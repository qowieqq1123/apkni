







def_class("UISubAct_tianxuyishiWin",UIWindowBase)









function UISubAct_tianxuyishiWin:bindComponents()

self.buyPageBtn=UIButton.get(self,0)
self.buyPageBtnReddot=UIObject.get(self,1)
self.buyPageBtnSelect=UIObject.get(self,2)
self.helpBtn=UIButton.get(self,3)
self.isShowReddotBtn=UIButton.get(self,4)
self.root=UIObject.get(self,5)
self.sellPageBtn=UIButton.get(self,6)
self.sellPageBtnReddot=UIObject.get(self,7)
self.sellPageBtnSelect=UIObject.get(self,8)
self.shopScrollerView=UIObject.get(self,9)
self.speakObj=UIObject.get(self,10)
self.speakText=UIText.get(self,11)
self.timeTxt=UIText.get(self,12)
self.titie=UIImage.get(self,13)

self.buyPageBtn:setButtonClick(function()self:onBuyPageBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)

self.sellPageBtn:setButtonClick(function()self:onSellPageBtn()end)



end


function UISubAct_tianxuyishiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buyPageBtn);self.buyPageBtn=nil;
_UIObject_release(self.buyPageBtnReddot);self.buyPageBtnReddot=nil;
_UIObject_release(self.buyPageBtnSelect);self.buyPageBtnSelect=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sellPageBtn);self.sellPageBtn=nil;
_UIObject_release(self.sellPageBtnReddot);self.sellPageBtnReddot=nil;
_UIObject_release(self.sellPageBtnSelect);self.sellPageBtnSelect=nil;
_UIObject_release(self.shopScrollerView);self.shopScrollerView=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.titie);self.titie=nil;
end
















local _this

local abName={"ui/windows/activities/sub_duihuanhuodong/duihuanhuodongicons_atlas_pak.ab",
"ui/windows/activities/sub_duihuanhuodong/duihuanhuodongicons2_atlas_pak.ab",
"ui/windows/activities/activities_common_atlas_pak.ab"}
local pageType={
eBuy=1,
eSell=2,
}
local speakType={
standby=1,
exchange=2,
}

function UISubAct_tianxuyishiWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)

end


function UISubAct_tianxuyishiWin:__delete()
_this=nil
self:unbindComponents()
if self.showMoney then
self.showMoney=nil
self:closeWindow('UITopMoneyWin4')
end
end


function UISubAct_tianxuyishiWin:onHide()
if self.showMoney then
self.showMoney=nil
self:closeWindow('UITopMoneyWin4')
end
end




function UISubAct_tianxuyishiWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.pageType=pageType.eBuy

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
end
self:refreshActTime()
self:refreshShopView(true)
self:refreshIsShowReddotBtn()
self:refreshPageBtn()
self:refreshShopbubble()
self:refreshPageBtnReddot()

local moneytypes=self.sub_actcfg.moneytypes
self.showMoney=moneytypes~=nil
if self.showMoney then
self:showWindow('UITopMoneyWin4',{moneys=moneytypes,offsetX=98,offsetY=-25})
else
self:closeWindow('UITopMoneyWin4')
end











reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
end

function UISubAct_tianxuyishiWin:refreshActTime()
local lerp=self.sub_actInfo:getEndLeftTime()
if lerp<0 then
lerp=0
end
local time_str=string.format('活动剩余时间：<color=#A9E152>%s</color>',timeHelper.format_time_stamp3(lerp))
self.timeTxt:setText(time_str)
end

function UISubAct_tianxuyishiWin:refreshShopView(isInit)
local c
if isInit then
local shopGoodList={}
for i,dhId in ipairs(self.sub_actcfg.dhList)do
local cfg=cfgHelper.get1(cfg_tianxuyishiduihuanconfig_get,dhId)
if cfg.etype==self.pageType then
local weight=0
local dhMax=cfg.dhMax
local buyTimes=self.sub_actInfo:getGoodBuyNum(dhId)
if dhMax>=0 and buyTimes>=dhMax then
weight=-1000000
elseif self.sub_actInfo:checkGoodBuyReddot(dhId)then
weight=1000000
end
local d={
dhId=dhId,
weight=weight,
}
table.insert(shopGoodList,d)
end
end
self.shopGoodList=shopGoodList
c=#self.shopGoodList
if c>1 then
table.sort(self.shopGoodList,function(a,b)
return a.weight>b.weight
end)
end
else
c=#self.shopGoodList
end

self.shopScrollerView:setChildScrollViewCreateGrids(c,1)
self.shopScrollerView:setChildScrollViewSelectItem(0,false,false,true)
local grids=self.shopScrollerView:getChildScrollViewItemWidgets()
for i=1,c do
local item=grids[i-1]
self:refreshShopItem(item,i)
end
end

