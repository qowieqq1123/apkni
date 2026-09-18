







def_class("UIXianJie_JiJie_YBDListWin",UIWindowBase)









function UIXianJie_JiJie_YBDListWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.onekeyBtn=UIButton.get(self,1)
self.ruleBtn=UIButton.get(self,2)
self.tipsTxt=UIText.get(self,3)
self.noSign=UIObject.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.itemScrollView=UIObject.get(self,6)
self.wayTimeSortBtn=UIButton.get(self,7)
self.ruleSelect=UIObject.get(self,8)
self.wayTimeSortIcon=UIImage.get(self,9)
self.itemPanel=UIObject.get(self,10)
self.refreshBtn=UIButton.get(self,11)
self.root=UIObject.get(self,12)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.onekeyBtn:setButtonClick(function()self:onOnekeyBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.wayTimeSortBtn:setButtonClick(function()self:onWayTimeSortBtn()end)

self.refreshBtn:setButtonClick(function()self:onRefreshBtn()end)



end


function UIXianJie_JiJie_YBDListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.onekeyBtn);self.onekeyBtn=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.noSign);self.noSign=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.itemScrollView);self.itemScrollView=nil;
_UIObject_release(self.wayTimeSortBtn);self.wayTimeSortBtn=nil;
_UIObject_release(self.ruleSelect);self.ruleSelect=nil;
_UIObject_release(self.wayTimeSortIcon);self.wayTimeSortIcon=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.refreshBtn);self.refreshBtn=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _itemCmpIndex={
bg=0,
num=1,
head=2,
serverName=3,
name=4,
teamGrid=5,
joinBtn=6,
kickOutBtn=7,
soldierBgIcon=8,
soldierNameIcon=9,
soldierNumText=10,
wayTimeText=11,
infoBtn=12,
dzFightValueText=13,
sign=14,
}
local _this




function UIXianJie_JiJie_YBDListWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianJie_JiJie_YBDListWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianJie_JiJie_YBDListWin:onShow(argtable,afterOnloaded)
self.massActorId=argtable and argtable.massActorId
self.massGuid=argtable and argtable.massGuid
self.infoGuid=argtable and argtable.infoGuid
self.isPVE=argtable and argtable.isPVE
local ret=self:initMemberActorIdLookup()
if not ret then
return
end
self.sortOrder=eSortOrder.eDown


local guid=self.isPVE and self.infoGuid or Int64_0
local logicSceneType=xianjieController:transSceneIdxToLogicSceneType(xianjieModel:getSceneIndex())
if xianjieModel:isMoJunBuild_int64(guid)then

guid=int64.new("1")
xianjieController:reqMassYBDList(eYbdType.MoJieYbd,guid)

elseif logicSceneType==eXianJieLogicSceneType.eMoJie then
xianjieController:reqMassYBDList(eYbdType.MoJieYbd,guid)
else
local clientType=xianjieModel:getClientBdYBDTypeByBuildId(self.infoGuid)
if clientType then
xianjieController:reqMassYBDList(clientType,guid)
else
xianjieController:reqMassYBDList(eYbdType.YiShouYbd,guid)
end
end

self:refresh(true)
end


function UIXianJie_JiJie_YBDListWin:onHide()

end

function UIXianJie_JiJie_YBDListWin:refresh(isInit,onlyRefresh)
if isInit then

self.ybdSortDataList={}
elseif not onlyRefresh then
self.ybdSortDataList=self:getSortYbdList()
end

if not onlyRefresh then
self.itemPanel:setChildLayoutGroupCreateItems(#self.ybdSortDataList,function(index)
local widget=self.itemPanel:getChildLayoutGroupGridItem(index-1)
self:refreshItem(widget,index)
end)
else
local grids=self.itemPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local widget=grids[i-1]
self:refreshItem(widget,i)
end
end

local isEmpty=not self.ybdSortDataList or not next(self.ybdSortDataList)
self.noSign:setActive(isEmpty)


local massCfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'mass')
local maxMemberCount=massCfg[2]
local massData=self:getMassDetailData()
if not massData then
return
end
local memberCount=massData.memberCount
local teamNumStr=FMT.fmt("{0}/{1}",memberCount,maxMemberCount)
if memberCount>=maxMemberCount then
teamNumStr=FMT.cfmt(FONT_COLOR.eRedColor,teamNumStr)
else
teamNumStr=FMT.cfmt(FONT_COLOR.eGreenColor,teamNumStr)
end
self.tipsTxt:setText(FMT.fmt("集结队伍数量：{0}",teamNumStr))


