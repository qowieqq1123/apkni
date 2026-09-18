







def_class("UISubAct_XMHB_mainWin",UIWindowBase)









function UISubAct_XMHB_mainWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.leftBtn=UIButton.get(self,1)
self.rightBtn=UIButton.get(self,2)
self.rewardScrollView=UIObject.get(self,3)
self.rewardContent=UIObject.get(self,4)
self.rewardProgressBar=UIObject.get(self,5)
self.rewardProgress=UIObject.get(self,6)
self.closeBtn=UIButton.get(self,7)
self.scoreText=UIText.get(self,8)
self.helpBtn=UIButton.get(self,9)
self.hongbaoPanel=UIObject.get(self,10)
self.hongBaoItemCenter=UIObject.get(self,11)
self.hongBaoItemLeft=UIObject.get(self,12)
self.hongBaoItemRight=UIObject.get(self,13)
self.hongbaoModel=UIObject.get(self,14)
self.catModel=UIObject.get(self,15)
self.timeText=UIText.get(self,16)
self.mask=UIObject.get(self,17)
self.tipsBtn=UIButton.get(self,18)
self.sendRewardPanel=UIObject.get(self,19)
self.sendRwScrollView=UIObject.get(self,20)
self.tipsText=UIText.get(self,21)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)



end


function UISubAct_XMHB_mainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewardProgress);self.rewardProgress=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.scoreText);self.scoreText=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.hongbaoPanel);self.hongbaoPanel=nil;
_UIObject_release(self.hongBaoItemCenter);self.hongBaoItemCenter=nil;
_UIObject_release(self.hongBaoItemLeft);self.hongBaoItemLeft=nil;
_UIObject_release(self.hongBaoItemRight);self.hongBaoItemRight=nil;
_UIObject_release(self.hongbaoModel);self.hongbaoModel=nil;
_UIObject_release(self.catModel);self.catModel=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.sendRewardPanel);self.sendRewardPanel=nil;
_UIObject_release(self.sendRwScrollView);self.sendRwScrollView=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
end















local UIPrepareEnScroller=simple_class(UIEnhancedScroller)
local _this
local _hongBaoItemCmpIdx={
titleIcon=0,
addItem=1,
selectItem=2,
changeBtn=3,
descGroup=4,
buyBtn=5,
costText=6,
useCountText=7,
cannotBuyTips=8,
}
local hongBaoSpineAnimParams={
[1]={
idle=3653,
left=nil,
right=3661,
send=3657,
},
[2]={
idle=3654,
left=3666,
right=3662,
send=3658,
},
[3]={
idle=3655,
left=3665,
right=3663,
send=3659,
},
[4]={
idle=3656,
left=3664,
right=nil,
send=3660,
},
}




function UISubAct_XMHB_mainWin:onLoaded(...)
_this=self
self:bindComponents()




self._onXMHBPlayerDataChange=function(...)
self:onXMHBPlayerDataChange(...)
end
self._onXMHBGuildDataChange=function(...)
self:onXMHBGuildDataChange(...)
end
self:addNotify(notifyConfig.onXMHBPlayerDataChange,self._onXMHBPlayerDataChange)
self:addNotify(notifyConfig.onXMHBGuildDataChange,self._onXMHBGuildDataChange)






end


function UISubAct_XMHB_mainWin:__delete()
_this=nil
self:clearTimer()
self:unbindComponents()
end




function UISubAct_XMHB_mainWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
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


self.myData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.sub_actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

self.beginTime=self.sub_actInfo.start_time
self.endTime=self.sub_actInfo.end_time


local cannotBuyCd=self.config.end_send_hb_time or 0
self.cannotBuyCdTime=self.endTime-cannotBuyCd
local nowTime=gameUtilityModel.getServerShortTime()
self.isCanBuy=nowTime<self.cannotBuyCdTime

local bgModelId=self.config.bgSpineId
if afterOnloaded then
if bgModelId then
self.bgModel:setChildUIModelShowTarget(bgModelId,1,{},eAnimationID.stand)
end
self.catModel:setChildUIModelShowTarget(6522,1,{},eAnimationID.stand)
end

