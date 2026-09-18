







def_class("UISubAct_xianshichoukaWin_Role",UIWindowBase)









function UISubAct_xianshichoukaWin_Role:bindComponents()

self.bgImg=UIImage.get(self,0)
self.root=UIObject.get(self,1)
self.posCollection=UIObject.get(self,2)
self.cloudImg=UIImage.get(self,3)
self.rightRoot=UIObject.get(self,4)
self.bottomRoot=UIObject.get(self,5)
self.topRoot=UIObject.get(self,6)
self.rewardScrollView=UIObject.get(self,7)
self.descIcon=UIImage.get(self,8)
self.messageFrame=UIObject.get(self,9)
self.skipBtn=UIButton.get(self,10)
self.money2Root=UIObject.get(self,11)
self.money1Root=UIObject.get(self,12)
self.timeTxt=UIText.get(self,13)
self.descTxt=UIText.get(self,14)
self.rewadProgress=UIObject.get(self,15)
self.rewardProgressBar=UIObject.get(self,16)
self.rewardGrid=UIObject.get(self,17)
self.oneCostReddot=UIObject.get(self,18)
self.oneFreeDesc=UIText.get(self,19)
self.oneCostDesc=UIText.get(self,20)
self.oneCostIcon=UIImage.get(self,21)
self.modelListPanel=UIObject.get(self,22)
self.skipSelectImg=UIObject.get(self,23)
self.rewardNumTxt=UIText.get(self,24)
self.tenCostIcon=UIImage.get(self,25)
self.tenCostDesc=UIText.get(self,26)
self.tenCostReddot=UIObject.get(self,27)
self.rewardContent=UIObject.get(self,28)
self.messageMask=UIObject.get(self,29)
self.message2Txt=UIText.get(self,30)
self.messageTxt=UIText.get(self,31)
self.baoXiangReddot=UIImage.get(self,32)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)



end


function UISubAct_xianshichoukaWin_Role:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.posCollection);self.posCollection=nil;
_UIObject_release(self.cloudImg);self.cloudImg=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.bottomRoot);self.bottomRoot=nil;
_UIObject_release(self.topRoot);self.topRoot=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.descIcon);self.descIcon=nil;
_UIObject_release(self.messageFrame);self.messageFrame=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.money2Root);self.money2Root=nil;
_UIObject_release(self.money1Root);self.money1Root=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.oneCostReddot);self.oneCostReddot=nil;
_UIObject_release(self.oneFreeDesc);self.oneFreeDesc=nil;
_UIObject_release(self.oneCostDesc);self.oneCostDesc=nil;
_UIObject_release(self.oneCostIcon);self.oneCostIcon=nil;
_UIObject_release(self.modelListPanel);self.modelListPanel=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.rewardNumTxt);self.rewardNumTxt=nil;
_UIObject_release(self.tenCostIcon);self.tenCostIcon=nil;
_UIObject_release(self.tenCostDesc);self.tenCostDesc=nil;
_UIObject_release(self.tenCostReddot);self.tenCostReddot=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.messageMask);self.messageMask=nil;
_UIObject_release(self.message2Txt);self.message2Txt=nil;
_UIObject_release(self.messageTxt);self.messageTxt=nil;
_UIObject_release(self.baoXiangReddot);self.baoXiangReddot=nil;
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


function UISubAct_xianshichoukaWin_Role:onLoaded(...)
_this=self
self:bindComponents()

local posCollectionGrid=self.posCollection:getChildCommonLayoutGroupWidgetList()
local cnt=posCollectionGrid.Count
self.posGroupsCnt=cnt

self:addNotify(notifyConfig.onShowPrize,self.onShowPrize)
self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UISubAct_xianshichoukaWin_Role:__delete()
self:stopBgAudioSound()
_this=nil
self:unbindComponents()
for k,v in pairs(self.fmTweener)do
v:Kill()
end
self:recordAllNotFullOpenItem(true)
end


function UISubAct_xianshichoukaWin_Role:onHide()
self:stopBgAudioSound()
end

function UISubAct_xianshichoukaWin_Role.onShowPrize(prizeType,temp,effectData)
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

function UISubAct_xianshichoukaWin_Role.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
if itemid==_this.costItemID then
_this:refreshCostBtn()
end
if _this.moneyLookup then
local money=_this.moneyLookup[itemid]
if money then
_this:refreshMoneyItem(money,oldcount)
end
end
end

