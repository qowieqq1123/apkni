
shopProductionSheetReddot=reddotSheetBase.new({classname='shopProductionSheetReddot',subType_=REDDIT_SUB_TYPE.sShopCreate})

shopProductionSheetReddot.reddot_type=REDDIT_TYPE.eShop

shopProductionSheetReddot.isDynamic=true

function shopProductionSheetReddot:onAppStart()

end

function shopProductionSheetReddot:onEnterState()
self:resetConfig()
self:initConfig()
end

function shopProductionSheetReddot:onLeaveState()
self:resetConfig()
end

function shopProductionSheetReddot:initConfig()

if self.reddot_config==nil then
self.reddot_config={}

reddotClassManager.init_class(self)

self:init_data()
end
end

function shopProductionSheetReddot.addConfig(ubdId)
local class=reddotClassManager.get_class(REDDIT_TYPE.eShop)
local self=class
if self.guidList[ubdId]then
return self.guidList[ubdId]
end
self.guid=self.guid+1
local guid=self.guid
local key=self:getSubReddotKey(guid)
self.guidList[ubdId]=key
local subConfig={
catch={
CATCH_TYPE.eShopCreate,
},
func=function(catchType)
local ubdData=zongmenModel:getBuildingData(ubdId)
return UIShopControl:checkReddot(ubdData)
end,
}
self.reddot_config[key]=subConfig
reddotClassManager.add_class_config(self,key,subConfig)
return key
end

function shopProductionSheetReddot:resetConfig()

reddotClassManager.reset_class(self)
self.reddot_config=nil
self.guid=0
self.guidList={}
end
