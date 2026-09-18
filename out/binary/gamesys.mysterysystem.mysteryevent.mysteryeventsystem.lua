






local _MODULENAME="MysteryEventSystem"


gameState.addListener(def_table(_MODULENAME))
MysteryEventSystem.name=_MODULENAME




MysteryEventSystem.ResultPanel=
{
Attr="UIMER_Attr_Panel",
Item="UIMER_Item_Panel",
Shane="UIMER_Shane_Panel",
Rule="UIMER_Rule_Panel",
}


MysteryEventSystem.diceCfg=
{
[1]={point="result1point",result="result1txt",explain="explain1txt",args="result1"},
[2]={point="result2point",result="result2txt",explain="explain2txt",args="result2"},
[3]={point="result3point",result="result3txt",explain="explain3txt",args="result3"},
[4]={point="result4point",result="result4txt",explain="explain4txt",args="result4"},
[5]={point="result5point",result="result5txt",explain="explain5txt",args="result5"},
[6]={point="result6point",result="result6txt",explain="explain6txt",args="result6"},

getPoint=function(resultIndex)
return FMT.fmt("result{0}point",resultIndex)
end,
getResultTxt=function(resultIndex)
return FMT.fmt("result{0}txt",resultIndex)
end,
getExplain=function(resultIndex)
return FMT.fmt("explain{0}txt",resultIndex)
end,
getArgs=function(resultIndex)
return FMT.fmt("result{0}",resultIndex)
end,
}


MysteryEventSystem.injuryType=
{
"轻伤",
"重伤",
"濒死",
"死亡",
}

MysteryEventSystem.flowRoot=
{
center=1,
rightDown=2,
}

MysteryEventSystem.flowType=
{
strTips=1,
itemTips=2,
}


local BlockSystemInRecvEvent=
{
[SYSTEM_DEFINE.eCloudCityTreasure]=1,
[SYSTEM_DEFINE.eWanBaoXunBaoDuiOpen]=1,
[SYSTEM_DEFINE.eJiuChongTianJie1]=1,
[SYSTEM_DEFINE.eXianJieShiLiQiYuEvent]=1,
}


MysteryEventSystem.data={}


function MysteryEventSystem:onAppStart()
MysteryEventModel:on_app_start()
MysteryEventCnd:bind_data()
MysteryEventResult:bind_data()

socketManager:register_receiver(18,1,MysteryEventSystem.recv_18_1)

socketManager:register_receiver(18,3,MysteryEventSystem.recv_18_3)

socketManager:register_receiver(18,4,MysteryEventSystem.recv_18_4)
socketManager:register_receiver(18,5,MysteryEventSystem.recv_18_5)
socketManager:register_receiver(18,6,MysteryEventSystem.recv_18_6)
socketManager:register_receiver(18,7,MysteryEventSystem.recv_18_7)
socketManager:register_receiver(18,8,MysteryEventSystem.recv_18_8)
socketManager:register_receiver(18,9,MysteryEventSystem.recv_18_9)
socketManager:register_receiver(18,12,MysteryEventSystem.recv_18_12)

end



function MysteryEventSystem:onEnterState()
MysteryEventModel:on_enter_state()
MysteryEventListModel:on_enter_state()
self.data.eventStrList={}


notifySystem:listenNotify(notifyConfig.on_mystery_event_result_finish_c,self.onMysteryEventResultFinish)
notifySystem:listenNotify(notifyConfig.on_mystery_event_finish,self.onMysteryEventFightFinish)

end


function MysteryEventSystem:onLeaveState()

MysteryEventModel:on_leave_state()
MysteryEventListModel:on_leave_state()
self.data={}
MysteryEventModel.resultCallback=nil


notifySystem:removelistener(notifyConfig.on_mystery_event_result_finish_c,self.onMysteryEventResultFinish)
notifySystem:removelistener(notifyConfig.on_mystery_event_finish,self.onMysteryEventFightFinish)
end


function MysteryEventSystem:onPlayerCreate(player,...)


end





function MysteryEventSystem.event_start(sysId,eventGroupId,teamList,signData,isNotFullOpen,resumeCB)


if not signData then
MysteryEventSystem:show_event_win(-1,sysId,eventGroupId,teamList,nil,isNotFullOpen)
return
end

