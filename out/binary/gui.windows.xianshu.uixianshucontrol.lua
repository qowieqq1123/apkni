


UIXianShuControl=gameState.addListener({})

function UIXianShuControl:onAppStart()
socketManager:register_receiver(29,1,self.recv_29_1)
socketManager:register_receiver(29,2,self.recv_29_2)
socketManager:register_receiver(29,3,self.recv_29_3)
socketManager:register_receiver(29,4,self.recv_29_4)
socketManager:register_receiver(29,5,self.recv_29_5)
socketManager:register_receiver(29,6,self.recv_29_6)
socketManager:register_receiver(29,7,self.recv_29_7)

socketManager:register_receiver(29,8,self.recv_29_8)
















end

function UIXianShuControl:onEnterState(isReconnect)
if isReconnect then
return
end

self.data={}
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)

self:onEnterState_TQ(isReconnect)

self:readLocalRewardChangeList()

end

function UIXianShuControl:onLeaveState(isReconnect)
if isReconnect then
return
end

self.enterGuid=nil
self.data=nil
notifySystem:removelistener(notifyConfig.on_system_open,self.onSystemOpen)

self:onLeaveState_TQ(isReconnect)
end

function UIXianShuControl:onReConnection(isReconnect)
if not isReconnect then
return
end
UIXianShuControl:checkAndShowEnterIcon()
end

function UIXianShuControl.onSystemOpen(sysId)
if sysId==SYSTEM_DEFINE.eXianShu then
UIXianShuControl:checkAndShowEnterIcon()
end
end































function UIXianShuControl:showXianShuWin()
local extraParams={tab=1}
return UIFullTotalTouZiActivityontrol:showMenuWindow({menuType=TZ_MENU_TYPE.eXianShu,extraParams=extraParams})
end

function UIXianShuControl:showXianShuTaskWin(argstable)

local extraParams={tab=2}
return UIFullTotalTouZiActivityontrol:showMenuWindow({menuType=TZ_MENU_TYPE.eXianShu,extraParams=extraParams})

end


function UIXianShuControl:closeAllXianShuWindow()
if fullScreenUI.checkFull(UIXianShuControl)then
UIXianShuControl:closeUI(UIXianShuControl.activeUI)
end

UIManager:closeWindow('UIXianShuActiveWin')

UIManager:closeWindow('UIXianShuBuyLevelWin')
end

function UIXianShuControl:isActivityOpen()
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
return false
end
if not systemModel.isOpen(SYSTEM_DEFINE.eXianShu)then
return false
end
local xsId=self:getCurrentId()
if not xsId then
return false
end
local time=self:getRemainingTime()
return time>0
end

function UIXianShuControl:getRemainingTime()
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,self:getCurrentId())
if not cfg then
return 0
end








local startTime=self:getStartTime()
local onydaysec=86400
local endTime=startTime+cfg.duration*onydaysec
local serverTime=gameUtilityModel.getServerShortTime()

return endTime-serverTime
end

function UIXianShuControl:checkAndShowEnterIcon()
if self:isActivityOpen()then



UIFullTotalTouZiActivityontrol:onChanged(TZ_CATCH_TYPE.eXianShu)
end
end

function UIXianShuControl:removeEnterIcon()
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end


function UIXianShuControl:checkReconfirmBuyTime()
local cfg=cfgHelper.get1(cfg_fairybookconfig_get,self:getCurrentId())
if not cfg then
return false
end

local showReconfirmDay=cfg.reconfirmDay
if not showReconfirmDay then

return false
end

local remainingTime=self:getRemainingTime()
local onydaysec=86400
local remainingDay=math.floor(remainingTime/onydaysec)+1
if remainingDay>showReconfirmDay then

return false
end
local contentStr=FMT.fmt("当前仙书剩余时间已不足<color=#549327>{0}天</color>，是否确认开通仙门谱牒？",remainingDay)
return true,contentStr
end



function UIXianShuControl:refreshReddot()

reddotControl.on_change_catch_type(CATCH_TYPE.eXianShu)

notifySystem:postNotify(notifyConfig.onXianShuChange)
end

function UIXianShuControl:checkReddot()
return self:checkRewardReddot()or self:checkTaskReddot()
end

function UIXianShuControl:checkRewardReddot()
local level=self:getLevel()
local norLevel=self:getReceiveLevel(1)
if norLevel<level then
return true
end

local speLevel=self:getReceiveLevel(2)
local rId=self:getRechargeId()
if rId>0 and speLevel<level then
return true
end

