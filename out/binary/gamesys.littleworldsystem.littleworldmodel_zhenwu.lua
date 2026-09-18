





eZhenWuEffectType=
{
eLittleWorldAttr=1,
eDiscipleAttr=2,
eItemAddSpeed=3,
}

local ZhenWuEffectDesc=
{
[eZhenWuEffectType.eLittleWorldAttr]=function(attrType,val)
local descCfg=cfgHelper.get(cfg_smallworldconfig_get,1,"zw_effect_desc")
local desc=descCfg[attrType]or""
return FMT.fmt('{0}+{1}%',desc,val)
end,
[eZhenWuEffectType.eDiscipleAttr]=function(attrType,val)
local name,str=equipsHelper.getAttr(attrType,val)
return FMT.fmt('{0}：{1}',name,str)
end,
[eZhenWuEffectType.eItemAddSpeed]=function(itemId,val)
if val[2]==1 then
return FMT.fmt('小世界{0}产速+{1}%',itemsConfig.getItemName(itemId),val[1])
else
return FMT.fmt('小世界{0}产出+{1}',itemsConfig.getItemName(itemId),val[1])
end
end,
}

function LittleWorldModel:getZhenWuEffectDesc(zwEffectType,attrType,val)
if ZhenWuEffectDesc[zwEffectType]then
return ZhenWuEffectDesc[zwEffectType](attrType,val)
end
end

function LittleWorldModel:SetEffectDirty()
self.isSetItemEffectDirty=true
self.isSetWorldAttrEffectDirty=true
end

function LittleWorldModel:getZhenWuItemEffect()
if self.isSetItemEffectDirty or(not self.worldZhenWuEffectItemUp or not self.worldZhenWuEffectItemUpPercent)then
local slot=LittleWorldModel:getZhenWuSlot()
local rewardUpList={}
local rewardUpPercentList={}
for i,v in pairs(slot)do
local star=LittleWorldModel:getZhenWuData(v)
local zwEffect=LittleWorldModel.getZWEffectConfig(v,star)
for _,vv in ipairs(zwEffect)do
local effType=vv[1]
local effArgs=vv[2]
if effType==eZhenWuEffectType.eItemAddSpeed then
for itemId,val in pairs(effArgs)do
if val[2]==1 then
rewardUpPercentList[itemId]=(rewardUpPercentList[itemId]or 0)+val[1]
else
rewardUpList[itemId]=(rewardUpList[itemId]or 0)+val[1]
end
end
end
end
end
self.isSetItemEffectDirty=nil
self.worldZhenWuEffectItemUp,self.worldZhenWuEffectItemUpPercent=rewardUpList,rewardUpPercentList
return rewardUpList,rewardUpPercentList
else
return self.worldZhenWuEffectItemUp,self.worldZhenWuEffectItemUpPercent
end
end


function LittleWorldModel:getZhenWuAttrEffect()
if self.isSetWorldAttrEffectDirty or(not self.worldZhenWuEffectAttr)then
local attrLookup={}
local zhenWuSlot=LittleWorldModel:getZhenWuSlot()
for k,v in pairs(zhenWuSlot)do
local star=LittleWorldModel:getZhenWuData(v)
if star then
local zwEffect=LittleWorldModel.getZWEffectConfig(v,star)
if zwEffect then
for i,v in ipairs(zwEffect)do
local effType=v[1]
local effArgs=v[2]
if effType==eZhenWuEffectType.eLittleWorldAttr then
for t,v2 in pairs(effArgs)do
attrLookup[t]=(attrLookup[t]or 0)+v2
end
end
end
end
end
end
self.isSetWorldAttrEffectDirty=nil
self.worldZhenWuEffectAttr=attrLookup
return attrLookup
else
return self.worldZhenWuEffectAttr
end
end

function LittleWorldModel:getZhenWuAttrEffectById(id)
local list=LittleWorldModel:getZhenWuAttrEffect()
return list[id]or 0
end



function LittleWorldModel:getZhenWuSlot()
return self.data.zwSlot or{}
end

function LittleWorldModel:initZhenWuSlot(serverData)
local list={}
if serverData then
for i,v in ipairs(serverData)do
list[v.param_1]=v.param_2
end
end
self.data.zwSlot=list
LittleWorldModel:SetEffectDirty()
end

function LittleWorldModel:setZhenWuSlot(idx,id)
for k,v in pairs(self.data.zwSlot)do
if v==id then
self.data.zwSlot[k]=nil
UIManager:callWindowFunc("UIPlanent","refreshSlot",k)
end
end
self.data.zwSlot[idx]=id
LittleWorldModel:SetEffectDirty()
end

function LittleWorldModel:getZhenWuIdxSlot(idx)
if self.data.zwSlot then
return self.data.zwSlot[idx]
end
end


function LittleWorldModel:getZhenWuSlotBag(slotId)
local zwConfig=cfg_smallworldtownconfig()
local bagIdList={}
for i,v in pairs(zwConfig)do

table.insert(bagIdList,v.id)

end
table.sort(bagIdList,function(a,b)return a<b end)
return bagIdList
end

function LittleWorldModel:initZhenWuData(dataList,slotList)
local list={}
if dataList then
for i,v in ipairs(dataList)do
list[v.param_1]=v.param_2
end
end
if slotList then
for i,v in ipairs(slotList)do
list[v.param_2]=v.param_3
end
end
self.data.zwData=list
LittleWorldModel:SetEffectDirty()
end

function LittleWorldModel:setZhenWuStar(zwId,star)
self.data.zwData[zwId]=star
LittleWorldModel:SetEffectDirty()
end

function LittleWorldModel:getZhenWuData(zwId)
return self.data.zwData~=nil and self.data.zwData[zwId]
end

function LittleWorldModel:isZhenWuCanActive(zwId)
if LittleWorldModel:getZhenWuData(zwId)then
return false
end
local zwConfig=cfgHelper.get(cfg_smallworldtownconfig_get,zwId)
local costConfig=zwConfig.lv_costs
for i,v in ipairs(costConfig)do
if itemsModel.getCount(v[1])<v[2]then
return false
end
end
return true
end

function LittleWorldModel:haveZhenWuCanActive()
local zwConfig=cfg_smallworldtownconfig()
for i,v in ipairs(zwConfig)do
if LittleWorldModel:isZhenWuCanActive(v.id)then
return true
end
end
end

function LittleWorldModel:isZhenWuCanEquipReddot()
for i=1,4 do
if not LittleWorldModel:getZhenWuIdxSlot(i)then
if LittleWorldModel:isZhenWuCanEquip()then
return true
else
return false
end
end
end
end

function LittleWorldModel:isZhenWuCanEquip()
local zwConfig=self.data.zwData or defaultT
for zwId,_ in pairs(zwConfig)do
if not LittleWorldModel:isZhenWuEquiped(zwId)then
return true
end
end
end



function LittleWorldModel:isZhenWuEquiped(zwId)
for k,v in pairs(LittleWorldModel:getZhenWuSlot())do
if v==zwId then
return k
end
end
end


function LittleWorldModel:getStarZhenWuNum(star)
local slotList=LittleWorldModel:getZhenWuSlot()or{}
if not next(slotList)then
return 0
end
local num=0
for k,v in ipairs(slotList)do
local slotstar=LittleWorldModel:getZhenWuData(v)
if slotstar>=star then
num=num+1
end
end
return num
end


