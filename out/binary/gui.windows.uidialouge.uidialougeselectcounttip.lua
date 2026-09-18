







def_class("UIDialougeSelectCountTip",UIWindowBase)









function UIDialougeSelectCountTip:bindComponents()

self.addBtn=UIButton.get(self,0)
self.cancelButton=UIButton.get(self,1)
self.cancelText=UIText.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.handleImg=UIObject.get(self,4)
self.linkImageText1=UILinkImageText.get(self,5)
self.linkImageText2=UILinkImageText.get(self,6)
self.maxCnt=UIButton.get(self,7)
self.okButton=UIButton.get(self,8)
self.okText=UIText.get(self,9)
self.scrollerView=UIObject.get(self,10)
self.selectCntSlider=UIObject.get(self,11)
self.selectCntText=UIText.get(self,12)
self.sliderRoot=UIObject.get(self,13)
self.subBtn=UIButton.get(self,14)
self.tipsBtn=UIButton.get(self,15)
self.tipsPanel=UIObject.get(self,16)
self.tipsRoot=UIButton.get(self,17)
self.tipsTx=UIText.get(self,18)
self.titleText=UIText.get(self,19)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.maxCnt:setButtonClick(function()self:onMaxCnt()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)

self.tipsRoot:setButtonClick(function()self:onTipsRoot()end)



end


function UIDialougeSelectCountTip:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.linkImageText1);self.linkImageText1=nil;
_UIObject_release(self.linkImageText2);self.linkImageText2=nil;
_UIObject_release(self.maxCnt);self.maxCnt=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
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



















function UIDialougeSelectCountTip:onLoaded(...)
self:bindComponents()
local _onClickRewardItem=function(...)
self:onClickRewardItem(...)
end
self.scrollerView:setChildScrollViewInit(-1,true,_onClickRewardItem,nil)
end


function UIDialougeSelectCountTip:__delete()
self:unbindComponents()
self.selectCnt=nil
self.max=nil
if self.showMoney then
UIManager:closeWindow('UITopMoneyHigh_dialougeOnly_Win')
end
end




function UIDialougeSelectCountTip:onShow(argtable,afterOnloaded)
self.showdata=argtable
self.rewards=self.showdata.rewards
self.selectCntDesc=self.showdata.selectCntDesc or"{0}"
self.rewardCountDesc=self.showdata.rewardCountDesc
self.selectItemId=self.showdata.selectItemId

if not self.selectItemId then
self.selectItemId=self.rewards[1][1]
self.selectIdx=1
end

if not self.selectIdx then
for i=1,#self.rewards do
if self.rewards[i][1]==self.selectItemId then
self.selectIdx=i
break
end
end
end

self.titleText:setText(self.showdata.title)
if self.showdata.tips then
self.linkImageText2:setText(self.showdata.tips)
else
self.linkImageText2:setActive(false)
end
self.okText:setText(self.showdata.oktext)

self.hideSlider=self.showdata.hideSlider
if self.hideSlider then
self.sliderRoot:setActive(false)

self.winlua:SetChildAnchoredPosition(self.linkImageText1:getID(),Vector2.New(242.5,-68))
self.winlua:SetChildAnchoredPosition(self.linkImageText2:getID(),Vector2.New(242.5,-136))
self.winlua:SetChildAnchoredPosition(self.tipsBtn:getID(),Vector2.New(17,-4))

self.max=self.showdata.defaultCnt or 1
self.min=self.showdata.defaultCnt or 1
self.selectCnt=self.showdata.defaultCnt or 1
else
self:refreshSlider()
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
UIManager:showWindow('UITopMoneyHigh_dialougeOnly_Win',{moneytypes=moneytypes,parentName='UIDialougeSelectCountTip'})
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

function UIDialougeSelectCountTip:refreshSlider()
self.max=self.rewards[self.selectIdx][2]or 0
self.min=1
if self.max==0 then
self.min=0
end
self.selectCnt=self.showdata.defaultCnt or self.min
local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildImageRaycast(self.handleImg:getID(),self.max>self.min)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,self.min,self.max,func)
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
self.okButton:setGray(self.max==0)
end


function UIDialougeSelectCountTip:onSliderChange(value)
self.selectCnt=value

self.selectCntText:setText(FMT.fmt(self.selectCntDesc,self.selectCnt))
end


function UIDialougeSelectCountTip:onHide()

end

function UIDialougeSelectCountTip:refreshItem()
local rewards=self.rewards

local len=#rewards
local maxW=len*90+40
local _w=math.min(440,maxW)
self.scrollerView:setChildScrollRectEnable(maxW>440)
self.scrollerView:setChildSizeDelta(_w,115)
self.scrollerView:setChildScrollViewCreateGrids(len,len)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local reward=rewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=count
local showCountBG=true
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=count==0 and 2 or 0}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(i)
end)
item:SetBaseItemLongTouchEvent(0,itemsComponentHelper.onItemClick)

local isSelect=self.selectItemId==itemid
if isSelect and self.selectIdx~=i then
self.selectIdx=i
end
item:SetChildActive(1,isSelect)

if self.rewardCountDesc then
item:SetChildText(2,FMT.fmt(self.rewardCountDesc,count))
else
item:SetChildText(2,"")
end
end
end
end





function UIDialougeSelectCountTip:onAddBtn()




if self.min>=self.max then
return
end
if self.selectCnt>=self.max then
return
end
self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIDialougeSelectCountTip:onCancelButton()
local cancelcallback=self.showdata.cancelcallback

self.showdata:deleteSelf()
self:close()

if cancelcallback then
cancelcallback()
end
end



function UIDialougeSelectCountTip:onCloseBtn()
self:doClose()
end



function UIDialougeSelectCountTip:onMaxCnt()
end



function UIDialougeSelectCountTip:onOkButton()
if self.selectCnt==0 then
UIManager.error("数量不足")
return
end
local selectItemId=self.selectItemId
local selectCnt=self.selectCnt
if selectCnt>self.max then
selectCnt=self.max
end

local okcallback=self.showdata.okcallback

self.showdata:deleteSelf()
self:close()

if okcallback then
okcallback(selectItemId,selectCnt)
end
end



function UIDialougeSelectCountTip:onSubBtn()
if self.selectCnt<=self.min then
return
end
self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIDialougeSelectCountTip:onTipsBtn()
self.tipsRoot:setActive(true)
end



function UIDialougeSelectCountTip:onTipsRoot()
self.tipsRoot:setActive(false)
end

function UIDialougeSelectCountTip:onBGClick()
self:doClose()
end
function UIDialougeSelectCountTip:doClose()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()

self:close()
if closecallback then
closecallback()
end
end

function UIDialougeSelectCountTip:onClickRewardItem(index)
local rewards=self.rewards
local itemid=rewards[index][1]
if itemid==-1 then
return
end
local count=rewards[index][2]
if count==0 then
UIManager.error("数量不足")
end
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local oldItem=grids[self.selectIdx-1]
if oldItem then
oldItem:SetChildActive(1,false)
end
self.selectItemId=itemid
self.selectIdx=index
local item=grids[index-1]
item:SetChildActive(1,true)

if not self.hideSlider then
self:refreshSlider()
end
end
