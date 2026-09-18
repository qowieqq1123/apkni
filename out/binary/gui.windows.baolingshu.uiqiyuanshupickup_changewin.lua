







def_class("UIQiYuanShuPickUp_ChangeWin",UIWindowBase)









function UIQiYuanShuPickUp_ChangeWin:bindComponents()

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
self.selectlist=UIObject.get(self,13)
self.btnpanel=UIObject.get(self,14)
self.upbtn=UIButton.get(self,15)
self.downbtn=UIButton.get(self,16)
self.pagtxt=UIText.get(self,17)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.mask:setButtonClick(function()self:onMask()end)

self.changeBtn:setButtonClick(function()self:onChangeBtn()end)

self.upbtn:setButtonClick(function()self:onUpbtn()end)

self.downbtn:setButtonClick(function()self:onDownbtn()end)



end


function UIQiYuanShuPickUp_ChangeWin:unbindComponents()
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
_UIObject_release(self.selectlist);self.selectlist=nil;
_UIObject_release(self.btnpanel);self.btnpanel=nil;
_UIObject_release(self.upbtn);self.upbtn=nil;
_UIObject_release(self.downbtn);self.downbtn=nil;
_UIObject_release(self.pagtxt);self.pagtxt=nil;
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
local selectItemCmpIndex2=
{
name=0,
rewardGrids=1,
selectFlag=2,
bg=3,
root=4,
btn=5,
xqbtn=6,
bgmodel=7,
}
local abname='ui/windows/baolingshu/qiyuanshu_atlas_pak.ab'
local stateFalg=
{
enter=1,
upanddown=2,
onlyup=3,
onlydown=4,
}




function UIQiYuanShuPickUp_ChangeWin:onLoaded(...)
_this=self
self:bindComponents()
self.selectpageidx=1
self.lib_list={}
end


function UIQiYuanShuPickUp_ChangeWin:__delete()
_this=nil
self:clearAllTimer()
self:clearOpenTipsTimer()
self:clearRemainingTipsTimer()
self:unbindComponents()
end


function UIQiYuanShuPickUp_ChangeWin:onSelectGbList(selectItemIndex,gubaoListIndex)
local isClickSelect=selectItemIndex==self.clickSelectPageItemIndex
if isClickSelect then
return
end
if gubaoListIndex==self.lib_id then
return UIManager.error("当前已为该档期古宝")
end
local Mainwidget=self.selectlist:getChildWidgetBase()
if self.clickSelectPageItemIndex then

local oldWidget=Mainwidget:GetChildWidgetBase(self.clickSelectPageItemIndex-1)
self:ChangeSelectBg(oldWidget,self.clickSelectPageItemIndex,false)
end

local newWidget=Mainwidget:GetChildWidgetBase(selectItemIndex-1)
self:ChangeSelectBg(newWidget,selectItemIndex,true)

self.clickSelectPageItemIndex=selectItemIndex
self.clickSelectGbListIndex=gubaoListIndex
end

function UIQiYuanShuPickUp_ChangeWin:onXQGbList(selectItemIndex,gubaoListIndex)
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.blsrewards,{cjType=1,showType=2,qysId=gubaoListIndex})
end

function UIQiYuanShuPickUp_ChangeWin:onUpbtn()
if self.selectpageidx==1 then
return
end
self.selectpageidx=self.selectpageidx-1
self:freshpagtxt()
self:setBtnGray()
local oldlist=self._List[self.selectpageidx+1]
local newlist=self._List[self.selectpageidx]
local num=#newlist-#oldlist
if num==0 then
self:refresh2(false,{stateFalg.upanddown,stateFalg.upanddown,stateFalg.upanddown})
elseif num==1 then
self:refresh2(false,{stateFalg.upanddown,stateFalg.upanddown,stateFalg.onlydown})
elseif num==2 then
self:refresh2(false,{stateFalg.upanddown,stateFalg.onlydown,stateFalg.onlydown})
end
end

