







def_class("UILingZhenPZMainWin",UIWindowBase)









function UILingZhenPZMainWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.closeTx=UIText.get(self,1)
self.selectCampPanel=UIObject.get(self,2)
self.startGamePanel=UIObject.get(self,3)
self.tipsText=UIText.get(self,4)
self.helpBtn=UIButton.get(self,5)
self.campShowPanel1=UIObject.get(self,6)
self.campShowPanel2=UIObject.get(self,7)
self.todayTopScore=UIText.get(self,8)
self.startBtn=UIButton.get(self,9)
self.ruleBtn=UIButton.get(self,10)
self.shopBtn=UIButton.get(self,11)
self.lianzhiBtn=UIButton.get(self,12)
self.timeText=UIText.get(self,13)
self.selectCampBtn1=UIButton.get(self,14)
self.selectCampBtn2=UIButton.get(self,15)
self.bgModel=UIObject.get(self,16)
self.progressRewardScrollView=UIObject.get(self,17)
self.progressContent=UIObject.get(self,18)
self.progressBar=UIObject.get(self,19)
self.progressValue=UIObject.get(self,20)
self.speakObj1=UIObject.get(self,21)
self.speakObj2=UIObject.get(self,22)
self.speakText1=UIText.get(self,23)
self.speakText2=UIText.get(self,24)
self.randomCampBtn=UIButton.get(self,25)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.lianzhiBtn:setButtonClick(function()self:onLianzhiBtn()end)

self.selectCampBtn1:setButtonClick(function()self:onSelectCampBtn1()end)

self.selectCampBtn2:setButtonClick(function()self:onSelectCampBtn2()end)

self.randomCampBtn:setButtonClick(function()self:onRandomCampBtn()end)



end


function UILingZhenPZMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeTx);self.closeTx=nil;
_UIObject_release(self.selectCampPanel);self.selectCampPanel=nil;
_UIObject_release(self.startGamePanel);self.startGamePanel=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.campShowPanel1);self.campShowPanel1=nil;
_UIObject_release(self.campShowPanel2);self.campShowPanel2=nil;
_UIObject_release(self.todayTopScore);self.todayTopScore=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.lianzhiBtn);self.lianzhiBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.selectCampBtn1);self.selectCampBtn1=nil;
_UIObject_release(self.selectCampBtn2);self.selectCampBtn2=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.progressRewardScrollView);self.progressRewardScrollView=nil;
_UIObject_release(self.progressContent);self.progressContent=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.speakObj1);self.speakObj1=nil;
_UIObject_release(self.speakObj2);self.speakObj2=nil;
_UIObject_release(self.speakText1);self.speakText1=nil;
_UIObject_release(self.speakText2);self.speakText2=nil;
_UIObject_release(self.randomCampBtn);self.randomCampBtn=nil;
end















local _this
local campShowPanelCmpIndex={
campName=0,
campScore=1,
rewardScrollView=2,
rewardList=3,
selfFlag=4,
firstEffect=5,
}

local progressRewardItemIndex={
item=0,
gotFlag=1,
click=2,
scoreText=3,
select=4,
}
local _maxShowRewardCount=4




function UILingZhenPZMainWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UILingZhenPZMainWin:__delete()
_this=nil
self:unbindComponents()
self:clearTimer()
self:clearSpeakTimer()
end




function UILingZhenPZMainWin:onShow(argtable,afterOnloaded)
self.actID=LIMIT_ACT_TYPE.eLingZhenPengZhuang

local npcSpeakParam=cfgHelper.get(cfg_lingzhenpengzhuangconfig_get,1,"npcSpeakParam")
self.npcTalkTime=npcSpeakParam.spaceTime
self.npcTalkShowTime=npcSpeakParam.showTime
self:onShowArgRecv(argtable,afterOnloaded)
end

function UILingZhenPZMainWin:onShowArgRecv(argtable,afterOnloaded)
if not lingZhenPengZhuangController:isActOpen()then
UIManager.error("活动已结束")
return self:onCloseBtn()
end

if afterOnloaded then
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),true,true,true)
end
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5292,1,{},eAnimationID.stand)
end


lingZhenPengZhuangController:reqGetCampScoreDataList()
self.lastSpeakIndex1=nil
self.lastSpeakIndex2=nil
self:refresh(true)
end


