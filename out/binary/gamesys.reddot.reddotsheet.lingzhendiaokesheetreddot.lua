
lingzhenDiaokeSheetReddot=reddotSheetBase.new({classname='lingzhenDiaokeSheetReddot',subType_=REDDIT_SUB_TYPE.slingZhenDiaoke})

lingzhenDiaokeSheetReddot.reddot_type=REDDIT_TYPE.elingZhenDiaoke

lingzhenDiaokeSheetReddot.isDynamic=true

function lingzhenDiaokeSheetReddot:onAppStart()

end

function lingzhenDiaokeSheetReddot:onEnterState()
self:resetConfig()
self:initConfig()
end

function lingzhenDiaokeSheetReddot:onLeaveState()
self:resetConfig()
end

function lingzhenDiaokeSheetReddot:initConfig()

if self.reddot_config==nil then
self.reddot_config={}

reddotClassManager.init_class(self)

self:init_data()
end
end

function lingzhenDiaokeSheetReddot.addConfig(ubdId)
local class=reddotClassManager.get_class(REDDIT_TYPE.elingZhenDiaoke)
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
CATCH_TYPE.eLingZhenDiaoke,
},
func=function(catchType)
local ubdData=zongmenModel:getBuildingData(ubdId)
if not ubdData then
return false
end
local sfid,jzGuid=zongmenModel:getMountainId(),ubdData.un_build_id
return LZDiaoKeModel:checkReddot(jzGuid)or LZDiaoKeModel:CheckDKState(sfid,jzGuid)==LZDKSTATE.eHoldDKReward
end,
}
self.reddot_config[key]=subConfig
reddotClassManager.add_class_config(self,key,subConfig)
return key
end

function lingzhenDiaokeSheetReddot:resetConfig()

reddotClassManager.reset_class(self)
self.reddot_config=nil
self.guid=0
self.guidList={}
end

