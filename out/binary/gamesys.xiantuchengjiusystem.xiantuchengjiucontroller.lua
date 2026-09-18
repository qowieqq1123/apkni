






local _MODULENAME="xiantuchengjiuController"

gameState.addListener(def_table(_MODULENAME))
xiantuchengjiuController.name=_MODULENAME
xiantuchengjiuController.canTips=false
xiantuchengjiuController.readyTips=nil


local _loadWins={
"UILoading",
"UIFightPrepareLoading",

"UIDiscipleJingJieBrokeWin",
"UIZheXianLingJiYuanWin",
"UISubAct_xianguyijiWin",
"UISubAct_xianshichoukaWin",
"UISubAct_xianshichouka2Win",
}
local _tipsWin="UIXianTuChengJiuTipsWin"

function xiantuchengjiuController:onAppStart()

xiantuchengjiuModel:onAppStart()








socketManager:register_receiver(30,1,self.recv_30_1)
socketManager:register_receiver(30,2,self.recv_30_2)
socketManager:register_receiver(30,3,self.recv_30_3)
socketManager:register_receiver(30,5,self.recv_30_5)
socketManager:register_receiver(30,6,self.recv_30_6)
socketManager:register_receiver(30,7,self.recv_30_7)

notifySystem:listenNotify(notifyConfig.onBattleClose,self.onBattleClose)
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildingEvent)
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.inNewbie,self.onInNewbie)
notifySystem:listenNotify(notifyConfig.inStory,self.onInStory)
notifySystem:listenNotify(notifyConfig.closeUI,self.closeUI)
end


function xiantuchengjiuController:onEnterState(isReconnect)
xiantuchengjiuModel:onEnterState()
end


function xiantuchengjiuController:onProtocolReq()
xiantuchengjiuModel:onProtocolReq()
self:triggerClientCheckTaskTypeInit()
self:checkCorrectZMTXStageActive()
self:checkXTCJGubaoActive()
self.canTips=true
self.readyTips=nil
end


function xiantuchengjiuController:onLeaveState(isReconnect)
xiantuchengjiuModel:onLeaveState(isReconnect)
self.canTips=false


end


function xiantuchengjiuController:onLostConnection()

end


function xiantuchengjiuController:onReConnection(isInitPro)

end



function xiantuchengjiuController.send_30_1()
socketManager:send_30_1()
end


function xiantuchengjiuController.send_30_2(list)
if#list>0 then
socketManager:send_30_2(#list,list)
end
end


function xiantuchengjiuController.send_30_3(id)
socketManager:send_30_3(id)
end


function xiantuchengjiuController.send_30_4(id)
socketManager:send_30_4(id)
end


function xiantuchengjiuController.send_30_5()
socketManager:send_30_5()
end

function xiantuchengjiuController.send_30_7(id)
socketManager:send_30_7(id)
end


function xiantuchengjiuController.recv_30_1(args)
local type1Len=args[1]
local type1List=args[2]
local type2Len=args[3]
local type2List=args[4]
local type3Len=args[5]
local type3List=args[6]
local temp1=xiantuchengjiuModel:updateZMXTDataList(type1List)
local temp2=xiantuchengjiuModel:updateXTCJDataList(type2List)
local temp3=xiantuchengjiuModel:updateFSDTDataList(type3List)

if initProControl.isDone()then
notifySystem:postNotify(notifyConfig.onXianTuChengJiuSystemInit)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianTuChengJiuTaskProgress)
for i,v in ipairs(temp1)do
xiantuchengjiuController:addTaskTips(v[1],v[2],v[3],v[4])
end
for i,v in ipairs(temp2)do
xiantuchengjiuController:addTaskTips(v[1],v[2],v[3],v[4])
end
for i,v in ipairs(temp3)do
xiantuchengjiuController:addTaskTips(v[1],v[2],v[3],v[4])
end
end
end


