







def_class("UIXianYuanXunFangWin",UIWindowBase)









function UIXianYuanXunFangWin:bindComponents()

self.bgImg=UIImage.get(self,0)
self.bottomRoot=UIObject.get(self,1)
self.changeDZBtn=UIButton.get(self,2)
self.changeDZBtnTxt=UIText.get(self,3)
self.cloudImg=UIObject.get(self,4)
self.descIcon=UIImage.get(self,5)
self.descTxt=UIText.get(self,6)
self.dzItemList=UIObject.get(self,7)
self.leftRoot=UIObject.get(self,8)
self.message2Txt=UIText.get(self,9)
self.messageFrame=UIObject.get(self,10)
self.messageMask=UIObject.get(self,11)
self.messageTxt=UIText.get(self,12)
self.modelObj=UIObject.get(self,13)
self.money1Root=UIObject.get(self,14)
self.money2Root=UIObject.get(self,15)
self.newSign=UIObject.get(self,16)
self.oneCostDesc=UIText.get(self,17)
self.oneCostIcon=UIImage.get(self,18)
self.oneCostReddot=UIObject.get(self,19)
self.oneFreeDesc=UIText.get(self,20)
self.posCollection=UIObject.get(self,21)
self.rightRoot=UIObject.get(self,22)
self.root=UIObject.get(self,23)
self.skipBtn=UIButton.get(self,24)
self.skipSelectImg=UIObject.get(self,25)
self.tenCostDesc=UIText.get(self,26)
self.tenCostIcon=UIImage.get(self,27)
self.tenCostReddot=UIObject.get(self,28)
self.timeObj=UIObject.get(self,29)
self.timeTxt=UIText.get(self,30)
self.topRoot=UIObject.get(self,31)

self.changeDZBtn:setButtonClick(function()self:onChangeDZBtn()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)



end


function UIXianYuanXunFangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.bottomRoot);self.bottomRoot=nil;
_UIObject_release(self.changeDZBtn);self.changeDZBtn=nil;
_UIObject_release(self.changeDZBtnTxt);self.changeDZBtnTxt=nil;
_UIObject_release(self.cloudImg);self.cloudImg=nil;
_UIObject_release(self.descIcon);self.descIcon=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.dzItemList);self.dzItemList=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.message2Txt);self.message2Txt=nil;
_UIObject_release(self.messageFrame);self.messageFrame=nil;
_UIObject_release(self.messageMask);self.messageMask=nil;
_UIObject_release(self.messageTxt);self.messageTxt=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.money2Root);self.money2Root=nil;
_UIObject_release(self.newSign);self.newSign=nil;
_UIObject_release(self.oneCostDesc);self.oneCostDesc=nil;
_UIObject_release(self.oneCostIcon);self.oneCostIcon=nil;
_UIObject_release(self.oneCostReddot);self.oneCostReddot=nil;
_UIObject_release(self.oneFreeDesc);self.oneFreeDesc=nil;
_UIObject_release(self.posCollection);self.posCollection=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.tenCostDesc);self.tenCostDesc=nil;
_UIObject_release(self.tenCostIcon);self.tenCostIcon=nil;
_UIObject_release(self.tenCostReddot);self.tenCostReddot=nil;
_UIObject_release(self.timeObj);self.timeObj=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.topRoot);self.topRoot=nil;
end
















local _this
local posEffectLookup={
[eQualityColor.eBlue]={10160,0},
[eQualityColor.ePurple]={10161,0},
[eQualityColor.eOrange]={10162,0},
[eQualityColor.eRed]={10163,1},
[eQualityColor.ePink]={10163,1},
}
local posEffectDelayLookup={
[eQualityColor.eBlue]=0.1,
[eQualityColor.ePurple]=0.1,
[eQualityColor.eOrange]=0.2,
[eQualityColor.eRed]=0.4,
[eQualityColor.ePink]=0.4,
}
local lastEffectDelay=1


function UIXianYuanXunFangWin:onLoaded(...)
_this=self
self:bindComponents()

local posCollectionGrid=self.posCollection:getChildCommonLayoutGroupWidgetList()
local cnt=posCollectionGrid.Count
self.posGroupsCnt=cnt

