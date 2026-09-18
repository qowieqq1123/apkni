







def_class("UIFirstRechargeWin3",UIWindowBase)









function UIFirstRechargeWin3:bindComponents()

self.mask=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.confirmBtn=UIButton.get(self,2)
self.infoBtn=UIButton.get(self,3)
self.xiaoren=UIObject.get(self,4)
self.titleImage=UIImage.get(self,5)
self.item_1=UIObject.get(self,6)
self.item_2=UIObject.get(self,7)
self.item_3=UIObject.get(self,8)
self.item_4=UIObject.get(self,9)
self.item_5=UIObject.get(self,10)
self.showModelPanel=UIObject.get(self,11)
self.discipleModelRoot=UIObject.get(self,12)
self.gubaoModelRoot=UIObject.get(self,13)
self.gubaoImage=UIImage.get(self,14)
self.diziPanel=UIObject.get(self,15)
self.selectDiziPanel=UIObject.get(self,16)
self.selectDiziList=UIObject.get(self,17)
self.confirmBtnText=UIText.get(self,18)
self.leftPanel=UIObject.get(self,19)
self.dayBtn_1=UIButton.get(self,20)
self.dayBtn_2=UIButton.get(self,21)
self.dayBtn_3=UIButton.get(self,22)
self.dayBtnList=UIObject.get(self,23)
self.gotFlag=UIObject.get(self,24)
self.timeText=UIText.get(self,25)
self.dayBtnReddot_1=UIObject.get(self,26)
self.dayBtnReddot_2=UIObject.get(self,27)
self.dayBtnReddot_3=UIObject.get(self,28)
self.dayBtnSelect_1=UIObject.get(self,29)
self.dayBtnSelect_2=UIObject.get(self,30)
self.dayBtnSelect_3=UIObject.get(self,31)
self.tabPanel=UIObject.get(self,32)
self.buildingModelRoot=UIObject.get(self,33)
self.specialImageModelRoot=UIImage.get(self,34)
self.specialSpineModelRoot=UIObject.get(self,35)
self.root=UIObject.get(self,36)
self.bgModel=UIObject.get(self,37)
self.clickItemMask=UIButton.get(self,38)
self.dzJJLvBg=UIObject.get(self,39)
self.dzJJLvText=UIText.get(self,40)
self.giftMark_1=UIObject.get(self,41)
self.giftMark_2=UIObject.get(self,42)
self.giftMark_3=UIObject.get(self,43)

