






local _MODULENAME="rankListController"




local _rankTypeHandleFunc=
{
[eRankListType.eXianGongPingDingRank]=function(rankInfo)
xiangongpingdingModel:onInitRank(rankInfo)
end,
[eRankListType.eYinJieKaiTian]=function(rankInfo)
JiuChongTianJieEnterModel:onInitYinJieRank(rankInfo)
end,
[eRankListType.eDuJieFeiSheng]=function(rankInfo)
JiuChongTianJieEnterModel:onInitDuJieRank(rankInfo)
end,
}


local _crossRankType=
{
[eRankListType.eYinJieKaiTian]=true,
[eRankListType.eDuJieFeiSheng]=true,
[eRankListType.eJiuYouTa2]=true,
[eRankListType.eJiuYouTaJiFen2]=true,
[eRankListType.eFaBaoFight2]=true,
[eRankListType.eDaoBingFight2]=true,
[eRankListType.eTop15Disciple1]=true,
[eRankListType.eTopJob1]=true,
[eRankListType.eTopJob2]=true,
[eRankListType.eTopJob51]=true,
[eRankListType.eTopJob52]=true,
[eRankListType.eTopJob101]=true,
[eRankListType.eTopJob102]=true,
[eRankListType.eTopJob151]=true,
[eRankListType.eTopJob152]=true,
[eRankListType.eTopJob201]=true,
[eRankListType.eTopJob251]=true,
[eRankListType.eTopJob252]=true,
[eRankListType.eWanLingTaRank]=true,
[eRankListType.eMingYuanZhuSha]=true,
}


local _xjCrossRankType=
{
[eRankListType.eJiuYouTa3]=true,
[eRankListType.eJiuYouTaJiFen3]=true,
[eRankListType.eTop15Disciple2]=true,
[eRankListType.eBaoLeiShiLi]=true,
[eRankListType.eShaQiJiLei]=true,
[eRankListType.eXiuShiZhanSun]=true,
[eRankListType.eXianFaRank]=true,
[eRankListType.eXianSunRank]=true,
[eRankListType.eZhuMoRank]=true,
[eRankListType.eXMZhuMoRank]=true,
}



gameState.addListener(def_table(_MODULENAME))
rankListController.name=_MODULENAME


rankListController.data={}

function rankListController:onAppStart()

rankListModel:onAppStart()



socketManager:register_receiver(24,1,self.recv_24_1)
socketManager:register_receiver(24,3,self.recv_24_3)
socketManager:register_receiver(24,21,self.recv_24_21)
socketManager:register_receiver(24,22,self.recv_24_22)
socketManager:register_receiver(24,23,self.recv_24_23)
socketManager:register_receiver(24,24,self.recv_24_24)

notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:listenNotify(notifyConfig.onDiscipleLTChange,self.onDiscipleLTChange)
notifySystem:listenNotify(notifyConfig.onGuBaoActive,self.onGuBaoActive)
notifySystem:listenNotify(notifyConfig.shilianta_change,self.shilianta_change)


end


function rankListController:onEnterState()
rankListModel:onEnterState()
end


function rankListController:onServerDataInitFinish()
rankListModel:onServerDataInitFinish()
end


function rankListController:onLeaveState()
rankListModel:onLeaveState()

self.data={}
end


function rankListController:onLostConnection()

end



function rankListController:req_rankList_data(rankType,immediately)
if rankType==eRankListType.eShiLianTa then
shiLianTaController.req_13_1()
shiLianTaController.req_13_5()
elseif rankType==eRankListType.eDouFaTai then
douFaTaiController:req_doufatai_data()
douFaTaiController:req_rank_data()
elseif rankType==eRankListType.eBigCrossMingYuanZhuSha then
rankListController:send_24_7(rankType)
else
local level=table.findValue(eXFWDLevel2RankType,rankType)
if level then
UIXianFaWenDaoControl:reqRankList(level)
return
end

if immediately or rankListModel:checkRankTime(rankType)then
if _crossRankType[rankType]then
self:send_24_2(rankType)
elseif _xjCrossRankType[rankType]then
self:send_24_5(rankType)
else
self:send_24_1(rankType)
end
end
end
end

function rankListController:send_24_1(rankType)
socketManager:send_24_1(rankType)
end

function rankListController:send_24_2(rankType)
socketManager:send_24_2(rankType)
end

function rankListController:send_24_5(rankType)
socketManager:send_24_5(rankType)
end

function rankListController:send_24_7(rankType)
socketManager:send_24_7(rankType)
end

function rankListController:send_24_21()
socketManager:send_24_21()
end

function rankListController:send_24_22(achievementId)
socketManager:send_24_22(achievementId)
end

