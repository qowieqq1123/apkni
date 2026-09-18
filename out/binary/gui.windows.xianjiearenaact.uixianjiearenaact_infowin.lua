







def_class("UIXianJieArenaAct_infoWin",UIWindowBase)









function UIXianJieArenaAct_infoWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.jijieBtn=UIButton.get(self,2)
self.jijieBtnText=UIText.get(self,3)
self.menuItemGroup=UIObject.get(self,4)
self.rankPanel=UIObject.get(self,5)
self.rankScrollView=UIObject.get(self,6)
self.noRankTips=UIObject.get(self,7)
self.teamPanel=UIObject.get(self,8)
self.teamCountText=UIText.get(self,9)
self.teamScrollView=UIObject.get(self,10)
self.noTeamTips=UIObject.get(self,11)
self.simpleRecordPanel=UIButton.get(self,12)
self.simpleRecordScrollView=UIObject.get(self,13)
self.bgModel=UIObject.get(self,14)
self.root=UIObject.get(self,15)
self.sortConditionButton=UIButton.get(self,16)
self.searchInput=UIInputField.get(self,17)
self.searchBtn=UIButton.get(self,18)
self.searchCancelBtn=UIButton.get(self,19)
self.arenaModel=UIObject.get(self,20)
self.arenaName=UIText.get(self,21)
self.xianyuName=UIText.get(self,22)
self.detailPanel=UIObject.get(self,23)
self.detailScrollView=UIObject.get(self,24)
self.arrowBtn=UIButton.get(self,25)
self.noLogTips=UIObject.get(self,26)
self.teamListBtn=UIButton.get(self,27)
self.detailPanelMask=UIButton.get(self,28)
self.teamContent=UIObject.get(self,29)
self.xjbjbtn=UIButton.get(self,30)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.jijieBtn:setButtonClick(function()self:onJijieBtn()end)

self.simpleRecordPanel:setButtonClick(function()self:onSimpleRecordPanel()end)

self.sortConditionButton:setButtonClick(function()self:onSortConditionButton()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.searchCancelBtn:setButtonClick(function()self:onSearchCancelBtn()end)

self.arrowBtn:setButtonClick(function()self:onArrowBtn()end)

self.teamListBtn:setButtonClick(function()self:onTeamListBtn()end)

self.detailPanelMask:setButtonClick(function()self:onDetailPanelMask()end)

self.xjbjbtn:setButtonClick(function()self:onXjbjbtn()end)



end


function UIXianJieArenaAct_infoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.jijieBtn);self.jijieBtn=nil;
_UIObject_release(self.jijieBtnText);self.jijieBtnText=nil;
_UIObject_release(self.menuItemGroup);self.menuItemGroup=nil;
_UIObject_release(self.rankPanel);self.rankPanel=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.noRankTips);self.noRankTips=nil;
_UIObject_release(self.teamPanel);self.teamPanel=nil;
_UIObject_release(self.teamCountText);self.teamCountText=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
_UIObject_release(self.noTeamTips);self.noTeamTips=nil;
_UIObject_release(self.simpleRecordPanel);self.simpleRecordPanel=nil;
_UIObject_release(self.simpleRecordScrollView);self.simpleRecordScrollView=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sortConditionButton);self.sortConditionButton=nil;
_UIObject_release(self.searchInput);self.searchInput=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.searchCancelBtn);self.searchCancelBtn=nil;
_UIObject_release(self.arenaModel);self.arenaModel=nil;
_UIObject_release(self.arenaName);self.arenaName=nil;
_UIObject_release(self.xianyuName);self.xianyuName=nil;
_UIObject_release(self.detailPanel);self.detailPanel=nil;
_UIObject_release(self.detailScrollView);self.detailScrollView=nil;
_UIObject_release(self.arrowBtn);self.arrowBtn=nil;
_UIObject_release(self.noLogTips);self.noLogTips=nil;
_UIObject_release(self.teamListBtn);self.teamListBtn=nil;
_UIObject_release(self.detailPanelMask);self.detailPanelMask=nil;
_UIObject_release(self.teamContent);self.teamContent=nil;
_UIObject_release(self.xjbjbtn);self.xjbjbtn=nil;
end
















local _this

local rankItemCmpIndex={
rankNum=0,
xyName=1,
timeText=2,
}
local teamItemCmpIndex={
num=0,
head=1,
serverName=2,
xmName=3,
playerName=4,
soldierBgIcon=5,
soldierNameIcon=6,
soldierNumText=7,
clickMask=8,
}
local simpleLogItemCmpIndex={
flagIcon=0,
playerName=1,
simpleDesc=2,
}
local detailLogItemCmpIndex={
flagIcon=0,
desc=1,
recordBtn=2,
timeText=3,
soldierInfoPanel=4,
atkSoldierStr=5,
defSoldierStr=6,
atkSoldierInfoBtn=7,
defSoldierInfoBtn=8,
}
local logTypeIconList={
[1]="image_xjleitaixinxiui_7",
[2]="image_xjleitaixinxiui_6",
[3]="image_xjleitaixinxiui_8",
[4]="image_xjleitaixinxiui_9",
}

