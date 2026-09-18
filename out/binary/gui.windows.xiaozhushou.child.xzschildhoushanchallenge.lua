







def_class("xzsChildHouShanChallenge",UICloneObject)





xzsChildHouShanChallenge.abName="ui/windows/xiaozhushou/child/xzschildhoushanchallenge.ab"

xzsChildHouShanChallenge.assetName="xzsChildHouShanChallenge"


function xzsChildHouShanChallenge:bindComponents()

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


function xzsChildHouShanChallenge:unbindComponents()
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









function xzsChildHouShanChallenge:onLoaded(...)
self:bindComponents()
end


function xzsChildHouShanChallenge:__delete()
self:unbindComponents()
fightModel:setSendExtraArgs(eBattleType.huanjing,nil)
end




function xzsChildHouShanChallenge:onShow(argtable,afterOnloaded)
local detailId=argtable.detailId
self.detailId=detailId
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
self.title:setText(detailCfg.name)
self.icon:setSprite("ui/windows/xiaozhushou/xzsiconsmall_pak.ab",string.format("image_zsjztps_%d",detailCfg.icon))
self.doingText:setText(detailCfg.timeTxt)
local min_t,max_t=detailCfg.time[1],detailCfg.time[2]

self.args=xiaoZhuShouModel:getDetailDataArgs(detailId)
self.progress:animate(0)
self.rewardText:setText("")

self:startAutoChallenge()
end

function xzsChildHouShanChallenge:startAutoChallenge()
local data=UIHuanJingControl:getDayChallengeData()
local isNotOpen=false
self.fightList={}
if data and data.fzId>0 and data.levels then
for i,v in ipairs(data.levels)do
if v.param_2~=1 and v.param_3~=1 then
table.insert(self.fightList,{id=v.param_1,result=0})
end
end
else
isNotOpen=true
end
self.startTime=timeHelper.getServerShortTime()
self.fightIdx=1
self.isFighting=false
self.maxFightNum=#self.fightList
if self.maxFightNum>0 then
local skip_daily_limit=cfgHelper.get2(cfg_guanqianewbasicconfig_get,1,"skip_daily_limit")
local zmFight=playerModel:getActorFightValue()
local zmLevel=zongmenModel:getLevel()or 0
local lvRange=skip_daily_limit[1]
local fightRange=skip_daily_limit[2]
local idx
for i,v in ipairs(lvRange)do
if v[1]<=zmLevel and zmLevel<=v[2]then
idx=i
break
end
end
local needFightVal=fightRange[idx]
if needFightVal and needFightVal<=zmFight then
self:skipDayChallenge()
else
local updateFunc=function()
self:onExecuteUpdate()
end
self.updateTimer=self:setTimer(1,0,updateFunc)
end
else
self.tipsText:setText(isNotOpen and"每日挑战未开放"or"每日挑战已完成")
local time=0.2
self.progress:animateFiveParams(0,1,1,time,false)
self.progress:setFinishAction(function()
xiaoZhuShouController:setIdleState()
if self and not self.isClose then
self.progress:setActive(false)
self.tipsText:setActive(true)
end
end)
end
end

function xzsChildHouShanChallenge:skipDayChallenge()
if self.maxFightNum>0 and self.fightIdx<=self.maxFightNum then
local guanqia_id=self.fightList[self.fightIdx].id
socketManager:send_25_51(guanqia_id)
end
end

function xzsChildHouShanChallenge:skipDayChallengeCallback(guanqia_id,result)
if self.maxFightNum>0 and self.fightIdx<=self.maxFightNum then
self.fightList[self.fightIdx].result=result==0 and 1 or 2
self:updateDetailProgress(self.fightIdx,self.maxFightNum,0.2)
self.fightIdx=self.fightIdx+1
self:skipDayChallenge()
end
end

function xzsChildHouShanChallenge:onExecuteUpdate()
local overTime=timeHelper.getServerShortTime()-self.startTime
if overTime>=10 then
self:updateDetailProgress(1,1,0.2)
self:stopAllTimer()
return
end

if self.fightIdx>self.maxFightNum then
self:stopAllTimer()
return
end

if self.isFighting then
return
end

local guanqia_id=self.fightList[self.fightIdx].id
local completeCall=function(param,result,prizeList)
param=unpack(param)

UIHuanJingControl:setDayChallengeResult(param.guanqia_id,result==1 and 1 or 2)

self.fightList[self.fightIdx].result=result==1 and 1 or 2
self:updateDetailProgress(self.fightIdx,self.maxFightNum,3)
self.fightIdx=self.fightIdx+1
self.isFighting=false
fightModel:setSendExtraArgs(eBattleType.huanjing,nil)
end
local success=UIHuanJingControl:skipFight(guanqia_id,completeCall)
if success then
self.isFighting=true
end
end

function xzsChildHouShanChallenge:updateDetailProgress(target,max,duration)
if target>=max then
self.progress:setFinishAction(function()
self.progress:setActive(false)
self:refreshRewards()
self:refreshCostPanel()
xiaoZhuShouController:setIdleState()
end)
end
self.progress:animateThreeParams(target,max,duration)
end

function xzsChildHouShanChallenge:refreshRewards()
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

local lostNum=0
for i,v in ipairs(self.fightList)do
local result=v.result
if result==2 then
lostNum=lostNum+1
end
end
if lostNum>=self.maxFightNum then
local str=string.format("%s队挑战失败",lostNum)
self.tipsText:setActive(true)
self.tipsText:setText(str)
self.rewardPanel:setActive(false)
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_1,str)
elseif lostNum>0 then
local str=string.format("%s队挑战失败",lostNum)
self.rewardText:setText(str)
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_hs_1,str)
else
self.rewardTextLayout:setActive(false)
end
end

function xzsChildHouShanChallenge:refreshCostPanel()
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