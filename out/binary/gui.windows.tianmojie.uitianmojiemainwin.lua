







def_class("UITianMoJieMainWin",UIWindowBase)









function UITianMoJieMainWin:bindComponents()

self.activityRoot=UIGameobjectClone.new(self,0)
self.discipleRoot=UIObject.get(self,1)
self.finishBtn=UIButton.get(self,2)
self.gotoBtn=UIButton.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.monsterRoot=UIObject.get(self,5)
self.progressFinal=UIObject.get(self,6)
self.progressSp=UIObject.get(self,7)
self.recordBtn=UIButton.get(self,8)
self.recordNew=UIObject.get(self,9)
self.rewardBtn=UIButton.get(self,10)
self.rewardList=UIObject.get(self,11)
self.rewardReddot=UIObject.get(self,12)
self.stageList=UIObject.get(self,13)
self.stageTotal=UIText.get(self,14)
self.startBtn=UIButton.get(self,15)

self.finishBtn:setButtonClick(function()self:onFinishBtn()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.recordBtn:setButtonClick(function()self:onRecordBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.startBtn:setButtonClick(function()self:onStartBtn()end)



end


function UITianMoJieMainWin:unbindComponents()
local _UIObject_release=UIObject.release
self.activityRoot:deleteSelf();self.activityRoot=nil;
_UIObject_release(self.discipleRoot);self.discipleRoot=nil;
_UIObject_release(self.finishBtn);self.finishBtn=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.monsterRoot);self.monsterRoot=nil;
_UIObject_release(self.progressFinal);self.progressFinal=nil;
_UIObject_release(self.progressSp);self.progressSp=nil;
_UIObject_release(self.recordBtn);self.recordBtn=nil;
_UIObject_release(self.recordNew);self.recordNew=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.stageList);self.stageList=nil;
_UIObject_release(self.stageTotal);self.stageTotal=nil;
_UIObject_release(self.startBtn);self.startBtn=nil;
end















local _this=nil
local _stageCmp={
widget=-1,
stageTx=0,
stageActive=1,
}
local _rewardCmp={
widget=-1,
root=0,
stageNum=1,
rewardBtn=2,
getted=3,
reddot=4,
notGetted=5,
canGetted=6,
}
local _discipleCmp={
widget=-1,
model=0,
}
local _monsterCmp={
widget=-1,
model=0,
effect=1,
}
local _stateType={
eNotOpen=1,
eOpen=2,
eCompleted=3,
}
local _stateTransition={
[_stateType.eNotOpen]={
[_stateType.eOpen]=function(window)
window:doStateAnimation_notOpen2Open()
tianMoJieModel:doneAnimData()
end,
[_stateType.eCompleted]=function(window)
window.startBtn:setActive(false)
window.finishBtn:setActive(true)
end,
},
[_stateType.eOpen]={
[_stateType.eOpen]=function(window)
window:doStateAnimation_open2Open()
tianMoJieModel:doneAnimData()
end,
[_stateType.eCompleted]=function(window)
window:doStateAnimation_open2Completed()
end,
},
[_stateType.eCompleted]={

},
}
local _stateRefresh={
[_stateType.eNotOpen]=function(window)
window.startBtn:setActive(true)
window.monsterRoot:setActive(false)
window.discipleRoot:setActive(false)
end,
[_stateType.eOpen]=function(window)
window.startBtn:setActive(false)
window.monsterRoot:setActive(true)
window:refreshMonsterList()
window.discipleRoot:setActive(false)
end,
[_stateType.eCompleted]=function(window)
window.startBtn:setActive(false)
window.monsterRoot:setActive(false)
window.discipleRoot:setActive(true)
window:refreshDiscipleList()
end,
}
local _discipleMax=4



function UITianMoJieMainWin:onLoaded(...)
self:bindComponents()
_this=self
self.actEnters={}
self:addProNotify(34,124,self.on_34_124)
self:addProNotify(34,122,self.on_34_122)
self:addProNotify(34,121,self.on_34_121)
self:addProNotify(34,128,self.on_34_128)
self:addNotify(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)
self:addNotify(notifyConfig.onActivityStateChange,self.onActivityStateChange)
self:addNotify(notifyConfig.onActivityOpen,self.onActivityOpen)
self:initStageList()
end


