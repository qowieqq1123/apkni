







def_class("UISubAct_YHDBExchangeShopWin",UIWindowBase)









function UISubAct_YHDBExchangeShopWin:bindComponents()

self.model=UIObject.get(self,0)
self.modelbefore=UIObject.get(self,1)
self.modelPeople=UIObject.get(self,2)
self.modelPeopleBtn=UIButton.get(self,3)
self.money=UIText.get(self,4)
self.moneyBtn=UIButton.get(self,5)
self.moneyIcon=UIImage.get(self,6)
self.shopContent=UIObject.get(self,7)
self.speakObj=UIObject.get(self,8)
self.speakText=UIText.get(self,9)
self.time=UIText.get(self,10)

self.modelPeopleBtn:setButtonClick(function()self:onModelPeopleBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)



end


function UISubAct_YHDBExchangeShopWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelbefore);self.modelbefore=nil;
_UIObject_release(self.modelPeople);self.modelPeople=nil;
_UIObject_release(self.modelPeopleBtn);self.modelPeopleBtn=nil;
_UIObject_release(self.money);self.money=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.shopContent);self.shopContent=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.time);self.time=nil;
end


















local this
local _format=string.format
local _floor=math.floor


function UISubAct_YHDBExchangeShopWin:onLoaded(...)
self:bindComponents()

this=self

self:addNotify(notifyConfig.building_event,function(...)
self:onBuildingEvent(...)
end)

self:addNotify(notifyConfig.on_money_changed,function(...)
self:onMoneyChanged(...)
end)
end


function UISubAct_YHDBExchangeShopWin:__delete()
self:unbindComponents()
end




function UISubAct_YHDBExchangeShopWin:onShow(argtable,afterOnloaded)
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

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end

self.tempStamps=1609430400
self.moneyType=self.config.money
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

self:initRandom()
self:refreshBgModel()
self:setRemainingTimeTimer()
self:freshGirds()
self:initMoney()

self.delay=self.config.cdTime
if self.delay then
local cb=function()
self:doSpeaking_player()
end
self:delayDo(0.35,cb)
self.spkTimer=self:setTimer(self.delay,0,cb)
end
end


function UISubAct_YHDBExchangeShopWin:onHide()
self:clearTimer()
self:reductionSpkObj()
end


function UISubAct_YHDBExchangeShopWin:refreshBgModel()
local bgModelId=nil
local modelId=nil
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


function UISubAct_YHDBExchangeShopWin:setRemainingTimeTimer()
self:clearTimer()
local func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.time:setText(FMT.fmt("活动时间：{0}",timeHelper.format_time_stamp3(lerp)))
else
self.time:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end
func()
self.timer=self:setTimer(1,0,func)
end


function UISubAct_YHDBExchangeShopWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end

if self.spkTimer then
self:stopTimerByID(self.spkTimer)
self.spkTimer=nil
end
end

function UISubAct_YHDBExchangeShopWin:initMoney()
local moneyType=self.moneyType
local moneyIconName=iconHelper.getIconName(moneyType)
local value=mathHelper.formatNumber(moneyModel.getMoney(moneyType)or 0)
self.moneyIcon:setChildIcon(moneyIconName,false)
self.money:setText(value)
end

function UISubAct_YHDBExchangeShopWin:freshMoney()
for pageidx,list in ipairs(self.goodlist or{})do
for index,v in ipairs(list or{})do
local cfg=v
local i=cfg.index
local needCount=cfg[3]
local moneyType=self.moneyType
local enoughMoneyOne=moneyModel.checkEnoughMoney(moneyType,needCount)
local pageWidget=self.shopContent:getChildLayoutGroupGridItem(pageidx-1)
local item=pageWidget:GetChildLayoutGroupGridItem(3,index-1)
item:SetChildText(6,enoughMoneyOne and needCount or FMT.cfmt(FONT_COLOR.eRedColor,needCount))
end
end
end

function UISubAct_YHDBExchangeShopWin:getGoodData(idx)
local activityData=activitiesModel:getSubActInfoData(self.activityId,self.subType,self.subId)or{}
for i,v in ipairs(activityData.list or{})do
if v.param_1==idx then
return v
end
end
end

function UISubAct_YHDBExchangeShopWin:freshGirds()
local activityCfg=self.config
local good=activityCfg.good
local sortTag={}
local goodlist={}
for i,v in ipairs(good)do
local cfg=v
local limitCount=cfg[4]
local islimit=limitCount>0
local goodData=self:getGoodData(i)or{}
local buyCount=goodData.param_2 or 0
local buyOver=islimit and buyCount>=limitCount
local sort=cfg[10]
goodlist[i]=v
local buyOverTag=buyOver and 1 or 0
sortTag[i]=sort+buyOverTag*100000
goodlist[i].index=i
end
if#goodlist>1 then
table.sort(goodlist,function(a,b)
return sortTag[a.index]<sortTag[b.index]
end)
end

self.goodlist=goodlist

