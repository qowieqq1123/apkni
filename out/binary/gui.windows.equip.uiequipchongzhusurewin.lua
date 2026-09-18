







def_class("UIEquipChongZhuSureWin",UIWindowBase)









function UIEquipChongZhuSureWin:bindComponents()

self.BtnSelectBefore=UIButton.get(self,0)
self.BtnSelectAfter=UIButton.get(self,1)
self.selectBeforeImg=UIObject.get(self,2)
self.lattrs2=UIObject.get(self,3)
self.lsuit2=UIObject.get(self,4)
self.selectAfterImg=UIObject.get(self,5)
self.rattrs2=UIObject.get(self,6)
self.rsuit2=UIObject.get(self,7)
self.rattrRoot1=UIObject.get(self,8)
self.rattrRoot2=UIObject.get(self,9)
self.rattrRoot3=UIObject.get(self,10)
self.rattrRoot4=UIObject.get(self,11)
self.newAttrRed=UIText.get(self,12)
self.selectAfterAttrImg=UIObject.get(self,13)
self.lattrRoot1=UIObject.get(self,14)
self.lattrRoot4=UIObject.get(self,15)
self.lattrRoot3=UIObject.get(self,16)
self.lattrRoot2=UIObject.get(self,17)
self.selectBeforeAttrImg=UIObject.get(self,18)
self.newSuitRed=UIText.get(self,19)
self.rSuitRoot=UIObject.get(self,20)
self.lSuitRoot=UIObject.get(self,21)
self.selectBeforeSuitImg=UIObject.get(self,22)
self.selectAfterSuitImg=UIObject.get(self,23)
self.BtnSelectAfterSuit=UIButton.get(self,24)
self.lsuit=UIObject.get(self,25)
self.rsuit=UIObject.get(self,26)
self.BtnSelectBeforeSuit=UIButton.get(self,27)
self.btnSure=UIButton.get(self,28)
self.rattrs=UIObject.get(self,29)
self.BtnSelectBeforeAttr=UIButton.get(self,30)
self.lattrs=UIObject.get(self,31)
self.BtnSelectAfterAttr=UIButton.get(self,32)
self.lattrRoot24=UIObject.get(self,33)
self.lattrRoot23=UIObject.get(self,34)
self.lattrRoot22=UIObject.get(self,35)
self.lattrRoot21=UIObject.get(self,36)
self.newAttrRed2=UIText.get(self,37)
self.rattrRoot24=UIObject.get(self,38)
self.rattrRoot23=UIObject.get(self,39)
self.rattrRoot22=UIObject.get(self,40)
self.rattrRoot21=UIObject.get(self,41)
self.lSuitRoot2=UIObject.get(self,42)
self.newSuitRed2=UIText.get(self,43)
self.rSuitRoot2=UIObject.get(self,44)

self.BtnSelectBefore:setButtonClick(function()self:onBtnSelectBefore()end)

self.BtnSelectAfter:setButtonClick(function()self:onBtnSelectAfter()end)

self.BtnSelectAfterSuit:setButtonClick(function()self:onBtnSelectAfterSuit()end)

self.BtnSelectBeforeSuit:setButtonClick(function()self:onBtnSelectBeforeSuit()end)

self.btnSure:setButtonClick(function()self:onBtnSure()end)

self.BtnSelectBeforeAttr:setButtonClick(function()self:onBtnSelectBeforeAttr()end)

self.BtnSelectAfterAttr:setButtonClick(function()self:onBtnSelectAfterAttr()end)



end


function UIEquipChongZhuSureWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.BtnSelectBefore);self.BtnSelectBefore=nil;
_UIObject_release(self.BtnSelectAfter);self.BtnSelectAfter=nil;
_UIObject_release(self.selectBeforeImg);self.selectBeforeImg=nil;
_UIObject_release(self.lattrs2);self.lattrs2=nil;
_UIObject_release(self.lsuit2);self.lsuit2=nil;
_UIObject_release(self.selectAfterImg);self.selectAfterImg=nil;
_UIObject_release(self.rattrs2);self.rattrs2=nil;
_UIObject_release(self.rsuit2);self.rsuit2=nil;
_UIObject_release(self.rattrRoot1);self.rattrRoot1=nil;
_UIObject_release(self.rattrRoot2);self.rattrRoot2=nil;
_UIObject_release(self.rattrRoot3);self.rattrRoot3=nil;
_UIObject_release(self.rattrRoot4);self.rattrRoot4=nil;
_UIObject_release(self.newAttrRed);self.newAttrRed=nil;
_UIObject_release(self.selectAfterAttrImg);self.selectAfterAttrImg=nil;
_UIObject_release(self.lattrRoot1);self.lattrRoot1=nil;
_UIObject_release(self.lattrRoot4);self.lattrRoot4=nil;
_UIObject_release(self.lattrRoot3);self.lattrRoot3=nil;
_UIObject_release(self.lattrRoot2);self.lattrRoot2=nil;
_UIObject_release(self.selectBeforeAttrImg);self.selectBeforeAttrImg=nil;
_UIObject_release(self.newSuitRed);self.newSuitRed=nil;
_UIObject_release(self.rSuitRoot);self.rSuitRoot=nil;
_UIObject_release(self.lSuitRoot);self.lSuitRoot=nil;
_UIObject_release(self.selectBeforeSuitImg);self.selectBeforeSuitImg=nil;
_UIObject_release(self.selectAfterSuitImg);self.selectAfterSuitImg=nil;
_UIObject_release(self.BtnSelectAfterSuit);self.BtnSelectAfterSuit=nil;
_UIObject_release(self.lsuit);self.lsuit=nil;
_UIObject_release(self.rsuit);self.rsuit=nil;
_UIObject_release(self.BtnSelectBeforeSuit);self.BtnSelectBeforeSuit=nil;
_UIObject_release(self.btnSure);self.btnSure=nil;
_UIObject_release(self.rattrs);self.rattrs=nil;
_UIObject_release(self.BtnSelectBeforeAttr);self.BtnSelectBeforeAttr=nil;
_UIObject_release(self.lattrs);self.lattrs=nil;
_UIObject_release(self.BtnSelectAfterAttr);self.BtnSelectAfterAttr=nil;
_UIObject_release(self.lattrRoot24);self.lattrRoot24=nil;
_UIObject_release(self.lattrRoot23);self.lattrRoot23=nil;
_UIObject_release(self.lattrRoot22);self.lattrRoot22=nil;
_UIObject_release(self.lattrRoot21);self.lattrRoot21=nil;
_UIObject_release(self.newAttrRed2);self.newAttrRed2=nil;
_UIObject_release(self.rattrRoot24);self.rattrRoot24=nil;
_UIObject_release(self.rattrRoot23);self.rattrRoot23=nil;
_UIObject_release(self.rattrRoot22);self.rattrRoot22=nil;
_UIObject_release(self.rattrRoot21);self.rattrRoot21=nil;
_UIObject_release(self.lSuitRoot2);self.lSuitRoot2=nil;
_UIObject_release(self.newSuitRed2);self.newSuitRed2=nil;
_UIObject_release(self.rSuitRoot2);self.rSuitRoot2=nil;
end



















local leftAttrPosY={-43,-43}
local suitPosY={-85,308}
local _colorFormat=
{
[eQualityColor.eGreen]='#4f851b',
[eQualityColor.eBlue]='#1b4385',
[eQualityColor.ePurple]='#431b85',
[eQualityColor.eOrange]='#85451b',
[eQualityColor.eRed]='#851b1b',

}

local _colorFormat2=
{
[eQualityColor.eGreen]='#549327',
[eQualityColor.eBlue]='#1b4385',
[eQualityColor.ePurple]='#6833c0',
[eQualityColor.eOrange]='#ca631d',
[eQualityColor.eRed]='#c82c2c',
}
local _colorFormat3=
{
[1]='#5f8d33',
[2]='#c99b4c',
[3]='#ca631d',
[4]='#c82c2c',
}

local _upImg=
{
[1]='icon_jiantou_1',
[2]='icon_jiantou_4',
[3]='icon_jiantou_5',
[4]='icon_jiantou_2',
}
local _getAttrColor=function(attrId,val,itemsStage)
local const_def=cfg_discipleequipjinglianconfig().const_def
local attrcolor=const_def.attrcolor
local attrColortable=attrcolor[attrId][itemsStage]
local flag=cfg_attributesconfig_get(attrId).flag
if flag==2 then
val=val/100
elseif flag==3 then
val=val*100
end
for k,v in pairs(attrColortable)do
if val>=v[1]and(v[2]==nil or val<v[2])then
return k
elseif k>=#attrColortable then
return k
end
end
loggerUtil.logErrFMT('属性{0}阶数{1}没有找到值{2}对应的颜色',attrId,itemsStage,val)
end

