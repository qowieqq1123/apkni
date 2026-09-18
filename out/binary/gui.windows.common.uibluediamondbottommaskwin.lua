







def_class("UIBlueDiamondBottomMaskWin",UIWindowBase)









function UIBlueDiamondBottomMaskWin:bindComponents()

self.buyBtn=UIButton.get(self,0)
self.gotoBtn=UIButton.get(self,1)
self.mbg=UIObject.get(self,2)
self.mbg2=UIObject.get(self,3)
self.menuGrid=UIObject.get(self,4)
self.root=UIObject.get(self,5)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIBlueDiamondBottomMaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.mbg2);self.mbg2=nil;
_UIObject_release(self.menuGrid);self.menuGrid=nil;
_UIObject_release(self.root);self.root=nil;
end
















local menuCmpIndex={
cmpName=0,
cmpReddot=1,
cmpBg=2,
select=3,
clicker=4,
panel=5,
}

local _this=nil




function UIBlueDiamondBottomMaskWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onActorBlueDiamondChange,self.onActorBlueDiamondChange)
end


function UIBlueDiamondBottomMaskWin:__delete()
self:unbindComponents()
_this=nil
end

function UIBlueDiamondBottomMaskWin.onActorBlueDiamondChange()
_this:refreshBlueDiamond()
end




function UIBlueDiamondBottomMaskWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local activeUI=fullScreenUI.activeUI
self.replaceTitleName=activeUI.replaceTitleName
self.defaultTitleName=activeUI.defaultTitleName

self.fullType=activeUI.fullType
self.showMenu,self.showMenuNum=self:hasMenu()
self.args=argtable or{}

local changed=activeUI:checkTabChange()or self.selectMenuIdx==nil
if changed then
self:freshMenuList()
end
if not self.isPlay then
self.menuGrid:setChildCanvasGroupAlpha(0)
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
self.delayTimer=nil
end
local cavasGroup=self.menuGrid:getCommonComponent('CanvasGroup')
if self.tweener then
self.tweener:Kill(false)
self.tweener=nil
end
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6197,1,nil,3415,false,false,0)
self.delayTimer=self:delayDo(0.3,function()
if not _this then return end
_this.tweener=_DOTweenProxy.DOFade(cavasGroup,1,0.5)
_this.tweener:SetDelay(0.2)
_this.delayTimer=nil
end)
end
self:setAsFirstSibling()
self.isPlay=true

self:refreshBlueDiamond()
self:refreshMBg()
end

function UIBlueDiamondBottomMaskWin:refreshMBg()
local activeUI=fullScreenUI.activeUI
local activeSubMenu=activeUI.activeSubMenu
local tabType=activeSubMenu[self.selectMenuIdx].tabType

local animId=3413
if tabType==FULL_TAB_TYPE.eBlueDiamond_NewBieGift then
animId=3407
elseif tabType==FULL_TAB_TYPE.eBlueDiamond_TeQuanInfo then
animId=3408
end

self.root:setChildCanvasGroupAlpha(0)
if self.delayTimer2 then
self:stopTimerByID(self.delayTimer2)
self.delayTimer2=nil
end
local cavasGroup=self.root:getCommonComponent('CanvasGroup')
if self.tweener2 then
self.tweener2:Kill(false)
self.tweener2=nil
end
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg2:getID(),false,true,false)
self.mbg2:setChildUIModelShowTarget(6196,1,nil,animId,false,false,0)
self.delayTimer2=self:delayDo(0.3,function()
if not _this then return end
_this.tweener2=_DOTweenProxy.DOFade(cavasGroup,1,0.5)
_this.tweener2:SetDelay(0.2)
_this.delayTimer2=nil
end)
end

function UIBlueDiamondBottomMaskWin:refreshBlueDiamond()



end

function UIBlueDiamondBottomMaskWin:hasMenu()
local activeUI=fullScreenUI.activeUI
if activeUI then
local activeSubMenu=activeUI.activeSubMenu
if activeSubMenu then
local num=#activeSubMenu
if num>0 then
return true,num
end
end
end
return false,0
end


