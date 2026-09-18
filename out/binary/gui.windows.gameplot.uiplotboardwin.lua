







def_class("UIPlotBoardWin",UIWindowBase)









function UIPlotBoardWin:bindComponents()

self.arrowShadow=UIObject.get(self,0)
self.biaoqingObj=UIObject.get(self,1)
self.centerpanel=UIObject.get(self,2)
self.chooseGrid=UIObject.get(self,3)
self.chooseView=UIObject.get(self,4)
self.cndesctxt=UIText.get(self,5)
self.cntitletxt=UIText.get(self,6)
self.EventGroupBG=UIObject.get(self,7)
self.EventGroupImage=UIObject.get(self,8)
self.goBtnObj=UIObject.get(self,9)
self.modelImage=UIObject.get(self,10)
self.modelObj=UIObject.get(self,11)
self.nameObj=UIObject.get(self,12)
self.rewardObj=UIObject.get(self,13)
self.root=UIObject.get(self,14)
self.shakeRoot=UIObject.get(self,15)
self.talkdesc=UIText.get(self,16)
self.talkdesc2=UIText.get(self,17)
self.talkframe=UIImage.get(self,18)
self.talkframe2=UIObject.get(self,19)
self.taskItemroot=UIObject.get(self,20)
self.testObj=UIObject.get(self,21)
self.xiushiPanel=UIImage.get(self,22)
self.xsdescImg=UIImage.get(self,23)
self.xsdesctxt=UIText.get(self,24)
self.xstitletxt=UIText.get(self,25)



end


function UIPlotBoardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrowShadow);self.arrowShadow=nil;
_UIObject_release(self.biaoqingObj);self.biaoqingObj=nil;
_UIObject_release(self.centerpanel);self.centerpanel=nil;
_UIObject_release(self.chooseGrid);self.chooseGrid=nil;
_UIObject_release(self.chooseView);self.chooseView=nil;
_UIObject_release(self.cndesctxt);self.cndesctxt=nil;
_UIObject_release(self.cntitletxt);self.cntitletxt=nil;
_UIObject_release(self.EventGroupBG);self.EventGroupBG=nil;
_UIObject_release(self.EventGroupImage);self.EventGroupImage=nil;
_UIObject_release(self.goBtnObj);self.goBtnObj=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.nameObj);self.nameObj=nil;
_UIObject_release(self.rewardObj);self.rewardObj=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shakeRoot);self.shakeRoot=nil;
_UIObject_release(self.talkdesc);self.talkdesc=nil;
_UIObject_release(self.talkdesc2);self.talkdesc2=nil;
_UIObject_release(self.talkframe);self.talkframe=nil;
_UIObject_release(self.talkframe2);self.talkframe2=nil;
_UIObject_release(self.taskItemroot);self.taskItemroot=nil;
_UIObject_release(self.testObj);self.testObj=nil;
_UIObject_release(self.xiushiPanel);self.xiushiPanel=nil;
_UIObject_release(self.xsdescImg);self.xsdescImg=nil;
_UIObject_release(self.xsdesctxt);self.xsdesctxt=nil;
_UIObject_release(self.xstitletxt);self.xstitletxt=nil;
end
















local lookingTimeDefault=60
local _this=nil

local dialougeSkins={
[1]={"frame_juqing_1","ui/windows/gameplot/sharedtextures/frame_juqing_1.ab"},
[2]={"frame_juqing_3","ui/windows/gameplot/sharedtextures/frame_juqing_3.ab"},
}


function UIPlotBoardWin:onLoaded(...)
self:bindComponents()
_this=self
self.oldBgmId=AudioManager.getCurrentBgm()
self.nowBgmId=AudioManager.getCurrentBgm()
end


function UIPlotBoardWin:__delete()
self:unbindComponents()
_this=nil

if self.audioHandle then
AudioManager.stopAudioById(self.audioHandle)
self.audioHandle=nil
end

if self.showblack then
gameplotController:closePlotBlack()
end
self:clearDelayCloseTimer()

if self.callCB and self.callback then
self.callback(false)
end
UIManager:closeActiveWindow('UITopMoneyWin2')
end


function UIPlotBoardWin:onHide()

end




function UIPlotBoardWin:onShow(argtable,afterOnloaded)
self.overPlot=false
self.actionPlaying=false
self.modelMoving=false

local showTest=false



self.testObj:setActive(showTest)

