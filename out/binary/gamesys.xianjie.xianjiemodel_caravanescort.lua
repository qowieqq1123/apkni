
function xianjieModel:initCaravanEscortDatas()
xianjieModel:clearData_caravanEscort()
xianjieModel:initCaravanEscortEnterData()
xianjieModel:initCaravanEscortHubData()
xianjieModel:initCaravanEscortTeamDatas()
end

function xianjieModel:initCaravanEscortEnterData()
xianjieModel:clearData_caravanEscortEnter()
self.caravanEscortEnterData=nil
self.caravanEscortEnterCreateEntFlag=nil
end

function xianjieModel:initCaravanEscortHubData()
xianjieModel:clearData_allCaravanEscortHub()
self.caravanEscortHubDatas={}
self.caravanEscortHubCreateEntFlag={}
end

function xianjieModel:initCaravanEscortTeamDatas()
xianjieModel:clearData_allCaravanEscortTeam()
self.caravanEscortTeamDatas={}
self.caravanEscortTeamCreateEntFlag={}
end

function xianjieModel:clearData_caravanEscort()
xianjieModel:clearData_caravanEscortEnter()
xianjieModel:clearData_allCaravanEscortHub()
xianjieModel:clearData_allCaravanEscortTeam()
end

function xianjieModel:clearData_caravanEscortEnter()
if self.caravanEscortEnterData then
local data=self.caravanEscortEnterData
xianjieController:removeXJClass(data)
self.caravanEscortEnterData=nil
self.caravanEscortEnterCreateEntFlag=nil
end
end

function xianjieModel:clearData_allCaravanEscortHub()
if self.caravanEscortHubDatas and next(self.caravanEscortHubDatas)then
for i,data in pairs(self.caravanEscortHubDatas)do
xianjieController:removeXJClass(data)
end
self.caravanEscortHubDatas=nil
self.caravanEscortHubCreateEntFlag=nil
end
end

function xianjieModel:clearData_allCaravanEscortTeam()
if self.caravanEscortTeamDatas and next(self.caravanEscortTeamDatas)then
for i,data in pairs(self.caravanEscortTeamDatas)do
xianjieController:removeXJClass(data)
end
self.caravanEscortTeamDatas=nil
self.caravanEscortTeamCreateEntFlag=nil
end
end

function xianjieModel:clearData_caravanEscortTeam_byGuid(guid)
local guidStr=tostring(guid)
if self.caravanEscortTeamDatas and self.caravanEscortTeamDatas[guidStr]then
local data=self.caravanEscortTeamDatas[guidStr]
xianjieController:removeXJClass(data)
self.caravanEscortTeamDatas[guidStr]=nil
self.caravanEscortTeamCreateEntFlag[guidStr]=nil
end
end



function xianjieModel:createCaravanEscortEnterData()
if not self.caravanEscortEnterData then
self:initCaravanEscortEnterData()
end

if not self.caravanEscortEnterData and initProControl:isDoneKF()and xianjieModel:checkInit()then
self.caravanEscortEnterData=xianjieController:createXJClass(xjDataType.eCaravanEscortEnter,{})
return true
end
end

function xianjieModel:getCaravanEscortEnterData()
return self.caravanEscortEnterData
end

function xianjieModel:checkClientBdIsCaravanEscortEnterByGuid(guid)
local guidNum=mathHelper.int64_to_number(guid)
return guidNum==xjClientBuildType.flcbCaravanEscortEnter
end

function xianjieModel:checkClientBdIsCaravanEscortEnterByBuildId(buildId)
return buildId==xjClientBuildType.flcbCaravanEscortEnter
end


function xianjieModel:createCaravanEscortEnterEntities(needRefreshAOI)
if not self.caravanEscortEnterCreateEntFlag then
local data=self.caravanEscortEnterData
if data then
local ret=data:createEntity(needRefreshAOI)
if ret then
self.caravanEscortEnterCreateEntFlag=true
end
end
end
end


function xianjieModel:removeCaravanEscortEnterEntities()
local data=self.caravanEscortEnterData
if self.caravanEscortEnterCreateEntFlag then
data:removeEntity()
self.caravanEscortEnterCreateEntFlag=nil
end
end


function xianjieModel:createCaravanEscortHubData(sceneIdx,posX,posY,hubType)
if not self.caravanEscortHubDatas then
self:initCaravanEscortHubData()
end

local hubKey=string.format("%s_%s_%s",sceneIdx,posX,posY,hubType)
if not self.caravanEscortHubDatas[hubKey]and initProControl:isDoneKF()and xianjieModel:checkInit()then
self.caravanEscortHubDatas[hubKey]=xianjieController:createXJClass(xjDataType.eCaravanEscortHub,{hubSceneIdx=sceneIdx,hubPosX=posX,hubPosY=posY,hubType=hubType})
return true
end
end

function xianjieModel:getCaravanEscortHubDatas()
return self.caravanEscortHubDatas
end

function xianjieModel:getCaravanEscortHubDataByHubKey(hubKey)
if not hubKey or not self.caravanEscortHubDatas then
return
end

if self.caravanEscortHubDatas[hubKey]then
return self.caravanEscortHubDatas[hubKey]
end
end


