







def_class("UIStoryBoardWin",UIWindowBase)









function UIStoryBoardWin:bindComponents()

self.modelObj=UIObject.get(self,0)
self.nameObj=UIObject.get(self,1)
self.talkdesc=UIText.get(self,2)
self.rewardObj=UIObject.get(self,3)
self.chooseGrid=UIObject.get(self,4)
self.arrowShadow=UIObject.get(self,5)
self.biaoqingObj=UIObject.get(self,6)
self.testObj=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.modelImage=UIObject.get(self,9)



end


function UIStoryBoardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.nameObj);self.nameObj=nil;
_UIObject_release(self.talkdesc);self.talkdesc=nil;
_UIObject_release(self.rewardObj);self.rewardObj=nil;
_UIObject_release(self.chooseGrid);self.chooseGrid=nil;
_UIObject_release(self.arrowShadow);self.arrowShadow=nil;
_UIObject_release(self.biaoqingObj);self.biaoqingObj=nil;
_UIObject_release(self.testObj);self.testObj=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
end
















local lookingTime=60
local _this=nil


function UIStoryBoardWin:onLoaded(...)
self:bindComponents()
_this=self
self.oldBgmId=AudioManager.getCurrentBgm()
self.nowBgmId=AudioManager.getCurrentBgm()
notifySystem:listenNotify(notifyConfig.onTestModelChange,self.onTestModelChange)


self:showTestRoot()
end


function UIStoryBoardWin:__delete()
self:unbindComponents()
_this=nil

if self.audioHandle then
AudioManager.stopAudioById(self.audioHandle)
self.audioHandle=nil
end

notifySystem:removelistener(notifyConfig.onTestModelChange,self.onTestModelChange)
end


function UIStoryBoardWin:onHide()

end

function UIStoryBoardWin.onTestModelChange(flag)
if _this==nil then return end

_this:showTestRoot()
end

function UIStoryBoardWin:showTestRoot()
local show=false



show=show and playerController.testModel
self.testObj:setActive(show)
end




function UIStoryBoardWin:onShow(argtable,afterOnloaded)
self.overPlot=false
self.isFullOpen=argtable.isFullOpen
self.dis_guid=argtable.dis_guid
self.taskdata=argtable.taskdata
self.taskid=self.taskdata.taskid
self.taskcfg=self.taskdata.cfg

local taskstateResult=taskModel:getTaskState(self.taskdata)
local taskstate=taskstateResult.state

self.tasksSelectPoint=nil
self.dialoguelist=nil
if taskstate==taskModel.taskAcceptState then
self.dialoguelist=self.taskcfg.acceptTalk
if taskModel:isMultiAcceptTask(self.taskid)then
self.tasksSelectPoint=self.taskcfg.tasksSelectPoint
end
elseif taskstate==taskModel.taskRewardState then
self.dialoguelist=self.taskcfg.finishTalk
if taskModel:isMultiCommitTask(self.taskid)then
self.tasksSelectPoint=self.taskcfg.tasksSelectPoint
end
end
if self.dialoguelist==nil then



self:closeFullWin()
return
end

self.rewardIndex=nil
self.dialogueNum=#self.dialoguelist
self.dialogueIndex=0

self:doNext()
end

function UIStoryBoardWin:checkHasSelect()
local idx=self.tasksSelectPoint
return idx~=nil and idx==self.dialogueIndex
end

function UIStoryBoardWin:checkFinalDialogue()
return self.dialogueIndex>=self.dialogueNum
end

function UIStoryBoardWin:doNext()
self.dialogueIndex=self.dialogueIndex+1
if self.dialogueIndex<=self.dialogueNum then
local dia_idx=self.dialoguelist[self.dialogueIndex]
self.dialoguecfg=cfgHelper.get1(cfg_storydialogueconfig_get,dia_idx)
local oldSide=self.modelSide
local oldnpcID=self.npcID
self.modelSide=self.dialoguecfg.side
self.npcID=self.dialoguecfg.npcID
if self:checkHasSelect()or self:checkFinalDialogue()then

self.modelSide=0
end
local changenpc=self.npcID~=oldnpcID
local changeSide=self.modelSide~=oldSide or(oldnpcID==-1 and changenpc)

self:initSelect()
self:showModel(changeSide)
self:showEmot()
self:showName()
self:showTalk()
self:showReward()
self:playDialogueBGM()
else
self:finishStory()
end
end


