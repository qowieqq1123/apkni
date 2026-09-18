







def_class("UILingShanZhengDuoWin",UIWindowBase)









function UILingShanZhengDuoWin:bindComponents()

self.areaInfo_1=UIObject.get(self,0)
self.areaInfo_2=UIObject.get(self,1)
self.areaInfo_3=UIObject.get(self,2)
self.bg=UIObject.get(self,3)
self.bottomBtn=UIButton.get(self,4)
self.buffInfoText=UIText.get(self,5)
self.buyNumBtn=UIButton.get(self,6)
self.closeBtnName=UIText.get(self,7)
self.closeMPBtn=UIButton.get(self,8)
self.contect=UIObject.get(self,9)
self.contect2=UIObject.get(self,10)
self.countBg=UIObject.get(self,11)
self.countText=UIText.get(self,12)
self.helpBtn=UIButton.get(self,13)
self.infobg=UIObject.get(self,14)
self.infoPanel=UIObject.get(self,15)
self.logBtn=UIButton.get(self,16)
self.logReddot=UIObject.get(self,17)
self.mainPanel=UIObject.get(self,18)
self.other=UIObject.get(self,19)
self.rewardBtn=UIButton.get(self,20)
self.root=UIObject.get(self,21)
self.scrollView=UIObject.get(self,22)
self.scrollView2=UIObject.get(self,23)
self.smallIcon=UIImage.get(self,24)
self.teamBtn=UIButton.get(self,25)
self.teamCountText=UIText.get(self,26)
self.title=UIImage.get(self,27)
self.topBtn=UIButton.get(self,28)
self.wanFaBtn=UIButton.get(self,29)

self.bottomBtn:setButtonClick(function()self:onBottomBtn()end)

self.buyNumBtn:setButtonClick(function()self:onBuyNumBtn()end)

self.closeMPBtn:setButtonClick(function()self:onCloseMPBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.logBtn:setButtonClick(function()self:onLogBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.teamBtn:setButtonClick(function()self:onTeamBtn()end)

self.topBtn:setButtonClick(function()self:onTopBtn()end)

self.wanFaBtn:setButtonClick(function()self:onWanFaBtn()end)
self.areaInfo={
self.areaInfo_1,
self.areaInfo_2,
self.areaInfo_3,
}



end


function UILingShanZhengDuoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.areaInfo_1);self.areaInfo_1=nil;
_UIObject_release(self.areaInfo_2);self.areaInfo_2=nil;
_UIObject_release(self.areaInfo_3);self.areaInfo_3=nil;
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.bottomBtn);self.bottomBtn=nil;
_UIObject_release(self.buffInfoText);self.buffInfoText=nil;
_UIObject_release(self.buyNumBtn);self.buyNumBtn=nil;
_UIObject_release(self.closeBtnName);self.closeBtnName=nil;
_UIObject_release(self.closeMPBtn);self.closeMPBtn=nil;
_UIObject_release(self.contect);self.contect=nil;
_UIObject_release(self.contect2);self.contect2=nil;
_UIObject_release(self.countBg);self.countBg=nil;
_UIObject_release(self.countText);self.countText=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.infobg);self.infobg=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.logBtn);self.logBtn=nil;
_UIObject_release(self.logReddot);self.logReddot=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.other);self.other=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.scrollView2);self.scrollView2=nil;
_UIObject_release(self.smallIcon);self.smallIcon=nil;
_UIObject_release(self.teamBtn);self.teamBtn=nil;
_UIObject_release(self.teamCountText);self.teamCountText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.topBtn);self.topBtn=nil;
_UIObject_release(self.wanFaBtn);self.wanFaBtn=nil;
self.areaInfo=nil;
end
















local _this

local _infoIndex={
bg=0,
infoP=1,
infoM=2,
headP=3,
headM=4,
flag=5,
xmNameP=6,
nameP=7,
fValue=8,
leaveBtn=9,
tipsMY=10,
protect=11,
protectCD=12,
nameM=13,
playerImage=14,
challengeBtn=15,
headMBG=16,
click=17,
timebg=18,
time=19,
xmIconBG=20,
xmIcon=21,
xmIconK=22,
}




function UILingShanZhengDuoWin:onLoaded(...)
self:bindComponents()

self:addNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange,self.onZhengZhanShanHaiLogReddotChange)
self:addNotify(notifyConfig.onZZSHRaceStateChange,self.onZZSHRaceStateChange)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)


