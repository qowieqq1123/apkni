







local _MODULENAME="skillController"
gameState.addListener(def_table(_MODULENAME))
skillController.name=_MODULENAME

function skillController:onAppStart()
end

function skillController:onEnterState()
end

function skillController:onLeaveState()
skillModel:clearSkillLvPlusLookup()
end

function skillController:onPlayerCreate(...)
end

function skillController:onLostConnection()
end