function UITianMoJieMainWin:__delete()
self.activityRoot:recycleAll()

self:unbindComponents()
_this=nil

self:stopDiscipleAI()
self:killAllTweeners()
end




function UITianMoJieMainWin:onShow(argtable,afterOnloaded)
if argtable.cloud then
loadingControl.closeCloud()
end
self:refreshStageProgress()
self:refreshStageReward()
self:refreshHelpNew()
self:refreshState()
self:refreshRewardReddot()
self:refreshActivity()
end


function UITianMoJieMainWin:onHide()

end




function UITianMoJieMainWin:onGotoBtn()
local enterAnim=tianMoJieModel:getEnterAnim()
if enterAnim then
tianMoJieModel:clearEnterAnim()
UIFullTianMoJieControl:closeWinByCloud()
else
if mainControl:isInScene(eSceneType.eZongmen)and zongmenModel:getMountainId()==mapIdType.zhufeng then
loadingControl.openCloud(function()
jumpManager:jump({id=JUMP_TYPE.eTMJJump})
end,0.5)
else
jumpManager:jump({id=JUMP_TYPE.eTMJJump})
end
end













end


function UITianMoJieMainWin:onHelpBtn()
local d={}
d.title='规则介绍'
d.mode=3
d.name='tianmojie_help_%d'
d.showBlack=true
self:showWindow('UIRuleWin',d)
end


function UITianMoJieMainWin:onRecordBtn()
tianMoJieController:send_34_126()
local args={
perantWin=self,
afterRefresh=function()
self:refreshHelpNew()
end,
}
self:showWindow("UITianMoJieHelpRecordWin",args)
end


function UITianMoJieMainWin:onRewardBtn()
if not self.passport_guid then
self.passportId=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie,"passport")
if not self.passportId then

return
end
self.passport_guid=UITYTongXingZhengModel:findGuidByTXZId(self.passportId)
end
if self.passport_guid then
UITYTongXingZhengController:showTXZWin(self.passport_guid,self.passportId)
else
loggerUtil.logErrFMT("不存在ID为{0}的通行证GUID",self.passportId)
end
end


function UITianMoJieMainWin:onStartBtn()
local score=tianMoJieModel:getScore()
local notopen=score<0
if notopen then
tianMoJieController:send_34_123()
end
end

function UITianMoJieMainWin:onFinishBtn()
storyAIManager:startStoryBehavior('story_37_TianMoJie_2',{},function()
UIFullTianMoJieControl:showMainWinByCloud()
end)
tianMoJieModel:doneAnimData()
end

function UITianMoJieMainWin:refreshHelpNew()
local show=tianMoJieModel:checkNewHelp()
self.recordNew:setActive(show)
end

function UITianMoJieMainWin:onClickStageReward(id)
local flag=tianMoJieModel:getFlag()
local score=tianMoJieModel:getScore()
local cfg=self.stageCfg[id]
if score<cfg.score then

local args={
parentWin=self,
title=FMT.fmt("阶段奖励({0})",mathHelper.numberToChinese(id)),
desc=FMT.fmt("魔劫积分达到{0}可领取以下奖励",cfg.score),
tips="（任意点击空白处关闭）",
rewards=cfg.reward,
}
self:showWindow("UICommonRewardShowWin2",args)
elseif flag<id then

local topStage=id
for i=id+1,self.stageCnt do
if score>=self.stageCfg[i].score then
topStage=i
else
break
end
end
tianMoJieController:send_34_124(topStage)
else

local args={
parentWin=self,
title=FMT.fmt("阶段奖励({0})",mathHelper.numberToChinese(id)),
desc=FMT.fmt("魔劫积分达到{0}可领取以下奖励",cfg.score),
tips="（任意点击空白处关闭）",
rewards=cfg.reward,
flag={image={globalABLookup.global,"image_yilingqu"}}
}
self:showWindow("UICommonRewardShowWin2",args)
end
end

