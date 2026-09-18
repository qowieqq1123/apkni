







def_class("UIMoJieMoJunRewardWin",UIWindowBase)









function UIMoJieMoJunRewardWin:bindComponents()

self.curJieShu=UIText.get(self,0)
self.desc=UIText.get(self,1)
self.desc2=UIText.get(self,2)
self.hurtButton=UIButton.get(self,3)
self.hurtGridPanel=UIObject.get(self,4)
self.hurtReddot=UIObject.get(self,5)
self.hurtScrollView=UILoopListView.new(self,6)
self.hurtTxt=UIText.get(self,7)
self.jieshuButton=UIButton.get(self,8)
self.jieshuDayRewardList=UIObject.get(self,9)
self.jieShuDesc=UIText.get(self,10)
self.jieshuKillRewardList=UIObject.get(self,11)
self.jieshuRewardBtn=UIButton.get(self,12)
self.jieshuRewardList=UIObject.get(self,13)
self.notJieshuReward=UIText.get(self,14)
self.panel1=UIObject.get(self,15)
self.panel2=UIObject.get(self,16)
self.panel3=UIObject.get(self,17)
self.rewardButton=UIButton.get(self,18)
self.rewardList=UIObject.get(self,19)
self.rewardList2=UIObject.get(self,20)
self.rewardReddot=UIObject.get(self,21)
self.root=UIObject.get(self,22)
self.title=UIText.get(self,23)
self.mjbg1=UIObject.get(self,24)
self.mjbg2=UIObject.get(self,25)
self.tzRewardPanel=UIObject.get(self,26)
self.jsRewardPanel=UIObject.get(self,27)
self.nscrollView=UIObject.get(self,28)
self.rewardLista=UIObject.get(self,29)
self.desca=UIText.get(self,30)
self.rewardListb=UIObject.get(self,31)
self.descb=UIText.get(self,32)
self.rewardListc=UIObject.get(self,33)
self.descc=UIText.get(self,34)

self.hurtButton:setButtonClick(function()self:onHurtButton()end)

self.hurtScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.jieshuButton:setButtonClick(function()self:onJieshuButton()end)

self.jieshuRewardBtn:setButtonClick(function()self:onJieshuRewardBtn()end)

self.rewardButton:setButtonClick(function()self:onRewardButton()end)



end


function UIMoJieMoJunRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.curJieShu);self.curJieShu=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.hurtButton);self.hurtButton=nil;
_UIObject_release(self.hurtGridPanel);self.hurtGridPanel=nil;
_UIObject_release(self.hurtReddot);self.hurtReddot=nil;
self.hurtScrollView:deleteSelf();self.hurtScrollView=nil;
_UIObject_release(self.hurtTxt);self.hurtTxt=nil;
_UIObject_release(self.jieshuButton);self.jieshuButton=nil;
_UIObject_release(self.jieshuDayRewardList);self.jieshuDayRewardList=nil;
_UIObject_release(self.jieShuDesc);self.jieShuDesc=nil;
_UIObject_release(self.jieshuKillRewardList);self.jieshuKillRewardList=nil;
_UIObject_release(self.jieshuRewardBtn);self.jieshuRewardBtn=nil;
_UIObject_release(self.jieshuRewardList);self.jieshuRewardList=nil;
_UIObject_release(self.notJieshuReward);self.notJieshuReward=nil;
_UIObject_release(self.panel1);self.panel1=nil;
_UIObject_release(self.panel2);self.panel2=nil;
_UIObject_release(self.panel3);self.panel3=nil;
_UIObject_release(self.rewardButton);self.rewardButton=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardList2);self.rewardList2=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.mjbg1);self.mjbg1=nil;
_UIObject_release(self.mjbg2);self.mjbg2=nil;
_UIObject_release(self.tzRewardPanel);self.tzRewardPanel=nil;
_UIObject_release(self.jsRewardPanel);self.jsRewardPanel=nil;
_UIObject_release(self.nscrollView);self.nscrollView=nil;
_UIObject_release(self.rewardLista);self.rewardLista=nil;
_UIObject_release(self.desca);self.desca=nil;
_UIObject_release(self.rewardListb);self.rewardListb=nil;
_UIObject_release(self.descb);self.descb=nil;
_UIObject_release(self.rewardListc);self.rewardListc=nil;
_UIObject_release(self.descc);self.descc=nil;
end
















