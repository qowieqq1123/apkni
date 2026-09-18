







def_class("UISubAct_LianGouHaoLiNewWin",UIWindowBase)









function UISubAct_LianGouHaoLiNewWin:bindComponents()

self.bigRewardBtn=UIButton.get(self,0)
self.bigRewarditem_1=UIObject.get(self,1)
self.bigRewarditem_2=UIObject.get(self,2)
self.bigRewarditem_3=UIObject.get(self,3)
self.bigRewarditem_4=UIObject.get(self,4)
self.bigRewardPanel=UIObject.get(self,5)
self.dayRewardBtn=UIButton.get(self,6)
self.mbg=UIObject.get(self,7)
self.progressTx=UIText.get(self,8)
self.rewardGridList=UIObject.get(self,9)
self.rewardReddot=UIObject.get(self,10)
self.root=UIObject.get(self,11)
self.selectBigRewardBtn=UIButton.get(self,12)
self.tabBigRewardBtn=UIButton.get(self,13)
self.timeBg=UIImage.get(self,14)
self.timeTx=UIText.get(self,15)

self.bigRewardBtn:setButtonClick(function()self:onBigRewardBtn()end)

self.dayRewardBtn:setButtonClick(function()self:onDayRewardBtn()end)

self.selectBigRewardBtn:setButtonClick(function()self:onSelectBigRewardBtn()end)

self.tabBigRewardBtn:setButtonClick(function()self:onTabBigRewardBtn()end)
self.bigRewarditem={
self.bigRewarditem_1,
self.bigRewarditem_2,
self.bigRewarditem_3,
self.bigRewarditem_4,
}



end


function UISubAct_LianGouHaoLiNewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bigRewardBtn);self.bigRewardBtn=nil;
_UIObject_release(self.bigRewarditem_1);self.bigRewarditem_1=nil;
_UIObject_release(self.bigRewarditem_2);self.bigRewarditem_2=nil;
_UIObject_release(self.bigRewarditem_3);self.bigRewarditem_3=nil;
_UIObject_release(self.bigRewarditem_4);self.bigRewarditem_4=nil;
_UIObject_release(self.bigRewardPanel);self.bigRewardPanel=nil;
_UIObject_release(self.dayRewardBtn);self.dayRewardBtn=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.progressTx);self.progressTx=nil;
_UIObject_release(self.rewardGridList);self.rewardGridList=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectBigRewardBtn);self.selectBigRewardBtn=nil;
_UIObject_release(self.tabBigRewardBtn);self.tabBigRewardBtn=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
self.bigRewarditem=nil;
end
















local _this=nil
local _itemCmp={
rewardList=0,
day=1,
lock=2,
ywc=3,
buyBtn=4,
buyTxt=5,
tips=6,
beiTxt=7,
}

local _ab="ui/windows/activities/sub_liangouhaoli/liangouhaoli_new_atlas_pak.ab"




function UISubAct_LianGouHaoLiNewWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.onNewDay,self.onNewDay)
end


function UISubAct_LianGouHaoLiNewWin:__delete()
self:stopCDTick()
self:stopDayTick()

self:unbindComponents()

notifySystem:removelistener(notifyConfig.onNewDay,self.onNewDay)

_this=nil
end




function UISubAct_LianGouHaoLiNewWin:onShow(argtable,afterOnloaded)
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
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6352,1,nil,eAnimationID.stand,false,false,0,function()
if not _this then return end
return _this.root:setChildCanvasGroupDOFade(1,0.5)
end)
end
end


function UISubAct_LianGouHaoLiNewWin:onHide()

end

function UISubAct_LianGouHaoLiNewWin:initView()


self:initNormalDay()

self:initFinalDay()

self:startCDTick()

self:refreshDailyReward()
end

function UISubAct_LianGouHaoLiNewWin:initNormalDay()
local data=self.info:getData()
if data then
local now_time=timeHelper.getServerLongTime()
local start_time=timeHelper.getServerZeroStamp(self.info.start_time_l)
local day=math.ceil((now_time-start_time)/86400)

local len=#self.config.rewards
self.rewardGridList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.rewardGridList:getChildLayoutGroupGridItem(index-1)

local show=self.config.show[index]
local tDay=self.config.rewards[index][1]
local rewards=self.config.rewards[index][2]
local recharge=self.config.rewards[index][3]
item:SetChildLayoutGroupCreateItems(_itemCmp.rewardList,#rewards,function(idx)
local rewardItem=item:GetChildLayoutGroupGridItem(_itemCmp.rewardList,idx-1)
local rewardData=rewards[idx]
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)

