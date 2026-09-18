







def_class("UIJiuChongTianJieEnterWin",UIWindowBase)









function UIJiuChongTianJieEnterWin:bindComponents()

self.backButton=UIButton.get(self,0)
self.btnRoot=UIObject.get(self,1)
self.canFeiShengTips=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.content=UIObject.get(self,4)
self.dzmodel=UIObject.get(self,5)
self.effect=UIObject.get(self,6)
self.effectfs=UIObject.get(self,7)
self.feishengAnPai=UIObject.get(self,8)
self.feishengBtn=UIButton.get(self,9)
self.feishengModel=UIObject.get(self,10)
self.feishengPanel=UIObject.get(self,11)
self.feishengtaiBtn=UIButton.get(self,12)
self.fsLeftImg=UIObject.get(self,13)
self.jieButton=UIButton.get(self,14)
self.jiYuanBtn=UIButton.get(self,15)
self.lightningEffect=UIObject.get(self,16)
self.lightningEffect2=UIObject.get(self,17)
self.mask=UIObject.get(self,18)
self.model=UIObject.get(self,19)
self.noselectJiYuan=UIObject.get(self,20)
self.openButton=UIButton.get(self,21)
self.openEffect=UIObject.get(self,22)
self.openModel=UIObject.get(self,23)
self.openRoot=UIObject.get(self,24)
self.panelRoot=UIObject.get(self,25)
self.rankBtn=UIButton.get(self,26)
self.reddotJiYuan=UIObject.get(self,27)
self.scrollView=UIObject.get(self,28)
self.showModel_1=UIObject.get(self,29)
self.showModel_2=UIObject.get(self,30)
self.showModelRoot=UIObject.get(self,31)
self.sysPanel=UIObject.get(self,32)
self.sysRoot=UIGameobjectClone.new(self,33)
self.taskTips=UIObject.get(self,34)
self.taskTipsText=UIText.get(self,35)
self.topMask=UIObject.get(self,36)
self.xljkBtn=UIButton.get(self,37)

self.backButton:setButtonClick(function()self:onBackButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.feishengBtn:setButtonClick(function()self:onFeishengBtn()end)

self.feishengtaiBtn:setButtonClick(function()self:onFeishengtaiBtn()end)

self.jieButton:setButtonClick(function()self:onJieButton()end)

self.jiYuanBtn:setButtonClick(function()self:onJiYuanBtn()end)

self.openButton:setButtonClick(function()self:onOpenButton()end)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.xljkBtn:setButtonClick(function()self:onXljkBtn()end)
self.showModel={
self.showModel_1,
self.showModel_2,
}



end


function UIJiuChongTianJieEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backButton);self.backButton=nil;
_UIObject_release(self.btnRoot);self.btnRoot=nil;
_UIObject_release(self.canFeiShengTips);self.canFeiShengTips=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.dzmodel);self.dzmodel=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effectfs);self.effectfs=nil;
_UIObject_release(self.feishengAnPai);self.feishengAnPai=nil;
_UIObject_release(self.feishengBtn);self.feishengBtn=nil;
_UIObject_release(self.feishengModel);self.feishengModel=nil;
_UIObject_release(self.feishengPanel);self.feishengPanel=nil;
_UIObject_release(self.feishengtaiBtn);self.feishengtaiBtn=nil;
_UIObject_release(self.fsLeftImg);self.fsLeftImg=nil;
_UIObject_release(self.jieButton);self.jieButton=nil;
_UIObject_release(self.jiYuanBtn);self.jiYuanBtn=nil;
_UIObject_release(self.lightningEffect);self.lightningEffect=nil;
_UIObject_release(self.lightningEffect2);self.lightningEffect2=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.noselectJiYuan);self.noselectJiYuan=nil;
_UIObject_release(self.openButton);self.openButton=nil;
_UIObject_release(self.openEffect);self.openEffect=nil;
_UIObject_release(self.openModel);self.openModel=nil;
_UIObject_release(self.openRoot);self.openRoot=nil;
_UIObject_release(self.panelRoot);self.panelRoot=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.reddotJiYuan);self.reddotJiYuan=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.showModel_1);self.showModel_1=nil;
_UIObject_release(self.showModel_2);self.showModel_2=nil;
_UIObject_release(self.showModelRoot);self.showModelRoot=nil;
_UIObject_release(self.sysPanel);self.sysPanel=nil;
self.sysRoot:deleteSelf();self.sysRoot=nil;
_UIObject_release(self.taskTips);self.taskTips=nil;
_UIObject_release(self.taskTipsText);self.taskTipsText=nil;
_UIObject_release(self.topMask);self.topMask=nil;
_UIObject_release(self.xljkBtn);self.xljkBtn=nil;
self.showModel=nil;
end


















