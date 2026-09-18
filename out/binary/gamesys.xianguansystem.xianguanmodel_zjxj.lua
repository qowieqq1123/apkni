





XIANGUAN_PRIVILEGE_POJIEZHUTIAN=33


function xianguanModel.onPZXJJump()

local isJob,xgid=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eZhuJieXianJun)
if not isJob then
UIManager.info("无该特权的官职")
return
end

local jobName=xianguanConfig.getJobConfig(nil,xgid,'name')


local _fun=function()

UIManager:invokeUIMethod("UIXianGuanMainWin","onBackButton")
UIFullXJForceControl:closeUI()

end

local showdata=
{
type='UIDialouge',
title='使用提示',
content=FMT.fmt("{0}可使<color=#ca631d>仙界中的友方行军</color>在<color=#549327>5秒后</color>到达目的地，是否前往仙界使用特权",jobName),
oktext='前往仙界',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
}
local comfirmDialog3=UIDialogManager.newDialog(showdata)
comfirmDialog3:show()
end



function xianguanModel.isPZXJTequan()
local isWSBX,xgid=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eZhuJieXianJun)
if isWSBX then
isWSBX=xianguanHelper.checkTeQuanPlatformLimit(XIANGUAN_PRIVILEGE_POJIEZHUTIAN)
end
return isWSBX,xgid
end

function xianguanModel.get_PZXJ_Cd()
local tqid=XIANGUAN_PRIVILEGE_POJIEZHUTIAN
local isZYXS,xgid=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eZhuJieXianJun)
local cd=xianguanModel:callTeQuanObjFunc(xgid,tqid,"getCdLeft")or 0
return cd
end

function xianguanModel:set_PZXJ_march_guid(march_guid,delay)
self.data.PZXJ_march_guid=tostring(march_guid)
self.data.delay_PZXJ_march=delay
end

function xianguanModel:get_PZXJ_march_guid()
return self.data.PZXJ_march_guid
end

function xianguanModel:get_delay_PZXJ_marchd()
return self.data.delay_PZXJ_march or 0
end