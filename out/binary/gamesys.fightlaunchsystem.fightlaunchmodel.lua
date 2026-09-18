






local _MODULENAME="fightLaunchModel"




def_table(_MODULENAME)
fightLaunchModel.name=_MODULENAME


fightLaunchModel.data={}

function fightLaunchModel:onAppStart()

end


function fightLaunchModel:onEnterState()
self.tempFight={}
self.fightSendKey=0
end


function fightLaunchModel:onLeaveState()

self.data={}
self.tempFight={}
end


function fightLaunchModel:onServerDataInitFinish()

end






function fightLaunchModel:getFightSendKey()
self.fightSendKey=self.fightSendKey+1
return self.fightSendKey
end

function fightLaunchModel:endInteval()
if self.inteval~=nil then
self.inteval:cancel()
self.inteval=nil
end
end

function fightLaunchModel:insertFightSend(fightList,other,head,fightKey)
if head then
table.insert(self.tempFight,1,{fightList,other,fightKey})
else
table.insert(self.tempFight,{fightList,other,fightKey})
end
end

function fightLaunchModel:getFightSend()
if next(self.tempFight)then
local data=self.tempFight[1]
self.tempFightType=nil
return data
end
end

function fightLaunchModel:isFightListEmpty()
return next(self.tempFight)==nil
end

function fightLaunchModel:removeFightSend()
table.remove(self.tempFight,1)
end

function fightLaunchModel:removeFightSendByFightKey(fightKey)
local pos=nil
for i,v in ipairs(self.tempFight)do
if fightKey==v[3]then
pos=i
break
end
end
if pos then
table.remove(self.tempFight,pos)
end
end

function fightLaunchModel:setNextSendTime(nextSendTime)
self.data.nextSendTime=nextSendTime
end

function fightLaunchModel:getNextSendTime()
return self.data.nextSendTime
end