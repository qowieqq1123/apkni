







def_class("UIWanLingTaMainWin",UIWindowBase)









function UIWanLingTaMainWin:bindComponents()

self.bg=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.collectNum_1=UIText.get(self,2)
self.collectNum_2=UIText.get(self,3)
self.collectNum_3=UIText.get(self,4)
self.collectNum_4=UIText.get(self,5)
self.collectNum_5=UIText.get(self,6)
self.collectReddot_1=UIObject.get(self,7)
self.collectReddot_2=UIObject.get(self,8)
self.collectReddot_3=UIObject.get(self,9)
self.collectReddot_4=UIObject.get(self,10)
self.collectReddot_5=UIObject.get(self,11)
self.level=UIText.get(self,12)
self.levelBg=UIButton.get(self,13)
self.rankBtn=UIButton.get(self,14)
self.rewardBtn=UIButton.get(self,15)
self.rewardBtnReddot=UIObject.get(self,16)
self.root=UIObject.get(self,17)
self.shopBtn=UIButton.get(self,18)
self.shopBtnReddot=UIObject.get(self,19)
self.taLing=UIObject.get(self,20)
self.totalCollect=UIText.get(self,21)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.levelBg:setButtonClick(function()self:onLevelBg()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)
self.collectNum={
self.collectNum_1,
self.collectNum_2,
self.collectNum_3,
self.collectNum_4,
self.collectNum_5,
}
self.collectReddot={
self.collectReddot_1,
self.collectReddot_2,
self.collectReddot_3,
self.collectReddot_4,
self.collectReddot_5,
}



end


function UIWanLingTaMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.collectNum_1);self.collectNum_1=nil;
_UIObject_release(self.collectNum_2);self.collectNum_2=nil;
_UIObject_release(self.collectNum_3);self.collectNum_3=nil;
_UIObject_release(self.collectNum_4);self.collectNum_4=nil;
_UIObject_release(self.collectNum_5);self.collectNum_5=nil;
_UIObject_release(self.collectReddot_1);self.collectReddot_1=nil;
_UIObject_release(self.collectReddot_2);self.collectReddot_2=nil;
_UIObject_release(self.collectReddot_3);self.collectReddot_3=nil;
_UIObject_release(self.collectReddot_4);self.collectReddot_4=nil;
_UIObject_release(self.collectReddot_5);self.collectReddot_5=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.levelBg);self.levelBg=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardBtnReddot);self.rewardBtnReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.shopBtnReddot);self.shopBtnReddot=nil;
_UIObject_release(self.taLing);self.taLing=nil;
_UIObject_release(self.totalCollect);self.totalCollect=nil;
self.collectNum=nil;
self.collectReddot=nil;
end

















local itemIndex=
{
button=0,
text=1,
collect=2,
}
local this


function UIWanLingTaMainWin:onLoaded(...)
self:bindComponents()
this=self
self:addNotify(notifyConfig.onWanLingTaLevelRewardChange,self.onWanLingTaLevelRewardChange)
self:addNotify(notifyConfig.onWanLingTaCollectRewardReceive,self.onWanLingTaCollectRewardReceive)
self:addNotify(notifyConfig.onWanLingTaTuJianChange,self.onWanLingTaTuJianChange)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIWanLingTaMainWin:__delete()
self:unbindComponents()
this=nil
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end
end




function UIWanLingTaMainWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupRaycast(false)
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bg:getID(),true,true,true)
end
self.bg:setChildUIModelShowTarget(5776,1,{},eAnimationID.enter,false,false,0)
self:delayDo(1,function()
self.root:setChildCanvasGroupDOFade(1,1,function()
self.root:setChildCanvasGroupRaycast(true)
end)
self.taLing:setChildUIModelShowTarget(2123004,0.4,{},eAnimationID.stand,false,false,0.6)
local parent=self.winlua:GetCommonComponent(self.taLing:getID(),'Transform')
_InstantiateManager.AddInstance(INSTANCE_TYPE.eClick,parent,function(id)
local hudWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
hudWidget:SetChildSizeDelta(0,200,160)
hudWidget:SetChildAnchoredPos(0,0,40)
hudWidget:SetChildButtonClick(0,function()
self:setTaLingSpeak()
end)
end)
end)
end
if argtable.showcaseId then
UIManager:showWindow("UIWanLingTaBgWin",argtable)
end
local rankOpen=systemModel.isOpen(SYSTEM_DEFINE.eiXuMiTaRank)
self.rankBtn:setActive(rankOpen)
self:refreshCollectInfo()
self:refreshTaLingInfo()
self:refreshBtnReddot()
self:refreshCollectReddot()
self:refreshShopBtn()
self:setTaLingSpeakTimer()
end

function UIWanLingTaMainWin:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UIWanLingTaMainWin.onWanLingTaLevelRewardChange()
this:refreshTaLingInfo()
this:refreshBtnReddot()
this:refreshCollectReddot()
this:refreshShopBtn()
end

function UIWanLingTaMainWin.onWanLingTaTuJianChange(tjId,tjLevel)
this:refreshCollectInfo()
this:refreshTaLingInfo()
this:refreshCollectReddot()
end

function UIWanLingTaMainWin.onWanLingTaCollectRewardReceive(sjId)
this:refreshCollectReddot()
end

