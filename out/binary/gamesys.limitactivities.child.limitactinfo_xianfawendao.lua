
local limitActInfo_xianfawendao={name='xianfawendao'}


function limitActInfo_xianfawendao:onInit()

end


function limitActInfo_xianfawendao:onStart()

end


function limitActInfo_xianfawendao:onUpdate()

end


function limitActInfo_xianfawendao:onDelete()

end


function limitActInfo_xianfawendao:checkReddot()
return UIXianFaWenDaoControl:checkReddot()
end


function limitActInfo_xianfawendao:jump()
jumpManager:jump({id=JUMP_TYPE.eXianFaWenDao},nil,JUMP_BACK.eNoBack)
end

function limitActInfo_xianfawendao:checkOpen(isWarning)
if isWarning then
local dayCond,lerpDay=limitActivitiesModel:checkDayCondition(self.actID)
if dayCond then
self.isopen=self:checkCondition(true)
else
UIManager.error(FMT.fmt('{0}天后可参与',lerpDay))
self.isopen=false
end
end
return self.isopen
end

function limitActInfo_xianfawendao:checkJump_time(isWarning)
return true
end

function limitActInfo_xianfawendao:checkJump_data(isWarning)
local check,ctype,txt,cd=UIXianFaWenDaoControl:checkUnlock()
if not check then
if ctype==1 then
UIManager.info(FMT.fmt(txt,timeHelper.formatSimpleTime(cd)))
else
UIManager.info(txt)
end
end
return check
end


return limitActInfo_xianfawendao