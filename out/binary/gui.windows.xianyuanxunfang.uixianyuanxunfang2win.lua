







def_class("UIXianYuanXunFang2Win",UIWindowBase)









function UIXianYuanXunFang2Win:bindComponents()

self.bgImg=UIImage.get(self,0)
self.boomEffect=UIObject.get(self,1)
self.bottomRoot=UIObject.get(self,2)
self.cloudImg=UIObject.get(self,3)
self.descIcon=UIImage.get(self,4)
self.descTxt=UIText.get(self,5)
self.equipBtn=UIButton.get(self,6)
self.equipItem=UIBaseItem.get(self,7)
self.leftRoot=UIObject.get(self,8)
self.loveDZHeadObj=UIObject.get(self,9)
self.message2Txt=UIText.get(self,10)
self.messageFrame=UIObject.get(self,11)
self.messageMask=UIObject.get(self,12)
self.messageTxt=UIText.get(self,13)
self.modelRoot=UIObject.get(self,14)
self.money1Root=UIObject.get(self,15)
self.money2Root=UIObject.get(self,16)
self.oneCostDesc=UIText.get(self,17)
self.oneCostIcon=UIImage.get(self,18)
self.oneCostReddot=UIObject.get(self,19)
self.posGroup=UIObject.get(self,20)
self.rightRoot=UIObject.get(self,21)
self.root=UIObject.get(self,22)
self.singleRoleItem=UIObject.get(self,23)
self.skipBtn=UIButton.get(self,24)
self.skipSelectImg=UIObject.get(self,25)
self.tenCostDesc=UIText.get(self,26)
self.tenCostIcon=UIImage.get(self,27)
self.tenCostReddot=UIObject.get(self,28)
self.timeObj=UIObject.get(self,29)
self.timeTxt=UIText.get(self,30)
self.topRoot=UIObject.get(self,31)
self.uiRoot=UIObject.get(self,32)

self.equipBtn:setButtonClick(function()self:onEquipBtn()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)



end


function UIXianYuanXunFang2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.boomEffect);self.boomEffect=nil;
_UIObject_release(self.bottomRoot);self.bottomRoot=nil;
_UIObject_release(self.cloudImg);self.cloudImg=nil;
_UIObject_release(self.descIcon);self.descIcon=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.equipBtn);self.equipBtn=nil;
_UIObject_release(self.equipItem);self.equipItem=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.loveDZHeadObj);self.loveDZHeadObj=nil;
_UIObject_release(self.message2Txt);self.message2Txt=nil;
_UIObject_release(self.messageFrame);self.messageFrame=nil;
_UIObject_release(self.messageMask);self.messageMask=nil;
_UIObject_release(self.messageTxt);self.messageTxt=nil;
_UIObject_release(self.modelRoot);self.modelRoot=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.money2Root);self.money2Root=nil;
_UIObject_release(self.oneCostDesc);self.oneCostDesc=nil;
_UIObject_release(self.oneCostIcon);self.oneCostIcon=nil;
_UIObject_release(self.oneCostReddot);self.oneCostReddot=nil;
_UIObject_release(self.posGroup);self.posGroup=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.singleRoleItem);self.singleRoleItem=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.tenCostDesc);self.tenCostDesc=nil;
_UIObject_release(self.tenCostIcon);self.tenCostIcon=nil;
_UIObject_release(self.tenCostReddot);self.tenCostReddot=nil;
_UIObject_release(self.timeObj);self.timeObj=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.topRoot);self.topRoot=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this

local posEffectLookup={
[eQualityColor.eBlue]={20661,20662},
[eQualityColor.ePurple]={20663,20664},
[eQualityColor.eOrange]={20665,20666},
[eQualityColor.eRed]={20667,20668},
[eQualityColor.ePink]={20667,20668},
}

local posLookup={
[1]={0,-400,-450},
[2]={-125,-450,-500},
[3]={125,-450,-500},
[4]={-250,-650,-700},
[5]={300,-750,-800},
[6]={-375,-700,-750},
[7]={475,-500,-550},
[8]={-500,-700,-750},
[9]={600,-550,-600},
[10]={-600,-600,-650},
}







