





equipsControl=gameState.addListener({})

function equipsControl:onAppStart()

end

function equipsControl:onEnterState()
equipsModel:loadEqupJingLianDropDownIdx()
end


function equipsControl:onLeaveState()

end







function equipsControl.freshWindow(funcname,...)
UIManager:callWindowFunc('UIEquipWin',funcname,...)
end

function equipsControl.freshJinglianWindow(funcname,...)
UIManager:callWindowFunc('UIEquipJinglianWin',funcname,...)
end

function equipsControl.freshAttrWindow()
UIManager:callWindowFunc('UIDiscipleRoleInfoThreeWin','refreshAttrs')
end

function equipsControl.freshBagWindow(funcname,...)
UIManager:callWindowFunc('UIBagWin',funcname,...)
end

function equipsControl.openJinglianWindow(args)
if systemModel.isOpen(SYSTEM_DEFINE.eJingLian)then
return oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipJingLian,args)
end
return false
end

function equipsControl.openChongZhuWindow(args)
if systemModel.isOpen(SYSTEM_DEFINE.eChongZhu)then
return oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipChongZhu,args)
end
return false
end