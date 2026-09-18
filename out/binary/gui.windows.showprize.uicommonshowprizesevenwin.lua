







def_class("UICommonShowPrizeSevenWin",UIWindowBase)









function UICommonShowPrizeSevenWin:bindComponents()

self.tipsText=UIText.get(self,0)
self.rwScrollView=UIObject.get(self,1)
self.tips=UIText.get(self,2)
self.creater=UIGameobjectClone.new(self,3)
self.effect=UIObject.get(self,4)
self.rankBtn=UIButton.get(self,5)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)



end


function UICommonShowPrizeSevenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.tips);self.tips=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
end















local _this=nil



function UICommonShowPrizeSevenWin:onLoaded(...)
self:bindComponents()
_this=nil
end


function UICommonShowPrizeSevenWin:__delete()
self:unbindComponents()
_this=nil
end




function UICommonShowPrizeSevenWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
local tipsStr=argtable.tips or''
local closeTips=argtable.closeTips or'点击空白区域关闭'

self.tips:setText(tipsStr)
self.tipsText:setText(closeTips)
self.effect:setChildShowEffect(10014,true)

AudioManager.playAudio(407)

local rewards=argtable.list
local len=#rewards
local col=math.min(len,5)
self.rwScrollView:setChildScrollViewStopGridCreate()
self.rwScrollView:setChildScrollViewCreateGrids(len,col)
self.rwScrollView:setChildSizeDelta(col*90,110)
local items=self.rwScrollView:getChildScrollViewItemWidgets()

for i=1,len do
local rwdata=rewards[i]
local item=items[i-1]
widgetHelper.setNormalRewardItem(item,0,{rwdata.itemid,rwdata.num,guid=rwdata.itemguid})
if rwdata.name then
local name=FMT.fmt('<color={0}>{1}</color>',FONT_COLOR_VAL[rwdata.color],rwdata.name)
item:SetChildText(1,name)
else
item:SetChildText(1,'')
end
end
end


function UICommonShowPrizeSevenWin:onHide()

end





function UICommonShowPrizeSevenWin:onRankBtn()
if self.callback then
self.callback()
end
end

