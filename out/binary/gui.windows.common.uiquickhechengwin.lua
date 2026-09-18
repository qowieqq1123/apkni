







def_class("UIQuickHeChengWin",UIWindowBase)









function UIQuickHeChengWin:bindComponents()

self.root=UIObject.get(self,0)
self.titleName=UIText.get(self,1)
self.panel=UIObject.get(self,2)
self.lianHuaItem=UIBaseItem.get(self,3)
self.matTypeText=UIText.get(self,4)
self.selectCntSlider=UIObject.get(self,5)
self.handleImg=UIObject.get(self,6)
self.selectCntText=UIText.get(self,7)
self.subBtn=UIButton.get(self,8)
self.addBtn=UIButton.get(self,9)
self.maxCnt=UIButton.get(self,10)
self.costCntText=UIText.get(self,11)
self.costIcon=UIImage.get(self,12)
self.selectBtn=UIButton.get(self,13)
self.closeBtn=UIButton.get(self,14)
self.unLockText=UIText.get(self,15)
self.materials=UIObject.get(self,16)
self.countText=UIText.get(self,17)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIQuickHeChengWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.panel);self.panel=nil;
_UIObject_release(self.lianHuaItem);self.lianHuaItem=nil;
_UIObject_release(self.matTypeText);self.matTypeText=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.costCntText);self.costCntText=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.unLockText);self.unLockText=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.countText);self.countText=nil;
end
















local _this




function UIQuickHeChengWin:onLoaded(...)
_this=self
self:bindComponents()
notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
end


function UIQuickHeChengWin:__delete()
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.onItemListChanged)
end




function UIQuickHeChengWin:onShow(argtable,afterOnloaded)
self.itemId=argtable.itemId
self.parentWin=argtable.parentWin
self.needCount=argtable.needCount
self.closeCallback=argtable.closeCallback
self.heChengParam=argtable.heChengParam
local showCallback=argtable.showCallback
self:initPfId()
self:refresh(true)
if showCallback then
showCallback(self)
end
end


function UIQuickHeChengWin:onHide()

end

function UIQuickHeChengWin:initPfId()
self.pfId=self.heChengParam.args and self.heChengParam.args[1]or nil
self.pfConfig=cfgHelper.get1(cfg_lianqigeconfig_get,self.pfId)
local canMax=heChengLianHuaModel:getMaxLianHuaCount_quick(self.pfConfig)
if canMax<=0 then
canMax=1
end
local initCount=canMax
if self.needCount then
initCount=canMax>self.needCount and self.needCount or canMax
end
self.selectCnt=initCount or 1
self.maxLianZhiCnt=canMax
end

function UIQuickHeChengWin:refresh(isInit)
local pfConfig=self.pfConfig
local unLock=heChengLianHuaModel:checkPeiFangUnlock(pfConfig)
self.matTypeText:setActive(unLock)
self.selectCntSlider:setActive(unLock)
self.materials:setActive(unLock)
self.selectBtn:setActive(unLock)
self.unLockText:setActive(not unLock)

local rewards=pfConfig.rewards
local num=rewards[1][2]*self.selectCnt
local showNum=num>1
local numStr=showNum and num or''
local composeId=pfConfig.itemid

local conf={itemid=composeId,showStage=true,itemcount="",showCountBG=false,showname=false}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
self.lianHuaItem:setChildPropData(propData)
self.lianHuaItem:setBaseItemClickEvent(function(...)
tipsManager.showTips({itemid=composeId})
end)
self.countText:setText(FMT.fmt("<color=#7d3b17>数量：</color>{0}",num))
if unLock then

local func=function(...)
self:onSliderChange(...)
end
local mixCount
if self.maxLianZhiCnt==1 then
mixCount=0
else
mixCount=1
end
if isInit then
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.maxLianZhiCnt>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,mixCount,self.maxLianZhiCnt,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


