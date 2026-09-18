






zhenfaSheetReddot=reddotSheetBase.new({classname='zhenfaSheetReddot',subType_=REDDIT_SUB_TYPE.sZhenFa})

zhenfaSheetReddot.reddot_type=REDDIT_TYPE.eZhenFa
















zhenfaSheetReddot.isDynamic=true

function zhenfaSheetReddot:onAppStart()

end

function zhenfaSheetReddot:onEnterState()
self:resetConfig()
self:initConfig()
end

function zhenfaSheetReddot:onLeaveState()
self:resetConfig()
end

function zhenfaSheetReddot:initConfig()



if self.reddot_config==nil then
self.reddot_config={}

reddotClassManager.init_class(self)

self:init_data()
end
end

function zhenfaSheetReddot.addConfig(ubdId)
local class=reddotClassManager.get_class(REDDIT_TYPE.eZhenFa)
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
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eZhenFa,
},
func=function(catchType)
local ubdData=zongmenModel:getBuildingData(ubdId)
return zhenfaModel:isBuilding_CanActive(ubdData)
end,
}
self.reddot_config[key]=subConfig
reddotClassManager.add_class_config(self,key,subConfig)
return key
end

function zhenfaSheetReddot:resetConfig()

reddotClassManager.reset_class(self)
self.reddot_config=nil
self.guid=0
self.guidList={}
end
