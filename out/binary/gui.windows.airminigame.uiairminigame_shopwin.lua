







def_class("UIAirMiniGame_shopWin",UIWindowBase)









function UIAirMiniGame_shopWin:bindComponents()

self.mask=UIObject.get(self,0)
self.itemRefreshBtn=UIButton.get(self,1)
self.bagBtn=UIButton.get(self,2)
self.continueBtn=UIButton.get(self,3)
self.goodGridGroup=UIObject.get(self,4)
self.equipGridGroup=UIObject.get(self,5)
self.moneyRoot=UIObject.get(self,6)
self.moneyBtn=UIButton.get(self,7)
self.bgModel=UIObject.get(self,8)
self.fgModel=UIObject.get(self,9)
self.moneyRefreshBtn=UIButton.get(self,10)
self.itemCostIcon=UIObject.get(self,11)
self.itemCostCountText=UIText.get(self,12)
self.moneyCostIcon=UIImage.get(self,13)
self.moneyCostCountText=UIText.get(self,14)
self.clickMask=UIObject.get(self,15)
self.helpBtn=UIButton.get(self,16)
self.equipReddotGroup=UIObject.get(self,17)

self.itemRefreshBtn:setButtonClick(function()self:onItemRefreshBtn()end)

self.bagBtn:setButtonClick(function()self:onBagBtn()end)

self.continueBtn:setButtonClick(function()self:onContinueBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.moneyRefreshBtn:setButtonClick(function()self:onMoneyRefreshBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)



end


function UIAirMiniGame_shopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.itemRefreshBtn);self.itemRefreshBtn=nil;
_UIObject_release(self.bagBtn);self.bagBtn=nil;
_UIObject_release(self.continueBtn);self.continueBtn=nil;
_UIObject_release(self.goodGridGroup);self.goodGridGroup=nil;
_UIObject_release(self.equipGridGroup);self.equipGridGroup=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.fgModel);self.fgModel=nil;
_UIObject_release(self.moneyRefreshBtn);self.moneyRefreshBtn=nil;
_UIObject_release(self.itemCostIcon);self.itemCostIcon=nil;
_UIObject_release(self.itemCostCountText);self.itemCostCountText=nil;
_UIObject_release(self.moneyCostIcon);self.moneyCostIcon=nil;
_UIObject_release(self.moneyCostCountText);self.moneyCostCountText=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.equipReddotGroup);self.equipReddotGroup=nil;
end















local _this
local goodItemCmpIndex={
itemName=0,
item=1,
itemType=2,
attrLayout=3,
priceText=4,
priceIcon=5,
buyBtn=6,
levelUpBtn=7,
selloutFlag=8,
descTitleText=9,
descText=10,
levelUpModel=11,
levelUpKuangModel=12,
bg_item=13,
bg_equip=14,
line_item=15,
line_equip=16,
attrPanel=17,
itemDescText=18,
lockBtn=19,
unlockFlag=20,
lockFlag=21,
}
local oppositeAttrList={
[aiAttributeType.ePriceReduct]=true,
[aiAttributeType.eRecvDamage]=true,
}



function UIAirMiniGame_shopWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIAirMiniGame_shopWin:__delete()
shaderHelper.enableCurvedWorld(true)
_this=nil
self:unbindComponents()
end




function UIAirMiniGame_shopWin:onShow(argtable,afterOnloaded)
shaderHelper.enableCurvedWorld(false)
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5504,1,{},eAnimationID.stand)
self.winlua:SetChildUIModelShowTarget(self.fgModel:getID(),5503,1,{},eAnimationID.stand)
end
self:refresh(true)
end


function UIAirMiniGame_shopWin:onHide()

end

function UIAirMiniGame_shopWin:refresh(isInit,ignoreFade)

self:refreshEquipList()


self:refreshMoney()


self:refreshBtnPanel()

self:clearFadeTweener()

