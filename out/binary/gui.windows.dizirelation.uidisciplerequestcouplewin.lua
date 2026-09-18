







def_class("UIDiscipleRequestCoupleWin",UIWindowBase)









function UIDiscipleRequestCoupleWin:bindComponents()

self.root=UIObject.get(self,0)
self.manSnowEffect=UIObject.get(self,1)
self.womanThunderEffect=UIObject.get(self,2)
self.manThunderEffect=UIObject.get(self,3)
self.resultEffect=UIObject.get(self,4)
self.flowerEffect=UIObject.get(self,5)
self.heartEffect=UIObject.get(self,6)
self.helpBtn=UIButton.get(self,7)
self.womanSnowEffect=UIObject.get(self,8)
self.infoPanel=UIObject.get(self,9)
self.descBg=UIObject.get(self,10)
self.moonModel=UIObject.get(self,11)
self.bridgeModel=UIObject.get(self,12)
self.bgModel=UIObject.get(self,13)
self.dzWoman=UIObject.get(self,14)
self.title=UIObject.get(self,15)
self.dzMan=UIObject.get(self,16)
self.manMask=UIButton.get(self,17)
self.womanMask=UIButton.get(self,18)
self.cloudModel=UIObject.get(self,19)
self.redRopeModel=UIObject.get(self,20)
self.agreeBtn=UIButton.get(self,21)
self.refuseBtn=UIButton.get(self,22)
self.womanName=UIText.get(self,23)
self.manDialogueBg=UIObject.get(self,24)
self.womanInfoBtn=UIButton.get(self,25)
self.manInfoBtn=UIButton.get(self,26)
self.manName=UIText.get(self,27)
self.womanDialogueBg=UIObject.get(self,28)
self.womanDialogue=UIText.get(self,29)
self.manModel=UIObject.get(self,30)
self.womanModel=UIObject.get(self,31)
self.desc=UIText.get(self,32)
self.manDialogue=UIText.get(self,33)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.manMask:setButtonClick(function()self:onManMask()end)

self.womanMask:setButtonClick(function()self:onWomanMask()end)

self.agreeBtn:setButtonClick(function()self:onAgreeBtn()end)

self.refuseBtn:setButtonClick(function()self:onRefuseBtn()end)

self.womanInfoBtn:setButtonClick(function()self:onWomanInfoBtn()end)

self.manInfoBtn:setButtonClick(function()self:onManInfoBtn()end)



end


function UIDiscipleRequestCoupleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.manSnowEffect);self.manSnowEffect=nil;
_UIObject_release(self.womanThunderEffect);self.womanThunderEffect=nil;
_UIObject_release(self.manThunderEffect);self.manThunderEffect=nil;
_UIObject_release(self.resultEffect);self.resultEffect=nil;
_UIObject_release(self.flowerEffect);self.flowerEffect=nil;
_UIObject_release(self.heartEffect);self.heartEffect=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.womanSnowEffect);self.womanSnowEffect=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.moonModel);self.moonModel=nil;
_UIObject_release(self.bridgeModel);self.bridgeModel=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.dzWoman);self.dzWoman=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.dzMan);self.dzMan=nil;
_UIObject_release(self.manMask);self.manMask=nil;
_UIObject_release(self.womanMask);self.womanMask=nil;
_UIObject_release(self.cloudModel);self.cloudModel=nil;
_UIObject_release(self.redRopeModel);self.redRopeModel=nil;
_UIObject_release(self.agreeBtn);self.agreeBtn=nil;
_UIObject_release(self.refuseBtn);self.refuseBtn=nil;
_UIObject_release(self.womanName);self.womanName=nil;
_UIObject_release(self.manDialogueBg);self.manDialogueBg=nil;
_UIObject_release(self.womanInfoBtn);self.womanInfoBtn=nil;
_UIObject_release(self.manInfoBtn);self.manInfoBtn=nil;
_UIObject_release(self.manName);self.manName=nil;
_UIObject_release(self.womanDialogueBg);self.womanDialogueBg=nil;
_UIObject_release(self.womanDialogue);self.womanDialogue=nil;
_UIObject_release(self.manModel);self.manModel=nil;
_UIObject_release(self.womanModel);self.womanModel=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.manDialogue);self.manDialogue=nil;
end



















local closeCallback
local this
function UIDiscipleRequestCoupleWin:onLoaded(...)
self:bindComponents()
this=self
end


function UIDiscipleRequestCoupleWin:__delete()
self:unbindComponents()
uiAIManager:clearUIWinData('UIDiscipleRequestCoupleWin')
self.currManDZ=nil
self.currWomanDZ=nil
self.manGuid=nil
self.womanGuid=nil
end




function UIDiscipleRequestCoupleWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5385,1,{},eAnimationID.stand)
self.winlua:SetChildUIModelShowTarget(self.cloudModel:getID(),5386,1,{},eAnimationID.stand)
self.winlua:SetChildUIModelShowTarget(self.bridgeModel:getID(),5387,1,{},eAnimationID.stand)
self.manDialogueBg:setActive(false)
self.womanDialogueBg:setActive(false)
self.isAnim=false
self.manGuid=argtable.man
self.womanGuid=argtable.woman
local manName=UIDiscipleModel:getDiscipleName(self.manGuid)
local womanName=UIDiscipleModel:getDiscipleName(self.womanGuid)
self.dialogueId=argtable.dialogueId
self.timeStamp=argtable.timeStamp
local cfg=cfgHelper.get1(cfg_reqcoupledialogueconfig_get,self.dialogueId)

self.manName:setText(manName)
self.womanName:setText(womanName)

local dialogue1=cfg.manDialogue
local dialogue2=cfg.womanDialogue
self.manDialogue:setText(string.format(dialogue1,womanName))
self.womanDialogue:setText(string.format(dialogue2,manName))

self.desc:setText(string.format(cfg.shortDesc,manName,womanName))
self:delayDo(0.3,function()
self.root:setChildCanvasGroupDOFade(1,0.6)

comHelper.setChildInSideModel(self.manModel,self.manGuid,0.7,nil,0,40,false,false,0.6)
comHelper.setChildInSideModel(self.womanModel,self.womanGuid,0.7,nil,0,40,false,false,0.6)
end)
self:delayDo(1.5,function()
if self.isAnim then return end

self.manDialogueBg:setActive(true)
end)
self:delayDo(2.5,function()
if self.isAnim then return end

self.womanDialogueBg:setActive(true)
end)

self.winlua:SetChildUIModelShowTarget(self.redRopeModel:getID(),5384,1,{},eAnimationID.stand)
closeCallback=function()
if#DiscipleCoupleModel:getReqCoupleList()<=0 then
return false
end
if not(UIDiscipleModel:getDiscipleData(argtable.man)and UIDiscipleModel:getDiscipleData(argtable.woman))then
return false
end
if not(DiscipleCoupleModel:CheckReqCoupleListContain(argtable.man)and DiscipleCoupleModel:CheckReqCoupleListContain(argtable.woman))then
return false
end
UIManager:showWindow("UIDiscipleRequestCoupleListWin",{man=argtable.man,woman=argtable.woman,dialogueId=argtable.dialogueId,timeStamp=argtable.timeStamp})
return false
end
end


function UIDiscipleRequestCoupleWin:onHide()

end



function UIDiscipleRequestCoupleWin:test(ret)
local random_dis1=UIDiscipleModel:getRandomDiscipleData().discipleguid
local random_dis2=UIDiscipleModel:getRandomDiscipleData().discipleguid
self:onCoupleHandleCallback(random_dis1,random_dis2,ret)
end

