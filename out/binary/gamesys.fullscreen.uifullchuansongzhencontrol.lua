







UIFullChuanSongZhenControl=gameState.addListener(fullScreenUI.create())

function UIFullChuanSongZhenControl:onAppStart()
local args={
fullType=FULL_TYPE.eChuanSongZhen,
skinType=fullScreenSkinType.eSkin5,
stage=true,
}
self:initUI(args)
end

function UIFullChuanSongZhenControl:showMainWindow(argstable)
local func1=function()
self:showMainWindowEx(argstable)
end
local func2=function()
fightStage:create(103,func1,argstable)
end
local opened=fullScreenUI.isActiveFullEx(FULL_TYPE.eChuanSongZhen)
if not opened then



UIFullDouFaTaiControl:showWindow("UIFightPrepareLoading",{
startCallback=func2
})
else
self:showMainWindowEx(argstable)
end
end

function UIFullChuanSongZhenControl:showMainWindowEx(argstable)
local args={
showBg=false,
showFg=false,
viewNames={'UIChuanSongZhenWin'},
viewArgs={
['UIChuanSongZhenWin']=argstable,
},
}
self:showUI(args)
end