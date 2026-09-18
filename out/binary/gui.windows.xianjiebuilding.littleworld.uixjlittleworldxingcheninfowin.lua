







def_class("UIXJLittleWorldXingChenInfoWin",UIWindowBase)








function UIXJLittleWorldXingChenInfoWin:bindComponents()

self.attrPanel=UIObject.get(self,0)
self.center=UIObject.get(self,1)
self.changeButton=UIButton.get(self,2)
self.changeButtonText=UIText.get(self,3)
self.ciZhuiPanel=UIObject.get(self,4)
self.colorFrame=UIImage.get(self,5)
self.icon=UIImage.get(self,6)
self.level=UIText.get(self,7)
self.maxLvBtn=UIButton.get(self,8)
self.maxLvReturnBtn=UIButton.get(self,9)
self.modelImage=UIImage.get(self,10)
self.name=UIText.get(self,11)
self.qianghuaButton=UIButton.get(self,12)
self.right=UIObject.get(self,13)
self.star=UIObject.get(self,14)
self.starAttrPanel=UIObject.get(self,15)
self.starPanel=UIObject.get(self,16)
self.starText=UIText.get(self,17)
self.takeOffButton=UIButton.get(self,18)
self.zhenxiEffect=UIObject.get(self,19)
self.zhenxiPanel=UIObject.get(self,20)

self.changeButton:setButtonClick(function()
self:onChangeButton()
end)

self.maxLvBtn:setButtonClick(function()
self:onMaxLvBtn()
end)

self.maxLvReturnBtn:setButtonClick(function()
self:onMaxLvReturnBtn()
end)

self.qianghuaButton:setButtonClick(function()
self:onQianghuaButton()
end)

self.takeOffButton:setButtonClick(function()
self:onTakeOffButton()
end)



end


function UIXJLittleWorldXingChenInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrPanel);
self.attrPanel=nil;
_UIObject_release(self.center);
self.center=nil;
_UIObject_release(self.changeButton);
self.changeButton=nil;
_UIObject_release(self.changeButtonText);
self.changeButtonText=nil;
_UIObject_release(self.ciZhuiPanel);
self.ciZhuiPanel=nil;
_UIObject_release(self.colorFrame);
self.colorFrame=nil;
_UIObject_release(self.icon);
self.icon=nil;
_UIObject_release(self.level);
self.level=nil;
_UIObject_release(self.maxLvBtn);
self.maxLvBtn=nil;
_UIObject_release(self.maxLvReturnBtn);
self.maxLvReturnBtn=nil;
_UIObject_release(self.modelImage);
self.modelImage=nil;
_UIObject_release(self.name);
self.name=nil;
_UIObject_release(self.qianghuaButton);
self.qianghuaButton=nil;
_UIObject_release(self.right);
self.right=nil;
_UIObject_release(self.star);
self.star=nil;
_UIObject_release(self.starAttrPanel);
self.starAttrPanel=nil;
_UIObject_release(self.starPanel);
self.starPanel=nil;
_UIObject_release(self.starText);
self.starText=nil;
_UIObject_release(self.takeOffButton);
self.takeOffButton=nil;
_UIObject_release(self.zhenxiEffect);
self.zhenxiEffect=nil;
_UIObject_release(self.zhenxiPanel);
self.zhenxiPanel=nil;
end



















function UIXJLittleWorldXingChenInfoWin:onLoaded(...)
self:bindComponents()
self.showFirst=nil



end


function UIXJLittleWorldXingChenInfoWin:__delete()
self.showFirst=nil
self:unbindComponents()

end




function UIXJLittleWorldXingChenInfoWin:onShow(argtable,afterOnloaded)
local equip=argtable.equip

self.equip=equip

self.itemId=equip.itemid
self.itemguid=equip.itemguid
self.itemConfig=itemsConfig.getConfig(self.itemId)
self.pos=self.itemConfig.type1

local upConfig=cfgHelper.get(cfg_starslvconfig_get,self.pos)
self.qianghuaButton:setActive(upConfig and upConfig[xingChenBagModel:getOrbitLevel(self.pos)+1]~=nil)



self.zhenxiEffect:setChildShowEffect(10661,(equip.itemData.fin_rare_id or 0)~=0)

self:refresh()


self.right:setChildCanvasGroupAlpha(0)
local tween=self.right:setChildCanvasGroupDOFade(1,0.2,nil)

self.right:setChildAnchoredPos(512,338.3)
self.right:setChildDOAnchorPosX(0,0.2)
self.showFirst=true




end


function UIXJLittleWorldXingChenInfoWin:onHide()

end

function UIXJLittleWorldXingChenInfoWin:clearFirst()
self.showFirst=nil
end

function UIXJLittleWorldXingChenInfoWin:refresh()
self:setShowItems()
self:refreshAttrs()
self:refreshAffixPanel()
self:refreshStarPanel()
self.isShowMax=false
local posData=xingChenBagModel:getPosData()
self.changeButtonText:setText(posData[self.pos]~=nil and"更换"or"定轨")

