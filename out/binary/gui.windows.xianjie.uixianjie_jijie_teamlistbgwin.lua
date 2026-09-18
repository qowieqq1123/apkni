







def_class("UIXianJie_JiJie_teamListBgWin",UIWindowBase)









function UIXianJie_JiJie_teamListBgWin:bindComponents()

self.menuGridPanel=UIObject.get(self,0)



end


function UIXianJie_JiJie_teamListBgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
end
















local pageConfig=
{
[1]={
page=1,
win='UIXianJie_JiJie_teamListMonsterWin',
name='魔物',
checkReddot=function()
return xianjieModel:getJiJieDirtyDataTypeNum(xjJjJieBaseType.eMonster)
end,
checkOpen=function()
return true
end
},
[2]={
page=2,
win='UIXianJie_JiJie_teamListWarWin',
name='战争',
checkReddot=function()
return xianjieModel:getJiJieDirtyDataTypeNum(xjJjJieBaseType.eWar)
end,
checkOpen=function()
return true
end
},
[3]={
page=3,
win="UIMoJie_JiJie_teamListMonsterWin",
name="魔界",
checkReddot=function()
return xianjieModel:getJiJieDirtyDataTypeNum(xjJjJieBaseType.eMoJie)
end,
checkOpen=function()
return xianjieModel:checkCurrentMoJieEnterTime()
end
}
}
local _this=nil
local menu_slot_name='button_dytab'




function UIXianJie_JiJie_teamListBgWin:onLoaded(...)
_this=self
self:bindComponents()
self.winList={}
self.pageLookup={}
self.openPageConfig={}

for index,config in ipairs(pageConfig)do
if config.checkOpen and config.checkOpen()then
self.openPageConfig[#self.openPageConfig+1]=config
end
end

for i,v in ipairs(self.openPageConfig)do
self.pageLookup[v.page]=i
end
end


function UIXianJie_JiJie_teamListBgWin:__delete()
_this=nil
self:unbindComponents()
for win,v in pairs(self.winList)do
UIManager:closeWindow(win)
end
self.winList=nil
end




function UIXianJie_JiJie_teamListBgWin:onShow(argtable,afterOnloaded)
local page=1
if argtable then
if argtable.page then
page=argtable.page
end
if argtable.extraArgs then
self.extraArgs=argtable.extraArgs
end
end
local idx=self.pageLookup[page]
if afterOnloaded then
local cnt=#self.openPageConfig
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=self.openPageConfig[i]
item:SetChildText(1,cfg.name)
local isSelected=i==idx
local func=function()
if _this==nil then return end
if isSelected then
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
self:refreshMenuItemSelect(item,i,isSelected)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end
self:onMenuItemClick(idx)
end


function UIXianJie_JiJie_teamListBgWin:onHide()

end

function UIXianJie_JiJie_teamListBgWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIXianJie_JiJie_teamListBgWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=self.openPageConfig[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(3,false)
item:SetChildActive(4,isReddot>0)
item:SetChildText(5,isReddot)
end

function UIXianJie_JiJie_teamListBgWin:refreshMenuReddot(page)
local idx=self.pageLookup[page]
self:refreshMenuItemReddot(nil,idx)
end

function UIXianJie_JiJie_teamListBgWin:refreshAllMenuReddot()
for page,idx in pairs(self.pageLookup)do
self:refreshMenuItemReddot(nil,idx)
end
end

function UIXianJie_JiJie_teamListBgWin:onMenuItemClick(idx)
local cfg=self.openPageConfig[idx]
if cfg.page==self.curPage then
return
end
local old=self.curPage
self.curPage=cfg.page
if old~=nil then
local idx_=self.pageLookup[old]
self:refreshMenuItemSelect(nil,idx_,false)
end
self:refreshMenuItemSelect(nil,idx,true)
self:refreshMenuPage()
end

function UIXianJie_JiJie_teamListBgWin:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=self.openPageConfig[idx]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args=self.extraArgs or{}
args.parentWin='UIXianJie_JiJie_teamListBgWin'
args.page=self.curPage
self:showWindow(win,args)
end
end



function UIXianJie_JiJie_teamListBgWin:onClickClose()
self:closeSelf()
end


function UIXianJie_JiJie_teamListBgWin:changeExtraArgs(newArgs)
self.extraArgs=newArgs
end