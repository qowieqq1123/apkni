







def_class("UIBottomMaskFourthWin",UIWindowBase)









function UIBottomMaskFourthWin:bindComponents()

self.menulist=UIObject.get(self,0)
self.back=UIObject.get(self,1)
self.scrollView=UIScrollView.get(self,2)
self.menu_anim_1=UIObject.get(self,3)
self.menu_anim_2=UIObject.get(self,4)
self.menu_anim_3=UIObject.get(self,5)
self.menu_anim_4=UIObject.get(self,6)
self.menuAnimGrid=UIObject.get(self,7)
self.menu_anim={
self.menu_anim_1,
self.menu_anim_2,
self.menu_anim_3,
self.menu_anim_4,
}



end


function UIBottomMaskFourthWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.menulist);self.menulist=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.menu_anim_2);self.menu_anim_2=nil;
_UIObject_release(self.menu_anim_3);self.menu_anim_3=nil;
_UIObject_release(self.menu_anim_4);self.menu_anim_4=nil;
_UIObject_release(self.menuAnimGrid);self.menuAnimGrid=nil;
self.menu_anim=nil;
end
















local _CMP_INDEX={
cmpSelfItem=0,
cmpReddot=1,
cmpName=2,
}
local body_menu_id=2017
local menu_slot_name='button_dytab'

local _scrollLen=4


function UIBottomMaskFourthWin:onLoaded(...)
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.scrollView:setClickAction(self._on_click_callback)
end


function UIBottomMaskFourthWin:__delete()
self.scrollView:setClickAction(nil)
self:unbindComponents()
self:clearReddotFunction()
end




function UIBottomMaskFourthWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local clickMenu=argtable.clickMenu or false
local oldShowMenu=self.showMenu
self.showMenu,self.showMenuNum=self:hasMenu()
if not self.isPlay then
local isfirst=afterOnloaded
self:onLoadFinish(isfirst)
else
if oldShowMenu~=self.showMenu then
self:onLoadFinish()
end
end
self:setAsFirstSibling()
self.isPlay=true
self:freshMenuList()
end

function UIBottomMaskFourthWin:onLoadFinish(isfirst)
self.menulist:setActive(false)
local activeUI=fullScreenUI.activeUI
if self.showMenu==true then
local selectMenuIdx=activeUI.activeMenuIndex
for i,v in ipairs(self.menu_anim)do
local isshow=i<=self.showMenuNum
local anim=self.menu_anim[i]
local func=function()

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,selectMenuIdx==i and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
local cb=nil
if isfirst then
cb=func
end
anim:setChildUIModelShowTarget(body_menu_id,1,{},eAnimationID.common_window_enter,false,false,0,cb)
if not isfirst then
func()
end
anim:setActive(isshow)
end

local func1=function()
self.menulist:setActive(true)
self.menulist:setChildCanvasGroupAlpha(0)
self.menulist:setChildCanvasGroupDOFade(1,1,nil)
end
self:delayDo(0.3,func1)
end
end

function UIBottomMaskFourthWin:hasMenu()
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


function UIBottomMaskFourthWin:onHide()
self.isPlay=false
self:clearReddotFunction()
end


function UIBottomMaskFourthWin:onClickCloseBtn()

AudioManager.playBtnClick()
self:onClickClose()
end

function UIBottomMaskFourthWin:onClickClose()
fullScreenUI.closeActiveUI(true)
end

function UIBottomMaskFourthWin:freshMenuList()
if fullScreenUI.activeUI==nil then
return
end
local activeUI=fullScreenUI.activeUI


local config=cfgHelper.get1(cfg_fullsystemconfig_get,activeUI.fullType)
if config then

end
self:clearReddotFunction()
local activeSubMenu=activeUI.activeSubMenu
if self.showMenu then
self.selectMenuIdx=activeUI.activeMenuIndex

local tNum=#activeSubMenu

self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),tNum>_scrollLen)
self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i,v in ipairs(activeSubMenu)do
self:fillMenu(activeUI,i,v)
end
end
end

function UIBottomMaskFourthWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIBottomMaskFourthWin:fillMenu(activeUI,index,config)
local tabType=config.tabType
local tabConfig=fullScreenModel.getFullTabConfig(tabType)
local selectMenuIdx=activeUI.activeMenuIndex

local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildText(_CMP_INDEX.cmpName,tabConfig.tabname)
local anim=self.menu_anim[index]

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,selectMenuIdx==index and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))

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

function UIBottomMaskFourthWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.cmpReddot,flag)
end

function UIBottomMaskFourthWin:freshMenuSelect(activeUI,index,is_select)
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
local anim=self.menu_anim[index]
if is_select then
anim:setChildModelAnimationState(eAnimationID.common_window_dianji)
end

self.winlua:SetChildUIModelShowSlotAttachment(anim:getID(),menu_slot_name,is_select and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIBottomMaskFourthWin:on_click_callback(id,index,guid,attach)
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
end
end