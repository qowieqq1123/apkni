





jumpManager={}
JUMP_RET=
{
eSuccess=0,
eArgsNull=1,
eArgsTypeErr=2,
eUnDefineFunc=3,
eFuncErr=4,
eUnDefineCfg=5,
eNotEnoughLevel=6,
eNotEnoughSystem=7,
eNotEnterScene=8,
eNotEnterMount=9,
eErrCfg=10,
eErr=11,
eNotEnoughCheck=12,
}

JUMP_WINDOW_TYPE=
{
eFullScreen=1,
eBaseFullScreen=2,
}

JUMP_BACK=
{
eNoBack=0,
eNomal=1,
eForceBack=2,
}

local _jumpBackInfo=
{
[JUMP_TYPE.eShiLianTa]=
{
control=UIFullFightPrepareControl,
}
}


local _disJump=
{
{
func=function()
return UIManager:isActive('UIDiscipleJingJieBrokeWin')
end
},
{
func=function()
return UIManager:isActive('UIBubbleShooterWin')
end
},
{
func=function()
return UIManager:isActive('UIDiscipleJingJieBrokeWin_afterTX')
end
},

}


local _jumpBackSkipWin=
{
['UITipsWin']=true,
['UINewbieWin']=true,
['UICommonPageWin']=true,
['UIGongFaTipsThreeWin']=true,
['UIGongFaStudyWin']=true,
['UILimitActTipsWin']=true,
}
local _skipLookupWin={}
for k,v in pairs(_jumpBackSkipWin)do
_skipLookupWin[k]=v
end

local _jumpBackParam=nil
local _nextInfo=nil
local _lastInfo=nil
local _forceBack=false
local _beginControl=nil


local _isjump=false
local _lastStamp=nil
local _outTime=10

function jumpManager:onLeaveState()
_lastStamp=nil
_isjump=false
end












function jumpManager:jump(jumpParam,call,backFlag)
if _isjump then
local stamp=timeHelper.getServerShortTime()
if _lastStamp==nil or(stamp-_lastStamp)>_outTime then
_lastStamp=nil
_isjump=false
else

jumpManager:returnRet(call,JUMP_RET.eErr)
return false
end
end
backFlag=backFlag or JUMP_BACK.eNomal
if jumpParam==nil then



jumpManager:returnRet(call,JUMP_RET.eArgsNull)
return false
end

if type(jumpParam)=='number'then



jumpManager:returnRet(call,JUMP_RET.eArgsTypeErr)
return false
end
local jumpType=jumpParam.type or 0
local jumpId=jumpParam.id
local jumpArgs=jumpParam.args or{}
jumpArgs.itemguid=jumpParam.itemguid

if MysteryModel:is_in_mystery()then
UIManager.error("秘境内无法跳转")
return false
end

if fightModel:haveBattleShow()then
UIManager.error("战斗中无法跳转")
return false
end


if worldController:isInWorld()and fullScreenUI.isActiveBaseFull()and not worldController:getCameraControl()then
loggerUtil.logWarnFMT("大世界执行动画中，无法跳转")
return false
end


local forceBack=backFlag==JUMP_BACK.eForceBack
local noBack=backFlag==JUMP_BACK.eNoBack
if forceBack and jumpManager:getBackControl(jumpId)==nil then
logErr(FMT.fmt('jumpManager中的_jumpBackInfo没有添加{0}的配置：',jumpId))
jumpManager:returnRet(call,JUMP_RET.eErrCfg)
return false
elseif forceBack then
jumpManager:clearBackArgs()
_jumpBackParam=jumpParam
end

if type(jumpArgs)=='number'then



jumpManager:returnRet(call,JUMP_RET.eArgsTypeErr)
return false
end

if jumpId==nil then



jumpManager:returnRet(call,JUMP_RET.eUnDefineFunc)
return false
end

local jumpCfg=uiwindow_id_tips_callbacks[jumpId]
if jumpCfg==nil then
loggerUtil.logErrFMT('配置的跳转id没有对应跳转方法：{0}',jumpId)
jumpManager:returnRet(call,JUMP_RET.eFuncErr)
return false
end

if jumpCfg.check then
if not jumpCfg.check(jumpArgs)then
jumpManager:returnRet(call,JUMP_RET.eNotEnoughCheck)
return false
end
end

local lastControl=jumpManager:getCurrentControl()


