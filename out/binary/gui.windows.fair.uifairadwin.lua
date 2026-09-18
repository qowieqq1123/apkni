







def_class("UIFairAdWin",UIWindowBase)









function UIFairAdWin:bindComponents()

self.center_btn=UIButton.get(self,0)
self.sur_btn=UIButton.get(self,1)
self.desc=UIText.get(self,2)

self.center_btn:setButtonClick(function()self:onCenter_btn()end)

self.sur_btn:setButtonClick(function()self:onSur_btn()end)
self.center={
["btn"]=self.center_btn,
}
self.sur={
["btn"]=self.sur_btn,
}



end


function UIFairAdWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.center_btn);self.center_btn=nil;
_UIObject_release(self.sur_btn);self.sur_btn=nil;
_UIObject_release(self.desc);self.desc=nil;
self.center=nil;
self.sur=nil;
end



















function UIFairAdWin:onLoaded(...)
self:bindComponents()
end


function UIFairAdWin:__delete()
self:unbindComponents()
end




function UIFairAdWin:onShow(argtable,afterOnloaded)
local descStr=''
local index=1

for i=index,10,1 do
local descIndex=string.format('cangjingge_desc_%d',index)
local str=cfgHelper.get1(cfg_lang_get,descIndex)
if str==nil then
break
end

descStr=descStr..'\n'..str
index=index+1
end
self.desc:setText(descStr)
end


function UIFairAdWin:onHide()

end





function UIFairAdWin:onCenter_btn()
self:closeSelf()
end



function UIFairAdWin:onSur_btn()




self:closeSelf()
end

