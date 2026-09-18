







def_class("UIXianFaWenDaoWin",UIWindowBase)









function UIXianFaWenDaoWin:bindComponents()

self.actCD=UIText.get(self,0)
self.actDes=UIText.get(self,1)
self.actTime=UIText.get(self,2)
self.cd=UIText.get(self,3)
self.challengeBtn=UIButton.get(self,4)
self.competitor_1=UIObject.get(self,5)
self.competitor_2=UIObject.get(self,6)
self.competitor_3=UIObject.get(self,7)
self.defendBtn=UIButton.get(self,8)
self.enterBtn=UIButton.get(self,9)
self.faze=UIButton.get(self,10)
self.funcIcons=UIObject.get(self,11)
self.fzDesc=UIText.get(self,12)
self.fzIcon=UIObject.get(self,13)
self.fzName=UIText.get(self,14)
self.groupName=UIText.get(self,15)
self.helpBtn=UIButton.get(self,16)
self.hideBtn=UIButton.get(self,17)
self.honorBtn=UIButton.get(self,18)
self.levelIcon=UIImage.get(self,19)
self.likeReddot=UIObject.get(self,20)
self.normalPanel=UIObject.get(self,21)
self.rankBtn=UIButton.get(self,22)
self.ranking=UIText.get(self,23)
self.recordBtn=UIButton.get(self,24)
self.regBG=UIObject.get(self,25)
self.regBtn=UIButton.get(self,26)
self.registered=UIObject.get(self,27)
self.registerPanel=UIObject.get(self,28)
self.reqReward=UIButton.get(self,29)
self.rewardBtn=UIButton.get(self,30)
self.rightPanelA=UIObject.get(self,31)
self.rightPanelB=UIObject.get(self,32)
self.rwReddot=UIObject.get(self,33)
self.rwScrollView=UIObject.get(self,34)
self.rwTips=UIText.get(self,35)
self.scoreIcon=UIObject.get(self,36)
self.scores=UIText.get(self,37)
self.scoresPB=UIObject.get(self,38)
self.scoresText=UIText.get(self,39)
self.shopBtn=UIButton.get(self,40)
self.teamScrollView=UIObject.get(self,41)
self.wdcqBtn=UIButton.get(self,42)

self.challengeBtn:setButtonClick(function()self:onChallengeBtn()end)

self.defendBtn:setButtonClick(function()self:onDefendBtn()end)

self.enterBtn:setButtonClick(function()self:onEnterBtn()end)

self.faze:setButtonClick(function()self:onFaze()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.hideBtn:setButtonClick(function()self:onHideBtn()end)

self.honorBtn:setButtonClick(function()self:onHonorBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.regBtn:setButtonClick(function()self:onRegBtn()end)

self.reqReward:setButtonClick(function()self:onReqReward()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.wdcqBtn:setButtonClick(function()self:onWdcqBtn()end)
self.competitor={
self.competitor_1,
self.competitor_2,
self.competitor_3,
}



end


function UIXianFaWenDaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actCD);self.actCD=nil;
_UIObject_release(self.actDes);self.actDes=nil;
_UIObject_release(self.actTime);self.actTime=nil;
_UIObject_release(self.cd);self.cd=nil;
_UIObject_release(self.challengeBtn);self.challengeBtn=nil;
_UIObject_release(self.competitor_1);self.competitor_1=nil;
_UIObject_release(self.competitor_2);self.competitor_2=nil;
_UIObject_release(self.competitor_3);self.competitor_3=nil;
_UIObject_release(self.defendBtn);self.defendBtn=nil;
_UIObject_release(self.enterBtn);self.enterBtn=nil;
_UIObject_release(self.faze);self.faze=nil;
_UIObject_release(self.funcIcons);self.funcIcons=nil;
_UIObject_release(self.fzDesc);self.fzDesc=nil;
_UIObject_release(self.fzIcon);self.fzIcon=nil;
_UIObject_release(self.fzName);self.fzName=nil;
_UIObject_release(self.groupName);self.groupName=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.hideBtn);self.hideBtn=nil;
_UIObject_release(self.honorBtn);self.honorBtn=nil;
_UIObject_release(self.levelIcon);self.levelIcon=nil;
_UIObject_release(self.likeReddot);self.likeReddot=nil;
_UIObject_release(self.normalPanel);self.normalPanel=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.ranking);self.ranking=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.regBG);self.regBG=nil;
_UIObject_release(self.regBtn);self.regBtn=nil;
_UIObject_release(self.registered);self.registered=nil;
_UIObject_release(self.registerPanel);self.registerPanel=nil;
_UIObject_release(self.reqReward);self.reqReward=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rightPanelA);self.rightPanelA=nil;
_UIObject_release(self.rightPanelB);self.rightPanelB=nil;
_UIObject_release(self.rwReddot);self.rwReddot=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.rwTips);self.rwTips=nil;
_UIObject_release(self.scoreIcon);self.scoreIcon=nil;
_UIObject_release(self.scores);self.scores=nil;
_UIObject_release(self.scoresPB);self.scoresPB=nil;
_UIObject_release(self.scoresText);self.scoresText=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
_UIObject_release(self.wdcqBtn);self.wdcqBtn=nil;
self.competitor=nil;
end



















