







def_class("UIBottomMaskTwoWin",UIWindowBase)









function UIBottomMaskTwoWin:bindComponents()

self.background=UIObject.get(self,0)
self.menu=UIObject.get(self,1)
self.title=UIText.get(self,2)
self.animDB=UIObject.get(self,3)
self.mouse1=UIObject.get(self,4)
self.mouse2=UIObject.get(self,5)
self.scrollView=UIScrollView.get(self,6)



end


function UIBottomMaskTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.animDB);self.animDB=nil;
_UIObject_release(self.mouse1);self.mouse1=nil;
_UIObject_release(self.mouse2);self.mouse2=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end
















local _CMP_INDEX={
cmpSelfItem=0,
cmpNomalIcon=1,
cmpSelectRoot=2,
cmpSelectIcon=3,
cmpReddot=4,
}

local _scrollLen=4


function UIBottomMaskTwoWin:onLoaded(...)
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)
self:initAI()
end


function UIBottomMaskTwoWin:__delete()
self.scrollView:setClickAction(nil)


self:unbindComponents()
self:clearReddotFunction()
end




function UIBottomMaskTwoWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local clickMenu=argtable.clickMenu or false
if not self.isPlay then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.background:getID(),'',0,2)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.menu:getID(),'',0,2)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.animDB:getID(),'',0,2)
end
self:setAsFirstSibling()
self.isPlay=true
self:freshMenuList()
self:resetAI(false)
end


function UIBottomMaskTwoWin:onHide()
self.isPlay=false
self:resetAI(true)
self:clearReddotFunction()
end




function UIBottomMaskTwoWin:setTitle(title)
self.title:setText(title)
end

function UIBottomMaskTwoWin:onClickClose()
fullScreenUI.closeActiveUI(true)
end

function UIBottomMaskTwoWin:freshMenuList()
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI


local config=cfgHelper.get1(cfg_fullsystemconfig_get,activeUI.fullType)
if config then
self.title:setText(config.name)
end

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

function UIBottomMaskTwoWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIBottomMaskTwoWin:fillMenu(activeUI,index,config)
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
end

function UIBottomMaskTwoWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.cmpReddot,flag)
end

function UIBottomMaskTwoWin:freshMenuSelect(activeUI,index)
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

function UIBottomMaskTwoWin:on_click_callback(id,index,guid,attach)
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

function UIBottomMaskTwoWin:OnDisplay()
self.animDB:setChildUIModelShowTarget(2006,1,nil,eAnimationID.enter)
self.animDB:setChildModelAnimationState(5)
end

function UIBottomMaskTwoWin:OnComplete()

self.animDB:setChildModelAnimationState(0)
end

function UIBottomMaskTwoWin:initAI()

















end

function UIBottomMaskTwoWin:resetAI(sleep)




end

function UIBottomMaskTwoWin:onClickMouse1()

end

function UIBottomMaskTwoWin:onClickMouse2()

end