







def_class("UIXianJie_JiJie_initiateWin",UIWindowBase)









function UIXianJie_JiJie_initiateWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.confirmBtn=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.titleName=UIObject.get(self,3)
self.timeSelectGroup=UIObject.get(self,4)
self.bgModel=UIObject.get(self,5)
self.moneyCost=UIObject.get(self,6)
self.moneyCostCountText=UIText.get(self,7)
self.moneyCostIcon=UIImage.get(self,8)
self.root=UIObject.get(self,9)
self.jobPanel=UIObject.get(self,10)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianJie_JiJie_initiateWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.timeSelectGroup);self.timeSelectGroup=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.moneyCost);self.moneyCost=nil;
_UIObject_release(self.moneyCostCountText);self.moneyCostCountText=nil;
_UIObject_release(self.moneyCostIcon);self.moneyCostIcon=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.jobPanel);self.jobPanel=nil;
end
















local _this
local _jobPanelCmpIndex={
jobIcon=0,
jobName=1,
attrList=2,
attrTips=3,
attrPanel=4,
descPanel=5,
descText=6,
}




function UIXianJie_JiJie_initiateWin:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.on_money_changed,function(...)
self:onMoneyChanged(...)
end)
end


function UIXianJie_JiJie_initiateWin:__delete()
_this=nil
self:closeWindow('UITopMoneyWin2')
self:unbindComponents()
end




function UIXianJie_JiJie_initiateWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.bgModel:setChildUIModelShowTarget(5729,1,{},eAnimationID.enter)
self:delayDo(0.4,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
self.confirmCb=argtable and argtable.confirmCb
self.orderType=argtable and argtable.orderType
self.extraCost=argtable and argtable.extraCost or{}
self.isXianXu=argtable and argtable.isXianXu
self.selectIndex=self:getDefaultSelectIndex()
self.massTimeList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'massTime')
local sceneidx=xianjieModel:getSceneIndex()
if sceneidx and(xianjienSceneIndexType:isMoJie(sceneidx)or xianjienSceneIndexType:isMoGongZhengDuo(sceneidx))then
self:showWindow("UITopMoneyWin2",{moneys={{eMoneyType.mtMoLing}},offsetX=0,offsetY=-25})
else
self:showWindow("UITopMoneyWin2",{moneys={{eMoneyType.mtXianLing}},offsetX=0,offsetY=-25})
end
self:refresh(true)
end


function UIXianJie_JiJie_initiateWin:onHide()

end

function UIXianJie_JiJie_initiateWin:getDefaultSelectIndex()
local data=xianjieModel:getJiJieLocalData()or{}
local lastSelectJJIndex=data.lastSelectJJIndex or 1
return lastSelectJJIndex
end

function UIXianJie_JiJie_initiateWin:refresh(isInit)

local childnum=#self.massTimeList
if isInit then
self.timeSelectGroup:setChildLayoutGroupCreateItems(childnum)
end
local childGrids=self.timeSelectGroup:getChildLayoutGroupGridList()
for i=1,childnum do
local childItem=childGrids[i-1]
local timeSecond=self.massTimeList[i]
if timeSecond then
childItem:SetChildActive(-1,true)
local isSelect=i==self.selectIndex
childItem:SetChildToggle(0,isSelect)

local timeStr=FMT.fmt("{0}分钟",math.floor(timeSecond/60))
childItem:SetChildText(1,timeStr)
if isInit then
childItem:SetChildToggleChange(0,function(name,isOn)

if isOn then
self.selectIndex=i
end
end)
end
else
childItem:SetChildActive(-1,false)
end
end


self.allCostList={}
if self.orderType then
local orderCfg=xianjieModel:getOrderConfig(self.orderType)
local czCost=orderCfg[4]or{}
local costIndexLookup={}

for i,v in ipairs(czCost)do
local itemId=v[1]
local itemCount=v[2]
local index=costIndexLookup[itemId]
if index and self.allCostList[index]then
self.allCostList[index][2]=self.allCostList[index][2]+itemCount
else
index=#self.allCostList+1
self.allCostList[#self.allCostList+1]={itemId,itemCount}
costIndexLookup[itemId]=index
end
end
for i,v in ipairs(self.extraCost)do
local itemId=v[1]
local itemCount=v[2]
local index=costIndexLookup[itemId]
if index and self.allCostList[index]then
self.allCostList[index][2]=self.allCostList[index][2]+itemCount
else
index=#self.allCostList+1
self.allCostList[#self.allCostList+1]={itemId,itemCount}
costIndexLookup[itemId]=index
end
end
end

self:refreshCost()

end

function UIXianJie_JiJie_initiateWin:refreshCost(itemList)
local isShowCost=self.allCostList and next(self.allCostList)~=nil or false
self.moneyCost:setActive(isShowCost)
if isShowCost then
local cost=self.allCostList[1]
local moneyType=cost[1]
local moneyCount=cost[2]
local hasCount=itemsModel.getCount(moneyType)


local countStr=mathHelper.formatNumber(moneyCount)
if hasCount<moneyCount then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
end
self.moneyCostCountText:setText(countStr)
self.moneyCostIcon:setIcon(iconHelper.getIconName(moneyType),false)
self.showCostMoneyType=moneyType
end
end

function UIXianJie_JiJie_initiateWin:checkIsEnoughCost(itemList)
if not itemList or not next(itemList)then
return true
end

for i,v in pairs(itemList)do
local itemId=v[1]
local needNum=v[2]
local haveNum=itemsModel.getCount(itemId)

if haveNum<needNum then
return false,itemId
end
end
return true
end


















































function UIXianJie_JiJie_initiateWin:onMoneyChanged(moneyType)
if moneyType==self.showCostMoneyType then
return self:refreshCost()
end
end




function UIXianJie_JiJie_initiateWin:onClickMask()
self:onCloseBtn()
end



function UIXianJie_JiJie_initiateWin:onConfirmBtn()

local isEnough,itemId=self:checkIsEnoughCost(self.allCostList)
if not isEnough then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
return
end

local timeSecond=self.massTimeList[self.selectIndex]
xianjieModel:setJiJieLocalData_lastSelectJJIndex(self.selectIndex)
xianjieModel:saveJiJieLocalData()

local func=function()
if not _this then return end
if self.confirmCb then
local cb=self.confirmCb
return cb(timeSecond)
end

if _this then

self:onCloseBtn()
end
end






















return func()
end



function UIXianJie_JiJie_initiateWin:onCloseBtn()
self:closeSelf()
end

