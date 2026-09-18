







def_class("UIXianZhanEntrustWin",UIWindowBase)









function UIXianZhanEntrustWin:bindComponents()

self.acceptBtn=UIButton.get(self,0)
self.btnClose=UIButton.get(self,1)
self.click=UIObject.get(self,2)
self.completeBtn=UIButton.get(self,3)
self.completeImg=UIObject.get(self,4)
self.conditionItem=UIObject.get(self,5)
self.desc=UIText.get(self,6)
self.desc2=UIText.get(self,7)
self.FightMonster=UIObject.get(self,8)
self.frameAnim=UIObject.get(self,9)
self.goBtn=UIButton.get(self,10)
self.handInBtn=UIButton.get(self,11)
self.HandItem=UIObject.get(self,12)
self.icon=UIObject.get(self,13)
self.iconbg=UIImage.get(self,14)
self.iconbg2=UIObject.get(self,15)
self.iconTag=UIImage.get(self,16)
self.jingjie=UIText.get(self,17)
self.limitText=UIText.get(self,18)
self.mask=UIObject.get(self,19)
self.name=UIText.get(self,20)
self.progressBar=UIProgress.get(self,21)
self.rewardScrollview=UIObject.get(self,22)
self.root=UIObject.get(self,23)
self.scrollview=UIObject.get(self,24)
self.title=UIText.get(self,25)

self.acceptBtn:setButtonClick(function()self:onAcceptBtn()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.completeBtn:setButtonClick(function()self:onCompleteBtn()end)

self.goBtn:setButtonClick(function()self:onGoBtn()end)

self.handInBtn:setButtonClick(function()self:onHandInBtn()end)



end


function UIXianZhanEntrustWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.acceptBtn);self.acceptBtn=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.completeBtn);self.completeBtn=nil;
_UIObject_release(self.completeImg);self.completeImg=nil;
_UIObject_release(self.conditionItem);self.conditionItem=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.desc2);self.desc2=nil;
_UIObject_release(self.FightMonster);self.FightMonster=nil;
_UIObject_release(self.frameAnim);self.frameAnim=nil;
_UIObject_release(self.goBtn);self.goBtn=nil;
_UIObject_release(self.handInBtn);self.handInBtn=nil;
_UIObject_release(self.HandItem);self.HandItem=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.iconbg);self.iconbg=nil;
_UIObject_release(self.iconbg2);self.iconbg2=nil;
_UIObject_release(self.iconTag);self.iconTag=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.limitText);self.limitText=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.rewardScrollview);self.rewardScrollview=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.title);self.title=nil;
end

















local _this

local _iconAb=globalABLookup.global
local _iconBg={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_7",
}
local _iconTag={
[monType.LittleMonster]="",
[monType.EliteMonster]="icon_gwbz_3",
[monType.Boss]="icon_gwbz_2",
[monType.GodAnimal]="icon_gwbz_1",
}


function UIXianZhanEntrustWin:onLoaded(...)
_this=self
self:bindComponents()

if webGLHelper:isNeedAdaption()then
self.btnClose:setActive(false)
self.click:setActive(true)
end
end


function UIXianZhanEntrustWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianZhanEntrustWin:onShow(argtable,afterOnloaded)
self.roomId=argtable

local cb=function()
self:onLoadFinish()
end
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameAnim:setChildUIModelShowTarget(3037,1,{},eAnimationID.bd_stand,false,false,0,cb)
else
self.root:setChildCanvasGroupAlpha(0)
self.frameAnim:setChildModelAnimationState(eAnimationID.bd_stand)
cb()
end
end

function UIXianZhanEntrustWin:onLoadFinish()
self:refreshPanelState()
self:refreshSpeakText()
local func=function()
self.root:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.3,func)
end


function UIXianZhanEntrustWin:onHide()

end

function UIXianZhanEntrustWin:refreshPanelState()
self.data=xianzhanModel:getRoomDataByRoomId(self.roomId)
self.fkConfig=cfgHelper.get1(cfg_xianzhanfangkeconfig_get,self.data.customerId)
local entrustId=self.data.wtTaskId
self.config=cfgHelper.get1(cfg_xianzhanweituoconfig_get,entrustId)


local isComplete=self.data.wtTaskStaus==1

self.title:setText(self.config.name)
self.completeImg:setActive(isComplete)
self:refreshPanelInfo()
end

function UIXianZhanEntrustWin:refreshPanelInfo()
local showType=self.config.wtType
self.HandItem:setActive(showType==XIANZHAN_ENTRUST_TYPE.eHandItem)
self.FightMonster:setActive(showType==XIANZHAN_ENTRUST_TYPE.eFightMonster)
if showType==XIANZHAN_ENTRUST_TYPE.eHandItem then

self:refreshHandItem()
elseif showType==XIANZHAN_ENTRUST_TYPE.eFightMonster then

self:refreshFightMonster()
else

end
end

