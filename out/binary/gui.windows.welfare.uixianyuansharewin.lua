







def_class("UIXianYuanShareWin",UIWindowBase)









function UIXianYuanShareWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.wheel=UIObject.get(self,1)
self.shareBtn=UIButton.get(self,2)
self.titleImg=UIImage.get(self,3)
self.rotationBtn=UIButton.get(self,4)
self.catTalk=UIObject.get(self,5)
self.catModel=UIObject.get(self,6)
self.tipsPanel=UIObject.get(self,7)
self.shareReddot=UIObject.get(self,8)
self.reddot=UIObject.get(self,9)
self.numTx=UIText.get(self,10)
self.tipsTx=UILinkImageText.get(self,11)
self.hightlight_6=UIObject.get(self,12)
self.item_6=UIObject.get(self,13)
self.hightlight_8=UIObject.get(self,14)
self.item_8=UIObject.get(self,15)
self.hightlight_1=UIObject.get(self,16)
self.item_1=UIObject.get(self,17)
self.item_4=UIObject.get(self,18)
self.hightlight_4=UIObject.get(self,19)
self.item_2=UIObject.get(self,20)
self.hightlight_2=UIObject.get(self,21)
self.item_3=UIObject.get(self,22)
self.hightlight_3=UIObject.get(self,23)
self.hightlight_5=UIObject.get(self,24)
self.item_5=UIObject.get(self,25)
self.hightlight_7=UIObject.get(self,26)
self.item_7=UIObject.get(self,27)
self.catTalkDesc=UIText.get(self,28)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.rotationBtn:setButtonClick(function()self:onRotationBtn()end)
self.hightlight={
self.hightlight_1,
self.hightlight_2,
self.hightlight_3,
self.hightlight_4,
self.hightlight_5,
self.hightlight_6,
self.hightlight_7,
self.hightlight_8,
}
self.item={
self.item_1,
self.item_2,
self.item_3,
self.item_4,
self.item_5,
self.item_6,
self.item_7,
self.item_8,
}



end


function UIXianYuanShareWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.wheel);self.wheel=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.titleImg);self.titleImg=nil;
_UIObject_release(self.rotationBtn);self.rotationBtn=nil;
_UIObject_release(self.catTalk);self.catTalk=nil;
_UIObject_release(self.catModel);self.catModel=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.shareReddot);self.shareReddot=nil;
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.numTx);self.numTx=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.hightlight_6);self.hightlight_6=nil;
_UIObject_release(self.item_6);self.item_6=nil;
_UIObject_release(self.hightlight_8);self.hightlight_8=nil;
_UIObject_release(self.item_8);self.item_8=nil;
_UIObject_release(self.hightlight_1);self.hightlight_1=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_4);self.item_4=nil;
_UIObject_release(self.hightlight_4);self.hightlight_4=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.hightlight_2);self.hightlight_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
_UIObject_release(self.hightlight_3);self.hightlight_3=nil;
_UIObject_release(self.hightlight_5);self.hightlight_5=nil;
_UIObject_release(self.item_5);self.item_5=nil;
_UIObject_release(self.hightlight_7);self.hightlight_7=nil;
_UIObject_release(self.item_7);self.item_7=nil;
_UIObject_release(self.catTalkDesc);self.catTalkDesc=nil;
self.hightlight=nil;
self.item=nil;
end















local _this=nil
local _itemCmp={
item=0,
getted=1,
xi=2,
}



function UIXianYuanShareWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianYuanShareWin:__delete()
self:unbindComponents()
_this=nil
if self.tween and self.tween:IsActive()then
self.tween:Kill()
end
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
end
end




function UIXianYuanShareWin:onShow(argtable,afterOnloaded)
if not xianyuanShareModel:isInit()then
UIManager.info('功能已关闭')
UIFullWelfareController:closeUI(true,true)
return
end

if afterOnloaded then
self.index=1
self:refreshWheelRewards()
self:initCat()
self:initTips()
end

self.wheel:setRotation(0,0,0)
self:resetItemsRotation()
self:refreshTimes()
self:refreshTips()

self:resetItemHightLight()
self:refreshReddot()

end


function UIXianYuanShareWin:onHide()
if self.index then
self.hightlight[self.index]:setActive(false)
end
end





function UIXianYuanShareWin:onRotationBtn()
if not self.tween then
if xianyuanShareModel:getValibTimes()>0 then
xianyuanShareController:reqXianYuanShareWheel()
else
UIManager.info("每日首次接引仙友可获得开启次数")
end
end
end



