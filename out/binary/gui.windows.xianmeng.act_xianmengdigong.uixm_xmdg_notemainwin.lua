







def_class("UIXM_XMDG_NoteMainWin",UIWindowBase)









function UIXM_XMDG_NoteMainWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.menuGridPanel=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXM_XMDG_NoteMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end
















local pageConfig=
{
[1]={
win='UIXM_XMDG_NoteWin',
name='记事',
title='探索记事',
checkReddot=function()
return false
end,
},
[2]={
win='UIXM_XMDG_MemberWin',
name='盟员',
title='探索成员',
checkReddot=function()
return false
end,
},
[3]={
win='UIXM_XMDG_HarvestWin',
name='收获',
title='地宫收获',
checkReddot=function()
return false
end,
},
}
local _this=nil
local menu_slot_name='button_dytab'


function UIXM_XMDG_NoteMainWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_XMDG_NoteMainWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_XMDG_NoteMainWin:onHide()

end




function UIXM_XMDG_NoteMainWin:onShow(argtable,afterOnloaded)
local page=1
if argtable then
if argtable.page then
page=argtable.page
end
end
if afterOnloaded then
local cnt=#pageConfig
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=pageConfig[i]
item:SetChildText(1,cfg.name)
local isSelected=i==page
local func=function()
if _this==nil then return end
if isSelected then

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
self:refreshMenuItemSelect(item,i,i==page)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end

self:onMenuItemClick(page)
end

function UIXM_XMDG_NoteMainWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end

item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIXM_XMDG_NoteMainWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=pageConfig[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(3,isReddot)
end

function UIXM_XMDG_NoteMainWin:onMenuItemClick(page)
if page==self.curPage then
return
end
local old=self.curPage
self.curPage=page
if old~=nil then
self:refreshMenuItemSelect(nil,old,false)
end
self:refreshMenuItemSelect(nil,page,true)
local cfg=pageConfig[page]
local title=cfg.title
self.titleTxt:setText(title)
self:refreshMenuPage(page)
end

function UIXM_XMDG_NoteMainWin:refreshMenuPage(page)
local cfg=pageConfig[page]
local win=cfg.win
if self.pagewin==win then
return
end
if self.pagewin then
self:closeWindow(self.pagewin)
end
if win~=nil and win~=''then
self.pagewin=win
local args={parentWin='UIXM_XMDG_NoteMainWin'}
self:showWindow(win,args)
end
end

function UIXM_XMDG_NoteMainWin:onClickClose()
self:closeSelf()
end

function UIXM_XMDG_NoteMainWin:onCloseBtn()
self:closeSelf()
end