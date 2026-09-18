







def_class("UIWanBaoXunBaoDui_RecruitWin",UIWindowBase)









function UIWanBaoXunBaoDui_RecruitWin:bindComponents()

self.bgspine=UIObject.get(self,0)
self.Root=UIObject.get(self,1)
self.recruitModelRoot=UIObject.get(self,2)
self.recruitStateRoot=UIObject.get(self,3)
self.idleimg=UIObject.get(self,4)
self.recruitRateRoot=UIObject.get(self,5)
self.closebtn=UIButton.get(self,6)
self.tipBtn=UIButton.get(self,7)
self.recruitNeedRoot=UIObject.get(self,8)
self.levelinfo=UIText.get(self,9)
self.stateRecruitBtn=UIButton.get(self,10)
self.addbtn=UIButton.get(self,11)
self.reducebtn=UIButton.get(self,12)
self.moneyName=UIText.get(self,13)
self.recruitStateInfo=UIText.get(self,14)
self.statebg=UIObject.get(self,15)
self.countdownbg=UIObject.get(self,16)
self.statetxt=UIText.get(self,17)
self.countdowntip=UIText.get(self,18)
self.countdowntxt=UIText.get(self,19)
self.model=UIObject.get(self,20)
self.adjustRoot=UIObject.get(self,21)
self.wagetxt=UIText.get(self,22)

self.closebtn:setButtonClick(function()self:onClosebtn()end)

self.tipBtn:setButtonClick(function()self:onTipBtn()end)

self.stateRecruitBtn:setButtonClick(function()self:onStateRecruitBtn()end)

self.addbtn:setButtonClick(function()self:onAddbtn()end)

self.reducebtn:setButtonClick(function()self:onReducebtn()end)



end


function UIWanBaoXunBaoDui_RecruitWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgspine);self.bgspine=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.recruitModelRoot);self.recruitModelRoot=nil;
_UIObject_release(self.recruitStateRoot);self.recruitStateRoot=nil;
_UIObject_release(self.idleimg);self.idleimg=nil;
_UIObject_release(self.recruitRateRoot);self.recruitRateRoot=nil;
_UIObject_release(self.closebtn);self.closebtn=nil;
_UIObject_release(self.tipBtn);self.tipBtn=nil;
_UIObject_release(self.recruitNeedRoot);self.recruitNeedRoot=nil;
_UIObject_release(self.levelinfo);self.levelinfo=nil;
_UIObject_release(self.stateRecruitBtn);self.stateRecruitBtn=nil;
_UIObject_release(self.addbtn);self.addbtn=nil;
_UIObject_release(self.reducebtn);self.reducebtn=nil;
_UIObject_release(self.moneyName);self.moneyName=nil;
_UIObject_release(self.recruitStateInfo);self.recruitStateInfo=nil;
_UIObject_release(self.statebg);self.statebg=nil;
_UIObject_release(self.countdownbg);self.countdownbg=nil;
_UIObject_release(self.statetxt);self.statetxt=nil;
_UIObject_release(self.countdowntip);self.countdowntip=nil;
_UIObject_release(self.countdowntxt);self.countdowntxt=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.adjustRoot);self.adjustRoot=nil;
_UIObject_release(self.wagetxt);self.wagetxt=nil;
end



















function UIWanBaoXunBaoDui_RecruitWin:onLoaded(...)
self:bindComponents()
self.btTreeList={}

self:addNotify(notifyConfig.onWanBaoXunBaoDuiCatComeInterview,function(...)self:onWanBaoXunBaoDuiCatComeInterview(...)end)
self:addNotify(notifyConfig.onWanBaoXunBaoDuiDealCatInterView,function(...)self:onWanBaoXunBaoDuiDealCatInterView(...)end)

end


function UIWanBaoXunBaoDui_RecruitWin:__delete()
self:unbindComponents()
for index=1,3 do
if self.btTreeList[index]then
behaviorManager:removeBehaviorTree(self.btTreeList[index])
self.btTreeList[index]=nil
end
end

if self.tid then
self:stopTimerByID(self.tid)
self.tid=nil
end
UIManager:invokeUIMethod('UIWanBaoXunBaoDui_MTSceneWin','startShowRecruitment')

end




