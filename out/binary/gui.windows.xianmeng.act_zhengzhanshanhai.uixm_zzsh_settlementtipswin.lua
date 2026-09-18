







def_class("UIXM_ZZSH_settlementTipsWin",UIWindowBase)









function UIXM_ZZSH_settlementTipsWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.bgModel=UIObject.get(self,2)
self.gotoBtn=UIButton.get(self,3)
self.seasonNameIcon=UIImage.get(self,4)
self.timeText=UIText.get(self,5)
self.desc=UIText.get(self,6)
self.gou=UIObject.get(self,7)
self.notTipsMark=UIButton.get(self,8)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.notTipsMark:setButtonClick(function()self:onNotTipsMark()end)



end


function UIXM_ZZSH_settlementTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.seasonNameIcon);self.seasonNameIcon=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.gou);self.gou=nil;
_UIObject_release(self.notTipsMark);self.notTipsMark=nil;
end



















function UIXM_ZZSH_settlementTipsWin:onLoaded(...)
self:bindComponents()
end


function UIXM_ZZSH_settlementTipsWin:__delete()
self:clearTimer()
self:unbindComponents()
end




function UIXM_ZZSH_settlementTipsWin:onShow(argtable,afterOnloaded)

zhengzhanshanhaiController.req_ZZSH_Rank()


self.bgModel:setChildUIModelShowTarget(6180,1,{},eAnimationID.enter)

self:refresh()
end


function UIXM_ZZSH_settlementTipsWin:onHide()
self:clearTimer()
end

function UIXM_ZZSH_settlementTipsWin:refresh()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()


local icon
if shSeasonId==-1 then
local raceIndex=zhengzhanshanhaiModel:getRaceIndex()
icon=cfgHelper.get2(cfg_zhengzhanshanhaisessionconfig_get,raceIndex,'mapicon')
else

icon=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonId,"seasonIconid")
end
self.seasonNameIcon:setSprite(globalABLookup.zzshtitleicons,FMT.fmt('image_shanhaishijiebt_{0}',icon))


local settlementTipsStr=zhengzhanshanhaiController:getZZSHCfg("settlementTipsText")
if not settlementTipsStr then

settlementTipsStr=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,1,"settlementTipsText")
end
local selfRankIndex=zhengzhanshanhaiModel:getSelfRankIndex_ZZSH()
local rankStr
if not selfRankIndex then
rankStr="<color=#c82c2c>未上榜</color>"
else
rankStr=FMT.fmt("<color=#549327>第{0}名</color>",selfRankIndex)
end
self.desc:setText(FMT.fmt(settlementTipsStr,rankStr))


self:refreshNotTipsMark()


self:setRemainingTimeTimer()
end

function UIXM_ZZSH_settlementTipsWin:refreshNotTipsMark()
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHSeasonSettlementTips)
self.gou:setActive(flag)
end

function UIXM_ZZSH_settlementTipsWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=timeHelper.getServerLongTime()
local startTime,endTime,settleTime=zhengzhanshanhaiModel:getSeasonTime()
local lerp=settleTime-nowTime
if lerp>0 then

self.timeText:setText(FMT.fmt("赛季剩余时间：<color=#aae252>{0}</color>",timeHelper.format_time_stamp11(lerp,true)))
else
self.timeText:setText("赛季结算中")
self:clearTimer()
self:onCloseBtn()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UIXM_ZZSH_settlementTipsWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end




function UIXM_ZZSH_settlementTipsWin:onClickMask()
self:onCloseBtn()
end



function UIXM_ZZSH_settlementTipsWin:onCloseBtn()
self:closeSelf()
end



function UIXM_ZZSH_settlementTipsWin:onGotoBtn()
UIManager:showWindow('UIXM_ZZSH_RankInfoWin')
self:closeSelf()
end



function UIXM_ZZSH_settlementTipsWin:onNotTipsMark()
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHSeasonSettlementTips)
flag=not flag
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHSeasonSettlementTips,flag)
return self:refreshNotTipsMark()
end

