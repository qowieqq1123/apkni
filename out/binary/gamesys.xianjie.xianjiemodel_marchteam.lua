


































































xjServerMarch2TeamHandleType={
[xjServerMarchType.eKill]=xjTeamHandleType.eMarchKill,
[xjServerMarchType.eSpy]=xjTeamHandleType.eMarchSpy,
[xjServerMarchType.eStation]=xjTeamHandleType.eMarchStation,
[xjServerMarchType.eBack]=xjTeamHandleType.eMarchBack,
[xjServerMarchType.eYuanZhu]=xjTeamHandleType.eMarchYuanZhu,
[xjServerMarchType.eJiJieJoin]=xjTeamHandleType.eJiJieJoin,
[xjServerMarchType.eJiJieChuZheng]=xjTeamHandleType.eJiJieChuZheng,
[xjServerMarchType.eAttackRole]=xjTeamHandleType.eAttackRole,
[xjServerMarchType.eKillBossMonster]=xjTeamHandleType.eMarchKill,
[xjServerMarchType.eCarry]=xjTeamHandleType.eCarryRepair,
[xjServerMarchType.eMoZongAttack]=xjTeamHandleType.eMoZongAttack,
[xjServerMarchType.eMoZongBack]=xjTeamHandleType.eMoZongBack,
[xjServerMarchType.eMoJingZhenJi_Normal]=xjTeamHandleType.eMarchKill,
[xjServerMarchType.eMoJingZhenJi_Origin]=xjTeamHandleType.eMoJingZhenJi_Origin,
[xjServerMarchType.eDefendXianMeng]=xjTeamHandleType.eDefendXianMeng,
[xjServerMarchType.eAttackXianMeng]=xjTeamHandleType.eAttackXianMeng,
[xjServerMarchType.eMoJunYaoMo]=xjTeamHandleType.eMoJunYaoMo,
[xjServerMarchType.eMoJunFenShenAttack]=xjTeamHandleType.eMoJunFenShenAttack,
[xjServerMarchType.eMJSLDebuffAdd]=xjTeamHandleType.eMarchMJSLDebuffAdd,
[xjServerMarchType.eMoJieBoxCJ]=xjTeamHandleType.eMarchMJBoxCJ,
[xjServerMarchType.eMoJieSG]=xjTeamHandleType.eMarchKill,
[xjServerMarchType.eMoGongZhanHunGe]=xjTeamHandleType.eMoGongBuffMarchTeam,
[xjServerMarchType.eMoGongHuLingTa]=xjTeamHandleType.eMoGongBuffMarchTeam,
[xjServerMarchType.eZhenYanAttack]=xjTeamHandleType.eZhenYanAttack,
[xjServerMarchType.eZhenYanBack]=xjTeamHandleType.eZhenYanBack,
[xjServerMarchType.eLingShouAttack]=xjTeamHandleType.eLingShouAttack,
[xjServerMarchType.eLingShouGroupAttak]=xjTeamHandleType.eLingShouGroupAttack,
}

xjMarchTeamStateType={
eNone=-1,
eGoto=0,
eBattle=1,
eBack=2,

getDesc=function(self_,v)
if v==self_.eGoto then
return'前往中'
elseif v==self_.eBattle then
return'战斗中'
elseif v==self_.eBack then
return'返程中'
end
end,
}

function xianjieModel:clearData_marchTeam()
local lp=self.allMarchTeamDatas
if lp then
for marchguid_str,marchTeamData in pairs(lp)do
xianjieController:removeXJClass(marchTeamData)
end
self.allMarchTeamDatas=nil
self.removeMarchTeamLookup=nil
end
end


function xianjieModel:clearData_marchTeamByMarchtype(marchtype)
local lp=self.allMarchTeamDatas
if lp then
for marchguid_str,marchTeamData in pairs(lp)do
if marchtype==marchTeamData.marchtype then
xianjieController:removeXJClass(marchTeamData)
self.allMarchTeamDatas[marchguid_str]=nil
self.removeMarchTeamLookup[marchguid_str]=true
end
end
end
end


function xianjieModel:clearData_marchTeamByMoJunFenShen(_infoguidStr)
local lp=self.allMarchTeamDatas
if lp then
for marchguid_str,marchTeamData in pairs(lp)do
if marchTeamData.marchtype==xjServerMarchType.eMoJunFenShenAttack and marchTeamData.infoguidStr==_infoguidStr then
xianjieController:removeXJClass(marchTeamData)
self.allMarchTeamDatas[marchguid_str]=nil
self.removeMarchTeamLookup[marchguid_str]=true
end
end
end
end


function xianjieModel:clearData_marchTeam_notData()
local lp=self.notDataMarchTeamList
if lp then
for guid,teamData in pairs(lp)do
xianjieModel:removeNotDataMarchTeam(guid)
end
self.notDataMarchTeamList=nil
end
end