function UITianMoJieMainWin:initStageList()
self.stageCfg=cfg_tianmojiestageconfig()
self.stageCnt=#self.stageCfg
self.stageList:setChildLayoutGroupCreateItems(self.stageCnt)
self.rewardList:setChildLayoutGroupCreateItems(self.stageCnt)
local stageItems=self.stageList:getChildLayoutGroupGridList()
local rewardItems=self.rewardList:getChildLayoutGroupGridList()
for id=1,self.stageCnt do
local cfg=self.stageCfg[id]
local stageItem=stageItems[id-1]
local rewardItem=rewardItems[id-1]
stageItem:SetChildText(_stageCmp.stageTx,id)
rewardItem:SetChildText(_rewardCmp.stageNum,cfg.score)
rewardItem:SetChildButtonClick(_rewardCmp.rewardBtn,function()
self:onClickStageReward(id)
end)
rewardItem:SetChildActive(_rewardCmp.getted,false)
rewardItem:SetChildActive(_rewardCmp.reddot,false)
stageItem:SetChildActive(_stageCmp.stageActive,false)
rewardItem:SetChildActive(_rewardCmp.canGetted,false)
rewardItem:SetChildActive(_rewardCmp.notGetted,false)
end
end

function UITianMoJieMainWin:refreshStageProgress()
local score=tianMoJieModel:getScore()
local max=750
local prev=0
local progress=0
local per=max/self.stageCnt
self.curStage=self.stageCnt+1
for i,v in ipairs(self.stageCfg)do
if score<v.score then
local temp=(score-prev)/(v.score-prev)*per
progress=progress+temp
self.curStage=i
break
else
progress=progress+per
prev=v.score
end
end
progress=math.floor(progress)
self.progressSp:setChildSizeDelta(progress,8)
self.progressFinal:setActive(self.curStage>self.stageCnt)
self.stageTotal:setText(FMT.fmt("魔劫积分: {0}",math.max(score,0)))
end

function UITianMoJieMainWin:refreshStageReward()
local score=tianMoJieModel:getScore()
local flag=tianMoJieModel:getFlag()
local stageItems=self.stageList:getChildLayoutGroupGridList()
local rewardItems=self.rewardList:getChildLayoutGroupGridList()
for i=1,self.stageCnt do
local pCfg=self.stageCfg[i-1]
local stageItem=stageItems[i-1]
local rewardItem=rewardItems[i-1]
local active=score>=(pCfg and pCfg.score or 0)
local enough=score>=self.stageCfg[i].score
local getted=flag>=i
stageItem:SetChildActive(_stageCmp.stageActive,active)
rewardItem:SetChildActive(_rewardCmp.getted,getted)
rewardItem:SetChildActive(_rewardCmp.reddot,enough and not getted)
rewardItem:SetChildActive(_rewardCmp.canGetted,enough and not getted)
rewardItem:SetChildActive(_rewardCmp.notGetted,not enough and not getted)
end
end

function UITianMoJieMainWin:refreshDiscipleList()
local netDatas={}
for i=1,_discipleMax do
local netData=UIDiscipleModel:getPlotDiscipleByIndex(i)
if netData then
table.insert(netDatas,netData)
end
end
self.discipleRoot:setChildLayoutGroupCreateItems(#netDatas,function(index)
local item=self.discipleRoot:getChildLayoutGroupGridItem(index-1)
local netData=netDatas[index]
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(netData.discipleguid)
item:SetChildUIModelShowTarget(_discipleCmp.model,modelParams.body,1,modelParams.componets,eAnimationID.stand,false,false,0)
end)

self:startDiscipleAI()
end

function UITianMoJieMainWin:startDiscipleAI()
if not self.discipleAI then
local args={
target=_discipleCmp.model,
}
self.discipleAI=behaviorManager:addBehaviorTree("bt_ui_tmj_disciple",nil,true,args)
end
end

