







def_class("UICommonShowPrizeFourWin",UIWindowBase)









function UICommonShowPrizeFourWin:bindComponents()

self.creater=UIGameobjectClone.new(self,0)
self.effect=UIObject.get(self,1)
self.goodGridPanel=UIObject.get(self,2)
self.goodScrollView=UIObject.get(self,3)
self.tips=UIText.get(self,4)
self.tipsText=UIText.get(self,5)



end


function UICommonShowPrizeFourWin:unbindComponents()
local _UIObject_release=UIObject.release
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.goodGridPanel);self.goodGridPanel=nil;
_UIObject_release(self.goodScrollView);self.goodScrollView=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
end

















local cellSizeX_=84
local cellSizeY_=110
local spaceX_=47
local spaceY_=5
local leftPadding_=30
local topPadding_=10
local colNum_=5




function UICommonShowPrizeFourWin:onLoaded(...)
self:bindComponents()
self.scrollViewWidth=self.goodScrollView:getChildSizeDeltaX()
self.scrollViewHeight=self.goodScrollView:getChildSizeDeltaY()
self.scrollViewPos=self.goodScrollView:getChildAnchoredPosition()

UIManager.setMoneyMsgShowState(false,true)
end


function UICommonShowPrizeFourWin:__delete()
self:unbindComponents()

UIManager.setMoneyMsgShowState(true,true)
end




function UICommonShowPrizeFourWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
local tipsStr=argtable.tips or''
local closeTips=argtable.closeTips or'点击空白区域关闭'

self.networking=false

self.tips:setText(tipsStr)
self.tipsText:setText(closeTips)
self.effect:setChildShowEffect(10014,true)

local rewards=argtable.list
local len=#rewards
self.rewardnum=len

if len>0 then
self.goodGridPanel:setChildLayoutGroupCreateItems(len)
local grids=self.goodGridPanel:getChildLayoutGroupGridList()
for i=1,len do
local rwdata=rewards[i]
local item=grids[i-1]
self:refreshItemPos(item,i)
widgetHelper.setNormalRewardItem(item,0,{rwdata.itemid,rwdata.num,guid=rwdata.itemguid})

item:SetChildCanvasGroupAlpha(-1,0)
end
self:refreswhScrollView()
self.playingAnim=true
self:delayDo(0.3,function()
self:playShow()
end)
else
logErr('没有奖励却打开了UICommonShowPrizeFourWin?')
end
end

function UICommonShowPrizeFourWin:refreshItemPos(item,idx)
local cNum=idx%colNum_
if cNum==0 then cNum=colNum_ end
local x=leftPadding_+cellSizeX_/2+(cNum-1)*(cellSizeX_+spaceX_)
local rowNum=math.ceil(self.rewardnum/colNum_)
if rowNum<=1 then
local cNum_=self.rewardnum%colNum_
if cNum_>0 then
local w1=cNum_*cellSizeX_+(cNum_-1)*spaceX_
local w2=colNum_*cellSizeX_+(colNum_-1)*spaceX_
local lerp=(w2-w1)/2
x=x+lerp
end
end
local rNum=math.ceil(idx/colNum_)
local y=-(topPadding_+cellSizeY_/2+(rNum-1)*(cellSizeY_+spaceY_))
item:SetChildAnchoredPos(-1,x,y)
end

function UICommonShowPrizeFourWin:refreswhScrollView()
local rowNum=math.ceil(self.rewardnum/colNum_)
local h=topPadding_+rowNum*cellSizeY_+(rowNum-1)*spaceY_
self.goodGridPanel:setChildSizeDelta(self.scrollViewWidth,h)
local flag=true
if rowNum<=1 then
flag=false
self.goodScrollView:setChildSizeDelta(self.scrollViewWidth,150)
else
self.goodScrollView:setChildSizeDelta(self.scrollViewWidth,195)
end
self.goodScrollView:setChildScrollRectEnable(flag)
end


function UICommonShowPrizeFourWin:onHide()

end



function UICommonShowPrizeFourWin:onClickBg()
if self.callback then
self.callback()
end
self:closeSelf()
end



function UICommonShowPrizeFourWin:playShow()
local delay=0
local d=0.1
local num=self.rewardnum
local grids=self.goodGridPanel:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
local func=function()
item:SetChildCanvasGroupDOFade(-1,1,0.2)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
delay=delay+d
end
local func2=function()
self:onFinish()
end
self:delayDo(delay,func2)
end

function UICommonShowPrizeFourWin:onFinish()
self.playingAnim=false
end
