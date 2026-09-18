







def_class("UIMoJie_MoJunInfoWin",UIWindowBase)









function UIMoJie_MoJunInfoWin:bindComponents()

self.commitBtn=UIButton.get(self,0)
self.commitBtnTxt=UIText.get(self,1)
self.costBg=UIObject.get(self,2)
self.costIcon=UIImage.get(self,3)
self.costNum=UIText.get(self,4)
self.costTimeItem=UIObject.get(self,5)
self.effectBtn=UIButton.get(self,6)
self.hpRecoverBtn=UIButton.get(self,7)
self.hpRecoverBtnBg=UIObject.get(self,8)
self.hpRecoverDesc=UIText.get(self,9)
self.hpRecoverTime=UIText.get(self,10)
self.hpRecoverTimeBg=UIObject.get(self,11)
self.jieshuDesc=UIText.get(self,12)
self.jieshuPanel=UIObject.get(self,13)
self.jieshuTips=UIButton.get(self,14)
self.lockPanel=UIObject.get(self,15)
self.lockTxt=UIText.get(self,16)
self.mask=UIButton.get(self,17)
self.monsterInfo=UIObject.get(self,18)
self.posTxt=UIText.get(self,19)
self.rankBtn=UIButton.get(self,20)
self.recordBtn=UIButton.get(self,21)
self.rewardBtn=UIButton.get(self,22)
self.rewardReddot=UIObject.get(self,23)
self.root=UIObject.get(self,24)
self.ruleBtn=UIButton.get(self,25)
self.stateLayout=UIObject.get(self,26)
self.stateTimeTxt=UIText.get(self,27)
self.stateTxt=UIText.get(self,28)
self.teamItem=UIObject.get(self,29)
self.texingBtn=UIButton.get(self,30)
self.unlockPanel=UIObject.get(self,31)
self.xjbjbtn=UIButton.get(self,32)
self.mjslpanel=UIObject.get(self,33)
self.mjslskill=UIObject.get(self,34)
self.mjbg1=UIObject.get(self,35)
self.mjbg2=UIObject.get(self,36)
self.mjhf1=UIObject.get(self,37)
self.mjhf2=UIObject.get(self,38)
self.zhenfaBtn=UIButton.get(self,39)
self.xintexingBtn=UIButton.get(self,40)

self.commitBtn:setButtonClick(function()self:onCommitBtn()end)

self.effectBtn:setButtonClick(function()self:onEffectBtn()end)

self.hpRecoverBtn:setButtonClick(function()self:onHpRecoverBtn()end)

self.jieshuTips:setButtonClick(function()self:onJieshuTips()end)

self.mask:setButtonClick(function()self:onMask()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.texingBtn:setButtonClick(function()self:onTexingBtn()end)

self.xjbjbtn:setButtonClick(function()self:onXjbjbtn()end)

self.zhenfaBtn:setButtonClick(function()self:onZhenfaBtn()end)

self.xintexingBtn:setButtonClick(function()self:onXintexingBtn()end)



end


function UIMoJie_MoJunInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.commitBtn);self.commitBtn=nil;
_UIObject_release(self.commitBtnTxt);self.commitBtnTxt=nil;
_UIObject_release(self.costBg);self.costBg=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.costTimeItem);self.costTimeItem=nil;
_UIObject_release(self.effectBtn);self.effectBtn=nil;
_UIObject_release(self.hpRecoverBtn);self.hpRecoverBtn=nil;
_UIObject_release(self.hpRecoverBtnBg);self.hpRecoverBtnBg=nil;
_UIObject_release(self.hpRecoverDesc);self.hpRecoverDesc=nil;
_UIObject_release(self.hpRecoverTime);self.hpRecoverTime=nil;
_UIObject_release(self.hpRecoverTimeBg);self.hpRecoverTimeBg=nil;
_UIObject_release(self.jieshuDesc);self.jieshuDesc=nil;
_UIObject_release(self.jieshuPanel);self.jieshuPanel=nil;
_UIObject_release(self.jieshuTips);self.jieshuTips=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.lockTxt);self.lockTxt=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.monsterInfo);self.monsterInfo=nil;
_UIObject_release(self.posTxt);self.posTxt=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.stateLayout);self.stateLayout=nil;
_UIObject_release(self.stateTimeTxt);self.stateTimeTxt=nil;
_UIObject_release(self.stateTxt);self.stateTxt=nil;
_UIObject_release(self.teamItem);self.teamItem=nil;
_UIObject_release(self.texingBtn);self.texingBtn=nil;
_UIObject_release(self.unlockPanel);self.unlockPanel=nil;
_UIObject_release(self.xjbjbtn);self.xjbjbtn=nil;
_UIObject_release(self.mjslpanel);self.mjslpanel=nil;
_UIObject_release(self.mjslskill);self.mjslskill=nil;
_UIObject_release(self.mjbg1);self.mjbg1=nil;
_UIObject_release(self.mjbg2);self.mjbg2=nil;
_UIObject_release(self.mjhf1);self.mjhf1=nil;
_UIObject_release(self.mjhf2);self.mjhf2=nil;
_UIObject_release(self.zhenfaBtn);self.zhenfaBtn=nil;
_UIObject_release(self.xintexingBtn);self.xintexingBtn=nil;
end
