self.selectItemIdx=1
local animParams=hongBaoSpineAnimParams[self.selectItemIdx]
local hbModelAnimId=animParams.idle
self.hongbaoModel:setChildUIModelShowTarget(6521,1,{},hbModelAnimId)

self:refresh()

self:clearFadeTweener()
self.hongbaoPanel:setChildCanvasGroupAlpha(0)
self.fadeTweener=self.hongbaoPanel:setChildCanvasGroupDOFade(1,0.5)


self:setRemainingTimeTimer()
end


function UISubAct_XMHB_mainWin:onHide()
self:clearTimer()
end

function UISubAct_XMHB_mainWin:refresh(isIgnoreChangeAnim)

self:refreshHongBaoPanel(isIgnoreChangeAnim)


self:refreshProgressPanel()

end


function UISubAct_XMHB_mainWin:refreshHongBaoPanel(isIgnoreChangeAnim)
self.hbLvCfgList=self.config.hongbao_level_conf
self.hbAllCfgList=self.config.hongbao_conf
local dataNum=#self.hbLvCfgList



local widget=self.hongBaoItemCenter:getWidgetBase()
self:onRefreshHongBaoItem(self.selectItemIdx,widget)











local isShowLeft=self.selectItemIdx>1
local isShowRight=self.selectItemIdx<dataNum


self.leftBtn:setActive(isShowLeft)
self.rightBtn:setActive(isShowRight)


self:refreshSendRewardPanel()


local desc=self.config.endSendHbTips
self.tipsText:setText(desc)
end


function UISubAct_XMHB_mainWin:refreshSendRewardPanel()

local hbLv=self.selectItemIdx
local hbId=self:getNowSelectLevelHbId(hbLv)or nil
local sendRewardList
if hbId then
local hbCfg=self.hbAllCfgList[hbLv]and self.hbAllCfgList[hbLv][hbId]or nil
if hbCfg then
sendRewardList=hbCfg[4]
end
end

local isShowSendRwPanel=sendRewardList and next(sendRewardList)~=nil or false
self.sendRewardPanel:setActive(isShowSendRwPanel)

if isShowSendRwPanel then
local count=#sendRewardList
self.sendRwScrollView:setChildScrollViewCreateGrids(count,count)
local grids=self.sendRwScrollView:getChildScrollViewItemWidgets()
for index=1,grids.Count do
local widget=grids[index-1]
local reward=sendRewardList[index]
if reward then
widget:SetChildActive(-1,true)
local itemWidget=widget:GetChildWidgetBase(1)
local itemId=reward[1]
local itemCount=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
if _this==nil or not _this.isVisible then return end
return self:onClickRewardItem(...)
end)
else
widget:SetChildActive(-1,false)
end
end
end
end

function UISubAct_XMHB_mainWin:refreshProgressPanel(isInit)
local progressRwList=self.config.score_reward
local count=#progressRwList
self.rewardScrollView:setChildScrollViewCreateGrids(count,count)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
local maxGotIdx=self.myData.scoreGotRewardIdx
local score=self.myData.score
local progressPercent=0
local singlePercent=1/count
local lastTargetScore=0
local firstReddotIdx
for i=1,grids.Count do
local widget=grids[i-1]
local rewardCfg=progressRwList[i]
if rewardCfg then
widget:SetChildActive(-1,true)

local targetScore=rewardCfg[1]

widget:SetChildText(0,targetScore)


local isGot=i<=maxGotIdx
widget:SetChildActive(2,isGot)


local isCanGet=score>=targetScore
local reddot=isCanGet and not isGot
widget:SetChildActive(3,reddot)
if reddot and not firstReddotIdx then
firstReddotIdx=i
end

local rewardItem=rewardCfg[2][1]
local itemWidget=widget:GetChildWidgetBase(1)
local itemId=rewardItem[1]
local itemCount=rewardItem[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemCount)
end
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
if _this==nil or not _this.isVisible then return end
if isCanGet and not isGot then
return self:onClickGotRewardBtn()
else
return self:onClickRewardItem(...)
end
end)

