







def_class("UISubAct_fuxinggaozhao_Win",UIWindowBase)









function UISubAct_fuxinggaozhao_Win:bindComponents()

self.buttonReward=UIButton.get(self,0)
self.finRoot=UIObject.get(self,1)
self.gameRoot=UIObject.get(self,2)
self.gametext=UIText.get(self,3)
self.helpBtn=UIButton.get(self,4)
self.itemGrid=UIObject.get(self,5)
self.itemPanel=UIObject.get(self,6)
self.jiang_1=UIObject.get(self,7)
self.jiang_2=UIObject.get(self,8)
self.jiang_3=UIObject.get(self,9)
self.luckyNum=UIText.get(self,10)
self.luckyNumRoot=UIObject.get(self,11)
self.model=UIObject.get(self,12)
self.npcModel=UIObject.get(self,13)
self.num_now_1=UIObject.get(self,14)
self.num_now_2=UIObject.get(self,15)
self.num_now_3=UIObject.get(self,16)
self.num_now_4=UIObject.get(self,17)
self.num_now_5=UIObject.get(self,18)
self.num_now_6=UIObject.get(self,19)
self.num_now2_1=UIObject.get(self,20)
self.num_now2_2=UIObject.get(self,21)
self.num_now2_3=UIObject.get(self,22)
self.num_now2_4=UIObject.get(self,23)
self.num_now2_5=UIObject.get(self,24)
self.num_now2_6=UIObject.get(self,25)
self.numItem_1=UIObject.get(self,26)
self.numItem_2=UIObject.get(self,27)
self.numItem_3=UIObject.get(self,28)
self.numItem_4=UIObject.get(self,29)
self.numItem_5=UIObject.get(self,30)
self.numItem_6=UIObject.get(self,31)
self.numItem2_1=UIObject.get(self,32)
self.numItem2_2=UIObject.get(self,33)
self.numItem2_3=UIObject.get(self,34)
self.numItem2_4=UIObject.get(self,35)
self.numItem2_5=UIObject.get(self,36)
self.numItem2_6=UIObject.get(self,37)
self.playButton=UIButton.get(self,38)
self.replayButton=UIButton.get(self,39)
self.replayRoot=UIObject.get(self,40)
self.replaytext=UIText.get(self,41)
self.rewardRoot=UIObject.get(self,42)
self.root=UIObject.get(self,43)
self.speakObj=UIObject.get(self,44)
self.speakText=UIText.get(self,45)
self.time=UIText.get(self,46)
self.titleRoot=UIObject.get(self,47)
self.zhongjiangText=UIText.get(self,48)
self.zhongjiangText2=UIText.get(self,49)

