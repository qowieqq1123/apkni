









wudaotangController=gameState.addListener({})

local init=false
local curState=nil

function wudaotangController:onAppStart()
socketManager:register_receiver(3,171,wudaotangController.do_protocol_3_171)
socketManager:register_receiver(3,172,wudaotangController.do_protocol_3_172)
socketManager:register_receiver(3,174,wudaotangController.do_protocol_3_174)
socketManager:register_receiver(3,175,wudaotangController.do_protocol_3_175)
socketManager:register_receiver(3,177,wudaotangController.do_protocol_3_177)
end

function wudaotangController:onEnterState()
notifySystem:listenNotify(notifyConfig.onShowPrize,wudaotangController.onShowPrize)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,wudaotangController.onDiscipleStateChange)
init=false
end

function wudaotangController:onLeaveState()
wudaotangModel:clearData()
notifySystem:removelistener(notifyConfig.onShowPrize,wudaotangController.onShowPrize)
notifySystem:removelistener(notifyConfig.onDiscipleStateChange,wudaotangController.onDiscipleStateChange)
end

function wudaotangController:onPlayerCreate(...)


end

function wudaotangController:onLostConnection()

end

function wudaotangController:onProtocolReq()
wudaotangController:createEventTimer()
end

function wudaotangController:checkInit()
return init
end

function wudaotangController.onDiscipleStateChange(guid,stateType,oldFlag,curFlag)
if stateType~=DISCIPLE_STATE_TYPE.edsDispatch then return end
if not wudaotangModel:hasPlan()then return end
if oldFlag==true and curFlag==false then

wudaotangModel:onDispatchChange(guid,false)
elseif oldFlag==false and curFlag==true then

wudaotangModel:onDispatchChange(guid,true)
end
end

function wudaotangController.onShowPrize(prizeType,prizelist,effectData)
if not wudaotangController:checkInit()then return end

if prizeType==ePrizeType.eWuDaoTang then


local idx=effectData.discipleidx
local data={}
data.exp=effectData.randjingjieexp
if prizelist~=nil then

local c=#prizelist
for i=c,1,-1 do
local data=prizelist[i]
local itemid=data.itemid
local num=data.num
local f=false
for j=1,i-1 do
local d=prizelist[j]
if d.itemid==itemid then
f=true
d.num=d.num+num
break
end
end
if f then
table.remove(prizelist,i)
end
end
end
data.reward=prizelist
wudaotangModel:recordReward(idx,data)
end
end


function wudaotangController:doReqFight(guid)
local pos=cfgHelper.get(cfg_wudaotangconfig_get,1,'pos')
local monsterListEx={{typo=fightCommonTag.typoDizi,guid=guid,pos=pos[2]}}
local dzMaskList={}
local fightlist=wudaotangModel:getFightDisciples()
if fightlist then
for i,v in ipairs(fightlist)do
dzMaskList[tostring(v)]=true
end
end
local winArgs=
{
enterCallBack=function(selectList,zfId)
if wudaotangModel:hasPlan()and not wudaotangModel:checkHasRewardEx()then
local fightGuid=wudaotangModel:checkFightDisciple(selectList)
if fightGuid~=nil then
local disname=UIDiscipleModel:getDiscipleName(fightGuid)
UIManager.error(FMT.fmt('弟子{0}已入魔，无法出战',fightGuid))
wudaotangController:openWuDaoTang()
else
fightLaunchController:sendFight(eBattleLaunch.wudaotang,selectList,0,zfId,{guid})
end
else
UIManager.error('悟道已结束')
wudaotangController:openWuDaoTang()
end
end,
enterTxt="悟道堂",
cancelCallBack=function()
wudaotangController:openWuDaoTang()
end,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
monsterListEx=monsterListEx,
dzMaskList=dzMaskList,
isHomeBattle=true,
cantEnter=false,
monsterPosType=pos[1],
}
fightController.showPrepareWin(fightPreSelectModel.fightType.wudaotang,winArgs)
end

function wudaotangController:getBuildData()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eWuDaoTang)
return bdDatas[1]
end

function wudaotangController:refreshBuildEffct(bdData,init)
if bdData==nil then
bdData=wudaotangController:getBuildData()
end
if bdData==nil or bdData.entityId==nil then return end

if wudaotangModel:hasBuildEffect(bdData)then

