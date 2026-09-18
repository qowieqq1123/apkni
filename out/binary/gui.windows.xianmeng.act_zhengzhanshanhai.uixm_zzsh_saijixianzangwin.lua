







def_class("UIXM_ZZSH_SaiJiXianZangWin",UIWindowBase)









function UIXM_ZZSH_SaiJiXianZangWin:bindComponents()

self.modelBg=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.unlockText=UIText.get(self,2)
self.unlcokBtn=UIButton.get(self,3)
self.timeRoot=UIObject.get(self,4)
self.TipsBtn=UIButton.get(self,5)
self.ScrollerView=UIObject.get(self,6)
self.titleImgae=UIObject.get(self,7)
self.lefttime=UIText.get(self,8)
self.Content=UIObject.get(self,9)
self.bottomBg=UIObject.get(self,10)
self.proRoot=UIObject.get(self,11)
self.progressbar=UIObject.get(self,12)
self.addBtn=UIButton.get(self,13)
self.progressValueTxt=UIText.get(self,14)
self.buyBtn=UIButton.get(self,15)
self.curlevel=UIText.get(self,16)
self.reward1lock=UIObject.get(self,17)
self.reward1Beishu=UIText.get(self,18)
self.reward2lock=UIObject.get(self,19)
self.reward2Beishu=UIText.get(self,20)

self.unlcokBtn:setButtonClick(function()self:onUnlcokBtn()end)

self.TipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)



end


function UIXM_ZZSH_SaiJiXianZangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
_UIObject_release(self.unlcokBtn);self.unlcokBtn=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.TipsBtn);self.TipsBtn=nil;
_UIObject_release(self.ScrollerView);self.ScrollerView=nil;
_UIObject_release(self.titleImgae);self.titleImgae=nil;
_UIObject_release(self.lefttime);self.lefttime=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.bottomBg);self.bottomBg=nil;
_UIObject_release(self.proRoot);self.proRoot=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.progressValueTxt);self.progressValueTxt=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.curlevel);self.curlevel=nil;
_UIObject_release(self.reward1lock);self.reward1lock=nil;
_UIObject_release(self.reward1Beishu);self.reward1Beishu=nil;
_UIObject_release(self.reward2lock);self.reward2lock=nil;
_UIObject_release(self.reward2Beishu);self.reward2Beishu=nil;
end















local itemcmp=
{
bg=0,
freeCreat=1,
reward1Creat=2,
reward2Creat=3,
activebg=4,
countTxt=5,
jfValue=6,
commonBg=7,
endBg=8,
endTips=9,
proBar=10,
}

local item2cmp=
{
normalReward=0,
select=1,
spriteani=2,
lock=3,
gray=4,
reddot=5,
redCnt=6,
}


local RewardState={
eRecved=1,
eNotRecv=2,
eRecv=3,
}




function UIXM_ZZSH_SaiJiXianZangWin:onLoaded(...)
self:bindComponents()
self.modelBg:setChildUIModelShowTarget(6184,1,{},0)

end


function UIXM_ZZSH_SaiJiXianZangWin:__delete()
self:stopCDTick()
self:unbindComponents()
end




function UIXM_ZZSH_SaiJiXianZangWin:onShow(argtable,afterOnloaded)
self:initLogic()
self:refresh()
end

function UIXM_ZZSH_SaiJiXianZangWin:onShowArgRecv()
self:onShow()
end


function UIXM_ZZSH_SaiJiXianZangWin:onHide()

end


function UIXM_ZZSH_SaiJiXianZangWin:initLogic()

