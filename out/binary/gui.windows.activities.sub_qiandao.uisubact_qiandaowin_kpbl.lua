







def_class("UISubAct_QianDaoWin_KPBL",UIWindowBase)









function UISubAct_QianDaoWin_KPBL:bindComponents()

self.model=UIObject.get(self,0)
self.timeText=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.day=UIText.get(self,3)
self.aiModel=UIObject.get(self,4)
self.effect=UIObject.get(self,5)
self.progressContent=UIObject.get(self,6)
self.progressRewardScrollView=UIObject.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_QianDaoWin_KPBL:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.day);self.day=nil;
_UIObject_release(self.aiModel);self.aiModel=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.progressContent);self.progressContent=nil;
_UIObject_release(self.progressRewardScrollView);self.progressRewardScrollView=nil;
end
















local abName='ui/windows/activities/sub_qiandao/gongceqiandao_atlas_pak.ab'
local assetName={'image_gongceqiandaoui_1','image_gongceqiandaoui_3'}
local assetmaskName={'image_gongceqiandaoui_2','image_gongceqiandaoui_5'}




function UISubAct_QianDaoWin_KPBL:onLoaded(...)
self:bindComponents()
end


function UISubAct_QianDaoWin_KPBL:__delete()
if self.actorAudioHandleId then
AudioManager.fadeOutStopAudioById(self.actorAudioHandleId,0.5)
end

self:unbindComponents()
self:closeWindow("UIRawImageBackWin")
end




function UISubAct_QianDaoWin_KPBL:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.egongCheQianDao
self.subid=argtable.sub_act_id
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

local openPanel=self.config.openPanel
if openPanel[1][2]then
local modelParams=openPanel[1][2].modelParams

if modelParams then
self.model:setChildUIModelShowTarget(modelParams.body,modelParams.scale or 1,modelParams.components or{},eAnimationID.stand,false,nil,0)
self.model:setChildUIModelShowTargetOffset(modelParams.offsetX or 0,modelParams.offsetY or 0)
end

self.actorParams=openPanel[1][2].actorParams
end
if self.activityArgs.parentWin then
UIManager:callWindowFunc(self.activityArgs.parentWin,"hideClose")
else
local arrs=self:getChildCanvas(-1)
local sortLayer=arrs[1]
local sortOrder=arrs[2]-1
self:showWindow("UIRawImageBackWin",{sortLayer=sortLayer,sortOrder=sortOrder})
end

self.info:setShowLogin()

self.opendays=self.info.openDays
self.startday=self.info.start_day_idx
self.endday=self.info.end_day_idx
self.start_time=self.info.start_time
self.end_time=self.info.end_time

self:setRemainingTimeTimer()

self:refreshList()
end


function UISubAct_QianDaoWin_KPBL:onHide()

end

function UISubAct_QianDaoWin_KPBL:createActor(bodyId,otherData,animationID,pos,animList,effectAnim,animTime,animAudio)
local parent=self.aiModel:getCommonComponent('Transform')
local id=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDisciple,parent,function(id)
local stWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
stWidget:SetChildAnchoredPosition(0,pos)

local scale=isometricMapSystem:getModelScale(bodyId,true)
if otherData.scale then
scale=scale*otherData.scale
end
if animList then
stWidget:SetChildUIModelShowTarget(0,bodyId,scale,otherData.componets,animationID or eAnimationID.stand)
local idx=1
for i,v in ipairs(animList)do
if v==animationID then
idx=i
break
end
end
if effectAnim then
self:setAnimAndEffect(stWidget,idx,animationID,animList,effectAnim,animTime)
end

if animAudio then
self:setAnimAudio(idx,animationID,animList,animTime,animAudio)
end

else
stWidget:SetChildUIModelShowTarget(0,bodyId,scale,otherData.componets,animationID or eAnimationID.stand)
end






end)
return id
end