self:clearDelayCloseTimer()
self.dis_guid=argtable.dis_guid
self.name=argtable.name
self.groupid=argtable.groupid
self.rewards=argtable.rewards
self.callback=argtable.callback
self.isFullOpen=argtable.isFullOpen
self.testOffset=argtable.testOffset
self.isReady=argtable.isReady
if self.isReady==nil then self.isReady=true end
self.rewardBtnClickGray=argtable.rewardBtnClickGray
self.rewardBtnStr=argtable.rewardBtnStr
self.showGoBtn=argtable.showGoBtn
self.goBtnStr=argtable.goBtnStr
self.image=argtable.image
self.npcData=argtable.npcData
self.eventguid=argtable.eventguid
self.callCB=argtable.callCB
self.NPCtaskIndex=argtable.NPCtaskIndex
self.taskitem=argtable.taskItem
self.finishselect=argtable.finishselect
self.isfinishtask=argtable.isfinishtask
self.isaccepttask=argtable.isaccepttask
self.isfinishItem=argtable.isfinishItem
self.xiushiCond=argtable.xiushiCond

self.showblack=argtable.showblack







local selectlist=nil

local taskitemlist=nil
local lookingTime
if self.groupid~=nil then
self.groupcfg=cfgHelper.get(cfg_storydialoguegroupconfig_get,self.groupid)
self.dialoguelist=self.groupcfg.dialoguelist
selectlist=self.groupcfg.selectlist
taskitemlist=self.groupcfg.taskitemlist
lookingTime=self.groupcfg.lookingTime
else
self.groupcfg={}
self.dialoguelist=argtable.dialoguelist
selectlist=argtable.selectlist
taskitemlist=argtable.taskitemlist
end
self.lookingTime=lookingTime or lookingTimeDefault
self.afterSelectTalks=argtable.afterSelectTalks

self.tasksSelectPoint=nil
self.selectTxtList=nil
if selectlist then
self.tasksSelectPoint=selectlist[1]
self.selectTxtList=selectlist[2]
self.signtable=selectlist[3]
end
self.taskitembegin=nil
self.taskitemend=nil
if taskitemlist then
self.taskitembegin=taskitemlist[1]
self.taskitemend=taskitemlist[2]
end


self.rewardIndex=nil

self.dialogueNum=#self.dialoguelist
self.dialogueIndex=0

local isReady=self.isReady
self.root:setActive(isReady)
if self.isReady then


self:doNext()
end

end

function UIPlotBoardWin:onShowArgRecv(argtable)
self:onShow(argtable)
end


function UIPlotBoardWin:setReady(flag)
self.isReady=flag
if flag then

self.root:setActive(true)

self:doNext()
else

self.root:setActive(false)
end
end


function UIPlotBoardWin:refreshAnimModel(flag)
if flag then

self.root:setActive(false)
else

self.root:setActive(true)
end
end


function UIPlotBoardWin:checkHasSelect()
local idx=self.tasksSelectPoint
return idx~=nil and idx==self.dialogueIndex
end

function UIPlotBoardWin:checkFinalDialogue()
return self.dialogueIndex>=self.dialogueNum
end

function UIPlotBoardWin:doNext()
self.dialogueIndex=self.dialogueIndex+1
if self.dialogueIndex<=self.dialogueNum then
local dia_idx=self.dialoguelist[self.dialogueIndex]
self.dialoguecfg=cfgHelper.get1(cfg_storydialogueconfig_get,dia_idx)

if self.dialoguecfg.showNpc then
UIManager:showWindow("UIPlotBoardWin_npc",{self.dialoguecfg,self.dialoguecfg.npcID})
self:showRootCanvasGroup(0,0)
end
if self.dialoguecfg.enterEffectList==nil then
self:initShow()
else
self:initEnterActions()
end
self:playDialogueBGM()
else

self:checkFinish()
end
end


function UIPlotBoardWin:playDialogueBGM()
local dialogBGM=self.dialoguecfg.dialogBGM
if dialogBGM and dialogBGM~=self.nowBgmId then
local fadeTime=0.5
self.nowBgmId=dialogBGM
AudioManager.playBgMusic(dialogBGM,fadeTime)
end
end


function UIPlotBoardWin:restoreBGM()
if self.oldBgmId~=AudioManager.getCurrentBgm()then
if self.oldBgmId then
AudioManager.playBgMusic(self.oldBgmId)
else

local fadeTime=0.5
AudioManager.fadeoutBGMusic(fadeTime)
end
end
end

function UIPlotBoardWin:showRootCanvasGroup(value,time)
self.root:setChildCanvasGroupDOFade(value,time,nil)
end

function UIPlotBoardWin:checkFinish()
if not self.overPlot then
self.overPlot=true
if self.groupcfg.enterEffectList==nil and self.groupcfg.leaveEffectList==nil then
self:finishStory()
else
plotBoardController:handleLeaveAction()
end
end
end

function UIPlotBoardWin:initEnterActions()
self:refreshAnimModel(true)

self.actionList=plotActionController.initActionList(self.dialoguecfg.enterEffectList)

for i,v in ipairs(self.actionList)do
if v.flag==nil then
v.flag=true
plotBoardController:doAction(v.effect)
end
end

