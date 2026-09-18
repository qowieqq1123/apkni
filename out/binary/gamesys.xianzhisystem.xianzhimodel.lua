






local _MODULENAME="xianzhiModel"


def_table(_MODULENAME)
xianzhiModel.name=_MODULENAME
xianzhiModel.data={}

function xianzhiModel:onAppStart()

end


function xianzhiModel:onEnterState(isReconnect)
self:initData()
end


function xianzhiModel:onProtocolReq()

end


function xianzhiModel:onLeaveState(isReconnect)

self.data={}
end

function xianzhiModel:initData()
self.data.localData={}

self.data.toZMXTFlag=false

self.data.isReceiveServerData=false

self:initLevelStarLookup()
self:initTaskList()
end

function xianzhiModel:initLevelStarLookup()
self.data.levelStarLookup={}

local allCfg=cfg_xianzhiconfig()

for index,cfg in pairs(allCfg)do
local jctian=cfg.jctian
local star=cfg.star

if not self.data.levelStarLookup[jctian]then
self.data.levelStarLookup[jctian]={}
end
self.data.levelStarLookup[jctian][star]=cfg
end
end

function xianzhiModel:initTaskList()
self.data.taskList={}

local allCfg=cfg_xianzhiconfig()

for index,cfg in pairs(allCfg)do
if cfg.goalItems~=nil then
local temp={}
temp.cfg=cfg
temp.widget=cfg.id*100

self.data.taskList[#self.data.taskList+1]=temp
end
end

table.sort(self.data.taskList,function(a,b)
return a.widget<b.widget
end)
end


function xianzhiModel:setServerData(xzid,openFlag,xgRwMaxId,rewardXzId,rewardXbLevel,rewardXbPercent,rewardFlag)

self.data.serverData={}

self.data.serverData.xzId=xzid
self.data.serverData.openFlag=openFlag
self.data.serverData.xgRwMaxId=xgRwMaxId
self.data.serverData.rewardXzId=rewardXzId
self.data.serverData.rewardXbLevel=rewardXbLevel
self.data.serverData.rewardXbPercent=rewardXbPercent/10000
self.data.serverData.rewardFlag=rewardFlag

self:updateTaskList()

self.data.isReceiveServerData=true

end

function xianzhiModel:changeXianZhiOpenFlag(openFlag)
self.data.serverData.openFlag=openFlag
end

function xianzhiModel:changeXzId(xzId)
self.data.serverData.xzId=xzId

self:updateTaskList()
end

function xianzhiModel:changeXbLevel(xbLevel)
self.data.serverData.xbLevel=xbLevel
end

function xianzhiModel:changeRewardXzId()
self.data.serverData.rewardXzId=self.data.serverData.xzId
end

function xianzhiModel:changeRewardXbLevel()
self.data.serverData.rewardXbLevel=xianzhiModel:getXianBaoLevel()
end

function xianzhiModel:changeRewardFlag(flag)
self.data.serverData.rewardFlag=flag
end

function xianzhiModel:changeXgRwMaxId(xgRwMaxId)
self.data.serverData.xgRwMaxId=xgRwMaxId

self:updateTaskList()
end

function xianzhiModel:updateTaskList()
local xzid=self.data.serverData.xzId
local xgRwMaxId=self.data.serverData.xgRwMaxId

for index,taskData in ipairs(self.data.taskList)do
local isReceived=xgRwMaxId>=taskData.cfg.id
local isCanReceive=xzid>xgRwMaxId

local widget=taskData.cfg.id

if isReceived then
widget=widget+10000
end

if not isCanReceive then
widget=widget+100000
end

taskData.widget=widget
end

table.sort(self.data.taskList,function(a,b)
return a.widget<b.widget
end)
end




function xianzhiModel:getXianZhiId()
return self.data.serverData and self.data.serverData.xzId or 0
end

function xianzhiModel:resetNewDayRewardFlag()
if self.data and self.data.serverData then
self.data.serverData.rewardFlag=0
self.data.serverData.rewardXbPercent=xianzhiController.getGBSKil_XianZhiWagesRate()

self:changeRewardXzId()
self:changeRewardXbLevel()
end
end

function xianzhiModel:getRewardXzId()
return self.data.serverData.rewardXzId or 1
end

function xianzhiModel:getRewardPercent()
return self.data.serverData.rewardXbPercent or 0
end



function xianzhiModel:getXianBaoLevel()

local gbid=xianzhiConfig.getBaseInfo('gbid')
return gubaoModel:getSkillLv(gbid)
end


function xianzhiModel:setReturnToZMXTFlag(state)
self.data.toZMXTFlag=state
end

function xianzhiModel:getReturnToZMXTFlag()
return self.data.toZMXTFlag
end


function xianzhiModel:getMainInfo()
local temp={}
local xzid=self.data.serverData.xzId
local xzCfg=cfgHelper.get1(cfg_xianzhiconfig_get,xzid)
local totalStar=self:getXzTotalStarNum(xzid)

temp.cfg=xzCfg
temp.totalStar=totalStar

return temp
end

function xianzhiModel:getXzTotalStarNum(xzid)
local xzCfg=cfgHelper.get1(cfg_xianzhiconfig_get,xzid)
local totalStar=#(self.data.levelStarLookup[xzCfg.jctian]or{})
return totalStar
end



function xianzhiModel:getTaskList()
return self.data.taskList
end

function xianzhiModel:getReddot()
local xbReddot=self:checkXianBaoReddot()
local xzReddot=self:checkCanUpXzLevel()
local xgjjReddot=self:checkXGJJReddot()
local mrflReddot=self:checkCanReceiveDayXianFeng()
local tqReddot=xianguanController:getSelfPrivilegeUseReddot()

return xbReddot or xzReddot or xgjjReddot or mrflReddot or tqReddot
end




function xianzhiModel:checkFirstOpenXianZhi()
return systemModel.isOpen(SYSTEM_DEFINE.eXianZhi)and not xianzhiModel:checkServerSystemOpenFlag()
end

function xianzhiModel:checkOpenXianZhi()
return systemModel.isOpen(SYSTEM_DEFINE.eXianZhi)and xianzhiModel:checkServerSystemOpenFlag()
end

function xianzhiModel:checkServerSystemOpenFlag()
if self.data.serverData and self.data.serverData.openFlag then
return self.data.serverData.openFlag==1
end
return false
end

function xianzhiModel:checkCanUpXzLevel()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianZhi)then return false end
if self.data.serverData then
if not self:checkXzFull()then
local cfg=cfgHelper.get1(cfg_xianzhiconfig_get,self.data.serverData.xzId)
local uplevelCost=cfg.exp
local hasNum=itemsModel.getCount(uplevelCost[1])
return hasNum>=uplevelCost[2]
end
end
return false
end

