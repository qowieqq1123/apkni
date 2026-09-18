downloadAssetWithFileManager=gameState.addListener({})

local startDownloadFile=CS.ResourceHelper.StartDownloadFileEx
local stopDownloadFile=CS.ResourceHelper.StopDownloadFile

function downloadAssetWithFileManager:onAppStart(...)
downloadAssetWithFileManager:initCfgs()
downloadAssetWithFileManager:clearCurrentData()
downloadAssetWithFileManager:clearAllData()
end

function downloadAssetWithFileManager:onEnterState()

end

function downloadAssetWithFileManager:onLeaveState()

end

function downloadAssetWithFileManager:clearAllData()
self.progressLookup={}
self.bundleProgress={}

self.fileCurrentDownData={}
self.fileLastDownloadData={}
downloadAssetWithFileManager:initReadFileProgress()
end


function downloadAssetWithFileManager:clearCurrentData()
self.fileGroupid=nil
self.downloadId=nil
self.resgroupid=nil
self.totalSize=0
self.downSize=0
end

function downloadAssetWithFileManager:initCfgs()
self.fileLookup={}
local cfgs=cfg_downloadfileconfig()
for _,v in ipairs(cfgs)do
self.fileLookup[v.filepath]=v.id
end
end

function downloadAssetWithFileManager.onDownLoadBundleFinished(resgroupid,size,total,error)
local self=downloadAssetWithFileManager
self.bundleProgress[resgroupid]={size,total}

if resgroupid==self.resgroupid then
downloadAssetWithFileManager:refreshTotalProgress()
if error==''then
downloadAssetWithFileManager:onBundleDownloaded()
downloadAssetWithFileManager:flushWindow(DOWNLOAD_TYPE.eDownLoading)
downloadAssetWithFileManager:downloadNext()
else
local name=cfgHelper.get2(cfg_downloadfilegroupconfig_get,self.fileGroupid,'name')
downloadAssetWithFileManager:onLoadFailed(error)
UIManager.error(FMT.fmt('{0}{1}',name,error))
end
end
end

function downloadAssetWithFileManager.onDownLoadBundleProgress(resgroupid,size,total)
local self=downloadAssetWithFileManager
self.bundleProgress[resgroupid]={size,total}

if resgroupid==self.resgroupid then
downloadAssetWithFileManager:refreshTotalProgress()
downloadAssetWithFileManager:flushWindow(DOWNLOAD_TYPE.eDownLoading)
end
end

function downloadAssetWithFileManager.onDownLoadFinished(key,filePath,error)
local self=downloadAssetWithFileManager
local downloadId=self.fileLookup[filePath]

if downloadId==nil then
loggerUtil.logErrFMT('没有找到路径对应的文件下载id：{0}',filePath)
return
end
local cfg=downloadAssetWithFileManager:getDownLoadFileConfig(downloadId)
local totalSize=tonumber(cfg.size)
if error==''then
downloadAssetWithFileManager:saveFileProgress(downloadId,totalSize,true)
end
if not self.fileGroupid then return end
if not downloadAssetWithFileManager:hasDownloadId(self.fileGroupid,downloadId)then return end

local oldProgress=self.fileCurrentDownData[downloadId]
local total=oldProgress[2]
oldProgress[1]=total


downloadAssetWithFileManager:refreshTotalProgress()
if error==''then
downloadAssetWithFileManager:onFileDownloaded(downloadId)
downloadAssetWithFileManager:flushWindow(DOWNLOAD_TYPE.eDownLoading)
downloadAssetWithFileManager:downloadNext()
else
local name=cfgHelper.get2(cfg_downloadfilegroupconfig_get,self.fileGroupid,'name')
downloadAssetWithFileManager:onLoadFailed(error)
UIManager.error(FMT.fmt('{0}下载失败，请稍后重试',name))

end
end

function downloadAssetWithFileManager.onDownLoadProgress(key,filePath,progress)
local self=downloadAssetWithFileManager
local downloadId=self.fileLookup[filePath]

if downloadId==nil then
loggerUtil.logErrFMT('没有找到路径对应的文件下载id：{0}',filePath)
return
end
local cfg=downloadAssetWithFileManager:getDownLoadFileConfig(downloadId)
local totalSize=tonumber(cfg.size)
local downSize=tonumber(totalSize*progress)
downloadAssetWithFileManager:saveFileProgress(downloadId,downSize)