buildingEffectControl:playEffectByEID(bdData.entityId,bdData.build_id,buildEffectType.eWuDaoTang)
else
if not init then

buildingEffectControl:stopEffect(bdData.entityId,buildEffectType.eWuDaoTang)
end
end
end

function wudaotangController:openWuDaoTang()
local bdData=wudaotangController:getBuildData()
UIFullWuDaoTangControl:showMyWindow({entityID=bdData.entityId})
end

function wudaotangController:createEventTimer()
if wudaotangModel:hasPlan()then
curState=nil
timeEventController.addNormalTimerHandler(2,'wudaotangController',wudaotangController)
end
end

function wudaotangController:onNormalUpdate(delay)
if not zongmenControl:checkInit()then return end
local bdData=wudaotangController:getBuildData()
if bdData==nil then return end
local state=wudaotangModel:getwdSatet(bdData)
if curState~=state then
curState=state
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
wudaotangController:refreshBuildEffct()
end
if state<0 then
timeEventController.removeNormalTimerHandler(2,'wudaotangController')
end
end




function wudaotangController:reqInfo()
socketManager:send_3_171()
end


function wudaotangController:reqStart(planid,len,list,assistant)



if not assistant then
assistant=0
end
socketManager:send_3_172(planid,len,list,assistant)
end


function wudaotangController:reqReward(assistant)
if not assistant then
assistant=0
end
socketManager:send_3_174(assistant)
end


function wudaotangController:reqChangeDizi(index,guid,assistant)
if not assistant then
assistant=0
end
socketManager:send_3_175(index,guid,assistant)
end


function wudaotangController:reqAweakDizi(guidlist)
socketManager:send_3_177(#guidlist,guidlist)
end






function wudaotangController.do_protocol_3_171(planid,starttime,len,wdtlist)










if not init then
init=true
end
if planid>0 then
local curtime=gameUtilityModel.getServerShortTime()
if curtime<starttime then

starttime=curtime
end

end
if wdtlist then
for i,v in ipairs(wdtlist)do
if v.begintime>0 then

end
end
end
wudaotangModel:initData(planid,starttime,wdtlist)

if initProControl.isDone()then
wudaotangController:createEventTimer()
end
end


function wudaotangController.do_protocol_3_172(planid,assistant,res,guid)



if res==0 then
UIManager.info('开始悟道')
UIManager:invokeUIMethod('UIWuDaoTangWin','rec_plan',planid)
wudaotangController:refreshBuildEffct()
end
end


function wudaotangController.do_protocol_3_174(res,assistant)

if res==0 then
local d={}
d.planid=wudaotangModel:getPlan()
local wdtlist=wudaotangModel:getDisDatas()
local dislist={}
for i,v in ipairs(wdtlist)do
table.insert(dislist,v.guid)
end
d.dislist=dislist
d.rewardlist=wudaotangModel:getReward()or{}
if assistant and assistant==1 then
local args={rewards=wudaotangModel:getReward()or{}}
xiaoZhuShouModel:addDetailData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_wdt_1,args)

local temprewards={}
for k,v in ipairs(d.rewardlist)do
local data=v
if data and#data.reward>0 then
for i=1,#data.reward do
table.insert(temprewards,data.reward[i])
end
end
end
xiaoZhuShouController:inserPrizeList(temprewards)
else
UIManager:showWindow('UIWuDaoRewardWin',d)
end


wudaotangModel:clearPlan()

UIManager:invokeUIMethod('UIWuDaoTangWin','rec_planOver')
wudaotangController:refreshBuildEffct()
else




end
end


function wudaotangController.do_protocol_3_175(idx,guid,res,assistant)



if res==0 then

UIManager:invokeUIMethod('UIWuDaoTangWin','rec_plan')

end
end


function wudaotangController.do_protocol_3_177(len,list)
if len>0 and list then
for k,v in ipairs(list)do
wudaotangModel:fightVictory(v.param_1)
end
end
end

function wudaotangController.testReward()
local d={}
d.dislist={int64.new('898948612310958156'),int64.new('898948612310958158'),int64.new('898948612310958154')}
d.rewardlist={}
for i=1,3 do
if i~=2 then
local data={}
data.exp=100
data.reward={}
for i1=1,5 do
data.reward[i1]={itemid=11006,num=1}
end
d.rewardlist[i]=data
end
end
UIManager:showWindow('UIWuDaoRewardWin',d)
end


