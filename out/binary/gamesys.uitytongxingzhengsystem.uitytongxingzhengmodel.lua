






local _MODULENAME="UITYTongXingZhengModel"


buyFlagType=
{
free=1,
money=2,
recharge=3,
}

txzCurRewardRecvKey={
[buyFlagType.free]='freeLayer',
[buyFlagType.money]='lock1Layer',
[buyFlagType.recharge]='lock2Layer',

}


txzType=
{
act=1,
sys=2,
}


txzScoreEnum={
eScore=1,
eLevel=2,
}



def_table(_MODULENAME)
UITYTongXingZhengModel.name=_MODULENAME
UITYTongXingZhengModel.data={}

function UITYTongXingZhengModel:onAppStart()

end


function UITYTongXingZhengModel:onEnterState(isReconnect)

end


function UITYTongXingZhengModel:onProtocolReq()
UITYTongXingZhengModel:initCfg()
end


function UITYTongXingZhengModel:onLeaveState(isReconnect)

self.data={}
self.guidList={}
end



function UITYTongXingZhengModel:initCfg()

local prize
local cfg=cfg_passportconfig()
if cfg then
self.prizeCfgs={}
for i,j in ipairs(cfg)do
local data=j
if data.target_rewards then
prize=data.target_rewards
end

if prize then
local list={}
for k,v in ipairs(prize)do
local temp={layer=v[1],freeReward=v[2][1],lock1Reward=v[2][2],lock2Reward=v[2][3]}
table.insert(list,temp)
end
table.sort(list,function(a,b)
return a.layer<b.layer
end)
table.insert(self.prizeCfgs,list)
end
end
end
end


function UITYTongXingZhengModel:getPrizeCfgsByIndex(txzId)
if self.prizeCfgs then
return self.prizeCfgs[txzId]
end
end

function UITYTongXingZhengModel:initDatas(len,array)
for i=1,len do
local data=array[i]
if data then
UITYTongXingZhengModel:addDatas(data)
end
end

end

function UITYTongXingZhengModel:addDatas(datas)
local data={}
local temp_data=datas
data.guid=temp_data.passport_guid
data.txzId=temp_data.passport_id
data.startTime=temp_data.start_time
data.endTime=temp_data.end_time
data.progress=temp_data.progress
data.recvTime=temp_data.recv_times
data.invest_bits=temp_data.invest_bits
data.level=temp_data.level




local otherData=temp_data.otherData
data.passporttype=otherData.passporttype
if otherData.passporttype==txzType.act then
data.activityId=otherData.act_id
data.subType=otherData.act_type
data.subId=otherData.act2_id
UITYTongXingZhengModel:setActIDByGuid(data.guid,data.activityId,data.subType,data.subId)
UITYTongXingZhengModel:setGuidByActID(otherData.passporttype,data.activityId,data.subType,data.subId,data.guid)
elseif otherData.passporttype==txzType.sys then
data.sys_id=otherData.sys_id
data.sub_sys_id=otherData.sub_sys_id

UITYTongXingZhengModel:setGuidBySysID(otherData.passporttype,data.sys_id,data.sub_sys_id,data.guid)
end

if temp_data.len>0 then
data.freeLayer=temp_data.recvList[1]
data.lock1Layer=temp_data.recvList[2]
data.lock2Layer=temp_data.recvList[3]
else
data.freeLayer=0
data.lock1Layer=0
data.lock2Layer=0
end

local index=tostring(data.guid)
self.data[index]=data

end


function UITYTongXingZhengModel:getTXZId(guid)
if not guid then return end
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
return data.txzId
end
end

function UITYTongXingZhengModel:findGuidByTXZId(txzId,isNoLog)
for i,v in pairs(self.data)do
if v.txzId==txzId then
return v.guid
end
end
if not isNoLog then
loggerUtil.logErrFMT("没有对应通行证ID的通行证数据：{0}",txzId)
end
end


function UITYTongXingZhengModel:setActIDByGuid(guid,actId,subType,subId)
if not self.actList then
self.actList={}
end

local idx=tostring(guid)
self.actList[idx]={actId,subType,subId}


end


function UITYTongXingZhengModel:getActIDByGuid(guid)
if not self.actList then
return nil
end

local subType
local idx=tostring(guid)

if self.actList[idx]then
subType=self.actList[idx]
end

return subType
end


function UITYTongXingZhengModel:setGuidBySysID(passporttype,sys_id,sub_sys_id,guid)

if not self.guidList then
self.guidList={}
end

local passporttypeStr=tostring(passporttype)
local sys_idStr=tostring(sys_id)
local sub_sys_idStr=tostring(sub_sys_id)

