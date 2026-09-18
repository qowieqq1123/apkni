







def_class("UISubAct_gongfaGainWin",UIWindowBase)









function UISubAct_gongfaGainWin:bindComponents()

self.root=UIObject.get(self,0)
self.getBtn1=UIButton.get(self,1)
self.skillItem_2=UIButton.get(self,2)
self.skillItem_1=UIButton.get(self,3)
self.skillItem_0=UIButton.get(self,4)
self.skillShow=UIObject.get(self,5)
self.dailyGetted=UIObject.get(self,6)
self.dailyBtn=UIButton.get(self,7)
self.getBtn2=UIButton.get(self,8)
self.progressBar=UIProgress.get(self,9)
self.title2=UIImage.get(self,10)
self.title=UIImage.get(self,11)
self.timeTx=UIText.get(self,12)
self.getBtnTx1=UIText.get(self,13)
self.tipsTx=UIText.get(self,14)
self.progressAddBtn=UIButton.get(self,15)
self.gfItem=UIBaseItem.get(self,16)
self.rewardGetted=UIObject.get(self,17)
self.rewardReddot=UIObject.get(self,18)

self.getBtn1:setButtonClick(function()self:onGetBtn1()end)

self.skillItem_2:setButtonClick(function()self:onSkillItem_2()end)

self.skillItem_1:setButtonClick(function()self:onSkillItem_1()end)

self.skillItem_0:setButtonClick(function()self:onSkillItem_0()end)

self.dailyBtn:setButtonClick(function()self:onDailyBtn()end)

self.getBtn2:setButtonClick(function()self:onGetBtn2()end)

self.progressAddBtn:setButtonClick(function()self:onProgressAddBtn()end)
self.skillItem={
[0]=self.skillItem_0,
[1]=self.skillItem_1,
[2]=self.skillItem_2,
}



end


function UISubAct_gongfaGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.getBtn1);self.getBtn1=nil;
_UIObject_release(self.skillItem_2);self.skillItem_2=nil;
_UIObject_release(self.skillItem_1);self.skillItem_1=nil;
_UIObject_release(self.skillItem_0);self.skillItem_0=nil;
_UIObject_release(self.skillShow);self.skillShow=nil;
_UIObject_release(self.dailyGetted);self.dailyGetted=nil;
_UIObject_release(self.dailyBtn);self.dailyBtn=nil;
_UIObject_release(self.getBtn2);self.getBtn2=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.getBtnTx1);self.getBtnTx1=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.progressAddBtn);self.progressAddBtn=nil;
_UIObject_release(self.gfItem);self.gfItem=nil;
_UIObject_release(self.rewardGetted);self.rewardGetted=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
self.skillItem=nil;
end















local _this=nil
local _skillCmp={
button=-1,
icon=0,
name=1,
sign=2,
}



function UISubAct_gongfaGainWin:onLoaded(...)
self:bindComponents()
_this=self

self._on_249_116=function(actId,subId,dailySec,taskProgress,rewardFlag)
if self.info:compare(actId,self.subType,subId)then
self:refreshView()
end
end
self:addProNotify(249,116,self._on_249_116)

self._onNewDay=function()
self:refreshDailyReward()
end
self._closeUI=function(...)
self:listenCloseUI(...)
end
self:addNotify(notifyConfig.onNewDay,self._onNewDay)
self:addNotify(notifyConfig.closeUI,self._closeUI)
end


function UISubAct_gongfaGainWin:__delete()
self:stopCDTick()

self:unbindComponents()
_this=nil

if self.battleId then
fightController:completeBattle(self.battleId,true)
fightController:closeBattle(self.battleId)
self.battleId=nil
end

if self.fightStage then
self.fightStage:close()
end
end




function UISubAct_gongfaGainWin:onShow(argtable,afterOnloaded)
if argtable then
local old=self.actId==argtable.act_id and self.subType==argtable.sub_act_type and self.subId==argtable.sub_act_id
self.actId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.argtable=argtable
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.actInfo=activitiesModel:getActInfo(self.actId)
if not old then
self:initView()
end
self:showFightReport()
if self.info and self.info:hasData()then
self:refreshView()
end
end
UIManager:hideWindow("UIRawImageBackWin")
end


function UISubAct_gongfaGainWin:onHide()
if self.battleId then
fightController:completeBattle(self.battleId,true)
fightController:closeBattle(self.battleId)
self.battleId=nil
end

if self.fightStage then
self.fightStage:close()
end
UIManager:showWindow("UIRawImageBackWin")
self.actInfo:invokePanelMethod("activeBlack",true)
self.actInfo:invokePanelMethod("setLockClick",false)
end





function UISubAct_gongfaGainWin:onDailyBtn()
if self.info:hasData()then
local data=self.info:getData()
if data.dailySec<=0 or not timeHelper.isTodayShort(data.dailySec)then
call_activitiesHandle_func("activitiesHandle_gongfagain","reqDailyReward",self.actId,self.subId)
end
end
end



function UISubAct_gongfaGainWin:onProgressAddBtn()
if self.config.gainJump then
jumpManager:jump(self.config.gainJump)
else
local itemid=self.config.param[1]
gainControl:showGainWin(itemid)
end
end

function UISubAct_gongfaGainWin:refreshView()
if self.info:hasData()then
local data=self.info:getData()
local reward=self.config.reward[1]
local itemId=reward[1]
local max=self.config.aim
local cur=tonumber(tostring(data.taskProgress))
cur=math.min(cur,max)
local str=FMT.fmt("{0}/{1}",cur,max)
self.progressBar:setProgressValue(math.floor(cur/max*10000),10000)
self.progressBar:setChildProgressText(str)