function UIWanLingTaMainWin.on_money_changed(moneyType,lastVal,val)
if moneyType==eMoneyType.mtXmtExp then
this:refreshBtnReddot()
end
end

function UIWanLingTaMainWin:setTaLingSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end
local speakInterval=cfgHelper.getdef1(cfg_xumitatalingtalkconfig,"speakInterval")
self.speakTimer=self:setTimer(speakInterval,0,function()
self:setTaLingSpeak()
end)
end

function UIWanLingTaMainWin:setTaLingSpeak()
local collect=wanLingTaModel:getCollectCount()
local cfg=cfg_xumitatalingtalkconfig()
local idx=#cfg
for i,v in ipairs(cfg)do
if collect<=v.range then
idx=i
break
end
end
local txtLib=cfg[idx].lines
local speakTxt=txtLib[math.random(#txtLib)]
local parent=self.winlua:GetCommonComponent(self.taLing:getID(),'Transform')
if self.sHUD then
local hudWidget=_InstantiateManager.GetComponent(self.sHUD,'CSGUIWidgetBase')
local txt=chatEmotHelper.decodeEmot(speakTxt)or''
hudWidget:SetChildText(0,txt)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
else
self.sHUD=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleSpeak,parent,function(id)
if self.sHUD==id then
local hudWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local offsetVal=Vector2.New(0,125)
hudWidget:SetChildAnchoredPosition(2,offsetVal)
local txt=chatEmotHelper.decodeEmot(speakTxt)or''
hudWidget:SetChildText(0,txt)
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(1)
hudWidget:SetChildCSImageSprite(1,abName,skinName)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
else
hudControl:removeHUD(id)
self.sHUD=nil
end
end)
end
if self.removeSpeakTimer then
self:stopTimerByID(self.removeSpeakTimer)
self.removeSpeakTimer=nil
end
local speakDuration=3
self.removeSpeakTimer=self:setTimer(speakDuration,0,function()
self:removeTaLingSpeak()
end)
end

function UIWanLingTaMainWin:removeTaLingSpeak()
if self.sHUD then
_InstantiateManager.RemoveInstance(self.sHUD)
self.sHUD=nil
end
end

function UIWanLingTaMainWin:refreshShopBtn()
local const_def=cfgHelper.getdef(cfg_xumitashopconfig)
local baoKuCfg=const_def.baoKuCfg
local cfg=baoKuCfg[1]
local unLockLevel=cfg.cdn
local taLingLevel=wanLingTaModel:getTaLingLevel()
self.shopBtn:setActive(taLingLevel>=unLockLevel)
end

function UIWanLingTaMainWin:refreshBtnReddot()
local rewardReddot=wanLingTaModel:checkTaLingLevelRewardReddot()
self.rewardBtnReddot:setActive(rewardReddot)
local shopReddot=wanLingTaModel:checkWanLingBaoKuNewLevelReddot()
self.shopBtnReddot:setActive(shopReddot)
end

function UIWanLingTaMainWin:refreshCollectReddot()
for typeId,v in ipairs(self.collectReddot)do
local reddot=wanLingTaModel:checkTypeCollectTargetReddot(typeId)or wanLingTaModel:checkTypeTuJianReddot(typeId)
v:setActive(reddot)
end
end

function UIWanLingTaMainWin:refreshCollectInfo()
for i,v in ipairs(self.collectNum)do
local collect,max=wanLingTaModel:getCollectCount(i)
v:setText(string.format("收集:%d/%d",collect,max))
end
end

function UIWanLingTaMainWin:refreshTaLingInfo()
local taLingLevel=wanLingTaModel:getTaLingLevel()
local collect,max=wanLingTaModel:getCollectCount()

self.level:setText(taLingLevel)
self.totalCollect:setText(string.format("%d/%d",collect,max))
end

function UIWanLingTaMainWin:OnEvent(id)
if self.anim then
return
end
self.anim=true
local show=function()
UIManager:showWindow("UIWanLingTaBgWin",{showcaseId=id})
self.anim=false
end
self.taLing:setChildDOLocalMoveX(40,0.3)
self:delayDo(0.1,function()
self.taLing:setChildCanvasGroupDOFade(0,0.2,show)
end)
self:delayDo(1,function()
self:resetTaLing()
end)
end

function UIWanLingTaMainWin:resetTaLing()
self.winlua:SetChildLocalPosX(self.taLing:getID(),0)
self.taLing:setChildCanvasGroupAlpha(1)
end

function UIWanLingTaMainWin:onRewardBtn()
if self.anim then
return
end
self:showWindow("UIWanLingTaRewardWin")
end

function UIWanLingTaMainWin:onLevelBg()
if self.anim then
return
end
self:onRewardBtn()
end

function UIWanLingTaMainWin:onRankBtn()
if self.anim then
return
end
self:showWindow("UIWanLingTaRankWin")
end

function UIWanLingTaMainWin:onShopBtn()
if self.anim then
return
end
self:showWindow("UIWanLingBaoKuWin")
self.shopBtnReddot:setActive(false)
end

function UIWanLingTaMainWin:onCloseBtn()
if self.anim then
return
end
local startCallback=function()
UIFullWanLingTaControl:closeUI(nil,true)
end
loadingControl.openCloud(startCallback,0.5)
self:stopAllTimer()
end