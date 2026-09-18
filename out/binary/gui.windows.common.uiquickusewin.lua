







def_class("UIQuickUseWin",UIWindowBase)









function UIQuickUseWin:bindComponents()

self.root=UIObject.get(self,0)
self.useScrollView=UIObject.get(self,1)
self.oneKeyUse=UIButton.get(self,2)
self.emptyTips=UIText.get(self,3)
self.title=UIText.get(self,4)
self.panel=UIObject.get(self,5)
self.empty=UIObject.get(self,6)

self.oneKeyUse:setButtonClick(function()self:onOneKeyUse()end)



end


function UIQuickUseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.useScrollView);self.useScrollView=nil;
_UIObject_release(self.oneKeyUse);self.oneKeyUse=nil;
_UIObject_release(self.emptyTips);self.emptyTips=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.panel);self.panel=nil;
_UIObject_release(self.empty);self.empty=nil;
end
















local _this




function UIQuickUseWin:onLoaded(...)
self:bindComponents()

_this=self

notifySystem:listenNotify(notifyConfig.onItemUse,self.onItemUse)
notifySystem:listenNotify(notifyConfig.onItemUseInBatch,self.onItemUseInBatch)

notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
end


function UIQuickUseWin:__delete()
self:unbindComponents()

notifySystem:removelistener(notifyConfig.onItemUse,self.onItemUse)
notifySystem:removelistener(notifyConfig.onItemUseInBatch,self.onItemUseInBatch)

notifySystem:removelistener(notifyConfig.on_item_list_changed,self.onItemListChanged)
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChanged)

_this=nil
end

function UIQuickUseWin:refreshParentWin(utype,...)
UIManager:callAllWindowFunc('refreshAfterItemUse',utype,...)
end

function UIQuickUseWin.onItemUse(itemId,num)
_this:refreshParentWin(ITEM_USE_TYPE.eSigleUse,itemId,num)

end

function UIQuickUseWin.onItemUseInBatch(len,arr)
_this:refreshParentWin(ITEM_USE_TYPE.eMultipleUse,len,arr)


local list={}
for i,v in ipairs(arr)do
local cfg=itemsConfig.getConfig(v.param_1)
local ktype=cfg.gain[1]
local kCount=cfg.gain[2]
local val=list[ktype]or 0
list[ktype]=v.param_2*kCount+val
end

local tempRewardlist={}
for k,v in pairs(list)do
showPrizeControl.insertTemp(tempRewardlist,nil,k,v)
end
showPrizeControl.showWindow(tempRewardlist)
end




function UIQuickUseWin:onShow(argtable,afterOnloaded)
self.itemId=argtable.itemId
self.parentWin=argtable.parentWin
self.needCount=argtable.needCount or 1
local showBack=argtable.showBack
self.closeCB=argtable.closeBack
if showBack then
showBack(self)
end
self:initQuickUseItemListLookup()
self:refresh()
end


function UIQuickUseWin:onHide()

end

function UIQuickUseWin:initQuickUseItemListLookup()
local ccfg=itemsConfig.getConfig(self.itemId)
local useCfg=ccfg.quickUse or{}
self.quickUseItemList_lookup={}
for i,v in ipairs(useCfg)do
local itemId=v
self.quickUseItemList_lookup[itemId]=true
end
end

function UIQuickUseWin:refresh()
self:showItemList(self.itemId)
end

function UIQuickUseWin:getDatas(id)
local datas=zongmenControl:getQuickUseItems(id)
local list={}
local checkList_lookup={}
local itemCfg=itemsConfig.getConfig(id)
local sortWeightList={}
if itemCfg.quickUse then
for i,v in ipairs(itemCfg.quickUse)do
local itemId=v
sortWeightList[itemId]=i*-1000
end
end
for i,v in ipairs(datas)do
local cfg=itemsConfig.getConfig(v.itemid)
local sortWeight=sortWeightList[v.itemid]or-100000
table.insert(list,{data=v,color=cfg.color,id=cfg.id,sortWeight=sortWeight})
checkList_lookup[v.itemid]=true
end
table.sort(list,function(a,b)
if a.sortWeight==b.sortWeight then
if a.color>b.color then
return true
elseif a.color<b.color then
return false
else
return a.id>b.id
end
else
return a.sortWeight>b.sortWeight
end
end)
return list,checkList_lookup
end

