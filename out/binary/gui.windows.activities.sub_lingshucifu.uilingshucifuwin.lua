







def_class("UILingShuCiFuWin",UIWindowBase)









function UILingShuCiFuWin:bindComponents()

self.bigRewardGroup=UIObject.get(self,0)
self.freeOnce=UIText.get(self,1)
self.guoshiModel_1=UIObject.get(self,2)
self.guoshiModel_10=UIObject.get(self,3)
self.guoshiModel_2=UIObject.get(self,4)
self.guoshiModel_3=UIObject.get(self,5)
self.guoshiModel_4=UIObject.get(self,6)
self.guoshiModel_5=UIObject.get(self,7)
self.guoshiModel_6=UIObject.get(self,8)
self.guoshiModel_7=UIObject.get(self,9)
self.guoshiModel_8=UIObject.get(self,10)
self.guoshiModel_9=UIObject.get(self,11)
self.guoshiPanel=UIObject.get(self,12)
self.isShowReddotBgImg=UIButton.get(self,13)
self.isShowReddotBtn=UIButton.get(self,14)
self.isShowReddotSelectImg=UIObject.get(self,15)
self.leftCatModel=UIObject.get(self,16)
self.levelPanel=UIObject.get(self,17)
self.levelText=UIText.get(self,18)
self.manyBtn=UIButton.get(self,19)
self.manyBtnReddot=UIObject.get(self,20)
self.manyBtnTx=UIText.get(self,21)
self.manyIcon=UIImage.get(self,22)
self.manyNum=UIText.get(self,23)
self.mbg=UIObject.get(self,24)
self.moneyBtn=UIButton.get(self,25)
self.moneyRoot=UIObject.get(self,26)
self.mtree=UIObject.get(self,27)
self.nextTx=UIText.get(self,28)
self.onceBtn=UIButton.get(self,29)
self.onceBtnReddot=UIObject.get(self,30)
self.onceBtnTx=UIText.get(self,31)
self.onceCost=UIObject.get(self,32)
self.onceIcon=UIImage.get(self,33)
self.onceNum=UIText.get(self,34)
self.openRoot=UIObject.get(self,35)
self.progressBar=UIProgress.get(self,36)
self.rewadProgress=UIObject.get(self,37)
self.rewardContent=UIObject.get(self,38)
self.rewardGrid=UIObject.get(self,39)
self.rewardNumTxt=UIText.get(self,40)
self.rewardPrevieBtn=UIButton.get(self,41)
self.rewardProgressBar=UIObject.get(self,42)
self.rewardScrollView=UIObject.get(self,43)
self.rightCatModel=UIObject.get(self,44)
self.rightPanel=UIObject.get(self,45)
self.root=UIObject.get(self,46)
self.skipBgImg=UIButton.get(self,47)
self.skipBtn=UIButton.get(self,48)
self.skipSelectImg=UIObject.get(self,49)
self.timeTx=UIText.get(self,50)
self.tipsBtn=UIButton.get(self,51)

self.isShowReddotBgImg:setButtonClick(function()self:onIsShowReddotBgImg()end)

self.isShowReddotBtn:setButtonClick(function()self:onIsShowReddotBtn()end)

self.manyBtn:setButtonClick(function()self:onManyBtn()end)

self.moneyBtn:setButtonClick(function()self:onMoneyBtn()end)

self.onceBtn:setButtonClick(function()self:onOnceBtn()end)

self.rewardPrevieBtn:setButtonClick(function()self:onRewardPrevieBtn()end)

self.skipBgImg:setButtonClick(function()self:onSkipBgImg()end)

self.skipBtn:setButtonClick(function()self:onSkipBtn()end)

self.tipsBtn:setButtonClick(function()self:onTipsBtn()end)
self.guoshiModel={
self.guoshiModel_1,
self.guoshiModel_2,
self.guoshiModel_3,
self.guoshiModel_4,
self.guoshiModel_5,
self.guoshiModel_6,
self.guoshiModel_7,
self.guoshiModel_8,
self.guoshiModel_9,
self.guoshiModel_10,
}



end


function UILingShuCiFuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bigRewardGroup);self.bigRewardGroup=nil;
_UIObject_release(self.freeOnce);self.freeOnce=nil;
_UIObject_release(self.guoshiModel_1);self.guoshiModel_1=nil;
_UIObject_release(self.guoshiModel_10);self.guoshiModel_10=nil;
_UIObject_release(self.guoshiModel_2);self.guoshiModel_2=nil;
_UIObject_release(self.guoshiModel_3);self.guoshiModel_3=nil;
_UIObject_release(self.guoshiModel_4);self.guoshiModel_4=nil;
_UIObject_release(self.guoshiModel_5);self.guoshiModel_5=nil;
_UIObject_release(self.guoshiModel_6);self.guoshiModel_6=nil;
_UIObject_release(self.guoshiModel_7);self.guoshiModel_7=nil;
_UIObject_release(self.guoshiModel_8);self.guoshiModel_8=nil;
_UIObject_release(self.guoshiModel_9);self.guoshiModel_9=nil;
_UIObject_release(self.guoshiPanel);self.guoshiPanel=nil;
_UIObject_release(self.isShowReddotBgImg);self.isShowReddotBgImg=nil;
_UIObject_release(self.isShowReddotBtn);self.isShowReddotBtn=nil;
_UIObject_release(self.isShowReddotSelectImg);self.isShowReddotSelectImg=nil;
_UIObject_release(self.leftCatModel);self.leftCatModel=nil;
_UIObject_release(self.levelPanel);self.levelPanel=nil;
_UIObject_release(self.levelText);self.levelText=nil;
_UIObject_release(self.manyBtn);self.manyBtn=nil;
_UIObject_release(self.manyBtnReddot);self.manyBtnReddot=nil;
_UIObject_release(self.manyBtnTx);self.manyBtnTx=nil;
_UIObject_release(self.manyIcon);self.manyIcon=nil;
_UIObject_release(self.manyNum);self.manyNum=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.moneyBtn);self.moneyBtn=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.mtree);self.mtree=nil;
_UIObject_release(self.nextTx);self.nextTx=nil;
_UIObject_release(self.onceBtn);self.onceBtn=nil;
_UIObject_release(self.onceBtnReddot);self.onceBtnReddot=nil;
_UIObject_release(self.onceBtnTx);self.onceBtnTx=nil;
_UIObject_release(self.onceCost);self.onceCost=nil;
_UIObject_release(self.onceIcon);self.onceIcon=nil;
_UIObject_release(self.onceNum);self.onceNum=nil;
_UIObject_release(self.openRoot);self.openRoot=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.rewadProgress);self.rewadProgress=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.rewardNumTxt);self.rewardNumTxt=nil;
_UIObject_release(self.rewardPrevieBtn);self.rewardPrevieBtn=nil;
_UIObject_release(self.rewardProgressBar);self.rewardProgressBar=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.rightCatModel);self.rightCatModel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skipBgImg);self.skipBgImg=nil;
_UIObject_release(self.skipBtn);self.skipBtn=nil;
_UIObject_release(self.skipSelectImg);self.skipSelectImg=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.tipsBtn);self.tipsBtn=nil;
self.guoshiModel=nil;
end
















local _this
local _format=string.format

local guoshiModelIdList={
6463,6464,6465,6466,6467,6468,6469,6470,6471,6472
}


local guoshiOneModelIdRandomList={
6464,6465,6466,6467,6468,6469,6470
}

local animType={
dianweiStand=1,
dianweiChai=2,
guoshiStand=3,
}

local animIdLookup={
[animType.dianweiStand]={
[0]=3621,
[4]=3620,
[5]=3619,
},
[animType.dianweiChai]={
[0]=3624,
[4]=3623,
[5]=3622,
},
[animType.guoshiStand]={
[0]=3627,
[4]=3626,
[5]=3625,
},
}




function UILingShuCiFuWin:onLoaded(...)
self:bindComponents()
_this=self
self.showCatBt={}

self.indexLookup={
[self.leftCatModel:getID()]=1,
[self.rightCatModel:getID()]=2,
}

self:addNotify(notifyConfig.onShowPrize,function(...)
self:onShowPrize(...)
end)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
self:addNotify(notifyConfig.on_item_list_changed,self.onItemListChanged)
self:addNotify(notifyConfig.onSubActivityOverBeforeEndTime24Hour,self.onSubActivityOverBeforeEndTime24Hour)
end


function UILingShuCiFuWin:__delete()
self:unbindComponents()

self:stopCDTick()
if self.showCatBt and self.showCatBt[1]then
behaviorManager:removeBehaviorTree(self.showCatBt[1])
end
if self.showCatBt and self.showCatBt[2]then
behaviorManager:removeBehaviorTree(self.showCatBt[2])
end
self.showCatBt={}
notifySystem:removelistener(notifyConfig.on_item_list_changed,self.on_item_list_changed)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)

