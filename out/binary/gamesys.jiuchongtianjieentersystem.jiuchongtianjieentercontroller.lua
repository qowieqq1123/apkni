






local _MODULENAME="JiuChongTianJieEnterController"

local _ResourceHelper=CS.ResourceHelper

gameState.addListener(def_table(_MODULENAME))
JiuChongTianJieEnterController.name=_MODULENAME
JiuChongTianJieEnterController.data={}

local url='http://10.10.6.22:8080/video/move-1.mp4'

local writablePath=CS.GamePath.writablePath


function JiuChongTianJieEnterController:onAppStart()

JiuChongTianJieEnterModel:onAppStart()








socketManager:register_receiver(34,1,JiuChongTianJieEnterController.recv_34_1)
socketManager:register_receiver(34,2,JiuChongTianJieEnterController.recv_34_2)

notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
notifySystem:listenNotify(notifyConfig.onJctjProgressChange,self.onJctjProgressChange)
end


function JiuChongTianJieEnterController:onEnterState(isReconnect)
self.isPVComplete=nil
JiuChongTianJieEnterModel:onEnterState()
end


function JiuChongTianJieEnterController:onProtocolReq()
JiuChongTianJieEnterModel:onProtocolReq()

if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie3)and not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then

JiuChongTianJieEnterController.discposableLoadPv()
end
end


function JiuChongTianJieEnterController:onLeaveState(isReconnect)
JiuChongTianJieEnterModel:onLeaveState(isReconnect)

self:removeDuJieDiscipleOnZongMen()


self.data={}
self.isPVComplete=nil
self.downloadTimes=nil
end

function JiuChongTianJieEnterController.on_system_open(sysid)
if sysid==SYSTEM_DEFINE.eJiuChongTianJie1 then
UIManager:callWindowFunc("UITaskListWin","refreshZheXianLing")
elseif sysid==SYSTEM_DEFINE.eTianJieQianZou then
UIManager:callWindowFunc("UITaskListWin","refreshZheXianLing")
elseif sysid==SYSTEM_DEFINE.eJiuChongTianJie3 then

JiuChongTianJieEnterController.discposableLoadPv()
elseif sysid==SYSTEM_DEFINE.eJiuChongTianJieComplete then
JiuChongTianJieEnterController.onJiuChongTianJieComplete()
end
end



function JiuChongTianJieEnterController:onLostConnection()

end


function JiuChongTianJieEnterController:onReConnection(isInitPro)

end


function JiuChongTianJieEnterController.onRankListRefresh(rankType)

end


function JiuChongTianJieEnterController:req_kaitian_my_rank()






end

function JiuChongTianJieEnterController.req_34_2(disciple_guid)
socketManager:send_34_2(disciple_guid)
end

function JiuChongTianJieEnterController.recv_34_1(args)
local open_sec=args[1]
local finish_num=args[2]
local len=args[3]
local list=args[4]
local disciple_guid=args[5]
local first_finish_sec=args[6]
JiuChongTianJieEnterModel:setOpenTianJieSec(open_sec)
JiuChongTianJieEnterModel:setOpenTianJiePeople(finish_num)
JiuChongTianJieEnterModel:setTianJieStageFinishData(len,list)
JiuChongTianJieEnterModel:setTianJieFirstFinishSec(first_finish_sec)
notifySystem:postNotify(notifyConfig.onJctjDayChange,open_sec)
local guidNum=mathHelper.int64_to_number(disciple_guid)
if guidNum>0 then
systemControl.onJctjProgressChange()
JiuChongTianJieEnterModel:setSelectFeiShengGuid(disciple_guid)
elseif guidNum==0 then
JiuChongTianJieEnterModel:setSelectFeiShengGuid(disciple_guid)
end

UIManager:callWindowFunc("UITaskListWin","refreshZheXianLing")
end

