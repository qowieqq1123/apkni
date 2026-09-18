







def_class("UISubAct_tufaEventWin_YSLK",UIWindowBase)









function UISubAct_tufaEventWin_YSLK:bindComponents()

self.timeText=UIText.get(self,0)
self.title=UIImage.get(self,1)
self.infoText=UIText.get(self,2)
self.rewardList=UIObject.get(self,3)
self.infoBg=UIObject.get(self,4)
self.bgModel=UIObject.get(self,5)
self.caoLingModel=UIObject.get(self,6)
self.xiaoRenModel=UIObject.get(self,7)
self.dzRoot=UIObject.get(self,8)
self.pos_1=UIObject.get(self,9)
self.pos_2=UIObject.get(self,10)
self.pos_3=UIObject.get(self,11)
self.pos_4=UIObject.get(self,12)
self.pos_5=UIObject.get(self,13)
self.pos_6=UIObject.get(self,14)
self.pos_7=UIObject.get(self,15)
self.pos_8=UIObject.get(self,16)
self.pos_9=UIObject.get(self,17)
self.pos_10=UIObject.get(self,18)
self.pos_11=UIObject.get(self,19)
self.pos_12=UIObject.get(self,20)
self.pos_13=UIObject.get(self,21)
self.pos_14=UIObject.get(self,22)
self.pos_15=UIObject.get(self,23)
self.caolingEffect=UIObject.get(self,24)
self.xiaorenEffect=UIObject.get(self,25)
self.helpPanel=UIObject.get(self,26)
self.descText=UIText.get(self,27)
self.tempText=UIText.get(self,28)
self.helpBtn=UIButton.get(self,29)
self.pos_16=UIObject.get(self,30)
self.pos_17=UIObject.get(self,31)
self.pos_18=UIObject.get(self,32)
self.pos_19=UIObject.get(self,33)
self.dzRoot1=UIObject.get(self,34)
self.xiaorenEffect1=UIObject.get(self,35)
self.xiaorenEffect2=UIObject.get(self,36)
self.xiaorenEffect3=UIObject.get(self,37)
self.xiaoRenModel1=UIObject.get(self,38)
self.xiaoRenModel2=UIObject.get(self,39)
self.xiaoRenModel3=UIObject.get(self,40)
self.speakObj_1=UIObject.get(self,41)
self.speakText_1=UIText.get(self,42)
self.speakObj_2=UIObject.get(self,43)
self.speakText_2=UIText.get(self,44)
self.pos_20=UIObject.get(self,45)
self.pos_21=UIObject.get(self,46)
self.pos_22=UIObject.get(self,47)
self.pos_23=UIObject.get(self,48)
self.pos_24=UIObject.get(self,49)
self.pos_25=UIObject.get(self,50)
self.speakObj_3=UIObject.get(self,51)
self.speakText_3=UIText.get(self,52)
self.speakObj_4=UIObject.get(self,53)
self.speakText_4=UIText.get(self,54)
self.speakObj_5=UIObject.get(self,55)
self.speakText_5=UIText.get(self,56)
self.bornPos=UIObject.get(self,57)
self.idlePos=UIObject.get(self,58)
self.diePos=UIObject.get(self,59)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)
self.pos={
self.pos_1,
self.pos_2,
self.pos_3,
self.pos_4,
self.pos_5,
self.pos_6,
self.pos_7,
self.pos_8,
self.pos_9,
self.pos_10,
self.pos_11,
self.pos_12,
self.pos_13,
self.pos_14,
self.pos_15,
self.pos_16,
self.pos_17,
self.pos_18,
self.pos_19,
self.pos_20,
self.pos_21,
self.pos_22,
self.pos_23,
self.pos_24,
self.pos_25,
}
self.speakObj={
self.speakObj_1,
self.speakObj_2,
self.speakObj_3,
self.speakObj_4,
self.speakObj_5,
}
self.speakText={
self.speakText_1,
self.speakText_2,
self.speakText_3,
self.speakText_4,
self.speakText_5,
}



end


function UISubAct_tufaEventWin_YSLK:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.infoText);self.infoText=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.infoBg);self.infoBg=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.caoLingModel);self.caoLingModel=nil;
_UIObject_release(self.xiaoRenModel);self.xiaoRenModel=nil;
_UIObject_release(self.dzRoot);self.dzRoot=nil;
_UIObject_release(self.pos_1);self.pos_1=nil;
_UIObject_release(self.pos_2);self.pos_2=nil;
_UIObject_release(self.pos_3);self.pos_3=nil;
_UIObject_release(self.pos_4);self.pos_4=nil;
_UIObject_release(self.pos_5);self.pos_5=nil;
_UIObject_release(self.pos_6);self.pos_6=nil;
_UIObject_release(self.pos_7);self.pos_7=nil;
_UIObject_release(self.pos_8);self.pos_8=nil;
_UIObject_release(self.pos_9);self.pos_9=nil;
_UIObject_release(self.pos_10);self.pos_10=nil;
_UIObject_release(self.pos_11);self.pos_11=nil;
_UIObject_release(self.pos_12);self.pos_12=nil;
_UIObject_release(self.pos_13);self.pos_13=nil;
_UIObject_release(self.pos_14);self.pos_14=nil;
_UIObject_release(self.pos_15);self.pos_15=nil;
_UIObject_release(self.caolingEffect);self.caolingEffect=nil;
_UIObject_release(self.xiaorenEffect);self.xiaorenEffect=nil;
_UIObject_release(self.helpPanel);self.helpPanel=nil;
_UIObject_release(self.descText);self.descText=nil;
_UIObject_release(self.tempText);self.tempText=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.pos_16);self.pos_16=nil;
_UIObject_release(self.pos_17);self.pos_17=nil;
_UIObject_release(self.pos_18);self.pos_18=nil;
_UIObject_release(self.pos_19);self.pos_19=nil;
_UIObject_release(self.dzRoot1);self.dzRoot1=nil;
_UIObject_release(self.xiaorenEffect1);self.xiaorenEffect1=nil;
_UIObject_release(self.xiaorenEffect2);self.xiaorenEffect2=nil;
_UIObject_release(self.xiaorenEffect3);self.xiaorenEffect3=nil;
_UIObject_release(self.xiaoRenModel1);self.xiaoRenModel1=nil;
_UIObject_release(self.xiaoRenModel2);self.xiaoRenModel2=nil;
_UIObject_release(self.xiaoRenModel3);self.xiaoRenModel3=nil;
_UIObject_release(self.speakObj_1);self.speakObj_1=nil;
_UIObject_release(self.speakText_1);self.speakText_1=nil;
_UIObject_release(self.speakObj_2);self.speakObj_2=nil;
_UIObject_release(self.speakText_2);self.speakText_2=nil;
_UIObject_release(self.pos_20);self.pos_20=nil;
_UIObject_release(self.pos_21);self.pos_21=nil;
_UIObject_release(self.pos_22);self.pos_22=nil;
_UIObject_release(self.pos_23);self.pos_23=nil;
_UIObject_release(self.pos_24);self.pos_24=nil;
_UIObject_release(self.pos_25);self.pos_25=nil;
_UIObject_release(self.speakObj_3);self.speakObj_3=nil;
_UIObject_release(self.speakText_3);self.speakText_3=nil;
_UIObject_release(self.speakObj_4);self.speakObj_4=nil;
_UIObject_release(self.speakText_4);self.speakText_4=nil;
_UIObject_release(self.speakObj_5);self.speakObj_5=nil;
_UIObject_release(self.speakText_5);self.speakText_5=nil;
_UIObject_release(self.bornPos);self.bornPos=nil;
_UIObject_release(self.idlePos);self.idlePos=nil;
_UIObject_release(self.diePos);self.diePos=nil;
self.pos=nil;
self.speakObj=nil;
self.speakText=nil;
end
















