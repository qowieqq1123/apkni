







def_class("xzsChildXFWDChallenge",UICloneObject)





xzsChildXFWDChallenge.abName="ui/windows/xiaozhushou/child/xzschildxfwdchallenge.ab"

xzsChildXFWDChallenge.assetName="xzsChildXFWDChallenge"


function xzsChildXFWDChallenge:bindComponents()

self.costIcon_1=UIObject.get(self,0)
self.costIcon_2=UIObject.get(self,1)
self.costNum_1=UIText.get(self,2)
self.costNum_2=UIText.get(self,3)
self.costPanel=UIObject.get(self,4)
self.costTitle=UIText.get(self,5)
self.doingText=UIText.get(self,6)
self.icon=UIImage.get(self,7)
self.progress=UIProgressBarAni.get(self,8)
self.rewardContent=UIObject.get(self,9)
self.rewardPanel=UIObject.get(self,10)
self.rewardText=UIText.get(self,11)
self.rewardTextLayout=UIObject.get(self,12)
self.tipsText=UIText.get(self,13)
self.title=UIText.get(self,14)
self.costIcon={
self.costIcon_1,
self.costIcon_2,
}
self.costNum={
self.costNum_1,
self.costNum_2,
}

end


function xzsChildXFWDChallenge:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costIcon_1);self.costIcon_1=nil;
_UIObject_release(self.costIcon_2);self.costIcon_2=nil;
_UIObject_release(self.costNum_1);self.costNum_1=nil;
_UIObject_release(self.costNum_2);self.costNum_2=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costTitle);self.costTitle=nil;
_UIObject_release(self.doingText);self.doingText=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardText);self.rewardText=nil;
_UIObject_release(self.rewardTextLayout);self.rewardTextLayout=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.title);self.title=nil;
self.costIcon=nil;
self.costNum=nil;
end









function xzsChildXFWDChallenge:onLoaded(...)
self:bindComponents()
end


function xzsChildXFWDChallenge:__delete()
self:unbindComponents()
end




function xzsChildXFWDChallenge:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
self.detailId=detailId
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
self.doingText:setText(detailCfg.timeTxt)

self.orderID=argtable.orderID
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
self.fightIdx=argtable.fightIdx
self.fightName=argtable.fightName
self.buyNum=argtable.buyNum
self.args=xiaoZhuShouModel:getDetailDataArgs(detailId)
self.progress:animate(0)
self.rewardText:setText("")

self.oldJiFen=UIXianFaWenDaoControl:getScore()
self.overTime=0
self:startFightTimer()
end

function xzsChildXFWDChallenge:startFightTimer()
self:autoChallenge(0)
local updateFunc=function()
self:autoChallenge(0.5)
end
self.updateTimer=self:setTimer(0.5,0,updateFunc)
end

function xzsChildXFWDChallenge:stopFightTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function xzsChildXFWDChallenge:onFinishErr()
self.progress:setActive(false)
self.tipsText:setActive(true)
self.tipsText:setText("挑战超时，已停止自动挑战")
xiaoZhuShouController:setIdleState()
end

function xzsChildXFWDChallenge:autoChallenge(delay)
self.overTime=self.overTime+delay
if self.overTime>=10 then
self:stopFightTimer()
self:onFinishErr()
return
end
if self.isFighting then
return
end

local completeCall=function(param,result,prizeList)
local data=unpack(param)
self.isVictory=result==1
self:stopFightTimer()
UIXianFaWenDaoControl:setRank(data.rank)
UIXianFaWenDaoControl:addTimes()
UIXianFaWenDaoControl:addMoneyNum(data.moneynum)
UIXianFaWenDaoControl:setScore(data.score)
self:updateDetailProgress(1,1,3.6)
self.isFighting=false
fightModel:setSendExtraArgs(eBattleType.xianfawendao,nil)
end
local waitTime=UIXianFaWenDaoControl:xfwdSkipFight(self.fightIdx,completeCall)
if waitTime<=0 then
self.isFighting=true
end
end

function xzsChildXFWDChallenge:updateDetailProgress(target,max,duration)
if target>=max then
self.progress:setFinishAction(function()
self.progress:setActive(false)
self:refreshTipsText()
self:refreshCostPanel()
if self.isVictory then
UIXianFaWenDaoControl:xfwdAutoFight(self.orderID)
else
xiaoZhuShouController:setIdleState()
end
end)
end
self.progress:animateThreeParams(target,max,duration)
end

function xzsChildXFWDChallenge:refreshTipsText()
local str=""
local costStr
if self.buyNum then
local consume=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,"consume")
local costItemCfg=consume[self.buyNum][1]
local costItem=costItemCfg[1]
local costNum=costItemCfg[2]
costStr=string.format("已消耗<color=#CA631D>%d</color>%s",costNum,itemsConfig.getItemName(costItem))
end
if not self.isVictory then
if costStr then
str=string.format("%s自动挑战<color=#CA631D>%s</color>，挑战失败，已停止自动挑战",costStr,self.fightName)
else
str=string.format("已自动挑战<color=#CA631D>%s</color>，挑战失败，已停止自动挑战",self.fightName)
end
else
local nowJiFen=UIXianFaWenDaoControl:getScore()
local addJiFen=nowJiFen-self.oldJiFen
if costStr then
str=string.format("%s自动挑战<color=#CA631D>%s</color>，挑战胜利，获得<color=#CA631D>%d</color>积分，当前积分<color=#CA631D>%d</color>",costStr,self.fightName,addJiFen,nowJiFen)
else
str=string.format("已自动挑战<color=#CA631D>%s</color>，挑战胜利，获得<color=#CA631D>%d</color>积分，当前积分<color=#CA631D>%d</color>",self.fightName,addJiFen,nowJiFen)
end
end
self.widget:SetChildTextFontSize(self.tipsText:getID(),28)
self.tipsText:setText(str)
self.tipsText:setActive(true)
end

function xzsChildXFWDChallenge:refreshRewards()
self.rewardPanel:setActive(true)
local rewards=xiaoZhuShouModel:popWaitReward(self.detailId)or{}
self.rewardContent:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local itemid=data.itemid
local itemNum=data.num
local countStr=itemNum>1 and mathHelper.formatNumber(itemNum)or''
local showCountBG=itemNum>1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
rewardItem:SetChildPropData(0,prop)
end)
end

function xzsChildXFWDChallenge:refreshCostPanel()
local cost=self.args.cost or{}
if#cost>0 then
self.costPanel:setActive(true)
self.costTitle:setText("购买次数消耗：")
for i,v in ipairs(self.costIcon)do
if cost[i]then
local itemid,itemnum=unpack(cost[i])
self.costIcon[i]:setChildIcon(iconHelper.getIconName(itemid),false)
self.costNum[i]:setText(itemnum)
self.costIcon[i]:setActive(true)
self.costNum[i]:setActive(true)
else
self.costIcon[i]:setActive(false)
self.costNum[i]:setActive(false)
end
end
else
self.costPanel:setActive(false)
end
end