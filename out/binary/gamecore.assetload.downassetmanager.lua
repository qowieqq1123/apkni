







downAssetManager=gameState.addListener({})
local _InitPackInfo=CS.ResourceHelper.UpdateManager_InitPackInfo
local _SetDownloadParam=CS.ResourceHelper.SetDownloadParam

local _GetTotalNeedUpdatePackageSize=CS.ResourceHelper.UpdateManager_GetTotalNeedUpdatePackageSize
local _GetTotalNeedUpdateGroupSize=CS.ResourceHelper.UpdateManager_GetTotalNeedUpdateGroupSize

local _GetCurrentInternetReachability=CS.NetworkHelper.GetCurrentInternetReachability

local _GetTotalNeedUpdateFileCount=CS.ResourceHelper.GetTotalNeedUpdateFileCount
local _GetTotalNeedUpdateFileSize=CS.ResourceHelper.GetTotalNeedUpdateFileSize
local _GetResourceVersion=CS.AppDataModel.GetResourceVersion
local _IsNeedDownLoadAssetbundle=CS.ResourceHelper.IsNeedDownLoadAssetbundle
function downAssetManager:onAppStart(...)
self.showRetDialogue={}

notifySystem:listenNotify(notifyConfig.building_event,self.onBuildEvent)
end

function downAssetManager:onEnterState()

end

function downAssetManager:onLeaveState()

end

function downAssetManager:onProtocolReq()
downAssetManager:startNextDownload()
end

function downAssetManager:onLeaveState_()
downAssetManager:startNextDownload()
end





function downAssetManager:needDownLoadScene(sceneId,mapid,notice)
if notice==nil then notice=true end
if sceneId==SCENE_TYPE.home then
if mapid and mapid~=mapIdType.zhufeng then
return downAssetManager:needDownLoadZongMenMap(mapid,notice)
end
end
return downAssetManager:needDownLoadSceneEx(sceneId,notice)
end

function downAssetManager:needDownLoadSceneEx(sceneId,notice)
local sceneCfg=cfg_sceneconfig_get(sceneId)
local resgroupid=sceneCfg.resgroupid
local name=sceneCfg.scencename
return downAssetManager:needDownLoadResGroupNotice(resgroupid,name,notice)
end


function downAssetManager:needDownLoadWorld(worldId,notice)
local cfg=cfgHelper.get1(cfg_worldconfig_get,worldId)
return downAssetManager:needDownLoadScene(cfg.sceneid,nil,notice)
end





function downAssetManager:needDownLoadZongMenMap(mapid,notice)
if mapid==mapIdType.zhufeng then
return downAssetManager:needDownLoadSceneEx(SCENE_TYPE.home,notice)
elseif mapid==mapIdType.lingshoudao then
return downAssetManager:needDownLoadResGroupNotice(ASSET_GROUP_TYPE.eLingShouCommon,'灵兽岛',notice)
elseif mapid==mapIdType.xianzhan then
return downAssetManager:needDownLoadResGroupNotice(ASSET_GROUP_TYPE.eXianZhan,'仙栈',notice)
elseif mapid==mapIdType.xianmeng then
return downAssetManager:needDownLoadResGroupNotice(ASSET_GROUP_TYPE.exianmeng,'仙盟',notice)
elseif mapid==mapIdType.zhufeng_hy then
return downAssetManager:needDownLoadSceneEx(SCENE_TYPE.home,notice)
elseif mapid==mapIdType.zhufeng_design then
return downAssetManager:needDownLoadSceneEx(SCENE_TYPE.home,notice)
elseif mapid==mapIdType.fort then
return downAssetManager:needDownLoadResGroupNotice(ASSET_GROUP_TYPE.efort,'堡垒',notice)
end
return true
end





function downAssetManager:needDownLoadMiJing(id)
local cfg=cfg_secretscenefubenconfig_get(id)
local resgroupid=cfg.resgroupid
local name=cfg.name
return downAssetManager:needDownLoadResGroup(resgroupid,name)
end

function downAssetManager:needDownLoadMiJingWithNotice(id,notice,showFinish)
local cfg=cfg_secretscenefubenconfig_get(id)
local resgroupid=cfg.resgroupid
local name=cfg.name
return downAssetManager:needDownLoadResGroupNotice(resgroupid,name,notice,showFinish)
end


