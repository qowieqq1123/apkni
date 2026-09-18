






LuaListView=simple_class(UIWidgetRef)
local ListType={
Vertical=1,
Horizonal=2,
}


function LuaListView:__init(gameObject)

self.mLuaNodeList={}
self.padding={left=0,right=0,top=0,bottom=0}
end


function LuaListView:__delete()
self.mScrollRect=nil
self.padding=nil
end


function LuaListView:Size()
return table.getn(self.mLuaNodeList)
end


function LuaListView:NodeList()
return self.mLuaNodeList
end


function LuaListView:GetNodeAt(index)
return self.mLuaNodeList[index]
end


function LuaListView:IndexOf(gameObject)
for i,node in pairs(self.mLuaNodeList)do
if node==gameObject then return i end
end

return-1
end


function LuaListView:InitListView(Formater,count,HanderScript,...)
for i=1,count do
local node=self:FindTransform(string.format(Formater,i))

if(HanderScript)then node=HanderScript(node.gameObject,...)end

self:Insert(#self.mLuaNodeList+1,node)
end
end


function LuaListView:AddNode(prefab,HanderScript,...)

local ListItem=GameObject.Instantiate(prefab)


if HanderScript then
ListItem=HanderScript(ListItem,...)
end



return self:Insert(#self.mLuaNodeList+1,ListItem)
end

local NodeNameFormat="Item_%s"


function LuaListView:Insert(index,node)



if index<1 or index>#self.mLuaNodeList+1 then
error("invalid index to add list view!")return nil
end

node.gameObject.name=string.format(NodeNameFormat,index)
node.gameObject:SetActive(true)
node.transform:SetParent(self.transform,false)
node.transform:SetSiblingIndex(index)

table.insert(self.mLuaNodeList,index,node)

self:UpdateContentSize(index)return node
end


function LuaListView:Remove(gameObject)
self:RemoveAt(self:IndexOf(gameObject))
end


function LuaListView:RemoveAt(index)
local node=self.mLuaNodeList[index]

if node then GameObject.Destroy(node.gameObject)end

table.remove(self.mLuaNodeList,index)

self:UpdateContentSize(index)
end


function LuaListView:RemoveAll()
if#self.mLuaNodeList>0 then
for _,node in pairs(self.mLuaNodeList)do
GameObject.Destroy(node.gameObject)
end

self.mLuaNodeList=nil
self.mLuaNodeList={}
end

self:UpdateContentSize(0)
end


function LuaListView:SetScrollRect(compoment)
self.mScrollRect=compoment
end


function LuaListView:SetGridLayoutGroupPadding(padding)
self.padding=padding
end


function LuaListView:SetVerticalNormalizedPosition(value)
if self.mScrollRect then

self.mScrollRect.verticalNormalizedPosition=1-value
end
end

function LuaListView:SetHorizonalNormalizedPosition(value)
if self.mScrollRect then

self.mScrollRect.horizonalNormalizedPosition=1-value
end
end

























function LuaListView:UpdateContentSize(index)
if index<0 or index>#self.mLuaNodeList then return end

local newPosX=0 local newPosY=0

local mLuaNodeList=self.mLuaNodeList



if#mLuaNodeList>0 then

local rectform=mLuaNodeList[index].transform
if(index==1)then index=index+1
rectform.anchoredPosition3D=Vector3(0,0)
end


rectform=mLuaNodeList[index-1].transform

newPosX=rectform.anchoredPosition3D.x
newPosY=-rectform.anchoredPosition3D.y+rectform.sizeDelta.y


for i=index,#mLuaNodeList do
rectform=mLuaNodeList[i].transform
rectform.anchoredPosition3D=Vector3(newPosX,-newPosY)

newPosY=newPosY+rectform.sizeDelta.y
end
end



local sizeDelta=self.transform.sizeDelta
sizeDelta.y=newPosY
self.transform.sizeDelta=sizeDelta


if self.OnSizeChangeCall then self.OnSizeChangeCall(sizeDelta.x,sizeDelta.y)end


end


