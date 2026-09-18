







def_class("UISubAct_XYZPWin",UIWindowBase)









function UISubAct_XYZPWin:bindComponents()

self.bgImg=UIObject.get(self,0)
self.bottomRoot=UIObject.get(self,1)
self.leftCount=UIText.get(self,2)
self.leftCountBg=UIObject.get(self,3)
self.rightRoot=UIObject.get(self,4)
self.money1Root=UIObject.get(self,5)
self.oneCostDesc=UIText.get(self,6)
self.oneCostIcon=UIImage.get(self,7)
self.oneCostObj=UIObject.get(self,8)
self.oneCostReddot=UIObject.get(self,9)
self.oneFreeDesc=UIText.get(self,10)
self.previewContent=UIObject.get(self,11)
self.previewMask=UIButton.get(self,12)
self.rewardNumTxt=UIText.get(self,13)
self.rewardPreviewPanel=UIObject.get(self,14)
self.root=UIObject.get(self,15)
self.skipBtn=UIButton.get(self,16)
self.skipSelectImg=UIObject.get(self,17)
self.tenCostDesc=UIText.get(self,18)
self.tenCostIcon=UIImage.get(self,19)
self.tenCostObj=UIObject.get(self,20)
self.tenCostReddot=UIObject.get(self,21)
self.timeBg=UIObject.get(self,22)
self.timeTxt=UIText.get(self,23)
self.tips=UIObject.get(self,24)
self.centerRoot=UIObject.get(self,25)
self.rewards=UIObject.get(self,26)
self.jdimg=UIObject.get(self,27)
self.xybtn=UIButton.get(self,28)
self.jdtxt=UIText.get(self,29)
self.rewardScrollView=UIObject.get(self,30)
self.rewardContent=UIObject.get(self,31)
self.rewardProgressBar=UIObject.get(self,32)
self.rewadProgress=UIObject.get(self,33)
self.rewardGrid=UIObject.get(self,34)
self.bgImg2=UIObject.get(self,35)
self.rewarditems=UIObject.get(self,36)
self.bgImg3=UIObject.get(self,37)
self.speak1=UIObject.get(self,38)
self.speak2=UIObject.get(self,39)
self.speak3=UIObject.get(self,40)
self.speak4=UIObject.get(self,41)
self.speak5=UIObject.get(self,42)
self.speak6=UIObject.get(self,43)
self.effectpanel=UIObject.get(self,44)
self.effectpanel2=UIObject.get(self,45)
self.bageffect=UIObject.get(self,46)
self.effectpanel3=UIObject.get(self,47)
self.jdreddot=UIObject.get(self,48)
self.xiangxibtn=UIButton.get(self,49)

self.previewMask:setButtonClick(function()self:onPreviewMask()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.xybtn:setButtonClick(function()self:onXybtn()end)

self.xiangxibtn:setButtonClick(function()self:onXiangxibtn()end)



end


function UISubAct_XYZPWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.bottomRoot);self.bottomRoot=nil;
_UIObject_release(self.leftCount);self.leftCount=nil;
_UIObject_release(self.leftCountBg);self.leftCountBg=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.oneCostDesc);self.oneCostDesc=nil;
_UIObject_release(self.oneCostIcon);self.oneCostIcon=nil;
_UIObject_release(self.oneCostObj);self.oneCostObj=nil;
_UIObject_release(self.oneCostReddot);self.oneCostReddot=nil;
_UIObject_release(self.oneFreeDesc);self.oneFreeDesc=nil;
_UIObject_release(self.previewContent);self.previewContent=nil;
_UIObject_release(self.previewMask);self.previewMask=nil;
_UIObject_release(self.rewardNumTxt);self.rewardNumTxt=nil;
_UIObject_release(self.rewardPreviewPanel);self.rewardPreviewPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.tenCostDesc);self.tenCostDesc=nil;
_UIObject_release(self.tenCostIcon);self.tenCostIcon=nil;
_UIObject_release(self.tenCostObj);self.tenCostObj=nil;
_UIObject_release(self.tenCostReddot);self.tenCostReddot=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.centerRoot);self.centerRoot=nil;
_UIObject_release(self.rewards);self.rewards=nil;
_UIObject_release(self.jdimg);self.jdimg=nil;
_UIObject_release(self.xybtn);self.xybtn=nil;
_UIObject_release(self.jdtxt);self.jdtxt=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.bgImg2);self.bgImg2=nil;
_UIObject_release(self.rewarditems);self.rewarditems=nil;
_UIObject_release(self.bgImg3);self.bgImg3=nil;
_UIObject_release(self.speak1);self.speak1=nil;
_UIObject_release(self.speak2);self.speak2=nil;
_UIObject_release(self.speak3);self.speak3=nil;
_UIObject_release(self.speak4);self.speak4=nil;
_UIObject_release(self.speak5);self.speak5=nil;
_UIObject_release(self.speak6);self.speak6=nil;
_UIObject_release(self.effectpanel);self.effectpanel=nil;
_UIObject_release(self.effectpanel2);self.effectpanel2=nil;
_UIObject_release(self.bageffect);self.bageffect=nil;
_UIObject_release(self.effectpanel3);self.effectpanel3=nil;
_UIObject_release(self.jdreddot);self.jdreddot=nil;
_UIObject_release(self.xiangxibtn);self.xiangxibtn=nil;
end
















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

local _pathType=DG.Tweening.PathType
local _Ease=DG.Tweening.Ease
local pointer_idx=0
local weakGuideId=4145


local _this
local rwItemidx=
{
selfitem=0,
reward=1,
flag=2,
lightimg=3,
EFFECT=4,
numbg=5,
num=6
}
local round1=2
local round2=3

local list1={1,5,12}
local list2={2,9,11}
local list3={3,4,7}
local list4={6,10}
local list5={8}

local starEffectOne={22667,22668,22669,22670}
local starEffectTwo1={22671,22672,22673,22674}
local starEffectTwo2={22675,22676,22677,22678}


