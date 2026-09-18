newbieSkipFuncHelper={}


local _func=
{

[NEWBIE_SKIP_FUNC_TYPE.eTask]=function(cfg)
local len=#cfg
local taskLen=len-1
for i=1,taskLen do
local task=cfg[i+1]
local taskId=task[1]
local match=false
for _,state in ipairs(task[2])do
local taskdata=taskModel:getTask(taskId)
if taskdata then
local taskstate=taskModel:getTaskState_transfromstate(taskdata)
if taskstate==state then return true end
end
end
end
return false
end,

[NEWBIE_SKIP_FUNC_TYPE.eBuildNoDZ]=function(cfg)
local args=cfg[2]
local buildId=args[1]
local buildingDatas=zongmenModel:getAllBuildingData(mapIdType.zhufeng)
for i,v in ipairs(buildingDatas)do
if v.build_id==buildId and tostring(v.dizi_id)~='0'then
return false
end
end
return true
end,

[NEWBIE_SKIP_FUNC_TYPE.eLimitAPILEVEL]=function(cfg)
local args=cfg[2]
local apilevel=args
return deviceHelper.getAPILevel()<apilevel
end,

[NEWBIE_SKIP_FUNC_TYPE.eExistChuanSongZhenDisciple]=function(cfg)
local allCfg=cfg_worldtravelconfig()
for world,cfg in pairs(allCfg)do
local data=chuanSongZhenModel:getData(world)
if data and#data.current>0 then
return true
end
end
return false
end,

[NEWBIE_SKIP_FUNC_TYPE.eRaiseFish]=function(cfg)
return next(UIAquariumControl:getFishItems())~=nil
end,

[NEWBIE_SKIP_FUNC_TYPE.eSetDefense]=function(cfg)
return lingxuwenjianModel:isBaoMing()
end,
[NEWBIE_SKIP_FUNC_TYPE.eWinHasDZ]=function(...)
return newbieSkipFuncHelper.winHasDZ(...)
end,
[NEWBIE_SKIP_FUNC_TYPE.eCanNotProduct]=function(...)
return newbieSkipFuncHelper.canNotProduct(...)
end,
[NEWBIE_SKIP_FUNC_TYPE.eCanNotLianZhiFaBao]=function(...)
return newbieSkipFuncHelper.canNotLianZhiFaBao(...)
end,
[NEWBIE_SKIP_FUNC_TYPE.eCanNotLianZhiFuLu]=function(...)
return newbieSkipFuncHelper.canNotLianZhiFuLu(...)
end,
[NEWBIE_SKIP_FUNC_TYPE.eFightPrepareNoDz]=function(...)
return newbieSkipFuncHelper.fightPrepareNoDz(...)
end,
[NEWBIE_SKIP_FUNC_TYPE.eFaBaoShiLian]=function(cfg)
local sub_actList=activitiesModel:getActSubList_subType_doing(SUB_ACTIVITY_TYPE.eTargetTask4)
if#sub_actList>0 then
for i,sub_actInfo in ipairs(sub_actList)do
if sub_actInfo:checkOpen()then
if sub_actInfo:checkHasTaskReward()then
return true
end
end
end
return false
end
return true
end,
[NEWBIE_SKIP_FUNC_TYPE.elvfaAnPaiDZ]=function(...)
return newbieSkipFuncHelper.lvfaHasDZ(...)
end,
[NEWBIE_SKIP_FUNC_TYPE.eDouFaTaiXiuXi]=function(...)
return newbieSkipFuncHelper.isDouFaTaiXiuXi(...)
end,
[NEWBIE_SKIP_FUNC_TYPE.eHasAnyAnPaiDZ]=function(...)
return newbieSkipFuncHelper.hasAnyAnPaiDZ(...)
end,
[NEWBIE_SKIP_FUNC_TYPE.eHasGuPiaoDAta]=function(...)
return newbieSkipFuncHelper.hasGuPiaoDAta(...)
end,
[NEWBIE_SKIP_FUNC_TYPE.eBuildNum]=function(...)
return newbieSkipFuncHelper.hasBuildNum(...)
end,
}