self:refreshSortBtn()
end

function UIXianJie_JiJie_YBDListWin:refreshItem(widget,idx)
local data=self.ybdSortDataList[idx]
if data then
widget:SetChildActive(-1,true)
local actorId=data.data.actorid

widget:SetChildText(_itemCmpIndex.num,idx)


local iconInfo=data.data.iconInfo
playerController:setHeadIcon(widget,_itemCmpIndex.head,{iconInfo=iconInfo,scale=0.62})


local playName=data.data.actorname
widget:SetChildText(_itemCmpIndex.name,playName)


local serverId=data.data.serverid
local serverName=loginModel:getServerName(serverId)or""
widget:SetChildText(_itemCmpIndex.serverName,FMT.fmt("[{0}]",serverName))


local xianGuanMsgList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"YBDListXianGuanMsg")

local showJobId=nil
local showPrivilegeId={}
for _,v in ipairs(xianGuanMsgList)do
local jobType=v[1]
local privilegeId=v[2]
local jobInfo=xianguanModel:getDataBykey(XIANGUAN_INFO_KEY_ENUM.eXGInfo_ActorId_XgType_TqID,actorId,jobType,privilegeId)
if jobInfo then
local jobId=jobInfo.jobId
if xianguanHelper.checkSpecialUseCondition(jobId,privilegeId,false)then
showJobId=jobId


table.insert(showPrivilegeId,privilegeId)
end
end
end
local isShowSign=showJobId~=nil
widget:SetChildActive(_itemCmpIndex.sign,isShowSign)
if isShowSign then
local jobCfg=xianguanConfig.getJobConfig2(showJobId)
local chatFlagId=jobCfg.chatFlagId
local flagCfg=cfgHelper.get1(cfg_chatflagconfig_get,chatFlagId)
local signWidget=widget:GetChildWidgetBase(_itemCmpIndex.sign)
signWidget:SetChildActive(1,flagCfg.showType==2)
if flagCfg.showType==1 then
local icon=chatModel:getSignIcon(flagCfg.icon)
if icon then
signWidget:SetChildIcon(0,icon,false)
end
elseif flagCfg.showType==2 then
signWidget:SetChildText(3,flagCfg.name)
local icon=chatModel:getSignIcon(flagCfg.icon)
if icon then
signWidget:SetChildIcon(0,icon,true)
end
if flagCfg.spriteAnimation then
signWidget:SetChildAnimationStringID(2,flagCfg.spriteAnimation)
end
end
widget:SetChildButtonClick(_itemCmpIndex.sign,function()
if not _this then return end
return _this:onSignClick(idx,showPrivilegeId)
end,true)
end


local dzList=data.data.discipleList or{}
local dznum=#dzList
widget:SetChildLayoutGroupCreateItems(_itemCmpIndex.teamGrid,dznum,function(index)
local dzItem=widget:GetChildLayoutGroupGridItem(_itemCmpIndex.teamGrid,index-1)
local netData=dzList[index]
local has=netData~=nil and netData.flag>0
dzItem:SetChildActive(-1,has)
local dzHeadItemWidget=dzItem:GetChildWidgetBase(0)
if has then
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)

comHelper.setChildModelHeadIconBGByColor(dzHeadItemWidget,0,image.color or 1)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(1,dzHeadItemWidget,modelParams,eHeadCenterType.eHead,nil,false)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
dzItem:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

UIDiscipleModel:setDiscipleXianMoHeadImage(dzHeadItemWidget,8,netData)
end
end)
local dzFightValue=0
for i,netData in ipairs(dzList)do
local has=netData~=nil and netData.flag>0
if has then
local fightValue_int64=netData.fightvalue
local fightValue=mathHelper.int64_to_number(fightValue_int64)
dzFightValue=dzFightValue+fightValue
end
end
widget:SetChildText(_itemCmpIndex.dzFightValueText,FMT.fmt("随队弟子战力：{0}",mathHelper.formatNumber3(dzFightValue)))


local allSoldierCount=0
local moneyList=data.data.moneyList
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


