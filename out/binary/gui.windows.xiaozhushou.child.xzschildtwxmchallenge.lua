







def_class("xzsChildTWXMChallenge",UICloneObject)





xzsChildTWXMChallenge.abName="ui/windows/xiaozhushou/child/xzschildtwxmchallenge.ab"

xzsChildTWXMChallenge.assetName="xzsChildTWXMChallenge"


function xzsChildTWXMChallenge:bindComponents()

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


function xzsChildTWXMChallenge:unbindComponents()
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









function xzsChildTWXMChallenge:onLoaded(...)
self:bindComponents()
end


function xzsChildTWXMChallenge:__delete()
self:unbindComponents()
end




function xzsChildTWXMChallenge:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
self.detailId=detailId
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
self.doingText:setText(detailCfg.timeTxt)

self.orderID=argtable.orderID

self.buyNum=argtable.buyNum
self.args=xiaoZhuShouModel:getDetailDataArgs(detailId)
self.progress:animate(0)
self.rewardText:setText("")

self.overTime=0
self:startFightTimer()
end

function xzsChildTWXMChallenge:startFightTimer()
self:autoChallenge(0)
local updateFunc=function()
self:autoChallenge(0.5)
end
self.updateTimer=self:setTimer(0.5,0,updateFunc)
end

function xzsChildTWXMChallenge:stopFightTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function xzsChildTWXMChallenge:onFinishErr()
self.progress:setActive(false)
self.tipsText:setActive(true)
self.tipsText:setText("挑战超时，已停止自动挑战")
xiaoZhuShouController:setIdleState()
end

function xzsChildTWXMChallenge:autoChallenge(delay)
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
param=unpack(param)

self.hurt=param.hurt
local data=XianJieFuMoModel:getData()
local oldTotalDamage=data.totaldamage or 0
local oldChallengeTimes=data.challengedCnt or 0
local lastDamage=self.hurt
local totalDamage=lastDamage+oldTotalDamage
XianJieFuMoController.recv_248_107(lastDamage,totalDamage,oldChallengeTimes+1)
self:stopFightTimer()
self:updateDetailProgress(1,1,3.6)
self.isFighting=false
fightModel:setSendExtraArgs(eBattleType.xianjiefumo,nil)
end
local waitTime=XianJieFuMoController:twxmSkipFight(completeCall)
if waitTime<=0 then
self.isFighting=true
end
end

function xzsChildTWXMChallenge:updateDetailProgress(target,max,duration)
if target>=max then
self.progress:setFinishAction(function()
self.progress:setActive(false)
self:refreshRewards()
self:refreshCostPanel()
XianJieFuMoController:twxmAutoFight(self.orderID)
end)
end
self.progress:animateThreeParams(target,max,duration)
end

function xzsChildTWXMChallenge:refreshRewards()
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

local hurtStr=mathHelper.formatNumber4(tonumber(tostring(self.hurt)),2)
local str=string.format("挑战1次天外魔物，累计伤害<color=#CA631D>%s</color>，获得以下奖励：",hurtStr)
if self.buyNum then
local buyCfg=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"buy")
local costItemCfg=buyCfg[self.buyNum]
local costItem=costItemCfg[1]
local costNum=costItemCfg[2]
local costStr=string.format("消耗<color=#CA631D>%d</color>%s",costNum,itemsConfig.getItemName(costItem))
str=costStr..str
end
self.widget:SetChildTextFontSize(self.rewardText:getID(),29)
self.rewardText:setText(str)
end

function xzsChildTWXMChallenge:refreshCostPanel()
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