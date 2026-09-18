







def_class("UIWanBaoXunBaoDui_MTSceneWin",UIWindowBase)









function UIWanBaoXunBaoDui_MTSceneWin:bindComponents()

self.root=UIObject.get(self,0)
self.shipSpine=UIObject.get(self,1)
self.teanShipBg=UIObject.get(self,2)
self.teamroot=UIObject.get(self,3)
self.memberList=UIObject.get(self,4)
self.crew_1=UIBaseItem.get(self,5)
self.crew_2=UIBaseItem.get(self,6)
self.crew_3=UIBaseItem.get(self,7)
self.boss=UIObject.get(self,8)
self.recruitRoot=UIObject.get(self,9)
self.recruitBtn=UIButton.get(self,10)
self.recruimentList=UIObject.get(self,11)
self.adventuringspine=UIObject.get(self,12)
self.worldEndPoint=UIObject.get(self,13)
self.worldStartPoint=UIObject.get(self,14)
self.catJumpYan=UIObject.get(self,15)
self.fishmodelroot=UIObject.get(self,16)
self.fish_1=UIObject.get(self,17)
self.fish_2=UIObject.get(self,18)
self.fish_3=UIObject.get(self,19)

self.recruitBtn:setButtonClick(function()self:onRecruitBtn()end)
self.crew={
self.crew_1,
self.crew_2,
self.crew_3,
}
self.fish={
self.fish_1,
self.fish_2,
self.fish_3,
}



end


function UIWanBaoXunBaoDui_MTSceneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shipSpine);self.shipSpine=nil;
_UIObject_release(self.teanShipBg);self.teanShipBg=nil;
_UIObject_release(self.teamroot);self.teamroot=nil;
_UIObject_release(self.memberList);self.memberList=nil;
_UIObject_release(self.crew_1);self.crew_1=nil;
_UIObject_release(self.crew_2);self.crew_2=nil;
_UIObject_release(self.crew_3);self.crew_3=nil;
_UIObject_release(self.boss);self.boss=nil;
_UIObject_release(self.recruitRoot);self.recruitRoot=nil;
_UIObject_release(self.recruitBtn);self.recruitBtn=nil;
_UIObject_release(self.recruimentList);self.recruimentList=nil;
_UIObject_release(self.adventuringspine);self.adventuringspine=nil;
_UIObject_release(self.worldEndPoint);self.worldEndPoint=nil;
_UIObject_release(self.worldStartPoint);self.worldStartPoint=nil;
_UIObject_release(self.catJumpYan);self.catJumpYan=nil;
_UIObject_release(self.fishmodelroot);self.fishmodelroot=nil;
_UIObject_release(self.fish_1);self.fish_1=nil;
_UIObject_release(self.fish_2);self.fish_2=nil;
_UIObject_release(self.fish_3);self.fish_3=nil;
self.crew=nil;
self.fish=nil;
end
















local CmpExplorationTeamSlotItemIndex={
model=0,
addimg=1,
txList=2,
yan=3,
effect=4,
}





function UIWanBaoXunBaoDui_MTSceneWin:onLoaded(...)
self:bindComponents()

self.btTreeList={}
self.recruitBtList={}
self.btStateList={}


self:addNotify(notifyConfig.onWanBaoXunBaoDuiTakeTask,function(...)self:onWanBaoXunBaoDuiTakeTask(...)end)

self:addNotify(notifyConfig.onWanBaoXunBaoDuiGoAdventure,function(...)self:onWanBaoXunBaoDuiGoAdventure(...)end)

self:addNotify(notifyConfig.onWanBaoXunBaoDuiCatComeInterview,function(...)self:onWanBaoXunBaoDuiCatComeInterview(...)end)

self:addNotify(notifyConfig.onWanBaoXunBaoDuiDealCatInterView,function(...)self:onWanBaoXunBaoDuiDealCatInterView(...)end)


self.crewWorldPosList={
[1]=self.winlua:GetChildPosition(self.crew_1:getID()),
[2]=self.winlua:GetChildPosition(self.crew_2:getID()),
[3]=self.winlua:GetChildPosition(self.crew_3:getID()),
}
end


