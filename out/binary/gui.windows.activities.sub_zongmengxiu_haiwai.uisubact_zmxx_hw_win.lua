







def_class("UISubAct_ZMXX_HW_Win",UIWindowBase)









function UISubAct_ZMXX_HW_Win:bindComponents()

self.bgModel=UIObject.get(self,0)
self.time=UIText.get(self,1)
self.rewardInfoBtn=UIButton.get(self,2)
self.reawrdName=UIText.get(self,3)
self.rewardPro=UIText.get(self,4)
self.horScrollView=UIObject.get(self,5)
self.horContent=UIObject.get(self,6)
self.progressScrollView=UIObject.get(self,7)
self.progressContent=UIObject.get(self,8)
self.progressBar=UIObject.get(self,9)
self.progressValue=UIObject.get(self,10)
self.proCount=UIText.get(self,11)
self.verScrollView=UIObject.get(self,12)
self.verContent=UIObject.get(self,13)
self.progressBarBg=UIObject.get(self,14)
self.progressValueBg=UIObject.get(self,15)
self.showItemPos=UIObject.get(self,16)
self.itemModel=UIObject.get(self,17)
self.itemEffectBg=UIObject.get(self,18)
self.itemEffect=UIObject.get(self,19)
self.itemImg=UIImage.get(self,20)
self.itemClick=UIButton.get(self,21)
self.zuShiModel1=UIObject.get(self,22)
self.zuShiModel2=UIObject.get(self,23)
self.bubbleframeRoot=UIImage.get(self,24)
self.bubbleModel=UIObject.get(self,25)
self.headKuang=UIImage.get(self,26)
self.emotRoot=UIObject.get(self,27)
self.emoticon=UIImage.get(self,28)
self.notModelPanel=UIObject.get(self,29)
self.notModelItem=UIObject.get(self,30)
self.leftBtn=UIButton.get(self,31)
self.rightBtn=UIButton.get(self,32)
self.modelstage=UIObject.get(self,33)
self.progressBarContent=UIObject.get(self,34)
self.titleImage=UIImage.get(self,35)

self.rewardInfoBtn:setButtonClick(function()self:onRewardInfoBtn()end)

self.itemClick:setButtonClick(function()self:onItemClick()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)



end


function UISubAct_ZMXX_HW_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.rewardInfoBtn);self.rewardInfoBtn=nil;
_UIObject_release(self.reawrdName);self.reawrdName=nil;
_UIObject_release(self.rewardPro);self.rewardPro=nil;
_UIObject_release(self.horScrollView);self.horScrollView=nil;
_UIObject_release(self.horContent);self.horContent=nil;
_UIObject_release(self.progressScrollView);self.progressScrollView=nil;
_UIObject_release(self.progressContent);self.progressContent=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.proCount);self.proCount=nil;
_UIObject_release(self.verScrollView);self.verScrollView=nil;
_UIObject_release(self.verContent);self.verContent=nil;
_UIObject_release(self.progressBarBg);self.progressBarBg=nil;
_UIObject_release(self.progressValueBg);self.progressValueBg=nil;
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
_UIObject_release(self.notModelPanel);self.notModelPanel=nil;
_UIObject_release(self.notModelItem);self.notModelItem=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.modelstage);self.modelstage=nil;
_UIObject_release(self.progressBarContent);self.progressBarContent=nil;
_UIObject_release(self.titleImage);self.titleImage=nil;
end


















local horItemCmp=
{
horItem=0,
bg=1,
lockMask=2,
select=3,
itemContent=4,
reddot=5,
lockFlag=6,
recvedFlag=7,
click=8,
}

local verItemCmp=
{
verItem=0,
bg=1,
desc=2,
recvBtn=3,
gotoBtn=4,
recvedFlag=5,
itemScroview=6,
itemContent=7,
}

local ItemCmp=
{
UINormalRewardItem=0,
}

local progressItemCmp=
{
item=0,
gotFlag=1,
click=2,
pro=3,
select=4,
add=5,
change=6,
gray=7
}