local zyTypeList={
eSelf=1,
eXMAllies=2,
eNotXMAllies=3,
eEnemy=4,
}




function UIXianJieArenaAct_infoWin:onLoaded(...)
_this=self
self:bindComponents()
self.searchInput:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)
end


function UIXianJieArenaAct_infoWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJieArenaAct_infoWin:onShow(argtable,afterOnloaded)
self.arenaId=argtable and argtable.arenaId
if not self.arenaId then
return self:onCloseClick()
end
local openSelectMenuIndex=argtable and argtable.openSelectMenuIndex
if openSelectMenuIndex then
self.selectMenuIndex=openSelectMenuIndex
else
self.selectMenuIndex=xianJieArenaActModel:getArenaInfoWinSelectMenuIndex()or 1
end
self.isFromOvArenaWin=argtable and argtable.isFromOvArenaWin


xianJieArenaActController:reqGetXJArenaActData_arenaInfo(self.arenaId)

self:refresh(true)


if systemModel.isOpen(SYSTEM_DEFINE.eXianJieBiaoJi)then
self.xjbjbtn:setActive(false)
local actorid=playerModel:getActorID()
local pos=xianmengModel:getXMMemberPost(actorid)
if pos then
if pos==GUILD_POST_TYPE.gpAllyLeader or pos==GUILD_POST_TYPE.gpViceLeader then
self.xjbjbtn:setActive(true)
end
end
else
self.xjbjbtn:setActive(false)
end
end


function UIXianJieArenaAct_infoWin:onHide()

end

function UIXianJieArenaAct_infoWin:refresh(isInit)

self:refreshMiddlePanel()


self:refreshLeftPanel(isInit)


self:refreshRightPanel(isInit)
end

function UIXianJieArenaAct_infoWin:refreshMiddlePanel()
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.arenaId)
if cfg then

local param=cfg.clientParam
local modelId=param.model
local scale=0.7
local offset={0,30}
self.arenaModel:setChildUIModelShowTarget(modelId,scale,{},eAnimationID.stand)
self.arenaModel:setChildUIModelShowTargetOffset(offset[1]or 0,offset[2]or 0)


local nameStr=cfg.name or"未知擂台"
self.arenaName:setText(nameStr)


local arenaData=xianJieArenaActModel:getArenaBuildData(self.arenaId)or{}
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx
self.sharex=cfg.x
self.sharez=cfg.y
local xyNameStr
local hasOccupy=occupySceneIdx and occupySceneIdx~=0 or nil
if hasOccupy then

xyNameStr=xianjieController:getCrossServerNamebySCidx(occupySceneIdx)

local cross_sid=loginModel:getCrossServerId()
local isSelfXianYu=occupyServerId==cross_sid
if isSelfXianYu then
xyNameStr=FMT.cfmt(FONT_COLOR.eGreenColor,xyNameStr)
else
xyNameStr=FMT.cfmt(FONT_COLOR.eRedColor,xyNameStr)
end
else
xyNameStr="无"
end
self.xianyuName:setText(FMT.fmt("当前归属：{0}",xyNameStr))
end
end

function UIXianJieArenaAct_infoWin:refreshLeftPanel(isInit)
self.simpleRecordPanel:setActive(not self.isShowDetail)
self.detailPanel:setActive(self.isShowDetail or false)
self.detailPanelMask:setActive(self.isShowDetail or false)
if not self.isShowDetail then

self:refreshSimpleRecordPanel(isInit)
else

self:refreshDetailPanel(isInit)
end
end

function UIXianJieArenaAct_infoWin:refreshRightPanel(isInit)
self:clearUpdateTimer()

local menuGrids=self.menuItemGroup:getChildCommonLayoutGroupWidgetList()
for i=1,menuGrids.Count do
local menuWidget=menuGrids[i-1]
local isSelect=self.selectMenuIndex==i
menuWidget:SetChildActive(0,not isSelect)
menuWidget:SetChildActive(1,isSelect)
menuWidget:SetChildButtonClick(-1,function()
if not _this then return end
return self:selectMenu(i)
end,true)
end

if self.selectMenuIndex==1 then

self.rankPanel:setActive(true)
self.teamPanel:setActive(false)
local hasOccupyXy=self:refreshRankPanel(isInit)
if hasOccupyXy then
self:setUpdateTimer()
end
elseif self.selectMenuIndex==2 then

self.rankPanel:setActive(false)
self.teamPanel:setActive(true)
self:refreshTeamPanel()
end

