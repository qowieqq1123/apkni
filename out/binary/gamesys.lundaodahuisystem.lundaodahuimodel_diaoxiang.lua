





function lundaodahuiModel:setDxData(dxList)
self.data.dxList={}
if dxList then
for i,v in ipairs(dxList)do
self.data.dxList[v.un_build_id]=v
end
end
end

function lundaodahuiModel:getDxData(un_build_id)
if not self.data.dxList then
return
end
return self.data.dxList[un_build_id]
end