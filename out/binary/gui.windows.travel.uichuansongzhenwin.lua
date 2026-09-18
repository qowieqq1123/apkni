







def_class("UIChuanSongZhenWin",UIWindowBase)









function UIChuanSongZhenWin:bindComponents()

self.dropRoot=UIObject.get(self,0)
self.dropPool=UIGameobjectClone.new(self,1)
self.backBtn=UIButton.get(self,2)
self.areaList=UIScrollView.get(self,3)
self.flex_1=UIObject.get(self,4)
self.flex_2=UIObject.get(self,5)
self.rewardListBg=UIObject.get(self,6)
self.helpContent=UIText.get(self,7)
self.callbackJiyuanTx=UIText.get(self,8)
self.callbackBtn=UIButton.get(self,9)
self.callbackName=UIText.get(self,10)
self.callbackJingjieTx=UIText.get(self,11)
self.chatFlexBtn=UIButton.get(self,12)
self.chatReddot=UIObject.get(self,13)
self.buidlingUpReddot=UIObject.get(self,14)
self.rewardSelected=UIObject.get(self,15)
self.helpPanel=UIObject.get(self,16)
self.dialogBg=UIButton.get(self,17)
self.callbackPanel=UIObject.get(self,18)
self.chatItem=UIButton.get(self,19)
self.monsterRoot=UIObject.get(self,20)
self.discipleRoot=UIObject.get(self,21)
self.getBtn=UIButton.get(self,22)
self.rewards=UIObject.get(self,23)
self.buildingUpBtn=UIButton.get(self,24)
self.earningBtn=UIButton.get(self,25)
self.rewardBtn=UIButton.get(self,26)
self.descImg=UIImage.get(self,27)
self.backgroundRoot=UIObject.get(self,28)
self.chatScrollView=UIObject.get(self,29)
self.headList=UIObject.get(self,30)
self.helpBtn=UIButton.get(self,31)
self.storeTime=UIText.get(self,32)
self.dialogRoot=UIObject.get(self,33)
self.rewardList=UIObject.get(self,34)
self.chatContent=UIObject.get(self,35)
self.buildingLvTx=UIText.get(self,36)

self.backBtn:setButtonClick(function()self:onBackBtn()end)

self.callbackBtn:setButtonClick(function()self:onCallbackBtn()end)

self.chatFlexBtn:setButtonClick(function()self:onChatFlexBtn()end)

self.dialogBg:setButtonClick(function()self:onDialogBg()end)

self.chatItem:setButtonClick(function()self:onChatItem()end)

self.getBtn:setButtonClick(function()self:onGetBtn()end)

self.buildingUpBtn:setButtonClick(function()self:onBuildingUpBtn()end)

self.earningBtn:setButtonClick(function()self:onEarningBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)
self.flex={
self.flex_1,
self.flex_2,
}



end


function UIChuanSongZhenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dropRoot);self.dropRoot=nil;
self.dropPool:deleteSelf();self.dropPool=nil;
_UIObject_release(self.backBtn);self.backBtn=nil;
_UIObject_release(self.areaList);self.areaList=nil;
_UIObject_release(self.flex_1);self.flex_1=nil;
_UIObject_release(self.flex_2);self.flex_2=nil;
_UIObject_release(self.rewardListBg);self.rewardListBg=nil;
_UIObject_release(self.helpContent);self.helpContent=nil;
_UIObject_release(self.callbackJiyuanTx);self.callbackJiyuanTx=nil;
_UIObject_release(self.callbackBtn);self.callbackBtn=nil;
_UIObject_release(self.callbackName);self.callbackName=nil;
_UIObject_release(self.callbackJingjieTx);self.callbackJingjieTx=nil;
_UIObject_release(self.chatFlexBtn);self.chatFlexBtn=nil;
_UIObject_release(self.chatReddot);self.chatReddot=nil;
_UIObject_release(self.buidlingUpReddot);self.buidlingUpReddot=nil;
_UIObject_release(self.rewardSelected);self.rewardSelected=nil;
_UIObject_release(self.helpPanel);self.helpPanel=nil;
_UIObject_release(self.dialogBg);self.dialogBg=nil;
_UIObject_release(self.callbackPanel);self.callbackPanel=nil;
_UIObject_release(self.chatItem);self.chatItem=nil;
_UIObject_release(self.monsterRoot);self.monsterRoot=nil;
_UIObject_release(self.discipleRoot);self.discipleRoot=nil;
_UIObject_release(self.getBtn);self.getBtn=nil;
_UIObject_release(self.rewards);self.rewards=nil;
_UIObject_release(self.buildingUpBtn);self.buildingUpBtn=nil;
_UIObject_release(self.earningBtn);self.earningBtn=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.descImg);self.descImg=nil;
_UIObject_release(self.backgroundRoot);self.backgroundRoot=nil;
_UIObject_release(self.chatScrollView);self.chatScrollView=nil;
_UIObject_release(self.headList);self.headList=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.storeTime);self.storeTime=nil;
_UIObject_release(self.dialogRoot);self.dialogRoot=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.chatContent);self.chatContent=nil;
_UIObject_release(self.buildingLvTx);self.buildingLvTx=nil;
self.flex=nil;
end
















local _this=nil
local _areaCmp={
selected=0,
name=1,
reddot=2,
bg=3,
lock=4,
}
local _headCmp={
this=-1,
add=0,
head=1,
selected=2,
time=3,
}
local _ab="ui/windows/travel/travel_atlas_pak.ab"







local _spineCmp={
this=-1,
qian=0,
hou=1,
zhon1=2,
zhon2=3,
zhon3=4,
zhon4=5,
zhon5=6,
zhon6=7,
zhon7=8,
zhon8=9,
zhon9=10,
zhon10=11,


}
local _rotationSlot={
qian=80,
hou=500,
zhon1=84,
zhon2=89,
zhon3=95,
zhon4=102,
zhon5=110,
zhon6=119,
zhon7=129,
zhon8=400,
zhon9=400,
zhon10=400,
}
local _monsterPos={
{3,5.25,-1},{4.7,4.7,-1.25},{6.5,4.25,-1.7}
}
local _monsterPosDelta={6,-0.6,-1}
local _monsterScale=0.7
local _monsterNearPos={
{2,5.25,-1},{2.5,4.7,-1.25},{3,4.25,-1.7}
}
local _disciplePos={
{-1.5,5.25,-1},{-3,4.85,-1.5},{-4.5,4.75,-1}
}
local _discipleScale=1.4
local _discipleNearPos={
{-0.5,5.25,-1},{-1,4.7,-1.25},{-1.5,4.25,-1.7}
}
local _dropPos={
{85,-74},{135,-104},{130,-136}
}
local _dropMax=3
local _backgroundPos={1,-17,-6}
local _backgroundScale=1.4
local _foregroundPos={1,-17,-12}
local _foregroundScale=1.4
local _max_unit_count=3
local _disciple_since_num=100
local _monster_since_num=200
local _background_since_num=300
local _foreground_since_num=400



