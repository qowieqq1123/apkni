







def_class("UIDialougeMJPHBBtips",UIWindowBase)









function UIDialougeMJPHBBtips:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.cancelText=UIText.get(self,1)
self.okText=UIText.get(self,2)
self.cancelButton=UIButton.get(self,3)
self.okButton=UIButton.get(self,4)
self.titleText=UIText.get(self,5)
self.tipsBtn=UIButton.get(self,6)
self.fightSaveMode=UIToggleButton.get(self,7)
self.Imagegou=UIObject.get(self,8)
self.repanel=UIObject.get(self,9)
self.closetip=UIText.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)



end


function UIDialougeMJPHBBtips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
_UIObject_release(self.fightSaveMode);self.fightSaveMode=nil;
_UIObject_release(self.Imagegou);self.Imagegou=nil;
_UIObject_release(self.repanel);self.repanel=nil;
_UIObject_release(self.closetip);self.closetip=nil;
end
















local _this



function UIDialougeMJPHBBtips:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDialougeMJPHBBtips:__delete()
self:unbindComponents()
_this=nil
end


function UIDialougeMJPHBBtips:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then return end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eCenter})
end




function UIDialougeMJPHBBtips:onShow(argtable,afterOnloaded)
if argtable then
self.titleText:setText(argtable.title or"")
self.okcallback=argtable.okcallback
self.oktext=argtable.oktext
self.canceltext=argtable.canceltext

self.isshowrewards=argtable.isshowrewards
self.repaneltxt=argtable.repaneltxt
self.rewardList=argtable.rewardList
self.closetipshow=argtable.closetip
self.repanelTips=argtable.repanelTips
end
self.okText:setText(self.oktext or"")
self.cancelText:setText(self.canceltext or"")
if self.oktext then
self.okButton:setActive(true)
else
self.okButton:setActive(false)
end
if self.canceltext then
self.cancelButton:setActive(true)
else
self.cancelButton:setActive(false)
end
if self.closetipshow then
self.closetip:setActive(true)
end

if self.isshowrewards then
self.repanel:setActive(true)
local widget=self.repanel:getWidgetBase()
widget:SetChildText(1,self.repaneltxt or'')
widget:SetChildText(2,self.repanelTips or'')
local rewardList=self.rewardList
if rewardList then
local len=#rewardList
widget:SetChildScrollViewCreateGrids(0,len,len)
local reward_grids=widget:GetChildScrollViewItemWidgets(0)
for j=1,len do
local reward=rewardList[j]
local itemid=reward[1]
local count=reward[2]
local widget2=reward_grids[j-1]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget2:SetChildActive(-1,true)
widget2:SetChildPropData(0,prop)
widget2:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end
end

else
self.repanel:setActive(false)
end
end


function UIDialougeMJPHBBtips:onHide()

end





function UIDialougeMJPHBBtips:onCloseBtn()
self:closeSelf()
end



function UIDialougeMJPHBBtips:onMaxCnt()
end



function UIDialougeMJPHBBtips:onSubBtn()
end



function UIDialougeMJPHBBtips:onAddBtn()
end



function UIDialougeMJPHBBtips:onCancelButton()
self:closeSelf()
end



function UIDialougeMJPHBBtips:onOkButton()
local okcallback=_this.okcallback
self:closeSelf()
if okcallback then
okcallback()
end
end



function UIDialougeMJPHBBtips:onTipsRoot()
end



function UIDialougeMJPHBBtips:onTipsBtn()
end
