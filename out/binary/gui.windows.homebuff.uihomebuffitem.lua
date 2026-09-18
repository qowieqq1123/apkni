







def_class("UIHomeBuffItem",UICloneObject)





UIHomeBuffItem.abName="ui/windows/homebuff/uihomebuffitem.ab"

UIHomeBuffItem.assetName="UIHomeBuffItem"

local spetqid=
{
[3001]=true,

}
function UIHomeBuffItem:bindComponents()

self.icon=UIImage.get(self,0)
self.name=UIText.get(self,1)
self.time=UIText.get(self,2)
self.clock=UIObject.get(self,3)
self.line=UIObject.get(self,4)
self.desc1=UIText.get(self,5)
self.uneffect=UIText.get(self,6)

end


function UIHomeBuffItem:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.clock);self.clock=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.desc1);self.desc1=nil;
_UIObject_release(self.uneffect);self.uneffect=nil;
end








function UIHomeBuffItem:onLoaded(...)
self:bindComponents()
self:setTimer(1,0,function()
if self and not self.isClose then
self:freshLeftTime()
end
end)
end

function UIHomeBuffItem:__delete()
self:unbindComponents()
end

function UIHomeBuffItem:onShow(argtable,afterOnloaded)
local id=argtable[1]
local endStamp=argtable[2]
local idx=argtable.idx
local len=argtable.len
self.id=id
self.endStamp=endStamp
local guildstateconfig=cfg_guildstateconfig_get(id)
local showTimeByConfig=guildstateconfig.showtime~=false
local isEveryTime=endStamp<=0
local showTime=not isEveryTime and showTimeByConfig or false
self.showTime=showTime
local effects=guildstateconfig.effects
local iconname=iconHelper.getzmStateIcon(guildstateconfig.icon)
local txt=''
local hasHigher=homeBuffModel.hasHigherLevelBuff(id)
for i,v in ipairs(effects)do
local effectid=effects[i]
if spetqid[effectid]then
local buffnum=homeBuffModel.getBuffAddValue(BUFF_EFFECT_TYPE.eZongmenMiJingDoubleChanged)or 0
local num=MysteryModel:getMJbuffUseNum()
if num<buffnum then
local desc=homeBuffModel:getBuffDesc(effectid)
if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
desc=string.replaceSpace(desc)
end
txt=txt~=''and FMT.fmt('{0}\n{1}',txt,desc)or desc
end
else
local desc=homeBuffModel:getBuffDesc(effectid)
if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
desc=string.replaceSpace(desc)
end
txt=txt~=''and FMT.fmt('{0}\n{1}',txt,desc)or desc
end
end
if hasHigher then
txt=FMT.cfmt(FONT_COLOR.eRedColor,'已有更高阶效果生效中')
end
self.line:setActive(idx==1)
self.desc1:setText(txt)
self.icon:setImageIcon(iconname,false)
self.icon:setImageExGray(hasHigher)
self.name:setText(guildstateconfig.name)

self.clock:setActive(showTime)
if showTime then
local stamp=timeHelper.getServerShortTime()
local left=endStamp-stamp
if left>0 then
self.time:setText(timeHelper.format_time_stamp13(left))
else
self.time:setText('')
end
else
self.time:setText('')
end
end

function UIHomeBuffItem:freshLeftTime()
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

function UIHomeBuffItem:onHide()

end


