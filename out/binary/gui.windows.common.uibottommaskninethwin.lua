







def_class("UIBottomMaskNinethWin",UIWindowBase)









function UIBottomMaskNinethWin:bindComponents()

self.root=UIObject.get(self,0)
self.menu=UIObject.get(self,1)
self.animFan=UIObject.get(self,2)
self.scrollView=UIScrollView.get(self,3)
self.title=UIText.get(self,4)
self.bg=UIObject.get(self,5)



end


function UIBottomMaskNinethWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.animFan);self.animFan=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.bg);self.bg=nil;
end


















local _CMP_INDEX={
cmpSelfItem=0,
cmpNomalIcon=1,
cmpSelectRoot=2,
cmpSelectIcon=3,
cmpReddot=4,
}

local _scrollLen=4


function UIBottomMaskNinethWin:onLoaded(...)
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)
self.isInit=false
end


function UIBottomMaskNinethWin:__delete()
self.scrollView:setClickAction(nil)

self:unbindComponents()
self:clearReddotFunction()
end




function UIBottomMaskNinethWin:onShow(argtable,afterOnloaded)

self.args=argtable or{}










if not self.isPlay then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.bg:getID(),'',0,2)
end
self.isPlay=true
self:setAsFirstSibling()

self:freshMenuList()

self.isInit=true
end


function UIBottomMaskNinethWin:onHide()
self.isPlay=false
self:clearReddotFunction()
self.isInit=false
end

function UIBottomMaskNinethWin:on_click_callback(id,index,guid,attach)
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
self:freshMenuSelect(self.selectMenuIdx)
self:freshMenuSelect(index)
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

function UIBottomMaskNinethWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIBottomMaskNinethWin:freshMenuList()
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI

self:clearReddotFunction()
local config=cfgHelper.get1(cfg_fullsystemconfig_get,activeUI.fullType)
if config then
self.title:setText(config.name)
end

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
if not self.isInit then
self.scrollView:setChildCanvasGroupAlpha(0)
self.scrollView:setChildCanvasGroupDOFade(1,0.5):SetDelay(0.5)
end
else
self.menu:setActive(false)
end
end

function UIBottomMaskNinethWin:freshMenuSelect(activeUI,index)
if index==nil then
return
end
local activeSubMenu=activeUI.activeSubMenu
local config=activeSubMenu[index]
if config==nil then
return
end
local selectMenuIdx=activeUI.activeMenuIndex
local item=self.winlua:GetChildCSGUIBaseItem(index-1)
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,selectMenuIdx==index)
end

function UIBottomMaskNinethWin:fillMenu(activeUI,index,config)
local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local selecticon=assetConfig.selecticon
local selectMenuIdx=activeUI.activeMenuIndex

local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,selectMenuIdx==index)


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
item:SetChildNewBieComponentId(-1,FMT.fmt('UIBottomMaskNinethWin.btnClick.{0}',index))
end

function UIBottomMaskNinethWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.cmpReddot,flag)
end

function UIBottomMaskNinethWin:OnStart()
self.animFan:setChildUIModelShowTarget(2007,1,nil,eAnimationID.enter)
end

function UIBottomMaskNinethWin:OnDisplay()
self.animFan:setChildModelAnimationState(eAnimationID.enter)
end

function UIBottomMaskNinethWin:setTitle(title)
self.title:setText(title)
end

function UIBottomMaskNinethWin:setBgSprite(abname,asset)
self.bg:setCSImageSprite(abname,asset)
end


function UIBottomMaskNinethWin:onClickCloseBtn()

AudioManager.playBtnClick()
self:onClickClose()
end

function UIBottomMaskNinethWin:onClickClose()
if self.args.close then
self.args.close()
else
fullScreenUI.closeActiveUI(true)
end
end


