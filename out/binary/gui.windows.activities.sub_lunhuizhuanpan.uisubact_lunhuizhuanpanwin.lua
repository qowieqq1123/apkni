







def_class("UISubAct_lunhuizhuanpanWin",UIWindowBase)









function UISubAct_lunhuizhuanpanWin:bindComponents()

self.bgImg=UIObject.get(self,0)
self.bigRewardItem=UIObject.get(self,1)
self.bottomRoot=UIObject.get(self,2)
self.changeRewardBtn=UIButton.get(self,3)
self.effectSmallStone1=UIObject.get(self,4)
self.effectSmallStone2=UIObject.get(self,5)
self.effectStone1=UIObject.get(self,6)
self.effectStone2=UIObject.get(self,7)
self.leftCount=UIText.get(self,8)
self.leftCountBg=UIObject.get(self,9)
self.leftRoot=UIObject.get(self,10)
self.money1Root=UIObject.get(self,11)
self.oneCostDesc=UIText.get(self,12)
self.oneCostIcon=UIImage.get(self,13)
self.oneCostObj=UIObject.get(self,14)
self.oneCostReddot=UIObject.get(self,15)
self.oneEffect=UIObject.get(self,16)
self.oneFreeDesc=UIText.get(self,17)
self.pointer=UIObject.get(self,18)
self.previewContent=UIObject.get(self,19)
self.previewMask=UIButton.get(self,20)
self.rewadProgress=UIObject.get(self,21)
self.rewardContent=UIObject.get(self,22)
self.rewardItem_1=UIObject.get(self,23)
self.rewardItem_2=UIObject.get(self,24)
self.rewardItem_3=UIObject.get(self,25)
self.rewardItem_4=UIObject.get(self,26)
self.rewardItem_5=UIObject.get(self,27)
self.rewardItem_6=UIObject.get(self,28)
self.rewardItem_7=UIObject.get(self,29)
self.rewardNumTxt=UIText.get(self,30)
self.rewardPreviewPanel=UIObject.get(self,31)
self.rewardScrollView=UIObject.get(self,32)
self.root=UIObject.get(self,33)
self.skipBtn=UIButton.get(self,34)
self.skipSelectImg=UIObject.get(self,35)
self.tenCostDesc=UIText.get(self,36)
self.tenCostIcon=UIImage.get(self,37)
self.tenCostObj=UIObject.get(self,38)
self.tenCostReddot=UIObject.get(self,39)
self.tenEffect=UIObject.get(self,40)
self.timeBg=UIObject.get(self,41)
self.timeTxt=UIText.get(self,42)
self.tips=UIObject.get(self,43)
self.topRoot=UIObject.get(self,44)
self.turnTableModel=UIObject.get(self,45)
self.isShowReddotBtn=UIButton.get(self,46)

self.changeRewardBtn:setButtonClick(function()self:onChangeRewardBtn()end)

self.previewMask:setButtonClick(function()self:onPreviewMask()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)
self.rewardItem={
self.rewardItem_1,
self.rewardItem_2,
self.rewardItem_3,
self.rewardItem_4,
self.rewardItem_5,
self.rewardItem_6,
self.rewardItem_7,
}



end