local _this
local ComMonsterIdx={
icon=0,
model=1,
name=2,
lifeProImg=3,
lifeProTxt=4,
type=5,
typeIcon=6,
typeIconName=7,
jieshu=8,
jieshuBtn=9,
lifePro=10,
isKill=11,
icon2=12,
}
local _ab="ui/windows/mojiemojun/mojiemojun_atlas_pak.ab"
local slskillidx=
{
skillbtn=0,
icon=1,
name=2,
djsbg=3,
djs=4
}
local zhinyincheck={
[0]=1,
[1]=1,
[2]=1,
[3]=1,
}



function UIMoJie_MoJunInfoWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
self:addNotify(notifyConfig.onXianJieMoJunKill,self.onXianJieMoJunKill)

local widget=self.teamItem:getWidgetBase()
widget:SetChildButtonClick(1,function()
self:onClickTeamBtn()
end)
end


function UIMoJie_MoJunInfoWin:__delete()
self:unbindComponents()
self:stopSelfTimerMJSL()
local entityData=xianjieModel:getMoJunEntityData(self.seasonType,self.stageIndex)
if entityData then
entityData:selectEntity(false)
end

_this=nil
end


function UIMoJie_MoJunInfoWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIMoJie_MoJunInfoWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIMoJie_MoJunInfoWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then return end
_this:onCloseClick()
end

function UIMoJie_MoJunInfoWin.onXianJieMoJunKill()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIMoJie_MoJunInfoWin:onShowArgRecv(argtable)
local build_id=argtable and argtable.build_id
self:refreshView(build_id)
end

function UIMoJie_MoJunInfoWin:refreshView(build_id)
local entityData=xianjieModel:getMoJunEntityData(self.seasonType,self.stageIndex)
if entityData==nil then
self:closeSelf()
return
end
if build_id then
self.guid=mathHelper.number_to_int64(build_id)
end
self:refreshInfo()
end

function UIMoJie_MoJunInfoWin:refreshRewardReddot()
local rewardReddot=xianjieModel:checkHasMoJunJieShuReward()or xianjieModel:checkHasMoJunHurtReward()
self.rewardReddot:setActive(rewardReddot)
end




function UIMoJie_MoJunInfoWin:onShow(argtable,afterOnloaded)
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
self.build_id=argtable.build_id
self.guid=mathHelper.number_to_int64(self.build_id)


local enterData=xianjieModel:getMoJieEnterData()
if enterData then
local sId=enterData.sId
if sId and zhinyincheck[sId]then
local isFirst=userActorSetting.get('mojun_saiji_first',false)
if not isFirst then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_BRANCH_LUA_FUNC_NAME.firstOpen_MoJun_SaiJi)
userActorSetting.set('mojun_saiji_first',true)
userActorSetting.flush()
end
end
end

if self.mytimer==nil then
_this:updateTime()
self.mytimer=self:setTimer(1,0,function()
_this:updateTime()
end)
end



self.MJZJID=xianjieModel:getMoJunZhangJieID()
if self.MJZJID==MoJunZhangJieID.two then
self.mjbg1:setActive(false)
self.mjbg2:setActive(true)

self.mjhf1:setActive(false)
self.mjhf2:setActive(true)

self.effectBtn:setActive(false)
self.texingBtn:setActive(false)
self.zhenfaBtn:setActive(true)
self.xintexingBtn:setActive(true)

end

local entityData=xianjieModel:getMoJunEntityData(self.seasonType,self.stageIndex)
if entityData==nil then
self:closeSelf()
return
else
self:refreshInfo(entityData)

xianjieController:reqMoJunGetTeam(self.seasonType,self.stageIndex)
end
self:refreshRewardReddot()
if afterOnloaded then
if entityData then
entityData:selectEntity(true)
end

