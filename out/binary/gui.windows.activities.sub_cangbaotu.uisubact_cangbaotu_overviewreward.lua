







def_class("UISubAct_CangBaoTu_OverViewReward",UIWindowBase)









function UISubAct_CangBaoTu_OverViewReward:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.rewradView=UIScrollView.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_CangBaoTu_OverViewReward:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.rewradView);self.rewradView=nil;
end















local _this=nil




function UISubAct_CangBaoTu_OverViewReward:onLoaded(...)
self:bindComponents()
_this=self

self.rewradView:setClickAction(itemsComponentHelper.onItemClick)
end


function UISubAct_CangBaoTu_OverViewReward:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_CangBaoTu_OverViewReward:onShow(argtable,afterOnloaded)
local props={}
for i,v in ipairs(argtable.reward or{})do
local conf={itemid=v,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
table.insert(props,props)
end
local count=#props
self.rewradView:freshGridsNum(count,math.ceil(count/4),4,true)
self.rewradView:initPropData(props)
end


function UISubAct_CangBaoTu_OverViewReward:onHide()

end




function UISubAct_CangBaoTu_OverViewReward:onCloseBtn()
self:closeSelf()
end

function UISubAct_CangBaoTu_OverViewReward:onBackground()
self:closeSelf()
end