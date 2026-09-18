







def_class("UISubAct_xianjieqiyuan_LimitExchangeDialog",UIWindowBase)









function UISubAct_xianjieqiyuan_LimitExchangeDialog:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.modelMao=UIObject.get(self,2)
self.desc1Txt=UIText.get(self,3)
self.changeItem=UIObject.get(self,4)
self.desc2Txt=UIText.get(self,5)
self.exchangeBtn=UIButton.get(self,6)
self.showToggle=UIToggleButton.get(self,7)
self.speakObj=UIObject.get(self,8)
self.speakText=UIText.get(self,9)

self.exchangeBtn:setButtonClick(function()self:onExchangeBtn()end)



end


function UISubAct_xianjieqiyuan_LimitExchangeDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.modelMao);self.modelMao=nil;
_UIObject_release(self.desc1Txt);self.desc1Txt=nil;
_UIObject_release(self.changeItem);self.changeItem=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.exchangeBtn);self.exchangeBtn=nil;
_UIObject_release(self.showToggle);self.showToggle=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
end















local _this=nil



function UISubAct_xianjieqiyuan_LimitExchangeDialog:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.onSubActivityStateChange,self.onSubActivityStateChange)
end


function UISubAct_xianjieqiyuan_LimitExchangeDialog:__delete()
local flag=self.showToggle:getToggle()
_this=nil
self:unbindComponents()
if flag==true then
onlineDataSetting:setData('act_exchargeXianJieQiYuan_open',true)
end
end




function UISubAct_xianjieqiyuan_LimitExchangeDialog:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.extraParams=argtable.extraParams
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

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

self:playSpeak(2)
end


function UISubAct_xianjieqiyuan_LimitExchangeDialog:onHide()

end



function UISubAct_xianjieqiyuan_LimitExchangeDialog:onExchangeBtn()
activitiesController:jump(self.actID,self.subType,self.subid)
end


function UISubAct_xianjieqiyuan_LimitExchangeDialog:onCancelBtn()
local actID=self.actID
local subType=self.subType
local subid=self.subid
local extraParams=self.extraParams
self:closeSelf()
activitiesModel:extraCheck(actID,nil,nil,extraParams,activityExtracheckType.eXianJieQiYuan)
end

function UISubAct_xianjieqiyuan_LimitExchangeDialog.onSubActivityStateChange(actID,subType,subid,state)
if _this==nil then return end

if _this.actID==actID and _this.subType==subType and _this.subid==subid then
if state==activitiesModel.activityFinishState then
_this:closeSelf()
end
end
end

function UISubAct_xianjieqiyuan_LimitExchangeDialog:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end


function UISubAct_xianjieqiyuan_LimitExchangeDialog:playSpeak(delay)
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

function UISubAct_xianjieqiyuan_LimitExchangeDialog:doSpeaking()
local talkarr=self.config.talkList
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

function UISubAct_xianjieqiyuan_LimitExchangeDialog:doTalkAnim()
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

function UISubAct_xianjieqiyuan_LimitExchangeDialog:finishSpeak()
self.speakObj:setChildCanvasGroupAlpha(0)

self:playSpeak(5)
end

function UISubAct_xianjieqiyuan_LimitExchangeDialog:clearTalk()
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


function UISubAct_xianjieqiyuan_LimitExchangeDialog:refreshActTime()
local time=self.info:getEndLeftTime()
local timeStr=timeHelper.format_time_stamp(time,true)
local str_fmt='<color=#6833c0>{0}</color>将于<color=#549327>{1}</color>后结束，{2}在活动结束后将兑换为{3}，请及时进行抽取'
local itemId=self.config.itemid
local itemCfg=itemsConfig.getConfig(itemId)
local funcparam=itemCfg.funcparam
local reward_list=funcparam.reward_list
local itemName=itemsConfig.getColorName(itemId)
local targetName=itemsConfig.getColorName(reward_list[1])
local money_str=FMT.fmt(str_fmt,self.config.sub_name,timeStr,itemName,targetName)
self.desc1Txt:setText(money_str)
end

function UISubAct_xianjieqiyuan_LimitExchangeDialog:updateView()
if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
self:refreshActTime()
end











local sItemId=self.config.itemid
local itemCfg=itemsConfig.getConfig(sItemId)
local funcparam=itemCfg.funcparam
local reward_list=funcparam.reward_list
local tItemId=reward_list[1]
local exchangePer=reward_list[2]
local sNum=itemsModel.getCount(sItemId)
local tNum=sNum*exchangePer

local idx=1
local widget=self.changeItem:getChildWidgetBase()
if idx==1 then

local itemid=sItemId
local itemnum=sNum
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

local itemid=tItemId
local itemnum=tNum
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
widget:SetChildPropData(2,prop)
widget:SetBaseItemClickEvent(2,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
widget:SetChildText(3,itemsConfig.getItemName(itemid))
end
end