local pos=self.root:getChildLocalPosition()
self.root:setLocalPosX(pos.x+500)
self.root:setChildDOLocalMoveX(pos.x,0.2)
end















self.xjbjbtn:setActive(false)
end

function UIMoJie_MoJunInfoWin:updateTime()
if self.isActiveTimer then
self:refreshStateDesc()
end

if self.hpRecoverEndTime then
local nowTime=timeHelper.getServerShortTime()
local left=self.hpRecoverEndTime-nowTime
if left>=0 then
self.hpRecoverTime:setText(timeHelper.format_time_stamp3(left))
else
self.hpRecoverEndTime=nil
self:refreshNewHpRecoverInfo()
end
end
local entityData=xianjieModel:getMoJunEntityData(self.seasonType,self.stageIndex)
if not entityData then
return
end
end

function UIMoJie_MoJunInfoWin:refreshInfo(entityData)
if entityData==nil then
entityData=xianjieModel:getMoJunEntityData(self.seasonType,self.stageIndex)
end
if entityData==nil then return end
local mojunData=xianjieModel:getMoJunData(self.seasonType,self.stageIndex)
local mojunEntityData=xianjieModel:getMoJunEntityData(self.seasonType,self.stageIndex)
local cfg=entityData:getCfg()
self.sharecfg=cfg

local gridX_c,gridZ_c=entityData:getCenterGridPosFloor()
local pos_str=FMT.fmt('（X:{0},Y:{1}）',gridX_c,gridZ_c)
self.posTxt:setText(pos_str)
self.sharex=gridX_c
self.sharez=gridZ_c
self.mstentitytype=entityData.entitytype


local monsterInfoWidget=self.monsterInfo:getWidgetBase()

monsterInfoWidget:SetChildActive(ComMonsterIdx.icon,true)
monsterInfoWidget:SetChildActive(ComMonsterIdx.icon2,false)
monsterInfoWidget:SetChildActive(ComMonsterIdx.typeIcon,true)
if self.MJZJID==MoJunZhangJieID.two then
monsterInfoWidget:SetChildActive(ComMonsterIdx.icon,false)
monsterInfoWidget:SetChildActive(ComMonsterIdx.icon2,true)
monsterInfoWidget:SetChildActive(ComMonsterIdx.typeIcon,false)
if mojunData.killTime>0 then
monsterInfoWidget:SetChildGray(ComMonsterIdx.icon2,true)
else
monsterInfoWidget:SetChildGray(ComMonsterIdx.icon2,false)
end
end
monsterInfoWidget:SetChildUIModelRemoveTarget(ComMonsterIdx.model)

local isMoJun,isMoJunInit=xianjieModel:isMoJunBuild(self.build_id)
local ab,iconname=xianjieModel:getMoJunTypeIcon(self.build_id)
monsterInfoWidget:SetChildText(ComMonsterIdx.name,mojunEntityData:getName())
monsterInfoWidget:SetChildCSImageSprite(ComMonsterIdx.typeIcon,ab,iconname)
monsterInfoWidget:SetChildText(ComMonsterIdx.typeIconName,isMoJunInit and"初形"or"真身")
local stage=xianjieModel:getMoJunJieShuByid(mojunData.mojunJieShu)
monsterInfoWidget:SetChildText(ComMonsterIdx.jieshu,FMT.fmt("魔君阶数：{0}阶",stage))
monsterInfoWidget:SetChildCSImageSprite(ComMonsterIdx.icon,_ab,mojunData.killTime>0 and"image_mojieui_ctlh1"or"image_mojieui_ctlh2")

monsterInfoWidget:SetChildButtonClick(ComMonsterIdx.jieshuBtn,function()
if not self.jSPosX then
local jsWidth=monsterInfoWidget:GetChildSizeDeltaX(ComMonsterIdx.jieshu)
local initPos=self.jieshuPanel:getChildLocalPosition()
self.jSPosX=initPos.x+jsWidth/2
end
self.jieshuPanel:setLocalPosX(self.jSPosX)
self.jieshuTips:setActive(true)
end)
monsterInfoWidget:SetChildButtonClick(ComMonsterIdx.typeIcon,function()
local winParams={
parentWin=_this,
isRight=true,
}
_this:showWindow("UIMoJie_MoJunTypeTipsWin",winParams)
end)


local monsterSceneIdx=entityData.sceneidx
if xianjienSceneIndexType:isOhterXianYu(monsterSceneIdx)then

