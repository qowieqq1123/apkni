







def_class("UIXM_LXWJ_Enter_win",UIWindowBase)









function UIXM_LXWJ_Enter_win:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.bottomPanel=UIObject.get(self,2)
self.leftPanel=UIObject.get(self,3)
self.topPanel=UIObject.get(self,4)
self.rightPanel=UIObject.get(self,5)
self.middlePanel=UIObject.get(self,6)
self.ruleBtn=UIButton.get(self,7)
self.shopBtn=UIButton.get(self,8)
self.rewardBtn=UIButton.get(self,9)
self.zzbBtn=UIButton.get(self,10)
self.defBtn=UIButton.get(self,11)
self.xmInfoPanel=UIObject.get(self,12)
self.closeBtn=UIButton.get(self,13)
self.rankPanel=UIObject.get(self,14)
self.gotoBtn=UIButton.get(self,15)
self.joinBtn=UIButton.get(self,16)
self.joinXMBtn=UIButton.get(self,17)
self.selfZMInfoPanel=UIObject.get(self,18)
self.raceStateTimeTxt=UIText.get(self,19)
self.raceStateIcon=UIImage.get(self,20)
self.ranktBtn=UIButton.get(self,21)
self.rankGridPanel=UIObject.get(self,22)
self.rankSp=UIObject.get(self,23)
self.shareBtn=UIButton.get(self,24)
self.joinReward=UIObject.get(self,25)
self.raceTimeTxt=UIText.get(self,26)
self.raceTxt=UIText.get(self,27)
self.zzbReward=UIObject.get(self,28)
self.zzbIcon=UIImage.get(self,29)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.zzbBtn:setButtonClick(function()self:onZzbBtn()end)

self.defBtn:setButtonClick(function()self:onDefBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.joinBtn:setButtonClick(function()self:onJoinBtn()end)

self.joinXMBtn:setButtonClick(function()self:onJoinXMBtn()end)

self.ranktBtn:setButtonClick(function()self:onRanktBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UIXM_LXWJ_Enter_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.middlePanel);self.middlePanel=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.zzbBtn);self.zzbBtn=nil;
_UIObject_release(self.defBtn);self.defBtn=nil;
_UIObject_release(self.xmInfoPanel);self.xmInfoPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.rankPanel);self.rankPanel=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.joinBtn);self.joinBtn=nil;
_UIObject_release(self.joinXMBtn);self.joinXMBtn=nil;
_UIObject_release(self.selfZMInfoPanel);self.selfZMInfoPanel=nil;
_UIObject_release(self.raceStateTimeTxt);self.raceStateTimeTxt=nil;
_UIObject_release(self.raceStateIcon);self.raceStateIcon=nil;
_UIObject_release(self.ranktBtn);self.ranktBtn=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
_UIObject_release(self.rankSp);self.rankSp=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.joinReward);self.joinReward=nil;
_UIObject_release(self.raceTimeTxt);self.raceTimeTxt=nil;
_UIObject_release(self.raceTxt);self.raceTxt=nil;
_UIObject_release(self.zzbReward);self.zzbReward=nil;
_UIObject_release(self.zzbIcon);self.zzbIcon=nil;
end
















local _this=nil


function UIXM_LXWJ_Enter_win:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onXianMengChange,self.onXianMengChange)
self:addNotify(notifyConfig.onXianMengLevelChange,self.onXianMengLevelChange)
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)


end


function UIXM_LXWJ_Enter_win:__delete()
_this=nil
self:unbindComponents()
UIManager:closeWindow('UIXM_LXWJ_BattleWin')
UIManager:closeWindow('UIXM_LXWJ_Effect_win')

end


function UIXM_LXWJ_Enter_win:onHide()

end

function UIXM_LXWJ_Enter_win.onXianMengChange(flag)
if _this==nil then return end
if not flag then
_this:refreshXMInfo()
_this:refreshInfo()
end
end

function UIXM_LXWJ_Enter_win.onXianMengLevelChange(oldlv,lv)
if _this==nil then return end
if oldlv==0 then

_this.joinXMBtn:setActive(false)
lingxuwenjianModel:checkBaseDataRefersh()
end
end

function UIXM_LXWJ_Enter_win.onLimitActStateChange(actID,state,isNew)
if _this==nil then return end
if actID~=LIMIT_ACT_TYPE.eLingXuWenJian then return end
if state==limitActivitiesModel.actDoingState then

