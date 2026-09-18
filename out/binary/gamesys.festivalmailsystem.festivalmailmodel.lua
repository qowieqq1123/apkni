






festivalMailModel={}
festivalMailModel.data={}

function festivalMailModel:onAppStart()

end


function festivalMailModel:onEnterState(isReconnect)

end


function festivalMailModel:onProtocolReq()

end


function festivalMailModel:onLeaveState(isReconnect)

self.data={}
end



function festivalMailModel:set_received_mail_list(list)
self.data={}
for i,v in pairs(list)do
table.insert(self.data,v)
end
end


function festivalMailModel:add_id_received_mail_list(id)
table.insert(self.data,id)
end


function festivalMailModel:check_received_mail_by_id(id)
for i,v in ipairs(self.data)do
if v==id then
return true
end
end
return false
end