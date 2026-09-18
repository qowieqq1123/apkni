







def_class("UISubAct_XYZPTipWin",UIWindowBase)









function UISubAct_XYZPTipWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.cancelText=UIText.get(self,1)
self.okText=UIText.get(self,2)
self.cancelButton=UIButton.get(self,3)
self.okButton=UIButton.get(self,4)
self.titleText=UIText.get(self,5)
self.fightSaveMode=UIToggleButton.get(self,6)
self.Imagegou=UIObject.get(self,7)
self.repanel=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UISubAct_XYZPTipWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.fightSaveMode);self.fightSaveMode=nil;
_UIObject_release(self.Imagegou);self.Imagegou=nil;
_UIObject_release(self.repanel);self.repanel=nil;
end















local _this



function UISubAct_XYZPTipWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISubAct_XYZPTipWin:__delete()
self:unbindComponents()
_this=nil
end


function UISubAct_XYZPTipWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then return end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eCenter})
end




function UISubAct_XYZPTipWin:onShow(argtable,afterOnloaded)
if argtable then
self.titleText:setText(argtable.title or"")
self.okcallback=argtable.okcallback
self.oktext=argtable.oktext
self.canceltext=argtable.canceltext

self.repaneltxt=argtable.repaneltxt
self.rewardList=argtable.rewardList
end

self:freshRewards()

end


function UISubAct_XYZPTipWin:onHide()

end

function UISubAct_XYZPTipWin:onCloseBtn()
self:closeSelf()
end

function UISubAct_XYZPTipWin:onCancelButton()
self:closeSelf()
end


function UISubAct_XYZPTipWin:onOkButton()
local okcallback=_this.okcallback
self:closeSelf()
if okcallback then
okcallback()
end
end

function UISubAct_XYZPTipWin:onTipsBtn()
end



function UISubAct_XYZPTipWin:freshRewards()
local widget=self.repanel:getWidgetBase()
widget:SetChildText(1,self.repaneltxt or'')
local rewardList=self.rewardList
if rewardList then
local len=#rewardList
widget:SetChildScrollViewCreateGrids(0,len,len)
local reward_grids=widget:GetChildScrollViewItemWidgets(0)
for j=1,len do
local reward=rewardList[j]
local itemid=reward[1]
local count=reward[2]
local gaiLvtxt=reward[3]
local widget2=reward_grids[j-1]
widget2:SetChildText(2,gaiLvtxt)
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
end

