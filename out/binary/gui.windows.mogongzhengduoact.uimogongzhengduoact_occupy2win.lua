







def_class("UIMoGongZhengDuoAct_Occupy2Win",UIWindowBase)









function UIMoGongZhengDuoAct_Occupy2Win:bindComponents()

self.arenaItemGroup=UIObject.get(self,0)
self.center=UIObject.get(self,1)
self.menuGridPanel=UIObject.get(self,2)
self.noRankTips=UIObject.get(self,3)
self.noTeamTips=UIObject.get(self,4)
self.rankBelongName=UIText.get(self,5)
self.rankGotoBuildBtn=UIButton.get(self,6)
self.rankLookTeamBtn=UIButton.get(self,7)
self.rankPanel=UIObject.get(self,8)
self.rankScrollView=UIObject.get(self,9)
self.rewardBtn=UIButton.get(self,10)
self.root=UIObject.get(self,11)
self.teamBelongName=UIText.get(self,12)
self.teamContent=UIObject.get(self,13)
self.teamCountText=UIText.get(self,14)
self.teamGotoBuildBtn=UIButton.get(self,15)
self.teamPanel=UIObject.get(self,16)
self.teamScrollView=UIObject.get(self,17)
self.titleName=UIText.get(self,18)

self.rankGotoBuildBtn:setButtonClick(function()self:onRankGotoBuildBtn()end)

self.rankLookTeamBtn:setButtonClick(function()self:onRankLookTeamBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.teamGotoBuildBtn:setButtonClick(function()self:onTeamGotoBuildBtn()end)



end


function UIMoGongZhengDuoAct_Occupy2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arenaItemGroup);self.arenaItemGroup=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.noRankTips);self.noRankTips=nil;
_UIObject_release(self.noTeamTips);self.noTeamTips=nil;
_UIObject_release(self.rankBelongName);self.rankBelongName=nil;
_UIObject_release(self.rankGotoBuildBtn);self.rankGotoBuildBtn=nil;
_UIObject_release(self.rankLookTeamBtn);self.rankLookTeamBtn=nil;
_UIObject_release(self.rankPanel);self.rankPanel=nil;
_UIObject_release(self.rankScrollView);self.rankScrollView=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.teamBelongName);self.teamBelongName=nil;
_UIObject_release(self.teamContent);self.teamContent=nil;
_UIObject_release(self.teamCountText);self.teamCountText=nil;
_UIObject_release(self.teamGotoBuildBtn);self.teamGotoBuildBtn=nil;
_UIObject_release(self.teamPanel);self.teamPanel=nil;
_UIObject_release(self.teamScrollView);self.teamScrollView=nil;
_UIObject_release(self.titleName);self.titleName=nil;
end
















local _this
local allArenaIndexList={
[1]=xjClientBuildType.flcbMoGong1,
[2]=xjClientBuildType.flcbMGZDZhanHunGe1,
[3]=xjClientBuildType.flcbMGZDHuLingTa1,
[4]=xjClientBuildType.flcbMGZDHuLingTa2,
[5]=xjClientBuildType.flcbMGZDZhanHunGe2,
}

local arenaItemCmpIndex={
selectBg=0,
bdModel=1,
nameBg=2,
name=3,
arrow=4,
clickMask=5,
reddot=6,
numberBg=7,
numberText=8,
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

local rankItemCmpIndex={
rankNum=0,
xyName=1,
timeText=2,
}



function UIMoGongZhengDuoAct_Occupy2Win:onLoaded(...)
self:bindComponents()
_this=self

self:addProNotify(35,118,self.recv_35_118)
end


function UIMoGongZhengDuoAct_Occupy2Win:__delete()
_this=nil
self:unbindComponents()
end




function UIMoGongZhengDuoAct_Occupy2Win:onShow(argtable,afterOnloaded)
self.selectArenaId=argtable and argtable.arenaId
if not self.selectArenaId then
self.selectArenaId=self:getDefaultSelectArenaId()
end


moGongZhengDuoActController:reqMoGongActData()

self:refresh(true)

self:onArenaItemClick(self.selectArenaId)
end

function UIMoGongZhengDuoAct_Occupy2Win:onShowArgRecv(argtable,afterOnloaded)
self:refresh()
end


function UIMoGongZhengDuoAct_Occupy2Win:onHide()

end

function UIMoGongZhengDuoAct_Occupy2Win:getArenaIdData(arenaId)
if arenaId~=xjClientBuildType.flcbMoGong1 then
return xianjieModel:getMGZDBuildServerData(arenaId)or defaultT
else
return moGongZhengDuoActModel:getArenaBuildData(arenaId)or defaultT
end
end

function UIMoGongZhengDuoAct_Occupy2Win:refresh(isInit)

self.needGotRewardArenaList={}
local grids=self.arenaItemGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local arenaId=allArenaIndexList[i]
local widget=grids[i-1]
if arenaId then
widget:SetChildActive(-1,true)
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,arenaId)
if cfg then