self.buttonReward:setButtonClick(function()self:onButtonReward()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.playButton:setButtonClick(function()self:onPlayButton()end)

self.replayButton:setButtonClick(function()self:onReplayButton()end)
self.jiang={
self.jiang_1,
self.jiang_2,
self.jiang_3,
}
self.num_now={
self.num_now_1,
self.num_now_2,
self.num_now_3,
self.num_now_4,
self.num_now_5,
self.num_now_6,
}
self.num_now2={
self.num_now2_1,
self.num_now2_2,
self.num_now2_3,
self.num_now2_4,
self.num_now2_5,
self.num_now2_6,
}
self.numItem={
self.numItem_1,
self.numItem_2,
self.numItem_3,
self.numItem_4,
self.numItem_5,
self.numItem_6,
}
self.numItem2={
self.numItem2_1,
self.numItem2_2,
self.numItem2_3,
self.numItem2_4,
self.numItem2_5,
self.numItem2_6,
}


self.spriteAnim_fuxinggaozhaonum_1=0

end


function UISubAct_fuxinggaozhao_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buttonReward);self.buttonReward=nil;
_UIObject_release(self.finRoot);self.finRoot=nil;
_UIObject_release(self.gameRoot);self.gameRoot=nil;
_UIObject_release(self.gametext);self.gametext=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.itemGrid);self.itemGrid=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.jiang_1);self.jiang_1=nil;
_UIObject_release(self.jiang_2);self.jiang_2=nil;
_UIObject_release(self.jiang_3);self.jiang_3=nil;
_UIObject_release(self.luckyNum);self.luckyNum=nil;
_UIObject_release(self.luckyNumRoot);self.luckyNumRoot=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.num_now_1);self.num_now_1=nil;
_UIObject_release(self.num_now_2);self.num_now_2=nil;
_UIObject_release(self.num_now_3);self.num_now_3=nil;
_UIObject_release(self.num_now_4);self.num_now_4=nil;
_UIObject_release(self.num_now_5);self.num_now_5=nil;
_UIObject_release(self.num_now_6);self.num_now_6=nil;
_UIObject_release(self.num_now2_1);self.num_now2_1=nil;
_UIObject_release(self.num_now2_2);self.num_now2_2=nil;
_UIObject_release(self.num_now2_3);self.num_now2_3=nil;
_UIObject_release(self.num_now2_4);self.num_now2_4=nil;
_UIObject_release(self.num_now2_5);self.num_now2_5=nil;
_UIObject_release(self.num_now2_6);self.num_now2_6=nil;
_UIObject_release(self.numItem_1);self.numItem_1=nil;
_UIObject_release(self.numItem_2);self.numItem_2=nil;
_UIObject_release(self.numItem_3);self.numItem_3=nil;
_UIObject_release(self.numItem_4);self.numItem_4=nil;
_UIObject_release(self.numItem_5);self.numItem_5=nil;
_UIObject_release(self.numItem_6);self.numItem_6=nil;
_UIObject_release(self.numItem2_1);self.numItem2_1=nil;
_UIObject_release(self.numItem2_2);self.numItem2_2=nil;
_UIObject_release(self.numItem2_3);self.numItem2_3=nil;
_UIObject_release(self.numItem2_4);self.numItem2_4=nil;
_UIObject_release(self.numItem2_5);self.numItem2_5=nil;
_UIObject_release(self.numItem2_6);self.numItem2_6=nil;
_UIObject_release(self.playButton);self.playButton=nil;
_UIObject_release(self.replayButton);self.replayButton=nil;
_UIObject_release(self.replayRoot);self.replayRoot=nil;
_UIObject_release(self.replaytext);self.replaytext=nil;
_UIObject_release(self.rewardRoot);self.rewardRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.titleRoot);self.titleRoot=nil;
_UIObject_release(self.zhongjiangText);self.zhongjiangText=nil;
_UIObject_release(self.zhongjiangText2);self.zhongjiangText2=nil;
self.jiang=nil;
self.num_now=nil;
self.num_now2=nil;
self.numItem=nil;
self.numItem2=nil;
end



















local _this
local callbacklist=
{
[littleGameType.eLianLianKan]=
{
finCallback=function(result,remainTime)

local cfgtime=_this.config.time
local time=cfgtime[2]
local numberTime=_this.config.numberTime[2]
if result==1 then
_this.needRefresh=true
activitiesHandle_fuxinggaozhao:send_play(_this.actid,_this.subid,numberTime>=(time-remainTime)and 2 or 1)
end
end,
startCallback=function()

end,
},

[littleGameType.eTuLingGuiWei]=
{

finCallback=function(result,remainTime)

local cfgtime=_this.config.time
local time=cfgtime[2]
local numberTime=_this.config.numberTime[2]
if result==1 then
_this.needRefresh=true
activitiesHandle_fuxinggaozhao:send_play(_this.actid,_this.subid,numberTime>=(time-remainTime)and 2 or 1)
end
end,
startCallback=function()

end,
},
[littleGameType.eGuHeJieMi]=
{

finCallback=function(result,remainTime)

local cfgtime=_this.config.time
local time=cfgtime[2]
local numberTime=_this.config.numberTime[2]
if result==1 then
_this.needRefresh=true
activitiesHandle_fuxinggaozhao:send_play(_this.actid,_this.subid,numberTime>=(time-remainTime)and 2 or 1)
end
end,
startCallback=function()

end,
},
[littleGameType.eWanBaoJianShang]=
{

finCallback=function(result,score,remainTime)
local cfgtime=_this.config.time
local time=cfgtime[2]
local numberTime=_this.config.numberTime[2]

if result==1 then
_this.needRefresh=true
activitiesHandle_fuxinggaozhao:send_play(_this.actid,_this.subid,numberTime>=(time-remainTime)and 2 or 1)
end
end,
startCallback=function()

end,
}
}


