local classname='benMingFaBaoSheetReddot'

benMingFaBaoSheetReddot=reddotSheetBase.new({classname=classname,subType_=REDDIT_SUB_TYPE.sBenMingFabaoBase})

benMingFaBaoSheetReddot.reddot_type=REDDIT_TYPE.eBenMingFaBaoBase

benMingFaBaoSheetReddot.isDynamic=true

function benMingFaBaoSheetReddot:onAppStart()

end
function benMingFaBaoSheetReddot:onEnterState()
self:initConfig()
end
function benMingFaBaoSheetReddot:onLeaveState()
self:resetConfig()
end

function benMingFaBaoSheetReddot:initConfig()
if self.reddot_config==nil then
self:resetConfig()
self.reddot_config={}
reddotClassManager.init_class(self)
self:init_data()
end
end

function benMingFaBaoSheetReddot.addConfig(itemguid)
local class=reddotClassManager.get_class(REDDIT_TYPE.eBenMingFaBaoBase)
if class==nil then
class=reddotClassManager.get_class_by_name(classname)
class:initConfig()
end
local self=class
local handle=tostring(itemguid)
if self.guidList[handle]then
return self.guidList[handle].key
end
self.guid=self.guid+1
local guid=self.guid
local key=self:getSubReddotKey(guid)
self.guidList[handle]={key=key,itemguid=itemguid}
local subConfig={
catch={
CATCH_TYPE.eItem,
CATCH_TYPE.eMoneyInit,
CATCH_TYPE.eFaBaoLxExp,
},
func=function(catchType)
return benMingFaBaoHelper.canlxUp(itemguid)
end,
}
self.reddot_config[key]=subConfig
reddotClassManager.add_class_config(self,key,subConfig)
return key
end

function benMingFaBaoSheetReddot.getItemKey(itemguid)
local class=reddotClassManager.get_class(REDDIT_TYPE.eBenMingFaBaoBase)or
reddotClassManager.get_class_by_name(classname)
if class==nil then return end
local self=class
local handle=tostring(itemguid)
if self.guidList[handle]then
return self.guidList[handle].key
end
end

function benMingFaBaoSheetReddot.getKeyList()
local class=reddotClassManager.get_class(REDDIT_TYPE.eBenMingFaBaoBase)or
reddotClassManager.get_class_by_name(classname)
if class==nil then return end
local self=class
return self.guidList
end

function benMingFaBaoSheetReddot:resetConfig()

reddotClassManager.reset_class(self)
self.reddot_config=nil
self.guid=0
self.guidList={}
end
