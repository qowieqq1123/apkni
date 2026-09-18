







def_class("UISubAct_YHDBShowPrizeWin",UIWindowBase)









function UISubAct_YHDBShowPrizeWin:bindComponents()

self.button_1=UIObject.get(self,0)
self.button_2=UIObject.get(self,1)
self.creater=UIGameobjectClone.new(self,2)
self.effect=UIObject.get(self,3)
self.greatNum=UIText.get(self,4)
self.rwScrollView=UIObject.get(self,5)
self.tips=UILinkImageText.get(self,6)
self.tipsText=UIText.get(self,7)
self.button={
self.button_1,
self.button_2,
}



end


function UISubAct_YHDBShowPrizeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.button_1);self.button_1=nil;
_UIObject_release(self.button_2);self.button_2=nil;
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.greatNum);self.greatNum=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
self.button=nil;
end
















local itemKid={
button=0,
buttonTx=1,
costRoot=2,
costIcon=3,
costNum=4,
}



function UISubAct_YHDBShowPrizeWin:onLoaded(...)
self:bindComponents()
self.rwScrollView:setChildScrollViewInit(0.5,false,nil,nil)

UIManager.setMoneyMsgShowState(false,true)
end

function UISubAct_YHDBShowPrizeWin:__delete()
if self.ListTimer then
self:stopTimerByID(self.ListTimer)
end
self.ListTimer=nil
self:unbindComponents()


UIManager.setMoneyMsgShowState(true,true)
end















function UISubAct_YHDBShowPrizeWin:onShow(argtable,afterOnloaded)
self.argtable=argtable
self.callback=argtable.callback
self.btnData=argtable.btnData
local tipsStr=argtable.tips or''
local closeTips=argtable.closeTips or'点击空白区域关闭'
local moneytypes=argtable.moneytypes
local greatNum=argtable.greatNum or 0

self.tips:setText(tipsStr)
self.tipsText:setText(closeTips)
self.greatNum:setText(greatNum)
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
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,5))
self.grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=self.grids.Count
self.ListCreateIndex=0
if self.ListTimer then
self:stopTimerByID(self.ListTimer)
end
self.ListTimer=self:setTimer(0.15,count,function()
if self and not self.isClose then
local item=self.grids[self.ListCreateIndex]
if item then
self:refreshItem(self.ListCreateIndex,item)
end
self.ListCreateIndex=self.ListCreateIndex+1
end
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
if self and not self.isClose and btnData.callback then
if self.ListTimer then
self:onClickBg()
return
end
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

function UISubAct_YHDBShowPrizeWin:refreshItem(id,item)
id=id+1
local rwdata=self.argtable.list[id]
local rewardId=rwdata.itemid
local rewardNum=rwdata.num
local rewardGuid=rwdata.itemguid
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local colorEffect=self.argtable.effect[rewardId]or false
local conf={itemid=rewardId,itemcount=countStr,itemguid=rewardGuid,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=colorEffect}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetIcon,10)]=equipsHelper.getSuitIcon(rwdata)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)itemsComponentHelper.onItemClickEx(...)end)
item:SetChildShowEffect(2,10078,true)

if id>=self.grids.Count and self.ListTimer then
self:stopTimerByID(self.ListTimer)
self.ListTimer=nil
end
end



function UISubAct_YHDBShowPrizeWin:onClickBg()
if self.ListTimer then
self:stopTimerByID(self.ListTimer)
local count=self.grids.Count
if self.ListCreateIndex<count then
for i=self.ListCreateIndex,count-1 do
local item=self.grids[i]
if item then
self:refreshItem(i,item)
end
end
end
self.ListTimer=nil
else
if self.callback then
self.callback()
end
self:closeSelf()
end
end