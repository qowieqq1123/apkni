







def_class("UIXBSL_xuanShangWin",UIWindowBase)









function UIXBSL_xuanShangWin:bindComponents()

self.cost=UIText.get(self,0)
self.moneyIcon=UIObject.get(self,1)
self.rwValue=UIText.get(self,2)
self.model=UIObject.get(self,3)
self.payBtn=UIButton.get(self,4)
self.scrollview=UIObject.get(self,5)
self.rwScrollView=UIObject.get(self,6)
self.speakHUD=UIObject.get(self,7)
self.menuScrollView=UIObject.get(self,8)
self.closeBtn=UIButton.get(self,9)

self.payBtn:setButtonClick(function()self:onPayBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)


self.sprite_button_zhulitouziui_1=0
self.sprite_button_zhulitouziui_2=1

end


function UIXBSL_xuanShangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.rwValue);self.rwValue=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.payBtn);self.payBtn=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.speakHUD);self.speakHUD=nil;
_UIObject_release(self.menuScrollView);self.menuScrollView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
end
















local rewardItemCmpIndex={
titleText=0,
freeItemGroup=1,
investorItemGroup=2,
lock=3
}
local _this




function UIXBSL_xuanShangWin:onLoaded(...)
_this=self
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
self.menuScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIXBSL_xuanShangWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXBSL_xuanShangWin:onShow(argtable,afterOnloaded)
self.selectMenuIndex=self:getDefaultMenuIndex()

self:refresh(true,true)

self:showNPC()
end

function UIXBSL_xuanShangWin:refresh(isInit,autoJump)
self:refreshMenu(isInit)
self:refreshPage(autoJump)
end

function UIXBSL_xuanShangWin:refreshPage(autoJump)
self:setRewardList(autoJump)
self:setSPRewards()
self:setTZValue()
end


function UIXBSL_xuanShangWin:onHide()

end

function UIXBSL_xuanShangWin:getDefaultMenuIndex()





return 1
end

function UIXBSL_xuanShangWin:refreshMenu(isInit)
if not self.xuanShangCfgList or isInit then
self.xuanShangCfgList=self:getXuanShangCfgList()
end
local count=#self.xuanShangCfgList
self.menuScrollView:setChildScrollViewCreateGrids(count,0)
local grids=self.menuScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local cfg=self.xuanShangCfgList[i]
if cfg then
widget:SetChildActive(-1,true)
local isSelect=self.selectMenuIndex==i
widget:SetChildActive(1,not isSelect)
widget:SetChildActive(2,isSelect)

widget:SetChildButtonClick(0,function()
if not _this then return end
if _this.selectMenuIndex==i then return end
return _this:selectMenu(i)
end,true)


local bountyId=cfg.id
local nameStr=string.format("第%d期",bountyId)
widget:SetChildText(3,nameStr)


local reddot=xunBaoShiLianModel:checkXuanShangReddotByBountyId(bountyId)
widget:SetChildActive(4,reddot)
else
widget:SetChildActive(-1,false)
end
end
end

function UIXBSL_xuanShangWin:refreshMenuReddot()
local grids=self.menuScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local cfg=self.xuanShangCfgList[i]
if cfg then
local bountyId=cfg.id

local reddot=xunBaoShiLianModel:checkXuanShangReddotByBountyId(bountyId)
widget:SetChildActive(4,reddot)
end
end
end

function UIXBSL_xuanShangWin:selectMenu(selectMenuIndex)
if selectMenuIndex==self.selectMenuIndex then
return
end
self.selectMenuIndex=selectMenuIndex
self:refresh(nil,true)
end

function UIXBSL_xuanShangWin:getXuanShangCfgList()
local allCfg=cfg_treasuretrainningbountyconfig()
local xuanShangCfgList={}
for i,v in ipairs(allCfg)do
local bountyId=v.id

local isUnlock=xunBaoShiLianModel:checkXuanShangIsUnlockByBountyId(bountyId)
if isUnlock then

local isAllGot=xunBaoShiLianModel:checkXuanShangIsAllGotByBountyId(bountyId)
if not isAllGot then
xuanShangCfgList[#xuanShangCfgList+1]=v
end
end
end

return xuanShangCfgList
end

function UIXBSL_xuanShangWin:showNPC()


local diziId=3005
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(diziId)
local info=dzData.imageInfo
if info then

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,{isNotBg=true})
local scale=0.8
self.model:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,eAnimationID.stand)



end


local widget=self.speakHUD:getChildWidgetBase()
local txt='购买后完成指定关卡，\n可获得大量灵玉奖励！'
widget:SetChildText(0,chatEmotHelper.decodeEmot(txt))
end

function UIXBSL_xuanShangWin:setTZValue()
local xuanshangCfg=self.xuanShangCfgList[self.selectMenuIndex]
if xuanshangCfg then
local bountyId=xuanshangCfg.id
local isBought=xunBaoShiLianModel:checkXuanShangIsBoughtByBountyId(bountyId)
local worth=xuanshangCfg.worth
local rechargeId=xuanshangCfg.invest_recharge_id
local czcfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(czcfg)
self.moneyIcon:setChildIcon(iconHelper.getIconName(worth[1]),false)
self.rwValue:setText(worth[2])
if isBought then
self.payBtn:setImageSprite(self.sprite_button_zhulitouziui_2,true)
self.cost:setText('已购买')
else
self.payBtn:setImageSprite(self.sprite_button_zhulitouziui_1,true)
self.cost:setText(FMT.fmt('{0}购买',str))
end
end
end

