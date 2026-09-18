














local limitActInfo_xianguanwenxuan={name='xianguanwuxuan'}


function limitActInfo_xianguanwenxuan:onInit()

end


function limitActInfo_xianguanwenxuan:onStart()

end


function limitActInfo_xianguanwenxuan:onDelete()

end


function limitActInfo_xianguanwenxuan:checkReddot()
return xianguanModel:getWenXuanReddot()
end


function limitActInfo_xianguanwenxuan:jump(extraParams)







jumpManager:jump({id=JUMP_TYPE.eXianGuanWenXuan})
end

function limitActInfo_xianguanwenxuan:checkCondition(isWarning)
return systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)
end

function limitActInfo_xianguanwenxuan:checkJump_time(isWarning)
return xianguanModel:checkWenXuanActivityTime()or xianguanController:isInMatchStage_enter_WenXuan_BW()
end

function limitActInfo_xianguanwenxuan:checkJump_data(isWarning)
return xianguanModel:checkInitWenXuanData()
end

return limitActInfo_xianguanwenxuan