local hasBack=jumpManager:hasBack()
if noBack then hasBack=false end
if hasBack==false then
forceBack=false
end
local isSetBegin=false
local setBegin=function(disableBack)
if disableBack then
hasBack=false
forceBack=false
end
if not isSetBegin then
jumpManager:beginJump(jumpParam,jumpCfg,lastControl,forceBack,jumpArgs)
isSetBegin=true
end
_isjump=true
_lastStamp=timeHelper.getServerShortTime()
end
local endBegin=function(ret)
jumpManager:endJump(ret,jumpParam,jumpCfg,lastControl,hasBack,jumpArgs)
_isjump=false
end
local func=function()
setBegin()
local ret,msg=jumpCfg.bag_tips_callback(jumpArgs)
if ret==nil then
loggerUtil.logErrFMT('id={0}的跳转没有正确返回跳转结果：',jumpId)
jumpManager:returnRet(call,JUMP_RET.eUnDefineFunc)
return false
end
endBegin(ret)
jumpManager:returnRet(call,JUMP_RET.eSuccess,ret)
if ret then


return true
else
if msg then
UIManager.info(msg)
end

return false
end
end


local jumpConfig=cfg_jumpconfig_get(jumpId)

if jumpConfig==nil then
loggerUtil.logErrFMT('没有找到跳转配置：{0}',jumpId)
jumpManager:returnRet(call,JUMP_RET.eUnDefineCfg)
return false
end
local limitLevel=jumpConfig.level
local limitSystem=jumpConfig.system
local scenetype=jumpConfig.scenetype
local mapidlist=jumpConfig.mapid
local systemUseName=jumpConfig.systemUseName

if limitLevel then
local min=limitLevel[1]
local max=limitLevel[2]
local lv=playerModel:getActorLevel()
if lv<min then
UIManager.error(FMT.fmt('宗门等级不足{0}级',min))
jumpManager:returnRet(call,JUMP_RET.eNotEnoughLevel,min)
return false
end
if max and lv>max then
UIManager.error('已超过限定宗门等级')
jumpManager:returnRet(call,JUMP_RET.eNotEnoughLevel,max)
return false
end
end



if limitSystem then
for _,sysid in ipairs(limitSystem)do
local isOpen=systemModel.isOpen(sysid)
if not isOpen then
local back_desc=systemUseName and FMT.fmt('开启{0}',systemUseName)or nil
local desc=systemModel.getOpenTips(sysid,nil,back_desc)
UIManager.error(desc)
jumpManager:returnRet(call,JUMP_RET.eNotEnoughSystem,sysid)
return false
end
end
end

if scenetype==nil and mapidlist then
logErr('跳转跳转mapid不为空时，scenetype必须配置')
jumpManager:returnRet(call,JUMP_RET.eErrCfg)
return false
end


local argsMapId=jumpArgs.mapid
local argsScenetype=jumpArgs.scenetype
if argsScenetype then
scenetype=argsScenetype
end

if scenetype then
local mapid=argsMapId

if argsMapId then
mapidlist={argsMapId}
else
if mapidlist then
mapid=mapid or mapidlist[1]
end
end



