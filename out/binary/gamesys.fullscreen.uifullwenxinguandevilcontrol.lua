







UIFullWenXinGuanDevilControl=gameState.addListener(fullScreenUI.create())

function UIFullWenXinGuanDevilControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eWenXinGuan_Devli,
}
self:initUI(args)
end

function UIFullWenXinGuanDevilControl:showWin(argstable)
local args={
showFg=false,
showBg=true,
showTopMask=true,
viewNames={'UIWenXinGuanTransferDevilWin'},
viewArgs={['UIWenXinGuanTransferDevilWin']=argstable},
}
self:showUI(args)
end

function UIFullWenXinGuanDevilControl:showWenXinGuanDevilWin(argstable)
local startCallback=function()
local args={
showFg=false,
showBg=false,
showTopMask=true,
viewNames={'UIWenXinGuanTransferDevilWin'},
viewArgs={['UIWenXinGuanTransferDevilWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end