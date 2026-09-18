






local _MODULENAME="systemZongmenRelationModel"


def_table(_MODULENAME)
systemZongmenRelationModel.name=_MODULENAME
systemZongmenRelationModel.data={}

function systemZongmenRelationModel:onAppStart()

end


function systemZongmenRelationModel:onEnterState(isReconnect)

end


function systemZongmenRelationModel:onProtocolReq()

end


function systemZongmenRelationModel:onLeaveState(isReconnect)

self.data={}
end

function systemZongmenRelationModel:setWillChangeZM()
local list={}
local infoList=systemZongMenModel:getInfoList()

for index,info in ipairs(infoList)do
local type=cfgHelper.get2(cfg_syssectconfig_get,info.id,'type')
if type==1 and(info.flag==systemZongMenFightFlagType.eBeAttacked or info.flag==systemZongMenFightFlagType.eAttacking)then
list[#list+1]=info
end
end
self.data.list=list
end

function systemZongmenRelationModel:getWillChangeZm()
return self.data.list or{}
end