local showCount=allSoldierCount
widget:SetChildText(_itemCmpIndex.soldierNumText,mathHelper.formatNumber4(showCount,1))
if maxSoldierLevel then
local levelCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,maxSoldierLevel)
local bgIconName=levelCfg.bgIcon
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
widget:SetChildCSImageSprite(_itemCmpIndex.soldierBgIcon,iconAb,bgIconName)

local levelIconName=levelCfg.nameIcon
widget:SetChildCSImageSprite(_itemCmpIndex.soldierNameIcon,iconAb,levelIconName)
end


local wayTime=data.wayTime
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp(wayTime)
widget:SetChildText(_itemCmpIndex.wayTimeText,time_str)


local actorIdStr=tostring(actorId)
local isMember=false
if self.memberActorIdLookup[actorIdStr]then
isMember=true
end
widget:SetChildActive(_itemCmpIndex.joinBtn,not isMember)
widget:SetChildActive(_itemCmpIndex.kickOutBtn,isMember)
if not isMember then

local isRejected=data.isRejected or false
widget:SetChildGray(_itemCmpIndex.joinBtn,isRejected)


widget:SetChildButtonClick(_itemCmpIndex.joinBtn,function()
if not _this then return end
return _this:onJoinBtnClick(idx,isRejected)
end,true)
else

widget:SetChildButtonClick(_itemCmpIndex.kickOutBtn,function()
if not _this then return end
return _this:onKickOutBtnClick(idx)
end,true)
end


widget:SetChildButtonClick(_itemCmpIndex.infoBtn,function()
if not _this then return end
return _this:onInfoBtnClick(idx,isMember)
end,true)
else
widget:SetChildActive(-1,false)
end
end

function UIXianJie_JiJie_YBDListWin:getSortYbdList()
local ybdDataList=xianjieModel:getJiJieYBDListData()
local sortList={}
for i,v in ipairs(ybdDataList)do
local actorId=v.actorid
local zmData=xianjieModel:getZongMenData(actorId)
if zmData then
local speed=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"march",xjServerMarchType.eJiJieJoin,1)
local wayTime=xianjieModel:getZongMenToPosWayTime(zmData.sceneidx,zmData.gridX,zmData.gridZ,speed,nil,nil,nil)

local isRejected=false
if self.isPVE then
local monsterData=xianjieModel:getMonsterData(self.infoGuid)
local isXianXu=monsterData and monsterData.entitytype==xjServerEnityType.eMonsterHouse
if isXianXu then

local cfg=monsterData:getCfg()
if cfg.flag and cfg.flag==2 then

local xgList=v.xgList or{}
local xxType=cfg.xianguan_xianxu
for _,id in ipairs(xgList)do
if id==xxType then
isRejected=true
break
end
end
else

local xmList=v.xmList or{}
local xmFlag=cfg.xmFlag
for _,id in ipairs(xmList)do
if id==xmFlag then
isRejected=true
break
end
end
end
end
end

if xianjienSceneIndexType:isMoGongZhengDuo(zmData.sceneidx)then
isRejected=true
end

local rejectedWeight=isRejected and 1000 or 0