local _autoWait=10
local _switchDuartion=0.2
local _abName='ui/windows/xianyuanxunfang/xianyuanxunfang_atlas_pak.ab'


function UIXianYuanXunFang2Win:onLoaded(...)
_this=self
self:bindComponents()

local _onBeginDrag=function(...)self:onBeginDrag(...)end
local _onEndDrag=function(...)self:onEndDrag(...)end
local _onDrag=function(...)self:onDrag(...)end
self.winlua:SetChildUIDragEvent(self.singleRoleItem:getID(),0,_onBeginDrag,_onEndDrag,_onDrag)
self.singleRoleWidget=self.singleRoleItem:getChildWidgetBase()
local pos=self:getChildCanvas(-1)
local defaultSortLayer=pos[1]
local defaultSortOrder=pos[2]
self.cloudImg:setChildCanvas(defaultSortLayer,defaultSortOrder+2)
self.uiRoot:setChildCanvas(defaultSortLayer,defaultSortOrder+3)

self:addNotify(notifyConfig.onShowPrize,self.onShowPrize)
self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIXianYuanXunFang2Win:__delete()
self:stopBgAudioSound()
_this=nil
self:unbindComponents()
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self:recordAllNotFullOpenItem(true)
xianyuanxunfangModel:clearNoteSelect()
end


function UIXianYuanXunFang2Win:onHide()
self:stopBgAudioSound()
end

function UIXianYuanXunFang2Win.onShowPrize(prizeType,temp,effectData)
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

function UIXianYuanXunFang2Win.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
if itemid==_this.costItemID then
_this:refreshCostBtn()
end
local money=_this.moneyLookup[itemid]
if money then
_this:refreshMoneyItem(money,oldcount)
end
end

function UIXianYuanXunFang2Win.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
local money=_this.moneyLookup[moneyType]
if money then
_this:refreshMoneyItem(money,lastVal)
end
end



function UIXianYuanXunFang2Win:initMoneyData(datas)
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

function UIXianYuanXunFang2Win:initMoneyItem(money)
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

function UIXianYuanXunFang2Win:refreshMoneyItem(money,lastVal)
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

function UIXianYuanXunFang2Win:onAddClick(moneyType)
gainControl:showCommonGainWin_item(moneyType)
end

function UIXianYuanXunFang2Win:clickMoney(moneyType)
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end

function UIXianYuanXunFang2Win:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end






function UIXianYuanXunFang2Win:onShow(argtable,afterOnloaded)
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

self.dzShowList=xianyuanxunfangModel:getDZOpenSortList()
self.myData=xianyuanxunfangModel:getData()
self.mycfg=xianyuanxunfangModel:getCfg2()
self.costItemID=self.mycfg.itemid
self.actid=xianyuanxunfangModel:getActID()
self.hasEquip=self.mycfg.lottery_equip~=nil
self.lottery_equip=nil

self:initMoneyData({{self.costItemID},{self.mycfg.money[1]}})

if afterOnloaded then
self:initModelView()
self:delayDo(0.5,function()
self:initMessage()
end)
end
self:refreshEquipLove()
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
_this:delayDo(0.2,function()
_this.root:setChildCanvasGroupDOFade(1,0.35,nil)
end)



end






local bgSpine=5770
self.bgImg:setChildUIModelShowTarget(bgSpine,1,{},0,false,false,0,func)
local cloudSpine=5769
self.cloudImg:setChildUIModelShowTarget(cloudSpine,1,{},0,false,false,0,nil)

end

function UIXianYuanXunFang2Win:recordAllNotFullOpenItem(isclear)
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

function UIXianYuanXunFang2Win:refreshDesc()

local icon
if self.myData.round==self.mycfg.upround then
icon='image_xinxianyuanxunfang_wz3'
else
icon='image_xinxianyuanxunfang_wz2'
end
self.descIcon:setSprite(_abName,icon)

local maxRoundNum=self.mycfg.round
local lerp=maxRoundNum-self.myData.times
self.descTxt:setText(lerp)
end

