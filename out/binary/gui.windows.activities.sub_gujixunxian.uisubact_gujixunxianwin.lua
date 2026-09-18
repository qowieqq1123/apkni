







def_class("UISubAct_gujixunxianWin",UIWindowBase)









function UISubAct_gujixunxianWin:bindComponents()

self.bgImg=UIObject.get(self,0)
self.bottomRoot=UIObject.get(self,1)
self.bottomRoot2=UIObject.get(self,2)
self.descIcon=UIImage.get(self,3)
self.descTxt=UIText.get(self,4)
self.effectBottom_1=UIObject.get(self,5)
self.effectBottom_10=UIObject.get(self,6)
self.effectBottom_2=UIObject.get(self,7)
self.effectBottom_3=UIObject.get(self,8)
self.effectBottom_4=UIObject.get(self,9)
self.effectBottom_5=UIObject.get(self,10)
self.effectBottom_6=UIObject.get(self,11)
self.effectBottom_7=UIObject.get(self,12)
self.effectBottom_8=UIObject.get(self,13)
self.effectBottom_9=UIObject.get(self,14)
self.effectBottomRoot=UIObject.get(self,15)
self.effectCenter=UIObject.get(self,16)
self.effectMid=UIObject.get(self,17)
self.message2Txt=UIText.get(self,18)
self.messageFrame=UIObject.get(self,19)
self.messageMask=UIObject.get(self,20)
self.messageTxt=UIText.get(self,21)
self.money1Root=UIObject.get(self,22)
self.money2Root=UIObject.get(self,23)
self.oneCostDesc=UIText.get(self,24)
self.oneCostIcon=UIImage.get(self,25)
self.oneCostReddot=UIObject.get(self,26)
self.oneFreeDesc=UIText.get(self,27)
self.rewadProgress=UIObject.get(self,28)
self.rewardContent=UIObject.get(self,29)
self.rewardNumTxt=UIText.get(self,30)
self.rewardScrollView=UIObject.get(self,31)
self.rightRoot=UIObject.get(self,32)
self.roleList=UIEnhancedScrollerLua.get(self,33)
self.root=UIObject.get(self,34)
self.singleRoleItem=UIObject.get(self,35)
self.skipBtn=UIButton.get(self,36)
self.skipSelectImg=UIObject.get(self,37)
self.Stage772050=UIObject.get(self,38)
self.tenCostDesc=UIText.get(self,39)
self.tenCostIcon=UIImage.get(self,40)
self.tenCostReddot=UIObject.get(self,41)
self.texiao_guaidan0=UIObject.get(self,42)
self.texiao_guaidan1=UIObject.get(self,43)
self.texiao_guaidan2=UIObject.get(self,44)
self.texiao_guaidan3=UIObject.get(self,45)
self.texiao_guaidan4=UIObject.get(self,46)
self.texiao_guaidan5=UIObject.get(self,47)
self.timeTxt=UIText.get(self,48)
self.topRoot=UIObject.get(self,49)
self.UICamera=UIObject.get(self,50)
self.upBtn=UIButton.get(self,51)
self.upBtnEx=UIButton.get(self,52)
self.upIconImage=UIImage.get(self,53)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.upBtn:setButtonClick(function()self:onUpBtn()end)

self.upBtnEx:setButtonClick(function()self:onUpBtnEx()end)
self.effectBottom={
self.effectBottom_1,
self.effectBottom_2,
self.effectBottom_3,
self.effectBottom_4,
self.effectBottom_5,
self.effectBottom_6,
self.effectBottom_7,
self.effectBottom_8,
self.effectBottom_9,
self.effectBottom_10,
}
self.texiao={
["guaidan0"]=self.texiao_guaidan0,
["guaidan1"]=self.texiao_guaidan1,
["guaidan2"]=self.texiao_guaidan2,
["guaidan3"]=self.texiao_guaidan3,
["guaidan4"]=self.texiao_guaidan4,
["guaidan5"]=self.texiao_guaidan5,
}



end


