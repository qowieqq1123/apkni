







def_class("UIShangHangLeftWin",UIWindowBase)









function UIShangHangLeftWin:bindComponents()

self.blackImg=UIObject.get(self,0)
self.qipao_1=UIObject.get(self,1)
self.maskBlock=UIObject.get(self,2)
self.bgImg=UIImage.get(self,3)
self.qipiaoText_1=UIText.get(self,4)
self.itemRed=UIObject.get(self,5)
self.menuScrollView=UIObject.get(self,6)
self.itemButton=UIButton.get(self,7)
self.model=UIObject.get(self,8)
self.rongyuRed=UIObject.get(self,9)
self.root=UIObject.get(self,10)
self.wanfaButton=UIButton.get(self,11)
self.fazeButton=UIButton.get(self,12)
self.rongyuButton=UIButton.get(self,13)
self.rankButton=UIButton.get(self,14)
self.menuGrid=UIObject.get(self,15)

self.itemButton:setButtonClick(function()self:onItemButton()end)

self.wanfaButton:setButtonClick(function()self:onWanfaButton()end)

self.fazeButton:setButtonClick(function()self:onFazeButton()end)

self.rongyuButton:setButtonClick(function()self:onRongyuButton()end)

self.rankButton:setButtonClick(function()self:onRankButton()end)
self.qipao={
self.qipao_1,
}
self.qipiaoText={
self.qipiaoText_1,
}



end


function UIShangHangLeftWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.qipao_1);self.qipao_1=nil;
_UIObject_release(self.maskBlock);self.maskBlock=nil;
_UIObject_release(self.bgImg);self.bgImg=nil;
_UIObject_release(self.qipiaoText_1);self.qipiaoText_1=nil;
_UIObject_release(self.itemRed);self.itemRed=nil;
_UIObject_release(self.menuScrollView);self.menuScrollView=nil;
_UIObject_release(self.itemButton);self.itemButton=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.rongyuRed);self.rongyuRed=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.wanfaButton);self.wanfaButton=nil;
_UIObject_release(self.fazeButton);self.fazeButton=nil;
_UIObject_release(self.rongyuButton);self.rongyuButton=nil;
_UIObject_release(self.rankButton);self.rankButton=nil;
_UIObject_release(self.menuGrid);self.menuGrid=nil;
self.qipao=nil;
self.qipiaoText=nil;
end



















function UIShangHangLeftWin:onLoaded(...)
self:bindComponents()
end


function UIShangHangLeftWin:__delete()
self:unbindComponents()
end




function UIShangHangLeftWin:onShow(argtable,afterOnloaded)

shangHangController:send_248_100()
local list=shangHangModel:getItemList()
self.itemButton:setActive(#list>0)

self.model:setChildUIModelShowTarget(1113008,1.3,{},eAnimationID.stand,false,nil,0)
self.model:setChildUIModelShowFlipX(true)

self:refreshRongyuRed()

self:startSpeak(8)
end

function UIShangHangLeftWin:onShowArgRecv(argtable)

end


function UIShangHangLeftWin:onHide()

end

function UIShangHangLeftWin:refreshRongyuRed()
local comment_cnt=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"comment_cnt")
local data=shanmenModel:get_gushen_data()
self.rongyuRed:setActive(data~=nil and next(data)~=nil and data.server~=0 and shangHangModel:getLikeOrHateCnt()<comment_cnt)
end

function UIShangHangLeftWin:startSpeak(delay)
self:stopSpeak()
local cfg=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"mainSpeakText")
local list=cfg
if list then
self.speak=self:setTimer(delay,0,function()
self.qipao_1:setChildCanvasGroupAlpha(0)
self.qipao_1:setChildCanvasGroupDOFade(1,0.2)

self.qipiaoText_1:setText(list[math.random(1,#list)])
local hide=self.qipao_1:setChildCanvasGroupDOFade(0,0.2)
hide:SetDelay(2)
end)
end
end

function UIShangHangLeftWin:stopSpeak()
if self.speak then
self:stopTimerByID(self.speak)
self.speak=nil
end
end

function UIShangHangLeftWin:refreshItemButton()
local list=shangHangModel:getItemList()
local active=#list>0
self.itemButton:setActive(active)
if active then
local reddot=true
local now=timeHelper.getServerLongTime()
if not shangHangModel:isOpenTime(now)then
reddot=false
end
local nextTime=shangHangModel:getNextChangeTime(false,now)
for i=1,2 do
if nextTime==0 then
reddot=false
break
end
nextTime=shangHangModel:getNextChangeTime(false,nextTime)
end
self.itemRed:setActive(reddot)
else
self.itemRed:setActive(false)
end
end




function UIShangHangLeftWin:onWanfaButton()
local d={}
d.title='活动规则'
d.mode=3
d.num=13
d.name='shanghang_rule_%d'
self:showWindow('UIRuleWin',d)
end



function UIShangHangLeftWin:onFazeButton()
self:showWindow("UIShangHangRuleViewWin")
end



function UIShangHangLeftWin:onRongyuButton()
self:showWindow("UIGuPiaoRongYuWin")
end

function UIShangHangLeftWin:onItemButton()
self:showWindow("UIGuPiaoItemEventWin")
end

function UIShangHangLeftWin:onRankButton()
self:showWindow("UIShangHangRankWin")
end

function UIShangHangLeftWin:onClickClose()
fullScreenUI.closeActiveUI(true)
shangHangController.saveLeaveData()
end







































































































