









local xjEntityData_notDataMarchTeam={}


function xjEntityData_notDataMarchTeam:onInit()
self.len=nil
self.list=nil
self.isMyWaiPai=xianjieModel:checkInBaseWaiPai(xjWaiPiaBaseType.eMarckTeam,self.guid)
end

function xjEntityData_notDataMarchTeam:refreshData(d)

end

function xjEntityData_notDataMarchTeam:markMyWaiPai()
self.isMyWaiPai=true
end

function xjEntityData_notDataMarchTeam:compareKey(guid)
local marchguid_str=tostring(self.guid)
return marchguid_str==tostring(guid)
end


function xjEntityData_notDataMarchTeam:initTeamHandle()
if self.teamHandleID==nil then
local marchguid=self.guid
local marchguid_str=tostring(self.guid)
self.teamHandleID=xianjieController:addXJTeamHandle(xjTeamHandleType.eNotDataMarchTeam,{marchguid=marchguid,marchguid_str=marchguid_str})
end
end


function xjEntityData_notDataMarchTeam:onDelete()

end

return xjEntityData_notDataMarchTeam