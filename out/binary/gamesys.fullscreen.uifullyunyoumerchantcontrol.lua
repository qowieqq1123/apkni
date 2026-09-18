
UIFullYunYouMerchantControl=gameState.addListener(fullScreenUI.create())

function UIFullYunYouMerchantControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eYunYouMerchant,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullYunYouMerchantControl:showMainWindow()
local param={}
local args=
{
moneyArgs={{2}},
showBg=true,
viewNames={'UIYunYouMerchantWin'},
viewArgs={['UIYunYouMerchantWin']=param},
}
self:showUI(args)
return true
end