local isZongMen=scenetype==eSceneType.eZongmen
local isWorld=scenetype==eSceneType.eWorld
if isZongMen then
mapid=mapid or mapIdType.zhufeng
if not mainControl:isInScene(eSceneType.eZongmen)then
if mountainControl:isOpen(mapid,true)then
local args={mapid}
if mainControl:enterHome(args,func)then
setBegin(true)
return true
end
end
jumpManager:returnRet(call,JUMP_RET.eNotEnoughSystem,scenetype)
return false
else
if mapidlist and not mountainControl:isInMounts(mapidlist)then
if mountainControl:isOpen(mapid,true)then
setBegin(true)
return mountainControl:loadAndswitchMapEx(mapid,true,func)
end
jumpManager:returnRet(call,JUMP_RET.eNotEnterScene,mapid)
return false
end
end
elseif isWorld then
mapid=mapid or 1
if not mainControl:isInScene(eSceneType.eWorld)then
local isOpenArea,err=worldBlockModel:checkWorldEnterLimit(mapid)
if isOpenArea then
local args={mapid}
if mainControl:enterWorld(args,func)then
setBegin(true)
return true
end
end
UIManager.error(err)
jumpManager:returnRet(call,JUMP_RET.eNotEnoughSystem,scenetype)
return false
else
if mapidlist and not table.containsValue(mapidlist,worldModel.world)then
local isOpenArea,err=worldBlockModel:checkWorldEnterLimit(mapid)
if isOpenArea then
local args={mapid}
if mainControl:enterWorld(args,func)then
setBegin(true)
return true
end
end
UIManager.error(err)
jumpManager:returnRet(call,JUMP_RET.eNotEnoughSystem,scenetype)
return false
end
end
elseif scenetype==eSceneType.eXianJie then
local sceneType_xj
if mapid==nil then
sceneType_xj=xianjieModel:getDefaultScene()
mapidlist={sceneType_xj}
elseif mapid==xjJumpSceneType.eSelfZMPos then
local data=xianjieModel:getZongMenOutPos()
if data==nil then
UIManager.error('场景尚未开启')
jumpManager:returnRet(call,JUMP_RET.eNotEnterScene,xianjienSceneType.eXianJie)
return false
end
local sceneidx=data[1]
sceneType_xj=xianjieModel:sceneIndex2SceneType(sceneidx)
mapidlist={sceneType_xj}
elseif mapid==xjJumpSceneType.eOwnerZMXY then
sceneType_xj=xianjieModel:sceneIndex2SceneType(xianjieModel:getXianYuSceneIndex())
mapidlist={sceneType_xj}
elseif mapid==xjJumpSceneType.eNowPos then
return func()
elseif mapid==xjJumpSceneType.eMoJie then
local enterData=xianjieModel:getMoJieEnterData()
local nowTime=timeHelper.getServerShortTime()
if enterData==nil or nowTime>=enterData.eTime then
UIManager.info("魔界已关闭")
UIManager:invokeUIMethod("UIMainSubEnterPanelWin","onMask")
return
end
if nowTime<enterData.sTime then
local leastTime=enterData.sTime-timeHelper.getServerShortTime()
UIManager.info(FMT.fmt("{0}后开放",timeHelper.format_time_stamp4(leastTime)))
return
end
local cfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
sceneType_xj=xianjieModel:sceneIndex2SceneType(cfg.sceneidx)
mapidlist={sceneType_xj}
elseif mapid==xjJumpSceneType.eMoGong then
local isOpenActDoing=limitActivitiesModel:checkActDoing(LIMIT_ACT_TYPE.eMoGongZhengDuo)
if not isOpenActDoing then
UIManager.info("魔宫未开启")
return
end
local isCanJump=xianjieController:checkCanEnterMoGongZhengDuo()
if isCanJump then
sceneType_xj=xianjienSceneType.eMoGongZhengDuo
mapidlist={xianjienSceneType.eMoGongZhengDuo}
else
return false
end
end
if sceneType_xj==nil then sceneType_xj=mapid end
if not mainControl:isInScene(eSceneType.eXianJie)then
if xianjieController:isSceneOpen(sceneType_xj,true)then
if xianjieController:enterXianJie(sceneType_xj,jumpArgs,func)then
setBegin(true)
return true
end
end
jumpManager:returnRet(call,JUMP_RET.eNotEnoughSystem,scenetype)
return false
else
if mapidlist and not xianjieModel:checkSceneTypes(mapidlist)then
if xianjieController:isSceneOpen(sceneType_xj,true)then
if xianjieController:enterXianJie(sceneType_xj,jumpArgs,func)then
setBegin(true)
return true
end
end
jumpManager:returnRet(call,JUMP_RET.eNotEnterScene,sceneType_xj)
return false
elseif mapid==xjJumpSceneType.eSelfZMPos then
local actorid=playerModel:getActorID()
local zmData=xianjieModel:getZongMenData(actorid)
local gridX_c,gridZ_c=xianjieModel:getZongMenWorldGridCenterPos(zmData)
xianjieController:jumpGrid(zmData.sceneidx,gridX_c,gridZ_c,func)
return true
end
end
end
end
return func()
end

function jumpManager:beginJump(jumpParam,jumpCfg,lastControl,forceBack,jumpArgs)
oneTabScreenController:closeUI()

