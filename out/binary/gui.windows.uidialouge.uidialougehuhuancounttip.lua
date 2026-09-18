







def_class("UIDialougeHuHuanCountTip",UIWindowBase)









function UIDialougeHuHuanCountTip:bindComponents()

self.addBtn=UIButton.get(self,0)
self.cancelButton=UIButton.get(self,1)
self.cancelText=UIText.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.handleImg=UIObject.get(self,4)
self.itemPanel=UIObject.get(self,5)
self.leftRewardItem=UIObject.get(self,6)
self.linkImageText1=UILinkImageText.get(self,7)
self.linkImageText2=UILinkImageText.get(self,8)
self.maxCnt=UIButton.get(self,9)
self.okButton=UIButton.get(self,10)
self.okText=UIText.get(self,11)
self.rightRewardItem=UIObject.get(self,12)
self.selectCntSlider=UIObject.get(self,13)
self.selectCntText=UIText.get(self,14)
self.sliderRoot=UIObject.get(self,15)
self.subBtn=UIButton.get(self,16)
self.tipsBtn=UIButton.get(self,17)
self.tipsPanel=UIObject.get(self,18)
self.tipsRoot=UIButton.get(self,19)
self.tipsTx=UIText.get(self,20)
self.titleText=UIText.get(self,21)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.tipsRoot:setButtonClick(function()self:onTipsRoot()end)



end


function UIDialougeHuHuanCountTip:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.leftRewardItem);self.leftRewardItem=nil;
_UIObject_release(self.linkImageText1);self.linkImageText1=nil;
_UIObject_release(self.linkImageText2);self.linkImageText2=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.rightRewardItem);self.rightRewardItem=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end



















function UIDialougeHuHuanCountTip:onLoaded(...)
self:bindComponents()
end


function UIDialougeHuHuanCountTip:__delete()
self:unbindComponents()
self.selectCnt=nil
self.max=nil
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end


function UIDialougeHuHuanCountTip:onHide()

end




function UIDialougeHuHuanCountTip:onShow(argtable,afterOnloaded)
self.showdata=argtable
self.leftItemId=self.showdata.leftItemId
self.rightItemId=self.showdata.rightItemId
self.selectCntDesc=self.showdata.selectCntDesc or"{0}"

self.titleText:setText(self.showdata.title)
if self.showdata.tips then
self.linkImageText2:setText(self.showdata.tips)
else
self.linkImageText2:setActive(false)
end
if self.showdata.content then
self.linkImageText1:setText(self.showdata.content)
else
self.linkImageText1:setActive(false)
end
self.okText:setText(self.showdata.oktext)

self.max=self.showdata.max or 99
self.min=self.showdata.min or 1
if self.max==0 then
self.max=1
end
self.selectCnt=self.showdata.defaultCnt or self.min

if self.max<=self.min then
self.sliderRoot:setActive(false)

self.winlua:SetChildAnchoredPosition(self.itemPanel:getID(),Vector2.New(22,-35))
self.winlua:SetChildAnchoredPosition(self.linkImageText1:getID(),Vector2.New(246,-55))
self.winlua:SetChildAnchoredPosition(self.linkImageText2:getID(),Vector2.New(246,-136))
self.winlua:SetChildAnchoredPosition(self.tipsBtn:getID(),Vector2.New(17,-4))
else
local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>self.min)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

if self.showdata.canceltext~=nil then
self.cancelText:setText(self.showdata.canceltext)
else
self.cancelButton:setActive(false)
end
if self.showdata.showclosebtn then
self.closeBtn:setActive(self.showdata.showclosebtn)
else
self.closeBtn:setActive(false)
end

local showMoney
local moneytypes=self.showdata.moneytypes
if moneytypes then
showMoney=true
UIManager:showWindow('UITopMoneyHigh_dialougeOnly_Win',{moneytypes=moneytypes,parentName='UIDialougeHuHuanCountTip'})
else
showMoney=false
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
self.showMoney=showMoney

self.tipsTx:setText(self.showdata.tipContent)
self.winlua:ForceLayoutRect(self.tipsPanel:getID())
self.winlua:SetChildAnchoredPosition(self.tipsPanel:getID(),self.showdata.tipsPos)
self.tipsRoot:setActive(false)


self:refreshItem()
end

function UIDialougeHuHuanCountTip:onSliderChange(value)
self.selectCnt=value

self.selectCntText:setText(FMT.fmt(self.selectCntDesc,self.selectCnt))
end

function UIDialougeHuHuanCountTip:refreshItem()
local leftItemId=self.leftItemId
local rightItemId=self.rightItemId

local leftWidget=self.leftRewardItem:getWidgetBase()
local conf={itemid=leftItemId,itemcount='',showCountBG=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
leftWidget:SetChildPropData(-1,prop)
leftWidget:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)

local rightWidget=self.rightRewardItem:getWidgetBase()
local conf={itemid=rightItemId,itemcount='',showCountBG=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rightWidget:SetChildPropData(-1,prop)
rightWidget:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)
end






function UIDialougeHuHuanCountTip:onAddBtn()




if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIDialougeHuHuanCountTip:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

self.showdata:deleteSelf()
self:close()

if cancelcallback then
cancelcallback()
end
end



function UIDialougeHuHuanCountTip:onCloseBtn()
self:doClose()
end



function UIDialougeHuHuanCountTip:onMaxCnt()
end



function UIDialougeHuHuanCountTip:onOkButton()
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end

local okcallback=self.showdata.okcallback

self.showdata:deleteSelf()
self:close()

if okcallback then
okcallback(selectCnt)
end
end



function UIDialougeHuHuanCountTip:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIDialougeHuHuanCountTip:onTipsBtn()
self.tipsRoot:setActive(true)
end



function UIDialougeHuHuanCountTip:onTipsRoot()
self.tipsRoot:setActive(false)
end

function UIDialougeHuHuanCountTip:onBGClick()
self:doClose()
end

function UIDialougeHuHuanCountTip:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end

function UIDialougeHuHuanCountTip:onClickRewardItem(clickCount,index)
local rewards=self.rewards
local itemid=rewards[index+1][1]
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid})
end
