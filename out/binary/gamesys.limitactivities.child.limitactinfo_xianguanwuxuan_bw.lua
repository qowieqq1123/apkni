














local limitActInfo_xianguanwuxuan_bw={name='xianguanwuxuan_bw'}


function limitActInfo_xianguanwuxuan_bw:onInit()

end


function limitActInfo_xianguanwuxuan_bw:onStart()

end


function limitActInfo_xianguanwuxuan_bw:onDelete()

end


function limitActInfo_xianguanwuxuan_bw:checkReddot()
return xianguanModel:getWuXuanReddot_BW()
end


function limitActInfo_xianguanwuxuan_bw:jump(extraParams)
jumpManager:jump({id=JUMP_TYPE.eXianGuanWuXuan})
end

function limitActInfo_xianguanwuxuan_bw:checkCondition(isWarning)
return systemModel.isOpen(SYSTEM_DEFINE.eXianGongEnter)
end

function limitActInfo_xianguanwuxuan_bw:checkJump_time(isWarning)
return xianguanModel:checkWuXuanActivityTime()or xianguanController:isInMatchStage_enter_WuXuan_BW()
end

function limitActInfo_xianguanwuxuan_bw:checkJump_data(isWarning)
return xianguanModel:checkInitWuXuanData()
end

return limitActInfo_xianguanwuxuan_bw