






local _MODULENAME="roleAudioModel"


def_table(_MODULENAME)
roleAudioModel.name=_MODULENAME
roleAudioModel.data={}

function roleAudioModel:onAppStart()

end


function roleAudioModel:onEnterState(isReconnect)

end


function roleAudioModel:onLeaveState(isReconnect)

self.data={}
end




function roleAudioModel:randomByWeight(lib,totalWeight)
if not totalWeight then
totalWeight=0
for _,info in ipairs(lib)do
totalWeight=totalWeight+info[2]
end
if totalWeight<=0 then
return
end
end


local rand=math.random(1,totalWeight)
local rate=0
for idx,info in ipairs(lib)do
rate=rate+info[2]
if rand<=rate then

return info[1],idx,info
end
end
end
