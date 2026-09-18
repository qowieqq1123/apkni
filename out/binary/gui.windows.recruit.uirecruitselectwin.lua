







def_class("UIRecruitSelectWin",UIWindowBase)









function UIRecruitSelectWin:bindComponents()

self.root=UIObject.get(self,0)
self.scrollview=UIObject.get(self,1)
self.other=UIObject.get(self,2)
self.LBtips=UIObject.get(self,3)
self.showEffect=UIObject.get(self,4)
self.effect1=UIObject.get(self,5)
self.Text=UIText.get(self,6)
self.recrultBtn=UIButton.get(self,7)
self.desc=UIText.get(self,8)
self.icon=UIImage.get(self,9)
self.tips=UIText.get(self,10)
self.guarantTipsText=UIText.get(self,11)
self.guarantTips=UIObject.get(self,12)
self.tipsBtn=UIButton.get(self,13)

self.recrultBtn:setButtonClick(function()self:onRecrultBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)



end


function UIRecruitSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.other);self.other=nil;
_UIObject_release(self.LBtips);self.LBtips=nil;
_UIObject_release(self.showEffect);self.showEffect=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.recrultBtn);self.recrultBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.guarantTipsText);self.guarantTipsText=nil;
_UIObject_release(self.guarantTips);self.guarantTips=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
end
















local _this

local effectCX={[3]=10015,[4]=10016,[5]=10017}
local audioCX={[5]=613}
local effectZM={[3]=10018,[4]=10019,[5]=10020}
local enterEffects={[2]=10055,[3]=10056,[4]=10057,[5]=10058}
local enterAudio={[3]=609,[4]=610,[5]=611}
local delayTimes={[2]=1,[3]=1,[4]=2.5,[5]=2.5}
local pinzi={"平庸","出众","傲人","绝伦","逆天","逆天"}



function UIRecruitSelectWin:onLoaded(...)
self:bindComponents()

_this=self

self.tweeners={}
self.tweenerVal={}

self.recruitItemTweener={}
self.tzrecruitItemTweener={}
self.sperecruitItemTweener={}

self.timerDatas={}

self.tzlistTime=0.3

self.effects={[3]={10082,10083,10084},[1]={10083}}

self.abName='ui/windows/recruit/sharedtextures/yinxiantai_new.ab'
self.globalAB='ui/sharedtextures/uiglobalspriteatlas_1.ab'
self.iconName={[-2]='icon_tyshijian',[-1]='icon_dizidengdai',[1]='icon_zhaomujuan'}
self.speakSkin={'frame_duihuaqipaokuang_1','frame_duihuaqipaokuang_2'}

self.scrollview:setChildScrollViewInit(1,true,nil,nil)

self.root:setChildCanvasGroupAlpha(0)

self:addNotify(notifyConfig.on_item_list_changed,function(...)self:on_item_list_changed(...)end)
end


function UIRecruitSelectWin:__delete()
self:unbindComponents()

_this=nil
roleAudioController:stopRoleSpeak()
UIManager:invokeUIMethod('UIRecruitMainWin','playAnimation',0)
UIManager:invokeUIMethod('UIRecruitMainWin','Refresh')
UIManager:invokeUIMethod('UIRecruitJZWin','resetDzSpeak')
if self.delayShowAnimationTimer~=nil then
self.delayShowAnimationTimer:cancel()
self.delayShowAnimationTimer=nil
end
for k,v in pairs(self.tweeners)do
v:Kill()
end

for k,v in pairs(self.recruitItemTweener)do
v:Kill()
end

for k,v in pairs(self.tzrecruitItemTweener)do
v:Kill()
end

for k,v in pairs(self.sperecruitItemTweener)do
v:Kill()
end

if self.closeCallback then
self.closeCallback()
end
end




function UIRecruitSelectWin:onShow(argtable,afterOnloaded)
self:resetShowArgs(argtable)
local showAnim=argtable.showAnim
self:Refresh(showAnim)
end

function UIRecruitSelectWin:resetShowArgs(argtable)
self.showList=argtable.showList
self.infoList=argtable.infoList
self.specialItem=argtable.specialItem
self.showOnly=argtable.showOnly
self.closeCallback=argtable.closeCallback
if argtable.showDetail~=nil then
self.showDetail=argtable.showDetail
else
self.showDetail=true
end
self.mode=1
if self.showList then
self.mode=self.specialItem and 3 or 2
end
self.tipsBR=argtable.tipsBR
end

function UIRecruitSelectWin:Refresh(showAnimation)
self:clearSpeakTimer()
if self.mode==1 then
local count=UIRecruitModel:getRecruitDiscipleCount()
if count<=0 then
self:onClickClose()
return
end
end
self:RefreshTimes()
self:RefreshDisciple(showAnimation)
self:RefreshBottomRightTipsStr()
self:RefreshGuarantTipsStr(self.mode==1)
end

