







UIFullWenXinGuanTransferControl=gameState.addListener(fullScreenUI.create())

function UIFullWenXinGuanTransferControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eWenXinGuan_Transfer,
}
self:initUI(args)
end

function UIFullWenXinGuanTransferControl:showWin(argstable)
local args={
showFg=false,
showBg=true,
showTopMask=true,
viewNames={'UIWenXinGuanTransferWin'},
viewArgs={['UIWenXinGuanTransferWin']=argstable},
}
self:showUI(args)
end

function UIFullWenXinGuanTransferControl:showWenXinGuanTransferWin(argstable)
local startCallback=function()
local args={
showFg=false,
showBg=false,
showTopMask=true,
viewNames={'UIWenXinGuanTransferWin'},
viewArgs={['UIWenXinGuanTransferWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end