function UISubAct_QianDaoWin_KPBL:setAnimAndEffect(stWidget,idx,animationID,animList,effectAnim,animTime)
if effectAnim then
if effectAnim[animationID]then
local delay=effectAnim[animationID][4]or 0
if delay>0 then
self:delayDo(delay,function()
self.effect:setChildShowEffect(effectAnim[animationID][1],true)
self.effect:setChildAnchoredPos(effectAnim[animationID][2]or 0,effectAnim[animationID][3]or 0)
end)
else
self.effect:setChildShowEffect(effectAnim[animationID][1],true)
self.effect:setChildAnchoredPos(effectAnim[animationID][2]or 0,effectAnim[animationID][3]or 0)
end
end
end

local num=#animList
local last=idx
local findEffect=false
local delayTime=0
for i=idx,num do
if i~=idx and effectAnim[animList[i]]then
idx=i
findEffect=true
break
end
if animTime[animList[i]]then
delayTime=delayTime+animTime[animList[i]]
end
end
if not findEffect then
if last>1 then
for i=1,last-1 do
if effectAnim[animList[i]]then
idx=i
break
end
if animTime[animList[i]]then
delayTime=delayTime+animTime[animList[i]]
end
end
end
end
self.effectDelay=self.effectDelay or{}
self.effectDelay[animationID]=self:delayDo(delayTime,function()
self:setAnimAndEffect(stWidget,idx,animList[idx],animList,effectAnim,animTime)
end)













end

function UISubAct_QianDaoWin_KPBL:setAnimAudio(idx,animationID,animList,animTime,animAudio)

local animAudioParam=animAudio[animationID]
if animAudioParam then
local delay=animAudioParam[2]
local animAudioId=animAudioParam[1]
if delay and delay>0 then
self:delayDo(delay,function()

self.actorAudioHandleId=AudioManager.playAudio(animAudioId)
end)
else

self.actorAudioHandleId=AudioManager.playAudio(animAudioId)
end
end

local num=#animList
local last=idx
local delayTime=animTime and animTime[animList[idx]]or 0
local nextIndex=idx+1
if nextIndex>num then
nextIndex=1
end

self.audioDelay=self.audioDelay or{}
self.audioDelay[animationID]=self:delayDo(delayTime,function()
self:setAnimAudio(nextIndex,animList[nextIndex],animList,animTime,animAudio)
end)
end


function UISubAct_QianDaoWin_KPBL:refreshActor()
if self.actorList then
for i,v in pairs(self.actorList)do
_InstantiateManager.RemoveInstance(v)
end
end
if self.effectDelay then
for i,v in pairs(self.effectDelay)do
self:stopTimerByID(v)
end
end
if self.audioDelay then
for i,v in pairs(self.audioDelay)do
self:stopTimerByID(v)
end
end

