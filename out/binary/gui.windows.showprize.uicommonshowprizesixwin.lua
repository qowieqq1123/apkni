







def_class("UICommonShowPrizeSixWin",UIWindowBase)









function UICommonShowPrizeSixWin:bindComponents()

self.tipsText=UIText.get(self,0)
self.rwScrollView=UIObject.get(self,1)
self.tips=UIText.get(self,2)
self.effect=UIObject.get(self,3)



end


function UICommonShowPrizeSixWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.effect);self.effect=nil;
end


















function UICommonShowPrizeSixWin:onLoaded(...)
self:bindComponents()
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
UIManager.setMoneyMsgShowState(false,true)
end

function UICommonShowPrizeSixWin:__delete()
self.rwScrollView:setChildScrollViewStopGridCreate()
UIManager.setMoneyMsgShowState(true,true)
self:unbindComponents()
end

function UICommonShowPrizeSixWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
local tipsStr=argtable.tips or''
local closeTips=argtable.closeTips or'点击空白区域关闭'

self.tips:setText(tipsStr)
self.tipsText:setText(closeTips)
self.effect:setChildShowEffect(10014,true)

local rewards=argtable.list
local len=#rewards
self.rwScrollView:setChildScrollViewStopGridCreate()







self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,5))
local items=self.rwScrollView:getChildScrollViewItemWidgets()
for i=1,len do
local rwdata=rewards[i]
local item=items[i-1]
widgetHelper.setNormalRewardItem(item,0,{rwdata.itemid,rwdata.num,guid=rwdata.itemguid})
end
end

function UICommonShowPrizeSixWin:onHide()

end



function UICommonShowPrizeSixWin:onClickBg()
self:closeSelf()
end