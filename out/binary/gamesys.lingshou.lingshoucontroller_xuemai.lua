





function lingshouController:onAppStart_xuemai()
socketManager:register_receiver(19,5,self.do_protocol_19_5)
socketManager:register_receiver(19,6,self.do_protocol_19_6)

end

function lingshouController:onEnterState_xuemai()
end

function lingshouController:onLeaveState_xuemai()
end

function lingshouController:onLostConnection_xuemai()

end


function lingshouController.req_19_5(lsGuid,dzGuid,sameLSListLen,sameLSList,colorLSListLen,colorLSList)
if lingshouModel:checkNoOptState(lsGuid)then return end

socketManager:send_19_5(lsGuid,dzGuid,sameLSListLen,sameLSList,colorLSListLen,colorLSList)
end

function lingshouController.req_19_6(lsGuid,dzGuid)
if lingshouModel:checkNoOptState(lsGuid)then return end

socketManager:send_19_6(lsGuid,dzGuid)
end

function lingshouController.do_protocol_19_5(lsGuid,dzGuid)
local lsData=lingshouModel:getLingShouData2(lsGuid)
local isNeedUpStage_before=lingshouModel:checkIsNeedUpLevel_XueMai(lsGuid,lsData.xuemai_val,lsData.xuemai_dianshu)
if isNeedUpStage_before then
lingshouController.recvTuPo_xuemai(lsGuid,lsData.xuemai_val+1)
else
lingshouController.recvNingLian_xuemai(lsGuid,lsData.xuemai_dianshu+1)
end

lingshouModel:setAttrListDirtyX(lsGuid,lingshouAttributeType.eXueMai,true)
notifySystem:postNotify(notifyConfig.onLingShouXMChange,lsGuid,lsData.xuemai_val)
end

function lingshouController.do_protocol_19_6(lsGuid,dzGuid,xuemai_dianshu)
lingshouController.recvNingLian_xuemai(lsGuid,xuemai_dianshu)

lingshouModel:setAttrListDirtyX(lsGuid,lingshouAttributeType.eXueMai,true)
end


function lingshouController.recvNingLian_xuemai(lsGuid,point)

local lsData=lingshouModel:getLingShouData2(lsGuid)
lsData.xuemai_dianshu=point


UIManager:invokeUIMethod("UILingShouXueMaiWin",'recv_NingLian',lsGuid)
lingshouModel:setFightDirty(lsGuid,true)
end

function lingshouController.recvTuPo_xuemai(lsGuid,level)


local lsData=lingshouModel:getLingShouData2(lsGuid)
local oldData=table.deepCopy(lsData)

lsData.xuemai_val=level
lsData.xuemai_dianshu=0



UIManager:invokeUIMethod("UILingShouXueMaiWin",'recv_TuPo',lsGuid,oldData)

lingshouModel:setFightDirty(lsGuid,true)
end



function lingshouController:setLingShouData_XueMai_Test(lsGuidStr,level,point)
local lsGuid=int64.new(lsGuidStr)

local lsData=lingshouModel:getLingShouData2(lsGuid)
lsData.xuemai_val=level or 1
lsData.xuemai_dianshu=point or 0
end

