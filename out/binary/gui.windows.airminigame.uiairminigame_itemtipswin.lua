







def_class("UIAirMiniGame_itemTipsWin",UIWindowBase)









function UIAirMiniGame_itemTipsWin:bindComponents()

self.mask=UIButton.get(self,0)
self.item=UIObject.get(self,1)
self.itemName=UIText.get(self,2)
self.itemTag=UIText.get(self,3)
self.attrLayout=UIObject.get(self,4)
self.itemDesc=UILinkImageText.get(self,5)
self.btnPanel=UIObject.get(self,6)
self.sellBtn=UIButton.get(self,7)
self.hechengBtn=UIButton.get(self,8)
self.sellPriceText=UIText.get(self,9)
self.sellPriceIcon=UIImage.get(self,10)
self.typeBuffPanel=UIObject.get(self,11)
self.suitPanel=UIObject.get(self,12)
self.lastDmgPanel=UIObject.get(self,13)
self.typeTitle=UIText.get(self,14)
self.suitTitle=UIText.get(self,15)
self.lastDmgText=UIText.get(self,16)
self.extraLayout=UIObject.get(self,17)
self.sellBtnText=UIText.get(self,18)
self.hechengReddot=UIObject.get(self,19)

self.mask:setButtonClick(function()self:onMask()end)

self.sellBtn:setButtonClick(function()self:onSellBtn()end)

self.hechengBtn:setButtonClick(function()self:onHechengBtn()end)



end


function UIAirMiniGame_itemTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.itemName);self.itemName=nil;
_UIObject_release(self.itemTag);self.itemTag=nil;
_UIObject_release(self.attrLayout);self.attrLayout=nil;
_UIObject_release(self.itemDesc);self.itemDesc=nil;
_UIObject_release(self.btnPanel);self.btnPanel=nil;
_UIObject_release(self.sellBtn);self.sellBtn=nil;
_UIObject_release(self.hechengBtn);self.hechengBtn=nil;
_UIObject_release(self.sellPriceText);self.sellPriceText=nil;
_UIObject_release(self.sellPriceIcon);self.sellPriceIcon=nil;
_UIObject_release(self.typeBuffPanel);self.typeBuffPanel=nil;
_UIObject_release(self.suitPanel);self.suitPanel=nil;
_UIObject_release(self.lastDmgPanel);self.lastDmgPanel=nil;
_UIObject_release(self.typeTitle);self.typeTitle=nil;
_UIObject_release(self.suitTitle);self.suitTitle=nil;
_UIObject_release(self.lastDmgText);self.lastDmgText=nil;
_UIObject_release(self.extraLayout);self.extraLayout=nil;
_UIObject_release(self.sellBtnText);self.sellBtnText=nil;
_UIObject_release(self.hechengReddot);self.hechengReddot=nil;
end
















local nameColorList={
[FONT_COLOR.eWhiteColor]='#efeded',
[FONT_COLOR.eGreenColor]='#549327',
[FONT_COLOR.eBlueColor]='#3375c0',
[FONT_COLOR.ePurpleColor]='#6833c0',
[FONT_COLOR.eOrangeColor]='#FFC04A',
[FONT_COLOR.eRedColor]='#FF5A51',
[FONT_COLOR.ePinkColor]='#d03497',
}

local oppositeAttrList={
[aiAttributeType.ePriceReduct]=true,
[aiAttributeType.eRecvDamage]=true,
}




function UIAirMiniGame_itemTipsWin:onLoaded(...)
self:bindComponents()
end


function UIAirMiniGame_itemTipsWin:__delete()
self:unbindComponents()
end




function UIAirMiniGame_itemTipsWin:onShow(argtable,afterOnloaded)
self.itemId=argtable and argtable.itemId
self.itemType=argtable and argtable.itemType
self.fromType=argtable and argtable.fromType
self.equipIndex=argtable and argtable.equipIndex
self.inOutOpen=argtable and argtable.inOutOpen

self:refresh()
end


function UIAirMiniGame_itemTipsWin:onHide()

end

function UIAirMiniGame_itemTipsWin:refresh()

self:refreshTopPanel()


self:refreshMiddlePanel()


self:refreshBtnPanel()


self:refreshExtraPanel()
end

function UIAirMiniGame_itemTipsWin:refreshTopPanel()
local itemTagStr=""
local itemCfg
local iconName
if self.itemType==1 then
itemCfg=cfgHelper.get(cfg_airweaponconfig_get,self.itemId)












