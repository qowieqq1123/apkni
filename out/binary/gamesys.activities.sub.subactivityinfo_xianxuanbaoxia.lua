









local subActivityInfo_xianxuanbaoxia={name='xianxuanbaoxia'}

function subActivityInfo_xianxuanbaoxia:onInit()
self.rewards=self:getSubActConfig('rewards')
end

function subActivityInfo_xianxuanbaoxia:onStart()

end

function subActivityInfo_xianxuanbaoxia:onUpdate()

end

function subActivityInfo_xianxuanbaoxia:onDelete()

end

function subActivityInfo_xianxuanbaoxia:checkReddot()
if not self.data then

return false
end
for i,v in ipairs(self.rewards)do
if self:checkCanRecvFlag(i)then
return true
end
end
return false
end


function subActivityInfo_xianxuanbaoxia:checkNewDay()
UIManager:invokeUIMethod("UISubAct_XXBX_Win","refresh")
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eXianXuanBaoXia)
end







function subActivityInfo_xianxuanbaoxia:getBuyFlag()
return self.data.unlock_flag==1
end

function subActivityInfo_xianxuanbaoxia:getRecvIndex()
return self.data.reward_idx
end

function subActivityInfo_xianxuanbaoxia:getFreeRecvFlag(index)
local recvIndex=self:getRecvIndex()
return recvIndex>=index
end

function subActivityInfo_xianxuanbaoxia:getRmbRecvFlag(index)
local recvIndex=self:getRecvIndex()
return recvIndex>=index
end

function subActivityInfo_xianxuanbaoxia:checkCanRecvFlag(index)
local day=self:getStart2NowDay()
if index>day then
return false
end
local recvIndex=self:getRecvIndex()
return index>recvIndex
end


return subActivityInfo_xianxuanbaoxia