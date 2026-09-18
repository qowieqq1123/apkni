






local _MODULENAME="mysteryWeekActivityModel"


def_table(_MODULENAME)
mysteryWeekActivityModel.name=_MODULENAME
mysteryWeekActivityModel.data={}

function mysteryWeekActivityModel:onAppStart()
self:initTuJianConfig()
end


function mysteryWeekActivityModel:onEnterState(isReconnect)
self.data={}
self.data.fbList={}
self.data.activedTuJian={}
end


function mysteryWeekActivityModel:onLeaveState(isReconnect)

self.data={}
end

function mysteryWeekActivityModel:onProtocolReq()

end

function mysteryWeekActivityModel:getEndTime()

local stortTime=mysteryWeekActivityModel:getNextMonday5oClock()
return stortTime-7*86400,stortTime
end

function mysteryWeekActivityModel:getNextMonday5oClock()
local week=timeHelper.getWeakDateEx()
local longStamp=timeHelper.getWeakDateStamp(1,1,5,0,0)
if week==1 then
local pass=timeHelper.getServerTodayPass()
if pass<5*3600 then
longStamp=timeHelper.getTodayZeroStamp()+5*3600
end
end
return timeHelper.convertShortStamp(longStamp)
end


function mysteryWeekActivityModel:initFbList()
self.data.fbList={}
end

function mysteryWeekActivityModel:addWeekMystery(mysteryData)
mysteryWeekActivityModel:removeMysteryById(mysteryData.id)
local guidStr=tostring(mysteryData.guidPos)
self.data.fbList[guidStr]=mysteryData
end

function mysteryWeekActivityModel:removeMystery(guidPos)
local guidStr=tostring(guidPos)
self.data.fbList[guidStr]=nil
end

function mysteryWeekActivityModel:getMysteryList()
return self.data.fbList
end

function mysteryWeekActivityModel:getMysteryNum()
local num=0
for i,v in pairs(self.data.fbList or{})do
num=num+1
end
return num
end

function mysteryWeekActivityModel:getMystery(guidStr)
guidStr=tostring(guidStr)
return self.data.fbList[guidStr]
end

function mysteryWeekActivityModel:getNextMystery()
local list=mysteryWeekActivityModel:getMysteryList()
local k=next(list)
if k then
return list[k]
end
end

function mysteryWeekActivityModel:setNewMytery(flag)
self.data.isNew=flag
end

function mysteryWeekActivityModel:isNewMystery()
return self.data.isNew
end

function mysteryWeekActivityModel:updateMysteryById(fbid,dataList)
for guid,v in pairs(self.data.fbList)do
if fbid==v.id then
for i,data in pairs(dataList)do
v[i]=data
end
end
end
end

function mysteryWeekActivityModel:removeMysteryById(fbid)
local guidStr=nil
for guid,v in pairs(self.data.fbList)do
if fbid==v.id then
guidStr=guid
break
end
end
if guidStr then
self.data.fbList[guidStr]=nil
end
end

function mysteryWeekActivityModel:getMysteryById(fbid)
for guid,v in pairs(self.data.fbList)do
if fbid==v.id then
return v
end
end
end


function mysteryWeekActivityModel:getMysterySortList(sortFunc)
if not sortFunc then
sortFunc=function(a,b)
return a.id<b.id
end
end
local list={}
for guid,v in pairs(self.data.fbList)do
local fb=v
fb.guidStr=guid
table.insert(list,fb)
end
table.sort(list,sortFunc)
return list
end

function mysteryWeekActivityModel:getMysteryUnitWinList(sortFunc)
if not sortFunc then
sortFunc=function(a,b)
return a.id<b.id
end
end
local list={}
local cfgList=cfg_secretscenefubenconfig()
for guid,v in pairs(self.data.fbList)do
local fb=v
fb.guidStr=guid
local id=fb.id
local cfg=cfgList[id]
if cfg then
fb.name=cfg.name
fb.icon=cfg.image
end
fb.ing=v.tzStatus==1
fb.guid=id

