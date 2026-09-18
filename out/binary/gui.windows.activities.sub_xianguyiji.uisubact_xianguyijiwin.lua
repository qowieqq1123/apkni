







def_class("UISubAct_xianguyijiWin",UIWindowBase)









function UISubAct_xianguyijiWin:bindComponents()

self.effectLottery=UIObject.get(self,0)
self.rewardList=UIObject.get(self,1)
self.moneyIcon=UIImage.get(self,2)
self.moneyNum=UIText.get(self,3)
self.onceBtnReddot=UIObject.get(self,4)
self.freeOnce=UIText.get(self,5)
self.onceBtnTx=UIText.get(self,6)
self.onceCost=UIObject.get(self,7)
self.manyBtnReddot=UIObject.get(self,8)
self.manyBtnTx=UIText.get(self,9)
self.luckReddot=UIObject.get(self,10)
self.tansuoBottle=UIObject.get(self,11)
self.tansuoProgress=UIProgress.get(self,12)
self.tansuoBottleTx=UIText.get(self,13)
self.onceIcon=UIImage.get(self,14)
self.onceNum=UIText.get(self,15)
self.tansuoEffect=UIObject.get(self,16)
self.manyIcon=UIImage.get(self,17)
self.manyNum=UIText.get(self,18)
self.rewardContent=UIObject.get(self,19)
self.effectRoot=UIObject.get(self,20)
self.dzModel=UIObject.get(self,21)
self.rewardView=UIObject.get(self,22)
self.rewardBtn=UIButton.get(self,23)
self.nextTx=UIText.get(self,24)
self.jumpAnimation=UIToggleButton.get(self,25)
self.timeBg=UIObject.get(self,26)
self.manyBtn=UIButton.get(self,27)
self.onceBtn=UIButton.get(self,28)
self.tansuoBtn=UIButton.get(self,29)
self.luckBtn=UIButton.get(self,30)
self.moneyBg=UIButton.get(self,31)
self.timeTx=UIText.get(self,32)
self.background=UIObject.get(self,33)
self.isShowReddotBtn=UIButton.get(self,34)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.manyBtn:setButtonClick(function()self:onManyBtn()end)

self.onceBtn:setButtonClick(function()self:onOnceBtn()end)

self.tansuoBtn:setButtonClick(function()self:onTansuoBtn()end)

self.luckBtn:setButtonClick(function()self:onLuckBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)



end


function UISubAct_xianguyijiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effectLottery);self.effectLottery=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.onceBtnReddot);self.onceBtnReddot=nil;
_UIObject_release(self.freeOnce);self.freeOnce=nil;
_UIObject_release(self.onceBtnTx);self.onceBtnTx=nil;
_UIObject_release(self.onceCost);self.onceCost=nil;
_UIObject_release(self.manyBtnReddot);self.manyBtnReddot=nil;
_UIObject_release(self.manyBtnTx);self.manyBtnTx=nil;
_UIObject_release(self.luckReddot);self.luckReddot=nil;
_UIObject_release(self.tansuoBottle);self.tansuoBottle=nil;
_UIObject_release(self.tansuoProgress);self.tansuoProgress=nil;
_UIObject_release(self.tansuoBottleTx);self.tansuoBottleTx=nil;
_UIObject_release(self.onceIcon);self.onceIcon=nil;
_UIObject_release(self.onceNum);self.onceNum=nil;
_UIObject_release(self.tansuoEffect);self.tansuoEffect=nil;
_UIObject_release(self.manyIcon);self.manyIcon=nil;
_UIObject_release(self.manyNum);self.manyNum=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.nextTx);self.nextTx=nil;
_UIObject_release(self.jumpAnimation);self.jumpAnimation=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.manyBtn);self.manyBtn=nil;
_UIObject_release(self.onceBtn);self.onceBtn=nil;
_UIObject_release(self.tansuoBtn);self.tansuoBtn=nil;
_UIObject_release(self.luckBtn);self.luckBtn=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
end


















local _this=nil
local _order={
eZongMenPostType.eZhangMen,
eZongMenPostType.eChuanGong,
eZongMenPostType.eJieYin,
eZongMenPostType.eJielu,
eZongMenPostType.eZhenYu,
eZongMenPostType.eNeiMen,
eZongMenPostType.eWaiMen,
}
local _effectColor={
[eQualityColor.eWhite]=10188,
[eQualityColor.eGreen]=10188,
[eQualityColor.eBlue]=10188,
[eQualityColor.ePurple]=10189,
[eQualityColor.eOrange]=10189,
[eQualityColor.eRed]=10189,
[eQualityColor.ePink]=10189,
}
local _speEffectColor=10190
local _supEffectColor=10197
local _rollSpeed=10
local _rerollInterval=10
local _RollList=simple_class(LuaRollListVertical)


