







def_class("UIWeakGuideTwoWin",UIWindowBase)









function UIWeakGuideTwoWin:bindComponents()

self.root=UIObject.get(self,0)
self.back=UIButton.get(self,1)

self.back:setButtonClick(function()self:onBack()end)



end


function UIWeakGuideTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.back);self.back=nil;
end
















local _this=nil
local clearCache=nil


function UIWeakGuideTwoWin:onLoaded(...)
self:bindComponents()
_this=self
clearCache={}
if self.channelList==nil then
self.channelList={}
self:refreshChannelCnt()
end
end


function UIWeakGuideTwoWin:__delete()
self:clearRefreshTimer()
self:unbindComponents()
_this=nil
for guid,c_cache in pairs(clearCache)do
self:removeInstantiate(c_cache[2],guid)
end
clearCache=nil
end


function UIWeakGuideTwoWin:onHide()

end




function UIWeakGuideTwoWin:onShow(argtable,afterOnloaded)
if self.channelList==nil then
self.channelList={}
self:refreshChannelCnt()
end

self:beginGuide(argtable)

if self.refreshTimer==nil then
local func=function()
self:refershPos()
end
self.refreshTimer=self:setTimer(1,0,func)
self:refershPos()
end
end

function UIWeakGuideTwoWin:beginGuide(args)
local guideID=args.guideID
local cfg=cfgHelper.get(cfg_weakguideconfig_get,guideID)
local channel=cfg.channel
if not weakGuideController:checkGuideChannel(channel)then
return
end

local pos=args.pos
local parentUI=args.parentUI
local sortOrder=args.sortOrder
local sortLayer=args.sortLayer
local life=cfg.life/1000
local dynamic=cfg.dynamic
if dynamic==nil then dynamic=false end
local sortOrderOffset=cfg.sortOrderOffset or 1
local data=self.channelList[channel]
if data~=nil then


self:killChannelEx(channel)
end

data={}
data.guideID=guideID
data.pos=pos
data.parentUI=parentUI
data.dynamic=dynamic
data.sortOrder=sortOrder
data.sortLayer=sortLayer
data.sortOrderOffset=sortOrderOffset
data.channel=channel
data.posOffest=cfg.offest
data.clickClose=cfg.clickClose


local style=cfg.style
local styleType=style[1]
local instanceID=weakGuideController:getStyleInstance(styleType)
if dynamic then
data.guid=_InstantiateManager.AddInstance(instanceID,parentUI,function(id)
if _this==nil then return end
if _this:checkClearCache(id)then return end
local widget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
if widget then
data.guideWidget=widget
self:refershDynamicGuide(widget,data)
weakGuideController:createStyle(widget,style,data)
end
end)
else
local func1=function(id)
if _this==nil then return end
if _this:checkClearCache(id)then return end
local widget=self:getGuideWidget(id)
if widget then
data.guideWidget=widget
self:refershGuide(widget,data)
weakGuideController:createStyle(widget,style,data)
end
end
data.guid=self:setChildGreateExpandUI(0,-1,instanceID,func1)
end

local func2=function()

self:endGuide(channel)
end
data.closeTimer=self:delayDo(life,func2)
self.channelList[channel]=data
self:refreshChannelCnt()


if data.clickClose==true then
self.back:setActive(true)
end
end

function UIWeakGuideTwoWin:endGuide(channel)
if self.channelList==nil then return end
local data=self.channelList[channel]
if data==nil then return end
local guideID=data.guideID
weakGuideController:killGuide(guideID)
end

function UIWeakGuideTwoWin:clearRefreshTimer()
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
self:refreshChannelCnt()
end
end

function UIWeakGuideTwoWin:refershPos()
if self.channelCnt<=0 then
self:finishGuid()
return
end
end

function UIWeakGuideTwoWin:refershDynamicGuide(widget,data)
local localpos=Vector3.zero
localpos.x=localpos.x+data.posOffest[1]
localpos.y=localpos.y+data.posOffest[2]
widget:SetChildLocalPosition(0,localpos)


if data.sortLayer~=-1 and data.sortOrder~=-999 then
widget:SetChildCanvas(0,data.sortLayer,data.sortOrder+data.sortOrderOffset)
else
local cav=widget:GetChildCanvas(-1)
widget:SetChildCanvas(0,cav[1],cav[2]+data.sortOrderOffset)
end
end

function UIWeakGuideTwoWin:refershGuide(widget,data)
local screenPos=CS.CSGUIManager.Instance:WorldToScreenPoint(data.pos)
local localpos=self:getChildUIScreenPos2Local(-1,screenPos)
localpos.x=localpos.x+data.posOffest[1]
localpos.y=localpos.y+data.posOffest[2]
widget:SetChildLocalPosition(0,localpos)


if data.sortLayer~=-1 and data.sortOrder~=-999 then
widget:SetChildCanvas(0,data.sortLayer,data.sortOrder+data.sortOrderOffset)
end
end

function UIWeakGuideTwoWin:getGuideWidget(guid)
return self:getChildExpandUI(0,guid)
end

function UIWeakGuideTwoWin:finishGuid()
self:closeSelf()
end

function UIWeakGuideTwoWin:killChannel(channel)
self:killChannelEx(channel)
weakGuideController:killChannel(channel)
end

function UIWeakGuideTwoWin:killChannelEx(channel)
if self.channelList==nil then return end
local data=self.channelList[channel]
local hideClickClose=false
if data~=nil then
if data.guideWidget~=nil then
self:removeInstantiate(data.dynamic,data.guid)
else
local c_cache={data.guid,data.dynamic}
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
self.back:setActive(false)
end
end

function UIWeakGuideTwoWin:onBack()
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

function UIWeakGuideTwoWin:refreshChannelCnt()
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

function UIWeakGuideTwoWin:checkClearCache(guid)
local c_cache=clearCache[guid]
if c_cache then
self:removeInstantiate(c_cache[2],guid)
clearCache[guid]=nil
return true
end
return false
end

function UIWeakGuideTwoWin:removeInstantiate(dynamic,guid)
if dynamic then
_InstantiateManager.RemoveInstance(guid)
else
self:setChildRemoveExpandUI(0,guid)
end
end