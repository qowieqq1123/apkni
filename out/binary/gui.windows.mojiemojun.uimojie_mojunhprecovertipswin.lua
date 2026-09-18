







def_class("UIMoJie_MoJunHpRecoverTipsWin",UIWindowBase)









function UIMoJie_MoJunHpRecoverTipsWin:bindComponents()

self.desc=UIText.get(self,0)
self.rDesc=UIText.get(self,1)
self.root=UIObject.get(self,2)
self.rPanel=UIObject.get(self,3)
self.timePanel=UIObject.get(self,4)
self.timeText=UIText.get(self,5)



end


function UIMoJie_MoJunHpRecoverTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.rDesc);self.rDesc=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rPanel);self.rPanel=nil;
_UIObject_release(self.timePanel);self.timePanel=nil;
_UIObject_release(self.timeText);self.timeText=nil;
end



















function UIMoJie_MoJunHpRecoverTipsWin:onLoaded(...)
self:bindComponents()
end


function UIMoJie_MoJunHpRecoverTipsWin:__delete()
self:unbindComponents()
end




function UIMoJie_MoJunHpRecoverTipsWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id

self:refresh()
end


function UIMoJie_MoJunHpRecoverTipsWin:onHide()

end

function UIMoJie_MoJunHpRecoverTipsWin:refresh()
local mojunData=xianjieModel:getMoJunData(self.seasonType,self.stageIndex)

local hpRecoverData=xianjieModel:getHpRecoverData(self.seasonType,self.stageIndex)
self.desc:setText(FMT.fmt("{0}%",hpRecoverData[3]/100))

local nextHpRecoverData
if mojunData.killTime==0 then
nextHpRecoverData=xianjieModel:getHpRecoverData(self.seasonType,self.stageIndex,true)
end
if nextHpRecoverData then
self.rDesc:setText(FMT.fmt("{0}%",nextHpRecoverData[3]/100))

local nowTime=timeHelper.getServerShortTime()
local zeorSec=timeHelper.getServerZeroShortStamp(mojunData.yaomoEndTime)
local endTime=zeorSec+nextHpRecoverData[1]*86400
self.timeText:setText(timeHelper.format_time_stamp3(endTime-nowTime))

self.endTime=endTime

self:setRemainingTimeTimer()
else
self:clearTimer()
end
self.timePanel:setActive(nextHpRecoverData~=nil)
self.rPanel:setActive(nextHpRecoverData~=nil)
end


function UIMoJie_MoJunHpRecoverTipsWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=timeHelper.getServerShortTime()
local lerp=self.endTime-nowTime
if lerp>=0 then
self.timeText:setText(timeHelper.format_time_stamp3(lerp))
else
self:clearTimer()
self:refresh()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UIMoJie_MoJunHpRecoverTipsWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end





function UIMoJie_MoJunHpRecoverTipsWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

