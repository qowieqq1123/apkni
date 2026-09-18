







def_class("UILingShuCiFuShowPrizeWin",UIWindowBase)









function UILingShuCiFuShowPrizeWin:bindComponents()

self.backNumText=UIText.get(self,0)
self.btnClickMask=UIObject.get(self,1)
self.creater=UIGameobjectClone.new(self,2)
self.effect=UIObject.get(self,3)
self.freeOnce=UIText.get(self,4)
self.levelText=UIText.get(self,5)
self.manyBtn=UIButton.get(self,6)
self.manyBtnReddot=UIObject.get(self,7)
self.manyBtnTx=UIText.get(self,8)
self.manyIcon=UIImage.get(self,9)
self.manyNum=UIText.get(self,10)
self.moneyAddTips=UIText.get(self,11)
self.moneyBtn=UIButton.get(self,12)
self.moneyIcon=UIImage.get(self,13)
self.moneyRoot=UIObject.get(self,14)
self.nextTx=UIText.get(self,15)
self.onceBtn=UIButton.get(self,16)
self.onceBtnReddot=UIObject.get(self,17)
self.onceBtnTx=UIText.get(self,18)
self.onceCost=UIObject.get(self,19)
self.onceIcon=UIImage.get(self,20)
self.onceNum=UIText.get(self,21)
self.prizeBtns=UIObject.get(self,22)
self.progressBar=UIProgressBarAni.get(self,23)
self.progressVal=UIText.get(self,24)
self.rwScrollView=UIObject.get(self,25)
self.useIcon=UIImage.get(self,26)
self.useNumText=UIText.get(self,27)

self.manyBtn:setButtonClick(function()self:onManyBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.onceBtn:setButtonClick(function()self:onOnceBtn()end)



end


function UILingShuCiFuShowPrizeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backNumText);self.backNumText=nil;
_UIObject_release(self.btnClickMask);self.btnClickMask=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.freeOnce);self.freeOnce=nil;
_UIObject_release(self.levelText);self.levelText=nil;
_UIObject_release(self.manyBtn);self.manyBtn=nil;
_UIObject_release(self.manyBtnReddot);self.manyBtnReddot=nil;
_UIObject_release(self.manyBtnTx);self.manyBtnTx=nil;
_UIObject_release(self.manyIcon);self.manyIcon=nil;
_UIObject_release(self.manyNum);self.manyNum=nil;
_UIObject_release(self.moneyAddTips);self.moneyAddTips=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.nextTx);self.nextTx=nil;
_UIObject_release(self.onceBtn);self.onceBtn=nil;
_UIObject_release(self.onceBtnReddot);self.onceBtnReddot=nil;
_UIObject_release(self.onceBtnTx);self.onceBtnTx=nil;
_UIObject_release(self.onceCost);self.onceCost=nil;
_UIObject_release(self.onceIcon);self.onceIcon=nil;
_UIObject_release(self.onceNum);self.onceNum=nil;
_UIObject_release(self.prizeBtns);self.prizeBtns=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressVal);self.progressVal=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.useIcon);self.useIcon=nil;
_UIObject_release(self.useNumText);self.useNumText=nil;
end
















local _this

local _format=string.format




function UILingShuCiFuShowPrizeWin:onLoaded(...)
_this=self
self:bindComponents()
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)

UIManager.setMoneyMsgShowState(false,true)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
end


function UILingShuCiFuShowPrizeWin:__delete()
self:clearTimer()
self.rwScrollView:setChildScrollViewStopGridCreate()

self:unbindComponents()


UIManager.setMoneyMsgShowState(true,true)
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
_this=nil
end

function UILingShuCiFuShowPrizeWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end

if moneyType==_this.money then
_this:freshMoneyValue(lastVal)
end
end

function UILingShuCiFuShowPrizeWin:onItemListChanged(list)
if list==nil then return end
for i,v in pairs(list)do
local itemid=v.itemid
local lastCount=v.itemcount
if itemid==_this.money then
_this:freshMoneyValue(lastCount)
break
end
end
end




function UILingShuCiFuShowPrizeWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.effectData then
self.effectData=argtable.effectData
end
if argtable.act_id then
self.actID=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subId)
local data=self.info:getData()

self:clearTimer()
self.openTimer=self:delayDo(0.5,function()
if _this==nil then return end
self.btnClickMask:setActive(false)
end)

self.effect:setChildShowEffect(10014,true)

local useItems=self.config.useItems
local money=useItems[1][1]

self.rewards={}
local itemList=self.effectData.itemList
for i,v in ipairs(itemList)do
if v.param_1~=money then
table.insert(self.rewards,v)
end
end

local len=#self.rewards
self.rwScrollView:setChildScrollViewStopGridCreate()
self.rwScrollView:setChildScrollViewCreateGrids(0,0)
self.rwScrollView:setChildScrollViewDelayCreateGrids(len,math.min(len,5),0.15,1,false,false,function(index,item)
local rwdata=self.rewards[index+1]
local rewardId=rwdata.param_1
local rewardNum=rwdata.param_2
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local colorEffect=true
local isDaoBing=itemsConfig.isDaoBing(rewardId)
local showStage=not isDaoBing
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=showStage,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=equipsHelper.getSuitIcon(rwdata)
item:SetChildPropData(0,prop)

item:SetBaseItemClickEvent(0,function(...)itemsComponentHelper.onItemClickEx(...)end)


if index<10 then
item:SetChildShowEffect(2,10078,true)
end
end)