_this=self

self.abName='ui/windows/lingshanzhengduo/lszd_atlas_pak.ab'
self.titleImage={
'image_lingshanwendao_1',
'image_lingshanwendao_2'
}

self.smallImage={
'image_lingshanzhengduo_6',
'image_lingshanzhengduo_7'
}

self.teamInfoBG={
'image_lszd_jz1',
'image_lszd_jz2',
'image_lszd_jz3'
}







self.areaPanelBGMID={6203,6202,6201}

self.areaIds={3,2,1}

self.areaNames={'山底','山腰','山顶'}

self.countType={
eMoneyType.mtLingShanBattleTimes1,

}

self.protectTime=cfgHelper.get2(cfg_lingshanbattlebaseconfig_get,1,'protect_sec')

self.scrollItemHeight=750

self.fight_top5=playerModel:getActorFightValue()

self.scrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.scrollView2:setChildScrollViewInit(0.5,true,nil,nil)

self.timers={}

self.checkTimer=self:setTimer(0.25,0,function()
if self.needUpdateArrow then
self:refreshArrowBtn()
end
end)

self.rzTimeList={}
self.rzTimer=self:setTimer(1,0,function()
local currtime=gameUtilityModel.getServerShortTime()
for i,v in pairs(self.rzTimeList)do
local item=v[1]
local stime=v[2]
local dtime=currtime-stime
item:SetChildText(_infoIndex.time,timeHelper.format_time_stamp11(dtime,true))
end
end)

self.versionId=pfwindowslController:getGameVersion()
end


function UILingShanZhengDuoWin:__delete()
if zhengzhanshanhaiModel:checkJoin()then
zhengzhanshanhaiController:checkAndCloseListen("UILingShanZhengDuoWin")
end
self.scrollView:setChildScrollViewStopGridCreate()
self.scrollView2:setChildScrollViewStopGridCreate()
self:unbindComponents()
_this=nil
end




function UILingShanZhengDuoWin:onShow(argtable,afterOnloaded)

if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then
if zhengzhanshanhaiModel:checkJoin()then
zhengzhanshanhaiController:reqMapListen(1)
end
end

self:refresh(argtable)

if afterOnloaded and not self.areaId then
self:startPlayEnterAnim()
end
end

function UILingShanZhengDuoWin:init()

end

function UILingShanZhengDuoWin:onShowArgRecv(argtable)
self:refresh(argtable)
end

function UILingShanZhengDuoWin:startPlayEnterAnim()






self.root:setChildCanvasGroupAlpha(0)

self:delayDo(0.8,function()
self:playEnterAnim()
end)
end

function UILingShanZhengDuoWin:playEnterAnim()













self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end


function UILingShanZhengDuoWin:onHide()

end

function UILingShanZhengDuoWin.onZhengZhanShanHaiLogReddotChange()
_this:setLogReddot()
end

function UILingShanZhengDuoWin.onZZSHRaceStateChange(oldState,newState)
if newState==eZZSH_State.ePVPFight or newState==eZZSH_State.ePVPStandby then
UILSZDControl:closeUI(nil,true)
end
end

function UILingShanZhengDuoWin.on_money_changed(moneyType,lastVal,val)
if not _this then return end
if moneyType==eMoneyType.mtLingShanBattleTimes1 then
_this:setChallengeCount()
end
end





function UILingShanZhengDuoWin:setLogReddot()
local check=zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()
self.logReddot:setActive(check)
end

function UILingShanZhengDuoWin:refresh(argtable)
if argtable then
self.mountId=argtable.mountId
self.areaId=argtable.areaId
self.pos=argtable.pos
self.config=UILSZDControl:getLingShanConfig(self.mountId)

self.set_up_team_limit=self.config.set_up_team_limit[1]
if self.versionId and self.config.set_up_team_limit[self.versionId]then
self.set_up_team_limit=self.config.set_up_team_limit[self.versionId]
end
self.monster_group=self.config.monster_group[1]
if self.versionId and self.config.monster_group[self.versionId]then
self.monster_group=self.config.monster_group[self.versionId]
end

self.bg:setChildUIModelShowTarget(6181,1,nil,eAnimationID.enter)
self.title:setSprite(self.abName,self.titleImage[self.config.mount_type])
self.smallIcon:setSprite(self.abName,self.smallImage[self.config.mount_type])
end