function UISubAct_lunhuizhuanpanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.bigRewardItem);self.bigRewardItem=nil;
_UIObject_release(self.bottomRoot);self.bottomRoot=nil;
_UIObject_release(self.changeRewardBtn);self.changeRewardBtn=nil;
_UIObject_release(self.effectSmallStone1);self.effectSmallStone1=nil;
_UIObject_release(self.effectSmallStone2);self.effectSmallStone2=nil;
_UIObject_release(self.effectStone1);self.effectStone1=nil;
_UIObject_release(self.effectStone2);self.effectStone2=nil;
_UIObject_release(self.leftCount);self.leftCount=nil;
_UIObject_release(self.leftCountBg);self.leftCountBg=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.oneCostDesc);self.oneCostDesc=nil;
_UIObject_release(self.oneCostIcon);self.oneCostIcon=nil;
_UIObject_release(self.oneCostObj);self.oneCostObj=nil;
_UIObject_release(self.oneCostReddot);self.oneCostReddot=nil;
_UIObject_release(self.oneEffect);self.oneEffect=nil;
_UIObject_release(self.oneFreeDesc);self.oneFreeDesc=nil;
_UIObject_release(self.pointer);self.pointer=nil;
_UIObject_release(self.previewContent);self.previewContent=nil;
_UIObject_release(self.previewMask);self.previewMask=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardItem_1);self.rewardItem_1=nil;
_UIObject_release(self.rewardItem_2);self.rewardItem_2=nil;
_UIObject_release(self.rewardItem_3);self.rewardItem_3=nil;
_UIObject_release(self.rewardItem_4);self.rewardItem_4=nil;
_UIObject_release(self.rewardItem_5);self.rewardItem_5=nil;
_UIObject_release(self.rewardItem_6);self.rewardItem_6=nil;
_UIObject_release(self.rewardItem_7);self.rewardItem_7=nil;
_UIObject_release(self.rewardNumTxt);self.rewardNumTxt=nil;
_UIObject_release(self.rewardPreviewPanel);self.rewardPreviewPanel=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.tenCostDesc);self.tenCostDesc=nil;
_UIObject_release(self.tenCostIcon);self.tenCostIcon=nil;
_UIObject_release(self.tenCostObj);self.tenCostObj=nil;
_UIObject_release(self.tenCostReddot);self.tenCostReddot=nil;
_UIObject_release(self.tenEffect);self.tenEffect=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.topRoot);self.topRoot=nil;
_UIObject_release(self.turnTableModel);self.turnTableModel=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
self.rewardItem=nil;
end



















local _this
local _rewardCmp={
item=0,
num=1,
numBg=2,
highLight=3,
pointBg=4,
gotFlag=5,
hasFlag=6,
}
local _effectEnter=10545
local _progressWidth=13
local _progressSpeed=370
local _progressPadding=56
local _progressStep=137
local _itemWidth=1030
local _autoWait=10
local _switchDuartion=0.2
local _abName="ui/windows/activities/sub_lunhuizhuanpan/lunhuizhuanpan_atlas_pak.ab"
local bigRewardPosOffset={
Vector3(-133,56.9,0),
Vector3(-188,189.9,0),
Vector3(-133,322.9,0),
Vector3(0,377.9,0),
Vector3(133,322.9,0),
Vector3(188,189.9,0),
Vector3(133,56.9,0),
}
local controlPosOffset={

{Vector3(80,60,0),Vector3(100,80,0)},
{Vector3(80,60,0),Vector3(100,80,0)},
{Vector3(80,60,0),Vector3(100,80,0)},
{Vector3(80,60,0),Vector3(100,80,0)},
{Vector3(-80,60,0),Vector3(-100,80,0)},
{Vector3(-80,60,0),Vector3(-100,80,0)},
{Vector3(-80,60,0),Vector3(-100,80,0)},
}
local _pathType=DG.Tweening.PathType
local _Ease=DG.Tweening.Ease
local pointer_idx=0
local weakGuideId=4145

function UISubAct_lunhuizhuanpanWin:onLoaded(...)
self:bindComponents()
_this=self
pointer_idx=0
self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
end


function UISubAct_lunhuizhuanpanWin:__delete()
self:unbindComponents()
_this=nil
for k,v in pairs(self.fmTweener)do
v:Kill()
end
end




function UISubAct_lunhuizhuanpanWin:onShow(argtable,afterOnloaded)
if self.fmTweener then
for k,v in pairs(self.fmTweener)do
v:Kill()
end
end
self.fmTweener={}

if afterOnloaded then
if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.turnTableModel:getID(),true,true,true)
end
self.bgImg:setChildUIModelShowTarget(6139,1,{},eAnimationID.lhzp_bg_stand)
self.turnTableModel:setChildUIModelShowTarget(6140,1,{},eAnimationID.lhzp_turntable_stand)
end

if argtable then
if argtable.act_id then
self.activityId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self.activityData=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self.actData=self.activityData.data
if not self.activityData or not self.actData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self:caculateTotalLuckCnt()
self.isAnim=false
self:refreshSkipBtn()
self:refreshCostBtn()
self:refreshTargetRewardPanel(false,true)
self:refreshTurntableReward()
self:refreshPreviewReward()
self:refreshLeftCount()
self:refreshIsShowReddotBtn()

self.costItemID=self.config.itemid
self:initMoneyData({{self.costItemID}})

if self.actTimer==nil then
local func=function()
self:refreshActTimer()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end