jumpManager:setBeginJump(lastControl)
local jumpWinType=jumpCfg.jumpWinType
if jumpCfg.check_win_type_func then
jumpWinType=jumpCfg.check_win_type_func(jumpArgs)
end
local baseJumpIn=jumpWinType==JUMP_WINDOW_TYPE.eBaseFullScreen
local baseJumpOut=lastControl and lastControl.fullType==BASE_FULL_TYPE or false
local fullJumpIn=not baseJumpIn
local fullJumpOut=lastControl and lastControl.fullType~=BASE_FULL_TYPE or false
baseFullScreenUI:clearNeedShowBackWindow()
if baseJumpIn then
baseFullScreenUI:beginJumpIn(jumpCfg,baseJumpOut)
else

if lastControl==nil then return end
if fullJumpOut then
jumpManager:setLastArgs(lastControl,forceBack)
baseFullScreenUI:beginJumpOut(jumpCfg)
lastControl:beginJumpOut(jumpCfg)
else
baseFullScreenUI:beginJumpOut(jumpCfg)
end
end
end

function jumpManager:endJump(ret,jumpParam,jumpCfg,lastControl,hasBack,jumpArgs)
local jumpWinType=jumpCfg.jumpWinType
if jumpCfg.check_win_type_func then
jumpWinType=jumpCfg.check_win_type_func(jumpArgs)
end
if ret then
local baseJumpIn=jumpWinType==JUMP_WINDOW_TYPE.eBaseFullScreen
local baseJumpOut=lastControl and lastControl.fullType==BASE_FULL_TYPE or false
local fullJumpIn=not baseJumpIn
local fullJumpOut=lastControl and lastControl.fullType~=BASE_FULL_TYPE or false

if baseJumpIn then
if baseJumpOut and jumpParam and jumpParam.needJumpBack then
baseFullScreenUI:setNeedShowBackWindow(true)
end
baseFullScreenUI:endJumpIn(ret,jumpCfg,lastControl)
else

if lastControl==nil then return end
if fullJumpOut then
lastControl:endJumpOut(jumpCfg,hasBack)
else

baseFullScreenUI:endJumpOut(jumpCfg,hasBack)
end
end
else


local baseJumpIn=jumpWinType==JUMP_WINDOW_TYPE.eBaseFullScreen
if baseJumpIn then
baseFullScreenUI:revertActiveNamesList()
end
end
end

function jumpManager:getCurrentControl()
if fullScreenUI.isActiveFull()then
return fullScreenUI.activeUI
elseif fullScreenUI.isActiveBaseFull()then
return baseFullScreenUI
end
end

function jumpManager:returnRet(call,ret,...)
if ret==JUMP_RET.eSuccess and call then
call(...)
end
end


function jumpManager:jumpBack(control)
if control and _jumpBackParam then
local jumpId=_jumpBackParam.id
if _lastInfo and _lastInfo.activeUI and _nextInfo and _nextInfo.activeUI then
if _nextInfo.activeUI.fullType==control.fullType then
_lastInfo.activeUI:showUI(_lastInfo.showParam,true)
baseFullScreenUI:showBackWindow()
jumpManager:clearBackArgs()
return true
end
end
end
return false
end


function jumpManager:setLastArgs(control,forceBack)
if not forceBack then return end
_lastInfo={}
_lastInfo.activeUI=control
_lastInfo.showParam=control.showParam
end


function jumpManager:setNextArgs(control)
if control==nil or _jumpBackParam==nil or _lastInfo==nil then return end
local jumpId=_jumpBackParam.id
local jumpControl=jumpManager:getBackControl(jumpId)
if jumpControl==nil then return end
if jumpControl.fullType~=control.fullType then return end
_nextInfo={}
_nextInfo.activeUI=control
_nextInfo.showParam=control.showParam
end


function jumpManager:clearBackArgs()
_jumpBackParam=nil
_nextInfo=nil
_lastInfo=nil
end


function jumpManager:getBackControl(jumpId)
if _jumpBackInfo[jumpId]then
return _jumpBackInfo[jumpId].control
end
end



function jumpManager:setBeginJump()
jumpManager:clearJump()
_beginControl=fullScreenUI.activeUI
if _beginControl then
_beginControl.jump=true
end
end

function jumpManager:clearJump()
if _beginControl then
_beginControl.jump=false
end
_beginControl=nil
baseFullScreenUI:clearBackInfo()
fullScreenUI.clearLastUI()
jumpManager:clearBackArgs()
end


function jumpManager:hasBack()
for i,v in ipairs(_disJump)do
if v.func()then
return false
end
end
return true
end

function jumpManager:isSkipBack(name)
return _skipLookupWin[name]or false
end
