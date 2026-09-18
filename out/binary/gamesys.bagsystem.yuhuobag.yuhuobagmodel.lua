

yuhuoBagModel=simple_class(baseBagModel)

yuhuoBagModel.bagType=BAG_TYPE.eYuHuo

function yuhuoBagModel:onAppStart()

end

function yuhuoBagModel:onEnterState()
self:init()

self.yuhuoData={}
self.countDataDirty=true
end

function yuhuoBagModel:onLeaveState()
self:init()

self.yuhuoData=nil
end

function yuhuoBagModel:onAddItem(data,isInit)
yuhuoBagModel._base.onAddItem(self,data,isInit)
self.countDataDirty=true
end

function yuhuoBagModel:onDeleteItem(data)
yuhuoBagModel._base.onDeleteItem(self,data)
self.countDataDirty=true
end

function yuhuoBagModel:onChangeItem(data)
yuhuoBagModel._base.onChangeItem(self,data)
self.countDataDirty=true
end

function yuhuoBagModel:getItemCountData()
if self.countDataDirty then
local items=self:getBagItems()
local list={}
local olist={}
for i,v in ipairs(items)do
local cfg=itemsConfig.getConfig(v.itemid)
local tc=list[cfg.type1]or 0
tc=tc+1
list[cfg.type1]=tc
if UIAquariumControl:isOrnamentalFish(v)then
tc=olist[cfg.type1]or 0
tc=tc+1
olist[cfg.type1]=tc
end
end
self.yuhuoData.typeCountData=list
self.yuhuoData.ornamentalTypeCountData=olist
self.countDataDirty=false
end
return self.yuhuoData
end

function yuhuoBagModel:chackHaveTypeItem(ftype)
local datas=self:getItemCountData()
local count=datas.typeCountData[ftype]or 0
return count>0
end

function yuhuoBagModel:chackHaveOrnamentalTypeItem(ftype)
local datas=self:getItemCountData()
local count=datas.ornamentalTypeCountData[ftype]or 0
return count>0
end