if self.areaId then
self:showAreaInfoBG()
self.mainPanel:setActive(false)
self.infoPanel:setActive(true)
self.countBg:setActive(true)
self.countText:setChildPivot(Vector2(0.5,0.5))
self.countText:setChildAnchoredPos(157,7.8)
self.helpBtn:setChildAnchoredPos(322.8,10)
self.closeBtnName:setText(self.areaNames[self.areaId])
if self.areaId<3 then
self.scrollView:setActive(false)
self.scrollView2:setActive(true)
self:setAreaInfoPanel2()
else
self.scrollView:setActive(true)
self.scrollView2:setActive(false)
self:setAreaInfoPanel()
end
self:refreshTeamCount()
else
self.mainPanel:setActive(true)
self.infoPanel:setActive(false)
self.countBg:setActive(false)
self.countText:setChildPivot(Vector2(0.5,0))
self.countText:setChildAnchoredPos(147,-18.8)
self.helpBtn:setChildAnchoredPos(327,0)
self:setMainPanel()
self:refreshBuffInfo()
end
self:setChallengeCount()
self:setLogReddot()
end

function UILingShanZhengDuoWin:showAreaInfoBG()
local mId=self.areaPanelBGMID[self.areaId]
self.infobg:setChildUIModelShowTarget(mId,1,nil,eAnimationID.stand)
self.infobg:setChildCanvasGroupAlpha(0)
self.infobg:setChildCanvasGroupDOFade(1,0.3,nil)
end

function UILingShanZhengDuoWin:refreshBuffInfo()
local buffType=1
local cfg=cfgHelper.get1(cfg_lingshanbuffconfig_get,buffType)
local args=UILSZDControl:countBuffArgs(buffType)
local desc=FMT.fmt(cfg.desc,unpack(args))
local str=FMT.fmt('仙盟灵山增益：{0}',desc)
self.buffInfoText:setText(str)
end

function UILingShanZhengDuoWin:setMainPanel()
for i=1,3 do
local areaInfo=self.areaInfo[i]
local widget=areaInfo:getChildWidgetBase()
local areaId=self.areaIds[i]
widget:SetChildText(1,mathHelper.formatNumber(self.config.area_fight_value[areaId]))
local maxNum=self.set_up_team_limit[areaId]
local num=UILSZDControl:getMountAreaTeamNum(self.mountId,areaId)
widget:SetChildText(2,FMT.fmt('{0}/{1}',num,maxNum))
widget:SetChildButtonClick(3,function()
_this.areaId=areaId
_this:refresh()
end)
local check=UILSZDControl:hasMyTeam(self.mountId,areaId)
widget:SetChildActive(4,check)
end
end

function UILingShanZhengDuoWin:setChallengeCount()
local mount_type=self.config.mount_type
local mtype=self.countType[1]
local mcfg=moneyModel.getMoneyConfig(mtype)
local num=moneyModel.getMoney(mtype)
local max=mcfg.autoincr[5]
local info=UILSZDControl:getLingShanInfo(mount_type)

self.countText:setText(FMT.fmt('挑战次数：<color=#549327>{0}/{1}</color>',num,max))
if num<max then
self:setTeamCountTimer(info.name,max,mtype)
end
end

function UILingShanZhengDuoWin:setTeamCountTimer(name,max,mtype)
self:clearTCTimer()
local leastFull=moneyAutoIncreaseModel:getLeastTimeToFull(mtype)
if leastFull<=0 then
return
end
local endTime=gameUtilityModel.getServerShortTime()+leastFull
local func=function()
local currtime=gameUtilityModel.getServerShortTime()
local dtime=endTime-currtime
local num=moneyModel.getMoney(mtype)
if dtime>=0 and(num<max)then
dtime=math.max(dtime,0)
local tstr=timeHelper.format_time_stamp11(dtime,true)
self.countText:setText(FMT.fmt('挑战次数：<color=#549327>{0}/{1}</color>\n（全部恢复还需：{2}）',num,max,tstr))
else
self:clearTCTimer()
self:setChallengeCount()
end
end
func()
self.tcTimer=self:setTimer(1,0,func)
end

function UILingShanZhengDuoWin:clearTCTimer()
if self.tcTimer then
self:stopTimerByID(self.tcTimer)
self.tcTimer=nil
end
end

