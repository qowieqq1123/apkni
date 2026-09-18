







def_class("UIShangHangMainWin",UIWindowBase)









function UIShangHangMainWin:bindComponents()

self.gushiScrollView=UIObject.get(self,0)
self.time=UIText.get(self,1)
self.eventViewPanel=UIObject.get(self,2)
self.moneyRoot=UIObject.get(self,3)
self.yongjinBtn=UIButton.get(self,4)
self.danmuMask=UIObject.get(self,5)
self.emptyGuPiao=UIObject.get(self,6)
self.yongjinReddot=UIObject.get(self,7)
self.money1Btn=UIButton.get(self,8)
self.danmuRoot=UIObject.get(self,9)
self.sortBtn_4=UIButton.get(self,10)
self.sortBtn_3=UIButton.get(self,11)
self.sortBtn_1=UIButton.get(self,12)
self.sortBtn_2=UIButton.get(self,13)
self.dealButton=UIButton.get(self,14)
self.sortBtn_5=UIButton.get(self,15)
self.eventView=UIObject.get(self,16)

self.yongjinBtn:setButtonClick(function()self:onYongjinBtn()end)

self.money1Btn:setButtonClick(function()self:onMoney1Btn()end)

self.sortBtn_4:setButtonClick(function()self:onSortBtn_4()end)

self.sortBtn_3:setButtonClick(function()self:onSortBtn_3()end)

self.sortBtn_1:setButtonClick(function()self:onSortBtn_1()end)

self.sortBtn_2:setButtonClick(function()self:onSortBtn_2()end)

self.dealButton:setButtonClick(function()self:onDealButton()end)

self.sortBtn_5:setButtonClick(function()self:onSortBtn_5()end)
self.sortBtn={
self.sortBtn_1,
self.sortBtn_2,
self.sortBtn_3,
self.sortBtn_4,
self.sortBtn_5,
}



end


function UIShangHangMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gushiScrollView);self.gushiScrollView=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.eventViewPanel);self.eventViewPanel=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.yongjinBtn);self.yongjinBtn=nil;
_UIObject_release(self.danmuMask);self.danmuMask=nil;
_UIObject_release(self.emptyGuPiao);self.emptyGuPiao=nil;
_UIObject_release(self.yongjinReddot);self.yongjinReddot=nil;
_UIObject_release(self.money1Btn);self.money1Btn=nil;
_UIObject_release(self.danmuRoot);self.danmuRoot=nil;
_UIObject_release(self.sortBtn_4);self.sortBtn_4=nil;
_UIObject_release(self.sortBtn_3);self.sortBtn_3=nil;
_UIObject_release(self.sortBtn_1);self.sortBtn_1=nil;
_UIObject_release(self.sortBtn_2);self.sortBtn_2=nil;
_UIObject_release(self.dealButton);self.dealButton=nil;
_UIObject_release(self.sortBtn_5);self.sortBtn_5=nil;
_UIObject_release(self.eventView);self.eventView=nil;
self.sortBtn=nil;
end



















local sortFunc=
{

[1]=function(self,list)
table.sort(list,function(a,b)
if self.sortType then
return a.guPiaoData.stock_id>b.guPiaoData.stock_id
else
return a.guPiaoData.stock_id<b.guPiaoData.stock_id
end
end)
end,

[2]=function(self,list)
table.sort(list,function(a,b)
if self.sortType then
return a.guPiaoData.price<b.guPiaoData.price
else
return a.guPiaoData.price>b.guPiaoData.price
end
end)
end,

[3]=function(self,list)
table.sort(list,function(a,b)
if self.sortType then
return a.zhangdie<b.zhangdie
else
return a.zhangdie>b.zhangdie
end
end)
end,

[4]=function(self,list)
table.sort(list,function(a,b)
local cntA=a.acotrData~=nil and a.acotrData.stock_cnt or 0
local cntB=b.acotrData~=nil and b.acotrData.stock_cnt or 0
if self.sortType then
return cntA<cntB
else
return cntA>cntB
end
end)
end,

[5]=function(self,list)
table.sort(list,function(a,b)
if self.sortType then
return a.yingli<b.yingli
else
return a.yingli>b.yingli
end
end)
end,
}


function UIShangHangMainWin:onLoaded(...)
self:bindComponents()

self.danMuQueue=queue.New()
self.YListIndex={1}

self.activeDanMu=0

local now=timeHelper.getServerLongTime()
if shangHangModel:isOpenTime(now)then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.stocksOpen)
else
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.stocksClose)
end
end


function UIShangHangMainWin:__delete()
self:unbindComponents()

end




function UIShangHangMainWin:onShow(argtable,afterOnloaded)


socketManager:send_248_94()

self.sortIdx=4
self.sortType=nil

