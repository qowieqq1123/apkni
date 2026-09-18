







def_class("UIXM_TYSC_BattleWin",UIWindowBase)









function UIXM_TYSC_BattleWin:bindComponents()

self.bgImg2=UIObject.get(self,0)
self.bigMonsterListPanel=UIObject.get(self,1)
self.bossListPanel=UIObject.get(self,2)
self.bossLock=UIObject.get(self,3)
self.bossNumTxt=UIText.get(self,4)
self.challengeAddBtn=UIButton.get(self,5)
self.challengeNumTxt=UIText.get(self,6)
self.closebg=UIButton.get(self,7)
self.killMonterEffect=UIObject.get(self,8)
self.killMonterNumTxt=UIText.get(self,9)
self.killMonterObj=UIObject.get(self,10)
self.mapEffect=UIObject.get(self,11)
self.mapRoot=UIObject.get(self,12)
self.message2Txt=UIText.get(self,13)
self.messageFrame=UIObject.get(self,14)
self.messageMask=UIObject.get(self,15)
self.messageTxt=UIText.get(self,16)
self.monsterListPanel=UIObject.get(self,17)
self.monsterProgress=UIObject.get(self,18)
self.quickActive=UIObject.get(self,19)
self.quickBtn=UIButton.get(self,20)
self.quicknotActive=UIObject.get(self,21)
self.quicknottext=UIText.get(self,22)
self.rankBtn=UIButton.get(self,23)
self.rankReddot=UIObject.get(self,24)
self.rewardNumObj=UIObject.get(self,25)
self.rewardNumText=UIText.get(self,26)
self.rewardObj=UIButton.get(self,27)
self.rewardProgress=UIObject.get(self,28)
self.rewardProgressText=UIText.get(self,29)
self.root=UIObject.get(self,30)
self.ruleBtn=UIButton.get(self,31)
self.scoreTxt=UIText.get(self,32)
self.timeTxt=UIText.get(self,33)
self.uiRoot=UIObject.get(self,34)

self.challengeAddBtn:setButtonClick(function()self:onChallengeAddBtn()end)

self.closebg:setButtonClick(function()self:onClosebg()end)

self.quickBtn:setButtonClick(function()self:onQuickBtn()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.rewardObj:setButtonClick(function()self:onRewardObj()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)



end


function UIXM_TYSC_BattleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImg2);self.bgImg2=nil;
_UIObject_release(self.bigMonsterListPanel);self.bigMonsterListPanel=nil;
_UIObject_release(self.bossListPanel);self.bossListPanel=nil;
_UIObject_release(self.bossLock);self.bossLock=nil;
_UIObject_release(self.bossNumTxt);self.bossNumTxt=nil;
_UIObject_release(self.challengeAddBtn);self.challengeAddBtn=nil;
_UIObject_release(self.challengeNumTxt);self.challengeNumTxt=nil;
_UIObject_release(self.closebg);self.closebg=nil;
_UIObject_release(self.killMonterEffect);self.killMonterEffect=nil;
_UIObject_release(self.killMonterNumTxt);self.killMonterNumTxt=nil;
_UIObject_release(self.killMonterObj);self.killMonterObj=nil;
_UIObject_release(self.mapEffect);self.mapEffect=nil;
_UIObject_release(self.mapRoot);self.mapRoot=nil;
_UIObject_release(self.message2Txt);self.message2Txt=nil;
_UIObject_release(self.messageFrame);self.messageFrame=nil;
_UIObject_release(self.messageMask);self.messageMask=nil;
_UIObject_release(self.messageTxt);self.messageTxt=nil;
_UIObject_release(self.monsterListPanel);self.monsterListPanel=nil;
_UIObject_release(self.monsterProgress);self.monsterProgress=nil;
_UIObject_release(self.quickActive);self.quickActive=nil;
_UIObject_release(self.quickBtn);self.quickBtn=nil;
_UIObject_release(self.quicknotActive);self.quicknotActive=nil;
_UIObject_release(self.quicknottext);self.quicknottext=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.rankReddot);self.rankReddot=nil;
_UIObject_release(self.rewardNumObj);self.rewardNumObj=nil;
_UIObject_release(self.rewardNumText);self.rewardNumText=nil;
_UIObject_release(self.rewardObj);self.rewardObj=nil;
_UIObject_release(self.rewardProgress);self.rewardProgress=nil;
_UIObject_release(self.rewardProgressText);self.rewardProgressText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.scoreTxt);self.scoreTxt=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this=nil
local delayBattle=1.4
local monsterEmotID=11
local emotTime=3
local delayEmotTime=10
local emotNum=3
local emotDelayTime={0.1,1.5}
local killMonterEffectIDs={10172,10173}


