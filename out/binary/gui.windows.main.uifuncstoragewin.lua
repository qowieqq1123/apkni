







def_class("UIFuncStorageWin",UIWindowBase)









function UIFuncStorageWin:bindComponents()

self.arenaCompensationBtn=UIButton.get(self,0)
self.countIcon=UIObject.get(self,1)
self.countTex=UIText.get(self,2)
self.coupleRequestBtn=UIButton.get(self,3)
self.emailBtn=UIButton.get(self,4)
self.fastManagerBtn=UIButton.get(self,5)
self.funcList=UIObject.get(self,6)
self.funcListbtn=UIButton.get(self,7)
self.funcListbtnselect=UIObject.get(self,8)
self.funcListReddot=UIObject.get(self,9)
self.gateApplyBtn=UIButton.get(self,10)
self.HQTBtn=UIButton.get(self,11)
self.mojieRewardBtn=UIButton.get(self,12)
self.paiQianLuBtn=UIButton.get(self,13)
self.serverTransferHistroyBtn=UIButton.get(self,14)
self.serverTransferRewardBtn=UIButton.get(self,15)
self.shiWuBtn=UIButton.get(self,16)
self.systemZongMenFightBtn=UIButton.get(self,17)
self.systemZongMenLetterBtn=UIButton.get(self,18)
self.systemZongMenSGBtn=UIButton.get(self,19)
self.systemZongMenSurrenderBtn=UIButton.get(self,20)
self.tianMoJieBtn=UIButton.get(self,21)
self.tuFaBtn=UIButton.get(self,22)
self.underAttackBtn=UIButton.get(self,23)
self.xianjieJieYinBtn=UIButton.get(self,24)
self.XianjieRiZhiBtn=UIButton.get(self,25)
self.xianmengInviteBtn=UIButton.get(self,26)
self.xingyuBtn=UIButton.get(self,27)
self.xmdgRewardBtn=UIButton.get(self,28)
self.yuLingZhaiBtn=UIButton.get(self,29)
self.zbgRewardBtn=UIButton.get(self,30)

self.arenaCompensationBtn:setButtonClick(function()self:onArenaCompensationBtn()end)

self.coupleRequestBtn:setButtonClick(function()self:onCoupleRequestBtn()end)

self.emailBtn:setButtonClick(function()self:onEmailBtn()end)

self.fastManagerBtn:setButtonClick(function()self:onFastManagerBtn()end)

self.funcListbtn:setButtonClick(function()self:onFuncListbtn()end)

self.gateApplyBtn:setButtonClick(function()self:onGateApplyBtn()end)

self.HQTBtn:setButtonClick(function()self:onHQTBtn()end)

self.mojieRewardBtn:setButtonClick(function()self:onMojieRewardBtn()end)

self.paiQianLuBtn:setButtonClick(function()self:onPaiQianLuBtn()end)

self.serverTransferHistroyBtn:setButtonClick(function()self:onServerTransferHistroyBtn()end)

self.serverTransferRewardBtn:setButtonClick(function()self:onServerTransferRewardBtn()end)

self.shiWuBtn:setButtonClick(function()self:onShiWuBtn()end)

self.systemZongMenFightBtn:setButtonClick(function()self:onSystemZongMenFightBtn()end)

self.systemZongMenLetterBtn:setButtonClick(function()self:onSystemZongMenLetterBtn()end)

self.systemZongMenSGBtn:setButtonClick(function()self:onSystemZongMenSGBtn()end)

self.systemZongMenSurrenderBtn:setButtonClick(function()self:onSystemZongMenSurrenderBtn()end)

self.tianMoJieBtn:setButtonClick(function()self:onTianMoJieBtn()end)

self.tuFaBtn:setButtonClick(function()self:onTuFaBtn()end)

self.underAttackBtn:setButtonClick(function()self:onUnderAttackBtn()end)

self.xianjieJieYinBtn:setButtonClick(function()self:onXianjieJieYinBtn()end)

self.XianjieRiZhiBtn:setButtonClick(function()self:onXianjieRiZhiBtn()end)

self.xianmengInviteBtn:setButtonClick(function()self:onXianmengInviteBtn()end)

self.xingyuBtn:setButtonClick(function()self:onXingyuBtn()end)

self.xmdgRewardBtn:setButtonClick(function()self:onXmdgRewardBtn()end)

self.yuLingZhaiBtn:setButtonClick(function()self:onYuLingZhaiBtn()end)

self.zbgRewardBtn:setButtonClick(function()self:onZbgRewardBtn()end)



end


function UIFuncStorageWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arenaCompensationBtn);self.arenaCompensationBtn=nil;
_UIObject_release(self.countIcon);self.countIcon=nil;
_UIObject_release(self.countTex);self.countTex=nil;
_UIObject_release(self.coupleRequestBtn);self.coupleRequestBtn=nil;
_UIObject_release(self.emailBtn);self.emailBtn=nil;
_UIObject_release(self.fastManagerBtn);self.fastManagerBtn=nil;
_UIObject_release(self.funcList);self.funcList=nil;
_UIObject_release(self.funcListbtn);self.funcListbtn=nil;
_UIObject_release(self.funcListbtnselect);self.funcListbtnselect=nil;
_UIObject_release(self.funcListReddot);self.funcListReddot=nil;
_UIObject_release(self.gateApplyBtn);self.gateApplyBtn=nil;
_UIObject_release(self.HQTBtn);self.HQTBtn=nil;
_UIObject_release(self.mojieRewardBtn);self.mojieRewardBtn=nil;
_UIObject_release(self.paiQianLuBtn);self.paiQianLuBtn=nil;
_UIObject_release(self.serverTransferHistroyBtn);self.serverTransferHistroyBtn=nil;
_UIObject_release(self.serverTransferRewardBtn);self.serverTransferRewardBtn=nil;
_UIObject_release(self.shiWuBtn);self.shiWuBtn=nil;
_UIObject_release(self.systemZongMenFightBtn);self.systemZongMenFightBtn=nil;
_UIObject_release(self.systemZongMenLetterBtn);self.systemZongMenLetterBtn=nil;
_UIObject_release(self.systemZongMenSGBtn);self.systemZongMenSGBtn=nil;
_UIObject_release(self.systemZongMenSurrenderBtn);self.systemZongMenSurrenderBtn=nil;
_UIObject_release(self.tianMoJieBtn);self.tianMoJieBtn=nil;
_UIObject_release(self.tuFaBtn);self.tuFaBtn=nil;
_UIObject_release(self.underAttackBtn);self.underAttackBtn=nil;
_UIObject_release(self.xianjieJieYinBtn);self.xianjieJieYinBtn=nil;
_UIObject_release(self.XianjieRiZhiBtn);self.XianjieRiZhiBtn=nil;
_UIObject_release(self.xianmengInviteBtn);self.xianmengInviteBtn=nil;
_UIObject_release(self.xingyuBtn);self.xingyuBtn=nil;
_UIObject_release(self.xmdgRewardBtn);self.xmdgRewardBtn=nil;
_UIObject_release(self.yuLingZhaiBtn);self.yuLingZhaiBtn=nil;
_UIObject_release(self.zbgRewardBtn);self.zbgRewardBtn=nil;
end
















