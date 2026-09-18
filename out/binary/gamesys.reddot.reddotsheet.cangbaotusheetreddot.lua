local classname='cangbaotuSheetReddot'

cangbaotuSheetReddot=reddotSheetBase.new({classname=classname,subType_=REDDIT_SUB_TYPE.sCangBaoTuCardRecord})

cangbaotuSheetReddot.reddot_type=REDDIT_TYPE.eCangBaoTuCardRecord

cangbaotuSheetReddot.isDynamic=true

function cangbaotuSheetReddot:onAppStart()

end

function cangbaotuSheetReddot:onEnterState()
self:initConfig()
end

function cangbaotuSheetReddot:onLeaveState()
self:resetConfig()
end

function cangbaotuSheetReddot:initConfig()
if self.reddot_config==nil then
self:resetConfig()
self.reddot_config={}
reddotClassManager.init_class(self)
self:init_data()
end
end

function cangbaotuSheetReddot:resetConfig()

reddotClassManager.reset_class(self)
self.reddot_config=nil
self.guid=0
self.guidList={}
end

function cangbaotuSheetReddot.addConfig(actId,subId)
local class=reddotClassManager.get_class(REDDIT_TYPE.eCangBaoTuCardRecord)
if class==nil then
class=reddotClassManager.get_class_by_name(classname)
class:initConfig()
end
local self=class
if self.guidList[actId]and self.guidList[actId][subId]then
return self.guidList[actId][subId]
end

self.guid=self.guid+1
local guid=self.guid
local key=self:getSubReddotKey(guid)
if not self.guidList[actId]then
self.guidList[actId]={}
end
self.guidList[actId][subId]=key
local subConfig={
catch={
CATCH_TYPE.eCangBaoTuShareRecord,
},
func=function(catchType)
return cangbaotuSheetReddot.getRecordReddot(actId,subId)
end,
}
self.reddot_config[key]=subConfig
reddotClassManager.add_class_config(self,key,subConfig)
return key
end

function cangbaotuSheetReddot.getSubActivityKey(actId,subId)
local class=reddotClassManager.get_class(REDDIT_TYPE.eCangBaoTuCardRecord)or
reddotClassManager.get_class_by_name(classname)
if class==nil then return end
local self=class
if self.guidList[actId]then
return self.guidList[actId][subId]
end
end

function cangbaotuSheetReddot.getRecordReddot(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eCangBaoGe
local info=activitiesModel:getSubActInfo(actId,subType,subId)
if info and info:checkDoing()and info:hasData()then
return info:getRecordReddot()
end
return false
end