local eventData=MysteryEventListModel:get_event_by_signData(sysId,signData)

if eventData then
MysteryEventSystem:show_event_win(eventData.guid,sysId,eventData.eventGroupId,teamList,{eventData.choiceId,eventData.resultConf,eventData.resultIndex},isNotFullOpen,nil,resumeCB)
else
MysteryEventModel.teamList=teamList
MysteryEventSystem.resumeCB=resumeCB
MysteryEventSystem.isNotFullOpen=isNotFullOpen
socketManager:send_18_4(sysId,eventGroupId,signData or{})
end
end







function MysteryEventSystem:show_event_win(evtGuid,sysId,eventgroupid,guidList,resultArgs,isNotFullOpen,interOpen,resumeCB)

if resultArgs then
local optionCfg=MysteryEventModel.get_option_cfg(eventgroupid,resultArgs[1])
if optionCfg then
local resultCfg=optionCfg[FMT.fmt("result{0}",resultArgs[2])]
if resultCfg then
if type(resultCfg[1])=='number'then
resultCfg={resultCfg}
end
if resultArgs[3]>=#resultCfg then
notifySystem:postNotify(notifyConfig.on_mystery_event_finish,sysId,evtGuid,eventgroupid)
return
end
end
end
end

if not interOpen then
self.resumeCB=resumeCB
self.isNotFullOpen=isNotFullOpen
end

local winParam={sysId=sysId,groupId=eventgroupid,guid=evtGuid,guidList=guidList,resultArgs=resultArgs}
MysteryEventModel:set_team_data(guidList)
if UIManager:isActive("UIMysteryEventWin")then
UIManager:invokeUIMethod("UIMysteryEventWin","onShow",winParam)
else
UIFullMysteryEventControl:showEventWindow(winParam,self.isNotFullOpen)
end

if resultArgs and resultArgs[1]~=0 then
MysteryEventSystem:event_result(evtGuid,sysId,eventgroupid,resultArgs[1],resultArgs[2],resultArgs[3])
else
notifySystem:postNotify(notifyConfig.on_mystery_event_enter,sysId,eventgroupid)
end
end


function MysteryEventSystem:flow_text(flowType,rootType,offset,...)
UIManager:invokeUIMethod("UIMysteryEventInfoWin","flowText",flowType,rootType,offset,...)
end



function MysteryEventSystem:event_result(evtGuid,sysId,groupId,optionId,resultIndex,nFinishResult)
local optionCfg=MysteryEventModel.get_option_cfg(groupId,optionId)
if not optionCfg then
error("无选项配置")
return
end
if resultIndex==0 then
error("事件结果错误")
return
end


MysteryEventModel:set_result_select(sysId,evtGuid,groupId,optionId,resultIndex)

local isdice=optionCfg.conditiontype and optionCfg.conditiontype==1
if isdice then

if UIManager:isActive("UIMysteryEventDice2Win")then
UIManager:invokeUIMethod("UIMysteryEventDice2Win","refreshDiceCount")
else
MysteryEventSystem.send_18_9(evtGuid,sysId)
UIFullMysteryEventControl:showWindow("UIMysteryEventDice2Win",
{evtGuid=evtGuid,
sysId=sysId,
groupId=groupId,
optionId=optionId,
resultIndex=resultIndex,
guid=MysteryEventModel:get_select_disciple(),
})
end
end

local resultCfg=optionCfg[FMT.fmt("result{0}",resultIndex)]
if resultCfg then

local resultArgs=
{
sysId=sysId,
groupId=groupId,
optionId=optionId,
guid=evtGuid,
resultIndex=resultIndex,
isdice=isdice,
resultCfgList=resultCfg,
nFinishResult=nFinishResult,
confirmCallBack=function()
MysteryEventSystem.do_result_before_callback(evtGuid)
end,
guidList=MysteryEventModel:get_team_data(),
}
MysteryEventResult.result_win(resultArgs)
end


end

function MysteryEventSystem:showEventByGuid(sysId,guid,teamList,isNotFullOpen,resumeCB)
local eventData=MysteryEventListModel:get_event_by_guid(sysId,guid)
MysteryEventSystem:show_event_win(eventData.guid,sysId,eventData.eventGroupId,teamList or{},{eventData.choiceId,eventData.resultConf,eventData.resultIndex},isNotFullOpen,nil,resumeCB)
end



