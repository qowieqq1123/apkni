







def_class("UIXianJie_JiJie_YBDSetBgWin",UIWindowBase)









function UIXianJie_JiJie_YBDSetBgWin:bindComponents()

self.menuGridPanel=UIObject.get(self,0)



end


function UIXianJie_JiJie_YBDSetBgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
end
















local pageConfig=
{
[1]={
page=1,
win='UIXianJie_JiJie_YBDSetPVEWin',
name='魔物',
checkOpenState=function()
local ybdData=xianjieModel:getJiJieYBDData()
local openFlag=ybdData and ybdData.openFlag or 0
local isOpen_PVE=bitHelper.check_pos(openFlag,0)
return isOpen_PVE
end,
checkOpen=function()
return true
end
},
[2]={
page=2,
win='UIXianJie_JiJie_YBDSetPVPWin',
name='战争',
checkOpenState=function()
local ybdData=xianjieModel:getJiJieYBDData()
local openFlag=ybdData and ybdData.openFlag or 0
local isOpen_PVP=bitHelper.check_pos(openFlag,1)
return isOpen_PVP
end,
checkOpen=function()
return true
end
},
[3]={
page=3,
win='UIMoJie_JiJie_YBDSetPVEWin',
name='魔界',
checkOpenState=function()
local ybdData=xianjieModel:getJiJieYBDData()
local openFlag=ybdData and ybdData.openFlag or 0
local isOpen_MoJie=bitHelper.check_pos(openFlag,2)
return isOpen_MoJie
end,
checkOpen=function()
return xianjieModel:checkCurrentMoJieEnterTime()
end
}
}
local _this=nil
local menu_slot_name='button_dytab'




function UIXianJie_JiJie_YBDSetBgWin:onLoaded(...)
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


function UIXianJie_JiJie_YBDSetBgWin:__delete()
_this=nil
self:unbindComponents()
for win,v in pairs(self.winList)do
UIManager:closeWindow(win)
end
self.winList=nil
end




function UIXianJie_JiJie_YBDSetBgWin:onShow(argtable,afterOnloaded)
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

self:refreshMenuItemOpenState(item,i)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end
self:onMenuItemClick(idx)
end


function UIXianJie_JiJie_YBDSetBgWin:onHide()

end

function UIXianJie_JiJie_YBDSetBgWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end


function UIXianJie_JiJie_YBDSetBgWin:refreshMenuItemOpenState(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=self.openPageConfig[idx]
local isOpen=cfg.checkOpenState()
item:SetChildActive(3,false)
item:SetChildActive(4,isOpen)
item:SetChildActive(5,not isOpen)
end

function UIXianJie_JiJie_YBDSetBgWin:refreshMenuOpenState(page)
local idx=self.pageLookup[page]
self:refreshMenuItemOpenState(nil,idx)
end

function UIXianJie_JiJie_YBDSetBgWin:refreshAllMenuOpenState()
for page,idx in pairs(self.pageLookup)do
self:refreshMenuItemOpenState(nil,idx)
end
end

function UIXianJie_JiJie_YBDSetBgWin:onMenuItemClick(idx)
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

function UIXianJie_JiJie_YBDSetBgWin:refreshMenuPage()
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
args.parentWin='UIXianJie_JiJie_YBDSetBgWin'
args.page=self.curPage
self:showWindow(win,args)
end
end



function UIXianJie_JiJie_YBDSetBgWin:onClickClose()
self:closeSelf()
end


function UIXianJie_JiJie_YBDSetBgWin:changeExtraArgs(newArgs)
self.extraArgs=newArgs
end