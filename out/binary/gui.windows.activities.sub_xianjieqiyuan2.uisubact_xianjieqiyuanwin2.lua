







def_class("UISubAct_xianjieqiyuanWin2",UIWindowBase)








function UISubAct_xianjieqiyuanWin2:bindComponents()

self.bgImg_1=UIObject.get(self,0)
self.bgImgRoot=UIGameobjectClone.new(self,1)
self.bottomRoot=UIObject.get(self,2)
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
self.equipBtn=UIButton.get(self,18)
self.equipItem=UIBaseItem.get(self,19)
self.loveDZHeadObj=UIObject.get(self,20)
self.message2Txt=UIText.get(self,21)
self.messageFrame=UIObject.get(self,22)
self.messageMask=UIObject.get(self,23)
self.messageTxt=UIText.get(self,24)
self.money1Root=UIObject.get(self,25)
self.money2Root=UIObject.get(self,26)
self.oneCostDesc=UIText.get(self,27)
self.oneCostIcon=UIImage.get(self,28)
self.oneCostReddot=UIObject.get(self,29)
self.oneFreeDesc=UIText.get(self,30)
self.rewadProgress=UIObject.get(self,31)
self.rewardContent=UIObject.get(self,32)
self.rewardNumTxt=UIText.get(self,33)
self.rewardScrollView=UIObject.get(self,34)
self.rightRoot=UIObject.get(self,35)
self.roleList=UIEnhancedScrollerLua.get(self,36)
self.root=UIObject.get(self,37)
self.singleRoleItem=UIObject.get(self,38)
self.skipBtn=UIButton.get(self,39)
self.skipSelectImg=UIObject.get(self,40)
self.tenCostDesc=UIText.get(self,41)
self.tenCostIcon=UIImage.get(self,42)
self.tenCostReddot=UIObject.get(self,43)
self.timeTxt=UIText.get(self,44)
self.topRoot=UIObject.get(self,45)
self.isShowReddotBtn=UIButton.get(self,46)

self.equipBtn:setButtonClick(function()self:onEquipBtn()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)
self.bgImg={
self.bgImg_1,
}
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



end


function UISubAct_xianjieqiyuanWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImg_1);self.bgImg_1=nil;
self.bgImgRoot:deleteSelf();self.bgImgRoot=nil;
_UIObject_release(self.bottomRoot);self.bottomRoot=nil;
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
_UIObject_release(self.equipBtn);self.equipBtn=nil;
_UIObject_release(self.equipItem);self.equipItem=nil;
_UIObject_release(self.loveDZHeadObj);self.loveDZHeadObj=nil;
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
_UIObject_release(self.tenCostDesc);self.tenCostDesc=nil;
_UIObject_release(self.tenCostIcon);self.tenCostIcon=nil;
_UIObject_release(self.tenCostReddot);self.tenCostReddot=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.topRoot);self.topRoot=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
self.bgImg=nil;
self.effectBottom=nil;
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

local _effectScale={
[_effectSize.point]={20,40},
[_effectSize.small]={40,70},
[_effectSize.middle]={70,120},
[_effectSize.big]={120,140},
}
local _effectGridSpacing=20
local _effectGridPadding=100
local _effectStepDuration=1.5
local _effectDelayRange={0,10}
local _effectRange={
[_effectSize.point]={0,0},
[_effectSize.small]={-1,1},
[_effectSize.middle]={-2,2},
[_effectSize.big]={-3,3},
}
local _effectID_XJQY={
[_effectSize.point]={
[eQualityColor.eWhite]=10552,
[eQualityColor.eGreen]=10552,
[eQualityColor.eBlue]=10552,
[eQualityColor.ePurple]=10553,
[eQualityColor.eOrange]=10550,
[eQualityColor.eRed]=10551,
[eQualityColor.ePink]=10551,
},
[_effectSize.small]={
[eQualityColor.eWhite]=10552,
[eQualityColor.eGreen]=10552,
[eQualityColor.eBlue]=10552,
[eQualityColor.ePurple]=10553,
[eQualityColor.eOrange]=10550,
[eQualityColor.eRed]=10551,
[eQualityColor.ePink]=10551,
},
[_effectSize.middle]={
[eQualityColor.eWhite]=10542,
[eQualityColor.eGreen]=10542,
[eQualityColor.eBlue]=10542,
[eQualityColor.ePurple]=10543,
[eQualityColor.eOrange]=10540,
[eQualityColor.eRed]=10541,
[eQualityColor.ePink]=10541,
},
[_effectSize.big]={
[eQualityColor.eWhite]=10542,
[eQualityColor.eGreen]=10542,
[eQualityColor.eBlue]=10542,
[eQualityColor.ePurple]=10543,
[eQualityColor.eOrange]=10540,
[eQualityColor.eRed]=10541,
[eQualityColor.ePink]=10541,
},
}












