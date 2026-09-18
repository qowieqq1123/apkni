







def_class("UICommonGainWayWin",UIWindowBase)









function UICommonGainWayWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.Root=UIObject.get(self,1)
self.tip=UIText.get(self,2)
self.title=UIText.get(self,3)
self.uiRoot=UIObject.get(self,4)
self.wayScrollView=UIScrollView.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UICommonGainWayWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.wayScrollView);self.wayScrollView=nil;
end
















local _this

local CmpWayItemIndex={
lock=0,
name=1,
goBtn=2,
gray=3,
bgClick=4,
}



function UICommonGainWayWin:onLoaded(...)
self:bindComponents()

_this=self

self.wayScrollView:bindScrollWidget(function(...)self:bindWayItem(...)end)
end


function UICommonGainWayWin:__delete()

_this=nil

self:unbindComponents()
end










function UICommonGainWayWin:onShow(argtable,afterOnloaded)

if argtable then

self.gainWayList=argtable.gainWayList
self.titleTxt=argtable.title or''
self.tips=argtable.tips
self.closeCallBack=argtable.closeCallBack

self.outCheckGrayFuncs=argtable.outCheckGrayFuncs

self:refresh()
end
end


function UICommonGainWayWin:onHide()

end





function UICommonGainWayWin:onCloseBtn()
self:closeSelf()
end


function UICommonGainWayWin:refresh()

self.title:setText(self.titleTxt)

self.tip:setText(self.tips)

self.wayScrollView:freshGridsNum(#self.gainWayList,#self.gainWayList,1)
end

function UICommonGainWayWin:bindWayItem(index,item)
local info=self.gainWayList[index]
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

local active=(canJump or canBuy or canHeCheng or canShopBuy)and not isGray
local desc,state=gainControl:getJumpDesc(info,unLock,isGray)
item:SetChildText(CmpWayItemIndex.name,desc)
item:SetChildActive(CmpWayItemIndex.lock,not unLock)
item:SetChildActive(CmpWayItemIndex.gray,isGray)
local showArrow=gainControl:checkShowArrow(jump,active,state)
item:SetChildActive(CmpWayItemIndex.goBtn,not hasHeCheng and not hasShopBuy and showArrow)

local isCustomJump,customNoJumpTips=self:customCheckCanJump(info)

local clickBgFun=function(...)
if _this==nil then return end

if not isCustomJump then
UIManager.info(customNoJumpTips)
return
end

if active then
if canJump then
gainControl:handleJump(jump,function(ret)
if _this==nil then return end
_this:jumpCB(ret)
end)
end
else
if not unLock then
gainControl:showTips(errArgs)
return
elseif isGray then
UIManager.error(tips)
return
else


end
end
end

item:SetBaseItemClickEvent(-1,clickBgFun)
item:SetChildButtonClick(CmpWayItemIndex.bgClick,function()
clickBgFun()
end,true)
end

function UICommonGainWayWin:isUnlock(info)
local sysid=info.sysid
local lv=info.lv
local jumpId=info.jump and info.jump.id or nil
if sysid then
if not systemModel.isOpen(sysid)then
return false
end
end
if lv then
if playerModel:getActorLevel()<lv then
return false
end
end
local ret=true
local args
if ret==nil then return true end
return ret,args
end

function UICommonGainWayWin:isGray(info)
return false
end

function UICommonGainWayWin:customCheckCanJump(info)
if info.noJumpCondition and self.outCheckGrayFuncs then
for index,condition in ipairs(info.noJumpCondition)do
local type=condition[1]
if self.outCheckGrayFuncs[type]and self.outCheckGrayFuncs[type]()then
return false,info.tips
end
end
end
return true
end

function UICommonGainWayWin:jumpCB(ret)
if _this==nil then return end
if not ret then return end

local closeCallBack=_this.closeCallBack
_this:closeSelf()
if closeCallBack then
closeCallBack()
end
end
