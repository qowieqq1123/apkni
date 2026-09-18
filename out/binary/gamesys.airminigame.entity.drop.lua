drop=simple_class(baseEntity)


function drop:initialize(args)
self.num=1
local cfg=self.entityCfg
local dropid=cfg.id
self.dropid=dropid
if cfg==nil or cfg.speed==nil then
loggerUtil.logErrFMT('掉落物配置为空或速度配置为空：{0}',dropid)
end

local spriteName=FMT.fmt("icon_item_{0}",cfg.icon)
self.entity.MoveSpeed=cfg.speed or 20
self.delay=cfg.delay

self:setSpriteRender(spriteName)
self:setSpriteScale(cfg.scale)
self:addMainColliderByCfg()
self:setSelfSpriteSortingGroup()
self.singleNum=airDropSystem:getDropContainsNum(dropid)

self:lookAtCamera()
self:addPostDelete()
end

function drop:onDelete()
if self==nil or self:isDeleteSelf()then return end
self:removePostDelete()
if self.cb then
self.cb(self)
end
airDropSystem:removeDropEnt(self.handle)
self.target=nil
self.cb=nil
self.delay=nil
self.num=nil
self.moveFunc=nil
self.dropid=nil
self._base.onDelete(self)
end

function drop:onUpdate()
self._base.onUpdate(self)
if self.delayTime and self.delayTime<=Time.realtimeSinceStartup then
self:startMove()
end
end

function drop:onPause()
self._base.onPause(self)

end

function drop:onContinue()
self._base.onContinue(self)

end

function drop:onFastUpdate()
self._base.onFastUpdate(self)

end

function drop:onDeleteBefore()
self.cb=nil
end

function drop:getNum()
return self.num
end

function drop:startCollect(owner,cb)
local action
if cb then
self.cb=cb
action=function()
if self and not self:isDeleteSelf()then
cb(self)
self.cb=nil
self:deleteEntity()
end
end
end
self:enableCollider(-1,false)

self.action=action
local handle=owner.handle
self.target=handle
self.moveFunc=function()
self.entity:BindDropTarget(handle,0.1,action)
end
if self.delay then
self.delayTime=Time.realtimeSinceStartup+self.delay
else
self:startMove()
end
end

function drop:startMove()
self.moveFunc()
end

function drop:onDrop(entity)
local dropCfg=self.entityCfg
local type1=dropCfg.type1
local processData=airModel:getActorProcessData()
local isInSettlement=processData and processData.isInSettlement or false
if isInSettlement then

if type1~=eDropType.eBox then
return
end
end

local funcparam=dropCfg.funcparam
local dropid=self.dropid
local num=self.num

local multi=airBuffSystem:getAddDropMulti(dropid)
if multi>0 then
num=math.floor(num*(1+multi))
end
local tnum=self.singleNum*num
airDropSystem:addCollectDrop(dropid,num)
if type1==eDropType.eMoney then
airModel:addMoney(tnum)
local expMulti=cfgHelper.get2(cfg_aircommonconfig_get,1,'expMulti')
local value=tnum*expMulti
local addValue,addValue_P=airBuffSystem:getExpGainBuff()
if addValue>0 then
value=value+addValue
end
if addValue_P>0 then
value=value+value*addValue_P/10000
end
value=math.floor(value)
airModel:addExp(value)
UIManager:callWindowFunc('UIAirMiniGameMainWin','refreshExp')
elseif type1==eDropType.eBox then
airModel:addDropBox(dropid,num)
elseif type1==eDropType.eRestoreHP then
local addValue=funcparam.value or 0
local addValue_P=funcparam.value_p or 0
local addValue_,addValue_p_=airBuffSystem:getAddXiaoHaoPinRestoreEffect()
local addValue_RecoverHP=entity:getAttrValue(aiAttributeType.eRecoverHP)
addValue=addValue+addValue_
addValue_P=addValue_P+addValue_p_+addValue_RecoverHP
entity:onRestoreHPByDrop(addValue,addValue_P)
end
airDropSystem:onCollectDrop(entity,dropid,num)
end

function drop:checkDropId(dropId)
return dropId==-1 or dropId==self.dropId
end

function drop:checkDropType(type1,type2)
local dropCfg=self.entityCfg
return type1==-1 or dropCfg.type1==type1 and
type2==-1 or type2 and dropCfg.type2==type2 or type2==nil
end

function drop:onRemoveEntity(handle)
drop._base.onRemoveEntity(self,handle)
if handle==self.target then
self.target=nil
self.entity:UnBindEntity()
end
end