function UILingZhenPZMainWin:onHide()
self:clearTimer()
self:clearSpeakTimer()
self:clearEffect()
end

function UILingZhenPZMainWin:refresh(isInit)

self.campId=lingZhenPengZhuangModel:getLingZhenCamp()
if self.campId then

self:refreshStartGamePanel()
else

self:refreshSelectCampPanel()
end


self.nextUpdateDataTime=lingZhenPengZhuangModel:getNextUpdateDataTime()


self:setRemainingTimeTimer()

if isInit then

self:clearSpeakTimer()
self.speakTimer=self:delayDo(0.3,function()
self:doSpeaking()
end)
end
end

function UILingZhenPZMainWin:refreshSelectCampPanel()
self.selectCampPanel:setActive(true)
self.selectCampPanel:setChildCanvasGroupAlpha(1)
self.startGamePanel:setActive(false)
end


function UILingZhenPZMainWin:refreshStartGamePanel(isChange)
if isChange then
self.campId=lingZhenPengZhuangModel:getLingZhenCamp()
self.selectCampPanel:setChildCanvasGroupDOFade(0,0.5,function()
if not _this then return end
self.startGamePanel:setActive(true)
self.startGamePanel:setChildCanvasGroupAlpha(0)
self.startGamePanel:setChildCanvasGroupDOFade(1,0.5)
self.selectCampPanel:setActive(false)
end)
else
self.startGamePanel:setActive(true)
self.startGamePanel:setChildCanvasGroupAlpha(1)
self.selectCampPanel:setActive(false)
end


local tipStr=cfgHelper.get(cfg_lingzhenpengzhuangconfig_get,1,"tipText")or""
self.tipsText:setText(tipStr)


for i=1,2 do
self:refreshCampShowPanel(i)
end















self:refreshProgressPanel(true)
end

function UILingZhenPZMainWin:refreshProgressPanel(isNeedJump)
local allRewardCfg=cfg_lingzhenpengzhuangstageconfig()
local showRewardCount=#allRewardCfg


local todayTopScore=lingZhenPengZhuangModel:getTopScore()or 0
self.todayTopScore:setText(FMT.fmt("今日最佳：<color=#c82c2c>{0}</color>",todayTopScore))

self.progressRewardScrollView:setChildScrollViewCreateGrids(showRewardCount,showRewardCount)
local grids=self.progressRewardScrollView:getChildScrollViewItemWidgets()
self.progressRewardScrollView:setActive(true)
local finalFinishIdx=0
for i=1,grids.Count do
local progressRewardItem=grids[i-1]
local cfg=allRewardCfg[i]
if cfg then
local targetScore=cfg.score
local reward=cfg.reward[1]
local isGot=todayTopScore>=targetScore or false

progressRewardItem:SetChildText(progressRewardItemIndex.scoreText,targetScore)

progressRewardItem:SetChildActive(progressRewardItemIndex.gotFlag,isGot)

progressRewardItem:SetChildActive(progressRewardItemIndex.select,false)

local rewardItem=progressRewardItem:GetChildWidgetBase(progressRewardItemIndex.item)
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf
conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGot
rewardItem:SetChildActive(-1,true)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)

if isGot and i>finalFinishIdx then
finalFinishIdx=i
end
end
end
if isNeedJump then
local jumpIndex=finalFinishIdx
if jumpIndex<0 then
jumpIndex=0
end
self.progressRewardScrollView:setChildScrollRectEnable(false)
self.progressRewardScrollView:setChildScrollViewSelectItem(jumpIndex-1,false,false,false)
self.progressRewardScrollView:setChildScrollRectEnable(true)
end


local progressBarWidth=self.progressBar:getChildRectWidth()
local progressValueWidth=progressBarWidth-5
local progressValueHeight=self.progressValue:getChildRectHeight()
local ignoreWidth_singleItem=56
local nowValue=0
local allCount=#allRewardCfg
local invalidPercent_allItem=(ignoreWidth_singleItem*(allCount-1))/progressValueWidth
local validParecent=1-invalidPercent_allItem
local lastScore=0
local finishCount=0
for i,v in ipairs(allRewardCfg)do
local targetScore=v.score
if todayTopScore>=targetScore then
if i>1 then
nowValue=nowValue+1/(allCount-1)
end
finishCount=finishCount+1
else
nowValue=nowValue+(todayTopScore-lastScore)/(targetScore-lastScore)*(1/(allCount-1))
break
end
lastScore=targetScore
end


