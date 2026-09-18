








function WDCQController:onLeaveState_ActEnter(isReconnect)
self:removeEnter()
self:removeQuFuActEnter()
self:removeRongYuBangActEnter()
end




function WDCQController:freshEnter()
local flag=self:checkEnter()

if flag then
if not self.enterGuid then
self.enterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eWenDingCangQiong})
else
enterManager:freshFunc('freshReddot',ENTER_TYPE.eWenDingCangQiong)
end
else
self:removeEnter()
end
end


function WDCQController:removeEnter()
if not self.enterGuid then return end
enterManager:removeEnter(self.enterGuid)
self.enterGuid=nil
end


function WDCQController:checkEnter()
if not XiWeiSaiController.checkSysOpen()then
return false
end
local startTime=WDCQModel:getData_startTime()
local xwStartTime=XiWeiSaiModel:getData_startTime()
if xwStartTime~=0 or startTime~=0 then
return true
end

local currtime=gameUtilityModel.getServerShortTime()
local startTime=XiWeiSaiModel:getConfig_startTime()
local endTime=WDCQController.getGameEnterEndTime()

if currtime<startTime then
return false
elseif currtime<=endTime then
return true
elseif currtime>endTime then
return false
end

end


function WDCQController:freshRongYuBangActEnter()
local flag=self:checkRongYuBangEnter()
if flag then
if not self.RYTEnterGuid then
self.RYTEnterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eWenDingBang,getReddotFun=WDCQController.checkRongYuBangEnterReddot})
else
enterManager:freshFunc('freshReddot',ENTER_TYPE.eWenDingBang)
end
else
self:removeRongYuBangActEnter()
end
end

function WDCQController:removeRongYuBangActEnter()
if not self.RYTEnterGuid then return end
enterManager:removeEnter(self.RYTEnterGuid)
self.RYTEnterGuid=nil
end

function WDCQController:checkRongYuBangEnter()



local state=true

if state then
local data=WDCQModel:getData()
local curTime=timeHelper.getServerShortTime()
state=data.zan_end_time>=curTime
end

return state
end

function WDCQController.checkRongYuBangEnterReddot()
local data=WDCQModel:getData()
local dznum=cfgHelper.get2(cfg_wendingcangqiongconfig_get,1,'daily_like_max')
local num=data.dian_zan_cnt or 0
return dznum>num
end

function WDCQController.getRongYuBangEnterLeftTime()
local data=WDCQModel:getData()
local curTime=timeHelper.getServerShortTime()



local endtime=data.zan_end_time



return endtime
end

function WDCQController.clickRongYuBangEnter()
UIManager:showWindow('UILDRongYuTongWin',{ftype=3})
end

function WDCQController:getMaxChampionGroupIndex()
local groupList=self:getUnlockGroupCfgList()

for index=#groupList,1,-1 do
local championInfo=WDCQModel:getRYBRankInfo(index,1)
if championInfo then
return index
end
end
return 1
end


function WDCQController:freshQuFuActEnter()
local flag=self:checkQuFuEnter()
if flag then
if not self.QuFuEnterGuid then
self.QuFuEnterGuid=enterManager:freshEnter({id=1,enterIconType=ENTER_ICON_TYPE.eNomal,enterType=ENTER_TYPE.eWDCQQFAct,getReddotFun=WDCQController.checkQuFuEnterReddot})
else
enterManager:freshFunc('freshReddot',ENTER_TYPE.eWDCQQFAct)
end
else
self:removeQuFuActEnter()
end
end

function WDCQController:removeQuFuActEnter()
if not self.QuFuEnterGuid then return end
enterManager:removeEnter(self.QuFuEnterGuid)
self.QuFuEnterGuid=nil
end

function WDCQController:checkQuFuEnter()



local state=true

if state then
local data=WDCQModel:getData()
local curTime=timeHelper.getServerShortTime()
state=data.qufu_act_end_time>=curTime
end

if state then
local data=WDCQModel:getData()
state=state and data.rewardInfoList~=nil and table.numsEx(data.rewardInfoList)>0
end


return state
end

function WDCQController.checkQuFuEnterReddot()
local data=WDCQModel:getData()

for groupId,roleList in pairs(data.rewardInfoList or{})do
for rank,roleInfo in pairs(roleList)do
if roleInfo.isReceive==0 then
return true
end
end
end
return false
end

function WDCQController.getQuFugEnterLeftTime()

local data=WDCQModel:getData()
local endtime=data.qufu_act_end_time
return endtime



end

function WDCQController.clickQuFugEnter()
if WDCQController.getQuFugEnterLeftTime()<=0 then return end
WDCQController.showQuFuActFull()
end

function WDCQController.showQuFuActFull()
local pageCfg={
{win='UIWDCQ_SubActServerRewardWin',tabType=FULL_TAB_TYPE.eWDCQAct_QufuJiangLi,reddotType=REDDIT_SUB_TYPE.sWDCQQFActReward},
}

if WDCQController.checkShowQuFuZengYiSubTab()then
pageCfg[2]={win='UIWDCQ_SubActZongMenBuffWin',tabType=FULL_TAB_TYPE.eWDCQAct_ZongMenZhuangTai}
end

UIFullCommonControl:showCommonActWindow_notFull(pageCfg)
end

function WDCQController.checkShowQuFuAct()



local data=WDCQModel:getData()
if not data.recvPlayerInfo then return false end
return data.rewardInfoLen>0
end

function WDCQController.checkShowQuFuZengYiSubTab()



local data=WDCQModel:getData()
return data.isShowQFZY
end

function WDCQController.getQuFuRewardActData()
local data=WDCQModel:getData()

if data.qufuRewardActData~=nil then
return data.qufuRewardActData
end

local groupDatas={}
for groupId,roleList in pairs(data.rewardInfoList)do
local list={}
local temp={groupId=groupId,list=list}

for rank,roleInfo in pairs(roleList)do
list[#list+1]=roleInfo
end

groupDatas[#groupDatas+1]=temp
end

table.sort(groupDatas,function(a,b)
return a.groupId<b.groupId
end)

for index,groupData in ipairs(groupDatas)do
table.sort(groupData.list,function(a,b)
return a.rank<b.rank
end)
end

data.qufuRewardActData=groupDatas

return data.qufuRewardActData
end

function WDCQController.changeQuFuRoleInfoRewardFlag(group,rank)
local data=WDCQModel:getData()

for index,roleInfo in pairs(data.rewardInfoList[group])do
roleInfo.isReceive=1
end
end

function WDCQController.getQuFuZYRoleInfo()
local data=WDCQModel:getData()
return data.zyRoleInfo
end



function WDCQController:freshClientAct()
if not WDCQController.checkSysOpen()then return end

local startTimeStamp=XiWeiSaiModel:getConfig_startTime()
local endTimeStamp=WDCQController.getGameEndTime()

limitActivitiesModel:addClientAct(LIMIT_ACT_TYPE.eWenDingCangQiong,startTimeStamp,endTimeStamp)
end
