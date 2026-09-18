







def_class("UIXiaoZhuShou_XJ_YBD_SetupWin",UIWindowBase)









function UIXiaoZhuShou_XJ_YBD_SetupWin:bindComponents()

self.inputText=UIInputField.get(self,0)
self.root=UIObject.get(self,1)



end


function UIXiaoZhuShou_XJ_YBD_SetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.inputText);self.inputText=nil;
_UIObject_release(self.root);self.root=nil;
end



















function UIXiaoZhuShou_XJ_YBD_SetupWin:onLoaded(...)
self:bindComponents()

self.inputText:setChildInputFieldChange(true,function(...)
self:onInputTextChanged(...)
end)
end


function UIXiaoZhuShou_XJ_YBD_SetupWin:__delete()
self:unbindComponents()
end




function UIXiaoZhuShou_XJ_YBD_SetupWin:onShow(argtable,afterOnloaded)
self.orderID=XIAOZHUSHU_ENUM.xzs_XJ_YBD
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
local targetNum=setupData[xzsDataKey.xjYBDAutoSaveMoneyNum]
local limitNum=cfgHelper.get3(cfg_fairylandbaseconfig_get,1,'ybdMoneyParam',2)
self.inputText:setInputFieldValue(tostring(targetNum or limitNum))
end


function UIXiaoZhuShou_XJ_YBD_SetupWin:onHide()

end



function UIXiaoZhuShou_XJ_YBD_SetupWin:onInputTextChanged(str)
local count=tonumber(str)
local oCnt=count
local limitNum=cfgHelper.get3(cfg_fairylandbaseconfig_get,1,'ybdMoneyParam',2)

local isNeedReset=false
if count==nil then

count=0
elseif count<1 then

count=0
elseif count>limitNum then

count=limitNum
end

if count~=oCnt then
self.inputText:setInputFieldValue(count)
end

local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
setupData[xzsDataKey.xjYBDAutoSaveMoneyNum]=count
end