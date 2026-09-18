







def_class("UIDialougeBuyCountNoTip",UIWindowBase)









function UIDialougeBuyCountNoTip:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.handleImg=UIObject.get(self,1)
self.maxCnt=UIButton.get(self,2)
self.subBtn=UIButton.get(self,3)
self.addBtn=UIButton.get(self,4)
self.cancelText=UIText.get(self,5)
self.okText=UIText.get(self,6)
self.selectCntText=UIText.get(self,7)
self.cancelButton=UIButton.get(self,8)
self.okButton=UIButton.get(self,9)
self.titleText=UIText.get(self,10)
self.linkImageText1=UILinkImageText.get(self,11)
self.linkImageText2=UILinkImageText.get(self,12)
self.sliderRoot=UIObject.get(self,13)
self.selectCntSlider=UIObject.get(self,14)
self.tipsRoot=UIButton.get(self,15)
self.tipsPanel=UIObject.get(self,16)
self.tipsTx=UIText.get(self,17)
self.tipsBtn=UIButton.get(self,18)
self.scrollerView=UIObject.get(self,19)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.tipsRoot:setButtonClick(function()self:onTipsRoot()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)



end


function UIDialougeBuyCountNoTip:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.linkImageText1);self.linkImageText1=nil;
_UIObject_release(self.linkImageText2);self.linkImageText2=nil;
_UIObject_release(self.sliderRoot);self.sliderRoot=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
end



















function UIDialougeBuyCountNoTip:onLoaded(...)
self:bindComponents()
local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.scrollerView:setChildScrollViewInit(-1,true,_onClickRewardItem,nil)
end


function UIDialougeBuyCountNoTip:__delete()
self:unbindComponents()
self.selectCnt=nil
self.max=nil
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end




function UIDialougeBuyCountNoTip:onShow(argtable,afterOnloaded)
self.showdata=argtable
self.rewards=self.showdata.rewards
self.selectCntDesc=self.showdata.selectCntDesc or"{0}"

self.titleText:setText(self.showdata.title)
if self.showdata.tips then
self.linkImageText2:setText(self.showdata.tips)
else
self.linkImageText2:setActive(false)
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

self.winlua:SetChildAnchoredPosition(self.linkImageText1:getID(),Vector2.New(242.5,-68))
self.winlua:SetChildAnchoredPosition(self.linkImageText2:getID(),Vector2.New(242.5,-136))
self.winlua:SetChildAnchoredPosition(self.tipsBtn:getID(),Vector2.New(17,-4))
self.winlua:SetChildAnchoredPosition(self.scrollerView:getID(),Vector2.New(30,12))
else
local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>self.min)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end
local str=self.showdata.refreshcallback(self.selectCnt)

self.okText:setText(str)

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
UIManager:showWindow('UITopMoneyHigh_dialougeOnly_Win',{moneytypes=moneytypes,parentName='UIDialougeBuyCountNoTip'})
else
showMoney=false
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
self.showMoney=showMoney

self.tipsTx:setText(self.showdata.tipContent)
self.winlua:ForceLayoutRect(self.tipsPanel:getID())
self.winlua:SetChildAnchoredPosition(self.tipsPanel:getID(),self.showdata.tipsPos or Vector2.zero)
self.tipsRoot:setActive(false)


self:refreshItem()
end

function UIDialougeBuyCountNoTip:onSliderChange(value)
self.selectCnt=value

self.selectCntText:setText(FMT.fmt(self.selectCntDesc,self.selectCnt))

local str=self.showdata.refreshcallback(value)

self.okText:setText(str)

if self.showdata.isRefreshRewards then
self:refreshItemEx()
end
end


function UIDialougeBuyCountNoTip:onHide()

end

function UIDialougeBuyCountNoTip:refreshItem()
local rewards=self.rewards


local len=#rewards
local _w=math.min(410,len*80-10)
self.scrollerView:setChildScrollRectEnable(_w>410)
self.scrollerView:setChildSizeDelta(_w,80)
self.scrollerView:setChildScrollViewCreateGrids(len,len)

self:refreshItemEx()
end

function UIDialougeBuyCountNoTip:refreshItemEx()
local rewards=self.rewards
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>0 then
showCountBG=true
countStr=mathHelper.formatNumber(count*self.selectCnt)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
end
end
end





function UIDialougeBuyCountNoTip:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

self.showdata:deleteSelf()
self:close()

if cancelcallback then
cancelcallback()
end
end


function UIDialougeBuyCountNoTip:onOkButton()
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


function UIDialougeBuyCountNoTip:onMaxCnt()
end


function UIDialougeBuyCountNoTip:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end


function UIDialougeBuyCountNoTip:onAddBtn()




if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIDialougeBuyCountNoTip:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
else
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIDialougeBuyCountNoTip:onCloseBtn()
self:doClose()
end

function UIDialougeBuyCountNoTip:onBGClick()
self:doClose()
end

function UIDialougeBuyCountNoTip:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end

function UIDialougeBuyCountNoTip:doOk()
local okcallback=self.showdata.okcallback
self.showdata:deleteSelf()
self:close()
if okcallback then
okcallback()
end
end

function UIDialougeBuyCountNoTip:doCancel()
self.showdata:deleteSelf()
self:close()
end

function UIDialougeBuyCountNoTip:onTipsRoot()
self.tipsRoot:setActive(false)
end

function UIDialougeBuyCountNoTip:onTipsBtn()
self.tipsRoot:setActive(true)
end

function UIDialougeBuyCountNoTip:onClickRewardItem(clickCount,index)
local rewards=self.rewards
local itemid=rewards[index+1][1]
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid})
end