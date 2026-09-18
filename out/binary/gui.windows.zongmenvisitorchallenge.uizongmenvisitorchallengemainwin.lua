







def_class("UIZongMenVisitorChallengeMainWin",UIWindowBase)









function UIZongMenVisitorChallengeMainWin:bindComponents()

self.finishTargetConditionList=UIObject.get(self,0)
self.spinebg=UIObject.get(self,1)
self.enterEffect=UIObject.get(self,2)
self.uiRoot=UIObject.get(self,3)
self.closeRoot=UIObject.get(self,4)
self.txlist=UIObject.get(self,5)
self.progress=UIProgressBarAni.get(self,6)
self.finishLevelInfo=UIText.get(self,7)
self.finishRewardReddot=UIObject.get(self,8)
self.finishRewardItem=UIBaseItem.get(self,9)
self.Root=UIObject.get(self,10)
self.beforeSpine=UIObject.get(self,11)
self.jinduRoot=UIObject.get(self,12)
self.rightRoot=UIObject.get(self,13)
self.midRoot=UIObject.get(self,14)
self.fightRoot=UIObject.get(self,15)
self.rewardRoot=UIObject.get(self,16)
self.monsterModel=UIObject.get(self,17)
self.monsterInfoRoot=UIObject.get(self,18)
self.jinduScrollview=UIObject.get(self,19)
self.finishTargetRoot=UIObject.get(self,20)
self.monsterTxRoot=UIObject.get(self,21)
self.finishLevelInfoBtn=UIButton.get(self,22)
self.finishRewardBoxRoot=UIObject.get(self,23)
self.firstFinishRoot=UIObject.get(self,24)
self.curLevelRewardRoot=UIObject.get(self,25)
self.fightBtn=UIButton.get(self,26)
self.fightFinishImg=UIObject.get(self,27)
self.monsterNameBg=UIObject.get(self,28)
self.monsterJJNameBg=UIObject.get(self,29)
self.fightSpineBtn=UIObject.get(self,30)
self.curRewardBox=UIButton.get(self,31)
self.curRewardList=UIObject.get(self,32)
self.firstFinishInfoBg=UIObject.get(self,33)
self.firstFinishPlayerName=UIText.get(self,34)
self.firstFinishPlayerHead=UIObject.get(self,35)
self.firstFinishDefaultHead=UIObject.get(self,36)
self.monsterName=UIText.get(self,37)
self.monsterJingjie=UIText.get(self,38)
self.rewardStateImg=UIImage.get(self,39)
self.bar=UIObject.get(self,40)
self.selectText=UIText.get(self,41)
self.closeBtn=UIButton.get(self,42)
self.levelList=UIObject.get(self,43)

self.finishLevelInfoBtn:setButtonClick(function()self:onFinishLevelInfoBtn()end)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.curRewardBox:setButtonClick(function()self:onCurRewardBox()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIZongMenVisitorChallengeMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.finishTargetConditionList);self.finishTargetConditionList=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.enterEffect);self.enterEffect=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.closeRoot);self.closeRoot=nil;
_UIObject_release(self.txlist);self.txlist=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.finishLevelInfo);self.finishLevelInfo=nil;
_UIObject_release(self.finishRewardReddot);self.finishRewardReddot=nil;
_UIObject_release(self.finishRewardItem);self.finishRewardItem=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.beforeSpine);self.beforeSpine=nil;
_UIObject_release(self.jinduRoot);self.jinduRoot=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.midRoot);self.midRoot=nil;
_UIObject_release(self.fightRoot);self.fightRoot=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.monsterModel);self.monsterModel=nil;
_UIObject_release(self.monsterInfoRoot);self.monsterInfoRoot=nil;
_UIObject_release(self.jinduScrollview);self.jinduScrollview=nil;
_UIObject_release(self.finishTargetRoot);self.finishTargetRoot=nil;
_UIObject_release(self.monsterTxRoot);self.monsterTxRoot=nil;
_UIObject_release(self.finishLevelInfoBtn);self.finishLevelInfoBtn=nil;
_UIObject_release(self.finishRewardBoxRoot);self.finishRewardBoxRoot=nil;
_UIObject_release(self.firstFinishRoot);self.firstFinishRoot=nil;
_UIObject_release(self.curLevelRewardRoot);self.curLevelRewardRoot=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.fightFinishImg);self.fightFinishImg=nil;
_UIObject_release(self.monsterNameBg);self.monsterNameBg=nil;
_UIObject_release(self.monsterJJNameBg);self.monsterJJNameBg=nil;
_UIObject_release(self.fightSpineBtn);self.fightSpineBtn=nil;
_UIObject_release(self.curRewardBox);self.curRewardBox=nil;
_UIObject_release(self.curRewardList);self.curRewardList=nil;
_UIObject_release(self.firstFinishInfoBg);self.firstFinishInfoBg=nil;
_UIObject_release(self.firstFinishPlayerName);self.firstFinishPlayerName=nil;
_UIObject_release(self.firstFinishPlayerHead);self.firstFinishPlayerHead=nil;
_UIObject_release(self.firstFinishDefaultHead);self.firstFinishDefaultHead=nil;
_UIObject_release(self.monsterName);self.monsterName=nil;
_UIObject_release(self.monsterJingjie);self.monsterJingjie=nil;
_UIObject_release(self.rewardStateImg);self.rewardStateImg=nil;
_UIObject_release(self.bar);self.bar=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.levelList);self.levelList=nil;
end
















