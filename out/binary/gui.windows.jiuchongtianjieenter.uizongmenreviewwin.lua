







def_class("UIZongMenReviewWin",UIWindowBase)









function UIZongMenReviewWin:bindComponents()

self.btn=UIButton.get(self,0)
self.content=UIObject.get(self,1)
self.downProgressItem=UIObject.get(self,2)
self.enterXianJieBtn=UIButton.get(self,3)
self.enterXianJieBtnClickEffect=UIObject.get(self,4)
self.enterXianJieBtnClickEffect2=UIObject.get(self,5)
self.enterXianJieBtnEffect=UIObject.get(self,6)
self.mainModel=UIObject.get(self,7)
self.mainModelParent=UIObject.get(self,8)
self.maskBtn=UIButton.get(self,9)
self.modelList=UIObject.get(self,10)
self.modelListParent=UIObject.get(self,11)
self.precent=UIText.get(self,12)
self.progress=UIProgressBarAni.get(self,13)
self.returnBtn=UIButton.get(self,14)
self.reviewList=UIObject.get(self,15)
self.Root=UIObject.get(self,16)
self.sceollView=UIObject.get(self,17)
self.scrollviewTips=UIObject.get(self,18)
self.shareBtn=UIButton.get(self,19)
self.skipBtn=UIButton.get(self,20)
self.spineBefore=UIObject.get(self,21)
self.spineBg=UIObject.get(self,22)
self.uiRoot=UIObject.get(self,23)

self.btn:setButtonClick(function()self:onBtn()end)

self.enterXianJieBtn:setButtonClick(function()self:onEnterXianJieBtn()end)

self.maskBtn:setButtonClick(function()self:onMaskBtn()end)

self.returnBtn:setButtonClick(function()self:onReturnBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)



end


function UIZongMenReviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btn);self.btn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.downProgressItem);self.downProgressItem=nil;
_UIObject_release(self.enterXianJieBtn);self.enterXianJieBtn=nil;
_UIObject_release(self.enterXianJieBtnClickEffect);self.enterXianJieBtnClickEffect=nil;
_UIObject_release(self.enterXianJieBtnClickEffect2);self.enterXianJieBtnClickEffect2=nil;
_UIObject_release(self.enterXianJieBtnEffect);self.enterXianJieBtnEffect=nil;
_UIObject_release(self.mainModel);self.mainModel=nil;
_UIObject_release(self.mainModelParent);self.mainModelParent=nil;
_UIObject_release(self.maskBtn);self.maskBtn=nil;
_UIObject_release(self.modelList);self.modelList=nil;
_UIObject_release(self.modelListParent);self.modelListParent=nil;
_UIObject_release(self.precent);self.precent=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.returnBtn);self.returnBtn=nil;
_UIObject_release(self.reviewList);self.reviewList=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.sceollView);self.sceollView=nil;
_UIObject_release(self.scrollviewTips);self.scrollviewTips=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.spineBefore);self.spineBefore=nil;
_UIObject_release(self.spineBg);self.spineBg=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this
local _gridWidth=364
local _gridListSpacing=160
local _modelFade=0.2
local _reviewStartPosX=1334
local _contentEndPadding=493

local _contentMoveSpeed=150
local _djDzStartPosAbs=600
local _baseScreenWidth=1334
local _endStartOffsetTime=10
local _hhWaitTime=10





function UIZongMenReviewWin:onLoaded(...)
self:bindComponents()
_this=self

local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
self.realWidth=UnityEngine.Screen.width/scaleFactor.x

self.modelEntList={}

self.isEnd=false

self.hhCount=0
self.showInfoContentIndex=0
self.reviewInfoAlpfaFadeDtList={}
end


function UIZongMenReviewWin:__delete()

self:stopAnimation()

if self.speakTimerId then
self:stopTimerByID(self.speakTimerId)
self.speakTimerId=nil
end

if self.returnAlhpaDt then
self.returnAlhpaDt:Complete()
self.returnAlhpaDt:Kill()
self.returnAlhpaDt=nil
end

_this=nil

JiuChongTianJieEnterController:endReview()

self:unbindComponents()
end




function UIZongMenReviewWin:onShow(argtable,afterOnloaded)