self.changeRewardBtn:setActive(#self.config.lib>1)
end

function UISubAct_lunhuizhuanpanWin:caculateTotalLuckCnt()
self.totalLuckCnt=1
local rewardList=self.config.lib[1]
for i,v in ipairs(rewardList)do
if v[2]~=1 then
self.totalLuckCnt=self.totalLuckCnt+v[3]
end
end
end

function UISubAct_lunhuizhuanpanWin:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(time))
self.timeTxt:setText(time_str)
end

function UISubAct_lunhuizhuanpanWin:rec_newday()
if _this==nil then return end
_this:refreshCostBtn()
end

function UISubAct_lunhuizhuanpanWin.on_item_list_changed(argsTable)
if _this==nil then return end
for k,itemdata in ipairs(argsTable or{})do
local itemid=itemdata[3]
local oldcount=itemdata[4]
if itemid==_this.costItemID then
_this:refreshCostBtn()
end
local money=_this.moneyLookup[itemid]
if money then
_this:refreshMoneyItem(money,oldcount)
end
end
end

function UISubAct_lunhuizhuanpanWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
local money=_this.moneyLookup[moneyType]
if money then
_this:refreshMoneyItem(money,lastVal)
end
end

function UISubAct_lunhuizhuanpanWin:initMoneyData(datas)
local moneyList={}
local moneyLookup={}
for i=1,1 do
local data=datas[i]
local moneyType=data[1]
local isAdd=data[2]
local widgetName=FMT.fmt('money{0}Root',i)
local widget=self[widgetName]:getChildWidgetBase()
local d={widget,moneyType,isAdd}
moneyList[i]=d
if moneyType then
moneyLookup[moneyType]=d
end
end
self.moneyList=moneyList
self.moneyLookup=moneyLookup

for i,money in ipairs(self.moneyList)do
self:initMoneyItem(money)
end
end

function UISubAct_lunhuizhuanpanWin:initMoneyItem(money)
local moneyType=money[2]
local widget=money[1]
local isshow=moneyType~=nil
widget:SetChildActive(-1,isshow)
if isshow then
local isAdd=money[3]~=1
local moneyVal
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(1,iconHelper.getIconName(moneyType),false)
widget:SetChildText(2,moneyStr)
widget:SetChildActive(3,isAdd)
widget:SetChildButtonClick(3,function()
if _this==nil then return end
_this:onAddClick(moneyType)
end)
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:clickMoney(moneyType)
end)
end
end

function UISubAct_lunhuizhuanpanWin:refreshMoneyItem(money,lastVal)
local moneyType=money[2]
local widget=money[1]
local isshow=moneyType~=nil
widget:SetChildActive(-1,isshow)
if isshow then
local moneyVal
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end

self:clearFMTweener(moneyType)
self.fmTweener[moneyType]=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(2,moneyStr)
end,moneyVal,1)
end
end

function UISubAct_lunhuizhuanpanWin:onAddClick(moneyType)
gainControl:showCommonGainWin_item(moneyType)
end

function UISubAct_lunhuizhuanpanWin:clickMoney(moneyType)
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end

function UISubAct_lunhuizhuanpanWin:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UISubAct_lunhuizhuanpanWin:refreshCostBtn()
local hasfree=self.activityData:checkFree()
local itemid=self.config.itemid
local itemnum=1
local fix,str



local needCnt
local haveItem=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)


needCnt=itemnum*1
fix=true
if not hasfree then
if haveItem<needCnt then
fix=false
end
end

if not hasfree then
self.oneCostIcon:setActive(true)
self.oneFreeDesc:setText('')
local iconName=iconHelper.getIconName(itemid)
self.oneCostIcon:setImageIcon(iconName)
str=tostring(needCnt)
if not fix then
str=toColorString(FONT_COLOR.eRedColor,str)
end
self.oneCostDesc:setText(str)
else
self.oneCostIcon:setActive(false)
self.oneCostDesc:setText('')
self.oneFreeDesc:setText('首次免费')
end
self.oneCostReddot:setActive(hasfree)


needCnt=itemnum*10
fix=true
if haveItem<needCnt then
fix=false
end
local iconName=iconHelper.getIconName(itemid)
self.tenCostIcon:setImageIcon(iconName)
str=tostring(needCnt)
if not fix then
str=toColorString(FONT_COLOR.eRedColor,str)
end
self.tenCostDesc:setText(str)
self.tenCostReddot:setActive(fix)
end

