airActorSystem={}


function airActorSystem:onAppStart()

end

function airActorSystem:onEnterState(isReconnect)

end


function airActorSystem:onLeaveState(isReconnect)

end

function airActorSystem:onProtocolReq(isReconnect)

end

function airActorSystem:enterAirGame()
self.hudhandle=nil
end

function airActorSystem:leaveAirGame()
self.hudhandle=nil
end


function airActorSystem:setActor(ent)
self.ent=ent
end

function airActorSystem:hasActor()
return self.ent~=nil
end

function airActorSystem:getActorPosition2D()
if self.ent==nil then return end
return airEntitySystem:getPosition2D(self.ent)
end

function airActorSystem:getActor()
return self.ent
end

function airActorSystem:getHandle()
return self.ent and self.ent.handle or nil
end

function airActorSystem:getActorPosition()
return self.ent:getPosition()
end

function airActorSystem:onMove(screenPoint)
if self.ent==nil then return end
self.ent:onMove(screenPoint)
end

function airActorSystem:onMoveEnd()
self.moveDirection=nil
end

function airActorSystem:setMoveDelta(x,z)
self.moveDirection={x,z}
end

function airActorSystem:getMoveDirection()
if self.moveDirection then
local x=self.moveDirection[1]
local z=self.moveDirection[2]
return Vector3.New(x,0,z)
else
local ent=airActorSystem:getActor()
local flipX=ent.flipX
return flipX and Vector3.right or Vector3.left
end
end

function airActorSystem:setRoleMoveSpeed(speed)
if self.ent==nil then return end
self.ent.moveSpeed=speed
end


function airActorSystem:getEquips()
local processData=airModel:getActorProcessData()
return processData and processData.equipBag or nil
end


function airActorSystem:getItemBag()
local processData=airModel:getActorProcessData()
return processData and processData.itemBag or nil
end

function airActorSystem:createActor()
if self.ent then return true end
if self.hudhandle then
airHUDSystem:deleteEntityAllHUD(self.hudhandle)
self.hudhandle=nil
end

local isInit=airModel:initActorData()
airModel:initStatisticData()
local dzguid=airGameEnterModel:getSelectDisciple()
local mountguid=airGameEnterModel:getMount()
local attrs=airGameEnterModel:getGameInitAttrList(dzguid)
local attrLookup=attrListHelper.tramsformToLookup(attrs)
local voc=UIDiscipleModel:getDiscipleJob(dzguid)

local args={}
args.extraAttrs=attrLookup
args.mountguid=mountguid
args.dzguid=dzguid
local ent=airEntitySystem:createRoleEntity(voc,args)
airActorSystem:createRoleHUD()

local processData=airModel:getActorProcessData()
processData.isInit=nil
airModel:setActorProcessData(processData)
if isInit or
processData.allBuff==nil or
#processData.allBuff<=0 then
airActorSystem:clearAllBuffData(ent,processData)
airActorSystem:addAllItemBuff(ent)
ent:updateExtraAttrs()
end
end

function airActorSystem:clearAllBuffData(ent,processData)
processData.allBuff=nil
processData.chixuDamage=nil
processData.buffLookup=nil
processData.buffDelayList=nil
processData.buffSameConver=nil
processData.buffguid=0
end

function airActorSystem:addAllItemBuff(ent)
local dzguid=airGameEnterModel:getSelectDisciple()
local voc=UIDiscipleModel:getDiscipleJob(dzguid)
local items=cfgHelper.get2(cfg_airvocationconfig_get,voc,'items')or{}
for _,v in ipairs(items)do
airModel:addBuffOnAddItem(ent,v)
end
end

function airActorSystem:deleteActor()
airActorSystem:setActor(nil)
end

function airActorSystem:showCommonDamageBehaiour()
UIManager:callWindowFunc('UIAirMiniGameMainWin','startDamage')
end

function airActorSystem:createRoleHUD()
local handle=airActorSystem:getHandle()
if handle and self.hudhandle==nil then
if airHUDSystem:createHpHUD(eAirEntityType.TYPE_ROLE,handle)then
self.hudhandle=handle
end
end
end