self:addNotify(notifyConfig.onShowPrize,self.onShowPrize)
self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIXianYuanXunFangWin:__delete()
self:stopBgAudioSound()
_this=nil
self:unbindComponents()
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self:recordAllNotFullOpenItem(true)
xianyuanxunfangModel:clearNoteSelect()
end


function UIXianYuanXunFangWin:onHide()
self:stopBgAudioSound()
end

function UIXianYuanXunFangWin.onShowPrize(prizeType,temp,effectData)
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

function UIXianYuanXunFangWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
if itemid==_this.costItemID then
_this:refreshCostBtn()
end
local money=_this.moneyLookup[itemid]
if money then
_this:refreshMoneyItem(money,oldcount)
end
end

function UIXianYuanXunFangWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
local money=_this.moneyLookup[moneyType]
if money then
_this:refreshMoneyItem(money,lastVal)
end
end



function UIXianYuanXunFangWin:initMoneyData(datas)
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

function UIXianYuanXunFangWin:initMoneyItem(money)
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

function UIXianYuanXunFangWin:refreshMoneyItem(money,lastVal)
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

function UIXianYuanXunFangWin:onAddClick(moneyType)
gainControl:showCommonGainWin_item(moneyType)
end

function UIXianYuanXunFangWin:clickMoney(moneyType)
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end

function UIXianYuanXunFangWin:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end






function UIXianYuanXunFangWin:onShow(argtable,afterOnloaded)
local isFull=argtable.isFull
self.isFull=isFull
if self.fmTweener then
for k,v in pairs(self.fmTweener)do
v:Kill()
end
end
self.fmTweener={}
self:stopBgAudioSound()
self.bgAudioHandleId=nil

self.myData=xianyuanxunfangModel:getData()
self.mycfg=xianyuanxunfangModel:getCfg2()
self.costItemID=self.mycfg.itemid

self:initMoneyData({{self.costItemID},{self.mycfg.money[1]}})

if afterOnloaded then
self:initModel()
self:delayDo(0.5,function()
self:initMessage()
end)
end
self:refreshModel()
self:refreshCostBtn()
self:refreshDesc()
self:refreshSkipBtn()
self:refreshNewSign()

if self.actTimer==nil then
local func=function()
self:refreshActTimer()
self:updateMessage()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end
self:recordAllNotFullOpenItem()

self.root:setChildCanvasGroupAlpha(0)
local func=function()
if _this==nil then return end

_this.root:setChildCanvasGroupDOFade(1,0.25,nil)




end






local bgSpine=5770
self.bgImg:setChildUIModelShowTarget(bgSpine,1,{},0,false,false,0,func)
local cloudSpine=5769
self.cloudImg:setChildUIModelShowTarget(cloudSpine,1,{},0,false,false,0,nil)

end

function UIXianYuanXunFangWin:recordAllNotFullOpenItem(isclear)
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
for i,v in ipairs(self.mycfg.disciple)do
local itemId=v[1]
table.insert(notFullOpenItemMark,itemId)
UIRecruitControl:recordNotFullOpenItem(itemId,true)
end
end
end

function UIXianYuanXunFangWin:refreshDesc()
local icon
local maxRoundNum=self.mycfg.round
if self.myData.round==self.mycfg.upround then
icon='image_xunxianch_1'
else
icon='image_xunxianch_2'
end
local lerp=maxRoundNum-self.myData.times
self.descIcon:setSprite(globalABLookup.xianyuanxunfang,icon)
self.descTxt:setText(lerp)
end

function UIXianYuanXunFangWin:refreshActTimer()

local actID=self.myData.actID
local actInfo=activitiesModel:getActInfo(actID)
local has=actInfo~=nil
self.timeObj:setActive(has)
if has then
local time=activitiesModel:getActEndLeftTime(actID)
local time_str=FMT.fmt('{0}',timeHelper.format_time_stamp3(time))
self.timeTxt:setText(time_str)
end
end

function UIXianYuanXunFangWin:initModel()
local widget=self.dzItemList:getWidgetBase()
for i=1,3 do
local item=widget:GetChildWidgetBase(i-1)

item:SetChildButtonClick(1,function()
self:onViewBtn(i)
end)
end
end

function UIXianYuanXunFangWin:refreshModel()

