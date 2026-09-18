







xjWaiPiaBaseType={
eMarckTeam=1,
eStation=2,
eYuanZhu=3,
eJiJIe=4,
eArena=5,
eMoGong=6,
eDefendXianMeng=7,
eMoJun=8,
eYuanZhu_MJ=9,
eMoGong_ZHG=10,
eMoGong_HLT=11,
eYuanZhu_MG=12,
eXJLingShou=13,
eXJLingShouGroup=14,
}

local getTeamHandleFunc={
[xjWaiPiaBaseType.eMarckTeam]=function(guid)
local teamData=xianjieModel:getMarchTeamData(guid)
if teamData then
return teamData:getTeamHandle()
else
local notDataTeam=xianjieModel:getNotDataMarchTeam(guid)
if notDataTeam then

local teamHandleId=notDataTeam.teamHandleID
return xianjieController:getXJTeamHandle(teamHandleId)
end
end
end,
[xjWaiPiaBaseType.eStation]=function(guid)
local teamData=xianjieModel:getSelfStationTeamData(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
return xianjieController:getXJTeamHandle(teamHandleId)
end
end,
[xjWaiPiaBaseType.eJiJIe]=function(guid)
local teamData=xianjieModel:getSelfJiJieTeamData(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
return xianjieController:getXJTeamHandle(teamHandleId)
end
end,
[xjWaiPiaBaseType.eYuanZhu]=function(guid)
local teamData=xianjieModel:getSelfYuanJunTeamData(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
return xianjieController:getXJTeamHandle(teamHandleId)
end
end,
[xjWaiPiaBaseType.eArena]=function(guid)
local teamData=xianjieModel:getArenaZJTeamData(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
return xianjieController:getXJTeamHandle(teamHandleId)
end
end,
[xjWaiPiaBaseType.eMoGong]=function(guid)
local teamData=xianjieModel:getMoGongZJTeamData(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
return xianjieController:getXJTeamHandle(teamHandleId)
end
end,
[xjWaiPiaBaseType.eDefendXianMeng]=function(guid)
local teamData=xianjieModel:getSelfDefendXianMengTeamData(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
return xianjieController:getXJTeamHandle(teamHandleId)
end
end,
[xjWaiPiaBaseType.eMoJun]=function(guid)
local teamData=xianjieModel:getSelfMoJunTeamData(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
return xianjieController:getXJTeamHandle(teamHandleId)
end
end,
[xjWaiPiaBaseType.eYuanZhu_MJ]=function(guid)
local teamData=xianjieModel:getSelfYuanJunTeamData_MoJie(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
return xianjieController:getXJTeamHandle(teamHandleId)
end
end,
[xjWaiPiaBaseType.eMoGong_ZHG]=function(guid)
local teamData=xianjieModel:getMGZDBuildZJTeamData(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
return xianjieController:getXJTeamHandle(teamHandleId)
end
end,
[xjWaiPiaBaseType.eMoGong_HLT]=function(guid)
local teamData=xianjieModel:getMGZDBuildZJTeamData(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
return xianjieController:getXJTeamHandle(teamHandleId)
end
end,
[xjWaiPiaBaseType.eYuanZhu_MG]=function(guid)
local teamData=xianjieModel:getSelfYuanJunTeamData_MoGong(guid)
if teamData then
local teamHandleId=teamData.teamHandleId
return xianjieController:getXJTeamHandle(teamHandleId)
end
end,
}

function xianjieModel:handleWaiPaiData(v)
v.refreshData=function(self_,d)
self_.guidlistlen=d.guidlistlen
self_.guidList=d.guidList
self_.moneylistlen=d.moneylistlen
self_.moneyList=d.moneyList
self_.paramlistlen=d.paramlistlen
self_.paramList=d.paramList
end

v.getQBEntityData=function(self_)
if self_.occupytype==xjWaiPiaBaseType.eMarckTeam then
local teamData=self_:getMarchTeamData()
if teamData and teamData.infoguid then
local entityType=xianjieModel:getEntityTypeByGuid(teamData.infoguid,teamData.sceneidx)
if entityType==xjServerEnityType.eClientBuild then
if xianjieModel:isMoJunBuild(teamData.infoguid)then
return xianjieModel:getMoJunEntityData()
elseif xianjieModel:checkClientBdIsBenYuanZhenJiByGuid(teamData.infoguid)then
return xianjieModel:findBenYuanZhenJiDataByBuildId(teamData.infoguid)
end
elseif entityType==xjServerEnityType.eMoJingZhenJi_Normal then
return xianjieModel:getPuTongZhenJiData(teamData.infoguid)
elseif entityType==xjServerEnityType.eLingShou then
return xianjieModel:getXJLingShouData(teamData.infoguid)
else
return xianjieModel:getMonsterData(teamData.infoguid)
end
elseif teamData and teamData.tarcbid then
return xianjieModel:getMonsterData(teamData.tarcbid)
elseif teamData and teamData.taractorid then
return xianjieModel:getZongMenData(teamData.taractorid)
elseif teamData and teamData.buildingId then
if xianjieModel:checkClientBdIsBenYuanZhenJiByGuid(teamData.buildingId)then
return xianjieModel:findBenYuanZhenJiDataByBuildId(teamData.buildingId)
end
end
elseif self_.occupytype==xjWaiPiaBaseType.eStation then
local teamData=xianjieModel:getSelfStationTeamData(self_.guid)
if teamData then
return teamData
else
return xianjieModel:getStationData(self_.guid)
end
elseif self_.occupytype==xjWaiPiaBaseType.eJiJIe then
return xianjieModel:getSelfJiJieTeamData(self_.guid)
elseif self_.occupytype==xjWaiPiaBaseType.eYuanZhu then
return xianjieModel:getSelfYuanJunTeamData(self_.guid)
elseif self_.occupytype==xjWaiPiaBaseType.eArena then
return xianjieModel:getArenaZJTeamData(self_.guid)
elseif self_.occupytype==xjWaiPiaBaseType.eMoGong then
return xianjieModel:getMoGongZJTeamData(self_.guid)
elseif self_.occupytype==xjWaiPiaBaseType.eDefendXianMeng then
return xianjieModel:getSelfDefendXianMengTeamData(self_.guid)
elseif self_.occupytype==xjWaiPiaBaseType.eMoJun then
return xianjieModel:getSelfMoJunTeamData(self_.guid)
elseif self_.occupytype==xjWaiPiaBaseType.eYuanZhu_MJ then
return xianjieModel:getSelfYuanJunTeamData_MoJie(self_.guid)
elseif self_.occupytype==xjWaiPiaBaseType.eMoGong_ZHG then
return xianjieModel:getMGZDBuildZJTeamData(self_.guid)
elseif self_.occupytype==xjWaiPiaBaseType.eMoGong_HLT then
return xianjieModel:getMGZDBuildZJTeamData(self_.guid)
elseif self_.occupytype==xjWaiPiaBaseType.eYuanZhu_MG then
return xianjieModel:getSelfYuanJunTeamData_MoGong(self_.guid)
end
end
v.getMarchTeamData=function(self_)
if self_.occupytype==xjWaiPiaBaseType.eMarckTeam then
return xianjieModel:getMarchTeamData(self_.guid)
end
end
v.getTeamHandle=function(self_)
if self_.occupytype and getTeamHandleFunc[self_.occupytype]then
return getTeamHandleFunc[self_.occupytype](self_.guid)
end
end
end

function xianjieModel:getDZState_WaiPai(discipleGuidStr,showDesc)

local guidInt64=int64.new(discipleGuidStr)
local dzState=xianjieModel:getDzXJOccupyType(guidInt64)
local isOccupy=dzState~=nil
if isOccupy then
local stateStr
if showDesc then
stateStr="占用中"
if dzState==xjWaiPiaBaseType.eMarckTeam or dzState==xjWaiPiaBaseType.eYuanZhu or dzState==xjWaiPiaBaseType.eMoJun then
stateStr="派遣中"
elseif dzState==xjWaiPiaBaseType.eStation then
stateStr="驻扎中"
elseif dzState==xjWaiPiaBaseType.eDefendXianMeng then
stateStr="驻守中"
end
end
return 4,stateStr
end

if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
for occupytype,lp in pairs(baseWaiPaiDatas)do
for guid_str,data in pairs(lp)do
for index=1,data.guidlistlen do
local v=data.guidList[index]
if discipleGuidStr==tostring(v)then
local desc
if showDesc then
desc='外派中'
end
return 4,desc
end
end
end
end
end
end
end


function xianjieModel:initBaseWaiPaiDatas(list)











if self.baseData==nil then return end
local baseWaiPaiDatas={}
if list~=nil then
for i,v in ipairs(list)do
local lp=baseWaiPaiDatas[v.occupytype]
if lp==nil then
lp={}
baseWaiPaiDatas[v.occupytype]=lp
end
v.guid_str=tostring(v.guid)
xianjieModel:handleWaiPaiData(v)
local teamData
teamData=v:getMarchTeamData()
if teamData then
teamData:markMyWaiPai()
elseif v.occupytype==xjWaiPiaBaseType.eMarckTeam then
xianjieModel:refreshNotDataMarchTeam(v,true)
end
if v.occupytype==xjWaiPiaBaseType.eJiJIe then

xianjieModel:refreshSelfJiJieTeamData(v,true)
elseif v.occupytype==xjWaiPiaBaseType.eYuanZhu then

xianjieModel:refreshSelfYuanJunTeamData(v,true)
elseif v.occupytype==xjWaiPiaBaseType.eStation then

xianjieModel:refreshSelfStationTeamData(v,true)
elseif v.occupytype==xjWaiPiaBaseType.eArena then

xianjieModel:refreshArenaZJTeamData(v,true)
elseif v.occupytype==xjWaiPiaBaseType.eMoGong then

xianjieModel:refreshMoGongZJTeamData(v,true)
elseif v.occupytype==xjWaiPiaBaseType.eDefendXianMeng then

xianjieModel:refreshSelfDefendXianMengTeamData(v,true)
elseif v.occupytype==xjWaiPiaBaseType.eMoJun then

xianjieModel:refreshSelfMoJunTeamData(v,true)
elseif v.occupytype==xjWaiPiaBaseType.eYuanZhu_MJ then

xianjieModel:refreshSelfYuanJunTeamData_MoJie(v,true)
elseif v.occupytype==xjWaiPiaBaseType.eMoGong_ZHG then

xianjieModel:refreshMGZDBuildZJTeamData(v,true)
elseif v.occupytype==xjWaiPiaBaseType.eMoGong_HLT then

xianjieModel:refreshMGZDBuildZJTeamData(v,true)
elseif v.occupytype==xjWaiPiaBaseType.eYuanZhu_MG then

xianjieModel:refreshSelfYuanJunTeamData_MoGong(v,true)
end
lp[v.guid_str]=v

if v.boatid and v.boatid~=0 then
YingXianGeModel:setXJChuZhenInfo(v.boatid,v)
xianjieModel:setXJYZChuZhenTeamList(v.boatid,v.guidList)
xianjieModel:checkXJYZChuZhenTeamResetYzData(v.boatid)
XianYunGangModel:setBoatShow(v.boatid)
end
xianjieModel:setXJDzOccupyTypeList(v.occupytype,v.guidList)
end

end
self.baseData.baseWaiPaiDatas=baseWaiPaiDatas
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eInit)
end

function xianjieModel:checkIsWaiPaiIng(sceneIdx)
if self.baseData and self.baseData.baseWaiPaiDatas then
local occupytype=1
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas[occupytype]then
local data=baseWaiPaiDatas[occupytype]
for k,v in pairs(data)do
if v and v.occupytype==1 then
if sceneIdx then

local isMoJieScene=xianjienSceneIndexType:isMoJie(sceneIdx)
local isMoJieWaiPai=xianjienSceneIndexType:isMoJie(v.sceneidx)
if isMoJieScene==isMoJieWaiPai then

return false
end
else

return false
end

end
end
end
end
return true
end

function xianjieModel:getWaiPaiData(occupytype,guid)
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
local lp=baseWaiPaiDatas[occupytype]
if lp then
local guid_str=tostring(guid)
return lp[guid_str]
end
end
end
end

function xianjieModel:checkInBaseWaiPai(occupytype,guid)
return xianjieModel:getWaiPaiData(occupytype,guid)~=nil
end

function xianjieModel:refreshBaseWaiPaiData(v)
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
local lp=baseWaiPaiDatas[v.occupytype]
if lp==nil then
lp={}
baseWaiPaiDatas[v.occupytype]=lp
end
v.guid_str=tostring(v.guid)
local d=lp[v.guid_str]
if d==nil then
xianjieModel:handleWaiPaiData(v)
lp[v.guid_str]=v
local teamData=v:getMarchTeamData()
if teamData then
teamData:markMyWaiPai()

teamData:playBattleResult()
elseif v.occupytype==xjWaiPiaBaseType.eMarckTeam then
local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshNotDataMarchTeam(v,isInit)
end
if v.occupytype==xjWaiPiaBaseType.eJiJIe then

local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshSelfJiJieTeamData(v,isInit)
elseif v.occupytype==xjWaiPiaBaseType.eYuanZhu then

local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshSelfYuanJunTeamData(v,isInit)
elseif v.occupytype==xjWaiPiaBaseType.eStation then

local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshSelfStationTeamData(v,isInit)
elseif v.occupytype==xjWaiPiaBaseType.eArena then

local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshArenaZJTeamData(v,isInit)
elseif v.occupytype==xjWaiPiaBaseType.eMoGong then

local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshMoGongZJTeamData(v,isInit)
elseif v.occupytype==xjWaiPiaBaseType.eDefendXianMeng then
local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshSelfDefendXianMengTeamData(v,isInit)
elseif v.occupytype==xjWaiPiaBaseType.eMoJun then
local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshSelfMoJunTeamData(v,isInit)
elseif v.occupytype==xjWaiPiaBaseType.eYuanZhu_MJ then

local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshSelfYuanJunTeamData_MoJie(v,isInit)
elseif v.occupytype==xjWaiPiaBaseType.eMoGong_ZHG then

local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshMGZDBuildZJTeamData(v,isInit)
elseif v.occupytype==xjWaiPiaBaseType.eMoGong_HLT then

local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshMGZDBuildZJTeamData(v,isInit)
elseif v.occupytype==xjWaiPiaBaseType.eYuanZhu_MG then

local checkInit=xianjieModel:checkInitMapData()
local isInit=not checkInit
xianjieModel:refreshSelfYuanJunTeamData_MoGong(v,isInit)
end
local teamHandle=v:getTeamHandle()
xianjieModel:setXJDzOccupyTypeList(v.occupytype,v.guidList)
d=lp[v.guid_str]
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eAdd,teamHandle)
else
d:refreshData(v)
if d.occupytype==xjWaiPiaBaseType.eJiJIe then
xianjieModel:refreshSelfJiJieTeamData(d)
elseif d.occupytype==xjWaiPiaBaseType.eYuanZhu then
xianjieModel:refreshSelfYuanJunTeamData(d)
elseif d.occupytype==xjWaiPiaBaseType.eArena then
xianjieModel:refreshArenaZJTeamData(d)
elseif d.occupytype==xjWaiPiaBaseType.eMoGong then
xianjieModel:refreshMoGongZJTeamData(d)
elseif v.occupytype==xjWaiPiaBaseType.eDefendXianMeng then
xianjieModel:refreshSelfDefendXianMengTeamData(d)
elseif d.occupytype==xjWaiPiaBaseType.eMoJun then
xianjieModel:refreshSelfMoJunTeamData(d)
elseif d.occupytype==xjWaiPiaBaseType.eYuanZhu_MJ then
xianjieModel:refreshSelfYuanJunTeamData_MoJie(d)
elseif d.occupytype==xjWaiPiaBaseType.eMoGong_ZHG then
xianjieModel:refreshMGZDBuildZJTeamData(d)
elseif d.occupytype==xjWaiPiaBaseType.eMoGong_HLT then
xianjieModel:refreshMGZDBuildZJTeamData(d)
elseif d.occupytype==xjWaiPiaBaseType.eYuanZhu_MG then
xianjieModel:refreshSelfYuanJunTeamData_MoGong(d)
end
end
if d.boatid and d.boatid~=0 then
YingXianGeModel:setXJChuZhenInfo(d.boatid,d)
xianjieModel:setXJYZChuZhenTeamList(d.boatid,d.guidList)
XianYunGangModel:setBoatShow(d.boatid)
end
end
end
end

function xianjieModel:removeBaseWaiPaiData(occupytype,guid,teamHandleID,boatid,isIgnoreSelfTeam,isChangeTeamOccupy)
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
local lp=baseWaiPaiDatas[occupytype]
if lp then
local guid_str=tostring(guid)
local wpData=lp[guid_str]
local isNotDataTeam=false

if wpData then
if not teamHandleID then

if occupytype==xjWaiPiaBaseType.eMarckTeam then
local marchData=xianjieModel:getMarchTeamData(guid)
if marchData then
local teamHandle=marchData:getTeamHandle()
teamHandleID=teamHandle.m_ID
else
local notDataTeam=xianjieModel:getNotDataMarchTeam(guid)
if notDataTeam then

teamHandleID=notDataTeam.teamHandleID
isNotDataTeam=true
end
end
elseif occupytype==xjWaiPiaBaseType.eStation then
local teamData=xianjieModel:getSelfStationTeamData(guid)
if teamData then
teamHandleID=teamData.teamHandleId
end
elseif occupytype==xjWaiPiaBaseType.eJiJIe then
local teamData=xianjieModel:getSelfJiJieTeamData(guid)
if teamData then
teamHandleID=teamData.teamHandleId
end
elseif occupytype==xjWaiPiaBaseType.eYuanZhu then
local teamData=xianjieModel:getSelfYuanJunTeamData(guid)
if teamData then
teamHandleID=teamData.teamHandleId
end
elseif occupytype==xjWaiPiaBaseType.eArena then
local teamData=xianjieModel:getArenaZJTeamData(guid)
if teamData then
teamHandleID=teamData.teamHandleId
end
elseif occupytype==xjWaiPiaBaseType.eMoGong then
local teamData=xianjieModel:getMoGongZJTeamData(guid)
if teamData then
teamHandleID=teamData.teamHandleId
end
elseif occupytype==xjWaiPiaBaseType.eDefendXianMeng then
local teamData=xianjieModel:getSelfDefendXianMengTeamData(guid)
if teamData then
teamHandleID=teamData.teamHandleId
end
elseif occupytype==xjWaiPiaBaseType.eMoJun then
local teamData=xianjieModel:getSelfMoJunTeamData(guid)
if teamData then
teamHandleID=teamData.teamHandleId
end
elseif occupytype==xjWaiPiaBaseType.eYuanZhu_MJ then
local teamData=xianjieModel:getSelfYuanJunTeamData_MoJie(guid)
if teamData then
teamHandleID=teamData.teamHandleId
end
elseif occupytype==xjWaiPiaBaseType.eMoGong_ZHG then
local teamData=xianjieModel:getMGZDBuildZJTeamData(guid)
if teamData then
teamHandleID=teamData.teamHandleId
end
elseif occupytype==xjWaiPiaBaseType.eMoGong_HLT then
local teamData=xianjieModel:getMGZDBuildZJTeamData(guid)
if teamData then
teamHandleID=teamData.teamHandleId
end
elseif occupytype==xjWaiPiaBaseType.eYuanZhu_MG then
local teamData=xianjieModel:getSelfYuanJunTeamData_MoGong(guid)
if teamData then
teamHandleID=teamData.teamHandleId
end
end
end

if not isNotDataTeam and occupytype==xjWaiPiaBaseType.eMarckTeam and not isIgnoreSelfTeam then
xianjieModel:removeMarchTeamData(guid,true)
elseif occupytype==xjWaiPiaBaseType.eJiJIe and not isIgnoreSelfTeam then
xianjieModel:removeSelfJiJieTeamData(guid)
elseif occupytype==xjWaiPiaBaseType.eYuanZhu and not isIgnoreSelfTeam then
xianjieModel:removeSelfYuanJunTeamData(guid)
elseif occupytype==xjWaiPiaBaseType.eStation and not isIgnoreSelfTeam then
xianjieModel:removeSelfStationTeamData(guid)
elseif occupytype==xjWaiPiaBaseType.eArena and not isIgnoreSelfTeam then
xianjieModel:removeArenaZJTeamData(guid)
elseif occupytype==xjWaiPiaBaseType.eMoGong and not isIgnoreSelfTeam then
xianjieModel:removeMoGongZJTeamData(guid)
elseif occupytype==xjWaiPiaBaseType.eDefendXianMeng and not isIgnoreSelfTeam then
xianjieModel:removeSelfDefendXianMengTeamData(guid)
elseif isNotDataTeam and occupytype==xjWaiPiaBaseType.eMarckTeam and not isIgnoreSelfTeam then
xianjieModel:removeNotDataMarchTeam(guid)
elseif occupytype==xjWaiPiaBaseType.eMoJun and not isIgnoreSelfTeam then
xianjieModel:removeSelfMoJunTeamData(guid)
elseif occupytype==xjWaiPiaBaseType.eYuanZhu_MJ and not isIgnoreSelfTeam then
xianjieModel:removeSelfYuanJunTeamData_MoJie(guid)
elseif occupytype==xjWaiPiaBaseType.eMoGong_ZHG and not isIgnoreSelfTeam then
xianjieModel:removeMGZDBuildZJTeamData(guid,occupytype)
elseif occupytype==xjWaiPiaBaseType.eMoGong_HLT and not isIgnoreSelfTeam then
xianjieModel:removeMGZDBuildZJTeamData(guid,occupytype)
elseif occupytype==xjWaiPiaBaseType.eYuanZhu_MG and not isIgnoreSelfTeam then
xianjieModel:removeSelfYuanJunTeamData_MoGong(guid,occupytype)
end
boatid=boatid or wpData.boatid
local dzList=wpData.guidList
lp[guid_str]=nil
if boatid and boatid~=0 then
YingXianGeModel:removeXJChuZhenInfo(boatid)
xianjieModel:removeXJYZChuZhenTeamList(boatid)
xianjieModel:clearJiJieSelfMassYBDCdStampByMassGuid(guid)
XianYunGangModel:setBoatShow(boatid)
end
xianjieModel:setXJDzOccupyTypeList(nil,dzList)
notifySystem:postNotify(notifyConfig.onXianJieWaiPaiChange,CHANGE_TYPE.eDelete,teamHandleID,isChangeTeamOccupy)
end
end
end
end
end

function xianjieModel:checkMarchBaseWaiPaiData(sceneidx)
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
local checkOccupyType=xjWaiPiaBaseType.eMarckTeam
local lp=baseWaiPaiDatas[checkOccupyType]
if lp==nil then
return
end
local isMoJie_original=xianjienSceneIndexType:isMoJie(sceneidx)
for guid_str,v in pairs(lp)do
local dataSceneidx=v.sceneidx or xianjienSceneIndexType.eXianJie
local isMoJie=xianjienSceneIndexType:isMoJie(dataSceneidx)
if isMoJie~=isMoJie_original then
local guid=v.guid
xianjieModel:refreshNotDataMarchTeam(v)
end
end
end
end
end
function xianjieModel:getWaiPaiTeamNum()
local num=0
num=num+xianjieModel:getWaiPaiTeamNum_plot()
num=num+xianjieModel:getWaiPaiTeamNum_base()
num=num+xianjieModel:getWaiPaiTeamNum_ResPoint()
return num
end

function xianjieModel:getWaiPaiTeamNumEx()
local num=0
num=num+xianjieModel:getWaiPaiTeamNum_plot()
num=num+xianjieModel:getWaiPaiTeamNum_baseEx()
num=num+xianjieModel:getWaiPaiTeamNum_ResPoint()
return num
end


function xianjieModel:getWaiPaiTeamCanMaxNum()
local max=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'max')
max=max+xianjieModel:getWaiPaiTeamMaxExtraNum()
return max
end

function xianjieModel:getWaiPaiTeamMaxNum()
local max=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'max')
max=max+xianjieModel:getWaiPaiTeamUnlockNum()
return max
end


function xianjieModel:getWaiPaiTeamUnlockNum()









local extraNum=0

if xianjieModel:getCloudIsRecvQueue()then
extraNum=extraNum+1
end


if seasonController:checkSeasonHandleComplete(0)or xianjieModel:getCJXYIsRecvQueue()then
extraNum=extraNum+1
end

return extraNum
end


function xianjieModel:getWaiPaiTeamMaxExtraNum()
local extraNum=2
return extraNum
end

function xianjieModel:getWaiPaiTeamNum_ResPoint()
local marshs=xianjieModel:getAllResPointMarch()
local num=0
for i,v in pairs(marshs)do
local dDataType=v:getMarchData("dDataType")
if dDataType~=xjResPointMarchTeamType.eData then
num=num+1
end
end
return num
end

function xianjieModel:getWaiPaiTeamNum_plot()
local num=0
local lp=xianjieModel:getCloudLookup()
if lp then
for cloudid,cloudData in pairs(lp)do
if cloudData.hasDZ and not cloudData:isSearchBack()then
num=num+1
end
local cloudPlotlp=cloudData.cloudPlotlp
for plotIdx,cloudPlotData in pairs(cloudPlotlp)do
local state=cloudData:checkCloudPlotState(plotIdx)
if xjCloudPlotStateType:checkDoing(state)then
num=num+1
end
end
end
end
return num
end

function xianjieModel:getWaiPaiTeamNum_base()
local num=0
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
for occupytype,lp in pairs(baseWaiPaiDatas)do
for guid_str,wpData in pairs(lp)do
local teamHandle=wpData:getTeamHandle()
if teamHandle then
num=num+1
end
end
end
end
end
return num
end

function xianjieModel:getWaiPaiTeamNum_baseEx()
local num=0
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
for occupytype,lp in pairs(baseWaiPaiDatas)do
for guid_str,wpData in pairs(lp)do
num=num+1
end
end
end
end
return num
end

function xianjieModel:checkWaiPaiTeamNum(isWarning)
local num=xianjieModel:getWaiPaiTeamNum()
local max=xianjieModel:getWaiPaiTeamMaxNum()
if num>=max then
if isWarning then
UIManager.error(FMT.fmt('最多外派{0}支队伍',max))
local unlockTeamCount=xianjieModel:getWaiPaiTeamUnlockNum()
local maxExtraTeamCount=xianjieModel:getWaiPaiTeamMaxExtraNum()
if unlockTeamCount<maxExtraTeamCount then

local args={}
args.titleName='队伍拓展'
args.showClose=false
args.pos=2
args.extraWin='UIXianJie_extraTeamGainWin'


local extraParams={}
args.extraParams=extraParams

UIManager:showWindow('UICommonPageWin',args)
end
end
return false
end
return true
end


function xianjieModel:getAllWaiPaiTeamHandle()
local list={}
local lp=xianjieModel:getCloudLookup()
if lp then
for cloudid,cloudData in pairs(lp)do
if cloudData.hasDZ and not cloudData:isSearchBack()then
local teamHandle=cloudData:getTeamHandle()
if teamHandle then
table.insert(list,teamHandle)
end
end
for plotIdx,cloudPlotData in pairs(cloudData.cloudPlotlp)do
local state=cloudData:checkCloudPlotState(plotIdx)
if xjCloudPlotStateType:checkDoing(state)then
local teamHandle
if state==xjCloudPlotStateType.eRetract then
teamHandle=cloudPlotData:getTeamHandle_retract()
else
teamHandle=cloudPlotData:getTeamHandle()
end
if teamHandle then
table.insert(list,teamHandle)
end
end
end
end
end
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
for occupytype,lp in pairs(baseWaiPaiDatas)do
for guid_str,wpData in pairs(lp)do
local teamHandle
if occupytype==xjWaiPiaBaseType.eJiJIe then
local teamData=xianjieModel:getSelfJiJieTeamData(wpData.guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
elseif occupytype==xjWaiPiaBaseType.eYuanZhu then
local teamData=xianjieModel:getSelfYuanJunTeamData(wpData.guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
elseif occupytype==xjWaiPiaBaseType.eStation then
local teamData=xianjieModel:getSelfStationTeamData(wpData.guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
else
teamHandle=wpData:getTeamHandle()
end
elseif occupytype==xjWaiPiaBaseType.eArena then
local teamData=xianjieModel:getArenaZJTeamData(wpData.guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
elseif occupytype==xjWaiPiaBaseType.eMoGong then
local teamData=xianjieModel:getMoGongZJTeamData(wpData.guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
elseif occupytype==xjWaiPiaBaseType.eDefendXianMeng then
local teamData=xianjieModel:getSelfDefendXianMengTeamData(wpData.guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
elseif occupytype==xjWaiPiaBaseType.eMoJun then
local teamData=xianjieModel:getSelfMoJunTeamData(wpData.guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
elseif occupytype==xjWaiPiaBaseType.eYuanZhu_MJ then
local teamData=xianjieModel:getSelfYuanJunTeamData_MoJie(wpData.guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
elseif occupytype==xjWaiPiaBaseType.eMoGong_ZHG then
local teamData=xianjieModel:getMGZDBuildZJTeamData(wpData.guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
elseif occupytype==xjWaiPiaBaseType.eMoGong_HLT then
local teamData=xianjieModel:getMGZDBuildZJTeamData(wpData.guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
elseif occupytype==xjWaiPiaBaseType.eYuanZhu_MG then
local teamData=xianjieModel:getSelfYuanJunTeamData_MoGong(wpData.guid)
if teamData then
local teamHandleId=teamData.teamHandleId
teamHandle=xianjieController:getXJTeamHandle(teamHandleId)
end
else
teamHandle=wpData:getTeamHandle()
end
if teamHandle then
table.insert(list,teamHandle)
end
end
end
end
end

local rpMarchTeam=xianjieModel:getAllResPointWaiPaiTeamHandle()
for index,teamHandle in ipairs(rpMarchTeam)do
table.insert(list,teamHandle)
end

local mojunBoxMarchTeam=xianjieModel:getAllMoJunBoxWaiPaiTeamHandle()
for index,teamHandle in ipairs(mojunBoxMarchTeam)do
table.insert(list,teamHandle)
end

return list
end


function xianjieModel:getWaiPaiByQBEntityData(ent_guid)
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
for occupytype,lp in pairs(baseWaiPaiDatas)do
for guid_str,wpData in pairs(lp)do
local entityData=wpData:getQBEntityData()
if entityData then
if entityData.compareKey and entityData:compareKey(ent_guid)then
return wpData
end
end
end
end
end
end
end

function xianjieModel:getWaiPaiByQBEntityData2(occupytype,ent_guid)
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
local lp=baseWaiPaiDatas[occupytype]
if lp then
for guid_str,wpData in pairs(lp)do
local entityData=wpData:getQBEntityData()
if entityData then
if entityData.compareKey and entityData:compareKey(ent_guid)then
return wpData
end
end
end
end
end
end
end


function xianjieModel:getWaiPaiByQBEntityData3(occupytype,ent_guid)
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
local lp=baseWaiPaiDatas[occupytype]
if lp then
for guid_str,wpData in pairs(lp)do
local entityData=wpData:getQBEntityData()
local teamData=wpData:getMarchTeamData()
if entityData and teamData then
if entityData.compareKey and entityData:compareKey(ent_guid)and playerModel:checkActorId(teamData.actorid)then
return wpData
end
end
end
end
end
end
end

function xianjieModel:getOnlyWaiPaiTeamData()
local list={}
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
for occupytype,lp in pairs(baseWaiPaiDatas)do
for guid_str,wpData in pairs(lp)do
local teamData
if occupytype==xjWaiPiaBaseType.eJiJIe then
teamData=xianjieModel:getSelfJiJieTeamData(wpData.guid)
elseif occupytype==xjWaiPiaBaseType.eYuanZhu then
teamData=xianjieModel:getSelfYuanJunTeamData(wpData.guid)
elseif occupytype==xjWaiPiaBaseType.eStation then
teamData=xianjieModel:getSelfStationTeamData(wpData.guid)
elseif occupytype==xjWaiPiaBaseType.eArena then
teamData=xianjieModel:getArenaZJTeamData(wpData.guid)
elseif occupytype==xjWaiPiaBaseType.eMoGong then
teamData=xianjieModel:getMoGongZJTeamData(wpData.guid)
elseif occupytype==xjWaiPiaBaseType.eDefendXianMeng then
teamData=xianjieModel:getSelfDefendTeamData(wpData.guid)
elseif occupytype==xjWaiPiaBaseType.eMarckTeam then
teamData=xianjieModel:getMarchTeamData(wpData.guid)
if not teamData then
teamData=xianjieModel:getNotDataMarchTeam(wpData.guid)
end
elseif occupytype==xjWaiPiaBaseType.eMoJun then
teamData=xianjieModel:getSelfMoJunTeamData(wpData.guid)
elseif occupytype==xjWaiPiaBaseType.eYuanZhu_MJ then
teamData=xianjieModel:getSelfYuanJunTeamData_MoJie(wpData.guid)
elseif occupytype==xjWaiPiaBaseType.eMoGong_ZHG then
teamData=xianjieModel:getMGZDBuildZJTeamData(wpData.guid)
elseif occupytype==xjWaiPiaBaseType.eMoGong_HLT then
teamData=xianjieModel:getMGZDBuildZJTeamData(wpData.guid)
elseif occupytype==xjWaiPiaBaseType.eYuanZhu_MG then
teamData=xianjieModel:getSelfYuanJunTeamData_MoGong(wpData.guid)
end
if teamData then
table.insert(list,{teamData=teamData,occupytype=occupytype})
end
end
end
end
end
return list
end

function xianjieModel:getOnlyWaiPaiTeamInfo()
local list={}
if self.baseData then
local baseWaiPaiDatas=self.baseData.baseWaiPaiDatas
if baseWaiPaiDatas then
for occupytype,lp in pairs(baseWaiPaiDatas)do
for guid_str,wpData in pairs(lp)do
table.insert(list,wpData)
end
end
end
end
return list
end



function xianjieModel:test_setWaiPaiTeamUnlockNum(num)
if not self.baseData then
return
end
self.baseData.unLockTeamCount=num
UIManager:invokeUIMethod("UIXianJieMainWin","refreshTeamPanel")
end


function xianjieModel:test_printAllWaiPaiTeamData()
local teamHandleList=xianjieModel:getAllWaiPaiTeamHandle()
local teamDataList={}
for i,teamHandle in ipairs(teamHandleList)do
teamDataList[i]=teamHandle.teamData
end
logErr(FMT.fmt("测试打印 仙界当前队伍占用数据：{0}",serializeHelper.serialize(teamDataList)))
end