function UISubAct_tianxuyishiWin:refreshShopItem(item,idx)
if item==nil then
item=self.shopScrollerView:getChildScrollViewItemWidget(idx-1)
end

local dhId=self.shopGoodList[idx].dhId
local cfg=cfgHelper.get1(cfg_tianxuyishiduihuanconfig_get,dhId)
local dhType=cfg.dhItem[1]
local dhItem=cfg.dhItem[2]
local buyTimes=self.sub_actInfo:getGoodBuyNum(dhId)
local buyMax=cfg.dhMax
local c

local buys={{dhItem[3],dhItem[4]}}
if dhType==4 then buys={{dhItem[4],dhItem[5]}}end
c=#buys
item:SetChildLayoutGroupCreateItems(2,c)
local grids1=item:GetChildLayoutGroupGridList(2)
for i=1,c do
local item1=grids1[i-1]
local d1=buys[i]
local itemid=d1[1]
local itemnum=d1[2]
local countStr=''
local showCountBG=false
if itemnum>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemnum)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item1:SetChildPropData(0,prop)
item1:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end

local costs=dhType==4 and{{dhItem[1],dhItem[3]}}or{{dhItem[1],dhItem[2]}}
c=#costs
item:SetChildLayoutGroupCreateItems(3,c)
local grids2=item:GetChildLayoutGroupGridList(3)
for i=1,c do
local item2=grids2[i-1]
local d2=costs[i]
local itemid=d2[1]
local itemnum=d2[2]
local conf
if dhType==1 then
conf={itemid=itemid,itemcount='',showCountBG=false,showname=false}
elseif dhType==2 then

local itemid=cfgHelper.get2(cfg_tianxuyishiduihuanconfig_get,dhId,'itemid')


conf={itemid=itemid,itemcount='',showCountBG=false,iconColor=d2[1],showname=false}
elseif dhType==3 then

local itemid=cfgHelper.get2(cfg_tianxuyishiduihuanconfig_get,dhId,'itemid')


conf={itemid=itemid,itemcount='',showCountBG=false,iconColor=d2[1],showname=false}
elseif dhType==4 then

local itemid=cfgHelper.get2(cfg_tianxuyishiduihuanconfig_get,dhId,'itemid')


conf={itemid=itemid,itemcount='',showCountBG=false,iconColor=d2[1],showname=false}
end
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item2:SetChildPropData(0,prop)
item2:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local countStr
local hasnum=0
if dhType==1 then
if moneyConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
else
hasnum=bagModel.getNotExpireItemCountById(itemid)
end
elseif dhType==2 then
hasnum=gubaoModel:getPieceCountByColor(itemid)
elseif dhType==3 then

hasnum=0
local needItemStage=dhItem[1]
local filter={}
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,1}
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eEquals,{needItemStage}}
local fabaoitems=bagControl.getBagItemsByFilter(BAG_TYPE.eMaterialsBag,filter,nil,false)

for _,fabaoMaterialItem in pairs(fabaoitems)do
hasnum=hasnum+bagModel.getNotExpireItemCountById(fabaoMaterialItem.itemid)
end
elseif dhType==4 then

hasnum=0
local needItemIdList=dhItem[2]
local filter={}
filter[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,needItemIdList}
local JGJZitems=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter,nil,false)

for _,JGJZitem in pairs(JGJZitems)do
hasnum=hasnum+bagModel.getNotExpireItemCountById(JGJZitem.itemid)
end
end
countStr=FMT.fmt('{0}/{1}',mathHelper.formatNumber(hasnum),mathHelper.formatNumber(itemnum))
if hasnum<itemnum then
countStr=FMT.fmt('<color=#c82c2c>{0}</color>',countStr)
else
countStr=FMT.fmt('<color=#549327>{0}</color>',countStr)
end
item2:SetChildText(1,countStr)

end
item:SetChildScrollRectEnable(1,c>=3)

item:SetChildActive(7,false)

local sellout=buyMax>=0 and buyTimes>=buyMax
item:SetChildActive(8,sellout)

item:SetChildActive(5,not sellout)

if not sellout and buyMax>0 then
item:SetChildActive(4,true)
local lerpbuy=buyMax-buyTimes
local limit_str=FMT.fmt('可兑换<color=#549327>{0}</color>次',lerpbuy)
item:SetChildText(4,limit_str)
else
item:SetChildActive(4,false)
end
if not sellout then
local canBuy=self.sub_actInfo:checkGoodBuyReddot(dhId)

item:SetChildImageExGray(5,not canBuy)

item:SetChildActive(6,canBuy)

item:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onClickItemBuy(dhId)
end)
end

item:SetChildActive(9,cfg.recommend==1)


end