function UIChuanSongZhenWin:onLoaded(...)
self:bindComponents()
_this=self

notifySystem:listenNotify(notifyConfig.onTravelInited,self.onTravelInited)
notifySystem:listenNotify(notifyConfig.onTravelChange,self.onTravelChange)
notifySystem:listenNotify(notifyConfig.onTravelReward,self.onTravelReward)
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:listenNotify(notifyConfig.building_event,self.onBuildingEvent)
notifySystem:listenNotify(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)

self.areaList:bindScrollWidget(function(...)self:onAreaItemCreate(...)end)
self.areaList:setClickAction(function(id,index,guid,attach)self:onAreaItemClick(index)end)






self.helpContent:setText(cfgHelper.get1(cfg_lang_get,"worldTour_tips_2"))
self.winlua:ForceLayoutRect(self.helpPanel:getID())
self.helpPanel:setActive(false)

self.showReward=false
self.rewardShow=cfgHelper.getdef(cfg_worldtravelconfig,"rewardImage")
self.rewards:setChildLayoutGroupCreateItems(#self.rewardShow,function(index)
local item=self.rewards:getChildLayoutGroupGridItem(index-1)
item:SetChildCSImageSprite(0,_ab,self.rewardShow[index][2])
item:SetChildButtonClick(0,function()
self:onClickReward()
end)
for i=1,3 do
item:SetChildActive(i,index>=i)
end

end)
self.dropItems=cfgHelper.getdef1(cfg_worldtravelconfig,"dropAnimation")
self.spineBgs={}
self.dropObjList={}
self.dropObjTimer={}

AudioManager.setGroupMute(SOUND_GROUP_TYPE.skill,true)
end


function UIChuanSongZhenWin:__delete()

self:setAIImp(false)
notifySystem:removelistener(notifyConfig.onTravelInited,self.onTravelInited)
notifySystem:removelistener(notifyConfig.onTravelChange,self.onTravelChange)
notifySystem:removelistener(notifyConfig.onTravelReward,self.onTravelReward)
notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
notifySystem:removelistener(notifyConfig.building_event,self.onBuildingEvent)
notifySystem:removelistener(notifyConfig.onWorldBlockDataChanged,self.onWorldBlockDataChanged)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)

self:stopRewardTick()
self:stopUpdateTimer()
self:clearDropTimer()

if self.tweener then
self.tweener:Kill()
self.tweener=nil
end
if self.itemTweener then
self.itemTweener:Kill()
self.itemTweener=nil
end

self:unbindComponents()
_this=nil

if self.rotationTweemer then
for index,tweeners in pairs(self.rotationTweemer)do
for slotName,tweener in pairs(tweeners)do
tweener:Kill(false)
end
end
self.rotationTweemer=nil
end
for i=1,_max_unit_count do
self.fightStage:removeEntity(i+_monster_since_num)
self.fightStage:removeEntity(i+_disciple_since_num)
self.fightStage:removeEntity(i+_background_since_num)
self.fightStage:removeEntity(i+_foreground_since_num)
end
self.fightStage:close()
AudioManager.setGroupMute(SOUND_GROUP_TYPE.skill,false)
end




function UIChuanSongZhenWin:onShow(argtable,afterOnloaded)
if argtable==nil then return end
local entityId=argtable.entityId
self.fightStage=argtable.fightStage
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(entityId)

self:setChatContent()
self:setAreaList()
self:refreshBuildLevel()
self:refreshBuildingUpReddot()
if#self.areas>0 then
for i,v in ipairs(self.areas)do
if argtable.travel==i then
self:onAreaItemClick(i)
return
end
end
self:onAreaItemClick(1)
end
end


function UIChuanSongZhenWin:onHide()

end




function UIChuanSongZhenWin:onBackBtn()
UIFullChuanSongZhenControl:closeUI(true,true)
end


function UIChuanSongZhenWin:onChatFlexBtn()
local show=self.winlua:GetChildActiveSelf(self.flex_2:getID())
self.flex_2:setActive(not show)
self:setChatSize(not show)
end


function UIChuanSongZhenWin:onRuleBtn()
local show=self.winlua:GetChildActiveSelf(self.rulePanel:getID())
self.rulePanel:setActive(not show)
end


function UIChuanSongZhenWin:onHelpBtn()
local show=self.winlua:GetChildActiveSelf(self.helpPanel:getID())
self.helpPanel:setActive(not show)
end

function UIChuanSongZhenWin:refreshBuildingUpReddot()
local reddot=chuanSongZhenModel:checkBuildLevelUp(self.bdData)
self.buidlingUpReddot:setActive(reddot)
end


function UIChuanSongZhenWin:onAreaItemCreate(index,item)
local world=self.areas[index]
local wCfg=cfgHelper.get1(cfg_worldconfig_get,world)
local ylCfg=cfgHelper.get1(cfg_worldtravelconfig_get,world)

local open=ylCfg.level<=self.bdData.level
local reddot=open and chuanSongZhenModel:checkEmptySlot(world)or chuanSongZhenModel:checkRewardSingle(world)
item:SetChildActive(_areaCmp.selected,index==self.selectIdx)
item:SetChildText(_areaCmp.name,wCfg.name)
item:SetChildActive(_areaCmp.reddot,reddot)
item:SetChildActive(_areaCmp.lock,not open)
end

function UIChuanSongZhenWin:refresAreasOpen()
for index,world in ipairs(self.areas)do
local item=self.areaList:getGridObjectByindex(index-1)
local ylCfg=cfgHelper.get1(cfg_worldtravelconfig_get,world)
local open=ylCfg.level<=self.bdData.level
local reddot=open and chuanSongZhenModel:checkEmptySlot(world)or chuanSongZhenModel:checkRewardSingle(world)
item:SetChildActive(_areaCmp.reddot,reddot)
item:SetChildActive(_areaCmp.lock,not open)
end
end


