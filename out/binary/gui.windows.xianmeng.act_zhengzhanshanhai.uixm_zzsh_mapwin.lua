







def_class("UIXM_ZZSH_MapWin",UIWindowBase)









function UIXM_ZZSH_MapWin:bindComponents()

self.blockMask=UIButton.get(self,0)
self.chatContent=UIObject.get(self,1)
self.chatCreater=UIGameobjectClone.new(self,2)
self.chatReddot=UIObject.get(self,3)
self.chatScrollView=UIObject.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.cloudRoot=UIObject.get(self,6)
self.fightModelBtn=UIButton.get(self,7)
self.float2Arrow=UIButton.get(self,8)
self.float2Obj=UIObject.get(self,9)
self.floatArrow=UIButton.get(self,10)
self.floatObj=UIObject.get(self,11)
self.floatRoot=UIObject.get(self,12)
self.frameBG=UIImage.get(self,13)
self.lindiGrid=UIObject.get(self,14)
self.mapContent=UIObject.get(self,15)
self.mapRoot=UIObject.get(self,16)
self.miniMapBtn=UIButton.get(self,17)
self.monsterGrid=UIObject.get(self,18)
self.moveBlock=UIObject.get(self,19)
self.numText=UIText.get(self,20)
self.overWidthMaskLayout=UIObject.get(self,21)
self.plotBlack=UIObject.get(self,22)
self.posBtn=UIButton.get(self,23)
self.posTxt=UIText.get(self,24)
self.raceIconImg=UIImage.get(self,25)
self.raceObj=UIButton.get(self,26)
self.rankEnter=UIObject.get(self,27)
self.ruleBtn=UIButton.get(self,28)
self.settingModel2Panel=UIObject.get(self,29)
self.settingModel2PanelRoot=UIObject.get(self,30)
self.teamGrid=UIObject.get(self,31)
self.testBtn=UIButton.get(self,32)
self.testReddot=UIObject.get(self,33)
self.uiroot=UIObject.get(self,34)
self.xianmengGrid=UIObject.get(self,35)
self.xmMoveEffect=UIObject.get(self,36)
self.xmMoveObj=UIObject.get(self,37)
self.zsGrid=UIObject.get(self,38)
self.seasonMsgBtn=UIButton.get(self,39)
self.shLvBtn=UIButton.get(self,40)
self.shLvText=UIText.get(self,41)
self.topReddot=UIObject.get(self,42)
self.seasonTimeBg=UIObject.get(self,43)
self.seasonTimeText=UIText.get(self,44)
self.zhanlingBtn=UIButton.get(self,45)
self.zhanlingReddot=UIObject.get(self,46)

self.blockMask:setButtonClick(function()self:onBlockMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.fightModelBtn:setButtonClick(function()self:onFightModelBtn()end)

self.float2Arrow:setButtonClick(function()self:onFloat2Arrow()end)

self.floatArrow:setButtonClick(function()self:onFloatArrow()end)

self.miniMapBtn:setButtonClick(function()self:onMiniMapBtn()end)

self.posBtn:setButtonClick(function()self:onPosBtn()end)

self.raceObj:setButtonClick(function()self:onRaceObj()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.testBtn:setButtonClick(function()self:onTestBtn()end)

self.seasonMsgBtn:setButtonClick(function()self:onSeasonMsgBtn()end)

self.shLvBtn:setButtonClick(function()self:onShLvBtn()end)

self.zhanlingBtn:setButtonClick(function()self:onZhanlingBtn()end)



end


function UIXM_ZZSH_MapWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blockMask);self.blockMask=nil;
_UIObject_release(self.chatContent);self.chatContent=nil;
self.chatCreater:deleteSelf();self.chatCreater=nil;
_UIObject_release(self.chatReddot);self.chatReddot=nil;
_UIObject_release(self.chatScrollView);self.chatScrollView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cloudRoot);self.cloudRoot=nil;
_UIObject_release(self.fightModelBtn);self.fightModelBtn=nil;
_UIObject_release(self.float2Arrow);self.float2Arrow=nil;
_UIObject_release(self.float2Obj);self.float2Obj=nil;
_UIObject_release(self.floatArrow);self.floatArrow=nil;
_UIObject_release(self.floatObj);self.floatObj=nil;
_UIObject_release(self.floatRoot);self.floatRoot=nil;
_UIObject_release(self.frameBG);self.frameBG=nil;
_UIObject_release(self.lindiGrid);self.lindiGrid=nil;
_UIObject_release(self.mapContent);self.mapContent=nil;
_UIObject_release(self.mapRoot);self.mapRoot=nil;
_UIObject_release(self.miniMapBtn);self.miniMapBtn=nil;
_UIObject_release(self.monsterGrid);self.monsterGrid=nil;
_UIObject_release(self.moveBlock);self.moveBlock=nil;
_UIObject_release(self.numText);self.numText=nil;
_UIObject_release(self.overWidthMaskLayout);self.overWidthMaskLayout=nil;
_UIObject_release(self.plotBlack);self.plotBlack=nil;
_UIObject_release(self.posBtn);self.posBtn=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.raceIconImg);self.raceIconImg=nil;
_UIObject_release(self.raceObj);self.raceObj=nil;
_UIObject_release(self.rankEnter);self.rankEnter=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.settingModel2Panel);self.settingModel2Panel=nil;
_UIObject_release(self.settingModel2PanelRoot);self.settingModel2PanelRoot=nil;
_UIObject_release(self.teamGrid);self.teamGrid=nil;
_UIObject_release(self.testBtn);self.testBtn=nil;
_UIObject_release(self.testReddot);self.testReddot=nil;
_UIObject_release(self.uiroot);self.uiroot=nil;
_UIObject_release(self.xianmengGrid);self.xianmengGrid=nil;
_UIObject_release(self.xmMoveEffect);self.xmMoveEffect=nil;
_UIObject_release(self.xmMoveObj);self.xmMoveObj=nil;
_UIObject_release(self.zsGrid);self.zsGrid=nil;
_UIObject_release(self.seasonMsgBtn);self.seasonMsgBtn=nil;
_UIObject_release(self.shLvBtn);self.shLvBtn=nil;
_UIObject_release(self.shLvText);self.shLvText=nil;
_UIObject_release(self.topReddot);self.topReddot=nil;
_UIObject_release(self.seasonTimeBg);self.seasonTimeBg=nil;
_UIObject_release(self.seasonTimeText);self.seasonTimeText=nil;
_UIObject_release(self.zhanlingBtn);self.zhanlingBtn=nil;
_UIObject_release(self.zhanlingReddot);self.zhanlingReddot=nil;
end
















local _this=nil
local mapMinScale=0.5
local mapMaxScale=1
local mapDefaultScale=1
local dragTimeOffset=0.2
local dragDistanceOffset=10
local mainWinType={
eEnterMainWin=1,
ePvPMainWin=2,
eIdeaMainWin=3,
ePvEMainWin=4,
eOffSeasonWin=5,
}
local mainWinLookup={
[mainWinType.eEnterMainWin]='UIXM_ZZSH_EnterMainWin',
[mainWinType.ePvPMainWin]='UIXM_ZZSH_PvPMainWin',
[mainWinType.eIdeaMainWin]='UIXM_ZZSH_IdleMainWin',
[mainWinType.ePvEMainWin]='UIXM_ZZSH_PvEMainWin',
[mainWinType.eOffSeasonWin]='UIXM_ZZSH_offSeasonWin',
}
local maskWins={
['UIXM_ZZSH_MapWin']=true,
['UIXM_ZZSH_PvEMainWin']=true,
['UIXM_ZZSH_EnterMainWin']=true,
['UIXM_ZZSH_PvPMainWin']=true,
['UIXM_ZZSH_IdleMainWin']=true,
['UIXM_ZZSH_signWin']=true,
['UIXM_ZZSH_offSeasonWin']=true,
}
local _showChannels={CHAT_CHANNNEL.eWorld,CHAT_CHANNNEL.eBattleField,CHAT_CHANNNEL.eSeasonZZSH,CHAT_CHANNNEL.eXianmeng,CHAT_CHANNNEL.eKuafu,CHAT_CHANNNEL.ePrivate}

function UIXM_ZZSH_MapWin:setOffset(time,dis)
dragTimeOffset=time
dragDistanceOffset=dis
end


function UIXM_ZZSH_MapWin:onLoaded(...)
_this=self
self:bindComponents()
local scale=zhengzhanshanhaiController:getZZSHCfg('mapScale')
mapMinScale=scale[1]
mapMaxScale=scale[2]
mapDefaultScale=scale[3]
self:addNotify(notifyConfig.onLimitActStateChange,self.onLimitActStateChange)
self:addNotify(notifyConfig.showUI,self.showUI)
self:addNotify(notifyConfig.closeUI,self.closeUI)
self:addNotify(notifyConfig.onZZSHMapDataInit,self.onZZSHMapDataInit)
self:addNotify(notifyConfig.onZZSHXMChange,self.onZZSHXMChange)
self:addNotify(notifyConfig.onZZSHLingDiChange,self.onZZSHLingDiChange)
self:addNotify(notifyConfig.onZZSHPvEQingBaoChange,self.onZZSHPvEQingBaoChange)
self:addNotify(notifyConfig.onZZSHPvETeamChange,self.onZZSHPvETeamChange)
self:addNotify(notifyConfig.onZZSHPvPTargetChange,self.onZZSHPvPTargetChange)
self:addNotify(notifyConfig.onZZSHOrderChange,self.onZZSHOrderChange)
self:addNotify(notifyConfig.onZZSHPvEWaiPaiChange,self.onZZSHPvEWaiPaiChange)
self:addNotify(notifyConfig.onRecvMessage,function(...)self:onRecvMessage(...)end)
self:addNotify(notifyConfig.onZZSHSeasonStateChange,self.onZZSHSeasonStateChange)
self:addReddotNotify(REDDIT_TYPE.eSHZhanLing,function(...)
self:refreshZhanlingBtnReddot(...)
end)
zhengzhanshanhaiModel:set_zzshModel(true)
self.winLookup={}
local m_cav=self:getChildCanvas(-1)
self.m_cav=m_cav
self.mView={}

self.is_enableDrag=true

local order=xianmengdigongModel:getEntityUIOrder(eZZSHEntityType.eLingDi)
if order then
self.lindiGrid:setChildCanvas(m_cav[1],m_cav[2]+order)
end
order=xianmengdigongModel:getEntityUIOrder(eZZSHEntityType.eMonster)
if order then
self.monsterGrid:setChildCanvas(m_cav[1],m_cav[2]+order)
end
order=xianmengdigongModel:getEntityUIOrder(eZZSHEntityType.ePvEXianMeng)
if order then
self.xianmengGrid:setChildCanvas(m_cav[1],m_cav[2]+order)
end
order=xianmengdigongModel:getEntityUIOrder(eZZSHEntityType.ePvETeam)
if order then
self.teamGrid:setChildCanvas(m_cav[1],m_cav[2]+order)
end



self.xmMoveObj:setChildCanvas(m_cav[1],m_cav[2]+25)
self.floatRoot:setChildCanvas(m_cav[1],m_cav[2]+26)
self.uiroot:setChildCanvas(m_cav[1],m_cav[2]+27)
self.overWidthMaskLayout:setChildCanvas(m_cav[1],m_cav[2]+28)
if deviceHelper.getAPILevel()>=12 then
self:initFloatSign()
local s_func=function(pos)
if _this==nil then return end
_this.lockClick=true
_this.lockClickTime=Time.realtimeSinceStartup
_this.lockClickPos=pos
_this:initFloatSignTimer()
end
local e_func=function(pos)
if _this==nil then return end
_this.lockClick=false
_this:refreshMapViewPos()
_this:clearFloatSignTimer()
_this:refreshFloatSign()
_this:refreshAOI()

