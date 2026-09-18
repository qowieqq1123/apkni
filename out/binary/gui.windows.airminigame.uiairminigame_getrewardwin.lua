







def_class("UIAirMiniGame_getRewardWin",UIWindowBase)









function UIAirMiniGame_getRewardWin:bindComponents()

self.rewardItem=UIObject.get(self,0)
self.itemName=UIText.get(self,1)
self.attrLayout=UIObject.get(self,2)
self.descText=UIText.get(self,3)
self.gotFlag=UIObject.get(self,4)
self.refreshBtn=UIButton.get(self,5)
self.refreshCountText=UIText.get(self,6)
self.btnPanel=UIObject.get(self,7)
self.sellBtn=UIButton.get(self,8)
self.sellPriceIcon=UIImage.get(self,9)
self.sellPriceText=UIText.get(self,10)
self.getRewardBtn=UIButton.get(self,11)
self.rewardCountText=UIText.get(self,12)
self.leftBtn=UIButton.get(self,13)
self.rightBtn=UIButton.get(self,14)
self.sellFlag=UIObject.get(self,15)
self.rewardInfoRoot=UIObject.get(self,16)
self.info=UIObject.get(self,17)
self.bgModel=UIObject.get(self,18)
self.attrPanel=UIText.get(self,19)
self.moneyRoot=UIObject.get(self,20)
self.moneyBtn=UIButton.get(self,21)
self.descPanel=UIText.get(self,22)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)

self.sellBtn:setButtonClick(function()self:onSellBtn()end)

self.getRewardBtn:setButtonClick(function()self:onGetRewardBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)



end


function UIAirMiniGame_getRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewardItem);self.rewardItem=nil;
_UIObject_release(self.itemName);self.itemName=nil;
_UIObject_release(self.attrLayout);self.attrLayout=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.gotFlag);self.gotFlag=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.refreshCountText);self.refreshCountText=nil;
_UIObject_release(self.btnPanel);self.btnPanel=nil;
_UIObject_release(self.sellBtn);self.sellBtn=nil;
_UIObject_release(self.sellPriceIcon);self.sellPriceIcon=nil;
_UIObject_release(self.sellPriceText);self.sellPriceText=nil;
_UIObject_release(self.getRewardBtn);self.getRewardBtn=nil;
_UIObject_release(self.rewardCountText);self.rewardCountText=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.sellFlag);self.sellFlag=nil;
_UIObject_release(self.rewardInfoRoot);self.rewardInfoRoot=nil;
_UIObject_release(self.info);self.info=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.attrPanel);self.attrPanel=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.descPanel);self.descPanel=nil;
end
















local _this

local oppositeAttrList={
[aiAttributeType.ePriceReduct]=true,
[aiAttributeType.eRecvDamage]=true,
}



function UIAirMiniGame_getRewardWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIAirMiniGame_getRewardWin:__delete()
_this=nil
self:clearFadeTweener()
self:clearEnterDelayTimer()
self:unbindComponents()
end




function UIAirMiniGame_getRewardWin:onShow(argtable,afterOnloaded)
self.selectIndex=1
self.info:setActive(false)
if afterOnloaded then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5502,1,{},eAnimationID.enter)
self.enterDelayTimer=self:delayDo(2,function()
if not _this then
return
end
self.info:setChildCanvasGroupAlpha(0)
self.info:setChildCanvasGroupDOFade(1,0.5)
self.info:setActive(true)
self:refresh()
end)
end

end


function UIAirMiniGame_getRewardWin:onHide()
self:clearFadeTweener()
self:clearEnterDelayTimer()
end

function UIAirMiniGame_getRewardWin:refresh(isChange)
self:clearFadeTweener()
if isChange then
self.rewardInfoRoot:setChildCanvasGroupAlpha(0)
self.fadeTweener=self.rewardInfoRoot:setChildCanvasGroupDOFade(1,0.5)
end

self:refreshRewardInfo()


self:refreshArrowBtn()


self:refreshMoney()


self:refreshTitleBtnPanel()
end