function xianjieModel:createCaravanEscortHubEntities(needRefreshAOI)
local lp=self.caravanEscortHubDatas
if lp then
for hubKey,data in pairs(lp)do
if not self.caravanEscortHubCreateEntFlag[hubKey]then
local ret=data:createEntity(needRefreshAOI)
if ret then
self.caravanEscortHubCreateEntFlag[hubKey]=true
end
end
end
end
end


function xianjieModel:removeCaravanEscortHubEntities()
local lp=self.caravanEscortHubDatas
if lp then
for hubKey,data in pairs(lp)do
if self.caravanEscortHubCreateEntFlag[hubKey]then
data:removeEntity()
self.caravanEscortHubCreateEntFlag[hubKey]=nil
end
end
end
end


function xianjieModel:createCaravanEscortTeamData(data)
if not self.caravanEscortTeamDatas then
self:initCaravanEscortTeamDatas()
end

local guidStr=data.guidStr
if not self.caravanEscortTeamDatas[guidStr]and initProControl:isDoneKF()and xianjieModel:checkInit()then
self.caravanEscortTeamDatas[guidStr]=xianjieController:createXJClass(xjDataType.eCaravanEscortTeam,data)
return true
end
return false
end

function xianjieModel:refreshCaravanEscortTeamData(data)
if not self.caravanEscortTeamDatas then
return
end

local guidStr=data.guidStr
if self.caravanEscortTeamDatas[guidStr]then
local entityData=self.caravanEscortTeamDatas[guidStr]
entityData:refreshData(data)
end
end

function xianjieModel:createCaravanEscortTeamEntities(needRefreshAOI)
local lp=self.caravanEscortTeamDatas
if lp then
for guidStr,data in pairs(lp)do
if not self.caravanEscortTeamCreateEntFlag[guidStr]then
local ret=data:createEntity(needRefreshAOI)
if ret then
self.caravanEscortTeamCreateEntFlag[guidStr]=true
end
end
end
end
end

function xianjieModel:getCaravanEscortTeamDataByShipGuid(shipGuid)
if not shipGuid or not self.caravanEscortTeamDatas then
return
end

local guidStr=tostring(shipGuid)
if self.caravanEscortTeamDatas[guidStr]then
return self.caravanEscortTeamDatas[guidStr]
end
end

function xianjieModel:removeAllCaravanEscortTeamEntities()
local lp=self.caravanEscortTeamDatas
if lp then
for guidStr,data in pairs(lp)do
if self.caravanEscortTeamCreateEntFlag[guidStr]then
data:removeEntity()
self.caravanEscortTeamCreateEntFlag[guidStr]=nil
end
end
end
end

function xianjieModel:removeCaravanEscortTeamEntityDataByShipGuid(shipGuid)
if not shipGuid or not self.caravanEscortTeamDatas then
return
end

local guidStr=tostring(shipGuid)
if self.caravanEscortTeamDatas[guidStr]then
local data=self.caravanEscortTeamDatas[guidStr]
data:removeEntity()
self.caravanEscortTeamCreateEntFlag[guidStr]=nil
end
end

function xianjieModel:createCaravanEscortTeamListBehavior(sceneidx,isStart)
local lp=self.caravanEscortTeamDatas
if lp then
for guidStr,data in pairs(lp)do
if not self.caravanEscortTeamCreateEntFlag[guidStr]then
local ret=data:createBehavior(sceneidx,isStart)
if ret then
self.caravanEscortTeamCreateEntFlag[guidStr]=true
end
end
end
end
end

function xianjieModel:createCaravanEscortTeamBehavior(guidStr,sceneidx,isStart)
if self.caravanEscortTeamDatas then
local data=self.caravanEscortTeamDatas[guidStr]
if data then
if not self.caravanEscortTeamCreateEntFlag[guidStr]then
local ret=data:createBehavior(sceneidx,isStart)
if ret then
self.caravanEscortTeamCreateEntFlag[guidStr]=true
end
end
end
end
end

function xianjieModel:removeAllCaravanEscortTeamBehavior()
local lp=self.caravanEscortTeamDatas
if lp then
for guidStr,data in pairs(lp)do
if self.caravanEscortTeamCreateEntFlag[guidStr]then

data:clearBehaviorEx()
self.caravanEscortTeamCreateEntFlag[guidStr]=nil
end
end
end
end

function xianjieModel:removeCaravanEscortTeamBehaviorByShipGuid(guidStr)
local lp=self.caravanEscortTeamDatas
if lp then
if self.caravanEscortTeamCreateEntFlag[guidStr]then
local data=self.caravanEscortTeamDatas[guidStr]

data:clearBehaviorEx()
self.caravanEscortTeamCreateEntFlag[guidStr]=nil
end
end
end


function xianjieModel:test_setAllCaravanEscortTeamIsShowLine(isShow)
local lp=self.caravanEscortTeamDatas
if lp then
for guidStr,entityData in pairs(lp)do
local clickEntKey=entityData:getTeamEnityKey()
if clickEntKey then
local ent=xianjieController:getEntity(clickEntKey)
if ent then
ent:setIsShowLine(isShow)
ent:checkLine()
end
end
end
end
end