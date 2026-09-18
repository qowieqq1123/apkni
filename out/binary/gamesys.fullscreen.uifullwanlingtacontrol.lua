








UIFullWanLingTaControl=gameState.addListener(fullScreenUI.create())

function UIFullWanLingTaControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eWanLingTa,
skinType=fullScreenSkinType.eSkin5,
attachName={},
}
self:initUI(args)
end


function UIFullWanLingTaControl:showMainWindow(argstable)
local args=
{
showTopMask=true,
viewNames={'UIWanLingTaMainWin'},
viewArgs={['UIWanLingTaMainWin']=argstable or{}},
}
if argstable and argstable.skipCloud then
self:showUI(args)
else
local startCallback=function()
self:showUI(args)
end
loadingControl.openCloud(startCallback,0.5)
end
end

function UIFullWanLingTaControl:showBookWindow(argstable)
local args=
{
showTopMask=true,
viewNames={'UIWanLingTaBgWin'},
viewArgs={['UIWanLingTaBgWin']=argstable or{}},
}
self:showUI(args)
end



