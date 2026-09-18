








UIFullLingShouSelectControl=gameState.addListener(fullScreenUI.create())

function UIFullLingShouSelectControl:onAppStart()
local args=
{
fullType=FULL_TYPE.eLingShouSelect,
skinType=fullScreenSkinType.eSkin9,
attachName={'entityID'},
}
self:initUI(args)
end


function UIFullLingShouSelectControl:showLingShouSelectWindowEx(argstable)
local args=
{
showBg=true,
viewNames={'UILingShouSelectWin'},
viewArgs={['UILingShouSelectWin']=argstable or{}},
}
self:showUI(args)
end

function UIFullLingShouSelectControl:showLingShouSelectWindow(argstable)
argstable=argstable or{}
local sysid=SLG_SYSTEM_TYPE.eWangShouTang
if not zongmenModel:haveBuildByBuildId(sysid)then
return false
end
local sfId=zongmenModel:getMountainId()
local data=zongmenModel:getBuildingDataByBdType(sfId,sysid)
argstable.entityID=data[1].entityId
UIFullLingShouSelectControl:showLingShouSelectWindowEx(argstable)
return true
end