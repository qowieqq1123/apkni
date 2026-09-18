







def_class("UICommonChangeNumWin",UIWindowBase)









function UICommonChangeNumWin:bindComponents()

self.titleText=UIText.get(self,0)
self.inputField=UIInputField.get(self,1)
self.costIcon=UIImage.get(self,2)
self.costDesc=UIText.get(self,3)
self.costObj=UIButton.get(self,4)
self.inputDefaultTxt=UIText.get(self,5)

self.costObj:setButtonClick(function()self:onCostObj()end)



end


function UICommonChangeNumWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.inputField);self.inputField=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costDesc);self.costDesc=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.inputDefaultTxt);self.inputDefaultTxt=nil;
end















local _this




function UICommonChangeNumWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UICommonChangeNumWin:__delete()
_this=nil
self:unbindComponents()
end




function UICommonChangeNumWin:onShow(argtable,afterOnloaded)
self.title=argtable.title or'修改'
self.defaultNum=argtable.defaultNum
self.defaultDesc=argtable.defaultDesc or'请输入新值'
self.checkFunc=argtable.checkFunc
self.cost=argtable.cost
self.callback=argtable.callback
self.crossCheck=argtable.crossCheck

self:upDateView()
end


function UICommonChangeNumWin:onHide()

end

function UICommonChangeNumWin:upDateView()

self.titleText:setText(self.title)

if self.defaultNum then
self.inputField:setInputFieldValue(tostring(self.defaultNum))
end

self.inputDefaultTxt:setText(self.defaultDesc)

local cost=self.cost
local showCost=cost~=nil
self.showCost=showCost
self.costObj:setActive(showCost)
if showCost then
local costItemID=cost[1]
local costNum=cost[2]
self.costItemID=costItemID
self.costNum=costNum
local have=0
if moneyConfig.isMoney(costItemID)then
have=moneyModel.getMoney(costItemID)
else
have=itemBagModel:getItemCountByItemID(costItemID)
end
self.hasCostNum=have
local iconName=iconHelper.getIconName(costItemID)
self.costIcon:setImageIcon(iconName,false)
local nunStr
if have<costNum then
nunStr=FMT.fmt('<color=#E33021>{0}</color>',costNum)
else
nunStr=tostring(costNum)
end
self.costDesc:setText(nunStr)
end
end




function UICommonChangeNumWin:onCostObj()
gainControl:showGainWin(self.costItemID)
end

function UICommonChangeNumWin:onSureBtn()

AudioManager.playBtnClick()
local changeNumStr=self.inputField:getInputFieldValue()
if changeNumStr==nil or changeNumStr==''then
UIManager.error('不能为空')
return
end
local changeNum=tonumber(changeNumStr)
if self.defaultNum~=nil then
if changeNum==self.defaultNum then
UIManager.error('请输入新的值')
return
end
end

if self.showCost then
if self.hasCostNum<self.costNum then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(self.costItemID)))
return
end
end

local checkFunc=self.checkFunc
if checkFunc then
local ret,newNum=checkFunc(changeNum)
if not ret then
if newNum then
self.inputField:setInputFieldValue(tostring(newNum))
end
return
end
end

local callback=self.callback
if callback then
callback(changeNum)
end
self:closeSelf()
end