local objPos={{-327,270,1},{355,401,0.86},{3,513,0.75}}
local roadPos={{27,398,0},{131,431,13.36},{3,513,0.7}}
local modelAnim={2084,2085,2086}
local effectAnim={20372,20373,20373}
local roadEffect={20261,20261,20261}
local yanshiAnim=2308

function UIJiuChongTianJieEnterWin:onLoaded(...)
self:bindComponents()
self.systemObj={}
self.systemRoad={}

local step=JiuChongTianJieEnterModel:getOpenStep()
self.model:setChildUIModelShowTarget(5437,1,{},modelAnim[step],false,false,0.2,nil)
self.openModel:setChildUIModelShowTarget(5440,1,{},eAnimationID.stand,false,false,0.2,nil)
self.feishengModel:setChildUIModelShowTarget(5743,1,{},eAnimationID.stand,false,false,0.2,nil)

self.isOpenFeiSheng=JiuChongTianJieEnterModel:isJCTJFinish()
end


function UIJiuChongTianJieEnterWin:__delete()
self:unbindComponents()
end




function UIJiuChongTianJieEnterWin:onShow(argtable,afterOnloaded)

local open=userActorSetting.get('JiuChongTianJieOpen',false)
self.openRoot:setActive(not open)
local step=JiuChongTianJieEnterModel:getOpenStep()

self.effect:setChildShowEffect(effectAnim[step],true)

if open then
if self.enterTweener then
self.enterTweener:Kill()
self.enterTweener=nil
end

self.scrollView:setScale(Vector3(1.35,1.35,1.35))
self.enterTweener=self.scrollView:setChildDOScale(1,0.5,nil)

if self.isOpenFeiSheng then
self.model:setChildUIModelShowTarget(5599,1,{},0,false,false,0.2,nil)
self.sysPanel:setActive(false)
self.feishengPanel:setActive(true)
self.rankBtn:setActive(false)
self.feishengPanel:setChildCanvasGroupAlpha(1)
self.scrollView:setChildScrollRectEnable(false)
self.fsLeftImg:setChildCanvasGroupAlpha(1)
self:refreshTaskTips()
else

self.model:setChildModelAnimationState(modelAnim[step],1,nil)
self.sysPanel:setActive(true)
self.rankBtn:setActive(true)
self.feishengPanel:setActive(false)
end



self:playNewbie()
else
self.model:setChildModelAnimationState(modelAnim[2],1,nil)
self.model:setScale(Vector3(1.35,1.35,1.35))
self.model:setChildAnchoredPos(0,-2973)
self.btnRoot:setActive(false)
self.sysPanel:setActive(false)
self.openEffect:setChildShowEffect(20374,true)
self.lightningEffect2:setChildShowEffect(effectAnim[step],true)
self.openButtonTimer=self:delayDo(1,function()
self.openEffect:setChildShowEffect(20375,true)
end)
end

self:showSystemObj()
self:freshJiYuan()
end


function UIJiuChongTianJieEnterWin:onHide()

end

function UIJiuChongTianJieEnterWin:refreshTaskTips()
local checkTask,taskId=self:checkDontFinishTask()
if checkTask then
self.taskTips:setActive(true)
self.canFeiShengTips:setActive(false)
self.taskTipsText:setText(FMT.fmt("需完成主线任务·{0}",taskModel:getTaskConfig(taskId).name))
else
self.taskTips:setActive(false)
self.canFeiShengTips:setActive(true)
end
end

function UIJiuChongTianJieEnterWin:showSystemObj()
local config=cfg_jctjsysconfig()
self:clearSystemObj()
local index=0
local delay=0
for _,v in pairs(config)do
index=index+1
local i=index

local guid=self.sysRoot:createObject('jctjSysWidget',self.sysRoot:getID(),0,{sysType=v.id,pos=objPos[i],parent=self})
self.systemObj[index]=guid

end


local guid=self.sysRoot:createObject('jctjRoadWidget',self.sysRoot:getID(),0,{pos=roadPos[1],parent=self,effect=roadEffect[1]})
self.systemRoad[guid]=1


local buffList=nil
local baseCfg=cfgHelper.get(cfg_jctjbaseconfig_get,1)
local needNum=baseCfg.xljkNum or 0
if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie2)and JiuChongTianJieEnterModel:getOpenTianJiePeople()>=needNum then
buffList=JiuChongTianJieEnterModel:getBuffList()
end
self.xljkBtn:setActive(buffList and next(buffList)~=nil)
end

function UIJiuChongTianJieEnterWin:clearSystemObj()
for k,v in pairs(self.systemObj)do
self.sysRoot:recycleItemById(v)
end
self.systemObj={}
end

function UIJiuChongTianJieEnterWin:clearRoadObj()
for k,v in pairs(self.systemRoad)do
self.sysRoot:recycleItemById(k)
end
self.systemObj={}
end