function UIWanBaoXunBaoDui_MTSceneWin:__delete()

self:destoryAllAnimation()
self:resetCrew()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_MTSceneWin:onShow(argtable,afterOnloaded)
self.selectChannelIndex,self.selectChannelId=wanBaoXunBaoDuiModel:getChannelDefaultSelectIndex()

self.boss:setChildUIModelShowTarget(3030,0.2,{},0,false,false,0,nil)
self:refresh()
end


function UIWanBaoXunBaoDui_MTSceneWin:onHide()

end

function UIWanBaoXunBaoDui_MTSceneWin:refresh()
self:initData()

self:refreshBoss()

self:refreshShip()

self:refreshCrew()


self:refreshRecruitRoot()
end

function UIWanBaoXunBaoDui_MTSceneWin:initData()
self.channelDatasById=wanBaoXunBaoDuiModel:getChannelDatas()
self.channelDatas,self.channelLen=wanBaoXunBaoDuiModel:getMainWinChannelDatas()

for index,channelData in pairs(self.channelDatas)do
if channelData.channel_Id==self.selectChannelId then
self.selectChannelIndex=index
end
end

self.selectChannelData=self.channelDatas[self.selectChannelIndex]
end

function UIWanBaoXunBaoDui_MTSceneWin:refreshBoss(animId)
animId=animId or eAnimationID.idle
self.boss:setChildModelAnimationState(animId)
end

function UIWanBaoXunBaoDui_MTSceneWin:refreshShip(state)
if self.shipDW then
self.shipDW:Kill()
self.shipDW=nil
end

if self.returnShipDW then
self.returnShipDW:Kill()
self.returnShipDW=nil
end

local channelData=self.channelDatas[self.selectChannelIndex]
local isShow=channelData.channel_state==WBXBD_Channel_STATE.preparing or channelData.channel_state==WBXBD_Channel_STATE.finish or channelData.channel_state==WBXBD_Channel_STATE.early_return
local isDoing=channelData.channel_state==WBXBD_Channel_STATE.doing or channelData.channel_state==WBXBD_Channel_STATE.done
self.teanShipBg:setActive(isShow)
self.adventuringspine:setActive(isDoing)
self.shipSpine:setChildAnchoredPos(167,-102)

if isShow then
local originalState=state
if not state then
state=WBXBD_Ship_Animation.idle
if channelData.channel_state==WBXBD_Channel_STATE.finish
or channelData.channel_state==WBXBD_Channel_STATE.done
or channelData.channel_state==WBXBD_Channel_STATE.early_return
then
state=WBXBD_Ship_Animation.finish
end
end
if originalState and originalState==WBXBD_Ship_Animation.comeBack or originalState==WBXBD_Ship_Animation.finish then
if channelData.channel_state==WBXBD_Channel_STATE.finish
or channelData.channel_state==WBXBD_Channel_STATE.done
or channelData.channel_state==WBXBD_Channel_STATE.early_return
then

AudioManager.playAudio(628)
end
elseif state==WBXBD_Ship_Animation.idle and channelData.channel_state==WBXBD_Channel_STATE.preparing and channelData.employeeLen==0 then

AudioManager.playAudio(625)
end

self.winlua:SetChildSpineAnimation(self.teanShipBg:getID(),state,1,nil)
end

if channelData.employeeLen==0 then
self.shipSpine:setChildAnchoredPos(1600,-102)
self.shipDW=self.shipSpine:setChildDOAnchorPosX(167,1,function()end)
end
end

function UIWanBaoXunBaoDui_MTSceneWin:resetCrew()
for index,itemobj in pairs(self.crew)do

if self.btTreeList[index]then
behaviorManager:removeBehaviorTree(self.btTreeList[index])
self.btTreeList[index]=nil
end

if self.btTreeList[index+100]then
behaviorManager:removeBehaviorTree(self.btTreeList[index+100])
self.btTreeList[index+100]=nil
end


