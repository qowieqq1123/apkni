







def_class("UISubAct_HuiYingPinTuWin",UIWindowBase)









function UISubAct_HuiYingPinTuWin:bindComponents()

self.root=UIObject.get(self,0)
self.actytime=UIText.get(self,1)
self.bgimg=UIImage.get(self,2)
self.mencengimg=UIImage.get(self,3)
self.itemlist=UIObject.get(self,4)
self.item1=UIObject.get(self,5)
self.item2=UIObject.get(self,6)
self.item3=UIObject.get(self,7)
self.item4=UIObject.get(self,8)
self.item5=UIObject.get(self,9)
self.item6=UIObject.get(self,10)
self.item7=UIObject.get(self,11)
self.item8=UIObject.get(self,12)
self.item9=UIObject.get(self,13)
self.item10=UIObject.get(self,14)
self.item11=UIObject.get(self,15)
self.item12=UIObject.get(self,16)
self.item13=UIObject.get(self,17)
self.item14=UIObject.get(self,18)
self.item15=UIObject.get(self,19)
self.item16=UIObject.get(self,20)
self.item17=UIObject.get(self,21)
self.item18=UIObject.get(self,22)
self.item19=UIObject.get(self,23)
self.item20=UIObject.get(self,24)
self.item21=UIObject.get(self,25)
self.item22=UIObject.get(self,26)
self.item23=UIObject.get(self,27)
self.item24=UIObject.get(self,28)
self.commonGoodItem1=UIObject.get(self,29)
self.commonGoodItem2=UIObject.get(self,30)
self.commonGoodItem3=UIObject.get(self,31)
self.taskScroller=UIObject.get(self,32)
self.tasktitle=UIText.get(self,33)
self.time=UIText.get(self,34)
self.rulebtn=UIButton.get(self,35)
self.allrewardbtn=UIButton.get(self,36)
self.progressBar=UIProgress.get(self,37)
self.rewardList=UIObject.get(self,38)
self.scoreText=UIText.get(self,39)
self.tipspanel=UIObject.get(self,40)
self.nexttxt=UIText.get(self,41)
self.bgModel=UIObject.get(self,42)
self.txtpanel=UIObject.get(self,43)
self.unlocktxtpanel=UIObject.get(self,44)
self.unlocktxttips=UIText.get(self,45)
self.bxbtns=UIButton.get(self,46)
self.openpintubtns=UIButton.get(self,47)
self.opennewpanel=UIObject.get(self,48)
self.pintubtn=UIButton.get(self,49)
self.bxeffect=UIObject.get(self,50)
self.kqReddot=UIImage.get(self,51)
self.effectRoot=UIObject.get(self,52)

self.rulebtn:setButtonClick(function()self:onRulebtn()end)

self.allrewardbtn:setButtonClick(function()self:onAllrewardbtn()end)

self.bxbtns:setButtonClick(function()self:onBxbtns()end)

self.openpintubtns:setButtonClick(function()self:onOpenpintubtns()end)

self.pintubtn:setButtonClick(function()self:onPintubtn()end)



end


function UISubAct_HuiYingPinTuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.actytime);self.actytime=nil;
_UIObject_release(self.bgimg);self.bgimg=nil;
_UIObject_release(self.mencengimg);self.mencengimg=nil;
_UIObject_release(self.itemlist);self.itemlist=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.item5);self.item5=nil;
_UIObject_release(self.item6);self.item6=nil;
_UIObject_release(self.item7);self.item7=nil;
_UIObject_release(self.item8);self.item8=nil;
_UIObject_release(self.item9);self.item9=nil;
_UIObject_release(self.item10);self.item10=nil;
_UIObject_release(self.item11);self.item11=nil;
_UIObject_release(self.item12);self.item12=nil;
_UIObject_release(self.item13);self.item13=nil;
_UIObject_release(self.item14);self.item14=nil;
_UIObject_release(self.item15);self.item15=nil;
_UIObject_release(self.item16);self.item16=nil;
_UIObject_release(self.item17);self.item17=nil;
_UIObject_release(self.item18);self.item18=nil;
_UIObject_release(self.item19);self.item19=nil;
_UIObject_release(self.item20);self.item20=nil;
_UIObject_release(self.item21);self.item21=nil;
_UIObject_release(self.item22);self.item22=nil;
_UIObject_release(self.item23);self.item23=nil;
_UIObject_release(self.item24);self.item24=nil;
_UIObject_release(self.commonGoodItem1);self.commonGoodItem1=nil;
_UIObject_release(self.commonGoodItem2);self.commonGoodItem2=nil;
_UIObject_release(self.commonGoodItem3);self.commonGoodItem3=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.tasktitle);self.tasktitle=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.rulebtn);self.rulebtn=nil;
_UIObject_release(self.allrewardbtn);self.allrewardbtn=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.scoreText);self.scoreText=nil;
_UIObject_release(self.tipspanel);self.tipspanel=nil;
_UIObject_release(self.nexttxt);self.nexttxt=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.txtpanel);self.txtpanel=nil;
_UIObject_release(self.unlocktxtpanel);self.unlocktxtpanel=nil;
_UIObject_release(self.unlocktxttips);self.unlocktxttips=nil;
_UIObject_release(self.bxbtns);self.bxbtns=nil;
_UIObject_release(self.openpintubtns);self.openpintubtns=nil;
_UIObject_release(self.opennewpanel);self.opennewpanel=nil;
_UIObject_release(self.pintubtn);self.pintubtn=nil;
_UIObject_release(self.bxeffect);self.bxeffect=nil;
_UIObject_release(self.kqReddot);self.kqReddot=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
end

















