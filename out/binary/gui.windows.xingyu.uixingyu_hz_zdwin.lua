







def_class("UIXingYu_HZ_ZDWin",UIWindowBase)









function UIXingYu_HZ_ZDWin:bindComponents()

self.hzRoundBtn=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.fightTipRoot=UIObject.get(self,2)
self.fightTipTxt=UIText.get(self,3)
self.shenglvRoot=UIObject.get(self,4)
self.selfSL=UIText.get(self,5)
self.otherSL=UIText.get(self,6)
self.selfPlayerInfo=UIObject.get(self,7)
self.otherPlayerInfo=UIObject.get(self,8)
self.hzIngReward=UIObject.get(self,9)
self.hzIngwinReward=UIObject.get(self,10)
self.hzIngFailReward=UIObject.get(self,11)
self.teamSelectRoot=UIObject.get(self,12)
self.teamSelectList=UIObject.get(self,13)
self.emptyTip=UIObject.get(self,14)
self.dzModelList=UIObject.get(self,15)
self.hzWinTipRoot=UIObject.get(self,16)
self.hzFailTipRoot=UIObject.get(self,17)
self.hzFailTip=UIText.get(self,18)
self.teamSumRewardRoot=UIObject.get(self,19)
self.teamSumRewardTitle=UIText.get(self,20)
self.teamSumRewardSView=UIObject.get(self,21)
self.teamSumRewardList=UIObject.get(self,22)
self.zdRoundBg=UIObject.get(self,23)
self.zdRound=UIText.get(self,24)
self.zdzIngReward=UIObject.get(self,25)
self.zdzIngRewardItem=UIBaseItem.get(self,26)
self.finishRoot=UIObject.get(self,27)
self.finishRound=UIText.get(self,28)
self.replayBtn=UIButton.get(self,29)
self.GJIcon=UIObject.get(self,30)
self.titleBg=UIObject.get(self,31)
self.ruleBtn=UIButton.get(self,32)
self.closeBtn=UIButton.get(self,33)
self.nameImg=UIImage.get(self,34)
self.teamNoSumRewardTip=UIText.get(self,35)
self.leftspeak=UIObject.get(self,36)
self.rightspeak=UIObject.get(self,37)
self.centerspeak=UIObject.get(self,38)
self.teamSumRewardSViewEx=UIObject.get(self,39)
self.teamSumRewardListEx=UIObject.get(self,40)
self.zdzIngRewardBg=UIImage.get(self,41)
self.maskbg=UIObject.get(self,42)
self.zdzIngRewardBgModel=UIObject.get(self,43)
self.zdzRewardBtn=UIButton.get(self,44)
self.slTipClick=UIButton.get(self,45)
self.slTipRoot=UIObject.get(self,46)
self.finishstage=UIText.get(self,47)

self.hzRoundBtn:setButtonClick(function()self:onHzRoundBtn()end)

self.replayBtn:setButtonClick(function()self:onReplayBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.zdzRewardBtn:setButtonClick(function()self:onZdzRewardBtn()end)

self.slTipClick:setButtonClick(function()self:onSlTipClick()end)



end


function UIXingYu_HZ_ZDWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.hzRoundBtn);self.hzRoundBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.fightTipRoot);self.fightTipRoot=nil;
_UIObject_release(self.fightTipTxt);self.fightTipTxt=nil;
_UIObject_release(self.shenglvRoot);self.shenglvRoot=nil;
_UIObject_release(self.selfSL);self.selfSL=nil;
_UIObject_release(self.otherSL);self.otherSL=nil;
_UIObject_release(self.selfPlayerInfo);self.selfPlayerInfo=nil;
_UIObject_release(self.otherPlayerInfo);self.otherPlayerInfo=nil;
_UIObject_release(self.hzIngReward);self.hzIngReward=nil;
_UIObject_release(self.hzIngwinReward);self.hzIngwinReward=nil;
_UIObject_release(self.hzIngFailReward);self.hzIngFailReward=nil;
_UIObject_release(self.teamSelectRoot);self.teamSelectRoot=nil;
_UIObject_release(self.teamSelectList);self.teamSelectList=nil;
_UIObject_release(self.emptyTip);self.emptyTip=nil;
_UIObject_release(self.dzModelList);self.dzModelList=nil;
_UIObject_release(self.hzWinTipRoot);self.hzWinTipRoot=nil;
_UIObject_release(self.hzFailTipRoot);self.hzFailTipRoot=nil;
_UIObject_release(self.hzFailTip);self.hzFailTip=nil;
_UIObject_release(self.teamSumRewardRoot);self.teamSumRewardRoot=nil;
_UIObject_release(self.teamSumRewardTitle);self.teamSumRewardTitle=nil;
_UIObject_release(self.teamSumRewardSView);self.teamSumRewardSView=nil;
_UIObject_release(self.teamSumRewardList);self.teamSumRewardList=nil;
_UIObject_release(self.zdRoundBg);self.zdRoundBg=nil;
_UIObject_release(self.zdRound);self.zdRound=nil;
_UIObject_release(self.zdzIngReward);self.zdzIngReward=nil;
_UIObject_release(self.zdzIngRewardItem);self.zdzIngRewardItem=nil;
_UIObject_release(self.finishRoot);self.finishRoot=nil;
_UIObject_release(self.finishRound);self.finishRound=nil;
_UIObject_release(self.replayBtn);self.replayBtn=nil;
_UIObject_release(self.GJIcon);self.GJIcon=nil;
_UIObject_release(self.titleBg);self.titleBg=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.nameImg);self.nameImg=nil;
_UIObject_release(self.teamNoSumRewardTip);self.teamNoSumRewardTip=nil;
_UIObject_release(self.leftspeak);self.leftspeak=nil;
_UIObject_release(self.rightspeak);self.rightspeak=nil;
_UIObject_release(self.centerspeak);self.centerspeak=nil;
_UIObject_release(self.teamSumRewardSViewEx);self.teamSumRewardSViewEx=nil;
_UIObject_release(self.teamSumRewardListEx);self.teamSumRewardListEx=nil;
_UIObject_release(self.zdzIngRewardBg);self.zdzIngRewardBg=nil;
_UIObject_release(self.maskbg);self.maskbg=nil;
_UIObject_release(self.zdzIngRewardBgModel);self.zdzIngRewardBgModel=nil;
_UIObject_release(self.zdzRewardBtn);self.zdzRewardBtn=nil;
_UIObject_release(self.slTipClick);self.slTipClick=nil;
_UIObject_release(self.slTipRoot);self.slTipRoot=nil;
_UIObject_release(self.finishstage);self.finishstage=nil;
end