function UIAirMiniGame_getRewardWin:refreshRewardInfo()
local processData=airModel:getActorProcessData()
self.rewardItemIdList=processData.settlementData and processData.settlementData.rewardIdList or nil
if not self.rewardItemIdList then
return
end


self.allCount=#self.rewardItemIdList
local nowNum=self.selectIndex
self.rewardCountText:setText(FMT.fmt("{0}/{1}",nowNum,self.allCount))

local goodRandId=self.rewardItemIdList[self.selectIndex]
local goodCfg=cfgHelper.get(cfg_airrandshopconfig_get,goodRandId)
if goodCfg then
local selectRewardItemId=goodCfg.itemId
if selectRewardItemId then
local rewardCfg=cfgHelper.get(cfg_airitemconfig_get,selectRewardItemId)
if rewardCfg then

local itemWidget=self.rewardItem:getWidgetBase()
local prop={}
local iconName=FMT.fmt("icon_item_{0}",rewardCfg.icon)
local itemColor=rewardCfg.color
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetText,3)]=''
prop[PropIndex(DataPropKey.eWidgetText,4)]=''
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)


local name=rewardCfg.name
self.itemName:setText(name)


local attrList=self:getItemAttrSortList(selectRewardItemId)
if attrList and next(attrList)then
self.attrPanel:setActive(true)
local grids=self.attrLayout:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local attrData=attrList[i]
if attrData then
widget:SetChildActive(-1,true)
local attrId=attrData.attrId
local attrVal=attrData.attrVal
local isPercent=attrData.isPercent
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
local attrName=attrCfg.attrname

widget:SetChildText(0,FMT.fmt("{0}：",attrName))
local attrValStr
if not isPercent then
attrValStr=airController:getAttrStr(attrId,attrVal)
else
local percent=attrVal/100
percent=math.floor(percent)
attrValStr=FMT.fmt("{0}%",percent)
end

if attrVal>=0 then
attrValStr=FMT.fmt("+{0}",attrValStr)
if oppositeAttrList[attrId]then

attrValStr=FMT.cfmt(FONT_COLOR.eRedColor,attrValStr)
end
else
if not oppositeAttrList[attrId]then

attrValStr=FMT.cfmt(FONT_COLOR.eRedColor,attrValStr)
end
end
widget:SetChildText(1,attrValStr)
else
widget:SetChildActive(-1,false)
end
end
else
self.attrPanel:setActive(false)
end


local desc=rewardCfg.desc
if desc then

if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
desc=string.gsub(desc," ","\194\160")
end
self.descPanel:setActive(true)
self.descText:setText(desc)
else
self.descPanel:setActive(false)
end

local isGot=false
local isSell=false
local processData=airModel:getActorProcessData()
local settlementData=processData and processData.settlementData or{}
if settlementData and settlementData.itemRewardIndex and settlementData.itemRewardIndex[self.selectIndex]then
local flag=settlementData.itemRewardIndex[self.selectIndex]
isGot=flag==1
isSell=flag==2
end
self.gotFlag:setActive(isGot)
self.sellFlag:setActive(isSell)
self.btnPanel:setActive(not isGot and not isSell)
if not isGot and not isSell then

local sellPrice=airController:getItemBuyOrSellPrice(selectRewardItemId,2,2)
self.sellPriceText:setText(sellPrice)
local moneyIconName=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyIcon")
self.sellPriceIcon:setImageIcon(moneyIconName,false)
end
end
end
end

end

function UIAirMiniGame_getRewardWin:refreshArrowBtn()
local isShowLeft=self.allCount>1 and self.selectIndex>1
local isShowRight=self.allCount>1 and self.selectIndex<self.allCount

self.leftBtn:setActive(isShowLeft)
self.rightBtn:setActive(isShowRight)
end

function UIAirMiniGame_getRewardWin:refreshMoney()
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyVal=airModel:getMoney()
local moneyIconName=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyIcon")
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,moneyIconName,false)
widget:SetChildText(1,moneyStr)
end


function UIAirMiniGame_getRewardWin:refreshItemRefreshCost()
self:refreshTitleBtnPanel()
end


