local _sendData={}
local _stamp={}

function huntMonsterTeamModel:initSendData()
_sendData={}
_stamp={}
end

function huntMonsterTeamModel:setSendData(world,monsters)
_sendData[world]=monsters
_stamp[world]=timeHelper.getServerShortTime()
end

function huntMonsterTeamModel:clearSendData(world)
_sendData[world]=nil
_stamp[world]=nil
end

function huntMonsterTeamModel:getSendData(world)
return _sendData[world]
end


function huntMonsterTeamModel:existSendData(world)
local oldstamp=_stamp[world]
local stamp=timeHelper.getServerShortTime()
if oldstamp and(stamp-oldstamp)>3 then return nil end
return self:getSendData(world)~=nil
end