function UIWanBaoXunBaoDui_RecruitWin:onShow(argtable,afterOnloaded)
self.Root:setChildCanvasGroupAlpha(0)

AudioManager.playAudio(627)

self.rlv=wanBaoXunBaoDuiModel:getRecruitLv()
self.model:setChildUIModelShowTarget(3030,0.3,{},0,false,false,0,nil)
self.model:setChildUIModelShowTargetOffset(0,-200)
self.model:setChildUIModelShowFlipX(true)
self:initUI()
self:onShowArgRecv()

self.bgspine:setChildSpineAnimation(eAnimationID.enter,1,nil)
self:delayDo(0.3,function()
self.Root:setChildCanvasGroupDOFade(1,0.2,nil)
end)
end


function UIWanBaoXunBaoDui_RecruitWin:onHide()

end

function UIWanBaoXunBaoDui_RecruitWin:onShowArgRecv()
self:showWindow("UITopMoneyWin2",{moneys={{eMoneyType.mtYuBi}},offsetX=385,offsetY=-138})
end





function UIWanBaoXunBaoDui_RecruitWin:onReducebtn()
local reducelvcfg=cfgHelper.get1(cfg_catconfig_get,self.rlv-1)
if reducelvcfg then
self.rlv=self.rlv-1
self:initUI()
end
end


function UIWanBaoXunBaoDui_RecruitWin:onAddbtn()
local reducelvcfg=cfgHelper.get1(cfg_catconfig_get,self.rlv+1)
if reducelvcfg then
self.rlv=self.rlv+1
self:initUI()
end
end


function UIWanBaoXunBaoDui_RecruitWin:onStateRecruitBtn()
if self.rstate then

wanBaoXunBaoDuiController:reqCancelRecruit()
else

if wanBaoXunBaoDuiModel:isFullEmployee()then
local recruitDatas=wanBaoXunBaoDuiModel:getRecruitDatas()
if#recruitDatas<3 then
local cfg=cfgHelper.get1(cfg_catconfig_get,self.rlv)
local moneyNum=moneyModel.getMoney(eMoneyType.mtYuBi)
if moneyNum>=cfg.consume then
wanBaoXunBaoDuiModel:setLocalRecruitLv(self.rlv)
wanBaoXunBaoDuiController:reqStartRecruit(self.rlv)
else
UIManager.info("货币不足")
gainControl:showGainWin(eMoneyType.mtYuBi)
end
else
UIManager.info("请先处理来聘请的猫猫哟")
end
else
UIManager.info('雇员已满员了喵')
end
end
end



function UIWanBaoXunBaoDui_RecruitWin:onClosebtn()

UIFullWanBaoXunBaoDuiController:closeWindow('UIWanBaoXunBaoDui_RecruitWin')
end

function UIWanBaoXunBaoDui_RecruitWin:onTipBtn()
local d={}

d.title='提示'
d.mode=3
d.name='wbxbd_recruitment_rule_help_%d'

self:showWindow('UIRuleWin',d)
end


function UIWanBaoXunBaoDui_RecruitWin:initUI()
self.rstate=wanBaoXunBaoDuiModel:getRecruitState()
self:freshAdjustCmp()
self:freshCountDownCmp()
self:freshRecruits()
end

function UIWanBaoXunBaoDui_RecruitWin:freshAdjustCmp()

local rcfg=cfgHelper.get1(cfg_catconfig_get,self.rlv-1)
local acfg=cfgHelper.get1(cfg_catconfig_get,self.rlv+1)
self.addbtn:setGray(not acfg)
self.reducebtn:setGray(not rcfg)

local recruitLvCfg=cfgHelper.get1(cfg_catconfig_get,self.rlv)
self.wagetxt:setText(recruitLvCfg.consume)
self.levelinfo:setText(FMT.fmt("{0}级",self.rlv))
self.recruitStateInfo:setText(self.rstate and"取消招聘"or"开始招聘")

local widght=self.recruitRateRoot:getWidgetBase()
local maxw=0
for k,v in pairs(recruitLvCfg.color)do
maxw=maxw+v
end

for k,v in pairs(recruitLvCfg.color)do
widght:SetChildText(k,FMT.fmt("{0}\n%",Mathf.Floor(v/maxw*100)))
end
end