if v.percent2 and v.percent2>v.percent then
fb.percent=v.percent2
end
table.insert(list,fb)
end
table.sort(list,sortFunc)
return list
end


function mysteryWeekActivityModel:refreshUnitData(data)
local mystery=self:getMystery(data.guidStr)
data.ing=mystery.tzStatus==1
data.percent=mystery.percent








end

function mysteryWeekActivityModel:getFBReddot()
if self.data.fbList then
for guid,v in pairs(self.data.fbList)do
if v.percent<100 then
return true
end
end
end
return false
end



function mysteryWeekActivityModel:initXDTouZiData(passLayer,freeLayerLast,feeLayerLast,mhTimeout,jhFlag)
self.data.touziData={passLayer=passLayer,freeLayerLast=freeLayerLast,feeLayerLast=feeLayerLast,mhTimeout=mhTimeout,jhFlag=jhFlag}
end

function mysteryWeekActivityModel:getXDTouZiData()
return self.data.touziData or{}
end

function mysteryWeekActivityModel:getXDTouZiPassLayer()
local touziData=self:getXDTouZiData()
return touziData.passLayer
end

function mysteryWeekActivityModel:getXDTouZiFreeLayerLast()
local touziData=self:getXDTouZiData()
return touziData.freeLayerLast
end

function mysteryWeekActivityModel:getXDTouZiFeeLayerLast()
local touziData=self:getXDTouZiData()
return touziData.feeLayerLast
end

function mysteryWeekActivityModel:getXDTouZiMhTimeout()
local touziData=self:getXDTouZiData()
return touziData.mhTimeout
end

function mysteryWeekActivityModel:getXDTouZiJhFlag()
local mhTimeout=self:getXDTouZiMhTimeout()
if mhTimeout==0 then
return 0
end
local touziData=self:getXDTouZiData()
return touziData.jhFlag
end



function mysteryWeekActivityModel:initTuJianConfig()
if self.mijingfazetujian then
return
end
local mijingfazetujian={}
local tujianConfig=cfg_mijingfazetujianconfig()
for i,v in ipairs(tujianConfig)do
local tagId=v.tagId
if not mijingfazetujian[tagId]then
mijingfazetujian[tagId]={}
end
table.insert(mijingfazetujian[tagId],v)
end
self.mijingfazetujian=mijingfazetujian










end

function mysteryWeekActivityModel:getTuJianConfigByTagId(tagId)
return self.mijingfazetujian[tagId]
end

function mysteryWeekActivityModel:getTuJianShouJiConfigByTagId(tagId)
return cfgHelper.get(cfg_mijingfazetujianshoujiconfig_get,tagId)
end

function mysteryWeekActivityModel:initTuJianData(len,fzList,rwHis)
self.data.activedTuJian={}
if fzList then
for i,v in ipairs(fzList)do
self.data.activedTuJian[v.tjId]=v
end
end
self.data.activedlen=len

self.data.sjList={}
if rwHis then
for i,v in ipairs(rwHis)do
self.data.sjList[v.param_1]=v.param_2
end
end
end

function mysteryWeekActivityModel:isTuJianActived(tjId)
return self.data.activedTuJian[tjId]~=nil
end

function mysteryWeekActivityModel:getTuJianData(tjId)
return self.data.activedTuJian[tjId]
end

function mysteryWeirdBoxModel:getTuJianActivedByRule(ruleId,level)
if not self.mijingfazetujianLookUp then
self.mijingfazetujianLookUp={}
end
local key=table.concat({ruleId,level},"-")
local tjId=self.mijingfazetujianLookUp[key]
if tjId then
return mysteryWeekActivityModel:isTuJianActived(tjId)
else
local tujianConfig=cfg_mijingfazetujianconfig()
for i,v in ipairs(tujianConfig)do
local key=table.concat({v.fzId,v.fzLevel},"-")
self.mijingfazetujianLookUp[key]=v.id
if ruleId==v.fzId and level==v.fzLevel then
return mysteryWeekActivityModel:isTuJianActived(v.id)
end
end
return true
end
end

