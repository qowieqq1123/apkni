






local _MODULENAME="worldResPointBaseModel"




def_table(_MODULENAME)
worldResPointBaseModel.name=_MODULENAME

worldResPointBaseModel.collection_effect=20010

local tempCameraData=nil
local initWorld={}
local initGuid={}
local timeData={}

function worldResPointBaseModel:onAppStart()

end


function worldResPointBaseModel:onEnterState()

end


function worldResPointBaseModel:onLeaveState()

tempCameraData=nil
timeData={}
initWorld={}
initGuid={}
end


function worldResPointBaseModel:onServerDataInitFinish()

end


function worldResPointBaseModel:convertUnitKey(guid,subIndex)
return worldModel:convertUnitKey({eWorldUnitTpye.RESPOINT,tostring(guid),subIndex})
end

function worldResPointBaseModel:getTempCemaraData()
return tempCameraData
end

function worldResPointBaseModel:setTempCemaraData(unitKey,lookAtPosition,height)
tempCameraData={unitKey,lookAtPosition,height}
end

function worldResPointBaseModel:addTimeData(guid,time)
local guidStr=tostring(guid)
timeData[guidStr]=time
end

function worldResPointBaseModel:removeTimeData(guid)
local guidStr=tostring(guid)
timeData[guidStr]=nil
end

function worldResPointBaseModel:checkTimeData()
local now=timeHelper.getServerShortTime()
for i,v in pairs(timeData)do
if v<=now then
local guid=int64.new(i)
local data=worldResPointDataModel:getPointData(guid)
worldResPointController:hideResPointAllUnit(guid)
timeData[i]=nil
worldResPointDataModel:clearPointData(guid,true)
end
end
end

function worldResPointBaseModel:checkExistTime()
return next(timeData)~=nil
end

function worldResPointBaseModel:getOverTime(guid)
local guidStr=tostring(guid)
return timeData[guidStr]
end

function worldResPointBaseModel:addInitWorld(world)
initWorld[world]=true
end

function worldResPointBaseModel:removeInitWorld(world,array)
initWorld[world]=nil
if array then
for i,v in ipairs(array)do
if v.len>0 then
for j,w in ipairs(v.contentList)do
table.insert(initGuid,{v.guid,w.param_3})
end
end
end
end
end

function worldResPointBaseModel:checkInitWorld()
if next(initWorld)==nil then
worldPositionLibrary:checkDataEx(eWorldUnitTpye.RESPOINT,initGuid)
end
end