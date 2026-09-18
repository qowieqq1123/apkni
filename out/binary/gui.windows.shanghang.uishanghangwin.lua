







def_class("UIShangHangWin",UIWindowBase)









function UIShangHangWin:bindComponents()

self.money1Btn=UIButton.get(self,0)
self.posRight2=UIObject.get(self,1)
self.posRight1=UIObject.get(self,2)
self.posCenter=UIObject.get(self,3)
self.posLeft2=UIObject.get(self,4)
self.posLeft1=UIObject.get(self,5)
self.gsName_2=UIText.get(self,6)
self.gsIcon_2=UIImage.get(self,7)
self.gsIcon_1=UIImage.get(self,8)
self.gsName_1=UIText.get(self,9)
self.moneyRoot=UIObject.get(self,10)
self.aiRoot=UIObject.get(self,11)
self.enterButton=UIButton.get(self,12)
self.closeBtn=UIButton.get(self,13)
self.zichanChang1=UILinkImageText.get(self,14)
self.up=UIObject.get(self,15)
self.down=UIObject.get(self,16)
self.zichanChang=UILinkImageText.get(self,17)
self.zichan=UILinkImageText.get(self,18)
self.timeTitle=UIText.get(self,19)
self.time=UIText.get(self,20)
self.xionggu=UIObject.get(self,21)
self.niugu=UIObject.get(self,22)
self.noGu=UIText.get(self,23)
self.testBtn=UIButton.get(self,24)
self.testReddot=UIObject.get(self,25)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.enterButton:setButtonClick(function()self:onEnterButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.testBtn:setButtonClick(function()self:onTestBtn()end)
self.gsName={
self.gsName_1,
self.gsName_2,
}
self.gsIcon={
self.gsIcon_1,
self.gsIcon_2,
}



end


function UIShangHangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.money1Btn);self.money1Btn=nil;
_UIObject_release(self.posRight2);self.posRight2=nil;
_UIObject_release(self.posRight1);self.posRight1=nil;
_UIObject_release(self.posCenter);self.posCenter=nil;
_UIObject_release(self.posLeft2);self.posLeft2=nil;
_UIObject_release(self.posLeft1);self.posLeft1=nil;
_UIObject_release(self.gsName_2);self.gsName_2=nil;
_UIObject_release(self.gsIcon_2);self.gsIcon_2=nil;
_UIObject_release(self.gsIcon_1);self.gsIcon_1=nil;
_UIObject_release(self.gsName_1);self.gsName_1=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.aiRoot);self.aiRoot=nil;
_UIObject_release(self.enterButton);self.enterButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.zichanChang1);self.zichanChang1=nil;
_UIObject_release(self.up);self.up=nil;
_UIObject_release(self.down);self.down=nil;
_UIObject_release(self.zichanChang);self.zichanChang=nil;
_UIObject_release(self.zichan);self.zichan=nil;
_UIObject_release(self.timeTitle);self.timeTitle=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.xionggu);self.xionggu=nil;
_UIObject_release(self.niugu);self.niugu=nil;
_UIObject_release(self.noGu);self.noGu=nil;
_UIObject_release(self.testBtn);self.testBtn=nil;
_UIObject_release(self.testReddot);self.testReddot=nil;
self.gsName=nil;
self.gsIcon=nil;
end


















local dizilist={{body=101011,compont={101011}},
{body=109011,compont={109011}},
{body=103011,compont={103011}},
}

function UIShangHangWin:onLoaded(...)
self:bindComponents()
end


function UIShangHangWin:__delete()
if self.curBT then
for i,v in pairs(self.curBT)do
uiAIManager:removeUIInstance(v)
end
self.curBT=nil
end

self:unbindComponents()

end




function UIShangHangWin:onShow(argtable,afterOnloaded)
local startMoney=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"init_yq")
local curMoney=shangHangModel:getZiChanZongZhi()
local iconStr=''
self.zichan:setText(FMT.fmt("{0}<color=#ca631d>{1}</color>",iconStr,mathHelper.formatNumber5(curMoney,2)))
local up=math.floor((curMoney-startMoney)/startMoney*10000)/100
if up==0 then
self.zichanChang1:setText("资产涨幅：暂无变化")
else
self.zichanChang:setText(FMT.fmt("<color={1}>{0}%</color>",up,up>0 and FONT_COLOR_VAL[FONT_COLOR.eRedColor]or FONT_COLOR_VAL[FONT_COLOR.eGreenColor]))

self.zichanChang1:setText("资产涨幅：")
end

self.up:setActive(up>0)
self.down:setActive(up<0)
local topUp,topDown=shangHangModel:getUpDownTop()
self.niugu:setActive(topUp~=nil)
self.xionggu:setActive(topDown~=nil)
self.noGu:setActive(topUp==nil)
self:startTime()
if topUp then
local cfg=cfgHelper.get(cfg_shanghangstockconfig_get,topUp)
self.gsName[1]:setText(cfg.name)
local icon=shangHangModel.getGuPiaoIcon(topUp)
self.gsIcon[1]:setIcon(icon)


end

if topDown then
local cfg=cfgHelper.get(cfg_shanghangstockconfig_get,topDown)
self.gsName[2]:setText(cfg.name)
local icon=shangHangModel.getGuPiaoIcon(topDown)
self.gsIcon[2]:setIcon(icon)
end


