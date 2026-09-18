







def_class("UIXianJie_lingshouInfoWin",UIWindowBase)









function UIXianJie_lingshouInfoWin:bindComponents()

self.actorItem=UIObject.get(self,0)
self.commitBtn=UIButton.get(self,1)
self.commitBtnTxt=UIText.get(self,2)
self.costBg=UIObject.get(self,3)
self.costIcon=UIImage.get(self,4)
self.costNum=UIText.get(self,5)
self.costTimeItem=UIObject.get(self,6)
self.exBtns=UIObject.get(self,7)
self.findXg=UIObject.get(self,8)
self.lockBtn=UIButton.get(self,9)
self.lockPanel=UIObject.get(self,10)
self.lockTxt=UIText.get(self,11)
self.mask=UIButton.get(self,12)
self.mjslpanel=UIObject.get(self,13)
self.mjslskill=UIObject.get(self,14)
self.monsterInfo=UIObject.get(self,15)
self.monsterRewardDetailbtn=UIButton.get(self,16)
self.mzrewardbtn=UIButton.get(self,17)
self.noAttackTimeLeft=UIText.get(self,18)
self.noAttackTips=UIText.get(self,19)
self.posTxt=UIText.get(self,20)
self.progressbar=UIObject.get(self,21)
self.progressValue=UIObject.get(self,22)
self.progressValueTxt=UIText.get(self,23)
self.proroot=UIObject.get(self,24)
self.proTipbtn=UIButton.get(self,25)
self.proTitle=UIText.get(self,26)
self.recommendedItem=UIObject.get(self,27)
self.recommendjzItem=UIObject.get(self,28)
self.recordBtn=UIButton.get(self,29)
self.rewardPanel=UIObject.get(self,30)
self.rewardPanelBg1=UIObject.get(self,31)
self.rewardPanelBg2=UIObject.get(self,32)
self.rewardTips=UIText.get(self,33)
self.rewardView=UIObject.get(self,34)
self.root=UIObject.get(self,35)
self.ruleBtn=UIButton.get(self,36)
self.shareBtn=UIButton.get(self,37)
self.shdBtn=UIButton.get(self,38)
self.shdTx=UIText.get(self,39)
self.showRewardBtn=UIButton.get(self,40)
self.stateLayout=UIObject.get(self,41)
self.stateTimeTxt=UIText.get(self,42)
self.stateTxt=UIText.get(self,43)
self.teamItem=UIObject.get(self,44)
self.texingBtn=UIButton.get(self,45)
self.timeRemaining=UIObject.get(self,46)
self.TisBtn=UIButton.get(self,47)
self.troopsItem=UIObject.get(self,48)
self.unlockPanel=UIObject.get(self,49)
self.xjbjbtn=UIButton.get(self,50)
self.xmItem=UIObject.get(self,51)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.lockBtn:setButtonClick(function()self:onLockBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.monsterRewardDetailbtn:setButtonClick(function()self:onMonsterRewardDetailbtn()end)

self.mzrewardbtn:setButtonClick(function()self:onMzrewardbtn()end)

self.proTipbtn:setButtonClick(function()self:onProTipbtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.shdBtn:setButtonClick(function()self:onShdBtn()end)

self.showRewardBtn:setButtonClick(function()self:onShowRewardBtn()end)

self.texingBtn:setButtonClick(function()self:onTexingBtn()end)

self.TisBtn:setButtonClick(function()self:onTisBtn()end)

self.xjbjbtn:setButtonClick(function()self:onXjbjbtn()end)



end


function UIXianJie_lingshouInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actorItem);self.actorItem=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commitBtnTxt);self.commitBtnTxt=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costTimeItem);self.costTimeItem=nil;
_UIObject_release(self.exBtns);self.exBtns=nil;
_UIObject_release(self.findXg);self.findXg=nil;
_UIObject_release(self.lockBtn);self.lockBtn=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.lockTxt);self.lockTxt=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.mjslpanel);self.mjslpanel=nil;
_UIObject_release(self.mjslskill);self.mjslskill=nil;
_UIObject_release(self.monsterInfo);self.monsterInfo=nil;
_UIObject_release(self.monsterRewardDetailbtn);self.monsterRewardDetailbtn=nil;
_UIObject_release(self.mzrewardbtn);self.mzrewardbtn=nil;
_UIObject_release(self.noAttackTimeLeft);self.noAttackTimeLeft=nil;
_UIObject_release(self.noAttackTips);self.noAttackTips=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.progressValueTxt);self.progressValueTxt=nil;
_UIObject_release(self.proroot);self.proroot=nil;
_UIObject_release(self.proTipbtn);self.proTipbtn=nil;
_UIObject_release(self.proTitle);self.proTitle=nil;
_UIObject_release(self.recommendedItem);self.recommendedItem=nil;
_UIObject_release(self.recommendjzItem);self.recommendjzItem=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardPanelBg1);self.rewardPanelBg1=nil;
_UIObject_release(self.rewardPanelBg2);self.rewardPanelBg2=nil;
_UIObject_release(self.rewardTips);self.rewardTips=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.shdBtn);self.shdBtn=nil;
_UIObject_release(self.shdTx);self.shdTx=nil;
_UIObject_release(self.showRewardBtn);self.showRewardBtn=nil;
_UIObject_release(self.stateLayout);self.stateLayout=nil;
_UIObject_release(self.stateTimeTxt);self.stateTimeTxt=nil;
_UIObject_release(self.stateTxt);self.stateTxt=nil;
_UIObject_release(self.teamItem);self.teamItem=nil;
_UIObject_release(self.texingBtn);self.texingBtn=nil;
_UIObject_release(self.timeRemaining);self.timeRemaining=nil;
_UIObject_release(self.TisBtn);self.TisBtn=nil;
_UIObject_release(self.troopsItem);self.troopsItem=nil;
_UIObject_release(self.unlockPanel);self.unlockPanel=nil;
_UIObject_release(self.xjbjbtn);self.xjbjbtn=nil;
_UIObject_release(self.xmItem);self.xmItem=nil;
end
