if finishCount<=1 then
if finishCount==0 then
nowValue=0
end
finishCount=0
else
finishCount=finishCount-1
end

if nowValue>0 then
local finishItemWidth=ignoreWidth_singleItem*finishCount
if finishCount<(allCount-1)then
finishItemWidth=finishItemWidth+ignoreWidth_singleItem/2
end

nowValue=nowValue*validParecent+finishItemWidth/progressValueWidth
end

self.progressValue:setChildSizeDelta(progressValueWidth*nowValue,progressValueHeight)
end

function UILingZhenPZMainWin:refreshCampShowPanel(campId)
local campShowPanel=self[FMT.fmt("campShowPanel{0}",campId)]
if campShowPanel then
local panelWidget=campShowPanel:getWidgetBase()
local campData=lingZhenPengZhuangModel:getLingZhenCampScoreDataByCampId(campId)
if campData then
local nowTime=timeHelper.getServerShortTime()
local nextUpdateTime=campData.nextUpdateTime
if nextUpdateTime<=nowTime then

lingZhenPengZhuangController:reqGetCampScoreDataList()
else
self.updateCampDataTime=nextUpdateTime
end
end

if panelWidget then

local allScore=campData and campData.score or 0
panelWidget:SetChildText(campShowPanelCmpIndex.campScore,FMT.fmt("总积分：{0}",allScore))

local allCampNameCfg=cfgHelper.get(cfg_lingzhenpengzhuangconfig_get,1,"camp")
local campName=allCampNameCfg and allCampNameCfg[campId]or"未知"
panelWidget:SetChildText(campShowPanelCmpIndex.campName,campName)

local otherCampId
if campId==1 then
otherCampId=2
elseif campId==2 then
otherCampId=1
end
local otherCampData=lingZhenPengZhuangModel:getLingZhenCampScoreDataByCampId(otherCampId)
local otherCampAllScore=otherCampData and otherCampData.score or 0
local otherCampLastUpdateTime=otherCampData and otherCampData.lastUpdateTime or 0
local lastUpdateTime=campData and campData.lastUpdateTime or 0

local isWin=false
if allScore==otherCampAllScore then
if lastUpdateTime==otherCampLastUpdateTime then
isWin=true
else
isWin=lastUpdateTime<otherCampLastUpdateTime
end
else
isWin=allScore>otherCampAllScore
end

local allRewardList=cfgHelper.get(cfg_lingzhenpengzhuangconfig_get,1,"reward")
local showRewardList
if isWin then
showRewardList=allRewardList and allRewardList[1]or{}
else
showRewardList=allRewardList and allRewardList[2]or{}
end
local count=#showRewardList
panelWidget:SetChildLayoutGroupCreateItems(campShowPanelCmpIndex.rewardList,count)
local grids=panelWidget:GetChildLayoutGroupGridList(campShowPanelCmpIndex.rewardList)
for j=1,grids.Count do
local item=grids[j-1]
item:SetChildActive(-1,true)
local itemCfg=showRewardList[j]
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
panelWidget:SetChildScrollRectEnable(campShowPanelCmpIndex.rewardScrollView,count>_maxShowRewardCount)


local isSelfCamp=campId==self.campId
panelWidget:SetChildActive(campShowPanelCmpIndex.selfFlag,isSelfCamp)


if isWin then
panelWidget:SetChildShowEffect(campShowPanelCmpIndex.firstEffect,10560,true)
else
panelWidget:SetChildShowEffect(campShowPanelCmpIndex.firstEffect,0,false)
end
end
end
end


function UILingZhenPZMainWin:clearEffect()
for i=1,2 do
local campShowPanel=self[FMT.fmt("campShowPanel{0}",i)]
if campShowPanel then
local panelWidget=campShowPanel:getWidgetBase()
panelWidget:SetChildShowEffect(campShowPanelCmpIndex.firstEffect,0,false)
end
end
end


function UILingZhenPZMainWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local time=limitActivitiesModel:getActEndLeftTime(self.actID)or 0
if time>0 then

