







def_class("UIPlotComicWin",UIWindowBase)









function UIPlotComicWin:bindComponents()

self.arrowShadow=UIObject.get(self,0)
self.back=UIButton.get(self,1)
self.clickMaskBtn=UIButton.get(self,2)
self.entryPlay=UIObject.get(self,3)
self.infoBg=UIObject.get(self,4)
self.leftObj=UIObject.get(self,5)
self.manhuaRoot=UIImage.get(self,6)
self.modelImage=UIObject.get(self,7)
self.modelObj=UIObject.get(self,8)
self.nameObj=UIObject.get(self,9)
self.pbObj=UIObject.get(self,10)
self.plotroot=UIObject.get(self,11)
self.rightObj=UIObject.get(self,12)
self.root=UIObject.get(self,13)
self.skipBtn=UIButton.get(self,14)
self.talkdesc=UIText.get(self,15)
self.talkdesc2=UIText.get(self,16)
self.talkframe=UIImage.get(self,17)
self.talkframe2=UIObject.get(self,18)
self.topUIRoot=UIObject.get(self,19)

self.back:setButtonClick(function()self:onBack()end)

self.clickMaskBtn:setButtonClick(function()self:onClickMaskBtn()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)



end


function UIPlotComicWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrowShadow);self.arrowShadow=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.clickMaskBtn);self.clickMaskBtn=nil;
_UIObject_release(self.entryPlay);self.entryPlay=nil;
_UIObject_release(self.infoBg);self.infoBg=nil;
_UIObject_release(self.leftObj);self.leftObj=nil;
_UIObject_release(self.manhuaRoot);self.manhuaRoot=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.nameObj);self.nameObj=nil;
_UIObject_release(self.pbObj);self.pbObj=nil;
_UIObject_release(self.plotroot);self.plotroot=nil;
_UIObject_release(self.rightObj);self.rightObj=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.talkdesc);self.talkdesc=nil;
_UIObject_release(self.talkdesc2);self.talkdesc2=nil;
_UIObject_release(self.talkframe);self.talkframe=nil;
_UIObject_release(self.talkframe2);self.talkframe2=nil;
_UIObject_release(self.topUIRoot);self.topUIRoot=nil;
end
















local lookingTime=10
local changeInterval=0.5
local _defaultTalkSpeed=40

local _this

local dialougeSkinGroups={
[1]={
[1]={"frame_juqing_1","ui/windows/gameplot/sharedtextures/frame_juqing_1.ab"},
[2]={"frame_juqing_3","ui/windows/gameplot/sharedtextures/frame_juqing_3.ab"},
},
[2]={
[1]={"image_juqingduihuaui_3","ui/windows/gameplot/sharedtextures/image_juqingduihuaui_3.ab"},
[2]={"image_juqingduihuaui_4","ui/windows/gameplot/sharedtextures/image_juqingduihuaui_4.ab"},
}
}




function UIPlotComicWin:onLoaded(...)
_this=self
self.oldBgmId=AudioManager.getCurrentBgm()
self.nowBgmId=AudioManager.getCurrentBgm()
self:bindComponents()

self.back:setChildCanvasGroupAlpha(0)
end


function UIPlotComicWin:__delete()
_this=nil
self:unbindComponents()
end




function UIPlotComicWin:onShow(argtable,afterOnloaded)
local sc=UIManager.defaultCanvas_trans.localScale
local width=UnityEngine.Screen.width/sc.x
if UIManager:isActive("UITopMaskWin")then
self.topUIRoot:setChildSizeDelta(width,750)
else
local height=UnityEngine.Screen.height/sc.y
self.topUIRoot:setChildSizeDelta(width,height)
end

self.dis_guid=argtable.dis_guid
self.groupid=argtable.groupid
self.callback=argtable.callback
self.isFullOpen=argtable.isFullOpen

self.name=argtable.name
self.npcData=argtable.npcData

self.eventguid=argtable.eventguid

local groupcfg=cfgHelper.get(cfg_storydialoguegroupconfig_get,self.groupid)
self.groupcfg=groupcfg


local showSkip=groupcfg.allowskip
self.skipBtn:setActive(showSkip==true)

self.isCanSkipTalk=groupcfg.isCanSkipTalk
self.dialoguelist=groupcfg.dialoguelist
self.dialogueNum=#self.dialoguelist
self.callback=argtable.callback


