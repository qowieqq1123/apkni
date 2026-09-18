







def_class("xzsChildTYSCChallenge",UICloneObject)





xzsChildTYSCChallenge.abName="ui/windows/xiaozhushou/child/xzschildtyscchallenge.ab"

xzsChildTYSCChallenge.assetName="xzsChildTYSCChallenge"


function xzsChildTYSCChallenge:bindComponents()

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


function xzsChildTYSCChallenge:unbindComponents()
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









function xzsChildTYSCChallenge:onLoaded(...)
self:bindComponents()
end


function xzsChildTYSCChallenge:__delete()
self:unbindComponents()
fightModel:setSendExtraArgs(eBattleType.tianyuanshouchao,nil)
end




function xzsChildTYSCChallenge:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
self.detailId=detailId
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
self.doingText:setText(detailCfg.timeTxt)

self.orderID=argtable.orderID
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
self.challengeType=argtable.challengeType
if self.challengeType==1 then
self.monType=setupData[xzsDataKey.tyscYaoShouType]==1 and MONSTER_TYPE.eJingYing or MONSTER_TYPE.eXiaoGuai
self.m_id=nil
else
self.monType=MONSTER_TYPE.eShouLing
self.m_id=argtable.m_id
end
self.buyNum=argtable.buyNum
self.args=xiaoZhuShouModel:getDetailDataArgs(detailId)
self.progress:animate(0)
self.rewardText:setText("")

self.oldJiFen=xianmengModel:getMyScore_TYSC()
self.overTime=0
self:startFightTimer()
end

function xzsChildTYSCChallenge:startFightTimer()
self:autoChallenge(0)
local updateFunc=function()
self:autoChallenge(0.5)
end
self.updateTimer=self:setTimer(0.5,0,updateFunc)
end

function xzsChildTYSCChallenge:stopFightTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function xzsChildTYSCChallenge:onFinishErr()
self.progress:setActive(false)
self.tipsText:setActive(true)
self.tipsText:setText("挑战超时，已停止自动挑战")
xiaoZhuShouController:setIdleState()
end

function xzsChildTYSCChallenge:autoChallenge(delay)
self.overTime=self.overTime+delay
if self.overTime>=10 then
self:stopFightTimer()
self:onFinishErr()
return
end
if self.isFighting then
return
end
local monType=self.monType
local m_id=self.m_id
local completeCall=function(param,result,prizeList)

local isVictory=result==1
self:stopFightTimer()
self:updateDetailProgress(1,1,3.6)
self.isFighting=false
fightModel:setSendExtraArgs(eBattleType.tianyuanshouchao,nil)
end
local waitTime=xianmengController:tyscSkipFight(monType,m_id,completeCall)
if waitTime<=0 then
self.isFighting=true
end
end

function xzsChildTYSCChallenge:updateDetailProgress(target,max,duration)
if target>=max then
self.progress:setFinishAction(function()
self.progress:setActive(false)
self:refreshRewards()
self:refreshCostPanel()
xianmengController:tyscAutoFight(self.orderID,self.challengeType)
end)
end
self.progress:animateThreeParams(target,max,duration)
end

function xzsChildTYSCChallenge:refreshRewards()
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

if self.challengeType==1 then
local nowJiFen=xianmengModel:getMyScore_TYSC()
local addJiFen=nowJiFen-self.oldJiFen
local ysLevel=self.monType==MONSTER_TYPE.eJingYing and"精英"or"普通"
local str=string.format("挑战1次%s妖兽，获得<color=#CA631D>%d</color>天渊积分，获得以下奖励：",ysLevel,addJiFen)
if self.buyNum then
local shouchaoNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shouchaoNum')
local costItem=shouchaoNum[3]
local costNum=shouchaoNum[4][self.buyNum]
local costStr=string.format("消耗<color=#CA631D>%d</color>%s",costNum,itemsConfig.getItemName(costItem))
str=costStr..str
end
self.rewardText:setText(str)
else
local str="挑战1次首领妖兽，获得以下奖励："
if self.buyNum then
local shoulingNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shoulingNum')
local costItem=shoulingNum[3]
local costNum=shoulingNum[4][self.buyNum]
local costStr=string.format("消耗<color=#CA631D>%d</color>%s",costNum,itemsConfig.getItemName(costItem))
str=costStr..str
end
self.rewardText:setText(str)
end
end

function xzsChildTYSCChallenge:refreshCostPanel()
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