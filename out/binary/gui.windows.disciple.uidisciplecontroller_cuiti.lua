













function UIDiscipleController:onAppStart_cuiti()
socketManager:register_receiver(2,88,UIDiscipleController.do_protocol_2_88)
socketManager:register_receiver(2,89,UIDiscipleController.do_protocol_2_89)
end

function UIDiscipleController:onEnterState_cuiti()
UIDiscipleModel:initCuiTiData()
end

function UIDiscipleController:onLeaveState_cuiti()
UIDiscipleModel:clearCuiTiData()
end




function UIDiscipleController:reqCuiTiUp(discipleguid)

socketManager:send_2_88(discipleguid)
end


function UIDiscipleController:reqCuiTiReset(discipleguid)

socketManager:send_2_89(discipleguid)
end





function UIDiscipleController.do_protocol_2_88(discipleguid,ctlv,ctexp)




local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end

local ctlv_o=netData.qzctlv
netData.qzctlv=ctlv
netData.qzctexp=ctexp

if ctlv_o~=ctlv then
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eCuiTi,true)
notifySystem:postNotify(notifyConfig.onDiscipleCuiTiChange,discipleguid,ctlv_o,ctlv)
reddotControl.onDiscipleCuiTiChange(discipleguid)
end
end

function UIDiscipleController.do_protocol_2_89(discipleguid)
local netData=UIDiscipleModel:getDiscipleData(discipleguid)
if netData==nil then return end
local ctlv_o=netData.qzctlv
netData.qzctlv=1
netData.qzctexp=0

netData.qzList=nil
netData.qzlistlen=0
netData.qzItemlookup={}
local isclear=true
if ctlv_o~=netData.qzctlv then
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eCuiTi,true)
notifySystem:postNotify(notifyConfig.onDiscipleCuiTiChange,discipleguid,nil)
reddotControl.onDiscipleCuiTiChange(discipleguid,isclear)
end

UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eQiZhen,true)
notifySystem:postNotify(notifyConfig.onDiscipleQiZhenChange,discipleguid,isclear)
reddotControl.onDiscipleQiZhenChange(discipleguid,isclear)
end

