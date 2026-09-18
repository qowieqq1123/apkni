







def_class("UISubAct_dongtianfudi_SelectWin",UIWindowBase)









function UISubAct_dongtianfudi_SelectWin:bindComponents()

self.animRoot=UIObject.get(self,0)
self.ListPanel=UIObject.get(self,1)
self.moneyIcon=UIButton.get(self,2)
self.moneyText=UIText.get(self,3)

self.moneyIcon:setButtonClick(function()self:onMoneyIcon()end)



end


function UISubAct_dongtianfudi_SelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animRoot);self.animRoot=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyText);self.moneyText=nil;
end





















function UISubAct_dongtianfudi_SelectWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_dongtianfudi_SelectWin:__delete()
self:unbindComponents()
end




function UISubAct_dongtianfudi_SelectWin:onShow(argtable,afterOnloaded)
local fudiIndex=argtable.fudiIndex
local args=argtable.args
self.fudiIndex=fudiIndex
if not self.config then
self.actid=args.act_id
self.subType=SUB_ACTIVITY_TYPE.eDongTianFuDi
self.subid=args.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
end
self.moneyType=activitiesHandle_dongtianfudi.exchangeMoneyType[fudiIndex]
self:refreshItemList()
if args.initWin then
self.animRoot:setLocalPosY(-638)
self.animRoot:setChildDOLocalMoveY(0,0.2)
end
end

function UISubAct_dongtianfudi_SelectWin:refreshMoney()
local iconname=iconHelper.getIconName(self.moneyType)
self.moneyIcon:setIcon(iconname)
self.moneyText:setText(FMT.fmt("x{0}",moneyModel.getMoney(self.moneyType)))
end

function UISubAct_dongtianfudi_SelectWin:onMoneyIcon()
gainControl:showGainWin(self.moneyType)
end

function UISubAct_dongtianfudi_SelectWin:refreshItemList()
self:refreshMoney()
local lotteryList=self.config.lotteryList
local lotteryD=table.deepCopy(lotteryList[self.fudiIndex][6])

local iconname=iconHelper.getIconName(self.moneyType)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,32)

local actData=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local limitList=actData.limitList[self.fudiIndex]or{}

local lottery={}
for i,v in ipairs(lotteryD)do
local data=lotteryD[i]
local itemId=data[2]
local limit=data[4]
local sortIdx=data[5]or i
local buy=limitList[itemId]or 0
local sort=sortIdx
if limit~=0 and limit<=buy then
sort=sort+100000
end
data.idx=i
data.sort=sort
table.insert(lottery,data)
end
table.sort(lottery,function(a,b)return a.sort<b.sort end)

local callback=function(item,idx)

local data=lottery[idx]

local prize=data[1]
local itemId=data[2]
local num=data[3]
local limit=data[4]
local buy=limitList[itemId]or 0

local conf={itemid=itemId,itemcount=num>1 and num or'',showCountBG=num>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)

item:SetChildText(3,FMT.fmt("需求：{0}{1}",iconStr,prize))

local limitFlag=limit~=0
if limitFlag then
item:SetChildText(7,FMT.fmt("限购：{0}/{1}",limit-buy,limit))
item:SetChildActive(1,limit<=buy)
item:SetChildActive(5,limit>buy)
limitFlag=limit>buy
else
item:SetChildActive(5,true)
end
item:SetChildActive(6,limitFlag)


item:SetChildButtonClick(5,function()
if limit~=0 then
if limit<=buy then
UIManager.error("已售罄")
return
end
end
if not moneyModel.checkEnoughMoney(self.moneyType,prize)then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(self.moneyType)))
return
end

self:onBuyClick(data.idx,limit-buy,self.moneyType,prize)
end)
end

self.ListPanel:setChildScrollViewCreateGrids(#lottery,#lottery)
local grids=self.ListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
callback(grids[i-1],i)
end
self.ListPanel:setChildScrollRectEnable(false)
self.ListPanel:setChildScrollViewSelectItem(0,false,false,false)
self.ListPanel:setChildScrollRectEnable(true)
end


function UISubAct_dongtianfudi_SelectWin:onBuyClick(idx,max,moneyType,unitPrice)
local showdata=
{
type='UIUseItemDialouge',
title='提示',
canceltext='取消',
oktext='购买',
max=max,
itemId=moneyType,
unitPrice=unitPrice,
okcallback=function(num)
if not moneyModel.checkEnoughMoney(self.moneyType,unitPrice)then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(self.moneyType)))
return
end
activitiesHandle_dongtianfudi.sendBuy(self.actid,self.subid,self.fudiIndex,idx,num)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()

end


function UISubAct_dongtianfudi_SelectWin:onHide()

end



