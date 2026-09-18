







def_class("UISubAct_CangBaoTuCollectWin",UIWindowBase)









function UISubAct_CangBaoTuCollectWin:bindComponents()

self.tips=UIText.get(self,0)
self.card_1=UIButton.get(self,1)
self.card_2=UIButton.get(self,2)
self.card_3=UIButton.get(self,3)
self.card_4=UIButton.get(self,4)
self.card_5=UIButton.get(self,5)
self.card_6=UIButton.get(self,6)
self.card_7=UIButton.get(self,7)
self.card_8=UIButton.get(self,8)
self.card_9=UIButton.get(self,9)

self.card_1:setButtonClick(function()self:onCard_1()end)

self.card_2:setButtonClick(function()self:onCard_2()end)

self.card_3:setButtonClick(function()self:onCard_3()end)

self.card_4:setButtonClick(function()self:onCard_4()end)

self.card_5:setButtonClick(function()self:onCard_5()end)

self.card_6:setButtonClick(function()self:onCard_6()end)

self.card_7:setButtonClick(function()self:onCard_7()end)

self.card_8:setButtonClick(function()self:onCard_8()end)

self.card_9:setButtonClick(function()self:onCard_9()end)
self.card={
self.card_1,
self.card_2,
self.card_3,
self.card_4,
self.card_5,
self.card_6,
self.card_7,
self.card_8,
self.card_9,
}



end


function UISubAct_CangBaoTuCollectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.card_1);self.card_1=nil;
_UIObject_release(self.card_2);self.card_2=nil;
_UIObject_release(self.card_3);self.card_3=nil;
_UIObject_release(self.card_4);self.card_4=nil;
_UIObject_release(self.card_5);self.card_5=nil;
_UIObject_release(self.card_6);self.card_6=nil;
_UIObject_release(self.card_7);self.card_7=nil;
_UIObject_release(self.card_8);self.card_8=nil;
_UIObject_release(self.card_9);self.card_9=nil;
self.card=nil;
end
















local _this=nil
local _cardCmp={
item=0,
select=1,
}




function UISubAct_CangBaoTuCollectWin:onLoaded(...)
self:bindComponents()
_this=self

self._on_money_changed=function(...)
self:on_money_changed(...)
end
notifySystem:listenNotify(notifyConfig.on_money_changed,self._on_money_changed)
end


function UISubAct_CangBaoTuCollectWin:__delete()
self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.on_money_changed,self._on_money_changed)
end




function UISubAct_CangBaoTuCollectWin:onShow(argtable,afterOnloaded)
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self:refreshView()
self.tips:setActive(self.config.recv and self.config.recv>0)
end


function UISubAct_CangBaoTuCollectWin:onHide()

end



function UISubAct_CangBaoTuCollectWin:refreshView()
self.moneys={}
for i,v in ipairs(self.config.money)do
local count=itemsModel.getCount(v)
if count>0 then
table.insert(self.moneys,i)
end
end
for i,v in ipairs(self.card)do
local cardWidget=v:getChildWidgetBase()
local index=self.moneys[i]
cardWidget:SetChildActive(_cardCmp.select,index~=nil)
if index then
local itemId=self.config.money[index]
local itemNum=itemsModel.getCount(itemId)
local conf={itemid=itemId,itemcount=itemNum,showname=true,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
cardWidget:SetChildPropData(_cardCmp.item,prop)
cardWidget:SetBaseItemClickEvent(_cardCmp.item,function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end
end
end



function UISubAct_CangBaoTuCollectWin:onCard_1()
self:onClickCard(1)
end



function UISubAct_CangBaoTuCollectWin:onCard_2()
self:onClickCard(2)
end



function UISubAct_CangBaoTuCollectWin:onCard_3()
self:onClickCard(3)
end



function UISubAct_CangBaoTuCollectWin:onCard_4()
self:onClickCard(4)
end



function UISubAct_CangBaoTuCollectWin:onCard_5()
self:onClickCard(5)
end



function UISubAct_CangBaoTuCollectWin:onCard_6()
self:onClickCard(6)
end



function UISubAct_CangBaoTuCollectWin:onCard_7()
self:onClickCard(7)
end



function UISubAct_CangBaoTuCollectWin:onCard_8()
self:onClickCard(8)
end



function UISubAct_CangBaoTuCollectWin:onCard_9()
self:onClickCard(9)
end

function UISubAct_CangBaoTuCollectWin:onClickCard(i)










local index=self.moneys[i]
if index==nil then
return
end
if self.config.recv and self.config.recv>0 then
local money=self.config.money[index]
local count=itemsModel.getCount(money)
if(systemModel.isOpen(SYSTEM_DEFINE.eFriend)or xianmengModel:hasXM())and count>0 then
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
piece=index,
funcType=1,
}
self:showWindow("UISubAct_CangBaoTuFriendListWin",args)
end
else
local money=self.config.money[index]
itemsComponentHelper.onItemClickEx(money)
end
end

function UISubAct_CangBaoTuCollectWin:on_money_changed(moneyType,lastVal,val)
if table.containsValue(self.config.money,moneyType)then
local index=table.findValue(self.moneys,moneyType)
if index then
local cardWidget=self.card[index]:getChildWidgetBase()
local itemId=self.config.money[index]
local conf={itemid=itemId,itemcount=val,showname=true,showCountBG=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
cardWidget:SetChildPropData(_cardCmp.item,prop)
else
self:refreshView()
end
end
end