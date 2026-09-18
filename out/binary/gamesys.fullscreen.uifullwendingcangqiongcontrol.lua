
UIFullWenDingCangQiongControl=gameState.addListener(fullScreenUI.create())



function UIFullWenDingCangQiongControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eWenDingCangQiong,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullWenDingCangQiongControl:showWin(argstable)
if WDCQController.checkInTheGame()then
self:showMainWin(argstable)
else
self:showHaiXuanWin(argstable)
end
end

function UIFullWenDingCangQiongControl:showMainWin(argstable)
if not WDCQController.checkUnlockEx(true)then
return false
end

local tabType=FULL_TAB_TYPE.eWDCangQiong
local args=
{
tabType=tabType,
showBg=true,
showTopMask=true,
viewNames={'UIWDCQMainWin'},
viewArgs={['UIWDCQMainWin']=argstable},
}
local startCallback=function()
self:showUI(args)




end
if argstable and argstable.loading then















loadingControl.openCloud(startCallback)
else
self:showUI(args)
end
return true
end

function UIFullWenDingCangQiongControl:showPreGameWin(argstable)

local tabType=FULL_TAB_TYPE.eWDCangQiong
local args=
{
tabType=tabType,
showBg=true,
showTopMask=true,
viewNames={'UIWDCQPreGameWin'},
viewArgs={['UIWDCQPreGameWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullWenDingCangQiongControl:showHaiXuanWin(argstable)
if not WDCQController.checkUnlockEx(true)then
return false
end
local tabType=FULL_TAB_TYPE.eWDCangQiong
local args=
{
tabType=tabType,
showBg=true,
showTopMask=true,
viewNames={'UIWDCQHaiXuanWin'},
viewArgs={['UIWDCQHaiXuanWin']=argstable},
}
local startCallback=function()
self:showUI(args)
end
if argstable and argstable.loading then
loadingControl.openCloud(startCallback)
else
self:showUI(args)
end
return true
end