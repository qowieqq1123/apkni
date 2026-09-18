







def_class("UIXYBGShopWin",UIWindowBase)









function UIXYBGShopWin:bindComponents()

self.creater=UIObject.get(self,0)
self.downFlag=UIObject.get(self,1)
self.model=UIObject.get(self,2)
self.modelbefore=UIObject.get(self,3)
self.modelPeople=UIObject.get(self,4)
self.modelPeopleBtn=UIButton.get(self,5)
self.money=UIText.get(self,6)
self.moneyBtn=UIButton.get(self,7)
self.moneyIcon2=UIImage.get(self,8)
self.moneyRoot=UIObject.get(self,9)
self.rewardBtn=UIButton.get(self,10)
self.rewardReddot=UIObject.get(self,11)
self.speakObj=UIObject.get(self,12)
self.speakText=UIText.get(self,13)
self.time=UIText.get(self,14)

self.modelPeopleBtn:setButtonClick(function()self:onModelPeopleBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIXYBGShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.downFlag);self.downFlag=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelbefore);self.modelbefore=nil;
_UIObject_release(self.modelPeople);self.modelPeople=nil;
_UIObject_release(self.modelPeopleBtn);self.modelPeopleBtn=nil;
_UIObject_release(self.money);self.money=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyIcon2);self.moneyIcon2=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.time);self.time=nil;
end


















local this
local _format=string.format
local _floor=math.floor



function UIXYBGShopWin:onLoaded(...)
self:bindComponents()

this=self

self:addNotify(notifyConfig.building_event,function(...)
self:onBuildingEvent(...)
end)

self:addNotify(notifyConfig.on_money_changed,function(...)
self:onMoneyChanged(...)
end)

self.createrT=self.creater:getTransform()

end


function UIXYBGShopWin:__delete()
self:unbindComponents()
end




function UIXYBGShopWin:onShow(argtable,afterOnloaded)
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
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self.sublist=activitiesModel:getActSubList_open_doing(self.activityId)

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end

self.tempStamps=1609430400
self.moneyType=self.config.money
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time
self.limitHeight=30000
self.showdownAllowFlag=false
local checkFun=function()
local curShow=self.createrT.localPosition.y<self.limitHeight
if curShow~=self.showdownAllowFlag then
self.showdownAllowFlag=curShow
self.downFlag:setActive(curShow)
end
end

self.scrollDownAllowCheckTimer=self:setTimer(0.5,0,checkFun)
self:initRandom()
self:refreshBgModel()
self:setRemainingTimeTimer()
self:freshGirds()
self:initMoney()

self.giftId=self.config.giftId or nil
self:refreshRewardBtn()







end


function UIXYBGShopWin:onHide()
self:clearTimer()
self:reductionSpkObj()
if self.scrollDownAllowCheckTimer~=nil then
self:stopTimerByID(self.scrollDownAllowCheckTimer)
end
end


function UIXYBGShopWin:refreshBgModel()
local bgModelId=self.config.bgModelId
local modelId=self.config.modelId
if bgModelId then
local animId=eAnimationID.stand
self.model:setChildUIModelShowTarget(bgModelId[1],1,{},animId,false,false,0)
self.modelbefore:setChildUIModelShowTarget(bgModelId[2],1,{},animId,false,false,0)
self.model:setActive(true)
self.modelbefore:setActive(true)
else
self.model:setActive(false)
self.modelbefore:setActive(false)
self.model:setChildUIModelRemoveTarget()
self.modelbefore:setChildUIModelRemoveTarget()
end

if modelId then
local animId=eAnimationID.stand
self.modelPeople:setChildUIModelShowTarget(modelId[1],modelId[2],{},animId,false,false,0)
self.modelPeople:setActive(true)
else
self.modelPeople:setActive(false)
self.modelPeople:setChildUIModelRemoveTarget()
end
end


function UIXYBGShopWin:setRemainingTimeTimer()
self:clearTimer()

local tipsType={
[0]='活动剩余时间:',
[1]='限购重置倒计时:',
}
local flag=self.config.tipText or 0

local func=function()
local endTime=self.endTime
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=endTime and endTime-nowTime or 0
if flag==1 then lerp=timeHelper.getServerTodayLeft()end
if lerp>0 then

