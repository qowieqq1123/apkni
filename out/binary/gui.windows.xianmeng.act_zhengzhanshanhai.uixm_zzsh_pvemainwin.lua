







def_class("UIXM_ZZSH_PvEMainWin",UIWindowBase)









function UIXM_ZZSH_PvEMainWin:bindComponents()

self.bottomPanel=UIObject.get(self,0)
self.boxBtn=UIButton.get(self,1)
self.boxNumObj=UIObject.get(self,2)
self.boxNumTxt=UIText.get(self,3)
self.buffBtn=UIButton.get(self,4)
self.infoBtn=UIButton.get(self,5)
self.infoBtnReddot=UIObject.get(self,6)
self.jijieBtn=UIButton.get(self,7)
self.jijieNumObj=UIObject.get(self,8)
self.jijieNumTxt=UIText.get(self,9)
self.leftModel2Panel=UIObject.get(self,10)
self.leftModel3Panel=UIObject.get(self,11)
self.leftPanel=UIObject.get(self,12)
self.money1Root=UIObject.get(self,13)
self.moveBtn=UIButton.get(self,14)
self.noteBtn=UIButton.get(self,15)
self.noteBtnReddot=UIObject.get(self,16)
self.rightPanel=UIObject.get(self,17)
self.root=UIObject.get(self,18)
self.setBtn=UIButton.get(self,19)
self.setbydBtn=UIButton.get(self,20)
self.shopBtn=UIButton.get(self,21)
self.signBtn=UIButton.get(self,22)
self.teamBtn=UIButton.get(self,23)
self.teamWPBtn=UIButton.get(self,24)
self.teamWPNumObj=UIObject.get(self,25)
self.teamWPNumTxt=UIText.get(self,26)
self.teamWPPanel=UIObject.get(self,27)
self.topPanel=UIObject.get(self,28)
self.weekTask=UIButton.get(self,29)
self.weekTasknumTxt=UIText.get(self,30)
self.weekTaskReddot=UIObject.get(self,31)
self.weekTaskTips=UIText.get(self,32)
self.ybdred=UIObject.get(self,33)
self.zhanlingBtn=UIButton.get(self,34)
self.zhanlingReddot=UIObject.get(self,35)

self.boxBtn:setButtonClick(function()self:onBoxBtn()end)

self.buffBtn:setButtonClick(function()self:onBuffBtn()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.jijieBtn:setButtonClick(function()self:onJijieBtn()end)

self.moveBtn:setButtonClick(function()self:onMoveBtn()end)

self.noteBtn:setButtonClick(function()self:onNoteBtn()end)

self.setBtn:setButtonClick(function()self:onSetBtn()end)

self.setbydBtn:setButtonClick(function()self:onSetbydBtn()end)

self.shopBtn:setButtonClick(function()self:onShopBtn()end)

self.signBtn:setButtonClick(function()self:onSignBtn()end)

self.teamBtn:setButtonClick(function()self:onTeamBtn()end)

self.teamWPBtn:setButtonClick(function()self:onTeamWPBtn()end)

self.weekTask:setButtonClick(function()self:onWeekTask()end)

self.zhanlingBtn:setButtonClick(function()self:onZhanlingBtn()end)



end


function UIXM_ZZSH_PvEMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.boxBtn);self.boxBtn=nil;
_UIObject_release(self.boxNumObj);self.boxNumObj=nil;
_UIObject_release(self.boxNumTxt);self.boxNumTxt=nil;
_UIObject_release(self.buffBtn);self.buffBtn=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.infoBtnReddot);self.infoBtnReddot=nil;
_UIObject_release(self.jijieBtn);self.jijieBtn=nil;
_UIObject_release(self.jijieNumObj);self.jijieNumObj=nil;
_UIObject_release(self.jijieNumTxt);self.jijieNumTxt=nil;
_UIObject_release(self.leftModel2Panel);self.leftModel2Panel=nil;
_UIObject_release(self.leftModel3Panel);self.leftModel3Panel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.moveBtn);self.moveBtn=nil;
_UIObject_release(self.noteBtn);self.noteBtn=nil;
_UIObject_release(self.noteBtnReddot);self.noteBtnReddot=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.setBtn);self.setBtn=nil;
_UIObject_release(self.setbydBtn);self.setbydBtn=nil;
_UIObject_release(self.shopBtn);self.shopBtn=nil;
_UIObject_release(self.signBtn);self.signBtn=nil;
_UIObject_release(self.teamBtn);self.teamBtn=nil;
_UIObject_release(self.teamWPBtn);self.teamWPBtn=nil;
_UIObject_release(self.teamWPNumObj);self.teamWPNumObj=nil;
_UIObject_release(self.teamWPNumTxt);self.teamWPNumTxt=nil;
_UIObject_release(self.teamWPPanel);self.teamWPPanel=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.weekTask);self.weekTask=nil;
_UIObject_release(self.weekTasknumTxt);self.weekTasknumTxt=nil;
_UIObject_release(self.weekTaskReddot);self.weekTaskReddot=nil;
_UIObject_release(self.weekTaskTips);self.weekTaskTips=nil;
_UIObject_release(self.ybdred);self.ybdred=nil;
_UIObject_release(self.zhanlingBtn);self.zhanlingBtn=nil;
_UIObject_release(self.zhanlingReddot);self.zhanlingReddot=nil;
end
















