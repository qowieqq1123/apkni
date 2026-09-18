







def_class("UISubAct_AnniversaryDuiHuanWin",UIWindowBase)









function UISubAct_AnniversaryDuiHuanWin:bindComponents()

self.boxModel=UIObject.get(self,0)
self.huzhuBtn=UIButton.get(self,1)
self.isShowReddotBtn=UIButton.get(self,2)
self.mbg=UIObject.get(self,3)
self.rankBg=UIImage.get(self,4)
self.rankBtn=UIButton.get(self,5)
self.rankPanel=UIObject.get(self,6)
self.shopScrollerView=UIObject.get(self,7)
self.timeTxt=UIText.get(self,8)
self.titieImg=UIImage.get(self,9)
self.wanfaBtn=UIButton.get(self,10)
self.xmJifen=UIText.get(self,11)
self.xmRank=UIText.get(self,12)

self.huzhuBtn:setButtonClick(function()self:onHuzhuBtn()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.wanfaBtn:setButtonClick(function()self:onWanfaBtn()end)



end


function UISubAct_AnniversaryDuiHuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.boxModel);self.boxModel=nil;
_UIObject_release(self.huzhuBtn);self.huzhuBtn=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.rankBg);self.rankBg=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rankPanel);self.rankPanel=nil;
_UIObject_release(self.shopScrollerView);self.shopScrollerView=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.titieImg);self.titieImg=nil;
_UIObject_release(self.wanfaBtn);self.wanfaBtn=nil;
_UIObject_release(self.xmJifen);self.xmJifen=nil;
_UIObject_release(self.xmRank);self.xmRank=nil;
end
















local _this




function UISubAct_AnniversaryDuiHuanWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
end


function UISubAct_AnniversaryDuiHuanWin:__delete()
_this=nil
self:unbindComponents()
if self.showMoney then
self.showMoney=nil
self:closeWindow('UITopMoneyWin4')
end
end


function UISubAct_AnniversaryDuiHuanWin:onHide()
if self.showMoney then
self.showMoney=nil
self:closeWindow('UITopMoneyWin4')
end
end




function UISubAct_AnniversaryDuiHuanWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.tab_idx=argtable.tab_idx

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self.score_name=self.sub_actcfg.score_name or"喜庆值"
self.rule_str=self.sub_actcfg.rule_str or"喜庆值"

self.useRank=self.sub_actcfg.use_rank==1

self.windowType=self.sub_actcfg.windowType or 1

if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
end
self:refreshActTime()
self:refreshShopView(true)
self:rec_myRank()

local moneytypes=self.sub_actcfg.moneytypes
self.showMoney=moneytypes~=nil
if self.showMoney then
self:showWindow('UITopMoneyWin2',{moneys=moneytypes,offsetX=75,offsetY=-40})
else
self:closeWindow('UITopMoneyWin2')
end

if afterOnloaded then
if self.sub_actcfg.showModel and self.sub_actcfg.showModel.bgModel then
local bgModel=self.sub_actcfg.showModel.bgModel
self.mbg:setChildUIModelShowTarget(bgModel[1],bgModel[2]or 1,{},0,false,false,0,nil)
if bgModel[3]then
self.mbg:setChildUIModelShowTargetOffset(bgModel[3],bgModel[4])
end
else
self.mbg:setChildUIModelShowTarget(6134,1,{},0,false,false,0,nil)
end
self.rankBg:setActive(false)
if self.sub_actcfg.showModel and self.sub_actcfg.showModel.otherModel then
local otherModel=self.sub_actcfg.showModel.otherModel
if otherModel[1]and otherModel[1]~=0 then
self.boxModel:setChildUIModelShowTarget(otherModel[1],otherModel[2]or 1,{},0,false,false,0,nil)
if otherModel[3]then
self.boxModel:setChildUIModelShowTargetOffset(otherModel[3],otherModel[4])
end
else
local _ab,icon=self.sub_actInfo:getIconFrame("image_qingdianlihe_juanzhoudi")
self.rankBg:setCSImageSprite(_ab,icon)
self.rankBg:setActive(true)
end
else
self.boxModel:setChildUIModelShowTarget(6135,1,{},0,false,false,0,nil)
end
if self.sub_actcfg.winParams and self.sub_actcfg.winParams.hideTitle then
self.titieImg:setActive(false)
else
local _ab,icon=self.sub_actInfo:getIconFrame("image_qingdianlihe_xttx")
self.titieImg:setCSImageSprite(_ab,icon)
self.titieImg:setActive(true)
end

local _ab,icon=self.sub_actInfo:getIconFrame("button_xiqingpaiming")
self.rankBtn:setCSImageSprite(_ab,icon)

local _ab2,icon2=self.sub_actInfo:getIconFrame("button_cailiaohuzhu")
self.huzhuBtn:setCSImageSprite(_ab2,icon2)
end
self:refreshIsShowReddotBtn()
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
end

function UISubAct_AnniversaryDuiHuanWin:refreshActTime()
local lerp=self.sub_actInfo:getEndLeftTime()
if lerp<0 then
lerp=0
end
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(lerp))
self.timeTxt:setText(time_str)
end

function UISubAct_AnniversaryDuiHuanWin:handelData(data)
local buyidx=data.buyidx
local maxbuy=data.cfg[3]
local curbuy=self.sub_actInfo:getGoodBuyNum(buyidx)
local lerpbuy=maxbuy-curbuy
if lerpbuy<0 then lerpbuy=0 end
local canbuy=0
local weight=#self.shopGoodList-buyidx
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

