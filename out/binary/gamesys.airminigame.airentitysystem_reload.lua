

local _srcPath='lua.gamesys.airminigame.entity'

local entity_creator=
{

[eAirEntityType.TYPE_ROLE]={creator='role'},

[eAirEntityType.TYPE_MONSTER]={creator='monster',},

[eAirEntityType.TYPE_SKILL]={creator='skill',},

[eAirEntityType.TYPE_MONSTER_SKILL]={creator='skill',},

[eAirEntityType.TYPE_DROP]={creator='drop',},

[eAirEntityType.TYPE_BULLET]={creator='bullet',},

[eAirEntityType.TYPE_NPC]={creator='npc',},

[eAirEntityType.TYPE_PET]={creator='pet',},

[eAirEntityType.TYPE_HALO]={creator='halo',},

[eAirEntityType.TYPE_SUMMON]={creator='summon',},

[eAirEntityType.TYPE_COLLECTABLE]={creator='collectable',},

[eAirEntityType.TYPE_BUILDING]={creator='building',},

[eAirEntityType.TYPE_TELEPORT]={creator='teleport',},

[eAirEntityType.TYPE_MONSTER_ELITE]={creator='monster',},

[eAirEntityType.TYPE_MONSTER_BOSS]={creator='monster',},

[eAirEntityType.TYPE_WEAPON]={creator='weapon',},

[eAirEntityType.TYPE_OTHER]={creator='other',},

[eAirEntityType.TYPE_MONSTER_DEAD]={creator='deadSkill',},

[eAirEntityType.TYPE_TOWER]={creator='tower',},

[eAirEntityType.TYPE_MONSTER_NEUTRAL]={creator='monster',},

[eAirEntityType.TYPE_TRAP]={creator='trap',},

[eAirEntityType.TYPE_ENTITY_REPLACE]={creator='replaceEntity',},

}

local other_entity_creator=
{
[eAirOtherEntityType.eMonsterMask]={creator='monsterMask',},
[eAirOtherEntityType.eHarm]={creator='harm',},
}

local _skillSrcPath='lua.gamesys.airminigame.entity.skill'
local entity_skill_creator=
{

[eAirSkillEntityType.eCommon]={creator='skill',},
[eAirSkillEntityType.eShot]={creator='shotSkill',},
[eAirSkillEntityType.eKuoSan]={creator='kuosanSkill',},
[eAirSkillEntityType.eRoundTrip]={creator='roundTripSkill',},
[eAirSkillEntityType.eRoundTrip2]={creator='roundTrip2Skill',},
[eAirSkillEntityType.eFan]={creator='fanSkill',},
[eAirSkillEntityType.eJianXiuShot]={creator='jianxiuShotSkill',},
[eAirSkillEntityType.eSkillRange]={creator='skillRangeCheck'},
[eAirSkillEntityType.eTargetRoundSkill]={creator='targetRoundSkill'}
}









local _ctor={}


local function _PreloadCtor(typo)

local info=entity_creator[typo]
assert(info,string.format('没找到typo为%d的实体脚本',typo))
local creator=info.creator
local ctor=_ctor[creator]
if _ctor[creator]==nil then
local src=string.format('%s.%s',_srcPath,creator)
require(src)
ctor=_G[info.creator]
_ctor[info.creator]=ctor
end
info.ctor=ctor
end


local function _PreloadOtherCtor(typo)

local info=other_entity_creator[typo]
assert(info,string.format('没找到typo为%d的实体脚本',typo))
local creator=info.creator
local ctor=_ctor[creator]
if _ctor[creator]==nil then
local src=string.format('%s.%s',_srcPath,creator)
require(src)
ctor=_G[info.creator]
_ctor[info.creator]=ctor
end
info.ctor=ctor
end


local function _PreloadSkillCtor(typo)

local info=entity_skill_creator[typo]
assert(info,string.format('没找到typo为%d的技能脚本',typo))
local creator=info.creator
local ctor=_ctor[creator]
if _ctor[creator]==nil then
local src=string.format('%s.%s',_skillSrcPath,creator)
require(src)
ctor=_G[info.creator]
_ctor[info.creator]=ctor
end
info.ctor=ctor
end


local function _PreloadSkillSlotCtor(typo)

local info=entity_skillSlot_creator[typo]
assert(info,string.format('没找到typo为%d的技能插槽脚本',typo))
local creator=info.creator
local ctor=_ctor[creator]
if _ctor[creator]==nil then
local src=string.format('%s.%s',_skillSlotSrcPath,creator)
require(src)
ctor=_G[info.creator]
_ctor[info.creator]=ctor
end
info.ctor=ctor
end


function airEntitySystem:preloadEntity(entityType)
_PreloadCtor(entityType)
end

function airEntitySystem:preloadOtherEntity(otherType)
_PreloadOtherCtor(otherType)
end

function airEntitySystem:getEntityInfo(entityType)
return entity_creator[entityType]
end

function airEntitySystem:getOtherEntityCtor(otherType)
return other_entity_creator[otherType]
end

function airEntitySystem:preloadSkill(behavourType)
_PreloadSkillCtor(behavourType)
end

function airEntitySystem:getSkillInfo(behavourType)
return entity_skill_creator[behavourType]
end