_this=nil
end

function UILingShuCiFuWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end

if moneyType==_this.money then
_this:freshMoneyValue(lastVal)
_this:freshManyReddot()
end
end

function UILingShuCiFuWin:onItemListChanged(list)
if list==nil then return end
for i,v in pairs(list)do
local itemid=v.itemid
local lastCount=v.itemcount
if itemid==_this.money then
_this:freshMoneyValue(lastCount)
_this:freshManyReddot()
break
end
end
end




function UILingShuCiFuWin:onShow(argtable,afterOnloaded)
self:onShowArgRecv(argtable,afterOnloaded)
end

function UILingShuCiFuWin:onShowArgRecv(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.actID=argtable.act_id
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
self.isAnim=false


self.info=activitiesModel:getSubActInfo(self.actID,self.subType,self.subId)

local data=self.info:getData()
if not data then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.actID,self.subType,self.subId))
return
end
self.bigRewardModelLoadTimer={}

self.rightPanel:setActive(true)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)

self:refreshRewardPanel(self.actID,self.subType,self.subId,false,true)
self:refreshButton()

if afterOnloaded and deviceHelper.getAPILevel()>=18 then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
end
self.mbg:setChildUIModelShowTarget(6451,1,{},eAnimationID.stand)
self.mtree:setChildUIModelShowTarget(6452,1,{},eAnimationID.stand)

if not self.info.data then

else
self:initLevelPanel()
self:initCatModel()
self:refreshFree()
self:refreshPanel()
self:refreshBigReward(true)
self:initCatShow(true)
end
self:startCDTick()
self:refreshJumpAnimation()

self:refreshIsShowReddotBtn()
end


function UILingShuCiFuWin:onHide()
if self.showCatBt and self.showCatBt[1]then
behaviorManager:removeBehaviorTree(self.showCatBt[1])
end
if self.showCatBt and self.showCatBt[2]then
behaviorManager:removeBehaviorTree(self.showCatBt[2])
end
self.showCatBt={}

self.rightPanel:setActive(false)
end

function UILingShuCiFuWin:getCatSpeakText(stateId,modelIndex)
local speakLib
local index=self.indexLookup[modelIndex]
if stateId==0 then
speakLib=self.config.normalSpeakLib[index]
elseif stateId==1 then
speakLib=self.config.specialSpeakLib[index]
end

local count=#speakLib
local selectIndex
if count>1 then
selectIndex=math.random(1,count)
else
selectIndex=1
end

local catSpeakText=speakLib[selectIndex]
self.showCatBt[index]:setSharedVar("catSpeakText",catSpeakText)
end


function UILingShuCiFuWin:setTreeAnim()
local animTime=0.6
local pos1=self.leftCatModel:getChildLocalPosition()
local pos2=self.rightCatModel:getChildLocalPosition()
local time1=math.abs(pos1.x+105)/160-animTime
local time2=math.abs(pos2.x-190)/160-animTime
local minTime=math.min(time1,time2)
local delayTime=math.max(minTime,0)

local grids=self.bigRewardGroup:getChildCommonLayoutGroupWidgetList()
self:delayDo(delayTime,function()
for i=1,grids.Count do
local widget=grids[i-1]
local itemData=_this.bigRewardList[i]or{}
local ItemId=itemData[1]
if ItemId then
local itemConfig=itemsConfig.getConfig(ItemId)
local color=itemConfig.color
local animId=animIdLookup[animType.dianweiChai][color]or animIdLookup[animType.dianweiChai][0]
widget:SetChildSpineAnimation(0,animId,1,nil)
end
end
end)
delayTime=delayTime+animTime
self:delayDo(delayTime,function()
for i=1,grids.Count do
local widget=grids[i-1]
widget:SetChildActive(4,false)
widget:SetChildActive(2,false)
widget:SetChildActive(1,false)
end
end)







end


function UILingShuCiFuWin:setTreeAnim2(modelIndex)
local index=self.indexLookup[modelIndex]
if index==1 then
self.leftCatModel:setChildModelAnimationState(3618,1,nil)
else
self.rightCatModel:setChildModelAnimationState(3618,1,nil)
end
if not self.animTimer then
self.mtree:setChildModelAnimationState(3618,1,nil)