local text=tipsType[flag]
self.time:setText(FMT.fmt("{0}{1}",text,timeHelper.format_time_stamp16(lerp)))
else
self.time:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end


end
func()
self.timer=self:setTimer(1,0,func)
end


function UIXYBGShopWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end

if self.spkTimer then
self:stopTimerByID(self.spkTimer)
self.spkTimer=nil
end
end

function UIXYBGShopWin:initMoney()
local moneyType=self.moneyType
local moneyIconName=iconHelper.getIconName(moneyType)
local value=moneyModel.getMoney(moneyType)or 0
self.moneyIcon2:setChildIcon(moneyIconName,false)
self.money:setText(value)
end

function UIXYBGShopWin:freshMoney()
for pageidx,list in ipairs(self.goodlist or{})do
for index,v in ipairs(list or{})do
local cfg=v
local i=cfg.index
local needCount=cfg[3]
local moneyType=self.moneyType
local enoughMoneyOne=moneyModel.checkEnoughMoney(moneyType,needCount)
local pageWidget=self.creater:getChildLayoutGroupGridItem(pageidx-1)
local item=pageWidget:GetChildLayoutGroupGridItem(3,index-1)
item:SetChildText(6,enoughMoneyOne and needCount or FMT.cfmt(FONT_COLOR.eRedColor,needCount))
end
end
end

function UIXYBGShopWin:getGoodData(idx)
local activityData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)or{}
for i,v in ipairs(activityData.list or{})do
if v.param_1==idx then
return v
end
end
end

