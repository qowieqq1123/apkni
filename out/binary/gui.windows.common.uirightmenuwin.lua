







def_class("UIRightMenuWin",UIWindowBase)









function UIRightMenuWin:bindComponents()

self.ScrollView=UIScrollView.get(self,0)



end


function UIRightMenuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end



















local _CMP_INDEX=
{
cmpSelfItem=0,
cmpNomalIcon=1,
cmpSelectRoot=2,
cmpSelectIcon=3,
cmpReddot=4,
}

local _scrollLen=4


function UIRightMenuWin:onLoaded(...)
self:bindComponents()
self._on_click_callback=function(...)
self:on_click_callback(...)
end
self.ScrollView:setClickAction(self._on_click_callback)
end


function UIRightMenuWin:__delete()
self.ScrollView:setClickAction(nil)
self:unbindComponents()
end




function UIRightMenuWin:onShow(argtable,afterOnloaded)
self:freshMenuList()
end


function UIRightMenuWin:onHide()

end



function UIRightMenuWin:freshMenuList()
if fullScreenUI.activeUI==nil then return end
local activeUI=fullScreenUI.activeUI

local subMenu=activeUI.subMenu
local activeSubMenu=activeUI.activeSubMenu

if activeSubMenu==nil or#activeSubMenu==0 then return end
self.selectMenuIdx=activeUI.activeMenuIndex

local tNum=#activeSubMenu

self.winlua:SetChildScrollRectEnable(self.ScrollView:getID(),tNum>_scrollLen)
self.ScrollView:freshGridsNum(tNum,tNum,1,true)
for i,v in ipairs(activeSubMenu)do
self:fillMenu(activeUI,i,v)
end
end

function UIRightMenuWin:fillMenu(activeUI,index,config)
local tabType=config.tabType
local assetConfig=fullScreenModel.getFullTabAssetConfig(tabType)
local nomalicon=assetConfig.nomalicon
local selecticon=assetConfig.selecticon
local selectMenuIdx=activeUI.activeMenuIndex

local item=self.ScrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,selectMenuIdx==index)
item:SetChildCSImageSprite(_CMP_INDEX.cmpSelectIcon,selecticon[1],selecticon[2])
item:SetChildActive(_CMP_INDEX.cmpReddot,false)
end

function UIRightMenuWin:freshMenuSelect(activeUI,index)
if index==nil then return end
local activeSubMenu=activeUI.activeSubMenu
local config=activeSubMenu[index]
if config==nil then return end
local selectMenuIdx=activeUI.activeMenuIndex
local item=self.winlua:GetChildCSGUIBaseItem(index-1)
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,selectMenuIdx==index)
end

function UIRightMenuWin:on_click_callback(id,index,guid,attach)
if fullScreenUI.activeUI==nil then return end
local activeUI=fullScreenUI.activeUI
if index==self.selectMenuIdx then return end
self:freshMenuSelect(self.selectMenuIdx)
self:freshMenuSelect(index)
activeUI.activeMenuIndex=index
self.selectMenuIdx=index
if activeUI.activeSubMenu and activeUI.activeSubMenu[index]then
local conf=activeUI.activeSubMenu[index]
local clickCall=conf.callback
local tabType=conf.tabType
if clickCall==nil then
loggerUtil.logErrFMT('没有找到配置页签类型：{0}的点击事件',tabType)
return
end
local isload=activeUI.showTabTypeList[tabType]
local argstable=nil
if activeUI.attach then
argstable=activeUI.attach
end
clickCall(argstable)
end
end