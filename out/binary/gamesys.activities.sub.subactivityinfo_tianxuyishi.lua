









local subActivityInfo_tianxuyishi={name='tianxuyishi'}

function subActivityInfo_tianxuyishi:onInit()













end

function subActivityInfo_tianxuyishi:onStart()






end

function subActivityInfo_tianxuyishi:on_money_changed(moneyType,lastVal,val)
if self.itemLookup then
local lp=self.itemLookup[moneyType]
local c=0
if lp then c=#lp end
if c>0 then
UIManager:invokeUIMethod('UISubAct_tianxuyishiWin','rec_Item',lp)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end
end

function subActivityInfo_tianxuyishi:on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if self.itemLookup then
local lp=self.itemLookup[itemid]
local c=0
if lp then c=#lp end
if c>0 then
UIManager:invokeUIMethod('UISubAct_tianxuyishiWin','rec_Item',lp)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.sub_act_type)
end
end
end

function subActivityInfo_tianxuyishi:onUpdate()

end

function subActivityInfo_tianxuyishi:onDelete()
self.itemLookup=nil
end

function subActivityInfo_tianxuyishi:checkReddot()
local data=self.data
if data then
local isShowReddotList={}
for i=1,2 do
isShowReddotList[i]=self:checkIsShowReddot(i)
end
local dhList=self:getSubActConfig('dhList')
for i,dhId in ipairs(dhList)do
local cfg=cfgHelper.get1(cfg_tianxuyishiduihuanconfig_get,dhId)
if isShowReddotList[cfg.etype]and self:checkGoodBuyReddot(dhId)then
return true
end
end
end
return false
end

function subActivityInfo_tianxuyishi:checkPageReddot(pageType)
local data=self.data
if data then
local dhList=self:getSubActConfig('dhList')
for i,dhId in ipairs(dhList)do
local cfg=cfgHelper.get1(cfg_tianxuyishiduihuanconfig_get,dhId)
if pageType==cfg.etype and self:checkGoodBuyReddot(dhId)then
return true
end
end
end
return false
end


function subActivityInfo_tianxuyishi:checkNewDay()
end

function subActivityInfo_tianxuyishi:getGoodBuyNum(dhId)
local data=self.data
if data then
local buyTimes=data.goodLookup[dhId]or 0
return buyTimes
end
return 0
end

function subActivityInfo_tianxuyishi:checkGoodBuyReddot(dhId)
local data=self.data
if data then
local buyTimes=data.goodLookup[dhId]or 0
local cfg=cfgHelper.get1(cfg_tianxuyishiduihuanconfig_get,dhId)
local dhMax=cfg.dhMax
if dhMax>=0 and buyTimes>=dhMax then
return false
end
local dhItem=cfg.dhItem
local dhType=dhItem[1]
local dhList=dhItem[2]
if dhType==1 then
local needItemId,needItemCount=dhList[1],dhList[2]
local hasnum=0
if moneyConfig.isMoney(needItemId)then
hasnum=moneyModel.getMoney(needItemId)
else
hasnum=bagModel.getNotExpireItemCountById(needItemId)
end
return hasnum>=needItemCount
elseif dhType==2 then
local needItemColor,needItemCount=dhList[1],dhList[2]
local hasnum=gubaoModel:getPieceCountByColor(needItemColor)
return hasnum>=needItemCount
elseif dhType==3 then

local needItemStage,needItemCount=dhList[1],dhList[2]
local filter={}
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,1}
filter[ITEM_FILTER_TYPE.eStage]={ITEM_FILTER_COMPARE.eEquals,{needItemStage}}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eMaterialsBag,filter,nil,false)
local hasnum=0
for _,item in pairs(items)do
hasnum=hasnum+bagModel.getNotExpireItemCountById(item.itemid)
end
return hasnum>=needItemCount
elseif dhType==4 then

local needItemColor,needItemIdList,needItemCount=dhList[1],dhList[2],dhList[3]
local filter={}
filter[ITEM_FILTER_TYPE.eItemid]={ITEM_FILTER_COMPARE.eEquals,needItemIdList}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eItemBag,filter,nil,false)
local hasnum=0
for _,item in ipairs(items)do
hasnum=hasnum+bagModel.getNotExpireItemCountById(item.itemid)
end
return hasnum>=needItemCount
end
end
return false
end

return subActivityInfo_tianxuyishi