function UISubAct_lunhuizhuanpanWin:onOneBtn()
if self.isAnim then
return
end
local select_idx=self.actData.select_idx
if select_idx<=0 then
UIManager.info("请祖师选择轮盘奖励")
self:onChangeRewardBtn()
return
end
local nowTime=Time.realtimeSinceStartup
if self.lotteryTime and(nowTime-self.lotteryTime)<0.5 then
return
end
self.lotteryTime=nowTime
self.activityData:lottery(1)
self.oneEffect:setChildShowEffect(18054,true)
end

function UISubAct_lunhuizhuanpanWin:onTenBtn()
if self.isAnim then
return
end
local select_idx=self.actData.select_idx
if select_idx<=0 then
UIManager.info("请祖师选择轮盘奖励")
self:onChangeRewardBtn()
return
end
local nowTime=Time.realtimeSinceStartup
if self.lotteryTime and(nowTime-self.lotteryTime)<0.5 then
return
end
self.lotteryTime=nowTime
self.activityData:lottery(2)
self.tenEffect:setChildShowEffect(18055,true)
end

function UISubAct_lunhuizhuanpanWin:refreshTargetRewardPanel(anim,isInit)
local target=self.config.stage_reward
local max=#target
local total=self.actData.total_luck_cnt
local stage_reward_idx=self.actData.stage_reward_idx
local curIndex=0
for i,d in ipairs(target)do
if total>=d[1]then
curIndex=i
end
end

self.rewardContent:setChildLayoutGroupCreateItems(max)
local grids=self.rewardContent:getChildLayoutGroupGridList()
local topFlag1=nil
local topFlag2=nil
for i=1,max do
local item=grids[i-1]
local d=target[i]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=i<=stage_reward_idx


local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isGray=not fix
local graynum=(fix and rewardFlag)and 1 or 0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_rewardCmp.item,prop)
item:SetBaseItemClickEvent(_rewardCmp.item,function(...)
if _this==nil then return end
_this:onClickItem(i)
end)

item:SetChildText(_rewardCmp.num,fix and rewardFlag and""or num)

item:SetChildActive(_rewardCmp.hasFlag,fix and not rewardFlag)

item:SetChildActive(_rewardCmp.gotFlag,fix and rewardFlag)

item:SetChildActive(_rewardCmp.pointBg,fix and rewardFlag)

item:SetChildActive(_rewardCmp.highLight,fix and not rewardFlag)

if fix and not topFlag1 then
if not rewardFlag then
topFlag1=i
else
topFlag2=i
end
end


end

self.rewardNumTxt:setText(tostring(total))

local cur_height
if curIndex>=max then
cur_height=max*_progressStep+_progressPadding
elseif curIndex<=0 then
cur_height=total/target[curIndex+1][1]*_progressPadding
else
local rate=(total-target[curIndex][1])/(target[curIndex+1][1]-target[curIndex][1])
cur_height=(curIndex-1+rate)*_progressStep+_progressPadding
end
if anim then
local old_height=self.rewadProgress:getChildSizeDeltaY()
local lerp=math.abs(cur_height-old_height)
self.rewadProgress:setChildDOSizeDelta(Vector2(_progressWidth,cur_height),lerp/_progressSpeed,nil)
else
self.rewadProgress:setChildSizeDelta(_progressWidth,cur_height)
end

if isInit then
self.winlua:ForceLayoutRect(self.rewardContent:getID())
if not self.maxContentPosY then
local viewHeight=self.rewardScrollView:getChildRectHeight()
local contentHight=self.rewardContent:getChildSizeDeltaY()
self.maxContentPosY=math.max(contentHight-viewHeight,0)
end
local y=Mathf.Clamp(((topFlag1 or topFlag2 or 0)-1)*_progressStep,0,self.maxContentPosY)
self.rewardContent:setChildAnchoredPos(0,-y)
end
end

function UISubAct_lunhuizhuanpanWin:onClickItem(index)
if self.isAnim then
return
end
local total=self.actData.total_luck_cnt
local stage_reward_idx=self.actData.stage_reward_idx

local target=self.config.stage_reward
local d=target[index]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=index<=stage_reward_idx