function UISubAct_gujixunxianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.bottomRoot);self.bottomRoot=nil;
_UIObject_release(self.bottomRoot2);self.bottomRoot2=nil;
_UIObject_release(self.descIcon);self.descIcon=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.effectBottom_1);self.effectBottom_1=nil;
_UIObject_release(self.effectBottom_10);self.effectBottom_10=nil;
_UIObject_release(self.effectBottom_2);self.effectBottom_2=nil;
_UIObject_release(self.effectBottom_3);self.effectBottom_3=nil;
_UIObject_release(self.effectBottom_4);self.effectBottom_4=nil;
_UIObject_release(self.effectBottom_5);self.effectBottom_5=nil;
_UIObject_release(self.effectBottom_6);self.effectBottom_6=nil;
_UIObject_release(self.effectBottom_7);self.effectBottom_7=nil;
_UIObject_release(self.effectBottom_8);self.effectBottom_8=nil;
_UIObject_release(self.effectBottom_9);self.effectBottom_9=nil;
_UIObject_release(self.effectBottomRoot);self.effectBottomRoot=nil;
_UIObject_release(self.effectCenter);self.effectCenter=nil;
_UIObject_release(self.effectMid);self.effectMid=nil;
_UIObject_release(self.message2Txt);self.message2Txt=nil;
_UIObject_release(self.messageFrame);self.messageFrame=nil;
_UIObject_release(self.messageMask);self.messageMask=nil;
_UIObject_release(self.messageTxt);self.messageTxt=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.money2Root);self.money2Root=nil;
_UIObject_release(self.oneCostDesc);self.oneCostDesc=nil;
_UIObject_release(self.oneCostIcon);self.oneCostIcon=nil;
_UIObject_release(self.oneCostReddot);self.oneCostReddot=nil;
_UIObject_release(self.oneFreeDesc);self.oneFreeDesc=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardNumTxt);self.rewardNumTxt=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.roleList);self.roleList=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.singleRoleItem);self.singleRoleItem=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.Stage772050);self.Stage772050=nil;
_UIObject_release(self.tenCostDesc);self.tenCostDesc=nil;
_UIObject_release(self.tenCostIcon);self.tenCostIcon=nil;
_UIObject_release(self.tenCostReddot);self.tenCostReddot=nil;
_UIObject_release(self.texiao_guaidan0);self.texiao_guaidan0=nil;
_UIObject_release(self.texiao_guaidan1);self.texiao_guaidan1=nil;
_UIObject_release(self.texiao_guaidan2);self.texiao_guaidan2=nil;
_UIObject_release(self.texiao_guaidan3);self.texiao_guaidan3=nil;
_UIObject_release(self.texiao_guaidan4);self.texiao_guaidan4=nil;
_UIObject_release(self.texiao_guaidan5);self.texiao_guaidan5=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.topRoot);self.topRoot=nil;
_UIObject_release(self.UICamera);self.UICamera=nil;
_UIObject_release(self.upBtn);self.upBtn=nil;
_UIObject_release(self.upBtnEx);self.upBtnEx=nil;
_UIObject_release(self.upIconImage);self.upIconImage=nil;
self.effectBottom=nil;
self.texiao=nil;
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
local _effectSize={
point=0,
small=1,
middle=2,
big=3,
}


local _effectGridSpacing=20

local _effectRange={
[_effectSize.point]={0,0},
[_effectSize.small]={-1,1},
[_effectSize.middle]={-2,2},
[_effectSize.big]={-3,3},
}
local _effectID={
[eQualityColor.eWhite]=18046,
[eQualityColor.eGreen]=18046,
[eQualityColor.eBlue]=18046,
[eQualityColor.ePurple]=18047,
[eQualityColor.eOrange]=18048,
[eQualityColor.eRed]=18049,
[eQualityColor.ePink]=18049,
}

local _effectIDbaozha={
[eQualityColor.eWhite]=18042,
[eQualityColor.eGreen]=18042,
[eQualityColor.eBlue]=18042,
[eQualityColor.ePurple]=18043,
[eQualityColor.eOrange]=18044,
[eQualityColor.eRed]=18045,
[eQualityColor.ePink]=18045,
}


local chouType=
{
one=1,
ten=2,
}


local DurationTime=
{
[chouType.one]={6.6,6.9},
[chouType.ten]={6.6,6.9},
}

local _effectEnter=10545
local _progressWidth=13
local _progressSpeed=370
local _progressPadding=56
local _progressStep=134
local _itemWidth=1030
local _autoWait=10
local _switchDuartion=0.2
local _abName="ui/windows/activities/sub_gujixunxian/gujixunxian_atlas_pak.ab"
local UIListScroller=simple_class(UIEnhancedScroller)



function UISubAct_gujixunxianWin:onLoaded(...)
self:bindComponents()
_this=self



local _onBeginDrag=function(...)self:onBeginDrag(...)end
local _onEndDrag=function(...)self:onEndDrag(...)end
local _onDrag=function(...)self:onDrag(...)end
self.winlua:SetChildUIDragEvent(self.singleRoleItem:getID(),0,_onBeginDrag,_onEndDrag,_onDrag)
self.singleRoleWidget=self.singleRoleItem:getChildWidgetBase()

self.screenHeight=self.winlua:GetChildRectHeight(-1)
self.screenWidth=self.winlua:GetChildRectWidth(-1)

self:addNotify(notifyConfig.onShowPrize,self.onShowPrize)
self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)

activitiesController:setUI_activity_main_Win_blackImg(false)
end


function UISubAct_gujixunxianWin:__delete()
self:stopBgAudioSound()
self:unbindComponents()
if self.showingResult then
UIManager:invokeUIMethod(self.parentWin,'activeRoot',true)
end
_this=nil
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self:recordAllNotFullOpenItem(true)
local subActInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
if subActInfo then
subActInfo:clearNoteSelect()
end
if self.animBt then
behaviorManager:removeBehaviorTree(self.animBt)
self.animBt=nil
end
end




function UISubAct_gujixunxianWin:onShow(argtable,afterOnloaded)
buildlightController:setBLState(false)
if self.fmTweener then
for k,v in pairs(self.fmTweener)do
v:Kill()
end
end
self.fmTweener={}

self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.parentWin=argtable.parentWin
self:stopBgAudioSound()
self.bgAudioHandleId=nil

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.costItemID=self.sub_actcfg.itemid