function UIQuickUseWin:showItemList(id)
local datas,checkList_lookup=self:getDatas(id)
self.datas=datas
self.datasCheckList_lookup=checkList_lookup

local len=#datas

local isEmpty=len<=0

if isEmpty then
if self.closeCB then
self.closeCB()
end
self:closeSelf()
return
end

local ccfg=itemsConfig.getConfig(id)
local useCfg=ccfg.quickUse or{}

self.title:setText(useCfg.title or'')
self.empty:setActive(isEmpty)
self.panel:setActive(not isEmpty)

if isEmpty then
self.emptyTips:setText(useCfg.emptyDes or'')
return
end

self.empty:setActive(false)

self.useScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.useScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
local hasOneKeyUseItem=false
for i=1,count do
local item=grids[i-1]
local data=datas[i].data
local itemId=data.itemid
local itemCount=data.itemcount
widgetHelper.setNormalRewardItem(item,0,{itemId,itemCount,noClick=false})
local cfg=itemsConfig.getConfig(itemId)
item:SetChildText(1,cfg.name)
item:SetChildText(5,cfg.name)
local gain=cfg.gain
item:SetChildActive(1,gain~=nil)
item:SetChildActive(2,gain~=nil)
item:SetChildActive(4,gain~=nil)
item:SetChildActive(5,gain==nil)
if gain then
item:SetChildText(2,FMT.fmt('+{0}',mathHelper.formatNumber(gain[2])))
item:SetChildIcon(4,iconHelper.getIconName(gain[1]),true)
hasOneKeyUseItem=true
else
item:SetChildIcon(4,"",false)
end
item:SetChildButtonClick(3,function()

self:useItem(data)
end)
end

local limit=zongmenModel:getWarehouseLimit(id)
if not limit or limit<0 then

limit=moneyModel.getMoneyMax(id)
end

local showOnekey=useCfg.showOneKey and useCfg.showOneKey or 1
local isShowOnekeyBtn=hasOneKeyUseItem and showOnekey==1

if isShowOnekeyBtn and limit and limit>0 then
local have=moneyModel.getMoney(id)
isShowOnekeyBtn=have<limit
end
self.oneKeyUse:setActive(isShowOnekeyBtn)
end

function UIQuickUseWin:useItem(data)

self.useItemCheck_lookup={}
self.useItemCheck_lookup[data.itemid]=true
local itemCfg=itemsConfig.getConfig(data.itemid)

local showMult=function()
local selectNumCmpArgs=nil
local isShowBatchBody=true
if itemCfg.funcparam then
local ftype=itemCfg.funcparam.type

if ftype and BAG_ITEM_CAN_SHOW_BATCH_SPECIAL_FUN[ftype]then
local fun=BAG_ITEM_CAN_SHOW_BATCH_SPECIAL_FUN[ftype]
isShowBatchBody=fun(data.itemid,itemCfg.funcparam)
end
end
if isShowBatchBody then
local maxUseCount=data.itemcount
if itemCfg.gain then

local gainItemId=itemCfg.gain[1]
local gainItemCount=itemCfg.gain[2]
local gainItemCfg=itemsConfig.getConfig(gainItemId)
if gainItemCfg.max then
maxUseCount=math.floor(gainItemCfg.max/gainItemCount)
end
end
local canUseMaxCount=data.itemcount<maxUseCount and data.itemcount or maxUseCount
selectNumCmpArgs={numFormat='使用：<color=#f1ce78>{0}/{1}</color>',min=1,max=canUseMaxCount,val=1,}
end
tipsManager.showTips({formType=TIPS_FORM_TYPE.eQuickUse,
itemid=data.itemid,
itemguid=data.itemguid,
attach={selectNumCmpArgs=selectNumCmpArgs}})
end

local directUseMultBox=function()
local funcparam=itemCfg.funcparam
local canGetKindNum=funcparam.num
local canGetSingleNum=0
local selectIndex=0
for k,v in pairs(funcparam.itemList)do
if v[1]==self.itemId then
canGetSingleNum=v[2]
selectIndex=k
break
end
end

