







def_class("UIMoGongZhengDuoAct_FightInfoWin",UIWindowBase)









function UIMoGongZhengDuoAct_FightInfoWin:bindComponents()

self.centerLayout=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.menuItemGroup=UIObject.get(self,2)
self.Root=UIObject.get(self,3)
self.spineBG=UIObject.get(self,4)
self.uiRoot=UIObject.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIMoGongZhengDuoAct_FightInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.menuItemGroup);self.menuItemGroup=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.spineBG);self.spineBG=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end















local _this
local pageConfig=
{
[1]={
name="战场",
page=1,
win='UIMoGongZhengDuoAct_Occupy2Win',
args={
arenaId=xjClientBuildType.flcbMoGong1,
},
anim=eAnimationID.stand2,
},
[2]={
name="队伍",
page=2,
win='UIMoGongZhengDuoAct_ovTeam2Win',
anim=eAnimationID.stand,
},
}



function UIMoGongZhengDuoAct_FightInfoWin:onLoaded(...)
self:bindComponents()

_this=self

self.winList={}
self.pageLookup={}
for i,v in ipairs(pageConfig)do
self.pageLookup[v.page]=i
end

end


function UIMoGongZhengDuoAct_FightInfoWin:__delete()
_this=nil
self.winList=nil
self:unbindComponents()
end




function UIMoGongZhengDuoAct_FightInfoWin:onShow(argtable,afterOnloaded)
local showIndex=1
if argtable then
if argtable.showIndex then
showIndex=argtable.showIndex
end
if argtable.extraArgs then
self.extraArgs=argtable.extraArgs
end
self.pageList=argtable.pageList
end
self.selectIdx=0
if afterOnloaded then
self.menuItemGroup:setChildLayoutGroupCreateItems(#self.pageList)
local menuGrids=self.menuItemGroup:getChildLayoutGroupGridList()
for i=1,menuGrids.Count do
local widget=menuGrids[i-1]

local page=self.pageList[i]
local isShow=page~=nil
widget:SetChildActive(-1,isShow)
if isShow then
local cfg=pageConfig[page]
if cfg and widget then
widget:SetChildText(2,cfg.name)
local isSelect=i==showIndex
self:refreshMenuItemSelect(widget,i,isSelect)
widget:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end,true)
end
end
end
end

if afterOnloaded then
self.centerLayout:setChildCanvasGroupAlpha(0)
self.spineBG:setChildUIModelShowTarget(5683,1,nil,eAnimationID.enter,false,false,0.2,function()
_this.centerLayout:setChildCanvasGroupDOFade(1,0.2,function()
_this:onMenuItemClick(showIndex)
end)
end)
else
self:onMenuItemClick(showIndex)
end
end


function UIMoGongZhengDuoAct_FightInfoWin:onHide()

end

function UIMoGongZhengDuoAct_FightInfoWin:refreshMenuPage()
local id=self.pageList[self.selectIdx]
local cfg=pageConfig[id]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args=self.extraArgs or{}
args.parentWin='UIMoGongZhengDuoAct_FightInfoWin'
args.page=self.selectIdx

if cfg.args then
for key,val in pairs(cfg.args)do
args[key]=val
end
end

self:showWindow(win,args)
self.spineBG:setChildModelAnimationState(cfg.anim,1)
end
end

function UIMoGongZhengDuoAct_FightInfoWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuItemGroup:getChildLayoutGroupGridItem(idx-1)
end

item:SetChildActive(0,not flag)
item:SetChildActive(1,flag)
end

function UIMoGongZhengDuoAct_FightInfoWin:onMenuItemClick(idx)

if self.selectIdx==idx then
return
end
local old=self.selectIdx==0 and idx or self.selectIdx
self.selectIdx=idx
if old~=nil then
self:refreshMenuItemSelect(nil,old,false)
end
self:refreshMenuItemSelect(nil,idx,true)
self:refreshMenuPage()
end





function UIMoGongZhengDuoAct_FightInfoWin:onCloseBtn()
self:closeSelf()
end
