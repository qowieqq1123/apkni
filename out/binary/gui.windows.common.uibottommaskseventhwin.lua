







def_class("UIBottomMaskSeventhWin",UIWindowBase)









function UIBottomMaskSeventhWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.menuGrid=UIObject.get(self,1)
self.animRoot=UIObject.get(self,2)



end


function UIBottomMaskSeventhWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.menuGrid);self.menuGrid=nil;
_UIObject_release(self.animRoot);self.animRoot=nil;
end
















local animLookup={
'lingshoukaihua_lock',
'lingshoukaihua_close_idle',
'lingshoukaihua_close',
'lingshoukaihua_open_idle',
'lingshoukaihua_open',
}


function UIBottomMaskSeventhWin:onLoaded(...)
self:bindComponents()
end


function UIBottomMaskSeventhWin:__delete()
self:unbindComponents()
self:clearReddotFunction()
end


function UIBottomMaskSeventhWin:onHide()
self.isPlay=false
self:clearReddotFunction()
end




function UIBottomMaskSeventhWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local clickMenu=argtable.clickMenu or false
local activeUI=fullScreenUI.activeUI
self.replaceTitleName=activeUI.replaceTitleName
self.defaultTitleName=activeUI.defaultTitleName

local oldShowMenu=self.showMenu
local oldshowMenuNum=self.showMenuNum
self.showMenu,self.showMenuNum=self:hasMenu()
local menuChange=oldShowMenu~=self.showMenu or oldshowMenuNum~=self.showMenuNum

if not self.isPlay then
if not afterOnloaded then

self.animRoot:setAnimatorInteger('state',0,true)
end
self.menuGrid:setActive(false)
local func=function()
self.menuGrid:setActive(true)
end
self:delayDo(0.2,func)

self:refreshTitle()
self:refreshMenuList()
end
self:setAsFirstSibling()
self.isPlay=true
self:refreshTitle()
self:refreshMenuList()
end

function UIBottomMaskSeventhWin:hasMenu()
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

function UIBottomMaskSeventhWin:setTitle(title)
self.titleTxt:setText(title)
end

function UIBottomMaskSeventhWin:refreshTitle()
local titleName
if self.replaceTitleName then
if type(self.replaceTitleName)=='table'then
if self.showMenu then
local activeUI=fullScreenUI.activeUI
local selectMenuIdx=activeUI.activeMenuIndex
titleName=self.replaceTitleName[selectMenuIdx]
end
else
titleName=self.replaceTitleName
end
else
titleName=self.defaultTitleName or''
if self.showMenu then
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


function UIBottomMaskSeventhWin:onClickCloseBtn()

AudioManager.playBtnClick()
self:onClickClose()
end

function UIBottomMaskSeventhWin:onClickClose()
fullScreenUI.closeActiveUI(true)
end

function UIBottomMaskSeventhWin:refreshMenuList()
if fullScreenUI.activeUI==nil then
return
end
self:clearReddotFunction()
local activeUI=fullScreenUI.activeUI
local activeSubMenu=activeUI.activeSubMenu
self.selectMenuIdx=activeUI.activeMenuIndex
local num=3
self.menuGrid:setChildLayoutGroupCreateItems(num)
local gridlist=self.menuGrid:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
local isshow=activeSubMenu~=nil and activeSubMenu[i]~=nil
item:SetChildActive(4,isshow)
if isshow then
self:fillMenu(item,activeUI,i,activeSubMenu[i])
else
item:SetChildAnimationStringID(0,animLookup[1])
end
local func=function()
self:on_click_callback(i)
end
item:SetChildButtonClick(3,func,true)
end
end

function UIBottomMaskSeventhWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIBottomMaskSeventhWin:fillMenu(item,activeUI,index,config)
local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local selectMenuIdx=activeUI.activeMenuIndex

item:SetChildCSImageSprite(1,nomalicon[1],nomalicon[2])
local animIdx=selectMenuIdx==index and 4 or 2
item:SetChildAnimationStringID(0,animLookup[animIdx])

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
item:SetChildActive(2,isreddot)

item:SetChildNewBieComponentId(3,FMT.fmt('UIBottomMaskSeventhWin.btnClick.{0}',index))
end

function UIBottomMaskSeventhWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.menuGrid:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(2,flag)
end

function UIBottomMaskSeventhWin:refreshMenuSelect(activeUI,index,is_select)
if index==nil then
return
end
local activeSubMenu=activeUI.activeSubMenu
local config=activeSubMenu[index]
if config==nil then
return
end
local item=self.menuGrid:getChildLayoutGroupGridItem(index-1)
local animIdx=is_select==true and 5 or 3




item:SetChildAnimationStringID(0,animLookup[animIdx],true,nil)
end

function UIBottomMaskSeventhWin:on_click_callback(index)
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
self:refreshMenuSelect(activeUI,self.selectMenuIdx,false)
self:refreshMenuSelect(activeUI,index,true)
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