local isHasSelfZhuJun=xianJieArenaActModel:checkArenaHasSelfJJOrZJTeam(self.arenaId)
local jjBtnStr="进攻集结"
local arenaData=xianJieArenaActModel:getArenaBuildData(self.arenaId)or{}
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx
local hasOccupy=occupySceneIdx and occupySceneIdx~=0 or nil
if hasOccupy then
local cross_sid=loginModel:getCrossServerId()
local isSelfXianYu=occupyServerId==cross_sid
if isSelfXianYu then
jjBtnStr="协助驻守"
end
end
self.jijieBtnText:setText(jjBtnStr)
self.jijieBtn:setActive(not isHasSelfZhuJun)
end

function UIXianJieArenaAct_infoWin:selectMenu(index)
if not index or self.selectMenuIndex==index then
return
end

self.selectMenuIndex=index
xianJieArenaActModel:setArenaInfoWinSelectMenuIndex(index)
self:refreshRightPanel()
end

function UIXianJieArenaAct_infoWin:refreshRankPanel(isInit)

local occupySortListData=self:getArenaOccupySortListData(isInit)
local occupySortList=occupySortListData.sortList or{}
local selfOccupyData=occupySortListData.selfOccupyData
local arenaData=xianJieArenaActModel:getArenaBuildData(self.arenaId)or{}
local occupyServerId=arenaData.occupyServerId
local occupySceneIdx=arenaData.sceneidx
local hasOccupyXy=occupyServerId and occupyServerId~=0
local count=#occupySortList
local nowOccupyXyTime=0
local isSetNowOccupyXy=false
if hasOccupyXy then
count=count+1
local occupyStartTime=arenaData.occupyStartTime or 0
if occupyStartTime>0 then
local nowTime=timeHelper.getServerShortTime()
nowOccupyXyTime=nowTime-occupyStartTime
end

local occupiedTime=selfOccupyData and selfOccupyData.occupyTime or 0
nowOccupyXyTime=nowOccupyXyTime+occupiedTime
end
self.rankScrollView:setChildScrollViewCreateGrids(count,1)
local girds=self.rankScrollView:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
local dataIndex=isSetNowOccupyXy and i-1 or i
local data=occupySortList[dataIndex]
local occupyTime=data and data.occupyTime or 0
local serverId=data and data.serverId
local sceneIdx=data and data.sceneIdx
local isNowOccupyXy=false
if not isSetNowOccupyXy and nowOccupyXyTime>occupyTime then
occupyTime=nowOccupyXyTime
serverId=occupyServerId
sceneIdx=occupySceneIdx
isNowOccupyXy=true
isSetNowOccupyXy=true
end
local cross_sid=loginModel:getCrossServerId()
local isSelfXianYu=serverId==cross_sid


local numStr=tostring(i)



local xyNameStr=xianjieController:getCrossServerNamebySCidx(sceneIdx)


local timeStr=timeHelper.format_time_stamp3(occupyTime)

if isSelfXianYu then
numStr=FMT.cfmt(FONT_COLOR.eGreenColor,numStr)
xyNameStr=FMT.cfmt(FONT_COLOR.eGreenColor,xyNameStr)
timeStr=FMT.cfmt(FONT_COLOR.eGreenColor,timeStr)
end
widget:SetChildText(rankItemCmpIndex.rankNum,numStr)
widget:SetChildText(rankItemCmpIndex.xyName,xyNameStr)
widget:SetChildText(rankItemCmpIndex.timeText,timeStr)
end
self.noRankTips:setActive(count<=0)
return hasOccupyXy
end

function UIXianJieArenaAct_infoWin:refreshTeamPanel()
local zjList=xianJieArenaActModel:getArenaZhuJunList(self.arenaId)or{}
local count=#zjList
local maxTeamCount=cfgHelper.get(cfg_leitaiyanwubaseconfig_get,1,"guardMax")

self.teamCountText:setText(FMT.fmt("<color=#7d3b17>驻守队伍：</color>{0}/{1}",count,maxTeamCount))


self.teamScrollView:setChildScrollViewCreateGrids(count,1)
local girds=self.teamScrollView:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
local zjData=zjList[i]
local actorId=zjData.massActorid
local guid=zjData.massGuid


local teamNumber=i
widget:SetChildText(teamItemCmpIndex.num,teamNumber)


local iconInfo=zjData.iconInfo
playerController:setHeadIcon(widget,teamItemCmpIndex.head,{iconInfo=iconInfo,scale=0.62})


local serverId=zjData.serverId
local serverName=loginModel:getServerName(serverId)or""
widget:SetChildText(teamItemCmpIndex.serverName,FMT.fmt("[{0}]",serverName))


local xmName=zjData.xmName
widget:SetChildText(teamItemCmpIndex.xmName,xmName)