function UIXM_TYSC_BattleWin:onLoaded(...)
_this=self
self:bindComponents()

self.monsterTimerFuncLookup={}
end


function UIXM_TYSC_BattleWin:__delete()
_this=nil
self.mapEffect:setChildShowEffect(10174,false)
if self.killMonterEffectID then
self.killMonterEffect:setChildShowEffect(0,false)
end
self:unbindComponents()

self.monsterTimerFuncLookup=nil
xianmengModel:clearNoteSelect_TYSC()
end


function UIXM_TYSC_BattleWin:onHide()

end

function UIXM_TYSC_BattleWin:checkMonsterTimerFunc(monsterType,posIdx,state_name,isbreak)
local d=self.monsterTimerFuncLookup[monsterType]
if d then
local dd=d[posIdx]
if dd then
local timer_func=dd.state_name
if timer_func then
if isbreak then
self:breakMonsterTimerFunc(timer_func)
end
return true
end
end
end
return false
end

function UIXM_TYSC_BattleWin:breakMonsterTimerFunc(timer_func)
if timer_func==nil then return end
local timer=timer_func[1]
self:stopTimerByID(timer)
local func=timer_func[2]
if func then
func()
end
end

function UIXM_TYSC_BattleWin:setMonsterTimerFunc(monsterType,posIdx,state_name,timer_func)
local d=self.monsterTimerFuncLookup[monsterType]
if d then
local dd=d[posIdx]
if dd==nil then
dd={}
d[posIdx]=dd
end
dd.state_name=timer_func
else
d={}
d[posIdx]={}
d[posIdx].state_name=timer_func
self.monsterTimerFuncLookup[monsterType]=d
end
end

function UIXM_TYSC_BattleWin:clearMonsterTimerFunc()
local lp=self.monsterTimerFuncLookup
for monsterType,d in pairs(lp)do
for posIdx,dd in pairs(d)do
local timer_func=dd.state_name
if timer_func then
local timer=timer_func[1]
self:stopTimerByID(timer)
end
end
end
self.monsterTimerFuncLookup={}
end

function UIXM_TYSC_BattleWin:getMapRootPosX()
local pos=self.mapRoot:getChildLocalPosition()
return pos.x
end

function UIXM_TYSC_BattleWin:setMapRootPosX(mapRootPosX)
self.mapRoot:setLocalPosX(mapRootPosX)
end




function UIXM_TYSC_BattleWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self:initAllMosterWidget()
end
self.actID=LIMIT_ACT_TYPE.eTianYuanShouChao
self.isFull=argtable.isFull
self.Callback=argtable.Callback
self.sc_level=xianmengModel:getLevel_TYSC()

if self.actTimer==nil then
local func=function()
self:updateMessage()
self:refreshActTimer()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end
self:refreshScore()
self:refreshRewardProgress()
self:refreshRewardNum()
self:refreshChallengeNum()
self:refreshMonsterProgress()
self:initAllMonster()
self:refreshRankReddot()


local mapRootPosX=xianmengController:getMarkMonsterPos_TYSC()
if mapRootPosX then
xianmengController:setMarkMonsterPos_TYSC(nil)
self:setMapRootPosX(mapRootPosX)
end
local markMonster=xianmengController:getMarkMonster_TYSC()
if markMonster~=nil then
xianmengController:setMarkMonster_TYSC(nil)
local monsterType=markMonster[1]
local posIdx=markMonster[2]
if monsterType~=nil then
self.playingAnim=true
self:killMonster_anim_ex(0.25,monsterType,posIdx)
end
end

if self.randomEmotTimer==nil then
local func=function()
if _this==nil then return end
_this:monsterRandomEmot()
end
self.randomEmotTimer=self:setTimer(delayEmotTime,0,func)
end
if afterOnloaded then
self:delayDo(0.5,function()
self:initMessage()
end)
end
if self.Callback then
self.Callback()
end

local flag=xianmengModel:GetNeedOpenquickWin()
if flag then
self:onQuickBtn()
xianmengModel:SetNeedOpenquickWin(false)
end
end


