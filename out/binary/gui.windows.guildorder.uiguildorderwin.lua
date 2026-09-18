







def_class("UIGuildOrderWin",UIWindowBase)









function UIGuildOrderWin:bindComponents()

self.root=UIObject.get(self,0)
self.orderScrollView=UIScrollView.get(self,1)



end


function UIGuildOrderWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.orderScrollView);self.orderScrollView=nil;
end
















local _this=nil
local pageWinList={
[1]="UICommonPageWin",
[2]="UICommonPageTwoWin",
[3]="UICommonPageThreeWin",
}
local specialfaling=
{
[10]=true,
}

local useOrderImmediately=
{
[GUILD_ORDER_TYPE.eAutoFireFighting]=true,
[GUILD_ORDER_TYPE.eAutoCaoLing]=true,
[GUILD_ORDER_TYPE.eAutoBaiShan]=true,
}


function UIGuildOrderWin:onLoaded(...)
_this=self
self:bindComponents()

self.orderScrollView:setClickAction(nil)
end


function UIGuildOrderWin:__delete()
_this=nil
self:unbindComponents()
end


function UIGuildOrderWin:onHide()

end




function UIGuildOrderWin:onShow(argtable,afterOnloaded)
local params=argtable.params
local orderID_
if params then
orderID_=params.orderID
end
self:refreshView()

if orderID_ then
local data,idx=self:findOrderItemData(orderID_)
if data~=nil then
self.orderScrollView:jumpToLockY(idx)
end
end
end

function UIGuildOrderWin:checkitemorder(orderID)
_this:refreshView()
if orderID then
local data,idx=_this:findOrderItemData(orderID)
if data~=nil then
_this.orderScrollView:jumpToLockY(idx)
end
end
end

function UIGuildOrderWin:handleOrderItemData(d)
local cfg=d.cfg
local orderID=cfg.id
local weight=100-orderID
local isActive=guildOrderModel:checkOrderActive(orderID)
d.isActive=isActive
if not isActive then
weight=weight+1000
local isFix=guildOrderModel:checkOrderCondEx(cfg.unlock)
d.isFix=isFix
if isFix then
weight=weight+10000
local isEnough=guildOrderModel:checkEnoughActive(cfg.cost)
d.isEnough=isEnough
if isEnough then
weight=weight+100000
end
end
end

if specialfaling[orderID]then
local reddot=guildOrderModel:checkAutoShengChanReddot()
if reddot then
weight=weight+1000000
end
end
d.weight=weight
end

function UIGuildOrderWin:findOrderItemData(orderID)
for idx,data in ipairs(self.dataList)do
if data.cfg.id==orderID then
return data,idx
end
end
return nil,nil
end

function UIGuildOrderWin:refreshView()
local list={}
local cfgs=cfg_guildorderconfig()
for i,cfg in pairs(cfgs)do
local issysopen=guildOrderModel:checkSystemCnd(cfg)
if issysopen then
local d={}
d.cfg=cfg
self:handleOrderItemData(d)
table.insert(list,d)
end
end
local c=#list
if c>1 then
table.sort(list,function(a,b)
return a.weight>b.weight
end)
end
self.dataList=list
self.orderScrollView:freshGridsNum(c,1,c,true)
for idx=1,c do
local item=self.orderScrollView:getGridObjectByindex(idx-1)
self:refreshOrderItem(item,idx)

item:SetChildButtonClick(7,function()
if _this==nil then return end
_this:onStudyBtn(idx)
end)

item:SetChildButtonClick(12,function()
if _this==nil then return end
_this:onSetupBtn(idx)
end)

item:SetChildButtonClick(13,function()
if _this==nil then return end
_this:onControllBtn(idx)
end)
end
end

function UIGuildOrderWin:refreshOrderItem(item,idx)
if item==nil then
item=self.orderScrollView:getGridObjectByindex(idx-1)
end

local data=self.dataList[idx]
local cfg=data.cfg
local orderID=cfg.id
local isActive=data.isActive
local isFix=data.isFix

