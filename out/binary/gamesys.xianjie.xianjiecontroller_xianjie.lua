







function xianjieController:onAppStart_xianjie()

end

function xianjieController:onEnterState_xianjie(isReconnet)

end

function xianjieController:onLeaveState_xianjie(isReconnet)

end

function xianjieController:onEnterMap_xianjie(ischange,enterParam)

xianjieController:excuteAllPlotBehavior2()
end

function xianjieController:onLeaveMap_xianjie(ischange)
xianjieModel:clearData_plotBehavior()
xianjieModel:removeAllCloudPlotEntity()
end

function xianjieController:handleEnterParam_xianjie(enterParam,ischange)

end

function xianjieController:onNormalUpdate_xianjie(delay)

end