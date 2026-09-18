







UIFullXianMengDaZhenController=gameState.addListener(fullScreenUI.create())

function UIFullXianMengDaZhenController:onAppStart()
local args={
fullType=FULL_TYPE.eTianDaoShu,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullXianMengDaZhenController:showMainWindow(argstable)
local guildId=xianmengModel:getMyXMGuildID()
if guildId then
local garrison=xianjieModel:getXianMengGarrison(guildId)
if not garrison or garrison.serverTime>garrison.clientTime then
xianjieController:send_35_156(guildId)
end

local args={
showBg=true,
viewNames={'UIXianMengDaZhenWin'},
viewArgs={['UIXianMengDaZhenWin']=argstable},
}
self:showUI(args)
else
UIManager.error("请先加入仙盟")
end
end