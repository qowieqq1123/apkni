






local _MODULENAME="JiuChongTianJieEnterModel"


def_table(_MODULENAME)
JiuChongTianJieEnterModel.name=_MODULENAME
JiuChongTianJieEnterModel.data={}


local _register_list={}
local _register_sublist={}


function JiuChongTianJieEnterModel:onAppStart()

end


function JiuChongTianJieEnterModel:onEnterState(isReconnect)
self.weakNewbie=nil
end


function JiuChongTianJieEnterModel:onProtocolReq()

end


function JiuChongTianJieEnterModel:onLeaveState(isReconnect)

self.data={}
end

function JiuChongTianJieEnterModel:isShowWeakNewbie()
if self.weakNewbie==nil and JiuChongTianJieEnterModel:getState()==eJiuChongTianJieStateType.eDoing and JiuChongTianJieEnterModel:getAllProgress()<=5 then
return true
end
end

function JiuChongTianJieEnterModel:setShowWeakNewbie()
self.weakNewbie=true
end

function JiuChongTianJieEnterModel:isSysOpen()
return systemModel.isOpen(SYSTEM_DEFINE.eTianJieQianZou)
end

function JiuChongTianJieEnterModel:getState()
if not JiuChongTianJieEnterModel:isSysOpen()then

return eJiuChongTianJieStateType.ePreview
else

local sec=JiuChongTianJieEnterModel:getOpenTianJieSec()
if sec>0 then
local dur=JiuChongTianJieEnterModel:getOpenTianJieDur()
local now=timeHelper.getServerShortTime()
local openSys=systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie1)
if sec+dur>now or(not openSys)then
return eJiuChongTianJieStateType.eStart
else
return eJiuChongTianJieStateType.eDoing
end
else
return eJiuChongTianJieStateType.ePreview
end
end
end

function JiuChongTianJieEnterModel:getOpenStep()
local list=self:getSortSysList()
local len=#list
local cfg
for i=1,len do
cfg=list[len-i+1]
if not cfg.shield and systemModel.isOpen(cfg.sysid)then
return cfg.id
end
end
return 1
end

function JiuChongTianJieEnterModel:setOpenTianJieSec(open_sec)
self.data.open_sec=open_sec
end

function JiuChongTianJieEnterModel:getOpenTianJieSec()
return self.data.open_sec or 0
end

function JiuChongTianJieEnterModel:setOpenTianJiePeople(finish_num)
self.data.finish_num=finish_num
end


function JiuChongTianJieEnterModel:getOpenTianJiePeople()
return self.data.finish_num or 0
end


function JiuChongTianJieEnterModel:setSelectFeiShengGuid(diziguid)
self.data.selectDiziGuid=diziguid
end

function JiuChongTianJieEnterModel:getSelectFeiShengGuid()
return self.data.selectDiziGuid
end

function JiuChongTianJieEnterModel:isSelectFeiShengGuid()
if self.data.selectDiziGuid then
return mathHelper.int64_to_number(self.data.selectDiziGuid)>0
end
end

function JiuChongTianJieEnterModel:isJiuChongTianJieComplete()
return systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieComplete)
end


function JiuChongTianJieEnterModel:getOpenTianJieDur()
return cfgHelper.get(cfg_jctjbaseconfig_get,1,"duration")
end

function JiuChongTianJieEnterModel.bindClass(class)
local sysType=class.sysType
if _register_list[sysType]then return end
_register_list[sysType]=class
end


function JiuChongTianJieEnterModel:getSysClass(sysType)
local class=_register_list[sysType]
if class then
return class
else
loggerUtil.logWarnFMT("该系统没有对应class",sysType)
return jiuChongTianJieSysBase
end
end

function JiuChongTianJieEnterModel.bindSubClass(class)
local sysType=class.sysType
if _register_sublist[sysType]then return end
_register_sublist[sysType]=class
end



