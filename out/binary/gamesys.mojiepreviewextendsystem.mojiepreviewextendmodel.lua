






local _MODULENAME="MojiePreviewExtendModel"


def_table(_MODULENAME)
MojiePreviewExtendModel.name=_MODULENAME
MojiePreviewExtendModel.data={}

function MojiePreviewExtendModel:onAppStart()

end


function MojiePreviewExtendModel:onEnterState(isReconnect)

end


function MojiePreviewExtendModel:onProtocolReq()

end


function MojiePreviewExtendModel:onLeaveState(isReconnect)

self.data={}
end

function MojiePreviewExtendModel:setData(data)
self.data=data
end

function MojiePreviewExtendModel:getData()
return self.data
end

function MojiePreviewExtendModel:setSeverData(data)
self.severData=data
end

function MojiePreviewExtendModel:getSeverData()
return self.severData
end











function MojiePreviewExtendModel:getData_seasonId()
return self.data.seasonId or 0
end

function MojiePreviewExtendModel:getData_taskId(refresh)
if not self.data.taskId or refresh then
self.data.taskId=1
local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local config=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
local nowTime=timeHelper.getServerShortTime()
local starTime=enterData.sTime-config.preview[1]*86400
local stratYuGaoDayZeroTime=timeHelper.getServerZeroShortStamp(starTime)
if nowTime>=stratYuGaoDayZeroTime then
local leftDay=math.ceil((nowTime-stratYuGaoDayZeroTime)/86400)
if leftDay==0 then
leftDay=1
end
local baseCfg=cfg_mojieyugaoextbaseconfig_get(enterData.sId)
local mytask=baseCfg.mytask
if mytask[leftDay]then
self.data.taskId=mytask[leftDay]
else
if leftDay<=config.preview[1]then
logErr(FMT.fmt("赛季 {0}预告 缺少 第{1}天的任务id配置",enterData.sId,leftDay))
end
end
end

end

end

return self.data.taskId
end

function MojiePreviewExtendModel:getData_myScore()
return self.data.myScore or 0
end

function MojiePreviewExtendModel:getData_myReward()
return self.data.myReward or 0
end

function MojiePreviewExtendModel:getData_xianyuScore()
return self.data.xianyuScore or 0
end

function MojiePreviewExtendModel:getData_xianyuReward()
return self.data.xianyuReward or 0
end

function MojiePreviewExtendModel:getData_bzzmRwFlag()
return self.data.bzzmRwFlag or 0
end

function MojiePreviewExtendModel:getData_chapterMaxId()
return self.data.chapterMaxId or 0
end

function MojiePreviewExtendModel:getData_mzyhReward()
return self.data.mzyhReward or 0
end



