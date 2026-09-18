







def_class("UIXianJieExplorationWin",UIWindowBase)









function UIXianJieExplorationWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.maskBlock=UIButton.get(self,1)
self.money1Root=UIObject.get(self,2)
self.openlieyao=UIButton.get(self,3)
self.root=UIObject.get(self,4)
self.searchBtn=UIButton.get(self,5)
self.searLock=UIObject.get(self,6)
self.tabList=UIObject.get(self,7)
self.uiPanel=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maskBlock:setButtonClick(function()self:onMaskBlock()end)

self.openlieyao:setButtonClick(function()self:onOpenlieyao()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)



end


function UIXianJieExplorationWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
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
win='UIXianJieExp_monsterWin',
name='魔物',
checkReddot=function(self_,win)
if xianguanController.getSelfPrivilegeUseReddot()or xianguanModel:getPublishWantedReddot()then
local a
return true
end

return false
end,
checkopen=function(self_,win)
return true
end,
},
[2]={
page=2,
win='UIXianJieExplorationMysteryWin',
name='秘境',
checkReddot=function(self_,win)
return false
end,
checkopen=function(self_,win)
return true
end,
},
[3]={
page=3,
win='UIXianJieExplorationTaskWin',
name='任务',
checkReddot=function(self_,win)
return taskModel:explorTaskAllreddot()
end,
checkopen=function(self_,win)
return true
end,
},
[4]={
page=4,
win='UIXianJieExplorationForceWin',
name='势力',
checkReddot=function(self_,win)
return xianjieModel:getAllForceReddot()
end,
checkopen=function(self_,win)
return true
end,
},
[5]={
page=5,
win='UIXBTCTaskWin',
name='仙榜',
checkReddot=function(self_,win)
return false
end,
checkopen=function(self_,win)
return true
end,
},
[6]={
page=6,
win='UIXianJieExplorationXingYuWin',
name='星域',
checkReddot=function(self_,win)
return XingYuController.checkFirstReddot()
end,
checkopen=function(self_,win)
return XingYuController.checkSysOpen()
end,
},
[7]={
page=7,
win='UIXianJieExplorationLingShouWin',
name='灵兽',
checkReddot=function(self_,win)
return false
end,
checkopen=function(self_,win)
return systemModel.isOpen(SYSTEM_DEFINE.eXianJieZhuaChong)
end,
}
}
local pageConfig={}


function UIXianJieExplorationWin:onLoaded(...)
_this=self
self:bindComponents()












self:addProNotify(40,26,self.on_40_26)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onXianGuanJingXuanSegmentChange,self.onXianGuanJingXuanSegmentChange)
self:addNotify(notifyConfig.onXianJieFactionReddotChange,self.onXianJieFactionReddotChange)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.on_system_open,self.on_system_open)
local cost=cfgHelper.get2(cfg_zhengzhanshanhaisearchconfig_get,1,'consume')
self.moneyType=cost[1][1]
end

function UIXianJieExplorationWin:getMapView()
return self.mapView
end


function UIXianJieExplorationWin:__delete()
self:unbindComponents()
pageConfig={}
for win,v in pairs(self.winList)do

xianjieController:closeWin(win)
end
self.winList=nil
_this=nil


end


function UIXianJieExplorationWin:onHide()
self:onMaskBlock()
end

function UIXianJieExplorationWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
if moneyType==_this.moneyType then

end
end




function UIXianJieExplorationWin:onShow(argtable,afterOnloaded)
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
end
end



self:onMenuItemClick(idx,true)
self.openlieyao:setActive(systemModel.isOpen(SYSTEM_DEFINE.eXianJieShouMoTeam))



end


function UIXianJieExplorationWin:playEnterAnim()
if not newbieControl.isInNewbie()then
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
self.uiPanel:setChildAnchoredPosition(Vector2(-508,1))
self.uiPanel:setChildDOAnchorPosX(1,0.2,nil)
else
self.root:setChildCanvasGroupAlpha(1)
end
end
function UIXianJieExplorationWin:playLeaveAnim()
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

function UIXianJieExplorationWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.tabList:getChildLayoutGroupGridItem(idx-1)
end
item:SetChildActive(0,flag)
end

function UIXianJieExplorationWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.tabList:getChildLayoutGroupGridItem(idx-1)
end
local cfg=pageConfig[idx]
local isReddot=cfg:checkReddot(self)
item:SetChildActive(2,isReddot)
end

function UIXianJieExplorationWin:refreshAllMenuItemReddot()
local cnt=#pageConfig
local grids=self.tabList:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
self:refreshMenuItemReddot(item,i)
end
end

function UIXianJieExplorationWin:refreshAllMenuItemSingleReddot(page)
local cnt=#pageConfig
local grids=_this.tabList:getChildLayoutGroupGridList()
for i=1,cnt do
if pageConfig[i].page==page then
local item=grids[i-1]
_this:refreshMenuItemReddot(item,i)
end
end
end

function UIXianJieExplorationWin:onMenuItemClick(idx,isInit)
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

function UIXianJieExplorationWin:refreshMenuPage(isInit)
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
args.parentWin='UIXianJieExplorationWin'
args.page=self.curPage
args.isInit=isInit
args.extra=self.extra
self:showWindow(win,args)
end
end

function UIXianJieExplorationWin:onMaskBlock()
if _this==nil then return end
if _this.closeLock then return end
_this:onCloseBtn()
end

function UIXianJieExplorationWin:onCloseBtn()
if _this==nil then return end
if self.closeLock then return end
self:playLeaveAnim()
end


function UIXianJieExplorationWin:initQingBaoList()
local isChange=false
return isChange
end
function UIXianJieExplorationWin:checkQingBaoReddot(infotype)
return false
end
function UIXianJieExplorationWin:getQingBaoList(infotype,isInit)
return nil
end

function UIXianJieExplorationWin:rec_search()
if UIManager:isActive('UIXM_ZZSH_monsterInfoWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_monsterInfoWin','clearMapView')
UIManager:closeWindow('UIXM_ZZSH_monsterInfoWin')
end
if UIManager:isActive('UIXM_ZZSH_resourceInfoWin')then
UIManager:invokeUIMethod('UIXM_ZZSH_resourceInfoWin','clearMapView')
UIManager:closeWindow('UIXM_ZZSH_resourceInfoWin')
end
end


function UIXianJieExplorationWin:onOpenlieyao()

local arg=xianjieModel:GetrecordlastSelectType()
UIManager:showWindow('UIXianJie_ShouMoList',arg)
end

function UIXianJieExplorationWin.onXianGuanJingXuanSegmentChange(campaignType)
if campaignType==XianGuanCampaignType.eWuXuan then
_this:refreshAllMenuItemSingleReddot(4)
end
end

function UIXianJieExplorationWin.onXianJieFactionReddotChange()
_this:refreshAllMenuItemSingleReddot(4)
end

function UIXianJieExplorationWin.on_40_26()
_this:refreshAllMenuItemSingleReddot(4)
end

function UIXianJieExplorationWin.on_system_open(sysId)
if shouhundingModel:isSysID(sysId)then
_this:refreshAllMenuItemSingleReddot(4)
end
end

function UIXianJieExplorationWin.on_money_changed(mType)
if shouhundingModel:isDataType(mType)then
_this:refreshAllMenuItemSingleReddot(4)
end
end