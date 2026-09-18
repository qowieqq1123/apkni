
UIFullCloudUnlockMapControl=gameState.addListener(fullScreenUI.create())

function UIFullCloudUnlockMapControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eCloudUnLockMap,
skinType=fullScreenSkinType.eSkin22,
}
self:initUI(args)
end


function UIFullCloudUnlockMapControl:showMainWindow()
local param={}
local args=
{
showBg=true,
viewNames={'UIXianJie_cloudUnlockMapWin'},
viewArgs={['UIXianJie_cloudUnlockMapWin']=param},
}
self:showUI(args)
return true
end