self.spineBg:setChildUIModelShowTarget(5730,1,nil,eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.winlua:SetChildUIModelAnimationSpeed(_this.spineBg:getID(),0.03)
end)

self.spineBefore:setChildUIModelShowTarget(5737,1,nil,eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.winlua:SetChildUIModelAnimationSpeed(_this.spineBefore:getID(),0.03)
end)

self.reviewList:setChildAnchoredPos(_reviewStartPosX,0)

self:delayDo(1,function()
if _this==nil then return end

self:prePrepareBtData()

_this.bt=behaviorManager:addBehaviorTree("bt_ui_zongmen_review",nil,true,self.btInitData,true)
_this.bt:setSharedVar("stageState",2)
end)

self.returnBtn:setChildCanvasGroupAlpha(0)
self.returnBtn:setActive(true)

self:showDownProgress()
end


function UIZongMenReviewWin:onHide()

end



function UIZongMenReviewWin:prePrepareBtData()
self.baseConfig=cfgHelper.get1(cfg_zongmenhuigubaseconfig_get,1)
self.dujieDisciple=JiuChongTianJieEnterController:getDuJieDisciple()
self.dujieDiscipleData=UIDiscipleModel:getDiscipleData(self.dujieDisciple)


local selectFunc=function(netData)
if _this==nil then return false end

if mathHelper.compareInt64(self.dujieDisciple,netData.discipleguid)then
return false
end

if table.findValue(self.baseConfig.plotDisIdList,netData.id)~=nil then
return false
end

return true
end

local selectFunc2=function(netData)
if _this==nil then return false end

if mathHelper.compareInt64(self.dujieDisciple,netData.discipleguid)then
return false
end

if table.findValue(self.baseConfig.plotDisIdList,netData.id)~=nil then
return true
end

return false
end

local sortFunc=function(a,b)
return a.fightvalue>b.fightvalue
end
self.discipleSortList=UIDiscipleModel:getSortList(selectFunc,sortFunc)
self.beforeDiscipleList=UIDiscipleModel:getSortList(selectFunc2,sortFunc)

self.discipleSortList=table.concatTable(self.beforeDiscipleList,self.discipleSortList)

self.curSwapIndex=0
self.modelLen=#(self.baseConfig.subDisShowList or{})
self.modelList:setChildLayoutGroupCreateItems(self.modelLen,function(index)
local item=self.modelList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(-1,false)
end)


self.swapDiscipleMoveDtList={}
self.speakContentIndex=0

local LookBacks=JiuChongTianJieEnterModel:getReviewBlocks(1)
self.LookBacks=LookBacks or{}
self.reviewLen=Mathf.Min(#self.LookBacks,self.baseConfig.maxReviewNum)

self.reviewListWidth=_gridWidth*self.reviewLen+((self.reviewLen-1)*_gridListSpacing)
self.contentWidth=self.reviewListWidth+_reviewStartPosX+_contentEndPadding
self.djDzMoveWidth=self.baseConfig.mainDisPos[2][1]-self.baseConfig.mainDisPos[1][1]

self.contentMoveDuration=(self.contentWidth-_baseScreenWidth)/_contentMoveSpeed
self.dzMoveSpeed=(_baseScreenWidth/2)/5
self.moveDzEndDuration=4

self.content:setChildSizeDelta(self.contentWidth,750)
self.reviewList:setChildSizeDelta(self.reviewListWidth,607)


self.reviewList:setChildLayoutGroupCreateItems(self.reviewLen,function(index)
if _this==nil then return end

local item=_this.reviewList:getChildLayoutGroupGridItem(index-1)
local data=_this.LookBacks[index]

item:SetChildText(0,FMT.fmt("N{0}Y",data.year))

item:SetChildText(1,data.content)
item:SetChildCanvasGroupAlpha(1,0)
end)

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.dujieDisciple)