if _this.clickEntity then
local lerpTime=Time.realtimeSinceStartup-_this.lockClickTime
local dis=mathHelper.distance(pos.x,pos.y,_this.lockClickPos.x,_this.lockClickPos.y)
if dis<dragDistanceOffset and lerpTime<dragTimeOffset then
local ent=zhengzhanshanhaiModel:getEntity(_this.clickEntity)
if ent then
ent:onClick()
end
end
_this.clickEntity=nil
end
if _this.curMoveXMClickPos then
local lerpTime=Time.realtimeSinceStartup-_this.lockClickTime
local dis=mathHelper.distance(pos.x,pos.y,_this.lockClickPos.x,_this.lockClickPos.y)
if dis<dragDistanceOffset and lerpTime<dragTimeOffset then
_this:onMoveMapClickUp(_this.curMoveXMClickPos)
end
_this.curMoveXMClickPos=nil
end
if _this.curSignRecordClickPos then
local lerpTime=Time.realtimeSinceStartup-_this.lockClickTime
local dis=mathHelper.distance(pos.x,pos.y,_this.lockClickPos.x,_this.lockClickPos.y)
if dis<dragDistanceOffset and lerpTime<dragTimeOffset then
_this:onMapClickUp(_this.curSignRecordClickPos)
end
_this.curSignRecordClickPos=nil
end
end
self.mapRoot:setChildDragStartAndEndEvent(s_func,e_func)
end
self.mapRoot:setChildZoomLimit(mapMaxScale,mapMinScale)
local onMapUp=function(num,clickPos)
if _this==nil then return end
_this:onMoveMapClickUp(clickPos)
end
self.moveBlock:setChildUITouchEvent(onMapUp,nil,nil)
local onMapUp2=function(num,clickPos)
if _this==nil then return end
_this:onMapClickUp(clickPos)
end
self.frameBG:setChildUITouchEvent(onMapUp2,nil,nil)

myxpcall(function()
if _this==nil then return end
_this:initChatInfo()
end)
end

function UIXM_ZZSH_MapWin:setClickEntity(ojbID)
self.clickEntity=ojbID
end

function UIXM_ZZSH_MapWin:checkLockClick()
return self.lockClick
end

function UIXM_ZZSH_MapWin:onReConnection()
self.chatCreater:recycleAll()
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eBattleField,self.handler)
end


function UIXM_ZZSH_MapWin:__delete()
self:stopRankSettlementTimer()
self:clearSeasonTimer()
self:clearSeasonSettlementTimer()
self:endAllReddotPunchRotation()
self:clearXMMoveObjEffect()
self:unregisterChatHandle()
self.chatCreater:setRefreshAction(nil)
self:unbindComponents()
zhengzhanshanhaiModel:set_zzshModel(nil)

zhengzhanshanhaiModel:removeAllEntitys()
if zhengzhanshanhaiModel:checkJoin()then

zhengzhanshanhaiController:checkAndCloseListen("UIXM_ZZSH_MapWin")
end

self:closeMainWin()
clear_zzshWidgetPool()
end


function UIXM_ZZSH_MapWin:onHide()
self:clearSeasonTimer()
self:clearSeasonSettlementTimer()
zhengzhanshanhaiModel:set_zzshModel(nil)
self:clearTimer()
self:closeMainWin()

self:enableDrag(false)

zhengzhanshanhaiModel:removeAllEntitys2()
if not zhengzhanshanhaiController:checkFigthReady()then
if zongmenModel:getMountainId()==mapIdType.fort then
else
buildlightController:setBLState(true)
end
end

end

function UIXM_ZZSH_MapWin:onLostConnection()
self:enableDrag(false)
end

function UIXM_ZZSH_MapWin.onLimitActStateChange(actID,state)
if actID~=LIMIT_ACT_TYPE.eZhengZhanShanHai then return end
if _this==nil or not _this.isVisible then return end

local callback=function()
if _this==nil or not _this.isVisible then return end
_this:changeMainWin()
end
UIManager:showWindow("UIFightPrepareLoading",{para=1,startCallback=callback})
end

function UIXM_ZZSH_MapWin:checkWinLookup()
for k,v in pairs(self.winLookup)do
if v then
return false
end
end
return true
end

function UIXM_ZZSH_MapWin.showUI(name)
if _this==nil or not _this.isVisible then return end
if maskWins[name]==nil then
_this.winLookup[name]=true
local flag_=false

if _this.is_enableDrag~=flag_ then
_this:enableDrag(flag_,true)
end
end
end

function UIXM_ZZSH_MapWin.closeUI(name)
if _this==nil then return end
_this.winLookup[name]=nil
if not _this.isVisible then return end
local flag=_this:checkWinLookup()

if flag then
_this:enableDrag(true)
end
end




function UIXM_ZZSH_MapWin:onShow(argtable,afterOnloaded)
zhengzhanshanhaiController.req_44_11()
zhengzhanshanhaiController:checkNeedReqSeasonData()
zhengzhanshanhaiController:setFigthReady(nil)

if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then
if zhengzhanshanhaiModel:checkJoin()then
zhengzhanshanhaiController:reqMapListen(1)
end
end
self.isFull=argtable.isFull
self.scaleFactor=UIManager.defaultCanvas_trans.localScale
zhengzhanshanhaiModel:set_zzshModel(true)
local myActorid=playerModel:getActorID()
self.isManager=xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSign)
self.nowShSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
self.seasonState=zhengzhanshanhaiModel:getSeasonState()
self:initMap()
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
self:updataAllEntities()
end)
end
local isChange=self:refreshTime()
if not afterOnloaded then
self.rectAOI=nil
if not isChange then
self:changeMainWin(true)
end
else

end
self:refreshFloatSign()
self:refreshMapViewPos()

self:setContentBottom()
self:freshChatReddot()
self:refreshMySettingModel()
buildlightController:setBLState(false)


if zhengzhanshanhaiModel:checkJoin()then
if self.m_winType==mainWinType.ePvEMainWin then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.begin_ZZSH_PVE)
end
end

local isShowSeasonPopup=false
local hasJump=self:checkHasJump(argtable)
if afterOnloaded and not newbieControl.isInNewbie()and not hasJump then
isShowSeasonPopup=self:checkSeasonPopup()
end


if zhengzhanshanhaiModel:checkJoin()then
zhengzhanshanhaiModel:getPVPWarBalanceData()
end

if not newbieControl.isInNewbie()and not isShowSeasonPopup then
self:handleJump(argtable)
end

self:refreshRankEnter()
self:refreshSeasonMsgBtn()
self:refreshShSeasonLvBtn()
self:refreshShSeasonTimeShow()
end

function UIXM_ZZSH_MapWin:onShowArgRecv(argtable)
self.nowShSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
self:handleJump(argtable)
self:changeMainWin()
self:refreshMySettingModel()
self:refreshRankEnter()
self:refreshSeasonMsgBtn()
self:refreshShSeasonLvBtn()
self:refreshShSeasonTimeShow()

end

function UIXM_ZZSH_MapWin:onSeasonDataInit(isActiveActivity)

if isActiveActivity or limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then
if zhengzhanshanhaiModel:checkJoin()then
zhengzhanshanhaiController:reqMapListen(1)
end
end
self.mapid=nil
zhengzhanshanhaiModel:set_zzshModel(true)
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local isChangeSeason=self.nowShSeasonId~=shSeasonId
self.nowShSeasonId=shSeasonId
self:initMap()

self:changeMainWin()
if isChangeSeason then
self:refreshFloatSign()
self:refreshMapViewPos()
end
self:refreshMySettingModel()

if not newbieControl.isInNewbie()then
self:checkSeasonPopup()
end
self:refreshRankEnter()
self:refreshSeasonMsgBtn()
self:refreshShSeasonLvBtn()
self:refreshShSeasonTimeShow()
end

function UIXM_ZZSH_MapWin:checkHasJump(argtable)
local extraParams=argtable.extraParams
if self.m_winType==mainWinType.ePvEMainWin then
if extraParams.jumpQB then
return true
end
if extraParams.jumpQB2 then
return true
end
if extraParams.jumpQBPage then
return true
end
end
if extraParams.log_jump then
return true
end






if extraParams.openSelectTeam then
if self.m_winType~=mainWinType.eEnterMainWin then
return true
end
end
if extraParams.ZZSHshopshow then

if self.m_winType~=mainWinType.eEnterMainWin then
local auto=zhengzhanshanhaiController:getZZSHCfg("auto")
local hasAutoCfg=auto~=nil
if hasAutoCfg then

return true
end
end
end
return false
end
function UIXM_ZZSH_MapWin:handleJump(argtable)

local extraParams=argtable.extraParams
local jumpPos=extraParams.jumpPos
if jumpPos~=nil then
self:move2GridPos(jumpPos[1],jumpPos[2],-1,false,0)
end
if self.m_winType==mainWinType.ePvEMainWin then
if extraParams.jumpQB then
zhengzhanshanhaiModel:checkQingBaoDetail(extraParams.jumpQB)
end
if extraParams.jumpQB2 then
zhengzhanshanhaiModel:checkQingBaoDetail_xm(extraParams.jumpQB2)
end
if extraParams.jumpQBPage then
if extraParams.jumpQBPage==1 then

UIManager:showWindow('UIXM_ZZSH_entitySelectWin',{page=1})
else

UIManager:showWindow('UIXM_ZZSH_entitySelectWin',{page=2})
end
end
end

if extraParams.jumpLSQBPage then
UILSZDControl:openIntelligenceWin(extraParams.mountType or 1)
end

if extraParams.log_jump then
if extraParams.log_jump==0 then

zhengzhanshanhaiController:OpenZhengZhanShanHaiMonsterLog(extraParams.is_jijie)
elseif extraParams.log_jump==1 then

zhengzhanshanhaiController:OpenZhengZhanShanHaiResourceLog()
elseif extraParams.log_jump==2 then

if self.jumpTimer~=nil then
self:stopTimerByID(self.jumpTimer)
end
self.jumpTimer=self:setTimer(0.3,1,function()
if UIManager:isActive("UIXM_ZZSH_MapWin")then
zhengzhanshanhaiController:OpenZhengZhanShanHaiFightLog(true)
end
end)
elseif extraParams.log_jump==3 then

local log_jump_args=extraParams.log_jump_args
if log_jump_args then
zhengzhanshanhaiModel:checkOpenPvPAttackDataWin(log_jump_args[1],log_jump_args[2])
end
elseif extraParams.log_jump==4 then
zhengzhanshanhaiController:OpenZhengZhanShanHaiLingShanLog()
end
end


if not extraParams.not_showlogtips then
local ret=zhengzhanshanhaiController:onProtocolReq_log()
if ret then
zhengzhanshanhaiModel:Set_tipsflag(true)
end
end
if extraParams.openSelectTeam then
if self.m_winType~=mainWinType.eEnterMainWin then
zhengzhanshanhaiModel:checkOpenSelectTeamWin(1,nil,true)
end
end
if extraParams.ZZSHshopshow then

if self.m_winType~=mainWinType.eEnterMainWin then
self:JudeLastTime()
end
end

end

function UIXM_ZZSH_MapWin:checkSeasonPopup()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()

local seasonState=zhengzhanshanhaiModel:getSeasonState()
if seasonState==1 then

if shSeasonId~=-1 then

local browsedSeasonId=zhengzhanshanhaiModel:loadUpdateMsgBrowsedSeasonId()
if shSeasonId>browsedSeasonId then
local seasonMsgGroupId
local firstShSeasonId=zhengzhanshanhaiModel:getFirstSHSeasonId()
if shSeasonId<=firstShSeasonId then

seasonMsgGroupId=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonId,"firstIntoSeasonMsgGroupId")
else
seasonMsgGroupId=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonId,"seasonMsgGroupId")
end
if seasonMsgGroupId then

local winArgs={groupId=seasonMsgGroupId}
zhengzhanshanhaiModel:saveUpdateMsgBrowsedSeasonId(shSeasonId)
self:showWindow("UICommonVisualGuideWin",winArgs)
return true
end
end
end

if zhengzhanshanhaiModel:checkJoin()then
local earlyTime=zhengzhanshanhaiController:getZZSHCfg("settlementTipsEarlyTime")
if not earlyTime and shSeasonId==-1 then
earlyTime=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,1,"settlementTipsEarlyTime")
end

if earlyTime then

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHSeasonSettlementTips)
if not flag then
local startTime,endTime,settleTime=zhengzhanshanhaiModel:getSeasonTime()
if settleTime then
local checkTime=settleTime-earlyTime
local nowTime=timeHelper.getServerLongTime()
if nowTime>=checkTime then