function UIChuanSongZhenWin:onAreaItemClick(index)
if self.selectIdx~=index then
local world=self.areas[index]
local ylCfg=cfgHelper.get1(cfg_worldtravelconfig_get,world)
local open=ylCfg.level<=self.bdData.level
if not open then
UIManager.error(FMT.fmt('传送阵升到{0}级解锁',ylCfg.level))
return
end

local oldSelect=self.selectIdx
local oldId=nil
if oldSelect then
oldId=self.areas[oldSelect]
local item=self.areaList:getGridObjectByindex(oldSelect-1)
item:SetChildActive(_areaCmp.selected,false)
end
self.selectIdx=index
self.selectId=world

local item=self.areaList:getGridObjectByindex(self.selectIdx-1)
item:SetChildActive(_areaCmp.bg,false)
item:SetChildActive(_areaCmp.reddot,false)
item:SetChildActive(_areaCmp.name,false)
item:SetChildActive(_areaCmp.selected,true)
item:SetChildSizeDelta(_areaCmp.selected,0,72)
if self.itemTweener then
self.itemTweener:Kill(true)
self.itemTweener=nil
end
self.itemTweener=item:SetChildDOSizeDelta(_areaCmp.selected,Vector2.New(260,72),0.2,function()
item:SetChildActive(_areaCmp.name,true)
item:SetChildActive(_areaCmp.bg,true)
local reddot=chuanSongZhenModel:checkEmptySlot(self.selectId)or chuanSongZhenModel:checkRewardSingle(self.selectId)
item:SetChildActive(_areaCmp.reddot,reddot)
self.itemTweener=nil
end)

self:setView()

self:setBackground(oldSelect,self.selectIdx)
end
end

function UIChuanSongZhenWin:setAreaList()
local cfg=cfg_worldtravelconfig()
self.areas={}
for i,v in pairs(cfg)do
if type(i)=='number'and worldBlockModel:getWorldStateCount(i,eWorldBlockState.OPEN)>0 then
table.insert(self.areas,i)
end
end
table.sort(self.areas)
local count=#self.areas
self.selectIdx=nil
if self.selectId then
self.selectIdx=table.findValue(self.areas,selectId)
end

self.areaList:clearItems()
self.areaList:freshGridsNum(count,count,1,false)

self.timerParam=cfgHelper.getdef1(cfg_worldtravelconfig,"recvtips")
self.timerCheck={}
for i,v in ipairs(self.areas)do
local firstDisciple=chuanSongZhenModel:getDisciple(v,1)
if firstDisciple~=nil then
table.insert(self.timerCheck,i)
end
end
if#self.timerCheck>0 then
self:startUpdateTimer()
else
self:stopUpdateTimer()
end
end

function UIChuanSongZhenWin:startUpdateTimer()
if not self.updateTimer then
self.updateTimer=self:setTimer(1,0,self.onUpdateTimer)
end
end

function UIChuanSongZhenWin:stopUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIChuanSongZhenWin:setView()
local data=chuanSongZhenModel:getData(self.selectId)
if data then
self:setArea()
self:setTeam()
self:setReward()
self:setAI()
end
end

function UIChuanSongZhenWin:setAIImp(run)
self.aiRunning=run
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
self.animationMonsters={}
self.animationDisciples={}
for i=1,_max_unit_count do
self.fightStage:removeEntity(_monster_since_num+i)

end
end
if run then
local args={
stateId=0,
}
self.bt=behaviorManager:addBehaviorTree("bt_ui_csz",nil,true,args)
end
end

function UIChuanSongZhenWin:setAI()
local list=chuanSongZhenModel:getDisciples(self.selectId)
local check=false
self.state={}
for i,v in ipairs(list)do
local temp=not UIDiscipleModel:checkDiscipleState2(v,DISCIPLE_STATE_TYPE.eChuiWei)
self.state[i]=temp
check=check or temp
end
self:setAIImp(check)
end

function UIChuanSongZhenWin:setReward()
local guids=chuanSongZhenModel:getDisciples(self.selectId)
self.since=#guids>0
self:startRewardTick()
self:setRewardImp()
end

function UIChuanSongZhenWin:startRewardTick()
if self.since then
if not self.rewardTick then
self.rewardTick=self:setTimer(1,0,function()
self:setRewardImp()
end)
end
else
self:stopRewardTick()
end
end

function UIChuanSongZhenWin:setRewardImp()
if not self.selectId then
self:stopRewardTick()
end

local index=nil
local sum=chuanSongZhenModel:getMaxDurationSum(self.selectId)
for i=#self.rewardShow,1,-1 do
local cfg=self.rewardShow[i]
if sum>=cfg[1]then
index=i
break
end
end

local itemList=self.rewards:getChildLayoutGroupGridList()
for i=1,itemList.Count do
local item=itemList[i-1]
local oShow=item:GetChildActiveSelf(-1)
local nShow=i==index
if oShow~=nShow then
item:SetChildActive(-1,nShow)
end
end



















local data=chuanSongZhenModel:getData(self.selectId)
local tCfg=cfgHelper.get1(cfg_worldtravelconfig_get,self.selectId)
local max=cfgHelper.getdef(cfg_worldtravelconfig,"maxstore")
local now=timeHelper.getServerShortTime()
for i=1,tCfg.max do
local v=data.current[i]
local item=self.headList:getChildLayoutGroupGridItem(i-1)
if v then
local temp=v.dead>0 and v.dead or now
local time=Mathf.Clamp(temp-v.money,0,max)
item:SetChildText(_headCmp.time,timeHelper.format_time_stamp3(time))
else
item:SetChildText(_headCmp.time,"")
end
end
end

function UIChuanSongZhenWin:stopRewardTick()
if self.rewardTick then
self:stopTimerByID(self.rewardTick)
self.rewardTick=nil
end
end

function UIChuanSongZhenWin:setArea()
local wCfg=cfgHelper.get1(cfg_worldconfig_get,self.selectId)
local tCfg=cfgHelper.get1(cfg_worldtravelconfig_get,self.selectId)
self.descImg:setSprite(_ab,tCfg.descImage)
self.rewardSelected:setActive(self.showReward)