function UIStoryBoardWin:playDialogueBGM()
local dialogBGM=self.dialoguecfg.dialogBGM
if dialogBGM and dialogBGM~=self.nowBgmId then
local fadeTime=0.5
self.nowBgmId=dialogBGM
AudioManager.playBgMusic(dialogBGM,fadeTime)
end
end


function UIStoryBoardWin:restoreBGM()
if self.oldBgmId~=AudioManager.getCurrentBgm()then
if self.oldBgmId then
AudioManager.playBgMusic(self.oldBgmId)
else

local fadeTime=0.5
AudioManager.fadeoutBGMusic(fadeTime)
end
end
end

function UIStoryBoardWin:showModel(changeSide,changenpc)
local bodyid=nil
local components={}
local npcID=self.npcID
local offset=nil
local isZSModel=false
local modelType=1
if npcID==0 then

if self.dis_guid==nil then
local random_dis=UIDiscipleModel:getRandomDiscipleData()
self.dis_guid=random_dis.discipleguid
end

if self.dis_guid~=nil then
local image=UIDiscipleModel:getDiscipleInsideModelInfo(self.dis_guid)
if image then
bodyid=image.body
components=image.componets
end
end
elseif npcID>=0 then
local image=npcModel:getImageInfo(npcID)
if image then
bodyid=image.body
components=image.componets
end
local npccfg=cfgHelper.get1(cfg_npcimageconfig_get,npcID)
offset=npccfg.plotOffset
if self.testOffset~=nil then
offset=self.testOffset
end
modelType=npccfg.modelType
elseif npcID==-3 then
if self.dis_guid==nil then
local random_dis=MysteryModel:get_random_dizi_data()
self.dis_guid=random_dis.discipleguid
end

if self.dis_guid~=nil then
local image=UIDiscipleModel:getDiscipleInsideModelInfo(self.dis_guid)
if image then
bodyid=image.body
components=image.componets
end
end
elseif npcID==-13 then

isZSModel=true

end
local isshow=bodyid~=nil or isZSModel
self.modelObj:setActive(isshow)
if isshow then
local fadeTime=0
if changeSide or changenpc then
fadeTime=0.3
if self.modelMove~=nil then
self.modelMove:Kill()
self.modelMove=nil
end
local func=function()
if _this==nil then return end
self.modelMove=nil
end
if self.modelSide==0 then

self.modelObj:setLocalPosX(-398)
self.modelMove=self.modelObj:setChildDOLocalMoveX(-378,0.4,func)
else

self.modelObj:setLocalPosX(398)
self.modelMove=self.modelObj:setChildDOLocalMoveX(378,0.4,func)
end
if modelType==1 then

if self.scaleYTween==nil then
self.scaleYTween=self.modelObj:setChildDOScaleY(1.01,1.5,nil)
self.scaleYTween:SetEase(_Ease.Linear)
self.scaleYTween:SetLoops(-1,_LoopType.Yoyo)
end
else

if self.scaleYTween~=nil then
self.scaleYTween:Kill()
self.scaleYTween=nil
self.modelObj:setScale(Vector3.one)
end
end



end


local actionid=self.dialoguecfg.actionid
local flipX=self.dialoguecfg.flipX
flipX=flipX==nil and false or flipX

local softmask={572,572}
local scale=1
local offx=0
local offy=0
if offset~=nil then
if offset[1]~=nil then
scale=offset[1]
end
if offset[2]~=nil then
offx=offset[2]
end
if offset[3]~=nil then
offy=offset[3]
end
if offset[4]~=nil then
softmask=offset[4]
end
end
if isZSModel then
local playertable=playerImageModel:getPlayerImage()
local playertb=table.weakCopy(playertable)
if playertb and playertb[10]then
playertb[10]=0
end
playerImageController.setPlayerModel(self.winlua,self.modelImage:getID(),playertb,1,eAnimationID.idle,0,0,playerController:supportDynamic())
else
self.modelImage:setChildUIModelShowTarget(bodyid,scale,components,actionid,false,false,fadeTime)
end

self.modelImage:setChildUIModelShowFlipX(flipX)
self.modelImage:setChildUIModelShowTargetOffset(offx,offy)
self.modelObj:setChildSizeDelta(softmask[1],softmask[2])
else
self.modelImage:setChildUIModelRemoveTarget()
end
end

function UIStoryBoardWin:showEmot()
local emot=self.dialoguecfg.emot
local hasEmot=emot~=nil
self.biaoqingObj:setActive(hasEmot)
if hasEmot then
local bqWidget=self.biaoqingObj:getChildWidgetBase()
if self.modelSide==0 then

