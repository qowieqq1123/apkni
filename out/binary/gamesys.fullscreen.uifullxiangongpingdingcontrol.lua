
UIFullXianGongPingDingControl=gameState.addListener(fullScreenUI.create())

function UIFullXianGongPingDingControl:onAppStart()

local args=
{

fullType=FULL_TYPE.eXianGongPingDing,
}
self:initUI(args)
end

function UIFullXianGongPingDingControl:showXGPDWindow()
local args=
{
showBg=false,
viewNames={'UIXianGongPingDingMainWin'},
}
return self:showUI(args)
end