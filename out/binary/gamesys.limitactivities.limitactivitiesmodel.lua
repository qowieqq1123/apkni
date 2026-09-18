







limitActivitiesModel={}

limitActivitiesModel.actFinishState=-1
limitActivitiesModel.actIdleState=0
limitActivitiesModel.actPreviewState=1
limitActivitiesModel.actDoingState=2

local _clientLookup=nil

local dataLookup=nil

function limitActivitiesModel:initActInfoList(serverType)
if dataLookup==nil then
dataLookup={}
end

local lookup={}
local cfgs=cfg_xianshihuodongconfig()
for i,actcfg in ipairs(cfgs)do
if not limitActivitiesModel.checkActForbidden(actcfg)then
local actID=actcfg.id
local serverType_=limitActivitiesModel:getActServerType(actcfg)
lookup[actID]=true
local openFlag=limitActivitiesModel:checkOpenCnd(actcfg)
if serverType_==serverType and openFlag then
local isNew=limitActivitiesModel:setActInfo(actcfg)
if isNew then
local actInfo=dataLookup[actID]
actInfo:onReady(isNew)
end
end
end
end

if _clientLookup~=nil then
for actID,v in pairs(_clientLookup)do
local sTime=v[1]
local eTime=v[2]
local actcfg=cfgHelper.get(cfg_clientxianshihuodongconfig_get,actID)
if actcfg then
if not limitActivitiesModel.checkActForbidden(actcfg)then
local isNew=limitActivitiesModel:setActInfo(actcfg,sTime,eTime)
local actInfo=dataLookup[actID]
actInfo:onReady(isNew)
if isNew then
local state=actInfo:getStateEx()
notifySystem:postNotify(notifyConfig.onLimitActStateChange,actID,state,isNew)


end
end
else



end
end
_clientLookup=nil
end


local dels={}
for actID,actInfo in pairs(dataLookup)do
local serverType_=actInfo:getActServerType()
if lookup[actID]==nil and serverType_==serverType then
if not actInfo:isClientAct()then
table.insert(dels,actID)
end
end
end
if#dels>0 then
for i,actID in ipairs(dels)do
limitActivitiesModel:removeActInfo(actID)
end
end
end

function limitActivitiesModel:addAct(actID,sTime,eTime)
if dataLookup==nil then
dataLookup={}
end
local actcfg=cfgHelper.get(cfg_xianshihuodongconfig_get,actID)
if actcfg then
local isNew=limitActivitiesModel:setActInfo(actcfg,sTime,eTime)
local actInfo=dataLookup[actID]
actInfo:onReady(isNew)
if isNew then
local state=actInfo:getStateEx()
notifySystem:postNotify(notifyConfig.onLimitActStateChange,actID,state,isNew)
else
limitActivitiesController:refreshActEnter(actID,true)
end

if actcfg.huChi then
limitActivitiesModel:removeActInfo(actcfg.huChi)
notifySystem:postNotify(notifyConfig.onLimitActOpen,actcfg.huChi,2)
end
else



end

end







function limitActivitiesModel:addClientAct(actID,sTime,eTime)
if dataLookup==nil then
dataLookup={}
end
if not initProControl.isDone()then
if _clientLookup==nil then _clientLookup={}end
_clientLookup[actID]={sTime,eTime}
else
local actcfg=cfgHelper.get(cfg_clientxianshihuodongconfig_get,actID)
if actcfg then
local isNew=limitActivitiesModel:setActInfo(actcfg,sTime,eTime)
local actInfo=dataLookup[actID]
actInfo:onReady(isNew)
if isNew then
local state=actInfo:getStateEx()
notifySystem:postNotify(notifyConfig.onLimitActStateChange,actID,state,isNew)
else
limitActivitiesController:refreshActEnter(actID,true)
end
else



end
end
end


function limitActivitiesModel:addClientAct_lt(actID,sTime_l,eTime_l)
local sTime=gameUtilityModel.serverLongTimeToShort(sTime_l)
local eTime=gameUtilityModel.serverLongTimeToShort(eTime_l)
limitActivitiesModel:addClientAct(actID,sTime,eTime)
end

function limitActivitiesModel:isClientAct(actID)
return actID>=10000
end

function limitActivitiesModel:clearData()
if dataLookup==nil then return end
for act_id,actInfo in pairs(dataLookup)do
release_limitActInfo(actInfo)
end
dataLookup=nil
self.actMark=nil
end