function UISubAct_fuxinggaozhao_Win:onLoaded(...)
self:bindComponents()
_this=self
self.rollNumItemCount=6
notifySystem:listenNotify(notifyConfig.serverZoneFresh,function()
for i=1,3 do
self:refreshTopPanel(i)
end
end)
self.model:setChildUIModelShowTarget(4117,1,{},eAnimationID.stand,false,nil,0)
self.npcModel:setChildUIModelShowTarget(4015,0.2,{},eAnimationID.stand,false,false,0)
self.npcModel:setChildUIModelShowTargetOffset(0,0)
self.npcModel:setChildUIModelShowFlipX(true)
self.numTable={0,9,8,7,6,5,4,3,2,1}
self.numTableIndexList_lookup={}
self.numNowSelectIndex={1,1,1,1,1,1}
self.numCount=#self.numTable
local count=#self.numTable
for i=1,count do
local num=self.numTable[i]
self.numTableIndexList_lookup[num]=i
end
local rollParam=cfgHelper.getdef(cfg_fuxinggaozhaoconfig)or{}
self.delayStartRollTime=rollParam.delayStartRollTime or 0
self.speedLowTime=rollParam.speedLowTime or 4
self.maxSpeed=rollParam.maxSpeed or 35
self.delayTime=rollParam.delayTime or 0.1
self.baseRoundCount=rollParam.baseRoundCount or 1
self.addRoundCount=rollParam.addRoundCount or 1

notifySystem:listenNotify(notifyConfig.closeUI,self.onCloseUI)

self:rewardAnim()
end


function UISubAct_fuxinggaozhao_Win:__delete()
self:unbindComponents()

notifySystem:removelistener(notifyConfig.closeUI,self.onCloseUI)
_this=nil
end

function UISubAct_fuxinggaozhao_Win.onCloseUI(name)
if not _this then return end
if name=='UICommonShowPrizeWin'and _this.needRefresh then
_this:onRefresh(_this.animIndex)
_this.needRefresh=nil
end
end




function UISubAct_fuxinggaozhao_Win:onShow(argtable,afterOnloaded)
self.activityArgs=argtable
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eFuXingGaoZhao
self.subid=argtable.sub_act_id
if argtable.extraParams then
self.jumpIdx=argtable.extraParams.jumpIndex
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)

if self.config.numberTime[1]==1 then
self.gametext:setText(string.format("<color=#c4562a>%d次</color>内完成挑战解锁额外号码",self.config.numberTime[2]))
self.replaytext:setText(string.format("<color=#c4562a>%d次</color>内完成挑战解锁额外号码",self.config.numberTime[2]))
else
self.gametext:setText(string.format("<color=#c4562a>%d秒</color>内完成挑战解锁额外号码",self.config.numberTime[2]))
self.replaytext:setText(string.format("<color=#c4562a>%d秒</color>内完成挑战解锁额外号码",self.config.numberTime[2]))
end
self:onRefresh()

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if self.info then
local leftTime=self.info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(leftTime)))
else
self.time:setText("活动已结束")
self.isOver=true
end
self.leftTimer=self:setTimer(1,-1,function()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
if info then
local leftTime=info:getEndLeftTime()
if leftTime>0 then
self.time:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(leftTime)))
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
end
end

function UISubAct_fuxinggaozhao_Win:rewardAnim()
self.rewardTween=self.buttonReward:setChildDOLocalMoveX(165,0.8,nil)
self.rewardTween:SetLoops(-1,_LoopType.Yoyo)
end

function UISubAct_fuxinggaozhao_Win:onRefresh(animIndex)
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)

for i=1,3 do
self:refreshTopPanel(i)
end

self:refreshOwnPanel(data,animIndex)
end

function UISubAct_fuxinggaozhao_Win:onRecv(animIndex)
self.animIndex=animIndex
self:onRefresh(animIndex)
end

function UISubAct_fuxinggaozhao_Win:refreshTopPanel(index)
local data=activitiesModel:getSubActInfoData(self.actid,self.subType,self.subid)
local reward=self.config.reward[index]
local ranklist=data.ranklist or{}
local rankData=ranklist[index]
local jiangRoot=self.jiang[index]
local widget=jiangRoot:getWidgetBase()
if widget then
if rankData then
local num=rankData.number
local iconInfo=rankData.iconInfo
local server=rankData.serverid
local actorname=rankData.actorname
local serverName=loginModel:getServerName(server)
widget:SetChildText(8,FMT.fmt("<color=#7d3b17>[{0}]</color>\n{1}",serverName,actorname))
widget:SetChildActive(9,false)
widget:SetChildActive(6,true)
playerController:setImage(widget,6,nil,iconInfo)
for i=1,6 do
local n=math.floor(num/(10^(6-i))%10)
widget:SetChildText(i-1,n)
end
else
for i=1,6 do
widget:SetChildText(i-1,"？")
end
widget:SetChildText(8,"")
widget:SetChildActive(9,true)
widget:SetChildActive(6,false)
end

