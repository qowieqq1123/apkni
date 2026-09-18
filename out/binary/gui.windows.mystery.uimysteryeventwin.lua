







def_class("UIMysteryEventWin",UIWindowBase)









function UIMysteryEventWin:bindComponents()

self.BackModel=UIObject.get(self,0)
self.closeClick=UIButton.get(self,1)
self.diziText=UIText.get(self,2)
self.EventGroupImage=UIObject.get(self,3)
self.EventGroupImageMask=UIObject.get(self,4)
self.EventGroupText=UIText.get(self,5)
self.EventListPanel=UIObject.get(self,6)
self.eventTitlle=UIText.get(self,7)
self.itemPanel=UIObject.get(self,8)
self.mask=UIObject.get(self,9)
self.MysteryEventOptionsItem1=UIObject.get(self,10)
self.MysteryEventOptionsItem2=UIObject.get(self,11)
self.MysteryEventOptionsItem3=UIObject.get(self,12)
self.MysteryEventOptionsItem4=UIObject.get(self,13)
self.optionItem_1=UIObject.get(self,14)
self.optionItem_2=UIObject.get(self,15)
self.optionItem_3=UIObject.get(self,16)
self.optionItem_4=UIObject.get(self,17)
self.optionPanel=UIObject.get(self,18)
self.RoleListPanel=UIObject.get(self,19)
self.root=UIObject.get(self,20)
self.tips=UIObject.get(self,21)
self.tipsText=UIText.get(self,22)

self.closeClick:setButtonClick(function()self:onCloseClick()end)
self.optionItem={
self.optionItem_1,
self.optionItem_2,
self.optionItem_3,
self.optionItem_4,
}



end


function UIMysteryEventWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.BackModel);self.BackModel=nil;
_UIObject_release(self.closeClick);self.closeClick=nil;
_UIObject_release(self.diziText);self.diziText=nil;
_UIObject_release(self.EventGroupImage);self.EventGroupImage=nil;
_UIObject_release(self.EventGroupImageMask);self.EventGroupImageMask=nil;
_UIObject_release(self.EventGroupText);self.EventGroupText=nil;
_UIObject_release(self.EventListPanel);self.EventListPanel=nil;
_UIObject_release(self.eventTitlle);self.eventTitlle=nil;
_UIObject_release(self.itemPanel);self.itemPanel=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.MysteryEventOptionsItem1);self.MysteryEventOptionsItem1=nil;
_UIObject_release(self.MysteryEventOptionsItem2);self.MysteryEventOptionsItem2=nil;
_UIObject_release(self.MysteryEventOptionsItem3);self.MysteryEventOptionsItem3=nil;
_UIObject_release(self.MysteryEventOptionsItem4);self.MysteryEventOptionsItem4=nil;
_UIObject_release(self.optionItem_1);self.optionItem_1=nil;
_UIObject_release(self.optionItem_2);self.optionItem_2=nil;
_UIObject_release(self.optionItem_3);self.optionItem_3=nil;
_UIObject_release(self.optionItem_4);self.optionItem_4=nil;
_UIObject_release(self.optionPanel);self.optionPanel=nil;
_UIObject_release(self.RoleListPanel);self.RoleListPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
self.optionItem=nil;
end

















local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local m_sendGuid=nil
local m_selectGuidIndex=nil

local enterTime=1.3
local changeTime=1.5
local textchangeTime=0.2

local isNotQiYu=false


function UIMysteryEventWin:onLoaded(...)
self:bindComponents()
isNotQiYu=false
self.isSelected=nil
self.optionTween={}

self.MysteryEventOption={
self.MysteryEventOptionsItem1,
self.MysteryEventOptionsItem2,
self.MysteryEventOptionsItem3,
self.MysteryEventOptionsItem4,
}


self.RoleListPanel:setChildScrollViewInit(-1,true,function(...)self:OnClickRoleItemCallback(...)end,nil)

local modelId=2042
self.root:setActive(false)
self.BackModel:setChildUIModelShowTarget(modelId,1,{},eAnimationID.common_window_enter,false,false,0,function()
timeEventController.delayDo(0.4,function()
if self and not self.isClose then
self.root:setActive(true)
self:playAnimation(1,enterTime)
end
end)
end)
self.oldBgmId=AudioManager.getCurrentBgm()
self.nowBgmId=AudioManager.getCurrentBgm()
end


