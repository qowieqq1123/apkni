


parentNode=simple_class(baseNode)

local _insert=table.insert

function parentNode:awake()
self.children={}
end

function parentNode:start()
parentNode._base.start(self)
for i,v in ipairs(self.children)do
v:start()
end
end

function parentNode:reset()
parentNode._base.reset(self)
for i,v in ipairs(self.children)do
v:reset()
end
end

function parentNode:broke()
for i,v in ipairs(self.children)do
v:broke()
end
end


function parentNode:addChild(node)
if#self.children<self:maxChildren()then
_insert(self.children,node)
end
end

function parentNode:getChildren()
return self.children
end



function parentNode:getChild(index)
return self.children[index]
end


function parentNode:getRandomChildList()
if self.children then
local list={}
for i,v in ipairs(self.children)do
list[i]=v
end
local len=#list
for i=1,len do
local r=math.random(1,len)
local v=list[i]
list[i]=list[r]
list[r]=v
end
return list
end
end