_this:refreshRaceTxt()
_this:refreshZZBBtn()
elseif state==limitActivitiesModel.actFinishState then
_this:refreshZZBBtn()
end
end




function UIXM_LXWJ_Enter_win:onShow(argtable,afterOnloaded)
self.isFull=argtable.isFull
local extraParams=argtable.extraParams
self:refreshRaceTxt()
self:refreshTime()
self:refreshRank()
self:refreshJoinReward()
self:refreshZZBBtn()

local has_xm=xianmengModel:hasXM()
self.joinXMBtn:setActive(not has_xm)
if has_xm then
if lingxuwenjianModel:checkBaseDataRefersh()then
self.xmInfoPanel:setActive(false)
self.selfZMInfoPanel:setActive(false)
else
self:refreshXMInfo()
self:refreshInfo()
end
else
lingxuwenjianModel:checkRefreshRank1()
end

if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
end

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4791,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.25,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,function()
if _this==nil then return end
_this:openBeginWin()
end)
end)
end)
self.rankSp:setChildUIModelShowTarget(4793,1,{},0,false,false,0,nil)
UIManager:showWindow('UIXM_LXWJ_Effect_win')
end


local checkJump=false
if extraParams.openBattle then
if xianmengModel:hasXM()and lingxuwenjianModel:isBaoMing()and self.raceState~=eLXWJ_State.eIdle then
if not UIManager:isActive('UIXM_LXWJ_BattleWin')then
checkJump=true
lingxuwenjianController:enterBattleScene({openPos=extraParams.openPos})
end
end
elseif extraParams.openPos then
if xianmengModel:hasXM()and lingxuwenjianModel:isBaoMing()and self.raceState~=eLXWJ_State.eIdle then
checkJump=true
if not UIManager:isActive('UIXM_LXWJ_BattleWin')then
lingxuwenjianController:enterBattleScene({openPos=extraParams.openPos})
else
UIManager:invokeUIMethod('UIXM_LXWJ_BattleWin','doOpenPos',extraParams.openPos)
end
end
end
if not checkJump then
lingxuwenjianController:doCloseCloud()
end










end

function UIXM_LXWJ_Enter_win:openBeginWin()
self:delayDo(0.5,function()
local isIn=newbieControl.isInNewbie()
local raceIndex=lingxuwenjianModel:getRaceIndex()
if not isIn and lingxuwenjianModel:checkFisrtEnter(raceIndex)then
UIManager:showWindow('UIXM_LXWJ_beginWin')
lingxuwenjianModel:markFisrtEnter(raceIndex)
end
end)
end

function UIXM_LXWJ_Enter_win:refreshRaceTxt()
local raceIndex=lingxuwenjianModel:getRaceIndex()
local race_str=tostring(raceIndex)
self.raceTxt:setText(race_str)
end

function UIXM_LXWJ_Enter_win:refreshTime()

local isDoing=limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eLingXuWenJian)
local race_time_str
if isDoing then
local lefttime=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eLingXuWenJian)

if lefttime<=604800 then
race_time_str=FMT.fmt('赛季剩余：<color=#8b3a10>{0}</color>',timeHelper.format_time_stamp3(lefttime))
else
local endTime_l=timeHelper.getServerLongTime()+lefttime
local battleWeek=cfgHelper.get2(cfg_lingxuwenjianconfig_get,1,'battle')
local startTime_l=endTime_l-(battleWeek*7*24*60*60)
local start_m=tonumber(timeHelper.dateServerStamp('%m',startTime_l))
local start_d=tonumber(timeHelper.dateServerStamp('%d',startTime_l))
local startDate=string.format('%d月%d日',start_m,start_d)
if pfwindowslController:checkIsGameVersion_yuenan()then
startDate=string.format('%d月%d日',start_d,start_m)
end
local end_m=tonumber(timeHelper.dateServerStamp('%m',endTime_l-3600))
local end_d=tonumber(timeHelper.dateServerStamp('%d',endTime_l-3600))
local endDate=string.format('%d月%d日',end_m,end_d)
if pfwindowslController:checkIsGameVersion_yuenan()then
endDate=string.format('%d月%d日',end_d,end_m)
end
race_time_str=string.format("%s~%s",startDate,endDate)
end
else
race_time_str=''
end
self.raceTimeTxt:setText(race_time_str)