local _this=nil
local rankIconlp={
'image_shanhaisjui_4','image_shanhaisjui_5','image_shanhaisjui_6'
}
local stringF=string.format

function UIXM_ZZSH_PvEMainWin:onLoaded(...)
_this=self
self:bindComponents()

self.buffBtn:setActive(UILSZDControl:isLingShanOpen())

self:setAsFirstSibling(-1)
self:addNotify(notifyConfig.onZZSHPvETeamChange,self.onZZSHPvETeamChange)
self:addNotify(notifyConfig.onZZSHPvEWaiPaiChange,self.onZZSHPvEWaiPaiChange)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onBaoXiaReddotChange,self.onBaoXiaReddotChange)
self:addNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange,self.onZhengZhanShanHaiLogReddotChange)
self:addNotify(notifyConfig.onZZSH_WeekTaskReddot,self.onZZSH_WeekTaskReddot)



end


function UIXM_ZZSH_PvEMainWin:__delete()
_this=nil
self:unbindComponents()
UIManager:closeWindow('UIXM_ZZSH_selfPVETeamWin')
UIManager:closeWindow('UIXM_ZZSH_settingWin')
end


function UIXM_ZZSH_PvEMainWin:onHide()

end

function UIXM_ZZSH_PvEMainWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
if moneyType==eMoneyType.mtXuKongLing then
_this:refreshMoney()
end
end




function UIXM_ZZSH_PvEMainWin:onShow(argtable,afterOnloaded)
self.openTeam=zhengzhanshanhaiModel:checkpveMainOpenTeamFlag()
if zhengzhanshanhaiModel:checkPvETeamsInit()then
self:refreshMyWaiPai()
end
if self.mytimer==nil then
self.mytimer=self:setTimer(1,0,function()
self:refreshTime()
end)
end
self:refreshMyXMJiJie()
self:initMoney()
self:refreshSettingModel()
self:refreshNoteReddot()
self:refreshBaoXiaReddot()
self:refreshQingBaoReddot()

self:checkWeekTaskOpen()
self:checkWeekTaskReddot()
self:refreshSetbyd()
end

function UIXM_ZZSH_PvEMainWin:refreshQingBaoReddot()
self.infoBtnReddot:setActive(self:checkQingBaoReddot())
end

function UIXM_ZZSH_PvEMainWin:checkQingBaoReddot()
local check=UILSZDControl:checkQingBaoReddot()
if check then
return true
end

return false
end

function UIXM_ZZSH_PvEMainWin:refreshTime()
self:refreshAllTeamItemTime()
if self.updataMoveBtn then
self:refreshMoveBtnProgress()
end
end

function UIXM_ZZSH_PvEMainWin:checkClickLock()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<zhengzhanshanhaiModel.clickBtnCoolTime then
return false
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
return true
end




