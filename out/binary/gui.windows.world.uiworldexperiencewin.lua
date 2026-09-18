







def_class("UIWorldExperienceWin",UIWindowBase)









function UIWorldExperienceWin:bindComponents()

self.Cloud=UIObject.get(self,0)
self.UIRoot=UIObject.get(self,1)
self.progressEffect=UIObject.get(self,2)
self.progressTx=UIText.get(self,3)
self.peopleAnim=UIObject.get(self,4)
self.titleName=UIText.get(self,5)
self.titleNum=UIText.get(self,6)
self.backBtn=UIButton.get(self,7)
self.continueBtn=UIButton.get(self,8)
self.progressBtn=UIButton.get(self,9)
self.bagBtn=UIButton.get(self,10)
self.retreatBtn=UIButton.get(self,11)
self.titleRoot=UIObject.get(self,12)
self.diziBtn=UIButton.get(self,13)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.continueBtn:setButtonClick(function()self:onContinueBtn()end)

self.progressBtn:setButtonClick(function()self:onProgressBtn()end)

self.bagBtn:setButtonClick(function()self:onBagBtn()end)

self.retreatBtn:setButtonClick(function()self:onRetreatBtn()end)

self.diziBtn:setButtonClick(function()self:onDiziBtn()end)



end


function UIWorldExperienceWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Cloud);self.Cloud=nil;
_UIObject_release(self.UIRoot);self.UIRoot=nil;
_UIObject_release(self.progressEffect);self.progressEffect=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.peopleAnim);self.peopleAnim=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.titleNum);self.titleNum=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.continueBtn);self.continueBtn=nil;
_UIObject_release(self.progressBtn);self.progressBtn=nil;
_UIObject_release(self.bagBtn);self.bagBtn=nil;
_UIObject_release(self.retreatBtn);self.retreatBtn=nil;
_UIObject_release(self.titleRoot);self.titleRoot=nil;
_UIObject_release(self.diziBtn);self.diziBtn=nil;
end

















local _this=nil




function UIWorldExperienceWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onMissionDiscipleChanged,self.onMissionDiscipleChanged)
notifySystem:listenNotify(notifyConfig.onStartMissionInWorld,self.onStartMissionInWorld)
notifySystem:listenNotify(notifyConfig.onExperiencePointCompleted,self.onExperiencePointCompleted)

if webGLHelper:isNeedAdaption()then
local pos=self.retreatBtn:getChildAnchoredPosition3D()
self.retreatBtn:setChildAnchoredPosition3D(Vector3.New(pos.x,-111.5,0))
end
end


function UIWorldExperienceWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onMissionDiscipleChanged,self.onMissionDiscipleChanged)
notifySystem:removelistener(notifyConfig.onStartMissionInWorld,self.onStartMissionInWorld)
notifySystem:removelistener(notifyConfig.onExperiencePointCompleted,self.onExperiencePointCompleted)
_this=nil
end




function UIWorldExperienceWin:onShow(argtable,afterOnloaded)
local show=argtable~=false and UIManager:findLoadingWindow("UIWorldBossWin")==nil

self:showContinue(show)

self:setProgressText()
self:setTitle(argtable==false)
self:setTaskDisciple()
self:refreshProgressEffect()

self:checkAutoContinue()
end


function UIWorldExperienceWin:onHide()

end




function UIWorldExperienceWin:onBackBtn()
worldExperienceController:exitExperience()
end

function UIWorldExperienceWin:onProgressBtn()

if worldExperienceController:isAnimationing()or worldExperienceController:isInCommunication()or not worldController:getCameraControl()then
return
end

UIManager:showWindow("UIWorldProgressWin")
end

function UIWorldExperienceWin:onRetreatBtn()
worldExperienceController:retreatExperience()
end

function UIWorldExperienceWin:onContinueBtn()
worldExperienceController:doContinue()
end

function UIWorldExperienceWin:onDiziBtn()

if worldExperienceController:isAnimationing()or worldExperienceController:isInCommunication()or not worldController:getCameraControl()then
return
end

