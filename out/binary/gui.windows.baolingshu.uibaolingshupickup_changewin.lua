







def_class("UIBaoLingShuPickUp_ChangeWin",UIWindowBase)









function UIBaoLingShuPickUp_ChangeWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.leftBtn=UIButton.get(self,1)
self.rightBtn=UIButton.get(self,2)
self.mask=UIButton.get(self,3)
self.changeBtn=UIButton.get(self,4)
self.changeCostText=UIText.get(self,5)
self.changeCostIcon=UIImage.get(self,6)
self.bgModel=UIObject.get(self,7)
self.boatModel=UIObject.get(self,8)
self.backPanel=UIObject.get(self,9)
self.frontPanel=UIObject.get(self,10)
self.selectScrollerView=UIObject.get(self,11)
self.Content=UIObject.get(self,12)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)



end


function UIBaoLingShuPickUp_ChangeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.changeBtn);self.changeBtn=nil;
_UIObject_release(self.changeCostText);self.changeCostText=nil;
_UIObject_release(self.changeCostIcon);self.changeCostIcon=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.boatModel);self.boatModel=nil;
_UIObject_release(self.backPanel);self.backPanel=nil;
_UIObject_release(self.frontPanel);self.frontPanel=nil;
_UIObject_release(self.selectScrollerView);self.selectScrollerView=nil;
_UIObject_release(self.Content);self.Content=nil;
end
















local selectItemCmpIndex={
selectBg=0,
name=1,
jobIcon=2,
rewardGrids=3,
selectFlag=4,
bg=5,
}
local _this




function UIBaoLingShuPickUp_ChangeWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIBaoLingShuPickUp_ChangeWin:__delete()
_this=nil
self:clearAllTimer()
self:unbindComponents()
end




function UIBaoLingShuPickUp_ChangeWin:onShow(argtable,afterOnloaded)
self.nowSelectPageIndex=1
if afterOnloaded then
self.backPanel:setChildCanvasGroupAlpha(0)
self.frontPanel:setChildCanvasGroupAlpha(0)
self.backPanel:setChildCanvasGroupDOFade(1,1)
self.frontPanel:setChildCanvasGroupDOFade(1,1)

self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),5037,1,{},eAnimationID.stand)
self.winlua:SetChildUIModelShowTarget(self.boatModel:getID(),5038,1,{},eAnimationID.stand)
end
self:refresh(afterOnloaded)
self:setEndTimer()
self:setUpdateTimer()
end


function UIBaoLingShuPickUp_ChangeWin:onHide()
self:clearAllTimer()
end

function UIBaoLingShuPickUp_ChangeWin:onUpdate()

if self.selectItemPosList and next(self.selectItemPosList)then
local nowPos=self.Content:getChildAnchoredPosition()
local showWidth=self.selectScrollerView:getChildSizeDeltaX()
local nowPosX_Left=nowPos.x
local nowPosX_Right=nowPos.x-showWidth
local pageShowItemIdx_left
local pageShowItemIdx_right
local offset=50
for i,v in ipairs(self.selectItemPosList)do
local itemLeftPos=-v.left
local itemRightPos=-v.right
local itemSpace=v.space
if not pageShowItemIdx_left and nowPosX_Left<=(itemLeftPos-offset)and nowPosX_Left>=(itemRightPos-itemSpace-offset)then
pageShowItemIdx_left=i
end
if not pageShowItemIdx_right and nowPosX_Right<=(itemLeftPos+itemSpace+offset)and nowPosX_Right>=(itemRightPos+offset)then
pageShowItemIdx_right=i
end

if pageShowItemIdx_left and pageShowItemIdx_right then
break
end
end

local hasChangeIndex=false
if self.pageShowItemIdx_left~=pageShowItemIdx_left or self.pageShowItemIdx_right~=pageShowItemIdx_right then
hasChangeIndex=true
end
self.pageShowItemIdx_left=pageShowItemIdx_left
self.pageShowItemIdx_right=pageShowItemIdx_right

if hasChangeIndex then
return self:refreshArrowBtn()
end
end
end

function UIBaoLingShuPickUp_ChangeWin:refresh(isInit)
local roundList=baoLingShuModel:getPickUpShowGBPickUpRoundList()
local selectGubaoListIndex=baoLingShuModel:getPickUpShowGBListIndex()
local roundCount,roundId=baoLingShuModel:getPickUpShowGBPickUpRoundCount()
local roundListCount=#roundList
self.maxListIndex=roundListCount
if isInit then
self:initItemPosList()
end