local count=#tCfg.drop
self.rewardList:setChildLayoutGroupCreateItems(count,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=tCfg.drop[index]
local rewardCfg=itemsConfig.getConfig(rewardData[1])
local data={
[1]=rewardData[1],
[2]=rewardData[2],
[3]=rewardData[3],
['stage']=rewardCfg.stage,
}
widgetHelper.setNormalRewardItem(rewardItem,-1,data,true)
end)
end

function UIChuanSongZhenWin:setTeam()
local tCfg=cfgHelper.get1(cfg_worldtravelconfig_get,self.selectId)
self.headList:setChildLayoutGroupClearAllItems()
self.headList:setChildLayoutGroupCreateItems(tCfg.max,function(index)
self:setHeadSlot(index,true)
end)

for i=1,_max_unit_count do
self.fightStage:removeEntity(_disciple_since_num+i)
self.fightStage:removeEntity(_monster_since_num+i)
end
local guids=chuanSongZhenModel:getDisciples(self.selectId)
for index,discipleguid in ipairs(guids)do
local entityIdx=_disciple_since_num+index
local pos=mathHelper.convertArrayToVector(_disciplePos[index])
pos=fightModel:transToBattleWorld(pos)
local ent=entity()
local model={}
if not chuanSongZhenModel:checkDiscipleState(self.selectId,index)then
model.body=UIDiscipleModel:getDiscipleSex(discipleguid)==1 and 1114103 or 1114104
model.componets=nil
else
local rawData=fightModel:createEntityInfo(discipleguid,1,1)
model=rawData.model
end
ent:initObj(model.body,model.componets,pos,_discipleScale,true)
self.fightStage:pushEntity(entityIdx,ent)

end

self:showCallbackPanel(nil)
end

function UIChuanSongZhenWin:changeTeam(index)
local entIdx=_disciple_since_num+index
local ent=self.fightStage:getEntity(entIdx)
local discipleguid=chuanSongZhenModel:getDisciple(self.selectId,index)
local isEmpty=discipleguid==nil
if ent then
if isEmpty then
self.fightStage:removeEntity(entIdx)
else
local model={}
if not chuanSongZhenModel:checkDiscipleState(self.selectId,index)then
model.body=UIDiscipleModel:getDiscipleSex(discipleguid)==1 and 1114103 or 1114104
model.componets=nil
else
local rawData=fightModel:createEntityInfo(discipleguid,1,1)
model=rawData.model
end
ent:changeBody(model.body,model.componets,_discipleScale)
end
else
if not isEmpty then
local pos=mathHelper.convertArrayToVector(_disciplePos[index])
pos=fightModel:transToBattleWorld(pos)
local ent=entity()
local model={}
if not chuanSongZhenModel:checkDiscipleState(self.selectId,index)then
model.body=UIDiscipleModel:getDiscipleSex(discipleguid)==1 and 1114103 or 1114104
model.componets=nil
else
local rawData=fightModel:createEntityInfo(discipleguid,1,1)
model=rawData.model
end
ent:initObj(model.body,model.componets,pos,_discipleScale,true)
self.fightStage:pushEntity(entIdx,ent)
end
end
end

function UIChuanSongZhenWin:setHeadSlot(index,init)
local data=chuanSongZhenModel:getSlotData(self.selectId,index)
local disciple=data and data.disciple or nil
local slot=self.headList:getChildLayoutGroupGridItem(index-1)
local isEmpty=disciple==nil
if init then
slot:SetChildButtonClick(_headCmp.this,function()
self:onClickHead(index)
end)
end

slot:SetChildNewBieComponentId(-1,FMT.fmt('UIChuanSongZhenWin.headSlot_{0}',index))
slot:SetChildActive(_headCmp.add,isEmpty)
slot:SetChildActive(_headCmp.head,not isEmpty)
slot:SetChildActive(_headCmp.selected,self.slot==index)
if not isEmpty then
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfo(disciple)
local gray=UIDiscipleModel:checkDiscipleState2(disciple,DISCIPLE_STATE_TYPE.eChuiWei)
comHelper.setChildModelRawImageEx(_headCmp.head,slot,modelParams,nil,0.8,gray)
local color=UIDiscipleModel:getDiscipleColor(disciple)
comHelper.setChildModelHeadIconBGByColor(slot,_headCmp.this,color)


local now=timeHelper.getServerShortTime()
local max=cfgHelper.getdef(cfg_worldtravelconfig,"maxstore")
local temp=data.dead>0 and data.dead or now
local time=Mathf.Clamp(temp-data.money,0,max)
slot:SetChildText(_headCmp.time,timeHelper.format_time_stamp3(time))
else
slot:SetChildCSImageSprite(_headCmp.this,"","")
slot:SetChildText(_headCmp.time,"")
end
end

function UIChuanSongZhenWin:onClickHead(index)
local disciple=chuanSongZhenModel:getDisciple(self.selectId,index)
local isEmpty=disciple==nil
if isEmpty then
local args={
bdData=self.bdData,
openType=dzSelectWinOpenType.eYouLi,
callback=function(guid)
chuanSongZhenController:send_5_92(self.selectId,guid)
end
}
discipleSelectController:openDiscipleSelect(args)
else
self:showCallbackPanel(index)
end
end

function UIChuanSongZhenWin:onClickReward()
chuanSongZhenController:send_5_94(self.selectId)
end

function UIChuanSongZhenWin:showCallbackPanel(slot)
if self.slot then
local slotCmp=self.headList:getChildLayoutGroupGridItem(self.slot-1)
slotCmp:SetChildActive(_headCmp.selected,false)
end
self.slot=slot
self.dialogRoot:setActive(slot~=nil)
if slot then
local slotCmp=self.headList:getChildLayoutGroupGridItem(slot-1)
slotCmp:SetChildActive(_headCmp.selected,true)
self:setCallbackPanel(slot)
end
end

function UIChuanSongZhenWin:onDialogBg()
self:showCallbackPanel()
end