self:showWindow("UIXM_ZZSH_settlementTipsWin")
return true
end
end
end
end
end
else
if seasonState==0 or seasonState==2 or(seasonState==3 and shSeasonId==-1)then

if zhengzhanshanhaiModel:checkJoin()then

local isNeedShow=zhengzhanshanhaiModel:isBXReddotout()or zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()
if isNeedShow then
self:showWindow("UIXM_ZZSH_endTipsWin")
return true
end
end
end
end
return false
end

function UIXM_ZZSH_MapWin:checkSeasonStateChange()
local isChange=false
local seasonState=zhengzhanshanhaiModel:getSeasonState()
local seasonState_old=self.seasonState
self.seasonState=seasonState
if self.seasonState~=seasonState_old then
isChange=true
self:changeMainWin()
self:refreshRace()
self:refreshRankEnter()
self:refreshSeasonMsgBtn()
self:refreshShSeasonLvBtn()
self:refreshShSeasonTimeShow()
end
return isChange
end


function UIXM_ZZSH_MapWin:refreshTime()
local isChange=false
local raceState,left=zhengzhanshanhaiModel:getLunState()
local raceState_old=self.raceState
self.raceState=raceState
if self.raceState~=raceState_old then
isChange=true
self:changeMainWin()
self:refreshRace()
end
return isChange
end

function UIXM_ZZSH_MapWin:clearTimer()
if self.mytimer~=nil then
self:stopTimerByID(self.mytimer)
self.mytimer=nil
end
end


function UIXM_ZZSH_MapWin:enableDrag(flag,lockTime)
if self.is_enableDrag~=flag then
self.is_enableDrag=flag
self.mapRoot:setChildDragZoomEnable(flag)
end
if not flag and lockTime then
self.lockTime_blockMask=Time.realtimeSinceStartup+2
end
self.blockMask:setActive(not flag)

end

function UIXM_ZZSH_MapWin:getMapView()
local view=self.mView
if view then
local view_={}
view_.g_x=view.g_x
view_.g_y=view.g_y
view_.scale=view.scale
return view_
end
end

function UIXM_ZZSH_MapWin:setMapView(view)
self:move2GridPos(view.g_x,view.g_y,0,false,view.scale)
end


function UIXM_ZZSH_MapWin:jumpPos(posx,posy,anim,func)
local func2=function()
if _this==nil then return end
_this:refreshMapViewPos()
_this:refreshFloatSign(false)
_this:refreshAOI()
if func then
func()
end
end
local duration=anim or 0
self.mapRoot:subMoveToTargetPos(Vector3(posx,posy,0),duration,true,func2)
end







function UIXM_ZZSH_MapWin:move2GridPos(g_x,g_y,anim,isLocal,scaleType,func)
local old=self.is_enableDrag
local markOld
if not old then
markOld=1
self:enableDrag(true)
end

local mapScale=self.mapContent:getScale()
local view
local scale_
local ease_
if type(scaleType)=='number'then
local scale
if scaleType==1 then
scale_=Vector3(mapMaxScale,mapMaxScale,mapMaxScale)
scale=mapScale
mapScale=scale_
elseif scaleType==2 then
scale_=Vector3(mapMinScale,mapMinScale,mapMinScale)
scale=mapScale
mapScale=scale_
end
if scale then
view={g_x=g_x,g_y=g_y,scale=scale}
end
else
scale_=scaleType
mapScale=scale_
ease_=DG.Tweening.Ease.InQuart
end
local func2=function()
if _this==nil then return end
if func then
func(view)
end
end

local posx,posy
if not isLocal then
posx,posy=zhengzhanshanhaiModel:gridPos2localPos(g_x,g_y)
else
posx=g_x
posy=g_y
end

posx=posx*mapScale.x
posy=posy*mapScale.y



local scaleFactor=self.scaleFactor
local height=UnityEngine.Screen.height/scaleFactor.y
local width=UnityEngine.Screen.width/scaleFactor.x
local h_w=width/2
local h_h=height/2

local topLeftX=posx-h_w
local topLeftY=posy+h_h
local bottomRightX=posx+h_w
local bottomRightY=posy-h_h



local mapWidth=self.mapWidth*mapScale.x
local mapHeight=self.mapHeight*mapScale.x
local h_w_=mapWidth/2
local h_h_=mapHeight/2

local topLeftX_=-h_w_
local topLeftY_=h_h_
local bottomRightX_=h_w_
local bottomRightY_=-h_h_


if topLeftX<topLeftX_ then
posx=posx+(topLeftX_-topLeftX)
elseif bottomRightX>bottomRightX_ then
posx=posx-(bottomRightX-bottomRightX_)
end
if topLeftY>topLeftY_ then
posy=posy-(topLeftY-topLeftY_)
elseif bottomRightY<bottomRightY_ then
posy=posy+(bottomRightY_-bottomRightY)
end


posx=-posx
posy=-posy

anim=anim or 0
if anim==0 then
anim=0.6
end
local func3=function()
if _this==nil then return end
if markOld~=nil then
local flag=_this:checkWinLookup()
if not flag then
_this:enableDrag(false)
end
end
_this:refreshMapViewPos()
_this:clearFloatSignTimer()
_this:refreshFloatSign(false)
_this:refreshAOI()
end
if anim>0 then
self:delayDo(0.1,function()
func2()
end)
ease_=ease_ or DG.Tweening.Ease.OutExpo

if scale_ then
local tween1=self.mapContent:setChildDOScale(scale_.x,anim,nil)
tween1:SetEase(ease_)
end
local tween2=self.mapContent:setChildDOLocalMove(Vector3(posx,posy,0),anim,func3)
tween2:SetEase(ease_)
self:initFloatSignTimer()
else
if scale_ then
self.mapContent:setScale(scale_)
end
self.mapContent:setLocalPos(posx,posy,0)
func3()
func2()
end
end

function UIXM_ZZSH_MapWin:onBlockMask()
if self.lockTime_blockMask then
if Time.realtimeSinceStartup<self.lockTime_blockMask then
return
else
self.lockTime_blockMask=nil
end
end
self:enableDrag(true)
end



function UIXM_ZZSH_MapWin:initMap()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local bgAbName
local bgImageName
if shSeasonId==-1 then

bgAbName="ui/windows/xianmeng/act_zhengzhanshanhai/sharedtextures/shanhaimap.ab"
bgImageName="shanhaiMap"
else

local bgMapId=zhengzhanshanhaiController:getZZSHCfg("bgmapid")
local mapCfg=cfgHelper.get(cfg_zhengzhanshanhaimapnewconfig_get,bgMapId)
bgAbName=mapCfg.bgAbName
bgImageName=mapCfg.bgImageName
end
self.frameBG:setCSImageSprite(bgAbName,bgImageName)

local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
local mapid=baseCfg.id
if self.mapid==mapid then
return
end
self.mapid=mapid
local w=baseCfg.w*baseCfg.gw+baseCfg.bw*2
local h=baseCfg.h*baseCfg.gh+baseCfg.bh*2
self.mapWidth=w
self.mapHeight=h

self.frameBG:setChildSizeDelta(w,h)

self.mapContent:setChildSizeDelta(w,h)
self.mapContent:setScale(Vector3(mapDefaultScale,mapDefaultScale,mapDefaultScale))


local zsWidget=self.zsGrid:getWidgetBase()
for i,v in ipairs(baseCfg.zhuangshi)do
zhengzhanshanhaiModel:addEntity(eZZSHEntityType.eZhuanShi,v,zsWidget)
end


local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if g_x then
self:move2GridPos(g_x,g_y,-1,false,0)
end
end





function UIXM_ZZSH_MapWin:addLSEntity(v,widget,rectAOI)
if v:isAddEntity()then
return
end
if widget==nil then
widget=self.lindiGrid:getWidgetBase()
end
local d={mountId=v.mountId}
self:setEntityDataUISort(eZZSHEntityType.eLingShan,d)
local objID=zhengzhanshanhaiModel:addEntity(eZZSHEntityType.eLingShan,d,widget,rectAOI)
v:setObjID(objID)
end

function UIXM_ZZSH_MapWin:addLDEntity(v,widget,rectAOI)
if widget==nil then
widget=self.lindiGrid:getWidgetBase()
end
local d={cfgID=v.domainid}
self:setEntityDataUISort(eZZSHEntityType.eLingDi,d)
local objID=zhengzhanshanhaiModel:addEntity(eZZSHEntityType.eLingDi,d,widget,rectAOI)
v:setObjID(objID)
end

function UIXM_ZZSH_MapWin:addXMEntity(v,widget,rectAOI)
if widget==nil then
widget=self.xianmengGrid:getWidgetBase()
end
local d={guid=v.guildid}
self:setEntityDataUISort(eZZSHEntityType.ePvEXianMeng,d)
local objID=zhengzhanshanhaiModel:addEntity(eZZSHEntityType.ePvEXianMeng,d,widget,rectAOI)
v:setObjID(objID)
end

function UIXM_ZZSH_MapWin:addQBEntity(v,widget,rectAOI)
if widget==nil then
widget=self.monsterGrid:getWidgetBase()
end
local d={guid=v.guid}
local objID
if v.infotype==zhengzhanshanhaiModel.qbType.eMonster then
self:setEntityDataUISort(eZZSHEntityType.eMonster,d)
objID=zhengzhanshanhaiModel:addEntity(eZZSHEntityType.eMonster,d,widget,rectAOI)
else
self:setEntityDataUISort(eZZSHEntityType.eResource,d)
objID=zhengzhanshanhaiModel:addEntity(eZZSHEntityType.eResource,d,widget,rectAOI)
end
v:setObjID(objID)
end

function UIXM_ZZSH_MapWin:checkTeamEntity(v)
if not zhengzhanshanhaiModel:checkPvETeamBySetting(v)then
return false
end
if not v:valid(true)then return false end
local infotype=v:get_infotype()
local check=zhengzhanshanhaiModel:checkPvETeamShowEntity(infotype,v.sec)
return check
end

function UIXM_ZZSH_MapWin:addTeamEntity(v,widget,rectAOI)
if widget==nil then
widget=self.teamGrid:getWidgetBase()
end
local d={only_key=v.only_key}
self:setEntityDataUISort(eZZSHEntityType.ePvETeam,d)
local objID=zhengzhanshanhaiModel:addEntity(eZZSHEntityType.ePvETeam,d,widget,rectAOI)
v:setObjID(objID)
end

function UIXM_ZZSH_MapWin:addPvPLineEntity(v,widget,rectAOI)
if widget==nil then
widget=self.teamGrid:getWidgetBase()
end
local d={teamtype=v.teamtype}
self:setEntityDataUISort(eZZSHEntityType.ePvPLine,d)
local objID=zhengzhanshanhaiModel:addEntity(eZZSHEntityType.ePvPLine,d,widget,rectAOI)
v:setObjID(objID)
end

function UIXM_ZZSH_MapWin:checkPvPTeamEntity(v)
if not zhengzhanshanhaiModel:checkPvPTeamBySetting(v)then
return false
end
if not v:valid()then return false end
local check=zhengzhanshanhaiModel:checkPvPTeamShowEntity(v)
return check
end

function UIXM_ZZSH_MapWin:addPvPTeamEntity(v,widget,rectAOI)
if widget==nil then
widget=self.teamGrid:getWidgetBase()
end
local d={targetid_str=v.targetid_str,attackidx=v.idx}
self:setEntityDataUISort(eZZSHEntityType.ePvPTeam,d)
local objID=zhengzhanshanhaiModel:addEntity(eZZSHEntityType.ePvPTeam,d,widget,rectAOI)
v:setObjID(objID)
end

function UIXM_ZZSH_MapWin:createMapEntity()
if self.m_winType==mainWinType.ePvEMainWin then

local ldlp=zhengzhanshanhaiModel:getAllLDLookup()
if ldlp then
local lindiWidget=self.lindiGrid:getWidgetBase()
for k,v in pairs(ldlp)do
self:addLDEntity(v,lindiWidget)
end
end

if UILSZDControl:isLingShanOpen(true)then
local lsdatas=UILSZDControl:getDatas()
if lsdatas then
local lindiWidget=self.lindiGrid:getWidgetBase()
for k,v in pairs(lsdatas)do
self:addLSEntity(v,lindiWidget)
end
end
end

