














local limitActInfo_xianguanwuxuan={name='xianguanwuxuan'}


function limitActInfo_xianguanwuxuan:onInit()

end


function limitActInfo_xianguanwuxuan:onStart()

end


function limitActInfo_xianguanwuxuan:onDelete()

end


function limitActInfo_xianguanwuxuan:checkReddot()
return xianguanModel:getWuXuanReddot()
end


function limitActInfo_xianguanwuxuan:jump(extraParams)
jumpManager:jump({id=JUMP_TYPE.eXianGuanWuXuan})
end

function limitActInfo_xianguanwuxuan:checkCondition(isWarning)
return systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)
end

function limitActInfo_xianguanwuxuan:checkJump_time(isWarning)
return xianguanModel:checkWuXuanActivityTime()or xianguanController:isInMatchStage_enter_WuXuan_BW()
end

function limitActInfo_xianguanwuxuan:checkJump_data(isWarning)
return xianguanModel:checkInitWuXuanData()
end

return limitActInfo_xianguanwuxuan