local _effectCountRange={
[_effectSize.small]={1,3},
[_effectSize.middle]={2,3},
[_effectSize.big]={1,2},
}
local _effectDefault={
color=nil,
duration=1,
delay=0,
yEnd=400,
yStart=0,
size=_effectSize.middle,
scale=1,
x=0,
ease=DG.Tweening.Ease.Linear,
}
local _effectExplode={
[eQualityColor.eWhite]=10548,
[eQualityColor.eGreen]=10548,
[eQualityColor.eBlue]=10548,
[eQualityColor.ePurple]=10549,
[eQualityColor.eOrange]=10544,
[eQualityColor.eRed]=10547,
[eQualityColor.ePink]=10547,
}
local _effectEase={


DG.Tweening.Ease.OutBack,
}
local _effectEnter=10545
local _progressWidth=13
local _progressSpeed=370
local _progressPadding=56
local _progressStep=137
local _itemWidth=1030
local _autoWait=10
local _switchDuartion=0.2
local _abName="ui/windows/activities/sub_xianjieqiyuan/xianjieqiyuan_atlas_pak.ab"
local UIListScroller=simple_class(UIEnhancedScroller)

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

local _effectID_YTXX={
[eQualityColor.eWhite]=18046,
[eQualityColor.eGreen]=18046,
[eQualityColor.eBlue]=18046,
[eQualityColor.ePurple]=18047,
[eQualityColor.eOrange]=18048,
[eQualityColor.eRed]=18049,
[eQualityColor.ePink]=18049,
}

local resultAnimEnum={
XJQY=1,
YTXX=2,
YGBH=3,
}

local playAnimGroup={
[resultAnimEnum.XJQY]={
playResultAnim=function(self,typo,colors,func)
if self and self.isClose then return end
self:playResultAnim_xjqy(typo,colors,func)
end,
resetResultAnim=function(self)
if self and self.isClose then return end
self:resetResultAnim_xjqy()
end,
showRewardWinName="UISubAct_xianjjieqiyuan_rewardWin",
},
[resultAnimEnum.YTXX]={
playResultAnim=function(self,typo,colors,func)
if self and self.isClose then return end
self:playResultAnim_ytxx(typo,colors,func)
end,
resetResultAnim=function(self)
if self and self.isClose then return end
self:resetResultAnim_ytxx()
end,
showRewardWinName="UISubAct_gujixunxian_rewardWin",
subItemwWinName="UIXianJieQiYuan2SubItem_YTXX"
},
[resultAnimEnum.YGBH]={
playResultAnim=function(self,typo,colors,func)
if self and self.isClose then return end
self:playResultAnim_ygbh(typo,colors,func)
end,
resetResultAnim=function(self)
if self and self.isClose then return end
self:resetResultAnim_ygbh()
end,
showRewardWinName="UISubAct_gujixunxian_rewardWin",
subItemwWinName="UIXianJieQiYuan2SubItem_YGBH"
},
}



function UISubAct_xianjieqiyuanWin2:onLoaded(...)
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
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)

self.effectInitGridList={}
for name,value in pairs(_effectSize)do
self.effectInitGridList[value]={}
end

local tempW=math.floor((self.screenWidth/2-_effectGridPadding)/_effectGridSpacing)*_effectGridSpacing
local firstSize=_effectDefault.size
local firstPosW=_effectDefault.x

local firstRange=_effectRange[firstSize]
self.leftBorder=-tempW
self.rightBorder=tempW
self.bottomBorder=_effectGridPadding
self.topBorder=self.screenHeight-_effectGridPadding
for sizeName,sizeValue in pairs(_effectSize)do
local range=_effectRange[sizeValue]
local minW=(firstRange[1]+range[1])*_effectGridSpacing+firstPosW
local maxW=(firstRange[2]+range[2])*_effectGridSpacing+firstPosW
for w=self.leftBorder,self.rightBorder,_effectGridSpacing do
if w<minW or w>maxW then
for h=self.bottomBorder,self.topBorder,_effectGridSpacing do
table.insert(self.effectInitGridList[sizeValue],w)
end
end
end
end

