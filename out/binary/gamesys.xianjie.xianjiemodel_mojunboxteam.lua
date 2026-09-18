local _marchs={}

mjMoJunBoxChangeEventType={
eAdd=1,
eUpdate=2,
eDelete=3,
}

mjMoJunBoxMarchTeamType={
eNormal=1,
eRetract=2,
}


function xianjieModel:initData_mojunBoxTeam()

end

function xianjieModel:clearData_mojunBoxTeam()
xianjieModel:clearAllMoJunBoxMarch()
end

function xianjieModel:onEnterMap_mojunBoxTeam()
xianjieModel:excuteAllMoJunBoxMarchBehaviour()
end

function xianjieModel:onExitMap_mojunBoxTeam()
xianjieModel:clearAllMoJunBoxMarchBehaviour()
end

function xianjieModel:refreshMoJunBoxMarch(guid,marchJson,isInit)
if marchJson and marchJson~=""then
local march=self:getMoJunBoxMarch(guid)
if march then
march:refreshJson(marchJson)
notifySystem:postNotify(notifyConfig.onXianJieMoJunBoxMarchChange,mjMoJunBoxChangeEventType.eUpdate,guid,isInit)

local teamHandle=march:getTeamHandle()
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eChanged,teamHandle)
else
march=self:addMoJunBoxMarchJson(guid,marchJson)
march:initTeamHandle()
if not isInit then
march:createBehavior(nil,true)
end
notifySystem:postNotify(notifyConfig.onXianJieMoJunBoxMarchChange,mjMoJunBoxChangeEventType.eAdd,guid,isInit)

local teamHandle=march:getTeamHandle()
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eAdd,teamHandle)
end
else
local march=self:getMoJunBoxMarch(guid)
if march then
local teamHandleID=march.teamHandleID

self:deleteMoJunBoxMarch(guid)
notifySystem:postNotify(notifyConfig.onXianJieMoJunBoxMarchChange,mjMoJunBoxChangeEventType.eDelete,guid,isInit)

notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eDelete,teamHandleID)
end
end
end

function xianjieModel:addMoJunBoxMarchJson(guid,json)
local guidStr=tostring(guid)
local args={
guid=guid,
guid_str=guidStr,
marchJson=json,
}
local xjData=xianjieController:createXJClass(xjDataType.eMoJunBox_MarchTeam,args)
_marchs[guidStr]=xjData

return xjData
end

function xianjieModel:deleteMoJunBoxMarch(guid)
local key=tostring(guid)
local data=_marchs[key]

if data then
xianjieController:removeXJClass(data)
_marchs[key]=nil
end
end

function xianjieModel:getMoJunBoxMarch(guid)
local key=tostring(guid)
return _marchs[key]
end

function xianjieModel:getMoJunBoxMarchEx(key)
return _marchs[key]
end

function xianjieModel:haveMoJunBoxMarch(guid)
local data=self:getMoJunBoxMarch(guid)
return data~=nil
end

function xianjieModel:getAllMoJunBoxMarch()
return _marchs
end

function xianjieModel:clearAllMoJunBoxMarch()
local temp=_marchs
_marchs={}
for key,data in pairs(temp)do
xianjieController:removeXJClass(data)
end
end

function xianjieModel:excuteAllMoJunBoxMarchBehaviour()
for key,march in pairs(_marchs)do
march:createBehavior(nil,true)
end
end

function xianjieModel:clearAllMoJunBoxMarchBehaviour()
for key,march in pairs(_marchs)do
march:clearBehaviorEx()
end
end

function xianjieModel:getAllMoJunBoxWaiPaiTeamHandle()
local list={}
local marchs=self:getAllMoJunBoxMarch()
for key,march in pairs(marchs)do
table.insert(list,march:getTeamHandle())
end
return list
end

