







def_class("UIGuPiaoDetailWin",UIWindowBase)









function UIGuPiaoDetailWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.redObj=UIObject.get(self,1)
self.buyBtn=UIButton.get(self,2)
self.rightBtn=UIButton.get(self,3)
self.leftBtn=UIButton.get(self,4)
self.sellBtn=UIButton.get(self,5)
self.icon=UIImage.get(self,6)
self.redLine=UIObject.get(self,7)
self.LeafLine=UIObject.get(self,8)
self.empty=UIObject.get(self,9)
self.redObjChild=UIObject.get(self,10)
self.total=UILinkImageText.get(self,11)
self.name=UIText.get(self,12)
self.zhangdieUp=UIObject.get(self,13)
self.zhangdieDown=UIObject.get(self,14)
self.yingliUp=UIObject.get(self,15)
self.yingliDown=UIObject.get(self,16)
self.chiyou=UILinkImageText.get(self,17)
self.eventView=UIObject.get(self,18)
self.kaipan=UILinkImageText.get(self,19)
self.baojia=UILinkImageText.get(self,20)
self.zhangdie=UILinkImageText.get(self,21)
self.yingli=UILinkImageText.get(self,22)
self.chigujunjia=UILinkImageText.get(self,23)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.buyBtn:setButtonClick(function()self:onBuyBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)

self.sellBtn:setButtonClick(function()self:onSellBtn()end)



end


function UIGuPiaoDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.redObj);self.redObj=nil;
_UIObject_release(self.buyBtn);self.buyBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.sellBtn);self.sellBtn=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.redLine);self.redLine=nil;
_UIObject_release(self.LeafLine);self.LeafLine=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.redObjChild);self.redObjChild=nil;
_UIObject_release(self.total);self.total=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.zhangdieUp);self.zhangdieUp=nil;
_UIObject_release(self.zhangdieDown);self.zhangdieDown=nil;
_UIObject_release(self.yingliUp);self.yingliUp=nil;
_UIObject_release(self.yingliDown);self.yingliDown=nil;
_UIObject_release(self.chiyou);self.chiyou=nil;
_UIObject_release(self.eventView);self.eventView=nil;
_UIObject_release(self.kaipan);self.kaipan=nil;
_UIObject_release(self.baojia);self.baojia=nil;
_UIObject_release(self.zhangdie);self.zhangdie=nil;
_UIObject_release(self.yingli);self.yingli=nil;
_UIObject_release(self.chigujunjia);self.chigujunjia=nil;
end



















function UIGuPiaoDetailWin:onLoaded(...)
self:bindComponents()
end


function UIGuPiaoDetailWin:__delete()
self:unbindComponents()
end




function UIGuPiaoDetailWin:onShow(argtable,afterOnloaded)
local sortList=argtable.sortList
local index=argtable.index

self.sortList=sortList
self.selectIndex=index

self:freshInfo()
end


function UIGuPiaoDetailWin:onHide()

end



function UIGuPiaoDetailWin:freshInfo()
local data=self.sortList[self.selectIndex]

local oldData=data.guPiaoData
local id=oldData.stock_id
local guPiaoData=shangHangModel:getGuPiaoDatById(id)
local acotrData=shangHangModel:getActorGuPiaoData(id)

if not guPiaoData then

self:onCloseBtn()
return
end

local stock_cnt=acotrData and acotrData.stock_cnt or 0
local cfg=cfgHelper.get(cfg_shanghangstockconfig_get,guPiaoData.stock_id)



local changeList=guPiaoData.changeList or{}
local buy=acotrData~=nil and acotrData.buy_price or 0
local cnt=acotrData~=nil and acotrData.stock_cnt or 0
local yingli=shangHangModel.calcYingLi(buy,cnt,guPiaoData.price)
local zhangdie=shangHangModel.calcZhangDie(guPiaoData.day_price,guPiaoData.price)