function UIXBSL_xuanShangWin:setSPRewards()
local xuanshangCfg=self.xuanShangCfgList[self.selectMenuIndex]
if xuanshangCfg then
local bountyId=xuanshangCfg.id
local isBought=xunBaoShiLianModel:checkXuanShangIsBoughtByBountyId(bountyId)
local rewards=xuanshangCfg.buy_rewards
local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,4))
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count-1
for i=0,count do
local item=grids[i]
local rwdata=rewards[i+1]
widgetHelper.setNormalRewardItem(item,0,rwdata)
item:SetChildGraphicGray(0,isBought,true)
item:SetChildActive(1,isBought)
end
end
end

function UIXBSL_xuanShangWin:setRewardList(autoJump)
local xuanshangCfg=self.xuanShangCfgList[self.selectMenuIndex]
if xuanshangCfg then
local autoJumpIndex
local bountyId=xuanshangCfg.id
local levelReward_free=xuanshangCfg.bounty_free_reward
local levelReward_invest=xuanshangCfg.bounty_invest_reward
local len=#levelReward_free
local clearChapterId=xunBaoShiLianModel:getChapterIdByModeId(XBSL_DIFFICULTY_MODE.Normal)
local clearLevelIdx=xunBaoShiLianModel:getLevelIdxByModeId(XBSL_DIFFICULTY_MODE.Normal)
self.scrollview:setChildScrollViewCreateGrids(len,len)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
local isBought=xunBaoShiLianModel:checkXuanShangIsBoughtByBountyId(bountyId)
for i=1,count do
local item=grids[i-1]
local freeRewards=levelReward_free[i]
local investRewards=levelReward_invest[i]
local chapterId=freeRewards[1]
local levelIdx=freeRewards[2]
local data=xunBaoShiLianModel:getXuanShangData(bountyId)or{}
item:SetChildActive(rewardItemCmpIndex.lock,not isBought)
item:SetChildText(rewardItemCmpIndex.titleText,FMT.fmt("完成关卡\n<color=#ca631d>{0}-{1}</color>",chapterId,levelIdx))
if not isBought then
item:SetChildButtonClick(rewardItemCmpIndex.lock,function()
UIManager.error('购买悬赏后解锁')
end,true)
end

local isFinish=false
if clearChapterId>chapterId or(clearChapterId==chapterId and clearLevelIdx>=levelIdx)then
isFinish=true
end
local isGot_free=data.free_idx and data.free_idx>=i or false
local isGot_invest=data.invest_idx and data.invest_idx>=i or false
local itemClickFun_free=function(...)
self:onClickRewardItem(...)
end
local itemClickFun_invest=function(...)
self:onClickRewardItem(...)
end
if isFinish and not isGot_free then
itemClickFun_free=function()
xunBaoShiLianController:reqGetXuanShangReward(bountyId)
end
if not autoJumpIndex then
autoJumpIndex=i
end
end
if isFinish and isBought and(not isGot_invest or not isGot_free)then
itemClickFun_invest=function()
xunBaoShiLianController:reqGetXuanShangReward(bountyId)
end
if not autoJumpIndex then
autoJumpIndex=i
end
end

if not isFinish and not autoJumpIndex then
autoJumpIndex=i
end
local effectId="xianshu_light"

local freeRewardsList=freeRewards[3]
item:SetChildLayoutGroupCreateItems(rewardItemCmpIndex.freeItemGroup,#freeRewardsList,function(index)
local rwWidget=item:GetChildLayoutGroupGridItem(rewardItemCmpIndex.freeItemGroup,index-1)
local reward=freeRewardsList[index]
local itemid=reward[1]
local itemcount=reward[2]
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGot_free
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildPropData(0,prop)
rwWidget:SetBaseItemClickEvent(0,itemClickFun_free)
rwWidget:SetChildActive(2,isGot_free)




rwWidget:SetChildActive(3,isFinish and not isGot_free)
end)


local investRewardsList=investRewards[3]
item:SetChildLayoutGroupCreateItems(rewardItemCmpIndex.investorItemGroup,#investRewardsList,function(index)
local rwWidget=item:GetChildLayoutGroupGridItem(rewardItemCmpIndex.investorItemGroup,index-1)
local reward=investRewardsList[index]
local itemid=reward[1]
local itemcount=reward[2]
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGot_invest or not isBought
rwWidget:SetChildActive(-1,true)
rwWidget:SetChildPropData(0,prop)
rwWidget:SetBaseItemClickEvent(0,itemClickFun_invest)
rwWidget:SetChildActive(2,isGot_invest)




rwWidget:SetChildActive(3,isBought and isFinish and not isGot_invest)
end)
end

if autoJump then
autoJumpIndex=autoJumpIndex or 1
self.scrollview:setChildScrollViewSelectItem(autoJumpIndex-1,false,false,false)
end
end

end




function UIXBSL_xuanShangWin:onPayBtn()
local xuanshangCfg=self.xuanShangCfgList[self.selectMenuIndex]
if xuanshangCfg then
local bountyId=xuanshangCfg.id
local isBought=xunBaoShiLianModel:checkXuanShangIsBoughtByBountyId(bountyId)
local rechargeId=xuanshangCfg.invest_recharge_id
if not isBought then




self:showWindow("UIXBSL_xuanShangBuyWin",{rechargeId=rechargeId,bountyId=bountyId,xuanshangCfg=xuanshangCfg})
end
end
end

function UIXBSL_xuanShangWin:onCloseBtn()
self:closeSelf()
end



function UIXBSL_xuanShangWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid,showModel=true,})
end