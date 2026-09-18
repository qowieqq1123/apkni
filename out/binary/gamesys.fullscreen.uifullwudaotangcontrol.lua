







UIFullWuDaoTangControl=gameState.addListener(fullScreenUI.create())

function UIFullWuDaoTangControl:onAppStart()
local args={
fullType=FULL_TYPE.eWuDaoTang,
attachName={},
}
self:initUI(args)
end

function UIFullWuDaoTangControl:showMyWindow(argstable)
local args={
showBg=true,
viewNames={'UIWuDaoTangWin'},
viewArgs={['UIWuDaoTangWin']=argstable},
}
self:showUI(args)
end

function UIFullWuDaoTangControl:showMyWindowEx()
if not zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eWuDaoTang)then
return false
end
local data=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eWuDaoTang)
UIFullWuDaoTangControl:showMyWindow({entityID=data[1].entityId})
return true
end