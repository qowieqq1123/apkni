







def_class("UIEquipChongZhuWin",UIWindowBase)









function UIEquipChongZhuWin:bindComponents()

self.leftPanel=UIObject.get(self,0)
self.BtnSelectSuit=UIButton.get(self,1)
self.showItem=UIBaseItem.get(self,2)
self.battrs=UIObject.get(self,3)
self.selectSuitImg=UIObject.get(self,4)
self.BtnSelectAttr=UIButton.get(self,5)
self.selectAttrImg=UIObject.get(self,6)
self.afterRoot=UIObject.get(self,7)
self.beforeRoot=UIObject.get(self,8)
self.tipsText=UIText.get(self,9)
self.btnSure=UIButton.get(self,10)
self.btnAgain=UIButton.get(self,11)
self.btnChongZhu=UIButton.get(self,12)
self.lattrRoot3=UIObject.get(self,13)
self.lattrRoot2=UIObject.get(self,14)
self.lattrRoot1=UIObject.get(self,15)
self.lattrRoot4=UIObject.get(self,16)
self.rattrRoot4=UIObject.get(self,17)
self.rattrRoot3=UIObject.get(self,18)
self.rattrRoot2=UIObject.get(self,19)
self.rattrRoot1=UIObject.get(self,20)
self.rattrRoot=UIObject.get(self,21)
self.newAttrRed=UIText.get(self,22)
self.newSuitRed=UIText.get(self,23)
self.rsuitRoot=UIObject.get(self,24)
self.leftItem=UIBaseItem.get(self,25)
self.rightItem=UIBaseItem.get(self,26)
self.lSuitRoot=UIObject.get(self,27)
self.rAttrRoot=UIObject.get(self,28)
self.rSuitRoot=UIObject.get(self,29)

self.BtnSelectSuit:setButtonClick(function()self:onBtnSelectSuit()end)

self.BtnSelectAttr:setButtonClick(function()self:onBtnSelectAttr()end)

self.btnSure:setButtonClick(function()self:onBtnSure()end)

self.btnAgain:setButtonClick(function()self:onBtnAgain()end)

self.btnChongZhu:setButtonClick(function()self:onBtnChongZhu()end)



end


function UIEquipChongZhuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.BtnSelectSuit);self.BtnSelectSuit=nil;
_UIObject_release(self.showItem);self.showItem=nil;
_UIObject_release(self.battrs);self.battrs=nil;
_UIObject_release(self.selectSuitImg);self.selectSuitImg=nil;
_UIObject_release(self.BtnSelectAttr);self.BtnSelectAttr=nil;
_UIObject_release(self.selectAttrImg);self.selectAttrImg=nil;
_UIObject_release(self.afterRoot);self.afterRoot=nil;
_UIObject_release(self.beforeRoot);self.beforeRoot=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.btnSure);self.btnSure=nil;
_UIObject_release(self.btnAgain);self.btnAgain=nil;
_UIObject_release(self.btnChongZhu);self.btnChongZhu=nil;
_UIObject_release(self.lattrRoot3);self.lattrRoot3=nil;
_UIObject_release(self.lattrRoot2);self.lattrRoot2=nil;
_UIObject_release(self.lattrRoot1);self.lattrRoot1=nil;
_UIObject_release(self.lattrRoot4);self.lattrRoot4=nil;
_UIObject_release(self.rattrRoot4);self.rattrRoot4=nil;
_UIObject_release(self.rattrRoot3);self.rattrRoot3=nil;
_UIObject_release(self.rattrRoot2);self.rattrRoot2=nil;
_UIObject_release(self.rattrRoot1);self.rattrRoot1=nil;
_UIObject_release(self.rattrRoot);self.rattrRoot=nil;
_UIObject_release(self.newAttrRed);self.newAttrRed=nil;
_UIObject_release(self.newSuitRed);self.newSuitRed=nil;
_UIObject_release(self.rsuitRoot);self.rsuitRoot=nil;
_UIObject_release(self.leftItem);self.leftItem=nil;
_UIObject_release(self.rightItem);self.rightItem=nil;
_UIObject_release(self.lSuitRoot);self.lSuitRoot=nil;
_UIObject_release(self.rAttrRoot);self.rAttrRoot=nil;
_UIObject_release(self.rSuitRoot);self.rSuitRoot=nil;
end


















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

