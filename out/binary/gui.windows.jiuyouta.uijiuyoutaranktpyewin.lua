







def_class("UIJiuYouTaRankTpyeWin",UIWindowBase)









function UIJiuYouTaRankTpyeWin:bindComponents()

self.rankBtn_1=UIButton.get(self,0)
self.rankBtn_2=UIButton.get(self,1)
self.rankSelect_1=UIObject.get(self,2)
self.rankSelect_2=UIObject.get(self,3)

self.rankBtn_1:setButtonClick(function()self:onRankBtn_1()end)

self.rankBtn_2:setButtonClick(function()self:onRankBtn_2()end)
self.rankBtn={
self.rankBtn_1,
self.rankBtn_2,
}
self.rankSelect={
self.rankSelect_1,
self.rankSelect_2,
}



end


function UIJiuYouTaRankTpyeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rankBtn_1);self.rankBtn_1=nil;
_UIObject_release(self.rankBtn_2);self.rankBtn_2=nil;
_UIObject_release(self.rankSelect_1);self.rankSelect_1=nil;
_UIObject_release(self.rankSelect_2);self.rankSelect_2=nil;
self.rankBtn=nil;
self.rankSelect=nil;
end


















local winConfig=
{
{name="UIJiuYouTaRank2Win",},
{name="UIJiuYouTaRankWin",},
}


function UIJiuYouTaRankTpyeWin:onLoaded(...)
self:bindComponents()
end


function UIJiuYouTaRankTpyeWin:__delete()
self:unbindComponents()
end




function UIJiuYouTaRankTpyeWin:onShow(argtable,afterOnloaded)
local tabType=argtable.tabType
self:onWinOpen(tabType)
end


function UIJiuYouTaRankTpyeWin:onHide()

end

function UIJiuYouTaRankTpyeWin:onWinOpen(tabType)
local old=self.tabType
if old then
self:hideWindow(winConfig[old].name)
self.rankSelect[old]:setActive(false)
end
self:showWindow(winConfig[tabType].name)
self.rankSelect[tabType]:setActive(true)
self.tabType=tabType
end

function UIJiuYouTaRankTpyeWin:onRankBtn_1()
self:onWinOpen(1)
end

function UIJiuYouTaRankTpyeWin:onRankBtn_2()
self:onWinOpen(2)
end

function UIJiuYouTaRankTpyeWin:onBg()
self:closeSelf()
end