function UIXM_TYSC_BattleWin:onRefreshView()
self:clearMonsterTimerFunc()

self.sc_level=xianmengModel:getLevel_TYSC()

self:refreshScore()
self:refreshRewardProgress()
self:refreshRewardNum()
self:refreshChallengeNum()
self:refreshMonsterProgress()
self:initAllMonster()
self:refreshRankReddot()
end




function UIXM_TYSC_BattleWin:killMonster_anim(delay,monsterType,posIdx)
self:killMonster_anim_ex(delay,monsterType,posIdx)
end

function UIXM_TYSC_BattleWin:killMonster_anim_ex(delay,monsterType,posIdx)
local monster=xianmengModel:getMonsterByPosIdx_TYSC(monsterType,posIdx)
if monster==nil then return end
local func=function()
if _this==nil then return end
if _this:checkMonsterTimerFunc(monsterType,posIdx,'die')then return end

_this:checkMonsterTimerFunc(monsterType,posIdx,'talk',true)
local widget=_this:getPosWidgetByIndex(monsterType,posIdx)
widget:SetChildActive(3,false)
widget:SetChildShowEffect(0,0,false)
widget:SetChildActive(2,false)
widget:SetChildModelAnimationState(1,eAnimationID.dead)
widget:SetChildShowEffect(4,30001,true)
_this:delayDo(0.2,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(1,0,0.4,nil)

end)
local timer_func={}
local func2=function()
if _this==nil then return end

widget:SetChildShowEffect(4,0,false)

_this:setMonsterTimerFunc(monsterType,posIdx,'die',nil)
xianmengModel:removeMonsterEx_TYSC(monsterType,posIdx)
_this:hidePosWidgetByPos(monsterType,posIdx)
_this:addMonster(monsterType)
end
timer_func[1]=_this:delayDo(0.8,func2)
timer_func[2]=nil
_this:setMonsterTimerFunc(monsterType,posIdx,'die',timer_func)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
end

function UIXM_TYSC_BattleWin:killBoss_anim(monsterType,posIdx)
if self:checkMonsterTimerFunc(monsterType,posIdx,'die')then return end

self:checkMonsterTimerFunc(monsterType,posIdx,'talk',true)
local widget=self:getPosWidgetByIndex(monsterType,posIdx)
widget:SetChildActive(3,false)
widget:SetChildShowEffect(0,0,false)
widget:SetChildActive(2,false)
widget:SetChildModelAnimationState(1,eAnimationID.dead)
widget:SetChildShowEffect(4,30001,true)
self:delayDo(0.2,function()
widget:SetChildCanvasGroupDOFade(1,0,0.4,nil)

end)
local timer_func={}
local func2=function()
if _this==nil then return end

widget:SetChildShowEffect(4,0,false)
_this:setMonsterTimerFunc(monsterType,posIdx,'die',nil)
_this:hidePosWidgetByPos(monsterType,posIdx)
end
timer_func[1]=self:delayDo(0.8,func2)
timer_func[2]=nil
self:setMonsterTimerFunc(monsterType,posIdx,'die',timer_func)
end

function UIXM_TYSC_BattleWin:monsterRandomEmot()
local list={}
local list2={}
local monsterList
for i,monsterType in ipairs(self.monsterTypeList)do
monsterList=xianmengModel:getMonsterList_TYSC(monsterType)
for k,monster in pairs(monsterList)do
local posIdx=monster.posIdx
local checkTalk=self:checkMonsterTimerFunc(monsterType,posIdx,'talk')
local checkBattle=self:checkMonsterTimerFunc(monsterType,posIdx,'battle')
if not checkTalk and not checkBattle then
table.insert(list,monster)
end
end
end
if#list>0 then
for i=1,emotNum do
local c=#list
if c>0 then
local r=math.random(1,c)
local monster=table.remove(list,r)
table.insert(list2,monster)
else
break
end
end
end
if#list2>0 then
for i,monster in ipairs(list2)do
if i>1 then
local d=math.random(emotDelayTime[1],emotDelayTime[2])
self:delayDo(d,function()
self:monsterShowEmot(monster)
end)
else
self:monsterShowEmot(monster)
end
end
end
end

function UIXM_TYSC_BattleWin:monsterShowEmot(monster)
local monsterType=monster.monsterType
local posIdx=monster.posIdx
local widget=self:getPosWidgetByIndex(monsterType,posIdx)

