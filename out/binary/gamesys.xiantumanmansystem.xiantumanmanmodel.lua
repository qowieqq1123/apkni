






local _MODULENAME="XianTuManManModel"


def_table(_MODULENAME)
XianTuManManModel.name=_MODULENAME
XianTuManManModel.data={}

function XianTuManManModel:onAppStart()

end


function XianTuManManModel:onEnterState(isReconnect)

end


function XianTuManManModel:onProtocolReq()

end


function XianTuManManModel:onLeaveState(isReconnect)

self.data={}
end


function XianTuManManModel:setData(data)
self.data=data
end

function XianTuManManModel:getData()
return self.data
end

function XianTuManManModel:setData_loginDay(day)
self.data.login_days=day
end

function XianTuManManModel:getData_loginDay()
return self.data.login_days or 0
end

function XianTuManManModel:setData_rewardsIdx(idx)
self.data.rewards_idx=idx
end

function XianTuManManModel:getData_rewardsIdx()
return self.data.rewards_idx or 0
end

function XianTuManManModel:getConfig()
return cfg_xiantumanmanconfig()
end
