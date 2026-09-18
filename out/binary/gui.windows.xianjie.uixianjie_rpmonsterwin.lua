







def_class("UIXianJie_RPMonsterWin",UIWindowBase)









function UIXianJie_RPMonsterWin:bindComponents()

self.cdBg=UIObject.get(self,0)
self.cdTx=UIText.get(self,1)
self.commitBtn=UIButton.get(self,2)
self.costBg=UIObject.get(self,3)
self.costIcon=UIImage.get(self,4)
self.costNum=UIText.get(self,5)
self.costTimeTxt=UIText.get(self,6)
self.mask=UIButton.get(self,7)
self.monsterIcon=UIObject.get(self,8)
self.monsterKuang=UIImage.get(self,9)
self.monsterLvBg=UIImage.get(self,10)
self.monsterLvTx=UIText.get(self,11)
self.monsterName=UIText.get(self,12)
self.posTxt=UIText.get(self,13)
self.recommendedTxt=UIText.get(self,14)
self.recordBtn=UIButton.get(self,15)
self.rewardPanel=UIObject.get(self,16)
self.rewardView=UIObject.get(self,17)
self.root=UIObject.get(self,18)
self.ruleBtn=UIButton.get(self,19)
self.showRewardBtn=UIButton.get(self,20)
self.source_1=UIObject.get(self,21)
self.stateLayout=UIObject.get(self,22)
self.stateTimeTxt=UIText.get(self,23)
self.stateTxt=UIText.get(self,24)
self.stateimg=UIImage.get(self,25)
self.tsuoimg=UIImage.get(self,26)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.showRewardBtn:setButtonClick(function()self:onShowRewardBtn()end)
self.source={
self.source_1,
}



end


function UIXianJie_RPMonsterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cdBg);self.cdBg=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costTimeTxt);self.costTimeTxt=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.monsterIcon);self.monsterIcon=nil;
_UIObject_release(self.monsterKuang);self.monsterKuang=nil;
_UIObject_release(self.monsterLvBg);self.monsterLvBg=nil;
_UIObject_release(self.monsterLvTx);self.monsterLvTx=nil;
_UIObject_release(self.monsterName);self.monsterName=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.recommendedTxt);self.recommendedTxt=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.showRewardBtn);self.showRewardBtn=nil;
_UIObject_release(self.source_1);self.source_1=nil;
_UIObject_release(self.stateLayout);self.stateLayout=nil;
_UIObject_release(self.stateTimeTxt);self.stateTimeTxt=nil;
_UIObject_release(self.stateTxt);self.stateTxt=nil;
_UIObject_release(self.stateimg);self.stateimg=nil;
_UIObject_release(self.tsuoimg);self.tsuoimg=nil;
self.source=nil;
end















local _this=nil
local _colorKuang={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.BigBoss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_5",
}



function UIXianJie_RPMonsterWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
self:addNotify(notifyConfig.onXianJieResPointDataChange,self.onXianJieResPointDataChange)
self:addNotify(notifyConfig.onXianJieResPointMarchChange,self.onXianJieResPointMarchChange)
end


function UIXianJie_RPMonsterWin:__delete()
self:unbindComponents()
_this=nil
self:stopCDTick()
self:stopMarchTick()
xianjieController:closeWin2(self.__name)
local rpData=xianjieModel:getResPointData(self.guid)
if rpData then
rpData:selectEntity(false)
end
end




function UIXianJie_RPMonsterWin:onShow(argtable,afterOnloaded)
self.guid=argtable.guid
local rpData=xianjieModel:getResPointData(self.guid)
if rpData==nil then
_this:onMask()
return
end
self:refreshView()
if afterOnloaded then
if rpData then
rpData:selectEntity(true)
end
end
end


function UIXianJie_RPMonsterWin:onHide()

end

function UIXianJie_RPMonsterWin:onShowArgRecv(argtable)
local oldGuid=self.guid
if oldGuid and oldGuid~=argtable.guid then
local data=xianjieModel:getResPointData(oldGuid)
if data then
data:selectEntity(false)
end
data=xianjieModel:getResPointData(argtable.guid)
if data then
data:selectEntity(true)
end
end
self:onShow(argtable,false)
end

