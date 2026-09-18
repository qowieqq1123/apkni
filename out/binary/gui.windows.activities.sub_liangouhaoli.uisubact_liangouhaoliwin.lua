







def_class("UISubAct_LianGouHaoLiWin",UIWindowBase)









function UISubAct_LianGouHaoLiWin:bindComponents()

self.buyed=UIObject.get(self,0)
self.day_0=UIObject.get(self,1)
self.day_1=UIObject.get(self,2)
self.day_2=UIObject.get(self,3)
self.day_3=UIObject.get(self,4)
self.day_4=UIObject.get(self,5)
self.day_5=UIObject.get(self,6)
self.dayBtn=UIButton.get(self,7)
self.dayReddot=UIObject.get(self,8)
self.getted=UIObject.get(self,9)
self.lockTx=UIText.get(self,10)
self.nameImage0=UIImage.get(self,11)
self.nameImage1=UIImage.get(self,12)
self.nameImageTx=UIText.get(self,13)
self.nameTx=UIText.get(self,14)
self.percentBg=UIObject.get(self,15)
self.percentTx=UIText.get(self,16)
self.progressTx=UIText.get(self,17)
self.rewardBtn=UIButton.get(self,18)
self.rewardBtnTx=UIText.get(self,19)
self.rewardImage=UIObject.get(self,20)
self.rewardList=UIObject.get(self,21)
self.rewardReddot=UIObject.get(self,22)
self.tabRewardBtn=UIButton.get(self,23)
self.timeBg=UIImage.get(self,24)
self.timeTx=UIText.get(self,25)
self.tipsTx=UIText.get(self,26)
self.title=UIObject.get(self,27)
self.titleBg2=UIObject.get(self,28)
self.titleTx=UIText.get(self,29)

self.dayBtn:setButtonClick(function()self:onDayBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.tabRewardBtn:setButtonClick(function()self:onTabRewardBtn()end)
self.day={
[0]=self.day_0,
[1]=self.day_1,
[2]=self.day_2,
[3]=self.day_3,
[4]=self.day_4,
[5]=self.day_5,
}



end


function UISubAct_LianGouHaoLiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buyed);self.buyed=nil;
_UIObject_release(self.day_0);self.day_0=nil;
_UIObject_release(self.day_1);self.day_1=nil;
_UIObject_release(self.day_2);self.day_2=nil;
_UIObject_release(self.day_3);self.day_3=nil;
_UIObject_release(self.day_4);self.day_4=nil;
_UIObject_release(self.day_5);self.day_5=nil;
_UIObject_release(self.dayBtn);self.dayBtn=nil;
_UIObject_release(self.dayReddot);self.dayReddot=nil;
_UIObject_release(self.getted);self.getted=nil;
_UIObject_release(self.lockTx);self.lockTx=nil;
_UIObject_release(self.nameImage0);self.nameImage0=nil;
_UIObject_release(self.nameImage1);self.nameImage1=nil;
_UIObject_release(self.nameImageTx);self.nameImageTx=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.percentBg);self.percentBg=nil;
_UIObject_release(self.percentTx);self.percentTx=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardBtnTx);self.rewardBtnTx=nil;
_UIObject_release(self.rewardImage);self.rewardImage=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.tabRewardBtn);self.tabRewardBtn=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.titleBg2);self.titleBg2=nil;
_UIObject_release(self.titleTx);self.titleTx=nil;
self.day=nil;
end















local _this=nil
local _progressWidth=702
local _itemCmp={
root=-1,
gou=0,
itemBg=1,
item=2,
select=3,
lock=4,
timeTx=5,
}
local _dayNormalCmp={
icon=0,
lock=1,
gou=2,
dayTx=3,
model=4,
button=5,
black=6,
}
local _dayFinalCmp={
model=0,
icon=1,
gou=2,
button=3,
reddot=4,
}



function UISubAct_LianGouHaoLiWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
end


function UISubAct_LianGouHaoLiWin:__delete()
self:stopCDTick()
self:stopDayTick()

self:unbindComponents()
_this=nil

notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)
end




function UISubAct_LianGouHaoLiWin:onShow(argtable,afterOnloaded)
if argtable then
local old=self.activityId==argtable.act_id and self.subType==argtable.sub_act_type and self.subId==argtable.sub_act_id
self.actId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.parentWin=argtable.parentWin
self.argtable=argtable
if not old then
self:initView()
else
self:refreshViewImp()
end
end
end


function UISubAct_LianGouHaoLiWin:onHide()

end