local _this

local _showType={
[xjServerEnityType.eLingShou]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hujianguiwu_03"},
[xjServerEnityType.eLingShouGroup]={"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hujianguiwu_04"},
}

local _btnName={
[xjServerEnityType.eLingShou]="挑战",
[xjServerEnityType.eLingShouGroup]="挑战",
}




function UIXianJie_lingshouInfoWin:onLoaded(...)
self:bindComponents()

_this=self

if self.mytimer==nil then
_this:updateTime()
self.mytimer=self:setTimer(1,0,function()
_this:updateTime()
end)
end

local _onXianJieLingShouDataChange=function(opType,guid)
if _this==nil then return end
if guid~=_this.infoguid then return end
if opType==CHANGE_TYPE.eDelete then
_this:onCloseClick()
elseif opType==CHANGE_TYPE.eChanged then
local lsData=xianjieController:getLingShouData(guid)
if lsData and lsData.isExpire then
_this:onCloseClick()
else
_this:refreshView()
end
end
end
self:addNotify(notifyConfig.onXianJieLingShouDataChange,_onXianJieLingShouDataChange)
end


function UIXianJie_lingshouInfoWin:__delete()

local lsData=xianjieController:getLingShouData_exExpire(self.infoguid)
if lsData and lsData.selectEntity then
lsData:selectEntity(false)
end

if self.mytimer then
self:stopTimerByID(self.mytimer)
self.mytimer=nil
end

_this=nil
self:unbindComponents()
end




function UIXianJie_lingshouInfoWin:onShow(argtable,afterOnloaded)
self.infoguid=argtable.infoguid
local lsData=xianjieController:getLingShouData(self.infoguid)

if lsData==nil then self:closeSelf()return end

self:refreshInfo(lsData)
self:refreshExPart()

if afterOnloaded then
if lsData then
lsData:selectEntity(true)
end
end
end


function UIXianJie_lingshouInfoWin:onHide()

end


function UIXianJie_lingshouInfoWin:onShowArgRecv(argtable)
local oldGuid=self.infoguid
if oldGuid and not mathHelper.compareInt64(oldGuid,argtable.infoguid)then
local lsData=xianjieController:getLingShouData(oldGuid)
if lsData then
lsData:selectEntity(false)
end
lsData=xianjieController:getLingShouData(argtable.infoguid)
if lsData then
lsData:selectEntity(true)
end
end
self:refreshView(argtable.infoguid)
end

