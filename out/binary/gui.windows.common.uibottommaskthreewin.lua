







def_class("UIBottomMaskThreeWin",UIWindowBase)









function UIBottomMaskThreeWin:bindComponents()

self.root=UIObject.get(self,0)
self.menulist=UIObject.get(self,1)
self.title=UIText.get(self,2)
self.back=UIObject.get(self,3)
self.scrollView=UIScrollView.get(self,4)
self.menu_anim_1=UIObject.get(self,5)
self.menu_anim_2=UIObject.get(self,6)
self.menu_anim_3=UIObject.get(self,7)
self.menu_anim_4=UIObject.get(self,8)
self.menu_anim_5=UIObject.get(self,9)
self.menuAnimGrid=UIObject.get(self,10)
self.menu_anim_6=UIObject.get(self,11)
self.menu_anim={
self.menu_anim_1,
self.menu_anim_2,
self.menu_anim_3,
self.menu_anim_4,
self.menu_anim_5,
self.menu_anim_6,
}



end


function UIBottomMaskThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.menulist);self.menulist=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.menu_anim_2);self.menu_anim_2=nil;
_UIObject_release(self.menu_anim_3);self.menu_anim_3=nil;
_UIObject_release(self.menu_anim_4);self.menu_anim_4=nil;
_UIObject_release(self.menu_anim_5);self.menu_anim_5=nil;
_UIObject_release(self.menuAnimGrid);self.menuAnimGrid=nil;
_UIObject_release(self.menu_anim_6);self.menu_anim_6=nil;
self.menu_anim=nil;
end
















local _CMP_INDEX={
cmpSelfItem=0,
cmpNomalIcon=1,
cmpReddot=2,
cmpBtnClick=3,
cmpLock=4,
}
local body_id={
back=2016,
menu=2017,
}
local menu_slot_name='button_dytab'

local _scrollLen=5


function UIBottomMaskThreeWin:onLoaded(...)
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)
self:setAsFirstSibling(-1)
end


function UIBottomMaskThreeWin:__delete()
self.scrollView:setClickAction(nil)
self:unbindComponents()
self:clearReddotFunction()
end


function UIBottomMaskThreeWin:onHide()
self.isPlay=false
self:clearReddotFunction()
end




function UIBottomMaskThreeWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local clickMenu=argtable.clickMenu or false
local activeUI=fullScreenUI.activeUI
self.replaceTitleName=activeUI.replaceTitleName
self.defaultTitleName=activeUI.defaultTitleName




local oldShowMenu=self.showMenu
local oldshowMenuNum=self.showMenuNum
local old_fullType=self.fullType
self.fullType=activeUI.fullType
self.showMenu,self.showMenuNum=self:hasMenu()
local menuChange=oldShowMenu~=self.showMenu or oldshowMenuNum~=self.showMenuNum
if not self.isPlay then
local isfirst=afterOnloaded
local cb=nil
if isfirst then
self.animLock1=true
cb=function()
self:onLoadFinish(menuChange)
end
end

self.back:setChildSpineAnimation(eAnimationID.common_window_enter,1,cb)

AudioManager.playAudio(633)
if not isfirst then
self:onLoadFinish(menuChange)
end
else
if menuChange then
self:onLoadFinish(true)
end
end
self:setAsFirstSibling()
self.isPlay=true
self:freshMenuList()
self:refreshTitle()
end


function UIBottomMaskThreeWin:rebuildMenu(newSelectIndex)
self:onShow()
end


function UIBottomMaskThreeWin:reSelectMenu(index)
self:on_click_callbackEx(index)
end

function UIBottomMaskThreeWin:onLoadFinish(isNew)
self.animLock1=nil
self:clearMenuTweener()
self.menuAnimGrid:setChildCanvasGroupAlpha(0)
self.menulist:setChildCanvasGroupAlpha(0)
local activeUI=fullScreenUI.activeUI
if self.showMenu==true then
local func=function()
self.menuAnimGrid:setChildCanvasGroupAlpha(1)
local selectMenuIdx=activeUI.activeMenuIndex
for i,v in ipairs(self.menu_anim)do
local isshow=i<=self.showMenuNum
local anim=self.menu_anim[i]
local func2=function()
if isshow then
local isGray=false
local item=self.scrollView:getGridObjectByindex(i-1)
if activeUI.activeSubMenu then
local subMenu=activeUI.activeSubMenu[i]
isGray=subMenu.checkGray and subMenu.checkGray()or false
end
item:SetChildActive(_CMP_INDEX.cmpLock,isGray)