function UISubAct_LianGouHaoLiWin:onDayBtn()
if self.info:checkReddot()then
local handleName=activitiesController:getHandleName(self.subType)
call_activitiesHandle_func(handleName,'reqDailyReward',self.actId,self.subId)
end
end



function UISubAct_LianGouHaoLiWin:onRewardBtn()
local data=self.info:getData()
if data then
if self.select<=0 then
local count=#self.config.rewards
local pass=mathHelper.cntbit(data.flag,1,count)
local getted=mathHelper.getBitValue(data.flag,0)
if pass>=count and not getted then
local handleName=activitiesController:getHandleName(self.subType)
call_activitiesHandle_func(handleName,'reqFinalReward',self.actId,self.subId)
else
UIManager.info("购买前面天数全部礼包可领取")
end
else
local buyed=mathHelper.getBitValue(data.flag,self.select)
if not buyed then
local recharge=self.config.rewards[self.select][3]
local handleName=activitiesController:getHandleName(self.subType)
call_activitiesHandle_func(handleName,'reqBuyReward',self.actId,self.subId,recharge,self.select)
end
end
end
end


function UISubAct_LianGouHaoLiWin:onFinalBg()
self:onClickShow(0)
end

function UISubAct_LianGouHaoLiWin:onTabRewardBtn()
local data=self.info:getData()
local args={
act_id=self.actId,
sub_act_type=self.subType,
sub_act_id=self.subId,
parentWin=self,
aimIndex=data.aimIndex,
}
self:showWindow("UISubAct_LGHL_SelectRewardWin",args)
end

function UISubAct_LianGouHaoLiWin:initNormalDay(index,item)
local showCfg=self.config.show[index]
local rewardCfg=self.config.rewards[index]
local data=self.info:getData()
local flag=data and mathHelper.getBitValue(data.flag,index)or false
local widget=item:getWidgetBase()
local isLock=self.openDay<rewardCfg[1]
widget:SetChildCSImageIcon(_dayNormalCmp.icon,iconHelper.getIconName(showCfg[1]),false)
widget:SetChildText(_dayNormalCmp.dayTx,FMT.fmt("第{0}天",rewardCfg[1]))
widget:SetChildButtonClick(_dayNormalCmp.button,function()
self:onClickShow(index)
end)
widget:SetChildActive(_dayNormalCmp.gou,flag)
widget:SetChildActive(_dayNormalCmp.lock,isLock)
local anim=self.select==index and eAnimationID.juanzhou_idle2 or eAnimationID.juanzhou_idle1








widget:SetChildUIModelShowTarget(_dayNormalCmp.model,4705,1,{},anim,false,false,0)
widget:SetChildActive(_dayNormalCmp.black,isLock)
end