function UIXM_ZZSH_PvEMainWin:setMoneyRootCanves(flag,sortLayer,sortOrder)
if flag then
self.topPanel:setChildCanvas(sortLayer,sortOrder)
else
self.topPanel:setChildRemoveCanvas()
end
end

function UIXM_ZZSH_PvEMainWin:initMoney()
local widget=self.money1Root:getWidgetBase()
local moneyType=eMoneyType.mtXuKongLing
local moneyVal=zhengzhanshanhaiModel:getXuKongLing()
local moneyStr=mathHelper.formatNumber(moneyVal,true)
local max=moneyModel.getMoneyMax(moneyType)
if max then
moneyStr=FMT.fmt('{0}/{1}',moneyStr,max)
end
widget:SetChildIcon(1,iconHelper.getIconName(moneyType),false)
widget:SetChildText(2,moneyStr)
widget:SetChildActive(3,true)
widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onAddClick(moneyType)
end)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:clickMoney(moneyType)
end)
end

function UIXM_ZZSH_PvEMainWin:refreshMoney()
local widget=self.money1Root:getWidgetBase()
local moneyVal=zhengzhanshanhaiModel:getXuKongLing()
local moneyType=eMoneyType.mtXuKongLing
local moneyStr=mathHelper.formatNumber(moneyVal,true)
local max=moneyModel.getMoneyMax(moneyType)
if max then
moneyStr=FMT.fmt('{0}/{1}',moneyStr,max)
end
widget:SetChildText(2,moneyStr)
end

function UIXM_ZZSH_PvEMainWin:onAddClick(moneyType)
self:clickMoney(moneyType)
end

function UIXM_ZZSH_PvEMainWin:clickMoney(moneyType)
gainControl:showGainWin(moneyType)
end



function UIXM_ZZSH_PvEMainWin:refreshMyWaiPai()
self.mPvEWaiPaiList=zhengzhanshanhaiModel:getMyPvEWaiPaiList()
local cur=#self.mPvEWaiPaiList
local showPanel=self.openTeam
self.teamWPPanel:setActive(showPanel)
self.teamWPBtn:setActive(not showPanel)
local showNum=cur>0
if showPanel then
local widget=self.teamWPPanelWidget
if widget==nil then
widget=self.teamWPPanel:getWidgetBase()
self.teamWPPanelWidget=widget
end
if not self.isInitTeamWPPanel then
self.isInitTeamWPPanel=true

widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onTeamWPBtn()
end)

widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onTeamDetailBtn()
end)

widget:SetChildButtonClick(4,function()
if _this==nil then return end
_this:onTeamJumpBtn(1)
end)
widget:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onTeamJumpBtn(2)
end)
end
local max=zhengzhanshanhaiModel:getMaxWaiPaiNum()

local num_str=FMT.fmt('外派队伍({0}/{1})',cur,max)
widget:SetChildText(1,num_str)

widget:SetChildActive(6,showNum)
widget:SetChildActive(3,not showNum)

if showNum then
widget:SetChildLayoutGroupCreateItems(6,cur,function(idx)
if _this==nil then return end
local item=widget:GetChildLayoutGroupGridItem(6,idx-1)
local wpData=_this.mPvEWaiPaiList[idx]

item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onWaiPaiClick(idx)
end)

local rankIcon=rankIconlp[idx]or rankIconlp[#rankIconlp]
item:SetChildCSImageSprite(0,globalABLookup.zzshicons,rankIcon)


local name_str=wpData:getName()
item:SetChildText(1,name_str)

local teamData=wpData:getTeamData()
if teamData then
local state=teamData:getState(true)
item:SetChildText(2,state)
end

self:refreshTeamItemTime(item,idx)
end)
end
else
self.teamWPNumObj:setActive(showNum)
if showNum then
self.teamWPNumTxt:setText(tostring(cur))
end
end
end

function UIXM_ZZSH_PvEMainWin:refreshAllTeamItemTime()
if self.mPvEWaiPaiList and self.openTeam then
local num=#self.mPvEWaiPaiList
if num>0 then
for idx,v in ipairs(self.mPvEWaiPaiList)do
self:refreshTeamItemTime(nil,idx)
end
end
end
end

