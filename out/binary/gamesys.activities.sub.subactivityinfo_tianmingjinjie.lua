









local subActivityInfo_tianmingjinjie={name='tianmingjinjie'}

function subActivityInfo_tianmingjinjie:onInit()

end

function subActivityInfo_tianmingjinjie:onStart()

end

function subActivityInfo_tianmingjinjie:onDelete()

end

function subActivityInfo_tianmingjinjie:checkReddot()
if not self.data then
return false
end

local cfg=cfgHelper.get1(cfg_specdsptianmingconfig_get,self.sub_act_id)
local showIndex=self.data.rewardIndex+1
showIndex=math.min(showIndex,#cfg.reward)
if showIndex==self.data.rewardIndex then
return false
end

local target=cfg.reward[showIndex][1]
local len=#target
for i=1,len do
if self.data.progress[i]<target[i]then
return false
end
end

return true
end

return subActivityInfo_tianmingjinjie