function mysteryWeekActivityModel:setTuJianJHReward(tjId)
if self.data.activedTuJian[tjId]then
self.data.activedTuJian[tjId].jhReward=1
end
end

function mysteryWeekActivityModel:getTuJianJHReward(tjId)
self.data.activedTuJian=self.data.activedTuJian or{}
if self.data.activedTuJian[tjId]then
return self.data.activedTuJian[tjId].jhReward==0
end
end

function mysteryWeekActivityModel:setTuJiansjId(tagId,rwHis)
if not self.data.sjList then
self.data.sjList={}
end
self.data.sjList[tagId]=rwHis
end

function mysteryWeekActivityModel:getActivedTuJianLen()
return self.data.activedlen
end

function mysteryWeekActivityModel:getActivedTuJianTagLen(tagId)
local num=0
self.data.activedTuJian=self.data.activedTuJian or{}
if self.mijingfazetujian[tagId]then
for i,v in pairs(self.mijingfazetujian[tagId])do
local tjId=v.id
if self.data.activedTuJian[tjId]then
num=num+1
end
end
end
return num
end

function mysteryWeekActivityModel:getsjId()
return self.data.sjList or{}
end

function mysteryWeekActivityModel:checkTuJianReddotByTagId(tagId)
local group=self.mijingfazetujian[tagId]
if group then
for i,v in ipairs(group)do
if self:getTuJianJHReward(v.id)then
return true
end
end
end
return false
end

function mysteryWeekActivityModel:checkXuanShangReddot()
local xdTouZiData=mysteryWeekActivityModel:getXDTouZiData()
local layerClear=xdTouZiData.passLayer or 0
local cfg=cfg_mijingtanxiantouziconfig()
local freerewardLast=mysteryWeekActivityModel:getXDTouZiFreeLayerLast()or 0
local feerewardLast=mysteryWeekActivityModel:getXDTouZiFeeLayerLast()or 0
local isBuyChaozhi=mysteryWeekActivityModel:getXDTouZiJhFlag()==1
for index,v in ipairs(cfg)do
local isFinish=layerClear>=index
if isFinish and((index>freerewardLast)or(isBuyChaozhi and index>feerewardLast))then
return true
end
end
return false
end

function mysteryWeekActivityModel:checkAllTuJianReddot()
if self.data.activedTuJian then
for i,v in pairs(self.data.activedTuJian)do
if v.jhReward==0 then
return true
end
end
end
return false
end

function mysteryWeekActivityModel:checkAllReddot()
if mysteryWeekActivityModel:checkAllTuJianReddot()then
return true
end

if mysteryWeekActivityModel:checkTujianShouJiReddot()then
return true
end
end

function mysteryWeekActivityModel:checkTujianShouJiTabReddot(tagId)
local shoujiConfig=mysteryWeekActivityModel:getTuJianShouJiConfigByTagId(tagId)
if shoujiConfig then
local sjList=mysteryWeekActivityModel:getsjId()or{}
local sjId=sjList[tagId]or 0
local activedLen=mysteryWeekActivityModel:getActivedTuJianTagLen(tagId)

for i,v in ipairs(shoujiConfig)do
if v.sjId>sjId then
local num=v.num
if activedLen>=num then
return true
end
end
end
end
return false
end

function mysteryWeekActivityModel:checkTujianShouJiReddot()
local tagList=cfg_mijingfazetujiantagconfig()
for i,v in ipairs(tagList)do
if mysteryWeekActivityModel:checkTujianShouJiTabReddot(v.id)then
return true
end
end
return false
end