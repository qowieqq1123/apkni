






local _MODULENAME="worldExperienceModel"




def_table(_MODULENAME)
worldExperienceModel.name=_MODULENAME


eExperiencePonitType={
EMPTY=0,
FIGHT=1,
EVENT=2,
REWARD=3,
MYSTERY=4,
FAKEBATTLE=5,
DISCIPLE=6
}

eExperiencePonitState={
Init=0,
PreStory=1,
Content=2,
PostStory=3,
Finish=4,
}


function worldExperienceModel:onAppStart()

end


function worldExperienceModel:onEnterState()

end


function worldExperienceModel:onLeaveState(isReconnet)



self:setBattle()
if not isReconnet then
self:outScene()
end
end


function worldExperienceModel:onServerDataInitFinish()

end





function worldExperienceModel:convertTaskTargetKey(world,block)
local cfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
return worldModel:convertUnitKey({eWorldUnitTpye.EXPERIENCE,cfg.fog2})
end




function worldExperienceModel:getPointKey(id)
return worldModel:convertUnitKey({eWorldUnitTpye.EXPERIENCE,id})
end






function worldExperienceModel:getPathKey(sId,eId,index)
return worldModel:convertUnitKey({worldModel.UNITTYPE.EXPERIENCE,sId,eId,index})
end



function worldExperienceModel:getDiscipleKey()
return worldModel:convertUnitKey({worldModel.UNITTYPE.EXPERIENCE,0})
end




function worldExperienceModel:getFollowerKey(index)
return worldModel:convertUnitKey({worldModel.UNITTYPE.EXPERIENCE,-index})
end