local abName="ui/windows/xingyu/xingyu_atlas_pak.ab"

local c_posDataList={
{
{x=0,y=-80},
},
{
{x=80,y=-80},
{x=-80,y=-80},
},
{
{x=0,y=-80},
{x=160,y=-80},
{x=-160,y=-80},
},
{
{x=80,y=-80},
{x=-80,y=-80},
{x=240,y=-80},
{x=-240,y=-80},
},
{
{x=0,y=-80},
{x=160,y=-80},
{x=-160,y=-80},
{x=320,y=-80},
{x=-320,y=-80},
},
}

local l_posDataList={
{x=-250,y=0},
{x=-250,y=-170},
{x=-430,y=50},
{x=-430,y=-90},
{x=-430,y=-255},
}

local r_posDataList={
{x=250,y=0},
{x=250,y=-170},
{x=430,y=50},
{x=430,y=-90},
{x=430,y=-255},
}

local teamabName="ui/windows/huanjing/huanjing_atlas_pak.ab"
local teamAssetName={
"icon_duibiao_1",
"icon_duibiao_2",
"icon_duibiao_3"
}




function UIXingYu_HZ_ZDWin:onLoaded(...)
self:bindComponents()
self.zdzIngRewardItem:setBaseItemClickEvent(itemsComponentHelper.onItemClick)
end


function UIXingYu_HZ_ZDWin:__delete()
self:unbindComponents()
self:killAllSpeakTween()
self:killAllTween()
self:stopTimer()
end




function UIXingYu_HZ_ZDWin:onShow(argtable,afterOnloaded)
self.level=JiuYuZhengFengModel:getData_rank_level()or 0
self.reqList={}
local xyId=argtable.xyId
self.xyId=xyId
if not self:refreshState()then
return
end
local xyCfg=XingYuModel:getXingYuConfig(xyId)
self.nameImg:setSprite(abName,xyCfg.nameiconAssest)
local func=function()
if self and not self.isClose then
self:initTeamSelectRoot()
self:startTimer(function()
self:update()
end)
self:reqAllRivalInfo()
else
logErr("UIXingYu_HZ_ZDWin 回调窗口已销毁")
end
end
self:killAllTween()
if not afterOnloaded then
self.rootTweener=self.root:setChildCanvasGroupDOFade(0,0.2)
self.maskbgTweener=self.maskbg:setChildCanvasGroupDOFade(1,0.2,function()
local _func=function(_args)
fightManager.setState(2)

UIFullXingYuController.fightStage=_args.fightStage
func()
if self and not self.isClose then
self.maskbgTweener=self.maskbg:setChildCanvasGroupDOFade(0,0.3)
self.rootTweener=self.root:setChildCanvasGroupDOFade(1,0.3)
else
logErr("UIXingYu_HZ_ZDWin 回调窗口已销毁")
end
end
local stage=xyCfg.stage
fightManager.setCameraActive(true,fightCameraMode.fight)
fightStage:create(stage,_func,{})
end)























else
func()
end
end

function UIXingYu_HZ_ZDWin:killAllTween()
if self.maskbgTweener then
self.maskbgTweener:Kill(false)
self.maskbgTweener=nil
end
if self.rootTweener then
self.rootTweener:Kill(false)
self.rootTweener=nil
end

end

function UIXingYu_HZ_ZDWin:refreshState()
local state,endTime=XingYuController.getXingYuState(self.xyId)
if state==XingYuState.eDataErr or state==XingYuState.eNone or state==XingYuState.eTanSuo then
logErr("UIXingYu_HZ_ZDWin 状态不对")
self:closeSelf()
return
end
self.state=state
return true
end


function UIXingYu_HZ_ZDWin:onHide()
self:killAllSpeakTween()
self:killAllTween()
end

function UIXingYu_HZ_ZDWin:update()
self:refreshFightTipRoot()
if not self.speakDzList or not next(self.speakDzList)then
return
end

local teamp=self.speakDzList
if teamp.ctime==teamp.showtime then
teamp.ctime=0-teamp.interltime
if teamp.leftWidget then
teamp.leftSpeakTweens=teamp.leftWidget:SetChildCanvasGroupDOFade(-1,0,0.5,function()
teamp.leftWidget:SetChildText(0,"")
end)
end
if teamp.rightWidget then
teamp.rightSpeakTweens=teamp.rightWidget:SetChildCanvasGroupDOFade(-1,0,0.5,function()
teamp.rightWidget:SetChildText(0,"")
end)
end
end
if teamp.ctime==0 then
local lastRandomIndex=teamp.lastRandomIndex
local speakSubIdList=teamp.speakSubIdList
local _speakIndexList={}
for i,v in ipairs(speakSubIdList)do
if lastRandomIndex~=i then
table.insert(_speakIndexList,i)
end
end
local newIndex=math.random(1,#_speakIndexList)
lastRandomIndex=_speakIndexList[newIndex]
teamp.lastRandomIndex=lastRandomIndex
local subId=speakSubIdList[lastRandomIndex]
local speakTypeCfg=cfg_xingyuspeakconfig_get(teamp.speakType)

if teamp.leftWidget then
local speakTxt1=speakTypeCfg[subId].speakTxt1
teamp.leftWidget:SetChildText(0,speakTxt1)
teamp.leftSpeakTweens=teamp.leftWidget:SetChildCanvasGroupDOFade(-1,1,0.5)
end
if teamp.rightWidget then
local speakTxt2=speakTypeCfg[subId].speakTxt2 or speakTypeCfg[subId].speakTxt1
teamp.rightWidget:SetChildText(0,speakTxt2)
teamp.rightSpeakTweens=teamp.rightWidget:SetChildCanvasGroupDOFade(-1,1,0.5)
end
end
teamp.ctime=teamp.ctime+1
end

function UIXingYu_HZ_ZDWin:killAllSpeakTween()
if not self.speakDzList or not next(self.speakDzList)then
return
end
local teamp=self.speakDzList
if teamp.rightWidget then
teamp.rightWidget:SetChildCanvasGroupAlpha(-1,0)
end
if teamp.leftWidget then
teamp.leftWidget:SetChildCanvasGroupAlpha(-1,0)
end

if teamp.rightSpeakTweens then
teamp.rightSpeakTweens:Kill(false)
teamp.rightSpeakTweens=nil
end

if teamp.leftSpeakTweens then
teamp.leftSpeakTweens:Kill(false)
teamp.leftSpeakTweens=nil
end

self.speakDzList=nil
end


function UIXingYu_HZ_ZDWin:stopTimer()
if self._timer then
self:stopTimerByID(self._timer)
self._timer=nil
end
end

function UIXingYu_HZ_ZDWin:startTimer(func)
self:stopTimer()
self._timer=self:setTimer(1,0,func)
end



function UIXingYu_HZ_ZDWin:initTeamSelectRoot()
self.refreshSelectIndex=true
local xyId=self.xyId
if not XingYuController.checkHasTeam(xyId)then
logErr("没有派遣队伍打开混战争夺战界面")
return
end

local teamGuidList=XingYuModel:getXingYuData_teamGuidList(xyId)

self.selectTempList={}
for teamIndex,guidList in pairs(teamGuidList)do
local temp={}
temp.index=teamIndex
local fight=0
for ii,guid in ipairs(guidList)do
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local _fight=mathHelper.int64_to_number(netdata.fightvalue)
if _fight>fight then
fight=_fight
temp.maxFightdzGuid=guid
end
end
if temp.maxFightdzGuid then
table.insert(self.selectTempList,temp)
end
end
if#self.selectTempList<=0 then
logErr("星域界面 selectTempList==0")
return
end

self.selectIndex=1
self.teamSelectList:setChildLayoutGroupClearAllItems()
self.teamSelectList:setChildLayoutGroupCreateItems(#self.selectTempList,function(index)
local temp=self.selectTempList[index]
local guid=temp.maxFightdzGuid
local teamIndex=temp.index

local xyteamselecetItem=self.teamSelectList:getChildLayoutGroupGridItem(index-1)
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local dzId=netdata.id
local isSpDz=UIDiscipleModel:isSPDisciple(dzId)
local switchidx
if isSpDz then
local netDzId=XingYuModel:getXingYuData_teamListDzId(xyId,guid)
if netDzId and netDzId~=dzId then
switchidx=1
end
end
local image=UIDiscipleModel.calculationDiscipleImageBase(netdata,switchidx)





local color=image.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(netdata,color)

comHelper.setChildModelHeadIconBGByColor(xyteamselecetItem,0,color)


UIDiscipleModel:setDiscipleXianMoHeadImage(xyteamselecetItem,3,netdata)


local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,xyteamselecetItem,modelParams,eHeadCenterType.eHead,nil,false)

xyteamselecetItem:SetChildActive(4,false)
xyteamselecetItem:SetChildActive(7,true)
xyteamselecetItem:SetChildCSImageSprite(7,teamabName,teamAssetName[teamIndex])
xyteamselecetItem:SetChildActive(5,false)
xyteamselecetItem:SetChildButtonClick(6,function()
self:onSelecetItemClick(index)
end)
end)