local starslvconfig=cfg_starslvconfig()
local max=#starslvconfig[self.pos]
local max2=#cfg_starsstarconfig()

local color=self.itemConfig.color
if color==eQualityColor.eRed and(xingChenBagModel:getOrbitLevel(self.pos)<max or xingChenHelper.getStarLevel(self.equip)<max2)then
self.maxLvBtn:setActive(not self.isShowMax)
self.maxLvReturnBtn:setActive(self.isShowMax)
else
self.maxLvBtn:setActive(false)
self.maxLvReturnBtn:setActive(false)
end
end

function UIXJLittleWorldXingChenInfoWin:setShowItems(orbitlevel)
local itemConfig=self.itemConfig
orbitlevel=orbitlevel or xingChenBagModel:getOrbitLevel(self.pos)
self.icon:setImageIcon(iconHelper.getIconName(self.itemId))
self.level:setText(FMT.fmt("星轨等级：{0}",orbitlevel))
self.name:setText(xingChenHelper.getXingChenName(self.equip))

local colorFrame=FMT.fmt("image_xiaoshijiebz_{0}",itemConfig.color-2)
self.colorFrame:setCSImageSprite("ui/windows/xianjiebuilding/littleworld/littleworld_atlas_pak.ab",colorFrame)

self.isEquiped=xingChenBagModel:getEquip(self.itemguid)
self.changeButton:setActive(self.isEquiped==nil)
self.takeOffButton:setActive(self.isEquiped~=nil)
self.qianghuaButton:setActive(self.isEquiped~=nil)
end

function UIXJLittleWorldXingChenInfoWin:refreshAttrs(orbitlevel)
orbitlevel=orbitlevel or xingChenBagModel:getOrbitLevel(self.pos)

local fixAttrs=xingChenHelper.getFixedAttr(self.itemId,orbitlevel)
self.attrPanel:setChildLayoutGroupCreateItems(#fixAttrs)
local grids=self.attrPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local attr=fixAttrs[i]
local name,str=equipsHelper.getAttr(attr[1],attr[2])
grid:SetChildText(1,FMT.fmt("{0}：{1}",name,str))
end
end

function UIXJLittleWorldXingChenInfoWin:refreshAffixPanel(starLevel)
local equip=self.equip
local affixList=xingChenHelper.getAffixList(equip)
local affix_num=xingChenHelper.getAffixLimit(equip,starLevel)
local color=self.itemConfig.color
local max=affix_num
if color==eQualityColor.eRed then
max=xingChenHelper.getMaxAffixLimit()
end
self.ciZhuiPanel:setChildLayoutGroupCreateItems(max)
local grids=self.ciZhuiPanel:getChildLayoutGroupGridList()
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
self:showWindow("UILittleWorldAffixWin",{item=grid,node='bottom',config=config})
end)
grid:SetChildActive(4,true)
else
if i<=affix_num then
grid:SetChildActive(6,true)
grid:SetChildActive(4,false)
else
grid:SetChildActive(6,false)
grid:SetChildActive(4,true)
local need=xingChenHelper:getNewAffixLv(i)or 0
grid:SetChildText(1,cfgHelper.get(cfg_starsstarconfig_get,need,"show_star"))
grid:SetChildCSImageSprite(0,"ui/windows/xianjiebuilding/littleworld/littleworld_atlas_pak.ab","frame_tytezhikuang_9")
grid:SetChildButtonClick(0,nil)
end
end


end

local fin_rare_id=equip.itemData.fin_rare_id
if starLevel then
local star_attrs=self.itemConfig.star_attrs
fin_rare_id=star_attrs[starLevel][1]
end

if fin_rare_id~=0 then
self.zhenxiPanel:setActive(true)

local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,fin_rare_id)
local effects_adddesc=zxConfig.effects_adddesc

