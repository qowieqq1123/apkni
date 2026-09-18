







def_class("UIWanLingTaRewardWin",UIWindowBase)









function UIWanLingTaRewardWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.exp=UIText.get(self,1)
self.expProgress=UIObject.get(self,2)
self.level=UIText.get(self,3)
self.mask=UIButton.get(self,4)
self.rewardContent=UIObject.get(self,5)
self.rewardScrollRect=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.taLing=UIObject.get(self,8)
self.upgradeBtn=UIButton.get(self,9)
self.upgradeBtnReddot=UIObject.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.upgradeBtn:setButtonClick(function()self:onUpgradeBtn()end)



end


function UIWanLingTaRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.exp);self.exp=nil;
_UIObject_release(self.expProgress);self.expProgress=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.rewardContent);self.rewardContent=nil;
_UIObject_release(self.rewardScrollRect);self.rewardScrollRect=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.taLing);self.taLing=nil;
_UIObject_release(self.upgradeBtn);self.upgradeBtn=nil;
_UIObject_release(self.upgradeBtnReddot);self.upgradeBtnReddot=nil;
end

















local this=nil
local itemCmp={
items={1,2},
}


function UIWanLingTaRewardWin:onLoaded(...)
self:bindComponents()
this=self
self:addNotify(notifyConfig.onWanLingTaLevelRewardChange,self.onWanLingTaLevelRewardChange)
end


function UIWanLingTaRewardWin:__delete()
this=nil
self:unbindComponents()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end
end




function UIWanLingTaRewardWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.taLing:setChildUIModelShowTarget(2123004,0.5,{},eAnimationID.stand,false,false,0.6)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6)
end
local levelRewardList={}
local cfgs=cfg_xumitatllevelconfig()
for level,cfg in ipairs(cfgs)do
if cfg.items then
table.insert(levelRewardList,{level,cfg.items})
end
end
self.levelRewardList=levelRewardList
self.receiveLevel=0
self:refreshLevelRewardList()
self:refreshTaLingInfo()
self:setTaLingSpeakTimer()
end

function UIWanLingTaRewardWin.onWanLingTaLevelRewardChange()
this:refreshLevelRewardList()
this:refreshTaLingInfo()
end

function UIWanLingTaRewardWin:setTaLingSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end
local speakInterval=cfgHelper.getdef1(cfg_xumitatalingtalkconfig,"speakInterval")
self.speakTimer=self:setTimer(speakInterval,0,function()
self:setTaLingSpeak()
end)
end

