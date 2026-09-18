







UIFullDanRenControl=gameState.addListener(fullScreenUI.create())

function UIFullDanRenControl:onAppStart()
local args={
fullType=FULL_TYPE.eDanRen,
attachName={'entityId'}
}
self:initUI(args)
end

function UIFullDanRenControl:showDzRoomWindow(argstable)
local args={
showBg=true,
viewNames={'UIDzRoomWin'},
viewArgs={['UIDzRoomWin']=argstable},
}
self:showUI(args)
end