local item=itemobj:getWidgetBase()
item:SetChildActive(CmpExplorationTeamSlotItemIndex.addimg,false)
item:SetChildActive(CmpExplorationTeamSlotItemIndex.txList,false)
item:SetChildUIModelRemoveTarget(CmpExplorationTeamSlotItemIndex.model)
item:SetChildLocalPos(CmpExplorationTeamSlotItemIndex.model,0,0,0)
end
self.selectChannelData.bt_num=0
self.selectChannelData.bt_state=WBXBD_BT_STATE.none
for k=1,3 do
self.btStateList[k]=false
end
end

function UIWanBaoXunBaoDui_MTSceneWin:refreshCrew(animid)
local channelData=self.channelDatas[self.selectChannelIndex]
local teamDatas=channelData.employeeList or{}
local isShowTeam=channelData.channel_state==WBXBD_Channel_STATE.preparing
or channelData.channel_state==WBXBD_Channel_STATE.early_return
or channelData.channel_state==WBXBD_Channel_STATE.finish

self.memberList:setActive(isShowTeam)

if isShowTeam then


for index,itemobj in pairs(self.crew)do
local guid=teamDatas[index]
local data=wanBaoXunBaoDuiModel:getCatData(guid)
local item=itemobj:getWidgetBase()

item:SetChildActive(CmpExplorationTeamSlotItemIndex.addimg,data==nil and channelData.channel_state==WBXBD_Channel_STATE.preparing)
item:SetChildActive(CmpExplorationTeamSlotItemIndex.txList,data~=nil and channelData.channel_state==WBXBD_Channel_STATE.preparing)

if animid==nil then
animid=animid or eAnimationID.idle

if channelData.channel_state==WBXBD_Channel_STATE.finish then
animid=2162
elseif channelData.channel_state==WBXBD_Channel_STATE.early_return then
animid=2163
end
end


if self.btTreeList[index]then
behaviorManager:removeBehaviorTree(self.btTreeList[index])
self.btTreeList[index]=nil
end

if data then
self:freshCatAchiveTx(index)
local modelid,components=wanbaoXunBaoDuiHelper:getCatModelParam(data)
item:SetChildUIModelShowTarget(CmpExplorationTeamSlotItemIndex.model,modelid,1,components,animid,false,false,0,nil)

local speakType
if channelData.channel_state==WBXBD_Channel_STATE.preparing then
speakType=WBXBD_Speak_Type.prepara
elseif channelData.channel_state==WBXBD_Channel_STATE.early_return then
speakType=WBXBD_Speak_Type.adventure_fail
elseif channelData.channel_state==WBXBD_Channel_STATE.finish then
speakType=WBXBD_Speak_Type.adventure_success
end
local initData={
widget=item,
speakType=speakType,
startWaitTime=0.5,
endWaitTime=Mathf.Random(6,10),
speakOffset={-30,100},
speakDuration=5,
speakid=1,
stateId=WBXBD_BT_Type.None,
}
self.btTreeList[index]=behaviorManager:addBehaviorTree('bt_ui_wbxbd_employee',{},true,initData)
else
item:SetChildUIModelRemoveTarget(CmpExplorationTeamSlotItemIndex.model)
end

