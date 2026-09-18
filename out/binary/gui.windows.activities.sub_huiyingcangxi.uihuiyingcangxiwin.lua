







def_class("UIHuiYingCangXiWin",UIWindowBase)









function UIHuiYingCangXiWin:bindComponents()

self.areaItem3_1=UIImage.get(self,0)
self.areaItem3_2=UIImage.get(self,1)
self.areaItem3_3=UIImage.get(self,2)
self.areaItem5_1=UIImage.get(self,3)
self.areaItem5_2=UIImage.get(self,4)
self.areaItem5_3=UIImage.get(self,5)
self.areaItem5_4=UIImage.get(self,6)
self.areaItem5_5=UIImage.get(self,7)
self.areaItem6_1=UIImage.get(self,8)
self.areaItem6_2=UIImage.get(self,9)
self.areaItem6_3=UIImage.get(self,10)
self.areaItem6_4=UIImage.get(self,11)
self.areaItem6_5=UIImage.get(self,12)
self.areaItem6_6=UIImage.get(self,13)
self.areaPanel_3=UIObject.get(self,14)
self.areaPanel_5=UIObject.get(self,15)
self.areaPanel_6=UIObject.get(self,16)
self.bigReward=UIObject.get(self,17)
self.huiguBtn=UIButton.get(self,18)
self.iconImg=UIButton.get(self,19)
self.leftBtn=UIButton.get(self,20)
self.leftReddot=UIObject.get(self,21)
self.lockClick=UIButton.get(self,22)
self.lockClickText=UIText.get(self,23)
self.lockPanel=UIObject.get(self,24)
self.lockTitle=UIText.get(self,25)
self.lockTxt=UIText.get(self,26)
self.mbg=UIObject.get(self,27)
self.mbg2=UIObject.get(self,28)
self.progressbar=UIProgress.get(self,29)
self.rightBtn=UIButton.get(self,30)
self.rightReddot=UIObject.get(self,31)
self.rolea=UIObject.get(self,32)
self.roleb=UIObject.get(self,33)
self.rolec=UIObject.get(self,34)
self.roled=UIObject.get(self,35)
self.rolePanel=UIObject.get(self,36)
self.root=UIObject.get(self,37)
self.ScreenTitleText=UIText.get(self,38)
self.tansuoBtn=UIButton.get(self,39)
self.tansuoReddot=UIObject.get(self,40)
self.timeBg=UIObject.get(self,41)
self.timeTxt=UIText.get(self,42)
self.titieImg=UIImage.get(self,43)
self.xiufuBtn=UIButton.get(self,44)
self.xiufuReddot=UIObject.get(self,45)

self.huiguBtn:setButtonClick(function()self:onHuiguBtn()end)