if not self.guidList[passporttypeStr]then
self.guidList[passporttypeStr]={}
end

if not self.guidList[passporttypeStr][sys_idStr]then
self.guidList[passporttypeStr][sys_idStr]={}
end

self.guidList[passporttypeStr][sys_idStr][sub_sys_idStr]=guid


end


function UITYTongXingZhengModel:getGuidBySysID(passporttype,sys_id,sub_sys_id,warning)
if not self.guidList then
return nil
end

local passporttypeStr=tostring(passporttype)
local sys_idStr=tostring(sys_id)
local sub_sys_idStr=tostring(sub_sys_id)

if self.guidList[passporttypeStr]and self.guidList[passporttypeStr][sys_idStr]then
local guid=self.guidList[passporttypeStr][sys_idStr][sub_sys_idStr]
local txzId=UITYTongXingZhengModel:getTXZId(guid)

if(warning==true or warning==nil)and(not guid or not txzId)then
local str=string.format("系统id%s，子id%s拿取guid或通行证id有误，请联系前端排查！！！",sys_id,sub_sys_id)
logErr(str)
end

return guid
end
return nil
end


function UITYTongXingZhengModel:setGuidByActID(passporttype,activityId,subType,subId,guid)

if not self.guidList then
self.guidList={}
end

local passporttypeStr=tostring(passporttype)
local activityIdStr=tostring(activityId)
local subTypeStr=tostring(subType)
local subIdStr=tostring(subId)

if not self.guidList[passporttypeStr]then
self.guidList[passporttypeStr]={}
end

if not self.guidList[passporttypeStr][activityIdStr]then
self.guidList[passporttypeStr][activityIdStr]={}
end
if not self.guidList[passporttypeStr][activityIdStr][subTypeStr]then
self.guidList[passporttypeStr][activityIdStr][subTypeStr]={}
end

self.guidList[passporttypeStr][activityIdStr][subTypeStr][subIdStr]=guid


end


function UITYTongXingZhengModel:getGuidByActID(passporttype,activityId,subType,subId)
if not self.guidList then
return nil
end

local passporttypeStr=tostring(passporttype)
local activityIdStr=tostring(activityId)
local subTypeStr=tostring(subType)
local subIdStr=tostring(subId)

if self.guidList[passporttypeStr]and self.guidList[passporttypeStr][activityIdStr]and self.guidList[passporttypeStr][activityIdStr][subTypeStr]then
return self.guidList[passporttypeStr][activityIdStr][subTypeStr][subIdStr]
end
return nil
end


function UITYTongXingZhengModel:getDataByGuid(guid)
local index=tostring(guid)
local data=self.data[index]
if data then
return data
else
return nil
end
end


function UITYTongXingZhengModel:getEndTime(guid)
local index=tostring(guid)
local data=self.data[index]
if data then
return data.endTime
end
end


function UITYTongXingZhengModel:getProgress(guid)
local index=tostring(guid)
local data=self.data[index]
if data then
return data.progress
end
return 0
end


function UITYTongXingZhengModel:setProgress(guid,score,level)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
data.progress=score
data.level=level
end
end

function UITYTongXingZhengModel:getLevel(guid)
local index=tostring(guid)
local data=self.data[index]
if data then
return data.level
end
return 0
end


















function UITYTongXingZhengModel:isFreePrize(guid,layer)
local finishLayer
local data=UITYTongXingZhengModel:getDataByGuid(guid)

if data then
finishLayer=data.freeLayer
else
finishLayer=0
end
return finishLayer>=layer
end


function UITYTongXingZhengModel:isMoneyPrize(guid,layer)
local finishLayer
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
finishLayer=data.lock1Layer
else
finishLayer=0
end

return finishLayer>=layer and UITYTongXingZhengModel:hasTouziMoney(guid)
end


function UITYTongXingZhengModel:isRechargePrize(guid,layer)
local finishLayer
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
finishLayer=data.lock2Layer
else
finishLayer=0
end

return finishLayer>=layer and UITYTongXingZhengModel:hasTouziRecharge(guid)
end


function UITYTongXingZhengModel:canFreePrize(guid,layer,index)
local finishLayer
local data=UITYTongXingZhengModel:getDataByGuid(guid)

if data then
finishLayer=data.progress
else
finishLayer=0
end

local flag=true
if index then
flag=UITYTongXingZhengModel:isFreePrize(guid,index)
end

if finishLayer>=layer and not flag then
return true
end
return false
end


function UITYTongXingZhengModel:canMoneyPrize(guid,layer,index)
local finishLayer
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
finishLayer=data.progress
else
finishLayer=0
end