local bgname
if not isActive and not isFix then
bgname='image_zmddfalingui_2'
else
bgname='image_zmddfalingui_1'
end
item:SetChildCSImageSprite(15,globalABLookup.guildordericons,bgname)

item:SetChildText(0,cfg.name)

local iconname=guildOrderModel.getIconName(cfg.icon)
item:SetChildCSImageSprite(1,globalABLookup.systemicons,iconname)

self:refreshItemDesc(item,idx)

item:SetChildActive(9,isActive)
item:SetChildActive(5,not isActive and isFix==true)
item:SetChildActive(3,not isActive and isFix==false)
if isActive then

local hasSetup=cfg.setupWin~=nil
if hasSetup then
item:SetChildText(10,cfg.desc2)
item:SetChildText(11,'')
else
item:SetChildText(11,cfg.desc2)
item:SetChildText(10,'')
end
item:SetChildActive(12,hasSetup)

self:refreshItemControllBtn(item,idx,orderID)

local setupReddot=guildOrderModel:checkSetupBtnReddot(orderID)
item:SetChildActive(17,setupReddot)
else
if isFix==true then


self:refreshItemStudyCost(item,idx)
else

self:refreshItemCond(item,idx)
end
end
end

function UIGuildOrderWin:refreshItemDesc(item,idx)
if item==nil then
item=self.orderScrollView:getGridObjectByindex(idx-1)
end

local data=self.dataList[idx]
local orderID=data.cfg.id
local isActive=data.isActive
local desc_str=guildOrderModel:getOrderDesc(orderID,isActive,true)
item:SetChildText(2,desc_str)
end

function UIGuildOrderWin:refreshItemControllBtn(item,idx,orderID)
if item==nil then
item=self.orderScrollView:getGridObjectByindex(idx-1)
end

local isSetupOpen=guildOrderModel:isOrderSetupOpen(orderID)
item:SetChildActive(14,not isSetupOpen)
item:SetChildActive(16,isSetupOpen)
end

function UIGuildOrderWin:refreshItemStudyCost(item,idx)
if item==nil then
item=self.orderScrollView:getGridObjectByindex(idx-1)
end

local data=self.dataList[idx]
local isActive=data.isActive
local isFix=data.isFix
if isActive or not isFix then return end