function xianjieModel:turnData_marchTeamData2notDataTeam()
local lp=self.allMarchTeamDatas
if lp then
for marchguid_str,marchTeamData in pairs(lp)do
local isMyWaiPai=marchTeamData.isMyWaiPai
local marchguid=marchTeamData.marchguid
local boatid=marchTeamData.boatid
local sceneidx=marchTeamData.tarsceneidx
if isMyWaiPai then
local data={
guid=marchguid,
boatid=boatid,
sceneidx=sceneidx,
}
xianjieModel:refreshNotDataMarchTeam(data)
end
end
end
end

function xianjieModel:clearData_marchTeamBehavior()
local lp=self.allMarchTeamDatas
if lp then
for marchguid_str,marchTeamData in pairs(lp)do
marchTeamData:clearBehaviorEx()
end
end
end

function xianjieModel:initAllMarchTeamDatas(isClear)
if isClear then
xianjieModel:clearData_marchTeam()
xianjieModel:clearData_marchTeam_notData()
end
if not self.allMarchTeamDatas then
self.allMarchTeamDatas={}
end

if not self.notDataMarchTeamList then
self.notDataMarchTeamList={}
end

if not self.removeMarchTeamLookup then
self.removeMarchTeamLookup={}
end
end

function xianjieModel:refreshMarchTeamData(v,isInit)
local marchguid_str=v.marchguid_str
if isInit then
local marchTeamData=xianjieController:createXJClass(xjDataType.eMarchTeam,v)
self.allMarchTeamDatas[marchguid_str]=marchTeamData
marchTeamData:initTeamHandle()
else
if v.marchtype~=0 then
local marchTeamData_=self.allMarchTeamDatas[marchguid_str]
if marchTeamData_==nil then
local marchTeamData=xianjieController:createXJClass(xjDataType.eMarchTeam,v)
self.allMarchTeamDatas[marchguid_str]=marchTeamData
marchTeamData:initTeamHandle()
marchTeamData:createBehavior(nil,true)
else
marchTeamData_:refreshData(v)
end
else
local marchTeamData=self.allMarchTeamDatas[marchguid_str]
if marchTeamData~=nil then
local isMyWaiPai=marchTeamData.isMyWaiPai
local teamHandleID=marchTeamData.teamHandleID
local marchguid=marchTeamData.marchguid
local boatid=marchTeamData.boatid
xianjieController:removeXJClass(marchTeamData)
self.allMarchTeamDatas[marchguid_str]=nil
self.removeMarchTeamLookup[marchguid_str]=true
if isMyWaiPai then
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eMarckTeam,marchguid,teamHandleID,boatid)
end
else
if not self.removeMarchTeamLookup or not self.removeMarchTeamLookup[marchguid_str]then



end
end
end
end
end

function xianjieModel:removeMarchTeamData(guid,isRemoveByWaiPaiData)
local marchguid_str=tostring(guid)
if not self.allMarchTeamDatas then

return
end

local marchTeamData=self.allMarchTeamDatas[marchguid_str]
if marchTeamData then
local isMyWaiPai=marchTeamData.isMyWaiPai
local teamHandleID=marchTeamData.teamHandleID
local marchguid=marchTeamData.guid
local boatid=marchTeamData.boatid
xianjieController:removeXJClass(marchTeamData)
self.allMarchTeamDatas[marchguid_str]=nil
self.removeMarchTeamLookup[marchguid_str]=true
if isMyWaiPai and not isRemoveByWaiPaiData then
xianjieModel:removeBaseWaiPaiData(xjWaiPiaBaseType.eMarckTeam,marchguid,teamHandleID,boatid)
end
else
if not self.removeMarchTeamLookup or not self.removeMarchTeamLookup[marchguid_str]then



end
end
end

function xianjieModel:refreshNotDataMarchTeam(v,isInit)
local marchguid_str=tostring(v.guid)
if not self.notDataMarchTeamList then

return
end

if isInit then
local xjData=xianjieController:createXJClass(xjDataType.eNotDataMarchTeam,v)
self.notDataMarchTeamList[marchguid_str]=xjData
xjData:initTeamHandle()
else
local xjData_=self.notDataMarchTeamList[marchguid_str]
if xjData_==nil then
local xjData=xianjieController:createXJClass(xjDataType.eNotDataMarchTeam,v)
self.notDataMarchTeamList[marchguid_str]=xjData
xjData:initTeamHandle()
else
xjData_:refreshData(v)
end
end
end

function xianjieModel:removeNotDataMarchTeam(guid)
local marchguid_str=tostring(guid)
local xjData=self.notDataMarchTeamList[marchguid_str]
if xjData then
local teamHandleID=xjData.teamHandleID
local marchguid=xjData.guid
local boatid=xjData.boatid
xianjieController:removeXJClass(xjData)
self.notDataMarchTeamList[marchguid_str]=nil

end
end

function xianjieModel:getIsHaveYuanJunTeam()
if self.allMarchTeamDatas then
for k,v in pairs(self.allMarchTeamDatas)do
if v then
if v.marchtype==5 then
return true
end
end
end
end

return false
end