function UIXianFaWenDaoWin:onLoaded(...)
self:bindComponents()



self.showBtns=true

self.abName='ui/windows/xianfawendao/xfwd_atlas_pak.ab'
self.levelIcons={
'icon_zongmendjhz_4',
'icon_zongmendjhz_3',
'icon_zongmendjhz_2',
'icon_zongmendjhz_1',
}
self.rankBG={
'image_xianfawendaoui_7',
'image_xianfawendaoui_9',
'image_xianfawendaoui_11',
}
self.rankIcon={
'image_xianfawendaoui_8',
'image_xianfawendaoui_10',
'image_xianfawendaoui_12',
}

self.teamScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)

UIXianFaWenDaoControl:checkAndReqNewData()

if UIXianFaWenDaoControl:isFirstOpenWinInSession()then
UIManager:showWindow('UIXFWDFaZeWin')
end

if verifyManager:isHideBusinessActivity()then
self.rewardBtn:setActive(false)
end

end


function UIXianFaWenDaoWin:__delete()
self:unbindComponents()
end




function UIXianFaWenDaoWin:onShow(argtable,afterOnloaded)
self:refresh()
if argtable then
local subWin=argtable.subWin
if subWin==3 then
self:onRecordBtn()
end
end
end

function UIXianFaWenDaoWin:onShowArgRecv(argtable)
self:refresh()
end


function UIXianFaWenDaoWin:onHide()

end

function UIXianFaWenDaoWin:setRewardReddot()
self.rwReddot:setActive(UIXianFaWenDaoControl:checkInvestReddot())
end

function UIXianFaWenDaoWin:setLikeReddot()
self.likeReddot:setActive(UIXianFaWenDaoControl:checkLikeReddot())
end

function UIXianFaWenDaoWin:refresh()
local isReg=UIXianFaWenDaoControl:getRegister()
local inRegTime=UIXianFaWenDaoControl:isInRegisterTime()
local isTruce=UIXianFaWenDaoControl:isInTruceTime()

local isOpenWDCQ=WDCQController.checkSysOpen()
local isShowWdcqBtn=true
if isOpenWDCQ then
isShowWdcqBtn=isReg or((not isReg)and isTruce)
else
isShowWdcqBtn=false
end

self.wdcqBtn:setActive(isShowWdcqBtn)

