






local _myXMBuoy=nil
local _myXMEffect=nil
local _teamData={}
local _xmMoveTimes=nil

function xianjieModel:clearData_xianmeng()
local lp=self.allXianMengDatas
if lp then
for guildid_str,xmData in pairs(lp)do
xianjieController:removeXJClass(xmData)
end
self.allXianMengDatas=nil
end
if _myXMEffect then
xianjieController:removeXJClass(_myXMEffect)
_myXMEffect=nil
end
end

function xianjieModel:initAllXianMengDatas()
xianjieModel:clearData_xianmeng()
self.allXianMengDatas={}
end

function xianjieModel:refreshXianMengData(v,isInit)











local guildid_str=v.guildid_str
local effectData=xianmengModel:isMyXM2(v.guildid)and{
gridX=v.x,
gridZ=v.y,
sceneidx=v.sceneidx,
guildid=v.guildid,
guildid_str=tostring(v.guildid),
lv=v.lv,
shield=v.shield,
sec=v.sec,
}or nil

if isInit then
if v.serverid~=0 then
local xmData=xianjieController:createXJClass(xjDataType.eXianMeng,v)
self.allXianMengDatas[guildid_str]=xmData
xianjieModel:setGuid2EntityType(v.guildid,v.entitytype,v.sceneidx)

if effectData then
_myXMEffect=xianjieController:createXJClass(xjDataType.eXianMengEffect,effectData)
end

notifySystem:postNotify(notifyConfig.onXianJieXMChange,CHANGE_TYPE.eInit,xmData.guildid)
else



end
else
if v.serverid~=0 then
local xmData_=self.allXianMengDatas[guildid_str]
if xmData_==nil then
local xmData=xianjieController:createXJClass(xjDataType.eXianMeng,v)
self.allXianMengDatas[guildid_str]=xmData
xianjieModel:setGuid2EntityType(v.guildid,v.entitytype,v.sceneidx)
xmData:createEntity(true)
notifySystem:postNotify(notifyConfig.onXianJieXMChange,CHANGE_TYPE.eAdd,xmData.guildid)
else
xmData_:refreshData(v)
xmData_:refreshEntity()
notifySystem:postNotify(notifyConfig.onXianJieXMChange,CHANGE_TYPE.eChanged,xmData_.guildid)
end

if effectData then
if _myXMEffect==nil then
_myXMEffect=xianjieController:createXJClass(xjDataType.eXianMengEffect,effectData)
_myXMEffect:createEntity(true)
else
_myXMEffect:refreshData(effectData)
_myXMEffect:refreshEntity()
end
end
else
local xmData=self.allXianMengDatas[guildid_str]
if xmData~=nil then
local guildid=xmData.guildid
local sceneidx=xmData.sceneidx
xianjieController:removeXJClass(xmData)
self.allXianMengDatas[guildid_str]=nil
xianjieModel:setGuid2EntityType(v.guildid,nil,sceneidx)
notifySystem:postNotify(notifyConfig.onXianJieXMChange,CHANGE_TYPE.eDelete,guildid)
else



end

if effectData then
if _myXMEffect~=nil then
xianjieController:removeXJClass(_myXMEffect)
_myXMEffect=nil
end
end
end
end
end

function xianjieModel:getXianMengData(guildid)
local guildid_str=tostring(guildid)
return self:getXianMengDataEx(guildid_str)
end

function xianjieModel:getXianMengDataEx(guildid_str)
if self.allXianMengDatas then
return self.allXianMengDatas[guildid_str]
end
end

function xianjieModel:getMyXianMengData()
local guild=xianmengModel:getMyXMGuildID()
return self:getXianMengData(guild)
end

function xianjieModel:createAllXianMengEnities(needRefreshAOI)
local lp=self.allXianMengDatas
if lp then
for guildid_str,xmData in pairs(lp)do
xmData:createEntity(needRefreshAOI)
end
end
if _myXMEffect then
_myXMEffect:createEntity(needRefreshAOI)
end
end

function xianjieModel:removeAllXianMengEnities()
local lp=self.allXianMengDatas
if lp then
for guildid_str,xmData in pairs(lp)do
xmData:removeEntity()
end
end
if _myXMEffect then
_myXMEffect:removeEntity()
end
end

function xianjieModel:initMyXianMengBuoy()
if _myXMBuoy==nil and xianmengModel:hasXM()and xianjieModel:isInMoJie()then
local guildid=xianmengModel:myXMGuildID()
local xmData=xianjieModel:getXianMengData(guildid)
local canCreate=xianjieModel:getMoJieEnterConfig("guild")
if canCreate and xmData and xianjieModel:checkSceneIndex(xmData.sceneidx)then
_myXMBuoy=xianjieController:addBuoy(xjBuoyType.eXianMeng,{guildid=guildid})
end
end
end

function xianjieModel:clearMyXianMengBuoy(remove)
if _myXMBuoy then
if remove then
xianjieController:removeBuoy(_myXMBuoy)
end
_myXMBuoy=nil
end
end