function UIXianYuanShareWin:onShareBtn()
local cfg=cfgHelper.get1(cfg_xianyuanjieyinconfig_get,1)
local imageCfg=cfg.shareImage1
local wordCfg=cfg.shareImage2
local openDay=timeHelper.getServerOpenDay()
local imageLib=imageCfg[openDay]or imageCfg[math.random(1,#imageCfg)]
local wordLib=wordCfg[openDay]or{}

local param={
extra="shareChildSimplePicture",
param={
picAB=imageLib[1],
picName=imageLib[2],
wordAB=wordLib[1],
wordName=wordLib[2],
},
share=function(shareType)
if not xianyuanShareModel:haveTodayShare()then
xianyuanShareController:reqXianYuanShareDaily()
end
end,
close=function()
self:closeWindow("UIShareImageFrameWin")
end
}
self:showWindow("UIShareImageFrameWin",param)
xianyuanShareController:triggerReddotCancel()
end

function UIXianYuanShareWin:onClickItem(index)
if not self.tween then
local info=cfgHelper.get3(cfg_xianyuanjieyinconfig_get,1,"lib",index)
local rewards=info[1]
local reward=rewards[1]
itemsComponentHelper.onItemClickEx(reward[1],index,nil,nil)
end
end

function UIXianYuanShareWin:refreshView()
self:refreshWheelRewards()
self:refreshTimes()
end

function UIXianYuanShareWin:refreshWheelRewards()
for i,v in ipairs(self.item)do
local info=cfgHelper.get3(cfg_xianyuanjieyinconfig_get,1,"lib",i)
local rewards=info[1]
local reward=rewards[1]
local showCountBG=reward[2]>1
local itemCountStr=showCountBG and reward[2]or""
local conf={itemid=reward[1],itemcount=itemCountStr,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local itemWidget=v:getChildWidgetBase()
itemWidget:SetChildPropData(_itemCmp.item,prop)
itemWidget:SetBaseItemClickEvent(_itemCmp.item,function()
self:onClickItem(i)
end)
itemWidget:SetChildActive(_itemCmp.getted,xianyuanShareModel:isGettedReward(i))
end
end

function UIXianYuanShareWin:doAnimation(index,rewards,ease)

self:resetItemHightLight()
local turnNum=math.random(2,4)
local t=-turnNum*360-(index-self.index)*45

local endValue=Vector3.forward*t
local _ease=ease or 21
self.tween=self.wheel:setChildDORotation(endValue,math.random(5,10),DG.Tweening.RotateMode.LocalAxisAdd,function()
self.tween=nil
self:resetItemsRotation()

if rewards then
showPrizeControl.showWindow(rewards)
end
self:refreshWheelRewards()
self.hightlight[index]:setActive(true)
self.lighting=index

end)
self.tween:OnUpdate(function()
self:resetItemsRotation()
end)
self.tween:SetEase(DG.Tweening.Ease.IntToEnum(_ease))
self.index=index
end

function UIXianYuanShareWin:resetItemsRotation()
for i,v in ipairs(self.item)do
local rt=v:getCommonComponent("RectTransform")
rt.rotation=Quaternion.identity
end
end

function UIXianYuanShareWin:resetItemHightLight()
for i,v in ipairs(self.hightlight)do
v:setActive(false)
end
self.lighting=nil
end

function UIXianYuanShareWin:initCat()
self.catModel:setChildUIModelShowTarget(4932,1,{},eAnimationID.stand,false,false,0)
if self.bt then
behaviorManager:removeBehaviorTree(self.bt)
self.bt=nil
self.catTalk:setScale(Vector3.zero)
end
local args={
winName="UIXianYuanShareWin",
widget=self.winlua,
compenont=self.catTalk:getID(),
}
self.bt=behaviorManager:addBehaviorTree("bt_ui_xianyuanshare_cattalk",nil,true,args)
end

function UIXianYuanShareWin:randomCatTalk(bt)
local config=cfgHelper.get2(cfg_xianyuanjieyinconfig_get,1,"catTalk")
local r=math.random(1,#config)
self.catTalkDesc:setText(config[r])
end

function UIXianYuanShareWin:refreshTimes()
local times=xianyuanShareModel:getValibTimes()
self.numTx:setText(FMT.fmt("次数：{0}",times))
self.reddot:setActive(times>0)
end

function UIXianYuanShareWin:afterWheel(index)
local info=cfgHelper.get3(cfg_xianyuanjieyinconfig_get,1,"lib",index)
local rewards=info[1]
local prizeList={}
for i,v in ipairs(rewards)do
table.insert(prizeList,{itemid=v[1],num=v[2]})
end
self:doAnimation(index,prizeList)
self:refreshTimes()
end

function UIXianYuanShareWin:refreshReddot()
local reddot=xianyuanShareModel:getReddot()
local check=xianyuanShareModel:checkSharedTimes()
self.shareReddot:setActive(reddot and check)
end

function UIXianYuanShareWin:initTips()
local daily=cfgHelper.get2(cfg_xianyuanjieyinconfig_get,1,"daily")
local costStr=""
for i,v in ipairs(daily)do
costStr=FMT.fmt("{0}quad-icon={1}-quad   {2}",costStr,iconHelper.getIconName(v[1]),v[2])
end
costStr=FMT.fmt("每日首次接引可获得转盘次数和  {0}",costStr)
self.tipsTx:setText(costStr)
end

function UIXianYuanShareWin:refreshTips()
local show=not xianyuanShareModel:haveTodayShare()
local check=xianyuanShareModel:checkSharedTimes()
self.tipsPanel:setActive(show and check)
end