self.actionPlaying=true
local time=self.dialoguecfg.enterLife or 1000
time=time/1000
local func=function()
self:refreshAnimModel(false)
self.actionPlaying=false
self:killActionList()
self:initShow()
end
self:delayDo(time,func)
end

function UIPlotBoardWin:initShow()
local oldSide=self.modelSide
local oldnpcID=self.npcID
self.modelSide=self.dialoguecfg.side
self.npcID=self.dialoguecfg.npcID
self.imageID=self.dialoguecfg.imageID

if self.modelSide~=2 and self:checkHasSelect()or(self.modelSide~=1 and self.rewards~=nil and self:checkFinalDialogue())then

self.modelSide=0
end
local changenpc=self.npcID~=oldnpcID
local changeSide=self.modelSide~=oldSide or(oldnpcID==-1 and changenpc)

self:initTalkActions()
self:initSelect()
self:showModel(changeSide,changenpc,oldnpcID)
self:showEmot()
local noMan=self.npcID==-1
self.talkframe:setActive(not noMan)
self.talkframe2:setActive(noMan)
self.EventGroupBG:setActive(false)
if not noMan then
self:showName()
self:showTalk(self.talkdesc)

local dialougeSkin=self.dialoguecfg.dialougeSkin or 1
local dialougeSkinInfo=dialougeSkins[dialougeSkin]
self.talkframe:setCSImageSprite(dialougeSkinInfo[2],dialougeSkinInfo[1])
else
if self.imageID then
self.EventGroupBG:setActive(true)
local showflag=self:checkIsShowTaskItem()
if showflag or self:checkHasSelect()then
self.EventGroupBG:setLocalPos(-231,34,0)
else
self.EventGroupBG:setLocalPos(19,34,0)
end
self.EventGroupImage:setChildIcon(FMT.fmt("image_shijian_{0}",self.imageID),true)
end

self:showTalk(self.talkdesc2)
end
self:showReward()
self:showGo()
self:showShake()
self:showTaskItem()

self:showModelMove()


end



function UIPlotBoardWin:showShake()
local shakeLevel=self.dialoguecfg.shake or 0
if shakeLevel>0 then
self.shakeScale=1+0.01*shakeLevel
self.shakeNum=3
self.shakeRoot:setScale(Vector3(1,1,1))
self:doShake()
end
end


function UIPlotBoardWin:teskShake(shakeLevel,baseshake)
baseshake=baseshake or 0.01
if shakeLevel>0 then
self.shakeScale=1+baseshake*shakeLevel
self.shakeNum=3
self.shakeRoot:setScale(Vector3(1,1,1))
self:doShake()
end
end

function UIPlotBoardWin:doShake()
if self.shakeNum<=0 then return end
self.shakeNum=self.shakeNum-1
if self.shakeTween~=nil then
self.shakeTween:Kill()
self.shakeTween=nil
end
self.shakeTween=self.shakeRoot:setChildDOScale(self.shakeScale,0.05,function()
if _this==nil then return end
_this.shakeTween=nil
_this:doShake2()
end)
end

function UIPlotBoardWin:doShake2()
if self.shakeTween~=nil then
self.shakeTween:Kill()
self.shakeTween=nil
end
self.shakeTween=self.shakeRoot:setChildDOScale(1,0.05,function()
if _this==nil then return end
_this.shakeTween=nil
_this:doShake()
end)
end






function UIPlotBoardWin:showModelMove()
local MovePose=self.dialoguecfg.MovePose
if MovePose then
local pos=MovePose[1]or{10,10,0}
local duration=MovePose[2]or 5
self.modelMoving=true
local func1=function()
self.modelMoving=false
if self.modelMove2~=nil then
self.modelMove2:Kill()
self.modelMove2=nil
end
end
if self.modelMove2~=nil then
self.modelMove2:Kill()
self.modelMove2=nil
end
self.modelMove2=self.modelObj:setChildDOLocalMove(Vector3.New(pos[1],pos[2],pos[3]),duration,func1)
end
end


function UIPlotBoardWin:showFlashAndShake()
local flashmove=self.dialoguecfg.flashmove
if flashmove then
if flashmove then
UIPlotBoardWin:showCameraShake(flashmove[2])
end
end
end


function UIPlotBoardWin:showCameraShake(flashmove)

if flashmove then
local duration=flashmove[1]
local strength=flashmove[2]
local vibrato=flashmove[3]
local roottransform=self.winlua:GetChildGameObject(self.root:getID()).transform
local tweener=_DOTweenProxy.DOShakePosition(roottransform,duration,Vector3.New(strength[1],strength[2],strength[3]),vibrato)
tweener:SetEase(_Ease.Linear)
end
end



function UIPlotBoardWin:initTalkActions()
if self.dialoguecfg.effectlist~=nil then

self.actionList=plotActionController.initActionList(self.dialoguecfg.effectlist)

