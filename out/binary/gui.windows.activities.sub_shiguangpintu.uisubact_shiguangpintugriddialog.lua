







def_class("UISubAct_ShiGuangPinTuGridDialog",UIWindowBase)









function UISubAct_ShiGuangPinTuGridDialog:bindComponents()

self.background=UIButton.get(self,0)
self.cancelButton=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.descTx=UILinkImageText.get(self,3)
self.okButton=UIButton.get(self,4)
self.rewardList=UIObject.get(self,5)

self.background:setButtonClick(function()self:onBackground()end)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UISubAct_ShiGuangPinTuGridDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
end















local _this=nil



function UISubAct_ShiGuangPinTuGridDialog:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
self:addNotify(notifyConfig.on_money_init,self.onMoneyInited)
end


function UISubAct_ShiGuangPinTuGridDialog:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_ShiGuangPinTuGridDialog:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.content=argtable.content
self.money=argtable.money
self.rewards=argtable.rewards
self.callback=argtable.callback

self:refreshRewards()
self:refreshMoney()
end


function UISubAct_ShiGuangPinTuGridDialog:onHide()

end




function UISubAct_ShiGuangPinTuGridDialog:onBackground()
self:onCloseBtn()
end


function UISubAct_ShiGuangPinTuGridDialog:onCancelButton()
self:onCloseBtn()
end


function UISubAct_ShiGuangPinTuGridDialog:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end


function UISubAct_ShiGuangPinTuGridDialog:onOkButton()
if moneyModel.checkEnoughMoney(self.money[1],self.money[2])then
if self.callback then
self.callback()
end
self:onCloseBtn()
end
end

function UISubAct_ShiGuangPinTuGridDialog:refreshRewards()
self.rewardList:setChildLayoutGroupCreateItems(#self.rewards,function(index)
local item=self.rewardList:getChildLayoutGroupGridItem(index-1)
local data=self.rewards[index]
local itemId=data[1]
local itemNum=data[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(-1,prop)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
self.winlua:ForceLayoutRect(self.rewardList:getID())
end

function UISubAct_ShiGuangPinTuGridDialog:refreshMoney()
local check=moneyModel.checkEnoughMoney(self.money[1],self.money[2])
local color=check and FONT_COLOR.eGreenColor or FONT_COLOR.eRedColor
local countStr=FMT.cfmt(color,self.money[2])
local content=FMT.fmt(self.content,iconHelper.getIconName(self.money[1]),countStr)
self.descTx:setText(content)
self.okButton:setChildImageExGray(not check)
end

function UISubAct_ShiGuangPinTuGridDialog.onMoneyChanged(moneyType)
if moneyType==_this.money[1]then
_this:refreshMoney()
end
end

function UISubAct_ShiGuangPinTuGridDialog.onMoneyInited()
_this:refreshMoney()
end