local progressBarItemCmp=
{
valueImg=0,
}



local TempState={
eNone=0,
eRecved=1,
eNotRecv=2,
eRecv=3,
}

local _daoBingBgEffectId=
{
[eQualityColor.ePurple]=10185,
[eQualityColor.eOrange]=10186,
[eQualityColor.eRed]=10187,
}

local itemsize=108
local firstitemsize=84
local hight=9
local abNmae="ui/windows/activities/sub_zongmengxiu_haiwai/zongmengxiu_haiwai_atlas_pak.ab"
local _this

function UISubAct_ZMXX_HW_Win:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onShowPrize,self.onShowPrize)
self:addNotify(notifyConfig.onItemUse,self.onItemUse)
end


function UISubAct_ZMXX_HW_Win:__delete()
self:clearShowItemModel()
self:unbindComponents()
end




function UISubAct_ZMXX_HW_Win:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id

self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)

self.data=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subid)
if afterOnloaded then
local modelList=self.config.modelList

self.bgModel:setChildUIModelShowTarget(modelList[1],1,{},eAnimationID.stand)
self.modelstage:setChildUIModelShowTarget(modelList[2],1,{},eAnimationID.stand)
end

self:handleCfg()
self.titleImage:setCSImageSprite(abNmae,self.config.titlename)

if self.actTimer==nil then
local func=function()
self:refreshActTimer()
end
self.actTimer=self:setTimer(60,0,func)
end
self:refreshActTimer()



if self.taskCfgLen>0 then
local targetIndex=nil
local last=1
for i=1,self.taskCfgLen do
local taskDay=self.taskDayLookUp[i]
local state=self:getTaskDayState(taskDay)
if state==TempState.eRecv then
targetIndex=i
break
end
if state==TempState.eNone and not targetIndex then
targetIndex=i
end
if state~=TempState.eNotRecv then
last=i
end
end
targetIndex=targetIndex or last
self:createHorContent(targetIndex)
self:refreshHorContent()
self:onHorItemClick(targetIndex)
end

self:createProgressContent()
self:refreshProgressContent(true)
local targetIndex=0
local curPro=self:getAllTaskPro()
for i,v in ipairs(self.config.bigRewards)do
if curPro>=v[1]then
targetIndex=i
end
end
targetIndex=targetIndex+1
self.bigRewardIndex=targetIndex<=#self.config.bigRewards and targetIndex or#self.config.bigRewards
self.rightBtn:setActive(#self.config.bigRewards>1)
self.leftBtn:setActive(#self.config.bigRewards>1)
self:refreshShowModel()

end


function UISubAct_ZMXX_HW_Win:onHide()
if self.actTimer then
self:stopTimerByID(self.actTimer)
end
self:clearShowItemModel()
self.curHorIndex=nil
end

function UISubAct_ZMXX_HW_Win:refreshShowModel()
local bigRewardCfg=self.config.bigRewards[self.bigRewardIndex]
local showModelParam=bigRewardCfg[3]or{}
local itemId=bigRewardCfg[2][1]
local count=bigRewardCfg[2][2]
local rewardtartget=bigRewardCfg[1]
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

self:showItemModel_NormalItemImage(itemId,count)
end
local offset=showModelParam.offset or{0,0}
local size=showModelParam.size or 1
local hidesatge=showModelParam.hidesatge and showModelParam.hidesatge==1 or false
self.showItemPos:setScale(Vector3.New(size,size,size))
self.showItemPos:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))
self.modelstage:setActive(not hidesatge)

self.reawrdName:setText(cfg.name)

self.rewardPro:setText(rewardtartget)
end

function UISubAct_ZMXX_HW_Win:clearShowItemModel()
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
self.notModelPanel:setActive(false)
end


function UISubAct_ZMXX_HW_Win:showItemModel_DaoBing(oItemId)
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



function UISubAct_ZMXX_HW_Win:showItemModel_NormalItemModel(itemId,modelParams)
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


function UISubAct_ZMXX_HW_Win:showItemModel_ZuShi(itemId)
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