local _this
local _Count=24
local StateType=
{
unlock=0,
doing=1,
finished=2,
reward=3,
}
local taskItemIndex={
nBoxImg=0,
oBoxImg=1,
goBtn=2,
rewardBtn=3,
gotFlag=4,
rewards=5,
progressbar=6,
name=7,
changebtn=8,
rewarditem=9,
}

local rewardCmpIndex={
targetScore=0,
gotFlag=1,
boxImg=2,
reddot=3,
pointSelect=4,
}
local abName="ui/windows/activities/sub_huiyingpintu/huiyingpintu_atlas_pak.ab"
local abNametwo="ui/windows/activities/sub_wanbaojianshangact/wanbaojianshangact_box_atlas_pak.ab"


function UISubAct_HuiYingPinTuWin:onLoaded(...)
self:bindComponents()
_this=self
self.itemSParry=
{
self.item1,self.item2,self.item3,self.item4,self.item5,self.item6,
self.item7,self.item8,self.item9,self.item10,self.item11,self.item12,
self.item13,self.item14,self.item15,self.item16,self.item17,self.item18,
self.item19,self.item20,self.item21,self.item22,self.item23,self.item24,
}
self.rewardarrys={self.commonGoodItem1,self.commonGoodItem2,self.commonGoodItem3}
self.debrisTypeData={}
for i=1,_Count do
self.debrisTypeData[#self.debrisTypeData+1]=StateType.unlock
end
self.animations={}
end


function UISubAct_HuiYingPinTuWin:__delete()
self:unbindComponents()
self.isOver=nil
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
if self.pintuleftTimer then
self:stopTimerByID(self.pintuleftTimer)
self.pintuleftTimer=nil
end
self:cleanAllAnimationTween()
_this=nil
end




function UISubAct_HuiYingPinTuWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self.startday=self.sub_actInfo.start_day_idx
self.start_time=self.sub_actInfo.start_time
self.end_time=self.sub_actInfo.end_time

if self.sub_actInfo then
local leftTime=self.sub_actInfo:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(leftTime,true)))
else
self.time:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(leftTime,true)))
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end
else
self.time:setText("活动已结束")
self.isOver=true
if self.leftTimer then
self:stopTimerByID(self.leftTimer)
self.leftTimer=nil
end
end

end)
else
self.time:setText("活动已结束")
self.isOver=true
end
self.max_task_len=cfg_paintedpuzzleactivityconfig_get(_this.subid).max_task_len or 3

self.boxPunchTweener={}
self.boxDelayTimerList={}
self.punchIntervalTime=2
self:stopAllBoxPunch()

self.bgModel:setChildUIModelShowTarget(5209,1,{},eAnimationID.stand,false,false,0,nil)

self:initDebris()
self:PinTuRewards()
self:refreshDebris()
self:refreshGridReddot()
self:refreshTask()
self:refreshProgress()
self:checkOpenNewPinTu()

end
local _format=string.format
local _floor=math.floor
function UISubAct_HuiYingPinTuWin.format_time_stamp2(inteval)
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

if DD>0 then
return _format('%s天%s时%s分',DD,HH,mm)
else
if HH>0 then
return _format('%s时%s分',HH,mm)
else
if mm>0 then
return _format('%s分%s秒',mm,SS)
else
return _format('%s秒',SS)
end
end
end
end
function UISubAct_HuiYingPinTuWin.format_time_stamp3(inteval)
local SS=inteval%60
local cc=_floor(inteval/60)
local mm=cc%60
cc=_floor(cc/60)
local HH=cc%24
cc=_floor(cc/24)
local DD=cc

if DD>0 then
return _format('%s天%s时%s分',DD,HH,mm)
else
if HH>0 then
return _format('%s时%s分',HH,mm)
else
if mm>0 then
return _format('%s分%s秒',mm,SS)
else
return _format('%s秒',SS)
end
end
end
end


