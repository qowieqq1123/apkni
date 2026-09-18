







def_class("UISubAct_CangBaoTuCardWin",UIWindowBase)









function UISubAct_CangBaoTuCardWin:bindComponents()

self.background=UIButton.get(self,0)
self.cardView=UIObject.get(self,1)
self.prizeBtn=UIButton.get(self,2)
self.moneyBg=UIButton.get(self,3)
self.backBtn=UIButton.get(self,4)
self.moneyIcon=UIImage.get(self,5)
self.moneyNum=UIText.get(self,6)
self.freeTx=UIText.get(self,7)
self.costRoot=UIObject.get(self,8)
self.prizeReddot=UIObject.get(self,9)
self.costTx=UIText.get(self,10)
self.costIcon=UIImage.get(self,11)
self.cardList=UIObject.get(self,12)

self.background:setButtonClick(function()self:onBackground()end)

self.prizeBtn:setButtonClick(function()self:onPrizeBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.backBtn:setButtonClick(function()self:onBackBtn()end)



end


function UISubAct_CangBaoTuCardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.cardView);self.cardView=nil;
_UIObject_release(self.prizeBtn);self.prizeBtn=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.freeTx);self.freeTx=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.prizeReddot);self.prizeReddot=nil;
_UIObject_release(self.costTx);self.costTx=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.cardList);self.cardList=nil;
end
















local _this=nil
local _cardCmp={
back=0,
fore=1,
item=2,
effect=3,
}
local _tips1="点击任意地方关闭"
local _tips2="点击查看获得的九宫牌"
local _cardMax=30
local _scrollMax=10



function UISubAct_CangBaoTuCardWin:onLoaded(...)
self:bindComponents()
_this=self
self.cache={}
self.animations={}
self.cardList:setChildLayoutGroupCreateItems(0)
end


function UISubAct_CangBaoTuCardWin:__delete()
self:unbindComponents()
_this=nil
self:cleanAllAnimationTween()
end




function UISubAct_CangBaoTuCardWin:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
self.closeCB=argtable.closeCB
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

self:initMoneyItem()
self:onPrizeBtn()
end


function UISubAct_CangBaoTuCardWin:onHide()

end



function UISubAct_CangBaoTuCardWin:onBackBtn()
self:onBackground()
end



function UISubAct_CangBaoTuCardWin:onBackground()
if self.closeCB then
self.closeCB()
end
self:closeSelf()
end



function UISubAct_CangBaoTuCardWin:onPrizeBtn()

local data=self.info:getData()
if not data then
return
end

local line=self.config.free
local times=data.task.searchtimes
if times>=line then
local itemId=self.listen[1]
local have=itemsModel.getCount(itemId)
if self.need>have then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
return
end
end