function UISubAct_ZMXX_HW_Win:showItemModel_DiZi(itemId)
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


function UISubAct_ZMXX_HW_Win:showItemModel_HeadKuangOrQiPaoKuangOrEmot(itemId)
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



function UISubAct_ZMXX_HW_Win:showItemModel_GuBao(itemId,relevantPram)
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


function UISubAct_ZMXX_HW_Win:showItemModel_NormalItemImage(itemId,count)




self.notModelPanel:setActive(true)
local rwWidget=self.notModelItem:getWidgetBase()
local itemid=itemId
local countStr=count
local showCountBG=count>1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildPropData(0,prop)
rwWidget:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end


function UISubAct_ZMXX_HW_Win:createHorContent(targetIndex)
self.horContent:setChildLayoutGroupClearAllItems()
local horContentLen=self.taskCfgLen
self.horContent:setChildLayoutGroupCreateItems(horContentLen,function(index)
local horitem=self.horContent:getChildLayoutGroupGridItem(index-1)
horitem:SetChildButtonClick(horItemCmp.click,function()
self:onHorItemClick(index)
end,true)

end)
self.horgrids=self.horContent:getChildLayoutGroupGridList()
local veieW=675
local allW=horContentLen*139+7
local maxW=allW-veieW
local moveX=targetIndex<=4 and 0 or targetIndex*139
moveX=moveX>=maxW and maxW or moveX
self.horContent:setLocalPosX(-moveX)
end

function UISubAct_ZMXX_HW_Win:refreshHorContent()
local horContentLen=self.taskCfgLen
local reddotFlag,lockFlag,recvedFlag
for i=1,horContentLen do
local horitem=self.horgrids[i-1]
local taskDay=self.taskDayLookUp[i]
reddotFlag=self:getReddotFlag_taskDay(taskDay)
lockFlag=self:getLockFlag_taskDay(taskDay)
recvedFlag=self:getRecvedFlag_taskDay(taskDay)
horitem:SetChildText(horItemCmp.itemContent,string.format("第%s天",taskDay))
horitem:SetChildActive(horItemCmp.reddot,reddotFlag)
horitem:SetChildActive(horItemCmp.lockFlag,lockFlag)
horitem:SetChildActive(horItemCmp.lockMask,lockFlag)
horitem:SetChildActive(horItemCmp.recvedFlag,recvedFlag)
end
end

function UISubAct_ZMXX_HW_Win:refreshVerContent()
local curTaskDay=self.curTaskDay
local curDayTaskCfg=self.taskCfgLookUp[curTaskDay]
local verContentLen=#curDayTaskCfg

self.verContent:setChildLayoutGroupClearAllItems()
self.verContent:setChildLayoutGroupCreateItems(verContentLen,function(index)
local veritem=self.verContent:getChildLayoutGroupGridItem(index-1)
local verItemCfg=curDayTaskCfg[index]
local rewards=verItemCfg.rewards
local itemContentLen=#rewards

veritem:SetChildLayoutGroupCreateItems(verItemCmp.itemContent,itemContentLen,function(subindex)
local data=rewards[subindex]
local itemwidget=veritem:GetChildLayoutGroupGridItem(verItemCmp.itemContent,subindex-1)
widgetHelper.setNormalRewardItem(itemwidget,ItemCmp.UINormalRewardItem,data)
end)
veritem:SetChildButtonClick(verItemCmp.recvBtn,function()
self:onVeritemRecvBtn(index)
end,true)
veritem:SetChildButtonClick(verItemCmp.gotoBtn,function()
self:onVeritemGotoBtn(index)
end,true)
veritem:SetChildText(verItemCmp.desc,string.format(verItemCfg.curPro<verItemCfg.target and"%s<color=#C82C2C>(%s/%s)</color>"or"%s<color=#549327>(%s/%s)</color>",verItemCfg.desc,verItemCfg.curPro,verItemCfg.target))
veritem:SetChildActive(verItemCmp.gotoBtn,verItemCfg.state==TempState.eNotRecv)
veritem:SetChildActive(verItemCmp.recvBtn,verItemCfg.state==TempState.eRecv)
veritem:SetChildActive(verItemCmp.recvedFlag,verItemCfg.state==TempState.eRecved)
end)