local _this
local funcBtnIdx=0
local _funcBtnGetIdx=function()
funcBtnIdx=funcBtnIdx+1
return funcBtnIdx
end


local eFuncBtnEnum={
arenaCompensationBtn=_funcBtnGetIdx(),
coupleRequestBtn=_funcBtnGetIdx(),
emailBtn=_funcBtnGetIdx(),
fastManagerBtn=_funcBtnGetIdx(),
gateApplyBtn=_funcBtnGetIdx(),
HQTBtn=_funcBtnGetIdx(),
mojieRewardBtn=_funcBtnGetIdx(),
paiQianLuBtn=_funcBtnGetIdx(),
serverTransferHistroyBtn=_funcBtnGetIdx(),
serverTransferRewardBtn=_funcBtnGetIdx(),
shiWuBtn=_funcBtnGetIdx(),
systemZongMenFightBtn=_funcBtnGetIdx(),
systemZongMenLetterBtn=_funcBtnGetIdx(),
systemZongMenSGBtn=_funcBtnGetIdx(),
systemZongMenSurrenderBtn=_funcBtnGetIdx(),
tianMoJieBtn=_funcBtnGetIdx(),
tuFaBtn=_funcBtnGetIdx(),
underAttackBtn=_funcBtnGetIdx(),
xianjieJieYinBtn=_funcBtnGetIdx(),
XianjieRiZhiBtn=_funcBtnGetIdx(),
xianmengInviteBtn=_funcBtnGetIdx(),
xingyuBtn=_funcBtnGetIdx(),
xmdgRewardBtn=_funcBtnGetIdx(),
yuLingZhaiBtn=_funcBtnGetIdx(),
zbgRewardBtn=_funcBtnGetIdx(),
}

local getButtonIsActivated=function(button)
local wb=button:getChildWidgetBase()
return wb:GetChildActiveSelf(-1)
end


local funcButtonHandler={
[eFuncBtnEnum.arenaCompensationBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.coupleRequestBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.emailBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.fastManagerBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.gateApplyBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.HQTBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.mojieRewardBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.paiQianLuBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
local recordCount=worldFightRecordModel:getRecordCount()
if recordCount<=0 then
self.baseButton:setActive(false)
end
end
},
[eFuncBtnEnum.serverTransferHistroyBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.serverTransferRewardBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.shiWuBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.systemZongMenFightBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.systemZongMenLetterBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.systemZongMenSGBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.systemZongMenSurrenderBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.tianMoJieBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.tuFaBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.underAttackBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.xianjieJieYinBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.XianjieRiZhiBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
local isReddot=xianjieModel:get_monsterReddot()or xianjieModel:get_ResourceReddot()or xianjieModel:isNewRiZhi()or xianjieModel:Get_reddotchangeflag()
if not isReddot then
self.baseButton:setActive(false)
end
end
},
[eFuncBtnEnum.xianmengInviteBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.xingyuBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.xmdgRewardBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.yuLingZhaiBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
[eFuncBtnEnum.zbgRewardBtn]={

baseButton=nil,
isActive=function(self)
return getButtonIsActivated(self.baseButton)
end,
refreshState=function(self,uiBase)
end
},
}


local registerFuncButton=function(key,button)
funcButtonHandler[key].baseButton=button
end

local funcBtnViewMaxWidth=700
local buttonWidth=70
local buttonSpacing=20
local buttonScollSpacing_left=30
local buttonScollSpacing_right=80
local maxShowBtnCount=3





function UIFuncStorageWin:onLoaded(...)
self:bindComponents()

_this=self

self.bShowFuncList=simpleModeControl:getFuncStorageSimple()
if self.bShowFuncList then
self.funcList:setChildCanvasGroupAlpha(1)
self.funcList:setActive(true)

self.funcListReddot:setActive(false)
self:doPunchRotation(false)
else
self.funcList:setChildCanvasGroupAlpha(0)
self.funcList:setActive(false)

self:clearTweener_AllBtn()
end

self.funcListbtnselect:setActive(self.bShowFuncList)
self.infoList={9,10,11,12,13}

self:setTimer(1,-1,function()
self:refreshReddot()
end)

notifySystem:listenNotify(notifyConfig.onWorldFightRecordChanged,self.on_paiqian_change)
self:addNotify(notifyConfig.on_mail_changed,self.on_mail_changed)
self:addNotify(notifyConfig.onSystemZMFightRecordNew,self.onSystemZMFightRecordNew)
self:addNotify(notifyConfig.onSystemZMFightResultNew,self.onSystemZMFightResultNew)
self:addNotify(notifyConfig.onSystemZMFightWaitResultNew,self.onSystemZMFightWaitResultNew)
self:addNotify(notifyConfig.onSystemZMFightFlagChanged,self.onSystemZMFightFlagChanged)
self:addNotify(notifyConfig.onSystemZMInit,self.onSystemZMInit)
self:addNotify(notifyConfig.onSystemZMVassalRewardChange,self.onSystemZMVassalRewardChange)
self:addNotify(notifyConfig.onSystemZMLetterChange,self.onSystemZMLetterChange)
self:addNotify(notifyConfig.onTianMoJieMonsterChange,self.onTianMoJieMonsterChange)
self:addNotify(notifyConfig.onXiaoZhuShouFinish,self.onXiaoZhuShouFinish)
self:addNotify(notifyConfig.onXiaoZhuShouStop,self.onXiaoZhuShouStop)
self:addProNotify(35,8,self.on_35_8)



self:registerAllButton()
end


function UIFuncStorageWin:__delete()
self:doPunchRotation(false)
self:clearTweener_AllBtn()
self:unbindComponents()

_this=nil

self:clearSWTimer()
self:clearFLTweener()
self:stopSystemZongMenFightCDTimer()

notifySystem:removelistener(notifyConfig.onWorldFightRecordChanged,self.on_paiqian_change)
end

function UIFuncStorageWin.on_paiqian_change()
_this:refreshPaiQianLu(false)
_this:quickRefresh()
end

function UIFuncStorageWin.on_mail_changed()
_this:refreshEmailBtn(false)
_this:quickRefresh()
end




function UIFuncStorageWin:onShow(argtable,afterOnloaded)
self.widget:SetAsFirstSibling(-1)
self:refresh()
self:refreshReddot()


UIManager:invokeUIMethod("UIMain","freshSimpleBtn")
end

function UIFuncStorageWin:refreshReddot()
if not self.bShowFuncList then
local isReddot=self:checkReddot()
self.funcListReddot:setActive(isReddot)
self:doPunchRotation(isReddot)
end
end

function UIFuncStorageWin:checkReddot()

local check=systemModel.isOpen(SYSTEM_DEFINE.eTuFaEvent)
if check then
local data=emergenciesControl:getSettlementData()
if data~=nil then
return true
end
end


check=systemModel.isOpen(SYSTEM_DEFINE.eDispatchRecord)
if check then
local num=worldFightRecordModel:getNewRecordCount()
if num>0 then
return true
end
end


check=systemModel.isOpen(SYSTEM_DEFINE.eXianMeng)
if check then
local num=xianmengModel:getInvitationCount()
if num>0 then
return true
end
end


check=systemModel.isOpen(SYSTEM_DEFINE.eYouJian)
if check then
local reddot=mailModel:checkReddot()
if reddot then
return true
end
end


check=systemModel.isOpen(SYSTEM_DEFINE.eDiscipleCouple)
if check then
local num=#DiscipleCoupleModel:getReqCoupleList()
if num>0 then
return true
end
end

if systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)then
if systemZongMenModel:isExistFightFlag(systemZongMenFightFlagType.eSurrender)then
return true
end
end