function UIChuanSongZhenWin:onCallbackBtn()
local disciple=chuanSongZhenModel:getDisciple(self.selectId,self.slot)
if disciple then
local show_data={
type='UIDialouge',
title='提示',
content=FMT.fmt("是否确认召回弟子<{0}>？",UIDiscipleModel:getDiscipleName(disciple)),
oktext='召回',
canceltext='关闭',
okcallback=function()
chuanSongZhenController:send_5_93(self.selectId,disciple)
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
local slot=self.headList:getChildLayoutGroupGridItem(self.slot-1)
slot:SetChildActive(_headCmp.backPanel,false)
end
end

function UIChuanSongZhenWin:setCallbackPanel(slot)
local disciple=chuanSongZhenModel:getDisciple(self.selectId,self.slot)
self.callbackName:setText(UIDiscipleModel:getDiscipleName(disciple))
local jjLv=UIDiscipleModel:getDiscipleJJLevel(disciple)
local jjStr=FMT.fmt("境界：{0}",UIDiscipleModel:getJJName3(jjLv))
self.callbackJingjieTx:setText(jjStr)
local jyStr=FMT.fmt("机缘：{0}",UIDiscipleModel:getDiscipleBaseAttr(disciple,DISCIPLE_BASE_ATTR_TYPE.eJiYuan))
self.callbackJiyuanTx:setText(jyStr)
end

function UIChuanSongZhenWin:onRewardBtn()
if self.tweener then
return
end
self.showReward=not self.showReward
if self.showReward then
self.rewardSelected:setActive(self.showReward)
self.winlua:SetChildSizeDelta(self.rewardListBg:getID(),50,90)
self.tweener=self.winlua:SetChildDOSizeDelta(self.rewardListBg:getID(),Vector2.New(400,90),0.3,function()
self.tweener=nil
end)
else
self.tweener=self.winlua:SetChildDOSizeDelta(self.rewardListBg:getID(),Vector2.New(50,90),0.3,function()
self.rewardSelected:setActive(self.showReward)
self.tweener=nil
end)
end
end

function UIChuanSongZhenWin:onGetBtn()
self:onClickReward()
end

function UIChuanSongZhenWin:onBuildingUpBtn()
UIManager:showWindow("UIBuildingInfoWin",self.bdData)
end

function UIChuanSongZhenWin:onEarningBtn()
UIManager:showWindow("UIChuanSongZhenEarningsWin",{list=self.areas})
end

function UIChuanSongZhenWin.onTravelInited()
_this:setView()
end

function UIChuanSongZhenWin.onTravelChange(typo,world,slot,discipleguid)
local tCfg=cfgHelper.get1(cfg_worldtravelconfig_get,world)
if _this.selectId==world then

for i=slot,tCfg.max do
_this:setHeadSlot(i)
_this:changeTeam(i)
end

_this:setAI()
if not _this.bt then
_this:background_rotatePause()
end

if slot then
_this:setReward()
end

if typo==0 and _this.slot then
if _this.slot==slot then
_this:showCallbackPanel()
elseif _this.slot>slot then
_this:showCallbackPanel(_this.slot-1)
end
end
end

for i,v in ipairs(_this.areas)do
if v==world then
local item=_this.areaList:getGridObjectByindex(i-1)
local empty=chuanSongZhenModel:checkEmptySlot(world)
local reward=chuanSongZhenModel:checkRewardSingle(world)
local reddot=empty or reward
item:SetChildActive(_areaCmp.reddot,reddot)

if typo==0 then
local first=chuanSongZhenModel:getDisciple(world,1)
if first==nil then
table.removeValue(_this.timerCheck,i)
end
elseif typo==1 then
if not table.containsValue(_this.timerCheck,i)then
table.insert(_this.timerCheck,i)
end
end

break
end
end
end

function UIChuanSongZhenWin.onTravelReward(world)
if _this.selectId==world then
_this:setReward()

for i,v in ipairs(_this.areas)do
if v==world then
local item=_this.areaList:getGridObjectByindex(i-1)
local reddot=chuanSongZhenModel:checkEmptySlot(world)or chuanSongZhenModel:checkRewardSingle(world)
item:SetChildActive(_areaCmp.reddot,reddot)
end
end
end
end

function UIChuanSongZhenWin.onWorldBlockDataChanged(world,block,cState,oState)
if cState==eWorldBlockState.OPEN then
local count=worldBlockModel:getWorldStateCount(world,eWorldBlockState.OPEN)
if count<=1 then
_this:setAreaList()
end
end
end

function UIChuanSongZhenWin.onBuildingEvent(etype,sfId,ubdId,arg1,arg2)
if etype==buildingEvent.levelUpComplete and ubdId==_this.bdData.un_build_id then
_this:refresAreasOpen()
_this:refreshBuildLevel()
_this:refreshBuildingUpReddot()
elseif etype==buildingEvent.levelUpStart and ubdId==_this.bdData.un_build_id then
_this:refreshBuildingUpReddot()
end
end

function UIChuanSongZhenWin.on_money_changed(moneyType,lastVal,val)
_this:refreshBuildingUpReddot()
end

function UIChuanSongZhenWin:refreshBuildLevel()
local str=FMT.fmt("{0}级",self.bdData.level)
self.buildingLvTx:setText(str)
end

function UIChuanSongZhenWin.onDiscipleStateChange(discipleguid,stateType,old,cur)
if stateType==DISCIPLE_STATE_TYPE.eChuiWei then
local disciples=chuanSongZhenModel:getDisciples(_this.selectId)
for index,disciple in ipairs(disciples)do
if mathHelper.compareInt64(disciple,discipleguid)then
local slot=_this.headList:getChildLayoutGroupGridItem(index-1)
slot:SetChildCaptureImageGray(_headCmp.head,cur)
local discipleEntity=_this.fightStage:getEntity(_disciple_since_num+index)
local modelParams={}
if cur then
modelParams.body=UIDiscipleModel:getDiscipleSex(discipleguid)==1 and 1114103 or 1114104
modelParams.componets=nil

local pos=mathHelper.convertArrayToVector(_disciplePos[index])
pos=fightModel:transToBattleWorld(pos)
discipleEntity:setPosition(pos)
discipleEntity:runAnimator(eAnimationID.stand)

_this.state[index]=false
else
local rawData=fightModel:createEntityInfo(discipleguid,1,1)
modelParams=rawData.model
end
discipleEntity:changeBody(modelParams.body,modelParams.componets,_discipleScale)
end
end

_this:setAI()
if not _this.bt then
_this:background_rotatePause()
end
end
end

function UIChuanSongZhenWin.onUpdateTimer()
if#_this.timerCheck>0 then
for index,areaIdx in ipairs(_this.timerCheck)do
local item=_this.areaList:getGridObjectByindex(areaIdx-1)
local world=_this.areas[areaIdx]
local check1=chuanSongZhenModel:checkEmptySlot(world)or chuanSongZhenModel:checkRewardSingle(world)
local check2=item:GetChildActiveSelf(_areaCmp.reddot)
if check1~=check2 then
item:SetChildActive(_areaCmp.reddot,check1)
end
end
else
_this:stopUpdateTimer()
end
end


function UIChuanSongZhenWin:setChatSize(flex,atOnce)
local height=self.winlua:GetChildSizeDeltaY(self.chatContent:getID())
height=flex and math.max(math.min(height,500),138)or 138
local duration=atOnce and 0 or 0.2
self.winlua:SetStopChildScrollRect(self.chatScrollView:getID())
self.winlua:SetChildDOSizeDelta(self.chatScrollView:getID(),Vector2.New(0,height),duration)
end

function UIChuanSongZhenWin:setChatContent()
local chatList=chuanSongZhenModel:getEventData()
self.chatContent:setChildLayoutGroupCreateItems(#chatList,function(index)
local item=self.chatContent:getChildLayoutGroupGridItem(index-1)
local data=chatList[index]

item:SetChildText(0,chatEmotHelper.decodeEmot(data.content))
item:SetChildButtonClick(-1,function()self:onClickChat()end)
item:ForceLayoutRect(-1)
end)
self.chatContent:setChildAnchoredPosition(Vector2.zero)
self.winlua:ForceLayoutRect(self.chatContent:getID())
end

function UIChuanSongZhenWin:onClickChat()
local args={
title="游历见闻",
tips="风平浪静，没有发生什么事情",
datas=chuanSongZhenModel:getEventData(),
open=function()
chuanSongZhenModel:readEventData()
end
}

UIFullChuanSongZhenControl:showWindow("UITravelEventWin",args)
end

function UIChuanSongZhenWin:background_rotatePlay(index)
local id=self.areas[index or self.selectIdx]
local cfg=cfgHelper.get1(cfg_worldtravelconfig_get,id)
local idx1=_background_since_num+(index or self.selectIdx)
local ent1=self.fightStage:getEntity(idx1)
if ent1 then
if not self.rotationTweemer then
self.rotationTweemer={}
end
if not self.rotationTweemer[idx1]then
self.rotationTweemer[idx1]={}
end
local tweemers=self.rotationTweemer[idx1]
if next(tweemers)~=nil then
for i,v in pairs(tweemers)do
if not v:IsPlaying()then
v:TogglePause()
end
end
else
for i,v in pairs(cfg.bgSpineRotationSlot)do
local slotTF=ent1:getSlotTransform(i)
if slotTF then
local tweemer=Lua.DOTweenProxyExtensions.DOLocalRotate(slotTF,Vector3.forward*360,v,DG.Tweening.RotateMode.FastBeyond360)
tweemer:SetLoops(-1,DG.Tweening.LoopType.Incremental)
tweemer:SetEase(DG.Tweening.Ease.Linear)
tweemers[i]=tweemer
end
end
end
else

end

local idx2=_foreground_since_num+(index or self.selectIdx)
local ent2=self.fightStage:getEntity(idx2)
if ent2 then
if not self.rotationTweemer then
self.rotationTweemer={}
end
if not self.rotationTweemer[idx2]then
self.rotationTweemer[idx2]={}
end
local tweemers=self.rotationTweemer[idx2]
if next(tweemers)~=nil then
for i,v in pairs(tweemers)do
if not v:IsPlaying()then
v:TogglePause()
end
end
elseif cfg.fgSpineRotationSlot then
for i,v in pairs(cfg.fgSpineRotationSlot)do
local slotTF=ent2:getSlotTransform(i)
if slotTF then
local tweemer=Lua.DOTweenProxyExtensions.DOLocalRotate(slotTF,Vector3.forward*360,v,DG.Tweening.RotateMode.FastBeyond360)
tweemer:SetLoops(-1,DG.Tweening.LoopType.Incremental)
tweemer:SetEase(DG.Tweening.Ease.Linear)
tweemers[i]=tweemer
end
end
end
end
end

function UIChuanSongZhenWin:background_rotatePause(index)
local idx1=_background_since_num+(index or self.selectIdx)
local ent1=self.fightStage:getEntity(idx1)
if ent1 then
if self.rotationTweemer and self.rotationTweemer[idx1]then
local tweemers=self.rotationTweemer[idx1]
for i,v in pairs(tweemers)do
if v:IsPlaying()then
v:TogglePause()
end
end
end
else

end

local idx2=_foreground_since_num+(index or self.selectIdx)
local ent2=self.fightStage:getEntity(idx2)
if ent2 then
if self.rotationTweemer and self.rotationTweemer[idx2]then
local tweemers=self.rotationTweemer[idx2]
for i,v in pairs(tweemers)do
if v:IsPlaying()then
v:TogglePause()
end
end
end
end
end

function UIChuanSongZhenWin:background_fadeIn(index)
local idx1=_background_since_num+(index or self.selectIdx)
local ent1=self.fightStage:getEntity(idx1)
if ent1 then
ent1:setVisible(true)
ent1:setColor(Color.New(0,0,0,0))
ent1:fadeToColor(Color.white,1)
else

end

local idx2=_foreground_since_num+(index or self.selectIdx)
local ent2=self.fightStage:getEntity(idx2)
if ent2 then
ent2:setVisible(true)
ent2:setColor(Color.New(0,0,0,0))
ent2:fadeToColor(Color.white,1)
end
end

function UIChuanSongZhenWin:background_fadeOut(index)
local idx1=_background_since_num+(index or self.selectIdx)
local ent1=self.fightStage:getEntity(idx1)
if ent1 then
ent1:setColor(Color.white)
ent1:fadeToColor(Color.New(0,0,0,0),1,function()
self:background_rotatePause(idx1)
ent1:setVisible(false)
end)
else

end

local idx2=_foreground_since_num+(index or self.selectIdx)
local ent2=self.fightStage:getEntity(idx2)
if ent2 then
ent2:setColor(Color.white)
ent2:fadeToColor(Color.New(0,0,0,0),1,function()
self:background_rotatePause(idx2)
ent2:setVisible(false)
end)
end
end

function UIChuanSongZhenWin:setBackground(oldIdx,newIdx)
local newId=self.areas[newIdx]
local cfg=cfgHelper.get1(cfg_worldtravelconfig_get,newId)
local index=newIdx+_background_since_num
local newEntity=self.fightStage:getEntity(index)
if newEntity then
if self.bt then
local state=self.bt:getSharedVar("stateId")
if state==0 then
self:background_rotatePlay(newIdx)
else
self:background_rotatePause(newIdx)
end
else
self:background_rotatePause(newIdx)
end
self:background_fadeIn(newIdx)
if oldIdx then
self:background_fadeOut(oldIdx)
end
else
local wait=1

local callback=function()
wait=wait-1
if wait>0 then
return
end

if self.bt then
local state=self.bt:getSharedVar("stateId")
if state==0 then
self:background_rotatePlay(newIdx)
else
self:background_rotatePause(newIdx)
end
else
self:background_rotatePause(newIdx)
end

if oldIdx then
self:background_fadeIn(newIdx)
self:background_fadeOut(oldIdx)
else
UIManager:invokeUIMethod("UIFightPrepareLoading","endAni")
end
end

if cfg.fgSpineType then
wait=2
local index2=newIdx+_foreground_since_num
local ent=entity()
self.fightStage:pushEntity(index2,ent)
local fgPos=mathHelper.convertArrayToVector(_foregroundPos)
fgPos=fightModel:transToBattleWorld(fgPos)
ent:initObj(cfg.fgSpineType,{},fgPos,_foregroundScale,false,callback)
end

local ent=entity()
self.fightStage:pushEntity(index,ent)
local bgPos=mathHelper.convertArrayToVector(_backgroundPos)
bgPos=fightModel:transToBattleWorld(bgPos)
ent:initObj(cfg.bgSpineType,{},bgPos,_backgroundScale,false,callback)
end
end

function UIChuanSongZhenWin:walkState()
for i=1,_max_unit_count do
local discipleEntity=self.fightStage:getEntity(_disciple_since_num+i)
if discipleEntity and self.state[i]then
discipleEntity:runAnimator(eAnimationID.run)
local pos=mathHelper.convertArrayToVector(_disciplePos[i])
pos=fightModel:transToBattleWorld(pos)
discipleEntity:setPosition(pos)
end
self.fightStage:removeEntity(_monster_since_num+i)
end

self:background_rotatePlay()
end

function UIChuanSongZhenWin:showMonsterState()
local cfg=cfgHelper.get3(cfg_worldtravelconfig_get,self.selectId,"monster",1)
local r=math.random(1,3)
for i=1,r do
local id=table.randomIndex(cfg)
local modelCfg=cfgHelper.get3(cfg_worldmodelconfig_get,id,"data",4)
local ent=entity()
local endPos=mathHelper.convertArrayToVector(_monsterPos[i])
endPos=fightModel:transToBattleWorld(endPos)
local startPos=endPos+mathHelper.convertArrayToVector(_monsterPosDelta)
local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelCfg[1])
local scale=bodyCfg.worldScales and bodyCfg.worldScales[1]or 1

