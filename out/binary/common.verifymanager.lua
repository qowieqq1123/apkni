
local _AppConfig_GetBool=CS.AppDataModel.AppConfig_GetBool

verifyManager={}

local skipActivityData={[249]={}}
local noSkipMsgWinData={
[1]=true,
[2]=true,
[4]=true,
[5]=true,
[8]=true,
[28]=true,
}
local unUseBtnData={[1]=true}


function verifyManager:isMasking()
local mask=_AppConfig_GetBool('openMasking',false)
return mask
end


function verifyManager:isOpen()
return updateState.filterServer==true
end

function verifyManager:isHideRecharge()
return verifyManager:isOpen()and webGLHelper:is_MiniGame()
end

function verifyManager:isHideRule()
return verifyManager:isOpen()and(deviceHelper.isRunIOS()or webGLHelper:isRunWeiXin())and(not webGLHelper:isRunWeiXinTwo())
end


function verifyManager:isHideRuleTick()
return verifyManager:isOpen()and webGLHelper:isRunWeiXinTwo()
end


function verifyManager:isHideIpBelong()
return verifyManager:isOpen()and webGLHelper:isRunWeiXinTwo()
end


function verifyManager:isCustomQualification()
return verifyManager:isOpen()and webGLHelper:isRunWeiXinTwo()
end


function verifyManager:isHideWelfare()
return verifyManager:isOpen()and(deviceHelper.isRunIOS()or deviceHelper.isRunAndroid())
end



function verifyManager:isHideYuyin()
return verifyManager:isOpen()and(pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei())
end



function verifyManager:isHideSpecificRecharge()
return verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_yuenan()
end


function verifyManager:SkipUIGameBeginVideoWin()
return verifyManager:isOpen()and(pfwindowslController:checkIsGameVersion_yuenan()or pfwindowslController:checkIsGameVersion_oumei())
end


function verifyManager:isHideKeFu()
return verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_oumei()
end


function verifyManager:isHideSheQu()
return verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_oumei()
end


function verifyManager:isHideWanBaoShangHui()
return verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_oumei()
end


function verifyManager:isHideBindAccount()
return verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_oumei()
end



function verifyManager:isHideChatWarning()
return verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_yuenan()
end


function verifyManager:isHideVersion()
return verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_yuenan()
end


function verifyManager:isHideActPreview()
return verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_yuenan()
end


function verifyManager:isHideChangeSex()
return verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_yuenan()
end


function verifyManager:isHideTeamSetting()
return verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_yuenan()
end


function verifyManager:testVerify()
updateState.filterServer=true
end


function verifyManager:checkSkipActivity(sid,pid)
if(verifyManager:isOpen()and webGLHelper:isRunMiniGame())or verifyManager:isHideBusinessActivity()then
local sdata=skipActivityData[sid]
if sdata then
if#sdata>0 then
if sdata[pid]then
return true
end
else
return true
end
end
end
return false
end

function verifyManager:checkSkipMsgWin(wid)
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
if not noSkipMsgWinData[wid]then
return true
end
end
return false
end

function verifyManager:checkItemBtnCanUse(btnType)
if verifyManager:isOpen()and webGLHelper:isRunMiniGame()then
if unUseBtnData[btnType]then
return false
end
end
return true
end


function verifyManager:getLoginData()
local data=verifyData:getLoginData()
local loginData=table.deepCopy(data)
loginData.user=loginModel.userid
return loginData
end


function verifyManager:getProductId(rmb)
local datas=verifyData:getProductData()
local pid=datas[tostring(rmb)]
return pid
end


function verifyManager:isNeedRequestPHP()
local flag=_AppConfig_GetBool('needRequestPHP',false)
return flag
end


function verifyManager:isMaskActivity()
local flag=_AppConfig_GetBool('maskActivity',false)
return flag
end


function verifyManager:isHideBusinessActivity()
return verifyManager:isOpen()and verifyManager:isMaskActivity()
end



function verifyManager:isHideLimitActivities()
return verifyManager:isOpen()and pfwindowslController:checkIsGameVersion_oumei()
end