function UIBlueDiamondBottomMaskWin:onHide()

end

function UIBlueDiamondBottomMaskWin:freshMenuList()
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI

self:clearReddotFunction()

local activeSubMenu=activeUI.activeSubMenu
self.selectMenuIdx=activeUI.activeMenuIndex

local tNum=#activeSubMenu
self.menuGrid:setChildLayoutGroupCreateItems(tNum)
for i,v in ipairs(activeSubMenu)do
self:fillMenu(activeUI,i,v)
end
end

function UIBlueDiamondBottomMaskWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIBlueDiamondBottomMaskWin:fillMenu(activeUI,index,config)
local tabIndex=index
local tabType=config.tabType
local tabConfig=fullScreenModel.getFullTabConfig(tabType)
local selectMenuIdx=activeUI.activeMenuIndex

local isSelect=selectMenuIdx==tabIndex
local item=self.menuGrid:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(menuCmpIndex.select,isSelect)
item:SetChildText(menuCmpIndex.cmpName,tabConfig.tabname)
if index==4 then
item:SetChildLocalPosX(menuCmpIndex.panel,81)
else
item:SetChildLocalPosX(menuCmpIndex.panel,99-(index-1)*6.5)
end

local isreddot=false
local reddotType=config.reddotType
if reddotType then
isreddot=reddotClassManager.get_reddot(reddotType)
local func=function(...)
if self==nil or self.isClose then return end
self:refreshReddot(index,...)
end
self.reddotfuncs[reddotType]=func
reddotClassManager.register_event(reddotType,func)
end

item:SetChildActive(menuCmpIndex.cmpReddot,isreddot)

item:SetChildButtonClick(menuCmpIndex.clicker,function()
self:on_click_callback(index)
end)
end

function UIBlueDiamondBottomMaskWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.menuGrid:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(menuCmpIndex.cmpReddot,flag)
end

function UIBlueDiamondBottomMaskWin:freshMenuSelect(activeUI,index,is_select)
if index==nil then
return
end
local activeSubMenu=activeUI.activeSubMenu
local config=activeSubMenu[index]
if config==nil then
return
end
local item=self.menuGrid:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(menuCmpIndex.select,is_select)
end




function UIBlueDiamondBottomMaskWin:onBuyBtn()
platformSDK:reqQQEvent("buy_vip")
end



function UIBlueDiamondBottomMaskWin:onGotoBtn()
platformSDK:reqQQEvent("guanzhu")
end

function UIBlueDiamondBottomMaskWin:onClickClose()
if self.args.close then
self.args.close()
else
fullScreenUI.closeActiveUI(true)
end
end

function UIBlueDiamondBottomMaskWin:on_click_callback(index)
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI
if index==self.selectMenuIdx then
return
end
if activeUI.activeSubMenu and activeUI.activeSubMenu[index]then
local conf=activeUI.activeSubMenu[index]
local tabType=conf.tabType
if not fullScreenModel.checkTabEnoughCND(tabType,true)then return end

local clickCond=conf.clickCond
if clickCond~=nil then
if not clickCond()then
return
end
end
self:freshMenuSelect(activeUI,self.selectMenuIdx,false)
self:freshMenuSelect(activeUI,index,true)
activeUI.activeMenuIndex=index
self.selectMenuIdx=index

local clickCall=conf.callback
if clickCall==nil then
loggerUtil.logErrFMT('没有找到配置页签类型：{0}的点击事件',tabType)
return
end
if not fullScreenModel.isTabOpen(tabType,true)then return end
local isload=activeUI.showTabTypeList[tabType]
local argstable=nil
if activeUI.attach then
argstable=activeUI.attach
if argstable then
argstable.clickMenu=true
end
else
argstable={clickMenu=true}
end
clickCall(argstable)
if argstable then
argstable.clickMenu=nil
end

self:refreshMBg()
end
end
