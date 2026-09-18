







def_class("UIGuPiaoShiJianJiLuWin",UIWindowBase)









function UIGuPiaoShiJianJiLuWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.ScrollView=UIObject.get(self,1)
self.Content=UIObject.get(self,2)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIGuPiaoShiJianJiLuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Content);self.Content=nil;
end



















function UIGuPiaoShiJianJiLuWin:onLoaded(...)
self:bindComponents()
end


function UIGuPiaoShiJianJiLuWin:__delete()
self:unbindComponents()
end




function UIGuPiaoShiJianJiLuWin:onShow(argtable,afterOnloaded)
self:freshEventPanel()
end


function UIGuPiaoShiJianJiLuWin:onHide()

end




function UIGuPiaoShiJianJiLuWin:freshEventPanel()
local eventList=shangHangModel:getEventList(true,true)

self.Content:setChildLayoutGroupCreateItems(#eventList)
local items=self.Content:getChildLayoutGroupGridList()
local now=timeHelper.getServerShortTime()

self.Content:setLocalPosY(10000)
for i=1,items.Count do
local grid=items[i-1]
local event=eventList[i]
local id=event.id
local percent=event.percent
local time=event.time
local times=event.times
local et=event.type
local cfg=cfgHelper.get(cfg_shanghangeventconfig_get,id)
local text
local nextTime=shangHangModel:getNextChangeTime(true,timeHelper.convertLongStamp(time))
if et==eShangHangEventType.eHear then
if not cfg then
cfg=cfgHelper.get(cfg_shanghangitemeventconfig_get,id)
text=cfg.text1
end
text=cfg.text1
grid:SetChildIcon(0,"icon_shangshievent_0",false)
if now>=nextTime then
grid:SetChildText(1,FMT.fmt("<color=#6833c0>传闻：</color>{0}",FMT.fmt(text,math.abs(percent))))
else
grid:SetChildText(1,FMT.fmt("<color=#bb8cf1>传闻：</color>{0}",FMT.fmt(text,math.abs(percent))))
end
grid:SetChildActive(3,false)
elseif et==eShangHangEventType.eItemEvent then

cfg=cfgHelper.get(cfg_shanghangitemeventconfig_get,id)
if percent>0 then
if cfg.text2 then
text=cfg.text2[times]or cfg.text2[#cfg.text2]
else
text=''
loggerUtil.logErrFMT('{0} 该事件上涨{1}%但没配置上涨文本',id,math.abs(percent))
end
grid:SetChildIcon(0,"icon_shangshievent_1",false)
else
if cfg.text3 then
text=cfg.text3[times]or cfg.text3[#cfg.text3]
else
text=''
loggerUtil.logErrFMT('{0} 该事件下跌{1}%但没配置下跌文本',id,math.abs(percent))
end
grid:SetChildIcon(0,"icon_shangshievent_2",false)
end
if percent>0 then
grid:SetChildText(1,FMT.fmt("<color=#fd8950>事件：</color>{0}",FMT.fmt(text,FMT.cfmt(FONT_COLOR.eRedColor,math.abs(percent)))))
else
grid:SetChildText(1,FMT.fmt("<color=#fd8950>事件：</color>{0}",FMT.fmt(text,FMT.cfmt(FONT_COLOR.eGreenColor,math.abs(percent)))))
end
else

if percent>0 then
if cfg.text2 then
text=cfg.text2[times]or cfg.text2[#cfg.text2]
else
text=''
loggerUtil.logErrFMT('{0} 该事件上涨{1}%但没配置上涨文本',id,math.abs(percent))
end
else
if cfg.text3 then
text=cfg.text3[times]or cfg.text3[#cfg.text3]
else
text=''
loggerUtil.logErrFMT('{0} 该事件下跌{1}%但没配置下跌文本',id,math.abs(percent))
end
end
grid:SetChildIcon(0,FMT.fmt("icon_shangshievent_{0}",event.upType),false)
if percent>0 then
grid:SetChildText(1,FMT.fmt("<color=#fd8950>事件：</color>{0}",FMT.fmt(text,FMT.cfmt(FONT_COLOR.eRedColor,math.abs(percent)))))
else
grid:SetChildText(1,FMT.fmt("<color=#fd8950>事件：</color>{0}",FMT.fmt(text,FMT.cfmt(FONT_COLOR.eGreenColor,math.abs(percent)))))
end
end

grid:SetChildText(2,timeHelper.getTwoFormatByStamp(timeHelper.convertLongStamp(time)))
grid:SetChildText(4,times)

grid:SetChildActive(6,now>=nextTime)
grid:SetChildDoBrightness(6,now>=nextTime and 0.8 or 1,0,nil)

end
end





function UIGuPiaoShiJianJiLuWin:onCloseBtn()
self:closeSelf()
end

