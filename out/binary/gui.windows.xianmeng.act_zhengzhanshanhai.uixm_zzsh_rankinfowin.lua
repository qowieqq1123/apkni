







def_class("UIXM_ZZSH_RankInfoWin",UIWindowBase)









function UIXM_ZZSH_RankInfoWin:bindComponents()

self.cd=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.givenBtn=UIButton.get(self,2)
self.infoScrollView=UILoopListView.new(self,3)
self.myinfo=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.ruleBtn=UIButton.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.givenBtn:setButtonClick(function()self:onGivenBtn()end)

self.infoScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)



end


function UIXM_ZZSH_RankInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cd);self.cd=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.givenBtn);self.givenBtn=nil;
self.infoScrollView:deleteSelf();self.infoScrollView=nil;
_UIObject_release(self.myinfo);self.myinfo=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
end
















local _this=nil

local _CmpItemSlotIndex={
rank=0,
server=1,
name=2,
scores=3,
reward_item_1=4,
reward_item_2=5,
reward_item_3=6,
reward_item_4=7,
info=8,
xwyd=9,
ctips=10,
items=11,
rwtips=12,
rankIcon=13,
signBgIcon=14,
signIcon=15,
signKuangIcon=16
}

local _rewardCmpIndexList={4,5,6,7}




function UIXM_ZZSH_RankInfoWin:onLoaded(...)
self:bindComponents()

_this=self

self.attend_rewards=zhengzhanshanhaiController.getRankeAttendrewards_ZZSH_Rank()
self.rankCfgs=zhengzhanshanhaiController.getRankeCfg_ZZSH_Rank()
self.rankTotalLen=#self.rankCfgs

zhengzhanshanhaiController.req_ZZSH_Rank()

self:addProNotify(20,253,self.recv_20_253)
self:addProNotify(44,253,self.recv_20_253)
end


function UIXM_ZZSH_RankInfoWin:__delete()

self:stopRankSettlementTimer()

_this=nil

self:unbindComponents()
end




function UIXM_ZZSH_RankInfoWin:onShow(argtable,afterOnloaded)

self.root:setChildCanvasGroupAlpha(0)
if zhengzhanshanhaiModel:isRecvRankInfo_ZZSH()then
self:refreshAll()
self.root:setChildCanvasGroupDOFade(1,0.2)
end
end


function UIXM_ZZSH_RankInfoWin:onHide()

end





function UIXM_ZZSH_RankInfoWin:onCloseBtn()
self:closeSelf()
end

function UIXM_ZZSH_RankInfoWin:onGivenBtn()
local rank_souce_get_way,rank_souce_get_tips=zhengzhanshanhaiController.getRankeGetWay_ZZSH_Rank()

local closeCallBack=function()
if _this==nil then return end
_this:closeSelf()
end
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
tips=rank_souce_get_tips,
gainWayList=rank_souce_get_way,
closeCallBack=closeCallBack,
outCheckGrayFuncs=checkGrayFuncs,
}
UIManager:showWindow("UICommonGainWayWin",args)
end

function UIXM_ZZSH_RankInfoWin:onRuleBtn()
local name=zhengzhanshanhaiController.getRankeRuleFmt_ZZSH_Rank()
local winName='UIRuleScrollViewWin'

local d={}
d.mode=3
d.title="规则说明"
d.name=name
d.showBlack=true
UIManager:showWindow(winName,d)
end


function UIXM_ZZSH_RankInfoWin:refreshAll()
self:refreshScrollView()

self:refreshSelfRankInfo()

self:refreshCountDown()

self:refreshOther()
end


function UIXM_ZZSH_RankInfoWin:refreshScrollView()
self.infoScrollView:initData('item',self.rankCfgs,self.rankTotalLen)
end

function UIXM_ZZSH_RankInfoWin:onStartAction()
end

function UIXM_ZZSH_RankInfoWin:onFreshAction(index,item)

local showRIcon=index<=3


item:SetChildActive(_CmpItemSlotIndex.rankIcon,showRIcon)
if showRIcon then
item:SetChildCSImageSprite(_CmpItemSlotIndex.rankIcon,globalABLookup.global,'icon_phbmingci_'..index)
end

item:SetChildText(_CmpItemSlotIndex.rank,index)

local rankCfg=self.rankCfgs[index]
local rankInfo=zhengzhanshanhaiModel:getRankInfoByRankIndex_ZZSH(index)
local isHasRankInfo=rankInfo~=nil

item:SetChildActive(_CmpItemSlotIndex.scores,isHasRankInfo)
item:SetChildActive(_CmpItemSlotIndex.info,isHasRankInfo)
item:SetChildActive(_CmpItemSlotIndex.signBgIcon,isHasRankInfo)

item:SetChildActive(_CmpItemSlotIndex.xwyd,not isHasRankInfo)
item:SetChildActive(_CmpItemSlotIndex.ctips,not isHasRankInfo)

if isHasRankInfo then

local signIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,rankInfo.xmImg.icon,'icon')
item:SetChildCSImageSprite(_CmpItemSlotIndex.signIcon,globalABLookup.xianmengicons,signIconName)

local signBgIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,rankInfo.xmImg.bg,'icon')
item:SetChildCSImageSprite(_CmpItemSlotIndex.signBgIcon,globalABLookup.xianmengicons,signBgIconName)

local signKuangIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,rankInfo.xmImg.kuang,'icon')
item:SetChildCSImageSprite(_CmpItemSlotIndex.signKuangIcon,globalABLookup.xianmengicons,signKuangIconName)


local serverName=loginModel:getServerName(rankInfo.server_id)
serverName=FMT.fmt("[{0}]",serverName)
item:SetChildText(_CmpItemSlotIndex.server,serverName)

