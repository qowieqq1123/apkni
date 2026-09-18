

UIXuanShangControl=gameState.addListener(fullScreenUI.create())

function UIXuanShangControl:onAppStart()
socketManager:register_receiver(7,50,self.recv_7_50)
socketManager:register_receiver(7,51,self.recv_7_51)
socketManager:register_receiver(7,52,self.recv_7_52)
socketManager:register_receiver(7,54,self.recv_7_54)

local menulist=
{
{tabType=FULL_TAB_TYPE.eXuanShangTai,callback=function(...)self:showXuanShangWindow(...)end,
sendCallback=function()end},
}

local args=
{
menulist=menulist,
fullType=FULL_TYPE.eXuanShangTai,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIXuanShangControl:onEnterState(isReconnect)
if isReconnect then
return
end
self.data={}
self.taskDiscipleDict={}
self.cdDatas={}
self.dialogShowFlags={}
end

function UIXuanShangControl:onLeaveState(isReconnect)
self.RefreshTag=nil
if isReconnect then
return
end
self.data=nil
self.taskDiscipleDict=nil
self.cdDatas=nil
self.dialogShowFlags=nil
end

function UIXuanShangControl:showXuanShangWindow(argstable)
local isXJsystem=XianjieXuanShangController:changeXJXSsystm()
if isXJsystem then
local args=
{
tabType=FULL_TAB_TYPE.eXuanShangTai,
showBg=true,
viewNames={'UIXianjieXuanShangWin'},
viewArgs={['UIXianjieXuanShangWin']=argstable},
}
self:showUI(args)
else
local args=
{
tabType=FULL_TAB_TYPE.eXuanShangTai,
showBg=true,
viewNames={'UIXuanShangWin'},
viewArgs={['UIXuanShangWin']=argstable},
}
self:showUI(args)
end
end

function UIXuanShangControl:getDialogShowFlag(stype)
return self.dialogShowFlags[stype]
end

function UIXuanShangControl:setDialogShowFlag(stype,flag)
self.dialogShowFlags[stype]=flag
end

function UIXuanShangControl:setDatas(datas)
self.data.level=datas[1]
self.data.freeRefresh=datas[2]
self.data.itemRefresh=datas[3]
local taskList={}
if datas[4]>0 then
for i,v in ipairs(datas[5])do
taskList[v.taskId]=v
self:recordDisciple(v.dzList,true)
end
end
self.data.taskList=taskList
self.data.freeDispatch=datas[6]
self.data.itemDispatch=datas[7]
local jinduList={}
if datas[8]>0 then
for i,v in ipairs(datas[9])do
jinduList[v.param_1]=v.param_2
end
end
self.data.jinduList=jinduList
end

function UIXuanShangControl:getJinduByColor(color)
return self.data.jinduList[color]or 0
end

function UIXuanShangControl:addCDData(data)
if data.endTime>0 then
local cdd={}
local curTime=gameUtilityModel.getServerShortTime()
local cfg=cfgHelper.get1(cfg_zongmenxuanshangtaskconfig_get,data.taskId)
local ntime=cfg.time*60
cdd.beginTime=data.endTime-ntime
cdd.ntime=ntime
cdd.dtime=curTime-cdd.beginTime
cdd.cd=cdd.ntime-cdd.dtime
cdd.complete=cdd.dtime>=cdd.ntime
self.cdDatas[data.taskId]=cdd
end
end

function UIXuanShangControl:removeCDData(taskId)
self.cdDatas[taskId]=nil
end

function UIXuanShangControl:getCDData(taskId)
return self.cdDatas[taskId]
end

function UIXuanShangControl:getCDDatas()
return self.cdDatas
end

function UIXuanShangControl:isDispatching(taskId)
local task=self.data.taskList[taskId]
return task.endTime>0
end

function UIXuanShangControl:recordDisciple(dzList,state)
if dzList then
for i,v in ipairs(dzList)do
self.taskDiscipleDict[tostring(v)]=state
end
end
end

function UIXuanShangControl:setDiscipleTaskState(dzId,state)
self.taskDiscipleDict[tostring(dzId)]=state
end

function UIXuanShangControl:isDiscipleInTask(dzId)
return self.taskDiscipleDict[tostring(dzId)]
end

function UIXuanShangControl:resetTaskData(data)
self.data.taskList[data.taskId]=data
end

function UIXuanShangControl:quickFinishTask(data)
self.data.taskList[data.taskId]=data
local cddata=self:getCDData(data.taskId)
if cddata then
cddata.complete=true
end
end

function UIXuanShangControl:dispatchTask(data)
self.data.taskList[data.taskId]=data
self:recordDisciple(data.dzList,true)
self:addCDData(data)
end

function UIXuanShangControl:receiveTask(data)
self.data.taskList[data.taskId]=nil
self:recordDisciple(data.dzList)
self:removeCDData(data.taskId)
end

function UIXuanShangControl:setLastTaskList(list,rtype,arr)
local datas
if list then
datas={}
if rtype==1 then
for k,v in pairs(list)do
datas[v.index]=v.endTime>0 and 0 or 1
end
else
for k,v in pairs(list)do
datas[v.index]=0
end
for i,v in ipairs(arr)do
if datas[v.index]then
datas[v.index]=1
end
end
end
end
self.data.lastTaskList=datas
end

function UIXuanShangControl:getLastTaskList()
return self.data.lastTaskList
end

function UIXuanShangControl:getTaskList()
return self.data.taskList
end

function UIXuanShangControl:getXuanShangLevel()
return self.data.level
end

function UIXuanShangControl:getFreeRefreshNum()
return self.data.freeRefresh
end

function UIXuanShangControl:getItemRefreshNum()
return self.data.itemRefresh
end

function UIXuanShangControl:getFreeDispatchNum()
return self.data.freeDispatch
end

function UIXuanShangControl:getItemDispatchNum()
return self.data.itemDispatch
end

function UIXuanShangControl:setDispatchNum(freeNum,itemNum)
self.data.freeDispatch=freeNum
self.data.itemDispatch=itemNum
end

function UIXuanShangControl:hasTaskFinish()
local isXJsystem=XianjieXuanShangController:changeXJXSsystm()
if isXJsystem then
return XianjieXuanShangModel:hasTaskFinish()
else
local curTime=gameUtilityModel.getServerShortTime()
local list=self.data.taskList
for k,v in pairs(list)do
if v.endTime>0 and curTime>=v.endTime then
return true
end
end
return false
end
end

function UIXuanShangControl:checkXuanShangReddot()
return UIXuanShangControl:getFreeDispatchNum()>0 or UIXuanShangControl:getItemDispatchNum()>0 or UIXuanShangControl:hasTaskFinish()
end

function UIXuanShangControl:checkFreeOrTaskReddot()
local isXJsystem=XianjieXuanShangController:changeXJXSsystm()
if isXJsystem then
return XianjieXuanShangController:checkFreeOrTaskReddot()
else
return UIXuanShangControl:getFreeDispatchNum()>0 or UIXuanShangControl:hasTaskFinish()
end
end

function UIXuanShangControl:refreshXuanShangHUD()
if not isometricMapSystem:IsInHome()then
return
end
local bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eXuanShangTai)
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end



