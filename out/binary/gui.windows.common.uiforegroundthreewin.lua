







def_class("UIForeGroundThreeWin",UIWindowBase)









function UIForeGroundThreeWin:bindComponents()

self.back=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.bg=UIImage.get(self,2)
self.menu=UIObject.get(self,3)
self.scrollView=UIScrollView.get(self,4)
self.btnClose=UIButton.get(self,5)
self.content=UIObject.get(self,6)
self.title=UIText.get(self,7)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIForeGroundThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.title);self.title=nil;
end
















local _CMP_INDEX={
name=0,
unSelect=1,
select=2,
reddot=3,
lock=4,
}
local _scrollLen=4
local _maxScrollViewHeight=400
local _itemHeight=79
local _itemSpace=5




function UIForeGroundThreeWin:onLoaded(...)
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)
end


function UIForeGroundThreeWin:__delete()
self.scrollView:setClickAction(nil)
self:unbindComponents()
self:clearReddotFunction()
end




function UIForeGroundThreeWin:onShow(argtable,afterOnloaded)
local activeUI=fullScreenUI.activeUI
self.replaceTitleName=activeUI.replaceTitleName
self.defaultTitleName=activeUI.defaultTitleName
self:freshMenuList()
self:refreshTitle()
if not self.isPlay then
self.back:setActive(false)
self:delayDo(0.1,function()
self.back:setActive(true)
end)
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
self.isFinishInit=true
end


function UIForeGroundThreeWin:onHide()
self.isPlay=false
self.isFinishInit=false
self:clearReddotFunction()
if self.selectMenuIdx then

self.selectMenuIdx=nil
end
end

function UIForeGroundThreeWin:refreshTitle()
local titleName
if self.replaceTitleName then
if type(self.replaceTitleName)=='table'then
if self.showMenuNum>0 then
local selectMenuIdx=self.selectMenuIdx
titleName=self.replaceTitleName[selectMenuIdx]
end
else
titleName=self.replaceTitleName
end
else
titleName=self.defaultTitleName or''
if self.showMenuNum>0 then
local activeUI=fullScreenUI.activeUI
local selectMenuIdx=self.selectMenuIdx
local menuList
if not activeUI.isShowUnActiveWin then
menuList=activeUI.activeSubMenu
else
menuList=self.unActiveMenuList
end

local tabType=menuList[selectMenuIdx].tabType
local tabConfig=fullScreenModel.getFullTabConfig(tabType)
if tabConfig.titleName~=nil then
titleName=tabConfig.titleName
end
end
end
self:setTitle(titleName)
end

function UIForeGroundThreeWin:setTitle(title)
self.title:setText(title)
end

function UIForeGroundThreeWin:freshMenuList()
if fullScreenUI.activeUI==nil then
return
end

local activeUI=fullScreenUI.activeUI

self:clearReddotFunction()
local menuList
if not activeUI.isShowUnActiveWin then
menuList=activeUI.activeSubMenu
else
self:initShowUnActiveMenuList()
menuList=self.unActiveMenuList
end

if menuList and#menuList>0 then
if not activeUI.isShowUnActiveWin then
self.selectMenuIdx=activeUI.activeMenuIndex
else
self.selectMenuIdx=self:getShowUnActiveSelectMenuIdx()
end

local tNum=#menuList

local originalPos=self.content:getChildAnchoredPosition()

self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),tNum>_scrollLen)
self.showMenuNum=tNum
if tNum>1 then
self.menu:setActive(true)
self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i,v in ipairs(menuList)do
self:fillMenu(activeUI,i,v)
end

if self.isFinishInit then
self.content:setChildAnchoredPos(originalPos.x,originalPos.y)
end
else
self.menu:setActive(false)
end
else
self.menu:setActive(false)
end
end

function UIForeGroundThreeWin:initShowUnActiveMenuList()
local activeUI=fullScreenUI.activeUI
local menuList={}
self.menuTypeList_lookup={}
self.unActiveMenuList={}
for i,v in ipairs(activeUI.subMenu)do
local tabType=v.tabType

