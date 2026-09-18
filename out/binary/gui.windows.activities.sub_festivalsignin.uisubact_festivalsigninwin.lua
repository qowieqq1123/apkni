







def_class("UISubAct_FestivalSignInWin",UIWindowBase)









function UISubAct_FestivalSignInWin:bindComponents()

self.newTimeTextYM=UIText.get(self,0)
self.newTimeTextD=UIText.get(self,1)
self.festivalNameImage=UIImage.get(self,2)
self.oldTimeText=UIText.get(self,3)
self.shiYiText=UIText.get(self,4)
self.poetryText=UIText.get(self,5)
self.dayScrollView=UIObject.get(self,6)
self.rewardGrids=UIObject.get(self,7)
self.getRewardBtn=UIButton.get(self,8)
self.gotFlag=UIObject.get(self,9)
self.getRewardReddot=UIObject.get(self,10)
self.showItemPanel=UIObject.get(self,11)
self.showItemPos=UIObject.get(self,12)
self.itemModel=UIObject.get(self,13)
self.itemEffectBg=UIObject.get(self,14)
self.itemEffect=UIObject.get(self,15)
self.itemImg=UIImage.get(self,16)
self.itemClick=UIButton.get(self,17)
self.zuShiModel1=UIObject.get(self,18)
self.zuShiModel2=UIObject.get(self,19)
self.bubbleframeRoot=UIImage.get(self,20)
self.bubbleModel=UIObject.get(self,21)
self.headKuang=UIImage.get(self,22)
self.emotRoot=UIObject.get(self,23)
self.emoticon=UIImage.get(self,24)
self.timeText=UIText.get(self,25)
self.calendarBg1=UIImage.get(self,26)
self.showItemAcBg=UIObject.get(self,27)
self.showItemAcImage=UIImage.get(self,28)
self.calendarBg2=UIImage.get(self,29)
self.bgModel=UIObject.get(self,30)
self.npcModel=UIObject.get(self,31)
self.speakObj=UIObject.get(self,32)
self.speakText=UIText.get(self,33)
self.npcPanel=UIObject.get(self,34)

self.getRewardBtn:setButtonClick(function()self:onGetRewardBtn()end)

self.itemClick:setButtonClick(function()self:onItemClick()end)



end


function UISubAct_FestivalSignInWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.newTimeTextYM);self.newTimeTextYM=nil;
_UIObject_release(self.newTimeTextD);self.newTimeTextD=nil;
_UIObject_release(self.festivalNameImage);self.festivalNameImage=nil;
_UIObject_release(self.oldTimeText);self.oldTimeText=nil;
_UIObject_release(self.shiYiText);self.shiYiText=nil;
_UIObject_release(self.poetryText);self.poetryText=nil;
_UIObject_release(self.dayScrollView);self.dayScrollView=nil;
_UIObject_release(self.rewardGrids);self.rewardGrids=nil;
_UIObject_release(self.getRewardBtn);self.getRewardBtn=nil;
_UIObject_release(self.gotFlag);self.gotFlag=nil;
_UIObject_release(self.getRewardReddot);self.getRewardReddot=nil;
_UIObject_release(self.showItemPanel);self.showItemPanel=nil;
_UIObject_release(self.showItemPos);self.showItemPos=nil;
_UIObject_release(self.itemModel);self.itemModel=nil;
_UIObject_release(self.itemEffectBg);self.itemEffectBg=nil;
_UIObject_release(self.itemEffect);self.itemEffect=nil;
_UIObject_release(self.itemImg);self.itemImg=nil;
_UIObject_release(self.itemClick);self.itemClick=nil;
_UIObject_release(self.zuShiModel1);self.zuShiModel1=nil;
_UIObject_release(self.zuShiModel2);self.zuShiModel2=nil;
_UIObject_release(self.bubbleframeRoot);self.bubbleframeRoot=nil;
_UIObject_release(self.bubbleModel);self.bubbleModel=nil;
_UIObject_release(self.headKuang);self.headKuang=nil;
_UIObject_release(self.emotRoot);self.emotRoot=nil;
_UIObject_release(self.emoticon);self.emoticon=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.calendarBg1);self.calendarBg1=nil;
_UIObject_release(self.showItemAcBg);self.showItemAcBg=nil;
_UIObject_release(self.showItemAcImage);self.showItemAcImage=nil;
_UIObject_release(self.calendarBg2);self.calendarBg2=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.npcModel);self.npcModel=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.npcPanel);self.npcPanel=nil;
end
