local _this

local CmpLevelItemIndex={
bg=0,
levelname=1,
icon=2,
selectimg=3,
lock=4,
reddot=5,
okimg=6,
}

local CmpFinishTargetItemIndex={
icon=0,
info=1,
okImg=2,
}

local _ab='ui/windows/zongmenvisitorchallenge/zongmenvisitorchallenge_atlas_pak.ab'

local conditionIconList={
'image_fangkeshilian_9',
'image_fangkeshilian_10',
}

local levelIconList={
'icon_fangkeshilian_01',
'icon_fangkeshilian_02',
'icon_fangkeshilian_03',
}

local boxIconList={
'image_fangkeshilian_05',
'image_fangkeshilian_06',
}

local fightSpineBtnResList={
3053,3054
}




function UIZongMenVisitorChallengeMainWin:onLoaded(...)
self:bindComponents()

_this=self
end


function UIZongMenVisitorChallengeMainWin:__delete()
if self.speakBt then
behaviorManager:removeBehaviorTree(self.speakBt)
self.speakBt=nil
end

self:unbindComponents()

_this=nil

end




function UIZongMenVisitorChallengeMainWin:onShow(argtable,afterOnloaded)
self.challengeId=zmvisitchallengeModel:getOpenChallengeId()
local totalChallengeLevelNum=zmvisitchallengeConfig.getChallengeMaxNum(self.challengeId)
self.selectLevelIndex=zmvisitchallengeModel:getCurrentLevel()+1
self.selectLevelIndex=Mathf.Min(totalChallengeLevelNum,self.selectLevelIndex)
local titleName=cfgHelper.get2(cfg_visitorchallengeconfig_get,self.challengeId,'name')
self.selectText:setText(titleName)

self:refreshAll()
end

function UIZongMenVisitorChallengeMainWin:onShowArgRecv(args)
self:onShow(args)
end



function UIZongMenVisitorChallengeMainWin:onHide()
end

function UIZongMenVisitorChallengeMainWin:refreshAll()
self:refreshProgress()

self:refreshMidPart()

self:refreshRewardPart()

self:refreshRightPart()

self:refreshFightPart()
end

function UIZongMenVisitorChallengeMainWin:refreshProgress()
local allLevelCfg=cfgHelper.get1(cfg_visitorchallengelayerconfig_get,self.challengeId)
local curLevel=zmvisitchallengeModel:getCurrentLevel()
local levelLen=#allLevelCfg






self.levelList:setChildLayoutGroupCreateItems(levelLen,function(index)
local item=self.levelList:getChildLayoutGroupGridItem(index-1)
local levelCfg=allLevelCfg[index]

item:SetChildActive(-1,levelCfg~=nil)
if levelCfg then
local isReceived=zmvisitchallengeModel:checkChallengeFinishByLevelId(index)
local isLock=index>curLevel+1


item:SetChildText(CmpLevelItemIndex.levelname,FMT.fmt('第{0}关',index))


local levelIconType=levelCfg.icon
local levelIconName=levelIconList[levelIconType]
item:SetChildCSImageSprite(CmpLevelItemIndex.icon,_ab,levelIconName)
item:SetChildGray(CmpLevelItemIndex.icon,curLevel>=index)


item:SetChildActive(CmpLevelItemIndex.selectimg,self.selectLevelIndex==index)


item:SetChildActive(CmpLevelItemIndex.lock,isLock)


local isShowReddot=(curLevel>=index)and not isReceived
item:SetChildActive(CmpLevelItemIndex.reddot,isShowReddot)
_this:doPunchRotation(item,CmpLevelItemIndex.reddot,index,isShowReddot)


local isFinish=curLevel>=index
item:SetChildActive(CmpLevelItemIndex.okimg,isFinish)


item:SetBaseItemClickEvent(-1,function()
if isLock then
UIManager.info(FMT.fmt('通关第{0}关解锁',index-1))
else
local preItem=_this.levelList:getChildLayoutGroupGridItem(_this.selectLevelIndex-1)
preItem:SetChildActive(CmpLevelItemIndex.selectimg,false)

_this.selectLevelIndex=index
item:SetChildActive(CmpLevelItemIndex.selectimg,true)

_this:refreshMidPart()
_this:refreshRewardPart()
_this:refreshRightPart()
_this:refreshFightPart()
end
end)
end
end)


