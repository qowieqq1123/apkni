







def_class("UIXJBuildingDetailWin",UIWindowBase)









function UIXJBuildingDetailWin:bindComponents()

self.attrPanel=UIObject.get(self,0)
self.detailPanel=UIObject.get(self,1)
self.levelPanel=UIObject.get(self,2)



end


function UIXJBuildingDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.detailPanel);self.detailPanel=nil;
_UIObject_release(self.levelPanel);self.levelPanel=nil;
end



















function UIXJBuildingDetailWin:onLoaded(...)
self:bindComponents()
end


function UIXJBuildingDetailWin:__delete()
self:unbindComponents()
end




function UIXJBuildingDetailWin:onShow(argtable,afterOnloaded)
self.bdData=argtable.bdData
self.build_id=self.bdData.build_id
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self.attrConfig=xianjieModel:getXianJieBuildingAttr(self.config.build_type)

local lv=self.bdData.level

local totalAttrList
if self.attrConfig.getTotalAttrList then
totalAttrList=self.attrConfig:getTotalAttrList()
end
local attrList=self.attrConfig:getAttrList()
local detailList={}

local curAttr=totalAttrList and totalAttrList or attrList[lv]

self.attrPanel:setChildLayoutGroupCreateItems(#curAttr,nil)
local childGrids=self.attrPanel:getChildLayoutGroupGridList()
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
local attr=curAttr[i]
local attrVal=attr.val
if attr.addVal and attr.addVal>0 then
attrVal=attrVal+attr.addVal
end
childItem:SetChildText(0,attr.name)
childItem:SetChildText(1,xianjieModel:getBuildingAttrVal(attrVal,attr.flag))
end

self.detailPanel:setActive(#detailList>0)
if#detailList then
self.detailPanel:setChildLayoutGroupCreateItems(#detailList,nil)
local childGrids=self.detailPanel:getChildLayoutGroupGridList()
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
local attr=detailList[i]
childItem:SetChildText(0,attr.name)
childItem:SetChildText(1,xianjieModel:getBuildingAttrVal(attr.val,attr.flag))
end
end
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
local hide=self.bdData.level==1 and nextLvCfg==nil
if not hide then
self.levelPanel:setActive(true)
self.levelPanel:setChildLayoutGroupCreateItems(#attrList+1,nil)
local childGrids=self.levelPanel:getChildLayoutGroupGridList()
for i=1,childGrids.Count do
local childItem=childGrids[i-1]
if i==1 then
local attr=attrList[i]
childItem:SetChildText(0,"<color=#cacaca>等级</color>")
for i2=1,3 do
local childAttr=attr[i2]
if childAttr then
childItem:SetChildActive(i2,true)
childItem:SetChildText(i2,string.format("<color=#cacaca>%s</color>",childAttr.name))
else
childItem:SetChildActive(i2,false)
end
end
else
local isSelect=lv==i-1
local attr=attrList[i-1]
local levelStr=i-1
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
end
else
self.levelPanel:setActive(false)
end
end


function UIXJBuildingDetailWin:onHide()

end

function UIXJBuildingDetailWin:onClickClose()
UIManager:invokeUIMethod("UIXJBuildingInfoWin",'onDetailWinClose')
self:closeSelf()
end