sortList[#sortList+1]={data=v,wayTime=wayTime,isRejected=isRejected,rejectedWeight=rejectedWeight}
end
end

if self.sortOrder==eSortOrder.eUp then
table.sort(sortList,function(a,b)
if a.rejectedWeight==b.rejectedWeight then
return a.wayTime<b.wayTime
else
return a.rejectedWeight<b.rejectedWeight
end

end)
elseif self.sortOrder==eSortOrder.eDown then
table.sort(sortList,function(a,b)
if a.rejectedWeight==b.rejectedWeight then
return a.wayTime>b.wayTime
else
return a.rejectedWeight<b.rejectedWeight
end
end)
end

return sortList
end

function UIXianJie_JiJie_YBDListWin:updateSortYbdListWithNewSortOrder()
local sortList=self.ybdSortDataList
if self.sortOrder==eSortOrder.eUp then
table.sort(sortList,function(a,b)
return a.wayTime<b.wayTime
end)
elseif self.sortOrder==eSortOrder.eDown then
table.sort(sortList,function(a,b)
return a.wayTime>b.wayTime
end)
end
self.ybdSortDataList=sortList
end

function UIXianJie_JiJie_YBDListWin:initMemberActorIdLookup()
local massData=self:getMassDetailData()
if not massData then
return false
end
self.memberActorIdLookup={}
if massData.memberCount>0 then
local memberList=massData.memberList
for i,v in ipairs(memberList)do
local actorId=v.actorid
local actorIdStr=tostring(actorId)
self.memberActorIdLookup[actorIdStr]=i
end
end
return true
end

function UIXianJie_JiJie_YBDListWin:refreshSortBtn()
local sortIcon
if self.sortOrder==eSortOrder.eUp then
sortIcon='button_tybukepailie'
elseif self.sortOrder==eSortOrder.eDown then
sortIcon='button_tykepailie_2'
end
self.wayTimeSortIcon:setSprite(globalABLookup.global,sortIcon)
end

function UIXianJie_JiJie_YBDListWin:getMassDetailData()
local massData=xianjieModel:getJiJieTeamDetail(self.massActorId,self.massGuid)
if not massData then
UIManager.error("该集结已结束")
self:onCloseBtn()
return
end

local chuZhengSec=massData.sec
if chuZhengSec==0 then
UIManager.error("集结已出击")
self:onCloseBtn()
return
end

return massData
end




function UIXianJie_JiJie_YBDListWin:onClickMask()
self:onCloseBtn()
end



function UIXianJie_JiJie_YBDListWin:onOnekeyBtn()
local massData=self:getMassDetailData()
if not massData then
return
end

local chuZhengSec=massData.sec
if chuZhengSec==0 then

return UIManager.error("集结已结束，无法加入")
else
local nowTime=timeHelper.getServerShortTime()
local remainingTime=chuZhengSec-nowTime
if remainingTime<=0 then

return UIManager.error("集结已结束，无法加入")
end
end


local massCfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'mass')
local maxMemberCount=massCfg[2]
local nowMemberCount=massData.memberCount
local deltaMemberCount=maxMemberCount-nowMemberCount
if deltaMemberCount<=0 then
return UIManager.error("当前队员已满，无法加入更多队员")
end


local allSoldierCount=0
local maxSoldierCount=massData.maxSoldierCount
local memberList=massData.memberList
if memberList and next(memberList)then
for _,v in ipairs(memberList)do
local moneyList=v.moneyList
if moneyList and next(moneyList)then
for _,money in ipairs(moneyList)do
local count=money.param_2
allSoldierCount=allSoldierCount+count
end
end
end
end

local deltaSoldierCount=maxSoldierCount-allSoldierCount
if deltaSoldierCount<=0 then
return UIManager.error("当前兵力已满，无法加入更多队员")
end

if not self.ybdSortDataList or not next(self.ybdSortDataList)then
return UIManager.error("当前没有可邀请加入的预备队，无法一键加入")
end

local gridX_c,gridZ_c,sceneidx=xianjieModel:getZongMenWorldGridCenterPos()

local addActorIdList={}
local addActorGateList={}
local nowTime=timeHelper.getServerShortTime()
local cdTime=xianjieModel:getJiJieSelfMassYBDCd()
for i,data in ipairs(self.ybdSortDataList)do
local actorId=data.data.actorid
local actorIdStr=tostring(actorId)
local isMember=false
if self.memberActorIdLookup[actorIdStr]then
isMember=true
end
if not isMember then

local isRejected=data.isRejected
if not isRejected then

local zmData=xianjieModel:getZongMenData(actorId)
if zmData then
local bornAreaID=zmData:getBornAreaID()
local ret,gateList=xianjieController:checkMovePath(bornAreaID,zmData.sceneidx,zmData.gridX_c,zmData.gridZ_c,sceneidx,gridX_c,gridZ_c)
if ret then


local lastCdStamp=xianjieModel:getJiJieSelfMassYBDCdStamp(self.massGuid,actorId)or 0
local lerp=nowTime-lastCdStamp
if lerp>=cdTime then

local soldierCount=0
local moneyList=data.data.moneyList
if moneyList and next(moneyList)then
for i,money in ipairs(moneyList)do
local moneyType=money.param_1
local count=money.param_2
soldierCount=soldierCount+count
end
end