local _this
local dayItemCmpIndex={
bg=0,
select=1,
showItem=2,
name=3,
reddot=4,
}
local rewardItemCmpIndex={
bg=0,
qualityIcon=1,
itemIcon=2,
countLayout=3,
countText=4,
gotFlag=5,
}

local itemColorImage={
[eQualityColor.eGreen]="image_jieriqiandao_yqpz1",
[eQualityColor.eBlue]="image_jieriqiandao_yqpz2",
[eQualityColor.ePurple]="image_jieriqiandao_yqpz3",
[eQualityColor.eOrange]="image_jieriqiandao_yqpz4",
[eQualityColor.eRed]="image_jieriqiandao_yqpz5",
}

local rewardColorImage={
[eQualityColor.eGreen]="image_jieriqiandao_dzpz1",
[eQualityColor.eBlue]="image_jieriqiandao_dzpz2",
[eQualityColor.ePurple]="image_jieriqiandao_dzpz3",
[eQualityColor.eOrange]="image_jieriqiandao_dzpz4",
[eQualityColor.eRed]="image_jieriqiandao_dzpz5",
}
local colorImageAbName="ui/windows/activities/sub_festivalsignin/festivalsignin_atlas_pak.ab"

local _daoBingBgEffectId=
{
[eQualityColor.ePurple]=10185,
[eQualityColor.eOrange]=10186,
[eQualityColor.eRed]=10187,
}



function UISubAct_FestivalSignInWin:onLoaded(...)
_this=self
self:bindComponents()

end


function UISubAct_FestivalSignInWin:__delete()
_this=nil
self:clearShowItemModel()
self:clearAllTimer()
self:unbindComponents()
end




function UISubAct_FestivalSignInWin:onShow(argtable,afterOnloaded)
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

if not self.activityData then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.beginTime=self.activityData.start_time
self.endTime=self.activityData.end_time

if afterOnloaded and self.config.bgModelId then
self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),self.config.bgModelId,1,{},eAnimationID.stand)
end

self.selectDayIndex=nil
self:initDate()
self:refresh(true)

self:refreshNPCModel(afterOnloaded)


self:setRemainingTimeTimer()
end


function UISubAct_FestivalSignInWin:onHide()
self.dayScrollView:setActive(false)
self:clearShowItemModel()
self:clearAllTimer()
end

function UISubAct_FestivalSignInWin:initDate()
self.todayIndex=self.activityData:getOpenDayIndex()
local todayZeroTime=timeHelper.getTodayZeroStamp()
self.nextRefreshTime=todayZeroTime+86400
end

function UISubAct_FestivalSignInWin:refresh(isInit)
self:refreshCalendarPanel()
self:refreshMainPanel(isInit)

self:refreshShowItemModel()
end

function UISubAct_FestivalSignInWin:refreshCalendarPanel()
local allDayCfg=self.config.showDayParam
local dayCfg=allDayCfg[self.todayIndex]
if not dayCfg then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的对应第{3}天的显示配置，请检查配置表是否正确",self.activityId,self.subType,self.subId,self.todayIndex))
return
end
local jrImgParam=dayCfg.jrImgParam
if jrImgParam then
local jrImageAbName="ui/windows/activities/sub_festivalsignin/festivalsignin_festivalname_atlas_pak.ab"
local imageName=jrImgParam.image
local imageOffset=jrImgParam.offset or{-51,66}
self.festivalNameImage:setCSImageSprite(jrImageAbName,imageName)
self.festivalNameImage:setChildAnchoredPos(imageOffset[1],imageOffset[2])
self.festivalNameImage:setActive(true)
else
self.festivalNameImage:setActive(false)
end