check=systemModel.isOpen(SYSTEM_DEFINE.eJianZhuTiShi)
if check then
if xiaodaotongModel:getManufactureReddot()or
xiaodaotongModel:getBuildingReddot()or
xiaodaotongModel:getReddot()then
return true
end
end


local xmdg_num=xianmengdigongModel:getAllHasRewardEventNum()
if xmdg_num>0 then
return true
end


local isHideShanMen=shanmenModel:getIsShanMenModelHide()
if not isHideShanMen then
local state,optionReddot,time=eventOptionControl.getOptionShowInfo()
local baiShanReddot=false
local reddotCount=optionReddot
if baiShanReddot or
reddotCount>0 or
state==EVENT_OPTION_STATE.eFinish or
state==EVENT_OPTION_STATE.eWaitFinishMiJing then
return true
end
end


local flag=XingYuController.checkXingYuReddot()
if flag then
return true
end

local state=YuLingZhaiModel:getHealType()
if state==1 then
return true
end

local showGateApplyBtn=xianjieModel:checkIsShowGateApplyBtn()
if showGateApplyBtn then
local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
local num=xianjieModel:checkMoJieGateNotReadAskCountByGateId(selfXmOwnGateId)
return num>0
end

return false
end

function UIFuncStorageWin:refresh()
self:refreshSystemZongMenLetterBtn(false)
self:refreshSystemZongMenSurrenderBtn(false)
self:refreshSystemZongMenSGBtn(false)
self:refreshSystemZongMenFightBtn(false)
self:refreshTuFaIcon(false)
self:freshFastBtn(false)
self:refreshPaiQianLu(false)
self:refreshShiWuBtn(false)
self:refreshXianMengInviteBtn(false)
self:refreshEmailBtn(false)
self:refreshxmdgRewardBtn(false)
self:refreshzbgRewardBtn(false)
self:refreshCoupleRequestBtn(false)
self:refreshTianMoJieBtn(false)
self:refreshXiJiBtn(false)
self:refreshXianJieRiZhi(false)
self:refreshXianJieJieYinBtn(false)
self:refreshXingYuBtn(false)
self:refreshYuLingZhaiBtn(false)
self:refreshMoJieRewardBtn(false)
self:refreshArenaCompensationBtn(false)
self:refreshGateApplyBtn(false)
self:refreshHQTbtn(false)
self:refreshServerTransferHistroyBtn(false)
self:refreshServerTransferRewardBtn(false)


self:quickRefresh()
end


function UIFuncStorageWin:onHide()
self:doPunchRotation(false)
self:clearTweener_AllBtn()
end

function UIFuncStorageWin:refreshTuFaIcon(needQuickRefresh)
local data=emergenciesControl:getSettlementData()
local check=data~=nil
self.tuFaBtn:setActive(check)
if check then
local widget=self.fastManagerBtn:getChildWidgetBase()
widget:SetChildActive(3,true)
widget:SetChildText(4,1)
end

if needQuickRefresh~=false then

return self:quickRefresh()
end
end

function UIFuncStorageWin:freshFastBtn(needQuickRefresh)
if not self.bShowFuncList then
return
end
local check=systemModel.isOpen(SYSTEM_DEFINE.eJianZhuTiShi)
self.fastManagerBtn:setActive(check)

if needQuickRefresh~=false then

self:quickRefresh()
end

if not check then
return
end
local widget=self.fastManagerBtn:getChildWidgetBase()
local num=0
local mNum=xiaodaotongModel:getManufactureReddotNum()
local bdNum=xiaodaotongModel:getBuildingReddotNum()
local tipsNum=xiaodaotongModel:getReddotNum()or 0
local cesNum=catEntrustModel:getReddotStateNum()
local xzsNum=xiaoZhuShouModel:getReddotNum()
num=num+mNum+bdNum+tipsNum+cesNum+xzsNum
if tipsNum>0 then
self.fastMarPage=3
elseif mNum>0 then
self.fastMarPage=1
elseif bdNum>0 then
self.fastMarPage=2
else
self.fastMarPage=3
end
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)

end


function UIFuncStorageWin:refreshFastManagerBtn()
local func=function()
if not self or self.isClose then return end
self:freshFastBtn()
self.delayFlushTimer=nil
end
if self.delayFlushTimer==nil then
self.delayFlushTimer=FrameTimer.New(func,1,0)
self.delayFlushTimer:Start()
end
end

function UIFuncStorageWin:refreshPaiQianLu(needQuickRefresh)
local check=worldFightRecordController.enoughOpenDialogueConditon()
self.paiQianLuBtn:setActive(check)

if needQuickRefresh~=false then

self:quickRefresh()
end
if not check then
return
end
local num=worldFightRecordModel:getNewRecordCount()
local widget=self.paiQianLuBtn:getChildWidgetBase()
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
end

function UIFuncStorageWin:refreshShiWuBtn(needQuickRefresh)




local check
local baishanReddot=false
local eventReddot
local isHideShanMen=shanmenModel:getIsShanMenModelHide()
if not isHideShanMen then

eventReddot=eventOptionControl.needOption()
check=eventReddot or baishanReddot
else
check=false
end
self.shiWuBtn:setActive(check)
local widget=self.shiWuBtn:getChildWidgetBase()
local widgetId=self.shiWuBtn:getID()
if check then
local state,optionReddot,time=eventOptionControl.getOptionShowInfo()