local starone4=
{
[0]=Vector3(-271,70,0),[1]=Vector3(-122,-79,0),[2]=Vector3(19,49,0),[3]=Vector3(270,-8,0),
}
local startwo4=
{
[0]=Vector3(-217,170,0),[1]=Vector3(-122,-27,0),[2]=Vector3(58,138,0),[3]=Vector3(233,26,0),
}

local starone3=
{
[0]=Vector3(-153,70,0),[1]=Vector3(-16,-79,0),[2]=Vector3(162,49,0),
}
local startwo3=
{
[0]=Vector3(-96,170,0),[1]=Vector3(35,-27,0),[2]=Vector3(212,138,0),
}

local starone2=
{
[0]=Vector3(-120,19,0),[1]=Vector3(124,-84,0),
}
local startwo2=
{
[0]=Vector3(-76,96,0),[1]=Vector3(175,-1,0),
}

local starone1=
{
[0]=Vector3(10,-42,0),
}
local startwo1=
{
[0]=Vector3(58,44,0),
}


function UISubAct_XYZPWin:onLoaded(...)
self:bindComponents()
_this=self
pointer_idx=0
self.fmTweener={}
local list={self.speak1,self.speak2,self.speak3,self.speak4,self.speak5,self.speak6}
self.speakitems={}
for k,v in ipairs(list)do
local widget=v:getWidgetBase()
self.speakitems[#self.speakitems+1]=widget
end
self.talkTween={}
self.speakShowTimer={}
self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UISubAct_XYZPWin:__delete()
self:unbindComponents()
self:initFMTweener()
self:clearTimer()
self:stopExpireTimer()
_this=nil
end


function UISubAct_XYZPWin.on_item_list_changed(argsTable)
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
function UISubAct_XYZPWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
local money=_this.moneyLookup[moneyType]
if money then
_this:refreshMoneyItem(money,lastVal)
end
if _this.wish_consume then
local xymoneyType=_this.wish_consume[1]
if xymoneyType and xymoneyType==moneyType then
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,SUB_ACTIVITY_TYPE.eLotteryact13)
end
end









end
function UISubAct_XYZPWin:rec_newday()
if _this==nil then return end
_this:refreshCostBtn()
end

function UISubAct_XYZPWin:onAddClick(moneyType)
gainControl:showCommonGainWin_item(moneyType)
end

function UISubAct_XYZPWin:onClickItem2(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end

function UISubAct_XYZPWin:clickMoney(moneyType)
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end


function UISubAct_XYZPWin:onXiangxibtn()
local bxRewards=self.config.bxRewards
local rewardList=bxRewards[2]
local str=bxRewards[1]
if pfwindowslController:checkIsGameVersion_guofu()or pfwindowslController:checkIsGameVersion_HWFT()then
str=string.gsub(str," ","\194\160")
end

local showdata=
{
title='祈愿袋',
closetip=true,
repaneltxt=str,
rewardList=rewardList,
}
UIManager:showWindow('UISubAct_XYZPTipWin',showdata)
end

function UISubAct_XYZPWin:onTipsBtn()
AudioManager.playBtnClick()
if self.isAnim then
return
end
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
proTitle='祈愿袋',
normalTitle='流星许愿',
}
oneTabScreenController:openUI(SEC_FULL_TYPE.lotterySecondary,args)

end

function UISubAct_XYZPWin:onClickItem(index)
if self.isAnim then
return
end
local target=self.config.target_reward
local total=self.actData.total_luck_cnt
local stage_reward_idx=self.actData.stage_reward_idx
local d=target[index]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=index<=stage_reward_idx
local itemid=reward[1]
if fix and not rewardFlag then
call_activitiesHandle_func("activitiesHandle_xingyunzhuanpan","reqReceiveReward",self.activityId,self.subId)
else
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eCenter})
end
end

function UISubAct_XYZPWin:onOneBtn()
if self.isAnim then
return
end
local nowTime=Time.realtimeSinceStartup
if self.lotteryTime and(nowTime-self.lotteryTime)<0.5 then
return
end
self.lotteryTime=nowTime
self.activityData:reqChouJiang(1)

end

function UISubAct_XYZPWin:onTenBtn()
if self.isAnim then
return
end
local nowTime=Time.realtimeSinceStartup
if self.lotteryTime and(nowTime-self.lotteryTime)<0.5 then
return
end
self.lotteryTime=nowTime
self.activityData:reqChouJiang(2)

end

function UISubAct_XYZPWin:onXybtn()
if self.isAnim then
return
end
local nowTime=Time.realtimeSinceStartup
if self.lotteryTime and(nowTime-self.lotteryTime)<0.5 then
return
end
self.lotteryTime=nowTime

local moneyType=self.wish_consume[1]
local jindu=self.wish_consume[2]
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
if moneyVal>=jindu then
self.activityData:reqChouJiang(3)

else
gainControl:showGainWin(moneyType)
return
end
end





function UISubAct_XYZPWin:onShow(argtable,afterOnloaded)
self:initFMTweener()
if afterOnloaded then




self.bgImg:setChildUIModelShowTarget(6315,1,{},eAnimationID.stand)
self.winlua:SetChildSpineAnimation(self.bgImg2:getID(),1,1,nil)


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


self.wish_consume=self.config.wish_consume
self.isAnim=false


local _moneyType=self.wish_consume[1]
local _jindu=self.wish_consume[2]or 0
local _moneyVal=0
if moneyConfig.isMoney(_moneyType)then
_moneyVal=moneyModel.getMoney(_moneyType)
else
_moneyVal=bagControl.invokeFuncByItemId(_moneyType,'getItemCountByItemID',_moneyType)
end
if _moneyVal>=_jindu then
self.bgImg3:setChildUIModelShowTarget(6319,1,{},eAnimationID.stand2)
else
self.bgImg3:setChildUIModelShowTarget(6319,1,{},eAnimationID.stand)
end

self.costItemID=self.config.itemid
self:initMoneyData({{self.costItemID}})

if self.actTimer==nil then
local func=function()
self:refreshActTimer()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end


self:initRewardList2()

self:freahXuYuanReward()
self:refreshSkipBtn()
self:refreshCostBtn()
self:refreshTargetRewardPanel(false,true)