local equipSkillId=itemCfg.skillid
if equipSkillId then
local skillCfg=cfgHelper.get(cfg_airskillconfig_get,equipSkillId)
if skillCfg then
local attackType=skillCfg.hurtType
if attackType==1 then
itemTagStr="物理伤害"
elseif attackType==2 then
itemTagStr="法术伤害"
end
end
end
elseif self.itemType==2 then
itemCfg=cfgHelper.get(cfg_airitemconfig_get,self.itemId)
itemTagStr="宝物"
end
iconName=FMT.fmt("icon_item_{0}",itemCfg.icon)
local itemName=itemCfg.name
local itemColor=itemCfg.color
local colorVal=nameColorList[itemColor]

self.itemName:setText(toColorStringX(colorVal,itemName))

self.itemTag:setText(itemTagStr)


local itemWidget=self.item:getWidgetBase()
local prop={}
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetText,3)]=''
prop[PropIndex(DataPropKey.eWidgetText,4)]=''
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
end

function UIAirMiniGame_itemTipsWin:refreshMiddlePanel()
local itemCfg
local descStr
local isShowAdd=self.fromType~=1
local ent=airActorSystem:getActor()
if self.itemType==1 then
itemCfg=cfgHelper.get(cfg_airweaponconfig_get,self.itemId)
descStr=itemCfg.tipsDesc
local descParams=itemCfg.descParams
local valStrList={}
if descStr and descParams then
for i,v in ipairs(descParams)do
local valParams=v
local originalVal=valParams[1]
local val=originalVal
local relevantAttrId=valParams[2]
local relevantAttrStr=""
local valStr=tostring(val)
if isShowAdd and relevantAttrId then
local attrValue=ent:getAttrValue(relevantAttrId)
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,relevantAttrId)
local iconName=attrCfg.smallIconName
local iconStr=chatEmotHelper.getIconEmotMesg(iconName,30)
local attrValStr=airController:getAttrStr(relevantAttrId,attrValue,true)
relevantAttrStr=FMT.fmt("（{0}{1}）",attrValStr,iconStr)