if not self.fileGroupid then return end
if not downloadAssetWithFileManager:hasDownloadId(self.fileGroupid,downloadId)then return end

local oldProgress=self.fileCurrentDownData[downloadId]or{}
local orginDownSize=self.fileLastDownloadData[downloadId]or 0
oldProgress[1]=math.max(0,downSize-orginDownSize)

downloadAssetWithFileManager:refreshTotalProgress()
downloadAssetWithFileManager:flushWindow(DOWNLOAD_TYPE.eDownLoading)
end

function downloadAssetWithFileManager:onFinished()
if self.fileGroupid then
local fileGroupid=self.fileGroupid
self.downSize=self.totalSize
local totalSize=self.totalSize
self.progressLookup[self.fileGroupid]={self.downSize,self.totalSize}
downloadAssetWithFileManager:flushWindow(DOWNLOAD_TYPE.eDownLoaded)
downloadAssetWithFileManager:clearCurrentData()
local name=cfgHelper.get2(cfg_downloadfilegroupconfig_get,fileGroupid,'name')
if not UIManager:callWindowFunc('UIFileDownDoadDialogueWin','onLoadSuccess',fileGroupid,totalSize)then
UIManager.error(FMT.fmt('{0}下载完成',name))
end

end
end

function downloadAssetWithFileManager:onLoadFailed(error)
local fileGroupid=self.fileGroupid
downloadAssetWithFileManager:clearCurrentData()
if downAssetManager.forceDownResGroupID==-1 then
downAssetManager:resumeDownLoad()
end
if not UIManager:callWindowFunc('UIFileDownDoadDialogueWin','onLoadFailed',fileGroupid)then
local fileCfg=cfg_downloadfilegroupconfig_get(fileGroupid)
UIManager.error(FMT.fmt('{0}下载失败，请稍后继续',fileCfg.name))
end
end





function downloadAssetWithFileManager:stratDownLoad(fileGroupid,showDialogue)
if webGLHelper:skipDownLoadResGroup()then return false end
if downloadAssetWithFileManager:isDownLoadFinish(fileGroupid)then return false end

if self.fileGroupid then
local name=cfgHelper.get2(cfg_downloadfilegroupconfig_get,self.fileGroupid,'name')
if fileGroupid==self.fileGroupid then
downloadAssetWithFileManager:showDownloadDialogue(showDialogue)
UIManager.error(name.."正在下载,请祖师耐心等待")
else
UIManager.error("正在下载"..name..',请祖师耐心等待')
end
return true
elseif downAssetManager.forceDownResGroupID>=0 then
local name=cfgHelper.get2(cfg_downloadfilegroupconfig_get,downAssetManager.forceDownResGroupID,'name')
UIManager.error(name.."正在下载,请祖师耐心等待")
return true
end

self.totalSize=0
self.downSize=0
self.fileGroupid=fileGroupid

local fileCfg=cfg_downloadfilegroupconfig_get(fileGroupid)
local gameVersion=pfwindowslController:getGameVersion()
local downloadFileIds=fileCfg.downloadFileIds
if downloadFileIds then
downloadFileIds=downloadFileIds[gameVersion]or downloadFileIds[1]
end

self.downloadFileIds={}
if downloadFileIds then
local size,list=downloadAssetWithFileManager:getTotalFileNeedDownLoadSize(downloadFileIds)
self.totalSize=self.totalSize+size

if size>0 then
self.downloadFileIds=list
for _,downloadId in ipairs(list)do
downloadAssetWithFileManager:readFileProgress(downloadId)
local orginDownSize=self.fileLastDownloadData[downloadId]or 0
local totalSizeStr=cfgHelper.get2(cfg_downloadfileconfig_get,downloadId,'size')
local totalSize=tonumber(totalSizeStr)
self.fileCurrentDownData[downloadId]={0,totalSize-orginDownSize}
end
end
end

local resgroupid=fileCfg.resgroupid
if resgroupid then
local count,size=downAssetManager:getTotalGroupNeedDownLoadSize(resgroupid)
self.totalSize=self.totalSize+size

