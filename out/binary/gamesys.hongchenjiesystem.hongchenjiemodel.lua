






local _MODULENAME="hongChenJieModel"


def_table(_MODULENAME)
hongChenJieModel.name=_MODULENAME
hongChenJieModel.data={}

function hongChenJieModel:onAppStart()

end


function hongChenJieModel:onEnterState(isReconnect)
self.data.handleLookUp={}
self.data.careMoneyTypeChangeLookUp={}
end


function hongChenJieModel:onProtocolReq()

end


function hongChenJieModel:onLeaveState(isReconnect)

self.data={}
end


function hongChenJieModel:unpackServerData(id,data,isCrossServer)
local temp={}
temp.id=id
temp.identityList=data.identity_list
temp.discipleGuid=data.discipleguid
temp.gameData=data.hcjData
temp.rewardOtherFinishListLen=data.reward1_list_len
temp.rewardOtherFinishList=data.reward1_list
temp.rewardSelfFinishListLen=data.reward2_list_len
temp.rewardSelfFinishList=data.reward2_list
temp.times=data.times
temp.buyTimes=data.buy_times
temp.maxYear=data.max_year
temp.maxLevel=data.max_level
temp.rankListLen=data.rank_list_len
temp.rankList=data.rank_list
temp.taskRewardFlag=data.reward3_idx
temp.refreshTime=data.refresh_time
temp.freeTimesRefreshTimeStamp=data.free_sec
temp.isCrossServer=isCrossServer


hongChenJieModel:setServerData(temp)
end

function hongChenJieModel:setServerData(data)
if self.data.handleLookUp[data.id]then
if self.data.handleLookUp[data.id]:checkIdle()then
self.data.handleLookUp[data.id]:updateInfo(data)
else

logErr("红尘劫 历练中，不应该接收到初始化协议，此处阻断，未更新数据")
end
else
local handle=new_hongChenJieGameInfo(data)
self.data.handleLookUp[handle.id]=handle
end

local money_type=hongChenJieConfig.getBaseInfo(data.id,'money_type')
self.data.careMoneyTypeChangeLookUp[money_type]=data.id
end

function hongChenJieModel:getGameHandle(id)
return self.data.handleLookUp[id]
end


function hongChenJieModel:addNewEvent(id,eventData)
if self.data.handleLookUp[id]then
self.data.handleLookUp[id]:addEventData(eventData)
else
logErr('缺少实例：：',id)
end
end

function hongChenJieModel:setRankingRewardFlag(id,type,reward_idx)
if self.data.handleLookUp[id]then
if type==1 then
self.data.handleLookUp[id]:setRewardOtherFinishFlag(reward_idx)
elseif type==2 then
self.data.handleLookUp[id]:setRewardSelfFinishFlag(reward_idx)
else
logErr("出现了未知奖励类型",type)
end
else
logErr('缺少实例：：',id)
end
end

function hongChenJieModel:setBuyTimes(id,buy_times)
if self.data.handleLookUp[id]then
self.data.handleLookUp[id]:setBuyTimes(buy_times)
else
logErr('缺少实例：：',id)
end
end

function hongChenJieModel:updateRankingList(id,len1,itemList,len2,flagList)
if self.data.handleLookUp[id]then
if len1>0 then
for index=1,len1 do
local uitem=itemList[index]
self.data.handleLookUp[id]:updateRankingItem(uitem)
end
end

if len2>0 then
self.data.handleLookUp[id]:updateRankingListAchiveFlag(len2,flagList)
end
else
logErr('缺少实例：：',id)
end
end

function hongChenJieModel:setGameData(id,hcjData)
if self.data.handleLookUp[id]then

self.data.handleLookUp[id]:resetIdentityList()



self.data.handleLookUp[id]:setGameData(hcjData)

UIFullHongChenJieControl:transToWin(function()
UIFullHongChenJieControl:showGameWin({id=id})
end)
else
logErr('缺少实例：：',id)
end
end