local str=chatEmotHelper.getSmallEmotMesg(monsterEmotID)
widget:SetChildText(7,chatEmotHelper.decodeEmot(str))
widget:SetChildActive(6,true)
widget:SetChildModelAnimationState(1,eAnimationID.attack1)

local timer_func={}
local func=function()
widget:SetChildActive(6,false)
end
local func2=function()
func()
self:setMonsterTimerFunc(monsterType,posIdx,'talk',nil)
end
timer_func[1]=self:delayDo(emotTime,func2)
timer_func[2]=func
self:setMonsterTimerFunc(monsterType,posIdx,'talk',timer_func)
end

function UIXM_TYSC_BattleWin:refreshActTimer()
local time=limitActivitiesModel:getActEndLeftTime(self.actID)
local time_str=FMT.fmt('活动结束剩余：{0}',timeHelper.format_time_stamp3(time))
self.timeTxt:setText(time_str)

local isdoing=limitActivitiesModel:checkActDoing(self.actID)
if not isdoing then
self:onClickClose()
end
end

function UIXM_TYSC_BattleWin:refreshScore()
local lvname=xianmengModel:getLevelName_TYSC(self.sc_level)
local str=FMT.fmt('仙盟天渊积分：{0}({1})',xianmengModel:getNowScore_TYSC(),lvname)
self.scoreTxt:setText(str)
end

function UIXM_TYSC_BattleWin:refreshRewardProgress(anim)
local speed=3
local cur_score=xianmengModel:getNowScore_TYSC()
local pmpReward=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,self.sc_level,'pmpReward')
local max_score=pmpReward[1]*pmpReward[2]
local isFullScore=cur_score>=max_score

local floor,cur,max=xianmengModel:getSoreFloor_TYSC(self.sc_level,cur_score)
local old_floor=self.floor
self.floor=floor
local old_rate=self.rewardProgress:getChildIconFillAmount()
local cur_rate
if isFullScore then
cur_rate=1
else
cur_rate=cur/max
if cur_rate>1 then
cur_rate=1
end
end

local progress_str
if isFullScore then
progress_str=FMT.fmt('天渊积分：{0}',cur_score)
else
progress_str=FMT.fmt('天渊积分：{0}/{1}',cur,max)
end
self.rewardProgressText:setText(progress_str)

if old_rate==cur_rate and self.floor==old_floor then
return
end
if self.progressTween~=nil then
if not self.progressTween:IsComplete()then
self.progressTween:OnComplete(nil)
self.progressTween:Complete()
end
self.progressTween=nil
end

if old_floor~=nil and self.floor~=old_floor then
if anim then
self.progressTween=self.rewardProgress:setChildImageDOFillAmount(1,(1-old_rate)*speed,function()
if _this==nil then return end
_this.progressTween=nil
_this.rewardProgress:setChildIconFillAmount(0)
_this.progressTween=_this.rewardProgress:setChildImageDOFillAmount(cur_rate,cur_rate*speed,function()
if _this==nil then return end
_this.progressTween=nil
end)
end)
else
self.rewardProgress:setChildIconFillAmount(cur_rate)
end
else
if cur_rate~=old_rate then
if anim then
self.progressTween=self.rewardProgress:setChildImageDOFillAmount(cur_rate,math.abs(cur_rate-old_rate)*speed,function()
if _this==nil then return end
_this.progressTween=nil
end)
else
self.rewardProgress:setChildIconFillAmount(cur_rate)
end
end
end
end

function UIXM_TYSC_BattleWin:refreshRewardNum()
local num=xianmengModel:getSellRewardNum_TYSC()
local showSellReward=num>0
local cur_score=xianmengModel:getNowScore_TYSC()
local pmpReward=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,self.sc_level,'pmpReward')
local max_score=pmpReward[1]*pmpReward[2]
self.rewardNumObj:setActive(showSellReward)
if showSellReward then
local num_str=tostring(num)
self.rewardNumText:setText(num_str)
end
end

function UIXM_TYSC_BattleWin:refreshChallengeNum()
local num=xianmengModel:getChallengeNum1_TYSC()
local num_str=FMT.fmt('剩余挑战次数：\n{0}',num)
self.challengeNumTxt:setText(num_str)


local num=xianmengController:loadTYSC_ChallengNum()
local quick_neednum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'quick_neednum')
local quick_needLV=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'quick_needLV')


