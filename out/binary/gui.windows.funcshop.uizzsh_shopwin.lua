







def_class("UIZZSH_ShopWin",UIWindowBase)









function UIZZSH_ShopWin:bindComponents()

self.background=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.animDB=UIObject.get(self,2)
self.mouse1=UIObject.get(self,3)
self.mouse2=UIObject.get(self,4)
self.menu=UIObject.get(self,5)
self.content=UIObject.get(self,6)
self.goodsScrollview=UIObject.get(self,7)
self.timeTitle=UIText.get(self,8)
self.timeText=UIText.get(self,9)
self.animFan=UIObject.get(self,10)
self.scrollView=UIScrollView.get(self,11)



end


function UIZZSH_ShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.animDB);self.animDB=nil;
_UIObject_release(self.mouse1);self.mouse1=nil;
_UIObject_release(self.mouse2);self.mouse2=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.goodsScrollview);self.goodsScrollview=nil;
_UIObject_release(self.timeTitle);self.timeTitle=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.animFan);self.animFan=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
end



















local cmp=
{
item=0,
jiagenum1=1,
jiagenum2=2,
icon1=3,
icon2=4,
name=5,
limit=6,
clickbg=9,
xiyou=10,
isbuy=11,
normalbg2=12,
seasonLimitFlag=13,
}

function UIZZSH_ShopWin:onLoaded(...)
self:bindComponents()
end


function UIZZSH_ShopWin:__delete()
self:unbindComponents()
end




function UIZZSH_ShopWin:onShow(argtable,afterOnloaded)
self.shopId=eFuncShopType.eshanhaishop
self.config=cfg_shanhaishopconfig()
self.shopCfg=cfgHelper.get(cfg_shoplistconfig_get,self.shopId)

local moneyBar=table.weakCopy(self.shopCfg.moneyBar)
local exMoneyBar=zhengzhanshanhaiController:getZZSHCfg("exMoneyBar")
if exMoneyBar then
for i,v in ipairs(exMoneyBar)do
table.insert(moneyBar,v)
end
end

UIManager:showWindow('UITopMoneyWin',moneyBar)
self.data=funcShopModel:GetShanHaiShop()
self:SetLayoutGroup()


if argtable and argtable.canvasIdx then
self.canvasIdx=argtable.canvasIdx
self:setCanvasIndex(-1,argtable.canvasIdx)
end
end


function UIZZSH_ShopWin:onHide()

end


function UIZZSH_ShopWin:recordreward()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local checkSeason=false
if shSeasonId==-1 then
checkSeason=true
end

local nowsaiji=zhengzhanshanhaiModel:getRaceIndex()

local nowtable={}
local yettable={}
for a,b in pairs(self.config)do
local unlock=b.unlock
local flag=true
local minsaiji=nil
local maxsaiji=nil
for k,v in ipairs(unlock)do
flag=funcShopModel:CheckShanHai(v[1],v)
if not flag then
break
end
if v[1]==6 then
minsaiji=v[2]
end
end
if flag then

local showCnd=b.hide
local isShow=true
if showCnd then
for k,v in ipairs(showCnd)do
isShow=funcShopModel:CheckShanHai(v[1],v)
if not isShow then
break
end
end
end

if isShow then
if minsaiji and checkSeason then

if minsaiji==nowsaiji then
table.insert(nowtable,b)
else
table.insert(yettable,b)
end
else
table.insert(nowtable,b)
end
end
end
end

return nowtable,yettable
end

function UIZZSH_ShopWin:paixuShop()
for k,v in ipairs(self.nowtable)do
local buyNum=funcShopModel:findNum(v.id)

local buyNum=buyNum

local max=v.buyLimit[1][2]
if buyNum>=max then
v.sort=v.sort+10000
end
end
for k,v in ipairs(self.yettable)do
local buyNum=funcShopModel:findNum(v.id)

local buyNum=buyNum

local max=v.buyLimit[1][2]
if buyNum>=max then
v.sort=v.sort+10000
end
end
table.sort(self.nowtable,function(a,b)
return a.sort<b.sort
end)
table.sort(self.yettable,function(a,b)
return a.sort<b.sort
end)

