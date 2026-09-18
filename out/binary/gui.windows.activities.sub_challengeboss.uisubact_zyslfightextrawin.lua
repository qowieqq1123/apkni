







def_class("UISubAct_zyslFightExtraWin",UIWindowBase)









function UISubAct_zyslFightExtraWin:bindComponents()

self.desc=UIText.get(self,0)



end


function UISubAct_zyslFightExtraWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desc);self.desc=nil;
end



















function UISubAct_zyslFightExtraWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_zyslFightExtraWin:__delete()
self:unbindComponents()
end




function UISubAct_zyslFightExtraWin:onShow(argtable,afterOnloaded)
local id=argtable[5]
local lv=argtable[6]
local config=cfgHelper.get1(cfg_sslawruleconfig_get,id)
local text=config.desc
local value=string.format("%d%%",unpack(config.descparm[lv]))
text=string.format("%s<color=#56942B>%s</color>",text,value)
self.desc:setText(text)
end


function UISubAct_zyslFightExtraWin:onHide()

end



