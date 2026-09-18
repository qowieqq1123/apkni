




UIFullFightResultControl=gameState.addListener(fullScreenUI.create())

function UIFullFightResultControl:onAppStart()
local args=
{
menulist=nil,
fullType=FULL_TYPE.eFightResult,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end