local _this




function UISubAct_tufaEventWin_YSLK:onLoaded(...)
_this=self
self:bindComponents()
self.model={
self.caoLingModel,
self.xiaoRenModel,
self.xiaoRenModel1,
self.xiaoRenModel2,
self.xiaoRenModel3,
}
self.modelEffect={
self.caolingEffect,
self.xiaorenEffect,
self.xiaorenEffect1,
self.xiaorenEffect2,
self.xiaorenEffect3,
}
end


function UISubAct_tufaEventWin_YSLK:__delete()
self:clearDzBt()
self:clearTimer()
self:clearDelayClickTimer()
self.isClickModel=nil
self:clearAllTimer()


self.caoLingModel:setChildCanvasGroupAlpha(0)
self.xiaoRenModel:setChildCanvasGroupAlpha(0)
self.xiaoRenModel1:setChildCanvasGroupAlpha(0)
self.xiaoRenModel2:setChildCanvasGroupAlpha(0)
self.xiaoRenModel3:setChildCanvasGroupAlpha(0)
uiAIManager:removeUIInstance(self.bt_caoLing)
uiAIManager:removeUIInstance(self.bt_xiaoRen)
uiAIManager:removeUIInstance(self.bt_xiaoRen1)
uiAIManager:removeUIInstance(self.bt_xiaoRen2)
uiAIManager:removeUIInstance(self.bt_xiaoRen3)
self.bt_caoLing=nil
self.bt_xiaoRen=nil
self.bt_xiaoRen1=nil
self.bt_xiaoRen2=nil
self.bt_xiaoRen3=nil
self.checkFadeOut={}
self.fadeOutTime={}
self.doFadeInTweener={}
self.doFadeOutTweener={}
self.checkStartPos_x={}
self.checkTargetPos_x={}
self.modelWidget={}
self.modelIndex={}
self.checkTimer={}
self:unbindComponents()
_this=nil
self.model=nil;
self.modelEffect=nil;
end




function UISubAct_tufaEventWin_YSLK:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self.itemList=self.config.showRewards
self.checkFadeOut={}
self.fadeOutTime={}
self.doFadeInTweener={}
self.doFadeOutTweener={}
self.checkStartPos_x={}
self.checkTargetPos_x={}
self.modelWidget={}
self.modelIndex={}
self.checkTimer={}
self.modelEffectCreate={}
self.localPosList=nil
self.isClickModel=nil
local specialPram=self.config.specialPram
if specialPram then
self.xiaoRenDis=specialPram.xiaorenDis
self.caoLingRunSpeed=specialPram.speed[1]
self.lxtSpeed=specialPram.speed[2]
self.routeEndWaitTime_1=specialPram.routeEndWaitTime_1
self.routeEndWaitTime_2=specialPram.routeEndWaitTime_2
self.routeModelSize={}
self.routeModelSize[1]={}
self.routeModelSize[1][1]=specialPram.routeXiaohaiSize_1
self.routeModelSize[1][2]=specialPram.routeXiaohaiSize_2
self.routeModelSize[2]={}
self.routeModelSize[2][1]=specialPram.routeXiaorenSize_1
self.routeModelSize[2][2]=specialPram.routeXiaorenSize_2
self.routeModelSize[2][3]=0.45
self.routeModelSize[3]={}
self.routeModelSize[3][1]=specialPram.routeXiaorenSize_1
self.routeModelSize[3][2]=specialPram.routeXiaorenSize_2
self.routeModelSize[3][3]=0.45
self.routeModelSize[4]={}
self.routeModelSize[4][1]=specialPram.routeXiaorenSize_1
self.routeModelSize[4][2]=specialPram.routeXiaorenSize_2
self.routeModelSize[4][3]=0.45
self.routeModelSize[5]={}
self.routeModelSize[5][1]=specialPram.routeXiaorenSize_1
self.routeModelSize[5][2]=specialPram.routeXiaorenSize_2
self.routeModelSize[5][3]=0.45

self.rolePos=specialPram.pos
self.talkDesc=specialPram.talkDesc
else

logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的特殊参数 请检查配置是否正确",self.activityId,self.subType,self.subId))
end


self:refreshBgModel()

self:refresh()


self:refreshDZModel()
self:refreshXiaoHaiRunModel()
self:refreshXiaoRenRunModel()
self:refreshXiaoRenRunModel1()
self:refreshXiaoRenRunModel2()
self:refreshXiaoRenRunModel3()

self.desclist={}
local name="yishilaike_1"
local str=cfgHelper.get1(cfg_lang_get,name)
local descText=comHelper.getCheckLayoutStr(self.tempText:getGameObject(),385,str,true)
self.descText:setText(descText)
end


function UISubAct_tufaEventWin_YSLK:onHide()
self:clearDzBt()
self:clearTimer()
self:clearDelayClickTimer()
self:returnSpeakObj()

self:clearAllTimer()
self:resetEffectParent()
self.caoLingModel:setChildCanvasGroupAlpha(0)
self.xiaoRenModel:setChildCanvasGroupAlpha(0)
self.xiaoRenModel1:setChildCanvasGroupAlpha(0)
self.xiaoRenModel2:setChildCanvasGroupAlpha(0)
self.xiaoRenModel3:setChildCanvasGroupAlpha(0)
uiAIManager:removeUIInstance(self.bt_caoLing)
uiAIManager:removeUIInstance(self.bt_xiaoRen)
uiAIManager:removeUIInstance(self.bt_xiaoRen1)
uiAIManager:removeUIInstance(self.bt_xiaoRen2)
uiAIManager:removeUIInstance(self.bt_xiaoRen3)
self.bt_caoLing=nil
self.bt_xiaoRen=nil
self.bt_xiaoRen1=nil
self.bt_xiaoRen2=nil
self.bt_xiaoRen3=nil
end

function UISubAct_tufaEventWin_YSLK:refresh()

local abName="ui/windows/activities/sub_yishilaike/uiyslk_atlas_pak.ab"
local iconname=self.config.titleImage
if iconname then
self.title:setSprite(abName,iconname)
self.title:setActive(true)
else
self.title:setActive(false)
end