function UIXianYuanXunFang2Win:refreshActTimer()
local actID=self.actid
if actID~=nil then
local actInfo=activitiesModel:getActInfo(actID)
local has=actInfo~=nil
self.timeObj:setActive(has)
if has then
local time=activitiesModel:getActEndLeftTime(actID)
local time_str=FMT.fmt('{0}',timeHelper.format_time_stamp3(time))
self.timeTxt:setText(time_str)
else
self.actid=nil
end
else
self.actid=xianyuanxunfangModel:getActID()
end
end

function UIXianYuanXunFang2Win:initModelView()
self.currModelIdx=1
self.hideColor=Color.New(1,1,1,0)
local itemid=self.dzShowList[self.currModelIdx][1]
self:setSignleModel(itemid)

self:refreshModelLove()

self:refreshLoveDZObj()
end

function UIXianYuanXunFang2Win:refreshLoveDZObj()
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
local idx=self.myData.items[itemIdx]
local itemid=self.mycfg.disciple[idx][1]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemid)
local imageInfo=dzData.imageInfo
local color=imageInfo.color
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
comHelper.setChildModelHeadIconBGByColor(widget,2,color)
comHelper.setChildModelRawImageEx(3,widget,modelParams,eHeadCenterType.eHead)
end

widget:SetChildActive(4,not has)
end

function UIXianYuanXunFang2Win:refreshEquipLove()
self.equipBtn:setActive(self.hasEquip)
if self.hasEquip then
local haveEquip=self.myData.equip_idx>0
self.equipItem:setActive(haveEquip)
if haveEquip then
local piece=self.mycfg.lottery_equip[1][self.myData.equip_idx][1]
local itemId=vocEquipModel:getPieceToItem(piece)
local conf={itemid=itemId,itemcount="",showCountBG=false,showname=true,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.equipItem:setChildPropData(prop)
end
end
end

function UIXianYuanXunFang2Win:onEquipBtn()
if self.lottery_equip==nil then
self.lottery_equip=xianyuanxunfangController:convertLoveEquip(self.mycfg.lottery_equip[1])
end
local args={}
args.configs=self.lottery_equip
args.current=self.myData.equip_idx
args.callback=function(idx)
if _this==nil then return end
xianyuanxunfangController:reqSelectEquip(idx)
end
self:showWindow('UICommonVocEquipListSelectWin',args)
end

function UIXianYuanXunFang2Win:refreshModelLove()
local itemIdx=self.myData.itemid
self.canDrag=#self.dzShowList>1 and itemIdx<=0
if self.canDrag then
self:startAutoSwitch()
else
local idx=self.myData.items[itemIdx]
local itemid=self.mycfg.disciple[idx][1]
self:setSignleModel(itemid,Color.white)
self:stopAutoSwitch()
end
end

function UIXianYuanXunFang2Win:setSignleModel(itemID,color,callback)
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo

local args={bgFisrt=true}
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,args)
local dzpos=self.mycfg.dzpos[itemID]
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

function UIXianYuanXunFang2Win:onBeginDrag(id,pos)
if not self.canDrag then
return
end

self.dragPos=pos
self.dragFlag=0
self:stopAutoSwitch()
end

function UIXianYuanXunFang2Win:onEndDrag(id,pos)
if self.dragPos==nil or self.dragFlag==nil then return end

local right=mathHelper.getBitValue(self.dragFlag,0)
local left=mathHelper.getBitValue(self.dragFlag,1)
if right~=left then
self.currModelIdx=self.currModelIdx+(right and 1 or-1)
local count=#self.dzShowList
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

function UIXianYuanXunFang2Win:onDrag(id,pos,dt)
if self.dragPos==nil or self.dragFlag==nil then return end

if self.dragPos.x<pos.x then
self.dragFlag=mathHelper.setbit(self.dragFlag,0)
elseif self.dragPos.x>pos.x then
self.dragFlag=mathHelper.setbit(self.dragFlag,1)
end

self.dragPos=pos
end

function UIXianYuanXunFang2Win:startAutoSwitch()
if self.canDrag and not self.autoSwitchTick then
self.autoSwitchTick=self:setTimer(_autoWait,0,function()
self.currModelIdx=self.currModelIdx+1
local count=#self.dzShowList
if self.currModelIdx>count then
self.currModelIdx=self.currModelIdx-count
end
self:doSwitchTo(self.currModelIdx)
end)
end
end

