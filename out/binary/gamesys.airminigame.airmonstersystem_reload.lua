
require'lua.gamesys.airminigame.AI.monsterAI'
local _srcPath='lua.gamesys.airminigame.AI'
local _creator=
{

[eAirMonsterAiType.eMelee]={creator='meleeAI',},
[eAirMonsterAiType.eRanged]={creator='rangeAI',},
[eAirMonsterAiType.eRoaming]={creator='roamingAI',},
[eAirMonsterAiType.eNeutral]={creator='monsterAI',},
}


local _ctor={}


local function _PreloadCtor(typo)

local info=_creator[typo]
assert(info,string.format('没找到typo为%d的ai脚本',typo))
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


function airMonsterSystem:preloadAI(type)
_PreloadCtor(type)
end

function airMonsterSystem:getAIInfo(type)
local creator=_creator[type].creator
return _G[creator]
end