local speaks=self.config.speaks
self.speaksDaiJi={}
self.speaksAnima={}
if speaks[1]then
for k,v in ipairs(speaks[1])do
if next(v)then
table.insert(self.speaksDaiJi,k)
end
end
end
if speaks[2]then
for k,v in ipairs(speaks[2])do
if next(v)then
table.insert(self.speaksAnima,k)
end
end
end
self:refreshDaiJiBubble()
end

function UISubAct_XYZPWin:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(time))
self.timeTxt:setText(time_str)
end

function UISubAct_XYZPWin:refreshSkipBtn()
if self.skipFlag==nil then
self.skipFlag=self.activityData:getJumpAnimation()
end
self.skipSelectImg:setActive(self.skipFlag)
end

function UISubAct_XYZPWin:onSkipBtn()
if self.isAnim then
return
end
self.skipFlag=not self.skipFlag
self.activityData:setJumpAnimation(self.skipFlag)
self:refreshSkipBtn()
end

function UISubAct_XYZPWin:initMoneyData(datas)
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

function UISubAct_XYZPWin:initMoneyItem(money)
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

function UISubAct_XYZPWin:refreshMoneyItem(money,lastVal)
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
function UISubAct_XYZPWin:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end
function UISubAct_XYZPWin:initFMTweener()
if self.fmTweener then
for k,v in pairs(self.fmTweener)do
v:Kill()
end
end
end


function UISubAct_XYZPWin:severRefresh(act_id,sub_act_type,sub_act_id)
if act_id and sub_act_type and sub_act_id then
if act_id==_this.activityId and sub_act_type==_this.subType and sub_act_id==_this.subId then
_this:refreshCostBtn()
_this:refreshTargetRewardPanel(false,false)
end
end
end

function UISubAct_XYZPWin:initRewardList2()
local reward_list=self.config.reward_list
local cwidget=self.rewarditems:getWidgetBase()
for k=1,12 do
local widget=cwidget:GetChildWidgetBase(k-1)
local data=reward_list[k]
if data then
widget:SetChildActive(-1,true)
local itemid=data[1]
local itemCount=data[2]
local flag=data[3]
widget:SetChildActive(rwItemidx.flag,false)
widget:SetChildActive(rwItemidx.lightimg,false)
if itemCount>1 then
widget:SetChildActive(rwItemidx.numbg,true)
local Str=itemCount>1 and mathHelper.formatNumber(itemCount)or''
widget:SetChildText(rwItemidx.num,Str)
else
widget:SetChildActive(rwItemidx.numbg,false)
end
local graynum=0
local countStr=''
local showCountBG=false
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(rwItemidx.reward,prop)
widget:SetBaseItemClickEvent(rwItemidx.reward,function(...)
if _this==nil then return end
self:onClickItem2(...)
end)
else
widget:SetChildActive(-1,false)
end
end
end

function UISubAct_XYZPWin:freahXuYuanReward()
local moneyType=self.wish_consume[1]
local jindu=self.wish_consume[2]
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
if moneyVal>=jindu then


self.jdreddot:setActive(true)
else
self.jdreddot:setActive(false)
end
local str=FMT.fmt("{0}/{1}",moneyStr,jindu)
self.jdtxt:setText(str)
end

function UISubAct_XYZPWin:refreshCostBtn()
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

function UISubAct_XYZPWin:refreshTargetRewardPanel(anim,isInit)
local speed=400
local stepWidth=100
local contentOffset={10,0}
self.rewardProgressBar:setChildAnchoredPosition(Vector2(contentOffset[1],0))


local target=self.config.target_reward
local max=#target
local total=self.actData.total_luck_cnt
local stage_reward_idx=self.actData.stage_reward_idx
local curIndex=0
for i,d in ipairs(target)do
if total>=d[1]then
curIndex=i
end
end

self.rewardGrid:setChildLayoutGroupCreateItems(max)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for i=1,max do
local item=grids[i-1]
local d=target[i]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=i<=stage_reward_idx


local posX=(i-1)*stepWidth
item:SetChildAnchoredPosition(-1,Vector2(posX,0))

local itemid=reward[1]
local count=reward[2]
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
_this:onClickItem(i)
end)

item:SetChildText(1,num)

item:SetChildActive(2,fix and rewardFlag)

item:SetChildActive(6,fix and not rewardFlag)

item:SetChildActive(3,fix and rewardFlag)


end
local content_width=max*stepWidth+contentOffset[1]+contentOffset[2]
self.rewardContent:setChildSizeDelta(content_width,115)


local max_width=max*stepWidth-(contentOffset[1]*2)
self.rewardProgressBar:setChildSizeDelta(max_width,28)

local cur_width
if curIndex>=max then
cur_width=max_width
elseif curIndex<=0 then
cur_width=total/target[curIndex+1][1]*stepWidth
else
local rate=(total-target[curIndex][1])/(target[curIndex+1][1]-target[curIndex][1])
cur_width=(curIndex+rate)*stepWidth
end
if cur_width>(contentOffset[1]*2+10)then
cur_width=cur_width-(contentOffset[1]*2+10)
end

if anim then
local old_width=self.rewardProgressBar:getChildSizeDeltaY()
local lerp=math.abs(cur_width-old_width)
self.rewadProgress:setChildDOSizeDelta(Vector2(cur_width,16),lerp/speed,nil)
else
self.rewadProgress:setChildSizeDelta(cur_width,16)
end

self.rewardNumTxt:setText(tostring(total))

if isInit then
local showWidth=self.rewardScrollView:getChildRectWidth()
local moveX
local halfWidth=showWidth/2
local width=cur_width+contentOffset[1]+contentOffset[2]
if width>showWidth then
moveX=width-showWidth+halfWidth
local max_width_=content_width-halfWidth
if moveX>max_width_ then
moveX=max_width_
end
else
if width>halfWidth then
moveX=width-halfWidth
else
moveX=0
end
end
self.rewardContent:setLocalPosX(-moveX)
end
end

