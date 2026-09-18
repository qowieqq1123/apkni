







UIFullWenXinGuanMainControl=gameState.addListener(fullScreenUI.create())

function UIFullWenXinGuanMainControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eWenXinGuan_Main,
}
self:initUI(args)
end

function UIFullWenXinGuanMainControl:showWin(argstable)
local args={
showFg=false,
showBg=true,
showTopMask=true,
viewNames={'UIWenXinGuanMainWin'},
viewArgs={['UIWenXinGuanMainWin']=argstable},
}
self:showUI(args)
end

function UIFullWenXinGuanMainControl:showWenXinGuanMainWin(argstable)
local startCallback=function()
local args={
showFg=false,
showBg=false,
showTopMask=true,
viewNames={'UIWenXinGuanMainWin'},
viewArgs={['UIWenXinGuanMainWin']=argstable},
}
self:showUI(args)
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback})
end