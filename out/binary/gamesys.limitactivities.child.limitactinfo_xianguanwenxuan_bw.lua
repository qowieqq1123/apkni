














local limitActInfo_xianguanwenxuan_bw={name='xianguanwenxuan_bw'}


function limitActInfo_xianguanwenxuan_bw:onInit()

end


function limitActInfo_xianguanwenxuan_bw:onStart()

end


function limitActInfo_xianguanwenxuan_bw:onDelete()

end


function limitActInfo_xianguanwenxuan_bw:checkReddot()
return xianguanModel:getWenXuanReddot_BW()
end


function limitActInfo_xianguanwenxuan_bw:jump(extraParams)








jumpManager:jump({id=JUMP_TYPE.eXianGuanWenXuan})
end

function limitActInfo_xianguanwenxuan_bw:checkCondition(isWarning)
return systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)
end

function limitActInfo_xianguanwenxuan_bw:checkJump_time(isWarning)
return xianguanModel:checkWenXuanActivityTime()or xianguanController:isInMatchStage_enter_WenXuan_BW()
end

function limitActInfo_xianguanwenxuan_bw:checkJump_data(isWarning)
return xianguanModel:checkInitWenXuanData()
end

return limitActInfo_xianguanwenxuan_bw