local _this

local _hurtItemCom={
desc=0,
rewardList=1,
getBtn=2,
ylq=3,
wwc=4,
rewardsView=5,
}
local flagabname='ui/windows/mojiemojun/mojiemojun_atlas_pak.ab'



function UIMoJieMoJunRewardWin:onLoaded(...)
self:bindComponents()
local id=self.hurtScrollView:getID()
_this=self
self.hurtGridPanelCmp=self.winlua:GetChildLoopListView2(id)
end


function UIMoJieMoJunRewardWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMoJieMoJunRewardWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id

self.selectTabIdx=1

self.MJZJID=xianjieModel:getMoJunZhangJieID()
if self.MJZJID==MoJunZhangJieID.two then
self.mjbg1:setActive(false)
self.mjbg2:setActive(true)
end
self:refreshPanel()
end

function UIMoJieMoJunRewardWin:refreshHurt()
if self.selectTabIdx==1 then
self:RefreshWin()
end
end

function UIMoJieMoJunRewardWin:refreshPanel()
self.panel1:setActive(self.selectTabIdx==1)
self.panel2:setActive(self.selectTabIdx==2)
self.panel3:setActive(self.selectTabIdx==3)

if self.selectTabIdx==1 then
self:RefreshWin()
elseif self.selectTabIdx==2 then
self:refreshJieShu()
else
self:refreshReward()
end

local hurtWidget=self.hurtButton:getChildWidgetBase()
hurtWidget:SetChildActive(0,self.selectTabIdx==1)
local jieshuWidget=self.jieshuButton:getChildWidgetBase()
jieshuWidget:SetChildActive(0,self.selectTabIdx==2)
local rewardWidget=self.rewardButton:getChildWidgetBase()
rewardWidget:SetChildActive(0,self.selectTabIdx==3)

self:refreshHurtReddot()
self:refreshRewardReddot()
end


function UIMoJieMoJunRewardWin:refreshHurtReddot()
local rewardReddot=xianjieModel:checkHasMoJunHurtReward()
self.hurtReddot:setActive(rewardReddot)
end

function UIMoJieMoJunRewardWin:refreshRewardReddot()
local rewardReddot=xianjieModel:checkHasMoJunJieShuReward()
self.rewardReddot:setActive(rewardReddot)
end


function UIMoJieMoJunRewardWin:RefreshWin()
self.title:setText("伤害奖励")
self.mojunData=xianjieModel:getMoJunData(self.seasonType,self.stageIndex)or{}
if not self.data then
local itemIdList={}
self.data=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"hurtRewards")
local resourcetb=self.data
self.hurtScrollView:initData("hurt_Item",itemIdList)
if resourcetb~=nil and next(resourcetb)then
for i=1,#resourcetb do
itemIdList[i]=i
end
self.hurtScrollView:initData("hurt_Item",itemIdList)
end
else
local nowShowItemCount=self.hurtGridPanelCmp.ShownItemCount
for i=0,nowShowItemCount-1 do
local item=self.hurtGridPanelCmp:GetShownItemByIndex(i)
local index=item.ItemIndex+1
if item then
self:refreshItem(item.Widget,index)
end
end
end

local hurtTotal=mathHelper.int64_to_number(self.mojunData.hurtTotal)
self.hurtTxt:setText(FMT.fmt("当前累计伤害：<color=#ca631d>{0}</color>",mathHelper.formatNumber4(hurtTotal,1)))
end

function UIMoJieMoJunRewardWin:refreshItem(widget,idx)
if widget==nil then

return
end
local hurt_data=self.data
local hurtData=hurt_data[idx]
local hurtTotal=mathHelper.int64_to_number(self.mojunData.hurtTotal)
local hurtRwMaxVal=mathHelper.int64_to_number(self.mojunData.hurtRwMaxVal)
widget:SetChildText(_hurtItemCom.desc,FMT.fmt("累计造成<color=#ca631d>{0}</color>伤害",mathHelper.formatNumber4(hurtData[1],1)))