local itemid=reward[1]
if fix and not rewardFlag then
call_activitiesHandle_func("activitiesHandle_lunhuizhuanpan","reqReceiveStageReward",self.activityId,self.subId)
else
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end
end

function UISubAct_lunhuizhuanpanWin:refreshTurntableReward()
local select_idx=self.actData.select_idx
if select_idx<=0 then
weakGuideController:beginGuide(weakGuideId)
end
local luck_lookup=self.actData.luck_lookup
local rewardList=self.config.lib[select_idx]
for idx,v in ipairs(self.rewardItem)do
local item=v:getWidgetBase()
if select_idx>0 then
local reward=rewardList[idx]
if reward then
local items=reward[4][1]
local itemid=items[1]
local count=items[2]
local reward_num=reward[3]
local reward_idx=idx
local luck_num=luck_lookup[reward_idx]or 0
local left_num=reward_num-luck_num
local itemColor=itemsConfig.getItemColor(itemid)
local iconName=iconHelper.getIconName(itemid)

item:SetChildActive(0,true)
item:SetChildScale(0,Vector3.one)
item:SetChildActive(1,true)
item:SetChildScale(1,Vector3.one)
item:SetChildActive(2,true)
item:SetChildCSImageSprite(0,_abName,string.format("image_lunhuipanzhen_pzdk%d",itemColor))
item:SetChildIcon(1,iconName,true)
item:SetChildText(2,count>1 and count or"")
item:SetChildActive(3,left_num<=0)
item:SetChildActive(4,true)
item:SetChildText(5,string.format("<color=%s>%d份</color>",left_num<=0 and"#f36666"or"#F1CE78",left_num))
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onClickTurntableItem(itemid)
end)
item:SetChildActive(9,false)
end
else
item:SetChildActive(0,false)
item:SetChildActive(1,false)
item:SetChildActive(2,false)
item:SetChildActive(3,false)
item:SetChildActive(4,false)
item:SetChildActive(9,true)
end
end

local item=self.bigRewardItem:getWidgetBase()
if select_idx>0 then
local big_rewards=self.config.reward_preview_pro_pr[select_idx][1]
local isRewardList=#big_rewards>1
local reward=big_rewards[1]
local itemid=reward[1]
local count=reward[2]

if isRewardList then
item:SetChildActive(0,true)
item:SetChildCSImageSprite(0,_abName,"image_lunhuipanzhen_pzdk8")
item:SetChildActive(1,false)
item:SetChildActive(2,false)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onClickTurntableItem(itemid,true)
end)
else
local itemColor=itemsConfig.getItemColor(itemid)
local iconName=iconHelper.getIconName(itemid)
item:SetChildActive(0,true)
item:SetChildActive(1,true)
item:SetChildActive(2,true)
item:SetChildCSImageSprite(0,_abName,string.format("image_lunhuipanzhen_pzdk%d",itemColor))
item:SetChildIcon(1,iconName,true)
item:SetChildText(2,count>1 and count or"")
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onClickTurntableItem(itemid)
end)
end
else
item:SetChildActive(0,false)
item:SetChildActive(1,false)
item:SetChildActive(2,false)
end
end

function UISubAct_lunhuizhuanpanWin:onClickTurntableItem(itemid,isBigReward)
if self.isAnim then
return
end
if isBigReward then
local select_idx=self.actData.select_idx
if select_idx>0 then
self.previewMask:setActive(true)
end
else
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end
end

function UISubAct_lunhuizhuanpanWin:rec_lottery(big_rw_cnt,rw_idx,luck_cnt,luck_lookup,luck_type)
local rewardList={}
local rewardIdxLookup={}
local hasLeftReward=false
local select_idx=self.actData.select_idx
local lib=self.config.lib[select_idx]
local max_rare=-1
local show_idx=0
if big_rw_cnt>0 then
local big_reward_idx=rw_idx[big_rw_cnt]
for idx,v in ipairs(lib)do
local itemList=v[4]
local reward_num=v[3]
local reward_idx=idx
local luck_num=luck_lookup[reward_idx]or 0
local left_num=reward_num-luck_num
if left_num>0 and(v[2]~=1 or idx==big_reward_idx)then
if idx==big_reward_idx then
for _,items in ipairs(itemList)do
local itemid=items[1]
local itemnum=items[2]
for i=1,left_num do
table.insert(rewardList,1,{itemid=itemid,num=itemnum})
end
end
else
for _,items in ipairs(itemList)do
local itemid=items[1]
local itemnum=items[2]
for i=1,left_num do
table.insert(rewardList,{itemid=itemid,num=itemnum})
end
end
rewardIdxLookup[reward_idx]=true
hasLeftReward=true
end
end
end
else
for _,idx in ipairs(rw_idx)do
local reward=lib[idx]
local items=reward[4]
for i,v in ipairs(items)do
local itemid=v[1]
local itemnum=v[2]
table.insert(rewardList,{itemid=itemid,num=itemnum})
end