if not ignoreFade then
local fun=function()
if not _this then return end

self:refreshGoodsList()


self.goodGridGroup:setChildCanvasGroupAlpha(0)
self.fadeTweener=self.goodGridGroup:setChildCanvasGroupDOFade(1,0.5)
self.clickMask:setActive(false)
self.isInFade=nil
end

if not isInit then

self.clickMask:setActive(true)
self.goodGridGroup:setChildCanvasGroupAlpha(1)
self.fadeTweener=self.goodGridGroup:setChildCanvasGroupDOFade(0,0.5,fun)
self.isInFade=true
else
return fun()
end
else

self:refreshGoodsList()

self.goodGridGroup:setChildCanvasGroupAlpha(1)
self.clickMask:setActive(false)
self.isInFade=nil
end

end

function UIAirMiniGame_shopWin:refreshGoodsList()

local processData=airModel:getActorProcessData()
local goodRandIdList=processData.settlementData and processData.settlementData.goodsList or nil
if not goodRandIdList then
return
end

self.goodGridGroup:setChildLayoutGroupCreateItems(#goodRandIdList,function(index)
if _this==nil then return end
local widget=self.goodGridGroup:getChildLayoutGroupGridItem(index-1)
local goodRandId=goodRandIdList[index]
if goodRandId then
widget:SetChildActive(-1,true)
local goodCfg=cfgHelper.get(cfg_airrandshopconfig_get,goodRandId)
local itemId=goodCfg.itemId
local itemType=goodCfg.itemType
local itemCfg
local itemTypeStr=''
local descTitleStr=''
local iconName=''
local priceNum=airController:getItemBuyOrSellPrice(itemId,itemType,1,true)
if itemType==1 then

itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
local weaponTypeCfg=cfgHelper.get(cfg_airweapontypeconfig_get,itemCfg.type1)
local weaponTypeStr=weaponTypeCfg.name
itemTypeStr=FMT.fmt("武器·{0}",weaponTypeStr)
descTitleStr="武器效果"

elseif itemType==2 then

itemCfg=cfgHelper.get(cfg_airitemconfig_get,itemId)
itemTypeStr="宝物"
descTitleStr="宝物效果"

end

widget:SetChildActive(goodItemCmpIndex.bg_equip,itemType==1)
widget:SetChildActive(goodItemCmpIndex.line_equip,itemType==1)
widget:SetChildActive(goodItemCmpIndex.bg_item,itemType==2)

iconName=FMT.fmt("icon_item_{0}",itemCfg.icon)
local itemName=itemCfg.name
local itemColor=itemCfg.color

widget:SetChildText(goodItemCmpIndex.itemName,itemName)

widget:SetChildText(goodItemCmpIndex.itemType,itemTypeStr)


local itemWidget=widget:GetChildWidgetBase(goodItemCmpIndex.item)
local prop={}
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetText,3)]=''
prop[PropIndex(DataPropKey.eWidgetText,4)]=''
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
self:onClickGoodsItem(itemId,itemType)
end)


local itemAttrList=airController:getItemSortAttrList(itemId,itemType)
local attrCount=#itemAttrList
widget:SetChildLayoutGroupCreateItems(goodItemCmpIndex.attrLayout,attrCount,function(i)
local attrWidget=widget:GetChildLayoutGroupGridItem(goodItemCmpIndex.attrLayout,i-1)
local attr=itemAttrList[i]
local attrId=attr.attrId
local attrName
local attrValStr
if attrId then
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
attrName=attrCfg.attrname
if itemType==1 then
attrValStr=airController:getAttrStr(attrId,attr.attrVal)
elseif itemType==2 then
if not attr.isPercent then
attrValStr=airController:getAttrStr(attrId,attr.attrVal)
else

local percent=math.floor(attr.attrVal/100)
attrValStr=FMT.fmt("{0}%",percent)
end
end
elseif attr.attrName then
attrName=attr.attrName
local relevantAttrId=attr.relevantAttrId
attrValStr=mathHelper.formatNumber(math.floor(attr.attrVal))

if relevantAttrId==aiAttributeType.eAttckSpeed then
local attrVal=mathHelper.decimal(attr.attrVal,1)
attrValStr=FMT.fmt("{0}秒",attrVal)
end
end

if attr.attrVal>=0 then
if itemType==2 then
attrValStr=FMT.fmt("+{0}",attrValStr)
end

if oppositeAttrList[attrId]then

attrValStr=FMT.cfmt(FONT_COLOR.eRedColor,attrValStr)
end
elseif not oppositeAttrList[attrId]then
attrValStr=FMT.cfmt(FONT_COLOR.eRedColor,attrValStr)
end
attrWidget:SetChildText(0,attrName)
attrWidget:SetChildText(1,attrValStr)
end)