local xmlp=zhengzhanshanhaiModel:getAllXMLookup(true)
if xmlp then
local xmWidget=self.xianmengGrid:getWidgetBase()
for k,v in pairs(xmlp)do
self:addXMEntity(v,xmWidget)
end
end

local baseCfg=zhengzhanshanhaiModel:get_mapBaseCfg()
local lindiWidget=self.lindiGrid:getWidgetBase()
local poslist=baseCfg.libs[4]
if poslist then
for i,v in ipairs(poslist)do
local radius=zhengzhanshanhaiModel:getPosDontMoveRadius(v[1],v[2])
if radius then
local d={v[1],v[2],radius}
self:setEntityDataUISort(eZZSHEntityType.eMonsterPos,d)
zhengzhanshanhaiModel:addEntity(eZZSHEntityType.eMonsterPos,d,lindiWidget)
end
end
end

local qblp=zhengzhanshanhaiModel:getAllQingBaoLookup(true)
if qblp then
local monsterWidget=self.monsterGrid:getWidgetBase()
for k,v in pairs(qblp)do
self:addQBEntity(v,monsterWidget)
end
end
elseif self.m_winType==mainWinType.ePvPMainWin and not zhengzhanshanhaiModel.maskPvP then

local ldlp=zhengzhanshanhaiModel:getAllLDLookup()
if ldlp then
local lindiWidget=self.lindiGrid:getWidgetBase()
for k,v in pairs(ldlp)do
self:addLDEntity(v,lindiWidget)
end
end

if UILSZDControl:isLingShanOpen(true)then
local lsdatas=UILSZDControl:getDatas()
if lsdatas then
local lindiWidget=self.lindiGrid:getWidgetBase()
for k,v in pairs(lsdatas)do
self:addLSEntity(v,lindiWidget)
end
end
end

local xmlp=zhengzhanshanhaiModel:getAllXMLookup(true)
if xmlp then
local xmWidget=self.xianmengGrid:getWidgetBase()
for k,v in pairs(xmlp)do
self:addXMEntity(v,xmWidget)
end
end
if self.raceState==eZZSH_State.ePVPStandby then

local orderslp=zhengzhanshanhaiModel:getAllPvPOrder(true)
if orderslp then
local teamWidget=self.teamGrid:getWidgetBase()
for k,v in pairs(orderslp)do
if v:valid(true)then
self:addPvPLineEntity(v,teamWidget)
end
end
end
end
end
end

function UIXM_ZZSH_MapWin:createTeamEntity()
if self.m_winType==mainWinType.ePvEMainWin then

local teamslp=zhengzhanshanhaiModel:getAllPvETeams(true)
if teamslp then
local teamWidget=self.teamGrid:getWidgetBase()
for k,v in pairs(teamslp)do
if self:checkTeamEntity(v)then
self:addTeamEntity(v,teamWidget)
end
end
end
elseif self.m_winType==mainWinType.ePvPMainWin and not zhengzhanshanhaiModel.maskPvP then
if self.raceState==eZZSH_State.ePVPFight then

local pvpTargets=zhengzhanshanhaiModel:getpvpTargetsLookup()
if pvpTargets then
local teamWidget=self.teamGrid:getWidgetBase()
for k,targetData in pairs(pvpTargets)do
if targetData.len>0 then
for k2,v in ipairs(targetData.teams2)do
if self:checkPvPTeamEntity(v)then
self:addPvPTeamEntity(v,teamWidget)
end
end
end
end
end
end
end
end

function UIXM_ZZSH_MapWin:refreshTeamEntity()
if self.m_winType==mainWinType.ePvEMainWin then

local teamslp=zhengzhanshanhaiModel:getAllPvETeams(true)
if teamslp then
local teamWidget=self.teamGrid:getWidgetBase()
for k,teamData in pairs(teamslp)do
if zhengzhanshanhaiModel:getEntity(teamData.ojbID)then
if not self:checkTeamEntity(teamData)then
zhengzhanshanhaiModel:delEntityNow(teamData.ojbID)
end
else
if self:checkTeamEntity(teamData)then
self:addTeamEntity(teamData,teamWidget,self.rectAOI)
end
end
end
end
elseif self.m_winType==mainWinType.ePvPMainWin and not zhengzhanshanhaiModel.maskPvP then
if self.raceState==eZZSH_State.ePVPFight then

local pvpTargets=zhengzhanshanhaiModel:getpvpTargetsLookup()
if pvpTargets then
local teamWidget=self.teamGrid:getWidgetBase()
for k,targetData in pairs(pvpTargets)do
if targetData.len>0 then
for k2,teamData in ipairs(targetData.teams2)do
if zhengzhanshanhaiModel:getEntity(teamData.ojbID)then
if not self:checkPvPTeamEntity(teamData)then
zhengzhanshanhaiModel:delEntityNow(teamData.ojbID)
end
else
if self:checkPvPTeamEntity(teamData)then
self:addPvPTeamEntity(teamData,teamWidget,self.rectAOI)
end
end
end
end
end
end
end
end
end

function UIXM_ZZSH_MapWin:setEntityDataUISort(entityType,d)
d.sortLayer=self.m_cav[1]
d.sortOrder=self.m_cav[2]+20
local sortOrder=xianmengdigongModel:getEntityUIOrder(entityType)
d.sortOrder2=self.m_cav[2]+sortOrder
d.sortOrder3=self.m_cav[2]
end


function UIXM_ZZSH_MapWin:refreshAOI(needRefresh)
local scale=self.mapContent:getScale()
local pos=self.mapContent:getChildLocalPosition()


local x=(0-pos.x)/scale.x
local y=(0-pos.y)/scale.y


local scaleFactor=self.scaleFactor
local height=UnityEngine.Screen.height/(scaleFactor.y*scale.y)
local width=UnityEngine.Screen.width/(scaleFactor.x*scale.x)
local x1=x-width/2-100
local y1=y-height/2-100
local x2=x+width/2+100
local y2=y+height/2+100
local mapScale=scale.x
local rectAOI=self.rectAOI
if needRefresh or rectAOI==nil or not mathHelper.rectInRect(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],x1,y1,x2,y2)then
self:updateNearlyAOI(scale,pos)
local rectAOI_old
if rectAOI~=nil then
rectAOI_old=self.rectAOI_old
if rectAOI_old~=nil then
rectAOI_old[1]=rectAOI[1]
rectAOI_old[2]=rectAOI[2]
rectAOI_old[3]=rectAOI[3]
rectAOI_old[4]=rectAOI[4]
rectAOI_old[5]=rectAOI[5]
else
rectAOI_old={rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],rectAOI[5]}
self.rectAOI_old=rectAOI_old
end
rectAOI[1]=x1
rectAOI[2]=y1
rectAOI[3]=x2
rectAOI[4]=y2
rectAOI[5]=mapScale
else
rectAOI={x1,y1,x2,y2,mapScale}
self.rectAOI=rectAOI
end
zhengzhanshanhaiModel:refreshAOI(x1,y1,x2,y2,mapScale,rectAOI_old)
else
if mapScale~=rectAOI[5]then
rectAOI[5]=mapScale
zhengzhanshanhaiModel:refreshAOIScale(rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4],mapScale)
end
end
end

function UIXM_ZZSH_MapWin:updateNearlyAOI(scale,pos)


local x=(0-pos.x)/scale.x
local y=(0-pos.y)/scale.y


local scaleFactor=self.scaleFactor
local height=UnityEngine.Screen.height/(scaleFactor.y*mapMinScale)
local width=UnityEngine.Screen.width/(scaleFactor.x*mapMinScale)
local x1=x-width/2-100
local y1=y-height/2-100
local x2=x+width/2+100
local y2=y+height/2+100
local rectAOI=self.rectAOI_nearly
if rectAOI then
rectAOI[1]=x1
rectAOI[2]=y1
rectAOI[3]=x2
rectAOI[4]=y2
else
rectAOI={x1,y1,x2,y2}
self.rectAOI_nearly=rectAOI
end
end

function UIXM_ZZSH_MapWin:getNearlyAOI()
return self.rectAOI_nearly
end

function UIXM_ZZSH_MapWin:updataAllEntities()
zhengzhanshanhaiModel:updataAllEntities()
end





function UIXM_ZZSH_MapWin:initFloatSign()
self.floatTopRightBorad_h=250
self.floatTopRightBorad_w=180
self.floatRectScale=0.15
self.float2RectScale=0.01
end

function UIXM_ZZSH_MapWin:initFloatSignTimer()
if self.refreshFloatSignTimer==nil then
self.refreshFloatSignTimer=self:setTimer(0.2,0,function()
self:refreshFloatSign()
self:refreshAOI()
end)
self:refreshFloatSign(true)
end
end

function UIXM_ZZSH_MapWin:clearFloatSignTimer()
if self.refreshFloatSignTimer~=nil then
self:stopTimerByID(self.refreshFloatSignTimer)
self.refreshFloatSignTimer=nil
end
end

function UIXM_ZZSH_MapWin:hideFloatSign()
if deviceHelper.getAPILevel()<12 then return end
self.floatObj:setActive(false)
self.float2Obj:setActive(false)
end

function UIXM_ZZSH_MapWin:refreshFloatSign(anim)
if deviceHelper.getAPILevel()<12 then return end
local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
local check=g_x~=nil
local pos1,pos2,pos3,posTL,posBR,scale,pos,height,width,h_w,h_h
if check then
local l_x,l_y=zhengzhanshanhaiModel:gridPos2localPos(g_x,g_y)
pos2={x=l_x,y=l_y}
end

if check then
scale=self.mapContent:getScale()
pos=self.mapContent:getChildLocalPosition()

local x1=(0-pos.x)/scale.x
local y1=(0-pos.y)/scale.y

pos1={x1,y1}

local scaleFactor=self.scaleFactor
height=UnityEngine.Screen.height/(scaleFactor.y*scale.y)
width=UnityEngine.Screen.width/(scaleFactor.x*scale.x)
h_w=width/2
h_h=height/2

local topLeftX=x1-h_w
local topLeftY=y1+h_h
local bottomRightX=x1+h_w
local bottomRightY=y1-h_h
posTL={topLeftX,topLeftY}
posBR={bottomRightX,bottomRightY}

if pos2.x<topLeftX or pos2.x>bottomRightX
or pos2.y>topLeftY or pos2.y<bottomRightY then
local x2=pos2.x
local y2=pos2.y
local lerpX=x2-x1
local lerpY=y2-y1
local plist={}
if lerpX==0 then


if x2>=topLeftX and x2<=bottomRightX then
table.insert(plist,{x2,topLeftY})
table.insert(plist,{x2,bottomRightY})
end
elseif lerpY==0 then


if y2>=topLeftY and y2<=bottomRightY then
table.insert(plist,{topLeftX,y2})
table.insert(plist,{bottomRightX,y2})
end
else

local k=lerpY/lerpX
local b=y2-k*x2

table.insert(plist,{(topLeftY-b)/k,topLeftY})
table.insert(plist,{(bottomRightY-b)/k,bottomRightY})

table.insert(plist,{topLeftX,k*topLeftX+b})
table.insert(plist,{bottomRightX,k*bottomRightX+b})
end

local d=nil
if#plist>0 then
for i,v in ipairs(plist)do
if v[1]>=topLeftX and v[1]<=bottomRightX and v[2]<=topLeftY and v[2]>=bottomRightY then
if pos3==nil then
pos3=v
d=mathHelper.distance(v[1],v[2],x2,y2)
else
local d2=mathHelper.distance(v[1],v[2],x2,y2)
if d2<d then
pos3=v
d=d2
end
end
end
end
end
end
check=pos3~=nil
end
self.floatObj:setActive(check)
if check then

local pos3_l={pos3[1]-pos1[1],pos3[2]-pos1[2]}


local scaleFactor=self.scaleFactor
local height_=UnityEngine.Screen.height/scaleFactor.y
local width_=UnityEngine.Screen.width/scaleFactor.x
local h_w_=width_/2
local h_h_=height_/2
local dx=h_w_-self.floatTopRightBorad_w-h_w_*self.floatRectScale
local dy=h_h_-self.floatTopRightBorad_h-h_h_*self.floatRectScale

local pos3_l_={pos3_l[1]*self.floatRectScale,pos3_l[2]*self.floatRectScale}