function UIEquipChongZhuSureWin:onLoaded(...)
self:bindComponents()
end


function UIEquipChongZhuSureWin:__delete()
self:unbindComponents()
end




function UIEquipChongZhuSureWin:onShow(argtable,afterOnloaded)
local data=argtable
local itemguid=data.itemguid
local equip=equipsHelper.getEquip(itemguid)
local itemid=equip.itemid
self.itemguid=itemguid
self.itemid=itemid
self.equip=equip
self.equipConfig=itemsConfig.getConfig(itemid)
self.equipPos=self.equipConfig.type1
local isEquip=equipsModel.isEquipedOnAnyDizi(itemguid)

if isEquip then
self.diziGuid=equipsModel.getDiziguidByItemguid(itemguid)
end
self.isEquip=isEquip

self:refreshState()


self:refresh()
end


function UIEquipChongZhuSureWin:onHide()

end

function UIEquipChongZhuSureWin:refreshState()
local data=equipsModel:getChongZhuEquipData(self.itemguid)
local newAttr=data.randattrList
local newSuit=data.suitid
local selecType=0
self.selectAfter=true
self.selectAfterAttr=true
self.selectAfterSuit=true
if newAttr~=nil and newSuit~=0 then
selecType=1
self:refreshCheck1()
self:refreshCheck2()
self.lattrs:setActive(true)
self.rattrs:setActive(true)
self.lsuit:setActive(true)
self.rsuit:setActive(true)
elseif newAttr~=nil and newSuit==0 then
selecType=2
self.lsuit:setActive(false)
self.rsuit:setActive(false)
self.lattrs2:setActive(true)
self.rattrs2:setActive(true)

self:refreshCheck()
elseif newAttr==nil and newSuit~=0 then
selecType=3
self.lattrs:setActive(false)
self.rattrs:setActive(false)
self.lsuit:setLocalPosY(suitPosY[2])
self.rsuit:setLocalPosY(suitPosY[2])
self.lsuit2:setActive(true)
self.rsuit2:setActive(true)
self:refreshCheck()
end
self.selectType=selecType
self.BtnSelectBefore:setActive(selecType==2 or selecType==3)
self.BtnSelectAfter:setActive(selecType==2 or selecType==3)
self.BtnSelectBeforeAttr:setActive(selecType==1)
self.BtnSelectAfterAttr:setActive(selecType==1)
self.BtnSelectBeforeSuit:setActive(selecType==1)
self.BtnSelectAfterSuit:setActive(selecType==1)
end

function UIEquipChongZhuSureWin:refresh()
if self.selectType==1 then
self:refreshLeftAttr((self.selectAfterAttr))
self:refreshLeftSuit((self.selectAfterSuit))
local data=equipsModel:getChongZhuEquipData(self.itemguid)
self:refreshRightAttr(data.randattrList,not(self.selectAfterAttr))
self:refreshRightSuit(data.suitid,not(self.selectAfterSuit))
else
self:refreshLeftAttr((self.selectAfter))
self:refreshLeftSuit((self.selectAfter))
local data=equipsModel:getChongZhuEquipData(self.itemguid)
self:refreshRightAttr(data.randattrList,not(self.selectAfter))
self:refreshRightSuit(data.suitid,not(self.selectAfter))
end
end

function UIEquipChongZhuSureWin:refreshCheck()
self.selectBeforeImg:setActive(not self.selectAfter)
self.selectAfterImg:setActive(self.selectAfter)
end

function UIEquipChongZhuSureWin:refreshCheck1()
self.selectBeforeAttrImg:setActive(not self.selectAfterAttr)
self.selectAfterAttrImg:setActive(self.selectAfterAttr)
end

function UIEquipChongZhuSureWin:refreshCheck2()
self.selectBeforeSuitImg:setActive(not self.selectAfterSuit)
self.selectAfterSuitImg:setActive(self.selectAfterSuit)
end