function UISubAct_XYZPWin:rec_DoAnim(prizelist,effectData)
if not prizelist or not effectData or not effectData.lotterytype then
logErr(FMT.fmt('幸运抽奖活动返回奖励报错,特效类型为100,effectData=nil,prizelist=nil'))
return
end
if#prizelist==0 then
logErr(FMT.fmt('幸运抽奖活动返回奖励报错,特效类型为100,prizelist奖励列表长度为0'))
return
end
local flag=effectData.lotterytype

local colorlist={}

local rewardList={}
for i,v in ipairs(prizelist)do
local itemid=v.itemid
local num=v.num
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
if color==2 or color==3 or color==4 or color==5 then
if not colorlist[color]then
colorlist[color]=1
else
colorlist[color]=colorlist[color]+1
end
end
table.insert(rewardList,{itemid=itemid,num=num})
end
local effectlist={}
if next(colorlist)then
for k,v in pairs(colorlist)do
local index=k-1
table.insert(effectlist,index)
end
end
if#rewardList>1 then
if#effectlist<3 then
local idx=effectlist[1]
local idx2=effectlist[2]or idx
if idx then
table.insert(effectlist,idx)
end
if#effectlist<3 and idx2 then
table.insert(effectlist,idx2)
end
end
end

if self.skipFlag then

self:freahXuYuanReward()
showPrizeControl.showWindow(rewardList)
self.isAnim=false
else
self.isAnim=true
self:playShowAnim(effectlist,rewardList)
end






























































end

function UISubAct_XYZPWin:RewardsDisapper()
local cwidget=_this.rewarditems:getWidgetBase()
local delaytime=0.2
_this:delayDo(delaytime,function()
if _this==nil then return end
for k,index in ipairs(list1)do
local widget=cwidget:GetChildWidgetBase(index-1)
widget:SetChildCanvasGroupDOFade(-1,0,0.4)
widget:SetChildShowEffect(4,22666,true)
end
end)

delaytime=delaytime+0.2
_this:delayDo(delaytime,function()
if _this==nil then return end
for k,index in ipairs(list2)do
local widget=cwidget:GetChildWidgetBase(index-1)
widget:SetChildCanvasGroupDOFade(-1,0,0.4)
widget:SetChildShowEffect(4,22666,true)
end
end)

delaytime=delaytime+0.1
_this:delayDo(delaytime,function()
if _this==nil then return end
for k,index in ipairs(list3)do
local widget=cwidget:GetChildWidgetBase(index-1)
widget:SetChildCanvasGroupDOFade(-1,0,0.4)
widget:SetChildShowEffect(4,22666,true)
end
end)

delaytime=delaytime+0.2
_this:delayDo(delaytime,function()
if _this==nil then return end
for k,index in ipairs(list4)do
local widget=cwidget:GetChildWidgetBase(index-1)
widget:SetChildCanvasGroupDOFade(-1,0,0.2)
widget:SetChildShowEffect(4,22666,true)
end
end)

delaytime=delaytime+0.1
_this:delayDo(delaytime,function()
if _this==nil then return end
for k,index in ipairs(list5)do
local widget=cwidget:GetChildWidgetBase(index-1)
widget:SetChildCanvasGroupDOFade(-1,0,0.2)
widget:SetChildShowEffect(4,22666,true)
end
end)
end

function UISubAct_XYZPWin:RewardsShow()
local list={1,2,3,4,5,6,7,8,9,10,11,12}
local cwidget=_this.rewarditems:getWidgetBase()
for k,index in ipairs(list)do
local widget=cwidget:GetChildWidgetBase(index-1)
widget:SetChildCanvasGroupDOFade(-1,1,0.2)
end
end

function UISubAct_XYZPWin:playShowAnim(effectlist,prizelist)
if#effectlist==1 then
local indxlist=effectlist
self:playRewardsAnim1(prizelist,indxlist)
elseif#effectlist==2 then
local indxlist=effectlist
self:playRewardsAnim2(prizelist,indxlist)
elseif#effectlist==3 then
local indxlist=effectlist
self:playRewardsAnim3(prizelist,indxlist)
elseif#effectlist==4 then
local indxlist=effectlist
self:playRewardsAnim4(prizelist,indxlist)
elseif#effectlist==0 then
local indxlist={2}
self:playRewardsAnim1(prizelist,indxlist)
end
end

function UISubAct_XYZPWin:playRewardsAnim4(rewardList,indxlist)
self:RewardsDisapper()
self.winlua:SetChildSpineAnimation(self.bgImg2:getID(),3426,1,nil)


self:stopExpireTimer2()
local times=1.4
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(1,2)
end)
times=times+0.2
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(4,2)
end)
times=times+0.1
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(6,2)
end)


local idx1=indxlist[1]
local idx2=indxlist[2]
local idx3=indxlist[3]
local idx4=indxlist[4]
local effect_widget=self.effectpanel:getWidgetBase()
times=times+0.1
self:delayDo(times,function()
if _this==nil then return end
effect_widget:SetChildLocalPosition(0,starone4[0])
effect_widget:SetChildShowEffect(0,starEffectOne[idx1],true)
end)
times=times+0.1
self:delayDo(times,function()
if _this==nil then return end
effect_widget:SetChildLocalPosition(1,starone4[1])
effect_widget:SetChildShowEffect(1,starEffectOne[idx2],true)
end)
times=times+0.2
self:delayDo(times,function()
if _this==nil then return end
effect_widget:SetChildLocalPosition(2,starone4[2])
effect_widget:SetChildShowEffect(2,starEffectOne[idx3],true)
end)
times=times+0.2
self:delayDo(times,function()
if _this==nil then return end
effect_widget:SetChildLocalPosition(3,starone4[3])
effect_widget:SetChildShowEffect(3,starEffectOne[idx4],true)
end)

local fun=function()
if _this==nil then return end
local moneyType=self.wish_consume[1]
local jindu=self.wish_consume[2]or 0
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end


local effect_widget2=self.effectpanel2:getWidgetBase()
local times2=0.4
self:delayDo(times2,function()
if _this==nil then return end
effect_widget2:SetChildLocalPosition(0,startwo4[0])
effect_widget2:SetChildLocalPosition(1,startwo4[1])
effect_widget2:SetChildLocalPosition(2,startwo4[2])
effect_widget2:SetChildLocalPosition(3,startwo4[3])
effect_widget2:SetChildShowEffect(0,starEffectTwo1[idx1],true)
effect_widget2:SetChildShowEffect(1,starEffectTwo1[idx2],true)
effect_widget2:SetChildShowEffect(2,starEffectTwo1[idx3],true)
effect_widget2:SetChildShowEffect(3,starEffectTwo1[idx4],true)
end)

