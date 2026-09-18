







function UIDiscipleModel:getDZLingShou(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
local ls_guid=netData.lingshou_guid
if mathHelper.validInt64(ls_guid)then
return ls_guid
end
return nil
end

function UIDiscipleModel:checkDZHasLingShou(guid)
return UIDiscipleModel:getDZLingShou(guid)~=nil
end

function UIDiscipleModel:checkHasLingShouDZ(ls_guid)
local discipleNetData=UIDiscipleModel:getAllDiscipleData()
if discipleNetData then
for k,v in pairs(discipleNetData)do
local netData=v.netData.net
if mathHelper.compareInt64(ls_guid,netData.lingshou_guid)then
return netData
end
end
end
return nil
end