function UIXianZhanEntrustWin:refreshSpeakText()
local speakStr=self.config.talk or self.config.desc
local isComplete=self.data.wtTaskStaus==1
if isComplete then
local speakList=self.fkConfig.rewardSpeak
speakStr=speakList[math.random(1,#speakList)]
end
UIManager:invokeUIMethod('UIXianZhanInteractWin','refreshSpeakStr',speakStr)
end


function UIXianZhanEntrustWin:refreshFightMonster()
self.desc:setText(self.config.desc)
self.taskConfig=taskModel:getTaskConfig(self.config.taskId)
local params=self.taskConfig.params
local allowGo=true
local limitStr=''

local monsterLv=zongmenModel:getMonsterLevel()
local wtParam=self.config.wtParam
local typo=wtParam[1]
local name_str
if typo==1 then

local monsterId=params[2]
local sundriseCfg=cfgHelper.get1(cfg_monijyrandomitemconfig_get,monsterId)
name_str=sundriseCfg.name
local modelParams={}
modelParams.body=sundriseCfg.model[1]
modelParams.componets=sundriseCfg.model[2]
comHelper.setChildModelRawImageEx(self.icon:getID(),self.winlua,modelParams,eHeadCenterType.eHead)
else

local needUnlock,str=xianzhanModel:checkWorldBlockNeedUnlock(self.taskConfig,self.config)
allowGo=not needUnlock
limitStr=str
local tasktype=self.taskConfig.tasktype
if tasktype==102 or tasktype==17 then

local mjid=params[1]






local cfg_fb=cfg_secretscenefubenconfig_get(mjid)
name_str=cfg_fb.name
self.iconbg:setImageIcon(cfg_fb.image,false)
self.iconbg2:setActive(false)
elseif tasktype==103 then

local mubanid=params[3]
local mModleid=cfgHelper.get4(cfg_worldrestemplatedataconfig_get,mubanid,'data',1,2)
local groupid=cfgHelper.get2(cfg_worldresbattleconfig_get,mModleid,'groupid')
local groupConfig=cfgHelper.get1(cfg_monstergroup_get,groupid)
local monsterType=groupConfig.monType
name_str=groupConfig.name
comHelper.setChildModelRawImage_monsterGroup(self.winlua,groupid,self.icon:getID(),0,eHeadCenterType.eHead)
self.iconbg:setSprite(_iconAb,_iconBg[monsterType])
self.iconTag:setSprite(_iconAb,_iconTag[monsterType])

local point=worldResPointDataModel:findTaskData(self.config.taskId)
if point then
monsterLv=point.level
end
end
end
self.name:setText(FMT.fmt('名称：{0}',name_str or''))

self.jingjie:setText(FMT.fmt('境界：{0}','未知'))


local rewards=table.deepCopy(self.taskConfig.taskReward)or{}
table.insert(rewards,1,{xianzhanModel.showItemid,self.config.hgdVal})
local num=#rewards
self.scrollview:setChildScrollViewCreateGrids(num,5)
local grids=self.scrollview:getChildScrollViewItemWidgets()
for i=1,num do
local item=grids[i-1]
local widget=item:GetChildWidgetBase(0)
local count
local itemid
local conf
local reward=rewards[i]
itemid=reward[1]
count=reward[2]
local countStr=mathHelper.formatNumber(count)
conf={itemid=itemid,showCountBG=true,itemcount=countStr,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
tipsManager.showTips({itemid=itemid,move=TIPS_MOVE_POS.eLeft})
end)
end

local isAccepted=self.data.wtJieFlag==1
local isComplete=self.data.wtTaskStaus==1
local taskid=self.config.taskId
local taskData=taskModel:getTask(taskid)

local showAccept=not isAccepted and not isComplete and allowGo
self.acceptBtn:setActive(showAccept)

local showGo=isAccepted and not isComplete and taskData~=nil and taskModel:getTaskState_transfromstate(taskData)==taskModel.taskDoingState
showGo=showGo and allowGo
self.goBtn:setActive(showGo)

local showComplete=isAccepted and not isComplete and
((taskData~=nil and taskModel:getTaskState_transfromstate(taskData)==taskModel.taskRewardState)or taskModel:checkTaskFinish(taskid))
self.completeBtn:setActive(showComplete)

if not showGo and not showAccept and not showComplete and not allowGo then
self.limitText:setText(limitStr)
else
self.limitText:setText('')
end
end


function UIXianZhanEntrustWin:refreshHandItem()

local conditions=self.config.wtParam
local condition=conditions[1]
local conItemid=condition[1]
local need=condition[2]
local need_str=mathHelper.formatNumber4(need,1)
local conItem=self.conditionItem:getChildWidgetBase()
local conf={itemid=conItemid,itemcount=need_str,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
conItem:SetChildPropData(0,prop)
conItem:SetBaseItemClickEvent(0,function(...)
tipsManager.showTips({itemid=conItemid,move=TIPS_MOVE_POS.eLeft})
end)

local isComplete=self.data.wtTaskStaus==1
local showProgress=not isComplete
self.progressBar:setActive(showProgress)
if showProgress then
local have=0
if moneyConfig.isMoney(conItemid)then
have=moneyModel.getMoney(conItemid)
else
have=bagControl.invokeFuncByItemId(conItemid,'getItemCountByItemID',conItemid)
end
self.progressBar:setProgress(have,need)
local colorStr='#f9f9f9'
if have<need then
colorStr='#f63030'
end
local have_str=mathHelper.formatNumber4(have,1)
local countStr=FMT.fmt('<color={0}>{1}/{2}</color>',colorStr,have_str,need_str)
self.progressBar:setChildProgressText(countStr)
end

self.desc2:setText(self.config.desc)

local isComplete=self.data.wtTaskStaus==1
local showHandInBtn=not isComplete
self.handInBtn:setActive(showHandInBtn)
if showHandInBtn then
local canHandIn=self:checkHandIn()
self.handInBtn:setButtonEnable(canHandIn,not canHandIn)
end

local rewards=self.config.reward
local lastnum=#rewards+1
local hgdVal=self.config.hgdVal
self.rewardScrollview:setChildScrollViewCreateGrids(lastnum,5)
local grids2=self.rewardScrollview:getChildScrollViewItemWidgets()
for i=1,lastnum do
local item=grids2[i-1]
local widget=item:GetChildWidgetBase(0)
local count
local itemid
if i<lastnum then
local reward=rewards[i]
itemid=reward[1]
count=reward[2]
else
itemid=xianzhanModel.showItemid
count=hgdVal
end
local countStr=mathHelper.formatNumber(count)
local conf2={itemid=itemid,showCountBG=true,itemcount=countStr,showStage=true,showname=false}
local prop2=itemsComponentHelper.getCommonFillDataSmall(conf2)
widget:SetChildPropData(0,prop2)
widget:SetBaseItemClickEvent(0,function(...)
tipsManager.showTips({itemid=itemid,move=TIPS_MOVE_POS.eLeft})
end)
end
end

function UIXianZhanEntrustWin:checkHandIn(errorMsg)
local conditions=self.config.wtParam
for i,v in ipairs(conditions)do
local itemid=v[1]
local needCount=v[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if have<needCount then
if errorMsg then
UIManager.error('要求的道具数量不足')
gainControl:showGainWin(itemid)
end
return false
end
end
return true
end

function UIXianZhanEntrustWin:getRewardsConf()
local rewards=nil
local showType=self.config.wtType
if showType==XIANZHAN_ENTRUST_TYPE.eHandItem then

rewards=self.config.reward
elseif showType==XIANZHAN_ENTRUST_TYPE.eFightMonster then

rewards=self.taskConfig.taskReward
end
local conf={}
if rewards~=nil then
for i,v in ipairs(rewards)do
table.insert(conf,{itemid=v[1],num=v[2]})
end
end
return conf
end


function UIXianZhanEntrustWin:startRewardSpeak()
local speakList=self.fkConfig.rewardSpeak
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
self:refreshPanelState()

self.completeImg:setScale(Vector3(3,3,3))
self.completeImg:setChildDOScale(1,0.2,nil)

local func=function()
if _this==nil then return end
_this.mask:setActive(true)
local func2=function()
if _this==nil then return end
_this.mask:setActive(false)
end
xianzhanController:interactStartTalk({speakStr},func2,func2)
end
local conf=self:getRewardsConf()
if#conf>0 then
showPrizeControl.showWindowNow(conf,func)
else
func()
end
end



function UIXianZhanEntrustWin:onCloseClick()
xianzhanController:resetInreractSpeak()
xianzhanController:closeInteractAttachWin(XianZhanInteractType.eEntrust)
end

function UIXianZhanEntrustWin:onAcceptBtn()
xianzhanController:req_accept_entrust(self.roomId,self.data.wtTaskId)
end

function UIXianZhanEntrustWin:onGoBtn()
local taskId=self.taskConfig.id
xianzhanController:closeInteractWin()
xianzhanController:xianzhanTaskJump(taskId)
end

function UIXianZhanEntrustWin:onCompleteBtn()
xianzhanController:req_complete_entrust(self.roomId)
taskController:doGetTaskReward(self.config.taskId,false,true)
end

function UIXianZhanEntrustWin:onHandInBtn()
if self:checkHandIn(true)then
xianzhanController:req_complete_entrust(self.roomId)
end
end

function UIXianZhanEntrustWin:onClickMask()
UIManager:invokeUIMethod('UIXianZhanInteractWin','quicklyPlay')
end

function UIXianZhanEntrustWin:rec_acceptWT(roomId,wtId)
if self.roomId==roomId then
self:refreshPanelInfo()
end
end

function UIXianZhanEntrustWin:onBtnClose()
self:onCloseClick()
end