function UISubAct_HuiYingPinTuWin:onHide()
self:stopAllBoxPunch()
end




function UISubAct_HuiYingPinTuWin:reseatDebrisTypeData()

self.debrisTypeData={}
for i=1,_Count do
self.debrisTypeData[#self.debrisTypeData+1]=StateType.unlock
end
for k,v in ipairs(self.itemSParry)do
local widget=v:getWidgetBase()
widget:SetChildShowEffect(6,0,false)
local item=widget:GetChildWidgetBase(3)
item:SetChildActive(3,false)
end

self:setLingqupnael(false)
self:setkaiqipnael(false)
self.tipspanel:setActive(false)
self.opennewpanel:setActive(false)
if self.pintuleftTimer then
self:stopTimerByID(self.pintuleftTimer)
self.pintuleftTimer=nil
end
end


function UISubAct_HuiYingPinTuWin:checkOpenNewPinTu()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local debrisList=mydata.debrisList
local puzzle_id=mydata.puzzle_id
local recv_puzzle_id=mydata.recv_puzzle_id
local recvList=mydata.recvList
local cfg_puzzle=cfg_paintedpuzzleactivityconfig_get(_this.subid).puzzle
local isfinish=#debrisList>=_Count


if isfinish and#recvList>=24 then

if#cfg_puzzle==puzzle_id and#cfg_puzzle==recv_puzzle_id then
_this.tipspanel:setActive(false)
_this.txtpanel:setActive(false)
_this.unlocktxtpanel:setActive(true)
_this:setLingqupnael(false)
_this:setkaiqipnael(false)
end

if#cfg_puzzle==puzzle_id and#cfg_puzzle~=recv_puzzle_id then
_this.tipspanel:setActive(false)
_this.txtpanel:setActive(false)
_this.unlocktxtpanel:setActive(false)
_this:setLingqupnael(true)
end

if#cfg_puzzle~=puzzle_id then
local sub_actInfo=activitiesModel:getSubActInfo(_this.actID,_this.subType,_this.subid)

local startday=sub_actInfo:getOpenDayIndex()
local nextday=cfg_puzzle[puzzle_id+1][1]
_this.tipspanel:setActive(false)
_this.txtpanel:setActive(false)
_this.unlocktxtpanel:setActive(false)

if startday>=nextday then

if puzzle_id==recv_puzzle_id then
_this:setLingqupnael(false)
_this:setkaiqipnael(true)
else
_this:setLingqupnael(true)
_this:setkaiqipnael(false)
end
else

_this.tipspanel:setActive(true)
_this:setkaiqipnael(false)
if puzzle_id==recv_puzzle_id then
_this:setLingqupnael(false)
else
_this:setLingqupnael(true)
end

if _this.pintuleftTimer then
_this:stopTimerByID(_this.pintuleftTimer)
_this.pintuleftTimer=nil
end


local shenyutime2=timeHelper.getServerTodayPass()
local shicha_day2=nextday-startday-1
if shicha_day2>=1 then
shenyutime2=shicha_day2*24*60*60
end

local jintian=timeHelper.getTodayZeroStamp()
local mingtian=jintian+86400
_this.pintuleftTimer=_this:setTimer(1,-1,function()
local now=timeHelper.getServerLongTime()
local shenyutime=mingtian-now

local shicha_day=nextday-startday-1
if shicha_day>=1 then
shenyutime=shenyutime+shicha_day*24*60*60
end

if shenyutime>0 then
_this.nexttxt:setText(FMT.fmt('<color=#c82c2c>{0}</color>后解锁下一张拼图',UISubAct_HuiYingPinTuWin.format_time_stamp3(shenyutime)))
else
if _this.pintuleftTimer then
_this:stopTimerByID(_this.pintuleftTimer)
_this.pintuleftTimer=nil
end
_this.nexttxt:setText(FMT.fmt('可解锁下一张拼图'))

_this:checkOpenNewPinTu()
end
end)
end
end
end
end


function UISubAct_HuiYingPinTuWin:setLingqupnael(flag)
self.bxbtns:setActive(flag)
if flag then
self.bxeffect:setChildUIModelShowTarget(4112,1,nil,5)
self.tipspanel:setActive(false)
self.txtpanel:setActive(false)
end
end

function UISubAct_HuiYingPinTuWin:setkaiqipnael(flag)
self.opennewpanel:setActive(flag)
self.openpintubtns:setActive(flag)
self:dokqPunchRotation(flag)
end

function UISubAct_HuiYingPinTuWin:dokqPunchRotation(reddot)
if reddot then
if self.kqTweener==nil then
self.kqReddot:setRotation(0,0,0)
local tweener=self.kqReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.kqTweener=tweener
end
else
if self.kqTweener~=nil then
self.kqTweener:Complete()
self.kqTweener:Kill()
self.kqTweener=nil
self.kqReddot:setRotation(0,0,0)
end
end
end

function UISubAct_HuiYingPinTuWin:onBxbtns()
local json_str=jsonHelper.encode({4})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end

function UISubAct_HuiYingPinTuWin:onOpenpintubtns()


local json_str=jsonHelper.encode({5})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end


function UISubAct_HuiYingPinTuWin:initDebris()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local taskList=mydata.taskList
local debrisList={}
local doinglist={}
local finishedlist={}
local task_pools=cfg_paintedpuzzleactivityconfig_get(_this.subid).task_pools
if taskList and#taskList>0 then
for k,v in ipairs(taskList)do
local taskIndex=v.task_idx
local jindu=task_pools[taskIndex][1][2]
if v.task_progress>=jindu then
finishedlist[v.debris_idx]=v.debris_idx
else
doinglist[v.debris_idx]=v.debris_idx
end
end
end
for k,v in ipairs(mydata.debrisList)do
debrisList[v]=v
end

for i=1,_Count do
if debrisList then
if debrisList[i]then
self.debrisTypeData[i]=StateType.reward
end
end
if doinglist then
if doinglist[i]then
self.debrisTypeData[i]=StateType.doing
end
end
if finishedlist then
if finishedlist[i]then
self.debrisTypeData[i]=StateType.finished
end
end
end
end


function UISubAct_HuiYingPinTuWin:refreshDebris()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local puzzle_id=mydata.puzzle_id
local debrisList=mydata.debrisList

local puzzleimg=cfg_paintedpuzzleactivityconfig_get(_this.subid).puzzleimg
local _abName=FMT.fmt("ui/windows/activities/sub_huiyingpintu/sharedtextures/{0}.ab",puzzleimg[puzzle_id])

self.winlua:SetChildCSImageSprite(self.bgimg:getID(),_abName,puzzleimg[puzzle_id]or"image_pintuchahua1")
self.bgimg:setActive(true)

if#debrisList>=_Count then
self.itemlist:setActive(false)





else



self.itemlist:setActive(true)

local taskList=mydata.taskList
local cfg_reward=cfg_paintedpuzzleactivityconfig_get(_this.subid).debris
local debrisrewards={}
if taskList and#taskList>0 then
for k,v in ipairs(taskList)do
if v.debris_idx then
debrisrewards[v.debris_idx]=v.reward_idx
end
end
end

for k,v in ipairs(self.itemSParry)do
local widget=v:getWidgetBase()
local debrisstate=self.debrisTypeData[k]
widget:SetChildRotation(1,0,0,0)
widget:SetChildRotation(2,0,0,0)
widget:SetChildRotation(3,0,0,0)

widget:SetChildActive(0,true)
if debrisstate==StateType.unlock then
widget:SetChildActive(1,true)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildActive(4,false)
widget:SetChildButtonClick(5,function()
self:OnGridsClick(k)
end)

elseif debrisstate==StateType.doing then
widget:SetChildActive(1,false)
widget:SetChildActive(2,true)
widget:SetChildActive(3,true)
widget:SetChildActive(4,false)
local reward_id
if debrisrewards[k]then
reward_id=debrisrewards[k]
end
if reward_id then
local item=widget:GetChildWidgetBase(3)
local data=cfg_reward[puzzle_id][reward_id][1]


local rewardId=data[1]
local rewardNum=data[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
widget:SetChildButtonClick(5,function()
self:OnGridsClick(k)
end)
end

elseif debrisstate==StateType.finished then
widget:SetChildActive(1,false)
widget:SetChildActive(2,true)
widget:SetChildActive(3,true)
widget:SetChildActive(4,false)
local reward_id
if debrisrewards[k]then
reward_id=debrisrewards[k]
end
if reward_id then
local item=widget:GetChildWidgetBase(3)
local data=cfg_reward[puzzle_id][reward_id][1]
local rewardId=data[1]
local rewardNum=data[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetChildAnimationStringID(3,"xianshu_light",true)
item:SetChildActive(3,true)
widget:SetChildButtonClick(5,function()
self:OnGridsClick(k)
end)
end

elseif debrisstate==StateType.reward then
widget:SetChildActive(0,false)
end
end
end
end


function UISubAct_HuiYingPinTuWin:refreshGridSinglebyUnlock(debrisindexArry)

local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local cfg_reward=cfg_paintedpuzzleactivityconfig_get(_this.subid).debris
local puzzle_id=mydata.puzzle_id
local taskList=mydata.taskList
local debris_rewards={}
if taskList and#taskList>0 then
for k,v in ipairs(taskList)do
if v.debris_idx then
debris_rewards[v.debris_idx]=v.reward_idx
end
end
end
for k,v in ipairs(debrisindexArry)do
local taskindex=v.task_idx
local taskprogress=v.task_progress
local debrisindex=v.debris_idx
local rewardindex=v.reward_idx
if debris_rewards[debrisindex]then
local widget=self.itemSParry[debrisindex]:getWidgetBase()
local debrisstate=self.debrisTypeData[debrisindex]

if debrisstate==StateType.unlock then


self:doAnimationTween(debrisindex)

widget:SetChildActive(2,true)
widget:SetChildActive(3,true)
widget:SetChildActive(4,false)
local item=widget:GetChildWidgetBase(3)
local data=cfg_reward[puzzle_id][rewardindex][1]
local rewardId=data[1]
local rewardNum=data[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
self.debrisTypeData[debrisindex]=StateType.doing
elseif debrisstate==StateType.doing then

local task_pools=cfg_paintedpuzzleactivityconfig_get(_this.subid).task_pools
local jindu=task_pools[taskindex][1][2]
if taskprogress>=jindu then
widget:SetChildActive(1,false)
widget:SetChildActive(2,true)
widget:SetChildActive(3,true)
widget:SetChildActive(4,false)
local item=widget:GetChildWidgetBase(3)
local data=cfg_reward[puzzle_id][rewardindex][1]
local rewardId=data[1]
local rewardNum=data[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetChildAnimationStringID(3,"xianshu_light",true)
item:SetChildActive(3,true)
self.debrisTypeData[debrisindex]=StateType.finished
end
end
end
end
self:refreshGridReddot()
end


function UISubAct_HuiYingPinTuWin:refreshGridSinglebyReward(debrisindex)
local widget=self.itemSParry[debrisindex]:getWidgetBase()
widget:SetChildActive(0,false)
self.debrisTypeData[debrisindex]=StateType.reward
self:refreshGridReddot()
end


function UISubAct_HuiYingPinTuWin:refreshGridReddot()
local isreddot=activitiesHandle_huiyingpintu.checkdebrisreddot(_this.actID,_this.subType,_this.subid)
if isreddot then
for i=1,_Count do
local debrisstate=self.debrisTypeData[i]
if debrisstate==StateType.unlock then
local widgetnew=self.itemSParry[i]:getWidgetBase()
widgetnew:SetChildActive(4,true)
_this.reddotidx=i
break
end
end
else
if _this.reddotidx then
local widgetnew=self.itemSParry[_this.reddotidx]:getWidgetBase()
widgetnew:SetChildActive(4,false)
end
end
end


function UISubAct_HuiYingPinTuWin:OnGridsClick(debrisindex)
local debrisstate=self.debrisTypeData[debrisindex]
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local taskList=mydata.taskList


if debrisstate==StateType.unlock then
if#taskList<_this.max_task_len then


local json_str=jsonHelper.encode({3,debrisindex})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
else
UIManager.info('当前可领取的任务数量已达上限')
end


elseif debrisstate==StateType.doing then
local cfg_reward=cfg_paintedpuzzleactivityconfig_get(_this.subid).debris
local puzzle_id=mydata.puzzle_id
local reward_id
if taskList and#taskList>0 then
for k,v in ipairs(taskList)do
if v.debris_idx and v.debris_idx==debrisindex then
reward_id=v.reward_idx
break
end
end
end
if reward_id then
local data=cfg_reward[puzzle_id][reward_id][1]
if data and data[1]then
self:onRewardItemClick(data[1])
end
end


elseif debrisstate==StateType.finished then
local task_pools=cfg_paintedpuzzleactivityconfig_get(_this.subid).task_pools
local task_idx=0
if taskList and#taskList>0 then
for k,v in ipairs(taskList)do
local taskIndex=v.task_idx
local jindu=task_pools[taskIndex][1][2]
if v.task_progress>=jindu then
if v.debris_idx==debrisindex then
task_idx=k
break
end
end
end
end
if task_idx>0 then
self:onClickRewardBtn(task_idx)
end
end
end


function UISubAct_HuiYingPinTuWin:PinTuRewards()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local puzzle_id=mydata.puzzle_id
local debrisList=mydata.debrisList
local recv_puzzle_id=mydata.recv_puzzle_id
local rewardList=cfg_paintedpuzzleactivityconfig_get(_this.subid).puzzle_rewards
local rewards=rewardList[puzzle_id]
for i,item in ipairs(_this.rewardarrys)do
local data=rewards[i]
if data then
item:setActive(true)
local widget=item:getWidgetBase()
local rewardId=data[1]
local rewardNum=data[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local isfinish=#debrisList>=_Count
local isreward=puzzle_id==recv_puzzle_id
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,
showname=false,showStage=true,colorEffect=isfinish and not isreward}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function()
if _this==nil then return end
self:onRewardPinTuClick(rewardId,isfinish,isreward)
end)
else
item:setActive(false)
end
end
end


function UISubAct_HuiYingPinTuWin:onRewardPinTuClick(itemId,isfinish,isreward)




if itemId then
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end

end


function UISubAct_HuiYingPinTuWin:onRewardItemClick(itemId,itemIndex)
if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end


function UISubAct_HuiYingPinTuWin:refreshTask()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local taskList=mydata.taskList
local debrisList=mydata.debrisList
local task_pools=cfg_paintedpuzzleactivityconfig_get(_this.subid).task_pools
local cfg_reward=cfg_paintedpuzzleactivityconfig_get(_this.subid).debris
local puzzle_id=mydata.puzzle_id
local dataNum=#taskList
local colorStr=dataNum<_this.max_task_len and"549327"or"FF0000FF"
self.tasktitle:setText(FMT.fmt('任务清单<color=#{0}>({1}/{2})</color>',colorStr,dataNum,_this.max_task_len))

if dataNum<=0 then
self.taskScroller:setActive(false)
local isfinish=#debrisList>=_Count
self.txtpanel:setActive(not isfinish)
self.unlocktxtpanel:setActive(false)
else
self.txtpanel:setActive(false)
self.unlocktxtpanel:setActive(false)
self.opennewpanel:setActive(false)

local isfinish=#debrisList>=_Count
if isfinish then
self:checkOpenNewPinTu()
return
end
self.taskScroller:setActive(true)
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count

for i=1,count do
local item=grids[i-1]
if item then
local taskIndex=taskList[i].task_idx
local taskdata=task_pools[taskIndex]

local desc=taskdata[3]
item:SetChildText(taskItemIndex.name,desc)

local cur=taskList[i].task_progress
local need=taskdata[1][2]
if cur>need then
cur=need
end
item:SetChildProgressValue(taskItemIndex.progressbar,cur,need)
item:SetChildProgressText(taskItemIndex.progressbar,FMT.fmt('{0}/{1}',mathHelper.formatNumber(cur),mathHelper.formatNumber(need)))

local jumpParam=taskdata[4]
local isfinish=cur>=need
local showGoBtn=jumpParam~=nil
item:SetChildActive(taskItemIndex.goBtn,not isfinish and showGoBtn)
item:SetChildActive(taskItemIndex.rewardBtn,isfinish)
item:SetChildButtonClick(taskItemIndex.rewardBtn,function()
if _this==nil then return end
self:onClickRewardBtn2(i)
end)
item:SetChildButtonClick(taskItemIndex.goBtn,function()
if _this==nil then return end
self:onClickGoBtn(jumpParam)
end)

item:SetChildActive(taskItemIndex.changebtn,not isfinish)
item:SetChildButtonClick(taskItemIndex.changebtn,function()
if _this==nil then return end
self:onClickChangeBtn(i)
end)


local widget=item:GetChildWidgetBase(taskItemIndex.rewarditem)
local data=cfg_reward[puzzle_id][taskList[i].reward_idx][1]
local rewardId=data[1]
local rewardNum=data[2]
local countStr=rewardNum>1 and mathHelper.formatNumber(rewardNum)or''
local showCountBG=rewardNum>1
local conf={itemid=rewardId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true,colorEffect=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)






widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function()
if _this==nil then return end
self:onClickTaskItem(isfinish,i,rewardId)
end)

end
end
end
end


function UISubAct_HuiYingPinTuWin:onClickTaskItem(isfinish,task_id,rewardId)



self:onRewardItemClick(rewardId)

end


function UISubAct_HuiYingPinTuWin:onClickGoBtn(jumpParam)
















if jumpParam then
local jumpId=jumpParam.id
if jumpId then
local backFlag=nil
if jumpId==JUMP_TYPE.eShiLianTa then
backFlag=JUMP_BACK.eForceBack
elseif jumpId==JUMP_TYPE.eDouFaTai then
backFlag=JUMP_BACK.eNoBack
end
jumpManager:jump(jumpParam,nil,backFlag)
end
end
end


function UISubAct_HuiYingPinTuWin:onClickRewardBtn2(i)
if i then


local task_id=i

if task_id then
local json_str=jsonHelper.encode({6})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
end
end


function UISubAct_HuiYingPinTuWin:onClickRewardBtn(task_id)
if task_id then
local json_str=jsonHelper.encode({6})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
end


function UISubAct_HuiYingPinTuWin:onClickChangeBtn(taskid)
if taskid then
UIManager:showWindow('UISubAct_HYPTTaskWin',{actID=_this.actID,subType=_this.subType,subid=_this.subid,task_id=taskid})
end
end


function UISubAct_HuiYingPinTuWin:onAllrewardbtn()
UIManager:showWindow('UIHYPT_rewardWin',{actID=_this.actID,subType=_this.subType,subid=_this.subid})
end


function UISubAct_HuiYingPinTuWin:onPintubtn()
UIManager:showWindow('UIHYPTTuJianWin',{actID=_this.actID,subType=_this.subType,subid=_this.subid})
end


function UISubAct_HuiYingPinTuWin:onRulebtn()
local d={}
d.title='绘影拼图规则'
d.mode=3
d.name='HuiYingPinTuWin_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UISubAct_HuiYingPinTuWin:refreshProgress()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local progress_rewards=cfg_paintedpuzzleactivityconfig_get(_this.subid).debris_progress_rewards
local debrisList=mydata.debrisList
local has_recv_idx=mydata.has_recv_idx
local debris_progress=mydata.debris_progress

local targetCount=#progress_rewards
local nowValue=0
local boxCfgList=progress_rewards
local lastTargetScore=0
local nowScore=debris_progress

for i,v in ipairs(boxCfgList)do
local targetScore=v[1]
if nowScore>=targetScore then
nowValue=nowValue+1/targetCount
else
nowValue=nowValue+(nowScore-lastTargetScore)/(targetScore-lastTargetScore)*(1/targetCount)
break
end
lastTargetScore=targetScore
end


local temp={0,0.15,0.3,0.38,0.5,0.62,0.7,0.85,1}
local temp2={0,0.3,0.5,0.7,1}
local temp3={0.15,0.37,0.61,0.85,1}
local idx=1
local ishalf=false
for k,v in ipairs(boxCfgList)do
if debris_progress==v[1]then
idx=k
ishalf=false
end
if debris_progress>v[1]then
idx=k
ishalf=true
end
if idx==5 then
ishalf=false
end
end

if ishalf then
self.winlua:SetChildProgressValue(self.progressBar:getID(),temp3[idx]*100,100)
else
self.winlua:SetChildProgressValue(self.progressBar:getID(),temp2[idx]*100,100)
end



local strScore=FMT.fmt('{0}/{1}',nowScore,boxCfgList[#boxCfgList][1])
self.scoreText:setText(strScore)

local doPunchList={}
local hasNewPunch=false

local girds=self.rewardList:getChildCommonLayoutGroupWidgetList()
for i=1,girds.Count do
local widget=girds[i-1]
local boxCfg=boxCfgList[i]
if boxCfg then
widget:SetChildActive(-1,true)

local boxIconName=FMT.fmt('button_lianbaodahui_bx{0}',i)
if boxIconName then
widget:SetChildCSImageSprite(rewardCmpIndex.boxImg,abNametwo,boxIconName)
end


local targetScore=boxCfg[1]
widget:SetChildText(rewardCmpIndex.targetScore,targetScore)


local isGot=has_recv_idx>=i
widget:SetChildActive(rewardCmpIndex.gotFlag,isGot)

widget:SetChildImageExGray(rewardCmpIndex.boxImg,isGot)


widget:SetChildButtonClick(rewardCmpIndex.boxImg,function()
self:onClickRewardBox(i)
end)


local isFinish=nowScore>=targetScore
local isCanGet=isFinish and not isGot
widget:SetChildActive(rewardCmpIndex.reddot,isCanGet)
widget:SetChildActive(rewardCmpIndex.pointSelect,isFinish)


if isCanGet then
local isDoPunch=self:checkBoxDoPunch(i)
if not hasNewPunch and not isDoPunch then
hasNewPunch=true
end
table.insert(doPunchList,i)
else
self:setBoxDoPunchRotation(i,isCanGet)
end
else
widget:SetChildActive(-1,false)
end
end


if hasNewPunch then
self:stopAllBoxPunch()
end
for _,boxIndex in ipairs(doPunchList)do
self:setBoxDoPunchRotation(boxIndex,true)
end
end


function UISubAct_HuiYingPinTuWin:checkBoxDoPunch(boxIndex)
if self.boxPunchTweener and self.boxPunchTweener[boxIndex]~=nil then
return true
end
return false
end


function UISubAct_HuiYingPinTuWin:stopAllBoxPunch()
for boxIndex,tweener in pairs(self.boxPunchTweener)do
self:setBoxDoPunchRotation(boxIndex,false)
end
end

function UISubAct_HuiYingPinTuWin:clearBoxDelayTimerList(boxIndex)
if self.boxDelayTimerList[boxIndex]then
self:stopTimerByID(self.boxDelayTimerList[boxIndex])
self.boxDelayTimerList[boxIndex]=nil
end
end


function UISubAct_HuiYingPinTuWin:setBoxDoPunchRotation(boxIndex,isPunch)
local widget=self.rewardList:getChildCommonLayoutGroupWidgetItem(boxIndex-1)
if isPunch then
if self.boxPunchTweener[boxIndex]==nil then
self:clearBoxDelayTimerList(boxIndex)
widget:SetChildRotation(rewardCmpIndex.boxImg,0,0,0)
local tweener=widget:SetChildDOPunchRotation(rewardCmpIndex.boxImg,Vector3(0,0,10),1,5,1,function()
if _this==nil then return end
_this.boxDelayTimerList[boxIndex]=_this:delayDo(_this.punchIntervalTime,function()
if _this==nil then return end
if _this.boxPunchTweener[boxIndex]then
_this:setBoxDoPunchRotation(boxIndex,false)
return _this:setBoxDoPunchRotation(boxIndex,isPunch)
end
end)
end)
tweener:SetEase(_Ease.Linear)

self.boxPunchTweener[boxIndex]=tweener
end
else
if self.boxPunchTweener[boxIndex]~=nil then
self.boxPunchTweener[boxIndex]:Complete()
self.boxPunchTweener[boxIndex]:Kill()
self.boxPunchTweener[boxIndex]=nil
widget:SetChildRotation(rewardCmpIndex.boxImg,0,0,0)
end
self:clearBoxDelayTimerList(boxIndex)
end
end


function UISubAct_HuiYingPinTuWin:onClickRewardBox(index)
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local progress_rewards=cfg_paintedpuzzleactivityconfig_get(_this.subid).debris_progress_rewards
local debrisList=mydata.debrisList
local has_recv_idx=mydata.has_recv_idx
local debris_progress=mydata.debris_progress

local boxCfgList=progress_rewards
local boxCfg=boxCfgList[index]
local targetScore=boxCfg[1]
local rewards=boxCfg[2]or{}
local nowScore=debris_progress


local isFinish=nowScore>=targetScore

local isGot=has_recv_idx>=index


if isFinish and not isGot then

local json_str=jsonHelper.encode({1})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
else
local content=FMT.fmt("<color=#171311>解锁的碎片达到<color=#ca631d>{0}</color>可领取\n以下奖励：</color>",targetScore)
local args={
title='进度奖励',
rewardTitle=-1,
desc1=content,
rewards=rewards,
showCancel=false,
commitName='确定',
}
self:showWindow('UIDialougeRewardWin',args)
end





end


function UISubAct_HuiYingPinTuWin:doAnimationTween(index)
local cardWidget=_this.itemSParry[index]:getWidgetBase()
cardWidget:SetChildActive(1,true)
cardWidget:SetChildActive(2,true)
cardWidget:SetChildRotation(2,0,90,0)
cardWidget:SetChildRotation(3,0,90,0)
local sequence=Lua.SequenceProxy.New()
local tween1=cardWidget:SetChildDORotation(1,Vector3.up*270,0.25,DG.Tweening.RotateMode.FastBeyond360)
tween1:SetEase(DG.Tweening.Ease.Linear)
sequence:Append(tween1)
local tween2=cardWidget:SetChildDORotation(2,Vector3.zero,0.25,DG.Tweening.RotateMode.Fast)
tween2:SetEase(DG.Tweening.Ease.Linear)
sequence:Append(tween2)
local tween3=cardWidget:SetChildDORotation(3,Vector3.zero,0.25,DG.Tweening.RotateMode.Fast)
tween3:SetEase(DG.Tweening.Ease.Linear)
sequence:Append(tween3)
_this.animations[index]=sequence
_this:delayDo(0.7,function()
if _this==nil then return end
cardWidget:SetChildShowEffect(6,10413,true)
end)


AudioManager.playAudio(594)
end
function UISubAct_HuiYingPinTuWin:cleanAllAnimationTween()
if _this.animations and#_this.animations>0 then
for i,v in pairs(_this.animations)do
if v:IsActive()then
v:Kill()
end
end
end
end


function UISubAct_HuiYingPinTuWin:setpintumap()
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)

local debrisList=mydata.debrisList



if#debrisList>=_Count then
_this.itemlist:setActive(false)





_this.bxbtns:setActive(false)
_this.winlua:SetChildShowEffect(_this.effectRoot:getID(),10756,true)
_this:delayDo(1,function(...)




_this.bxbtns:setActive(true)
_this.bxeffect:setChildUIModelShowTarget(4112,1,nil,5)
end)
end
end


function UISubAct_HuiYingPinTuWin:OpeanPrizeWin()
local data=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
if data==nil then return end

local list=data.specialPrize or{}


local conf={}
for i,v in ipairs(list)do
table.insert(conf,{itemid=v.itemid,num=v.num})
end

showPrizeControl.showWindow(conf,function()

UISubAct_yunchengtanbaoWin:continueRun(nil)
end)
end