function UIXianJie_lingshouInfoWin:updateTime()
if self.isActiveTimer then
self:refreshStateDesc()
end
local monsterData=xianjieModel:getMonsterData(self.infoguid)
if not monsterData then
return
elseif monsterData.expiresec~=0 then
self:refreshTimeRemaining()
end
end

function UIXianJie_lingshouInfoWin:refreshView(infoguid)
if mathHelper.compareInt64(self.infoguid,infoguid)then return end
local lsData=xianjieController:getLingShouData(self.infoguid)
if lsData==nil then self:closeSelf()return end

self.infoguid=infoguid
self:refreshInfo()
self:refreshExPart()
end


function UIXianJie_lingshouInfoWin:refreshInfo(lsData)
if lsData==nil then
lsData=xianjieController:getLingShouData(self.infoguid)
end
if lsData==nil then self:closeSelf()return end

local zmData=xianjieModel:getZongMenData(lsData.ownerActorId)
local xmData=xianjieModel:getXianMengData(lsData.ownerXMGuid)
local cfg=lsData:getCfg()
local gridX_c,gridZ_c=lsData:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c
self.entitytype=lsData.entitytype

local monsterInfoWidget=self.monsterInfo:getWidgetBase()
local groupid=cfg.monster[1]
local groupcfg=cfgHelper.get1(cfg_monstergroup_get,groupid)
local bgName=FMT.fmt('image_gwtouxiangpjk_{0}',cfg.color)
monsterInfoWidget:SetChildActive(6,true)
monsterInfoWidget:SetChildUIModelRemoveTarget(0)
monsterInfoWidget:SetChildCSImageSprite(6,globalABLookup.global,bgName)
comHelper.setChildModelRawImage_monsterGroup(monsterInfoWidget,groupid,7,0,eHeadCenterType.eHead)

local typeImg=_showType[lsData.entitytype]
if typeImg then
monsterInfoWidget:SetChildCSImageSprite(11,typeImg[1],typeImg[2])
else
monsterInfoWidget:SetChildCSImageIcon(11,"",true)
end

monsterInfoWidget:SetChildActive(1,true)
monsterInfoWidget:SetChildActive(13,false)


local nameStr=groupcfg.name



monsterInfoWidget:SetChildText(1,nameStr)


local lsSceneIdx=lsData.sceneidx
if xianjienSceneIndexType:isOhterXianYu(lsSceneIdx)then

self.costTimeItem:setActive(false)
else
self.costTimeItem:setActive(true)
local costTimeWidget=self.costTimeItem:getWidgetBase()
local wayTime=lsData:getBaseWayTime()
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
costTimeWidget:SetChildText(0,time_str)
end

self.actorItem:setActive(zmData~=nil)
if zmData then
local actorWidget=self.actorItem:getWidgetBase()
actorWidget:SetChildText(0,zmData.actorname)

local clickFunc=function()

end
actorWidget:SetChildButtonClick(1,clickFunc,true)
end

self.xmItem:setActive(xmData~=nil)
if xmData then
local xmWidget=self.xmItem:getWidgetBase()
xmWidget:SetChildText(0,xmData.guildname)
local abname=globalABLookup.xianmengicons
local image=xianmengModel.splitGuildIcon(xmData.guildicon)

xmWidget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

xmWidget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

xmWidget:SetChildCSImageSprite(3,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local clickFunc=function()

end
xmWidget:SetChildButtonClick(4,clickFunc,true)
end

local recommendedWidget=self.recommendedItem:getChildWidgetBase()
local recommendedStr=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"recommend",lsData.entitytype,cfg.stage)
if recommendedStr==nil then
logErr("仙界配置- 基础配置 recommend 缺少配置",lsData.entitytype,cfg.stage)
end
recommendedStr=mathHelper.formatNumber(recommendedStr)
recommendedWidget:SetChildText(0,recommendedStr)

local recommendjzStr
local recommendjz=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"recommendJZ")
if recommendjz then
local ent_recommendjz=recommendjz[lsData.entitytype]or{}
recommendjzStr=ent_recommendjz[cfg.stage]
end
self.recommendjzItem:setActive(recommendjzStr~=nil)
if recommendjzStr then
local recommendjzWidget=self.recommendjzItem:getChildWidgetBase()
recommendjzWidget:SetChildText(0,recommendjzStr)
end

