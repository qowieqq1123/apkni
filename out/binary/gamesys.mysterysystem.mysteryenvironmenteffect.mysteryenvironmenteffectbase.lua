






eEnvironmentEffect=
{
eHunt=1,
eHag=3,
eDust=4,
eBigFog=6,
eSilent=11,



eSkillRangeDouble=1001,
eViewAddTwo=1002,
}

mysteryEnvironmentEffectBase={}

function mysteryEnvironmentEffectBase.new(class)
local _clone={}
if class then
for i,v in pairs(class)do
_clone[i]=v
end
_clone._base=class

end
if class.environmentEffectType==nil then
logErr('没有传入类型 environmentEffectType')
end
local clone_mt={}
clone_mt.__index=mysteryEnvironmentEffectBase
setmetatable(_clone,clone_mt)
mysteryEnvironmentEffectController.bindClass(_clone)
return _clone
end

function mysteryEnvironmentEffectBase:setEnvironmentEffect(...)

end




mysteryEnvironmentEffectHunt=mysteryEnvironmentEffectBase.new({environmentEffectType=eEnvironmentEffect.eHunt})
function mysteryEnvironmentEffectHunt:setEnvironmentEffect(rstParam)

local roomId=mysteryRoomModel:get_cur_roomID()
mysteryTriggerLockPlayer.resultTargetPlayer(nil,nil,roomId,true)
end


mysteryEnvironmentEffectHag=mysteryEnvironmentEffectBase.new({environmentEffectType=eEnvironmentEffect.eHag})
function mysteryEnvironmentEffectHag:setEnvironmentEffect(rstParam)

MysteryModel:set_stop_surface(rstParam)
end


mysteryEnvironmentEffectDust=mysteryEnvironmentEffectBase.new({environmentEffectType=eEnvironmentEffect.eDust})
function mysteryEnvironmentEffectDust:setEnvironmentEffect(rstParam)

local view=rstParam and rstParam[1]or 1
MysteryModel:set_fog_view(view)
end


mysteryEnvironmentEffectBigFog=mysteryEnvironmentEffectBase.new({environmentEffectType=eEnvironmentEffect.eBigFog})
function mysteryEnvironmentEffectBigFog:setEnvironmentEffect(rstParam)

local view=rstParam and rstParam[1]or 1
MysteryModel:set_fog_view(view)
end


mysteryEnvironmentEffectSilent=mysteryEnvironmentEffectBase.new({environmentEffectType=eEnvironmentEffect.eSilent})
function mysteryEnvironmentEffectSilent:setEnvironmentEffect(rstParam)

mysterySkillModel:set_fb_probeSkill_silent(true)
end
