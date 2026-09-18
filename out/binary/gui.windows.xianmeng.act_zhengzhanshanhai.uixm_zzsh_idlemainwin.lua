







def_class("UIXM_ZZSH_IdleMainWin",UIWindowBase)









function UIXM_ZZSH_IdleMainWin:bindComponents()

self.topPanel=UIObject.get(self,0)
self.leftPanel=UIObject.get(self,1)
self.rightPanel=UIObject.get(self,2)
self.bottomPanel=UIObject.get(self,3)
self.tipsObj=UIObject.get(self,4)
self.noteBtnReddot=UIObject.get(self,5)
self.setBtn=UIButton.get(self,6)
self.noteBtn=UIButton.get(self,7)
self.teamBtn=UIButton.get(self,8)
self.root=UIObject.get(self,9)
self.boxBtn=UIButton.get(self,10)
self.tipsTxt=UIText.get(self,11)
self.boxNumObj=UIObject.get(self,12)
self.boxNumTxt=UIText.get(self,13)

self.setBtn:setButtonClick(function()self:onSetBtn()end)

self.noteBtn:setButtonClick(function()self:onNoteBtn()end)

self.teamBtn:setButtonClick(function()self:onTeamBtn()end)

self.boxBtn:setButtonClick(function()self:onBoxBtn()end)



end


function UIXM_ZZSH_IdleMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.tipsObj);self.tipsObj=nil;
_UIObject_release(self.noteBtnReddot);self.noteBtnReddot=nil;
_UIObject_release(self.setBtn);self.setBtn=nil;
_UIObject_release(self.noteBtn);self.noteBtn=nil;
_UIObject_release(self.teamBtn);self.teamBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.boxBtn);self.boxBtn=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.boxNumObj);self.boxNumObj=nil;
_UIObject_release(self.boxNumTxt);self.boxNumTxt=nil;
end
















local _this


function UIXM_ZZSH_IdleMainWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onBaoXiaReddotChange,self.onBaoXiaReddotChange)
self:addNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange,self.onZhengZhanShanHaiLogReddotChange)
end


function UIXM_ZZSH_IdleMainWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_ZZSH_IdleMainWin:onHide()

end




function UIXM_ZZSH_IdleMainWin:onShow(argtable,afterOnloaded)
if self.actTimer==nil then
local func=function()
self:timerRefresh()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end
self:refreshNoteReddot()
self:refreshBaoXiaReddot()
self:refreshSettingModel()
end

function UIXM_ZZSH_IdleMainWin:checkClickLock()
if self.clickLockTime~=nil and gameUtilityModel.getServerShortTime()-self.clickLockTime<zhengzhanshanhaiModel.clickBtnCoolTime then
return false
end
self.clickLockTime=gameUtilityModel.getServerShortTime()
return true
end

function UIXM_ZZSH_IdleMainWin:timerRefresh()
self:refreshActTimer()
end

function UIXM_ZZSH_IdleMainWin:refreshActTimer()
local raceState,left,curState=zhengzhanshanhaiModel:getLunState()
local time_str
if curState==nil then
time_str=FMT.fmt('距离山海世界关闭剩余：{0}',timeHelper.format_time_stamp3(left))
elseif curState>0 then
local actState=limitActivitiesModel:checkActState(LIMIT_ACT_TYPE.eZhengZhanShanHai)
if actState==limitActivitiesModel.actDoingState then
time_str=FMT.fmt('距离山海世界开启剩余：{0}',timeHelper.format_time_stamp3(left))
else
local time=limitActivitiesModel:getActStartLeftTime(LIMIT_ACT_TYPE.eZhengZhanShanHai)
time_str=FMT.fmt('距离山海世界开启剩余：{0}',timeHelper.format_time_stamp3(time))
end
end
local isshow=time_str~=nil
self.tipsObj:setActive(isshow)
if isshow then
self.tipsTxt:setText(time_str)
end
end

function UIXM_ZZSH_IdleMainWin:onQishiRankBtn()

end



function UIXM_ZZSH_IdleMainWin.onBaoXiaReddotChange()
if _this==nil then return end
_this:refreshBaoXiaReddot()
end

function UIXM_ZZSH_IdleMainWin:refreshBaoXiaReddot()
local num=zhengzhanshanhaiModel:isBXReddot()
local isshow=num>0
self.boxNumObj:setActive(isshow)
if isshow then
self.boxNumTxt:setText(tostring(num))
end
end

function UIXM_ZZSH_IdleMainWin:onBoxBtn()
UIManager:showWindow('UIXM_ZZSH_TreasureBoxWin')
end





function UIXM_ZZSH_IdleMainWin.onZhengZhanShanHaiLogReddotChange()
if _this==nil then return end
_this:refreshNoteReddot()
end

function UIXM_ZZSH_IdleMainWin:refreshNoteReddot()
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

function UIXM_ZZSH_IdleMainWin:onNoteBtn()
zhengzhanshanhaiController:OpenZhengZhanShanHaiFightLog()
end





function UIXM_ZZSH_IdleMainWin:onSetBtn()
UIManager:showWindow("UIXM_ZZSH_settingWin")
end

function UIXM_ZZSH_IdleMainWin:refreshSettingModel()


self:refrshTeamBtn()

end





function UIXM_ZZSH_IdleMainWin:onTeamBtn()
if not self:checkClickLock()then
return
end
zhengzhanshanhaiModel:checkOpenSelectTeamWin(1)
end

function UIXM_ZZSH_IdleMainWin:refrshTeamBtn()
local isShow=false
local actState=limitActivitiesModel:checkActState(LIMIT_ACT_TYPE.eZhengZhanShanHai)
if actState==limitActivitiesModel.actDoingState then
if not zhengzhanshanhaiModel.maskPvP then
local setting=zhengzhanshanhaiModel:getPvESetting()
local showModel=setting[2]or 1
isShow=showModel==1 or showModel==2
end
end
self.teamBtn:setActive(isShow)
end


