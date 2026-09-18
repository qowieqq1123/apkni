





UIFullProsperityController=gameState.addListener(fullScreenUI.create())

function UIFullProsperityController:onAppStart()
local args={
fullType=FULL_TYPE.eProsperity,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullProsperityController:check_Open(isWarning)
if not systemModel.isOpen(SYSTEM_DEFINE.eProsperity)then
return false
end

return true
end

function UIFullProsperityController:showMainWindow()
if not systemModel.isOpen(SYSTEM_DEFINE.eProsperity)then return end

local args={
showBg=true,
viewNames={'UIProsprity_MainWin'},
}
self:showUI(args)
end

function UIFullProsperityController:showDetailsInfoWindow(args)
local args={
showBg=true,
viewNames={'UIProsprity_MainWin','UIProsperity_DetailsInfoWin'},
viewArgs={['UIProsperity_DetailsInfoWin']=args},
}
self:showUI(args)
end