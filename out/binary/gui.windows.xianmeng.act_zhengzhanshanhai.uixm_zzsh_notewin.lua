







def_class("UIXM_ZZSH_noteWin",UIWindowBase)









function UIXM_ZZSH_noteWin:bindComponents()

self.menuGridPanel=UIObject.get(self,0)



end


function UIXM_ZZSH_noteWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
end



















local _this=nil
local menu_slot_name='button_dytab'


function UIXM_ZZSH_noteWin:onLoaded(...)
_this=self
self:bindComponents()

self.pageConfig=
{
[1]={
page=1,
win='UIXM_ZZSH_monsterAllMyTeamWin',
name='异兽',
checkReddot=function()
return zhengzhanshanhaiModel:getPvEJiJieDatasNum()
end,
},
[2]={
page=2,
win='UIXM_ZZSH_resourceAllMyTeamWin',
name='宝地',
checkReddot=function()
return zhengzhanshanhaiModel:getPvEBaodiDatasNum()
end,
}
}

if UILSZDControl:isLingShanOpen()then
self.pageConfig[3]={
page=3,
win='UILingShanZTCJPageWin',
name='灵山',
checkReddot=function()
return 0
end,
}
end

self.winList={}
self.pageLookup={}
for i,v in ipairs(self.pageConfig)do
self.pageLookup[v.page]=i
end
end


function UIXM_ZZSH_noteWin:__delete()
_this=nil
self:unbindComponents()
for win,v in pairs(self.winList)do
UIManager:closeWindow(win)
end
self.winList=nil
end


function UIXM_ZZSH_noteWin:onHide()

end




function UIXM_ZZSH_noteWin:onShow(argtable,afterOnloaded)
local page=1
if argtable then
if argtable.page then
page=argtable.page
end
end
local idx=self.pageLookup[page]
if afterOnloaded then
local cnt=#self.pageConfig
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=self.pageConfig[i]
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

function UIXM_ZZSH_noteWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIXM_ZZSH_noteWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=self.pageConfig[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(3,false)
item:SetChildActive(4,isReddot>0)
item:SetChildText(5,isReddot)
end

function UIXM_ZZSH_noteWin:refreshMenuReddot(page)
local idx=self.pageLookup[page]
self:refreshMenuItemReddot(nil,idx)
end

function UIXM_ZZSH_noteWin:onMenuItemClick(idx)
local cfg=self.pageConfig[idx]
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

function UIXM_ZZSH_noteWin:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=self.pageConfig[idx]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args={}
args.parentWin='UIXM_ZZSH_noteWin'
args.page=self.curPage
self:showWindow(win,args)
end
end

function UIXM_ZZSH_noteWin:onClickClose()
self:closeSelf()
end