local year,month,day=timeHelper.getServerData()
self.newTimeTextYM:setText(FMT.fmt("{0}年{1}月",year,month))
self.newTimeTextD:setText(day)
local dateOffset=dayCfg.dateOffset or{0,87}
self.newTimeTextD:setChildAnchoredPos(dateOffset[1],dateOffset[2])


if api_Available_ToChineseCalendar()then
local lunarDate_year,lunarDate_month,lunarDate_day,isLeapMonth=timeHelper.getChineseCalendarDateByDate(year,month,day)
local lunarDateStr
local monthStr=""
if lunarDate_month==1 then
monthStr="正"
else
monthStr=mathHelper.numberToChinese(lunarDate_month)
end

if not isLeapMonth then
lunarDateStr=FMT.fmt("农历{0}月{1}",monthStr,timeHelper.getChineseCalendarDateStr(lunarDate_day))
else
lunarDateStr=FMT.fmt("农历闰{0}月{1}",monthStr,timeHelper.getChineseCalendarDateStr(lunarDate_day))
end
self.oldTimeText:setText(lunarDateStr)
self.oldTimeText:setActive(true)
else
self.oldTimeText:setActive(false)
end


self.shiYiText:setText(dayCfg.shiyiDesc)


self.poetryText:setText(dayCfg.poetry)


local bgName1="image_jieriqiandao_7"
local bgName2="image_jieriqiandao_5"
local offset2={0,85.5}
local abName="ui/windows/activities/sub_festivalsignin/festivalsignin_calendarbg_atlas_pak.ab"
if dayCfg.rlbgParam then
local param=dayCfg.rlbgParam
bgName1=param.image1 and param.image1 or bgName1
bgName2=param.image2 and param.image2 or bgName2
offset2=param.offset and param.offset or offset2
end
self.calendarBg1:setCSImageSprite(abName,bgName1)
self.calendarBg2:setCSImageSprite(abName,bgName2)
self.calendarBg2:setChildAnchoredPos(offset2[1],offset2[2])
end

function UISubAct_FestivalSignInWin:refreshMainPanel(isNeedJump)
local dayRewardList=self.config.rewards
local allDayCfg=self.config.showDayParam
local allDayCount=#dayRewardList
if not self.selectDayIndex then

for i=1,allDayCount do
local isGot=self.activityData:checkDayRewardIsGot(i)
local isSign=self.activityData:checkDayIsSignIn(i)
if isSign and not isGot then
self.selectDayIndex=i
break
end
end

if not self.selectDayIndex then

self.selectDayIndex=self.todayIndex
end
end


self.dayScrollView:setChildScrollViewCreateGrids(allDayCount,allDayCount)
local grids=self.dayScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local dayCfg=allDayCfg[i]
local dayName=dayCfg.name

widget:SetChildButtonClick(dayItemCmpIndex.bg,function()
self:onClickSelectDay(i)
end)


widget:SetChildText(dayItemCmpIndex.name,dayName)


local isSelect=i==self.selectDayIndex
widget:SetChildActive(dayItemCmpIndex.select,isSelect)


local rewards=dayRewardList[i]
local firstItem=rewards[1]
local itemId=firstItem[1]
local isGot=self.activityData:checkDayRewardIsGot(i)
local item=widget:GetChildWidgetBase(dayItemCmpIndex.showItem)
item:SetChildIcon(1,iconHelper.getIconName(itemId),false)
local itemCfg=itemsConfig.getConfig(itemId)
local colorImageName=itemColorImage[itemCfg.color]
item:SetChildCSImageSprite(0,colorImageAbName,colorImageName)
item:SetChildActive(2,isGot)
widget:SetBaseItemClickEvent(dayItemCmpIndex.showItem,function(...)
self:onClickRewardItem(itemId)
end)


