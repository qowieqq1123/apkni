local _gift={}

function systemZongMenModel:setGiftCount(serial,num)
_gift[tostring(serial)]=num
end

function systemZongMenModel:getGiftCount(serial)
return _gift[tostring(serial)]
end