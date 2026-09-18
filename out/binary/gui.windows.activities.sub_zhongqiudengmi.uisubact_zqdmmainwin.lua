







def_class("UISubAct_ZQDMmainWin",UIWindowBase)









function UISubAct_ZQDMmainWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.actytime=UIText.get(self,1)
self.npcModel=UIObject.get(self,2)
self.speakObj=UIObject.get(self,3)
self.speakText=UIText.get(self,4)
self.jianglitext=UIText.get(self,5)
self.rwScrollView=UIObject.get(self,6)
self.gobtn=UIButton.get(self,7)
self.gobtnimg=UIImage.get(self,8)
self.rulebtn=UIButton.get(self,9)
self.rewardList=UIObject.get(self,10)
self.rolea=UIObject.get(self,11)
self.roleb=UIObject.get(self,12)
self.rolec=UIObject.get(self,13)
self.roled=UIObject.get(self,14)
self.centerPanel=UIObject.get(self,15)
self.btnPanel=UIObject.get(self,16)

self.gobtn:setButtonClick(function()self:onGobtn()end)

self.rulebtn:setButtonClick(function()self:onRulebtn()end)



end


function UISubAct_ZQDMmainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.actytime);self.actytime=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.jianglitext);self.jianglitext=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.gobtn);self.gobtn=nil;
_UIObject_release(self.gobtnimg);self.gobtnimg=nil;
_UIObject_release(self.rulebtn);self.rulebtn=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rolea);self.rolea=nil;
_UIObject_release(self.roleb);self.roleb=nil;
_UIObject_release(self.rolec);self.rolec=nil;
_UIObject_release(self.roled);self.roled=nil;
_UIObject_release(self.centerPanel);self.centerPanel=nil;
_UIObject_release(self.btnPanel);self.btnPanel=nil;
end
















local _this
local abname="ui/windows/activities/sub_zhongqiudengmi/zhongqiudengmi_atlas_pak.ab"
local roleindex=
{
npcmodel=0,
speakobj=1,
speaktxt=2,
}
local roleids={2004,2003,2002,2001}



function UISubAct_ZQDMmainWin:onLoaded(...)
self:bindComponents()
_this=self
self.rolelists={self.rolea,self.roleb,self.rolec,self.roled}
end


function UISubAct_ZQDMmainWin:__delete()
self:clearTimer()
self:unbindComponents()
_this=nil
end




function UISubAct_ZQDMmainWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
if not self.sub_actInfo then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.startday=self.sub_actInfo.start_day_idx
self.start_time=self.sub_actInfo.start_time
self.end_time=self.sub_actInfo.end_time

self.bgModel:setChildUIModelShowTarget(5569,1,{},eAnimationID.stand,false,false,0,function()




end)

self.subcfg=cfg_lanternriddlesconfig_get(self.subid)
self:refreshActivityTime()
self:refreshShopModel()
self:freshdatijindu()
self:freshinfo()
self:freshbtntxt()
self:doSpeaking_player()
self:freshRolePanel()
end


function UISubAct_ZQDMmainWin:onHide()

end


function UISubAct_ZQDMmainWin:refreshOtherDay()
_this:freshdatijindu()
_this:freshinfo()
_this:freshbtntxt()
end



function UISubAct_ZQDMmainWin:onRulebtn()
local d={}
d.title='规则说明'
d.mode=3
d.name='UISubAct_ZQDMmainWin_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UISubAct_ZQDMmainWin:onGobtn()
local reward_bits=self.sub_actInfo:getRewardBits()
local idx=self.sub_actInfo:getOpenDayIndex()

local maxNum=self:getMaxTitleNum()
if maxNum>0 then
local isgot=bitHelper.check_pos(reward_bits,idx-1)
if isgot then
UIManager.info("祖师今日挑战已完成！")
else
local finishIdex=self:getNowNum()
if finishIdex>=maxNum then
UIManager.info("祖师今日挑战已完成！")
return
end
local temp=
{
act_id=self.actID,
sub_act_type=self.subType,
sub_act_id=self.subid,
parentwin=self,
}
self:showWindow("UISubAct_ZQDMtitleWin",temp)
end
end
end

function UISubAct_ZQDMmainWin:refreshActivityTime()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.end_time and self.end_time-nowTime or 0
if lerp>0 then

self.actytime:setText(FMT.fmt("<color=#f1ce78>{0}结束倒计时：</color>{1}",self.subcfg.sub_name,timeHelper.format_time_stamp3(lerp,true)))
else
self.actytime:setText("活动已结束")
UIManager.error("活动已结束")
self.isOver=true
self:clearTimer()
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UISubAct_ZQDMmainWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_ZQDMmainWin:refreshShopModel()
local cfg_npcmodelid=4016
self.npcModel:setChildUIModelShowTarget(cfg_npcmodelid,0.28,{},eAnimationID.stand)

end

function UISubAct_ZQDMmainWin:doSpeaking_player()
local cfg=self.subcfg.shopspeaks
local speakList=cfg
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim_player()
end

function UISubAct_ZQDMmainWin:doTalkAnim_player()
if self.talkTween2~=nil then
self.talkTween2:Kill()
self.talkTween2=nil
end

