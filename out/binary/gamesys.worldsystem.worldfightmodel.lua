






local _MODULENAME="worldFightModel"




def_table(_MODULENAME)
worldFightModel.name=_MODULENAME

local _this=worldFightModel
local reward={}
MONSTER_EXTRA_DROP_ACTIVITIES={
[SUB_ACTIVITY_TYPE.eDropAct]=true
}


function worldFightModel:onAppStart()

end


function worldFightModel:onEnterState()
reward={}
end


function worldFightModel:onLeaveState()

reward={}
end


function worldFightModel:onServerDataInitFinish()

end













function worldFightModel:turnResult(rewards)
local exp=0
local items={}
for i,v in ipairs(rewards or{})do



v.itemcount=v.itemcount or v.num
v.num=v.itemcount
table.insert(items,v)

end
table.sort(items,function(a,b)
local aType=self:getItemTypeScore(a.itemid)
local bType=self:getItemTypeScore(b.itemid)
if aType~=bType then
return aType>bType
else
local aConfig=itemsConfig.getConfig(a.itemid)
local bConfig=itemsConfig.getConfig(b.itemid)
return aConfig.color>bConfig.color
end
end)
return items,exp
end

function worldFightModel:getItemTypeScore(itemid)
if itemsConfig.isEquip(itemid)then
return 3
elseif itemsConfig.isItem(itemid)then
return 2
elseif itemsConfig.isMoney(itemid)then
return 1
else
return 0
end
end

function worldFightModel:getMonsterShowAwards(monsterGroup,level)
local mCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroup)
return self:getMonsterShowAwardsEx(mCfg,level)
end

function worldFightModel:getMonsterShowAwardsEx(mCfg,level)
local detail={}
local items={}
local showItems=nil
local outItems=nil
local awardConfig=nil
if mCfg.drops then
for i,v in ipairs(mCfg.drops)do
if level then
awardConfig=itemsAwardConfig:getAwardInConfigByLevel(v,level)

else
awardConfig=cfgHelper.get(cfg_awardconfig_get,v)
end

if awardConfig then
showItems=awardConfig.detailItems
outItems=awardConfig.showItems
end

if showItems then
for i,vv in ipairs(showItems)do
table.insert(detail,vv)
end
end

if outItems then
for i,vv in ipairs(outItems)do
table.insert(items,vv)
end
end
end
end

return items,detail
end

function worldFightModel:getMonsterShowAwardsEx2(drops,level)
local detail={}
local items={}
local showItems=nil
local outItems=nil
local awardConfig=nil
if drops then
for i,v in ipairs(drops)do
if level then
awardConfig=itemsAwardConfig:getAwardInConfigByLevel(v,level)

else
awardConfig=cfgHelper.get(cfg_awardconfig_get,v)
end

if awardConfig then
showItems=awardConfig.detailItems
outItems=awardConfig.showItems
end

if showItems then
for i,vv in ipairs(showItems)do
table.insert(detail,vv)
end
end

if outItems then
for i,vv in ipairs(outItems)do
table.insert(items,vv)
end
end
end
end

return items,detail
end

function worldFightModel:getMonsterExtraDropActReward(monsterGroupId)
local actRewards={}
local actRewards_lookup={}
local mCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
if mCfg and mCfg.drops then

for subType,_ in pairs(MONSTER_EXTRA_DROP_ACTIVITIES)do
local subActs=activitiesModel:getActSubList_subType_doing(subType)
for index,subAct in ipairs(subActs)do
local dropCfg=subAct:getSubActConfig("drop")
local dropsCfg=subAct:getSubActConfig("drops")
if dropsCfg~=nil and#dropsCfg>0 then
dropCfg=dropsCfg[2][1]
end

if mCfg.monClass and dropCfg[mCfg.monClass]then

if mCfg.monType and dropCfg[mCfg.monClass][mCfg.monType]then

local dropId=dropCfg[mCfg.monClass][mCfg.monType]
local exDropItemList=zongmenControl:getRewardConfigData(dropId,zongmenModel:getLevel())
for i=1,#exDropItemList do
local item=exDropItemList[i]
local itemId=item[1]
local itemCount=item[2]
local isLock=item[3]
local range=item.range
if not actRewards_lookup[itemId]then
local showItem={itemId,-1,isLock}
showItem.range=range
showItem.showCount=itemCount
table.insert(actRewards,showItem)
actRewards_lookup[itemId]=true
end
end
end
end
end
end
end

return actRewards
end