







def_class("UIAreaUnlockWaitWin",UIWindowBase)









function UIAreaUnlockWaitWin:bindComponents()

self.btnUnlock=UIButton.get(self,0)
self.condition=UIText.get(self,1)
self.root=UIObject.get(self,2)
self.scrollview=UIObject.get(self,3)
self.timeTxt=UIText.get(self,4)
self.title=UIText.get(self,5)
self.unlockBtnText=UIText.get(self,6)

self.btnUnlock:setButtonClick(function()self:onBtnUnlock()end)



end


function UIAreaUnlockWaitWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnUnlock);self.btnUnlock=nil;
_UIObject_release(self.condition);self.condition=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.unlockBtnText);self.unlockBtnText=nil;
end



















function UIAreaUnlockWaitWin:onLoaded(...)
self:bindComponents()
end


function UIAreaUnlockWaitWin:__delete()
self:unbindComponents()
self:clearTimer()
end




function UIAreaUnlockWaitWin:onShow(argtable,afterOnloaded)
self.areaId=argtable
self:refresh()
end


function UIAreaUnlockWaitWin:onHide()

end

function UIAreaUnlockWaitWin:refresh()
local cfg=cfgHelper.get1(cfg_monijyareaconfig_get,self.areaId)

self.title:setText(cfg.name)

local rewards=cfg.unlock_rewards
self.scrollview:setChildScrollViewCreateGrids(#rewards,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local data=rewards[i+1]
local item=grids[i]
widgetHelper.setNormalRewardItem(item,0,data)
end

if cfg.unlock_dizi~=nil then
self.condition:setText("弟子探索中...")
else
self.condition:setText("探索中...")
end

local sfId=zongmenModel:getMountainId()
local areaData=zongmenModel:getAreaData(sfId,self.areaId)
self.endTime=areaData.begintime+cfg.unlock_wait

local func=function()
local curTime=gameUtilityModel.getServerShortTime()
local left=self.endTime-curTime
if left>=0 then
self.timeTxt:setText(timeHelper.format_time_stamp3(left))
else
self:clearTimer()
self:onClickClose()
end
end
self.timer=self:setTimer(1,0,func)

func()
end


function UIAreaUnlockWaitWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end




function UIAreaUnlockWaitWin:onBtnUnlock()
self:onClickClose()
end

function UIAreaUnlockWaitWin:onClickClose()
self:closeSelf()
end