local flag=true
if index then
flag=UITYTongXingZhengModel:isMoneyPrize(guid,index)
end

if finishLayer>=layer and not flag and UITYTongXingZhengModel:hasTouziMoney(guid)then
return true
end
return false
end


function UITYTongXingZhengModel:canRechargePrize(guid,layer,index)
local finishLayer
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
finishLayer=data.progress
else
finishLayer=0
end

local flag=true
if index then
flag=UITYTongXingZhengModel:isRechargePrize(guid,index)
end

if finishLayer>=layer and not flag and UITYTongXingZhengModel:hasTouziRecharge(guid)then
return true
end
return false
end

function UITYTongXingZhengModel:setPrizeLayer(guid,len,recvList)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if len>0 then
local value=recvList[1]
if value then
UITYTongXingZhengModel:setFreePrizeLayer(guid,value)
end

value=recvList[2]
if value then
UITYTongXingZhengModel:setMoneyPrizeLayer(guid,value)
end

value=recvList[3]
if value then
UITYTongXingZhengModel:setRechargePrizeLayer(guid,value)
end
end
end

function UITYTongXingZhengModel:setFreePrizeLayer(guid,value)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
data.freeLayer=value
end
end

function UITYTongXingZhengModel:getFreePrizeLayer(guid)
local finishLayer
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
finishLayer=data.freeLayer
else
finishLayer=0
end

return finishLayer
end

function UITYTongXingZhengModel:setMoneyPrizeLayer(guid,value)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
data.lock1Layer=value
end
end

function UITYTongXingZhengModel:getMoneyPrizeLayer(guid)
local finishLayer
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
finishLayer=data.lock1Layer
else
finishLayer=0
end

return finishLayer
end

function UITYTongXingZhengModel:setRechargePrizeLayer(guid,value)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
data.lock2Layer=value
end
end

function UITYTongXingZhengModel:getRechargePrizeLayer(guid)
local finishLayer
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
finishLayer=data.lock2Layer
else
finishLayer=0
end

return finishLayer
end


function UITYTongXingZhengModel:getCanPizeLayer(guid,txzId)

local freeLayer=UITYTongXingZhengModel:getCanFreePizeLayer(guid,txzId)
local moneyLayer=UITYTongXingZhengModel:getCanMoneyPizeLayer(guid,txzId)
local rechargeLayer=UITYTongXingZhengModel:getCanRechargPizeLayer(guid,txzId)

if not UITYTongXingZhengModel:hasTouziMoney(guid)then
moneyLayer=9999
end

if not UITYTongXingZhengModel:hasTouziRecharge(guid)then
rechargeLayer=9999
end

local index=math.min(freeLayer,moneyLayer,rechargeLayer)
if index==-1 then index=0 end
return index
end

function UITYTongXingZhengModel:getCanFreePizeLayer(guid,txzId)
local prizeCfgs=UITYTongXingZhengModel:getPrizeCfgsByIndex(txzId)
local prizelayer=UITYTongXingZhengModel:getFreePrizeLayer(guid)
local len=#prizeCfgs
local index=0

if prizelayer>=len then
index=0
else
index=prizelayer
if prizeCfgs[index+1]then
local layer=prizeCfgs[index+1].layer
if layer then
if not UITYTongXingZhengModel:canFreePrize(guid,layer,index+1)then
index=prizelayer-1
end
end
end
end

return index
end

function UITYTongXingZhengModel:getCanMoneyPizeLayer(guid,txzId)
local prizeCfgs=UITYTongXingZhengModel:getPrizeCfgsByIndex(txzId)
local prizelayer=UITYTongXingZhengModel:getMoneyPrizeLayer(guid)
local len=#prizeCfgs
local index=0

if prizelayer>=len then
index=0
else
index=prizelayer
if prizeCfgs[index+1]then
local layer=prizeCfgs[index+1].layer
if layer then
if not UITYTongXingZhengModel:canMoneyPrize(guid,layer,index+1)then
index=prizelayer-1
end
end
end
end

return index
end

function UITYTongXingZhengModel:getCanRechargPizeLayer(guid,txzId)
local prizeCfgs=UITYTongXingZhengModel:getPrizeCfgsByIndex(txzId)
local prizelayer=UITYTongXingZhengModel:getRechargePrizeLayer(guid)
local len=#prizeCfgs
local index=0

if prizelayer>=len then
index=0
else
index=prizelayer
if prizeCfgs[index+1]then
local layer=prizeCfgs[index+1].layer
if layer then
if not UITYTongXingZhengModel:canRechargePrize(guid,layer,index+1)then
index=prizelayer-1
end
end
end
end

