local _MODULENAME="worldDispatchFactory"
def_table(_MODULENAME)
worldDispatchFactory.name=_MODULENAME


worldDispatchFactory.flyMount=nil

worldDispatchFactory.tourHUD=13
worldDispatchFactory.fightEffect=20009
worldDispatchFactory.experienceSpeed=5
worldDispatchFactory.fadeDuration=0.3
worldDispatchFactory.fadeEffect=3

worldDispatchFactory.runWaitInterval=0.5
worldDispatchFactory.runEffect=20105
worldDispatchFactory.runAnimation=11

worldDispatchFactory.flyJumpDuration=0.4
worldDispatchFactory.flyJumpAnimation=2002
worldDispatchFactory.flyAnimation=eAnimationID.stand
worldDispatchFactory.flyShowInvertal=2
worldDispatchFactory.flyTeamOffsetUnit=1
worldDispatchFactory.flyTeamOffset={
[1]={Vector3.zero},
[2]={Vector3.zero,Vector3.New(-1,0,-1)},
[3]={Vector3.zero,Vector3.New(-1,0,-1),Vector3.New(-1,0,1)},
[4]={Vector3.zero,Vector3.New(-1,0,-1),Vector3.New(-1,0,1),Vector3.New(-2,0,-1)},
[5]={Vector3.zero,Vector3.New(-1,0,-1),Vector3.New(-1,0,1),Vector3.New(-2,0,-1),Vector3.New(-2,0,1)},
}

local _specialMoveType={
[eWorldUnitTpye.SYSTEMZM]=function(id,guid)
return id>0 and eWorldTripType.Fake or nil
end
}

local _category={
[eWorldTripType.Fake]={

[eWorldUnitTpye.MYSTERY]=function(id,guid)
return worldDispatchTask_ZongMen_Mystery.New()
end,

[eWorldUnitTpye.HUNTMONSTERTEAM]=function(id,guid)
return worldDispatchTask_HuntMonsterTeam.New()
end,
[eWorldUnitTpye.SYSTEMZM]=function(id,guid)
if id==0 then
return worldDispatchTask_Fake.New()
else
return worldDispatchTask_SystemZongMenAttack.New()
end
end,
},
[eWorldTripType.Run]={

[eWorldUnitTpye.EXPERIENCE]=function(id,guid)
return worldDispatchTask_Run_Experience.New()
end,

[eWorldUnitTpye.MYSTERY]=function(id,guid)
return worldDispatchTask_Run_Mystery.New()
end,

[eWorldUnitTpye.MONSTER]=function(id,guid)
return worldDispatchTask_Run_Monster.New()
end,

[eWorldUnitTpye.RESPOINT]=function(id,guid)
return worldDispatchTask_Run_ResPointMonster.New()
end,

[eWorldUnitTpye.FAMILY]=function(id,guid)
return worldDispatchTask_Run_Family.New()
end,

[eWorldUnitTpye.TOURPOINT]=function(id,guid)
return worldDispatchTask_Run_Tour.New()
end,

[eWorldUnitTpye.SYSTEMZM]=function(id,guid)
return worldDispatchTask_Run_SystemZongMen.New()
end,
[eWorldUnitTpye.RESMYSTERY]=function(id,guid)
return worldDispatchTask_Run_Mystery.New()
end,
[eWorldUnitTpye.HUNTMONSTERTEAM]=function(id,guid)
return worldDispatchTask_Run_HuntMonsterTeam.New()
end,
},
[eWorldTripType.Fly]={

[eWorldUnitTpye.EXPERIENCE]=function(id,guid)
return worldDispatchTask_Fly_Experience.New()
end,

[eWorldUnitTpye.MYSTERY]=function(id,guid)
return worldDispatchTask_Fly_Mystery.New()
end,

[eWorldUnitTpye.MONSTER]=function(id,guid)
return worldDispatchTask_Fly_Monster.New()
end,

[eWorldUnitTpye.RESPOINT]=function(id,guid)
return worldDispatchTask_Fly_ResPointMonster.New()
end,

[eWorldUnitTpye.FAMILY]=function(id,guid)
return worldDispatchTask_Fly_Family.New()
end,

[eWorldUnitTpye.TOURPOINT]=function(id,guid)
return worldDispatchTask_Fly_Tour.New()
end,

[eWorldUnitTpye.SYSTEMZM]=function(id,guid)
return worldDispatchTask_Fly_SystemZongMen.New()
end,
[eWorldUnitTpye.RESMYSTERY]=function(id,guid)
return worldDispatchTask_Fly_Mystery.New()
end,
[eWorldUnitTpye.HUNTMONSTERTEAM]=function(id,guid)
return worldDispatchTask_Fly_HuntMonsterTeam.New()
end
},
}