local arenaData=self:getArenaIdData(arenaId)or{}
local occupyServerId=arenaData.occupyServerId
local xmGuid=arenaData.xmGuid
local name

local hasOccupy=xmGuid and mathHelper.validInt64(xmGuid)or nil
if hasOccupy then
local isSelfXianYu=xianmengModel:compareTwoGuildID(xmGuid,xianmengModel:myXMGuildID())
name=arenaData.xmName
if isSelfXianYu then
name=FMT.fmt("<color=#2be71d>{0}</color>",name)
end
else
name="暂无归属"
end
widget:SetChildText(arenaItemCmpIndex.name,name)
widget:SetChildActive(arenaItemCmpIndex.nameBg,true)




if isInit then

widget:SetChildActive(arenaItemCmpIndex.clickMask,true)
widget:SetChildButtonClick(arenaItemCmpIndex.clickMask,function()
if not _this then return end
return self:onArenaItemClick(arenaId)
end,true)
end
end


local isSelect=arenaId==self.selectArenaId
widget:SetChildActive(arenaItemCmpIndex.selectBg,isSelect)
widget:SetChildActive(arenaItemCmpIndex.arrow,isSelect)












else
widget:SetChildActive(-1,false)
end
end


self:refreshInfoPanel(isInit)








end

function UIMoGongZhengDuoAct_Occupy2Win:refreshInfoPanel(isInit)
local isMoGong=self.selectArenaId==xjClientBuildType.flcbMoGong1

self.rankPanel:setActive(isMoGong)
self.teamPanel:setActive(not isMoGong)

if isMoGong then
self:refreshRankPanel(isInit)
else
self:refreshTeamPanel(isInit)
end
end

function UIMoGongZhengDuoAct_Occupy2Win:getDefaultSelectArenaId()
local lastSelectArenaId=xianJieArenaActModel:getLastSelectArenaId()
if lastSelectArenaId then
return lastSelectArenaId
end

local openArenaList=xianJieArenaActModel:getArenaBuildList()or{}
local maxArenaId
for i,v in pairs(openArenaList)do
if not maxArenaId or v.buildId>maxArenaId then
maxArenaId=v.buildId
end
end

return maxArenaId
end

function UIMoGongZhengDuoAct_Occupy2Win:selectArena(arenaId)
if not arenaId or self.selectArenaId==arenaId then
return
end
self.selectArenaId=arenaId
xianJieArenaActModel:setLastSelectArenaId(arenaId)
self:refresh()
end

function UIMoGongZhengDuoAct_Occupy2Win:refreshRankPanel(isInit)

local occupySortListData=self:getArenaOccupySortList(self.selectArenaId,isInit)
local occupySortList=occupySortListData.sortList or{}

local selfOccupyData=occupySortListData.selfOccupyData
local arenaData=moGongZhengDuoActModel:getArenaBuildData(self.selectArenaId)

local hasOccupy=arenaData and arenaData.xmGuidStr~='0'
local count=#occupySortList
local nowOccupyTime=0
local isSetNowOccupy=false
if hasOccupy then
count=count+1
local occupyStartTime=arenaData.occupyStartTime or 0
if occupyStartTime>0 then
local nowTime=timeHelper.getServerShortTime()
nowOccupyTime=nowTime-occupyStartTime
end

local occupiedTime=selfOccupyData and selfOccupyData.occupyTime or 0
nowOccupyTime=nowOccupyTime+occupiedTime
end

local xmGuid=xianmengModel:myXMGuildID()

self.rankScrollView:setChildScrollViewCreateGrids(count,1)
local girds=self.rankScrollView:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
local dataIndex=isSetNowOccupy and i-1 or i
local data=occupySortList[dataIndex]
local occupyTime=data and data.occupyTime or 0

local isNowOccupy=false
local xmNameStr=data and data.xmName
local isSelf=false
if not isSetNowOccupy and nowOccupyTime>occupyTime then
occupyTime=nowOccupyTime