function UIDiscipleRequestCoupleWin:onCoupleHandleCallback(discipleguid1,discipleguid2,way)
self.isAnim=true
local cfg=cfg_reqcoupledialogueconfig()
local dialogueid=math.random(#cfg)
if way==1 then
self.resultEffect:setChildShowEffect(20204,true)
self.infoPanel:setActive(false)
self.root:setChildCanvasGroupAlpha(0)

self:delayDo(0.6,function()
self.winlua:SetChildUIModelShowFadeToColor(self.manModel:getID(),Color.New(1,1,1,0),1,0,nil)
self.winlua:SetChildUIModelShowFadeToColor(self.womanModel:getID(),Color.New(1,1,1,0),1,0,nil)
self.winlua:SetChildUIModelShowFadeToColor(self.redRopeModel:getID(),Color.New(1,1,1,0),1,0,nil)
local manSpeakTxt=cfg[dialogueid].manSpeakTxt
local womanSpeakTxt=cfg[dialogueid].womanSpeakTxt

self:createDZ(discipleguid1,1,manSpeakTxt,function(bt)
if self then
self.currManDZ=bt
end
end)
self:createDZ(discipleguid2,2,womanSpeakTxt,function(bt)
if self then
self.currWomanDZ=bt
end
end)
end)
self:delayDo(1.5,function()





self.heartEffect:setChildShowEffect(20202,true)

self.flowerEffect:setChildShowEffect(20203,true)

self.moonModel:setChildUIModelShowTarget(5391,1,{},eAnimationID.enter)






end)
self:delayDo(4.5,function()
self.currManDZ:setSharedVar('dPos',{-120,-40})
self.currWomanDZ:setSharedVar('dPos',{-648,-40})
self.currManDZ:setSharedVar('run',1)
self.currWomanDZ:setSharedVar('run',1)
self.currManDZ:broke()
self.currManDZ:reset()
self.currManDZ:tick(0)
self.currWomanDZ:broke()
self.currWomanDZ:reset()
self.currWomanDZ:tick(0)
end)
self:delayDo(7.5,function()
self.dzMan:setChildCanvasGroupDOFade(0,1)
self.dzWoman:setChildCanvasGroupDOFade(0,1,function()
UIManager:closeWindow("UIDiscipleRequestCoupleWin")
end)
end)
elseif way==0 then
self.manDialogueBg:setActive(false)
self.womanDialogueBg:setActive(false)

self.resultEffect:setChildShowEffect(20207,true)

self:delayDo(0.8,function()

self.winlua:SetChildModelAnimationState(self.redRopeModel:getID(),2195,1)
end)
self:delayDo(2.5,function()

self.manThunderEffect:setChildShowEffect(20209,true)
self.womanThunderEffect:setChildShowEffect(20209,true)
end)
self:delayDo(3,function()

self.winlua:SetChildUIModelGray(self.manModel:getID(),true)
self.winlua:SetChildUIModelGray(self.womanModel:getID(),true)

self.manSnowEffect:setChildShowEffect(20210,true)
self.womanSnowEffect:setChildShowEffect(20210,true)
end)
self:delayDo(3.8,function()

self.manDialogueBg:setActive(true)
end)
self:delayDo(4.8,function()

self.womanDialogueBg:setActive(true)
end)
self:delayDo(6.5,function()

self.winlua:SetChildCanvasGroupDOFade(self.manMask:getID(),0,1)
self.winlua:SetChildDOAnchorPos(self.manMask:getID(),Vector2.New(-450,-56),1)
self.winlua:SetChildCanvasGroupDOFade(self.womanMask:getID(),0,1)
self.winlua:SetChildDOAnchorPos(self.womanMask:getID(),Vector2.New(450,-56),1,function()
UIManager:closeWindow("UIDiscipleRequestCoupleWin")
end)
end)

self.refuseBtn:setActive(false)
self.agreeBtn:setActive(false)
local manDialogue=cfg[dialogueid].refuseManDialog
local womanDialogue=cfg[dialogueid].refuseWomanDialog
self.manDialogue:setText(manDialogue)
self.womanDialogue:setText(womanDialogue)
end
end

function UIDiscipleRequestCoupleWin:createDZ(dzId,sex,speakTxt,callback)
local initData={
dPos=sex==1 and{250,30}or{-250,30},
speakHUDParent=1,
offset={0,0},
speakTxt="#23",
speakTime=999,
run=1,
}
local tran
if sex==1 then
tran=self.dzMan:getCommonComponent('Transform')
else
tran=self.dzWoman:getCommonComponent('Transform')
end
local vpos=Vector2.zero
local otherData={
scale=0.8,
checkChuiWei=false,
}
uiAIManager:createUIDisciple('UIDiscipleRequestCoupleWin','bt_ui_coupleSuccess',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end

function UIDiscipleRequestCoupleWin:onRefuseBtn()
if self.isAnim then
return
end
local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local NowTimeStamp=timeHelper.getServerShortTime()
local pastTime=NowTimeStamp-self.timeStamp
if pastTime<=cfg.duration then
DiscipleCoupleController.send_2_144(self.manGuid,self.womanGuid,0)
else
DiscipleCoupleModel:DelReqCoupleList(self.manGuid,self.womanGuid)
UIManager:invokeUIMethod('UIFuncStorageWin','refreshCoupleRequestBtn')
UIManager:invokeUIMethod('UIDiscipleRequestCoupleListWin','onShow')
if#DiscipleCoupleModel:getReqCoupleList()<=0 then
UIManager:closeWindow('UIDiscipleRequestCoupleListWin')
end
UIManager.error("该弟子请求良缘时间已过期")
self:closeSelf()
end
end

function UIDiscipleRequestCoupleWin:onAgreeBtn()
if self.isAnim then
return
end
local cfg=cfgHelper.get1(cfg_disciplecoupleconfig_get,1)
local NowTimeStamp=timeHelper.getServerShortTime()
local pastTime=NowTimeStamp-self.timeStamp
if pastTime<=cfg.duration then
DiscipleCoupleController.send_2_144(self.manGuid,self.womanGuid,1)
else
DiscipleCoupleModel:DelReqCoupleList(self.manGuid,self.womanGuid)
UIManager:invokeUIMethod('UIFuncStorageWin','refreshCoupleRequestBtn')
UIManager:invokeUIMethod('UIDiscipleRequestCoupleListWin','onShow')
if#DiscipleCoupleModel:getReqCoupleList()<=0 then
UIManager:closeWindow('UIDiscipleRequestCoupleListWin')
end
UIManager.error("该弟子请求良缘时间已过期")
self:closeSelf()
end
end

function UIDiscipleRequestCoupleWin:onManInfoBtn()
if self.isAnim then
return
end
UIFullCommonControl:jumpDiscipleMain(self.manGuid,nil,closeCallback)
end

function UIDiscipleRequestCoupleWin:onWomanInfoBtn()
if self.isAnim then
return
end
UIFullCommonControl:jumpDiscipleMain(self.womanGuid,nil,closeCallback)
end

function UIDiscipleRequestCoupleWin:onManMask()
if self.isAnim then
return
end
UIFullCommonControl:jumpDiscipleMain(self.manGuid,nil,closeCallback)
end

function UIDiscipleRequestCoupleWin:onWomanMask()
if self.isAnim then
return
end
UIFullCommonControl:jumpDiscipleMain(self.womanGuid,nil,closeCallback)
end

function UIDiscipleRequestCoupleWin:onHelpBtn()
if self.isAnim then
return
end
local d={}
d.mode=3
d.title="规则介绍"
d.name='UIReqCoupleRule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end