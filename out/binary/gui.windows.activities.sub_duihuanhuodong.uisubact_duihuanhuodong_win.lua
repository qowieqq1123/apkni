







def_class("UISubAct_duihuanhuodong_win",UIWindowBase)









function UISubAct_duihuanhuodong_win:bindComponents()

self.root=UIObject.get(self,0)
self.boxModel=UIObject.get(self,1)
self.shopScrollerView=UIObject.get(self,2)
self.timeTxt=UIText.get(self,3)
self.isShowReddotBtn=UIButton.get(self,4)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)



end


function UISubAct_duihuanhuodong_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.boxModel);self.boxModel=nil;
_UIObject_release(self.shopScrollerView);self.shopScrollerView=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
end
















local _this

local abName={"ui/windows/activities/sub_duihuanhuodong/duihuanhuodongicons_atlas_pak.ab",
"ui/windows/activities/sub_duihuanhuodong/duihuanhuodongicons2_atlas_pak.ab",
"ui/windows/activities/activities_common_atlas_pak.ab"}
local imgType=
{
[1]={{3,"image_xianshilbui_2"},{1,"image_xianshilbui_2"},{1,"image_xianshidhlbui_1"}},
[2]={{2,"frame_chumoshangdian_01"},{2,"image_chumoshangdian_01"},{2,"image_chumoshangdian_02"}},
}


function UISubAct_duihuanhuodong_win:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)


end


function UISubAct_duihuanhuodong_win:__delete()
_this=nil
self:unbindComponents()
if self.showMoney then
self.showMoney=nil
self:closeWindow('UITopMoneyWin4')
end
end


function UISubAct_duihuanhuodong_win:onHide()
if self.showMoney then
self.showMoney=nil
self:closeWindow('UITopMoneyWin4')
end
end




function UISubAct_duihuanhuodong_win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.tab_idx=argtable.tab_idx

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self.windowType=self.sub_actcfg.windowType or 1

if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
end
self:refreshActTime()
self:refreshShopView(true)
self:refreshIsShowReddotBtn()

local moneytypes=self.sub_actcfg.moneytypes
self.showMoney=moneytypes~=nil
if self.showMoney then
self:showWindow('UITopMoneyWin4',{moneys=moneytypes,offsetX=175,offsetY=-40})
else
self:closeWindow('UITopMoneyWin4')
end

if afterOnloaded then
if self.sub_actcfg.showModel then
self.boxModel:setChildUIModelShowTarget(self.sub_actcfg.showModel[1],self.sub_actcfg.showModel[2],{},0,false,false,0,nil)
if self.sub_actcfg.showModel[3]then
self.boxModel:setChildUIModelShowTargetOffset(self.sub_actcfg.showModel[3],self.sub_actcfg.showModel[4])
end
else
self.boxModel:setChildUIModelShowTarget(4044,1,{},0,false,false,0,nil)
end
end
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
end

function UISubAct_duihuanhuodong_win:refreshActTime()
local lerp=self.sub_actInfo:getEndLeftTime()
if lerp<0 then
lerp=0
end
local time_str=FMT.fmt('{0}结束',timeHelper.format_time_stamp3(lerp))
self.timeTxt:setText(time_str)
end

function UISubAct_duihuanhuodong_win:handelData(data)
local buyidx=data.buyidx
local maxbuy=data.cfg[3]
local curbuy=self.sub_actInfo:getGoodBuyNum(buyidx)
local lerpbuy=maxbuy-curbuy
if lerpbuy<0 then lerpbuy=0 end
local canbuy=0
local weight=data.cfg[7]
local state=0
local state_=0
local notfix
if lerpbuy>0 then
state_=1
local costs=data.cfg[1]
local lp={}
for i,v in ipairs(costs)do
local itemid=v[1]
local itemnum=v[2]
local hasnum
if moneyConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
else
hasnum=bagModel.getNotExpireItemCountById(itemid)
end
lp[i]={itemnum,hasnum}
if hasnum<itemnum then
if notfix==nil then
notfix={itemid,itemnum-hasnum}
end
end
end
if notfix==nil then
state=2
else
state=1
end
if notfix==nil then
local min
for i,v in ipairs(lp)do
local m=math.floor(v[2]/v[1])
if min==nil or m<min then
min=m
end
end
if min~=nil then
canbuy=min
end
end
end
weight=weight+state_*1000


