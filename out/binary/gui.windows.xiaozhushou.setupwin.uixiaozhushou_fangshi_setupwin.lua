







def_class("UIXiaoZhuShou_FangShi_SetupWin",UIWindowBase)









function UIXiaoZhuShou_FangShi_SetupWin:bindComponents()

self.root=UIObject.get(self,0)
self.select=UIToggleButton.get(self,1)
self.select2=UIToggleButton.get(self,2)
self.select2Text=UIText.get(self,3)
self.select2Text2=UIText.get(self,4)
self.selectText=UIText.get(self,5)
self.setupBtn=UIButton.get(self,6)
self.trainCountInputText=UIInputField.get(self,7)

self.setupBtn:setButtonClick(function()self:onSetupBtn()end)



end


function UIXiaoZhuShou_FangShi_SetupWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.select);self.select=nil;
_UIObject_release(self.select2);self.select2=nil;
_UIObject_release(self.select2Text);self.select2Text=nil;
_UIObject_release(self.select2Text2);self.select2Text2=nil;
_UIObject_release(self.selectText);self.selectText=nil;
_UIObject_release(self.setupBtn);self.setupBtn=nil;
_UIObject_release(self.trainCountInputText);self.trainCountInputText=nil;
end



















function UIXiaoZhuShou_FangShi_SetupWin:onLoaded(...)
self:bindComponents()
self.trainCountInputText:setChildInputFieldChange(true,function(...)
self:changeSelectCount(...)

end)
end


function UIXiaoZhuShou_FangShi_SetupWin:__delete()
self:unbindComponents()
end




function UIXiaoZhuShou_FangShi_SetupWin:onShow(argtable,afterOnloaded)
self.orderID=XIAOZHUSHU_ENUM.xzs_FangShi
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
if adController:supportPlayAD()then
self.select:setActive(true)
local isBuyNum=setupData[xzsDataKey.fsAutoUseGYQ]==1
local itemid=cfg_advertconfig().const_def.itemid
local num=itemsModel.getCount(itemid)
self.select:setToggle(isBuyNum)
self.select:setToggleChange(function(name,isOn)
setupData[xzsDataKey.fsAutoUseGYQ]=isOn and 1 or 0
end)
self.selectText:setText(FMT.fmt("自动使用<color=#ca631d>观影券刷新</color>（剩余观影券数量：<color=#ca631d>{0}</color>）",num))
self.select2Text2:setText("次（若观影券不足，则无法使用）")
else
self.select:setActive(false)
self.select2Text2:setText("次")
end


local isBuyUseLy=setupData[xzsDataKey.fsAutoUseLY]==1
self.select2:setToggle(isBuyUseLy)
self.select2:setToggleChange(function(name,isOn)
if isOn==1 and setupData[xzsDataKey.fsAutoUseGYQ]==0 and fairModel:has_Ad_flush_count()then
self.select:setToggle(1)
end
setupData[xzsDataKey.fsAutoUseLY]=isOn and 1 or 0
end)
self.select2Text:setText(FMT.fmt("自动使用<color=#ca631d>灵玉</color>额外刷新"))
local useItemNum=setupData[xzsDataKey.fsAutoUseLYnum]
self.trainCountInputText:setInputFieldValue(useItemNum or 1)
end

function UIXiaoZhuShou_FangShi_SetupWin:changeSelectCount(str)

local count=tonumber(str)
if count==nil then
count=1
end
local yetlynum=fairModel:enough_pay_flush_count()
local lymaxnum=fairModel.get_booth_pay_flush_times_limit()

local num=math.min(count,lymaxnum)
local setupData=xiaoZhuShouModel:getSetupData(self.orderID)
self.trainCountInputText:setInputFieldValue(num)

setupData[xzsDataKey.fsAutoUseLYnum]=num

end


function UIXiaoZhuShou_FangShi_SetupWin:onHide()

end
local pageWinList={
[1]="UICommonPageWin",
[2]="UICommonPageTwoWin",
}
function UIXiaoZhuShou_FangShi_SetupWin:onSetupBtn()


if not guildOrderModel:checkOrderActive(GUILD_ORDER_TYPE.eAutoBuy)then
UIManager.info("请先激活自动购买法令")
return
end
local setupWin=cfgHelper.get2(cfg_guildorderconfig_get,GUILD_ORDER_TYPE.eAutoBuy,'setupWin')
if setupWin==nil then return end

local winname=setupWin[1]
local titleName=setupWin[2]
local pageType=setupWin[3]or 1
local pageWinName=pageWinList[pageType]
local args={}
args.titleName=titleName
args.pos=3
args.showBG=true
args.extraWin=winname
args.extraParams={}
self:showWindow(pageWinName,args)
end