self.mask:setButtonClick(function()self:onMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.confirmBtn:setButtonClick(function()self:onConfirmBtn()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.dayBtn_1:setButtonClick(function()self:onDayBtn_1()end)

self.dayBtn_2:setButtonClick(function()self:onDayBtn_2()end)

self.dayBtn_3:setButtonClick(function()self:onDayBtn_3()end)

self.clickItemMask:setButtonClick(function()self:onClickItemMask()end)
self.item={
self.item_1,
self.item_2,
self.item_3,
self.item_4,
self.item_5,
}
self.dayBtn={
self.dayBtn_1,
self.dayBtn_2,
self.dayBtn_3,
}
self.dayBtnReddot={
self.dayBtnReddot_1,
self.dayBtnReddot_2,
self.dayBtnReddot_3,
}
self.dayBtnSelect={
self.dayBtnSelect_1,
self.dayBtnSelect_2,
self.dayBtnSelect_3,
}
self.giftMark={
self.giftMark_1,
self.giftMark_2,
self.giftMark_3,
}



end


function UIFirstRechargeWin3:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.confirmBtn);self.confirmBtn=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.xiaoren);self.xiaoren=nil;
_UIObject_release(self.titleImage);self.titleImage=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
_UIObject_release(self.item_4);self.item_4=nil;
_UIObject_release(self.item_5);self.item_5=nil;
_UIObject_release(self.showModelPanel);self.showModelPanel=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.gubaoModelRoot);self.gubaoModelRoot=nil;
_UIObject_release(self.gubaoImage);self.gubaoImage=nil;
_UIObject_release(self.diziPanel);self.diziPanel=nil;
_UIObject_release(self.selectDiziPanel);self.selectDiziPanel=nil;
_UIObject_release(self.selectDiziList);self.selectDiziList=nil;
_UIObject_release(self.confirmBtnText);self.confirmBtnText=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.dayBtn_1);self.dayBtn_1=nil;
_UIObject_release(self.dayBtn_2);self.dayBtn_2=nil;
_UIObject_release(self.dayBtn_3);self.dayBtn_3=nil;
_UIObject_release(self.dayBtnList);self.dayBtnList=nil;
_UIObject_release(self.gotFlag);self.gotFlag=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.dayBtnReddot_1);self.dayBtnReddot_1=nil;
_UIObject_release(self.dayBtnReddot_2);self.dayBtnReddot_2=nil;
_UIObject_release(self.dayBtnReddot_3);self.dayBtnReddot_3=nil;
_UIObject_release(self.dayBtnSelect_1);self.dayBtnSelect_1=nil;
_UIObject_release(self.dayBtnSelect_2);self.dayBtnSelect_2=nil;
_UIObject_release(self.dayBtnSelect_3);self.dayBtnSelect_3=nil;
_UIObject_release(self.tabPanel);self.tabPanel=nil;
_UIObject_release(self.buildingModelRoot);self.buildingModelRoot=nil;
_UIObject_release(self.specialImageModelRoot);self.specialImageModelRoot=nil;
_UIObject_release(self.specialSpineModelRoot);self.specialSpineModelRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.clickItemMask);self.clickItemMask=nil;
_UIObject_release(self.dzJJLvBg);self.dzJJLvBg=nil;
_UIObject_release(self.dzJJLvText);self.dzJJLvText=nil;
_UIObject_release(self.giftMark_1);self.giftMark_1=nil;
_UIObject_release(self.giftMark_2);self.giftMark_2=nil;
_UIObject_release(self.giftMark_3);self.giftMark_3=nil;
self.item=nil;
self.dayBtn=nil;
self.dayBtnReddot=nil;
self.dayBtnSelect=nil;
self.giftMark=nil;
end

















local tabCmpIndex=
{
select=0,
reddot=1,
clicker=2,
nameIcon=3,
}
local selectDiziItemCmpIndex=
{
select=0,
head=1,
clicker=2,
}
local _this

local _showModelType={
eItem=1,
eBuilding=2,
eSpecialImage=3,
eSpecialSpine=4,
}




function UIFirstRechargeWin3:onLoaded(...)
_this=self
self:bindComponents()
end


function UIFirstRechargeWin3:__delete()
if self.isImageFloat then
self:doLocalMoveY(false)
end
_this=nil
self:clearTimer()
self:clearModelTween()
self:unbindComponents()
self.dayIndex=nil
self.rechargeId=nil
self.firstRechargeData=nil
end




function UIFirstRechargeWin3:onShow(argtable,afterOnloaded)
self.allCfg=firstRecharge3Model:getSortCfgList()
self.selectIndex=1
if argtable and argtable.id then
self.selectIndex=argtable.id
end
if argtable and argtable.dayIndex then
self.dayIndex=argtable.dayIndex
end




self.tabList=firstRecharge3Model:getShowTabList()

self:showBgModel()

self:selectTab(self.selectIndex,self.dayIndex)
end


function UIFirstRechargeWin3:onHide()
if self.isImageFloat then
self:doLocalMoveY(false)
end
end



function UIFirstRechargeWin3:showBgModel()


self.root:setChildCanvasGroupAlpha(0)
local bgModelId=4028
local bgOffset={25,-15}

self.bgModel:setChildUIModelShowTarget(bgModelId,1,nil,eAnimationID.enter,false,false,0,function()
self:finishLoadBgModel(false)
end)
self.bgModel:setChildUIModelShowTargetOffset(bgOffset[1],bgOffset[2])
end

function UIFirstRechargeWin3:finishLoadBgModel(isFront)
self:delayDo(0.2,function()

self.root:setChildCanvasGroupDOFade(1,0.5)
end)
end