local dzlist={}
local checkHas=false
local itemIdx=self.myData.itemid
for i=1,self.mycfg.select_num do
local idx=self.myData.items[i]or 0
if idx>0 then checkHas=true end
if i==itemIdx then
table.insert(dzlist,1,idx)
else
table.insert(dzlist,idx)
end
end
self.dzlist=dzlist
local widget=self.dzItemList:getWidgetBase()
for i=1,3 do
local item=widget:GetChildWidgetBase(i-1)
local idx=self.dzlist[i]
local has_=idx~=0
item:SetChildActive(2,has_)
item:SetChildActive(3,not has_)
if has_ then
local itemid=self.mycfg.disciple[idx][1]
local dzData_=UIDiscipleModel:getItemDiscipleDataByItemId(itemid)
local info_=dzData_.imageInfo

local modelParams_=UIDiscipleModel:getDiscipleInsideModelInfoByData(info_)
modelParams_.scale=0.018
modelParams_.offset={0,1}




local modelScale=1
comHelper.setChildModelRawImageEx(0,item,modelParams_,eHeadCenterType.eNone,modelScale,false)
end
end

local has=itemIdx>0
self.modelObj:setActive(has)
if has then
local dzpos=self.mycfg.dzpos
local idx=self.myData.items[itemIdx]
local itemid=self.mycfg.disciple[idx][1]
local modelSet
if dzpos then
modelSet=dzpos[itemid]
end
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemid)
local info=dzData.imageInfo
local typo=1
local modelParams
local anim
if typo==1 then
local args={isNotBg=true}
modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,args)

anim=0
else
modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
anim=0
end
self.modelObj:setChildUIModelEnableInitUISpinePara(true,true)
local scale=1
local offsetX=0
local offsetY=0
local flipX=false
if modelSet then
offsetX=modelSet[1]or 0
offsetY=modelSet[2]or 0
scale=modelSet[3]or 0
if modelSet[4]==1 then
flipX=true
end
end
self.modelObj:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,anim,true)
self.modelObj:setChildUIModelShowFlipX(flipX)
self.modelObj:setChildAnchoredPos(offsetX,offsetY)
end

local str=checkHas and'更换卡池弟子'or'自选3名弟子加入卡池'
self.changeDZBtnTxt:setText(str)
end

function UIXianYuanXunFangWin:onTipsBtn()

AudioManager.playBtnClick()
self:showWindow('UIXianYuanXunFangDetailWin')
end

function UIXianYuanXunFangWin:onShopBtn()

AudioManager.playBtnClick()


end

function UIXianYuanXunFangWin:onViewBtn(_index)
if self.playingAnim then return end
local idx=self.dzlist[_index]
if idx~=0 then


self:showWindow('UIXianYuanXunFangInfoWin')
else
self:showWindow('UIXianYuanXunFangSelectWin')
end
end

function UIXianYuanXunFangWin:onChangeDZBtn()
self:showWindow('UIXianYuanXunFangSelectWin')
end

function UIXianYuanXunFangWin:refreshNewSign()
local isNew=xianyuanxunfangModel:checkAnyDZNew()
self.newSign:setActive(isNew)
end

function UIXianYuanXunFangWin:refreshSkipBtn()
if self.skipFlag==nil then
local data=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXianYuanXunFang,{})
local flag=data.skipAnim==true
self.skipFlag=flag
end
self.skipSelectImg:setActive(self.skipFlag)
end

function UIXianYuanXunFangWin:onSkipBtn()
local typo=ACTOR_SETTING_TYPE.eXianYuanXunFang
local data=userActorArraySetting.getBase(typo,{})
local flag=data.skipAnim==true
flag=not flag
self.skipFlag=flag
data.skipAnim=flag
userActorArraySetting.setBase(typo,data)
userActorArraySetting.flush(typo)
self:refreshSkipBtn()
end

function UIXianYuanXunFangWin:getFastBuy()
local d=self.fastBuy[1]
return d[1],d[2]
end

function UIXianYuanXunFangWin:refreshCostBtn()
local hasfree=xianyuanxunfangModel.checkHasFree(self.myData.free)
local itemid=self.costItemID
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

function UIXianYuanXunFangWin:onOneBtn()
self:check_useItem(1,1,1)
end

function UIXianYuanXunFangWin:onTenBtn()
self:check_useItem(10,2,1)
end