self.rewardPanelBg1:setActive(lsData.entitytype==xjServerEnityType.eLingShou)
self.rewardPanelBg2:setActive(lsData.entitytype==xjServerEnityType.eLingShouGroup)


local dropID=lsData.isMySelf and cfg.reward[1]or cfg.reward[2]
local dropCfg=cfgHelper.get1(cfg_awardconfig_get,dropID)
local rewards=dropCfg.showItems or{}

if cfg.ex_drop then
local csid=xianjieModel:getMoJieEnterConfig('csid')
local ex_drop=cfg.ex_drop[csid]
local ex_dropCfg=cfgHelper.get1(cfg_awardconfig_get,ex_drop[2])
local ex_dropItems=ex_dropCfg.showItems or{}
local ispass=false
local csid=xianjieController:getMoJieSaiJiWanFaID()
if ex_drop[1]==0 then
ispass=true
elseif csid and seasonController:checkSeasonStageBegined(csid,ex_drop[1])then
ispass=true
end
if ispass then
local rewards2=table.weakCopy(ex_dropItems)
local old_rewards=dropCfg.showItems or{}
for k,v in ipairs(old_rewards)do
table.insert(rewards2,v)
end
rewards=rewards2
end
end
local rnum=#rewards
self.rewardPanel:setChildLayoutGroupCreateItems(rnum)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,rnum do
local rwItem=grids[i-1]
local itemData=rewards[i]
local itemid=itemData[1]
local itemnum=itemData[2]
local percent=itemData[4]
local isxmkf=itemData.isxmkf or false
local itemcount,showCountBG
local isShowPercent=percent~=nil
local range
if percent then
showCountBG=false
itemcount=""
else
range=itemData.range
if itemnum>1 or itemData.range~=nil then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
end

local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false,range=range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then
return
end
_this:onClickItem(...)
end)

local showSign=itemnum<=0 and itemData.range==nil and percent==nil
rwItem:SetChildActive(1,showSign)
rwItem:SetChildActive(2,isShowPercent)
if isShowPercent then
rwItem:SetChildText(3,FMT.fmt("{0}%",percent))
end
rwItem:SetChildActive(4,isxmkf)

end
self.rewardView:setChildScrollRectEnable(rnum>=5)


local marchguid
self.isActiveTimer=nil
local wpData=xianjieModel:getWaiPaiByQBEntityData2(xjWaiPiaBaseType.eMarckTeam,self.infoguid)
if wpData then
marchguid=wpData.guid
self.isActiveTimer=true
else
local teamData=xianjieModel:getSelfJiJieTeamDataByInfoguid(self.infoguid)
if teamData then
local teamHandleId=teamData.teamHandleId
local teamHandle_=xianjieController:getXJTeamHandle(teamHandleId)
local state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjJiJieTeamStateType.eNone then
self.isActiveTimer=true
end
end
end
self.marchguid=marchguid
self:refreshStateDesc()


local btnStr=_btnName[lsData.entitytype]
self.commitBtnTxt:setText(btnStr)

self:refreshRewardTimes(lsData)

self.monsterRewardDetailbtn:setActive(false)
self.timeRemaining:setActive(false)
self.TisBtn:setActive(false)

self.unlockPanel:setActive(true)
self.findXg:setActive(false)
self.troopsItem:setActive(false)
end

function UIXianJie_lingshouInfoWin:refreshStateDesc()
local teamHandle
local state,timeData,lerp
local desc
if self.marchguid then
local teamData=xianjieModel:getMarchTeamData(self.marchguid)
if teamData then
local teamHandle_=teamData:getTeamHandle()
state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjMarchTeamStateType.eNone then
teamHandle=teamHandle_
desc=xjMarchTeamStateType:getDesc(state)or''
end
end
if teamHandle==nil then
self.marchguid=nil
end
else
local teamData=xianjieModel:getSelfJiJieTeamDataByInfoguid(self.infoguid)
if teamData then
local teamHandleId=teamData.teamHandleId
local teamHandle_=xianjieController:getXJTeamHandle(teamHandleId)
state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjJiJieTeamStateType.eNone then
teamHandle=teamHandle_
desc=xjJiJieTeamStateType:getDesc(state)or''
end
end
end

