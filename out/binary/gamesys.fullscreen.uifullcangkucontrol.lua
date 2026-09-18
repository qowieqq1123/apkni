








UIFullCangKuControl=gameState.addListener(fullScreenUI.create())

function UIFullCangKuControl:onAppStart()
local args={
fullType=FULL_TYPE.eCangKu,
attachName={'entityId'}
}
self:initUI(args)
end

function UIFullCangKuControl:showWarehouseWindow(argstable)
local args={
showBg=true,
viewNames={'UIWarehouseWin'},
viewArgs={['UIWarehouseWin']=argstable},
}
self:showUI(args)
end

