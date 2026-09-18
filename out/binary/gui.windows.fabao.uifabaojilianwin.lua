







def_class("UIFabaoJilianWin",UIWindowBase)









function UIFabaoJilianWin:bindComponents()

self.addJinglianArrow=UIObject.get(self,0)
self.addJinglianLv=UIText.get(self,1)
self.arrow=UIObject.get(self,2)
self.arrow1=UIObject.get(self,3)
self.attr2Title=UIObject.get(self,4)
self.attrRoot1=UIObject.get(self,5)
self.attrRoot10=UIObject.get(self,6)
self.attrRoot11=UIObject.get(self,7)
self.attrRoot12=UIObject.get(self,8)
self.attrRoot2=UIObject.get(self,9)
self.attrRoot3=UIObject.get(self,10)
self.attrRoot4=UIObject.get(self,11)
self.attrRoot5=UIObject.get(self,12)
self.attrRoot6=UIObject.get(self,13)
self.attrRoot7=UIObject.get(self,14)
self.attrRoot8=UIObject.get(self,15)
self.attrRoot9=UIObject.get(self,16)
self.attrScrollView=UIObject.get(self,17)
self.attrTitle=UIObject.get(self,18)
self.bottomPanel=UIObject.get(self,19)
self.btnReset=UIButton.get(self,20)
self.btnTuPo=UIButton.get(self,21)
self.btnTuPoReddot=UIObject.get(self,22)
self.closeBtn=UIButton.get(self,23)
self.Content=UIObject.get(self,24)
self.costItemRoot=UIObject.get(self,25)
self.costTitle=UIText.get(self,26)
self.desc=UIText.get(self,27)
self.Dropdown1=UIDropdownEx.get(self,28)
self.Dropdown2=UIDropdownEx.get(self,29)
self.Dropdown3=UIDropdownEx.get(self,30)
self.Dropdown4=UIDropdownEx.get(self,31)
self.effect=UIObject.get(self,32)
self.effect0=UIObject.get(self,33)
self.effect1=UIObject.get(self,34)
self.effect2=UIObject.get(self,35)
self.effect2attrs=UIObject.get(self,36)
self.effect3=UIObject.get(self,37)
self.effect4=UIObject.get(self,38)
self.effect5=UIObject.get(self,39)
self.effectattrs=UIObject.get(self,40)
self.effectBtn=UIButton.get(self,41)
self.effectRoot=UIObject.get(self,42)
self.effectRoots_1=UIObject.get(self,43)
self.effectRoots_10=UIObject.get(self,44)
self.effectRoots_2=UIObject.get(self,45)
self.effectRoots_3=UIObject.get(self,46)
self.effectRoots_4=UIObject.get(self,47)
self.effectRoots_5=UIObject.get(self,48)
self.effectRoots_6=UIObject.get(self,49)
self.effectRoots_7=UIObject.get(self,50)
self.effectRoots_8=UIObject.get(self,51)
self.effectRoots_9=UIObject.get(self,52)
self.effectRoots2_1=UIObject.get(self,53)
self.effectRoots2_10=UIObject.get(self,54)
self.effectRoots2_2=UIObject.get(self,55)
self.effectRoots2_3=UIObject.get(self,56)
self.effectRoots2_4=UIObject.get(self,57)
self.effectRoots2_5=UIObject.get(self,58)
self.effectRoots2_6=UIObject.get(self,59)
self.effectRoots2_7=UIObject.get(self,60)
self.effectRoots2_8=UIObject.get(self,61)
self.effectRoots2_9=UIObject.get(self,62)
self.help=UIButton.get(self,63)
self.helpO=UIObject.get(self,64)
self.item1=UIBaseItem.get(self,65)
self.item2=UIBaseItem.get(self,66)
self.item3=UIBaseItem.get(self,67)
self.item4=UIBaseItem.get(self,68)
self.item5=UIBaseItem.get(self,69)
self.jilianlevel=UIText.get(self,70)
self.jinglianPanel=UIObject.get(self,71)
self.jingLianResetBtn=UIButton.get(self,72)
self.leftItem=UIObject.get(self,73)
self.maxTitle=UIText.get(self,74)
self.progressBar=UIProgressBarAni.get(self,75)
self.progressBarReverse=UIProgressBarAni.get(self,76)
self.progressCount=UIText.get(self,77)
self.progressCountReverse=UIText.get(self,78)
self.putBtnReddot=UIObject.get(self,79)
self.rightItem=UIObject.get(self,80)
self.ScrollView=UIScrollViewSlow.get(self,81)
self.selectBg=UIButton.get(self,82)
self.selectPanel=UIObject.get(self,83)
self.showItem=UIBaseItem.get(self,84)
self.topoAddJinglianArrow=UIObject.get(self,85)
self.topoAddJinglianLv=UIText.get(self,86)
self.tupoAttrRoot1=UIObject.get(self,87)
self.tupoAttrRoot10=UIObject.get(self,88)
self.tupoAttrRoot11=UIObject.get(self,89)
self.tupoAttrRoot12=UIObject.get(self,90)
self.tupoAttrRoot2=UIObject.get(self,91)
self.tupoAttrRoot3=UIObject.get(self,92)
self.tupoAttrRoot4=UIObject.get(self,93)
self.tupoAttrRoot5=UIObject.get(self,94)
self.tupoAttrRoot6=UIObject.get(self,95)
self.tupoAttrRoot7=UIObject.get(self,96)
self.tupoAttrRoot8=UIObject.get(self,97)
self.tupoAttrRoot9=UIObject.get(self,98)
self.tupoAttrScrollView=UIObject.get(self,99)
self.tupoItem1=UIBaseItem.get(self,100)
self.tupoItem2=UIBaseItem.get(self,101)
self.tupoItem3=UIBaseItem.get(self,102)
self.tupoItem4=UIBaseItem.get(self,103)
self.tupoItem5=UIBaseItem.get(self,104)
self.tupoJilianlevel=UIText.get(self,105)
self.tupoPanel=UIObject.get(self,106)
self.tupoProgressBar=UIProgressBarAni.get(self,107)
self.tupoProgressCount=UIText.get(self,108)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.btnTuPo:setButtonClick(function()self:onBtnTuPo()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.effectBtn:setButtonClick(function()self:onEffectBtn()end)

self.help:setButtonClick(function()self:onHelp()end)

self.jingLianResetBtn:setButtonClick(function()self:onJingLianResetBtn()end)

self.selectBg:setButtonClick(function()self:onSelectBg()end)
self.effectRoots={
self.effectRoots_1,
self.effectRoots_2,
self.effectRoots_3,
self.effectRoots_4,
self.effectRoots_5,
self.effectRoots_6,
self.effectRoots_7,
self.effectRoots_8,
self.effectRoots_9,
self.effectRoots_10,
}
self.effectRoots2={
self.effectRoots2_1,
self.effectRoots2_2,
self.effectRoots2_3,
self.effectRoots2_4,
self.effectRoots2_5,
self.effectRoots2_6,
self.effectRoots2_7,
self.effectRoots2_8,
self.effectRoots2_9,
self.effectRoots2_10,
}



end


function UIFabaoJilianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addJinglianArrow);self.addJinglianArrow=nil;
_UIObject_release(self.addJinglianLv);self.addJinglianLv=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.arrow1);self.arrow1=nil;
_UIObject_release(self.attr2Title);self.attr2Title=nil;
_UIObject_release(self.attrRoot1);self.attrRoot1=nil;
_UIObject_release(self.attrRoot10);self.attrRoot10=nil;
_UIObject_release(self.attrRoot11);self.attrRoot11=nil;
_UIObject_release(self.attrRoot12);self.attrRoot12=nil;
_UIObject_release(self.attrRoot2);self.attrRoot2=nil;
_UIObject_release(self.attrRoot3);self.attrRoot3=nil;
_UIObject_release(self.attrRoot4);self.attrRoot4=nil;
_UIObject_release(self.attrRoot5);self.attrRoot5=nil;
_UIObject_release(self.attrRoot6);self.attrRoot6=nil;
_UIObject_release(self.attrRoot7);self.attrRoot7=nil;
_UIObject_release(self.attrRoot8);self.attrRoot8=nil;
_UIObject_release(self.attrRoot9);self.attrRoot9=nil;
_UIObject_release(self.attrScrollView);self.attrScrollView=nil;
_UIObject_release(self.attrTitle);self.attrTitle=nil;
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.btnTuPo);self.btnTuPo=nil;
_UIObject_release(self.btnTuPoReddot);self.btnTuPoReddot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.costItemRoot);self.costItemRoot=nil;
_UIObject_release(self.costTitle);self.costTitle=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.Dropdown2);self.Dropdown2=nil;
_UIObject_release(self.Dropdown3);self.Dropdown3=nil;
_UIObject_release(self.Dropdown4);self.Dropdown4=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect0);self.effect0=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect2attrs);self.effect2attrs=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.effect5);self.effect5=nil;
_UIObject_release(self.effectattrs);self.effectattrs=nil;
_UIObject_release(self.effectBtn);self.effectBtn=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.effectRoots_1);self.effectRoots_1=nil;
_UIObject_release(self.effectRoots_10);self.effectRoots_10=nil;
_UIObject_release(self.effectRoots_2);self.effectRoots_2=nil;
_UIObject_release(self.effectRoots_3);self.effectRoots_3=nil;
_UIObject_release(self.effectRoots_4);self.effectRoots_4=nil;
_UIObject_release(self.effectRoots_5);self.effectRoots_5=nil;
_UIObject_release(self.effectRoots_6);self.effectRoots_6=nil;
_UIObject_release(self.effectRoots_7);self.effectRoots_7=nil;
_UIObject_release(self.effectRoots_8);self.effectRoots_8=nil;
_UIObject_release(self.effectRoots_9);self.effectRoots_9=nil;
_UIObject_release(self.effectRoots2_1);self.effectRoots2_1=nil;
_UIObject_release(self.effectRoots2_10);self.effectRoots2_10=nil;
_UIObject_release(self.effectRoots2_2);self.effectRoots2_2=nil;
_UIObject_release(self.effectRoots2_3);self.effectRoots2_3=nil;
_UIObject_release(self.effectRoots2_4);self.effectRoots2_4=nil;
_UIObject_release(self.effectRoots2_5);self.effectRoots2_5=nil;
_UIObject_release(self.effectRoots2_6);self.effectRoots2_6=nil;
_UIObject_release(self.effectRoots2_7);self.effectRoots2_7=nil;
_UIObject_release(self.effectRoots2_8);self.effectRoots2_8=nil;
_UIObject_release(self.effectRoots2_9);self.effectRoots2_9=nil;
_UIObject_release(self.help);self.help=nil;
_UIObject_release(self.helpO);self.helpO=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.item5);self.item5=nil;
_UIObject_release(self.jilianlevel);self.jilianlevel=nil;
_UIObject_release(self.jinglianPanel);self.jinglianPanel=nil;
_UIObject_release(self.jingLianResetBtn);self.jingLianResetBtn=nil;
_UIObject_release(self.leftItem);self.leftItem=nil;
_UIObject_release(self.maxTitle);self.maxTitle=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressBarReverse);self.progressBarReverse=nil;
_UIObject_release(self.progressCount);self.progressCount=nil;
_UIObject_release(self.progressCountReverse);self.progressCountReverse=nil;
_UIObject_release(self.putBtnReddot);self.putBtnReddot=nil;
_UIObject_release(self.rightItem);self.rightItem=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.selectBg);self.selectBg=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.showItem);self.showItem=nil;
_UIObject_release(self.topoAddJinglianArrow);self.topoAddJinglianArrow=nil;
_UIObject_release(self.topoAddJinglianLv);self.topoAddJinglianLv=nil;
_UIObject_release(self.tupoAttrRoot1);self.tupoAttrRoot1=nil;
_UIObject_release(self.tupoAttrRoot10);self.tupoAttrRoot10=nil;
_UIObject_release(self.tupoAttrRoot11);self.tupoAttrRoot11=nil;
_UIObject_release(self.tupoAttrRoot12);self.tupoAttrRoot12=nil;
_UIObject_release(self.tupoAttrRoot2);self.tupoAttrRoot2=nil;
_UIObject_release(self.tupoAttrRoot3);self.tupoAttrRoot3=nil;
_UIObject_release(self.tupoAttrRoot4);self.tupoAttrRoot4=nil;
_UIObject_release(self.tupoAttrRoot5);self.tupoAttrRoot5=nil;
_UIObject_release(self.tupoAttrRoot6);self.tupoAttrRoot6=nil;
_UIObject_release(self.tupoAttrRoot7);self.tupoAttrRoot7=nil;
_UIObject_release(self.tupoAttrRoot8);self.tupoAttrRoot8=nil;
_UIObject_release(self.tupoAttrRoot9);self.tupoAttrRoot9=nil;
_UIObject_release(self.tupoAttrScrollView);self.tupoAttrScrollView=nil;
_UIObject_release(self.tupoItem1);self.tupoItem1=nil;
_UIObject_release(self.tupoItem2);self.tupoItem2=nil;
_UIObject_release(self.tupoItem3);self.tupoItem3=nil;
_UIObject_release(self.tupoItem4);self.tupoItem4=nil;
_UIObject_release(self.tupoItem5);self.tupoItem5=nil;
_UIObject_release(self.tupoJilianlevel);self.tupoJilianlevel=nil;
_UIObject_release(self.tupoPanel);self.tupoPanel=nil;
_UIObject_release(self.tupoProgressBar);self.tupoProgressBar=nil;
_UIObject_release(self.tupoProgressCount);self.tupoProgressCount=nil;
self.effectRoots=nil;
self.effectRoots2=nil;
end


















