









shanMenDaZhenModel={}


shanMenDaZhenModel.data={}

function shanMenDaZhenModel:onAppStart()

end


function shanMenDaZhenModel:onEnterState(isReconnect)

end


function shanMenDaZhenModel:onProtocolReq()

end


function shanMenDaZhenModel:onLeaveState(isReconnect)

self.data={}
end



function shanMenDaZhenModel:getShanMenBdData()
local bdData
if self.data.shanmenUBdId then
bdData=zongmenModel:getBuildingData(self.data.shanmenUBdId)
else
bdData=zongmenModel:findBuildingDataByType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eShanMen)
if bdData then
self.data.shanmenUBdId=bdData.un_build_id
end
end
return bdData
end

function shanMenDaZhenModel:checkHaveShanmenDaZhen()
local bdData=shanMenDaZhenModel:getShanMenBdData()
if bdData then
return bdData.level>=1
else
return false
end
end


function shanMenDaZhenModel:setShanMenDaZhenShieldValue(value)
self.data.shieldValue=value or 0
end


function shanMenDaZhenModel:getShanMenDaZhenShieldValue()
return self.data.shieldValue or 0
end


function shanMenDaZhenModel:getShanMenDaZhenShieldMaxValue()
if not systemModel.isOpen(SYSTEM_DEFINE.eShanMenDaZhen)then
return 0
end

local bdData=shanMenDaZhenModel:getShanMenBdData()
if not bdData or bdData.level<1 then
return 0
else
local daZhenLevel=bdData.level-1

local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLevel)
local maxShieldValue=daZhenLvCfg.shield
return maxShieldValue
end
end

function shanMenDaZhenModel:setShanMenDaZhenTeamDiziList(len,guidList)
self.data.teamDzList={}
if len>0 then
local teamMaxDzCount=5
for i,guid in ipairs(guidList)do
local teamIndex=math.ceil(i/teamMaxDzCount)
local index=i%teamMaxDzCount
if index==0 then
index=teamMaxDzCount
end

if not self.data.teamDzList[teamIndex]then
self.data.teamDzList[teamIndex]={}
end
if guid and guid~=0 then
self.data.teamDzList[teamIndex][index]=guid
end
end
end
end

function shanMenDaZhenModel:getShanMenDaZhenTeamDiziListByTeamIndex(teamIndex)
if not self.data or not self.data.teamDzList then
return nil
end

return self.data.teamDzList[teamIndex]
end

function shanMenDaZhenModel:getShanMenDaZhenTeamDiziAllGuidList()
if not self.data or not self.data.teamDzList then
return nil
end

local allGuidList={}
local teamMaxDzNum=5
for teamIndex,guidList in pairs(self.data.teamDzList)do
for posIndex,guid in pairs(guidList)do
local listIndex=(teamIndex-1)*teamMaxDzNum+posIndex
allGuidList[listIndex]=guid
end
end

return allGuidList
end


function shanMenDaZhenModel:getDaZhenState()

local bdData=shanMenDaZhenModel:getShanMenBdData()
if not bdData then

return 0
end
local daZhenLv=bdData.level-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local nowShieldValue=shanMenDaZhenModel:getShanMenDaZhenShieldValue()
local maxShieldValue=daZhenLvCfg.shield

local state
if nowShieldValue==0 then
if bdData.level>1 then

state=3
else

state=4
end
elseif nowShieldValue>0 and nowShieldValue<maxShieldValue then

state=2
elseif nowShieldValue>=maxShieldValue then

state=1
end

return state
end

function shanMenDaZhenModel:checkDaZhenCanLevelUp()
local bdData=shanMenDaZhenModel:getShanMenBdData()
if zongmenModel:getBDFlagType(bdData.flag)~=bdFlagType.normal then
return false
end

local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)
if nextLvCfg then
local flag=zongmenControl:checkLevelUp(nextLvCfg)
if flag then
return true
end
end

return false
end


function shanMenDaZhenModel:checkDaZhenCanBatchLevelUp()
local bdData=shanMenDaZhenModel:getShanMenBdData()
if zongmenModel:getBDFlagType(bdData.flag)~=bdFlagType.normal then
return false
end

