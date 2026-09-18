







def_class("UIRankListEnterWin",UIWindowBase)









function UIRankListEnterWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.hundunbei=UIButton.get(self,1)
self.wanlingbei=UIButton.get(self,2)
self.wujibei=UIButton.get(self,3)
self.reddot=UIObject.get(self,4)
self.dragonBone=UIObject.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.hundunbei:setButtonClick(function()self:onHundunbei()end)

self.wanlingbei:setButtonClick(function()self:onWanlingbei()end)

self.wujibei:setButtonClick(function()self:onWujibei()end)



end


function UIRankListEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.hundunbei);self.hundunbei=nil;
_UIObject_release(self.wanlingbei);self.wanlingbei=nil;
_UIObject_release(self.wujibei);self.wujibei=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.dragonBone);self.dragonBone=nil;
end



















function UIRankListEnterWin:onLoaded(...)
self:bindComponents()
self.animationPlaying=true
self:delayDo(0.5,function()
self.dragonBone:setActive(true)

AudioManager.playAudio(539)
end)
self:delayDo(1.5,function()
self.animationPlaying=false
self:refreshReddot()
end)
end


function UIRankListEnterWin:__delete()
self:unbindComponents()
end




function UIRankListEnterWin:onShow(argtable,afterOnloaded)

end


function UIRankListEnterWin:onHide()

end




function UIRankListEnterWin:onCloseBtn()
UIFullZaoHuaTianBeiControl:closeWindow("UIRankListWuJiBeiWin")
UIFullZaoHuaTianBeiControl:closeWindow("UIRankListWanLingBeiWin")
UIFullZaoHuaTianBeiControl:closeWindow("UIRankListHunDunBeiWin")
UIFullZaoHuaTianBeiControl:closeUI(true,false)
end


function UIRankListEnterWin:onHundunbei()
if not self.animationPlaying then
UIFullZaoHuaTianBeiControl:openHunDunBei()
end
end


function UIRankListEnterWin:onWanlingbei()
if not self.animationPlaying then
UIFullZaoHuaTianBeiControl:openWanLingBei()
end
end


function UIRankListEnterWin:onWujibei()
if not self.animationPlaying then
UIFullZaoHuaTianBeiControl:openWuJiBei()
end
end

function UIRankListEnterWin:refreshReddot()
local reddot=wuJiBeiModel:getAllReddot()
self.reddot:setActive(reddot)
end