function newbieSkipFuncHelper.checkSkip(actionid)
local actionConfig=newbieConfig.getNewbieAction(actionid)
if actionConfig.skipfunc then
local skipfunc=actionConfig.skipfunc
local mathType=skipfunc[1]
local len=#skipfunc-1
for i=1,len do
local v=skipfunc[i+1]
local funcType=v[1]
if _func[funcType]==nil then
loggerUtil.logErrFMT('尚未支持类型为{0}的指引跳过方法',funcType)
else
local ret=nil
xpcall(function()
ret=_func[funcType](v)
end,function(err)
logErr(FMT.fmt('newbie checkSkip err:{0}',err))
end)
if ret~=nil then
if mathType==1 then
if ret then return true end
elseif mathType==2 then
if not ret then return true end
end
end
end
end
end
return false
end


function newbieSkipFuncHelper.winHasDZ(cfg)
local name=cfg[2]
local win=UIManager:findActiveWindow(name)
if not win then
loggerUtil.logErrFMT('触发时没有打开界面')
return false
end
if win.getDZId==nil then
loggerUtil.logErrFMT('界面没有获得弟子的方法')
return false
end
local dzid=win:getDZId()
return dzid~=nil
end

function newbieSkipFuncHelper.canNotProduct(cfg)
local name='UIManufactureWin'
local win=UIManager:findActiveWindow(name)
if not win then
loggerUtil.logErrFMT('触发时没有打开界面')
return false
end
if win.checkPlant==nil then
loggerUtil.logErrFMT('界面没有检查生产的方法')
return false
end
return not win:checkPlant()
end

function newbieSkipFuncHelper.canNotLianZhiFaBao(cfg)
local name='UIFabaoWin'
local win=UIManager:findActiveWindow(name)
if not win then
loggerUtil.logErrFMT('触发时没有打开界面')
return false
end
if win.checkLianzhi==nil then
loggerUtil.logErrFMT('界面没有检查炼制的方法')
return false
end
return not win:checkLianzhi()
end

function newbieSkipFuncHelper.canNotLianZhiFuLu(cfg)
local name='UIFuLuMixWin'
local win=UIManager:findActiveWindow(name)
if not win then
loggerUtil.logErrFMT('触发时没有打开界面')
return false
end
return not win:checkLianzhi()
end

function newbieSkipFuncHelper.lvfaHasDZ(cfg)
local name='UISectPalacePostInfoWin'
local win=UIManager:findActiveWindow(name)
if not win then
loggerUtil.logErrFMT('触发时没有打开界面',name)
return false
end
return not win:hasDZ()
end

function newbieSkipFuncHelper.isDouFaTaiXiuXi(cfg)
return douFaTaiModel:checkIsTruce()
end

function newbieSkipFuncHelper.fightPrepareNoDz(cfg)
return UIManager:invokeUIMethod("UIFightPrepareWin","checkPosEmpty")
end

function newbieSkipFuncHelper.hasAnyAnPaiDZ(cfg)
local name=cfg[2]
local win=UIManager:findActiveWindow(name)
if not win then
loggerUtil.logErrFMT('触发时没有打开界面')
return false
end
if win.hasAnyAnPaiDZ==nil then
loggerUtil.logErrFMT('{0}没有支持是否有弟子可安排的方法',name)
return false
end
return win:hasAnyAnPaiDZ()or false
end

function newbieSkipFuncHelper.hasGuPiaoDAta(cfg)
local data=shangHangModel:getGuPiaoData()
return next(data)==nil or false
end

function newbieSkipFuncHelper.hasBuildNum(cfg)
local len=#cfg
local cdnLen=len-1
for i=1,cdnLen do
local buildCdn=cfg[i+1]
local buildid,num=unpack(buildCdn)
local buildNum=zongmenModel:getBuildNum3(buildid)
if buildNum<num then
return false
end
end
return true
end