local pos3_={pos3_l_[1]+pos1[1],pos3_l_[2]+pos1[2]}

local pos4={pos3_[1]*scale.x+pos.x,pos3_[2]*scale.y+pos.y}


pos4[1]=pos4[1]+dx
pos4[2]=pos4[2]+dy
if anim==nil or anim==true then
self.floatObj:setChildDOAnchorPos(Vector2.New(pos4[1],pos4[2]),0.2)
else
self.floatObj:setLocalPos(pos4[1],pos4[2],0)
end

local v={0,-1}
local v2={pos2.x-pos3_[1],pos2.y-pos3_[2]}


local dot_v=v[1]*v2[1]+v[2]*v2[2]
local l_A=1
local l_B=math.sqrt(v2[1]*v2[1]+v2[2]*v2[2])
local angle=math.acos(dot_v/(l_A*l_B))
local angle_deg=math.deg(angle)

if pos3_[1]<=pos2.x then
self.floatArrow:setRotation(0,0,angle_deg)
else
self.floatArrow:setRotation(0,0,-angle_deg)
end
end

self:refreshFloat2Sign(anim)
end

function UIXM_ZZSH_MapWin:onFloatArrow()
local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if g_x then
self:hideFloatSign()
self:move2GridPos(g_x,g_y,0,false,0)
end
end

function UIXM_ZZSH_MapWin:getMyXMData()
local ldData=zhengzhanshanhaiModel:getMyLDData()
if ldData then
if self:isPvPWin(2)then
local cfgID=ldData.domainid
local targetid_str=tostring(-cfgID)
local targetData=zhengzhanshanhaiModel:getpvpTargetData(targetid_str)
if targetData then
local winner=targetData:findWinner()
if winner and xianmengModel:isMyXM(winner)then
return ldData.x,ldData.y
end
end
else
return ldData.x,ldData.y
end
end
end

function UIXM_ZZSH_MapWin:refreshFloat2Sign(anim)
if deviceHelper.getAPILevel()<12 then return end
local g_x,g_y=self:getMyXMData()
local check=g_x~=nil
local pos1,pos2,pos3,posTL,posBR,scale,pos,height,width,h_w,h_h
if check then
local l_x,l_y=zhengzhanshanhaiModel:gridPos2localPos(g_x,g_y)
pos2={x=l_x,y=l_y}
end

if check then
scale=self.mapContent:getScale()
pos=self.mapContent:getChildLocalPosition()

local x1=(0-pos.x)/scale.x
local y1=(0-pos.y)/scale.y

pos1={x1,y1}

local scaleFactor=self.scaleFactor
height=UnityEngine.Screen.height/(scaleFactor.y*scale.y)
width=UnityEngine.Screen.width/(scaleFactor.x*scale.x)
h_w=width/2
h_h=height/2

local topLeftX=x1-h_w
local topLeftY=y1+h_h
local bottomRightX=x1+h_w
local bottomRightY=y1-h_h
posTL={topLeftX,topLeftY}
posBR={bottomRightX,bottomRightY}

if pos2.x<topLeftX or pos2.x>bottomRightX
or pos2.y>topLeftY or pos2.y<bottomRightY then
local x2=pos2.x
local y2=pos2.y
local lerpX=x2-x1
local lerpY=y2-y1
local plist={}
if lerpX==0 then


if x2>=topLeftX and x2<=bottomRightX then
table.insert(plist,{x2,topLeftY})
table.insert(plist,{x2,bottomRightY})
end
elseif lerpY==0 then


if y2>=topLeftY and y2<=bottomRightY then
table.insert(plist,{topLeftX,y2})
table.insert(plist,{bottomRightX,y2})
end
else

local k=lerpY/lerpX
local b=y2-k*x2

table.insert(plist,{(topLeftY-b)/k,topLeftY})
table.insert(plist,{(bottomRightY-b)/k,bottomRightY})

table.insert(plist,{topLeftX,k*topLeftX+b})
table.insert(plist,{bottomRightX,k*bottomRightX+b})
end

local d=nil
if#plist>0 then
for i,v in ipairs(plist)do
if v[1]>=topLeftX and v[1]<=bottomRightX and v[2]<=topLeftY and v[2]>=bottomRightY then
if pos3==nil then
pos3=v
d=mathHelper.distance(v[1],v[2],x2,y2)
else
local d2=mathHelper.distance(v[1],v[2],x2,y2)
if d2<d then
pos3=v
d=d2
end
end
end
end
end
end
check=pos3~=nil
end
self.float2Obj:setActive(check)
if check then

local pos3_l={pos3[1]-pos1[1],pos3[2]-pos1[2]}


local scaleFactor=self.scaleFactor
local height_=UnityEngine.Screen.height/scaleFactor.y
local width_=UnityEngine.Screen.width/scaleFactor.x
local h_w_=width_/2
local h_h_=height_/2
local dx=h_w_-self.floatTopRightBorad_w-h_w_*self.floatRectScale
local dy=h_h_-self.floatTopRightBorad_h-h_h_*self.floatRectScale

local pos3_l_={pos3_l[1]*self.float2RectScale,pos3_l[2]*self.float2RectScale}

local pos3_={pos3_l_[1]+pos1[1],pos3_l_[2]+pos1[2]}

local pos4={pos3_[1]*scale.x+pos.x,pos3_[2]*scale.y+pos.y}


pos4[1]=pos4[1]+dx
pos4[2]=pos4[2]+dy
if anim==nil or anim==true then
self.float2Obj:setChildDOAnchorPos(Vector2.New(pos4[1],pos4[2]),0.2)
else
self.float2Obj:setLocalPos(pos4[1],pos4[2],0)
end

local v={0,-1}
local v2={pos2.x-pos3_[1],pos2.y-pos3_[2]}


local dot_v=v[1]*v2[1]+v[2]*v2[2]
local l_A=1
local l_B=math.sqrt(v2[1]*v2[1]+v2[2]*v2[2])
local angle=math.acos(dot_v/(l_A*l_B))
local angle_deg=math.deg(angle)

if pos3_[1]<=pos2.x then
self.float2Arrow:setRotation(0,0,angle_deg)
else
self.float2Arrow:setRotation(0,0,-angle_deg)
end
end
end

function UIXM_ZZSH_MapWin:onFloat2Arrow()
local g_x,g_y=self:getMyXMData()
if g_x then
self:hideFloatSign()
self:move2GridPos(g_x,g_y,0,false,0)
end
end






function UIXM_ZZSH_MapWin:activeSignModel(flag,pageModel)
if flag then
self.raceObj:setActive(false)
self:activeMainWin(false)
self.moveBlock:setActive(pageModel==2)
if pageModel==2 then

self:onFloatArrow()
end
UIManager:showWindow('UIXM_ZZSH_signWin',{pageModel=pageModel})
else
local inMove=self:checkInMoveModel()
UIManager:closeWindow('UIXM_ZZSH_signWin')
self.raceObj:setActive(true)
self.moveBlock:setActive(false)
self.xmMoveObj:setChildCanvasGroupAlpha(0)
self.curMoveXMPos=nil
self:clearXMMoveObjEffect()
self:activeMainWin(true)
if inMove then
zhengzhanshanhaiModel:invokeFunc3('refreshCircleSign')
end
end
self.settingModel2PanelRoot:setChildCanvasGroupAlpha(not flag and 1 or 0)
self.settingModel2PanelRoot:setChildCanvasGroupRaycast(not flag)
end

function UIXM_ZZSH_MapWin:checkInSignModel()
return UIManager:isActive('UIXM_ZZSH_signWin')
end

function UIXM_ZZSH_MapWin:checkInSignRecordModel()
return UIManager:invokeUIMethod('UIXM_ZZSH_signWin','checkInRecordModel')
end

function UIXM_ZZSH_MapWin:checkInMoveModel()
return UIManager:invokeUIMethod('UIXM_ZZSH_signWin','checkInMoveModel')
end

function UIXM_ZZSH_MapWin:checkInMoveModel2()
return UIManager:invokeUIMethod('UIXM_ZZSH_signWin','checkInMoveModel')and self:isPvPWin()and self.curMoveXMPos==nil
end

function UIXM_ZZSH_MapWin:quitMiniMapModel(g_x,g_y,isLocal)

self:enableDrag(true)
self:move2GridPos(g_x,g_y,-1,isLocal,0)
end

function UIXM_ZZSH_MapWin:onPosBtn()
self:showWindow('UIXM_ZZSH_jumpPosWin')
end

function UIXM_ZZSH_MapWin:onMiniMapBtn()



self:openWorldMap()
end

function UIXM_ZZSH_MapWin:openWorldMap()
local scale=self.mapContent:getScale()
local pos=self.mapContent:getChildLocalPosition()

local x=math.floor((0-pos.x)/scale.x)
local y=math.floor((0-pos.y)/scale.y)

UIManager:showWindow('UIXM_ZZSH_worldWin',{startPos={x,y}})


end


function UIXM_ZZSH_MapWin:refreshMapViewPos()
local scale=self.mapContent:getScale()
local pos=self.mapContent:getChildLocalPosition()

local x=math.floor((0-pos.x)/scale.x)
local y=math.floor((0-pos.y)/scale.y)

local g_x,g_y=zhengzhanshanhaiModel:localPos2gridPos(x,y)
local pos_str=FMT.fmt('X：<color=#ebe0ce>{0}</color>  Y：<color=#ebe0ce>{1}</color>',g_x,g_y)
self.posTxt:setText(pos_str)
self.mView.g_x=g_x
self.mView.g_y=g_y
self.mView.scale=scale
end

function UIXM_ZZSH_MapWin:clickPos2UILocalPos(clickPos)
local scale=self.mapContent:getScale()
local pos=self.mapContent:getChildLocalPosition()

local scaleFactor=self.scaleFactor
local h_h=UnityEngine.Screen.height/2
local h_w=UnityEngine.Screen.width/2

local clickPos_x=clickPos.x-h_w
local clickPos_y=clickPos.y-h_h

local ui_x=clickPos_x/scaleFactor.x
local ui_y=clickPos_y/scaleFactor.y

local local_x=math.floor((ui_x-pos.x)/scale.x)
local local_y=math.floor((ui_y-pos.y)/scale.y)
return local_x,local_y
end

function UIXM_ZZSH_MapWin:uiLocalPos2UIPos(local_x,local_y)
local scale=self.mapContent:getScale()
local pos=self.mapContent:getChildLocalPosition()
local ui_x=local_x*scale.x+pos.x
local ui_y=local_y*scale.y+pos.y
return ui_x,ui_y
end

function UIXM_ZZSH_MapWin:onMoveMapClickUp(clickPos)
if self:checkInMoveModel()then
if self.lockClick then
self.curMoveXMClickPos=clickPos
return
end
local local_x,local_y=self:clickPos2UILocalPos(clickPos)

local g_x,g_y=zhengzhanshanhaiModel:localPos2gridPos(local_x,local_y)

if not zhengzhanshanhaiModel:checkGridPosInMap(g_x,g_y)or
zhengzhanshanhaiModel:checkPosDontMove(g_x,g_y)then
UIManager.error('该坐标无法设置仙盟驻地')
return
end
local rectAOI=self.rectAOI
if rectAOI==nil or not mathHelper.posInRect(local_x,local_y,rectAOI[1],rectAOI[2],rectAOI[3],rectAOI[4])then
UIManager.error('该坐标不在视野内')
return
end
local flag,entityType=zhengzhanshanhaiModel:checkGridPosInInRadius(g_x,g_y,rectAOI)
if flag then
if entityType==eZZSHEntityType.eLingDi then
UIManager.error('仙盟堡垒无法进入领地范围里')
else
UIManager.error('该坐标无法设置仙盟驻地')
end
return
end

local xmWidget=self.xmMoveObj:getWidgetBase()
if self.curMoveXMPos==nil then
self.xmMoveObj:setChildCanvasGroupAlpha(0.5)
local entSet=zhengzhanshanhaiController:getZZSHCfg('xmEntitySet')
local size=entSet[1]
if self.moveXMSpine==nil then
self.moveXMSpine=1
xmWidget:SetChildCSImageSprite(0,globalABLookup.zzshentityicons,'xm_1')
end
xmWidget:SetChildScale(0,Vector3(size,size,size))
if self:isPvPWin()then
if self.moveXMCircle==nil then
self.moveXMCircle=1