function UITianMoJieMainWin:discipleRandomSpeak(bt)
local items=self.discipleRoot:getChildLayoutGroupGridList()
local speakLib=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"discipleSpeak")
bt:setSharedVar("widget",items[math.random(1,items.Count)-1])
bt:setSharedVar("speak",speakLib[math.random(1,#speakLib)])
end

function UITianMoJieMainWin:stopDiscipleAI()
if self.discipleAI then
behaviorManager:removeBehaviorTree(self.discipleAI)
self.discipleAI=nil
end
end

function UITianMoJieMainWin:refreshMonsterList()
local config=self.stageCfg[self.curStage]
local mIds={}
for id,num in pairsBySortKey(config.max)do
if#mIds<3 then
table.insert(mIds,id)
else
break
end
end
self.monsterRoot:setChildLayoutGroupCreateItems(#mIds,function(index)
local item=self.monsterRoot:getChildLayoutGroupGridItem(index-1)
local monsterId=mIds[index]
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,monsterId)
local monsterGroup=monsterCfg.monster
local groupCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroup)
local modelParams=groupCfg.model
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams[1],24)
item:SetChildUIModelShowTarget(_monsterCmp.model,modelParams[1],scaleParam[1],modelParams[3],eAnimationID.stand,false,false,0)
item:SetChildUIModelShowTargetOffset(_monsterCmp.model,scaleParam[2],scaleParam[3])
end)
end

function UITianMoJieMainWin:refreshMonsterListByAnimData()
local animData=tianMoJieModel:getAnimData()
local config=self.stageCfg[animData.stage]
local mIds={}
for id,num in pairsBySortKey(config.max)do
if#mIds<3 then
table.insert(mIds,id)
else
break
end
end
local monsterCnt=#mIds

self.monsterRoot:setChildLayoutGroupCreateItems(monsterCnt,function(index)
local item=self.monsterRoot:getChildLayoutGroupGridItem(index-1)
local monsterId=mIds[index]
local monsterCfg=cfgHelper.get1(cfg_tianmojiemonconfig_get,monsterId)
local monsterGroup=monsterCfg.monster
local groupCfg=cfgHelper.get1(cfg_monstergroup_get,monsterGroup)
local modelParams=groupCfg.model
local scaleParam=isometricMapSystem:getModelScales2Pram(modelParams[1],24)
item:SetChildUIModelShowTarget(_monsterCmp.model,modelParams[1],scaleParam[1],modelParams[3],eAnimationID.stand,false,false,0)
item:SetChildUIModelShowTargetOffset(_monsterCmp.model,scaleParam[2],scaleParam[3])
end)
end

function UITianMoJieMainWin:refreshState()
local animData=tianMoJieModel:getAnimData()
local stage=tianMoJieModel:getStage()
local nState=self:getStateByStage(stage)
if not animData.done and animData.stage~=stage then
local oState=self:getStateByStage(animData.stage)

local transition=_stateTransition[oState][nState]
if transition then
transition(self,animData)
return
end
end

local refresh=_stateRefresh[nState]
refresh(self)

tianMoJieModel:doneAnimData()
end

function UITianMoJieMainWin:refreshRewardReddot()
local txzId=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie,"passport")
local txzGuid=UITYTongXingZhengModel:findGuidByTXZId(txzId)
local reddot=UITYTongXingZhengController:checkReddot(txzGuid)
self.rewardReddot:setActive(reddot)
end

function UITianMoJieMainWin:getStateByStage(stage)
if stage<=0 then
return _stateType.eNotOpen
elseif stage>self.stageCnt then
return _stateType.eCompleted
else
return _stateType.eOpen
end
end

