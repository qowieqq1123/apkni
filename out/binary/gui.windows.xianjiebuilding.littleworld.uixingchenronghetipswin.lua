







def_class("UIXingChenRongHeTipsWin",UIWindowBase)









function UIXingChenRongHeTipsWin:bindComponents()

self.attrPanel=UIObject.get(self,0)
self.ciZhuiPanel=UIObject.get(self,1)
self.frame=UIObject.get(self,2)
self.level=UIText.get(self,3)
self.name=UIText.get(self,4)
self.node=UIObject.get(self,5)
self.root=UIButton.get(self,6)
self.zhenxiPanel=UIObject.get(self,7)

self.root:setButtonClick(function()self:onRoot()end)



end


function UIXingChenRongHeTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.ciZhuiPanel);self.ciZhuiPanel=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.node);self.node=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.zhenxiPanel);self.zhenxiPanel=nil;
end



















function UIXingChenRongHeTipsWin:onLoaded(...)
self:bindComponents()
end


function UIXingChenRongHeTipsWin:__delete()
self:unbindComponents()
self.equip=nil
end




function UIXingChenRongHeTipsWin:onShow(argtable,afterOnloaded)
self.frame:setChildCanvasGroupAlpha(0)
self.frame:setChildCanvasGroupDOFade(1,0.2)

local posWidget=argtable.posWidget
local equip=argtable.equip
self.equip=equip
self.itemId=equip.itemid
self.pos=itemsConfig.getConfig(equip.itemid).type1

if posWidget then
local posWidgetIndex=argtable.posWidgetIndex or-1
local pos=argtable.posWidget:GetChildScreenPointToLocalPointRectangle(posWidgetIndex)
self.frame:setChildAnchoredPos(pos.x+90,13)
else
if argtable.pos then
self.frame:setChildAnchoredPos(argtable.pos.x+90,-9.8)
end
end

self:refreshAttrs()
self:refreshAffixPanel()
self:refreshZhenXiPanel()
end


function UIXingChenRongHeTipsWin:onHide()

end

function UIXingChenRongHeTipsWin:onRoot()
self:closeSelf()
end

function UIXingChenRongHeTipsWin:refreshAttrs()
local curlv=xingChenBagModel:getOrbitLevel(self.pos)

self.level:setText(FMT.fmt("轨道等级：{0}",curlv))
self.name:setText(xingChenHelper.getXingChenName(self.equip))
local fixAttrs=xingChenHelper.getFixedAttr(self.itemId,curlv)
self.attrPanel:setChildLayoutGroupCreateItems(#fixAttrs)

local grids=self.attrPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local attr=fixAttrs[i]
local name,str=equipsHelper.getAttr(attr[1],attr[2])
grid:SetChildText(1,FMT.fmt("{0}：{1}",name,str))
end
end

function UIXingChenRongHeTipsWin:refreshAffixPanel()
local equip=self.equip
local affixList=xingChenHelper.getAffixList(equip)
local affix_num=xingChenHelper.getAffixLimit(equip)
self.ciZhuiPanel:setChildLayoutGroupCreateItems(affix_num)
local grids=self.ciZhuiPanel:getChildLayoutGroupGridList()
if#affixList>0 then
for i=1,grids.Count do
local grid=grids[i-1]
local affix=affixList[i]
if affix then
local config=cfgHelper.get(cfg_starsaffixconfig_get,affix)
local ab,frame=xingChenHelper.getAffixColorFrame(config.color)
local name=xingChenHelper.getAffixNameStr(config.name)
grid:SetChildText(1,name)
grid:SetChildCSImageSprite(0,ab,frame)
grid:SetChildButtonClick(0,function()
self:showWindow("UILittleWorldAffixWin",{item=self.node:getChildWidgetBase(),node='bottom',config=config})
end)
end
grid:SetChildActive(4,affix~=nil)
grid:SetChildActive(5,affix==nil)
end
end
end

function UIXingChenRongHeTipsWin:refreshZhenXiPanel()
local equip=self.equip
if equip.itemData.fin_rare_id~=0 then
self.zhenxiPanel:setActive(true)

local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,equip.itemData.fin_rare_id,"effects_adddesc")
self.zhenxiPanel:setChildLayoutGroupCreateItems(#zxConfig)
local grids=self.zhenxiPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
grid:SetChildText(1,zxConfig[i])
end
else
self.zhenxiPanel:setActive(false)
end
end