local _speed={
[eWorldTripType.Run]=2,
[eWorldTripType.Fly]=4,
[eWorldTripType.Fake]=0,
}

local _path={
[eWorldTripType.Run]=function(dest,orig,world)
if dest==orig then
loggerUtil.logErrFMT("路径相同的起始点和终止点 {0}, {1}",tostring(orig),tostring(dest))
end
local e={dest.x,dest.y}
local ePos,eBlock=worldPositionConfig:getPosition(world,e)
orig=orig or worldController:getMainCityPoint(world,eBlock)
local s={orig.x,orig.y}
local sPos=worldPositionConfig:getPosition(world,s)
local cslist=worldController:calculateNavPathEx(sPos,ePos)
if cslist==nil then
loggerUtil.logErrFMT("无效路径相同的起始点和终止点 {0}, {1}",tostring(orig),tostring(dest))
end
local temp={}
for i=0,cslist.Length-1 do
table.insert(temp,cslist[i])
end
return temp
end,
[eWorldTripType.Fly]=function(dest,orig,world)
local e={dest.x,dest.y}
local ePos,eBlock=worldPositionConfig:getPosition(world,e)
local s=orig or worldController:getMainCityPoint(world,eBlock)
s={s.x,s.y}
local sPos=worldPositionConfig:getPosition(world,s)
if not sPos or not ePos then

end
return{sPos,ePos}
end,
}

local _distance={
[eWorldTripType.Run]=function(s,e)
return Vector3.Distance(s,e)
end,
[eWorldTripType.Fly]=function(s,e)

local hS=Vector2.New(s.x,s.z)
local hE=Vector2.New(e.x,e.z)
return Vector2.Distance(hS,hE)
end,
}

local _duration={
[eWorldTripType.Run]=function(moveDuration,discipleCnt)
return moveDuration+(discipleCnt+1)*worldDispatchFactory.runWaitInterval
end,
[eWorldTripType.Fly]=function(moveDuration,discipleCnt)
return moveDuration+(math.floor(discipleCnt/worldDispatchFactory.flyShowInvertal)+1)*worldDispatchFactory.flyJumpDuration+worldDispatchFactory.fadeDuration
end,
}

local _key={
[eWorldUnitTpye.MYSTERY]=function(targetType,targetGuid,targetId)
return worldModel:convertUnitKey({eWorldUnitTpye.MYSTERY,targetId})
end,
[eWorldUnitTpye.MONSTER]=function(targetType,targetGuid,targetId)
return worldModel:convertUnitKey({eWorldUnitTpye.MONSTER,tostring(targetGuid)})
end,
[eWorldUnitTpye.RESPOINT]=function(targetType,targetGuid,targetId)
return worldResPointBaseModel:convertUnitKey(targetGuid,targetId)
end,
[eWorldUnitTpye.FAMILY]=function(targetType,targetGuid,targetId)
return worldXiuZhenJiaZuModel:convertKey(targetGuid)
end,
[eWorldUnitTpye.EXPERIENCE]=function(targetType,targetGuid,targetId)
return worldModel:convertUnitKey({eWorldUnitTpye.EXPERIENCE,targetId})
end,
[eWorldUnitTpye.TOURPOINT]=function(targetType,targetGuid,targetId)
return chuanSongZhenModel:getTaskTarget(targetId,targetGuid)
end,
[eWorldUnitTpye.SYSTEMZM]=function(targetType,targetGuid,targetId)
return systemZongMenModel:convertUnitKey(targetGuid)
end,
[eWorldUnitTpye.RESMYSTERY]=function(targetType,targetGuid,targetId)
return worldModel:convertUnitKey({eWorldUnitTpye.RESMYSTERY,targetId})
end,
[eWorldUnitTpye.HUNTMONSTERTEAM]=function(targetType,targetGuid,targetId)
return worldModel:convertUnitKey({eWorldUnitTpye.HUNTMONSTERTEAM,targetId})
end,
}