local reddotCount=optionReddot
if state~=self.state then
self.isShowInfo=false
widget:SetChildActive(8,false)
end
widget:SetChildActive(3,reddotCount>0)
widget:SetChildText(4,reddotCount)
widget:SetChildActive(5,time>0)
if time>0 and self.text6Time~=time then

self.text6Time=time
widget:SetChildText(6,FMT.fmt("<color=#a1ec58>{0}</color>",timeHelper.format_time_stamp12(time)))
end
self.state=state

local catReddot
if eventReddot then
catReddot=state==EVENT_OPTION_STATE.eFinish or state==EVENT_OPTION_STATE.eWaitFinishMiJing
else
catReddot=baishanReddot
end
self:doPunchRotation_Btn(widgetId,widget,16,catReddot)
else

self:doPunchRotation_Btn(widgetId,widget,16,false)
self.text6Time=nil
end

if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:refreshXianMengInviteBtn(needQuickRefresh)
local num=xianmengModel:getInvitationCount()
local check=num>0
self.xianmengInviteBtn:setActive(check)
if needQuickRefresh~=false then

self:quickRefresh()
end
if not check then
return
end
local widget=self.xianmengInviteBtn:getChildWidgetBase()
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
end

function UIFuncStorageWin:refreshEmailBtn(needQuickRefresh)
local num=mailModel:getReddotCount()
local check=num>0
self.emailBtn:setActive(check)
if needQuickRefresh~=false then

self:quickRefresh()
end
if not check then
return
end
local widget=self.emailBtn:getChildWidgetBase()

local glableCfg=cfg_globalconfig_get(1)
local MaxCount=glableCfg.maxmail
if num>MaxCount then
num=MaxCount
end

widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
end

function UIFuncStorageWin:refreshxmdgRewardBtn(needQuickRefresh)
local list=xianmengdigongModel:getAllHasRewardEvent()
local num=0
if list~=nil then
num=#list
end
local check=num>0
self.xmdgRewardBtn:setActive(check)
if needQuickRefresh~=false then

self:quickRefresh()
end
if not check then
return
end
local widget=self.xmdgRewardBtn:getChildWidgetBase()
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
end

function UIFuncStorageWin:refreshzbgRewardBtn(needQuickRefresh)
local reddot=rechargeModel:getZhenBaoGeGetNum()
self.zbgRewardBtn:setActive(reddot>0)
if needQuickRefresh~=false then

self:quickRefresh()
end
if reddot==0 then
return
end
local widget=self.zbgRewardBtn:getChildWidgetBase()
widget:SetChildActive(3,reddot>0)
widget:SetChildText(4,reddot)
end

function UIFuncStorageWin:refreshCoupleRequestBtn(needQuickRefresh)
local open=systemModel.isOpen(SYSTEM_DEFINE.eDiscipleCouple)
local reddot=#DiscipleCoupleModel:getReqCoupleList()
self.coupleRequestBtn:setActive(reddot>0 and open)
if needQuickRefresh~=false then

self:quickRefresh()
end
if reddot==0 or not open then
return
end
local widget=self.coupleRequestBtn:getChildWidgetBase()
widget:SetChildActive(3,reddot>0)
widget:SetChildText(4,reddot)
end

function UIFuncStorageWin:refreshTianMoJieBtn(needQuickRefresh)
local actorId=playerModel:getActorID()
local monsters=tianMoJieModel:getMonstersByActor(actorId)
self.tianMoJieBtn:setActive(next(monsters)~=nil)
if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:refreshXiJiBtn(needQuickRefresh)
local vis=xianjieModel:isUnderAttack()
self.underAttackBtn:setActive(vis)
local btnWidget=self.underAttackBtn:getChildWidgetBase()
local widgetId=self.underAttackBtn:getID()
if mainControl:isInScene(eSceneType.eXianJie)then
local func=function()
return xianjieModel:getMinLeftAttackTime()
end
self:startLeftTimer(widgetId,btnWidget,5,4,func)
else
self:stopLeftTimer(widgetId)
end
self:doPunchRotation_Btn(widgetId,btnWidget,3,vis)
if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:refreshXianJieRiZhi(needQuickRefresh)
local check=systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)
self.XianjieRiZhiBtn:setActive(check)
local btnWidget=self.XianjieRiZhiBtn:getChildWidgetBase()
local widgetId=self.XianjieRiZhiBtn:getID()
local isReddot=xianjieModel:get_monsterReddot()or xianjieModel:get_ResourceReddot()or xianjieModel:isNewRiZhi()or xianjieModel:Get_reddotchangeflag()

self:doPunchRotation_Btn(widgetId,btnWidget,5,isReddot)
if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:refreshXianJieJieYinBtn(needQuickRefresh)
local vis=jiuchongtianjieGuideController:checkShowSupportEnter()

self.xianjieJieYinBtn:setActive(vis)
local btnWidget=self.xianjieJieYinBtn:getChildWidgetBase()
local widgetId=self.xianjieJieYinBtn:getID()
local reddot=jiuchongtianjieGuideController:getSupportReddot()
btnWidget:SetChildActive(3,reddot)
self:doPunchRotation_Btn(widgetId,btnWidget,3,reddot)
if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:refreshXingYuBtn(needQuickRefresh)
local flag=XingYuController.checkXingYuReddot()
self.xingyuBtn:setActive(flag)
local btnWidget=self.xingyuBtn:getChildWidgetBase()
local num=XingYuController.getXingYuReddotCnt()
btnWidget:SetChildActive(3,num>0)
btnWidget:SetChildText(4,num)
if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:refreshYuLingZhaiBtn(needQuickRefresh)
local state=YuLingZhaiModel:getHealType()
self.yuLingZhaiBtn:setActive(state==1)
if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:refreshArenaCompensationBtn(needQuickRefresh)
local hasCompensation=xianJieArenaActModel:checkArenaHasCompensation()
self.arenaCompensationBtn:setActive(hasCompensation)
if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:refreshGateApplyBtn(needQuickRefresh)
local showGateApplyBtn=xianjieModel:checkIsShowGateApplyBtn()
local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
local check
if showGateApplyBtn then
local num=xianjieModel:checkMoJieGateNotReadAskCountByGateId(selfXmOwnGateId)
check=num>0
local widget=self.gateApplyBtn:getChildWidgetBase()

self.gateApplyBtn:setActive(check)
widget:SetChildActive(3,num>0)
widget:SetChildText(4,num)
else
check=false
self.gateApplyBtn:setActive(check)
end
if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:refreshHQTbtn(needQuickRefresh)
local check=LunHuiDianModel:getHYReddot()
self.HQTBtn:setActive(check)
local btnWidget=self.HQTBtn:getChildWidgetBase()
local widgetId=self.HQTBtn:getID()
self:doPunchRotation_Btn(widgetId,btnWidget,0,check)
if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:refreshServerTransferHistroyBtn(needQuickRefresh)
local check=ServerTransferModel:checkTransferServerHistroyShow()
self.serverTransferHistroyBtn:setActive(check)
if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:refreshServerTransferRewardBtn(needQuickRefresh)
local check=ServerTransferModel:checkTransferServerRewardShow()
self.serverTransferRewardBtn:setActive(check)
if needQuickRefresh~=false then

