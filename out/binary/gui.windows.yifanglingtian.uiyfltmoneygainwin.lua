







def_class("UIYFLTMoneyGainWin",UIWindowBase)









function UIYFLTMoneyGainWin:bindComponents()

self.adaptation=UIObject.get(self,0)
self.arrow=UIObject.get(self,1)
self.cdTx=UIText.get(self,2)
self.desc=UIText.get(self,3)
self.descContent=UIObject.get(self,4)
self.descScrollView=UIObject.get(self,5)
self.gainScrollerView=UIObject.get(self,6)
self.Icon=UIImage.get(self,7)
self.name=UIText.get(self,8)
self.num=UIText.get(self,9)
self.quality=UIImage.get(self,10)
self.root=UIObject.get(self,11)



end


function UIYFLTMoneyGainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.adaptation);self.adaptation=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.cdTx);self.cdTx=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.descContent);self.descContent=nil;
_UIObject_release(self.descScrollView);self.descScrollView=nil;
_UIObject_release(self.gainScrollerView);self.gainScrollerView=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.quality);self.quality=nil;
_UIObject_release(self.root);self.root=nil;
end



















local _this=nil
function UIYFLTMoneyGainWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIYFLTMoneyGainWin:__delete()
self:unbindComponents()
_this=nil
UIManager:closeWindow("UIYFLTQuickUseWin")
end




function UIYFLTMoneyGainWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.goodId=argtable.goodId
self.goodName=argtable.goodName
self.goodNum=argtable.goodNum
local goodIconName=argtable.goodIconName
local goodSignIcon=argtable.goodSignIcon
local goodColorPage=argtable.goodColorPage
local goodColor=argtable.goodColor
local goodDesc=argtable.goodDesc
self.showgoodNum=argtable.showgoodNum
self.isLY=argtable.isLY
self.goodProduce=argtable.goodProduce
self.name:setText(self.goodName)
self.desc:setText(goodDesc)
self.Icon:setImageIcon(goodIconName,false)
itemsComponentHelper.setUIBaseItemSmallSignCommonEx(self.widget,self.Icon:getID(),goodSignIcon,false)

self:refreshwindow()

self.winlua:SetChildQulaityEx(self.quality:getID(),goodColorPage,goodColor)
self:dealYFLT()
self:refreshGainList()



end


function UIYFLTMoneyGainWin:onHide()

end

function UIYFLTMoneyGainWin:refreshwindow()

self.num:setActive(self.showgoodNum)
if self.showgoodNum then

local lt_constcfg=cfg_yifanglintianconfig().const_def
local ly_itemid=lt_constcfg.ly_itemid
if self.goodId==ly_itemid then
local num,maxnum=YiFangLingTianModel:GetLingYeNum()
self.goodNum=num
end
self:refreshGoodNum(self.goodNum)
end
if self.isLY then
local lt_constcfg=cfg_yifanglintianconfig().const_def
local add_lingye_conf=lt_constcfg.add_lingye_conf
local add_lingye_num=itemsModel.getCount(add_lingye_conf[1])
if add_lingye_num>0 then
local func=function(...)
if _this==nil then return end
_this:onQuickUseWinShowBack(...)
end
local args={showBack=func}
self.parentWin:moveRoot(-190,0.5)
self.root:setChildDOLocalMoveX(-190,0.5)

UIManager:showWindow("UIYFLTQuickUseWin",args)
else
UIManager:invokeUIMethod("UIYFLTQuickUseWin","onCloseClisk")
end
else
UIManager:invokeUIMethod("UIYFLTQuickUseWin","onCloseClisk")
end

end

function UIYFLTMoneyGainWin:onCloseClick()
self.parentWin:onCloseClick()
end


function UIYFLTMoneyGainWin:onQuickUseWinShowBack(win)
local wincfg1=UIManager.get_window_config('UIYFLTMoneyGainWin')
local canvasIdx1=wincfg1.canvas
local wincfg2=UIManager.get_window_config('UIYFLTQuickUseWin')
local canvasIdx2=wincfg2.canvas
if canvasIdx1~=canvasIdx2 then
self.parentWin:setCanvasIndex(-1,canvasIdx2)
self:setCanvasIndex(-1,canvasIdx2)
end
local pos=win:getChildCanvas(-1)
self.parentWin:resetRootCanves(pos[1],pos[2]+2)
self:setChildCanvas(-1,pos[1],pos[2]+3)
win:setChildCanvas(-1,pos[1],pos[2]+1)
end