data.lerpbuy=lerpbuy
if canbuy>lerpbuy then
canbuy=lerpbuy
end
data.canbuy=canbuy
data.state=state
data.state_=state_
data.notfix=notfix
data.weight=weight
end

function UISubAct_duihuanhuodong_win:refreshShopView(isInit)
local c
if isInit then

local shopGoodList,notshowgoodList=self.sub_actInfo:GetShowList()
self.shopGoodList=shopGoodList
local _key=FMT.fmt('actid{0}_subtype{1}_subid{2}',self.actID,self.subType,self.subid)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eDuiHuanHuoDong,_key,notshowgoodList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eDuiHuanHuoDong)
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

function UISubAct_duihuanhuodong_win:refreshShopViewEx()
local c=#self.shopGoodList
if c>1 then
if c>1 then
table.sort(self.shopGoodList,function(a,b)
return a.weight>b.weight
end)
end
local grids=self.shopScrollerView:getChildScrollViewItemWidgets()
for i=1,c do
local item=grids[i-1]
self:refreshShopItem(item,i)
end
end
end

function UISubAct_duihuanhuodong_win:refreshShopItem(item,idx)
if item==nil then
item=self.shopScrollerView:getChildScrollViewItemWidget(idx-1)
end

local data=self.shopGoodList[idx]
local cfg=data.cfg
local state=data.state
local newflag=data.newflag and data.newflag or false
local cnt=0
local c

local buys=cfg[2]
c=#buys
cnt=cnt+c
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
item1:SetChildCSImageSprite(1,abName[imgType[self.windowType][2][1]],imgType[self.windowType][2][2])
end

local costs=cfg[1]
c=#costs
cnt=cnt+c
item:SetChildLayoutGroupCreateItems(3,c)
local grids2=item:GetChildLayoutGroupGridList(3)
for i=1,c do
local item2=grids2[i-1]
local d2=costs[i]
local itemid=d2[1]
local itemnum=d2[2]

local conf={itemid=itemid,itemcount='',showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item2:SetChildPropData(0,prop)
item2:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local countStr
local hasnum
if moneyConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
countStr=mathHelper.formatNumber(itemnum)
else
hasnum=bagModel.getNotExpireItemCountById(itemid)
countStr=FMT.fmt('{0}/{1}',mathHelper.formatNumber(hasnum),mathHelper.formatNumber(itemnum))
end
if hasnum<itemnum then
countStr=FMT.fmt('<color=#c82c2c>{0}</color>',countStr)
end
item2:SetChildText(1,countStr)
item2:SetChildCSImageSprite(2,abName[imgType[self.windowType][3][1]],imgType[self.windowType][3][2])
end
item:SetChildScrollRectEnable(1,cnt>=4)

item:SetChildActive(7,cfg[4]>0)

item:SetChildActive(8,state==0)
local showbtn=state~=0
item:SetChildActive(5,showbtn)
item:SetChildActive(4,showbtn)
if showbtn then
local limit_str=FMT.fmt('可兑换<color=#549327>{0}</color>次',data.lerpbuy)
item:SetChildText(4,limit_str)

item:SetChildImageExGray(5,state==1)

item:SetChildActive(6,state==2)

item:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onClickItemBuy(idx)
end)
end

item:SetChildActive(9,cfg[5]==1)
item:SetChildCSImageSprite(10,abName[imgType[self.windowType][1][1]],imgType[self.windowType][1][2])
item:SetChildActive(11,newflag)
end

function UISubAct_duihuanhuodong_win:refreshShopItemEx(item,idx)
if item==nil then
item=self.shopScrollerView:getChildScrollViewItemWidget(idx-1)
end

local data=self.shopGoodList[idx]
local cfg=data.cfg
local state=data.state
local c

