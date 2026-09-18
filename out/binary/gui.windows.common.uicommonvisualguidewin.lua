







def_class("UICommonVisualGuideWin",UIWindowBase)









function UICommonVisualGuideWin:bindComponents()

self.arrowBtns=UIObject.get(self,0)
self.bgModel=UIObject.get(self,1)
self.btnLeftMove=UIButton.get(self,2)
self.btnRightMove=UIButton.get(self,3)
self.countDown=UIObject.get(self,4)
self.desc_test=UIText.get(self,5)
self.extends=UIObject.get(self,6)
self.posContent=UIObject.get(self,7)
self.posList=UIObject.get(self,8)
self.Root=UIObject.get(self,9)
self.scrollview=UIObject.get(self,10)
self.uiRoot=UIObject.get(self,11)

self.btnLeftMove:setButtonClick(function()self:onBtnLeftMove()end)

self.btnRightMove:setButtonClick(function()self:onBtnRightMove()end)
self.desc={
["test"]=self.desc_test,
}



end


function UICommonVisualGuideWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrowBtns);self.arrowBtns=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.btnLeftMove);self.btnLeftMove=nil;
_UIObject_release(self.btnRightMove);self.btnRightMove=nil;
_UIObject_release(self.countDown);self.countDown=nil;
_UIObject_release(self.desc_test);self.desc_test=nil;
_UIObject_release(self.extends);self.extends=nil;
_UIObject_release(self.posContent);self.posContent=nil;
_UIObject_release(self.posList);self.posList=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.desc=nil;
end
















local _this=nil

local CmpContentItemIndex={
content_1=0,
title_1=1,
contentImg=2,
desc_1=3,
content_2=4,
scrolview_2=5,
desc_2=6,
title_2=7,
}

local _contentTypeEnum={
Content_Pictrue_Desc=1,
Content_Scrollview_Desc=2,
}




function UICommonVisualGuideWin:onLoaded(...)
self:bindComponents()

_this=self

self.pageCount=0
self.pageLength=1
self.selectConentIndex=0
self.isDrag=false
self.targetHor=0
self.smooting=10

self.pointTargetHor=0
self.pointSmooting=6
self.isAutoMovePoint=false
self.startAutoMoveDV=0.001


self.winlua:SetChildUIDragEvent(self.posList:getID(),0,self.pointBeginDragCallback,nil,nil)

self.updateTimer=self:setTimer(0.02,0,self.onScrollChanged)
end


function UICommonVisualGuideWin:__delete()

_this=nil

self:stopCountDown()

self:unbindComponents()
end




function UICommonVisualGuideWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.uiRoot:setChildCanvasGroupAlpha(0)
self:delayDo(0.1,function()
self.uiRoot:setChildCanvasGroupDOFade(1,0.4,nil)
end)
self.bgModel:setChildUIModelShowTarget(4086,1,{},eAnimationID.enter,false,false,0.3,function()

end)
end

if argtable==nil or argtable.groupId==nil then
return
end




self.groupId=argtable.groupId
self.groupCfg=cfgHelper.get1(cfg_visualguideconfig_get,self.groupId)
self.subItemLen=#self.groupCfg


self.timeFmt_CountDown=argtable.timeFmt
self.beginTime_CountDown=argtable.beginTime
self.endTime_CountDown=argtable.endTime
self.endTips_CountDown=argtable.countDownEndTips
self.isShowCountDown=self.timeFmt_CountDown~=nil and self.beginTime_CountDown~=nil and self.endTime_CountDown~=nil



self.closeCallBack=argtable.closeCallBack


self:refreshAll()
end


function UICommonVisualGuideWin:onHide()

end

function UICommonVisualGuideWin:refreshAll()
self:refreshContent()

self:refreshExtend()
end

function UICommonVisualGuideWin:refreshContent()

self:refreshScrollview()


self:refreshMoveBtns()


self:refreshOtherInfo()
end