self.costTimeItem:setActive(false)
else
self.costTimeItem:setActive(true)
local costTimeWidget=self.costTimeItem:getWidgetBase()
local wayTime=entityData:getBaseWayTime()
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
costTimeWidget:SetChildText(0,time_str)
end


self:refreshTeamInfo()


self:refreshLife(monsterInfoWidget,mojunData)


self:refreshHpRecoverInfo()


local haveCost=cfg.consume~=nil and next(cfg.consume)~=nil
self.costBg:setActive(haveCost)
if haveCost then
local itemId=cfg.consume[1][1]
local itemNum=cfg.consume[1][2]
local haveNum=itemsModel.getCount(itemId)
local numColor=haveNum>=itemNum and"549327"or"c82c2c"
self.costIcon:setImageIcon(iconHelper.getIconName(itemId),false)
self.costNum:setText(FMT.fmt("消耗：<color=#{1}>{0}</color>",mathHelper.formatNumber(itemNum),numColor))

self.winlua:ForceLayoutRect(self.costBg:getID())
end

local unlock=true
local lockStr
local mojunTime=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"mojunTime")
if mojunData.timeType==1 then
unlock=false
local nowTime=timeHelper.getServerShortTime()
if timeHelper.checkInSameDay2(nowTime,mojunData.endTime)then
lockStr=FMT.fmt("今日{0}点开启征讨魔君",mojunTime[1])
else
lockStr=FMT.fmt("明日{0}点开启征讨魔君",mojunTime[1])
end
elseif mojunData.timeType==3 then
unlock=false
lockStr=FMT.fmt("每日{0}点开启征讨",mojunTime[1])
end
self.lockTxt:setText(lockStr)
self.unlockPanel:setActive(unlock)
self.lockPanel:setActive(not unlock)


local jieshuDesc=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"jieshuDesc")
self.jieshuDesc:setText(jieshuDesc)


local marchguid
self.isActiveTimer=nil

local jsCfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
local teamData=xianjieModel:getSelfInitiatedJiJieTeamDataByInfoguid(jsCfg.bodyInit)
local teamData2=xianjieModel:getSelfInitiatedJiJieTeamDataByInfoguid(jsCfg.bodyReal)
local wpData=xianjieModel:getWaiPaiByQBEntityData3(xjWaiPiaBaseType.eMarckTeam,jsCfg.bodyInit)
local wpData2=xianjieModel:getWaiPaiByQBEntityData3(xjWaiPiaBaseType.eMarckTeam,jsCfg.bodyReal)
if wpData then
marchguid=wpData.guid
elseif wpData2 then
marchguid=wpData2.guid
end
if teamData then
local teamHandleId=teamData.teamHandleId
local teamHandle_=xianjieController:getXJTeamHandle(teamHandleId)
local state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjJiJieTeamStateType.eNone then
self.isActiveTimer=true
end
elseif teamData2 then
local teamHandleId=teamData2.teamHandleId
local teamHandle_=xianjieController:getXJTeamHandle(teamHandleId)
local state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjJiJieTeamStateType.eNone then
self.isActiveTimer=true
end
end

self.marchguid=marchguid
self:refreshStateDesc()

self.commitBtnTxt:setText("集结")

self:freshMoJiePnael()
self:freshMoJieSkillPnael()
if not unlock or mojunData.killTime>0 then
self.mjslpanel:setActive(false)
self.mjslskill:setActive(false)
end
end

function UIMoJie_MoJunInfoWin:refreshLife(widget,mojunData)
if widget==nil then
widget=self.monsterInfo:getWidgetBase()
end
if mojunData==nil then
mojunData=xianjieModel:getMoJunData(self.seasonType,self.stageIndex)
end
widget:SetChildActive(ComMonsterIdx.lifePro,mojunData.killTime==0)
widget:SetChildActive(ComMonsterIdx.isKill,mojunData.killTime>0)
if mojunData.killTime==0 then
local hp=mojunData.hp
widget:SetChildIconFillAmount(ComMonsterIdx.lifeProImg,hp/100000000)
local num=math.floor(hp/10000)/100
if hp>0 and hp<=10000 then
num=0.01
end
local rate_str=FMT.fmt('{0}%',num)
widget:SetChildText(ComMonsterIdx.lifeProTxt,rate_str)
end
end

function UIMoJie_MoJunInfoWin:refreshTeamInfo()
local widget=self.teamItem:getWidgetBase()
local teamList=xianjieModel:getMoJunTeamData()
local teamCnt=teamList and#teamList or 0
local haveTeam=teamCnt>0
local str=haveTeam and FMT.fmt("前往中（<color=#fd8950>{0}</color>）",teamCnt)or"无"
widget:SetChildActive(1,haveTeam)
widget:SetChildText(0,str)
end