local disLen=#self.sub_actcfg.disciple
self.upBtn:setActive(disLen>1)
self.upBtnEx:setActive(disLen==1)
if disLen==1 then
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(self.sub_actcfg.disciple[1][1])
comHelper.setChildModelRawImageByDiziId(self.widget,dzData.id,self.upIconImage:getID(),0,eHeadCenterType.eHead)
end

self:initMoneyData({{self.costItemID},{self.sub_actcfg.money[1]}})

if afterOnloaded then
self:initModelView()
self:delayDo(0.5,function()
self:initMessage()
end)
end

self:refreshCostBtn()
self:refreshDesc()
self:refreshSkipBtn()

if self.actTimer==nil then
local func=function()
self:refreshActTimer()
self:updateMessage()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end
self:recordAllNotFullOpenItem()
self:initRewardPanel(false,true)










_this:delayDo(0.35,function()
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end


function UISubAct_gujixunxianWin:onHide()
buildlightController:setBLState(true)
self:stopBgAudioSound()
end




function UISubAct_gujixunxianWin.onShowPrize(prizeType,temp,effectData)
if _this==nil then return end
if prizeType==ePrizeType.eActivityXianShiChouKa then
local rewardlist={}
if effectData.list then
for i,v in ipairs(effectData.list)do
table.insert(rewardlist,{itemid=v.param_1,num=v.param_2})
end
end

_this.rewardlist=rewardlist

_this:refreshCostBtn()
_this:show_chouka_reward()
end
end

function UISubAct_gujixunxianWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
if itemid==_this.costItemID then
_this:refreshCostBtn()
end
local money=_this.moneyLookup[itemid]
if money then
_this:refreshMoneyItem(money,oldcount)
end
end

function UISubAct_gujixunxianWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
local money=_this.moneyLookup[moneyType]
if money then
_this:refreshMoneyItem(money,lastVal)
end
end



function UISubAct_gujixunxianWin:initMoneyData(datas)
local moneyList={}
local moneyLookup={}
for i=1,2 do
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

function UISubAct_gujixunxianWin:initMoneyItem(money)
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

function UISubAct_gujixunxianWin:refreshMoneyItem(money,lastVal)
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

function UISubAct_gujixunxianWin:onAddClick(moneyType)
gainControl:showCommonGainWin_item(moneyType)
end

function UISubAct_gujixunxianWin:clickMoney(moneyType)
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end

function UISubAct_gujixunxianWin:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UISubAct_gujixunxianWin:recordAllNotFullOpenItem(isclear)
local notFullOpenItemMark=self.notFullOpenItemMark
if notFullOpenItemMark~=nil then
for i,itemId in ipairs(notFullOpenItemMark)do
UIRecruitControl:recordNotFullOpenItem(itemId,nil)
end
notFullOpenItemMark=nil
end
if not isclear then
notFullOpenItemMark={}
self.notFullOpenItemMark=notFullOpenItemMark
for i,v in ipairs(self.sub_actcfg.disciple)do
local itemId=v[1]
table.insert(notFullOpenItemMark,itemId)
UIRecruitControl:recordNotFullOpenItem(itemId,true)
end
end
end

function UISubAct_gujixunxianWin:refreshDesc()
local icon
local maxRoundNum=self.sub_actcfg.round
if self.myData.round==self.sub_actcfg.upround then
icon='image_gujixunxian_02'
else
icon='image_gujixunxian_02'
end
local lerp=maxRoundNum-self.myData.times
self.descIcon:setSprite(_abName,icon)
self.descTxt:setText(lerp)
end

function UISubAct_gujixunxianWin:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(time))
self.timeTxt:setText(time_str)
end

function UISubAct_gujixunxianWin:initModelView()



self.currModelIdx=1
self.hideColor=Color.New(1,1,1,0)
self:setSignleModel(self.currModelIdx)

self:refreshModelLove()
end

function UISubAct_gujixunxianWin:refreshModelLove()
self.canDrag=#self.sub_actcfg.disciple>1 and self.myData.itemid<=0
if self.canDrag then


self:startAutoSwitch()
elseif#self.sub_actcfg.disciple==1 then
self:setSignleModel(1)
self:stopAutoSwitch()
else



self:setSignleModel(self.myData.itemid,Color.white)
self:stopAutoSwitch()
end
end

function UISubAct_gujixunxianWin:setSignleModel(index,color,callback)
local itemID=self.sub_actcfg.disciple[index][1]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo

local args={bgFisrt=true}
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,args)
local dzpos=self.sub_actcfg.dzpos[itemID]
local anim=eAnimationID.stand
local offsetx=dzpos[1]
local offsety=dzpos[2]
local scale=dzpos[3]
local flipX=dzpos[4]==1

