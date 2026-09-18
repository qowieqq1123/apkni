







def_class("UIXianGongPingDingWin",UIWindowBase)









function UIXianGongPingDingWin:bindComponents()

self.titleName=UIText.get(self,0)
self.ScrollView=UILoopListView.new(self,1)
self.totalpingfen=UIText.get(self,2)
self.progressBar=UIProgressBarAni.get(self,3)
self.Content=UIObject.get(self,4)
self.btnClose=UIButton.get(self,5)
self.temp=UIObject.get(self,6)

self.ScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIXianGongPingDingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleName);self.titleName=nil;
self.ScrollView:deleteSelf();self.ScrollView=nil;
_UIObject_release(self.totalpingfen);self.totalpingfen=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.temp);self.temp=nil;
end

















local _slotName='item'
local _itemWidth=82
local _space=64
local _left=0

function UIXianGongPingDingWin:onLoaded(...)
self:bindComponents()
end

function UIXianGongPingDingWin:__delete()
self:unbindComponents()
end

function UIXianGongPingDingWin:onShow(argtable,afterOnloaded)
xiangongpingdingController:send_6_8()
end

function UIXianGongPingDingWin:onHide()

end





function UIXianGongPingDingWin:onBtnClose()
self:closeSelf()
end

function UIXianGongPingDingWin:freshInfo()
self:freshHisPanel()
self:freshPingFen()
end

function UIXianGongPingDingWin:freshHisPanel()
local list=xiangongpingdingModel:getHisList()
local len=#list
if len>0 then
self.temp:setActive(false)
self.ScrollView:initData(_slotName,list)
else
self.temp:setActive(true)
end
end


function UIXianGongPingDingWin:onFreshAction(i,widget,pingdingInfo)
local qiShu=pingdingInfo.qiShu
local pingJi=pingdingInfo.pingJi
local shortStamp=pingdingInfo.pjTime
local year=gameUtilityModel.getGameYearPass(shortStamp)
local assetname=xiangongpingdingModel:getPJImage(pingJi)
widget:SetChildCSImageSprite(0,globalABLookup.xdpdicons,assetname)
widget:SetChildText(1,FMT.fmt('宗门年历\n第{0}年',year))
widget:SetChildText(2,FMT.fmt('第{0}期仙宫总评',qiShu))
end

function UIXianGongPingDingWin:freshPingFen()
local zpfReward=cfgHelper.get2(cfg_xiangongpingdingbaseconfig_get,1,'zpfReward')
local len=#zpfReward
self.canPrizeIndex=nil
self.isPrizeMaxIndex=nil
self.winlua:SetChildLayoutGroupCreateItems(self.Content:getID(),len,function(index)
self:fillItem(index,zpfReward[index])
end)

local prizeIndex=0
for i,rewardInfo in ipairs(zpfReward)do
local pingfen=rewardInfo[1]
local jindu=xiangongpingdingModel:getPrizeJinDu()
local isPrize=jindu>=pingfen
if isPrize and i>prizeIndex then
prizeIndex=i
end
end
local max=_itemWidth*len+(len-1)*_space+_left
local val=_itemWidth*prizeIndex+(prizeIndex-1)*_space+_left
self.winlua:SetChildSizeDelta(self.progressBar:getID(),max,27)
self.progressBar:animateThreeParams(val,max,0)

local ljpf=xiangongpingdingModel:getLJPingFen()
self.totalpingfen:setText(ljpf)
local index=1
if self.canPrizeIndex then
index=self.canPrizeIndex
else
if self.isPrizeMaxIndex and self.isPrizeMaxIndex<len then
index=self.isPrizeMaxIndex+1
end
end

self:jumpIndex(index)
end

function UIXianGongPingDingWin:fillItem(index,rewardInfo)
local ljpf=xiangongpingdingModel:getLJPingFen()
local widget=self.winlua:GetChildLayoutGroupGridItem(self.Content:getID(),index-1)
local pingfen=rewardInfo[1]
local rewards=rewardInfo[2]
local jindu=xiangongpingdingModel:getPrizeJinDu()
local isPrize=jindu>=pingfen
local canPrize=ljpf>=pingfen and not isPrize or false
if canPrize and self.canPrizeIndex==nil then
self.canPrizeIndex=index
end
if isPrize then
if self.isPrizeMaxIndex==nil or index>self.isPrizeMaxIndex then
self.isPrizeMaxIndex=index
end
end
local data={}
data[1]=rewards[1]
data[2]=rewards[2]
data.noClick=true
local item=widgetHelper.setNormalRewardItem(widget,0,rewards[1])
item:SetChildGraphicGray(2,isPrize,false,false)
if canPrize then
item:SetChildButtonClick(3,function()
xiangongpingdingController:send_6_9()
end)
else
item:SetChildButtonClick(3,function()
tipsManager.showTips({formType=TIPS_FORM_TYPE.eClearBtn,
showModel=true,
itemid=rewards[1][1]})
end)
end

widget:SetChildActive(1,isPrize)
widget:SetChildActive(2,false)
widget:SetChildText(3,FMT.fmt('{0}分',pingfen))
widget:SetChildActive(4,canPrize)
end

function UIXianGongPingDingWin:onStartAction()

end

function UIXianGongPingDingWin:jumpIndex(index)
local func=function()
if self==nil or self.isClose then return end
local r=index
local viewWidth=705
local contentWidth=self.winlua:GetChildSizeDeltaX(self.Content:getID())
local itemWidth=82+64
local posX=(r-1)*itemWidth
if posX<=0 then posX=0 end
local div=contentWidth-viewWidth
if div<0 then div=0 end
if posX>div then posX=div end
self.winlua:SetChildAnchoredPos(self.Content:getID(),-posX,0)
end
self:delayDo(0.1,func)
end