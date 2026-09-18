







def_class("UIWuXingDianFightPrepareWin",UIWindowBase)









function UIWuXingDianFightPrepareWin:bindComponents()

self.stars_1=UIObject.get(self,0)
self.stars_2=UIObject.get(self,1)
self.stars_3=UIObject.get(self,2)
self.stars={
self.stars_1,
self.stars_2,
self.stars_3,
}



end


function UIWuXingDianFightPrepareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.stars_1);self.stars_1=nil;
_UIObject_release(self.stars_2);self.stars_2=nil;
_UIObject_release(self.stars_3);self.stars_3=nil;
self.stars=nil;
end


















function UIWuXingDianFightPrepareWin:onLoaded(...)
self:bindComponents()
end

function UIWuXingDianFightPrepareWin:__delete()
self:unbindComponents()
end

function UIWuXingDianFightPrepareWin:onShow(argtable,afterOnloaded)
local wxdId=argtable.wxdId
local layer=argtable.layer
local starTag=argtable.star_bits or 0
local stardesc=cfgHelper.get2(cfg_fiveelementsholytempleconfig_get,0,'stardesc')
local layerCfg=wuXingDianModel:getLayerCfg(wxdId,layer)
local target_condition=layerCfg.target_condition or{}
for i=1,3 do
local targetInfo=target_condition[i]
self.stars[i]:setActive(targetInfo~=nil)
if targetInfo~=nil then
local targetType=targetInfo[1]
local desc=stardesc[targetType]
if#targetInfo>1 then
local t={}
local t=table.getRange(targetInfo,2)
desc=FMT.fmt(desc,unpack(t))
end
local widget=self.stars[i]:getChildWidgetBase()
local pass=mathHelper.getBitValue(starTag,i-1)
widget:SetChildActive(0,pass)
widget:SetChildText(1,desc)
end
end
end

function UIWuXingDianFightPrepareWin:onHide()

end



