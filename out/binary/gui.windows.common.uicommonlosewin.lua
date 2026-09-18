







def_class("UICommonLoseWin",UIWindowBase)









function UICommonLoseWin:bindComponents()

self.closeTips=UIButton.get(self,0)
self.conditionList=UIObject.get(self,1)
self.continueButton=UIButton.get(self,2)
self.continueText=UIText.get(self,3)
self.dragonBack=UIObject.get(self,4)
self.fightCountBtn=UIButton.get(self,5)
self.fightRestartBtn=UIButton.get(self,6)
self.finalHpIcon=UIObject.get(self,7)
self.finalHpPanel=UIObject.get(self,8)
self.finalHpProgress=UIProgress.get(self,9)
self.finalHpTips=UIText.get(self,10)
self.quitButton=UIButton.get(self,11)
self.quitText=UIText.get(self,12)
self.root=UIObject.get(self,13)
self.teamTagIcon=UIImage.get(self,14)

self.closeTips:setButtonClick(function()self:onCloseTips()end)

self.continueButton:setButtonClick(function()self:onContinueButton()end)

self.fightCountBtn:setButtonClick(function()self:onFightCountBtn()end)

self.fightRestartBtn:setButtonClick(function()self:onFightRestartBtn()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)



end


function UICommonLoseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeTips);self.closeTips=nil;
_UIObject_release(self.conditionList);self.conditionList=nil;
_UIObject_release(self.continueButton);self.continueButton=nil;
_UIObject_release(self.continueText);self.continueText=nil;
_UIObject_release(self.dragonBack);self.dragonBack=nil;
_UIObject_release(self.fightCountBtn);self.fightCountBtn=nil;
_UIObject_release(self.fightRestartBtn);self.fightRestartBtn=nil;
_UIObject_release(self.finalHpIcon);self.finalHpIcon=nil;
_UIObject_release(self.finalHpPanel);self.finalHpPanel=nil;
_UIObject_release(self.finalHpProgress);self.finalHpProgress=nil;
_UIObject_release(self.finalHpTips);self.finalHpTips=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.quitText);self.quitText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.teamTagIcon);self.teamTagIcon=nil;
end

















local quitDefaultName='退 出'
local continueDefaultName='继续挑战'

local teamabName="ui/windows/huanjing/huanjing_atlas_pak.ab"
local getTeamTagIconName=function(teamId)
local number=Mathf.Clamp(teamId,1,3)
return"icon_duibiao_"..number
end



function UICommonLoseWin:onLoaded(...)
self:bindComponents()
end


function UICommonLoseWin:__delete()
self:stopCloseTimer()
self:unbindComponents()
self:closeExtra()
end




function UICommonLoseWin:onShow(argtable,afterOnloaded)
self:closeExtra()
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
end
self:delayDo(0.4,func)
end

self.extraWin=argtable.extraWin
self.fightData=argtable.fightData



self.extraParams=argtable.extraParams or{}
self.battleId=self.extraParams.battleId
self.resultType=self.extraParams.resultType
self.extraParams.fightData=self.fightData
self.extraParams.parentWin=self
self.battleType=self.extraParams.battleType
self.param=argtable.param
self.logPackage=argtable.logPackage
if self.extraWin~=nil then
self:showWindow(self.extraWin,self.extraParams)
end

if self.battleType==eBattleType.qiecuo then

local headdata=self.extraParams.headdata_param
if headdata then
self.isShareFight=true
if headdata[9]then
self.isShareFight=false
end
end
end

self.callback=argtable.callback


local btnsInfo=argtable.btnsInfo
self.quitCallBack=btnsInfo~=nil and btnsInfo.quitCallBack or nil
self.continuCallBack=btnsInfo~=nil and btnsInfo.continuCallBack or nil
local haveBtns=btnsInfo~=nil and(btnsInfo.quitCallBack~=nil or
btnsInfo.continuCallBack~=nil)