local raceState,left,left2=lingxuwenjianModel:getLunState()
local raceState_old=self.raceState
self.raceState=raceState
if self.raceState~=raceState_old then
local abname,icon=lingxuwenjianModel:getLunStateIcon(self.raceState)
self.raceStateIcon:setSprite(abname,icon)
end
local left_
if raceState==eLXWJ_State.eFight and lingxuwenjianModel:checkBattleResult()~=nil then
left_=left2
else
left_=left
end
local state_str=FMT.fmt('剩余：{0}',timeHelper.format_time_stamp2(left_))






self.raceStateTimeTxt:setText(state_str)
end

function UIXM_LXWJ_Enter_win:refreshXMInfo()
local has_xm=xianmengModel:hasXM()
self.xmInfoPanel:setActive(has_xm)
self.joinXMBtn:setActive(not has_xm)
if has_xm then
local widget=self.xmInfoPanel:getWidgetBase()
local image=xianmengModel:getGuildImage()
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local lv=xianmengModel:getXMLevel()
widget:SetChildText(3,FMT.fmt('{0}级',lv))

local name=xianmengModel:getXMName()
widget:SetChildText(4,FMT.fmt('仙盟：{0}',name))

local maxNum=xianmengModel.getXMMaxMemberNum(lv)
local curNum=xianmengModel:getXMMemberNum()
widget:SetChildText(6,FMT.fmt('人数：{0}/{1}',curNum,maxNum))

self:refreshXMRank(widget)

self:refreshScore(widget)
end
end

function UIXM_LXWJ_Enter_win:refreshZZBBtn()
if self.zzbIconShow==nil then
self.zzbIconShow=true
local abname=globalABLookup.mainEntrySprite
local iconname='button_hdrk_0027'
self.zzbIcon:setSprite(abname,iconname)
end

local isShow=not limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eLingXuWenJian)and limitActivitiesModel:checkActOpen(LIMIT_ACT_TYPE.eLingXuWenJian)
self.zzbBtn:setActive(isShow)
local isReddot=lingxuwenjianModel:checkLikeRedot()
self.zzbReward:setActive(isReddot)
end

function UIXM_LXWJ_Enter_win:refreshXMRank(widget)
if widget==nil then
widget=self.xmInfoPanel:getWidgetBase()
end
local rank=lingxuwenjianModel:getRank()
local rank_str
if rank~=nil and rank>0 then
rank_str=tostring(rank)
else
rank_str='未上榜'
end
widget:SetChildText(5,FMT.fmt('排名：{0}',rank_str))
end

function UIXM_LXWJ_Enter_win:refreshScore(widget)
if widget==nil then
widget=self.xmInfoPanel:getWidgetBase()
end
local score=lingxuwenjianModel:getScore()
local abname,icon,name=lingxuwenjianModel:getScoreCfg(score)
widget:SetChildCSImageSprite(7,abname,icon)
local score_str=FMT.fmt('{0}({1})',name,score)
widget:SetChildText(8,score_str)
end

function UIXM_LXWJ_Enter_win:refreshJoinReward()
local isBM=lingxuwenjianModel:isBaoMing()
self.joinReward:setActive(not isBM)
end

function UIXM_LXWJ_Enter_win:refreshInfo()
local has_xm=xianmengModel:hasXM()
local isBM=lingxuwenjianModel:isBaoMing()

self.joinBtn:setActive(has_xm and not isBM)
self.gotoBtn:setActive(has_xm and isBM)
self.selfZMInfoPanel:setActive(has_xm and isBM)

if has_xm and isBM then
local widget=self.selfZMInfoPanel:getWidgetBase()

local headParams={iconInfo=nil,scale=0.7}
playerController:setHeadIcon(widget,0,headParams)

widget:SetChildText(1,playerModel:getActorName())