function UIWanLingTaRewardWin:setTaLingSpeak()
local collect=wanLingTaModel:getCollectCount()
local cfg=cfg_xumitatalingtalkconfig()
local idx=#cfg
for i,v in ipairs(cfg)do
if collect<=v.range then
idx=i
break
end
end
local txtLib=cfg[idx].lines
local speakTxt=txtLib[math.random(#txtLib)]
local parent=self.winlua:GetCommonComponent(self.taLing:getID(),'Transform')
if self.sHUD then
local hudWidget=_InstantiateManager.GetComponent(self.sHUD,'CSGUIWidgetBase')
local txt=chatEmotHelper.decodeEmot(speakTxt)or''
hudWidget:SetChildText(0,txt)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
else
self.sHUD=_InstantiateManager.AddInstance(INSTANCE_TYPE.eUIDiscipleSpeak,parent,function(id)
if self.sHUD==id then
local hudWidget=_InstantiateManager.GetComponent(id,'CSGUIWidgetBase')
local offsetVal=Vector2.New(0,165)
hudWidget:SetChildAnchoredPosition(2,offsetVal)
local txt=chatEmotHelper.decodeEmot(speakTxt)or''
hudWidget:SetChildText(0,txt)
local abName,skinName=discipleStateManager:getSpeakSkinInfoById(1)
hudWidget:SetChildCSImageSprite(1,abName,skinName)
hudWidget:SetChildScale(2,Vector3.zero)
hudWidget:SetChildDOScale(2,1,0.3)
else
hudControl:removeHUD(id)
self.sHUD=nil
end
end)
end
local speakDuration=3
self:delayDo(speakDuration,function()
self:removeTaLingSpeak()
end)
end

function UIWanLingTaRewardWin:removeTaLingSpeak()
if self.sHUD then
_InstantiateManager.RemoveInstance(self.sHUD)
self.sHUD=nil
end
end

function UIWanLingTaRewardWin:refreshTaLingInfo()
local cfgs=cfg_xumitatllevelconfig()
local taLingLevel=wanLingTaModel:getTaLingLevel()
local exp=wanLingTaModel:getTaLingExp()
local maxExp=wanLingTaModel:getTaLingNeedExp()
self.level:setText(string.format("%d级",taLingLevel))
self.exp:setText(string.format("%d/%d",exp,maxExp))
self.expProgress:setChildIconFillAmount(exp/maxExp)
local maxLevel=#cfgs
local upGradeReddot=taLingLevel<maxLevel and exp>=maxExp
self.upgradeBtnReddot:setActive(upGradeReddot)
end

function UIWanLingTaRewardWin:refreshLevelRewardList()
local taLingLevel=wanLingTaModel:getTaLingLevel()
local rewardLevel=wanLingTaModel:getTaLingRewardLevel()
local len=#self.levelRewardList
local nextLevel
self.rewardScrollRect:setChildScrollRectEnable(false)
self.rewardContent:setChildLayoutGroupCreateItems(len,function(index)
local rewardItem=self.rewardContent:getChildLayoutGroupGridItem(index-1)
local data=self.levelRewardList[index]
local level,itemList=data[1],data[2]
local received=rewardLevel>=level
local canReceive=taLingLevel>=level and not received
for idx,cmp in ipairs(itemCmp.items)do
if itemList[idx]then
local itemid,itemnum=unpack(itemList[idx])
local countStr=itemnum>1 and mathHelper.formatNumber(itemnum)or''
local showCountBG=itemnum>1
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetBaseItemClickEvent(cmp,function(...)
itemsComponentHelper.onItemClick(...)
end)
rewardItem:SetChildPropData(cmp,prop)
end
end
local isEvenNumber=index%2==0
rewardItem:SetChildAnchoredPos(0,0,isEvenNumber and-10 or 0)
rewardItem:SetChildText(3,string.format("%d级",level))
rewardItem:SetChildActive(4,canReceive)
if canReceive then
self.receiveLevel=math.max(self.receiveLevel,level)
rewardItem:SetChildButtonClick(4,function()
self:onRewardButton()
end)
if not nextLevel then
nextLevel=level
local x=nextLevel and(nextLevel>3 and-140*(nextLevel-3)or 0)or 0
self.rewardContent:setChildAnchoredPosition(Vector2(x,0))
end
else
if not nextLevel and not received then
nextLevel=level
local x=nextLevel and(nextLevel>3 and-140*(nextLevel-3)or 0)or 0
self.rewardContent:setChildAnchoredPosition(Vector2(x,0))
end
end
rewardItem:SetChildActive(5,received)
if index==len then
self.rewardScrollRect:setChildScrollRectEnable(true)
end
end)
end

function UIWanLingTaRewardWin:onRewardButton()
if self.receiveLevel>0 then
wanLingTaController.send_43_2(self.receiveLevel)
end
end

function UIWanLingTaRewardWin:onUpgradeBtn()
local cfgs=cfg_xumitatllevelconfig()
local taLingLevel=wanLingTaModel:getTaLingLevel()
if taLingLevel>=#cfgs then
UIManager.info("塔灵等级已满级")
return
end
local exp=wanLingTaModel:getTaLingExp()
local tl_lv=taLingLevel
local sum=0
for lv=taLingLevel+1,#cfgs do
local cfg=cfgs[lv]
sum=sum+cfg.exp
if exp<sum then
break
end
tl_lv=lv
end
if tl_lv>taLingLevel then
wanLingTaController.send_43_7(tl_lv)
else
gainControl:showGainWin(eMoneyType.mtXmtExp)
end
end

function UIWanLingTaRewardWin:onMask()
self:closeSelf()
end

function UIWanLingTaRewardWin:onCloseBtn()
self:closeSelf()
end