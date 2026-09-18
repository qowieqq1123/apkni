








UIFullAirGameEnterController=gameState.addListener(fullScreenUI.create())

function UIFullAirGameEnterController:onAppStart()

local args=
{
skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eAirGameEnter,
}
self:initUI(args)
end

function UIFullAirGameEnterController:showMainWindow(argstable)
if not systemModel.isOpen(SYSTEM_DEFINE.eAirGame)then
logErr("系统未开启")
return
end

if not argstable then
argstable={}
end

local func=function()
local args=
{
showBg=true,
showTopMask=true,
viewNames={'UIAirGameEnterWin'},
viewArgs={['UIAirGameEnterWin']=argstable},
}
self:showUI(args)
end


if argstable.isNoShowCloud then
func()
else
self:showWinDowByCloud(func)
end

return true
end

function UIFullAirGameEnterController:showPrepareWindow(argstable)
if not systemModel.isOpen(SYSTEM_DEFINE.eAirGame)then
logErr("系统未开启")
return
end

if not argstable then
argstable={}
end



local func=function()
local args=
{
showBg=true,
showTopMask=true,
viewNames={'UIAirGamePrepareWin'},
viewArgs={['UIAirGamePrepareWin']=argstable},
}
self:showUI(args)
end

self:showWinDowByCloud(func)

return true
end

function UIFullAirGameEnterController:showWinDowByCloud(callback,endCallBack)
local startCallback=function()
callback()

UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
UIManager:showWindow("UIFightPrepareLoading",{startCallback=startCallback,endCallback=endCallBack})
end



