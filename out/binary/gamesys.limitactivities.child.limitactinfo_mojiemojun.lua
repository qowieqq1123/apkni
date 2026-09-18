














local limitActInfo_mojiemojun={name='mojiemojun'}


function limitActInfo_mojiemojun:onInit()

end


function limitActInfo_mojiemojun:onStart()

end


function limitActInfo_mojiemojun:onDelete()

end


function limitActInfo_mojiemojun:checkReddot()
return false
end


function limitActInfo_mojiemojun:jump(extraParams)
jumpManager:jump({id=JUMP_TYPE.eMoJun})
end

function limitActInfo_mojiemojun:checkCondition(isWarning)
local isOpenMoJie=xianjieModel:checkCurrentMoJieEnterTime()
if not isOpenMoJie then
return false
end
local mojunData=xianjieModel:getMoJunData()
return mojunData and mojunData.state==2
end

function limitActInfo_mojiemojun:checkJump_time(isWarning)
local mojunData=xianjieModel:getMoJunData()
return mojunData and mojunData.state==2
end

function limitActInfo_mojiemojun:checkJump_data(isWarning)
local mojunData=xianjieModel:getMoJunData()
return mojunData~=nil
end

return limitActInfo_mojiemojun