function UIMoJie_MoJunInfoWin:refreshHpRecoverInfo()
local mojunData=xianjieModel:getMoJunData(self.seasonType,self.stageIndex)
local hpRecoverData=xianjieModel:getHpRecoverData(self.seasonType,self.stageIndex)
local hpRecover=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"hpRecover")
local len=#hpRecover
self.hpRecoverBtn:setActive(len>1)
self.hpRecoverBtnBg:setActive(len>1)
if len>1 then
self.hpRecoverDesc:setText(FMT.fmt("每天攻打结束后若未击败魔君，则魔君生命回复至<color=#fd8950>{0}%</color>",hpRecoverData[3]/100))
else
self.hpRecoverDesc:setText(FMT.fmt("攻打结束后若未击败魔君，则魔君生命回复至<color=#fd8950>{0}%</color>",hpRecoverData[3]/100))
end
local nextHpRecoverData=xianjieModel:getHpRecoverData(self.seasonType,self.stageIndex,true)
if mojunData.killTime==0 and nextHpRecoverData then
self.hpRecoverTime:setActive(true)
self.hpRecoverTimeBg:setActive(true)
local nowTime=timeHelper.getServerShortTime()
local zeorSec=timeHelper.getServerZeroShortStamp(mojunData.yaomoEndTime)
local endTime=zeorSec+nextHpRecoverData[1]*86400
local left=endTime-nowTime
if left>=0 then
self.hpRecoverTime:setText(timeHelper.format_time_stamp3(left))
self.hpRecoverEndTime=endTime
else
self:refreshNewHpRecoverInfo()
end
else
self.hpRecoverTime:setActive(false)
self.hpRecoverTimeBg:setActive(false)
end
end

function UIMoJie_MoJunInfoWin:refreshNewHpRecoverInfo()
xianjieModel:onNewDay_mojun()
local mojunData=xianjieModel:getMoJunData(self.seasonType,self.stageIndex)
local nowTime=timeHelper.getServerShortTime()
local zeorSec=timeHelper.getServerZeroShortStamp(mojunData.yaomoEndTime)
local hpRecoverData=xianjieModel:getHpRecoverData(self.seasonType,self.stageIndex)
local hpRecover=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"hpRecover")
local len=#hpRecover
self.hpRecoverBtn:setActive(len>1)
self.hpRecoverBtnBg:setActive(len>1)
if len>1 then
self.hpRecoverDesc:setText(FMT.fmt("每天攻打结束后若未击败魔君，则魔君生命回复至<color=#fd8950>{0}%</color>",hpRecoverData[3]/100))
else
self.hpRecoverDesc:setText(FMT.fmt("攻打结束后若未击败魔君，则魔君生命回复至<color=#fd8950>{0}%</color>",hpRecoverData[3]/100))
end
local nextHpRecoverData=xianjieModel:getHpRecoverData(self.seasonType,self.stageIndex,true)
if mojunData.killTime==0 and nextHpRecoverData then
local endTime=zeorSec+nextHpRecoverData[1]*86400
local left=endTime-nowTime
if left>0 then
self.hpRecoverTime:setText(timeHelper.format_time_stamp3(left))
self.hpRecoverEndTime=endTime
end
end
end

function UIMoJie_MoJunInfoWin:refreshStateDesc()
local mojunData=xianjieModel:getMoJunData()
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
end
if not self.marchguid then
local cfg=cfgHelper.get1(cfg_seasonmojunjieshuconfig_get,mojunData.mojunJieShu)
local teamData=xianjieModel:getSelfInitiatedJiJieTeamDataByInfoguid(cfg.bodyInit)
local teamData2=xianjieModel:getSelfInitiatedJiJieTeamDataByInfoguid(cfg.bodyReal)
if teamData then
local teamHandleId=teamData.teamHandleId
local teamHandle_=xianjieController:getXJTeamHandle(teamHandleId)
state,timeData,lerp=teamHandle_:getTeamState()
if state~=xjJiJieTeamStateType.eNone then
teamHandle=teamHandle_
desc=xjJiJieTeamStateType:getDesc(state)or''
end
elseif teamData2 then
local teamHandleId=teamData2.teamHandleId
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
self.commitBtn:setActive(showBtn and mojunData.killTime==0)

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

