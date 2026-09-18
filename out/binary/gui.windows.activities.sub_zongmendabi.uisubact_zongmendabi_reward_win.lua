







def_class("UISubAct_zongmendabi_reward_win",UIWindowBase)









function UISubAct_zongmendabi_reward_win:bindComponents()

self.root=UIObject.get(self,0)
self.speakText=UIText.get(self,1)
self.entityPanel=UIObject.get(self,2)
self.rightPanel=UIObject.get(self,3)
self.rewardPoolModel=UIObject.get(self,4)
self.rewardPoolTxt=UIText.get(self,5)
self.rewardPoolEffect=UIObject.get(self,6)
self.npcModel=UIObject.get(self,7)
self.speakObj=UIObject.get(self,8)
self.headSelectGrid=UIObject.get(self,9)
self.headRewardGrid=UIObject.get(self,10)
self.headNoteGrid=UIObject.get(self,11)



end


function UISubAct_zongmendabi_reward_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.entityPanel);self.entityPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.rewardPoolModel);self.rewardPoolModel=nil;
_UIObject_release(self.rewardPoolTxt);self.rewardPoolTxt=nil;
_UIObject_release(self.rewardPoolEffect);self.rewardPoolEffect=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.headSelectGrid);self.headSelectGrid=nil;
_UIObject_release(self.headRewardGrid);self.headRewardGrid=nil;
_UIObject_release(self.headNoteGrid);self.headNoteGrid=nil;
end
















local _this
local maxDZNum=5


function UISubAct_zongmendabi_reward_win:onLoaded(...)
_this=self
self:bindComponents()

local pos=self:getChildCanvas(-1)
local defaultSortLayer=pos[1]
local defaultSortOrder=pos[2]

self.rewardPoolEffect:setChildShowEffect(10222,true)

self.enityWidgetList={}
self.entityPanel:setChildLayoutGroupCreateItems(maxDZNum)
local grids=self.entityPanel:getChildLayoutGroupGridList()
for i=1,maxDZNum do
local entityWidget=grids[i-1]
self.enityWidgetList[i]=entityWidget
end
self.entityPanel:setChildCanvas(defaultSortLayer,defaultSortOrder+2)
self.rightPanel:setChildCanvas(defaultSortLayer,defaultSortOrder+3)
self.posDataLookup={}

self.allDZLookup={}
local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
for k,v in pairs(all)do
local netData=v.netData.net
self.allDZLookup[netData.discipleguidStr]={netData.discipleguid,netData.discipleguidStr}
end
end
end


function UISubAct_zongmendabi_reward_win:__delete()
_this=nil
self:unbindComponents()
self:clearAllEntity()
end


function UISubAct_zongmendabi_reward_win:onHide()
if self.myTimer~=nil then
self:stopTimerByID(self.myTimer)
self.myTimer=nil
end
self:clearTalk()
end




function UISubAct_zongmendabi_reward_win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.tab_idx=argtable.tab_idx

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self:refreshRewardPool()
self:refreshHeadReward()
self:initNotesList()
self:refreshNotesGrid()

