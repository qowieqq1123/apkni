buildTiaoZhanControl=gameState.addListener({})

local _tiaozhanFunc=
{
[buildTiaoZhanType.eDouFaTai]=
{
jump=function(argtable)
UIFullDouFaTaiControl:showDouFaTaiWindow(argtable,true)
end,
reddotFunc=function(argtable)
return false
end,
unlockFunc=function(argtable)
return true
end,
},
[buildTiaoZhanType.eLunDaoDaHui]=
{
jump=function(argtable)
if not lundaodahuiModel:checkUnlockEx(true)then return false end
UIFullLunDaoDaHuiControl:showLunDaoDaHui(argtable)
return true
end,
reddotFunc=function(argtable)
return lundaodahuiModel:checkRongYuTangReddot()
end,
unlockFunc=function(argtable)
local ret,ctype,txt,cd=lundaodahuiModel:checkUnlock(true)
if ret then return true end
local temp={}
local args={}
local isTime=ctype==1
if isTime then
args.endStamp=cd+timeHelper.getServerShortTime()
end
args.txtFmt=txt
temp.typo=isTime and 1 or 2
temp.args=args
return false,temp
end,
},
[buildTiaoZhanType.eXianFaWenDao]=
{
jump=function(argtable)
return UIXianFaWenDaoControl:showXianFaWenDaoWin(argtable)
end,
reddotFunc=function(argtable)
return UIXianFaWenDaoControl:checkReddot()
end,
unlockFunc=function(argtable)
local ret,ctype,txt,cd=UIXianFaWenDaoControl:checkUnlock()
if ret then return true end
local temp={}
local args={}
local isTime=ctype==1
if isTime then
args.endStamp=cd+timeHelper.getServerShortTime()
end
args.txtFmt=txt
temp.typo=isTime and 1 or 2
temp.args=args
return false,temp
end,
},
[buildTiaoZhanType.eShiLianTa]=
{
jump=function(argtable)
shiLianTaController:showEnterWindow()
end,
reddotFunc=function(argtable)
return shiLianTaModel:checkAllReddot()
end,
unlockFunc=function(argtable)
return true
end,
},
[buildTiaoZhanType.eWuXingDian]=
{
jump=function(argtable)
UIFullWuXingDianControl:showWuXingDianWithLoading(argtable)
end,
reddotFunc=function(argtable)
return wuXingDianController:getReddot()
end,
unlockFunc=function(argtable)
if systemModel.isOpen(SYSTEM_DEFINE.eWuXingDian)then return true end
local tips=buildTiaoZhanControl:getOpenTips(SYSTEM_DEFINE.eWuXingDian)
local temp={}
local args={}
args.txt=tips
temp.typo=2
temp.args=args
return false,temp
end,
},
[buildTiaoZhanType.eJiuYouTa]=
{
jump=function(argtable)
UIFullJiuYouTaControl:showEnterWindow()
end,
reddotFunc=function(argtable)
return JiuYouTaModel:getSectionRewardState()or JiuYouTaModel:get_first_reddot()or JiuYouTaModel:getDayChallengeReddot()
end,
unlockFunc=function(argtable)








return true
end,
hideFunc=function(argtable)
local unlockState,lockType=JiuYouTaModel:isJiuYouTaUnlock()
return not unlockState
end,
dayFunc=function(argtable)
local isBanPlay,BanPlayTime=JiuYouTaModel:isInBanPlayTime()
if isBanPlay then
local nowStamp=timeHelper.getServerLongTime()
local left=BanPlayTime-nowStamp

return FMT.fmt("休战结束剩余{0}",timeHelper.format_time_stamp12(left))
else
local resultTime=JiuYouTaModel:getResultTime()
local now=timeHelper.getServerLongTime()
local left=resultTime-now




return FMT.fmt("距离结算剩余{0}",timeHelper.format_time_stamp12(left))

end
end,
dayTimeJiuYouTa=function()
local isBanPlay,BanPlayTime=JiuYouTaModel:isInBanPlayTime()
if isBanPlay then
local nowStamp=timeHelper.getServerLongTime()
local left=BanPlayTime-nowStamp

return BanPlayTime,"休战结束剩余{0}","休战中"
else
local resultTime=JiuYouTaModel:getResultTime()
local now=timeHelper.getServerLongTime()
local left=resultTime-now
return resultTime,"距离结算剩余{0}","结算中"
end
end,
},
[buildTiaoZhanType.eHouShanShiLian]=
{
jump=function(argtable)
local bdData=argtable.data
local bdDataArgs=argtable.args or{}
local isPlayedAnim=bdDataArgs.isjump or false
UIHuanJingControl:showAndOpenHuanJingWin({data=bdData,index=1,isPlayedAnim=isPlayedAnim})
return true
end,
reddotFunc=function(argtable)
return false
end,
unlockFunc=function(argtable)
return true
end,
},

[buildTiaoZhanType.eMeiRiTiaoZhan]=
{
jump=function(argtable)
if UIHuanJingControl:isDayChallengeOpen()then
local bdData=argtable.data
local bdDataArgs=argtable.args or{}
local isPlayedAnim=bdDataArgs.isjump or false
UIHuanJingControl:showAndOpenHuanJingWin({data=bdData,index=2,isPlayedAnim=isPlayedAnim})
return true
else
UIManager.error('通关第4层开启')
return false
end
end,
reddotFunc=function(argtable)
return false
end,
unlockFunc=function(argtable)
return UIHuanJingControl:isDayChallengeOpen()
end,
},

[buildTiaoZhanType.eHouShanJingDi]=
{
jump=function(argtable)
if UIHuanJingControl:isJinDiFuncOpen()then
local bdData=argtable.data
local bdDataArgs=argtable.args or{}
local isPlayedAnim=bdDataArgs.isjump or false
UIHuanJingControl:showAndOpenHuanJingWin({data=bdData,index=3,isPlayedAnim=isPlayedAnim})
return true
else
local open=cfgHelper.get2(cfg_backmountainareabasicconfig_get,1,"open")
UIManager.error(FMT.fmt('通关关卡{0}开启',UIHuanJingControl:getLevelName("",open)))
return false
end
end,
reddotFunc=function(argtable)
return false
end,
unlockFunc=function(argtable)
return UIHuanJingControl:isJinDiFuncOpen()
end,
},
[buildTiaoZhanType.eChuanSongZhen]=
{
jump=function(argtable)

local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eChuanSongZhen,true,true,true,true)
if bdList==nil or#bdList<=0 then
UIManager.error("需先修复传送阵")
else
UIFullChuanSongZhenControl:showMainWindow(argtable)
end
end,
reddotFunc=function(argtable)
local bdData=argtable.args.data
return chuanSongZhenModel:checkReddot(bdData)
end,
unlockFunc=function(argtable)
local bdList=zongmenModel:haveBuildByBuildId(SLG_SYSTEM_TYPE.eChuanSongZhen,true,true,true,true)
local state=true
if bdList==nil or#bdList<=0 then
state=false
end
return state
end,
},
[buildTiaoZhanType.eAirGame]=
{
jump=function(argtable)
if systemModel.isOpen(SYSTEM_DEFINE.eAirGame)then
UIFullAirGameEnterController:showMainWindow()
else
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eAirGame)
UIManager.error(tips)
end
end,
reddotFunc=function(argtable)
if not airController:api_Available()then
return false
end
return airGameEnterModel:checkReddot()
end,
unlockFunc=function(argtable)
local unlockState=false
local temp={}
if airController:api_Available()then
unlockState=systemModel.isOpen(SYSTEM_DEFINE.eAirGame)
if not unlockState then
local args={}
args.txt="完成任务“老道点拨”可开启\n（且宗门30级）"
args.errtip=systemModel.getOpenTips(SYSTEM_DEFINE.eAirGame)
temp.typo=3
temp.args=args
end
else
temp.args={}
temp.args.txt="该玩法需要使用新客户端，请去对应平台更新至最新版本，\n如您仍遇到问题，请联系客服"
temp.typo=3
temp.args.errtip="该玩法需要使用新客户端，请去对应平台更新至最新版本，如您仍遇到问题，请联系客服"
temp.isUseDialouge=true
end
return unlockState,temp
end,
hideFunc=function(argtable)
if pfwindowslController:checkIsGameVersion_yuenan()then
local unlockState=systemModel.isOpen(SYSTEM_DEFINE.eAirGame)
if not unlockState then
return true
end
end
local extraShowArgs=cfgHelper.get(cfg_aircommonconfig_get,1,"extraShowArgs")
if not extraShowArgs then
return false
end
for i,v in ipairs(extraShowArgs)do
if not systemConfig.isEnoughSingleCnd(unpack(v))then
return true
end
end
return false
end,
},
[buildTiaoZhanType.eXianYunGang]=
{
jump=function(argtable)
UIFullXianYunGangControl:showMainWindow(argtable.data)
end,
reddotFunc=function(argtable)
return XianYunGangModel:checkReddot()or YunZhouZhenTuModel:getYZZTAllReddot()
end,
unlockFunc=function(argtable)
return XianYunGangModel:checkOpen()
end,
},
[buildTiaoZhanType.eXianJunYanZhen]=
{
jump=function(argtable)
if systemModel.isOpen(SYSTEM_DEFINE.eXianJunYanZhen)then
UIManager:showWindow("UIFightPrepareLoading",{para=1})
timeEventController.delayDo(0.5,function()
UIFullXianJunYanZhenControl:showMainWindow()
end)
else
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eXianJunYanZhen)
UIManager.error(tips)
end
end,
reddotFunc=function(argtable)
return XianJunYanZhenModel:checkReddot()
end,
unlockFunc=function(argtable)
if systemModel.isOpen(SYSTEM_DEFINE.eXianJunYanZhen)then return true end
local tips=buildTiaoZhanControl:getOpenTips(SYSTEM_DEFINE.eXianJunYanZhen)
local temp={}
local args={}
args.txt=tips
temp.typo=2
temp.args=args
return false,temp
end,
hideFunc=function(argtable)
if pfwindowslController:checkIsGameVersion_yuenan()then
local unlockState=systemModel.isOpen(SYSTEM_DEFINE.eAirGame)
if not unlockState then
return true
end
end
local extraShowArgs=cfgHelper.getdef(cfg_xianjunyanzhengxconfig,"extraShowArgs")
if not extraShowArgs then
return false
end
for i,v in ipairs(extraShowArgs)do
if not systemConfig.isEnoughSingleCnd(unpack(v))then
return true
end
end
return false
end,
},
[buildTiaoZhanType.eMingYuanZhuSha]=
{
jump=function(argtable)
if myzsModel:checkOpen()then
UIManager:showWindow("UIFightPrepareLoading",{para=1})
timeEventController.delayDo(0.5,function()
myzsController:showFullWin()
end)
else
local tips=systemModel.getOpenTips(SYSTEM_DEFINE.eMingYuanZhuSha)
UIManager.error(tips)
end
end,
reddotFunc=function(argtable)
return myzsModel:getTxzReddot()
end,
unlockFunc=function(argtable)
if myzsModel:checkOpen()then
return true
end
local tips=buildTiaoZhanControl:getOpenTips(SYSTEM_DEFINE.eMingYuanZhuSha)
local temp={}
local args={}
args.txt=tips
temp.typo=2
temp.args=args
return false,temp
end,
hideFunc=function(argtable)
if not myzsModel:checkOpen()then return true end
local extraShowArgs=cfgHelper.get(cfg_mingyuanzhushabaseconfig_get,1,"extraShowArgs")
if not extraShowArgs then
return false
end
for i,v in ipairs(extraShowArgs)do
if not systemConfig.isEnoughSingleCnd(unpack(v))then
return true
end
end
return false
end,
dayFunc=function()
if not myzsModel:checkOpen()then return""end
local state=myzsModel:getSettlementState()

local nowStamp=timeHelper.getServerShortTime()
if state==MYZSSettlementStateEnum.eStop then
local nextStartStamp=myzsModel:getNextSeasonOpenStamp()
local left=nextStartStamp-nowStamp
return FMT.fmt("休战结束剩余{0}",timeHelper.format_time_stamp12(left))
else
local settlementStamp=myzsModel:getSettlementTime()
local left=settlementStamp-nowStamp
return FMT.fmt("距离结算剩余{0}",timeHelper.format_time_stamp12(left))
end
end,
dayTime=function()
if not myzsModel:checkOpen()then return""end
local state=myzsModel:getSettlementState()

if state==MYZSSettlementStateEnum.eStop then
local nextStartStamp=myzsModel:getNextSeasonOpenStamp()
return nextStartStamp,"休战结束剩余{0}","休战中"
else
local settlementStamp=myzsModel:getSettlementTime()
return settlementStamp,"距离结算剩余{0}","结算中"
end
end,
},
}

