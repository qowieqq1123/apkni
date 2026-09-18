









local subActivityInfo_fangyingting={name='fangyingting'}



function subActivityInfo_fangyingting:onInit()
local fangyingting_DatiRc=self:getFangYingTing_DatiRc()
if fangyingting_DatiRc and fangyingting_DatiRc.start_time then
if fangyingting_DatiRc.start_time<self.start_time then

self:setFangYingTing_DatiRc({})



end
end
end

function subActivityInfo_fangyingting:onStart()

end

function subActivityInfo_fangyingting:onUpdate()

end

function subActivityInfo_fangyingting:onDelete()

end

function subActivityInfo_fangyingting:checkReddot()
local data=self.data
if data then
local sub_actcfg=self:getSubActConfig()
end
return false
end


function subActivityInfo_fangyingting:getActTuiTuConfig()
local data=self:getData()

end


function subActivityInfo_fangyingting:getFangYingTing_DatiRc()
return userActorSetting.get("fangyingting_DatiRc",{})
end

function subActivityInfo_fangyingting:setFangYingTing_DatiRc(DatiRecord)
DatiRecord.start_time=self.start_time
userActorSetting.set("fangyingting_DatiRc",DatiRecord)
userActorSetting.flush()
end


local _EventHandle={
[eFangYingTingEventType.PushMap]={
Run=function(data,eventCfg,actID,subid,selectWhichAct)
local curWhichAct=data.progress

local isCompleted=selectWhichAct<=curWhichAct
if isCompleted then
local eventlist=eventCfg[2]
local ChallengepushMapId=eventlist[2]
local pushMapData=activitiesModel:getCommonActInfoData(actID,subid,selectWhichAct,ChallengepushMapId)
if pushMapData then
local pushMapCfg=cfg_acttutuiconfig_get(ChallengepushMapId)
return pushMapData.progress==#pushMapCfg.monList
end
end
return false
end
},
[eFangYingTingEventType.Adventure]={
Run=function(data,eventCfg,actID,subid,selectWhichAct)
local curWhichAct=data.progress
return selectWhichAct<=curWhichAct
end
},
[eFangYingTingEventType.AnswerQuestion]={
Run=function(data,eventCfg,actID,subid,selectWhichAct)
local curWhichAct=data.progress
return selectWhichAct<=curWhichAct
end
},
[eFangYingTingEventType.None]={
Run=function(data,eventCfg,actID,subid,selectWhichAct)
local curWhichAct=data.progress
return selectWhichAct<=curWhichAct
end
},
}


function subActivityInfo_fangyingting:checkCurScreenIsOpen(selectWhichAct)
local data=self:getData()
local sub_actcfg=self:getSubActConfig()
local isOpen=self:checkCurScreenIsOpen_Flag(sub_actcfg,data,selectWhichAct)
return isOpen
end


function subActivityInfo_fangyingting:checkCurScreenIsOpen_Flag(sub_actcfg,data,selectWhichAct)
local curWhichAct=data.progress
local ConditionDay=sub_actcfg.openCDN[selectWhichAct]
local today=self:getStart2NowDay()

local dayOpen=today>=ConditionDay

local lastScreenCompleted=selectWhichAct-1<=curWhichAct
return dayOpen and lastScreenCompleted
end


function subActivityInfo_fangyingting:checkScreenAllCompleted(selectWhichAct)
local data=self:getData()
local sub_actcfg=self:getSubActConfig()
local AllCompleted=self:checkScreenAllCompleted_Flag(sub_actcfg,data,selectWhichAct)
return AllCompleted
end


function subActivityInfo_fangyingting:checkScreenAllCompleted_Flag(sub_actcfg,data,selectWhichAct)
local eventCfg=sub_actcfg.eventList[selectWhichAct]
local EventHandle=_EventHandle[eventCfg[1]]
if EventHandle then
return EventHandle.Run(data,eventCfg,data.actID,data.subid,selectWhichAct)
end
return false
end



function subActivityInfo_fangyingting:getCommonActInfoData(act2index,tuituid)
local data=self:getData()
return activitiesModel:getCommonActInfoData(data.actID,data.subid,act2index,tuituid)
end

function subActivityInfo_fangyingting:PushMapCfg(tuituid)
return cfg_acttutuiconfig_get(tuituid)
end



function subActivityInfo_fangyingting:checkPushMapId(sub_actcfg,selectWhichAct)
local data=self:getData()
local screenAllCompleted=self:checkScreenAllCompleted(selectWhichAct)
local eventCfg=sub_actcfg.eventList[selectWhichAct]
local pushMapCfg=eventCfg[2]
local PushMapId=pushMapCfg[1]

local PlotState=eFangYingTingPlotState.Easy

local isCompleted=selectWhichAct<=data.progress
if not screenAllCompleted and isCompleted then
PushMapId=pushMapCfg[2]
PlotState=eFangYingTingPlotState.Difficult
end
return PushMapId,PlotState
end


function subActivityInfo_fangyingting:checkCurScreenReddot(sub_actcfg,data,selectWhichAct)
local isOpen=self:checkCurScreenIsOpen_Flag(sub_actcfg,data,selectWhichAct)
if isOpen then
local AllCompleted=self:checkScreenAllCompleted_Flag(sub_actcfg,data,selectWhichAct)
if not AllCompleted then
return true
end
end
return false
end


function subActivityInfo_fangyingting:checkAllScreenReddot()
local data=self:getData()
local sub_actcfg=self:getSubActConfig()
local len=#sub_actcfg.eventList
for i=1,len do
local flag=self:checkCurScreenReddot(sub_actcfg,data,i)
if flag then
return flag
end
end
return false
end


function subActivityInfo_fangyingting:checkLeftScreenReddot(sub_actcfg,data,selectWhichAct)
if selectWhichAct<=1 then
return false
end
for i=1,selectWhichAct-1 do
local flag=self:checkCurScreenReddot(sub_actcfg,data,i)
if flag then
return flag
end
end
return false
end



function subActivityInfo_fangyingting:checkRightScreenReddot(sub_actcfg,data,selectWhichAct)
if selectWhichAct>=#sub_actcfg.eventList then
return false
end
for i=selectWhichAct+1,#sub_actcfg.eventList do
local flag=self:checkCurScreenReddot(sub_actcfg,data,i)
if flag then
return flag
end
end
return false
end



function subActivityInfo_fangyingting:isAllCompleted()
local data=self:getData()
local sub_actcfg=self:getSubActConfig()
return data.progress==#sub_actcfg.eventList
end



function subActivityInfo_fangyingting:changePushMapId(PushMapId,PlotState)
local data=self:getData()
data.selectPushMapId=PushMapId
data.selectPlotState=PlotState
end


function subActivityInfo_fangyingting:checkProgressIsReceive()
local data=self:getData()
if data.rewardFlag~=1 then
local sub_actcfg=self:getSubActConfig()
local curExp=0
local curWhichAct=data.progress
for i,v in ipairs(sub_actcfg.eventList)do
if curWhichAct>=i then
curExp=curExp+v[3]
end
end
local isReceive=curExp>=sub_actcfg.gressMax
return isReceive
end
return false
end

function subActivityInfo_fangyingting:checkReddot()
local data=self.data
if data then
if data.rewardFlag==0 then
local sub_actcfg=self:getSubActConfig()
local curProgress=data.progress
if curProgress==#sub_actcfg.eventList then
return true
end
end
if self:checkAllScreenReddot()then
return true
end
end
return false
end

return subActivityInfo_fangyingting