local needExp=cfgHelper.get2(cfg_fairybookbaseconfig_get,1,'lv_exp')
local maxLevel=self:getMaxLevel()
local exp=self:getExp()
if level>=maxLevel and exp>=needExp then
return true
end

return false
end

function UIXianShuControl:checkTaskReddot()
local datas=self:getTaskDatas()
for k,v in pairs(datas)do
for kk,vv in pairs(v)do
if vv.taskstate==2 then
return true
end
end
end

return false
end

function UIXianShuControl:checkTaskReddotByType(ttype)
local datas=self:getTaskDatas()
for k,v in pairs(datas)do
if k==ttype then
for kk,vv in pairs(v)do
if vv.taskstate==2 then
return true
end
end
end
end

return false
end



function UIXianShuControl:setDatas(datas)
self.data.xsId=datas[1]
self.data.xsLevel=datas[2]
self.data.rechargeId=datas[3]
local taskDatas={}
if datas[4]>0 then
local taskList={}
for ii,vv in ipairs(datas[5])do
taskList[vv.taskid]=vv
end
taskDatas[1]=taskList
end
if datas[6]>0 then
local taskList={}
for ii,vv in ipairs(datas[7])do
taskList[vv.taskid]=vv
end
taskDatas[2]=taskList
end
if datas[8]>0 then
local taskList={}
for ii,vv in ipairs(datas[9])do
taskList[vv.taskid]=vv
end
taskDatas[3]=taskList
end
self.data.taskDatas=taskDatas
local receiveData={}
if datas[10]>0 then
for i,v in ipairs(datas[11])do
receiveData[v.param_1]=v.param_2
end
end
self.data.receiveData=receiveData

self.data.startTime=datas[12]

self:onInitTQEffectData()
end

function UIXianShuControl:getReceiveLevel(rtype)
return self.data.receiveData[rtype]
end

function UIXianShuControl:setReceiveLevel(rtype,val)
self.data.receiveData[rtype]=val
end

function UIXianShuControl:getTaskDatas()
return self.data.taskDatas
end

function UIXianShuControl:setTaskData(task)
local taskDatas=self.data.taskDatas
if taskDatas then
local ttype=cfgHelper.get2(cfg_fairybooktaskconfig_get,task.taskid,'tasklineid')
taskDatas[ttype][task.taskid]=task

self:onUpdateTQEffectData(ttype,task)
end
end

function UIXianShuControl:getTaskData(taskId)
local taskDatas=self.data.taskDatas
local ttype=cfgHelper.get2(cfg_fairybooktaskconfig_get,taskId,'tasklineid')
return taskDatas[ttype][taskId]
end

function UIXianShuControl:setTaskState(taskId,state)
local task=self:getTaskData(taskId)
task.taskstate=state
end

function UIXianShuControl:resetTaskList(data)
local taskDatas=self.data.taskDatas
if not taskDatas then
return
end
local taskList={}
if data.taskInfo then
for ii,vv in ipairs(data.taskInfo)do
taskList[vv.taskid]=vv
end
end
taskDatas[data.type]=taskList

self:onInitTQEffectData()
end

function UIXianShuControl:getCurrentId()
return self.data.xsId
end

function UIXianShuControl:getLevel()
return self.data.xsLevel
end

function UIXianShuControl:setLevel(level)
self.data.xsLevel=level
end

function UIXianShuControl:getMaxLevel()
local maxLevel=cfgHelper.get2(cfg_fairybookconfig_get,self:getCurrentId(),'max_lv')
return maxLevel
end

function UIXianShuControl:getExp()

local exp=moneyModel.getMoney(eMoneyType.mtXianShuJingYan)
return exp
end

function UIXianShuControl:setExp(exp)

end

function UIXianShuControl:getRechargeId()
return self.data.rechargeId
end

function UIXianShuControl:setRechargeId(rId)
self.data.rechargeId=rId
end

function UIXianShuControl:getStartTime()
return self.data.startTime
end


function UIXianShuControl:reqInitInfo()
socketManager:send_29_1()
end

function UIXianShuControl:reqReward(type)
socketManager:send_29_2(type)
end

function UIXianShuControl:reqBuyLevel(level)
socketManager:send_29_5(level)
end

function UIXianShuControl:reqTaskReward(taskId)
socketManager:send_29_6()
end



function UIXianShuControl.recv_29_1(datas)
UIXianShuControl:setDatas(datas)

UIXianShuControl:checkAndShowEnterIcon()

UIManager:invokeUIMethod('UIXianShuWin','refresh')
UIManager:invokeUIMethod('UIXianShuTaskWin','refresh')
UIManager:callWindowFunc('UITouZiXianShuWin','refresh')
end