self:quickRefresh()
end
end



function UIFuncStorageWin:onTuFaBtn()
local data=emergenciesControl:getSettlementData()
if data then
emergenciesControl:showSettlement(data)
self.tuFaBtn:setActive(false)
else
logErr('无突发事件结算数据')
end
end

function UIFuncStorageWin:onFastManagerBtn()
UIManager:showWindow('UIXiaoDaoTongMainWin',{page=self.fastMarPage})
end

function UIFuncStorageWin:onPaiQianLuBtn()
UIManager:showWindow("UIWorldFightRecordWin")
end

function UIFuncStorageWin:onXianmengInviteBtn()
local num=xianmengModel:getInvitationCount()
if num>0 then
UIManager:showWindow('UIXianMengInviteWin')
end
end

function UIFuncStorageWin:onXmdgRewardBtn()
xianmengdigongController:openEventRewardWin()
end

function UIFuncStorageWin:onZbgRewardBtn()
UIFullRechargeController:showXianGouLiBaoWin()
UIManager:showWindow("UIZhenBaoGeWin",true)
end

function UIFuncStorageWin:onCoupleRequestBtn()
UIManager:showWindow("UIDiscipleRequestCoupleListWin")
end


function UIFuncStorageWin:onArenaCompensationBtn()
xianJieArenaActController:openArenaCompensationWin()
end

function UIFuncStorageWin:showDoingInfo()
self.isShowInfo=not self.isShowInfo
local isShowInfo=self.isShowInfo
local widget=self.shiWuBtn:getChildWidgetBase()
widget:SetChildActive(8,isShowInfo)
end

function UIFuncStorageWin:freshDoingInfo(list)
local root=self.shiWuBtn:getChildWidgetBase()
for i,v in ipairs(self.infoList)do
local eventInfo=list[i]
root:SetChildActive(v,eventInfo~=nil)
if eventInfo then
local name=eventConfig.getEventOptionName(eventInfo.eventid)
local leftTime=eventInfo.eventtime+eventInfo.waitTime-timeHelper.getServerShortTime()
local widget=root:GetChildWidgetBase(v)
widget:SetChildText(0,name)
widget:SetChildText(1,timeHelper.format_time_stamp3(leftTime))
end
end
end

function UIFuncStorageWin:freshDoingTime(list)
local root=self.shiWuBtn:getChildWidgetBase()
local refreshCount=0
for i,v in ipairs(self.infoList)do
local eventInfo=list[i]
if eventInfo then
local leftTime=eventInfo.eventtime+eventInfo.waitTime-timeHelper.getServerShortTime()
if leftTime>=0 then
refreshCount=refreshCount+1
local widget=root:GetChildWidgetBase(v)
widget:SetChildText(1,timeHelper.format_time_stamp3(leftTime))
end
end
end

if refreshCount<=0 then

self:clearSWTimer()
end
end

function UIFuncStorageWin:clearSWTimer()
if self.swTimer then
self:stopTimerByID(self.swTimer)
self.swTimer=nil
end
end






function UIFuncStorageWin:onShiWuBtn()
local isHideShanMen=shanmenModel:getIsShanMenModelHide()
if isHideShanMen then
return
end

local eventType=self.state
if eventType==EVENT_OPTION_STATE.eFinish then
local eventInfo=eventOptionModel.getOneDoingOptionEvent()
local eventId=eventInfo.eventid
local eventguid=eventInfo.eventguid
local optionList=eventInfo.optionList
local optionid=optionList[1]

local dispatch=eventConfig.getOptionDispatch(eventId,optionid)
local isMiJingEvent=eventConfig.checkIsFinishMiJingEventOption(eventId,optionid)
if dispatch or isMiJingEvent then

eventProtocolControl.reqEventPrize(eventguid)
else

eventOptionControl:onRecvEventPrize(eventguid)
end
elseif eventType==EVENT_OPTION_STATE.eUnHand then






elseif eventType==EVENT_OPTION_STATE.eWaitChoice then

shanmenController:playSMAnim(SHANMEN_TYPE.eOptionEvent)

UIManager.info("有客前来拜访，请点击查看")
elseif eventType==EVENT_OPTION_STATE.eWaitFinishMiJing then

local eventInfo=eventOptionModel.getOneDoingOptionEvent()
local optionList=eventInfo.optionList
local eventId=eventInfo.eventid
local optionid=optionList[1]
local miJingIdList=eventConfig.getEventOptionMiJingIdList(eventId,optionid)
local miJingId=miJingIdList[1]
UIManager:showWindow('UIMiJingInfoShowWin',{miJingId=miJingId})

elseif eventType==EVENT_OPTION_STATE.eDoing then







local list=eventOptionModel.getDoingOptions()
self:showDoingInfo()
if self.isShowInfo then
self:freshDoingInfo(list)
self:clearSWTimer()
self.swTimer=self:setTimer(1,0,function()
self:freshDoingTime(list)
end)
end

elseif eventType==EVENT_OPTION_STATE.eNone then






end
end

function UIFuncStorageWin:hindAndShowFuncList(flag)
self:changeFuncListShow(flag)
end

function UIFuncStorageWin:onFuncListbtn()
self:changeFuncListShow(not self.bShowFuncList)
end

function UIFuncStorageWin:onUnderAttackBtn()

local tabType=xianjieModel:getFirstTabType()
if tabType==ATTACKTABTYPE.eMJ then
jumpManager:jump({id=JUMP_TYPE.eXianJieAttackerWin,args={mapid=xjJumpSceneType.eMoJie,tabType=tabType}})
elseif tabType==ATTACKTABTYPE.eMG then
jumpManager:jump({id=JUMP_TYPE.eXianJieAttackerWin,args={mapid=xjJumpSceneType.eMoGong,tabType=tabType}})
else
jumpManager:jump({id=JUMP_TYPE.eXianJieAttackerWin,args={mapid=xjJumpSceneType.eSelfZMPos}})
end
end

function UIFuncStorageWin:onXianjieRiZhiBtn()
xianjieController:OpenZhengZhanShanHaiMonsterLog()
end

function UIFuncStorageWin:onXianjieJieYinBtn()

UIManager:showWindow("UIXianJieJieYin_SupportWin")
end

function UIFuncStorageWin:onServerTransferHistroyBtn()
UIFullServerTransferControl:openServerTransferHistroyWindow()
end