function xiantuchengjiuController.recv_30_2(len,list)
if len>0 then
local temp=xiantuchengjiuModel:receiveTasksReward(list)
for i,v in ipairs(temp)do
xiantuchengjiuController:addTaskTips(v[1],v[2],v[3],v[4])
end
local notifys={}
local isPlayAudio=false
for i,v in ipairs(list)do
if v.keyInfo.xttype==eXianTuChengJiuTabType.ZongMenXianTu or v.keyInfo.xttype==eXianTuChengJiuTabType.XianTuChengJiu then
isPlayAudio=true
end
table.insert(notifys,{v.keyInfo.xttype,v.keyInfo.key1,v.keyInfo.key2,v.aimidx})
end
xiantuchengjiuController:triggerOpenCondition(eXianTuChengJiuConditionType.ChengJiuTaskAim)
notifySystem:postNotify(notifyConfig.onXianTuChengJiuTaskReward,notifys)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianTuChengJiuTaskProgress)

if isPlayAudio then

AudioManager.playAudio(503)
end
end
end


function xiantuchengjiuController.recv_30_3(id,times)
xiantuchengjiuModel:updateZMXTTimes(id,times)
xiantuchengjiuController:triggerOpenCondition(eXianTuChengJiuConditionType.ZongMenXianTu)
local rewards=cfgHelper.get2(cfg_sectxiantuconfig_get,id,"reward")
local itemsList={}
for i,v in ipairs(rewards)do
table.insert(itemsList,{itemid=v[1],num=v[2]})
end
UIFullXianTuChengJiuControl:addPopUpWin("UICommonShowPrizeWin",{list=itemsList})


notifySystem:postNotify(notifyConfig.onZongMenXianTuReward,id)
reddotControl.on_change_catch_type(CATCH_TYPE.eZongMenXianTuReward)
end


function xiantuchengjiuController.recv_30_4(achievetype,level)
xiantuchengjiuModel:updateXTCJLevel(achievetype,level)


end









function xiantuchengjiuController.recv_30_5(len,list)
if len>0 then
xiantuchengjiuModel:updateLookBacks(list)
UIManager:invokeUIMethod("UIXianTuLookBackWin","updateYuanZhuBtn")
end
JiuChongTianJieEnterModel:updateReviewBlocks()
JiuChongTianJieEnterController:showReviewWindow()
end


function xiantuchengjiuController.recv_30_6(keyInfo,progress)
local check,pass=xiantuchengjiuModel:updateTaskProgress(keyInfo.xttype,keyInfo.key1,keyInfo.key2,progress)
if check then
if xiantuchengjiuModel:checkTaskOpen(keyInfo.xttype,keyInfo.key1,keyInfo.key2)then
if pass then
xiantuchengjiuController:addTaskTips(keyInfo.xttype,keyInfo.key1,keyInfo.key2,pass)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianTuChengJiuTaskProgress)
notifySystem:postNotify(notifyConfig.onXianTuChengJiuTaskComplete,{{keyInfo.xttype,keyInfo.key1,keyInfo.key2}})
else
notifySystem:postNotify(notifyConfig.onXianTuChengJiuTaskProgress,{{keyInfo.xttype,keyInfo.key1,keyInfo.key2}})
end
end
end
end


function xiantuchengjiuController.recv_30_7(xtType1Info,xtType3Info)
local temp1=xiantuchengjiuModel:updateZMXTSingleData(xtType1Info)
local temp2=xiantuchengjiuModel:updateFSDTSingleData(xtType3Info)
xiantuchengjiuController:triggerClientCheckTaskTypeByData(eXianTuChengJiuTabType.ZongMenXianTu,xtType1Info.key1)
xiantuchengjiuController:triggerClientCheckTaskTypeByData(eXianTuChengJiuTabType.FeiShengDaoTu,xtType3Info.key1)
for i,v in ipairs(temp1)do
xiantuchengjiuController:addTaskTips(v[1],v[2],v[3],v[4])
end
for i,v in ipairs(temp2)do
xiantuchengjiuController:addTaskTips(v[1],v[2],v[3],v[4])
end
notifySystem:postNotify(notifyConfig.onZongMenXianTuStage,xtType1Info.key1)
reddotControl.on_change_catch_type(CATCH_TYPE.eZongMenXianTuStage)
end