local checkCount=2
local costList_lookup={}
for i=1,checkCount do
local targetLevel=bdData.level+i
local lvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,targetLevel)
if lvCfg then
local flag=zongmenControl:checkLevelUp(lvCfg)
if not flag then
return false
end

local lvCostList=lvCfg.uplevel_cost
for i,v in ipairs(lvCostList)do
local itemId=v[1]
local itemCount=v[2]
if costList_lookup[itemId]then
costList_lookup[itemId]=costList_lookup[itemId]+itemCount
else
costList_lookup[itemId]=itemCount
end
end
else

return false
end
end

for itemId,itemCount in pairs(costList_lookup)do
local hasCount=itemsModel.getCount(itemId)
if hasCount<itemCount then
return false
end
end

return true
end

function shanMenDaZhenModel:initLevelUpCostLookup()
local lookup={}
local bdData=shanMenDaZhenModel:getShanMenBdData()
if bdData then
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)
if nextLvCfg then
local costList=nextLvCfg.uplevel_cost
for i,v in ipairs(costList)do
local itemId=v[1]
local itemNum=v[2]
lookup[itemId]=itemNum
end
end
end
self.levelUpCostLookup=lookup
end

function shanMenDaZhenModel:checkIsDaZhenLevelUpItem(itemId)
if self.levelUpCostLookup and self.levelUpCostLookup[itemId]then
return true
end
return false
end

function shanMenDaZhenModel:checkDaZhenIsTeamEmptyByTeamIdx(teamIdx)
if not self.data or not self.data.teamDzList then
return true
end

if not self.data.teamDzList[teamIdx]or not next(self.data.teamDzList[teamIdx])then
return true
end

return false
end

function shanMenDaZhenModel:checkDaZhenIsHasEmptyTeam()
if not self.data or not self.data.teamDzList then
return true
end


local bdData=shanMenDaZhenModel:getShanMenBdData()
local buildLv=bdData.level
local daZhenLv=buildLv-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLv)
local unlockTeamCount=daZhenLvCfg.team
for i=1,unlockTeamCount do
local isTeamEmpty=shanMenDaZhenModel:checkDaZhenIsTeamEmptyByTeamIdx(i)
if isTeamEmpty then
return true
end
end

return false
end

function shanMenDaZhenModel:getDaZhenAttrAddList()
if not systemModel.isOpen(SYSTEM_DEFINE.eShanMenDaZhen)then
return nil
end

local bdData=shanMenDaZhenModel:getShanMenBdData()
if not bdData or bdData.level<1 then
return nil
else

local daZhenLevel=bdData.level-1
local daZhenLvCfg=cfgHelper.get(cfg_shanmendazhenconfig_get,daZhenLevel)
local attrList=daZhenLvCfg.attr
if attrList and next(attrList)then
local lookupList={}
local attrAddRate=daZhenLvCfg.percent or 0
local attrRate=1+attrAddRate/100
for i,v in ipairs(attrList)do
local attrId=v[1]
local attrCfgVal=v[2]
local attrVal=math.floor(attrCfgVal*attrRate+0.00001)
lookupList[attrId]=attrVal
end

return lookupList
end
end

return nil
end



function shanMenDaZhenModel:getDaZhenHasDzTeamNum()
if not self.data or not self.data.teamDzList or not next(self.data.teamDzList)then
return 0
end

local hasDzTeamNum=0
for i,dzList in pairs(self.data.teamDzList)do
if next(dzList)then
for _,guid in pairs(dzList)do
if guid~=0 and not mathHelper.compareInt64(guid,int64.new('0'))then
hasDzTeamNum=hasDzTeamNum+1
break
end
end
end
end

return hasDzTeamNum
end


function shanMenDaZhenModel:checkDzInDaZhenTeamByGuid(guid)
if not self.data or not self.data.teamDzList or not next(self.data.teamDzList)then
return false
end

for i,dzList in pairs(self.data.teamDzList)do
if next(dzList)then
for _,teamDzGuid in pairs(dzList)do







if teamDzGuid==guid then
return true
end
end
end
end

return false
end