function xianjieModel:getMarchTeamData(marchguid)
if self.allMarchTeamDatas then
local marchguid_str=tostring(marchguid)
return self.allMarchTeamDatas[marchguid_str]
end
end

function xianjieModel:getMarchTeamDataEx(marchguid_str)
if self.allMarchTeamDatas then
return self.allMarchTeamDatas[marchguid_str]
end
end

function xianjieModel:getNotDataMarchTeam(marchguid)
if self.notDataMarchTeamList then
local marchguid_str=tostring(marchguid)
return self.notDataMarchTeamList[marchguid_str]
end
end

function xianjieModel:isExistMatrchTeamData(marchtype,filter)
local lp=self.allMarchTeamDatas
if lp then
for marchguid_str,marchTeamData in pairs(lp)do
if marchtype==marchTeamData.marchtype and(filter==nil or filter(marchTeamData))then
return true
end
end
end
return false
end

function xianjieModel:findMatrchTeamData(marchtype,filter)
local list={}
local lp=self.allMarchTeamDatas
if lp then
for marchguid_str,marchTeamData in pairs(lp)do
if marchtype==marchTeamData.marchtype and(filter==nil or filter(marchTeamData))then
table.insert(list,marchTeamData)
end
end
end
return list
end

function xianjieModel:findMatrchTeamDataEx(marchtype,field)
local list={}
local lp=self.allMarchTeamDatas
if lp then
for marchguid_str,marchTeamData in pairs(lp)do
if marchtype==marchTeamData.marchtype then
if field==nil then
table.insert(list,marchTeamData)
else
local check=true
for i,v in pairs(field)do
if marchTeamData[i]~=v then
check=false
break
end
end
if check then
table.insert(list,marchTeamData)
end
end
end
end
end
return list
end


function xianjieModel:clearMarchTeamBehavior(marchguid,tree)
local teamData=self:getMarchTeamData(marchguid)
if teamData then
teamData:clearBehavior(tree)
end
end


function xianjieModel:clearMarchTeamBehaviorEx(marchguid)
local teamData=self:getMarchTeamData(marchguid)
if teamData then
teamData:clearBehaviorEx()
end
end

function xianjieModel:createMarchTeamBehavior(marchguid,isStart)
local teamData=self:getMarchTeamData(marchguid)
if teamData then
return teamData:createBehavior(nil,isStart)
end
end

function xianjieModel:createAllMarchTeamBehavior(sceneidx,isStart)
local lp=self.allMarchTeamDatas
if lp then
for marchguid_str,marchTeamData in pairs(lp)do
marchTeamData:createBehavior(sceneidx,isStart)
end
end
end

function xianjieModel.getMarchTeamHudSet(marchtype)
local typo=1
if marchtype==xjServerMarchType.eJiJieChuZheng then
typo=2
end
local modelsets=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'hudSet_team')
local modelset=modelsets[typo]or modelsets[1]
return modelset
end

local angleActionMap=
{
[-4]={eAnimationID.stand,true,false,"stand"},
[-3]={2113,true,false,"stand4"},
[-2]={eAnimationID.stand2,false,true,"stand2"},
[-1]={2113,false,false,"stand4"},
[0]={eAnimationID.stand,false,false,"stand"},
[1]={eAnimationID.stand3,false,false,"stand3,"},
[2]={eAnimationID.stand2,false,false,"stand2"},
[3]={eAnimationID.stand3,true,false,"stand3"},
[4]={eAnimationID.stand,true,false,"stand"},
}

function xianjieModel.getMarchTeamModelState(spos,epos)


local angle_deg=mathHelper.getAngleByPos(spos.x,spos.z,epos.x,epos.z)
local index=math.floor((angle_deg+22.5)/45)
local actionInfo=angleActionMap[index]
return actionInfo[1],actionInfo[2],actionInfo[3],angle_deg,index*45


















































end


function xianjieModel:getMarchSpeedEffect(speedcnt)
local accelerateeffect=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'accelerateeffect')
if self.initaccelerateeffect==nil then
if accelerateeffect and next(accelerateeffect)~=nil then
local min
local max
for k,v in pairs(accelerateeffect)do
if max==nil or max<k then
max=k
end
if min==nil or min>k then
min=k
end
end

local index
for i=min,max do
if accelerateeffect[i]==nil then
accelerateeffect[i]=accelerateeffect[index]
else
index=i
end
end
accelerateeffect.max=max
end
self.initaccelerateeffect=true
end
local max=accelerateeffect.max
local acceleratecnt=speedcnt-1
if acceleratecnt>=max then
return accelerateeffect[acceleratecnt]or accelerateeffect[max]
end
return accelerateeffect[acceleratecnt]
end

function xianjieModel:refreshAllMarchTeamModel()
local lp=self.allMarchTeamDatas
if lp then
for marchguid_str,marchTeamData in pairs(lp)do
local clickEntKey=marchTeamData:getTeamEnityKey()
xianjieController:invokeEntityFunc(clickEntKey,"refreshTeam")
end
end
end
