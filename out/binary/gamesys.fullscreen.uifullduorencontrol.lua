







UIFullDuoRenControl=gameState.addListener(fullScreenUI.create())

function UIFullDuoRenControl:onAppStart()
local args={
fullType=FULL_TYPE.eDuoRen,
attachName={'entityId'}
}
self:initUI(args)
end

function UIFullDuoRenControl:showDzRoomWindow(argstable)
local args={
showBg=true,
viewNames={'UIDzRoomWin'},
viewArgs={['UIDzRoomWin']=argstable},
}
self:showUI(args)
end