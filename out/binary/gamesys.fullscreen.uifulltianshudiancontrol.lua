





UIFullTianShuDianControl=gameState.addListener(fullScreenUI.create())

function UIFullTianShuDianControl:onAppStart()
local args={
fullType=FULL_TYPE.eTianShuDian,
skinType=fullScreenSkinType.eSkin24,
}
self:initUI(args)
end

function UIFullTianShuDianControl:showMainWindow(argstable)
local args={
showBg=true,
viewNames={'UITianShuDianWin'},
viewArgs={['UITianShuDianWin']=argstable},
}
self:showUI(args)
end