function limitActivitiesModel:onReconnet(serverType)
if dataLookup==nil then return end
for act_id,actInfo in pairs(dataLookup)do
local serverType_=actInfo:getActServerType()
if serverType_==serverType then
actInfo:onReconnect()
end
end
end

function limitActivitiesModel:removeActInfo(actID)
if dataLookup==nil then return false end
local actInfo=dataLookup[actID]
if actInfo~=nil then
release_limitActInfo(actInfo)
dataLookup[actID]=nil
actInfo=nil
return true
end
return false
end

function limitActivitiesModel:setActInfo(actcfg,sTime,eTime)
local actID=actcfg.id
local actInfo=dataLookup[actID]
local isNew=actInfo==nil
if isNew then
actInfo=new_limitActInfo(actcfg,sTime,eTime)
dataLookup[actID]=actInfo
else
actInfo:resetData(sTime,eTime)
end
return isNew
end

function limitActivitiesModel:getAllActivities()
return dataLookup or{}
end

function limitActivitiesModel:getActInfo(actID)
if dataLookup==nil then return end
return dataLookup[actID]
end

function limitActivitiesModel:checkAct_Open_Doing(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
if actInfo:checkOpen()and actInfo:checkDoing()then
if limitActivitiesModel:isXMAct(actID)then
if not xianmengModel:hasXM()then
return false
end
end
return true
end
end
return false
end

function limitActivitiesModel:callRefreshActEnter(actID,funcName,args)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
actInfo:refreshEnterEx(funcName,args)
end
end

function limitActivitiesModel:checkActOpen(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
return actInfo:checkOpen()
end
return false
end

function limitActivitiesModel:checkActState(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
return actInfo:getState()
end
return nil
end

function limitActivitiesModel:checkActIdle(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
return actInfo:checkIdle()
end
return false
end

function limitActivitiesModel:checkActPreview(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
return actInfo:checkPreview()
end
return false
end

function limitActivitiesModel:checkActDoing(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
return actInfo:checkDoing()
end
return false
end

function limitActivitiesModel:checkActFinish(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
return actInfo:checkFinish()
end
return false
end

function limitActivitiesModel:getActPreviewLeftTime(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
return actInfo:getPreviewLeftTime()
end
return 0
end

function limitActivitiesModel:getActEndLeftTime(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
return actInfo:getEndLeftTime()
end
return 0
end

function limitActivitiesModel:getActStartLeftTime(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
return actInfo:getStartLeftTime()
end
return 0
end

function limitActivitiesModel:getActReddot(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
return actInfo:getRoddot()
end
return false
end


function limitActivitiesModel:invokeMethod(actID,fName,...)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
local f=actInfo[fName]
if f then
return f(actInfo,...)
else
logErr(FMT.fmt("活动{0} 不存在方法 {1}",actID,fName))
end
end
end

function limitActivitiesModel:printActInfo(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
actInfo:printInfo()
end
end


function limitActivitiesModel:getActList_show()
local list={}
if dataLookup~=nil then
for actID,actInfo in pairs(dataLookup)do

if actInfo:checkOpen()and(actInfo:checkDoing()or actInfo:checkPreview())then
table.insert(list,actInfo)
end
end
end
return list
end


function limitActivitiesModel:getActList_show2()
local list={}
if dataLookup~=nil then
for actID,actInfo in pairs(dataLookup)do
table.insert(list,actInfo)
end
end
return list
end


function limitActivitiesModel:checkDoingPreview(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
if actInfo:checkOpen()and actInfo:checkDoing()and actInfo:checkInStartTimeDay()then
return true
end
end
return false
end

function limitActivitiesModel:checkDayCondition(actID)
local actInfo=limitActivitiesModel:getActInfo(actID)
if actInfo then
return actInfo:checkDayCondition()
end
return nil,nil
end



function limitActivitiesModel:initActMark(list,isclear)
if isclear then
self.actMark={}
end
local lp=self.actMark
if lp==nil then
lp={}
self.actMark=lp
end
if list then
for i,v in ipairs(list)do
lp[v.actId]=v
end
end
end

function limitActivitiesModel:setActMark_done(actID)
if self.actMark==nil then return end
local d=self.actMark[actID]
if d==nil then
d={actId=actID}
self.actMark[actID]=d
end
d.hisFlag=1
end

function limitActivitiesModel:getActMark_done(actID)
if self.actMark~=nil then
if self.actMark[actID]then
return self.actMark[actID].hisFlag==1
end
end
return false
end





function limitActivitiesModel.getActIcon(iconID)
local abName=globalABLookup.limitacticons
return abName,FMT.fmt('limitacticon_{0}',iconID)
end


function limitActivitiesModel.getActBigIcon(actID,typo)
local big_icon=limitActivitiesModel:getActConfig(actID,'big_icon')





local info={globalABLookup.limitactbigicons,FMT.fmt('image_huodongygt_{0}',big_icon[1])}
local info2
if typo==1 then

info2={globalABLookup.limitacwinicons,FMT.fmt('image_yureui_{0}',big_icon[2][1])}
elseif typo==2 then

info2={globalABLookup.limitacwinicons,FMT.fmt('image_huodonghdbg_{0}',big_icon[2][2])}
end
return info,info2
end

function limitActivitiesModel:getActConfig(actID,...)
if not limitActivitiesModel:isClientAct(actID)then
return cfgHelper.get(cfg_xianshihuodongconfig_get,actID,...)
else
return cfgHelper.get(cfg_clientxianshihuodongconfig_get,actID,...)
end
end

function limitActivitiesModel:getActSegmentToday(actID)
local week=tonumber(timeHelper.dateServer("%w"))
local hour=tonumber(timeHelper.dateServer("%H"))
local min=tonumber(timeHelper.dateServer("%H"))
local segs=self:getActConfig(actID,"status")
for i,v in ipairs(segs)do
if v.statusid==2 then
local sCfg=v
local check1=false
if week>sCfg.week then
check1=true
elseif week==sCfg.week then
if hour>sCfg.hour then
check1=true
elseif hour==sCfg.hour then
if min>=sCfg.min then
check1=true
end
end
end
if check1 then
local eIdx=i+1
eIdx=eIdx>#segs and 1 or eIdx
local eCfg=segs[eIdx]
local check2=false
if week<sCfg.week or sCfg.week<0 then
check2=true
elseif week==sCfg.week then
if hour<sCfg.hour then
check2=true
elseif hour==sCfg.hour then
if min<=sCfg.min then
check2=true
end
end
end
if check2 then
return sCfg.week,eCfg.week
end
end
end
end
end

function limitActivitiesModel:getActServerType(actcfg)
if actcfg.crossAct==1 then
return sendMessageServerType.eKuafu
elseif actcfg.crossAct==2 then
return sendMessageServerType.eXJKuafu
end
return sendMessageServerType.eNone
end

function limitActivitiesModel:checkOpenCnd(actcfg)
if not actcfg.openCnd then
return true
end
local openCnd=actcfg.openCnd
local type=openCnd[1]
local value=openCnd[2]
if type==1 then
return systemModel.isOpen(value)
elseif type==2 then
return not systemModel.isOpen(value)
end
return true
end

function limitActivitiesModel.getDayConditionCfg(actcfg)
local kfDay=actcfg.kfDay
if kfDay~=nil then
local bbid=pfwindowslController:getGameVersion()
local day=kfDay[bbid]or kfDay[pfwindowslController.sdkPFVersion.game_jianti]
return day
end
end

function limitActivitiesModel.getZMLevelConditionCfg(actcfg)
local zmLevel=actcfg.zmLevel
if zmLevel~=nil then
local bbid=pfwindowslController:getGameVersion()
local lv=zmLevel[bbid]or zmLevel[pfwindowslController.sdkPFVersion.game_jianti]
return lv
end
end


function limitActivitiesModel.checkActForbidden(actcfg)
if pfwindowslController:checkSkipCfgForbidden()then
return false
end
if actcfg.forbidden==1 then return true end
local forbidden_bb=actcfg.forbidden_bb
if forbidden_bb~=nil then
local bbid=pfwindowslController:getGameVersion()
local flag=forbidden_bb[bbid]
if flag==1 then return true end
end


local pfLimitCfg=actcfg.pfLimit
if pfLimitCfg then

local pfId=gameUtilityModel.getServerPlatform()
if pfId and(not pfLimitCfg[pfId]or pfLimitCfg[pfId]~=1)then

return true
end
end

return false
end

function limitActivitiesModel.getWorldMapLimitAct()
local lp={}
for lActID,Cfg in pairs(cfg_worldmaplimitactivityconfig())do
if not limitActivitiesModel.checkActForbidden(Cfg)then
lp[lActID]=Cfg
end
end
return lp
end

function limitActivitiesModel.getTimeDesc(actcfg)
local timedesc=actcfg.timedesc
if timedesc~=nil and type(timedesc)=='table'then
local bbid=pfwindowslController:getGameVersion()
local str=timedesc[bbid]or timedesc[pfwindowslController.sdkPFVersion.game_jianti]
return str
end
return timedesc
end