end


function UISubAct_xianjieqiyuanWin2:__delete()
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

self:stopOverTimer_ytxx()
self:stopOverTimer_ygbh()

buildlightController:resume()
end




function UISubAct_xianjieqiyuanWin2:onShow(argtable,afterOnloaded)

buildlightController:pause()
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

UIManager:invokeUIMethod(self.parentWin,'activeBlack',false)

self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.costItemID=self.sub_actcfg.itemid
self.hasEquip=self.sub_actcfg.lottery_equip~=nil
self.lottery_equip=nil
self:initMoneyData({{self.costItemID},{self.sub_actcfg.money[1]}})
self.resultAnimType=self.sub_actcfg.resultAnimType


self.animGroup=playAnimGroup[self.resultAnimType]

self:refreshBgImg()

if afterOnloaded then
self:initModelView()
self:delayDo(0.5,function()
self:initMessage()
end)
end

self:refreshCostBtn()
self:refreshDesc()
self:refreshSkipBtn()
self:refreshIsShowReddotBtn()

if self.actTimer==nil then
local func=function()
self:refreshActTimer()
self:updateMessage()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end
self:recordAllNotFullOpenItem()





self:refreshLoveDZObj()
self:refreshEquipLove()
end


function UISubAct_xianjieqiyuanWin2:onHide()
buildlightController:resume()
self:stopBgAudioSound()

end

function UISubAct_xianjieqiyuanWin2:onFreshEnd()
UIManager:invokeUIMethod(self.parentWin,'activeBlack',false)
end





function UISubAct_xianjieqiyuanWin2.onShowPrize(prizeType,temp,effectData)
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

function UISubAct_xianjieqiyuanWin2.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
if itemid==_this.costItemID then
_this:refreshCostBtn()
end
local money=_this.moneyLookup[itemid]
if money then
_this:refreshMoneyItem(money,oldcount)
end
end

function UISubAct_xianjieqiyuanWin2.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
local money=_this.moneyLookup[moneyType]
if money then
_this:refreshMoneyItem(money,lastVal)
end
end



function UISubAct_xianjieqiyuanWin2:initMoneyData(datas)
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

function UISubAct_xianjieqiyuanWin2:initMoneyItem(money)
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

function UISubAct_xianjieqiyuanWin2:refreshMoneyItem(money,lastVal)
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

function UISubAct_xianjieqiyuanWin2:onAddClick(moneyType)
gainControl:showCommonGainWin_item(moneyType)
end

function UISubAct_xianjieqiyuanWin2:clickMoney(moneyType)
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end

function UISubAct_xianjieqiyuanWin2:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end

function UISubAct_xianjieqiyuanWin2:recordAllNotFullOpenItem(isclear)
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
local itemId=v
table.insert(notFullOpenItemMark,itemId)
UIRecruitControl:recordNotFullOpenItem(itemId,true)
end
end
end

function UISubAct_xianjieqiyuanWin2:refreshDesc()
local icon
local maxRoundNum=self.sub_actcfg.round
if self.myData.round==self.sub_actcfg.upround then
icon='image_xianjieqiyuan_8'
else
icon='image_xianjieqiyuan_10'
end
local lerp=maxRoundNum-self.myData.times
self.descIcon:setSprite(_abName,icon)
self.descTxt:setText(lerp)
end

function UISubAct_xianjieqiyuanWin2:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(time))
self.timeTxt:setText(time_str)
end

function UISubAct_xianjieqiyuanWin2:initModelView()



self.currModelIdx=1
self.hideColor=Color.New(1,1,1,0)
self:setSignleModel(self.currModelIdx)

self:refreshModelLove()
end

function UISubAct_xianjieqiyuanWin2:refreshModelLove()
self.canDrag=#self.sub_actcfg.disciple>1 and self.myData.itemid<=0
if self.canDrag then


self:startAutoSwitch()
else



local index=self.myData.items[self.myData.itemid]
self:setSignleModel(index,Color.white)
self:stopAutoSwitch()
end
end

function UISubAct_xianjieqiyuanWin2:setSignleModel(index,color,callback)
local itemID=self.sub_actcfg.disciple[index]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo

local args={bgFisrt=true}
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,args)
local dzpos=self.sub_actcfg.dzpos[itemID]
if not dzpos then
logErr(FMT.fmt("仙界起源2 dzpos 没有 道具id {0} 的 配置 活动数据 ——》》 {1} {2} {3}",itemID,self.actID,self.subType,self.subid))
return
end
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

