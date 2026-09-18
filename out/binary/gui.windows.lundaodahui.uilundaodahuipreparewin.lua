







def_class("UILunDaoDaHuiPrePareWin",UIWindowBase)









function UILunDaoDaHuiPrePareWin:bindComponents()

self.root=UIObject.get(self,0)
self.time=UIText.get(self,1)



end


function UILunDaoDaHuiPrePareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.time);self.time=nil;
end



















function UILunDaoDaHuiPrePareWin:onLoaded(...)
self:bindComponents()
end


function UILunDaoDaHuiPrePareWin:__delete()
self:unbindComponents()
end




function UILunDaoDaHuiPrePareWin:onShow(argtable,afterOnloaded)

local lockTime=lundaodahuiModel:checkMatchTimeBefore15Min()
if lockTime then
self.time:setText("战斗阵容已锁定，不可调整")
else
if lundaodahuiModel:checkLunDaoDaHuiEntry()then
local matchListFunc=function()
local list=lundaodahuiModel:getMatchTimeList()
if list and next(list)then
local nowTime=timeHelper.getServerLongTime()
local min15=60*15
local flag=false
for i,v in ipairs(list)do
for ii,vv in ipairs(v)do
if nowTime<vv then
if vv-nowTime>min15 then
self.time:setText(FMT.fmt("比赛前<color=#ca631d>15分钟</color>锁定阵容\n调整阵容剩余时间：<color=#ca631d>{0}</color>",timeHelper.format_time_stamp3(vv-min15-nowTime)))
else
self.time:setText("战斗阵容已锁定，不可调整")
end
flag=true
break
end
end
if flag then
break
end
end
if not flag then
self.root:setActive(false)
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end
else
self.root:setActive(false)
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end
end
self.root:setActive(true)
matchListFunc()
self.timer=self:setTimer(1,0,matchListFunc)
else
self.root:setActive(false)
end
end
end




function UILunDaoDaHuiPrePareWin:onHide()

end



