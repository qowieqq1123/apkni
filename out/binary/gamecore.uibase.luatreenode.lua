






LuaTreeNode=simple_class(UIWidgetRef)


function LuaTreeNode:__init(gameObject,ListView,space)
self.space=space or 2

self.mLuaListView=ListView

self.mLayoutHeight=self.transform.sizeDelta.y

self.mLayoutWidth=self.transform.sizeDelta.x
end


function LuaTreeNode:InitTreeNode(name)
local childName=name and name or"GridLayout"


local FindTreeNode=self.transform:Find(childName)
if FindTreeNode then

local GridLayout=FindTreeNode:GetComponent("GridLayoutGroup")
if GridLayout then
local LuaGridView=LuaGridView(GridLayout.gameObject,GridLayout)
LuaGridView.OnSizeChangeCall=function(width,height)
self:UpdateContentSize(height)
end

self.mTreeNode=LuaGridView return
end

self.mTreeNode=FindTreeNode.gameObject
end
end


function LuaTreeNode:GetTreeNode()
return self.mTreeNode
end


function LuaTreeNode:AddClickEvent()
local touch=self.gameObject:AddComponent(typeof(CS.TouchEvent))
touch.OnClickListen=function(o)self:OnTreeNodeClick(o)end
end

function LuaTreeNode:SetClickCallback(callback)
self.mClickCallback=callback
end


function LuaTreeNode:OnTreeNodeClick()
self:OnTreeNodeExpand(not self:IsExpand())

if self.mClickCallback then
self.mClickCallback(self)
end
end


function LuaTreeNode:IsExpand()
return self.mTreeNode and self.mTreeNode.gameObject.activeSelf
end


function LuaTreeNode:OnTreeNodeExpand(expand)
if not self.mTreeNode or expand==self:IsExpand()then return end

self.mTreeNode.gameObject:SetActive(expand)

local expandType=2

local value=expandType==2 and self.mTreeNode.transform.sizeDelta.y or self.mTreeNode.transform.sizeDelta.x


self:UpdateContentSize(value)
end


function LuaTreeNode:UpdateContentSize(value)

local newHeight=self.mLayoutHeight+self.space
if self:IsExpand()then
newHeight=newHeight+value
end


local sizeDelta=self.transform.sizeDelta
sizeDelta.y=newHeight
self.transform.sizeDelta=sizeDelta


if self.mLuaListView then
local index=self.mLuaListView:IndexOf(self)
self.mLuaListView:UpdateContentSize(index)
end




















end