local cards=self.cardList:getChildLayoutGroupGridList()
if cards.Count<_cardMax then
self:addCard()
else
local showdata=
{
type='UIDialouge',
title='提示',
content="祖师是否重新探寻九宫牌",
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
self:resetView()
self:addCard()
end,
cancelcallback=function(...)
self:onBackground()
end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
end
end


function UISubAct_CangBaoTuCardWin:onMoneyBg()
local itemId=self.listen[1]
gainControl:showCommonGainWin_item(itemId)
end

function UISubAct_CangBaoTuCardWin:addCard()
self.cardList:setChildLayoutGroupAddItem()
local cards=self.cardList:getChildLayoutGroupGridList()
local index=cards.Count
self:resetCard(index)
self:refreshMoney()
self:refreshPrize()
self:onClickCard(index)
self.cardView:setChildScrollRectEnable(index>_scrollMax)
self.cardList:setChildAnchoredPos(0,0)
end

function UISubAct_CangBaoTuCardWin:onClickCard(index)
if self.cache[index]==nil then
self.cache[index]=false
call_activitiesHandle_func('activitiesHandle_cangbaotu','reqPrize',self.activityId,self.subId,{index})
end
end

function UISubAct_CangBaoTuCardWin:initMoneyItem()
self.listen={}
for i,v in ipairs(self.config.consume)do
table.insert(self.listen,v[1])
if i==1 then
self.need=v[2]
end
end
local itemId=self.listen[1]
local iconname=iconHelper.getIconName(itemId)
self.moneyIcon:setIcon(iconname)
self.costIcon:setIcon(iconname)
self:refreshMoney()
end

function UISubAct_CangBaoTuCardWin:refreshMoney()
local data=self.info:getData()
if data then
local itemId=self.listen[1]
local line=self.config.free
local times=data.task.searchtimes
local count=itemsModel.getCount(itemId)
local num=0
local cards=self.cardList:getChildLayoutGroupGridList()
for i=1,cards.Count do
if self.cache[i]==nil then
num=num+1
end
end
if times<line then
local free=line-times
local cost=math.max(num-free,0)
self.moneyNum:setText(count-cost)
else
self.moneyNum:setText(count-num)
end
else
self.moneyNum:setText("")
end
end

function UISubAct_CangBaoTuCardWin:refreshCardReward(actId,subType,subId,rewards)
if self.activityId==actId and self.subType==subType and self.subId==subId then
local index=1
local temp={}
local cards=self.cardList:getChildLayoutGroupGridList()
for i=1,cards.Count do
if self.cache[i]==false then
local reward=rewards[index]
if reward then
local cardWidget=self.cardList:getChildLayoutGroupGridItem(i-1)
local showCountBG=reward.num>1
local countStr=showCountBG and reward.num or""
local conf={itemguid=reward.itemguid,itemid=reward.itemid,itemcount=countStr,showname=true,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
cardWidget:SetChildPropData(_cardCmp.item,prop)
cardWidget:SetBaseItemClickEvent(_cardCmp.item,function(...)
itemsComponentHelper.onItemClickEx(...)
end)

self:doAnimationTween(i)

index=index+1
table.insert(temp,i)
end
end
end
for i,v in ipairs(temp)do
self.cache[v]=true
end
self:refreshPrize()
end
end

function UISubAct_CangBaoTuCardWin:refreshPrize()
local data=self.info:getData()
if data then
local line=self.config.free
local times=data.task.searchtimes
local num=0
local cards=self.cardList:getChildLayoutGroupGridList()
for i=1,cards.Count do
if self.cache[i]==nil then
num=num+1
end
end

local free=(times+num)<line
local have=itemsModel.getCount(self.listen[1])>=self.need
self.prizeReddot:setActive(free or have)
if free then
self.freeTx:setText(FMT.fmt("免费次数：{0}",line-(times+num)))
self.costRoot:setActive(false)
else
self.freeTx:setText('')
self.costRoot:setActive(true)
local have=itemsModel.getCount(self.listen[1])
local use=num*self.need
local tempStr=(have-use)>=self.need and self.need or FMT.cfmt(FONT_COLOR.eRedColor,"{0}",self.need)
self.costTx:setText(FMT.fmt("消耗:{0}",tempStr))
end
else
self.prizeReddot:setActive(false)
self.costRoot:setActive(false)
self.freeTx:setText('')
end
end

function UISubAct_CangBaoTuCardWin:refreshView(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshPrize()
self:refreshMoney()
end
end

function UISubAct_CangBaoTuCardWin:onNewDay()
self:refreshPrize()
self:refreshMoney()
end

function UISubAct_CangBaoTuCardWin:resetView()
self.cache={}
self.cardList:setChildLayoutGroupClearAllItems()
end

function UISubAct_CangBaoTuCardWin:resetCard(index)
local cardWidget=self.cardList:getChildLayoutGroupGridItem(index-1)
cardWidget:SetChildRotation(_cardCmp.back,0,0,0)
cardWidget:SetChildRotation(_cardCmp.fore,0,90,0)
end

function UISubAct_CangBaoTuCardWin:doAnimationTween(index)
local cardWidget=self.cardList:getChildLayoutGroupGridItem(index-1)
local sequence=Lua.SequenceProxy.New()
local tween1=cardWidget:SetChildDORotation(_cardCmp.back,Vector3.up*270,0.25,DG.Tweening.RotateMode.FastBeyond360)
tween1:SetEase(DG.Tweening.Ease.Linear)
sequence:Append(tween1)
local tween2=cardWidget:SetChildDORotation(_cardCmp.fore,Vector3.zero,0.25,DG.Tweening.RotateMode.Fast)
tween2:SetEase(DG.Tweening.Ease.Linear)
sequence:Append(tween2)
self.animations[index]=sequence
cardWidget:SetChildShowEffect(_cardCmp.effect,10305,true)

AudioManager.playAudio(594)
end

function UISubAct_CangBaoTuCardWin:cleanAllAnimationTween()
for i,v in pairs(self.animations)do
if v:IsActive()then
v:Kill()
end
end
end