local isGotDayReward=self.activityData:checkDayRewardIsGot(i)
local isSign=self.activityData:checkDayIsSignIn(i)
local reddot=isSign and not isGotDayReward
widget:SetChildActive(dayItemCmpIndex.reddot,reddot)
end

if isNeedJump then
local jumpIndex=self.selectDayIndex-2
self.dayScrollView:setChildScrollViewSelectItem(jumpIndex,false,false,false)
end


local isGot=self.activityData:checkDayRewardIsGot(self.selectDayIndex)
local isSign=self.activityData:checkDayIsSignIn(self.selectDayIndex)




local isReddot=isSign and not isGot
self.getRewardReddot:setActive(isReddot)
self.getRewardBtn:setActive(not isGot)
local isGray=not isSign and not isGot
self.getRewardBtn:setGray(isGray)


local selectDayRewards=dayRewardList[self.selectDayIndex]
self.rewardGrids:setChildLayoutGroupCreateItems(#selectDayRewards)
local rewardGridsList=self.rewardGrids:getChildLayoutGroupGridList()
for i=1,rewardGridsList.Count do
local widget=rewardGridsList[i-1]
local reward=selectDayRewards[i]
local itemid=reward[1]
local count=reward[2]
local countStr=""
local isShowCount=false
if count>1 then
isShowCount=true
countStr=mathHelper.formatNumber(count)
end
widget:SetChildActive(-1,true)
widget:SetChildActive(rewardItemCmpIndex.countLayout,isShowCount)
if isShowCount then
widget:SetChildText(rewardItemCmpIndex.countText,countStr)
end
widget:SetChildIcon(rewardItemCmpIndex.itemIcon,iconHelper.getIconName(itemid),true)
local itemCfg=itemsConfig.getConfig(itemid)
local colorImageName=rewardColorImage[itemCfg.color]
widget:SetChildCSImageSprite(rewardItemCmpIndex.qualityIcon,colorImageAbName,colorImageName)

widget:SetChildButtonClick(rewardItemCmpIndex.bg,function()
self:onClickRewardItem(itemid)
end)


widget:SetChildActive(rewardItemCmpIndex.gotFlag,isGot)
end



end

function UISubAct_FestivalSignInWin:refreshShowItemModel()
self.dayScrollView:setActive(true)
local showModelParam=self.config.showItemModelParams
if showModelParam then
self.showItemPanel:setActive(true)
local itemId=showModelParam.itemid
local cfg=itemsConfig.getConfig(itemId)
local model=cfg.model
if itemsConfig.isDaoBingMaterials(itemId)then
local dbitemid=daobingConfig.getCombineDaoBing(itemId)
model=itemsConfig.getConfig(dbitemid).model
end

self:clearShowItemModel()
self.showModelItemId=itemId

if model then
if itemsConfig.isDaoBing(itemId)or itemsConfig.isDaoBingMaterials(itemId)then
self:showItemModel_DaoBing(itemId)
else
self:showItemModel_NormalItemModel(itemId,model)
end
elseif cfg.funcparam and cfg.funcparam.type==28 and cfg.type1==18 then
self:showItemModel_ZuShi(itemId)
elseif cfg.funcparam and cfg.funcparam.type==item_funtion_type.disciple and cfg.funcparam.isSpecial then
self:showItemModel_DiZi(itemId)
elseif cfg.relevantPram and cfg.type1==18 then
self:showItemModel_HeadKuangOrQiPaoKuangOrEmot(itemId)
elseif cfg.relevantPram then

local relevantPram=cfg.relevantPram
local modelType=relevantPram.relevantId
if modelType==1 then
self:showItemModel_GuBao(itemId,relevantPram)
else



end
else

self:showItemModel_NormalItemImage(itemId)
end
local offset=showModelParam.offset or{0,0}
local size=showModelParam.size or 1
self.showItemPos:setScale(Vector3.New(size,size,size))
self.showItemPos:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))