function xianzhiModel:checkReceivedDayXianFeng()
if self.data.serverData then
return self.data.serverData.rewardFlag>0
end
return true
end

function xianzhiModel:checkCanReceiveDayXianFeng()
if self.data.serverData and self.data.serverData.rewardXzId~=0 and xianzhiModel:checkOpenXianZhi()then
return self.data.serverData.rewardFlag==0
end
return false
end

function xianzhiModel:checkReceivedXianGongJiaJiang(xzid)
if not self.data.serverData then return false end
return self.data.serverData.xgRwMaxId>=xzid
end

function xianzhiModel:checkCanReceiveXianGongJiaJiang(xzid)
if not self.data.serverData then return false end
return self.data.serverData.xzId>=xzid and not self:checkReceivedXianGongJiaJiang(xzid)
end

function xianzhiModel:checkXzFull()
local xzid=self.data.serverData.xzId
local xzCfg=cfgHelper.get1(cfg_xianzhiconfig_get,xzid)
local totalJCT=#self.data.levelStarLookup
return totalJCT==xzCfg.jctian and#self.data.levelStarLookup[totalJCT]==xzCfg.star
end

function xianzhiModel:checkCanUpXianBaoLevel()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianZhi)then return false end
if self:checkXzFull()then
local gbid=xianzhiConfig.getBaseInfo('gbid')
local gbCfg=itemsConfig.getConfig(gbid,ITEM_CONFIG_TYPE.eGuBao)
local xblevel=gubaoModel:getSkillLv(gbid)
local uplevelCost=gbCfg.level[xblevel]

if uplevelCost~=nil then
local isEnough=true
local lostInfo=nil
for index,info in ipairs(uplevelCost)do
if not itemsModel.checkItemEnough(info[1],info[2])then
isEnough=false
lostInfo=info
break
end
end
return isEnough,lostInfo
end
end
return false
end




function xianzhiModel:checkXGJJReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eXianZhi)then return false end
if self.data.serverData then
for index,taskData in ipairs(self.data.taskList)do
if self:checkCanReceiveXianGongJiaJiang(taskData.cfg.id)then
return true
end
end
end
return false
end

function xianzhiModel:checkXianBaoReddot()
return xianzhiModel:checkCanUpXianBaoLevel()
end


local _Localize_XianZhiData_List_Key="localize_XianZhiData_list"

function xianzhiModel:readLocalizeData()
local localData=userActorSetting.get(_Localize_XianZhiData_List_Key,{})

self.data.localData=localData
end

function xianzhiModel:writeLocalizeData()
userActorSetting.set(_Localize_XianZhiData_List_Key,self.data.localData)

userActorSetting.flush()
end