end
show_idx=rw_idx[1]
end

local func=function()
local btnData={}
local timesCfg=self.config.itemnum
local itemId=self.costItemID
for i,v in ipairs(timesCfg)do
local itemNum=v
local callback=function()
if not self.skipFlag then
UIManager:closeWindow("UICommonShowPrizeEightWin")
end
self.activityData:lottery(i)
end
local free=v==1 and self.activityData:checkFree()
local text=free and"本次免费"or FMT.fmt("注灵{0}次",v)
local cost=not free and{itemId,itemNum}or nil
local bData={
text=text,
cost=cost,
callback=callback,
}
table.insert(btnData,bData)
end
local moneyIconName=iconHelper.getIconName(self.costItemID)
local attempt_luck_cnt=timesCfg[luck_type]
local tipsStr=(big_rw_cnt>0 and(attempt_luck_cnt-big_rw_cnt)>0)and FMT.fmt("<color=#cacaca>第{0}次注灵已获得大奖！现返还</color>quad-icon={1}-quad {2}",big_rw_cnt,moneyIconName,attempt_luck_cnt-big_rw_cnt)
local args={
list=rewardList,
tips=tipsStr,
tipsSize=24,
btnData=btnData,
closeTips="点击屏幕领取奖励",
effect={},
moneytypes={{self.costItemID}},



}
local showResultFunc=function()
UIManager:showWindow('UICommonShowPrizeEightWin',args)
self:lotteryRefresh()
self.isAnim=false
self:setUIAlpha(1,0.8)
end

pointer_idx=show_idx
if show_idx>0 then

local item=self.rewardItem[show_idx]:getWidgetBase()
item:SetChildShowEffect(7,18051,true)
else

local bigRewardItem=self.bigRewardItem:getWidgetBase()
bigRewardItem:SetChildShowEffect(4,18051,true)
end

if self.skipFlag then
showResultFunc()
else
if show_idx>0 then
self:delayDo(0.3,showResultFunc)
else

local bigRewardItem=self.bigRewardItem:getWidgetBase()
bigRewardItem:SetChildShowEffect(3,18050,true)
args.closeCallback=function()
bigRewardItem:SetChildShowEffect(3,18050,false)
end

for idx,_ in pairs(rewardIdxLookup)do
local item=self.rewardItem[idx]:getWidgetBase()
item:SetChildShowEffect(6,18060,true)

item:SetChildDOScale(0,0,0.7)
item:SetChildDOScale(1,0,0.7)
item:SetChildActive(2,false)
item:SetChildActive(4,false)
end

local isSetAction=false
for idx,_ in pairs(rewardIdxLookup)do
local item=self.rewardItem[idx]:getWidgetBase()
local tran=item:GetCommonComponent(8,"Transform")
item:SetChildAnchoredPos(8,0,0)
item:SetChildShowEffect(8,18062,true)
local endPosOffset=bigRewardPosOffset[idx]
local controlPos1,controlPos2=unpack(controlPosOffset[idx])
local completeFunc=function()
item:SetChildShowEffect(8,18062,false)
end
if not isSetAction then
isSetAction=true
completeFunc=function()
local bigRewardItem=self.bigRewardItem:getWidgetBase()
bigRewardItem:SetChildShowEffect(3,18061,true)
item:SetChildShowEffect(8,18062,false)
end
end
local tweener=_DOTweenProxy.DoLocalPath(tran,{endPosOffset,controlPos1,controlPos2},1,_pathType.CubicBezier)

tweener:SetDelay(0.7)
tweener:OnComplete(completeFunc)
end
local delay=0.3
if hasLeftReward then
delay=2.5
end
self:delayDo(delay,showResultFunc)
end
end
end