item:SetBaseItemClickEvent(-1,function(id,mindex,iguid,attch)
local channelData=self.channelDatas[self.selectChannelIndex]
local teamDatas=channelData.employeeList or{}
local guid=teamDatas[index]
local data=wanBaoXunBaoDuiModel:getCatData(guid)
if channelData.channel_state==WBXBD_Channel_STATE.preparing then
if data~=nil then
if self.btStateList[index]then
UIManager.info('猫猫正在赶来')
return
end
local func=function()
wanBaoXunBaoDuiModel:removeDispatchEmployee(self.selectChannelId,index,guid)

end
local showdata=
{
type='UIDialouge',
title='提示',
content="是否取消该猫猫探险资格",
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
func()
end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
UIFullWanBaoXunBaoDuiController:showWindow("UIWanBaoXunBaoDui_SelectEmployeeWin",{index=index,channel_id=self.selectChannelId})
end
end
end)
end
end
end


function UIWanBaoXunBaoDui_MTSceneWin:freshBaseCrewItem(index)
local itemobj=self.crew[index]
local item=itemobj:getWidgetBase()

if self.btTreeList[index]then
behaviorManager:removeBehaviorTree(self.btTreeList[index])
self.btTreeList[index]=nil
end

item:SetChildUIModelRemoveTarget(CmpExplorationTeamSlotItemIndex.model)

item:SetChildActive(CmpExplorationTeamSlotItemIndex.addimg,true)
item:SetChildActive(CmpExplorationTeamSlotItemIndex.txList,false)
end

function UIWanBaoXunBaoDui_MTSceneWin:freshCatAchiveTx(index)
local itemobj=self.crew[index]
local item=itemobj:getWidgetBase()
local channelData=self.channelDatas[self.selectChannelIndex]
local teamDatas=channelData.employeeList or{}
local guid=teamDatas[index]
local data=wanBaoXunBaoDuiModel:getCatData(guid)

local needTx=cfgHelper.get2(cfg_catmapconfig_get,channelData.task_Id,'needTx')
local tempNeedTx={}
for k,v in pairs(needTx)do
tempNeedTx[v]=1
end

local hasTxList={}
for i,txid in pairs(data.txList or{})do
local spe=cfgHelper.get2(cfg_cattxconfig_get,txid,'spe')
local isItemTx=false
if spe~=nil then
for k,v in pairs(spe)do
if v[1]==4 then
isItemTx=true
break
end
end
end

if tempNeedTx[txid]~=nil or isItemTx then
hasTxList[#hasTxList+1]=txid
end
end
item:SetChildActive(CmpExplorationTeamSlotItemIndex.txList,#hasTxList>0)
item:SetChildLayoutGroupCreateItems(CmpExplorationTeamSlotItemIndex.txList,#hasTxList,function(index)
local txitem=item:GetChildLayoutGroupGridItem(CmpExplorationTeamSlotItemIndex.txList,index-1)
local txid=hasTxList[index]

local txCfg=cfgHelper.get1(cfg_cattxconfig_get,txid)

local name=UIDiscipleModel.getSpecialityNameStr(txCfg.name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(txCfg.frame)
txitem:SetChildCSImageSprite(0,abName,frameIcon)
txitem:SetChildText(1,name)
txitem:SetBaseItemClickEvent(-1,function()
self:showWindow('UIWanBaoXunBaoDui_SpeicialWin',{
item=txitem,
node='bottom',
spid=txid,
})
end)
end)
end

function UIWanBaoXunBaoDui_MTSceneWin:startShowRecruitment()
self:refreshRecruitRoot()
if self.addRecruitList~=nil and#self.addRecruitList>0 then
local interval=0.2
for index=1,#self.addRecruitList do
local data=self.addRecruitList[index]
local item=self.recruimentList:getChildLayoutGroupGridItem(data.index-1)
item:SetChildActive(-1,false)
self:delayDo(index*interval,function()
self:addRecruitMent(data.data,data.index)
end)
end
end
self.addRecruitList=nil
end

function UIWanBaoXunBaoDui_MTSceneWin:updataToMainWin(channel_Id)
if self.selectChannelId~=channel_Id then
self.selectChannelId=channel_Id
wanBaoXunBaoDuiModel:clearDispathTimer()
local channeldata=self.channelDatasById[self.selectChannelId]
if channeldata.channel_state==WBXBD_Channel_STATE.finish or channeldata.channel_state==WBXBD_Channel_STATE.early_return then
self:initData()
self:refreshShip()
self:refreshCrew()
self:playAdventureReturn(channeldata)
else
self:resetCrew()
self:refresh()
end
end
end

function UIWanBaoXunBaoDui_MTSceneWin:updataToChannel(channel_Id)
if channel_Id==self.selectChannelId then
self:refresh()
end
end

function UIWanBaoXunBaoDui_MTSceneWin:onWanBaoXunBaoDuiTakeTask(channel_id,task_id)
self:playShipIn(channel_id)
end

function UIWanBaoXunBaoDui_MTSceneWin:onWanBaoXunBaoDuiGoAdventure(channel_id,callback)
self:playAdventureGo(channel_id,callback)
end

function UIWanBaoXunBaoDui_MTSceneWin:onWanBaoXunBaoDuiCatComeInterview(data,index)
if UIManager:isActive('UIWanBaoXunBaoDui_RecruitWin')then
if self.addRecruitList==nil then
self.addRecruitList={}
end

table.insert(self.addRecruitList,{data=data,index=index})
else
self:addRecruitMent(data,index)
end
end

function UIWanBaoXunBaoDui_MTSceneWin:onWanBaoXunBaoDuiDealCatInterView(index,type)

local recruiters=wanBaoXunBaoDuiModel:getRecruitDatas()
local tempAddRecruitList=self.addRecruitList or{}
self.addRecruitList={}
for k,v in ipairs(recruiters)do
for kk,vv in ipairs(tempAddRecruitList)do
if v.guid==vv.data.guid then
table.insert(self.addRecruitList,{data=v,index=k})
end
end
end


end


function UIWanBaoXunBaoDui_MTSceneWin:onRecruitBtn()
UIFullWanBaoXunBaoDuiController:showWindow("UIWanBaoXunBaoDui_RecruitWin")
end

function UIWanBaoXunBaoDui_MTSceneWin:refreshRecruitRoot()
self.recruiters=wanBaoXunBaoDuiModel:getRecruitDatas()

self.recruimentList:setChildLayoutGroupCreateItems(3,function(index)
local recruit=self.recruiters[index]
local item=self.recruimentList:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(-1,recruit~=nil)
if recruit~=nil then
local modelid,components=wanbaoXunBaoDuiHelper:getCatModelParam(recruit)
item:SetChildUIModelShowTarget(0,modelid,1,components,1,false,false,0,nil)
end
end)
end

function UIWanBaoXunBaoDui_MTSceneWin:addRecruitMent(catinfo,catlen)


if self.recruitBtList[catlen]then
behaviorManager:removeBehaviorTree(self.recruitBtList[catlen])
self.recruitBtList[catlen]=nil
end
local item=self.recruimentList:getChildLayoutGroupGridItem(catlen-1)
item:SetChildActive(-1,false)


local modelid,components=wanbaoXunBaoDuiHelper:getCatModelParam(catinfo)
item:SetChildUIModelShowTarget(0,modelid,1,components,1,false,false,0,nil)

local initData={
widget=item,
modelIndex=0,
startPos={1000,0},
endPos={0,0},
stateId=1,
speakid=0,
}
self.recruitBtList[catlen]=behaviorManager:addBehaviorTree('bt_ui_wbxbd_employee',{},true,initData)

end

local startPosList={[1]={960,-165},[2]={660,-165},[3]={350,-165},}
local midPosList={[1]={301.1,-118.8},[2]={7.8,-121.8},[3]={-303,-135},}
local endPosList={[1]={478,-165},[2]={181,-168},[3]={-135,-180},}
local flipxList={false,false,true}
local flipx2List={false,false,false}
local osiderlist={Vector2.New(-0.3,-0.4),Vector2.New(0,0),Vector2.New(-0.3,-0.4)}
local esiderlist={Vector2.New(-0.3,-0.4),Vector2.New(0,0),Vector2.New(-0.3,-0.4)}
local jumpSpeedList={600,300,600}
local jumpPowerList={120,50,100}

local waitHiddAddIconTime={0.18,0.1,0.18}

function UIWanBaoXunBaoDui_MTSceneWin:dispatchCrew(guid,index)
if self.isJumpQuickDispath then return end

if self.btTreeList[index]then
behaviorManager:removeBehaviorTree(self.btTreeList[index])
self.btTreeList[index]=nil
end

local catInfo=wanBaoXunBaoDuiModel:getCatData(guid)
local item=self.crew[index]:getWidgetBase()
local modelid,components=wanbaoXunBaoDuiHelper:getCatModelParam(catInfo)
local apilevel=deviceHelper.getAPILevel()
if apilevel<=33 then
components={}
end
item:SetChildUIModelShowTarget(0,modelid,1,components,1,false,false,0,nil)
item:SetChildActive(0,false)
self:initData()


local initData={
mainWidget=item,
widget=item:GetChildWidgetBase(0),
objtranform='transform',
transform=item:GetCommonComponent(0,'Transform'),
modelIndex=-1,
startPos=startPosList[index],
midPos=midPosList[index],
endPos=endPosList[index],
stateId=2,
oSider=osiderlist[index],
worldPos=self.crewWorldPosList[index],
eSider=esiderlist[index],
flipx=flipxList[index],
flipx2=flipx2List[index],
channelId=self.selectChannelData.channel_Id,
itemIndex=index,
addIconIndex=1,
yanEffectWB=self.catJumpYan:getWidgetBase(),
yanEffectValue=10196,
jumpSpeed=jumpSpeedList[index],
jumpPower=jumpPowerList[index],
hideAddIconTime=waitHiddAddIconTime[index],


speakType=WBXBD_Speak_Type.prepara,
startWaitTime=0.5,
endWaitTime=Mathf.Random(6,10),
speakOffset={-30,100},
speakDuration=5,
}
self.btTreeList[index]=behaviorManager:addBehaviorTree('bt_ui_wbxbd_employee',{},true,initData)
wanBaoXunBaoDuiModel:setChannelBtState(self.selectChannelId,WBXBD_BT_STATE.dispatch)
end

function UIWanBaoXunBaoDui_MTSceneWin:playPreparingAnimation(team)
self:refreshShip()

for k,bt in pairs(self.btTreeList)do
if bt then
behaviorManager:removeBehaviorTree(bt)
end
end

for index,crewid in pairs(team)do
local item=self.crew[index]:getWidgetBase()
local catinfo=wanBaoXunBaoDuiModel:getCatData(crewid)
local modelid,components=wanbaoXunBaoDuiHelper:getCatModelParam(catinfo)
item:SetChildUIModelShowTarget(0,modelid,1,components,1,false,false,0,nil)

local initData={
widget=item:GetChildWidgetBase(0),
modelIndex=-1,
startPos=startPosList[index],
endPos=endPosList[index],
stateId=3,


speakWidget=item:GetChildWidgetBase(CmpExplorationTeamSlotItemIndex.speakRoot),
speakState=0,
speakWaitTime=3,
speakWeight=500,
contentIndex=0,
speakContentType=WBXBD_Speak_Type.prepara,
}
self.btTreeList[index]=behaviorManager:addBehaviorTree('bt_ui_wbxbd_employee',nil,true,initData)
end
end

function UIWanBaoXunBaoDui_MTSceneWin:playAdventureReturn(channelData,callback)
if self.selectChannelId==channelData.channel_Id then

if self.shipDW then
self.shipDW:Kill()
self.shipDW=nil
end

self:refreshShip(WBXBD_Ship_Animation.comeBack)
self.shipSpine:setChildCanvasGroupAlpha(0)
self:refreshCrew(eAnimationID.run)

self.shipSpine:setChildAnchoredPos(1600,-102)
self.shipSpine:setChildCanvasGroupDOFade(1,0.2)
self.shipDW=self.shipSpine:setChildDOAnchorPosX(167,2,function()
if callback then
pcall(callback)
end
self:refreshShip()
self:refreshCrew()
end)
end
end

function UIWanBaoXunBaoDui_MTSceneWin:playAdventureGo(channel_Id,callback)
if self.selectChannelId==channel_Id then

if self.returnShipDW then
self.returnShipDW:Kill()
self.returnShipDW=nil
end

self.shipSpine:setChildAnchoredPos(167,-102)

AudioManager.playAudio(626)
self.winlua:SetChildSpineAnimation(self.teanShipBg:getID(),WBXBD_Ship_Animation.run,1,nil)
local channelData=self.channelDatas[self.selectChannelIndex]
local teamDatas=channelData.employeeList or{}
for index,itemobj in ipairs(self.crew)do
if teamDatas[index]then
local item=itemobj:getWidgetBase()
item:SetChildModelAnimationState(0,eAnimationID.run)
end
end

self.returnShipDW=self.shipSpine:setChildDOAnchorPosX(200,1,function()

if self.shipDW then
self.shipDW:Kill()
self.shipDW=nil
end

self.shipDW=self.shipSpine:setChildDOAnchorPosX(-2000,3,function()
if callback then
pcall(callback)
end
self:refresh()
end)
self.shipDW:SetEase(_Ease.Linear)
end)
self.returnShipDW:SetEase(_Ease.Linear)
end
end

function UIWanBaoXunBaoDui_MTSceneWin:playAdventureFinishGoOut(callback)
if self.shipDW then
self.shipDW:Kill()
self.shipDW=nil
end

self:refreshCrew()
self.shipSpine:setChildAnchoredPos(167,-102)
self.shipDW=self.shipSpine:setChildDOAnchorPosX(-2000,2,function()
if callback then
callback()
end
end)
self.shipDW:SetEase(_Ease.Linear)
end

function UIWanBaoXunBaoDui_MTSceneWin:playAdventureFinish(channel_Id,employeeList)
if self.selectChannelId==channel_Id then

for k,bt in pairs(self.btTreeList)do
if bt then
behaviorManager:removeBehaviorTree(bt)
end
end

self:refresh()
self.shipSpine:setChildAnchoredPos(167,-102)

for index,cat_guid in pairs(employeeList)do
local crew=wanBaoXunBaoDuiModel:getCatData(cat_guid)
local item=self.crew[index]:getWidgetBase()
local modelid,components=wanbaoXunBaoDuiHelper:getCatModelParam(crew)
item:SetChildUIModelShowTarget(0,modelid,1,components,1,false,false,0,nil)

local initData={
widget=item:GetChildWidgetBase(0),
modelIndex=-1,
startPos=endPosList[index],
endPos=startPosList[index],
stateId=4,
}
self.btTreeList[index]=behaviorManager:addBehaviorTree('bt_ui_wbxbd_employee',nil,true,initData)
end
end
end

function UIWanBaoXunBaoDui_MTSceneWin:playCrewOut(index,cat_guid)
local offset=10

if self.btTreeList[index]then
behaviorManager:removeBehaviorTree(self.btTreeList[index])
self.btTreeList[index]=nil
end

if self.btTreeList[index+offset]then
behaviorManager:removeBehaviorTree(self.btTreeList[index+offset])
self.btTreeList[index+offset]=nil
end
local crew=wanBaoXunBaoDuiModel:getCatData(cat_guid)
local item=self.crew[index]:getWidgetBase()
local modelid,components=wanbaoXunBaoDuiHelper:getCatModelParam(crew)


local initData={
widget=self.winlua,
modelIndex=-1,
startPos=endPosList[index],
endPos=startPosList[index],
stateId=WBXBD_BT_Type.MT_DownShip,
parent=self.memberList:getID(),
target=self.crew[index]:getID(),
moveSpeed=100,

modelScale=1,
modelid=modelid,
componnets=components,
modelIndex=0
}
self.btTreeList[index+offset]=behaviorManager:addBehaviorTree('bt_ui_wbxbd_employee',nil,true,initData)
end

function UIWanBaoXunBaoDui_MTSceneWin:playShipIn(channel_Id)
if self.selectChannelId==channel_Id then

if self.shipDW then
self.shipDW:Kill()
self.shipDW=nil
end

self:refreshCrew()
self:refreshShip()
end
end

function UIWanBaoXunBaoDui_MTSceneWin:destoryAllAnimation()
for k,bt in pairs(self.btTreeList)do
if bt then
behaviorManager:removeBehaviorTree(bt)
end
end

if self.shipDW then
self.shipDW:Kill()
self.shipDW=nil
end
end

function UIWanBaoXunBaoDui_MTSceneWin:setBtState(index,state)
self.btStateList[index]=state
end

local waitList={1,1,1}
function UIWanBaoXunBaoDui_MTSceneWin:playRestoreTili(restore_list)

self.boss:setChildModelAnimationState(WBXBD_CatBOSS_Throw_Finish_Animation_ID[1],1,function()
end)
for k,index in pairs(restore_list)do
if self.btTreeList[index]then
behaviorManager:removeBehaviorTree(self.btTreeList[index])
end

if self.btTreeList[index+100]then
behaviorManager:removeBehaviorTree(self.btTreeList[index+100])
end
local crewWB=self.crew[index]:getWidgetBase()

local initData={
pindex=index,
waitTime=waitList[index],
channelId=self.selectChannelId,
crewWB=crewWB,

speakType=WBXBD_Speak_Type.huifutili,
speakOffset={-30,100},
speakDuration=5,
}
self.btTreeList[index+100]=behaviorManager:addBehaviorTree('bt_ui_wbxbd_restore_tili',nil,true,initData)
end
wanBaoXunBaoDuiModel:setChannelBtState(self.selectChannelId,WBXBD_BT_STATE.restoretili)
end

function UIWanBaoXunBaoDui_MTSceneWin:startRestoreTili(index)
local animationId=WBXBD_CatBOSS_Throw_Finish_Animation_ID[index]
local fish=self.fish[index]
local crewWB=self.crew[index]:getWidgetBase()

fish:setChildSpineAnimation(animationId,1.5,function()
fish:setChildSpineAnimation(eAnimationID.stand,1,nil)
crewWB:SetChildShowEffect(CmpExplorationTeamSlotItemIndex.effect,10500,true)
end)
end

function UIWanBaoXunBaoDui_MTSceneWin:startSpeak(index)

if self.btTreeList[index+100]then
behaviorManager:removeBehaviorTree(self.btTreeList[index+100])
self.btTreeList[index+100]=nil
end

local item=self.crew[index]:getWidgetBase()

local initData={
widget=item,
speakType=WBXBD_Speak_Type.prepara,
startWaitTime=0.5,
endWaitTime=Mathf.Random(6,10),
speakOffset={-30,100},
speakDuration=5,
speakid=1,
stateId=WBXBD_BT_Type.None,
}
self.btTreeList[index]=behaviorManager:addBehaviorTree('bt_ui_wbxbd_employee',{},true,initData)
end

function UIWanBaoXunBaoDui_MTSceneWin:doQuickStartAdventrue(channel_Id,callback)
if self.selectChannelId==channel_Id then
self.isJumpQuickDispath=true
wanBaoXunBaoDuiModel:clearDispathTimer()
self:initData()
local channelData=self.channelDatas[self.selectChannelIndex]
for index=1,3 do
if self.btTreeList[index]then
behaviorManager:removeBehaviorTree(self.btTreeList[index])
self.btTreeList[index]=nil

self.crew[index]:setChildCanvasGroupDOFade(0,0.2,nil)

wanBaoXunBaoDuiModel:resetBtNum(channel_Id)
end
end

local showFunc=function()
for index=1,3 do
local guid=channelData.employeeList[index]
if guid then
local item=self.crew[index]:getWidgetBase()
item:SetChildAnchoredPos(0,0,0)

local crew=wanBaoXunBaoDuiModel:getCatData(guid)
local modelid,components=wanbaoXunBaoDuiHelper:getCatModelParam(crew)
self:freshCatAchiveTx(index)

item:SetChildUIModelShowTarget(0,modelid,1,components,1,false,false,0,nil)

item:SetChildActive(0,true)
item:SetChildActive(1,false)
self.crew[index]:setChildCanvasGroupDOFade(1,0.2,function()
self:startSpeak(index)
end)
end
end
end

self:delayDo(0.3,showFunc)

self:delayDo(0.6,function()
wanBaoXunBaoDuiModel:doOperation({
state=WanBaoXunBaoDuiOperationType.DoTask,
channelId=channelData.channel_Id
})
self.isJumpQuickDispath=false

for k=1,3 do
self.btStateList[k]=false
end
end)
end
end



