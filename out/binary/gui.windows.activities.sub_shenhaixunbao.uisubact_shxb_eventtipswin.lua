







def_class("UISubAct_SHXB_eventTipsWin",UIWindowBase)









function UISubAct_SHXB_eventTipsWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.eventItem=UIObject.get(self,2)
self.titleText=UIText.get(self,3)

self.clickMask:setButtonClick(function()self:onClickMask()end)



end


function UISubAct_SHXB_eventTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.eventItem);self.eventItem=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end



















function UISubAct_SHXB_eventTipsWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_SHXB_eventTipsWin:__delete()
self:unbindComponents()
end




function UISubAct_SHXB_eventTipsWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.effectType=argtable and argtable.effectType
self.params=argtable and argtable.params
self.isAutoClose=argtable and argtable.isAutoClose or false
self.isSkipAnim=argtable and argtable.isSkipAnim or false
self.gridCfgId=argtable and argtable.gridCfgId

self:refresh()
end


function UISubAct_SHXB_eventTipsWin:onHide()

end

function UISubAct_SHXB_eventTipsWin:refresh()

local gridCfgId=self.gridCfgId
local gridCfg
if gridCfgId then
gridCfg=cfgHelper.get(cfg_shenhaixunbaogeziconfig_get,gridCfgId)
else
local allCfg=cfg_shenhaixunbaogeziconfig()
for id,cfg in pairs(allCfg)do
local gridType=cfg.gzType
if gridType==5 then
self.gridCfgId=id
gridCfgId=id
gridCfg=cfg
break
end
end
end

local infoParams=gridCfg.infoParams
local eventDescList=infoParams
local eventCfgIdx
eventCfgIdx=self.params and self.params[4]
local widget=self.eventItem:getWidgetBase()
local descData=eventDescList[eventCfgIdx]
local descStr=descData[1]

local iconName=descData[3]
local iconAb=descData[4]

widget:SetChildText(2,descStr)

if iconName then
widget:SetChildCSImageSprite(1,iconAb,iconName)
end

if self.isAutoClose then
local delayTime=1.5
self:delayDo(delayTime,function()
return self:onClickMask()
end)
end
end





function UISubAct_SHXB_eventTipsWin:onClickMask()
if self.parentWin then
if not self.isSkipAnim then
self.parentWin:try_playerMoveCheckNext()
else
self.parentWin:playerMoveCheckRestart()
end
end

self:closeSelf()
end

