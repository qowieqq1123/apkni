







def_class("UISubAct_xianshichouka2Win",UIWindowBase)









function UISubAct_xianshichouka2Win:bindComponents()

self.baoXiangReddot=UIImage.get(self,0)
self.bottomRoot=UIObject.get(self,1)
self.descIcon=UIImage.get(self,2)
self.descTxt=UIText.get(self,3)
self.equipBtn=UIButton.get(self,4)
self.equipItem=UIBaseItem.get(self,5)
self.leftRoot=UIObject.get(self,6)
self.loveModel=UIObject.get(self,7)
self.message2Txt=UIText.get(self,8)
self.messageFrame=UIObject.get(self,9)
self.messageMask=UIObject.get(self,10)
self.messageTxt=UIText.get(self,11)
self.money1Root=UIObject.get(self,12)
self.money2Root=UIObject.get(self,13)
self.oneCostDesc=UIText.get(self,14)
self.oneCostIcon=UIImage.get(self,15)
self.oneCostReddot=UIObject.get(self,16)
self.oneFreeDesc=UIText.get(self,17)
self.rewadProgress=UIObject.get(self,18)
self.rewardContent=UIObject.get(self,19)
self.rewardGrid=UIObject.get(self,20)
self.rewardNumTxt=UIText.get(self,21)
self.rewardProgressBar=UIObject.get(self,22)
self.rewardScrollView=UIObject.get(self,23)
self.rightRoot=UIObject.get(self,24)
self.root=UIObject.get(self,25)
self.skipBtn=UIButton.get(self,26)
self.skipSelectImg=UIObject.get(self,27)
self.tenCostDesc=UIText.get(self,28)
self.tenCostIcon=UIImage.get(self,29)
self.tenCostReddot=UIObject.get(self,30)
self.timeTxt=UIText.get(self,31)
self.topRoot=UIObject.get(self,32)
self.isShowReddotBtn=UIButton.get(self,33)

self.equipBtn:setButtonClick(function()self:onEquipBtn()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)



end


function UISubAct_xianshichouka2Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
_UIObject_release(self.bottomRoot);self.bottomRoot=nil;
_UIObject_release(self.descIcon);self.descIcon=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.equipBtn);self.equipBtn=nil;
_UIObject_release(self.equipItem);self.equipItem=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.loveModel);self.loveModel=nil;
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
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.rewardNumTxt);self.rewardNumTxt=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.tenCostDesc);self.tenCostDesc=nil;
_UIObject_release(self.tenCostIcon);self.tenCostIcon=nil;
_UIObject_release(self.tenCostReddot);self.tenCostReddot=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.topRoot);self.topRoot=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
end
















local _this

local colorEffectConfig={

[eQualityColor.ePurple]={2084,10249,6},
[eQualityColor.eOrange]={2085,10250,5.7},
[eQualityColor.eRed]={2086,10251,6},
}

local speed=400
local stepWidth=130
local stepWidthFisrt=50

function UISubAct_xianshichouka2Win:getColorEffectID()
self.maxRewardColor=self.maxRewardColor or eQualityColor.ePurple
if colorEffectConfig[self.maxRewardColor]then
return colorEffectConfig[self.maxRewardColor]
end
return colorEffectConfig[eQualityColor.eRed]
end


function UISubAct_xianshichouka2Win:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.onShowPrize,self.onShowPrize)
self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
end


function UISubAct_xianshichouka2Win:__delete()
self:stopBgAudioSound()
_this=nil
self:unbindComponents()
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self:recordAllNotFullOpenItem(true)
local subActInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
if subActInfo then
subActInfo:clearNoteSelect()
end
end


function UISubAct_xianshichouka2Win:onHide()
self:stopBgAudioSound()
end

function UISubAct_xianshichouka2Win.onShowPrize(prizeType,temp,effectData)
if _this==nil then return end
if prizeType==ePrizeType.eActivityXianShiChouKa2 then
_this.rewardlist=table.deepCopy(temp)
_this.maxRewardColor=eQualityColor.ePurple
for i,v in ipairs(_this.rewardlist)do
local itemConfig=itemsConfig.getConfig(v.itemid)
if itemConfig.color>_this.maxRewardColor then
_this.maxRewardColor=itemConfig.color
end
end

