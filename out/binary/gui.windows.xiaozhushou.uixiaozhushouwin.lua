







def_class("UIXiaoZhuShouWin",UIWindowBase)









function UIXiaoZhuShouWin:bindComponents()

self.backBtn=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.detailContent=UIObject.get(self,2)
self.detailCreater=UIGameobjectClone.new(self,3)
self.detailPanel=UIObject.get(self,4)
self.dogModel=UIObject.get(self,5)
self.lock=UIObject.get(self,6)
self.mainPanel=UIObject.get(self,7)
self.mask=UIButton.get(self,8)
self.okBtn=UIButton.get(self,9)
self.orderItem=UIObject.get(self,10)
self.orderScrollView=UIScrollView.get(self,11)
self.pauseBtn=UIButton.get(self,12)
self.reportBtn=UIButton.get(self,13)
self.reportReddot=UIObject.get(self,14)
self.root=UIObject.get(self,15)
self.setupPanel=UIObject.get(self,16)
self.startBtn=UIButton.get(self,17)
self.sureBtn=UIButton.get(self,18)
self.unlockBtn=UIButton.get(self,19)
self.shouyiPanel=UIObject.get(self,20)
self.shouyiScrollView=UILoopListView.new(self,21)
self.sySureBtn=UIButton.get(self,22)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.okBtn:setButtonClick(function()self:onOkBtn()end)

self.pauseBtn:setButtonClick(function()self:onPauseBtn()end)

self.reportBtn:setButtonClick(function()self:onReportBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)

self.sureBtn:setButtonClick(function()self:onSureBtn()end)

self.unlockBtn:setButtonClick(function()self:onUnlockBtn()end)

self.shouyiScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.sySureBtn:setButtonClick(function()self:onSySureBtn()end)



end


function UIXiaoZhuShouWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.detailContent);self.detailContent=nil;
self.detailCreater:deleteSelf();self.detailCreater=nil;
_UIObject_release(self.detailPanel);self.detailPanel=nil;
_UIObject_release(self.dogModel);self.dogModel=nil;
_UIObject_release(self.lock);self.lock=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.okBtn);self.okBtn=nil;
_UIObject_release(self.orderItem);self.orderItem=nil;
_UIObject_release(self.orderScrollView);self.orderScrollView=nil;
_UIObject_release(self.pauseBtn);self.pauseBtn=nil;
_UIObject_release(self.reportBtn);self.reportBtn=nil;
_UIObject_release(self.reportReddot);self.reportReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.setupPanel);self.setupPanel=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
_UIObject_release(self.sureBtn);self.sureBtn=nil;
_UIObject_release(self.unlockBtn);self.unlockBtn=nil;
_UIObject_release(self.shouyiPanel);self.shouyiPanel=nil;
self.shouyiScrollView:deleteSelf();self.shouyiScrollView=nil;
_UIObject_release(self.sySureBtn);self.sySureBtn=nil;
end


















local _this=nil
local dogAnims={{3085,false},{3086,false}}

local ItemType={
eEmptyItem=1,
eMoneyListItem=2,
eItemListItem=3,
}

local ItemName={
[ItemType.eEmptyItem]="emptyItem",
[ItemType.eMoneyListItem]="moneyListitem",
[ItemType.eItemListItem]="itemListitem",
}

function UIXiaoZhuShouWin:onLoaded(...)
self:bindComponents()
_this=self
self.orderScrollView:setClickAction(nil)
self.detailCreater:setRefreshAction(function(...)self:onFinishCreate(...)end)
self.detailIdx=0

self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
end


function UIXiaoZhuShouWin:__delete()
self:unbindComponents()
_this=nil
xiaoZhuShouModel:flushSetupData()
xiaoZhuShouModel:clearDetailData()
xiaoZhuShouController:clearPrizeList()
end




