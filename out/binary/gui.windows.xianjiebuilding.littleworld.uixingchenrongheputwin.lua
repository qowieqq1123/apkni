







def_class("UIXingChenRongHePutWin",UIWindowBase)









function UIXingChenRongHePutWin:bindComponents()

self.center=UIObject.get(self,0)
self.changeBtn=UIButton.get(self,1)
self.ciZhuiPanel=UIObject.get(self,2)
self.closeBg=UIButton.get(self,3)
self.colorFrame=UIImage.get(self,4)
self.icon=UIImage.get(self,5)
self.level=UIText.get(self,6)
self.name=UIText.get(self,7)
self.putInBtn=UIButton.get(self,8)
self.putOutBtn=UIButton.get(self,9)
self.star=UIObject.get(self,10)
self.starAttrPanel=UIObject.get(self,11)
self.starPanel=UIObject.get(self,12)
self.starText=UIText.get(self,13)
self.zhenxiPanel=UIObject.get(self,14)

self.changeBtn:setButtonClick(function()
self:onChangeBtn()
end)

self.closeBg:setButtonClick(function()
self:onCloseBg()
end)

self.putInBtn:setButtonClick(function()
self:onPutInBtn()
end)

self.putOutBtn:setButtonClick(function()
self:onPutOutBtn()
end)



end


function UIXingChenRongHePutWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.center);
self.center=nil;
_UIObject_release(self.changeBtn);
self.changeBtn=nil;
_UIObject_release(self.ciZhuiPanel);
self.ciZhuiPanel=nil;
_UIObject_release(self.closeBg);
self.closeBg=nil;
_UIObject_release(self.colorFrame);
self.colorFrame=nil;
_UIObject_release(self.icon);
self.icon=nil;
_UIObject_release(self.level);
self.level=nil;
_UIObject_release(self.name);
self.name=nil;
_UIObject_release(self.putInBtn);
self.putInBtn=nil;
_UIObject_release(self.putOutBtn);
self.putOutBtn=nil;
_UIObject_release(self.star);
self.star=nil;
_UIObject_release(self.starAttrPanel);
self.starAttrPanel=nil;
_UIObject_release(self.starPanel);
self.starPanel=nil;
_UIObject_release(self.starText);
self.starText=nil;
_UIObject_release(self.zhenxiPanel);
self.zhenxiPanel=nil;
end



















function UIXingChenRongHePutWin:onLoaded(...)
self:bindComponents()
end


function UIXingChenRongHePutWin:__delete()
self:unbindComponents()
end




function UIXingChenRongHePutWin:onShow(argtable,afterOnloaded)
local equip=argtable.equip
self.equip=equip
self.itemId=equip.itemid
self.itemguid=equip.itemguid
self.itemguidStr=tostring(equip.itemguid)
self.itemConfig=itemsConfig.getConfig(self.itemId)
self.pos=self.itemConfig.type1
self.isLeft=argtable.isLeft
self.selectMainItem=argtable.selectMainItem
self.selectChildItem=argtable.selectChildItem
self.callback=argtable.callback

self:setShowItems()

local btnType=1
if self.isLeft then
if self.selectMainItem then
if self.itemguidStr==tostring(self.selectMainItem.itemguid)then
btnType=2
else
btnType=3
end
end
else
if self.selectChildItem then
if self.itemguidStr==tostring(self.selectChildItem.itemguid)then
btnType=2
else
btnType=3
end
end
end

self.putInBtn:setActive(btnType==1)
self.putOutBtn:setActive(btnType==2)
self.changeBtn:setActive(btnType==3)
end


function UIXingChenRongHePutWin:onHide()

end

function UIXingChenRongHePutWin:setShowItems()
local itemConfig=self.itemConfig
self.icon:setImageIcon(iconHelper.getIconName(self.itemId))
self.level:setText(FMT.fmt("星轨等级：{0}",xingChenBagModel:getOrbitLevel(self.pos)))
self.name:setText(xingChenHelper.getXingChenName(self.equip))

