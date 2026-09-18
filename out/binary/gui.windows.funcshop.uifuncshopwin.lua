







def_class("UIFuncShopWin",UIWindowBase)









function UIFuncShopWin:bindComponents()

self.animDB=UIObject.get(self,0)
self.animFan=UIObject.get(self,1)
self.background=UIObject.get(self,2)
self.content=UIObject.get(self,3)
self.goodsScrollview=UIObject.get(self,4)
self.menu=UIObject.get(self,5)
self.mouse1=UIObject.get(self,6)
self.mouse2=UIObject.get(self,7)
self.mutiaoScroller=UIObject.get(self,8)
self.scrollView=UIScrollView.get(self,9)
self.timeText=UIText.get(self,10)
self.timeTitle=UIText.get(self,11)
self.timeTitleBg=UIObject.get(self,12)
self.title=UIText.get(self,13)



end


function UIFuncShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.animDB);self.animDB=nil;
_UIObject_release(self.animFan);self.animFan=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.goodsScrollview);self.goodsScrollview=nil;
_UIObject_release(self.menu);self.menu=nil;
_UIObject_release(self.mouse1);self.mouse1=nil;
_UIObject_release(self.mouse2);self.mouse2=nil;
_UIObject_release(self.mutiaoScroller);self.mutiaoScroller=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.timeTitle);self.timeTitle=nil;
_UIObject_release(self.timeTitleBg);self.timeTitleBg=nil;
_UIObject_release(self.title);self.title=nil;
end



















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
}
local _this=nil

function UIFuncShopWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onCommonShopData,self.onCommonShopData)

local clickEvent=function(...)
self:onClickItemCallback(...)
end
self.goodsScrollview:setChildScrollViewInit(0.5,true,clickEvent,nil)




end


function UIFuncShopWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onCommonShopData,self.onCommonShopData)
end




function UIFuncShopWin:onShow(argtable,afterOnloaded)
local shopId=argtable.shopId
self.shopId=shopId

self.shopCfg=cfgHelper.get(cfg_shoplistconfig_get,self.shopId)

local moneyBar=self.shopCfg.moneyBar

UIManager:showWindow('UITopMoneyWin',moneyBar)

self:updateView(true)

if argtable and argtable.canvasIdx then
self.canvasIdx=argtable.canvasIdx
self:setCanvasIndex(-1,argtable.canvasIdx)
end

end

function UIFuncShopWin:refreshTime(endTime)
local curTime=timeHelper.getServerShortTime()
local timeStr=FMT.fmt('<color=#ffeed1>赛季限购刷新：</color>\n{0}',timeHelper.format_time_stamp3(endTime-curTime))
self.timeText:setText(timeStr)
self:stopSelfTimer()
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0
local timeStr=FMT.fmt('<color=#ffeed1>赛季限购刷新：</color>\n{0}',timeHelper.format_time_stamp3(showTime))
self.timeText:setText(timeStr)
if dtTime<=-5 then
self:stopSelfTimer()
funcShopController.send_23_1(self.shopId)
end
end
self.timer=self:setTimer(1,0,func)
end

function UIFuncShopWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIFuncShopWin:onfresh()
self:updateView()
end

function UIFuncShopWin:updateView(freshTime)

self.shopList=funcShopModel:get_sort_list(self.shopId)
local length=#self.shopList
self.goodsScrollview:setChildScrollViewCreateGrids(length,3)

for i=1,length do
self:flushGoods(i-1)
end

local isShowTitleTimeRoot=false


local endtime=funcShopController:getEndTime(self.shopId)
if endtime then
self.timeText:setActive(true)
self:refreshTime(endtime)
isShowTitleTimeRoot=true
else
self.timeText:setActive(false)
end


self.timeTitleBg:setActive(isShowTitleTimeRoot)
local goodsScrollViewHeight=isShowTitleTimeRoot and 422 or 500
local goodsScrollViewPosY=isShowTitleTimeRoot and-295 or-250
self.goodsScrollview:setChildSizeDelta(1109.18,goodsScrollViewHeight)
self.goodsScrollview:setChildAnchoredPos(507.0545,goodsScrollViewPosY)
end

function UIFuncShopWin:flushGoods(index)



local cfgItem=self.shopList[index+1]
local sold=cfgItem.sold
local unlock=cfgItem.unlock
local cfg=cfgItem.cfg
local slot=self.goodsScrollview:getChildScrollViewItemWidget(index)

local buyData=funcShopModel:get_data(self.shopId,cfg.id)
local buyNum=buyData and buyData.buyNum or 0
local max=nil

local itemId=cfg.itemId












widgetHelper.setNormalRewardItem(slot,childIndex.item,{itemId,0,showStage=true})
slot:SetChildGraphicGray(childIndex.item,sold==true,true)

slot:SetChildText(childIndex.name,itemsConfig.getItemName(itemId))
slot:SetChildActive(childIndex.lock,not unlock)


slot:SetChildActive(17,(index+3)%3==0)

slot:SetChildText(childIndex.limit,"")
slot:SetChildText(childIndex.moneyTxt,"")
slot:SetChildActive(childIndex.limitbg,false)

slot:SetChildWeakGuideComponentId(-1,FMT.fmt('UIFuncShopWin.shopId_{0}_shopItem_{1}.root',self.shopId,itemId))

