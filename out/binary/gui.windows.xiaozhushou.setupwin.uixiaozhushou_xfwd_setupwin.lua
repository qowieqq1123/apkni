







def_class("UIXiaoZhuShou_XFWD_SetupWin",UIWindowBase)









function UIXiaoZhuShou_XFWD_SetupWin:bindComponents()

self.Checkmark_1=UIObject.get(self,0)
self.Checkmark_2=UIObject.get(self,1)
self.extraChallengeCost=UIText.get(self,2)
self.extraChallengeCount=UIInputField.get(self,3)
self.extraChallengeToggle=UIToggleButton.get(self,4)
self.toggle_1=UIButton.get(self,5)
self.toggle_2=UIButton.get(self,6)

self.toggle_1:setButtonClick(function()self:onToggle_1()end)

self.toggle_2:setButtonClick(function()self:onToggle_2()end)
self.Checkmark={
self.Checkmark_1,
self.Checkmark_2,
}
self.toggle={
self.toggle_1,
self.toggle_2,
}



end


function UIXiaoZhuShou_XFWD_SetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Checkmark_1);self.Checkmark_1=nil;
_UIObject_release(self.Checkmark_2);self.Checkmark_2=nil;
_UIObject_release(self.extraChallengeCost);self.extraChallengeCost=nil;
_UIObject_release(self.extraChallengeCount);self.extraChallengeCount=nil;
_UIObject_release(self.extraChallengeToggle);self.extraChallengeToggle=nil;
_UIObject_release(self.toggle_1);self.toggle_1=nil;
_UIObject_release(self.toggle_2);self.toggle_2=nil;
self.Checkmark=nil;
self.toggle=nil;
end



















function UIXiaoZhuShou_XFWD_SetupWin:onLoaded(...)
self:bindComponents()
self.extraChallengeCount:setChildInputFieldChange(true,function(...)
self:extraSelectCount(...)
end)
end


function UIXiaoZhuShou_XFWD_SetupWin:__delete()
self:unbindComponents()
end




function UIXiaoZhuShou_XFWD_SetupWin:onShow(argtable,afterOnloaded)
self.orderID=XIAOZHUSHU_ENUM.xzs_XFWD
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)

local isSelectHighScore=setupData[xzsDataKey.xfwdPriorityChallenge]==2
self.Checkmark_1:setActive(not isSelectHighScore)
self.Checkmark_2:setActive(isSelectHighScore)

local isAutoBuyTimes=setupData[xzsDataKey.xfwdAutoBuyTimes]==1
self.extraChallengeToggle:setToggle(isAutoBuyTimes)
self.extraChallengeToggle:setToggleChange(function(name,isOn)
setupData[xzsDataKey.xfwdAutoBuyTimes]=isOn and 1 or 0
end)

local xfwdBuyTimes=setupData[xzsDataKey.xfwdBuyTimes]
self.extraChallengeCount:setInputFieldValue(xfwdBuyTimes)

self:refreshChallengeCost()
end

function UIXiaoZhuShou_XFWD_SetupWin:refreshChallengeCost()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local xfwdBuyTimes=setupData[xzsDataKey.xfwdBuyTimes]
local consume=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,"consume")
local costNum=0
local costItem=consume[1][1][1]
for i,v in ipairs(consume)do
if xfwdBuyTimes>=i then
costNum=costNum+v[1][2]
else
break
end
end
self.extraChallengeCost:setText(string.format("（消耗%s：%d）",itemsConfig.getItemName(costItem),costNum))
end

function UIXiaoZhuShou_XFWD_SetupWin:extraSelectCount(str)

local count=tonumber(str)

local consume=cfgHelper.get2(cfg_xianfawendaoconfig_get,1,"consume")
local maxBuyCount=#consume

local showCount=''
local isNeedReset=false
local isSetData=true
if count==nil then


showCount=''
isNeedReset=true
isSetData=false
elseif count<1 then

count=1
showCount=1
isNeedReset=true
elseif count>maxBuyCount then

count=maxBuyCount
showCount=maxBuyCount
isNeedReset=true
end

if isNeedReset then
self.extraChallengeCount:setInputFieldValue(showCount)
end

if isSetData then
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
setupData[xzsDataKey.xfwdBuyTimes]=count
self:refreshChallengeCost()
end
end


function UIXiaoZhuShou_XFWD_SetupWin:onToggle_1()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local isSelect=setupData[xzsDataKey.xfwdPriorityChallenge]==1
if not isSelect then
setupData[xzsDataKey.xfwdPriorityChallenge]=1
self.Checkmark_1:setActive(true)
self.Checkmark_2:setActive(false)
end
end

function UIXiaoZhuShou_XFWD_SetupWin:onToggle_2()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local isSelect=setupData[xzsDataKey.xfwdPriorityChallenge]==2
if not isSelect then
setupData[xzsDataKey.xfwdPriorityChallenge]=2
self.Checkmark_1:setActive(false)
self.Checkmark_2:setActive(true)
end
end