self.quitButton:setActive(self.quitCallBack~=nil)
self.continueButton:setActive(self.continuCallBack~=nil)
self.closeTips:setActive(not haveBtns)
if self.quitCallBack~=nil then
local quitBtnName=btnsInfo.quitBtnName or quitDefaultName
self.quitText:setText(quitBtnName)
end
if self.continuCallBack~=nil then
local continueBtnName=btnsInfo.continueBtnName or continueDefaultName
self.continueText:setText(continueBtnName)
end

if self.battleId then
self.fightCountBtn:setActive(self.fightData~=nil)
self.fightRestartBtn:setActive(self.fightData~=nil)
end

if argtable.isHideFightBtn then
self.fightCountBtn:setActive(false)
self.fightRestartBtn:setActive(false)
end
self.canClose=nil


self.closeTimer=self:delayDo(1.5,function(...)
self.canClose=true
end)


if self.resultType and self.resultType==eShowResultType.qiecuo then
self.finalHpPanel:setActive(false)
DiZiDuelModel:setbattlelog(self.logPackage.logStr)
elseif self.resultType and self.resultType==eShowResultType.zhengzhanshanhailog then
self.finalHpPanel:setActive(false)
elseif self.resultType and self.resultType==eShowResultType.xianjielog then
if self.fightData then

local ifgw=false
if self.fightData[1].right then
if self.fightData[1].right[1]then
if self.fightData[1].right[1].enityType and self.fightData[1].right[1].enityType==fightEntityType.monster then
ifgw=true
end
end
end
if ifgw then
local fightCount=#self.fightData
local finalHpPercent=1
for i,oneFightData in ipairs(self.fightData)do
finalHpPercent=finalHpPercent-1/fightCount+oneFightData.rightFinalHpPercent/fightCount
end
finalHpPercent=math.ceil(finalHpPercent*100)
self.finalHpProgress:setProgressValue(finalHpPercent,100)
local progressStr=FMT.fmt("{0}%",finalHpPercent)
self.finalHpProgress:setChildProgressText(progressStr)

self.finalHpPanel:setChildCanvasGroupAlpha(0)
self.finalHpPanel:setActive(true)
local func=function()
self.finalHpPanel:setChildCanvasGroupDOFade(1,0.5,nil)
end
self:delayDo(1.2,func)
else
self.finalHpPanel:setActive(false)
end
else
self.finalHpPanel:setActive(false)
end
elseif self.resultType and self.resultType==eShowResultType.yunchengtanbao then
self.finalHpPanel:setActive(false)
elseif self.resultType and self.resultType==eShowResultType.huanjing then
if self.param[1]then
local pass_bits=self.param[1].pass_bits or 0
local guanqia_id=self.param[1].guanqia_id
local cfg=cfgHelper.get1(cfg_guanqianewconfig_get,guanqia_id)
local cndlist=UIHuanJingControl:getChallengeConditions(cfg)
if cndlist then
local cndData=cndlist[2]

local len=#cndData
self.conditionList:setChildScrollViewCreateGrids(len,1)
self.grids=self.conditionList:getChildScrollViewItemWidgets()
local count=self.grids.Count
local isConditions=false
for i=1,count do
local item=self.grids[i-1]
local data=cndData[i]
local pass=mathHelper.getBitValue(pass_bits,i-1)
local text=string.replace(data.text,'#efb150','#7D3B17')
item:SetChildText(0,text)
item:SetChildActive(1,not pass)
item:SetChildActive(2,pass)
if pass then
isConditions=true
end
end
if isConditions then

self.conditionList:setChildCanvasGroupAlpha(0)
self.conditionList:setActive(true)
if count<=2 then
self.winlua:SetChildSizeDelta(self.conditionList:getID(),560,count*43)
end
local func=function()
self.conditionList:setChildCanvasGroupDOFade(1,0.5,nil)
end
self:delayDo(1.2,func)
self.finalHpPanel:setActive(false)
return
end
end
end
if self.fightData then

