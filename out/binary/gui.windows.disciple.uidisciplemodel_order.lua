







function UIDiscipleModel:checkDZHasOrder(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.order>0
end