function airActorSystem:deleteRoleHUD(handle)
if self.hudhandle==handle then
self.hudhandle=nil
end
end

function airActorSystem:getOrder()
return self.ent:getSortingOrder()
end

function airActorSystem:resetRolePosition()
if self.ent==nil then return end
self.ent:setPosition(Vector3.zero)
end


function airActorSystem:getMountSkillid()
local ent=airActorSystem:getActor()
return ent:getMountSkill()
end

function airActorSystem:getRoleSkillid()
local ent=airActorSystem:getActor()
return ent:getRoleSkill()
end

function airActorSystem:isCoolDownSkill(skillid)
local ent=airActorSystem:getActor()
if ent==nil then return false end
return ent:isCoolDown(skillid)
end

function airActorSystem:getCoolDownSkill(skillid,toInt)
local ent=airActorSystem:getActor()
local value=ent:getCoolDownTime(skillid)
if toInt then
value=math.ceil(value)
end
return value
end

function airActorSystem:castSkillOnTarget(skillid,target,args)
local ent=airActorSystem:getActor()
if ent==nil or ent:isDeleteSelf()then return-2 end
return ent:castSkill(skillid,target,args)
end

function airActorSystem:castMountSkill(args)
local skillid=airActorSystem:getMountSkillid()
local direction=airActorSystem:getMoveDirection()
local pos=airActorSystem:getActorPosition()
local args_={direction=direction,pos=pos}
if args then
for k,v in pairs(args)do
args_[k]=v
end
end
return airActorSystem:castSkillOnTarget(skillid,nil,args_)
end


function airActorSystem:addBuff(buffid,level,caster)
if self.ent==nil then return end
return airBuffSystem:addBuff(self.ent,buffid,level,caster)
end

function airActorSystem:removeBuff(buffguid)
if self.ent==nil then return end
return airBuffSystem:removeBuff(self.ent,buffguid)
end

function airActorSystem:printBuff()
local ent=airActorSystem:getActor()
if ent then
ent:printBuff()
end
end




function airActorSystem:getActorBaseAttrList_lookup()
local ent=airActorSystem:getActor()
local attrList_lookup=ent:getAttrs()
return attrList_lookup
end


function airActorSystem:getActorAttrList_lookup()
local ent=airActorSystem:getActor()






local attrList_lookup=ent:getAttrs()


local finalAttrList={}
for attrId,attrVal in pairs(attrList_lookup)do
local finalVal=ent:getAttrValue(attrId,true)
finalAttrList[attrId]=finalVal
end

return finalAttrList
end


function airActorSystem:getActorBaseAttrValByAttrId(attrId)
local ent=airActorSystem:getActor()
local attrVal=ent:getBaseAttrValue(attrId)
return attrVal
end


function airActorSystem:getActorAttrValByAttrId(attrId)
local ent=airActorSystem:getActor()
local attrVal=ent:getAttrValue(attrId)
return attrVal
end


function airActorSystem:getActorClampAttrVal(attrId,attrVal)
local ent=airActorSystem:getActor()
if ent then
attrVal=ent:clampAttr(attrId,attrVal)
end
return attrVal
end


function airActorSystem:getActorAttrAddPercentByAttrId(attrId)
local ent=airActorSystem:getActor()
local attrP=ent:getAttr_P(attrId)
return attrP
end


function airActorSystem:getActorClampAttrMaxVal(attrId)
local ent=airActorSystem:getActor()
local attrMaxVal
if ent then
attrMaxVal=ent:getClampAttrTop(attrId)
end
return attrMaxVal
end


function airActorSystem:getActorModelParam()
local discipleGuid=airGameEnterModel:getSelectDisciple()
local modelParam
if discipleGuid then
local args={
tmLv=UIDiscipleModel:getTianMingLevel(discipleGuid)
}
modelParam=UIDiscipleModel:getDiscipleOutsideModelInfo(discipleGuid,false,1,args)
else
local cfg=cfgHelper.get(cfg_airroleconfig_get,1)
modelParam={}
modelParam.body=cfg.spineid
local spineCfg=cfgHelper.get1(cfg_dbbodyconfig_get,cfg.spineid)