self.biaoqingObj:setLocalPosX(-320)
bqWidget:SetChildScale(0,Vector3.New(1,1,1))
bqWidget:SetChildAnchoredPos(1,4,0)
else

self.biaoqingObj:setLocalPosX(210)
bqWidget:SetChildScale(0,Vector3.New(-1,1,1))
bqWidget:SetChildAnchoredPos(1,0,0)
end
bqWidget:SetChildText(1,chatEmotHelper.decodeEmot(emot))

self.biaoqingObj:setChildCanvasGroupAlpha(0)
self.biaoqingObj:setScale(Vector3.New(0,0,0))

local func=function()
self.biaoqingObj:setChildCanvasGroupDOFade(1,0.1,nil)
local t1=self.biaoqingObj:setChildDOScale(1,0.8,nil)
t1:SetEase(_Ease.OutElastic)
end
self:delayDo(0.3,func)
end
end

function UIStoryBoardWin:getName()
local npcID=self.npcID
local name=nil
if npcID==0 then
if self.dis_guid~=nil then
name=UIDiscipleModel:getDiscipleName(self.dis_guid)
end
elseif npcID==-2 then
name=playerModel:getActorName()
elseif npcID==-3 then
if self.dis_guid~=nil then
name=UIDiscipleModel:getDiscipleName(self.dis_guid)
end
elseif npcID==-13 then
name=playerModel:getActorName()
elseif npcID>=0 then
name=npcModel:getName(npcID)
end
return name
end

function UIStoryBoardWin:showName()
local name=self:getName()
local isshow=name~=nil
self.nameObj:setActive(isshow)
if isshow then
local nameObjWidget=self.nameObj:getChildWidgetBase()

if self.modelSide==0 then

self.nameObj:setLocalPosX(-436)
nameObjWidget:SetChildScale(0,Vector3.New(1,1,1))
else

self.nameObj:setLocalPosX(436)
nameObjWidget:SetChildScale(0,Vector3.New(-1,1,1))
end

nameObjWidget:SetChildText(1,name)
end
end

function UIStoryBoardWin:showTalk()
local isshow=not self:checkFinalDialogue()
self.talkdesc:setActive(isshow)
self.arrowShadow:setActive(isshow)
if isshow then
self.talkdesc:setChildCanvasGroupAlpha(0)


local slowShow=true
if self:checkHasSelect()then
slowShow=false
end
local name=self:getName()or''
local desc=self.dialoguecfg.dialogue
desc=gameplotModel:replaceName(desc,name)
local speed=slowShow and 40 or 80





self.talking=true

self.talkdesc:setText(desc)

local placeType=pfwindowslController:getPFMoneyType()
if placeType~=pfwindowslController.priceTypeStr.CNY then
if not verifyManager:isHideYuyin()then

if self.audioHandle then
AudioManager.stopAudioById(self.audioHandle)
self.audioHandle=nil
end


self.voiceId=self.dialoguecfg.voiceId
if self.voiceId then
self.audioHandle=AudioManager.playAudio(self.voiceId)
end
end
end

self:talkFinish()

if self.dialoguecfg.broadcast~=nil then
gameplotController.doDialogueBroadcast(name,self.dialoguecfg.broadcast)
end

self.talkdesc:setChildCanvasGroupDOFade(1,0.3,nil)
end
end

function UIStoryBoardWin:talkFinish()
self.talking=false
local hasSelect=self:checkHasSelect()
self:clearLookingTimer()
if hasSelect then
self:showSelect()
end
if not self:checkFinalDialogue()and not self:checkHasSelect()then
self:setLookingTimer()
end
end

function UIStoryBoardWin:setLookingTimer()
local func=function()
self:doNext()
end
self.lookingTimer=self:setTimer(lookingTime,1,func)
end

function UIStoryBoardWin:clearLookingTimer()
if self.lookingTimer~=nil then
self:stopTimerByID(self.lookingTimer)
self.lookingTimer=nil
end
end

function UIStoryBoardWin:showReward()
local isshow=self:checkFinalDialogue()
self.rewardObj:setActive(isshow)
self.arrowShadow:setActive(not isshow)
if isshow then
self.rewardObj:setChildCanvasGroupAlpha(0)
local rewardwiget=self.rewardObj:getChildWidgetBase()


local name=self:getName()or''
local desc=self.dialoguecfg.dialogue
desc=gameplotModel:replaceName(desc,name)
rewardwiget:SetChildText(0,desc)