local canGet=hurtRwMaxVal<hurtData[1]and hurtTotal>=hurtData[1]
widget:SetChildActive(_hurtItemCom.ylq,hurtRwMaxVal>=hurtData[1])
widget:SetChildActive(_hurtItemCom.wwc,hurtTotal<hurtData[1])
widget:SetChildActive(_hurtItemCom.getBtn,canGet)

widget:SetChildButtonClick(_hurtItemCom.getBtn,function()
xianjieController:reqMoJunMeMaxHurt(self.seasonType,self.stageIndex)
end)

local rewardList=hurtData[2]
widget:SetChildLayoutGroupCreateItems(_hurtItemCom.rewardList,#rewardList)
local grids=widget:GetChildLayoutGroupGridList(_hurtItemCom.rewardList)
for j=1,grids.Count do
local item=grids[j-1]
item:SetChildActive(-1,true)
local itemCfg=rewardList[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name='',colorEffect=canGet}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
widget:SetChildAnchoredPos(_hurtItemCom.rewardList,0,0)
widget:SetChildScrollRectEnable(_hurtItemCom.rewardsView,#rewardList>=5)
end


function UIMoJieMoJunRewardWin:onHide()

end

function UIMoJieMoJunRewardWin:onStartAction()

end

function UIMoJieMoJunRewardWin:onFreshAction(index,widget)
self:refreshItem(widget,index)
end


function UIMoJieMoJunRewardWin:refreshJieShu()
self.title:setText("阶数奖励")
local mojunData=xianjieModel:getMoJunData()
local mojunJieShu=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"mojunJieShu")
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)

local rewards={}
local tempLookup={}
local today,jieshu=xianjieModel:getCurMoJunDayAndJieshu()

local num=math.floor((today-1)/mojunJieShu[2])
local jieshu=math.max(mojunJieShu[1]-num,1)
self.curJieShu:setText(FMT.fmt("当前魔君阶数：{0}",jieshu))

local maxDay=today-1
if mojunData.killTime==0 and xianjieModel:getIsCurDayEndTzMoJun()then
maxDay=today
end
if mojunData.jsrwFail<maxDay then
for i=mojunData.jsrwFail+1,maxDay do
local curNum=math.floor((i-1)/mojunJieShu[2])
local curJieshu=math.max(mojunJieShu[1]-curNum,1)

local mjid=xianjieModel:getMoJunidByJieshu(self.seasonType,self.stageIndex,curJieshu)
local curCfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mjid)
for i,v in ipairs(curCfg.jsRewards[1])do
showPrizeControl.insertCommon(rewards,tempLookup,nil,v[1],v[2],true)
end
end
end

if mojunData.killTime>0 and mojunData.jsrwFail<today then
local mjid=xianjieModel:getMoJunidByJieshu(self.seasonType,self.stageIndex,jieshu)
local curCfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mjid)
for i,v in ipairs(curCfg.jsRewards[2])do
showPrizeControl.insertCommon(rewards,tempLookup,nil,v[1],v[2],true)
end
end

