






local _MODULENAME="MysteryEventModel"


def_table(_MODULENAME)
MysteryEventModel.name=_MODULENAME

MysteryEventModel.data={}

function MysteryEventModel:on_app_start()

end


function MysteryEventModel:on_enter_state()
self.data={}
self.data.maxDiceCount={}
self.data.eventStrList={}
self.data.currentResultData={}
self.resultCallback={}
self.resultBeforeCallback={}
self.data.eventDiceStrList={}
end


function MysteryEventModel:on_leave_state()

self.data={}
self.resultCallback={}
self.resultBeforeCallback={}
end



function MysteryEventModel.get_group_cfg(groupId)
groupId=tonumber(groupId)
return cfg_sschoiceeventconfig_get(groupId)
end

function MysteryEventModel.get_jump_result_type()
return cfg_sschoiceeventglobalconfig_get(1).jumpResultType
end

function MysteryEventModel.get_group_main_option(groupId)
local optionCfg=MysteryEventModel.get_option_cfg(groupId,1)
if not optionCfg then
optionCfg=MysteryEventModel.get_option_cfg(groupId,0)
end
return optionCfg
end

function MysteryEventModel.get_option_cfg(groupId,optionId)
if not groupId or not optionId then
return
end
groupId=tonumber(groupId)
local groupCfg=cfg_sschoiceeventconfig_get(groupId)
return groupCfg and groupCfg[optionId]
end

local sortDiceFunc=function(a,b)
return a<b
end


function MysteryEventModel:get_dice_anim(diceCount,diceList)
local nState=Mathf.Pow(10,diceCount+1)*diceCount
table.sort(diceList,sortDiceFunc)
for i,v in ipairs(diceList)do
nState=nState+Mathf.Pow(10,diceCount-i+1)*v
end

return nState
end



function MysteryEventModel:is_last_option(groupId,optionId,resultIndex)
resultIndex=resultIndex or 1
local optionCfg=MysteryEventModel.get_option_cfg(groupId,optionId)
local jumpType=MysteryEventModel.get_jump_result_type()
if optionCfg then
local result=optionCfg[MysteryEventSystem.diceCfg[resultIndex].args]
if type(result[1])=='number'then
result={result}
end
for i,v in ipairs(result)do
for _,jump in ipairs(jumpType)do
if v[1]==jump then
return
end
end
end
return true
end
end




function MysteryEventModel:set_dice_max_count(evtGuid,count)
self.data.maxDiceCount[tostring(evtGuid)]=count
end

function MysteryEventModel:get_dice_max_count(evtGuid)
if not evtGuid then
return 0
end
return self.data.maxDiceCount[tostring(evtGuid)]or 0
end

function MysteryEventModel:set_dice_count(count)
self.data.diceCount=count
end

function MysteryEventModel:get_dice_count()
return self.data.diceCount or 0
end


function MysteryEventModel:set_current_result_flag(resultType)
self.data.currentResultFlag=resultType
end

function MysteryEventModel:get_current_result_flag()
return self.data.currentResultFlag
end


function MysteryEventModel:set_current_result_data(resultType,...)
self.data.currentResultData[resultType]={...}
end

function MysteryEventModel:get_current_result_data(resultType)
return self.data.currentResultData[resultType]
end

function MysteryEventModel:clear_current_result_data(resultType)
self.data.currentResultData[resultType]=nil
end


function MysteryEventModel:set_result_before_callback(guid,data)
guid=tostring(guid)
if not MysteryEventModel.resultBeforeCallback[guid]then
MysteryEventModel.resultBeforeCallback[guid]=queue.New()
end
MysteryEventModel.resultBeforeCallback[guid]:enqueue(data)
end


function MysteryEventModel:set_result_callback(guid,resultType,callBack)
guid=tostring(guid)
if not MysteryEventModel.resultCallback[guid]then
MysteryEventModel.resultCallback[guid]=queue.New()
end
MysteryEventModel.resultCallback[guid]:enqueue({resultType,callBack})
end


function MysteryEventModel:get_result_callback_count(guid)
guid=tostring(guid)
if MysteryEventModel.resultCallback[guid]then
return MysteryEventModel.resultCallback[guid]:size()
end
return 0
end

function MysteryEventModel:clear_result_callback(guid)
guid=tostring(guid)
if MysteryEventModel.resultBeforeCallback[guid]then
MysteryEventModel.resultBeforeCallback[guid]:clear()
end
if MysteryEventModel.resultCallback[guid]then
MysteryEventModel.resultCallback[guid]:clear()
end
end


function MysteryEventModel:set_result_select(...)
self.data.activeSelect={...}
end

function MysteryEventModel:get_result_select()
if not self.data.activeSelect then
return
end
if not next(self.data.activeSelect)then
return
end
return self.data.activeSelect
end



function MysteryEventModel:set_preview_result_value(List)
self.previewResultValue={}
if List then
for i,v in ipairs(List)do
self.previewResultValue[v[1]]=v[2]
end
end
end

function MysteryEventModel:get_preview_result_value(resultType)
if self.previewResultValue and next(self.previewResultValue)then
return self.previewResultValue[resultType]
end
end


function MysteryEventModel:set_team_data(guidList)
self.guidList=guidList
end

function MysteryEventModel:get_team_data()
return self.guidList
end


function MysteryEventModel:add_event_str_data(str)
table.insert(self.data.eventStrList,str)
end

function MysteryEventModel:get_event_str_list()
return self.data.eventStrList
end

function MysteryEventModel:clear_event_str_list()
self.data.eventStrList={}
end


function MysteryEventModel:add_event_dice_str_data(uiType,str,guid)
table.insert(self.data.eventDiceStrList,{uiType=uiType,str=str,guid=guid})
end

function MysteryEventModel:get_event_dice_str_list()
return self.data.eventDiceStrList
end

function MysteryEventModel:clear_event_dice_str_list()
self.data.eventDiceStrList={}
end


function MysteryEventModel:set_select_disciple(guid)
self.data.selectDisciple=guid
end

function MysteryEventModel:get_select_disciple()
return self.data.selectDisciple
end


function MysteryEventModel:set_event_flag(flag)
self.data.eventFlag=flag
end

function MysteryEventModel:get_event_flag()
return self.data.eventFlag
end

function MysteryEventModel:have_event_flag()
return self.data.eventFlag~=nil
end


function MysteryEventModel:set_result_temp(args)
self.data.result_temp=args
end

function MysteryEventModel:get_result_temp()
return self.data.result_temp
end


function MysteryEventModel:afterGetMysteryInfoFunc(func)
self.data.afterafterGetMysteryInfo=func
end

function MysteryEventModel:getAfterMysteryInfoFunc()
return self.data.afterafterGetMysteryInfo
end