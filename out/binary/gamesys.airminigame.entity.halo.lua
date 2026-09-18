halo=simple_class(baseEntity)


function halo:initialize(args)
self.targetTeamType=args.targetTeamType
self:addMainColliderByCfg()
self:addPostDelete()
end

function halo:onDelete()
if self==nil or self:isDeleteSelf()then return end
halo._base.onDelete(self)
end

function halo:onUpdate()
halo._base.onUpdate(self)
end

function halo:onPause()
halo._base.onPause(self)

end

function halo:onContinue()
halo._base.onContinue(self)

end

function halo:onFastUpdate()
halo._base.onFastUpdate(self)

end


function halo:onRemoveEntity(handle)
halo._base.onRemoveEntity(self,handle)
if handle==self.target then
self.target=nil
self.entity:UnBindEntity()
end
end