function UIFirstRechargeWin3:selectTab(selectIndex,dayIndex)
self.selectIndex=selectIndex
if not self.tabList[selectIndex]then
if not self.tabList or next(self.tabList)then
logErr(FMT.fmt("价格档位列表没未初始化 选择档位索引：{0}，天数索引：{1}",selectIndex,dayIndex))
else
local tabCount=#self.tabList
logErr(FMT.fmt("找不到对应索引的价格档位 选择档位索引：{0}，天数索引：{1}，当前价格档位数量：{2}",selectIndex,dayIndex,tabCount))
end
return
end
self.rechargeId=self.tabList[selectIndex].rechargeId
self.czCfg=cfgHelper.get(cfg_rechargeconfig_get,self.rechargeId)
self.frCfg=cfgHelper.get1(cfg_firstcharge3config_get,self.rechargeId)
self.dayCount=self.tabList[selectIndex].dayCount
if not firstRecharge3Model:getFirstRechargePageOpenFlagByRechargeId(self.rechargeId)then
firstRecharge3Model:setFirstRechargePageOpenFlagByRechargeId(self.rechargeId)
if self.frCfg and self.frCfg.show_condition~=nil then

firstRecharge3Controller:refreshEnterObjReddot()
end
end

self.firstRechargeData=firstRecharge3Model:getFirstRechargeDataByRechargeId(self.rechargeId)
if not dayIndex then
local _,canGetDayIndex=firstRecharge3Model:checkReddotById(self.rechargeId)
self.dayIndex=canGetDayIndex
else
self.dayIndex=dayIndex
end
self:refresh(true)
end


function UIFirstRechargeWin3:selectDizi(selectIndex)
self.selectDiziIndex=selectIndex

self:refreshSelectDiziPanel()

self:refreshDiziPanel()
end

function UIFirstRechargeWin3:refresh(isChangePage)
self:refreshTabPanel()
self:refreshLeftPanel(isChangePage)
self:refreshRightPanel()
end


function UIFirstRechargeWin3:refreshTab()

self.tabList=firstRecharge3Model:getShowTabList()
self:selectTab(self.selectIndex)
end


function UIFirstRechargeWin3:refreshTabPanel()


local grids=self.tabPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local tabData=self.tabList[i]
if tabData then
item:SetChildActive(-1,true)
item:SetChildActive(tabCmpIndex.select,i==self.selectIndex)





local showParamIdList=tabData.cfg.showParamId
local showParamId=pfwindowsModel:getVersionAndPfCfg(showParamIdList)
local showParamCfg=cfgHelper.get1(cfg_firstrecharge3showparamconfig_get,showParamId)
local tabIconName=showParamCfg.tabIconName
if tabIconName then
local abName="ui/windows/firstrecharge/firstrechargetabicon_atlas_pak.ab"
item:SetChildCSImageSprite(tabCmpIndex.nameIcon,abName,tabIconName)
end

local reddot=firstRecharge3Model:checkReddotById(tabData.rechargeId)
item:SetChildActive(tabCmpIndex.reddot,reddot)


item:SetChildButtonClick(tabCmpIndex.clicker,function()
if _this==nil then return end
_this:onClickTab(i)
end)
else
item:SetChildActive(-1,false)
end


end
end

function UIFirstRechargeWin3:refreshLeftPanel(isChangePage)
local showParamIdList=self.frCfg.showParamId
local showParamId=pfwindowsModel:getVersionAndPfCfg(showParamIdList)
local showParamCfg=cfgHelper.get1(cfg_firstrecharge3showparamconfig_get,showParamId)
self.showModelType=showParamCfg.show_model and showParamCfg.show_model[self.dayIndex][1]or nil
self.showModelPram=showParamCfg.show_model and showParamCfg.show_model[self.dayIndex][2]or nil

if not self.showModelType or not self.showModelPram then

self.leftPanel:setActive(false)
self.showModelPanel:setActive(false)
return
end


self.leftPanel:setActive(true)
self.showModelPanel:setActive(true)

self.clickItemMask:setActive(false)
self.clickItemId=nil