self:startTime()

self:freshInfo()
self:freshEventInfo()



shangHangController.showCloseResultWin(self)
end


function UIShangHangMainWin:onHide()

end

function UIShangHangMainWin:onShowArgRecv(argtable)
self:freshInfo()
self:freshEventInfo()
self:showSaveDanMu()
end



function UIShangHangMainWin:freshInfo()
local data=shangHangModel:getGuPiaoData()
local list={}
local acotrData,buy,cnt
for i,v in pairs(data)do
acotrData=shangHangModel:getActorGuPiaoData(v.stock_id)
local buy=acotrData~=nil and acotrData.buy_price or 0
local cnt=acotrData~=nil and acotrData.stock_cnt or 0
table.insert(list,{guPiaoData=v,acotrData=acotrData,yingli=shangHangModel.calcYingLi(buy,cnt,v.price),zhangdie=shangHangModel.calcZhangDie(v.day_price,v.price)})
end
sortFunc[self.sortIdx](self,list)

self.sortGuPiaoList=list

self:freshMoney()
self:freshGuPiaoPanel()
self:freshDailyBtn()
end

function UIShangHangMainWin:freshDailyBtn()
self.yongjinBtn:setActive(shangHangModel:getActorMoneyToday()~=0)

self:doPunchRotation(self.winid,self.yongjinReddot:getID(),1,shangHangModel:getActorMoneyToday()~=0)
end

function UIShangHangMainWin:freshGuPiaoPanel()
local zero=timeHelper.getTodayZeroStamp()
local change_time=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"stock_price_change_time")
local v=change_time[1]
local changeStampFirst=zero+v[1]*3600+v[2]*60+v[3]

local long=timeHelper.getServerLongTime()
local first=long>=zero and long<changeStampFirst

