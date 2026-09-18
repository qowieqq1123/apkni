







def_class("UIXiaoZhuShou_HouShan_SetupWin",UIWindowBase)









function UIXiaoZhuShou_HouShan_SetupWin:bindComponents()

self.banTypeBtn_1=UIButton.get(self,0)
self.banTypeBtn_2=UIButton.get(self,1)
self.banTypeBtn_3=UIButton.get(self,2)
self.banTypeBtn_4=UIButton.get(self,3)
self.banTypeBtn_5=UIButton.get(self,4)
self.buyToggle=UIToggleButton.get(self,5)
self.root=UIObject.get(self,6)
self.sdNumDropdown=UIDropdownEx.get(self,7)
self.selectBanType_1=UIObject.get(self,8)
self.selectBanType_2=UIObject.get(self,9)
self.selectBanType_3=UIObject.get(self,10)
self.selectBanType_4=UIObject.get(self,11)
self.selectBanType_5=UIObject.get(self,12)
self.selectType_1=UIObject.get(self,13)
self.selectType_2=UIObject.get(self,14)
self.selectType_3=UIObject.get(self,15)
self.selectType_4=UIObject.get(self,16)
self.selectType_5=UIObject.get(self,17)

self.banTypeBtn_1:setButtonClick(function()self:onBanTypeBtn_1()end)

self.banTypeBtn_2:setButtonClick(function()self:onBanTypeBtn_2()end)

self.banTypeBtn_3:setButtonClick(function()self:onBanTypeBtn_3()end)

self.banTypeBtn_4:setButtonClick(function()self:onBanTypeBtn_4()end)

self.banTypeBtn_5:setButtonClick(function()self:onBanTypeBtn_5()end)
self.banTypeBtn={
self.banTypeBtn_1,
self.banTypeBtn_2,
self.banTypeBtn_3,
self.banTypeBtn_4,
self.banTypeBtn_5,
}
self.selectBanType={
self.selectBanType_1,
self.selectBanType_2,
self.selectBanType_3,
self.selectBanType_4,
self.selectBanType_5,
}
self.selectType={
self.selectType_1,
self.selectType_2,
self.selectType_3,
self.selectType_4,
self.selectType_5,
}



end


function UIXiaoZhuShou_HouShan_SetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.banTypeBtn_1);self.banTypeBtn_1=nil;
_UIObject_release(self.banTypeBtn_2);self.banTypeBtn_2=nil;
_UIObject_release(self.banTypeBtn_3);self.banTypeBtn_3=nil;
_UIObject_release(self.banTypeBtn_4);self.banTypeBtn_4=nil;
_UIObject_release(self.banTypeBtn_5);self.banTypeBtn_5=nil;
_UIObject_release(self.buyToggle);self.buyToggle=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.sdNumDropdown);self.sdNumDropdown=nil;
_UIObject_release(self.selectBanType_1);self.selectBanType_1=nil;
_UIObject_release(self.selectBanType_2);self.selectBanType_2=nil;
_UIObject_release(self.selectBanType_3);self.selectBanType_3=nil;
_UIObject_release(self.selectBanType_4);self.selectBanType_4=nil;
_UIObject_release(self.selectBanType_5);self.selectBanType_5=nil;
_UIObject_release(self.selectType_1);self.selectType_1=nil;
_UIObject_release(self.selectType_2);self.selectType_2=nil;
_UIObject_release(self.selectType_3);self.selectType_3=nil;
_UIObject_release(self.selectType_4);self.selectType_4=nil;
_UIObject_release(self.selectType_5);self.selectType_5=nil;
self.banTypeBtn=nil;
self.selectBanType=nil;
self.selectType=nil;
end



















function UIXiaoZhuShou_HouShan_SetupWin:onLoaded(...)
self:bindComponents()
self.sdNumDropdown:setChangeAction(function(...)self:onDropdownChange(...)end)
end


