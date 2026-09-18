







def_class("UICaiShenJiaDaoRedPacketShareWin",UIWindowBase)









function UICaiShenJiaDaoRedPacketShareWin:bindComponents()

self.background=UIButton.get(self,0)
self.changeBtn=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.cover=UIImage.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.jumpBtn=UIButton.get(self,5)
self.lookBtn=UIButton.get(self,6)
self.model=UIObject.get(self,7)
self.openBtn=UIButton.get(self,8)
self.refreshCDTx=UIText.get(self,9)
self.refreshTips=UIText.get(self,10)
self.rewardBtn=UIButton.get(self,11)
self.rewardBtn2=UIButton.get(self,12)
self.shareBtn=UIButton.get(self,13)
self.speakBg=UIObject.get(self,14)
self.speakTx=UIText.get(self,15)
self.speakTx2=UIText.get(self,16)
self.spine=UIObject.get(self,17)
self.titleImg=UIImage.get(self,18)

self.background:setButtonClick(function()self:onBackground()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.lookBtn:setButtonClick(function()self:onLookBtn()end)

self.openBtn:setButtonClick(function()self:onOpenBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.rewardBtn2:setButtonClick(function()self:onRewardBtn2()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)



end


function UICaiShenJiaDaoRedPacketShareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cover);self.cover=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.lookBtn);self.lookBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.openBtn);self.openBtn=nil;
_UIObject_release(self.refreshCDTx);self.refreshCDTx=nil;
_UIObject_release(self.refreshTips);self.refreshTips=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardBtn2);self.rewardBtn2=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.speakBg);self.speakBg=nil;
_UIObject_release(self.speakTx);self.speakTx=nil;
_UIObject_release(self.speakTx2);self.speakTx2=nil;
_UIObject_release(self.spine);self.spine=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
end















local _this=nil
local _abName="ui/windows/activities/sub_caishenjiadao/caishenjiadao_atlas_pak.ab"



function UICaiShenJiaDaoRedPacketShareWin:onLoaded(...)
self:bindComponents()
_this=self
self.subType=SUB_ACTIVITY_TYPE.eCaiShenJiaDao
self:addNotify(notifyConfig.onCSJDPlayerDataChange,self.onCSJDPlayerDataChange)
self:addNotify(notifyConfig.onNewDay,self.onNewDay)
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
end


function UICaiShenJiaDaoRedPacketShareWin:__delete()
self:unbindComponents()
_this=nil
self:killSpeak()
self:stopCDTick()
end




function UICaiShenJiaDaoRedPacketShareWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.info=argtable.info
self.config=self.info:getSubActConfig()
self.freeCfg=self.config.hb_conf[self.info.freeHBIndex]
self.blessIdx=math.random(1,#self.freeCfg.blessing)
self:initView()
self.winlua:SetChildSpineAnimation(self.spine:getID(),eAnimationID.enter,1,nil)
self:doSpeak()
end


function UICaiShenJiaDaoRedPacketShareWin:onHide()

end



function UICaiShenJiaDaoRedPacketShareWin:onRewardBtn()
local args={
config=self.freeCfg,
parentWin=self,
}
self:showWindow("UICaiShenJiaDaoRedPacketRewardWin",args)
end

function UICaiShenJiaDaoRedPacketShareWin:onRewardBtn2()
self:onRewardBtn()
end

function UICaiShenJiaDaoRedPacketShareWin:onChangeBtn()
self.blessIdx=self.blessIdx+1
local max=#self.freeCfg.blessing
if self.blessIdx>max then
self.blessIdx=self.blessIdx-max
end
self:refreshCover()
end

function UICaiShenJiaDaoRedPacketShareWin:onBackground()

end

function UICaiShenJiaDaoRedPacketShareWin:onLookBtn()
local playerData=self.info:getPlayerData(self.info.freeHBIndex)
if playerData.buyCnt>=playerData.buyMax and playerData.share then

self.info:checkMySort()
local myList=self.info:getMyList()or{}
if myList and#myList>0 then
local args={
info=self.info,
key=myList[#myList],
parentWin=self,
}
self:showWindow("UICaiShenJiaDaoRedPacketDetailWin",args)
else
UIManager.error("没有找到对应红包数据")
end
end
end

function UICaiShenJiaDaoRedPacketShareWin:onShareBtn()
local playerData=self.info:getPlayerData(self.info.freeHBIndex)
if playerData.buyCnt>0 then
if not playerData.share then

if xianmengModel:hasXM()then
call_activitiesHandle_func("activitiesHandle_caishenjiadao","reqShareRedPacket",self.info.act_id,self.info.sub_act_id,self.info.freeHBIndex,self.blessIdx)
else
UIManager.error(cfgHelper.getlang("haveNotXianMengTips"))
end
end
end
end

function UICaiShenJiaDaoRedPacketShareWin:onOpenBtn()
local playerData=self.info:getPlayerData(self.info.freeHBIndex)

if playerData.buyCnt>=playerData.buyMax then
UIManager.error("红包次数已达上限")
return
end

if playerData.buyCnt<=0 or playerData.share then

if self.info:checkEntityTime()then
call_activitiesHandle_func("activitiesHandle_caishenjiadao","reqOpenFreeRedPacket",self.info.act_id,self.info.sub_act_id,self.info.freeHBIndex)
else
UIManager.error("已超领取时限")
end
else
UIManager.error("未分享上一个红包")
end
end

function UICaiShenJiaDaoRedPacketShareWin:onHelpBtn()
local d={}
d.title='规则'
d.mode=3
d.name='caishenjiadao_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UICaiShenJiaDaoRedPacketShareWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UICaiShenJiaDaoRedPacketShareWin:onJumpBtn()
if xianmengModel:hasXM()then
self:onCloseBtn()
UIManager:showWindow('UIChatWin',{channelId=CHAT_CHANNNEL.eXianmeng})
else
UIManager.info("财神驾到红包需要加入仙盟才能领取")
end
end

function UICaiShenJiaDaoRedPacketShareWin:initView()
local tipsStr=FMT.fmt("每天可派一次红包，凌晨{0}点刷新",self.config.flush_caishen)
self.refreshTips:setText(tipsStr)

local image=self.config.image
self.model:setChildUIModelShowTarget(image[1],image[3]or 1,image[2]or{},eAnimationID.stand,false,true,0)
self.model:setChildUIModelShowFlipX(true)
self:refreshCover()
self:refreshOpen()
self:refreshCDTick()
end

function UICaiShenJiaDaoRedPacketShareWin:doSpeak()
self.speakBg:setChildCanvasGroupAlpha(0)
self.speakBg:setScale(Vector3.zero)
self.speakTx:setText("")
self:killSpeak()

local r=math.random(1,#self.config.speakLib)
local speakStr=self.config.speakLib[r]
local obj=self.speakTx2:getGameObject()
local width=self.speakTx2:getChildSizeDeltaX()
speakStr=comHelper.getCheckLayoutStr(obj,width,speakStr,true)
self.speakTx:setText("")
self.speakTweener=Lua.SequenceProxy.New()

local speakTxCmp=self.speakTx:getGameObject():GetComponent("Text")
local tween0=Lua.DOTweenProxyExtensions.DOText(speakTxCmp,'',0)
tween0:SetEase(DG.Tweening.Ease.Linear)
local tween1=self.speakBg:setChildCanvasGroupDOFade(1,0.1)
local tween2=self.speakBg:setChildDOScale(1.2,0.2)
local tween3=self.speakBg:setChildDOScale(1,0.1)
local tween4=Lua.DOTweenProxyExtensions.DOText(speakTxCmp,speakStr,1)
local temp=Lua.SequenceProxy.New()
temp:Append(tween2)
temp:Append(tween3)
self.speakTweener:Append(tween0)
self.speakTweener:Append(temp)
self.speakTweener:Join(tween1)
self.speakTweener:Join(tween4)
end

function UICaiShenJiaDaoRedPacketShareWin:killSpeak()
if self.speakTweener and self.speakTweener:IsActive()then
self.speakTweener:Kill()
end
end

function UICaiShenJiaDaoRedPacketShareWin:refreshCDTick()
local nowTime=timeHelper.getServerShortTime()
if nowTime<self.info.hbLimitTime then
local todayZero=timeHelper.getTodayZeroStamp()
todayZero=timeHelper.convertShortStamp(todayZero)
local cdTime=todayZero+self.config.flush_caishen*3600
cdTime=cdTime>nowTime and cdTime or(cdTime+86400)
self.cdType=cdTime>self.info.hbLimitTime and 0 or 1
self.cdTime=math.min(cdTime,self.info.hbLimitTime)
if self:updateCDTick()then
self:startCDTick()
return
end
end
local cdStr=FMT.fmt("{0}已离开！",self.config.modelName)
self.refreshCDTx:setText(cdStr)
self:stopCDTick()
end

function UICaiShenJiaDaoRedPacketShareWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UICaiShenJiaDaoRedPacketShareWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UICaiShenJiaDaoRedPacketShareWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local contentStr=self.cdType==0 and"{0}将在{1}后重新降临！"or"{0}将在{1}后离开！"
local leastTime=math.max(self.cdTime-nowTime,0)
local cdStr=timeHelper.formatSimpleTime(leastTime)
cdStr=FMT.fmt(contentStr,self.config.modelName,cdStr)
self.refreshCDTx:setText(cdStr)
return nowTime<=self.cdTime
end

function UICaiShenJiaDaoRedPacketShareWin:refreshCover()
local blessCfg=self.freeCfg.blessing[self.blessIdx]
self.titleImg:setSprite(_abName,blessCfg[1])
self.cover:setSprite(_abName,blessCfg[3])
end

function UICaiShenJiaDaoRedPacketShareWin:refreshOpen()
local playerData=self.info:getPlayerData(self.info.freeHBIndex)
if playerData.buyCnt>0 then
if playerData.share then
if playerData.buyCnt>=playerData.buyMax then
self.openBtn:setActive(false)
self.shareBtn:setActive(false)
self.lookBtn:setActive(true)
self.changeBtn:setActive(false)
else
self.changeBtn:setActive(true)
self.openBtn:setActive(true)
self.shareBtn:setActive(false)
self.lookBtn:setActive(false)
end
else
self.changeBtn:setActive(true)
self.openBtn:setActive(false)
self.shareBtn:setActive(true)
self.lookBtn:setActive(false)
end
else
self.changeBtn:setActive(true)
self.openBtn:setActive(true)
self.shareBtn:setActive(false)
self.lookBtn:setActive(false)
end
end

function UICaiShenJiaDaoRedPacketShareWin.onCSJDPlayerDataChange(actId,subType,subId,hbId)
if _this.info:compare(actId,subType,subId)then
_this:refreshOpen()
_this:doSpeak()
end
end

function UICaiShenJiaDaoRedPacketShareWin.onNewDay()
if not _this.info:checkEntityTime()then
_this:onCloseBtn()
end
end

function UICaiShenJiaDaoRedPacketShareWin.onSubActivityStateChange(actId,subType,subId,state)
if _this.info:compare(actId,subType,subId)and state~=activitiesModel.activityDoingState then
_this:onCloseBtn()
end
end