if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:onMyUpdate()
end)
end
self.sub_actInfo:checkPoolNoteList()

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.rewardPoolModel:setChildUIModelShowTarget(4042,1,{},0,false,false,0,function()
if _this==nil then return end
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
self.npcModel:setChildUIModelShowTarget(4015,0.25,{},0,false,false,0,nil)
self.npcModel:setChildUIModelShowFlipX(true)
end
self:playSpeak(1,2)

self:initAutoAddDZAnim()
end

function UISubAct_zongmendabi_reward_win:onMyUpdate()
self.sub_actInfo:checkPoolNoteList()
end

function UISubAct_zongmendabi_reward_win:refreshRewardPool()
local poolnum=self.myData.item_pool_num
local pool_str=FMT.fmt('灵玉奖池：<color=#171311>{0}</color>',poolnum)
self.rewardPoolTxt:setText(pool_str)
end

function UISubAct_zongmendabi_reward_win:refreshHeadReward()
if self.curHeadReward==nil then
self.curHeadReward=1
end
self.headSelectGrid:setChildLayoutGroupCreateItems(3)
local grids=self.headSelectGrid:getChildLayoutGroupGridList()
for i=1,3 do
local item=grids[i-1]
local name=activitiesHandle_zongmendabi.getRaceLevelName(self.subid,i)
item:SetChildText(1,name)
self:refreshHeadRewardSelect(item,i,self.curHeadReward==i)
item:SetChildButtonClick(-1,function()
if _this==nil then return end
self:onHeaRewardItemClick(i)
end)
end
self:refreshHeadRewardGrid()
end

function UISubAct_zongmendabi_reward_win:refreshHeadRewardSelect(item,idx,flag)
if item==nil then
item=self.headSelectGrid:getChildLayoutGroupGridItem(idx-1)
end
item:SetChildActive(0,flag)
end

function UISubAct_zongmendabi_reward_win:onHeaRewardItemClick(idx)
if self.curHeadReward==idx then return end

self:refreshHeadRewardSelect(nil,self.curHeadReward,false)
self:refreshHeadRewardSelect(nil,idx,true)
self.curHeadReward=idx
self:refreshHeadRewardGrid()
end

function UISubAct_zongmendabi_reward_win:refreshHeadRewardGrid()
local idx=self.curHeadReward
local bgicon
local effectid
if idx==3 then
bgicon='image_zongmendabijlui_3'
effectid=10211
elseif idx==2 then
bgicon='image_zongmendabijlui_2'
effectid=10212
else
bgicon='image_zongmendabijlui_1'
effectid=10213
end
local rewards=self.sub_actInfo:getHeadReward(idx)
self.headRewardGrid:setChildLayoutGroupCreateItems(#rewards)
local grids=self.headRewardGrid:getChildLayoutGroupGridList()
for i=1,#rewards do
local reward=rewards[i]
local item=grids[i-1]
local itemid=reward.itemid
local itemnum=reward.itemcount
local showCountBG=false
if itemnum>1 then
showCountBG=true
end
item:SetChildActive(1,showCountBG)
if showCountBG then
item:SetChildText(2,tostring(itemnum))
end
local showSign=itemsConfig.isFabao(itemid)
item:SetChildActive(5,showSign)
local iconName=itemsModel.getIconName(reward)
item:SetChildCSImageIcon(0,iconName,true)
item:SetChildCSImageSprite(3,globalABLookup.zonmengdabi_baoming,bgicon)
item:SetChildButtonClick(-1,function()
if _this==nil then return end
_this:onClickItem(idx,i)
end)

local name_str=FMT.fmt('第{0}名',i)
item:SetChildText(4,name_str)
item:SetChildShowEffect(6,effectid,true)
end
end

function UISubAct_zongmendabi_reward_win:onClickItem(idx,idx_)
local rewards=self.sub_actInfo:getHeadReward(idx)
local reward=rewards[idx_]
local itemguid=reward.itemguid
local itemid=reward.itemid
local watch=watchModel.getItem(itemguid)
if watch==nil then
watchModel.setItem(reward)
end
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_zongmendabi_reward_win:initNotesList()
local notesList={}
if self.myData.recordList then
for i,v in ipairs(self.myData.recordList)do
notesList[i]=v
end
end
if#notesList>1 then
table.sort(notesList,function(a,b)
return a.guid>b.guid
end)
end
self.notesList=notesList
end

function UISubAct_zongmendabi_reward_win:refreshNotesGrid()
self.headNoteGrid:setChildLayoutGroupCreateItems(#self.notesList)
local grids=self.headNoteGrid:getChildLayoutGroupGridList()
for i=1,#self.notesList do
local note=self.notesList[i]
local item=grids[i-1]
local str=FMT.fmt('<color=#ca631d>{0}</color>添加<color=#984e0d>{1}灵玉彩头</color>',note.zm_name,note.add_num)
item:SetChildText(0,str)
end
end


function UISubAct_zongmendabi_reward_win:playSpeak(speakIndex,delay)
self:clearTalk()
self.speakIndex=speakIndex
if delay~=nil and delay>0 then
self.nextTalkTimer=self:delayDo(delay,function()
self.nextTalkTimer=nil
self:doSpeaking()
end)
else
self:doSpeaking()
end
end

function UISubAct_zongmendabi_reward_win:doSpeaking()
local talkarr=self.sub_actcfg.talklist[self.speakIndex]
local speakStr=table.randomIndex(talkarr)
self.speakObj:setChildCanvasGroupAlpha(1)
local speed=30
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim()
self.npcModel:setChildModelAnimationState(eAnimationID.button_click)
self.modelSpeakAnimTimer=self:delayDo(2.6,function()
self.npcModel:setChildModelAnimationState(eAnimationID.stand)
end)

self.talkLifeTimer=self:delayDo(5,function()
self.talkLifeTimer=nil
self:finishSpeak()
end)
end

function UISubAct_zongmendabi_reward_win:doTalkAnim()
self.speakObj:setScale(Vector3.zero)
self.delayTalkTimer=self:delayDo(0.5,function()
self.delayTalkTimer=nil
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
end)
end)
end)
end

function UISubAct_zongmendabi_reward_win:finishSpeak()
self.speakObj:setChildCanvasGroupAlpha(0)

self:playSpeak(1,5)
end

function UISubAct_zongmendabi_reward_win:clearTalk()
self.speakIndex=nil
if self.nextTalkTimer~=nil then
self:stopTimerByID(self.nextTalkTimer)
self.nextTalkTimer=nil
end
if self.talkLifeTimer~=nil then
self:stopTimerByID(self.talkLifeTimer)
self.talkLifeTimer=nil
end
if self.modelSpeakAnimTimer~=nil then
self:stopTimerByID(self.modelSpeakAnimTimer)
self.modelSpeakAnimTimer=nil
end
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
if self.delayTalkTimer~=nil then
self.delayTalkTimer=nil
end
self.speakObj:setChildCanvasGroupAlpha(0)
end





function UISubAct_zongmendabi_reward_win:testPlay()
local entData=self:addEnity()
if entData then
self:doDZAnim(entData)
end
end

function UISubAct_zongmendabi_reward_win:initAutoAddDZAnim()
if self.delayAddDZAnimTimer~=nil then
self:stopTimerByID(self.delayAddDZAnimTimer)
self.delayAddDZAnimTimer=nil
end
if self.autoAddDZAnimTimer~=nil then
self:stopTimerByID(self.autoAddDZAnimTimer)
self.autoAddDZAnimTimer=nil
end
local r=math.random(2.1,3.1)
self.delayAddDZAnimTimer=self:delayDo(r,function()
self.delayAddDZAnimTimer=nil
self:autoAddDZ()
end)
end

function UISubAct_zongmendabi_reward_win:autoAddDZ()
self:addDZAnim(1)
local r=math.random(9.1,11.1)
self.autoAddDZAnimTimer=self:delayDo(r,function()
self.autoAddDZAnimTimer=nil
self:autoAddDZ()
end)
end

function UISubAct_zongmendabi_reward_win:addDZAnim(rnd_num)
if rnd_num==1 then
self:addDZAnimEx()
elseif rnd_num>1 then
local num=math.random(1,rnd_num)
local waitTime=0
for i=1,num do
self:addDZAnimEx(waitTime)
waitTime=waitTime+0.2
end
end
end

function UISubAct_zongmendabi_reward_win:addDZAnimEx(waitTime)
waitTime=waitTime or 0
if deviceHelper.getAPILevel()>=4 then
local entData=self:addEnity()
if entData then
self:doDZAnim(entData,waitTime)
end
end
end

function UISubAct_zongmendabi_reward_win:addEnity()

local idx
local temp={}
for idx=1,maxDZNum do
if self.posDataLookup[idx]==nil then
table.insert(temp,idx)
end
end
if#temp>1 then
idx=table.randomIndex(temp)
else
idx=temp[1]
end
if idx==nil then return end

local dis_guid_str
local temp2={}
for k,dz in pairs(self.allDZLookup)do
table.insert(temp2,dz)
end
local dz_=table.randomIndex(temp2)
dis_guid_str=dz_[2]

local entData=self:initEnity(dis_guid_str,idx)
return entData
end

function UISubAct_zongmendabi_reward_win:initEnity(dis_guid_str,idx)
local old_entData=self.posDataLookup[idx]
if old_entData~=nil then
self:removeEntity(idx)
end

local dz=self.allDZLookup[dis_guid_str]
local dis_guid=dz[1]
local entityWidget=self.enityWidgetList[idx]
local offsetX=0
local fadeIn=0.6
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dis_guid,true,nil,nil)
entityWidget:SetChildUIModelShowTarget(0,modelParams.body,1,modelParams.componets,0,false,false,0,nil)
entityWidget:SetChildCanvasGroupAlpha(0,1)
entityWidget:SetChildActive(0,false)