self.btInitData={

widget=self.widget,


djDzModelIndex=self.mainModel:getID(),
djDzModelWidget=self.mainModel:getWidgetBase(),
djDzModelBody=modelParams.body,
djDzModelComponents=modelParams.componets,
djDzModelSize=1,
djDzFadeInTime=_modelFade,

djDzMountModelId=1110011,
djDzMountModelSlots={},
djDzMountModelHP=nil,
djDzMountModelSize=1.8,
djDzMountModelOffset={0,0},

djDzStartPos=self.baseConfig.mainDisPos[1],
djDzWaitPos=self.baseConfig.mainDisPos[2],
djDzEndPos=self.baseConfig.mainDisPos[3],
djDzMoveSpeed=self.dzMoveSpeed,


swapSubDiscipleInterval=self.baseConfig.showSubDisFrequency[1],


waitStartNeedTime=10,
modelListId=self.modelList:getID(),
moveDzEndPos={self.baseConfig.subDzListEndPos[1],self.baseConfig.subDzListEndPos[2]},
moveDzEndDuration=self.moveDzEndDuration,


contentID=self.content:getID(),
contentEndPos={-self.contentWidth,0},
contentMoveDuration=100,



waitEndStartTime=self.contentMoveDuration-self.moveDzEndDuration,
showEndBtnWaitTime=_hhWaitTime,


stageState=-1,
}

self.enterXianJieBtnEffect:setChildShowEffect(20500,true)
end


function UIZongMenReviewWin:swapnSubdisciple(bt)
local singleSwapNum=self.baseConfig.showSubDisFrequency[2]

local speakHudOffset=cfgHelper.get2(cfg_zongmenhuigubaseconfig_get,1,"speakHudOffset")

for index=1,singleSwapNum do
self.curSwapIndex=self.curSwapIndex+1
if self.curSwapIndex<=self.modelLen then
local disData=self.discipleSortList[self.curSwapIndex]

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(disData.discipleguid)

local orderIndex=self.baseConfig.stationSequence[self.curSwapIndex]


local item=self.modelList:getChildLayoutGroupGridItem(orderIndex-1)
item:SetChildActive(-1,true)

local showInfo=self.baseConfig.subDisShowList[self.curSwapIndex]
local scale=showInfo[3]or 1
item:SetChildUIModelShowTarget(2,modelParams.body,scale,modelParams.componets,eAnimationID.run,false,false,_modelFade)
item:SetChildUIModelShowFlipX(2,true)

item:SetChildAnchoredPos(0,speakHudOffset[1],speakHudOffset[2])


item:SetChildAnchoredPos(-1,-_djDzStartPosAbs,showInfo[2])

self.swapDiscipleMoveDtList[self.curSwapIndex]=item:SetChildDOAnchorPosX(-1,showInfo[1],3,function()
if item==nil then return end
item:SetChildModelAnimationState(2,eAnimationID.walk,1)
end)
end
end
end

function UIZongMenReviewWin:playAllSubDiscipleAninmation()
local grids=self.modelList:getChildLayoutGroupGridList()
self.hhCount=self.hhCount+1
if self.hhCount>3 then
self:rankSubDiscipleSpeak()
self:btEndOpration()
return
end
for index=1,grids.Count do
local item=grids[index-1]
local callback
if index==grids.Count then

callback=function()
self:playAllSubDiscipleAninmation()
self.maskBtn:setActive(false)
end
end
item:SetChildModelAnimationState(2,2067,1,callback)
end
end

function UIZongMenReviewWin:rankSubDiscipleSpeak()

local intervalTime=Mathf.Random(self.baseConfig.speakFrequency[1],self.baseConfig.speakFrequency[2])
local duration=self.baseConfig.speakFrequency[3]