local passport_id=zhengzhanshanhaiModel:getPassData_passport_id()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then
logErr("旧上海 不开赛季仙藏")
return
end
local localpassport_id=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonId,"passport_id")
if not localpassport_id then
logErr("该赛季没有赛季仙藏",localpassport_id)
return
end
if passport_id~=localpassport_id then
logErr("前后端赛季通行证id 对不上",localpassport_id,passport_id)
return
end
local LogicConfig={}
local passCfg=cfgHelper.get(cfg_zhengzhanshanhaipassportconfig_get,passport_id)
local fee_rewards=passCfg.fee_rewards
local rewards_1=passCfg.rewards_1
local rewards_2=passCfg.rewards_2
for level,v in pairs(passCfg.fee_rewards)do
local temp={}
temp.targetLevel=level
temp.freeRewardList=v
local unlockReward1List=rewards_1[level]
if not unlockReward1List then
logErr(FMT.fmt("目标奖励配置不对 免费奖励配置了等级-->>{0} 奖励1 没配置",level))
return
else
temp.unlockReward1List=unlockReward1List
end

local unlockReward2List=rewards_2[level]
if not unlockReward2List then
logErr(FMT.fmt("目标奖励配置不对 免费奖励配置了等级-->>{0} 奖励2 没配置",level))
return
else
temp.unlockReward2List=unlockReward2List
end
table.insert(LogicConfig,temp)
end
table.sort(LogicConfig,function(a,b)
return a.targetLevel<b.targetLevel
end)
local endTargetTemp=LogicConfig[#LogicConfig]
if endTargetTemp.targetLevel~=#passCfg.up_level_conf then
logErr(FMT.fmt("配置不对 目标奖励最大目标是-->>{0} 升级的最大等级是-->>{1} 两个不相等",endTargetTemp.targetLevel,#passCfg.up_level_conf))
return
end
endTargetTemp.isEndTemp=true
if passCfg.max_level_box then
endTargetTemp.isEndTemp=false
local endTemp={}
endTemp.isEndTemp=true
endTemp.targetLevel=endTargetTemp.targetLevel
endTemp.isSpe=true
endTemp.freeRewardList={{passCfg.max_level_box[3],1}}
endTemp.unlockReward1List={}
endTemp.unlockReward2List={}
endTemp.maxBoxCnt=passCfg.max_level_box[1]
table.insert(LogicConfig,endTemp)
end
self.passCfg=passCfg
self.LogicConfig=LogicConfig

self:startCDTick()


local len=#self.LogicConfig
self.ScrollerView:setChildScrollViewCreateGrids(len,1)
local grids=self.ScrollerView:getChildScrollViewItemWidgets()
for i=1,len do
self:SetItemData_Init(grids[i-1],i)
end
self.reward1Beishu:setText(FMT.fmt("{0}倍",self.passCfg.rewards_1_beishu))
self.reward2Beishu:setText(FMT.fmt("{0}倍",self.passCfg.rewards_2_beishu))
end

function UIXM_ZZSH_SaiJiXianZangWin:refresh()


local curLevel=self:getCurLevel()
local curScore=self:getCurScore()
local reward1BuyFlag=self:getBuyFlag(PASS_Reward_Type.eReward1)
local reward2BuyFlag=self:getBuyFlag(PASS_Reward_Type.eReward2)
local isMax=self:checkIsMaxLevel()
local up_level_conf=self.passCfg.up_level_conf
local maxLevel=#up_level_conf


self.curlevel:setText(curLevel)
local targetScore=isMax and up_level_conf[maxLevel]or up_level_conf[curLevel+1]
self.progressValueTxt:setText(FMT.fmt("{0}/{1}",isMax and targetScore or curScore,targetScore))
self.progressbar:setChildUIProgressbar(isMax and targetScore or curScore,targetScore,false)



self.reward1lock:setActive(not reward1BuyFlag)
self.reward2lock:setActive(not reward2BuyFlag)



local len=#self.LogicConfig
local grids=self.ScrollerView:getChildScrollViewItemWidgets()
for i=1,len do
self:SetItemData_Refresh(grids[i-1],i)
end



self.unlcokBtn:setActive(not reward1BuyFlag or not reward2BuyFlag)
self:refreshBuyBtn()
self.addBtn:setActive(self.passCfg.souce_get_way~=nil)




local curIndex=0
for i,v in ipairs(self.LogicConfig)do
local targetLevel=v.targetLevel
if curLevel>=targetLevel then

curIndex=i
end
end

self.ScrollerView:setChildScrollViewSelectItem(curIndex,false,false,true)


end

function UIXM_ZZSH_SaiJiXianZangWin:refreshBuyBtn(curTime,settleEndTime)
local isMax=self:checkIsMaxLevel()
self.buyBtn:setActive(not isMax)
if isMax then
return
end
if not curTime then
curTime=timeHelper.getServerLongTime()
end
local buy_level_conf=self.passCfg.buy_level_conf
local lerpdaySec=buy_level_conf[1]*86400
if not settleEndTime then
local startTime,endTime,_settleTime,_settleEndTime=zhengzhanshanhaiModel:getSeasonTime()
settleEndTime=_settleEndTime
end
local showTime=settleEndTime-lerpdaySec
self.buyBtn:setActive(curTime>=showTime)
end


function UIXM_ZZSH_SaiJiXianZangWin:SetItemData_Refresh(widget,index)
if widget==nil then
widget=self.ScrollerView:getChildScrollViewItemWidget(index-1)
end

local cfg=self.LogicConfig[index]

local curLevel=self:getCurLevel()
local curScore=self:getCurScore()
local isMax=self:checkIsMaxLevel()
if widget and cfg then
local targetLevel=cfg.targetLevel
widget:SetChildActive(itemcmp.activebg,curLevel>=targetLevel)

if not cfg.isEndTemp then
if isMax then
widget:SetChildUIProgressbar(itemcmp.proBar,1,1,false)
else
local lerp=curLevel-targetLevel
if lerp<=0 then
widget:SetChildUIProgressbar(itemcmp.proBar,0,1,false)
else
local nextCfg=self.LogicConfig[index+1]
local step=nextCfg.targetLevel-targetLevel
widget:SetChildUIProgressbar(itemcmp.proBar,lerp,step,false)
end
end
end

local temp={
{cmpIndex=itemcmp.freeCreat,rewards=cfg.freeRewardList,rw_type=PASS_Reward_Type.eFree},
{cmpIndex=itemcmp.reward1Creat,rewards=cfg.unlockReward1List,rw_type=PASS_Reward_Type.eReward1},
{cmpIndex=itemcmp.reward2Creat,rewards=cfg.unlockReward2List,rw_type=PASS_Reward_Type.eReward2},
}
for i,v in ipairs(temp)do
local cmpIndex=v.cmpIndex
local rewards=v.rewards
local rw_type=v.rw_type
for ii,vv in ipairs(rewards)do
local itemwidget=widget:GetChildLayoutGroupGridItem(cmpIndex,ii-1)
local state=self:getRewardTypeState(cfg,rw_type)
local lockFlag=not self:getBuyFlag(rw_type)
local grayFlag=lockFlag or state==RewardState.eRecved
itemwidget:SetChildActive(item2cmp.gray,grayFlag)
itemwidget:SetChildActive(item2cmp.lock,lockFlag)
itemwidget:SetChildActive(item2cmp.spriteani,state==RewardState.eRecv)
itemwidget:SetChildActive(item2cmp.select,state==RewardState.eRecved)
if cfg.isSpe then
if state==RewardState.eRecv then
local cnt=math.floor(curScore/cfg.maxBoxCnt)
itemwidget:SetChildActive(item2cmp.reddot,cnt>1)
itemwidget:SetChildText(item2cmp.redCnt,cnt)
else
itemwidget:SetChildActive(item2cmp.reddot,false)
end
else
itemwidget:SetChildActive(item2cmp.reddot,false)
end

end
end
if cfg.isSpe then
widget:SetChildText(itemcmp.jfValue,FMT.fmt("{0}/{1}",isMax and curScore or 0,cfg.maxBoxCnt))
end
end
end

function UIXM_ZZSH_SaiJiXianZangWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UIXM_ZZSH_SaiJiXianZangWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXM_ZZSH_SaiJiXianZangWin:updateCDTick()
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()
local curTime=timeHelper.getServerLongTime()
local lerp=settleTime-curTime
local lerpEx=settleEndTime-curTime
self:refreshBuyBtn(curTime,settleEndTime)
if lerp>=0 then
self.lefttime:setText(FMT.fmt("赛季剩余时间：{0}",timeHelper.format_time_stamp3(lerp,true)))
elseif lerpEx>=0 then
self.lefttime:setText(FMT.fmt("关闭剩余时间：{0}",timeHelper.format_time_stamp3(lerpEx,true)))
else
self.lefttime:setText("赛季已结束")
UIFullSHZhanLingController:closeUI()
end

end

function UIXM_ZZSH_SaiJiXianZangWin:SetItemData_Init(widget,index)
if widget==nil then
widget=self.ScrollerView:getChildScrollViewItemWidget(index-1)
end
local cfg=self.LogicConfig[index]
if widget and cfg then
local temp={
{cmpIndex=itemcmp.freeCreat,rewards=cfg.freeRewardList},
{cmpIndex=itemcmp.reward1Creat,rewards=cfg.unlockReward1List},
{cmpIndex=itemcmp.reward2Creat,rewards=cfg.unlockReward2List}
}
for i,v in ipairs(temp)do
local cmpIndex=v.cmpIndex
local rewards=v.rewards
widget:SetChildLayoutGroupCreateItems(cmpIndex,#rewards,function(groupItemIndex)
local data={}
local reward=rewards[groupItemIndex]
data[1]=reward[1]
data[2]=reward[2]
data.showStage=true
local itemwidget=widget:GetChildLayoutGroupGridItem(cmpIndex,groupItemIndex-1)
widgetHelper.setNormalRewardItem(itemwidget,item2cmp.normalReward,data)
itemwidget:SetChildButtonClick(item2cmp.spriteani,function()
self:onPrize(cfg)
end,true)
end)
end
if not cfg.isSpe then
widget:SetChildActive(itemcmp.commonBg,true)
widget:SetChildActive(itemcmp.endBg,false)
widget:SetChildText(itemcmp.countTxt,FMT.fmt("{0}级",cfg.targetLevel))
else
widget:SetChildActive(itemcmp.commonBg,false)
widget:SetChildActive(itemcmp.endBg,true)
widget:SetChildText(itemcmp.endTips,FMT.fmt("满级后每{0}积分可兑换一个秘宝礼盒",cfg.maxBoxCnt))
end
widget:SetChildActive(itemcmp.proBar,not cfg.isEndTemp)
end
end

function UIXM_ZZSH_SaiJiXianZangWin:getCurLevel()
return zhengzhanshanhaiModel:getPassData_level()
end

function UIXM_ZZSH_SaiJiXianZangWin:getCurScore()
return zhengzhanshanhaiModel:getPassData_score()
end

function UIXM_ZZSH_SaiJiXianZangWin:getBuyFlag(rw_type)
return zhengzhanshanhaiModel:getPassData_rewardBuyFlag(rw_type)
end

function UIXM_ZZSH_SaiJiXianZangWin:checkIsMaxLevel()
local curLevel=self:getCurLevel()
local up_level_conf=self.passCfg.up_level_conf
local maxLevel=#up_level_conf
return curLevel>=maxLevel
end

function UIXM_ZZSH_SaiJiXianZangWin:getRewardTypeState(logicTemp,rw_type)
if logicTemp.isSpe then
local isMax=self:checkIsMaxLevel()
if isMax then
local curScore=self:getCurScore()
return curScore>=logicTemp.maxBoxCnt and RewardState.eRecv or RewardState.eNotRecv
else
return RewardState.eNotRecv
end
end
local targetLevel=logicTemp.targetLevel
if zhengzhanshanhaiModel:getPassData_targetLevelRecvFlag(targetLevel,rw_type)then
return RewardState.eRecved
end
local curLevel=self:getCurLevel()
local buyFlag=self:getBuyFlag(rw_type)
if curLevel>=targetLevel and buyFlag then
return RewardState.eRecv
end
return RewardState.eNotRecv
end






function UIXM_ZZSH_SaiJiXianZangWin:onUnlcokBtn()
self:showWindow("UIXM_SJXZ_TouziUnLockWin")
end



function UIXM_ZZSH_SaiJiXianZangWin:onTipsBtn()
local descFMT=self.passCfg.rule_name
self:showWindow('UIRuleScrollViewWin',{showBlack=true,mode=3,name=descFMT,title="玩法介绍"})
end

function UIXM_ZZSH_SaiJiXianZangWin:onAddBtn()
local souce_get_way=self.passCfg.souce_get_way
local state=zhengzhanshanhaiModel:getLunState()

local checkGrayFuncs={
[1]=function(condition)
return state==eZZSH_State.eIdle
end,
[2]=function(condition)
return state==eZZSH_State.ePVPStandby
end,
[3]=function(condition)
return state==eZZSH_State.ePVPFight
end,
[4]=function(condition)
return state==eZZSH_State.ePVEFight
end,
}

local args={
title='积分获取',
tips="可通过以下途径获取积分，提升等级：",
gainWayList=souce_get_way,
closeCallBack=nil,
outCheckGrayFuncs=checkGrayFuncs,
}
self:showWindow("UICommonGainWayWin",args)
end

function UIXM_ZZSH_SaiJiXianZangWin:onBuyBtn()
local passCfg=self.passCfg
local buy_level_conf=passCfg.buy_level_conf
local curLevel=self:getCurLevel()
local consumeList=buy_level_conf[3]
local rewardCfgTemp={
{rwType=PASS_Reward_Type.eFree,cfgkey="fee_rewards"},
{rwType=PASS_Reward_Type.eReward1,cfgkey="rewards_1"},
{rwType=PASS_Reward_Type.eReward2,cfgkey="rewards_2"},
}
local args={}
args.moneyList={{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}}
args.max_lv=#buy_level_conf[3]
args.curLevel=curLevel
args.desFmtStr="赛季仙藏提升至 <size=28><color=#7d3b17>{0}</color></size> 级，可获得以下奖励"
args.levelFmtStr="购买{0}级："
args.getDataFunc=function(startIndex,endIndex)
local list={}
local lookup={}
for _,v in ipairs(rewardCfgTemp)do
if zhengzhanshanhaiModel:getPassData_rewardBuyFlag(v.rwType)then
for tlevel,rlist in pairs(passCfg[v.cfgkey])do
if tlevel>=startIndex and tlevel<=endIndex then
for __,itemCfg in ipairs(rlist)do
if lookup[itemCfg[1]]then
lookup[itemCfg[1]]=lookup[itemCfg[1]]+itemCfg[2]
else
lookup[itemCfg[1]]=itemCfg[2]
end
end
end
end
end
end
for itemid,cnt in pairs(lookup)do
local color=itemsConfig.getItemColor(itemid)
table.insert(list,{itemid,cnt,color,showStage=true})
end



return list
end
args.consumeItemId=buy_level_conf[2]
args.getNeedValueFunc=function(butCnt)
local need=0
for i=curLevel+1,curLevel+butCnt do
need=need+consumeList[i]
end
return need
end
args.buyFunc=function(selectCnt)
local buy_level=selectCnt-curLevel
zhengzhanshanhaiController.req_44_16(buy_level)
end
self:showWindow("UICommonBuyWin",args)
end



function UIXM_ZZSH_SaiJiXianZangWin:onPrize(cfg)
if cfg.isSpe then
local curScore=self:getCurScore()
local cnt=math.floor(curScore/cfg.maxBoxCnt)
zhengzhanshanhaiController.req_44_15(cnt)
else
zhengzhanshanhaiController.req_44_13()
end

end

