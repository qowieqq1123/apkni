








UIFullZongMenPhotoControl=gameState.addListener(fullScreenUI.create())

function UIFullZongMenPhotoControl:onAppStart()
local args={
fullType=FULL_TYPE.eZongMenPhoto,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullZongMenPhotoControl:showWindowPhoto(argstable)
local args={
showBg=false,
skinType=fullScreenSkinType.eSkin5,
viewNames={'UIZongMenPhotoWin'},
viewArgs={['UIZongMenPhotoWin']=argstable},
}
self:showUI(args)
end