local turnIdx=show_idx
local turns=2
local angle=(turnIdx*-45)+(-360*turns)
if self.skipFlag then
self:playTurntableAnim(angle,0,func)
else
self.isAnim=true

self:setUIAlpha(0,0.3)

local animId=luck_type==1 and eAnimationID.lhzp_turntable_one or eAnimationID.lhzp_turntable_ten
self.turnTableModel:setChildModelAnimationState(animId,1)
local delay=0.3

self:delayDo(delay,function()
self.effectStone1:setChildShowEffect(18057,true)
self.effectStone2:setChildShowEffect(18057,true)
end)
delay=delay+0.25
self:delayDo(delay,function()
self.effectSmallStone1:setChildShowEffect(18058,true)
self.effectSmallStone2:setChildShowEffect(18058,true)
end)
delay=delay+0.1
self:delayDo(delay,function()
self:playTurntableAnim(angle,2,func)
end)
end
end

function UISubAct_lunhuizhuanpanWin:setUIAlpha(alpha,duration)
self.leftRoot:setChildCanvasGroupDOFade(alpha,duration)
self.rewardScrollView:setChildCanvasGroupDOFade(alpha,duration)
self.tips:setChildCanvasGroupDOFade(alpha,duration)
self.leftCountBg:setChildCanvasGroupDOFade(alpha,duration)
self.timeBg:setChildCanvasGroupDOFade(alpha,duration)
self.oneCostObj:setChildCanvasGroupDOFade(alpha,duration)
self.tenCostObj:setChildCanvasGroupDOFade(alpha,duration)
UIManager:invokeUIMethod(self.parentWin,'fadeRoot',alpha,duration)
end

function UISubAct_lunhuizhuanpanWin:test(idx)
local idxT={idx}
if idx<=0 then
idxT={1,2,3,4,5,6,7}
end

for _,idx in ipairs(idxT)do
local item=self.rewardItem[idx]:getWidgetBase()
item:SetChildShowEffect(6,18060,true)

item:SetChildDOScale(0,0,1)
item:SetChildDOScale(1,0,1)
item:SetChildActive(2,false)
item:SetChildActive(4,false)
end

local isSetAction=false
for _,idx in ipairs(idxT)do
local item=self.rewardItem[idx]:getWidgetBase()
local tran=item:GetCommonComponent(8,"Transform")
item:SetChildAnchoredPos(8,0,0)
item:SetChildShowEffect(8,18062,true)
local endPosOffset=bigRewardPosOffset[idx]
local controlPos1,controlPos2=unpack(controlPosOffset[idx])
local completeFunc=function()
item:SetChildShowEffect(8,18062,false)
end
if not isSetAction then
isSetAction=true
completeFunc=function()
local bigRewardItem=self.bigRewardItem:getWidgetBase()
bigRewardItem:SetChildShowEffect(3,18061,true)
item:SetChildShowEffect(8,18062,false)
end
end
local tweener=_DOTweenProxy.DoLocalPath(tran,{endPosOffset,controlPos1,controlPos2},1,_pathType.CubicBezier)

tweener:SetDelay(0.7)
tweener:OnComplete(completeFunc)
end
self:delayDo(2.5,function()
self:lotteryRefresh()
end)
end

function UISubAct_lunhuizhuanpanWin:playTurntableAnim(angle,duration,func)

if pointer_idx>0 then
local item=self.rewardItem[pointer_idx]:getWidgetBase()
item:SetChildShowEffect(7,18051,false)
else
local bigRewardItem=self.bigRewardItem:getWidgetBase()
bigRewardItem:SetChildShowEffect(4,18051,false)
end
angle=Vector3(0,0,angle)
duration=duration or 2
self.pointer:setChildDORotation(angle,duration,DG.Tweening.RotateMode.FastBeyond360,func):SetEase(_Ease.InOutQuad)
end

function UISubAct_lunhuizhuanpanWin:refreshPreviewReward()
local select_idx=self.actData.select_idx
if select_idx<=0 then return end
local rewards=self.config.reward_preview_pro_pr[select_idx][1]
self.previewContent:setChildLayoutGroupCreateItems(#rewards,function(index)
local item=self.previewContent:getChildLayoutGroupGridItem(index-1)
local reward=rewards[index]
local itemid=reward[1]
local count=reward[2]
local pr=reward[3]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local graynum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
itemsComponentHelper.onItemClickEx(...)
end)
item:SetChildText(1,FMT.fmt("{0}%",pr/100))
end)
end

