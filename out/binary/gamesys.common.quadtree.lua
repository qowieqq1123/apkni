

















































local quadtree={}

function quadtree:__init(x1,y1,x2,y2,maxDepth,maxChildCound)

self.rect={x1,y1,x2,y2,0,0}

self.root=createQuadtreeNode(self.rect,0,self)

self.maxDepth=maxDepth or 5

self.maxChildCound=maxChildCound or 4
end

function quadtree:__delete()
self.rect=nil
self.maxDepth=nil
self.maxChildCound=nil
if self.root then
releaseQuadtreeNode(self.root)
self.root=nil
end
end


function quadtree:insertObj(obj)
if self.root then
if obj.m_rect then
self.root:insertObj_rect(obj)
elseif obj.m_line then
self.root:insertObj_line(obj)
else
self.root:insertObj(obj)
end
end
end


function quadtree:removeObj(obj)
if self.root then
if obj.m_rect then
return self.root:removeObj_rect(obj)
elseif obj.m_line then
return self.root:removeObj_line(obj)
else
return self.root:removeObj(obj)
end
end
end



function quadtree:queryRange(result,x1,y1,x2,y2)
if self.root then
self.root:queryRange(result,x1,y1,x2,y2)
end
end



local num=1
local pool={}

function createQuadtree(x1,y1,x2,y2,maxDepth,maxChildCound)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={
__index=quadtree,
}
setmetatable(newT,mT)
end
newT:__init(x1,y1,x2,y2,maxDepth,maxChildCound)
return newT
end

function releaseQuadtree(tree)
if tree==nil then return end
tree:__delete()
if#pool>=num then
return
end
table.insert(pool,tree)
end
