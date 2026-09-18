














local limitActInfo_chisejindi={name='chisejindi'}


function limitActInfo_chisejindi:onInit()

end


function limitActInfo_chisejindi:onStart()

end


function limitActInfo_chisejindi:onDelete()

end


function limitActInfo_chisejindi:checkReddot()
return false
end


function limitActInfo_chisejindi:jump(extraParams)
activitiesController:jump(self.actId,self.subType,self.subId)
end

function limitActInfo_chisejindi:checkCondition(isWarning)
return true
end

function limitActInfo_chisejindi:checkJump_time(isWarning)
return true
end

function limitActInfo_chisejindi:checkJump_data(isWarning)
return true
end

function limitActInfo_chisejindi:bindData(actId,subType,subId)
self.actId=actId
self.subType=subType
self.subId=subId
end

return limitActInfo_chisejindi