function UITianMoJieMainWin:doStateAnimation_notOpen2Open()
self.startBtn:setActive(false)
self.monsterRoot:setActive(true)
self:refreshMonsterList()
local sequence=Lua.SequenceProxy.New()
local items=self.monsterRoot:getChildLayoutGroupGridList()
for index=1,items.Count do
local item=items[index-1]
item:SetChildCanvasGroupAlpha(_monsterCmp.model,0)
item:SetChildScale(_monsterCmp.model,Vector3.zero)
item:SetChildAnchoredPos(_monsterCmp.effect,150,350*2)
item:SetChildShowEffect(_monsterCmp.effect,10203,true)
local tran=item:GetCommonComponent(_monsterCmp.effect,"Transform")
local tweener=_DOTweenProxy.DoLocalPath(tran,{Vector3.zero,Vector3.left,Vector3.up},1,_pathType.CubicBezier)
tweener:SetEase(_Ease.Linear)
if index==1 then
sequence:Append(tweener)
else
sequence:Join(tweener)
end
end
sequence:AppendCallback(function()
for index=1,items.Count do
local item=items[index-1]
item:SetChildShowEffect(_monsterCmp.effect,10203,false)
item:SetChildAnchoredPos(_monsterCmp.effect,0,120)
item:SetChildShowEffect(_monsterCmp.effect,10201,true)
end
end)
sequence:AppendInterval(1)
for index=1,items.Count do
local item=items[index-1]
local tweener=item:SetChildCanvasGroupDOFade(_monsterCmp.model,1,1)
if index==1 then
sequence:Append(tweener)
else
sequence:Join(tweener)
end
tweener=item:SetChildDOScale(_monsterCmp.model,1,0.5)
sequence:Join(tweener)
end
sequence:AppendCallback(function()
self.tweeners=nil
end)
self.tweeners={sequence}
end

function UITianMoJieMainWin:doStateAnimation_open2Open()
self.monsterRoot:setActive(true)
local sequence=Lua.SequenceProxy.New()
self:refreshMonsterListByAnimData()

local config=self.stageCfg[self.curStage]
local mIds={}
for id,num in pairsBySortKey(config.max)do
if#mIds<3 then
table.insert(mIds,id)
else
break
end
end
local newCnt=#mIds

sequence:AppendInterval(1)
local items=self.monsterRoot:getChildLayoutGroupGridList()
for index=1,items.Count do
local item=items[index-1]
item:SetChildScale(_monsterCmp.model,Vector3.one)
item:SetChildCanvasGroupAlpha(_monsterCmp.model,1)
local tweener=item:SetChildCanvasGroupDOFade(_monsterCmp.model,0,1)
if index==1 then
sequence:Append(tweener)
else
sequence:Join(tweener)
end
end
sequence:AppendCallback(function()
self:refreshMonsterList()

for index=1,newCnt do
local item=items[index-1]
item:SetChildScale(_monsterCmp.model,Vector3.zero)
item:SetChildCanvasGroupAlpha(_monsterCmp.model,0)
item:SetChildAnchoredPos(_monsterCmp.effect,150,350*2)
item:SetChildShowEffect(_monsterCmp.effect,10203,true)
end
end)
for index=1,newCnt do
local item=items[index-1]
local tran=item:GetCommonComponent(_monsterCmp.effect,"Transform")
local tweener=_DOTweenProxy.DoLocalPath(tran,{Vector3.zero,Vector3.left,Vector3.up},1,_pathType.CubicBezier)
tweener:SetEase(_Ease.Linear)
if index==1 then
sequence:Append(tweener)
else
sequence:Join(tweener)
end
end
sequence:AppendCallback(function()
for index=1,newCnt do
local item=items[index-1]
item:SetChildShowEffect(_monsterCmp.effect,10201,true)
item:SetChildAnchoredPos(_monsterCmp.effect,0,120)
item:SetChildShowEffect(_monsterCmp.effect,10201,true)
end
end)
sequence:AppendInterval(1)
for index=1,newCnt do
local item=items[index-1]
local tweener=item:SetChildCanvasGroupDOFade(_monsterCmp.model,1,0.5)
if index==1 then
sequence:Append(tweener)
else
sequence:Join(tweener)
end
tweener=item:SetChildDOScale(_monsterCmp.model,1,0.5)
sequence:Join(tweener)
end
sequence:AppendCallback(function()
self.tweeners=nil
end)
self.tweeners={sequence}
end

