





function xianguanModel:onEnterState_TTMS(isReconnect)

end

function xianguanModel:onLeaveState_TTMS(isReconnect)

end


function xianguanModel.ttmsjump()


local isZYXS,xgid=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eTongTianMiShi)
if not isZYXS then
UIManager.info("无该特权的官职")
return
end

local jobName=xianguanConfig.getJobConfig(nil,xgid,'name')
local jobstage=xianguanConfig.getJobConfig(nil,xgid,'stage')or 2

local _fun=function()

UIManager:invokeUIMethod("UIXianGuanMainWin","onBackButton")
UIFullXJForceControl:closeUI()
if not xianjieController:check2DMapModel()then
UIManager:showWindow('UIXianJie_mapWin',{})
end
end

local showdata=
{
type='UIDialouge',
title='使用提示',
content=FMT.fmt("<color={0}>{1}</color>是否前往异界侦查",FONT_COLOR_VAL[jobstage],jobName),
oktext='前往异界',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
}
local comfirmDialog3=UIDialogManager.newDialog(showdata)
comfirmDialog3:show()
end


function xianguanModel.ttms_yjzz_jump()
local isZYXS,xgid=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eTongTianMiShi)
if not isZYXS then
UIManager.info("无该特权的官职")
return
end

local _fun2=function()
UIManager.info("密使可在仙界寻找其他仙域行军进行迷惑")
end
local _fun=function()
local sceneType=xianjieModel:getScenceType()
if sceneType and sceneType==xianjienSceneType.eXianJie then
UIManager.info("密使已在仙界")
else
UIManager:invokeUIMethod("UIXianGuanMainWin","onBackButton")
UIFullXJForceControl:closeUI()
return xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,_fun2)
end
end

local showdata=
{
type='UIDialouge',
title='使用提示',
content='密使可以在仙界<color=#c82c2c>对其他仙域的行军</color>进行<color=#549327>迷惑</color>，有<color=#549327>50%概率</color>可使对方<color=#549327>减速50%</color>，如果失败则让<color=#c82c2c>对方行军加速20%</color>，密使是否前往仙界',
oktext='前往仙界',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()

end


function xianguanModel.isTTMS_tequan()
local isWSBX,xgid=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eTongTianMiShi)
return isWSBX,xgid
end


function xianguanModel.ttms_WSBX_Cd()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_19
local isZYXS,xgid=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eTongTianMiShi)
local cd=0
if isZYXS then
cd=xianguanModel:callTeQuanObjFunc(xgid,tqid,"getCdLeft")or 0
end
return cd
end


function xianguanModel.useTTMS_WSBX_tequan(xgid,tqid,infoguid)
local guid=tostring(infoguid)
local json_str=jsonHelper.encode({4,guid})
xianguanController.sendUsePrivilege(xgid,tqid,json_str)
end



function xianguanModel.ttms_YJZZ_Cd()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_20

local isZYXS,xgid=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eTongTianMiShi)
local cd=xianguanModel:callTeQuanObjFunc(xgid,tqid,"getCdLeft")or 0


return cd
end


function xianguanModel.useTTMS_YJZZ_tequan(xgid,tqid,guid)
local json_str=jsonHelper.encode({5,guid})
xianguanController.sendUsePrivilege(xgid,tqid,json_str)
end


function xianguanModel.getttms_YJZZ_maxTime()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_20
local maxUseNum=xianguanConfig.getTeQuanCfg(tqid,"times")or 0
return maxUseNum
end

function xianguanModel.getttms_YJZZ_nowTime()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_20
local isZYXS,xgid=xianguanController:checkSelfHasJobByType(XIANGUAN_TYPE_ENUM.eTongTianMiShi)
local usedTimes=0
if isZYXS then
usedTimes=xianguanModel:callTeQuanObjFunc(xgid,tqid,"getTimes")or 0
end
return usedTimes
end