if self.config.infoDesc then
self.infoText:setText(self.config.infoDesc)
self.infoText:setActive(true)
self.infoBg:setActive(true)
else
self.infoText:setActive(false)
self.infoBg:setActive(false)
end


local grids=self.rewardList:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local reward=self.itemList[i]
if reward then
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildActive(-1,true)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
else
widget:SetChildActive(-1,false)
end
end


self:setRemainingTimeTimer()
end


function UISubAct_tufaEventWin_YSLK:refreshDZModel()
_this.roles1=_this.dzRoot:getWidgetBase()
_this.roles2=_this.dzRoot1:getWidgetBase()
local modelId={101017,103014}
local size=0.6
local animId=eAnimationID.stand
_this.roles1:SetChildAnchoredPosition(0,Vector2(self.rolePos[1][1],self.rolePos[1][2]))
_this.roles1:SetChildUIModelShowTarget(1,modelId[1],size,{},animId,false,false,0.5)
_this.rolestwordone=-1
_this.roles1:SetChildUIModelShowFlipX(1,_this.rolestwordone==1)
_this.roles1:SetChildActive(1,false)
_this:addDzBehaviorTree(2,2,1)

_this.roles2:SetChildAnchoredPosition(0,Vector2(self.rolePos[2][1],self.rolePos[2][2]))
_this.roles2:SetChildUIModelShowTarget(1,modelId[2],size,{},animId,false,false,0.5)
_this.rolestwordtwo=1
_this.roles2:SetChildUIModelShowFlipX(1,_this.rolestwordtwo==1)
end

function UISubAct_tufaEventWin_YSLK:addDzBehaviorTree(delayTime,flyTime,stateId)
_this:delayDo(delayTime,function()
_this.dzBt=behaviorManager:addBehaviorTree('bt_ui_act_yslk_dzfly',{},true,
{
winName="UISubAct_tufaEventWin_YSLK",
dzWidget=_this.roles1,
objTransform=_this.roles1:GetChildGameObject(1).transform,
dzIndex=1,
stateId=stateId,
flyTime=flyTime,
starPos=_this.bornPos:getChildPosition(),
idlePos=_this.idlePos:getChildPosition(),
endPos=_this.diePos:getChildPosition(),


rate=0.01,
})
end)
end

function UISubAct_tufaEventWin_YSLK:changeFlipX(dir)
_this.rolestwordone=dir
_this.roles1:SetChildUIModelShowFlipX(1,_this.rolestwordone==1)
end

function UISubAct_tufaEventWin_YSLK:upMount()
_this.roles1:SetChildModelAnimationState(1,eAnimationID.ui_jump2,1)
end


function UISubAct_tufaEventWin_YSLK:refreshXiaoHaiRunModel()
uiAIManager:removeUIInstance(self.bt_caoLing)
self.bt_caoLing=nil

self.caoLingModel:setChildCanvasGroupAlpha(0)


if not self.localPosList then
self.localPosList=self:getLocalPosList()
end

local modelId=5317
local tran=self.caoLingModel:getCommonComponent('Transform')
local vpos=Vector2.zero
local speed=self.caoLingRunSpeed

local initData={
winName="UISubAct_tufaEventWin_YSLK",
stateId=-1,
pos_1=self.localPosList[1],
pos_2=self.localPosList[2],
pos_3=self.localPosList[3],
pos_4=self.localPosList[4],
pos_5=self.localPosList[4],
pos_6=self.localPosList[6],
pos_7=self.localPosList[7],
pos_8=self.localPosList[8],
runSpeed=speed,
routeEndWaitTime_1=self.routeEndWaitTime_1,
routeEndWaitTime_2=self.routeEndWaitTime_2,
routeIndex=1,
modelBtIndex=1,
hideIndex=0,
isWait=false,
}
local func=function(bt)
self.bt_caoLing=bt
end
uiAIManager:createUIObject('UISubAct_tufaEventWin_YSLK','bt_ui_act_yslk_xiaohai',INSTANCE_TYPE.eUIDModel,modelId,tran,vpos,initData,nil,func)
end


function UISubAct_tufaEventWin_YSLK:refreshXiaoRenRunModel()
uiAIManager:removeUIInstance(self.bt_xiaoRen)
self.bt_xiaoRen=nil

self.xiaoRenModel:setChildCanvasGroupAlpha(0)


if not self.localPosList then
self.localPosList=self:getLocalPosList()
end

local tran=self.xiaoRenModel:getCommonComponent('Transform')
local vpos=Vector2.zero
local speed=self.lxtSpeed

local initData={
winName="UISubAct_tufaEventWin_YSLK",
stateId=-1,
pos_1=self.localPosList[17],
pos_2=self.localPosList[18],
pos_3=self.localPosList[9],
pos_4=self.localPosList[10],
pos_5=self.localPosList[10],
pos_6=self.localPosList[12],
pos_7=self.localPosList[13],
pos_8=self.localPosList[14],
pos_9=self.localPosList[22],
pos_10=self.localPosList[23],
pos_11=self.localPosList[24],
pos_12=self.localPosList[25],
runSpeed=speed,
runSpeed3=speed+10,
routeEndWaitTime_1=self.routeEndWaitTime_1,
routeEndWaitTime_2=self.routeEndWaitTime_2,
routeIndex=1,
modelBtIndex=2,
hideIndex=0,
isWait=false,
}
local func=function(bt)
self.bt_xiaoRen=bt
end

local modelId=5320
uiAIManager:createUIObject('UISubAct_tufaEventWin_YSLK','bt_ui_act_yslk_lxt2',INSTANCE_TYPE.eUIDModel,modelId,tran,vpos,initData,nil,func)
end


function UISubAct_tufaEventWin_YSLK:refreshXiaoRenRunModel1()
uiAIManager:removeUIInstance(self.bt_xiaoRen1)
self.bt_xiaoRen1=nil

self.xiaoRenModel1:setChildCanvasGroupAlpha(0)


if not self.localPosList then
self.localPosList=self:getLocalPosList()
end

local tran=self.xiaoRenModel1:getCommonComponent('Transform')
local vpos=Vector2.zero
local speed=self.lxtSpeed

local initData={
winName="UISubAct_tufaEventWin_YSLK",
stateId=-1,
pos_1=self.localPosList[15],
pos_2=self.localPosList[16],
pos_3=self.localPosList[9],
pos_4=self.localPosList[11],
pos_5=self.localPosList[11],
pos_6=self.localPosList[12],
pos_7=self.localPosList[20],
pos_8=self.localPosList[21],
pos_9=self.localPosList[22],
pos_10=self.localPosList[23],
pos_11=self.localPosList[24],
pos_12=self.localPosList[25],
runSpeed=speed,
runSpeed3=speed+10,
routeEndWaitTime_1=self.routeEndWaitTime_1,
routeEndWaitTime_2=self.routeEndWaitTime_2,
routeIndex=1,
modelBtIndex=3,
hideIndex=0,
isWait=false,
}
local func=function(bt)
self.bt_xiaoRen1=bt
end