end


function UIXingYu_HZ_ZDWin:recvData(teamIndex)
if not self.reqList then
return
end

self.reqList[teamIndex]=nil
if next(self.reqList)then
return
end


if self.refreshSelectIndex then
self.refreshSelectIndex=false
local xyId=self.xyId
for index,temp in ipairs(self.selectTempList)do
local teamIndex=temp.index
local isFail=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
if not isFail then
self.selectIndex=index
break
end
end
end

if self.openCloudstate==XingYuState.eHunZhan then
local info=self.autoRePlayInfo
local xyId=self.xyId
local state=self.state
local fightTemp
local fightLogId
if state==XingYuState.eHunZhan then
fightTemp=XingYuModel:getXingYuData_hzFightTemp(xyId,info.teamIndex)
fightLogId=fightTemp.fightLogId
else
fightTemp=XingYuModel:getXingYuData_zdzFightTemp(xyId,info.teamIndex)
fightLogId=fightTemp.fightLogId
end

local fightdata={
[1]={
name=playerModel:getActorName(),
iconInfo=playerModel:getActorIconInfo()
},
[2]={
name=fightTemp.fightName,
iconInfo=fightTemp.fightIcon
},
fightLogId=fightLogId
}
XingYuController.autoRePlay(fightdata,xyId)




self.openCloudstate=nil
self.autoRePlayInfo=nil

elseif self.openCloudstate==XingYuState.eZhenDuo then
XingYuController.req_35_107(self.xyId)
XingYuController.autoRePlayInfo=self.autoRePlayInfo
self.autoRePlayInfo=nil
self.openCloudstate=nil
else
if self.openCloudFlag then
loadingControl.closeCloud()
self.openCloudFlag=false
end
self:refreshView()
end


end


function UIXingYu_HZ_ZDWin:refreshTeamSelectRoot()
local xyId=self.xyId
for index,temp in ipairs(self.selectTempList)do
local guid=temp.maxFightdzGuid
local teamIndex=temp.index
local isFail=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
local xyteamselecetItem=self.teamSelectList:getChildLayoutGroupGridItem(index-1)
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local dzId=netdata.id
local isSpDz=UIDiscipleModel:isSPDisciple(dzId)
local switchidx
if isSpDz then
local netDzId=XingYuModel:getXingYuData_teamListDzId(xyId,guid)
if netDzId and netDzId~=dzId then
switchidx=1
end
end
local image=UIDiscipleModel.calculationDiscipleImageBase(netdata,switchidx)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
xyteamselecetItem:SetChildActive(4,isFail)

xyteamselecetItem:SetChildActive(5,self.selectIndex==index)
xyteamselecetItem:SetChildGray(0,isFail)
comHelper.setChildModelRawImageEx(1,xyteamselecetItem,modelParams,eHeadCenterType.eHead,nil,isFail)
end

end

function UIXingYu_HZ_ZDWin:reqRivalInfo()
if not self:refreshState()then
return
end
local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index

local xyId=self.xyId
local state=self.state
if state==XingYuState.eHunZhan then
XingYuController.req_35_110(xyId,teamIndex)
self.reqList[teamIndex]=true
else
local isFail,failType,failRound=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
if isFail then
XingYuController.req_35_111(xyId,teamIndex,failRound)
self.reqList[teamIndex]=true
else
local nextzdzRound=XingYuController.getZDZNextRound(xyId)
if nextzdzRound then
XingYuController.req_35_111(xyId,teamIndex,nextzdzRound)
self.reqList[teamIndex]=true
else
local zdzSumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)
XingYuController.req_35_111(xyId,teamIndex,zdzSumRound)
self.reqList[teamIndex]=true
end
end
end
end

function UIXingYu_HZ_ZDWin:reqAllRivalInfo()
if not self:refreshState()then
return
end
for i,temp in ipairs(self.selectTempList or{})do