return index
end


function UITYTongXingZhengModel:getMaxPizeLayer(guid)
local cfg
local layer
local finishLayer
local data=UITYTongXingZhengModel:getDataByGuid(guid)

if data then
finishLayer=data.progress
cfg=UITYTongXingZhengModel:getPrizeCfgsByIndex(data.txzId)
else
finishLayer=0
end

if cfg then
for k,v in ipairs(cfg)do
if finishLayer>=v.layer then
layer=k
end
end
end
return layer
end


function UITYTongXingZhengModel:isBuy(value,bIdx)
return mathHelper.getBitValue(value,bIdx)
end


function UITYTongXingZhengModel:hasTouziMoney(guid)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
return UITYTongXingZhengModel:isBuy(data.invest_bits,buyFlagType.money)
end
return false
end


function UITYTongXingZhengModel:hasTouziRecharge(guid)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
return UITYTongXingZhengModel:isBuy(data.invest_bits,buyFlagType.recharge)
end
return false
end

function UITYTongXingZhengModel:hasAnyTouzi(wxdId)
return not UITYTongXingZhengModel:hasTouziMoney(wxdId)or
not UITYTongXingZhengModel:hasTouziRecharge(wxdId)
end


function UITYTongXingZhengModel:setInvest_bits(guid,value)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
data.invest_bits=value
end
end


function UITYTongXingZhengModel:getInvest_bits(guid)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
return data.invest_bits
end
end


function UITYTongXingZhengModel:getCurLeftDay(guid)
local endStr
local endStamp=UITYTongXingZhengModel:getEndTime(guid)
if endStamp then
local stamp=timeHelper.getServerShortTime()
local left=endStamp-stamp
if left>=0 then
endStr=timeHelper.format_time_stamp3(left)
end
end

return endStr
end


function UITYTongXingZhengModel:getMaxLayer(txzId)
local maxLayer=0
local config=UITYTongXingZhengModel:getPrizeCfgsByIndex(txzId)
if not config then
return
end
for k,v in ipairs(config)do
if v.layer and v.layer>maxLayer then
maxLayer=v.layer
end
end

return maxLayer
end


function UITYTongXingZhengModel:isUnLockFull(guid,txzId)
local maxlayer=UITYTongXingZhengModel:getMaxLayer(txzId)
local progress=UITYTongXingZhengModel:getProgress(guid)
if not maxlayer then
logErr("拿不到通行证配置的最大层数，前端检查")
return false
end

if progress>=maxlayer then return true end
return false
end


function UITYTongXingZhengModel:isReceiveFull(guid,txzId)
local maxlayer=UITYTongXingZhengModel:getMaxLayer(txzId)
local progress=UITYTongXingZhengModel:getProgress(guid)
if not maxlayer then
return false
end
local cfg=UITYTongXingZhengModel:getPrizeCfgsByIndex(txzId)
for k,v in ipairs(cfg)do
if UITYTongXingZhengModel:canFreePrize(guid,v.layer,k)then
return false
end
end

if progress>=maxlayer then return true end
return false
end


function UITYTongXingZhengModel:isReceiveFullIncludeCharge(guid,txzId)
local maxlayer=UITYTongXingZhengModel:getMaxLayer(txzId)
local progress=UITYTongXingZhengModel:getProgress(guid)
if not maxlayer then
return false
end
local cfg=UITYTongXingZhengModel:getPrizeCfgsByIndex(txzId)
for k,v in ipairs(cfg)do

if UITYTongXingZhengModel:canFreePrize(guid,v.layer,k)then
return false
end


if UITYTongXingZhengModel:canMoneyPrize(guid,v.layer,k)then
return false
end


if UITYTongXingZhengModel:canRechargePrize(guid,v.layer,k)then
return false
end
end


if not UITYTongXingZhengModel:hasTouziMoney(guid)or not UITYTongXingZhengModel:hasTouziRecharge(guid)then
return false
end

if progress>=maxlayer then return true end
return false
end


function UITYTongXingZhengModel:setRecvTimes(guid,times)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
data.recvTime=data.recvTime+times
end
end


function UITYTongXingZhengModel:getRecvTimes(guid)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data then
return data.recvTime
end
return""
end


function UITYTongXingZhengModel:getCanRecvTimes(guid,txzId)

if not UITYTongXingZhengModel:isUnLockFull(guid,txzId)then
return 0
end

local recieveCount
local maxlayer=UITYTongXingZhengModel:getMaxLayer(txzId)
local progress=UITYTongXingZhengModel:getProgress(guid)
local recvTimes=UITYTongXingZhengModel:getRecvTimes(guid)
local jfvalue=cfgHelper.get2(cfg_passportconfig_get,txzId,"cost")