if score>=lastTargetScore then
local percent
if isCanGet then
percent=singlePercent
else
percent=(score-lastTargetScore)/(targetScore-lastTargetScore)*singlePercent
end
progressPercent=progressPercent+percent
end
lastTargetScore=targetScore
else
widget:SetChildActive(-1,false)
end
end


local height=10
local itemWidth=80
local itemSpace=57
local extraWidth=200
local progressAllWidth=(itemWidth+itemSpace)*count-itemWidth/2
local progressWidth=progressAllWidth*progressPercent+extraWidth
if score<=0 then
progressWidth=0
end
self.rewardProgress:setChildSizeDelta(progressWidth,height)
self.scoreText:setText(FMT.fmt("{0}分",score))

if isInit then

local idx=firstReddotIdx or maxGotIdx
local jumpIdx=count-idx
self.rewardScrollView:setChildScrollRectEnable(false)
self.rewardScrollView:setChildScrollViewSelectItem(jumpIdx,false,false,true)
self.rewardScrollView:setChildScrollRectEnable(true)
end
end


function UISubAct_XMHB_mainWin:getNowSelectLevelHbId(hbLv)
local _key=FMT.fmt('actid{0}_subtype{1}_subid{2}',self.activityId,self.subType,self.subId)
local localData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengHongBaoAct,_key,{})
local hbId=localData[tostring(hbLv)]
return hbId
end

function UISubAct_XMHB_mainWin:onRefreshHongBaoItem(dataIndex,widget,ignoreCheckMaxSend)
local index=dataIndex
local hbLvCfg=self.hbLvCfgList[index]
if hbLvCfg then
widget:SetChildActive(-1,true)
local hbLv=index
local hbRechargeId=hbLvCfg[1]
local hbPeopleNum=hbLvCfg[2]
local hbScore=hbLvCfg[3]
local hbShowParamList=self.config.hongbaoShowParam
local hbShowParam=hbShowParamList[hbLv]










local _key=FMT.fmt('actid{0}_subtype{1}_subid{2}',self.activityId,self.subType,self.subId)
local localData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianMengHongBaoAct,_key,{})
local hbId=localData[tostring(hbLv)]
local isSelect=hbId~=nil
widget:SetChildActive(_hongBaoItemCmpIdx.addItem,not isSelect)
widget:SetChildActive(_hongBaoItemCmpIdx.selectItem,isSelect)
widget:SetChildActive(_hongBaoItemCmpIdx.changeBtn,isSelect)
widget:SetChildActive(_hongBaoItemCmpIdx.useCountText,isSelect and self.isCanBuy)
widget:SetChildActive(_hongBaoItemCmpIdx.cannotBuyTips,not self.isCanBuy)
widget:SetChildActive(_hongBaoItemCmpIdx.buyBtn,self.isCanBuy)
if isSelect then

local hbCfgList=self.hbAllCfgList[hbLv]
local hbCfg=hbCfgList[hbId]
if hbCfg then
local itemWidget=widget:GetChildWidgetBase(_hongBaoItemCmpIdx.selectItem)
local itemId=hbCfg[1]
local itemCount=hbCfg[2]
local countStr=mathHelper.formatNumber(itemCount)
local showCountBG=true
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
itemWidget:SetBaseItemClickEvent(0,function(...)
if _this==nil or not _this.isVisible then return end
self:onClickRewardItem(...)
end)


end


widget:SetChildButtonClick(_hongBaoItemCmpIdx.changeBtn,function()
if _this==nil or not _this.isVisible then return end
return self:onClickSelectItemBtn(hbLv,hbId)
end,true)


local itemMaxUseCount=hbCfg[3]
local useCount=self.sub_actInfo:getSendHBCount(hbLv,hbId)
widget:SetChildText(_hongBaoItemCmpIdx.useCountText,FMT.fmt("发送次数：{0}/{1}",useCount,itemMaxUseCount))

if not ignoreCheckMaxSend and useCount>=itemMaxUseCount then
localData[tostring(hbLv)]=nil
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXianMengHongBaoAct,_key,localData)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXianMengHongBaoAct)
return self:onRefreshHongBaoItem(dataIndex,widget,true)
end
else

