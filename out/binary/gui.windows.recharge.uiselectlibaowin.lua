







def_class("UISelectLiBaoWin",UIWindowBase)









function UISelectLiBaoWin:bindComponents()

self.freeRewardBtn=UIButton.get(self,0)
self.freeRewardBtnReddot=UIObject.get(self,1)
self.bgModel=UIObject.get(self,2)
self.libaoScrollView=UIObject.get(self,3)

self.freeRewardBtn:setButtonClick(function()self:onFreeRewardBtn()end)



end


function UISelectLiBaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.freeRewardBtn);self.freeRewardBtn=nil;
_UIObject_release(self.freeRewardBtnReddot);self.freeRewardBtnReddot=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.libaoScrollView);self.libaoScrollView=nil;
end
















local libaoItemCmpIndex={
icon=0,
name=1,
limitText=2,
defaultRewardGroup=3,
selectRewardGroup=4,
buyBtn=5,
buyBtnIcon=6,
buyBtnText=7,
sellOut=8,
}
local resetTypeStrList={
[0]="",
[1]="每日",
[2]="每周",
[3]="每月",
}
local buyIconAbName="ui/windows/recharge/selectlibaoicon_atlas_pak.ab"




function UISelectLiBaoWin:onLoaded(...)
self:bindComponents()
end


function UISelectLiBaoWin:__delete()
self:unbindComponents()
end




function UISelectLiBaoWin:onShow(argtable,afterOnloaded)
self:onShowArgRecv(argtable,afterOnloaded)
end

function UISelectLiBaoWin:onShowArgRecv(argtable,afterOnloaded)
self.select_itemId=argtable.itemId
self.select_itemIdList=argtable.itemIdList
self:refresh()
end


function UISelectLiBaoWin:onHide()
self.libaoScrollView:setActive(false)
end

function UISelectLiBaoWin:refresh()

self:refreshLiBaoList()


self:refreshFreeRewardBtn()
end


function UISelectLiBaoWin:refreshLiBaoList()

self:initSortLiBaoList()

self.libaoScrollView:setActive(true)
local count=#self.sortLiBaoList
self.libaoScrollView:setChildScrollViewCreateGrids(count,1)
local grids=self.libaoScrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
self:refreshLiBaoItem(i,widget)
end

local itemIdList={}
if self.select_itemId then
table.insert(itemIdList,self.select_itemId)
self.select_itemId=nil
end
if self.select_itemIdList then
for i,itemId in ipairs(self.select_itemIdList)do
table.insert(itemIdList,itemId)
end
self.select_itemIdList=nil
end

for i,itemId in ipairs(itemIdList)do
local flag,libaoId,gridIdx=rechargeModel:checkSelectLiBaoHasItemId(itemId)
if flag then
local defaultReward,selectReward,canSelectReward=rechargeModel:getSelectLiBaoRewardByLiBaoId(libaoId)
local selectIdx=gridIdx-#defaultReward
self:showWindow("UISelectLiBao_selectWin",{libaoId=libaoId,selectIdx=selectIdx,selectItemId=itemId})
break
end
end
end

function UISelectLiBaoWin:refreshLiBaoItem(index,widget)
if not widget then
widget=self.libaoScrollView:getChildScrollViewItemWidget(index-1)
end

local data=self.sortLiBaoList[index]
if data then
local libaoId=data.libaoId
local buyNum=rechargeModel:getSelectLiBaoBuyNumByLiBaoId(libaoId)
local cfg=data.cfg


local iconName=cfg.icon

widget:SetChildCSImageSprite(libaoItemCmpIndex.icon,buyIconAbName,iconName)


local name=cfg.name
widget:SetChildText(libaoItemCmpIndex.name,name)


local maxCount=cfg.maxcount
local hasLimit=false
local isSellOut=false
if maxCount and maxCount>0 then
hasLimit=true
if buyNum>=maxCount then
isSellOut=true
end
end
widget:SetChildActive(libaoItemCmpIndex.limitText,hasLimit)
widget:SetChildActive(libaoItemCmpIndex.sellOut,isSellOut)
widget:SetChildActive(libaoItemCmpIndex.buyBtn,not isSellOut)
local resetType=cfg.reset_type
if hasLimit then
local typeStr=resetTypeStrList[resetType]
widget:SetChildText(libaoItemCmpIndex.limitText,FMT.fmt("{0}限购：{1}/{2}",typeStr,buyNum,maxCount))
end


local isRecharge=cfg.rechargeid~=nil
widget:SetChildActive(libaoItemCmpIndex.buyBtnIcon,not isRecharge)
if isRecharge then

local rechargeId=cfg.rechargeid
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeId)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
widget:SetChildText(libaoItemCmpIndex.buyBtnText,str)
else

local priceParam=cfg.price
local moneyId=priceParam[1]
local moneyCount=priceParam[2]
local itemicon=iconHelper.getIconName(moneyId)
widget:SetChildIcon(libaoItemCmpIndex.buyBtnIcon,itemicon,false)
widget:SetChildText(libaoItemCmpIndex.buyBtnText,moneyCount)
end
widget:SetChildButtonClick(libaoItemCmpIndex.buyBtn,function()
self:onLibaoBuyBtn(libaoId)
end)