local descStr=self:getGoodsDescStr(itemId,itemType)
local isShowDescTitle=itemType==1 and descStr~=nil
widget:SetChildActive(goodItemCmpIndex.descTitleText,isShowDescTitle)
if descStr then

if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
descStr=string.gsub(descStr," ","\194\160")
end
widget:SetChildActive(goodItemCmpIndex.descText,itemType==1)
widget:SetChildActive(goodItemCmpIndex.itemDescText,itemType==2)
if itemType==1 then
widget:SetChildText(goodItemCmpIndex.descTitleText,descTitleStr)
widget:SetChildText(goodItemCmpIndex.descText,descStr)
elseif itemType==2 then
widget:SetChildText(goodItemCmpIndex.itemDescText,descStr)
local posY=attrCount>0 and-39 or 0
widget:SetChildAnchoredPos(goodItemCmpIndex.itemDescText,0,posY)
end
else
widget:SetChildActive(goodItemCmpIndex.descText,false)
widget:SetChildActive(goodItemCmpIndex.itemDescText,false)
end


local priceIconName=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyIcon")
widget:SetChildIcon(goodItemCmpIndex.priceIcon,priceIconName,false)
local moneyCount=airModel:getMoney()
local priceStr=tostring(priceNum)
if moneyCount<priceNum then
priceStr=FMT.cfmt(FONT_COLOR.eRedColor,priceStr)
end
widget:SetChildText(goodItemCmpIndex.priceText,priceStr)

local isSellOut=false
local processData=airModel:getActorProcessData()
local settlementData=processData and processData.settlementData or{}
if settlementData and settlementData.boughtIndexList and settlementData.boughtIndexList[index]then
isSellOut=true
end

local isLevelUp=false
if itemType==1 then

local isFull=airActorSystem:checkActorEquipIsFull()
if isFull then

isLevelUp=airController:isEquipCanHeCheng(itemId)
end
end
widget:SetChildActive(goodItemCmpIndex.selloutFlag,isSellOut)
widget:SetChildActive(goodItemCmpIndex.buyBtn,not isSellOut and not isLevelUp)
widget:SetChildActive(goodItemCmpIndex.levelUpBtn,not isSellOut and isLevelUp)
widget:SetChildActive(goodItemCmpIndex.priceText,not isSellOut)
if not isSellOut then
if not isLevelUp then
widget:SetChildButtonClick(goodItemCmpIndex.buyBtn,function()
self:onGoodsBuyBtnClick(index,itemId,itemType)
end,true)
else
widget:SetChildButtonClick(goodItemCmpIndex.levelUpBtn,function()
self:onGoodsLevelUpBtnClick(index,itemId)
end,true)
end
end

