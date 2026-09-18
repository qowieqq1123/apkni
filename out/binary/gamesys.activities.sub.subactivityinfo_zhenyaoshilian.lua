









local subActivityInfo_zhenyaoshilian={name='zhenyaoshilian'}

function subActivityInfo_zhenyaoshilian:onInit()

end

function subActivityInfo_zhenyaoshilian:onStart()
self.data={}
self:listenNotify(notifyConfig.on_item_list_changed,function(...)
self:on_item_changed(...)
end)
end

function subActivityInfo_zhenyaoshilian:onUpdate()

end

function subActivityInfo_zhenyaoshilian:checkNewDay()
activitiesHandle_zhenyaoshilian:setChallenge_cnt(self.act_id,self.sub_act_id,0)
local subType=SUB_ACTIVITY_TYPE.eZhenYaoShiLian
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function subActivityInfo_zhenyaoshilian:checkReddot()
local sub_actcfg=self:getSubActConfig()
local freeCnt=sub_actcfg.free_cnt

local data=activitiesHandle_zhenyaoshilian:getAllMemoryBossReddotIdx(self.data.start_time)
if data and next(data)then
if data.bossReddotIdx then
for k,v in ipairs(data.bossReddotIdx)do
if v then
return true
end
end
end
end

if self.data and self.data.challenge_cnt and self.data.challenge_cnt<freeCnt then
return true
end

local costCfg=sub_actcfg.cost[1]
if costCfg then
local costId=costCfg[1]
local needCount=costCfg[2]
local haveCount=itemsModel.getCount(costId)

if haveCount>=needCount then
return true
else
return false
end
end

return false
end


function subActivityInfo_zhenyaoshilian:on_item_changed(args)
for i,v in ipairs(args)do
local changeType=v[1]
local itemguid=v[2]
local itemid=v[3]
local oldcount=v[4]
local newcount=v[5]

local sub_actcfg=self:getSubActConfig()
local costCfg=sub_actcfg.cost[1]
local itemId=costCfg[1]
if itemId==itemid then
activitiesHandle_zhenyaoshilian:on_item_changed(self.sub_act_id,itemid)
end
end
end

function subActivityInfo_zhenyaoshilian:onDelete()

end

return subActivityInfo_zhenyaoshilian