self.iconImg:setButtonClick(function()self:onIconImg()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.lockClick:setButtonClick(function()self:onLockClick()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.tansuoBtn:setButtonClick(function()self:onTansuoBtn()end)

self.xiufuBtn:setButtonClick(function()self:onXiufuBtn()end)
self.areaItem3={
self.areaItem3_1,
self.areaItem3_2,
self.areaItem3_3,
}
self.areaItem5={
self.areaItem5_1,
self.areaItem5_2,
self.areaItem5_3,
self.areaItem5_4,
self.areaItem5_5,
}
self.areaItem6={
self.areaItem6_1,
self.areaItem6_2,
self.areaItem6_3,
self.areaItem6_4,
self.areaItem6_5,
self.areaItem6_6,
}
self.areaPanel={
[3]=self.areaPanel_3,
[5]=self.areaPanel_5,
[6]=self.areaPanel_6,
}



end


function UIHuiYingCangXiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.areaItem3_1);self.areaItem3_1=nil;
_UIObject_release(self.areaItem3_2);self.areaItem3_2=nil;
_UIObject_release(self.areaItem3_3);self.areaItem3_3=nil;
_UIObject_release(self.areaItem5_1);self.areaItem5_1=nil;
_UIObject_release(self.areaItem5_2);self.areaItem5_2=nil;
_UIObject_release(self.areaItem5_3);self.areaItem5_3=nil;
_UIObject_release(self.areaItem5_4);self.areaItem5_4=nil;
_UIObject_release(self.areaItem5_5);self.areaItem5_5=nil;
_UIObject_release(self.areaItem6_1);self.areaItem6_1=nil;
_UIObject_release(self.areaItem6_2);self.areaItem6_2=nil;
_UIObject_release(self.areaItem6_3);self.areaItem6_3=nil;
_UIObject_release(self.areaItem6_4);self.areaItem6_4=nil;
_UIObject_release(self.areaItem6_5);self.areaItem6_5=nil;
_UIObject_release(self.areaItem6_6);self.areaItem6_6=nil;
_UIObject_release(self.areaPanel_3);self.areaPanel_3=nil;
_UIObject_release(self.areaPanel_5);self.areaPanel_5=nil;
_UIObject_release(self.areaPanel_6);self.areaPanel_6=nil;
_UIObject_release(self.bigReward);self.bigReward=nil;
_UIObject_release(self.huiguBtn);self.huiguBtn=nil;
_UIObject_release(self.iconImg);self.iconImg=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.leftReddot);self.leftReddot=nil;
_UIObject_release(self.lockClick);self.lockClick=nil;
_UIObject_release(self.lockClickText);self.lockClickText=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.lockTitle);self.lockTitle=nil;
_UIObject_release(self.lockTxt);self.lockTxt=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.mbg2);self.mbg2=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.rightReddot);self.rightReddot=nil;
_UIObject_release(self.rolea);self.rolea=nil;
_UIObject_release(self.roleb);self.roleb=nil;
_UIObject_release(self.rolec);self.rolec=nil;
_UIObject_release(self.roled);self.roled=nil;
_UIObject_release(self.rolePanel);self.rolePanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScreenTitleText);self.ScreenTitleText=nil;
_UIObject_release(self.tansuoBtn);self.tansuoBtn=nil;
_UIObject_release(self.tansuoReddot);self.tansuoReddot=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.titieImg);self.titieImg=nil;
_UIObject_release(self.xiufuBtn);self.xiufuBtn=nil;
_UIObject_release(self.xiufuReddot);self.xiufuReddot=nil;
self.areaItem3=nil;
self.areaItem5=nil;
self.areaItem6=nil;
self.areaPanel=nil;
end
















local this

local eventType=
{
Plot=1,
Adventure=2,
}

local eventHandle={
[eventType.Plot]=
{
enter=function(window,muralIdx)
muralIdx=muralIdx or 0
window:openPlot(muralIdx)
end
},
[eventType.Adventure]=
{
enter=function(window,muralIdx)
muralIdx=muralIdx or 0
window:openQiyu(muralIdx)
end
},
}

local roleindex=
{
npcmodel=0,
speakobj=1,
speaktxt=2,
}

local roleids={2004,2003,2002,2001}

local stringF=string.format




function UIHuiYingCangXiWin:onLoaded(...)
self:bindComponents()
this=self

self.selectTw={}
self.tweenerVal={}
self.rolelists={self.rolea,self.roleb,self.rolec,self.roled}

notifySystem:listenNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
end

function UIHuiYingCangXiWin.onItemListChanged(argsTable)
local fixCostLookup=this.info:getFixCostLookup()
for i,v in ipairs(argsTable)do
local itemid=v[3]
if fixCostLookup[itemid]~=nil then
this:refreshXiuFuReddot()
break
end
end
end

function UIHuiYingCangXiWin.onMoneyChanged(moneyType,oldVal,newVal)
local fixCostLookup=this.info:getFixCostLookup()
if fixCostLookup[moneyType]~=nil then
this:refreshXiuFuReddot()
end
end


function UIHuiYingCangXiWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.onItemListChanged)
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChanged)

self:clearSelectTw()
self.selectTw={}
self.tweenerVal={}

self:stopTick()

this=nil
end




function UIHuiYingCangXiWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.baseCfg=self.info:getMuralExpLoreBaseConfig()
self.fixBaseCfg=self.info:getMuralFixBaseConfig()


local curWhichAct=self.myData.mural_idx
self.isCompleted=self.info:isAllCompleted()

local CurScreenIsOpen=false
if not self.selectMuralIdx then

self.selectMuralIdx=curWhichAct
if not self.isCompleted then
CurScreenIsOpen=self.info:checkCurScreenIsOpen(curWhichAct+1)
end
if CurScreenIsOpen then
self.selectMuralIdx=curWhichAct+1
end
if self.selectMuralIdx==0 then
self.selectMuralIdx=1
end
if self.selectMuralIdx>#self.sub_actcfg.muralList then
self.selectMuralIdx=#self.sub_actcfg.muralList
end
end

local buid=self.sub_actcfg.BgId
self.mbg:setChildUIModelShowTarget(buid[1],1,nil,eAnimationID.stand,false,false,0,function()
end)
self.mbg2:setChildUIModelShowTarget(buid[2],1,nil,eAnimationID.stand,false,false,0,function()
end)