if self.showModelType==_showModelType.eItem then

self.buildingModelRoot:setActive(false)
self.specialImageModelRoot:setActive(false)
self.specialSpineModelRoot:setActive(false)

self:showItemModel(isChangePage)
elseif self.showModelType==_showModelType.eBuilding then

self.diziPanel:setActive(false)
self.discipleModelRoot:setActive(false)
self.gubaoModelRoot:setActive(false)
self.specialImageModelRoot:setActive(false)
self.specialSpineModelRoot:setActive(false)
self:doLocalMoveY(false)

self:showBuildingModel()
elseif self.showModelType==_showModelType.eSpecialImage then

self.diziPanel:setActive(false)
self.discipleModelRoot:setActive(false)
self.gubaoModelRoot:setActive(false)
self.specialSpineModelRoot:setActive(false)
self:doLocalMoveY(false)
self.buildingModelRoot:setActive(false)

self:showSpecialImageModel()
elseif self.showModelType==_showModelType.eSpecialSpine then

self.diziPanel:setActive(false)
self.discipleModelRoot:setActive(false)
self.gubaoModelRoot:setActive(false)
self:doLocalMoveY(false)
self.buildingModelRoot:setActive(false)
self.specialImageModelRoot:setActive(false)

self:showSpecialSpineModel()
else
logErr(FMT.fmt("找不到展示模型类型: {0} 请检查配置是否正确",self.showModelType))
end
end


function UIFirstRechargeWin3:showItemModel(isChangePage)

local hasShowType=false
local showModelItemId=self.showModelPram.itemid
local showItemType=itemsConfig.getMainType(showModelItemId)

if showItemType==ITEM_MAIN_TYPE.eGubao then

hasShowType=true

self.diziPanel:setActive(false)
self.discipleModelRoot:setActive(false)
self.gubaoModelRoot:setActive(true)

self:refreshGubaoPanel()
elseif showItemType==ITEM_MAIN_TYPE.eItem then

local isDiscipleItem=false
local isSelectDiscipleItem=false
local funcparam=itemsConfig.getConfig(showModelItemId).funcparam
if funcparam then
local ftype=funcparam.type
if ftype==item_funtion_type.disciple then
if funcparam.isSpecial then
isDiscipleItem=true
end
elseif ftype==item_funtion_type.selectDisciple then
isSelectDiscipleItem=true
end
end
if isDiscipleItem then

hasShowType=true

self.diziPanel:setActive(true)
self.discipleModelRoot:setActive(true)
self.gubaoModelRoot:setActive(false)


self.selectDiziPanel:setActive(false)

if self.showModelPram.isShowJJ then
if self.showModelPram.showJJZmlv then
local minLv=self.showModelPram.showJJZmlv[1]
local maxLv=self.showModelPram.showJJZmlv[2]
local zmLv=zongmenModel:getLevel()
if maxLv then
self.isShowJJLv=zmLv>=minLv and zmLv<=maxLv
else
self.isShowJJLv=zmLv>=minLv
end
else
self.isShowJJLv=true
end
else
self.isShowJJLv=false
end
self:doLocalMoveY(false)
self:refreshDiziPanel()
elseif isSelectDiscipleItem then

hasShowType=true

self.diziPanel:setActive(true)
self.discipleModelRoot:setActive(true)
self.gubaoModelRoot:setActive(false)


self.selectDiziPanel:setActive(true)
if isChangePage then

self.selectDiziIndex=1
end

self.isShowJJLv=false
self:doLocalMoveY(false)
self:refreshSelectDiziPanel()
self:refreshDiziPanel()
end
end

if not hasShowType then
logErr('前端代码中并未对传入的道具类型做展示效果')

self.leftPanel:setActive(false)
self.showModelPanel:setActive(false)
self:doLocalMoveY(false)
end
end


function UIFirstRechargeWin3:showBuildingModel()
local bdId=self.showModelPram.bdid
local size=self.showModelPram.size or 1
local offset=self.showModelPram.offset or{0,0}
local clickItemId=self.showModelPram.clickItemId