local hasWaiPai=teamHandle~=nil

local showBtn=not hasWaiPai
self.commitBtn:setActive(showBtn)

self.stateLayout:setActive(hasWaiPai)
if hasWaiPai then
self.stateTxt:setText(desc)
local time_str
if lerp>0 then
time_str=timeHelper.format_time_stamp3(lerp)
else
time_str='--'
end
self.stateTimeTxt:setText(time_str)
else
self.isActiveTimer=nil
end
end

function UIXianJie_lingshouInfoWin:refreshRewardTimes(lsData)
if lsData==nil then
lsData=xianjieModel:getlsData(self.infoguid)
end

if lsData==nil then
return
end

self.rewardTips:setText("")
end



function UIXianJie_lingshouInfoWin:refreshExPart()
self:refreshExPart_BiaoJi()
end

function UIXianJie_lingshouInfoWin:refreshExPart_BiaoJi()

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



function UIXianJie_lingshouInfoWin:onCloseClick(atOnce)
xianjieController:closeWin('UIXianJie_lingshouInfoWin',atOnce)
end





function UIXianJie_lingshouInfoWin:onCommitBtn()
local flag=xianjieModel:checkTriggerSeasonStageBehaivour()
if flag then
_this:onCloseClick()
return
end

local infoguid=self.infoguid
local lsData=xianjieController:getLingShouData(infoguid)
local cfg=lsData:getCfg()
local monsterGroupId=cfg.monster[1]
local monsterList=cfgHelper.get2(cfg_monstergroup_get,monsterGroupId,"monList")
local monsterFight=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"recommend",lsData.entitytype,cfg.stage)

local monsterSceneIdx=lsData.sceneidx
if xianjienSceneIndexType:isOhterXianYu(monsterSceneIdx)then

return UIManager.error("无法前往其他仙域")
end

if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end

if lsData.entitytype==xjServerEnityType.eLingShou and not lsData.isMySelf then
if lsData.shareFlag==0 then
return UIManager.error("需盟友分享后才能挑战")
end
end

local flag,g_list,errorParams=lsData:checkMovePathCondition(true)
local orderType=xjMonsterFightOrderMapping[lsData.entitytype]or xjOrderType.eAttack
local isJiJie=orderType==xjOrderType.eJiJieInitiate
local isChuZheng,isCanChuZheng,tipsChuZheng=xianjieModel:checkXJIsChuZhengEx(orderType,false)
local wayTime=lsData:getBaseWayTime()
if not isChuZheng then
local costList=cfg.consume


local winArgs={
enterCallBack=function(selectList,zfId,mapId)
local dzlist={}
for i,v in ipairs(selectList)do
table.insert(dzlist,v[2])
end

local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)

xianjieController:reqOrder(guid,orderType,dzlist,nil,nil,nil,nil,g_list)
UIManager:closeWindow('UIXianGuan_fightExtraWin')
fightController:closeSelectStage()
UIFullFightPrepareControl:closeActiveUI()

end,
enterTxt="仙界",
cancelCallBack=function()
UIManager:closeWindow('UIXianGuan_fightExtraWin')
fightController:closeSelectStage()
xianjieController:openMonsterInfoWin(infoguid)
end,
groupId=monsterGroupId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
isCheckXJOccupyType=true,
statePriorityCheck=false,
showZhenFa=false,





xjWayTime=wayTime,
costList=costList,
targetFight=monsterFight,
}
local dzInfoFuncList={}
local dzlist=UIDiscipleModel:getSortList()
for i,netData in ipairs(dzlist)do
local d={guid=netData.discipleguid}
xianjieModel:initBattleDZ(d)
dzInfoFuncList[netData.discipleguidStr]=d
end
winArgs.dzInfoFuncList=dzInfoFuncList
winArgs.checkDZSortFunc=xianjieModel.checkDZSortFunc
fightController.showPrepareWin(fightPreSelectModel.fightType.xianjieMonster,winArgs,function()
UIManager:showWindow('UIXianGuan_fightExtraWin')
end)