self:freshRolePanel()
self:refreshScreen()

if self.actTimer==nil then
local func=function()
self:refreshActTimer()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end
end

function UIHuiYingCangXiWin:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(time))
self.timeTxt:setText(time_str)
end



function UIHuiYingCangXiWin:onHide()

end


function UIHuiYingCangXiWin:refreshScreen(flag)
self.baseCfg=self.info:getMuralExpLoreBaseConfig(self.selectMuralIdx)

self.leftBtn:setActive(self.selectMuralIdx~=1)
self.rightBtn:setActive(self.selectMuralIdx~=#self.sub_actcfg.muralList)


local today=self.info:getStart2NowDay()

local screenAllCompleted=self.info:checkScreenAllCompleted(self.selectMuralIdx)

local CurScreenIsOpen=self.info:checkCurScreenIsOpen(self.selectMuralIdx)



local isLock=not CurScreenIsOpen or self.myData.mural_idx<self.selectMuralIdx

local title=self.baseCfg.title



local str=""
local strTitle="壁画尚处迷雾之中"
if not CurScreenIsOpen then
local Condition=self.sub_actcfg.openCDN[self.selectMuralIdx]
str=stringF("活动第%s天开启",Condition)
if Condition==today+1 then
str="明日开启"
else
local oldBaseCfg=self.info:getMuralExpLoreBaseConfig(self.selectMuralIdx-1)
str=stringF("完成【%s】后开启",oldBaseCfg.title)
strTitle="驱散迷雾"
end
self.lockClickText:setActive(false)
self.lockTxt:setActive(true)
self.lockPanel:setActive(true)
elseif self.myData.mural_idx<self.selectMuralIdx then
str=""
strTitle="驱散迷雾"
self.lockClickText:setActive(true)
self.lockTxt:setActive(false)
self.lockPanel:setActive(true)
else
self.lockPanel:setActive(false)
end

self.lockTxt:setText(str)

self.huiguBtn:setActive(screenAllCompleted)

self.tansuoBtn:setActive(not isLock and not screenAllCompleted)

self.xiufuBtn:setActive(not isLock)







self.ScreenTitleText:setText(title)

local iconNumber=isLock and 0 or self.baseCfg.icon
local _ab=stringF("ui/windows/activities/sub_huiyingcangxi/sharedtextures/image_hycx_bh%s.ab",iconNumber)
self.iconImg:setCSImageSprite(_ab,stringF("image_hycx_bh%s",iconNumber))

self.titieImg:setActive(not isLock)

self:UIProgress()



local leftReddotFlag=self.info:checkLeftScreenReddot(self.sub_actcfg,self.myData,self.selectMuralIdx)
local rightReddotFlag=self.info:checkRightScreenReddot(self.sub_actcfg,self.myData,self.selectMuralIdx)

self.leftReddot:setActive(leftReddotFlag)
self.rightReddot:setActive(rightReddotFlag)
self:refreshRewardPanel()
self:refreshXiuFuReddot()

local eventLen=#self.baseCfg.eventList+1
for i,v in pairs(self.areaPanel)do
v:setActive(eventLen==i)
end
local areaItemArr={}
if eventLen==3 then
areaItemArr=self.areaItem3
elseif eventLen==5 then
areaItemArr=self.areaItem5
elseif eventLen==6 then
areaItemArr=self.areaItem6
end

self:clearSelectTw(eventLen)
if not self.selectTw[eventLen]then
self.selectTw[eventLen]={}
end
if not self.tweenerVal[eventLen]then
self.tweenerVal[eventLen]={}
end

local dissovleFunc=function(widget,i,j)
local ablation_effect_duration=4
this.selectTw[i][j]=_DOTweenProxy.DoValueTo(
function()
return this.tweenerVal[i][j]or 0
end,
function(val)
this.tweenerVal[i][j]=val
this.widget:SetChildWidgetMaterialFloat(widget:getID(),'_DissovleProgress',val)
end,
1,ablation_effect_duration)

this:delayDo(ablation_effect_duration+0.05,function()
this.tweenerVal[i][j]=0
if this.selectTw[i][j]then
this.selectTw[i][j]:Kill()
this.selectTw[i][j]=nil
end
widget:setActive(false)
this.widget:SetChildWidgetMaterialFloat(widget:getID(),'_DissovleProgress',0)
end)
end

for i,v in ipairs(areaItemArr)do
if self.myData.mural_idx<self.selectMuralIdx then
v:setActive(true)
self.widget:SetChildWidgetMaterialFloat(v:getID(),'_DissovleProgress',0)
elseif self.myData.mural_idx>self.selectMuralIdx then
if not self.selectTw[eventLen][i]then
if flag then
dissovleFunc(v,eventLen,i)
else
v:setActive(false)
self.widget:SetChildWidgetMaterialFloat(v:getID(),'_DissovleProgress',0)
end
end
else
if i>self.myData.progress+1 then
v:setActive(true)
self.widget:SetChildWidgetMaterialFloat(v:getID(),'_DissovleProgress',0)
else
if not self.selectTw[eventLen][i]then
if flag then
dissovleFunc(v,eventLen,i)
else
v:setActive(false)
self.widget:SetChildWidgetMaterialFloat(v:getID(),'_DissovleProgress',0)
end
end
end
end
end
end

function UIHuiYingCangXiWin:refreshXiuFuReddot()
local xiufuReddotflag=self.info:checkAllFixReddot()
self.xiufuReddot:setActive(xiufuReddotflag)
end


function UIHuiYingCangXiWin:UIProgress()
local curExp=0
for i,v in ipairs(self.sub_actcfg.muralList)do
if self.myData.mural_idx>=i then
local baseCfg=self.info:getMuralExpLoreBaseConfig(i)
local progress=0
if self.myData.mural_idx>i then
progress=#baseCfg.eventList
elseif self.myData.mural_idx==i then
progress=self.myData.progress
end
for ii,vv in ipairs(baseCfg.eventList)do
if progress>=ii then
curExp=curExp+vv[4]
end
end
end
end
if self.myData.fix_list_len>0 then
for i,v in ipairs(self.myData.fix_list)do
local val=self.fixBaseCfg.fixConfig[v][3]or 0
curExp=curExp+val
end
end
local needExp=self.sub_actcfg.gressMax
self.progressbar:setProgressValue(curExp,needExp)
self.progressbar:setChildProgressText(FMT.fmt('{0}%',curExp/needExp*100))


end


function UIHuiYingCangXiWin:refreshRewardPanel()
local rewardList=self.sub_actcfg.rewards

self.isReceive=self.info:checkProgressIsReceive()

local item=self.bigReward:getChildWidgetBase()
local itemId,itemNum=unpack(rewardList[1])
local countStr=mathHelper.formatNumber(itemNum)
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=false,colorEffect=self.isReceive}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(0,function(...)
if self.isReceive then
call_activitiesHandle_func("activitiesHandle_huiyingcangxi","reqProtocol_ClaimReward",self.actID,self.subType,self.subid)
else
itemsComponentHelper.onItemClick(...)
end
end)
item:SetChildPropData(0,prop)