function UIJiuChongTianJieEnterWin:showObjEffect(show)
for prefabid,v in pairs(self.systemObj)do
local widget=self.sysRoot:getItemWidget(prefabid)
if widget then
widget:SetChildActive(4,show)
end
end
end

function UIJiuChongTianJieEnterWin:beginSysAnim()



for index,prefabid in pairs(self.systemObj)do
self.sysRoot:callChildFunc(prefabid,"setRootActive",false)
end
for prefabid,v in pairs(self.systemRoad)do
self.sysRoot:callChildFunc(prefabid,"setRootActive",false)
end
self:delayDo(1.6,function()
self.model:setChildAnchoredPos(0,-2046)
self.model:setChildDOScale(1,0.2,nil)
self.model:setChildDOAnchorPosY(-2046,0.2,nil)
self.model:setChildModelAnimationState(yanshiAnim,1,nil)
self.lightningEffect2:setChildShowEffect(20377,true)
end)

self:delayDo(2,function()

local prefabid=self.systemObj[1]
if prefabid then
self.sysRoot:callChildFunc(prefabid,"setRootActive",true)
self.sysRoot:callChildFunc(prefabid,"setWidgetPosition",{0,355,1.4})
self:delayDo(1,function()
self.sysRoot:callChildFunc(prefabid,"setWidgetDoPosition",objPos[1],1)
end)
end
self:delayDo(1.6,function()
self.lightningEffect:setChildShowEffect(20378,true)
end)
self:delayDo(2,function()
local prefabid=self.systemObj[2]
if prefabid then
self.sysRoot:callChildFunc(prefabid,"setRootActive",true)
end

self:delayDo(1,function()
local prefabid=self.systemObj[3]
if prefabid then
self.sysRoot:callChildFunc(prefabid,"setRootActive",true)
end
self:delayDo(0.5,function()
for prefabid,v in pairs(self.systemRoad)do
self.sysRoot:callChildFunc(prefabid,"setRootActive",true)
end
end)
end)
end)
end)
end

function UIJiuChongTianJieEnterWin:freshJiYuan()
local jiYuan=zheXianLingModel:hasJiYuanItems()
if jiYuan then
self.jiYuanBtn:setActive(true)
self.reddotJiYuan:setActive(zheXianLingModel:hasJiYuanTimes())
else
self.jiYuanBtn:setActive(false)
end

end

function UIJiuChongTianJieEnterWin:focusObj(pos,call)
if self.rootTweenPos then
return
end
if self.rootTweenScale then
self.rootTweenScale:Kill()
end
self.panelRoot:setChildAnchoredPosition(Vector2.zero)
self.panelRoot:setScale(Vector3.one)
self:showObjEffect(false)
self.rootTweenPos=self.panelRoot:setChildDOAnchorPos(Vector2(-pos.x*0.5,-pos.y*1.35+400),1,function()
if call then call()end
self.rootTweenPos=nil
self.panelRoot:setChildAnchoredPosition(Vector2.zero)
self:showObjEffect(true)
end)
self.rootTweenScale=self.panelRoot:setChildDOScale(1.35,1,function()
self.panelRoot:setScale(Vector3.one)
end)
self.topMask:setChildCanvasGroupAlpha(0)
self.topMask:setChildCanvasGroupDOFade(1,1.25,function()
self.topMask:setChildCanvasGroupAlpha(0)
end)
end


function UIJiuChongTianJieEnterWin:playOpenAnim()
if self.enterTweener then
self.enterTweener:Kill()
self.enterTweener=nil
end
self.scrollView:setScale(Vector3(1.35,1.35,1.35))
self.enterTweener=self.scrollView:setChildDOScale(1,1.25,nil)
self.enterTweener:SetEase(DG.Tweening.Ease.InExpo)
self.topMask:setChildCanvasGroupAlpha(1)
local t=self.topMask:setChildCanvasGroupDOFade(0,0.75,function()
self.topMask:setChildCanvasGroupAlpha(0)
end)
t:SetEase(DG.Tweening.Ease.InQuad)
end

function UIJiuChongTianJieEnterWin:refreshSelectDizi(dzId)
self.selectDz=dzId
self.dzmodel:setActive(true)
self.feishengBtn:setActive(true)
self.feishengAnPai:setActive(false)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzId)
self.dzmodel:setChildUIModelShowTarget(modelParams.body,1,modelParams.componets,eAnimationID.stand)

self:playFeiShengAnim1()
end


function UIJiuChongTianJieEnterWin:playFeiShengAnim1()
self.content:setChildAnchoredPos(0,0)
self.mask:setActive(true)
self.effect:setChildShowEffect(0,false)
self.effectfs:setChildShowEffect(20457,true)

