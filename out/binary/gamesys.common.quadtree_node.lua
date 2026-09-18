








local quadtreeNode={}

function quadtreeNode:__init(rect,depth,tree)

self.rect=rect

self.tree=tree

self.depth=depth

self.objects_lp={}

self.nodes=nil
end

function quadtreeNode:__delete()
self.rect=nil
self.tree=nil
self.depth=nil
self.objects_lp=nil
if self.nodes then
for i,node in ipairs(self.nodes)do
releaseQuadtreeNode(node)
end
self.nodes=nil
end
end


function quadtreeNode:insertObj(obj)
local node=nil

if self.depth<self.tree.maxDepth and self.nodes==nil then
self:createChild()
end
if self.nodes~=nil then
for i,node_ in ipairs(self.nodes)do
local rect_=node_.rect
if mathHelper.posInRect(obj.l_x,obj.l_y,rect_[1],rect_[2],rect_[3],rect_[4])then
node=node_
break
end
end
end
if node then
node:insertObj(obj)
else
self.objects_lp[obj.m_ojbID]=obj
end
end


function quadtreeNode:insertObj_rect(obj)

if self.depth<self.tree.maxDepth and self.nodes==nil then
self:createChild()
end
local flag=false
if self.nodes~=nil then
local rect=obj.m_rect
for i,node_ in ipairs(self.nodes)do
local rect_=node_.rect
if mathHelper.rectCrashRect(rect[1],rect[2],rect[3],rect[4],rect_[1],rect_[2],rect_[3],rect_[4])then
flag=true
node_:insertObj_rect(obj)
end
end
end
if not flag then
self.objects_lp[obj.m_ojbID]=obj
end
end


function quadtreeNode:insertObj_line(obj)

if self.depth<self.tree.maxDepth and self.nodes==nil then
self:createChild()
end
local flag=false
if self.nodes~=nil then
local line=obj.m_line
for i,node_ in ipairs(self.nodes)do
local rect_=node_.rect
if mathHelper.lineCrashRect(line[1],line[2],line[3],line[4],rect_[1],rect_[2],rect_[3],rect_[4])then
flag=true
node_:insertObj_line(obj)
end
end
end
if not flag then
self.objects_lp[obj.m_ojbID]=obj
end
end


function quadtreeNode:removeObj(obj)
if self.objects_lp then
if self.objects_lp[obj.m_ojbID]then
self.objects_lp[obj.m_ojbID]=nil
return true
end
end
if self.nodes~=nil then
for i,node_ in ipairs(self.nodes)do
local rect_=node_.rect
if mathHelper.posInRect(obj.l_x,obj.l_y,rect_[1],rect_[2],rect_[3],rect_[4])then
return node_:removeObj(obj)
end
end
end
return false
end


function quadtreeNode:removeObj_rect(obj)
local flag=false
if self.objects_lp then
if self.objects_lp[obj.m_ojbID]then
self.objects_lp[obj.m_ojbID]=nil
flag=true
end
end
if self.nodes~=nil then
local rect=obj.m_rect
for i,node_ in ipairs(self.nodes)do
local rect_=node_.rect
if mathHelper.rectCrashRect(rect[1],rect[2],rect[3],rect[4],rect_[1],rect_[2],rect_[3],rect_[4])then
if node_:removeObj_rect(obj)then
flag=true
end
end
end
end
return flag
end


function quadtreeNode:removeObj_line(obj)
local flag=false
if self.objects_lp then
if self.objects_lp[obj.m_ojbID]then
self.objects_lp[obj.m_ojbID]=nil
flag=true
end
end
if self.nodes~=nil then
local line=obj.m_line
for i,node_ in ipairs(self.nodes)do
local rect_=node_.rect
if mathHelper.lineCrashRect(line[1],line[2],line[3],line[4],rect_[1],rect_[2],rect_[3],rect_[4])then
if node_:removeObj_line(obj)then
flag=true
end
end
end
end
return flag
end



function quadtreeNode:queryRange(result,x1,y1,x2,y2)
if self.objects_lp then
for ojbID,obj in pairs(self.objects_lp)do
result[ojbID]=obj
end
end
if self.nodes~=nil then
for i,node_ in ipairs(self.nodes)do
local rect_=node_.rect
if mathHelper.rectCrashRect(x1,y1,x2,y2,rect_[1],rect_[2],rect_[3],rect_[4])then
node_:queryRange(result,x1,y1,x2,y2)
end
end
end
end


function quadtreeNode:createChild()
if self.nodes~=nil then return end

self.nodes={}

local rect=self.rect
local depth=self.depth+1
local rect_,node_

rect_={rect[1],rect[2],rect[5],rect[6]}
rect_[5]=rect_[1]+(rect_[3]-rect_[1])/2.0
rect_[6]=rect_[2]+(rect_[4]-rect_[2])/2.0
node_=createQuadtreeNode(rect_,depth,self.tree)
table.insert(self.nodes,node_)

rect_={rect[5],rect[2],rect[3],rect[6]}
rect_[5]=rect_[1]+(rect_[3]-rect_[1])/2.0
rect_[6]=rect_[2]+(rect_[4]-rect_[2])/2.0
node_=createQuadtreeNode(rect_,depth,self.tree)
table.insert(self.nodes,node_)

rect_={rect[1],rect[6],rect[5],rect[4]}
rect_[5]=rect_[1]+(rect_[3]-rect_[1])/2.0
rect_[6]=rect_[2]+(rect_[4]-rect_[2])/2.0
node_=createQuadtreeNode(rect_,depth,self.tree)
table.insert(self.nodes,node_)

rect_={rect[5],rect[6],rect[3],rect[4]}
rect_[5]=rect_[1]+(rect_[3]-rect_[1])/2.0
rect_[6]=rect_[2]+(rect_[4]-rect_[2])/2.0
node_=createQuadtreeNode(rect_,depth,self.tree)
table.insert(self.nodes,node_)
end



local num=10
local pool={}

function createQuadtreeNode(rect,depth,tree)
local newT
if#pool>0 then
newT=table.remove(pool)
else
newT={}
local mT={
__index=quadtreeNode,
}
setmetatable(newT,mT)
end
newT:__init(rect,depth,tree)
return newT
end

function releaseQuadtreeNode(node)
if node==nil then return end
node:__delete()
if#pool>=num then
return
end
table.insert(pool,node)
end