function UISubAct_xianjieqiyuanWin2:onBeginDrag(id,pos)
if not self.canDrag then
return
end

self.dragPos=pos
self.dragFlag=0
self:stopAutoSwitch()
end

function UISubAct_xianjieqiyuanWin2:onEndDrag(id,pos)
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

function UISubAct_xianjieqiyuanWin2:onDrag(id,pos,dt)
if self.dragPos==nil or self.dragFlag==nil then return end

if self.dragPos.x<pos.x then
self.dragFlag=mathHelper.setbit(self.dragFlag,0)
elseif self.dragPos.x>pos.x then
self.dragFlag=mathHelper.setbit(self.dragFlag,1)
end

self.dragPos=pos
end

function UISubAct_xianjieqiyuanWin2:startAutoSwitch()
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

function UISubAct_xianjieqiyuanWin2:stopAutoSwitch()
if self.autoSwitchTick then
self:stopTimerByID(self.autoSwitchTick)
self.autoSwitchTick=nil
end
end

function UISubAct_xianjieqiyuanWin2:doSwitchTo(index)
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

function UISubAct_xianjieqiyuanWin2:startAutoScroll()
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

function UISubAct_xianjieqiyuanWin2:stopAutoScroll()
if self.autoScrollTimer then
self:stopTimerByID(self.autoScrollTimer)
self.autoScrollTimer=nil
end
end

function UISubAct_xianjieqiyuanWin2:refreshEquipLove()
self.equipBtn:setActive(self.hasEquip)
if self.hasEquip then
local haveEquip=self.myData.equip_idx>0
self.equipItem:setActive(haveEquip)
if haveEquip then
local piece=self.sub_actcfg.lottery_equip[1][self.myData.equip_idx][1]
local itemId=vocEquipModel:getPieceToItem(piece)
local conf={itemid=itemId,itemcount="",showCountBG=false,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.equipItem:setChildPropData(prop)
end
end
end

function UISubAct_xianjieqiyuanWin2:onEquipBtn()
if self.lottery_equip==nil then
self.lottery_equip=xianyuanxunfangController:convertLoveEquip(self.sub_actcfg.lottery_equip[1])
end
local args={}
args.configs=self.lottery_equip
args.current=self.myData.equip_idx
args.callback=function(idx)
if _this==nil then return end
local json_str=jsonHelper.encode({5,idx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
self:showWindow('UICommonVocEquipListSelectWin',args)
end

function UISubAct_xianjieqiyuanWin2:initRewardPanel(anim,isInit)
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
local d=target[i]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=mathHelper.getBitValue(flag,i-1)


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
_this:onClickItem(i)
end)

item:SetChildText(_rewardCmp.num,fix and rewardFlag and""or num)

item:SetChildActive(_rewardCmp.hasFlag,fix and not rewardFlag)

item:SetChildActive(_rewardCmp.gotFlag,fix and rewardFlag)

item:SetChildActive(_rewardCmp.pointBg,fix and rewardFlag)
item:SetChildActive(_rewardCmp.numBg,not fix)
item:SetChildActive(_rewardCmp.highLight,fix and not rewardFlag)

if fix then
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
self.rewardContent:setChildAnchoredPos(0,y)
end
end

function UISubAct_xianjieqiyuanWin2:onClickItem(index)
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

function UISubAct_xianjieqiyuanWin2:onTipsBtn()

AudioManager.playBtnClick()
self:showWindow('UISubAct_xianshichouka_showRewardWin',{actID=self.actID,sub_act_type=self.subType,sub_act_id=self.subid})
end

function UISubAct_xianjieqiyuanWin2:onShopBtn()

AudioManager.playBtnClick()
local jumpParam=self.sub_actcfg.jumpParam
jumpManager:jump(jumpParam)
end

function UISubAct_xianjieqiyuanWin2:onViewBtn(itemid)
if self.playingAnim then return end
UIRecruitControl:showItemDiscipleInfoByItemId2(itemid)
end

function UISubAct_xianjieqiyuanWin2:refreshSkipBtn()
if self.skipFlag==nil then
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXianJieQiYuan,"skipFlag",false)
self.skipFlag=flag
end
self.skipSelectImg:setActive(self.skipFlag)
end

function UISubAct_xianjieqiyuanWin2:onSkipBtn()
local typo=ACTOR_SETTING_TYPE.eXianJieQiYuan
self.skipFlag=not self.skipFlag
userActorArraySetting.set(typo,"skipFlag",self.skipFlag)
userActorArraySetting.flush(typo)
self:refreshSkipBtn()
end

function UISubAct_xianjieqiyuanWin2:getFastBuy()
local d=self.fastBuy[1]
return d[1],d[2]
end

function UISubAct_xianjieqiyuanWin2:refreshCostBtn()
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

function UISubAct_xianjieqiyuanWin2:onOneBtn()
self:check_useItem(1,1,1)
end

function UISubAct_xianjieqiyuanWin2:onTenBtn()
self:check_useItem(10,2,1)
end

function UISubAct_xianjieqiyuanWin2:check_useItem(usecnt,typo,typo2)
if self.clickLockTime then
if gameUtilityModel.getServerShortTime()<self.clickLockTime then
return
end
self.clickLockTime=nil
end

local actID=self.actID
local subType=self.subType
local subid=self.subid
if self.myData.itemid<=0 then
local defaultdz=self.sub_actcfg.defaultdz
local dzStr=nil
for i,v in ipairs(defaultdz)do
local itemID=self.sub_actcfg.disciple[v]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local name=dzData.disciplename
dzStr=dzStr and FMT.fmt("{0},{1}",dzStr,name)or name
end
local contentStr=FMT.fmt('未选择弟子，是否使用{0}加入仙界奇缘？',dzStr or"")
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end
local json_str=jsonHelper.encode({4,defaultdz})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)

