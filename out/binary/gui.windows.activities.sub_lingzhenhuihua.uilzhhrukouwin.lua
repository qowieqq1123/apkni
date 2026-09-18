







def_class("UILZHHRuKouWin",UIWindowBase)









function UILZHHRuKouWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.btreddot=UIObject.get(self,1)
self.btreddot2=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.closeTx=UIText.get(self,4)
self.quickFinishGameBtn=UIButton.get(self,5)
self.quickFinishGameTxt=UIText.get(self,6)
self.quickFinishMaxScore=UIText.get(self,7)
self.quickModelLayout=UIObject.get(self,8)
self.random2CampBtn=UIButton.get(self,9)
self.randomCampBtn=UIButton.get(self,10)
self.selectCampBtn1=UIButton.get(self,11)
self.selectCampBtn2=UIButton.get(self,12)
self.selectCampPanel=UIObject.get(self,13)
self.speakObj1=UIObject.get(self,14)
self.speakObj2=UIObject.get(self,15)
self.speakText1=UIText.get(self,16)
self.speakText2=UIText.get(self,17)
self.timeText=UIText.get(self,18)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.quickFinishGameBtn:setButtonClick(function()self:onQuickFinishGameBtn()end)

self.random2CampBtn:setButtonClick(function()self:onRandom2CampBtn()end)

self.randomCampBtn:setButtonClick(function()self:onRandomCampBtn()end)

self.selectCampBtn1:setButtonClick(function()self:onSelectCampBtn1()end)

self.selectCampBtn2:setButtonClick(function()self:onSelectCampBtn2()end)



end


function UILZHHRuKouWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.btreddot);self.btreddot=nil;
_UIObject_release(self.btreddot2);self.btreddot2=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeTx);self.closeTx=nil;
_UIObject_release(self.quickFinishGameBtn);self.quickFinishGameBtn=nil;
_UIObject_release(self.quickFinishGameTxt);self.quickFinishGameTxt=nil;
_UIObject_release(self.quickFinishMaxScore);self.quickFinishMaxScore=nil;
_UIObject_release(self.quickModelLayout);self.quickModelLayout=nil;
_UIObject_release(self.random2CampBtn);self.random2CampBtn=nil;
_UIObject_release(self.randomCampBtn);self.randomCampBtn=nil;
_UIObject_release(self.selectCampBtn1);self.selectCampBtn1=nil;
_UIObject_release(self.selectCampBtn2);self.selectCampBtn2=nil;
_UIObject_release(self.selectCampPanel);self.selectCampPanel=nil;
_UIObject_release(self.speakObj1);self.speakObj1=nil;
_UIObject_release(self.speakObj2);self.speakObj2=nil;
_UIObject_release(self.speakText1);self.speakText1=nil;
_UIObject_release(self.speakText2);self.speakText2=nil;
_UIObject_release(self.timeText);self.timeText=nil;
end
















local _this
local campShowPanelCmpIndex={
campName=0,
campScore=1,
rewardScrollView=2,
rewardList=3,
selfFlag=4,
firstEffect=5,
}



function UILZHHRuKouWin:onLoaded(...)
self:bindComponents()
_this=self

local _recv_249_251=function(...)
if _this==nil then return end

_this:recv_249_251(...)
end
self:addProNotify(249,251,_recv_249_251)
end


function UILZHHRuKouWin:__delete()
self:unbindComponents()
self:clearTimer()
end




function UILZHHRuKouWin:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

self.sdFlagState=self.info:getQuickFlag()

self:onShowArgRecv(argtable,afterOnloaded)
local isreddot=self.info:checkdayreddot()or false
self.btreddot:setActive(isreddot)
end

function UILZHHRuKouWin:onShowArgRecv(argtable,afterOnloaded)
if not self.info then
UIManager.error("活动已结束")
return self:onCloseBtn()
end

if afterOnloaded then
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),true,true,true)
end
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5501,1,{},eAnimationID.stand)
end


self.lastSpeakIndex1=nil
self.lastSpeakIndex2=nil
self:refresh(true)
end