function UISubAct_xianshichoukaWin_Role.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
if _this.moneyLookup then
local money=_this.moneyLookup[moneyType]
if money then
_this:refreshMoneyItem(money,lastVal)
end
end
end



function UISubAct_xianshichoukaWin_Role:initMoneyData(datas)
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

function UISubAct_xianshichoukaWin_Role:initMoneyItem(money)
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

function UISubAct_xianshichoukaWin_Role:refreshMoneyItem(money,lastVal)
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

function UISubAct_xianshichoukaWin_Role:onAddClick(moneyType)
gainControl:showCommonGainWin_item(moneyType)
end

function UISubAct_xianshichoukaWin_Role:clickMoney(moneyType)
if moneyType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(moneyType)
end
end

function UISubAct_xianshichoukaWin_Role:clearFMTweener(mtype)
if self.fmTweener[mtype]then
self.fmTweener[mtype]:Kill()
self.fmTweener[mtype]=nil
end
end



function UISubAct_xianshichoukaWin_Role:refreshOnShow(actID,subType,subid)
self:refreshUpdate()
end




function UISubAct_xianshichoukaWin_Role:onShow(argtable,afterOnloaded)
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

self:refreshUpdate()
end


function UISubAct_xianshichoukaWin_Role:refreshUpdate()
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
if self.myData.period_idx==0 then

self:showWindow('UIXianShiChoukaSelectWin',{actID=self.actID,sub_act_type=self.subType,sub_act_id=self.subid})
return
end
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
self.costItemID=self.sub_actcfg.itemid

self:initMoneyData({{self.costItemID}})





self:initModel()
self:refrshModel()
self:refreshCostBtn()
self:refreshDesc()
self:refreshSkipBtn()

self:recordAllNotFullOpenItem()

if self.actTimer==nil then
local func=function()
self:refreshActTimer()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end


self.root:setChildCanvasGroupAlpha(0)
local func=function()
if _this==nil then return end
_this:delayDo(0.35,function()
_this:initRewardPanel(false,true)
_this.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)





local dzpos=self.sub_actcfg.dzpos[self.myData.period_idx]
local widget=self.modelListPanel:getChildWidgetBase()
local item1=widget:GetChildWidgetBase(0)
local item2=widget:GetChildWidgetBase(1)
local item3=widget:GetChildWidgetBase(2)
item1:SetChildDOLocalMoveX(0,dzpos[1][1],1)
item2:SetChildDOLocalMoveY(0,dzpos[2][2],1)
item3:SetChildDOLocalMoveX(0,dzpos[3][1],1)
item1:SetChildCanvasGroupDOFade(0,1,1.5)
item2:SetChildCanvasGroupDOFade(0,1,1.5)
item3:SetChildCanvasGroupDOFade(0,1,1.5)
end
if webGLHelper:isRunWebGL()then
local abName=webGLHelper:getReplaceResourceAB('xianYuanXunFangBG')
self.bgImg:setSprite(abName[1],abName[2])
func()
else
self.bgImg:setChildUIModelShowTarget(4017,1,{},0,false,false,0,func)
end
self:refreshDailyReward()
end


function UISubAct_xianshichoukaWin_Role:recordAllNotFullOpenItem(isclear)
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
local disciple=self.sub_actcfg.disciple
local disciple_period=disciple[self.myData.period_idx][2]
for i,v in ipairs(disciple_period)do
local itemId=v[1]
table.insert(notFullOpenItemMark,itemId)
UIRecruitControl:recordNotFullOpenItem(itemId,true)
end
end
end

function UISubAct_xianshichoukaWin_Role:refreshDesc()
local icon
local maxRoundNum=self.sub_actcfg.round
if self.myData.round==self.sub_actcfg.upround then
icon='image_xunxianch_1'
else
icon='image_xunxianch_2'
end
local lerp=maxRoundNum-self.myData.times
self.descIcon:setSprite(globalABLookup.xianyuanxunfang,icon)
self.descTxt:setText(lerp)
end

function UISubAct_xianshichoukaWin_Role:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(time))
self.timeTxt:setText(time_str)
end

function UISubAct_xianshichoukaWin_Role:initModel()
local disciple=self.sub_actcfg.disciple
local dzpos=self.sub_actcfg.dzpos[self.myData.period_idx]
local num=#disciple[self.myData.period_idx][2]
local widget=self.modelListPanel:getChildWidgetBase()
local list={}
local modelPos={}
local movePos={{-50,0},{0,-50},{50,0}}
for i=1,num do
local pos=dzpos[i]
local move=movePos[i]
local item=widget:GetChildWidgetBase(i-1)
item:SetChildLocalPos(0,pos[1]+move[1],pos[2]+move[2],0)
item:SetChildLocalPos(2,pos[3],pos[4],0)
item:SetChildCanvasGroupAlpha(0,0)