if size>0 then
self.resgroupid=resgroupid
self.bundleProgress[resgroupid]={0,size}
end
end
self.progressLookup[fileGroupid]={0,self.totalSize}

if self.totalSize<=0 then
downloadAssetWithFileManager:clearCurrentData()
return false
end


local ret=downloadAssetWithFileManager:downloadNext(showDialogue)
if not ret then
downloadAssetWithFileManager:clearCurrentData()
return false
end
return true
end

function downloadAssetWithFileManager:downloadNext(showDialogue)
local fileGroupid=self.fileGroupid

if#self.downloadFileIds>0 then
self.downloadId=table.remove(self.downloadFileIds,1)
downAssetManager:pauseDownLoad()
downloadAssetWithFileManager:downloadFile(self.downloadId)
downloadAssetWithFileManager:showDownloadDialogue(showDialogue)
return true
elseif self.resgroupid then
local cfg=cfg_resourcesgroupconfig_get(self.resgroupid)
local ret,loadType=downAssetManager:needDownLoadResGroupNotice(self.resgroupid,cfg.name,false,false)
if ret then
if loadType==DOWNLOAD_TYPE.eDownLoading then
if downAssetManager.forceDownResGroupID==self.resgroupid then
downloadAssetWithFileManager:showDownloadDialogue(showDialogue)
else
UIManager.error("正在下载"..downAssetManager.forceDownLoadName..',请祖师耐心等待')
end
end
end
return ret
else
downloadAssetWithFileManager:onFinished()
end
return false
end

function downloadAssetWithFileManager:isDownLoading()
return self.fileGroupid~=nil
end

function downloadAssetWithFileManager:isDownLoadingAsset(fileGroupid)
return fileGroupid and self.fileGroupid==fileGroupid or false
end

function downloadAssetWithFileManager:getProgress()
return self.downSize,self.totalSize
end

function downloadAssetWithFileManager:hasDownloadId(fileGroupid,downloadId)
local fileCfg=cfg_downloadfilegroupconfig_get(self.fileGroupid)
local gameVersion=pfwindowslController:getGameVersion()
local downloadFileIds=fileCfg.downloadFileIds
if downloadFileIds then
downloadFileIds=downloadFileIds[gameVersion]or downloadFileIds[1]
end
if downloadFileIds==nil then return false end
for i,v in ipairs(downloadFileIds)do
if v==downloadId then return true end
end
return false
end

function downloadAssetWithFileManager:showDownloadTips()
if self.fileGroupid==nil then return end
local fileCfg=cfg_downloadfilegroupconfig_get(self.fileGroupid)
UIManager.error('正在下载{0}正在下载，请祖师耐心等待',fileCfg.name)
end

function downloadAssetWithFileManager:downloadFile(downloadId)
if downloadId==nil then return false end
local cfg=downloadAssetWithFileManager:getDownLoadFileConfig(downloadId)
local url=downloadAssetWithFileManager:getFileDownLoadURL(downloadId)
platformSDK.printSDK('Start downloadFile',downloadId,url)
startDownloadFile(url,cfg.filepath,0,downloadAssetWithFileManager.onDownLoadFinished,downloadAssetWithFileManager.onDownLoadProgress,nil)
end

function downloadAssetWithFileManager:isDownLoadFinish(fileGroupid)
return downloadAssetWithFileManager:getDownLoadSize(fileGroupid)<=0
end

function downloadAssetWithFileManager:getDownLoadSize(fileGroupid)
local fileCfg=cfg_downloadfilegroupconfig_get(fileGroupid)
local gameVersion=pfwindowslController:getGameVersion()
local downloadFileIds=fileCfg.downloadFileIds
if downloadFileIds then
downloadFileIds=downloadFileIds[gameVersion]or downloadFileIds[1]
end
local resgroupid=fileCfg.resgroupid
return downloadAssetWithFileManager:getNeedDownLoadSize(resgroupid,downloadFileIds)or 0
end

function downloadAssetWithFileManager:getNeedDownLoadSize(resgroupid,downloadFileIds)
local count,size=downAssetManager:getTotalGroupNeedDownLoadSize(resgroupid)
local size1=downloadAssetWithFileManager:getTotalFileNeedDownLoadSize(downloadFileIds)
size=size+size1
return size
end

