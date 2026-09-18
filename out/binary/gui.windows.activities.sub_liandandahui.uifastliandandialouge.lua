







def_class("UIfastLianDanDialouge",UIWindowBase)









function UIfastLianDanDialouge:bindComponents()

self.autoLayout=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.selectCntSlider=UIObject.get(self,2)
self.titleText=UIText.get(self,3)
self.dialougeIcon=UIImage.get(self,4)
self.dialougeText=UILinkImageText.get(self,5)
self.costText=UIText.get(self,6)
self.cancelButton=UIButton.get(self,7)
self.okButton=UIButton.get(self,8)
self.cancelText=UIText.get(self,9)
self.okText=UIText.get(self,10)
self.handleImg=UIObject.get(self,11)
self.maxCnt=UIButton.get(self,12)
self.subBtn=UIButton.get(self,13)
self.addBtn=UIButton.get(self,14)
self.selectCntText=UIText.get(self,15)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)



end


function UIfastLianDanDialouge:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.autoLayout);self.autoLayout=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.dialougeIcon);self.dialougeIcon=nil;
_UIObject_release(self.dialougeText);self.dialougeText=nil;
_UIObject_release(self.costText);self.costText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
end



















function UIfastLianDanDialouge:onLoaded(...)
self:bindComponents()
end


function UIfastLianDanDialouge:__delete()
self:unbindComponents()
end


function UIfastLianDanDialouge:saveTimes()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eLianDanDaHui,"selectTimes",self.selectCnt)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eLianDanDaHui)
end




function UIfastLianDanDialouge:onShow(argtable,afterOnloaded)
self.config=argtable.config
self.callback=argtable.callback
self.actid,self.subType,self.subid=argtable.actid,argtable.subType,argtable.subid
local cost=argtable.config.consume
local iconname=iconHelper.getIconName(cost[1][1])
self.unitPrice=cost[1][2]
self.dialougeIcon:setChildIcon(iconname)

local count=itemsModel.getCount(cost[1][1])
local countTimes=math.floor(count/cost[1][2])
self.max=countTimes>=self.config.times[2]and self.config.times[2]or countTimes
if self.max==0 then
self.max=1
end
self.min=1

self.selectCnt=userActorArraySetting.get(ACTOR_SETTING_TYPE.eLianDanDaHui,"selectTimes",self.min)

self.need=self.selectCnt*self.unitPrice

local func=function(...)
self:onSliderChange(...)
end

self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIfastLianDanDialouge:onSliderChange(value)

self.selectCnt=value
self.selectCntText:setText(self.selectCnt)
self.need=self.selectCnt*self.unitPrice
self.costText:setText(FMT.fmt("<color=#843c0c>{0}</color>进行炼丹",self.need))
end


function UIfastLianDanDialouge:onHide()

end





function UIfastLianDanDialouge:onCloseBtn()
self:closeSelf()
end



function UIfastLianDanDialouge:onCancelButton()
self:closeSelf()
end



function UIfastLianDanDialouge:onOkButton()
local callback=self.callback
if callback then
callback(self.selectCnt)
end
self:saveTimes()
self:closeSelf()
end



function UIfastLianDanDialouge:onMaxCnt()
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.max)
end



function UIfastLianDanDialouge:onSubBtn()
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIfastLianDanDialouge:onAddBtn()
if self.max<=1 then
return
end

if self.min==self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


function UIfastLianDanDialouge:onBGClick()
self:closeSelf()
end
