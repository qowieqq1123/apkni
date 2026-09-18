







UIFullRuiShouLinMenControl=gameState.addListener(fullScreenUI.create())

function UIFullRuiShouLinMenControl:onAppStart()
local args={
fullType=FULL_TYPE.eRuiShouLinMen,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullRuiShouLinMenControl:showMainWindow(argstable)
local args={
showBg=true,
viewNames={'UIRuiShouLinMenWin'},
viewArgs={['UIRuiShouLinMenWin']=argstable},
}
self:showUI(args)
end