local colorFrame=FMT.fmt("image_xiaoshijiebz_{0}",itemConfig.color-2)
self.colorFrame:setCSImageSprite("ui/windows/xianjiebuilding/littleworld/littleworld_atlas_pak.ab",colorFrame)

self:refreshStarPanel()
end

function UIXingChenRongHePutWin:refreshStarPanel()
local equip=self.equip
local itemid=self.equip.itemid
local config=self.itemConfig
local lv=xingChenHelper.getStarLevel(equip)

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
self:showWindow("UILittleWorldAffixWin",{item=grid,node='bottom',config=config})
end)
end
grid:SetChildActive(4,affix~=nil)
grid:SetChildActive(6,affix==nil)
end
end

if equip.itemData.fin_rare_id~=0 then
local zxConfig=cfgHelper.get(cfg_starsrareconfig_get,equip.itemData.fin_rare_id)
local effects_adddesc=zxConfig.effects_adddesc
local isJzAttr=zxConfig.jz_effects~=nil
local star_attrs=self.itemConfig.star_attrs
local lv=xingChenHelper.getStarLevel(equip)
local nextStar=star_attrs[lv+1]
local attrList,nextList
local maxLv=#star_attrs
local max_id=star_attrs[maxLv][1]
local isMax=max_id==equip.itemData.fin_rare_id
if nextStar and nextStar[1]>0 and nextStar[1]~=equip.itemData.fin_rare_id then
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

function UIXingChenRongHePutWin:checkSameCiZhui(selectMainItem,selectChildItem)
if not selectMainItem then
return
end
if not selectChildItem then
return
end
local affixList=xingChenHelper.getAffixList(selectMainItem)
local childAffixList=xingChenHelper.getAffixList(selectChildItem)

for i,v in ipairs(childAffixList)do
if not table.containsValue(affixList,v)then
return false
end
end
return true
end




function UIXingChenRongHePutWin:onCloseBg()
self:closeSelf()
end



function UIXingChenRongHePutWin:onPutInBtn()
local itemguidStr=self.itemguidStr
local isChange=false
local item=self.equip
local isEquiped=xingChenBagModel:getEquip(item.itemguid)
if self.isLeft then

if self.selectChildItem and itemguidStr==tostring(self.selectChildItem.itemguid)then
if self.selectMainItem then
if isEquiped then
UIManager.error("装备中的星辰无法作为副星辰")
return
end
self.selectChildItem=self.selectMainItem
isChange=true
else
self.selectChildItem=nil
end
UIManager.info("更换成功")
else
if self.selectMainItem then
UIManager.info("更换成功")
else
UIManager.info("放入成功")
end

end
self.selectMainItem=item
else
if isEquiped then
UIManager.error("装备中的星辰无法作为副星辰")
return
end
if self.selectMainItem and itemguidStr==tostring(self.selectMainItem.itemguid)then
if isEquiped then
UIManager.error("装备中的星辰无法作为副星辰")
return
end
if self.selectChildItem then
self.selectMainItem=self.selectChildItem
isChange=true
else
self.selectMainItem=nil
end
UIManager.info("更换成功")
else
if self.selectChildItem then
UIManager.info("更换成功")
else
UIManager.info("放入成功")
end
end
self.selectChildItem=item
end
if self.callback then
self.callback(self.selectMainItem,self.selectChildItem)
end
UIManager:closeWindow("UIXingChenRongHeSelect2Win")
self:closeSelf()

end



function UIXingChenRongHePutWin:onPutOutBtn()
if self.isLeft then
self.callback(nil,self.selectChildItem)
else
self.callback(self.selectMainItem,nil)
end
UIManager.info("取出成功")
UIManager:closeWindow("UIXingChenRongHeSelect2Win")
self:closeSelf()

end

function UIXingChenRongHePutWin:onChangeBtn()
self:onPutInBtn()
end