self.emptyGuPiao:setActive(#self.sortGuPiaoList==0)

self.gushiScrollView:setChildScrollViewCreateGrids(#self.sortGuPiaoList,1)
local items=self.gushiScrollView:getChildScrollViewItemWidgets()
for i=1,items.Count do
local grid=items[i-1]
local data=self.sortGuPiaoList[i]
local guPiaoData=data.guPiaoData
local acotrData=data.acotrData
local stock_cnt=acotrData and acotrData.stock_cnt or 0
local cfg=cfgHelper.get(cfg_shanghangstockconfig_get,guPiaoData.stock_id)
local hangYeCfg=cfgHelper.get(cfg_shanghanghangyeconfig_get,cfg.hangye_id)
local diYuCfg=cfgHelper.get(cfg_shanghangdiyuconfig_get,cfg.area_id)
local icon=shangHangModel.getGuPiaoIcon(guPiaoData.stock_id)
grid:SetChildIcon(0,icon,false)
grid:SetChildText(3,cfg.name)

grid:SetChildIcon(2,FMT.fmt("icon_gpcy_{0}",hangYeCfg.icon),true)

local iconStr=shangHangModel.getYuQuanIconStr()
grid:SetChildText(4,FMT.fmt("{0} {1}",iconStr,guPiaoData.price))

grid:SetChildText(5,FMT.fmt("<color={1}>{0}%</color>",data.zhangdie,data.zhangdie>0 and"#c82c2c"or"#549327"))
grid:SetChildText(6,stock_cnt>0 and FMT.fmt("<color=#7d3b17>{0}</color>\n<color=#CA631D>[持有]</color>",stock_cnt)or'')
if data.yingli==0 then
grid:SetChildText(7,'')
else
grid:SetChildText(7,FMT.fmt("<color={1}>{0}%</color>",data.yingli,data.yingli>0 and"#c82c2c"or"#549327"))
end


grid:SetChildActive(1,shangHangModel:getRecommendGuPiao()==guPiaoData.stock_id and(not first))

grid:SetChildButtonClick(1,function()
local gushenData=shanmenModel:get_gushen_data()
if gushenData then
UIManager.info(FMT.fmt('<size=21><color=#ca631d>{0}</color>重仓买进<color=#ca631d>“{1}”</color></size>',gushenData.name,cfg.name))
end
end)

grid:SetChildButtonClick(8,function()
self:onDealClick(i)
end)

grid:SetChildNewBieComponentId(8,'UIShangHangMainWin.gpItem'..i)
end
end

function UIShangHangMainWin:freshEventInfo()
self:freshEventPanel()
end

function UIShangHangMainWin:freshEventPanel()
local eventList=shangHangModel:getEventList(true,true)

self.eventView:setChildLayoutGroupCreateItems(#eventList)
self.eventView:setLocalPosY(10000)
local items=self.eventView:getChildLayoutGroupGridList()
for i=1,items.Count do
local grid=items[i-1]
local event=eventList[i]
local id=event.id
local percent=event.percent
local time=event.time
local times=event.times
local et=event.type
local cfg=cfgHelper.get(cfg_shanghangeventconfig_get,id)
local text
if et==eShangHangEventType.eHear then
if not cfg then
cfg=cfgHelper.get(cfg_shanghangitemeventconfig_get,id)
text=cfg.text1
end
text=cfg.text1
grid:SetChildIcon(0,"icon_shangshievent_0",true)
grid:SetChildText(1,FMT.fmt("<color=#bb8cf1>传闻：</color>{0}",FMT.fmt(text,math.abs(percent))))
grid:SetChildActive(4,false)
elseif et==eShangHangEventType.eItemEvent then
cfg=cfgHelper.get(cfg_shanghangitemeventconfig_get,id)
if percent>0 then
if cfg.text2 then
text=cfg.text2[times]or cfg.text2[#cfg.text2]
else
text=''
loggerUtil.logErrFMT('{0} 该事件上涨{1}%但没配置上涨文本',id,math.abs(percent))
end
else
if cfg.text3 then
text=cfg.text3[times]or cfg.text3[#cfg.text3]
else
text=''
loggerUtil.logErrFMT('{0} 该事件下跌{1}%但没配置下跌文本',id,math.abs(percent))
end

end
grid:SetChildIcon(0,FMT.fmt("icon_shangshievent_{0}",event.upType),true)
if percent>0 then
grid:SetChildText(1,FMT.fmt("<color=#fd8950>事件：</color>{0}",FMT.fmt(text,FMT.cfmt(FONT_COLOR.eRedColor,math.abs(percent)))))
else
grid:SetChildText(1,FMT.fmt("<color=#fd8950>事件：</color>{0}",FMT.fmt(text,FMT.cfmt(FONT_COLOR.eGreenColor,math.abs(percent)))))
end
grid:SetChildText(3,times)
grid:SetChildActive(4,times>0)
else
if percent>0 then
if cfg.text2 then
text=cfg.text2[times]or cfg.text2[#cfg.text2]
else
text=''
loggerUtil.logErrFMT('{0} 该事件上涨{1}%但没配置上涨文本',id,math.abs(percent))
end
else
if cfg.text3 then
text=cfg.text3[times]or cfg.text3[#cfg.text3]
else
text=''
loggerUtil.logErrFMT('{0} 该事件下跌{1}%但没配置下跌文本',id,math.abs(percent))
end

end
grid:SetChildIcon(0,FMT.fmt("icon_shangshievent_{0}",event.upType),true)

if percent>0 then
grid:SetChildText(1,FMT.fmt("<color=#fd8950>事件：</color>{0}",FMT.fmt(text,FMT.cfmt(FONT_COLOR.eRedColor,math.abs(percent)))))
else
grid:SetChildText(1,FMT.fmt("<color=#fd8950>事件：</color>{0}",FMT.fmt(text,FMT.cfmt(FONT_COLOR.eGreenColor,math.abs(percent)))))
end
grid:SetChildText(3,times)
grid:SetChildActive(4,times>0)
end


grid:SetChildText(2,timeHelper.getTwoFormatByStamp(timeHelper.convertLongStamp(time)))

end


end

function UIShangHangMainWin:onDealClick(index)
self:showWindow("UIGuPiaoDetailWin",{sortList=self.sortGuPiaoList,index=index})

end



local moveX=1500
local moveTime=8
local YList={0}
function UIShangHangMainWin:onRecvMesg(mesg)
if#self.YListIndex>0 then
local danMu=self.danMuQueue:dequeue()
if not danMu then
self.danmuItemNum=self.danmuItemNum or 0

self.danmuRoot:setChildLayoutGroupAddItem()
self.danmuItemNum=self.danmuItemNum+1
danMu=self.danmuRoot:getChildLayoutGroupGridItem(self.danmuItemNum-1)

end
if danMu then
local randomYIndex=math.random(1,#self.YListIndex)
local YIndex=self.YListIndex[randomYIndex]
table.remove(self.YListIndex,randomYIndex)
local x=0
danMu:SetChildCanvasGroupAlpha(-1,1)
danMu:SetChildLocalPosition(-1,Vector3(x,YList[YIndex],0))

if self.activeDanMu==0 then
self.danmuMask:setChildCanvasGroupAlpha(1)
end
self.activeDanMu=self.activeDanMu+1

local tween=danMu:SetChildDOLocalMoveX(-1,-moveX,moveTime,function()
danMu:SetChildCanvasGroupAlpha(-1,0)
self.danMuQueue:enqueue(danMu)

self.activeDanMu=self.activeDanMu-1
if self.activeDanMu<=0 then
self.danmuMask:setChildCanvasGroupAlpha(0)
end
end)
tween:SetEase(_Ease.Linear)
danMu:SetChildText(0,mesg)

self:delayDo(0.5,function()
local width=danMu:GetChildRectWidth(-1)
local pos=danMu:GetChildLocalPosition(-1)
local wei=pos.x+width
if wei<0 then
local add=true
for i,v in ipairs(self.YListIndex)do if v==YIndex then add=false break end end
if add then
table.insert(self.YListIndex,YIndex)
end
else
self:delayDo(wei/(moveX/moveTime),function()
local add=true
for i,v in ipairs(self.YListIndex)do if v==YIndex then add=false break end end
if add then
table.insert(self.YListIndex,YIndex)
end
end)
end
end)
else
self:delayDo(moveTime,function()
self:onRecvMesg(mesg)
end)
end
end
end

function UIShangHangMainWin:showSaveDanMu()
local danMuList=shangHangModel:getDanMuList()
local nextTime=shangHangModel:getNextChangeTime(true)
for i,v in ipairs(danMuList)do
if i>1 then
self:delayDo((i-1)*0.5,function()
if v.addTime<nextTime then
self:showDanMu(v)
end
end)
else
if v.addTime<nextTime then
self:showDanMu(v)
end
end
end
end

function UIShangHangMainWin:showDanMu(danmu)
local baseCfg=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"danmuText")
local cfg=cfgHelper.get(cfg_shanghangstockconfig_get,danmu.id)
local diYuCfg=cfgHelper.get(cfg_shanghangdiyuconfig_get,cfg.area_id)
if danmu.num>0 then
self:onRecvMesg(FMT.fmt(baseCfg[1],danmu.name,cfg.name,danmu.num))
else
self:onRecvMesg(FMT.fmt(baseCfg[2],danmu.name,cfg.name,math.abs(danmu.num)))
end
end

function UIShangHangMainWin:getKongXianYList()
local list={}
for i,v in ipairs(self.YListIndex)do
if not self.usedYList[i]then
table.insert(i)
end
end
return list
end

function UIShangHangMainWin:freshMoney()
local moneyRoot=self.moneyRoot:getChildWidgetBase()
local money=shangHangModel:getActorMoney()
if not self.initMoneyIcon then
local iconname=shangHangModel.getYuQuanIcon()
moneyRoot:SetChildIcon(0,iconname,false)
self.initMoneyIcon=true
end
moneyRoot:SetChildText(1,mathHelper.formatNumber5(money,2))
end

function UIShangHangMainWin:onMoney1Btn()
shangHangController.showTransformMoney(self.moneyRoot,Vector2(-70,-100))
end



function UIShangHangMainWin:startTime()

self:stopTime()
self.timeTimer=self:setTimer(1,0,function()
local t=shangHangController.getShowTime()
self.time:setText(t)

shangHangController.showCloseResultWin(self)
end)
end

function UIShangHangMainWin:stopTime()
if self.timeTimer then
self:stopTimerByID(self.timeTimer)
end
end




function UIShangHangMainWin:onDealButton()
end

function UIShangHangMainWin:onSortBtn_1()
if self.sortIdx==1 then
self.sortType=not self.sortType
else
self.sortType=nil
end
self.sortIdx=1
self:freshInfo()
end

function UIShangHangMainWin:onSortBtn_2()
if self.sortIdx==2 then
self.sortType=not self.sortType
else
self.sortType=nil
end
self.sortIdx=2
self:freshInfo()
end

function UIShangHangMainWin:onSortBtn_3()
if self.sortIdx==3 then
self.sortType=not self.sortType
else
self.sortType=nil
end
self.sortIdx=3
self:freshInfo()
end

function UIShangHangMainWin:onSortBtn_4()
if self.sortIdx==4 then
self.sortType=not self.sortType
else
self.sortType=nil
end
self.sortIdx=4
self:freshInfo()
end

function UIShangHangMainWin:onSortBtn_5()
if self.sortIdx==5 then
self.sortType=not self.sortType
else
self.sortType=nil
end
self.sortIdx=5
self:freshInfo()
end

function UIShangHangMainWin:onEventListClick()
self:showWindow("UIGuPiaoShiJianJiLuWin")
end

function UIShangHangMainWin:onYongjinBtn()
self:showWindow("UIGuPiaoYongJinWin")
end






function UIShangHangMainWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end


function UIShangHangMainWin:endAllReddotPunchRotation()
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return
end
for i,v in pairs(self.reddotTweenerList)do
if v~=nil then
v.tweener:Complete()
v.tweener:Kill()
local widget=v.widget
local componentIndex=v.componentIndex
widget:SetChildRotation(componentIndex,0,0,0)

self.reddotTweenerList[i]=nil
end
end
end