function UIQiYuanShuPickUp_ChangeWin:onDownbtn()
if self.selectpageidx==self.ListMax then
return
end
self.selectpageidx=self.selectpageidx+1
self:freshpagtxt()
self:setBtnGray()
local oldlist=self._List[self.selectpageidx-1]
local newlist=self._List[self.selectpageidx]
local num=#oldlist-#newlist
if num==0 then
self:refresh2(false,{stateFalg.upanddown,stateFalg.upanddown,stateFalg.upanddown})
elseif num==1 then
self:refresh2(false,{stateFalg.upanddown,stateFalg.upanddown,stateFalg.onlyup})
elseif num==2 then
self:refresh2(false,{stateFalg.upanddown,stateFalg.onlyup,stateFalg.onlyup})
end
end




function UIQiYuanShuPickUp_ChangeWin:onShow(argtable,afterOnloaded)
self.nowSelectPageIndex=1
if afterOnloaded then
self.backPanel:setChildCanvasGroupAlpha(0)
self.frontPanel:setChildCanvasGroupAlpha(0)
self.backPanel:setChildCanvasGroupDOFade(1,1)
self.frontPanel:setChildCanvasGroupDOFade(1,1)

self.winlua:SetChildUIModelShowTarget(self.bgModel:getID(),6169,1,{},eAnimationID.enter)
self.winlua:SetChildUIModelShowTarget(self.boatModel:getID(),6170,1,{},eAnimationID.enter)
end

self:refresh2(afterOnloaded,false)

self:refreshtime()

end


function UIQiYuanShuPickUp_ChangeWin:onHide()
self:clearAllTimer()
end

function UIQiYuanShuPickUp_ChangeWin:onUpdate()

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

function UIQiYuanShuPickUp_ChangeWin:refresh(isInit)
self.lib_id=qiYuanShuModel:getQiYuanShuId()
local roundList={0}
local _List=qiYuanShuModel:getQiYuanShuOpenlist()
for k,v in ipairs(_List)do
table.insert(roundList,v)
end
local roundListCount=#roundList
self.maxListIndex=roundListCount
if isInit then
self:initItemPosList()
end
local jumpIndex=1
self.selectScrollerView:setChildScrollViewCreateGrids(roundListCount,roundListCount)
local grids=self.selectScrollerView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local gubaoListIndex=roundList[i]
widget:SetChildActive(-1,true)
local guBaoSuitCfg=qiYuanShuModel:getQiYuanShu_Suit(gubaoListIndex)


local name=guBaoSuitCfg[1]
widget:SetChildText(selectItemCmpIndex.name,name)


local isClickSelect=i==self.clickSelectPageItemIndex
widget:SetChildActive(selectItemCmpIndex.selectBg,isClickSelect)


local isSelect=gubaoListIndex==self.lib_id
if isSelect then
jumpIndex=i
end
widget:SetChildActive(selectItemCmpIndex.selectFlag,isSelect)


local rewards=guBaoSuitCfg[2]
local rewardGridsList=widget:GetChildCommonLayoutGroupWidgetList(selectItemCmpIndex.rewardGrids)
for i=1,rewardGridsList.Count do
local itemGrid=rewardGridsList[i-1]
local itemid=rewards[i]
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