self.dialogueIndex=0

self.talking=false
self.lockNext=true

self.beforeBgm=AudioManager.getCurrentBgm()
self.nowBgmHandle=nil
self.nowBgmId=nil
self.playSoundList={}


self:doNext()
end


function UIPlotComicWin:onHide()

end

function UIPlotComicWin:onShowArgRecv(argtable)
if argtable then
if self.waitCloseSelfTimerId then
self:stopTimerByID(self.waitCloseSelfTimerId)
self.waitCloseSelfTimerId=nil
end
self:onShow(argtable)
end
end

function UIPlotComicWin:finishStory()
if self.groupcfg.comicPlotNoBlackOut then
_this:onSkipBtn()
else
self.entryPlay:setChildCanvasGroupDOFade(1,1,function()
if _this==nil then return end
_this:onSkipBtn()
end)
end
end

function UIPlotComicWin:doNext()
self.dialogueIndex=self.dialogueIndex+1
if self.dialogueIndex<=self.dialogueNum then
self.leftObj:setChildCanvasGroupAlpha(0)
self.rightObj:setChildCanvasGroupAlpha(0)
local dia_idx=self.dialoguelist[self.dialogueIndex]
self.dialoguecfg=cfgHelper.get1(cfg_storydialogueconfig_get,dia_idx)

local isShowInfoBg=self.dialoguecfg.talkBlackBgAlpha~=nil
self.infoBg:setActive(isShowInfoBg)
if isShowInfoBg then
self.winlua:SetChildIconAlpha(self.infoBg:getID(),self.dialoguecfg.talkBlackBgAlpha)
end

local oldnpcID=self.npcID
self.npcID=self.dialoguecfg.npcID
local changenpc=self.npcID~=oldnpcID
local oldSide=self.modelSide
self.modelSide=self.dialoguecfg.side
local changeSide=self.modelSide~=oldSide or(oldnpcID==-1 and changenpc)
local dialougeGroup=self.dialoguecfg.bgInfo~=nil and 2 or 1


local freshObjs=function()
if _this==nil then return end
self.pbObj:setActive(self.modelSide==2)
self.talkframe2:setActive(self.modelSide==2)


self.talkframe:setActive(self.modelSide~=2)
self.modelObj:setActive(self.modelSide~=2 and dialougeGroup==1)
end

self:showComic()

self.arrowShadow:setActive(false)
self.plotroot:setChildCanvasGroupDOFade(0,changeInterval,function()
if _this==nil then return end
local showFunc=function()
if _this==nil then return end
freshObjs()
if self.modelSide==2 then
self:showNarration()
else

if dialougeGroup==1 then
self:showModel(changeSide,changenpc,oldnpcID)
elseif dialougeGroup==2 and(self.dialoguecfg.bgInfo[3]and self.dialoguecfg.bgInfo[3]==1)then
self:showModel(changeSide,changenpc,oldnpcID)
end
self:showName()
self:showTalk(dialougeGroup)
end
self.plotroot:setChildCanvasGroupDOFade(1,changeInterval,function()
if _this==nil then return end
self.lockNext=false

end)
end

if self.dialoguecfg.delayTalkTime~=nil then
self:delayDo(self.dialoguecfg.delayTalkTime,function()
showFunc()
end)
else
showFunc()
end
end)
self:playDialogueBGM()
else

self:finishStory()
end
end


function UIPlotComicWin:playDialogueBGM()
local dialogBGM=self.dialoguecfg.dialogBGM
if dialogBGM and dialogBGM~=self.nowBgmId then
local fadeTime=0.5
self.nowBgmId=dialogBGM
AudioManager.playBgMusic(dialogBGM,fadeTime)
end
end


function UIPlotComicWin:restoreBGM()
if self.oldBgmId~=AudioManager.getCurrentBgm()then
if self.oldBgmId then
AudioManager.playBgMusic(self.oldBgmId)
else

local fadeTime=0.5
AudioManager.fadeoutBGMusic(fadeTime)
end
end
end

function UIPlotComicWin:initShowModel(changeSide)

self:showModel(changeSide,changenpc,oldnpcID)
end

function UIPlotComicWin:showName()
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

self.nameObj:setLocalPosX(-436)
end

nameObjWidget:SetChildText(1,name)
end
end

