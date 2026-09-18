







def_class("UIPrisonMoUnlockWin",UIWindowBase)









function UIPrisonMoUnlockWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.applyBtn=UIButton.get(self,1)
self.desc=UIText.get(self,2)
self.level=UIText.get(self,3)
self.unlockText=UIText.get(self,4)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)



end


function UIPrisonMoUnlockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.unlockText);self.unlockText=nil;
end



















function UIPrisonMoUnlockWin:onLoaded(...)
self:bindComponents()
self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIPrisonMoUnlockWin:__delete()
self:unbindComponents()
end




function UIPrisonMoUnlockWin:onShow(argtable,afterOnloaded)
self.taskId=argtable[1]
self.costs=argtable[2]
self.descs=argtable[3]

local len=#self.costs
local ml=len>5 and 5 or len
self.scrollview:setChildScrollViewCreateGrids(len,ml)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count

for i=1,count do
local item=grids[i-1]
local data={self.costs[i][1],self.costs[i][2],checkAmount=true}
widgetHelper.setNormalRewardItem(item,0,data)
end


local title_str=cfgHelper.get2(cfg_taskconfig_get,self.taskId,'name')
local isFinish=taskModel:checkTaskFinish(self.taskId)or false

if not isFinish then
self.level:setText(string.format('完成主线任务<color=#C82C2C>%s</color>可修复',title_str))
end

self.level:setActive(not isFinish)
self.applyBtn:setActive(isFinish)
self.desc:setText(self.descs)

UIManager:showWindow('UITopMoneyWin',{{self.costs[1][1]},{self.costs[2][1]}})
end


function UIPrisonMoUnlockWin:onHide()

end

function UIPrisonMoUnlockWin:checkEnough(costs)
for i,v in ipairs(costs)do
local itemId=v[1]
local itemCount=v[2]
local have
if moneyConfig.isMoney(itemId)then
have=moneyModel.getMoney(itemId)
else
have=bagModel.getItemCountById(itemId)
end
if have<itemCount then
UIManager.error('材料不足')
gainControl:showGainWin(itemId)
return false
end
end
return true
end




function UIPrisonMoUnlockWin:onApplyBtn()
if self:checkEnough(self.costs)then
UIPrisonControl:reqUnlockMoYu()
self:onCloseClick()
end
end

function UIPrisonMoUnlockWin:onCloseClick()
self:closeSelf()
UIManager:closeWindow('UITopMoneyWin')
end