local _bag_filter_desc={}
local _onekey_filter_desc={}
local _colomn=4
local _row=6
local _maxAttrLine=6
local _fillItemLen=5
local _dropItemHeight=40
local _dropViewHeight=150

function UIFabaoJilianWin:onLoaded(...)
self:bindComponents()
self.showItem:setBaseItemClickEvent(function(...)self:onCostItemClick(...)end)
self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eStage,...)end)
self.Dropdown2:setChangeAction(function(...)self:onDropdownChange(ITEM_FILTER_TYPE.eColor,...)end)
self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(ITEM_FILTER_TYPE.eStage,...)end)
self.Dropdown2:setDropdownLayoutedAction(function(...)self:onDropdownCreate(ITEM_FILTER_TYPE.eColor,...)end)

self.Dropdown3:setChangeAction(function(...)self:onBagDropdownChange(ITEM_FILTER_TYPE.eStage,...)end)
self.Dropdown4:setChangeAction(function(...)self:onBagDropdownChange(ITEM_FILTER_TYPE.eColor,...)end)
self.Dropdown3:setDropdownLayoutedAction(function(...)self:onBagDropdownCreate(ITEM_FILTER_TYPE.eStage,...)end)
self.Dropdown4:setDropdownLayoutedAction(function(...)self:onBagDropdownCreate(ITEM_FILTER_TYPE.eColor,...)end)

self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)


self:addNotify(notifyConfig.on_item_list_changed,function(...)self:onItemListChanged(...)end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)

local list=table.toTable(eQualityColor.eGreen,eQualityColor.eRed)
_bag_filter_desc[ITEM_FILTER_TYPE.eColor]=itemsFilterHelper.getFilterNames(list,function(color)
return FMT.fmt('{0}',eQualityColorName[color])
end,'所有')

local list=table.toTable(1,5)
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=itemsFilterHelper.getFilterNames(list,function(stage)
return FMT.fmt('{0}品',stage)
end,'所有')

_onekey_filter_desc[ITEM_FILTER_TYPE.eColor]=itemsFilterHelper.getFilterNames(list,function(color)
return FMT.fmt('{0}及以下',eQualityColorName[color])
end)

local list=table.toTable(1,5)
_onekey_filter_desc[ITEM_FILTER_TYPE.eStage]=itemsFilterHelper.getFilterNames(list,function(stage)
return FMT.fmt('{0}品及以下',stage)
end)

self.selectBg:setActive(false)