local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,recharge)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local buyed=mathHelper.getBitValue(data.flag,index)
item:SetChildActive(_itemCmp.buyBtn,day>=tDay and not buyed)
item:SetChildText(_itemCmp.buyTxt,str)
item:SetChildButtonClick(_itemCmp.buyBtn,function()
if not buyed then
local handleName=activitiesController:getHandleName(self.subType)
call_activitiesHandle_func(handleName,'reqBuyReward',self.actId,self.subId,recharge,index)
end
end)

item:SetChildText(_itemCmp.day,show[2])

item:SetChildActive(_itemCmp.tips,day>=tDay and not buyed and show[3]~=nil)
if show[3]then
item:SetChildText(_itemCmp.beiTxt,FMT.fmt("{0}%",show[3]*100))
end

item:SetChildActive(_itemCmp.ywc,buyed)
end)
self:refreshDayPanelData()
end
end

function UISubAct_LianGouHaoLiNewWin:initFinalDay()
self:refreshFinalPanelData()

self:refreshFinalReddot()
end

function UISubAct_LianGouHaoLiNewWin:refreshView(actId,subType,subId)
if actId==self.actId and subType==subType and subId==self.subId then
self:refreshViewImp()
end
end

function UISubAct_LianGouHaoLiNewWin:refreshViewImp()
self:refreshSelectPanelData()
self:refreshDayBuy()
self:refreshFinalReddot()
self:refreshDailyReward()
end

function UISubAct_LianGouHaoLiNewWin:refreshSelectPanelData()
local data=self.info:getData()
if data then
self:refreshFinalPanelData()
self:refreshDayPanelData()
end
end

function UISubAct_LianGouHaoLiNewWin:refreshFinalPanelData()

local data=self.info:getData()
local count=#self.config.rewards
local pass=mathHelper.cntbit(data.flag,1,count)
local buyed=mathHelper.getBitValue(data.flag,0)
local len=0
local serverOpenDay=timeHelper.getServerOpenDay()
local zmLevel=zongmenModel:getLevel()or 0
for i,v in ipairs(self.config.aim)do
if serverOpenDay>=v[1]and zmLevel>=v[2]and(v[3]==0 or systemModel.isOpen(v[3]))then
len=len+1
end
end
local aimIndex=len==1 and 1 or data.aimIndex
self.bigRewardBtn:setActive(not buyed and aimIndex>0)
self.bigRewardPanel:setActive(aimIndex>0)
self.selectBigRewardBtn:setActive(aimIndex==0)
self.tabBigRewardBtn:setActive(len>1 and not buyed)

if aimIndex and aimIndex>0 then
local rewards=self.config.aim[aimIndex][4]
for i=1,4 do
local rewardData=rewards[i]
self.bigRewarditem[i]:setActive(rewardData~=nil)
local widget=self.bigRewarditem[i]:getChildWidgetBase()
if rewardData then
local showCountBG=rewardData[2]>1
local countStr=showCountBG and rewardData[2]or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end
end
end

self.progressTx:setText(FMT.fmt("进度：{0}/{1}",pass,count))
if pass<count then
self.bigRewardBtn:setActive(true)
self.bigRewardBtn:setCSImageSprite(_ab,"button_lghl_4")
self.rewardReddot:setActive(false)
else
local getted=mathHelper.getBitValue(data.flag,0)

if not getted then
self.progressTx:setText("")
self.bigRewardBtn:setActive(true)
self.bigRewardBtn:setCSImageSprite(_ab,aimIndex==0 and"button_lghl_4"or"button_lghl_2")
self.rewardReddot:setActive(aimIndex and aimIndex>1)
else

self.progressTx:setText("")
self.bigRewardBtn:setActive(false)
self.rewardReddot:setActive(false)
end
end
end

function UISubAct_LianGouHaoLiNewWin:refreshDayPanelData()
local data=self.info:getData()
local len=#self.config.rewards
local cfg=self.config.rewards[len]
local maxTDay=cfg[1]
local now_time=timeHelper.getServerLongTime()
local start_time=timeHelper.getServerZeroStamp(self.info.start_time_l)
local day=math.ceil((now_time-start_time)/86400)

self.endTimeLookup={}

if day<maxTDay then
for i=1,len do
local tDay=self.config.rewards[i][1]
if day<tDay then
if not self.endTimeLookup[i]then
self.endTimeLookup[i]=start_time+(tDay-1)*86400
end
end
end
self:startDayTick(start_time+(maxTDay-1)*86400)
else
self:stopDayTick()