function UIYFLTMoneyGainWin:refreshGoodNum(num)
if self.needCount and self.needCount>0 then
local color=num>=self.needCount and FONT_COLOR.eNomalColor or FONT_COLOR.eRedColor
num=FMT.fmt("{0}/{1}",FMT.cfmt(color,num),self.needCount)
end
self.num:setText(FMT.fmt('{0}{1}',FMT.cfmt(FONT_COLOR.eOrangeDescColor,'数量：'),num))
end



function UIYFLTMoneyGainWin:dealYFLT()

if not self.isLY then
return
end
local begintimes=YiFangLingTianModel:Getbegintimes()
self.cdTx:setActive(begintimes>0)
if begintimes<=0 then
return
end

local lt_constcfg=cfg_yifanglintianconfig().const_def
local ly_itemid=lt_constcfg.ly_itemid
local cdStr=self:GetYFLTStr()
self.cdTx:setText(cdStr)
if not self.cdYFLT then
self.cdYFLT=self:setTimer(1,0,function()
self:updateYFLTStr()
end)
end
end
function UIYFLTMoneyGainWin:stopYFLT()
if self.cdYFLT then
self:stopTimerByID(self.cdYFLT)
self.cdYFLT=nil
end
end


function UIYFLTMoneyGainWin:GetYFLTStr()

local time,alltime=YiFangLingTianModel:GetLingYeTime()
local timestr=timeHelper.format_time_stamp(time,false)
local alltimestr=timeHelper.format_time_stamp(alltime,false)
local param1=timeHelper.format_time_stamp3(time,true)

if alltime~=0 then
return FMT.fmt("(恢复一滴灵液：<color=#29ad0f>{0}</color>)",param1)
else
return FMT.fmt("(已达到上限)"),true
end

end

function UIYFLTMoneyGainWin:updateYFLTStr()