_this:refreshCostBtn()
_this:show_chouka_reward()
end
end

function UISubAct_xianshichouka2Win.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
if itemid==_this.costItemID then
_this:refreshCostBtn()
end
local money=_this.moneyLookup[itemid]
if money then
_this:refreshMoneyItem(money,oldcount)
end
end

function UISubAct_xianshichouka2Win.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
local money=_this.moneyLookup[moneyType]
if money then
_this:refreshMoneyItem(money,lastVal)
end
end



function UISubAct_xianshichouka2Win:initMoneyData(datas)
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

function UISubAct_xianshichouka2Win:initMoneyItem(money)
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

function UISubAct_xianshichouka2Win:refreshMoneyItem(money,lastVal)
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

function UISubAct_xianshichouka2Win:onAddClick(moneyType)
gainControl:showCommonGainWin_item(moneyType)
end

function UISubAct_xianshichouka2Win:clickMoney(moneyType)
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end

function UISubAct_xianshichouka2Win:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end






function UISubAct_xianshichouka2Win:onShow(argtable,afterOnloaded)
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
self.hasEquip=self.sub_actcfg.lottery_equip~=nil
self.lottery_equip=nil
self:initMoneyData({{self.costItemID},{self.sub_actcfg.money[1]}})

self:initRewardPanel(false,true)
self:refrshLoveModel()
self:refreshEquipLove()
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
if afterOnloaded then
self:delayDo(0.5,function()
self:initMessage()
end)
end

self:showWindow('UISubAct_xianshichouka2_result_Win')





self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self:refreshDailyReward()
self:refreshIsShowReddotBtn()
end

function UISubAct_xianshichouka2Win:recordAllNotFullOpenItem(isclear)
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

function UISubAct_xianshichouka2Win:refreshDesc()
local icon
local maxRoundNum=self.sub_actcfg.round
if self.myData.round==self.sub_actcfg.upround then
icon='image_wenzi_01'
else
icon='image_wenzi_02'
end
local lerp=maxRoundNum-self.myData.times
self.descIcon:setSprite(globalABLookup.xianshichouka2,icon)
self.descTxt:setText(lerp)
end

function UISubAct_xianshichouka2Win:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(time))
self.timeTxt:setText(time_str)
end

function UISubAct_xianshichouka2Win:refrshLoveModel()
local data=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local selectIndex=data.itemid
if selectIndex==0 then
selectIndex=1
end
local disciple=self.sub_actcfg.disciple
local dzpos=self.sub_actcfg.dzpos
local itemID=disciple[selectIndex][1]
local pos=dzpos[selectIndex]

local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo


local modelParams
local anim=eAnimationID.stand
local scale=pos[3]
local flipx
if pos[4]==1 then
flipx=true
else
flipx=false
end

modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info)

self.loveModel:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,anim,false)
self.loveModel:setChildUIModelShowFlipX(flipx)
self.loveModel:setLocalPos(pos[1],pos[2],0)
end

function UISubAct_xianshichouka2Win:refreshEquipLove()
self.equipBtn:setActive(self.hasEquip)
if self.hasEquip then
local haveEquip=self.myData.equip_idx>0
self.equipItem:setActive(haveEquip)
if haveEquip then
local piece=self.sub_actcfg.lottery_equip[1][self.myData.equip_idx][1]
local itemId=vocEquipModel:getPieceToItem(piece)
local conf={itemid=itemId,itemcount="",showCountBG=false,showname=true,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.equipItem:setChildPropData(prop)
end
end
end

function UISubAct_xianshichouka2Win:onEquipBtn()
if self.lottery_equip==nil then
self.lottery_equip=xianyuanxunfangController:convertLoveEquip(self.sub_actcfg.lottery_equip[1])
end
local args={}
args.configs=self.lottery_equip
args.current=self.myData.equip_idx
args.callback=function(idx)
if _this==nil then return end
local json_str=jsonHelper.encode({4,idx})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end
self:showWindow('UICommonVocEquipListSelectWin',args)
end

function UISubAct_xianshichouka2Win:getProgressNum(v)
if v>1 then
return stepWidthFisrt+(v-1)*stepWidth
else
return v*stepWidthFisrt
end
end

function UISubAct_xianshichouka2Win:initRewardPanel(anim,isInit)
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

self.rewardGrid:setChildLayoutGroupCreateItems(max)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for i=1,max do
local item=grids[i-1]
local d=target[i]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=mathHelper.getBitValue(flag,i-1)


local posY=self:getProgressNum(i)
item:SetChildAnchoredPosition(-1,Vector2(0,posY))

local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local isGray=fix and rewardFlag
local graynum=0
if isGray then
graynum=mathHelper.setbit(graynum,eGrayType.eGray-1)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(i)
end)

