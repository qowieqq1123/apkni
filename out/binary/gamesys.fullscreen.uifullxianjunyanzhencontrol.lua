
UIFullXianJunYanZhenControl=gameState.addListener(fullScreenUI.create())

function UIFullXianJunYanZhenControl:onAppStart()

local args=
{
skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eXianJunYanZhen,
}
self:initUI(args)
end

function UIFullXianJunYanZhenControl:showMainWindow(argstable)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJunYanZhen)then
logErr("系统未开启")
return
end

if not argstable then
argstable={}
end

local args=
{
showBg=true,
showTopMask=true,
viewNames={'UIXianJunYanZhenWin'},
viewArgs={['UIXianJunYanZhenWin']=argstable},
}
self:showUI(args)

return true
end

function UIFullXianJunYanZhenControl:showRecordWindow(argstable)
if not systemModel.isOpen(SYSTEM_DEFINE.eXianJunYanZhen)then
logErr("系统未开启")
return
end

if not argstable then
argstable={}
end

local args=
{
showBg=true,
showTopMask=true,
viewNames={'UIXianJunYanZhenWin'},
viewArgs={['UIXianJunYanZhenWin']=argstable},
}
self:showUI(args)
UIFullXianJunYanZhenControl:showWindow('UIXianJunYanZhenRecordWin',argstable)

return true
end



function UIFullXianJunYanZhenControl:showXJYZYunZhouBuZhenWindowEx(winArgs)
winArgs=winArgs or{}

self:showWindow("UIXianJunYanZhen_YunZhouPrepareWin",winArgs)
end

