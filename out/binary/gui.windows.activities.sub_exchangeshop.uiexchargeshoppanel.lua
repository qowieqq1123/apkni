







def_class("UIExchargeShopPanel",UIWindowBase)









function UIExchargeShopPanel:bindComponents()

self.creater=UIObject.get(self,0)
self.item1=UIBaseItem.get(self,1)
self.item2=UIBaseItem.get(self,2)
self.item3=UIBaseItem.get(self,3)
self.item4=UIBaseItem.get(self,4)
self.level=UIText.get(self,5)
self.model=UIObject.get(self,6)
self.modelMao=UIObject.get(self,7)
self.modelPeopleBtn=UIButton.get(self,8)
self.money=UIText.get(self,9)
self.moneyBtn=UIButton.get(self,10)
self.moneyIcon=UIObject.get(self,11)
self.moneyIcon2=UIImage.get(self,12)
self.moneyNum=UIText.get(self,13)
self.moneyRoot=UIObject.get(self,14)
self.progressBar=UIProgressBarAni.get(self,15)
self.progressCount=UIText.get(self,16)
self.reddot=UIObject.get(self,17)
self.rewards=UIObject.get(self,18)
self.rewardsRoot=UIObject.get(self,19)
self.speakObj=UIObject.get(self,20)
self.speakText=UIText.get(self,21)
self.time=UIText.get(self,22)
self.xiangzi=UIButton.get(self,23)

self.modelPeopleBtn:setButtonClick(function()self:onModelPeopleBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.xiangzi:setButtonClick(function()self:onXiangzi()end)



end


function UIExchargeShopPanel:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelMao);self.modelMao=nil;
_UIObject_release(self.modelPeopleBtn);self.modelPeopleBtn=nil;
_UIObject_release(self.money);self.money=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyIcon2);self.moneyIcon2=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressCount);self.progressCount=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.rewards);self.rewards=nil;
_UIObject_release(self.rewardsRoot);self.rewardsRoot=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.xiangzi);self.xiangzi=nil;
end


local this















function UIExchargeShopPanel:onLoaded(...)
self:bindComponents()