valStr=FMT.fmt("{0}{1}",valStr,relevantAttrStr)
end
valStrList[#valStrList+1]=valStr
end
descStr=FMT.fmt(descStr,unpack(valStrList))
end
elseif self.itemType==2 then
itemCfg=cfgHelper.get(cfg_airitemconfig_get,self.itemId)
descStr=itemCfg.desc
if itemCfg.tipsDesc then

descStr=itemCfg.tipsDesc
end
end


local itemAttrList=airController:getItemSortAttrList(self.itemId,self.itemType)
self.attrLayout:setChildLayoutGroupCreateItems(#itemAttrList,function(i)
local attrWidget=self.attrLayout:getChildLayoutGroupGridItem(i-1)
local attr=itemAttrList[i]
local attrId=attr.attrId
local attrVal=attr.attrVal
local attrName
local attrStr=''
if attrId then
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
attrName=attrCfg.attrname
local attrValStr
if self.itemType==1 then
attrValStr=airController:getAttrStr(attrId,attrVal)
else
if not attr.isPercent then
attrValStr=airController:getAttrStr(attrId,attr.attrVal)
else

local percent=attrVal/100
percent=math.floor(percent)
attrValStr=FMT.fmt("{0}%",percent)
end
end
local finalAttrVal
if self.fromType~=1 and self.itemType==1 then
finalAttrVal=airActorSystem:getActorAttrValByAttrId(attrId)

if attrId==aiAttributeType.eAttack then

local equipSkillId=itemCfg.skillid
if equipSkillId then
local skillCfg=cfgHelper.get(cfg_airskillconfig_get,equipSkillId)
if skillCfg then
local addAtkVal=airSkillSystem:getDamageValue(skillCfg.hurtType,ent)

finalAttrVal=attrVal+addAtkVal
end
end
elseif attrId==aiAttributeType.eCirticalRate then

finalAttrVal=attrVal+finalAttrVal
end
end

if isShowAdd and finalAttrVal and attrVal~=finalAttrVal then
local finalAttrValStr=airController:getAttrStr(attrId,finalAttrVal)
local color=finalAttrVal>attrVal and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
if oppositeAttrList[attrId]then

color=finalAttrVal<attrVal and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
end
finalAttrValStr=self:getColorStr(color,finalAttrValStr)

attrStr=finalAttrValStr
else
if self.itemType==2 then
if attrVal>=0 then
attrValStr=FMT.fmt("   +{0}",attrValStr)
if oppositeAttrList[attrId]then

attrValStr=self:getColorStr(FONT_COLOR.eRedColor,attrValStr)
else

attrValStr=self:getColorStr(FONT_COLOR.eGreenColor,attrValStr)
end
else
attrValStr=FMT.fmt("   {0}",attrValStr)
if oppositeAttrList[attrId]then

attrValStr=self:getColorStr(FONT_COLOR.eGreenColor,attrValStr)
else

attrValStr=self:getColorStr(FONT_COLOR.eRedColor,attrValStr)
end
end
end
attrStr=attrValStr
end
elseif attr.attrName then
attrName=attr.attrName
attrVal=math.floor(attrVal)
local attrValStr=mathHelper.formatNumber(attrVal)
local relevantAttrId=attr.relevantAttrId
if relevantAttrId==aiAttributeType.eAttckSpeed then
attrVal=mathHelper.decimal(attr.attrVal,1)
attrValStr=FMT.fmt("{0}秒",attrVal)
end
local finalAttrVal=math.floor(attr.finalAttrVal)
if isShowAdd and finalAttrVal and finalAttrVal~=attrVal then
local color=finalAttrVal>attrVal and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
if oppositeAttrList[attrId]then

color=finalAttrVal<attrVal and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
end
local finalAttrValStr=mathHelper.formatNumber(finalAttrVal)
if relevantAttrId==aiAttributeType.eAttckSpeed then
finalAttrVal=mathHelper.decimal(attr.finalAttrVal,1)
finalAttrValStr=FMT.fmt("{0}秒",finalAttrVal)
end
finalAttrValStr=self:getColorStr(color,finalAttrValStr)

attrStr=finalAttrValStr
else
attrStr=attrValStr
end
end
if self.itemType==1 then
attrWidget:SetChildText(0,FMT.fmt("{0}：",attrName))
elseif self.itemType==2 then
attrWidget:SetChildText(0,FMT.fmt("{0}",attrName))
end
attrWidget:SetChildText(1,attrStr)
end)


if descStr then

if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
descStr=string.gsub(descStr," ","\194\160")
end
self.itemDesc:setActive(true)
self.itemDesc:setText(descStr)
else
self.itemDesc:setActive(false)
end
end

function UIAirMiniGame_itemTipsWin:refreshBtnPanel()
local isShowSellBtn=self.fromType==2 and self.itemType==1

local isShowHeChengBtn=false
if self.fromType==2 and self.itemType==1 then
isShowHeChengBtn=airController:isEquipCanHeCheng(self.itemId,self.equipIndex)
end
self.hechengBtn:setActive(isShowHeChengBtn)

local isShowBtnPanel=isShowSellBtn or isShowHeChengBtn
self.btnPanel:setActive(isShowBtnPanel)
if not isShowBtnPanel then
return
end

self.sellBtn:setActive(isShowSellBtn)
if isShowSellBtn then

local btnTextStr="回收"
if self.itemType==2 then
btnTextStr="分解"
end
self.sellBtnText:setText(btnTextStr)

local price=airController:getItemBuyOrSellPrice(self.itemId,self.itemType,2)
self.sellPriceText:setText(FMT.fmt("+{0}",price))
local moneyIconName=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyIcon")
self.sellPriceIcon:setImageIcon(moneyIconName,false)
end
end

function UIAirMiniGame_itemTipsWin:refreshExtraPanel()
if self.itemType~=1 then
self.extraLayout:setActive(false)
return
end

local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,self.itemId)
local itemTypeCfg=cfgHelper.get(cfg_airweapontypeconfig_get,itemCfg.type1)
local isShowTypeBuffPanel=itemTypeCfg and itemTypeCfg.typeEffectParams~=nil or false
local suitCfg=itemCfg.suit and cfgHelper.get(cfg_airsuitconfig_get,itemCfg.suit)or nil
local isShowSuitPanel=suitCfg and suitCfg.suitEffectParams~=nil or false
local isShowLastDmgPanel=self.fromType~=1
local isShowExtra=isShowTypeBuffPanel or isShowSuitPanel or isShowLastDmgPanel
self.extraLayout:setActive(isShowExtra)
if not isShowExtra then
return
end

local isShowActiveState=self.fromType~=1