local acImageName=showModelParam.acImageName
if acImageName then
local acImageAbName="ui/windows/activities/sub_festivalsignin/festivalsignin_acimage_atlas_pak.ab"
self.showItemAcImage:setCSImageSprite(acImageAbName,acImageName)
self.showItemAcBg:setActive(true)
else
self.showItemAcBg:setActive(false)
end

else

self.showItemPanel:setActive(false)
end
end


function UISubAct_FestivalSignInWin:setRemainingTimeTimer()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.endTime and self.endTime-nowTime or 0
if lerp>0 then

self.timeText:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp11(lerp,true)))

if self.nextRefreshTime and nowTime>=self.nextRefreshTime then
self:initDate()
self:refresh()
end
else
self.timeText:setText("活动已结束")
UIManager.error("活动已结束")
self:clearTimer()
end
end

self.timer=self:setTimer(1,0,func)

func()
end


function UISubAct_FestivalSignInWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UISubAct_FestivalSignInWin:clearShowItemModel()
self.showModelItemId=nil
self.itemModel:setChildUIModelRemoveTarget()
self.zuShiModel1:setChildUIModelRemoveTarget()
self.zuShiModel2:setChildUIModelRemoveTarget()
self.winlua:SetChildDOTweenAnimation_DOPause(self.itemImg:getID())
self.itemImg:setChildAnchoredPos(0,0)
self.itemImg:setActive(false)
self.itemEffect:setChildShowEffect(0,false)
self.itemEffectBg:setChildShowEffect(0,false)
playerController:setWidgetHeadKuang(self.widget,self.headKuang:getID())
self.headKuang:setActive(false)
self.bubbleModel:setChildUIModelRemoveTarget()
self.bubbleframeRoot:setImageIcon("",false)
self.bubbleframeRoot:setActive(false)
self.emoticon:setImageIcon("",false)
self.emotRoot:setActive(false)

self.itemImg:setScale(Vector3.New(1,1,1))
self.itemEffect:setScale(Vector3.New(1,1,1))
self.itemEffectBg:setScale(Vector3.New(1,1,1))
end


function UISubAct_FestivalSignInWin:showItemModel_DaoBing(oItemId)
local itemId=oItemId
if itemsConfig.isDaoBingMaterials(oItemId)then
itemId=itemsConfig.getConfig(oItemId).piece[1]
end
local isMaxStar
local maxlv=daobingConfig.getStarMaxLv(itemId)
local starlv=0
isMaxStar=starlv==maxlv
local itemCfg=itemsConfig.getConfig(itemId)
local color=itemCfg.color

local modelParams=itemsConfig.getConfig(itemId).model
local effectInfo=isMaxStar and modelParams[2]or modelParams[1]
self.itemEffect:setChildShowEffect(effectInfo[1],true)
self.itemEffectBg:setChildShowEffect(_daoBingBgEffectId[color],true)

local size=0.8
self.itemEffect:setScale(Vector3.New(size,size,size))
self.itemEffectBg:setScale(Vector3.New(size,size,size))
end


function UISubAct_FestivalSignInWin:showItemModel_NormalItemModel(itemId,modelParams)
local modelID=modelParams.model
local defsize=cfgHelper.get2(cfg_dbbodyconfig_get,modelID,'scales')or{}
local size=modelParams.scale or defsize[1]or 1
local componnets=modelParams.cmp or{}
local animationID=modelParams.ani or 0
local offset=modelParams.offset
self.itemModel:setChildUIModelShowTarget(modelID,size,componnets,animationID)
if offset then
self.itemModel:setChildUIModelShowTargetOffset(offset[1],offset[2])
end
end


function UISubAct_FestivalSignInWin:showItemModel_ZuShi(itemId)
local itemCfg=itemsConfig.getConfig(itemId)
local sex=playerModel:getActorSex()