local floor=pos[6]or i
table.insert(list,{item,floor})

local cav=self:getChildCanvas(-1)
item:SetChildCanvas(2,cav[1],cav[2]+1)

item:SetChildLocalPos(7,pos[8],pos[9],0)
modelPos[i]=item:GetChildLocalPosition(-1)
end
self.modelPos=modelPos
table.sort(list,function(a,b)
return a[2]>b[2]
end)
for i,v in ipairs(list)do
local item=v[1]
item:SetAsFirstSibling(-1)
end
end

function UISubAct_xianshichoukaWin_Role:refrshModel()
local data=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local selectIndex=data.itemid
local disciple=self.sub_actcfg.disciple
local disciple_period=disciple[self.myData.period_idx][2]
local dzpos=self.sub_actcfg.dzpos[self.myData.period_idx]
local num=#disciple_period
local widget=self.modelListPanel:getChildWidgetBase()
for i=1,num do
local pos=dzpos[i]
local item=widget:GetChildWidgetBase(i-1)
local itemID=disciple_period[i][1]
local scale=pos[5]
local flipx
if pos[7]==1 then
flipx=true
else
flipx=false
end
self:refreshDZItem(item,itemID,1,scale or 1,flipx)

local islove=selectIndex==i
item:SetChildActive(7,islove)
if islove then
self:doLoveAnim(item)
end
end
end

function UISubAct_xianshichoukaWin_Role:refrshModelLove()
local data=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local selectIndex=data.itemid
local disciple=self.sub_actcfg.disciple
local disciple_period=disciple[self.myData.period_idx][2]
local num=#disciple_period
local widget=self.modelListPanel:getChildWidgetBase()
for i=1,num do
local item=widget:GetChildWidgetBase(i-1)
local islove=selectIndex==i

item:SetChildActive(7,islove)
if islove then
self:doLoveAnim(item)
end
end
end

function UISubAct_xianshichoukaWin_Role:doLoveAnim(item)
if self.loveTween then

self.loveTween:Kill()
self.loveTween=nil
end
if self.loveTweenTimer then
self:stopTimerByID(self.loveTweenTimer)
self.loveTweenTimer=nil
end
item:SetChildRotation(7,0,0,0)
local func=function()
if _this==nil then return end
_this.loveTween=nil

_this.loveTweenTimer=_this:delayDo(3,function()
if _this==nil then return end
_this.loveTweenTimer=nil
_this:doLoveAnim(item)
end)
end
local tweener=item:SetChildDOPunchRotation(7,Vector3(0,0,15),2,6,1,func)
self.loveTween=tweener
end

function UISubAct_xianshichoukaWin_Role:refreshDZItem(item,itemID,typo,scale,flipx)
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo


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
item:SetChildUIModelShowTarget(1,modelParams.body,scale,modelParams.componets,anim,true)
item:SetChildUIModelShowFlipX(1,flipx)

local jobicon=UIDiscipleModel:getJobIconName(info.job)
item:SetChildCSImageSprite(3,globalABLookup.global,jobicon)

item:SetChildText(5,dzData.disciplename)

local abname,icon=UIDiscipleModel:getJobOrientationIcon(info.job,dzData.id)
local showIcon=icon~=nil
item:SetChildActive(4,showIcon)
if showIcon then
item:SetChildCSImageSprite(4,abname,icon)
end

item:SetChildButtonClick(6,function()
self:onViewBtn(itemID)
end)
end

function UISubAct_xianshichoukaWin_Role:initRewardPanel(anim,isInit)
local speed=400
local stepWidth=100
local contentOffset={70,80}
self.rewardProgressBar:setChildAnchoredPosition(Vector2(contentOffset[1],-42))
self.rewardGrid:setChildAnchoredPosition(Vector2(contentOffset[1],19))

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


local posX=i*stepWidth
item:SetChildAnchoredPosition(-1,Vector2(posX,0))

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
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(i)
end)

item:SetChildText(1,num)

item:SetChildActive(2,fix and rewardFlag)

item:SetChildActive(6,fix and not rewardFlag)

