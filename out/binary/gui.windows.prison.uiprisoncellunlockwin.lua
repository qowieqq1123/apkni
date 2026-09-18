







def_class("UIPrisonCellUnlockWin",UIWindowBase)









function UIPrisonCellUnlockWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.applyBtn=UIButton.get(self,1)
self.cancelBtn=UIButton.get(self,2)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UIPrisonCellUnlockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
end



















function UIPrisonCellUnlockWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIPrisonCellUnlockWin:__delete()
self:unbindComponents()
end




function UIPrisonCellUnlockWin:onShow(argtable,afterOnloaded)
self.id=argtable
local cfg=cfg_laofangconfig_get(self.id)
self.costs=cfg.unlockItem
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
UIManager:showWindow('UITopMoneyWin',{{self.costs[1][1]},{self.costs[2][1]}})
end


function UIPrisonCellUnlockWin:onHide()

end

function UIPrisonCellUnlockWin:checkEnough(costs)
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




function UIPrisonCellUnlockWin:onApplyBtn()
if self:checkEnough(self.costs)then
UIPrisonControl:reqUnlockCell(self.id)
self:onCloseClick()
end
end

function UIPrisonCellUnlockWin:onCancelBtn()
self:onCloseClick()
end

function UIPrisonCellUnlockWin:onCloseClick()
self:closeSelf()
UIManager:closeWindow('UITopMoneyWin')
end