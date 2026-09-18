










local _helper=CS.UIHelper
UIToggleGroup=simple_class()
function UIToggleGroup:__init(gameObject,winLua,toggleCount,selectCallback)
self.gameObject=gameObject
self.winlua=winLua
self.toggleCount=toggleCount
self.toggleList={}
self.onSelectAction=selectCallback

self:InitToggle()
end

function UIToggleGroup:__delete()
self:DestoryAllToggle()

self.gameObject=nil
self.winlua=nil
self.toggleList=nil
end

function UIToggleGroup:Destory()
self:deleteSelf()
end


function UIToggleGroup:SelectToggleByIndex(index)
if self.toggleList~=nil then
for i,v in ipairs(self.toggleList)do
if i==index then
v:IsOn(true)
else
v:IsOn(false)
end
end

self.onSelectAction(index)
end
end

function UIToggleGroup:SelectToggle(toggle)
if self.preSelectCallback then
if not self.preSelectCallback(toggle.index)then
return
end
end

self:SelectToggleByIndex(toggle.index)
end



function UIToggleGroup:SetPreSelectCallback(preSelectCallback)
self.preSelectCallback=preSelectCallback
end


function UIToggleGroup:RefreshToggleRedPointActiveState(index,state)
if self.toggleList[index]~=nil then
self.toggleList[index]:SetRedPointActiveState(state)
end
end



function UIToggleGroup:InitToggle()
for i=1,self.toggleCount do
local toggleWinLua=self.winlua:GetChildWindowLua(i-1)
if i>=5 then
toggleWinLua=self.winlua:GetChildWindowLua(i+6)
end
local toggle=UIToggle(self,toggleWinLua,i)
self:RegisterToggle(toggle)
end
end

function UIToggleGroup:RegisterToggle(toggle)
self.toggleList[toggle.index]=toggle
end

function UIToggleGroup:UnregisterToggle(toggle)
self.toggleList[toggle.index]=nil
toggle:Destory()
end

function UIToggleGroup:DestoryAllToggle()
if self.toggleList~=nil then
for i,_ in ipairs(self.toggleList)do
self:UnregisterToggle(self.toggleList[i])
end
end
end
