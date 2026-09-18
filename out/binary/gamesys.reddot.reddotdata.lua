reddotData={}

function reddotData:init()
self.data={}
self.data.catch={}
end


function reddotData:setCatchData(catch,id,flag)
local data=self.data.catch
if data[catch]==nil then data[catch]={}end
local last=data[catch][id]or false
if last==flag then return false end
data[catch][id]=flag
reddotControl.on_change_catch_type(catch)
return true
end

function reddotData:getCatchData(catch,id)
local data=self.data.catch
if data[catch]==nil then return false end
return data[catch][id]or false
end