function UIXianYuanXunFang2Win:stopAutoSwitch()
if self.autoSwitchTick then
self:stopTimerByID(self.autoSwitchTick)
self.autoSwitchTick=nil
end
end

function UIXianYuanXunFang2Win:doSwitchTo(index)
self:stopAutoSwitch()
if self.switching then
local itemid=self.dzShowList[index][1]
self:setSignleModel(itemid,nil,function()
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

function UIXianYuanXunFang2Win:onTipsBtn()

AudioManager.playBtnClick()
self:showWindow('UIXianYuanXunFangDetailWin')
end

function UIXianYuanXunFang2Win:onShopBtn()

AudioManager.playBtnClick()
local actID=self.actid
if actID==nil then
UIManager.error('活动存在异常，暂时无法打开')
return
end
activitiesController:jump(actID)
if fullScreenUI.isActiveFull()then
local func=function()
xianyuanxunfangController:jumpWin2()
end
fullScreenUI.setNextActiveUICallback(func)
end
end

function UIXianYuanXunFang2Win:onLoveDZObjBtn()
self:showWindow('UIXianYuanXunFangSelect2Win')
end

function UIXianYuanXunFang2Win:refreshNewSign()
local widget=self.loveDZHeadObj:getWidgetBase()
local isNew=xianyuanxunfangModel:checkAnyDZNew()
widget:SetChildActive(5,isNew)
end

function UIXianYuanXunFang2Win:refreshSkipBtn()
if self.skipFlag==nil then
local data=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXianYuanXunFang,{})
local flag=data.skipAnim==true
self.skipFlag=flag
end
self.skipSelectImg:setActive(self.skipFlag)
end

function UIXianYuanXunFang2Win:onSkipBtn()
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

function UIXianYuanXunFang2Win:getFastBuy()
local d=self.fastBuy[1]
return d[1],d[2]
end

function UIXianYuanXunFang2Win:refreshCostBtn()
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
local iconName=iconHelper.getIconName(itemid)
self.oneCostIcon:setImageIcon(iconName)
str=tostring(needCnt)
if not fix then
str=toColorString(FONT_COLOR.eRedColor,str)
end
self.oneCostDesc:setText(str)
else
self.oneCostIcon:setActive(false)
self.oneCostDesc:setText('首次免费')
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

function UIXianYuanXunFang2Win:onOneBtn()
self:check_useItem(1,1,1)
end

function UIXianYuanXunFang2Win:onTenBtn()
self:check_useItem(10,2,1)
end

function UIXianYuanXunFang2Win:check_useItem(usecnt,typo,typo2)
if self.clickLockTime then
if gameUtilityModel.getServerShortTime()<self.clickLockTime then
return
end
self.clickLockTime=nil
end
if not xianyuanxunfangModel:checkChouKaWithAct(true)then
return
end

if self.myData.itemid<=0 then
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
local itemID_=defaultdz[1]
for idx,v in ipairs(disciple)do
if itemID_==itemID then
table.insert(selectList,idx)
break
end
end
xianyuanxunfangController:reqSelectDZ(selectList)

_this.markUseData={usecnt,typo,typo2}
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()

AudioManager.playOpenUI()
return
elseif self.hasEquip and self.myData.equip_idx<=0 then
local equip_idx_=1
local piece=self.mycfg.lottery_equip[1][equip_idx_][1]
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

xianyuanxunfangController:reqSelectEquip(equip_idx_)

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

function UIXianYuanXunFang2Win:useItem(usecnt,typo,typo2)
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




function UIXianYuanXunFang2Win:testAnim(typo)
typo=typo or 1
if typo>1 then
self.rewardlist=test_ten_reward
else
self.rewardlist=test_one_reward
end
local func=function()
if _this==nil then return end
local func2=function()
if _this==nil then return end
_this:resetResultAnim()
end

func2()
end
self:playResultAnim(typo or 1,func)
end


function UIXianYuanXunFang2Win:playResultAnim(typo,func)
self:resetResultAnim()
self.playingAnim=true

self.root:setChildCanvasGroupRaycast(false)
self.modelRoot:setChildCanvasGroupAlpha(0)
self.uiRoot:setChildCanvasGroupAlpha(0)