function UIXianJie_RPMonsterWin:onCloseClick()
xianjieController:closeWin('UIXianJie_RPMonsterWin')
end



function UIXianJie_RPMonsterWin:onCommitBtn()

local flag=xianjieModel:checkTriggerSeasonStageBehaivour()
if flag then
_this:onCloseClick()
return
end
local guid=self.guid

if xianjieModel:haveResPointMarch(guid)then
UIManager.info("已派遣队伍前往")
return
end

if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end

local rpData=xianjieModel:getResPointData(guid)
if not rpData then
UIManager.info("目标已不存在")
return
elseif rpData.deadTime then
UIManager.info("目标已死亡")
return
end

local flag,g_list,errorParams=rpData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法进攻本阵内的魔物"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法进攻阵外的魔物"
else

errStr="处于本阵内无法进攻其他本阵内的魔物"
end
UIManager.error(errStr)
end
return
end

local wayTime=rpData:getBaseWayTime()
local nowTime=timeHelper.getServerShortTime()
if rpData.endTime>0 and rpData.endTime-nowTime<wayTime then
UIManager.info("剩余时间不足以前往目标")
return
end

local _taskid
if rpData.source and rpData.source.srctype==xjResPointSourceType.eXianBangTask then
_taskid=rpData.source.taskid
end
local rpCfg=rpData:getCfg()
local needCheckCost=rpCfg.costs~=nil and next(rpCfg.costs)~=nil
local costList=needCheckCost and{rpCfg.costs}or{}
local changjingname="仙界"
local sceneidx=xianjieModel:getSceneIndex()
if sceneidx and xianjienSceneIndexType:isMoJie(sceneidx)then
changjingname="魔界"
end


local callback=function()
local monsterGroupId=rpCfg.monster_id
local monsterGroupCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroupId)
local monsterList=monsterGroupCfg.monList
local winArgs=
{
enterCallBack=function(selectList,zfId,mapId)
local rpData=xianjieModel:getResPointData(guid)
if not rpData then
UIManager.info("目标已不存在")
fightController:closeSelectStage()
UIFullFightPrepareControl:closeActiveUI()
return
end

if rpData.deadTime then
UIManager.info("目标已死亡")
fightController:closeSelectStage()
UIFullFightPrepareControl:closeActiveUI()
return
end

local nowTime=timeHelper.getServerShortTime()
if rpData.endTime>0 and rpData.endTime-nowTime<wayTime then
UIManager.info("剩余时间不足以前往目标")
else
if not xianjieModel:haveResPointMarch(guid)then

if _taskid then
xianjiexianbangController:send_37_85(_taskid,1)
end
xianjieController:doResPointMarchCreate(rpData,selectList)
UIManager.info('发起行军成功')
fightController:closeSelectStage()
UIFullFightPrepareControl:closeActiveUI()
return
else
UIManager.info("已派遣队伍前往")
end
end
fightController:closeSelectStage()
UIFullFightPrepareControl:closeActiveUI()

local winParams={
guid=guid,
}
xianjieController:openWin('UIXianJie_RPMonsterWin',winParams)
end,
enterTxt=changjingname,
cancelCallBack=function()
fightController:closeSelectStage()

local winParams={
guid=guid,
}
xianjieController:openWin('UIXianJie_RPMonsterWin',winParams)
end,
groupId=monsterGroupId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
isCheckXJOccupyType=true,
statePriorityCheck=false,
showZhenFa=false,
forceAutoSelect=true,


xjWayTime=wayTime,
costList=costList,
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

if rpCfg.fight_faze then
local fzZeData={}
for i,v in ipairs(rpCfg.fight_faze)do
table.insert(fzZeData,v[1])
end
winArgs.faZeData=fzZeData
end
fightController.showPrepareWin(fightPreSelectModel.fightType.xianjieResPointMonster,winArgs)
end
if needCheckCost then
moneySystem:useMoney(rpCfg.costs[1],rpCfg.costs[2],callback,WARNING_TYPE.eWarning)
else
callback()
end
end


function UIXianJie_RPMonsterWin:onMask()
xianjieController:closeWin('UIXianJie_RPMonsterWin')
end


function UIXianJie_RPMonsterWin:onRecordBtn()
local data=xianjieModel:getResPointData(self.guid)
if data then
local cfg=data:getCfg()
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,cfg.monster_id)
local temp=
{
gridX=self.sharex,
gridZ=self.sharez,
Point_Share=xianjie_Point_Share.mowu,
nameStr=monsterCfg.name,
sharename=monsterCfg.name,
ishujian=true,
}
UIManager:showWindow("UIXianJieRecAddWin",temp)
end
end