local configId=baoLingShuModel:getConfId()
local gubaoListShowCfg=cfgHelper.get2(cfg_baolingtreeconfig_get,configId,'gubaoRoundShowParam')
local gubaoListRewardCfg=cfgHelper.get2(cfg_baolingtreeconfig_get,configId,'gubaoList')
local jumpIndex=1
self.selectScrollerView:setChildScrollViewCreateGrids(roundListCount,roundListCount)
local grids=self.selectScrollerView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local gubaoListIndex=roundList[i]
widget:SetChildActive(-1,true)
local showCfg=gubaoListShowCfg[roundId][gubaoListIndex]

local name=showCfg.name
widget:SetChildText(selectItemCmpIndex.name,name)


local jobId=showCfg.job


local jobIconName=UIDiscipleModel:getJobIconName(jobId)
widget:SetChildCSImageSprite(selectItemCmpIndex.jobIcon,globalABLookup.global,jobIconName)


local isClickSelect=i==self.clickSelectPageItemIndex
widget:SetChildActive(selectItemCmpIndex.selectBg,isClickSelect)


local isSelect=gubaoListIndex==selectGubaoListIndex
if isSelect then
jumpIndex=i
end
widget:SetChildActive(selectItemCmpIndex.selectFlag,isSelect)


local rewards=gubaoListRewardCfg[roundId][gubaoListIndex]
local rewardGridsList=widget:GetChildCommonLayoutGroupWidgetList(selectItemCmpIndex.rewardGrids)
for i=1,rewardGridsList.Count do
local itemGrid=rewardGridsList[i-1]
local reward=rewards[i]
local itemid=reward[1]

local conf={itemid=itemid,itemcount="",showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemGrid:SetChildActive(-1,true)
itemGrid:SetChildPropData(0,prop)
itemGrid:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
local itemName=itemsConfig.getItemName(itemid)
itemGrid:SetChildText(1,itemName)
end


widget:SetChildButtonClick(selectItemCmpIndex.bg,function()
self:onSelectGbList(i,gubaoListIndex)
end)
end


self:refreshCost()

if isInit then

self:jumpItem(jumpIndex)
end
end

function UIBaoLingShuPickUp_ChangeWin:refreshCost()
local configId=baoLingShuModel:getConfId()
local gubaoChangeCfg=cfgHelper.get2(cfg_baolingtreeconfig_get,configId,'qhGuBao')
local costItemId=gubaoChangeCfg[1]
local costItemNeedCount=gubaoChangeCfg[2]
local countStr=mathHelper.formatNumber(costItemNeedCount,true)
local haveCount
if moneyConfig.isMoney(costItemId)then
haveCount=moneyModel.getMoney(costItemId)
if costItemId==eMoneyType.mtLingYu then
local xianyuCount=moneyModel.getMoney(eMoneyType.mtXianYu)
haveCount=haveCount+xianyuCount
end
else
haveCount=bagControl.invokeFuncByItemId(costItemId,'getItemCountByItemID',costItemId)
end
if haveCount<costItemNeedCount then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,countStr)
end
self.changeCostIcon:setChildIcon(iconHelper.getIconName(costItemId),false)
self.changeCostText:setText(countStr)
end

function UIBaoLingShuPickUp_ChangeWin:jumpItem(index,animation,alignEnd)
self.nowSelectItemIndex=index
local jumpIndex=index
if jumpIndex<=1 then
jumpIndex=0
elseif jumpIndex>=self.maxListIndex then
jumpIndex=self.maxListIndex+1
end
self.selectScrollerView:setChildScrollViewSelectItem(jumpIndex-1,animation or false,false,alignEnd or false)
end

function UIBaoLingShuPickUp_ChangeWin:initItemPosList()
local leftOffset=82
local rightOffset=82
local itemWeight=300
local itemSpace=18

local itemPosList={}
local itemCount=self.maxListIndex
local startPos=leftOffset
for i=1,itemCount do
local itemPos_left=startPos
local itemPos_right=startPos+itemWeight
local itemPos={left=itemPos_left,right=itemPos_right,space=itemSpace}
table.insert(itemPosList,itemPos)

startPos=itemPos_right+itemSpace
end
self.selectItemPosList=itemPosList
end

function UIBaoLingShuPickUp_ChangeWin:refreshArrowBtn()
local isShowLeftBtn=false
local isShowRightBtn=false

if self.pageShowItemIdx_left and self.pageShowItemIdx_left>=1 then
isShowLeftBtn=true
end
if self.pageShowItemIdx_right and self.pageShowItemIdx_right<=self.maxListIndex then
isShowRightBtn=true
end