local showTick=fix and rewardFlag
local showNum=not showTick
item:SetChildActive(2,fix and rewardFlag)

item:SetChildActive(5,showNum)
if showNum then
item:SetChildText(1,num)
local numIcon
if fix then
numIcon='image_dikuang_04'
else
numIcon='image_dikuang_02'
end
item:SetChildCSImageSprite(5,globalABLookup.xianshichouka2,numIcon)
end

item:SetChildActive(6,fix and not rewardFlag)

item:SetChildActive(3,fix and rewardFlag)

item:SetChildActive(4,showTick)
end


local max_width=self:getProgressNum(max)
self.rewardProgressBar:setChildSizeDelta(max_width,8)
self.rewardContent:setChildSizeDelta(370,max_width+110)

local cur_width
if curIndex>=max then
cur_width=max_width
elseif curIndex<=0 then
cur_width=self:getProgressNum(total/target[curIndex+1][1])
else
local rate=(total-target[curIndex][1])/(target[curIndex+1][1]-target[curIndex][1])
cur_width=self:getProgressNum(curIndex+rate)
end
if anim then
local old_width=self.rewardProgressBar:getChildSizeDeltaY()
local lerp=math.abs(cur_width-old_width)
self.rewadProgress:setChildDOSizeDelta(Vector2(cur_width,8),lerp/speed,nil)
else
self.rewadProgress:setChildSizeDelta(cur_width,8)
end

self.rewardNumTxt:setText(FMT.fmt('次数：{0}',total))

if isInit then
local showWidth=self.rewardScrollView:getChildRectWidth()
local moveX=0
local halfWidth=showWidth/2
if cur_width>halfWidth then
moveX=cur_width-halfWidth
end
if moveX>0 then
self.rewardContent:setChildAnchoredPos(0,-moveX)
end
end
end

function UISubAct_xianshichouka2Win:onClickItem(index)
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

function UISubAct_xianshichouka2Win:onTipsBtn()

AudioManager.playBtnClick()
self:showWindow('UISubAct_xianshichouka_showRewardWin',{actID=self.actID,sub_act_type=self.subType,sub_act_id=self.subid})
end

function UISubAct_xianshichouka2Win:onShopBtn()

AudioManager.playBtnClick()
local jumpParam=self.sub_actcfg.jumpParam
jumpManager:jump(jumpParam)

end

function UISubAct_xianshichouka2Win:onUpBtn()
local sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
local disciple=sub_actcfg.disciple
local num=#disciple
if num<=3 then
self:showWindow('UISubAct_xianshichouka_selectUpWin',{act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid})
else
self:showWindow('UISubAct_xianshichouka_selectUpWin_many',{act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid})
end
end

function UISubAct_xianshichouka2Win:refreshSkipBtn()
if self.skipFlag==nil then
local data=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXianShiChouKa,{})
local flag=data['2']==true
self.skipFlag=flag
end
self.skipSelectImg:setActive(self.skipFlag)
end

function UISubAct_xianshichouka2Win:onSkipBtn()
local typo=ACTOR_SETTING_TYPE.eXianShiChouKa
local data=userActorArraySetting.getBase(typo,{})
local flag=data['2']==true
flag=not flag
self.skipFlag=flag
data['2']=flag
userActorArraySetting.setBase(typo,data)
userActorArraySetting.flush(typo)
self:refreshSkipBtn()
end