local effect_widget3=self.effectpanel3:getWidgetBase()
times2=times2+1
self:delayDo(times2,function()
if _this==nil then return end
effect_widget3:SetChildLocalPosition(0,startwo4[0])
effect_widget3:SetChildLocalPosition(1,startwo4[1])
effect_widget3:SetChildLocalPosition(2,startwo4[2])
effect_widget3:SetChildLocalPosition(3,startwo4[3])
effect_widget3:SetChildShowEffect(0,starEffectTwo2[idx1],true)
effect_widget3:SetChildShowEffect(1,starEffectTwo2[idx2],true)
effect_widget3:SetChildShowEffect(2,starEffectTwo2[idx3],true)
effect_widget3:SetChildShowEffect(3,starEffectTwo2[idx4],true)
end)


times2=times2+0.4
local centerPostion=self.bageffect:getChildPosition()
self:delayDo(times2,function()
if _this==nil then return end
local tweener=effect_widget3:SetChildDOMove(0,centerPostion,1,function()
if _this==nil then return end
effect_widget3:SetChildShowEffect(0,0,false)
end)
tweener:SetEase(_Ease.Linear)
local tweener2=effect_widget3:SetChildDOMove(1,centerPostion,1,function()
if _this==nil then return end
effect_widget3:SetChildShowEffect(1,0,false)
end)
tweener2:SetEase(_Ease.Linear)
local tweener3=effect_widget3:SetChildDOMove(2,centerPostion,1,function()
if _this==nil then return end
effect_widget3:SetChildShowEffect(2,0,false)
end)
tweener3:SetEase(_Ease.Linear)
local tweener4=effect_widget3:SetChildDOMove(3,centerPostion,1,function()
if _this==nil then return end
effect_widget3:SetChildShowEffect(3,0,false)
end)
tweener4:SetEase(_Ease.Linear)
end)


times2=times2+0.5
self:delayDo(times2,function()
if _this==nil then return end
self.bageffect:setChildShowEffect(22679,true)
if moneyVal>=jindu then
self.bgImg3:setChildModelAnimationState(3481,1,nil)
self.jdreddot:setActive(true)
else
self.bgImg3:setChildModelAnimationState(3482,1,nil)
self.jdreddot:setActive(false)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
local str=FMT.fmt("{0}/{1}",moneyStr,jindu)
self.jdtxt:setText(str)
end)

times2=times2+1
self:delayDo(times2,function()
if _this==nil then return end
self:RewardsShow()
self.winlua:SetChildSpineAnimation(self.bgImg2:getID(),5,1,nil)
self.isAnim=false
end)
end

times=times+2.7
self:delayDo(times,function()
if _this==nil then return end
showPrizeControl.showWindow(rewardList,fun)
end)
end

function UISubAct_XYZPWin:playRewardsAnim3(rewardList,indxlist)
self:RewardsDisapper()
self.winlua:SetChildSpineAnimation(self.bgImg2:getID(),3426,1,nil)

self:stopExpireTimer2()
local times=1.4
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(1,2)
end)
times=times+0.2
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(4,2)
end)
times=times+0.1
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(6,2)
end)


local idx1=indxlist[1]
local idx2=indxlist[2]
local idx3=indxlist[3]
local effect_widget=self.effectpanel:getWidgetBase()
times=times+0.1
self:delayDo(times,function()
if _this==nil then return end
effect_widget:SetChildLocalPosition(0,starone3[0])
effect_widget:SetChildShowEffect(0,starEffectOne[idx1],true)
end)

times=times+0.1
self:delayDo(times,function()
if _this==nil then return end
effect_widget:SetChildLocalPosition(1,starone3[1])
effect_widget:SetChildShowEffect(1,starEffectOne[idx2],true)
end)

times=times+0.2
self:delayDo(times,function()
if _this==nil then return end
effect_widget:SetChildLocalPosition(2,starone3[2])
effect_widget:SetChildShowEffect(2,starEffectOne[idx3],true)
end)

local fun=function()
if _this==nil then return end
local moneyType=self.wish_consume[1]
local jindu=self.wish_consume[2]or 0
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end

local effect_widget2=self.effectpanel2:getWidgetBase()
local times2=0.4
self:delayDo(times2,function()
if _this==nil then return end
effect_widget2:SetChildLocalPosition(0,startwo3[0])
effect_widget2:SetChildLocalPosition(1,startwo3[1])
effect_widget2:SetChildLocalPosition(2,startwo3[2])
effect_widget2:SetChildShowEffect(0,starEffectTwo1[idx1],true)
effect_widget2:SetChildShowEffect(1,starEffectTwo1[idx2],true)
effect_widget2:SetChildShowEffect(2,starEffectTwo1[idx3],true)
end)

local effect_widget3=self.effectpanel3:getWidgetBase()
times2=times2+1
self:delayDo(times2,function()
if _this==nil then return end
effect_widget3:SetChildLocalPosition(0,startwo3[0])
effect_widget3:SetChildLocalPosition(1,startwo3[1])
effect_widget3:SetChildLocalPosition(2,startwo3[2])
effect_widget3:SetChildShowEffect(0,starEffectTwo2[idx1],true)
effect_widget3:SetChildShowEffect(1,starEffectTwo2[idx2],true)
effect_widget3:SetChildShowEffect(2,starEffectTwo2[idx3],true)
end)


times2=times2+0.4
local centerPostion=self.bageffect:getChildPosition()
self:delayDo(times2,function()
if _this==nil then return end
local tweener=effect_widget3:SetChildDOMove(0,centerPostion,1,function()
if _this==nil then return end
effect_widget3:SetChildShowEffect(0,0,false)
end)
tweener:SetEase(_Ease.Linear)
local tweener2=effect_widget3:SetChildDOMove(1,centerPostion,1,function()
if _this==nil then return end
effect_widget3:SetChildShowEffect(1,0,false)
end)
tweener2:SetEase(_Ease.Linear)
local tweener3=effect_widget3:SetChildDOMove(2,centerPostion,1,function()
if _this==nil then return end
effect_widget3:SetChildShowEffect(2,0,false)
end)
tweener3:SetEase(_Ease.Linear)
end)