function downAssetManager.preDownMijing(taskid)
if not webGLHelper:isRunWeiXin()then return end
local taskcfg=taskModel:getTaskConfig(taskid)
if taskcfg.downloadmj then
for _,v in ipairs(taskcfg.downloadmj)do
downAssetManager:needDownLoadMiJingWithNotice(v,false,false)
end
end
end





function downAssetManager:needDownLoadBattleStage(id,name)
local cfg=fightModel:getStage(id)
local resgroupid=cfg.resgroupid
name=name or'战斗场景'
return downAssetManager:needDownLoadResGroup(resgroupid,name)
end

function downAssetManager:needDownLoadBattleStageByReport(reportStr,name)
local fightInfo=fightModel:getJsonReport(reportStr)
local stageId=fightModel:getBattleStage(fightInfo)
local cfg=fightModel:getStage(stageId)
local resgroupid=cfg.resgroupid
name=name or'战斗场景'
return downAssetManager:needDownLoadResGroup(resgroupid,name)
end

function downAssetManager:needDownLoadBattleStageNotice(id,name,notice)
local cfg=fightModel:getStage(id)
local resgroupid=cfg.resgroupid
name=name or'战斗场景'
return downAssetManager:needDownLoadResGroupNotice(resgroupid,name,notice)
end


function downAssetManager:needDownLoadResGroup(resgroupid,name,showFinish)
if webGLHelper:skipDownLoadResGroup()then
return false
end
local downLoadType=downAssetManager:getDownLoadState(resgroupid,true,nil,name,showFinish)
if downLoadType==DOWNLOAD_TYPE.eDownLoaded then
return false
elseif downLoadType==DOWNLOAD_TYPE.eDownLoading then
return true,downLoadType
elseif downLoadType==DOWNLOAD_TYPE.eUnDownLoad then
return true,downLoadType
end
return false,downLoadType
end









function downAssetManager:needDownLoadResGroupNotice(resgroupid,name,notice,showFinish)
if webGLHelper:skipDownLoadResGroup()then
return false
end
local downLoadType=downAssetManager:getDownLoadStateWithNotice(resgroupid,true,name,notice,showFinish)
if downLoadType==DOWNLOAD_TYPE.eDownLoaded then
return false
elseif downLoadType==DOWNLOAD_TYPE.eDownLoading then
return true,downLoadType
elseif downLoadType==DOWNLOAD_TYPE.eUnDownLoad then
return true,downLoadType
end
return false,downLoadType
end










function downAssetManager:needDownLoadBundle(abName)
return _IsNeedDownLoadAssetbundle(abName)
end


function downAssetManager:canDownLoad()
local flag=not downAssetManager.forceDownFinish or
not downAssetManager.packageDownFinish

return flag
end


function downAssetManager:visDownLoadEnterWin()
local canDownLoad=downAssetManager:canDownLoad()
local clickFinish=self.clickFinish
return appUtils.enableDebug and(canDownLoad or not clickFinish)
end


function downAssetManager:getDownLoadCheckData()
local downloadCheckData={}
local pfs={'weixin'}
for i,v in ipairs(pfs)do
downloadCheckData[v]={}
end
local cfgs=cfg_LogicPackedConfig()
for k,v in pairs(cfgs)do
for kk,vv in pairs(downloadCheckData)do
if v[kk]then
vv[v.id]=v.groupArray
end
end
end
self.downloadCheckData=downloadCheckData
end

function downAssetManager:initWebGLSetting()
if webGLHelper:isRunWeiXin()then
local setting={}
if not webGLHelper:isEnableABWriteFile()then
local pfType=deviceHelper.getAppPlatformType()
if pfType~='None'then
local pfData=self.downloadCheckData[pfType]
if pfData then
local list={}
for k,v in pairs(pfData)do
for ii,vv in ipairs(v)do
list[vv]=true
end
end
local rlist={}
for k,v in pairs(list)do
table.insert(rlist,k)
end
setting.writeABGroup=rlist
setting.writeABGroupLength=#rlist
setting.enableABWriteFile=false
else
setting.enableABWriteFile=true
end
else
setting.enableABWriteFile=true
end
else
setting.enableABWriteFile=true
end
_WXInterface.InitSetting(setting)
end
end