local tNum=math.ceil(#goodlist/3)
local func=function(idx)
self:freshPageItem(idx)
end
self.shopContent:setChildLayoutGroupCreateItems(tNum,func)
end

function UISubAct_YHDBExchangeShopWin:freshPageItem(pageidx)
local widget=self.shopContent:getChildLayoutGroupGridItem(pageidx-1)
for index=1,3 do
self:freshChildItem(pageidx,index)
end
end

function UISubAct_YHDBExchangeShopWin:freshChildItem(pageidx,index)
local pageWidget=self.shopContent:getChildLayoutGroupGridItem(pageidx-1)
local item=pageWidget:GetChildCSGUIBaseItem(index-1)
local idx=index+(pageidx-1)*3
local cfg=self.goodlist[idx]
if not cfg then
item:SetChildActive(-1,false)
return
end
local cfgId=cfg.index
local itemid=cfg[1]
local itemCfg=itemsConfig.getConfig(itemid)
local num=cfg[2]
local moneyType=self.moneyType
local needCount=cfg[3]
local limitCount=cfg[4]
local xiyou=cfg[8]
local new=0
local goodData=self:getGoodData(cfgId)or{}
local buyCount=goodData.param_2 or 0
local enoughMoneyOne=moneyModel.checkEnoughMoney(moneyType,needCount)
local itemname=itemsModel.getName(itemid)
local moneyIconName=iconHelper.getIconName(moneyType)
local iconName=iconHelper.getIconName(itemid)
local islimit=limitCount>0
local buyOver=islimit and buyCount>=limitCount
local color=itemCfg.color
local colorPage=itemCfg.colorPage or 0

item:SetChildActive(-1,true)
item:SetBaseItemChildID(-1,cfgId)
item:SetBaseItemClickEvent(-1,function(...)
if self and not self.isClose then
self:onScrollItemClick(...)
end
end)
item:SetChildActive(0,islimit)
item:SetChildText(1,islimit and FMT.fmt('限购:{0}',limitCount-buyCount)or'不限购')
item:SetChildText(2,itemname)
item:SetChildIcon(3,moneyIconName,false)
item:SetChildText(4,enoughMoneyOne and needCount or FMT.cfmt(FONT_COLOR.eRedColor,needCount))
item:SetChildIcon(5,iconName,false)
itemsComponentHelper.setUIBaseItemSmallSignCommon(item,5,itemid,false)
item:SetChildQulaityEx(6,colorPage,color)
item:SetChildActive(7,num>1)
item:SetChildText(8,num)
item:SetChildActive(9,new==1)
item:SetChildActive(10,buyOver)
item:SetChildActive(11,buyOver)
item:SetChildActive(12,xiyou==1)
item:SetBaseItemChildID(13,itemid)
item:SetBaseItemClickEvent(13,function(...)
if self and not self.isClose then
self:onItemClick(...)
end
end)
end

function UISubAct_YHDBExchangeShopWin:onItemClick(id,index,guid,attach)
if id==-1 then return end
tipsManager.showTips({itemid=id,showModel=true,})
end

function UISubAct_YHDBExchangeShopWin:onScrollItemClick(id,index,guid,attach)
if id<0 then return end
local activityCfg=self.config
local cfg=activityCfg.good[id]
local moneyType=self.moneyType
local needCount=cfg[3]
local limitCount=cfg[4]
local goodData=self:getGoodData(id)or{}
local buyCount=goodData.param_2 or 0
local limit=limitCount>0
local buyOver=limit and buyCount>=limitCount or false
if buyOver then
UIManager.error('商品已售罄')
return
end

local left=limitCount-buyCount
if not limit then
left=100
end
if left>100 then left=100 end
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

function UISubAct_YHDBExchangeShopWin:onBuyGood(idx,freshAll)
if idx<=0 then return end
self:freshGirds()
end

function UISubAct_YHDBExchangeShopWin:onBuildingEvent(typo,level)




end

function UISubAct_YHDBExchangeShopWin:onMoneyChanged(moneyType)
if moneyType==self.moneyType then

local value=mathHelper.formatNumber(moneyModel.getMoney(moneyType)or 0)
self.money:setText(value)
end
end

function UISubAct_YHDBExchangeShopWin:initRandom()
this.talkList=this.config.auto_talklist
end

function UISubAct_YHDBExchangeShopWin:removeRandom(idx)
local list={}
for k,v in ipairs(this.talkList)do
if k~=idx then
table.insert(list,v)
end
end
this.talkList=list
end

function UISubAct_YHDBExchangeShopWin:getRandom()
local len=#this.talkList
if len==0 then this:initRandom()end

local idx=math.random(len)
local text=this.talkList[idx]
this:removeRandom(idx)

return text
end

function UISubAct_YHDBExchangeShopWin:doSpeaking_player()
local speed=30
local speakStr=this:getRandom()

this.winlua:SetChildCanvasGroupAlpha(this.speakObj:getID(),1)
this.winlua:SetChildTrendsTextPlay(this.speakText:getID(),speakStr,speed,nil)
this:doTalkAnim_player()
end

function UISubAct_YHDBExchangeShopWin:doTalkAnim_player()
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

function UISubAct_YHDBExchangeShopWin:talkEnd()
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

function UISubAct_YHDBExchangeShopWin:clearSpkTimer()
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

function UISubAct_YHDBExchangeShopWin:reductionSpkObj()
this:clearSpkTimer()
this.winlua:SetChildScale(this.speakObj:getID(),Vector3.zero)
this.winlua:SetChildCanvasGroupAlpha(this.speakObj:getID(),0)
end

function UISubAct_YHDBExchangeShopWin:getIsShowNewIcon(itemId)
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

function UISubAct_YHDBExchangeShopWin:getShowNewIconData()
local data=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eExChangeShop2,{})
return data
end

function UISubAct_YHDBExchangeShopWin:setShowNewIconData(list)
userActorArraySetting.setBase(ACTOR_SETTING_TYPE.eExChangeShop2,list)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eExChangeShop2)
end

function UISubAct_YHDBExchangeShopWin:onMoneyBtn()
gainControl:showGainWin(self.moneyType)
end

function UISubAct_YHDBExchangeShopWin:onModelPeopleBtn()
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