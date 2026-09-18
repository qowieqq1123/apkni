def_class('fBTBaseNode',{})

function fBTBaseNode:__init(_guid)
self.guid=_guid
self.state=fBTNodeState.inactive
self.typo=fBTNodeTypo.None
end

function fBTBaseNode:getTypo()
return self.typo
end

function fBTBaseNode:getName()
return fBTNodeTypoName[self.typo]
end

function fBTBaseNode:awake()

end

function fBTBaseNode:start()

end


function fBTBaseNode:update(delta)

return self.state
end

function fBTBaseNode:onEnd()

end

function fBTBaseNode:onComplete()

end

function fBTBaseNode:onDespawn()
self.state=fBTNodeState.inactive
fBTNodePool.recycle(self)
end