isNowOccupy=true
isSetNowOccupy=true
xmNameStr=arenaData.xmName

isSelf=xianmengModel:compareTwoGuildID(xmGuid,arenaData.xmGuid)
end


local numStr=tostring(i)





local timeStr=timeHelper.format_time_stamp3(occupyTime)

if isSelf then
numStr=FMT.cfmt(FONT_COLOR.eGreenColor,numStr)
xmNameStr=FMT.cfmt(FONT_COLOR.eGreenColor,xmNameStr)
timeStr=FMT.cfmt(FONT_COLOR.eGreenColor,timeStr)
end
widget:SetChildText(rankItemCmpIndex.rankNum,numStr)
widget:SetChildText(rankItemCmpIndex.xyName,xmNameStr)
widget:SetChildText(rankItemCmpIndex.timeText,timeStr)
end
local arenaData=moGongZhengDuoActModel:getArenaBuildData(self.arenaId)or{}
local belongName='暂无归属'
if mathHelper.validInt64(arenaData.xmGuid)then
local isSelf=xianmengModel:compareTwoGuildID(arenaData.xmGuid,xianmengModel:myXMGuildID())
local xmNameStr=arenaData.xmName~='0'and arenaData.xmName or'未知仙盟'
xmNameStr=isSelf and toColorString(FONT_COLOR.eGreenTxtColor,xmNameStr)or toColorString(FONT_COLOR.eRedColor,xmNameStr)
belongName=FMT.fmt('当前归属仙盟：{0}',xmNameStr)
end
self.rankBelongName:setText(belongName)
self.noRankTips:setActive(count<=0)
return hasOccupy
end

function UIMoGongZhengDuoAct_Occupy2Win:getArenaOccupySortList(arenaId,isReset)
if not isReset and self.arenaOccupySortList and not next(self.arenaOccupySortList)then
return self.arenaOccupySortList
end

local sortList={}
local arenaData=moGongZhengDuoActModel:getArenaBuildData(self.selectArenaId)or{}

local selfOccupyData
if arenaData.occupyHis then
local xmGuidNow=arenaData.xmGuid
for i,v in ipairs(arenaData.occupyHis)do
local xmGuid=v.xmGuid
local occupyData=v

if xianmengModel:compareTwoGuildID(xmGuid,xmGuidNow)then
selfOccupyData=occupyData
else
sortList[#sortList+1]=occupyData
end
end
end
table.sort(sortList,function(a,b)
return a.occupyTime>b.occupyTime
end)

self.arenaOccupySortList={sortList=sortList,selfOccupyData=selfOccupyData}
return self.arenaOccupySortList
end

function UIMoGongZhengDuoAct_Occupy2Win:refreshTeamPanel(isReset)
local zjList=moGongZhengDuoActModel:getArenaZhuJunList(self.selectArenaId)or{}
local count=#zjList
local maxTeamCount=cfgHelper.get(cfg_mogongyibanjianzhugeconfig_get,self.selectArenaId,"guardMax")

self.teamCountText:setText(FMT.fmt("<color=#c78300>驻守队伍：</color>{0}/{1}",count,maxTeamCount))


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
local dzList=moGongZhengDuoActModel:getArenaZhuJunDzList(actorId,guid)
local posContent=self.teamContent:getChildAnchoredPosition()
if dzList then

self:showWindow("UIXianJieArenaAct_dzListPanelWin",{pos={pos[1],pos[2]+posContent.y},dzList=dzList})
else

local cbFunc=function()
if not _this then return end
local dzList=moGongZhengDuoActModel:getArenaZhuJunDzList(actorId,guid)
_this:showWindow("UIXianJieArenaAct_dzListPanelWin",{pos={pos[1],pos[2]+posContent.y},dzList=dzList})
end

local args={}
args.callback=cbFunc
local arenaId=self.selectArenaId
moGongZhengDuoActController:reqGetMoGongZhuJunDzList(actorId,guid,arenaId,args)
end
end,true)
end
self.noTeamTips:setActive(count<=0)
local arenaData=xianjieModel:getMGZDBuildServerData(self.selectArenaId)or{}
local belongName='暂无归属'
if mathHelper.validInt64(arenaData.xmGuid)then
local isSelf=xianmengModel:compareTwoGuildID(arenaData.xmGuid,xianmengModel:myXMGuildID())
local xmNameStr=arenaData.xmName~='0'and arenaData.xmName or'未知仙盟'
xmNameStr=isSelf and toColorString(FONT_COLOR.eGreenTxtColor,xmNameStr)or toColorString(FONT_COLOR.eRedColor,xmNameStr)
belongName=FMT.fmt('当前归属仙盟：{0}',xmNameStr)
end
self.teamBelongName:setText(belongName)
end


