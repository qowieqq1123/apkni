function UIDiscipleController:setDiscipleSign(discipleguid,signType,endTime)
UIDiscipleModel:setDiscipleSign(discipleguid,signType,endTime)
notifySystem:postNotify(notifyConfig.onDiscipleSignChange,signType,{discipleguid})
end

function UIDiscipleController:setDisciplesSign(discipleguids,signType,endTime)
for index,guid in ipairs(discipleguids)do
UIDiscipleModel:setDiscipleSign(guid,signType,endTime)
end
notifySystem:postNotify(notifyConfig.onDiscipleSignChange,signType,discipleguids)
end

function UIDiscipleController:clearDiscipleSignType(signType)
UIDiscipleModel:clearDiscipleSignType(signType)
notifySystem:postNotify(notifyConfig.onDiscipleSignTypeChange,signType)
end

function UIDiscipleController:resetDiscipleSignType(discipleguids,signType,endTime)
UIDiscipleModel:clearDiscipleSignType(signType)
for index,guid in ipairs(discipleguids)do
UIDiscipleModel:setDiscipleSign(guid,signType,endTime)
end
notifySystem:postNotify(notifyConfig.onDiscipleSignTypeChange,signType)
end