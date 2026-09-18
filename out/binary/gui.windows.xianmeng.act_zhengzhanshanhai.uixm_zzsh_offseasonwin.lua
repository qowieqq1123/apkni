







def_class("UIXM_ZZSH_offSeasonWin",UIWindowBase)









function UIXM_ZZSH_offSeasonWin:bindComponents()

self.topPanel=UIObject.get(self,0)
self.leftPanel=UIObject.get(self,1)
self.rightPanel=UIObject.get(self,2)
self.bottomPanel=UIObject.get(self,3)
self.noteBtnReddot=UIObject.get(self,4)
self.noteBtn=UIButton.get(self,5)
self.root=UIObject.get(self,6)
self.boxBtn=UIButton.get(self,7)
self.timeText=UIText.get(self,8)
self.boxNumObj=UIObject.get(self,9)
self.boxNumTxt=UIText.get(self,10)

self.noteBtn:setButtonClick(function()self:onNoteBtn()end)

self.boxBtn:setButtonClick(function()self:onBoxBtn()end)



end


function UIXM_ZZSH_offSeasonWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.bottomPanel);self.bottomPanel=nil;
_UIObject_release(self.noteBtnReddot);self.noteBtnReddot=nil;
_UIObject_release(self.noteBtn);self.noteBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.boxBtn);self.boxBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.boxNumObj);self.boxNumObj=nil;
_UIObject_release(self.boxNumTxt);self.boxNumTxt=nil;
end
















local _this




function UIXM_ZZSH_offSeasonWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onBaoXiaReddotChange,self.onBaoXiaReddotChange)
self:addNotify(notifyConfig.onZhengZhanShanHaiLogReddotChange,self.onZhengZhanShanHaiLogReddotChange)
self:addNotify(notifyConfig.onZZSHSeasonStateChange,self.onZZSHSeasonStateChange)
end


function UIXM_ZZSH_offSeasonWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXM_ZZSH_offSeasonWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UIXM_ZZSH_offSeasonWin:onShowArgRecv(argtable)
self:refresh()
end


function UIXM_ZZSH_offSeasonWin:onHide()

end

function UIXM_ZZSH_offSeasonWin:refresh()
if self.timer==nil then
local func=function()
self:timerRefresh()
end
self.timer=self:setTimer(1,0,func)
self:refreshActTimer()
end
self:refreshBtn()
end

function UIXM_ZZSH_offSeasonWin:refreshBtn()

local isShowBtn=true
if zhengzhanshanhaiModel:checkJoin()then
local seasonState=zhengzhanshanhaiModel:getSeasonState()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if seasonState==3 and shSeasonId~=-1 then

isShowBtn=false
end
else

isShowBtn=false
end

self.noteBtn:setActive(isShowBtn)
self.boxBtn:setActive(isShowBtn)

if isShowBtn then
self:refreshNoteReddot()
self:refreshBaoXiaReddot()
end
end

function UIXM_ZZSH_offSeasonWin:timerRefresh()
self:refreshActTimer()
end

function UIXM_ZZSH_offSeasonWin:refreshActTimer()
local seasonState=zhengzhanshanhaiModel:getSeasonState()
if seasonState==1 then
return self:clearTimer()
end
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local startTime,endTime,settleTime,settleEndTime=zhengzhanshanhaiModel:getSeasonTime()
local nowTime=timeHelper.getServerLongTime()
local deltaTime
local time_str
if seasonState==3 or(seasonState==2 and shSeasonId==-1)then

deltaTime=endTime-nowTime
if deltaTime<=0 then
return self:clearTimer()
end

local nextSeasonId
if shSeasonId==-1 then
nextSeasonId=1
else
nextSeasonId=shSeasonId+1
end
local name=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,nextSeasonId,"name")
time_str=FMT.fmt('【{0}】将于<color=#aae252>{1}</color>后开始',name,timeHelper.format_time_stamp11(deltaTime,true))
elseif seasonState==2 then

deltaTime=settleEndTime-nowTime
if deltaTime<=0 then
return self:clearTimer()
end
time_str=FMT.fmt('赛季结算剩余时间：<color=#aae252>{0}</color>',timeHelper.format_time_stamp11(deltaTime,true))
end

self.timeText:setText(time_str)
end

function UIXM_ZZSH_offSeasonWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end
function UIXM_ZZSH_offSeasonWin.onZhengZhanShanHaiLogReddotChange()
if _this==nil then return end
_this:refreshNoteReddot()
end

function UIXM_ZZSH_offSeasonWin:refreshNoteReddot()
local isReddot=zhengzhanshanhaiModel:jude_zhengzhanshanhailog_reddot()
self.noteBtnReddot:setActive(isReddot)
end

function UIXM_ZZSH_offSeasonWin.onBaoXiaReddotChange()
if _this==nil then return end
_this:refreshBaoXiaReddot()
end

function UIXM_ZZSH_offSeasonWin:refreshBaoXiaReddot()
local num=zhengzhanshanhaiModel:isBXReddot()
local isshow=num>0
self.boxNumObj:setActive(isshow)
if isshow then
self.boxNumTxt:setText(tostring(num))
end
end

function UIXM_ZZSH_offSeasonWin:checkSeasonStateChange()
self:refresh()
end

function UIXM_ZZSH_offSeasonWin.onZZSHSeasonStateChange(isChangeSeason)
if _this==nil or not _this.isVisible then return end
if not isChangeSeason then
_this:checkSeasonStateChange()
end
end




function UIXM_ZZSH_offSeasonWin:onNoteBtn()
zhengzhanshanhaiController:OpenZhengZhanShanHaiFightLog()
end



function UIXM_ZZSH_offSeasonWin:onBoxBtn()
UIManager:showWindow('UIXM_ZZSH_TreasureBoxWin')
end