function MysteryEventSystem:fight_result(fightResult,sysId,resultCfg)
local winResultGroup=resultCfg[3]
local loseResultGroup=resultCfg[4]
local team_data=MysteryEventModel:get_team_data()
local isLast=false
local result_group=MysteryEventModel:get_result_select()
if result_group then
if fightResult==1 then
if winResultGroup and type(winResultGroup)=="number"then
MysteryEventListModel:update_event(sysId,result_group[2],winResultGroup)

if self.resumeCB and self.isNotFullOpen then
self.resumeCB()
end
MysteryEventSystem:show_event_win(result_group[2],sysId,winResultGroup,team_data,nil,nil,true)
else
isLast=true
end
elseif fightResult==2 or fightResult==3 then
if loseResultGroup and type(loseResultGroup)=="number"then
MysteryEventListModel:update_event(sysId,result_group[2],loseResultGroup)
if self.resumeCB and self.isNotFullOpen then
self.resumeCB()
end
MysteryEventSystem:show_event_win(result_group[2],sysId,loseResultGroup,team_data,nil,nil,true)
else
isLast=true
end
end
if isLast then
if self.resumeCB and self.isNotFullOpen then
self.resumeCB()
end

MysteryEventModel:set_result_select()
notifySystem:postNotify(notifyConfig.on_mystery_event_finish,unpack(result_group))
end
end
end

function MysteryEventSystem:haveFightResult(fightResult,groupId,optionId,resultIndex)
local optionCfg=MysteryEventModel.get_option_cfg(groupId,optionId)
if not optionCfg then
error("无选项配置")
return
end
local resultCfg=optionCfg[FMT.fmt("result{0}",resultIndex)]
local winResultCfg=resultCfg[3]
local loseResultCfg=resultCfg[4]
if fightResult==1 then
return winResultCfg~=nil and next(winResultCfg)~=nil
elseif fightResult==2 or fightResult==3 then
return loseResultCfg~=nil and next(loseResultCfg)~=nil
end
end




function MysteryEventSystem.send_4_10(eventGroupId,choiceId,guid)
socketManager:send_4_10(eventGroupId,choiceId,guid)
end


function MysteryEventSystem.send_4_15(x,y,hdwGuid)
local fbid=MysteryModel:get_cur_fbid()

socketManager:send_4_15(fbid,x,y,hdwGuid)
end