local entData={}
entData.dis_guid=dis_guid
entData.dis_guid_str=dis_guid_str
entData.index=idx
self.posDataLookup[idx]=entData
return entData
end

function UISubAct_zongmendabi_reward_win:removeEntity(idx)
local oldData=self.posDataLookup[idx]
if oldData~=nil then
if oldData.bt then
behaviorManager:removeBehaviorTree(oldData.bt)
oldData.bt=nil
end
local entityWidget=self.enityWidgetList[idx]
entityWidget:SetChildUIModelRemoveTarget(0)
self.posDataLookup[idx]=nil
end
end

function UISubAct_zongmendabi_reward_win:clearAllEntity()
for idx,entData in pairsBySortKey(self.posDataLookup)do
local entityWidget=self.enityWidgetList[idx]
if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
entityWidget:SetChildUIModelRemoveTarget(0)
end
self.posDataLookup=nil
end

function UISubAct_zongmendabi_reward_win:doDZAnim(entData,waitTime)
waitTime=waitTime or 0
if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
local idx=entData.index
local entityWidget=self.enityWidgetList[idx]
entityWidget:SetChildCanvasGroupAlpha(0,1)
local initData={
dzWidget=entityWidget,
dzIndex=0,
dzEffIndex=2,
entIndex=idx,
waitTime=waitTime,
}
local bt=behaviorManager:addBehaviorTree('bt_ui_zongmendabi_pool',nil,true,initData)
bt:setSharedVar('UIstateId',idx)
entData.bt=bt
end


function UISubAct_zongmendabi_reward_win:levelBack(idx)
local entData=self.posDataLookup[idx]
if entData==nil then return end

if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
local entityWidget=self.enityWidgetList[idx]
entityWidget:SetChildCanvasGroupAlpha(0,0)
self.posDataLookup[idx]=nil
end


function UISubAct_zongmendabi_reward_win:onSpeak(idx)
if self.speakIndex~=2 then
self:playSpeak(2,0)
end
end


function UISubAct_zongmendabi_reward_win:rec_notes(notes)
if notes and#notes>0 then
local cnt=0
for i,v in ipairs(notes)do
table.insert(self.notesList,1,v)
cnt=cnt+1
end
if cnt==1 then
self:addDZAnim(1)
elseif cnt>1 then
self:addDZAnim(2)
end
self:refreshNotesGrid()
end
end