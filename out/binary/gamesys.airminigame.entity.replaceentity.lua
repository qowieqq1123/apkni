replaceEntity=simple_class(lifeEntity)



function replaceEntity:initialize(args)
replaceEntity._base.initialize(self)
self.caster=args.caster
self.curAttrs=table.weakCopy(self.caster.curAttrs)
end

function replaceEntity:onDelete()
if self==nil or self:isDeleteSelf()then return end
replaceEntity._base.onDelete(self)
end


function replaceEntity:getAttrValue(attributeType,really)
local attributeCfg=cfg_airattributesconfig_get(attributeType)
local old=self:getBaseAttrValue(attributeType)
local value_p=0
local relevantAttr=attributeCfg.relevantAttr
if relevantAttr then
if relevantAttr==attributeType then
loggerUtil.logErrFMT('关联属性不能是本属性：{0}',attributeType)
return 0
end
value_p=value_p+self:getAttrValue(relevantAttr,really)
end
if value_p~=0 then
if airConfig.isAttr_P(attributeType)then
old=old+value_p
else
old=old+math.floor(old*value_p/10000)
end
end
old=self:clampTopAttr(attributeCfg,old)
if not really then
old=self:clampAttr(attributeType,old)
end
return old
end

function replaceEntity:getBaseAttrValue(attributeType)
return self.curAttrs[attributeType]or 0
end

function replaceEntity:onAttack(target)

end

function replaceEntity:onReflect(target)

end


function replaceEntity:postDelete()

end