local iconStr=shangHangModel.getYuQuanIconStr(32)
self.name:setText(cfg.name)
local icon=shangHangModel.getGuPiaoIcon(guPiaoData.stock_id)
self.icon:setChildIcon(icon,true)
self.kaipan:setText(FMT.fmt("今日开盘：{0}{1}",iconStr,guPiaoData.day_price))
local changNum=changeList[#changeList]or{}
changNum=changNum[2]or 0
if changNum>0 then
self.baojia:setText(FMT.fmt("最新报价：{0}<color={2}>{1}</color>",iconStr,guPiaoData.price,FONT_COLOR_VAL[FONT_COLOR.eRedColor]))
elseif changNum<0 then
self.baojia:setText(FMT.fmt("最新报价：{0}<color={2}>{1}</color>",iconStr,guPiaoData.price,FONT_COLOR_VAL[FONT_COLOR.eGreenColor]))
else
self.baojia:setText(FMT.fmt("最新报价：{0}<color={2}>{1}</color>",iconStr,guPiaoData.price,FONT_COLOR_VAL[FONT_COLOR.eNomalBlackColor]))
end

if zhangdie>0 then
self.zhangdie:setText(FMT.fmt("涨跌幅度：<color={1}>{0}%</color>",zhangdie,FONT_COLOR_VAL[FONT_COLOR.eRedColor]))
elseif zhangdie<0 then
self.zhangdie:setText(FMT.fmt("涨跌幅度：<color={1}>{0}%</color>",zhangdie,FONT_COLOR_VAL[FONT_COLOR.eGreenColor]))
else
self.zhangdie:setText(FMT.fmt("涨跌幅度：<color={1}>{0}%</color>",zhangdie,FONT_COLOR_VAL[FONT_COLOR.eNomalBlackColor]))
end


self.zhangdieUp:setActive(zhangdie>0)
self.zhangdieDown:setActive(zhangdie<0)

local jun=0
if stock_cnt>0 then
jun=math.floor(buy/stock_cnt)
end

if yingli>0 then
self.yingli:setText(FMT.fmt("盈利幅度：<color={1}>{0}%</color>",yingli,FONT_COLOR_VAL[FONT_COLOR.eRedColor]))
self.chigujunjia:setText(FMT.fmt("持股均价：{0} <color={2}>{1}</color>",iconStr,jun,FONT_COLOR_VAL[FONT_COLOR.eRedColor]))
elseif yingli<0 then
self.yingli:setText(FMT.fmt("盈利幅度：<color={1}>{0}%</color>",yingli,FONT_COLOR_VAL[FONT_COLOR.eGreenColor]))
self.chigujunjia:setText(FMT.fmt("持股均价：{0} <color={2}>{1}</color>",iconStr,jun,FONT_COLOR_VAL[FONT_COLOR.eGreenColor]))
else
self.yingli:setText(FMT.fmt("盈利幅度：<color={1}>{0}%</color>",yingli,FONT_COLOR_VAL[FONT_COLOR.eNomalBlackColor]))
self.chigujunjia:setText(FMT.fmt("持股均价：{0} <color={2}>{1}</color>",iconStr,jun,FONT_COLOR_VAL[FONT_COLOR.eNomalBlackColor]))
end

self.yingliUp:setActive(yingli>0)
self.yingliDown:setActive(yingli<0)

self.chiyou:setText(FMT.fmt("持有数量：{0}股",stock_cnt))


self:setEventList(guPiaoData.day_price,changeList)

self:paintLine(guPiaoData.day_price,changeList,cfg)

local sell_stock_cost_rate=cfg.sell_stock_cost_rate
local total=math.floor(stock_cnt*guPiaoData.price-sell_stock_cost_rate*guPiaoData.price*stock_cnt/10000)
self.total:setText(FMT.fmt("{0} {1}",iconStr,total))
end


function UIGuPiaoDetailWin:paintLine(day_price,changeList,cfg)
local w=self.redLine:getChildRectWidth()
local h=self.redLine:getChildRectHeight()
w=math.floor(w)
h=math.floor(h)

local changeNum=#changeList
local num=9
if changeNum>9 then
num=changeNum
end
local dx=w/num

local show_price=cfg.show_price or{}

local min=show_price[1]and show_price[1]*day_price/10000+day_price or day_price
local max=show_price[2]and show_price[2]*day_price/10000+day_price or day_price
local p=day_price




local perfetList
perfetList={day_price}

for i,v in ipairs(changeList)do

p=v[1]
table.insert(perfetList,p)
if min>p then min=p end
if max<p then max=p end

end


local lastPos=nil
self.redLine:setLineRendererPositionCount(0)


self.redObj:setActive(#changeList>0)
if#perfetList>1 then
local firstY=perfetList[1]

local d=0
if max-firstY>firstY-min then
d=max-firstY
else
d=firstY-min
end

local dy=(h/(2*d))

for i,v in ipairs(perfetList)do
local beginPosX=(i-1)*dx
local beginPosY=dy*(v-firstY)
local pos=Vector3(beginPosX,beginPosY)
self.redLine:addLineRendererPos(pos)
if lastPos and i==#perfetList then
self.redObj:setLocalPos(beginPosX,beginPosY+130,0)

local angle=Quaternion.FromToRotation(Vector3.New(0,0,1),lastPos-pos).eulerAngles
if lastPos.x-pos.x>0 then
self.redObjChild:setRotation(0,0,180-angle.x-90)
else
self.redObjChild:setRotation(0,0,angle.x-90)
end
end
lastPos=pos
end
end
end

function UIGuPiaoDetailWin:setEventList(day_price,changeList)
local data=self.sortList[self.selectIndex]
local id=data.guPiaoData.stock_id
local guPiaoData=shangHangModel:getGuPiaoDatById(id)

local dayPrice=guPiaoData.day_price

local changeList=guPiaoData.changeList or{}

local changeTime=guPiaoData.changeTime or{}

local effectEvent=shangHangModel:getGuPiaoEffectEvent(id)

local changeLen=#changeList
local effectEventLen=#effectEvent
self.eventView:setChildLayoutGroupCreateItems(changeLen+effectEventLen)
self.empty:setActive(changeLen+effectEventLen==0)
local items=self.eventView:getChildLayoutGroupGridList()
for i=1,items.Count do
local grid=items[i-1]
local event=effectEvent[i-changeLen]

if i<=changeLen then
local change=dayPrice
local old=dayPrice
for ii=1,i do
change=changeList[ii][1]-old
old=changeList[ii][1]
end
self:setChange(grid,id,math.ceil(change),i,changeTime[i])
else
self:setEvent(grid,event)
end
end
end

function UIGuPiaoDetailWin:setChange(grid,id,change,changeIdx,changeTime)
if change==0 then
grid:SetChildActive(-1,false)
return
end
grid:SetChildActive(-1,true)
local cfg=cfgHelper.get(cfg_shanghangstockconfig_get,id)

grid:SetChildText(1,FMT.fmt("<color=#549327>{0}</color>股价{1}<color={2}>{3}</color>",cfg.name,change>=0 and"上涨"or"下降",change>=0 and FONT_COLOR_VAL[FONT_COLOR.eRedColor]or FONT_COLOR_VAL[FONT_COLOR.eGreenColor],math.abs(change)))

if changeTime and changeTime~=0 then
grid:SetChildText(2,timeHelper.getTwoFormatByStamp(timeHelper.convertLongStamp(changeTime)))
else
local timeT=cfgHelper.get(cfg_shanghangbaseconfig_get,1,"stock_price_change_time")
local time=timeT[changeIdx]
if time then
local zero=timeHelper.getTodayZeroStamp()
grid:SetChildText(2,timeHelper.getTwoFormatByStamp(zero+time[1]*3600+time[2]*60+time[3]))
end
end

grid:SetChildActive(4,false)
end

function UIGuPiaoDetailWin:setEvent(grid,event)
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
grid:SetChildActive(4,false)
grid:SetChildIcon(0,"icon_shangshievent_0",true)
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
grid:SetChildText(3,times)
grid:SetChildActive(4,times>0)
grid:SetChildIcon(0,FMT.fmt("icon_shangshievent_{0}",event.upType),true)
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
grid:SetChildText(3,times)
grid:SetChildActive(4,times>0)
grid:SetChildIcon(0,FMT.fmt("icon_shangshievent_{0}",event.upType),true)
end
if percent>0 then
grid:SetChildText(1,FMT.fmt("<color=#ca631d>事件：</color>{0}",FMT.fmt(text,FMT.cfmt(FONT_COLOR.eRedColor,math.abs(percent)))))
else
grid:SetChildText(1,FMT.fmt("<color=#ca631d>事件：</color>{0}",FMT.fmt(text,FMT.cfmt(FONT_COLOR.eGreenColor,math.abs(percent)))))
end

grid:SetChildText(2,timeHelper.getTwoFormatByStamp(timeHelper.convertLongStamp(time)))

end





function UIGuPiaoDetailWin:onCloseBtn()
self:closeSelf()
end



function UIGuPiaoDetailWin:onLeftBtn()
if self.selectIndex>1 then
self.selectIndex=self.selectIndex-1
else
self.selectIndex=#self.sortList
end
self:freshInfo()
end



function UIGuPiaoDetailWin:onRightBtn()
if self.selectIndex<#self.sortList then
self.selectIndex=self.selectIndex+1
else
self.selectIndex=1
end
self:freshInfo()
end



function UIGuPiaoDetailWin:onBuyBtn()

local now=timeHelper.getServerLongTime()
if not shangHangModel:isOpenTime(now)then
UIManager.error("休市中无法交易")
return
end

local data=self.sortList[self.selectIndex]
local guPiaoData=data.guPiaoData
local id=guPiaoData.stock_id
shangHangController:showBuyDialog(id)
end



function UIGuPiaoDetailWin:onSellBtn()

local now=timeHelper.getServerLongTime()
if not shangHangModel:isOpenTime(now)then
UIManager.error("休市中无法交易")
return
end

local data=self.sortList[self.selectIndex]
local guPiaoData=data.guPiaoData
local id=guPiaoData.stock_id
shangHangController:showSellDialog(id)
end

