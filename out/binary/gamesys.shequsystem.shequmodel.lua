









shequModel={}


shequModel.data={}

function shequModel:onAppStart()

end


function shequModel:onEnterState(isReconnect)

end


function shequModel:onProtocolReq()

end


function shequModel:onLeaveState(isReconnect)

self.data={}
end


function shequModel:isHasSheQuAct()
if self.data.isTestMode then
return true
end
local htType=houtaiModel:getSheQuActTypeOnIndex(1)
if not htType then
return false
end

local data=houtaiModel:getSheQuActData(htType)
if not data or data==""then

return false
end


if not shequModel:checkSheQuActTime(data)then
return false
end
return true
end

function shequModel:checkSheQuActTime(sqdata)
if sqdata.beginTime~=nil then
local nowTime=timeHelper.getServerLongTime()
if nowTime>=sqdata.beginTime and nowTime<sqdata.endTime and nowTime>=sqdata.beginTime2 and nowTime<sqdata.endTime2 then
return true
end
end
return false
end

function shequModel:getSheQuActName()
local htType=houtaiModel:getSheQuActTypeOnIndex(1)
local data=houtaiModel:getSheQuActData(htType)
return data.title
end

function shequModel:isHasSheQuAct2()
if self.data.isTestMode2 then
return true
end

local htType=houtaiModel:getSheQuActTypeOnIndex(2)
if not htType then
return false
end

local data=houtaiModel:getSheQuActData(htType)
if not data or data==""then

return false
end


if not shequModel:checkSheQuActTime(data)then
return false
end
return true
end

function shequModel:getSheQuAct2Name()
local htType=houtaiModel:getSheQuActTypeOnIndex(2)
local data=houtaiModel:getSheQuActData(htType)
return data.title
end

function shequModel:isHasSheQuAct3()
if self.data.isTestMode3 then
return true
end

local htType=houtaiModel:getSheQuActTypeOnIndex(3)
if not htType then
return false
end

local data=houtaiModel:getSheQuActData(htType)
if not data or data==""then

return false
end


if not shequModel:checkSheQuActTime(data)then
return false
end
return true
end

function shequModel:getSheQuAct3Name()
local htType=houtaiModel:getSheQuActTypeOnIndex(3)
local data=houtaiModel:getSheQuActData(htType)
return data.title
end

function shequModel:isShowSheQuEnter()
local data=houtaiModel:getSheQuEnterData()
return data and data.isOpen or false
end

function shequModel:hasReddot()
local htType=houtaiModel:getSheQuActTypeOnIndex(1)
if not htType then
return false
end
local isShowSheQu=shequModel:isHasSheQuAct()
local htTypeName=FMT.fmt('weekSheQuAct_{0}',htType)
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eWeek,htTypeName)
return isShowSheQu and not flag
end

function shequModel:hasReddot2()
local htType=houtaiModel:getSheQuActTypeOnIndex(2)
if not htType then
return false
end
local isShowSheQu=shequModel:isHasSheQuAct2()
local htTypeName=FMT.fmt('weekSheQuAct_{0}',htType)
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eWeek,htTypeName)
return isShowSheQu and not flag
end

function shequModel:hasReddot3()
local htType=houtaiModel:getSheQuActTypeOnIndex(3)
if not htType then
return false
end
local isShowSheQu=shequModel:isHasSheQuAct3()
local htTypeName=FMT.fmt('weekSheQuAct_{0}',htType)
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eWeek,htTypeName)
return isShowSheQu and not flag
end


function shequModel:getCdnRootURL()
local cdnRootURL
local url=gameInfo:getParams('cdnURL')
if url~=nil then
url=string.gsub(url,"\\","")

local pos=0
for i=1,3 do
pos=string.find(url,"/",pos+1)
end
cdnRootURL=string.sub(url,1,pos)
end
return cdnRootURL
end


function shequModel:test_sheQuActChangeTestMode(isOpen)
self.data.isTestMode=isOpen
end

function shequModel:test_sheQuAct2ChangeTestMode(isOpen)
self.data.isTestMode2=isOpen
end

function shequModel:test_sheQuAct3ChangeTestMode(isOpen)
self.data.isTestMode3=isOpen
end