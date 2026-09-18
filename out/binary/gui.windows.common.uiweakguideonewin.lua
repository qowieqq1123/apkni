







def_class("UIWeakGuideOneWin",UIWindowBase)









function UIWeakGuideOneWin:bindComponents()

self.root=UIObject.get(self,0)
self.blockBG=UIButton.get(self,1)

self.blockBG:setButtonClick(function()self:onBlockBG()end)



end


function UIWeakGuideOneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.blockBG);self.blockBG=nil;
end
















local _luaHelper=CS.LuaHelper
local _this=nil
local clearCache=nil


function UIWeakGuideOneWin:onLoaded(...)
self:bindComponents()
_this=self
clearCache={}
if self.channelList==nil then
self.channelList={}
self:refreshChannelCnt()
end
end


function UIWeakGuideOneWin:__delete()
self:clearRefreshTimer()
self:unbindComponents()
_this=nil
for guid,c_cache in pairs(clearCache)do
self:removeInstantiate(guid)
end
clearCache=nil
end


function UIWeakGuideOneWin:onHide()

end




function UIWeakGuideOneWin:onShow(argtable,afterOnloaded)
if self.channelList==nil then
self.channelList={}
self:refreshChannelCnt()
end

self:beginGuide(argtable)

if self.refreshTimer==nil then
local func=function()
self:refershPos()
end
self.refreshTimer=self:setTimer(0.01,0,func)
self:refershPos()
end
end

function UIWeakGuideOneWin:beginGuide(args)
local guideID=args.guideID
local cfg=cfgHelper.get(cfg_weakguideconfig_get,guideID)
local channel=cfg.channel
if not weakGuideController:checkGuideChannel(channel)then
return
end

local pos=args.pos
local life=cfg.life/1000


local data=self.channelList[channel]
if data~=nil then


self:killChannelEx(channel)
end

data={}
data.guideID=guideID
data.pos=pos
data.channel=channel
data.screenType=cfg.screenParams and cfg.screenParams[1]
if cfg.extrajump and not cfg.screenParams then
data.screenType=cfg.extrajump
end
data.posOffest=cfg.offest

data.sortLayer=_luaHelper.SortingLayerNameToID('CanvasGroup')
data.sortOrder=999
data.clickClose=cfg.clickClose


local style=cfg.style
local styleType=style[1]
local instanceID=weakGuideController:getStyleInstance(styleType)
local func1=function(id)
if _this==nil then return end
if _this:checkClearCache(id)then return end
local widget=self:getGuideWidget(id)
if widget then
data.guideWidget=widget
widget:SetChildCanvas(0,data.sortLayer,data.sortOrder)
weakGuideController:createStyle(widget,style,data)
end
end
data.guid=self:setChildGreateExpandUI(0,-1,instanceID,func1)

local func2=function()

weakGuideController:killGuide(guideID)
end
data.closeTimer=self:delayDo(life,func2)
self.channelList[channel]=data
self:refreshChannelCnt()


if data.clickClose==true then
self.blockBG:setActive(true)
end
end

function UIWeakGuideOneWin:clearRefreshTimer()
if self.refreshTimer~=nil then
self:stopTimerByID(self.refreshTimer)
self.refreshTimer=nil
end
if self.channelCnt>0 then


local kills={}
for k,v in pairs(self.channelList)do
table.insert(kills,v.guideID)
end
if#kills>0 then
for i,guideID in ipairs(kills)do
weakGuideController:killGuide(guideID)
end
end
self.channelList=nil
self.channelCnt=0
end
end

function UIWeakGuideOneWin:refershPos()
if self.channelCnt<=0 then
self:finishGuid()
return
end

for k,v in pairs(self.channelList)do
local data=v
local guideWidget=data.guideWidget
if guideWidget then
local screenPos=weakGuideController.worldPos2Screen(data.guideID,data.screenType,data.pos)
if screenPos==nil then

return
end
local localpos=self:getChildUIScreenPos2Local(-1,screenPos)
localpos.x=localpos.x+data.posOffest[1]
localpos.y=localpos.y+data.posOffest[2]
guideWidget:SetChildLocalPosition(0,localpos)

end
end
end

function UIWeakGuideOneWin:getGuideWidget(guid)
return self:getChildExpandUI(0,guid)
end

function UIWeakGuideOneWin:finishGuid()
self:closeSelf()
end

function UIWeakGuideOneWin:killChannel(channel)
self:killChannelEx(channel)
weakGuideController:killChannel(channel)
end

function UIWeakGuideOneWin:killChannelEx(channel)
local data=self.channelList[channel]
local hideClickClose=false
if data~=nil then
if data.guideWidget~=nil then
self:removeInstantiate(data.guid)
else
local c_cache={data.guid}
clearCache[data.guid]=c_cache
end
if data.closeTimer~=nil then
self:stopTimerByID(data.closeTimer)
data.closeTimer=nil
end
self.channelList[channel]=nil
self:refreshChannelCnt()

if data.clickClose==true then
hideClickClose=true
end
end








if hideClickClose then
self.blockBG:setActive(false)
end
end

function UIWeakGuideOneWin:onBlockBG()
local kills={}
for k,v in pairs(self.channelList)do
if v.clickClose==true then
table.insert(kills,v.guideID)
end
end
if#kills>0 then
for i,guideID in ipairs(kills)do
weakGuideController:killGuide(guideID)
end
end
end

function UIWeakGuideOneWin:refreshChannelCnt()
local cnt=0
if self.channelList then
for k,v in pairs(self.channelList)do
if v~=nil then
cnt=cnt+1
end
end
end
self.channelCnt=cnt
end

function UIWeakGuideOneWin:checkClearCache(guid)
local c_cache=clearCache[guid]
if c_cache then
self:removeInstantiate(guid)
clearCache[guid]=nil
return true
end
return false
end

function UIWeakGuideOneWin:removeInstantiate(guid)
self:setChildRemoveExpandUI(-1,guid)
end