if not isSellOut and isLevelUp then
widget:SetChildUIModelShowTarget(goodItemCmpIndex.levelUpModel,5505,1,nil,eAnimationID.stand)
widget:SetChildUIModelShowTarget(goodItemCmpIndex.levelUpKuangModel,5509,1,nil,eAnimationID.stand)
widget:SetChildActive(goodItemCmpIndex.levelUpModel,true)
widget:SetChildActive(goodItemCmpIndex.levelUpKuangModel,true)
else
widget:SetChildUIModelRemoveTarget(goodItemCmpIndex.levelUpModel)
widget:SetChildUIModelRemoveTarget(goodItemCmpIndex.levelUpKuangModel)
widget:SetChildActive(goodItemCmpIndex.levelUpModel,false)
widget:SetChildActive(goodItemCmpIndex.levelUpKuangModel,false)
end


if not isSellOut then
widget:SetChildActive(goodItemCmpIndex.lockBtn,true)
widget:SetChildButtonClick(goodItemCmpIndex.lockBtn,function()
self:onGoodsLockBtnClick(index,goodRandId)
end,true)

local isLock=airModel:checkGoodsIsLockByIndex(index)
widget:SetChildActive(goodItemCmpIndex.lockFlag,isLock)
widget:SetChildActive(goodItemCmpIndex.unlockFlag,not isLock)

else

widget:SetChildActive(goodItemCmpIndex.lockBtn,false)
end
else
widget:SetChildActive(-1,false)
end
end)
end

function UIAirMiniGame_shopWin:refreshEquipList()
local equipList=airModel:getEquipList()or{}
local equipGrids=self.equipGridGroup:getChildCommonLayoutGroupWidgetList()
local reddotGrids=self.equipReddotGroup:getChildCommonLayoutGroupWidgetList()
local isFull=airActorSystem:checkActorEquipIsFull()
for i=1,equipGrids.Count do
local widget=equipGrids[i-1]
local reddotWidget=reddotGrids[i-1]
local itemId=equipList[i]

if itemId then
local itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)

local prop={}
local iconName=FMT.fmt("icon_item_{0}",itemCfg.icon)
local itemColor=itemCfg.color
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetText,3)]=''
prop[PropIndex(DataPropKey.eWidgetText,4)]=''
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false
widget:SetChildActive(0,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickBagEquipItem(i,itemId)
end)


local reddot=false
if isFull then
reddot=airController:isEquipCanHeCheng(itemId,i)
end
if reddotWidget then
reddotWidget:SetChildActive(0,reddot)
end
else
widget:SetChildActive(0,false)
if reddotWidget then
reddotWidget:SetChildActive(0,false)
end
end
end
end

function UIAirMiniGame_shopWin:onEquipLevelUp(equipIndex)
local widget=self.equipGridGroup:getChildCommonLayoutGroupWidgetItem(equipIndex-1)

widget:SetChildShowEffect(2,10219,true)
end

function UIAirMiniGame_shopWin:refreshMoney()
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyVal=airModel:getMoney()
local moneyIconName=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyIcon")
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,moneyIconName,false)
widget:SetChildText(1,moneyStr)
end