local size_=zhengzhanshanhaiModel:getAttackRadius()*zhengzhanshanhaiModel.grid2CircleEffect
xmWidget:SetChildShowEffectEx(2,10532,self.m_cav[1],self.m_cav[2]+24,true)
xmWidget:SetChildScale(2,Vector3(size_,size_,size_))
end
end
end
self.curMoveXMPos={g_x,g_y}
self.xmMoveObj:setLocalPos(local_x,local_y,0)

local g_x_o,g_y_o=zhengzhanshanhaiModel:getMyXMGridPos()
local l_x_o,l_y_o=zhengzhanshanhaiModel:gridPos2localPos(g_x_o,g_y_o)
local dis=mathHelper.distance(local_x,local_y,l_x_o,l_y_o)
xmWidget:SetChildSizeDelta(1,dis,11)

local v={1.0,0}
local v2={l_x_o-local_x,l_y_o-local_y}


local dot_v=v[1]*v2[1]+v[2]*v2[2]
local l_A=1.0
local l_B=math.sqrt(v2[1]*v2[1]+v2[2]*v2[2])
local angle=math.acos(dot_v/(l_A*l_B))
local angle_deg=math.deg(angle)

if local_y<=l_y_o then
xmWidget:SetChildRotation(1,0,0,angle_deg)
else
xmWidget:SetChildRotation(1,0,0,-angle_deg)
end
local dis_=mathHelper.distance(g_x_o,g_y_o,g_x,g_y)
dis_=math.ceil(dis_)
UIManager:invokeUIMethod('UIXM_ZZSH_signWin','refreshMoveCost',dis_)
else
self.moveBlock:setActive(false)
self.xmMoveObj:setChildCanvasGroupAlpha(0)
self.curMoveXMPos=nil
self:clearXMMoveObjEffect()
end
end

function UIXM_ZZSH_MapWin:clearXMMoveObjEffect()
if self.moveXMCircle then
self.moveXMCircle=nil
local xmWidget=self.xmMoveObj:getWidgetBase()
xmWidget:SetChildShowEffect(2,0,false)
end
end

function UIXM_ZZSH_MapWin:getMoveXMPos()
return self.curMoveXMPos
end

function UIXM_ZZSH_MapWin:onMapClickUp(clickPos)
if self:checkInSignRecordModel()then
if self.lockClick then
self.curSignRecordClickPos=clickPos
return
end
local local_x,local_y=self:clickPos2UILocalPos(clickPos)

local g_x,g_y=zhengzhanshanhaiModel:localPos2gridPos(local_x,local_y)
local data={x=g_x,y=g_y}
UIManager:showWindow('UIXM_ZZSH_posInfoWin',data)
end
end


function UIXM_ZZSH_MapWin:rec_movePos()
self.xmMoveObj:setChildCanvasGroupAlpha(0)
self.curMoveXMPos=nil
self:clearXMMoveObjEffect()

















end





function UIXM_ZZSH_MapWin:isPvEWin()
return self.m_winType==mainWinType.ePvEMainWin
end

function UIXM_ZZSH_MapWin:isPvPWin(typo)
if typo==1 then
return self.m_winType==mainWinType.ePvPMainWin and self.raceState==eZZSH_State.ePVPStandby
elseif typo==2 then
return self.m_winType==mainWinType.ePvPMainWin and self.raceState==eZZSH_State.ePVPFight
else
return self.m_winType==mainWinType.ePvPMainWin
end
end

function UIXM_ZZSH_MapWin:isPlayingWin()
return self.m_winType==mainWinType.ePvEMainWin or self.m_winType==mainWinType.ePvPMainWin
end

function UIXM_ZZSH_MapWin:changeMainWin(isInit)
local winType
if zhengzhanshanhaiController:isInActivityReset()then

return
end

if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then
local seasonState=zhengzhanshanhaiModel:getSeasonState()
if seasonState==1 then
if zhengzhanshanhaiModel:checkJoin()then

if self.raceState==eZZSH_State.ePVPStandby then
winType=mainWinType.ePvPMainWin
elseif self.raceState==eZZSH_State.ePVPFight then
winType=mainWinType.ePvPMainWin
elseif self.raceState==eZZSH_State.ePVEFight then
winType=mainWinType.ePvEMainWin
elseif self.raceState==eZZSH_State.eIdle then
winType=mainWinType.eIdeaMainWin
end
else
winType=mainWinType.eEnterMainWin
end
else
winType=mainWinType.eOffSeasonWin
end
else
winType=mainWinType.eIdeaMainWin
end
local lastWinType=self.m_winType
if isInit or self.m_winType~=winType then
local winName
if self.m_winType then
winName=mainWinLookup[self.m_winType]
if winName then
self:closeWindow(winName)

zhengzhanshanhaiModel:removeAllEntitys2()
end
end
self.m_winType=winType
if winType then
winName=mainWinLookup[winType]
if winName then
self:showWindow(winName)
end
end

self:createMapEntity()
self:createTeamEntity()
self:refreshAOI(true)
end
local showCloud=true
if self.m_winType==mainWinType.ePvEMainWin then
showCloud=false
elseif self.m_winType==mainWinType.ePvPMainWin and not zhengzhanshanhaiModel.maskPvP then
showCloud=false
end

self:activeMapCloud(showCloud)
self:refreshFightModelBtn()
self:refershZhanLing()
self:refreshZhanlingBtnReddot()
end

function UIXM_ZZSH_MapWin:activeMainWin(flag)
if self.m_winType then
local winName=mainWinLookup[self.m_winType]
if winName then
if flag then
self:showWindow(winName)
else
self:hideWindow(winName)
end
end
end
end

function UIXM_ZZSH_MapWin:closeMainWin()
if self.m_winType then
local winName=mainWinLookup[self.m_winType]
if winName then
self:closeWindow(winName)
end
self.m_winType=nil
end
end

function UIXM_ZZSH_MapWin:activeMapCloud(flag)
self.raceObj:setActive(not flag)
self.miniMapBtn:setActive(not flag)
if flag then
if self.cloudID==nil then
self.cloudID=5278
self.cloudRoot:setChildUIModelShowTarget(self.cloudID,1,{},eAnimationID.stand,false,false,0,nil)
end
else
if self.cloudID~=nil then
self.cloudRoot:setChildUIModelRemoveTarget()
self.cloudID=nil
end
end
end

function UIXM_ZZSH_MapWin:onCloseBtn()
if self:checkInSignModel()then
self:activeSignModel(false)
return
end
self:closeWin()
end

function UIXM_ZZSH_MapWin:closeWin()
if self.isFull then
UIFullCommonControl:closeUI()
else
self:closeSelf()
end
end

function UIXM_ZZSH_MapWin:closeElseWin()
if UIManager:isActive('UIXM_ZZSH_monsterInfoWin')then
UIManager:closeWindow('UIXM_ZZSH_monsterInfoWin')
end
if UIManager:isActive('UIXM_ZZSH_resourceInfoWin')then
UIManager:closeWindow('UIXM_ZZSH_resourceInfoWin')
end
if UIManager:isActive('UIXM_ZZSH_selfPVETeamWin')then
UIManager:closeWindow('UIXM_ZZSH_selfPVETeamWin')
end
if UIManager:isActive('UIXM_ZZSH_monsterAllMyTeamWin')then
UIManager:closeWindow('UIXM_ZZSH_monsterAllMyTeamWin')
end
if UIManager:isActive('UIXM_ZZSH_entitySelectWin')then
UIManager:closeWindow('UIXM_ZZSH_entitySelectWin')
end
if UIManager:isActive('UIXM_ZZSH_worldWin')then
UIManager:closeWindow('UIXM_ZZSH_worldWin')
end
if UIManager:isActive('UIXM_ZZSH_signWin')then
UIManager:closeWindow('UIXM_ZZSH_signWin')
end
end





function UIXM_ZZSH_MapWin:refreshRace()
local icon
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then
local raceIndex=zhengzhanshanhaiModel:getRaceIndex()
icon=cfgHelper.get2(cfg_zhengzhanshanhaisessionconfig_get,raceIndex,'mapicon')
else

icon=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonId,"seasonIconid")
end

self.raceIconImg:setSprite(globalABLookup.zzshtitleicons,FMT.fmt('image_shanhaishijiebt_{0}',icon))

local browsedSeasonId=zhengzhanshanhaiModel:loadServerListBrowsedSeasonId()
local isShowReddot=shSeasonId>browsedSeasonId
self.topReddot:setActive(isShowReddot)
end

function UIXM_ZZSH_MapWin:onRaceObj()
UIManager:showWindow("UIXM_ZZSH_XMRankListWin")
end


function UIXM_ZZSH_MapWin:onRaceObjBtn()
UIManager:showWindow("UIXM_ZZSH_XMRankListWin")
end





function UIXM_ZZSH_MapWin:onRuleBtn()
local ruleGroupID
if self.m_winType==mainWinType.ePvPMainWin then
ruleGroupID=ruleTipsImageGroup.eZhengZhanShanHai2
else
ruleGroupID=ruleTipsImageGroup.eZhengZhanShanHai
end
local args={
ruleGroupID=ruleGroupID,
}
UIManager:showWindow("UIRuleTipsImage2Win",args)
end





function UIXM_ZZSH_MapWin:onTestBtn()
UIManager:showWindow("UITestTagBtnWin",{systemId=1,})
end

function UIXM_ZZSH_MapWin:refreshTestWin()
local checkReddot
local systemIndexType=UISettingModel:getSystemIndexType()
local checkBtn=UISettingModel:checkIsOpenTest(systemIndexType.ShanHai)
if checkBtn then
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1
checkBtn=showModel==1
end
if not checkBtn then
UIManager:invokeUIMethod("UITestTagBtnWin",'closeWin')
else
checkReddot=UISettingModel:checkTestTagReddot(systemIndexType.ShanHai)
self.winlua:SetChildActive(self.testReddot:getID(),checkReddot)
end

self.winlua:SetChildActive(self.testBtn:getID(),checkBtn)
end





function UIXM_ZZSH_MapWin:onFightModelBtn()
UIManager:showWindow('UIXM_ZZSH_fightModelWin')
end

function UIXM_ZZSH_MapWin:refreshFightModelBtn()
local showBtn=self.isManager and self.m_winType~=mainWinType.ePvPMainWin and self.m_winType~=mainWinType.eEnterMainWin and self.m_winType~=mainWinType.eOffSeasonWin
showBtn=showBtn and not zhengzhanshanhaiModel.maskPvP
self.fightModelBtn:setActive(showBtn)
if showBtn then
local widget=self.fightModelBtn:getWidgetBase()
local flag=zhengzhanshanhaiModel:checkJoinFightFlag()
local icon=flag and'button_shsjcanyu_1'or'button_shsjcanyu_2'
widget:SetChildCSImageSprite(0,globalABLookup.zzshicons,icon)
local name=flag and'参与争夺'or'放弃争夺'
widget:SetChildText(1,name)
end
end





function UIXM_ZZSH_MapWin:refreshMySettingModel()
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1
self.settingModel2Panel:setActive(showModel==1)

self:refreshTestWin()
end

function UIXM_ZZSH_MapWin:refreshSettingModel()

self:refreshMySettingModel()

if self.m_winType then
local winName=mainWinLookup[self.m_winType]
if winName then
UIManager:invokeUIMethod(winName,'refreshSettingModel')
end
end
end






function UIXM_ZZSH_MapWin:showShake(shakeLevel,num)
local baseshake=0.01
if shakeLevel>0 then
self.shakeScale=1+baseshake*shakeLevel
self.shakeNum=num or 3
self.mapRoot:setScale(Vector3(1,1,1))
self:doShake()
end
end

function UIXM_ZZSH_MapWin:doShake()
if self.shakeNum<=0 then
self.mapRoot:setScale(Vector3(1,1,1))
return
end
self.shakeNum=self.shakeNum-1
if self.shakeTween~=nil then
self.shakeTween:Kill()
self.shakeTween=nil
end
self.shakeTween=self.mapRoot:setChildDOScale(self.shakeScale,0.05,function()
if _this==nil then return end
_this.shakeTween=nil
_this:doShake2()
end)
end