function UILZHHRuKouWin:onHide()
self:clearTimer()

end

function UILZHHRuKouWin:refresh(isInit)

self:setRemainingTimeTimer()
self:refreshBtns()
end

function UILZHHRuKouWin:refreshBtns()
local quickFinishCnd=self.config and self.config.quickFinishCnd
local serverOpenDay=timeHelper.getServerOpenDay()
local isOpenQuick=serverOpenDay>=quickFinishCnd
isOpenQuick=false
self.randomCampBtn:setActive(not isOpenQuick)
self.quickModelLayout:setActive(isOpenQuick)
if isOpenQuick then
local maxScore=self.info:getMaxScore()or 0
local isCanQuick=maxScore>0
local isQuicked=self.info:getQuickFlag()
local btnTxt=isQuicked and"今日已扫荡"or"每日扫荡"
local scoreTxt=isCanQuick and maxScore or"暂无"

self.quickFinishGameTxt:setText(btnTxt)
self.quickFinishMaxScore:setText(FMT.fmt("最高积分：{0}",scoreTxt))
end
end



function UILZHHRuKouWin:setRemainingTimeTimer()
if self.info then
self:clearTimer()
local func=function()
local time=self.info:getEndLeftTime()
if time>0 then

local nowTime=timeHelper.getServerShortTime()
self.timeText:setText(FMT.fmt("活动时间：{0}",timeHelper.format_time_stamp11(time,true)))
if self.updateCampDataTime then
if nowTime>=self.updateCampDataTime then
self.updateCampDataTime=self.updateCampDataTime+600
activitiesHandle_lingzhendiaoke:reqGetCampScoreDataList(_this.actid,_this.subType,_this.subid)
end
end
if self.nextUpdateDataTime then
if nowTime>=self.nextUpdateDataTime then


end
end
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()

if not self.info then
self:onCloseBtn()
end
end
end
self.timer=self:setTimer(1,0,func)
func()
end
end



function UILZHHRuKouWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UILZHHRuKouWin:clearEffect()
for i=1,2 do
local campShowPanel=self[FMT.fmt("campShowPanel{0}",i)]
if campShowPanel then
local panelWidget=campShowPanel:getWidgetBase()
panelWidget:SetChildShowEffect(campShowPanelCmpIndex.firstEffect,0,false)
end
end
end





function UILZHHRuKouWin:onCloseBtn()
end



function UILZHHRuKouWin:onHelpBtn()
end



function UILZHHRuKouWin:onStartBtn()
end



function UILZHHRuKouWin:onRuleBtn()
end



function UILZHHRuKouWin:onShopBtn()
end



function UILZHHRuKouWin:onLianzhiBtn()
end



function UILZHHRuKouWin:onSelectCampBtn1()
end



function UILZHHRuKouWin:onSelectCampBtn2()
end



function UILZHHRuKouWin:onRandomCampBtn()

UIFullLingZhenHuiHuaControl:showMainWin(_this.activityArgs)
end

function UILZHHRuKouWin:onRandom2CampBtn()
self:onRandomCampBtn()
end

function UILZHHRuKouWin:onQuickFinishGameBtn()
local maxScore=self.info:getMaxScore()or 0
if maxScore>0 then
local isQuicked=self.info:getQuickFlag()
if isQuicked then
UIManager.info("今日已扫荡")
else
activitiesHandle_lingzhendiaoke:reqSetScore(_this.actid,_this.subType,_this.subid,maxScore,1)
end
else
UIManager.info("暂无积分记录，请先游玩游戏~")
end
end

function UILZHHRuKouWin:recv_249_251(...)
local args={...}
local sdFlag=args[4]==1
if sdFlag==self.sdFlagState then return end

local maxScore=self.info:getMaxScore()or 0

local temp=
{
success=true,
score=maxScore,
originalTopScore=maxScore,
roletopScore=maxScore,
act_id=_this.actid,
sub_act_type=_this.subType,
sub_act_id=_this.subid,
}
self:showWindow('UILZHHResultWin',temp)

self.sdFlagState=sdFlag

self:refreshBtns()
end