for i,v in ipairs(self.actionList)do
if v.flag==nil then
v.flag=true
plotBoardController:doAction(v.effect)
end
end
end
end

function UIPlotBoardWin:showModel(changeSide,changenpc,oldnpcID)
local bodyid=nil
local components={}
local npcID=self.npcID
local offset=nil
local modelType=1
local isZSModel=false
local isDzModel=false
local dzGuid
if npcID==0 then

if self.dis_guid==nil then
local random_dis=UIDiscipleModel:getRandomDiscipleData()
self.dis_guid=random_dis.discipleguid
end

if self.image then
bodyid=self.image.body
components=self.image.componets
else
if self.dis_guid~=nil then
local image=UIDiscipleModel:getDiscipleInsideModelInfo(self.dis_guid)
if image then
bodyid=image.body
components=image.componets
end
end
end
elseif npcID==-3 then

local random_dis=MysteryModel:get_random_dizi_data()
self.dis_guid=random_dis.discipleguid


if self.image then
bodyid=self.image.body
components=self.image.componets
else
if self.dis_guid~=nil then
local image=UIDiscipleModel:getDiscipleInsideModelInfo(self.dis_guid)
if image then
bodyid=image.body
components=image.componets
end
end
end
elseif npcID==-4 then
if self.dis_guid==nil then
self.dis_guid=MysteryModel:get_team_first()
end

if self.image then
bodyid=self.image.body
components=self.image.componets
else
if self.dis_guid~=nil then
local image=UIDiscipleModel:getDiscipleInsideModelInfo(self.dis_guid)
if image then
bodyid=image.body
components=image.componets
end
end
end
elseif npcID==-5 then

if not changeSide and not changenpc then

return
end

local npcData=self.npcData
local eventguid=self.eventguid
local model=eventOptionControl.getOptionNpcModel(npcData,eventguid,true)
if model then
bodyid=model.body
components=model.componets
end
elseif npcID==-6 then

if not changeSide and not changenpc then

return
end

local npcid=YiYuHuiYouModel:getnpczhiyinid()
local cfg_npcmodelid=cfg_yiyuhuiyounpcconfig_get(npcid).npc_model

local model=npcModel:getImageInfo(cfg_npcmodelid[1])
if model then
bodyid=model.body
components=model.componets
end

local npccfg=cfgHelper.get1(cfg_npcimageconfig_get,cfg_npcmodelid[1])
if npccfg.plotOffset then
offset=npccfg.plotOffset
end
modelType=npccfg.modelType
elseif npcID==-7 then

if not changeSide and not changenpc then

return
end
local eventguid=self.eventguid
local dzGuid=eventOptionControl.getOptionDzGuid(eventguid)
if dzGuid then
local model=UIDiscipleModel:getDiscipleInsideModelInfo(dzGuid)
if model then
bodyid=model.body
components=model.componets
end
else

if self.dis_guid==nil then
local random_dis=UIDiscipleModel:getRandomDiscipleData()
self.dis_guid=random_dis.discipleguid
end

if self.image then
bodyid=self.image.body
components=self.image.componets
else
if self.dis_guid~=nil then
local image=UIDiscipleModel:getDiscipleInsideModelInfo(self.dis_guid)
if image then
bodyid=image.body
components=image.componets
end
end
end
end
elseif npcID==-8 then

if not changeSide and not changenpc then

return
end
local npcData=self.npcData
local manGuid=npcData.man
local image=UIDiscipleModel:getDiscipleInsideModelInfo(manGuid)
if image then
bodyid=image.body
components=image.componets
end
elseif npcID==-9 then

if not changeSide and not changenpc then

return
end

local npcData=self.npcData
local womanGuid=npcData.woman
local image=UIDiscipleModel:getDiscipleInsideModelInfo(womanGuid)
if image then
bodyid=image.body
components=image.componets
end
elseif npcID==-10 then

if not changeSide and not changenpc then

return
end

local npcData=self.npcData
local zmDisciple=npcData.zmDisciple
local image=UIDiscipleModel:getDiscipleInsideModelInfo(zmDisciple.discipleguid)
if image then
bodyid=image.body
components=image.componets
end
elseif npcID==-11 then

if not changeSide and not changenpc then

return
end

local npcData=self.npcData
local image=npcData.systemZongMenModel
if image then
bodyid=image.body
components=image.componets
end
elseif npcID==-12 then

if not changeSide and not changenpc then

return
end
self.dis_guid=JiuChongTianJieEnterController:getDuJieDisciple()
self.dis_guid=tostring(self.dis_guid)
if tonumber(self.dis_guid)>0 then
dzGuid=self.dis_guid
else
local sortFunc=function(sortA,sortB)
if sortA.jingjielv==sortA.jingjielv then
local aFight=UIDiscipleModel:getDiscipleFightValue(sortA.discipleguid)
local bFight=UIDiscipleModel:getDiscipleFightValue(sortB.discipleguid)
return aFight>bFight
else
return sortA.jingjielv>sortA.jingjielv
end