function UISubAct_lunhuizhuanpanWin:refreshLeftCount()
local round_luck_cnt=self.actData.round_luck_cnt
self.leftCount:setText(self.totalLuckCnt-round_luck_cnt)
end

function UISubAct_lunhuizhuanpanWin:lotteryRefresh()
self:refreshCostBtn()
self:refreshTargetRewardPanel(true,false)
self:refreshTurntableReward()
self:refreshLeftCount()
end

function UISubAct_lunhuizhuanpanWin:changeRewardLibRefresh()
for idx,v in ipairs(self.rewardItem)do
local item=v:getWidgetBase()
item:SetChildDORotation(0,Vector3(0,90,0),0.125,DG.Tweening.RotateMode.FastBeyond360)
item:SetChildDORotation(1,Vector3(0,90,0),0.125,DG.Tweening.RotateMode.FastBeyond360,function()
item:SetChildDORotation(0,Vector3(0,0,0),0.125,DG.Tweening.RotateMode.FastBeyond360)
item:SetChildDORotation(1,Vector3(0,0,0),0.125,DG.Tweening.RotateMode.FastBeyond360,function()
item:SetChildShowEffect(6,18059,true)
end)
end)
end
local item=self.bigRewardItem:getWidgetBase()
item:SetChildDORotation(0,Vector3(0,90,0),0.125,DG.Tweening.RotateMode.FastBeyond360)
item:SetChildDORotation(1,Vector3(0,90,0),0.125,DG.Tweening.RotateMode.FastBeyond360,function()
self:refreshTurntableReward()
item:SetChildDORotation(0,Vector3(0,0,0),0.125,DG.Tweening.RotateMode.FastBeyond360)
item:SetChildDORotation(1,Vector3(0,0,0),0.125,DG.Tweening.RotateMode.FastBeyond360,function()
item:SetChildShowEffect(3,18059,true)
end)
end)
self:refreshPreviewReward()
end

function UISubAct_lunhuizhuanpanWin:onChangeRewardBtn()
if self.isAnim then
return
end
local lib=self.config.lib
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
lib=lib,
}
self:showWindow("UISubAct_lunhuizhuanpanSelectWin",args)
end

function UISubAct_lunhuizhuanpanWin:onPreviewMask()
self.previewMask:setActive(false)
end

function UISubAct_lunhuizhuanpanWin:onTipsBtn()

AudioManager.playBtnClick()
if self.isAnim then
return
end
local nullTips
if self.actData.select_idx<=0 then
nullTips="请祖师选择轮盘奖励后再查看"
end
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
reward_idx=self.actData.select_idx,
nullTips=nullTips,
proTitle='大奖道具预览',
normalTitle='珍稀道具预览',
}
oneTabScreenController:openUI(SEC_FULL_TYPE.lotterySecondary_lunhuizhuanpan,args)
end

function UISubAct_lunhuizhuanpanWin:refreshSkipBtn()
if self.skipFlag==nil then
self.skipFlag=self.activityData:getJumpAnimation()
end
self.skipSelectImg:setActive(self.skipFlag)
end

function UISubAct_lunhuizhuanpanWin:onSkipBtn()
if self.isAnim then
return
end
self.skipFlag=not self.skipFlag
self.activityData:setJumpAnimation(self.skipFlag)
self:refreshSkipBtn()
end



function UISubAct_lunhuizhuanpanWin:refreshIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local isForbiddenShowReddot=actInfo:checkIsForbiddenShowReddot()
self.isShowReddotBtn:setActive(not isForbiddenShowReddot)
if isForbiddenShowReddot then
return
end

local isShowReddot=actInfo:checkIsShowReddot()
local btnWidget=self.isShowReddotBtn:getWidgetBase()
btnWidget:SetChildActive(0,not isShowReddot)
btnWidget:SetChildActive(1,isShowReddot)
end

function UISubAct_lunhuizhuanpanWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_lunhuizhuanpanWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.activityId==actId and _this.subType==subType and _this.subId==subId then
_this:refreshIsShowReddotBtn()
end
end