if api_Available_SetChildUIModelUpdateRendererSize()then
self.singleRoleWidget:SetChildUIModelShowTarget(0,modelParams.body,scale,modelParams.componets,anim,false,false,0,callback)
self.singleRoleWidget:SetChildUIModelShowTargetOffset(0,offsetx,offsety)
self.singleRoleWidget:SetChildUIModelShowFlipX(0,flipX)
self.singleRoleWidget:SetChildUIModelUpdateRendererSize(0,true)
else
local func=function()
if _this==nil then return end
self:delayDo(0.2,function()
local rt=self.singleRoleWidget:getCommonComponent(0,'RectTransform')
local r=rt:GetChild(0):GetChild(0):GetChild(0)
for i=1,r.childCount do
local child=r:GetChild(i-1):GetComponent("RectTransform")
child.sizeDelta=Vector2.one*1000
end
end)

if callback then
callback()
end
end
self.singleRoleWidget:SetChildUIModelShowTarget(0,modelParams.body,scale,modelParams.componets,anim,false,false,0,func)
self.singleRoleWidget:SetChildUIModelShowTargetOffset(0,offsetx,offsety)
self.singleRoleWidget:SetChildUIModelShowFlipX(0,flipX)
end
if color then
self.singleRoleWidget:SetChildUIModelShowColor(0,color)
end
end

function UISubAct_gujixunxianWin:onBeginDrag(id,pos)
if not self.canDrag then
return
end

self.dragPos=pos
self.dragFlag=0
self:stopAutoSwitch()
end

function UISubAct_gujixunxianWin:onEndDrag(id,pos)
if self.dragPos==nil or self.dragFlag==nil then return end

local right=mathHelper.getBitValue(self.dragFlag,0)
local left=mathHelper.getBitValue(self.dragFlag,1)
if right~=left then
self.currModelIdx=self.currModelIdx+(right and 1 or-1)
local count=#self.sub_actcfg.disciple
if self.currModelIdx<=0 then
self.currModelIdx=count
elseif self.currModelIdx>count then
self.currModelIdx=self.currModelIdx-count
end

self:doSwitchTo(self.currModelIdx)
else
self:startAutoSwitch()
end

self.dragPos=nil
self.dragFlag=nil
end

function UISubAct_gujixunxianWin:onDrag(id,pos,dt)
if self.dragPos==nil or self.dragFlag==nil then return end

if self.dragPos.x<pos.x then
self.dragFlag=mathHelper.setbit(self.dragFlag,0)
elseif self.dragPos.x>pos.x then
self.dragFlag=mathHelper.setbit(self.dragFlag,1)
end

self.dragPos=pos
end

function UISubAct_gujixunxianWin:startAutoSwitch()
if self.canDrag and not self.autoSwitchTick then
self.autoSwitchTick=self:setTimer(_autoWait,0,function()
self.currModelIdx=self.currModelIdx+1
local count=#self.sub_actcfg.disciple
if self.currModelIdx>count then
self.currModelIdx=self.currModelIdx-count
end
self:doSwitchTo(self.currModelIdx)
end)
end
end

function UISubAct_gujixunxianWin:stopAutoSwitch()
if self.autoSwitchTick then
self:stopTimerByID(self.autoSwitchTick)
self.autoSwitchTick=nil
end
end

function UISubAct_gujixunxianWin:doSwitchTo(index)
self:stopAutoSwitch()
if self.switching then
self:setSignleModel(index,nil,function()
self.singleRoleWidget:SetChildUIModelShowColor(0,self.hideColor)
self.singleRoleWidget:SetChildUIModelShowFadeToColor(0,Color.white,_switchDuartion,0,function()
self.switching=false
self:startAutoSwitch()
end)
end)
else
self.switching=true
self.singleRoleWidget:SetChildUIModelShowFadeToColor(0,self.hideColor,_switchDuartion,0,function()
self:doSwitchTo(index)
end)
end
end

function UISubAct_gujixunxianWin:startAutoScroll()
if not self.autoScrollTimer then
self.autoScrollTimer=self:setTimer(_autoWait,0,function()
local startIdx=self.scrollscript:getStartCellViewIndex()
local endIdx=self.scrollscript:getEndCellViewIndex()
local count=#self.sub_actcfg.disciple
for i=startIdx,endIdx do
local dataIdx=i%count
local cell=self.scrollscript:GetCell(dataIdx)
local contentPos=self.roleContent.anchoredPosition.x
local cellPos=cell:GetChildAnchoredPosition(-1).x
if math.abs(contentPos+cellPos)<1 then
local nextIdx=(dataIdx+1)%count
self:roleJumpTo(nextIdx,0.2)
return
end
end
end)
end
end

function UISubAct_gujixunxianWin:stopAutoScroll()
if self.autoScrollTimer then
self:stopTimerByID(self.autoScrollTimer)
self.autoScrollTimer=nil
end
end

function UISubAct_gujixunxianWin:initRewardPanel(anim,isInit)
local target=self.sub_actcfg.target
local max=#target
local total=self.myData.total
local flag=self.myData.flag
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
local idx=max-i+1
local d=target[idx]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=mathHelper.getBitValue(flag,idx-1)


local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isGray=not fix
local graynum=0
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(_rewardCmp.item,prop)
item:SetBaseItemClickEvent(_rewardCmp.item,function(...)
if _this==nil then return end
_this:onClickItem(idx)
end)

item:SetChildText(_rewardCmp.num,fix and rewardFlag and""or num)