function UIXiaoZhuShouWin:onShow(argtable,afterOnloaded)
self.shouyiPanel:setActive(false)
self:refreshView()
local anim=table.randomIndex(dogAnims)
self.dogModel:setChildUIModelShowTarget(5765,1,{},anim[1])
self.dogModel:setChildUIModelShowFlipX(anim[2])
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
local isUnlock=xiaoZhuShouController:checkXiaoZhuShouOpen()
self.lock:setActive(not isUnlock)
if isUnlock then
xiaoZhuShouModel:setOrderNewFlag()
local dft_unlock=xiaoZhuShouModel:checkSetupUnlock(XIAOZHUSHU_ENUM.xzs_DouFaTai)
if dft_unlock then
if newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.XiaoZhuShouLuaFunc)then
local idx=self.idxLookup[XIAOZHUSHU_ENUM.xzs_DouFaTai]
if idx then
self.orderScrollView:jumpToLockY(idx)
end
end
end
end
self:refreshReportReddot()
end

function UIXiaoZhuShouWin:refreshReportReddot()
local reportReddot=xiaoZhuShouModel:checkReportReddot()
self.reportReddot:setActive(reportReddot)
if reportReddot then
if self.reddotTweener==nil then
self.reportReddot:setRotation(0,0,0)
local tweener=self.reportReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.reportReddot:setRotation(0,0,0)
end
end
end

function UIXiaoZhuShouWin:refreshView()
local list={}
local cfgs=cfg_xiaozhushouconfig()
for orderID,cfg in ipairs(cfgs)do
local unlock=xiaoZhuShouModel:checkShowUnlock(orderID)
if unlock then
local d={}
d.cfg=cfg
self:handleOrderItemData(d)
table.insert(list,d)
end
end
local c=#list
if c>1 then
table.sort(list,function(a,b)
return a.weight<b.weight
end)
end
self.dataList=list
self.idxLookup={}
self.catchItem={}
self.orderScrollView:freshGridsNum(c,1,c,true)
for idx=1,c do
local data=self.dataList[idx]
local cfg=data.cfg
local orderID=cfg.id
self.idxLookup[orderID]=idx

local item=self.orderScrollView:getGridObjectByindex(idx-1)
self:refreshOrderItem(item,idx)
end
end

function UIXiaoZhuShouWin:openSetupWin(orderID)
local idx=self.idxLookup[orderID]
local data=self.dataList[idx]
local cfg=data.cfg
self:onClickSetupBtn(idx,cfg)
end

function UIXiaoZhuShouWin:handleOrderItemData(d)
local cfg=d.cfg
local orderID=cfg.id
local weight=0
local unlock=xiaoZhuShouModel:checkSetupUnlock(orderID)
if not unlock then
weight=weight+1000000
elseif xiaoZhuShouModel:checkOrderNewFlag(orderID)then
weight=weight-10000
end
weight=weight+cfg.sortVal
d.weight=weight
end

function UIXiaoZhuShouWin:refreshOrderItem(item,idx)
if item==nil then
item=self.orderScrollView:getGridObjectByindex(idx-1)
end
local data=self.dataList[idx]
local cfg=data.cfg
local orderID=cfg.id
local setupData=xiaoZhuShouModel:getSetupData(orderID)


item:SetChildCSImageSprite(0,"ui/windows/xiaozhushou/xzsicon_pak.ab",string.format("image_zsjztp_%d",cfg.icon))

item:SetChildText(1,cfg.name)

local setupCfg=xiaoZhuShouModel:getSetupConfig(orderID)
local toggleGroup
if setupCfg.getShowToggleGroup then
toggleGroup=setupCfg.getShowToggleGroup(orderID)
else
toggleGroup=cfg.toggleGroup
end

local c=#toggleGroup
item:SetChildLayoutGroupCreateItems(2,c)
local unlock,tips=xiaoZhuShouModel:checkSetupUnlock(orderID)
local grids=item:GetChildLayoutGroupGridList(2)
for i=1,c do
local toggleItem=grids[i-1]
local keyId=toggleGroup[i][1]
local name=toggleGroup[i][2]
local isOpen=setupData[keyId]==1
toggleItem:SetChildToggleChange(0,nil)
toggleItem:SetChildToggle(0,isOpen and unlock)
toggleItem:SetChildToggleChange(0,function(name,isOn)
local setupCfg=xiaoZhuShouModel:getSetupConfig(orderID)
if isOn and setupCfg.checkToggle then
if setupCfg.checkToggle(orderID,keyId)then
setupData[keyId]=isOn and 1 or 0
xiaoZhuShouModel:flushSetupData()
else
toggleItem:SetChildToggle(0,not isOn)
end
else
setupData[keyId]=isOn and 1 or 0
xiaoZhuShouModel:flushSetupData()
end
end)
toggleItem:SetChildText(1,name)
end