local playName=zjData.name
widget:SetChildText(teamItemCmpIndex.playerName,playName)


local allSoldierCount=0
local moneyList=zjData.moneyList
local maxSoldierLevel
if moneyList and next(moneyList)then
for i,money in ipairs(moneyList)do
local moneyType=money.param_1
local soldierLevel=yunjiayingModel:getSoldierLevelByMoneyType(moneyType)
if not maxSoldierLevel or soldierLevel>maxSoldierLevel then
maxSoldierLevel=soldierLevel
end
local count=money.param_2
allSoldierCount=allSoldierCount+count
end
end
widget:SetChildText(teamItemCmpIndex.soldierNumText,mathHelper.formatNumber4(allSoldierCount,1))
if maxSoldierLevel then
local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,maxSoldierLevel)
local bgIconName=levelCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(teamItemCmpIndex.soldierBgIcon,iconAb,bgIconName)

local levelIconName=levelCfg.nameIcon
widget:SetChildCSImageSprite(teamItemCmpIndex.soldierNameIcon,iconAb,levelIconName)
end


local posVector2=widget:GetChildScreenPointToLocalPointRectangle(-1)
local pos={posVector2.x,posVector2.y}
widget:SetChildButtonClick(teamItemCmpIndex.clickMask,function()
if not _this then return end
local dzList=xianJieArenaActModel:getArenaZhuJunDzList(actorId,guid)
local posContent=self.teamContent:getChildAnchoredPosition()
if dzList then

self:showWindow("UIXianJieArenaAct_dzListPanelWin",{pos={pos[1],pos[2]+posContent.y},dzList=dzList})
else

local cbFunc=function()
if not _this then return end
local dzList=xianJieArenaActModel:getArenaZhuJunDzList(actorId,guid)
_this:showWindow("UIXianJieArenaAct_dzListPanelWin",{pos={pos[1],pos[2]+posContent.y},dzList=dzList})
end

local args={}
args.callback=cbFunc
local arenaId=self.arenaId
xianJieArenaActController:reqGetXJArenaZhuJunDzList(actorId,guid,arenaId,args)
end
end,true)
end
self.noTeamTips:setActive(count<=0)
end

function UIXianJieArenaAct_infoWin:getArenaOccupySortListData(isReset)
if not isReset and self.arenaOccupySortList and not next(self.arenaOccupySortList)then
return self.arenaOccupySortList
end

local sortList={}
local arenaData=xianJieArenaActModel:getArenaBuildData(self.arenaId)or{}
local selfOccupyData
if arenaData.occupyHis then
local occupyNowServerId=arenaData.occupyServerId
for i,v in ipairs(arenaData.occupyHis)do
local serverId=v.param_1
local occupyTime=v.param_2
local sceneIdx=v.param_3
local occupyData={
serverId=serverId,
occupyTime=occupyTime,
sceneIdx=sceneIdx,
}
if serverId~=occupyNowServerId then
sortList[#sortList+1]=occupyData
else
selfOccupyData=occupyData
end
end
end
table.sort(sortList,function(a,b)
return a.occupyTime>b.occupyTime
end)

self.arenaOccupySortList={sortList=sortList,selfOccupyData=selfOccupyData}
return self.arenaOccupySortList
end

function UIXianJieArenaAct_infoWin:refreshSimpleRecordPanel(isInit)
local logList=self:getArenaSimpleLogSortList(isInit)
local count=#logList
local actStartTime=0
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eLeiTaiYanWu)
if actInfo then
actStartTime=actInfo.start_time
end
self.simpleRecordScrollView:setChildScrollViewCreateGrids(count,1)
local girds=self.simpleRecordScrollView:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
local data=logList[i]
if data then

widget:SetChildText(simpleLogItemCmpIndex.playerName,data.data.attackLeaderName)
local logType=data.logType

local descStr
if logType==1 then

descStr="<color=#549327>攻占擂台成功</color>"
elseif logType==2 then

descStr="<color=#c82c2c>攻占擂台失败</color>"
else
local curTime=data.logTime
descStr=FMT.fmt("<color=#ca631d>{0}到达</color>",timeHelper.format_time_stamp3(actStartTime-curTime))
end
widget:SetChildText(simpleLogItemCmpIndex.simpleDesc,descStr)


local iconName=logTypeIconList[logType]
local abName="ui/windows/xianjiearenaact/xianjiearena_atlas_pak.ab"
widget:SetChildCSImageSprite(simpleLogItemCmpIndex.flagIcon,abName,iconName)
end
end
self.noLogTips:setActive(count<=0)
self.isCanShowDetailPanel=count>0
end

function UIXianJieArenaAct_infoWin:refreshDetailPanel(isInit)

