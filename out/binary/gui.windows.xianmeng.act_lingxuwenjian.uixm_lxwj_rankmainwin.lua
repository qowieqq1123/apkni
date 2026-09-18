







def_class("UIXM_LXWJ_RankMainWin",UIWindowBase)









function UIXM_LXWJ_RankMainWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.menuGridPanel=UIObject.get(self,2)



end


function UIXM_LXWJ_RankMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
end
















local pageConfig=
{
[1]={
page=1,
win='UIXM_LXWJ_RankOneWin',
name='赛季排名',
},
[2]={
page=2,
win='UIXM_LXWJ_RankTwoWin',
name='历届至尊',
},
}
local _this=nil
local menu_slot_name='button_dytab'


function UIXM_LXWJ_RankMainWin:onLoaded(...)
_this=self
self:bindComponents()
self.winList={}
self.pageLookup={}
for i,v in ipairs(pageConfig)do
self.pageLookup[v.page]=i
end
end


function UIXM_LXWJ_RankMainWin:__delete()
_this=nil
self:unbindComponents()
for win,v in pairs(self.winList)do
UIManager:closeWindow(win)
end
self.winList=nil
end


function UIXM_LXWJ_RankMainWin:onHide()

end




function UIXM_LXWJ_RankMainWin:onShow(argtable,afterOnloaded)
local page=1
if argtable then
if argtable.page then
page=argtable.page
end
end
local idx=self.pageLookup[page]
if afterOnloaded then
local cnt=#pageConfig
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=pageConfig[i]
item:SetChildText(1,cfg.name)
local isSelected=i==idx
self:refreshMenuItemSelect(item,i,isSelected)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4749,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.25,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
_this:onMenuItemClick(idx)
end)
end)
else
self:onMenuItemClick(idx)
end
end

function UIXM_LXWJ_RankMainWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

local icon
if flag then
icon='button_lxwjfenxiang_3'
else
icon='button_lxwjfenxiang_4'
end
item:SetChildCSImageSprite(0,globalABLookup.lingxuwenjianicons,icon)
end

function UIXM_LXWJ_RankMainWin:onMenuItemClick(idx)
local cfg=pageConfig[idx]
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

function UIXM_LXWJ_RankMainWin:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=pageConfig[idx]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args={}
args.parentWin='UIXM_LXWJ_RankMainWin'
args.page=self.curPage
self:showWindow(win,args)
end
end

function UIXM_LXWJ_RankMainWin:onClickClose()
self:closeSelf()
end