local modelId=5314
uiAIManager:createUIObject('UISubAct_tufaEventWin_YSLK','bt_ui_act_yslk_lxt1',INSTANCE_TYPE.eUIDModel,modelId,tran,vpos,initData,nil,func)
end


function UISubAct_tufaEventWin_YSLK:refreshXiaoRenRunModel2()
uiAIManager:removeUIInstance(self.bt_xiaoRen2)
self.bt_xiaoRen2=nil

self.xiaoRenModel2:setChildCanvasGroupAlpha(0)


if not self.localPosList then
self.localPosList=self:getLocalPosList()
end

local tran=self.xiaoRenModel2:getCommonComponent('Transform')
local vpos=Vector2.zero
local speed=self.lxtSpeed

local initData={
winName="UISubAct_tufaEventWin_YSLK",
stateId=-1,
pos_1=self.localPosList[17],
pos_2=self.localPosList[18],
pos_3=self.localPosList[9],
pos_4=self.localPosList[12],
pos_5=self.localPosList[12],
pos_6=self.localPosList[12],
pos_7=self.localPosList[13],
pos_8=self.localPosList[14],
pos_9=self.localPosList[22],
pos_10=self.localPosList[23],
pos_11=self.localPosList[24],
pos_12=self.localPosList[25],
runSpeed=speed,
runSpeed3=speed+10,
routeEndWaitTime_1=self.routeEndWaitTime_1,
routeEndWaitTime_2=self.routeEndWaitTime_2,
routeIndex=1,
modelBtIndex=4,
hideIndex=0,
isWait=false,
}
local func=function(bt)
self.bt_xiaoRen2=bt
end

local modelId=5321
uiAIManager:createUIObject('UISubAct_tufaEventWin_YSLK','bt_ui_act_yslk_lxt1',INSTANCE_TYPE.eUIDModel,modelId,tran,vpos,initData,nil,func)
end


function UISubAct_tufaEventWin_YSLK:refreshXiaoRenRunModel3()
uiAIManager:removeUIInstance(self.bt_xiaoRen3)
self.bt_xiaoRen3=nil

self.xiaoRenModel3:setChildCanvasGroupAlpha(0)


if not self.localPosList then
self.localPosList=self:getLocalPosList()
end

local tran=self.xiaoRenModel3:getCommonComponent('Transform')
local vpos=Vector2.zero
local speed=self.lxtSpeed

local initData={
winName="UISubAct_tufaEventWin_YSLK",
stateId=-1,
pos_1=self.localPosList[15],
pos_2=self.localPosList[16],
pos_3=self.localPosList[9],
pos_4=self.localPosList[19],
pos_5=self.localPosList[19],
pos_6=self.localPosList[12],
pos_7=self.localPosList[20],
pos_8=self.localPosList[21],
pos_9=self.localPosList[22],
pos_10=self.localPosList[23],
pos_11=self.localPosList[24],
pos_12=self.localPosList[25],
runSpeed=speed,
runSpeed3=speed+10,
routeEndWaitTime_1=self.routeEndWaitTime_1,
routeEndWaitTime_2=self.routeEndWaitTime_2,
routeIndex=1,
modelBtIndex=5,
hideIndex=0,
isWait=false,
}
local func=function(bt)
self.bt_xiaoRen3=bt
end

local modelId=5324
uiAIManager:createUIObject('UISubAct_tufaEventWin_YSLK','bt_ui_act_yslk_lxt1',INSTANCE_TYPE.eUIDModel,modelId,tran,vpos,initData,nil,func)
end

function UISubAct_tufaEventWin_YSLK:getLocalPosList()
local localPostList={}

for i,posItem in ipairs(self.pos)do
local pos=posItem:getChildLocalPosition()
if pos then
localPostList[i]={pos.x,pos.y,pos.z}
end
end

return localPostList
end


function UISubAct_tufaEventWin_YSLK:refreshBgModel()
local bgModelId=5344
if bgModelId then
local animId=eAnimationID.stand
self.bgModel:setChildUIModelShowTarget(bgModelId,1,{},animId,false,false,0)
self.bgModel:setActive(true)
else
self.bgModel:setActive(false)
self.bgModel:setChildUIModelRemoveTarget()
end
end



function UISubAct_tufaEventWin_YSLK:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("<color=#f1ce78>活动剩余时间：</color>{0}",timeHelper.format_time_stamp11(lerp,true)))

else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()

end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_tufaEventWin_YSLK:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_tufaEventWin_YSLK:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end


function UISubAct_tufaEventWin_YSLK:modelBtWait(modelBtIndex,routeIndex)
if not self.waitModelBtList then
self.waitModelBtList={}
end

local routeDis
local delayTime
local fadeInStartPos
local fadeInEndPos
self.waitModelBtList[modelBtIndex]=routeIndex

if routeIndex==1 then

if self.waitModelBtList[1]==1 and self.waitModelBtList[2]==1 and self.waitModelBtList[3]==1
and self.waitModelBtList[4]==1 and self.waitModelBtList[5]==1 then

if self.isShow then
_this:changeFlipX(-1)
_this:addDzBehaviorTree(2,2,1)
end
self.isShow=true
self.waitModelBtList={}
fadeInStartPos=self.localPosList[1]
fadeInEndPos=self.localPosList[4]
routeDis=Vector2.Distance(Vector2.New(fadeInStartPos[1],fadeInStartPos[2]),Vector2.New(fadeInEndPos[1],fadeInEndPos[2]))
delayTime=routeDis/self.caoLingRunSpeed

self.bt_caoLing:setSharedVar("stateId",0)
_this.doPlay3=self:delayDo(5,function()
_this:doSpeaking_playerthree()
end)

self:clearDelayTimer()
self.delayTimer2=_this:delayDo(delayTime,function()
_this.bt_xiaoRen:setSharedVar("stateId",0)
end)
self.delayTimer3=_this:delayDo(delayTime,function()
_this.bt_xiaoRen1:setSharedVar("stateId",0)
end)
self.delayTimer4=_this:delayDo(delayTime+2,function()
_this.bt_xiaoRen2:setSharedVar("stateId",0)
end)
self.delayTimer5=_this:delayDo(delayTime+2,function()
_this.bt_xiaoRen3:setSharedVar("stateId",0)
end)
end
elseif routeIndex==2 then
delayTime=3
if self.waitModelBtList[1]==2 then
self:clearDelayTimer()
self.delayTimer1=self:delayDo(delayTime,function()
_this.bt_caoLing:setSharedVar("stateId",0)
end)
end