function JiuChongTianJieEnterController.recv_34_2(disciple_guid)
JiuChongTianJieEnterModel:setSelectFeiShengGuid(disciple_guid)

local guidNum=mathHelper.int64_to_number(disciple_guid)
if guidNum>0 then
JiuChongTianJieEnterController:startDJFS()
end
end

function JiuChongTianJieEnterController.onNewDay()
if JiuChongTianJieEnterModel:isSysOpen()then
notifySystem:postNotify(notifyConfig.onJctjDayChange,JiuChongTianJieEnterModel:getOpenTianJieSec())
end
UIManager:callWindowFunc("UITaskListWin","refreshZheXianLing")
end

function JiuChongTianJieEnterController:refreshReddot(jctjSubType)
UIManager:callWindowFunc("UITaskListWin","refreshZheXianLing")
notifySystem:postNotify(notifyConfig.onJctjReddotChange,jctjSubType)
end

function JiuChongTianJieEnterController.onJctjProgressChange()
UIManager:callWindowFunc("UITaskListWin","refreshZheXianLing")
end


function JiuChongTianJieEnterController:pvPlayComicPlot()
return webGLHelper:isRunMiniGame()or webGLHelper:isRunMGNative()or JiuChongTianJieEnterController.testWeiXin or(not api_Available_StartDownloadFileEx())
end

function JiuChongTianJieEnterController:playPv()
if JiuChongTianJieEnterController:pvPlayComicPlot()then



JiuChongTianJieEnterController.playComicPlot()

else
local id=JiuChongTianJieEnterController.getFSVideoId()
local cfg=cfgHelper.get(cfg_downloadfileconfig_get,id)
local _url=''





local localFile=fileHelper.getFullPath(cfg.filepath)
JiuChongTianJieEnterController.curUseVideoFile=localFile
if fileHelper.isFileExists(localFile)then
UIManager:showWindow("UIJiuChongTianJieVideoWin",{url=_url,name=cfg.filepath,callback=JiuChongTianJieEnterController.afterPlayPV})
else
UIManager.info("飞升资源加载中")
return false

end
end
return true
end

function JiuChongTianJieEnterController.onJiuChongTianJieComplete()

local enterCallBack=function()
if UIManager:isActive("UIZongMenReviewWin")then
UIManager:closeWindow("UIZongMenReviewWin")
end
if UIManager:isActive("UIPlotDecorationWin")then
UIManager:closeWindow("UIPlotDecorationWin")
end



xianjieStoryAIManager:startStoryBehavior("xj_churuxianjie01")
end
xianjieController:jumpXianJie(xianjienSceneType.eXianJie,nil,enterCallBack)
end

function JiuChongTianJieEnterController.playComic()
local comic=cfgHelper.get(cfg_jctjbaseconfig_get,1,"wxComic")
if comic then
gameplotController:showManHua({groupid=comic,callback=JiuChongTianJieEnterController.afterPlayPV})
end
end

function JiuChongTianJieEnterController.playComicPlot()
local comic=cfgHelper.get(cfg_jctjbaseconfig_get,1,"wxComic")
local args={
groupid=comic,
callback=JiuChongTianJieEnterController.afterPlayPV,
isFullOpen=false,
}
gameplotController:showPlotBoard(args)
end

function JiuChongTianJieEnterController.discposableLoadPv()
local loadPvList=cfgHelper.get2(cfg_jctjbaseconfig_get,1,'finishPV')
local gameVersion=pfwindowslController:getGameVersion()
loadPvList=loadPvList[gameVersion]or loadPvList[1]
if not(deviceHelper.isRunEditor()or webGLHelper:isRunMiniGame()or webGLHelper:isRunMGNative())then
if not api_Available_StartDownloadFileEx()then
return
end
local zsSex=playerModel:getActorSex()
local sIndex=zsSex==1 and 1 or 2
local sLoadPvList=loadPvList[sIndex]