function UIMoJie_MoJunInfoWin:onClickTeamBtn()
local args={
parentWin=self,
infoguid=self.guid
}
self:showWindow("UIMoJie_mojunTeamWin",args)
end


function UIMoJie_MoJunInfoWin:onHide()

end

function UIMoJie_MoJunInfoWin:openJiJieWin()
local entityData=xianjieModel:getMoJunEntityData(self.seasonType,self.stageIndex)
local wayTime=entityData:getBaseWayTime()
local flag,g_list,errorParams=entityData:checkMovePathCondition(true)
local guid=self.guid

local orderType=xjOrderType.eJiJieInitiate
local minSoldierNum=1
local confirmCb=function(timeSecond)

local func=function(selectDzList,selectMoneyList,boatId)
local ordertype=orderType
local data=xianjieModel:getJiJieLocalData()or{}
local isAutoGoFlag=0
local isEndGoFlag=1
local params={timeSecond,isAutoGoFlag,isEndGoFlag}
local pstr=jsonHelper.encode(params)
xianjieController:reqOrder(guid,ordertype,selectDzList,selectMoneyList,pstr,boatId,nil,g_list)
end

local maxSoldierNum=tianShuDianController:getJiJieXiuShiMaxCount(entityData.entitytype)
return UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func,
wayTime=wayTime,
jiJieTime=timeSecond,
orderType=orderType,
minSoldierNum=minSoldierNum,
maxSoldierNum=maxSoldierNum,
confirmBtnStr="发起集结",
})
end
self:showWindow("UIXianJie_JiJie_initiateWin",{confirmCb=confirmCb,orderType=orderType})
end




function UIMoJie_MoJunInfoWin:onCommitBtn()
local entityData=xianjieModel:getMoJunEntityData(self.seasonType,self.stageIndex)
local flag,g_list,errorParams=entityData:checkMovePathCondition(true)
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

if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end

if not xianjieModel:getMyCanTzMoJun()then
local content="宗门堡垒需处于魔宫挑战区域才能发起集结，是否前往挑战区域？"
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='前往',
canceltext='取消',
okcallback=function()
xianjieController:jumpMoJieMoJun(true)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return
end

local mojunData=xianjieModel:getMoJunData()
if mojunData.timeType~=2 then
UIManager.error("当前魔君在休战状态")
return
end


local isCanJiJie,err=xianjieModel:checkCanJiJie()
if not isCanJiJie then
return UIManager.error(err)
end

local doFunc=function()
self:openJiJieWin()
end
if xianjieModel:checkMoJunFightPlot(self.seasonType,self.stageIndex)then
doFunc()
else
local plots=seasonModel:getStageConfigEx(self.seasonType,self.stageIndex,"plots")
if plots[1]then
xianjieModel:setMoJunFightPlot(self.seasonType,self.stageIndex)
worldStoryController:showStoryTree(plots[1],doFunc,nil,nil,{isFullOpen=false})
else
doFunc()
end
end
end



function UIMoJie_MoJunInfoWin:onMask()
xianjieController:closeWin('UIMoJie_MoJunInfoWin')
end