local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
if bdcfg then





local model=bdcfg.model[1]
self.buildingModelRoot:setChildUIModelShowTarget(model,size,nil,eAnimationID.stand)
self.buildingModelRoot:setChildUIModelShowTargetOffset(offset[1],offset[2])
self.buildingModelRoot:setActive(true)
else
self.buildingModelRoot:setActive(false)
logErr(FMT.fmt("找不到建筑id:{0} 对应的建筑配置",bdId))
end

if clickItemId then
self.clickItemMask:setActive(true)
self.clickItemId=clickItemId
end
end


function UIFirstRechargeWin3:showSpecialImageModel()
local abName=self.showModelPram.abName
local imageName=self.showModelPram.imageName
local size=self.showModelPram.size or 1
local offset=self.showModelPram.offset or{0,0}
self.specialImageModelRoot:setSprite(abName,imageName)
self.specialImageModelRoot:setScale(Vector3.New(size,size,size))
self.specialImageModelRoot:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))
self.specialImageModelRoot:setActive(true)
end


function UIFirstRechargeWin3:showSpecialSpineModel()
local modelId=self.showModelPram.modelid
local anim=self.showModelPram.anim or eAnimationID.stand
local size=self.showModelPram.size or 1
local offset=self.showModelPram.offset or{0,0}

self.specialSpineModelRoot:setChildUIModelShowTarget(modelId,size,nil,anim)
self.specialSpineModelRoot:setChildUIModelShowTargetOffset(offset[1],offset[2])
self.specialSpineModelRoot:setActive(true)
end


function UIFirstRechargeWin3:refreshDiziPanel()
local showModelItemId=self.showModelPram.itemid
local modelOffset=self.showModelPram.offset
local data=UIDiscipleModel:getItemDiscipleDataByItemId(showModelItemId,self.selectDiziIndex)
if not data then
return
end
if not data.hasFixedImage then

logErr(FMT.fmt("展示弟子道具 {0} 对应的弟子id: {1} 没有配置固定组件库 无法加载形象",showModelItemId,data.id))
return
end

local info=data.imageInfo
if info then


self.discipleModelRoot:setChildUIModelRemoveTarget()
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)
local modelOffset_X=modelOffset and modelOffset[1]or 0
local modelOffset_Y=modelOffset and modelOffset[2]or 0
comHelper.setChildInSideModelEx(self.discipleModelRoot,modelParams,0.8,nil,modelOffset_X,modelOffset_Y,false,true)
self:doModelFadeIn()


self.xiaoren:setChildUIModelRemoveTarget()
modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
self.xiaoren:setChildUIModelShowTarget(modelParams.body,0.9,modelParams.componets,eAnimationID.stand,false,false,0.5)
self.xiaoren:setChildUIModelShowTargetOffset(0,0)

self.xiaoren:setChildUIModelShowFlipX(false)
end

self.dzJJLvBg:setActive(self.isShowJJLv)
if self.isShowJJLv then
local jjlv=data.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local str_1=''
if p~=nil then
str_1=FMT.fmt('{0}{1}',n,pN)
else
str_1=n
end
self.dzJJLvText:setText(str_1)
end
end

function UIFirstRechargeWin3:refreshGubaoPanel()
local showModelItemId=self.showModelPram.itemid
local gbId=gubaoLookup:good2GuBao(showModelItemId)
local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbId)


self.gubaoImage:setImageIcon(gubaoModel:getGuBaoBigIconName(gbCfg.icon),false)


self:doLocalMoveY(true)
end


function UIFirstRechargeWin3:refreshSelectDiziPanel()
if not self.selectDiziIndex then

self.selectDiziIndex=1
end

local showModelItemId=self.showModelPram.itemid

local grids=self.selectDiziList:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local diziData=UIDiscipleModel:getItemDiscipleDataByItemId(showModelItemId,i)
if diziData then
local info=diziData.imageInfo
item:SetChildActive(-1,true)
item:SetChildActive(selectDiziItemCmpIndex.select,i==self.selectDiziIndex)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)