function UISubAct_xianguyijiWin:onLoaded(...)
self:bindComponents()
_this=self
self.jumpAnimation:setToggleChange(function(...)self:onJumpAnimation(...)end)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_change)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
self.rollList=_RollList(self.winlua,self.rewardList)
self.value=1
end


function UISubAct_xianguyijiWin:__delete()
self:unbindComponents()
_this=nil
self:stopCDTick()
self:stopFreeTick()
self:stopRerollTick()
self:stopResetRollTick()
self.rollList:deleteSelf()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_change)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
uiAIManager:removeUIInstance(self.bt)
end




function UISubAct_xianguyijiWin:onShow(argtable,afterOnloaded)
local oSubId=self.subId
if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
if oSubId~=self.subId then
self:refreshRewardList()
self:refreshButton()
end

self:initDzModel()


self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end

if not self.activityData.data then

else
self:refreshFree()
self:refreshNext()
self:refreshExplore()
self:refreshLuckReddot()
self:refreshManyReddot()
end
self:startCDTick()
self:refreshJumpAnimation()
self:initActPanel()
self:refreshIsShowReddotBtn()
end


function UISubAct_xianguyijiWin:onHide()

end

function UISubAct_xianguyijiWin:initActPanel()
local abName='ui/windows/activities/sub_xianguyiji/xianguyiji_base_atlas_pak.ab'

local backgroundModelId=self.config.backgroundModelId or 4034
self.background:setChildUIModelShowTarget(backgroundModelId,1,{},eAnimationID.stand)

local tansuoBtnIcon=self.config.tansuoBtnIcon.icon or"image_xianguyijiui_3"
self.tansuoBtn:setSprite(abName,tansuoBtnIcon)
if self.config.tansuoBtnIcon.x then
self.tansuoBtn:setLocalPosX(self.config.tansuoBtnIcon.x)
end
if self.config.tansuoBtnIcon.y then
self.tansuoBtn:setLocalPosY(self.config.tansuoBtnIcon.y)
end

local previewBtnIcon=self.config.previewBtnIcon.icon or"button_xgjiangli"
self.rewardBtn:setSprite(abName,previewBtnIcon)
if self.config.previewBtnIcon.x then
self.rewardBtn:setLocalPosX(self.config.previewBtnIcon.x)
end
if self.config.previewBtnIcon.y then
self.rewardBtn:setLocalPosY(self.config.previewBtnIcon.y)
end

local isShowRp=self.config.reward1~=nil and self.config.reward2~=nil
self.luckBtn:setActive(isShowRp)
if isShowRp then
local rpBtnIcon=self.config.rpBtnIcon.icon or"button_xgrenpinbang"
self.luckBtn:setSprite(abName,rpBtnIcon)
if self.config.rpBtnIcon.x then
self.luckBtn:setLocalPosX(self.config.rpBtnIcon.x)
end
if self.config.rpBtnIcon.y then
self.luckBtn:setLocalPosY(self.config.rpBtnIcon.y)
end
end
end




function UISubAct_xianguyijiWin:onLuckBtn()
local jstr=jsonHelper.encode({4})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.activityId,self.subType,self.subId,jstr)

local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
activityData=self.activityData,
config=self.config,
}
self:showWindow("UISubAct_xianguyijiWin_RenPin",args)
end


function UISubAct_xianguyijiWin:onRewardBtn()
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
}
oneTabScreenController:openUI(SEC_FULL_TYPE.lotterySecondary,args)
end


function UISubAct_xianguyijiWin:onOnceBtn()
self.activityData:lottery(self.once)
end


function UISubAct_xianguyijiWin:onManyBtn()
self.activityData:lottery(self.many)
end

function UISubAct_xianguyijiWin:onMoneyBg()
local itemId=self.config.times[1][2]
gainControl:showCommonGainWin_item(itemId)
end


function UISubAct_xianguyijiWin:onTansuoBtn()
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
activityData=self.activityData,
config=self.config,
}
UIManager:showWindow("UISubAct_xianguyijiWin_TanSuoReward",args)
end