function UIXM_ZZSH_MapWin:doShake2()
if self.shakeTween~=nil then
self.shakeTween:Kill()
self.shakeTween=nil
end
self.shakeTween=self.mapRoot:setChildDOScale(1,0.05,function()
if _this==nil then return end
_this.shakeTween=nil
_this:doShake()
end)
end






function UIXM_ZZSH_MapWin:onCreateXianMeng2()


self:changeMainWin()





local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if g_x then
_this:move2GridPos(g_x,g_y,0,false,0)
else
_this:refreshFloatSign()
end




end



function UIXM_ZZSH_MapWin:onCreateXianMeng()
local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if g_x==nil then
self:refreshFloatSign()
return
end


self.lindiGrid:setActive(false)
self.monsterGrid:setActive(false)
self.xianmengGrid:setChildCanvasGroupAlpha(0)
self.teamGrid:setChildCanvasGroupAlpha(0)
self.uiroot:setChildCanvasGroupAlpha(0)
self.floatRoot:setActive(false)
self:activeMainWin(false)

self.plotBlack:setActive(true)
local plotWidget=self.plotBlack:getWidgetBase()

plotWidget:SetChildAnchoredPosition(0,Vector2.New(0,48))
plotWidget:SetChildDOAnchorPosY(0,0,0.35)

plotWidget:SetChildAnchoredPosition(1,Vector2.New(0,-48))
plotWidget:SetChildDOAnchorPosY(1,0,0.35)

self:move2GridPos(g_x,g_y,0,false,0)

local delay=0.6

self:delayDo(delay,function()
self:showShake(1,8)
end)

delay=delay+1
self:delayDo(delay,function()
local xmWidget=self.xmMoveObj:getWidgetBase()
self.xmMoveObj:setChildCanvasGroupAlpha(1)
if self.moveXMSpine==nil then
self.moveXMSpine=1
local entSet=zhengzhanshanhaiController:getZZSHCfg('xmEntitySet')
local mapScale
if self.rectAOI then
local min=zhengzhanshanhaiModel:get_entityAutoScaleMin()
mapScale=self.rectAOI[5]
mapScale=math.max(min,mapScale)/mapScale
else
mapScale=1
end
local size=entSet[1]*mapScale
xmWidget:SetChildCSImageSprite(0,globalABLookup.zzshentityicons,'xm_1')
xmWidget:SetChildScale(0,Vector3(size,size,size))
end
local local_x,local_y=zhengzhanshanhaiModel:gridPos2localPos(g_x,g_y)
self.xmMoveObj:setLocalPos(local_x,local_y,0)


end)

delay=delay+1.5
self:delayDo(delay,function()

plotWidget:SetChildDOAnchorPosY(0,48,0.35)

plotWidget:SetChildDOAnchorPosY(1,-48,0.35,function()
if _this==nil then return end
_this.plotBlack:setActive(false)
end)
end)


delay=delay+0.35
self:delayDo(delay,function()
self.xmMoveObj:setChildCanvasGroupAlpha(0)
self:clearXMMoveObjEffect()

self.lindiGrid:setActive(true)
self.monsterGrid:setActive(true)
self.xianmengGrid:setChildCanvasGroupAlpha(1)
self.teamGrid:setChildCanvasGroupAlpha(1)
self.uiroot:setChildCanvasGroupAlpha(1)
self.floatRoot:setActive(true)
self:activeMainWin(true)

self:changeMainWin()
end)
end





function UIXM_ZZSH_MapWin.onZZSHMapDataInit()
if _this==nil or not _this.isVisible then return end
if _this.m_winType==mainWinType.ePvEMainWin or _this.m_winType==mainWinType.ePvPMainWin then
if not zhengzhanshanhaiController:checkEnterMark()then

_this:createMapEntity()
_this:refreshAOI(true)


local g_x,g_y=zhengzhanshanhaiModel:getMyXMGridPos()
if g_x then
_this:move2GridPos(g_x,g_y,-1,false,0)
else
_this:refreshFloatSign()
end
end
end
end

function UIXM_ZZSH_MapWin.onZZSHXMChange(opType,xmData)
if _this==nil or not _this.isVisible then return end
if _this.m_winType==mainWinType.ePvEMainWin or _this.m_winType==mainWinType.ePvPMainWin then
if opType==zhengzhanshanhaiModel.opType.eAdd then
_this:addXMEntity(xmData,nil,_this.rectAOI)
elseif opType==zhengzhanshanhaiModel.opType.eRefresh then
local ent=zhengzhanshanhaiModel:getEntity(xmData.ojbID)
if ent~=nil then
zhengzhanshanhaiModel:refreshEnity(ent,_this.rectAOI)
if xmData:checkMyXM()then
_this:refreshFightModelBtn()
end
else
_this:addXMEntity(xmData,nil,_this.rectAOI)
end
if _this.raceState==eZZSH_State.ePVPStandby then
if xianmengModel:isMyXM(xmData.guildid)then
local orderslp=zhengzhanshanhaiModel:getAllPvPOrder(true)
if orderslp then
for k,orderData in pairs(orderslp)do
if zhengzhanshanhaiModel:getEntity(orderData.ojbID)then
zhengzhanshanhaiModel:invokeFunc(orderData.ojbID,'refreshLine')
end
end
end
else
local orderData=zhengzhanshanhaiModel:checkHasOrder2(xmData.guildid,nil)
if orderData then
if zhengzhanshanhaiModel:getEntity(orderData.ojbID)then
zhengzhanshanhaiModel:invokeFunc(orderData.ojbID,'refreshLine')
end
end
end
end
elseif opType==zhengzhanshanhaiModel.opType.eDel then
zhengzhanshanhaiModel:delEntityNow(xmData.ojbID)
end
end
end

function UIXM_ZZSH_MapWin.onZZSHLingDiChange(opType,ldData)
if _this==nil or not _this.isVisible then return end
if _this.m_winType==mainWinType.ePvEMainWin or _this.m_winType==mainWinType.ePvPMainWin then
if opType==zhengzhanshanhaiModel.opType.eRefresh then
if zhengzhanshanhaiModel:getEntity(ldData.ojbID)then
zhengzhanshanhaiModel:invokeFunc(ldData.ojbID,'changeXM')
else
_this:addLDEntity(ldData,nil,_this.rectAOI)
end
end
end
end

function UIXM_ZZSH_MapWin.onZZSHPvEQingBaoChange(opType,qbData)
if _this==nil or not _this.isVisible then return end
if _this.m_winType==mainWinType.ePvEMainWin then
if opType==zhengzhanshanhaiModel.opType.eDel then

if not zhengzhanshanhaiModel:invokeFunc(qbData.ojbID,'checkInFight')then
zhengzhanshanhaiModel:delEntityNow(qbData.ojbID)
end
elseif opType==zhengzhanshanhaiModel.opType.eAdd then
_this:addQBEntity(qbData,nil,_this.rectAOI)
elseif opType==zhengzhanshanhaiModel.opType.eRefresh then

end
end
end

function UIXM_ZZSH_MapWin.onZZSHPvETeamChange(opType,teamData)
if _this==nil or not _this.isVisible then return end
if _this.m_winType==mainWinType.ePvEMainWin then
if opType==zhengzhanshanhaiModel.opType.eInit then

_this:createTeamEntity()
_this:refreshAOI(true)
elseif opType==zhengzhanshanhaiModel.opType.eDel then
local qbData=zhengzhanshanhaiModel:getQingBaoData(teamData.guid)
if qbData~=nil and qbData.ojbID and zhengzhanshanhaiModel:checkPvETeamInFight(teamData)then

zhengzhanshanhaiModel:invokeFunc(qbData.ojbID,'activeFightEffect')
else
zhengzhanshanhaiModel:delEntityNow(teamData.ojbID)
end
elseif opType==zhengzhanshanhaiModel.opType.eAdd then
if _this:checkTeamEntity(teamData)then
_this:addTeamEntity(teamData,nil,_this.rectAOI)
end
elseif opType==zhengzhanshanhaiModel.opType.eRefresh then
if _this:checkTeamEntity(teamData)then
if zhengzhanshanhaiModel:getEntity(teamData.ojbID)then

else
_this:addTeamEntity(teamData,nil,_this.rectAOI)
end
else
zhengzhanshanhaiModel:delEntityNow(teamData.ojbID)
end
end
end
end

function UIXM_ZZSH_MapWin.onZZSHPvPTargetChange(opType,targetData,old_idx,new_idx)
if _this==nil or not _this.isVisible then return end
if _this.m_winType==mainWinType.ePvPMainWin then
if opType==zhengzhanshanhaiModel.opType.eInit then

if _this.m_winType==mainWinType.ePvPMainWin then
_this:createTeamEntity()
_this:refreshAOI(true)
end
elseif opType==zhengzhanshanhaiModel.opType.eAdd then
if targetData.len>0 then
for k2,teamData in ipairs(targetData.teams2)do
if _this:checkPvPTeamEntity(teamData)then
_this:addPvPTeamEntity(teamData,nil,_this.rectAOI)
end
end
end
elseif opType==zhengzhanshanhaiModel.opType.eRefresh then
if targetData.len>0 then
for i=old_idx,new_idx do
local teamData=targetData.teams2[i]
if teamData then
if _this:checkPvPTeamEntity(teamData)then
if zhengzhanshanhaiModel:getEntity(teamData.ojbID)then

else
_this:addPvPTeamEntity(teamData,nil,_this.rectAOI)
end
else
zhengzhanshanhaiModel:delEntityNow(teamData.ojbID)
end
end
end
end
end
end
end

function UIXM_ZZSH_MapWin.onZZSHOrderChange(opType,orderData)
if _this==nil or not _this.isVisible then return end
if _this.m_winType==mainWinType.ePvPMainWin then
if _this.raceState~=eZZSH_State.ePVPStandby then return end
if opType==zhengzhanshanhaiModel.opType.eDel then
zhengzhanshanhaiModel:delEntityNow(orderData.ojbID)
elseif opType==zhengzhanshanhaiModel.opType.eAdd then
if orderData:valid(true)then
_this:addPvPLineEntity(orderData,nil,_this.rectAOI)
end
elseif opType==zhengzhanshanhaiModel.opType.eRefresh then
if zhengzhanshanhaiModel:getEntity(orderData.ojbID)then
if not orderData:valid(true)then
zhengzhanshanhaiModel:delEntityNow(orderData.ojbID)
else

zhengzhanshanhaiModel:invokeFunc(orderData.ojbID,'refreshLine')
end
else
if orderData:valid(true)then
_this:addPvPLineEntity(orderData,nil,_this.rectAOI)
end
end
end
end
end

function UIXM_ZZSH_MapWin.onZZSHPvEWaiPaiChange(opType,qbGuid)
if _this==nil or not _this.isVisible then return end
if _this.m_winType==mainWinType.ePvEMainWin then

local qbData=zhengzhanshanhaiModel:getQingBaoData(qbGuid)
if qbData then
zhengzhanshanhaiModel:invokeFunc(qbData.ojbID,'refreshCollectSign')
end
end
end

function UIXM_ZZSH_MapWin:rec_leaveXM()
UIManager.info('你已离开仙盟，请重新加入仙盟')
self:closeElseWin()
self:changeMainWin()
end

function UIXM_ZZSH_MapWin.onZZSHSeasonStateChange(isChangeSeason)
if _this==nil or not _this.isVisible then return end
if not isChangeSeason then
_this:checkSeasonStateChange()
else
zhengzhanshanhaiController.req_44_11()
end
end




function UIXM_ZZSH_MapWin:initChatInfo()

self.handler=chatMessageMainHandler.create(self.chatCreater,self.chatContent:getID(),self)
self:registerChatHandle()
self.chatCreater:setRefreshAction(function(...)self:onFinishChatCreatAction(...)end)
self.viewHeight=self.winlua:GetChildSizeDeltaY(self.chatScrollView:getID())
self.viewWidth=self.winlua:GetChildSizeDeltaX(self.chatScrollView:getID())
chatControl.freshMainMesgPanel(MAIN_HOLD_TYPE.eBattleField,self.handler)
end

