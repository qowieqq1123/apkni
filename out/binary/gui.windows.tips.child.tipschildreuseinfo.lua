







def_class("tipsChildReuseInfo",UICloneObject)





tipsChildReuseInfo.abName="ui/windows/tips/child/tipschildreuseinfo.ab"

tipsChildReuseInfo.assetName="tipsChildReuseInfo"


function tipsChildReuseInfo:bindComponents()

self.cdTime=UIText.get(self,0)
self.expireCount=UIText.get(self,1)

end


function tipsChildReuseInfo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cdTime);self.cdTime=nil;
_UIObject_release(self.expireCount);self.expireCount=nil;
end









function tipsChildReuseInfo:onLoaded(...)
self:bindComponents()
end


function tipsChildReuseInfo:__delete()
self:clearTimer()
self:unbindComponents()
end




function tipsChildReuseInfo:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
self.itemguid=itemguid
local attach=data.attach
local itemConfig=itemsConfig.getConfig(itemid)
local itemLeftUseTimes=bagUseControl.getItemReuseCount(itemguid)
self.expireCount:setText(FMT.fmt("剩余次数：{0}",itemLeftUseTimes))
self:setCDTimeTimer()
end


function tipsChildReuseInfo:onHide()
self:clearTimer()
end

function tipsChildReuseInfo:setCDTimeTimer()
self:clearTimer()
local itemguid=self.itemguid
local func=function(isInit)
local lerp=bagUseControl.getItemCDTime(itemguid)
if lerp>0 then

self.cdTime:setText(FMT.fmt("冷却时间：{0}",timeHelper.format_time_stamp2(lerp)))
else
self.cdTime:setText("冷却时间：无")
self:clearTimer()
if not isInit then

tipsManager.freshTips()
end


UIManager:callWindowFunc('UIBagWin','freshItemByGuid',itemguid)
end
end

self.timer=self:setTimer(1,0,func)
func(true)
end


function tipsChildReuseInfo:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end