function UIFuncStorageWin:onServerTransferRewardBtn()
xianmengController:reqXMList()
UIFullServerTransferControl:openServerTransferRewardWindow()
end

function UIFuncStorageWin:clearFLTweener()
if self.flTweener then
self.flTweener:Kill()
self.flTweener=nil
end
end

function UIFuncStorageWin:changeFuncListShow(isShow)
if self.bShowFuncList==isShow then
return
end

self:clearFLTweener()
if isShow then
self.funcList:setActive(true)
self.flTweener=self.funcList:setChildCanvasGroupDOFade(1,0.5,nil)
self.funcListReddot:setActive(false)
else
self.flTweener=self.funcList:setChildCanvasGroupDOFade(0,0.5,function()
self.funcList:setActive(false)
end)
end
self.bShowFuncList=isShow
self.funcListbtnselect:setActive(self.bShowFuncList)
simpleModeControl:setFuncStorageSimple(self.bShowFuncList)
self:refresh()
if not self.bShowFuncList then
self:refreshReddot()
end


UIManager:invokeUIMethod("UIMain","freshSimpleBtn")
end

function UIFuncStorageWin:doPunchRotation(reddot)
if webGLHelper:isHidePunchAni()then return end
if reddot then
if self.reddotTweener==nil then
self.funcListReddot:setRotation(0,0,0)
local tweener=self.funcListReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.funcListReddot:setRotation(0,0,0)
end
end
end

function UIFuncStorageWin:doPunchRotation_Btn(widgetId,btnWidget,index,reddot)
if webGLHelper:isHidePunchAni()then return end
if not self.reddotTweener_BtnList then
self.reddotTweener_BtnList={}
end

if reddot then
if self.reddotTweener_BtnList[widgetId]==nil then
btnWidget:SetChildRotation(index,0,0,0)
local tweener=btnWidget:SetChildDOPunchRotation(index,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener_BtnList[widgetId]={}
self.reddotTweener_BtnList[widgetId].tweener=tweener
self.reddotTweener_BtnList[widgetId].cmpIndex=index
self.reddotTweener_BtnList[widgetId].btnWidget=btnWidget
btnWidget:SetChildActive(index,true)
end
else
if self.reddotTweener_BtnList[widgetId]~=nil then
btnWidget:SetChildActive(index,false)
local tweener=self.reddotTweener_BtnList[widgetId].tweener
tweener:Complete()
tweener:Kill()
self.reddotTweener_BtnList[widgetId]=nil
btnWidget:SetChildRotation(index,0,0,0)
end
end
end

function UIFuncStorageWin:clearTweener_AllBtn()
if not self.reddotTweener_BtnList then
return
end

for widgetId,v in pairs(self.reddotTweener_BtnList)do
local tweener=v.tweener
local cmpIndex=v.cmpIndex
local btnWidget=v.btnWidget
btnWidget:SetChildActive(cmpIndex,false)
tweener:Complete()
tweener:Kill()
btnWidget:SetChildRotation(cmpIndex,0,0,0)
self.reddotTweener_BtnList[widgetId]=nil
end
end


function UIFuncStorageWin:onEmailBtn()
local reddot=mailController:hasReddot()
if reddot then
mailController:showMailUI()
end
end





function UIFuncStorageWin:onSystemZongMenFightBtn()
local temp=self.systemZongMenPlayFight
if temp then
systemZongMenController:playFightBattle(temp,true)
else
local width=self.funcList:getChildSizeDeltaX()
local listPos=self.funcList:getChildAnchoredPosition()
local btnPos=self.systemZongMenFightBtn:getChildAnchoredPosition()
listPos.x=listPos.x-width+btnPos.x-10
if self.systemZongMenFlagType==systemZongMenFightFlagType.eBeAttacked then
UIManager:showWindow("UISystemZongMenFightingAttackWin",{arrow=listPos})
elseif self.systemZongMenFlagType==systemZongMenFightFlagType.eAttacking then
UIManager:showWindow("UISystemZongMenFightingDefenseWin",{arrow=listPos})
else
UIManager.error("暂无战争事务")
end
end
end

function UIFuncStorageWin:refreshSystemZongMenFightBtn(needQuickRefresh)


local refreshFunc=function()
if needQuickRefresh~=false then

return self:quickRefresh()
end
end

self.systemZongMenPlayFight=nil
self.systemZongMenFlagType=nil
local widget=self.systemZongMenFightBtn:getChildWidgetBase()
if not systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)then
self.systemZongMenFightBtn:setActive(false)
return refreshFunc()
end

local resultList=systemZongMenModel:getAllWaitNotifyResult()
if next(resultList)~=nil then
self.systemZongMenFightBtn:setActive(true)
self:stopSystemZongMenFightCDTimer()

local temp=nil
for key,data in pairs(resultList)do
if data.teamIndex==0 then
self.systemZongMenFlagType=systemZongMenFightFlagType.eAttacking
self.systemZongMenPlayFight=key
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_2")
widget:SetChildText(1,"<color=#BC4F4F>队伍战斗中</color>")
return refreshFunc()
else
temp=key
end
end

if temp then
self.systemZongMenFlagType=systemZongMenFightFlagType.eBeAttacked
self.systemZongMenPlayFight=temp
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_1")
widget:SetChildText(1,"<color=#BC4F4F>队伍战斗中</color>")

else
self.systemZongMenFlagType=systemZongMenFightFlagType.eNone
widget:SetChildCSImageIcon(0,"",true)
widget:SetChildText(1,"战况")
end
return refreshFunc()
end


local teamList=systemZongMenModel:getAllBattleWaitResult()
if#teamList>0 then
self.systemZongMenFightBtn:setActive(true)

local firstStamp=nil
for index,data in ipairs(teamList)do
if data.teamIndex==0 then
self.systemZongMenFlagType=systemZongMenFightFlagType.eAttacking
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_2")
self.systemZongMenFightDeadline=data.gameStamp
self:startSystemZongMenFightCDTimer()
return refreshFunc()
else
firstStamp=firstStamp and math.min(firstStamp,data.gameStamp)or data.gameStamp
end
end

if firstStamp then
self.systemZongMenFlagType=systemZongMenFightFlagType.eBeAttacked
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_1")
self.systemZongMenFightDeadline=firstStamp
self:startSystemZongMenFightCDTimer()

else
self.systemZongMenFlagType=systemZongMenFightFlagType.eNone
self:stopSystemZongMenFightCDTimer()
widget:SetChildCSImageIcon(0,"",true)
widget:SetChildText(1,"战况")
end
return refreshFunc()
end