local moneyCostList,costList=heChengLianHuaModel:getCrossLevelHeChengCostListByCount(self.pfId,self.selectCnt,true)
self.gainTable={}
local grids=self.materials:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
widget:SetChildActive(-1,i<=#costList)
if i<=#costList then
local costMat=costList[i]
local matId=costMat[1]
local have=0
if moneyConfig.isMoney(matId)then
have=moneyModel.getMoney(matId)
else
have=bagControl.invokeFuncByItemId(matId,'getItemCountByItemID',matId)
end
local need=costMat[2]
local colorStr=have<need and'red'or'white'
local countStr=FMT.fmt('<color={0}>{1}/{2}</color>',colorStr,mathHelper.formatBIGNumbereEx(have),mathHelper.formatBIGNumbereEx(need))
local matConf={itemid=matId,itemcount=countStr,showCountBG=true,showStage=true,showname=false}
local matProp=itemsComponentHelper.getCommonFillDataSmall(matConf)
matProp[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
matProp[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
matProp[PropIndex(DataPropKey.eWidgetActive,7)]=have<need
self.gainTable[matId]=need
widget:SetChildPropData(-1,matProp)
widget:SetBaseItemClickEvent(-1,function(...)
tipsManager.showTips({itemid=matId,usingType=TIPS_USING_TYPE.eNormal})
end)
end
end
if moneyCostList and next(moneyCostList)then
self.costCntText:setActive(true)
local moneyCost=moneyCostList[1]
local haveMoney=moneyModel.getMoney(moneyCost[1])
local iconName=iconHelper.getIconName(moneyCost[1])
local costCnt=moneyCost[2]
self.costIcon:setImageIcon(iconName,false)
if haveMoney<costCnt then
self.costCntText:setText(FMT.cfmt(FONT_COLOR.eRedColor,"{0}",costCnt))
else
self.costCntText:setText(costCnt)
end
else
self.costCntText:setActive(false)
end
end
end

function UIQuickHeChengWin:onSliderChange(value)
self.selectCnt=value
self.selectCntText:setText(self.selectCnt)
self:refresh()
end

function UIQuickHeChengWin.onItemListChanged(argsTable)
if _this==nil then return end
_this:refresh()
end




function UIQuickHeChengWin:onSubBtn()
self.selectCnt=self.selectCnt-1
if self.selectCnt<1 then
self.selectCnt=1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIQuickHeChengWin:onAddBtn()
self.selectCnt=self.selectCnt+1
if self.selectCnt>self.pfConfig.maxCount then
self.selectCnt=self.pfConfig.maxCount
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIQuickHeChengWin:onMaxCnt()
self.selectCnt=self.pfConfig.maxCount
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIQuickHeChengWin:onSelectBtn()
local isCan=true
local needMatId=nil

local isCrossLvHeCheng=false
local config=cfgHelper.get1(cfg_lianqigeconfig_get,self.pfId)
local originalCostList=config.cost
local originalCostList_lookup={}
for i,v in ipairs(originalCostList)do
local itemId=v[1]
originalCostList_lookup[itemId]=true
end
local moneyCostList,costList=heChengLianHuaModel:getCrossLevelHeChengCostListByCount(self.pfId,self.selectCnt,true)
for i,v in ipairs(costList)do
local matId=v[1]
local need=v[2]
local have=0
if not originalCostList_lookup[matId]then

isCrossLvHeCheng=true
end
if moneyConfig.isMoney(matId)then
have=moneyModel.getMoney(matId)
else
have=bagControl.invokeFuncByItemId(matId,'getItemCountByItemID',matId)
end
if have<need then
isCan=false
needMatId=matId

if self.needCount then
local itemId=self.itemId
local needCount=self.needCount
local needNum=need*needCount
gainControl:showGainWin(matId,needNum,{needCount=needNum},function()
local itemHasCount=0
if moneyConfig.isMoney(itemId)then
itemHasCount=moneyModel.getMoney(itemId)
else
itemHasCount=bagControl.invokeFuncByItemId(itemId,'getItemCountByItemID',itemId)
end
local needNum=needCount+itemHasCount
gainControl:showGainWin(itemId,needNum,{needCount=needNum})
end)
else
local itemId=self.itemId
local needNum=need
gainControl:showGainWin(matId,needNum,{needCount=needNum},function()
gainControl:showGainWin(itemId)
end)
end
UIManager.error('材料不足，无法合成')
return
end
end
if moneyCostList and next(moneyCostList)then
local moneyCost=moneyCostList[1]
local haveMoney=moneyModel.getMoney(moneyCost[1])
local costCnt=moneyCost[2]
isCan=haveMoney>=costCnt
if not isCan then
UIManager.error('灵石不足，无法合成')
return
end
end
local sfId=mapIdType.zhufeng
local bdData=zongmenModel:findBuildingDataByType(sfId,SLG_SYSTEM_TYPE.eBaGuaLu1)
if not bdData then
return UIManager.error("请先建造八卦炉")
end
heChengLianHuaController:reqHeChengItem(sfId,bdData.un_build_id,self.pfId,self.selectCnt,isCrossLvHeCheng and 1 or nil)

end



function UIQuickHeChengWin:onCloseBtn()
if self.closeCallback then
self:closeCallback()
elseif self.parentWin then
self.parentWin:onCloseClick()
end
end