function UISubAct_xianshichouka2Win:getFastBuy()
local d=self.fastBuy[1]
return d[1],d[2]
end

function UISubAct_xianshichouka2Win:refreshCostBtn()
local hasfree=activitiesHandle_xianshichouka2.checkHasFree(self.subType,self.subid,self.myData.free)
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
self.oneCostDesc:setActive(true)
self.oneFreeDesc:setActive(false)
local iconName=iconHelper.getIconName(itemid)
self.oneCostIcon:setImageIcon(iconName)
str=tostring(needCnt)
if not fix then
str=toColorString(FONT_COLOR.eRedColor,str)
end
self.oneCostDesc:setText(str)
else
self.oneCostIcon:setActive(false)
self.oneCostDesc:setActive(false)
self.oneFreeDesc:setActive(true)
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

function UISubAct_xianshichouka2Win:onOneBtn()
self:check_useItem(1,1,1)
end

function UISubAct_xianshichouka2Win:onTenBtn()
self:check_useItem(10,2,1)
end

function UISubAct_xianshichouka2Win:check_useItem(usecnt,typo,typo2)
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
local disciple=self.sub_actcfg.disciple
local defaultdz=self.sub_actcfg.defaultdz
if defaultdz==0 then
defaultdz=1
end
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

local json_str=jsonHelper.encode({4,equip_idx_})
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

function UISubAct_xianshichouka2Win:useItem(usecnt,typo,typo2)
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
UIManager:invokeUIMethod('UISubAct_xianshichouka_rewardWin','clearClickLock')
end
local closeback=function()
if _this==nil then return end
UIManager:invokeUIMethod('UISubAct_xianshichouka_rewardWin','clearClickLock',true)
end












local hasfree=activitiesHandle_xianshichouka2.checkHasFree(subType,subid,self.myData.free)
if typo==1 and hasfree then
callback()
return
end

if not gainControl:showGainWin(itemid,usecnt)then

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianYuanXunFnagCostChouKa2)
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
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eXianYuanXunFnagCostChouKa2,flag)

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
UIManager:invokeUIMethod('UISubAct_xianshichouka_rewardWin','clearClickLock',true)
end
end




function UISubAct_xianshichouka2Win:testAnim(typo)
local func=function()
if _this==nil then return end


_this:resetResultAnim()


end
self:playResultAnim(typo or 1,func)
end

function UISubAct_xianshichouka2Win:playResultAnim(typo,func)
self:resetResultAnim()
UIManager:invokeUIMethod(self.parentWin,'activeRoot',false)
self.playingAnim=true


self.bottomRoot:setChildDOLocalMoveY(-30,0.35)
self.topRoot:setChildDOLocalMoveY(20,0.35)
self.rightRoot:setChildDOLocalMoveX(20,0.35)
self.leftRoot:setChildDOLocalMoveX(-30,0.35)

self.root:setChildCanvasGroupRaycast(false)
self.root:setChildCanvasGroupDOFade(0,0.35)


local cfg=self:getColorEffectID()
UIManager:invokeUIMethod('UISubAct_xianshichouka2_result_Win','reloadEffect',cfg[2])

self:delayDo(0.25,function()
UIManager:invokeUIMethod('UISubAct_xianshichouka2_result_Win','playModel',cfg[1])
self:playPosEffect(typo,func)
end)
end

function UISubAct_xianshichouka2Win:playResultAnim2(typo,func)
self:resetResultAnim()
UIManager:invokeUIMethod(self.parentWin,'activeRoot',false)
self.playingAnim=true

self.root:setChildCanvasGroupRaycast(false)
self.root:setChildCanvasGroupAlpha(0)


local cfg=self:getColorEffectID()
UIManager:invokeUIMethod('UISubAct_xianshichouka2_result_Win','reloadEffect',cfg[2])

UIManager:invokeUIMethod('UISubAct_xianshichouka2_result_Win','playModel',cfg[1])
self:playPosEffect(typo,func)
end

function UISubAct_xianshichouka2Win:playPosEffect(typo,func)
local func2=function()
if func then
func()
end
end
local cfg=self:getColorEffectID()