local attackFlag=systemZongMenModel:isExistFightFlag(systemZongMenFightFlagType.eBeAttacked)
local defenseFlag=systemZongMenModel:isExistFightFlag(systemZongMenFightFlagType.eAttacking)
local haveFight=attackFlag or defenseFlag
self.systemZongMenFightBtn:setActive(haveFight)
if attackFlag then
self.systemZongMenFlagType=systemZongMenFightFlagType.eBeAttacked
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_1")
widget:SetChildText(1,"未派遣队伍")

elseif defenseFlag then
self.systemZongMenFlagType=systemZongMenFightFlagType.eAttacking
widget:SetChildCSImageSprite(0,globalABLookup.global,"image_gongfangbj_2")
widget:SetChildText(1,"宗门来袭")
else
self.systemZongMenFlagType=systemZongMenFightFlagType.eNone
widget:SetChildCSImageIcon(0,"",true)
widget:SetChildText(1,"战况")
end
self:stopSystemZongMenFightCDTimer()
return refreshFunc()
end

function UIFuncStorageWin:startSystemZongMenFightCDTimer()
if not self.systemZongMenFightCDTimer then
if self:updateSystemZongMenFightCDTimer()then
self.systemZongMenFightCDTimer=self:setTimer(1,0,function()
if not self:updateSystemZongMenFightCDTimer()then
self:stopSystemZongMenFightCDTimer()
end
end)
end
end
end

function UIFuncStorageWin:stopSystemZongMenFightCDTimer()
if self.systemZongMenFightCDTimer then
self:stopTimerByID(self.systemZongMenFightCDTimer)
self.systemZongMenFightCDTimer=nil
end
end

function UIFuncStorageWin:updateSystemZongMenFightCDTimer()
local nowTime=timeHelper.getServerShortTime()
local deltaTime=self.systemZongMenFightDeadline-nowTime
local widget=self.systemZongMenFightBtn:getChildWidgetBase()
if deltaTime<0 then

widget:SetChildText(1,"<color=#BC4F4F>即将战斗</color>")
return false
else
local str=FMT.fmt("<color=#94C547>{0}</color>到达",timeHelper.format_time_stamp(deltaTime,true))
widget:SetChildText(1,str)
return true
end
end

function UIFuncStorageWin.onSystemZMFightRecordNew()
_this:refreshSystemZongMenFightBtn(false)
_this:quickRefresh()
end

function UIFuncStorageWin.onSystemZMFightResultNew()
_this:refreshSystemZongMenFightBtn(false)
_this:quickRefresh()
end

function UIFuncStorageWin.onSystemZMFightWaitResultNew()
_this:refreshSystemZongMenFightBtn(false)
_this:quickRefresh()
end

function UIFuncStorageWin.onSystemZMFightFlagChanged(serial,oldFlag,newFlag)
if systemZongMenModel:isFightingAboutFlag(oldFlag)or systemZongMenModel:isFightingAboutFlag(newFlag)then
_this:refreshSystemZongMenFightBtn(false)
end
if oldFlag==systemZongMenFightFlagType.eSurrender or newFlag==systemZongMenFightFlagType.eSurrender then
_this:refreshSystemZongMenSurrenderBtn(false)
end
_this:quickRefresh()
end

function UIFuncStorageWin.onSystemZMInit()
_this:refreshSystemZongMenFightBtn(false)
_this:refreshSystemZongMenSGBtn(false)
_this:quickRefresh()
end

function UIFuncStorageWin:onSystemZongMenSGBtn()
if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
local disciplelist=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)or{}
local disciples=disciplelist[1]
if not disciples then
disciples=UIDiscipleModel:getPlotDiscipleByIndex(1)
end



local callback=function()
systemZongMenController:quickReqRewardVassal()
end


local args={
groupid=180001,
callback=callback,
isFullOpen=false,
npcData={zmDisciple=disciples},
}
gameplotController:showPlotBoard(args)
else
local width=self.funcList:getChildSizeDeltaX()
local listPos=self.funcList:getChildAnchoredPosition()
local btnPos=self.systemZongMenSGBtn:getChildAnchoredPosition()
listPos.x=listPos.x-width+btnPos.x-10
UIManager:showWindow("UISystemZongMenVassalRewardWin",{arrow=listPos})
end
end

function UIFuncStorageWin:refreshSystemZongMenSGBtn(needQuickRefresh)

local show=systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)and systemZongMenModel:haveSGReward()
self.systemZongMenSGBtn:setActive(show)
local btnWidget=self.systemZongMenSGBtn:getChildWidgetBase()
local widgetId=self.systemZongMenSGBtn:getID()
self:doPunchRotation_Btn(widgetId,btnWidget,0,show)

if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin.onSystemZMVassalRewardChange(serial,oldNum,newNum)
if oldNum<=0 and newNum>0 then
_this:refreshSystemZongMenSGBtn(false)
elseif oldNum>0 and newNum<=0 then
_this:refreshSystemZongMenSGBtn(false)
end
_this:quickRefresh()
end

function UIFuncStorageWin:refreshSystemZongMenSurrenderBtn(needQuickRefresh)
if not systemModel.isOpen(SYSTEM_DEFINE.eXiTongZongMenZhanDou)then
self.systemZongMenSurrenderBtn:setActive(false)
else
local show=systemZongMenModel:isExistFightFlag(systemZongMenFightFlagType.eSurrender)
self.systemZongMenSurrenderBtn:setActive(show)

local btnWidget=self.systemZongMenSurrenderBtn:getChildWidgetBase()
local widgetId=self.systemZongMenSurrenderBtn:getID()
self:doPunchRotation_Btn(widgetId,btnWidget,0,show)
end

if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:onSystemZongMenSurrenderBtn()

local width=self.funcList:getChildSizeDeltaX()
local listPos=self.funcList:getChildAnchoredPosition()
local btnPos=self.systemZongMenSurrenderBtn:getChildAnchoredPosition()
listPos.x=listPos.x-width+btnPos.x-10
UIManager:showWindow("UISystemZongMenSurrenderListWin",{arrow=listPos})
end

function UIFuncStorageWin:onSystemZongMenLetterBtn()
UIManager:showWindow("UISystemZongMenLetterDialog")
end

function UIFuncStorageWin:refreshSystemZongMenLetterBtn(needQuickRefresh)
local exsit=systemZongMenModel:exsitALetter()
self.systemZongMenLetterBtn:setActive(exsit)

if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin.onSystemZMLetterChange(flag)
_this:refreshSystemZongMenLetterBtn(false)
_this:quickRefresh()
end

function UIFuncStorageWin.onTianMoJieMonsterChange(actorid)
if playerModel:checkActorId(actorid)then
_this:refreshTianMoJieBtn(false)
_this:quickRefresh()
end
end

function UIFuncStorageWin.on_35_8()
_this:refreshXiJiBtn(false)
_this:quickRefresh()
end

function UIFuncStorageWin.onXiaoZhuShouFinish()
_this:quickRefresh()
end

