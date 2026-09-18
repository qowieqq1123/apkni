







local _MODULENAME="friendController"
gameState.addListener(def_table(_MODULENAME))
friendController.name=_MODULENAME



function friendController:onAppStart()
end

function friendController:onEnterState()
friendModel:init_data()
end

function friendController:onLeaveState()
end



function friendController:showMainUI()


UIFullFriendMainControl:showWindowList()

end

function friendController:closeMainUI()
baseFullScreenUI:openMain(true)
UIManager:hideWindow('UIFriendWin')
UIManager:closeWindow('UIMoneyPanel')

UIManager:closeWindow("UIFriendListWin")
UIManager:closeWindow("UIFriendAddWin")
UIManager:closeWindow("UIFriendApplyWin")
end




function friendController:hasReddot()
return friendModel:hasApply()or friendModel:hasSub1Reddot()
end

