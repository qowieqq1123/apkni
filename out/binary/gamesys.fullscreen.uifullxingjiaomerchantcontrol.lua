
UIFullXingJiaoMerchantControl=gameState.addListener(fullScreenUI.create())

function UIFullXingJiaoMerchantControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eXingJiaoMerchant,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullXingJiaoMerchantControl:showMainWindow()
local param={}
local args=
{

showBg=true,
viewNames={'UIXingJiaoMerchantWin'},
viewArgs={['UIXingJiaoMerchantWin']=param},
}
self:showUI(args)
return true
end