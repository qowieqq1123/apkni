local _AppConfig_GetString=CS.AppDataModel.AppConfig_GetString

function pfwindowslController:onAppStart_yuenan()

end

function pfwindowslController:onEnterState_yuenan(isReconnect)

end


function pfwindowslController:onLeaveState_yuenan(isReconnect)

end


function pfwindowslController:receiveHaoPingReward_yuenan()
if verifyManager:isOpen()then
return
end
platformSDK:invoke("reqGooglePlay")

userActorSetting.set("haoPingYouLi",haoPingYouLiTypeEnum.ePopUpEnd)
userActorSetting.flush()
end




function pfwindowslController:isTiShen()
local istisheng=_AppConfig_GetString('istisheng',false)

return istisheng
end



