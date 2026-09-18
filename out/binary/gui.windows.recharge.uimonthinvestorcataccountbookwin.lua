







def_class("UIMonthInvestorCatAccountBookWin",UIWindowBase)









function UIMonthInvestorCatAccountBookWin:bindComponents()

self.mask=UIButton.get(self,0)
self.btnClose=UIButton.get(self,1)
self.getRewardBtn=UIButton.get(self,2)
self.gotoOpenBtn=UIButton.get(self,3)
self.desc=UIText.get(self,4)
self.minshengValue=UIText.get(self,5)
self.speakObj=UIObject.get(self,6)
self.npcModel=UIObject.get(self,7)
self.speakText=UIText.get(self,8)
self.accumulateMsValue=UIText.get(self,9)
self.levelUpText=UIText.get(self,10)
self.bgModel=UIObject.get(self,11)
self.root=UIObject.get(self,12)

self.mask:setButtonClick(function()self:onMask()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.getRewardBtn:setButtonClick(function()self:onGetRewardBtn()end)

self.gotoOpenBtn:setButtonClick(function()self:onGotoOpenBtn()end)



end


function UIMonthInvestorCatAccountBookWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.getRewardBtn);self.getRewardBtn=nil;
_UIObject_release(self.gotoOpenBtn);self.gotoOpenBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.minshengValue);self.minshengValue=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.accumulateMsValue);self.accumulateMsValue=nil;
_UIObject_release(self.levelUpText);self.levelUpText=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this




function UIMonthInvestorCatAccountBookWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIMonthInvestorCatAccountBookWin:__delete()
self:clearSpeakTimer()
self:unbindComponents()
_this=nil
end




function UIMonthInvestorCatAccountBookWin:onShow(argtable,afterOnloaded)


local modelId=4041
self.bgModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.enter,false,false,0)


self.root:setChildCanvasGroupAlpha(0)
self:delayDo(0.2,function()
if _this==nil then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)


self:refresh(true)
end


function UIMonthInvestorCatAccountBookWin:onHide()
self:clearSpeakTimer()
end

function UIMonthInvestorCatAccountBookWin:refresh(isInit)
if not isInit then

local isNeedCloseWin=self:checkWinClose()
if isNeedCloseWin then
return self:closeSelf()
end
end


self:refreshInfoPanel()


local isActiveHeightCard=rechargeModel:checkCardActive(2)
self.getRewardBtn:setActive(isActiveHeightCard)
self.gotoOpenBtn:setActive(not isActiveHeightCard)


self:refreshNPCModel(isInit)
end

function UIMonthInvestorCatAccountBookWin:refreshInfoPanel()

local msValue=rechargeModel:getMonthCardAccumulateMingSheng()


local upLevelCount=zongmenModel:getCanLevelUpCountByAddExp(msValue)


local cfg=cfgHelper.get1(cfg_yuekacataccountbookconfig_get,1)
local levelup_Str=cfg.expectLevelUpText
local levelup_Text=''
if upLevelCount>0 and levelup_Str then
levelup_Text=FMT.fmt(levelup_Str,upLevelCount)
self.levelUpText:setActive(true)
self.levelUpText:setText(levelup_Text)
else
self.levelUpText:setActive(false)
end

local descStr=cfg.infoText
self.desc:setText(descStr)
self.accumulateMsValue:setText(FMT.fmt("已积累有<color=#ca631d>{0}</color>点名声",msValue))

self.minshengValue:setText(msValue)
end


function UIMonthInvestorCatAccountBookWin:refreshNPCModel(isInit)
local fadeTime=isInit and 0.5 or 0
local cfg=cfgHelper.get1(cfg_yuekanpcconfig_get,2)
if not cfg then
logErr(FMT.fmt("月卡配置表_npc配置中找不到id为{0} 所对应的配置",2))
return
end
self.speakContent_before=cfg.npcTalk_before
self.speakContent_after=cfg.npcTalk_after
local npcModelParms=cfg.npcModel
local modelId=npcModelParms[1]
local scale=npcModelParms[2]
local modelOffSet=npcModelParms[3]
self.npcModel:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand,false,false,fadeTime)
self.npcModel:setChildUIModelShowTargetOffset(modelOffSet[1],modelOffSet[2])
local isFlip=cfg.isFlip==true
self.npcModel:setChildUIModelShowFlipX(isFlip)

self.npcTalkTime=cfg.npcTalkTime
self.npcTalkShowTime=cfg.npcTalkShowTime


self:delayDo(0.3,function()
self:doSpeaking()
end)
end


function UIMonthInvestorCatAccountBookWin:doSpeaking()
self:clearSpeakTimer()
local speakList={}

local isActiveCard=rechargeModel:checkHasCardActive()
if isActiveCard then
speakList=self.speakContent_after
else
speakList=self.speakContent_before
end

local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self.npcModel:setChildModelAnimationState(2099)
self:doTalkAnim()
end


function UIMonthInvestorCatAccountBookWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.5,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end)
end


function UIMonthInvestorCatAccountBookWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)
self.npcModel:setChildModelAnimationState(eAnimationID.stand)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end


function UIMonthInvestorCatAccountBookWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UIMonthInvestorCatAccountBookWin:checkWinClose()
local isNeedClose=not rechargeModel:checkMonthCardCatAccountBtnActive()

return isNeedClose
end




function UIMonthInvestorCatAccountBookWin:onMask()
self:closeSelf()
end



function UIMonthInvestorCatAccountBookWin:onBtnClose()
self:closeSelf()
end



function UIMonthInvestorCatAccountBookWin:onGetRewardBtn()

if not rechargeModel:checkCardActive(2)then
UIManager.error("您的尊贵股东特权已过期")
return self:refresh()
end


rechargeController:reqMonthInvestorGetAccumulateMingSheng()
end



function UIMonthInvestorCatAccountBookWin:onGotoOpenBtn()

local isOnMonthInvestorWin=UIManager:isActive('UIMonthInvestorWin')

if isOnMonthInvestorWin then

local highMonthCfg=cfgHelper.get(cfg_yuekaconfig_get,2)
local isActive=rechargeModel:checkCardActive(highMonthCfg.id)
if not isActive then

local czId=highMonthCfg.czId
payControl.reqPay(czId)
else

self:refresh()
end
else

self:closeSelf()

jumpManager:jump({id=JUMP_TYPE.eReCharge,args={tabType=FULL_TAB_TYPE.eMonthInvestor}})
end
end


function UIMonthInvestorCatAccountBookWin:onNPCClick()
self:doSpeaking()
end