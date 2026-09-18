







UIFullWenXinGuanControl=gameState.addListener(fullScreenUI.create())

function UIFullWenXinGuanControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eWenXinGuan,
}
self:initUI(args)
end

function UIFullWenXinGuanControl:showWenXinGuanEnterWin(argstable)
local startCallback=function()
local args={
showFg=false,
showBg=false,
showTopMask=true,
viewNames={'UIWenXinGuanEnterWin'},
viewArgs={['UIWenXinGuanEnterWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end