local fightCount=#self.fightData
local finalHpPercent=1
local failedTeam=1
local teamCount=self.logPackage.teamNum


for i,data in ipairs(self.fightData)do
local hpPercent=data.rightFinalHpPercent
if hpPercent>=0 then
finalHpPercent=hpPercent
failedTeam=i
end
end



finalHpPercent=math.ceil(finalHpPercent*100)
self.finalHpProgress:setProgressValue(finalHpPercent,100)
local progressStr=FMT.fmt("{0}%",finalHpPercent)
self.finalHpProgress:setChildProgressText(progressStr)


self:showTeamTagIcon_InHuanJing(failedTeam,teamCount)


self.finalHpPanel:setChildCanvasGroupAlpha(0)
self.finalHpPanel:setActive(true)
local func=function()
self.finalHpPanel:setChildCanvasGroupDOFade(1,0.5,nil)
end
self:delayDo(1.2,func)
else
self.finalHpPanel:setActive(false)
end
elseif self.resultType and self.resultType==eShowResultType.xingyu then
self.finalHpPanel:setActive(false)
else
if self.fightData then

local fightCount=#self.fightData
local finalHpPercent=1
for i,oneFightData in ipairs(self.fightData)do
finalHpPercent=finalHpPercent-1/fightCount+oneFightData.rightFinalHpPercent/fightCount
end
finalHpPercent=math.ceil(finalHpPercent*100)
self.finalHpProgress:setProgressValue(finalHpPercent,100)
local progressStr=FMT.fmt("{0}%",finalHpPercent)
self.finalHpProgress:setChildProgressText(progressStr)

self.finalHpPanel:setChildCanvasGroupAlpha(0)
self.finalHpPanel:setActive(true)
local func=function()
self.finalHpPanel:setChildCanvasGroupDOFade(1,0.5,nil)
end
self:delayDo(1.2,func)
else
self.finalHpPanel:setActive(false)
end

end

local activityData=activitiesModel:getActSubList_subType_open_doing(SUB_ACTIVITY_TYPE.eCloudCityTreasure)
if activityData then
local sub_actInfo=activityData[1]
if sub_actInfo then
if sub_actInfo:isfrightAuto()then
self:delayDo(3,function()
if self==nil or self.isClose then return end
self:onCloseTips()
end)
end
end
end
end

function UICommonLoseWin:closeExtra()
if self.extraWin~=nil then
UIManager:closeWindow(self.extraWin)
self.extraWin=nil
self.extraParams=nil
end
end

function UICommonLoseWin:onCloseTips()
if not self.canClose then return false end
local cb=self.callback
self:closeSelf()

if cb then cb()end
return true
end

function UICommonLoseWin:onQuitButton()
if self==nil or self.isClose then return end
local cb=self.quitCallBack
self:closeSelf()

if cb then cb()end
end

function UICommonLoseWin:onContinueButton()
if self==nil or self.isClose then return end
local cb=self.continuCallBack
self:closeSelf()

if cb then cb()end
end

function UICommonLoseWin:onFightCountBtn()
if self.isWait then
return
end
if not self.fightData then
local log=self.logPackage.logStr
local battleID=fightController:startBallte(log,false,nil,nil,{})
local battle=fightModel:getBattle(battleID)
if battle then
battle:onSkipAll()
self.isWait=true
self:delayDo(2,function()
self.isWait=false
local resList={}
local list=battle:getStatisticsList()
for i,v in ipairs(list)do
local res=v.statistics
local round=v.round
local maxRound=v.maxRound
res.round=round
res.maxRound=maxRound
local leftId=battle:getLeftActorId()
local rightId=battle:getRightActorId()
res.leftId=leftId
res.rightId=rightId
table.insert(resList,res)
end
local fightData=resList
self.fightData=fightData
local battleType=self.battleType
UIManager:showWindow('UIFightCountWin',{fightData=fightData,battleId=battleID,battleType=battleType})
end)
end
else
UIManager:showWindow('UIFightCountWin',{fightData=self.fightData,battleId=self.battleId,battleType=self.battleType,isShareFight=self.isShareFight})
end
end