if self.waitModelBtList[2]==2 and self.waitModelBtList[3]==2 and self.waitModelBtList[4]==2 and self.waitModelBtList[5]==2 then
self:clearDelayTimer()
delayTime=1
self.delayTimer2=self:delayDo(delayTime,function()
_this.bt_xiaoRen:setSharedVar("stateId",0)
end)
self.delayTimer3=self:delayDo(delayTime+1,function()
_this.bt_xiaoRen1:setSharedVar("stateId",0)
end)
self.delayTimer4=self:delayDo(delayTime+1.5,function()
_this.bt_xiaoRen2:setSharedVar("stateId",0)
end)
self.delayTimer5=self:delayDo(delayTime+2,function()
_this.bt_xiaoRen3:setSharedVar("stateId",0)
end)
end
elseif routeIndex==3 then
if self.waitModelBtList[2]==3 and self.waitModelBtList[3]==3 and self.waitModelBtList[4]==3 and self.waitModelBtList[5]==3 then
self:clearDelayTimer()
delayTime=2
_this.doPlay2=self:delayDo(3,function()
_this:doSpeaking_playertwo(9)
end)
_this.doPlay5=self:delayDo(9,function()
_this:doSpeaking_playertwo(10)
end)
self.delayTimer2=self:delayDo(0,function()
_this.bt_xiaoRen:setSharedVar("stateId",0)
end)
self.delayTimer3=self:delayDo(delayTime,function()
_this.bt_xiaoRen1:setSharedVar("stateId",0)
end)
self.delayTimer4=self:delayDo(delayTime+2,function()
_this.bt_xiaoRen2:setSharedVar("stateId",0)
end)
self.delayTimer5=self:delayDo(delayTime+4.5,function()
_this.bt_xiaoRen3:setSharedVar("stateId",0)
end)
end
else
logErr(FMT.fmt("没有路线{0}对应的数据 请检查传参是否正确",routeIndex))
return
end
end

function UISubAct_tufaEventWin_YSLK:changeModelScale(modelBtIndex,routeIndex,modelWidget,modelIndex)
local scale=self.routeModelSize[modelBtIndex][routeIndex]
modelWidget:SetChildUIModelShowScale(modelIndex,scale)

if not self.modelEffectCreate[modelBtIndex]and modelBtIndex<=1 then

self.modelEffect[modelBtIndex]:setChildShowEffect(10196,true)
local modelTransform=modelWidget:GetChildGameObject(modelIndex).transform
local effectTransform=self.modelEffect[modelBtIndex]:getTransform()
effectTransform:SetParent(modelTransform)
self.modelEffectCreate[modelBtIndex]=true


local effectScale=120*scale
self.modelEffect[modelBtIndex]:setScale(Vector3.New(effectScale,effectScale,effectScale))
end
end


function UISubAct_tufaEventWin_YSLK:checkFadeByRouteIndex(modelBtIndex,routeIndex,modelWidget,modelIndex)
self:clearCheckTimer(modelBtIndex)
local fadeInStartPos
local fadeInEndPos
local fadeOutStartPos
local fadeOutEndPos

if routeIndex==1 then

if modelBtIndex==1 then
fadeInStartPos=self.localPosList[1]
fadeInEndPos=self.localPosList[2]
fadeOutStartPos=self.localPosList[3]
fadeOutEndPos=self.localPosList[4]
elseif modelBtIndex==2 then
fadeInStartPos=self.localPosList[17]
fadeInEndPos=self.localPosList[18]
fadeOutStartPos=self.localPosList[9]
fadeOutEndPos=self.localPosList[10]
elseif modelBtIndex==3 then
fadeInStartPos=self.localPosList[15]
fadeInEndPos=self.localPosList[16]
fadeOutStartPos=self.localPosList[9]
fadeOutEndPos=self.localPosList[10]
elseif modelBtIndex==4 then
fadeInStartPos=self.localPosList[17]
fadeInEndPos=self.localPosList[18]
fadeOutStartPos=self.localPosList[9]
fadeOutEndPos=self.localPosList[10]
elseif modelBtIndex==5 then
fadeInStartPos=self.localPosList[15]
fadeInEndPos=self.localPosList[16]
fadeOutStartPos=self.localPosList[9]
fadeOutEndPos=self.localPosList[10]
end
elseif routeIndex==2 then
if modelBtIndex==1 then
fadeInStartPos=self.localPosList[5]
fadeInEndPos=self.localPosList[6]
fadeOutStartPos=self.localPosList[7]
fadeOutEndPos=self.localPosList[8]
elseif modelBtIndex==2 then
fadeInStartPos=self.localPosList[10]
fadeInEndPos=self.localPosList[12]
fadeOutStartPos=self.localPosList[13]
fadeOutEndPos=self.localPosList[14]
elseif modelBtIndex==3 then
fadeInStartPos=self.localPosList[11]
fadeInEndPos=self.localPosList[16]
fadeOutStartPos=self.localPosList[20]
fadeOutEndPos=self.localPosList[21]
elseif modelBtIndex==4 then
fadeInStartPos=self.localPosList[12]
fadeInEndPos=self.localPosList[18]
fadeOutStartPos=self.localPosList[13]
fadeOutEndPos=self.localPosList[14]
elseif modelBtIndex==5 then
fadeInStartPos=self.localPosList[19]
fadeInEndPos=self.localPosList[16]
fadeOutStartPos=self.localPosList[20]
fadeOutEndPos=self.localPosList[21]
end
elseif routeIndex==3 then
fadeInStartPos=self.localPosList[22]
fadeInEndPos=self.localPosList[23]
fadeOutStartPos=self.localPosList[24]
fadeOutEndPos=self.localPosList[25]
else
logErr(FMT.fmt("没有路线{0}对应的数据 请检查传参是否正确",routeIndex))
return
end


local fadeInDis=Vector2.Distance(Vector2.New(fadeInStartPos[1],fadeInStartPos[2]),Vector2.New(fadeInEndPos[1],fadeInEndPos[2]))
local fadeInTime=fadeInDis/self.caoLingRunSpeed

local fadeOutDis=Vector2.Distance(Vector2.New(fadeOutStartPos[1],fadeOutStartPos[2]),Vector2.New(fadeOutEndPos[1],fadeOutEndPos[2]))
local fadeOutTime=fadeOutDis/self.caoLingRunSpeed
fadeInTime=0.9
fadeOutTime=0.9
self.fadeOutTime[modelBtIndex]=fadeOutTime


self:clearDoFadeInTweener(modelBtIndex)
self:clearDoFadeOutTweener(modelBtIndex)
self.doFadeInTweener[modelBtIndex]=self.model[modelBtIndex]:setChildCanvasGroupDOFade(1,fadeInTime)



self.checkStartPos_x[modelBtIndex]=fadeInStartPos[1]
self.checkTargetPos_x[modelBtIndex]=fadeOutStartPos[1]
self.modelWidget[modelBtIndex]=modelWidget
self.modelIndex[modelBtIndex]=modelIndex
self.checkFadeOut[modelBtIndex]=true
local index=modelBtIndex

self.checkTimer[modelBtIndex]=self:setTimer(0.02,0,function()
_this.onCheckFadeOut(index)
end)
end


function UISubAct_tufaEventWin_YSLK:stopCheckFadeOut(modelBtIndex)
self.checkFadeOut[modelBtIndex]=false
self:clearCheckTimer(modelBtIndex)
end