local _buildTiaoZhanList=
{
[SLG_SYSTEM_TYPE.eDouFaTai]={
list={
buildTiaoZhanType.eDouFaTai,
buildTiaoZhanType.eLunDaoDaHui,
buildTiaoZhanType.eXianFaWenDao,
},
},
[SLG_SYSTEM_TYPE.eShiLianTa]={
list={
buildTiaoZhanType.eShiLianTa,
buildTiaoZhanType.eWuXingDian,
buildTiaoZhanType.eJiuYouTa,
buildTiaoZhanType.eMingYuanZhuSha,
},
},
[SLG_SYSTEM_TYPE.eHouShanMiJing]={
list={
buildTiaoZhanType.eHouShanShiLian,
buildTiaoZhanType.eMeiRiTiaoZhan,
buildTiaoZhanType.eHouShanJingDi,
},
},
[SLG_SYSTEM_TYPE.eChuanSongZhen]={
list={
buildTiaoZhanType.eChuanSongZhen,
buildTiaoZhanType.eAirGame,
},
},
[SLG_SYSTEM_TYPE.eXianYunGang]={
list={
buildTiaoZhanType.eXianYunGang,
buildTiaoZhanType.eXianJunYanZhen,
},
},
}

function buildTiaoZhanControl:onAppStart()

