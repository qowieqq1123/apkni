






local _yzDzLookup
local _yzTeamDzLookup

function XianJunYanZhenModel:clearData_yunzhouTeam()
self.yzDataList=nil
self.yzTeamDataList=nil
_yzDzLookup={}
_yzTeamDzLookup={}
end

function XianJunYanZhenModel:initAllYunZhouTeamData()
self:clearData_yunzhouTeam()
end


function XianJunYanZhenModel:getXJYZYunZhouDataList()
if not self.yzDataList then

self:loadXJYZYunZhouDataList()
end
return self.yzDataList
end

function XianJunYanZhenModel:getXJYZYunZhouDataByYzIdx(yzIdx)
if not self.yzDataList then
self:loadXJYZYunZhouDataList()
end

return self.yzDataList[yzIdx]
end

function XianJunYanZhenModel:setXJYZYunZhouDataTeamByYzIdx(yzIdx,teamList)
if not self.yzDataList then
self:loadXJYZYunZhouDataList()
end

if not self.yzDataList[yzIdx]then
self.yzDataList[yzIdx]={}
end

local oldTeamList=self.yzDataList[yzIdx].team
if oldTeamList and next(oldTeamList)then
for posIdx,dzGuidStr in pairs(oldTeamList)do
_yzDzLookup[dzGuidStr]=nil
end
end

local list={}
if teamList~=nil and next(teamList)~=nil then
for posIdx,dzGuidStr in pairs(teamList)do
if UIDiscipleModel:isMyActorDZ(int64.new(dzGuidStr))then
list[posIdx]=dzGuidStr
end
end
end

if not next(list)then
self.yzDataList[yzIdx].team=nil
else
self.yzDataList[yzIdx].team=list

for posIdx,dzGuidStr in pairs(list)do
_yzDzLookup[dzGuidStr]={yzIdx=yzIdx,posIdx=posIdx}
end
end
end

function XianJunYanZhenModel:setXJYZYunZhouDataSoldierByYzIdx(yzIdx,soldierList)
if not self.yzDataList then
self:loadXJYZYunZhouDataList()
end

if not self.yzDataList[yzIdx]then
self.yzDataList[yzIdx]={}
end

if not next(soldierList)then
self.yzDataList[yzIdx].soldier=nil
else
self.yzDataList[yzIdx].soldier=soldierList
end
end

function XianJunYanZhenModel:saveXJYZYunZhouDataList()
local saveData={}
if self.yzDataList and next(self.yzDataList)then
for yzIdx,data in pairs(self.yzDataList)do
local yzIdxStr=tostring(yzIdx)
local s_data={}
s_data.name=data.name
if data then
if data.team and next(data.team)then
local teamList=data.team
local list={}
for posIdx,dzGuidStr in pairs(teamList)do
local posIdxStr=tostring(posIdx)
list[posIdxStr]=dzGuidStr
end
s_data.team=list
end
if data.soldier and next(data.soldier)then
local soldierList=data.soldier
local list={}
for soldierIdx,count in pairs(soldierList)do
if count>0 then
local soldierIdxStr=tostring(soldierIdx)
list[soldierIdxStr]=count
end
end
s_data.soldier=list
else
s_data.soldier=nil
end
end
saveData[yzIdxStr]=s_data
end

serverSaveController:send_254_102(SERVER_JSON_DATA_TYPE.eXJYZYZData,saveData)
end
end

function XianJunYanZhenModel:loadXJYZYunZhouDataList()
local saveData=serverSaveModel:getJsonData(SERVER_JSON_DATA_TYPE.eXJYZYZData)or{}
local yzDataList={}
_yzDzLookup={}
if saveData and tostring(saveData)~="userdata: NULL"and next(saveData)then
for yzIdxStr,data in pairs(saveData)do
local yzIdx=tonumber(yzIdxStr)
local s_data={}
s_data.name=data.name
if data then
if data.team and next(data.team)then
local teamList=data.team
local list={}
for posIdxStr,dzGuidStr in pairs(teamList)do
if UIDiscipleModel:isMyActorDZ(int64.new(dzGuidStr))then
local posIdx=tonumber(posIdxStr)
list[posIdx]=dzGuidStr

_yzDzLookup[dzGuidStr]={yzIdx=yzIdx,posIdx=posIdx}
end
end
s_data.team=list
end

if data.soldier and next(data.soldier)then
local soldierList=data.soldier
local list={}
for soldierIdxStr,count in pairs(soldierList)do
local soldierIdx=tonumber(soldierIdxStr)
if count>0 then
list[soldierIdx]=count
end
end
if next(list)~=nil then
s_data.soldier=list
end
end
end
yzDataList[yzIdx]=s_data
end
end
self.yzDataList=yzDataList
end

function XianJunYanZhenModel:getXJYZYunZhouDataSelectLookUp()
if not _yzDzLookup then
return{}
end
return _yzDzLookup
end

function XianJunYanZhenModel:removeXJYZYunZhouDataSelectDzByList(list)
if not self.yzDataList then
return
end

local yzidLookup={}
for _,v in ipairs(list)do
local yzIdx=v.yzIdx
local posIdx=v.posIdx
yzidLookup[yzIdx]=yzIdx
if self.yzDataList[yzIdx]and self.yzDataList[yzIdx].team then
local dzGuidStr=self.yzDataList[yzIdx].team[posIdx]
_yzDzLookup[dzGuidStr]=nil
self.yzDataList[yzIdx].team[posIdx]=nil
if not next(self.yzDataList[yzIdx].team)then
self.yzDataList[yzIdx].team=nil
end
end
end

for _,yzIdx in pairs(yzidLookup)do
UIManager:invokeUIMethod("UIXianJunYanZhen_YunZhouPrepareWin","onYunZhouTeamDZUpdateRecv",yzIdx)
end
end