local tweener=self.content:setChildDOAnchorPosY(-695,2)

tweener:SetDelay(1)
tweener:SetEase(_Ease.OutQuint)
tweener:OnComplete(function()

self.mask:setActive(false)
end)
local tweener2=self.fsLeftImg:setChildCanvasGroupDOFade(0,0.25)
tweener2:SetDelay(1.25)
end






function UIJiuChongTianJieEnterWin:onRankBtn()
self:showWindow("UIJCKTRankWin",{openType=2})
end



function UIJiuChongTianJieEnterWin:onJiYuanBtn()
UIFullZheXianControl:showZheXianLingWindow({winType=UIFullZheXianControl.winType.eJiYuan})
end

function UIJiuChongTianJieEnterWin:onCloseBtn()

local func=function()
UIFullJiuChongTianJieControl:closeUI()
end
loadingControl.openCloud(func,0.5)
end

function UIJiuChongTianJieEnterWin:onOpenButton()
if self.clickOpen then
return
end
self.clickOpen=true
if self.openButtonTimer then
self:stopTimerByID(self.openButtonTimer)
self.openButtonTimer=nil
end
self.openEffect:setChildShowEffect(20376,true)
self.openModel:setChildModelAnimationState(2307,1,nil)


self.sysPanel:setActive(true)
self:beginSysAnim()
self:delayDo(6,function()



self.clickOpen=nil

self.btnRoot:setActive(true)
self.openRoot:setActive(false)
if NEWBIE_LUA_FUNC_NAME.first_enter_JCTJ then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.first_enter_JCTJ)
end
end)





userActorSetting.flushVal('JiuChongTianJieOpen',true)
end

function UIJiuChongTianJieEnterWin:onXljkBtn()
self:showWindow("UIXianLuJianKaiWin")
end

function UIJiuChongTianJieEnterWin:onBackButton()
self.isOpenFeiSheng=not self.isOpenFeiSheng

self.feishengPanel:setChildCanvasGroupAlpha(1)
self.sysPanel:setChildCanvasGroupAlpha(0)
self.jieButton:setActive(true)

self.feishengPanel:setChildCanvasGroupDOFade(0,0.25,function()
if self and not self.isClose then
self.rankBtn:setActive(true)
self.feishengPanel:setActive(false)
end
end)
self.sysPanel:setActive(true)
self.sysPanel:setChildCanvasGroupDOFade(1,0.5)
end

function UIJiuChongTianJieEnterWin:onFeishengBtn()
if self.selectDz then
local rewardSysList=JiuChongTianJieEnterModel:getRewardSystem()or{}
if next(rewardSysList)then
self:showWindow("UIJiuChongTianJieDialouge",{systemList=rewardSysList,okCallback=function()
JiuChongTianJieEnterController.req_34_2(self.selectDz)
end})






else

JiuChongTianJieEnterController.req_34_2(self.selectDz)
end

AudioManager.playAudio(SoundID.BtnClick)
end
end

function UIJiuChongTianJieEnterWin:checkDontFinishTask()
local config=systemConfig.getSystemConfig(SYSTEM_DEFINE.eJiuChongTianJieComplete)
for k1,openargs in ipairs(config.openargs)do
for k,v in ipairs(openargs)do
if v[1]==SYSTEM_OPEN_TYPE.eTaskFinish then
if not taskModel:checkTaskFinish(v[2])then
return true,v[2]
end
end
end
end
end

function UIJiuChongTianJieEnterWin:onFeishengtaiBtn()
if self.selectDz~=nil then
return
end

if self:checkDontFinishTask()then
return
end

local args={
openType=dzSelectWinOpenType.eJctjFeiSheng,
callback=function(dzId)
self:refreshSelectDizi(dzId)
end,
}
discipleSelectController:openDiscipleSelect(args,"弟子安排")
end

function UIJiuChongTianJieEnterWin:playNewbie()
if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie2)then
if NEWBIE_LUA_FUNC_NAME.first_enter_JCTJ2 then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.first_enter_JCTJ2)
end
end
if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie3)then
if NEWBIE_LUA_FUNC_NAME.first_enter_JCTJ3 then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.first_enter_JCTJ3)
end
end
end

function UIJiuChongTianJieEnterWin:onJieButton()
self.isOpenFeiSheng=not self.isOpenFeiSheng

self.feishengPanel:setChildCanvasGroupAlpha(0)
self.feishengPanel:setActive(true)
self.sysPanel:setChildCanvasGroupAlpha(1)

self.feishengPanel:setChildCanvasGroupDOFade(1,0.25,function()
if self and not self.isClose then
self.jieButton:setActive(false)
self.sysPanel:setActive(false)
self.rankBtn:setActive(false)
end
end)
self.sysPanel:setChildCanvasGroupDOFade(0,0.5)
end