end

function buildTiaoZhanControl:onEnterState()
buildTiaoZhanModel:initData()
end

function buildTiaoZhanControl:onLeaveState()
buildTiaoZhanModel:initData()
end


function buildTiaoZhanControl:enterTiaoZhanByGUID(buildguid,tiaozhanType)
local bdData=zongmenModel:findBuildingByEntityId(buildguid)
if bdData==nil then return false end
local build_id=bdData.build_id
local tiaoZhanTypeList=_buildTiaoZhanList[build_id]
local tiaozhanType=argstable.tiaozhanType
if tiaozhanType==nil then
local temp=buildTiaoZhanControl:getWinArgs(bdData,argstable)
return UIManager:showWindow('UICommonGuanKaDisplayWin',argstable)
else
local has=buildTiaoZhanControl:containsTiaoZhanType(bdData,tiaoZhanTypeList,tiaozhanType)
if not has then
local buildname=cfgHelper.get2(cfg_monijybuildconfig_get,build_id,'name')
loggerUtil.logErrFMT('建筑{0}不包含挑战类型：{1}',buildname,tiaozhanType)
return false
end
return buildTiaoZhanControl:showTiaoZhanWindow(tiaozhanType,argstable)
end
end

function buildTiaoZhanControl:clickTiaoZhanBuild(argstable)
local args=argstable or{}
local tiaozhanType=args.tiaozhanType
local isjump=false
if args.args then
isjump=args.args.isjump
end
if isjump then
local list=buildTiaoZhanControl:getTiaoZhanList(argstable.data)
local jumpIndex=args.args.jumpIndex or 1