_this.markUseData={usecnt,typo,typo2}
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
return
elseif self.hasEquip and self.myData.equip_idx<=0 then
local equip_idx_=1
local piece=self.sub_actcfg.lottery_equip[1][equip_idx_][1]
local itemID=vocEquipModel:getPieceToItem(piece)
local name_str=itemsModel.getName(itemID)
local contentStr=FMT.fmt('需要先选择心愿装备，继续操作将会自动将<color=#549327>{0}</color>选为心愿装备，是否确认?\n\n注：心愿装备可随时进行更换',name_str)
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()
if _this==nil then return end

local json_str=jsonHelper.encode({5,equip_idx_})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)

_this.markUseData={usecnt,typo,typo2}
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
return
end
self:useItem(usecnt,typo,typo2)
end

function UISubAct_xianjieqiyuanWin2:useItem(usecnt,typo,typo2)
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
UIManager:invokeUIMethod(self.animGroup.showRewardWinName,'clearClickLock')
end
local closeback=function()
if _this==nil then return end
UIManager:invokeUIMethod(self.animGroup.showRewardWinName,'clearClickLock',true)
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
local contentStr=FMT.fmt('是否消耗{0}<color=#7d3b17>{1}</color> 进行{2}次仙界奇缘？',iconStr,usecnt,usecnt)
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
UIManager:invokeUIMethod(self.animGroup.showRewardWinName,'clearClickLock',true)
end
end




function UISubAct_xianjieqiyuanWin2:refreshBgImg()
local isUseXJQY=self.resultAnimType==resultAnimEnum.XJQY
local isUseYTXX=self.resultAnimType==resultAnimEnum.YTXX
local isUseYGBH=self.resultAnimType==resultAnimEnum.YGBH

self.bgImg_1:setActive(isUseXJQY)

if isUseXJQY then
self.root:setChildCanvasGroupAlpha(0)
self.bgImg_1:setChildUIModelEnableInitUISpinePara(false,true)
self.bgImg_1:setChildUIModelShowTarget(5236,1,{},0,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.35,function()
_this:initRewardPanel(false,true)
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end)
end

if isUseYTXX or isUseYGBH then

self.root:setChildCanvasGroupAlpha(0)
if self.showSubItemType==nil or self.showType~=self.resultAnimType then
self.bgImgRoot:recycleAll()
self.showSubItemType=self.resultAnimType
local parentIdx=self.bgImgRoot:getID()
local subItemwWinName=playAnimGroup[self.resultAnimType].subItemwWinName
self.bgImgLuaid=self.bgImgRoot:createObject(subItemwWinName,parentIdx,1,{})
elseif self.bgImgLuaid~=nil then
local luaObject=self.bgImgRoot:getLuaObject(self.bgImgLuaid)
if luaObject then
luaObject:onShow()
end
end


_this:initRewardPanel(false,true)
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)

end
end

function UISubAct_xianjieqiyuanWin2:playResultAnim(typo,colors,func)
if self.animGroup then
self.animGroup.playResultAnim(self,typo,colors,func)
end
end

