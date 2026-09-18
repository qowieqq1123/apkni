
function chatControl.recv_252_17(len,cfList,xgCurFlag)
chatModel:setSignList(len,cfList,xgCurFlag)
end

function chatControl.recv_252_20(xgCurFlag)
chatModel:changeXgCurSign(xgCurFlag)
end

function chatControl.reqChangeXgCurFlag(xgFlag)
socketManager:send_252_20(xgFlag)
end


