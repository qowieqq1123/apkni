







def_class("UISubAct_ChaosLingChiRecord2Win",UIWindowBase)








function UISubAct_ChaosLingChiRecord2Win:bindComponents()

self.notRecord=UIObject.get(self,0)
self.scrollerView=UILoopListView.new(self,1)

self.scrollerView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UISubAct_ChaosLingChiRecord2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.notRecord);self.notRecord=nil;
self.scrollerView:deleteSelf();self.scrollerView=nil;
end

















local item_index=
{
item=0,
itemName=1,
time=2,
name=3,
}

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemBgCountIdx=2,
cmpItemTxtCountIdx=3,
}


function UISubAct_ChaosLingChiRecord2Win:onLoaded(...)
self:bindComponents()
self.scrollerView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UISubAct_ChaosLingChiRecord2Win:__delete()
self:unbindComponents()
end




function UISubAct_ChaosLingChiRecord2Win:onShow(argtable,afterOnloaded)
local activityId=argtable.activityId
local subType=argtable.subType
local subId=argtable.subId
self:refreshPanel(activityId,subType,subId)
end


function UISubAct_ChaosLingChiRecord2Win:onHide()

end

function UISubAct_ChaosLingChiRecord2Win:refreshPanel(activityId,subType,subId)
self.activityId=activityId
self.subType=subType
self.subId=subId

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end

self.recordData=table.weakCopy(self.activityData.data.recordList or{})
table.sort(self.recordData,
function(a,b)
return a.get_time>b.get_time
end
)
self.scrollerView:setActive(#self.recordData>0)
self.notRecord:setActive(#self.recordData<=0)

if#self.recordData>0 then
local _slotName='recordItem'
self.scrollerView:initData(_slotName,self.recordData)
end
end

function UISubAct_ChaosLingChiRecord2Win:onFreshAction(i,item)
local record=self.recordData[i]
item:SetChildActive(-1,true)

item:SetChildText(item_index.name,record.actor_name)

item:SetBaseItemClickEvent(item_index.item,function(...)self:onItemClick(...)end)
local prop={}
local itemid=record.item_id
local itemCount=record.item_num
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,_itemWidgetIdx.cmpItemIconIdx)]=iconHelper.getIconName(itemid)
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemBgCountIdx)]=itemCount>1
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCountIdx)]=itemCount>1 and itemCount or""
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=-1
item:SetChildPropData(item_index.item,prop)
item:SetChildText(item_index.itemName,itemConfig.name)
end

function UISubAct_ChaosLingChiRecord2Win:onStartAction()

end

function UISubAct_ChaosLingChiRecord2Win:onItemClick(id,index,guid,attach)
itemsComponentHelper.onItemClick(id,index,guid,attach)
end

function UISubAct_ChaosLingChiRecord2Win:onCloseBtn()
UIManager:closeWindow(self.winlua.name)
end