local hideFunc=v.hideFunc
local isHide=false
if hideFunc then
isHide=hideFunc()
end

if not isHide then
local index=#menuList+1
self.menuTypeList_lookup[tabType]=index
menuList[index]=v
end
end
self.unActiveMenuList=menuList
end

function UIForeGroundThreeWin:getShowUnActiveSelectMenuIdx()
local activeUI=fullScreenUI.activeUI
local selectCfg=activeUI.activeSubMenu[activeUI.activeMenuIndex]
local selectTabType=selectCfg.tabType
local selectMenuIdx=self.menuTypeList_lookup[selectTabType]
return selectMenuIdx
end

function UIForeGroundThreeWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIForeGroundThreeWin:fillMenu(activeUI,index,config)
local tabIndex=index
local tabType=config.tabType
local tabConfig=fullScreenModel.getFullTabConfig(tabType)
local isTabOpen=fullScreenModel.isTabOpen(tabType)
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(-1,index)
local isSelect=self.selectMenuIdx==tabIndex
item:SetChildActive(_CMP_INDEX.unSelect,not isSelect)
item:SetChildActive(_CMP_INDEX.select,isSelect)
item:SetChildActive(_CMP_INDEX.lock,not isTabOpen)

local tabName
local nameStr=tabConfig.tabname
if config.getNameFun then
nameStr=config.getNameFun()
end
tabName=nameStr
item:SetChildText(_CMP_INDEX.name,tabName)

local isreddot=false
local reddotType=config.reddotType
if isTabOpen and reddotType then
isreddot=reddotClassManager.get_reddot(reddotType)
local func=function(...)
if self==nil or self.isClose then return end
self:refreshReddot(index,...)
end
self.reddotfuncs[reddotType]=func
reddotClassManager.register_event(reddotType,func)
end
item:SetChildActive(_CMP_INDEX.reddot,isreddot)


item:SetChildNewBieComponentId(-1,FMT.fmt('UIForeGroundThreeWin.menuItem_{0}',tabType))
item:SetChildWeakGuideComponentId(-1,FMT.fmt('UIForeGroundThreeWin.menuItem_{0}',tabType))
end

function UIForeGroundThreeWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.reddot,flag)
end

function UIForeGroundThreeWin:freshMenuSelect(activeUI,index)
if index==nil then
return
end
local menuList
local selectMenuIdx
if not activeUI.isShowUnActiveWin then
menuList=activeUI.activeSubMenu
selectMenuIdx=activeUI.activeMenuIndex
else
menuList=self.unActiveMenuList
selectMenuIdx=self:getShowUnActiveSelectMenuIdx()
end
local config=menuList[index]
if config==nil then
return
end
local item=self.scrollView:getGridObjectByindex(index-1)

local isSelect=selectMenuIdx~=index
item:SetChildActive(_CMP_INDEX.select,isSelect)
item:SetChildActive(_CMP_INDEX.unSelect,not isSelect)
end

function UIForeGroundThreeWin:on_click_callback(id,index,guid,attach)
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI
if index==self.selectMenuIdx then
return
end

local menuList
if not activeUI.isShowUnActiveWin then
menuList=activeUI.activeSubMenu
else
menuList=self.unActiveMenuList
end

if menuList and menuList[index]then
local conf=menuList[index]
local tabType=conf.tabType
if not fullScreenModel.checkTabEnoughCND(tabType)then
return fullScreenModel.showTabWarning(tabType)
end

local clickCond=conf.clickCond
if clickCond~=nil then
if not clickCond()then
return
end
end
self:freshMenuSelect(activeUI,self.selectMenuIdx)
self:freshMenuSelect(activeUI,index)
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
end
end




function UIForeGroundThreeWin:onBtnClose()
self.selectMenuIdx=nil
fullScreenUI.closeActiveUI(true)
end

function UIForeGroundThreeWin:setRootActive(flag)
self.root:setActive(flag)
end