local isJzAttr=zxConfig.jz_effects~=nil
local star_attrs=self.itemConfig.star_attrs
local lv=starLevel or xingChenHelper.getStarLevel(equip)
local nextStar=star_attrs[lv+1]
local attrList,nextList
local maxLv=#star_attrs
local max_id=star_attrs[maxLv][1]
local isMax=max_id==fin_rare_id
if nextStar and nextStar[1]>0 and nextStar[1]~=fin_rare_id then
local nextConfig=cfgHelper.get(cfg_starsrareconfig_get,nextStar[1])
if nextConfig.prio>zxConfig.prio then
if isJzAttr then
attrList=zxConfig.jz_effects
nextList=nextConfig.jz_effects
else
attrList=zxConfig.grow_effects
nextList=nextConfig.grow_effects
end
end
end
self.zhenxiPanel:setChildLayoutGroupCreateItems(#effects_adddesc)
local grids=self.zhenxiPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
if nextList then
if isJzAttr then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
else
if i==1 then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
end
end
else
if isMax then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}<color=#549327>（已满级）</color></color>",effects_adddesc[i]))
else
grid:SetChildText(1,FMT.fmt("<color=#ca631d>{0}</color>",effects_adddesc[i]))
end
end
end
else
local color=self.itemConfig.color
self.zhenxiPanel:setActive(color==eQualityColor.eRed)
if color==eQualityColor.eRed then
local nextLv=self.itemConfig.first_star_attrs_lv[2]
local id=xingChenHelper.getStarZhenXiId(equip.itemid,nextLv)
local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,id,"effects_adddesc")
self.zhenxiPanel:setChildLayoutGroupCreateItems(#zxConfig)
local grids=self.zhenxiPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
grid:SetChildText(1,FMT.fmt("<color=#8e8c87>{0}（{1}激活）</color>",zxConfig[i],cfgHelper.get(cfg_starsstarconfig_get,nextLv,"show_star")))
end
end
end
end

function UIXJLittleWorldXingChenInfoWin:refreshStarPanel(starLevel)
local equip=self.equip
local itemid=self.equip.itemid
local config=self.itemConfig
local color=config.color
if color==eQualityColor.eRed then
local lv=starLevel or xingChenHelper.getStarLevel(equip)
self.starPanel:setActive(true)
self.starAttrPanel:setActive(true)
xingChenHelper.setStarFlag(self.star:getChildWidgetBase(),lv)
if lv>0 then
self.starText:setText(cfgHelper.get(cfg_starsstarconfig_get,lv,"show_star"))
else
self.starText:setText("一阶零星")
end
local attrList=xingChenHelper.getStarAttr(itemid,lv)
if next(attrList)then
local attrLength=#attrList
local nextAttrList=xingChenHelper.getStarAttr(itemid,lv+1)or defaultT
local growAttrList=xingChenHelper.getStarGrowAttr(itemid,lv)
local growNextAttrList=xingChenHelper.getStarGrowAttr(itemid,lv+1)or defaultT
self.starAttrPanel:setChildLayoutGroupCreateItems(attrLength+#growAttrList)
local grids=self.starAttrPanel:getChildLayoutGroupGridList()

for i=1,grids.Count do
local grid=grids[i-1]
local attr=attrList[i]
local nextAttr=nextAttrList[i]
if attr then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
if nextAttr then
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}</color>",name,str))
else
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}<color=#549327>（已满级）</color></color>",name,str))
end
else
local gAttr=growAttrList[i-attrLength]
if gAttr then
local name,str=xingChenCiZhuiEffectController.getAttr(gAttr[1],gAttr[2])
if growNextAttrList[i-attrLength]then
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}</color>",name,str))
else
grid:SetChildText(1,FMT.fmt("<color=#d03497>{0}+{1}<color=#549327>（已满级）</color></color>",name,str))
end
end
end
end
else
local nextLv=config.first_star_attrs_lv[1]
local nextAttr=xingChenHelper.getStarAttr(itemid,nextLv)
local growAttrList=xingChenHelper.getStarGrowAttr(itemid,nextLv)

local attrLength=#nextAttr
self.starAttrPanel:setChildLayoutGroupCreateItems(attrLength+#growAttrList)
local grids=self.starAttrPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local grid=grids[i-1]
local attr=nextAttr[i]
if attr then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
grid:SetChildText(1,FMT.fmt("<color={2}>{0}+{1}（升星激活）</color>",name,str,FONT_TIPS_COLOR_VAL[FONT_COLOR.eGrayColor]))
else
local gAttr=growAttrList[i-attrLength]
if gAttr then
local name,str=xingChenCiZhuiEffectController.getAttr(gAttr[1],gAttr[2])
grid:SetChildText(1,FMT.fmt("<color={2}>{0}+{1}（升星激活）</color>",name,str,FONT_TIPS_COLOR_VAL[FONT_COLOR.eGrayColor]))
end
end
end
end
else
self.starPanel:setActive(false)
self.starAttrPanel:setActive(false)
end
end





function UIXJLittleWorldXingChenInfoWin:onChangeButton()
xingChenBagProtocolControl.req_37_90(self.pos,self.itemguid)
end



function UIXJLittleWorldXingChenInfoWin:onQianghuaButton()
UIFullLittleWorldControl:showXingChenIncreaseWindow({equip=self.equip})
end

function UIXJLittleWorldXingChenInfoWin:onTakeOffButton()
xingChenBagProtocolControl.req_37_91(self.pos)
end

function UIXJLittleWorldXingChenInfoWin:onMaxLvBtn()
local starslvconfig=cfg_starslvconfig()
local max=#starslvconfig[self.pos]
local max2=#cfg_starsstarconfig()
self:setShowItems(max)
self:refreshAttrs(max)
self:refreshAffixPanel(max2)
self:refreshStarPanel(max2)
self.isShowMax=true
self.maxLvBtn:setActive(not self.isShowMax)
self.maxLvReturnBtn:setActive(self.isShowMax)
end

function UIXJLittleWorldXingChenInfoWin:onMaxLvReturnBtn()
self:setShowItems()
self:refreshAttrs()
self:refreshAffixPanel()
self:refreshStarPanel()
self.isShowMax=nil
self.maxLvBtn:setActive(not self.isShowMax)
self.maxLvReturnBtn:setActive(self.isShowMax)
end