self.bgImg:setChildDOScale(2,0.8,nil)
self.cloudImg:setChildDOScale(1.2,0.8,nil)
local func2=function()
self:playPosEffect(typo,func)
end
self:delayDo(0.1,func2)
end

function UIXianYuanXunFang2Win:playResultAnim2(typo,func)
self:playResultAnim(typo,func)
end

function UIXianYuanXunFang2Win:playPosEffect(typo,func)

self.groupWidget=self.posGroup:getWidgetBase()




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


table.insert(showEffectList,{effectID,color})
if c>=10 then
break
end
end
end
local boomColor
if c>1 then
table.sort(showEffectList,function(a,b)
return a[2]>b[2]
end)
end
boomColor=showEffectList[1][2]


if typo==1 then

AudioManager.playAudio(505)
elseif typo==2 then

AudioManager.playAudio(506)
end

if c>0 then
local delay=0
for i,v in ipairs(showEffectList)do
local effectID=v[1]
local pos=posLookup[i]
local color=v[2]
local idx=i-1
if i>1 then
delay=delay+0
end
local func3=function()
local widget=self.groupWidget
widget:SetChildShowEffect(idx,effectID,true)
local y=math.random(pos[2],pos[3])
widget:SetChildAnchoredPos(idx,pos[1],y)




end
if delay>0 then
self:delayDo(delay,func3)
else
func3()
end
end

delay=delay+1
local func4=function()
local effectID=posEffectLookup[boomColor][2]
self.boomEffect:setChildShowEffect(effectID,true)
end
self:delayDo(delay,func4)
delay=delay+1.5
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

function UIXianYuanXunFang2Win:resetResultAnim()
if self.delayResetTime then
self:stopTimerByID(self.delayResetTime)
self.delayResetTime=nil
end
if self.groupWidget then
self.bottomRoot:setLocalPosY(0)
self.topRoot:setLocalPosY(0)
self.rightRoot:setLocalPosX(0)

self.singleRoleItem:setScale(Vector3(1,1,1))

self.playingAnim=nil
self.root:setChildCanvasGroupRaycast(true)
self.modelRoot:setChildCanvasGroupAlpha(1)
self.uiRoot:setChildCanvasGroupAlpha(1)
self.bgImg:setScale(Vector3(1,1,1))
self.cloudImg:setScale(Vector3(1,1,1))

self.boomEffect:setChildShowEffect(0,false)
local widget=self.groupWidget
for i=1,10 do
widget:SetChildShowEffect(i-1,0,false)
end
self.groupWidget=nil
end
end





function UIXianYuanXunFang2Win:initMessage()
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

function UIXianYuanXunFang2Win:updateMessage()
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

function UIXianYuanXunFang2Win:addMessage()
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

function UIXianYuanXunFang2Win:removeMessage(idx)
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



function UIXianYuanXunFang2Win:onBtnClose()

AudioManager.playBtnClick()
if self.isFull then
UIFullCommonControl:closeUI(nil,true)
else
self:closeSelf()
end
end



function UIXianYuanXunFang2Win:rec_selectDZ()
self:closeWindow('UIXianYuanXunFangSelect2Win')

self:refreshModelLove()
self:refreshLoveDZObj()
if self.markUseData~=nil then
local usecnt=self.markUseData[1]
local typo=self.markUseData[2]
local typo2=self.markUseData[3]
self:check_useItem(usecnt,typo,typo2)
self.markUseData=nil
end
end

function UIXianYuanXunFang2Win:rec_selectEquip()
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

function UIXianYuanXunFang2Win:rec_chouka()
self:refreshCostBtn()
self:refreshDesc()
end

function UIXianYuanXunFang2Win:show_chouka_reward()
if not self.skipFlag then
self:closeWindow('UIXianYuanXunFangRewardWin')
end
local args={}
args.rewardlist=table.deepCopy(self.rewardlist)
args.showType=self.mark_showType
args.parentWin='UIXianYuanXunFang2Win'
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

function UIXianYuanXunFang2Win:stopBgAudioSound()
if self.bgAudioHandleId then
local fadeTime=1
AudioManager.fadeOutStopAudioById(self.bgAudioHandleId,fadeTime,false)
self.bgAudioHandleId=nil
end
end