local cnt=UIDiscipleModel:checkDiscipleCount()
if cnt<=0 then
UIManager.error('没有弟子')
return
end
if not worldExperienceModel:checkScene()then return end
local world,block=worldExperienceModel:getScene()
local unitKey=worldExperienceModel:convertTaskTargetKey(world,block)
local taskKey=worldTaskModel:findTaskKey_ByTargetProgress(unitKey,eWorldTripProgress.Work)
local discipleTeam={}
if taskKey then
local task=worldTaskModel:getTask(taskKey)
discipleTeam=task.disciples
end
UIFullDiscipleSelectControl:showDiscipleSelectWindow({disciples=discipleTeam})
end

function UIWorldExperienceWin:onBagBtn()

if worldExperienceController:isAnimationing()or worldExperienceController:isInCommunication()or not worldController:getCameraControl()then
return
end

UIManager:showWindow('UIBagWin')
end

function UIWorldExperienceWin:setProgressText()
local progress=worldExperienceModel:getWorldProgress(worldModel.world)
self.progressTx:setText(FMT.fmt("{0}%",progress))
end

function UIWorldExperienceWin:setTaskDisciple()
if not worldExperienceModel:checkScene()then return end
local world,block=worldExperienceModel:getScene()
local unitKey=worldExperienceModel:convertTaskTargetKey(world,block)
local taskKey=worldTaskModel:findTaskKey_ByTargetProgress(unitKey,eWorldTripProgress.Work)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
local disciple=task.disciples[1]
if disciple then
if disciple~=self.disciple then
self.disciple=disciple
local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(disciple)
local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelParams.body)
local scale=bodyCfg.uiScales and bodyCfg.uiScales[1]or 1
local moveAnimation=10
self.winlua:SetChildUIModelShowTarget(self.peopleAnim:getID(),modelParams.body,scale,modelParams.componets,moveAnimation,false,false,0)
self.winlua:SetChildUIModelShowFlipX(self.peopleAnim:getID(),true)
end
return
else

end
else

end
self.disciple=nil
self.winlua:SetChildUIModelRemoveTarget(self.peopleAnim:getID())
end

function UIWorldExperienceWin:checkUIActive()
if not worldExperienceModel:checkScene()then return end
local world,block=worldExperienceModel:getScene()
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local uiCfg=cfgHelper.get1(cfg_experiencepanelconfig_get,blockCfg.eUIOpen)
self.backBtn:setActive(uiCfg.back)
self.retreatBtn:setActive(uiCfg.retreat)
self.progressBtn:setActive(uiCfg.progress)
self.bagBtn:setActive(uiCfg.bag)
self.titleRoot:setActive(uiCfg.title)
self.diziBtn:setActive(uiCfg.dizi)
end

function UIWorldExperienceWin:showContinue(show)
if show then
self.continueBtn:setActive(true)
self:checkUIActive()
else
self.continueBtn:setActive(false)
self.backBtn:setActive(false)
self.retreatBtn:setActive(false)
self.progressBtn:setActive(false)
self.bagBtn:setActive(false)
self.titleRoot:setActive(false)
self.diziBtn:setActive(false)
end
end

function UIWorldExperienceWin.onMissionDiscipleChanged(key,change)
local task=worldTaskModel:getTask(key)
if task.target_type==eWorldUnitTpye.EXPERIENCE then
if worldExperienceModel:checkScene()then
_this:setTaskDisciple()
end
end
end

function UIWorldExperienceWin.onStartMissionInWorld(taskKey,targetType,targetId,Team)
if targetType==eWorldUnitTpye.EXPERIENCE then
if worldExperienceModel:checkScene()then
_this:setTaskDisciple()
end
end
end

function UIWorldExperienceWin:refreshProgressEffect()
local check=worldExperienceModel:checkAllWorldProgress()
self.progressEffect:setActive(check)
end

function UIWorldExperienceWin:setTitle(onlyNum)

if not onlyNum then
local world,block=worldExperienceModel:getScene()
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
self.titleName:setText(blockCfg.name)
end
local max=worldExperienceModel:getCount()
local cur=worldExperienceModel:getProgress()
self.titleNum:setText(FMT.fmt("({0}/{1})",cur,max))
self.winlua:ForceLayoutRect(self.titleRoot:getID())
end

function UIWorldExperienceWin.onExperiencePointCompleted(pont)
_this:setTitle(true)
end

function UIWorldExperienceWin:checkAutoContinue()
if worldExperienceController.autoContinue then
worldExperienceController.autoContinue=nil
local world,block=worldExperienceModel:getScene()
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
if blockCfg.eAutoContinue then
self:onContinueBtn()
return
end
end
end