function MysteryEventSystem.send_18_1(sysId,eventGroupId,choiceId,guid,guidList,eType,sendParam)
if guid then
guidList={guid}or{}
end
eventGroupId=tostring(eventGroupId)
eType=eType or 0
if not sendParam then
eType=0
end
local data={eType,unpack(sendParam or{0})}
socketManager:send_18_1(sysId,eventGroupId,choiceId,#guidList,guidList,data)
end

function MysteryEventSystem.send_18_2(sysId,teamListLen,teamList,gwzListLen,gwzList)
socketManager:send_18_2(sysId,teamListLen,teamList,gwzListLen,gwzList)
end

function MysteryEventSystem.send_18_3(sysId,eventGroupId,choiceId,nIndex,choiceListLen,choiceList)
choiceListLen=choiceListLen or 0
choiceList=choiceList or{}
eventGroupId=tostring(eventGroupId)
socketManager:send_18_3(sysId,eventGroupId,choiceId,nIndex,choiceListLen,choiceList)
end

function MysteryEventSystem.send_18_5(sysId)
socketManager:send_18_5(sysId)
end


function MysteryEventSystem.event_end(guid)
local eventData,sysId=MysteryEventListModel:get_event(guid)
if eventData then
socketManager:send_18_6(guid,sysId)
end
end


function MysteryEventSystem.send_18_7(guid,choiceId,diziList,sysId)
if type(diziList)=="number"then
diziList={int64.new(diziList)}
elseif type(diziList)=="userdata"then
diziList={diziList}
else
local list={}
for i,v in ipairs(diziList)do
if type(v)~='userdata'then
table.insert(list,int64.new(v))
else
table.insert(list,v)
end
end
diziList=list
end

socketManager:send_18_7(guid,choiceId,#diziList,diziList,sysId)
end


function MysteryEventSystem.send_18_8(guid,resultIndex,sysId,nextEventGroupId,otherData)
otherData=otherData or{0,0}
nextEventGroupId=nextEventGroupId or 0
socketManager:send_18_8(guid,resultIndex,nextEventGroupId,otherData,sysId)
end

function MysteryEventSystem.send_18_9(guid,sysId)
socketManager:send_18_9(guid,sysId)
end


function MysteryEventSystem.recv_18_1(len,array)
if len<=0 then return end
for i=1,len do
local info=array[i]
MysteryEventListModel:init_event_list(info.sysId,info.qiyuList)
end

notifySystem:postNotify(notifyConfig.on_mystery_event_init)
end













function MysteryEventSystem.recv_18_3(qiyuSysList)
if qiyuSysList.qiyuListLen>0 then
for i,v in ipairs(qiyuSysList.qiyuList)do
MysteryEventListModel:add_event(qiyuSysList.sysId,v)
end
end

notifySystem:postNotify(notifyConfig.on_mystery_event_new,qiyuSysList.sysId,qiyuSysList.qiyuList)
end


function MysteryEventSystem.recv_18_4(sysId,eventData)
MysteryEventListModel:add_event(sysId,eventData)

local teamList=MysteryEventModel.teamList or{}








if sysId and not BlockSystemInRecvEvent[sysId]then
MysteryEventSystem:show_event_win(eventData.guid,sysId,eventData.eventGroupId,teamList,{eventData.choiceId,eventData.resultConf,eventData.resultIndex},MysteryEventSystem.isNotFullOpen,nil,MysteryEventSystem.resumeCB)
end

notifySystem:postNotify(notifyConfig.on_mystery_event_new,sysId,{eventData})
end


function MysteryEventSystem.recv_18_5(sysId,qiyuListLen,qiyuList)
MysteryEventListModel:init_event_list(sysId,qiyuList)
end



function MysteryEventSystem.recv_18_6(guid,endData,sysId)
MysteryEventListModel:remove_event(guid)
notifySystem:postNotify(notifyConfig.on_mystery_event_finish_s,guid,endData,sysId)


if sysId==SYSTEM_DEFINE.eTuFaEvent then
local npcId=emergenciesModel:getClickNpcId()
if npcId then
emergenciesControl:removeLaiKeByIndex(npcId)
emergenciesControl:getEventCount_YiShiLaiKe()

UIManager:invokeUIMethod('UIMain','setEventName')
emergenciesModel:clearAdventureDataByGuild(guid)
end
end
end

function MysteryEventSystem.req_18_12(sysId,len,guidList)
socketManager:send_18_12(sysId,len,guidList)
end

function MysteryEventSystem.recv_18_12(sysId,len,guidList)
if len>0 then
for i,guid in ipairs(guidList)do
MysteryEventSystem.recv_18_6(guid,nil,sysId)
end
end
end



function MysteryEventSystem.recv_18_7(argtable)
local guid,choiceId,resultIndex=argtable[1],argtable[2],argtable[3]
local diceListLen,diceList=argtable[4],argtable[5]
local diceNum,previewResult=argtable[6],argtable[7]
local sysId=argtable[8]

local eventData,sysId=MysteryEventListModel:get_event(guid)
if eventData then

eventData.choiceId=choiceId
eventData.resultConf=resultIndex
eventData.diceNum=diceNum

notifySystem:postNotify(notifyConfig.on_mystery_event_select,guid,eventData.eventGroupId,choiceId,resultIndex)

if sysId==SYSTEM_DEFINE.eMiJing then
MysteryEventModel:set_event_flag(nil)
end

if type(previewResult)=="string"then
local previewList=jsonHelper.decode(previewResult)

MysteryEventModel:set_preview_result_value(previewList)
end




if diceListLen>0 then

MysteryEventModel:set_dice_count(diceNum)

if UIManager:isActive("UIMysteryEventDice2Win")then
local after=function()
MysteryEventSystem:event_result(guid,sysId,eventData.eventGroupId,choiceId,resultIndex,nil)
end
UIManager:invokeUIMethod("UIMysteryEventDice2Win","refreshDice",diceList,after)
else
MysteryEventModel:set_dice_count(diceNum)
MysteryEventSystem:event_result(guid,sysId,eventData.eventGroupId,choiceId,resultIndex,nil)
end
else
MysteryEventSystem:event_result(guid,sysId,eventData.eventGroupId,choiceId,resultIndex,nil)
end
end


end



function MysteryEventSystem.recv_18_8(args)
local guid,choiceId,resultIndex,nIndex,nextEventGroupId,nextDiceNum,sysId=args[1],args[2],args[3],args[4],args[5],args[6],args[7]
local comfirmData={guid,choiceId,resultIndex,nIndex,nextEventGroupId}
MysteryEventModel:set_dice_max_count(guid,nextDiceNum)

UIManager:callWindowFunc("UIMysteryEventOutResultWin","waitToConfirm")
local eventData=MysteryEventListModel:get_event_by_guid(sysId,guid)

if eventData then
eventData.resultIndex=nIndex
end

MysteryEventModel:do_result_after_callback(comfirmData)
end

function MysteryEventSystem.recv_18_9(qiyuItem,sysId,diceListLen,diceList)
MysteryEventModel:set_result_temp({qiyuItem,sysId,diceListLen,diceList})
local after=function()
MysteryEventSystem:event_result(qiyuItem.guid,sysId,qiyuItem.eventGroupId,qiyuItem.choiceId,qiyuItem.resultConf,nil)
end
UIManager:invokeUIMethod("UIMysteryEventDice2Win","refreshDice",diceList,after)
end


function MysteryEventSystem.send_18_10(evtGuid,sysId)
socketManager:send_18_10(evtGuid,sysId)
end


function MysteryEventSystem.send_18_11(evtGuid,isWin,sysId)

if isWin then
socketManager:send_18_11(evtGuid,2,sysId)
else
socketManager:send_18_11(evtGuid,1,sysId)
end
end



function MysteryEventSystem.do_result_before_callback(guid)
guid=tostring(guid)
if MysteryEventModel.resultBeforeCallback[guid]then
local size=MysteryEventModel.resultBeforeCallback[guid]:size()
if size>0 then
local value=MysteryEventModel.resultBeforeCallback[guid]:dequeue()
if value then
if value[5]and type(value[5])=="function"then


value[5](value[1],value[2],value[3],value[4])
UIManager:callWindowFunc("UIMysteryEventOutResultWin","waitToConfirm")
else
MysteryEventSystem.send_18_8(value[6],value[4],value[1])
end
end
else
MysteryEventModel.resultBeforeCallback[guid]:clear()

local result_group=MysteryEventModel:get_result_select()
if result_group then
MysteryEventModel:set_result_select()
if MysteryEventModel:is_last_option(result_group[3],result_group[4],result_group[5])then
notifySystem:postNotify(notifyConfig.on_mystery_event_finish,unpack(result_group))
end

end
UIManager:callWindowFunc("UIMysteryEventOutResultWin","waitToConfirm")
end
else
UIManager:callWindowFunc("UIMysteryEventOutResultWin","waitToConfirm")
end

end


function MysteryEventModel:do_result_after_callback(comfirmData)
local guid=comfirmData[1]
guid=tostring(guid)
if MysteryEventModel.resultCallback[guid]then
local size=MysteryEventModel.resultCallback[guid]:size()
if size>0 then
local value=MysteryEventModel.resultCallback[guid]:dequeue()

if value[2]and type(value[2])=="function"then
value[2](comfirmData)
else
MysteryEventSystem.do_result_before_callback(guid)
end
else
MysteryEventSystem.do_result_before_callback(guid)
MysteryEventModel.resultCallback[guid]:clear()
end
else
MysteryEventSystem.do_result_before_callback(guid)
if next(MysteryEventModel.resultCallback)then
MysteryEventModel.resultCallback[guid]:clear()
end
end
end

function MysteryEventSystem.onMysteryEventResultFinish(guid)
MysteryEventSystem.do_result_before_callback(guid)
end

function MysteryEventSystem.onMysteryEventFightFinish(sysId,guid)
if guid then
if guid~=-1 then
MysteryEventSystem.event_end(guid)
end
end
end


