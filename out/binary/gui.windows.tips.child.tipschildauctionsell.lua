







def_class("tipsChildAuctionSell",UICloneObject)





tipsChildAuctionSell.abName="ui/windows/tips/child/tipschildauctionsell.ab"

tipsChildAuctionSell.assetName="tipsChildAuctionSell"


function tipsChildAuctionSell:bindComponents()

self.lockRemainingTimePanel=UIObject.get(self,0)
self.lockRemainingTimeText=UIText.get(self,1)

end


function tipsChildAuctionSell:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.lockRemainingTimePanel);self.lockRemainingTimePanel=nil;
_UIObject_release(self.lockRemainingTimeText);self.lockRemainingTimeText=nil;
end


local _topLayer='UITopModel'
local _topOrder=2001
local _this








function tipsChildAuctionSell:onLoaded(...)
_this=self
self:bindComponents()

local gameObj=self.widget:GetChildGameObject(-1)
local component=gameObj:GetComponent("CSGUILuaFunction")
if component then
CS.BindFunction(component,self)
end
end


function tipsChildAuctionSell:__delete()
self:clearTimer()
self:closeSellPanel()
self.attach={}
self.itemConfig=nil
self.isShowInfoTime=false
self:unbindComponents()
_this=nil
end




function tipsChildAuctionSell:onShow(argtable,afterOnloaded)
self.argtable=argtable
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
self.attach=data.attach
self.itemConfig=itemsConfig.getConfig(itemid)
self.isShowInfoTime=false

local auctionSeries=data.auctionSeries
local hasCdTime=not auctionSeries and bagUseControl.isItemInAuctionSellCd(itemguid)or false
if hasCdTime then

self.lockRemainingTime=bagUseControl.getItemAuctionSellCdTime(itemguid)
self:setLockRemainingTimeTimer()
end

self.lockRemainingTimePanel:setActive(hasCdTime)


if not hasCdTime then

self:showSellPanel()
else

self:closeSellPanel()
end
end


function tipsChildAuctionSell:onHide()
self:clearTimer()
self:closeSellPanel()
end


function tipsChildAuctionSell:setLockRemainingTimeTimer()
self:clearTimer()
local func=function(isInit)
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.lockRemainingTime and self.lockRemainingTime-nowTime or 0
if lerp>0 then

if self.isShowInfoTime then

self.lockRemainingTimeText:setText(FMT.fmt("锁定期倒计时：{0}",timeHelper.format_time_stamp11(lerp)))
else
if lerp>=60 then
self.lockRemainingTimeText:setText(FMT.fmt("锁定期倒计时：{0}",timeHelper.formatSimpleTime(lerp)))
else
self.lockRemainingTimeText:setText(FMT.fmt("锁定期倒计时：{0}",timeHelper.format_time_stamp7(lerp)))
end
end
else
self:clearTimer()
if not isInit then

tipsManager.freshTips()
end
end
end

self.timer=self:setTimer(1,0,func)
func(true)
end


function tipsChildAuctionSell:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function tipsChildAuctionSell:showSellPanel()
UIManager:showWindow("UIWanBaoShangHui_sellPanelWin",self.argtable)
end

function tipsChildAuctionSell:closeSellPanel()
UIManager:closeWindow("UIWanBaoShangHui_sellPanelWin")
end



function tipsChildAuctionSell.test_changeCdTimeShowMode()
_this.isShowInfoTime=not _this.isShowInfoTime
end