function UIXYBGShopWin:freshGirds()
self.creater:setChildLayoutGroupClearAllItems()
local activityCfg=self.config
local good=activityCfg.good
local sortTag={}
local goodlist={}
local qllist={}
qllist.qlTag=true
goodlist[#goodlist+1]=qllist
goodlist[#goodlist+1]={}
for i,v in ipairs(good)do
local cfg=v
local needZMLv=cfg[5]
local waitDays=cfg[6][2]
local passDay=timeHelper.getPassDay(self.beginTime+self.tempStamps)
local enoughLv=zongmenModel:getLevel()>=needZMLv
local enoughHours=passDay>=waitDays
local isUnlock=enoughLv and enoughHours or false
local limitCount=cfg[4]
local islimit=limitCount>0
local goodData=self:getGoodData(i)or{}
local buyCount=goodData.param_2 or 0
local buyOver=islimit and buyCount>=limitCount
local sort=cfg[10]
local qlTag=enoughHours
local qlindex=qlTag and 1 or 2
local subgoodlist=goodlist[qlindex]
if isUnlock then
subgoodlist[#subgoodlist+1]=v
local len=#subgoodlist
local buyOverTag=buyOver and 1 or 0
sortTag[i]=len+sort*100+buyOverTag*100000
subgoodlist[len].index=i
elseif cfg[9]==1 then
if enoughHours then
subgoodlist[#subgoodlist+1]=v
local len=#subgoodlist
sortTag[i]=len+needZMLv*500000
subgoodlist[len].index=i
else
subgoodlist[#subgoodlist+1]=v
local len=#subgoodlist
sortTag[i]=len+waitDays*50000000
subgoodlist[len].index=i
end
end
end
for i=#goodlist,1,-1 do
local info=goodlist[i]
local len=#info
if len==0 then
table.remove(goodlist,i)
elseif len>1 then
table.sort(info,function(a,b)
return sortTag[a.index]<sortTag[b.index]
end)
end
end

self.goodlist=goodlist

local tNum=#goodlist
local func=function(idx)
self:freshPageItem(idx)
end

self.creater:setChildLayoutGroupCreateItems(tNum,func)
end

function UIXYBGShopWin:freshPageItem(pageidx)
local widget=self.creater:getChildLayoutGroupGridItem(pageidx-1)
local pageCfg=self.goodlist[pageidx]
local qlTag=pageCfg.qlTag==true
local len=#pageCfg
local func=function(idx)
self:freshChildItem(pageidx,idx)
end

self.limitHeight=(len/3-2-0.5)*245
widget:SetChildLayoutGroupCreateItems(3,len,func)
widget:SetChildActive(0,qlTag)
widget:SetChildActive(1,not qlTag)
widget:SetChildActive(2,qlTag)
widget:SetChildActive(4,not qlTag)



end

function UIXYBGShopWin:freshChildItem(pageidx,index)
local pageWidget=self.creater:getChildLayoutGroupGridItem(pageidx-1)
local item=pageWidget:GetChildLayoutGroupGridItem(3,index-1)
local pageCfg=self.goodlist[pageidx]
local qlTag=pageCfg.qlTag==true
local cfg=pageCfg[index]
local i=cfg.index
local itemid=cfg[1]
local itemCfg=itemsConfig.getConfig(itemid)
local num=cfg[2]
local moneyType=self.moneyType
local needCount=cfg[3]
local limitCount=cfg[4]
local needZMLv=cfg[5]
local waitDays=cfg[6][2]
local xiyou=cfg[8]
local new=0
local goodData=self:getGoodData(i)or{}
local buyCount=goodData.param_2 or 0
local enoughMoneyOne=moneyModel.checkEnoughMoney(moneyType,needCount)
local passDay=timeHelper.getPassDay(self.beginTime+self.tempStamps)
local needDay
local enoughHours=passDay>=waitDays
if not enoughHours then needDay=self:getNeedTimeUnlock(waitDays-passDay)end
if passDay==waitDays and self:getIsShowNewIcon(itemid)then new=1 end
if new==1 then xiyou=0 end
local enoughLv=zongmenModel:getLevel()>=needZMLv
local isUnlock=enoughLv and enoughHours or false
local itemname=itemsModel.getName(itemid)
local moneyIconName=iconHelper.getIconName(moneyType)
local iconName=iconHelper.getIconName(itemid)
local islimit=limitCount>0
local buyOver=islimit and buyCount>=limitCount
local lockStr=not enoughHours and FMT.fmt('{0}后到货',needDay)or''
local color=itemCfg.color
local colorPage=itemCfg.colorPage or 0
local isShowBg=index%3==1 or false

item:SetBaseItemChildID(-1,i)
item:SetBaseItemClickEvent(-1,function(...)
if self and not self.isClose then
self:onScrollItemClick(...)
end
end)
item:SetChildActive(0,qlTag)
item:SetChildActive(20,not qlTag)
item:SetChildActive(1,isShowBg)
item:SetChildActive(18,not isUnlock or buyOver)
item:SetChildActive(2,isUnlock and not buyOver)
item:SetChildText(3,islimit and FMT.fmt('限购:{0}',limitCount-buyCount)or'不限购')
item:SetChildText(4,itemname)
if enoughLv then
item:SetChildActive(5,true)
item:SetChildIcon(5,moneyIconName,false)
item:SetChildText(6,enoughMoneyOne and needCount or FMT.cfmt(FONT_COLOR.eRedColor,needCount))
else
item:SetChildActive(5,false)
item:SetChildText(6,'')
end
item:SetBaseItemChildID(7,itemid)
item:SetBaseItemClickEvent(7,function(...)
if self and not self.isClose then
self:onItemClick(...)
end
end)
item:SetChildIcon(8,iconName,false)
itemsComponentHelper.setUIBaseItemSmallSignCommon(item,8,itemid,false)
item:SetChildActive(9,new==1)
item:SetChildActive(10,buyOver)
item:SetChildActive(11,not enoughHours)
item:SetChildText(12,lockStr)

item:SetChildQulaityEx(13,colorPage,color)
item:SetChildActive(14,num>1)
item:SetChildText(15,num)
item:SetChildActive(16,not enoughLv)
item:SetChildText(17,FMT.fmt('需宗门{0}级',needZMLv))
item:SetChildActive(22,xiyou==1)
end

function UIXYBGShopWin:onItemClick(id,index,guid,attach)
if id==-1 then return end
tipsManager.showTips({itemid=id,showModel=true,})
end

function UIXYBGShopWin:onScrollItemClick(id,index,guid,attach)
if id<0 then return end

local needDay
local activityCfg=self.config
local cfg=activityCfg.good[id]
local moneyType=self.moneyType
local needCount=cfg[3]
local limitCount=cfg[4]
local needZMLv=cfg[5]
local waitDays=cfg[6][2]
local goodData=self:getGoodData(id)or{}
local buyCount=goodData.param_2 or 0
local enoughLv=zongmenModel:getLevel()>=needZMLv
local passDay=timeHelper.getPassDay(self.beginTime+self.tempStamps)
local enoughHours=passDay>=waitDays
if not enoughHours then needDay=self:getNeedTimeUnlock(waitDays-passDay)end
local limit=limitCount>0
local buyOver=limit and buyCount>=limitCount or false
local lockStr=not enoughLv and FMT.fmt('宗门{0}级可进货',needZMLv)or
not enoughHours and FMT.fmt('商品{0}后到货',needDay)or''
if buyOver then
UIManager.error('商品已售罄')
return
end
if lockStr~=''then
UIManager.error(lockStr)
return
end
local left=limitCount-buyCount
if not limit then
left=100
end
if left>100 then left=100 end

local checkFlag,newMoneyType=moneySystem:checkReplaceMoney(moneyType,needCount)


local actId=self.activityId
local subType=self.subType
local subId=self.subId
local showdata=
{
type='UIUseItemDialouge',
title='提示',
canceltext='取消',
oktext='购买',
max=left,
itemId=newMoneyType,
isWarning=false,
unitPrice=needCount,
okcallback=function(num)






local fun=function()
local info={1,id,num}
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jsonStr)
end
moneySystem:useMoney(moneyType,needCount*num,fun,WARNING_TYPE.eRechargeDialogue)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIXYBGShopWin:onBuyGood(idx,freshAll)
if idx<=0 then return end
self:freshGirds()
end

function UIXYBGShopWin:onBuildingEvent(typo,level)

if buildingEvent.zongmenLevelUp==typo then
self:freshGirds()
end
end

function UIXYBGShopWin:onMoneyChanged(moneyType)
if moneyType==self.moneyType then
self:freshMoney()
local value=moneyModel.getMoney(moneyType)or 0
self.money:setText(value)
local moneyIconName=iconHelper.getIconName(moneyType)
self.moneyIcon2:setChildIcon(moneyIconName,false)
end
end

function UIXYBGShopWin:initRandom()
this.talkList=this.config.auto_talklist or nil
end

function UIXYBGShopWin:removeRandom(idx)
local list={}
for k,v in ipairs(this.talkList)do
if k~=idx then
table.insert(list,v)
end
end
this.talkList=list
end

function UIXYBGShopWin:getRandom()
if this.talkList then
local len=#this.talkList
if len==0 then this:initRandom()end

local idx=math.random(len)
local text=this.talkList[idx]
this:removeRandom(idx)

return text
end
return nil
end

function UIXYBGShopWin:doSpeaking_player()
local speed=30
local speakStr=this:getRandom()

if speakStr then
this.winlua:SetChildCanvasGroupAlpha(this.speakObj:getID(),1)
this.winlua:SetChildTrendsTextPlay(this.speakText:getID(),speakStr,speed,nil)
this:doTalkAnim_player()
end
end

function UIXYBGShopWin:doTalkAnim_player()
if this.talkTween~=nil then
this.talkTween:Kill()
this.talkTween=nil
end

this.winlua:SetChildScale(this.speakObj:getID(),Vector3.zero)
this.doTalk=this:delayDo(0.2,function()
this.talkTween=this.winlua:SetChildDOScaleY(this.speakObj:getID(),1.2,0.2,function()
if this==nil then return end
this.talkTween=nil
this.talkTween=this.winlua:SetChildDOScale(this.speakObj:getID(),0.8,0.1,function()
if this==nil then return end
this.talkTween=nil
return this:talkEnd()
end)
end)
end)
end

function UIXYBGShopWin:talkEnd()
if this.speakShowTimer then
this:stopTimerByID(this.speakShowTimer)
this.speakShowTimer=nil
end
this.speakShowTimer=this:delayDo(2,function()

if this==nil then return end
this.winlua:SetChildScale(this.speakObj:getID(),Vector3.zero)
this.winlua:SetChildCanvasGroupAlpha(this.speakObj:getID(),0)

if this.speakShowTimer then
this:stopTimerByID(this.speakShowTimer)
this.speakShowTimer=nil
end
end)
end

function UIXYBGShopWin:clearSpkTimer()
if this.talkTween~=nil then
this.talkTween:Kill()
this.talkTween=nil
end

if this.doTalk then
this:stopTimerByID(this.doTalk)
this.doTalk=nil
end

if this.speakShowTimer then
this:stopTimerByID(this.speakShowTimer)
this.speakShowTimer=nil
end
end

function UIXYBGShopWin:reductionSpkObj()
this:clearSpkTimer()
this.winlua:SetChildScale(this.speakObj:getID(),Vector3.zero)
this.winlua:SetChildCanvasGroupAlpha(this.speakObj:getID(),0)
end

function UIXYBGShopWin:getIsShowNewIcon(itemId)
local data=self:getShowNewIconData()
local itemIdStr=tostring(itemId)
if not data[itemIdStr]then
data[itemIdStr]=true
self:setShowNewIconData(data)
return true
else
return false
end
end

function UIXYBGShopWin:getShowNewIconData()
local data=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eExChangeShop2,{})
return data
end

function UIXYBGShopWin:setShowNewIconData(list)
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eExChangeShop2,list)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eExChangeShop2)
end

function UIXYBGShopWin:getNeedTimeUnlock(waitdays)
local curtime=timeHelper.getServerLongTime()
local y,m,d,h,min,s=timeHelper.getServerStampData(curtime)

d=d+waitdays
h=0
min=0
s=0
local time=timeHelper.timeServer(y,m,d,h,min,s)
local lerp=time-curtime
time=self:format_time_stamp122(lerp)
return time
end

function UIXYBGShopWin:format_time_stamp122(time)
local day=86400
local hour=3600
local min=60
local str=nil
if time>day then
local v1=_floor(time/day)
local v2=time%day/hour
str=_format('%d天',v1)
elseif time>hour then
local v1=_floor(time/hour)
local v2=time%hour/min
str=_format('%d时',v1)
elseif time>min then
local v1=_floor(time/min)
local v2=time-v1*60
str=_format('%d分',v1)
else
str=_format('1分')
end
return str
end





function UIXYBGShopWin:onModelPeopleBtn()
if not this.talkList then return end

local flag=false
local nowTime=gameUtilityModel.getServerShortTime()

if not self.timeStamps then
flag=true
elseif nowTime-self.timeStamps>=0.5 then
flag=true
end
if not flag then return end

self.timeStamps=nowTime
this:reductionSpkObj()

this:doSpeaking_player()
if self.spkTimer then
self:stopTimerByID(self.spkTimer)
self.spkTimer=nil
end
self.spkTimer=self:setTimer(self.delay,0,function()
this:doSpeaking_player()
end)
end


function UIXYBGShopWin:onMoneyBtn()
gainControl:showGainWin(self.moneyType)
end

function UIXYBGShopWin:refreshRewardBtn()
local data={self.activityId,self.subType,self.subId}
self.isCanReward=FreeGiftController.GetFreeGift(self.giftId,data)

if self.giftId and self.isCanReward then
self.rewardBtn:setActive(true)
else
self.rewardBtn:setActive(false)
end
self.rewardReddot:setActive(self.isCanReward)
self:doPunchRotation(self.isCanReward)
end

function UIXYBGShopWin:onRewardBtn()
if self.isCanReward then
local data={self.activityId,self.subType,self.subId}
FreeGiftController.SendFreeGift(self.giftId,data,function(arg)
if arg then
self.isCanReward=false
local nowTime=gameUtilityModel.getServerShortTime()
activitiesHandle_exchangeshop:setReceiveState(self.isCanReward,nowTime)
UIManager:invokeUIMethod('UIXYBGShopWin','refreshRewardBtn')
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eDuiHuanShangDian2)
end
end)
else
UIManager.error('今日领取次数已达上限')
end
end

function UIXYBGShopWin:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self:setChildRotation(self.rewardReddot:getID(),0,0,0)
local tweener=self:setChildDOPunchRotation(self.rewardReddot:getID(),Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self:setChildRotation(self.rewardReddot:getID(),0,0,0)
end
end
end