elseif isChuZheng then
if isCanChuZheng>0 then
if zongmenModel:haveBuildByBuildIdEx(SLG_SYSTEM_TYPE.eXianYunGang,false)then

UIManager.error(tipsChuZheng)
else

local buildname=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eXianYunGang,"name")
local str=FMT.fmt("{0}未建造，无法发起征讨\n是否前往建造？",buildname)
UIDialogManager.getCommonDialog(nil,str,function()
jumpManager:jump({id=JUMP_TYPE.eUnlockRepairBuild2,args={buildType=SLG_SYSTEM_TYPE.eXianYunGang,mapid=mapIdType.fort,weakGuide=4110}})
end)
end
return
end

local extraCost=cfg.consume

if isJiJie then

local isCanJiJie,err=xianjieModel:checkCanJiJie()
if not isCanJiJie then
return UIManager.error(err)
end


local _func=function()
local minSoldierNum=1
local confirmCb=function(timeSecond)

local func=function(selectDzList,selectMoneyList,boatId)
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=orderType
local data=xianjieModel:getJiJieLocalData()or{}
local isAutoGoFlag=data.lastSelectAutoFlag or 1
local isEndGoFlag=data.lastSelectEndGoFlag or 0
local params={timeSecond,isAutoGoFlag,isEndGoFlag}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,pstr,boatId,nil,g_list)
end

local maxSoldierNum=tianShuDianController:getJiJieXiuShiMaxCount(lsData.entitytype)
return UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func,
extraCost=extraCost,
wayTime=wayTime,
jiJieTime=timeSecond,
orderType=orderType,
minSoldierNum=minSoldierNum,
maxSoldierNum=maxSoldierNum,
confirmBtnStr="发起集结",
targetFight=monsterFight,
})
end
local isXianXu=lsData.entitytype==xjServerEnityType.eMonsterHouse
self:showWindow("UIXianJie_JiJie_initiateWin",{confirmCb=confirmCb,extraCost=extraCost,orderType=orderType,isXianXu=isXianXu})
end

local rewardTimeConf=cfgHelper.get4(cfg_fairylandbaseconfig_get,1,"info",1,lsData.entitytype)
if rewardTimeConf and not(lsData.entitytype==xjServerEnityType.eMonsterHouse and cfg.flag and cfg.flag==2)then
local maxTimes=rewardTimeConf[1]
local curTimes=xianjieModel:getMonsterRewardTimes(lsData.entitytype)
local least=maxTimes-curTimes
if least<=0 then
local args={
content="征讨奖励次数为<color=#c82c2c>0</color>，无法获得奖励\n是否继续发起集结？",
oktext="集结",
okcb=_func
}
local _dialog=UIDialogManager.getConfirmDialogEx(nil,args)
_dialog:show()
return
end
end

_func()
else

local func=function(selectDzList,selectMoneyList,boatId)
local infoguid_str=tostring(infoguid)
local guid=int64.new(infoguid_str)
local ordertype=orderType
local params=''
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,params,boatId,nil,g_list)
end

UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({callback=func,extraCost=extraCost,wayTime=wayTime,orderType=orderType,targetFight=monsterFight})
end
end
end



function UIXianJie_lingshouInfoWin:onLockBtn()
end



function UIXianJie_lingshouInfoWin:onMask()
end



function UIXianJie_lingshouInfoWin:onMonsterRewardDetailbtn()
end



function UIXianJie_lingshouInfoWin:onMzrewardbtn()
end



function UIXianJie_lingshouInfoWin:onProTipbtn()
end



function UIXianJie_lingshouInfoWin:onRecordBtn()
end



function UIXianJie_lingshouInfoWin:onRuleBtn()
end



function UIXianJie_lingshouInfoWin:onShareBtn()
self:showWindow("UIXianJieLingShouShareWin",{infoGuid=self.infoguid})
end



function UIXianJie_lingshouInfoWin:onShdBtn()
end



function UIXianJie_lingshouInfoWin:onShowRewardBtn()
end



function UIXianJie_lingshouInfoWin:onTexingBtn()
end



function UIXianJie_lingshouInfoWin:onTisBtn()
end



function UIXianJie_lingshouInfoWin:onXjbjbtn()
end