self:delayDo(3.7,function()
UIManager:invokeUIMethod('UISubAct_xianshichouka2_result_Win','playEffect',cfg[2])
end)


self:delayDo(cfg[3],function()
func2()
end)
end

function UISubAct_xianshichouka2Win:resetResultAnim()
if self.delayResetTime then
self:stopTimerByID(self.delayResetTime)
self.delayResetTime=nil
end
if self.playingAnim then
self.bottomRoot:setLocalPosY(0)
self.topRoot:setLocalPosY(0)
self.rightRoot:setLocalPosX(0)
self.leftRoot:setLocalPosX(0)

UIManager:invokeUIMethod('UISubAct_xianshichouka2_result_Win','hideModel')
UIManager:invokeUIMethod(self.parentWin,'activeRoot',true)
self.playingAnim=nil
self.root:setChildCanvasGroupRaycast(true)
self.root:setChildCanvasGroupAlpha(1)
end
end





function UISubAct_xianshichouka2Win:initMessage()
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

function UISubAct_xianshichouka2Win:updateMessage()
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

function UISubAct_xianshichouka2Win:addMessage()
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

function UISubAct_xianshichouka2Win:removeMessage(idx)
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





function UISubAct_xianshichouka2Win:rec_selectUp(actID,subType,subid)
if self.actID==actID and self.subType==subType and self.subid==subid then
self:refrshLoveModel()

self:closeWindow('UISubAct_xianshichouka_selectUpWin')
if self.markUseData~=nil then
local usecnt=self.markUseData[1]
local typo=self.markUseData[2]
local typo2=self.markUseData[3]
self:check_useItem(usecnt,typo,typo2)
self.markUseData=nil
end
end
end

function UISubAct_xianshichouka2Win:rec_selectEquip(actID,subType,subid)
if self.actID==actID and self.subType==subType and self.subid==subid then
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
end

function UISubAct_xianshichouka2Win:rec_chouka(actID,subType,subid)
if self.actID==actID and self.subType==subType and self.subid==subid then
self:initRewardPanel(true)


end
end

function UISubAct_xianshichouka2Win:show_chouka_reward()
if not self.skipFlag then
self:closeWindow('UISubAct_xianshichouka_rewardWin')
end
local args={act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid}
args.rewardlist=table.deepCopy(self.rewardlist)
args.showType=self.mark_showType
args.parentWin='UISubAct_xianshichouka2Win'
args.openBack=function()
if _this==nil then return end
_this.clickLockTime=nil
end
local func=function()
self:showWindow('UISubAct_xianshichouka_rewardWin',args)
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
self:showWindow('UISubAct_xianshichouka_rewardWin',args)
self:refreshDesc()
end
self.mark_showType=nil
self.mark_showType2=nil
end

function UISubAct_xianshichouka2Win:rec_tagReward(actID,subType,subid)
if self.actID==actID and self.subType==subType and self.subid==subid then
self:initRewardPanel()

end
end

function UISubAct_xianshichouka2Win:stopBgAudioSound()
if self.bgAudioHandleId then
local fadeTime=1
AudioManager.fadeOutStopAudioById(self.bgAudioHandleId,fadeTime,false)
self.bgAudioHandleId=nil
end
end



function UISubAct_xianshichouka2Win:refreshDailyReward()
if not self.info then
return
end

local isGot=self.info:reqXianShiChouKa_checkDailyRewardsIsGot()

if isGot then
self.baoXiangReddot:setActive(false)
self:doPunchRotation(false)
else
self.baoXiangReddot:setActive(true)
self:doPunchRotation(true)
end
end


function UISubAct_xianshichouka2Win:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self.baoXiangReddot:setRotation(0,0,0)
local tweener=self.baoXiangReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.baoXiangReddot:setRotation(0,0,0)
end
end
end



function UISubAct_xianshichouka2Win:refreshIsShowReddotBtn()
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

function UISubAct_xianshichouka2Win:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UISubAct_xianshichouka2Win.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.actID==actId and _this.subType==subType and _this.subid==subId then
_this:refreshIsShowReddotBtn()
end
end
