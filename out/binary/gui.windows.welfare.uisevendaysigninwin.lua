







def_class("UISevenDaySignInWin",UIWindowBase)









function UISevenDaySignInWin:bindComponents()

self.finalRewardImage=UIImage.get(self,0)
self.gubaoModelRoot=UIObject.get(self,1)
self.buildingModelRoot=UIObject.get(self,2)
self.signInList=UIObject.get(self,3)
self.rightPanel=UIObject.get(self,4)
self.signInItem_1=UIObject.get(self,5)
self.signInItem_2=UIObject.get(self,6)
self.signInItem_3=UIObject.get(self,7)
self.signInItem_4=UIObject.get(self,8)
self.signInItem_5=UIObject.get(self,9)
self.signInItem_6=UIObject.get(self,10)
self.signInItem_7=UIObject.get(self,11)
self.progress=UIObject.get(self,12)
self.bgMask=UIObject.get(self,13)
self.finalRewardClick=UIButton.get(self,14)
self.specialImageModelRoot=UIImage.get(self,15)
self.model_he=UIObject.get(self,16)
self.previewRoot=UIObject.get(self,17)
self.previewInfoImg=UIObject.get(self,18)

self.finalRewardClick:setButtonClick(function()self:onFinalRewardClick()end)
self.signInItem={
self.signInItem_1,
self.signInItem_2,
self.signInItem_3,
self.signInItem_4,
self.signInItem_5,
self.signInItem_6,
self.signInItem_7,
}
self.model={
["he"]=self.model_he,
}



end


function UISevenDaySignInWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.finalRewardImage);self.finalRewardImage=nil;
_UIObject_release(self.gubaoModelRoot);self.gubaoModelRoot=nil;
_UIObject_release(self.buildingModelRoot);self.buildingModelRoot=nil;
_UIObject_release(self.signInList);self.signInList=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.signInItem_1);self.signInItem_1=nil;
_UIObject_release(self.signInItem_2);self.signInItem_2=nil;
_UIObject_release(self.signInItem_3);self.signInItem_3=nil;
_UIObject_release(self.signInItem_4);self.signInItem_4=nil;
_UIObject_release(self.signInItem_5);self.signInItem_5=nil;
_UIObject_release(self.signInItem_6);self.signInItem_6=nil;
_UIObject_release(self.signInItem_7);self.signInItem_7=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.bgMask);self.bgMask=nil;
_UIObject_release(self.finalRewardClick);self.finalRewardClick=nil;
_UIObject_release(self.specialImageModelRoot);self.specialImageModelRoot=nil;
_UIObject_release(self.model_he);self.model_he=nil;
_UIObject_release(self.previewRoot);self.previewRoot=nil;
_UIObject_release(self.previewInfoImg);self.previewInfoImg=nil;
self.signInItem=nil;
self.model=nil;
end
















local ItemCompentIndex={
dayText=0,
gotFlag=1,
select=2,
click=3,
point=4,
trick=5,
bg=6,
item_1=7,
sign=8,
}
local showModelType={
eGubao=1,
eBuilding=2,
eSpecialImage=3,
}




function UISevenDaySignInWin:onLoaded(...)
self:bindComponents()
end


function UISevenDaySignInWin:__delete()

self:unbindComponents()
end




function UISevenDaySignInWin:onShow(argtable,afterOnloaded)
self:onShowArgRecv()
end


function UISevenDaySignInWin:onHide()

end


function UISevenDaySignInWin:onShowArgRecv()

local modelId=4087
self.model_he:setChildUIModelShowTarget(modelId,1,{},eAnimationID.enter,false,false,0,nil)

self:refresh()
end

function UISevenDaySignInWin:refresh()
self.signInData=welfareModel:getSevenDaySignInData()
if not self.signInData or next(self.signInData)==nil then
welfareController:reqSevenDaySignInData()
return
end
self.signInCfg=cfg_sevendayqiandaoconfig()

