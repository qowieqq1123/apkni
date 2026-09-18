









local subActivityInfo_fabaomilu={name='fabaomilu'}

function subActivityInfo_fabaomilu:onInit()

end

function subActivityInfo_fabaomilu:onStart()

end

function subActivityInfo_fabaomilu:onUpdate()

end

function subActivityInfo_fabaomilu:onDelete()

end



function subActivityInfo_fabaomilu:checkUnlock_first(isWarning)
local check=self:checkGotReward()
if not check then
if isWarning then
UIManager.info('完成法宝秘录的预览任务后解锁')
end
end
return check
end

function subActivityInfo_fabaomilu:checkReddot()
local data=self.data
if data then
local gotReward=data.sec>0
return not gotReward
end
return false
end

function subActivityInfo_fabaomilu:getLookRecords()
local temp=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eActFaBaoMiLu,{})
temp.looks=temp.looks or{}
local id_str=tostring(self.sub_act_id)
temp.looks[id_str]=temp.looks[id_str]or{}
return temp.looks[id_str]
end

function subActivityInfo_fabaomilu:setLookRedcord(idx)
local lp=self:getLookRecords()
local idx_str=tostring(idx)
lp[idx_str]=true
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eActFaBaoMiLu)
end

function subActivityInfo_fabaomilu:checkLookRedcord(idx)
local lp=self:getLookRecords()
local idx_str=tostring(idx)
return lp[idx_str]~=nil
end

function subActivityInfo_fabaomilu:getLookRecordNum()
local lp=self:getLookRecords()
local n=0
for k,v in pairs(lp)do
n=n+1
end
return n
end

function subActivityInfo_fabaomilu:getLookMaxNum()
return self:getSubActConfig('looknum')
end

function subActivityInfo_fabaomilu:checkReward()
local data=self.data
if data then
local cur=self:getLookRecordNum()
local max=self:getLookMaxNum()
local fix=cur>=max
local gotReward=data.sec>0
local hasReward=fix and not gotReward
return hasReward,fix
end
return false,false
end

function subActivityInfo_fabaomilu:checkGotReward()
local data=self.data
if data then
return data.sec>0
end
return false
end

function subActivityInfo_fabaomilu:checkFixAndGot()
local flag,fix=self:checkReward()
return not flag and fix
end

return subActivityInfo_fabaomilu