function UIQiYuanShuPickUp_ChangeWin:setLibList()
local roundList={0}
self._List={}
local List=qiYuanShuModel:getQiYuanShuOpenlist()
for k,v in ipairs(List)do
table.insert(roundList,v)
end
local list={}
local index2=1
local temp={}
for k,v in ipairs(roundList)do
temp[#temp+1]=v
list[index2]=temp
if#temp==3 then
index2=index2+1
temp={}
end
end
self._List=list
self.ListMax=#self._List
end

function UIQiYuanShuPickUp_ChangeWin:refresh2(isInit,ischange)
self.lib_id=qiYuanShuModel:getQiYuanShuId()








if isInit then
self:setLibList()
if self._List and#self._List>1 then
self.btnpanel:setActive(true)
else
self.btnpanel:setActive(false)
end
self:setBtnGray()
end
local roundList=self._List[self.selectpageidx]
local roundListCount=#roundList
self.maxListIndex=roundListCount

for i=1,3 do
local Mainwidget=self.selectlist:getChildWidgetBase()
local widget=Mainwidget:GetChildWidgetBase(i-1)
if roundListCount>=i then
if isInit then
widget:SetChildActive(-1,true)
end
local gubaoListIndex=roundList[i]
local guBaoSuitCfg=qiYuanShuModel:getQiYuanShu_Suit(gubaoListIndex)
local name=guBaoSuitCfg[1]
widget:SetChildText(selectItemCmpIndex2.name,name)

local isClickSelect=i==self.clickSelectPageItemIndex
self:ChangeSelectBg(widget,i,isClickSelect)

local isSelect=gubaoListIndex==self.lib_id
widget:SetChildActive(selectItemCmpIndex2.selectFlag,isSelect)


local rewards=guBaoSuitCfg[2]
local rewardGridsList=widget:GetChildCommonLayoutGroupWidgetList(selectItemCmpIndex2.rewardGrids)
for i=1,rewardGridsList.Count do
local itemGrid=rewardGridsList[i-1]
if rewards[i]then
if i==1 then
if#rewards==6 then
itemGrid:SetChildLocalPosX(-1,-62)
else
itemGrid:SetChildLocalPosX(-1,0)
end
end
itemGrid:SetChildActive(-1,true)
local itemid=rewards[i]
local conf={itemid=itemid,itemcount="",showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemGrid:SetChildPropData(0,prop)
itemGrid:SetBaseItemClickEvent(0,function(...)
self:onClickRewardItem(...)
end)
local itemName=itemsConfig.getItemName(itemid)
itemGrid:SetChildText(1,itemName)
else
itemGrid:SetChildActive(-1,false)
end
end


if isInit then
self:doSpiine(widget,i,stateFalg.enter)
end
if ischange and ischange[i]then
self:doSpiine(widget,i,ischange[i])
end


widget:SetChildButtonClick(selectItemCmpIndex2.btn,function()
self:onSelectGbList(i,gubaoListIndex)
end)

widget:SetChildButtonClick(selectItemCmpIndex2.xqbtn,function()
self:onXQGbList(i,gubaoListIndex)
end)
else

if isInit then
widget:SetChildActive(-1,false)
self:doSpiine(widget,i,stateFalg.enter)
end
if ischange and ischange[i]then
self:doSpiine(widget,i,ischange[i])
end
end
end


self:refreshCost()

self:freshpagtxt()
end

function UIQiYuanShuPickUp_ChangeWin:ChangeSelectBg(widget,i,isClickSelect)

if widget then















if isClickSelect then
widget:SetChildActive(selectItemCmpIndex2.bg,true)
else
widget:SetChildActive(selectItemCmpIndex2.bg,false)
end
end
end

function UIQiYuanShuPickUp_ChangeWin:doSpiine(widget,i,flag)
if flag==1 then
widget:SetChildCanvasGroupAlpha(selectItemCmpIndex2.root,0)
if i==1 then
widget:SetChildUIModelShowTarget(selectItemCmpIndex2.bgmodel,6171,1,{},3302)
self.delay1=self:delayDo(1.2,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,1,0.6,nil)
end)
elseif i==2 then
widget:SetChildUIModelShowTarget(selectItemCmpIndex2.bgmodel,6172,1,{},3302)
self.delay2=self:delayDo(1.2,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,1,0.6,nil)
end)
elseif i==3 then
widget:SetChildUIModelShowTarget(selectItemCmpIndex2.bgmodel,6173,1,{},3302)
self.delay3=self:delayDo(1.2,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,1,0.6,nil)
end)
end

elseif flag==2 then
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,0,0.2,function()
if _this==nil then return end
widget:SetChildModelAnimationState(selectItemCmpIndex2.bgmodel,3303)
if i==1 then
self.delay1=self:delayDo(1.2,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,1,0.6,nil)
end)
elseif i==2 then
self.delay2=self:delayDo(1.2,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,1,0.6,nil)
end)
elseif i==3 then
self.delay3=self:delayDo(1.2,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,1,0.6,nil)
end)
end
end)

elseif flag==3 then
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,0,0.2,function()
if _this==nil then return end
widget:SetChildModelAnimationState(selectItemCmpIndex2.bgmodel,3305)
end)

