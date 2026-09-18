














local limitActInfo_xianjierebuildpreview={name='xianjierebuildpreview'}


function limitActInfo_xianjierebuildpreview:onInit()

end


function limitActInfo_xianjierebuildpreview:onStart()

end


function limitActInfo_xianjierebuildpreview:onDelete()

end


function limitActInfo_xianjierebuildpreview:checkReddot()
return false
end


function limitActInfo_xianjierebuildpreview:jump(extraParams)
xianjieController:show_Xianjie_ReBuildPreview()
end

function limitActInfo_xianjierebuildpreview:checkCondition(isWarning)
return true
end

function limitActInfo_xianjierebuildpreview:checkJump_time(isWarning)
return true
end

function limitActInfo_xianjierebuildpreview:checkJump_data(isWarning)
return true
end

return limitActInfo_xianjierebuildpreview