local costs=cfg[1]
c=#costs
local grids2=item:GetChildLayoutGroupGridList(3)
for i=1,c do
local item2=grids2[i-1]
local d2=costs[i]
local itemid=d2[1]
local itemnum=d2[2]

local countStr
local hasnum
if moneyConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
countStr=mathHelper.formatNumber(itemnum)
else
hasnum=bagModel.getNotExpireItemCountById(itemid)
countStr=FMT.fmt('{0}/{1}',mathHelper.formatNumber(hasnum),mathHelper.formatNumber(itemnum))
end
if hasnum<itemnum then
countStr=FMT.fmt('<color=#c82c2c>{0}</color>',countStr)
end
item2:SetChildText(1,countStr)
end

item:SetChildActive(8,state==0)
local showbtn=state~=0
item:SetChildActive(5,showbtn)
item:SetChildActive(4,showbtn)
if showbtn then
local limit_str=FMT.fmt('可兑换<color=#549327>{0}</color>次',data.lerpbuy)
item:SetChildText(4,limit_str)

item:SetChildImageExGray(5,state==1)

item:SetChildActive(6,state==2)
end
end

function UISubAct_duihuanhuodong_win:onClickItemBuy(idx)
if not self.sub_actInfo:checkDoing()then
UIManager.error('活动已结束')
return
end
local data=self.shopGoodList[idx]
local state=data.state
if state<=0 then return end

if state==1 then
local notfix=data.notfix
UIManager.error('物品不足')
gainControl:showCommonGainWin_item(notfix[1])
return
end

local buyidx=data.buyidx
local canbuy=data.canbuy
local cfg=data.cfg
local callback=function(cnt)
if _this==nil then return end
local json_str=jsonHelper.encode({buyidx,cnt})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
if canbuy>1 then
local params={
title='批量兑换',
oktext='兑换',
canceltext='取消',
max=canbuy,
buyGoods=cfg[2],
costGoods=cfg[1],
okcallback=callback,
}
self:showWindow('UICommonUseItem_goods2goods_Win',params)
else
local params={
title='兑换',
oktext='兑换',
canceltext='取消',
max=1,
buyGoods=cfg[2],
costGoods=cfg[1],
okcallback=callback,
}
self:showWindow('UICommonUseItem_goods2goods_Win',params)
end
end

function UISubAct_duihuanhuodong_win:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UISubAct_duihuanhuodong_win:rec_refresh()
self:refreshShopView(true)
end

function UISubAct_duihuanhuodong_win:rec_Item(buyidxs)
local buyidxs_lp={}
for i,buyidx in ipairs(buyidxs)do
buyidxs_lp[buyidx]=0
end
for idx,data in ipairs(self.shopGoodList)do
if buyidxs_lp[data.buyidx]~=nil then
self:handelData(data)
self:refreshShopItemEx(nil,idx)
end
end
end

function UISubAct_duihuanhuodong_win:rec_buy(buyidx)
local idx,data
for i,d in ipairs(self.shopGoodList)do
if d.buyidx==buyidx then
idx=i
data=d
break
end
end
if idx then
local o_state_=data.state_
self:handelData(data)
local state_=data.state_
if state_==o_state_ then
self:refreshShopItemEx(nil,idx)
else
self:refreshShopViewEx()
end
end
end



function UISubAct_duihuanhuodong_win:refreshIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
local isForbiddenShowReddot=actInfo:checkIsForbiddenShowReddot()
self.isShowReddotBtn:setActive(not isForbiddenShowReddot)
if isForbiddenShowReddot then
return
end
local isShowReddot=actInfo:checkIsShowReddot()
local btnWidget=self.isShowReddotBtn:getWidgetBase()
btnWidget:SetChildActive(0,not isShowReddot)
btnWidget:SetChildActive(1,isShowReddot)
end

function UISubAct_duihuanhuodong_win:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_duihuanhuodong_win.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.actID==actId and _this.subType==subType and _this.subid==subId then
_this:refreshIsShowReddotBtn()
end
end
