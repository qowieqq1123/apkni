







def_class("UIHuanJingSelectWin",UIWindowBase)









function UIHuanJingSelectWin:bindComponents()

self.reddot1=UIObject.get(self,0)
self.reddot2=UIObject.get(self,1)
self.reddot4=UIObject.get(self,2)
self.iconScrollView=UIObject.get(self,3)
self.leftJianTou=UIButton.get(self,4)
self.rightJianTou=UIButton.get(self,5)
self.icon1=UIButton.get(self,6)
self.icon2=UIButton.get(self,7)
self.icon3=UIButton.get(self,8)
self.icon4=UIButton.get(self,9)
self.iconslist=UIObject.get(self,10)

self.leftJianTou:setButtonClick(function()self:onLeftJianTou()end)

self.rightJianTou:setButtonClick(function()self:onRightJianTou()end)

self.icon1:setButtonClick(function()self:onIcon1()end)

self.icon2:setButtonClick(function()self:onIcon2()end)

self.icon3:setButtonClick(function()self:onIcon3()end)

self.icon4:setButtonClick(function()self:onIcon4()end)



end


function UIHuanJingSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.reddot1);self.reddot1=nil;
_UIObject_release(self.reddot2);self.reddot2=nil;
_UIObject_release(self.reddot4);self.reddot4=nil;
_UIObject_release(self.iconScrollView);self.iconScrollView=nil;
_UIObject_release(self.leftJianTou);self.leftJianTou=nil;
_UIObject_release(self.rightJianTou);self.rightJianTou=nil;
_UIObject_release(self.icon1);self.icon1=nil;
_UIObject_release(self.icon2);self.icon2=nil;
_UIObject_release(self.icon3);self.icon3=nil;
_UIObject_release(self.icon4);self.icon4=nil;
_UIObject_release(self.iconslist);self.iconslist=nil;
end
















local _this

local _iconWidth=230
local _iconSpan=150
local _iconListLeftSpan=80
local _iconListRightSpan=80

local _moveSpeed=1000



function UIHuanJingSelectWin:onLoaded(...)
self:bindComponents()

_this=self

self.locateIndex=1

self.icons={
self.icon1,
self.icon2,
self.icon3,
self.icon4,
}

self.datas={
[1]={
name='后\n山\n试\n炼',
click=function()
self:showWin(1)
end,
},
[2]={
name='每\n日\n挑\n战',
click=function()
if UIHuanJingControl:isDayChallengeOpen()then
self:showWin(2)
else
UIManager.error('通关第4层开启')
end
end,
},
[3]={
name='后\n山\n禁\n地',
click=function()
if UIHuanJingControl:isJinDiFuncOpen()then
self:showWin(3)
else
local open=cfgHelper.get2(cfg_backmountainareabasicconfig_get,1,"open")
UIManager.error(FMT.fmt('通关关卡{0}开启',UIHuanJingControl:getLevelName("",open)))
end

end,
},
[4]={
name='后\n山\n阵\n灵',
click=function()
if UIHuanJingControl:isZhenlingFuncOpen()then
self:showWin(4)
else
local openStr=systemModel.getOpenTips(SYSTEM_DEFINE.eHouShanZhenLing)
UIManager.error(openStr)
end

end,
},
}

end


function UIHuanJingSelectWin:__delete()
self:unbindComponents()
end




function UIHuanJingSelectWin:onShow(argtable,afterOnloaded)
self.bdData=argtable.data
self.bdDataArgs=argtable.args or{}




local check=UIHuanJingControl:isDayChallengeOpen()
self.icon2:setChildGraphicGray(not check,true)
check=UIHuanJingControl:isJinDiFuncOpen()
self.icon3:setChildGraphicGray(not check,true)
check=UIHuanJingControl:isZhenlingFuncOpen()
self.icon4:setChildGraphicGray(not check,true)

local reddot=UIHuanJingControl:isShowRewardReddot()
self.reddot1:setActive(reddot)
if reddot then
local tweener=self.winlua:SetChildDOPunchRotation(self.reddot1:getID(),Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
end
local DCReddot=UIHuanJingControl:isShowDayChallengeRewardReddot()
self.reddot2:setActive(DCReddot)
if DCReddot then
local tweener=self.winlua:SetChildDOPunchRotation(self.reddot2:getID(),Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
end
local ZLReddot=UIHuanJingControl:isZhengLingReddot()
self.reddot4:setActive(ZLReddot)
if ZLReddot then
local tweener=self.winlua:SetChildDOPunchRotation(self.reddot4:getID(),Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
end

self:refreshJiantou()


end

function UIHuanJingSelectWin:showWin(index)
local bdData=self.bdData
local isPlayedAnim=self.bdDataArgs.isjump or false
self:onCloseClick()
UIHuanJingControl:showAndOpenHuanJingWin({data=bdData,index=index,isPlayedAnim=isPlayedAnim})
end


function UIHuanJingSelectWin:onHide()

end

function UIHuanJingSelectWin:refreshJiantou()
local pos=self.iconslist:getChildAnchoredPosition()
local state=pos.x<-_iconListLeftSpan

self.leftJianTou:setActive(state)
self.rightJianTou:setActive(not state)

self.isShowLeftJT=state
end

function UIHuanJingSelectWin:onScrollViewChange()
self:refreshJiantou()
end




function UIHuanJingSelectWin:onIcon1()
self.datas[1].click()
end

function UIHuanJingSelectWin:onIcon2()
self.datas[2].click()
end

function UIHuanJingSelectWin:onIcon3()
self.datas[3].click()
end

function UIHuanJingSelectWin:onIcon4()
self.datas[4].click()
end

function UIHuanJingSelectWin:onLeftJianTou()
local pos=self.iconslist:getChildAnchoredPosition()


local toposx=pos.x+_iconWidth+_iconSpan
toposx=Mathf.Min(toposx,0)
self.iconslist:setChildDOAnchorPosX(toposx,(-(pos.x-toposx))/_moveSpeed,nil)


end

function UIHuanJingSelectWin:onRightJianTou()
local pos=self.iconslist:getChildAnchoredPosition()
local swidth=self.iconScrollView:getChildSizeDeltaX()
local iwidth=self.iconslist:getChildSizeDeltaX()

local toposx=pos.x-_iconWidth-_iconSpan
toposx=Mathf.Max(toposx,swidth-iwidth)

self.iconslist:setChildDOAnchorPosX(toposx,(-(toposx-pos.x))/_moveSpeed,nil)
end

function UIHuanJingSelectWin:onCloseClick()
UIHuanJingControl:closeUI(true,true)
end

function UIHuanJingSelectWin:doShieldZL()
self.leftJianTou:setActive(false)
self.rightJianTou:setActive(false)
self.iconScrollView:setChildScrollRectEnable(false)
end