item:SetChildText(_CmpItemSlotIndex.name,rankInfo.guildname)


item:SetChildText(_CmpItemSlotIndex.scores,rankInfo.score)
else
item:SetChildText(_CmpItemSlotIndex.xwyd,'虚位以待')


local ctipsStr=FMT.fmt("{0}积分可上榜",mathHelper.formatNumber4(rankCfg.min_score,1))
item:SetChildText(_CmpItemSlotIndex.ctips,ctipsStr)
end

item:SetChildButtonClick(_CmpItemSlotIndex.info,function()







end,true)


local rewards=rankCfg.rewards

local reward,isShow
for rindex,cindex in ipairs(_rewardCmpIndexList)do
reward=rewards[rindex]
isShow=reward~=nil
item:SetChildActive(cindex,isShow)
if isShow then
widgetHelper.setNormalRewardItem(item,cindex,reward)
end
end
end


function UIXM_ZZSH_RankInfoWin:refreshSelfRankInfo()
local selfGuildInfo=xianmengModel:getXMDetialData()
local guildId=selfGuildInfo.guildid
local isShow=mathHelper.validInt64(guildId)

self.myinfo:setActive(isShow)

if isShow then
local myInfoWb=self.myinfo:getWidgetBase()
local item=myInfoWb:GetChildWidgetBase(0)

local image=xianmengModel:getGuildImage()
local rankInfo=zhengzhanshanhaiModel:getRankInfoByGuildIdStr_ZZSH(tostring(guildId))
local selfRankIndex=zhengzhanshanhaiModel:getSelfRankIndex_ZZSH()

local ishasRankIndex=selfRankIndex~=nil

item:SetChildActive(_CmpItemSlotIndex.rank,true)
if ishasRankIndex then
item:SetChildText(_CmpItemSlotIndex.rank,selfRankIndex)
else
item:SetChildText(_CmpItemSlotIndex.rank,toColorString(FONT_COLOR.eRedColor,'未上榜'))
end

local isShowRankIcon=ishasRankIndex and selfRankIndex<=3
item:SetChildActive(_CmpItemSlotIndex.rankIcon,isShowRankIcon)

local signIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon')
item:SetChildCSImageSprite(_CmpItemSlotIndex.signIcon,globalABLookup.xianmengicons,signIconName)

local signBgIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon')
item:SetChildCSImageSprite(_CmpItemSlotIndex.signBgIcon,globalABLookup.xianmengicons,signBgIconName)

local signKuangIconName=cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon')
item:SetChildCSImageSprite(_CmpItemSlotIndex.signKuangIcon,globalABLookup.xianmengicons,signKuangIconName)


local serverid=selfGuildInfo.leaderserverid
local serverName=loginModel:getServerName(serverid)
serverName=FMT.fmt("[{0}]",serverName)
item:SetChildText(_CmpItemSlotIndex.server,serverName)

local guildname=selfGuildInfo.guildname
item:SetChildText(_CmpItemSlotIndex.name,guildname)


local score=rankInfo and rankInfo.score or 0
item:SetChildText(_CmpItemSlotIndex.scores,score)


item:SetChildActive(_CmpItemSlotIndex.xwyd,false)
item:SetChildActive(_CmpItemSlotIndex.ctips,false)


local rewards=ishasRankIndex and self.rankCfgs[selfRankIndex].rewards or self.attend_rewards

local reward,isShow
for rindex,cindex in ipairs(_rewardCmpIndexList)do
reward=rewards[rindex]
isShow=reward~=nil
item:SetChildActive(cindex,isShow)
if isShow then
widgetHelper.setNormalRewardItem(item,cindex,reward)
end
end
end
end


function UIXM_ZZSH_RankInfoWin:refreshCountDown()
local raceIndex=zhengzhanshanhaiController.getRaceIndex_ZZSH_Rank()


local isStartCountDown=raceIndex==-1

if isStartCountDown then
self.cd:setText('本赛季结束后结算')
else

self:startRankSettlementTimer()
end
end

function UIXM_ZZSH_RankInfoWin:startRankSettlementTimer()
self:stopRankSettlementTimer()

local curTime=timeHelper.getServerLongTime()
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()


local freshStage=function(time)
if startTime==nil or endTime==nil or settleTime==nil then return 0 end

local stage










if time>=startTime and time<settleTime then
stage=2
elseif time>=settleTime and time<settleEndTime then
stage=3
elseif time>=settleEndTime then
stage=0
end
return stage
end

local curLeftTime,stageNew
local func=function()
if _this==nil then return end
curTime=timeHelper.getServerLongTime()
stageNew=freshStage(curTime)

if stageNew==2 then
curLeftTime=settleTime-curTime
_this.cd:setText(FMT.fmt("赛季结算剩余时间：<color=#549327>{0}</color>",timeHelper.format_time_stamp3(curLeftTime)))
end

if stageNew==3 then
curLeftTime=settleEndTime-curTime
_this.cd:setText(FMT.fmt("榜单展示剩余时间：<color=#549327>{0}</color>",timeHelper.format_time_stamp3(curLeftTime)))
end

if stageNew==0 then
_this:stopRankSettlementTimer()
end
end

self.rankSettlementTimer=self:setTimer(1,0,func)
func()
end

function UIXM_ZZSH_RankInfoWin:stopRankSettlementTimer()
if self.rankSettlementTimer then
self:stopTimerByID(self.rankSettlementTimer)
self.rankSettlementTimer=nil
end
end


function UIXM_ZZSH_RankInfoWin:refreshOther()
end






function UIXM_ZZSH_RankInfoWin.recv_20_253()
if _this==nil then return end

_this.root:setChildCanvasGroupDOFade(1,0.2)
_this:refreshAll()
end