function UIMoJie_MoJunInfoWin:onRecordBtn()
local winParams={
parentWin=self,
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIMoJieMoJunRecordWin",winParams)
end



function UIMoJie_MoJunInfoWin:onRuleBtn()






local args={
ruleGroupID=ruleTipsImageGroup.eZhengTaoMoJun,
}
if self.MJZJID==MoJunZhangJieID.two then
args={ruleGroupID=ruleTipsImageGroup.eZhengTaoMoJun2,}
end
UIManager:showWindow("UIRuleTipsImage2Win",args)
end



function UIMoJie_MoJunInfoWin:onEffectBtn()
local winParams={
parentWin=self,
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIMoJieMoJunAreaEffectInfoWin",winParams)
end



function UIMoJie_MoJunInfoWin:onTexingBtn()
local winParams={
parentWin=self,
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIMoJieMoJunInfoTipsWin",winParams)
end



function UIMoJie_MoJunInfoWin:onXjbjbtn()
local _posx=self.sharex
local _posy=self.sharez
local _sceneidx=xianjieModel:getSceneIndex()
local cbid=xianjieController.getZuoBiaoType(1)

if self.mstentitytype==xjServerEnityType.eMonsterHouse or
self.mstentitytype==xjServerEnityType.eMoJieMoZong_Big then
cbid=xianjieController.getZuoBiaoType(5)

elseif self.mstentitytype==xjServerEnityType.eBossMonster or
self.mstentitytype==xjServerEnityType.eMoJieMoZong_Small then
cbid=xianjieController.getZuoBiaoType(3)
elseif self.mstentitytype==xjServerEnityType.eMonster then
if self.sharecfg then
if self.sharecfg.flag==1 or self.sharecfg.flag==2 then
cbid=xianjieController.getZuoBiaoType(6)
else
cbid=xianjieController.getZuoBiaoType(1)
end
else
cbid=xianjieController.getZuoBiaoType(1)
end
end

xianjieController.openBJwin(_posx,_posy,_sceneidx,cbid)
end



function UIMoJie_MoJunInfoWin:onRankBtn()
local args={
handleType=self.seasonType,
stageIdx=self.stageIndex,
selectIdx=eSeasonRankType.ePlayer,
parentWin=self,
}
self:showWindow("UIMJMBChapterRankListWin",args)
end



function UIMoJie_MoJunInfoWin:onRewardBtn()
local winParams={
parentWin=self,
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIMoJieMoJunRewardWin",winParams)
end



function UIMoJie_MoJunInfoWin:onHpRecoverBtn()
local winParams={
parentWin=self,
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIMoJie_MoJunHpRecoverTipsWin",winParams)
end



function UIMoJie_MoJunInfoWin:onJieshuTips()
self.jieshuTips:setActive(false)
end


function UIMoJie_MoJunInfoWin:freshMoJiePnael()
local monsterData=xianjieModel:getMoJunData(self.seasonType,self.stageIndex)
local isMJtime=xianjieController:CheckMoJieSaiJieActityeTime()
if isMJtime then
self:freshMoJiBuffnum(monsterData)
local widget=self.mjslpanel:getWidgetBase()
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMoJiBuffClick(widget,monsterData)
end)
else
self.mjslpanel:setActive(false)
end
end

function UIMoJie_MoJunInfoWin:freshMoJiBuffnum()
local monsterData=xianjieModel:getMoJunData(self.seasonType,self.stageIndex)
local buffTemp={}
local buffNum=0
if monsterData and monsterData.bufflistlen and monsterData.bufflistlen>0 then
local buffList_lookup=monsterData.buffList or{}
buffTemp,buffNum=xianjieController:handleFaZeDieJia(buffList_lookup)
end

local widget=self.mjslpanel:getWidgetBase()
widget:SetChildText(1,buffNum)
if buffTemp and next(buffTemp)then
self.mjslpanel:setActive(true)
else
self.mjslpanel:setActive(false)
end
end

function UIMoJie_MoJunInfoWin:onMoJiBuffClick(_posWidget,monsterData)

local buffTemp={}
local buffNum=0
if monsterData and monsterData.bufflistlen and monsterData.bufflistlen>0 then
local buffList_lookup=monsterData.buffList or{}
buffTemp,buffNum=xianjieController:handleFaZeDieJia(buffList_lookup)
end
local widget=_this.mjslpanel:getWidgetBase()
widget:SetChildText(1,buffNum)


if buffTemp and next(buffTemp)then
self:showWindow('UIMoJieShiLiBuffTips',{posWidget=_posWidget,posWidgetIndex=0,pos={x=-265,y=65},bufflsit=buffTemp})
else
UIManager.info('暂无获得的魔界势力状态')
end
end

function UIMoJie_MoJunInfoWin:freshMoJieShiLiItem()
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
if isopen then
local forceid=0
if forceid>0 then
self.slItem:setActive(true)
local cfg=cfg_devildomforceconfig_get(forceid)
self.slNameText:setText(cfg.name)
else
self.slItem:setActive(false)
end
end
end



function UIMoJie_MoJunInfoWin:freshMoJieSkillPnael()
local isopen=xianjieController:CheckMoJieShiLiSkillZongMenBtn()
local monsterData=xianjieModel:getMoJunData(self.seasonType,self.stageIndex)
if isopen then
if monsterData==nil then return end
local forceid=xianjieController:getForce()
if forceid>0 and xianjieController:getShiLiDebuffCheck(forceid)then
local Skillidx,Taskidx=xianjieController:getForceCfg()
if Skillidx==nil then
self.mjslskill:setActive(false)
logErr(FMT.fmt('获取势力配置为nil,查看魔界赛季配置表的force字段'))
return
end
self.mjslskill:setActive(true)
self.skillcfg=xianjieController:getForceSkillCfg(forceid,Skillidx)
local skillcfg=self.skillcfg

local widget=self.mjslskill:getWidgetBase()
widget:SetChildText(slskillidx.name,skillcfg.name)
local iconName=iconHelper.getSkillIcon(skillcfg.skillicon)
widget:SetChildCSImageIcon(slskillidx.icon,iconName,false)
widget:SetChildButtonClick(slskillidx.skillbtn,function()
if _this==nil then return end
_this:onUseMoJiSkillbtn(monsterData)
end)
self:CheckUseMoJiSkillTime()
else
self.mjslskill:setActive(false)
end
else
self.mjslskill:setActive(false)
end
end

function UIMoJie_MoJunInfoWin:onUseMoJiSkillbtn()
local sceneidx=xianjieModel:getSceneIndex()
if xianjienSceneIndexType:isMoJie(sceneidx)then
local monsterData=xianjieModel:getMoJunEntityData(self.seasonType,self.stageIndex)
if monsterData==nil then return end
local flag,g_list,errorParams=monsterData:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法对本阵内的魔物使用"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法对阵外的魔物使用"
else

errStr="处于本阵内无法对其他本阵内的魔物使用"
end
UIManager.error(errStr)
end
return
end

local lastsec=xianjieController:getForceLastsec()
local curTime=timeHelper.getServerShortTime()
local skilldata=self.skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local skill_data=skilldata[lvl]
local skill_time=skill_data[2]
local endTime=lastsec+skill_time
if endTime>curTime then
UIManager.info('技能冷却中')
return
end
local build_id=self.build_id
local actorid=int64.new(tostring(build_id))

local _fun=function()
xianjieController:useMoJieShiLiSkill(actorid)
self:closeSelf()
end
local UseSkilldesc=self.skillcfg.UseSkilldesc
local skillname=self.skillcfg.name
local parem1=UseSkilldesc[1]
local parem2=UseSkilldesc[2][lvl]
local strdesc=''
xpcall(function()
strdesc=FMT.fmt(parem1,unpack(parem2))
end,function(err)
logErr(FMT.fmt('魔界势力技能参数报错，配置字段UseSkilldesc,技能名字：{0},技能等级：{1}',skillname,lvl))
end)
local str=FMT.fmt("是否使用<color=#ca631d>【{0}】</color>技能\n\n{1}",skillname,strdesc)
xianjieController:showUseSkillWin(_fun,str)
else
UIManager.info('势力技能只能在魔界使用')
end
end

function UIMoJie_MoJunInfoWin:serverMoJiSkill()
if _this==nil then return end
_this:CheckUseMoJiSkillTime()
end

function UIMoJie_MoJunInfoWin:CheckUseMoJiSkillTime()
local widget=self.mjslskill:getWidgetBase()
local lastsec=xianjieController:getForceLastsec()
local curTime=timeHelper.getServerShortTime()
local skilldata=self.skillcfg.skill
local lvl=xianjieController:getForceSkilllv()
local skill_data=skilldata[lvl]
local skill_time=skill_data[2]
local endTime=lastsec+skill_time
if endTime>curTime then

widget:SetChildActive(slskillidx.djsbg,true)
widget:SetChildGray(slskillidx.icon,true)
self:stopSelfTimerMJSL()
local timeStr=timeHelper.format_time_stamp(endTime-curTime,true)
widget:SetChildText(slskillidx.djs,timeStr)
local func=function()
local serTime=timeHelper.getServerShortTime()
local dtTime=endTime-serTime
local showTime=dtTime>=0 and dtTime or 0
timeStr=timeHelper.format_time_stamp(showTime,true)
widget:SetChildText(slskillidx.djs,timeStr)
if dtTime<=0 then
self:stopSelfTimerMJSL()
widget:SetChildActive(slskillidx.djsbg,false)
widget:SetChildGray(slskillidx.icon,false)
end
end
self.timermjsl=self:setTimer(1,0,func)
else
widget:SetChildActive(slskillidx.djsbg,false)
widget:SetChildGray(slskillidx.icon,false)
end
end
function UIMoJie_MoJunInfoWin:stopSelfTimerMJSL()
if self.timermjsl then
self:stopTimerByID(self.timermjsl)
self.timermjsl=nil
end
end


function UIMoJie_MoJunInfoWin:onZhenfaBtn()
local winParams={
parentWin=self,
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIMoJieMoJunTwoAreaEffectInfoWin",winParams)
end

function UIMoJie_MoJunInfoWin:onXintexingBtn()
local winParams={
parentWin=self,
seasonType=self.seasonType,
stageIndex=self.stageIndex,
build_id=self.build_id,
}
self:showWindow("UIMoJieMoJunTwoInfoTipsWin",winParams)
end