self.quickActive:setActive(num>=quick_neednum or zongmenModel:getLevel()>=quick_needLV)

self.quicknotActive:setActive(not(num>=quick_neednum or zongmenModel:getLevel()>=quick_needLV))
if num<quick_neednum then
self.quicknottext:setText(string.format("<color=#fd8950>%d</color>次挑战后解锁",quick_neednum-num))
end

end

function UIXM_TYSC_BattleWin:refreshMonsterProgress()
local shoulingNum=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,self.sc_level,'shoulingNum')
local maxBossNum=shoulingNum[1]
local maxBossShowNum=shoulingNum[2]
local bossNum=xianmengModel:getBossNum_TYSC()
local bossRefreshNum=xianmengModel:getRefreshBossNum_TYSC()
local cur_killNum=xianmengModel:getKillMonsterNum_TYSC()

local bossIdx=bossRefreshNum+1
local maxKillNum=shoulingNum[3][bossIdx]
if maxKillNum==nil then
local n=#shoulingNum[3]
maxKillNum=shoulingNum[3][n]
end
local cur
local rate

local islock=false
local isMax=bossRefreshNum>=maxBossNum
local isShowMax=bossNum>=maxBossShowNum
if isMax or isShowMax then
cur=cur_killNum
if cur>=maxKillNum then
cur=maxKillNum
islock=true
end
else
cur=cur_killNum
end
rate=cur/maxKillNum
if isMax then
islock=true
rate=0
end
self.bossLock:setActive(islock)
local killNum_str=FMT.fmt('{0}/{1}',cur,maxKillNum)
self.killMonterNumTxt:setText(killNum_str)
self.monsterProgress:setChildIconFillAmount(rate)
local bossNum_str=FMT.fmt('{0}/{1}',bossRefreshNum,maxBossNum)
self.bossNumTxt:setText(bossNum_str)
self.killMonterObj:setActive(not isMax)

local killMonterEffectID=0
if not isMax then
if rate>=0.3 and rate<0.7 then
killMonterEffectID=killMonterEffectIDs[1]
elseif rate>=0.7 then
killMonterEffectID=killMonterEffectIDs[2]
end
end
if killMonterEffectID~=self.killMonterEffectID then
if killMonterEffectID~=0 then
self.killMonterEffect:setChildShowEffect(killMonterEffectID,true)
else
self.killMonterEffect:setChildShowEffect(0,false)
end
self.killMonterEffectID=killMonterEffectID
end
end



function UIXM_TYSC_BattleWin:initAllMosterWidget()
self.monsterTypeList={MONSTER_TYPE.eXiaoGuai,MONSTER_TYPE.eJingYing,MONSTER_TYPE.eShouLing}

self.m_cav=self:getChildCanvas(-1)
local posWidgetList
for i,monsterType in ipairs(self.monsterTypeList)do
posWidgetList=self:getPosWidgetList(monsterType)
for i3=1,posWidgetList.Count do
local posIdx=i3-1
local widget=posWidgetList[posIdx]



widget:SetChildLocalPosY(0,80)


widget:SetChildCanvas(1,self.m_cav[1],self.m_cav[2]+2)

widget:SetChildScale(4,Vector3(100,100,100))
widget:SetChildLocalPosY(4,-50)

widget:SetChildCanvas(5,self.m_cav[1],self.m_cav[2]+5)

end
end

self.bgImg2:setChildCanvas(self.m_cav[1],self.m_cav[2]+4)

self.mapEffect:setChildShowEffect(10174,true)

self.uiRoot:setChildCanvas(self.m_cav[1],self.m_cav[2]+7)

end

function UIXM_TYSC_BattleWin:initAllMonster()
local monsterList,posWidgetList
for i,monsterType in ipairs(self.monsterTypeList)do
monsterList=xianmengModel:getMonsterList_TYSC(monsterType)

for k,monster in pairs(monsterList)do
self:refreshMonster(monster)
end
posWidgetList=self:getPosWidgetList(monsterType)
for i3=1,posWidgetList.Count do
local posIdx=i3-1
if not xianmengModel:checkMonsterPos_TYSC(monsterType,posIdx)then
local widget=posWidgetList[posIdx]
widget:SetChildActive(-1,false)
end
end
end
end

function UIXM_TYSC_BattleWin:addMonster(monsterType)
local monster=xianmengModel:addMonster_TYSC(monsterType)
self:refreshMonster(monster)
end

