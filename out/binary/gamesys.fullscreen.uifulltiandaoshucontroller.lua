







UIFullTianDaoShuController=gameState.addListener(fullScreenUI.create())

function UIFullTianDaoShuController:onAppStart()
local args={
fullType=FULL_TYPE.eTianDaoShu,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullTianDaoShuController:showMainWindow(argstable)
local args={
showBg=true,
viewNames={'UITianDaoShuWin'},
viewArgs={['UITianDaoShuWin']=argstable},
}
self:showUI(args)
end

function UIFullTianDaoShuController:touchBuild()
UIFullTianDaoShuController:showMainWindow()
local entityId=tiandaoshuController:getEnterEntity(mapIdType.xianmeng)
if entityId then
local pos=_MapManager.GetObjectAreaC(entityId)
isometricMapSystem:moveCameraToPosition(pos,true)
end

end