local placeType=pfwindowslController:getVoiceVoiceVersion()
if placeType~=pfwindowslController.VoiceType.guoyu then
if not verifyManager:isHideYuyin()then

if self.audioHandle then
AudioManager.stopAudioById(self.audioHandle)
self.audioHandle=nil
end


self.voiceId=self.dialoguecfg.voiceId
if self.voiceId then
self.audioHandle=AudioManager.playAudio(self.voiceId)
end
end
end


local rewardlist=taskModel:getTaskRewardList(self.taskid,self.rewardIndex)
local hasreward=#rewardlist>0
rewardwiget:SetChildActive(3,hasreward)
if hasreward then
local grid=rewardwiget:GetChildCommonLayoutGroupWidgetList(1)
for i=1,3 do
local data=rewardlist[i]
local item=grid[i-1]
local show=data~=nil
item:SetChildActive(1,show)
if show then
local itemID=data[1]
local num=data[2]
local str=''
if num>0 then
str=tostring(num)
end
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=str~='',showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)
end
end
end

local taskstateResult=taskModel:getTaskState(self.taskdata)
local taskstate=taskstateResult.state
if taskstate==taskModel.taskAcceptState then
rewardwiget:SetChildText(2,'接取任务')

else
rewardwiget:SetChildText(2,'领取奖励')

end

self.rewardObj:setChildCanvasGroupDOFade(1,0.3,nil)
end
end

function UIStoryBoardWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UIStoryBoardWin:initSelect()
self.chooseGrid:setActive(false)
end

function UIStoryBoardWin:showSelect()
local isshow=self:checkHasSelect()
self.chooseGrid:setActive(isshow)
self.arrowShadow:setActive(not isshow)
if isshow then
self.chooseGrid:setChildCanvasGroupAlpha(0)

local tasksSelectTxt=self.taskcfg.tasksSelectTxt
local num=#tasksSelectTxt
self.chooseGrid:setChildLayoutGroupCreateItems(num)
local grid=self.chooseGrid:getChildLayoutGroupGridList()
for i=1,num do
local data=tasksSelectTxt[i]
local item=grid[i-1]
local selectType=data[1]
local selectIcon='button_juqing_'..selectType

item:SetChildCSImageSprite(1,globalABLookup.juqingicons,selectIcon)

local desc_str=data[2]
local name=self:getName()or''
desc_str=gameplotModel:replaceName(desc_str,name)
item:SetChildText(2,desc_str)

item:SetChildButtonClick(0,function()
self:onSelectClick(i)
end)
end

self.chooseGrid:setChildCanvasGroupDOFade(1,0.3,nil)
end
end

function UIStoryBoardWin:onSelectClick(idx)
self.rewardIndex=idx
self:doNext()
end

function UIStoryBoardWin:finishStory()
self:onCommitClick()
end

function UIStoryBoardWin:onBackClick()

local isfinal=self:checkFinalDialogue()
local hasSelect=self:checkHasSelect()
if isfinal or hasSelect then
if self.talking then

self.talking=false
self:clearLookingTimer()

self:showSelect()
else
if(isfinal and not hasSelect)or(isfinal and hasSelect and self.rewardIndex~=nil)then
self:onCommitClick()
end
end
return
end
if self.talking then

self.talking=false
self:clearLookingTimer()
self:setLookingTimer()
else
self:clearLookingTimer()
self:doNext()
end
end

function UIStoryBoardWin:onCommitClick()
if self:checkFinalDialogue()and not self.overPlot then
self.overPlot=true
local taskstateResult=taskModel:getTaskState(self.taskdata)
local taskstate=taskstateResult.state

if self.audioHandle then
AudioManager.stopAudioById(self.audioHandle)
self.audioHandle=nil
end

self:restoreBGM()
if taskstate==taskModel.taskAcceptState then
taskController:reqAcceptTask(self.taskid)

AudioManager.playAudio(503)

if taskModel:isMultiAcceptTask(self.taskid)then
local idx=self.rewardIndex or 1
taskController:reqTaskReward(self.taskid,idx)

AudioManager.playAudio(100)
end
elseif taskstate==taskModel.taskRewardState then
local idx=0
if taskModel:isMultiCommitTask(self.taskid)then
idx=self.rewardIndex or 1
end
taskController:reqTaskReward(self.taskid,idx)

AudioManager.playAudio(100)
end
self:closeFullWin()
end
end

function UIStoryBoardWin:closeFullWin()
if self.isFullOpen then
fullScreenUI.closeActiveUI()
else
self:closeSelf()
end
end