function UIXM_TYSC_BattleWin:refreshMonster(monster)
local monsterType=monster.monsterType
local m_id=monster.m_id
local posIdx=monster.posIdx
if posIdx==nil then
posIdx=self:randomMonsterPos(monsterType)
if posIdx~=nil then
xianmengModel:setMonsterPos_TYSC(monster,posIdx)
end
end
if posIdx==nil then return end


local widget=self:getPosWidgetByIndex(monsterType,posIdx)
widget:SetChildActive(-1,true)

widget:SetChildCanvasGroupAlpha(1,1)
local monsterGroupId=monster.monsterGroupId
local modelParams=comHelper.getMonsterGroupModelParams(monsterGroupId)
local size=monster.scale
widget:SetChildUIModelShowTarget(1,modelParams.body,size,modelParams.componets,eAnimationID.stand)
widget:SetChildUIModelShowFlipX(1,monster.flipX)

widget:SetChildActive(2,true)
widget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onMonsterClick(monsterType,monsterGroupId,m_id)
end)

local showShadow=monsterType==MONSTER_TYPE.eXiaoGuai
widget:SetChildActive(3,showShadow)

local effecid
if not showShadow then
if monsterType==MONSTER_TYPE.eShouLing then
effecid=10176
else
effecid=10175
end
end
if effecid then
widget:SetChildShowEffect(0,effecid,true)
else
widget:SetChildShowEffect(0,0,false)
end

if monsterType==MONSTER_TYPE.eShouLing then

self:refreshBossBlood(widget,monster)
end
end

function UIXM_TYSC_BattleWin:refreshBossBlood(widget,monster)
local guid=monster.guid
local posIdx=monster.posIdx
if posIdx==nil then return end
if widget==nil then
local monsterType=monster.monsterType
widget=self:getPosWidgetByIndex(monsterType,posIdx)
end
widget:SetChildActive(9,true)
local sl=xianmengModel:getBossDataByGuid_TYSC(guid)
local rate=sl.hp/10000
if rate>1 then
rate=1
elseif rate<0 then
rate=0
end
widget:SetChildIconFillAmount(10,rate)
end

function UIXM_TYSC_BattleWin:onMonsterClick(monsterType,monsterGroupId,m_id)
if self.stayBattle then return end

local monster=xianmengModel:getMonsterByIndex_TYSC(monsterType,m_id)
if monsterType==MONSTER_TYPE.eShouLing then
self:showWindow('UIXM_TYSC_bossWin',{guid=monster.guid})
else
self:onMonsterClick_anim(monsterType,monsterGroupId,m_id)
end
end

function UIXM_TYSC_BattleWin:onMonsterClick_anim(monsterType,monsterGroupId,m_id)

local curNum=xianmengModel:getChallengeNum1_TYSC()







if bagControl.checkShowFullEquipBagTips('无法继续挑战')then
return
end

local monster=xianmengModel:getMonsterByIndex_TYSC(monsterType,m_id)
local posIdx=monster.posIdx
local widget=self:getPosWidgetByIndex(monsterType,posIdx)

self:checkMonsterTimerFunc(monsterType,posIdx,'talk',true)

widget:SetChildActive(8,true)
widget:SetChildCanvasGroupAlpha(8,1)
widget:SetChildUIModelShowTarget(8,4737,1,nil,eAnimationID.stand)
widget:SetChildModelAnimationState(1,eAnimationID.attack1)
self.stayBattle=true

local timer_func={}
local func=function()
if _this==nil then return end
_this:delayDo(1.6,function()
return widget:SetChildCanvasGroupDOFade(8,0,0.5,function()
widget:SetChildActive(8,false)
return widget:SetChildUIModelRemoveTarget(8)
end)
end)
end
local func2=function()
func()
self:setMonsterTimerFunc(monsterType,posIdx,'battle',nil)
self:onMonsterClick_battle(monsterType,monsterGroupId,m_id)
self.stayBattle=nil
end
timer_func[1]=self:delayDo(delayBattle,func2)
timer_func[2]=func
self:setMonsterTimerFunc(monsterType,posIdx,'battle',timer_func)
end

function UIXM_TYSC_BattleWin:onMonsterClick_battle(monsterType,monsterGroupId,m_id)
local score
local tyJiFen=cfgHelper.get2(cfg_skyshouchaojibieconfig_get,self.sc_level,'tyJiFen')
if monsterType==MONSTER_TYPE.eXiaoGuai then
score=tyJiFen[1]
else
score=tyJiFen[2]
end


