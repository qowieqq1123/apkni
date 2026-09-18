







UITabBarHL=simple_class(UITabBar)

function UITabBarHL:__init(tab_list,callback,disable_callback,isMoreClick)
self._isMoreClick=isMoreClick or false
self:initToggles()
end

function UITabBarHL:initToggles()
self.toggles_select_img={}
self.toggles_nor_img={}
self.togglesObj={}
self.redObj={}

otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)
self.toggles_select_img[index]=EngineTools.FindGameObject(handle_toggle,'SelectBg')
self.toggles_nor_img[index]=EngineTools.FindGameObject(handle_toggle,'NorBg')
self.togglesObj[index]=handle_toggle.gameObject
self.redObj[index]=handle_toggle.gameObject
end)
end

function UITabBarHL:__delete()
self.toggles_select_img=nil
self._isMoreClick=nil
end

function UITabBarHL:SetTabVisible(index,show)
if self.togglesObj[index]then
self.togglesObj[index]:SetActive(show)
end
end

function UITabBarHL:SetOpen(openList)
self.openList=openList
end

function UITabBarHL:UpdateSelected(index)
if self.openList and not self.openList[index].isOpen then
CommonLogic.SendPlayerNotify(self.openList[index].tips)
return
end
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
if self.toggles_select_img[i]then
self.toggles_select_img[i]:SetActive(i==self.select_index)
end
if self.toggles_nor_img[i]then
self.toggles_nor_img[i]:SetActive(i~=self.select_index)
end
end

self:ExecuteSelect()
end

function UITabBarHL:SetRedWithData(data,boolShowNum)
for k,num in ipairs(data)do
if boolShowNum then
RedHelper.SetRedDoc(self.redObj[k],num,num)
else
RedHelper.SetRedDoc(self.redObj[k],num)
end
end
end

function UITabBarHL:SetRed(uiname,pos,boolShowNum)
local data=RedManager:GetData(uiname)
if not data then return end

if not pos then
for k,red in pairs(data.redTab)do
local num=0
for i,v in ipairs(red)do
num=v+num
end
if boolShowNum then
RedHelper.SetRedDoc(self.redObj[k],num,num)
else
RedHelper.SetRedDoc(self.redObj[k],num)
end
end
else
for k,num in ipairs(data.redTab[pos])do
if boolShowNum then
RedHelper.SetRedDoc(self.redObj[k],num,num)
else
RedHelper.SetRedDoc(self.redObj[k],num)
end
end
end
end


function UITabBarHL:SetTogglesVisible(uiname,pos)
local cnf=MenuLogic.GetCnfMenuByName(uiname)
if cnf.tabUnlockCond==nil then return end
if not cnf.tabUnlockCond[1]then return end

local function SetVisible(index,show)

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

function UITabBarHL:SetLock(uiname,pos)
local cnf=MenuLogic.GetCnfMenuByName(uiname)
if not cnf.tabUnlockCond[1]then return end

local function SetVisible(index,show)
if self.toggles_list[index]and not show then
self.toggles_list[index].transform:Find('Lock').gameObject:SetActive(true)
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