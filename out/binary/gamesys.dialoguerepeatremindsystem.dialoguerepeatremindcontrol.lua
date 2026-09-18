dialogueRepeatRemindControl=gameState.addListener({})



function dialogueRepeatRemindControl:onAppStart()

end

function dialogueRepeatRemindControl:onEnterState()
dialogueRepeatRemindModel.onEnter()
end

function dialogueRepeatRemindControl:onLeaveState()
dialogueRepeatRemindModel.reset()
end