comHelper.setChildModelRawImageEx(selectDiziItemCmpIndex.head,item,modelParams,eHeadCenterType.eHead)


item:SetChildButtonClick(selectDiziItemCmpIndex.clicker,function()
if _this==nil then return end
_this:onClickSelectDiziItem(i)
end)
else
item:SetChildActive(-1,false)
end
end
end

function UIFirstRechargeWin3:refreshRightPanel()

local widget

local rewardsAllCfg=self.frCfg.rewards
local rewardsCfg=pfwindowsModel:getVersionAndPfCfg(rewardsAllCfg)
local rewardList=rewardsCfg[self.dayIndex]
for i,item in ipairs(self.item)do
if rewardList[i]then
item:setActive(true)
widget=item:getWidgetBase()
local data=rewardList[i]
widgetHelper.setNormalRewardItem(widget,-1,data)
widget:SetChildButtonClick(3,function()
self:onRewardItemClick(data[1],i)
end)
else
item:setActive(false)
end
end












local showParamIdList=self.frCfg.showParamId
local showParamId=pfwindowsModel:getVersionAndPfCfg(showParamIdList)
local showParamCfg=cfgHelper.get1(cfg_firstrecharge3showparamconfig_get,showParamId)
local titleImageName=showParamCfg.titleImageName
if titleImageName then
local abName="ui/windows/firstrecharge/firstrechargetitleimage_atlas_pak.ab"
self.titleImage:setSprite(abName,titleImageName)
end


local dayCount=self.tabList[self.selectIndex].dayCount
if dayCount>1 then

self.dayBtnList:setActive(true)


for i,dayBtn in ipairs(self.dayBtn)do
if i<=dayCount then

dayBtn:setActive(true)
local btnSelect=self.dayBtnSelect[i]
if self.dayIndex==i then

btnSelect:setActive(true)
else

btnSelect:setActive(false)
end
else

dayBtn:setActive(false)
end
end

else

self.dayBtnList:setActive(false)
end


self:refreshBottomPanel()

end


function UIFirstRechargeWin3:refreshBottomPanel()

self:clearTimer()


self:refreshDayBtnReddot()

local isNeedTimer=false
self.nextRefreshTime=firstRecharge3Model:getNextRefreshTime()
if self.nextRefreshTime then
isNeedTimer=true
end


local isBought=firstRecharge3Model:checkIsBought(self.rechargeId)

if not isBought then

self.confirmBtn:setActive(true)

self.gotFlag:setActive(false)

self.timeText:setActive(false)


self.confirmBtn:setButtonClick(function()self:onConfirmBtn(true)end)


local str=pfwindowslController:showDesc_ByMoneyType(self.czCfg)
self.confirmBtnText:setText(str)
else

local isGot=firstRecharge3Model:checkIsGotFirstRechargeRewardByIdAndDay(self.rechargeId,self.dayIndex)

self.gotFlag:setActive(isGot)

if isGot then

self.confirmBtn:setActive(false)

self.timeText:setActive(false)
else

local nowTime=gameUtilityModel.getServerLongTime()
self.canGetRewardTime=firstRecharge3Model:getCanGetRewardTimeByIdAndDay(self.rechargeId,self.dayIndex)

local canGet=self.canGetRewardTime-nowTime<=0


self.confirmBtn:setActive(canGet)

self.timeText:setActive(not canGet)

if canGet then

self.confirmBtn:setButtonClick(function()self:onConfirmBtn(false)end)

self.confirmBtnText:setText("领取")

self.canGetRewardTime=nil
else

self.timeText:setActive(true)

isNeedTimer=true
end
end
end

if isNeedTimer then
self:setRemainingTimeTimer()
end
end





function UIFirstRechargeWin3:onMask()
end



function UIFirstRechargeWin3:onCloseBtn()
self:closeSelf()
end



function UIFirstRechargeWin3:onConfirmBtn(isBought)
if isBought then

payControl.reqPay(self.rechargeId)
else