deltaSoldierCount=deltaSoldierCount-soldierCount
deltaMemberCount=deltaMemberCount-1
addActorIdList[#addActorIdList+1]=actorIdStr
addActorGateList[#addActorGateList+1]=gateList
end
end
end
end
end

if deltaSoldierCount<=0 or deltaMemberCount<=0 then
break
end
end

if not next(addActorIdList)then
return UIManager.error("当前没有可邀请加入的预备队，无法一键加入")
end

local infoguid=self.infoGuid
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieInvite
local params=addActorIdList
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,nil,nil,pstr)
end



function UIXianJie_JiJie_YBDListWin:onRuleBtn()
end



function UIXianJie_JiJie_YBDListWin:onCloseBtn()
self:closeSelf()
end



function UIXianJie_JiJie_YBDListWin:onWayTimeSortBtn()
if self.sortOrder==eSortOrder.eUp then
self.sortOrder=eSortOrder.eDown
elseif self.sortOrder==eSortOrder.eDown then
self.sortOrder=eSortOrder.eUp
end
self:updateSortYbdListWithNewSortOrder()
self:refresh(nil,true)
end



function UIXianJie_JiJie_YBDListWin:onRefreshBtn()

local guid=self.isPVE and self.infoGuid or Int64_0
local logicSceneType=xianjieController:transSceneIdxToLogicSceneType(xianjieModel:getSceneIndex())
if xianjieModel:isMoJunBuild_int64(guid)then

guid=int64.new("1")
xianjieController:reqMassYBDList(eYbdType.MoJieYbd,guid)
return
end
if logicSceneType==eXianJieLogicSceneType.eMoJie then
xianjieController:reqMassYBDList(eYbdType.MoJieYbd,guid)
return
end
local clientType=xianjieModel:getClientBdYBDTypeByBuildId(self.infoGuid)
if clientType then
xianjieController:reqMassYBDList(clientType,guid)
return
end
xianjieController:reqMassYBDList(eYbdType.YiShouYbd,guid)
end

function UIXianJie_JiJie_YBDListWin:onJoinBtnClick(index,isRejected)
local massData=self:getMassDetailData()
if not massData then
return
end

local data=self.ybdSortDataList[index]
local actorId=data.data.actorid
local massguid=self.massGuid
local infoguid=self.infoGuid

if isRejected then

local infoguidNum=mathHelper.int64_to_number(infoguid)
if infoguidNum==xjClientBuildType.flcbMoGong1 then
UIManager.error('魔尊宝库无法使用预备队')
return
end
local actorName=data.data.actorname
local monsterData=xianjieModel:getMonsterData(infoguid)
local cfg=monsterData:getCfg()
local groupid=cfg.monster[1]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
local xianxuNameStr
if cfg.flag and cfg.flag==2 then
xianxuNameStr=groupcfg.name
else
local xmFlag=cfg.xmFlag
local str=""
if xmFlag==1 then
str="(仙)"
elseif xmFlag==2 then
str="(魔)"
end
xianxuNameStr=FMT.fmt("{0}{1}",groupcfg.name,str)
end
local errStr=FMT.fmt("{0}未开启{1}集结",actorName,xianxuNameStr)
UIManager.error(errStr)
return
end

local monsterData=xianjieModel:getMonsterData(infoguid)
local cfg=monsterData and monsterData:getCfg()
if cfg and cfg.consume then
local otherPlayerHasMoneyVal={[eMoneyType.mtXianLing]=data.data.saveXLNum,[eMoneyType.mtMoLing]=data.data.saveMLNum}
for index,subConsume in ipairs(cfg.consume)do
local type=subConsume[1]
local needVal=subConsume[2]

if otherPlayerHasMoneyVal[type]~=nil and needVal>otherPlayerHasMoneyVal[type]then
UIManager.error("预备队消耗不足")
return
end
end
end


local lastCdStamp=xianjieModel:getJiJieSelfMassYBDCdStamp(massguid,actorId)or 0
local cdTime=xianjieModel:getJiJieSelfMassYBDCd()
local nowTime=timeHelper.getServerShortTime()
if nowTime-lastCdStamp<cdTime then
UIManager.error("操作频繁，请稍后再试")
return
end

local chuZhengSec=massData.sec
if chuZhengSec==0 then

return UIManager.error("集结已结束，无法加入更多队员")
else
local remainingTime=chuZhengSec-nowTime
if remainingTime<=0 then

return UIManager.error("集结已结束，无法加入更多队员")
end
end


local massCfg=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'mass')
local maxMemberCount=massCfg[2]
local nowMemberCount=massData.memberCount
local deltaMemberCount=maxMemberCount-nowMemberCount
if deltaMemberCount<=0 then
return UIManager.error("当前队员已满，无法加入更多队员")
end


