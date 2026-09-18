







UIFullWenXinGuanImmortalControl=gameState.addListener(fullScreenUI.create())

function UIFullWenXinGuanImmortalControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eWenXinGuan_Immortal,
}
self:initUI(args)
end

function UIFullWenXinGuanImmortalControl:showWin(argstable)
local args={
showFg=false,
showBg=true,
showTopMask=true,
viewNames={'UIWenXinGuanTransferImmortalWin'},
viewArgs={['UIWenXinGuanTransferImmortalWin']=argstable},
}
self:showUI(args)
end

function UIFullWenXinGuanImmortalControl:showWenXinGuanImmortalWin(argstable)
local startCallback=function()
local args={
showFg=false,
showBg=true,
showTopMask=true,
viewNames={'UIWenXinGuanTransferImmortalWin'},
viewArgs={['UIWenXinGuanTransferImmortalWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end