local _checkTarget={
[eWorldUnitTpye.MYSTERY]=function(targetType,targetGuid,targetId)
local typo=MysteryModel:get_mystery_sence_type(targetId)
if typo==MysterySenceType.World then
local data=MysteryModel:get_mysteryFB_unit(targetId)
return data~=nil
elseif typo==MysterySenceType.ResPoint then
local data,guid,subIdx=worldResPointDataModel:findMysteryData(targetId)
local position=worldResPointDataModel:getSubPointPos(guid,subIdx)
return position~=nil
elseif typo==MysterySenceType.ZiYuan then
local data=mysteryZiYuanFuBenModel:getZiYuanGroupByFbid(targetId)
return data~=nil
end
return false
end,
[eWorldUnitTpye.MONSTER]=function(targetType,targetGuid,targetId)
local monster=worldMonsterModel:get_monster(targetGuid)
return monster~=nil
end,
[eWorldUnitTpye.RESPOINT]=function(targetType,targetGuid,targetId)
local data=worldResPointDataModel:getPointData(targetGuid)
local position=worldResPointDataModel:getSubPointPos(targetGuid,targetId)

return position~=nil
end,
[eWorldUnitTpye.FAMILY]=function(targetType,targetGuid,targetId)
local data=worldXiuZhenJiaZuModel:getFamilyDataByGuid(targetGuid)
return data~=nil
end,
[eWorldUnitTpye.EXPERIENCE]=function(targetType,targetGuid,targetId)
return true
end,
[eWorldUnitTpye.TOURPOINT]=function(targetType,targetGuid,targetId)
return true
end,
[eWorldUnitTpye.SYSTEMZM]=function(targetType,targetGuid,targetId)
local data=systemZongMenModel:getInfoData(targetGuid)
return data~=nil
end,
[eWorldUnitTpye.RESMYSTERY]=function(targetType,targetGuid,targetId)
local data=mysteryZiYuanFuBenModel:get_mysteryFB_group_unit(targetId)
return data~=nil
end,
[eWorldUnitTpye.HUNTMONSTERTEAM]=function(targetType,targetGuid,targetId)
return true
end,
}

function worldDispatchFactory:onAppStart()
self.flyMount=cfgHelper.get3(cfg_worldglobalconfig_get,"taskDiscipleCloud","value",1)
end

function worldDispatchFactory:getCategory(moveType,unitType,id,guid)
return _category[moveType][unitType](id,guid)
end

function worldDispatchFactory:getSpeed(moveType)
return _speed[moveType]
end

function worldDispatchFactory:getUnitKey(targetType,targetGuid,targetId)
if _key[targetType]then
return _key[targetType](targetType,targetGuid,targetId)
end
end

function worldDispatchFactory:checkTargetData(targetType,targetGuid,targetId)
if _checkTarget[targetType]then
return _checkTarget[targetType](targetType,targetGuid,targetId)
end
end



function worldDispatchFactory:packTask(serverData)
local task=self:getCategory(serverData.task_type,serverData.aim_type,serverData.aim_id,serverData.aim_guid)
task.id=serverData.key
task.world=serverData.world_id
task.target_type=serverData.aim_type
task.target_id=serverData.aim_id
task.target_guid=serverData.aim_guid
task.x=serverData.x
task.z=serverData.y
task.mode=serverData.task_type
task.team=serverData.guidList
task.zhenfa_id=serverData.zhenfa_id
task.progress_begin=serverData.begin_time
task.progress_end=serverData.end_time
task.trip_duration=serverData.need_time
task.progress_state=serverData.dispatch_state

task.speed=self:getSpeed(task.mode)
task.destination=Vector2.New(task.x/100,task.z/100)
task.target_key=self:getUnitKey(task.target_type,task.target_guid,task.target_id)
task.show=false
task:refreshDisclples()