if self.curBT then
for i,v in pairs(self.curBT)do
uiAIManager:removeUIInstance(v)
end
self.curBT=nil
end
local createCB=function(bt)
self.curBT=self.curBT or{}
self.curBT[bt]=bt
end
local dzData=dizilist[1]
self:createDZ(dzData,self.posLeft1:getChildAnchoredPosition()+Vector2(200,0),0,0,createCB)
dzData=dizilist[2]
self:createDZ(dzData,self.posRight2:getChildAnchoredPosition(),2,1,createCB)
dzData=dizilist[3]
self:createDZ(dzData,self.posLeft1:getChildAnchoredPosition(),2,0,createCB)


self:freshMoney()
self:refreshTestWin()
end


function UIShangHangWin:onHide()

end

function UIShangHangWin.getShowTime()
local nextTime=shangHangModel:getNextChangeTime(true)
local endMonTime=shangHangModel:getMonEndTime(true)
local endEveTime=shangHangModel:getEveEndTime(true)
if shangHangModel:isWeekClose()then
local closeDay=shangHangModel.getCloseDay()+1
return FMT.fmt("{0}休市中",timeHelper.format_week_chinese(closeDay==7 and 0 or closeDay))
end
local now=timeHelper.getServerShortTime()


if now>endEveTime then
local openMonTime=shangHangModel:getMonBeginTime(true)
local weekIdx=timeHelper.getWeakDateEx()
local closeDay=shangHangModel.getCloseDay()
if closeDay==7 then closeDay=0 end
if weekIdx==closeDay then
return FMT.fmt("{0}休市中",timeHelper.format_week_chinese(closeDay))
end
return"距离早市开市",timeHelper.format_time_stamp3(openMonTime+86400-now)
end

local openMonTime=shangHangModel:getMonBeginTime(true)
if now<openMonTime then
return"距离早市开市",timeHelper.format_time_stamp3(openMonTime-now)
end

local openEveTime=shangHangModel:getEveBeginTime(true)
if now<openEveTime and now>endMonTime then
return"距离晚市开市",timeHelper.format_time_stamp3(openEveTime-now)
end
if nextTime==0 and now<endMonTime then
return"距离早市收市",timeHelper.format_time_stamp3(endMonTime-now)
end
if nextTime==0 and now<endEveTime and now>endMonTime then
return"距离晚市收市",timeHelper.format_time_stamp3(endEveTime-now)
end
return"下次价格波动",timeHelper.format_time_stamp3(nextTime-now)
end


function UIShangHangWin:startTime()

self:stopTime()
self.timeTimer=self:setTimer(1,0,function()
local tType,time=self.getShowTime()
if time then
self.timeTitle:setText(tType)
self.time:setText(time)
else
self.timeTitle:setText("")
self.time:setText(tType)
end
end)
end

function UIShangHangWin:stopTime()
if self.timeTimer then
self:stopTimerByID(self.timeTimer)
end
end

function UIShangHangWin:getRandomSpeakText(bt,tkey,idx)
local speakList=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"speakText")[idx]

local speakStr=speakList[math.random(1,#speakList)]or''
bt:setSharedVar(tkey,speakStr)
end

function UIShangHangWin:createDZ(dzData,pos,stateId,isEnter,callback)

local posList=
{
posCenter=self.posCenter:getChildAnchoredPosition(),
posLeft1=self.posLeft1:getChildAnchoredPosition(),
posLeft2=self.posLeft2:getChildAnchoredPosition(),
posRight1=self.posRight1:getChildAnchoredPosition(),
posRight2=self.posRight2:getChildAnchoredPosition(),
}

local initData={
sepaktime=3,
speakrate=0.5,
speakHUDParent=1,
stateId=stateId,
isEnter=isEnter or 0,

offset={0,120},

posCenter={posList.posCenter.x,posList.posCenter.y},
posLeft1={posList.posLeft1.x,posList.posLeft1.y},
posLeft2={posList.posLeft2.x,posList.posLeft2.y},
posRight1={posList.posRight1.x,posList.posRight1.y},
posRight2={posList.posRight2.x,posList.posRight2.y},
}

local tran=self.aiRoot:getCommonComponent('Transform')






uiAIManager:createUIObject('UIShangHangWin','bt_shanghang_enter',INSTANCE_TYPE.eUIDisciple,dzData.body,tran,pos,initData,{scale=0.8,componets=dzData.compont},function(bt)
callback(bt)
end)
end

function UIShangHangWin:freshMoney()
local moneyRoot=self.moneyRoot:getChildWidgetBase()
local money=shangHangModel:getActorMoney()
if not self.initMoneyIcon then
local iconname=shangHangModel.getYuQuanIcon()
moneyRoot:SetChildIcon(0,iconname,false)
self.initMoneyIcon=true
end
moneyRoot:SetChildText(1,mathHelper.formatNumber5(money,2))
end

function UIShangHangWin:onMoney1Btn()
shangHangController.showTransformMoney(self.moneyRoot,Vector2(-70,-100))
end





function UIShangHangWin:onEnterButton()
UIFullShangHangController:showShangHangTouZiWindow()
end

function UIShangHangWin:onCloseBtn()
UIFullShangHangEnterController:closeUI(true,false)
end

function UIShangHangWin:onTestBtn()
UIManager:showWindow("UITestTagBtnWin",{systemId=2,})
end

function UIShangHangWin:refreshTestWin()
local checkReddot
local systemIndexType=UISettingModel:getSystemIndexType()
local checkBtn=UISettingModel:checkIsOpenTest(systemIndexType.ShangShi)

if not checkBtn then
UIManager:invokeUIMethod("UITestTagBtnWin",'closeWin')
else
checkReddot=UISettingModel:checkTestTagReddot(systemIndexType.ShangShi)
self.winlua:SetChildActive(self.testReddot:getID(),checkReddot)
end

self.winlua:SetChildActive(self.testBtn:getID(),checkBtn)
end