local delayTime=0.5
self:delayDo(delayTime,function()
if#_this.effectData.itemList>1 then
for i,v in ipairs(_this.guoshiModel)do
local rwData=_this.effectData.itemList[i]
if rwData then
local rwId=rwData.param_1
local itemConfig=itemsConfig.getConfig(rwId)
local color=itemConfig.color
local animId=animIdLookup[animType.guoshiStand][color]or animIdLookup[animType.guoshiStand][0]
v:setChildUIModelShowTarget(guoshiModelIdList[i],1,{},animId)
end
end
else
local modelId=guoshiOneModelIdRandomList[math.random(1,#guoshiOneModelIdRandomList)]
local rwData=_this.effectData.itemList[1]
local rwId=rwData.param_1
local itemConfig=itemsConfig.getConfig(rwId)
local color=itemConfig.color
local animId=animIdLookup[animType.guoshiStand][color]or animIdLookup[animType.guoshiStand][0]
_this.guoshiModel[1]:setChildUIModelShowTarget(modelId,1,{},animId)
end
end)

delayTime=delayTime+3

self.animTimer=self:delayDo(delayTime,function()
for i,v in ipairs(_this.guoshiModel)do
v:setChildUIModelRemoveTarget()
end
_this.leftCatModel:setChildModelAnimationState(eAnimationID.walk,1,nil)
_this.rightCatModel:setChildModelAnimationState(eAnimationID.walk,1,nil)
_this.mtree:setChildModelAnimationState(eAnimationID.stand,1,nil)
behaviorManager:resetBT(_this.showCatBt[1],behaviorConfig.stateIdKey,0)
behaviorManager:resetBT(_this.showCatBt[2],behaviorConfig.stateIdKey,0)
if _this.showPrizeFunc then
_this.showPrizeFunc()
end
_this.animTimer=nil
_this.isAnim=false
end)
end
end

function UILingShuCiFuWin:initLevelPanel()
local flag=self.config.level[2]~=nil
self.levelPanel:setActive(flag)
self.rewardPrevieBtn:setActive(not flag)
end

function UILingShuCiFuWin:initCatModel()

self.leftCatModelParams=self:getCatModelInfo(6454)
self.rightCatModelParams=self:getCatModelInfo(6453)
end

function UILingShuCiFuWin:getCatModelInfo(modelId)
local result={}
result.body=modelId
result.componets={}
local headOffset=cfgHelper.get2(cfg_dbbodyconfig_get,result.body,'headOffset')
if headOffset then
result.offset={headOffset[1],headOffset[2]}
end
result.scale=1
result.anim=0
return result
end


function UILingShuCiFuWin:refreshRewardPanel(actID,subType,subId,anim,isInit)
if self.actID~=actID or self.subType~=subType or self.subId~=subId then return end
self:refreshNext()

local data=self.info:getData()
local jdRewards=self.config.jdRewards
local total=data.cjNum
local recvIdx=data.jdrwIndex
local speed=400
local stepHeight=130
local contentOffset={50,0}
self.rewardProgressBar:setChildAnchoredPosition(Vector2(0,0))
self.rewardGrid:setChildAnchoredPosition(Vector2(0,-contentOffset[1]))
self.isInitRewardScrollView=true

local max=#jdRewards

if isInit then
self.rewardScrollView:setChildCanvasGroupAlpha(0)
if max>0 then
self.rewardScrollView:setChildCanvasGroupDOFade(1,0.5,nil)
end
end
local canGet
local curIndex=0







for i,d in ipairs(jdRewards)do
if recvIdx>=i then
curIndex=i
end
end

if jdRewards[curIndex+1]then
local d=jdRewards[curIndex+1]or{}
local num=d[1]or 0
if total>=num then
curIndex=curIndex+1
canGet=true
end
end

self.rewardGrid:setChildLayoutGroupCreateItems(max)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for i=1,max do
local item=grids[i-1]
local d=jdRewards[i]or{}
local num=d[1]or 0
local reward=d[2][1]
local fix=total>=num
local rewardFlag=recvIdx>=i


local posY=i*stepHeight
item:SetChildAnchoredPosition(-1,Vector2(0,posY))

if reward then
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
end

local showTick=fix and rewardFlag
local showNum=not showTick
item:SetChildActive(2,showTick)

item:SetChildActive(3,showTick)

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

item:SetChildText(1,num)

item:SetChildActive(6,fix and not rewardFlag)

item:SetChildActive(4,fix)
end

local content_height=max*stepHeight+contentOffset[1]+contentOffset[2]
local max_height=max*stepHeight
self.rewardContent:setChildSizeDelta(100,max_height)


self.rewardProgressBar:setChildSizeDelta(8,max_height)

local cur_height
if curIndex>=max then
cur_height=max_height
elseif curIndex<=0 then
cur_height=total/jdRewards[curIndex+1][1]*stepHeight
else
local rate=(total-jdRewards[curIndex][1])/(jdRewards[curIndex+1][1]-jdRewards[curIndex][1])
cur_height=(curIndex+rate)*stepHeight
end
if anim then
local lerp=math.abs(cur_height-6)
self.rewadProgress:setChildDOSizeDelta(Vector2(8,cur_height),lerp/speed,nil)
else
self.rewadProgress:setChildSizeDelta(8,cur_height)
end
self.rewardNumTxt:setText(total)

if isInit or canGet then
local showHeight=self.rewardScrollView:getChildRectHeight()
local moveY=curIndex>1 and(curIndex-1)*stepHeight+20 or 0
local max_height_=content_height-showHeight
if moveY>max_height_ then
moveY=max_height_
end
self.rewardContent:setLocalPosY(-moveY-showHeight)
end
end

function UILingShuCiFuWin:onClickItem(index)
local data=self.info:getData()
local jdRewards=self.config.jdRewards
local total=data.cjNum
local recvIdx=data.jdrwIndex

local d=jdRewards[index]
local num=d[1]
local reward=d[2][1]
local fix=total>=num
local rewardFlag=recvIdx>=index

local itemid=reward[1]
if fix and not rewardFlag then
call_activitiesHandle_func("activitiesHandle_lingshucifu","reqProtocol_GetReward",self.actID,self.subType,self.subId)
else
itemsComponentHelper.onItemClickEx(itemid)
end
end

function UILingShuCiFuWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UILingShuCiFuWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：<color=#F7F7F7FF>{0}</color>",timeHelper.format_time_stamp3(time)))
end

function UILingShuCiFuWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UILingShuCiFuWin:refreshFree()
local check=self.info:checkFree()
self.freeOnce:setActive(check)
self.onceBtnReddot:setActive(check)
self.onceCost:setActive(not check)
end

function UILingShuCiFuWin:refreshNext()
local data=self.info:getData()
local maxTimes=self.config.round
self.nextTx:setText(maxTimes-data.cjNum2)
end

function UILingShuCiFuWin:rec_newday()
self:refreshFree()
end

function UILingShuCiFuWin:refreshAll()
self:refreshFree()
self:refreshPanel()
self:refreshRewardPanel(self.actID,self.subType,self.subId)
self:refreshBigReward()
end

function UILingShuCiFuWin:refreshPanel()
local data=self.info.data
local level=data.level or 1
self.levelText:setText(FMT.fmt("灵树:{0}级",level))
if self.config.level[level+1]then
local curExp=data.exp or 0
local maxexp=self.config.level[level+1]
self.progressBar:setProgressValue(curExp,maxexp)
self.progressBar:setChildProgressText(_format('%s/%s',curExp,maxexp))
else
local maxexp=self.config.level[level]
if not maxexp or maxexp<=0 then
maxexp=1
end
self.progressBar:setProgressValue(maxexp,maxexp)
self.progressBar:setChildProgressText("已满级")
end
end

function UILingShuCiFuWin:refreshBigReward(flag)
local data=self.info:getData()
local level=data.level or 1
local list=self.config.reward_list[level]
if not list or#list==0 then
self.bigRewardGroup:setActive(false)
return
end
if self.oldLevel~=level then
flag=true
end
self.oldLevel=level
self.bigRewardList=list
self.bigRewardGroup:setActive(true)
local grids=self.bigRewardGroup:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local widget=grids[i-1]
local itemData=list[i]or{}
local ItemId=itemData[1]
local ItemCount=itemData[2]or 0
local isSpe=itemData[3]==1
if ItemId then
widget:SetChildActive(-1,true)

local itemConfig=itemsConfig.getConfig(ItemId)
local color=itemConfig.color
local animId=animIdLookup[animType.dianweiStand][color]or animIdLookup[animType.dianweiStand][0]
widget:SetChildSpineAnimation(0,animId,1,nil)

widget:SetChildActive(1,ItemCount>1)
widget:SetChildActive(2,isSpe)
widget:SetChildActive(4,true)

if flag then
widget:SetChildIcon(4,iconHelper.getIconName(ItemId),false)

widget:SetChildText(1,ItemCount)


widget:SetChildButtonClick(3,function()
if _this==nil or _this.isAnim then return end
itemsComponentHelper.onItemClickEx(ItemId)
end,true)
end
else
widget:SetChildActive(-1,false)
end
end
end

function UILingShuCiFuWin:refreshButton()
local useItems=self.config.useItems

self.once=useItems[1][2]
self.money=useItems[1][1]
self.onceBtnTx:setText("祈愿1次")
self.onceIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.onceNum:setText(self.once)

self.many=useItems[1][2]*10
self.manyBtnTx:setText("祈愿10次")
self.manyIcon:setImageIcon(iconHelper.getIconName(self.money),false)
self.manyNum:setText(self.many)


self:freshMoney()
self:freshManyReddot()
end

function UILingShuCiFuWin:freshManyReddot()
local isRed=self.info:checkMany()
self.manyBtnReddot:setActive(isRed)
end

function UILingShuCiFuWin:freshMoney()
self.moneyRoot:setActive(true)

local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyType=self.money

local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
local moneyStr=mathHelper.formatNumber(moneyVal,true)
widget:SetChildIcon(0,iconHelper.getIconName(moneyType),false)
widget:SetChildText(1,moneyStr)
widget:SetChildActive(2,true)
widget:SetChildButtonClick(2,function()self:onAddClick(moneyType)end,true)
end

function UILingShuCiFuWin:freshMoneyValue(lastVal)
local moneyType=self.money
local widget=self.winlua:GetChildWidgetBase(self.moneyRoot:getID())
local moneyVal=0
if moneyConfig.isMoney(moneyType)then
moneyVal=moneyModel.getMoney(moneyType)
else
moneyVal=bagControl.invokeFuncByItemId(moneyType,'getItemCountByItemID',moneyType)
end
self:clearFMTweener()
self.fmTweener=_DOTweenProxy.DoValueTo(function()
return lastVal
end,function(val)
lastVal=val
local moneyStr=mathHelper.formatNumber(math.floor(val),true)
widget:SetChildText(1,moneyStr)
end,moneyVal,1)
end

function UILingShuCiFuWin:clearFMTweener()
if self.fmTweener==nil then return end
self.fmTweener:Kill()
self.fmTweener=nil
end

function UILingShuCiFuWin:refreshJumpAnimation()

local toggle=self.info:getJumpAnimation()
self.skipSelectImg:setActive(toggle)
self.skipBgImg:setActive(not toggle)
end


function UILingShuCiFuWin:initCatShow(isInit,stateId)
local isSkipAnim=self.info:getJumpAnimation()
local isSkip=isSkipAnim or self.skipAnimFlag_wish or false
local fadeInTime=isSkip and 0 or 0.5
if isInit then
self.leftCatModel:setLocalPosX(-500)
self.rightCatModel:setLocalPosX(500)
self.leftCatModel:setChildUIModelShowTarget(self.leftCatModelParams.body,1,self.leftCatModelParams.componets,eAnimationID.walk,false,false,0)
self.rightCatModel:setChildUIModelShowTarget(self.rightCatModelParams.body,1,self.rightCatModelParams.componets,eAnimationID.walk,false,false,0)
end
if isSkip then
self.leftCatModel:setChildCanvasGroupAlpha(1)
self.rightCatModel:setChildCanvasGroupAlpha(1)
else
self.leftCatModel:setChildCanvasGroupAlpha(1,fadeInTime)
self.rightCatModel:setChildCanvasGroupAlpha(1,fadeInTime)
end

local idx1=self.leftCatModel:getID()
local initData1={
winName="UILingShuCiFuWin",
modelWidget=self.winlua,
modelIndex=idx1,
stateId=stateId or 0,
targetPos1={-80,-215,0},
targetPos2={-500,-215,0},

targetPos={-106,-215,0},
targetEndPos={-105,-215,0},
targetWait=5,

speakWait=2,
}
local index1=self.indexLookup[idx1]
self.showCatBt[index1]=behaviorManager:addBehaviorTree('bt_ui_act_lscf_cat',{},true,initData1)

local idx2=self.rightCatModel:getID()
local initData2={
winName="UILingShuCiFuWin",
modelWidget=self.winlua,
modelIndex=idx2,
stateId=stateId or 0,
targetPos1={140,-215,0},
targetPos2={500,-215,0},

targetPos={191,-215,0},
targetEndPos={190,-215,0},
targetWait=5,

speakWait=4,
}
local index2=self.indexLookup[idx2]
self.showCatBt[index2]=behaviorManager:addBehaviorTree('bt_ui_act_lscf_cat',{},true,initData2)
end

function UILingShuCiFuWin:setSkipAnimByWish(flag)
self.skipAnimFlag_wish=flag
end

function UILingShuCiFuWin:onShowPrize(prizeType,rewards,effectData)
if prizeType~=ePrizeType.eLingShuCiFu then
return
end
local isSkipAnim=self.info:getJumpAnimation()
local isSkip=isSkipAnim or self.skipAnimFlag_wish or false

local isHideDrawBtn=false
if effectData.upLevelNum>0 and not isSkipAnim and not self.skipAnimFlag_wish then

isHideDrawBtn=true
end

if isSkip then
return self:showPrize(effectData)
else
self.isAnim=true
self.openRoot:setActive(false)
UIManager:invokeUIMethod(self.parentWin,'activeRoot',false)

behaviorManager:removeBehaviorTree(self.showCatBt[1])
behaviorManager:removeBehaviorTree(self.showCatBt[2])
self:initCatShow(nil,1)

self.effectData=effectData
self.showPrizeFunc=function()

_this:showPrize(effectData)
end
end
return true
end

function UILingShuCiFuWin:showPrize(effectData)

local args={
effectData=effectData,
act_id=self.actID,
sub_act_type=self.subType,
sub_act_id=self.subId,
}
UIManager:showWindow('UILingShuCiFuShowPrizeWin',args)
UIManager:invokeUIMethod(self.parentWin,'activeRoot',true)
self.openRoot:setActive(true)
self:refreshAll()
end






function UILingShuCiFuWin:onMoneyBtn()
gainControl:showGainWin(self.money)
end



function UILingShuCiFuWin:onOnceBtn()
if self.isAnim then
return
end
call_activitiesHandle_func("activitiesHandle_lingshucifu","reqProtocol_Choujiang",self.actID,self.subType,self.subId,1)
end



function UILingShuCiFuWin:onManyBtn()
if self.isAnim then
return
end
call_activitiesHandle_func("activitiesHandle_lingshucifu","reqProtocol_Choujiang",self.actID,self.subType,self.subId,10)
end



function UILingShuCiFuWin:onSkipBtn()
local toggle=self.info:getJumpAnimation()
toggle=not toggle
self.skipSelectImg:setActive(toggle)
self.skipBgImg:setActive(not toggle)
self.info:setJumpAnimation(toggle)
end



function UILingShuCiFuWin:onTipsBtn()
self:onRewardPrevieBtn()
end



function UILingShuCiFuWin:onRewardPrevieBtn()
self:showWindow("UILingShuCiFuPreviewWin",{parentWin=self,act_id=self.actID,sub_act_type=self.subType,sub_act_id=self.subId})
end





function UILingShuCiFuWin:refreshIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subId)
local isForbiddenShowReddot=actInfo:checkIsForbiddenShowReddot()
self.isShowReddotBtn:setActive(not isForbiddenShowReddot)
if isForbiddenShowReddot then
return
end

local isShowReddot=actInfo:checkIsShowReddot()
self.isShowReddotSelectImg:setActive(isShowReddot)
self.isShowReddotBgImg:setActive(not isShowReddot)
end

function UILingShuCiFuWin:onIsShowReddotBtn()
local actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subId)
local isShowReddot=actInfo:checkIsShowReddot()
isShowReddot=not isShowReddot

actInfo:setIsShowReddot(isShowReddot)
reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,self.subType)
self:refreshIsShowReddotBtn()
end

function UILingShuCiFuWin.onSubActivityOverBeforeEndTime24Hour(actId,subType,subId)
if _this==nil then return end
if _this.actID==actId and _this.subType==subType and _this.subId==subId then
_this:refreshIsShowReddotBtn()
end
end

function UILingShuCiFuWin:test_changePoint(index,animId)
local grids=self.bigRewardGroup:getChildCommonLayoutGroupWidgetList()
local item=grids[index-1]
item:SetChildSpineAnimation(0,animId,1,nil)
end