widget:SetChildButtonClick(_hongBaoItemCmpIdx.addItem,function()
if _this==nil or not _this.isVisible then return end
return self:onClickSelectItemBtn(hbLv)
end,true)
end


local hbDescList=self.config.hongbaoDesc
local descGrids=widget:GetChildCommonLayoutGroupWidgetList(_hongBaoItemCmpIdx.descGroup)
for i=1,descGrids.Count do
local descWidget=descGrids[i-1]
local descStr=hbDescList[i]
if descStr then
descWidget:SetChildActive(-1,true)
local str=FMT.fmt(descStr,hbPeopleNum,hbScore)
descWidget:SetChildText(0,str)
else
descWidget:SetChildActive(-1,false)
end
end


local rechargeCfg=cfgHelper.get1(cfg_rechargeconfig_get,hbRechargeId)

local moneyStr=pfwindowslController:showDesc_ByMoneyType(rechargeCfg)
widget:SetChildText(_hongBaoItemCmpIdx.costText,FMT.fmt("{0}发送",moneyStr))


widget:SetChildButtonClick(_hongBaoItemCmpIdx.buyBtn,function()
if _this==nil or not _this.isVisible then return end
return self:onClickBuyBtn(hbLv,hbId)
end,true)
end
end

function UISubAct_XMHB_mainWin:refreshNowHongBaoItems()
self:refreshHongBaoPanel()
end


function UISubAct_XMHB_mainWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动时间：{0}",timeHelper.format_time_stamp11(lerp,true)))
local isCanBuy=nowTime<self.cannotBuyCdTime
if self.isCanBuy and not isCanBuy then
self.isCanBuy=isCanBuy
self:refresh()
end
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_XMHB_mainWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_XMHB_mainWin:clearFadeTweener()
if self.fadeTweener~=nil then
self.fadeTweener:Complete()
self.fadeTweener:Kill()
self.fadeTweener=nil
end
end

function UISubAct_XMHB_mainWin:playSendAnim(hbInfo)
self.isPlayingAnim=true
self.mask:setActive(true)
self:clearFadeTweener()
self.fadeTweener=self.hongbaoPanel:setChildCanvasGroupDOFade(0,0.5)
self.bgModel:setChildModelAnimationState(eAnimationID.enter)
self.catModel:setChildModelAnimationState(eAnimationID.enter)
local animParams=hongBaoSpineAnimParams[self.selectItemIdx]
local animId=animParams.send
self.hongbaoModel:setChildModelAnimationState(animId)

