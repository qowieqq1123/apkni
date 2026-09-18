







def_class("UISubAct_ChaosLingChiExchangeWin",UIWindowBase)









function UISubAct_ChaosLingChiExchangeWin:bindComponents()

self.background=UIButton.get(self,0)
self.bgModel=UIObject.get(self,1)
self.bgModel2=UIObject.get(self,2)
self.catModel=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.currentTx=UIText.get(self,5)
self.Image=UIObject.get(self,6)
self.leftBtn=UIButton.get(self,7)
self.moneyBtn=UIButton.get(self,8)
self.rightBtn=UIButton.get(self,9)
self.root=UIObject.get(self,10)
self.ScrollView=UIEnhancedScrollerLua.get(self,11)
self.Tx=UIText.get(self,12)
self.tips=UIText.get(self,13)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UISubAct_ChaosLingChiExchangeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.bgModel2);self.bgModel2=nil;
_UIObject_release(self.catModel);self.catModel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.currentTx);self.currentTx=nil;
_UIObject_release(self.Image);self.Image=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Tx);self.Tx=nil;
_UIObject_release(self.tips);self.tips=nil;
end

















local UIListScroller=simple_class(UIEnhancedScroller)
local _this=nil
local _ab="ui/windows/activities/sub_niudanji/niudanji_atlas_pak.ab"
local _bgs={
[eQualityColor.eWhite]="image_ndjduihuanshangdianui_1",
[eQualityColor.eGreen]="image_ndjduihuanshangdianui_1",
[eQualityColor.eBlue]="image_ndjduihuanshangdianui_1",
[eQualityColor.ePurple]="image_ndjduihuanshangdianui_1",
[eQualityColor.eOrange]="image_ndjduihuanshangdianui_2",
[eQualityColor.eRed]="image_ndjduihuanshangdianui_3",
[eQualityColor.ePink]="image_ndjduihuanshangdianui_3",
}
local _checkFlag={
[1]=function(param)
return gubaoModel:checkActive(param)
end,
[2]=function(param)
return UIGongFaModel:isGongFaActive(param)
end,
}
local _itemKid={
bg=0,
item=1,
limitTimes=2,
numTx=3,
exchangeBtn=4,
limitBg=5,
over=6,
check=7,
moneyIcon=8,
}


function UISubAct_ChaosLingChiExchangeWin:onLoaded(...)
self:bindComponents()
_this=self
self.scrollscript=UIListScroller(self.ScrollView:getGameObject(),self.ScrollView:getCSharpObject(),nil,nil)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UISubAct_ChaosLingChiExchangeWin:__delete()
self:unbindComponents()
_this=nil
end




function UISubAct_ChaosLingChiExchangeWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.bgModel:setChildUIModelShowTarget(5420,1,{},eAnimationID.stand)
self.catModel:setChildUIModelShowTarget(4016,0.35,{},eAnimationID.stand)
self.bgModel2:setChildUIModelShowTarget(5421,1,{},eAnimationID.stand)
end
self.showCheck=self.activityId~=argtable.activityId or self.subId~=argtable.subId
self.activityId=argtable.activityId
self.subType=argtable.subType
self.subId=argtable.subId
self.activityData=argtable.activityData
self.config=argtable.config
self.money=self.config.money[1]

self:onLoadBackFinish()
end


function UISubAct_ChaosLingChiExchangeWin:onHide()

end

function UISubAct_ChaosLingChiExchangeWin.on_money_changed(mType,oldValue,newValue)
if _this.money==mType then
_this:refreshStar()
end
end



function UISubAct_ChaosLingChiExchangeWin:refreshStar()
local data=self.activityData.data
local moneyType=self.config.money[1]
local money=moneyModel.getMoney(moneyType)
self.currentTx:setText(money)
end

function UISubAct_ChaosLingChiExchangeWin:refreshView(actId,subType,subId)
if self.activityId==actId and self.subType==subType and self.subId==subId then
self:refreshStar()
self:refreshList()
end
end