function UIXM_ZZSH_PvEMainWin:refreshTeamItemTime(item,idx)
if item==nil then
item=self.teamWPPanelWidget:GetChildLayoutGroupGridItem(6,idx-1)
end
if item==nil then return end
local wpData=self.mPvEWaiPaiList[idx]
local teamData=wpData:getTeamData()
if teamData==nil then return end
local state,time=teamData:getState(true)
local time_str
if time>=0 then
time_str=timeHelper.format_time_stamp3(time)
else
time_str=''
end
item:SetChildText(3,time_str)
end

function UIXM_ZZSH_PvEMainWin:onWaiPaiClick(idx)
if not self:checkClickLock()then
return
end
local wpData=self.mPvEWaiPaiList[idx]
if wpData then
local teamData=wpData:getTeamData()
if teamData then
local qbData=teamData:getQingBaoData()
if qbData then
local infotype=qbData.infotype
if infotype==zhengzhanshanhaiModel.qbType.eMonster then

zhengzhanshanhaiModel:checkQingBaoDetail(teamData.guid)




else

zhengzhanshanhaiModel:checkQingBaoDetail(teamData.guid)




end
end
end
end
end

function UIXM_ZZSH_PvEMainWin:refreshMyXMJiJie()
local num=zhengzhanshanhaiModel:getPvEJiJieDatasNum()+zhengzhanshanhaiModel:getPvEBaodiDatasNum()
local showNum=num>0
num=num>99 and 99 or num
self.jijieNumObj:setActive(showNum)
if showNum then
self.jijieNumTxt:setText(tostring(num))
end
end

function UIXM_ZZSH_PvEMainWin:onTeamWPBtn()
if zhengzhanshanhaiModel:checkPvETeamsInit()then
self.openTeam=not self.openTeam
zhengzhanshanhaiModel:setpveMainOpenTeamFlag(self.openTeam)
self:refreshMyWaiPai()
end
end

function UIXM_ZZSH_PvEMainWin:onTeamDetailBtn()
UIManager:showWindow('UIXM_ZZSH_selfPVETeamWin')
end

function UIXM_ZZSH_PvEMainWin:onTeamJumpBtn(typo)
if typo==1 then

UIManager:showWindow('UIXM_ZZSH_entitySelectWin',{page=1})
else

UIManager:showWindow('UIXM_ZZSH_entitySelectWin',{page=2})
end
end

function UIXM_ZZSH_PvEMainWin:onJijieBtn()
if not self:checkClickLock()then
return
end
zhengzhanshanhaiModel:checkPvEJiJie()
end



function UIXM_ZZSH_PvEMainWin.onBaoXiaReddotChange()
if _this==nil then return end
_this:refreshBaoXiaReddot()
end

function UIXM_ZZSH_PvEMainWin:refreshBaoXiaReddot()
local num=zhengzhanshanhaiModel:isBXReddot()
local isshow=num>0
self.boxNumObj:setActive(isshow)
if isshow then
self.boxNumTxt:setText(tostring(num))
end
end

function UIXM_ZZSH_PvEMainWin:onBoxBtn()
UIManager:showWindow('UIXM_ZZSH_TreasureBoxWin')
end





function UIXM_ZZSH_PvEMainWin.onZhengZhanShanHaiLogReddotChange()
if _this==nil then return end
_this:refreshNoteReddot()
end

function UIXM_ZZSH_PvEMainWin:refreshNoteReddot()
local isReddot=zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()
self.noteBtnReddot:setActive(isReddot)
if isReddot then
if self.reddotTweener==nil then
self.noteBtnReddot:setRotation(0,0,0)
local tweener=self.noteBtnReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.noteBtnReddot:setRotation(0,0,0)
end
end
end

function UIXM_ZZSH_PvEMainWin:onNoteBtn()
zhengzhanshanhaiController:OpenZhengZhanShanHaiFightLog()
end





function UIXM_ZZSH_PvEMainWin:onSetBtn()
UIManager:showWindow("UIXM_ZZSH_settingWin")
end

function UIXM_ZZSH_PvEMainWin:refreshSettingModel()
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1

self.leftModel2Panel:setActive(showModel==1)
self.leftModel3Panel:setActive(showModel==1 or showModel==2)

