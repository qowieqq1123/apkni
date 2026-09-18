







def_class("UIFuBaoPingJiRewardWin",UIWindowBase)









function UIFuBaoPingJiRewardWin:bindComponents()

self.reddot=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.fubaoItem=UIObject.get(self,2)
self.ratingText=UIText.get(self,3)
self.scrollview=UIObject.get(self,4)
self.receiveBtn=UIButton.get(self,5)
self.name=UIText.get(self,6)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)



end


function UIFuBaoPingJiRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.reddot);self.reddot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.fubaoItem);self.fubaoItem=nil;
_UIObject_release(self.ratingText);self.ratingText=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.name);self.name=nil;
end



















function UIFuBaoPingJiRewardWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIFuBaoPingJiRewardWin:__delete()
self:unbindComponents()
end




function UIFuBaoPingJiRewardWin:onShow(argtable,afterOnloaded)
local config=argtable
self.config=config
self.rateCfg=cfg_fubaoratingconfig()











self.name:setText(self.config.name)

widgetHelper.setNormalRewardItem(self.winlua,self.fubaoItem:getID(),{config.itemId,0,noClick=true})


local curRate=UIFuLuFangModel:getRating(config.id)
self.ratingText:setText(FMT.fmt('当前：{0}',self.rateCfg[curRate].name))


self:refreshRewardsList()
end


function UIFuBaoPingJiRewardWin:onHide()

end

function UIFuBaoPingJiRewardWin:refreshRewardsList()
local list=UIFuLuFangModel:getRateRewardList(self.config)
local fbData=UIFuLuFangModel:getFuLuData(self.config.id)
local isGotAll=true
self.scrollview:setChildScrollViewCreateGrids(#list,1)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local item=self.grids[i-1]
local data=list[i]
local rate=data[1]
local items=data[2]
local itemData=items[1]
local itemid=itemData[1]
local itemcount=itemData[2]

local arriveRate=fbData and fbData.level>=rate
local rateStr=''
if arriveRate then
rateStr=FMT.fmt('<color=#549327>评级达到{0}</color>',self.rateCfg[rate].name)
else
rateStr=FMT.fmt('评级达到{0}（未获得）',self.rateCfg[rate].name)
end
item:SetChildText(0,rateStr)

local isGot=UIFuLuFangModel:checkRateRewardIsGot(self.config.id,rate)
if not isGot then
isGotAll=false
end
item:SetChildActive(1,isGot)







local clickFunc=function()
tipsManager.showTips({itemid=itemid,move=TIPS_MOVE_POS.eLeft})
end
widgetHelper.setNormalRewardItem(item,2,{itemid,itemcount,showStage=true,clickFunc=clickFunc})
end

local checkReward=UIFuLuFangModel:checkFuLuRateReward(self.config.id)
self.reddot:setActive(checkReward)
self.receiveBtn:setButtonEnable(true,not checkReward)
self.receiveBtn:setActive(not isGotAll)

local canScroll=#list>3
local scrolRect=self.scrollview:getCommonComponent('ScrollRect')
scrolRect.enabled=canScroll
end



function UIFuBaoPingJiRewardWin:onReceiveBtn()
local checkReward=UIFuLuFangModel:checkFuLuRateReward(self.config.id)
if checkReward then
UIFullFuLuFangControl:reqReceiveFLLevelReward(self.config.id,0)
else
UIManager.error('祖师还需努力提升评级')
end
end

function UIFuBaoPingJiRewardWin:onCloseClick()
self:closeSelf()
end