self.typeBuffPanel:setActive(isShowTypeBuffPanel)
if isShowTypeBuffPanel then

local typeBuffSortList=self:getBuffSortList(itemTypeCfg.typeEffectParams)
local typeName=itemTypeCfg.name
self.typeTitle:setText(typeName)
local sameTypeCount=self.inOutOpen and 0 or airActorSystem:getActorSameTypeEquipCount(itemCfg.type1)
local grids=self.typeBuffPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local buff=typeBuffSortList[i]
if buff then
widget:SetChildActive(-1,true)
local num=buff.num
local attrId=buff.attrId
local attrVal=buff.attrVal
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local attrName=attrCfg.attrname
local attrStr=airController:getAttrStr(attrId,attrVal)
local attrSign=attrVal>=0 and'+'or''
local buffStr=FMT.fmt("（{0}）{1}{2}{3}",num,attrSign,attrStr,attrName)
if isShowActiveState and sameTypeCount>=num then

buffStr=FMT.cfmt1(FONT_COLOR.eGreenColor,buffStr)
end
widget:SetChildText(-1,buffStr)
else
widget:SetChildActive(-1,false)
end
end
end

self.suitPanel:setActive(isShowSuitPanel)
if isShowSuitPanel then

local suitBuffSortList=self:getBuffSortList(suitCfg.suitEffectParams)
local suitName=suitCfg.name
self.suitTitle:setText(suitName)
local sameSuitCount=self.inOutOpen and 0 or airActorSystem:getActorSameSuitEquipCount(itemCfg.suit)
local grids=self.suitPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local buff=suitBuffSortList[i]
if buff then
widget:SetChildActive(-1,true)
local num=buff.num
local attrId=buff.attrId
local attrVal=buff.attrVal
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local attrName=attrCfg.attrname
local attrStr=airController:getAttrStr(attrId,attrVal)
local attrSign=attrVal>=0 and'+'or''
local buffStr=FMT.fmt("（{0}）{1}{2}{3}",num,attrSign,attrStr,attrName)
if isShowActiveState and sameSuitCount>=num then

buffStr=FMT.cfmt1(FONT_COLOR.eGreenColor,buffStr)
end
widget:SetChildText(-1,buffStr)
else
widget:SetChildActive(-1,false)
end
end
end


if isShowLastDmgPanel then
local equipDmg=airModel:getStatisticData_getLastLevelWeaponDmg(self.equipIndex)or 0
if equipDmg and equipDmg>0 then
self.lastDmgPanel:setActive(true)
self.lastDmgText:setText(FMT.fmt("{0}伤害",equipDmg))
else
self.lastDmgPanel:setActive(false)
end
else
self.lastDmgPanel:setActive(false)
end
end

function UIAirMiniGame_itemTipsWin:getBuffSortList(list)
local sortList={}
for num,v in pairs(list)do
sortList[#sortList+1]={
num=num,
attrId=v[1],
attrVal=v[2],
}
end
table.sort(sortList,function(a,b)
return a.num<b.num
end)

return sortList
end

function UIAirMiniGame_itemTipsWin:getColorStr(colorType,str)
local colorStr
if colorType==FONT_COLOR.eRedColor then

colorStr=FMT.cfmt(colorType,str)
elseif colorType==FONT_COLOR.eGreenColor then

colorStr=FMT.fmt("<color=#63B22B>{0}</color>",str)
else

colorStr=FMT.cfmt1(colorType,str)
end

return colorStr
end




function UIAirMiniGame_itemTipsWin:onMask()
self:closeSelf()
end



function UIAirMiniGame_itemTipsWin:onSellBtn()
local equipItemList=airModel:getEquipList()or{}
local equipCount=#equipItemList
if equipCount<=1 then
UIManager.error("当前仅有一把武器，无法回收")
return
end


airController:sellEquipItem(self.itemId,self.equipIndex)


self:onMask()
end



function UIAirMiniGame_itemTipsWin:onHechengBtn()

local sameEquipIndex=airActorSystem:getActorSameEquipIndex(self.itemId,self.equipIndex)
if self.equipIndex and sameEquipIndex then
local equipIdx_a=self.equipIndex<sameEquipIndex and self.equipIndex or sameEquipIndex
local equipIdx_b=self.equipIndex>sameEquipIndex and self.equipIndex or sameEquipIndex
airController:heChengEquipItem(self.itemId,equipIdx_a,equipIdx_b)
end


self:onMask()
end