function UIEquipChongZhuWin:onLoaded(...)
self:bindComponents()
self.attrTweener1={}
self.attrTweener2={}
end


function UIEquipChongZhuWin:__delete()
self:unbindComponents()

discipleEquipSheetReddot:resetConfig()
end

function UIEquipChongZhuWin:onShowArgRecv(argtable,afterOnloaded)

self.rSuitRoot:setChildCanvasGroupAlpha(0)
self.rAttrRoot:setChildCanvasGroupAlpha(0)

self:onShow(argtable,true)
end




function UIEquipChongZhuWin:onShow(argtable,afterOnloaded)
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
self.afterOnloaded=afterOnloaded
if isEquip then
self.diziGuid=equipsModel.getDiziguidByItemguid(itemguid)
if self.afterOnloaded then
equipsProtocolControl.req_equip_2_91(self.diziGuid,self.equipPos)
self.isWaittingData=true
else
self:refreshLeftAttr()
self:refreshLeftSuit()
end
else
if self.afterOnloaded then
equipsProtocolControl.req_equip_2_91(itemguid,0)
self.isWaittingData=true
else
self:refreshLeftAttr()
self:refreshLeftSuit()
end
end

self.isEquip=isEquip

self:refreshSelfItem()
end


function UIEquipChongZhuWin:onRecvData(initSelect)
self.isWaittingData=false

local data=equipsModel:getChongZhuEquipData(self.itemguid)
local flag=data~=nil and data.flag or 0


if initSelect then
if self.afterOnloaded then
self.selectAttr=bitHelper.check_pos(flag,0)
self.selectSuit=bitHelper.check_pos(flag,1)
end
end

self.selectAttrImg:setActive(self.selectAttr or false)
self.selectSuitImg:setActive(self.selectSuit or false)
self.BtnSelectSuit:setActive(not self.selectSuit)
self.BtnSelectAttr:setActive(not self.selectAttr)
if data then
self.isChongZhu=self.selectAttr or self.selectSuit
else
self.isChongZhu=false
end

self:refreshLeftAttr()
self:refreshLeftSuit()
self:refreshRightPanel()
self:refreshCostItem()
self:refreshBtn()
end

function UIEquipChongZhuWin:refreshSelfItem()
local item={itemid=self.itemid,itemguid=self.itemguid}
local conf={showCountBG=false,showname=false,guid=self.itemguid,showStageBg=true}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
self.showItem:setChildPropData(prop)
self.showItem:setBaseItemClickEvent(self.onClickItem)
end

function UIEquipChongZhuWin:refreshLeftAttr()
local itemData=self.equip.itemData or{}
local randattrList=itemData.randattrList
if randattrList==nil then
self.canSelectAttr=false
return
end


local length=#randattrList
self.canSelectAttr=length>=4
for i,v in ipairs(randattrList)do
local name,valstr=equipsHelper.getAttr(v.param_1,v.param_2)
local widget=self[FMT.fmt('lattrRoot{0}',i)]:getWidgetBase()
local itemConfig=itemsConfig.getConfig(self.itemid)
local attrColor=_getAttrColor(v.param_1,v.param_2,itemConfig.stage)
widget:SetChildText(1,FMT.fmt('<color={0}>{1}：</color><color={2}>{3}</color>',_colorFormat2[attrColor],name,_colorFormat[attrColor],valstr))
self[FMT.fmt('lattrRoot{0}',i)]:setActive(true)

