local _posRecordData={}
local _posRecordKey="posZMRandomObject"
local _posRecordChange=false
local _randomObject={}
local _randomPosListen={}

function zongmenModel:loadRandomObjectPosition()
_posRecordData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eZongmenRandomObject,_posRecordKey,{})
_posRecordChange=false
end

function zongmenModel:saveRandomObjectPosition()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eZongmenRandomObject,_posRecordKey,_posRecordData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eZongmenRandomObject)
_posRecordChange=false
end

function zongmenModel:checkRandomObjectPosition()
local keys={}
for key,posData in pairs(_posRecordData)do
if _randomObject[key]==nil then
table.insert(keys,key)
end
end
if#keys>0 then
for index,key in ipairs(keys)do
_posRecordData[key]=nil
end
_posRecordChange=true
end
end

function zongmenModel:flushRandomObjectPosition()
if _posRecordChange then
self:saveRandomObjectPosition()
end
end

function zongmenModel:registerPositionFunc(guids,func)
for i,v in ipairs(guids)do
local key=tostring(v)
_randomPosListen[key]=func
end
end

function zongmenModel:allMapRandomPosition(configId)
local list=_MapManager.GetMapAreaPosByConfig(mapIdType.zhufeng,-2,configId)
if list.Count>0 then
local r=math.random(1,list.Count)
for i=1,list.Count do
local index=(r+i-2)%list.Count
local p=list[index]
local pArray=_MapManager.Vector3IntToArray(p)
if pArray[2]>=-40 then
return p
end
end
end
end

function zongmenModel:defaultPositionFunc()





local p=self:allMapRandomPosition(3)
if p then
local pos=_HexMapManager.Vector3IntToVector3(p)
return{x=pos.x,y=pos.y}
end
return{0,0}
end

function zongmenModel:randomPositionData(guid)
if isometricMapSystem.isAreaInit then
local key=tostring(guid)
local data=self:defaultPositionFunc()
if _randomPosListen[key]then
data=_randomPosListen[key]()
_randomPosListen[key]=nil
end
return data
end
end

function zongmenModel:getRandomObject(guid)
local key=tostring(guid)
return _randomObject[key]
end

function zongmenModel:getAllRandomObject()
return _randomObject
end

function zongmenModel:placeRandomObject(guid)
local key=tostring(guid)
local objData=_randomObject[key]
if objData then
local posData=self:randomPositionData(guid)

objData.posData=posData
_posRecordData[key]=posData
_posRecordChange=posData~=nil
self:flushRandomObjectPosition()
end
end

function zongmenModel:addRandomObject(data)
local key=tostring(data.randItemGuid)
local posData=_posRecordData[key]
if posData==nil then
posData=self:randomPositionData()
_posRecordData[key]=posData
_posRecordChange=posData~=nil
end
data.posData=posData
_randomObject[key]=data
end

function zongmenModel:addRandomObjects(datas)
for i,v in ipairs(datas)do
self:addRandomObject(v)
end
end

function zongmenModel:removeRandomObject(guid)
local key=tostring(guid)
_randomObject[key]=nil
_posRecordData[key]=nil
_posRecordChange=true
end

function zongmenModel:removeRandomObjects(guids)
for i,v in ipairs(guids)do
self:removeRandomObject(v)
end
end

function zongmenModel:cleanRandomObject()
_randomObject={}
end

function zongmenModel:resetRandomObject(datas)
self:cleanRandomObject()
self:addRandomObjects(datas)
self:checkRandomObjectPosition()
end