end
local sortList=UIDiscipleModel:getSortList(nil,sortFunc)
local data=sortList[1]
dzGuid=data.discipleguid
self.dis_guid=dzGuid
end
isDzModel=dzGuid~=nil
elseif npcID==-13 then

isZSModel=true
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
end
local isshow=bodyid~=nil or isZSModel or isDzModel
self.modelObj:setActive(isshow)

if isshow then
if changenpc and oldnpcID~=nil then
self.modelImage:setChildUIModelRemoveTarget()
end
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
elseif self.modelSide==1 then

self.modelObj:setLocalPosX(398)
self.modelMove=self.modelObj:setChildDOLocalMoveX(378,0.4,func)
elseif self.modelSide==2 then
self.modelObj:setLocalPosX(0)
self.modelMove=self.modelObj:setChildDOLocalMoveX(0,0.4,func)
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
elseif isDzModel then
if dzGuid then
comHelper.setChildInSideModel(self.modelImage,dzGuid,0.85,nil,0,0,false,false,nil,{})
end
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

function UIPlotBoardWin:showEmot()
local emot=self.dialoguecfg.emot
local hasEmot=emot~=nil
self.biaoqingObj:setActive(hasEmot)
if hasEmot then
local bqWidget=self.biaoqingObj:getChildWidgetBase()
if self.modelSide==0 then

self.biaoqingObj:setLocalPosX(-320)
bqWidget:SetChildScale(0,Vector3.New(1,1,1))
bqWidget:SetChildAnchoredPos(1,4,0)
elseif self.modelSide==1 then

self.biaoqingObj:setLocalPosX(210)
bqWidget:SetChildScale(0,Vector3.New(-1,1,1))
bqWidget:SetChildAnchoredPos(1,0,0)
else
self.biaoqingObj:setLocalPosX(80)
bqWidget:SetChildScale(0,Vector3.New(1,1,1))
bqWidget:SetChildAnchoredPos(1,4,0)
end

bqWidget:SetChildText(1,chatEmotHelper.decodeEmot(emot))

self.biaoqingObj:setChildCanvasGroupAlpha(0)
self.biaoqingObj:setScale(Vector3.New(0.8,0.8,0))

local func=function()
self.biaoqingObj:setChildCanvasGroupDOFade(1,0.1,nil)
local t1=self.biaoqingObj:setChildDOScale(1,0.4,nil)
t1:SetEase(_Ease.OutElastic)
end
self:delayDo(0.1,func)
end
end

function UIPlotBoardWin:getName()
local npcID=self.npcID
local name=nil
if self.name then
name=self.name
else
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
elseif npcID==-5 then
local npcData=self.npcData
local eventguid=self.eventguid
name=eventOptionControl.getOptionNpcName(npcData,eventguid)or""
elseif npcID==-6 then
local npcid=YiYuHuiYouModel:getnpczhiyinid()
local cfg_npcmodelid=cfg_yiyuhuiyounpcconfig_get(npcid).npc_model

local cfg_npcname=cfg_npcimageconfig_get(cfg_npcmodelid[1]).name
name=cfg_npcname or""
elseif npcID==-7 then
local eventguid=self.eventguid
local dzGuid=eventOptionControl.getOptionDzGuid(eventguid)
if dzGuid then
name=UIDiscipleModel:getDiscipleName(dzGuid)
elseif self.dis_guid~=nil then
name=UIDiscipleModel:getDiscipleName(self.dis_guid)
end
elseif npcID==-8 then
local npcData=self.npcData
local manGuid=npcData.man
name=UIDiscipleModel:getDiscipleName(manGuid)or""
elseif npcID==-9 then
local npcData=self.npcData
local womanGuid=npcData.woman
name=UIDiscipleModel:getDiscipleName(womanGuid)or""
elseif npcID==-10 then
local npcData=self.npcData
local zmDisciple=npcData.zmDisciple
name=zmDisciple.disciplename or""
elseif npcID==-11 then
local npcData=self.npcData
name=npcData.systemZongMenName or""
elseif npcID==-12 then
if self.dis_guid~=nil then
name=UIDiscipleModel:getDiscipleName(self.dis_guid)
end
elseif npcID==-13 then
name=playerModel:getActorName()
elseif npcID>=0 then
name=npcModel:getName(npcID)
end
end

return name
end

function UIPlotBoardWin:getOtherName()
local npcID=self.npcID
local otherName=nil
if npcID==-8 then

local npcData=self.npcData
local womanGuid=npcData.woman
otherName=UIDiscipleModel:getDiscipleName(womanGuid)or""
elseif npcID==-9 then