local hbLv=hbInfo.level
local hbId=hbInfo.hb_id
local sendRewardList
if hbId then
local hbCfg=self.hbAllCfgList[hbLv]and self.hbAllCfgList[hbLv][hbId]or nil
if hbCfg and hbCfg[4]then
sendRewardList={}
local sendRewardCfg=hbCfg[4]
for i,reward in ipairs(sendRewardCfg)do
local itemId=reward[1]
local itemCount=reward[2]
sendRewardList[#sendRewardList+1]={itemid=itemId,num=itemCount}
end
end
end

self.animTimer=self:delayDo(3,function()
self:refresh(true)
self:clearFadeTweener()
self.fadeTweener=self.hongbaoPanel:setChildCanvasGroupDOFade(1,0.5)
self.mask:setActive(false)
UIManager.info("已分享红包至仙盟频道")
if sendRewardList and next(sendRewardList)~=nil then
showPrizeControl.showWindow(sendRewardList)
end
end)
end



































function UISubAct_XMHB_mainWin:onXMHBPlayerDataChange(act_id,sub_act_type,sub_act_id)
if act_id~=self.activityId or sub_act_type~=self.subType or sub_act_id~=self.subId then

return
end
if self.isPlayingAnim then

return
end


self:refreshNowHongBaoItems()


self:refreshProgressPanel()
end

function UISubAct_XMHB_mainWin:onXMHBGuildDataChange()

end


































































































function UISubAct_XMHB_mainWin:onLeftBtn()
local jumpIdx=self.selectItemIdx-1
if jumpIdx<1 then
return
end

local animParams=hongBaoSpineAnimParams[self.selectItemIdx]
local animId=animParams.left
local delayTime=0.5
if not animId then
animParams=hongBaoSpineAnimParams[jumpIdx]
animId=animParams.idle
delayTime=nil
end

self.hongbaoModel:setChildModelAnimationState(animId)
self.selectItemIdx=jumpIdx
self:clearFadeTweener()
self.hongbaoPanel:setChildCanvasGroupAlpha(0)
self:refreshHongBaoPanel()

local finishFunc=function()
local tweenTime=0.5
self.fadeTweener=self.hongbaoPanel:setChildCanvasGroupDOFade(1,tweenTime)
end

if delayTime then
self:delayDo(delayTime,finishFunc)
else
return finishFunc()
end
end



function UISubAct_XMHB_mainWin:onRightBtn()
local jumpIdx=self.selectItemIdx+1
if jumpIdx>#_this.hbLvCfgList then
return
end

local animParams=hongBaoSpineAnimParams[self.selectItemIdx]
local animId=animParams.right
local delayTime=0.5
if not animId then
animParams=hongBaoSpineAnimParams[jumpIdx]
animId=animParams.idle
delayTime=nil
end
self.hongbaoModel:setChildModelAnimationState(animId)

self.selectItemIdx=jumpIdx
self:clearFadeTweener()
self.hongbaoPanel:setChildCanvasGroupAlpha(0)
self:refreshHongBaoPanel()

local finishFunc=function()
local tweenTime=0.5
self.fadeTweener=self.hongbaoPanel:setChildCanvasGroupDOFade(1,tweenTime)
end

if delayTime then
self:delayDo(delayTime,finishFunc)
else
return finishFunc()
end
end


function UISubAct_XMHB_mainWin:onCloseBtn()
self:closeSelf()
end

function UISubAct_XMHB_mainWin:onHelpBtn()
local langId=self.config.ruleLangId
local d={}
d.title='规则'
d.mode=3
d.name=langId
d.showBlack=true
self:showWindow('UIRuleWin',d)
end

function UISubAct_XMHB_mainWin:onTipsBtn()
local offset=Vector2.New(0,35)
local desc=self.config.endSendHbTips
self:showWindow('UIConditionTipsThree',{showType=2,
str=desc,
posItem=self.tipsBtn,
pos=offset,
maxWidth=338})
end

function UISubAct_XMHB_mainWin:onClickSelectItemBtn(hbLv,hbId)
self:showWindow("UISubAct_XMHB_selectWin",{act_id=self.activityId,
sub_act_type=self.subType,
sub_act_id=self.subId,
hbLv=hbLv,
hbId=hbId})
end

function UISubAct_XMHB_mainWin:onClickBuyBtn(hbLv,hbId)

local hasXM=xianmengModel:hasXM()
if not hasXM then
return UIManager.error("请先加入仙盟！")
end


local hbCfgList=self.hbAllCfgList[hbLv]
local hbCfg=hbCfgList[hbId]
local maxUseCount=0
local useCount=self.sub_actInfo:getSendHBCount(hbLv,hbId)
if hbCfg then
maxUseCount=hbCfg[3]
else
UIManager.error("请先选择红包")
return self:onClickSelectItemBtn(hbLv)
end
if useCount>=maxUseCount then
return UIManager.error("该红包发送次数已达上限")
end

local actID=self.activityId
local subType=self.subType
local subID=self.subId

local hbLvCfg=self.hbLvCfgList[hbLv]
if hbLvCfg then
local rechargeId=hbLvCfg[1]
local info={hbLv,hbId}
local params=payControl.getActivityPayParams(actID,subType,subID,info)
payControl.reqPay(rechargeId,1,params)
end
end

function UISubAct_XMHB_mainWin:onClickGotRewardBtn()
call_activitiesHandle_func("activitiesHandle_xianmenghongbao","reqGetScoreReward",self.activityId,self.subId)
end

function UISubAct_XMHB_mainWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end