local itemsList={}
self.itemsList=itemsList
itemsList[#itemsList+1]=self.item1
itemsList[#itemsList+1]=self.item2
itemsList[#itemsList+1]=self.item3
itemsList[#itemsList+1]=self.item4
itemsList[#itemsList+1]=self.item5

for _,v in ipairs(itemsList)do
v:setBaseItemClickEvent(function(...)self:onSelectItemClick(...)end)
end

local tupoList={}
self.tupoList=tupoList
tupoList[#tupoList+1]=self.tupoItem1
tupoList[#tupoList+1]=self.tupoItem2
tupoList[#tupoList+1]=self.tupoItem3
tupoList[#tupoList+1]=self.tupoItem4
tupoList[#tupoList+1]=self.tupoItem5

local attrsList={}
self.attrsList=attrsList
attrsList[#attrsList+1]=self.attrRoot1
attrsList[#attrsList+1]=self.attrRoot2
attrsList[#attrsList+1]=self.attrRoot3
attrsList[#attrsList+1]=self.attrRoot4
attrsList[#attrsList+1]=self.attrRoot5
attrsList[#attrsList+1]=self.attrRoot6
attrsList[#attrsList+1]=self.attrRoot7
attrsList[#attrsList+1]=self.attrRoot8
attrsList[#attrsList+1]=self.attrRoot9
attrsList[#attrsList+1]=self.attrRoot10
attrsList[#attrsList+1]=self.attrRoot11
attrsList[#attrsList+1]=self.attrRoot12

local tupoAttrsList={}
self.tupoAttrsList=tupoAttrsList
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot1
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot2
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot3
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot4
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot5
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot6
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot7
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot8
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot9
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot10
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot11
tupoAttrsList[#tupoAttrsList+1]=self.tupoAttrRoot12

self:resetData()

self.onekeyFilter={}
self.onekeyFilter[ITEM_FILTER_TYPE.eStage]=1
self.onekeyFilter[ITEM_FILTER_TYPE.eColor]=1

self.bagFilter={}
self.bagFilter[ITEM_FILTER_TYPE.eStage]=0
self.bagFilter[ITEM_FILTER_TYPE.eColor]=0




self.curPageIndex=1
self.selectItemguid=nil
self.isSetZero=false
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self.checkList={}







end

function UIFabaoJilianWin:__delete()
self:stopBehavior()
self.Dropdown1:setChangeAction(nil)
self.Dropdown2:setChangeAction(nil)
self.Dropdown3:setChangeAction(nil)
self.Dropdown4:setChangeAction(nil)

self:unbindComponents()

tipsManager.closeTips()
fabaoModel:saveFabaoJiLianFilterIdx()


discipleFabaoSheetReddot:resetConfig()


end

function UIFabaoJilianWin:onShow(argtable,afterOnloaded)
self:freshFaBao(argtable)
end

function UIFabaoJilianWin:onHide()
end




function UIFabaoJilianWin:resetData()
self.selectItemsLookup={}
self.selectList={}
self.leftExp=0
self.overExp=0
self.addItemExp=0
self.addLv=0
self.leftList={}
self.curPageIndex=1
self.isSetZero=false

end

function UIFabaoJilianWin:freshFaBao(argtable)
self:resetData()
if argtable then
local itemguid=argtable.itemguid
self.item=fabaoHelper.getFabao(itemguid)
self.isEquip=fabaoModel.isEquipedOnAnyDizi(itemguid)
end
self:freshInfo()
local itemid=self.item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local maxLv=fabaoHelper.getJilianMaxLv(self.item.itemguid)
self.desc:setText(FMT.fmt('此法宝最高可精炼至{0}级',maxLv))
end

function UIFabaoJilianWin:freshInfo()
self:setShowItems()
self:freshOnkeyDropdowns()
self:freshBagDropdowns()
self:freshRight()
self.help:setActive(true)
self.helpO:setActive(false)
end

function UIFabaoJilianWin:freshCostMoney()
local jilianlv,itemid,itemguid,jilianexp=self:getJilianInfo()
local cost=fabaoConfig.getJilianTuPoCost(jilianlv,itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local maxlv=fabaoHelper.getJilianMaxLv(self.item.itemguid)
local curIsFull=jilianlv>=maxlv
local needExp=not curIsFull and fabaoConfig.getJilianExp(jilianlv,itemConfig.stage,itemConfig.color)or 0
local needTuPo=not curIsFull and cost~=nil and jilianexp>=needExp or false
if not needTuPo then
self:setCostItems()
end
end

function UIFabaoJilianWin:freshRight()
local jilianlv,itemid,itemguid,jilianexp=self:getJilianInfo()
local cost=fabaoConfig.getJilianTuPoCost(jilianlv,itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local maxlv=fabaoHelper.getJilianMaxLv(self.item.itemguid)
local curIsFull=jilianlv>=maxlv
local needExp=not curIsFull and fabaoConfig.getJilianExp(jilianlv,itemConfig.stage,itemConfig.color)or 0
local needTuPo=not curIsFull and cost~=nil and jilianexp>=needExp or false
self.needTuPo=needTuPo
self.tupoPanel:setActive(needTuPo)
self.jinglianPanel:setActive(not needTuPo)
self.jingLianResetBtn:setActive(jilianlv>0 or jilianexp>0)
if needTuPo then
self:setTuPoCostItems()
self:setTuPoProgress()
self:setTuPoAttrs()
self:setTuPoEffects()
self:setTuPoCostMoneyItems()

self:refreshBtnToPoReddot()
else
self:setSelectItems()
self:setProgress()
self:setCostItems()
self:setAttrs()
self:setJlEffects()

self:refreshPutBtnReddot()
end
end

function UIFabaoJilianWin:getJilianInfo()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local jilianlv=item.itemData and item.itemData.jilianlv or 0
local jilianexp=item.itemData and item.itemData.jilianexp or 0
return jilianlv,itemid,itemguid,jilianexp
end


function UIFabaoJilianWin:setShowItems()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
local name=item.itemData.name
local item_config=itemsConfig.getConfig(itemid)

local iconName=itemsModel.getIconName(item)
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetIcon,0,iconName)
self.showItem:setChildItemDataByDataPropKey(DataPropKey.eWidgetText,1,name)
self.showItem:setChildItemData(DataPropKey.eItemID,itemid)
self.showItem:setChildItemData(DataPropKey.eItemSeries,itemguid)


end



function UIFabaoJilianWin:freshAddExp()
local selectItems=self.selectList or{}
local addItemExp,addLv,leftExp,overExp,tuPoProgress=self:getJilianData(selectItems)
self.addItemExp=addItemExp
self.addLv=addLv
self.leftExp=leftExp

self.overExp=overExp
self.tuPoProgress=tuPoProgress
end

function UIFabaoJilianWin:getAddExp(itemguid)
local selectItems=self.selectList or{}
for k,v in pairs(selectItems)do
local _itemguid=v[1]
if tostring(_itemguid)==tostring(itemguid)then
local num=v[2]
local item=bagModel.getItem(itemguid)
if item then
return fabaoHelper.getJilianValue(itemguid,num)
end
end
end
return 0
end

function UIFabaoJilianWin:getJilianData(selectItems)
local addItemExp=0
if selectItems then
for k,v in pairs(selectItems)do
local itemguid=v[1]
local num=v[2]
local item=bagModel.getItem(itemguid)
if item then
addItemExp=addItemExp+fabaoHelper.getJilianValue(itemguid,num)
end
end
end
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
local jilianlv=item.itemData and item.itemData.jilianlv or 0
local jilianexp=item.itemData and item.itemData.jilianexp or 0
local addLv,leftExp,overExp,tuPoProgress=fabaoHelper.getAddJilianLv(itemguid,jilianlv,jilianexp,addItemExp)
local addExp=addItemExp-leftExp

return addItemExp,addLv,leftExp,overExp,tuPoProgress
end

function UIFabaoJilianWin:setProgress()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local maxlv=fabaoHelper.getJilianMaxLv(self.item.itemguid)
local jilianlv=item.itemData and item.itemData.jilianlv or 0
local jilianexp=item.itemData and item.itemData.jilianexp or 0
local duration=self.progressAni and 0.3 or 0
local durationReverse=self.progressReverseAni and 0.3 or 0
local addLv=self.addLv
local curIsFull=jilianlv>=maxlv
self.maxTitle:setText(curIsFull and'法宝已精炼至满级'or'')
self.bottomPanel:setActive(not curIsFull)
self.costItemRoot:setActive(not curIsFull)
if curIsFull then
self.progressBar:animateThreeParams(100,100,0)
self.progressBarReverse:animateThreeParams(100,100,0)
self.progressCount:setText('已满级')
self.progressCountReverse:setText('')
else
local curExp=jilianexp
local curTempExp=self.leftExp
local maxExp=0
local jilianlvOnAdd=addLv+jilianlv
local isFull=jilianlvOnAdd>=maxlv
local isTuPoLv=fabaoConfig.isJilianTuPoLv(jilianlvOnAdd,itemid)
local addItemExp=self.addItemExp
if addLv<=0 then
maxExp=fabaoConfig.getJilianExp(jilianlv,itemConfig.stage,itemConfig.color)
local curExp=fabaoHelper.getJilianExpByLevel(itemguid,0,jilianlv-1)+jilianexp
local totalExp=fabaoHelper.getJilianExpByLevel(itemguid,0,jilianlvOnAdd)
local left=self.addItemExp+curExp-totalExp
if isTuPoLv and left>=0 then
curExp=maxExp
curTempExp=left+maxExp
end
else
if not isFull then
maxExp=fabaoConfig.getJilianExp(jilianlvOnAdd,itemConfig.stage,itemConfig.color)
if self.tuPoProgress then
maxExp=fabaoConfig.getJilianExp(jilianlvOnAdd+1,itemConfig.stage,itemConfig.color)
end
local curExp=fabaoHelper.getJilianExpByLevel(itemguid,0,jilianlv-1)+jilianexp
local totalExp=fabaoHelper.getJilianExpByLevel(itemguid,0,jilianlvOnAdd)
local left=self.addItemExp+curExp-totalExp
if isTuPoLv and left>=0 then
curExp=maxExp
curTempExp=left+maxExp
end
else
maxExp=fabaoConfig.getJilianExp(maxlv-1,itemConfig.stage,itemConfig.color)
curTempExp=curTempExp+maxExp
end
if addLv>0 and not(addLv==1 and jilianlv==maxlv-1)then
curExp=0
end
end
if addItemExp==0 then
curTempExp=curExp
end
self.progressBar:animateThreeParams(curExp,maxExp,0)
self.progressBarReverse:animateThreeParams(curTempExp,maxExp,durationReverse)
self.progressCount:setText(FMT.fmt('{0}/{1}',curTempExp,maxExp))
self.progressCountReverse:setText(self.addItemExp>0 and FMT.fmt('+{0}',self.addItemExp)or'')
end
self.jilianlevel:setText(FMT.fmt('精炼等级：{0}/{1}',jilianlv,maxlv))
local addLv=self.addLv
local isAddLv=addLv>0
self.addJinglianLv:setText(isAddLv and addLv or'')
self.addJinglianArrow:setActive(isAddLv)
self.progressAni=true
self.progressReverseAni=true
end


function UIFabaoJilianWin:setTuPoProgress()
local jilianlv,itemid,itemguid,jilianexp=self:getJilianInfo()
local needTuPoItems=fabaoConfig.getJilianTuPoCost(jilianlv,itemid)
local needTuPo=needTuPoItems~=nil
local maxlv=fabaoHelper.getJilianMaxLv(self.item.itemguid)
local curIsFull=jilianlv>=maxlv
if curIsFull then
self.tupoProgressBar:animateThreeParams(0,100,0)
self.tupoProgressCount:setText('已满级')
else
self.tupoProgressBar:animateThreeParams(100,100,0)
self.tupoProgressCount:setText('可突破')
end
local addLv=fabaoHelper.getOverJilianLv(itemguid,jilianlv,jilianexp)
if addLv<=0 then addLv=1 end
self.tupoJilianlevel:setText(FMT.fmt('精炼等级：{0}/{1}',jilianlv,maxlv))
self.topoAddJinglianLv:setText(addLv)
self.topoAddJinglianArrow:setActive(true)
end

function UIFabaoJilianWin:setTuPoCostMoneyItems()
local components={}
components[#components+1]=self.leftItem
components[#components+1]=self.rightItem

for i,v in ipairs(components)do
v:setActive(false)
end
end

function UIFabaoJilianWin:setCostItems()
local components={}
components[#components+1]=self.leftItem
components[#components+1]=self.rightItem

local consumelist=fabaoConfig.getJilianCost()
for i,v in ipairs(components)do
local costInfo=consumelist[i]
v:setActive(costInfo~=nil)
if costInfo then
local itemid=costInfo[1]
local revise=costInfo[2]
self.checkList[itemid]=true
local cost=fabaoConfig.getJilianCostMoney(revise,self.addItemExp-self.overExp)
local isEnough=moneyModel.checkEnoughMoney(itemid,cost)
local costStr=isEnough and cost or FMT.cfmt(FONT_COLOR.eRedColor,cost)

local widget=self.winlua:GetChildWidgetBase(v:getID())
widget:SetChildIcon(0,iconHelper.getIconName(itemid),false)
widget:SetChildText(1,costStr)
end
end
end


function UIFabaoJilianWin:freshOnkeyDropdowns()
local filterType=ITEM_FILTER_TYPE.eStage
local stageDescList=_onekey_filter_desc[filterType]

local descList=table.deepCopy(stageDescList)
local options=table.reverse(descList)
self.Dropdown1:setOption(options)
local len=#stageDescList

local idx=fabaoModel:getFabaoJiLianFilterIdx(filterType)
self.onekeyFilter[filterType]=idx
local reIdx=len-1-idx

self.Dropdown1:setValue(reIdx)

local filterType=ITEM_FILTER_TYPE.eColor
local stageDescList=_onekey_filter_desc[filterType]

local descList=table.deepCopy(stageDescList)
local options=table.reverse(descList)
self.Dropdown2:setOption(options)
local len=#stageDescList

local idx=fabaoModel:getFabaoJiLianFilterIdx(filterType)
self.onekeyFilter[filterType]=idx
local reIdx=len-1-idx

self.Dropdown2:setValue(reIdx)
end

function UIFabaoJilianWin:freshBagDropdowns()
local filterType=ITEM_FILTER_TYPE.eStage
local stageDescList=_bag_filter_desc[filterType]

local descList=table.deepCopy(stageDescList)
local options=table.reverse(descList)
self.Dropdown3:setOption(options)
local len=#stageDescList
local idx=self.bagFilter[filterType]or 0
local reIdx=len-1-idx

self.Dropdown3:setValue(reIdx)

local filterType=ITEM_FILTER_TYPE.eColor
local stageDescList=_bag_filter_desc[filterType]

local descList=table.deepCopy(stageDescList)
local options=table.reverse(descList)
self.Dropdown4:setOption(options)
local len=#stageDescList
local idx=self.bagFilter[filterType]or 0
local reIdx=len-1-idx

self.Dropdown4:setValue(reIdx)
end


function UIFabaoJilianWin:setAttrs()
local attrsCmpList=self.attrsList
local tlen=#attrsCmpList
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local addLv=self.addLv
local jilianlv=item.itemData and item.itemData.jilianlv or 0
local attrlv=jilianlv
local nextLv=jilianlv+self.addLv
local maxlv=fabaoHelper.getJilianMaxLv(self.item.itemguid)
local nextMax=maxlv==nextLv
if nextMax then nextLv=nextLv-1 end

local baseAttrsLookup=fabaoHelper.getJilianBaseAttrsLookup(itemguid,jilianlv)
local addAttrLookup=fabaoConfig.getAddJilianLookupAttrs(item,jilianlv)
local jlAttrPercent=fabaoHelper.getJlAddAttrsPercent(item,jilianlv)
addAttrLookup=attrListHelper.getLookupOnPercent(addAttrLookup,jlAttrPercent,true)

local curAttrLookup=addAttrLookup

local nextBaseAttrsLookup=fabaoHelper.getJilianBaseAttrsLookup(itemguid,nextLv)or{}
local nextaddAttrLookup=fabaoConfig.getAddJilianLookupAttrs(item,nextLv)
local jlAttrPercent=fabaoHelper.getJlAddAttrsPercent(item,nextLv)
nextaddAttrLookup=attrListHelper.getLookupOnPercent(nextaddAttrLookup,jlAttrPercent,true)

local nextAttrLookup=nextaddAttrLookup

local temp={}
for attrType,attrValue in pairs(curAttrLookup)do
local addValue=(nextAttrLookup[attrType]or attrValue)-attrValue
temp[#temp+1]={attrType,attrValue,addValue}
end
local baseLen=#temp

if baseLen>1 then
table.sort(temp,function(a,b)
return a[1]<b[1]
end)
end

for i=1,math.min(baseLen,_maxAttrLine)do
self:fillAttr(attrsCmpList[i],i,temp[i])
end
local useIdx=baseLen

if useIdx<_maxAttrLine then
for i=useIdx+1,tlen do
attrsCmpList[i]:setActive(false)
end
end
self.arrow:setActive(baseLen>=6)
end

function UIFabaoJilianWin:fillAttr(cmpObject,index,attr)
cmpObject:setActive(attr~=nil)
if attr then
local addValue=attr[3]or 0
local widget=self.winlua:GetChildWidgetBase(cmpObject:getID())
local name,valstr,ifMod,flag=equipsHelper.getAttr(attr[1],attr[2])
local valstr=FMT.fmt('{0}：{1}',name,FMT.cfmt(FONT_COLOR.eNomalBlackColor,valstr))
widget:SetChildText(0,valstr)
local handleValue=ifMod and mathHelper.decimal(addValue)or math.floor(addValue)
local hasAdd=handleValue and handleValue>0 or false
widget:SetChildActive(1,hasAdd)
if hasAdd then
local name,valstr=equipsHelper.getAttr(attr[1],addValue)
widget:SetChildText(2,FMT.cfmt(eQualityColor.eGreen,valstr))
else
widget:SetChildText(2,'')
end
end
end

function UIFabaoJilianWin:fillExtraAttr(index,desc,addVal)
local cmpObject=self.attrsList[index]
cmpObject:setActive(true)

local widget=self.winlua:GetChildWidgetBase(cmpObject:getID())
widget:SetChildText(0,desc)
widget:SetChildActive(1,addVal>0)
widget:SetChildText(2,addVal>0 and FMT.cfmt(eQualityColor.eGreen,'{0}%',addVal)or'')
end

function UIFabaoJilianWin:setJlEffects()
local item=self.item
local jilianlv=item.itemData and item.itemData.jilianlv or 0
local nextLv=fabaoConfig.getNextJlTuPolv(jilianlv)
local maxlv=fabaoHelper.getJilianMaxLvByCfg(item.itemid)
if nextLv and nextLv>maxlv then nextLv=nil end
self.effect2attrs:setActive(nextLv~=nil)
if nextLv==nil then return end
local tupoargs=fabaoConfig.getJilianConfig(nextLv+1).tupoargs
local len=#tupoargs
local tupodesc=cfgHelper.getdef1(cfg_disciplefabaojilianconfig,'tupodesc')
for i,v in ipairs(self.effectRoots2)do
local vis=i<=len
v:setActive(vis)
if vis then
local desc=fabaoHelper.getTuPoDescEx(item,tupodesc,tupoargs[i])
local widget=v:getWidgetBase()
widget:SetChildText(0,desc)
widget:SetChildText(1,FMT.fmt('（精炼{0}级）',nextLv+1))
end
end
end

function UIFabaoJilianWin:setTuPoEffects()
local item=self.item
local addLv=self.addLv
local jilianlv=item.itemData and item.itemData.jilianlv or 0
local nextLv=jilianlv+1
local tupoargs=fabaoConfig.getJilianConfig(nextLv).tupoargs
local len=#tupoargs
local tupodesc=cfgHelper.getdef1(cfg_disciplefabaojilianconfig,'tupodesc')
self.effectattrs:setActive(len>0)
for i,v in ipairs(self.effectRoots)do
local vis=i<=len
v:setActive(vis)
if vis then
local desc=fabaoHelper.getTuPoDescEx(item,tupodesc,tupoargs[i])
local widget=v:getWidgetBase()
widget:SetChildText(0,desc)
widget:SetChildText(1,FMT.fmt('（精炼{0}级）',nextLv))
end
end
end

function UIFabaoJilianWin:setTuPoAttrs()
local attrsCmpList=self.tupoAttrsList
local tlen=#attrsCmpList
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local addLv=self.addLv
local jilianlv=item.itemData and item.itemData.jilianlv or 0
local nextLv=jilianlv+1

local baseAttrsLookup=fabaoHelper.getJilianBaseAttrsLookup(itemguid,jilianlv)
local addAttrLookup=fabaoConfig.getAddJilianLookupAttrs(item,jilianlv)
local jlAttrPercent=fabaoHelper.getJlAddAttrsPercent(item,jilianlv)
addAttrLookup=attrListHelper.getLookupOnPercent(addAttrLookup,jlAttrPercent,true)

local curAttrLookup=addAttrLookup

local nextBaseAttrsLookup=fabaoHelper.getJilianBaseAttrsLookup(itemguid,nextLv)or{}
local nextaddAttrLookup=fabaoConfig.getAddJilianLookupAttrs(item,nextLv)
local jlAttrPercent=fabaoHelper.getJlAddAttrsPercent(item,nextLv)
nextaddAttrLookup=attrListHelper.getLookupOnPercent(nextaddAttrLookup,jlAttrPercent,true)

local nextAttrLookup=nextaddAttrLookup

local temp={}
for attrType,attrValue in pairs(curAttrLookup)do
local addValue=(nextAttrLookup[attrType]or attrValue)-attrValue
temp[#temp+1]={attrType,attrValue,addValue}
end
local baseLen=#temp

if baseLen>1 then
table.sort(temp,function(a,b)
return a[1]<b[1]
end)
end

for i=1,math.min(baseLen,_maxAttrLine)do
self:fillAttr(attrsCmpList[i],i,temp[i])
end
local useIdx=baseLen
if useIdx<_maxAttrLine then
for i=useIdx+1,tlen do
attrsCmpList[i]:setActive(false)
end
end
self.arrow1:setActive(baseLen>=6)
end



function UIFabaoJilianWin:setSelectItems()
local selectList=self.selectList or{}
local itemsList=self.itemsList
for i,v in ipairs(itemsList)do
local selectInfo=selectList[i]or{}
local itemguid=selectInfo[1]
local num=selectInfo[2]or 0
local item=itemguid and bagModel.getItem(itemguid)
local conf={showname=false,itemcount=num,showCountBG=true}
v:setChildPropData(self:getSelectFillData(item,conf))
end
end

function UIFabaoJilianWin:setTuPoCostItems()
local jilianlv,itemid,itemguid=self:getJilianInfo()
local needTuPoItems=fabaoConfig.getJilianTuPoCost(jilianlv,itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local itemsList=self.tupoList
for i,v in ipairs(itemsList)do
local costItem=needTuPoItems[i]
v:setActive(costItem~=nil)
if costItem then
local itemid=costItem[1]
local cost=costItem[2]
self.checkList[itemid]=true
local hasNum=itemsModel.getCount(itemid)
local enough=hasNum>=cost
local item={itemid=itemid}
local numStr=enough and(cost>1 and cost or'')or FMT.cfmt(FONT_COLOR.eRedColor,cost)
local grayNum=enough and 0 or hasNum==0 and 3 or 2
local conf={showname=false,itemcount=numStr,showCountBG=numStr~='',gray=grayNum}
v:setChildPropData(self:getSelectFillData(item,conf))
v:setBaseItemClickEvent(function()
if enough then
tipsManager.showTips({itemid=itemid})
else
gainControl:showGainWin(itemid)
end
end)
end
end
end


function UIFabaoJilianWin:getSelectFillData(item,conf)
local prop
if item==nil then
prop=self:getSelectTempFillData()
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=true
else
prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(item.itemid)
local showStage=itemConfig.stage~=nil
prop[PropIndex(DataPropKey.eWidgetActive,8)]=showStage
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
return prop
end


function UIFabaoJilianWin:getSelectTempFillData()
local conf={}
conf.showbg=true
return itemsComponentHelper.getTempFillData(conf)
end

function UIFabaoJilianWin:getNextFillIdx(itemguid)
if self.selectList==nil then self.selectList={}end
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then return index end
for i=1,_fillItemLen do
local info=selectList[i]
if not info then
return i
end
end
end

function UIFabaoJilianWin:isFull()
for i=1,_fillItemLen do
local info=self.selectList[i]
if not info then
return false
end
end
return true
end

function UIFabaoJilianWin:getOtherFillNum(itemguid)
for i=1,_fillItemLen do
local info=self.selectList[i]
if info and tostring(info[1])~=tostring(itemguid)then
return info[2]
end
end
return 0
end

function UIFabaoJilianWin:getCanPutItemNum(itemguid,canOverExp)
local addExp=fabaoHelper.getJilianValue(itemguid,1)

local addTExp=self.addItemExp-self:getAddExp(itemguid)
local needMaxExp=fabaoHelper.getMaxJilianValueOnItem(self.item)
local lastIsFull=addTExp>=needMaxExp
if lastIsFull then
return 0
end
local num=1
local tExp=addTExp+addExp*num
local overExp=tExp-needMaxExp
while overExp<0 do
num=num+1
tExp=addTExp+addExp*num
overExp=tExp-needMaxExp
if not canOverExp and overExp>0 then return num-1 end
if overExp==0 then return num end
end
return num
end

function UIFabaoJilianWin:getCanPutMaxJilianNum(itemguid)
if not self:checkMaxLv(false)then return 0,0 end
local index=self.selectItemsLookup[tostring(itemguid)]
local alreadyNum=0
if not index then
if self:isFull()then return 0,0 end
else
local info=self.selectList[index]or{}
alreadyNum=info[2]or 0
end
local numByExp=self:getCanPutItemNum(itemguid,true)
local item=bagModel.getItem(itemguid)or{}

local hasNum=item.itemcount
return math.min(numByExp,hasNum),alreadyNum
end

function UIFabaoJilianWin:getSelectItemNum(itemguid)
if self.selectList==nil then self.selectList={}end
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
local selectItemsLookup=self.selectItemsLookup
local selectList=self.selectList
local index=selectItemsLookup[tostring(itemguid)]
if index then
local selectTable=selectList[index]or{}
return selectTable[2]or 0
end
return 0
end


function UIFabaoJilianWin:tryPutItem(itemguid,num,canOverExp)
local addTExp=self.addItemExp-self:getAddExp(itemguid)
local needMaxExp=fabaoHelper.getMaxJilianValueOnItem(self.item)
local lastIsFull=addTExp>=needMaxExp
if lastIsFull then
UIManager.error('已达到最大经验，无法添加')
return false
end
return true
end

function UIFabaoJilianWin:setSelectNum(itemguid,index,num)
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
if self.selectList==nil then self.selectList={}end
if num==0 then
self.selectList[index]=nil
self.selectItemsLookup[tostring(itemguid)]=nil
else
self.selectList[index]={itemguid,num}
self.selectItemsLookup[tostring(itemguid)]=index
end
self:freshAddExp()
end

function UIFabaoJilianWin:getSelectIndex(itemguid)
if self.selectItemsLookup==nil then self.selectItemsLookup={}end
if self.selectList==nil then self.selectList={}end
return self.selectItemsLookup[tostring(itemguid)]
end

function UIFabaoJilianWin:hasPutAny()
for i=1,_fillItemLen do
local info=self.selectList[i]
if info and info[1]and info[2]and info[2]>0 then
return true
end
end
return false
end


function UIFabaoJilianWin:showProvideSelectGrids()
if self.showDialogue then return end
self.showDialogue=true
self.selectBg:setActive(true)
self:freshProvideSelectGrids(true)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'1',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
end

function UIFabaoJilianWin:closeProvideSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false
self.curPageIndex=1
self.isSetZero=false
local selectItemguid=self.selectItemguid
self.selectItemguid=nil
self:freshProvideGridSelect(selectItemguid)
self.selectBg:setActive(false)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'2',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
end

function UIFabaoJilianWin:freshBagList()
local filter={}
for k,v in pairs(self.bagFilter)do
if v==0 then
filter[k]=nil
else
filter[k]=v
end
end

local filterguid=self.item.itemguid
filter[ITEM_FILTER_TYPE.eItemguid]={ITEM_FILTER_COMPARE.eNot,{filterguid}}
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eNot,{FABAO_TYPE.eBenMing}}
local fabaoList=bagControl.getBagItemsByFilter(BAG_TYPE.eFabaoBag,filter)


local itemidlist=fabaoHelper.getJilianItemidList()
filter[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,itemidlist}






local materialList=bagControl.getBagItemsByFilter(BAG_TYPE.eMaterialsBag,filter)
local itemList=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter)
local bagList=table.concatTable(fabaoList,materialList,itemList)or{}

local isPutItem=function(itemguid)
for i=1,_fillItemLen do
local info=self.selectList[i]
if info and tostring(info[1])==tostring(itemguid)and info[2]and info[2]>0 then
return true
end
end
end

local list={}
local looupup={}
if#bagList>0 then
for i=#bagList,1,-1 do
local item=bagList[i]
if not looupup[tostring(item.itemguid)]and isPutItem(item.itemguid)then
list[#list+1]=item
looupup[tostring(item.itemguid)]=true
table.remove(bagList,i)
end
end

for i,v in ipairs(list)do
table.insert(bagList,1,v)
end
end
local sortArray={}
for i,v in ipairs(bagList)do
local item=bagList[i]
local itemid=item.itemid
local itemguid=item.itemguid
local jilianlv=item.itemData and item.itemData.jilianlv or 0
local guidStr=tostring(itemguid)
local cfg=itemsConfig.getConfig(itemid)
local color=cfg.color
local stage=cfg.stage
local jilian=jilianlv>=fabaoConfig.getMinTuPoLv()
if itemsConfig.isMaterials(itemid)or itemsConfig.isItem(itemid)then
sortArray[guidStr]=-10000+color
elseif itemsConfig.isFabao(itemid)then
sortArray[guidStr]=1000000+100*stage+color
if jilian then
sortArray[guidStr]=1000000000
end
end
end

table.sort(bagList,function(a,b)
local itemguid_a=tostring(a.itemguid)
local itemguid_b=tostring(b.itemguid)
return sortArray[itemguid_a]<sortArray[itemguid_b]
end)

self.bagList=bagList
end


function UIFabaoJilianWin:getOnekeyFilterList()
local stageDropIdx=self.onekeyFilter[ITEM_FILTER_TYPE.eStage]
local colorDropIdx=self.onekeyFilter[ITEM_FILTER_TYPE.eColor]
local filterStage=stageDropIdx+1
local filterColor=colorDropIdx+1
return fabaoHelper.getJilianMateriasOnBag(self.item.itemguid,filterStage,filterColor)or{}
end


function UIFabaoJilianWin:freshProvideSelectGrids(freshData)
if not self.showDialogue then return end
if freshData then
self:freshBagList()
end
local list=self.bagList
local rNum=#list
local pageNum=_row*_colomn
if rNum<pageNum then rNum=pageNum end
local tRow=math.ceil(rNum/_colomn)
local tPage=math.ceil(rNum/pageNum)
self.tPage=tPage
local curPageIndex=self.curPageIndex
local showNum=curPageIndex*pageNum
local showRow=math.ceil(showNum/_colomn)
if curPageIndex==1 then
self.ScrollView:clearSlowItems()
end
self.ScrollView:freshSlowGrids(showNum,showRow,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UIFabaoJilianWin:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local isTemp=itemInfo==nil
if not isTemp then
local count=itemInfo.itemcount
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(itemInfo)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local num=self:getSelectItemNum(itemguid)
local countStr=num>0 and FMT.fmt('{0}/{1}',itemInfo.itemcount,num)or num<=0 and itemInfo.itemcount
local has=num>0
local showbg=true
local isLock=bagHelper.isLock(itemInfo)
local isFabao=itemsConfig.isFabao(itemid)
local showStage=itemConfig.stage~=nil
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)
widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)

widgetHelper.setItemQulaity(widget,itemid,2)
widget:SetChildIcon(3,iconName,false)
widget:SetChildText(4,countStr)
widget:SetChildActive(5,countStr~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,has)
widget:SetChildButtonClick(9,function()self:onClickGridButton(index,itemid,itemguid)end,true)
widget:SetChildActive(10,isFabao)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
else
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildText(4,'')
widget:SetChildActive(5,false)
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
widget:SetChildActive(10,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIFabaoJilianWin:freshProvideSelectSingleGirid(itemguid,flag,lastIdx)
local idx=lastIdx or self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(9,flag)
end
end
end

function UIFabaoJilianWin:freshProvideGridSelect(itemguid)
if itemguid==nil then return end
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(1,tostring(self.selectItemguid)==tostring(itemguid))
end
end
end

function UIFabaoJilianWin:freshProvideSingleGiridNum(itemguid,lastIdx)
local idx=lastIdx or self:getBagItemIdx(itemguid)
if idx then
local num=self:getSelectItemNum(itemguid)
local item=self.bagList[idx]
local txt=num>0 and FMT.fmt('{0}/{1}',item.itemcount,num)or num<=0 and item.itemcount
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildText(4,txt)
end
end
end

function UIFabaoJilianWin:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i,v
end
end
end
































function UIFabaoJilianWin:refreshPutBtnReddot()
local item=self.item
local itemguid=item.itemguid
local reddot=fabaoHelper.checkFabaoIsCanJiLian(itemguid)
self.putBtnReddot:setActive(reddot)
end


function UIFabaoJilianWin:refreshBtnToPoReddot()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
local isInTuPoLv=fabaoHelper.isInTuPo(itemguid,itemid)
local reddot=false
if isInTuPoLv then
local ret,errType,errArgs=fabaoHelper.isCanTuPo(itemguid)
reddot=ret
end

self.btnTuPoReddot:setActive(reddot)
end


function UIFabaoJilianWin:onDropdownChange(dropidx,reIdx)

local len=#_onekey_filter_desc[dropidx]
local idx=len-1-reIdx
if self.onekeyFilter[dropidx]==idx then return end
self.curPageIndex=1
self.isSetZero=false
self.selectItemguid=nil
self.onekeyFilter[dropidx]=idx
fabaoModel:changeFabaoJiLianFilterIdxByType(dropidx,idx)
self:freshProvideSelectGrids(true)


local win=UIManager:findActiveWindow('UIEquipWin')
if win then
win:freshItemsReddot({checkFabao=true})
end


self:refreshPutBtnReddot()
end


function UIFabaoJilianWin:onDropdownCreate(dropidx,scrollTrans,contentTrans)
local filterType=dropidx

local idx=fabaoModel:getFabaoJiLianFilterIdx(filterType)
self.onekeyFilter[filterType]=idx
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=height-(idx)*_dropItemHeight-_dropViewHeight
else
posY=0
end
if posY<=0 then posY=0 end

contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end


function UIFabaoJilianWin:onBagDropdownChange(dropidx,reIdx)

local len=#_bag_filter_desc[dropidx]
local idx=len-1-reIdx
if self.bagFilter[dropidx]==idx then return end
self.selectItemguid=nil
self.curPageIndex=1
self.isSetZero=false
self.bagFilter[dropidx]=idx
self:freshProvideSelectGrids(true)
end


function UIFabaoJilianWin:onBagDropdownCreate(dropidx,scrollTrans,contentTrans)
local filterType=dropidx
local idx=self.bagFilter[filterType]or 0
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=height-(idx)*_dropItemHeight-_dropViewHeight
else
posY=0
end
if posY<=0 then posY=0 end

contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end

function UIFabaoJilianWin:onItemListChanged(list)
if list==nil then return end
local needRefreshReddot=false
for i,v in ipairs(list)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
if itemsConfig.isMoney(itemid)or fabaoConfig.isJilianItem(itemid)then
needRefreshReddot=true
break
end
end

if needRefreshReddot then
self:refreshPutBtnReddot()
end


self:refreshBtnToPoReddot()
end

function UIFabaoJilianWin:onMoneyChanged(moneyType)
self:refreshPutBtnReddot()

self:refreshBtnToPoReddot()
self:freshCostMoney()
end

function UIFabaoJilianWin:onCostItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
self:onSelectGridItem(itemguid)
end
end

function UIFabaoJilianWin:onSelectGridItem(itemguid)
local lastItemguid=self.selectItemguid
self.selectItemguid=itemguid
if lastItemguid then
self:freshProvideGridSelect(lastItemguid)
end
self:freshProvideGridSelect(itemguid)
end

function UIFabaoJilianWin:onEdgeEvent()

if self.curPageIndex>=self.tPage then return end
self.curPageIndex=self.curPageIndex+1
self:freshProvideSelectGrids()
end

function UIFabaoJilianWin:onSelectItemClick(itemid,index,itemguid,attach)
self:showProvideSelectGrids()
end

function UIFabaoJilianWin:onSelectBg()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UIFabaoJilianWin:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
if itemsConfig.isFabao(itemid)then
local item=fabaoHelper.getFabao(itemguid)
local jilianlv=item.itemData and item.itemData.jilianlv or 0
if jilianlv>=fabaoConfig.getMinTuPoLv()then
UIManager.info('突破的法宝无法用于精炼，请先进行熔炼')
return
end
end
local max,fill=self:getCanPutMaxJilianNum(itemguid)
local hasNum=fill>0
local min=1

local val=max
tipsManager.showTips({formType=TIPS_FORM_TYPE.eFabaoJilian,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,selectNumCmpArgs={min=min,max=max,val=val}}})
self:onSelectGridItem(itemguid)
end

function UIFabaoJilianWin:putItem(index,itemid,itemguid,putnum)
if itemid==-1 then return end
if not self:checkMaxLv(true)then
return
end
local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('精炼材料栏已满')
tipsManager.closeTips()
return
end
if not self:tryPutItem(itemguid,putnum,true)then
return
end
local num=self:getSelectItemNum(itemguid)
if putnum==num then
if putnum>0 then
UIManager.info('该道具已放入')
end
return
end
local lastNum=num
if lastNum==0 then
self:freshProvideSelectSingleGirid(itemguid,true)
elseif putnum==0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
num=putnum
self:setSelectNum(itemguid,fillIdx,num)
self:freshProvideSingleGiridNum(itemguid)
self:freshRight()
tipsManager.closeTips()
end

function UIFabaoJilianWin:onClickGridButton(itemid,index,itemguid,attach)
if itemid==-1 then return end
local num=self:getSelectItemNum(itemguid)
if num<=0 then
UIManager.error('物品已达下限')
return
end
num=num-1
local selectIdx=self:getSelectIndex(itemguid)
self:setSelectNum(itemguid,selectIdx,num)
if num<=0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
self:freshProvideSingleGiridNum(itemguid)
self:freshRight()
end








function UIFabaoJilianWin:onClickBg()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UIFabaoJilianWin:onJilianClick()
local item=self.item
local itemguid=item.itemguid
local itemid=item.itemid
local selectItems=self.selectList
local itemsTemp={}
local fabaosTemp={}
local flag=false
for k,v in pairs(selectItems)do
local itemguid=v[1]
local num=v[2]
local item=bagModel.getItem(itemguid)
local temp={itemguid,num}
if itemsConfig.isItem(item.itemid)then
itemsTemp[#itemsTemp+1]=temp
else
fabaosTemp[#fabaosTemp+1]=itemguid
end
flag=true
end
if flag==false then
UIManager.error('请放入精炼材料')
return
end
local jilianlv=item.itemData and item.itemData.jilianlv or 0
local isTuPoLv=fabaoConfig.isJilianTuPoLv(jilianlv,itemid)
local ret,errType,errArgs=fabaoHelper.isCanJilian(itemguid,self.addItemExp)
if not ret then
if errType==fabaoHelper.jilianErr.eNotEnoughItem then
local itemid=errArgs[1]
local name=itemsModel.getName(itemid)
if not isTuPoLv then
UIManager.error(FMT.fmt('{0}不足，不可精炼',name))
else
UIManager.error(FMT.fmt('{0}不足，不可突破',name))
end
gainControl:showGainWin(itemid)
elseif errType==fabaoHelper.jilianErr.eLevelToCap then
UIManager.error('法宝精炼等级达到上限')
end
return
end
local pos=0
local guid=itemguid
if self.isEquip then
guid=fabaoModel.getDiziguidByItemguid(itemguid)
pos=1
end
local callback=function()
fabaoProtocolControl.reqJilianFabao(guid,pos,itemsTemp,fabaosTemp)
end





callback()

end


function UIFabaoJilianWin:onPutClick()
if not self:checkMaxLv(true)then
return
end
local filterList=self:getOnekeyFilterList()
local insertList=self.selectList or{}
local list,errType,errArgs=self:getJilianMetrials(self.item,filterList,insertList,_fillItemLen)
if list and#list>0 then
for _,v in ipairs(list)do
local itemguid=v[1]
local num=v[2]
local idx=self:getNextFillIdx(itemguid)
self:setSelectNum(itemguid,idx,num)
self:freshProvideSelectSingleGirid(itemguid,true)
end
self:freshRight()
else
if errType==fabaoHelper.jilianErr.eNotMaterials then
UIManager.error('没有材料可放入')
local itemid=fabaoConfig.getdefaultJinglianItem()
gainControl:showGainWin(itemid)
elseif errType==fabaoHelper.jilianErr.eNotEnoughItem then
local itemid=errArgs[1]
local name=itemsModel.getName(itemid)
UIManager.error(FMT.fmt('{0}不足，不可精炼',name))
gainControl:showGainWin(itemid)
elseif errType==fabaoHelper.jilianErr.eNotPos then
UIManager.error('精炼材料栏已满')
elseif errType==fabaoHelper.jilianErr.eExpOver then
UIManager.error('已达到最大经验，无法添加')
end
end
end

function UIFabaoJilianWin:onBtnReset()
if self:hasPutAny()then
local selectList=table.deepCopy(self.selectList)
local leftList=table.deepCopy(self.leftList)
self:resetData()
for _,v in pairs(selectList)do
local itemguid=v[1]
local lastIdx=leftList[tostring(itemguid)]
self:freshProvideSelectSingleGirid(itemguid,false,lastIdx)
self:freshProvideSingleGiridNum(itemguid,lastIdx)
end
self:freshRight()
end
end

function UIFabaoJilianWin:onHelp()
local offset=Vector2.New(-15,15)
local descTable={}
for i=1,10 do
local desc=cfg_lang_get(FMT.fmt('fabao_jinglian_readtips_{0}',i),false)
if desc then
descTable[#descTable+1]=desc
else
break
end
end
UIManager:showWindow('UIConditionTipsTwo',{showType=eArrowDirectionType.eBottomLeft,
descTable=descTable,
posItem=self.help,
pos=offset,
closeCall=function()
if self and not self.isClose then
self.help:setActive(true)
self.helpO:setActive(false)
end
end})
self.help:setActive(false)
self.helpO:setActive(true)
end

function UIFabaoJilianWin:onBtnTuPo()
local item=self.item
local itemid=item.itemid
local itemguid=item.itemguid
local jilianlv=item.itemData and item.itemData.jilianlv or 0
local isTuPoLv=fabaoConfig.isJilianTuPoLv(jilianlv,itemid)
local ret,errType,errArgs=fabaoHelper.isCanTuPo(itemguid,true)
if not ret then
if errType==fabaoHelper.jilianErr.eNotEnoughItem then
local itemid=errArgs[1]
local name=itemsModel.getName(itemid)
if not isTuPoLv then
UIManager.error(FMT.fmt('{0}不足，不可精炼',name))
else
UIManager.error(FMT.fmt('{0}不足，不可突破',name))
end
gainControl:showGainWin(itemid)
elseif errType==fabaoHelper.jilianErr.eLevelToCap then
UIManager.error('法宝精炼等级达到上限')
end
return
end
local pos=0
local guid=itemguid
if self.isEquip then
guid=fabaoModel.getDiziguidByItemguid(itemguid)
pos=1
end
fabaoProtocolControl.reqTuPoFabao(guid,pos)
end

function UIFabaoJilianWin:onEffectBtn()
self:showTuPoEffectWin()
end

function UIFabaoJilianWin:onJilian(oldlv,newlv)
if newlv~=oldlv and self.overExp==0 then
self.winlua:SetChildShowEffect(self.effect:getID(),10060,true)
end
self:startBehavior()
self:resetData()
self:freshInfo()
self:freshProvideSelectGrids(true)
end

function UIFabaoJilianWin:onJilianReset()
self.winlua:SetChildShowEffect(self.effect:getID(),10060,true)
self:resetData()
self:freshInfo()
self:freshProvideSelectGrids(true)
end

function UIFabaoJilianWin:checkMaxLv(warn)
local upItem=self.item
local jilianlv=upItem.itemData and upItem.itemData.jilianlv or 0
local maxlv=fabaoHelper.getJilianMaxLv(self.item.itemguid)
if jilianlv>=maxlv then
if warn then
UIManager.error('法宝精炼等级达到上限')
end
return false
end
return true
end

function UIFabaoJilianWin:startBehavior()
local flag=0
for i=1,_fillItemLen do
local info=self.selectList[i]
if info then
flag=flag+math.pow(2,i-1)
end
end
local target0=self.effect0:getID()
local target1=self.effect1:getID()
local target2=self.effect2:getID()
local target3=self.effect3:getID()
local target4=self.effect4:getID()
local target5=self.effect5:getID()

local parent=self.effectRoot:getID()
local pos=self.winlua:GetChildPosition(target0)
local v0=Vector2.New(0,0)
local initData=
{
stateId=flag,
widget=self.winlua,
target0=target0,
target1=target1,
target2=target2,
target3=target3,
target4=target4,
target5=target5,
parent=parent,
pos=pos,
duration1=1,
duration2=1.1,
duration3=1.2,
duration4=1.3,
duration5=1.4,


eSlider1=Vector2.New(0.3,0.4),
oSlider1=Vector2.New(0.3,0.4),

eSlider2=Vector2.New(0.1,0.2),
oSlider2=Vector2.New(0.1,0.2),

eSlider3=Vector2.New(0,0),
oSlider3=Vector2.New(0,0),

eSlider4=Vector2.New(-0.1,-0.2),
oSlider4=Vector2.New(-0.1,-0.2),

eSlider5=Vector2.New(-0.3,-0.4),
oSlider5=Vector2.New(-0.3,-0.4),
}
self:stopBehavior()
self.bt=behaviorManager:addBehaviorTree('bt_ui_equip_jinglian_fly',nil,true,initData)

end

function UIFabaoJilianWin:stopBehavior()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end

function UIFabaoJilianWin:onCloseSelect()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UIFabaoJilianWin:onCloseBtn()


end



function UIFabaoJilianWin:getJilianMetrials(item,list,insertlist,maxLen)


if list==nil or#list<=0 then
return false,fabaoHelper.jilianErr.eNotMaterials
end



local leftList={}
local tempList={}
local itemLen=#list
for i=1,maxLen do
if insertlist[i]==nil then
tempList[#tempList+1]=i
end
end
local inertLen=#tempList
if inertLen==0 then
return false,fabaoHelper.jilianErr.eNotPos
end

for i,v in ipairs(list)do
local guidStr=tostring(v.itemguid)
leftList[guidStr]=v.itemcount
end

local checkLeft=function(guidStr,num)
if leftList[guidStr]then
leftList[guidStr]=leftList[guidStr]-num
if leftList[guidStr]<=0 then
leftList[guidStr]=nil
end
end
end

local idxList={}
local fillList={}
local totalExp=0
local hasNumList={}
local useHoleLen=0
local holeIdxList={}

for i,v in pairs(insertlist)do
useHoleLen=useHoleLen+1
local itemguid=v[1]
local guidStr=tostring(itemguid)
local num=v[2]
local hasExp=fabaoHelper.getJilianValue(itemguid,num)
totalExp=totalExp+hasExp
hasNumList[guidStr]=num
fillList[guidStr]={itemguid,num}
idxList[guidStr]=i
holeIdxList[i]=true
checkLeft(guidStr,num)
end

local needMaxExp=fabaoHelper.getMaxJilianValueOnItem(item)
if totalExp>=needMaxExp then
local level=fabaoModel.getFabaoJilianLevel(item.itemguid)
local maxLv=fabaoHelper.getJilianMaxLv(item.itemguid)
if needMaxExp<0 and level<maxLv then
local temp=table.deepCopy(list)
local sortTag={}
for i,v in ipairs(temp)do
local exp=fabaoHelper.getJilianValue(v.itemguid,1)
sortTag[tostring(v.itemguid)]=exp*10000+i
end

table.sort(temp,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)
local minitem=temp[1]
needMaxExp=fabaoHelper.getJilianValue(minitem.itemguid,1)
else
return false,fabaoHelper.jilianErr.eExpOver
end
end

local sortTag={}
local temp=table.deepCopy(list)
for i,v in ipairs(temp)do
local exp=fabaoHelper.getJilianValue(v.itemguid,1)
sortTag[tostring(v.itemguid)]=itemsConfig.getMainType(v.itemid)*-10000000+exp*100-i
end


table.sort(temp,function(a,b)
return sortTag[tostring(a.itemguid)]>sortTag[tostring(b.itemguid)]
end)


local _getNextHole=function()
for i=1,maxLen do
if not holeIdxList[i]then
return i
end
end
end

local putAny=false
local _putItem=function(itemguid,oneExp,holeIdx,over)
local exp=totalExp+oneExp
if not over then
if exp>needMaxExp then
return false,fabaoHelper.jilianErr.eExpOver
end
end
local ret,args=fabaoHelper.checkCostMoney(exp)
if not ret then
return false,fabaoHelper.jilianErr.eNotEnoughItem,args
end
local guidStr=tostring(itemguid)
local lastNum=(fillList[guidStr]or{})[2]or 0
lastNum=lastNum+1
if holeIdxList[holeIdx]==nil then
holeIdxList[holeIdx]=true
useHoleLen=useHoleLen+1
end
idxList[guidStr]=holeIdx
fillList[guidStr]={itemguid,lastNum}
totalExp=totalExp+oneExp
checkLeft(guidStr,1)
putAny=true
return true
end
local compelementInfo={}
local expLookup={}
for i,v in ipairs(temp)do
if totalExp>=needMaxExp then break end
local itemguid=v.itemguid
local guidStr=tostring(itemguid)
local hasNum=hasNumList[guidStr]or 0
local alreadyPut=hasNum>0
local leftCount=v.itemcount-hasNum
local holeIdx=idxList[guidStr]
if not alreadyPut then
if(useHoleLen+1)>inertLen then break end
holeIdx=_getNextHole()
end
if holeIdx then
local oneExp=fabaoHelper.getJilianValue(itemguid,1)
local canPutExp=needMaxExp-totalExp
if canPutExp>0 then
if leftCount>0 then
local num=0
local nowLeft=leftCount
for i=1,leftCount do
local ret,err=_putItem(itemguid,oneExp,holeIdx,false)
if not ret then
break
else
num=num+1
nowLeft=nowLeft-1
end
end
if totalExp>=needMaxExp then break end
if num<leftCount then
local errType
if(useHoleLen==maxLen or useHoleLen==itemLen)then
for j=num+1,leftCount do
local ret,err=_putItem(itemguid,oneExp,holeIdx,true)
if ret then
nowLeft=nowLeft-1
else
errType=err
break
end
if totalExp>=needMaxExp then break end
end
end
if nowLeft>0 then
if not expLookup[oneExp]then
expLookup[oneExp]=true
compelementInfo[#compelementInfo+1]={oneExp,itemguid,holeIdx}
end
end
end
end
else
break
end
end
end
local errType=fabaoHelper.jilianErr.eExpOver
local retArgs=nil

if#compelementInfo>0 and totalExp<needMaxExp then
table.sort(compelementInfo,function(a,b)
return a[1]<b[1]
end)
local ret=false
for i,v in ipairs(compelementInfo)do
if totalExp>=needMaxExp then break end
local hasNum=hasNumList[tostring(v[2])]or 0
if hasNum>0 or useHoleLen<inertLen then
local r,err,args=_putItem(v[2],v[1],v[3],true)
retArgs=args
ret=r
errType=err
break
end
end
end
if putAny==false then
if next(leftList)==nil then
return false,fabaoHelper.jilianErr.eNotMaterials
else
return false,errType,retArgs
end
end
local finalList={}
for key,v in pairs(fillList)do
finalList[idxList[key]]=v
end

return finalList
end

function UIFabaoJilianWin:showTuPoEffectWin()
local args={}
args.titleName="精炼突破效果"
args.pos=1
args.extraWin='UIFabaoTuPoEffectWin'
local extraParams={}
extraParams.itemguid=self.item.itemguid
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UIFabaoJilianWin:onJingLianResetBtn()
local jilianlv,itemid,itemguid,jilianexp=self:getJilianInfo()
if jilianlv>0 or jilianexp>0 then
self:showWindow('UIFabaoJingLianResetTipsWin',{itemguid=self.item.itemguid})
else
UIManager.error("法宝未精炼过，无需重置")
end

end