function UIAirMiniGame_shopWin:getGoodsDescStr(itemId,itemType)
local itemCfg
local descStr
if itemType==1 then
itemCfg=cfgHelper.get(cfg_airweaponconfig_get,itemId)
descStr=itemCfg.tipsDesc
local descParams=itemCfg.descParams
local valList={}
if descParams then
for i,v in ipairs(descParams)do
local valParams=v
local originalVal=valParams[1]
local val=originalVal
valList[#valList+1]=val
end
end

descStr=FMT.fmt(descStr,unpack(valList))
elseif itemType==2 then
itemCfg=cfgHelper.get(cfg_airitemconfig_get,itemId)
descStr=itemCfg.desc
end

return descStr
end

function UIAirMiniGame_shopWin:refreshBtnPanel()

self.refreshCost=airController:getShopGoodsRefreshCost()
local moneyIconName=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyIcon")
if moneyIconName then
self.moneyCostIcon:setImageIcon(moneyIconName,false)
end
local costStr=tostring(self.refreshCost)
local moneyCount=airModel:getMoney()
if moneyCount<self.refreshCost then
costStr=FMT.cfmt(FONT_COLOR.eRedColor,costStr)
end
self.moneyCostCountText:setText(costStr)



local isShowCostRefreshBtn=false
self.itemRefreshBtn:setActive(isShowCostRefreshBtn)

if isShowCostRefreshBtn then

local maxRefreshNum=cfgHelper.get(cfg_aircommonconfig_get,1,"costMaxRefreshNum")
if maxRefreshNum then

local processData=airModel:getActorProcessData()
local refreshCount=processData and processData.settlementData and processData.settlementData.shopGoodsRefreshCount_itemCost or 0
self.itemCostCountText:setText(FMT.fmt("{0}/{1}",maxRefreshNum-refreshCount,maxRefreshNum))
end
end


self.moneyRefreshBtn:setActive(not isShowCostRefreshBtn)
end

function UIAirMiniGame_shopWin:refreshGoodsPrice()

local processData=airModel:getActorProcessData()
local goodRandIdList=processData.settlementData and processData.settlementData.goodsList or nil
if not goodRandIdList then
return
end

local grids=self.goodGridGroup:getChildLayoutGroupGridList()
for index=1,grids.Count do
local widget=grids[index-1]
local goodRandId=goodRandIdList[index]
if goodRandId then
widget:SetChildActive(-1,true)
local goodCfg=cfgHelper.get(cfg_airrandshopconfig_get,goodRandId)
local itemId=goodCfg.itemId
local itemType=goodCfg.itemType
local priceNum=airController:getItemBuyOrSellPrice(itemId,itemType,1,true)


local priceIconName=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyIcon")
widget:SetChildIcon(goodItemCmpIndex.priceIcon,priceIconName,false)
widget:SetChildText(goodItemCmpIndex.priceText,priceNum)
else
widget:SetChildActive(-1,false)
end
end

end

function UIAirMiniGame_shopWin:clearFadeTweener()
if self.fadeTweener then
self.fadeTweener:Complete()
self.fadeTweener:Kill()
self.fadeTweener=nil
end
end


function UIAirMiniGame_shopWin:checkIsCanShowCostRefreshBtn()
local costParams=cfgHelper.getdef(cfg_airfubenconfig,'flush_consume')
local costItemId=costParams and costParams[1]or nil
if not costItemId then
return false
end


local maxRefreshNum=cfgHelper.get(cfg_aircommonconfig_get,1,"costMaxRefreshNum")
if maxRefreshNum then

local processData=airModel:getActorProcessData()
local refreshCount=processData and processData.settlementData and processData.settlementData.shopGoodsRefreshCount_itemCost or 0
if refreshCount>=maxRefreshNum then
return false
end
end


local itemNum=bagModel.getItemCountById(costItemId)
local uesNum=costParams and costParams[2]or 1
if not itemNum or itemNum<uesNum then
return false
end

return true
end




function UIAirMiniGame_shopWin:onItemRefreshBtn()
if self.isInFade then
return
end


local lockList=airModel:getShopLockGoodsList()
if lockList and next(lockList)then
local maxLockCount=4
local count=0
for idx,randId in pairs(lockList)do
count=count+1
end

if count>=maxLockCount then
UIManager.error("当前商品已全部锁定，无法刷新")
return
end
end

local costParams=cfgHelper.getdef(cfg_airfubenconfig,'flush_consume')
local costItemId=costParams and costParams[1]or nil
if not costItemId then
return
end


local maxRefreshNum=cfgHelper.get(cfg_aircommonconfig_get,1,"costMaxRefreshNum")
if maxRefreshNum then

local processData=airModel:getActorProcessData()
local refreshCount=processData and processData.settlementData and processData.settlementData.shopGoodsRefreshCount_itemCost or 0
if refreshCount>=maxRefreshNum then
UIManager.error("刷新次数不足，无法刷新")
return
end
end


local itemNum=bagModel.getItemCountById(costItemId)
local uesNum=costParams and costParams[2]or 1
if not itemNum or itemNum<uesNum then
local itemName=itemsConfig.getItemName(costItemId)
UIManager.error("{0}不足，无法刷新",itemName)
return
end


airController:refreshShopGoodsData(nil,2)
end



function UIAirMiniGame_shopWin:onBagBtn()
self:showWindow("UIAirMiniGame_bagWin")
end



function UIAirMiniGame_shopWin:onContinueBtn()

airLevelSystem:startNextLevel()


local processData=airModel:getActorProcessData()

airController:setIsOnlyRefreshWinFlag(true)
processData.checkStep=nil
airModel:setActorProcessData(processData)
airController:reqSaveFbProcessData()
airBuffSystem:onLevelStart()

self:closeSelf()
end



function UIAirMiniGame_shopWin:onMoneyBtn()
end

function UIAirMiniGame_shopWin:onMoneyRefreshBtn()
if self.isInFade then
return
end


local lockList=airModel:getShopLockGoodsList()
if lockList and next(lockList)then
local maxLockCount=4
local count=0
for idx,randId in pairs(lockList)do
count=count+1
end

if count>=maxLockCount then
UIManager.error("当前商品已全部锁定，无法刷新")
return
end
end


local moneyCount=airModel:getMoney()
if moneyCount<self.refreshCost then
UIManager.error("云游精粹不足，无法刷新")
return
end


local maxRefreshNum=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyMaxRefreshNum")
if maxRefreshNum then

local processData=airModel:getActorProcessData()
local refreshCount=processData and processData.settlementData and processData.settlementData.shopGoodsRefreshCount or 0
if refreshCount>=maxRefreshNum then
UIManager.error("刷新次数不足，无法刷新")
return
end
end

airController:refreshShopGoodsData(self.refreshCost,1)
end

function UIAirMiniGame_shopWin:onClickGoodsItem(itemId,itemType)

self:showWindow("UIAirMiniGame_itemTipsWin",{itemId=itemId,itemType=itemType,fromType=1})
end

function UIAirMiniGame_shopWin:onClickBagEquipItem(index,itemId)

self:showWindow("UIAirMiniGame_itemTipsWin",{itemId=itemId,itemType=1,fromType=2,equipIndex=index})
end

function UIAirMiniGame_shopWin:onGoodsBuyBtnClick(index,itemId,itemType)
if self.isInFade then
return
end


if itemType==1 then

local isFull=airActorSystem:checkActorEquipIsFull()
if isFull then
UIManager.error("你已拥有6把武器，无法购买")
return
end
end
local price=airController:getItemBuyOrSellPrice(itemId,itemType,1,true)


local moneyCount=airModel:getMoney()
if moneyCount<price then
UIManager.error("云游精粹不足，无法购买")
return
end

airController:buyItemByItemIdAndType(index,itemId,itemType)
end

function UIAirMiniGame_shopWin:onGoodsLevelUpBtnClick(index,itemId)

local itemType=1
local price=airController:getItemBuyOrSellPrice(itemId,itemType,1,true)


local moneyCount=airModel:getMoney()
if moneyCount<price then
UIManager.error("云游精粹不足，无法购买")
return
end

local equipIndex=airActorSystem:getActorSameEquipIndex(itemId)
airController:buyAndLevelUpEquipItem(index,itemId,equipIndex)
end


function UIAirMiniGame_shopWin:onGoodsLockBtnClick(index,goodRandId)
local isLock=airModel:checkGoodsIsLockByIndex(index)
airController:setGoodsLockState(index,goodRandId,not isLock)
end


function UIAirMiniGame_shopWin:onHelpBtn()
local baseCfg=cfgHelper.get(cfg_aircommonconfig_get,1)
local langId=baseCfg.shopRuleLangId or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end