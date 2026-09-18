







def_class("tipsChildUseLimit",UICloneObject)





tipsChildUseLimit.abName="ui/windows/tips/child/tipschilduselimit.ab"

tipsChildUseLimit.assetName="tipsChildUseLimit"


function tipsChildUseLimit:bindComponents()

self.useCountText=UIText.get(self,0)

end


function tipsChildUseLimit:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.useCountText);self.useCountText=nil;
end


local _this








function tipsChildUseLimit:onLoaded(...)
_this=self
self:bindComponents()

notifySystem:listenNotify(notifyConfig.onItemUseCountChange,self.onItemUseCountChange)
end


function tipsChildUseLimit:__delete()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.onItemUseCountChange,self.onItemUseCountChange)
end




function tipsChildUseLimit:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
self.itemid=data.itemid
self.itemguid=data.itemguid
self.itemConfig=itemsConfig.getConfig(self.itemid)


local useLimit=self.itemConfig and self.itemConfig.uselimit or nil
if not useLimit then

self:recycleSelf()
return
end

self:refresh()
end


function tipsChildUseLimit:onHide()

end

function tipsChildUseLimit:refresh()
local useLimit=self.itemConfig and self.itemConfig.uselimit
local maxUseCount=useLimit[2]
local limitType=useLimit[1]
local limitTypeName=''
if limitType==1 then

limitTypeName="今日"
elseif limitType==2 then

limitTypeName="本周"
end


local nowUseCount=bagModel:getItemUseCount(self.itemid)
local useCountStr=''
if nowUseCount>=maxUseCount then
useCountStr=FMT.fmt("{0}剩余次数：<color={1}>0</color>",limitTypeName,FONT_COLOR_VAL[FONT_COLOR.eRedColor])
else
local canUseCount=maxUseCount-nowUseCount
useCountStr=FMT.fmt("{0}剩余次数：<color={2}>{1}</color>",limitTypeName,canUseCount,FONT_COLOR_VAL[FONT_COLOR.eGreenTxtColor])
end
self.useCountText:setText(useCountStr)
end


function tipsChildUseLimit.onItemUseCountChange()
if not _this then
return
end

_this:refresh()
end

