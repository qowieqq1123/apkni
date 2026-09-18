







function xianjieModel:clearData_selfYuanJunTeam_MoJie()
if self.selfYuanJunTeamDatas_mj and next(self.selfYuanJunTeamDatas_mj)then
for i,v in pairs(self.selfYuanJunTeamDatas_mj)do
local teamHandleId=v.teamHandleId
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.selfYuanJunTeamDatas_mj=nil
end

function xianjieModel:initselfYuanJunTeamDatas_MoJie()
xianjieModel:clearData_selfYuanJunTeam_MoJie()
self.selfYuanJunTeamDatas_mj={}
end

function xianjieModel:refreshSelfYuanJunTeamData_MoJie(v,isInit)
local guid_str=tostring(v.guid)
local teamType=xjTeamHandleType.eMarchYuanZhu
if not self.selfYuanJunTeamDatas_mj then

return
end

local sceneidx=v.sceneidx
if isInit then

self.selfYuanJunTeamDatas_mj[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{marchguid=v.guid,marchguid_str=guid_str,sceneidx=sceneidx})
self.selfYuanJunTeamDatas_mj[guid_str].teamHandleId=teamHandleID
else
local teamData=self.selfYuanJunTeamDatas_mj[guid_str]
if teamData==nil then

self.selfYuanJunTeamDatas_mj[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{marchguid=v.guid,marchguid_str=guid_str,sceneidx=sceneidx})
self.selfYuanJunTeamDatas_mj[guid_str].teamHandleId=teamHandleID
else


self.selfYuanJunTeamDatas_mj[guid_str].data=v
self.selfYuanJunTeamDatas_mj[guid_str].sceneidx=sceneidx
end
end
end

function xianjieModel:removeSelfYuanJunTeamData_MoJie(guid)
local guid_str=tostring(guid)
local teamData=self.selfYuanJunTeamDatas_mj[guid_str]
if teamData~=nil then
local teamHandleID=teamData.teamHandleId
local boatid=teamData.data.boatid
xianjieController:removeXJTeamHandle(teamHandleID)
self.selfYuanJunTeamDatas_mj[guid_str]=nil
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eYuanZhu_MJ,guid,teamHandleID,boatid,true)
else



end
end

function xianjieModel:getSelfYuanJunTeamData_MoJie(guid)
if self.selfYuanJunTeamDatas_mj then
local guid_str=tostring(guid)
return self.selfYuanJunTeamDatas_mj[guid_str]
end
end

function xianjieModel:getDZState_yuanjun_MoJie(disguid_str,showDesc)
if self.selfYuanJunTeamDatas_mj then
for i,v in pairs(self.selfYuanJunTeamDatas_mj)do
for ii,vv in pairs(v.data.guidList)do
if tostring(vv)==disguid_str then
local desc
if showDesc then
desc='援助中'
end
return 3,desc
end
end
end
end
return nil,nil
end


function xianjieModel:clearData_selfYuanJunTeam_MoGong()
if self.selfYuanJunTeamDatas_mg and next(self.selfYuanJunTeamDatas_mg)then
for i,v in pairs(self.selfYuanJunTeamDatas_mg)do
local teamHandleId=v.teamHandleId
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.selfYuanJunTeamDatas_mg=nil
end

function xianjieModel:initselfYuanJunTeamDatas_MoGong()
xianjieModel:clearData_selfYuanJunTeam_MoGong()
self.selfYuanJunTeamDatas_mg={}
end

function xianjieModel:refreshSelfYuanJunTeamData_MoGong(v,isInit)
local guid_str=tostring(v.guid)
local teamType=xjTeamHandleType.eMarchYuanZhu
if not self.selfYuanJunTeamDatas_mg then

return
end

local sceneidx=v.sceneidx
if isInit then

self.selfYuanJunTeamDatas_mg[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{marchguid=v.guid,marchguid_str=guid_str,sceneidx=sceneidx})
self.selfYuanJunTeamDatas_mg[guid_str].teamHandleId=teamHandleID
else
local teamData=self.selfYuanJunTeamDatas_mg[guid_str]
if teamData==nil then

self.selfYuanJunTeamDatas_mg[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{marchguid=v.guid,marchguid_str=guid_str,sceneidx=sceneidx})
self.selfYuanJunTeamDatas_mg[guid_str].teamHandleId=teamHandleID
else


self.selfYuanJunTeamDatas_mg[guid_str].data=v
self.selfYuanJunTeamDatas_mg[guid_str].sceneidx=sceneidx
end
end
end

function xianjieModel:removeSelfYuanJunTeamData_MoGong(guid)
local guid_str=tostring(guid)
local teamData=self.selfYuanJunTeamDatas_mg[guid_str]
if teamData~=nil then
local teamHandleID=teamData.teamHandleId
local boatid=teamData.data.boatid
xianjieController:removeXJTeamHandle(teamHandleID)
self.selfYuanJunTeamDatas_mg[guid_str]=nil
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eYuanZhu_MG,guid,teamHandleID,boatid,true)
else



end
end

function xianjieModel:getSelfYuanJunTeamData_MoGong(guid)
if self.selfYuanJunTeamDatas_mg then
local guid_str=tostring(guid)
return self.selfYuanJunTeamDatas_mg[guid_str]
end
end

function xianjieModel:getDZState_yuanjun_MoGong(disguid_str,showDesc)
if self.selfYuanJunTeamDatas_mg then
for i,v in pairs(self.selfYuanJunTeamDatas_mg)do
for ii,vv in pairs(v.data.guidList)do
if tostring(vv)==disguid_str then
local desc
if showDesc then
desc='援助中'
end
return 3,desc
end
end
end
end
return nil,nil
end