local name
if isGray then
name=FMT.fmt("{0}_{1}",menu_slot_name,3)
else
if selectMenuIdx==i then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end
end

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,name)
end
end
local cb=nil
if isNew then
cb=func2
end
anim:setChildUIModelShowTarget(body_id.menu,1,{},eAnimationID.common_window_enter,false,false,0,cb)
if not isNew then
func2()
end
anim:setActive(isshow)
end
end
self:delayDo(0.1,func)
self.animLock1=true
local func1=function()
self.animLock1=nil
self.menulist:setChildCanvasGroupAlpha(0)
local fun3=function()
self.menuTweener=nil
end
self.menuTweener=self.menulist:setChildCanvasGroupDOFade(1,1,fun3)
end
self:delayDo(0.4,func1)
end
end

function UIBottomMaskThreeWin:clearMenuTweener()
if self.menuTweener~=nil then
self.menuTweener:Complete()
self.menuTweener=nil
end
end

function UIBottomMaskThreeWin:hasMenu()
local activeUI=fullScreenUI.activeUI
if activeUI then
local activeSubMenu=activeUI.activeSubMenu
if activeSubMenu then
local num=#activeSubMenu
if num>1 then
return true,num
else
return false,num
end
end
end
return false,0
end




function UIBottomMaskThreeWin:setTitle(title)
self.title:setText(title)
end

function UIBottomMaskThreeWin:refreshTitle()
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


function UIBottomMaskThreeWin:onClickCloseBtn()
if self.animLock1==true then return end

AudioManager.playBtnClick()
fullScreenUI.closeActiveUI(true)
end

function UIBottomMaskThreeWin:onClickClose()
if self.animLock1==true then return end
fullScreenUI.closeActiveUI(true)
end

function UIBottomMaskThreeWin:freshMenuList()
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI

self:clearReddotFunction()
local activeSubMenu=activeUI.activeSubMenu
if self.showMenu then
self.selectMenuIdx=activeUI.activeMenuIndex

local tNum=#activeSubMenu


self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i,v in ipairs(activeSubMenu)do
self:fillMenu(activeUI,i,v)
end
end
end

function UIBottomMaskThreeWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIBottomMaskThreeWin:fillMenu(activeUI,index,config)
local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local selectMenuIdx=activeUI.activeMenuIndex


local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
local anim=self.menu_anim[index]

local subMenu=activeUI.activeSubMenu[index]
local isGray=subMenu.checkGray and subMenu.checkGray()or false
item:SetChildActive(_CMP_INDEX.cmpLock,isGray)

local name
if isGray then
name=FMT.fmt("{0}_{1}",menu_slot_name,3)
else
if selectMenuIdx==index then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end
end

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,name)

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
item:SetChildNewBieComponentId(-1,FMT.fmt('UIBottomMaskThreeWin.btnClick.{0}',index))
end

function UIBottomMaskThreeWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.cmpReddot,flag)
end

function UIBottomMaskThreeWin:freshMenuSelect(activeUI,index,is_select)
if index==nil then
return
end
local activeSubMenu=activeUI.activeSubMenu
local config=activeSubMenu[index]
if config==nil then
return
end

local anim=self.menu_anim[index]
if is_select then
anim:setChildModelAnimationState(eAnimationID.common_window_dianji)
end

local selectMenuIdx=activeUI.activeMenuIndex
local item=self.scrollView:getGridObjectByindex(index-1)
local subMenu=activeUI.activeSubMenu[index]
local isGray=subMenu.checkGray and subMenu.checkGray()or false
item:SetChildActive(_CMP_INDEX.cmpLock,isGray)

local name
if isGray then
name=FMT.fmt("{0}_{1}",menu_slot_name,3)
else
if selectMenuIdx==index then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end
end

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,name)
end

function UIBottomMaskThreeWin:on_click_callback(id,index,guid,attach)
if self.animLock1==true then return end
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
local tabType=conf.tabType
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

function UIBottomMaskThreeWin:on_click_callbackEx(index)
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI
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

local clickCall=conf.callback
local tabType=conf.tabType
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