elseif flag==4 then
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,0,0.2,function()
if _this==nil then return end
if i==1 then
self.delaydown1=self:delayDo(0.6,function()
if _this==nil then return end
widget:SetChildModelAnimationState(selectItemCmpIndex2.bgmodel,3304)
end)
self.delay1=self:delayDo(1.2,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,1,0.6,nil)
end)
elseif i==2 then
self.delaydown2=self:delayDo(0.6,function()
if _this==nil then return end
widget:SetChildModelAnimationState(selectItemCmpIndex2.bgmodel,3304)
end)
self.delay2=self:delayDo(1.2,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,1,0.6,nil)
end)
elseif i==3 then
self.delaydown3=self:delayDo(0.6,function()
if _this==nil then return end
widget:SetChildModelAnimationState(selectItemCmpIndex2.bgmodel,3304)
end)
self.delay3=self:delayDo(1.2,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,1,0.6,nil)
end)
end
end)
end
end

function UIQiYuanShuPickUp_ChangeWin:freshpagtxt()
self.pagtxt:setText(FMT.fmt("{0}/{1}",self.selectpageidx,self.ListMax))
end

function UIQiYuanShuPickUp_ChangeWin:setBtnGray()
if self.selectpageidx==1 then
self.winlua:SetChildGray(self.upbtn:getID(),true)
self.winlua:SetChildGray(self.downbtn:getID(),false)
elseif self.selectpageidx==self.ListMax then
self.winlua:SetChildGray(self.upbtn:getID(),false)
self.winlua:SetChildGray(self.downbtn:getID(),true)
end
end


function UIQiYuanShuPickUp_ChangeWin:testttttt(i,flag)
local Mainwidget=_this.selectlist:getChildWidgetBase()
local widget=Mainwidget:GetChildWidgetBase(i-1)
if flag==2 then
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,0,0.2,function()
if _this==nil then return end
widget:SetChildModelAnimationState(selectItemCmpIndex2.bgmodel,3303)
_this.delay1=_this:delayDo(1.2,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,1,0.6,nil)
end)
end)
elseif flag==3 then
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,0,0.2,function()
if _this==nil then return end
widget:SetChildModelAnimationState(selectItemCmpIndex2.bgmodel,3305)
end)
elseif flag==4 then
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,0,0.2,function()
if _this==nil then return end
widget:SetChildModelAnimationState(selectItemCmpIndex2.bgmodel,3304)
_this.delay1=_this:delayDo(1,function()
if _this==nil then return end
widget:SetChildCanvasGroupDOFade(selectItemCmpIndex2.root,1,0.6,nil)
end)
end)
end
end

function UIQiYuanShuPickUp_ChangeWin:refreshCost()
local gubaoChangeCfg=qiYuanShuModel:getQiYuanShu_cost(self.lib_id)
if gubaoChangeCfg then
self.changeCostText:setActive(true)
local costItemId=gubaoChangeCfg[1][1]
local costItemNeedCount=gubaoChangeCfg[1][2]
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
else
self.changeCostText:setActive(false)
end
end

function UIQiYuanShuPickUp_ChangeWin:jumpItem(index,animation,alignEnd)
self.nowSelectItemIndex=index
local jumpIndex=index
if jumpIndex<=1 then
jumpIndex=0
elseif jumpIndex>=self.maxListIndex then
jumpIndex=self.maxListIndex+1
end
self.selectScrollerView:setChildScrollViewSelectItem(jumpIndex-1,animation or false,false,alignEnd or false)
end

function UIQiYuanShuPickUp_ChangeWin:initItemPosList()
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

function UIQiYuanShuPickUp_ChangeWin:refreshArrowBtn()
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

function UIQiYuanShuPickUp_ChangeWin:setEndTimer()
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

function UIQiYuanShuPickUp_ChangeWin:setUpdateTimer()
self:clearUpdateTimer()
self.updateTimer=self:setTimer(0.05,0,function()self:onUpdate()end)
end

function UIQiYuanShuPickUp_ChangeWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIQiYuanShuPickUp_ChangeWin:clearUpdateTimer()
if self.updateTimer then
self:stopTimerByID(self.updateTimer)
self.updateTimer=nil
end
end

