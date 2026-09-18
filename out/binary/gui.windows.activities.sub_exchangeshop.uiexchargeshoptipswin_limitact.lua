







def_class("UIExchargeShopTipsWin_limitact",UIWindowBase)









function UIExchargeShopTipsWin_limitact:bindComponents()

self.frameSp=UIObject.get(self,0)
self.modelMao=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.desc1Txt=UIText.get(self,3)
self.changeItem=UIObject.get(self,4)
self.desc2Txt=UIText.get(self,5)
self.gotoBtn=UIButton.get(self,6)
self.cancelBtn=UIButton.get(self,7)
self.showToggle=UIToggleButton.get(self,8)
self.speakObj=UIObject.get(self,9)
self.speakText=UIText.get(self,10)
self.closeBtn=UIButton.get(self,11)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIExchargeShopTipsWin_limitact:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.modelMao);self.modelMao=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.desc1Txt);self.desc1Txt=nil;
_UIObject_release(self.changeItem);self.changeItem=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.showToggle);self.showToggle=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end



















local _this=nil


function UIExchargeShopTipsWin_limitact:onLoaded(...)
_this=self
self:bindComponents()

end


function UIExchargeShopTipsWin_limitact:__delete()
_this=nil
local flag=self.showToggle:getToggle()
self:unbindComponents()

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eZZSHShop,flag)
end


function UIExchargeShopTipsWin_limitact:onHide()

end






function UIExchargeShopTipsWin_limitact:onShow(argtable,afterOnloaded)








self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4701,1,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.35,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
self.modelMao:setChildUIModelShowTarget(4016,0.3,{},eAnimationID.stand,false,false,0,nil)
self.modelMao:setChildUIModelShowFlipX(true)
self.talklist=cfgHelper.get2(cfg_zhengzhanshanhaiconfig_get,1,"auto_talklist")
if#self.talklist>0 then
self:playSpeak(2)
end
self:SetRightData()
self:updateView()
end


function UIExchargeShopTipsWin_limitact:SetRightData()

self.desc2Txt:setText("<color=#ca631d>寻仙机缘</color>将于活动结束后回收为<color=#3375c0>灵石</color>")
if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
self:refreshActTime()
end

end

function UIExchargeShopTipsWin_limitact:refreshActTime()

local table1=limitActivitiesModel:getActInfo(10005)
local time=table1.end_time-timeHelper.getServerShortTime()

local auto=cfgHelper.get2(cfg_zhengzhanshanhaiconfig_get,1,"auto")
local moneyType=auto[1][1]
local name1=itemsConfig.getColorName(moneyType)
local hasnum=itemsModel.getCount(moneyType)
local str=FMT.fmt("<color=#6833c0>山海商店</color>将于<color=#549327>{0}</color>后结束，仙友仍剩余<color=#ca631d>{1}X{2}</color>，请及时进行兑换",timeHelper.format_time_stamp(time,true),name1,hasnum)
self.desc1Txt:setText(str)
end


function UIExchargeShopTipsWin_limitact:updateView()
if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
self:refreshActTime()
end
local auto=cfgHelper.get2(cfg_zhengzhanshanhaiconfig_get,1,"auto")
if auto then
local moneyType=auto[1][1]
local price1=auto[1][2]
local moneyType2=auto[1][3]
local price2=auto[1][4]
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

end

function UIExchargeShopTipsWin_limitact:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end






function UIExchargeShopTipsWin_limitact:playSpeak(delay)
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

function UIExchargeShopTipsWin_limitact:doSpeaking()
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

function UIExchargeShopTipsWin_limitact:doTalkAnim()
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

function UIExchargeShopTipsWin_limitact:finishSpeak()
self.speakObj:setChildCanvasGroupAlpha(0)

self:playSpeak(5)
end

function UIExchargeShopTipsWin_limitact:clearTalk()
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

function UIExchargeShopTipsWin_limitact:onCloseBtn()
self:closeSelf()

end

function UIExchargeShopTipsWin_limitact:onCancelBtn()
if not _this then return end
_this:closeSelf()
end


function UIExchargeShopTipsWin_limitact:onGotoBtn()
jumpManager:jump({id=JUMP_TYPE.eAllShop,args={shopId=12}})
end