function JiuChongTianJieEnterModel:getSubSysClass(sysType)
local class=_register_sublist[sysType]
if class then
return class
else
loggerUtil.logWarnFMT("该系统没有对应class",sysType)
return jiuChongTianJieSubSysBase
end
end

local requirePath='lua.gameSys.JiuChongTianJieEnterSystem.JiuChongTianJieSubSys.'
function JiuChongTianJieEnterModel:requireClass(sysType)
local name=jctjSubSysConfig[sysType]
if name then
require(requirePath..name)
end
end

function JiuChongTianJieEnterModel:getSysList(sysType)
local class=self:getSysClass(sysType)
return class:getSysList()
end

function JiuChongTianJieEnterModel:getSysConditon(sysType)
local class=self:getSysClass(sysType)
return class:getConditon()
end

function JiuChongTianJieEnterModel:isShield(sysType)
local class=self:getSysClass(sysType)
return class:isShield()
end

function JiuChongTianJieEnterModel:getConditonTxt(sysType)
local class=self:getSysClass(sysType)
return class:getConditonTxt()
end


function JiuChongTianJieEnterModel:getProgress(sysType)
local class=self:getSysClass(sysType)
return class:getProgress()
end

function JiuChongTianJieEnterModel:getSubSystemProgress(subType)
local class=JiuChongTianJieEnterModel:getSubSysClass(subType)
return class:getProgress()
end

function JiuChongTianJieEnterModel:getProgressCount(sysType)
local class=self:getSysClass(sysType)
return class:getProgressCount()
end


function JiuChongTianJieEnterModel:isJCTJFinish()
return self:getAllProgress()==100 and systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJieEnough)

end


function JiuChongTianJieEnterModel:getAllProgress()
local cur,max=0,0
local cfg=cfg_jctjsysconfig()
for id,v in pairs(cfg)do
if v.sort then


local c,m=self:getProgress(id)
if m>0 then
cur=cur+c
max=max+m
end

end
end

return max>0 and math.floor(cur/max*10000)/100 or 0,100
end

function JiuChongTianJieEnterModel:getAllReddot()
if JiuChongTianJieEnterModel:isJiuChongTianJieComplete()then
return false
end
local cfg=cfg_jctjsysconfig()
for id,v in pairs(cfg)do
if JiuChongTianJieEnterModel:getReddot(id,true)then
return true
end
end
return false
end

function JiuChongTianJieEnterModel:getReddot(sysType,isEnter)
local class=self:getSysClass(sysType)
return class:getReddot(isEnter)
end

function JiuChongTianJieEnterModel:getSortSysList()
local cfg=cfg_jctjsysconfig()
local list={}
for id,v in pairs(cfg)do
if v.sort then


table.insert(list,v)

end
end
table.sort(list,function(a,b)return a.sort<b.sort end)
return list
end

function JiuChongTianJieEnterModel:getYinJieRank()
return rankListModel:getRankList(eRankListType.eYinJieKaiTian)
end

function JiuChongTianJieEnterModel:getDuJieRank()
return rankListModel:getRankList(eRankListType.eDuJieFeiSheng)
end

function JiuChongTianJieEnterModel:onInitYinJieRank(rankInfo)
self.data.yinJieRankInfo=rankInfo

UIManager:invokeUIMethod("UIJCKTRankWin","fillItemMyKaiTian")
end

function JiuChongTianJieEnterModel:onInitDuJieRank(rankInfo)
self.data.duJieRankInfo=rankInfo
UIManager:invokeUIMethod("UIJCKTRankWin","fillItemMyChengXian")
end

function JiuChongTianJieEnterModel:getYinJieMyRank()

local playerId=playerModel:getActorID()
local rankList=JiuChongTianJieEnterModel:getYinJieRank()
for i,v in ipairs(rankList)do
if mathHelper.compareInt64(playerId,v.actorId)then
return v
end
end
end

function JiuChongTianJieEnterModel:getDuJieMyRank()