local llWidth=levelLen*133+(levelLen-1)*30+133
local psWidth=llWidth-100
local totalChallengeLevelNum=zmvisitchallengeConfig.getChallengeMaxNum(self.challengeId)
local level=zmvisitchallengeModel:getCurrentLevel()+1
local prelevel=Mathf.Min(totalChallengeLevelNum,level)
local percent=prelevel/levelLen

self.bar:setChildSizeDelta(psWidth*percent,9)
self.jinduScrollview:setChildScrollRectEnable(levelLen>7)
end

function UIZongMenVisitorChallengeMainWin:refreshMidPart()

local levelCfg=cfgHelper.get2(cfg_visitorchallengelayerconfig_get,self.challengeId,self.selectLevelIndex)

local groupID=levelCfg.mon_id
local groupCfg=cfgHelper.get1(cfg_monstergroup_get,groupID)



local npcid=cfgHelper.get2(cfg_visitorchallengeconfig_get,self.challengeId,'npcid')
local imagecfg=npcModel:getNPCImageCfg(npcid)
self.monsterModel:setChildUIModelRemoveTarget()
local modelParams=npcModel:getImageInfo(imagecfg.id)
comHelper.setChildInSideModelEx(self.monsterModel,modelParams,0.75,0,0,0,false,true)

local npcName=npcModel:getName(imagecfg.id)
self.monsterName:setText(self:transLineStr(npcName))



local jjName=UIDiscipleModel.getJJNameCommon(levelCfg.showmonsterlevel,3)

local mjjName=FMT.fmt("{0}",jjName)
self.monsterJingjie:setText(self:transLineStr(mjjName))


local skillList=cfgHelper.get2(cfg_monstergroup_get,groupID,"showSkills")or{}
self.txlist:setChildLayoutGroupCreateItems(#skillList,function(index)
local skillItem=self.txlist:getChildLayoutGroupGridItem(index-1)
local skillData=skillList[index]
local skillID=skillData[1]
local skillLv=skillData[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
skillItem:SetChildActive(-1,true)

skillItem:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
skillItem:SetChildActive(1,is_bd)

skillItem:SetChildButtonClick(3,function()

local pos=skillItem:GetChildUIScreenPos(-1,false)
pos=self:getChildUIScreenPos2Local(-1,pos)

local x=pos.x
local y=pos.y
local center=Vector2.one*0.5
local leftBottom=Vector2.zero
local args={
skillId=skillID,
skillLv=skillLv,
rootPoint={
anchorsMin=center,
anchorsMax=center,
pivot=leftBottom,
anchoredPosition=Vector2.New(x,y)
}
}
UIManager:showWindow('UISimpleSkillTipsWin',args)
end)
end)

self:modelSpeak()
end

function UIZongMenVisitorChallengeMainWin:refreshRewardPart()

local challengeCfg=cfgHelper.get1(cfg_visitorchallengeconfig_get,self.challengeId)

local allLevelCfg=cfgHelper.get1(cfg_visitorchallengelayerconfig_get,self.challengeId)

local totalLen=#allLevelCfg

local curLevel=zmvisitchallengeModel:getCurrentLevel()


local finishRewardId=challengeCfg.finishreward[1][1]
local finishRewardNum=challengeCfg.finishreward[1][2]
local finishRewardNumStr=challengeCfg.finishreward[1][2]>0 and challengeCfg.finishreward[1][2]or""
local finishGray=zmvisitchallengeModel:getBigRewardFlag()
local conf={itemid=finishRewardId,itemcount=finishRewardNumStr,showCountBG=finishRewardNum>1,showname=false,showStage=true,gray=finishGray,}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)
self.finishRewardItem:setChildPropData(propData)
self.finishRewardItem:setBaseItemClickEvent(function(...)
if zmvisitchallengeModel:checkFinishAllLevel()and zmvisitchallengeModel:getBigRewardFlag()==0 then

zmvisitchallengeController:req_25_31()
else
itemsComponentHelper.onItemClickEx(...)
end
end)

local isNonReceiveBigReward=zmvisitchallengeModel:getBigRewardFlag()==0
local isShowBigRewardReddot=curLevel==totalLen and isNonReceiveBigReward
self.finishLevelInfo:setText(FMT.fmt("通关所有试炼\n<color=#549327>({0}/{1})</color>",curLevel,totalLen))
self.finishRewardReddot:setActive(isShowBigRewardReddot)
self:doPunchRotation(self.winlua,self.finishRewardReddot:getID(),10000,isShowBigRewardReddot)


