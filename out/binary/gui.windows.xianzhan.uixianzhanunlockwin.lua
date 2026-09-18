







def_class("UIXianZhanUnLockWin",UIWindowBase)









function UIXianZhanUnLockWin:bindComponents()

self.content=UIText.get(self,0)
self.cancelButton=UIButton.get(self,1)
self.okButton=UIButton.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.titleText=UIText.get(self,4)
self.cancelText=UIText.get(self,5)
self.okText=UIText.get(self,6)
self.goodGrid=UIObject.get(self,7)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.okButton:setButtonClick(function()self:onOkButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianZhanUnLockWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.goodGrid);self.goodGrid=nil;
end



















function UIXianZhanUnLockWin:onLoaded(...)
self:bindComponents()
self.gainTable={}
end


function UIXianZhanUnLockWin:__delete()
self:unbindComponents()
end




function UIXianZhanUnLockWin:onShow(argtable,afterOnloaded)
local roomId=argtable.roomId
local data=xianzhanModel:getRoomDataByRoomId(roomId)
self.data=data
local unLockStr=''
local costList=cfgHelper.get2(cfg_xianzhanroomconfig_get,self.data.roomId,'unlock')
self.gainTable={}
local moneyList={}
if costList then
self.goodGrid:setChildLayoutGroupCreateItems(#costList)
local grids=self.goodGrid:getChildLayoutGroupGridList()
for i=1,grids.Count do
local item=grids[i-1]
local cost=costList[i]
local itemid=cost[1]
local need=cost[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
table.insert(moneyList,{itemid})
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
local countStr=mathHelper.formatBIGNumbereEx(need)
self.gainTable[itemid]=need
local grayNum=have<need and(have>0 and 2 or 3)or 0
local conf={itemid=itemid,showCountBG=true,itemcount=countStr,gray=grayNum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onItemClick(TIPS_MOVE_POS.eRight,...)end)
end
unLockStr='需要消耗以下材料来打扫房间'
else
unLockStr='是否解锁该房间？'
end
self.content:setText(unLockStr)

local showMoney=argtable.showMoney
if showMoney==true and#moneyList>0 then
self:showWindow('UITopMoneyWin2',moneyList)
end
end


function UIXianZhanUnLockWin:onHide()

end

function UIXianZhanUnLockWin:onItemClick(pos,itemid,index,itemguid,attach)
if itemid~=-1 then
local need=self.gainTable[itemid]
if gainControl:showGainWin(itemid,need)then return end
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=pos})
end
end

function UIXianZhanUnLockWin:checkCost()
local costList=cfgHelper.get2(cfg_xianzhanroomconfig_get,self.data.roomId,'unlock')
if costList then
for i,v in ipairs(costList)do
local cost=costList[i]
local itemid=cost[1]
local need=cost[2]
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
end
if have<need then
return false,itemid,need
end
end
end
return true
end


function UIXianZhanUnLockWin:onCancelButton()
self:onCloseBtn()
end

function UIXianZhanUnLockWin:onOkButton()
local ret,itemid,need=self:checkCost()
if ret then
xianzhanController:req_unlock_room(self.data.roomId)
else
UIManager.error('消耗不足')
gainControl:showGainWin(itemid)
end
end

function UIXianZhanUnLockWin:onCloseBtn()
self:closeSelf()
end

