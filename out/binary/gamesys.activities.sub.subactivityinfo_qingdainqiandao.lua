









local subActivityInfo_qingdainqiandao={name='qingdainqiandao'}

function subActivityInfo_qingdainqiandao:onInit()

end

function subActivityInfo_qingdainqiandao:onStart()

end

function subActivityInfo_qingdainqiandao:onDelete()

end

function subActivityInfo_qingdainqiandao:checkReddot()
if not self.data then
return false
end
for k,v in pairs(self.data)do
if v.qdFlag==1 and v.rwFlag==0 then
return true
end
end
return false
end

return subActivityInfo_qingdainqiandao