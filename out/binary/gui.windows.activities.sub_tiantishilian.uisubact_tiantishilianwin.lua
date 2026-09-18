







def_class("UISubAct_TianTiShiLianWin",UIWindowBase)









function UISubAct_TianTiShiLianWin:bindComponents()

self.root=UIObject.get(self,0)
self.mid=UIObject.get(self,1)
self.todayLevelInfo=UIText.get(self,2)
self.startGame=UIButton.get(self,3)
self.cyjbg=UIObject.get(self,4)
self.cyjrb=UIObject.get(self,5)
self.selectDiscipleBtnRoot=UIObject.get(self,6)
self.selectDiscipleBtn=UIButton.get(self,7)
self.changeDiscipleBtn=UIButton.get(self,8)
self.gameRuleBtn=UIButton.get(self,9)
self.rewardBtn=UIButton.get(self,10)
self.fallDiscipleList=UIObject.get(self,11)
self.rewardReddot=UIObject.get(self,12)
self.selectDisciple=UIObject.get(self,13)

self.startGame:setButtonClick(function()self:onStartGame()end)

self.selectDiscipleBtn:setButtonClick(function()self:onSelectDiscipleBtn()end)

self.changeDiscipleBtn:setButtonClick(function()self:onChangeDiscipleBtn()end)

self.gameRuleBtn:setButtonClick(function()self:onGameRuleBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UISubAct_TianTiShiLianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.mid);self.mid=nil;
_UIObject_release(self.todayLevelInfo);self.todayLevelInfo=nil;
_UIObject_release(self.startGame);self.startGame=nil;
_UIObject_release(self.cyjbg);self.cyjbg=nil;
_UIObject_release(self.cyjrb);self.cyjrb=nil;
_UIObject_release(self.selectDiscipleBtnRoot);self.selectDiscipleBtnRoot=nil;
_UIObject_release(self.selectDiscipleBtn);self.selectDiscipleBtn=nil;
_UIObject_release(self.changeDiscipleBtn);self.changeDiscipleBtn=nil;
_UIObject_release(self.gameRuleBtn);self.gameRuleBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.fallDiscipleList);self.fallDiscipleList=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.selectDisciple);self.selectDisciple=nil;
end
















local _this



function UISubAct_TianTiShiLianWin:onLoaded(...)
self:bindComponents()
_this=self

local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue
self.screenWidthHalf=UnityEngine.Screen.width/scaleFactor.x/2
self.screenHeightHalf=UnityEngine.Screen.height/scaleFactor.y/2

self.fallDiscipleItemList_stand={}
self.fallDiscipleList:setChildLayoutGroupCreateItems(10,function(index)
local item=self.fallDiscipleList:getChildLayoutGroupGridItem(index-1)
table.insert(self.fallDiscipleItemList_stand,item)
end)

self.fallDiscipleItemList_falling={}

end


function UISubAct_TianTiShiLianWin:__delete()
self:unbindComponents()
end




function UISubAct_TianTiShiLianWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eTianTiShiLian
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)




self:refresh()
self:randomFallDisciple()

end


function UISubAct_TianTiShiLianWin:onHide()

end

function UISubAct_TianTiShiLianWin:refresh()
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
self.startday=self.info.start_day_idx
self.start_time=self.info.start_time
self.end_time=self.info.end_time

self.todayLevelInfo:setText(FMT.fmt("本日最高层数：{0}",self.info.todayfloor))

self.selectDiscipleBtn:setActive(self.selectDzGuid==nil)
self.changeDiscipleBtn:setActive(self.selectDzGuid~=nil)
self.cyjbg:setActive(not self.info.isReceiveJoinReward)
local hasAchieveReddot=activitiesHandle_tiantishilian.checkAchieve(self.actid,self.subType,self.subid)
self.rewardReddot:setActive(hasAchieveReddot)
end

function UISubAct_TianTiShiLianWin:refreshSelectDz(dzguid)

self.selectDzGuid=dzguid
self:refresh()
if self.selectDiscipleTweenner then
self.selectDiscipleTweenner:Kill()
self.selectDiscipleTweenner=nil
end
self.selectDisciple:setChildAnchoredPos(284,-221)

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid,true,nil,nil)
self.selectDisciple:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,0,false,false,0,nil)
self.selectDisciple:setChildCanvasGroupAlpha(0)
self.selectDisciple:setChildCanvasGroupDOFade(1,0.25,function()
self.selectAiDirection=-1
self:returnSelectAI()
end)
end

function UISubAct_TianTiShiLianWin:returnSelectAI()
if self.selectDzGuid then
if self.selectAiDirection==-1 then
self.selectDisciple:setChildModelAnimationState(eAnimationID.stand,1,nil)
self.selectDisciple:setRotation(0,0,0)
self:delayDo(2,function()

self.selectDisciple:setChildModelAnimationState(eAnimationID.walk,1,nil)
self.selectDiscipleTweenner=self.selectDisciple:setChildDOLocalMoveX(-400,20,function()
self.selectAiDirection=self.selectAiDirection*-1
self:returnSelectAI()
end)
self.selectDiscipleTweenner:SetEase(_Ease.Linear)
end)
else
self.selectDisciple:setChildModelAnimationState(eAnimationID.stand,1,nil)
self.selectDisciple:setRotation(0,180,0)
self:delayDo(2,function()
self.selectDisciple:setChildModelAnimationState(eAnimationID.walk,1,nil)
self.selectDiscipleTweenner=self.selectDisciple:setChildDOLocalMoveX(279,20,function()
self.selectAiDirection=self.selectAiDirection*-1
self:returnSelectAI()
end)
self.selectDiscipleTweenner:SetEase(_Ease.Linear)
end)
end
end
end