function xiantuchengjiuController:triggerClientCheckTaskTypeEvent(eventType)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianTu)then return end
local tasktypes=taskModel:findTaskTypeByTaskEvent(eventType)
local complete={}
local progress={}
for index,tasktype in ipairs(tasktypes)do
local keys=xiantuchengjiuModel:findTaskKeyByType(tasktype)
if keys then
for taskparam,list in pairs(keys)do
for index,temp in ipairs(list)do
local eType=temp[1]
local eKey1=temp[2]
local eKey2=temp[3]
local check,pass=xiantuchengjiuModel:refreshTaskProgress(eType,eKey1,eKey2)
if check then
if#pass>0 then

xiantuchengjiuModel:doTempStorage(eType,eKey1,eKey2,pass[#pass])

if xiantuchengjiuModel:checkTaskOpen(eType,eKey1,eKey2)then
self:addTaskTips(eType,eKey1,eKey2,pass[1])
table.insert(complete,{eType,eKey1,eKey2})
end
else
if xiantuchengjiuModel:checkTaskOpen(eType,eKey1,eKey2)then
table.insert(progress,{eType,eKey1,eKey2})
end
end
end
end
end
end
end
if#progress>0 then
notifySystem:postNotify(notifyConfig.onXianTuChengJiuTaskProgress,progress)
end
if#complete>0 then
notifySystem:postNotify(notifyConfig.onXianTuChengJiuTaskComplete,complete)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianTuChengJiuTaskProgress)
end
end

function xiantuchengjiuController:triggerClientCheckTaskTypeInit()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianTu)then return end
local complete={}
local progress={}
for tasktype,list1 in pairs(xiantuchengjiuModel.task_lookup)do
for taskparam,list2 in pairs(list1)do
for index,temp in ipairs(list2)do
local eType=temp[1]
local eKey1=temp[2]
local eKey2=temp[3]
local check,pass=xiantuchengjiuModel:refreshTaskProgress(eType,eKey1,eKey2)
if check then
if#pass>0 then



if xiantuchengjiuModel:checkTaskOpen(eType,eKey1,eKey2)then
self:addTaskTips(eType,eKey1,eKey2,pass[1])
table.insert(complete,{eType,eKey1,eKey2})
end
else
if xiantuchengjiuModel:checkTaskOpen(eType,eKey1,eKey2)then
table.insert(progress,{eType,eKey1,eKey2})
end
end
end
end
end
end
if#progress>0 then
notifySystem:postNotify(notifyConfig.onXianTuChengJiuTaskProgress,progress)
end
if#complete>0 then
notifySystem:postNotify(notifyConfig.onXianTuChengJiuTaskComplete,complete)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianTuChengJiuTaskProgress)
end
end

function xiantuchengjiuController:triggerClientCheckTaskTypeByData(eType,eKey1)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianTu)then return end
local complete={}
local progress={}
local cfg=xiantuchengjiuModel:getTaskConfig(eType,eKey1)
for eKey2,cfg in pairs(cfg)do
local check,pass=xiantuchengjiuModel:refreshTaskProgress(eType,eKey1,eKey2)
if check then
if#pass>0 then