local xyId=self.xyId
local state=self.state
local teamIndex=temp.index
if state==XingYuState.eHunZhan then
XingYuController.req_35_110(xyId,teamIndex)
self.reqList[teamIndex]=true
else
local isFail,failType,failRound=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
if isFail then
XingYuController.req_35_111(xyId,teamIndex,failRound)
self.reqList[teamIndex]=true
else
local nextzdzRound=XingYuController.getZDZNextRound(xyId)
if nextzdzRound then
XingYuController.req_35_111(xyId,teamIndex,nextzdzRound)
self.reqList[teamIndex]=true
else
local zdzSumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)
XingYuController.req_35_111(xyId,teamIndex,zdzSumRound)
self.reqList[teamIndex]=true
end
end
end
end

end

function UIXingYu_HZ_ZDWin:checkOpenCloud(startround)

if not self.selectTempList or not self.selectIndex or not self.selectTempList[self.selectIndex]then
return false
end
local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index
local xyId=self.xyId
local state=self.state
local isFail=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
if isFail then

return false
end
if state==XingYuState.eHunZhan then






self.openCloudstate=state
self.autoRePlayInfo={teamIndex=teamIndex,round=startround}

return true
elseif state==XingYuState.eZhenDuo then






self.openCloudstate=state
self.autoRePlayInfo={teamIndex=teamIndex,round=startround}
return true
end

end

function UIXingYu_HZ_ZDWin:setOpenCloudFlag(flag)
self.openCloudFlag=flag
end

function UIXingYu_HZ_ZDWin:refreshView(teamIndex)







self:refreshTeamSelectRoot()
self:refreshFightTipRoot()
self:refreshShenglvRoot()
self:refreshPlayerRoot()
self:refreshHzIngRewardRoot()
self:refreshEmptyTipRoot()
self:refreshHzWinTipRoot()
self:refreshHzFailTipRoot()
self:refreshTeamSumRewardRoot()
self:refreshZdRoundBgRoot()
self:refreshZdzIngRewardRoot()
self:refreshFinishRoot()
self:refreshDzModelListRoot()
self:refreshZDZRewardBtn()
end

function UIXingYu_HZ_ZDWin:refreshFightTipRoot()
local xyId=self.xyId
local state=self.state
if state==XingYuState.eFinish then
self.fightTipRoot:setActive(false)
return
end
self.fightTipRoot:setActive(true)
local str,nextRound,nextTime,stateName,sumRound

if state==XingYuState.eHunZhan then
nextRound=XingYuController.getHZNextRound(xyId)
if nextRound then
nextTime=XingYuController.getHZRoundFightTime(nextRound)
end
stateName="混战"
sumRound=XingYuModel:getXingYuData_hzSumRound(xyId)
elseif state==XingYuState.eZhenDuo then
nextRound=XingYuController.getZDZNextRound(xyId)
if nextRound then
nextTime=XingYuController.getZDRoundFightTime(nextRound)
end
stateName="争夺战"
sumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)
end
if nextRound then

str=FMT.fmt("<color=#f1ce78>{0}</color>后进行第{1}轮{2}<color=#f1ce78>（{3}/{4}）</color>",timeHelper.format_time_stamp12(nextTime-timeHelper.getServerShortTime()),nextRound,stateName,nextRound,sumRound)
else
str="<color=#FFFFFF>所有轮次对战结束</color>"
end
self.fightTipTxt:setText(str)
end

function UIXingYu_HZ_ZDWin:refreshShenglvRoot()
self.shenglvRoot:setActive(false)




































end

function UIXingYu_HZ_ZDWin:refreshPlayerRoot()
local xyId=self.xyId
local state=self.state

if state==XingYuState.eFinish then
self.selfPlayerInfo:setActive(false)
self.otherPlayerInfo:setActive(false)
return
end


local nextHzRound=XingYuController.getHZNextRound(xyId)
if state==XingYuState.eHunZhan and not nextHzRound then
self.selfPlayerInfo:setActive(false)
self.otherPlayerInfo:setActive(false)
return
end


local nextzdzRound=XingYuController.getZDZNextRound(xyId)
if state==XingYuState.eZhenDuo and not nextzdzRound then
self.selfPlayerInfo:setActive(false)
self.otherPlayerInfo:setActive(false)
return
end

local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index

local isFail=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
if isFail then
self.selfPlayerInfo:setActive(false)
self.otherPlayerInfo:setActive(false)
return
end

self.selfPlayerInfo:setActive(true)
local selfWidget=self.selfPlayerInfo:getWidgetBase()

local fight=XingYuController.getXingYuTeamFight_TeamIndex(xyId,teamIndex)




selfWidget:SetChildText(1,mathHelper.formatNumber3(fight))
selfWidget:SetChildText(2,playerModel:getActorName())
playerController:setHeadIcon(selfWidget,3,{iconInfo=playerModel:getActorIconInfo(),scale=HEAD_SCALE_TYPE.e60x60})
selfWidget:SetChildText(4,loginModel:getMyServerName())

selfWidget:SetChildButtonClick(5,function()
XingYuController.showActorInfo(playerModel:getActorID(),loginModel.server_id,xyId,teamIndex,playerModel:getActorIconInfo(),playerModel:getActorName())
end)

local hasRival=XingYuController.checkXingYuStateTeamRival(xyId,teamIndex,state)
if not hasRival then
self.otherPlayerInfo:setActive(false)
return
end
self.otherPlayerInfo:setActive(true)
local temp
if state==XingYuState.eHunZhan then
temp=XingYuModel:getXingYuData_hzFightTemp(xyId,teamIndex)
else
temp=XingYuModel:getXingYuData_zdzFightTemp(xyId,teamIndex)
end
local otherWidget=self.otherPlayerInfo:getWidgetBase()
local fight=temp.fight
otherWidget:SetChildText(1,mathHelper.formatNumber3(fight))
otherWidget:SetChildText(2,temp.rName)
playerController:setHeadIcon(otherWidget,3,{iconInfo=temp.rIconInfo,scale=HEAD_SCALE_TYPE.e60x60})
otherWidget:SetChildText(4,loginModel:getServerName(temp.rServerId))
otherWidget:SetChildButtonClick(5,function()
XingYuController.showActorInfo(temp.rActorId,temp.rServerId,xyId,temp.rTeamIndex,temp.rIconInfo,temp.rName)
end)
end

function UIXingYu_HZ_ZDWin:refreshHzIngRewardRoot()
local xyId=self.xyId
local state=self.state

if state==XingYuState.eFinish or state==XingYuState.eZhenDuo then
self.hzIngReward:setActive(false)
return
end

local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index

local isFail=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
if isFail then
self.hzIngReward:setActive(false)
return
end



local nextRound=XingYuController.getHZNextRound(xyId)
if not nextRound then
self.hzIngReward:setActive(false)
return
end

