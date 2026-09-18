fightActionMrg={}

local action_Creator={}
local obj_pool={}
local is_init=false

function fightActionMrg:init()
if is_init==false then
is_init=true
self:registryAction(fightActionType.CAST_SKILL,fightSkillAction)
self:registryAction(fightActionType.ADD_BUFF,fightAddBuffAction)
self:registryAction(fightActionType.CHANGE_HP,fightChangeHpAction)
self:registryAction(fightActionType.DISPEL_BUFF,fightDispelBuffAction)
self:registryAction(fightActionType.SKILL_DODGE,fightSkillDodgeAction)
self:registryAction(fightActionType.BUFF_EFFECT,fightBuffAction)
self:registryAction(fightActionType.DEL_BUFF_EFFECT,fightDelBuffEffectAction)



self:registryAction(fightActionType.ACTION_START,fightActionStartAction)
self:registryAction(fightActionType.ACTION_END,fightActionEndAction)
self:registryAction(fightActionType.DISPEL_BUFF_EFFECT,fightDispelBuffEffectAction)
self:registryAction(fightActionType.DELETE_BUFF,fightDeleteBuffAction)
self:registryAction(fightActionType.REBOUND,fightReboundAction)
self:registryAction(fightActionType.RESURRECTION,fightResurrectionAction)
self:registryAction(fightActionType.GM,fightGMAction)
self:registryAction(fightActionType.NEW_MON,fightNewMonAction)
self:registryAction(fightActionType.CHANGE_PROP,fightChangePropAction)
self:registryAction(fightActionType.HALO_LIST,fightHaloListAction)
self:registryAction(fightActionType.SKILL_SHOW,fightSkillShowAction)
self:registryAction(fightActionType.UNITE_ATTACK,fightUniteAttackAction)
self:registryAction(fightActionType.CLIENT_SKILL_ACTION,fightSkillActionAction)
self:registryAction(fightActionType.CLIENT_SKILL_ACTION_TARGET,fightSkillActionTargetAction)
self:registryAction(fightActionType.CAST_Move_Target_SKILL,fightMoveTargetsSkillAction)
self:registryAction(fightActionType.AIM_ATTACK,fightAimAttackAction)
self:registryAction(fightActionType.LJD_CHANGE,fightCounterChangeAction)
self:registryAction(fightActionType.TEAM_SHIELD_CHANGE,fightTeamShieldAction)
self:registryAction(fightActionType.CLIENT_JUN_ZHEN_ACTION,fightJunZhenAction)

self:registryAction(fightActionType.FIGHT_LOG_CARD_CHANGE,fightCardChangeAction)
self:registryAction(fightActionType.FIGHT_LOG_CARD_GP,fightCardGPAction)
end
end


function fightActionMrg:registryAction(typo,creator)
if action_Creator[typo]==nil then
action_Creator[typo]=creator
obj_pool[typo]={}
else
logErr(FMT.fmt("重复注册Action:{0}",typo))
end
end


function fightActionMrg:getAction(typo)
local objPoolArray=obj_pool[typo]
local len=#objPoolArray
if len>0 then
local obj=objPoolArray[len]
objPoolArray[len]=nil
return obj
end

local creator=action_Creator[typo]
if creator~=nil then
return creator()
else
logErr(FMT.fmt("不存在战报类型{0}对应Action",typo))
end
end

function fightActionMrg:recycleAction(obj)

local typo=obj:getTypo()
local objArray=obj_pool[typo]
if objArray~=nil then
objArray[#objArray+1]=obj
else
logErr(FMT.fmt("不存在战报类型{0}对应Action 可以存入池",typo))
end
end