function UIAirMiniGame_getRewardWin:refreshTitleBtnPanel()

local isShowCostRefreshBtn=self:checkIsCanShowCostRefreshBtn()
self.refreshBtn:setActive(isShowCostRefreshBtn)

if isShowCostRefreshBtn then

local maxRefreshNum=cfgHelper.get(cfg_aircommonconfig_get,1,"costMaxRefreshNum")
if maxRefreshNum then

local processData=airModel:getActorProcessData()
local refreshCount=processData and processData.settlementData and processData.settlementData.rewardItemRefreshCount or 0
self.refreshCountText:setText(FMT.fmt("{0}/{1}",maxRefreshNum-refreshCount,maxRefreshNum))
self.refreshCountText:setActive(true)
else
self.refreshCountText:setActive(false)
end
end
end

function UIAirMiniGame_getRewardWin:checkIsCanShowCostRefreshBtn()
local costParams=cfgHelper.getdef(cfg_airfubenconfig,'flush_consume')
local costItemId=costParams and costParams[1]or nil
if not costItemId then
return false
end


local maxRefreshNum=cfgHelper.get(cfg_aircommonconfig_get,1,"costMaxRefreshNum")
if maxRefreshNum then

local processData=airModel:getActorProcessData()
local refreshCount=processData and processData.settlementData and processData.settlementData.rewardItemRefreshCount or 0
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

function UIAirMiniGame_getRewardWin:getItemAttrSortList(itemId)
if not self.itemAttrListLookup then
self.itemAttrListLookup={}
end

if self.itemAttrListLookup[itemId]then
return self.itemAttrListLookup[itemId]
end
local attrListLookup=airModel:getItemAttrListLookup(itemId)
local sortList={}
for attrId,v in pairs(attrListLookup)do
local sortId
if not v.cfgIdx then
local attrCfg=cfgHelper.get(cfg_airattributesconfig_get,attrId)
sortId=attrCfg.showSortId
else
sortId=v.cfgIdx
end
sortList[#sortList+1]={
attrId=attrId,
attrVal=v.val,
isPercent=v.isPercent,
sortId=sortId,
}
end

table.sort(sortList,function(a,b)
return a.sortId<b.sortId
end)

self.itemAttrListLookup[itemId]=sortList
return self.itemAttrListLookup[itemId]
end




function UIAirMiniGame_getRewardWin:onRefreshBtn()
local costParams=cfgHelper.getdef(cfg_airfubenconfig,'flush_consume')
local costItemId=costParams and costParams[1]or nil
if not costItemId then
return
end


local maxRefreshNum=cfgHelper.get(cfg_aircommonconfig_get,1,"costMaxRefreshNum")
if maxRefreshNum then

local processData=airModel:getActorProcessData()
local refreshCount=processData and processData.settlementData and processData.settlementData.rewardItemRefreshCount or 0
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


local processData=airModel:getActorProcessData()
local settlementData=processData and processData.settlementData or{}
local isGot=false
local isSell=false
if settlementData and settlementData.itemRewardIndex and settlementData.itemRewardIndex[self.selectIndex]then
local flag=settlementData.itemRewardIndex[self.selectIndex]
isGot=flag==1
isSell=flag==2
end

if isGot or isSell then
local err
if isGot then
err="领取"
elseif isSell then
err="分解"
end

return UIManager.error(FMT.fmt("当前宝物已{0}，无法刷新",err))
end


airController:itemRefreshRewardData(self.selectIndex)
end



function UIAirMiniGame_getRewardWin:onSellBtn()

local goodRandId=self.rewardItemIdList[self.selectIndex]
local goodCfg=cfgHelper.get(cfg_airrandshopconfig_get,goodRandId)
if goodCfg then
local selectRewardItemId=goodCfg.itemId
if selectRewardItemId then
airController:sellItemReward(selectRewardItemId,self.selectIndex,self.allCount)
end
end
end



function UIAirMiniGame_getRewardWin:onGetRewardBtn()