function UILingShanZhengDuoWin:refreshTeamCount()
local maxNum=self.set_up_team_limit[self.areaId]
local num=UILSZDControl:getMountAreaTeamNum(self.mountId,self.areaId)
self.teamCountText:setText(FMT.fmt('{0}/{1}',num,maxNum))
end

function UILingShanZhengDuoWin:setAreaInfoPanel()
self:clearAllTimer()
self.rzTimeList={}
self.maxNum=self.set_up_team_limit[self.areaId]or 0
local itemNum=math.ceil(self.maxNum/5)
local count=0
self.scrollView:setChildScrollViewDelayCreateGrids(itemNum,1,0.02,1,false,false,function(index,widget)
for i=1,5 do
local id=i-1
local _index=index*5+i
if _index<=self.maxNum then
widget:SetChildActive(id,true)
local item=widget:GetChildWidgetBase(id)
self:setTeamItem(item,_index)
else
widget:SetChildActive(id,false)
end
end
count=count+1
if count==itemNum then
if self.pos then
local id=math.ceil(self.pos/5)
self.pos=nil
self.scrollView:setChildScrollViewSelectItem(id-1,false,false,false)
end
end
end)
self:initArrowData(itemNum-1)
end

function UILingShanZhengDuoWin:setAreaInfoPanel2()
self:clearAllTimer()
self.rzTimeList={}
self.maxNum=self.set_up_team_limit[self.areaId]or 0
self.scrollView2:setChildScrollViewDelayCreateGrids(self.maxNum,2,0.02,6,false,false,function(index,widget)
local item=widget:GetChildWidgetBase(0)
local id=index+1
self:setTeamItem(item,id)
if self.pos and id==self.pos then
self.pos=nil
self.scrollView2:setChildScrollViewSelectItem(index,false,false,false)
end
end)
self.topBtn:setActive(false)
self.bottomBtn:setActive(false)
end

function UILingShanZhengDuoWin:setTeamItem(item,index)

