







def_class("UISubAct_fabaoshilian_win",UIWindowBase)









function UISubAct_fabaoshilian_win:bindComponents()

self.frameSp=UIObject.get(self,0)
self.costIcon=UIImage.get(self,1)
self.rewadProgress=UIObject.get(self,2)
self.battleBtnTxt=UIText.get(self,3)
self.battleReddot=UIObject.get(self,4)
self.monsterModel=UIObject.get(self,5)
self.monsterShadow=UIObject.get(self,6)
self.monsterSmoke=UIObject.get(self,7)
self.rewardScrollView=UIObject.get(self,8)
self.monsterRoot=UIObject.get(self,9)
self.battleBtn=UIButton.get(self,10)
self.costText=UIText.get(self,11)
self.rewardGrid=UIObject.get(self,12)
self.rewardProgressBar=UIObject.get(self,13)
self.root=UIObject.get(self,14)
self.monsterNameTxt=UIText.get(self,15)
self.baoxiangReddot=UIObject.get(self,16)
self.baoxiangClose=UIObject.get(self,17)
self.baoXiangOpen=UIObject.get(self,18)
self.costObj=UIObject.get(self,19)
self.baoxiangBtn=UIButton.get(self,20)
self.rewardGridPanel=UIObject.get(self,21)
self.timeTxt=UIText.get(self,22)
self.buffGridPanel=UIObject.get(self,23)
self.fabaoItem=UIObject.get(self,24)
self.rewardContent=UIObject.get(self,25)

self.battleBtn:setButtonClick(function()self:onBattleBtn()end)

self.baoxiangBtn:setButtonClick(function()self:onBaoxiangBtn()end)



end


function UISubAct_fabaoshilian_win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.battleBtnTxt);self.battleBtnTxt=nil;
_UIObject_release(self.battleReddot);self.battleReddot=nil;
_UIObject_release(self.monsterModel);self.monsterModel=nil;
_UIObject_release(self.monsterShadow);self.monsterShadow=nil;
_UIObject_release(self.monsterSmoke);self.monsterSmoke=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.monsterRoot);self.monsterRoot=nil;
_UIObject_release(self.battleBtn);self.battleBtn=nil;
_UIObject_release(self.costText);self.costText=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.monsterNameTxt);self.monsterNameTxt=nil;
_UIObject_release(self.baoxiangReddot);self.baoxiangReddot=nil;
_UIObject_release(self.baoxiangClose);self.baoxiangClose=nil;
_UIObject_release(self.baoXiangOpen);self.baoXiangOpen=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.baoxiangBtn);self.baoxiangBtn=nil;
_UIObject_release(self.rewardGridPanel);self.rewardGridPanel=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.buffGridPanel);self.buffGridPanel=nil;
_UIObject_release(self.fabaoItem);self.fabaoItem=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
end
















local _this


function UISubAct_fabaoshilian_win:onLoaded(...)
_this=self
self:bindComponents()
end


function UISubAct_fabaoshilian_win:__delete()
_this=nil
self:unbindComponents()
end


function UISubAct_fabaoshilian_win:onHide()

end




function UISubAct_fabaoshilian_win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.tab_idx=argtable.tab_idx
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
if afterOnloaded then
self:initMonsterList()
end

local jumpIndex
if argtable.extraParams then
jumpIndex=argtable.extraParams.jumpIndex
end
if jumpIndex then
self.monsterIndex=jumpIndex
else
if afterOnloaded then
local n=#self.monsterList
for i,d in ipairs(self.monsterList)do
if d:checkReddot(self.sub_actInfo)then
self.monsterIndex=i
break
end
end
if self.monsterIndex==nil then
local data=self.sub_actInfo.data
if data.monidx==0 then
self.monsterIndex=1
elseif data.monidx>=n then
self.monsterIndex=data.monidx
else
local idx_=data.monidx+1
local d_=self.monsterList[idx_]
if d_:checkUnlock(self.sub_actInfo)then
self.monsterIndex=idx_
else
self.monsterIndex=data.monidx
end
end
end
if self.monsterIndex==0 then
self.monsterIndex=1
end
end
end
self.curSelectIdx=self.monsterIndex