function UITianMoJieMainWin:doStateAnimation_open2Completed()
self.monsterRoot:setActive(true)
self.gotoBtn:setActive(false)
self:refreshMonsterListByAnimData()
local sequence=Lua.SequenceProxy.New()
sequence:AppendInterval(0.5)
local items=self.monsterRoot:getChildLayoutGroupGridList()
for index=1,items.Count do
local item=items[index-1]
local tweener=item:SetChildCanvasGroupDOFade(_monsterCmp.model,0,0.5)
if index==1 then
sequence:Append(tweener)
else
sequence:Join(tweener)
end
end
sequence:AppendCallback(function()
self.gotoBtn:setActive(true)
self.monsterRoot:setActive(false)
self.finishBtn:setActive(true)
self.finishBtn:setChildCanvasGroupAlpha(0)
end)
local tweener=self.finishBtn:setChildCanvasGroupDOFade(1,0.5)
sequence:Append(tweener)
sequence:AppendCallback(function()
self.tweeners=nil
end)
self.tweeners={sequence}
end

function UITianMoJieMainWin:killAllTweeners()
if self.tweeners then
for i,v in ipairs(self.tweeners)do
if v:IsActive()then
v:Kill()
end
end
end
end

function UITianMoJieMainWin:refreshActivity()
local activitys=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"activity")
if activitys then
for index,actId in ipairs(activitys)do
self:refreshActivityItem(actId,index)
end
end
end

function UITianMoJieMainWin:refreshActivityItem(actId,index)
local actInfo=activitiesModel:getActInfo(actId)
if actInfo and actInfo.enterguid then
local enterInfo=enterManager:getInfo(actInfo.enterguid)
local luaid=self.actEnters[actId]
if luaid then
local luaObjet=self.activityRoot:getLuaObject(luaid)
if luaObjet and luaObjet.onShow and enterInfo then
luaObjet:onShow({info=enterInfo})
end
else
local enterIconType=enterInfo.enterIconType
local enterType=enterInfo.enterType
local cfg=enterConfig.getConfig(enterIconType,enterType)
local args={info=enterInfo}
local parentIdx=self.activityRoot:getID()
luaid=self.activityRoot:createObject("UIEnterTianMoJieAct",parentIdx,index,args)
self.actEnters[actId]=luaid
end
else
local luaid=self.actEnters[actId]
if luaid then
self.activityRoot:deleteItemByLuaid(luaid)
end
end
end

function UITianMoJieMainWin.on_34_124()
_this:refreshStageReward()
end

function UITianMoJieMainWin.on_34_122()
local animData=tianMoJieModel:getAnimData()

if not animData.done then
_this:refreshState()
else
_this:refreshMonsterList()
end
end

function UITianMoJieMainWin.on_34_121()
_this:refreshStageProgress()
_this:refreshStageReward()
end

function UITianMoJieMainWin.on_34_128()
_this:refreshHelpNew()
end

function UITianMoJieMainWin.onTYTXZRewardChange(tzxGuid)
local txzId=cfgHelper.get2(cfg_jctjsubsysconfig_get,JIUCHONGTIANJIE_SUB_SYS_TYPE.eTianMoJie,"passport")
local txzData=UITYTongXingZhengModel:getDataByGuid(tzxGuid)
if txzId==txzData.txzId then
_this:refreshRewardReddot()
end
end

function UITianMoJieMainWin.onActivityStateChange(actId,actState)
local activitys=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"activity")
if activitys then
local index=table.findValue(activitys,actId)
if index then
_this:refreshActivityItem(actId,index)
end
end
end

function UITianMoJieMainWin.onActivityOpen(actId)
local activitys=cfgHelper.get2(cfg_tianmojiebaseconfig_get,1,"activity")
if activitys then
local index=table.findValue(activitys,actId)
if index then
_this:refreshActivityItem(actId,index)
end
end
end