item:SetChildText(3,cfg.desc)

local showItemList=cfg.showItemList
if showItemList then
item:SetChildActive(4,true)
local c=#showItemList
item:SetChildLayoutGroupCreateItems(4,c)
local grids=item:GetChildLayoutGroupGridList(4)
for i=1,c do
local costItem=grids[i-1]
local itemid=showItemList[i]
local itemnum=itemsModel.getCount(itemid)
local conf={itemid=itemid,itemcount=tostring(itemnum),showCountBG=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
costItem:SetChildPropData(0,prop)
costItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
costItem:SetChildText(1,itemsConfig.getItemName(itemid))

self.catchItem[tostring(itemid)]=costItem
end
else
item:SetChildActive(4,false)
end

if cfg.setupWin and unlock then
item:SetChildActive(5,true)
local btnTxt=cfg.setupWin[2]
item:SetChildButtonClick(5,function()
if _this==nil then return end
_this:onClickSetupBtn(idx,cfg)
end)
item:SetChildText(6,btnTxt)

item:SetChildNewBieComponentId(5,'UIXiaoZhuShouWin.SetupBtn'..orderID)
else
item:SetChildActive(5,false)
end

local new=xiaoZhuShouModel:checkOrderNewFlag(orderID)
item:SetChildActive(7,new)

item:SetChildActive(8,not unlock)

if not unlock then
item:SetChildText(9,tips or"")
end
end

function UIXiaoZhuShouWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end

function UIXiaoZhuShouWin:onClickSetupBtn(idx,cfg)
local orderID=cfg.id
self.selectOrderID=orderID
local setupData=xiaoZhuShouModel:getSetupData(orderID)
local item=self.orderItem:getWidgetBase()

item:SetChildCSImageSprite(0,"ui/windows/xiaozhushou/xzsicon_pak.ab",string.format("image_zsjztp_%d",cfg.icon))

item:SetChildText(1,cfg.name)

local setupCfg=xiaoZhuShouModel:getSetupConfig(orderID)
local toggleGroup
if setupCfg.getShowToggleGroup then
toggleGroup=setupCfg.getShowToggleGroup(orderID)
else
toggleGroup=cfg.toggleGroup
end

local c=#toggleGroup
item:SetChildLayoutGroupCreateItems(2,c)
local grids=item:GetChildLayoutGroupGridList(2)
for i=1,c do
local toggleItem=grids[i-1]
local keyId=toggleGroup[i][1]
local name=toggleGroup[i][2]
local isOpen=setupData[keyId]==1
toggleItem:SetChildToggleChange(0,nil)
toggleItem:SetChildToggle(0,isOpen)
toggleItem:SetChildToggleChange(0,function(name,isOn)
local setupCfg=xiaoZhuShouModel:getSetupConfig(orderID)
if isOn and setupCfg.checkToggle then
if setupCfg.checkToggle(orderID,keyId)then
setupData[keyId]=isOn and 1 or 0
xiaoZhuShouModel:flushSetupData()
else
toggleItem:SetChildToggle(0,not isOn)
end
else
setupData[keyId]=isOn and 1 or 0
xiaoZhuShouModel:flushSetupData()
end
self:refreshOrderItem(nil,idx)
end)
toggleItem:SetChildText(1,name)
end

item:SetChildText(3,cfg.desc)

local new=xiaoZhuShouModel:checkOrderNewFlag(orderID)
item:SetChildActive(4,new)

self:showWindow(cfg.setupWin[1])
self.mainPanel:setActive(false)
self.setupPanel:setActive(true)
end

function UIXiaoZhuShouWin.on_item_list_changed(array)
if not _this or _this.isClose or not _this.catchItem then return end
for k,itemdata in ipairs(array or{})do
local itemid=itemdata[3]
local costItem=_this.catchItem[tostring(itemid)]
if costItem then
local itemnum=itemsModel.getCount(itemid)
costItem:SetChildItemData(0,PropIndex(DataPropKey.eWidgetText,3),tostring(itemnum))
end
end
end

function UIXiaoZhuShouWin:createDetail(detailId,args)
local detailCfg=cfg_xiaozhushoudetailconfig_get(detailId)
local order=args.endFlag and self.detailIdx+1 or self.detailIdx
local luaid=self.detailCreater:createObject(detailCfg.obj,self.detailContent:getID(),order,args)
xiaoZhuShouModel:bindDetailLuaId(detailId,luaid)
end

function UIXiaoZhuShouWin:callDetailFunc(luaid,func,...)
self.detailCreater:callChildFunc(luaid,func,...)
end


function UIXiaoZhuShouWin:onFinishCreate(assetName,guid,luaid)
self.detailIdx=self.detailIdx+1
local height=self.detailContent:getChildRectHeight()
local contentY=self.detailContent:getChildAnchoredPosition().y
if contentY<height then

self.detailContent:setChildDOAnchorPosY(height,0.3)
end
self.detailCreater:callChildFunc(luaid,'onCreatedFinish')
end


function UIXiaoZhuShouWin:checkShouYi()

local prizeList=xiaoZhuShouController:getPrizeList()
if not prizeList then
return
end

local moneyList={}
local itmeList={}
local list={}
local prefabnameList={}

for i,itemData in ipairs(prizeList)do
local itemId=itemData.itemid
local itemNum=itemData.num
local itemGuid=itemData.itemguid
if itemsConfig.isMoney(itemId)then
table.insert(moneyList,itemData)
else
table.insert(itmeList,itemData)
end
end

if#moneyList>0 then
local col=3
local row=math.ceil(#moneyList/col)
for _r=1,row do
local temp={}
temp.itemType=ItemType.eMoneyListItem
table.insert(prefabnameList,ItemName[ItemType.eMoneyListItem])
local moneyDataList={}
for _c=1,col do
local index=(_r-1)*col+_c
local itemData=moneyList[index]
if itemData then
table.insert(moneyDataList,itemData)
end
end
temp.moneyDataList=moneyDataList
table.insert(list,temp)
end
end

if#itmeList>0 then
table.sort(itmeList,function(a,b)
local aColor=itemsConfig.getItemColor(a.itemid)
local bColor=itemsConfig.getItemColor(b.itemid)
return aColor>bColor
end)
local col=9
local row=math.ceil(#itmeList/col)
for _r=1,row do
local temp={}
temp.itemType=ItemType.eItemListItem
table.insert(prefabnameList,ItemName[ItemType.eItemListItem])
local itemDataList={}
for _c=1,col do
local index=(_r-1)*col+_c
local itemData=itmeList[index]
if itemData then
table.insert(itemDataList,itemData)
end
end
temp.itemDataList=itemDataList
table.insert(list,temp)
end
end

if#list>0 then
self.shouyiPanel:setActive(true)
self.detailPanel:setActive(false)

table.insert(prefabnameList,1,ItemName[ItemType.eEmptyItem])
table.insert(list,1,{itemType=ItemType.eEmptyItem})
self.shouyiScrollView:initDataEx(prefabnameList,list)
else
self.shouyiPanel:setActive(false)
self.detailPanel:setActive(true)
self.shouyiScrollView:initData(nil,nil,0)
end
end

function UIXiaoZhuShouWin:onFreshAction(index,widget,data)
local itemType=data.itemType
if itemType==ItemType.eEmptyItem then
elseif itemType==ItemType.eMoneyListItem then
local moneyDataList=data.moneyDataList
widget:SetChildLayoutGroupCreateItems(0,#moneyDataList,function(index)
local moneyItem=widget:GetChildLayoutGroupGridItem(0,index-1)
local itemData=moneyDataList[index]
local itemId=itemData.itemid
local itemNum=itemData.num
local iconname=iconHelper.getIconName(itemId)
moneyItem:SetChildIcon(0,iconname,false)
moneyItem:SetChildText(1,mathHelper.formatNumber(itemNum))
end)
elseif itemType==ItemType.eItemListItem then
local itemDataList=data.itemDataList
widget:SetChildLayoutGroupCreateItems(0,#itemDataList,function(index)
local item=widget:GetChildLayoutGroupGridItem(0,index-1)
local itemData=itemDataList[index]
local itemId=itemData.itemid
local itemNum=itemData.num
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""


local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{showname=false,itemcount=countStr,showCountBG=showCountBG,showStageBg=true})
item:SetChildPropData(-1,fillData)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
end
end

function UIXiaoZhuShouWin:onStartAction()

end

function UIXiaoZhuShouWin:onStartBtn()
local func=function()
self.detailIdx=0
self.detailCreater:recycleAll()
xiaoZhuShouController:startAllOrder()
end
if xiaoZhuShouModel:checkReportReddot()then
local show_data={
type='UIDialouge',
title='提示',
content="执事汇报中仍有事项未处理，是否继续开始宗门执事？",
oktext='开始执事',
canceltext='查看汇报',
okcallback=function()
func()
end,
cancelcallback=function()
xiaoZhuShouController:openReportWin()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
func()
end
end

function UIXiaoZhuShouWin:showDetailPanel()
self.mainPanel:setActive(false)
self.detailPanel:setActive(true)
self.pauseBtn:setActive(true)
end

function UIXiaoZhuShouWin:refreshPauseBtn(flag)
self.pauseBtn:setActive(flag)
end

function UIXiaoZhuShouWin:onOkBtn()
local orderID=self.selectOrderID
local setupCfg=xiaoZhuShouModel:getSetupConfig(orderID)
if setupCfg.checkSetup then
setupCfg.checkSetup(self)
else
self:saveSetup()
end
end

function UIXiaoZhuShouWin:saveSetup()
_this:closeAllWindow()
_this.mainPanel:setActive(true)
_this.setupPanel:setActive(false)
xiaoZhuShouModel:flushSetupData()
end

function UIXiaoZhuShouWin:onBackBtn()
local orderID=self.selectOrderID
local setupCfg=xiaoZhuShouModel:getSetupConfig(orderID)
if setupCfg.checkSetup then
setupCfg.checkSetup(self)
else
self:saveSetup()
end
end

function UIXiaoZhuShouWin:onSureBtn()
if xiaoZhuShouController:checkRunning()then
UIManager.info("小助手执行中")
return
end
self:closeSelf()
end

function UIXiaoZhuShouWin:backMainPanel()
if xiaoZhuShouController:checkRunning()then
UIManager.info("小助手执行中")
return
end
self.mainPanel:setActive(true)
self.detailPanel:setActive(false)
self.detailCreater:recycleAll()
end

function UIXiaoZhuShouWin:onPauseBtn()
if xiaoZhuShouController:checkRunning()then
xiaoZhuShouController:stopRunning()
UIManager.info("宗门执事已停止")
self.pauseBtn:setActive(false)
end
end

function UIXiaoZhuShouWin:onCloseBtn()
if xiaoZhuShouController:checkRunning()then
UIManager.info("小助手执行中")
return
end
self:closeSelf()
end

function UIXiaoZhuShouWin:onMask()
if xiaoZhuShouController:checkRunning()then
UIManager.info("小助手执行中")
return
end
self:closeSelf()
end

function UIXiaoZhuShouWin:onUnlockBtn()
UIFullRechargeController:showMonthInvestorWin()
self:closeSelf()
end

function UIXiaoZhuShouWin:onReportBtn()
xiaoZhuShouController:openReportWin()
end

function UIXiaoZhuShouWin:onSySureBtn()
xiaoZhuShouController:clearPrizeList()
self:closeSelf()
end