if v.param_3 and v.param_3>0 then
widget:SetChildActive(0,true)
widget:SetChildText(6,FMT.fmt("<color={0}>x{1}</color>",_colorFormat3[v.param_3]==nil and _colorFormat3[#_colorFormat3]or _colorFormat3[v.param_3],v.param_3))
widget:SetChildCSImageSprite(0,iconHelper.globalSpriteBundle1,_upImg[v.param_3]==nil and _upImg[#_upImg]or _upImg[v.param_3])
else
widget:SetChildActive(0,false)
end

end
if length<4 then
for i=#randattrList+1,4 do
self[FMT.fmt('lattrRoot{0}',i)]:setActive(false)
end
end
end

function UIEquipChongZhuWin:refreshLeftSuit()
local itemData=self.equip.itemData or{}
local suitid=itemData.suitid
local suitConfig=equipsConfig.getSuitConfig(suitid)
local widget=self.lSuitRoot:getWidgetBase()
if suitConfig==nil then
widget:SetChildText(0,"套装效果")
return
end
local name=suitConfig.name
widget:SetChildText(0,FMT.fmt("[{0}]套装效果",name))
local attr2desc=suitConfig.attr2desc
widget:SetChildActive(1,attr2desc~=nil)
if attr2desc then
local attr4name=FMT.fmt('[{0}]',string.addSpace('2件套',true))
local desc=FMT.fmt('{0}\194\160{1}',attr4name,attr2desc)
widget:SetChildText(1,desc)
end

local attr3desc=suitConfig.attr3desc
widget:SetChildActive(2,attr3desc~=nil)
if attr3desc then
local attr4name=FMT.fmt('[{0}]',string.addSpace('3件套',true))
local desc=FMT.fmt('{0}\194\160{1}',attr4name,attr3desc)
widget:SetChildText(2,desc)
end
end

function UIEquipChongZhuWin:refreshCostItem()
local chongzhuCost=self.equipConfig.chongzhu

local item={itemid=chongzhuCost[1][1],itemcount=chongzhuCost[1][2]}
local have=itemsModel.getCount(chongzhuCost[1][1])
local canBuy=have>=chongzhuCost[1][2]
local formatHave=mathHelper.formatNumber(have)

if self.selectAttr then
self.leftItem:setGray(false)
local conf={showCountBG=true,showname=false,itemcount=canBuy and FMT.fmt("{0}/{1}",formatHave,chongzhuCost[1][2])or FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",formatHave,chongzhuCost[1][2])}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
self.leftItem:setChildPropData(prop)
self.leftItem:setBaseItemClickEvent(self.onClickItem)
else
self.leftItem:setGray(true)
local conf={showCountBG=false,showname=false,itemcount=""}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
self.leftItem:setChildPropData(prop)
self.leftItem:setBaseItemClickEvent(self.onClickItem)
end

local item={itemid=chongzhuCost[2][1],itemcount=chongzhuCost[2][2]}
local have=itemsModel.getCount(chongzhuCost[2][1])
local canBuy=have>=chongzhuCost[2][2]
local formatHave=mathHelper.formatNumber(have)


if self.selectSuit then
self.rightItem:setGray(false)
local conf={showCountBG=true,showname=false,itemcount=canBuy and FMT.fmt("{0}/{1}",formatHave,chongzhuCost[2][2])or FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",formatHave,chongzhuCost[2][2])}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
self.rightItem:setChildPropData(prop)
self.rightItem:setBaseItemClickEvent(self.onClickItem)
else
self.rightItem:setGray(true)
local conf={showCountBG=false,showname=false,itemcount=""}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
self.rightItem:setChildPropData(prop)
self.rightItem:setBaseItemClickEvent(self.onClickItem)
end
end



function UIEquipChongZhuWin.onClickItem(itemid,index,itemguid,attach)
if itemid==-1 then
return
end
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end

function UIEquipChongZhuWin:refreshRightPanel()
if self.isChongZhu then
self.btnChongZhu:setActive(false)
self.btnAgain:setActive(true)
self.btnSure:setActive(true)

self.beforeRoot:setActive(false)

local data=equipsModel:getChongZhuEquipData(self.itemguid)
self:refreshRightAttr(data.randattrList,true)
self:refreshRightSuit(data.suitid)

if self.selectAttr then
self.rAttrRoot:setChildCanvasGroupAlpha(1)
self.rAttrRoot:setChildAnchoredPosition(Vector3.New(174,-134,0))
end

if self.selectSuit then
self.rSuitRoot:setChildCanvasGroupAlpha(1)
self.rSuitRoot:setChildAnchoredPosition(Vector3.New(0,0,0))
end
else
self.btnChongZhu:setActive(true)
self.btnAgain:setActive(false)
self.btnSure:setActive(false)

self:refreshRightAttr()
self:refreshRightSuit(0)

self.beforeRoot:setActive(true)

local widget=self.rSuitRoot:getWidgetBase()
widget:SetChildText(0,"套装效果")
end
end

function UIEquipChongZhuWin:refreshRightAttr(newAttrList,anim)
local list=newAttrList
local isNew=true
if not list then
local itemData=self.equip.itemData or{}
list=itemData.randattrList
isNew=false
end
self.newAttrRed:setActive(not isNew)
self.rattrRoot:setActive(isNew)

if isNew then
local length=#list
for i,v in ipairs(list)do
local name,valstr=equipsHelper.getAttr(v.param_1,v.param_2)
local widget=self[FMT.fmt('rattrRoot{0}',i)]:getWidgetBase()
local itemConfig=itemsConfig.getConfig(self.itemid)
local attrColor=_getAttrColor(v.param_1,v.param_2,itemConfig.stage)
widget:SetChildText(1,FMT.fmt('<color={0}>{1}：</color><color={2}>{3}</color>',_colorFormat2[attrColor],name,_colorFormat[attrColor],valstr))
if v.param_3 and v.param_3>0 then
widget:SetChildActive(0,true)
widget:SetChildText(6,FMT.fmt("<color={0}>x{1}</color>",_colorFormat3[v.param_3]==nil and _colorFormat3[#_colorFormat3]or _colorFormat3[v.param_3],v.param_3))
widget:SetChildCSImageSprite(0,iconHelper.globalSpriteBundle1,_upImg[v.param_3]==nil and _upImg[#_upImg]or _upImg[v.param_3])
else
widget:SetChildActive(0,false)
end

if anim then
self[FMT.fmt('rattrRoot{0}',i)]:setChildCanvasGroupAlpha(0)
if self.attrTweener1[i]then
self.attrTweener1[i]:Kill()
end
if self.attrTweener2[i]then
self.attrTweener2[i]:Kill()
end
local tweener=self[FMT.fmt('rattrRoot{0}',i)]:setChildCanvasGroupDOFade(1,0.1)
tweener:SetDelay((i-1)*0.2)
self.attrTweener1[i]=tweener
self[FMT.fmt('rattrRoot{0}',i)]:setLocalPosX(-48)
local tweener2=self[FMT.fmt('rattrRoot{0}',i)]:setChildDOLocalMoveX(-24,0.2)
tweener2:SetDelay((i-1)*0.2)
self.attrTweener2[i]=tweener2
else
self[FMT.fmt('rattrRoot{0}',i)]:setChildCanvasGroupAlpha(1)
end
end
if length<4 then
for i=#list+1,4 do
self[FMT.fmt('rattrRoot{0}',i)]:setChildCanvasGroupAlpha(0)
end
end
else

end
end

function UIEquipChongZhuWin:refreshRightSuit(newSuit,flag)
local suitid=newSuit
local isNew=true
if not suitid or suitid==0 then
local itemData=self.equip.itemData or{}
suitid=itemData.suitid
isNew=false
end
self.newSuitRed:setActive(not isNew)

self.rsuitRoot:setActive(isNew)
if not isNew then
local widget=self.rSuitRoot:getWidgetBase()
widget:SetChildText(0,"套装效果")
end
if isNew then
local suitConfig=equipsConfig.getSuitConfig(suitid)
if suitConfig==nil then
return
end
local widget=self.rSuitRoot:getWidgetBase()
local attr2desc=suitConfig.attr2desc

widget:SetChildActive(3,attr2desc~=nil)
if attr2desc then
local attr4name=FMT.fmt('[{0}]',string.addSpace('2件套',true))
local desc=FMT.fmt('{0}\194\160{1}',attr4name,attr2desc)
widget:SetChildText(1,desc)

end

local attr3desc=suitConfig.attr3desc

widget:SetChildActive(4,attr3desc~=nil)
if attr3desc then
local attr4name=FMT.fmt('[{0}]',string.addSpace('3件套',true))
local desc=FMT.fmt('{0}\194\160{1}',attr4name,attr3desc)
widget:SetChildText(2,desc)
end
local name=suitConfig.name
widget:SetChildText(0,FMT.fmt("[{0}]套装效果",name))

if attr2desc then
widget:SetChildCanvasGroupAlpha(1,0)
local tweener=widget:SetChildCanvasGroupDOFade(1,1,0.1)
tweener:SetDelay((1-1)*0.2)
widget:SetChildLocalPosX(1,-180)
local tweener2=widget:SetChildDOLocalMoveX(1,-150,0.2)
tweener2:SetDelay((1-1)*0.2)
else
widget:SetChildCanvasGroupAlpha(1,0)
end
if attr3desc then
widget:SetChildCanvasGroupAlpha(2,0)
local tweener3=widget:SetChildCanvasGroupDOFade(2,1,0.1)
tweener3:SetDelay((2-1)*0.2)
widget:SetChildLocalPosX(2,-180)
local tweener4=widget:SetChildDOLocalMoveX(2,-150,0.2)
tweener4:SetDelay((2-1)*0.2)
else
widget:SetChildCanvasGroupAlpha(2,0)
end
end
end


function UIEquipChongZhuWin:onHide()

end

function UIEquipChongZhuWin:refreshBtn()
local flag=0
if self.selectAttr then
flag=bitHelper.set_1(flag,0)
end
if self.selectSuit then
flag=bitHelper.set_1(flag,1)
end
self.btnChongZhu:setButtonEnable(true,flag==0)

self.tipsText:setActive(flag==0)
end





function UIEquipChongZhuWin:onLeftDialogue()
if self.isWaittingData then
return
end

end



function UIEquipChongZhuWin:onBtnSelectSuit()
if self.isWaittingData then
return
end




self.selectSuit=not self.selectSuit
self.BtnSelectSuit:setActive(not self.selectSuit)
self.selectSuitImg:setActive(self.selectSuit)


self:refreshCostItem()

self:refreshBtn()




if self.selectSuit then
self.rSuitRoot:setChildAnchoredPosition(Vector3.New(0,247,0))
self.rSuitRoot:setChildDOLocalMoveY(0,0.2)
self.rSuitRoot:setChildCanvasGroupAlpha(0)
self.rSuitRoot:setChildCanvasGroupDOFade(1,0.1)
else
self.rSuitRoot:setChildAnchoredPosition(Vector3.New(0,0,0))
self.rSuitRoot:setChildDOLocalMoveY(247,0.2)
self.rSuitRoot:setChildCanvasGroupAlpha(1)
self.rSuitRoot:setChildCanvasGroupDOFade(0,0.1)
end


end



function UIEquipChongZhuWin:onBtnSelectAttr()
if self.isWaittingData then
return
end
if not self.canSelectAttr then
UIManager.error("该装备随机属性条目不足4条，无法进行重铸")
return
end




self.selectAttr=not self.selectAttr
self.BtnSelectAttr:setActive(not self.selectAttr)
self.selectAttrImg:setActive(self.selectAttr)

self:refreshCostItem()

self:refreshBtn()




if self.selectAttr then
self.rAttrRoot:setChildAnchoredPosition(Vector3.New(174,112,0))
self.rAttrRoot:setChildDOLocalMoveY(-5,0.2)
self.rAttrRoot:setChildCanvasGroupAlpha(0)
self.rAttrRoot:setChildCanvasGroupDOFade(1,0.1)
else
self.rAttrRoot:setChildAnchoredPosition(Vector3.New(174,-134,0))
self.rAttrRoot:setChildDOLocalMoveY(112,0.2)
self.rAttrRoot:setChildCanvasGroupAlpha(1)
self.rAttrRoot:setChildCanvasGroupDOFade(0,0.1)
end


end



function UIEquipChongZhuWin:onBtnChongZhu()
if self.isWaittingData then
return
end

local chongzhuCost=self.equipConfig.chongzhu

local flag=0
if self.selectAttr then
local have=itemsModel.getCount(chongzhuCost[1][1])
local canBuy=have>=chongzhuCost[1][2]
if not canBuy then
local moneyType=chongzhuCost[1][1]
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(moneyType)))
gainControl:showGainWin(moneyType)
return
end
flag=bitHelper.set_1(flag,0)
end
if self.selectSuit then
local have=itemsModel.getCount(chongzhuCost[2][1])
local canBuy=have>=chongzhuCost[2][2]
if not canBuy then
local moneyType=chongzhuCost[2][1]
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(moneyType)))
gainControl:showGainWin(moneyType)
return
end
flag=bitHelper.set_1(flag,1)
end

if flag==0 then
UIManager.error("请祖师勾选至少一个需要重铸的属性")
return
end

if self.isEquip then
equipsProtocolControl.req_equip_2_92(self.diziGuid,self.equipPos,flag)
else
equipsProtocolControl.req_equip_2_92(self.itemguid,0,flag)
end
end



function UIEquipChongZhuWin:onBtnAgain()
if self.isWaittingData then
return
end
self:onBtnChongZhu()
end

function UIEquipChongZhuWin:onBtnSure()
if self.isWaittingData then
return
end

UIManager:showWindow("UIEquipChongZhuSureWin",{itemguid=self.itemguid})
end
