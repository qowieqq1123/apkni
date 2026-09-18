
fabaoCreateSheetReddot=reddotSheetBase.new({classname='fabaoCreateSheetReddot',subType_=REDDIT_SUB_TYPE.sFaBaoCreate})

fabaoCreateSheetReddot.reddot_type=REDDIT_TYPE.eFaBaoCreateBase

fabaoCreateSheetReddot.isDynamic=true

function fabaoCreateSheetReddot:onAppStart()

end
function fabaoCreateSheetReddot:onEnterState()
self:resetConfig()
self:initConfig()
end
function fabaoCreateSheetReddot:onLeaveState()
self:resetConfig()
end


function fabaoCreateSheetReddot:initConfig()



if self.reddot_config==nil then
self.reddot_config={}

reddotClassManager.init_class(self)

self:init_data()
end
end

function fabaoCreateSheetReddot.addConfig(ubdId)
local class=reddotClassManager.get_class(REDDIT_TYPE.eFaBaoCreateBase)
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
CATCH_TYPE.eFaBaoCreate,
},
func=function(catchType)
return fabaoModel.getFabaoLianzhiType(ubdId)==FABAO_LIANZHI_TYPE.ePrize
end,
}
self.reddot_config[key]=subConfig
reddotClassManager.add_class_config(self,key,subConfig)
return key
end

function fabaoCreateSheetReddot.getBuildKey(ubdId)
local class=reddotClassManager.get_class(REDDIT_TYPE.eFaBaoCreateBase)
local self=class
return self.guidList[ubdId]
end

function fabaoCreateSheetReddot:resetConfig()

reddotClassManager.reset_class(self)
self.reddot_config=nil
self.guid=0
self.guidList={}
end