if recvTimes and progress and jfvalue then
local surplus=progress-recvTimes*jfvalue-maxlayer

if surplus>0 then
recieveCount=math.floor(surplus/jfvalue)
end
end

return recieveCount or 0
end


function UITYTongXingZhengModel:getReddot(guid)
local txzId=UITYTongXingZhengModel:getTXZId(guid)
if txzId==nil then return false end
if UITYTongXingZhengModel:isReceiveFull(guid,txzId)then
local count=UITYTongXingZhengModel:getCanRecvTimes(guid,txzId)
if count>0 then
return true
end
end

local cfg=UITYTongXingZhengModel:getPrizeCfgsByIndex(txzId)
for k,v in ipairs(cfg)do
if UITYTongXingZhengModel:canFreePrize(guid,v.layer,k)
or UITYTongXingZhengModel:canMoneyPrize(guid,v.layer,k)
or UITYTongXingZhengModel:canRechargePrize(guid,v.layer,k)then
return true
end
end
return false
end

function UITYTongXingZhengModel:checkHasTxzBySystem(sysid)
if self.guidList then
local passporttypeStr=tostring(txzType.sys)
local sys_idStr=tostring(sysid)

if self.guidList[passporttypeStr]and self.guidList[passporttypeStr][sys_idStr]then
local list=self.guidList[passporttypeStr][sys_idStr]or{}
local guid=next(list)
return guid~=nil
end
end
end








function UITYTongXingZhengModel:getLevelProgressInfo(guid)
local data=self:getDataByGuid(guid)
if data==nil then
logErr("通用通行证指定的guid没有data数据")
return 0,0,100
end

local up_level_conf=cfgHelper.get2(cfg_passportconfig_get,data.txzId,'up_level_conf')
local maxlv=#up_level_conf
local re_level=Mathf.Min(data.level+1,maxlv)
if self:isFinishFullLayer_Level(guid)then
return data.level,up_level_conf[re_level],up_level_conf[re_level]
else
return data.level,data.progress,up_level_conf[re_level]
end
end

function UITYTongXingZhengModel:checkUnLockRewardType(guid,rtype)
local data=self:getDataByGuid(guid)
if data==nil then return false end
return mathHelper.getBitValue(data.invest_bits,rtype)
end

function UITYTongXingZhengModel:checkIsRecvedGradeReward(guid,index,grade)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
local recvKey=txzCurRewardRecvKey[grade]
local curRewardRecvLayer=data[recvKey]
return curRewardRecvLayer>=index
end

function UITYTongXingZhengModel:checkCanRecvGrade(guid,layer,index,grade)
if not self:checkUnLockRewardType(guid,grade)then return false end

local finishLayer=0
local data=UITYTongXingZhengModel:getDataByGuid(guid)

if data then
finishLayer=data.level
end

return finishLayer>=layer and not self:checkIsRecvedGradeReward(guid,index,grade)
end

function UITYTongXingZhengModel:getCanRecvRewardMaxLayer(guid)
local data=UITYTongXingZhengModel:getDataByGuid(guid)
local target_rewards=cfgHelper.get2(cfg_passportconfig_get,data.txzId,'target_rewards')

local layer

local compareVal=data.level

for index,rewardCfg in ipairs(target_rewards)do
if compareVal>=rewardCfg[1]then
layer=index
else
break
end
end

return layer
end

function UITYTongXingZhengModel:getMaxLayer_Level(txzId)
local config=UITYTongXingZhengModel:getPrizeCfgsByIndex(txzId)
if config==nil then return 0 end

local maxLen=#config
return config[maxLen].layer
end

function UITYTongXingZhengModel:isFinishFullLayer_Level(guid)
local txzId=self:getTXZId(guid)
local maxLayer=self:getMaxLayer_Level(txzId)
local level=self:getLevel(guid)
return level>=maxLayer
end

function UITYTongXingZhengModel:getCanRecvFinalBigRewardBoxCount(guid)
if not self:isFinishFullLayer_Level(guid)then return 0 end

local data=UITYTongXingZhengModel:getDataByGuid(guid)
if data==nil then return 0 end

local cost=cfgHelper.get2(cfg_passportconfig_get,data.txzId,'cost')
local boxRewardRecvedTime=data.recvTime
local totalRecvBoxRewardCount=mathHelper.safe_floor(data.progress/cost)
local canRecvCount=totalRecvBoxRewardCount-boxRewardRecvedTime
return canRecvCount
end