function UISubAct_tufaEventWin_YSLK:clearCheckTimer(modelBtIndex)
if self.checkTimer[modelBtIndex]then
self:stopTimerByID(self.checkTimer[modelBtIndex])
end
end

function UISubAct_tufaEventWin_YSLK.onCheckFadeOut(modelBtIndex)
if not _this.checkFadeOut[modelBtIndex]then
return
end

local modelPos=_this.modelWidget[modelBtIndex]:GetChildLocalPosition(_this.modelIndex[modelBtIndex])



if(modelPos.x-_this.checkStartPos_x[modelBtIndex])*(modelPos.x-_this.checkTargetPos_x[modelBtIndex])>0 then
_this.checkFadeOut[modelBtIndex]=false

_this:clearDoFadeInTweener(modelBtIndex)
_this:clearDoFadeOutTweener(modelBtIndex)
if modelBtIndex~=1 then
_this.doFadeOutTweener[modelBtIndex]=_this.model[modelBtIndex]:setChildCanvasGroupDOFade(0,_this.fadeOutTime[modelBtIndex])
return _this:clearCheckTimer(modelBtIndex)
end
end
end

function UISubAct_tufaEventWin_YSLK:clearAllDoFadeTweener()
self:clearDoFadeInTweener(1)
self:clearDoFadeInTweener(2)
self:clearDoFadeInTweener(3)
self:clearDoFadeInTweener(4)
self:clearDoFadeInTweener(5)
self:clearDoFadeOutTweener(1)
self:clearDoFadeOutTweener(2)
self:clearDoFadeOutTweener(3)
self:clearDoFadeOutTweener(4)
self:clearDoFadeOutTweener(5)
end

function UISubAct_tufaEventWin_YSLK:clearDoFadeInTweener(modelBtIndex)
if self.doFadeInTweener[modelBtIndex]then
self.doFadeInTweener[modelBtIndex]:Kill()
self.doFadeInTweener[modelBtIndex]=nil
end
end

function UISubAct_tufaEventWin_YSLK:clearDoFadeOutTweener(modelBtIndex)
if self.doFadeOutTweener[modelBtIndex]then
self.doFadeOutTweener[modelBtIndex]:Kill()
self.doFadeOutTweener[modelBtIndex]=nil
end
end


function UISubAct_tufaEventWin_YSLK:clearAllTimer()
self:clearTimer()
self:clearCheckTimer(1)
self:clearCheckTimer(2)
self:clearCheckTimer(3)
self:clearCheckTimer(4)
self:clearCheckTimer(5)
self:clearAllDoFadeTweener()
self:clearDelayTimer()
self:clearDelayClickTimer()
self:closeSpeakShowTimer()
end

function UISubAct_tufaEventWin_YSLK:clearDelayTimer()
if self.delayTimer1 then
self:stopTimerByID(self.delayTimer1)
end
if self.delayTimer2 then
self:stopTimerByID(self.delayTimer2)
end
if self.delayTimer3 then
self:stopTimerByID(self.delayTimer3)
end
if self.delayTimer4 then
self:stopTimerByID(self.delayTimer4)
end
if self.delayTimer5 then
self:stopTimerByID(self.delayTimer5)
end
end

function UISubAct_tufaEventWin_YSLK:clearDelayClickTimer()
if self.delayClickTimer then
self:stopTimerByID(self.delayClickTimer)
end
end

function UISubAct_tufaEventWin_YSLK:resetEffectParent()
local caolingEffectTran=self.caolingEffect:getTransform()
local caoLingModelTran=self.caoLingModel:getTransform()
caolingEffectTran:SetParent(caoLingModelTran)
self.caolingEffect:setChildShowEffect(0,false)
self.caolingEffect:setLocalPos(0,0,0)

local xiaorenEffectTran=self.xiaorenEffect:getTransform()
local xiaoRenModelTran=self.xiaoRenModel:getTransform()
xiaorenEffectTran:SetParent(xiaoRenModelTran)
self.xiaorenEffect:setChildShowEffect(0,false)
self.xiaorenEffect:setLocalPos(0,0,0)
end

function UISubAct_tufaEventWin_YSLK:showEffectParent()
_this:delayDo(0.5,function()
self.caolingEffect:setChildShowEffect(10196,true)
end)
end

function UISubAct_tufaEventWin_YSLK:hideEffectParent()
self.caolingEffect:setChildShowEffect(0,false)
end


function UISubAct_tufaEventWin_YSLK:onHelpBtn()
if not self.isClickHelp then
self.isClickHelp=true
else
self.isClickHelp=false
end

self.helpPanel:setActive(self.isClickHelp)
end

function UISubAct_tufaEventWin_YSLK:UpdateViewone()
if _this.refreshTimeId1 then
_this:stopTimerByID(_this.refreshTimeId1)
_this.refreshTimeId1=nil
end
_this.refreshTimeFunc=function()
local fun=function()
if _this==nil then return end
_this.roles1:SetChildModelAnimationState(1,eAnimationID.stand)
end
if _this==nil then return end

local pos=_this.roles1:GetChildLocalPosition(0)
if pos.x==_this.rightpointtop1[1]or pos.x==_this.leftpointtop1[1]then
_this.rolestwordone=-_this.rolestwordone
end

_this.roles1:SetChildModelAnimationState(1,eAnimationID.walk)
_this.roles1:SetChildUIModelShowFlipX(1,_this.rolestwordone==1)

if _this.rolestwordone==1 then
_this.tweener1=_this.roles1:SetChildDOAnchorPosX(0,_this.rightpointtop1[1],3,fun)
_this.tweener1:SetEase(_Ease.Linear)
elseif _this.rolestwordone==-1 then
_this.tweener1=_this.roles1:SetChildDOAnchorPosX(0,_this.leftpointtop1[1],4,fun)
_this.tweener1:SetEase(_Ease.Linear)
end
end
_this.refreshTimeFunc()
_this.refreshTimeId1=_this:setTimer(8.5,0,_this.refreshTimeFunc)
end

function UISubAct_tufaEventWin_YSLK:UpdateViewtwo()
if _this.refreshTimeId2 then
_this:stopTimerByID(_this.refreshTimeId2)
_this.refreshTimeId2=nil
end
_this.refreshTimeFunc=function()
local fun=function()
if _this==nil then return end
_this.roles2:SetChildModelAnimationState(1,eAnimationID.stand)
end
if _this==nil then return end

local pos=_this.roles2:GetChildLocalPosition(0)
if pos.x==_this.rightpointtop2[1]or pos.x==_this.leftpointtop2[1]then
_this.rolestwordtwo=-_this.rolestwordtwo
end

_this.roles2:SetChildModelAnimationState(1,eAnimationID.walk)
_this.roles2:SetChildUIModelShowFlipX(1,_this.rolestwordtwo==1)