item:SetChildActive(1,self.myData.reward_flag==1)
item:SetChildActive(2,self.isReceive)

local baseItem=item:GetChildWidgetBase(0)
baseItem:SetChildActive(0,false)
end

function UIHuiYingCangXiWin:onButtonClick(delta)
if self.clickCD then
return
end

self.clickCD=true

self.selectMuralIdx=self.selectMuralIdx+delta
self.selectMuralIdx=math.max(1,math.min(self.selectMuralIdx,#self.sub_actcfg.muralList))

self:refreshScreen()

self:delayDo(0.2,function()
self.clickCD=false
end)
end


function UIHuiYingCangXiWin:openPlot(muralIdx)
local args={isFullOpen=false,}
local progress
if muralIdx>0 then
progress=self.myData.recap_list[muralIdx]and self.myData.recap_list[muralIdx].progress or 0
else
progress=self.myData.progress
end
local PlotID=self.baseCfg.eventList[progress+1][2]
local PlotCompletedCD=function()
if this then
call_activitiesHandle_func("activitiesHandle_huiyingcangxi","reqProtocol_PlotFlag",this.actID,this.subType,this.subid,muralIdx)
end
end
worldStoryController:showStoryTree(PlotID,PlotCompletedCD,nil,nil,args)
end


function UIHuiYingCangXiWin:openQiyu(muralIdx)
local qiyuId
if muralIdx>0 then
if self.myData.recap_list[muralIdx]then
qiyuId=self.myData.recap_list[muralIdx].qiyu_id
end
else
qiyuId=self.myData.qiyu_id
end

if qiyuId==nil or tonumber(tostring(qiyuId))==0 then

call_activitiesHandle_func("activitiesHandle_huiyingcangxi","reqProtocol_EventStart",self.actID,self.subType,self.subid,muralIdx)
else
local actID=this.actID
local subType=this.subType
local subid=this.subid
local func=function()
activitiesController:jump(actID,subType,subid)
end
MysteryEventSystem:showEventByGuid(SYSTEM_DEFINE.eCloudCityTreasure,qiyuId,{},true,func)
end
end


function UIHuiYingCangXiWin:onEventProtocol(muralIdx,newqiyuId)
if newqiyuId~=nil and tonumber(tostring(newqiyuId))~=0 then
self:openQiyu(muralIdx)
end

end

function UIHuiYingCangXiWin:freshRolePanel()
for k,v in ipairs(self.rolelists)do
local widget=v:getChildWidgetBase()
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(roleids[k])
local imageInfo=dizidata.imageInfo
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)

widget:SetChildUIModelShowTarget(roleindex.npcmodel,modelParams.body,0.9,modelParams.componets,0)
widget:SetChildUIModelShowFlipX(roleindex.npcmodel,true)
end

self:stopTick()
self.timer=self:setTimer(self.sub_actcfg.speakTime,-1,self.timeOutCall)
self:doSpeaking_playera()
end

function UIHuiYingCangXiWin:timeOutCall()
this:doSpeaking_playera()
end

function UIHuiYingCangXiWin:stopTick()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIHuiYingCangXiWin:doSpeaking_playera()
local speakList=self.sub_actcfg.speaks
local dzRand=math.random(1,#speakList)
local rand=math.random(1,#speakList[dzRand])
local speakStr=speakList[dzRand][rand]
local speed=30
local widget=self.rolelists[dzRand]:getChildWidgetBase()
widget:SetChildCanvasGroupAlpha(roleindex.speakobj,1)
widget:SetChildTrendsTextPlay(roleindex.speaktxt,speakStr,speed,nil)
self:doTalkAnim_playera(widget)
end
function UIHuiYingCangXiWin:doTalkAnim_playera(widget)
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
widget:SetChildScale(roleindex.speakobj,Vector3.zero)
self:delayDo(0.2,function()
widget:SetChildCanvasGroupAlpha(roleindex.speakobj,1)
self.talkTween=widget:SetChildDOScale(roleindex.speakobj,1.2,0.2,function()
if self==nil then return end
self.talkTween=nil
self.talkTween=widget:SetChildDOScale(roleindex.speakobj,0.9,0.1,function()
if self==nil then return end
self.talkTween=nil
return self:talkEnda(widget)
end)
end)
end)
end
function UIHuiYingCangXiWin:talkEnda(widget)
if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
self.speakShowTimer=self:delayDo(3.5,function()

if self==nil then return end
widget:SetChildScale(roleindex.speakobj,Vector3.zero)
widget:SetChildCanvasGroupAlpha(roleindex.speakobj,0)

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end)
end

function UIHuiYingCangXiWin:clearSelectTw(type)
for k,v in pairs(self.selectTw)do
if k~=type then
for kk,vv in pairs(v)do
if vv then
vv:Kill()
end
end
self.selectTw[k]={}
end
end
end




function UIHuiYingCangXiWin:onHuiguBtn()
local muralIdx=self.selectMuralIdx
local progress=self.myData.recap_list[muralIdx]and self.myData.recap_list[muralIdx].progress or 0
local curEventCfg=self.baseCfg.eventList[progress+1]
local newHandle=eventHandle[curEventCfg[1]]
if newHandle then
newHandle.enter(self,muralIdx);
end
end



function UIHuiYingCangXiWin:onLeftBtn()
self:onButtonClick(-1)
end



function UIHuiYingCangXiWin:onLockClick()
call_activitiesHandle_func("activitiesHandle_huiyingcangxi","reqProtocol_OpenMural",self.actID,self.subType,self.subid)
end



function UIHuiYingCangXiWin:onRightBtn()
self:onButtonClick(1)
end



function UIHuiYingCangXiWin:onTansuoBtn()
if self.myData.mural_idx~=self.selectMuralIdx then
return
end
local curEventCfg=self.baseCfg.eventList[self.myData.progress+1]
local newHandle=eventHandle[curEventCfg[1]]
if newHandle then
newHandle.enter(self);
end
end



function UIHuiYingCangXiWin:onXiufuBtn()
local tempArgtable={act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid}
self:showWindow('UIHuiYingCangXiRepairWin',tempArgtable)
end

function UIHuiYingCangXiWin:onIconImg()
local screenAllCompleted=self.info:checkScreenAllCompleted(self.selectMuralIdx)
if screenAllCompleted then
UIManager.info('此壁画已探索完成')
return
end
self:onTansuoBtn()
end