end

function UIZZSH_ShopWin:SetLayoutGroup()
self.nowtable,self.yettable=self:recordreward()
self:paixuShop()

local num=0
if next(self.nowtable)then
num=num+1
end
if next(self.yettable)then
num=num+1
end
if num==0 then
return
end
self.content:setChildLayoutGroupCreateItems(num)

local name
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
if shSeasonId==-1 then
local raceIndex=zhengzhanshanhaiModel:getRaceIndex()
name=cfgHelper.get2(cfg_zhengzhanshanhaisessionconfig_get,raceIndex,'name')
else

name=cfgHelper.get(cfg_zhengzhanshanhainewconfig_get,shSeasonId,'name')
end

local widgets=self.content:getChildLayoutGroupGridList()

local setIndex=0

if next(self.nowtable)then
widgets[setIndex]:SetChildActive(3,true)
self:Setshopinfo(widgets[setIndex],self.nowtable,name)
setIndex=setIndex+1
end


if next(self.yettable)then
name='以往赛季'
widgets[setIndex]:SetChildActive(3,false)
self:Setshopinfo(widgets[setIndex],self.yettable,name)
end


end

function UIZZSH_ShopWin:Setshopinfo(widget,itemtable,name)
widget:SetChildLayoutGroupCreateItems(1,#itemtable)

widget:SetChildText(2,name)
local items=widget:GetChildLayoutGroupGridList(1)
for j=0,items.Count-1 do
local item=items[j]
item:SetChildActive(1,true)
local cfg=itemtable[j+1]



local itemid=cfg.itemId
local conf={itemid=itemid,showCountBG=false,showStage=true,name=''}

local max=cfg.buyLimit[1][2]
local buyNum=funcShopModel:findNum(cfg.id)

local countText=cfg.itemNum
if countText==1 then

countText=nil
end
widgetHelper.setNormalRewardItem(item,cmp.item,{itemid,0,showStage=true,countText=countText})

if cfg.xiyouFlag then
item:SetChildActive(cmp.xiyou,true)
else
item:SetChildActive(cmp.xiyou,false)
end

if cfg.consume and cfg.consume[1]then
item:SetChildActive(cmp.jiagenum2,true)
item:SetChildActive(cmp.icon2,true)
item:SetChildText(cmp.name,itemsConfig.getItemName(itemid))
local count=itemsModel.getCount(cfg.consume[1][1])
local itemtxt=""
if count<cfg.consume[1][2]then
itemtxt=string.format("<color=#c82c2c>%d</color>",cfg.consume[1][2])
else
itemtxt=string.format("<color=#171311>%d</color>",cfg.consume[1][2])
end
item:SetChildText(cmp.jiagenum2,itemtxt)
item:SetChildIcon(cmp.icon2,iconHelper.getIconName(cfg.consume[1][1]),false)

if cfg.consume[2]then
item:SetChildText(cmp.name,itemsConfig.getItemName(itemid))
local count=itemsModel.getCount(cfg.consume[2][1])
local itemtxt=""
if count<cfg.consume[2][2]then
itemtxt=string.format("<color=#c82c2c>%d</color>",cfg.consume[2][2])
else
itemtxt=string.format("<color=#171311>%d</color>",cfg.consume[2][2])
end
item:SetChildText(cmp.jiagenum1,itemtxt)
item:SetChildIcon(cmp.icon1,iconHelper.getIconName(cfg.consume[2][1]),false)
else

item:SetChildActive(cmp.jiagenum1,false)
item:SetChildActive(cmp.icon1,false)
end
else
item:SetChildText(cmp.name,itemsConfig.getItemName(itemid))
local count=itemsModel.getCount(cfg.money[1])
local itemtxt=""
if count<cfg.money[2]then
itemtxt=string.format("<color=#c82c2c>%d</color>",cfg.money[2])
else
itemtxt=string.format("<color=#171311>%d</color>",cfg.money[2])
end
item:SetChildText(cmp.jiagenum2,itemtxt)
item:SetChildText(cmp.jiagenum2,cfg.money[2])
item:SetChildIcon(cmp.icon2,iconHelper.getIconName(cfg.money[1]),false)

item:SetChildActive(cmp.jiagenum1,false)
item:SetChildActive(cmp.icon1,false)
end

if cfg.buyLimit then
local cfgLimit=cfgHelper.get(cfg_shoplimitconfig_get,cfg.buyLimit[1][1])
local str=FMT.fmt("{0}{1}",cfgLimit.limitStr,tonumber(max-buyNum))
item:SetChildText(cmp.limit,str)
else
item:SetChildText(cmp.limit,'')
end
item:SetChildImageExGray(cmp.clickbg,(max-buyNum)<=0)
item:SetChildImageExGray(12,(max-buyNum)<=0)
item:SetChildActive(cmp.isbuy,(max-buyNum)<=0)

item:SetChildButtonClick(cmp.clickbg,function()
self:onClickBuyItem(cfg)
end)





if buyNum>=max then
item:SetChildGraphicGray(cmp.item,true,true)
end



















local show_sjflag=cfg.sjflag
if show_sjflag then
item:SetChildActive(cmp.seasonLimitFlag,true)
else
item:SetChildActive(cmp.seasonLimitFlag,false)
end
end

end


function UIZZSH_ShopWin:onClickBuyItem(cfg)


if not cfg then
return
end



local buyId=cfg.id

local buyNum=funcShopModel:findNum(cfg.id)
local max=cfg.buyLimit[1][2]
if buyNum>=max then
return
end


if cfg.consume then
local money1=cfg.consume[1][1]
local money1_num=cfg.consume[1][2]
local isEoughMoney=moneyModel.checkEnoughMoney(money1,money1_num)
if not isEoughMoney then
local moneyName=moneyModel.getMoneyName(money1)
local err=FMT.fmt('{0}不足',moneyName)
UIManager.error(err)
gainControl:showGainWin(money1)
return
end
if cfg.consume[2]then
local money2=cfg.consume[2][1]
local money2_num=cfg.consume[2][2]
local isEoughMoney2=moneyModel.checkEnoughMoney(money2,money2_num)
if not isEoughMoney2 then
local moneyName=moneyModel.getMoneyName(money2)
local err=FMT.fmt('{0}不足',moneyName)
UIManager.error(err)
gainControl:showGainWin(money2)
return
end
end

else
local moneyType=cfg.money[1]
local singlePrice=cfg.money[2]
local isEoughMoney=moneyModel.checkEnoughMoney(moneyType,singlePrice)
if not isEoughMoney then
local moneyName=moneyModel.getMoneyName(moneyType)
local err=FMT.fmt('{0}不足',moneyName)
UIManager.error(err)
gainControl:showGainWin(moneyType)
return
end
end
local iconname=nil
local iconStr=nil
local iconname2=nil
local iconStr2=nil
local itemid=nil
local itemid2=nil
local singlePrice=0
local singlePrice2=0
if cfg.consume then
itemid=cfg.consume[1][1]
iconname=iconHelper.getIconName(cfg.consume[1][1])

iconStr=chatEmotHelper.getIconEmotMesg(iconname,35)
singlePrice=cfg.consume[1][2]
if cfg.consume[2]then
itemid2=cfg.consume[2][1]
iconname2=iconHelper.getIconName(cfg.consume[2][1])
iconStr2=chatEmotHelper.getIconEmotMesg(iconname2,35)
singlePrice2=cfg.consume[2][2]
end
else
itemid=cfg.money[1]
iconname=iconHelper.getIconName(cfg.money[1])
iconStr=chatEmotHelper.getIconEmotMesg(iconname,35)
singlePrice=cfg.money[2]
end

local showdata=
{
type='UIUseItemDialouge_2',
title='提示',
canceltext='取消',
oktext='购买',
max=max-buyNum,
itemid=itemid,
iconStr=iconStr,
singlePrice=singlePrice,
itemid2=itemid2,
iconStr2=iconStr2,
singlePrice2=singlePrice2,

okcallback=function(num)

funcShopController.send_23_2(self.shopId,buyId,num)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
