







def_class("UIMJ_ShopWin",UIWindowBase)









function UIMJ_ShopWin:bindComponents()

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


function UIMJ_ShopWin:unbindComponents()
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


















local _this
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

local childIndex=
{
moneyTxt=0,
moneyImg=1,
sold=2,
special=6,
item=7,
limit=8,
name=9,
lock=10,
lockTxt=11,
unlock=12,
normalBg=13,
grayBg=14,
speBg=15,
limitbg=16,
jiazi=17,
btnClick=18,
}

function UIMJ_ShopWin:onLoaded(...)
self:bindComponents()
notifySystem:listenNotify(notifyConfig.onCommonShopData,self.onCommonShopData)
notifySystem:listenNotify(notifyConfig.onCommonShopChange,self.onCommonShopChange)
notifySystem:listenNotify(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
notifySystem:listenNotify(notifyConfig.onSeasonChange,self.onSeasonChange)
_this=self
end


function UIMJ_ShopWin:__delete()
self:unbindComponents()
self:stopSelfTimer()
notifySystem:removelistener(notifyConfig.onCommonShopData,self.onCommonShopData)
notifySystem:removelistener(notifyConfig.onCommonShopChange,self.onCommonShopChange)
notifySystem:removelistener(notifyConfig.onSeasonStageChange,self.onSeasonStageChange)
notifySystem:removelistener(notifyConfig.onSeasonChange,self.onSeasonChange)
_this=nil
end


function UIMJ_ShopWin:onTipsClick(index)
local widgets=self.content:getChildLayoutGroupGridList()
local itemWidget=widgets[index]
if itemWidget then












local winParams={
parentWin=self,
lang='UIMJ_ShopWin_mjrule_%d',
num=nil,
posWidget=itemWidget,
posWidgetIndex=5,
pos={x=405,y=-90},
}
self:showWindow('UIMJ_ShopWinRuleWin',winParams)
end
end




function UIMJ_ShopWin:onShow(argtable,afterOnloaded)
self.shopId=eFuncShopType.eMojieSaiJi
self.config=cfg_devildomshopconfig()
self.shopCfg=cfgHelper.get(cfg_shoplistconfig_get,self.shopId)
self.sceneidx=xianjieModel:getSceneIndex()
if afterOnloaded then
funcShopController.send_23_1(self.shopId)
end


local moneyBar=table.weakCopy(self.shopCfg.moneyBar)
UIManager:showWindow('UITopMoneyWin',moneyBar)
self.data=funcShopModel:GetMoJieShop()
self:SetLayoutGroup(true)


if argtable and argtable.canvasIdx then
self.canvasIdx=argtable.canvasIdx
self:setCanvasIndex(-1,argtable.canvasIdx)
end
end


function UIMJ_ShopWin:onHide()

end


function UIMJ_ShopWin.onCommonShopData(shopId)
if _this.shopId==shopId then
_this:SetLayoutGroup()
end
end
function UIMJ_ShopWin.onCommonShopChange(shopId)
if _this.shopId==shopId then
_this:SetLayoutGroup()
end
end

function UIMJ_ShopWin.onSeasonStageChange(season_id,chapter_idx)
_this:SetLayoutGroup()
end
function UIMJ_ShopWin.onSeasonChange(season_id,chapter_idx)
_this:SetLayoutGroup()
end


function UIMJ_ShopWin:SetLayoutGroup()
self.shopList=self:get_sort_list(self.shopId)
local length=#self.shopList


self.content:setChildLayoutGroupCreateItems(1)
local widgets=self.content:getChildLayoutGroupGridList()
local itemWidget=widgets[0]

itemWidget:SetChildActive(3,true)


local shSeasonId=xianjieController:getMoJieSaiJiID()
local SJname=cfgHelper.get(cfg_devildomseasonconfig_get,shSeasonId,'name')
itemWidget:SetChildText(2,SJname)


itemWidget:SetChildLayoutGroupCreateItems(1,length)


itemWidget:SetChildButtonClick(5,function()
if _this==nil then return end
self:onTipsClick(0)
end)


self:daojishipanel(itemWidget)


self:Setshopinfo(itemWidget)
end
function UIMJ_ShopWin:Setshopinfo(widget,itemtable)
local items=widget:GetChildLayoutGroupGridList(1)
for j=0,items.Count-1 do
local item=items[j]
item:SetChildActive(1,true)
local cfgItem=self.shopList[j+1]

local sold=cfgItem.sold

local unlock=cfgItem.unlock
local cfg=cfgItem.cfg
local itemid=cfg.itemId


local max=cfg.buyLimit[1][2]
local buyNum=funcShopModel:findNumMoJie(cfg.id)




local countText=cfg.itemNum
if countText==1 then
countText=nil
end
widgetHelper.setNormalRewardItem(item,childIndex.item,{itemid,0,showStage=true,countText=countText})
item:SetChildGraphicGray(childIndex.item,sold==true,true)


item:SetChildText(childIndex.name,itemsConfig.getItemName(itemid))

item:SetChildActive(childIndex.lock,not unlock)

item:SetChildActive(childIndex.jiazi,(j+3)%3==0)

item:SetChildActive(childIndex.sold,sold)

item:SetChildText(childIndex.limit,"")
item:SetChildText(childIndex.moneyTxt,"")
item:SetChildActive(childIndex.limitbg,false)

if not unlock then
item:SetChildText(childIndex.lockTxt,funcShopModel:get_lock_tips(self.shopId,cfg.id))
item:SetChildActive(childIndex.unlock,false)
item:SetChildActive(childIndex.grayBg,true)
item:SetChildActive(childIndex.speBg,false)
else
item:SetChildActive(childIndex.unlock,true)
item:SetChildActive(childIndex.sold,sold)
item:SetChildActive(childIndex.grayBg,sold==true)
item:SetChildActive(childIndex.speBg,cfg.xiyouFlag==1)


if sold then

else

if cfg.buyLimit then
local cfgLimit=cfgHelper.get(cfg_shoplimitconfig_get,cfg.buyLimit[1][1])
max=max-buyNum
local str=FMT.fmt("{0}{1}",cfgLimit.limitStr,tonumber(max))
item:SetChildText(childIndex.limit,str)
item:SetChildActive(childIndex.limitbg,true)
else
item:SetChildActive(childIndex.limitbg,false)
end

item:SetChildActive(childIndex.special,cfg.xiyouFlag==1)
end


if cfg.consume and cfg.consume[1]then
local costId=cfg.consume[1][1]
local costNum=cfg.consume[1][2]
local bagcount=itemsModel.getCount(costId)
local itemtxt=""
if bagcount<costNum then
itemtxt=string.format("<color=#c82c2c>%d</color>",costNum)
else
itemtxt=string.format("<color=#171311>%d</color>",costNum)
end
item:SetChildIcon(childIndex.moneyImg,iconHelper.getIconName(costId),false)
item:SetChildText(childIndex.moneyTxt,itemtxt)
else
if cfg.money then
local moneyType=cfg.money[1]
local moneyNum=cfg.money[2]
local bagcount=moneyModel.getMoney(moneyType)
local itemtxt=""
if bagcount<moneyNum then
itemtxt=string.format("<color=#c82c2c>%d</color>",moneyNum)
else
itemtxt=string.format("<color=#171311>%d</color>",moneyNum)
end
item:SetChildIcon(childIndex.moneyImg,iconHelper.getIconName(moneyType),false)
item:SetChildText(childIndex.moneyTxt,itemtxt)
end
end
end


item:SetChildActive(childIndex.btnClick,true)
item:SetChildButtonClick(childIndex.btnClick,function()
self:onClickBuyItem(j)
end)














end
end





function UIMJ_ShopWin:recordreward()
local shSeasonId=xianjieController:getMoJieSaiJiID()
local checkSeason=false
if shSeasonId==-1 then
checkSeason=true
end

local nowsaiji=xianjieController:getMoJieSaiJiID()

local nowtable={}
local yettable={}
for a,b in pairs(self.config)do
local unlock=b.unlock
local flag=true
local minsaiji=nil
for k,v in ipairs(unlock)do
flag=funcShopModel:CheckMoJie(v[1],v)
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
isShow=funcShopModel:CheckMoJie(v[1],v)
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

function UIMJ_ShopWin:paixuShop()
for k,v in ipairs(self.nowtable)do
local buyNum=funcShopModel:findNumMoJie(v.id)

local buyNum=buyNum

local max=v.buyLimit[1][2]
if buyNum>=max then
v.sort=v.sort+10000
end
end
for k,v in ipairs(self.yettable)do
local buyNum=funcShopModel:findNumMoJie(v.id)

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

function UIMJ_ShopWin:SetLayoutGroup2()
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
local shSeasonId=xianjieController:getMoJieSaiJiID()
if shSeasonId==-1 then
local raceIndex=xianjieController:getMoJieSaiJiID()
name=cfgHelper.get2(cfg_devildomseasonconfig_get,raceIndex,'name')
else

name=cfgHelper.get(cfg_devildomseasonconfig_get,shSeasonId,'name')
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


function UIMJ_ShopWin:onClickBuyItem(index)
index=index+1
if index==0 then
return
end
local cfgItem=self.shopList[index]
local sold=cfgItem.sold
local unlock=cfgItem.unlock
local cfg=cfgItem.cfg

if sold then
UIManager.error("已售罄")
return
end
local lockstr="未解锁"
if cfgItem.warn_str then
lockstr=cfgItem.warn_str
end
if not unlock then
UIManager.error(lockstr)
return
end
local buyId=cfg.id

local buyNum=funcShopModel:findNumMoJie(cfg.id)
local max=cfg.buyLimit[1][2]
if buyNum>=max then
return
end

if cfg.consume then
local money1=cfg.consume[1][1]
local money1_num=cfg.consume[1][2]
local isEoughMoney=moneyModel.checkEnoughMoney(money1,money1_num)
if not isEoughMoney then



gainControl:showGainWin(money1)
return
end
if cfg.consume[2]then
local money2=cfg.consume[2][1]
local money2_num=cfg.consume[2][2]
local isEoughMoney2=moneyModel.checkEnoughMoney(money2,money2_num)
if not isEoughMoney2 then



gainControl:showGainWin(money2)
return
end
end
else
local moneyType=cfg.money[1]
local singlePrice=cfg.money[2]
local isEoughMoney=moneyModel.checkEnoughMoney(moneyType,singlePrice)
if not isEoughMoney then



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

if itemid and itemid2 then
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
else
local showdata=
{
type='UIUseItemDialouge',
title='提示',
canceltext='取消',
oktext='购买',
max=max-buyNum,
itemId=itemid,
unitPrice=singlePrice,
okcallback=function(num)
itemsModel:useItem(itemid,singlePrice*num,function()
funcShopController.send_23_2(self.shopId,buyId,num)
end,WARNING_TYPE.eWarning)
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
end


function UIMJ_ShopWin:get_sort_list(shopId,locklimit)
local cfg=funcShopModel.get_shop_item_conf(shopId)
local list={}
local locknum=0
for i,v in pairs(cfg)do
if i~='const_def'then
local item={}
local sortId=0
local buyData=funcShopModel:get_data(shopId,v.id)
local check=true
if funcShopModel:check_item_unlock(shopId,v.id,nil,'hide')then
local isunlock,warn_str=funcShopModel:check_item_unlock(shopId,v.id)
if isunlock then
if v.sort~=nil then
sortId=v.sort
end
item.unlock=true
item.warn_str=warn_str
else
locknum=locknum+1
if v.unlockSort~=nil then
sortId=v.unlockSort
elseif v.sort~=nil then
sortId=v.sort
else
sortId=1
end
sortId=sortId*1000
if locklimit~=nil then
if locknum>locklimit then
check=false
end
end
end

if buyData then
local buyNum=funcShopModel:findNumMoJie(v.id)
if v.buyLimit and buyNum>=v.buyLimit[1][2]then
item.sold=true
sortId=sortId+1000000000
end
else
local buyNum=funcShopModel:findNumMoJie(v.id)
if v.buyLimit and buyNum>=v.buyLimit[1][2]then
item.sold=true
sortId=sortId+1000000000
end
end

item.sortId=sortId
item.cfg=v
if check then
table.insert(list,item)
end
end
end
end

table.sort(list,function(a,b)return a.sortId<b.sortId end)
return list
end

function UIMJ_ShopWin:daojishipanel(widget,init)
widget:SetChildActive(4,false)
local endtime=xianjieController:getMoJieSaiJieTime()
if endtime then
local curTime=timeHelper.getServerShortTime()
local const_def=cfgHelper.getdef(cfg_devildomshopconfig)
local duration=const_def.duration or 0












local newtime=endtime+duration
if curTime<newtime then
widget:SetChildActive(4,true)
self:refreshTime(widget,newtime,2)
end
end
end
function UIMJ_ShopWin:refreshTime(widget,endTime,flag)
local name="赛季关闭："
if flag==2 then
name="商店关闭："
end
local curTime=timeHelper.getServerShortTime()
local timeStr=''
if(endTime-curTime)>0 then
timeStr=FMT.fmt('<color=#ffeed1>{1}</color>{0}',timeHelper.format_time_stamp3(endTime-curTime),name)
widget:SetChildText(4,timeStr)
else
widget:SetChildText(4,'')
end
self:stopSelfTimer()
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0
if showTime>0 then
timeStr=FMT.fmt('<color=#ffeed1>{1}</color>{0}',timeHelper.format_time_stamp3(showTime),name)
widget:SetChildText(4,timeStr)
else
widget:SetChildText(4,'')
end
if dtTime<=-1 then
self:stopSelfTimer()
if flag==1 then
funcShopController.send_23_1(self.shopId)
else
if UIManager:isActive('UIFuncShopMenuWin')then
UIManager:closeWindow('UIFuncShopMenuWin')
UIManager.info('魔界商店已关闭')
end
end
end
end
self.timer=self:setTimer(1,0,func)
end
function UIMJ_ShopWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UIMJ_ShopWin:testttt()

local enterData=xianjieModel:getMoJieEnterData()
local cfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
local sHandleType=cfg.csid
local nowchapteridx,stage=seasonModel:getHandleLastOpenStage(sHandleType)







end