function UIRecruitSelectWin:SetRecruitState(guid,state)
for i,v in ipairs(self.dispicles)do
if tostring(v.discipleInfo.discipleguid)==tostring(guid)then
local item=self.scrollview:getChildScrollViewItemWidget(i-1)
local showReceived=self.mode~=3
if state~=nil then
v.state=state
end
local check1=v.state==0
local check2=v.state==1
local check3=v.state==-1
item:SetChildActive(3,check1)
item:SetChildActive(4,check1)
item:SetChildActive(7,check2)
item:SetChildActive(9,check3 and showReceived)
item:SetChildActive(24,check2 and not showReceived)
item:SetChildActive(25,check3 and not showReceived)

local speakTexts=self:getSpeakTexts(v.discipleInfo,check2 and'recruit'or'refuse')
self:playSpeakText(item,speakTexts[math.random(1,#speakTexts)],check2 and 1 or 2)

if check2 then
item:SetChildModelAnimationState(1,eAnimationID.ui_jump1)
self:setTimer(1,1,function()
item:SetChildModelAnimationState(1,eAnimationID.ui_jump1)
end)
end
break
end
end
end

function UIRecruitSelectWin:getSpeakTexts(ddata,stype)
local texts=cfgHelper.get2(cfg_yinxiantaispeakconfig_get,ddata.imageInfo.job,stype)
return texts[ddata.imageInfo.sex]or{'...'}
end

function UIRecruitSelectWin:RandomSpeak(pcount,time)
local items=self.scrollview:getChildScrollViewItemWidgets()
local notes={}
local len=math.min(3,#self.dispicles)
for i=1,len do
local data=self.dispicles[i]
if data.state==0 then
table.insert(notes,{items[i-1],data.discipleInfo})
end
end
local nc=#notes
if nc<1 then
return
end
local rc={}
for i=1,pcount do
local index=math.random(1,nc)
if not rc[index]then
rc[index]=true
local sd=notes[index]
local item=sd[1]
local speakTexts=self:getSpeakTexts(sd[2],'idle')
local text=speakTexts[math.random(1,#speakTexts)]
self:playSpeakText(item,text,1)
end
end
self:clearSpeakTimer()
self.speakTimer=self:setTimer(time,1,function()
self:RandomSpeak(1,math.random(5,8))
end)
end

function UIRecruitSelectWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end
end

function UIRecruitSelectWin:playSpeakText(item,text,skin)
item:SetChildCSImageSprite(12,self.globalAB,self.speakSkin[skin])
item:SetChildText(11,chatEmotHelper.decodeEmot(text))
item:SetChildCanvasGroupAlpha(10,1)
local tweener=item:SetChildCanvasGroupDOFade(10,0,1)
tweener:SetDelay(3)
end

function UIRecruitSelectWin:RefreshDisciple(showAnimation)
if self.mode==2 or self.mode==3 then
self.dispicles=self.showList
else
local dispicles={}
local ddatas=UIRecruitModel:getRecruitDisciple()
for k,v in pairs(ddatas)do
table.insert(dispicles,v)
end
self.dispicles=dispicles
end

local zmLevel=zongmenModel:getLevel()
if zmLevel<5 then
table.sort(self.dispicles,function(a,b)
local infoA=UIRecruitModel:GetDiscipleImageInfo(a.discipleInfo)
local infoB=UIRecruitModel:GetDiscipleImageInfo(b.discipleInfo)
local fa=infoA.job==52
local fb=infoB.job==52
if fa and not fb then
return true
elseif fa==fb then
return infoA.job<infoB.job
else
return false
end
end)
end
local showReceived=self.mode~=3
self.scrollview:setChildScrollViewCreateGrids(#self.dispicles,0)
local items=self.scrollview:getChildScrollViewItemWidgets()
local delayUnit=0
local total=0
if showAnimation then
total=1.3
delayUnit=0.5
end
self.tweenerVal={}
for i=0,items.Count-1 do
local item=items[i]
local index=i+1
local data=self.dispicles[index]
local info=UIRecruitModel:GetDiscipleImageInfo(data.discipleInfo)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
item:SetChildUIModelShowTarget(0,modelParams.body,1,modelParams.componets,eAnimationID.stand)
item:SetChildUIModelShowColor(0,Color.clear)

modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
item:SetChildUIModelShowTarget(1,modelParams.body,0.75,modelParams.componets,eAnimationID.stand)
item:SetChildButtonClickWithID(1,self.onShowInfo,index)
item:SetChildButtonClickWithID(2,self.onShowInfo,index)
item:SetChildNewBieComponentId(2,FMT.fmt('UIRecruitSelectNode_click_{0}',info.job))
local check1=data.state==0
local check2=data.state==1
local check3=data.state==-1
item:SetChildActive(3,check1)
item:SetChildActive(4,check1)
if check1 then
item:SetChildButtonClickWithID(3,self.onSelect,index)
item:SetChildNewBieComponentId(3,FMT.fmt('UIRecruitSelectWin.SelectNode_selectBtn_{0}',info.job))
item:SetChildButtonClickWithID(4,self.onGiveUp,index)
end
item:SetChildActive(7,check2)
item:SetChildActive(9,check3 and showReceived)
item:SetChildActive(24,check2 and not showReceived)
item:SetChildActive(25,check3 and not showReceived)
if check2 and not showReceived then
item:SetChildButtonClickWithID(24,self.onZhuChu,index)
end


item:SetChildCSImageSprite(5,self.abName,FMT.fmt('frame_yxtjuanzhou_{0}',info.color))



item:SetChildCSImageSprite(17,globalABLookup.global,UIDiscipleModel:getJobIconName(info.job,data.discipleInfo.id))

local orientation=UIDiscipleModel:getJobOrientationName(info.job)or''
item:SetChildText(18,orientation)

item:SetChildCanvasGroupAlpha(10,0)
item:SetChildShowEffect(13,-1,false)
item:SetChildShowEffect(14,-1,false)
if self.recruitItemTweener[i]and self.recruitItemTweener[i]:IsPlaying()then
self.recruitItemTweener[i]:Kill()
end

if self.tzrecruitItemTweener[i]and self.tzrecruitItemTweener[i]:IsPlaying()then
self.tzrecruitItemTweener[i]:Kill()
end

if self.sperecruitItemTweener[i]and self.sperecruitItemTweener[i]:IsPlaying()then
self.sperecruitItemTweener[i]:Kill()
end

item:SetChildCanvasGroupAlpha(15,0)
item:SetChildCanvasGroupAlpha(19,0)
item:SetChildCanvasGroupAlpha(26,0)
local specialityPreviewList=UIDiscipleModel.getSpecialityPreviewList(data.discipleInfo)
local tzWidget=item:GetChildWidgetBase(19)
tzWidget:SetChildLayoutGroupClearAllItems(0)
tzWidget:SetChildLayoutGroupClearAllItems(1)
if specialityPreviewList and#specialityPreviewList>0 then
local tzList1Data
local tzList2Data
if#specialityPreviewList<=2 then
tzList1Data=table.sub(specialityPreviewList,1,#specialityPreviewList)
else
tzList1Data=table.sub(specialityPreviewList,1,2)
tzList2Data=table.sub(specialityPreviewList,3,#specialityPreviewList)
end
tzWidget:SetChildLayoutGroupCreateItems(0,#tzList1Data,function(index)
local sitem=tzWidget:GetChildLayoutGroupGridItem(0,index-1)
local sdata=tzList1Data[index]
sitem:SetChildCSImageSprite(-1,"ui/windows/recruit/yinxiantai_atlas_pak.ab",sdata.tzicon)
end)
if tzList2Data and next(tzList1Data)then
tzWidget:SetChildLayoutGroupCreateItems(1,#tzList2Data,function(index)
local sitem=tzWidget:GetChildLayoutGroupGridItem(1,index-1)
local sdata=tzList2Data[index]
sitem:SetChildCSImageSprite(-1,"ui/windows/recruit/yinxiantai_atlas_pak.ab",sdata.tzicon)
end)
end
end

local hasLoveSpe=UIDiscipleModel.checkDZHasLoveSpeciality(data.discipleInfo)
item:SetChildActive(26,hasLoveSpe)

if not showAnimation then
self.firstShowDissolve=true
item:SetDissolveFactor(16,0)
self.delayShowAnimationTimer=timeEventController.delayDo(1,
function()
if self==nil or self.isClose then return end
self.delayShowAnimationTimer=nil
self.tweeners["dissove"..i]=_DOTweenProxy.DoValueTo(
function()
return self.tweenerVal["dissove"..i]or 0
end,
function(val)
self.tweenerVal["dissove"..i]=val
item:SetDissolveFactor(16,val)
end,
1,1)
end)
item:SetChildCanvasGroupDOFade(19,1,self.tzlistTime,nil)
else
item:SetDissolveFactor(16,1)
end


self:refreshShareBtn(item,index)
end


if showAnimation then

self.winlua:SetChildCanvasGroupAlpha(self.scrollview:getID(),0)
self:resetAnimation()
self.other:setActive(false)
self.LBtips:setActive(false)
self.isPlaying=true
self.isWaiting=true
self:clearAllTimer()
local time=0.5
if self.mode==1 then
local maxPinZhi=UIRecruitModel:getDisciplesMaxPinZhi(self.dispicles)
self:playEnterEffect(maxPinZhi)
time=self:getDeleyShowTime(maxPinZhi)
end

self:startMyTimer(time,1,function()
self.root:setChildCanvasGroupDOFade(1,0.5,function()

self.winlua:SetChildCanvasGroupAlpha(self.scrollview:getID(),1)
self:playAnimation()
end)
end)
else
self.LBtips:setActive(false)
self.other:setActive(self.mode==1)
self.root:setChildCanvasGroupDOFade(1,0.5,function()
for i=0,items.Count-1 do
local item=items[i]
item:SetChildUIModelShowFadeToColor(0,Color.white,0.1,0,nil)
item:SetChildAnimatorParameter(8,'state','int',2)
item:SetChildAnimatorParameter(8,'tBreak','trigger','')
item:SetChildCanvasGroupAlpha(15,1)
item:SetChildCanvasGroupDOFade(19,1,self.tzlistTime,nil)
item:SetChildCanvasGroupAlpha(26,1)
local effectId1,effectId2=self:getPlayEffectID(i+1)
if effectId2 then
local item=self.scrollview:getChildScrollViewItemWidget(i)
item:SetChildShowEffect(14,effectId2,true)
end
end
self:RandomSpeak(2,math.random(5,8))
self.LBtips:setActive(true)
end)
self:delayDo(2,function()
self:showGiveReward()
end)
end
end


function UIRecruitSelectWin:refreshShareRewardShow()
self.scrollview:setChildScrollViewCreateGrids(#self.dispicles,0)
local girds=self.scrollview:getChildScrollViewItemWidgets()
for i=1,girds.Count do
local widget=girds[i-1]
self:refreshShareBtn(widget,i)
end
end


function UIRecruitSelectWin:refreshShareBtn(widget,index)
local data=self.dispicles[index]
local info=UIRecruitModel:GetDiscipleImageInfo(data.discipleInfo)
local showShareBtn=shareImageModel:IsShareDzBtnCanShow(info.color)
widget:SetChildActive(20,showShareBtn)
if not showShareBtn then
return
end
local shareShowType=shareImageModel:getShareShowTypeByWinName(self.window_name)
widget:SetChildButtonClick(20,function()
local param={
disciple_guid=data.discipleInfo.discipleguid,
}
shareImageController:showShareImageWin(shareShowType,param)
end,true)



local isShow=false
local shareType=shareImageModel:getShareTypeByWinName(self.window_name)
if shareType then
local canGetNum=shareImageModel:getShareRewardCanGetNumByType(shareType)
isShow=canGetNum>0
end
widget:SetChildActive(21,isShow)
if isShow then

local rewards=cfgHelper.get(cfg_yaoqingmadailyconfig_get,shareType,"rewards")
if rewards then

local reward=rewards[1]
local itemId=reward[1]
local itemCount=reward[2]
local countStr=mathHelper.formatNumber(itemCount)
widget:SetChildIcon(22,iconHelper.getIconName(itemId),false)
widget:SetChildText(23,countStr)
end
end
end

function UIRecruitSelectWin:getDeleyShowTime(maxPinZhi)
local time
if maxPinZhi<2 then
time=delayTimes[2]
else
time=delayTimes[maxPinZhi]
end
return time
end

function UIRecruitSelectWin:playEnterEffect(maxPinZhi)
local effectid
if maxPinZhi<2 then
effectid=enterEffects[2]
else
effectid=enterEffects[maxPinZhi]
end
self.showEffect:setChildShowEffect(effectid,true)

local audioId=maxPinZhi>=3 and enterAudio[maxPinZhi]or enterAudio[3]
AudioManager.playAudio(audioId)
end

function UIRecruitSelectWin:getPlayEffectID(index)
local data=self.dispicles[index]


local info=UIRecruitModel:GetDiscipleImageInfo(data.discipleInfo)
local color=info.color
local effectId1=effectCX[color]
local effectId2=effectZM[color]
local audioId=audioCX[color]
return effectId1,effectId2,audioId
end

function UIRecruitSelectWin.onShowInfo(id)
if not _this.isPlaying and _this.showDetail then
if _this.infoList then
local data=_this.dispicles[id]
for i,v in ipairs(_this.infoList)do
if v==data then
id=i
end
end
end
local list=_this.infoList or _this.dispicles
UIManager:showWindow('UIRecruitInfoWin',{index=id,datas=list,mode=_this.mode})
end
end

function UIRecruitSelectWin.onZhuChu(id)
local ddata=_this.dispicles[id]
UIManager:showWindow('UIDiscipleKickoutWin',{guid=ddata.discipleInfo.discipleguid,openType=1,useCancel=true})
end

function UIRecruitSelectWin.onSelect(id)
if _this.isWaiting then
return
end
if UIRecruitModel:checkZongMenPeopleMax()then
UIManager.info('宗门人数已达上限')
return
end
local ddata=_this.dispicles[id]
if _this.mode==1 then
UIRecruitControl:reqSelectDisciple(ddata.discipleInfo.discipleguid)
else
UIRecruitControl:reqSelectDiscipleJZ(ddata.familyid,ddata.discipleInfo.discipleguid)
end
roleAudioController:playRoleSpeak(ddata.discipleInfo.discipleguid,roleAudioNodeType.ZhaoMuChengGong)
end

function UIRecruitSelectWin.onGiveUp(id)
if _this==nil then return end
if _this.isWaiting then
return
end
if _this.mode==1 then
local ddata=_this.dispicles[id]
if UIDiscipleModel.checkDZHasLoveSpeciality(ddata.discipleInfo)then
local callback=function()
if _this==nil then return end
_this:showGiveUpDialog(id)
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveGiveUp)
if not flag then
local contentStr='当前弟子拥有<color=#c82c2c>心仪特质</color>，拒收后弟子消失，确定拒招吗？'
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
showclosebtn=true,
allowclickBG=false,
oktext='确定',
canceltext='取消',
choosetext='<color=#c82c2c>心仪特质</color>今日不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveGiveUp,flag)
end,
okcallback=function()
if _this==nil then return end
callback()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
callback()
end
return
end
end
_this:showGiveUpDialog(id)
end

function UIRecruitSelectWin:handleGiveUp(id)
local ddata=_this.dispicles[id]
if _this.mode==1 then
UIRecruitControl:reqGiveUpDisciple(ddata.discipleInfo.discipleguid)
else
UIRecruitControl:reqGiveUpDiscipleJZ(ddata.familyid,ddata.discipleInfo.discipleguid)
end
end

function UIRecruitSelectWin:resetAnimation()
local items=self.scrollview:getChildScrollViewItemWidgets()
local count=items.Count-1
for i=0,count do
local item=items[i]
item:SetChildAnimatorParameter(8,'state','int',0)
item:SetChildAnimatorParameter(8,'tBreak','trigger','')
end

self.winlua:SetChildClearTween(self.scrollview:getID(),true)
end

function UIRecruitSelectWin:playAnimation()
local spos=self.scrollview:getChildPosition()
spos.y=spos.y-2
local items=self.scrollview:getChildScrollViewItemWidgets()
local len=items.Count
local effects=self.effects[len]
local count=len-1
if len==3 then

AudioManager.playAudio(612)
elseif len==1 then

AudioManager.playAudio(616)
end
for i=0,count do
local item=items[i]
item:SetChildCanvasGroupAlpha(1,0)

local effectId1,effectId2,audioId=self:getPlayEffectID(i+1)
self:startMyTimer(0.5*i,1,function()
local jumpCB=nil
if i==count then
if(self.mode==1 or self.mode==3)and not self.showOnly then
self.other:setActive(true)
self.other:setChildCanvasGroupAlpha(0)
local tweener=self.other:setChildCanvasGroupDOFade(1,0.5,function()


self:RandomSpeak(2,math.random(5,8))
end)
tweener:SetEase(_Ease.InQuad)
tweener:SetDelay(1.5)
self:startMyTimer(1.5,1,function()
self.isPlaying=false
self.LBtips:setActive(true)
self:showGiveReward()
end)
else
jumpCB=function()
self:startMyTimer(1,1,function()
self.isPlaying=false
self.LBtips:setActive(true)
end)
end
self:startMyTimer(0.5*i+1.5,1,function(...)
self:RandomSpeak(2,math.random(5,8))
end)
end
end
if effects then
self.effect1:setChildShowEffect(effects[i+1],true)
end
self:handlePlay(spos,item,jumpCB)
self:startMyTimer(1,1,function(...)
if effectId1 then
item:SetChildShowEffect(13,effectId1,true)
item:SetChildUIModelShowFadeToColor(0,Color.white,0.1,0.35,nil)
else
item:SetChildUIModelShowFadeToColor(0,Color.white,0.1,0.1,nil)
end

if audioId then

AudioManager.playAudio(audioId)
end
end)
self:startMyTimer(0.6,1,function(...)
if effectId2 then
item:SetChildShowEffect(14,effectId2,true)
end
end)

self.recruitItemTweener[i]=item:SetChildCanvasGroupDOFade(15,1,1,function()
if _this then
_this.isWaiting=false
end
end)

self.recruitItemTweener[i]:SetDelay(2)

self.tzrecruitItemTweener[i]=item:SetChildCanvasGroupDOFade(19,1,self.tzlistTime,nil)

self.tzrecruitItemTweener[i]:SetDelay(2)

self.sperecruitItemTweener[i]=item:SetChildCanvasGroupDOFade(26,1,1,nil)
self.sperecruitItemTweener[i]:SetDelay(2)
end)
end
end

function UIRecruitSelectWin:showGiveReward()








end

function UIRecruitSelectWin:handlePlay(spos,item,jumpCB)
item:SetChildAnimatorParameter(8,'state','int',1)
local epos=item:GetChildPosition(8)
item:SetChildPosition(8,spos)
item:SetChildDOJump(8,epos,2,1,0.5)

local rpos=item:GetChildPosition(1)
item:SetChildPosition(1,spos)
local tweener4=item:SetChildDOJump(1,rpos,3,1,0.7,jumpCB)
tweener4:SetEase(_Ease.Linear)
item:SetChildModelAnimationState(1,eAnimationID.ui_jump1)
local tweener5=item:SetChildCanvasGroupDOFade(1,1,0.7)
tweener5:SetEase(_Ease.OutQuart)
end

function UIRecruitSelectWin:RefreshTimes()
self.tips:setActive(true)
local tipshow=false
if self.mode==1 then
local times=UIRecruitModel:getRecruitTimes()
local def=cfgHelper.getdef(cfg_yinxiantaizmconfig)
if times>0 then
self.tips:setText(string.format('剩余%s次',times))
self.recrultBtn:setActive(true)
self.tipsBtn:setActive(false)
self.way=0
else
local itemId=def.itemid
local itemCount=bagModel.getItemCountById(itemId)
if itemCount>0 then
local cfg=itemsHelper:get_item_config(itemId)
self.tips:setText(string.format('%sx%s',cfg.name,itemCount))
self.way=1
self.recrultBtn:setActive(true)
self.tipsBtn:setActive(false)
else
self:ShowCountDown()
self.recrultBtn:setActive(false)
self.tipsBtn:setActive(false)
self.way=-2
tipshow=true
end
end
local showIcon=self.way~=0
self.icon:setActive(showIcon)
if showIcon then
self.icon:setSprite(self.globalAB,self.iconName[self.way])
end
self.desc:setText(self.way==-2 and'下次招募：'or'')



if tipshow then
self.icon:setActive(false)
self.tips:setActive(false)
self.desc:setText('<color=#FF4040>招募令x0</color>')
self.recrultBtn:setActive(false)
self.tipsBtn:setActive(true)
end

elseif self.mode==3 then
local itemId=self.specialItem
local itemCount=bagModel.getItemCountById(itemId)
local cfg=itemsHelper:get_item_config(itemId)
local use=cfg.funcparam.num or 1
local str
if itemCount>=use then
str=string.format('%s（%s/%s）',cfg.name,itemCount,use)
else
local col=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
str=string.format('%s（<color=%s>%s</color>/%s）',cfg.name,col,itemCount,use)
end
self.tips:setText(str)
self.way=-3
self.recrultBtn:setActive(true)
self.tipsBtn:setActive(false)
self.desc:setText('')
end
if self.way~=-2 and self:getRecruitLastTime()<=0 then
self:RequestTimes()
end
end

function UIRecruitSelectWin:getDuration()
local cfgs=cfg_yinxiantaizmadjustconfig()
local attrCfg=cfgHelper.getdef1(cfg_yinxiantaizmconfig,'attr6')
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eJieYin)or{}
local index=1
if#dis_list>0 then
local ddata=dis_list[1]
local count=0
for i,v in ipairs(attrCfg)do
count=count+ddata.attrList[v]
end
for i,v in ipairs(cfgs)do
if count>=v.minval and count<=v.maxval then
index=i
end
end
if not index then
index=#cfgs
end
end
return cfgs[index].duration
end

function UIRecruitSelectWin:getRecruitLastTime()
local lastTime=UIRecruitModel:getRecruitLastTime()
local ntime=lastTime+self:getDuration()
local ctime=gameUtilityModel.getServerShortTime()
local time=ntime-ctime
return time
end

function UIRecruitSelectWin:ShowCountDown()
local time=self:getRecruitLastTime()
if time>0 then
local endTime=os.time()+time
self:SetCountDown(time)
self:ClearTimer()
self.timer=self:setTimer(1,time+3,function()
local dt=endTime-os.time()
if dt>=0 then
self:SetCountDown(dt)
else
self:RequestTimes()
end
end)
else
self:RequestTimes()
end
end

function UIRecruitSelectWin:RequestTimes()
UIRecruitControl:reqRefreshRecruitTimes()
self:ClearTimer()
end

function UIRecruitSelectWin:ClearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIRecruitSelectWin:SetCountDown(time)
self.tips:setText(timeHelper.format_time_stamp11(time,true))
end

function UIRecruitSelectWin:RefreshBottomRightTipsStr()
self.Text:setText(self.tipsBR or"点击弟子查看详细信息")
end

function UIRecruitSelectWin:getRecruitMaxCount(color)
local cfgs=cfg_yinxiantaizmconfig()
local count
for i,v in ipairs(cfgs)do
if v.color==color then
count=v.maxval
end
end
return count
end

function UIRecruitSelectWin:getNeedStr(num)
if num<10 then
return FMT.fmt('<color=#00000000>0</color><color=#8f5127>{0}</color>',num)
else
return FMT.fmt('<color=#8f5127>{0}</color>',num)
end
end

function UIRecruitSelectWin:RefreshGuarantTipsStr(isShow)
if not isShow then
self.guarantTips:setActive(false)
return
end

self.guarantTips:setActive(true)




local eachNum=cfg_yinxiantaizmconfig().const_def.eachnum




local color=4
local maxValue=self:getRecruitMaxCount(color)
local currValue=UIRecruitModel:getRecruitCount(color)-1
local need=math.ceil((maxValue-currValue)/eachNum)
local colorStr=FONT_COLOR_VAL[FONT_COLOR.eOrangeColor]
local pzn=UIDiscipleModel.getDiscipleColorDesc(color)
need=self:getNeedStr(need)
local needText=FMT.fmt('再招募 {0} 次，必得 <color={1}>{2}</color> 以上弟子',need,colorStr,pzn)

color=5
maxValue=self:getRecruitMaxCount(color)
currValue=UIRecruitModel:getRecruitCount(color)-1
need=math.ceil((maxValue-currValue)/eachNum)
colorStr=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
pzn=UIDiscipleModel.getDiscipleColorDesc(color)
need=self:getNeedStr(need)
needText=FMT.fmt('{3}\n再招募 {0} 次，必得 <color={1}>{2}</color> 弟子',need,colorStr,pzn,needText)

self.guarantTipsText:setText(needText)
end


function UIRecruitSelectWin:onHide()

end

function UIRecruitSelectWin:startMyTimer(delay,count,func)
local timer=self:setTimer(delay,count,func)
self.timerDatas[timer]=true
return timer
end

function UIRecruitSelectWin:clearAllTimer()
for k,v in pairs(self.timerDatas)do
self:stopTimerByID(k)
end
self.timerDatas={}
end




function UIRecruitSelectWin:onClickClose()
if not self.isPlaying then
self:closeSelf()
end
end

function UIRecruitSelectWin:countGiveUpReward(lookup)
lookup=lookup or{}
for i,v in ipairs(self.dispicles)do
if v.state==-1 then
UIDiscipleModel:getDiscipleGiveUpReward(v.discipleInfo.discipleguid,lookup)
end
end
self.giveUpReward=lookup
end

function UIRecruitSelectWin:finishReq()
self.reqCheck=false
end

function UIRecruitSelectWin:handleRecruit()
if self.reqCheck then
return
end

local time=gameUtilityModel.getServerShortTime()
local isSkipAnimation=UIRecruitControl:getSkipAnimationState()
local intervalTime=isSkipAnimation and 1 or 5
if self.lastReqTime then
local dt=time-self.lastReqTime
if dt<intervalTime then
if isSkipAnimation then
UIManager.info(FMT.fmt("寻觅弟子中，请静候{0}秒",Mathf.Ceil(intervalTime-dt)))
else
loggerUtil.debugErrFMT('招募间隔过短，跳过执行')
end
return
end
end
self:countGiveUpReward()
if self.way==-3 then
local itemid=self.specialItem
local itemCount=bagModel.getItemCountById(itemid)
local cfg=itemsHelper:get_item_config(itemid)
local use=cfg.funcparam.num or 1
if itemCount>=use then
if not itemsLookup:checkUseItemCondition(itemid)then
return
end
bagProtocolControl.req_use_item(itemid,use)
self.lastReqTime=time
self.reqCheck=true
else
UIManager.error('道具不足')
gainControl:showGainWin(itemid)
end
else
UIRecruitControl:reqRecruit(self.way,1)
self.lastReqTime=time
self.reqCheck=true
end
end

function UIRecruitSelectWin:showDialog()
local cfg=cfgHelper.get1(cfg_yinxiantaiconfig_get,1)
local isfinish=true
local content
local ftype=-1
local maxColor=-1
for i,v in ipairs(self.dispicles)do
if v.state==0 then
isfinish=false
local info=UIRecruitModel:GetDiscipleImageInfo(v.discipleInfo)
if info.color>maxColor then
maxColor=info.color
end
end
end

for i,v in ipairs(cfg.tips)do
if maxColor>=v[1]then
ftype=i
content=v[2]
end
end


local ffTypeName=FMT.fmt('recruitSelect_RecruitTips_{0}',ftype)
local ff=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,ffTypeName)

local iscolor=false
local setcolor=userActorSetting.get('UIRecruitSelectWincolor',0)
local setcolor2=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eUIRecruitSelectWincolor)
if setcolor>=maxColor and setcolor2 then
iscolor=true
end

if isfinish or ff or iscolor then
self:handleRecruit()
return
end

if not content then
logErr('无法找到招募提示配置')
return
end

local func=function()
local _ff=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,ffTypeName)
if _ff then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eUIRecruitSelectWincolor,true)
userActorSetting.set('UIRecruitSelectWincolor',maxColor)
userActorSetting.flush()
end
self:handleRecruit()
end
local _colornew=getQualityColorNew(QualityColorNewType.white,maxColor)
local _choosetext=FMT.fmt('<color={0}>{1}</color>品质以下今天不再提示',_colornew,pinzi[maxColor]or"")
local desc=content
local show_data=
{
title='提示',
Str=desc or'',
oktext="确认",
canceltext="取消",
eDay=REPEAT_TIME_TYPE.eDay,
REPEAT_TYPE=ffTypeName,
tipsTextstr=_choosetext,
profilerSetpos=186,
okcallback=function()
if _this==nil then return end
func()
end
}
UIManager:showWindow('UIDialougeYCTBtips',show_data)




















end

function UIRecruitSelectWin:showGiveUpDialog(id)
local cfg=cfgHelper.get1(cfg_yinxiantaiconfig_get,1)
local content
local ftype=-1

local data=self.dispicles[id]
local info=UIRecruitModel:GetDiscipleImageInfo(data.discipleInfo)
local color=info.color

for i,v in ipairs(cfg.giveup_tips)do
if color>=v[1]then
ftype=i
content=v[2]
end
end


local ffTypeName=FMT.fmt('recruitSelect_GiveUpTips_{0}',ftype)
local ff=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,ffTypeName)

local iscolor=false
local setcolor=userActorSetting.get('UIRecruitSelectWincolor',0)
local setcolor2=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eUIRecruitSelectWincolor)
if setcolor>=color and setcolor2 then
iscolor=true
end

if ff or ftype<0 or iscolor then
self:handleGiveUp(id)
return
end

if not content then
logErr('无法找到招募提示配置')
return
end

local func=function()
local _ff=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,ffTypeName)
if _ff then
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eUIRecruitSelectWincolor,true)
userActorSetting.set('UIRecruitSelectWincolor',color)
userActorSetting.flush()
end
self:handleGiveUp(id)
end
local _colornew=getQualityColorNew(QualityColorNewType.white,color)
local _choosetext=FMT.fmt('<color={0}>{1}</color>品质以下今天不再提示',_colornew,pinzi[color]or"")
local desc=content
local show_data=
{
title='提示',
Str=desc or'',
oktext="确认",
canceltext="取消",
eDay=REPEAT_TIME_TYPE.eDay,
REPEAT_TYPE=ffTypeName,
tipsTextstr=_choosetext,
profilerSetpos=186,
okcallback=function()
if _this==nil then return end
func()
end
}
UIManager:showWindow('UIDialougeYCTBtips',show_data)





