function UICommonVisualGuideWin:refreshScrollview()
self.pageCount=self.subItemLen
self.pageLength=1/((self.pageCount-1)==1 and 1 or(self.pageCount-1))
self.scrollview:setChildScrollViewCreateGrids(self.pageCount,self.pageCount)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
self:bindContent(i,item)
end
end

self:refreshPosList()
end

function UICommonVisualGuideWin:bindContent(index,item)
local cfg=self.groupCfg[index]

local isShowItem=cfg~=nil
item:SetChildActive(-1,isShowItem)
if not isShowItem then return end

local freshType=cfg.type

item:SetChildActive(CmpContentItemIndex.content_1,freshType==_contentTypeEnum.Content_Pictrue_Desc)
item:SetChildActive(CmpContentItemIndex.content_2,freshType==_contentTypeEnum.Content_Scrollview_Desc)

if freshType==1 then
self:fresh_Conent_Picture_Desc(index,cfg,item)
elseif freshType==2 then
self:fresh_Content_ScrollView_Desc(index,cfg,item)
end
end

function UICommonVisualGuideWin:fresh_Conent_Picture_Desc(index,cfg,item)
local title=cfg.title
item:SetChildText(CmpContentItemIndex.title_1,title)

local pictrue=cfg.pictrue
item:SetChildCSImageSprite(CmpContentItemIndex.contentImg,pictrue[1],pictrue[2])

local desc=cfg.desc
item:SetChildText(CmpContentItemIndex.desc_1,desc)
end

function UICommonVisualGuideWin:fresh_Content_ScrollView_Desc(index,cfg,item)
local title=cfg.title
item:SetChildText(CmpContentItemIndex.title_2,title)

local width=self.desc_test:getChildSizeDeltaX()
local desc=comHelper.getCheckLayoutStr(self.desc_test:getGameObject(),width,cfg.desc)

item:SetChildText(CmpContentItemIndex.desc_2,desc)
end

function UICommonVisualGuideWin:refreshPosList()
self.posList:setChildScrollViewCreateGrids(self.pageCount,self.pageCount)
self.posItemGrids=self.posList:getChildScrollViewItemWidgets()
self:refreshPosItems()
end

function UICommonVisualGuideWin:refreshPosItems()
local grid
for index=1,self.posItemGrids.Count do
grid=self.posItemGrids[index-1]
if grid then
grid:SetChildActive(0,index==self.selectConentIndex+1)
grid:SetChildButtonClick(-1,function()
self:onClickPagePoint(index)
end,true)
end
end

local width_sw=self.posList:getChildSizeDeltaX()
local width_con=self.posContent:getChildSizeDeltaX()
local npLength=width_con-width_sw
local width_item=36
local space=40

if npLength>0 then

local point_np=self.winlua:GetChildScrollRectNormalizedPosition(self.posList:getID(),true)
local showWidth_left=point_np*npLength
if showWidth_left>npLength then
showWidth_left=npLength
elseif showWidth_left<0 then
showWidth_left=0
end

local showWidth_right=showWidth_left+width_sw

local selectPoint_left=self.selectConentIndex*(width_item+space)
local selectPoint_right=selectPoint_left+width_item

local newPointTargetHor=self.pointTargetHor
local isNeedMove=false

if selectPoint_left<=showWidth_left then

newPointTargetHor=selectPoint_left/npLength
isNeedMove=true
elseif selectPoint_right>=showWidth_right then

newPointTargetHor=(selectPoint_right-width_sw)/npLength
isNeedMove=true
end

if isNeedMove and math.abs(newPointTargetHor-point_np)>=self.startAutoMoveDV then
self.pointTargetHor=newPointTargetHor
self.isAutoMovePoint=true
end
end
end

function UICommonVisualGuideWin:refreshOtherInfo()

end

function UICommonVisualGuideWin:refreshMoveBtns()
self.btnLeftMove:setActive(self.selectConentIndex>0)
self.btnRightMove:setActive(self.selectConentIndex<self.subItemLen-1)
end

function UICommonVisualGuideWin:refreshExtend()
self:refreshCountDown()
end