local npcData=self.npcData
local manGuid=npcData.man
otherName=UIDiscipleModel:getDiscipleName(manGuid)or""
end
return otherName
end

function UIPlotBoardWin:showName()
local name=self:getName()
local isshow=name~=nil
self.nameObj:setActive(isshow)
if isshow then
local nameObjWidget=self.nameObj:getChildWidgetBase()

if self.modelSide==0 then

self.nameObj:setLocalPosX(-436)

elseif self.modelSide==1 then

self.nameObj:setLocalPosX(500)

elseif self.modelSide==2 then

self.nameObj:setLocalPosX(0)
end

nameObjWidget:SetChildText(1,name)
end
end

function UIPlotBoardWin:showTalk(talkdesc)
local isshow=self.rewards==nil and self.showGoBtn==nil
if self.rewards or self.showGoBtn then
isshow=not self:checkFinalDialogue()
end

talkdesc:setActive(isshow)
self.arrowShadow:setActive(isshow)
if isshow then
talkdesc:setChildCanvasGroupAlpha(0)


local slowShow=true
if self:checkHasSelect()then
slowShow=false
end
local name=self:getName()or''
local otherName=self:getOtherName()or''
local desc=self.dialoguecfg.dialogue
desc=gameplotModel:replaceName(desc,name,otherName)
desc=FMT.fmt('{0}{1}','　　',desc)
local speed=slowShow and 40 or 80






if self.dialoguecfg.broadcast~=nil then
gameplotController.doDialogueBroadcast(name,self.dialoguecfg.broadcast)
end
self.talking=true
talkdesc:setText(desc)

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

self.centerpanel:setActive(false)
local noMan=self.npcID==-1
if not noMan then
local desc2=self.dialoguecfg.dialogue2
if desc2 then
talkdesc:setText("")
self.centerpanel:setActive(true)
self.cntitletxt:setText(desc2[1]or"")
self.cndesctxt:setText(desc2[2]or"")
end
end
self.xiushiPanel:setActive(false)
if self:checkHasSelect()and self.xiushiCond~=nil then
talkdesc:setText("")
self.xiushiPanel:setActive(true)
local soldierCfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,self.xiushiCond[1])
self.xstitletxt:setText(FMT.fmt("所需修士（{0}或以上）",soldierCfg.name))

local str
local soldierCountList,allSoldierCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy,nil,nil,self.xiushiCond[1])
local hasCountstr=mathHelper.formatNumber4(allSoldierCount,1)
local neednumstr=mathHelper.formatNumber4(self.xiushiCond[2],1)
if allSoldierCount>=self.xiushiCond[2]then
str=string.format("<color=#549327>%s/%s</color>",hasCountstr,neednumstr)
else
str=string.format("<color=#c82c2c>%s/%s</color>",hasCountstr,neednumstr)
end
self.xsdesctxt:setText(str)

local iconAb="ui/windows/xianjie/xianjiemain_soldiername_atlas_pak.ab"
local iconName=soldierCfg.nameIcon2
self.xsdescImg:setCSImageSprite(iconAb,iconName)
end
self:talkFinish()

talkdesc:setChildCanvasGroupDOFade(1,0.3,nil)
end
end

function UIPlotBoardWin:showReward()
local isshow=self.rewards~=nil and self:checkFinalDialogue()
self.rewardObj:setActive(isshow)
if isshow then
local hasSelect=self:checkHasSelect()
if hasSelect then
self:showSelect()
end

self.rewardObj:setChildCanvasGroupAlpha(0)
local rewardwiget=self.rewardObj:getChildWidgetBase()


local name=self:getName()or''
local desc=self.dialoguecfg.dialogue
desc=gameplotModel:replaceName(desc,name)
rewardwiget:SetChildText(0,desc)

local rewardlist=self.rewards
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
if self.rewardBtnStr then
rewardwiget:SetChildText(2,self.rewardBtnStr)
end

self.rewardObj:setChildCanvasGroupDOFade(1,0.3,nil)
end
self.arrowShadow:setActive(not isshow)
end




function UIPlotBoardWin:onGoodItemClick(itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid})
end
end

function UIPlotBoardWin:showGo()
local isshow=self.showGoBtn~=nil and self:checkFinalDialogue()
self.goBtnObj:setActive(isshow)
if isshow then
self.goBtnObj:setChildCanvasGroupAlpha(0)
local rewardwiget=self.goBtnObj:getChildWidgetBase()

local name=self:getName()or''
local desc=self.dialoguecfg.dialogue
desc=gameplotModel:replaceName(desc,name)
rewardwiget:SetChildText(0,desc)

if self.goBtnStr then
rewardwiget:SetChildText(1,self.goBtnStr)
end
self.goBtnObj:setChildCanvasGroupDOFade(1,0.3,nil)
end
end

