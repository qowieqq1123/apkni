







UIFullTianJiangFuYuanControl=gameState.addListener(fullScreenUI.create())

function UIFullTianJiangFuYuanControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eTianJiangFuYuan,
skinType=fullScreenSkinType.eSkin15,
}
self:initUI(args)
end

function UIFullTianJiangFuYuanControl:showMainWindow()

local args=
{
showBg=false,
viewNames={'UITianjiangfuyuanWin'},
viewArgs={['UITianjiangfuyuanWin']={isFull=true}},
}
self:showUI(args)
return true
end