function UIXianShuControl.recv_29_2(type,len,arr)
if type==1 then
if len>0 then
for i,v in ipairs(arr)do
UIXianShuControl:setReceiveLevel(v.param_1,v.param_2)
end
end
elseif type==2 then
local needExp=cfgHelper.get2(cfg_fairybookbaseconfig_get,1,'lv_exp')
local exp=UIXianShuControl:getExp()
local last=exp%needExp
UIXianShuControl:setExp(last)
end
UIManager:invokeUIMethod('UIXianShuWin','refresh')
UIManager:callWindowFunc('UITouZiXianShuWin','refresh')

UIXianShuControl:refreshReddot()
end

function UIXianShuControl.recv_29_3(level,exp)
local lastLevel=UIXianShuControl:getLevel()
UIXianShuControl:setLevel(level)

UIManager:invokeUIMethod('UIXianShuWin','refresh')
if level>lastLevel then
UIManager:showWindow('UIXianShuLevelUpWin',{lastLevel=lastLevel,currLevel=level})
end
UIManager:callWindowFunc('UITouZiXianShuWin','refresh')
UIXianShuControl:refreshReddot()
end

function UIXianShuControl.recv_29_4(data)
UIXianShuControl:resetTaskList(data)
UIManager:invokeUIMethod('UIXianShuTaskWin','refresh')


reddotControl.on_change_catch_type(CATCH_TYPE.eXianShu)
end

function UIXianShuControl.recv_29_5(level)
local lastLevel=UIXianShuControl:getLevel()
UIXianShuControl:setLevel(level)
UIManager:invokeUIMethod('UIXianShuWin','refresh')
UIManager:callWindowFunc('UITouZiXianShuWin','refresh')
if level>lastLevel then
UIManager:showWindow('UIXianShuLevelUpWin',{lastLevel=lastLevel,currLevel=level})
end

UIXianShuControl:refreshReddot()
end

function UIXianShuControl.recv_29_6(dlen,darr,wlen,warr)

if dlen>0 then
for i,v in ipairs(darr)do
UIXianShuControl:setTaskState(v,3)
end
end
if wlen>0 then
for i,v in ipairs(warr)do
UIXianShuControl:setTaskState(v,3)
end
end













UIManager:invokeUIMethod('UIXianShuTaskWin','refresh')
UIManager:callWindowFunc('UITouZiXianShuWin','refresh')

UIXianShuControl:refreshReddot()
end

function UIXianShuControl.recv_29_7(taskInfo)
UIXianShuControl:setTaskData(taskInfo)
UIManager:invokeUIMethod('UIXianShuTaskWin','refresh')

UIXianShuControl:refreshReddot()
end

function UIXianShuControl.recv_29_8(rId)
UIXianShuControl:setRechargeId(rId)
UIManager:invokeUIMethod('UIXianShuWin','refresh')
UIManager:callWindowFunc('UITouZiXianShuWin','refresh')

UIXianShuControl:refreshReddot()
end



function UIXianShuControl:getRewardDataInRange(startLevel,endLevel,isLuxury)
local currId=self:getCurrentId()
local rId=UIXianShuControl:getRechargeId()
local isPaid=rId>0

local datas=cfgHelper.get1(cfg_fairybooklevelconfig_get,currId)

startLevel=startLevel or 1
endLevel=endLevel or#datas
local list={}
for i=startLevel,endLevel do
local v=datas[i]
if not isLuxury then
for ii,vv in ipairs(v.general_rewards)do
local val=list[vv[1]]or 0
val=val+vv[2]
list[vv[1]]=val
end
end
if isPaid or isLuxury then
for ii,vv in ipairs(v.luxury_rewards)do
local val=list[vv[1]]or 0
val=val+vv[2]
list[vv[1]]=val
end
end
end
local rlist={}
for k,v in pairs(list)do
local cfg=itemsConfig.getConfig(k)
table.insert(rlist,{k,v,color=cfg.color})
end
table.sort(rlist,function(a,b)
return a.color>b.color
end)

return rlist
end

function UIXianShuControl:checkTaskOpenCondition(taskid)
local isOpen=false
local task_condition=cfgHelper.get2(cfg_fairybooktaskconfig_get,taskid,'condition')
if task_condition and task_condition[1]and task_condition[2]then
local _type=task_condition[1]
local _id=task_condition[2]
if _type==1 then
if systemModel.isOpen(_id)then
isOpen=true
end
elseif _type==2 then
if zongmenModel:haveBuildByBuildIdEx(_id)then
isOpen=true
end
end
else
isOpen=true
end
return isOpen
end