self:refershMoveBtn()
self:refershZhanLing()

self.signBtn:setActive(showModel==1 or showModel==2)
self:refrshTeamBtn()
end





function UIXM_ZZSH_PvEMainWin:onMoveBtn()
local moveTime=zhengzhanshanhaiModel:getPvEMoveTime()
local cur=gameUtilityModel.getServerShortTime()
if moveTime~=nil and cur<moveTime then
local lerp=moveTime-cur
UIManager.error(FMT.fmt('仙盟堡垒移动冷却中，{0}后才能再次移动',timeHelper.format_time_stamp11(lerp,true)))
return
end
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','activeSignModel',true,2)
end

function UIXM_ZZSH_PvEMainWin:refershMoveBtn()
local myActorid=playerModel:getActorID()
local showMove=xianmengModel.checkPostPrivileByActor(myActorid,GUILD_PRIVILE_TYPE.gptZZSHSign)
if showMove then
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1
showMove=showModel==1 or showModel==2
end
self.moveBtn:setActive(showMove)
self.updataMoveBtn=nil
if showMove then
if self.moveBtnWidget==nil then
self.moveBtnWidget=self.moveBtn:getWidgetBase()
end
local moveTime=zhengzhanshanhaiModel:getPvEMoveTime()
local cur=gameUtilityModel.getServerShortTime()
if moveTime~=nil and cur<moveTime then
self.updataMoveBtn=true
self.moveBtnWidget:SetChildActive(0,true)
self.moveBtnWidget:SetChildImageExGray(2,true)
self:refreshMoveBtnProgress(moveTime-cur)
else
self:refreshMoveBtnProgress(0)
end
end
end

function UIXM_ZZSH_PvEMainWin:refreshMoveBtnProgress(lerp)
if lerp==nil then
local moveTime=zhengzhanshanhaiModel:getPvEMoveTime()
local cur=gameUtilityModel.getServerShortTime()
lerp=moveTime-cur
if lerp<0 then lerp=0 end
end
if lerp>0 then
local move=zhengzhanshanhaiModel:getPvEMoveCoolTime()
local rate=(move-lerp)/move
self.moveBtnWidget:SetChildIconFillAmount(1,rate)
self.moveBtnWidget:SetChildText(3,timeHelper.format_time_stamp(lerp,true))
else
self.moveBtnWidget:SetChildActive(0,false)
self.moveBtnWidget:SetChildImageExGray(2,false)
self.moveBtnWidget:SetChildText(3,'')
self.updataMoveBtn=nil
end
end





function UIXM_ZZSH_PvEMainWin:onTeamBtn()
if not self:checkClickLock()then
return
end
zhengzhanshanhaiModel:checkOpenSelectTeamWin(1)
end

function UIXM_ZZSH_PvEMainWin:refrshTeamBtn()
local isShow=false
if not zhengzhanshanhaiModel.maskPvP then
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1
isShow=showModel==1 or showModel==2
end
self.teamBtn:setActive(isShow)
end



function UIXM_ZZSH_PvEMainWin:onInfoBtn()
UIManager:showWindow('UIXM_ZZSH_entitySelectWin')
end

function UIXM_ZZSH_PvEMainWin:onSignBtn()
UIManager:invokeUIMethod('UIXM_ZZSH_MapWin','activeSignModel',true,1)
end

function UIXM_ZZSH_PvEMainWin.onZZSHPvETeamChange(opType,teamData)
if _this==nil or not _this.isVisible then return end
if opType==zhengzhanshanhaiModel.opType.eInit then
_this:refreshMyWaiPai()
_this:refreshMyXMJiJie()
elseif opType==zhengzhanshanhaiModel.opType.eDel then
if teamData:isMyXMTeam()then
_this:refreshMyXMJiJie()
zhengzhanshanhaiModel:needrefresh()
end
elseif opType==zhengzhanshanhaiModel.opType.eAdd then
if teamData:isMyXMTeam()then
_this:refreshMyXMJiJie()
zhengzhanshanhaiModel:needrefresh()
end
end
end

function UIXM_ZZSH_PvEMainWin.onZZSHPvEWaiPaiChange(opType,qbGuid)
if _this==nil or not _this.isVisible then return end

