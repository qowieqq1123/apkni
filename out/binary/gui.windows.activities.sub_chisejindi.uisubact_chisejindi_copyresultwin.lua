







def_class("UISubAct_ChiSeJinDi_CopyResultWin",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyResultWin:bindComponents()

self.background=UIButton.get(self,0)
self.dailyScoreMask=UIObject.get(self,1)
self.dailyScoreTips=UIText.get(self,2)
self.dailyScoreTx1=UIText.get(self,3)
self.dailyScoreTx2=UIText.get(self,4)
self.dailyScoreTx3=UIText.get(self,5)
self.levelList=UIObject.get(self,6)
self.levelTips=UIText.get(self,7)
self.levelTx=UIText.get(self,8)
self.shareBtn=UIButton.get(self,9)
self.stageIcon_1=UIImage.get(self,10)
self.stageIcon_2=UIImage.get(self,11)
self.stageScoreMask=UIObject.get(self,12)
self.stageScoreTips=UIText.get(self,13)
self.stageScoreTx1=UIText.get(self,14)
self.stageScoreTx2=UIText.get(self,15)

self.background:setButtonClick(function()self:onBackground()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)
self.stageIcon={
self.stageIcon_1,
self.stageIcon_2,
}



end


function UISubAct_ChiSeJinDi_CopyResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.dailyScoreMask);self.dailyScoreMask=nil;
_UIObject_release(self.dailyScoreTips);self.dailyScoreTips=nil;
_UIObject_release(self.dailyScoreTx1);self.dailyScoreTx1=nil;
_UIObject_release(self.dailyScoreTx2);self.dailyScoreTx2=nil;
_UIObject_release(self.dailyScoreTx3);self.dailyScoreTx3=nil;
_UIObject_release(self.levelList);self.levelList=nil;
_UIObject_release(self.levelTips);self.levelTips=nil;
_UIObject_release(self.levelTx);self.levelTx=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.stageIcon_1);self.stageIcon_1=nil;
_UIObject_release(self.stageIcon_2);self.stageIcon_2=nil;
_UIObject_release(self.stageScoreMask);self.stageScoreMask=nil;
_UIObject_release(self.stageScoreTips);self.stageScoreTips=nil;
_UIObject_release(self.stageScoreTx1);self.stageScoreTx1=nil;
_UIObject_release(self.stageScoreTx2);self.stageScoreTx2=nil;
self.stageIcon=nil;
end















local _this=nil
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"



function UISubAct_ChiSeJinDi_CopyResultWin:onLoaded(...)
self:bindComponents()
_this=self
self.tweeners={}
socketManager:addNotify(249,240,self.on_249_240)
end


function UISubAct_ChiSeJinDi_CopyResultWin:__delete()
self:unbindComponents()
_this=nil
for i,v in ipairs(self.tweeners)do
if v:IsActive()then
v:Kill()
end
end
socketManager:removeNotify(249,240,self.on_249_240)
end




function UISubAct_ChiSeJinDi_CopyResultWin:onShow(argtable,afterOnloaded)

self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.parentWin=argtable.parentWin
self.callback=argtable.callback

self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.resultData=self.info:getResult()
self.info:setResult()

self:refreshView()
self:refreshShareBtn()
end


function UISubAct_ChiSeJinDi_CopyResultWin:onHide()

end




function UISubAct_ChiSeJinDi_CopyResultWin:onBackground()
if not self.finishAnimation then
self:callAnimationFinish()
return
end

if self.callback then
self.callback()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_CopyResultWin:refreshView()
self.levelList:setChildLayoutGroupCreateItems(0)
self.levelTx:setText(FMT.fmt("{0}级",self.resultData.level))
self.winlua:ForceLayoutRect(self.levelTips:getID())

local beforeDailyScore=self.resultData.bDailyScore
local afterDailyScore=self.resultData.aDailyScore
local deltaDailyScore=afterDailyScore-beforeDailyScore
local totalDailyScore=self.config.today
local leastDailyScore=math.max(totalDailyScore-afterDailyScore,0)
local leastStr=leastDailyScore<=0 and"今日获得活跃已达上限"or FMT.fmt("今日还可获得{0}",leastDailyScore)