if isReg and not inRegTime then
self.registerPanel:setActive(false)
self.normalPanel:setActive(true)
if isTruce then
self:setTrucePanel()
else
self:setNormalPanel()
end
else
if isTruce then
self.registerPanel:setActive(false)
self.normalPanel:setActive(true)
self:setTrucePanel()
else
self.registerPanel:setActive(true)
self.normalPanel:setActive(false)
self:setRegisterPanel()
end
end
end

function UIXianFaWenDaoWin:setRegisterPanel()
self.regBG:setChildUIModelShowTarget(4708,1,nil,eAnimationID.stand)
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
local btime,etime=UIXianFaWenDaoControl:getSessionTime()
local lbtime=timeHelper.convertLongStamp(btime)
local letime=timeHelper.convertLongStamp(etime-1)
local lbd=timeHelper.dateServerStampData(lbtime)
local led=timeHelper.dateServerStampData(letime)
self.actTime:setText(FMT.fmt('赛季时间：{0}-{1}',FMT.fmt('{0}月{1}日',lbd.month,lbd.day),
FMT.fmt('{0}月{1}日',led.month,led.day)))

self.faze:setChildAnchoredPosition(Vector2.New(-103.5,308.9))
self:setFaZe()

self.actDes:setText(cfg.desc)

local currtime=gameUtilityModel.getServerShortTime()
local regEndTime=btime+cfg.signup*86400
if currtime<regEndTime then
local isReg=UIXianFaWenDaoControl:getRegister()
if isReg then
self.regBtn:setActive(false)
self.registered:setActive(true)
else
self.regBtn:setActive(true)
self.registered:setActive(false)
end
self.enterBtn:setActive(false)
self:clearTimer()
local tick=function()
local cd=regEndTime-gameUtilityModel.getServerShortTime()
if cd>0 then
self.actCD:setText(FMT.fmt('报名倒计时：<color=#1e9a78>{0}</color>',timeHelper.format_time_stamp11(cd,true)))
else
self:clearTimer()
UIXianFaWenDaoControl:reqDatas()
end
end
self.timer=self:setTimer(1,0,tick)
tick()
else
self.regBtn:setActive(false)
self.enterBtn:setActive(true)
end

self:showTeamHeads()
end

function UIXianFaWenDaoWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIXianFaWenDaoWin:setFaZe()
local list=UIXianFaWenDaoControl:getFazeList()
local fzId=list[1]
local fcfg=cfgHelper.getSSlawRule(fzId)
local widget=self.faze:getChildWidgetBase()
widget:SetChildIcon(0,fcfg.image,true)
widget:SetChildText(1,FMT.fmt('<color=#fd8950>【{0}】</color>{1}',fcfg.name,fcfg.desc))
end

function UIXianFaWenDaoWin:setTrucePanel()
self.challengeBtn:setActive(false)


self:setRewardReddot()
self:setLikeReddot()

local ttime=UIXianFaWenDaoControl:getSessionTruceEndTime()
self:clearTimer()
local tick=function()
local dt=ttime-gameUtilityModel.getServerShortTime()
if dt>0 then
self.cd:setText(FMT.fmt('休战结束倒计时：{0}',timeHelper.format_time_stamp11(dt,true)))
else
UIXianFaWenDaoControl:setSessionOpenTime()
self:clearTimer()
self:refresh()
end
end
self.timer=self:setTimer(1,0,tick)
tick()

self.faze:setChildAnchoredPosition(Vector2.New(-115.4,267.3))
self:setFaZe()

self:showTopThree()

self.rightPanelA:setActive(false)
self.rightPanelB:setActive(true)

local session=UIXianFaWenDaoControl:getSession()
list=UIXianFaWenDaoControl:getFazeList(session+1)
local fzId=list[1]
local fcfg=cfgHelper.getSSlawRule(fzId)
self.fzIcon:setChildIcon(fcfg.image,true)
self.fzName:setText(fcfg.name)
self.fzDesc:setText(fcfg.desc)
end