xianmengController:doMonsterFight_TYSC(monsterType,monsterGroupId,m_id,score)
end


function UIXM_TYSC_BattleWin:getPosWidgetList(monsterType)
if monsterType==MONSTER_TYPE.eXiaoGuai then

if self.monsterPosWidgettList==nil then
self.monsterPosWidgettList=self.monsterListPanel:getChildCommonLayoutGroupWidgetList()
end
return self.monsterPosWidgettList
elseif monsterType==MONSTER_TYPE.eJingYing then

if self.bigmonsterPosWidgettList==nil then
self.bigmonsterPosWidgettList=self.bigMonsterListPanel:getChildCommonLayoutGroupWidgetList()
end
return self.bigmonsterPosWidgettList
else

if self.bossPosWidgettList==nil then
self.bossPosWidgettList=self.bossListPanel:getChildCommonLayoutGroupWidgetList()
end
return self.bossPosWidgettList
end
end

function UIXM_TYSC_BattleWin:getPosWidgetByIndex(monsterType,posIdx)
local posWidgetList=self:getPosWidgetList(monsterType)
return posWidgetList[posIdx]
end

function UIXM_TYSC_BattleWin:randomMonsterPos(monsterType)
local unuse={}
local posWidgetList=self:getPosWidgetList(monsterType)
for i=1,posWidgetList.Count do
local posIdx=i-1
if not xianmengModel:checkMonsterPos_TYSC(monsterType,posIdx)then
table.insert(unuse,posIdx)
end
end
if#unuse>0 then
return table.randomIndex(unuse)
end
end


function UIXM_TYSC_BattleWin:hidePosWidgetByPos(monsterType,posIdx)
local widget=_this:getPosWidgetByIndex(monsterType,posIdx)
if widget then
widget:SetChildActive(-1,false)
end
end





function UIXM_TYSC_BattleWin:initMessage()
self.messageSpeed=100
self.messageSpace=10
self.messageObjLookup={}
self.messageObjLookup[1]=self.messageTxt
self.messageObjLookup[2]=self.message2Txt
self.messageObjUsedLookup={}
self.messageList={}
self.messageBoxWidth=self.messageMask:getChildRectWidth()
self.nextRoundTime=5
end

function UIXM_TYSC_BattleWin:updateMessage()
if self.lockMessage then return end
local c=#self.messageList
if c<2 then
local l_time
if c>0 then
for i,meassge in ipairs(self.messageList)do
if l_time==nil or meassge.endTime>l_time then
l_time=meassge.endTime
self.m_endTime=l_time
end
end
end
if l_time==nil or Time.realtimeSinceStartup>l_time then
if self.showNextRound then
l_time=self.m_endTime or 0
if Time.realtimeSinceStartup>=l_time+self.nextRoundTime then
self.showNextRound=nil
self:addMessage()
end
else
self:addMessage()
end
end
end
end

function UIXM_TYSC_BattleWin:addMessage()
local obj_idx=nil
for idx,obj in pairs(self.messageObjLookup)do
if self.messageObjUsedLookup[idx]==nil then
obj_idx=idx
break
end
end
if obj_idx then
local message_str,nextRound=xianmengModel:getOneNoteStr_TYSC()
if nextRound then
self.showNextRound=true
end
if message_str then
self.messageFrame:setActive(true)

local message={}
message.obj_idx=obj_idx
local obj=self.messageObjLookup[obj_idx]
self.messageObjUsedLookup[obj_idx]=true
obj:setChildCanvasGroupAlpha(0)
obj:setText(message_str)
self.lockMessage=true
self:delayDo(0.2,function()
local w=obj:getChildSizeDeltaX()
local time=(w+self.messageBoxWidth)/self.messageSpeed
local time2
if nextRound then
time2=time
else
time2=w/self.messageSpeed+self.messageSpace
end
message.endTime=Time.realtimeSinceStartup+time2
local h_w=self.messageBoxWidth/2
obj:setChildAnchoredPos(h_w,2)
local tweener=obj:setChildDOAnchorPosX(-h_w-w,time,function()
if _this==nil then return end
_this:removeMessage(obj_idx)
if nextRound then
_this.messageFrame:setActive(false)
end
end)
tweener:SetEase(_Ease.Linear)
obj:setChildCanvasGroupAlpha(1)
table.insert(self.messageList,message)
self.lockMessage=nil
end)
end
end
end