local playerId=playerModel:getActorID()
local rankList=JiuChongTianJieEnterModel:getDuJieRank()
for i,v in ipairs(rankList)do
if mathHelper.compareInt64(playerId,v.actorId)then
return v
end
end
end

function JiuChongTianJieEnterModel:getBuffList()
local strList={}
local list=self:getSysList(JIUCHONGTIANJIE_SYS_TYPE.eZhuXianTai)
for i,v in ipairs(list)do
local class=self:getSubSysClass(v)
if class then
local buffList=class:getBuffList()
local name=class:getConfig().name
for i,v in ipairs(buffList)do
table.insert(strList,{name,v})
end
end
end
return strList
end


function JiuChongTianJieEnterModel:setTianJieStageFinishData(len,list)
local temp={}
if len>0 then


for i,v in ipairs(list)do
temp[v.param_1]=v.param_2
end
end
self.data.stageFinishData=temp
end

function JiuChongTianJieEnterModel:checkTianJieStageFinish(stage)
if self.data.stageFinishData and self.data.stageFinishData[stage]then
return self.data.stageFinishData[stage]>0
end
return false
end

function JiuChongTianJieEnterModel:checkSystemReward()
if JiuChongTianJieEnterModel:isJiuChongTianJieComplete()then
return false
end
local cfg=cfg_jctjsysconfig()
for id,v in pairs(cfg)do
local class=self:getSysClass(id)
if class:checkReward()then
return true
end
end
return false
end

function JiuChongTianJieEnterModel:getRewardSystem()
if JiuChongTianJieEnterModel:isJiuChongTianJieComplete()then
return
end
local subList={}
local cfg=cfg_jctjsysconfig()
for id,v in pairs(cfg)do
local class=self:getSysClass(id)
local list=class:getRewardSystem()
for i,v in ipairs(list)do
table.insert(subList,v)
end
end
return subList
end


function JiuChongTianJieEnterModel:setTianJieFirstFinishSec(first_finish_sec)
self.data.first_finish_sec=first_finish_sec
end


function JiuChongTianJieEnterModel:getTianJieFirstFinishSec()
return self.data.first_finish_sec or 0
end





function JiuChongTianJieEnterModel:updateReviewBlocks()
self.data.reviewBlocks={}
local reviewBlockIndex=0

local blocks=xiantuchengjiuModel:getLookBacksLookUp()

local reviewCfgs=cfg_zongmenhuiguconfig()
local mergeInfoType=cfgHelper.get2(cfg_zongmenhuigubaseconfig_get,1,'mergeInfoType')
local mergeList={}

for index,cfg in ipairs(reviewCfgs)do
local type=cfg.type
local blockTypeDataList=blocks[type]
local blockData
if blockTypeDataList and#blockTypeDataList>0 then
local compareType=cfg.limitType
local argsIndex
if compareType then
argsIndex=cfg.limitArgsIndex

if compareType==1 then
if#blockTypeDataList>1 then
table.sort(blockTypeDataList,function(a,b)
return a.args[argsIndex]<b.args[argsIndex]
end)
end
blockData=blockTypeDataList[1]
elseif compareType==2 then
if#blockTypeDataList>1 then
table.sort(blockTypeDataList,function(a,b)
return a.args[argsIndex]>b.args[argsIndex]
end)
end
blockData=blockTypeDataList[1]
elseif compareType==3 then
local fixedVal=cfg.limitFixedVal
for _,data in ipairs(blockTypeDataList)do
if data.args[argsIndex]==fixedVal then
blockData=data
end
end
end
else

if#blockTypeDataList>1 then
table.sort(blockTypeDataList,function(a,b)
return a.args[1]>b.args[1]
end)
end
blockData=blockTypeDataList[1]
end

if blockData then
local temp={}

temp.cfg=cfg
temp.blockData=blockData
temp.content=cfg.content

if cfg.contentEx then
temp.content=cfg.contentEx[blockData.args[argsIndex]]
end