if canGetKindNum*canGetSingleNum==0 then

return showMult()
end
local hasNum=itemsModel.getCount(self.itemId)
local balanceNum=self.needCount-hasNum
local needUseNum=Mathf.Ceil(balanceNum/(canGetKindNum*canGetSingleNum))
local useNum=Mathf.Min(needUseNum,data.itemcount)
tipsBtnsFunc.boxSelect(data.itemguid,useNum,1,{{selectIndex,useNum}})
end













if itemCfg.funcparam.type==5 then
if data.itemcount<=1 then
local endTime_Short=bagUseControl.getItemExpireTime(data.itemguid)
if itemCfg.funcparam.expire and endTime_Short>0 then
local contentStr=itemCfg.funcparam.expireStr or FMT.fmt("获得的限时道具将会跟{0}的时限保持一致",itemCfg.name)
local timeText="(剩余时间：{0})"
local showdata=
{
type='UIDialougeItemExpireTimeUpdate',
title='提示',
content=contentStr,
oktext='确定',
allowclickBG=true,
okcallback=function(...)
bagProtocolControl.req_use_item_by_itemguid(data.itemguid,1)
end,
showclosebtn=true,
endTime=endTime_Short,
timeText=timeText,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
bagUseControl.useSingleItem(data.itemid,1)
end
else
showMult()
end
elseif itemCfg.funcparam.type==13 then
local hasNum=itemsModel.getCount(self.itemId)
if hasNum>=self.needCount then
showMult()
else
directUseMultBox()
end
end
end

function UIQuickUseWin.onItemChanged(changeType,_itemguid,lastitemid,lastcount,_itemcount)
local needRefresh=false
if _this.quickUseItemList_lookup and _this.quickUseItemList_lookup[lastitemid]then
needRefresh=true
elseif#_this.datas>0 then
for k,v in pairs(_this.datas)do
if v.data.itemid==lastitemid then
needRefresh=true
end
end
end
if needRefresh then
_this:refresh()
end
end

function UIQuickUseWin.onItemListChanged(argsTable)
local needRefresh=false
if _this.itemCountChange or _this.isUseListItem then

_this.itemCountChange=nil
_this.useItemCheck_lookup=nil
_this.isUseListItem=nil
return _this:refresh()
end

for i,v in ipairs(argsTable)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
local oldVal=v[4]
local newVal=v[5]
if newVal<oldVal and _this.useItemCheck_lookup and _this.useItemCheck_lookup[itemid]then
_this.isUseListItem=true
needRefresh=true
break
else
if itemid==_this.itemId then
needRefresh=true
break
elseif _this.quickUseItemList_lookup and _this.quickUseItemList_lookup[itemid]then
needRefresh=true
break
elseif#_this.datas>0 then
if _this.datasCheckList_lookup and _this.datasCheckList_lookup[itemid]then
needRefresh=true
break
end
end
end
end

_this.useItemCheck_lookup=nil
if needRefresh then
_this:refresh()
end
end

function UIQuickUseWin.onMoneyChanged(moneyType,oldVal,newVal)
_this.itemCountChange=nil
if moneyType==_this.itemId then
_this.itemCountChange=true
end
end



local _limitUseItemList={eMoneyType.mtDiGongXingDongLi}
function UIQuickUseWin:onOneKeyUse()
local list={}

self.useItemCheck_lookup={}
for i,v in ipairs(self.datas)do
local data=v.data
local itemId=data.itemid
local cfg=itemsConfig.getConfig(itemId)
local gain=cfg.gain
if gain then
table.insert(list,{data.itemid,data.itemcount})
self.useItemCheck_lookup[data.itemid]=true
end
end
local callback=function()
zongmenControl:checkAndUseMatItem(list,function(retlist)
bagProtocolControl.req_use_item_list(#retlist,retlist)
end)
end

if table.findValue(_limitUseItemList,self.itemId)then
local content="是否使用全部道具？"
if self.itemId==eMoneyType.mtDiGongXingDongLi then
content="是否使用全部行动令？"
end
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
allowclickBG=true,
showclosebtn=true,
okcallback=callback,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
callback()
end

end

function UIQuickUseWin:onCloseClisk()
self.parentWin:onCloseClick()
end