function downloadAssetWithFileManager:getCurDownloadProgress(fileGroupid,total)
local size=downloadAssetWithFileManager:getDownLoadSize(fileGroupid)
local download=total-size
return download/total
end

function downloadAssetWithFileManager:refreshTotalProgress()
if self.fileGroupid==nil then return end
local fileGroupid=self.fileGroupid

local fileCfg=cfg_downloadfilegroupconfig_get(fileGroupid)
local gameVersion=pfwindowslController:getGameVersion()
local downloadFileIds=fileCfg.downloadFileIds
if downloadFileIds then
downloadFileIds=downloadFileIds[gameVersion]or downloadFileIds[1]
end
local resgroupid=fileCfg.resgroupid
local newDownload=0
if downloadFileIds then
for _,downloadId in ipairs(downloadFileIds)do
local curData=self.fileCurrentDownData[downloadId]or{}
local cur=curData[1]or 0
newDownload=newDownload+cur
end
end

if resgroupid then
local curData=self.bundleProgress[resgroupid]or{}
local cur=curData[1]or 0
newDownload=newDownload+cur
end
self.downSize=newDownload
self.progressLookup[fileGroupid]={newDownload,self.totalSize}

local progress=math.floor(self.downSize*100/self.totalSize)
pfCommonHelper.DownloadProgressReport(progress)
end


















function downloadAssetWithFileManager:onFileDownloaded(downloadId)
for i,v in ipairs(self.downloadFileIds)do
if v==downloadId then
table.remove(self.downloadFileIds,i)
break
end
end
if downloadId==self.downloadId then
self.downloadId=nil
end
end

function downloadAssetWithFileManager:onBundleDownloaded()
self.resgroupid=nil
end