local allSoldierCount=0
local maxSoldierCount=massData.maxSoldierCount
local memberList=massData.memberList
if memberList and next(memberList)then
for _,v in ipairs(memberList)do
local moneyList=v.moneyList
if moneyList and next(moneyList)then
for _,money in ipairs(moneyList)do
local count=money.param_2
allSoldierCount=allSoldierCount+count
end
end
end
end

local deltaSoldierCount=maxSoldierCount-allSoldierCount
if deltaSoldierCount<=0 then
return UIManager.error("当前兵力已满，无法加入更多队员")
end


local zmData=xianjieModel:getZongMenData(actorId)
if zmData then
local bornAreaID=zmData:getBornAreaID()
local gridX_c,gridZ_c,sceneidx=xianjieModel:getZongMenWorldGridCenterPos()
local ret,gateList,errorParams=xianjieController:checkMovePath(bornAreaID,zmData.sceneidx,zmData.gridX_c,zmData.gridZ_c,sceneidx,gridX_c,gridZ_c,true)
if not ret then

if errorParams then
local errStr=""
local isOtherZmInNeutralArea=errorParams.isSelfInNeutralArea
local isSelfZmInNeutralArea=errorParams.isTargetInNeutralArea
if isOtherZmInNeutralArea then

errStr="处于本阵内无法邀请阵外的祖师参与集结"
elseif isSelfZmInNeutralArea then

errStr="处于阵外无法邀请本阵内的祖师参与集结"
else

errStr="处于本阵内无法邀请其他本阵的祖师内参与集结"
end
UIManager.error(errStr)
end
return
end

local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieInvite
local params={tostring(actorId)}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,nil,nil,pstr,nil,nil,gateList)
end
end

function UIXianJie_JiJie_YBDListWin:onKickOutBtnClick(index)
local massData=self:getMassDetailData()
if not massData then
return
end

local data=self.ybdSortDataList[index]
local actorId=data.data.actorid
local infoguid=self.infoGuid
local massguid=self.massGuid
local massActorId=self.massActorId


local lastCdStamp=xianjieModel:getJiJieSelfMassYBDCdStamp(massguid,actorId)or 0
local cdTime=xianjieModel:getJiJieSelfMassYBDCd()
local nowTime=timeHelper.getServerShortTime()
if nowTime-lastCdStamp<cdTime then
UIManager.error("操作频繁，请稍后再试")
return
end

local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=xjOrderType.eJiJieKickOut
local params={tostring(massActorId),tostring(actorId)}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,nil,nil,pstr)
end

function UIXianJie_JiJie_YBDListWin:onInfoBtnClick(index,isMember)
local data=self.ybdSortDataList[index]
local actorId=data.data.actorid
if isMember then

local actorIdStr=tostring(actorId)
local memberIndex=self.memberActorIdLookup[actorIdStr]
local massActorId=self.massActorId
local massGuid=self.massGuid
local infoGuid=self.infoGuid
self:showWindow("UIXianJie_JiJie_teamInfoWin",{
isTeamInfo=false,
massActorId=massActorId,
massGuid=massGuid,
showMemberIndex=memberIndex,
infoGuid=infoGuid,
})
else

local massActorId=self.massActorId
local massGuid=self.massGuid
local infoGuid=self.infoGuid
self:showWindow("UIXianJie_JiJie_YBDInfoWin",{
isTeamInfo=false,
massActorId=massActorId,
massGuid=massGuid,
actorId=actorId,
infoGuid=infoGuid
})
end
end

function UIXianJie_JiJie_YBDListWin:onSignClick(idx,privilegeId)








local datas={}
for i,v in ipairs(privilegeId)do
local config=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,v)
local data={
icon=xianguanConfig.getTeQuanIconName(config.icon),
name=config.name,
descs=config.tipsDesc or defaultT,
}
table.insert(datas,data)
end
local args={
parentWin=self,
datas=datas,
background=XianGuanCampaignType.eWuXuan,
}
self:showWindow("UIXianGuanPrivilegeListTipsWin",args)
end

