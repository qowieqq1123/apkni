







def_class("UIWanBaoXunBaoDui_MenuWin",UIWindowBase)









function UIWanBaoXunBaoDui_MenuWin:bindComponents()

self.Root=UIObject.get(self,0)
self.menuRoot=UIObject.get(self,1)
self.menulist=UIScrollView.get(self,2)
self.menucontent=UIObject.get(self,3)
self.chilunspine=UIObject.get(self,4)
self.spine=UIObject.get(self,5)
self.returnbtn=UIButton.get(self,6)
self.closebtn=UIButton.get(self,7)

self.returnbtn:setButtonClick(function()self:onReturnbtn()end)

self.closebtn:setButtonClick(function()self:onClosebtn()end)



end


function UIWanBaoXunBaoDui_MenuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.menuRoot);self.menuRoot=nil;
_UIObject_release(self.menulist);self.menulist=nil;
_UIObject_release(self.menucontent);self.menucontent=nil;
_UIObject_release(self.chilunspine);self.chilunspine=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.returnbtn);self.returnbtn=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
end

















local _this=nil
local _scrollLen=7

local _CMP_INDEX={
cmpSelfItem=0,
cmpBg=1,
cmpNomalIcon=2,
select=3,
cmpReddot=4,
cmpName=5
}




function UIWanBaoXunBaoDui_MenuWin:onLoaded(...)
self:bindComponents()
_this=self
local clickMenu=function(...)
self:on_click_callback(...)
end
self.menulist:setClickAction(clickMenu)
end


function UIWanBaoXunBaoDui_MenuWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_MenuWin:onShow(argtable,afterOnloaded)
self:freshMenuList()
if not self.isPlay then

self.Root:setChildCanvasGroupAlpha(0)
local cavasGroup=self.Root:getCommonComponent('CanvasGroup')
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


function UIWanBaoXunBaoDui_MenuWin:onHide()
self.isPlay=false
self:clearReddotFunction()
if self.selectMenuIdx then

self.selectMenuIdx=nil
end
end




function UIWanBaoXunBaoDui_MenuWin:freshMenuList()
if fullScreenUI.activeUI==nil then
return
end




local activeUI=fullScreenUI.activeUI

self:clearReddotFunction()

local activeSubMenu=activeUI.activeSubMenu
if activeSubMenu and#activeSubMenu>0 then
self.menuRoot:setActive(true)
self.selectMenuIdx=activeUI.activeMenuIndex

local curSubMenu=activeSubMenu[self.selectMenuIdx]
self.returnbtn:setActive(curSubMenu.tabType~=FULL_TAB_TYPE.eWBXBD_MT)

local tNum=#activeSubMenu
self.winlua:SetChildScrollRectEnable(self.menulist:getID(),tNum>_scrollLen)
self.menulist:freshGridsNum(tNum,1,tNum,true)
for i,v in ipairs(activeSubMenu)do
self:fillMenu(activeUI,i,v)
end

else
self.menuRoot:setActive(false)
self.returnbtn:setActive(false)
end
end

function UIWanBaoXunBaoDui_MenuWin:clearReddotFunction()
if self.reddotfuncs then
for k,v in pairs(self.reddotfuncs)do
reddotClassManager.unregister_event(k,v)
end
end
self.reddotfuncs={}
end

function UIWanBaoXunBaoDui_MenuWin:fillMenu(activeUI,index,config)
local tabIndex=index
local tabConfig=fullScreenModel.getFullTabConfig(config.tabType)
local selectMenuIdx=activeUI.activeMenuIndex
local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local selecticon=assetConfig.selecticon

local item=self.menulist:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildActive(_CMP_INDEX.cmpBg,true)
item:SetChildActive(_CMP_INDEX.select,selectMenuIdx==tabIndex)
local tabName
item:SetChildCSImageSprite(_CMP_INDEX.select,selecticon[1],selecticon[2])
item:SetChildCSImageSprite(_CMP_INDEX.cmpBg,nomalicon[1],nomalicon[2])

if selectMenuIdx==tabIndex then

tabName=tabConfig.tabname
else
tabName=FMT.fmt("<color=#d0b496>{0}</color>",tabConfig.tabname)
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


item:SetChildNewBieComponentId(_CMP_INDEX.cmpSelfItem,FMT.fmt('UIWanBaoXunBaoDui_MenuWin.menuItem9_{0}',tabType))
item:SetChildWeakGuideComponentId(_CMP_INDEX.cmpSelfItem,FMT.fmt('UIWanBaoXunBaoDui_MenuWin.menuItem9_{0}',tabType))
end

function UIWanBaoXunBaoDui_MenuWin:refreshReddot(index,class,sub_typo,last_flag,flag)
local item=self.menulist:getGridObjectByindex(index-1)
item:SetChildActive(_CMP_INDEX.cmpReddot,flag)
end

function UIWanBaoXunBaoDui_MenuWin:freshMenuSelect(activeUI,index)
if index==nil then
return
end
local activeSubMenu=activeUI.activeSubMenu
local config=activeSubMenu[index]
if config==nil then
return
end
local selectMenuIdx=activeUI.activeMenuIndex
local item=self.menulist:getGridObjectByindex(index-1)

local isSelect=selectMenuIdx~=index
item:SetChildActive(_CMP_INDEX.cmpBg,not isSelect)
item:SetChildActive(_CMP_INDEX.select,isSelect)

local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local tabConfig=fullScreenModel.getFullTabConfig(tabType)
local tabName
if isSelect then
local selecticon=assetConfig.selecticon
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,selecticon[1],selecticon[2])
tabName=tabConfig.tabname
else
local nomalicon=assetConfig.nomalicon
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
tabName=FMT.fmt("<color=#d0b496>{0}</color>",tabConfig.tabname)
end
item:SetChildText(_CMP_INDEX.cmpName,tabName)
self.returnbtn:setActive(tabType~=FULL_TAB_TYPE.eWBXBD_MT)
end

function UIWanBaoXunBaoDui_MenuWin:on_click_callback(id,index,guid,attach)
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
self.returnbtn:setActive(tabType~=FULL_TAB_TYPE.eWBXBD_MT)
clickCall(argstable)
if argstable then
argstable.clickMenu=nil
end

AudioManager.playOpenUI()
end
end

function UIWanBaoXunBaoDui_MenuWin:onClosebtn()
self.selectMenuIdx=nil
fullScreenUI.closeActiveUI(true)
end

function UIWanBaoXunBaoDui_MenuWin:onReturnbtn()
self:on_click_callback(nil,1)
end

function UIWanBaoXunBaoDui_MenuWin:playSwitchAnimation(speed)
self.winlua:SetChildSpineAnimation(self.spine:getID(),eAnimationID.stand2,speed,nil)
end