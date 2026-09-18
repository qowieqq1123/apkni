







def_class("UIHouShanZhenLingPrepareTop",UIWindowBase)









function UIHouShanZhenLingPrepareTop:bindComponents()

self.layer=UIObject.get(self,0)
self.layerText=UIText.get(self,1)
self.icon=UIImage.get(self,2)


self.sprite_button_zdjiasu_1=0
self.sprite_button_zdjiasu_2=1
self.sprite_button_zdjiasu_3=2

end


function UIHouShanZhenLingPrepareTop:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.layer);self.layer=nil;
_UIObject_release(self.layerText);self.layerText=nil;
_UIObject_release(self.icon);self.icon=nil;
end
















local transId={
[2]=1,
[3]=2,
}




function UIHouShanZhenLingPrepareTop:onLoaded(...)
self:bindComponents()
end


function UIHouShanZhenLingPrepareTop:__delete()
self:unbindComponents()
end




function UIHouShanZhenLingPrepareTop:onShow(argtable,afterOnloaded)
self.type=argtable.type
self.layer2=argtable.layer

local cfg=cfgHelper.get2(cfg_houshanzhenlingjiecengconfig_get,self.type,self.layer2)
self.layer:setActive(true)
local tname=string.gsub(cfg.name,"%b()","")
self.layerText:setText(tname)

local isShowIcon=transId[cfg.mostertype]~=nil
self.icon:setActive(isShowIcon)
if isShowIcon then
local id=transId[cfg.mostertype]
local iconName=FMT.fmt("icon_guaiwubiaoqian_{0}",id)
self.icon:setCSImageSprite(globalABLookup.global,iconName)
end
end


function UIHouShanZhenLingPrepareTop:onHide()

end



