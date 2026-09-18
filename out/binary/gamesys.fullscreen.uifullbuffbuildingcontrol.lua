







UIFullBuffBuildingControl=gameState.addListener(fullScreenUI.create())

function UIFullBuffBuildingControl:onAppStart()
local args={
fullType=FULL_TYPE.eBuffBuilding,
}
self:initUI(args)
end

function UIFullBuffBuildingControl:showBuffBuildingWindow(argstable)
local args={
showBg=true,
viewNames={'UIBuffBuildingWin'},
viewArgs={['UIBuffBuildingWin']=argstable},
}
self:showUI(args)
end