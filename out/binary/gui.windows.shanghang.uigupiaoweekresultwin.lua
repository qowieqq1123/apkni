







def_class("UIGuPiaoWeekResultWin",UIWindowBase)









function UIGuPiaoWeekResultWin:bindComponents()

self.effect=UIObject.get(self,0)
self.model=UIObject.get(self,1)
self.qipao_1=UIObject.get(self,2)
self.upImg2=UIObject.get(self,3)
self.upImg=UIObject.get(self,4)
self.downImg=UIObject.get(self,5)
self.rankBtn=UIButton.get(self,6)
self.ScrollView=UIScrollView.get(self,7)
self.downImg2=UIObject.get(self,8)
self.lastZiyuan=UIText.get(self,9)
self.newZiyuan=UIText.get(self,10)
self.zhangfuVal=UIText.get(self,11)
self.dieVal=UIText.get(self,12)
self.rankVal=UIText.get(self,13)
self.new=UIObject.get(self,14)
self.Content=UIObject.get(self,15)
self.closeButton=UIButton.get(self,16)
self.qipiaoText_1=UIText.get(self,17)

self.rankBtn:setButtonClick(function()self:onRankBtn()end)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIGuPiaoWeekResultWin")end)
self.qipao={
self.qipao_1,
}
self.qipiaoText={
self.qipiaoText_1,
}



end


function UIGuPiaoWeekResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.qipao_1);self.qipao_1=nil;
_UIObject_release(self.upImg2);self.upImg2=nil;
_UIObject_release(self.upImg);self.upImg=nil;
_UIObject_release(self.downImg);self.downImg=nil;
_UIObject_release(self.rankBtn);self.rankBtn=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.downImg2);self.downImg2=nil;
_UIObject_release(self.lastZiyuan);self.lastZiyuan=nil;
_UIObject_release(self.newZiyuan);self.newZiyuan=nil;
_UIObject_release(self.zhangfuVal);self.zhangfuVal=nil;
_UIObject_release(self.dieVal);self.dieVal=nil;
_UIObject_release(self.rankVal);self.rankVal=nil;
_UIObject_release(self.new);self.new=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.qipiaoText_1);self.qipiaoText_1=nil;
self.qipao=nil;
self.qipiaoText=nil;
end



















function UIGuPiaoWeekResultWin:onLoaded(...)
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
self.speak={}
end


function UIGuPiaoWeekResultWin:__delete()
self:unbindComponents()
end




function UIGuPiaoWeekResultWin:onShow(argtable,afterOnloaded)


if not shangHangController:send_248_99()then
self:refreshRank()
end

local startMoney=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"init_yq")
local curMoney=shangHangModel:getZiChanZongZhi()

self.lastZiyuan:setText(mathHelper.formatNumber5(startMoney,2))


local zhangdie=math.ceil((curMoney-startMoney)/startMoney*100)

local up=zhangdie>=0

self.newZiyuan:setText(FMT.fmt("<color={1}>{0}</color>",mathHelper.formatNumber5(curMoney,2),up and FONT_COLOR_VAL[FONT_COLOR.eRedColor]or FONT_COLOR_VAL[FONT_COLOR.eGreenColor]))

self.downImg:setActive(not up)
self.downImg2:setActive(not up)

self.upImg:setActive(up)
self.upImg2:setActive(up)

self.zhangfuVal:setActive(up)
self.dieVal:setActive(not up)
if up then
self.zhangfuVal:setText(FMT.fmt("{0}%",zhangdie))
else
self.dieVal:setText(FMT.fmt("{0}%",zhangdie))
end




local week_reward_conf=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"week_reward_conf")

local mula=math.floor(curMoney*(curMoney/(curMoney+week_reward_conf[1])*week_reward_conf[2])+week_reward_conf[3])

local limit=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"money_rewards_limit")
if mula>limit[2]then
mula=limit[2]
end

local propData={itemsComponentHelper.getCommonFillData({itemid=week_reward_conf[4],itemcount=0},{showname=false,itemcount=mathHelper.formatNumber5(mula,2)})}
local propDataCnt=#propData
self.ScrollView:freshGridsNum(propDataCnt,1,propDataCnt,false)
self.ScrollView:initPropData(propData)

self.model:setChildUIModelShowTarget(1113008,1.3,{},eAnimationID.stand,false,nil,0)
self.model:setChildUIModelShowFlipX(true)

self:startSpeak(up and 1 or 2,5)

self.effect:setChildShowEffect(10053,true)
end

function UIGuPiaoWeekResultWin:startSpeak(idx,delay)
self:stopSpeak(idx)
local cfg=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"resultSpeakText")
local list=cfg[idx]
self.speak[idx]=self:setTimer(delay,0,function()
self.qipao_1:setChildCanvasGroupAlpha(0)
self.qipao_1:setChildCanvasGroupDOFade(1,0.2)

self.qipiaoText_1:setText(list[math.random(1,#list)])
local hide=self.qipao_1:setChildCanvasGroupDOFade(0,0.2)
hide:SetDelay(2)
end)
end

function UIGuPiaoWeekResultWin:stopSpeak(idx)
if self.speak[idx]then
self:stopTimerByID(self.speak[idx])
self.speak[idx]=nil
end
end


function UIGuPiaoWeekResultWin:onHide()

end

function UIGuPiaoWeekResultWin:refreshRank()
local rank=shangHangModel:getMyRank()
self.rankVal:setText(rank>0 and FMT.fmt("第{0}名",rank)or"未上榜")
end






function UIGuPiaoWeekResultWin:onRankBtn()
UIManager:showWindow("UIShangHangRankWin")
self:closeSelf()
end

function UIGuPiaoWeekResultWin:onCloseBtn()
self:closeSelf()
end
