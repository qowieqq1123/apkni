






LuaTabView=simple_class()

function LuaTabView:__init(gameObject,SelectCallback)
self.mTabIndex=nil;

self.mTabItemList={};
self.mTabPageList={};

self.OnSelectChange=SelectCallback;
end


function LuaTabView:TabIndex()
return self.mTabIndex;
end


function LuaTabView:GetTabItem(index)
return self.mTabPageList[index];
end

local BtnNameFormat="TabButton%s";
local TabNameFormat="TabView%s";




function LuaTabView:InitTabList(gameObject,count)
local trans=gameObject.transform
for i=1,count do
local transform=trans:Find(string.format(BtnNameFormat,i));
local tabButton=transform:GetComponent(typeof(UI.Button));

local transform=trans:Find(string.format(TabNameFormat,i));

self:AddTabItem(tabButton,transform);
end
end


function LuaTabView:AddTabItem(button,layout)
if(not button)then error("error!, add tab button is null.")end

local index=#self.mTabItemList+1;

table.insert(self.mTabItemList,index,button);
table.insert(self.mTabPageList,index,layout);

self:UpdateSelectState(index,true);

button.onClick:AddListener(function()self:SetSelected(index);end);
end


function LuaTabView:SetSelectCallback(callback)
self.OnSelectChange=callback;
end


function LuaTabView:SetSelected(index)


if(self.mTabIndex)then
self:UpdateSelectState(self.mTabIndex,true);
end

self.mTabIndex=index;

self:UpdateSelectState(index,false);


if(self.OnSelectChange)then
self.OnSelectChange(index,self.mTabPageList[index]);
end
end


function LuaTabView:SetTabVisible(index,visible)
if(self.mTabItemList[index])then
self.mTabItemList[index].gameObject:SetActive(visible);
end
end


function LuaTabView:UpdateSelectState(index,enable)
self.mTabItemList[index].interactable=enable;

if(self.mTabPageList[index])then
self.mTabPageList[index].gameObject:SetActive(not enable);
end
end