function UISubAct_tianxuyishiWin:onClickItemBuy(dhId)
if not self.sub_actInfo:checkDoing()then
UIManager.error('活动已结束')
return
end
local canBuy=self.sub_actInfo:checkGoodBuyReddot(dhId)
local cfg=cfgHelper.get1(cfg_tianxuyishiduihuanconfig_get,dhId)
local dhItem=cfg.dhItem
local dhType=dhItem[1]
local dhList=dhItem[2]
local buyTimes=self.sub_actInfo:getGoodBuyNum(dhId)
local buyMax=cfg.dhMax
local lerpbuy=buyMax-buyTimes
if not canBuy then
if dhType==1 then
local needItemId=dhList[1]
gainControl:showCommonGainWin_item(needItemId)
elseif dhType==2 then
local needItemColor=dhList[1]
UIManager.error(string.format('%s满星古宝碎片不足',eQualityColorName_GB[needItemColor]))
elseif dhType==3 then

local needItemStage=dhList[1]
UIManager.error(string.format('%s法宝炼制材料不足',eQualityColorName_GB[needItemStage]))
elseif dhType==4 then

local needItemColor=dhList[1]
UIManager.error(string.format('%s景观建筑图纸不足',eQualityColorName_GB[needItemColor]))
end
return
end

if dhType==1 then
local needItemId,needItemCount=dhList[1],dhList[2]
local hasnum=0
if moneyConfig.isMoney(needItemId)then
hasnum=moneyModel.getMoney(needItemId)
else
hasnum=bagModel.getNotExpireItemCountById(needItemId)
end
local canBuyNum=math.floor(hasnum/needItemCount)
if buyMax>0 then
canBuyNum=math.min(canBuyNum,lerpbuy)
end
local callback=function(cnt)
if _this==nil then return end
local json_str=jsonHelper.encode({1,dhId,cnt})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end

if canBuyNum>1 then
local params={
title='批量兑换',
oktext='兑换',
canceltext='取消',
max=canBuyNum,
buyGoods={{dhList[3],dhList[4]}},
costGoods={{needItemId,needItemCount}},
okcallback=callback,
}
self:showWindow('UICommonUseItem_goods2goods_Win',params)
else
local params={
title='兑换',
oktext='兑换',
canceltext='取消',
max=1,
buyGoods={{dhList[3],dhList[4]}},
costGoods={{needItemId,needItemCount}},
okcallback=callback,
}
self:showWindow('UICommonUseItem_goods2goods_Win',params)
end
elseif dhType==2 then
local needItemColor,needItemCount,targetItemId,targetItemCount=unpack(dhList)
local callback=function(cnt,itemList)
if _this==nil then return end
local json_str=jsonHelper.encode({2,dhId,cnt,itemList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
local colorCount=gubaoModel:getPieceCountByColor(needItemColor)
local canBuyNum=math.floor(colorCount/needItemCount)
if buyMax>0 then
canBuyNum=math.min(canBuyNum,lerpbuy)
end
local params={
title='兑换',
needItemColor=needItemColor,
needItemCount=needItemCount,
targetItemId=targetItemId,
targetItemCount=targetItemCount,
max=canBuyNum,
colorCount=colorCount,
dhId=dhId,
okcallback=callback,
}
self:showWindow('UISubAct_tianxuyishiGuBaoSelectWin',params)
elseif dhType==3 then

local needItemStage,needItemCount,targetItemId,targetItemCount=unpack(dhList)
local callback=function(cnt,itemList)
if _this==nil then return end
local json_str=jsonHelper.encode({3,dhId,cnt,itemList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
local stageCount=0

local filter={}
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,1}
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eEquals,{needItemStage}}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eMaterialsBag,filter,nil,false)
for _,item in pairs(items)do
stageCount=stageCount+bagModel.getNotExpireItemCountById(item.itemid)
end
local canBuyNum=math.floor(stageCount/needItemCount)
if buyMax>0 then
canBuyNum=math.min(canBuyNum,lerpbuy)
end
local params={
title='兑换',
needItemStage=needItemStage,
needItemCount=needItemCount,
targetItemId=targetItemId,
targetItemCount=targetItemCount,
max=canBuyNum,
stageCount=stageCount,
dhId=dhId,
okcallback=callback,
}
self:showWindow('UISubAct_tianxuyishiFaBaoMaterialSelectWin',params)
elseif dhType==4 then

local needItemColor,needItemIdList,needItemCount,targetItemId,targetItemCount=unpack(dhList)
local callback=function(cnt,itemList)
if _this==nil then return end
local json_str=jsonHelper.encode({4,dhId,cnt,itemList})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end

local filter={}
filter[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,needItemIdList}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter,nil,false)
local colorCount=0
for _,item in ipairs(items)do
colorCount=colorCount+bagModel.getNotExpireItemCountById(item.itemid)
end