local line1List={}
local line2List={}
for index,id in ipairs(self.baseConfig.stationSequence)do
local val=index%2
if val==0 then
line1List[#line1List+1]=id
elseif val==1 then
line2List[#line2List+1]=id
end
end

self.useLine1=false

local updateFunc=function()
if _this==nil then return end

local rankIndex
if _this.useLine1 then
rankIndex=table.randomIndex(line1List)
else
rankIndex=table.randomIndex(line2List)
end

_this.useLine1=not _this.useLine1

local item=_this.modelList:getChildLayoutGroupGridItem(rankIndex-1)
local itemWidget=item:GetChildWidgetBase(-1)

_this.speakContentIndex=_this.speakContentIndex+1
local speakIndex=_this.speakContentIndex%#_this.baseConfig.speakContentList+1
local content=_this.baseConfig.speakContentList[speakIndex]

itemWidget:SetChildActive(0,true)
itemWidget:SetChildText(1,content)
_this:delayDo(duration,function()
if _this==nil then return end
itemWidget:SetChildActive(0,false)
end)
end


self.speakTimerId=self:setTimer(intervalTime,0,updateFunc)
updateFunc()
end

function UIZongMenReviewWin:btEndOpration()
self.scrollviewTips:setActive(true)
self.enterXianJieBtn:setActive(true)



self.winlua:SetChildUIModelAnimationSpeed(self.spineBg:getID(),0)
self.winlua:SetChildUIModelAnimationSpeed(self.spineBefore:getID(),0)

local modelListParentTransform=self.modelListParent:getTransform()
local modelListTransform=self.modelList:getTransform()
modelListTransform:SetParent(modelListParentTransform)

local mainModelParentTransform=self.mainModelParent:getTransform()
local mainModelTransform=self.mainModel:getTransform()
mainModelTransform:SetParent(mainModelParentTransform)

self.isEnd=true
end

function UIZongMenReviewWin:autoMoveToPosition()
if self.contentMoveDt then
self.contentMoveDt:Complete()
self.contentMoveDt:Kill()
self.contentMoveDt=nil
end

self.contentMoveDt=self.content:setChildDOAnchorPosX(-(self.contentWidth-_baseScreenWidth),self.contentMoveDuration,function()
if _this==nil then return end
_this.winlua:SetChildUIModelAnimationSpeed(_this.spineBg:getID(),0)
end)
self.contentMoveDt:SetEase(DG.Tweening.Ease.Linear)
end

function UIZongMenReviewWin:moveModelList()
if self.modelListMoveDt then
self.modelListMoveDt:Complete()
self.modelListMoveDt:Kill()
self.modelListMoveDt=nil
end

self.modelListMoveDt=self.modelList:setChildDOAnchorPosX(0,self.moveDzEndDuration,function()
if _this==nil then return end
_this:playAllSubDiscipleAninmation()
end)
self.modelListMoveDt:SetEase(DG.Tweening.Ease.Linear)
end


function UIZongMenReviewWin:onSCrollViewChange()
local pos=self.content:getChildAnchoredPosition()
if self.isEnd then

local isShow=pos.x>-(self.contentWidth-self.realWidth-self.realWidth/2)

if self.returnAlhpaDt then
self.returnAlhpaDt:Complete()
self.returnAlhpaDt:Kill()
self.returnAlhpaDt=nil
end

local alphaVal=isShow and 1 or 0
self.returnAlhpaDt=self.returnBtn:setChildCanvasGroupDOFade(alphaVal,0.5)

self.scrollviewTips:setActive(false)

local dvalue=pos.x+self.contentWidth
local bgModelVal=dvalue*0.03
self.spineBg:setChildAnchoredPos(bgModelVal,0)
else
local posx=-pos.x
local syWidth=posx%(_gridWidth+_gridListSpacing)
local showIndex=Mathf.Floor(posx/(_gridWidth+_gridListSpacing))
if self.showInfoContentIndex==showIndex and syWidth>=(_gridWidth+_gridListSpacing)*0.3 and self.showInfoContentIndex<self.reviewLen then
local item=self.reviewList:getChildLayoutGroupGridItem(self.showInfoContentIndex)
self.showInfoContentIndex=self.showInfoContentIndex+1
self.reviewInfoAlpfaFadeDtList[self.showInfoContentIndex]=item:SetChildCanvasGroupDOFade(1,1,1)
end
end
end


function UIZongMenReviewWin:stopAnimation()
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end

if self.contentMoveDt then
self.contentMoveDt:Complete()
self.contentMoveDt:Kill()
self.contentMoveDt=nil
end

if self.modelListMoveDt then
self.modelListMoveDt:Complete()
self.modelListMoveDt:Kill()
self.modelListMoveDt=nil
end

if self.swapDiscipleMoveDtList then
for index,bt in pairs(self.swapDiscipleMoveDtList)do
bt:Complete()
bt:Kill()
end
self.swapDiscipleMoveDtList={}
end


for index,bt in pairs(self.reviewInfoAlpfaFadeDtList)do
bt:Complete()
bt:Kill()
end
self.swapDiscipleMoveDtList={}
end

function UIZongMenReviewWin:refreshShareRewardShow()

end





function UIZongMenReviewWin:onEnterXianJieBtn()
AudioManager.stopBGMusic()
AudioManager.playAudio(1027)
self.enterXianJieBtnClickEffect:setChildShowEffect(20501,true)
self.enterXianJieBtnClickEffect2:setChildShowEffect(20502,true)

if downloadAssetWithFileManager:stratDownLoad(LOAD_ASSET_TYPE.xianjie,true)then
return
end

self:delayDo(2,function()
JiuChongTianJieEnterController:finishDujieAnimation()






end)
end



function UIZongMenReviewWin:onReturnBtn()
if self.quickMoveContentDt then
self.quickMoveContentDt:Complete()
self.quickMoveContentDt:Kill()
self.quickMoveContentDt=nil
end

if self.spineBgMoveDt then
self.spineBgMoveDt:Complete()
self.spineBgMoveDt:Kill()
self.spineBgMoveDt=nil
end

self.quickMoveContentDt=self.content:setChildDOAnchorPosX(-(self.contentWidth-_baseScreenWidth),0.2)
self.quickMoveContentDt:SetEase(DG.Tweening.Ease.Linear)
self.spineBgMoveDt=self.spineBg:setChildDOAnchorPosX(0,0.2)
self.spineBgMoveDt:SetEase(DG.Tweening.Ease.Linear)

end



function UIZongMenReviewWin:onShareBtn()
local shareShowType=shareImageModel:getShareShowTypeByWinName(self.window_name)
local param={
disciple_guid=self.dujieDisciple,
}
shareImageController:showShareImageWin(shareShowType,param)
end

function UIZongMenReviewWin:onMaskBtn()
if self.isEnd then
return
end
self.skipBtn:setActive(true)
end

function UIZongMenReviewWin:onSkipBtn()
for index=1,Mathf.Ceil(self.modelLen/2)do
self:swapnSubdisciple()
end
self:stopAnimation()

self.isEnd=true

for index=1,self.reviewLen do
local item=self.reviewList:getChildLayoutGroupGridItem(index-1)
item:SetChildCanvasGroupAlpha(1,1)
end

self:delayDo(0.5,function()
if _this==nil then return end
_this:playAllSubDiscipleAninmation()
_this.scrollviewTips:setActive(true)
_this.enterXianJieBtn:setActive(true)
end)
self.mainModel:setChildAnchoredPos(self.baseConfig.mainDisPos[3][1],self.baseConfig.mainDisPos[3][2])
self.modelList:setChildAnchoredPos(0,self.baseConfig.subDzListEndPos[2])

local modelListParentTransform=self.modelListParent:getTransform()
local modelListTransform=self.modelList:getTransform()
modelListTransform:SetParent(modelListParentTransform)

local mainModelParentTransform=self.mainModelParent:getTransform()
local mainModelTransform=self.mainModel:getTransform()
mainModelTransform:SetParent(mainModelParentTransform)

self.skipBtn:setActive(false)
end

function UIZongMenReviewWin:showShare()
self.shareBtn:setActive(true)
end

function UIZongMenReviewWin:testEnterEffect()
self.enterXianJieBtnClickEffect:setChildShowEffect(20501,true)
self.enterXianJieBtnClickEffect2:setChildShowEffect(20502,true)
end

function UIZongMenReviewWin:onBtn()
downloadAssetWithFileManager:stratDownLoad(LOAD_ASSET_TYPE.xianjie,true)
end

function UIZongMenReviewWin:showDownProgress()
local isLoading=downloadAssetWithFileManager:isDownLoadingAsset(LOAD_ASSET_TYPE.xianjie)
self.downProgressItem:setActive(isLoading)
if isLoading then
local downSize,totalSize=downloadAssetWithFileManager:getProgress()
local progress=downSize/totalSize
local value=math.floor(100*progress)
self.precent:setText(FMT.fmt('{0}%',math.floor(progress*100)))
self.progress:animateThreeParams(value,100,0.2)
end
end

function UIZongMenReviewWin:refreshProgress(fileGroupid,downSize,totalSize)

if fileGroupid==LOAD_ASSET_TYPE.xianjie then
local progress=downSize/totalSize
local value=math.floor(100*progress)
self.precent:setText(FMT.fmt('{0}%',math.floor(progress*100)))
self.progress:animateThreeParams(value,100,0.2)
end
end