local list=itemCfg.funcparam.list[sex]
local modelParams=itemCfg.funcparam.model or{}
local scale=modelParams.scale or 0.5
local offsetX=modelParams.offsetX or 0
local offsetY=modelParams.offsetY or 0
if#(list or 0)==1 and list[1][1]==10 then
local temp={}
temp[list[1][1]]=list[1][2]
comHelper.setChildPlayerImage2(self.winlua,self.zuShiModel2:getID(),temp,sex,scale,eAnimationID.idle,offsetX,offsetY,playerController:supportDynamic())
else
local selfImageList=playerImageModel:getDefaultImage()
local getImageId=function(tabid)
for i,v in ipairs(list)do
if v[1]==tabid then
return v[2]
end
end
end
local playerImage={}
for _,tabid in pairs(PLAYER_IMAGE_TYPE)do
playerImage[tabid]=getImageId(tabid)or selfImageList[tabid]
end
playerImageController.setPlayerModel(self.winlua,self.zuShiModel1:getID(),playerImage,scale,eAnimationID.idle,offsetX,offsetY,playerController:supportDynamic())
end
end


function UISubAct_FestivalSignInWin:showItemModel_HeadKuangOrQiPaoKuangOrEmot(itemId)
local itemCfg=itemsConfig.getConfig(itemId)
local itemType1=itemCfg.type1
local itemType2=itemCfg.type2
local relevantPram=itemCfg.relevantPram
if itemType1==18 then
if itemType2==1 then

local headKuangId=relevantPram.relevantId
local headKuangCfg=cfgHelper.get1(cfg_headportraitframeconfig_get,headKuangId)
if headKuangCfg then
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
local kuangAnimType,kuangAnim,enterAnimId=playerModel:getActorFrameAnimById(headKuangId)
playerController:setWidgetHeadKuang(self.widget,self.headKuang:getID(),headKuangCfg.icon,kuangAnimType,kuangAnim,nil,enterAnimId)
self.headKuang:setScale(Vector3.New(size,size,size))
self.headKuang:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))
self.headKuang:setActive(true)
end
elseif itemType2==2 then

local bubbleFrameId=relevantPram.relevantId
local bubbleFrameCfg=cfgHelper.get1(cfg_bubbleframeconfig_get,bubbleFrameId)
if bubbleFrameCfg then
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
local bgmodel=bubbleFrameCfg.setmodel
if bgmodel then
self.bubbleModel:setChildUIModelShowTarget(bgmodel,1,{},eAnimationID.stand)
else
local kuangIconName=iconHelper.getChatKuangIcon(bubbleFrameCfg.icon)
self.bubbleframeRoot:setImageIcon(kuangIconName,false)
end
self.bubbleframeRoot:setScale(Vector3.New(size,size,size))
self.bubbleframeRoot:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))
self.bubbleframeRoot:setActive(true)
end
elseif itemType2==4 then

local bigEmotId=relevantPram.relevantId
local bigEmotCfg=cfgHelper.get1(cfg_chatebigmotconfig_get,bigEmotId)
if bigEmotCfg then
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
local bigEmotName=iconHelper.getBigEmotIcon(bigEmotId)
self.emoticon:setImageIcon(bigEmotName,false)
self.emotRoot:setScale(Vector3.New(size,size,size))
self.emotRoot:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))
self.emotRoot:setActive(true)
end
end
end
end


function UISubAct_FestivalSignInWin:showItemModel_GuBao(itemId,relevantPram)
local pram=relevantPram.pram
local icon=pram.icon or''
local effectid=pram.effectid
self.itemImg:setImageIcon(icon,true)
local needMove=icon~=''
if needMove then
self.winlua:SetChildDOTweenAnimation_DOPlay(self.itemImg:getID())
self.itemImg:setActive(true)
else
self.winlua:SetChildDOTweenAnimation_DOPause(self.itemImg:getID())
self.itemImg:setChildAnchoredPos(0,0)
self.itemImg:setActive(false)
end

if effectid then
self.itemEffect:setChildShowEffect(effectid,true)
else
self.itemEffect:setChildShowEffect(0,false)
end

local size=0.8
self.itemImg:setScale(Vector3.New(size,size,size))
self.itemEffect:setScale(Vector3.New(size,size,size))
end