times2=times2+0.5
self:delayDo(times2,function()
if _this==nil then return end
self.bageffect:setChildShowEffect(22679,true)
if moneyVal>=jindu then
self.bgImg3:setChildModelAnimationState(3481,1,nil)
self.jdreddot:setActive(true)
else
self.bgImg3:setChildModelAnimationState(3482,1,nil)
self.jdreddot:setActive(false)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
local str=FMT.fmt("{0}/{1}",moneyStr,jindu)
self.jdtxt:setText(str)
end)

times2=times2+1
self:delayDo(times2,function()
if _this==nil then return end
self:RewardsShow()
self.winlua:SetChildSpineAnimation(self.bgImg2:getID(),5,1,nil)
self.isAnim=false
end)
end
times=times+2.7
self:delayDo(times,function()
if _this==nil then return end
showPrizeControl.showWindow(rewardList,fun)
end)
end

function UISubAct_XYZPWin:playRewardsAnim2(rewardList,indxlist)
self:RewardsDisapper()
self.winlua:SetChildSpineAnimation(self.bgImg2:getID(),3426,1,nil)

self:stopExpireTimer2()
local times=1.4
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(1,2)
end)
times=times+0.2
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(4,2)
end)
times=times+0.1
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(6,2)
end)


local idx1=indxlist[1]
local idx2=indxlist[2]
local effect_widget=self.effectpanel:getWidgetBase()
times=times+0.1
self:delayDo(times,function()
if _this==nil then return end
effect_widget:SetChildLocalPosition(0,starone2[0])
effect_widget:SetChildShowEffect(0,starEffectOne[idx1],true)
end)
times=times+0.2
self:delayDo(times,function()
if _this==nil then return end
effect_widget:SetChildLocalPosition(1,starone2[1])
effect_widget:SetChildShowEffect(1,starEffectOne[idx2],true)
end)

local fun=function()
if _this==nil then return end
local moneyType=self.wish_consume[1]
local jindu=self.wish_consume[2]or 0
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end

local effect_widget2=self.effectpanel2:getWidgetBase()
local times2=0.4
self:delayDo(times2,function()
if _this==nil then return end
effect_widget2:SetChildLocalPosition(0,startwo2[0])
effect_widget2:SetChildLocalPosition(1,startwo2[1])
effect_widget2:SetChildShowEffect(0,starEffectTwo1[idx1],true)
effect_widget2:SetChildShowEffect(1,starEffectTwo1[idx2],true)
end)

local effect_widget3=self.effectpanel3:getWidgetBase()
times2=times2+1
self:delayDo(times2,function()
if _this==nil then return end
effect_widget3:SetChildLocalPosition(0,startwo2[0])
effect_widget3:SetChildLocalPosition(1,startwo2[1])
effect_widget3:SetChildShowEffect(0,starEffectTwo2[idx1],true)
effect_widget3:SetChildShowEffect(1,starEffectTwo2[idx2],true)
end)


times2=times2+0.4
local centerPostion=self.bageffect:getChildPosition()
self:delayDo(times2,function()
if _this==nil then return end
local tweener=effect_widget3:SetChildDOMove(0,centerPostion,1,function()
if _this==nil then return end
effect_widget3:SetChildShowEffect(0,0,false)
end)
tweener:SetEase(_Ease.Linear)
local tweener2=effect_widget3:SetChildDOMove(1,centerPostion,1,function()
if _this==nil then return end
effect_widget3:SetChildShowEffect(1,0,false)
end)
tweener2:SetEase(_Ease.Linear)
end)


times2=times2+0.5
self:delayDo(times2,function()
if _this==nil then return end
self.bageffect:setChildShowEffect(22679,true)
if moneyVal>=jindu then
self.bgImg3:setChildModelAnimationState(3481,1,nil)
self.jdreddot:setActive(true)
else
self.bgImg3:setChildModelAnimationState(3482,1,nil)
self.jdreddot:setActive(false)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
local str=FMT.fmt("{0}/{1}",moneyStr,jindu)
self.jdtxt:setText(str)
end)

times2=times2+1
self:delayDo(times2,function()
if _this==nil then return end
self:RewardsShow()
self.winlua:SetChildSpineAnimation(self.bgImg2:getID(),5,1,nil)
self.isAnim=false
end)
end
times=times+2.7
self:delayDo(times,function()
if _this==nil then return end
showPrizeControl.showWindow(rewardList,fun)
end)
end

function UISubAct_XYZPWin:playRewardsAnim1(rewardList,indxlist)
self:RewardsDisapper()
self.winlua:SetChildSpineAnimation(self.bgImg2:getID(),3426,1,nil)

self:stopExpireTimer2()
local times=1.4
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(1,2)
end)
times=times+0.2
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(4,2)
end)
times=times+0.1
self:delayDo(times,function()
if _this==nil then return end
self:handleSpeaking_player(6,2)
end)


local idx1=indxlist[1]
local effect_widget=self.effectpanel:getWidgetBase()
times=times+0.1
self:delayDo(times,function()
if _this==nil then return end
effect_widget:SetChildLocalPosition(0,starone1[0])
effect_widget:SetChildShowEffect(0,starEffectOne[idx1],true)
end)

local fun=function()
if _this==nil then return end
local moneyType=self.wish_consume[1]
local jindu=self.wish_consume[2]or 0
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end

local effect_widget2=self.effectpanel2:getWidgetBase()
local times2=0.4
self:delayDo(times2,function()
if _this==nil then return end
effect_widget2:SetChildLocalPosition(0,startwo1[0])
effect_widget2:SetChildShowEffect(0,starEffectTwo1[idx1],true)
end)

