function xianjieController:onAppStart_LeyLine()
xianjieModel:initLeyLineConfig()
end

function xianjieController:onEnterState_LeyLine()

end

function xianjieController:onLeaveState_LeyLine()
xianjieModel:deleteLeyLineData()
xianjieModel:clearLeyLineRepairData()
xianjieModel:clearLeyLineRepairReqTime()
end

function xianjieController:onEnterMap_LeyLine()
local entData=xianjieModel:getLeyLineData()
if entData then
entData:createEntity(true)
end

local cameraEffect=xianjieModel:checkLeyLineScene()and not xianjieModel:isLeyLineRepairFinish()
cameraControl.setBeautifyTone(cameraEffect,-1.05,Color.New(1,0.9732,0.9198,1),0.95,1.05)
end

function xianjieController:onExitMap_LeyLine()
local entData=xianjieModel:getLeyLineData()
if entData then
entData:removeEntity()
end
end

function xianjieModel:checkClickLeyLine(sceneidx,gridX,gridZ)
if xianjieModel:isInLeyLineRange(sceneidx,gridX,gridZ)then
xianjieController:onClickLeyLine()
return true
end
return false
end

function xianjieController:onClickLeyLine()
local data=xianjieModel:getLeyLineData()
if data then
local winParams={
lookAtPos=data:getWorldPos()
}
xianjieController:openWin("UIXianJie_LeyLineInfoWin",winParams)
end
end

function xianjieController:checkReqLeyLineRepiarData()
if xianjieModel:checkLeyLineRepairReqTime()then
xianjieModel:markLeyLineRepairReqTime()
xianjieController:send_35_91(xjClientBuildType.flcbXianYuLingMai)
end
end