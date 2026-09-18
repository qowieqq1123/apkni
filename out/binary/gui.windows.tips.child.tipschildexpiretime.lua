







def_class("tipsChildExpireTime",UICloneObject)





tipsChildExpireTime.abName="ui/windows/tips/child/tipschildexpiretime.ab"

tipsChildExpireTime.assetName="tipsChildExpireTime"


function tipsChildExpireTime:bindComponents()

self.expireTime=UIText.get(self,0)

end


function tipsChildExpireTime:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.expireTime);self.expireTime=nil;
end









function tipsChildExpireTime:onLoaded(...)
self:bindComponents()
end


function tipsChildExpireTime:__delete()
self:clearTimer()
self:unbindComponents()
end




function tipsChildExpireTime:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
self.itemguid=data.itemguid
local attach=data.attach
self.expire=attach.expire
self.boxGuid=attach.boxGuid
local itemConfig=itemsConfig.getConfig(itemid)



local itemguid=self.expire and itemConfig.expire and self.boxGuid or self.itemguid

self.itemExpireTime=bagUseControl.getItemExpireTime(itemguid)
if self.itemExpireTime==0 then

self:recycleSelf()
return
end


self:setExpireTimeTimer()
end


function tipsChildExpireTime:onHide()
self:clearTimer()
end




function tipsChildExpireTime:setExpireTimeTimer()
self:clearTimer()
local itemguid=self.expire and self.boxGuid or self.itemguid
local func=function(isInit)
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.itemExpireTime and self.itemExpireTime-nowTime or 0
if lerp>0 then

self.expireTime:setText(FMT.fmt("剩余时间：{0}",timeHelper.format_time_stamp7(lerp)))
else
self.expireTime:setText(FMT.fmt("剩余时间：<color={0}>已过期</color>",FONT_COLOR_VAL[FONT_COLOR.eRedColor]))
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


function tipsChildExpireTime:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end