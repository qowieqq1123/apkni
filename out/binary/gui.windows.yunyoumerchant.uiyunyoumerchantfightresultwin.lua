







def_class("UIYunYouMerchantFightResultWin",UIWindowBase)









function UIYunYouMerchantFightResultWin:bindComponents()

self.tipsTx=UIText.get(self,0)
self.progressBar=UIProgress.get(self,1)



end


function UIYunYouMerchantFightResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
end



















function UIYunYouMerchantFightResultWin:onLoaded(...)
self:bindComponents()
end


function UIYunYouMerchantFightResultWin:__delete()
self:unbindComponents()
end




function UIYunYouMerchantFightResultWin:onShow(argtable,afterOnloaded)
self.tipsTx:setText(argtable.tips or"")
local progressData=argtable.progress
self.progressBar:setActive(progressData~=nil)
if progressData then
self.progressBar:setProgressValue(math.floor(progressData[1]/progressData[2]*10000),10000)
if progressData[3]then
self:delayDo(2,function()
self.progressBar:setProgress(math.floor(progressData[3]/progressData[2]*10000),10000)
end)
end
end
end


function UIYunYouMerchantFightResultWin:onHide()

end