function UIMysteryEventWin:__delete()
self:unbindComponents()
if self and(not self.isClose)then
if isNotQiYu then
notifySystem:postNotify(notifyConfig.on_mystery_event_finish,self.sysId,-1,self.oriGroupId)
isNotQiYu=nil
end
end
if self.optionTween and next(self.optionTween)then
for i,v in pairs(self.optionTween)do
v:Kill()
end
end

self.isSelected=nil
m_sendGuid=nil

if self.oldBgmId~=AudioManager.getCurrentBgm()then
if self.oldBgmId then
AudioManager.playBgMusic(self.oldBgmId)
else

local fadeTime=0.5
AudioManager.fadeoutBGMusic(fadeTime)
end
end
end

function UIMysteryEventWin:playAnimation(id,maskTime)
self.root:setAnimatorInteger('nState',id,true)
if maskTime and maskTime>0 then
self.mask:setActive(true)
timeEventController.delayDo(maskTime,function()
if self and(not self.isClose)then
self.mask:setActive(false)
end
end)
end
end




function UIMysteryEventWin:onShow(argtable,afterOnloaded)
if argtable then
self.evtGuid=argtable.guid
self.sysId=argtable.sysId
self.groupId=argtable.groupId
self.team=argtable.guidList
self.resultArgs=argtable.resultArgs
self.eSendType=argtable.eSendType
self.sendParam=argtable.sendParam


if not isNotQiYu then
self.oriGroupId=argtable.groupId
end
else
error("error:group id is null")
return
end
self.groupCfg=MysteryEventModel.get_group_cfg(self.groupId)
if not self.groupCfg then
error(FMT.fmt("error:找不到group id:{0}",self.groupId))
return
end


self.mainCfg=MysteryEventModel.get_group_main_option(self.groupId)
if self.mainCfg then
self.eventTitlle:setText(self.mainCfg.title)
self:refreshEventText(self.mainCfg.text,self.curImage and 0.2)
if self.mainCfg.image then
local image
if type(self.mainCfg.image)=="table"then
image=self.mainCfg.image[1]
local playerSex=playerModel:getActorSex()
local sexIdx=playerSex==1 and 1 or 2
if self.mainCfg.image[sexIdx]then
image=self.mainCfg.image[sexIdx]
end
else
image=self.mainCfg.image
end
self:refreshEventImage(image)
end

local showClose=self.mainCfg.showClose
self.closeClick:setActive(not showClose)
end

self.isSelected=nil


self:changeEventList(nil,true)

self:refreshEventBubTips()

if self:isSingleDisciple()then
self:initTeamList()
self.diziText:setActive(true)
else
self.diziText:setActive(false)
end

if self.groupCfg[1]then
self.optionPanel:setActive(true)

local onRefresh=function()
if self and not self.isClose then
self:initEventList()
if self.mainCfg.isDefaultSelect then
self:OnClickEventItemCallback(1,0)
end

if self.resultArgs then
self:showChangedEventList(self.resultArgs[1],self.resultArgs[2])
self:showChangedEventList2(self.resultArgs[1],self.resultArgs[2])
end
end
end

if self.curImage then
timeEventController.delayDo(textchangeTime,onRefresh)

else
onRefresh()
end
self:playQiYuBGM()
else
self.optionPanel:setActive(false)
if self.mainCfg.isDefaultSelect then
self:OnClickEventItemCallback(1,-1)
end
end
end


function UIMysteryEventWin:playQiYuBGM()
local qiyuBGM=self.groupCfg[1].qiyuBGM
if qiyuBGM and qiyuBGM~=self.nowBgmId then
local fadeTime=0.5
self.nowBgmId=qiyuBGM
AudioManager.playBgMusic(qiyuBGM,fadeTime)
end
end

function UIMysteryEventWin:showEventList(active)
self.EventListPanel:setActive(active)
end

function UIMysteryEventWin:showOptionCount(num)
local count=#self.MysteryEventOption
for i=1,count do
local itemRoot=self.MysteryEventOption[i]
if i>num then
itemRoot:setActive(false)
else
itemRoot:setActive(true)
end
end
end