item:SetChildActive(_rewardCmp.hasFlag,fix and not rewardFlag)

item:SetChildActive(_rewardCmp.gotFlag,fix and rewardFlag)

item:SetChildActive(_rewardCmp.pointBg,fix and rewardFlag)
item:SetChildActive(_rewardCmp.numBg,not fix)
item:SetChildActive(_rewardCmp.highLight,fix and not rewardFlag)

if fix then
if not rewardFlag then
if not topFlag1 then
topFlag1=i
end
else
if not topFlag2 then
topFlag2=i
end
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
local viewHeight=self.rewardScrollView:getChildRectHeight()
self.winlua:ForceLayoutRect(self.rewardContent:getID())
if not self.maxContentPosY then
local contentHight=self.rewardContent:getChildSizeDeltaY()
self.maxContentPosY=math.max(contentHight-viewHeight,0)
end
local y=Mathf.Clamp(((topFlag1 or topFlag2 or max)-2)*_progressStep,0,self.maxContentPosY)
self.rewardContent:setChildAnchoredPos(0,y)
end
end

function UISubAct_gujixunxianWin:onClickItem(index)
local total=self.myData.total
local flag=self.myData.flag

local target=self.sub_actcfg.target
local d=target[index]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=mathHelper.getBitValue(flag,index-1)

local itemid=reward[1]
if fix and not rewardFlag then
local json_str=jsonHelper.encode({3,index})
activitiesController:sendProtocol(actSendType.eComonReqHandle,self.actID,self.subType,self.subid,json_str)
else
tipsManager.showTips({itemid=itemid,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end
end

function UISubAct_gujixunxianWin:onTipsBtn()

AudioManager.playBtnClick()
self:showWindow('UISubAct_xianshichouka_showRewardWin',{actID=self.actID,sub_act_type=self.subType,sub_act_id=self.subid})
end

function UISubAct_gujixunxianWin:onShopBtn()

AudioManager.playBtnClick()
local jumpParam=self.sub_actcfg.jumpParam
jumpManager:jump(jumpParam)
end

function UISubAct_gujixunxianWin:onViewBtn(itemid)
if self.playingAnim then return end
UIRecruitControl:showItemDiscipleInfoByItemId2(itemid)
end

function UISubAct_gujixunxianWin:onUpBtn()
local args={
actId=self.actID,
subType=self.subType,
subId=self.subid,
parentWin=self,
current=self.myData.itemid
}
self:showWindow('UISubAct_gujixunxian_SelectLoveDialog',args)
end

function UISubAct_gujixunxianWin:onUpBtnEx()
if#self.sub_actcfg.disciple==1 then
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(self.sub_actcfg.disciple[1][1])
UIRecruitControl:showItemDiscipleInfoByItemId2(dzData.srctype)
end
end

function UISubAct_gujixunxianWin:refreshSkipBtn()
if self.skipFlag==nil then
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianJieQiYuan,"skipFlag",false)
self.skipFlag=flag
end
self.skipSelectImg:setActive(self.skipFlag)
end

function UISubAct_gujixunxianWin:onSkipBtn()
local typo=ACTOR_SETTING_TYPE.eXianJieQiYuan
self.skipFlag=not self.skipFlag
userActorArraySetting.set(typo,"skipFlag",self.skipFlag)
userActorArraySetting.flush(typo)
self:refreshSkipBtn()
end

function UISubAct_gujixunxianWin:getFastBuy()
local d=self.fastBuy[1]
return d[1],d[2]
end


function UISubAct_gujixunxianWin:refreshCostBtn()
local hasfree=activitiesHandle_xianjieqiyuan.checkHasFree(self.subType,self.subid,self.myData.free)
local itemid=self.sub_actcfg.itemid
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

function UISubAct_gujixunxianWin:onOneBtn()
self:check_useItem(1,1,1)
end

function UISubAct_gujixunxianWin:onTenBtn()
self:check_useItem(10,2,1)
end

function UISubAct_gujixunxianWin:check_useItem(usecnt,typo,typo2)
if self.clickLockTime then
if gameUtilityModel.getServerShortTime()<self.clickLockTime then
return
end
self.clickLockTime=nil
end

local itemIdx=self.myData.itemid
if itemIdx<=0 then
local actID=self.actID
local subType=self.subType
local subid=self.subid
local disciple=self.sub_actcfg.disciple
local defaultdz=self.sub_actcfg.defaultdz
if defaultdz==0 then
defaultdz=1
end
if#self.sub_actcfg.disciple>1 then
local itemID=disciple[defaultdz][1]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local contentStr=FMT.fmt('需要先选择心愿弟子，继续操作将会自动将<color=#549327>{0}</color>选为心愿弟子，是否确认?\n\n注：心愿弟子可随时进行更换',dzData.disciplename)
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
local json_str=jsonHelper.encode({1,defaultdz})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)

_this.markUseData={usecnt,typo,typo2}
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
local json_str=jsonHelper.encode({1,defaultdz})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)

_this.markUseData={usecnt,typo,typo2}
end
else
self:useItem(usecnt,typo,typo2)
end
end

