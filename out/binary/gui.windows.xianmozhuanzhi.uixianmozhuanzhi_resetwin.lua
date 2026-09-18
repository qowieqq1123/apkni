







def_class("UIXianMoZhuanZhi_resetWin",UIWindowBase)









function UIXianMoZhuanZhi_resetWin:bindComponents()

self.mask=UIButton.get(self,0)
self.resetBtn=UIButton.get(self,1)
self.reverseBtn=UIButton.get(self,2)

self.mask:setButtonClick(function()self:onMask()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)

self.reverseBtn:setButtonClick(function()self:onReverseBtn()end)



end


function UIXianMoZhuanZhi_resetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.reverseBtn);self.reverseBtn=nil;
end



















function UIXianMoZhuanZhi_resetWin:onLoaded(...)
self:bindComponents()
end


function UIXianMoZhuanZhi_resetWin:__delete()
self:unbindComponents()
end




function UIXianMoZhuanZhi_resetWin:onShow(argtable,afterOnloaded)
self.dis_guid=argtable
end


function UIXianMoZhuanZhi_resetWin:onHide()

end


function UIXianMoZhuanZhi_resetWin:onMask()
self:closeSelf()
end

function UIXianMoZhuanZhi_resetWin:onResetBtn()
local arg=
{
guid=self.dis_guid,
isFull=true,
reset=true,
}
jumpManager:jump({id=JUMP_TYPE.eWenXinGuan_Transfer,args=arg})
end

function UIXianMoZhuanZhi_resetWin:onReverseBtn()
local arg=
{
guid=self.dis_guid,
isFull=true,
reverse=true,
}
jumpManager:jump({id=JUMP_TYPE.eWenXinGuan_Transfer,args=arg})
end