function downAssetManager:isAllowDownload(id)
if webGLHelper:isRunWeiXin()then

if id==0 then
return true
end
local pfType=deviceHelper.getAppPlatformType()
if pfType=='None'then
return true
else
local pfData=self.downloadCheckData[pfType]
if not pfData then
logErr('未配置类型，默认开启下载',pfType)
return true
end
local check=pfData[id]
return check~=nil
end
else
return id>0
end
end







function downAssetManager:init()
if self.isInit then return end
self.isInit=true


self.downPackageTotalInfo={}
self.downPackageTotalIndex={}

self.curPackageInfo=nil
self.totalPackage=1
self.remainPackage=1
self.curDownTotalFileCount=0
self.curGroupFileDownCount=1
self.curPackDownCount=1
self.curPackFileCount=1

self.downMode=0
self.hasPackageDownLoading=false
self.packageDownFinish=false
self.hasReward=false
self.hasInitReward=false
self.hasReportResVersion=false
self.allowDown=true
self.allowCarrierNetDown=true

self.hasForceGroupDown=false
self.forceDownFinish=true
self.forceDownResGroupID=-1
self.forceDownLoadName=''
self.forceGroupFileCountDown=0
self.forceGroupFileCount=1
self.forceGroupFileSizeDown=0
self.forceGroupFileSize=1
self.simulationProgress=0
self.forceGroupFileSpeed=0
self.clickFinish=false

self.curNetType=_GetCurrentInternetReachability()

self:getDownLoadCheckData()
self:initWebGLSetting()


_InitPackInfo()
local packageInfo=cfg_LogicPackedConfig()
local packageTotalFileCount=0
for k,v in pairs(packageInfo)do
if self:isAllowDownload(v.id)then
local rawData=_GetTotalNeedUpdatePackageSize(v.packId,false)
local itemNum=#rawData

if itemNum>0 then
local packInfo={}
packInfo.groups={}
packInfo.groupInfo={}
packInfo.size=0
packInfo.fileCount=0
packInfo.id=v.packId
packInfo.downCount=0
packInfo.curGroupDownCount=0

for i=1,itemNum,3 do
local groupInfo={}
groupInfo.groupID=rawData[i]
groupInfo.groupSize=rawData[i+1]
groupInfo.groupFileCount=rawData[i+2]
groupInfo.downSizeWhenBreak=0
groupInfo.downCount=0
groupInfo.downSize=0

packInfo.size=packInfo.size+groupInfo.groupSize
packInfo.fileCount=packInfo.fileCount+groupInfo.groupFileCount
packInfo.groupInfo[groupInfo.groupID]=groupInfo
table.insert(packInfo.groups,groupInfo.groupID)
end