function UIXianYuanXunFangWin:check_useItem(usecnt,typo,typo2)
if self.clickLockTime then
if gameUtilityModel.getServerShortTime()<self.clickLockTime then
return
end
self.clickLockTime=nil
end

local itemIdx=self.myData.itemid
if itemIdx<=0 then
local disciple=self.mycfg.disciple
local defaultdz=self.mycfg.defaultdz
local itemID=defaultdz[1]
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

local selectList={}
for _,itemID in ipairs(defaultdz)do
for idx,v in ipairs(disciple)do
if v[1]==itemID then
table.insert(selectList,idx)
break
end
end
end
xianyuanxunfangController:reqSelectDZ(selectList)

_this.markUseData={usecnt,typo,typo2}
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
else
self:useItem(usecnt,typo,typo2)
end
end

function UIXianYuanXunFangWin:useItem(usecnt,typo,typo2)
local itemid=self.costItemID
local callback=function()
if _this==nil then return end
_this.mark_showType=typo
_this.mark_showType2=typo2
_this.clickLockTime=gameUtilityModel.getServerShortTime()+10

xianyuanxunfangController:reqChouKa(typo)

UIManager:invokeUIMethod('UIXianYuanXunFangRewardWin','clearClickLock')
end
local closeback=function()
if _this==nil then return end
UIManager:invokeUIMethod('UIXianYuanXunFangRewardWin','clearClickLock',true)
end












local hasfree=xianyuanxunfangModel.checkHasFree(self.myData.free)
if typo==1 and hasfree then
callback()
return
end

if not gainControl:showGainWin(itemid,usecnt)then

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianYuanXunFnagCostChouKa)
if not flag then
local iconname=iconHelper.getIconName(itemid)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,52)
local contentStr=FMT.fmt('是否消耗{0}<color=#7d3b17>{1}</color> 进行{2}次仙缘寻访？',iconStr,usecnt,usecnt)
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
UIManager:invokeUIMethod('UIXianYuanXunFangRewardWin','clearClickLock',true)
end
end




function UIXianYuanXunFangWin:testAnim(typo)
local func=function()
if _this==nil then return end
local func2=function()
if _this==nil then return end
_this:resetResultAnim()
end
_this:delayDo(2,func2)
end
self:playResultAnim(typo or 1,func)
end

function UIXianYuanXunFangWin:playResultAnim(typo,func)
self:resetResultAnim()
self.playingAnim=true


self.bottomRoot:setChildDOLocalMoveY(-30,0.35)
self.topRoot:setChildDOLocalMoveY(20,0.35)
self.rightRoot:setChildDOLocalMoveX(20,0.35)

self.modelObj:setChildDOScale(0.9,0.25)

self.root:setChildCanvasGroupRaycast(false)
self.root:setChildCanvasGroupDOFade(0,0.35)

self:delayDo(0.15,function()
self.bgImg:setChildDOScale(2,0.8,function()
if _this==nil then return end
_this:playPosEffect(typo,func)
end)
self.cloudImg:setChildCanvasGroupDOFade(0,0.8)
end)
end

function UIXianYuanXunFangWin:playResultAnim2(typo,func)
self:resetResultAnim()
self.playingAnim=true

self.root:setChildCanvasGroupRaycast(false)
self.root:setChildCanvasGroupAlpha(0)
self.cloudImg:setChildCanvasGroupAlpha(0)

self.bgImg:setChildDOScale(2,0.8,function()
if _this==nil then return end
_this:playPosEffect(typo,func)
end)
end

function UIXianYuanXunFangWin:playPosEffect(typo,func)

