







def_class("UIMoJieExplorationWin",UIWindowBase)









function UIMoJieExplorationWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.maskBlock=UIButton.get(self,1)
self.openlieyao=UIButton.get(self,2)
self.root=UIObject.get(self,3)
self.searchBtn=UIButton.get(self,4)
self.searLock=UIObject.get(self,5)
self.tabList=UIObject.get(self,6)
self.uiPanel=UIObject.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.openlieyao:setButtonClick(function()self:onOpenlieyao()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)



end


function UIMoJieExplorationWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.openlieyao);self.openlieyao=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searLock);self.searLock=nil;
_UIObject_release(self.tabList);self.tabList=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
end

















local _this
local pageConfig2=
{
[1]={
page=1,
win='UIMoJieExp_monsterWin',
name='魔物',
checkReddot=function(self_,win)
return false
end,
checkopen=function(self_,win)
return true
end,
},
[2]={
page=2,
win='UIMoJieExplorationMoZongWin',
name='魔宗',
checkReddot=function(self_,win)
return false
end,
checkopen=function(self_,win)
local stage=seasonModel:findFirstDoingStage(seasonStageType.eMZHD)
if stage then
return true
end
return false
end,
},
[3]={
page=3,
win='UIMoJieExplorationGateWin',
name='关口',
checkReddot=function(self_,win)
return false
end,
checkopen=function(self_,win)
return true
end,
},
[4]={
page=4,
win='UIMoJieExplorationZhenYanWin',
name='阵眼',
checkReddot=function(self_,win)
return false
end,
checkopen=function(self_,win)
local stage=seasonModel:findFirstDoingStage(seasonStageType.eMJZY)
if stage then
return true
end
return false
end,
},
[5]={
page=5,
win='UIMoJieExplorationZhenTaiWin',
name='镇台',
checkReddot=function(self_,win)
return false
end,
checkopen=function(self_,win)
return seasonModel:haveBeginStage(seasonStageType.eMJZT)
end,
},
[6]={
page=6,
win='UIMoJieExplorationBenYuanZhenJiWin',
name='本源阵基',
checkReddot=function(self_,win)
return false
end,
checkopen=function(self_,win)
local stage=seasonModel:findFirstDoingStage(seasonStageType.eMJZJ)
if stage then
return true
end
return false
end,
},
[7]={
page=7,
win='UIMoJieExplorationWuXingZhenJiWin',
name='五行阵基',
checkReddot=function(self_,win)
return false
end,
checkopen=function(self_,win)
local stage=seasonModel:findFirstDoingStage(seasonStageType.eMJZJ)
if stage then
return true
end
local lp=xianjieModel:getAllPuTongZhenJiData()
if lp and next(lp)~=nil then
return true
end
return false
end,
},
}
local pageConfig={}


function UIMoJieExplorationWin:onLoaded(...)
_this=self
self:bindComponents()
end

function UIMoJieExplorationWin:getMapView()
return self.mapView
end


function UIMoJieExplorationWin:__delete()
self:unbindComponents()
pageConfig={}
for win,v in pairs(self.winList)do
xianjieController:closeWin(win)
end
self.winList=nil
_this=nil
end


function UIMoJieExplorationWin:onHide()
self:onMaskBlock()
end




function UIMoJieExplorationWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
end
pageConfig={}
self.winList={}
for i,v in ipairs(pageConfig2)do
if v.checkopen()then
pageConfig[#pageConfig+1]=v
end
end
self.pageLookup={}
for i,v in ipairs(pageConfig)do
self.pageLookup[v.page]=i
end

local page=1
if argtable then
if argtable.page then
page=argtable.page
end
self.extra=argtable.extra
end
local idx=1
if self.pageLookup[page]then
idx=self.pageLookup[page]
else
idx=1
end
if afterOnloaded then
local cnt=#pageConfig
self.tabList:setChildLayoutGroupCreateItems(cnt)
local grids=self.tabList:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=pageConfig[i]
item:SetChildText(1,cfg.name)

local isSelected=i==idx
self:refreshMenuItemSelect(item,i,isSelected)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
item:SetChildNewBieComponentId(3,FMT.fmt("UIMoJieExplorationWin.newBieItem_{0}",cfg.page))
end
end

self:onMenuItemClick(idx,true)

local sceneidx=xianjieModel:getSceneIndex()
if sceneidx and xianjienSceneIndexType:isMoJie(sceneidx)then
self.openlieyao:setActive(systemModel.isOpen(SYSTEM_DEFINE.eXianJieShouMoTeam))

else
self.openlieyao:setActive(systemModel.isOpen(SYSTEM_DEFINE.eXianJieShouMoTeam))
end
end


function UIMoJieExplorationWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(1,0.2,nil)
else
self.root:setChildCanvasGroupAlpha(1)
end
end
function UIMoJieExplorationWin:playLeaveAnim()
local idx=self.pageLookup[self.curPage]or 1
local cfg=pageConfig[idx]
if cfg then
UIManager:invokeUIMethod(cfg.win,'playLeaveAnim')
end
self.uiPanel:setChildDOAnchorPosX(-508,0.2,nil)
self.closeLock=true
self:delayDo(0.2,function()
self.closeLock=nil

xianjieController:closeWin(self.__name)
end)
end

function UIMoJieExplorationWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.tabList:getChildLayoutGroupGridItem(idx-1)
end
item:SetChildActive(0,flag)
end

function UIMoJieExplorationWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.tabList:getChildLayoutGroupGridItem(idx-1)
end
local cfg=pageConfig[idx]
local isReddot=cfg:checkReddot(self)
item:SetChildActive(2,isReddot)
end

function UIMoJieExplorationWin:refreshAllMenuItemReddot()
local cnt=#pageConfig
local grids=self.tabList:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
self:refreshMenuItemReddot(item,i)
end
end

function UIMoJieExplorationWin:refreshAllMenuItemSingleReddot(page)
local cnt=#pageConfig
local grids=_this.tabList:getChildLayoutGroupGridList()
for i=1,cnt do
if pageConfig[i].page==page then
local item=grids[i-1]
_this:refreshMenuItemReddot(item,i)
end
end
end

function UIMoJieExplorationWin:onMenuItemClick(idx,isInit)
if self.closeLock then return end
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
self:refreshMenuItemReddot(nil,idx)
self:refreshMenuPage(isInit)
end

function UIMoJieExplorationWin:refreshMenuPage(isInit)
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
args.parentWin='UIMoJieExplorationWin'
args.page=self.curPage
args.isInit=isInit
args.extra=self.extra
self:showWindow(win,args)
end
end

function UIMoJieExplorationWin:onMaskBlock()
if _this==nil then return end
if _this.closeLock then return end
_this:onCloseBtn()
end

function UIMoJieExplorationWin:onCloseBtn()
if _this==nil then return end
if self.closeLock then return end
self:playLeaveAnim()
end


function UIMoJieExplorationWin:onOpenlieyao()
local arg=xianjieModel:GetrecordlastSelectType()
UIManager:showWindow('UIXianJie_ShouMoList',arg)
end
