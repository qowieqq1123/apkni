









local subActivityInfo_drawdianji={name='subActivityInfo_drawdianji'}

function subActivityInfo_drawdianji:onInit()
self:listenNotify(notifyConfig.onLingZengPengZhuangScoreChange,function(score)

local jstr=jsonHelper.encode({4,score})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.act_id,self.sub_act_type,self.sub_act_id,jstr)
end)
end

function subActivityInfo_drawdianji:onStart()

end

function subActivityInfo_drawdianji:onDelete()

end

function subActivityInfo_drawdianji:checkReddot()
if self:judeTarget()then
return true
end

return false
end

function subActivityInfo_drawdianji:judeTarget()
self.config=activitiesModel:getSubActivityConfig(self.sub_act_type,self.sub_act_id)
self.data.CangetReward={}
local flag=false
for k,v in ipairs(self.config.taskList)do
local cfg=cfgHelper.get1(cfg_huihuadianjiactgoalconfig_get,v)
local hhjf=cfg.hhjf

local f1=false
local f2=false
local f3=false

if self.data.freeReward<hhjf and self.data.hhjifen>=hhjf then
flag=true
f1=true
end
if self.data.tzRewardFlag1==1 and self.data.tzRewad1<hhjf and self.data.hhjifen>=hhjf then
flag=true
f2=true
end
if self.data.tzRewardFlag2==1 and self.data.tzRewad2<hhjf and self.data.hhjifen>=hhjf then
flag=true
f3=true
end

self.data.CangetReward[#self.data.CangetReward+1]={f1,f2,f3}

end

return flag
end


return subActivityInfo_drawdianji