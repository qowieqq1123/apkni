
function xianjieModel:initAllMoGongDatas()
xianjieModel:clearData_allMoGong()
self.allMoGongDatas={}
self.allMoGongCreateEntFlag={}
self.allMoGongRangeDatas={}
end

function xianjieModel:clearData_allMoGong()
if self.allMoGongDatas and next(self.allMoGongDatas)then
for i,data in pairs(self.allMoGongDatas)do
xianjieController:removeXJClass(data)
end
self.allMoGongDatas=nil
self.allMoGongCreateEntFlag=nil
end
if self.allMoGongRangeDatas and next(self.allMoGongRangeDatas)then
for i,data in pairs(self.allMoGongRangeDatas)do
xianjieController:removeXJClass(data)
end
self.allMoGongRangeDatas=nil
end
end

function xianjieModel:clearData_moGong_byMoGongId(moGongId)
if self.allMoGongDatas and self.allMoGongDatas[moGongId]then
local data=self.allMoGongDatas[moGongId]
xianjieController:removeXJClass(data)
self.allMoGongDatas[moGongId]=nil
self.allMoGongCreateEntFlag[moGongId]=nil
end
if self.allMoGongRangeDatas and self.allMoGongRangeDatas[moGongId]then
local data=self.allMoGongRangeDatas[moGongId]
xianjieController:removeXJClass(data)
self.allMoGongRangeDatas[moGongId]=nil
end
end


function xianjieModel:createMoGongData(moGongId)
if not self.allMoGongDatas then
self:initAllMoGongDatas()
end

if not self.moGongZJTeamDatas then
self:initMoGongZJTeamDatas()
end

if not self.allMoGongDatas[moGongId]and initProControl:isDoneKF()and xianjieModel:checkInit()then
self.allMoGongDatas[moGongId]=xianjieController:createXJClass(xjDataType.eMoGong,{moGongId=moGongId})
self.allMoGongRangeDatas[moGongId]=xianjieController:createXJClass(xjDataType.eMoGongRange,{moGongId=moGongId})
return true
end
end

function xianjieModel:getMoGongDataByMoGongId(moGongId)
if not self.allMoGongDatas then
return nil
end

return self.allMoGongDatas[moGongId]
end

function xianjieModel:getMoGongRangeDataByMoGongId(moGongId)
if not self.allMoGongRangeDatas then
return nil
end

return self.allMoGongRangeDatas[moGongId]
end

function xianjieModel:getMoGongDataList()
return self.allMoGongDatas
end

function xianjieModel:checkClientBdIsMoGongByGuid(guid)
local guidNum=mathHelper.int64_to_number(guid)
return guidNum==xjClientBuildType.flcbMoGong1
end

function xianjieModel:checkClientBdIsMoGongByBuildId(buildId)
return buildId==xjClientBuildType.flcbMoGong1
end

function xianjieModel:createAllMoGongEntities(needRefreshAOI)
local lp=self.allMoGongDatas
if lp then
for moGongId,data in pairs(lp)do
if not self.allMoGongCreateEntFlag[moGongId]then
local ret=data:createEntity(needRefreshAOI)
local ret2=self.allMoGongRangeDatas[moGongId]:createEntity(needRefreshAOI)
if ret then
self.allMoGongCreateEntFlag[moGongId]=true
end
end
end
end
end

function xianjieModel:removeAllMoGongEntities()
local lp=self.allMoGongDatas
if lp then
for moGongId,data in pairs(lp)do
if self.allMoGongCreateEntFlag[moGongId]then
data:removeEntity()
self.allMoGongCreateEntFlag[moGongId]=nil
end
end
end
end


function xianjieModel:clearData_moGongZJTeam()
if self.moGongZJTeamDatas and next(self.moGongZJTeamDatas)then
for i,v in pairs(self.moGongZJTeamDatas)do
local teamHandleId=v.teamHandleId
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.moGongZJTeamDatas=nil
end

function xianjieModel:initMoGongZJTeamDatas()
xianjieModel:clearData_moGongZJTeam()
self.moGongZJTeamDatas={}
end

function xianjieModel:refreshMoGongZJTeamData(v,isInit)
local guid_str=tostring(v.guid)
local teamType=xjTeamHandleType.eMoGongZhuJun
if not self.moGongZJTeamDatas then

return
end

if isInit then

self.moGongZJTeamDatas[guid_str]={data=v}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.moGongZJTeamDatas[guid_str].teamHandleId=teamHandleID
else
local teamData=self.moGongZJTeamDatas[guid_str]
if teamData==nil then

self.moGongZJTeamDatas[guid_str]={data=v}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{guid=v.guid,guid_str=guid_str})
self.moGongZJTeamDatas[guid_str].teamHandleId=teamHandleID
else


self.moGongZJTeamDatas[guid_str].data=v

end
end


end

function xianjieModel:removeMoGongZJTeamData(guid,moGongId)
local guid_str=tostring(guid)
local teamData=self.moGongZJTeamDatas[guid_str]
if teamData~=nil then
local teamHandleID=teamData.teamHandleId
local boatid=teamData.data.boatid
xianjieController:removeXJTeamHandle(teamHandleID)
self.moGongZJTeamDatas[guid_str]=nil
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eMoGong,guid,teamHandleID,boatid,true)
else



end
end

function xianjieModel:getMoGongZJTeamData(guid)
if self.moGongZJTeamDatas then
local guid_str=tostring(guid)
return self.moGongZJTeamDatas[guid_str]
end
end


function xianjieModel:isMoGongAtk(guid)
if xianjieModel:checkClientBdIsMoGongByGuid(guid)then
local isSelfXianYu=false

local moGongId=mathHelper.int64_to_number(guid)
local moGongData=moGongZhengDuoActModel:getArenaBuildData(moGongId)or{}
if moGongData then
local occupySceneIdx=moGongData.xmGuid
local hasOccupy=not mathHelper.validInt64(occupySceneIdx)
if hasOccupy then
local myXm=xianmengModel:getMyXMGuildID()
isSelfXianYu=xianmengModel:compareTwoGuildID(myXm,occupySceneIdx)
end
end
return not isSelfXianYu
end
return false
end



function xianjieModel:checkMoGongOccupyCamp(guid)
local campIndex=0

local moGongId=mathHelper.int64_to_number(guid)
local moGongData=moGongZhengDuoActModel:getArenaBuildData(moGongId)or{}
if moGongData then
local occupySceneIdx=moGongData.xmGuid
local hasOccupy=not mathHelper.validInt64(occupySceneIdx)
if hasOccupy then
local myXm=xianmengModel:getMyXMGuildID()
if xianmengModel:compareTwoGuildID(myXm,occupySceneIdx)then

campIndex=1
else

campIndex=2
end
end
end
return campIndex
end

