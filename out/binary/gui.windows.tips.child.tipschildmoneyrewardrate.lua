







def_class("tipsChildMoneyRewardRate",UICloneObject)





tipsChildMoneyRewardRate.abName="ui/windows/tips/child/tipschildmoneyrewardrate.ab"

tipsChildMoneyRewardRate.assetName="tipsChildMoneyRewardRate"


function tipsChildMoneyRewardRate:bindComponents()

self.rateTitle=UIText.get(self,0)
self.rate=UIText.get(self,1)
self.rewardTitle=UIText.get(self,2)
self.rewardCount=UIText.get(self,3)

end


function tipsChildMoneyRewardRate:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rateTitle);self.rateTitle=nil;
_UIObject_release(self.rate);self.rate=nil;
_UIObject_release(self.rewardTitle);self.rewardTitle=nil;
_UIObject_release(self.rewardCount);self.rewardCount=nil;
end









function tipsChildMoneyRewardRate:onLoaded(...)
self:bindComponents()
end


function tipsChildMoneyRewardRate:__delete()
self:unbindComponents()
end




function tipsChildMoneyRewardRate:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach

if attach and attach.rewardRateArgs then
local rewardRateArgs=attach.rewardRateArgs
local rate=rewardRateArgs.rate
local allCount=rewardRateArgs.allCount
local rewardCount=math.ceil(allCount*rate/100)
self.rate:setText(FMT.fmt("{0}%",rate))
self.rewardCount:setText(rewardCount)

local rateTitle=rewardRateArgs.rateTitle or"比例:"
local rewardTitle=rewardRateArgs.rewardTitle or"获得:"
self.rateTitle:setText(rateTitle)
self.rewardTitle:setText(rewardTitle)
else
self:recycleSelf()
return
end
end


function tipsChildMoneyRewardRate:onHide()

end