function UIXM_ZZSH_MapWin:unregisterChatHandle()
if self.isHandle then
self.isHandle=false
chatControl.unregisterMainHandler(MAIN_HOLD_TYPE.eBattleField,self.handler)
end
end

function UIXM_ZZSH_MapWin:registerChatHandle()
if not self.isHandle then
self.isHandle=true
chatControl.registerMainHandler(MAIN_HOLD_TYPE.eBattleField,self.handler)
end
end

function UIXM_ZZSH_MapWin:releaseObject(luaid)
self.chatCreater:recycleItemById(luaid)
end

function UIXM_ZZSH_MapWin:onFinishChatCreatAction(assetName,guid,luaid,isInit)
if not isInit then
self:setContentBottom(true)
self.chatCreater:callChildFunc(luaid,'playAni')
end
end

function UIXM_ZZSH_MapWin:setContentBottom(ani)

local height=self.winlua:GetChildSizeDeltaY(self.chatContent:getID())
local viewHeight=self.viewHeight
self.winlua:SetStopChildScrollRect(self.chatScrollView:getID())
self.winlua:SetChildDOAnchorPosY(self.chatContent:getID(),0,ani and 0.2 or 0)
end


function UIXM_ZZSH_MapWin:onRecvMessage()
self:freshChatReddot()
end

function UIXM_ZZSH_MapWin:onReadNewestMesg(channel,actorid)
self:freshChatReddot()
end

function UIXM_ZZSH_MapWin:freshChatReddot()
local channels=_showChannels

local num=0
for _,channelId in ipairs(channels)do
if chatCommonHelper.isShowChannel(channelId)and
chatControl.hasNewMesgByChannel(channelId)then
num=num+chatControl.getNewestMesgNumByChannel(channelId)
end
end
local reddot=num>0
if num>99 then
num='99+'
elseif num<=0 then
num=''
end
self.chatReddot:setActive(reddot)
self.numText:setText(num)
self.chatReddotIndex=self:doPunchRotation(self.widget,self.chatReddot:getID(),self.chatReddotIndex,reddot)
end





function UIXM_ZZSH_MapWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UIXM_ZZSH_MapWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end
function UIXM_ZZSH_MapWin:JudeLastTime()
local auto=zhengzhanshanhaiController:getZZSHCfg("auto")
local hasAutoCfg=auto~=nil
if not hasAutoCfg then

return
end


local table1=limitActivitiesModel:getActInfo(10005)
local time=table1.end_time-timeHelper.getServerShortTime()

local day=time/86400

if day<1 and day>0 then
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHShop)
if check then
return
end
UIManager:showWindow("UIExchargeShopTipsWin_limitact")
end
end


local _rankEnterCmpIndex={
icon=0,
state=1,
stateTxt=2,
countdownBg=3,
coutndownTxt=4,
click=5,
}
function UIXM_ZZSH_MapWin:refreshRankEnter(isNoFreshTimer)


local isShow=zhengzhanshanhaiController.checkShowEnter_ZZSH_Rank()
if isShow then
if zhengzhanshanhaiModel:getSeasonState()==3 then
isShow=false
end
end
self.rankEnter:setActive(isShow)

if not isShow then return end

local wb=self.rankEnter:getWidgetBase()


local state=zhengzhanshanhaiController.getEnterState_ZZSH_Rank()

local isShowState=state~=0
local isShowCountDown=state>0

wb:SetChildActive(_rankEnterCmpIndex.state,isShowState)
if isShowState then

local str=""
if state==1 then
str='即将结算'
elseif state==2 then
str=toColorString(FONT_COLOR.eGreenTxtColor,'已结算')
end
wb:SetChildText(_rankEnterCmpIndex.stateTxt,str)
end


wb:SetChildActive(_rankEnterCmpIndex.countdownBg,isShowCountDown)


wb:SetChildButtonClick(_rankEnterCmpIndex.click,function()
UIManager:showWindow('UIXM_ZZSH_RankInfoWin')
end,true)

if not isNoFreshTimer then
self:startRankSettlementTimer()
end
end

function UIXM_ZZSH_MapWin:startRankSettlementTimer()
self:stopRankSettlementTimer()

local wb=self.rankEnter:getWidgetBase()
local curTime=timeHelper.getServerLongTime()
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()
local rankSettlementTime=zhengzhanshanhaiController.getRankPreviewSettlementTime()



local freshStage=function(time)
if startTime==nil or endTime==nil or settleTime==nil or settleEndTime==nil then return 0 end

local stage
if time>=startTime and time<rankSettlementTime then
stage=1
elseif time>=rankSettlementTime and time<settleTime then
stage=2
elseif time>=settleTime and time<settleEndTime then
stage=3
elseif time>=settleEndTime then
stage=0
end
return stage
end
local stageOld=freshStage(curTime)



local curLeftTime,stageNew
local func=function()
if _this==nil then return end
curTime=timeHelper.getServerLongTime()
stageNew=freshStage(curTime)
if stageOld~=stageNew then
_this:refreshRankEnter()
stageOld=stageNew
end

if stageNew==2 then
curLeftTime=settleTime-curTime
wb:SetChildText(_rankEnterCmpIndex.coutndownTxt,timeHelper.format_time_stamp3(curLeftTime))
end

if stageNew==3 then
curLeftTime=settleEndTime-curTime
wb:SetChildText(_rankEnterCmpIndex.coutndownTxt,timeHelper.format_time_stamp3(curLeftTime))
end


if stageNew==0 then
_this:stopRankSettlementTimer()
end
end

self.rankSettlementTimer=self:setTimer(1,0,func)
func()
end

function UIXM_ZZSH_MapWin:stopRankSettlementTimer()
if self.rankSettlementTimer then
self:stopTimerByID(self.rankSettlementTimer)
self.rankSettlementTimer=nil
end
end




function UIXM_ZZSH_MapWin:refreshSeasonMsgBtn()
self:clearSeasonSettlementTimer()

local isShowBtn=false

local seasonMsgGroupId
local seasonState=zhengzhanshanhaiModel:getSeasonState()
local nextSeasonId
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if seasonState==3 or(seasonState==2 and shSeasonId==-1)then

local isFirstSeason=false
if shSeasonId==-1 then
nextSeasonId=1
isFirstSeason=true
else
local firstShSeasonId=zhengzhanshanhaiModel:getFirstSHSeasonId()
nextSeasonId=shSeasonId+1
isFirstSeason=nextSeasonId<=firstShSeasonId
end

if isFirstSeason then

seasonMsgGroupId=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,nextSeasonId,"firstIntoSeasonMsgGroupId")
else
seasonMsgGroupId=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,nextSeasonId,"seasonMsgGroupId")
end
if seasonMsgGroupId then
isShowBtn=true
end
end
self.seasonMsgBtn:setActive(isShowBtn)
if isShowBtn then
self:setSeasonSettlementTimer()
local wb=self.seasonMsgBtn:getWidgetBase()
local browsedSeasonId=zhengzhanshanhaiModel:loadUpdateMsgBrowsedSeasonId()
local isShowReddot=nextSeasonId>browsedSeasonId
wb:SetChildActive(2,isShowReddot)
end

end


function UIXM_ZZSH_MapWin:refreshShSeasonLvBtn()

local isShowBtn=false
if limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eZhengZhanShanHai)then
if zhengzhanshanhaiModel:checkJoin()then
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId>0 then
local seasonState=zhengzhanshanhaiModel:getSeasonState()
if seasonState==1 then
isShowBtn=true
end
end
end
end

self.shLvBtn:setActive(isShowBtn)
if isShowBtn then
local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()or 0
self.shLvText:setText(shSeasonLv)
end

end


function UIXM_ZZSH_MapWin:refreshShSeasonTimeShow()

local seasonState=zhengzhanshanhaiModel:getSeasonState()
local isShowTime=false
if seasonState==1 then
local startTime,endTime,settleTime=zhengzhanshanhaiModel:getSeasonTime()
if settleTime then
isShowTime=true
end
end

self.seasonTimeBg:setActive(isShowTime)
self.isShowSeasonTimeNow=isShowTime
UIManager:invokeUIMethod("UIXM_ZZSH_PvPMainWin","setEmptyObjShow",isShowTime)
if isShowTime then

self:setSeasonTimer()
end
end

function UIXM_ZZSH_MapWin:getShSeasonTimeShowState()
return self.isShowSeasonTimeNow or false
end


function UIXM_ZZSH_MapWin:onSeasonMsgBtn()
local seasonMsgGroupId
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local nextSeasonId
local isFirstSeason=false
if shSeasonId==-1 then
nextSeasonId=1
isFirstSeason=true
else
local firstShSeasonId=zhengzhanshanhaiModel:getFirstSHSeasonId()
nextSeasonId=shSeasonId+1
isFirstSeason=nextSeasonId<=firstShSeasonId
end

if isFirstSeason then

seasonMsgGroupId=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,nextSeasonId,"firstIntoSeasonMsgGroupId")
else
seasonMsgGroupId=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,nextSeasonId,"seasonMsgGroupId")
end

if seasonMsgGroupId then

local winArgs={groupId=seasonMsgGroupId}
zhengzhanshanhaiModel:saveUpdateMsgBrowsedSeasonId(nextSeasonId)
self:refreshSeasonMsgBtn()
return UIManager:showWindow("UICommonVisualGuideWin",winArgs)
end
end


function UIXM_ZZSH_MapWin:setSeasonSettlementTimer()
self:clearSeasonSettlementTimer()
local func
func=function()
local wb=self.seasonMsgBtn:getWidgetBase()
local start_time,end_time,settle_time,settle_end_time=zhengzhanshanhaiModel:getSeasonTime()
local nowTime=timeHelper.getServerLongTime()
local deltaTime=end_time and end_time-nowTime or 0
local timeStr=timeHelper.format_time_stamp11(deltaTime,true)
wb:SetChildText(1,timeStr)
if deltaTime<=0 then
self:clearSeasonSettlementTimer()
end
end

self.seasonSettlementTimer=self:setTimer(1,0,func)

func()
end


function UIXM_ZZSH_MapWin:clearSeasonSettlementTimer()
if self.seasonSettlementTimer then
self:stopTimerByID(self.seasonSettlementTimer)
self.seasonSettlementTimer=nil
end
end


function UIXM_ZZSH_MapWin:setSeasonTimer()
self:clearSeasonTimer()
local func
func=function()
local start_time,end_time,settle_time=zhengzhanshanhaiModel:getSeasonTime()
local nowTime=timeHelper.getServerLongTime()
local deltaTime=settle_time-nowTime
local timeStr=timeHelper.format_time_stamp11(deltaTime,true)
self.seasonTimeText:setText(FMT.fmt("赛季剩余时间:<color=#aae252>{0}</color>",timeStr))
if deltaTime<=0 then
self:clearSeasonTimer()
end
end

self.seasonTimer=self:setTimer(1,0,func)

func()
end


function UIXM_ZZSH_MapWin:clearSeasonTimer()
if self.seasonTimer then
self:stopTimerByID(self.seasonTimer)
self.seasonTimer=nil
end
end


function UIXM_ZZSH_MapWin:onShLvBtn()
local shSeasonLv=zhengzhanshanhaiModel:getSeasonLv()
local d={}
local langId=zhengzhanshanhaiController:getZZSHCfg("lvTipsLangId")or""
d.mode=3
d.title=FMT.fmt("当前山海等级：{0}",shSeasonLv)
d.name=langId
d.posItem=self.shLvBtn
d.pos=Vector2.New(0,-107)
self:showWindow('UIDescribeTips8',d)
end



function UIXM_ZZSH_MapWin:refreshZhanlingBtnReddot()
local isreddot=reddotClassManager.get_reddot(REDDIT_TYPE.eSHZhanLing)
self.zhanlingReddot:setActive(isreddot)
end

function UIXM_ZZSH_MapWin:refershZhanLing()
if zhengzhanshanhaiController.checkSHZhanLingOpen()or zhengzhanshanhaiController.checkSJXianZangOpen()then
self.zhanlingBtn:setActive(true)
else
self.zhanlingBtn:setActive(false)
end
end


function UIXM_ZZSH_MapWin:onZhanlingBtn()


UIFullSHZhanLingController:showMainWindow({tabType=nil,nextFunc=function()
zhengzhanshanhaiController:finishFightOpen({showCloud=false})
end})
end