function UIPlotComicWin:showComic()
local isShow=self.dialoguecfg.bgInfo~=nil
if not isShow then
self.manhuaRoot:setChildCanvasGroupDOFade(0,changeInterval)
self.back:setChildCanvasGroupDOFade(0,changeInterval)
return
end
if self.storyBgId and self.dialoguecfg.bgInfo[1]==self.storyBgId then
return
end

self.manhuaRoot:setActive(true)

self.manhuaRoot:setChildCanvasGroupDOFade(0,changeInterval,function()
if _this==nil then return end
local imageName=FMT.fmt("image_storytalkbg_{0}",self.dialoguecfg.bgInfo[1])
self.manhuaRoot:setCSImageSprite(self.dialoguecfg.bgInfo[2],imageName)

self.back:setChildCanvasGroupDOFade(1,changeInterval)
self.manhuaRoot:setChildCanvasGroupDOFade(1,changeInterval)
self.entryPlay:setChildCanvasGroupAlpha(0)
end)
self.storyBgId=self.dialoguecfg.bgInfo[1]
end


function UIPlotComicWin:animatorPrefabInitCallBack(obj)
self.animatorObj=obj;
local component=self.animatorObj:GetComponent("CSGUILuaFunction")
if component then
CS.BindFunction(component,self)
end
end


function UIPlotComicWin:animatorPlaySound(soundId)
local audioHandleId=AudioManager.playAudio(soundId)

table.insert(self.playSoundList,audioHandleId)
end


function UIPlotComicWin:clearPlaySound()
if self.playSoundList and next(self.playSoundList)then
local fadeTime=1
for i,v in ipairs(self.playSoundList)do
AudioManager.fadeOutStopAudioById(v,fadeTime)
end


self.playSoundList={}
end
end

function UIPlotComicWin:showNarration()
local dialougeGroup=self.dialoguecfg.bgInfo~=nil and 2 or 1
self.pbObj:setActive(dialougeGroup==2)
self.talkframe2:setActive(dialougeGroup==1)

local name=self:getName()
local desc=self.dialoguecfg.dialogue or'未配置'
desc=gameplotModel:replaceName(desc,name)
local descColor=dialougeGroup==1 and"#171311"or"#f7f7f7"
desc=toColorStringX(descColor,desc)
local speed=self.dialoguecfg.talkSpeed or _defaultTalkSpeed

if dialougeGroup==1 then
local func=function()
if self and not self.isClose then
self:talkFinish()
end
self.arrowShadow:setActive(true)
end
self.talking=true
self.talkdesc2:setChildTrendsTextPlay(desc,speed,func)
elseif dialougeGroup==2 then
local widget=self.pbObj:getChildWidgetBase()
widget:SetChildActive(1,false)
local func=function()
if self and not self.isClose then
self:talkFinish()

self.arrowShadow:setActive(true)
end
end
self.talking=true
widget:SetChildTrendsTextPlay(0,desc,speed,func)
end
end

function UIPlotComicWin:showTalk(dialougeGroup)

local dialougeSkin=self.dialoguecfg.dialougeSkin or 1
local dialougeinfo=dialougeSkinGroups[dialougeGroup][dialougeSkin]


self.talkframe:setCSImageSprite(dialougeinfo[2],dialougeinfo[1])

local name=self:getName()or''
local desc=self.dialoguecfg.dialogue or'未配置'
desc=gameplotModel:replaceName(desc,name)
local descColor=dialougeGroup==1 and"#171311"or"#f7f7f7"
desc=toColorStringX(descColor,desc)
local speed=self.dialoguecfg.talkSpeed or _defaultTalkSpeed
local func=function()
if self and not self.isClose then
self:talkFinish()
end
self.arrowShadow:setActive(true)
end

if self.dialoguecfg.broadcast~=nil then
gameplotController.doDialogueBroadcast(name,self.dialoguecfg.broadcast)
end
self.talking=true
self.talkdesc:setChildTrendsTextPlay(desc,speed,func)


end

function UIPlotComicWin:showModelTalk(changeSide)
local bodyid=nil
local components={}
local npcID=self.dialoguecfg.npcID
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
end

local sideObj=self:getSideObj(self.modelSide)
local sideWidget=sideObj:getChildWidgetBase()
sideObj:setChildCanvasGroupAlpha(1)


local showBody=bodyid~=nil
sideWidget:SetChildActive(0,showBody)
if showBody then
local modelParams={body=bodyid,componets=components}
local dbcfg=cfgHelper.get1(cfg_dbbodyconfig_get,bodyid)
modelParams.icon_head=dbcfg.icon_head