local logList=self:getArenaDetailLogFilterList(isInit)
local count=#logList
local actStartTime=0
local actInfo=limitActivitiesModel:getActInfo(LIMIT_ACT_TYPE.eLeiTaiYanWu)
if actInfo then
actStartTime=actInfo.start_time
end
self.detailScrollView:setChildScrollViewCreateGrids(count,1)
local girds=self.detailScrollView:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
local data=logList[i]
if data then
local logType=data.logType






widget:SetChildActive(detailLogItemCmpIndex.flagIcon,false)


local fairylandLogId=data.fairylandLogId
local resultType=data.data.result

local descStr=data.descStr
if logType==1 or logType==2 then
local str
if logType==1 then
str=FMT.cfmt(FONT_COLOR.eGreenColor,"【进攻方获胜】")
elseif logType==2 then
str=FMT.cfmt(FONT_COLOR.eRedColor,"【进攻方失败】")
end
descStr=FMT.fmt("{0}{1}",str,descStr)
end
widget:SetChildText(detailLogItemCmpIndex.desc,descStr)


local logTime=data.logTime
local logTime_long=timeHelper.convertLongStamp(logTime)
widget:SetChildText(detailLogItemCmpIndex.timeText,timeHelper.dateServerStamp('%Y-%m-%d',logTime_long))


local isAtkHasZsSoldier=data.data.attackZSList and next(data.data.attackZSList)~=nil or false
local isDefHasZsSoldier=data.data.defenseZSList and next(data.data.defenseZSList)~=nil or false
local isShowZsSoldierPanel=isAtkHasZsSoldier and isDefHasZsSoldier
widget:SetChildActive(detailLogItemCmpIndex.soldierInfoPanel,isShowZsSoldierPanel)
if isShowZsSoldierPanel then
local atkZsNum=0
widget:SetChildActive(detailLogItemCmpIndex.atkSoldierInfoBtn,isAtkHasZsSoldier)
if isAtkHasZsSoldier then
local zsList=data.data.attackZSList
for i,v in ipairs(zsList)do
local zsNum=v.qsNum+v.zsNum+v.swNum
atkZsNum=atkZsNum+zsNum
end

widget:SetChildButtonClick(detailLogItemCmpIndex.atkSoldierInfoBtn,function()
if not _this then return end
self:onSoldierInfoBtnClick(widget,detailLogItemCmpIndex.atkSoldierInfoBtn,zsList)
end,true)
end
widget:SetChildText(detailLogItemCmpIndex.atkSoldierStr,FMT.fmt("攻方伤亡修士：<color=#ca631d>{0}</color>",mathHelper.formatNumber4(atkZsNum,1)))

local defZsNum=0
widget:SetChildActive(detailLogItemCmpIndex.defSoldierInfoBtn,isDefHasZsSoldier)
if isDefHasZsSoldier then
local zsList=data.data.defenseZSList
for i,v in ipairs(zsList)do
local zsNum=v.qsNum+v.zsNum+v.swNum
defZsNum=defZsNum+zsNum
end

widget:SetChildButtonClick(detailLogItemCmpIndex.defSoldierInfoBtn,function()
if not _this then return end
self:onSoldierInfoBtnClick(widget,detailLogItemCmpIndex.defSoldierInfoBtn,zsList)
end,true)
end
widget:SetChildText(detailLogItemCmpIndex.defSoldierStr,FMT.fmt("守方伤亡修士：<color=#ca631d>{0}</color>",mathHelper.formatNumber4(defZsNum,1)))
end


local hasFightLog=resultType==1 or resultType==2
widget:SetChildActive(detailLogItemCmpIndex.recordBtn,hasFightLog)
if hasFightLog then
local fightLogId=data.data.fightLogId
local huifang_txt=cfgHelper.get2(cfg_fairylandlogconfig_get,fairylandLogId,"huifang_txt")
local is_win=cfgHelper.get2(cfg_fairylandlogconfig_get,fairylandLogId,"is_win")
widget:SetChildButtonClick(detailLogItemCmpIndex.recordBtn,function()

fightController:send_254_29(fightLogId,{nil,fightLogId,eRePlayerType.xianjielog,huifang_txt,is_win},true,true)
end,true)
end
end
end


self:refreshInputBtns()
end

function UIXianJieArenaAct_infoWin:getXJZmData(actorId)
local zmData
local isSelf=playerModel:checkActorId(actorId)
if isSelf then
zmData=xianjieModel:getMyZongMenData()
else
zmData=xianjieModel:getZongMenData(actorId)
end
return zmData
end

function UIXianJieArenaAct_infoWin:getLogCfgIdByLogData(logData,logType)
local logCfgId
local fairylandLogId
local resultType=logData.result
local cross_sid=loginModel:getCrossServerId()
local defActorId=logData.defenseActorId
local isSelfXianYu=logData.defenseCrossId==cross_sid
if logType==1 then
if resultType==1 then
logCfgId=1
fairylandLogId=isSelfXianYu and 14 or 13
else

