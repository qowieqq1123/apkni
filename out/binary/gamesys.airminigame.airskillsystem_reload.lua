
local _srcPath='lua.gamesys.airminigame.command'
local skill_creator=
{

[eAirSkillBehavourType.eBase]={creator='airSkillAction',},
[eAirSkillBehavourType.eShot]={creator='airShotSkillAction',},
[eAirSkillBehavourType.eMove]={creator='airMoveSkillAction',},
[eAirSkillBehavourType.eBaWangQiang]={creator='airBaWangQiangSkillAction',},
[eAirSkillBehavourType.eXueYinDao]={creator='airXueYinDaoSkillAction',},
[eAirSkillBehavourType.ePanGuanBi]={creator='airPanGuanBiSkillAction',},
[eAirSkillBehavourType.eQingYunShan]={creator='airQingYunShanSkillAction',},
[eAirSkillBehavourType.eQianKunZhu]={creator='airQianKunZhuSkillAction',},
[eAirSkillBehavourType.eWanDuFan]={creator='airWanDuFanSkillAction',},
[eAirSkillBehavourType.eJianXiu]={creator='airJianXiuSkillAction',},
[eAirSkillBehavourType.eEffect]={creator='airPlayEffectAction',},
[eAirSkillBehavourType.eHalo]={creator='airHaloAction',},
[eAirSkillBehavourType.eDeadSkill]={creator='airDeadSkillAction',},
[eAirSkillBehavourType.eCreateMon]={creator='airCreateMonAction',},
[eAirSkillBehavourType.eMoveToTarget]={creator='airMoveToTargetSkillAction',},
[eAirSkillBehavourType.eRangeArea]={creator='airRangeAreaAction',},
[eAirSkillBehavourType.eCreateEnt]={creator='airCreateEntAction',},
[eAirSkillBehavourType.eCastSkillProbabilty]={creator='airCastSkillProbabiltyAction',},

}


local _ctor={}


local function _PreloadCtor(typo)

local info=skill_creator[typo]
assert(info,string.format('没找到typo为%d的技能脚本',typo))
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


function airSkillSystem:preloadAction(type)
_PreloadCtor(type)
end

function airSkillSystem:getActionInfo(type)
local creator=skill_creator[type].creator
return _G[creator]
end