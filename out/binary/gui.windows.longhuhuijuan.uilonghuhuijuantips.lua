







def_class("UILongHuHuiJuanTips",UIWindowBase)









function UILongHuHuiJuanTips:bindComponents()

self.root=UIObject.get(self,0)
self.Title=UIText.get(self,1)
self.text=UIText.get(self,2)
self.time=UIText.get(self,3)



end


function UILongHuHuiJuanTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.Title);self.Title=nil;
_UIObject_release(self.text);self.text=nil;
_UIObject_release(self.time);self.time=nil;
end



















function UILongHuHuiJuanTips:onLoaded(...)
self:bindComponents()
end


function UILongHuHuiJuanTips:__delete()
self:unbindComponents()
end




function UILongHuHuiJuanTips:onShow(argtable,afterOnloaded)
local showType=argtable.showType or eArrowDirectionType.eBottomLeft
local showTitle=argtable.showTitle
if showTitle==nil then
showTitle=true
end
local pos=nil
if argtable.posItem then
pos=argtable.posItem:getChildScreenPointToLocalPointRectangle()
elseif argtable.posWidget then
local posWidgetIndex=argtable.posWidgetIndex or-1
pos=argtable.posWidget:GetChildScreenPointToLocalPointRectangle(posWidgetIndex)
end
if pos then
local p=argtable.pos or{x=0,y=0}
pos.x=pos.x+p.x
pos.y=pos.y+p.y
else
pos=argtable.pos or Vector2.zero
end

local buffid=argtable.buffid

if pos then
self.root:setChildLocalPosition(Vector3.New(pos.x,pos.y,0))
end

local buffCfg=cfg_guildstateconfig_get(buffid)
local name=buffCfg.name

self.Title:setText(name)
self.text:setText(self:getBuffDesc(buffid))

local info=homeBuffModel.getBuffInfoByIdSrc(buffid,1)
if info then
local endTime=info[2]

local cb=function()
local now=timeHelper.getServerShortTime()
if endTime-now>0 then
self.time:setText(FMT.fmt("效果时间：{0}",timeHelper.format_time_stamp3(endTime-now)))
else
self.time:setText(FMT.cfmt(FONT_COLOR.eRedColor,"已过期"))
if self.timerUpdate then
self:stopTimerByID(self.timerUpdate)
self.timerUpdate=nil
end
end
end
cb()
self.timerUpdate=self:setTimer(1,0,cb)
end
end



function UILongHuHuiJuanTips:getBuffDesc(id)
local desc=""
local effects=cfgHelper.get2(cfg_guildstateconfig_get,id,'effects')
for kk,vv in pairs(effects)do
local str=cfgHelper.get2(cfg_guildstateeffectconfig_get,vv,'desc')
desc=FMT.fmt("{0}{1}",desc,str)
if kk<#effects then
desc=FMT.fmt("{0}{1}",desc,'\n')
end
end
return desc
end



function UILongHuHuiJuanTips:onHide()

end