if defActorId and not mathHelper.compareInt64(defActorId,Int64_0)then
logCfgId=3
else
logCfgId=7
end
end
elseif logType==2 then
if resultType==2 then
logCfgId=2
fairylandLogId=isSelfXianYu and 16 or 15
else
logCfgId=4
end
elseif logType==3 then
logCfgId=5
elseif logType==4 then
logCfgId=6
end

return logCfgId,fairylandLogId
end

function UIXianJieArenaAct_infoWin:getDetailLogDesc(logData,logCfgId)
local logCfg=cfgHelper.get(cfg_leitaiyanwulogconfig_get,logCfgId)
local descStr=logCfg.logDesc
local atkActorId=logData.attackActorId
local atkActorLeaderName=logData.attackLeaderName
local atkXyName="未知仙域"
local atkZmData=self:getXJZmData(atkActorId)
if atkZmData then
atkXyName=xianjieController:getCrossServerNamebySCidx(atkZmData.ownersceneidx)
end

local defActorId=logData.defenseActorId
local defActorLeaderName=logData.defenseLeaderName
local defXyName="未知仙域"
local defZmData=self:getXJZmData(defActorId)
if defZmData then
defXyName=xianjieController:getCrossServerNamebySCidx(defZmData.ownersceneidx)
end

local arenaCfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.arenaId)
local arenaNameStr=arenaCfg.name or"未知擂台"

descStr=FMT.fmt(descStr,arenaNameStr,atkXyName,atkActorLeaderName,defXyName,defActorLeaderName)
return descStr
end

function UIXianJieArenaAct_infoWin:changeLogPanelShow(isShowDetail)
if self.isShowDetail==nil then
self.isShowDetail=false
end

if isShowDetail==self.isShowDetail then
return
end
self.isShowDetail=isShowDetail
if not isShowDetail then
self:clearSearchInput()
end
self:refreshLeftPanel()
end

function UIXianJieArenaAct_infoWin:getArenaSimpleLogSortList(isReset)
if not isReset and self.arenaSimpleLogSortList and not next(self.arenaSimpleLogSortList)then
return self.arenaSimpleLogSortList
end

local sortList={}
local logDataList=xianJieArenaActModel:getArenaLogList(self.arenaId)or{}
local useTypeList={
[11]=true,
[12]=true,

}
for i,logData in ipairs(logDataList)do
local resultType=logData.result
local isInsert=false
local logType
if useTypeList[resultType]then
isInsert=true
if resultType==11 then
logType=1
elseif resultType==12 then
logType=2
elseif resultType==13 then
if logData.attackCrossId~=logData.defenseCrossId then
logType=3
else
logType=4
end
end
end
if isInsert then
local logGuid_int64=logData.logGuid
local logGuid_num=mathHelper.int64_to_number(logGuid_int64)
sortList[#sortList+1]={
data=logData,
logTime=logData.logTime,
logType=logType,
logGuid_num=logGuid_num,
}
end
end
table.sort(sortList,function(a,b)
if a.logTime==b.logTime then

return a.logGuid_num>b.logGuid_num
else
return a.logTime>b.logTime
end
end)

self.arenaSimpleLogSortList=sortList
return self.arenaSimpleLogSortList
end

function UIXianJieArenaAct_infoWin:getArenaDetailLogSortList(isReset)
if not isReset and self.arenaDetailLogSortList and not next(self.arenaDetailLogSortList)then
return self.arenaDetailLogSortList
end

local sortList={}
local logDataList=xianJieArenaActModel:getArenaLogList(self.arenaId)or{}
local useTypeList={
[1]=true,
[2]=true,
[11]=true,

[13]=true,
}
for i,logData in ipairs(logDataList)do
local resultType=logData.result
local isInsert=false
local logType
if useTypeList[resultType]then
isInsert=true
if resultType==1 or resultType==11 then
logType=1
elseif resultType==2 or resultType==12 then
logType=2
elseif resultType==13 then
if logData.attackCrossId~=logData.defenseCrossId then
logType=3
isInsert=false
else
logType=4
end
end
end
if isInsert then
local logCfgId,fairylandLogId=self:getLogCfgIdByLogData(logData,logType)
local descStr=self:getDetailLogDesc(logData,logCfgId)
local logGuid_int64=logData.logGuid
local logGuid_num=mathHelper.int64_to_number(logGuid_int64)
sortList[#sortList+1]={
data=logData,
logTime=logData.logTime,
logType=logType,
logCfgId=logCfgId,
fairylandLogId=fairylandLogId,
descStr=descStr,
logGuid_num=logGuid_num,
}
end
end
table.sort(sortList,function(a,b)
if a.logTime==b.logTime then

return a.logGuid_num>b.logGuid_num
else
return a.logTime>b.logTime
end
end)