function UIXiaoZhuShou_HouShan_SetupWin:__delete()
self.sdNumDropdown:setChangeAction(nil)
self:unbindComponents()
end




function UIXiaoZhuShou_HouShan_SetupWin:onShow(argtable,afterOnloaded)
self.orderID=XIAOZHUSHU_ENUM.xzs_HouShanZhenLing
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local isBuyNum=setupData[xzsDataKey.hsAutoBuyCleanup]==1
local buyNum=setupData[xzsDataKey.hsAutoBuyCleanupNum]
self:refreshCleanupType()
self:refreshBanType()

self.buyToggle:setToggle(isBuyNum)
self.buyToggle:setToggleChange(function(name,isOn)
setupData[xzsDataKey.hsAutoBuyCleanup]=isOn and 1 or 0
end)

local condition=cfgHelper.get2(cfg_houshanzhenlingbaseconfig_get,1,'daySaoDang')
local dayBuyCountMax=condition[1]
self.numArray=table.toTable(1,dayBuyCountMax)
local temp={}
for i,v in ipairs(self.numArray)do
table.insert(temp,tostring(i))
end
self.sdNumDropdown:setOption(temp)
self.sdNumDropdown:setValue(buyNum-1)
end

function UIXiaoZhuShou_HouShan_SetupWin:onDropdownChange(idx)

local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local buyNum=self.numArray[idx+1]
setupData[xzsDataKey.hsAutoBuyCleanupNum]=buyNum
end

function UIXiaoZhuShou_HouShan_SetupWin:OnEvent(idx)
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
if setupData[xzsDataKey.hsBetterCleanupType]~=idx then
local banTypeLookup=setupData[xzsDataKey.hsBanCleanupType]
if banTypeLookup[idx]==true then
local nameTab={"金","木","水","火","土"}
UIManager.error(string.format("已选择跳过扫荡%s属性阵灵，无法优先扫荡",nameTab[idx]))
return
end
setupData[xzsDataKey.hsBetterCleanupType]=idx
self:refreshCleanupType()
end
end

function UIXiaoZhuShou_HouShan_SetupWin:refreshCleanupType()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local firstType=setupData[xzsDataKey.hsBetterCleanupType]
for i,v in ipairs(self.selectType)do
v:setActive(i==firstType)
end
end

function UIXiaoZhuShou_HouShan_SetupWin:refreshBanType()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local banTypeLookup=setupData[xzsDataKey.hsBanCleanupType]
for i,v in ipairs(self.selectBanType)do
if banTypeLookup[i]==true then
v:setActive(true)
else
v:setActive(false)
end
end
end

function UIXiaoZhuShou_HouShan_SetupWin:onBanTypeBtn(idx)
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local firstType=setupData[xzsDataKey.hsBetterCleanupType]
local banTypeLookup=setupData[xzsDataKey.hsBanCleanupType]
if banTypeLookup[idx]~=true then
if firstType==idx then
local nameTab={"金","木","水","火","土"}
UIManager.error(string.format("已选择优先扫荡%s属性阵灵，无法跳过",nameTab[idx]))
return
end
banTypeLookup[idx]=true
else
banTypeLookup[idx]=nil
end
self:refreshBanType()
end

function UIXiaoZhuShou_HouShan_SetupWin:onBanTypeBtn_1()
self:onBanTypeBtn(1)
end

function UIXiaoZhuShou_HouShan_SetupWin:onBanTypeBtn_2()
self:onBanTypeBtn(2)
end

function UIXiaoZhuShou_HouShan_SetupWin:onBanTypeBtn_3()
self:onBanTypeBtn(3)
end

function UIXiaoZhuShou_HouShan_SetupWin:onBanTypeBtn_4()
self:onBanTypeBtn(4)
end

function UIXiaoZhuShou_HouShan_SetupWin:onBanTypeBtn_5()
self:onBanTypeBtn(5)
end