xiantuchengjiuModel:doTempStorage(eType,eKey1,eKey2,pass[#pass])

if xiantuchengjiuModel:checkTaskOpen(eType,eKey1,eKey2)then
self:addTaskTips(eType,eKey1,eKey2,pass[1])
table.insert(complete,{eType,eKey1,eKey2})
end
else
if xiantuchengjiuModel:checkTaskOpen(eType,eKey1,eKey2)then
table.insert(progress,{eType,eKey1,eKey2})
end
end
end
end
if#progress>0 then
notifySystem:postNotify(notifyConfig.onXianTuChengJiuTaskProgress,progress)
end
if#complete>0 then
notifySystem:postNotify(notifyConfig.onXianTuChengJiuTaskComplete,complete)
reddotControl.on_change_catch_type(CATCH_TYPE.eXianTuChengJiuTaskProgress)
end
end

function xiantuchengjiuController:addTaskTips(type,key1,key2,aimIdx)
if initProControl.isDone()and self.canTips then
local need=cfgHelper.get2(cfg_xiantuachievebaseconfig_get,1,"tipsShow")
local have=zongmenModel:getLevel()or 0
if have>=need and not xiantuchengjiuModel:isMarkRepeated(type,key1,key2,aimIdx)then
xiantuchengjiuModel:saveMarkRepeated(type,key1,key2,aimIdx)
xiantuchengjiuModel:pushTaskTips(type,key1,key2,aimIdx)
self:checkShowTaskTips()
end
end
end

function xiantuchengjiuController:checkCanShowTips(checkTipsWin)
if not self:checkReadyTips()then
return false
end
if fightModel:haveBattleShow()then
return false
end
if newbieControl.isInNewbie()then
return false
end
if storyAICommonManager:isPlayingStory()then
return false
end
if systemZongMenController:isOutgoerSceneDoing()then
return false
end
if not xiantuchengjiuModel:haveTaskTips()then
return false
end
for i,v in ipairs(_loadWins)do
if UIManager:isActive(v,true)then
return false
end
end

if checkTipsWin or checkTipsWin==nil then
if UIManager:isActive(_tipsWin,true)then
return false
end
end
return true
end

function xiantuchengjiuController:checkReadyTips()
return self.readyTips==nil or self.readyTips:isDead()
end

function xiantuchengjiuController:checkShowTaskTips()
local check=self:checkCanShowTips()

if check then
self.readyTips=timeEventController.delayDo(0.2,UIFullXianTuChengJiuControl.showTipsWin)
end
end

function xiantuchengjiuController:triggerOpenCondition(cType)
local opens=xiantuchengjiuModel:triggerTaskOpens(cType)
notifySystem:postNotify(notifyConfig.onXianTuChengJiuTaskOpen,opens)

local subs=xiantuchengjiuModel:triggerSubOpens(cType)
for i,v in ipairs(subs)do
local cfg=cfgHelper.get1(cfg_xiantuachieveconfig_get,v)
local gbData=gubaoModel:getDataByID(cfg.gubao)
if not gbData then
self.send_30_4(v)
end
end
notifySystem:postNotify(notifyConfig.onXianTuChengJiuSubOpen,subs)
end

function xiantuchengjiuController:checkCorrectZMTXStageActive()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianTu)then return end
local keys=xiantuchengjiuModel:getZMXTOpens()
for i,v in ipairs(keys)do
xiantuchengjiuController.send_30_7(v)
end


















end

function xiantuchengjiuController:checkXTCJGubaoActive()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianTu)then return end
local cfg=cfg_xiantuachieveconfig()
for i,v in ipairs(cfg)do
if xiantuchengjiuModel:checkConditions(v.unlock)and not gubaoModel:getDataByID(v.gubao)then
self.send_30_4(i)
end
end
end

function xiantuchengjiuController.onBattleClose()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianTu)then return end
xiantuchengjiuController:checkShowTaskTips()
end

function xiantuchengjiuController.onBuildingEvent(eventType,param1,param2,param3)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianTu)then return end
if eventType==buildingEvent.zongmenLevelUp and param3~=param1 then
xiantuchengjiuController:triggerOpenCondition(eXianTuChengJiuConditionType.ZongMenLevel)
end
end

function xiantuchengjiuController.onDiscipleJJChange(dzguid,oldlv,newlv)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianTu)then return end
local keys=xiantuchengjiuModel:getZMXTOpens()
for i,v in ipairs(keys)do
xiantuchengjiuController.send_30_7(v)
end


















end

function xiantuchengjiuController.on_system_open(sysId)
if sysId==SYSTEM_DEFINE.eXianTu then
xiantuchengjiuController:triggerClientCheckTaskTypeInit()
xiantuchengjiuController:checkCorrectZMTXStageActive()
xiantuchengjiuController:checkXTCJGubaoActive()
end
end

function xiantuchengjiuController.closeUI(name,isClose)
if table.containsValue(_loadWins,name)or name==_tipsWin then
xiantuchengjiuController:checkShowTaskTips()
end
end

function xiantuchengjiuController.onInNewbie(newbieId,isBegin)
if not isBegin then
xiantuchengjiuController:checkShowTaskTips()
end
end

function xiantuchengjiuController.onInStory(filename,isBegin)
if not isBegin then
xiantuchengjiuController:checkShowTaskTips()
end
end

