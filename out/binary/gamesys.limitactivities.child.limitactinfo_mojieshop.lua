














local limitActInfo_mojieshop={name='mojieshop'}


function limitActInfo_mojieshop:onInit()

end


function limitActInfo_mojieshop:onStart()

end


function limitActInfo_mojieshop:onDelete()

end


function limitActInfo_mojieshop:checkReddot()
return false
end


function limitActInfo_mojieshop:jump(extraParams)
xianjieController:MoJieShop_Enter()
end

function limitActInfo_mojieshop:checkCondition(isWarning)

return true
end

function limitActInfo_mojieshop:checkJump_time(isWarning)
return true
end

function limitActInfo_mojieshop:checkJump_data(isWarning)
return true
end

return limitActInfo_mojieshop