for index,loadId in ipairs(sLoadPvList)do
local cfg=cfgHelper.get(cfg_downloadfileconfig_get,loadId)
local localFile=fileHelper.getFullPath(cfg.filepath)
if fileHelper.isFileExists(localFile)then
JiuChongTianJieEnterController.isPVLoad=true
else
local cdnRootURL
if deviceHelper.isRunNonePlatform()then
cdnRootURL="https://reszqzs.xw66.top/"
else
cdnRootURL=gameInfo:getParams('cdnRootURL')
end
if not cdnRootURL then
loggerUtil.logErrFMT("取不到cdnRootURL")
return
end
local _url=cdnRootURL.."pic/"..cfg.filepath
_ResourceHelper.StartDownloadFileEx(_url,cfg.filepath,0,JiuChongTianJieEnterController.afterLoadPv,JiuChongTianJieEnterController.loadPvProgress,nil)
end
end
else
JiuChongTianJieEnterController.isPVLoad=true

















end
end

function JiuChongTianJieEnterController.afterPlayPV()
JiuChongTianJieEnterController.startZongMenReview()
end

function JiuChongTianJieEnterController.afterLoadPv(key,file,error)
downloadAssetWithFileManager.onDownLoadFinished(key,file,error)
if error==""or error==nil then
JiuChongTianJieEnterController.isPVLoad=true


if JiuChongTianJieEnterController.curUseVideoFile~=nil and fileHelper.isFileExists(JiuChongTianJieEnterController.curUseVideoFile)then
UIDialogManager.getCommonDialog3('提示','飞升资源下载完成',nil,nil)
end
else
logErr('下载视频失败,重试',key,file,error)
if not JiuChongTianJieEnterController.waitToTry then

if JiuChongTianJieEnterController.downloadTimes and JiuChongTianJieEnterController.downloadTimes>=3 then
return
end
JiuChongTianJieEnterController.waitToTry=true
local delayTry=timer.new()
delayTry:start(5,function()
JiuChongTianJieEnterController.waitToTry=false
local downloadTimes=JiuChongTianJieEnterController.downloadTimes or 0
JiuChongTianJieEnterController.downloadTimes=downloadTimes+1
JiuChongTianJieEnterController.discposableLoadPv()
end,1)
end
end
end

function JiuChongTianJieEnterController.loadPvProgress(key,file,progress)
downloadAssetWithFileManager.onDownLoadProgress(key,file,progress)
end

function JiuChongTianJieEnterController:testComplteteWeixin(flag)
self.testWeiXin=flag
end



function JiuChongTianJieEnterController:addDuJieBehavior()
JiuChongTianJieEnterModel:setLocalizeProgress(eDuJieFeiShengProgressType.beforePvPlot)
AudioManager.playBgMusic(1020)
storyAIManager:startStoryBehavior("story_38_xianyouxiangzhu_1",nil,nil,nil,false)
end

function JiuChongTianJieEnterController:getDuJieDisciple()
return JiuChongTianJieEnterModel:getSelectFeiShengGuid()
end

function JiuChongTianJieEnterController:createDuJieDisicpleOnZongMen(scale)
local duJieDiscipleGuid=JiuChongTianJieEnterController:getDuJieDisciple()
if duJieDiscipleGuid then
local top1Disciple=UIDiscipleModel:getDiscipleData(duJieDiscipleGuid)
local imageInfo=UIDiscipleModel.calculationDiscipleImage(top1Disciple.discipledata,top1Disciple.discipleimage)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)

local smData=zongmenModel:findBuildingDataByType(zongmenModel:getMountainId(),SLG_SYSTEM_TYPE.eFeiShengTai2)
if smData then
local offset={2,4}
local pos=_MapManager.ToVector3Int(smData.x+offset[1],smData.y+offset[2],0)
scale=scale or modelParams.scale
self.data.duJieDiscipleEntity=isometricMapSystem:createRoleEntity(objectType.eRole,mapIdType.zhufeng,0,modelParams.body,modelParams.componets,SortingLayers.ITBuilding,scale,pos)
else
logErr("检查下是否建造了飞升台")
end
else
logErr("缺少渡劫弟子guid，call技术检查")
end
end