local levelCfg=allLevelCfg[self.selectLevelIndex]
local isReceived=zmvisitchallengeModel:isChallengeFinish(self.selectLevelIndex)

local dropData=zongmenControl:getRewardConfigData(levelCfg.layer_drop_id,zongmenModel:getLevel())

self.curRewardList:setChildLayoutGroupCreateItems(#dropData,function(index)
local rewardItem=self.curRewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=dropData[index]

local itemid=rewardData[1]
local itemnum=rewardData[2]or 0
local range=rewardData.range
local gray=isReceived and 1 or 0

local conf={
itemid=itemid,
itemcount=itemnum>-1 and mathHelper.formatNumber(itemnum)or'',
showCountBG=itemnum>-1 or range~=nil,
showname=false,
range=range,
gray=gray,
}
local propData=itemsComponentHelper.getCommonFillDataSmall(conf)

rewardItem:SetChildPropData(-1,propData)
rewardItem:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end)

local rewardBoxIconName
if isReceived then
rewardBoxIconName=boxIconList[2]
else
rewardBoxIconName=boxIconList[1]
end
self.rewardStateImg:setCSImageSprite(_ab,rewardBoxIconName)
end

function UIZongMenVisitorChallengeMainWin:refreshRightPart()

local levelCfg=cfgHelper.get2(cfg_visitorchallengelayerconfig_get,self.challengeId,self.selectLevelIndex)

local conditionStrlist=levelCfg.targettrlist or{}

local levelState=zmvisitchallengeModel:checkChallengeFinishByLevelId(self.selectLevelIndex)

self.finishTargetConditionList:setChildLayoutGroupCreateItems(#conditionStrlist,function(index)
local tItem=self.finishTargetConditionList:getChildLayoutGroupGridItem(index-1)
local condition=conditionStrlist[index]
local conditionStr=condition[1]
local iconType=condition[2]
local iconName=conditionIconList[iconType]

tItem:SetChildCSImageSprite(CmpFinishTargetItemIndex.icon,_ab,iconName)
tItem:SetChildText(CmpFinishTargetItemIndex.info,conditionStr)
tItem:SetChildActive(CmpFinishTargetItemIndex.okImg,levelState)

tItem:ForceLayoutRect(-1)
end)


self.firstFinishRoot:setActive(false)
self.finishLevelInfoBtn:setActive(false)











end

function UIZongMenVisitorChallengeMainWin:refreshFightPart()
local levelState=zmvisitchallengeModel:checkChallengeFinishByLevelId(self.selectLevelIndex)

local stateIndex=levelState and 2 or 1
local spineId=fightSpineBtnResList[stateIndex]
self.fightSpineBtn:setChildUIModelShowTarget(spineId,1,{},eAnimationID.stand,false,false,0.2,nil)


end



function UIZongMenVisitorChallengeMainWin:modelSpeak()
if self.speakBt then
behaviorManager:removeBehaviorTree(self.speakBt)
end


local initData={
widget=self.midRoot:getWidgetBase(),
speakOffset={-75,100},
speakDuration=5,
level=self.selectLevelIndex
}
self.speakBt=behaviorManager:addBehaviorTree('bt_ui_zmvc_speak',{},true,initData)
end






function UIZongMenVisitorChallengeMainWin:onFinishLevelInfoBtn()
end



function UIZongMenVisitorChallengeMainWin:onFightBtn()




zmvisitchallengeController:showPrepareWin(self.challengeId,self.selectLevelIndex)
end



function UIZongMenVisitorChallengeMainWin:onCloseBtn()
self.closeBtn:setActive(false)
UIFullZMVisitChallengeControl:closeUI()

if zmvisitchallengeModel:checkFinishAllLevel()and zmvisitchallengeModel:getBigRewardFlag()==1 then
zmvisitchallengeController:showEndByChallengeId(true)
end
end

function UIZongMenVisitorChallengeMainWin:onCurRewardBox()
local state=zmvisitchallengeModel:isChallengeFinish(self.selectLevelIndex)
if not state then
UIManager.info('通过本关后获得')
end
end


function UIZongMenVisitorChallengeMainWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UIZongMenVisitorChallengeMainWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end

function UIZongMenVisitorChallengeMainWin:transLineStr(str)
if pfwindowslController:checkIsGameVersion_yuenan()then
return str
else
local result=string.toTable(str)

local temp=result[1]
for i=2,#result do
temp=FMT.fmt("{0}\n{1}",temp,result[i])
end
return temp
end
end