if _this.rolestwordtwo==1 then
_this.tweener2=_this.roles2:SetChildDOAnchorPosX(0,_this.rightpointtop2[1],3,fun)
_this.tweener2:SetEase(_Ease.Linear)
elseif _this.rolestwordtwo==-1 then
_this.tweener2=_this.roles2:SetChildDOAnchorPosX(0,_this.leftpointtop2[1],4,fun)
_this.tweener2:SetEase(_Ease.Linear)
end
end
_this.refreshTimeFunc()
_this.refreshTimeId2=_this:setTimer(7,0,_this.refreshTimeFunc)
end

function UISubAct_tufaEventWin_YSLK:doSpeaking_player(modelBtIndex,modelIndex,modelWidget)
local speed=30
local speakStr=_this.talkDesc[1]
if modelBtIndex>1 then speakStr=_this.talkDesc[5]end

_this.winlua:SetChildCanvasGroupAlpha(_this.speakObj[modelBtIndex]:getID(),1)
_this.winlua:SetChildTrendsTextPlay(_this.speakText[modelBtIndex]:getID(),speakStr,speed,nil)
_this:doTalkAnim_player(modelBtIndex)
end

function UISubAct_tufaEventWin_YSLK:doTalkAnim_player(modelBtIndex)
if _this.talkTween~=nil then
_this.talkTween:Kill()
_this.talkTween=nil
end

_this.winlua:SetChildScale(_this.speakObj[modelBtIndex]:getID(),Vector3.zero)
_this.doTalk=_this:delayDo(0.2,function()
_this.talkTween=_this.winlua:SetChildDOScaleY(_this.speakObj[modelBtIndex]:getID(),1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.winlua:SetChildDOScale(_this.speakObj[modelBtIndex]:getID(),0.8,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd(modelBtIndex)
end)
end)
end)
end

function UISubAct_tufaEventWin_YSLK:talkEnd(modelBtIndex)
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
_this.speakShowTimer=_this:delayDo(2,function()

if _this==nil then return end
_this.winlua:SetChildScale(_this.speakObj[modelBtIndex]:getID(),Vector3.zero)
_this.winlua:SetChildCanvasGroupAlpha(_this.speakObj[modelBtIndex]:getID(),0)

if modelBtIndex==1 then _this:doSpeaking_playerone()end

if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
end)
end

function UISubAct_tufaEventWin_YSLK:doSpeaking_playerone()
local speed=30
local speakStr=_this.talkDesc[2]

self.doPlay1=_this:delayDo(1.5,function()
_this.rolestwordone=1
_this.roles1:SetChildUIModelShowFlipX(1,_this.rolestwordone==1)
_this.roles1:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this.roles1:SetChildCanvasGroupAlpha(2,1)
_this:doTalkAnim_playerone()
_this:delayDo(0.5,function()
_this.roles1:SetChildChangeSlotDisplay(1,"face","face",1110002)
end)
end)
end

function UISubAct_tufaEventWin_YSLK:doTalkAnim_playerone()
if _this.talkTween1~=nil then
_this.talkTween1:Kill()
_this.talkTween1=nil
end

_this.roles1:SetChildScale(2,Vector3.zero)
_this.doTalk1=_this:delayDo(0.2,function()
_this.roles1:SetChildCanvasGroupAlpha(2,1)
_this.talkTween1=_this.roles1:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTween1=nil
_this.talkTween1=_this.roles1:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTween1=nil
return _this:talkEndone()
end)
end)
end)
end

function UISubAct_tufaEventWin_YSLK:talkEndone()
if _this.speakShowTimerone then
_this:stopTimerByID(_this.speakShowTimerone)
_this.speakShowTimerone=nil
end
_this.speakShowTimerone=_this:delayDo(2.5,function()

if _this==nil then return end
_this.roles1:SetChildScale(2,Vector3.zero)
_this.roles1:SetChildCanvasGroupAlpha(2,0)

if _this.speakShowTimerone then
_this:stopTimerByID(_this.speakShowTimerone)
_this.speakShowTimerone=nil
end
end)

_this.doEnd1=_this:delayDo(3.3,function()
_this.rolestwordone=-1
_this.roles1:SetChildChangeSlotDisplay(1,"face","face",0)
_this:addDzBehaviorTree(1.5,2,2)
end)
end

function UISubAct_tufaEventWin_YSLK:doSpeaking_playertwo(index)
local speed=30
local speakStr=_this.talkDesc[3]
if index then speakStr=_this.talkDesc[index]end
_this.roles2:SetChildChangeSlotDisplay(1,"face","face",1110008)
_this.roles2:SetChildCanvasGroupAlpha(2,1)
_this.roles2:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playertwo()
end

function UISubAct_tufaEventWin_YSLK:doTalkAnim_playertwo()
if _this.talkTween2~=nil then
_this.talkTween2:Kill()
_this.talkTween2=nil
end

_this.roles2:SetChildScale(2,Vector3.zero)
_this.doTalk2=_this:delayDo(0.2,function()
_this.roles2:SetChildCanvasGroupAlpha(2,1)
_this.talkTween2=_this.roles2:SetChildDOScaleY(2,1.2,0.2,function()
if _this==nil then return end
_this.talkTween2=nil
_this.talkTween2=_this.roles2:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTween2=nil
return _this:talkEndtwo()
end)
end)
end)
end

function UISubAct_tufaEventWin_YSLK:talkEndtwo()
if _this.speakShowTimertwo then
_this:stopTimerByID(_this.speakShowTimertwo)
_this.speakShowTimertwo=nil
end
_this.speakShowTimertwo=_this:delayDo(3.5,function()

if _this==nil then return end
_this.roles2:SetChildScale(2,Vector3.zero)
_this.roles2:SetChildCanvasGroupAlpha(2,0)
_this.roles2:SetChildChangeSlotDisplay(1,"face","face",0)

if _this.speakShowTimertwo then
_this:stopTimerByID(_this.speakShowTimertwo)
_this.speakShowTimertwo=nil
end
end)
end

function UISubAct_tufaEventWin_YSLK:doSpeaking_playerthree()
local speed=30
local speakStr=_this.talkDesc[4]

_this.roles1:SetChildCanvasGroupAlpha(2,1)
_this.roles1:SetChildTrendsTextPlay(3,speakStr,speed,nil)
_this:doTalkAnim_playerthree()
end

function UISubAct_tufaEventWin_YSLK:doTalkAnim_playerthree()
if _this.talkTween3~=nil then
_this.talkTween3:Kill()
_this.talkTween3=nil
end

_this.roles1:SetChildScale(2,Vector3.zero)
_this.doTalk3=_this:delayDo(0.2,function()
_this.roles1:SetChildCanvasGroupAlpha(2,1)
_this.talkTween3=_this.roles1:SetChildDOScaleY(2,2,0.2,function()
if _this==nil then return end
_this.talkTween3=nil
_this.talkTween3=_this.roles1:SetChildDOScale(2,0.8,0.1,function()
if _this==nil then return end
_this.talkTween3=nil
return _this:talkEndthree()
end)
end)
end)
end