function UIXuanShangControl:reqData()
socketManager:send_7_50()
end

function UIXuanShangControl:reqQuickFinish(id)
socketManager:send_7_51(id)
end

function UIXuanShangControl:reqReward(id,assistant)
socketManager:send_7_52(id,assistant or 0)
end

function UIXuanShangControl:reqRefresh()
socketManager:send_7_53()
self.RefreshTag=true
end

function UIXuanShangControl:reqPaiQian(id,len,dzlist)
socketManager:send_7_54(id,len,dzlist)
end



function UIXuanShangControl.recv_7_50(datas)
local lastTasks=UIXuanShangControl:getLastTaskList()
local lastLevel=UIXuanShangControl:getXuanShangLevel()
UIXuanShangControl:setDatas(datas)
UIXuanShangControl:setLastTaskList(UIXuanShangControl:getTaskList(),1)
UIManager:invokeUIMethod('UIXuanShangWin','refresh',lastTasks)
UIXuanShangControl:refreshXuanShangHUD()
if UIXuanShangControl.RefreshTag then
UIManager.info('悬赏任务已刷新')
end
UIXuanShangControl.RefreshTag=false
local currLevel=UIXuanShangControl:getXuanShangLevel()
if lastLevel and currLevel>lastLevel then
UIManager:showWindow('UIXSLevelUpWin',{lastLevel=lastLevel,currLevel=currLevel})
notifySystem:postNotify(notifyConfig.onXuanShangTaiLevelChange)
end
end