function UISubAct_ChaosLingChiExchangeWin:refreshList()
self.dataList={}
local exchanges=self.activityData.data.exchanges
for i,v in ipairs(self.config.gift)do
local data={
index=i,
itemId=v[1],
itemNum=v[2],
cost=v[3],
max=v[4],
buyed=exchanges[i],
sort=(v[4]>0 and v[4]<=exchanges[i])and(10000+i)or i,
check=v[5],
}
table.insert(self.dataList,data)
end
table.sort(self.dataList,function(a,b)
return a.sort<b.sort
end)
if self.initList then
self.scrollscript.data=self.dataList
self.scrollscript:doRefreshActiveCellViews()
else
self.scrollscript:initData(self.dataList,300,#self.dataList)
self.initList=true
end
end

function UISubAct_ChaosLingChiExchangeWin:onLoadBackFinish()
if not self.loaded then
self.loaded=true
self.root:setActive(true)
end

local moneyType=self.config.money[1]
local moneyName=moneyModel.getMoneyName(moneyType)
self.Image:setImageIcon(iconHelper.getIconName(moneyType),false)
self.Tx:setText(moneyName)
self.tips:setText(FMT.fmt("{0}在活动结束后将被清空，请及时兑换",moneyName))

self:refreshStar()
self:refreshList()

end


function UIListScroller:OnScrollEndCall()
local sIndex=self:getStartCellViewIndex()
local eIndex=self:getEndCellViewIndex()

_this.leftBtn:setActive(sIndex>0)
_this.rightBtn:setActive(eIndex<(#_this.config.gift-1))
end

function UIListScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIListScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIListScroller:RefreshCell(dataIndex,cellIndex,item)
local data=self.data[dataIndex]
local rewardId=data.itemId
local rewardNum=data.itemNum
local showCountBG=rewardNum>1
local countStr=showCountBG and mathHelper.formatNumber(rewardNum)or''
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=true,colorEffect=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(_itemKid.item,function(...)itemsComponentHelper.onItemClick(...)end)
item:SetChildPropData(_itemKid.item,prop)

local buyMax=data.max
local buyNum=data.buyed
item:SetChildActive(_itemKid.limitBg,buyMax>0)
item:SetChildText(_itemKid.limitTimes,FMT.fmt("限购：{0}/{1}",buyNum,buyMax))

item:SetChildText(_itemKid.numTx,FMT.fmt("{0}",data.cost))

local itemCfg=itemsConfig.getConfig(rewardId)
item:SetChildCSImageSprite(_itemKid.bg,_ab,_bgs[itemCfg.color])

item:SetChildButtonClick(_itemKid.exchangeBtn,function()self:onClickExchangeBtn(dataIndex)end)
item:SetChildActive(_itemKid.exchangeBtn,buyMax<=0 or buyNum<buyMax)
item:SetChildActive(_itemKid.over,buyMax>0 and buyNum>=buyMax)
local moneyType=_this.config.money[1]
item:SetChildIcon(_itemKid.moneyIcon,iconHelper.getIconName(moneyType),false)

local check=false
if data.check then
local type=data.check[1]
local param=data.check[2]
check=_checkFlag[type](param)
end
item:SetChildActive(_itemKid.check,check)

end

function UIListScroller:onClickExchangeBtn(dataIndex)
local data=_this.activityData.data
local itemData=self.data[dataIndex]

local buyCnt=itemData.max>0 and itemData.max-itemData.buyed or nil
if buyCnt and buyCnt<=0 then
UIManager.error("已售罄")
return
end
local moneyType=_this.config.money[1]
local money=moneyModel.getMoney(moneyType)
local moneyName=moneyModel.getMoneyName(moneyType)
local starCnt=math.floor(money/itemData.cost)
if starCnt<=0 then
UIManager.error(FMT.fmt("{0}不足",moneyName))
return
end

local least=buyCnt and math.min(buyCnt,starCnt)or starCnt

if least>1 then
local refresh=function(num)
local cost=itemData.cost*num
local exNum=itemData.itemNum*num
local itemName=itemsConfig.getColorName(itemData.itemId)

local moneyIconName=iconHelper.getIconName(moneyType)
local contentStr=FMT.fmt("是否花费quad-icon={3}-quad<color=#ca631d>{0}</color>兑换{1}个{2}",cost,exNum,itemName,moneyIconName)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=least,
tips=nil,
oktext='兑换',
canceltext='取消',
okcallback=function(num)
call_activitiesHandle_func("activitiesHandle_chaoslingchi","reqExchange",_this.activityId,_this.subId,itemData.index,num)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
local cost=itemData.cost*least
local itemName=itemsConfig.getColorName(itemData.itemId)
local moneyIconName=iconHelper.getIconName(moneyType)
local contentStr=FMT.fmt("是否花费quad-icon={2}-quad<color=#ca631d>{0}</color>兑换{1}",cost,itemName,moneyIconName)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
call_activitiesHandle_func("activitiesHandle_chaoslingchi","reqExchange",_this.activityId,_this.subId,itemData.index,least)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
end





function UISubAct_ChaosLingChiExchangeWin:onBackground()
self:onCloseBtn()
end



function UISubAct_ChaosLingChiExchangeWin:onCloseBtn()
if self.loaded then
self:closeSelf()
end
end



function UISubAct_ChaosLingChiExchangeWin:onLeftBtn()
local index=self.scrollscript:getStartCellViewIndex()
if index>0 then
self.scrollscript:jumpToDataIndex(index-1,0,0,true,0,0,nil)
self.scrollscript:OnScrollEndCall()
end
end



function UISubAct_ChaosLingChiExchangeWin:onMoneyBtn()
local moneyType=self.config.money[1]
gainControl:showGainWin(moneyType)
end



function UISubAct_ChaosLingChiExchangeWin:onRightBtn()
local index=self.scrollscript:getEndCellViewIndex()
if index<(#self.config.gift-1)then
self.scrollscript:jumpToDataIndex(index+1,0,0,true,0,0,nil)
self.scrollscript:OnScrollEndCall()
end
end