function UISubAct_LianGouHaoLiWin:initFinalDay(item)
local showCfg=self.config.show[#self.config.show]
local widget=item:getWidgetBase()

widget:SetChildCSImageIcon(_dayFinalCmp.icon,iconHelper.getIconName(showCfg[1]),false)
widget:SetChildButtonClick(_dayFinalCmp.button,function()
self:onClickShow(0)
end)

local anim=self.select==0 and eAnimationID.juanzhou_idle3 or eAnimationID.juanzhou_idle2
widget:SetChildUIModelShowTarget(_dayFinalCmp.model,4707,1,{},anim,false,false,0)

self:refreshFinalReddot()
end

function UISubAct_LianGouHaoLiWin:initView()
self.titleTx:setText(self.config.titlePrice)
if pfwindowslController:checkIsGameVersion_HWFT()then
self.titleTx:setActive(false)
self.titleBg2:setActive(false)
end

local count=#self.config.rewards
local _perX=_progressWidth/(#self.config.show)
self.openDay=self.info:getStartDay()
for i,v in pairs(self.day)do
if i>0 then
self:initNormalDay(i,v)
else
self:initFinalDay(v)
end
end

self:startCDTick()

self:refreshDailyReward()

self:onClickShow(0)
end

function UISubAct_LianGouHaoLiWin:refreshView(actId,subType,subId)
if actId==self.actId and subType==subType and subId==self.subId then
self:refreshViewImp()
end
end

function UISubAct_LianGouHaoLiWin:refreshViewImp()
self:refreshSelectPanelData()
self:refreshDailyReward()
self:refreshDayBuy()
self:refreshFinalReddot()
end

function UISubAct_LianGouHaoLiWin:onClickShow(index)
local data=self.info:getData()
if data and self.select~=index then
local old=self.select
self.select=index
self:refreshSelectPanel()
if old then
self:refreshSelectItem(old)
end
end
end

function UISubAct_LianGouHaoLiWin:refreshSelectItem(index)
local dayCmp=self.day[index]
local rewardCfg=self.config.rewards[index]
local widget=dayCmp:getWidgetBase()
local isNormal=index>0
local cmp=isNormal and _dayNormalCmp or _dayFinalCmp
local isSelect=index==self.select

local anim=nil
if isNormal then
anim=isSelect and eAnimationID.juanzhou_idle2 or eAnimationID.juanzhou_idle1

local color=isSelect and Color.StrToColor('#7d3b17')or Color.StrToColor('#171311')
widget:SetTextColor(_dayNormalCmp.dayTx,color)






else
anim=isSelect and eAnimationID.juanzhou_idle3 or eAnimationID.juanzhou_idle2
end
widget:SetChildModelAnimationState(cmp.model,anim)
if isNormal then
local isLock=self.openDay<rewardCfg[1]
widget:SetChildActive(_dayNormalCmp.black,not isSelect and isLock)
end
end

function UISubAct_LianGouHaoLiWin:refreshFinalPanelData()

local data=self.info:getData()
local count=#self.config.rewards
local pass=mathHelper.cntbit(data.flag,1,count)
self:stopDayTick()
if pass<count then
self.tipsTx:setText("")
self.progressTx:setText(FMT.fmt("进度：{0}/{1}",pass,count))
self.rewardBtn:setActive(true)
self.rewardBtn:setImageExGray(true)
self.getted:setActive(false)
self.buyed:setActive(false)
self.rewardReddot:setActive(false)
else
local getted=mathHelper.getBitValue(data.flag,0)

if not getted then
self.progressTx:setText("")
self.tipsTx:setText("")
self.rewardBtn:setActive(true)
self.rewardBtn:setImageExGray(false)
self.getted:setActive(false)
self.buyed:setActive(false)
self.rewardReddot:setActive(true)
self.lockTx:setText("")
else

self.progressTx:setText("")
self.tipsTx:setText("")
self.rewardBtn:setActive(false)
self.rewardReddot:setActive(false)
self.getted:setActive(true)
self.buyed:setActive(false)
end
end
end

function UISubAct_LianGouHaoLiWin:refreshDayPanelData()
local data=self.info:getData()
local cfg=self.config.rewards[self.select]
local tDay=cfg[1]
local now_time=timeHelper.getServerLongTime()
local start_time=timeHelper.getServerZeroStamp(self.info.start_time_l)
local day=math.ceil((now_time-start_time)/86400)

if day<tDay then
self:startDayTick(start_time+(tDay-1)*86400)
self.tipsTx:setText("")
self.rewardBtn:setActive(false)
self.getted:setActive(false)
self.buyed:setActive(false)
self.progressTx:setText("")
else
local buyed=mathHelper.getBitValue(data.flag,self.select)
self:stopDayTick()
self.progressTx:setText("")
local isFinal=self.select<=0
if isFinal then
if type(self.config.aim[1])=="number"then
local len=0
local serverOpenDay=timeHelper.getServerOpenDay()
local zmLevel=zongmenModel:getLevel()or 0
for i,v in ipairs(self.config.aim)do
if serverOpenDay>=v[1]and zmLevel>=v[2]and(v[3]==0 or systemModel.isOpen(v[3]))then
len=len+1
end
end
local aimIndex=len==1 and 1 or data.aimIndex
self.rewardBtn:setActive(not buyed and aimIndex>0)
else
self.rewardBtn:setActive(not buyed)
end
else
self.rewardBtn:setActive(not buyed)
end
self.tipsTx:setText("")
self.getted:setActive(false)
self.buyed:setActive(buyed)
end
end

function UISubAct_LianGouHaoLiWin:refreshSelectPanelData()
local data=self.info:getData()
if data then
if self.select<=0 then
self:refreshFinalPanelData()
else
self:refreshDayPanelData()
end
end
end

function UISubAct_LianGouHaoLiWin:refreshSelectPanel()
local isFinal=self.select<=0
self.rewardImage:setActive(not isFinal)
local data=self.info:getData()
self.nameImage0:setActive(isFinal)
self.nameImage1:setActive(not isFinal)
if isFinal then
local show=self.config.show[#self.config.show]
self.nameTx:setText(show[2])
self.percentBg:setActive(show[3]~=nil)
if show[3]then
self.percentTx:setText(FMT.fmt("{0}倍",show[3]))
end
self.rewardBtnTx:setText("领取奖励")

if type(self.config.aim[1])=="number"then
local len=0
local serverOpenDay=timeHelper.getServerOpenDay()
local zmLevel=zongmenModel:getLevel()or 0
for i,v in ipairs(self.config.aim)do
if serverOpenDay>=v[1]and zmLevel>=v[2]and(v[3]==0 or systemModel.isOpen(v[3]))then
len=len+1
end
end
local aimIndex=len==1 and 1 or data.aimIndex
self.tabRewardBtn:setActive(len>1)
if aimIndex and aimIndex>0 then
self.rewardList:setActive(true)
local rewards=self.config.aim[aimIndex][4]
self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewards[index]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
else
self.rewardList:setActive(false)
end
else
self.tabRewardBtn:setActive(false)
self.rewardList:setActive(true)
local rewards=self.config.aim
self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewards[index]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
end

self:refreshFinalPanelData()
else
self.rewardList:setActive(true)
self.tabRewardBtn:setActive(false)
local cfg=self.config.rewards[self.select]
local rewards=cfg[2]
self.rewardList:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewards[index]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)
local show=self.config.show[self.select]
self.nameTx:setText(show[2])
self.percentBg:setActive(show[3]~=nil)
if show[3]then
self.percentTx:setText(FMT.fmt("{0}倍",show[3]))
end
local recharge=cfg[3]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,recharge)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
self.rewardBtnTx:setText(str)
self.rewardReddot:setActive(false)

self.nameImageTx:setText(mathHelper.numberToChinese(cfg[1]))

self:refreshDayPanelData()
end

self:refreshSelectItem(self.select)
end

function UISubAct_LianGouHaoLiWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_LianGouHaoLiWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_LianGouHaoLiWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.actId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("{0}后结束",timeHelper.format_time_stamp3(time)))
end