local dayRewards=cfg.jsRewards[1]
self.jieshuDayRewardList:setChildLayoutGroupCreateItems(#dayRewards)
local grids=self.jieshuDayRewardList:getChildLayoutGroupGridList()
for j=1,grids.Count do
local item=grids[j-1]
item:SetChildActive(-1,true)
local itemCfg=dayRewards[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

local killRewards=cfg.jsRewards[2]
self.jieshuKillRewardList:setChildLayoutGroupCreateItems(#killRewards)
local grids2=self.jieshuKillRewardList:getChildLayoutGroupGridList()
for j=1,grids2.Count do
local item=grids2[j-1]
item:SetChildActive(-1,true)
local itemCfg=killRewards[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

if mojunData.jsrwSucc>0 then
rewards={}
end
local isHasReward=rewards~=nil and next(rewards)~=nil
if isHasReward then
self.jieshuRewardList:setChildLayoutGroupCreateItems(#rewards)
local grids3=self.jieshuRewardList:getChildLayoutGroupGridList()
for j=1,grids3.Count do
local item=grids3[j-1]
item:SetChildActive(-1,true)
local itemCfg=rewards[j]
local itemId=itemCfg.itemid
local itemNum=itemCfg.num
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
self.notJieshuReward:setActive(not isHasReward)
self.jieshuRewardList:setActive(isHasReward)
self.jieshuRewardBtn:setActive(isHasReward)
end


function UIMoJieMoJunRewardWin:refreshReward()
self.title:setText("奖励预览")
if self.initReward then return end
self.initReward=true


local mohe=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"mohe")
if mohe and next(mohe)then
self.tzRewardPanel:setActive(false)
self.jsRewardPanel:setActive(false)
self.nscrollView:setActive(true)
local mojunData=xianjieModel:getMoJunData()
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
self.desca:setText(FMT.fmt("（魔界第{0}章期间，征讨魔君最多获得1次首战奖励）",self.stageIndex))

local tzRewards=cfg.tzRewards
self.rewardLista:setChildLayoutGroupCreateItems(#tzRewards)
local grids=self.rewardLista:getChildLayoutGroupGridList()
for j=1,grids.Count do
local item=grids[j-1]
item:SetChildActive(-1,true)
local itemCfg=tzRewards[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end


local itemid=eMoneyType.mtMoZhenYiHe
local num=mohe[1]or 1
local tempRewards={{itemid,num},{itemid,num}}
self.rewardListb:setChildLayoutGroupCreateItems(#tempRewards)
local grids3=self.rewardListb:getChildLayoutGroupGridList()
for j=1,grids3.Count do
local item=grids3[j-1]
item:SetChildActive(-1,true)
local itemCfg=tempRewards[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>=1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>=1
if j==1 then
item:SetChildCSImageSprite(2,flagabname,"image_mojun_9")
elseif j==2 then
countStr=''
showCountBG=false
item:SetChildCSImageSprite(2,flagabname,"image_mojun_10")
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
self.descb:setText(FMT.fmt("（对魔君造成的伤害量越高，额外获得的魔核越多）"))


local dieRewards=cfg.dieRewards
self.rewardListc:setChildLayoutGroupCreateItems(#dieRewards)
local grids2=self.rewardListc:getChildLayoutGroupGridList()
for j=1,grids2.Count do
local item=grids2[j-1]
item:SetChildActive(-1,true)
local itemCfg=dieRewards[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
else
self.tzRewardPanel:setActive(true)
self.jsRewardPanel:setActive(true)
self.nscrollView:setActive(false)
local mojunData=xianjieModel:getMoJunData()
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
self.desc:setText(FMT.fmt("（魔界第{0}章期间，征讨魔君最多获得1次首战奖励）",self.stageIndex))

local tzRewards=cfg.tzRewards
self.rewardList:setChildLayoutGroupCreateItems(#tzRewards)
local grids=self.rewardList:getChildLayoutGroupGridList()
for j=1,grids.Count do
local item=grids[j-1]
item:SetChildActive(-1,true)
local itemCfg=tzRewards[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end

local dieRewards=cfg.dieRewards
self.rewardList2:setChildLayoutGroupCreateItems(#dieRewards)
local grids2=self.rewardList2:getChildLayoutGroupGridList()
for j=1,grids2.Count do
local item=grids2[j-1]
item:SetChildActive(-1,true)
local itemCfg=dieRewards[j]
local itemId=itemCfg[1]
local itemNum=itemCfg[2]
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end
end

function UIMoJieMoJunRewardWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight,
showModel=true,})
end




function UIMoJieMoJunRewardWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UIMoJieMoJunRewardWin:onHurtButton()
self.selectTabIdx=1
self:refreshPanel()
end

function UIMoJieMoJunRewardWin:onJieshuButton()
self.selectTabIdx=2
self:refreshPanel()
end


function UIMoJieMoJunRewardWin:onRewardButton()
self.selectTabIdx=3
self:refreshPanel()
end

function UIMoJieMoJunRewardWin:onJieshuRewardBtn()
xianjieController:reqMoJunGetJieShuReward(self.seasonType,self.stageIndex)
end