if reward then
local conf={itemid=reward[1][1],itemcount=reward[1][2]>1 and reward[1][2]or'',showCountBG=reward[1][2]>1,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(7,prop)
widget:SetBaseItemClickEvent(7,itemsComponentHelper.onItemClick)
end

end
end

function UISubAct_fuxinggaozhao_Win:refreshOwnPanel(data,animIndex)
local luckynum=data.luckynum
local isKaiJiang=luckynum>=0
local ownList=data.ownList or{}
local len=#ownList

local haveNumber=len>0
self.luckyNum:setText(luckynum)
if haveNumber then
if isKaiJiang then
self.luckyNumRoot:setActive(true)
self.titleRoot:setActive(false)
self.finRoot:setActive(false)
self.rewardRoot:setActive(true)
self.gameRoot:setActive(false)
self.replayRoot:setActive(false)

self:refreshJackpot()
else
self.finRoot:setActive(true)
self.titleRoot:setActive(false)
self.replayRoot:setActive(true)
self.gameRoot:setActive(false)
self.luckyNumRoot:setActive(false)
self.rewardRoot:setActive(false)
end
else
self.finRoot:setActive(false)
self.titleRoot:setActive(true)
self.replayRoot:setActive(false)
self.gameRoot:setActive(true)
self.rewardRoot:setActive(false)
self.luckyNumRoot:setActive(false)
end

if haveNumber then
local own1=ownList[1]
local own2=ownList[2]
if not animIndex then
if own1 then
local number=own1.number
local valid=own1.valid
for i=1,6 do
local num=math.floor(number/(10^(6-i))%10)
local widget=self.numItem[i]:getWidgetBase()

self:roll2Num(self.num_now[i],num,0)
widget:SetChildGray(0,valid==0)
end

end
if own2 then
local number=own2.number
local valid=own2.valid
for i=1,6 do
local num=math.floor(number/(10^(6-i))%10)
local widget=self.numItem2[i]:getWidgetBase()


self:roll2Num(self.num_now2[i],num,0)
widget:SetChildGray(0,valid==0)
end
else
for i=1,6 do
local widget=self.numItem2[i]:getWidgetBase()
self:roll2Num(self.num_now2[i],10,0)
widget:SetChildGray(0,false)
end
end
else
if own1 then
local valid=own1.valid
local number=own1.number
for i=1,6 do
local widget=self.numItem[i]:getWidgetBase()
widget:SetChildGray(0,valid==0)
local num=math.floor(number/(10^(6-i))%10)
if animIndex==1 or animIndex==3 then
self:roll2Num(self.num_now[i],10,0)
self:delayDo((7-i)*0.5,function()
self:roll2Num(self.num_now[i],num,2)
end)
else
self:roll2Num(self.num_now[i],num,0)
end
end
end
if own2 then
local valid=own2.valid
local number=own2.number

for i=1,6 do
local widget=self.numItem2[i]:getWidgetBase()
widget:SetChildGray(0,valid==0)
local num=math.floor(number/(10^(6-i))%10)
if animIndex==2 then
self:roll2Num(self.num_now2[i],10,0)
self:delayDo((7-i)*0.5,function()
self:roll2Num(self.num_now2[i],num,2)
end)
elseif animIndex==3 then
self:roll2Num(self.num_now2[i],10,0)
self:delayDo((8-i)*0.5,function()
self:roll2Num(self.num_now2[i],num,2)
end)
else
self:roll2Num(self.num_now2[i],num,0)
end
end
else
for i=1,6 do
local widget=self.numItem2[i]:getWidgetBase()
self:roll2Num(self.num_now2[i],10,0)
widget:SetChildGray(0,false)
end
end
end
else
for i=1,6 do
local widget=self.numItem[i]:getWidgetBase()
self:roll2Num(self.num_now[i],10,0)
widget:SetChildGray(0,false)
end
for i=1,6 do
local widget=self.numItem2[i]:getWidgetBase()
self:roll2Num(self.num_now2[i],10,0)
widget:SetChildGray(0,false)
end
end
end

function UISubAct_fuxinggaozhao_Win:refreshJackpot()
local info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)
local ownJackpot=info:getOwnJackpot()
local rankJackpot=info:getRankJackpot()
local rewardList={}
local reward=self.config.reward
if next(rankJackpot)then
if ownJackpot then
self.zhongjiangText:setText(FMT.fmt("恭喜您中了{0}等奖和幸运号码！",mathHelper.numberToChinese(rankJackpot[1])))
self.zhongjiangText2:setText("这是您的奖励")
for i,v in ipairs(rankJackpot)do
local jr=reward[v]
for _,r in ipairs(jr)do
table.insert(rewardList,r)
end
end
for i,v in ipairs(reward[5])do
table.insert(rewardList,{v[1],v[2]*ownJackpot})
end
else
self.zhongjiangText:setText(FMT.fmt("福星高照！恭喜您中了{0}等奖！",mathHelper.numberToChinese(rankJackpot[1])))
self.zhongjiangText2:setText("这是您的奖励")
rewardList=reward[rankJackpot[1]]
end
else
if ownJackpot then
self.zhongjiangText:setText("恭喜您中了幸运号码！")
self.zhongjiangText2:setText("这是您的奖励")
rewardList=table.deepCopy(reward[4])
for i,v in ipairs(reward[5])do
table.insert(rewardList,{v[1],v[2]*ownJackpot})
end
else
self.zhongjiangText:setText("很遗憾本期您没有中奖")
self.zhongjiangText2:setText("这是您的奖励，下期继续加油")
rewardList=reward[4]
end
end