end

function UIRecruitSelectWin:onRecrultBtn()
if self.isPlaying then return end
if self.mode==1 then
local hasSpeLove=false
for i,v in ipairs(self.dispicles)do
if v.state==0 then
if UIDiscipleModel.checkDZHasLoveSpeciality(v.discipleInfo)then
hasSpeLove=true
break
end
end
end
if hasSpeLove then
local callback=function()
if _this==nil then return end
_this:showDialog()
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveGiveUp)
if not flag then
local contentStr='尚有<color=#c82c2c>心仪特质</color>弟子未收入宗门，是否要继续招募？'
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
showclosebtn=true,
allowclickBG=false,
oktext='确定',
canceltext='取消',
choosetext='<color=#c82c2c>心仪特质</color>今日不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eSpecialityLoveGiveUp,flag)
end,
okcallback=function()
if _this==nil then return end
callback()
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
callback()
end
return
end
end
self:showDialog()
end

function UIRecruitSelectWin:onTipsBtn()


gainControl:showGainWin(10501)
end

function UIRecruitSelectWin:on_item_list_changed(array)
local def=cfgHelper.getdef(cfg_yinxiantaizmconfig)
for k,itemdata in ipairs(array or{})do
local changeType=itemdata[1]
local itemid=itemdata[3]
if itemid==def.itemid and changeType==CHANGE_TYPE.eAdd then
self:ClearTimer()
self:RefreshTimes(false)
end
end
end