item:SetChildActive(3,fix and rewardFlag)

item:SetChildActive(4,fix)



end
local content_width=max*stepWidth+contentOffset[1]+contentOffset[2]
self.rewardContent:setChildSizeDelta(content_width,220)


local max_width=max*stepWidth
self.rewardProgressBar:setChildSizeDelta(max_width,8)

local cur_width
if curIndex>=max then
cur_width=max_width
elseif curIndex<=0 then
cur_width=total/target[curIndex+1][1]*stepWidth
else
local rate=(total-target[curIndex][1])/(target[curIndex+1][1]-target[curIndex][1])
cur_width=(curIndex+rate)*stepWidth
end
if anim then
local old_width=self.rewardProgressBar:getChildSizeDeltaY()
local lerp=math.abs(cur_width-old_width)
self.rewadProgress:setChildDOSizeDelta(Vector2(cur_width,8),lerp/speed,nil)
else
self.rewadProgress:setChildSizeDelta(cur_width,8)
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

function UISubAct_xianshichoukaWin_Role:onClickItem(index)
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

function UISubAct_xianshichoukaWin_Role:onTipsBtn()

AudioManager.playBtnClick()
self:showWindow('UISubAct_xianshichouka_showRewardWin',{actID=self.actID,sub_act_type=self.subType,sub_act_id=self.subid})
end

function UISubAct_xianshichoukaWin_Role:onShopBtn()

AudioManager.playBtnClick()
local jumpParam=self.sub_actcfg.jumpParam
jumpManager:jump(jumpParam)

end


function UISubAct_xianshichoukaWin_Role:SwitchBtn()
self:showWindow('UIXianShiChoukaSelectWin',{actID=self.actID,sub_act_type=self.subType,sub_act_id=self.subid})
end

function UISubAct_xianshichoukaWin_Role:onViewBtn(itemid)
if self.playingAnim then return end
UIRecruitControl:showItemDiscipleInfoByItemId2(itemid)
end

function UISubAct_xianshichoukaWin_Role:onUpBtn()
self:showWindow('UISubAct_xianshichouka_selectUpWin_Role',{act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid})
end

function UISubAct_xianshichoukaWin_Role:refreshSkipBtn()
if self.skipFlag==nil then
local data=userActorArraySetting.getBase(ACTOR_SETTING_TYPE.eXianShiChouKa,{})
local flag=data['1']==true
self.skipFlag=flag
end
self.skipSelectImg:setActive(self.skipFlag)
end

function UISubAct_xianshichoukaWin_Role:onSkipBtn()
local typo=ACTOR_SETTING_TYPE.eXianShiChouKa
local data=userActorArraySetting.getBase(typo,{})
local flag=data['1']==true
flag=not flag
self.skipFlag=flag
data['1']=flag
userActorArraySetting.setBase(typo,data)
userActorArraySetting.flush(typo)
self:refreshSkipBtn()
end

function UISubAct_xianshichoukaWin_Role:getFastBuy()
local d=self.fastBuy[1]
return d[1],d[2]
end

function UISubAct_xianshichoukaWin_Role:refreshCostBtn()
local hasfree=activitiesHandle_xianshichouka_Role.checkHasFree(self.subType,self.subid,self.myData.free)
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

function UISubAct_xianshichoukaWin_Role:onOneBtn()
self:check_useItem(1,1,1)
end

function UISubAct_xianshichoukaWin_Role:onTenBtn()
self:check_useItem(10,2,1)
end

function UISubAct_xianshichoukaWin_Role:check_useItem(usecnt,typo,typo2)
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
local disciple_period=disciple[self.myData.period_idx][2]
local defaultdz=self.sub_actcfg.defaultdz
if defaultdz==0 then
defaultdz=1
end
local itemID=disciple_period[defaultdz][1]
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
local json_str=jsonHelper.encode({1,self.myData.period_idx,defaultdz})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)

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

function UISubAct_xianshichoukaWin_Role:useItem(usecnt,typo,typo2)
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












local hasfree=activitiesHandle_xianshichouka_Role.checkHasFree(subType,subid,self.myData.free)
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
UIManager:invokeUIMethod('UISubAct_xianshichouka_rewardWin','clearClickLock',true)
end
end




function UISubAct_xianshichoukaWin_Role:testAnim(typo)
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

function UISubAct_xianshichoukaWin_Role:playResultAnim(typo,func)
self:resetResultAnim()
UIManager:invokeUIMethod(self.parentWin,'activeRoot',false)
self.playingAnim=true