local timesList=lingxuwenjianModel:getTimes()
local defrate=0
if timesList[4]~=nil and timesList[4]>0 then
defrate=timesList[3]/timesList[4]
defrate=mathHelper.decimal(defrate*100,1)
end
widget:SetChildText(2,FMT.fmt('防守总胜率：<color=#7d3b17>{0}%</color>',defrate))
local atkrate=0
if timesList[2]~=nil and timesList[2]>0 then
atkrate=timesList[1]/timesList[2]
atkrate=mathHelper.decimal(atkrate*100,1)
end
widget:SetChildText(3,FMT.fmt('进攻总胜率：<color=#7d3b17>{0}%</color>',atkrate))
local wjrate=0
if timesList[6]~=nil and timesList[6]>0 then
wjrate=timesList[5]/timesList[6]
wjrate=mathHelper.decimal(wjrate*100,1)
end
widget:SetChildText(4,FMT.fmt('问剑总胜率：<color=#7d3b17>{0}%</color>',wjrate))
local bestnum=timesList[7]or 0
widget:SetChildText(5,FMT.fmt('全场最佳：<color=#7d3b17>{0}次</color>',bestnum))
end
end

function UIXM_LXWJ_Enter_win:refreshRank()
self.rankPanel:setActive(true)
local rankList=lingxuwenjianModel:getRankTopThree()or{}
local num=#rankList
num=math.max(num,3)
local func=function(i)
if _this==nil then return end
local item=_this.rankGridPanel:getChildLayoutGroupGridItem(i-1)
local data=rankList[i]
local isshow=data~=nil
local rank=i
item:SetChildText(0,tostring(rank))
local name_str
local tips_str
if isshow then
name_str=data.guildname
tips_str=''
else
name_str=''
tips_str='虚位以待'
end
item:SetChildText(1,name_str)
item:SetChildText(2,tips_str)
end
self.rankGridPanel:setChildLayoutGroupCreateItems(num,func)
end

function UIXM_LXWJ_Enter_win:onDefBtn()
local isBM=lingxuwenjianModel:isBaoMing()
if isBM then
local raceState=lingxuwenjianModel:getLunState()
if raceState==eLXWJ_State.eFight then
UIManager.error('决战阶段不能设置防守阵容')
return
end
end
lingxuwenjianController.setupDefTeams(1)
end

function UIXM_LXWJ_Enter_win:onRuleBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eLingXuWenJian
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end

function UIXM_LXWJ_Enter_win:onCloseBtn()
if self.isFull then
UIFullCommonControl:closeUI()
else
self:closeSelf()
end
end

function UIXM_LXWJ_Enter_win:onRanktBtn()
UIManager:showWindow('UIXM_LXWJ_RankMainWin')
end

function UIXM_LXWJ_Enter_win:onJoinXMBtn()
if not xianmengModel:hasXM()then
xianmengController:openJoinWin()
end
end

function UIXM_LXWJ_Enter_win:onJoinBtn()
local isBM=lingxuwenjianModel:isBaoMing()
if not isBM then
UIManager.error('请先设置防守阵容')

lingxuwenjianController.setupDefTeams(1)
return
end
end

function UIXM_LXWJ_Enter_win:onGotoBtn()
if self.raceState==eLXWJ_State.eIdle then
UIManager.error('休战阶段无法进入')
return
end
lingxuwenjianController:enterBattleScene({})
end

function UIXM_LXWJ_Enter_win:onRewardBtn()
UIManager:showWindow('UIXM_LXWJ_RewardMainWin')
end

function UIXM_LXWJ_Enter_win:onShareBtn()
local jsonStr=''
local args={
title='战绩分享',
jsonStr=jsonStr,
counterType=gameCounterType.eLingXuWenJianShareNum,
regexType=CHAT_REGEX_TYPE.eShareLXWJ,
shareBack=function()

end
}
UIManager:showWindow('UICommonShareWin',args)
end

function UIXM_LXWJ_Enter_win:rec_baseData()
self:refreshXMInfo()
self:refreshInfo()
self:refreshRank()
end

function UIXM_LXWJ_Enter_win:rec_ranklist()
self:refreshRank()
end

function UIXM_LXWJ_Enter_win:rec_rank()
self:refreshXMRank()
end

function UIXM_LXWJ_Enter_win:rec_score()
self:refreshScore()
end

function UIXM_LXWJ_Enter_win:rec_baoming()
self:refreshInfo()
self:refreshJoinReward()
end

function UIXM_LXWJ_Enter_win:onShopBtn()
funcShopController:openShopWin({shopId=eFuncShopType.eZhanGong})
end

function UIXM_LXWJ_Enter_win:onZzbBtn()
UIManager:showWindow('UIXM_LXWJ_zhizunbang_win')
end

function UIXM_LXWJ_Enter_win:rec_like(rank)
self:refreshZZBBtn()
end