function UIXuanShangControl.recv_7_51(data)

data.endTime=gameUtilityModel.getServerShortTime()
UIXuanShangControl:quickFinishTask(data)
UIManager:invokeUIMethod('UIXuanShangWin','refresh')
UIManager.info('任务已完成')
UIXuanShangControl:refreshXuanShangHUD()
end

function UIXuanShangControl.recv_7_52(len,arr)

UIXuanShangControl:setLastTaskList(UIXuanShangControl:getTaskList(),2,arr)
if len>0 then
for i,v in ipairs(arr)do
UIXuanShangControl:receiveTask(v)
end
end

UIXuanShangControl:refreshXuanShangHUD()

AudioManager.playAudio(503)
end

function UIXuanShangControl.recv_7_54(data,freeNum,itemNum)
UIXuanShangControl:dispatchTask(data)
UIXuanShangControl:setDispatchNum(freeNum,itemNum)
UIXuanShangControl:setLastTaskList(UIXuanShangControl:getTaskList(),1)
UIManager:invokeUIMethod('UIXuanShangWin','refresh')
UIXuanShangControl:refreshXuanShangHUD()
end



function UIXuanShangControl:getConditionText(cnd)
local ctype=cnd[1]
if ctype==1 then
local color=UIDiscipleModel.getDiscipleJJColor(cnd[3])
return FMT.fmt('需要{0}名<color={2}>{1}</color>境界及以上的弟子',cnd[2],UIDiscipleModel:getJJNameX(cnd[3]),color)
elseif ctype==2 then
local color=FONT_COLOR_VAL[cnd[3]]
return FMT.fmt('需要{0}名<color={2}>{1}</color>品质及以上的弟子',cnd[2],UIDiscipleModel.getDiscipleColorDesc(cnd[3]),color)
elseif ctype==3 then
return FMT.fmt('需要{0}名职业为<color=#6833c0>{1}</color>的弟子',cnd[2],UIDiscipleModel:getJobName(cnd[3]))
end
return'???'
end

function UIXuanShangControl:checkPQCondition(seldata,cnd,wraning)
local stype=cnd[1]
if stype==1 then
local count=0
for kk,vv in pairs(seldata)do
local dzData=UIDiscipleModel:getDiscipleData(vv)
if dzData and dzData.jingjielv>=cnd[3]then
count=count+1
end
end
if count<cnd[2]then
if wraning then
UIManager.error(FMT.fmt('需{0}名{1}境界弟子',cnd[2],UIDiscipleModel:getJJNameX(cnd[3])))
end
return false
end
elseif stype==2 then
local count=0
for kk,vv in pairs(seldata)do
if(UIDiscipleModel:getDiscipleColor(vv)or 0)>=cnd[3]then
count=count+1
end
end
if count<cnd[2]then
if wraning then
UIManager.error(FMT.fmt('需{0}名{1}品质弟子',cnd[2],UIDiscipleModel.getDiscipleColorDesc(cnd[3])))
end
return false
end
elseif stype==3 then
local count=0
for kk,vv in pairs(seldata)do
if(UIDiscipleModel:getDiscipleJob(vv)or 0)==cnd[3]then
count=count+1
end
end
if count<cnd[2]then
if wraning then
UIManager.error(FMT.fmt('需{0}名职业为{1}的弟子',cnd[2],UIDiscipleModel:getJobName(cnd[3])))
end
return false
end
end
return true
end