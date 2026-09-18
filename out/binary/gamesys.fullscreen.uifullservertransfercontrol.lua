








UIFullServerTransferControl=gameState.addListener(fullScreenUI.create())

function UIFullServerTransferControl:onAppStart()
local menulist={}

local args=
{
menulist=menulist,
skinType=fullScreenSkinType.eSkin5,
fullType=FULL_TYPE.eServerTransfer,
}
self:initUI(args)
end

function UIFullServerTransferControl:openServerTransferWindow(argstable)
local args=
{
showBg=true,
showBlur=false,
showTopMask=true,
viewNames={'UIServerTransferXianYuMainWin'},
viewArgs={['UIServerTransferXianYuMainWin']=argstable},
}
if argstable and argstable.skipCloud then
self:showUI(args)
else
local startCallback=function()
self:showUI(args)
end
loadingControl.openCloud(startCallback,0.5)
end
return true
end

function UIFullServerTransferControl:openServerTransferHistroyWindow(argstable)
local args=
{
showBg=true,
showBlur=false,
showTopMask=true,
viewNames={'UIServerTransferHistroyWin'},
viewArgs={['UIServerTransferHistroyWin']=argstable},
}
self:showUI(args)
return true
end

function UIFullServerTransferControl:openServerTransferRewardWindow(argstable)
local args=
{
showBg=true,
showBlur=false,
showTopMask=true,
viewNames={'UIServerTransferRewardWin'},
viewArgs={['UIServerTransferRewardWin']=argstable},
}
self:showUI(args)
return true
end