local canBuyNum=math.floor(colorCount/needItemCount)
if buyMax>0 then
canBuyNum=math.min(canBuyNum,lerpbuy)
end
local params={
title='兑换',
needItemColor=needItemColor,
needItemCount=needItemCount,
targetItemId=targetItemId,
targetItemCount=targetItemCount,
max=canBuyNum,
colorCount=colorCount,
dhId=dhId,
okcallback=callback,
needItemIdList=needItemIdList,
}
self:showWindow('UISubAct_tianxuyishiiJGJZSelectWin',params)
end
end

function UISubAct_tianxuyishiWin:onClickItem(itemId,index,guid,attach)
if itemId>0 then
tipsManager.showTips({itemid=itemId,itemguid=nil})
end
end


function UISubAct_tianxuyishiWin:refreshShopbubble(reset)
if self.refreshTimeIdshop then
self:stopTimerByID(self.refreshTimeIdshop)
self.refreshTimeIdshop=nil
end
self.refreshTimeFunshop=function()
self:doSpeaking_player(speakType.standby)
end
if not reset then
self.refreshTimeFunshop()
end
local bubbleTime=10
self.refreshTimeIdshop=self:setTimer(bubbleTime,0,self.refreshTimeFunshop)
end

function UISubAct_tianxuyishiWin:doSpeaking_player(sType)
local key
if sType==speakType.standby then
key="standbySpeak"
elseif sType==speakType.exchange then
key="exchangeSpeak"
end
local speakList=self.sub_actInfo:getSubActConfig(key,self.pageType)
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim_player()
end

function UISubAct_tianxuyishiWin:doTalkAnim_player()
if self.talkTween2~=nil then
self.talkTween2:Kill()
self.talkTween2=nil
end

self.speakObj:setScale(Vector3.zero)
self:delayDo(0.2,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween2=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween2=nil
_this.talkTween2=_this.speakObj:setChildDOScale(0.9,0.1,function()
if _this==nil then return end
_this.talkTween2=nil
return _this:talkEnd()
end)
end)
end)
end
function UISubAct_tianxuyishiWin:talkEnd()
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
self.speakShowTimer=self:delayDo(3.5,function()

if _this==nil then return end
_this.speakObj:setScale(Vector3.zero)
_this.speakObj:setChildCanvasGroupAlpha(0)

if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
end)
end

function UISubAct_tianxuyishiWin:rec_refresh()
self:refreshShopView(true)
end

function UISubAct_tianxuyishiWin:rec_Item(buyidxs)

end

function UISubAct_tianxuyishiWin:rec_buy(dhId)
local canBuy=self.sub_actInfo:checkGoodBuyReddot(dhId)
self:refreshShopView(not canBuy)
self:doSpeaking_player(speakType.exchange)
self:refreshShopbubble(true)
self:refreshPageBtnReddot()
end


function UISubAct_tianxuyishiWin:refreshIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
local isForbiddenShowReddot=actInfo:checkIsForbiddenShowReddot()
self.isShowReddotBtn:setActive(not isForbiddenShowReddot)
if isForbiddenShowReddot then
return
end
local isShowReddot=actInfo:checkIsShowReddot(self.pageType)
local btnWidget=self.isShowReddotBtn:getWidgetBase()
btnWidget:SetChildActive(0,not isShowReddot)
btnWidget:SetChildActive(1,isShowReddot)
end

function UISubAct_tianxuyishiWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
local isShowReddot=actInfo:checkIsShowReddot(self.pageType)
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot,self.pageType)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_tianxuyishiWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.actID==actId and _this.subType==subType and _this.subid==subId then
_this:refreshIsShowReddotBtn()
end
end



function UISubAct_tianxuyishiWin:onBuyPageBtn()
if self.pageType==pageType.eBuy then
return
end
self.pageType=pageType.eBuy
self:refreshShopView(true)
self:refreshPageBtn()
self:refreshIsShowReddotBtn()
end

function UISubAct_tianxuyishiWin:onSellPageBtn()
if self.pageType==pageType.eSell then
return
end
self.pageType=pageType.eSell
self:refreshShopView(true)
self:refreshPageBtn()
self:refreshIsShowReddotBtn()
end

function UISubAct_tianxuyishiWin:refreshPageBtn()
self.buyPageBtnSelect:setActive(self.pageType==pageType.eBuy)
self.sellPageBtnSelect:setActive(self.pageType==pageType.eSell)
end

function UISubAct_tianxuyishiWin:refreshPageBtnReddot()
local buyReddot=self.sub_actInfo:checkPageReddot(pageType.eBuy)
local sellReddot=self.sub_actInfo:checkPageReddot(pageType.eSell)
self.buyPageBtnReddot:setActive(buyReddot)
self.sellPageBtnReddot:setActive(sellReddot)
end

function UISubAct_tianxuyishiWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='tianxuyishi_help_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end