function UIQiYuanShuPickUp_ChangeWin:clearAllTimer()
self:clearTimer()
self:clearUpdateTimer()
self:cleardelaysTimer()
end
function UIQiYuanShuPickUp_ChangeWin:cleardelaysTimer()
if self.delay1 then
self:stopTimerByID(self.delay1)
self.delay1=nil
end
if self.delay2 then
self:stopTimerByID(self.delay2)
self.delay2=nil
end
if self.delay3 then
self:stopTimerByID(self.delay3)
self.delay3=nil
end
if self.delaydown1 then
self:stopTimerByID(self.delaydown1)
self.delaydown1=nil
end
if self.delaydown2 then
self:stopTimerByID(self.delaydown2)
self.delaydown2=nil
end
if self.delaydown3 then
self:stopTimerByID(self.delaydown3)
self.delaydown3=nil
end
end


function UIQiYuanShuPickUp_ChangeWin:refreshtime()
self:clearTimer()
local isInQiYuanNow=qiYuanShuModel:checkIsInQiYuanNow()
if isInQiYuanNow then
self:setRemainingTipsTimer()
else
self:setOpenTipsTimer()
end
end
function UIQiYuanShuPickUp_ChangeWin:setRemainingTipsTimer()
self:clearRemainingTipsTimer()
local func=function()

local sTime,eTime=qiYuanShuModel:getQiYuanTime()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=eTime and eTime-nowTime or 0
if lerp>0 then
else
UIManager.error("本期古宝活动已结束")
return _this:onCloseBtn()
end
end
func()
self.timer=self:setTimer(1,0,func)
end
function UIQiYuanShuPickUp_ChangeWin:clearRemainingTipsTimer()
if self.openTipsTimer then
self:stopTimerByID(self.openTipsTimer)
self.openTipsTimer=nil
end
end
function UIQiYuanShuPickUp_ChangeWin:setOpenTipsTimer()
self:clearOpenTipsTimer()
local func=function()

local sTime,eTime=qiYuanShuModel:getQiYuanTime()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=sTime and sTime-nowTime or 0
if lerp>0 then

else
UIManager.error("本期古宝活动已结束")
return _this:onCloseBtn()
end
end
func()
self.timer=self:setTimer(1,0,func)
end
function UIQiYuanShuPickUp_ChangeWin:clearOpenTipsTimer()
if self.openTipsTimer then
self:stopTimerByID(self.openTipsTimer)
self.openTipsTimer=nil
end
end








function UIQiYuanShuPickUp_ChangeWin:onCloseBtn()
self:closeSelf()
end



function UIQiYuanShuPickUp_ChangeWin:onLeftBtn()
if not self.pageShowItemIdx_left then
return
end

self:jumpItem(self.pageShowItemIdx_left,true)
end



function UIQiYuanShuPickUp_ChangeWin:onRightBtn()
if not self.pageShowItemIdx_right then
return
end

self:jumpItem(self.pageShowItemIdx_right,true,true)
end



function UIQiYuanShuPickUp_ChangeWin:onMask()
self:closeSelf()
end


function UIQiYuanShuPickUp_ChangeWin:onChangeBtn()
if not self.clickSelectGbListIndex then
return UIManager.error("请选择一期古宝")
end
local gubaoChangeCfg=qiYuanShuModel:getQiYuanShu_cost(self.lib_id)
if gubaoChangeCfg then
local costItemId=gubaoChangeCfg[1][1]
local costItemNeedCount=gubaoChangeCfg[1][2]

local buyFun=function()
if _this==nil then return end
local iconname=iconHelper.getIconName(costItemId)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,30)
local contentStr=FMT.fmt("是否花费<color=#7d3b17>{0}</color>{1}切换至所选古宝？",costItemNeedCount,iconStr)
local timeText="本期古宝活动时间仅剩<color=#549327>{0}</color>，"
local sTime,eTime=qiYuanShuModel:getQiYuanTime()
local endTime_Short=eTime
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
qiYuanShuController:req_qiyuanshu_change(selectGbListIndex)
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
else
qiYuanShuController:req_qiyuanshu_change(self.clickSelectGbListIndex)
if _this then
_this:onCloseBtn()
end
end
end


function UIQiYuanShuPickUp_ChangeWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid})
end