local isBuy=info.data.recv==1

local num=#rewardList
local refreshCB=function(i,items)
local item=items[i]
local r=rewardList[i+1]

local conf={itemid=r[1],showCountBG=r[2]>1,itemcount=r[2]>1 and r[2]or'',showStage=true,showname=false,itemIndex=i}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetBaseItemClickEvent(2,function()
self:onClickItem(i+1,r[1],isBuy)
end)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isBuy
prop[PropIndex(DataPropKey.eWidgetActive,10)]=not isBuy
item:SetChildPropData(2,prop)
item:SetChildActive(0,isBuy)
end

if num>3 then
self.itemPanel:setChildScrollViewCreateGrids(num,num)
local items=self.itemPanel:getChildScrollViewItemWidgets()
for i=0,items.Count-1 do
refreshCB(i,items)
end
else
self.itemGrid:setChildLayoutGroupCreateItems(num)
local items=self.itemGrid:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
refreshCB(i,items)
end
end

end

function UISubAct_fuxinggaozhao_Win:onClickItem(index,itemid,isBuy)
if isBuy then
itemsComponentHelper.onItemClick(itemid,index)
else
activitiesHandle_fuxinggaozhao:send_get_reward(self.actid,self.subid)
end
end


function UISubAct_fuxinggaozhao_Win:onHide()

end

function UISubAct_fuxinggaozhao_Win:Set1()
self.needRefresh=true
activitiesHandle_fuxinggaozhao:send_play(self.actid,self.subid,1)
end
function UISubAct_fuxinggaozhao_Win:Set2()
self.needRefresh=true
activitiesHandle_fuxinggaozhao:send_play(self.actid,self.subid,2)
end

function UISubAct_fuxinggaozhao_Win:Set3()

self.winlua:SetChildSpriteAnimationPrefabIndex(self.num_now[1]:getID(),0,true)
self:delayDo(2,function()
local SpriteAnimation=self.num_now[1]:getCommonComponent('SpriteAnimationPlayer')
if SpriteAnimation then
SpriteAnimation:Stop()
SpriteAnimation:SetCurrentFrame(2)
end
end)
end



function UISubAct_fuxinggaozhao_Win:roll2Num(numRoot,num,time)
self.winlua:SetChildSpriteAnimationPrefabIndex(numRoot:getID(),0,true)
local cb=function()
local SpriteAnimation=numRoot:getCommonComponent('SpriteAnimationPlayer')
if SpriteAnimation then
SpriteAnimation:Stop()
SpriteAnimation:SetCurrentFrame(2+(6*num))
end
end
if time==0 then
cb()
else
self:delayDo(time,cb)
end
end





function UISubAct_fuxinggaozhao_Win:onPlayButton()
local mapGroup=self.config.mapGroup
local cfgtime=self.config.time
local time=cfgtime[2]
local numberTime=self.config.numberTime[2]

local mapId=mapGroup[math.random(1,#mapGroup)]

local finCallback=callbacklist[cfgtime[1]].finCallback
local startCallback=callbacklist[cfgtime[1]].startCallback
UILittleGameController:openLittleGame(cfgtime[1],{mapId=mapId,time=time},finCallback,startCallback)
end



function UISubAct_fuxinggaozhao_Win:onHelpBtn()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_fuxinggaozhao_help_%s'})
end

function UISubAct_fuxinggaozhao_Win:onReplayButton()
self:onPlayButton()
end

function UISubAct_fuxinggaozhao_Win:onButtonReward()
local args={}
args.title='挑战奖励'
args.desc='挑战成功可获得以下奖励'
local reward=self.config.reward[6]
args.rewards=reward
self:showWindow('UICommonRewardShowWin',args)
end