function UISubAct_xianjieqiyuanWin2:resetResultAnim()
if self.animGroup then
self.animGroup.resetResultAnim(self)
end
end



function UISubAct_xianjieqiyuanWin2:testAnim(typo,colors)
local func=function()
if _this==nil then return end
local func2=function()
if _this==nil then return end
_this:resetResultAnim()
end
_this:delayDo(2,func2)
end
self:playResultAnim(typo or 1,colors,func)
end

function UISubAct_xianjieqiyuanWin2:playResultAnim_xjqy(typo,colors,func)

UIManager:invokeUIMethod(self.parentWin,'activeRoot',false)
self.playingAnim=true






self.root:setChildCanvasGroupRaycast(false)
self.root:setChildCanvasGroupDOFade(0,0.35)

local callback=function()
self.animBt=nil

if typo==1 then

AudioManager.playAudio(505)
elseif typo==2 then

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

local colorCnt=#colors
local effectInfos={}
effectInfos[1]=table.weakCopy(_effectDefault)
effectInfos[1].color=colors[1]
if colorCnt>1 then
local sizeList={_effectSize.middle}

local effectPosList={}
local posList={}
local indexList={}
for name,value in pairs(_effectSize)do
effectPosList[value]=table.weakCopy(self.effectInitGridList[value])
posList[value]={}
indexList[value]=0
end

for type=_effectSize.big,_effectSize.point,-1 do
local cntCfg=_effectCountRange[type]
local least=#colors-#sizeList
if cntCfg then
local min=cntCfg[1]
local max=math.min(cntCfg[2],least)
if max>=min then
local randomCnt=math.random(min,max)

self:lotterySizePos_xjqy(randomCnt,type,sizeList,posList,effectPosList)
else

end
else
self:lotterySizePos_xjqy(least,type,sizeList,posList,effectPosList)
end
end

for i=2,colorCnt do
local info={}
local size=sizeList[i]
local color=colors[i]
local delay=0.25+(i-1)*0.05


local duration=_effectStepDuration-delay