function UIMysteryEventWin:initEventList()
if not self.groupCfg then
return
end
local itemList={}
local count=#self.MysteryEventOption
for i=1,count do
local itemRoot=self.MysteryEventOption[i]
if self.groupCfg[i]then
itemRoot:setActive(true)
local item=itemRoot:getChildWidgetBase()
local optionCfg=self.groupCfg[i]
local condition=optionCfg.condition or{}
if optionCfg.conditiontype~=nil and optionCfg.conditiontype==3 then
for i,c in ipairs(condition)do
if c[2]==2 then
table.insert(itemList,c[3])
break
end
end
end
item:SetChildActive(1,false)
item:SetChildText(0,optionCfg.choicetext or"")
if optionCfg.conditiontip then
item:SetChildActive(5,true)
item:SetChildText(3,optionCfg.conditiontip[#condition])
else
item:SetChildActive(5,false)
end

if self:haveAllDiscipleCheck(condition)or optionCfg.child==2 then
item:SetChildActive(4,true)
if api_Available_SetChildCSImage()then
item:SetChildCSImage(2,globalABLookup.global,"icon_anpaidizi",true)
else
item:SetChildCSImageSprite(2,globalABLookup.global,"icon_anpaidizi")
end

else
item:SetChildActive(4,(optionCfg.conditiontype~=nil))
if optionCfg.conditiontype then
local flagIcon=iconHelper.getEventIcon(optionCfg.conditiontype)
item:SetChildCSImageIcon(2,flagIcon,false)
end
end



if optionCfg.jumpWithOutResult then
if not isNotQiYu then
isNotQiYu=true
end
end

item:SetChildButtonClick(6,function()self:OnClickEventItemCallback(1,i-1)end)


item:SetChildNewBieComponentId(6,FMT.fmt('UIMysteryEventWin.MysteryEventOptionItem_{0}',i))
else
itemRoot:setActive(false)
end
end

self.itemPanel:setActive(#itemList>0)
if#itemList>0 then
local count=#self.optionItem
for i=1,count do
local itemRoot=self.optionItem[i]
if itemList[i]then
itemRoot:setActive(true)
local item=itemRoot:getChildWidgetBase()
local itemId=itemList[i][1]
local needCount=itemList[i][2]
local have=itemsModel.getCount(itemId)
local countColor=have>=needCount and FONT_TIPS_COLOR_VAL[FONT_COLOR.eGreenColor]or FONT_TIPS_COLOR_VAL[FONT_COLOR.eRedColor]
local countStr=FMT.fmt("<color={1}>{0}</color>",mathHelper.formatNumber(needCount),countColor)
local config=itemsConfig.getConfig(itemId)
item:SetChildQulaity(1,config.color)
item:SetChildCSImageIcon(2,iconHelper.getIconName(itemId),false)
item:SetChildActive(3,needCount>0)
item:SetChildText(4,countStr)
item:SetChildActive(5,true)
item:SetChildText(6,FMT.fmt("拥有：{0}",mathHelper.formatNumber(have)))

local onClickFun=function()
tipsManager.showTips({itemid=itemId,itemguid=nil})
end
item:SetChildButtonClick(0,onClickFun)
else
itemRoot:setActive(false)
end
end
end
end


function UIMysteryEventWin:changeEventList(optionId,setActive)
if(not self)or(self and self.isClose)then
return
end
local count=#self.MysteryEventOption
for i=1,count do
local itemRoot=self.MysteryEventOption[i]
local item=itemRoot:getChildWidgetBase()
if self.optionTween[i]then
self.optionTween[i]:Kill()
self.optionTween[i]=nil
end
if not optionId then
if setActive then
item:SetChildCanvasGroupAlpha(6,1)
end
else
if i~=optionId then
self.optionTween[i]=item:SetChildCanvasGroupDOFade(6,0,textchangeTime,nil)
item:SetChildActive(1,false)
else
item:SetChildCanvasGroupAlpha(6,1)
item:SetChildActive(1,true)
end
end
end
self.itemPanel:setActive(false)
end


function UIMysteryEventWin:showChangedEventList(optionId,resultIndex)
if not self.groupCfg then
return
end
local optionCfg=self.groupCfg[optionId]
if not optionCfg then

return
end
local resultKey=MysteryEventSystem.diceCfg[resultIndex]
if resultKey then
local explain=optionCfg[resultKey.explain]
if explain and explain[2]then
explain=explain[2]
if optionCfg then
self:showOptionCount(0)
end
end
end


end

function UIMysteryEventWin:showChangedEventList2(optionId,resultIndex)
if not self.groupCfg then
return
end
local optionCfg=self.groupCfg[optionId]
if not optionCfg then

return
end
local resultKey=MysteryEventSystem.diceCfg[resultIndex]
if resultKey then
local args=optionCfg[resultKey.args]
if args.image then
self:refreshEventText(optionCfg[resultKey.result],0.2)
self:refreshEventImage(args.image)
else
self:refreshEventText(optionCfg[resultKey.result])
end
self:changeEventList(optionId)
end
end


function UIMysteryEventWin:refreshEventText(txt,delay)
delay=delay or 0
if delay<=0 then
self.EventGroupText:setText(txt or"")
else
timeEventController.delayDo(delay,function()
if self and(not self.isClose)then
self.EventGroupText:setText(txt or"")
end
end)
end
end

function UIMysteryEventWin:refreshEventImage(imageId)
if self.curImage then
self:playAnimation(2,changeTime)
timeEventController.delayDo(changeTime,function()
if self and(not self.isClose)then
self.EventGroupImageMask:setChildIcon(FMT.fmt("image_shijian_{0}",imageId),true)
end
end)
else
self.EventGroupImageMask:setChildIcon(FMT.fmt("image_shijian_{0}",imageId),true)
end
self.EventGroupImage:setChildIcon(FMT.fmt("image_shijian_{0}",imageId),true)
self.curImage=imageId
end

function UIMysteryEventWin:refreshEventImageMask()
if self.curImage then
self.EventGroupImageMask:setChildIcon(FMT.fmt("image_shijian_{0}",self.curImage),true)
end
end

function UIMysteryEventWin:refreshEventConditionTip()

local count=#self.MysteryEventOption
for i=1,count do
local optionCfg=self.groupCfg[i]
if optionCfg then
local item=self.MysteryEventOption[i]:getChildWidgetBase()
local condition=optionCfg.condition or{}
local isMatch,notMatchIndex=self:checkMatchCondition(condition,m_sendGuid)
if optionCfg.conditiontip then
item:SetChildText(3,optionCfg.conditiontip[notMatchIndex])
end
end
end
end

function UIMysteryEventWin:refreshEventBubTips()
if(not self.mainCfg)or(not self.mainCfg.bubTips)then
self.tips:setActive(false)
return
end
self.tipsText:setText(self.mainCfg.bubTips)
self.tips:setActive(true)
end

function UIMysteryEventWin:initTeamList()

local probeTeam=self.team or{}
if#probeTeam>0 then

local condList={}
for i,v in pairs(self.groupCfg)do
local condition=v.condition
if condition then
for _,vv in ipairs(condition)do
table.insert(condList,vv)
end
end
end

self.RoleListPanel:setChildScrollViewCreateGrids(#probeTeam,6)

local grids=self.RoleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local unitType=probeTeam[i].unitType
local guid=probeTeam[i].unitId
local item=grids[i-1]
local blood=probeTeam[i].blood or 100
local maxBlood=probeTeam[i].bloodMax or 100
local name
blood=tonumber(tostring(blood))
item:SetChildActive(2,true)
item:SetChildProgress(2,blood,tonumber(tostring(maxBlood)))

if unitType==fightPreSelectModel.teamEntityType.dizi then
name=UIDiscipleModel:getDiscipleName(guid)
item:SetChildText(0,name)
comHelper.setChildModelRawImage(item,guid,3,0,eHeadCenterType.eHead,nil,blood<=0)
if UIDiscipleModel:checkInjuryType(guid,eInjuryType.eHealth)then
item:SetChildActive(8,false)
else
item:SetChildActive(8,true)
local injury=UIDiscipleModel:getDiscipleInjury(guid)
local injury_icon=eInjuryType:getIcon(injury)
item:SetChildCSImageSprite(5,globalab,injury_icon)
end
elseif unitType==fightPreSelectModel.teamEntityType.npc then
guid=tonumber(tostring(guid))
local npcConfig=fightPreSelectModel.getNPCConfig(guid)
item:SetChildText(0,npcConfig.name)
local imageInfo=fightPreSelectModel.getNPCInSideModel(guid)
if imageInfo then
comHelper.setChildModelRawImageEx(3,item,imageInfo,eHeadCenterType.eHead,nil,blood<=0)
end
item:SetChildActive(8,false)
end

if blood<=0 then
local emotList=cfgHelper.get2(cfg_secretscenebaseconfig_get,1,"deadFace")
local emot=emotList[math.random(1,#emotList)]
item:SetChildActive(6,true)
item:SetChildUIModelShowTarget(6,emot,1,{},eAnimationID.stand)
else
item:SetChildActive(6,false)
end

local num=1

local cond={}
for i,v in ipairs(condList)do
if cond[v[2]]then
if MysteryEventCnd:can_match_condition(v[2],guid,v[3])then
cond[v[2]]=v
end
else
cond[v[2]]=v
end
end

for i,v in pairs(cond)do
local tips=MysteryEventCnd:getTips(v[2],guid,v[3])
if tips then
local tipsItem=item:GetChildWidgetBase(13+num)
item:SetChildActive(13+num,true)
if type(tips)=="table"then
tips=tips[1]
end
tipsItem:SetChildText(0,tips)
num=num+1
if num>=3 then
break
end
end
end
end
end
end

function UIMysteryEventWin:OnClickEventItemCallback(clicknum,index)
if not self.groupCfg then
return
end

if self.isSelected then
return
end

local optionCfg=self.groupCfg[index+1]

local optionId=optionCfg.choiceid


if optionCfg.isleave then
if optionCfg.isleave==2 then
notifySystem:postNotify(notifyConfig.on_mystery_event_break,self.sysId,self.groupId,self.evtGuid)
else
notifySystem:postNotify(notifyConfig.on_mystery_event_finish,self.sysId,self.evtGuid,self.groupId,index+1,0)
end

if isNotQiYu then
UIFullMysteryEventControl:closeUIEX(false)
else
UIFullMysteryEventControl:closeUIEX()
end
MysteryEventModel:set_event_flag(nil)
return
end

local condition=optionCfg.condition or{}
local checkCondition=false
local notMatchIndex=#condition

if self:haveAllDiscipleCheck(condition)or optionCfg.child==2 then
self:showSelectDZList(optionId,condition,optionCfg.conditiontip)
return
end

if optionCfg.child==1 then
if m_sendGuid==nil then
UIManager.error("尚未选择弟子")
return
end
checkCondition,notMatchIndex=self:checkMatchCondition(condition,m_sendGuid,true)
elseif optionCfg.child==0 then
checkCondition=self:OrOneMatchCondition(condition,true)
end


if optionCfg.jumpWithOutResult then
self:onJumpEvent(optionCfg.jumpWithOutResult)
return
end


if checkCondition then
MysteryEventModel:set_select_disciple(m_sendGuid)
local maxDice=MysteryEventModel:get_dice_max_count(self.evtGuid)
if optionCfg.conditiontype and optionCfg.conditiontype==1 and maxDice>0 then
UIFullMysteryEventControl:showWindow("UIMysteryEventDice2Win",{evtGuid=self.evtGuid,sysId=self.sysId,groupId=self.groupId,optionId=optionId,guid=m_sendGuid})
else
if optionCfg.child==1 then
MysteryEventSystem.send_18_7(self.evtGuid,optionId,m_sendGuid,self.sysId)
else
local guidList={}
if self.team then
for i,v in ipairs(self.team)do
if v.unitType~=0 then
table.insert(guidList,type(v.unitId)=="number"and int64.new(v.unitId)or v.unitId)
end
end
end
MysteryEventSystem.send_18_7(self.evtGuid,optionId,guidList,self.sysId)
end
end
self.isSelected=true
self:changeEventList(index+1)
else



end
end

function UIMysteryEventWin:OnClickRoleItemCallback(clicknum,index)
index=index+1
if index==0 then
return
end
local probeTeam=self.team or{}

local unitType=probeTeam[index].unitType
if unitType==fightPreSelectModel.teamEntityType.dizi then
local blood=probeTeam[index].blood
if blood and tonumber(tostring(blood))<=0 then
UIManager.error("阵亡弟子不可选择")
return
end

local oldIndex
if index~=m_selectGuidIndex then
oldIndex=m_selectGuidIndex
end
m_selectGuidIndex=index

local guid=probeTeam[index].unitId

m_sendGuid=guid

local grid=self.RoleListPanel:getChildScrollViewItemWidget(index-1)
if grid then
grid:SetChildActive(4,true)
end
if oldIndex then
grid=self.RoleListPanel:getChildScrollViewItemWidget(oldIndex-1)
if grid then
grid:SetChildActive(4,false)
end
end
else
UIManager.error("临时弟子不可选择")
end


self:refreshEventConditionTip()
end


function UIMysteryEventWin:OnEnable()

end


function UIMysteryEventWin:OnDisable()

end

function UIMysteryEventWin:isSingleDisciple()
for i,v in pairs(self.groupCfg)do
if v.child==1 then
return true
end
end
return false
end

function UIMysteryEventWin:getCurEvtGuid()
return self.evtGuid
end

function UIMysteryEventWin:AllMatchCondition(conditionCfg)
if not next(conditionCfg)then
return true
end
local conditionType,value
local probeTeam=self.team
if not probeTeam then
return false
end
local isMatch=true
for i,v in ipairs(probeTeam)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
local guid=v.unitId
local flag=self:checkMatchCondition(conditionCfg,guid)
if not flag then
isMatch=false
break
end
end
end
return isMatch
end

function UIMysteryEventWin:OrOneMatchCondition(conditionCfg,warring)
if not next(conditionCfg)then
return true
end
local probeTeam=self.team

if not probeTeam then
return false
end
if not next(probeTeam)then
local isMatch=self:checkMatchCondition(conditionCfg,nil,warring)
if isMatch then
return true
end
end
for i,v in pairs(probeTeam)do
if v.unitType==fightPreSelectModel.teamEntityType.dizi then
local guid=v.unitId
local isMatch=self:checkMatchCondition(conditionCfg,guid,warring)
if isMatch then
return true
end

end
end
return false
end

function UIMysteryEventWin:checkMatchCondition(conditionCfg,guid,warring)
if not next(conditionCfg)then
return true
end
local conditionType,value,notMatchIndex
local isMatch=true
for i,v in ipairs(conditionCfg)do
conditionType=v[2]
value=v[3]
if not MysteryEventCnd:can_match_condition(conditionType,guid,value,warring)then
isMatch=false
notMatchIndex=i
break
end
end
if isMatch then

notMatchIndex=#conditionCfg
end
return isMatch,notMatchIndex
end

function UIMysteryEventWin:haveAllDiscipleCheck(conditionCfg)
for i,c in ipairs(conditionCfg)do
if c[1]==2 then
return true
end
end
end

function UIMysteryEventWin:onCloseClick()

notifySystem:postNotify(notifyConfig.on_mystery_event_break,self.sysId,self.groupId,self.evtGuid)
if isNotQiYu then
UIFullMysteryEventControl:closeUIEX(false,true)
else
UIFullMysteryEventControl:closeUIEX(true,true)
end
MysteryEventModel:set_event_flag(nil)
end

function UIMysteryEventWin:onJumpEvent(jumpEvent)
local winParam={sysId=self.sysId,groupId=jumpEvent,guid=self.evtGuid,guidList=self.team}
isNotQiYu=true
self:onShow(winParam)
end


function UIMysteryEventWin:showSelectDZList(optionId,conditionCfg,tipsList)
local conditionStr='要求：'
if tipsList then
for i,v in ipairs(tipsList)do
if i==1 then
conditionStr=FMT.fmt("{0}<color=#a46d20>{1}</color>",conditionStr,v)
else
conditionStr=FMT.fmt("{0}\n   <color=#a46d20>{1}</color>",conditionStr,v)
end

end
else
conditionStr=''
end
local okFunc=function(guidIdxList)
local guidList={}
if guidIdxList then
for i,v in ipairs(guidIdxList)do
if v~=0 then
table.insert(guidList,v)
MysteryEventModel:set_select_disciple(v)
end
end
end
socketManager:send_18_7(self.evtGuid,optionId,#guidList,guidList,self.sysId)
end
self:showWindow("UIMysteryEventDiscipleSelectWin",{titleStr="请选择弟子",condition=conditionCfg,conditionStr=conditionStr,okFunc=okFunc})
end