tiaozhanType=list[jumpIndex]
else
tiaozhanType=nil
end
if tiaozhanType==nil then

AudioManager.playBtnClick()

local bdData=argstable.data
local temp=buildTiaoZhanControl:getWinArgs(bdData,argstable)
if#temp.cfgs==1 then
tiaozhanType=temp.cfgs[1].typo
return buildTiaoZhanControl:showTiaoZhanWindow(tiaozhanType,argstable)
else
return UIManager:showWindow('UICommonGuanKaDisplayWin',temp)
end
else
return buildTiaoZhanControl:showTiaoZhanWindow(tiaozhanType,argstable)
end
end

function buildTiaoZhanControl:showTiaoZhanWindow(tiaozhanType,argstable)
local cfg=self:getTiaoZhanLuaCfg(tiaozhanType)
if cfg then
return cfg.jump(argstable)
else
logErr(FMT.fmt('尚未支持类型{0}的跳转',tiaozhanType))
end
return false
end

function buildTiaoZhanControl:getTiaoZhanLuaCfg(tiaozhanType)
return _tiaozhanFunc[tiaozhanType]
end

function buildTiaoZhanControl:getTiaoZhanList(bdData)
local build_id=bdData.build_id
if _buildTiaoZhanList[build_id]then
return _buildTiaoZhanList[build_id].list
end
end

