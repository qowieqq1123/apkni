







def_class("UISubAct_NiuDanJiExchangeTipsWin",UIWindowBase)









function UISubAct_NiuDanJiExchangeTipsWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.modelMao=UIObject.get(self,2)
self.desc1Txt=UIText.get(self,3)
self.changeItem=UIObject.get(self,4)
self.desc2Txt=UIText.get(self,5)
self.gotoBtn=UIButton.get(self,6)
self.cancelBtn=UIButton.get(self,7)
self.showToggle=UIToggleButton.get(self,8)
self.speakObj=UIObject.get(self,9)
self.speakText=UIText.get(self,10)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UISubAct_NiuDanJiExchangeTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.modelMao);self.modelMao=nil;
_UIObject_release(self.desc1Txt);self.desc1Txt=nil;
_UIObject_release(self.changeItem);self.changeItem=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.showToggle);self.showToggle=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
end
















local _this=nil


function UISubAct_NiuDanJiExchangeTipsWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
end


function UISubAct_NiuDanJiExchangeTipsWin:__delete()
_this=nil
local flag=self.showToggle:getToggle()
self:unbindComponents()
if flag==true then
onlineDataSetting:setData('act_exchargeShopTip_open',true)
end
end


function UISubAct_NiuDanJiExchangeTipsWin:onHide()

end

function UISubAct_NiuDanJiExchangeTipsWin.onSubActivityStateChange(actID,subType,subid,state)
if _this==nil then return end

if _this.actID==actID and _this.subType==subType and _this.subid==subid then
if state==activitiesModel.activityFinishState then
_this:closeSelf()
end
end
end




function UISubAct_NiuDanJiExchangeTipsWin:onShow(argtable,afterOnloaded)
local actID=argtable.act_id
local subType=argtable.sub_act_type
local subid=argtable.sub_act_id
self.actcfg=activitiesModel:getSubActivityConfig(subType,subid)
self.talklist=self.actcfg.auto_talklist or{}
self.moneyType=self.actcfg.money[1]
self.actID=actID
self.subType=subType
self.subid=subid
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
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

function UISubAct_NiuDanJiExchangeTipsWin:refreshActTime()
local time=self.sub_actInfo:getEndLeftTime()
local str_fmt='<color=#6833c0>{0}</color>将于<color=#549327>{1}</color>后结束，仙友仍剩余{2}，请及时进行兑换'
local moneyType=self.moneyType
local itemcfg=itemsConfig.getConfig(moneyType)
local s=FMT.fmt('{0}X{1}',itemcfg.name,itemsModel.getCount(moneyType))
s=FMT.cfmt(itemcfg.color,s)
local money_str=FMT.fmt(str_fmt,self.actcfg.sub_name,timeHelper.format_time_stamp(time,true),s)
self.desc1Txt:setText(money_str)
end

function UISubAct_NiuDanJiExchangeTipsWin:updateView()
if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
self:refreshActTime()
end
local moneyType=self.moneyType
local price1=1
local moneyType2=eMoneyType.mtLingShi
local price2=self.actcfg.rate
local name1=itemsConfig.getColorName(moneyType)
local name2=itemsConfig.getColorName(moneyType2)
local str=FMT.fmt('{0}将于活动结束后回收为{1}',name1,name2)
self.desc2Txt:setText(str)

local hasnum=itemsModel.getCount(moneyType)
local idx=1
local widget=self.changeItem:getChildWidgetBase()
if idx==1 then

local itemid=moneyType
local itemnum=hasnum
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
widget:SetChildText(1,itemsConfig.getItemName(itemid))
end
idx=2
if idx==2 then

local itemid=moneyType2
local itemnum=hasnum/price1*price2
local itemcount,showCountBG
if itemnum>1 then
itemcount=mathHelper.formatNumber7(itemnum,1,2)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(2,prop)
widget:SetBaseItemClickEvent(2,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
widget:SetChildText(3,itemsConfig.getItemName(itemid))
end
end

function UISubAct_NiuDanJiExchangeTipsWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_NiuDanJiExchangeTipsWin:onGotoBtn()
local args={
activityId=self.actID,
subType=self.subType,
subId=self.subid,
activityData=self.sub_actInfo,
config=self.actcfg,
}
UIManager:showWindow("UISubAct_NiuDanJiExchangeWin",args)
self:closeSelf()
end

function UISubAct_NiuDanJiExchangeTipsWin:onCancelBtn()
self:closeSelf()
end


function UISubAct_NiuDanJiExchangeTipsWin:playSpeak(delay)
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

function UISubAct_NiuDanJiExchangeTipsWin:doSpeaking()
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

function UISubAct_NiuDanJiExchangeTipsWin:doTalkAnim()
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

function UISubAct_NiuDanJiExchangeTipsWin:finishSpeak()
self.speakObj:setChildCanvasGroupAlpha(0)

self:playSpeak(5)
end

function UISubAct_NiuDanJiExchangeTipsWin:clearTalk()
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
