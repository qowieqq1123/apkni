







def_class("UITipLianDonWin",UIWindowBase)









function UITipLianDonWin:bindComponents()

self.bg=UIButton.get(self,0)
self.Image=UIImage.get(self,1)
self.timeBg=UIImage.get(self,2)
self.timeText=UIText.get(self,3)

self.bg:setButtonClick(function()self:onBg()end)



end


function UITipLianDonWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.Image);self.Image=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeText);self.timeText=nil;
end



















function UITipLianDonWin:onLoaded(...)
self:bindComponents()
end


function UITipLianDonWin:__delete()
self:unbindComponents()
end




function UITipLianDonWin:onShow(argtable,afterOnloaded)
local linkageId=argtable.linkageId or 1
local liandonCfg=liandonModel:getLianDonConfig(linkageId)
self.Image:setSprite(globalABLookup.liandonLogin,liandonCfg.image)
self.timeBg:setActive(false)


end


function UITipLianDonWin:onHide()

end

function UITipLianDonWin:onBg()
self:closeSelf()
end