function UISubAct_FestivalSignInWin:showItemModel_NormalItemImage(itemId)
local iconName=iconHelper.getIconName(itemId)
self.itemImg:setImageIcon(iconName,false)
self.itemImg:setChildSizeDelta(250,250)
self.itemImg:setActive(true)
end


function UISubAct_FestivalSignInWin:showItemModel_DiZi(itemId)
local data=UIDiscipleModel:getItemDiscipleDataByItemId(itemId)
if not data then
return
end

if not data.hasFixedImage then

logErr(FMT.fmt("展示弟子道具 {0} 对应的弟子id: {1} 没有配置固定组件库 无法加载形象",itemId,data.id))
return
end

local info=data.imageInfo
if info then

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info)
local scale=1
local animId=eAnimationID.stand
self.zuShiModel1:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,animId)
end
end




function UISubAct_FestivalSignInWin:refreshNPCModel(isInit)
if not self.config.npcModel then
self.npcPanel:setActive(false)
return
end

self.npcPanel:setActive(true)
local fadeTime=isInit and 0.5 or 0
self.speakContent=self.config.npcTalk
local npcModelParms=self.config.npcModel
local modelId=npcModelParms[1]
local scale=npcModelParms[2]
local modelOffSet=npcModelParms[3]
local componnets={}
if npcModelParms[4]and npcModelParms[4]~=0 then
table.insert(componnets,npcModelParms[4])
end
local animId=npcModelParms[5]or eAnimationID.stand
self.npcModel:setChildUIModelShowTarget(modelId,scale,componnets,animId,false,false,fadeTime)
self.npcModel:setChildUIModelShowTargetOffset(modelOffSet[1],modelOffSet[2])
local isFlip=self.config.isFlip==true



if isFlip then
local flipScale=Vector3.New(-scale,scale,scale)
self.npcModel:setScale(flipScale)
end

self.npcTalkTime=self.config.npcTalkTime
self.npcTalkShowTime=self.config.npcTalkShowTime

if isInit then

self.speakObj:setScale(Vector3.zero)
end

if self.speakContent then

self:delayDo(0.3,function()
self:doSpeaking()
end)
end
end


function UISubAct_FestivalSignInWin:doSpeaking()
self:clearSpeakTimer()

local randomIndexList={}
for i=1,#self.speakContent do
if not self.lastSpeakIndex or i~=self.lastSpeakIndex then
table.insert(randomIndexList,i)
end
end
local speakIndex=1
if#randomIndexList>1 then
local randomIndex=math.random(1,#randomIndexList)
speakIndex=randomIndexList[randomIndex]
self.lastSpeakIndex=speakIndex
end
local speakStr=self.speakContent[speakIndex]
local speed=30
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,speed,nil)
self:doTalkAnim()
end


function UISubAct_FestivalSignInWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.5,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end)
end


function UISubAct_FestivalSignInWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end


function UISubAct_FestivalSignInWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end


function UISubAct_FestivalSignInWin:clearAllTimer()
self:clearTimer()
self:clearSpeakTimer()
end




function UISubAct_FestivalSignInWin:onGetRewardBtn()
local isSign=self.activityData:checkDayIsSignIn(self.selectDayIndex)

if isSign then
self.activityData:reqGetFestivalDayReward(self.selectDayIndex)
else
local needDayCount=self.selectDayIndex-self.todayIndex
local errStr
if needDayCount==1 then
errStr="明天可领取"
elseif needDayCount>1 then
errStr=FMT.fmt("{0}天后可领取",needDayCount)
end
UIManager.error(errStr)
end
end



function UISubAct_FestivalSignInWin:onItemClick()
self:onClickRewardItem(self.showModelItemId)

end

function UISubAct_FestivalSignInWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end


function UISubAct_FestivalSignInWin:onClickSelectDay(index)
if index==self.selectDayIndex then
return
end

self.selectDayIndex=index
self:refreshMainPanel()
end