local scale=_effectScale[size]
scale=math.random(scale[1],scale[2])/100
local pList=posList[size]
local pIdx=indexList[size]
local pos=pList[pIdx+1]
local ease=_effectEase[math.random(1,#_effectEase)]

info.color=color
info.duration=duration
info.delay=delay
info.yEnd=pos[2]
info.yStart=-500
info.x=pos[1]
info.size=size
info.scale=scale
info.ease=ease:ToInt()

effectInfos[i]=info
indexList[size]=pIdx+1
end
end







































local args={
widget=self.winlua,
count=colorCnt,
effectMid=self.effectMid:getID(),
bgModel=self.bgImg_1:getID(),
effectCenter=self.effectCenter:getID(),
effectColor0=_effectExplode[colors[1]],
callback=callback,
}
for i=1,colorCnt do
local effectInfo=effectInfos[i]
local delayKey=FMT.fmt("delay{0}",i)
args[delayKey]=effectInfo.delay
local scaleKey=FMT.fmt("effectScale{0}",i)
args[scaleKey]=effectInfo.scale
local sPosKey=FMT.fmt("sPos{0}",i)
args[sPosKey]={effectInfo.x,effectInfo.yStart}
local ePosKey=FMT.fmt("ePos{0}",i)
args[ePosKey]={effectInfo.x,effectInfo.yEnd}
local colorKey=FMT.fmt("effectColor{0}",i)
args[colorKey]=_effectID_XJQY[effectInfo.size][effectInfo.color]

local itemKey=FMT.fmt("effectBottom{0}",i)
args[itemKey]=self.effectBottom[i]:getID()
local durationKey=FMT.fmt("duration{0}",i)
args[durationKey]=effectInfo.duration
local easeKey=FMT.fmt("ease{0}",i)
args[easeKey]=effectInfo.ease
end
self.animBt=behaviorManager:addBehaviorTree("bt_ui_xjqy",nil,true,args,true)
end

function UISubAct_xianjieqiyuanWin2:resetResultAnim_xjqy()
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

self.bgImg_1:setChildModelAnimationState(eAnimationID.stand,1)
end

function UISubAct_xianjieqiyuanWin2:lotteryPos_xjqy(posList,sizeType)
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

function UISubAct_xianjieqiyuanWin2:lotterySizePos_xjqy(count,sizeType,oTypeList,oPosList,iPosList)

for i=1,count do
local rindex=math.random(2,#oTypeList+1)
table.insert(oTypeList,rindex,sizeType)
local x,y=self:lotteryPos_xjqy(iPosList,sizeType)
table.insert(oPosList[sizeType],{x,y})
end
end



function UISubAct_xianjieqiyuanWin2:stopOverTimer_ytxx()
if self.ovetTimer then
self:stopTimerByID(self.ovetTimer)
self.ovetTimer=nil
end
end

function UISubAct_xianjieqiyuanWin2:hideEffectRoot_ytxx()
for i,effect in pairs(self.texiao)do
if i~='guaidan0'then
effect:setActive(false)
end
end
end

function UISubAct_xianjieqiyuanWin2:playResultAnim_ytxx(typo,colors,func)

UIManager:invokeUIMethod(self.parentWin,'activeRoot',false)
self.playingAnim=true


self.bottomRoot:setChildDOLocalMoveY(0,0.35)
self.topRoot:setChildDOLocalMoveY(0,0.35)
self.rightRoot:setChildDOLocalMoveX(0,0.35)

self.root:setChildCanvasGroupRaycast(false)
self.root:setChildCanvasGroupDOFade(0,0.35)

local callback=function()
self.animBt=nil
self:stopOverTimer_ytxx()
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

local subCallBack=function(mfirstEffect,mfirstEffectid,mbloomEffectid)
firstEffect=mfirstEffect
firstEffectid=mfirstEffectid
bloomEffectid=mbloomEffectid
end

self.bgImgRoot:callChildFunc(self.bgImgLuaid,'playResultAnim',self,typo,colors,subCallBack)
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

function UISubAct_xianjieqiyuanWin2:resetResultAnim_ytxx()
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
self.bgImgRoot:callChildFunc(self.bgImgLuaid,'resetResultAnim')

end




function UISubAct_xianjieqiyuanWin2:stopOverTimer_ygbh()
if self.ovetTimer then
self:stopTimerByID(self.ovetTimer)
self.ovetTimer=nil
end
end

function UISubAct_xianjieqiyuanWin2:hideEffectRoot_ygbh()
for i,effect in pairs(self.texiao2)do
if i~='guaidan0'then
effect:setActive(false)
end
end
end

function UISubAct_xianjieqiyuanWin2:playResultAnim_ygbh(typo,colors,func)

UIManager:invokeUIMethod(self.parentWin,'activeRoot',false)
self.playingAnim=true


self.bottomRoot:setChildDOLocalMoveY(0,0.35)
self.topRoot:setChildDOLocalMoveY(0,0.35)
self.rightRoot:setChildDOLocalMoveX(0,0.35)

self.root:setChildCanvasGroupRaycast(false)
self.root:setChildCanvasGroupDOFade(0,0.35)

local callback=function()
self.animBt=nil
self:stopOverTimer_ytxx()
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

local subCallBack=function(mfirstEffect,mfirstEffectid,mbloomEffectid)
firstEffect=mfirstEffect
firstEffectid=mfirstEffectid
bloomEffectid=mbloomEffectid
end

self.bgImgRoot:callChildFunc(self.bgImgLuaid,'playResultAnim',self,typo,colors,subCallBack)
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

function UISubAct_xianjieqiyuanWin2:resetResultAnim_ygbh()
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
self.bgImgRoot:callChildFunc(self.bgImgLuaid,'resetResultAnim')

end







function UISubAct_xianjieqiyuanWin2:initMessage()
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

function UISubAct_xianjieqiyuanWin2:updateMessage()
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

function UISubAct_xianjieqiyuanWin2:addMessage()
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

function UISubAct_xianjieqiyuanWin2:removeMessage(idx)
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



function UISubAct_xianjieqiyuanWin2:onBtnClose()
UIManager:invokeUIMethod(self.parentWin,'onBtnClose')
end



function UISubAct_xianjieqiyuanWin2:rec_selectUp()
self:refreshLoveDZObj()
self:refreshModelLove()

if self.markUseData~=nil then
local usecnt=self.markUseData[1]
local typo=self.markUseData[2]
local typo2=self.markUseData[3]
self:check_useItem(usecnt,typo,typo2)
self.markUseData=nil
end
end

function UISubAct_xianjieqiyuanWin2:rec_selectEquip()
self:refreshEquipLove()

self:closeWindow('UICommonVocEquipListSelectWin')
if self.markUseData~=nil then
local usecnt=self.markUseData[1]
local typo=self.markUseData[2]
local typo2=self.markUseData[3]
self:check_useItem(usecnt,typo,typo2)
self.markUseData=nil
end
end

function UISubAct_xianjieqiyuanWin2:rec_chouka()
self:initRewardPanel(true)
end

function UISubAct_xianjieqiyuanWin2:show_chouka_reward()
local rewardWinName=self.animGroup.showRewardWinName

if not self.skipFlag then
self:closeWindow(rewardWinName)
end
local args={act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid}
args.actData=self.myData
args.rewardlist=table.deepCopy(self.rewardlist)
args.showType=self.mark_showType
args.parentWin='UISubAct_xianjieqiyuanWin2'
args.openBack=function()
if _this==nil then return end
_this.clickLockTime=nil
end
local func=function()
self:showWindow(rewardWinName,args)
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
self.winlua:SetChildModelAnimationStop(self.bgImg_1:getID(),eAnimationID.zhidui_enter,1)
self:showWindow(rewardWinName,args)
self:refreshDesc()
end
self.showingResult=true
self.mark_showType=nil
self.mark_showType2=nil
end

function UISubAct_xianjieqiyuanWin2:rec_tagReward(actID,subType,subid)
self:initRewardPanel()
end

function UISubAct_xianjieqiyuanWin2:stopBgAudioSound()
if self.bgAudioHandleId then
local fadeTime=1
AudioManager.fadeOutStopAudioById(self.bgAudioHandleId,fadeTime,false)
self.bgAudioHandleId=nil
end
end

function UISubAct_xianjieqiyuanWin2:roleJumpTo(index,tweenTime,callback)
self.scrollscript:jumpToDataIndex(index,0,0,true,tweenTime<=0 and 0 or 4,math.max(tweenTime,0),callback)
end

function UISubAct_xianjieqiyuanWin2:printItemIndex()

end

function UISubAct_xianjieqiyuanWin2:printScrollRectNormalizedPosition()
local pos=_this.winlua:GetChildScrollRectNormalizedPosition(_this.roleList:getID(),true)

end

function UISubAct_xianjieqiyuanWin2:doCheckScrollDone()
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

function UISubAct_xianjieqiyuanWin2:cancelCheckScrollDone()
if self.scrollDoneTimer then
self:stopTimerByID(self.scrollDoneTimer)
self.scrollDoneTimer=nil
end
end

function UISubAct_xianjieqiyuanWin2:refreshLoveDZObj()
local widget=self.loveDZHeadObj:getWidgetBase()
if self.initLoveDZHeadObj==nil then
self.initLoveDZHeadObj=true
widget:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onLoveDZObjBtn()
end)
end
local itemIdx=self.myData.itemid
local has=itemIdx>0

local str=has==true and'当前心愿'or'选择心愿弟子'
widget:SetChildText(1,str)

widget:SetChildActive(2,has)
if has==true then
local index=self.myData.items[itemIdx]
local itemID=self.sub_actcfg.disciple[index]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local imageInfo=dzData.imageInfo
local color=imageInfo.color
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
comHelper.setChildModelHeadIconBGByColor(widget,2,color)
comHelper.setChildModelRawImageEx(3,widget,modelParams,eHeadCenterType.eHead)
end

widget:SetChildActive(4,not has)
end

function UISubAct_xianjieqiyuanWin2:onLoveDZObjBtn()
local itemIdx=self.myData.itemid
if itemIdx>0 then
local args={
actId=self.actID,
subType=self.subType,
subId=self.subid,
parentWin=self,
}
self:showWindow('UISubAct_xianjieqiyuan_LoveListDialog',args)
else
local args={
actId=self.actID,
subType=self.subType,
subId=self.subid,
parentWin=self,
}
self:showWindow('UISubAct_xianjieqiyuan_SelectLoveDialog2',args)
end
end


function UIListScroller:OnSetCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIListScroller:OnRefreshCellView(dataIndex,cellIndex,cell)
self:RefreshCell(dataIndex,cellIndex,cell)
end

function UIListScroller:RefreshCell(dataIndex,cellIndex,item)
local itemID=self.window.sub_actcfg.disciple[dataIndex]
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
local itemID=self.window.sub_actcfg.disciple[dataIndex]
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



function UISubAct_xianjieqiyuanWin2:refreshIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
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

function UISubAct_xianjieqiyuanWin2:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_xianjieqiyuanWin2.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.actID==actId and _this.subType==subType and _this.subid==subId then
_this:refreshIsShowReddotBtn()
end
end