local goodRandId=self.rewardItemIdList[self.selectIndex]
local goodCfg=cfgHelper.get(cfg_airrandshopconfig_get,goodRandId)
if goodCfg then
local selectRewardItemId=goodCfg.itemId
if selectRewardItemId then
airController:getItemReward(selectRewardItemId,self.selectIndex,self.allCount)
end
end
end



function UIAirMiniGame_getRewardWin:onLeftBtn()
if self.selectIndex<=1 then
return
end

self.selectIndex=self.selectIndex-1
self:refresh(true)
end



function UIAirMiniGame_getRewardWin:onRightBtn()
if self.selectIndex>=self.allCount then
return
end

self.selectIndex=self.selectIndex+1
self:refresh(true)
end

function UIAirMiniGame_getRewardWin:onMoneyBtn()
end

function UIAirMiniGame_getRewardWin:clearFadeTweener()
if self.fadeTweener then
self.fadeTweener:Complete()
self.fadeTweener:Kill()
self.fadeTweener=nil
end
end

function UIAirMiniGame_getRewardWin:clearEnterDelayTimer()
if self.enterDelayTimer then
self:stopTimerByID(self.enterDelayTimer)
self.enterDelayTimer=nil
end
end

function UIAirMiniGame_getRewardWin:sellOrGotRewardRecv()
local processData=airModel:getActorProcessData()
local rewardItemIdList=processData.settlementData and processData.settlementData.rewardIdList
local originalGoodRandId=self.rewardItemIdList[self.selectIndex]
local newGoodRandId=rewardItemIdList[self.selectIndex]
if originalGoodRandId~=newGoodRandId then

local isSellOrGot=false
local settlementData=processData and processData.settlementData or{}
if settlementData and settlementData.itemRewardIndex and settlementData.itemRewardIndex[self.selectIndex]then
local flag=settlementData.itemRewardIndex[self.selectIndex]
isSellOrGot=flag and flag~=0
end
if not isSellOrGot then

return self:refresh(true)
end
end



local nextIndex
local startIndex=self.selectIndex+1
local endIndex=self.allCount

for i=startIndex,endIndex do
local isSellOrGot=false
local settlementData=processData and processData.settlementData or{}
if settlementData and settlementData.itemRewardIndex and settlementData.itemRewardIndex[i]then
local flag=settlementData.itemRewardIndex[i]
isSellOrGot=flag and flag~=0
end

if not isSellOrGot then
nextIndex=i
break
end
end

if not nextIndex then
startIndex=1
endIndex=self.selectIndex-1
for i=startIndex,endIndex do
local isSellOrGot=false
local settlementData=processData and processData.settlementData or{}
if settlementData and settlementData.itemRewardIndex and settlementData.itemRewardIndex[i]then
local flag=settlementData.itemRewardIndex[i]
isSellOrGot=flag and flag~=0
end

if not isSellOrGot then
nextIndex=i
break
end
end
end

if nextIndex then
self.selectIndex=nextIndex
return self:refresh(true)
else
return self:refresh()
end
end

function UIAirMiniGame_getRewardWin:refreshItemSellPrice()
self.allCount=#self.rewardItemIdList
local goodRandId=self.rewardItemIdList[self.selectIndex]
local goodCfg=cfgHelper.get(cfg_airrandshopconfig_get,goodRandId)
if goodCfg then
local selectRewardItemId=goodCfg.itemId
if selectRewardItemId then
local rewardCfg=cfgHelper.get(cfg_airitemconfig_get,selectRewardItemId)
if rewardCfg then
local isGot=false
local isSell=false
local processData=airModel:getActorProcessData()
local settlementData=processData and processData.settlementData or{}
if settlementData and settlementData.itemRewardIndex and settlementData.itemRewardIndex[self.selectIndex]then
local flag=settlementData.itemRewardIndex[self.selectIndex]
isGot=flag==1
isSell=flag==2
end
if not isGot and not isSell then

local sellPrice=airController:getItemBuyOrSellPrice(selectRewardItemId,2,2)
self.sellPriceText:setText(sellPrice)
local moneyIconName=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyIcon")
self.sellPriceIcon:setImageIcon(moneyIconName,false)
end
end
end
end
end