local defaultReward,selectReward,canSelectReward=rechargeModel:getSelectLiBaoRewardByLiBaoId(libaoId)
local defaultRewardCount=#defaultReward

widget:SetChildLayoutGroupCreateItems(libaoItemCmpIndex.defaultRewardGroup,defaultRewardCount,function(gridIndex)
local item=widget:GetChildLayoutGroupGridItem(libaoItemCmpIndex.defaultRewardGroup,gridIndex-1)
local reward=defaultReward[gridIndex]
local itemid=reward.itemId
local itemcount=reward.itemCount
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildActive(-1,true)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
end)

local selectRewardCount=#canSelectReward-defaultRewardCount
widget:SetChildLayoutGroupCreateItems(libaoItemCmpIndex.selectRewardGroup,selectRewardCount,function(gridIndex)
local item=widget:GetChildLayoutGroupGridItem(libaoItemCmpIndex.selectRewardGroup,gridIndex-1)
local reward=selectReward[gridIndex]
item:SetChildActive(-1,true)
if reward then
local itemid=reward.itemId
local itemcount=reward.itemCount
local countStr=''
local showCountBG=false
if itemcount>1 then
showCountBG=true
countStr=mathHelper.formatNumber(itemcount)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetChildActive(0,true)
item:SetChildActive(2,false)
local reddot=rechargeModel:checkSelectLiBaoGridReddot(libaoId,gridIndex)
item:SetChildActive(5,reddot)
item:SetChildActive(4,true)
if reddot then
item:SetChildActive(4,false)
end
else
item:SetChildActive(0,false)
item:SetChildActive(2,true)
item:SetChildActive(4,false)
item:SetChildActive(5,false)
end
item:SetChildButtonClick(3,function()
if isSellOut then
UIManager.error("该礼包已售罄")
return
end

self:onClickSelectItem(libaoId,gridIndex)
end,true)
end)
end
end


function UISelectLiBaoWin:refreshFreeRewardBtn()
local isGotFreeReward=rechargeModel:checkSelectLiBaoFreeRewardGot()
self.freeRewardBtn:setActive(not isGotFreeReward)
end

function UISelectLiBaoWin:initSortLiBaoList()
local sortList={}
local allCfg=cfg_customizedgiftconfig()
for _,cfg in pairs(allCfg)do
local libaoId=cfg.id
if libaoId then
local isHide=rechargeModel:isSelectLiBaoHide(libaoId)
if not isHide then
local weight=cfg.sortId

local isSellOut=false
local buyNum=rechargeModel:getSelectLiBaoBuyNumByLiBaoId(libaoId)
if cfg.maxcount and cfg.maxcount>0 then

if buyNum>=cfg.maxcount then
isSellOut=true
end
end

if isSellOut then
weight=weight+1000
end
sortList[#sortList+1]={
libaoId=libaoId,
weight=weight,
cfg=cfg,
}
end
end
end

table.sort(sortList,function(a,b)
return a.weight<b.weight
end)
self.sortLiBaoList=sortList
end

function UISelectLiBaoWin:refreshLiBaoItemByLibaoId(libaoId)
local index
for i,v in ipairs(self.sortLiBaoList)do
if v.libaoId==libaoId then
index=i
break
end
end

if index then
self:refreshLiBaoItem(index)
end
end




function UISelectLiBaoWin:onFreeRewardBtn()
local giftId=cfgHelper.getdef1(cfg_customizedgiftconfig,'freegiftid')
FreeGiftController.SendFreeGift(giftId,nil,function(result)
if result then
UIManager:invokeUIMethod("UISelectLiBaoWin","refreshFreeRewardBtn")

reddotControl.on_change_catch_type(CATCH_TYPE.eSelectLiBao)
end
end)
end


function UISelectLiBaoWin:onLibaoBuyBtn(libaoId)

local defaultReward,selectReward,canSelectReward=rechargeModel:getSelectLiBaoRewardByLiBaoId(libaoId)
local defaultRewardCount=#defaultReward
local selectRewardCount=#canSelectReward-defaultRewardCount
local itemIndexList={}
local rewards={}
for i=1,defaultRewardCount do
local item=defaultReward[i]
itemIndexList[#itemIndexList+1]=item.idx
rewards[#rewards+1]={item.itemId,item.itemCount}
end

for i=1,selectRewardCount do
local item=selectReward[i]
if not item then
UIManager.error("还有未选择的道具！")
return
end
itemIndexList[#itemIndexList+1]=item.idx
rewards[#rewards+1]={item.itemId,item.itemCount}
end

self:showWindow("UISelectLiBao_dialogWin",{libaoId=libaoId,rewards=rewards,rewardIndexList=itemIndexList})
end



function UISelectLiBaoWin:onClickRewardItem(itemId,index,guid,attach)
if itemId==-1 then
return
end


tipsManager.showTips({itemid=itemId,itemguid=guid})
end

function UISelectLiBaoWin:onClickSelectItem(libaoId,index)

self:showWindow("UISelectLiBao_selectWin",{libaoId=libaoId,selectIdx=index})
end
