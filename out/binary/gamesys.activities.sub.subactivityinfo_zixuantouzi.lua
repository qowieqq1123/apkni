









local subActivityInfo_zixuantouzi={name='zixuantouzi'}

function subActivityInfo_zixuantouzi:onInit()
self.flushKey=FMT.fmt('actid{0}_subtype{1}_subid{2}_selectBuyId',self.act_id,self.sub_act_type,self.sub_act_id)
end

function subActivityInfo_zixuantouzi:onStart()

end

function subActivityInfo_zixuantouzi:onUpdate()

end

function subActivityInfo_zixuantouzi:onDelete()

end

function subActivityInfo_zixuantouzi:checkReddot()
if not self.data then

return false
end

local recvIndex=self:getRecvIndex()
local nextIndex=recvIndex+1
local target_rewards=self:getSubActConfig('target_rewards')

if target_rewards[nextIndex]then
local curScore=self:getCurScore()
local nextScore=target_rewards[nextIndex][1]
return curScore>=nextScore
end
return false

end



function subActivityInfo_zixuantouzi:checkNewDay()

end


function subActivityInfo_zixuantouzi:startActTime()

end

function subActivityInfo_zixuantouzi:getSelectBuyId()
local selectBuyId=userActorSetting.get(self.flushKey,nil)
return selectBuyId
end

function subActivityInfo_zixuantouzi:setSelectBuyId(id)
userActorSetting.flushVal(self.flushKey,id)
end

function subActivityInfo_zixuantouzi:getBuyedId()
return self.data.invest_idx~=0 and self.data.invest_idx or nil
end

function subActivityInfo_zixuantouzi:getCurScore()
return self.data.score or 0
end

function subActivityInfo_zixuantouzi:getRecvIndex()
return self.data.reward_idx or 0
end



return subActivityInfo_zixuantouzi