function UISubAct_tufaEventWin_YSLK:talkEndthree()
if _this.speakShowTimerthree then
_this:stopTimerByID(_this.speakShowTimerthree)
_this.speakShowTimerthree=nil
end
_this.speakShowTimerthree=_this:delayDo(1.5,function()

if _this==nil then return end
_this.roles1:SetChildScale(2,Vector3.zero)
_this.roles1:SetChildCanvasGroupAlpha(2,0)
_this.roles1:SetChildChangeSlotDisplay(1,"face","face",0)

if _this.speakShowTimerthree then
_this:stopTimerByID(_this.speakShowTimerthree)
_this.speakShowTimerthree=nil
end
end)
end

function UISubAct_tufaEventWin_YSLK:doSpeaking_player4(modelBtIndex,modelIndex,modelWidget)
local speed=30
local speakStr
local delayTime
if modelBtIndex==3 then
delayTime=7
speakStr=_this.talkDesc[6]
elseif modelBtIndex==4 then
delayTime=11
speakStr=_this.talkDesc[8]
elseif modelBtIndex==5 then
delayTime=8
speakStr=_this.talkDesc[7]
end

local transform=_this.speakObj[modelBtIndex]:getTransform()
local modelTransform=modelWidget:GetChildGameObject(modelIndex).transform
transform:SetParent(modelTransform)

_this.doPlay4=_this:delayDo(delayTime,function()
_this.winlua:SetChildCanvasGroupAlpha(_this.speakObj[modelBtIndex]:getID(),1)
_this.winlua:SetChildTrendsTextPlay(_this.speakText[modelBtIndex]:getID(),speakStr,speed,nil)
_this:doTalkAnim_player4(modelBtIndex)
end)
end

function UISubAct_tufaEventWin_YSLK:doTalkAnim_player4(modelBtIndex)
if _this.talkTween4~=nil then
_this.talkTween4:Kill()
_this.talkTween4=nil
end

_this.winlua:SetChildScale(_this.speakObj[modelBtIndex]:getID(),Vector3.zero)
_this.doTalk4=_this:delayDo(0.2,function()
_this.talkTween4=_this.winlua:SetChildDOScaleY(_this.speakObj[modelBtIndex]:getID(),1.2,0.2,function()
if _this==nil then return end
_this.talkTween4=nil
_this.talkTween4=_this.winlua:SetChildDOScale(_this.speakObj[modelBtIndex]:getID(),0.8,0.1,function()
if _this==nil then return end
_this.talkTween4=nil
return _this:talkEnd4(modelBtIndex)
end)
end)
end)
end

function UISubAct_tufaEventWin_YSLK:talkEnd4(modelBtIndex)
if _this.speakShowTimer4 then
_this:stopTimerByID(_this.speakShowTimer4)
_this.speakShowTimer4=nil
end
_this.speakShowTimer4=_this:delayDo(2,function()

if _this==nil then return end
_this.winlua:SetChildScale(_this.speakObj[modelBtIndex]:getID(),Vector3.zero)
_this.winlua:SetChildCanvasGroupAlpha(_this.speakObj[modelBtIndex]:getID(),0)

if _this.speakShowTimer4 then
_this:stopTimerByID(_this.speakShowTimer4)
_this.speakShowTimer4=nil
end
end)
end

function UISubAct_tufaEventWin_YSLK:clearDzBt()
if _this.dzBt then
behaviorManager:removeBehaviorTree(_this.dzBt)
_this.dzBt=nil
end
end

function UISubAct_tufaEventWin_YSLK:closeSpeakShowTimer()
if _this.speakShowTimer then
_this:stopTimerByID(_this.speakShowTimer)
_this.speakShowTimer=nil
end
if _this.speakShowTimerone then
_this:stopTimerByID(_this.speakShowTimerone)
_this.speakShowTimerone=nil
end
if _this.speakShowTimertwo then
_this:stopTimerByID(_this.speakShowTimertwo)
_this.speakShowTimertwo=nil
end
if _this.speakShowTimerthree then
_this:stopTimerByID(_this.speakShowTimerthree)
_this.speakShowTimerthree=nil
end
if _this.speakShowTimer4 then
_this:stopTimerByID(_this.speakShowTimer4)
_this.speakShowTimer4=nil
end

if _this.doPlay1 then
_this:stopTimerByID(_this.doPlay1)
_this.doPlay1=nil
end
if _this.doPlay2 then
_this:stopTimerByID(_this.doPlay2)
_this.doPlay2=nil
end
if _this.doPlay3 then
_this:stopTimerByID(_this.doPlay3)
_this.doPlay3=nil
end
if _this.doPlay4 then
_this:stopTimerByID(_this.doPlay4)
_this.doPlay4=nil
end
if _this.doPlay5 then
_this:stopTimerByID(_this.doPlay5)
_this.doPlay5=nil
end

if _this.doTalk1 then
_this:stopTimerByID(_this.doTalk1)
_this.doTalk1=nil
end
if _this.doTalk2 then
_this:stopTimerByID(_this.doTalk2)
_this.doTalk2=nil
end
if _this.doTalk3 then
_this:stopTimerByID(_this.doTalk3)
_this.doTalk3=nil
end
if _this.doTalk4 then
_this:stopTimerByID(_this.doTalk4)
_this.doTalk4=nil
end

if _this.talkTween1~=nil then
_this.talkTween1:Kill()
_this.talkTween1=nil
end
if _this.talkTween2~=nil then
_this.talkTween2:Kill()
_this.talkTween2=nil
end
if _this.talkTween3~=nil then
_this.talkTween3:Kill()
_this.talkTween3=nil
end
if _this.talkTween4~=nil then
_this.talkTween4:Kill()
_this.talkTween4=nil
end
end

function UISubAct_tufaEventWin_YSLK:returnSpeakObj()
for i=1,5 do
local pos
local modelTransform
local transform=_this.speakObj[i]:getTransform()

if i==3 then
modelTransform=self.xiaoRenModel1:getTransform()
pos=Vector3.New(-470,-230,0)
elseif i==4 then
modelTransform=self.xiaoRenModel2:getTransform()
pos=Vector3.New(-300,-280,0)
elseif i==5 then
modelTransform=self.xiaoRenModel3:getTransform()
pos=Vector3.New(-450,-220,0)
end
if modelTransform then
transform:SetParent(modelTransform)
_this.winlua:SetChildAnchoredPosition(_this.speakObj[i]:getID(),pos)
end

_this.winlua:SetChildScale(_this.speakObj[i]:getID(),Vector3.zero)
_this.winlua:SetChildCanvasGroupAlpha(_this.speakObj[i]:getID(),0)
end

_this.roles1:SetChildScale(2,Vector3.zero)
_this.roles1:SetChildCanvasGroupAlpha(2,0)
_this.roles2:SetChildScale(2,Vector3.zero)
_this.roles2:SetChildCanvasGroupAlpha(2,0)
end