this=self
self.itemsSlot={}
local slot=self.itemsSlot
slot[#slot+1]=self.item1
slot[#slot+1]=self.item2
slot[#slot+1]=self.item3
slot[#slot+1]=self.item4
self:addNotify(notifyConfig.building_event,function(...)
self:onBuildingEvent(...)
end)

self:addNotify(notifyConfig.on_money_changed,function(...)
self:onMoneyChanged(...)
end)
self.showRewards=true
end

function UIExchargeShopPanel:__delete()
self:stopReddotTweener()
self:unbindComponents()
this=nil
end

function UIExchargeShopPanel:onShow(argtable,afterOnloaded)
local actId=argtable.act_id
local subType=argtable.sub_act_type
local subId=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(subType,subId)
self.moneyType=self.config.money
self.actId=actId
self.subType=subType
self.subId=subId
self.tNum=nil
self.winlua:SetChildUIModelShowTarget(self.model:getID(),4003,1,{},eAnimationID.stand,
false,false,0,function()
self:freshXiangzi()
end)
self.winlua:SetChildUIModelShowTarget(self.modelMao:getID(),4016,0.3,{},eAnimationID.stand)
self:freshInfo()

self.delay=5
local cb=function()
self:doSpeaking_player()
end

if this.config.talk then
self:initRandom()
self:delayDo(0.35,cb)
self.spkTimer=self:setTimer(self.delay,0,cb)
end
end

function UIExchargeShopPanel:onHide()

end



function UIExchargeShopPanel:freshInfo()

self:freshTime()
self:freshGirds()
self:freshItemList()
end

function UIExchargeShopPanel:freshTime()
if self.timer then
self:stopTimerByID(self.timer)
end
local actId=self.actId
local subType=self.subType
local subId=self.subId
local model=activitiesModel:getSubActInfo(actId,subType,subId)
local activityCfg=activitiesModel:getSubActivityConfig(subType,subId)
local activityData=activitiesModel:getSubActInfoData(actId,subType,subId)
local func=function()
local endTime=model.end_time
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=endTime-nowTime
self.time:setText(FMT.fmt("剩余活动时间：{0}",timeHelper.format_time_stamp3(lerp,true)))
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIExchargeShopPanel:freshItemList()
local actId=self.actId
local subType=self.subType
local subId=self.subId
local model=activitiesModel:getSubActInfo(actId,subType,subId)
local activityCfg=activitiesModel:getSubActivityConfig(subType,subId)
local activityData=activitiesModel:getSubActInfoData(actId,subType,subId)
local exp=activityData.exp or 0

local shoplv,need,rewardsCfg,isMax=model:getShopLevel()
local lastlv=shoplv-1
local total=rewardsCfg[1]
local lastMaxExp=lastlv>0 and activityCfg.level[lastlv][1]or 0
local curMaxExp=total-lastMaxExp
local curexp=exp-lastMaxExp
local moneyType=self.moneyType
local moneyIconName=iconHelper.getIconName(moneyType)
local noNext=isMax
self.moneyNum:setText(need)
self.moneyIcon:setChildIcon(moneyIconName,false)
self.money:setText(moneyModel.getMoney(moneyType))
local moneyIconName=iconHelper.getIconName(moneyType)
self.moneyIcon2:setChildIcon(moneyIconName,false)
self.level:setText(FMT.fmt('{0}级商店',shoplv))
if curexp>=curMaxExp then curexp=curMaxExp end
if noNext then
if curMaxExp==0 then curMaxExp=100 end
curexp=curMaxExp
end
self.progressBar:animateThreeParams(curexp,curMaxExp,self.buy and 0.5 or 0)
self.progressCount:setText(noNext and'经验已满'or FMT.fmt('{0}/{1}',curexp,curMaxExp))

self.buy=false

self:freshXiangzi()

local rewards=rewardsCfg[2]
for i=1,4 do
local itemsSlot=self.itemsSlot[i]
local itemInfo=rewards[i]
itemsSlot:setActive(itemInfo~=nil)
if itemInfo then
local widget=itemsSlot:getWidgetBase()
local itemid=itemInfo[1]
local itemCfg=itemsConfig.getConfig(itemid)
local num=itemInfo[2]
local iconName=iconHelper.getIconName(itemid)
widget:SetChildIcon(0,iconName,false)
widget:SetChildActive(1,num>1)

widget:SetChildText(2,num)
widget:SetChildQulaity(3,itemCfg.color)
widgetHelper.setItemQulaity(widget,itemid,3)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemClickEvent(-1,function(...)
if self and not self.isClose then
self:onItemClick(...)
end
end)
end
end
end

function UIExchargeShopPanel:freshXiangzi()
local actId=self.actId
local subType=self.subType
local subId=self.subId
local model=activitiesModel:getSubActInfo(actId,subType,subId)
local activityData=activitiesModel:getSubActInfoData(actId,subType,subId)
local shoplv,need,rewardsCfg,isMax=model:getShopLevel()
local hasPrize=model:hasPrize()
local showXiangZi=true
if isMax and model:alreadyPrize(shoplv-1)then showXiangZi=false end

self.xiangzi:setActive(showXiangZi)

local showRewards=self.showRewards
showRewards=showXiangZi and showRewards and not isMax
self.showRewards=showRewards
self.rewardsRoot:setActive(showRewards)
self:setReddotVis(hasPrize)

local slotname='duihuangshandian_4'
self.winlua:SetChildUIModelShowSlotAttachment(self.model:getID(),slotname,
showXiangZi and slotname or'')

local slotname='duihuangshandian_5'
self.winlua:SetChildUIModelShowSlotAttachment(self.model:getID(),slotname,
showXiangZi and slotname or'')

local slotname='duihuangshandian_3'
self.winlua:SetChildUIModelShowSlotAttachment(self.model:getID(),slotname,
showXiangZi and slotname or'')


local slotname='duihuangshandian_2'
self.winlua:SetChildUIModelShowSlotAttachment(self.model:getID(),slotname,
hasPrize and slotname or'')
local slotname='duihuangshandian_24'
self.winlua:SetChildUIModelShowSlotAttachment(self.model:getID(),slotname,
hasPrize and'duihuangshandian_2'or'')
end

function UIExchargeShopPanel:stopReddotTweener()
self.reddot:setActive(false)
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener=nil
self.reddot:setRotation(0,0,0)
end
end

function UIExchargeShopPanel:setReddotVis(reddot)
if reddot then
self.reddot:setActive(true)
if self.reddotTweener==nil then
self.reddot:setRotation(0,0,0)
local tweener=self.reddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
self:stopReddotTweener()
end
end

function UIExchargeShopPanel:freshGirds()
local actId=self.actId
local subType=self.subType
local subId=self.subId
local model=activitiesModel:getSubActInfo(actId,subType,subId)
local activityCfg=activitiesModel:getSubActivityConfig(subType,subId)
local good=activityCfg.good
local shoplv=model:getShopLevel()
local sortTag={}
local goodlist={}
local qllist={}
qllist.qlTag=true
goodlist[#goodlist+1]=qllist
goodlist[#goodlist+1]={}
for i,v in ipairs(good)do
local cfg=v
local needZMLv=cfg[5]
local needShopLv=cfg[6]
local enoughLv=zongmenModel:getLevel()>=needZMLv
local enoughShopLv=shoplv>=needShopLv
local isUnlock=enoughLv and enoughShopLv or false
local limitCount=cfg[4]
local islimit=limitCount>0
local goodData=self:getGoodData(i)or{}
local buyCount=goodData.param_2 or 0
local buyOver=islimit and buyCount>=limitCount
local sort=cfg[10]
local qlTag=cfg[11]==1 and true or false
local qlindex=qlTag and 1 or 2
local subgoodlist=goodlist[qlindex]
if isUnlock then
subgoodlist[#subgoodlist+1]=v
local len=#subgoodlist
local buyOverTag=buyOver and 1 or 0
sortTag[i]=len+sort*100+buyOverTag*100000
subgoodlist[len].index=i
elseif cfg[9]==1 then
if enoughShopLv then
subgoodlist[#subgoodlist+1]=v
local len=#subgoodlist
sortTag[i]=len+needZMLv*500000
subgoodlist[len].index=i
else
subgoodlist[#subgoodlist+1]=v
local len=#subgoodlist
sortTag[i]=len+needShopLv*50000000
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

function UIExchargeShopPanel:freshPageItem(pageidx)
local widget=self.creater:getChildLayoutGroupGridItem(pageidx-1)
local pageCfg=self.goodlist[pageidx]
local qlTag=pageCfg.qlTag==true
local len=#pageCfg
local func=function(idx)
self:freshChildItem(pageidx,idx)
end
widget:SetChildLayoutGroupCreateItems(3,len,func)
widget:SetChildActive(0,qlTag)
widget:SetChildActive(1,not qlTag)
widget:SetChildText(2,qlTag and'奇珍异宝'or
FMT.cfmt2('#883b31','不可多得'))

end

function UIExchargeShopPanel:freshChildItem(pageidx,index)
local pageWidget=self.creater:getChildLayoutGroupGridItem(pageidx-1)
local item=pageWidget:GetChildLayoutGroupGridItem(3,index-1)
local pageCfg=self.goodlist[pageidx]
local qlTag=pageCfg.qlTag==true
local cfg=pageCfg[index]
local actId=self.actId
local subType=self.subType
local subId=self.subId
local model=activitiesModel:getSubActInfo(actId,subType,subId)
local activityCfg=activitiesModel:getSubActivityConfig(subType,subId)
local activityData=activitiesModel:getSubActInfoData(actId,subType,subId)
local i=cfg.index
local itemid=cfg[1]
local itemCfg=itemsConfig.getConfig(itemid)
local num=cfg[2]
local moneyType=self.moneyType
local needCount=cfg[3]
local limitCount=cfg[4]
local needZMLv=cfg[5]
local needShopLv=cfg[6]
local resetType=cfg[7]
local xiyou=cfg[8]
local goodData=self:getGoodData(i)or{}
local buyCount=goodData.param_2 or 0
local enoughMoneyOne=moneyModel.checkEnoughMoney(moneyType,needCount)
local shoplv=model:getShopLevel()
local enoughLv=zongmenModel:getLevel()>=needZMLv
local enoughShopLv=shoplv>=needShopLv
local isUnlock=enoughLv and enoughShopLv or false
local itemname=itemsModel.getName(itemid)
local moneyIconName=iconHelper.getIconName(moneyType)
local iconName=iconHelper.getIconName(itemid)
local islimit=limitCount>0
local buyOver=islimit and buyCount>=limitCount
local lockStr=not enoughShopLv and FMT.fmt('{0}级解锁',needShopLv)or''
local color=itemCfg.color
local colorPage=itemCfg.colorPage or 0

item:SetBaseItemChildID(-1,i)
item:SetBaseItemClickEvent(-1,function(...)
if self and not self.isClose then
self:onScrollItemClick(...)
end
end)
item:SetChildActive(0,qlTag)
item:SetChildActive(20,not qlTag)

item:SetChildActive(1,false)
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
item:SetChildActive(9,xiyou==1)
item:SetChildActive(10,buyOver)
item:SetChildActive(11,not enoughShopLv)
item:SetChildText(12,lockStr)

item:SetChildQulaityEx(13,colorPage,color)
item:SetChildActive(14,num>1)
item:SetChildText(15,num)
item:SetChildActive(16,not enoughLv)
item:SetChildText(17,FMT.fmt('需宗门{0}级',needZMLv))
end

function UIExchargeShopPanel:freshMoney()
for pageidx,list in ipairs(self.goodlist or{})do
for index,v in ipairs(list or{})do
local cfg=v
local i=cfg.index
local actId=self.actId
local subType=self.subType
local subId=self.subId
local model=activitiesModel:getSubActInfo(actId,subType,subId)
local activityCfg=activitiesModel:getSubActivityConfig(subType,subId)
local activityData=activitiesModel:getSubActInfoData(actId,subType,subId)
local needCount=cfg[3]
local moneyType=self.moneyType
local enoughMoneyOne=moneyModel.checkEnoughMoney(moneyType,needCount)
local pageWidget=self.creater:getChildLayoutGroupGridItem(pageidx-1)
local item=pageWidget:GetChildLayoutGroupGridItem(3,index-1)
item:SetChildText(6,enoughMoneyOne and needCount or FMT.cfmt(FONT_COLOR.eRedColor,needCount))
end
end
end

function UIExchargeShopPanel:onItemClick(id,index,guid,attach)
if id==-1 then return end
tipsManager.showTips({itemid=id})
end


function UIExchargeShopPanel:onScrollItemClick(id,index,guid,attach)
if id<0 then return end
local actId=self.actId
local subType=self.subType
local subId=self.subId
local model=activitiesModel:getSubActInfo(actId,subType,subId)
local activityCfg=activitiesModel:getSubActivityConfig(subType,subId)
local activityData=activitiesModel:getSubActInfoData(actId,subType,subId)

local cfg=activityCfg.good[id]
local itemid=cfg[1]
local num=cfg[2]
local moneyType=self.moneyType
local needCount=cfg[3]
local limitCount=cfg[4]
local needZMLv=cfg[5]
local needShopLv=cfg[6]
local resetType=cfg[7]
local xiyou=cfg[8]
local goodData=self:getGoodData(id)or{}
local buyCount=goodData.param_2 or 0
local shoplv=model:getShopLevel()
local enoughLv=zongmenModel:getLevel()>=needZMLv
local enoughShopLv=shoplv>=needShopLv
local iconName=iconHelper.getIconName(itemid)
local limit=limitCount>0
local buyOver=limit and buyCount>=limitCount or false
local lockStr=not enoughLv and FMT.fmt('宗门{0}级解锁',needZMLv)or
not enoughShopLv and FMT.fmt('商店{0}级解锁',needShopLv)or''
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
local actId=self.actId
local subType=self.subType
local subId=self.subId
local showdata=
{
type='UIUseItemDialouge',
title='提示',
canceltext='取消',
oktext='购买',
max=left,
itemId=moneyType,
unitPrice=needCount,
okcallback=function(num)
if not moneyModel.checkEnoughMoney(moneyType,needCount*num)then
local moneyName=moneyModel.getMoneyName(moneyType)
local err=FMT.fmt('{0}不足',moneyName)
UIManager.error(err)
return
end
local info={1,id,num}
local jsonStr=jsonHelper.encode(info)
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jsonStr)
end,

showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end

function UIExchargeShopPanel:getGoodData(idx)
local actId=self.actId
local subType=self.subType
local subId=self.subId
local activityData=activitiesModel:getSubActInfoData(actId,subType,subId)or{}
for i,v in ipairs(activityData.list or{})do
if v.param_1==idx then
return v
end
end
end

function UIExchargeShopPanel:onBuyGood(idx,freshAll)
if idx<=0 then return end
self.buy=true







self:freshInfo()
end


function UIExchargeShopPanel:onRewards()
self:freshItemList()
end

function UIExchargeShopPanel:onXiangzi()
local actId=self.actId
local subType=self.subType
local subId=self.subId
local model=activitiesModel:getSubActInfo(actId,subType,subId)
local activityCfg=activitiesModel:getSubActivityConfig(subType,subId)
local activityData=activitiesModel:getSubActInfoData(actId,subType,subId)
local shoplv,need,rewardsCfg=model:getShopLevel()
local levels=model:getCanPrizeLevel()
if#levels<=0 then
self.showRewards=not self.showRewards
self.rewardsRoot:setActive(self.showRewards)
return
end
local level=0
for i,v in ipairs(levels)do
if level<v then
level=v
end
end
local jsonStr=jsonHelper.encode({2,level})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actId,subType,subId,jsonStr)
end

function UIExchargeShopPanel:onBuildingEvent(typo,level)

if buildingEvent.zongmenLevelUp==typo then
self:freshInfo()
end
end

function UIExchargeShopPanel:onMoneyChanged(moneyType)
if moneyType==self.moneyType then
self:freshMoney()
self.money:setText(moneyModel.getMoney(moneyType))
local moneyIconName=iconHelper.getIconName(moneyType)
self.moneyIcon2:setChildIcon(moneyIconName,false)
end
end

function UIExchargeShopPanel:onMoneyBtn()
gainControl:showGainWin(self.moneyType)
end

function UIExchargeShopPanel:closeRewards()
self.rewardsRoot:setActive(false)
end


function UIExchargeShopPanel:initRandom()
this.talkList=this.config.talk or{}
end

function UIExchargeShopPanel:removeRandom(idx)
local list={}
for k,v in ipairs(this.talkList)do
if k~=idx then
table.insert(list,v)
end
end
this.talkList=list
end

function UIExchargeShopPanel:getRandom()
local len=#this.talkList
if len==0 then this:initRandom()end

local idx=math.random(len)
local text=this.talkList[idx]
this:removeRandom(idx)

return text
end

function UIExchargeShopPanel:doSpeaking_player()
local speed=30
local speakStr=this:getRandom()

this.winlua:SetChildCanvasGroupAlpha(this.speakObj:getID(),1)
this.winlua:SetChildTrendsTextPlay(this.speakText:getID(),speakStr,speed,nil)
this:doTalkAnim_player()
end

function UIExchargeShopPanel:doTalkAnim_player()
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

function UIExchargeShopPanel:talkEnd()
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

function UIExchargeShopPanel:clearSpkTimer()
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

function UIExchargeShopPanel:reductionSpkObj()
this:clearSpkTimer()
this.winlua:SetChildScale(this.speakObj:getID(),Vector3.zero)
this.winlua:SetChildCanvasGroupAlpha(this.speakObj:getID(),0)
end


function UIExchargeShopPanel:onModelPeopleBtn()
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