local cdStr,flag=self:GetYFLTStr()
self.cdTx:setText(cdStr)
if flag then
self:stopYFLT()
end
end
local gainItemCmpIndex={
icon=0,
name=1,
lockImg=2,
goBtn=3,
bg=4,
garyImg=5,
state=6,
selectBg=7,
specialBg=8,
}
function UIYFLTMoneyGainWin:refreshGainList()
local showList=gainControl:getGainSortList(self.goodProduce,self.goodId)
self.gainScrollerView:setChildScrollViewCreateGrids(#showList,1)
local grids=self.gainScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
self.quickHeChengInfo=nil
self.quickHeChengItemIndex=nil
self.quickBuyInfo=nil

for i=1,count do
local item=grids[i-1]
local info=showList[i]
local jump=info.jump
local buy=info.buy
local hecheng=info.hecheng
local shopBuy=info.shopBuy
local hasJump=jump~=nil
local hasBuy=buy~=nil
local hasHeCheng=hecheng~=nil
local hasShopBuy=shopBuy~=nil
local unLock,errArgs=gainControl:isUnlock(info)
local isGray,tips=self:isGray(info)
local canJump=hasJump and unLock or false
local canBuy=hasBuy and unLock or false
local canHeCheng=hasHeCheng and unLock or false
local canShopBuy=hasShopBuy and unLock or false
if canHeCheng then
self.quickHeChengInfo=info
self.quickHeChengItemIndex=i
end
if canBuy then
self.quickBuyInfo=info
end
if canShopBuy then
self.quickShopBuyInfo=info
self.quickShopBuyItemIndex=i
end
local active=(canJump or canBuy or canHeCheng or canShopBuy)and not isGray
local iconInfo=self:getIconInfo(info)
iconHelper.setChildIcon_2(item,gainItemCmpIndex.icon,iconInfo)
local desc,state=gainControl:getJumpDesc(info,unLock,isGray)
item:SetChildText(gainItemCmpIndex.name,desc)
item:SetChildText(gainItemCmpIndex.state,state)
item:SetChildActive(gainItemCmpIndex.lockImg,not unLock)
item:SetChildActive(gainItemCmpIndex.garyImg,unLock and isGray)
local showArrow=gainControl:checkShowArrow(jump,active,state)
item:SetChildActive(gainItemCmpIndex.goBtn,not hasHeCheng and not hasShopBuy and showArrow)
local clickBgFun=function(...)

if _this==nil then return end
if active then
if canJump then

gainControl:handleJump(jump,self.jumpCB)
elseif canBuy then
self:showQuickBuyWin(info)
elseif canHeCheng then

elseif canShopBuy then
self:showQuickShopBuyWin(info,i)
end
else
if not unLock then
gainControl:showTips(errArgs)
elseif isGray then
UIManager.error(tips)
else


end
end
end
if hasHeCheng or hasShopBuy then
item:SetChildActive(gainItemCmpIndex.specialBg,true)
item:SetChildActive(gainItemCmpIndex.bg,false)
item:SetChildButtonClick(gainItemCmpIndex.specialBg,clickBgFun)
else
item:SetChildActive(gainItemCmpIndex.bg,true)
item:SetChildActive(gainItemCmpIndex.specialBg,false)
item:SetChildButtonClick(gainItemCmpIndex.bg,clickBgFun)
end
end
end
function UIYFLTMoneyGainWin:getIconInfo(v)
local buyParam=v.buy
if buyParam and buyParam.icon then
local typo=buyParam.typo
local info=_quickBuyfunc[typo]
if info and info.icon then
return info.icon(self,buyParam)
end
end
return nil
end
function UIYFLTMoneyGainWin:isGray(v)
local buyParam=v.buy
if buyParam then
local typo=buyParam.typo
local info=_quickBuyfunc[typo]
if info and info.gray then
return info.gray(self,buyParam)
end
end
local gray=v.gray
if gray then
local typo=gray.typo
local func=_grayfunc[typo]
if func then
return func(self,gray)
end
end
return false
end


function UIYFLTMoneyGainWin:showQuickBuyWin(info)
local showfunc=function(...)
if self==nil or self.isClose then return end
self:onQuickBuyWinShowBack(...)
end
local closefunc=function()
if self==nil or self.isClose then return end
self.parentWin:showCloseBtn(true)
self.parentWin:moveRoot(0,0.5)
self.root:setChildDOLocalMoveX(0,0.5)
UIManager:closeWindow('UIQuickBuyWin')
self.attachWin=nil
end

if not info then
if self.quickBuyInfo then
info=self.quickBuyInfo
else
return closefunc()
end
end

local buyParam=info.buy
self.parentWin:moveRoot(-190,0.5)
self.root:setChildDOLocalMoveX(-190,0.5)
local args=self:getBuyWinArgs(buyParam)
args.gray=self:isGray(info)
args.showCallback=showfunc
args.parentWin=self.parentWin
args.closeCallback=closefunc
self:showAttachWindow('UIQuickBuyWin',args)
end

function UIYFLTMoneyGainWin:onQuickBuyWinShowBack(win)
local wincfg1=UIManager.get_window_config('UIYFLTMoneyGainWin')
local canvasIdx1=wincfg1.canvas
local wincfg2=UIManager.get_window_config('UIQuickBuyWin')
local canvasIdx2=wincfg2.canvas
if canvasIdx1~=canvasIdx2 then
self.parentWin:setCanvasIndex(-1,canvasIdx2)
self:setCanvasIndex(-1,canvasIdx2)
end
local pos=win:getChildCanvas(-1)
self.parentWin:resetRootCanves(pos[1],pos[2]+2)
self:setChildCanvas(-1,pos[1],pos[2]+3)
win:setChildCanvas(-1,pos[1],pos[2]+1)
end

function UIYFLTMoneyGainWin:showQuickShopBuyWin(info,itemIndex)
local widget=self.gainScrollerView:getChildScrollViewItemWidget(itemIndex-1)
local isSelect=false
if not UIManager:isActive("UIQuickShopBuyWin")then

isSelect=true
local shopBuyParam=info.shopBuy
self.parentWin:moveRoot(-190,0.5)
self.root:setChildDOLocalMoveX(-190,0.5)
local showfunc=function(...)
if self==nil or self.isClose then return end
self:onQuickShopBuyWinShowBack(...)
end
local closefunc=function()
if self==nil or self.isClose then return end
self.parentWin:showCloseBtn(true)
self.parentWin:moveRoot(0,0.5)
self.root:setChildDOLocalMoveX(0,0.5)
UIManager:closeWindow('UIQuickShopBuyWin')
if widget then
widget:SetChildActive(gainItemCmpIndex.selectBg,false)
end
self.attachWin=nil
end
local args={}
args.shopId=shopBuyParam.shopId
args.itemId=self.goodId
args.showCallback=showfunc
args.parentWin=self.parentWin
args.closeCallback=closefunc
self:showAttachWindow('UIQuickShopBuyWin',args)
else

UIManager:invokeUIMethod("UIQuickShopBuyWin","onCloseBtn")
end
widget:SetChildActive(gainItemCmpIndex.selectBg,isSelect)
end


