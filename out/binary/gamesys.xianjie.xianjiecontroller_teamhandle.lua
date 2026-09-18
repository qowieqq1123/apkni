







xjTeamHandleConfig={
[xjTeamHandleType.eSearchTeam]='xjTeamHandle_search',
[xjTeamHandleType.ePlotTeam]='xjTeamHandle_plot',
[xjTeamHandleType.eMarchKill]='xjTeamHandle_marchkill',
[xjTeamHandleType.eMarchSpy]='xjTeamHandle_marchSpy',
[xjTeamHandleType.eMarchStation]='xjTeamHandle_marchStation',
[xjTeamHandleType.eMarchBack]='xjTeamHandle_marchBack',
[xjTeamHandleType.ePlotTeamReract]='xjTeamHandle_plotRetract',
[xjTeamHandleType.eMarchYuanZhu]='xjTeamHandle_marchYuanZhu',
[xjTeamHandleType.eResPointTeam]='xjTeamHandle_respointTeam',
[xjTeamHandleType.eResPointReract]='xjTeamHandle_respointRetract',
[xjTeamHandleType.eJiJieWait]='xjTeamHandle_jiJieWait',
[xjTeamHandleType.eJiJieJoin]='xjTeamHandle_jiJieJoin',
[xjTeamHandleType.eJiJieChuZheng]='xjTeamHandle_jiJieChuZheng',
[xjTeamHandleType.eAttackRole]='xjTeamHandle_AttackRole',
[xjTeamHandleType.eStationTeam]='xjTeamHandle_stationTeam',
[xjTeamHandleType.eCarryRepair]='xjTeamHandle_carryRepair',
[xjTeamHandleType.eArenaZhuJun]='xjTeamHandle_arenaZhuJun',
[xjTeamHandleType.eNotDataMarchTeam]='xjTeamHandle_notDataMarchTeam',
[xjTeamHandleType.eMoGongZhuJun]='xjTeamHandle_moGongZhuJun',
[xjTeamHandleType.eMoZongAttack]='xjTeamHandle_moZongAttack',
[xjTeamHandleType.eMoZongBack]='xjTeamHandle_moZongBack',
[xjTeamHandleType.eMoJingZhenJi_Origin]='xjTeamHandle_benYuanZhenJi',
[xjTeamHandleType.eDefendXianMeng]='xjTeamHandle_DefendXianMeng',
[xjTeamHandleType.eAttackXianMeng]='xjTeamHandle_AttackXianMeng',
[xjTeamHandleType.eMoJunYaoMo]='xjTeamHandle_moJunYaoMo',
[xjTeamHandleType.eMoJunFenShenAttack]='xjTeamHandle_moJunFenShenAttack',
[xjTeamHandleType.eDefendXianMengStation]='xjTeamHandle_DefendXianMengStation',
[xjTeamHandleType.eMarchMJSLDebuffAdd]='xjTeamHandle_marchMJSLBuffAdd',
[xjTeamHandleType.eMarchMJBoxCJ]='xjTeamHandle_marchMJBox',
[xjTeamHandleType.eAttackMoJun]='xjTeamHandle_AttackMoJun',
[xjTeamHandleType.eMoJunBoxTeam]='xjTeamHandle_MoJunBoxTeam',
[xjTeamHandleType.eMoGongBuffZhuJunTeam]='xjTeamHandle_MoGongBuffTeam',
[xjTeamHandleType.eMoGongBuffMarchTeam]='xjTeamHandle_MoGongBuffMarchTeam',
[xjTeamHandleType.eZhenYanAttack]='xjTeamHandle_zhenYanAttack',
[xjTeamHandleType.eZhenYanBack]='xjTeamHandle_zhenYanBack',
[xjTeamHandleType.eLingShouAttack]='xjTeamHandle_lingshouAttack',
[xjTeamHandleType.eLingShouGroupAttack]='xjTeamHandle_lingshouGroupAttack',
}

local teamDataLookup={}
local teamDataKeyLookup={}

function xianjieController:getXJTeamHandle(mID)
if mID==nil then return end
return teamDataLookup[mID]
end

function xianjieController:getXJTeamHandleByKey(onlykey)
if onlykey==nil then return end
return teamDataKeyLookup[onlykey]
end

function xianjieController:addXJTeamHandle(teamType,data)
local obj=new_xjTeamHandle(teamType,data)
local mID=obj.m_ID
assert(teamDataLookup[mID]==nil)
teamDataLookup[mID]=obj
local onlykey=obj.onlykey
assert(teamDataKeyLookup[onlykey]==nil)
teamDataKeyLookup[onlykey]=obj
return mID
end

function xianjieController:removeXJTeamHandle(mID)
if mID==nil then return end
local obj=xianjieController:getXJTeamHandle(mID)
if obj then
local onlykey=obj.onlykey
release_xjTeamHandle(obj)
teamDataLookup[mID]=nil
teamDataKeyLookup[onlykey]=nil
end
end

function xianjieController:invokeXJTeamHandleFunc(mID,funcName,...)
if mID==nil then return end
local data=xianjieController:getXJTeamHandle(mID)
if data then
local f=data[funcName]
if f~=nil then
return f(data,...)
end
end
end