
function LittleWorldModel:dirtyAllDiscipleAttribute(showFightTips)
if not systemModel.isOpen(SYSTEM_DEFINE.eSmallWorld)then
return
end
showFightTips=showFightTips or false
local disciples=UIDiscipleModel:getAllDiscipleData()
for index,disciple in pairs(disciples)do
local netData=disciple.netData.net

UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eLittleWorld,showFightTips)
end
end


function LittleWorldModel:calculationDiscipleAttrLookup(guid)
if not systemModel.isOpen(SYSTEM_DEFINE.eSmallWorld)then
return
end
local netData=UIDiscipleModel:getDiscipleData(guid)
local discipleAttrLookup=netData.discipleAttrLookup


local attrs={}
attrs=attrListHelper.concatLookup(attrs,LittleWorldModel:getDiscipleAddAttr_Lookup())


local xcattrLookup=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eGlobalDiZiAttrRate)
attrs=attrListHelper.concatLookup(attrs,xcattrLookup)

if discipleAttrLookup then
discipleAttrLookup[DISCIPLE_ATTRIBUTE_TYPE.eLittleWorld]=attrs
end
end



function LittleWorldModel:getDiscipleAddAttr_Lookup()
local lookup={}
lookup=attrListHelper.concatLookup(lookup,LittleWorldModel:getWorldBaseAttr_Lookup())


local addRate=xingChenHelper.getAllAffixAttr_Lookup()
for a,v in pairs(lookup)do
lookup[a]=v*(1+(addRate[a]or 0)/100)
end

lookup=attrListHelper.concatLookup(lookup,LittleWorldModel:getWorldZhenWuAttr_Lookup())
lookup=attrListHelper.concatLookup(lookup,xingChenHelper.getXingChenAttr())


return lookup
end


function LittleWorldModel:getWorldBaseAttr_Lookup()
local lv=LittleWorldModel:getLittleWorldLevel()
return attrListHelper.tramsformToLookup(LittleWorldModel.getWorldBaseAttr(lv)or{})
end



function LittleWorldModel:getWorldZhenWuAttr_Lookup()
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
if effType==eZhenWuEffectType.eDiscipleAttr then
for t,v2 in pairs(effArgs)do
attrLookup[t]=(attrLookup[t]or 0)+v2
end
end
end
end
end
end

return attrLookup
end


function LittleWorldModel:calculationAttrLookup(lookup)
if not systemModel.isOpen(SYSTEM_DEFINE.eSmallWorld)then
return
end
local attrLookup=LittleWorldModel:getDiscipleAddAttr_Lookup()
for k,v in pairs(attrLookup)do
lookup[k]=lookup[k]or 0
lookup[k]=lookup[k]+v
end
end