self.hzIngReward:setActive(true)
local winRwList=XingYuController.getHZRoundRwList(xyId,nextRound,true)
local failRwList=XingYuController.getHZRoundRwList(xyId,nextRound,false)

local winCnt=#winRwList>=2 and 2 or#winRwList
self.hzIngwinReward:setChildLayoutGroupCreateItems(winCnt,function(index)
local rewardItem=self.hzIngwinReward:getChildLayoutGroupGridItem(index-1)
local rewardData=winRwList[index]
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)
end)

local failCnt=#failRwList>=2 and 2 or#failRwList
self.hzIngFailReward:setChildLayoutGroupCreateItems(failCnt,function(index)
local rewardItem=self.hzIngFailReward:getChildLayoutGroupGridItem(index-1)
local rewardData=failRwList[index]
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)
end)

end

function UIXingYu_HZ_ZDWin:refreshEmptyTipRoot()
local xyId=self.xyId
local state=self.state

if state==XingYuState.eFinish then
self.emptyTip:setActive(false)
return
end

local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index

local isFail=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
if isFail then
self.emptyTip:setActive(false)
return
end


local nextHzRound=XingYuController.getHZNextRound(xyId)
if state==XingYuState.eHunZhan and not nextHzRound then
self.emptyTip:setActive(false)
return
end


local nextzdzRound=XingYuController.getZDZNextRound(xyId)
if state==XingYuState.eZhenDuo and not nextzdzRound then
self.emptyTip:setActive(false)
return
end


local hasRival=XingYuController.checkXingYuStateTeamRival(xyId,teamIndex,state)
self.emptyTip:setActive(not hasRival)
end

function UIXingYu_HZ_ZDWin:refreshHzWinTipRoot()
local xyId=self.xyId
local state=self.state

if state==XingYuState.eFinish or state==XingYuState.eZhenDuo then
self.hzWinTipRoot:setActive(false)
return
end

local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index

local isFail=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
if isFail then
self.hzWinTipRoot:setActive(false)
return
end



local nextRound=XingYuController.getHZNextRound(xyId)

local hasRival=XingYuController.checkXingYuStateTeamRival(xyId,teamIndex,state)
if not hasRival and nextRound then
self.hzWinTipRoot:setActive(false)
return
end
self.hzWinTipRoot:setActive(nextRound==nil)
end

function UIXingYu_HZ_ZDWin:refreshHzFailTipRoot()
local xyId=self.xyId
local state=self.state






local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index

local isFail,failType,failRound=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
if isFail then
self.hzFailTipRoot:setActive(true)
local str=""
if failType==FailType.eTanSuo then
str="队伍在<color=#fd8950>探索期</color>遭到重创，无法参加对战"


else
self.hzFailTipRoot:setActive(false)
end
self.hzFailTip:setText(str)
else
self.hzFailTipRoot:setActive(false)
end
end

function UIXingYu_HZ_ZDWin:refreshTeamSumRewardRoot()
local xyId=self.xyId
local state=self.state

local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index

local isFail,failType,failRound=XingYuController.checkXingYuTeamFail(xyId,teamIndex)

local nextHzRound=XingYuController.getHZNextRound(xyId)
if not isFail and state==XingYuState.eHunZhan and nextHzRound then
self.teamSumRewardRoot:setActive(false)
return
end


local nextzdzRound=XingYuController.getZDZNextRound(xyId)
if not isFail and state==XingYuState.eZhenDuo and nextzdzRound then
self.teamSumRewardRoot:setActive(false)
return
end

self.teamSumRewardRoot:setActive(true)
local titleStr="累计对战奖励"
local rewardList

local temp
if state==XingYuState.eHunZhan then
temp=XingYuModel:getXingYuData_hzFightTemp(xyId,teamIndex)
else
temp=XingYuModel:getXingYuData_zdzFightTemp(xyId,teamIndex)
end

if isFail and failType==FailType.eTanSuo then
titleStr="累计探索奖励"
rewardList=temp.tsRewardList
else
rewardList=self:getFightRewardList(temp)
end

self.teamSumRewardTitle:setText(titleStr)
self.teamNoSumRewardTip:setActive(not rewardList or#rewardList<=0)

local Cnt=#rewardList
if Cnt<=4 then
self.teamSumRewardSView:setActive(true)
self.teamSumRewardSViewEx:setActive(false)
self.teamSumRewardList:setChildLayoutGroupCreateItems(Cnt,function(index)
local rewardItem=self.teamSumRewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardList[index]
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)
end)
else
self.teamSumRewardSView:setActive(false)
self.teamSumRewardSViewEx:setActive(true)
self.teamSumRewardListEx:setChildLayoutGroupCreateItems(Cnt,function(index)
local rewardItem=self.teamSumRewardListEx:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardList[index]
widgetHelper.setNormalRewardItem(rewardItem,-1,rewardData,true)
end)
end


end

