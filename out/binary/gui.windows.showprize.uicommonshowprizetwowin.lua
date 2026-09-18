







def_class("UICommonShowPrizeTwoWin",UIWindowBase)









function UICommonShowPrizeTwoWin:bindComponents()

self.tipsText=UIText.get(self,0)
self.rwScrollView=UIObject.get(self,1)
self.tips=UIText.get(self,2)
self.creater=UIGameobjectClone.new(self,3)
self.effect=UIObject.get(self,4)



end


function UICommonShowPrizeTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.tips);self.tips=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.effect);self.effect=nil;
end




























function UICommonShowPrizeTwoWin:onLoaded(...)
self:bindComponents()
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)

UIManager.setMoneyMsgShowState(false,true)
end

function UICommonShowPrizeTwoWin:__delete()
self.rwScrollView:setChildScrollViewStopGridCreate()

self:unbindComponents()

if self.callback then
self.callback()
end

UIManager.setMoneyMsgShowState(true,true)

end

function UICommonShowPrizeTwoWin:onShow(argtable,afterOnloaded)

self.callback=argtable.callback
local tipsStr=argtable.tips or''
local closeTips=argtable.closeTips or'点击空白区域关闭'













self.tips:setText(tipsStr)
self.tipsText:setText(closeTips)
self.effect:setChildShowEffect(10014,true)




local rewards=argtable.list
local len=#rewards
self.rwScrollView:setChildScrollViewDelayCreateGrids(len,math.min(len,5),0.15,1,false,false,function(index,item)
local rwdata=rewards[index+1]
widgetHelper.setNormalRewardItem(item,0,{rwdata.itemid,rwdata.num,guid=rwdata.itemguid})
if rwdata.name then
local name=FMT.fmt('<color={0}>{1}</color>',FONT_COLOR_VAL[rwdata.color],rwdata.name)
item:SetChildText(1,name)
else
item:SetChildText(1,'')
end
end)
end

















function UICommonShowPrizeTwoWin:onHide()

end