function UIEquipChongZhuSureWin:refreshLeftAttr(gray)
local itemData=self.equip.itemData or{}
local randattrList=itemData.randattrList
if randattrList==nil then
self.canSelectAttr=false
return
end
local length=#randattrList
self.canSelectAttr=length>=4
local isTwo=self.selectType==2
for i,v in ipairs(randattrList)do
local name,valstr=equipsHelper.getAttr(v.param_1,v.param_2)
local itemConfig=itemsConfig.getConfig(self.itemid)
local attrColor=_getAttrColor(v.param_1,v.param_2,itemConfig.stage)
local cf=_colorFormat[attrColor]
local cf2=_colorFormat2[attrColor]
if gray then
cf="#525050"
cf2="#525050"
end
local widget=self[FMT.fmt('lattrRoot{1}{0}',i,isTwo and 2 or"")]:getWidgetBase()
widget:SetChildText(1,FMT.fmt('<color={0}>{1}：</color><color={2}>{3}</color>',cf2,name,cf,valstr))
self[FMT.fmt('lattrRoot{1}{0}',i,isTwo and 2 or"")]:setActive(true)

if v.param_3 and v.param_3>0 then
widget:SetChildActive(6,true)
widget:SetChildText(7,FMT.fmt("<color={0}>x{1}</color>",_colorFormat3[v.param_3],v.param_3))
widget:SetChildCSImageSprite(6,iconHelper.globalSpriteBundle1,_upImg[v.param_3])
else
widget:SetChildActive(6,false)
end
end
if length<4 then
for i=#randattrList+1,4 do
self[FMT.fmt('lattrRoot{1}{0}',i,isTwo and 2 or"")]:setActive(false)
end
end
self.BtnSelectBefore:setGray(gray)
self.BtnSelectBeforeAttr:setGray(gray)
end

function UIEquipChongZhuSureWin:refreshLeftSuit(gray)
local itemData=self.equip.itemData or{}
local suitid=itemData.suitid
local suitConfig=equipsConfig.getSuitConfig(suitid)
if suitConfig==nil then
return
end
local attrColor="171311"
if gray then
attrColor="525050"
end
local isTwo=self.selectType==3
local widget=self[FMT.fmt('lSuitRoot{0}',isTwo and 2 or"")]:getWidgetBase()
local attr2desc=suitConfig.attr2desc
widget:SetChildActive(1,attr2desc~=nil)
if attr2desc then
local attr4name=FMT.fmt('<color=#{1}>[{0}]</color>',string.addSpace('2件套',true),attrColor)
local desc=FMT.fmt('<color=#{2}>{0}\194\160{1}</color>',attr4name,attr2desc,attrColor)
widget:SetChildText(1,desc)
end

local attr3desc=suitConfig.attr3desc
widget:SetChildActive(2,attr3desc~=nil)
if attr3desc then
local attr4name=FMT.fmt('<color=#{1}>[{0}]</color>',string.addSpace('3件套',true),attrColor)
local desc=FMT.fmt('<color=#{2}>{0}\194\160{1}</color>',attr4name,attr3desc,attrColor)
widget:SetChildText(2,desc)
end
local name=suitConfig.name
widget:SetChildText(0,name)
self.BtnSelectBefore:setGray(gray)
self.BtnSelectBeforeSuit:setGray(gray)
end

function UIEquipChongZhuSureWin:refreshRightPanel(gray)
local data=equipsModel:getChongZhuEquipData(self.itemguid)
self:refreshRightAttr(data.randattrList,gray)
self:refreshRightSuit(data.suitid,gray)
end

function UIEquipChongZhuSureWin:refreshRightAttr(newAttrList,gray)
local list=newAttrList
local isNew=true
if not list then
local itemData=self.equip.itemData or{}
list=itemData.randattrList
isNew=false
end
local isTwo=self.selectType==2
if list and#list>0 then
local length=#list
for i,v in ipairs(list)do
local name,valstr=equipsHelper.getAttr(v.param_1,v.param_2)
local widget=self[FMT.fmt('rattrRoot{1}{0}',i,isTwo and 2 or"")]:getWidgetBase()
local itemConfig=itemsConfig.getConfig(self.itemid)
local attrColor=_getAttrColor(v.param_1,v.param_2,itemConfig.stage)
local cf=_colorFormat[attrColor]
local cf2=_colorFormat2[attrColor]
if gray then
cf="#525050"
cf2="#525050"
end
widget:SetChildText(1,FMT.fmt('<color={0}>{1}：</color><color={2}>{3}</color>',cf2,name,cf,valstr))
self[FMT.fmt('rattrRoot{1}{0}',i,isTwo and 2 or"")]:setActive(true)

