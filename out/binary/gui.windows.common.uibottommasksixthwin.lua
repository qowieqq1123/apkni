







def_class("UIBottomMaskSixthWin",UIWindowBase)









function UIBottomMaskSixthWin:bindComponents()

self.back=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.title=UIText.get(self,2)
self.menu=UIObject.get(self,3)
self.scrollView=UIScrollView.get(self,4)
self.img=UIObject.get(self,5)



end


function UIBottomMaskSixthWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.img);self.img=nil;
end

















local _CMP_INDEX={
cmpSelfItem=0,
cmpName=1,
cmpReddot=2,
cmpAnim=3,
cmpBg=4,
cmpNomalIcon=5,
select=6,
}

local _scrollLen=4


function UIBottomMaskSixthWin:onLoaded(...)
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)
self.isGuoFu=pfwindowslController:checkIsGameVersion_guofu()
self.img:setActive(self.isGuoFu)
end


function UIBottomMaskSixthWin:__delete()
self.scrollView:setClickAction(nil)
self:unbindComponents()
self:clearReddotFunction()
end




function UIBottomMaskSixthWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local clickMenu=argtable.clickMenu or false
local activeUI=fullScreenUI.activeUI
self.replaceTitleName=activeUI.replaceTitleName
self.defaultTitleName=activeUI.defaultTitleName

local oldShowMenu=self.showMenu
local oldshowMenuNum=self.showMenuNum
local old_fullType=self.fullType
local old_selectMenuIdx=self.selectMenuIdx
local selectMenuIdx=activeUI.activeMenuIndex
self.fullType=activeUI.fullType
self.showMenu,self.showMenuNum=self:hasMenu()
local menuChange=self.fullType~=old_fullType or oldShowMenu~=self.showMenu or oldshowMenuNum~=self.showMenuNum or old_selectMenuIdx~=selectMenuIdx
self.args=argtable or{}

local changed=activeUI:checkTabChange()or self.selectMenuIdx==nil
if changed then
self:freshMenuList()
self:refreshTitle()
end
if not clickMenu and selectMenuIdx>5 then
self.scrollView:jumpToLockX(selectMenuIdx)
end
if not self.isPlay then
self.back:setChildUIModelShowTarget(5235,1,{},eAnimationID.stand,false,false)
self.root:setChildCanvasGroupAlpha(0)
local cavasGroup=self.root:getCommonComponent('CanvasGroup')
if self.tweener then
self.tweener:Kill(false)
self.tweener=nil
end
self.tweener=_DOTweenProxy.DOFade(cavasGroup,1,1)
self.tweener:SetDelay(0.2)
end
self:setAsFirstSibling()
self.isPlay=true
end

function UIBottomMaskSixthWin:hasMenu()
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


function UIBottomMaskSixthWin:onHide()
self.isPlay=false
self:clearReddotFunction()
end

function UIBottomMaskSixthWin:refreshTitle()
local titleName
if self.replaceTitleName then
if type(self.replaceTitleName)=='table'then
if self.showMenuNum>0 then
local activeUI=fullScreenUI.activeUI
local selectMenuIdx=activeUI.activeMenuIndex
titleName=self.replaceTitleName[selectMenuIdx]
end
else
titleName=self.replaceTitleName
end
else
titleName=self.defaultTitleName or''
if self.showMenuNum>0 then
local activeUI=fullScreenUI.activeUI
local selectMenuIdx=activeUI.activeMenuIndex
local tabType=activeUI.activeSubMenu[selectMenuIdx].tabType
local tabConfig=fullScreenModel.getFullTabConfig(tabType)
if tabConfig.titleName~=nil then
titleName=tabConfig.titleName
end
end
end
self:setTitle(titleName)
end

function UIBottomMaskSixthWin:setTitle(title)
self.title:setText(title)
end

function UIBottomMaskSixthWin:freshMenuList()
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI

self:clearReddotFunction()

local activeSubMenu=activeUI.activeSubMenu
if activeSubMenu and#activeSubMenu>0 then
self.menu:setActive(true)
self.selectMenuIdx=activeUI.activeMenuIndex

local tNum=#activeSubMenu

self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),tNum>_scrollLen)
self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i,v in ipairs(activeSubMenu)do
self:fillMenu(activeUI,i,v)
end
else
self.menu:setActive(false)
end
end

function UIBottomMaskSixthWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIBottomMaskSixthWin:fillMenu(activeUI,index,config)
local tabIndex=index
local tabConfig=fullScreenModel.getFullTabConfig(config.tabType)
local selectMenuIdx=activeUI.activeMenuIndex
local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildText(_CMP_INDEX.cmpName,tabConfig.tabname)
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
item:SetChildActive(_CMP_INDEX.cmpBg,selectMenuIdx~=tabIndex)
item:SetChildActive(_CMP_INDEX.select,selectMenuIdx==tabIndex)

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
item:SetChildActive(_CMP_INDEX.cmpReddot,isreddot)
item:SetChildNewBieComponentId(-1,FMT.fmt('UIBottomMaskSixthWin.btnClick.{0}',tabType))
end

function UIBottomMaskSixthWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.cmpReddot,flag)
end

function UIBottomMaskSixthWin:freshMenuSelect(activeUI,index,is_select)
if index==nil then
return
end
local activeSubMenu=activeUI.activeSubMenu
local config=activeSubMenu[index]
if config==nil then
return
end
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.cmpBg,not is_select)
item:SetChildActive(_CMP_INDEX.select,is_select)
end

function UIBottomMaskSixthWin:on_click_callback(id,index,guid,attach)
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
self:refreshTitle()

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
end
end



function UIBottomMaskSixthWin:onClickCloseBtn()

AudioManager.playBtnClick()
self:onClickClose()
end

function UIBottomMaskSixthWin:onClickClose()
if self.args.close then
self.args.close()
else
fullScreenUI.closeActiveUI(true)
end
end