function UIFuncStorageWin.onXiaoZhuShouStop()
_this:quickRefresh()
end

function UIFuncStorageWin:onTianMoJieBtn()
local width=self.funcList:getChildSizeDeltaX()
local listPos=self.funcList:getChildAnchoredPosition()
local btnPos=self.systemZongMenSurrenderBtn:getChildAnchoredPosition()
listPos.x=listPos.x-width+btnPos.x-10
UIManager:showWindow("UITianMoJieMonsterListWin2",{arrow=listPos})
end

function UIFuncStorageWin:startLeftTimer(widgetId,widget,rootIdx,tIdx,func)
if self.timerList==nil then self.timerList={}end
self:stopLeftTimer(widgetId)
local lefTime=func()
if lefTime<=0 then
widget:SetChildActive(rootIdx,false)
return
end
widget:SetChildActive(rootIdx,true)
local tick=function()
local lefTime=func()
if lefTime>0 then
widget:SetChildText(tIdx,FMT.fmt("<color=#a1ec58>{0}</color>",timeHelper.format_time_stamp12(lefTime)))
else
widget:SetChildActive(rootIdx,false)
self:stopLeftTimer(widgetId)
end
end
self.timerList[widgetId]=self:setTimer(1,0,tick)
tick()
end

function UIFuncStorageWin:stopLeftTimer(widgetId)
if self.timerList==nil then return end
if self.timerList[widgetId]then
self:stopTimerByID(self.timerList[widgetId])
self.timerList[widgetId]=nil
end
end

function UIFuncStorageWin:onXingyuBtn()
XingYuController.showGetReward()
end

function UIFuncStorageWin:onYuLingZhaiBtn()
UIFullYuLingZhaiControl:showMainWindow()
end

function UIFuncStorageWin:refreshMoJieRewardBtn(needQuickRefresh)
self.mojieRewardBtn:setActive(false)
if needQuickRefresh~=false then

self:quickRefresh()
end
end

function UIFuncStorageWin:onMojieRewardBtn()

end

function UIFuncStorageWin:onGateApplyBtn()
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
return
end

local selfXmOwnGateId=xianjieModel:getMoJieGateSelfXmOwnGateId()
local jumpFunc=function()
xianjieController:jumpMoJieGateByGateId(selfXmOwnGateId,true,true)
end

local sceneType=xianjieModel:getScenceType()
if not sceneType or not xianjienSceneType:isMoJie(sceneType)then

local content="关口通行簿需前往魔界查看，是否前往？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=jumpFunc,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return false
else
jumpFunc()
return true
end
end


function UIFuncStorageWin:onHQTBtn()
LunHuiDianModel:jumpHQTWin()
end



function UIFuncStorageWin:registerAllButton()
registerFuncButton(eFuncBtnEnum.arenaCompensationBtn,self.arenaCompensationBtn)
registerFuncButton(eFuncBtnEnum.zbgRewardBtn,self.zbgRewardBtn)
registerFuncButton(eFuncBtnEnum.yuLingZhaiBtn,self.yuLingZhaiBtn)
registerFuncButton(eFuncBtnEnum.xmdgRewardBtn,self.xmdgRewardBtn)
registerFuncButton(eFuncBtnEnum.xingyuBtn,self.xingyuBtn)
registerFuncButton(eFuncBtnEnum.xianmengInviteBtn,self.xianmengInviteBtn)
registerFuncButton(eFuncBtnEnum.XianjieRiZhiBtn,self.XianjieRiZhiBtn)
registerFuncButton(eFuncBtnEnum.xianjieJieYinBtn,self.xianjieJieYinBtn)
registerFuncButton(eFuncBtnEnum.underAttackBtn,self.underAttackBtn)
registerFuncButton(eFuncBtnEnum.tuFaBtn,self.tuFaBtn)
registerFuncButton(eFuncBtnEnum.tianMoJieBtn,self.tianMoJieBtn)
registerFuncButton(eFuncBtnEnum.systemZongMenSurrenderBtn,self.systemZongMenSurrenderBtn)
registerFuncButton(eFuncBtnEnum.systemZongMenSGBtn,self.systemZongMenSGBtn)
registerFuncButton(eFuncBtnEnum.systemZongMenLetterBtn,self.systemZongMenLetterBtn)
registerFuncButton(eFuncBtnEnum.systemZongMenFightBtn,self.systemZongMenFightBtn)
registerFuncButton(eFuncBtnEnum.shiWuBtn,self.shiWuBtn)
registerFuncButton(eFuncBtnEnum.serverTransferRewardBtn,self.serverTransferRewardBtn)
registerFuncButton(eFuncBtnEnum.serverTransferHistroyBtn,self.serverTransferHistroyBtn)
registerFuncButton(eFuncBtnEnum.paiQianLuBtn,self.paiQianLuBtn)
registerFuncButton(eFuncBtnEnum.mojieRewardBtn,self.mojieRewardBtn)
registerFuncButton(eFuncBtnEnum.HQTBtn,self.HQTBtn)
registerFuncButton(eFuncBtnEnum.gateApplyBtn,self.gateApplyBtn)
registerFuncButton(eFuncBtnEnum.fastManagerBtn,self.fastManagerBtn)
registerFuncButton(eFuncBtnEnum.emailBtn,self.emailBtn)
registerFuncButton(eFuncBtnEnum.coupleRequestBtn,self.coupleRequestBtn)
end

function UIFuncStorageWin:quickRefresh()
self:handleFuncButtonVisibility()
self:updateCountIconDisplay()
end

function UIFuncStorageWin:handleFuncButtonVisibility()

for _,index in pairs(eFuncBtnEnum)do
funcButtonHandler[index]:refreshState(_this)
end

local visibleBtnCount=0
for _,index in pairs(eFuncBtnEnum)do
if funcButtonHandler[index]:isActive()then
visibleBtnCount=visibleBtnCount+1
end
end

self.visibleBtnCount=visibleBtnCount

local viewWidth=self:getFuncBtnViewWidth(visibleBtnCount)
viewWidth=math.max(90,math.min(viewWidth,funcBtnViewMaxWidth))
self.funcList:setChildSizeDelta(viewWidth,buttonWidth)
end

function UIFuncStorageWin:getFuncBtnViewWidth(buttonCount)
local width=buttonScollSpacing_left+buttonScollSpacing_right
local showBtnCount=math.min(buttonCount,maxShowBtnCount)
for i=1,showBtnCount do
width=width+buttonWidth+buttonSpacing
end

if buttonCount>3 then
width=width+buttonWidth/2
end

return width
end

function UIFuncStorageWin:updateCountIconDisplay()
if self.visibleBtnCount~=nil then
self.countIcon:setActive(self.visibleBtnCount>3)
self.countTex:setText(self.visibleBtnCount)
end
end


