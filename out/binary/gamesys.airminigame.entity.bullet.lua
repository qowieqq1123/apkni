bullet=simple_class(baseEntity)

function bullet:initialize()

end

function bullet:onUpdate(delta)

end

function bullet:onDelete()
self._base.onDelete(self)
end



function bullet:onTriggerEnterMonster(entity)

end

function bullet:onDamageMonster(monster)

end