if self.myTimer==nil then
self.myTimer=self:setTimer(1,0,function()
self:refreshActTime()
end)
end
self:refreshActTime()

if afterOnloaded then
self.rewardScrollView:setChildCanvasGroupAlpha(0)
self:delayDo(0.01,function()
self.rewardScrollView:setChildCanvasGroupDOFade(1,0.35,nil)
self:refreshSelectPanel(true)
end)
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(5203,1,{},0,false,false,0,function()
if _this==nil then return end
_this:refreshView()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
else
self:refreshSelectPanel()
self:refreshView()
end
end

function UISubAct_fabaoshilian_win:refreshActTime()
local lerp=self.sub_actInfo:getEndLeftTime()
if lerp<0 then
lerp=0
end
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(lerp))
self.timeTxt:setText(time_str)
end

function UISubAct_fabaoshilian_win:initMonsterList()
local list=self.sub_actcfg.monster
self.monsterList={}
local c=#list
for idx,cfg in ipairs(list)do
local d={}
d.idx=idx
d.idx_max=c
d.cfg=cfg
d.checkUnlock=function(self_,sub_actInfo,isWarning)
return sub_actInfo:checkMonsterUnlock(self_.cfg,self_.idx,isWarning)
end
d.checkReddot=function(self_,sub_actInfo)
return sub_actInfo:checkMonsterReddot(self_.cfg,self_.idx)
end
d.checkReddot2=function(self_,sub_actInfo)
return sub_actInfo:checkMonsterReddot2(self_.cfg,self_.idx)
end
d.checkKilled=function(self_,sub_actInfo)
return sub_actInfo:checkKilled(self_.idx)
end
d.getRewardIndex=function(self_,sub_actInfo)
return sub_actInfo:getRewardIndex(self_.cfg,self_.idx)
end
d.isMax=function(self_)
return self_.idx>=self_.idx_max
end
table.insert(self.monsterList,d)
end
end



function UISubAct_fabaoshilian_win:refreshSelectPanel(isInit)
self.speed=400
self.stepWidth=158
local contentOffset={55,55}
self.contentOffset=contentOffset
self.rewardProgressBar:setChildAnchoredPosition(Vector2(contentOffset[1],-4))
self.rewardGrid:setChildAnchoredPosition(Vector2(contentOffset[1],0))

local max=#self.monsterList

self.rewardGrid:setChildLayoutGroupCreateItems(max)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for idx=1,max do
local item=grids[idx-1]

local posX=(idx-1)*self.stepWidth
item:SetChildAnchoredPosition(-1,Vector2(posX,0))

local r=idx%3
local icon_name=r==0 and'image_fabaoshilian_04'or'image_fabaoshilian_03'
item:SetChildCSImageSprite(5,globalABLookup.fabaoshilianicons,icon_name)

item:SetChildButtonClick(0,function(...)
if _this==nil then return end
_this:onSelectItem(idx)
end)
self:refreshItemSelect(item,idx,idx==self.curSelectIdx)
self:refreshItemState(item,idx)
end

local max_width=(max-1)*self.stepWidth+contentOffset[1]+contentOffset[2]
self.rewardContent:setChildSizeDelta(max_width,165)


self:refreshProgress()

if isInit then
self:jumpToItemEx(self.cur_Width)
end
end

function UISubAct_fabaoshilian_win:jumpToItem(idx)
local width=self:calculationWidth(idx)
self:jumpToItemEx(width)
end

function UISubAct_fabaoshilian_win:jumpToItemEx(width)
width=width+self.contentOffset[1]
local sWidth=self.rewardScrollView:getChildRectWidth()
local sWidth_h=sWidth/2
local moveX
if width>sWidth then
moveX=width-sWidth+sWidth_h
local max=#self.monsterList
local max_width=(max-1)*self.stepWidth+self.contentOffset[1]-sWidth_h
if moveX>max_width then
moveX=max_width
end
else
if width>sWidth_h then
moveX=width-sWidth_h
else
moveX=0
end
end
self.rewardContent:setLocalPosX(-moveX)
end