_this:refreshMyWaiPai()
end

function UIXM_ZZSH_PvEMainWin:rec_myWaiPiaList()
if zhengzhanshanhaiModel:checkPvETeamsInit()then
self:refreshMyWaiPai()
end
end


function UIXM_ZZSH_PvEMainWin:onWeekTask()
UIManager:showWindow('UIXM_ZZSH_WeekTaskWin')
end


function UIXM_ZZSH_PvEMainWin:onZhanlingBtn()


UIFullSHZhanLingController:showMainWindow({tabType=FULL_TAB_TYPE.eSHZhanLing,nextFunc=function()
zhengzhanshanhaiController:finishFightOpen({showCloud=false})
end})
end

function UIXM_ZZSH_PvEMainWin:refershZhanLing()







self.zhanlingBtn:setActive(false)
end









function UIXM_ZZSH_PvEMainWin.onZZSH_WeekTaskReddot()
_this:checkWeekTaskOpen()
end


function UIXM_ZZSH_PvEMainWin:checkWeekTaskOpen()
local SystemOpen=zhengzhanshanhaiController:checkSystemOpen_weekTask()
self.weekTask:setActive(SystemOpen)
if SystemOpen then
_this:checkWeekTaskReddot()
local IsShowTask=zhengzhanshanhaiModel:getIsShowTask()
if IsShowTask then
if zhengzhanshanhaiModel:checkWeekTaskAllComplete()then
self.weekTasknumTxt:setText("已完成全部任务")
else
self.taskList=zhengzhanshanhaiModel:getSortTaskList()
if self.taskList then
local fristTaskData=self.taskList[1].Data
local complete_cnt,rewardflag,needComplete_cnt=zhengzhanshanhaiModel:getComplete_cntAndrewardflag(fristTaskData)
local curCfg=zhengzhanshanhaiController:getZZSHCfg_weekTask(fristTaskData.id)
local desc
if complete_cnt>=needComplete_cnt then
desc=stringF("\n(<color=%s>%s</color>)",FONT_COLOR_VAL[FONT_COLOR.eGreenColor],stringF("%s/%s",needComplete_cnt,needComplete_cnt))
else
desc=stringF("\n(<color=%s>%s</color>)",FONT_COLOR_VAL[FONT_COLOR.eRedColor],stringF("%s/%s",complete_cnt,needComplete_cnt))
end
self.weekTasknumTxt:setText(stringF("%s%s",curCfg.Desc,desc))
end
end
else
local startTime,endTime=zhengzhanshanhaiModel:getPvPTime()
if endTime then
local func=function()
if _this then
local leftTime=(endTime-gameUtilityModel.getServerLongTime())
if leftTime>0 then
self.weekTasknumTxt:setText(FMT.fmt("<color=#FF0B0B>{0}</color>后重置任务",timeHelper.format_time_stamp11(leftTime,true)))
else
_this:stopTimerByID(_this.weekTaskPveTimer)
end
end
end
if not self.weekTaskPveTimer then
self.weekTaskPveTimer=self:setTimer(1,0,func)
end
end
end
end
end

function UIXM_ZZSH_PvEMainWin:onShopBtn()
funcShopController:openShopWin({shopId=eFuncShopType.eshanhaishop,canvasIdx=5})
end


function UIXM_ZZSH_PvEMainWin:checkWeekTaskReddot()
local SystemOpen=zhengzhanshanhaiController:checkSystemOpen_weekTask()
if SystemOpen then
local reddot=zhengzhanshanhaiModel:checkAllReddot()
self.weekTaskReddot:setActive(reddot)
end
end



function UIXM_ZZSH_PvEMainWin:refreshSetbyd()


local reddot=not zhengzhanshanhaiModel:checkIsSetZZSHYbd()
self.ybdred:setActive(reddot)
end


function UIXM_ZZSH_PvEMainWin:onSetbydBtn()
self:showWindow("UIXMZZSH_YuBeiDuiSetWin")
end

function UIXM_ZZSH_PvEMainWin:onBuffBtn()
self:showWindow("UILingShanBuffWin")
end