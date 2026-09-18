




eventOptionRetAction=simple_class(eventBaseAction)

function eventOptionRetAction.create(...)
return refObject.getX('eventOptionRetAction',...)
end

function eventOptionRetAction:init(...)
self.leaveState=false
self:start(...)
end

function eventOptionRetAction:onRelease()
self.leaveState=false
end


function eventOptionRetAction:start(eventconfig,eventInfo)
local mainType=eventInfo.mainType
local subType=eventInfo.subType
local eventid=eventInfo.eventid
local eventguid=eventInfo.eventguid
local paramList=eventInfo.paramList
local optioncontent=eventconfig.optioncontent
local optionicon=eventconfig.optionicon
local optionList=eventInfo.optionList
local optionid=optionList[1]
local cndid=optionList[2]
local effectidx=optionList[3]
local name=optioncontent[1]
local icon=optionicon[2][optionid][cndid][effectidx]
local contentParam=eventTextControl.getOptionContent(eventguid,eventid,paramList,optionid,cndid,effectidx)
local rewards=eventServerDataModel.getItem(eventguid)
local key=self:getkey()
local guid=self:getguid()
local args={}
args.content=contentParam and contentParam[1]or nil
args.effContent=contentParam and contentParam[2]or nil
args.rewards=rewards
args.name=name
args.icon=icon
args.actionKey={guid,key}
args.isEnd=true

local hasWaitTime=eventInfo.waitTime and eventInfo.waitTime>0
local isMiJingEvent=eventConfig.checkIsFinishMiJingEventOption(eventInfo.eventid,optionid)
local finishFunc=function()
if not self:isRelease(guid,key)then
self.leaveState=true
end
if not hasWaitTime and not isMiJingEvent then

shanmenModel:optionEventNPCLeave(eventguid,optionid)


eventOptionControl:checkWaitOptionEventList()

notifySystem:postNotify(notifyConfig.onShanMenVisitChange,SHANMEN_TYPE.eOptionEvent)
end

eventActionControl.onFinish(eventguid)
UIManager:closeWindow('UIEventOptionSelectWin')
end
args.okClick=finishFunc

local optionEndBtnTextList=eventConfig.getEventConfig(eventid).optionEndBtnText
local selectEndBtnText
if optionEndBtnTextList and optionEndBtnTextList[optionid]then
local selectEndBtnParam=optionEndBtnTextList[optionid][cndid]
if type(selectEndBtnParam)=='table'then
selectEndBtnText=selectEndBtnParam[effectidx]
else
selectEndBtnText=selectEndBtnParam
end
end
if selectEndBtnText then
local btnList={}
local btnParam={
name=selectEndBtnText,
click=function()
local win=UIManager:findActiveWindow("UIEventOptionSelectWin")
if win then
return win:onBtnClose()
end
end,
}
table.insert(btnList,btnParam)
args.btnList=btnList
end


local storyId_before=eventOptionControl.checkOptionEventHasEndStory(eventInfo,optionid,cndid,effectidx,true)
local storyId_after=eventOptionControl.checkOptionEventHasEndStory(eventInfo,optionid,cndid,effectidx,false)
local npcData=eventInfo.npcData

args.eventguid=eventguid
args.eventid=eventid
local showFunc=function()
if storyId_before or storyId_after then
if storyId_after then
args.endStoryId=storyId_after
args.endNpcData=npcData
end

if storyId_before then

local callback=function()
return UIManager:showWindow('UIEventOptionSelectWin',args)
end
local storyArgs={

npcData=npcData,
eventguid=eventguid,

}
eventOptionModel.setShowOptionEventResultIsOpening(true)

worldStoryController:showStoryTree(storyId_before,callback,nil,nil,storyArgs)
return
end
end
UIManager:showWindow('UIEventOptionSelectWin',args)
end


local win=UIManager:findActiveWindow('UIItemRecruitDiscipleWin')
if win then

win:addCallback(showFunc)
else

eventOptionModel.setShowOptionEventResultFunc(showFunc)
showFunc()
end

end

function eventOptionRetAction:update()
return self.leaveState
end