function UIXingYu_HZ_ZDWin:getFightRewardList(temp)
local xyId=self.xyId
local lookUp={}
if not temp.zdzidx then
local hzSumRound=XingYuModel:getXingYuData_hzSumRound(xyId)
hzSumRound=hzSumRound<=0 and 1 or hzSumRound
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local color=xyCfg.color
local colorCfg=cfgHelper.get(cfg_xingyuhunzhanrewardconfig_get,color)
local hzqfail=temp.hzFailIndex
local hzqwin=hzqfail==0 and hzSumRound or hzqfail-1
for r=1,hzqwin do
local realLun=hzSumRound-r+1
local rwList=colorCfg[realLun].winRewards
for ___,itemCfg in ipairs(rwList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
if self.level>0 then
local dwRwList=colorCfg[realLun].dwRewards[self.level]
if dwRwList then
local dwWinRWList=dwRwList[1]
for ___,itemCfg in ipairs(dwWinRWList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
end
end
end

if hzqfail~=0 then
local realLun=hzSumRound-hzqfail+1
local rwList=colorCfg[realLun].lostRewards
for ___,itemCfg in ipairs(rwList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end

if self.level>0 then
local dwRwList=colorCfg[realLun].dwRewards[self.level]
if dwRwList then
local dwLoseRWList=dwRwList[2]
for ___,itemCfg in ipairs(dwLoseRWList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
end
end
end
else
local hzSumRound=XingYuModel:getXingYuData_hzSumRound(xyId)
hzSumRound=hzSumRound<=0 and 1 or hzSumRound
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local hzFailIndex=temp.hzFailIndex

local color=xyCfg.color
local hzcolorCfg=cfgHelper.get(cfg_xingyuhunzhanrewardconfig_get,color)
for r=1,hzFailIndex==0 and hzSumRound or hzFailIndex-1 do
local realLun=hzSumRound-r+1
local rwList=hzcolorCfg[realLun].winRewards
for ___,itemCfg in ipairs(rwList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end

if self.level>0 then
local dwRwList=hzcolorCfg[realLun].dwRewards[self.level]
if dwRwList then
local dwWinRWList=dwRwList[1]
for ___,itemCfg in ipairs(dwWinRWList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
end
end
end
if hzFailIndex~=0 then
local realLun=hzSumRound-hzFailIndex+1
local rwList=hzcolorCfg[realLun].lostRewards
for ___,itemCfg in ipairs(rwList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
if self.level>0 then
local dwRwList=hzcolorCfg[realLun].dwRewards[self.level]
if dwRwList then
local dwLoseRWList=dwRwList[2]
for ___,itemCfg in ipairs(dwLoseRWList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
end
end
end
local zdcolorCfg=cfgHelper.get(cfg_xingyuzhengduozhanrewardconfig_get,color)
local zdzwin=temp.zdzWinIndex
local zdzfail=temp.zdzFailIndex

if zdzwin~=0 or zdzfail~=0 then

local zdzSumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)


zdzSumRound=zdzSumRound<=0 and 1 or zdzSumRound
if zdzwin~=0 then
for r=1,zdzwin do

local rwList=XingYuController.getZDRoundRwList(xyId,r,true,self.level)
for ___,itemCfg in ipairs(rwList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
end
end

if zdzfail~=0 then


local rwList=XingYuController.getZDRoundRwList(xyId,zdzfail,false,self.level)
for ___,itemCfg in ipairs(rwList)do
if lookUp[itemCfg[1]]then
lookUp[itemCfg[1]]=lookUp[itemCfg[1]]+itemCfg[2]
else
lookUp[itemCfg[1]]=itemCfg[2]
end
end
end
end

end
local rewardList={}
for itemId,num in pairs(lookUp)do
local color=itemsConfig.getItemColor(itemId)
table.insert(rewardList,{itemId,num,color=color,showStage=true,})
end
table.sort(rewardList,function(a,b)
return a.color>b.color
end)
return rewardList
end

function UIXingYu_HZ_ZDWin:refreshZdRoundBgRoot()
local xyId=self.xyId
local state=self.state

local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index

local isFail,failType,failRound=XingYuController.checkXingYuTeamFail(xyId,teamIndex)

if not isFail then
local nextRound
if state==XingYuState.eHunZhan then
nextRound=XingYuController.getHZNextRound(xyId)
elseif state==XingYuState.eZhenDuo then
nextRound=XingYuController.getZDZNextRound(xyId)
end
if nextRound then
self.zdRoundBg:setActive(true)
self.zdRound:setText(FMT.fmt("第{0}轮",nextRound))
else
self.zdRoundBg:setActive(false)
end
else
self.zdRoundBg:setActive(false)
end
end

function UIXingYu_HZ_ZDWin:refreshZdzIngRewardRoot()
local xyId=self.xyId
local state=self.state

local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index

local isFail,failType,failRound=XingYuController.checkXingYuTeamFail(xyId,teamIndex)

local nextzdzRound=XingYuController.getZDZNextRound(xyId)
if not isFail and state==XingYuState.eZhenDuo and nextzdzRound then
self.zdzIngReward:setActive(true)
local xyCfg=XingYuModel:getXingYuConfig(xyId)
local color=xyCfg.color
local cfg=cfgHelper.get(cfg_xingyuzhengduozhanrewardconfig_get,color)
local zdzSumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)
local realLun=zdzSumRound-nextzdzRound+1
local winRwList=XingYuController.getZDRoundRwList(xyId,nextzdzRound,true)
local bigRw=winRwList[1]
local itemid=bigRw[1]
local showCnt=bigRw[2]>1
local cntStr=showCnt and bigRw[2]or""
local fillData=itemsComponentHelper.getCommonFillData({itemid=itemid},{showname=false,itemcount=cntStr,showCountBG=showCnt,showStageBg=true})
self.zdzIngRewardItem:setChildPropData(fillData)

if xyCfg.zdzItemBgModel then
self.zdzIngRewardBg:setActive(false)
self.zdzIngRewardBgModel:setChildUIModelShowTarget(xyCfg.zdzItemBgModel,1,nil,eAnimationID.stand)
elseif xyCfg.zdzItemBg then
self.zdzIngRewardBg:setActive(true)
self.zdzIngRewardBgModel:setChildUIModelRemoveTarget(4)
self.zdzIngRewardBg:setSprite(abName,xyCfg.zdzItemBg)
else
logErr("UIXingYu_HZ_ZDWin 争夺期宝物道具背景 没配置")
end

else
self.zdzIngReward:setActive(false)
end
end

function UIXingYu_HZ_ZDWin:refreshFinishRoot()
local xyId=self.xyId
local state=self.state





local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index

local isFail,failType,failRound=XingYuController.checkXingYuTeamFail(xyId,teamIndex)


if isFail and failType==FailType.eTanSuo then
self.finishRoot:setActive(false)
return
end


local nextHzRound=XingYuController.getHZNextRound(xyId)
if not isFail and state==XingYuState.eHunZhan then
self.finishRoot:setActive(false)
return
end


local nextzdzRound=XingYuController.getZDZNextRound(xyId)
if not isFail and state==XingYuState.eZhenDuo and nextzdzRound then
self.finishRoot:setActive(false)
return
end


self.finishRoot:setActive(true)
if failType==FailType.eHunZhan then
self.GJIcon:setActive(false)
local hzSumRound=XingYuModel:getXingYuData_hzSumRound(xyId)
self.replayBtn:setActive(hzSumRound>0)
hzSumRound=hzSumRound<=0 and 1 or hzSumRound
self.finishstage:setChildAnchoredPos(-49.8,0.3)
self.finishstage:setText("混战")
self.finishRound:setChildAnchoredPos(43.5,0.3)
self.finishRound:setText(FMT.fmt("第{0}轮",isFail and failRound or hzSumRound))
else
local zdzSumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)
self.replayBtn:setActive(zdzSumRound>0)
zdzSumRound=zdzSumRound<=0 and 1 or zdzSumRound
self.finishstage:setChildAnchoredPos(-44.5,0.3)
self.finishstage:setText("争夺战")
self.finishRound:setChildAnchoredPos(61.6,0.3)
self.finishRound:setText(FMT.fmt("第{0}轮",isFail and failRound or zdzSumRound))
self.GJIcon:setActive(not isFail)
end

end

function UIXingYu_HZ_ZDWin:refreshDzModelListRoot()
local xyId=self.xyId
local state=self.state
local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index
local isFail,failType,failRound=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
local dzList={}


if isFail then
if failType==FailType.eTanSuo then

elseif failType==FailType.eHunZhan then

elseif failType==FailType.eZhenDuo then

end

local guidList=XingYuController.getXingYuTeamDzList_TeamIndex(xyId,teamIndex)
for i,guid in ipairs(guidList)do
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local posData=c_posDataList[#guidList][i]
local temp={}
temp.baseData=netdata
temp.posData=posData
temp.fipX=false
temp.actorId=playerModel:getActorID()
temp.serverId=loginModel.server_id
temp.iconInfo=playerModel:getActorIconInfo()
temp.name=playerModel:getActorName()
temp.teamIndex=teamIndex
temp.speakType=1
temp.isLeft=true
table.insert(dzList,temp)
end
else
local nexthzRound=XingYuController.getHZNextRound(xyId)
local nextzdzRound=XingYuController.getZDZNextRound(xyId)

if state==XingYuState.eHunZhan and not nexthzRound then
local guidList=XingYuController.getXingYuTeamDzList_TeamIndex(xyId,teamIndex)
for i,guid in ipairs(guidList)do
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local posData=c_posDataList[#guidList][i]
local temp={}
temp.baseData=netdata
temp.posData=posData
temp.fipX=false
temp.actorId=playerModel:getActorID()
temp.serverId=loginModel.server_id
temp.iconInfo=playerModel:getActorIconInfo()
temp.name=playerModel:getActorName()
temp.teamIndex=teamIndex
temp.isLeft=true
table.insert(dzList,temp)
end

elseif(state==XingYuState.eZhenDuo and not nextzdzRound)or state==XingYuState.eFinish then
local guidList=XingYuController.getXingYuTeamDzList_TeamIndex(xyId,teamIndex)
for i,guid in ipairs(guidList)do
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local posData=c_posDataList[#guidList][i]
local temp={}
temp.baseData=netdata
temp.posData=posData
temp.fipX=false
temp.actorId=playerModel:getActorID()
temp.serverId=loginModel.server_id
temp.iconInfo=playerModel:getActorIconInfo()
temp.name=playerModel:getActorName()
temp.teamIndex=teamIndex
temp.speakType=4
temp.isLeft=true
table.insert(dzList,temp)
end

elseif state==XingYuState.eHunZhan and nexthzRound then
local speakType
local hasRival=XingYuController.checkXingYuStateTeamRival(xyId,teamIndex,state)
if hasRival then
local hzFightTemp=XingYuModel:getXingYuData_hzFightTemp(xyId,teamIndex)
if mathHelper.compareInt64(playerModel:getActorID(),hzFightTemp.rActorId)then
speakType=3
else
speakType=2
end
end

local posguidList=XingYuController.getXingYuTeamPosDzList_TeamIndex(xyId,teamIndex)
for i,guid in ipairs(posguidList)do
if not mathHelper.compareInt64(guid,Int64_0)then
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local posData=l_posDataList[i]
local temp={}
temp.baseData=netdata
temp.posData=posData
temp.fipX=true
temp.actorId=playerModel:getActorID()
temp.serverId=loginModel.server_id
temp.iconInfo=playerModel:getActorIconInfo()
temp.name=playerModel:getActorName()
temp.teamIndex=teamIndex
temp.speakType=speakType
temp.isLeft=true
table.insert(dzList,temp)
end
end

if hasRival then
local hzFightTemp=XingYuModel:getXingYuData_hzFightTemp(xyId,teamIndex)
local teamDzList=hzFightTemp.teamDzList
for i,xingyuDisciple in ipairs(teamDzList or{})do
local guid=xingyuDisciple.dzInfo.discipleguid
if not mathHelper.compareInt64(guid,Int64_0)then
local temp={}
temp.baseData=xingyuDisciple.dzInfo
temp.posData=r_posDataList[i]
temp.fipX=false
temp.actorId=hzFightTemp.rActorId
temp.serverId=hzFightTemp.rServerId
temp.iconInfo=hzFightTemp.rIconInfo
temp.name=hzFightTemp.rName
temp.teamIndex=hzFightTemp.rTeamIndex
temp.speakType=speakType
temp.isLeft=false
table.insert(dzList,temp)
end
end
end

elseif state==XingYuState.eZhenDuo and nextzdzRound then

local speakType
local hasRival=XingYuController.checkXingYuStateTeamRival(xyId,teamIndex,state)
if hasRival then
local zdzFightTemp=XingYuModel:getXingYuData_zdzFightTemp(xyId,teamIndex)
if mathHelper.compareInt64(playerModel:getActorID(),zdzFightTemp.rActorId)then
speakType=3
else
speakType=2
end
end


local posguidList=XingYuController.getXingYuTeamPosDzList_TeamIndex(xyId,teamIndex)
for i,guid in ipairs(posguidList)do
if not mathHelper.compareInt64(guid,Int64_0)then
local netdata=UIDiscipleModel:getDiscipleDataX(guid).netData.net
local posData=l_posDataList[i]
local temp={}
temp.baseData=netdata
temp.posData=posData
temp.fipX=true
temp.actorId=playerModel:getActorID()
temp.serverId=loginModel.server_id
temp.iconInfo=playerModel:getActorIconInfo()
temp.name=playerModel:getActorName()
temp.teamIndex=teamIndex
temp.speakType=speakType
temp.isLeft=true
table.insert(dzList,temp)
end
end


local hasRival=XingYuController.checkXingYuStateTeamRival(xyId,teamIndex,state)
if hasRival then
local zdzFightTemp=XingYuModel:getXingYuData_zdzFightTemp(xyId,teamIndex)
local teamDzList=zdzFightTemp.teamDzList
for i,xingyuDisciple in ipairs(teamDzList or{})do
local guid=xingyuDisciple.dzInfo.discipleguid
if not mathHelper.compareInt64(guid,Int64_0)then
local temp={}
temp.baseData=xingyuDisciple.dzInfo
temp.posData=r_posDataList[i]
temp.fipX=false
temp.actorId=zdzFightTemp.rActorId
temp.serverId=zdzFightTemp.rServerId
temp.iconInfo=zdzFightTemp.rIconInfo
temp.name=zdzFightTemp.rName
temp.teamIndex=zdzFightTemp.rTeamIndex
temp.speakType=speakType
temp.isLeft=false
table.insert(dzList,temp)
end
end
end
end
end
self:killAllSpeakTween()
self.speakDzList={}
self.dzModelList:setChildLayoutGroupCreateItems(#dzList,function(index)
local dzModelItem=self.dzModelList:getChildLayoutGroupGridItem(index-1)
local data=dzList[index]
local baseData=data.baseData
local posData=data.posData
local dzId=baseData.id
local guid=baseData.discipleguid
local isSpDz=UIDiscipleModel:isSPDisciple(dzId)
local switchidx
if isSpDz then
local netDzId=XingYuModel:getXingYuData_teamListDzId(xyId,guid)
if netDzId and netDzId~=dzId then
switchidx=1
end
end
local image=UIDiscipleModel.calculationDiscipleImageBase(baseData,switchidx)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(image)
dzModelItem:SetChildUIModelShowTarget(0,modelParams.body,0.8,modelParams.componets,modelParams.anim)
dzModelItem:SetChildAnchoredPos(4,posData.x,posData.y)
dzModelItem:SetChildUIModelShowFlipX(0,data.fipX)
dzModelItem:SetChildButtonClick(5,function()

XingYuController.showActorInfo(data.actorId,data.serverId,xyId,data.teamIndex,data.iconInfo,data.name)
end)
local teamp=self.speakDzList
if data.isLeft and not teamp.leftWidget and data.speakType then
teamp.leftWidget=self.leftspeak:getWidgetBase()
teamp.ctime=0
teamp.showtime=5
teamp.interltime=3
local speakTypeCfg=cfg_xingyuspeakconfig_get(data.speakType)
local speakSubIdList={}
for k,v in pairs(speakTypeCfg)do
table.insert(speakSubIdList,v.subId)
end
local lastRandomIndex=math.random(1,#speakSubIdList)
teamp.speakSubIdList=speakSubIdList
teamp.lastRandomIndex=lastRandomIndex
teamp.speakType=data.speakType
end
if not data.isLeft and not teamp.rightWidget and data.speakType then
teamp.rightWidget=self.rightspeak:getWidgetBase()
end
end)
if self.speakDzList.leftWidget and not self.speakDzList.rightWidget then
self.speakDzList.leftWidget=self.centerspeak:getWidgetBase()
end

end

function UIXingYu_HZ_ZDWin:refreshZDZRewardBtn()
local xyId=self.xyId
local state=self.state
self.zdzRewardBtn:setActive(state==XingYuState.eZhenDuo or state==XingYuState.eFinish)
end







function UIXingYu_HZ_ZDWin:onHzRoundBtn()
local xyId=self.xyId
local state=self.state

if state==XingYuState.eHunZhan then
XingYuController.req_35_106(xyId)
else
XingYuController.req_35_107(xyId)
end
end

function UIXingYu_HZ_ZDWin:onReplayBtn()
local xyId=self.xyId
local state=self.state

if state==XingYuState.eDataErr or state==XingYuState.eNone or state==XingYuState.eTanSuo then
return
end
local temp=self.selectTempList[self.selectIndex]
local teamIndex=temp.index
local fightTemp
local isFail,failType,failRound=XingYuController.checkXingYuTeamFail(xyId,teamIndex)
local fightLogId
if state==XingYuState.eHunZhan then
fightTemp=XingYuModel:getXingYuData_hzFightTemp(xyId,teamIndex)
fightLogId=fightTemp.fightLogId
else
fightTemp=XingYuModel:getXingYuData_zdzFightTemp(xyId,teamIndex)





fightLogId=fightTemp.fightLogId
end



local args={}
args.eReplayType=eRePlayerType.xingyu
args.showBattle=true
args.result=isFail and 2 or 1
args.player1={playerModel:getActorName(),playerModel:getActorIconInfo()}
args.player2={fightTemp.fightName,fightTemp.fightIcon}
args.checkActorId=true
args.battleType=eBattleType.xingyu
args.fightCloseCallBack=function(battle)
loadingControl.openCloud(function()
if battle then
fightController:closeBattle(battle)
end
XingYuController.req_35_102(xyId)
end)
end
if fightLogId and fightLogId~=""then
loadingControl.openCloud(function()
if UIFullXingYuController.fightStage then
UIFullXingYuController.fightStage:close()
UIFullXingYuController.fightStage=nil
end

fightModel:setSendExtraArgs(eBattleType.xingyu,args)
fightController:send_log_list({fightLogId},args,true,true)
end,nil,true)
else
UIManager.error("回放失败，战斗记录已过期或无效")
end
end

function UIXingYu_HZ_ZDWin:onRuleBtn()





local args={
ruleGroupID=ruleTipsImageGroup.eXingYu,
}
self:showWindow("UIRuleTipsImage2Win",args)
end

function UIXingYu_HZ_ZDWin:onCloseBtn()
if UIFullXingYuController.fightStage then
UIFullXingYuController.fightStage:close()
UIFullXingYuController.fightStage=nil
end
UIFullXingYuController:closeUI()
end

function UIXingYu_HZ_ZDWin:onSelecetItemClick(index)
if self.selectIndex==index then
return
end
local oldItem=self.teamSelectList:getChildLayoutGroupGridItem(self.selectIndex-1)
oldItem:SetChildActive(5,false)
local newItem=self.teamSelectList:getChildLayoutGroupGridItem(index-1)
newItem:SetChildActive(5,true)
self.selectIndex=index
self:reqRivalInfo()
end

function UIXingYu_HZ_ZDWin:onZdzRewardBtn()
local xyId=self.xyId
local state=self.state
local args={
xyId=xyId,
}

local nextzdzRound=XingYuController.getZDZNextRound(xyId)
local tabTpye
if nextzdzRound==1 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZDZReward_Round1
elseif nextzdzRound==2 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZDZReward_Round2
elseif nextzdzRound==3 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZDZReward_Round3
elseif nextzdzRound==4 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZDZReward_Round4
elseif nextzdzRound==5 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZDZReward_Round5
else
local sumRound=XingYuModel:getXingYuData_zdzSumRound(xyId)

if sumRound==0 or sumRound==1 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZDZReward_Round1
elseif sumRound==2 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZDZReward_Round2
elseif sumRound==3 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZDZReward_Round3
elseif sumRound==4 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZDZReward_Round4
elseif sumRound==5 then
tabTpye=SEC_FULL_TAB_TYPE.eXYZDZReward_Round5
end
end
if tabTpye then
oneTabScreenController:openTabUI(tabTpye,args)
else
oneTabScreenController:openUI(SEC_FULL_TYPE.XYZDZReward,args)
end
end

function UIXingYu_HZ_ZDWin:onSlTipClick()
self.slTipRoot:setActive(true)
local callBack=function()
if self and self.isClose then return end
self.slTipRoot:setActive(false)
end
UIManager:invokeUIMethod("UIXingYuMainWin","openFullMaskClick",callBack)
end
