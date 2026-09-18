






XMDG_Pass_Invest_Type={
eFree=0,
eMoney=1,
eRecharge=2,
}

function xianmengdigongModel:initData_pass()
self.firstTime=0
self.stopTime=0
self.xdlTotal=0
self.claimed={}
self.investFlag=0
self.passInvestList=nil
end

function xianmengdigongModel:clearData_pass()
self.firstTime=0
self.stopTime=0
self.xdlTotal=0
self.claimed={}
self.investFlag=0
self.passInvestList=nil
end

function xianmengdigongModel:actStartClearPassData()
self.xdlTotal=0
self.claimed={}
self.investFlag=0
UIManager:invokeUIMethod("UIXM_XMDG_MiLingWin","refresh")
end


function xianmengdigongModel:setPassFirstTime(firstTime)
self.firstTime=firstTime
end


function xianmengdigongModel:setPassStopTime(stopTime)
self.stopTime=stopTime
end


function xianmengdigongModel:getPassFirstTimeOpen()
if self.stopTime==0 then
return false
end
local limitInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianMengDiGong)
local endTime=limitInfo.end_time
if endTime==self.stopTime then
return false
end
local versionLimit=cfgHelper.get2(cfg_xmdgtongxingzhengbaseconfig_get,1,"versionLimit")
local gameVersion=pfwindowslController:getGameVersion()
if not versionLimit or not versionLimit[gameVersion]then
return false
end
return true
end


function xianmengdigongModel:setPassXDL(xdl)
self.xdlTotal=xdl
end


function xianmengdigongModel:getPassXDL()
return self.xdlTotal
end


function xianmengdigongModel:setPassClaimedXDL(investType,xdl)
self.claimed[investType]=xdl
end


function xianmengdigongModel:getPassClaimedXDL(investType)
return self.claimed[investType]or 0
end


function xianmengdigongModel:setPassInvestFlag(investType,flag)
if flag==1 then
self.investFlag=bitHelper.set_1(self.investFlag,investType)
else
self.investFlag=bitHelper.set_0(self.investFlag,investType)
end
end


function xianmengdigongModel:getPassInvestFlag(investType)
if investType==XMDG_Pass_Invest_Type.eFree then
return true
end
return bitHelper.check_pos(self.investFlag,investType)
end



function xianmengdigongModel:getPassInvestList()
if not self.passInvestList then
self.passInvestList={}
local configs=cfg_xmdgtongxingzhengrewardconfig()
for i,v in pairs(configs)do
table.insert(self.passInvestList,v)
end

table.sort(self.passInvestList,function(a,b)
return a.id<b.id
end)
end

return self.passInvestList
end


function xianmengdigongModel:checkPassReddot()
local hasXM=xianmengModel:hasXM()
local actOpen=limitActivitiesModel:checkActState(LIMIT_ACT_TYPE.eXianMengDiGong)==limitActivitiesModel.actDoingState
if not hasXM or not actOpen or not xianmengdigongModel:getPassFirstTimeOpen()then
return false
end
local limitInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eXianMengDiGong)
local endTime=tostring(limitInfo.end_time)
local roundPassReddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eOneTimeReddot,'xmdgPassReddot',0)~=endTime
return roundPassReddot or xianmengdigongModel:checkPassRewardReddot()or xianmengdigongModel:checkPassBuyProgressReddot()
end


function xianmengdigongModel:checkPassRewardReddot()
local passInvestList=xianmengdigongModel:getPassInvestList()
for i,v in ipairs(passInvestList)do
if self.xdlTotal>=v.id then
for _,type in pairs(XMDG_Pass_Invest_Type)do
if xianmengdigongModel:getPassInvestFlag(type)and xianmengdigongModel:getPassClaimedXDL(type)<v.id then
return true
end
end
else
break
end
end
return false
end


function xianmengdigongModel:checkPassBuyProgressReddot()
if not xianmengdigongModel:checkPassBuyProgressVisiable()then
return false
end
local reddot=not dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXMDGPassBuyProgress)
return reddot
end


function xianmengdigongModel:checkPassBuyProgressVisiable()
local cfg=cfgHelper.get1(cfg_xmdgtongxingzhengbaseconfig_get,1)
local buyProgressLimit=cfg.buyProgressLimit
local leftTime=limitActivitiesModel:getActEndLeftTime(LIMIT_ACT_TYPE.eXianMengDiGong)
if leftTime>buyProgressLimit then
return false
end
local passInvestList=xianmengdigongModel:getPassInvestList()
local maxXDL=passInvestList[#passInvestList].id
if self.xdlTotal>=maxXDL then
return false
end
return true
end


function xianmengdigongModel:getPassBuyProgressRewardList(buyId)
local rewards={}
local lookup={}
local lyFlag=xianmengdigongModel:getPassInvestFlag(XMDG_Pass_Invest_Type.eMoney)
local czFlag=xianmengdigongModel:getPassInvestFlag(XMDG_Pass_Invest_Type.eRecharge)
local passInvestList=xianmengdigongModel:getPassInvestList()
for _,v in ipairs(passInvestList)do
if self.xdlTotal<v.id and buyId>=v.id then
for _,vv in ipairs(v.freeItems)do
local itemid,itemcount=unpack(vv)
lookup[itemid]=(lookup[itemid]or 0)+itemcount
end
if lyFlag then
for _,vv in ipairs(v.lyItems)do
local itemid,itemcount=unpack(vv)
lookup[itemid]=(lookup[itemid]or 0)+itemcount
end
end
if czFlag then
for _,vv in ipairs(v.czItems)do
local itemid,itemcount=unpack(vv)
lookup[itemid]=(lookup[itemid]or 0)+itemcount
end
end
end
end
for itemid,itemcount in pairs(lookup)do
local color=itemsConfig.getItemColor(itemid)
local sortVal=color*-10000000+itemid
table.insert(rewards,{itemid,itemcount,sortVal=sortVal})
end
table.sort(rewards,function(a,b)
return a.sortVal<b.sortVal
end)
return rewards
end