local effect_widget3=self.effectpanel3:getWidgetBase()
times2=times2+1
self:delayDo(times2,function()
if _this==nil then return end
effect_widget3:SetChildLocalPosition(0,startwo1[0])
effect_widget3:SetChildShowEffect(0,starEffectTwo2[idx1],true)
end)


times2=times2+0.4
local centerPostion=self.bageffect:getChildPosition()
self:delayDo(times2,function()
if _this==nil then return end
local tweener=effect_widget3:SetChildDOMove(0,centerPostion,1,function()
if _this==nil then return end
effect_widget3:SetChildShowEffect(0,0,false)
end)
tweener:SetEase(_Ease.Linear)
end)


times2=times2+0.5
self:delayDo(times2,function()
if _this==nil then return end
self.bageffect:setChildShowEffect(22679,true)
if moneyVal>=jindu then
self.bgImg3:setChildModelAnimationState(3481,1,nil)
self.jdreddot:setActive(true)
else
self.bgImg3:setChildModelAnimationState(3482,1,nil)
self.jdreddot:setActive(false)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
local str=FMT.fmt("{0}/{1}",moneyStr,jindu)
self.jdtxt:setText(str)
end)

times2=times2+1
self:delayDo(times2,function()
if _this==nil then return end
self:RewardsShow()
self.winlua:SetChildSpineAnimation(self.bgImg2:getID(),5,1,nil)
self.isAnim=false
end)
end
times=times+2.7
self:delayDo(times,function()
if _this==nil then return end
showPrizeControl.showWindow(rewardList,fun)
end)
end


function UISubAct_XYZPWin:testttttspine(id)
if id==1 then
_this:RewardsDisapper()
_this.winlua:SetChildSpineAnimation(_this.bgImg2:getID(),3426,1,nil)
else
_this:RewardsShow()
_this.winlua:SetChildSpineAnimation(_this.bgImg2:getID(),5,1,nil)
end
end
function UISubAct_XYZPWin:testttttspine2(id)
if id==1 then
_this.bgImg3:setChildModelAnimationState(3481,1,nil)
else
_this.bgImg3:setChildModelAnimationState(3482,1,nil)
end
end
function UISubAct_XYZPWin:testttttspine3(id)
local rewardList2={
[1]={
['sortWeight']=3000,
['itemid']=12122,
['num']=2,
['itemguid']=3188882787792847522,
},}
if id==1 then
local indxlist={4}
_this:playShowAnim(indxlist,rewardList2)
elseif id==2 then
local indxlist={1,3}
_this:playShowAnim(indxlist,rewardList2)
elseif id==3 then
local indxlist={2,4,3}
_this:playShowAnim(indxlist,rewardList2)
elseif id==4 then
local indxlist={1,4,2,3}
_this:playShowAnim(indxlist,rewardList2)
end
end



function UISubAct_XYZPWin:stopExpireTimer()
if self.refreshTimeIdshop then
self:stopTimerByID(self.refreshTimeIdshop)
self.refreshTimeIdshop=nil
end
for index=1,6 do
if self.talkTween[index]~=nil then
self.talkTween[index]:Kill()
self.talkTween[index]=nil
end
if self.speakShowTimer[index]then
self:stopTimerByID(self.speakShowTimer[index])
self.speakShowTimer[index]=nil
end
end
end
function UISubAct_XYZPWin:stopExpireTimer2()
for index=1,6 do
if self.talkTween[index]~=nil then
if _this==nil then return end
self.talkTween[index]=nil
if self.speakShowTimer[index]then

self.speakitems[index]:SetChildScale(1,Vector3.zero)
self.speakitems[index]:SetChildCanvasGroupAlpha(1,0)
if self.speakShowTimer[index]then
self:stopTimerByID(self.speakShowTimer[index])
self.speakShowTimer[index]=nil
end
end
end
end
end