function UIPlotBoardWin:talkFinish()
self.talking=false
local hasSelect=self:checkHasSelect()
self:clearLookingTimer()
if hasSelect then
self:showSelect()
else
if self.rewards==nil or(self.rewards~=nil and not self:checkFinalDialogue())then
self:setLookingTimer()
end
end
end

function UIPlotBoardWin:setLookingTimer()
local func=function()
self:talkEnd()
end
self.lookingTimer=self:setTimer(self.lookingTime,1,func)
end

function UIPlotBoardWin:clearLookingTimer()
if self.lookingTimer~=nil then
self:stopTimerByID(self.lookingTimer)
self.lookingTimer=nil
end
end

function UIPlotBoardWin:initSelect()
self.chooseGrid:setActive(false)
self.chooseView:setActive(false)
end

function UIPlotBoardWin:showSelect()
local isshow=self:checkHasSelect()
self.chooseGrid:setActive(isshow)
self.chooseView:setActive(isshow)
self.arrowShadow:setActive(not isshow)
if isshow then
self.chooseGrid:setChildCanvasGroupAlpha(0)
local list={}
local tasksSelectTxt=self.selectTxtList
for i=1,#tasksSelectTxt do
if self.xiushiCond then
local isHasXS=self:judeFinishXiuShi()
if i==1 then
if isHasXS then
table.insert(list,{id=i,str=tasksSelectTxt[i]})
end
else
if not isHasXS then
table.insert(list,{id=i,str=tasksSelectTxt[i]})
end
end
else
table.insert(list,{id=i,str=tasksSelectTxt[i]})
end
end
local num=#list
local signSelect=self.signtable



self.chooseView:setChildScrollViewCreateGrids(num,1)
local grid=self.chooseView:getChildScrollViewItemWidgets()
for i=1,num do
local id=list[i].id
local desc_str=list[i].str
local item=grid[i-1]
local selectType=1
local selectIcon='button_juqing_'..selectType

item:SetChildCSImageSprite(1,globalABLookup.juqingicons,selectIcon)

item:SetChildActive(3,false)

if signSelect then
local type=signSelect[i]
local signimage,abname=taskModel:GettaskTypeSign(type)
if signimage then
item:SetChildActive(3,true)
item:SetChildCSImageSprite(3,abname,signimage)
end
end

local name=self:getName()or''
desc_str=gameplotModel:replaceName(desc_str,name)
item:SetChildText(2,desc_str)

item:SetChildButtonClick(0,function()
self:onSelectClick(id)
end)

item:SetChildNewBieComponentId(0,'UIPlotBoardWin.chooseItem_'..i)
end
self.chooseGrid:setChildCanvasGroupDOFade(1,0.3,nil)
end
end

function UIPlotBoardWin:talkEnd()
if self.dialoguecfg.effectlist then
self:killActionList()
end
if self.dialoguecfg.leaveEffectList==nil then
self:doNext()
else
self:initLeaveActions()
end
end

function UIPlotBoardWin:killActionList()
if self.actionList then
for i,v in ipairs(self.actionList)do
if v.flag==true then
v.flag=false
plotBoardController:killAction(v.effect)
end
end
end
self.actionList=nil
end

function UIPlotBoardWin:initLeaveActions()
self:refreshAnimModel(true)

self.actionList=plotActionController.initActionList(self.dialoguecfg.leaveEffectList)

for i,v in ipairs(self.actionList)do
if v.flag==nil then
v.flag=true
plotBoardController:doAction(v.effect)
end
end

self.actionPlaying=true
local time=self.dialoguecfg.leaveLife or 3000
time=time/1000
local func=function()
self:refreshAnimModel(false)
self.actionPlaying=false
self:killActionList()
self:doNext()
end
self:delayDo(time,func)
end


function UIPlotBoardWin:showTaskItem()
local isshow=self.taskitem~=nil and self:checkIsShowTaskItem()
self.taskItemroot:setActive(isshow)
if isshow then

local taskwiget=self.taskItemroot:getChildWidgetBase()

if self.isfinishtask then
taskwiget:SetChildText(1,"所需物品")
elseif self.isaccepttask then
taskwiget:SetChildText(1,"任务物品")
end

local item=taskwiget:GetChildWidgetBase(0)

local data=self.taskitem[1]