end

















function UISubAct_ZMXX_HW_Win:createProgressContent()
local progressLen=#self.target_rewards
self.progressScrollView:setChildScrollViewCreateGrids(progressLen,progressLen)
self.grids=self.progressScrollView:getChildScrollViewItemWidgets()
for i=1,self.grids.Count do
local progressItem=self.grids[i-1]
local cfg=self.target_rewards[i]
if cfg then
local targetCount=cfg[1]
progressItem:SetChildText(progressItemCmp.pro,targetCount)
progressItem:SetChildButtonClick(progressItemCmp.click,function()
self:onProgressItemClick(i)
end,true)
progressItem:SetChildButtonClick(progressItemCmp.add,function()
self:onProgressItemAddClick(i)
end,true)
progressItem:SetChildButtonClick(progressItemCmp.change,function()
self:onProgressItemChangeClick(i)
end,true)
progressItem:SetChildActive(progressItemCmp.click,false)
end
end

self.progressBarContent:setChildLayoutGroupClearAllItems()
self.progressBarContent:setChildLayoutGroupCreateItems(progressLen)
self.progressBargrids=self.progressBarContent:getChildLayoutGroupGridList()
end

function UISubAct_ZMXX_HW_Win:refreshProgressContent(isJump)
local pro=self:getAllTaskPro()
self.proCount:setText(pro)
self.progressValueBg:setActive(pro>0)
local firstRecvIndex=nil
local firstNotRecvIndex=nil

local len=#self.target_rewards
for i=1,len do
local progressItem=self.grids[i-1]
local progressBarItem=self.progressBargrids[i-1]
local cfg=self.target_rewards[i]
if cfg then
local state=self:getTargetState(i)
local rewards=cfg[2]
local isFix=#rewards==1
local localSelectList=self:getSelectList()
local selectIndex=localSelectList[i]





local reward=rewards[selectIndex]
progressItem:SetChildActive(progressItemCmp.select,state==TempState.eRecv)
if reward then
progressItem:SetChildActive(progressItemCmp.item,true)
progressItem:SetChildActive(progressItemCmp.add,false)

local rewardItem=progressItem:GetChildWidgetBase(progressItemCmp.item)
local itemid=reward[1]
local count=reward[2]
local countStr=''
local showCountBG=false
if count>=1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end
local conf

local grayNum=0

conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,gray=grayNum,showStage=true}

local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(i,...)
end)
progressItem:SetChildActive(progressItemCmp.gotFlag,state==TempState.eRecved)
progressItem:SetChildActive(progressItemCmp.gray,state==TempState.eRecved)
if isFix then
progressItem:SetChildActive(progressItemCmp.change,false)
else
progressItem:SetChildActive(progressItemCmp.change,state~=TempState.eRecved)
end
else
progressItem:SetChildActive(progressItemCmp.item,false)
progressItem:SetChildActive(progressItemCmp.gotFlag,false)
progressItem:SetChildActive(progressItemCmp.gray,false)
progressItem:SetChildActive(progressItemCmp.change,false)
progressItem:SetChildActive(progressItemCmp.add,true)
end
if state==TempState.eRecv and not firstRecvIndex then
firstRecvIndex=i
end
if state==TempState.eNotRecv and not firstNotRecvIndex then
firstNotRecvIndex=i
end




if state==TempState.eRecv or state==TempState.eRecved then
progressBarItem:SetChildIconFillAmount(progressBarItemCmp.valueImg,1)
elseif state==TempState.eNotRecv then
local lastcfg=self.target_rewards[i-1]
local lastTarget=lastcfg and lastcfg[1]or 0
local curTarget=cfg[1]
local barcount=pro-lastTarget
local barbaseCout=curTarget-lastTarget