packageTotalFileCount=packageTotalFileCount+packInfo.fileCount
self.downPackageTotalInfo[v.packId]=packInfo
self.downPackageTotalIndex[#self.downPackageTotalIndex+1]=v.packId
end
end
end

self.packageTotalFileCount=packageTotalFileCount
self.totalPackage=#self.downPackageTotalIndex
self.remainPackage=#self.downPackageTotalIndex
if#self.downPackageTotalIndex>1 then
table.sort(self.downPackageTotalIndex,function(a,b)
return a<b
end)
end


if self.packageTotalFileCount>0 then
self.clickFinish=false
self.packageDownFinish=false

if not webGLHelper:isSkipAutoDownload()then
self:startDownLoad(false)
end
else
self.clickFinish=true
self.packageDownFinish=true
end
if deviceHelper.isRunWebGL()then
self:setDownloadMax(0.2,3)
else
self:setDownloadMax(0.05,3)
end
end



function downAssetManager.checkNetTypeState()

downAssetManager.curNetType=_GetCurrentInternetReachability()
if downAssetManager.curNetType==eNetworkReachability.ViaCarrierData then
if downAssetManager.allowCarrierNetDown then
if downAssetManager.hasPackageDownLoading==false then
downAssetManager:startDownLoad(false)
end
else
if downAssetManager.hasPackageDownLoading==true then
downAssetManager:stopDownLoad()
end
end
else
if downAssetManager.allowDown then
if downAssetManager.hasPackageDownLoading==false then
downAssetManager:startDownLoad(false)
end
end
end
end


function downAssetManager:getDownPrecent()
if self.downMode==0 then
if self.packageTotalFileCount==0 then
return 100
else
return 100*(self.curDownTotalFileCount+self.curPackDownCount+self.curGroupFileDownCount)/self.packageTotalFileCount
end
elseif self.downMode==1 then
return self.simulationProgress
else
return 0
end
end



function downAssetManager:allPackageDownLoad(shopTip)

self.curPackageInfo=nil
self.packageDownFinish=true
downAssetManager:stopDownLoad()
downAssetManager.flushLoadWinData()
end


function downAssetManager:startDownStateCheck()
if self.netStateCheckTime==nil then
self.netStateCheckTime=timer.new()
self.netStateCheckTime:start(1,downAssetManager.checkNetTypeState)
end
downAssetManager.checkNetTypeState()
end

function downAssetManager:startDownTask(mode)
self.downMode=mode
end







function downAssetManager.onPackageGroupDownFinish(groupid,resVersion,retCode)

if retCode>0 then
local curPackInfo=downAssetManager.curPackageInfo
local groupInfo=curPackInfo.groupInfo[groupid]
if groupInfo~=nil then
curPackInfo.downCount=curPackInfo.downCount+groupInfo.groupFileCount
else
curPackInfo.downCount=curPackInfo.downCount+curPackInfo.curGroupDownCount
end
curPackInfo.curGroupDownCount=0
downAssetManager.curPackDownCount=curPackInfo.downCount
downAssetManager.curGroupFileDownCount=0
downAssetManager:flushPackageDownUI()
elseif retCode==0 then

local curPackInfo=downAssetManager.curPackageInfo
downAssetManager.curPackageInfo=nil

curPackInfo.downCount=curPackInfo.fileCount
curPackInfo.curGroupDownCount=0
downAssetManager.curPackDownCount=0
downAssetManager.curGroupFileDownCount=0
downAssetManager.curDownTotalFileCount=downAssetManager.curDownTotalFileCount+curPackInfo.fileCount
downAssetManager:flushPackageDownUI()
local packId=curPackInfo.id
for i,v in ipairs(downAssetManager.downPackageTotalIndex)do
if packId==v then
table.remove(downAssetManager.downPackageTotalIndex,i)
break
end
end

downAssetManager:startDownLoad(true)

elseif retCode==-1 then



downAssetManager:stopDownLoad()
elseif retCode==-2 then
downAssetManager:stopDownLoad()
end
end



function downAssetManager.onPackageSingleFileDown(fval,totalSize,fileName,speed)
local curPackInfo=downAssetManager.curPackageInfo
if curPackInfo~=nil then
curPackInfo.curGroupDownCount=curPackInfo.curGroupDownCount+1
downAssetManager.curGroupFileDownCount=curPackInfo.curGroupDownCount
end
local precent=downAssetManager:getDownPrecent()
pfCommonHelper.DownloadProgressReport(precent)
downAssetManager:flushPackageDownUI()
end


function downAssetManager:startDownLoad(showTip)


downAssetManager:refreshNextDownLoadAsset()
local remainPackage=#self.downPackageTotalIndex
self.remainPackage=remainPackage
if downAssetManager.hasNextDownPackage()then
if self.hasForceGroupDown==true then return end
downAssetManager.flushLoadWinData()
self:startDownTask(0)
self.hasPackageDownLoading=true
self:startDownStateCheck()

local curPackageInfo=self.curPackageInfo
self.curGroupFileDownCount=curPackageInfo.curGroupDownCount
self.curPackDownCount=curPackageInfo.downCount
self.curPackFileCount=curPackageInfo.fileCount
local groupArray=curPackageInfo.groups

downAssetSubPackage:startDownPackage(groupArray,
downAssetManager.onPackageSingleFileDown,
downAssetManager.onPackageGroupDownFinish)
else
if remainPackage==0 then
downAssetManager:allPackageDownLoad(showTip)
else
if self.hasForceGroupDown==true then return end
downAssetManager:stopDownLoad()
end
end
end


function downAssetManager:stopDownLoad()

downAssetManager.flushLoadWinData()
if downAssetManager.netStateCheckTime~=nil then
downAssetManager.netStateCheckTime:cancel()
downAssetManager.netStateCheckTime=nil
end
self.hasPackageDownLoading=false
downAssetSubPackage:stopDownPackage()
end


function downAssetManager:pauseDownLoad()

if downAssetManager.hasPackageDownLoading==true then
downAssetManager:stopDownLoad()
end
end


function downAssetManager:resumeDownLoad()

if webGLHelper:isSkipAutoDownload()then
return
end
self:startDownTask(0)
self:flushPackageDownUI()
local remainPackage=#self.downPackageTotalIndex
self.remainPackage=remainPackage
if remainPackage>0 then
self:refreshNextDownLoadAsset()
self:startDownStateCheck()
end
end


function downAssetManager:checkGroupDownLoad(groupID)
local size=_GetTotalNeedUpdateGroupSize(groupID,false)
return tonumber(tostring(size))
end

function downAssetManager:checkGroupArrayDown(groupArray)
for i,v in ipairs(groupArray)do
local count=_GetTotalNeedUpdateFileCount(v,false)
if count>0 then
return 1
end
end

return 0
end



function downAssetManager:getDownLoadState(resgroupid,startDown,tips,name,showFinish)
if resgroupid==nil then return DOWNLOAD_TYPE.eDownLoaded end
local groupIDs=cfg_resourcesgroupconfig_get(resgroupid).groupids
if#groupIDs==0 or(#groupIDs==1 and groupIDs[1]==0)then
return DOWNLOAD_TYPE.eDownLoaded
end

if showFinish==nil then showFinish=true end
for _,v in ipairs(groupIDs)do
self.showRetDialogue[v]=showFinish
end

local fileCount=self:checkGroupArrayDown(groupIDs)
if fileCount>0 then
if self.forceDownResGroupID~=-1 then
if self.forceDownResGroupID==resgroupid then
UIManager.error(downAssetManager.forceDownLoadName.."正在下载中,请祖师耐心等待")
else
UIManager.error("正在下载"..downAssetManager.forceDownLoadName..",请祖师耐心等待")
end
return DOWNLOAD_TYPE.eDownLoading
end

if startDown then
if not self.onDownLoadReq then
self.onDownLoadReq=UIDialogManager.newConfirmDialog()
end

self.onDownLoadReq.oktext='确定'
self.onDownLoadReq.canceltext='取消'

self.onDownLoadReq.content=string.format('需要下载%s场景才能进入',name)

self.onDownLoadReq.okcallback=function()

downAssetManager:downGroup(resgroupid,name)

end
self.onDownLoadReq:show()
else
if tips then
UIManager.error(tips)
end
end

return DOWNLOAD_TYPE.eUnDownLoad
else
return DOWNLOAD_TYPE.eDownLoaded
end
end




function downAssetManager:getDownLoadStateWithNotice(resgroupid,startDown,name,notice,showFinish)
if resgroupid==nil then return DOWNLOAD_TYPE.eDownLoaded end

local groupIDs=cfg_resourcesgroupconfig_get(resgroupid).groupids
if#groupIDs==0 or(#groupIDs==1 and groupIDs[1]==0)then
return DOWNLOAD_TYPE.eDownLoaded
end

if showFinish==nil then showFinish=true end
for _,v in ipairs(groupIDs)do
self.showRetDialogue[v]=showFinish
end

local fileCount=self:checkGroupArrayDown(groupIDs)
if fileCount>0 then
if self.forceDownResGroupID~=-1 then
if notice then
if self.forceDownResGroupID==resgroupid then
UIManager.error(downAssetManager.forceDownLoadName.."正在下载,请祖师耐心等待")
else
UIManager.error("正在下载"..downAssetManager.forceDownLoadName..',请祖师耐心等待')
end
end
return DOWNLOAD_TYPE.eDownLoading
end

if startDown then
if notice then
if not self.onDownLoadReq then
self.onDownLoadReq=UIDialogManager.newConfirmDialog()
end

self.onDownLoadReq.oktext='确定'
self.onDownLoadReq.canceltext='取消'

self.onDownLoadReq.content=string.format('需要下载%s场景才能进入',name)

self.onDownLoadReq.okcallback=function()

downAssetManager:downGroup(resgroupid,name)

end
self.onDownLoadReq:show()
else
downAssetManager:downGroup(resgroupid,name)
end
else
if notice then
UIManager.error(tips)
end
end

return DOWNLOAD_TYPE.eUnDownLoad
else
return DOWNLOAD_TYPE.eDownLoaded
end
end


function downAssetManager.onForceDownGroupFinish(errorcode,groupid,resVersion)

if errorcode==nil then



if downAssetManager.curDownIndex>=#downAssetManager.downGroups then
local id=downAssetManager.forceDownResGroupID
local fileCount=downAssetManager.forceGroupFileCount
downAssetManager.forceDownResGroupID=-1
downAssetManager.forceDownFinish=true
downAssetManager.hasForceGroupDown=false
if downAssetManager.forceProgressTime~=nil then
downAssetManager.forceProgressTime:cancel()
downAssetManager.forceProgressTime=nil
end

if downAssetManager.showRetDialogue[groupid]and
(not(webGLHelper:isSkipAutoDownload()and id==ASSET_GROUP_TYPE.eBaseRes))then
UIManager:showWindow('UIAssetLoadSceneWin')
end
downAssetManager:resumeDownLoad()
downloadAssetWithFileManager.onDownLoadBundleFinished(id,fileCount,fileCount,'')
else
downAssetManager:forceDownLoadGroup()
end
else
local id=downAssetManager.forceDownResGroupID
local fileCount=downAssetManager.forceGroupFileCount
local downSize=downAssetManager.forceGroupFileSizeDown
downAssetManager.forceDownResGroupID=-1
downAssetManager.forceDownFinish=true
downAssetManager.hasForceGroupDown=false

downAssetManager:resumeDownLoad()
downAssetManager:forceDownFailed()
downloadAssetWithFileManager.onDownLoadBundleFinished(id,downSize,fileCount,'下载失败，请稍后重试')
end
end


function downAssetManager.onForceDownGroupSingleFile(fval,totalSize,fileName,speed)
downAssetManager.forceGroupFileCountDown=downAssetManager.forceGroupFileCountDown+1
downAssetManager.forceGroupFileSizeDown=downAssetManager.forceGroupFileSizeDown+totalSize
downAssetManager.forceGroupFileSpeed=speed
local realProgress=downAssetManager.forceGroupFileCountDown*100/downAssetManager.forceGroupFileCount
if downAssetManager.simulationProgress<realProgress then
downAssetManager.simulationProgress=realProgress
end

downAssetManager:flushSceneWin('flushProgress',true)

downAssetManager:freshDownLoadProgress()

downloadAssetWithFileManager.onDownLoadBundleProgress(downAssetManager.forceDownResGroupID,downAssetManager.forceGroupFileCountDown,downAssetManager.forceGroupFileCount)
end

function downAssetManager:getTotalGroupNeedDownLoadSize(resgroupid)
local groupIDs=cfg_resourcesgroupconfig_get(resgroupid).groupids
local downLoadGroups={}
local size=0
local count=0
for i,v in ipairs(groupIDs)do
local gSize,gVersion,gCount=_GetTotalNeedUpdateFileSize(v,true,0,0)
if gCount>0 then
size=size+gSize
count=count+gCount
downLoadGroups[#downLoadGroups+1]=v
end
end
return count,size,downLoadGroups
end


function downAssetManager:downGroup(resgroupid,name)
downAssetManager:pauseDownLoad()
self:startDownTask(1)
downAssetManager.forceDownFinish=false
downAssetManager.flushLoadWinData()

local size=0
local count=0
local groupIDs=cfg_resourcesgroupconfig_get(resgroupid).groupids
local downLoadGroups={}
for i,v in ipairs(groupIDs)do
local gSize,gVersion,gCount=_GetTotalNeedUpdateFileSize(v,true,0,0)
if gCount>0 then
size=size+gSize
count=count+gCount
downLoadGroups[#downLoadGroups+1]=v
end
end

if self.forceDownResGroupID~=resgroupid then
self.forceGroupFileCountDown=0
self.forceGroupFileCount=count
self.forceGroupFileSizeDown=0
self.forceGroupFileSize=size
end

self.hasForceGroupDown=true
self.forceDownResGroupID=resgroupid
self.forceDownLoadName=name
self.simulationProgress=0
self.curDownIndex=0
self.downGroups=downLoadGroups
if size==0 then
self.onForceDownGroupFinish()
else

if self.forceProgressTime~=nil then
self.forceProgressTime:cancel()
self.forceProgressTime=nil
end

local flushForceProgressCall=function(...)
self.simulationProgress=self.simulationProgress+(100-self.simulationProgress)/50
downAssetManager:flushSceneWin('set_ProgressBar',self.simulationProgress,100)
downAssetManager:freshDownLoadProgress()
end
self.forceProgressTime=timer.new()
self.forceProgressTime:start(1,flushForceProgressCall)

downAssetManager:forceDownLoadGroup()
end
end


function downAssetManager:forceDownLoadGroup()
local curDownIndex=self.curDownIndex
self.curDownIndex=self.curDownIndex+1
if self.curDownIndex>#self.downGroups then
self.onForceDownGroupFinish()
return
end

local groupID=self.downGroups[self.curDownIndex]
local size=downAssetGroup:startDownGroup(groupID,self.onForceDownGroupSingleFile,self.onForceDownGroupFinish,5)

if size==0 then
downAssetManager:forceDownLoadGroup()
elseif size==-1 then
local id=downAssetManager.forceDownResGroupID
local fileCount=downAssetManager.forceGroupFileCount
local downSize=downAssetManager.forceGroupFileSizeDown
downAssetManager.forceDownResGroupID=-1
downAssetManager.hasForceGroupDown=false
downAssetManager.forceDownFinish=true
self:forceDownFailed()
downAssetManager:resumeDownLoad()
downloadAssetWithFileManager.onDownLoadBundleFinished(id,downSize,fileCount,'下载失败，请稍后重试')
end
end


function downAssetManager:forceDownFailed()
UIManager:closeWindow('UIAssetLoadSceneWin')
if self.forceProgressTime~=nil then
self.forceProgressTime:cancel()
self.forceProgressTime=nil
end

if not self.forceDownFailedTip then
self.forceDownFailedTip=UIDialogManager.newConfirmDialog()
end
self.forceDownFailedTip.oktext='确定'
self.forceDownFailedTip.showclosebtn=false

self.forceDownFailedTip.content=self.forceDownLoadName..'下载出现异常,稍后重试'
self.forceDownFailedTip:show()
end





function downAssetManager:flushPackageDownUI()
downAssetManager.flushLoadWinData()
downAssetManager:freshDownLoadProgress()
end

function downAssetManager.flushLoadWinData()
downAssetManager:flushLoadWin('flushData')
end

function downAssetManager:flushLoadWin(func,...)
UIManager:callWindowFunc('UIAssetLoadWin',func,...)
end

function downAssetManager:flushSceneWin(func,...)
UIManager:callWindowFunc('UIAssetLoadSceneWin',func,...)
end

function downAssetManager:freshDownLoadProgress()
UIManager:callWindowFunc('UIAssetLoadEnterWin','onflushProgressTxt')
end

function downAssetManager:closeAssetLoadEnter()
self.clickFinish=true
if not downAssetManager:visDownLoadEnterWin()then
UIManager:closeWindow('UIAssetLoadEnterWin')
end
end


function downAssetManager:refreshNextDownLoadAsset()
if self.curPackageInfo then return end
for _,v in ipairs(self.downPackageTotalIndex)do
local cfg=cfg_LogicPackedConfig_get(v)
if self:checkCND(cfg)then
self.curPackageInfo=self.downPackageTotalInfo[v]
break
end
end
end

function downAssetManager:checkCND(cfg)

local level=initProControl.isDone()and zongmenModel:getLevel()or 10000000
return downAssetManager:isAllowDownload(cfg.id)and
(cfg.level==nil or cfg.level<=level)
end

function downAssetManager.hasNextDownPackage()
return downAssetManager.curPackageInfo~=nil
end

function downAssetManager.onBuildEvent(etype)
if etype==buildingEvent.zongmenLevelUp then
downAssetManager:startNextDownload()
end
end

function downAssetManager:startNextDownload()
if webGLHelper:isSkipAutoDownload()then
return
end
downAssetManager:refreshNextDownLoadAsset()
if downAssetManager.hasNextDownPackage()then
downAssetManager:startDownLoad()
end
end

function downAssetManager:setDownloadMax(space,count)
_SetDownloadParam(space,count)
self.maxDownloadMaxCount=count
end

function downAssetManager:getDownloadMax()
return self.maxDownloadMaxCount or 3
end