function UIXianFaWenDaoWin:setNormalPanel()
self:setRewardReddot()
self:setLikeReddot()
self.challengeBtn:setActive(true)
self.challengeBtn:setChildUIModelShowTarget(4709,1,nil,eAnimationID.stand)

local ttime=UIXianFaWenDaoControl:getSessionEndTime()
self:clearTimer()
local tick=function()
local dt=ttime-gameUtilityModel.getServerShortTime()
if dt>0 then
self.cd:setText(FMT.fmt('赛季结束倒计时：<color=#171311>{0}</color>',timeHelper.format_time_stamp11(dt,true)))
else
self:clearTimer()
self:refresh()
end
end
self.timer=self:setTimer(1,0,tick)
tick()

self.faze:setChildAnchoredPosition(Vector2.New(-115.4,267.3))
self:setFaZe()

self:showTopThree()

self.rightPanelA:setActive(true)
self.rightPanelB:setActive(false)


local order=UIXianFaWenDaoControl:getLevel()
local cfg=cfgHelper.get1(cfg_xianfawendaolevelconfig_get,order)
self.groupName:setText(cfg.name)
local level=UIXianFaWenDaoControl:getOrderLevel()
self.levelIcon:setSprite(self.abName,self.levelIcons[level])
local icon=UIXianFaWenDaoControl:getScoreIconName()
self.scoreIcon:setChildIcon(icon,true)
local scores=UIXianFaWenDaoControl:getScore()
self.scores:setText(scores)
local nextOrder=UIXianFaWenDaoControl:getNextOrderLevel()
local gcfg=cfgHelper.get1(cfg_xianfawendaoscoreconfig_get,nextOrder)
local rank=UIXianFaWenDaoControl:getRank()
self.ranking:setText(FMT.fmt('排名：<color=#171311>{0}</color>',rank>0 and rank or'未上榜'))

local isFull=scores>=gcfg.min
if isFull then
self.scoresPB:setChildUIProgressbar(1,1,false)
self.scoresText:setText('满阶')
self.rwTips:setText('已升至最高段位')
self.rwScrollView:setActive(false)
else
self.rwTips:setText('升阶奖励')
self.rwScrollView:setActive(true)

self.scoresPB:setChildUIProgressbar(scores,gcfg.min,false)
self.scoresText:setText(FMT.fmt('{0}/{1}',scores,gcfg.min))

