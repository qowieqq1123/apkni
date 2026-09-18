





UIFullZaoWuGeControl=gameState.addListener(fullScreenUI.create())

function UIFullZaoWuGeControl:onAppStart()
local args={
fullType=FULL_TYPE.eZaoWuGe,
skinType=fullScreenSkinType.eSkin24,
}
self:initUI(args)
end

function UIFullZaoWuGeControl:showMainWindow(argstable)
local args={
showBg=true,
viewNames={'UIZaoWuGeWin'},
viewArgs={['UIZaoWuGeWin']=argstable},
}
self:showUI(args)
end
