






eMysteryDiscipleEffect=
{

eExploreRangeDouble=1,
eViewAddTwo=2,
eHideAdd=3,
eFindHidden=5,
}


eMysteryDiscipleMEEffect=
{
[eMysteryDiscipleEffect.eExploreRangeDouble]=true,
[eMysteryDiscipleEffect.eViewAddTwo]=true,
[eMysteryDiscipleEffect.eHideAdd]=true,
}

mysteryDiscipleEffectBase={}

function mysteryDiscipleEffectBase.new(class)
local _clone={}
if class then
for i,v in pairs(class)do
_clone[i]=v
end
_clone._base=class

end
if class.discipleEffect==nil then
logErr('没有传入类型 discipleEffectType')
end
local clone_mt={}
clone_mt.__index=mysteryDiscipleEffectBase
setmetatable(_clone,clone_mt)
mysteryDiscipleEffectController.bindClass(_clone)
return _clone
end

function mysteryDiscipleEffectBase:setDiscipleEffect(...)

end




mysteryDiscipleEffectExploreRangeDouble=mysteryDiscipleEffectBase.new({discipleEffect=eMysteryDiscipleEffect.eExploreRangeDouble})
function mysteryDiscipleEffectExploreRangeDouble:setDiscipleEffect(guid,rstParam)
local num=rstParam or 0
mysteryDiscipleEffectModel:add_skill_explore_range(guid,num)
end


mysteryDiscipleEffectSkillViewAddTwo=mysteryDiscipleEffectBase.new({discipleEffect=eMysteryDiscipleEffect.eViewAddTwo})
function mysteryDiscipleEffectSkillViewAddTwo:setDiscipleEffect(guid,rstParam)
local view=rstParam or 0
mysteryDiscipleEffectModel:set_fog_add_view(guid,view)
end


mysteryDiscipleEffectSkillHideAdd=mysteryDiscipleEffectBase.new({discipleEffect=eMysteryDiscipleEffect.eHideAdd})
function mysteryDiscipleEffectSkillHideAdd:setDiscipleEffect(guid,rstParam)
local num=rstParam or 0
mysteryDiscipleEffectModel:add_hide_step(guid,num)
end


mysteryDiscipleEffectSkillFindHidden=mysteryDiscipleEffectBase.new({discipleEffect=eMysteryDiscipleEffect.eFindHidden})
function mysteryDiscipleEffectSkillFindHidden:setDiscipleEffect(guid,rstParam)
local args=rstParam
args.guid=guid
mysteryDiscipleEffectModel:set_find_hidden_args(guid,rstParam)
end