comHelper.setChildModelRawImageEx(0,sideWidget,modelParams,eHeadCenterType.eHead)
end

local name=self:getName()
sideWidget:SetChildText(1,name)



local desc=self.dialoguecfg.dialogue or'未配置'
desc=gameplotModel:replaceName(desc,name)
local speed=self.dialoguecfg.talkSpeed or _defaultTalkSpeed
local func=function()
if self and not self.isClose then
self:talkFinish()
end
end

if self.dialoguecfg.broadcast~=nil then
gameplotController.doDialogueBroadcast(name,self.dialoguecfg.broadcast)
end
self.talking=true
sideWidget:SetChildTrendsTextPlay(2,desc,speed,func)


end

function UIPlotComicWin:stopTalkPlay()
if self.dialoguecfg.side==2 then
local widget=self.pbObj:getChildWidgetBase()
widget:SetChildTrendsTextStop(0)
widget:SetChildActive(1,true)
else
local sideObj=self:getSideObj(self.modelSide)
local sideWidget=sideObj:getChildWidgetBase()
sideWidget:SetChildTrendsTextStop(2)
end
end


function UIPlotComicWin:getSideObj(side)
return side==0 and self.leftObj or self.rightObj
end

function UIPlotComicWin:checkFinalDialogue()
return self.dialogueIndex>=self.dialogueNum
end

function UIPlotComicWin:talkFinish()
self.talking=false

self:clearLookingTimer()
if not self:checkFinalDialogue()then
self:setLookingTimer()
else
self:changeNextTalkAnimation()
end
end

function UIPlotComicWin:setLookingTimer()
local func=function()
if _this==nil then return end
self:doNext()
self.lookingTimer=nil
end
if self.useUnscaledDeltaTime then
self.lookingTimer=Timer.New(func,lookingTime,1,false)
self.lookingTimer:Start()
else
self.lookingTimer=self:setTimer(lookingTime,1,func)
end
end

function UIPlotComicWin:clearLookingTimer()
if self.lookingTimer~=nil then
if self.useUnscaledDeltaTime then
self.lookingTimer:Stop()
else
self:stopTimerByID(self.lookingTimer)
end

self.lookingTimer=nil
end
end

function UIPlotComicWin:closeBefore()
if self.isFullOpen then
if fullScreenUI.isActiveFullEx(FULL_TYPE.eStoryBoard,'UIPlotComicWin')then
fullScreenUI.closeActiveUI()
end
else
UIManager:closeWindow('UIPlotComicWin')
end
end

function UIPlotComicWin:closeFullWin()
if self.isFullOpen then
fullScreenUI.closeActiveUI()
else
UIManager:closeWindow('UIPlotComicWin')
end
end

function UIPlotComicWin:changeNextTalkAnimation()

end

function UIPlotComicWin:getName()
local npcID=self.npcID or self.dialoguecfg.npcID
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

function UIPlotComicWin:showModel(changeSide,changenpc,oldnpcID)
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
playerImageController.setPlayerModel(self.winlua,self.modelImage:getID(),playertb,1,eAnimationID.idle,0,0,playerController:supportDynamic(),nil,true)
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





function UIPlotComicWin:onClickMaskBtn()
if self.isCanSkipTalk then
if not self.lockNext then
if self.talking then

self:stopTalkPlay()
self:talkFinish()
else
self.lockNext=true
self:clearLookingTimer()
self:doNext()
end
end
else
if(not self.talking)and(not self.lockNext)then
self.lockNext=true
self:clearLookingTimer()
self:doNext()
end
end

end



function UIPlotComicWin:onSkipBtn()

if self.talking then
self:stopTalkPlay()
self.talking=false
self:clearLookingTimer()
self:setLookingTimer()
else
self:clearLookingTimer()
end

local isFullOpen=self.isFullOpen
self.waitCloseSelfTimerId=self:delayDo(0.5,function()
if _this==nil then return end
_this:closeFullWin(isFullOpen)
end)


self:restoreBGM()

if self.groupcfg.imagePool~=nil then
plotBoardController:closeStage(self.groupid)
end

self:clearPlaySound()





local cb=self.callback
if cb~=nil then cb()end
end

function UIPlotComicWin:onBackClick()

end