function JiuChongTianJieEnterController:removeDuJieDiscipleOnZongMen()
if self.data.duJieDiscipleEntity then
_MapManager.RemoveTilemapObject(self.data.duJieDiscipleEntity)
self.data.duJieDiscipleEntity=nil
end
end

function JiuChongTianJieEnterController.dujieBehaviorFinishCallBack()
JiuChongTianJieEnterModel:setLocalizeProgress(eDuJieFeiShengProgressType.inPv)
UIManager:showWindow("UIJiuChongTianJieStoryWin",{type=1,isShowAni=false})
end

function JiuChongTianJieEnterController:startReview()
self.data.isShowReview=true
xiantuchengjiuController.send_30_5()
end

function JiuChongTianJieEnterController:endReview()
self.data.isShowReview=false
end

function JiuChongTianJieEnterController:showReviewWindow()
if self.data.isShowReview then
UIManager:showWindow("UIZongMenReviewWin")
end
end

function JiuChongTianJieEnterController:finishDujieAnimation()
JiuChongTianJieEnterController.isPVComplete=true
if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then
JiuChongTianJieEnterController.onJiuChongTianJieComplete()
else
systemControl.onJctjProgressChange()
end
end

function JiuChongTianJieEnterController.getFileGroupId()
local zsSex=playerModel:getActorSex()
return zsSex==1 and LOAD_ASSET_TYPE.pv1 or LOAD_ASSET_TYPE.pv0
end

function JiuChongTianJieEnterController.getFSVideoId()
local zsSex=playerModel:getActorSex()
zsSex=zsSex==1 and 1 or 2
local guid=JiuChongTianJieEnterController:getDuJieDisciple()
local dzSex=UIDiscipleModel:getDiscipleUseSex(guid)

local loadPvList=cfgHelper.get2(cfg_jctjbaseconfig_get,1,'finishPV')
local gameVersion=pfwindowslController:getGameVersion()
loadPvList=loadPvList[gameVersion]or loadPvList[1]

local sLoadPvList=loadPvList[zsSex]
if sLoadPvList and sLoadPvList[dzSex]then
return sLoadPvList[dzSex]
end
return sLoadPvList[1]
end

function JiuChongTianJieEnterController.replaceReviewInfo(str)
local zsName=playerModel:getActorName()
str=string.gsub(str,'%[ZSNAME%]',zsName or'')

local djDzGuid=JiuChongTianJieEnterController:getDuJieDisciple()
local djDZName=UIDiscipleModel:getDiscipleName(djDzGuid)
str=string.gsub(str,'%[DJDZNAME%]',djDZName or'')

local zmName=UISettingModel:getZMName()
str=string.gsub(str,'%[ZMNAME%]',zmName or'')

local dzTotalNum=#(UIDiscipleModel:getSortList()or{})-1
str=string.gsub(str,'%[OTHERDZCOUNT%]',dzTotalNum-1)

local gbColorCountLookip=gubaoModel:getColorCollect()or{}
str=string.gsub(str,'%[GBCOUNTTX%]',gbColorCountLookip[5]or 0)
str=string.gsub(str,'%[GBCOUNTTT%]',gbColorCountLookip[4]or 0)
str=string.gsub(str,'%[GBCOUNTXT%]',gbColorCountLookip[3]or 0)
str=string.gsub(str,'%[GBCOUNTZT%]',gbColorCountLookip[2]or 0)

local curTime=timeHelper.getServerShortTime()
str=string.gsub(str,'%[CURTIME%]',gameUtilityModel.getGameYearPass(curTime))

