







def_class("UIXiaoZhuShou_DouFaTai_SetupWin",UIWindowBase)









function UIXiaoZhuShou_DouFaTai_SetupWin:bindComponents()

self.Checkmark_1=UIObject.get(self,0)
self.Checkmark_2=UIObject.get(self,1)
self.enterBtn=UIButton.get(self,2)
self.num=UIText.get(self,3)
self.toggle_1=UIButton.get(self,4)
self.toggle_2=UIButton.get(self,5)
self.toggle_3=UIToggleButton.get(self,6)
self.trainCountInputText=UIInputField.get(self,7)

self.enterBtn:setButtonClick(function()self:onEnterBtn()end)

self.toggle_1:setButtonClick(function()self:onToggle_1()end)

self.toggle_2:setButtonClick(function()self:onToggle_2()end)
self.Checkmark={
self.Checkmark_1,
self.Checkmark_2,
}
self.toggle={
self.toggle_1,
self.toggle_2,
self.toggle_3,
}



end


function UIXiaoZhuShou_DouFaTai_SetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Checkmark_1);self.Checkmark_1=nil;
_UIObject_release(self.Checkmark_2);self.Checkmark_2=nil;
_UIObject_release(self.enterBtn);self.enterBtn=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.toggle_1);self.toggle_1=nil;
_UIObject_release(self.toggle_2);self.toggle_2=nil;
_UIObject_release(self.toggle_3);self.toggle_3=nil;
_UIObject_release(self.trainCountInputText);self.trainCountInputText=nil;
self.Checkmark=nil;
self.toggle=nil;
end



















function UIXiaoZhuShou_DouFaTai_SetupWin:onLoaded(...)
self:bindComponents()

local config=douFaTaiModel:getDouFaTaiBasicConfig()
local cost=config.challenge_item[1]
self.tzlItemId=cost[1]
self.trainCountInputText:setChildInputFieldChange(true,function(...)
self:changeSelectCount(...)

end)
end


function UIXiaoZhuShou_DouFaTai_SetupWin:__delete()
self:unbindComponents()
end




function UIXiaoZhuShou_DouFaTai_SetupWin:onShow(argtable,afterOnloaded)
self.orderID=XIAOZHUSHU_ENUM.xzs_DouFaTai
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local isSelectScore=setupData[xzsDataKey.dftSelectActor]==2
local useItem=setupData[xzsDataKey.dftItemFight]==1
local useItemNum=setupData[xzsDataKey.dftItemFightNum]

self.Checkmark_1:setActive(not isSelectScore)
self.Checkmark_2:setActive(isSelectScore)

self.toggle_3:setToggle(useItem)
self.toggle_3:setToggleChange(function(name,isOn)
setupData[xzsDataKey.dftItemFight]=isOn and 1 or 0
end)

local haveItem=bagControl.invokeFuncByItemId(self.tzlItemId,'getItemCountByItemID',self.tzlItemId)
self.num:setText(FMT.fmt("（剩余挑战令：{0}）",haveItem))


if useItemNum and tostring(useItemNum)=='userdata: NULL'then
useItemNum=nil
end

self.trainCountInputText:setInputFieldValue(math.min(useItemNum or 0,haveItem))
end

function UIXiaoZhuShou_DouFaTai_SetupWin:changeSelectCount(str)

local count=tonumber(str)
local oriCoount=count
local haveItem=bagControl.invokeFuncByItemId(self.tzlItemId,'getItemCountByItemID',self.tzlItemId)

local times=cfgHelper.get2(cfg_doufataibasicconfig_get,1,"assistantTimes")or 5

local maxCount=math.min(haveItem,times)

local isNeedReset=false
if count==nil then

count=0
isNeedReset=true
elseif count<1 then

count=0
isNeedReset=true
elseif count>maxCount then

count=maxCount
isNeedReset=true
end

if isNeedReset then
if count~=oriCoount then
self.trainCountInputText:setInputFieldValue(count)
end
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
setupData[xzsDataKey.dftItemFightNum]=count
return
end



local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
setupData[xzsDataKey.dftItemFightNum]=count
end


function UIXiaoZhuShou_DouFaTai_SetupWin:onHide()

end

function UIXiaoZhuShou_DouFaTai_SetupWin:onToggle_1()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local isSelectScore=setupData[xzsDataKey.dftSelectActor]==2
if isSelectScore then
setupData[xzsDataKey.dftSelectActor]=1
self.Checkmark_1:setActive(true)
self.Checkmark_2:setActive(false)
end
end

function UIXiaoZhuShou_DouFaTai_SetupWin:onToggle_2()
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local isSelectScore=setupData[xzsDataKey.dftSelectActor]==2
if not isSelectScore then
setupData[xzsDataKey.dftSelectActor]=2
self.Checkmark_1:setActive(false)
self.Checkmark_2:setActive(true)
end
end






function UIXiaoZhuShou_DouFaTai_SetupWin:onEnterBtn()
end