function xianjieModel:refreshMyXianMengBuoy()
if _myXMBuoy then
local buoy=xianjieController:getBuoy(_myXMBuoy)
if not xianmengModel:isMyXM2(buoy.data.guildid)then
xianjieController:removeBuoy(_myXMBuoy)
_myXMBuoy=nil
end
end

self:initMyXianMengBuoy()

if _myXMBuoy then
xianjieController:refreshBuoy(_myXMBuoy)
end
end

function xianjieModel:getXianMengEffectData()
return _myXMEffect
end

function xianjieModel:setXianMengMoveTimes(times)
_xmMoveTimes=times
end

function xianjieModel:getXianMengMoveTimes()
return _xmMoveTimes or 0
end

function xianjieModel:addXianMengMoveTimes()
_xmMoveTimes=(_xmMoveTimes or 0)+1
end

function xianjieModel:clearAllXianMengGarrisonData()
table.clear(_teamData)
end

function xianjieModel:getMyXianMengGarrison()
local guildId=xianmengModel:getMyXMGuildID()
if guildId then
return xianjieModel:getXianMengGarrison(guildId)
end
end

function xianjieModel:getXianMengGarrison(guildId)
local guildIdStr=mathHelper.int64_to_string(guildId)
return self:getXianMengGarrisonEx(guildIdStr)
end

function xianjieModel:getXianMengGarrisonEx(guildIdStr)
return _teamData[guildIdStr]
end

function xianjieModel:setXianMengGarrison(guildId,teamList,dataSec)
local guildIdStr=mathHelper.int64_to_string(guildId)
local data=_teamData[guildIdStr]
if data==nil then
data={}
_teamData[guildIdStr]=data
end
data.guild=guildId
data.team=teamList or{}
data.serverTime=dataSec
data.clientTime=dataSec
end

function xianjieModel:refreshXianMengGarrisonTime(guildId,dataSec)
local data=xianjieModel:getXianMengGarrison(guildId)
if data then
data.serverTime=dataSec

end
end


function xianjieModel:clearData_selfDefendXianMengTeam()
if self.selfDefendXianMengTeamDatas and next(self.selfDefendXianMengTeamDatas)then
for i,v in pairs(self.selfDefendXianMengTeamDatas)do
local teamHandleId=v.teamHandleId
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.selfDefendXianMengTeamDatas=nil
end

function xianjieModel:initSelfDefendXianMengTeamDatas(isInit_allXianJie)
if isInit_allXianJie then
xianjieModel:clearData_selfDefendXianMengTeam()
self.selfDefendXianMengTeamDatas={}
else
if not self.selfDefendXianMengTeamDatas then
self.selfDefendXianMengTeamDatas={}
end
end
end

function xianjieModel:refreshSelfDefendXianMengTeamData(v,isInit)
local guid_str=tostring(v.guid)
local teamType=xjTeamHandleType.eDefendXianMengStation
if not self.selfDefendXianMengTeamDatas then

return
end

if isInit then

self.selfDefendXianMengTeamDatas[guid_str]={data=v,sceneidx=v.sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.selfDefendXianMengTeamDatas[guid_str].teamHandleId=teamHandleID

notifySystem:postNotify(notifyConfig.onXianJieDefendXianMengStationChange,CHANGE_TYPE.eInit,v.guid)
else
local teamData=self.selfDefendXianMengTeamDatas[guid_str]
if teamData==nil then

self.selfDefendXianMengTeamDatas[guid_str]={data=v,sceneidx=v.sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.selfDefendXianMengTeamDatas[guid_str].teamHandleId=teamHandleID

notifySystem:postNotify(notifyConfig.onXianJieDefendXianMengStationChange,CHANGE_TYPE.eAdd,v.guid)
else


self.selfDefendXianMengTeamDatas[guid_str].data=v

notifySystem:postNotify(notifyConfig.onXianJieDefendXianMengStationChange,CHANGE_TYPE.eChanged,v.guid)
end
end
end

function xianjieModel:removeSelfDefendXianMengTeamData(guid)
local guid_str=tostring(guid)
local teamData=self.selfDefendXianMengTeamDatas[guid_str]
if teamData~=nil then
local teamHandleID=teamData.teamHandleId
local boatid=teamData.data.boatid
xianjieController:removeXJTeamHandle(teamHandleID)
self.selfDefendXianMengTeamDatas[guid_str]=nil
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eDefendXianMeng,guid,teamHandleID,boatid,true)

notifySystem:postNotify(notifyConfig.onXianJieDefendXianMengStationChange,CHANGE_TYPE.eDelete,guid)
else



end
end

function xianjieModel:getSelfDefendXianMengTeamData(guid)
if self.selfDefendXianMengTeamDatas then
local guid_str=tostring(guid)
return self.selfDefendXianMengTeamDatas[guid_str]
end
end

function xianjieModel:haveSelfDefendXianMengTeamData(guid)
return self:getSelfDefendXianMengTeamData(guid)~=nil
end