function UICommonVisualGuideWin:refreshCountDown()
self.countDown:setActive(self.isShowCountDown)

if not self.isShowCountDown then return end

local wb=self.countDown:getChildWidgetBase()

self:startCountDown(wb)
end


function UICommonVisualGuideWin:startCountDown(wb)
self:stopCountDown()

local nowTime=timeHelper.getServerShortTime()
local isEnd=self.endTime_CountDown-nowTime>0

if not isEnd then
wb:SetChildText(0,_this.endTips_CountDown)
return
end

local desc,leftTime
local func=function()
nowTime=timeHelper.getServerShortTime()
leftTime=_this.endTime_CountDown-nowTime
desc=FMT.fmt(_this.timeFmt_CountDown,timeHelper.format_time_stamp3(leftTime))
wb:SetChildText(0,desc)
if leftTime<=0 then
if _this~=nil then
_this:stopCountDown()
wb:SetChildText(0,_this.endTips_CountDown)
end
end
end

self.timerId_CountDown=self:setTimer(1,0,func)
func()
end

function UICommonVisualGuideWin:stopCountDown()
if self.timerId_CountDown then
self:stopTimerByID(self.timerId_CountDown)
self.timerId_CountDown=nil
end
end


function UICommonVisualGuideWin.beginDragCallback()
_this.isDrag=true
end

function UICommonVisualGuideWin.endDragCallback()
_this.isDrag=false

local posX=_this.winlua:GetChildScrollRectNormalizedPosition(_this.scrollview:getID(),true)
local index=0
local offset=Mathf.Abs(-posX)
for i=1,_this.pageCount do
local temp=Mathf.Abs(_this.pageLength*i-posX)
if(temp<offset)then
index=i
offset=temp
end
end
_this.selectConentIndex=index

_this.targetHor=_this.pageLength*_this.selectConentIndex
_this:refreshMoveBtns()

_this:refreshPosItems()
end

function UICommonVisualGuideWin.onScrollChanged()







if _this.isAutoMovePoint then
local point_np=_this.winlua:GetChildScrollRectNormalizedPosition(_this.posList:getID(),true)
if math.abs(_this.pointTargetHor-point_np)>=_this.startAutoMoveDV then
_this.winlua:SetChildScrollRectNormalizedPosition(_this.posList:getID(),true,Mathf.Lerp(point_np,_this.pointTargetHor,Time.deltaTime*_this.pointSmooting))
else
_this.isAutoMovePoint=false
end
end
end

function UICommonVisualGuideWin.pointBeginDragCallback()
_this.isAutoMovePoint=false
end

function UICommonVisualGuideWin:onClickPagePoint(index)
if self.selectConentIndex==index-1 then
return
end


self.selectConentIndex=index-1

self:jumpPage(self.selectConentIndex)

self:refreshMoveBtns()

self:refreshPosItems()
end

function UICommonVisualGuideWin:jumpPage(index)
self:clearFadeTweener()
self.scrollview:setChildCanvasGroupAlpha(0)
self.scrollview:setChildScrollViewSelectItem(index,false,false,false)
self.fadeTweener=self.scrollview:setChildCanvasGroupDOFade(1,1.5)
end

function UICommonVisualGuideWin:clearFadeTweener()
if self.fadeTweener then
self.fadeTweener:Kill(false)
self.fadeTweener=nil
end
end



function UICommonVisualGuideWin:onCloseSelf()
if self.closeCallBack then
self.closeCallBack()
end
self:closeSelf()
end

function UICommonVisualGuideWin:onBtnLeftMove()
if self.selectConentIndex<0 then return end
self.selectConentIndex=self.selectConentIndex-1


self:jumpPage(self.selectConentIndex)
self:refreshMoveBtns()
self:refreshPosItems()
end

function UICommonVisualGuideWin:onBtnRightMove()
if self.selectConentIndex>self.subItemLen-1 then return end
self.selectConentIndex=self.selectConentIndex+1


self:jumpPage(self.selectConentIndex)
self:refreshMoveBtns()
self:refreshPosItems()
end
