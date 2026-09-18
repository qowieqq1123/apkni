







UIFullWenXinGuanUnknowControl=gameState.addListener(fullScreenUI.create())

function UIFullWenXinGuanUnknowControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eWenXinGuan_Unknow,
}
self:initUI(args)
end

function UIFullWenXinGuanUnknowControl:showWin(argstable)
local args={
showFg=false,
showBg=true,
showTopMask=true,
viewNames={'UIWenXinGuanUnknownWin'},
viewArgs={['UIWenXinGuanUnknownWin']=argstable},
}
self:showUI(args)
end

function UIFullWenXinGuanUnknowControl:showWenXinGuanUnknowWin(argstable)
local startCallback=function()
local args={
showFg=false,
showBg=false,
showTopMask=true,
viewNames={'UIWenXinGuanUnknownWin'},
viewArgs={['UIWenXinGuanUnknownWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end