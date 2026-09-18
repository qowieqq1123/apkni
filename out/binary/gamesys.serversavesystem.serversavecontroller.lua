






local _MODULENAME="serverSaveController"




gameState.addListener(def_table(_MODULENAME))
serverSaveController.name=_MODULENAME



function serverSaveController:onAppStart()

serverSaveModel:onAppStart()



socketManager:register_receiver(254,11,self.recv_254_11)
socketManager:register_receiver(254,38,self.recv_254_38)
socketManager:register_receiver(254,101,self.recv_254_101)








end


function serverSaveController:onEnterState()
serverSaveModel:onEnterState()
end


function serverSaveController:onServerDataInitFinish()
serverSaveModel:onServerDataInitFinish()
end


function serverSaveController:onLeaveState()
serverSaveModel:onLeaveState()


end


function serverSaveController:onLostConnection()

end






function serverSaveController:send_254_10(arg1,arg2,arg3)
socketManager:send_254_10(arg1,arg2,arg3)
end



function serverSaveController:send_254_11(arg1)
socketManager:send_254_11(arg1)
end





function serverSaveController.recv_254_11(arg1,arg2,arg3)
serverSaveModel:DispathData(arg1,arg2,arg3)
end


function serverSaveController:send_254_38()
socketManager:send_254_38()
end

function serverSaveController.recv_254_38(len,array)
local temp={}
if len>0 then
for i=1,len do
local info=array[i]
temp[info.type]=true
serverSaveModel:DispathData(info.type,info.count,info.data)
end
end

for _,v in pairs(serverSaveModel.SYSTEM_ENUM)do
if temp[v]==nil then
serverSaveModel:DispathData(v,0)
end
end
end


function serverSaveController:send_254_102(dataType,data)
local jsonStr=serverSaveModel:getJsonStr()

if jsonStr==nil then return end
local newJsonStr=serverSaveModel:setTempJsonData(dataType,data)
if jsonStr==newJsonStr then return end
socketManager:send_254_102(newJsonStr)
end

function serverSaveController.recv_254_101(jsonStr)
serverSaveModel:saveJsonData(jsonStr)
end


















