







def_class("UIForeGroundTwoWin",UIWindowBase)









function UIForeGroundTwoWin:bindComponents()

self.back=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.bg=UIImage.get(self,2)
self.menu=UIObject.get(self,3)
self.scrollView=UIScrollView.get(self,4)
self.btnClose=UIButton.get(self,5)
self.content=UIObject.get(self,6)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIForeGroundTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.content);self.content=nil;
end
















local _CMP_INDEX={
cmpSelfItem=0,
cmpName=1,
cmpReddot=2,
cmpBg=3,
cmpNomalIcon=4,
select=5,
}

local _scrollLen=7




function UIForeGroundTwoWin:onLoaded(...)
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)
end


function UIForeGroundTwoWin:__delete()
self.scrollView:setClickAction(nil)
self:unbindComponents()
self:clearReddotFunction()
end




function UIForeGroundTwoWin:onShow(argtable,afterOnloaded)
self:freshMenuList()
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


function UIForeGroundTwoWin:onHide()
self.isPlay=false
self.isFinishInit=false
self:clearReddotFunction()
if self.selectMenuIdx then

self.selectMenuIdx=nil
end
end

function UIForeGroundTwoWin:freshMenuList()
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

local originalPos=self.content:getChildAnchoredPosition()

self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),tNum>_scrollLen)
self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i,v in ipairs(activeSubMenu)do
self:fillMenu(activeUI,i,v)
end

if self.isFinishInit then
self.content:setChildAnchoredPos(originalPos.x,originalPos.y)
end
else
self.menu:setActive(false)
end
end

function UIForeGroundTwoWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIForeGroundTwoWin:fillMenu(activeUI,index,config)
local tabIndex=index
local tabConfig=fullScreenModel.getFullTabConfig(config.tabType)
local selectMenuIdx=activeUI.activeMenuIndex
local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildActive(_CMP_INDEX.cmpBg,true)
item:SetChildActive(_CMP_INDEX.select,selectMenuIdx==tabIndex)
local tabName
local nameStr=tabConfig.tabname
if config.getNameFun then
nameStr=config.getNameFun()
end
if selectMenuIdx==tabIndex then
item:SetChildActive(_CMP_INDEX.cmpBg,false)

local selecticon=assetConfig.selecticon
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,selecticon[1],selecticon[2])
tabName=nameStr
else
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
tabName=FMT.fmt("<color=#d0b496>{0}</color>",nameStr)
end
item:SetChildText(_CMP_INDEX.cmpName,tabName)

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


item:SetChildNewBieComponentId(_CMP_INDEX.cmpSelfItem,FMT.fmt('UIForeGroundTwoWin.menuItem9_{0}',tabType))
item:SetChildWeakGuideComponentId(_CMP_INDEX.cmpSelfItem,FMT.fmt('UIForeGroundTwoWin.menuItem9_{0}',tabType))
end

function UIForeGroundTwoWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.cmpReddot,flag)
end

function UIForeGroundTwoWin:freshMenuSelect(activeUI,index)
if index==nil then
return
end
local activeSubMenu=activeUI.activeSubMenu
local config=activeSubMenu[index]
if config==nil then
return
end
local selectMenuIdx=activeUI.activeMenuIndex
local item=self.scrollView:getGridObjectByindex(index-1)

local isSelect=selectMenuIdx~=index
item:SetChildActive(_CMP_INDEX.cmpBg,not isSelect)
item:SetChildActive(_CMP_INDEX.select,isSelect)

local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local tabConfig=fullScreenModel.getFullTabConfig(tabType)
local tabName
local nameStr=tabConfig.tabname
if config.getNameFun then
nameStr=config.getNameFun()
end

if isSelect then
local selecticon=assetConfig.selecticon
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,selecticon[1],selecticon[2])
tabName=nameStr
else
local nomalicon=assetConfig.nomalicon
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
tabName=FMT.fmt("<color=#d0b496>{0}</color>",nameStr)
end
item:SetChildText(_CMP_INDEX.cmpName,tabName)
end

function UIForeGroundTwoWin:on_click_callback(id,index,guid,attach)
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

function UIForeGroundTwoWin:onBtnClose()
self.selectMenuIdx=nil
fullScreenUI.closeActiveUI(true)
end