self.dailyScoreTx1:setText(beforeDailyScore)
self.dailyScoreTx2:setText(FMT.fmt("+{0}",deltaDailyScore))
self.dailyScoreTx3:setText(leastStr)

local txObj=self.winlua:GetChildGameObject(self.dailyScoreTx2:getID())
local text=ComponentHelper.GetComponent(txObj,UI.Text)
local width=text.preferredWidth
self.dailyScoreMask:setChildSizeDelta(width,30)
self.winlua:ForceLayoutRect(self.dailyScoreTips:getID())

local beforeStageScore=self.resultData.bStageScore
local afterStageScore=self.resultData.aStageScore
local deltaStageScore=afterStageScore-beforeStageScore
local beforeStage=self.resultData.bStage
local beforeStageName=self.config.scoreClient[beforeStage][1]
local deltaStageScoreStr=deltaStageScore>=0 and FMT.fmt("+{0}",deltaStageScore)or tostring(deltaStageScore)
local deltaStageScoreColor=deltaStageScore>=0 and"#A8DE4F"or"red"
self.stageScoreTx1:setText(FMT.fmt("{0}阶 {1}",beforeStageName,beforeStageScore))
self.stageScoreTx2:setText(FMT.fmt("<color={1}>{0}</color>",deltaStageScoreStr,deltaStageScoreColor))

txObj=self.winlua:GetChildGameObject(self.stageScoreTx2:getID())
text=ComponentHelper.GetComponent(txObj,UI.Text)
width=text.preferredWidth
self.stageScoreMask:setChildSizeDelta(width,30)
self.winlua:ForceLayoutRect(self.stageScoreTips:getID())

local afterStage=self.resultData.aStage
self.stageIcon[2]:setSprite(_abName,self.config.scoreClient[afterStage][2])
end

function UISubAct_ChiSeJinDi_CopyResultWin:callAnimationLevel()
local levels=self.levelList:getChildLayoutGroupGridList()
local nowCnt=levels.Count
if nowCnt<self.resultData.level then
self.levelList:setChildLayoutGroupAddItem()
local item=self.levelList:getChildLayoutGroupGridItem(nowCnt)
local sequence=Lua.SequenceProxy.New()
local tween1=item:SetChildDOScale(-1,1,0.5)
local tween2=item:SetChildCanvasGroupDOFade(-1,1,0.5)
sequence:Join(tween1)
sequence:Join(tween2)
self.tweeners[nowCnt+1]=sequence
end
end

function UISubAct_ChiSeJinDi_CopyResultWin:callAnimationFinish()
self.finishAnimation=true
self.winlua:SetChildAnimatorParameter(-1,"tTrigger","trigger","")
for i,v in ipairs(self.tweeners)do
if v:IsActive()then
v:Kill(true)
end
end
self.levelList:setChildLayoutGroupCreateItems(self.resultData.level,function(index)
local item=self.levelList:getChildLayoutGroupGridItem(index-1)
item:SetChildScale(-1,Vector3.one)
item:SetChildCanvasGroupAlpha(-1,1)
end)
end

function UISubAct_ChiSeJinDi_CopyResultWin:refreshShareBtn()
local open=houtaiModel:isOpenShareImage()and self.resultData.level==self.config.level[2]
self.shareBtn:setActive(open)
end

function UISubAct_ChiSeJinDi_CopyResultWin:onShareBtn()
local param={
extra="shareChildChiSeJinDi",
param={
actId=self.actId,
subType=self.subType,
subId=self.subId,
team=self.resultData.teamData,
},
share=function(shareType)

end,
close=function()
self:closeWindow("UIShareImageFrameWin")
end
}
self:showWindow("UIShareImageFrameWin",param)
end

function UISubAct_ChiSeJinDi_CopyResultWin.on_249_240(actId,subId)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshView()
end
end