local isEnough=data.isEnough
local cost=data.cfg.cost
local c=#cost
item:SetChildLayoutGroupCreateItems(6,c)
local grids=item:GetChildLayoutGroupGridList(6)
for i=1,c do
local costItem=grids[i-1]
local itemid=cost[i][1]
local itemnum=cost[i][2]
local hasnum
local item_str
if itemsConfig.isMoney(itemid)then
hasnum=moneyModel.getMoney(itemid)
item_str=mathHelper.formatBIGNumbereEx(itemnum)
else
hasnum=bagModel.getItemCountById(itemid)
item_str=FMT.fmt('{0}/{1}',hasnum,itemnum)
end
if hasnum<itemnum then
item_str=toColorString(FONT_COLOR.eRedColor,item_str)
end
local grayNum=0
if hasnum<=0 then
grayNum=mathHelper.setbit(grayNum,eGrayType.eGray-1)
elseif hasnum<itemnum then
grayNum=mathHelper.setbit(grayNum,eGrayType.eMaskGray-1)
end
local conf={itemid=itemid,itemcount=item_str,showCountBG=true,showname=false,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
costItem:SetChildPropData(0,prop)
costItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end

local isReddot=not isActive and isFix==true and isEnough==true
item:SetChildActive(8,isReddot)
end

function UIGuildOrderWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end

function UIGuildOrderWin:refreshItemCond(item,idx)
if item==nil then
item=self.orderScrollView:getGridObjectByindex(idx-1)
end

local data=self.dataList[idx]
local unlock=data.cfg.unlock
local defaultVersionId=pfwindowslController:getGameVersion()
local pfid=loginModel:getPfid()
local unlock2=guildOrderModel:checkOrderPT(unlock,defaultVersionId,pfid)
local c=#unlock2
item:SetChildLayoutGroupCreateItems(4,c)
local grids=item:GetChildLayoutGroupGridList(4)
for i=1,c do
local condItem=grids[i-1]
local cond=unlock2[i]
local flag,cur,max=guildOrderModel:checkCond(cond)
local cond_str=guildOrderModel:getCondDesc(cond)
if flag then
cond_str=toColorString(FONT_COLOR.eGreenColor,cond_str)
else
cond_str=FMT.fmt('{0} ({1}/{2})',cond_str,cur,max)
end
condItem:SetChildText(1,cond_str)
condItem:SetChildToggle(0,flag)
end
end

function UIGuildOrderWin:onStudyBtn(idx)
local data=self.dataList[idx]
local cfg=data.cfg
local orderID=cfg.id
local isActive=guildOrderModel:checkOrderActive(orderID)
if data.isActive then return end

local isFix=guildOrderModel:checkOrderCondEx(cfg.unlock,true)
if not isFix then return end








moneySystem:useMoneys(cfg.cost,function()
guildOrderController:send_3_247(orderID)
end,WARNING_TYPE.eWarning)


end

function UIGuildOrderWin:onSetupBtn(idx)
local data=self.dataList[idx]
local orderID=data.cfg.id
local args={}
args.pos=3
args.showBG=true
guildOrderModel:openSetupWin(orderID,args)
end

function UIGuildOrderWin:onControllBtn(idx)
local data=self.dataList[idx]
local orderID=data.cfg.id
local setup=guildOrderModel:getSetupData(orderID)
setup.isOpen=not setup.isOpen
guildOrderModel:flushSetupData(orderID)
guildOrderModel:changeSetupOpen(orderID,setup.isOpen)
self:refreshItemControllBtn(nil,idx,orderID)
self:refreshItemDesc(nil,idx)

if specialfaling[orderID]then
local _setup=guildOrderModel:getSetupData(orderID)
if _setup.isOpen then
guildOrderController:handleAutoShengChan()
end
end
if useOrderImmediately[orderID]then
guildOrderController:checkAddAI(orderID,true)
end
end

function UIGuildOrderWin:onOrdersCondChange(orderList)
for i,orderID in ipairs(orderList)do
local data,idx=self:findOrderItemData(orderID)
if data~=nil then
self:handleOrderItemData(data)
self:refreshOrderItem(nil,idx)
end
end
end

function UIGuildOrderWin:onOrderCostChange(orderList)
for i,orderID in ipairs(orderList)do
local data,idx=self:findOrderItemData(orderID)
if data~=nil then
self:handleOrderItemData(data)
self:refreshItemStudyCost(nil,idx)
end
end
end

function UIGuildOrderWin:onOrderSetupChange(orderID)
local data,idx=self:findOrderItemData(orderID)
if data~=nil then
self:refreshItemDesc(nil,idx)
end
end



function UIGuildOrderWin:rec_active(orderID)
local data,idx=self:findOrderItemData(orderID)
if data~=nil then
self:handleOrderItemData(data)
self:refreshOrderItem(nil,idx)
end
end

function UIGuildOrderWin:rec_reddot(orderID)
local data,idx=self:findOrderItemData(orderID)
if data~=nil then
self:refreshOrderItem(nil,idx)
end
end



function UIGuildOrderWin:changeFaLingOpen(orderID)
if orderID==GUILD_ORDER_TYPE.eZongMenGenTi then
local setup,cfg=guildOrderModel:getSetupData(orderID)
local thisdaystate=setup.daystate
local isSetupOpen=guildOrderModel:isOrderSetupOpen(orderID)
if isSetupOpen then
buildlightController:setNature(false)
if thisdaystate[1]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DAY)
elseif thisdaystate[2]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DUSK)
elseif thisdaystate[3]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.NIGHT)
elseif thisdaystate[4]==1 then
buildlightController:setTiemState(BUILD_LIGHT_TYPE.DAWN)
end
buildlightController:ChangeBuildLight()
else
buildlightController:cleartimedata()
buildlightController:setNature(true)
end
end
end