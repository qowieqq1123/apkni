









local subActivityInfo_gongceqiandao={name='gongceqiandao'}


function subActivityInfo_gongceqiandao:onInit()

end

function subActivityInfo_gongceqiandao:onStart()

end

function subActivityInfo_gongceqiandao:onDelete()

end


function subActivityInfo_gongceqiandao:checkNewDay()
if not self.data then
return
end
local today=self:getStart2NowDay()
bitHelper.set_1(self.data.sign_flag,today-1)

local subType=SUB_ACTIVITY_TYPE.egongCheQianDao
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)
end

function subActivityInfo_gongceqiandao:checkReddot()
if not self.data then
return false
end

local reward=self:getSubActConfig().rewards
local today=self:getStart2NowDay()
if reward[today]then
return self:checkSign(today)and not self:checkGot(today)
end

return false
end

function subActivityInfo_gongceqiandao:setShowLogin()
self.showWin=true
end

function subActivityInfo_gongceqiandao:checkShowLogin()
return not self.showWin
end

function subActivityInfo_gongceqiandao:checkSign(idx)
if not self.data then
return false
end
return bitHelper.check_pos(self.data.sign_flag,idx-1)
end

function subActivityInfo_gongceqiandao:checkGot(rewardIdx)
if not self.data then
return false
end
local flag=self.data.reward_flag
return bitHelper.check_pos(flag,rewardIdx-1)
end

function subActivityInfo_gongceqiandao:getZMLevel()
if not self.data then
return
end
return self.data.level or 0
end

return subActivityInfo_gongceqiandao