function hongChenJieModel:setIdentityList(id,identityList,state)
if self.data.handleLookUp[id]then
self.data.handleLookUp[id]:resetGameData()
self.data.handleLookUp[id]:setIdentityList(identityList)
if state~=HongChenJieRefreshIdentityState.refresh then
UIManager:invokeUIMethod('UIHongChenJieMainWin','playEnterPrepareWinAnim',id,identityList)
else
UIManager:invokeUIMethod('UIHongChenJiePrepareWin','playFreshIndentityAnim',id,identityList)
end
else
logErr('缺少实例：：',id)
end
end

function hongChenJieModel:setTaskRewardFlag(id,idxFlag)
if self.data.handleLookUp[id]then
self.data.handleLookUp[id]:setTaskRewardFlag(idxFlag)
else
logErr('缺少实例：：',id)
end
end

function hongChenJieModel:isCrossServer(id)
if self.data.handleLookUp[id]then
return self.data.handleLookUp[id].data.isCrossServer
else
logErr('缺少实例：：',id)
end
end

function hongChenJieModel:getProgress(id)
if self.data.handleLookUp[id]then
return self.data.handleLookUp[id]:getProgress()
else
return 0,100

end
end

function hongChenJieModel:getReddot(id)
if self.data.handleLookUp[id]then
return self.data.handleLookUp[id]:getReddot()
else
return false

end
end

function hongChenJieModel:getSystemFinishState(id)
if self.data.handleLookUp[id]then
return self.data.handleLookUp[id]:getSystemFinishState()
else
return false

end
end

function hongChenJieModel:setRefreshedTimes(id,refreshTimes)
if self.data.handleLookUp[id]then
return self.data.handleLookUp[id]:setRefreshedTimes(refreshTimes)
else
logErr('缺少实例：：',id)
end
end

function hongChenJieModel:setRefreshFreeStamp(id,stamp)
if self.data.handleLookUp[id]then
return self.data.handleLookUp[id]:setRefreshFreeStamp(stamp)
else
logErr('缺少实例：：',id)
end
end

function hongChenJieModel:checkHasGameIdData(id)
return self.data.handleLookUp[id]~=nil
end

function hongChenJieModel:refreshSelectGuid(id,guid)
if self.data.handleLookUp[id]then
return self.data.handleLookUp[id]:setDataDiscipleGuid(guid)
else
logErr('缺少实例：：',id)
end
end

function hongChenJieModel:refreshTimes(id,times)
if self.data.handleLookUp[id]then
return self.data.handleLookUp[id]:setTimes(times)
else
logErr('缺少实例：：',id)
end
end



function hongChenJieModel:updateFreeTimes()
if self.data and self.data.handleLookUp then
for id,data in pairs(self.data.handleLookUp or{})do
data:updateFreeTimes()
end
end
end

function hongChenJieModel:DoPostNotify(moneyType)
if self.data then
if self.data.careMoneyTypeChangeLookUp then
local id=self.data.careMoneyTypeChangeLookUp[moneyType]
if id~=nil then
hongChenJieController:postNotifyProgress(id)
end
end
end
end


local usreDataKey_DispatchDisciple='usreDataKey_DispatchDisciple'
function hongChenJieModel:saveGameDispatchDisciple(id,disciple_guid)
if not self.dispactchDiscipleLookup then
self.dispactchDiscipleLookup={}
end
self.dispactchDiscipleLookup[id]=tostring(disciple_guid)

local saveTemp={}
for k,v in pairs(self.dispactchDiscipleLookup)do
saveTemp[#saveTemp+1]={k,v}
end

userActorSetting.set(usreDataKey_DispatchDisciple,saveTemp)
userActorSetting.flush()
end

function hongChenJieModel:initGameDispatchDisciple()
local getTemp=userActorSetting.get(usreDataKey_DispatchDisciple,{})

self.dispactchDiscipleLookup={}
for k,v in pairs(getTemp)do
local id=v[1]
local val=v[2]
self.dispactchDiscipleLookup[id]=val
end
end

function hongChenJieModel:getGameDispatchDisciple(id)
if not self.dispactchDiscipleLookup then
self:initGameDispatchDisciple()
end

local discipleGuid
if self.dispactchDiscipleLookup[id]then
local discipleData=UIDiscipleModel:getDiscipleDataByStr(self.dispactchDiscipleLookup[id])
discipleGuid=discipleData and discipleData.discipleguid
end
return discipleGuid
end