modelParam.anim=spineCfg and spineCfg.mountAni or eAnimationID.stand
local scales=spineCfg and spineCfg.scales or{}

modelParam.scale=scales[1]or 1
modelParam.componets={}
end

return modelParam
end

function airActorSystem:getActorMountModelParams()
local discipleGuid=airGameEnterModel:getSelectDisciple()
local mountModelParams
local node
local hasMount=false
local mountData
local scale
if discipleGuid then
local baseRoleInfo=airGameEnterModel:getGameBaseRoleInfo(discipleGuid)
local mountItemGuid=baseRoleInfo.mountItemGuid
mountData=mountModel:getMount(mountItemGuid)or itemsModel.getItem(mountItemGuid)
hasMount=mountItemGuid~=nil and mountData~=nil
end

if hasMount then
local mountItemId=mountData.itemid
local mountItemCfg=itemsConfig.getConfig(mountItemId)
mountModelParams=mountItemCfg.model
node=mountItemCfg.node or'zuoqidian'

local modelId=mountModelParams.model
local scaleArgs=cfgHelper.get2(cfg_dbbodyconfig_get,modelId,'scales')or{}
scale=scale or scaleArgs[2]or 1
else
mountModelParams={
model=1110010,
offset={0,0,0},
}
node=""
scale=1.5
end

return mountModelParams,node,scale
end

function airActorSystem:checkActorEquipIsFull()
local equipItemList=airModel:getEquipList()or{}
local maxEquipCount=6
return#equipItemList>=maxEquipCount
end

function airActorSystem:getActorSameEquipIndex(itemId,equipIndex)
local equipItemList=airModel:getEquipList()or{}
for i,v in ipairs(equipItemList)do
if not equipIndex or i~=equipIndex then
if v==itemId then
return i
end
end
end
return nil
end

function airActorSystem:getActorSameTypeEquipCount(equipType)
local equipItemList=airModel:getEquipList()or{}
local count=0
for i,v in ipairs(equipItemList)do
local itemId=v
local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
if itemCfg.type1==equipType then
count=count+1
end
end
return count
end

function airActorSystem:getActorSameSuitEquipCount(suitId)
local equipItemList=airModel:getEquipList()or{}
local count=0
for i,v in ipairs(equipItemList)do
local itemId=v
local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
if itemCfg.suit and itemCfg.suit==suitId then
count=count+1
end
end
return count
end

function airActorSystem:checkActorCanLevelUp()
local nowLevel=airModel:getLevel()
local roleCfg=cfgHelper.get(cfg_airroleconfig_get,1)
local maxLevel=roleCfg.maxlevel
if nowLevel>=maxLevel then
return false
end
local nowExp=airModel:getExp()
local lvUpExpList_lookup=roleCfg.lvUpExp or{}
local lvUpNeedExp=lvUpExpList_lookup[nowLevel+1]
if lvUpNeedExp and nowExp>=lvUpNeedExp then
return true
end

return false
end

function airActorSystem:getLevelUpNeedExpByLevel(level)
local roleCfg=cfgHelper.get(cfg_airroleconfig_get,1)
local maxLevel=roleCfg.maxlevel
if level>=maxLevel then
return-1
end
local lvUpExpList_lookup=roleCfg.lvUpExp or{}
local lvUpNeedExp=lvUpExpList_lookup[level+1]
return lvUpNeedExp
end


function airActorSystem:getShopPrice(price,type,itemId,itemType)
local addValue,addValue_P=airBuffSystem:getAddItemPrice(type,itemId,itemType)
if type==1 then
local role=airActorSystem:getActor()
addValue_P=addValue_P+role:getAttrValue(aiAttributeType.ePriceReduct)
end
if addValue~=0 then
price=price+addValue
end
if addValue_P~=0 then
price=math.ceil(price*(1+addValue_P/10000))
end
return price
end

function airActorSystem:isXuanYunStatus()

end