self:refreshSignInList()

self:refreshRightPanel()
end

function UISevenDaySignInWin:refreshSignInList()
for i=1,#self.signInItem do
if self.signInCfg[i]then
local signInItem=self.signInItem[i]:getWidgetBase()
local reward=self.signInCfg[i].rewards
if signInItem and reward then

local isSignIn=self.signInData.signInDayList[i]and self.signInData.signInDayList[i].rewardFlag==0

signInItem:SetChildActive(ItemCompentIndex.select,isSignIn)

local isGot=self.signInData.signInDayList[i]and self.signInData.signInDayList[i].rewardFlag==1

signInItem:SetChildActive(ItemCompentIndex.gotFlag,isGot)


signInItem:SetChildActive(ItemCompentIndex.point,isSignIn or isGot)
signInItem:SetChildActive(ItemCompentIndex.trick,isGot)


signInItem:SetChildImageExGray(ItemCompentIndex.bg,isGot)

for j=1,#reward do
local itemid=reward[j][1]
local count=reward[j][2]

local countStr=''
local showCountBG=false
if count>1 then
showCountBG=true
countStr=mathHelper.formatNumber(count)
end

local conf
if isGot then

conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=1}
else
conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG}
end

local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
signInItem:SetChildActive(ItemCompentIndex.item_1+j-1,true)
signInItem:SetChildPropData(ItemCompentIndex.item_1+j-1,prop)

local rewardItem=signInItem:GetChildWidgetBase(ItemCompentIndex.item_1+j-1)
if isSignIn then

rewardItem:SetChildButtonClick(1,function()
self:onClickSignInItem(i)
end)
else

rewardItem:SetChildButtonClick(1,function()
self:onClickSignInRewardItem(itemid)
end)
end

rewardItem:SetChildLongTouch(1,i,0.5,function()
self:onClickSignInRewardItem(itemid)
end)
end
signInItem:SetChildActive(ItemCompentIndex.sign,self.signInCfg[i].slotsign~=nil)
if self.signInCfg[i].slotsign~=nil then
signInItem:SetChildCSImageSprite(ItemCompentIndex.sign,self.signInCfg[i].slotsign[1],self.signInCfg[i].slotsign[2])
end







end






























end
end


local progressPercent
if self.signInData.signInDayListLen<7 then
progressPercent=self.signInData.signInDayListLen/8
else
progressPercent=1
end
self.progress:setChildIconFillAmount(progressPercent)

end

function UISevenDaySignInWin:refreshRightPanel()

local showItemConfig
if self.signInData.signInDayListLen and self.signInData.signInDayListLen>0 then
showItemConfig=self.signInCfg[self.signInData.signInDayListLen].showModel
end
if not showItemConfig then

self.rightPanel:setActive(false)

self:doLocalMoveY(false)

self.bgMask:setActive(true)
return
end


self.bgMask:setActive(false)

self.rightPanel:setActive(true)


local showItemType=showItemConfig[1]
local showItemPram=showItemConfig[2]
if showItemType==showModelType.eGubao then

self.gubaoModelRoot:setActive(true)

self.buildingModelRoot:setActive(false)
self.specialImageModelRoot:setActive(false)

local gubaoItemId=showItemPram
local gbId=gubaoLookup:good2GuBao(gubaoItemId)
local gbCfg=cfgHelper.get1(cfg_gubaoconfig_get,gbId)


self.finalRewardImage:setImageIcon(gubaoModel:getGuBaoBigIconName(gbCfg.icon),false)


self:doLocalMoveY(true)

elseif showItemType==showModelType.eBuilding then

self.buildingModelRoot:setActive(true)

self.specialImageModelRoot:setActive(false)
self.gubaoModelRoot:setActive(false)
self:doLocalMoveY(false)

