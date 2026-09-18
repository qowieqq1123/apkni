







def_class("UICommonShowPrizeThreeWin",UIWindowBase)









function UICommonShowPrizeThreeWin:bindComponents()

self.tipsText=UIText.get(self,0)
self.rwScrollView=UIObject.get(self,1)
self.tips=UIText.get(self,2)
self.creater=UIGameobjectClone.new(self,3)
self.effect=UIObject.get(self,4)
self.button_1=UIObject.get(self,5)
self.button_2=UIObject.get(self,6)
self.button={
self.button_1,
self.button_2,
}



end


function UICommonShowPrizeThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.tips);self.tips=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.button_1);self.button_1=nil;
_UIObject_release(self.button_2);self.button_2=nil;
self.button=nil;
end
















local itemKid={
button=0,
buttonTx=1,
costRoot=2,
costIcon=3,
costNum=4,
}



function UICommonShowPrizeThreeWin:onLoaded(...)
self:bindComponents()
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)

UIManager.setMoneyMsgShowState(false,true)
end

function UICommonShowPrizeThreeWin:__delete()
self.rwScrollView:setChildScrollViewStopGridCreate()

self:unbindComponents()


UIManager.setMoneyMsgShowState(true,true)
end















function UICommonShowPrizeThreeWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.btnData=argtable.btnData
local tipsStr=argtable.tips or''
local closeTips=argtable.closeTips or'点击空白区域关闭'
local moneytypes=argtable.moneytypes

self.networking=false

self.tips:setText(tipsStr)
self.tipsText:setText(closeTips)
self.effect:setChildShowEffect(10014,true)

AudioManager.playAudio(407)

local rewards=argtable.list
local len=#rewards
if len<5 then
self.rwScrollView:setLocalPosY(-51.7)
else
self.rwScrollView:setLocalPosY(-14)
end
self.rwScrollView:setChildScrollViewStopGridCreate()
self.rwScrollView:setChildScrollViewCreateGrids(0,0)
self.rwScrollView:setChildScrollViewDelayCreateGrids(len,math.min(len,5),0.15,1,false,false,function(index,item)
local rwdata=rewards[index+1]
local rewardId=rwdata.itemid
local rewardNum=rwdata.num
local rewardGuid=rwdata.itemguid
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local colorEffect=argtable.effect[rewardId]or false
local conf={itemid=rewardId,itemcount=countStr,itemguid=rewardGuid,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=equipsHelper.getSuitIcon(rwdata)
item:SetChildPropData(0,prop)

item:SetBaseItemClickEvent(0,function(...)itemsComponentHelper.onItemClickEx(...)end)

item:SetChildShowEffect(2,10078,true)
end)

for i,v in ipairs(self.button)do
local btnData=self.btnData[i]
local show=btnData~=nil
v:setActive(show)
if show then
local widget=v:getWidgetBase()
widget:SetChildText(itemKid.buttonTx,btnData.text)
widget:SetChildActive(itemKid.costRoot,btnData.cost~=nil)
if btnData.cost then
widget:SetChildCSImageIcon(itemKid.costIcon,iconHelper.getIconName(btnData.cost[1]),false)
widget:SetChildText(itemKid.costNum,btnData.cost[2])
end
widget:SetChildButtonClick(itemKid.button,function()
if self and not self.isClose and not self.networking and btnData.callback()then
self.networking=true
btnData.callback()
end
end)
end
end

self.showMoney=moneytypes~=nil
if self.showMoney then
self:showWindow('UITopMoneyWin4',{moneys=moneytypes,offsetX=-125,offsetY=-40})
else
self:closeWindow('UITopMoneyWin4')
end

if argtable.extraWin then
self:showWindow(argtable.extraWin,argtable.extraParams)
end
end

function UICommonShowPrizeThreeWin:onHide()

end



function UICommonShowPrizeThreeWin:onClickBg()
if self.callback then
self.callback()
end
self:closeSelf()
end