local maxLv=#self.config.reward_preview
local useItems=self.config.useItems
self.money=useItems[1][1]
if self.effectData then
local addNum=self.effectData.cjNum-self.effectData.djIndex
if self.effectData.djIndex>0 and addNum>0 then
self.useNumText:setActive(true)
self.useNumText:setText(FMT.fmt("第{0}次祈愿灵树已升级！现返还",self.effectData.djIndex))
self.backNumText:setText(useItems[1][2]*addNum)
self.useIcon:setImageIcon(iconHelper.getIconName(self.money),false)
else
self.useNumText:setActive(false)
end

local level=data.level or 1
if self.effectData.exp>0 and maxLv>1 then
self.levelText:setActive(true)

local curExp=data.exp or 0
local callFunc=function(isMax)
if curExp==0 then
local oldLv=level-1
local oldmaxexp=self.config.level[level]
local oldexp=oldmaxexp-1
self.levelText:setText(FMT.fmt("灵树：{0}级",oldLv))
self.winlua:SetProgressBarAniWithThreeParams(self.progressBar:getID(),oldexp,oldmaxexp,0)
self.progressVal:setText(_format('%s/%s',oldexp,oldmaxexp))
if isMax then
local delayTime=0.2
self.winlua:SetProgressBarAniWithThreeParams(self.progressBar:getID(),oldmaxexp,oldmaxexp,delayTime)
self:delayDo(delayTime,function()
_this.levelText:setText(FMT.fmt("灵树：{0}级",level))
_this.progressVal:setText("已满级")
end)
else
local maxexp=self.config.level[level+1]
local delayTime=0.2
self.winlua:SetProgressBarAniWithThreeParams(self.progressBar:getID(),oldmaxexp,oldmaxexp,delayTime)
self:delayDo(delayTime,function()
_this.winlua:SetProgressBarAniWithThreeParams(_this.progressBar:getID(),curExp,maxexp,0)
_this.levelText:setText(FMT.fmt("灵树：{0}级",level))
_this.progressVal:setText(_format('%s/%s',curExp,maxexp))
end)
end
else
local maxexp=self.config.level[level+1]
local oldexp=curExp-1

self.levelText:setText(FMT.fmt("灵树：{0}级",level))
self.winlua:SetProgressBarAniWithThreeParams(self.progressBar:getID(),oldexp,maxexp,0)
self.progressVal:setText(_format('%s/%s',oldexp,maxexp))

local delayTime=0.2
self.winlua:SetProgressBarAniWithThreeParams(self.progressBar:getID(),curExp,maxexp,delayTime)
self:delayDo(delayTime,function()
_this.progressVal:setText(_format('%s/%s',curExp,maxexp))
end)
end
end

if self.config.level[level+1]then
callFunc()
else
callFunc(true)
end
self.rwScrollView:setLocalPosY(-5)
else
self.levelText:setActive(false)
self.rwScrollView:setLocalPosY(-30)
end

if self.effectData.upLevelNum>0 then

end
end

local maxTimes=self.config.round
self.nextTx:setText(maxTimes-data.cjNum2)

self:refreshBtn()
self:freshMoney()
end


function UILingShuCiFuShowPrizeWin:onHide()
self:clearTimer()
end

function UILingShuCiFuShowPrizeWin:refreshBtn()
self.prizeBtns:setActive(true)
local useItems=self.config.useItems

self.once=useItems[1][2]
self.onceBtnTx:setText("祈愿1次")
self.onceIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.onceNum:setText(self.once)
self.freeOnce:setActive(self.info:checkFree())
self.onceCost:setActive(not self.info:checkFree())

self.many=useItems[1][2]*10
self.manyBtnTx:setText("祈愿10次")
self.manyIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.manyNum:setText(self.many)
local isRed=self.info:checkMany()
self.manyBtnReddot:setActive(isRed)
end

function UILingShuCiFuShowPrizeWin:freshMoney()
self.moneyRoot:setActive(true)

local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyType=self.money

local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
widget:SetChildActive(2,true)
widget:SetChildButtonClick(2,function()self:onAddClick(moneyType)end,true)
end

function UILingShuCiFuShowPrizeWin:freshMoneyValue(lastVal)
local moneyType=self.money
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self:clearFMTweener()
self.fmTweener=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UILingShuCiFuShowPrizeWin:clearFMTweener()
if self.fmTweener==nil then return end
self.fmTweener:Kill()
self.fmTweener=nil
end





function UILingShuCiFuShowPrizeWin:onMoneyBtn()
gainControl:showGainWin(self.money)
end



function UILingShuCiFuShowPrizeWin:onOnceBtn()
_this:clearTimer()
self.btnClickMask:setActive(true)
self.openTimer=self:delayDo(0.5,function()
if _this==nil then return end
self.btnClickMask:setActive(false)
end)
UIManager:invokeUIMethod("UILingShuCiFuWin","onOnceBtn")
local toggle=self.info:getJumpAnimation()
if not toggle then
self:onClickBg()
end
end



function UILingShuCiFuShowPrizeWin:onManyBtn()
_this:clearTimer()
self.btnClickMask:setActive(true)
self.openTimer=self:delayDo(0.5,function()
if _this==nil then return end
self.btnClickMask:setActive(false)
end)
UIManager:invokeUIMethod("UILingShuCiFuWin","onManyBtn")
local toggle=self.info:getJumpAnimation()
if not toggle then
self:onClickBg()
end
end

function UILingShuCiFuShowPrizeWin:onClickBg()
_this:clearTimer()
self.btnClickMask:setActive(true)
self:closeSelf()
end

function UILingShuCiFuShowPrizeWin:clearTimer()
if self.openTimer then
self:stopTimerByID(self.openTimer)
self.openTimer=nil
end
end