function UISubAct_TianTiShiLianWin:randomFallDisciple()
if#self.fallDiscipleItemList_stand>0 then
local discipleItem=table.remove(self.fallDiscipleItemList_stand,1)
local randomPosx=Mathf.Random(0,self.screenWidthHalf*2-100)
discipleItem:SetChildAnchoredPos(-1,randomPosx,self.screenHeightHalf*2+100)
discipleItem:SetChildActive(-1,true)
local randomDelayTime=Mathf.Random(10,20)
if discipleItem then
self:delayDo(randomDelayTime,function()
self:randomFallDisciple()
discipleItem:SetChildUIModelShowTarget(-1,1113002,1,nil,eAnimationID.stand)
local tw1=discipleItem:SetChildDOLocalMoveY(-1,100,10,function()
discipleItem:SetChildModelAnimationState(-1,eAnimationID.walk,1,nil)
local needTime=Mathf.Abs(-self.screenWidthHalf-randomPosx)
local tw2=discipleItem:SetChildDOLocalMoveX(-1,-100,needTime/100,function()
discipleItem:SetChildActive(-1,false)
table.insert(self.fallDiscipleItemList_stand,discipleItem)
end)
tw2:SetEase(_Ease.Linear)
end)
tw1:SetEase(_Ease.Linear)
end)
end
end
end





function UISubAct_TianTiShiLianWin:onStartGame()
if self.selectDzGuid==nil then
UIManager.info("请先选择弟子")
return
end
local settlementFunc=function(floor,rewardboxnum)
rewardboxnum=rewardboxnum or 0
if floor>0 and rewardboxnum>0 then
activitiesHandle_tiantishilian:sendFinishFloor(_this.actid,_this.subid,floor,rewardboxnum)
elseif floor>0 and rewardboxnum==0 and not self.info.isReceiveJoinReward then

local items={}
for k,v in pairs(_this.config.attend or{})do
table.insert(items,{itemid=v[1],itemcount=v[2]})
end
local effectData={
effecttype=ePrizeType.eTianTiShiLian,
actid=_this.actid,
act2id=_this.subid,
floor=floor,
todayfloor=floor,
}
local winArgs={
extraWin="UILingYunLanZhongVictoryWin",
extraParams={
items=items,
title=nil,
tips="",
effectData=effectData
},
btnsInfo={
continuCallBack=function()
if UIManager:isActive("UISubAct_TianTiShiLianWin")then
UIManager:invokeUIMethod("UISubAct_TianTiShiLianWin","onStartGame")
end
end,
quitCallBack=function()end,
continueBtnName="重新开始",
quitBtnName="退出"
},
battleId=-1,
}
UIManager:showWindow("UICommonVictoryWin",winArgs)


_this.info.isReceiveJoinReward=true
activitiesModel:setSubActInfoData(_this.actid,_this.subType,_this.subid,_this.info)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,_this.subType)
else

local effectData={
effecttype=ePrizeType.eTianTiShiLian,
actid=_this.actid,
act2id=_this.subid,
floor=floor,
todayfloor=_this.info.todayfloor,
}
local winArgs={
extraWin="UILingYunLanZhongVictoryWin",
extraParams={
items=nil,
title=nil,
tips="",
effectData=effectData
},
btnsInfo={
continuCallBack=function()
if UIManager:isActive("UISubAct_TianTiShiLianWin")then
UIManager:invokeUIMethod("UISubAct_TianTiShiLianWin","onStartGame")
end
end,
quitCallBack=function()end,
continueBtnName="重新开始",
quitBtnName="退出"
},
battleId=-1,
}
UIManager:showWindow("UICommonVictoryWin",winArgs)
end
end
local args={
limitSwapRewardBoxNum=self.config.daily[1]-_this.info.boxcnt,
settlementFunc=settlementFunc,
subid=_this.subid,
discipleguid=self.selectDzGuid
}
local showcallback=function()
UILittleGameController:openLittleGame(littleGameType.eLingYunLanZhong,args,nil,nil)
end

self:showWindow("UILingYunLanZhongRuleShowWin",{
showcallback=showcallback
})
end



function UISubAct_TianTiShiLianWin:onSelectDiscipleBtn()
local callback=function(...)

_this:refreshSelectDz(...)
end
local args={
openType=dzSelectWinOpenType.eTianTiShiLian,
canvasIdx=8,
callback=callback,
}
discipleSelectController:openDiscipleSelect(args)
end



function UISubAct_TianTiShiLianWin:onChangeDiscipleBtn()
local callback=function(...)

_this:refreshSelectDz(...)
end
local discipleData=UIDiscipleModel:getMyDiscipleData(self.selectDzGuid)
local dzIdStr=discipleData.netData.discipleguidStr
local args={
openType=dzSelectWinOpenType.eTianTiShiLian,
canvasIdx=8,
callback=callback,
dzIdStr=dzIdStr,
}
discipleSelectController:openDiscipleSelect(args)
end



function UISubAct_TianTiShiLianWin:onGameRuleBtn()
end



function UISubAct_TianTiShiLianWin:onRewardBtn()
self:showWindow("UISubAct_TianTiShiLian_AchieveWin",self.activityArgs)
end

