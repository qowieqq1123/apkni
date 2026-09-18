







function xianjieModel:clearData_selfYuanJunTeam()
if self.selfYuanJunTeamDatas and next(self.selfYuanJunTeamDatas)then
for i,v in pairs(self.selfYuanJunTeamDatas)do
local teamHandleId=v.teamHandleId
xianjieController:removeXJTeamHandle(teamHandleId)
end
end

self.selfYuanJunTeamDatas=nil
end

function xianjieModel:initSelfYuanJunTeamDatas()
xianjieModel:clearData_selfYuanJunTeam()
self.selfYuanJunTeamDatas={}
end

function xianjieModel:refreshSelfYuanJunTeamData(v,isInit)
local guid_str=tostring(v.guid)
local teamType=xjTeamHandleType.eMarchYuanZhu
if not self.selfYuanJunTeamDatas then

return
end

local sceneidx=v.sceneidx
if isInit then

self.selfYuanJunTeamDatas[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{marchguid=v.guid,marchguid_str=guid_str,sceneidx=sceneidx})
self.selfYuanJunTeamDatas[guid_str].teamHandleId=teamHandleID
else
local teamData=self.selfYuanJunTeamDatas[guid_str]
if teamData==nil then

self.selfYuanJunTeamDatas[guid_str]={data=v,sceneidx=sceneidx}
local teamHandleID=xianjieController:addXJTeamHandle(teamType,{marchguid=v.guid,marchguid_str=guid_str,sceneidx=sceneidx})
self.selfYuanJunTeamDatas[guid_str].teamHandleId=teamHandleID
else


self.selfYuanJunTeamDatas[guid_str].data=v
self.selfYuanJunTeamDatas[guid_str].sceneidx=sceneidx
end
end
end

function xianjieModel:removeSelfYuanJunTeamData(guid)
local guid_str=tostring(guid)
local teamData=self.selfYuanJunTeamDatas[guid_str]
if teamData~=nil then
local teamHandleID=teamData.teamHandleId
local boatid=teamData.data.boatid
xianjieController:removeXJTeamHandle(teamHandleID)
self.selfYuanJunTeamDatas[guid_str]=nil
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eYuanZhu,guid,teamHandleID,boatid,true)
else



end
end

function xianjieModel:getSelfYuanJunTeamData(guid)
if self.selfYuanJunTeamDatas then
local guid_str=tostring(guid)
return self.selfYuanJunTeamDatas[guid_str]
end
end

function xianjieModel:getDZState_yuanjun(disguid_str,showDesc)
if self.selfYuanJunTeamDatas then
for i,v in pairs(self.selfYuanJunTeamDatas)do
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