self.speakObj:setScale(Vector3.zero)
self:delayDo(0.2,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween2=self.speakObj:setChildDOScale(1.2,0.2,function()
if self==nil then return end
self.talkTween2=nil
self.talkTween2=self.speakObj:setChildDOScale(0.9,0.1,function()
if self==nil then return end
self.talkTween2=nil
return self:talkEnd()
end)
end)
end)
end
function UISubAct_ZQDMmainWin:talkEnd()
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
self.speakShowTimer=self:delayDo(3.5,function()

if self==nil then return end
self.speakObj:setScale(Vector3.zero)
self.speakObj:setChildCanvasGroupAlpha(0)

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end)
end

function UISubAct_ZQDMmainWin:ClickSpeaking_player()
self:doSpeaking_player()
end


function UISubAct_ZQDMmainWin:freshinfo()
local idx=self.sub_actInfo:getOpenDayIndex()
local cfg_questions=self.subcfg.questions
local reward={}
if idx and idx>0 and cfg_questions[idx]then
reward=cfg_questions[idx][2]
end
if reward and next(reward)then

local reward_bits=self.sub_actInfo:getRewardBits()
local widget=self.rewardList:getWidgetBase()
for i=1,4 do
local rewardItem=widget:GetChildWidgetBase(i-1)
local rewards=reward[i]
if rewards then
rewardItem:SetChildActive(0,true)
local itemid=rewards[1]
local itemnum=rewards[2]
local graynum=0
local isgot=bitHelper.check_pos(reward_bits,idx-1)
if isgot then
graynum=mathHelper.setbit(graynum,eGrayType.eGray-1)
rewardItem:SetChildActive(2,true)
else
rewardItem:SetChildActive(2,false)
graynum=0
end
local itemcount=mathHelper.formatNumber7(itemnum,nil,2)
local conf={itemid=itemid,itemcount=itemcount,showCountBG=true,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(1,prop)
rewardItem:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
else
rewardItem:SetChildActive(0,false)
end
end
end
end

function UISubAct_ZQDMmainWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end

function UISubAct_ZQDMmainWin:getMaxTitleNum()
local idx=self.sub_actInfo:getOpenDayIndex()
local cfg_questions=self.subcfg.questions
if idx and idx>0 then
local questionslist=cfg_questions[idx]
if questionslist and questionslist[1]then
return#questionslist[1]
end
end
return 0
end

function UISubAct_ZQDMmainWin:getNowNum()
local finishIdex=self.sub_actInfo:getAnserdata()
return finishIdex
end

function UISubAct_ZQDMmainWin:freshbtntxt()
local reward_bits=self.sub_actInfo:getRewardBits()
local idx=self.sub_actInfo:getOpenDayIndex()
local finishIdex=self:getNowNum()
local maxNum=self:getMaxTitleNum()
if maxNum>0 then
local isgot=bitHelper.check_pos(reward_bits,idx-1)
if isgot then
self.winlua:SetChildCSImageSprite(self.gobtnimg:getID(),abname,'image_2024caidengmiwz_3')
else
if finishIdex==0 then
self.winlua:SetChildCSImageSprite(self.gobtnimg:getID(),abname,'image_2024caidengmiwz_1')
else
self.winlua:SetChildCSImageSprite(self.gobtnimg:getID(),abname,'image_2024caidengmiwz_2')
end
end
end
end

function UISubAct_ZQDMmainWin:freshdatijindu()
local finishIdex=self:getNowNum()
local maxNum=self:getMaxTitleNum()
local reward_bits=self.sub_actInfo:getRewardBits()
local idx=self.sub_actInfo:getOpenDayIndex()or 1
local str=""
local isgot=bitHelper.check_pos(reward_bits,idx-1)
if isgot then
str=FMT.fmt('即可领取奖励（<color=#549327>{0}/{1}</color>）',finishIdex,maxNum)
else
str=FMT.fmt('即可领取奖励（<color=#c82c2c>{0}/{1}</color>）',finishIdex,maxNum)
end
self.jianglitext:setText(str)
end

function UISubAct_ZQDMmainWin:openRewardwin()
local temp=
{
act_id=_this.actID,
sub_act_type=_this.subType,
sub_act_id=_this.subid,
}
_this:showWindow("UISubAct_ZQDMrewardWin",temp)
end


function UISubAct_ZQDMmainWin:freshRolePanel()
for k,v in ipairs(self.rolelists)do
local widget=v:getChildWidgetBase()
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(roleids[k])
local imageInfo=dizidata.imageInfo
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)

widget:SetChildUIModelShowTarget(roleindex.npcmodel,modelParams.body,0.95,modelParams.componets,0)
widget:SetChildUIModelShowFlipX(roleindex.npcmodel,true)
end
end
function UISubAct_ZQDMmainWin:doSpeaking_playera()
local cfg=self.subcfg.shopspeaks
local speakList=cfg
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim_playera()
end
function UISubAct_ZQDMmainWin:doTalkAnim_playera()
if self.talkTween2~=nil then
self.talkTween2:Kill()
self.talkTween2=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.2,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween2=self.speakObj:setChildDOScale(1.2,0.2,function()
if self==nil then return end
self.talkTween2=nil
self.talkTween2=self.speakObj:setChildDOScale(0.9,0.1,function()
if self==nil then return end
self.talkTween2=nil
return self:talkEnda()
end)
end)
end)
end
function UISubAct_ZQDMmainWin:talkEnda()
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
self.speakShowTimer=self:delayDo(3.5,function()

if self==nil then return end
self.speakObj:setScale(Vector3.zero)
self.speakObj:setChildCanvasGroupAlpha(0)

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end)
end