ent:initObj(modelCfg[1],modelCfg[2]or{},startPos,scale,false)
self.fightStage:pushEntity(_monster_since_num+i,ent)
ent:setColor(Color.New(1,1,1,0))
ent:fadeToColor(Color.white,1)
ent:moveTo(endPos,false,1,1,nil)
ent:runAnimator(eAnimationID.run)
end
end

function UIChuanSongZhenWin:fightMonsterState()
if self.bt==nil then return end
local monsters={}
local disciples={}
for i=1,_max_unit_count do
local entIdx=_disciple_since_num+i
local ent=self.fightStage:getEntity(entIdx)
if ent and self.state[i]then
ent:runAnimator(eAnimationID.stand)
table.insert(disciples,entIdx)
end
entIdx=_monster_since_num+i
ent=self.fightStage:getEntity(entIdx)
if ent then
ent:runAnimator(eAnimationID.stand)
table.insert(monsters,entIdx)
end
end
self:background_rotatePause()

local delay={}
self.animationMonsters=monsters
for i=1,#self.animationMonsters do
table.insert(delay,(i-1)*0.5)
end
for i,v in ipairs(self.animationMonsters)do
local delay=table.remove(delay,math.random(#delay))
local count=math.random(2,4)
self:delayDo(delay,function()
if self.bt==nil then return end
self:monsterAttackLoop(self.bt.uid,v,count)
end)
end

self.animationDisciples=disciples
delay={}
for i=1,#self.animationDisciples do
table.insert(delay,(i-1)*0.5)
end
for i,v in ipairs(self.animationDisciples)do
local delay=table.remove(delay,math.random(#delay))
self:delayDo(delay,function()
if self.bt==nil then return end
self:discipleAttackLoop(self.bt.uid,v)
end)
end
end

function UIChuanSongZhenWin:monsterAttackLoop(btId,entIdx,count)
if self.bt==nil or btId~=self.bt.uid then return end
local ent=self.fightStage:getEntity(entIdx)
local attack=eAnimationID.attack1
if ent then
ent:runAnimator(attack,1,function(aId)
self:delayDo(0.2,function()
if self.bt==nil or self.bt.uid~=btId then return end
if aId~=attack then return end
count=count-1
if count>0 then
self:monsterAttackLoop(btId,entIdx,count)
else
self:monsterDead(btId,entIdx)
end
end)
end)
end
end

function UIChuanSongZhenWin:monsterDead(btId,entIdx)
if self.bt==nil or btId~=self.bt.uid then return end
local ent=self.fightStage:getEntity(entIdx)
if ent then
ent:runAnimator(eAnimationID.dead,1)
ent:fadeToColor(Color.New(1,1,1,0),1.5)
ent:playEffect(30001,Vector3.New(-0.1,-0.1,0),true,true)
table.removeValue(self.animationMonsters,entIdx)
if not chuanSongZhenModel:checkRewardSingle(self.selectId)then
self:animationDropItem(entIdx-_monster_since_num)
end
end
end

function UIChuanSongZhenWin:discipleAttackLoop(btId,entIdx)
if self.bt==nil or btId~=self.bt.uid then return end
local index=entIdx-_disciple_since_num
local discipleGuid=chuanSongZhenModel:getDisciple(self.selectId,index)
if discipleGuid==nil then return end
local job=UIDiscipleModel:getDiscipleJob(discipleGuid)
local cfg=cfgHelper.get1(cfg_worldtravelattackconfig_get,job)
local attacks={}
for i,v in pairs(cfg)do
table.insert(attacks,i)
end
local r=math.random(1,#attacks)
local attack=attacks[r]
local ent=self.fightStage:getEntity(entIdx)
ent:runAnimator(attack,1,function(aId)
self:delayDo(0.2,function()
if self.bt==nil or btId~=self.bt.uid then return end
if aId~=attack then return end
if#self.animationMonsters>0 then
self:discipleAttackLoop(btId,entIdx,ent)
else
table.removeValue(self.animationDisciples,entIdx)
if#self.animationDisciples<=0 and self.bt:getSharedVar("stateId")==1 then
self.bt:setSharedVar("stateId",1.5)
end
end
end)
end)


local target=math.random(1,#self.animationMonsters)
local targetEnt=self.fightStage:getEntity(self.animationMonsters[target])
local disciplePos=mathHelper.convertArrayToVector(_disciplePos[index])
disciplePos=fightModel:transToBattleWorld(disciplePos)
local monsterPos=mathHelper.convertArrayToVector(_monsterPos[target])
monsterPos=fightModel:transToBattleWorld(monsterPos)

cfg=cfg[attack]

if cfg.effect1 then
self:playEntityEffect(ent,cfg.effect1,cfg.effectScale1,cfg.effectDelay1,cfg.effectOffset1)
end

if cfg.effect3 then
self:playEntityEffect(targetEnt,cfg.effect3,cfg.effectScale3,cfg.effectDelay3,cfg.effectOffset3)
end

if cfg.effect2 then
local effectId=cfg.effect2
local scale=cfg.effectScale2 and mathHelper.convertArrayToVector(cfg.effectScale2)or Vector3.one
local delay=cfg.effectDelay2 or 0
local offset=cfg.effectOffset2 and mathHelper.convertArrayToVector(cfg.effectOffset2)or Vector3.zero
local speed=cfg.effectSpeed2 or 1
local srcPos=disciplePos+offset
local dstPos=monsterPos+offset
local func=function()
if self.bt==nil or self.bt.uid~=btId then return end
local paras={
[1]=2,
[2]=speed*1000,
[3]=1,
[4]=1,
}
fightManager.playMoveEffect(effectId,paras,srcPos,dstPos,nil,scale)
end

if delay>0 then
self:delayDo(delay,func)
else
func()
end

if cfg.effect4 then
local flyDuration=Vector3.Distance(srcPos,dstPos)/(speed*1000/100)
self:playEntityEffect(targetEnt,cfg.effect4,cfg.effectScale4,(cfg.effectDelay4 or 0)+flyDuration,cfg.effectOffset4)
end
end
end

function UIChuanSongZhenWin:playEntityEffect(ent,cfgEffect,cfgScale,cfgDelay,cfgOffset)
local effectId=cfgEffect
local scale=cfgScale and mathHelper.convertArrayToVector(cfgScale)or Vector3.one
local delay=cfgDelay or 0
local offset=cfgOffset and mathHelper.convertArrayToVector(cfgOffset)or Vector3.zero
if delay>0 then
self:delayDo(delay,function()
if self.bt==nil or ent==nil then return end
ent:playEffect(effectId,offset,true,true,scale)
end)
else
ent:playEffect(effectId,offset,true,true,scale)
end
end

function UIChuanSongZhenWin:readyMonsterState()
for i=1,_max_unit_count do

local entIdx=_disciple_since_num+i
local ent=self.fightStage:getEntity(entIdx)
local discipleGuid=chuanSongZhenModel:getDisciple(self.selectId,i)
if ent and discipleGuid and self.state[i]then
local need=UIDiscipleModel:isMeleeAttack(discipleGuid)
if need then
local pos=mathHelper.convertArrayToVector(_discipleNearPos[i])
pos=fightModel:transToBattleWorld(pos)
ent:runAnimator(eAnimationID.run)
ent:moveTo(pos,true,0.5,1,nil)
else
ent:runAnimator(eAnimationID.run)
end
end

entIdx=_monster_since_num+i
ent=self.fightStage:getEntity(entIdx)
if ent then
local pos=mathHelper.convertArrayToVector(_monsterNearPos[i])
pos=fightModel:transToBattleWorld(pos)
ent:runAnimator(eAnimationID.run)
ent:moveTo(pos,true,0.5,1,nil)
end
end
end

function UIChuanSongZhenWin:finishMonsterState()
for i=1,_max_unit_count do
local entIdx=_disciple_since_num+i
local ent=self.fightStage:getEntity(entIdx)
local discipleGuid=chuanSongZhenModel:getDisciple(self.selectId,i)
if ent and discipleGuid and self.state[i]then
local need=UIDiscipleModel:isMeleeAttack(discipleGuid)
if need then
local pos=mathHelper.convertArrayToVector(_disciplePos[i])
pos=fightModel:transToBattleWorld(pos)
ent:flipX(false)
ent:runAnimator(eAnimationID.run)
local btId=self.bt.uid
ent:moveTo(pos,true,0.5,1,function()
if self.bt==nil or btId~=self.bt.uid then return end
ent:flipX(true)
end)
else
ent:runAnimator(eAnimationID.stand)
end
end
end
end

function UIChuanSongZhenWin:animationDropItem(index)
self.dropObjList[index]={}
local num=math.random(1,_dropMax)
local cmpId=self.dropRoot:getID()
local formPos=Vector3.New(_dropPos[index][1],_dropPos[index][2],0)

for i=1,num do
local order=0
local midPos=formPos+Vector3.New(50+i*50,0,0)
local itemIdx=math.random(1,#self.dropItems)
local params={
itemId=self.dropItems[itemIdx],
toPos=Vector3.down*250,
formPos=formPos,
midPos=midPos,
index=i,
}
local luaid=self.dropPool:createObject('UICSZDropItem',cmpId,order,params)
table.insert(self.dropObjList[index],luaid)
end

local dropTimer=self:delayDo(4.2,function()
if self.bt==nil then return end
for i,v in ipairs(self.dropObjList[index])do
self.dropPool:recycleItemById(v)
end
self.dropObjList[index]=nil
if self.dropObjTimer[index]then
self:stopTimerByID(self.dropObjTimer[index])
self.dropObjTimer[index]=nil
end
end)
self.dropObjTimer[index]=dropTimer
end

function UIChuanSongZhenWin:clearDropTimer()
for i,v in pairs(self.dropObjTimer)do
self:stopTimerByID(v)
end
self.dropObjTimer=nil
end