self.leftBtn:setActive(isShowLeftBtn)
self.rightBtn:setActive(isShowRightBtn)
end

function UIBaoLingShuPickUp_ChangeWin:onSelectGbList(selectItemIndex,gubaoListIndex)
local isClickSelect=selectItemIndex==self.clickSelectPageItemIndex
if isClickSelect then
return
end

local selectGubaoListIndex=baoLingShuModel:getPickUpShowGBListIndex()
if gubaoListIndex==selectGubaoListIndex then
return UIManager.error("当前已为该档期古宝")
end

if self.clickSelectPageItemIndex then

local oldWidget=self.selectScrollerView:getChildScrollViewItemWidget(self.clickSelectPageItemIndex-1)
oldWidget:SetChildActive(selectItemCmpIndex.selectBg,false)
end

local newWidget=self.selectScrollerView:getChildScrollViewItemWidget(selectItemIndex-1)
newWidget:SetChildActive(selectItemCmpIndex.selectBg,true)

self.clickSelectPageItemIndex=selectItemIndex
self.clickSelectGbListIndex=gubaoListIndex
end


function UIBaoLingShuPickUp_ChangeWin:setEndTimer()
self:clearTimer()
local sTime,eTime,nsTime=baoLingShuModel:getGBPickUpTime()
local endTime=timeHelper.convertShortStamp(eTime)
local func=function()
if _this==nil then return end
local nowTime=timeHelper.getServerShortTime()
local lerp=endTime-nowTime

if lerp<=0 then
UIManager.error("本期古宝活动已结束")
return _this:onCloseBtn()
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UIBaoLingShuPickUp_ChangeWin:setUpdateTimer()
self:clearUpdateTimer()
self.updateTimer=self:setTimer(0.05,0,function()self:onUpdate()end)
end

function UIBaoLingShuPickUp_ChangeWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIBaoLingShuPickUp_ChangeWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIBaoLingShuPickUp_ChangeWin:clearAllTimer()
self:clearTimer()
self:clearUpdateTimer()
end




function UIBaoLingShuPickUp_ChangeWin:onCloseBtn()
self:closeSelf()
end



function UIBaoLingShuPickUp_ChangeWin:onLeftBtn()
if not self.pageShowItemIdx_left then
return
end

self:jumpItem(self.pageShowItemIdx_left,true)
end



function UIBaoLingShuPickUp_ChangeWin:onRightBtn()
if not self.pageShowItemIdx_right then
return
end

self:jumpItem(self.pageShowItemIdx_right,true,true)
end



function UIBaoLingShuPickUp_ChangeWin:onMask()
self:closeSelf()
end



function UIBaoLingShuPickUp_ChangeWin:onChangeBtn()
if not self.clickSelectGbListIndex then
return UIManager.error("请选择一期古宝")
end
local configId=baoLingShuModel:getConfId()
local gubaoChangeCfg=cfgHelper.get2(cfg_baolingtreeconfig_get,configId,'qhGuBao')
local costItemId=gubaoChangeCfg[1]
local costItemNeedCount=gubaoChangeCfg[2]

local buyFun=function()
if _this==nil then return end
local iconname=iconHelper.getIconName(costItemId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,30)
local contentStr=FMT.fmt("是否花费<color=#7d3b17>{0}</color>{1}切换至所选职业古宝？",costItemNeedCount,iconStr)
local timeText="本期古宝活动时间仅剩<color=#549327>{0}</color>，"
local sTime,eTime,nsTime=baoLingShuModel:getGBPickUpTime()
local endTime_Short=timeHelper.convertShortStamp(eTime)
local showTime=endTime_Short-86400
local selectGbListIndex=_this.clickSelectGbListIndex
local showdata=
{
type='UIDialougeWithTimeUpdate',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
baoLingShuController:req_getBLSChangePickUpGB(selectGbListIndex)
if _this then
_this:onCloseBtn()
end
end,
showclosebtn=true,
endTime=endTime_Short,
showTime=showTime,
timeText=timeText,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

if moneyConfig.isMoney(costItemId)then
moneySystem:useMoney(costItemId,costItemNeedCount,buyFun,WARNING_TYPE.eWarning)
else
local haveCount=bagControl.invokeFuncByItemId(costItemId,'getItemCountByItemID',costItemId)
if haveCount<costItemNeedCount then
local itemName=itemsModel.getName(costItemId)
UIManager.error(FMT.fmt('{0}不足',itemName))
gainControl:showGainWin(costItemId)
return
else
buyFun()
end
end
end


function UIBaoLingShuPickUp_ChangeWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end