local bdId=showItemPram.bdid
local size=showItemPram.size or 1
local offset=showItemPram.offset or{0,0}
local animId=showItemPram.anim or eAnimationID.bd_stand
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
if bdcfg then
local model=bdcfg.model[1]
self.buildingModelRoot:setChildUIModelShowTarget(model,size,nil,animId)
self.buildingModelRoot:setChildUIModelShowTargetOffset(offset[1],offset[2])
self.buildingModelRoot:setActive(true)
else
self.buildingModelRoot:setActive(false)
logErr(FMT.fmt("找不到建筑id:{0} 对应的建筑配置",bdId))
end

elseif showItemType==showModelType.eSpecialImage then

self.specialImageModelRoot:setActive(true)

self.buildingModelRoot:setActive(false)
self.gubaoModelRoot:setActive(false)
self:doLocalMoveY(false)

self:showSpecialImageModel(showItemPram)
local viewcfg=self.signInCfg[self.signInData.signInDayListLen].previewimg
self.previewInfoImg:setCSImageSprite(viewcfg[1],viewcfg[2])
else
logErr(FMT.fmt("找不到展示类型: {0} 请检查配置是否正确",showItemType))
return
end


local previewShowState=true
local cfg=self.signInCfg[self.signInData.signInDayListLen+1]
local previewInfo=cfg and cfg.previewimg
for k,v in pairs(self.signInData.signInDayList)do
if v.rewardFlag==0 then
previewShowState=false
break
end
end
previewShowState=previewShowState and(previewInfo~=nil)
self.previewRoot:setActive(previewShowState or self.signInData.signInDayListLen==1)
if previewShowState then
self.previewInfoImg:setCSImageSprite(previewInfo[1],previewInfo[2])
if showItemType==showModelType.eSpecialImage and cfg.showModel[2]then
self:showSpecialImageModel(cfg.showModel[2])
end
end
end


function UISevenDaySignInWin:showSpecialImageModel(showModelPram)
if not showModelPram or not next(showModelPram)then
logErr("找不到对应的展示参数 请检查配置是否正确")
return
end

local abName=showModelPram.abName
local imageName=showModelPram.imageName
local size=showModelPram.size or 1
local offset=showModelPram.offset or{0,0}
self.specialImageModelRoot:setSprite(abName,imageName)
self.specialImageModelRoot:setScale(Vector3.New(size,size,size))
self.specialImageModelRoot:setChildAnchoredPosition(Vector2.New(offset[1],offset[2]))
self.specialImageModelRoot:setActive(true)
end


function UISevenDaySignInWin:onClickSignInItem(index)

if self.signInData.signInDayList[index]then
if self.signInData.signInDayList[index].rewardFlag==1 then
if index==self.signInData.signInDayListLen then
if self.signInData.signInDayListLen==7 then
UIManager.info('您已完成七日签到')
else
UIManager.info('今天已领取签到奖励，请明天再来')
end
else
UIManager.info('您已领取过此签到奖励了')
end

elseif self.signInData.signInDayList[index].rewardFlag==0 then
welfareController:reqSevenDaySignInGetReward()
end
else
UIManager.error('未达到签到天数')
end
end

function UISevenDaySignInWin:onClickSignInRewardItem(itemid)
tipsManager.showTips({itemid=itemid,itemguid=nil,showModel=true})
end


function UISevenDaySignInWin:doLocalMoveY(isFloat)
if isFloat then
if self.floatTweener==nil then
self.finalRewardImage:setLocalPosY(0)
local tweener=self.finalRewardImage:setChildDOLocalMoveY(10.0,1.5)
tweener:SetEase(_Ease.InOutSine)
tweener:SetLoops(-1,_LoopType.Yoyo)
self.floatTweener=tweener
end
else
if self.floatTweener~=nil then
self.floatTweener:Complete()
self.floatTweener:Kill()
self.floatTweener=nil
self.finalRewardImage:setLocalPosY(0)
end
end
end

function UISevenDaySignInWin:checkTodayReceived()

end