function UISubAct_LianGouHaoLiWin:startDayTick(day_time)
self.day_time=day_time
self:updateDayTick()
if not self.dayTick then
self.dayTick=self:setTimer(1,0,function()
self:updateDayTick()
end)
end
end

function UISubAct_LianGouHaoLiWin:stopDayTick()
self.lockTx:setText("")
if self.dayTick then
self:stopTimerByID(self.dayTick)
self.dayTick=nil
end
end

function UISubAct_LianGouHaoLiWin:updateDayTick()
local time=self.day_time-timeHelper.getServerLongTime()
if time>=0 then
self.lockTx:setText(FMT.fmt("{0}后解锁",timeHelper.format_time_stamp3(time)))
else
self:stopDayTick()
self:refreshSelectPanel()
end
end

function UISubAct_LianGouHaoLiWin:refreshDailyReward()
local data=self.info:getData()
local now=timeHelper.getServerShortTime()
local reddot=false
if data then
reddot=now>data.dailySec and not timeHelper.checkInSameDay2(data.dailySec,now)
end
self.dayReddot:setActive(reddot)
end

function UISubAct_LianGouHaoLiWin:refreshDayBuy()
local data=self.info:getData()
for i=1,#self.config.rewards do
local dayCmp=self.day[i]
local item=dayCmp:getWidgetBase()
item:SetChildActive(_dayNormalCmp.gou,mathHelper.getBitValue(data.flag,i))
end
end

function UISubAct_LianGouHaoLiWin:refreshDayLock()
self.openDay=self.info:getStartDay()
for i,v in ipairs(self.config.rewards)do
local dayCmp=self.day[i]
local rewardCfg=v
local item=dayCmp:getWidgetBase()
item:SetChildActive(_dayNormalCmp.lock,self.openDay<rewardCfg[1])
if self.openDay>=rewardCfg[1]and self.select~=i then
local widget=dayCmp:getWidgetBase()
widget:SetChildModelAnimationState(_dayNormalCmp.model,eAnimationID.juanzhou_idle2)
end
end
end

function UISubAct_LianGouHaoLiWin.onNewDay(isLogin)
_this:refreshDailyReward()
_this:refreshSelectPanelData()
_this:refreshDayLock()
end

function UISubAct_LianGouHaoLiWin:refreshFinalReddot()
local data=self.info:getData()
local flag=data and data.flag or 0
local widget=self.day_0:getWidgetBase()
local check=mathHelper.getBitValue(flag,0)
widget:SetChildActive(_dayFinalCmp.gou,check)
if not check then
local rewards=self.config.rewards
local cnt=mathHelper.cntbit(flag,1,#rewards)
if cnt>=#rewards then
widget:SetChildActive(_dayFinalCmp.reddot,true)
return
end
end
widget:SetChildActive(_dayFinalCmp.reddot,false)
end