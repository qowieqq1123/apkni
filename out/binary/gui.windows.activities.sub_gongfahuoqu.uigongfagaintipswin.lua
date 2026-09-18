







def_class("UIGongfaGainTipsWin",UIWindowBase)









function UIGongfaGainTipsWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.modelMao=UIObject.get(self,2)
self.desc1Txt=UIText.get(self,3)
self.gotoBtn=UIButton.get(self,4)
self.cancelBtn=UIButton.get(self,5)
self.showToggle=UIToggleButton.get(self,6)
self.speakObj=UIObject.get(self,7)
self.progressBar=UIProgress.get(self,8)
self.speakText=UIText.get(self,9)
self.tipsTx=UIText.get(self,10)
self.gfItem=UIBaseItem.get(self,11)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UIGongfaGainTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.modelMao);self.modelMao=nil;
_UIObject_release(self.desc1Txt);self.desc1Txt=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.showToggle);self.showToggle=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.gfItem);self.gfItem=nil;
end















local _this=nil



function UIGongfaGainTipsWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
end


function UIGongfaGainTipsWin:__delete()
local flag=self.showToggle:getToggle()
if flag==true then
local key=FMT.fmt("act_gongfaGainTip_open_{0}_{1}",self.actID,self.subid)
onlineDataSetting:setData(key,true)

end

self:unbindComponents()
_this=nil
end




function UIGongfaGainTipsWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.talklist=self.config.auto_talklist or{}
self.extraParams=argtable.extraParams

if not self.info or not self.info:checkDoing()or not self.info:hasData()then
return
end

self:updateView()

self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4701,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.35,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
self.modelMao:setChildUIModelShowTarget(4016,0.3,{},eAnimationID.stand,false,false,0,nil)
self.modelMao:setChildUIModelShowFlipX(true)

if#self.talklist>0 then
self:playSpeak(2)
end
end


function UIGongfaGainTipsWin:onHide()

end



function UIGongfaGainTipsWin.onSubActivityStateChange(actID,subType,subid,state)
if _this==nil then return end

if _this.actID==actID and _this.subType==subType and _this.subid==subid then
if state==activitiesModel.activityFinishState then
_this:closeSelf()
end
end
end

function UIGongfaGainTipsWin:refreshActTime()
local data=self.info:getData()
local time=self.info:getEndLeftTime()
local str_fmt=self.config.endTips
local least=self.config.aim-data.taskProgress
local money_str=FMT.fmt(str_fmt,self.config.sub_name,timeHelper.format_time_stamp(time,true),least)
self.desc1Txt:setText(money_str)
end

function UIGongfaGainTipsWin:updateView()
if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
self:refreshActTime()
end

local data=self.info:getData()
local reward=self.config.reward[1]
local itemId=reward[1]
local itemNum=reward[2]
local max=self.config.aim
local cur=tonumber(tostring(data.taskProgress))
cur=math.min(cur,max)
local str=FMT.fmt("{0}/{1}",cur,max)
self.progressBar:setProgressValue(math.floor(cur/max*10000),10000)
self.progressBar:setChildProgressText(str)

local showCountBG=itemNum>1
local countStr=showCountBG and itemNum or""
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.gfItem:setChildPropData(prop)
self.gfItem:setBaseItemClickEvent(function(...)
itemsComponentHelper.onItemClick(...)
end)

local tipsStr=self.config.desc
self.tipsTx:setText(tipsStr)
end

function UIGongfaGainTipsWin:onGotoBtn()
activitiesController:jump(self.actID,self.subType,self.subid)
end

function UIGongfaGainTipsWin:onCancelBtn()
local actID=self.actID
local subType=self.subType
local subid=self.subid
local extraParams=self.extraParams
self:closeSelf()
activitiesModel:extraCheck(actID,nil,nil,extraParams,activityExtracheckType.eTianDaoMiJi)
end


function UIGongfaGainTipsWin:playSpeak(delay)
self:clearTalk()
if delay~=nil and delay>0 then
self.nextTalkTimer=self:delayDo(delay,function()
self.nextTalkTimer=nil
self:doSpeaking()
end)
else
self:doSpeaking()
end
end

function UIGongfaGainTipsWin:doSpeaking()
local talkarr=self.talklist
local speakStr=table.randomIndex(talkarr)
self.speakObj:setChildCanvasGroupAlpha(1)
local speed=30
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim()

self.talkLifeTimer=self:delayDo(5,function()
self.talkLifeTimer=nil
self:finishSpeak()
end)
end

function UIGongfaGainTipsWin:doTalkAnim()
self.speakObj:setScale(Vector3.zero)
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
end)
end)
end

function UIGongfaGainTipsWin:finishSpeak()
self.speakObj:setChildCanvasGroupAlpha(0)

self:playSpeak(5)
end

function UIGongfaGainTipsWin:clearTalk()
if self.nextTalkTimer~=nil then
self:stopTimerByID(self.nextTalkTimer)
self.nextTalkTimer=nil
end
if self.talkLifeTimer~=nil then
self:stopTimerByID(self.talkLifeTimer)
self.talkLifeTimer=nil
end
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setChildCanvasGroupAlpha(0)
end

