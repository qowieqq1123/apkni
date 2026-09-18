







def_class("UIReChargeWin",UIWindowBase)









function UIReChargeWin:bindComponents()

self.mutiaoScroller=UIObject.get(self,0)
self.pageScrollView=UIObject.get(self,1)
self.scrollerView=UIObject.get(self,2)
self.tips=UIText.get(self,3)



end


function UIReChargeWin:unbindComponents()
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
firstimage=10,
}

local showType=
{
Show=1,
Hide=10,
}



function UIReChargeWin:onLoaded(...)
self:bindComponents()

self.pages={
{
name='仙券',
type=34
},
{
name='仙玉',
type=1
}
}

self.tips:setActive(false)









local _onClickItem=function(...)
self:onClickItem(...)
end
self.scrollerView:setChildScrollViewInit(-1,true,_onClickItem,nil)





self.pageScrollView:setChildScrollViewInit(0.5,true,function(...)self:onPageClick(...)end,nil)
end

function UIReChargeWin:getDatas(rtype)
local platform=deviceHelper.getRuntimePlatformStr()
local allConfig=self:getRechargeList(rtype)
local rechargeConfig={}
local gameversionIndex=pfwindowslController:getGameVersion()
for i,v in ipairs(allConfig)do
if v.Platfrom==nil or v.Platfrom==platform then
if v.showGameVersion then
local flag=v.showGameVersion[gameversionIndex]
if flag==showType.Show then
table.insert(rechargeConfig,v)
end
else
table.insert(rechargeConfig,v)
end
end
end
return rechargeConfig
end

function UIReChargeWin:onPageClick(num,index)
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
self.tips:setActive(data.type==34)

local item=self.pageScrollView:getChildScrollViewItemWidget(self.currPageIndex)
item:SetChildActive(0,true)
end


function UIReChargeWin:__delete()
self:unbindComponents()
end




function UIReChargeWin:onShow(argtable,afterOnloaded)
local page
if argtable then
if argtable.pageType then
for i,v in ipairs(self.pages)do
if v.type==argtable.pageType then
page=i-1
break
end
end
end
end
page=page or 0
if payControl:isActiveXianQuanShop()then
self.pageScrollView:setActive(true)
self:refreshPage()
self:onPageClick(0,page)
else
self.rechargeConfig=self:getDatas(1)
if verifyManager:isHideSpecificRecharge()then
self:SetTishenData()
end
self.pageScrollView:setActive(false)
self:refreshScrollerView()
end
end


function UIReChargeWin:onHide()

end

function UIReChargeWin:refreshPage()
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

function UIReChargeWin:getRechargeList(rtype)
local list={}
local allConfig=cfg_rechargeconfig()
for i,v in pairs(allConfig)do
if v.recharge_type==rtype then
table.insert(list,v)
end
end
return list
end


function UIReChargeWin:SetTishenData()

local data={}
for k,v in ipairs(self.rechargeConfig)do
if v.id<=5 then
table.insert(data,v)
end

end
self.rechargeConfig=data
end



function UIReChargeWin:refreshScrollerView()
self.scrollerView:setChildScrollViewCreateGrids(#self.rechargeConfig,3)
local grids=self.scrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local config=self.rechargeConfig[i]
local showIconName=iconHelper.getChongZhiIcon(config.icon)
item:SetChildIcon(itemIndex.icon,showIconName,false)
item:SetChildText(itemIndex.xianyu,config.name)
local str=pfwindowslController:showDesc_ByMoneyType(config)
item:SetChildText(itemIndex.cash,str)


local presentType=eMoneyType.mtLingYu
local iconName=iconHelper.getIconName(presentType)
local isFirst=rechargeModel:getFirstRecharge(config.id)
item:SetChildActive(itemIndex.firstPresentObj,isFirst and config.first_reward~=nil)

item:SetChildActive(itemIndex.firstimage,false)
if isFirst then
if pfwindowslController:checkIsGameVersion_yuenan()then
item:SetChildText(itemIndex.fPresentText,FMT.fmt("Nạp Đầu Tặng 100%"))
item:SetChildActive(itemIndex.firstimage,true)
else
item:SetChildText(itemIndex.fPresentText,FMT.fmt("首充赠{0}灵玉",config.first_reward))
end

item:SetChildActive(itemIndex.fPresentIcon,false)
end


item:SetChildActive(itemIndex.normalPresentObj,not isFirst and config.reward~=nil)
if config.reward then
item:SetChildText(itemIndex.nPresentText,FMT.fmt("赠送{0}灵玉",config.reward))

end

local _onClickPackItem=function(...)
self:onClickItem(1,i-1)
end
item:SetChildButtonClick(itemIndex.buyBtn,_onClickPackItem)
end
end
end

function UIReChargeWin:onClickItem(clickCount,index)

local config=self.rechargeConfig[index+1]
payControl.reqPay(config.id)
end