local enough=cur>=max
local rGet=data.rewardFlag==1
local color=itemsConfig.getItemColor(itemId)
if color>=eQualityColor.eGreen then
local prop={}
prop[PropIndex(DataPropKey.eWidgetQualityEffect,9)]=not rGet and color or-1
self.gfItem:setChildPropData(prop)
end

self.rewardGetted:setActive(rGet)
self.rewardReddot:setActive(not rGet and enough)
self.getBtn1:setActive(not rGet and not enough)
self.getBtn2:setActive(not rGet and enough)
else
self.progressBar:setProgressValue(0,10000)
self.progressBar:setChildProgressText("")
local prop={}
prop[PropIndex(DataPropKey.eWidgetQualityEffect,9)]=-1
self.gfItem:setChildPropData(prop)
self.rewardGetted:setActive(false)
self.rewardReddot:setActive(false)
self.getBtn1:setActive(false)
self.getBtn2:setActive(false)
end

self:refreshDailyReward()
end

function UISubAct_gongfaGainWin:refreshDailyReward()
if self.info:hasData()then
local data=self.info:getData()
local dGet=data.dailySec>0 and timeHelper.isTodayShort(data.dailySec)
local rGet=data.rewardFlag==1
self.dailyBtn:setActive(not dGet)
self.dailyGetted:setActive(false)
else
self.dailyBtn:setActive(false)
self.dailyGetted:setActive(false)
end
end

function UISubAct_gongfaGainWin:onClickReward(...)
if self.info:hasData()then
local data=self.info:getData()
if data.rewardFlag==0 then
local progress=tonumber(tostring(data.taskProgress))
if progress>=self.config.aim then
call_activitiesHandle_func("activitiesHandle_gongfagain","reqTaskReward",self.actId,self.subId)
return
end
end
end
itemsComponentHelper.onItemClick(...)
end

function UISubAct_gongfaGainWin:initView()
self:startCDTick()

if self.argtable.title then
self.title:setSprite(self.argtable.title[1],self.argtable.title[2])
end
if self.argtable.title2 then
self.title2:setSprite(self.argtable.title2[1],self.argtable.title2[2])
end

local rewardData=self.config.reward[1]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.gfItem:setChildPropData(prop)
self.gfItem:setBaseItemClickEvent(function(...)
self:onClickReward(...)
end)

local tipsStr=self.config.desc
self.tipsTx:setText(tipsStr)

local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.config.gongfa)
local skillWidget0=self.skillItem_0:getWidgetBase()
skillWidget0:SetChildIcon(_skillCmp.icon,iconHelper.getSkillIcon(cfg.icon),true)
skillWidget0:SetChildText(_skillCmp.name,cfg.name)
skillWidget0:SetChildActive(_skillCmp.sign,false)

for index=1,2 do
local skillItem=self.skillItem[index]
local skillWidget=skillItem:getWidgetBase()
local skillID=cfg.skill[index]
local hasSkill=skillID~=nil
skillWidget:SetChildActive(_skillCmp.button,hasSkill)
if hasSkill then
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
skillWidget:SetChildIcon(_skillCmp.icon,iconHelper.getSkillIcon(skillCfg.icon),true)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
skillWidget:SetChildActive(_skillCmp.sign,is_bd)
skillWidget:SetChildText(_skillCmp.name,skillCfg.name)
end
end

self.getBtnTx1:setText(self.config.gainTips or"获得积分")
end

function UISubAct_gongfaGainWin:showFightReport()
if not self._onFightStageLoaded then
self._onFightStageLoaded=function()
self.actInfo:invokePanelMethod("activeBlack",false)
self.actInfo:invokePanelMethod("setLockClick",false)
local report=fightModel:getFightReport(self.config.fightReport)
self.battleId=fightController:startBallte(report,true,nil,nil,{hideStartWin=true,repeatPlayRound=true,entHideHud=true,resetCamera=true,fightUseType=FIGHT_USE_TYPE.eYanShi})
self.fightBattle=fightModel:getBattle(self.battleId)
self.fightBattle:setAccMulti(1,false)
end
end

self.actInfo:invokePanelMethod("activeBlack",true)
self.actInfo:invokePanelMethod("setLockClick",true)
self.fightStage=fightStage:create(self.config.fightStage,self._onFightStageLoaded,{})
end

function UISubAct_gongfaGainWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_gongfaGainWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_gongfaGainWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.actId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end

function UISubAct_gongfaGainWin:onSkillItem_0()
UIManager:showWindow('UIGongFaTipsFiveWin',{gfID=self.config.gongfa})
end

function UISubAct_gongfaGainWin:onSkillItem_1()
self:showSkillDialog(1)
end

function UISubAct_gongfaGainWin:onSkillItem_2()
self:showSkillDialog(2)
end

function UISubAct_gongfaGainWin:showSkillDialog(index)
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.config.gongfa)
local skillID=cfg.skill[index]
local args={skillID=skillID,skillLv=1,fromCfg=true}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end

function UISubAct_gongfaGainWin:onGetBtn1()
self:onProgressAddBtn()
end

function UISubAct_gongfaGainWin:onGetBtn2()
if self.info:hasData()then
local data=self.info:getData()
if data.rewardFlag==0 then
local progress=tonumber(tostring(data.taskProgress))
if progress>=self.config.aim then
call_activitiesHandle_func("activitiesHandle_gongfagain","reqTaskReward",self.actId,self.subId)
end
end
end
end

function UISubAct_gongfaGainWin:listenCloseUI(winName,isClose)
if winName=="UIReportDisplayWin"or winName=="UIReportDisplayFrameWin"then
_this:showFightReport()
end
end