local craeteRoleShortTime=gameUtilityModel.getPlayerCreateTime()
local craeteRoleLongTime=timeHelper.convertLongStamp(craeteRoleShortTime)
str=string.gsub(str,'%[CREATEROLETIME%]',timeHelper.getFiveFormatByStamp(craeteRoleLongTime))

local rankData=rankListModel:getPlayerInfo(eRankListType.eDuJieFeiSheng)
if rankData and rankData.rank>0 then
str=string.gsub(str,'%[FSDJRANK%]',rankData.rank)
end

local feishengRank=xianjieModel:getFeiShengRank()
if feishengRank>0 then
str=string.gsub(str,'%[FSRANK%]',feishengRank)
end

local serverId=playerModel:getActorServerID()
if serverId then
local zoneName=loginModel:getZoneName(serverId)
str=string.gsub(str,'%[ZONENAME%]',zoneName)
end

return str
end

function JiuChongTianJieEnterController.checkCanShare()
if not systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)then return false end

local openSystemServerDay=JiuChongTianJieEnterModel:getServerLocalizeShare()

if openSystemServerDay==0 then return true end

if openSystemServerDay>0 then
local openServerDay=timeHelper.getServerOpenDay()
return openSystemServerDay>=0 and math.abs(openSystemServerDay-openServerDay)<3
end

return false
end

function JiuChongTianJieEnterController:startDJFS()
local index=JiuChongTianJieEnterModel:getLocalizeProgress()

if index==1 then
self.inFSJQ=true
JiuChongTianJieEnterController:addDuJieBehavior()
elseif index==2 then
UIManager:showWindow("UIJiuChongTianJieStoryWin",{type=1,isShowAni=true})
else
JiuChongTianJieEnterController.startZongMenReview()
end

if not self.isStartLoadXianJieRes then
self:preLoadXianJieRes()
end
end

function JiuChongTianJieEnterController.startZongMenReview()
JiuChongTianJieEnterModel:setLocalizeProgress(eDuJieFeiShengProgressType.inZongmenReview)
rankListController:req_rankList_data(eRankListType.eDuJieFeiSheng)
UIManager:showWindow("UIJiuChongTianJieStoryWin",{type=2,isShowAni=true})
end

function JiuChongTianJieEnterController.setZongMenReivewShareStamp(len,val)
if len>0 then
JiuChongTianJieEnterModel:setServerLocalizeShare(val[1]or 0)
end
end

function JiuChongTianJieEnterController.hideBigWorldCamera()

end

function JiuChongTianJieEnterController:checkInFSJQ()
return self.inFSJQ
end

function JiuChongTianJieEnterController:preLoadXianJieRes()
self.isStartLoadXianJieRes=true
local sceneCfg=cfgHelper.get1(cfg_xianjiesceneconfig_get,1)
downAssetManager:needDownLoadSceneEx(sceneCfg.sceneid,false)
end

function JiuChongTianJieEnterController:playAudio(soundId,volWeight,priority)
if self.data.audioHandleList==nil then
self.data.audioHandleList={}
end
self.data.audioHandleList[soundId]=AudioManager.playAudio(soundId,volWeight,priority)

end

function JiuChongTianJieEnterController:stopAudio(soundId)
local handle=self.data.audioHandleList and self.data.audioHandleList[soundId]
if handle then
AudioManager.stopAudioById(handle)
end
end


function JiuChongTianJieEnterController.testBehavior()
behaviorManager:addBehaviorTree("bt_test",{},true,{},true)
end

function JiuChongTianJieEnterController.testPv(id)
local cfg=cfgHelper.get(cfg_downloadfileconfig_get,id)
local _url=''
local localFile=fileHelper.getFullPath(cfg.filepath)
if fileHelper.isFileExists(localFile)then
UIManager:showWindow("UIJiuChongTianJieVideoWin",{url=_url,name=cfg.filepath,callback=JiuChongTianJieEnterController.afterPlayPV})
else
JiuChongTianJieEnterController.playComic()
end
end