self.arenaDetailLogSortList=sortList
return self.arenaDetailLogSortList
end


function UIXianJieArenaAct_infoWin:getArenaDetailLogFilterList(isInit)
local sortLogList=self:getArenaDetailLogSortList(isInit)
local list={}
local filterName,filterFlag=self:getFilterData()
local isAllFalseFlagList={}
for i,flagList in pairs(self.filterFlag)do
local isAllFalse=true
for i2,v in pairs(flagList)do
if v then
isAllFalse=false
break
end
end
isAllFalseFlagList[i]=isAllFalse
end

for i,v in ipairs(sortLogList)do
local logType=v.logType
local resultType=v.data.result
local atkActorId=v.data.attackActorId
local atkZyType=self:getZhenYingTypeByActorId(atkActorId)
local hasDef=resultType==1 or resultType==2
local defActorId=v.data.defenseActorId
local defZyType=hasDef and self:getZhenYingTypeByActorId(defActorId)or-1
local isInsert=true


if not isAllFalseFlagList[1]and self.filterFlag[1]and next(self.filterFlag[1])then
local idx
if atkZyType==zyTypeList.eSelf or defZyType==zyTypeList.eSelf then
idx=1
elseif atkZyType==zyTypeList.eXMAllies or defZyType==zyTypeList.eXMAllies then
idx=2
elseif atkZyType==zyTypeList.eNotXMAllies or defZyType==zyTypeList.eNotXMAllies then
idx=3
elseif atkZyType==zyTypeList.eEnemy or defZyType==zyTypeList.eEnemy then
idx=4
end
if not self.filterFlag[1][idx]then
isInsert=false
end
end


if isInsert and self.inputstr then
local descStr=v.descStr
if not string.find(descStr,self.inputstr)then
isInsert=false
end
end

if isInsert then
list[#list+1]=v
end
end
return list

end

function UIXianJieArenaAct_infoWin:getZhenYingTypeByActorId(actorId)
local zmData=self:getXJZmData(actorId)
local enemyType=xianjieModel:checkEnemyType2(actorId,zmData.ownersceneidx)
local zyType
if enemyType==xjEnemyType.eSelf then
zyType=zyTypeList.eSelf
elseif enemyType==xjEnemyType.eAllies then
zyType=zyTypeList.eXMAllies
elseif enemyType==xjEnemyType.eEnemy then
zyType=zyTypeList.eEnemy
elseif enemyType==xjEnemyType.eStranger then

local isSelfXianYu=zmData.ownersceneidx==xianjieModel:getXianYuSceneIndex()
if isSelfXianYu then
zyType=zyTypeList.eNotXMAllies
else
zyType=zyTypeList.eEnemy
end
end
return zyType
end


function UIXianJieArenaAct_infoWin:setUpdateTimer()
self:clearUpdateTimer()
if self.updateTimer==nil then
self.updateTimer=self:setTimer(1,0,function()
if not _this then return end
self:refreshRankPanel()
end)
end
end

function UIXianJieArenaAct_infoWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIXianJieArenaAct_infoWin:getFilterData(isReset)
if self.filterName==nil then
self.filterName={}
self.filterName[1]={"筛选范围",{
{name="与我有关",id=1},
{name="同仙盟祖师",id=2},
{name="同仙域祖师",id=3},
{name="敌对祖师",id=4},
}}
end

if isReset or self.filterFlag==nil then
self.filterFlag={}
self.filterFlag[1]={}
for i,v in pairs(self.filterName[1][2])do
self.filterFlag[1][i]=false
end
end

return self.filterName,self.filterFlag
end


function UIXianJieArenaAct_infoWin.selectConditionBack(data)
if _this==nil then
return
end

_this.filterFlag=data.filterFlag
_this:refreshDetailPanel()
end

function UIXianJieArenaAct_infoWin:clearSearchInput()
self.inputstr=nil
local str=''
self.searchInput:setInputFieldValue(str)
self:refreshInputBtns(str)
end

function UIXianJieArenaAct_infoWin:refreshInputBtns()
local showCancel=self.inputstr~=nil
self.searchCancelBtn:setActive(showCancel)
self.searchBtn:setActive(not showCancel)
end

function UIXianJieArenaAct_infoWin:onSearchChange(str)
self:refreshInputBtns(str)
end




function UIXianJieArenaAct_infoWin:onClickMask()
self:onCloseClick()
end



function UIXianJieArenaAct_infoWin:onCloseBtn()
self:onCloseClick()
end



function UIXianJieArenaAct_infoWin:onJijieBtn()

local arenaId=self.arenaId
local arenaData=xianjieModel:getArenaDataByArenaId(arenaId)
if not arenaData then return end

local flag,g_list=arenaData:checkMovePathCondition(true)
if not flag then
return
end

local isCanJiJie,err=xianjieModel:checkCanJiJie()
if not isCanJiJie then
UIManager.error(err)
return
end

local orderType=xjOrderType.eJiJieInitiate
local isChuZheng,isCanChuZheng=xianjieModel:checkXJIsChuZheng(orderType,true)
if not isChuZheng or not isCanChuZheng then
return
end

local gridX=arenaData.gridX
local gridZ=arenaData.gridZ
local sceneidx=arenaData.sceneidx
local speed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eJiJieChuZheng,1)
local wayTime=xianjieModel:getZongMenToPosWayTime(sceneidx,gridX,gridZ,speed,nil,nil,nil)
local extraCost={}