local value=barcount<=0 and 0 or(barcount/barbaseCout)*0.48+0.3
progressBarItem:SetChildIconFillAmount(progressBarItemCmp.valueImg,value)
else
progressBarItem:SetChildIconFillAmount(progressBarItemCmp.valueImg,0)
end
end
end

if isJump then
local jumpIndex=firstRecvIndex and firstRecvIndex or firstNotRecvIndex
jumpIndex=jumpIndex or len
if jumpIndex<=0 then
jumpIndex=1
end

self.progressScrollView:setChildScrollRectEnable(false)

self.progressContent:setLocalPosX(-(jumpIndex-1)*130)
self.progressScrollView:setChildScrollRectEnable(true)
end


























end

function UISubAct_ZMXX_HW_Win:handleCfg()
local taskCfgLookUp={}
local taskDayLookUp={}
local tasks=self.config.tasks
local taskDay
local len=0
for i,v in ipairs(tasks)do
taskDay=v[5]

if not taskCfgLookUp[taskDay]then
taskCfgLookUp[taskDay]={}
len=len+1
taskDayLookUp[len]=taskDay
end
local temp={}
temp.taskDay=taskDay
temp.rewards=v[4]
temp.desc=v[6]
temp.target=v[1]
temp.jumpArgs=v[7]
temp.index=i
temp.state=0
taskCfgLookUp[taskDay][#taskCfgLookUp[taskDay]+1]=temp
end
self.taskCfgLookUp=taskCfgLookUp
self.taskCfgLen=len
self.taskDayLookUp=taskDayLookUp
self.target_rewards=self.config.target_rewards
self:sortTaskDayCfg()
end

function UISubAct_ZMXX_HW_Win:sortTaskDayCfg(day)
if day then
local dayCfg=self.taskCfgLookUp[day]
if not dayCfg then
return
end
for i,v in ipairs(dayCfg)do
v.state,v.curPro=self:getTaskState(day,i)
end
table.sort(dayCfg,function(a,b)
return a.state>b.state
end)
return
end

for k,v in pairs(self.taskCfgLookUp)do
for i,vv in ipairs(v)do
vv.state,vv.curPro=self:getTaskState(k,i)
end
table.sort(v,function(a,b)
if a.state==b.state then
return a.index<b.index
else
return a.state>b.state
end

end)
end
end

function UISubAct_ZMXX_HW_Win:getReddotFlag_taskDay(taskDay)
return TempState.eRecv==self:getTaskDayState(taskDay)
end

function UISubAct_ZMXX_HW_Win:getLockFlag_taskDay(taskDay)
return TempState.eNotRecv==self:getTaskDayState(taskDay)
end

function UISubAct_ZMXX_HW_Win:getRecvedFlag_taskDay(taskDay)
return TempState.eRecved==self:getTaskDayState(taskDay)
end

function UISubAct_ZMXX_HW_Win:getTaskDayState(taskDay)
local curday=self.sub_actInfo:getServerCurDay()
if taskDay>curday then
return TempState.eNotRecv,taskDay-curday
end
local dayTaskCfg=self.taskCfgLookUp[taskDay]
local recvedCount=0
for i,v in ipairs(dayTaskCfg)do
local taskState=self:getTaskState(taskDay,i)
if taskState==TempState.eRecv then
return TempState.eRecv
elseif taskState==TempState.eRecved then
recvedCount=recvedCount+1
end
end
return recvedCount==#dayTaskCfg and TempState.eRecved or TempState.eNone
end

function UISubAct_ZMXX_HW_Win:getTaskState(taskDay,index)
local dayTaskCfg=self.taskCfgLookUp[taskDay]
local taskCfg=dayTaskCfg[index]
local taskdatalookUp=self.data.taskdatalookUp
local taskdata=taskdatalookUp[taskCfg.index]
local pro=taskdata.task_progress
local state=self.sub_actInfo:getTaskState(taskCfg.index)
return state,pro
end

function UISubAct_ZMXX_HW_Win:getAllTaskPro()
local allcount=self.sub_actInfo:getAllTaskPro()
return allcount
end

function UISubAct_ZMXX_HW_Win:getTargetState(index)
local state=self.sub_actInfo:getTargetState(index)
return state
end


function UISubAct_ZMXX_HW_Win:refreshActTimer()
local time=activitiesModel:getSubActEndLeftTime(self.actID,self.subType,self.subid)
local time_str=FMT.fmt('活动剩余时间：{0}',timeHelper.format_time_stamp3(time))
self.time:setText(time_str)
end





function UISubAct_ZMXX_HW_Win:onRewardInfoBtn()
self:onClickItem(self.showModelItemId)
end


function UISubAct_ZMXX_HW_Win:onClickItem(itemId,index,guid,attach)

if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eRight,
showModel=true,})
end