function UISubAct_fabaoshilian_win:refreshItemSelect(item,idx,flag)
if item==nil then
item=self.rewardGrid:getChildLayoutGroupGridItem(idx-1)
end
item:SetChildActive(1,flag)
end

function UISubAct_fabaoshilian_win:refreshItemState(item,idx)
if idx>#self.monsterList then return end
if item==nil then
item=self.rewardGrid:getChildLayoutGroupGridItem(idx-1)
end
local d=self.monsterList[idx]
local isUnlock=d:checkUnlock(self.sub_actInfo)
local isReddot=d:checkReddot(self.sub_actInfo)or d:checkReddot2(self.sub_actInfo)
local isKilled=d:checkKilled(self.sub_actInfo)

local desc_str=FMT.fmt('第{0}关',d.idx)
item:SetChildText(2,desc_str)

item:SetChildImageExGray(5,not isUnlock)

item:SetChildActive(6,isUnlock and isKilled)

item:SetChildActive(3,not isUnlock)

item:SetChildActive(4,isReddot)
end

function UISubAct_fabaoshilian_win:calculationWidth(idx)
local width
if idx>1 then
width=(idx-1)*self.stepWidth
else
width=0
end
return width
end

function UISubAct_fabaoshilian_win:refreshProgress(anim)
local curIndex=self.curSelectIdx
local max=#self.monsterList
local max_width=(max-1)*self.stepWidth
self.rewardProgressBar:setChildSizeDelta(max_width,9)

local max_width_=max_width
local stepWidth_=self.stepWidth
local cur_Width
if curIndex>=max then
cur_Width=max_width_
else
if curIndex>1 then
cur_Width=(curIndex-1)*stepWidth_
else
cur_Width=0
end
end
self.cur_Width=cur_Width

if anim then
local old_width=self.rewardProgressBar:getChildSizeDeltaX()
local lerp=math.abs(cur_Width-old_width)
self.rewadProgress:setChildDOSizeDelta(Vector2(cur_Width,8),lerp/self.speed,nil)
else
self.rewadProgress:setChildSizeDelta(cur_Width,8)
end
end

function UISubAct_fabaoshilian_win:onSelectItem(idx,isjump)
if self.curSelectIdx==idx then return end
local d=self.monsterList[idx]
if not d:checkUnlock(self.sub_actInfo,true)then
return
end
self:refreshItemSelect(nil,self.curSelectIdx,false)
self:refreshItemSelect(nil,idx,true)
self.curSelectIdx=idx
self:refreshView()
if isjump then
self:jumpToItem(idx)
end
end



function UISubAct_fabaoshilian_win:refreshView()
self:refreshMonster()
self:refreshBuffGrid()
self:refreshInfo()

local d=self.monsterList[self.curSelectIdx]
local rewards=d.cfg[4]
local c2=#rewards
self.rewardGridPanel:setChildLayoutGroupCreateItems(c2)
local grids2=self.rewardGridPanel:getChildLayoutGroupGridList()
for i=1,c2 do
local rewardItem=grids2[i-1]
local reward=rewards[i]
local itemid=reward[1]
local itemnum=reward[2]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickGoodItem(...)
end)
end
end

function UISubAct_fabaoshilian_win:refreshMonster()
local d=self.monsterList[self.curSelectIdx]
local monster=d.cfg[2]
local monsterCfg=cfgHelper.get(cfg_monstergroup_get,monster)
local model=monsterCfg.model


self.monsterSmoke:setChildShowEffect(11001,true)
self.monsterRoot:setActive(false)

self.monsterNameTxt:setText(monsterCfg.name)
self.monsterModel:setChildUIModelRemoveTarget()
self:delayDo(0.35,function()
self.monsterRoot:setActive(true)
self.monsterModel:setScale(Vector3(1.5,1.5,1.5))
local modelParam=isometricMapSystem:getModelScales2Pram(model[1],15)
local scale=modelParam[1]or model[2]
self.monsterModel:setChildUIModelShowTarget(model[1],scale,model[3]or{},eAnimationID.stand,false,false,0,function()
if _this==nil then return end
_this.monsterModel:setChildModelAnimationState(eAnimationID.stand)
end)

self.monsterModel:setChildUIModelShowTargetOffset(modelParam[2]or 0,modelParam[3]or 0)
self.monsterShadow:setScale(Vector3(0.7*model[2],0.7*model[2],1))
end)
end