if v.param_3 and v.param_3>0 then
widget:SetChildActive(6,true)
widget:SetChildText(7,FMT.fmt("<color={0}>x{1}</color>",_colorFormat3[v.param_3],v.param_3))
widget:SetChildCSImageSprite(6,iconHelper.globalSpriteBundle1,_upImg[v.param_3])
else
widget:SetChildActive(6,false)
end
end
if length<4 then
for i=#list+1,4 do
self[FMT.fmt('rattrRoot{1}{0}',i,isTwo and 2 or"")]:setActive(false)
end
end
self.BtnSelectAfter:setGray(gray)
self.BtnSelectAfterAttr:setGray(gray)
end
end

function UIEquipChongZhuSureWin:refreshRightSuit(newSuit,gray)
local suitid=newSuit
local isNew=true
if not suitid or suitid==0 then
local itemData=self.equip.itemData or{}
suitid=itemData.suitid
isNew=false
end

local suitConfig=equipsConfig.getSuitConfig(suitid)
if suitConfig==nil then
return
end
local attrColor="171311"
if gray then
attrColor="525050"
end
local isTwo=self.selectType==3
local widget=self[FMT.fmt('rSuitRoot{0}',isTwo and 2 or"")]:getWidgetBase()
local attr2desc=suitConfig.attr2desc
widget:SetChildActive(1,attr2desc~=nil)
if attr2desc then
local attr4name=FMT.fmt('<color=#{1}>[{0}]</color>',string.addSpace('2件套',true),attrColor)
local desc=FMT.fmt('<color=#{2}>{0}\194\160{1}</color>',attr4name,attr2desc,attrColor)
widget:SetChildText(1,desc)
end

local attr3desc=suitConfig.attr3desc
widget:SetChildActive(2,attr3desc~=nil)
if attr3desc then
local attr4name=FMT.fmt('<color=#{1}>[{0}]</color>',string.addSpace('3件套',true),attrColor)
local desc=FMT.fmt('<color=#{2}>{0}\194\160{1}</color>',attr4name,attr3desc,attrColor)
widget:SetChildText(2,desc)
end
local name=suitConfig.name
widget:SetChildText(0,name)
self.BtnSelectAfter:setGray(gray)
self.BtnSelectAfterSuit:setGray(gray)
end

function UIEquipChongZhuSureWin:onCloseClick()
self:closeSelf()
end





function UIEquipChongZhuSureWin:onBtnSelectBefore()
self.selectAfter=false
self:refreshCheck()
self:refresh()
end



function UIEquipChongZhuSureWin:onBtnSelectAfter()
self.selectAfter=true
self:refreshCheck()
self:refresh()
end

function UIEquipChongZhuSureWin:onBtnSelectBeforeAttr()
self.selectAfterAttr=false
self:refreshCheck1()
self:refresh()
end

function UIEquipChongZhuSureWin:onBtnSelectAfterAttr()
self.selectAfterAttr=true
self:refreshCheck1()
self:refresh()
end

function UIEquipChongZhuSureWin:onBtnSelectBeforeSuit()
self.selectAfterSuit=false
self:refreshCheck2()
self:refresh()
end

function UIEquipChongZhuSureWin:onBtnSelectAfterSuit()
self.selectAfterSuit=true
self:refreshCheck2()
self:refresh()
end



function UIEquipChongZhuSureWin:onBtnSure()
local flag=0
if self.selectType==1 then
if self.selectAfterAttr then
flag=bitHelper.set_1(flag,0)
end
if self.selectAfterSuit then
flag=bitHelper.set_1(flag,1)
end
elseif self.selectType==2 or self.selectType==3 then
if self.selectAfter then
local data=equipsModel:getChongZhuEquipData(self.itemguid)
flag=data.flag
end
end

if self.isEquip then
equipsProtocolControl.req_equip_2_93(self.diziGuid,self.equipPos,flag)
else
equipsProtocolControl.req_equip_2_93(self.itemguid,0,flag)
end
self:closeSelf()
end