function UIWanBaoXunBaoDui_RecruitWin:freshCountDownCmp()
self.recruitStateRoot:setActive(self.rstate)
self.idleimg:setActive(not self.rstate)
if self.rstate then
if self.tid then
self:stopTimerByID(self.tid)
self.tid=nil
end
local leftTime=wanBaoXunBaoDuiModel:getRecruitLeftTime()
local func=function()
leftTime=leftTime-1
self.countdowntxt:setText(timeHelper.format_time_stamp3(leftTime))
if leftTime<=0 then

self:stopTimerByID(self.tid)
end
end
self.tid=self:setTimer(1,0,func)
func()
end
end

function UIWanBaoXunBaoDui_RecruitWin:freshRecruits()
local recruitDatas=wanBaoXunBaoDuiModel:getRecruitDatas()

local rwidght=self.recruitModelRoot:getWidgetBase()
for i=1,3 do
local data=recruitDatas[i]
local item=rwidght:GetChildWidgetBase(i)
item:SetChildActive(-1,data~=nil)
if data~=nil then
self:freshSingleRecruit(item,data,i)
end
item:SetChildNewBieComponentId(-1,FMT.fmt('UIWanBaoXunBaoDui_RecruitWin.recruit_{0}',i))
end
end

function UIWanBaoXunBaoDui_RecruitWin:freshSingleRecruit(item,data,index)
if self.btTreeList[index]then
if self.btTreeList[index]:getSharedVar('donging')==0 then
behaviorManager:removeBehaviorTree(self.btTreeList[index])
self.btTreeList[index]=nil
else
return
end
end

local cfg=cfgHelper.get1(cfg_catshowconfig_get,data.wx_id)
local modelid=cfg.model
item:SetChildUIModelShowTarget(0,modelid,2,{},0,false,false,0,nil)
item:SetChildUIModelShowFlipX(0,true)
item:SetBaseItemClickEvent(-1,function()
UIFullWanBaoXunBaoDuiController:showWindow("UIWanBaoXunBaoDui_RecruitmentWin",{type=WBXBD_ReCruitment_TYPE.recruit})
end)

local initData={
widget=item,
stateId=WBXBD_BT_Type.None,

speakid=1,
speakType=WBXBD_Speak_Type.recruit,
startWaitTime=0.5,
endWaitTime=Mathf.Random(6,10),
speakOffset={-30,80},
speakDuration=5,
}

self.btTreeList[index]=behaviorManager:addBehaviorTree('bt_ui_wbxbd_employee',{},true,initData)
self.btTreeList[index]:setSharedVar('donging',0)
end

function UIWanBaoXunBaoDui_RecruitWin:addRecruit(data,index)

local rwidght=self.recruitModelRoot:getWidgetBase()
local item=rwidght:GetChildWidgetBase(index)
local modelid=cfgHelper.get2(cfg_catshowconfig_get,data.wx_id,'model')

item:SetBaseItemClickEvent(-1,function()
UIFullWanBaoXunBaoDuiController:showWindow("UIWanBaoXunBaoDui_RecruitmentWin",{type=WBXBD_ReCruitment_TYPE.recruit})
end)

if self.btTreeList[index]then
behaviorManager:removeBehaviorTree(self.btTreeList[index])
self.btTreeList[index]=nil
end

local initData={
widget=item,
modelIndex=0,
modelid=modelid,
startPos={0,-200},
showDuration=2,
endPos={0,-100},
moveSpeed=50,
modelScale=2,

stateId=WBXBD_BT_Type.ZP_Recruit,

speakType=WBXBD_Speak_Type.recruit,
startWaitTime=0.5,
endWaitTime=Mathf.Random(6,10),
speakOffset={-30,100},
speakDuration=5,

donging=1,
}
self.btTreeList[index]=behaviorManager:addBehaviorTree('bt_ui_wbxbd_employee',{},true,initData)
self.btTreeList[index]:setSharedVar('donging',1)
end

function UIWanBaoXunBaoDui_RecruitWin:onWanBaoXunBaoDuiCatComeInterview(data,index)
self.rstate=wanBaoXunBaoDuiModel:getRecruitState()
self:addRecruit(data,index)
self:freshAdjustCmp()
self:freshCountDownCmp()
end

function UIWanBaoXunBaoDui_RecruitWin:onWanBaoXunBaoDuiDealCatInterView(index,type)
self:freshRecruits()
end