function downloadAssetWithFileManager:getTotalFileNeedDownLoadSize(downloadFileIds)
local list={}
for _,downloadId in ipairs(downloadFileIds or{})do
if not downloadAssetWithFileManager:checkDownloadFinish(downloadId)then
list[#list+1]=downloadId
end
end
if#list>0 then
local size=0
for i,downloadId in ipairs(list)do
local needSize=downloadAssetWithFileManager:getFileNeedDownLoadSize(downloadId)
size=size+needSize
end

return size,list
end
return 0,list
end

function downloadAssetWithFileManager:getDownLoadFileConfig(downloadId)
return cfg_downloadfileconfig_get(downloadId)
end

function downloadAssetWithFileManager:checkDownloadFinish(downloadId)
local cfg=downloadAssetWithFileManager:getDownLoadFileConfig(downloadId)
if cfg==nil then
loggerUtil.logErrFMT('资源下载没有id为{0}的配置')
return true
end
local filepath=cfg.filepath
local path=fileHelper.getFullPath(filepath)
if fileHelper.isFileExists(path)then
return true
end
return false
end

function downloadAssetWithFileManager:getFileDownLoadURL(downloadId)
local cfg=downloadAssetWithFileManager:getDownLoadFileConfig(downloadId)
if deviceHelper.isRunEditor()then
return'http://10.10.3.22/'..cfg.filepath
elseif deviceHelper.isRunNonePlatform()then
return string.format('https://reszqzs.xw66.top/pic/%s',cfg.filepath)
else
local cdnRoot=gameInfo:getParams('cdnRootURL')
return string.format('%s/pic/%s',cdnRoot,cfg.filepath)
end
end

function downloadAssetWithFileManager:getFileNeedDownLoadSize(downloadId)
local cfg=downloadAssetWithFileManager:getDownLoadFileConfig(downloadId)
local path=fileHelper.getFullPath(cfg.filepath)
if fileHelper.isFileExists(path)then return 0 end

local size=tonumber(cfg.size)
local tempPath=FMT.fmt('{0}.tmp',path)
if fileHelper.isFileExists(tempPath)then
local downloadsize=self.fileLastDownloadData[downloadId]or 0

return size-downloadsize
end
return size
end


function downloadAssetWithFileManager:getSaveFileProgress(downloadId)
local typo=ACTOR_SETTING_TYPE.eDownLoadFileProgress
local key=string.format('id_%d',downloadId)
local progress=userActorArraySetting.get(ACTOR_SETTING_TYPE.eDownLoadFileProgress,key,0)

return tonumber(progress)
end


function downloadAssetWithFileManager:saveFileProgress(downloadId,downSize,force)
local typo=ACTOR_SETTING_TYPE.eDownLoadFileProgress
local key=string.format('id_%d',downloadId)
local old=userActorArraySetting.get(ACTOR_SETTING_TYPE.eDownLoadFileProgress,key,0)
local cfg=downloadAssetWithFileManager:getDownLoadFileConfig(downloadId)
local totalSize=tonumber(cfg.size)
local progress=downSize/totalSize

local progressStr=string.format('%0.2f',progress)
userActorArraySetting.set(typo,key,progressStr)
local stamp=timeHelper.getServerShortTime()
if force or self.oldStamp==nil or stamp>(self.oldStamp+1)then
self.oldStamp=stamp
userActorArraySetting.flush(typo)
end
end

function downloadAssetWithFileManager:initReadFileProgress()
local typo=ACTOR_SETTING_TYPE.eDownLoadFileProgress
local localData=userActorArraySetting.getBase(typo)
if localData then
for key,progressStr in pairs(localData)do
local downloadIdStr=string.gsub(key,'id_','')
local downloadId=tonumber(downloadIdStr)
local totalSizeStr=cfgHelper.get2(cfg_downloadfileconfig_get,downloadId,'size')
local totalSize=tonumber(totalSizeStr)
local progress=tonumber(progressStr)
local downSize=tonumber(totalSize*progress)
self.fileCurrentDownData[downloadId]={0,totalSize-downSize}
self.fileLastDownloadData[downloadId]=downSize
end
end
end

function downloadAssetWithFileManager:readFileProgress(downloadId)
local totalSizeStr=cfgHelper.get2(cfg_downloadfileconfig_get,downloadId,'size')
local totalSize=tonumber(totalSizeStr)
local progress=downloadAssetWithFileManager:getSaveFileProgress(downloadId)
local downSize=tonumber(totalSize*progress)

self.fileCurrentDownData[downloadId]={0,totalSize-downSize}
self.fileLastDownloadData[downloadId]=downSize
end

function downloadAssetWithFileManager:flushWindow()
local downSize=self.downSize
local totalSize=self.totalSize

UIManager:callWindowFunc('UIFileDownDoadDialogueWin','refreshProgress',{fileGroupid=self.fileGroupid,size=downSize,tsize=totalSize})
UIManager:callWindowFunc('UIJiuChongTianJieStoryWin','refreshProgress',self.fileGroupid,downSize,totalSize)
UIManager:callWindowFunc('UIZongMenReviewWin','refreshProgress',self.fileGroupid,downSize,totalSize)
end

function downloadAssetWithFileManager:showDownloadDialogue(showDialogue)

if self.fileGroupid and showDialogue then
local fileGroupid=self.fileGroupid
local fileCfg=cfg_downloadfilegroupconfig_get(fileGroupid)
local title=FMT.fmt('{0}正在下载中，请祖师耐心等待',fileCfg.name)
local args=
{
fileGroupid=fileGroupid,
size=self.downSize,
tsize=self.totalSize,
title=title,
}
UIManager:showWindow('UIFileDownDoadDialogueWin',args)
UIManager:callWindowFunc('UIJiuChongTianJieStoryWin','showDownProgress')
UIManager:callWindowFunc('UIZongMenReviewWin','showDownProgress')
end
end

function downloadAssetWithFileManager:showDownloadDialogueEx(fileGroupid)
local fileCfg=cfg_downloadfilegroupconfig_get(fileGroupid)
local title=FMT.fmt('{0}正在下载中，请祖师耐心等待',fileCfg.name)
local progressLookup=self.progressLookup[fileGroupid]or{}
local downSize=progressLookup[1]or 0
local totalSize=progressLookup[2]or 0
if fileGroupid~=self.fileGroupid then
if downSize>=totalSize and totalSize~=0 then
title='已下载完成'
end
else
totalSize=self.totalSize
downSize=self.downSize
end
local args=
{
fileGroupid=fileGroupid,
size=downSize,
tsize=totalSize,
title=title,
}
UIManager:showWindow('UIFileDownDoadDialogueWin',args)
end
