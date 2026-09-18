airModel={}

function airModel:onLeaveState(isReconnect)

self.processData=nil
self.actorData=nil
self.statisticData=nil
end


function airModel:initActorData()
self.actorData={}
local processData=airModel:getActorProcessData()
local isInit=processData.isInit or false

local fbId=airGameEnterModel:getCurFbId()
local defaultMoney=0
if fbId then
local fbCfg=cfgHelper.get(cfg_airfubenconfig_get,fbId)
if fbCfg and fbCfg.money then
defaultMoney=fbCfg.money
end
end

if isInit then

self.actorData.equipBag={}
local discipleGuid=airGameEnterModel:getSelectDisciple()
if discipleGuid then

local info=airGameEnterModel:getGameBaseRoleInfo(discipleGuid)
self.actorData.equipBag={info.equipItemId}
else

local cfg=cfgHelper.get(cfg_airroleconfig_get,1)
self.actorData.equipBag=table.weakCopy(cfg.equip)
end


local bagItem
local voc=UIDiscipleModel:getDiscipleJob(discipleGuid)
local items=cfgHelper.get2(cfg_airvocationconfig_get,voc,'items')or{}
bagItem={}
for _,v in ipairs(items)do
bagItem[#bagItem+1]={itemId=v,itemCount=1}
end
self.actorData.itemBag=bagItem

self.actorData.level=0
self.actorData.money=defaultMoney
self.actorData.exp=0
self.actorData.boxList={}
else
self.actorData.equipBag=processData and processData.equipBag or{}
self.actorData.itemBag=processData and processData.itemBag or{}
self.actorData.level=processData and processData.actorLevel or 0

self.actorData.money=processData and processData.money or defaultMoney
self.actorData.exp=processData and processData.exp or 0
self.actorData.boxList=processData and processData.boxList or{}
end
return isInit
end

function airModel:setActorData(actorData)
self.actorData=actorData
end

function airModel:getActorData()
if not self.actorData then
airModel:initActorData()
end

return self.actorData
end


function airModel:getLevel()
local actorData=airModel:getActorData()
return actorData.level
end

function airModel:setLevel(value)
local actorData=airModel:getActorData()
actorData.level=value
airModel:setActorData(actorData)
end


function airModel:addMoney(value)
local actorData=airModel:getActorData()
actorData.money=actorData.money+value

airModel:setActorData(actorData)
UIManager:callWindowFunc('UIAirMiniGameMainWin','freshMoney')
end

function airModel:getMoney()
local actorData=airModel:getActorData()
return actorData.money or 0
end

function airModel:useMoney(value)
local actorData=airModel:getActorData()
actorData.money=actorData.money-value
airModel:setActorData(actorData)
UIManager:callWindowFunc('UIAirMiniGameMainWin','freshMoney')
end


function airModel:addExp(value)
local actorData=airModel:getActorData()
actorData.exp=actorData.exp+value

airModel:setActorData(actorData)

airModel:setStatisticData_addGotExpCount(value)
end

function airModel:getExp()
local actorData=airModel:getActorData()
return actorData.exp or 0
end


function airModel:setExp(value)
local actorData=airModel:getActorData()
actorData.exp=value
airModel:setActorData(actorData)
end


function airModel:addEquip(weaponId)
local actorData=airModel:getActorData()
local equipIndex=#actorData.equipBag+1
actorData.equipBag[equipIndex]=weaponId
airModel:setActorData(actorData)

local ent=airActorSystem:getActor()
if ent then

ent:addEquipAttr(weaponId)

ent:addEquipEnt(weaponId)

ent:refreshEquipEntPosition()

ent:refreshSuitAttrs()

ent:refreshWeaponTypeAttrs()
end
end

function airModel:removeEquip(equipIndex)
local actorData=airModel:getActorData()
local weaponId=actorData.equipBag[equipIndex]
table.remove(actorData.equipBag,equipIndex)
airModel:setActorData(actorData)

local ent=airActorSystem:getActor()
if ent then

ent:removeEquipAttr(weaponId)

ent:removeEquipEnt(equipIndex)

ent:refreshEquipEntPosition()

ent:refreshSuitAttrs()

ent:refreshWeaponTypeAttrs()
end
end

function airModel:changeEquip(equipIndex,weaponId)
local actorData=airModel:getActorData()
local originalWeaponId=actorData.equipBag[equipIndex]
actorData.equipBag[equipIndex]=weaponId
airModel:setActorData(actorData)


local ent=airActorSystem:getActor()
if ent then

ent:changeEquipAttr(originalWeaponId,weaponId)

ent:changeEquipEnt(weaponId,equipIndex)

ent:refreshEquipEntPosition()

ent:refreshSuitAttrs()

ent:refreshWeaponTypeAttrs()
end
end

function airModel:getEquipList()
local actorData=airModel:getActorData()
return actorData.equipBag
end


function airModel:checkEquipIsCanLevelUp(equipIndex)
local equipList=airModel:getEquipList()
if not equipList then
return false
end
local itemId=equipList[equipIndex]
if itemId then
local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
if itemCfg and itemCfg.combine then

return true
end
end
return false
end


function airModel:addBagItem(itemId)
local actorData=airModel:getActorData()
local addNew=true
local itemCfg=cfgHelper.get(cfg_airitemconfig_get,itemId)
local itemCount

if itemCfg.dup and itemCfg.dup>1 then

for i,v in ipairs(actorData.itemBag)do
if v.itemId==itemId and v.itemCount<itemCfg.dup then
v.itemCount=v.itemCount+1
itemCount=v.itemCount
addNew=false
end
end
end
if addNew then
itemCount=1
actorData.itemBag[#actorData.itemBag+1]={
itemId=itemId,
itemCount=itemCount,
}
end
airModel:setActorData(actorData)


local ent=airActorSystem:getActor()
if ent then

airModel:addBuffOnAddItem(ent,itemId)
end
end

function airModel:getItemBag()
local actorData=airModel:getActorData()
return actorData.itemBag
end


function airModel:getVocationId()
local discipleGuid=airGameEnterModel:getSelectDisciple()
local vocId
if discipleGuid then

vocId=UIDiscipleModel:getDiscipleJob(discipleGuid)
else

local cfg=cfgHelper.get(cfg_airroleconfig_get,1)
vocId=cfg.defaultVoc
end
return vocId
end


function airModel:addDropBox(dropId,num)
local actorData=airModel:getActorData()
if not actorData.boxList then
actorData.boxList={}
end
local dropIdStr=tostring(dropId)
if actorData.boxList[dropIdStr]then
actorData.boxList[dropIdStr]=actorData.boxList[dropIdStr]+num
else
actorData.boxList[dropIdStr]=num
end
airModel:setActorData(actorData)
end

function airModel:getDropBoxList()
local actorData=airModel:getActorData()
return actorData.boxList or{}
end

function airModel:getDropBoxNumByDropId(dropId)
local actorData=airModel:getActorData()
local dropIdStr=tostring(dropId)
if not actorData.boxList or not actorData.boxList[dropIdStr]then
return 0
end
return actorData.boxList[dropIdStr]
end

function airModel:clearDropBoxList()
local actorData=airModel:getActorData()
actorData.boxList=nil
airModel:setActorData(actorData)
end


function airModel:getActorProcessData(isUpdateData,isIgnoreInit)
if not self.processData and not isIgnoreInit then
airModel:initActorProcessData()
end

if isUpdateData then

local ent=airActorSystem:getActor()
self.processData.equipBag=airModel:getEquipList()
self.processData.itemBag=airModel:getItemBag()
self.processData.money=airModel:getMoney()
self.processData.actorLevel=airModel:getLevel()
self.processData.exp=airModel:getExp()
self.processData.boxList=airModel:getDropBoxList()

if ent then
self.processData.curAttrs=ent:getAttrs()
self.processData.levelUpAttrs=ent:getLevelUpAttrs()
self.processData.attrTopLimit=ent.attrTopLimit
self.processData.allBuff=ent:getStoreAllBuff()
self.processData.chixuDamage=ent:getStoreChiXuDamages()
self.processData.buffLookup=ent:getStoreBuffLookup()
self.processData.buffDelayList=ent:getStoreDelayList()
self.processData.buffSameConver=ent:getStoreSameConver()
self.processData.buffguid=airBuffSystem:getCurrentBuffGUID()
end

airModel:saveStatisticData()
end

return self.processData
end

function airModel:setActorProcessData(data)
self.processData=data
end

function airModel:initActorProcessData()
local processData={}


processData.settlementData={}


processData.isInit=true

self.processData=processData
end

function airModel:setSettlementRewardList(rewardList)
self.settlementRewards=rewardList
end

function airModel:getSettlementRewardList()
return self.settlementRewards
end

function airModel:getOverLimitGoodsList()
local overLimitList={}

local equipIdConnectGoodIdList_lookup=airModel:getItemConnectGoodsLookup(1)
local equipBag=airModel:getEquipList()or{}
if equipBag then
local equipItemCountList={}
for i,itemId in ipairs(equipBag)do
if not equipItemCountList[itemId]then
equipItemCountList[itemId]=1
else
equipItemCountList[itemId]=equipItemCountList[itemId]+1
end
end

for itemId,itemCount in pairs(equipItemCountList)do
local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
if itemCfg.shopMaxCount and itemCount>=itemCfg.shopMaxCount then
local goodsIdList=equipIdConnectGoodIdList_lookup[itemId]
if goodsIdList then
for _,goodsId in ipairs(goodsIdList)do
local goodsIdStr=tostring(goodsId)
overLimitList[goodsIdStr]=1
end
end
end
end
end


local itemIdConnectGoodIdList_lookup=airModel:getItemConnectGoodsLookup(2)
local itemBag=airModel:getItemBag()or{}
if itemBag then
local itemCountList={}
for i,v in ipairs(itemBag)do
local itemId=v.itemId
local itemCount=v.itemCount
if not itemCountList[itemId]then
itemCountList[itemId]=itemCount
else
itemCountList[itemId]=itemCountList[itemId]+itemCount
end
end

for itemId,itemCount in pairs(itemCountList)do
local itemCfg=cfgHelper.get(cfg_airitemconfig_get,itemId)
if itemCfg.shopMaxCount and itemCount>=itemCfg.shopMaxCount then
local goodsIdList=itemIdConnectGoodIdList_lookup[itemId]
if goodsIdList then
for _,goodsId in ipairs(goodsIdList)do
local goodsIdStr=tostring(goodsId)
overLimitList[goodsIdStr]=1
end
end
end
end
end

return overLimitList
end

function airModel:getOverLimitLvUpRandAttrIdList()
local overLimitList={}
local processData=airModel:getActorProcessData()
local lvUpIdSelectCountList_lookup=processData.lvUpIdSelectCountList
if lvUpIdSelectCountList_lookup and next(lvUpIdSelectCountList_lookup)then
for attrRandIdStr,count in pairs(lvUpIdSelectCountList_lookup)do
local attrRandId=tonumber(attrRandIdStr)
local attrRandCfg=cfgHelper.get(cfg_airrandattrconfig_get,attrRandId)
if attrRandCfg and attrRandCfg.limit_num and count>=attrRandCfg.limit_num then
overLimitList[attrRandIdStr]=1
end
end
end

return overLimitList
end


function airModel:getMaxLevelEquipList()
local maxList={}
local equipList=airModel:getEquipList()or{}
for idx,weaponId in ipairs(equipList)do
local weaponCfg=cfgHelper.get(cfg_airweaponconfig_get,weaponId)
if weaponCfg and weaponCfg.color>=5 then

maxList[#maxList+1]=weaponId
end
end

return maxList
end



function airModel:getItemConnectGoodsLookup(itemType)
if not self.itemConnectGoodsLookup then
local lookup={}

local allGoodsCfg=cfg_airrandshopconfig()
for id,cfg in pairs(allGoodsCfg)do
local goodsItemId=cfg.itemId
local goodsItemType=cfg.itemType
if not lookup[goodsItemType]then
lookup[goodsItemType]={}
end

if not lookup[goodsItemType][goodsItemId]then
lookup[goodsItemType][goodsItemId]={}
end
table.insert(lookup[goodsItemType][goodsItemId],id)
end

self.itemConnectGoodsLookup=lookup
end

return self.itemConnectGoodsLookup[itemType]or{}
end


function airModel:getFbLevelGetBoxCountList()
local list={}
local allBoxCount=0
local checkBoxList=cfgHelper.get(cfg_aircommonconfig_get,1,"checkBoxList")
if checkBoxList then
for _,dropid in ipairs(checkBoxList)do
local dropCfg=cfgHelper.get(cfg_airdropconfig_get,dropid)
if dropCfg and dropCfg.type1==eDropType.eBox then
local funcparam=dropCfg.funcparam
local boxId=funcparam.value
if boxId then

local getNum=airModel:getDropBoxNumByDropId(dropid)
local boxIdStr=tostring(boxId)
if getNum and getNum>0 then
if not list[boxIdStr]then
list[boxIdStr]=0
end
list[boxIdStr]=list[boxIdStr]+getNum
allBoxCount=allBoxCount+getNum
end
end
end
end
end

return list,allBoxCount
end


function airModel:checkIsCanContinueLevel()
if not self.processData then

return false
end

if self.processData.checkStep and self.processData.checkStep>=3 then

return false
end

return true
end


function airModel:getItemAttrListLookup(itemId)
local itemCfg=cfgHelper.get(cfg_airitemconfig_get,itemId)
local attrList_lookup={}

local buffList=itemCfg.buffid
for idx,buff in ipairs(buffList)do
local buffId=buff[1]
local buffLevel=buff[2]
if buffLevel then
local buffCfg=cfg_airbuffconfig_get(buffId)
if buffCfg then
local buffType=buffCfg.buffType
local duration=buffCfg.duration
if duration==-1 and buffType==eBuffType.eChangeAttr then

local effect=airBuffSystem:getBuffEffects(buffCfg,buffLevel)
local attrId=effect[1]
local value=effect[2]
local value_P=effect[3]
local isPercent=value_P~=0
local attrVal=isPercent and value_P or value
if attrList_lookup[attrId]then
attrList_lookup[attrId].val=attrList_lookup[attrId].val+attrVal
else
attrList_lookup[attrId]={
val=attrVal,
isPercent=isPercent,
cfgIdx=idx,
}
end
end
else
logErr(FMT.fmt("找不到宝物id为{0},buffId为{1}所对应的配置",itemId,buffId))
end
end
end

return attrList_lookup
end


function airModel:checkGoodsIsLockByIndex(index)
local processData=airModel:getActorProcessData()
if processData and processData.settlementData and processData.settlementData.goodsLockList then
if processData.settlementData.goodsLockList[index]then
return true
end
end
return false
end


function airModel:getShopLockGoodsList()
local processData=airModel:getActorProcessData()
if processData and processData.settlementData and processData.settlementData.goodsLockList then
local list_lookup=processData.settlementData.goodsLockList
if list_lookup and next(list_lookup)then
local list={}
for goodsIdx,goodsRandId in pairs(list_lookup)do
list[#list+1]={goodsIdx,goodsRandId}
end
return list
end
end
return nil
end

function airModel:checkIsHasRemainingReviveCount()
local processData=airModel:getActorProcessData()
local useCount=processData and processData.reviveCount or 0
local maxReviveCount=1

return maxReviveCount-useCount>0
end


function airModel:getNowSuitIdList()
local equipList=airModel:getEquipList()or{}
local list={}
local list_lookup={}
for idx,weaponId in ipairs(equipList)do
local weaponCfg=cfgHelper.get(cfg_airweaponconfig_get,weaponId)
if weaponCfg and weaponCfg.suit then
local suitId=weaponCfg.suit
list_lookup[suitId]=true
end
end

for suitId,_ in pairs(list_lookup)do
list[#list+1]=suitId
end

return list
end


function airModel:getNowEquipTypeList()
local equipList=airModel:getEquipList()or{}
local list={}
local list_lookup={}
for idx,weaponId in ipairs(equipList)do
local weaponCfg=cfgHelper.get(cfg_airweaponconfig_get,weaponId)
if weaponCfg and weaponCfg.type1 then
local equipType=weaponCfg.type1
list_lookup[equipType]=true
end
end

for suitId,_ in pairs(list_lookup)do
list[#list+1]=suitId
end

return list
end


function airModel:addBuffOnAddItem(ent,itemid)
local buffids=cfgHelper.get2(cfg_airitemconfig_get,itemid,'buffid')
if buffids==nil then return end

for _,v in ipairs(buffids)do
local buffid=v[1]
local level=v[2]
airBuffSystem:addBuff(ent,buffid,level,ent,false)
end
end


function airModel:initStatisticData()
airModel:loadStatisticData()
if not self.statisticData then
self.statisticData={}

self.statisticData.allDmg=0
self.statisticData.weaponDmgList={}
self.statisticData.killMonsterCount=0
self.statisticData.killBossCount=0
self.statisticData.gotExpCount=0
end
end


function airModel:saveStatisticData()
if not self.processData then
airModel:initActorProcessData()
end

local statisticData=table.weakCopy(self.statisticData)
if statisticData and statisticData.weaponDmgList and next(statisticData.weaponDmgList)then
local tmpList={}
for equipIdx,v in ipairs(statisticData.weaponDmgList)do
local equipIdxStr=tostring(equipIdx)
tmpList[equipIdxStr]=v
end
statisticData.weaponDmgList=tmpList
end
self.processData.statisticData=statisticData
end


function airModel:loadStatisticData()
if not self.processData then
airModel:initActorProcessData()
end

local processData=airModel:getActorProcessData()
local isInit=processData and processData.isInit or false

if not isInit then
local statisticData=self.processData.statisticData
if statisticData and statisticData.weaponDmgList and next(statisticData.weaponDmgList)then
local tmpList={}
for equipIdxStr,v in pairs(statisticData.weaponDmgList)do
local equipIdx=tonumber(equipIdxStr)
tmpList[equipIdx]=v
end
statisticData.weaponDmgList=tmpList
end
self.statisticData=statisticData
end
end

function airModel:clearStatisticData()
self.statisticData=nil
end


function airModel:setStatisticData_addAllDmg(addDmgVal)
if not self.statisticData then
airModel:initStatisticData()
end
self.statisticData.allDmg=self.statisticData.allDmg+addDmgVal
end


function airModel:getStatisticData_getAllDmg()
if not self.statisticData then
airModel:initStatisticData()
end
return self.statisticData.allDmg
end


function airModel:setStatisticData_addWeaponDmg(equipIdx,addDmgVal)
if not self.statisticData then
airModel:initStatisticData()
end

if self.statisticData.weaponDmgList[equipIdx]then
self.statisticData.weaponDmgList[equipIdx].allDmg=self.statisticData.weaponDmgList[equipIdx].allDmg+addDmgVal
else
self.statisticData.weaponDmgList[equipIdx]={}
self.statisticData.weaponDmgList[equipIdx].allDmg=addDmgVal
end
end


function airModel:setStatisticData_setWeaponDmg(equipIdx,dmgVal)
if not self.statisticData then
airModel:initStatisticData()
end

if self.statisticData.weaponDmgList[equipIdx]then
self.statisticData.weaponDmgList[equipIdx].allDmg=dmgVal
else
self.statisticData.weaponDmgList[equipIdx]={}
self.statisticData.weaponDmgList[equipIdx].allDmg=dmgVal
end
end


function airModel:setStatisticData_removeWeaponDmg(equipIdx)
if not self.statisticData then
airModel:initStatisticData()
end

if self.statisticData.weaponDmgList[equipIdx]then
table.remove(self.statisticData.weaponDmgList,equipIdx)
end
end



function airModel:setStatisticData_mergeWeaponDmg(equipIdx_a,equipIdx_b)
if not self.statisticData then
airModel:initStatisticData()
end

local data_a=self.statisticData.weaponDmgList[equipIdx_a]or{}
local data_b=self.statisticData.weaponDmgList[equipIdx_b]or{}

local allDmg_a=data_a.allDmg or 0
local lastDmg_a=data_a.lastDmg or 0
local overLastDmg_a=data_a.overLastDmg or 0
local allDmg_b=data_b.allDmg or 0
local lastDmg_b=data_b.lastDmg or 0
local overLastDmg_b=data_b.overLastDmg or 0

self.statisticData.weaponDmgList[equipIdx_a]={
allDmg=allDmg_a+allDmg_b,
lastDmg=lastDmg_a+lastDmg_b,
overLastDmg=overLastDmg_a+overLastDmg_b,
}
airModel:setStatisticData_removeWeaponDmg(equipIdx_b)
end



function airModel:getStatisticData_getWeaponDmg(equipIdx)
if not self.statisticData then
airModel:initStatisticData()
end

return self.statisticData.weaponDmgList[equipIdx]and self.statisticData.weaponDmgList[equipIdx].allDmg or nil
end


function airModel:setStatisticData_setOverLastLevelWeaponDmg()
if not self.statisticData then
airModel:initStatisticData()
end

if self.statisticData.weaponDmgList then
for equipIdx,v in pairs(self.statisticData.weaponDmgList)do
if self.statisticData.weaponDmgList[equipIdx].lastDmg then
self.statisticData.weaponDmgList[equipIdx].overLastDmg=self.statisticData.weaponDmgList[equipIdx].lastDmg
else
self.statisticData.weaponDmgList[equipIdx].overLastDmg=0
end

self.statisticData.weaponDmgList[equipIdx].lastDmg=self.statisticData.weaponDmgList[equipIdx].allDmg
end
end
end


function airModel:getStatisticData_getLastLevelWeaponDmg(equipIdx)
if not self.statisticData then
airModel:initStatisticData()
end

local lastDmg
if self.statisticData.weaponDmgList[equipIdx]then
if self.statisticData.weaponDmgList[equipIdx].lastDmg then
local overLastDmg=self.statisticData.weaponDmgList[equipIdx].overLastDmg or 0
lastDmg=self.statisticData.weaponDmgList[equipIdx].lastDmg-overLastDmg
end
end

return lastDmg
end


function airModel:setStatisticData_addKillMonsterCount(addVal)
if not self.statisticData then
airModel:initStatisticData()
end
self.statisticData.killMonsterCount=self.statisticData.killMonsterCount+addVal
end


function airModel:getStatisticData_getKillMonsterCount()
if not self.statisticData then
airModel:initStatisticData()
end
return self.statisticData.killMonsterCount
end


function airModel:setStatisticData_addKillBossCount(addVal)
if not self.statisticData then
airModel:initStatisticData()
end
self.statisticData.killBossCount=self.statisticData.killBossCount+addVal
end


function airModel:getStatisticData_getKillBossCount()
if not self.statisticData then
airModel:initStatisticData()
end
return self.statisticData.killBossCount
end


function airModel:setStatisticData_addGotExpCount(addVal)
if not self.statisticData then
airModel:initStatisticData()
end
self.statisticData.gotExpCount=self.statisticData.gotExpCount+addVal
end


function airModel:getStatisticData_getGotExpCount()
if not self.statisticData then
airModel:initStatisticData()
end
return self.statisticData.gotExpCount
end