function UIMoGongZhengDuoAct_Occupy2Win:checkEmptyOccupyPrint()
local isAllEmpty=true
local printList={}
for i=1,#allArenaIndexList do
local arenaId=allArenaIndexList[i]
local isArenaOpen=xianJieArenaActModel:checkArenaBuildIsOpenByArenaId(arenaId)
if isArenaOpen then
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
local sceneIdx=arenaData.sceneidx
local hasOccupy=sceneIdx and sceneIdx~=0 or nil
if hasOccupy then
isAllEmpty=false
break
else
printList[#printList+1]=arenaData
end
end
end

if isAllEmpty then

local str=serializeHelper.serialize(printList)
platformSDK.printSDK("UIMoGongZhengDuoAct_Occupy2Win 擂台结算空占用打印:",str)

end
end


function UIMoGongZhengDuoAct_Occupy2Win:onArenaItemClick(arenaId)


moGongZhengDuoActController:reqGetMoGongActData_arenaInfo(arenaId)


end

function UIMoGongZhengDuoAct_Occupy2Win.recv_35_118(buildId,len,logList,len2,zjList)
if _this==nil then return end
_this.selectArenaId=buildId
_this:refresh()
end

function UIMoGongZhengDuoAct_Occupy2Win:onTeamGotoBuildBtn()
local buildID=self.selectArenaId
xianjieController:closeWin("UIMoGongZhengDuoAct_FightInfoWin")

if buildID==xjClientBuildType.flcbMoGong1 then
xianjieController:openMGZDMoGongInfoWin(buildID)
elseif buildID==xjClientBuildType.flcbMGZDZhanHunGe1 or buildID==xjClientBuildType.flcbMGZDZhanHunGe2 then
xianjieController:openMGZDZhanHunGeInfoWin(buildID)
elseif buildID==xjClientBuildType.flcbMGZDHuLingTa1 or buildID==xjClientBuildType.flcbMGZDHuLingTa2 then
xianjieController:openMGZDHuLingTaInfoWin(buildID)
end
end

function UIMoGongZhengDuoAct_Occupy2Win:onRankGotoBuildBtn()
local buildID=self.selectArenaId
xianjieController:closeWin("UIMoGongZhengDuoAct_FightInfoWin")

if buildID==xjClientBuildType.flcbMoGong1 then
xianjieController:openMGZDMoGongInfoWin(buildID)
elseif buildID==xjClientBuildType.flcbMGZDZhanHunGe1 or buildID==xjClientBuildType.flcbMGZDZhanHunGe2 then
xianjieController:openMGZDZhanHunGeInfoWin(buildID)
elseif buildID==xjClientBuildType.flcbMGZDHuLingTa1 or buildID==xjClientBuildType.flcbMGZDHuLingTa2 then
xianjieController:openMGZDHuLingTaInfoWin(buildID)
end
end

function UIMoGongZhengDuoAct_Occupy2Win:onRankLookTeamBtn()
local buildID=self.selectArenaId
xianjieController:closeWin("UIMoGongZhengDuoAct_FightInfoWin")

if buildID==xjClientBuildType.flcbMoGong1 then
xianjieController:openMGZDMoGongInfoWin(buildID,2)
elseif buildID==xjClientBuildType.flcbMGZDZhanHunGe1 or buildID==xjClientBuildType.flcbMGZDZhanHunGe2 then
xianjieController:openMGZDZhanHunGeInfoWin(buildID)
elseif buildID==xjClientBuildType.flcbMGZDHuLingTa1 or buildID==xjClientBuildType.flcbMGZDHuLingTa2 then
xianjieController:openMGZDHuLingTaInfoWin(buildID)
end
end


function UIMoGongZhengDuoAct_Occupy2Win:test_occupyPrint()
local printList={}
for i=1,#allArenaIndexList do
local arenaId=allArenaIndexList[i]
local isArenaOpen=xianJieArenaActModel:checkArenaBuildIsOpenByArenaId(arenaId)
if isArenaOpen then
local arenaData=xianJieArenaActModel:getArenaBuildData(arenaId)or{}
printList[#printList+1]=arenaData
end
end


local str=serializeHelper.serialize(printList)

end
