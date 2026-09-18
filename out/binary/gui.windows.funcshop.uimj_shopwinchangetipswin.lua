







def_class("UIMJ_ShopWinChangeTipsWin",UIWindowBase)









function UIMJ_ShopWinChangeTipsWin:bindComponents()

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

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UIMJ_ShopWinChangeTipsWin:unbindComponents()
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
end
















local _this=nil


function UIMJ_ShopWinChangeTipsWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIMJ_ShopWinChangeTipsWin:__delete()
_this=nil
local flag=self.showToggle:getToggle()
self:unbindComponents()
if flag==true then

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMoJieShop,flag)
end
if self.myTimer~=nil then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
end
end


function UIMJ_ShopWinChangeTipsWin:onHide()

end




function UIMJ_ShopWinChangeTipsWin:onShow(argtable,afterOnloaded)
local enterData=xianjieModel:getMoJieEnterData()
if enterData==nil then
logErr("魔界已经关闭，不能打开界面 UIMJ_ShopWinChangeTipsWin")
self:closeSelf()
return
end
local nowTime=timeHelper.getServerShortTime()
local const_def=cfgHelper.getdef(cfg_devildomshopconfig)
local duration=const_def.duration
local cfg=cfgHelper.get1(cfg_devildomseasonconfig_get,enterData.sId)
self.shopCfg=cfgHelper.get(cfg_shoplistconfig_get,eFuncShopType.eMojieSaiJi)
self.auto_excharge=cfg.auto[1]
self.talklist={}
self.shopbegintime=nowTime
self.shopendtime=enterData.eTime+duration


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

function UIMJ_ShopWinChangeTipsWin:refreshActTime()
local nowTime=timeHelper.getServerShortTime()
local time=self.shopendtime-nowTime
if time>0 then
local str_fmt='<color=#6833c0>{0}</color>将于<color=#549327>{1}</color>后结束，仙友仍剩余{2}，请及时进行兑换'
local moneyType=self.auto_excharge[1]
local itemcfg=itemsConfig.getConfig(moneyType)
local s=FMT.fmt('{0}X{1}',itemcfg.name,itemsModel.getCount(moneyType))
s=FMT.cfmt(itemcfg.color,s)
local money_str=FMT.fmt(str_fmt,self.shopCfg.name,timeHelper.format_time_stamp3(time),s)
self.desc1Txt:setText(money_str)
else
if self.myTimer~=nil then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
end
self:closeSelf()
end
end

function UIMJ_ShopWinChangeTipsWin:updateView()
local auto=self.auto_excharge
if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
self:refreshActTime()
end
local moneyType=auto[1]
local price1=auto[2]
local moneyType2=auto[3]
local price2=auto[4]
local name1=itemsConfig.getColorName(moneyType)
local name2=itemsConfig.getColorName(moneyType2)
local str=FMT.fmt('{0}将于{2}结束后回收为{1}',name1,name2,self.shopCfg.name)
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

function UIMJ_ShopWinChangeTipsWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
function UIMJ_ShopWinChangeTipsWin:onGotoBtn()
xianjieController:MoJieShop_Enter()
self:closeSelf()
end
function UIMJ_ShopWinChangeTipsWin:onCancelBtn()




self:closeSelf()

end


function UIMJ_ShopWinChangeTipsWin:playSpeak(delay)
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
function UIMJ_ShopWinChangeTipsWin:doSpeaking()
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
function UIMJ_ShopWinChangeTipsWin:doTalkAnim()
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
function UIMJ_ShopWinChangeTipsWin:finishSpeak()
self.speakObj:setChildCanvasGroupAlpha(0)
self:playSpeak(5)
end
function UIMJ_ShopWinChangeTipsWin:clearTalk()
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