local index=math.random(1,self.posGroupsCnt)
self.groupsWidget=self.posCollection:getChildCommonLayoutGroupWidgetItem(index-1)
local poslist={}
for i=1,10 do
poslist[i]=i
end
local showEffectList={}
local rewardlist=self.rewardlist or{}
local c=0
for i,reward in ipairs(rewardlist)do
local itemid=reward.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
if color>=eQualityColor.eBlue then
c=c+1
local effectID=posEffectLookup[color][1]
local effectDelay=posEffectDelayLookup[color]
local f=math.random(1,#poslist)
local idx=table.remove(poslist,f)
table.insert(showEffectList,{effectID,effectDelay,color,idx})
if c>=10 then
break
end
end
end
if c>1 then
table.sort(showEffectList,function(a,b)
return a[3]<b[3]
end)
end


if typo==1 then

AudioManager.playAudio(505)
elseif typo==2 then

AudioManager.playAudio(506)
end

if c>0 then
local delay=0
for i,v in ipairs(showEffectList)do
local effectID=v[1]
local effectDelay=v[2]
local color=v[3]
local idx=v[4]
if i>1 then
delay=delay+effectDelay
end
local func=function()
local widget=self.groupsWidget
local posWidget=widget:GetChildWidgetBase(idx-1)
posWidget:SetChildShowEffect(0,effectID,true)
if color>=eQualityColor.eRed then

AudioManager.playAudio(508)
end
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
if i>=c then
delay=delay+lastEffectDelay+posEffectLookup[color][2]
end
end
local func2=function()
if func then
func()
end
end
self:delayDo(delay,func2)
else
if func then
func()
end
end
end

function UIXianYuanXunFangWin:resetResultAnim()
if self.delayResetTime then
self:stopTimerByID(self.delayResetTime)
self.delayResetTime=nil
end
if self.groupsWidget then
self.bottomRoot:setLocalPosY(0)
self.topRoot:setLocalPosY(0)
self.rightRoot:setLocalPosX(0)

self.modelObj:setScale(Vector3(1,1,1))

self.playingAnim=nil
self.root:setChildCanvasGroupRaycast(true)
self.root:setChildCanvasGroupAlpha(1)
self.bgImg:setScale(Vector3(1,1,1))
self.cloudImg:setChildCanvasGroupAlpha(1)

local widget=self.groupsWidget
for i=1,10 do
local posWidget=widget:GetChildWidgetBase(i-1)
posWidget:SetChildShowEffect(0,0,false)
end
self.groupsWidget=nil
end
end





function UIXianYuanXunFangWin:initMessage()
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

function UIXianYuanXunFangWin:updateMessage()
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

function UIXianYuanXunFangWin:addMessage()
local obj_idx=nil
for idx,obj in pairs(self.messageObjLookup)do
if self.messageObjUsedLookup[idx]==nil then
obj_idx=idx
break
end
end
if obj_idx then
local message_str,nextRound=xianyuanxunfangModel:getOneNoteStr()
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

function UIXianYuanXunFangWin:removeMessage(idx)
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



function UIXianYuanXunFangWin:onBtnClose()

AudioManager.playBtnClick()
if self.isFull then
UIFullCommonControl:closeUI(nil,true)
else
self:closeSelf()
end
end



function UIXianYuanXunFangWin:rec_selectDZ()
self:refreshModel()
if self.markUseData~=nil then
local usecnt=self.markUseData[1]
local typo=self.markUseData[2]
local typo2=self.markUseData[3]
self:useItem(usecnt,typo,typo2)
self.markUseData=nil
end
end

function UIXianYuanXunFangWin:rec_selectUp()
self:refreshModel()
end

function UIXianYuanXunFangWin:rec_chouka()
self:refreshCostBtn()
self:refreshDesc()
end

function UIXianYuanXunFangWin:show_chouka_reward()
if not self.skipFlag then
self:closeWindow('UIXianYuanXunFangRewardWin')
end
local args={}
args.rewardlist=table.deepCopy(self.rewardlist)
args.showType=self.mark_showType
args.parentWin='UIXianYuanXunFangWin'
args.openBack=function()
if _this==nil then return end
_this.clickLockTime=nil
end
local func=function()
self:showWindow('UIXianYuanXunFangRewardWin',args)
self:refreshDesc()
self.delayResetTime=self:delayDo(2,function()
self.delayResetTime=nil
self:resetResultAnim()
end)
end
if not self.skipFlag then
if self.mark_showType2==1 then
self:playResultAnim(self.mark_showType,func)
else
self:playResultAnim2(self.mark_showType,func)
end
else
self:showWindow('UIXianYuanXunFangRewardWin',args)
self:refreshDesc()
end
self.mark_showType=nil
self.mark_showType2=nil

end

function UIXianYuanXunFangWin:stopBgAudioSound()
if self.bgAudioHandleId then
local fadeTime=1
AudioManager.fadeOutStopAudioById(self.bgAudioHandleId,fadeTime,false)
self.bgAudioHandleId=nil
end
end