self.bottomRoot:setChildDOLocalMoveY(-30,0.35)
self.topRoot:setChildDOLocalMoveY(20,0.35)
self.rightRoot:setChildDOLocalMoveX(20,0.35)

local widget=self.modelListPanel:getChildWidgetBase()
local item1=widget:GetChildWidgetBase(0)
local item2=widget:GetChildWidgetBase(1)
local item3=widget:GetChildWidgetBase(2)
item1:SetChildDOLocalMoveX(-1,self.modelPos[1].x-50,0.4)
item2:SetChildDOScale(-1,0.9,0.25)
item3:SetChildDOLocalMoveX(-1,self.modelPos[3].x+50,0.4)

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

function UISubAct_xianshichoukaWin_Role:playResultAnim2(typo,func)
self:resetResultAnim()
UIManager:invokeUIMethod(self.parentWin,'activeRoot',false)
self.playingAnim=true

self.root:setChildCanvasGroupRaycast(false)
self.root:setChildCanvasGroupAlpha(0)
self.cloudImg:setChildCanvasGroupAlpha(0)

self.bgImg:setChildDOScale(2,0.8,function()
if _this==nil then return end
_this:playPosEffect(typo,func)
end)
end

function UISubAct_xianshichoukaWin_Role:playPosEffect(typo,func)

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

function UISubAct_xianshichoukaWin_Role:resetResultAnim()
if self.delayResetTime then
self:stopTimerByID(self.delayResetTime)
self.delayResetTime=nil
end
if self.groupsWidget then
self.bottomRoot:setLocalPosY(0)
self.topRoot:setLocalPosY(0)
self.rightRoot:setLocalPosX(0)

local widget=self.modelListPanel:getChildWidgetBase()
local item1=widget:GetChildWidgetBase(0)
local item2=widget:GetChildWidgetBase(1)
local item3=widget:GetChildWidgetBase(2)
item1:SetChildLocalPosX(-1,self.modelPos[1].x)
item2:SetChildScale(-1,Vector3(1,1,1))
item3:SetChildLocalPosX(-1,self.modelPos[3].x)

UIManager:invokeUIMethod(self.parentWin,'activeRoot',true)
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





function UISubAct_xianshichoukaWin_Role:onBtnClose()
UIManager:invokeUIMethod(self.parentWin,'onBtnClose')
end



function UISubAct_xianshichoukaWin_Role:rec_selectUp(actID,subType,subid)
if self.actID==actID and self.subType==subType and self.subid==subid then


self:closeWindow('UISubAct_xianshichouka_selectUpWin_Role')
self:closeWindow('UIXianShiChoukaSelectWin')

if self.markUseData~=nil then
local usecnt=self.markUseData[1]
local typo=self.markUseData[2]
local typo2=self.markUseData[3]
self:useItem(usecnt,typo,typo2)
self.markUseData=nil
end
end
end

function UISubAct_xianshichoukaWin_Role:rec_chouka(actID,subType,subid)
if self.actID==actID and self.subType==subType and self.subid==subid then
self:initRewardPanel(true)
end
end

function UISubAct_xianshichoukaWin_Role:show_chouka_reward()
if not self.skipFlag then
self:closeWindow('UISubAct_xianshichouka_rewardWin')
end
local args={act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subid}
args.rewardlist=table.deepCopy(self.rewardlist)
args.showType=self.mark_showType
args.parentWin='UISubAct_xianshichoukaWin_Role'
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

function UISubAct_xianshichoukaWin_Role:rec_tagReward(actID,subType,subid)
if self.actID==actID and self.subType==subType and self.subid==subid then
self:initRewardPanel()

end
end

function UISubAct_xianshichoukaWin_Role:stopBgAudioSound()
if self.bgAudioHandleId then
local fadeTime=1
AudioManager.fadeOutStopAudioById(self.bgAudioHandleId,fadeTime,false)
self.bgAudioHandleId=nil
end
end



function UISubAct_xianshichoukaWin_Role:refreshDailyReward()
if not self.info then
return
end

local isGot=self.info:reqXianShiChouKa_checkDailyRewardsIsGot()

if isGot then
self.baoXiangReddot:setActive(true)
self:doPunchRotation(true)
else
self.baoXiangReddot:setActive(false)
self:doPunchRotation(false)
end
end


function UISubAct_xianshichoukaWin_Role:doPunchRotation(reddot)
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