function UIXianJie_RPMonsterWin:onRuleBtn()
local ruleLangIdList=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'ruleLangIdList')
local ruleType=xjRuleTipsType.eResPointMonster
local langId=ruleLangIdList[ruleType]
local screenPos=self.ruleBtn:getChildUIScreenPos(false)
screenPos.x=screenPos.x-50
local winParams={
parentWin=self,
lang=langId,
num=nil,
screenPos=screenPos,
}
self:showWindow("UIXianJie_monsterRuleWin",winParams)





end


function UIXianJie_RPMonsterWin:onShowRewardBtn()
local data=xianjieModel:getResPointData(self.guid)
local cfg=data:getCfg()
local args={
parentWin=self,
drop={cfg.drop_id},
}
self:showWindow("UIXianJie_MonsterDropWin",args)
end


function UIXianJie_RPMonsterWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXianJie_RPMonsterWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIXianJie_RPMonsterWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then return end
_this:onMask()
end

function UIXianJie_RPMonsterWin.onXianJieResPointDataChange(etype,guid)
if _this.guid==guid then
if etype==xjResPointChangeEventType.eDelete then
_this:onMask()
end
end
end

function UIXianJie_RPMonsterWin.onXianJieResPointMarchChange(etype,guid)
if _this.guid==guid then
_this:refreshMarchInfo()
end
end

function UIXianJie_RPMonsterWin:refreshView()
local data=xianjieModel:getResPointData(self.guid)