function UISubAct_ZMXX_HW_Win:onHorItemClick(index)
if self.curHorIndex==index then
return
end
if index~=1 then
local taskDay=self.taskDayLookUp[index]
local state,needDay=self:getTaskDayState(taskDay)

if state==TempState.eNotRecv then
UIManager.info(needDay==1 and"明天开启"or FMT.fmt("{0}天后开启",needDay))
return
end
end

if self.curHorIndex then
local lasthoritem=self.horgrids[self.curHorIndex-1]
lasthoritem:SetChildActive(horItemCmp.select,false)
end
local curhoritem=self.horgrids[index-1]
curhoritem:SetChildActive(horItemCmp.select,true)
self.curHorIndex=index
self.curTaskDay=self.taskDayLookUp[index]


self:refreshVerContent()
end


function UISubAct_ZMXX_HW_Win:onVeritemRecvBtn(index)

local taskList={}
local curTaskDay=self.curTaskDay
local curDayTaskCfg=self.taskCfgLookUp[curTaskDay]

for i,v in ipairs(curDayTaskCfg)do
if v.state==TempState.eRecv then
taskList[#taskList+1]=v.index
end
end
if#taskList>0 then
call_activitiesHandle_func("activitiesHandle_zongmengxiuxing","reqTaskReward",self.actID,self.subid,taskList)
end
end

function UISubAct_ZMXX_HW_Win:onVeritemGotoBtn(index)
local curTaskDay=self.curTaskDay
local curDayTaskCfg=self.taskCfgLookUp[curTaskDay]
local verItemCfg=curDayTaskCfg[index]
local jumpArgs=verItemCfg.jumpArgs
local jumpParam={type=jumpArgs[1],id=jumpArgs[2],args=jumpArgs[3]}
jumpManager:jump(jumpParam)
end

function UISubAct_ZMXX_HW_Win:onProgressItemClick(index)

end

function UISubAct_ZMXX_HW_Win:onProgressItemAddClick(index)

local itemList={}
local temp={}
local cfg=self.target_rewards[index]
local rewards=cfg[2]
temp.oldSelectIndex=nil
temp.selectList=rewards
itemList[1]=temp
local okCallback=function(selectIndexList)
self:setSelectList(index,selectIndexList[1])
self:refreshProgressContent()
end
UIManager:showWindow("UICommonGiftSelectWin",{itemList=itemList,okCallback=okCallback})
end




function UISubAct_ZMXX_HW_Win:getSelectList()
return self.data.selectList
end

function UISubAct_ZMXX_HW_Win:setSelectList(index,value)


self.data.selectList[index]=value
userActorSetting.set(FMT.fmt('actid{0}_subid{1}_selectList',self.actID,self.subid),self.data.selectList)
end

function UISubAct_ZMXX_HW_Win:onProgressItemChangeClick(index)
local itemList={}
local temp={}
local cfg=self.target_rewards[index]
local rewards=cfg[2]
temp.oldSelectIndex=nil
temp.selectList=rewards
itemList[1]=temp
local okCallback=function(selectIndexList)
self:setSelectList(index,selectIndexList[1])
self:refreshProgressContent()
end
UIManager:showWindow("UICommonGiftSelectWin",{itemList=itemList,okCallback=okCallback})
end

function UISubAct_ZMXX_HW_Win:onClickRewardItem(index,...)

local state=self:getTargetState(index)
if state==TempState.eRecv then
local selectList={}
local curRecvIdx=self.data.targetRecvIdx
for i=curRecvIdx+1,#self.target_rewards do
if self:getTargetState(i)==TempState.eRecv then
local cfg=self.target_rewards[i]
local rewards=cfg[2]
local isFix=#rewards==1
local localSelectList=self:getSelectList()
local selectIndex=localSelectList[i]
if not isFix and not selectIndex then
UIManager.error("请先选好自选道具")
return
end
selectList[#selectList+1]=isFix and 1 or selectIndex
end
end
if#selectList>0 then
call_activitiesHandle_func("activitiesHandle_zongmengxiuxing","reqTargetReward",self.actID,self.subid,selectList)
return
end
else
itemsComponentHelper.onItemClickEx(...)
end

end

function UISubAct_ZMXX_HW_Win:onItemClick()
self:onClickItem(self.showModelItemId)
end

function UISubAct_ZMXX_HW_Win:onLeftBtn()
local biglen=#self.config.bigRewards
self.bigRewardIndex=self.bigRewardIndex-1
self.bigRewardIndex=self.bigRewardIndex<=0 and biglen or self.bigRewardIndex
self:refreshShowModel()

end

function UISubAct_ZMXX_HW_Win:onRightBtn()
local biglen=#self.config.bigRewards
self.bigRewardIndex=self.bigRewardIndex+1
self.bigRewardIndex=self.bigRewardIndex>biglen and 1 or self.bigRewardIndex
self:refreshShowModel()
end

function UISubAct_ZMXX_HW_Win.onShowPrize(prizeType,temp,effectData)
if _this==nil then return end
if prizeType==ePrizeType.eZongMenXiuXing then
local tipsid=effectData.tipsid
table.sort(temp,function(a,b)
return a.sortWeight>b.sortWeight
end)
local tips=showPrizeControl.getTips(tipsid)

if not _this:checkUseItme(temp)then
showPrizeControl.showWindow(temp,nil,{tips=tips})
end
end
end

function UISubAct_ZMXX_HW_Win:checkUseItme(temp)
local useFlag=false
for KUANGE_HIDE_TYPE,v in pairs(temp)do
local itemid=v.itemid
local itemnum=v.num
local isNew=false
local itemcfg=itemsConfig.getConfig(itemid)
local checkuse=false
local funcparam=itemcfg.funcparam
if funcparam then
local ftype=funcparam.type
if ftype==item_funtion_type.disciple and funcparam.isSpecial==true then
local srctype=itemid
isNew=UIDiscipleModel:findSrcTypeDisciple(srctype)==nil
local itemCount=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if itemCount>=itemnum then
checkuse=true
end
end
end
if isNew then
if not self.newDZIDlist then
self.newDZIDlist={}
end
self.newDZIDlist[#self.newDZIDlist+1]=itemid
if checkuse then
bagProtocolControl.req_use_item(itemid,v.num)
useFlag=true
end
end
end
return useFlag
end

function UISubAct_ZMXX_HW_Win.onItemUse(itemid,num)
if _this==nil then return end
if not _this.newDZIDlist then
return
end
local itemcfg=itemsConfig.getConfig(itemid)
local funcparam=itemcfg.funcparam
if funcparam then
local ftype=funcparam.type
if ftype==item_funtion_type.disciple and funcparam.isSpecial==true then
local dzid=funcparam.discipleid
local removeIndex=nil
for i,v in ipairs(_this.newDZIDlist)do
if v==itemid then
removeIndex=i
break
end
end
if removeIndex then
table.remove(_this.newDZIDlist,removeIndex)
local backArgs={id=JUMP_TYPE.eActivity,args={subType=_this.subType,subid=_this.subid}}
if not UIRecruitControl:checkStartStory(itemid,backArgs)then
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
if not dzData then
dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzid)
end
if dzData and dzData.discipleguid then
UIRecruitControl:showItemRecruitDiscipleWindow(itemid,dzData.discipleguid)
end
end
end

end
end
end