function buildTiaoZhanControl:containsTiaoZhanType(bdData,tiaoZhanTypeList,tiaozhanType)
for _,v in ipairs(tiaoZhanTypeList.list)do
if tiaozhanType==v then
return true
end
end
return false
end

function buildTiaoZhanControl:getWinArgs(bdData,argstable)
local temp={}
local cfgs={}
local tiaoZhanTypeList=buildTiaoZhanControl:getTiaoZhanList(bdData)
for _,v in ipairs(tiaoZhanTypeList)do
local luaCfg=buildTiaoZhanControl:getTiaoZhanLuaCfg(v)
if not luaCfg.hideFunc or not luaCfg.hideFunc()then
local sheetCfg=cfg_buildtiaozhanconfig_get(v)
cfgs[#cfgs+1]=
{
jump=luaCfg.jump,
reddotFunc=luaCfg.reddotFunc,
unlockFunc=luaCfg.unlockFunc,
abName=sheetCfg.abName,
assetName=sheetCfg.assetName,
typo=sheetCfg.id,
newbieGuidStr=sheetCfg.newbieGuidStr,
dayFunc=luaCfg.dayFunc,
dayTime=luaCfg.dayTime,
dayTimeJiuYouTa=luaCfg.dayTimeJiuYouTa,
}

end
end
temp.args=argstable
temp.cfgs=cfgs
return temp
end

function buildTiaoZhanControl:getOpenTips(sysid)
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(sysid)
if not isCan then
local typo=errArgs[1]
local val=errArgs[2]
local val2=errArgs[3]
local name=systemConfig.getSystemName(sysid)
if typo==SYSTEM_OPEN_TYPE.eZongmemLevelChanged then
local level=val
return FMT.fmt('宗门{0}级开启',level)
elseif typo==SYSTEM_OPEN_TYPE.eTaskFinish then
local taskname=taskModel:getTaskConfig(val).name
return FMT.fmt('完成任务{0}开启',taskname)
elseif typo==SYSTEM_OPEN_TYPE.eOpenServerTime then
local day=val
local openDay=timeHelper.getServerOpenDay()
return FMT.fmt('{0}天后开启',day-openDay)
elseif typo==SYSTEM_OPEN_TYPE.eKillBoss then
local boosName=cfgHelper.get1(cfg_monstergroup_get,val).name
return FMT.fmt('击杀{1}开启',boosName)
elseif typo==SYSTEM_OPEN_TYPE.eZheXianLingBook then
local bookStr=mathHelper.numberToChinese(val)
if val2 and val2>0 then
local chapterStr=mathHelper.numberToChinese(val2)
return FMT.fmt('谪仙令{0}卷{1}章开启',bookStr,chapterStr)
else
return FMT.fmt('谪仙令{0}卷开启',bookStr)
end
elseif typo==SYSTEM_OPEN_TYPE.eItemOrMoney then
local itemcfg=itemsConfig.getConfig(val)
return FMT.fmt('拥有{0}x{1}开启',itemcfg.name,val2)
elseif typo==SYSTEM_OPEN_TYPE.eXianTuLevel then
return FMT.fmt('仙途{0}级开启',val)
elseif typo==SYSTEM_OPEN_TYPE.eWuXingShengDianOpen then
return'五行圣殿后开启'
elseif typo==SYSTEM_OPEN_TYPE.eXianJieEntityStage then
local entityName=cfgHelper.get2(cfg_fairylandentitytypeconfig_get,val,"name")
return FMT.fmt("{0}{1}阶开启",entityName,val2)
end
end
return''
end