lingshouSelectController=gameState.addListener({})

function lingshouSelectController:onAppStart()
end

function lingshouSelectController:onEnterState()
end

function lingshouSelectController:onLeaveState()
end

function lingshouSelectController:onPlayerCreate(...)
end

function lingshouSelectController:onLostConnection()
end

function lingshouSelectController:openLingShouSelect(args,titleName)
titleName=titleName or"灵兽选择"
local winParams={
titleName=titleName,
extraWin="UIMLingShouSelect",
extraParams=args,
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end

function lingshouSelectController:openLingShouSelect_chuangongge(args,titleName)
titleName=titleName or"灵兽选择"
local winParams={
titleName=titleName,
extraWin="UIMLingShouSelect_chuangongge",
extraParams=args,
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end