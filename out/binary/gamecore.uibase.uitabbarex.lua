







UITabBarEx=simple_class(UITabBar)

function UITabBarEx:__init(tab_list,callback,disable_callback,isMoreClick)
self._isMoreClick=isMoreClick or false
self.toggles_select_img={}
self.togglesObj={}

otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)
local obj=handle_toggle.transform:Find('SelectBg').gameObject
local img=ComponentHelper.GetComponent(obj,UI.Image)
self.toggles_select_img[#self.toggles_select_img+1]=img.gameObject
table.insert(self.togglesObj,handle_toggle.gameObject)
end)
end

function UITabBarEx:__delete()
self.toggles_select_img=nil
self._isMoreClick=nil
end

function UITabBarEx:SetRed(uiname,pos)
local data=RedManager:GetData(uiname)
if not data then return end

if not pos then
for k,red in pairs(data.redTab)do
local num=0
for i,v in ipairs(red)do
num=v+num
end
RedHelper.SetRedDoc(self.toggles[k],num)
end
else
for k,num in ipairs(data.redTab[pos])do
RedHelper.SetRedDoc(self.toggles[k],num)
end
end
end


function UITabBarEx:SetTogglesVisible(uiname,pos)
local cnf=MenuLogic.GetCnfMenuByName(uiname)
if not cnf.tabUnlockCond[1]then return end

local function SetVisible(index,show)
if show then return end
if self.togglesObj[index]then
self.togglesObj[index]:SetActive(show)
end
end

if not pos then

for i,data in ipairs(cnf.tabUnlockCond)do
local show=false
for k,cond in ipairs(data)do
if MenuLogic.CheckTabIsOpen(cond)then
show=true
break
end
end

SetVisible(i,show)
end
else
local data=cnf.tabUnlockCond[pos]
for k,cond in ipairs(data or{})do
SetVisible(k,MenuLogic.CheckTabIsOpen(cond))
end
end
end

function UITabBarEx:UpdateSelected(index)
if not self.toggles_state[index]then
if self.disable_callback then
self.disable_callback(index)
end
self.state_lock=true
otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)
handle_toggle.isOn=self.select_index==index
end)
self.state_lock=false
return
end
if self.select_index==index and not self._isMoreClick then
return
end

self.select_index=index

for i=1,#self.toggles_select_img do
self.toggles_select_img[i]:SetActive(i==self.select_index)
end

self:ExecuteSelect()
end

function UITabBarEx:ShowSelected(index)
if not self.toggles_state[index]then
if self.disable_callback then
self.disable_callback(index)
end
self.state_lock=true
otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)
handle_toggle.isOn=self.select_index==index
end)
self.state_lock=false
return
end

if self.select_index==index and not self._isMoreClick then
return
end

self.select_index=index

for i=1,#self.toggles_select_img do
self.toggles_select_img[i]:SetActive(i==self.select_index)
end
end