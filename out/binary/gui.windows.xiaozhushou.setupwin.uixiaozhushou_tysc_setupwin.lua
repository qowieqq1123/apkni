







def_class("UIXiaoZhuShou_TYSC_SetupWin",UIWindowBase)









function UIXiaoZhuShou_TYSC_SetupWin:bindComponents()

self.Checkmark_1=UIObject.get(self,0)
self.Checkmark_2=UIObject.get(self,1)
self.slChallengeCost=UIText.get(self,2)
self.slChallengeCount=UIInputField.get(self,3)
self.slChallengeToggle=UIToggleButton.get(self,4)
self.toggle_1=UIButton.get(self,5)
self.toggle_2=UIButton.get(self,6)
self.ysChallengeCost=UIText.get(self,7)
self.ysChallengeCount=UIInputField.get(self,8)
self.ysChallengeToggle=UIToggleButton.get(self,9)

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


function UIXiaoZhuShou_TYSC_SetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Checkmark_1);self.Checkmark_1=nil;
_UIObject_release(self.Checkmark_2);self.Checkmark_2=nil;
_UIObject_release(self.slChallengeCost);self.slChallengeCost=nil;
_UIObject_release(self.slChallengeCount);self.slChallengeCount=nil;
_UIObject_release(self.slChallengeToggle);self.slChallengeToggle=nil;
_UIObject_release(self.toggle_1);self.toggle_1=nil;
_UIObject_release(self.toggle_2);self.toggle_2=nil;
_UIObject_release(self.ysChallengeCost);self.ysChallengeCost=nil;
_UIObject_release(self.ysChallengeCount);self.ysChallengeCount=nil;
_UIObject_release(self.ysChallengeToggle);self.ysChallengeToggle=nil;
self.Checkmark=nil;
self.toggle=nil;
end



















function UIXiaoZhuShou_TYSC_SetupWin:onLoaded(...)
self:bindComponents()
self.ysChallengeCount:setChildInputFieldChange(true,function(...)
self:ysSelectCount(...)
end)
self.slChallengeCount:setChildInputFieldChange(true,function(...)
self:slSelectCount(...)
end)
end


function UIXiaoZhuShou_TYSC_SetupWin:__delete()
self:unbindComponents()
end




function UIXiaoZhuShou_TYSC_SetupWin:onShow(argtable,afterOnloaded)
self.orderID=XIAOZHUSHU_ENUM.xzs_TYSC
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)

local isSelectNormal=setupData[xzsDataKey.tyscYaoShouType]==2
self.Checkmark_1:setActive(not isSelectNormal)
self.Checkmark_2:setActive(isSelectNormal)

local isAutoBuyTimesYS=setupData[xzsDataKey.tyscAutoBuyTimesYS]==1
self.ysChallengeToggle:setToggle(isAutoBuyTimesYS)
self.ysChallengeToggle:setToggleChange(function(name,isOn)
setupData[xzsDataKey.tyscAutoBuyTimesYS]=isOn and 1 or 0
end)

local isAutoBuyTimesSL=setupData[xzsDataKey.tyscAutoBuyTimesSL]==1
self.slChallengeToggle:setToggle(isAutoBuyTimesSL)
self.slChallengeToggle:setToggleChange(function(name,isOn)
setupData[xzsDataKey.tyscAutoBuyTimesSL]=isOn and 1 or 0
end)

local tyscBuyTimesYS=setupData[xzsDataKey.tyscBuyTimesYS]
local tyscBuyTimesSL=setupData[xzsDataKey.tyscBuyTimesSL]
self.ysChallengeCount:setInputFieldValue(tyscBuyTimesYS)
self.slChallengeCount:setInputFieldValue(tyscBuyTimesSL)

self:refreshYSChallengeCost()
self:refreshSLChallengeCost()
end

function UIXiaoZhuShou_TYSC_SetupWin:refreshYSChallengeCost()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local tyscBuyTimesYS=setupData[xzsDataKey.tyscBuyTimesYS]
local shouchaoNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,"shouchaoNum")
local costNum=0
local costItem=shouchaoNum[3]
for i,v in ipairs(shouchaoNum[4])do
if tyscBuyTimesYS>=i then
costNum=costNum+v
else
break
end
end
self.ysChallengeCost:setText(string.format("（消耗%s：%d）",itemsConfig.getItemName(costItem),costNum))
end

function UIXiaoZhuShou_TYSC_SetupWin:refreshSLChallengeCost()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local tyscBuyTimesSL=setupData[xzsDataKey.tyscBuyTimesSL]
local shoulingNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,"shoulingNum")
local costNum=0
local costItem=shoulingNum[3]
for i,v in ipairs(shoulingNum[4])do
if tyscBuyTimesSL>=i then
costNum=costNum+v
else
break
end
end
self.slChallengeCost:setText(string.format("（消耗%s：%d）",itemsConfig.getItemName(costItem),costNum))
end

function UIXiaoZhuShou_TYSC_SetupWin:ysSelectCount(str)

local count=tonumber(str)

local shouchaoNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,"shouchaoNum")
local maxBuyCount=shouchaoNum[2]

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
self.ysChallengeCount:setInputFieldValue(showCount)
end

if isSetData then
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
setupData[xzsDataKey.tyscBuyTimesYS]=count
self:refreshYSChallengeCost()
end
end

function UIXiaoZhuShou_TYSC_SetupWin:slSelectCount(str)

local count=tonumber(str)

local shoulingNum=cfgHelper.get2(cfg_skyshouchaobaseconfig_get,1,"shoulingNum")
local maxBuyCount=shoulingNum[2]

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
self.slChallengeCount:setInputFieldValue(showCount)
end

if isSetData then
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
setupData[xzsDataKey.tyscBuyTimesSL]=count
self:refreshSLChallengeCost()
end
end


function UIXiaoZhuShou_TYSC_SetupWin:onToggle_1()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local isSelect=setupData[xzsDataKey.tyscYaoShouType]==1
if not isSelect then
setupData[xzsDataKey.tyscYaoShouType]=1
self.Checkmark_1:setActive(true)
self.Checkmark_2:setActive(false)
end
end

function UIXiaoZhuShou_TYSC_SetupWin:onToggle_2()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local isSelect=setupData[xzsDataKey.tyscYaoShouType]==2
if not isSelect then
setupData[xzsDataKey.tyscYaoShouType]=2
self.Checkmark_1:setActive(false)
self.Checkmark_2:setActive(true)
end
end