local cfg=data:getCfg()
local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,cfg.monster_id)
if data.source and data.source.srctype==xjResPointSourceType.eXianBangTask then
local _taskid=data.source.taskid or 1
local cfg_task=cfg_xianbangtaskconfig_get(_taskid)
self.monsterKuang:setSprite(globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",cfg_task.color))
else
self.monsterKuang:setSprite(globalABLookup.global,FMT.fmt("image_gwtouxiangpjk_{0}",cfg.type))
end
comHelper.setChildModelRawImage_monsterGroup(self.winlua,cfg.monster_id,self.monsterIcon:getID(),0,eHeadCenterType.eHead)
self.monsterName:setText(monsterCfg.name)

for i,v in pairs(self.source)do
v:setActive(data.source.srctype==i)
end

local showLv=xianjieModel:excuteResPointResourceHandle(data.source.srctype,"getHUDInfo")
if showLv then
self.monsterLvBg:setSprite(globalABLookup.global,FMT.fmt('image_gwtouxiangdjk_{0}',cfg.type))
self.monsterLvTx:setText(cfg.stage)
else
self.monsterLvBg:setImageIcon("",false)
self.monsterLvTx:setText("")
end

local gridX_c,gridZ_c=data:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c


local duration=data:getBaseWayTime()
duration=math.ceil(duration)
self.costTimeTxt:setText(timeHelper.format_time_stamp3(duration))




local dropCfg=cfgHelper.get(cfg_awardconfig_get,cfg.drop_id)
local rewardList=dropCfg and dropCfg.showItems or{}
self.rewardPanel:setChildLayoutGroupCreateItems(#rewardList,function(index)
local rewardItem=self.rewardPanel:getChildLayoutGroupGridItem(index-1)
local rewardData=rewardList[index]
local rewardId=rewardData[1]
local rewardNum=rewardData[2]
local showCountBG=rewardNum>1 or rewardData.range~=nil
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or""
local conf={itemid=rewardId,itemcount=countStr,showname=false,showCountBG=showCountBG,range=rewardData.range,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
rewardItem:SetChildActive(1,rewardData.range==nil and rewardNum<0)
end)
self.rewardView:setChildScrollRectEnable(#rewardList>=5)

local haveCost=cfg.costs~=nil and#cfg.costs>0
self.costBg:setActive(haveCost)
if haveCost then
local itemId=cfg.costs[1]
local itemNum=cfg.costs[2]
local haveNum=itemsModel.getCount(itemId)
local numColor=haveNum>=itemNum and"549327"or"c82c2c"
self.costIcon:setImageIcon(iconHelper.getIconName(itemId),false)
self.costNum:setText(FMT.fmt("消耗：<color=#{1}>{0}</color>",mathHelper.formatNumber(itemNum),numColor))
end

if data.source and data.source.srctype==xjResPointSourceType.eXianBangTask then
self.isXianBang=true
end
if self.isXianBang then
self.stateimg:setActive(true)
self.tsuoimg:setActive(false)
end

self:refreshMarchInfo()

self.cdBg:setActive(data.endTime>0)
if data.endTime>0 then
self:updateCDTx()
self:startCDTick()
else
self:stopCDTick()
end
end

function UIXianJie_RPMonsterWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UIXianJie_RPMonsterWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTx()
end)
end
end

function UIXianJie_RPMonsterWin:updateCDTx()
local data=xianjieModel:getResPointData(self.guid)
if data.endTime>0 then
local nowTime=timeHelper.getServerShortTime()
local least=math.max(data.endTime-nowTime,0)
local timeStr=FMT.fmt("{0}<color=#76D81E>后消失</color>",timeHelper.format_time_stamp3(least))
self.cdTx:setText(timeStr)
else
self.cdBg:setActive(false)
self:stopCDTick()
end
end

function UIXianJie_RPMonsterWin:refreshMarchInfo()
local marching=xianjieModel:haveResPointMarch(self.guid)
self.commitBtn:setActive(not marching)
self.stateLayout:setActive(marching)

if marching then
self:startMarchTick()
self:updateMarchTick()
else
self:stopMarchTick()
end
end

function UIXianJie_RPMonsterWin:startMarchTick()
if not self.marchTick then
self.marchTick=self:setTimer(1,0,function()
self:updateMarchTick()
end)
end
end

function UIXianJie_RPMonsterWin:stopMarchTick()
if self.marchTick then
self:stopTimerByID(self.marchTick)
self.marchTick=nil
end
end

function UIXianJie_RPMonsterWin:updateMarchTick()
local march=xianjieModel:getResPointMarch(self.guid)
local teamHandle=march:getTeamHandle()
local state,times,lerp=teamHandle:getTeamState()
if lerp and lerp>0 then
local desc=xjMarchTeamStateType:getDesc(state)
if teamHandle.teamType==xjTeamHandleType.eResPointReract then
desc="撤回中"
end
self.stateTxt:setText(desc)
local time_str=lerp>0 and timeHelper.format_time_stamp3(lerp)or'--'
self.stateTimeTxt:setText(time_str)
else
self.commitBtn:setActive(false)
self.stateLayout:setActive(false)
self:stopMarchTick()
end
end


function UIXianJie_RPMonsterWin:testttprintdata()
local rpData=xianjieModel:getResPointData(_this.guid)
local rpCfg=rpData:getCfg()
local cfgid=rpCfg.id
local rpGuid=rpData.rpGuid
local rpType=rpData.resourcetype

local sceneidx=rpData.sceneidx
local posIdx=rpData.posIdx
local rpId=rpData.rpId

local str=FMT.fmt('唯一guid：{0}。资源点id：{1}。坐标索引：{2}。怪物配置表id：{3}。场景id：{4}',rpGuid,rpId,posIdx,cfgid,sceneidx)

end