if self.actorParams then
self.actorList={}
local today=self.info:getStart2NowDay()
for i,v in ipairs(self.actorParams)do
local anim=eAnimationID.stand
if v.dayAnim then
if type(v.dayAnim)=='table'then
anim=v.dayAnim[today]
else
anim=v.dayAnim
end
elseif v.anim then
if type(v.anim)=='table'then
anim=v.anim[math.random(1,#v.anim)]
else
anim=v.anim
end
end

local id=self:createActor(v.body,{componets=v.componets,scale=v.scale},anim,Vector3(v.offset[1],v.offset[2],0),v.anim,v.animEffect,v.animTime,v.animAudio)
self.actorList[id]=id
end
end
end

function UISubAct_QianDaoWin_KPBL:refreshList(dataRecv)
local reward=self.config.rewards
local showArgs=self.config.show_rewards


local len=#reward
local today=self.info:getStart2NowDay()
self.progressRewardScrollView:setChildScrollViewCreateGrids(len,len)

self.day:setText(today)



local grids=self.progressRewardScrollView:getChildScrollViewItemWidgets()
for i=1,len do
local item=grids[i-1]
local dayReward=reward[i]
local showItem=dayReward[1]

local isSign=self.info:checkSign(i)
local isGot=self.info:checkGot(i)

item:SetChildText(0,FMT.fmt("第{0}天",i))
local dajiang=showArgs[i]and showArgs[i][1]==1
item:SetChildAnimationStringID(9,"xianshu_light",true)
item:SetChildActive(5,dajiang)
item:SetChildActive(6,not dajiang)
if i==today then
item:SetChildActive(1,isGot)
item:SetChildActive(4,false)
item:SetChildActive(9,isSign and not isGot)
item:SetChildText(8,'')
elseif i<today then
item:SetChildActive(1,isGot)

item:SetChildActive(4,not isGot)
item:SetChildActive(9,false)
item:SetChildText(8,'')
item:SetChildButtonClick(4,function()
local buqianConmuse=self.config.buqian_cost[i]~=nil and self.config.buqian_cost[i]or self.config.buqian_cost[1]
local conmuse=buqianConmuse[1]
local iconname=iconHelper.getIconName(conmuse[1])
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,40)
local show_data={
type='UIDialougeWithIcon',
title='提示',
content=FMT.fmt("是否确认花费{0}<color=#db8e28>{1}</color>进行补签？",iconStr,conmuse[2]),
oktext='确定',
canceltext='取消',
okcallback=function()
moneySystem:useMoney(conmuse[1],conmuse[2],function()
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({2,i}))
end,WARNING_TYPE.eWarning)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
end)
elseif i>today then
item:SetChildActive(1,false)
item:SetChildActive(4,false)
item:SetChildActive(9,false)
end

local conf={itemid=showItem[1],itemcount=showItem[2]<=1 and''or showItem[2],showname=false,showCountBG=showItem[2]>1,range=showItem.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,11)]=showItem.range~=nil
item:SetChildPropData(7,prop)
item:SetBaseItemClickEvent(7,function(...)
if i==today and isSign and not isGot then
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actid,self.subType,self.subid,jsonHelper.encode({1,i}))
else
self:onClickRewardItem(...)
end
end)


local posY=i%2==0 and-29 or-5
item:SetChildAnchoredPos(10,0,posY)
end

if self.daytimer then
self:stopTimerByID(self.daytimer)
self.daytimer=nil
end
if today<len then
local func=function()
local time=timeHelper.getServerShortTime()
local zeroTime=timeHelper.convertShortStamp(timeHelper.getTodayZeroStamp()+86400)
for i=today+1,len do
local item=grids[i-1]
local dayTime=(i-today-1)*86400+(zeroTime-time)

local timeStr=""
if dayTime>=86400 then


local day=math.ceil(dayTime/86400)
timeStr=FMT.fmt("{0}天后",day)
else
timeStr=timeHelper.format_time_stamp(dayTime,true)
end
item:SetChildText(8,timeStr)

end
end
self.daytimer=self:setTimer(1,-1,func)
end
if not dataRecv then
self:refreshActor()
end
end


function UISubAct_QianDaoWin_KPBL:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
self:refreshRemainingTimeTimer()
end

self.timer=self:setTimer(1,0,func)

self:refreshRemainingTimeTimer()
end


function UISubAct_QianDaoWin_KPBL:refreshRemainingTimeTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actid,self.subType,self.subid)
if time>0 then

local time_str=FMT.fmt('活动剩余时间：<color=#f1ce78>{0}</color>',timeHelper.format_time_stamp11(time,true))
self.timeText:setText(time_str)
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
self:onCloseBtn()
end
end



function UISubAct_QianDaoWin_KPBL:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end





function UISubAct_QianDaoWin_KPBL:onCloseBtn()
if self.activityArgs.parentWin then
UIManager:callWindowFunc(self.activityArgs.parentWin,"onBtnClose")
else
self:closeSelf()
end
end


function UISubAct_QianDaoWin_KPBL:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight})
end