function UISubAct_gujixunxianWin:useItem(usecnt,typo,typo2)
local closeback=function()
if _this==nil then return end
UIManager:invokeUIMethod('UISubAct_gujixunxian_rewardWin','clearClickLock',true)
end
local callFunc=function()
local itemid=self.sub_actcfg.itemid
local actID=self.actID
local subType=self.subType
local subid=self.subid
local callback=function()
if _this==nil then return end
_this.mark_showType=typo
_this.mark_showType2=typo2
_this.clickLockTime=gameUtilityModel.getServerShortTime()+10
local json_str=jsonHelper.encode({2,typo})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
UIManager:invokeUIMethod('UISubAct_gujixunxian_rewardWin','clearClickLock')
end

local hasfree=activitiesHandle_xianjieqiyuan.checkHasFree(subType,subid,self.myData.free)
if typo==1 and hasfree then
callback()
return
end

if not gainControl:showGainWin(itemid,usecnt)then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianYuanXunFnagCostChouKa)
if not flag then
local iconname=iconHelper.getIconName(itemid)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local contentStr=FMT.fmt('是否消耗{0}<color=#7d3b17>{1}</color> 进行{2}次{3}？',iconStr,usecnt,usecnt,_this.sub_actcfg.sub_name)
local show_data={
type='UIDialougeWithIcon',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
choosetext='今日不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianYuanXunFnagCostChouKa,flag)
end,
okcallback=function()
if _this==nil then return end
callback()
end,
cancelcallback=closeback,
closecallback=closeback,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
callback()
end
else
UIManager:invokeUIMethod('UISubAct_gujixunxian_rewardWin','clearClickLock',true)
end
end

if#self.sub_actcfg.disciple==1 then
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eYaoTianXunXianMaxLP)
if not flag then
local isMaxLP,count=dzLingCuiShopController:checkFullTianMingItemEx(self.sub_actcfg.disciple[1][1])
if isMaxLP then
local contentStr='当前弟子灵魄已满，是否继续进行瑶天寻仙？'
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
choosetext='今日不再提示',
choosecallback=function(flag)
if _this==nil then return end
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eYaoTianXunXianMaxLP,flag)
end,
okcallback=function()
if _this==nil then return end
callFunc()
end,
cancelcallback=closeback,
closecallback=closeback,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
return
end
end
end
callFunc()
end




function UISubAct_gujixunxianWin:testAnim(typo,colors)
local func=function()
if _this==nil then return end
local func2=function()
if _this==nil then return end
_this:resetResultAnim()
end
_this:delayDo(2,func2)
end

end


function UISubAct_gujixunxianWin:stopOverTimer()
if self.ovetTimer then
self:stopTimerByID(self.ovetTimer)
self.ovetTimer=nil
end
end

function UISubAct_gujixunxianWin:hideEffectRoot()
for i,effect in pairs(self.texiao)do
if i~='guaidan0'then
effect:setActive(false)
end
end
end

function UISubAct_gujixunxianWin:playResultAnim(typo,colors,func)

UIManager:invokeUIMethod(self.parentWin,'activeRoot',false)
self.playingAnim=true


self.bottomRoot:setChildDOLocalMoveY(0,0.35)
self.topRoot:setChildDOLocalMoveY(0,0.35)
self.rightRoot:setChildDOLocalMoveX(0,0.35)

self.root:setChildCanvasGroupRaycast(false)
self.root:setChildCanvasGroupDOFade(0,0.35)

local callback=function()
self.animBt=nil
self:stopOverTimer()
if typo==chouType.one then

AudioManager.playAudio(505)
elseif typo==chouType.ten then

AudioManager.playAudio(506)
end

if func then
func()
end

return true
end

table.sort(colors,function(a,b)
return a>b
end)

local firstEffect,firstEffectid,bloomEffectid

if typo==chouType.one then

self:hideEffectRoot()
local effect=self.texiao["guaidan0"]
local curcolor=colors[1]
local effectid=_effectID[curcolor]
firstEffectid=effectid
bloomEffectid=_effectIDbaozha[curcolor]
self.winlua:SetChildShowEffect(effect:getID(),effectid,true)
firstEffect=effect
elseif typo==chouType.ten then

local index=1
for i,effect in pairs(self.texiao)do
effect:setActive(true)
local curcolor=colors[index]
local effectid=_effectID[curcolor]
if index==1 then
bloomEffectid=_effectIDbaozha[curcolor]
firstEffectid=effectid
firstEffect=effect
end
index=index+1
self.winlua:SetChildShowEffect(effect:getID(),effectid,true)


end
end

self.Stage772050:setAnimatorInteger('nStateID',2,true)
self.ovetTimer=self:delayDo(DurationTime[typo][1],function(...)
if _this then

self.winlua:SetChildShowEffect(firstEffect:getID(),bloomEffectid,true)
end
end)
self.ovetTimer2=self:delayDo(DurationTime[typo][2],function(...)
if _this then
callback()
end
end)
end

function UISubAct_gujixunxianWin:resetResultAnim()
if self.delayResetTime then
self:stopTimerByID(self.delayResetTime)
self.delayResetTime=nil
end