local show=data~=nil
item:SetChildActive(1,show)
if show and moneyConfig.isMoney(data[1])and self.isfinishtask then
UIManager:showWindow('UITopMoneyWin2',{moneys={{data[1]}},canvasIndex=9})
end
if show then
local itemID=data[1]
local num=data[2]
local str=''
local neednum=data[2]
local hasCount=itemsModel.getCount(itemID)
if hasCount>=neednum then
local neednumstr=mathHelper.formatNumber4(neednum)
str=string.format("<color=#aae252>%s</color>",neednumstr)
else
local hasCountstr=mathHelper.formatNumber4(hasCount)
local neednumstr=mathHelper.formatNumber4(neednum)
str=string.format("<color=#f36666>%s/%s</color>",hasCountstr,neednumstr)
end
if self.isaccepttask then
str=''
end
local conf={itemid=itemID,itemcount=str,showname=true,showCountBG=str~='',showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(...)end)
local itemcfg=itemsConfig.getConfig(itemID)
local itemtype=itemcfg.type1 or 0
item:SetChildActive(2,itemtype==30)
end
if self:checkHasSelect()then
self.taskItemroot:setLocalPos(419.6,56.8,0)
else
self.taskItemroot:setLocalPos(419.6,-95,0)
end

end
end


function UIPlotBoardWin:checkIsShowTaskItem()
local idx=self.taskitembegin
local endidx=self.taskitemend
if idx~=nil and endidx~=nil then
if self.dialogueIndex>=idx and self.dialogueIndex<=endidx then
return true
end
end
return false
end



function UIPlotBoardWin:onSelectClick(idx)

if self.finishselect then
if idx==1 then
if self.xiushiCond then
if not self:judeFinishXiuShi()then
UIManager.info("所需修士不足")
return
end
elseif self.isfinishItem then
if not UIPlotBoardWin:judeFinishItem(self.taskitem)then
UIManager.info("所需物品不足")
return
end
else
local task_id=taskModel:GetReceiveTask()
if task_id and task_id~=0 then
if not taskModel:judeFinishItem(task_id)then
UIManager.info("所需物品不足")
return
end
end
end

end
end
self.rewardIndex=idx

local afterSelectTalks=self.afterSelectTalks
if afterSelectTalks~=nil then
local list=afterSelectTalks[idx]
if list~=nil then
for i,str in ipairs(list)do
table.insert(self.dialoguelist,str)
end
self.dialogueNum=#self.dialoguelist
end
end

self.NPCtaskIndex=idx
self:talkEnd()
end


function UIPlotBoardWin:judeFinishXiuShi()
local soldierCountList,allSoldierCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy,nil,nil,self.xiushiCond[1])
return allSoldierCount>=self.xiushiCond[2]
end


function UIPlotBoardWin:judeFinishItem(taskItem)
if not taskItem then
return true
end
for k,v in ipairs(taskItem)do
local neednum=v[2]
local hasCount=itemsModel.getCount(v[1])
if neednum>hasCount then
return false
end
end
return true
end

function UIPlotBoardWin:onBackClick()

if not self.isReady or self.actionPlaying or self.overPlot or self.modelMoving then return end
if self:checkHasSelect()then

if self.talking then


self.talking=false
self:clearLookingTimer()

self:showSelect()
else
if self:checkFinalDialogue()and self.rewards~=nil and self.rewardIndex~=nil then
self:onRewardBtn()
end
end
return
elseif self:checkFinalDialogue()and self.rewards~=nil then
self:onRewardBtn()
return
end

if self.talking then
self.talking=false
self:clearLookingTimer()
self:setLookingTimer()
else
self:clearLookingTimer()
self:talkEnd()
end

AudioManager.playBtnClick()
end

function UIPlotBoardWin:onRewardBtn()
if self.rewardBtnClickGray then
local rewardwiget=self.rewardObj:getChildWidgetBase()
rewardwiget:SetChildButtonEnable(4,true,true)
end
self:checkFinish()
end

function UIPlotBoardWin:onGoBtn()
self:checkFinish()
end


function UIPlotBoardWin:onLeave()
self:finishStory()
end

function UIPlotBoardWin:finishStory()
if self:checkFinalDialogue()then

local func=function()
self.delayCloseTimer=nil
self:closeBefore()
end
self.delayCloseTimer=self:setTimer(0.05,1,func)


self:restoreBGM()

if self.groupcfg.imagePool~=nil then
plotBoardController:closeStage(self.groupid)
end

local cb=self.callback
local idx=self.rewardIndex
local selectindex=self.NPCtaskIndex
if cb~=nil then cb(idx,selectindex)end
end
end

function UIPlotBoardWin:clearDelayCloseTimer()
if self.delayCloseTimer~=nil then
self:stopTimerByID(self.delayCloseTimer)
self.delayCloseTimer=nil
end
end

function UIPlotBoardWin:closeBefore()
if self.isFullOpen then
if fullScreenUI.isActiveFullEx(FULL_TYPE.eStoryBoard,'UIPlotBoardWin')then
fullScreenUI.closeActiveUI()
end
else
UIManager:closeWindow('UIPlotBoardWin')
end
end

function UIPlotBoardWin:closeFullWin()
if self.isFullOpen then
fullScreenUI.closeActiveUI()
else
UIManager:closeWindow('UIPlotBoardWin')
end
end