function UISubAct_fabaoshilian_win:refreshBuffGrid()
local d=self.monsterList[self.curSelectIdx]
local bufflist=d.cfg[3]
local c=#bufflist
self.buffGridPanel:setChildLayoutGroupCreateItems(c)
local grids=self.buffGridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local buff=bufflist[i]
local buffId=buff[1]
local buffLv=buff[2]
local bIcon=mysteryEnvironmentEffectModel.getRuleIcon(buffId)
local bStr=mysteryEnvironmentEffectModel.getRuleDesc(buffId,buffLv)

item:SetChildText(1,bStr)
item:SetChildCSImageIcon(0,bIcon,true)

item:SetChildActive(2,i<c)
end

local list=self.sub_actcfg.monster2 or{}
local dd=list[self.curSelectIdx]
self.fabaoItem:setActive(dd~=nil)
if dd~=nil then
local fabaoItemWidget=self.fabaoItem:getChildWidgetBase()
local itemid=dd
local itemcfg=itemsConfig.getConfig(itemid)
local conf={itemid=itemid,itemcount='',showCountBG=false,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
fabaoItemWidget:SetChildPropData(0,prop)
fabaoItemWidget:SetChildText(1,itemcfg.name)
fabaoItemWidget:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onFabaoItemClick()
end)
end
end

function UISubAct_fabaoshilian_win:onFabaoItemClick()
local list=self.sub_actcfg.monster2 or{}
local dd=list[self.curSelectIdx]
if dd then
local itemid=dd
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end
end

function UISubAct_fabaoshilian_win:refreshInfo()
local d=self.monsterList[self.curSelectIdx]
local rewardIdx=d:getRewardIndex(self.sub_actInfo)


local showCost=rewardIdx~=nil and rewardIdx>1
self.costObj:setActive(showCost)
if showCost then
local costs=d.cfg[5][rewardIdx-1]
local cost=costs[1]
self.costIcon:setImageIcon(iconHelper.getIconName(cost[1]),false)
self.costText:setText(tostring(cost[2]))
end

local isReddot=d:checkReddot(self.sub_actInfo)
self:doReddotPunchRotation(isReddot)
self.baoxiangReddot:setActive(isReddot)





self.baoxiangClose:setActive(rewardIdx~=nil)
self.baoXiangOpen:setActive(rewardIdx==nil)

local isKilled=d:checkKilled(self.sub_actInfo)
local btn_str
if isKilled then
if d:isMax()then
btn_str='已击败'
else
local d_=self.monsterList[self.curSelectIdx+1]
if d_:checkUnlock(self.sub_actInfo)then
btn_str='下一关'
else
btn_str='已击败'
end
end
else
btn_str='挑战'
end
self.battleBtnTxt:setText(btn_str)
local isReddot2=d:checkReddot2(self.sub_actInfo)
self:doReddotPunchRotation2(isReddot2)
self.battleReddot:setActive(isReddot2)
end

function UISubAct_fabaoshilian_win:doReddotPunchRotation(isreddot)
if isreddot then
if self.reddotTweener==nil then
self.baoxiangReddot:setRotation(0,0,0)
local tweener=self.baoxiangReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.baoxiangReddot:setRotation(0,0,0)
end
end
end

function UISubAct_fabaoshilian_win:doReddotPunchRotation2(isreddot)
if isreddot then
if self.reddotTweener2==nil then
self.battleReddot:setRotation(0,0,0)
local tweener=self.battleReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener2=tweener
end
else
if self.reddotTweener2~=nil then
self.reddotTweener2:Complete()
self.reddotTweener2:Kill()
self.reddotTweener2=nil
self.battleReddot:setRotation(0,0,0)
end
end
end

