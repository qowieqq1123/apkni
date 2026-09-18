







def_class("UIXJTianShuDianBuildingDetailWin",UIWindowBase)









function UIXJTianShuDianBuildingDetailWin:bindComponents()

self.levelPanel=UIObject.get(self,0)



end


function UIXJTianShuDianBuildingDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.levelPanel);self.levelPanel=nil;
end



















function UIXJTianShuDianBuildingDetailWin:onLoaded(...)
self:bindComponents()
end


function UIXJTianShuDianBuildingDetailWin:__delete()
self:unbindComponents()
end




function UIXJTianShuDianBuildingDetailWin:onShow(argtable,afterOnloaded)
self.bdData=argtable.bdData
self.build_id=self.bdData.build_id
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.attrConfig=xianjieModel:getXianJieBuildingAttr(self.config.build_type)

local lv=self.bdData.level
local attrList=self.attrConfig:getAttrList()

local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
local hide=self.bdData.level==1 and nextLvCfg==nil
if not hide then
self.levelPanel:setActive(true)
self.levelPanel:setChildLayoutGroupCreateItems(#attrList,nil)
local childGrids=self.levelPanel:getChildLayoutGroupGridList()
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
local isSelect=lv==i-1
local attr=attrList[i]
local levelStr=i
if isSelect then
levelStr=FMT.fmt("<color=#efb150>{0}</color>",levelStr)
end
childItem:SetChildText(0,levelStr)
for i2=1,3 do
local childAttr=attr[i2]
if childAttr then
childItem:SetChildActive(i2,true)
local str=childAttr.val
if isSelect then
str=FMT.fmt("<color=#efb150>{0}</color>",str)
end
childItem:SetChildText(i2,str)
else
childItem:SetChildActive(i2,false)
end
end
end
else
self.levelPanel:setActive(false)
end
end


function UIXJTianShuDianBuildingDetailWin:onHide()

end

function UIXJTianShuDianBuildingDetailWin:onClickClose()
UIManager:invokeUIMethod("UIXJTianShuDianBuildingInfoWin",'onDetailWinClose')
self:closeSelf()
end


