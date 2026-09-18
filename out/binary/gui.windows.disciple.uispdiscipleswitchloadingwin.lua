







def_class("UISpDiscipleSwitchLoadingWin",UIWindowBase)









function UISpDiscipleSwitchLoadingWin:bindComponents()

self.dzModel=UIObject.get(self,0)
self.effect=UIObject.get(self,1)
self.mask=UIObject.get(self,2)
self.progressBar=UIProgressBarAni.get(self,3)
self.root=UIObject.get(self,4)
self.loadingText=UIText.get(self,5)
self.vocIcon1=UIImage.get(self,6)
self.vocIcon2=UIImage.get(self,7)
self.finishSwitchPanel=UIObject.get(self,8)
self.clickClose=UIButton.get(self,9)
self.effectModel=UIObject.get(self,10)
self.finishEffect=UIObject.get(self,11)
self.finishEffectBg=UIObject.get(self,12)
self.tipsText=UIText.get(self,13)

self.clickClose:setButtonClick(function()self:onClickClose()end)



end


function UISpDiscipleSwitchLoadingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.loadingText);self.loadingText=nil;
_UIObject_release(self.vocIcon1);self.vocIcon1=nil;
_UIObject_release(self.vocIcon2);self.vocIcon2=nil;
_UIObject_release(self.finishSwitchPanel);self.finishSwitchPanel=nil;
_UIObject_release(self.clickClose);self.clickClose=nil;
_UIObject_release(self.effectModel);self.effectModel=nil;
_UIObject_release(self.finishEffect);self.finishEffect=nil;
_UIObject_release(self.finishEffectBg);self.finishEffectBg=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
end
















local _this




function UISpDiscipleSwitchLoadingWin:onLoaded(...)
self:bindComponents()
_this=self
self.progressBar:setFinishAction(function()
self:onProgressForwardFinish()
end)
end


function UISpDiscipleSwitchLoadingWin:__delete()
self:unbindComponents()
_this=nil

if self.overTimer then
self:stopTimerByID(self.overTimer)
self.overTimer=nil
end
end




function UISpDiscipleSwitchLoadingWin:onShow(argtable,afterOnloaded)
self.count=argtable.count
self.duration=argtable.duration or 0.5
self.overTime=argtable.over or 10
self.onSeg=argtable.onSeg
self.onCheck=argtable.onCheck

self.onOver=argtable.onOver
self.onCheckErr=argtable.onCheckErr
self.index=0
self.discipleguid=argtable.discipleguid
self.switchidx=argtable.switchidx

self.clickClose:setActive(false)
self.finishSwitchPanel:setActive(false)
self.loadingText:setActive(true)

self.effectModel:setChildUIModelShowTarget(6167,1,{},eAnimationID.stand)
self.effect:setChildShowEffect(22689,true)


self:refreshDzModel()


self:doProgressForward()
end


function UISpDiscipleSwitchLoadingWin:onHide()

end

function UISpDiscipleSwitchLoadingWin:refreshDzModel()
local dzguid=self.discipleguid
local args={
tmLv=UIDiscipleModel:getTianMingLevel(dzguid),
}
local scale=1
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid,false,1,args)
self.dzModel:setChildUIModelShowTarget(modelParams.body,modelParams.scale*scale,modelParams.componets,modelParams.anim,false,false)
end





function UISpDiscipleSwitchLoadingWin:onClickClose()
self:closeSelf()
end


function UISpDiscipleSwitchLoadingWin:doProgressForward()
local old=self.index
self.index=self.index+1
if self.index>self.count then

self:onCompleteLoading()
else
self.progressBar:animateFiveParams(old,self.index,self.count,self.duration,false)
if self.onSeg then
self.ret=self.onSeg(self.index,self.discipleguid,self.switchidx)
end
end
end

function UISpDiscipleSwitchLoadingWin:onProgressForwardFinish()
if self.ret==false then
if self.onCheckErr then
self.onCheckErr(self.index,self.discipleguid,self.switchidx)
end
return
end

local complete=true
if self.onCheck then
complete=self.onCheck(self.index)
end

if complete then
self:doProgressForward()
else
self.countdown=self.overTime
self.overTimer=self:setTimer(1,self.overTime,function()
self:onOverTime()
end)
end
end

function UISpDiscipleSwitchLoadingWin:onOverTime()
self.countdown=self.countdown-1
local complete=true
if self.onCheck then
complete=self.onCheck(self.index)
end
if complete then
if self.overTimer then
self:stopTimerByID(self.overTimer)
self.overTimer=nil
end
self:doProgressForward()
elseif self.countdown<=0 then
if self.onOver then
self.onOver(self.index)
end
end
end

function UISpDiscipleSwitchLoadingWin:onCompleteLoading()

self.finishEffect:setChildShowEffect(22691,true)
self.finishEffectBg:setChildShowEffect(22690,true)

self.loadingText:setActive(false)
self:delayDo(0.3,function()
self.effect:setChildShowEffect(0,false)

self:refreshDzModel()


self.effectModel:setChildModelAnimationState(eAnimationID.stand,0)
return self:delayDo(1,function()
return self:onFinishLoading()
end)
end)
end

function UISpDiscipleSwitchLoadingWin:onFinishLoading()
UIDiscipleModel:setIsSwitchingSPDisciple(false)
UIDiscipleModel:setSPDiscipleLastSwitchTimeStamp()


UIManager:callWindowFunc("UIDiscipleRoleInfoWin","refreshDiscipleInfo")
UIManager:callWindowFunc("UIDiscipleRoleInfo2Win","refreshDiscipleInfo")
UIManager:callWindowFunc("UIDiscipleRoleInfo2Win","refreshBotton")
UIManager:invokeUIMethod('UIDiscipleRoleInfoTwoWin','refreshJJInfoStatic')
UIManager:invokeUIMethod('UIDiscipleRoleInfoTwoWin','refreshXianMoDaoHengTimer')
UIManager:callWindowFunc('UIDiscipleMainWin','refreshDiscipleList')
UIManager:callWindowFunc('UIDiscipleMainWin','refreshPresetNum')
UIManager:callWindowFunc('UIDiscipleSelectWin','initRoleListPanel')
UIManager:callWindowFunc("UIDiscipleListComponent","freshDZList")


equipsControl.freshWindow('showModel')
equipsControl.freshWindow('freshEquips')
equipsControl.freshWindow('onChangeFabao')
equipsControl.freshAttrWindow()


UIManager:callWindowFunc("UIDiscipleSkillInfoWin","refreshPageWin")


UIManager:callWindowFunc("UIDiscipleTianMingWin","refreshPageWin")


UIManager:callWindowFunc("UIDiscipleLinggenlInfoWin","refreshPageWin")


local discipleguid=self.discipleguid
notifySystem:postNotify(notifyConfig.onDiscipleVocSwitch,discipleguid)




local originialJobIcon=UIDiscipleModel:getJobIconNameX(self.discipleguid,self.switchidx)
self.vocIcon1:setSprite(globalABLookup.global,originialJobIcon)
local jobicon=UIDiscipleModel:getJobIconNameX(self.discipleguid)
self.vocIcon2:setSprite(globalABLookup.global,jobicon)
self.finishSwitchPanel:setActive(true)

self.tipsText:setActive(true)


self.clickClose:setActive(true)

end