temp.content=FMT.fmt(temp.content,table.unpackEx(blockData.args))
temp.content=JiuChongTianJieEnterController.replaceReviewInfo(temp.content)
temp.year=gameUtilityModel.getGameYearPass(blockData.time)

if mergeInfoType[cfg.type]==nil then
reviewBlockIndex=reviewBlockIndex+1
self.data.reviewBlocks[reviewBlockIndex]=temp
else
local mergeId=mergeInfoType[cfg.type]
if mergeList[mergeId]==nil then
mergeList[mergeId]=temp
else
local mergeData=mergeList[mergeId]
local isChange=false
local mergeCompareVal=mergeData.blockData.args[argsIndex]
local tempCompareVal=blockData.args[argsIndex]

if compareType==1 then
if tempCompareVal==mergeCompareVal then
isChange=cfg.id>mergeData.cfg.id
else
isChange=mergeCompareVal>tempCompareVal
end
elseif compareType==2 then
if tempCompareVal==mergeCompareVal then
isChange=cfg.id>mergeData.cfg.id
else
isChange=mergeCompareVal<tempCompareVal
end
end

if isChange then
mergeList[mergeId]=temp
end
end
end
else


end
else

if type==0 then

local temp={}
temp.cfg=cfg
reviewBlockIndex=reviewBlockIndex+1
self.data.reviewBlocks[reviewBlockIndex]=temp
temp.content=cfg.content
temp.content=JiuChongTianJieEnterController.replaceReviewInfo(temp.content)
temp.year=gameUtilityModel.getGameYearPass(timeHelper.getServerShortTime())
elseif type==-1 then
local rankData=rankListModel:getPlayerInfo(eRankListType.eDuJieFeiSheng)
if rankData and rankData.rank>0 then
local temp={}
temp.cfg=cfg
reviewBlockIndex=reviewBlockIndex+1
self.data.reviewBlocks[reviewBlockIndex]=temp
temp.content=cfg.content
temp.content=JiuChongTianJieEnterController.replaceReviewInfo(temp.content)
temp.year=gameUtilityModel.getGameYearPass(timeHelper.getServerShortTime())
end
end
end

if not blockData then
if cfg.isUseBogusData then
local temp={}
temp.cfg=cfg
reviewBlockIndex=reviewBlockIndex+1
self.data.reviewBlocks[reviewBlockIndex]=temp
temp.content=cfg.content
local year=gameUtilityModel.getGameYearPass(timeHelper.getServerShortTime())
if cfg.bogusData then
temp.content=FMT.fmt(temp.content,table.unpackEx(cfg.bogusData))
year=cfg.bogusData[1]
end
temp.content=JiuChongTianJieEnterController.replaceReviewInfo(temp.content)
temp.year=year
end
end
end


for index,data in pairs(mergeList)do
reviewBlockIndex=reviewBlockIndex+1
self.data.reviewBlocks[reviewBlockIndex]=data
end
end

function JiuChongTianJieEnterModel:getReviewBlocks(sortType)
if sortType==1 then
table.sort(self.data.reviewBlocks,function(a,b)
local atime=a.year
local btime=b.year

if atime==btime then
return a.cfg.reviewWidget>b.cfg.reviewWidget
else
return atime<btime
end
end)
else
table.sort(self.data.reviewBlocks,function(a,b)
return a.cfg.shareWidget>b.cfg.shareWidget
end)
end

return self.data.reviewBlocks
end

local _localRecordKey="DuJieFeiShengProgress"
function JiuChongTianJieEnterModel:setLocalizeProgress(progress)
userActorSetting.set(_localRecordKey,progress)
userActorSetting.flush()
end

function JiuChongTianJieEnterModel:getLocalizeProgress()
return userActorSetting.get(_localRecordKey,1)
end

function JiuChongTianJieEnterModel:setServerLocalizeShare(day)
self.data.zongmenReviewShareStamp=day
end

function JiuChongTianJieEnterModel:getServerLocalizeShare()
return self.data.zongmenReviewShareStamp or 0
end