local nowTime=timeHelper.getServerShortTime()
self.timeText:setText(FMT.fmt("活动时间：{0}",timeHelper.format_time_stamp11(time,true)))
if self.updateCampDataTime then
if nowTime>=self.updateCampDataTime then
self.updateCampDataTime=self.updateCampDataTime+600

lingZhenPengZhuangController:reqGetCampScoreDataList()
end
end

if self.nextUpdateDataTime then
if nowTime>=self.nextUpdateDataTime then

lingZhenPengZhuangModel:setTopScore(0)

lingZhenPengZhuangController:reqDatas()
end
end
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()

local isdoing=limitActivitiesModel:checkActDoing(self.actID)
if not isdoing then
self:onCloseBtn()
end
end
end

self.timer=self:setTimer(1,0,func)

func()
end



function UILingZhenPZMainWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UILingZhenPZMainWin:doSpeaking()
self:clearSpeakTimer()

local speakLib=cfgHelper.get(cfg_lingzhenpengzhuangconfig_get,1,"npcSpeakLib")
local speakLib1=table.weakCopy(speakLib[1])
local speakLib2=table.weakCopy(speakLib[2])
if self.lastSpeakIndex1 and speakLib1[self.lastSpeakIndex1]then
table.remove(speakLib1,self.lastSpeakIndex1)
end
if self.lastSpeakIndex2 and speakLib2[self.lastSpeakIndex2]then
table.remove(speakLib2,self.lastSpeakIndex2)
end
local rand1=math.random(1,#speakLib1)
self.lastSpeakIndex1=rand1
local speakStr1=speakLib1[rand1]
local rand2=math.random(1,#speakLib2)
self.lastSpeakIndex2=rand2
local speakStr2=speakLib2[rand2]
local speed=30
self.speakObj1:setChildCanvasGroupAlpha(1)
self.speakText1:setChildTrendsTextPlay(speakStr1,speed,nil)
self.speakObj2:setChildCanvasGroupAlpha(1)
self.speakText2:setChildTrendsTextPlay(speakStr2,speed,nil)
self:doTalkAnim()
end


function UILingZhenPZMainWin:doTalkAnim()
if self.talkTween1~=nil then
self.talkTween1:Kill()
self.talkTween1=nil
end
if self.talkTween2~=nil then
self.talkTween2:Kill()
self.talkTween2=nil
end
self.speakObj1:setScale(Vector3.zero)
self.speakObj2:setScale(Vector3.zero)
self:delayDo(0.5,function()
self.speakObj1:setChildCanvasGroupAlpha(1)
self.speakObj2:setChildCanvasGroupAlpha(1)
self.talkTween1=self.speakObj1:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween1=nil
_this.talkTween1=_this.speakObj1:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween1=nil
return _this:talkEnd()
end)
end)
self.talkTween2=self.speakObj2:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween2=nil
_this.talkTween2=_this.speakObj2:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween2=nil
return
end)
end)
end)
end


function UILingZhenPZMainWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj1:setScale(Vector3.zero)
self.speakObj2:setScale(Vector3.zero)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end


function UILingZhenPZMainWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end





function UILingZhenPZMainWin:onCloseBtn()
UILZPZControl:closeUI(true)
end



function UILingZhenPZMainWin:onHelpBtn()
end



function UILingZhenPZMainWin:onStartBtn()
UILZPZControl:showGameWin()
end



function UILingZhenPZMainWin:onRuleBtn()
local langId=cfgHelper.get(cfg_lingzhenpengzhuangconfig_get,1,"ruleLangId")or''
local d={}
d.title='规则'
d.mode=3
d.name=langId
self:showWindow('UIRuleWin',d)
end



function UILingZhenPZMainWin:onShopBtn()
local config=cfgHelper.get1(cfg_lingzhenpengzhuangconfig_get,1)
if config.shopId then
funcShopController:openShopWin({shopId=config.shopId})
end
end



function UILingZhenPZMainWin:onLianzhiBtn()

jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eTianGongGe,tabType=FULL_TAB_TYPE.eLingZhenDiaoKe}})
end



function UILingZhenPZMainWin:onSelectCampBtn1()









end



function UILingZhenPZMainWin:onSelectCampBtn2()









end

function UILingZhenPZMainWin:onRandomCampBtn()
if self.campId then

return
end

lingZhenPengZhuangController:reqSelectCampById()
end

function UILingZhenPZMainWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight,
showModel=true,})
end