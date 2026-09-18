







UIFullZongMenVisitorControl=gameState.addListener(fullScreenUI.create())

function UIFullZongMenVisitorControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eZongMenVisitor,
skinType=fullScreenSkinType.eSkin5,
}
self:initUI(args)
end

function UIFullZongMenVisitorControl:showMainWindow()
local param={}
if zongmenModel:getMountainId()==mapIdType.zhufeng_hy then
param.actor=visitControl:getCurrentActor()
else
param.actor=playerModel:getActorID()
end
zongmenVisitorController:send_26_102(param.actor)
local args=
{
showBg=true,
viewNames={'UIZongMenVisitorWin'},
viewArgs={['UIZongMenVisitorWin']=param},
}
self:showUI(args)
return true
end