local fvColor='#549327'
local pdata=UILSZDControl:getAreaPosDataById(self.mountId,self.areaId,index)
if pdata then
local func=function()
self:onChallenge(index)
end
local currtime=gameUtilityModel.getServerShortTime()
local dtime=currtime-pdata.set_up_sec
item:SetChildActive(_infoIndex.infoP,true)
item:SetChildActive(_infoIndex.infoM,false)
item:SetChildText(_infoIndex.xmNameP,pdata.guild_name)
item:SetChildText(_infoIndex.nameP,pdata.name)
local image=xianmengModel.splitGuildIcon(pdata.guildicon)
local abname=globalABLookup.xianmengicons
if image.icon>0 then
item:SetChildCSImageSprite(_infoIndex.xmIcon,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))
end
if image.bg>0 then
item:SetChildCSImageSprite(_infoIndex.xmIconBG,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))
end
if image.kuang>0 then
item:SetChildCSImageSprite(_infoIndex.xmIconK,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end
local fvalue=tonumber(tostring(pdata.fight))
local xmId=xianmengModel:getMyXMGuildID()
if xmId==pdata.guild_id then
item:SetChildActive(_infoIndex.challengeBtn,false)
item:SetChildActive(_infoIndex.protect,false)
local pId=playerModel:getActorID()
if pId==pdata.actor_id then
item:SetChildActive(_infoIndex.flag,true)
item:SetChildActive(_infoIndex.leaveBtn,true)
item:SetChildActive(_infoIndex.tipsMY,false)
item:SetChildButtonClick(_infoIndex.leaveBtn,function()
local content='撤离队伍将无法继续获得入驻奖励且结算累计获得的入驻奖励，请确认是否撤离队伍？'
self:showDialogue(content,function()
UILSZDControl:reqLeaveMount(pdata.mountId,pdata.area_id,pdata.pos)
UIManager.info('队伍已撤离')
end)
end)
else
item:SetChildActive(_infoIndex.flag,false)
item:SetChildActive(_infoIndex.leaveBtn,false)
item:SetChildActive(_infoIndex.tipsMY,true)
item:SetChildButtonClick(_infoIndex.tipsMY,function()
UIManager.info('盟友无法挑战')
end)
end
else
item:SetChildActive(_infoIndex.flag,false)
item:SetChildActive(_infoIndex.leaveBtn,false)
item:SetChildActive(_infoIndex.tipsMY,false)
if currtime>pdata.protect_end_sec then
item:SetChildActive(_infoIndex.challengeBtn,true)
item:SetChildActive(_infoIndex.protect,false)
item:SetChildButtonClick(_infoIndex.challengeBtn,func)
if self.fight_top5<=fvalue then
fvColor='#c82c2c'
end
else
item:SetChildActive(_infoIndex.challengeBtn,false)
item:SetChildActive(_infoIndex.protect,true)
local ltime=pdata.protect_end_sec-currtime
item:SetChildText(_infoIndex.protectCD,timeHelper.format_time_stamp11(ltime,true))
self:startTimer(index,item,pdata.protect_end_sec)
end
end
item:SetChildText(_infoIndex.fValue,FMT.fmt('<color={0}>{1}</color>',fvColor,mathHelper.formatNumber(fvalue)))
if self.areaId==3 then
item:SetChildActive(_infoIndex.headP,false)
item:SetChildActive(_infoIndex.playerImage,true)
local replace={[PLAYER_IMAGE_TYPE.eBodyOrnament]=1}
playerController:setImage(item,_infoIndex.playerImage,pdata.sex,pdata.iconInfo,playerController:supportDynamic(),0.35,replace)
else
item:SetChildActive(_infoIndex.headP,true)
item:SetChildActive(_infoIndex.playerImage,false)
playerController:setHeadIcon(item,_infoIndex.headP,{scale=0.75,iconInfo=pdata.iconInfo})
end
item:SetChildButtonClick(_infoIndex.click,func)
item:SetChildText(_infoIndex.time,timeHelper.format_time_stamp11(dtime,true))
self:addToTimeCount(pdata.pos,item,pdata.set_up_sec)
else
item:SetChildActive(_infoIndex.infoP,false)
item:SetChildActive(_infoIndex.infoM,true)
item:SetChildActive(_infoIndex.playerImage,false)
local mgData=self.monster_group[self.areaId][index]
local mgId=mgData[1]
local cfg=cfgHelper.get1(cfg_monstergroup_get,mgId)
item:SetChildCSImageSprite(_infoIndex.headMBG,globalABLookup.global,monTypeBg[cfg.monType])
comHelper.setChildModelRawImage_monsterGroup(item,mgId,_infoIndex.headM,0,eHeadCenterType.eHead)
item:SetChildText(_infoIndex.nameM,cfg.name)

item:SetChildActive(_infoIndex.challengeBtn,true)


local fvalue=cfg.fightVal or 0
if self.fight_top5<=fvalue then
fvColor='#c82c2c'
end
item:SetChildText(_infoIndex.fValue,FMT.fmt('<color={0}>{1}</color>',fvColor,mathHelper.formatNumber(fvalue)))
item:SetChildButtonClick(_infoIndex.challengeBtn,function()
self:onChallenge(index)
end)
end
end

function UILingShanZhengDuoWin:startTimer(index,item,etime)
local timerId
timerId=self:setTimer(1,0,function()
local currtime=gameUtilityModel.getServerShortTime()
local dtime=etime-currtime
if dtime>=0 then
item:SetChildText(_infoIndex.protectCD,timeHelper.format_time_stamp11(dtime,true))
else
self:stopTimerByID(timerId)
self.timers[index]=nil
self:setTeamItem(item,index)
end
end)
self.timers[index]=timerId
end

function UILingShanZhengDuoWin:clearAllTimer()
for k,v in pairs(self.timers)do
self:stopTimerByID(v)
end
self.timers={}
end

function UILingShanZhengDuoWin:addToTimeCount(id,item,stime)
self.rzTimeList[id]={item,stime}
end

function UILingShanZhengDuoWin:onChallenge(index)
local pdata=UILSZDControl:getAreaPosDataById(self.mountId,self.areaId,index)
if pdata then
UIManager:showWindow('UILingShanTeamInfoWin',{mountId=self.mountId,areaId=self.areaId,pos=index})
else
local mount_type=self.config.mount_type
local num=moneyModel.getMoney(self.countType[1])
if num>0 then
if UILSZDControl:checkTeamLimit(mount_type)then
self:handleFight(index)
else


UIManager.error('入驻灵山队伍已达上限')
end
else
UIManager.error('挑战次数不足')
end
end
end

function UILingShanZhengDuoWin:handleFight(index)
UILSZDControl:handleFight(self.mountId,self.areaId,index)
end

function UILingShanZhengDuoWin:initArrowData(num)
self.topBtn:setActive(false)
self.bottomBtn:setActive(false)
self.topIndex=0
self.bottomIndex=num
self.topValue=0
self.bottomValue=self.scrollItemHeight*num
self.topCheckValue=self.topValue+10
self.bottomCheckValue=self.bottomValue-10
self:refreshArrowBtn()
end

function UILingShanZhengDuoWin:refreshArrowBtn()
local cpos=self.contect:getChildAnchoredPosition3D()
local y=cpos.y
self.topBtn:setActive(y>self.topCheckValue)
self.bottomBtn:setActive(y<self.bottomCheckValue)
self.needUpdateArrow=false
end

function UILingShanZhengDuoWin:onScrollViewChange()
self.needUpdateArrow=true
end

function UILingShanZhengDuoWin:showDialogue(content,okcb)
local dialog=UIDialogManager.getConfirmDialog(nil,'提示',content,'确认','取消',okcb)
dialog:show()
end




function UILingShanZhengDuoWin:onTopBtn()
self.scrollView:setChildScrollViewSelectItem(self.topIndex,false,false,false)
end

function UILingShanZhengDuoWin:onBottomBtn()
self.scrollView:setChildScrollViewSelectItem(self.bottomIndex,false,false,true)
end

function UILingShanZhengDuoWin:onTeamBtn()
UIManager:showWindow('UIXM_ZZSH_noteWin',{page=3})
end

function UILingShanZhengDuoWin:onLogBtn()
zhengzhanshanhaiController:OpenZhengZhanShanHaiLingShanLog()
end

function UILingShanZhengDuoWin:onRewardBtn()
UIManager:showWindow('UILingShanRewardWin',self.mountId)
end

function UILingShanZhengDuoWin:onWanFaBtn()
local d={}
d.title='提示'
d.mode=3
d.name='LingShan_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UILingShanZhengDuoWin:onHelpBtn()
local d={}
d.title='提示'
d.mode=3
d.name=self.config.mount_type==1 and'LingShan_SuChen_help_%d'or'LingShan_HunYuan_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UILingShanZhengDuoWin:onCloseMPBtn()
self:onCloseClick()
end

function UILingShanZhengDuoWin:onCloseClick()
if self.areaId then
self.areaId=nil
self:refresh()
else
UILSZDControl:closeUI(nil,true)
end
end

function UILingShanZhengDuoWin:onBuyNumBtn()
local id=eMoneyType.mtLingShanBattleTimes1
local cfg=moneyModel.getMoneyConfig(id)
local moneyNum=moneyModel.getMoney(id)
local moneyMax=cfg.autoincr[5]
if moneyNum>=moneyMax then
UIManager.info("挑战次数储存已达上限，无法继续购买")
return
end
local single=cfg.buy[1]
local cost=cfg.buy[2]
local cnt=#cost
local buyCnt=moneyBuyModel:getCount(id)
local buyCntMax=moneyBuyModel:getMax(id)
local buyLeftCount=buyCntMax-buyCnt
local diffNum=moneyMax-moneyNum
local costItemID=cost[1][1][1]

if buyLeftCount>0 then
local getCostNum=function(num)
local costItemNum=0
for i=1,num do
local costIndex=buyCnt+i
costIndex=costIndex>cnt and cnt or costIndex
local n=cost[costIndex][1][2]
costItemNum=costItemNum+n
end
return costItemNum
end
local refresh=function(num)
local itemNum=getCostNum(num)
local have=itemsModel.getCount(costItemID)
local colorStr=have>=itemNum and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(costItemID)
local costStr=FMT.fmt("quad-icon={2}-quad<color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
local contentStr=FMT.fmt('是否花费{0}购买{1}次挑战次数',costStr,num*single)
return contentStr
end

local show_data={
type='UIDialougeNewBuyCount',
title='提示',
refreshcallback=refresh,

max=math.min(diffNum,buyLeftCount),
tips=FMT.fmt("（今日剩余次数：{0}）",buyLeftCount),
oktext='购买',
canceltext='取消',
okcallback=function(num)
local itemNum=getCostNum(num)
local func=function()
socketManager:send_254_44(id,num)
end
moneySystem:useMoney(costItemID,itemNum,func,WARNING_TYPE.eWarning)
end,
moneytypes={{costItemID},{eMoneyType.mtXianYu}},
}
if diffNum<buyLeftCount then
show_data.addMaxBtnCallback=function()
UIManager.error("购买次数已达储存上限")
end
end
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
UIManager.error("购买次数不足")
end
end