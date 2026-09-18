







def_class("UIYueNanIosReChargeWin",UIWindowBase)









function UIYueNanIosReChargeWin:bindComponents()

self.mutiaoScroller=UIObject.get(self,0)
self.pageScrollView=UIObject.get(self,1)
self.scrollerView=UIObject.get(self,2)
self.tips=UIText.get(self,3)



end


function UIYueNanIosReChargeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mutiaoScroller);self.mutiaoScroller=nil;
_UIObject_release(self.pageScrollView);self.pageScrollView=nil;
_UIObject_release(self.scrollerView);self.scrollerView=nil;
_UIObject_release(self.tips);self.tips=nil;
end

















local itemIndex={
xianyu=0,
cash=1,
firstPresentObj=2,
normalPresentObj=3,
fPresentText=4,
fPresentIcon=5,
nPresentText=6,
nPresentIcon=7,
icon=8,
buyBtn=9,
}



function UIYueNanIosReChargeWin:onLoaded(...)
self:bindComponents()

self.pages={
{
name='Tiên Ngọc',
type=1
},
{
name='Tiên Phiếu',
type=34
}
}

self.tips:setActive(false)









local _onClickItem=function(...)
self:onClickItem(...)
end
self.scrollerView:setChildScrollViewInit(-1,true,_onClickItem,nil)





self.pageScrollView:setChildScrollViewInit(0.5,true,function(...)self:onPageClick(...)end,nil)
self:showWindow('UIIOSTiShenTopMoneyWin',{{eMoneyType.mtXianYu}})
end

function UIYueNanIosReChargeWin:getDatas(rtype)
local platform=deviceHelper.getRuntimePlatformStr()
local allConfig=self:getRechargeList(rtype)
local rechargeConfig={}
local gameversionIndex=pfwindowslController:getGameVersion()
for i,v in ipairs(allConfig)do
if v.Platfrom==nil or v.Platfrom==platform then
if v.showGameVersion then
if v.showGameVersion[gameversionIndex]or v.showGameVersion[-2]then
table.insert(rechargeConfig,v)
end
else
table.insert(rechargeConfig,v)
end
end
end
return rechargeConfig
end

function UIYueNanIosReChargeWin:onPageClick(num,index)
if self.currPageIndex==index then
return
end

if self.currPageIndex then
local item=self.pageScrollView:getChildScrollViewItemWidget(self.currPageIndex)
item:SetChildActive(0,false)
end

self.currPageIndex=index
local data=self.pages[index+1]
self.rechargeConfig=self:getDatas(data.type)
self:refreshScrollerView()
self.tips:setActive(index==1)

local item=self.pageScrollView:getChildScrollViewItemWidget(self.currPageIndex)
item:SetChildActive(0,true)
end


function UIYueNanIosReChargeWin:__delete()
self:unbindComponents()
end




function UIYueNanIosReChargeWin:onShow(argtable,afterOnloaded)
local page
if argtable then
if argtable.page then
page=argtable.page
end
end
page=page or 0





self.rechargeConfig=self:getDatas(1)

table.insertto(self.rechargeConfig,self:getDatas(45),0)



table.sort(self.rechargeConfig,function(a,b)
local MoneyType=pfwindowslController:getPFMoneyType()
local GameVersion=pfwindowslController:getGameVersion()
return a.pay[GameVersion][MoneyType]<b.pay[GameVersion][MoneyType]
end)

self.pageScrollView:setActive(false)
self:refreshScrollerView()

end


function UIYueNanIosReChargeWin:onHide()

end

function UIYueNanIosReChargeWin:refreshPage()
self.pageScrollView:setChildScrollViewCreateGrids(#self.pages,0)
local grids=self.pageScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.pages[i]
item:SetChildActive(0,false)
item:SetChildText(1,data.name)
item:SetChildActive(2,i==count)
end
end

function UIYueNanIosReChargeWin:getRechargeList(rtype)
local list={}
local allConfig=cfg_rechargeconfig()
for i,v in pairs(allConfig)do
if v.recharge_type==rtype then
table.insert(list,v)
end
end
return list
end


function UIYueNanIosReChargeWin:SetTishenData()

local data={}
for k,v in ipairs(self.rechargeConfig)do
if v.id<=5 then
table.insert(data,v)
end

end
self.rechargeConfig=data
end



function UIYueNanIosReChargeWin:refreshScrollerView()
self.scrollerView:setChildScrollViewCreateGrids(#self.rechargeConfig,4)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local config=self.rechargeConfig[i]
local icon=config.icon+1
local showIconName=FMT.fmt("icon_shagndian_0{0}",icon>9 and 9 or icon)
item:SetChildCSImageSprite(itemIndex.icon,"ui/windows/recharge/iostishenshop_atlas_pak.ab",showIconName)
item:SetChildText(itemIndex.xianyu,"")
local str=pfwindowslController:showDesc_ByMoneyType(config)
item:SetChildText(itemIndex.cash,str)


local presentType=eMoneyType.mtLingYu
local iconName=iconHelper.getIconName(presentType)
local isFirst=rechargeModel:getFirstRecharge(config.id)
item:SetChildActive(itemIndex.firstPresentObj,isFirst and config.first_reward~=nil)

if isFirst then
if pfwindowslController:checkIsGameVersion_yuenan()then
item:SetChildText(itemIndex.fPresentText,config.name)
else
item:SetChildText(itemIndex.fPresentText,config.name)
end

item:SetChildActive(itemIndex.fPresentIcon,false)
end


item:SetChildActive(itemIndex.normalPresentObj,not isFirst and config.reward~=nil)
if config.reward then
item:SetChildText(itemIndex.nPresentText,config.name)

end

local _onClickPackItem=function(...)
self:onClickItem(1,i-1)
end
item:SetChildButtonClick(itemIndex.buyBtn,_onClickPackItem)
end
end
end

function UIYueNanIosReChargeWin:onClickItem(clickCount,index)

local config=self.rechargeConfig[index+1]
payControl.reqPay(config.id)
end