local minSoldierNum=1
local guid=int64.new(tostring(arenaId))
local confirmCb=function(timeSecond)

local func=function(selectDzList,selectMoneyList,boatId)
local ordertype=orderType
local data=xianjieModel:getJiJieLocalData()or{}
local isAutoGoFlag=data.lastSelectAutoFlag or 1
local isEndGoFlag=data.lastSelectEndGoFlag or 0
local params={timeSecond,isAutoGoFlag,isEndGoFlag}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,pstr,boatId,nil,g_list)
end

local maxSoldierNum=tianShuDianController:getJiJieXiuShiMaxCount(_this.arenaId)
return UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func,extraCost=extraCost,wayTime=wayTime,jiJieTime=timeSecond,orderType=orderType,minSoldierNum=minSoldierNum,maxSoldierNum=maxSoldierNum,
})
end

self:showWindow("UIXianJie_JiJie_initiateWin",{confirmCb=confirmCb,extraCost=extraCost,orderType=orderType})

end



function UIXianJieArenaAct_infoWin:onSimpleRecordPanel()
if self.isCanShowDetailPanel==false then

return
end

self:changeLogPanelShow(true)
end



function UIXianJieArenaAct_infoWin:onSortConditionButton()
local filterName,filterFlag=self:getFilterData()
local args={}
args.titleName=cfgHelper.getlang('filter_title_name')

args.extraWin='UIFilterThreeWin'
local extraParams={filterName=filterName,filterFlag=filterFlag,comfirmCallback=self.selectConditionBack}
args.extraParams=extraParams
self:showWindow('UICommonPageTwoWin',args)
end



function UIXianJieArenaAct_infoWin:onSearchBtn()
local inputstr=self.searchInput:getInputFieldValue()

if inputstr==''or inputstr==nil then
if self.inputstr~=nil then

self:clearSearchInput()
self:refreshDetailPanel()
else
UIManager.info('请输入搜索内容')
end
return
end
if self.inputstr==inputstr then
return
end
self.inputstr=inputstr

self:refreshDetailPanel()
end



function UIXianJieArenaAct_infoWin:onSearchCancelBtn()
if self.inputstr==nil then return end

self.inputstr=nil
self:clearSearchInput()
self:refreshDetailPanel()
end

function UIXianJieArenaAct_infoWin:onCloseClick(atOnce)
if self.isFromOvArenaWin then

local win=UIManager:findActiveWindow("UIXianJieExtra_LTYWWin")
if win and win.isVisible then
win:onZhanKuangBtn(1,{arenaId=self.arenaId})
else
UIManager.error("活动已结束")
end
end
xianjieController:closeWin('UIXianJieArenaAct_infoWin',atOnce)
end

function UIXianJieArenaAct_infoWin:onArrowBtn()
self:changeLogPanelShow(false)
end

function UIXianJieArenaAct_infoWin:onSoldierInfoBtnClick(widget,index,zsList)

local posVector2=widget:GetChildScreenPointToLocalPointRectangle(index)
local pos={posVector2.x+170,posVector2.y+190}
self:showWindow("UIXianJie_commonSolderLossInfoWin",{pos=pos,soldierList=zsList})
end

function UIXianJieArenaAct_infoWin:onTeamListBtn()

local win=UIManager:findActiveWindow("UIXianJieExtra_LTYWWin")
if win and win.isVisible then
win:onZhanKuangBtn(2,{filterParam={arenaIdList={self.arenaId}}})
else
UIManager.error("活动已结束")
end
end

function UIXianJieArenaAct_infoWin:onDetailPanelMask()
return self:onArrowBtn()
end

function UIXianJieArenaAct_infoWin:onXjbjbtn()
local _posx=self.sharex
local _posy=self.sharez
local _sceneidx=xianjieModel:getSceneIndex()
local cbid=xianjieController.getZuoBiaoType(7)
xianjieController.openBJwin(_posx,_posy,_sceneidx,cbid)
end