for i=1,len do
local item=self.rewardGridList:getChildLayoutGroupGridItem(i-1)

local show=self.config.show[i]
local tDay=self.config.rewards[i][1]
local buyed=mathHelper.getBitValue(data.flag,i)
item:SetChildActive(_itemCmp.buyBtn,day>=tDay and not buyed)

item:SetChildActive(_itemCmp.tips,day>=tDay and not buyed and show[3]~=nil)

item:SetChildActive(_itemCmp.ywc,buyed)
end
end
end

function UISubAct_LianGouHaoLiNewWin:refreshDailyReward()
local data=self.info:getData()
local now=timeHelper.getServerShortTime()
local reddot=false
if data then
reddot=now>data.dailySec and not timeHelper.checkInSameDay2(data.dailySec,now)
end
self.dayRewardBtn:setActive(reddot)
end

function UISubAct_LianGouHaoLiNewWin:refreshDayBuy()
local data=self.info:getData()
for i=1,#self.config.rewards do
local buyed=mathHelper.getBitValue(data.flag,i)
local item=self.rewardGridList:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(_itemCmp.ywc,buyed)
if buyed then
item:SetChildActive(_itemCmp.buyBtn,false)
item:SetChildActive(_itemCmp.tips,false)
end
end
end

function UISubAct_LianGouHaoLiNewWin.onNewDay(isLogin)
_this:refreshDailyReward()
_this:refreshSelectPanelData()
end

function UISubAct_LianGouHaoLiNewWin:refreshFinalReddot()
















end


function UISubAct_LianGouHaoLiNewWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_LianGouHaoLiNewWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_LianGouHaoLiNewWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.actId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("{0}后结束",timeHelper.format_time_stamp3(time)))
end

function UISubAct_LianGouHaoLiNewWin:startDayTick(day_time)
self.day_time=day_time
self:updateDayTick()
if not self.dayTick then
self.dayTick=self:setTimer(1,0,function()
self:updateDayTick()
end)
end
end

function UISubAct_LianGouHaoLiNewWin:stopDayTick()
if self.dayTick then
self:stopTimerByID(self.dayTick)
self.dayTick=nil
end
end

function UISubAct_LianGouHaoLiNewWin:updateDayTick()
local now_time=timeHelper.getServerLongTime()
local time=self.day_time-now_time
if time>=0 then
local len=#self.config.rewards
for i=1,len do
if self.endTimeLookup and self.endTimeLookup[i]then
local item=self.rewardGridList:getChildLayoutGroupGridItem(i-1)
local lerf=self.endTimeLookup[i]-now_time
if lerf>=0 then
item:SetChildActive(_itemCmp.lock,true)
item:SetChildText(_itemCmp.lock,FMT.fmt("{0}后解锁",timeHelper.format_time_stamp3(lerf)))
else
self.endTimeLookup[i]=nil
item:SetChildActive(_itemCmp.lock,false)
end
end
end
else
self:stopDayTick()
self:refreshSelectPanelData()
end
end




function UISubAct_LianGouHaoLiNewWin:onBigRewardBtn()
local data=self.info:getData()
if data then

local len=0
local serverOpenDay=timeHelper.getServerOpenDay()
local zmLevel=zongmenModel:getLevel()or 0
for i,v in ipairs(self.config.aim)do
if serverOpenDay>=v[1]and zmLevel>=v[2]and(v[3]==0 or systemModel.isOpen(v[3]))then
len=len+1
end
end
local aimIndex=len==1 and 1 or data.aimIndex
if aimIndex==0 then
UIManager.info("请先选择大奖")
return
end

local count=#self.config.rewards
local pass=mathHelper.cntbit(data.flag,1,count)
local getted=mathHelper.getBitValue(data.flag,0)
if pass>=count and not getted then
local handleName=activitiesController:getHandleName(self.subType)
call_activitiesHandle_func(handleName,'reqFinalReward',self.actId,self.subId)
else
UIManager.info("购买全部线索礼包后可领取")
end
end
end



function UISubAct_LianGouHaoLiNewWin:onDayRewardBtn()
if self.info:checkReddot()then
local handleName=activitiesController:getHandleName(self.subType)
call_activitiesHandle_func(handleName,'reqDailyReward',self.actId,self.subId)
end
end



function UISubAct_LianGouHaoLiNewWin:onSelectBigRewardBtn()
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



function UISubAct_LianGouHaoLiNewWin:onTabBigRewardBtn()
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

