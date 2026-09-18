







def_class("UIXianJieHomeBuffItem",UICloneObject)





UIXianJieHomeBuffItem.abName="ui/windows/homebuff/uixianjiehomebuffitem.ab"

UIXianJieHomeBuffItem.assetName="UIXianJieHomeBuffItem"


function UIXianJieHomeBuffItem:bindComponents()

self.clock=UIObject.get(self,0)
self.desc1=UIText.get(self,1)
self.icon=UIImage.get(self,2)
self.name=UIText.get(self,3)
self.time=UIText.get(self,4)
self.uneffect=UIText.get(self,5)

end


function UIXianJieHomeBuffItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clock);self.clock=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.uneffect);self.uneffect=nil;
end








function UIXianJieHomeBuffItem:onLoaded(...)
self:bindComponents()
end

function UIXianJieHomeBuffItem:__delete()
self:unbindComponents()
end

function UIXianJieHomeBuffItem:onShow(argtable,afterOnloaded)
local buffData=argtable.buffData
local id=buffData.buffid
local endStamp=buffData.endsec
local idx=argtable.idx
local len=argtable.len
self.id=id
self.endStamp=endStamp
local buffType=argtable.buffType
local buffCfg
if buffType==1 then
buffCfg=cfg_fairylandbuffconfig_get(id)
elseif buffType==2 then
buffCfg=cfg_guildstateconfig_get(id)
end
if not buffCfg then
loggerUtil.debugErrFMT("not find buff. buffType:{0}  buffId:{1}",buffType,id)
self:recycleSelf()
return
end
local isEveryTime=endStamp<=0
self.showTime=true
if isEveryTime and not buffCfg.durationDesc then
self.showTime=false
end
local effects=buffCfg.effects
local iconname=iconHelper.getzmStateIcon(buffCfg.icon)
local txt=''
if buffType==1 then
txt=buffCfg.desc or''
elseif buffType==2 then
for i,v in ipairs(effects)do
local effectid=effects[i]
local desc=homeBuffModel:getBuffDesc(effectid)
desc=string.replaceSpace(desc)
txt=txt~=''and FMT.fmt('{0}\n{1}',txt,desc)or desc
end
end
txt=string.gsub(txt,"aae252","549327")

self.desc1:setText(txt)
self.icon:setImageIcon(iconname,false)
self.name:setText(buffCfg.name)
self.clock:setActive(self.showTime)
if self.showTime then
if buffCfg.durationDesc then
self.time:setText(buffCfg.durationDesc)
else
local stamp=timeHelper.getServerShortTime()
local left=endStamp-stamp
if left>0 then
self.time:setText(timeHelper.format_time_stamp13(left))
self:setTimer(1,0,function()
self:freshLeftTime()
end)
else
self.time:setText('')
end
end
else
self.time:setText('')
end

local weakGuide=argtable.weakGuide
if weakGuide then
local key=weakGuide[1]
local id=weakGuide[2]
self.widget:SetChildWeakGuideComponentId(-1,key)
if id then

timeEventController.delayDo(0.3,function()
weakGuideController:beginGuide(id)
end)
end
end
end

function UIXianJieHomeBuffItem:freshLeftTime()
if self.endStamp and self.showTime then
local endStamp=self.endStamp
local stamp=timeHelper.getServerShortTime()
local left=endStamp-stamp
if left>0 then
self.time:setText(timeHelper.format_time_stamp13(left))
else
self.time:setText('')
end
end
end

function UIXianJieHomeBuffItem:onHide()

end