function UISubAct_fabaoshilian_win:onClickGoodItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UISubAct_fabaoshilian_win:onBattleBtn()
local d=self.monsterList[self.curSelectIdx]
if not d:checkUnlock(self.sub_actInfo,true)then
return
end
if d:checkKilled(self.sub_actInfo)then
if not d:isMax()then
local idx_jump
local data=self.sub_actInfo.data
local idx=data.monidx
local d_=self.monsterList[idx+1]
if d_ and d_:checkUnlock(self.sub_actInfo)then
idx_jump=idx+1
else
d_=self.monsterList[idx]
if d_ and d_:checkUnlock(self.sub_actInfo)then
idx_jump=idx
end
end
if idx_jump then
self:onSelectItem(idx_jump,true)
end
end
return
end

local idx=self.curSelectIdx
local actID=self.actID
local subType=self.subType
local subid=self.subid
local gwzId=d.cfg[2]
local monsterList=cfgHelper.get2(cfg_monstergroup_get,gwzId,"monList")
local bufflist=d.cfg[3]
local faZeList2Args={}
for i,buff in ipairs(bufflist)do
local fzId=buff[1]
local fzlv=buff[2]
local fzRuleCfg=cfgHelper.getSSlawRule(fzId)
local hasParam=fzRuleCfg.descparm and fzRuleCfg.descparm[fzlv]and true or false
local fzdesc=not hasParam and fzRuleCfg.desc or
string.format(fzRuleCfg.desc,unpack(fzRuleCfg.descparm[fzlv]))
faZeList2Args[#faZeList2Args+1]={name=fzRuleCfg.name,icon=fzRuleCfg.image,desc=fzdesc}
end




local winArgs=
{
enterCallBack=function(selectList,zfId,mapId)
fightLaunchController:sendFight(eBattleLaunch.fabaoshilian,selectList,mapId,zfId,{actID,subid,idx})
end,
enterTxt="法宝试炼",
cancelCallBack=function()

fightController:closeSelectStage()
activitiesController:jump(actID,subType,subid,{jumpIndex=idx})
end,
groupId=gwzId,
monsterList=monsterList,
skipDiscipleStateCheck=true,
skipDiscipleInjuryCheck=true,
statePriorityCheck=false,
showZhenFa=false,
faZeList2Args=faZeList2Args,
faZeList2Default=false,

}
fightController.showPrepareWin(fightPreSelectModel.fightType.fabaoshilian,winArgs)
end

function UISubAct_fabaoshilian_win:onBaoxiangBtn()
local d=self.monsterList[self.curSelectIdx]
if not d:checkKilled(self.sub_actInfo)then
UIManager.info('需要击败怪物才可以获得奖励哦')
return
end
if not d:checkUnlock(self.sub_actInfo)then
return
end
local rewardIdx=d:getRewardIndex(self.sub_actInfo)
if rewardIdx then
local callback=function()
local json_str=jsonHelper.encode({self.curSelectIdx,rewardIdx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
end
if rewardIdx==1 then

callback()
else

local costs=d.cfg[5][rewardIdx-1]
local cost=costs[1]
local itemid=cost[1]
local itemnum=cost[2]
local iconname=iconHelper.getIconName(itemid)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local contentStr=FMT.fmt('是否消耗{0}<color=#7d3b17>{1}</color> 获取宝箱奖励？',iconStr,itemnum)
local show_data={
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
moneySystem:useMoney(itemid,itemnum,callback,WARNING_TYPE.eWarning)
end,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
end
else
UIManager.info('奖励已领取完')
end
end

function UISubAct_fabaoshilian_win:rec_refresh(idx)
self:refreshItemState(nil,idx)
self:refreshItemState(nil,idx+1)
if self.curSelectIdx==idx then
self:refreshInfo()
end
end

function UISubAct_fabaoshilian_win:rec_newday()
local max=#self.monsterList
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for idx=1,max do
local item=grids[idx-1]
self:refreshItemState(item,idx)
end
self:refreshInfo()
end