if not unlock then
slot:SetChildText(childIndex.lockTxt,funcShopModel:get_lock_tips(self.shopId,cfg.id))
slot:SetChildActive(childIndex.unlock,false)
slot:SetChildActive(childIndex.grayBg,true)
slot:SetChildActive(childIndex.speBg,false)
else
slot:SetChildActive(childIndex.unlock,true)
slot:SetChildActive(childIndex.sold,sold)
slot:SetChildActive(childIndex.grayBg,sold==true)
slot:SetChildActive(childIndex.speBg,cfg.xiyouFlag==1)
if sold then

else
if cfg.buyLimit then
local cfgLimit=cfgHelper.get(cfg_shoplimitconfig_get,cfg.buyLimit[1][1])
max=cfg.buyLimit[1][2]-buyNum
slot:SetChildText(childIndex.limit,FMT.fmt("{0}{1}",cfgLimit.limitStr,max))
slot:SetChildActive(childIndex.limitbg,true)
end


slot:SetChildActive(childIndex.special,cfg.xiyouFlag==1)
end
if cfg.money then
slot:SetChildIcon(childIndex.moneyImg,iconHelper.getIconName(cfg.money[1]),false)
slot:SetChildText(childIndex.moneyTxt,cfg.money[2])
end
end


end


function UIFuncShopWin:onHide()

end

function UIFuncShopWin.onClickBaseItem(itemid,index,itemguid,attach)
if itemsConfig.isGubao(itemid)then
gubaoController:gubaoShowTips(itemid)
return
end
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end

function UIFuncShopWin:onClickItemCallback(clickNum,index)

index=index+1
if index==0 then
return
end
local cfgItem=self.shopList[index]
local sold=cfgItem.sold
local unlock=cfgItem.unlock
local cfg=cfgItem.cfg
local buyId=cfg.id
local buyData=funcShopModel:get_data(self.shopId,cfg.id)
local buyNum=buyData and buyData.buyNum or 0
local max=nil
if unlock then
if not sold then
if cfg.buyLimit then
max=cfg.buyLimit[1][2]-buyNum
end
end
end

if sold then
UIManager.error("已售罄")
return
end
if not unlock then
UIManager.error("未解锁")
return
end

local needItemId=cfg.money[1]
local unitPrice=cfg.money[2]



local showdata=
{
type='UIUseItemDialouge',
title='提示',
canceltext='取消',
oktext='购买',
max=max,
itemId=needItemId,
unitPrice=unitPrice,
okcallback=function(num)
itemsModel:useItem(needItemId,unitPrice*num,function()
funcShopController.send_23_2(self.shopId,buyId,num)
end,WARNING_TYPE.eWarning)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIFuncShopWin:onClickClose()
self:closeSelf()
end
local _CMP_INDEX={
cmpSelfItem=0,
cmpNomalIcon=1,
cmpSelectRoot=2,
cmpSelectIcon=3,
cmpReddot=4,
}
function UIFuncShopWin:refreshMenu(shopId)
local menu=funcShopModel:get_menu(shopId)
local tNum=#menu
if tNum>0 then
table.sort(menu,function(a,b)return a.shopIndex<b.shopIndex end)
self.menuList=menu
self.winlua:SetChildScrollRectEnable(self.scrollView:getID(),tNum>4)
self.scrollView:freshGridsNum(tNum,tNum,1,true)
for i,v in ipairs(menu)do
self:fillMenu(i,v,shopId)
end
if not self.isInit then
self.scrollView:setChildCanvasGroupAlpha(0)
self.scrollView:setChildCanvasGroupDOFade(1,0.5):SetDelay(0.5)
self.animFan:setActive(true)
self.animFan:setChildUIModelShowTarget(2007,1,nil,eAnimationID.enter)
self.isInit=true
end

end
end

function UIFuncShopWin:fillMenu(index,data,shopId)
local assetConfig=cfg_fulltabassetconfig_get(data.icon)
local nomalicon=assetConfig.nomalicon
local item=self.scrollView:getGridObjectByindex(index-1)
item:SetBaseItemChildIndex(_CMP_INDEX.cmpSelfItem,index)
item:SetChildCSImageSprite(_CMP_INDEX.cmpNomalIcon,nomalicon[1],nomalicon[2])
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,shopId==data.id)
if shopId==data.id then
self.selectMenuIdx=index
end
end

function UIFuncShopWin:on_click_callback(id,index,guid,attach)
local shopId=self.menuList[index].id
if shopId==eFuncShopType.eXianMeng then
local funcCfg=funcShopModel.FuncShopTypeFunc[shopId]
if(not funcCfg)or(funcCfg and funcCfg.checkOpen())then
self:showWindow('UIXianMengShopWin')
end
else
self:showWindow("UIFuncShopWin",{shopId=shopId})
end

local item=self.winlua:GetChildCSGUIBaseItem(index-1)
if item then
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,true)
end
if self.selectMenuIdx then
if item then
local item=self.winlua:GetChildCSGUIBaseItem(self.selectMenuIdx-1)
item:SetChildActive(_CMP_INDEX.cmpSelectRoot,false)
end
end
self.selectMenuIdx=index
end


function UIFuncShopWin.onCommonShopData(shopId)
if _this.shopId==shopId then
_this:updateView()
end
end
