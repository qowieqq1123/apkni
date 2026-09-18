







function xianjieModel:onNewDay_huzhu()
xianjieModel:clearHuZhuLimitTimes()
end

function xianjieModel:setHuZhuData(cooperaionInfo)
if not self.cooperaionLookup then
self.cooperaionLookup={}
end
if cooperaionInfo.actorid==0 or cooperaionInfo.actorid==int64.zero then
local old=self.cooperaionLookup[cooperaionInfo.guid]
if old then
local isSelfPlayer=playerModel:checkActorId(old.actorid)
if isSelfPlayer then
xianjieModel:setQiuZhuData(old.type1,old.type2,nil)
end
end
self.cooperaionLookup[cooperaionInfo.guid]=nil
else
self.cooperaionLookup[cooperaionInfo.guid]=cooperaionInfo
end
end

function xianjieModel:setHuZhuList(cooperaionList,helpList,limitList)
self.cooperaionLookup={}
self.qiuzhuData={}
self.helpList={}
self.limitList={}
self.clearLimitListTime=gameUtilityModel.getServerShortTime()

if cooperaionList then
for i,v in pairs(cooperaionList)do
if v.actorid==0 then
local old=self.cooperaionLookup[v.guid]
if old then
local isSelfPlayer=playerModel:checkActorId(old.actorid)
if isSelfPlayer then
xianjieModel:setQiuZhuData(old.type1,old.type2,nil)
end
end
self.cooperaionLookup[v.guid]=nil
else
self.cooperaionLookup[v.guid]=v

local isSelfPlayer=playerModel:checkActorId(v.actorid)
if isSelfPlayer then
xianjieModel:setQiuZhuData(v.type1,v.type2,v.guid)
end
end
end
end
if helpList then
for i,v in ipairs(helpList)do
self.helpList[v]=v
end
end
if limitList then
for i,v in ipairs(limitList)do
self.limitList[v.param_1]=v.param_2
end
end
end

function xianjieModel:clearHuZhuLimitTimes()
local nowTime=timeHelper.getServerShortTime()
if not timeHelper.checkInSameDay2(nowTime,self.clearLimitListTime or 0)then
self.clearLimitListTime=nowTime
self.limitList={}
UIManager:invokeUIMethod("UIYuLingZhaiWin","freshHuZhuBtn")
end
end

function xianjieModel:setAddHuZhuLimitTimes(type,addTimes)
xianjieModel:clearHuZhuLimitTimes()
if not self.limitList then
self.limitList={}
end
if self.limitList[type]then
self.limitList[type]=self.limitList[type]+addTimes
else
self.limitList[type]=addTimes
end
end

function xianjieModel:getHuZhuLimitTimes(type)
if not self.limitList then
self.limitList={}
end
local bdData=YingXianGeController:getBuildingData()

if bdData then
local level=bdData.level
local cfg=cfgHelper.get1(cfg_yingxiangeconfig_get,level)
if cfg.cooperation_conf and cfg.cooperation_conf[type]then
local limit=self.limitList[type]or 0
local huZhuNum=cfg.cooperation_conf[type]or 0
local finalHuZhuNum=YingXianGeModel:getMaxCooperationTypeNumEx(type,huZhuNum)
limit=math.min(limit,finalHuZhuNum)
return limit,finalHuZhuNum
end
end

return nil,nil
end



function xianjieModel:setQiuZhuData(type1,type2,guid)
if not self.qiuzhuData then
self.qiuzhuData={}
end
if not self.qiuzhuData[type1]then
self.qiuzhuData[type1]={}
end
self.qiuzhuData[type1][type2]=guid
end


function xianjieModel:setHuZhuState(guid,ret)
if ret==0 then
if not self.helpList then
self.helpList={}
end
self.helpList[guid]=guid
end
end

function xianjieModel:getCooperaionList()
local list={}
if not self.cooperaionLookup then
return list
end
for i,v in pairs(self.cooperaionLookup)do
local actorData=xianmengModel:getXMMemberData(v.actorid)
local addTime,maxCount=YingXianGeModel:getReduceTimesData(v.actorid)
local isMax=v.times>=maxCount
if actorData and not isMax then
table.insert(list,v)
end
end
return list
end

function xianjieModel:getCooperaionDataByGuid(guid)
if not self.cooperaionLookup then
return nil
end
return self.cooperaionLookup[guid]
end

function xianjieModel:getHelpList()
if not self.helpList then
return{}
end
local list={}
for i,v in pairs(self.helpList)do
list[#list+1]=v
end
return list or{}
end

function xianjieModel:getIsHelp(guid)
if not self.helpList then
return false
end
return self.helpList[guid]~=nil
end



function xianjieModel:getQiuzhuGuid(type1,type2)
if not self.qiuzhuData then
return nil
end
if not self.qiuzhuData[type1]then
return nil
end
return tonumber(self.qiuzhuData[type1][type2])
end




function xianjieModel:getIsCanQiuzhu(type1,type2)
local isOpen=YingXianGeModel:checkOpen()
if not isOpen then
return false
end
local spcfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_allow')
if not spcfg[type2]or not spcfg[type2][type1]then
return false
end
local guid=xianjieModel:getQiuzhuGuid(type1,type2)
if guid then
return false,true
end
local limit,maxLimit=xianjieModel:getHuZhuLimitTimes(type2)
if maxLimit~=nil then
if limit>=maxLimit then
return false
end
end
return true
end


function xianjieModel:checkHasHuZhu()
if not self.cooperaionLookup then
return false
end
for i,v in pairs(self.cooperaionLookup)do
if v.actorid then
local addTime,maxCount=YingXianGeModel:getReduceTimesData(v.actorid)
local isMax=v.times>=maxCount
local isSelfPlayer=playerModel:checkActorId(v.actorid)
local isHelp=xianjieModel:getIsHelp(v.guid)
if not isHelp and not isSelfPlayer and not isMax then
return true
end
end
end
return false
end


function xianjieModel:getHuZhuNum()
if not self.cooperaionLookup then
return 0
end
local num=0
for i,v in pairs(self.cooperaionLookup)do
if v.actorid then
local addTime,maxCount=YingXianGeModel:getReduceTimesData(v.actorid)
local isMax=v.times>=maxCount
local isSelfPlayer=playerModel:checkActorId(v.actorid)
local isHelp=xianjieModel:getIsHelp(v.guid)
if not isHelp and not isSelfPlayer and not isMax then
num=num+1
end
end
end
return num
end
