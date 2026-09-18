
local zmBuffValue

function xianjieController:onAppStart_JZAttribute()
zmBuffValue=nil
end

function xianjieController:onEnterState_JZAttribute(isReconnet)

notifySystem:listenNotify(notifyConfig.onGuBaoActive,self.onGuBaoUpdate)
notifySystem:listenNotify(notifyConfig.onGuBaoAwake,self.onGuBaoUpdate)
notifySystem:listenNotify(notifyConfig.onGuBaoShengXing,self.onGuBaoUpdate)
notifySystem:listenNotify(notifyConfig.onGuBaoSkillLevelChange,self.onGuBaoUpdate)

notifySystem:listenNotify(notifyConfig.onZongMenBuffFresh,self.onZongMenBuffFresh)

notifySystem:listenNotify(notifyConfig.onXianJieBuffFresh,self.onXianJieBuffFresh)

notifySystem:listenNotify(notifyConfig.onXCEquipChange,self.onXCEquipChange)
end

function xianjieController:onLeaveState_JZAttribute(isReconnet)
xianjieModel:clearJZAttribute()
notifySystem:removelistener(notifyConfig.onGuBaoActive,self.onGuBaoUpdate)
notifySystem:removelistener(notifyConfig.onGuBaoAwake,self.onGuBaoUpdate)
notifySystem:removelistener(notifyConfig.onGuBaoShengXing,self.onGuBaoUpdate)
notifySystem:removelistener(notifyConfig.onGuBaoSkillLevelChange,self.onGuBaoUpdate)
notifySystem:removelistener(notifyConfig.onXianJieBuffFresh,self.onXianJieBuffFresh)
notifySystem:removelistener(notifyConfig.onZongMenBuffFresh,self.onZongMenBuffFresh)
notifySystem:removelistener(notifyConfig.onXCEquipChange,self.onXCEquipChange)
end



function xianjieController.onGuBaoUpdate(gbid)
if gubaoLookup:checkEffect(23,gbid)then
local gbcfg=cfgHelper.get(cfg_gubaoconfig_get,gbid)
local skilllist=gbcfg.skill
local skilllv=gubaoModel:getSkillLv(gbid)
local skilldata=skilllist[skilllv]or nil

if skilldata then
local paramData=skilldata[3]

for i,effect in ipairs(paramData)do
local skillType=effect[1]
local attrId=effect[2]
if skillType and skillType==122 then
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aGuBao,attrId)

end
end
end
end

local suitlist=gubaoLookup:getSuitList(gbid)
if suitlist and next(suitlist)then
for k,suitid in ipairs(suitlist)do
local cfg=cfg_gubaosuitconfig_get(suitid)
if gubaoModel:checkSuitActive1(suitid)then
local config=cfg.skill0
if config and config[3]then
local effectData=config[3]
for k,v in ipairs(effectData)do
local type=v[1]or 0
local attrId=v[2]
if type==122 then
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aGuBao,attrId)

end
end
end
end
if gubaoModel:checkSuitActive2(suitid)then
local config=cfg.skill3
if config and config[3]then
local effectData=config[3]
for k,v in ipairs(effectData)do
local type=v[1]or 0
local attrId=v[2]
if type==122 then
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aGuBao,attrId)

end
end
end
end
if gubaoModel:checkSuitActive3(suitid)then
local config=cfg.skill_1
if config and config[3]then
local effectData=config[3]
for k,v in ipairs(effectData)do
local type=v[1]or 0
local attrId=v[2]
if type==122 then
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aGuBao,attrId)

end
end
end
end
end
end
end


function xianjieController.onZongMenBuffFresh(buffId)



















local addValue=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eJunZhenAttr)
local changeList={}
if addValue and next(addValue)then
for attrId,v in pairs(addValue)do
if changeList[attrId]then
changeList[attrId]=changeList[attrId]+v
else
changeList[attrId]=v
end
end
end
if zmBuffValue and next(zmBuffValue)then
for attrId,v in pairs(zmBuffValue)do
if changeList[attrId]then
changeList[attrId]=changeList[attrId]-v
else
changeList[attrId]=-v
end
end
end

if next(changeList)then
for attrId,v in pairs(changeList)do
if v~=0 then
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aZMBuff,attrId)
end
end
zmBuffValue=addValue
end
end


function xianjieController.onXianJieBuffFresh(buffId)

local effectData=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffId,'effects')
local scene=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffId,'scene')
if scene and next(scene)~=nil then return end

for k,v in ipairs(effectData)do
local type=v[1]
local attrId=v[2]
if type==2 then
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aXJBuff,attrId)

end
end
end

function xianjieController.onXCEquipChange(pos,equip)
if equip then
local affixList=xingChenHelper.getAffixList(equip)
for i,v in ipairs(affixList)do
local cfg=cfgHelper.get(cfg_starsaffixconfig_get,v)
if cfg~=nil and cfg.jz_effects~=nil then
for __,v2 in ipairs(cfg.jz_effects)do
local attrId=v2[1]
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aLittleWorld,attrId)
end
end
end
if equip.itemData.fin_rare_id and equip.itemData.fin_rare_id~=0 then
local cfg=cfgHelper.get(cfg_starsrareconfig_get,equip.itemData.fin_rare_id)
if cfg and cfg.jz_effects then
for __,v2 in ipairs(cfg.jz_effects)do
local attrId=v2[1]
xianjieModel:setDirty(SYSTEM_ATTRIBUTE_TYPE.aLittleWorld,attrId)
end
end
end
end
end
