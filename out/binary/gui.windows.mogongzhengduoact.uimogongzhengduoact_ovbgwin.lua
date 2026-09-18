







def_class("UIMoGongZhengDuoAct_ovBgWin",UIWindowBase)









function UIMoGongZhengDuoAct_ovBgWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.menuItemGroup=UIObject.get(self,2)
self.root=UIObject.get(self,3)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIMoGongZhengDuoAct_ovBgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.menuItemGroup);self.menuItemGroup=nil;
_UIObject_release(self.root);self.root=nil;
end


















local _this
local pageConfig=
{

[1]={
page=1,
win='UIMoGongZhengDuoAct_ovTeamWin',
},
}

function UIMoGongZhengDuoAct_ovBgWin:onLoaded(...)
_this=self
self:bindComponents()
self.winList={}
self.pageLookup={}
for i,v in ipairs(pageConfig)do
self.pageLookup[v.page]=i
end
end


function UIMoGongZhengDuoAct_ovBgWin:__delete()
self:unbindComponents()
self.winList=nil
end




function UIMoGongZhengDuoAct_ovBgWin:onShow(argtable,afterOnloaded)
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
local cnt=#pageConfig
local menuGrids=self.menuItemGroup:getChildCommonLayoutGroupWidgetList()
for i=1,menuGrids.Count do
local widget=menuGrids[i-1]
local cfg=pageConfig[i]
if cfg and widget then

local isSelect=i==idx
self:refreshMenuItemSelect(widget,i,isSelect)
widget:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end,true)
end
end
end
self:onMenuItemClick(idx)
end


function UIMoGongZhengDuoAct_ovBgWin:onHide()

end

function UIMoGongZhengDuoAct_ovBgWin:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=pageConfig[idx]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args=self.extraArgs or{}
args.parentWin='UIXianJieArenaAct_ovBgWin'
args.page=self.curPage
self:showWindow(win,args)
end
end

function UIMoGongZhengDuoAct_ovBgWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuItemGroup:getChildCommonLayoutGroupWidgetItem(idx-1)
end

item:SetChildActive(0,not flag)
item:SetChildActive(1,flag)
end

function UIMoGongZhengDuoAct_ovBgWin:onMenuItemClick(idx)
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




function UIMoGongZhengDuoAct_ovBgWin:onClickMask()
self:onClickClose()
end



function UIMoGongZhengDuoAct_ovBgWin:onCloseBtn()
self:onClickClose()
end

function UIMoGongZhengDuoAct_ovBgWin:onClickClose()
self:closeSelf()
end