function UICommonLoseWin:testFightData()
local test={}


local disciples1={
{enityType=fightEntityType.diZi,dis_guid=int64.new('353706103275586'),totalAttack=10000,totalDefend=5000,totalCue=0},
{enityType=fightEntityType.diZi,dis_guid=int64.new('355090243518530'),totalAttack=1000,totalDefend=6000,totalCue=0},
{enityType=fightEntityType.diZi,dis_guid=int64.new('355090237227074'),totalAttack=2200,totalDefend=7000,totalCue=0},
{enityType=fightEntityType.diZi,dis_guid=int64.new('355090242469954'),totalAttack=3000,totalDefend=8000,totalCue=0},
{enityType=fightEntityType.diZi,dis_guid=int64.new('355090245615682'),totalAttack=4000,totalDefend=9000,totalCue=0},
}
for i,v in ipairs(disciples1)do
if v.enityType==fightEntityType.diZi then
v.image=UIDiscipleModel:getDiscipleImageInfo(v.dis_guid)
end
end
test.left=disciples1

local disciples2={
{enityType=fightEntityType.monster,monsterID=1,totalAttack=10000,totalDefend=0,totalCue=100},
{enityType=fightEntityType.monster,monsterID=2,totalAttack=20000,totalDefend=0,totalCue=0},
{enityType=fightEntityType.monster,monsterID=3,totalAttack=30000,totalDefend=0,totalCue=200},
{enityType=fightEntityType.monster,monsterID=4,totalAttack=40000,totalDefend=0,totalCue=0},
{enityType=fightEntityType.monster,monsterID=5,totalAttack=50000,totalDefend=0,totalCue=300},
}
for i,v in ipairs(disciples2)do
if v.enityType==fightEntityType.diZi then
v.image=UIDiscipleModel:getDiscipleImageInfo(v.dis_guid)
end
end
test.right=disciples2

test.round=1
test.maxRound=20
return test
end

function UICommonLoseWin:stopCloseTimer()
if self.closeTimer then
self:stopTimerByID(self.closeTimer)
self.closeTimer=nil
end
end
function UICommonLoseWin:onFightRestartBtn()
if self.isWait then
return
end

if not self.battleId then

self:delayDo(2,function()
self.isWait=false
end)
local battleType=self.battleType
local log=self.logPackage.logStr
local logPackage=self.logPackage
local param=self.param


local battleID=fightController:startBallte(log,true,function(battleID,showWindow,stageCfg)




















local record=fightResultModel:getRecord()
if record then
record.battleId=battleID
record.fightData=fightResultModel:calculateFightData(battleID)
fightResultController:reShowResult()
end
end,nil,{hideExitWatch=true})
self:closeSelf()

else
local nowTime=timeHelper.getServerShortTime()
if self.lastTime then
if nowTime<self.lastTime+5 then
return
end
self.lastTime=nowTime
else
self.lastTime=nowTime
end
if self.battleId then
local battleId=self.battleId
local battle=fightModel:getBattle(battleId)
if battle then
battle.fightIndex=0
battle:restart()
self:closeSelf()

end
end
end
end

function UICommonLoseWin:showTeamTagIcon_InHuanJing(failedTeam,teamCount)
local tagIconName=getTeamTagIconName(failedTeam)
local showTeamTagIcon=not(teamCount==1)
self.teamTagIcon:setActive(showTeamTagIcon)
if showTeamTagIcon then
self.teamTagIcon:setSprite(teamabName,tagIconName)
end
end