firstRecharge3Controller:reqGetFirstRechargeReward(self.rechargeId,self.dayIndex)
if pfwindowslController:checkIsGameVersion_yuenan()then
pfwindowslController:checkHaoPingReward()
end
end
end



function UIFirstRechargeWin3:onInfoBtn()
local showModelItemId=self.showModelPram.itemid
UIRecruitControl:showItemDiscipleInfoByItemId2(showModelItemId,self.selectDiziIndex)
end



function UIFirstRechargeWin3:onDayBtn_1()
self:onDayBtnClick(1)
end



function UIFirstRechargeWin3:onDayBtn_2()
self:onDayBtnClick(2)
end



function UIFirstRechargeWin3:onDayBtn_3()
self:onDayBtnClick(3)
end



function UIFirstRechargeWin3:onClickItemMask()
tipsManager.showTips({itemid=self.clickItemId,move=TIPS_MOVE_POS.eRight})
end

function UIFirstRechargeWin3:onDayBtnClick(day,isForceRefresh)

if self.dayIndex~=day or isForceRefresh then
self.dayIndex=day
self:refresh(true)
end
end

function UIFirstRechargeWin3:onRewardItemClick(itemId,itemIndex)
if itemId==-1 then
return
end

tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end


function UIFirstRechargeWin3:onClickTab(index)
if index==self.selectIndex then
return
end

self:selectTab(index)
end


function UIFirstRechargeWin3:onClickSelectDiziItem(index)
if index==self.selectDiziIndex then
return
end

self:selectDizi(index)
end


function UIFirstRechargeWin3:doLocalMoveY(isFloat)
if isFloat then
if self.floatTweener==nil then
self.gubaoImage:setLocalPosY(0)
local tweener=self.gubaoImage:setChildDOLocalMoveY(20.0,2)
tweener:SetEase(_Ease.InOutSine)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.floatTweener=tweener

self.isImageFloat=true
end
else
if self.floatTweener~=nil then
self.floatTweener:Complete()
self.floatTweener:Kill()
self.floatTweener=nil
self.gubaoImage:setLocalPosY(0)
self.isImageFloat=nil
end
end
end


function UIFirstRechargeWin3:setRemainingTimeTimer()
self:clearTimer()

local func=function()
local nowTime=gameUtilityModel.getServerLongTime()
local lerp=self.nextRefreshTime-nowTime
if lerp<=0 then

self:refresh()
return
end

if self.canGetRewardTime then
lerp=self.canGetRewardTime-nowTime
if lerp>0 then
local timeStr=nil
if lerp<3600 then

timeStr=timeHelper.formatSimpleTime(lerp)
else

timeStr=timeHelper.format_time_stamp11(lerp,true)
end

self.timeText:setText(FMT.fmt("<color=#549327>{0}</color>后可领取",timeStr))
else

self:refresh()
end
end

end

self.timer=self:setTimer(1,0,func)

func()
end


function UIFirstRechargeWin3:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end


function UIFirstRechargeWin3:refreshDayBtnReddot()
local nowTime=gameUtilityModel.getServerLongTime()
for i,reddot in ipairs(self.dayBtnReddot)do
local reddotFlag=false
if i<=self.dayCount then

if not firstRecharge3Model:checkIsGotFirstRechargeRewardByIdAndDay(self.rechargeId,i)then

local targetTime=firstRecharge3Model:getCanGetRewardTimeByIdAndDay(self.rechargeId,i)
if targetTime and targetTime-nowTime<=0 then

reddotFlag=true
end
end
end
reddot:setActive(reddotFlag)
local giftMark=self.giftMark[i]
if i>1 then
giftMark:setActive(not reddotFlag)
else
giftMark:setActive(false)
end
end
end

function UIFirstRechargeWin3:doModelFadeIn()
self:clearModelTween()
self.discipleModelRoot:setChildCanvasGroupAlpha(0)

self.modelTween=self.discipleModelRoot:setChildCanvasGroupDOFade(1,0.5,function()
self:clearModelTween()
end)
end

function UIFirstRechargeWin3:clearModelTween()
if self.modelTween~=nil then
self.modelTween:Kill()
self.modelTween=nil
end
end