







def_class("UIXiaoZhuShou_TWXM_SetupWin",UIWindowBase)









function UIXiaoZhuShou_TWXM_SetupWin:bindComponents()

self.extraChallengeCost=UIText.get(self,0)
self.extraChallengeCount=UIInputField.get(self,1)
self.extraChallengeToggle=UIToggleButton.get(self,2)



end


function UIXiaoZhuShou_TWXM_SetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.extraChallengeCost);self.extraChallengeCost=nil;
_UIObject_release(self.extraChallengeCount);self.extraChallengeCount=nil;
_UIObject_release(self.extraChallengeToggle);self.extraChallengeToggle=nil;
end



















function UIXiaoZhuShou_TWXM_SetupWin:onLoaded(...)
self:bindComponents()
self.extraChallengeCount:setChildInputFieldChange(true,function(...)
self:extraSelectCount(...)
end)
end


function UIXiaoZhuShou_TWXM_SetupWin:__delete()
self:unbindComponents()
end




function UIXiaoZhuShou_TWXM_SetupWin:onShow(argtable,afterOnloaded)
self.orderID=XIAOZHUSHU_ENUM.xzs_TWXM
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)

local isAutoBuyTimes=setupData[xzsDataKey.twxmAutoBuyTimes]==1
self.extraChallengeToggle:setToggle(isAutoBuyTimes)
self.extraChallengeToggle:setToggleChange(function(name,isOn)
setupData[xzsDataKey.twxmAutoBuyTimes]=isOn and 1 or 0
end)

local twxmBuyTimes=setupData[xzsDataKey.twxmBuyTimes]
self.extraChallengeCount:setInputFieldValue(twxmBuyTimes)

self:refreshChallengeCost()
end

function UIXiaoZhuShou_TWXM_SetupWin:refreshChallengeCost()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local twxmBuyTimes=setupData[xzsDataKey.twxmBuyTimes]
local consume=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"buy")
local costNum=0
local costItem=consume[1][1]
for i,v in ipairs(consume)do
if twxmBuyTimes>=i then
costNum=costNum+v[2]
else
break
end
end
self.extraChallengeCost:setText(string.format("（消耗%s：%d）",itemsConfig.getItemName(costItem),costNum))
end

function UIXiaoZhuShou_TWXM_SetupWin:extraSelectCount(str)

local count=tonumber(str)

local consume=cfgHelper.get2(cfg_fairylandbossconfig_get,1,"buy")
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
setupData[xzsDataKey.twxmBuyTimes]=count
self:refreshChallengeCost()
end
end