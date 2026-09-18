local _battle=nil

function worldExperienceModel:setBattle(battle)
_battle=battle
end

function worldExperienceModel:checkBattle(battle)
return _battle==battle
end

function worldExperienceModel:afterFakeBattle(battle,point)
self:afterContentProgress()
end

function worldExperienceModel:isBattlePlaying()
return _battle~=nil
end

function worldExperienceModel:getBattle()
return _battle
end