if task.show then

task:path()
end
task:express()

task.state=eWorldTripState.Running
return task
end



function worldDispatchFactory:createTask(targetType,targetGuid,targetId,team,zfId)

local targetKey=self:getUnitKey(targetType,targetGuid,targetId)
local targetType=targetType
local targetId=targetId
local moveType=self:getSpecialMoveType(targetType,targetGuid,targetId)or self:getMoveType(team)
local taskKey=worldTaskModel:findNextKey()
local destVec2,world=worldTaskModel:getTaskTargetPoint(targetType,targetGuid,targetId)

local task=self:getCategory(moveType,targetType,targetId,targetGuid)

task.id=taskKey
task.world=world
task.target_type=targetType
task.target_id=targetId
task.target_guid=targetGuid
task.x=math.floor(destVec2.x*100)
task.z=math.floor(destVec2.y*100)
task.mode=moveType
task.team=team
task.zhenfa_id=zfId





task.speed=self:getSpeed(task.mode)
task.destination=destVec2
task.target_key=targetKey
task.show=false

task:refreshDisclples()
task:path()
task:express()
task:init()

task.state=eWorldTripState.Unplayed

return task
end

function worldDispatchFactory:unpackTask(dispatch)
local data={
dispatch.id,
dispatch.world,
dispatch.target_type,
dispatch.target_id,
dispatch.x,
dispatch.z,
dispatch.mode,
#dispatch.team,
dispatch.team,
dispatch.zhenfa_id,
dispatch.progress_begin,
dispatch.progress_end,
dispatch.trip_duration,
dispatch.progress_state,
dispatch.target_guid,
}

return data
end

function worldDispatchFactory:getMoveType(team)
local info=cfgHelper.get2(cfg_worldglobalconfig_get,"taskFlyRequirements","value")
local level=info[1]
local pos=info[2]
for i,v in ipairs(team)do
if v>int64.zero then
local discipleData=UIDiscipleModel:getDiscipleData(v)
local jjlv=discipleData.jingjielv
local zmPos=UIDiscipleModel:getDisciplePost(v)
if jjlv>=level and zmPos<=pos then
return eWorldTripType.Fly
end
end
end
return eWorldTripType.Run
end

function worldDispatchFactory:getSpecialMoveType(unitType,guid,id)
local check=_specialMoveType[unitType]
return check and check(id,guid)or nil
end

function worldDispatchFactory:getPathCorners(typo,e,s,world)
return _path[typo](e,s,world)
end

function worldDispatchFactory:getDistance(typo,corners)
local length=0
for i=1,#corners-1 do
local temp=_distance[typo](corners[i],corners[i+1])
length=length+temp
end
return length
end

function worldDispatchFactory:getDuration(typo,corners,speed)
local length=self:getDistance(typo,corners)
local speed=speed or self:getSpeed(typo)
local duration=length/speed
return duration
end

function worldDispatchFactory:getTripDuration(typo,moveDuration,discipleCnt)
local duration=_duration[typo](moveDuration,discipleCnt)
return math.ceil(duration)
end

function worldDispatchFactory:getFlyMount(discipleguid)
local mountParam=mountHelper.getMountModelParams(discipleguid)
if mountParam then
return mountParam.model
end
local post=UIDiscipleModel:getDisciplePost(discipleguid)
local mount=cfgHelper.get2(cfg_guildposconfig_get,post,'flymount')
local mount_body=cfgHelper.get2(cfg_disciplepostflyconfig_get,mount,"mount_body")
return mount_body or self.flyMount
end

function worldDispatchFactory:getFlyAnim(discipleguid)
local anim=mountHelper.getMountAniByDZ(discipleguid,self.flyAnimation)
return anim
end

function worldDispatchFactory:getFlyMountOffset(discipleguid)
local flyId=mountHelper.getFlyMountId(discipleguid)
if not flyId then
flyId=UIDiscipleModel:getDisciplePost(discipleguid)
end
local config=cfgHelper.get1(cfg_disciplepostflyconfig_get,flyId)
if config and config.offset2 then
return mathHelper.convertArrayToVector(config.offset2)
end
end