function rankListController:send_24_24(array)
socketManager:send_24_24(#array,array)
end

function rankListController:req_achievement_complete(cType,common_id)

local aList=wuJiBeiModel:checkTriggerCondition(cType,common_id)
table.sort(aList)
local list={}
for i,v in ipairs(aList)do
table.insert(list,{v,common_id or int64.zero,0})
end

if#list>0 then
self:send_24_24(list)
end
end

function rankListController.recv_24_1(nextTime,rankNum,rankStruct)

local rankType=rankStruct.rankType
local rankList=rankStruct.dataList
rankListModel:setRankList(rankType,rankList or{})
rankListModel:setRankTime(rankType,nextTime)
rankListModel:setRankNo(rankType,rankNum)

notifySystem:postNotify(notifyConfig.onRankListRefresh,rankType)
end

function rankListController.recv_24_21(actorLen,actorList,awardLen,awardList)
wuJiBeiModel:setActorDatas(actorList or{})
wuJiBeiModel:setAwardDatas(awardList or{})

UIManager:callWindowFunc("UIRankListEnterWin","refreshReddot")
UIManager:callWindowFunc("UIRankListEnterWin1","refreshReddotByPanelType",eRankListStelePanelType.eWuJiBei)
UIManager:callWindowFunc("UIRankListWuJiBeiWin","freshList")

local sfId=zongmenModel:getMountainId()
if sfId then
local bdDatas=zongmenModel:getBuildingDataByBdType(sfId,SLG_SYSTEM_TYPE.ePaiHangBang)
for i,v in ipairs(bdDatas)do
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end
end

for name,cId in pairs(eWuJiBeiConditionType)do
local commonId=wuJiBeiModel:getCheckTopTarget(cId)
if commonId then
rankListController:req_achievement_complete(cId,commonId)
end
end
end

function rankListController.recv_24_22(achievementId,status)
if status==1 then

AudioManager.playAudio(503)
end

wuJiBeiModel:setAward(achievementId,status)

UIManager:callWindowFunc("UIRankListEnterWin","refreshReddot")
UIManager:callWindowFunc("UIRankListEnterWin1","refreshReddotByPanelType",eRankListStelePanelType.eWuJiBei)
UIManager:callWindowFunc("UIRankListWuJiBeiWin","refreshAchievement",achievementId)

local sfId=zongmenModel:getMountainId()
if sfId then
local bdDatas=zongmenModel:getBuildingDataByBdType(sfId,SLG_SYSTEM_TYPE.ePaiHangBang)
for i,v in ipairs(bdDatas)do
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end
end
end

function rankListController.recv_24_23(data)
wuJiBeiModel:setActor(data)

UIManager:callWindowFunc("UIRankListEnterWin","refreshReddot")
UIManager:callWindowFunc("UIRankListEnterWin1","refreshReddotByPanelType",eRankListStelePanelType.eWuJiBei)
UIManager:callWindowFunc("UIRankListWuJiBeiWin","refreshAchievement",data.achieve_id)

local sfId=zongmenModel:getMountainId()
if sfId then
local bdDatas=zongmenModel:getBuildingDataByBdType(sfId,SLG_SYSTEM_TYPE.ePaiHangBang)
for i,v in ipairs(bdDatas)do
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end
end
end

function rankListController.recv_24_24(len,array)
local check=false
for i=1,len do
local sdata=array[i]
local success=sdata.status==1
check=check or success
if success then
local actorId=playerModel:getActorID()
local head=playerModel:getActorIconInfo()
local zmLevel=playerModel:getActorLevel()
local playerName=playerModel:getActorName()
local data={
achieve_id=sdata.achieve_id,
actor_id=actorId,
zmLevel=zmLevel,
iconInfo=head,
playerName=playerName,
}
wuJiBeiModel:setActor(data)

UIManager:callWindowFunc("UIRankListWuJiBeiWin","refreshAchievement",sdata.achieve_id)

else

end
end

if check then
UIManager:callWindowFunc("UIRankListEnterWin","refreshReddot")
UIManager:callWindowFunc("UIRankListEnterWin1","refreshReddotByPanelType",eRankListStelePanelType.eWuJiBei)

local sfId=zongmenModel:getMountainId()
if sfId then
local bdDatas=zongmenModel:getBuildingDataByBdType(sfId,SLG_SYSTEM_TYPE.ePaiHangBang)
for i,v in ipairs(bdDatas)do
hudControl:refreshBuildingStatusHUD(v.un_build_id)
end
end
end
end

function rankListController.recv_24_3(len,ranklist)
if len==0 then return end
for i=1,len do
local rankInfo=ranklist[i]
local rankType=rankInfo.rankType
if _rankTypeHandleFunc[rankType]then
_rankTypeHandleFunc[rankType](rankInfo)
else
loggerUtil.debugErrFMT('没有处理排行类型:{0}',rankType)
end
end
end











function rankListController.onDiscipleJJChange(discipleguid,old_jjlv,jingjielv,old_jjexp,jingjieexp,oldFight,newFight)
if old_jjlv~=jingjielv then
rankListController:req_achievement_complete(eWuJiBeiConditionType.eJingJie,discipleguid)
end
end

function rankListController.onDiscipleLTChange(discipleguid,old_lv,liantilv,old_exp,liantiexp)
if old_lv~=liantilv then
rankListController:req_achievement_complete(eWuJiBeiConditionType.eLianTi,discipleguid)
end
end

function rankListController.onGuBaoActive(gubaoid)
rankListController:req_achievement_complete(eWuJiBeiConditionType.eGuBao,nil)
end

function rankListController.onGuBaoChange(gubaoid)
rankListController:req_achievement_complete(eWuJiBeiConditionType.eGuBao,nil)
end

function rankListController.shilianta_change(oLayer,nLayer,isClearAll)
if oLayer~=nLayer then
rankListController:req_achievement_complete(eWuJiBeiConditionType.eShiLianTa,nil)
end
end