function UIXM_TYSC_BattleWin:removeMessage(idx)
local f
for i,message_ in ipairs(self.messageList)do
if message_.obj_idx==idx then
f=i
break
end
end
if f then
local message=table.remove(self.messageList,f)
local obj_idx=message.obj_idx
local obj=self.messageObjLookup[obj_idx]
obj:setChildCanvasGroupAlpha(0)
self.messageObjUsedLookup[obj_idx]=nil
end
end



function UIXM_TYSC_BattleWin:onClickClose()
if self.stayBattle then return end
if self.isFull then
UIFullCommonControl:closeUI()
else
self:closeSelf()
end
end

function UIXM_TYSC_BattleWin:onClosebg()
self:onClickClose()
end

function UIXM_TYSC_BattleWin:onChallengeAddBtn()
if self.stayBattle then return end
self:onChallengeAdd(true)
end

function UIXM_TYSC_BattleWin:onChallengeAdd(isWarning)
local shouchaoNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'shouchaoNum')
local maxBuyNum=shouchaoNum[2]
local curBuyNum=xianmengModel:getChallengeBuyNum1_TYSC()
local lerpBuyNum=maxBuyNum-curBuyNum
if lerpBuyNum<=0 then
if isWarning then
UIManager.error('购买次数已用完')
end
return false
end

local costItemID=shouchaoNum[3]
local costNumList=shouchaoNum[4]
local getCostNum=function(num)
local costItemNum=0
for curBuyLevel=curBuyNum+1,curBuyNum+num do
local n=costNumList[curBuyLevel]
if n==nil then
n=costNumList[#costNumList]
end
costItemNum=costItemNum+n
end
return costItemNum
end
local refresh=function(num)
local itemNum=getCostNum(num)
local have=itemsModel.getCount(costItemID)
local colorStr=have>=itemNum and"549327FF"or"FF0000FF"
local iconStr=iconHelper.getIconName(costItemID)
local costStr=FMT.fmt("quad-icon={2}-quad <color=#{0}>{1}</color>",colorStr,itemNum,iconStr)
local contentStr=FMT.fmt('是否花费{0}购买兽潮挑战次数？',costStr)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=lerpBuyNum,
tips=FMT.fmt("（剩余购买次数：{0}）",lerpBuyNum),
oktext='购买',
canceltext='取消',
okcallback=function(num)
if _this==nil then return end
local itemNum=getCostNum(num)
local func=function()
xianmengController:send_248_14(num)
end
moneySystem:useMoney(costItemID,itemNum,func,WARNING_TYPE.eWarning)
end,
moneytypes={{costItemID},},
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return true
end

function UIXM_TYSC_BattleWin:onRewardObj()
if self.stayBattle then return end
xianmengController:openSellRewardWin_TYSC()
end

function UIXM_TYSC_BattleWin:onRankBtn()
if self.stayBattle then return end
xianmengController:openRankWin_TYSC()
end

function UIXM_TYSC_BattleWin:refreshRankReddot()
local isreddot=xianmengModel:checkRankReddot_TYSC()
self.rankReddot:setActive(isreddot)

















end

function UIXM_TYSC_BattleWin:onRuleBtn()
local d={}
d.title='活动规则'
d.mode=3
d.name='limit_act_tysc_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end



function UIXM_TYSC_BattleWin:recv_buy()
self:refreshChallengeNum()
end

function UIXM_TYSC_BattleWin:recv_score_change()
self:refreshScore()
self:refreshRewardProgress(true)
self:refreshRewardNum()
self:refreshMonsterProgress()
self:refreshRankReddot()
end

function UIXM_TYSC_BattleWin:recv_boss_change()
self:refreshMonsterProgress()
end

function UIXM_TYSC_BattleWin:recv_reward()
self:refreshRankReddot()
end

function UIXM_TYSC_BattleWin:onQuickBtn()
local num=xianmengController:loadTYSC_ChallengNum()
local quick_neednum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'quick_neednum')
local quick_needLV=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,'quick_needLV')

if num>=quick_neednum or zongmenModel:getLevel()>=quick_needLV then
xianmengModel:GeTMonsterData()
else
UIManager.info(string.format("%d次挑战后解锁",quick_neednum-num))
end
end