local rewards=gcfg.reward
local col=math.min(3,#rewards)
self.rwScrollView:setChildScrollViewCreateGrids(#rewards,col)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local rdata=rewards[i]
widgetHelper.setNormalRewardItem(item,0,{rdata[1],rdata[2],showStage=true})
end
end
end

function UIXianFaWenDaoWin:showTopThree()
local cfg=cfgHelper.get1(cfg_xianfawendaoconfig_get,1)
local tline=cfg.rank[2]
local nlname=cfgHelper.get2(cfg_xianfawendaoscoreconfig_get,tline,'name')
local topThree=UIXianFaWenDaoControl:getTopThree()
local icon=UIXianFaWenDaoControl:getScoreIconName()
for i,v in ipairs(self.competitor)do
local widget=v:getChildWidgetBase()
local data=topThree[i]
if data then
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
if data.iconInfo.actoricon==0 then
widget:SetChildActive(12,true)
widget:SetChildActive(2,false)
else
widget:SetChildActive(2,true)
widget:SetChildActive(12,false)
playerController:setHeadIcon(widget,2,{scale=0.75,iconInfo=data.iconInfo})
end
local sname=loginModel:getServerName(data.serverid)
widget:SetChildText(9,FMT.fmt('[{0}]',sname))
widget:SetChildText(3,data.actorname)
widget:SetChildIcon(4,icon,true)
widget:SetChildText(5,data.score)
widget:SetChildActive(6,true)
local imageInfo=UIDiscipleModel.calculationDiscipleImageBase(data)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
local anim=mountHelper.getMountAniByBody(modelParams.body)
widget:SetChildUIModelShowTarget(6,modelParams.body,0.7,modelParams.componets,anim)
local mount=UIXianFaWenDaoControl:getActorMount(data.actorid)
local scale=isometricMapSystem:getModelScale(mount,true)
widget:SetChildUIModelMount(6,mount,nil,'zuoqidian',scale*0.5,Vector3.New(0,0,0),nil)
widget:SetChildButtonClick(8,function()
UIXianFaWenDaoControl:showActorInfo(data)
end)
widget:SetChildActive(10,true)
widget:SetChildCSImageSprite(10,self.abName,self.rankBG[i])
else
widget:SetChildActive(0,false)
widget:SetChildActive(1,true)
widget:SetChildActive(6,false)
widget:SetChildText(7,FMT.fmt('{0}可上榜',nlname))
widget:SetChildActive(10,false)
end
widget:SetChildCSImageSprite(11,self.abName,self.rankIcon[i])
end
end
















function UIXianFaWenDaoWin:getTeamData()
local team=UIXianFaWenDaoControl:getTeam()
local teamData={{},{},{}}
for i,v in ipairs(team)do
local dzId=tostring(v)
if dzId~='0'then
local tId=math.floor((i-1)/5)+1
local pId=(i-1)%5+1
local tdata=teamData[tId]
tdata[dzId]={pId,1,v}
end
end
return teamData
end

function UIXianFaWenDaoWin:showDefenders(selectIndex)
local enterCallBack=function(guidList)
local tlist={}
for i,v in ipairs(guidList)do
for ii,vv in ipairs(v[2])do
table.insert(tlist,vv[2])
end
end
if not UIXianFaWenDaoControl:checkTeamSame(tlist)then
UIXianFaWenDaoControl:reqChangeTeam(#tlist,tlist)
else
fightController:closeSelectStage()
UIXianFaWenDaoControl:showXianFaWenDaoWin()
UIManager.info('保存成功')
end
end

local faZeData=UIXianFaWenDaoControl:getFazeList()
local teamData=self:getTeamData()
local winArgs=
{
enterCallBack=enterCallBack,
enterTxt="仙法问道",
mapId=818004,

faZeData=faZeData,
multipleTeams=teamData,
skipDiscipleStateCheck=true,
statePriorityCheck=true,
skipDiscipleInjuryCheck=true,
skipShouYuanCheck=true,
cancelCallBack=function()
fightController:closeSelectStage()
UIXianFaWenDaoControl:showXianFaWenDaoWin()
end,
sureBodyid=2068,
sureBodyAnim=eAnimationID.dog_idle_1,
dontCloseStage=true,
notNeedDealOverTime=true,
defaultSelectTeamIndex=selectIndex or 1,
}
UIXianFaWenDaoControl:closeUI(false)
fightController.showPrepareWin(eFightPreSelectType.xianfawendaodefense,winArgs,function()

end)
end

function UIXianFaWenDaoWin:showTeamHeads()
local team=UIXianFaWenDaoControl:getTeam()

self.teamScrollView:setChildScrollViewCreateGrids(3,0)
local grids=self.teamScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildText(0,FMT.fmt('第\n{0}\n队',i))
for ii=1,5 do
local widget=item:GetChildWidgetBase(ii)
local index=ii+(i-1)*5
local dzId=team[index]or 0
if tostring(dzId)~='0'then
widget:SetChildActive(1,true)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
if dzData then
widget:SetChildActive(2,true)
widget:SetChildActive(4,false)
comHelper.setChildModelRawImage(widget,dzId,2,0,eHeadCenterType.eHead)
local jobicon=UIDiscipleModel:getJobIconNameX(dzId)
widget:SetChildCSImageSprite(3,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(dzId)
widget:SetChildActive(6,isSpDz)
local info=UIDiscipleModel:getDiscipleImageInfo(dzId)
comHelper.setChildModelHeadIconBGByColor(widget,5,info.color)
else
widget:SetChildActive(2,false)
widget:SetChildActive(4,true)
comHelper.setChildModelHeadIconBGByColor(widget,5,1)
end
else
widget:SetChildActive(1,false)
end
item:SetChildButtonClick(ii,function()
self:showDefenders(i)
end)
end
end
end




function UIXianFaWenDaoWin:checkTeam()
local team=UIXianFaWenDaoControl:getTeam()
if#team<15 then
return false
end
for i=1,3 do
local count=0
for ii=1,5 do
local index=ii+(i-1)*5
local dzId=team[index]
if tostring(dzId)~='0'then
count=count+1
end
end
if count==0 then
return false
end
end
return true
end

function UIXianFaWenDaoWin:onEnterBtn()
self:onRegBtn()
end

function UIXianFaWenDaoWin:onRegBtn()
if self:checkTeam()then
UIXianFaWenDaoControl:reqRegister()
else
UIManager.error('请先设置防守阵容')
self:showDefenders()
end
end

function UIXianFaWenDaoWin:onShopBtn()
funcShopController:openShopWin({shopId=4})
end

function UIXianFaWenDaoWin:onRankBtn()
local level=UIXianFaWenDaoControl:getLevel()
level=math.max(level,1)

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.xfwdRank,{})
UIXianFaWenDaoControl:reqRankList(level)
end

function UIXianFaWenDaoWin:onRecordBtn()
UIXianFaWenDaoControl:reqRecordList()
UIManager:showWindow('UIXFWDRecordWin')
end

function UIXianFaWenDaoWin:onDefendBtn()
self:showDefenders()
end

function UIXianFaWenDaoWin:onChallengeBtn()
local isReg=UIXianFaWenDaoControl:getRegister()
if not isReg then
if self:checkTeam()then
UIXianFaWenDaoControl:reqRegister()
else
UIManager.error('请先设置防守阵容')
self:showDefenders()
return
end
end
local datas=UIXianFaWenDaoControl:getMatchingData()
if#datas==0 then
UIXianFaWenDaoControl:reqMatching()
end

UIXianFaWenDaoControl:showXianFaWenDaoChallengeWin()
end

function UIXianFaWenDaoWin:onRewardBtn()


local func=function(args_)
UIXianFaWenDaoControl:showXianFaWenDaoWin(args_)
end
fullScreenUI.setNextActiveUICallback(func)
UIFullTotalTouZiActivityontrol:showMenuWindow({menuType=TZ_MENU_TYPE.eXFLDRewards})
end

function UIXianFaWenDaoWin:onHonorBtn()
UIManager:showWindow('UILDRongYuTongWin',{ftype=2})
end

function UIXianFaWenDaoWin:onFaze()
UIManager:showWindow('UIXFWDFaZeWin')
end

function UIXianFaWenDaoWin:onReqReward()
UIManager:showWindow('UIXFWDRegRewardWin')
end

function UIXianFaWenDaoWin:clearBTTweener()
if self.btTweener then
self.btTweener:Kill()
self.btTweener=nil
end
end

function UIXianFaWenDaoWin:onHideBtn()
self:clearBTTweener()
if self.showBtns then

self.hideBtn:setSprite(self.abName,'button_xianfawendaoui_3')
self.btTweener=self.funcIcons:setChildCanvasGroupDOFade(0,0.5,nil)
else

self.hideBtn:setSprite(self.abName,'button_xianfawendaoui_2')
self.btTweener=self.funcIcons:setChildCanvasGroupDOFade(1,0.5,nil)
end
self.showBtns=not self.showBtns
end

function UIXianFaWenDaoWin:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_xianfawendao_help_%s'})
end

function UIXianFaWenDaoWin:onCloseClick()
fullScreenUI.closeActiveUI()
end

function UIXianFaWenDaoWin:onWdcqBtn()





self:showWindow("UIXFWD_WDCQ_CSTS_Win")
end