UIManager:invokeUIMethod(self.parentWin,'activeRoot',true)
self.playingAnim=nil
self.showingResult=false
self.root:setChildCanvasGroupRaycast(true)
self.root:setChildCanvasGroupAlpha(1)

for i,v in ipairs(self.effectBottom)do
v:setChildShowEffect(-1,false)
end
self.Stage772050:setAnimatorInteger('nStateID',1,true)

end

function UISubAct_gujixunxianWin:lotteryPos(posList,sizeType)
local r=_effectRange[sizeType]
local targetList=posList[sizeType]
local rIndex=math.random(1,#targetList)
local w=targetList[rIndex]
local h=math.random(self.bottomBorder,self.topBorder)

for sizeName,sizeValue in pairs(_effectSize)do
local tempList=posList[sizeValue]
local range=_effectRange[sizeValue]
local minW=(r[1]+range[1])*_effectGridSpacing+w
local maxW=(r[2]+range[2])*_effectGridSpacing+w
for width=minW,maxW,_effectGridSpacing do
table.removeValue(tempList,width)
end

end

return w,h
end

function UISubAct_gujixunxianWin:lotterySizePos(count,sizeType,oTypeList,oPosList,iPosList)

for i=1,count do
local rindex=math.random(2,#oTypeList+1)
table.insert(oTypeList,rindex,sizeType)
local x,y=self:lotteryPos(iPosList,sizeType)
table.insert(oPosList[sizeType],{x,y})
end
end




function UISubAct_gujixunxianWin:initMessage()
self.messageSpeed=100
self.messageSpace=2
self.messageObjLookup={}
self.messageObjLookup[1]=self.messageTxt
self.messageObjLookup[2]=self.message2Txt
self.messageObjUsedLookup={}
self.messageList={}
self.messageBoxWidth=self.messageMask:getChildRectWidth()
self.nextRoundTime=5
end

function UISubAct_gujixunxianWin:updateMessage()
if self.lockMessage then return end
local c=#self.messageList
if c<2 then
local l_time
if c>0 then
for i,meassge in ipairs(self.messageList)do
if l_time==nil or meassge.endTime>l_time then
l_time=meassge.endTime
self.m_endTime=l_time
end
end
end
if l_time==nil or Time.realtimeSinceStartup>l_time then
if self.showNextRound then
l_time=self.m_endTime or 0
if Time.realtimeSinceStartup>=l_time+self.nextRoundTime then
self.showNextRound=nil
self:addMessage()
end
else
self:addMessage()
end
end
end
end

function UISubAct_gujixunxianWin:addMessage()
local obj_idx=nil
for idx,obj in pairs(self.messageObjLookup)do
if self.messageObjUsedLookup[idx]==nil then
obj_idx=idx
break
end
end
if obj_idx then
local subActInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
local message_str,nextRound=subActInfo:getOneNoteStr()
if nextRound then
self.showNextRound=true
end
if message_str then
self.messageFrame:setActive(true)

local message={}
message.obj_idx=obj_idx
local obj=self.messageObjLookup[obj_idx]
self.messageObjUsedLookup[obj_idx]=true
obj:setChildCanvasGroupAlpha(0)
obj:setText(message_str)
self.lockMessage=true
self:delayDo(0.2,function()
local w=obj:getChildSizeDeltaX()
local time=(w+self.messageBoxWidth)/self.messageSpeed
local time2
if nextRound then
time2=time
else
time2=w/self.messageSpeed+self.messageSpace
end
message.endTime=Time.realtimeSinceStartup+time2
local h_w=self.messageBoxWidth/2
obj:setChildAnchoredPos(h_w,2)
local tweener=obj:setChildDOAnchorPosX(-h_w-w,time,function()
if _this==nil then return end
_this:removeMessage(obj_idx)
if nextRound then
_this.messageFrame:setActive(false)
end
end)
tweener:SetEase(_Ease.Linear)
obj:setChildCanvasGroupAlpha(1)
table.insert(self.messageList,message)
self.lockMessage=nil
end)
end
end
end

function UISubAct_gujixunxianWin:removeMessage(idx)
local f
for i,message_ in ipairs(self.messageList)do
if message_.obj_idx==idx then
f=i
break
end
end
if f then
local message=table.remove(self.messageList,f)
local obj_idx=message.obj_idx
local obj=self.messageObjLookup[obj_idx]
obj:setChildCanvasGroupAlpha(0)
self.messageObjUsedLookup[obj_idx]=nil
end
end



function UISubAct_gujixunxianWin:onBtnClose()
UIManager:invokeUIMethod(self.parentWin,'onBtnClose')
end



function UISubAct_gujixunxianWin:rec_selectUp()
self:closeWindow('UISubAct_xianshichouka_selectUpWin')

self:refreshModelLove()

if self.markUseData~=nil then
local usecnt=self.markUseData[1]
local typo=self.markUseData[2]
local typo2=self.markUseData[3]
self:useItem(usecnt,typo,typo2)
self.markUseData=nil
end
end

function UISubAct_gujixunxianWin:rec_chouka()
self:initRewardPanel(true)
end


function UISubAct_gujixunxianWin:show_chouka_reward()
if not self.skipFlag then
self:closeWindow('UISubAct_gujixunxian_rewardWin')
end
local args={act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid}
args.actData=self.myData
args.rewardlist=table.deepCopy(self.rewardlist)
args.showType=self.mark_showType
args.parentWin='UISubAct_gujixunxianWin'
args.openBack=function()
if _this==nil then return end
_this.clickLockTime=nil
end
local func=function()
self:showWindow('UISubAct_gujixunxian_rewardWin',args)
self:refreshDesc()
end

local colors={}
for i,v in ipairs(self.rewardlist)do
local color=itemsConfig.getItemColor(v.itemid)
table.insert(colors,color)
end

if not self.skipFlag then
self:playResultAnim(self.mark_showType,colors,func)
else
UIManager:invokeUIMethod(self.parentWin,'activeRoot',false)
self.root:setChildCanvasGroupRaycast(false)
self.root:setChildCanvasGroupDOFade(0,0.35)

self:showWindow('UISubAct_gujixunxian_rewardWin',args)
self:refreshDesc()
end
self.showingResult=true
self.mark_showType=nil
self.mark_showType2=nil
end

function UISubAct_gujixunxianWin:rec_tagReward(actID,subType,subid)
self:initRewardPanel()
end

function UISubAct_gujixunxianWin:stopBgAudioSound()
if self.bgAudioHandleId then
local fadeTime=1
AudioManager.fadeOutStopAudioById(self.bgAudioHandleId,fadeTime,false)
self.bgAudioHandleId=nil
end
end

function UISubAct_gujixunxianWin:roleJumpTo(index,tweenTime,callback)
self.scrollscript:jumpToDataIndex(index,0,0,true,tweenTime<=0 and 0 or 4,math.max(tweenTime,0),callback)
end

function UISubAct_gujixunxianWin:printItemIndex()

end

function UISubAct_gujixunxianWin:printScrollRectNormalizedPosition()
local pos=_this.winlua:GetChildScrollRectNormalizedPosition(_this.roleList:getID(),true)

end

function UISubAct_gujixunxianWin:doCheckScrollDone()
self:cancelCheckScrollDone()
self.scrollPos=self.roleContent.anchoredPosition.x
self.scrollDoneTimer=self:setTimer(0.2,0,function()
local pos=self.roleContent.anchoredPosition.x
if Mathf.Approximately(self.scrollPos,pos)then
self:cancelCheckScrollDone()
self.scrollPos=nil
local delta=(_itemWidth/2-pos%_itemWidth)/_itemWidth
local index=delta>0 and self.scrollscript:getEndCellViewIndex()or self.scrollscript:getStartCellViewIndex()
index=index%(#self.sub_actcfg.disciple)
self:roleJumpTo(index,0.5-math.abs(delta),function()
self:refreshModelLove()
end)
else
self.scrollPos=pos
end
end)
end

function UISubAct_gujixunxianWin:cancelCheckScrollDone()
if self.scrollDoneTimer then
self:stopTimerByID(self.scrollDoneTimer)
self.scrollDoneTimer=nil
end
end


function UIListScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIListScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIListScroller:RefreshCell(dataIndex,cellIndex,item)
local itemID=self.window.sub_actcfg.disciple[dataIndex][1]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo

local args={bgFisrt=true}
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,args)
local dzpos=self.window.sub_actcfg.dzpos[itemID]
local anim=eAnimationID.stand
local offsetx=dzpos[1]
local offsety=dzpos[2]
local scale=dzpos[3]
local flipX=dzpos[4]==1

if api_Available_SetChildUIModelUpdateRendererSize()then
item:SetChildUIModelShowTarget(0,modelParams.body,scale,modelParams.componets,anim,false,false,0)
item:SetChildUIModelShowTargetOffset(0,offsetx,offsety)
item:SetChildUIModelShowFlipX(0,flipX)
item:SetChildUIModelUpdateRendererSize(0,true)
else
local func=function()
if _this==nil then return end
self.window:delayDo(0.2,function()
local rt=item:getCommonComponent(0,'RectTransform')
local r=rt:GetChild(0):GetChild(0):GetChild(0)
for i=1,r.childCount do
local child=r:GetChild(i-1):GetComponent("RectTransform")
child.sizeDelta=Vector2.one*1000
end
end)
end
item:SetChildUIModelShowTarget(0,modelParams.body,scale,modelParams.componets,anim,false,false,0)
item:SetChildUIModelShowTargetOffset(0,offsetx,offsety)
item:SetChildUIModelShowFlipX(0,flipX)
end
item.gameObject.name=FMT.fmt("{0}_{1}",dataIndex,cellIndex)
end

function UIListScroller:onItemClick(eventName,clickCount,index,cell)
local dataIndex=index+1
local itemID=self.window.sub_actcfg.disciple[dataIndex][1]
self.window:onViewBtn(itemID)
end

function UIListScroller:onItemDrag(dataIndex,screenPos,cell)

end

function UIListScroller:onItemBeginDrag()
self.window:cancelCheckScrollDone()
self.window:stopAutoScroll()
end

function UIListScroller:onItemEndDrag()
if self.window.myData.itemid<=0 then
self.window:doCheckScrollDone()
end
end