function UISubAct_XYZPWin:refreshDaiJiBubble()
if self.refreshTimeIdshop then
self:stopTimerByID(self.refreshTimeIdshop)
self.refreshTimeIdshop=nil
end
self.refreshTimeFunshop=function()
if not _this.isAnim then
local idx=math.random(1,#self.speaksDaiJi)
local index=self.speaksDaiJi[idx]
if not _this.talkTween[index]and not _this.speakShowTimer[index]then
_this:handleSpeaking_player(index,1)
end
end
end
self.refreshTimeFunshop()
local shoptime=2
self.refreshTimeIdshop=self:setTimer(shoptime,0,self.refreshTimeFunshop)
end

function UISubAct_XYZPWin:handleSpeaking_player(index,flag)
_this:doSpeaking_player(index,flag)
end
function UISubAct_XYZPWin:doSpeaking_player(index,flag)






local cfg_speaks=self.config.speaks or{}
local speakList
if flag==1 then
speakList=cfg_speaks[1][index]
else
speakList=cfg_speaks[2][index]
end
if speakList then
local rand=math.random(1,#speakList)
local speakStr=speakList[rand]
local speed=30
self.speakitems[index]:SetChildCanvasGroupAlpha(1,1)
self.speakitems[index]:SetChildTrendsTextPlay(2,speakStr,speed,nil)
self:doTalkAnim_player(index)
end
end
function UISubAct_XYZPWin:doTalkAnim_player(index)
if self.talkTween[index]~=nil then
self.talkTween[index]:Kill()
self.talkTween[index]=nil
end
self.speakitems[index]:SetChildScale(1,Vector3.zero)
self:delayDo(0.2,function()
self.speakitems[index]:SetChildCanvasGroupAlpha(1,1)
self.talkTween[index]=self.speakitems[index]:SetChildDOScaleY(1,1.2,0.2,function()
if _this==nil then return end
self.talkTween[index]=nil
self.talkTween[index]=self.speakitems[index]:SetChildDOScale(1,0.8,0.1,function()
if _this==nil then return end
self.talkTween[index]=nil
return self:talkEnd(index)
end)
end)
end)
end
function UISubAct_XYZPWin:talkEnd(index)
if self.speakShowTimer[index]then
self:stopTimerByID(self.speakShowTimer[index])
self.speakShowTimer[index]=nil
end
self.speakShowTimer[index]=_this:delayDo(3,function()

if _this==nil then return end
self.speakitems[index]:SetChildScale(1,Vector3.zero)
self.speakitems[index]:SetChildCanvasGroupAlpha(1,0)
if self.speakShowTimer[index]then
self:stopTimerByID(self.speakShowTimer[index])
self.speakShowTimer[index]=nil
end
end)
end



function UISubAct_XYZPWin:lotteryRefresh()
self:refreshCostBtn()
self:refreshTargetRewardPanel(true,false)
self:clearRewards()


end

function UISubAct_XYZPWin:setUIAlpha(alpha,duration)
self.leftRoot:setChildCanvasGroupDOFade(alpha,duration)
self.rewardScrollView:setChildCanvasGroupDOFade(alpha,duration)
self.tips:setChildCanvasGroupDOFade(alpha,duration)
self.leftCountBg:setChildCanvasGroupDOFade(alpha,duration)
self.timeBg:setChildCanvasGroupDOFade(alpha,duration)
self.oneCostObj:setChildCanvasGroupDOFade(alpha,duration)
self.tenCostObj:setChildCanvasGroupDOFade(alpha,duration)
UIManager:invokeUIMethod(self.parentWin,'fadeRoot',alpha,duration)
end

function UISubAct_XYZPWin:initRewardList()
self.AllwidgetList={}
self.BigwidgetList={}
self.AllRewardLookup={}
self.BigRewardLookup={}
local bigRewardLookup={}























end

function UISubAct_XYZPWin:initCenterReward()

local reward_list=self.config.reward_list
for k,widget in ipairs(self.AllwidgetList)do
local data=reward_list[k]
local itemid=data[1]
local itemCount=data[2]
local flag=data[3]
if flag and flag==1 then
widget:SetChildActive(rwItemidx.flag,true)
else
widget:SetChildActive(rwItemidx.flag,false)
end
widget:SetChildActive(rwItemidx.lightimg,false)

local graynum=0
local countStr=itemCount>1 and mathHelper.formatNumber(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(rwItemidx.reward,prop)
widget:SetBaseItemClickEvent(rwItemidx.reward,function(...)
if _this==nil then return end
self:onClickItem2(...)
end)
end
end
function UISubAct_XYZPWin:clearRewards()
for k,widget in ipairs(self.AllwidgetList)do
widget:SetChildActive(rwItemidx.lightimg,false)
end
end

function UISubAct_XYZPWin:HandleAnimRound(prizelist,flag)
local reward_list=self.config.reward_list
local curindex={reward_list[2],2}
local len=#prizelist
if len>1 then
for i,v in ipairs(prizelist)do
local itemid=v.itemid
local num=v.num
local data=self.AllRewardLookup[itemid]
if data then
if data[1]==1 then
curindex={{itemid,num,data[1]},data[2]}
break
else
curindex={{itemid,num,data[1]},data[2]}
end
end
end
else
for i,v in ipairs(prizelist)do
local itemid=v.itemid
local num=v.num
local data=self.AllRewardLookup[itemid]
if data then
curindex={{itemid,num,data[1]},data[2]}
break
end
end
end


if flag==3 then

local len2=#self.BigwidgetList
local itemid2=curindex[1][1]
local bigdata=self.BigRewardLookup[itemid2]
if bigdata then
local idx2=bigdata[2]
local lastRoundidx=len2*round2+idx2
if len2==1 then
lastRoundidx=1
end
return lastRoundidx,idx2
else
return len2*round2,1
end
else

local len2=#self.AllwidgetList
local idx=curindex[2]
local lastRoundidx=len2*round1+idx
return lastRoundidx,idx
end
end

function UISubAct_XYZPWin:playRewardsAnim(lastRoundidx,flag,func)


local len_all=#self.AllwidgetList
local len_big=#self.BigwidgetList
self:clearTimer()
if flag==3 then
local outidx=1
local inidx=1
local func2=function()
if _this==nil then return end
if outidx<lastRoundidx then
outidx=outidx+1
if outidx>len_big then
inidx=outidx%len_big
if inidx==0 then
inidx=len_big
end
else
inidx=outidx
end
local thisidx=inidx
local widget=self.BigwidgetList[thisidx]
widget:SetChildActive(rwItemidx.lightimg,true)

local lastidx=inidx-1
if lastidx>0 then
local lastwidget=self.BigwidgetList[lastidx]
lastwidget:SetChildActive(rwItemidx.lightimg,false)
else
local lastwidget=self.BigwidgetList[len_big]
lastwidget:SetChildActive(rwItemidx.lightimg,false)
end
else
self:clearTimer()
func()
end
end
self.cjTimer=self:setTimer(0.25,0,func2)
else
local outidx=1
local inidx=1
local func2=function()
if _this==nil then return end
if outidx<lastRoundidx then
outidx=outidx+1
if outidx>len_all then
inidx=outidx%len_all
if inidx==0 then
inidx=len_all
end
else
inidx=outidx
end
local thisidx=inidx
local widget=self.AllwidgetList[thisidx]
widget:SetChildActive(rwItemidx.lightimg,true)

local lastidx=inidx-1
if lastidx>0 then
local lastwidget=self.AllwidgetList[lastidx]
lastwidget:SetChildActive(rwItemidx.lightimg,false)
else
local lastwidget=self.AllwidgetList[len_all]
lastwidget:SetChildActive(rwItemidx.lightimg,false)
end
else
self:clearTimer()
func()
end
end
self.cjTimer=self:setTimer(0.18,0,func2)
end
end
function UISubAct_XYZPWin:clearTimer()
if self.cjTimer then
self:stopTimerByID(self.cjTimer)
self.cjTimer=nil
end
end

function UISubAct_XYZPWin:sstestttt()
local fun=function()
UIManager.info('获得奖励了1 2')
end
_this:playRewardsAnim(34,1,fun)
end

function UISubAct_XYZPWin:jlhdtestttt()
local effectData={}
effectData.lotterytype=1
local prizelist={}
prizelist={{itemid=36289,num=1},{itemid=36289,num=11},{itemid=36289,num=12},{itemid=36289,num=13},{itemid=36289,num=14},{itemid=36289,num=15}}
_this:rec_DoAnim(prizelist,effectData)
end