function XianJunYanZhenModel:removeXJYZYunZhouDz(guid)
local delGuidStr=tostring(guid)
if not _yzDzLookup or not _yzDzLookup[delGuidStr]then
return
end
local yzIdx=_yzDzLookup[delGuidStr].yzIdx
local posIdx=_yzDzLookup[delGuidStr].posIdx
self.yzDataList[yzIdx].team[posIdx]=nil
if not next(self.yzDataList[yzIdx].team)then
self.yzDataList[yzIdx].team=nil
end

_yzDzLookup[delGuidStr]=nil
end



function XianJunYanZhenModel:getXJYZYunZhouTeamDataList()
if not self.yzTeamDataList then

self:loadXJYZYunZhouTeamDataList()
end
return self.yzTeamDataList
end

function XianJunYanZhenModel:getXJYZYunZhouTeamDataByTeamIdx(teamIdx)
if not self.yzTeamDataList or not self.yzTeamDataList[teamIdx]then
return false
end
return self.yzTeamDataList[teamIdx]
end

function XianJunYanZhenModel:setXJYZYunZhouTeamDzListByTeamIdx(teamIdx,dzList)
if not self.yzTeamDataList then
self:loadXJYZYunZhouTeamDataList()
end

if not self.yzTeamDataList[teamIdx]then
self.yzTeamDataList[teamIdx]={}
end

local oldDzList=self.yzTeamDataList[teamIdx].dzList
if oldDzList and next(oldDzList)then
for posIdx,dzGuidStr in pairs(oldDzList)do
_yzTeamDzLookup[dzGuidStr]=nil
end
end

local list={}
if dzList~=nil and next(dzList)~=nil then
for posIdx,dzGuidStr in pairs(dzList)do
if UIDiscipleModel:isMyActorDZ(int64.new(dzGuidStr))then
list[posIdx]=dzGuidStr
end
end
end

local idx=teamIdx

if list and next(list)then
self.yzTeamDataList[teamIdx].dzList=list
for posIdx,dzGuidStr in pairs(list)do
_yzTeamDzLookup[dzGuidStr]={teamIdx=teamIdx,posIdx=posIdx}
end
else

table.remove(self.yzTeamDataList,teamIdx)
idx=nil
end

return idx
end

function XianJunYanZhenModel:getXJYZYunZhouTeamSelectLookUp()
if not _yzTeamDzLookup then
return{}
end

return _yzTeamDzLookup
end


function XianJunYanZhenModel:saveXJYZYunZhouTeamDataList()
local saveData={}
if self.yzTeamDataList and next(self.yzTeamDataList)then
for teamIdx,data in pairs(self.yzTeamDataList)do
local teamIdxStr=tostring(teamIdx)
local s_data={}
s_data.name=data.name
if data and data.dzList and next(data.dzList)then
local dzList=data.dzList
local list={}
for posIdx,dzGuidStr in pairs(dzList)do
local posIdxStr=tostring(posIdx)
list[posIdxStr]=dzGuidStr
end
s_data.dzList=list
end
saveData[teamIdxStr]=s_data
end

userActorArraySetting.set(ACTOR_SETTING_TYPE.eXJYZYunZhouTeam,'xjyzYzTeamDataList',saveData)

userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXJYZYunZhouTeam)
end
end

function XianJunYanZhenModel:loadXJYZYunZhouTeamDataList()
local saveData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXJYZYunZhouTeam,'xjyzYzTeamDataList',{})
local yzTeamDataList={}
_yzTeamDzLookup={}
if next(saveData)then
for teamIdxStr,data in pairs(saveData)do
local teamIdx=tonumber(teamIdxStr)
local s_data={}
s_data.name=data.name
if data and data.dzList and next(data.dzList)then
local dzList=data.dzList
local list={}
for posIdxStr,dzGuidStr in pairs(dzList)do
if UIDiscipleModel:isMyActorDZ(int64.new(dzGuidStr))then
local posIdx=tonumber(posIdxStr)
list[posIdx]=dzGuidStr

_yzTeamDzLookup[dzGuidStr]={teamIdx=teamIdx,posIdx=posIdx}
end
end
if next(list)~=nil then
s_data.dzList=list
end
end
yzTeamDataList[teamIdx]=s_data
end
end
self.yzTeamDataList=yzTeamDataList
end

function XianJunYanZhenModel:removeXJYZYunZhouTeamDz(guid)
local delGuidStr=tostring(guid)
if not _yzTeamDzLookup or not _yzTeamDzLookup[delGuidStr]then
return
end
local teamIdx=_yzTeamDzLookup[delGuidStr].teamIdx
local posIdx=_yzTeamDzLookup[delGuidStr].posIdx
self.yzTeamDataList[teamIdx].dzList[posIdx]=nil
if not next(self.yzTeamDataList[teamIdx].dzList)then
table.remove(self.yzTeamDataList,teamIdx)
end

_yzTeamDzLookup[delGuidStr]=nil
end



function XianJunYanZhenModel:getXJYZFreeAndHasTeamYzIndex(gx_id,yzUsedLookup)
local yzList=XianYunGangModel:getBoatList()or{}
for i,v in ipairs(yzList)do
local yzId=v.boatid
local isUsedYZ=XianJunYanZhenModel:getIsUsedYZ(yzId,gx_id)
if yzUsedLookup and yzUsedLookup[yzId]~=nil then
isUsedYZ=true
end
if not isUsedYZ then
local yzData=self:getXJYZYunZhouDataByYzIdx(yzId)
if yzData and yzData.team and next(yzData.team)then
return yzId
end
end
end

return nil
end