function UISubAct_xianguyijiWin:onJumpAnimation(name,jump,data)
self.activityData:setJumpAnimation(jump)
end

function UISubAct_xianguyijiWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_xianguyijiWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_xianguyijiWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end

function UISubAct_xianguyijiWin:refreshFree()
local check=self.activityData:checkFree()
self.freeOnce:setActive(check)
self.onceBtnReddot:setActive(check)
self.onceCost:setActive(not check)
if check then
self:stopFreeTick()
else
self:startFreeTick()
end
end

function UISubAct_xianguyijiWin:refreshNext()
local data=self.activityData.data
local textStr=self.config.textStr or"探寻"
self.nextTx:setText(FMT.fmt("再{0}{1}次必出仙古宝藏",textStr,data.great))
end

function UISubAct_xianguyijiWin:refreshRewardList()
self:stopRerollTick()
self:stopResetRollTick()
self.rollList:stopRoll()
self.rollList:createList(#self.config.reward_list,82,8)
self.rollList:startRoll(_rollSpeed,ScrollerOrder.order)














end

function UISubAct_xianguyijiWin:refreshExplore()
local data=self.activityData.data
local cur=data.star
local value=math.min(cur,data.fullValue)/data.fullValue

if value<=self.value then
local rewardMoneyName=self.config.rewardMoneyName or"探寻值"
local str=FMT.fmt("{0}\n{1}",rewardMoneyName,data.star)
self.winlua:SetChildWidgetMaterialFloat(self.tansuoBottle:getID(),"_GrowUp",value)
self.tansuoBottle:setActive(value>0)
self.tansuoBottleTx:setText(str)
self.tansuoEffect:setActive(data.star>=data.fullReddot)
self.value=value
self.explore=cur
else
self.tansuoBottle:setActive(true)
local deltaValue=(value-self.value)/50
local currValue=self.value
local deltaExplore=(cur-self.explore)/50
local currExplore=self.explore
if self.bottleTimer then
self:stopTimerByID(self.bottleTimer)
self.bottleTimer=nil
end
local count=0
self.bottleTimer=self:setTimer(0.02,50,function()
count=count+1
currValue=currValue+deltaValue
currExplore=currExplore+deltaExplore
if count>=50 then
self.tansuoEffect:setActive(data.star>=data.fullReddot)
currValue=value
currExplore=cur
end

self.value=currValue
self.winlua:SetChildWidgetMaterialFloat(self.tansuoBottle:getID(),"_GrowUp",currValue)
local rewardMoneyName=self.config.rewardMoneyName or"探寻值"
local str=FMT.fmt("{0}\n{1}",rewardMoneyName,math.floor(currExplore))
self.tansuoBottleTx:setText(str)
self.explore=currExplore
end)
end
end

function UISubAct_xianguyijiWin:refreshButton()
local list={}
for i,v in pairs(self.config.times)do
table.insert(list,i)
end
table.sort(list)

local textStr=self.config.textStr or"探寻"
self.once=list[1]
local cfg=self.config.times[self.once]
self.money=cfg[2]
if pfwindowslController:checkIsGameVersion_oumei()then
self.onceBtnTx:setText(FMT.fmt("{0} X{1}",textStr,self.once))
else
self.onceBtnTx:setText(FMT.fmt("{0}{1}次",textStr,self.once))
end
self.onceIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.onceNum:setText(cfg[3])

self.many=list[2]
if pfwindowslController:checkIsGameVersion_oumei()then
self.manyBtnTx:setText(FMT.fmt("{0} X{1}",textStr,self.many))
else
self.manyBtnTx:setText(FMT.fmt("{0}{1}次",textStr,self.many))
end
cfg=self.config.times[self.many]
self.manyIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.manyCostNeed=cfg[3]

self.moneyIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self:refreshMoney()
end

function UISubAct_xianguyijiWin:refreshJumpAnimation()

local toggle=self.activityData:getJumpAnimation()
self.jumpAnimation:setToggle(toggle)
end

function UISubAct_xianguyijiWin:refreshView(activityId,subType,subId,rewards,show)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshFree()
self:refreshNext()
self:refreshExplore()
self:refreshLuckReddot()

local textStr=self.config.textStr or"探寻"
if rewards then
if self.activityData:getJumpAnimation()and show then
self.activityData:showPrize(rewards,show,textStr)
else
local maxColor=eQualityColor.eWhite
local spe=false
for i,v in ipairs(rewards)do
if self.config.reset_items[v.itemid]then
spe=true
break
else
local cfg=itemsConfig.getConfig(v.itemid)
maxColor=math.max(maxColor,cfg.color)
end
end
local effectId=_effectColor[maxColor]
local stateId=1
local audioId=598
if spe then
effectId=_speEffectColor
audioId=599
elseif show==false then
effectId=self.config.speEffect
audioId=600
if self.dzGuid then
local modelParam=UIDiscipleModel:getDiscipleOutsideModelInfo(self.dzGuid,false)
local canFace=spineHelper.enableChangeFace(modelParam.body)or false
stateId=not canFace and 3 or 2
elseif self.dzBody then
local canFace=spineHelper.enableChangeFace(self.dzBody)
stateId=not canFace and 3 or 2
end
end
local effectDelay=cfgHelper.get2(cfg_effectconfig_get,effectId,"lifetime")or 1000
effectDelay=effectDelay/1000

self.effectRoot:setActive(true)
self.effectLottery:setChildShowEffect(effectId,true)

AudioManager.playAudio(audioId)

if self.bt then
self.bt:setSharedVar("stateId",stateId)
self.bt:broke()
self.bt:reset()
end


self:delayDo(effectDelay,function()
self.activityData:showPrize(rewards,show,textStr)
self.effectRoot:setActive(false)


end)
end
end
end
end

function UISubAct_xianguyijiWin:refreshView_OnlyExplore(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshExplore()
end
end

function UISubAct_xianguyijiWin:startFreeTick()
if not self.freeTimer then
self.freeTimer=self:setTimer(1,0,function()

if self.activityData:checkFree()then
self.freeOnce:setActive(true)
self.onceBtnReddot:setActive(true)
self:stopFreeTick()
end
end)
end
end

function UISubAct_xianguyijiWin:stopFreeTick()
if self.freeTimer then
self:stopTimerByID(self.freeTimer)
self.freeTimer=nil
end
end

function UISubAct_xianguyijiWin.on_item_change(changeType,itemguid,itemid,lastcount,itemcount)
if _this.money==itemid then
_this:refreshMoney()
_this:refreshManyReddot()
end
end

function UISubAct_xianguyijiWin.on_money_changed(mType,oldValue,newValue)
if _this.money==mType then
_this:refreshMoney()
_this:refreshManyReddot()
end
end

function UISubAct_xianguyijiWin:refreshMoney()
local num=itemsModel.getCount(self.money)
self.moneyNum:setText(num)
end

function UISubAct_xianguyijiWin:refreshManyReddot()
local num=itemsModel.getCount(self.money)
local manyNumStr=tostring(self.manyCostNeed)
if num<self.manyCostNeed then
manyNumStr=FMT.cfmt(FONT_COLOR.eRedColor,manyNumStr)
end
self.manyNum:setText(manyNumStr)

self.manyBtnReddot:setActive(self.activityData:lotteryEnough(self.many))
end

function UISubAct_xianguyijiWin:refreshLuckReddot()
if not self.config.dz_all_times then
self.luckReddot:setActive(false)
return
end
local rank=self.activityData:getCommentData()
local reddotGood=self.activityData.data.good<self.config.dz_all_times
local reddotBad=self.activityData.data.bad<self.config.dz_all_times
if rank==nil then
self.luckReddot:setActive(reddotGood or reddotBad)
else
self.luckReddot:setActive((reddotGood and rank[1]~=nil)or(reddotBad and rank[2]~=nil))
end
end

function UISubAct_xianguyijiWin:checkLuckReddot(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshLuckReddot()
end
end

function UISubAct_xianguyijiWin:initDzModel()
uiAIManager:removeUIInstance(self.bt)
self.bt=nil

local vpos=Vector2.New(0,-210)
local initData={
leftPos={0,-210},
rightPos={270,-210},
standPos=1,
winName="UISubAct_xianguyijiWin",
stateId=0,
speak="",
speak2="",
}
local tran=self.dzModel:getCommonComponent('Transform')
local func=function(bt)
self.bt=bt
end

if self.config.character then
local bodyId=self.config.character[1]
local components=self.config.character[2]
local scale=self.config.character[3]
local otherData={
componets=components,
scale=scale,
}
uiAIManager:createUIObject("UISubAct_xianguyijiWin","bt_ui_xgyj",INSTANCE_TYPE.eUIDisciple,bodyId,tran,vpos,initData,otherData,func)
self.dzGuid=nil
self.dzBody=bodyId
return
end

local dzId=nil
local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
local temp={}
for i,v in pairs(all)do
local netData=v.netData.net
if temp[netData.pos]==nil then
if not UIDiscipleModel:checkDiscipleState2(netData.discipleguid,DISCIPLE_STATE_TYPE.eChuiWei)then
temp[netData.pos]=netData
end
end
end
for i,v in ipairs(_order)do
if temp[v]then
dzId=temp[v].discipleguid
break
end
end
if temp[0]and dzId==nil then
dzId=temp[0].discipleguid
end
end
if dzId==nil then
return
end

self.dzGuid=dzId
self.dzBody=nil
uiAIManager:createUIDisciple('UISubAct_xianguyijiWin','bt_ui_xgyj',dzId,tran,vpos,initData,nil,func)
end

function UISubAct_xianguyijiWin:setSpeakContent()
local content=nil
if self.config.speak and#self.config.speak>0 then
local r=math.random(1,#self.config.speak)
content=self.config.speak[r]
end
self.bt:setSharedVar("speak",content)
end

function UISubAct_xianguyijiWin:setSpeakContent2()
local content=nil
if self.config.speak2 and#self.config.speak2>0 then
local r=math.random(1,#self.config.speak2)
content=self.config.speak2[r]
end
self.bt:setSharedVar("speak2",content)
end

function UISubAct_xianguyijiWin:setSpeakContent3()
local content=nil
if self.config.speak3 and#self.config.speak3>0 then
local r=math.random(1,#self.config.speak3)
content=self.config.speak3[r]
end
self.bt:setSharedVar("speak3",content)
end

function UISubAct_xianguyijiWin:startRerollTick()
if not self.rerollTick and self.delayReroll>0 then
self.rerollTick=self:setTimer(1,0,function()
self.delayReroll=self.delayReroll-1

if self.delayReroll<=0 then
self.rollList:startRoll(_rollSpeed,ScrollerOrder.order)
self:stopRerollTick()
end
end)
end
end

function UISubAct_xianguyijiWin:stopRerollTick()
if self.rerollTick then
self:stopTimerByID(self.rerollTick)
self.rerollTick=nil
end
end

function UISubAct_xianguyijiWin:startResetRollTick()
if not self.resetRollTick then
self.resetRollTick=self:setTimer(_rerollInterval,1,function()
self.rollList:resumeRoll()
self:stopResetRollTick()
end)
end
end

function UISubAct_xianguyijiWin:stopResetRollTick()
if self.resetRollTick then
self:stopTimerByID(self.resetRollTick)
self.resetRollTick=nil
end
end

function _RollList:onRefershItem(item,dataIndex)

local data=_this.config.reward_list[dataIndex]
local rewardId=data[1]
local rewardNum=data[2]
local rewardFlag=data[3]==1
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)self:onClickItem(...)end)
item:SetChildPropData(0,prop)
item:SetChildActive(2,rewardFlag)
end

function _RollList:onClickItem(itemid,index,itemguid,attach)
if itemid==nil or itemid==-1 then return end
local callback=function()
_this:startResetRollTick()
end
tipsManager.showTips({itemid=itemid,itemguid=itemguid,attach=attach,closeCallback=callback})
self:pauseRoll()
end

function _RollList:beginDrag(pos)
LuaRollListVertical.beginDrag(self,pos)
_this.delayReroll=_rerollInterval
end

function _RollList:endDrag(pos)
LuaRollListVertical.endDrag(self,pos)
_this:startRerollTick()
end





















































































































function UISubAct_xianguyijiWin:refreshIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local isForbiddenShowReddot=actInfo:checkIsForbiddenShowReddot()
self.isShowReddotBtn:setActive(not isForbiddenShowReddot)
if isForbiddenShowReddot then
return
end

local isShowReddot=actInfo:checkIsShowReddot()
local btnWidget=self.isShowReddotBtn:getWidgetBase()
btnWidget:SetChildActive(0,not isShowReddot)
btnWidget:SetChildActive(1,isShowReddot)
end

function UISubAct_xianguyijiWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_xianguyijiWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.activityId==actId and _this.subType==subType and _this.subId==subId then
_this:refreshIsShowReddotBtn()
end
end