function UISubAct_AnniversaryDuiHuanWin:refreshShopView(isInit)
local c
if isInit then
self.shopGoodList=self.sub_actInfo:GetShowList()
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

function UISubAct_AnniversaryDuiHuanWin:refreshShopViewEx()
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

function UISubAct_AnniversaryDuiHuanWin:refreshShopItem(item,idx)
if item==nil then
item=self.shopScrollerView:getChildScrollViewItemWidget(idx-1)
end

local data=self.shopGoodList[idx]
local cfg=data.cfg
local state=data.state
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
countStr=mathHelper.formatNumber4(itemnum,1)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item1:SetChildPropData(0,prop)
item1:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
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
countStr=mathHelper.formatNumber4(itemnum,1)
else
hasnum=bagModel.getNotExpireItemCountById(itemid)
countStr=FMT.fmt('{0}/{1}',mathHelper.formatNumber4(hasnum,1),mathHelper.formatNumber4(itemnum,1))
end
if hasnum<itemnum then
countStr=FMT.fmt('<color=#c82c2c>{0}</color>',countStr)
end
item2:SetChildText(1,countStr)
end
item:SetChildScrollRectEnable(1,false)


item:SetChildActive(7,false)

item:SetChildActive(11,self.useRank)
if self.useRank then
item:SetChildText(11,FMT.fmt('{1}：<color=#549327>{0}</color>',cfg[4],self.score_name))
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

item:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onClickItemBuy(idx)
end)
end

item:SetChildActive(9,cfg[5]and cfg[5]==1)

local _ab3,icon3=self.sub_actInfo:getIconFrame("image_qingdianlihe_db1")
item:SetChildCSImageSprite(10,_ab3,icon3)
end

function UISubAct_AnniversaryDuiHuanWin:refreshShopItemEx(item,idx)
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
countStr=mathHelper.formatNumber4(itemnum,1)
else
hasnum=bagModel.getNotExpireItemCountById(itemid)
countStr=FMT.fmt('{0}/{1}',mathHelper.formatNumber4(hasnum,1),mathHelper.formatNumber4(itemnum,1))
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

function UISubAct_AnniversaryDuiHuanWin:onClickItemBuy(idx)
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
self.sub_actInfo:reqGetxchange(buyidx,cnt)
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
self:showWindow('UICommonUseItem_anniversaryDuiHuan_Win',params)
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
self:showWindow('UICommonUseItem_anniversaryDuiHuan_Win',params)
end
end

function UISubAct_AnniversaryDuiHuanWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UISubAct_AnniversaryDuiHuanWin:rec_refresh()
self:refreshShopView(true)
end

function UISubAct_AnniversaryDuiHuanWin:rec_Item(buyidxs)
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

function UISubAct_AnniversaryDuiHuanWin:rec_buy(buyidx)
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

function UISubAct_AnniversaryDuiHuanWin:rec_myRank()
self.rankPanel:setActive(self.useRank)
self.rankBtn:setActive(self.useRank)
if self.useRank then
local rankStrColor=self.sub_actcfg.winParams and self.sub_actcfg.winParams.rankStrColor
local hasXM=xianmengModel:hasXM()
if hasXM then
local m_rank=self.sub_actInfo:GetMyRank()
local m_score=self.sub_actInfo:GetMyScore()
if rankStrColor then
self.xmRank:setText(FMT.fmt("<color={1}>仙盟排名：</color><color={2}>{0}</color>",m_rank,rankStrColor[1],rankStrColor[2]))
self.xmJifen:setText(FMT.fmt("<color={2}>{0}：</color><color={3}>{1}</color>",self.score_name,m_score,rankStrColor[1],rankStrColor[2]))
else
self.xmRank:setText(string.format("仙盟排名：%d",m_rank))
self.xmJifen:setText(FMT.fmt("{0}：{1}",self.score_name,m_score))
end
else
if rankStrColor then
self.xmRank:setText(FMT.fmt("<color={0}>暂无仙盟</color>",rankStrColor[1]))
self.xmJifen:setText(FMT.fmt("<color={1}>无{0}</color>",self.score_name,rankStrColor[1]))
else
self.xmRank:setText("暂无仙盟")
self.xmJifen:setText(FMT.fmt("无{0}",self.score_name))
end
end
end
end





function UISubAct_AnniversaryDuiHuanWin:onHuzhuBtn()
local hasXM=xianmengModel:hasXM()
if not hasXM then
UIManager.error('请先加入仙盟')
return
end
local args={
act_id=self.actID,
sub_act_type=self.subType,
sub_act_id=self.subid,
}
self:showWindow("UISubAct_AnniversaryDuiHuan_HuHuanWin",args)
end



function UISubAct_AnniversaryDuiHuanWin:onRankBtn()
local hasXM=xianmengModel:hasXM()
if not hasXM then
UIManager.error('请先加入仙盟')
return
end
local args={
act_id=self.actID,
sub_act_type=self.subType,
sub_act_id=self.subid,
}
self:showWindow("UISubAct_AnniversaryDuiHuanRankWin",args)
end



function UISubAct_AnniversaryDuiHuanWin:onWanfaBtn()
local d={}
d.title='玩法介绍'
d.mode=3
d.name=self.rule_str and FMT.fmt("{0}_%d",self.rule_str)or'AnniversaryDuiHuan_help_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end




function UISubAct_AnniversaryDuiHuanWin:refreshIsShowReddotBtn()
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

function UISubAct_AnniversaryDuiHuanWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_AnniversaryDuiHuanWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.actID==actId and _this.subType==subType and _this.subid==subId then
_this:refreshIsShowReddotBtn()
end
end

