







def_class("UIXianJie_cloudSearchWin",UIWindowBase)









function UIXianJie_cloudSearchWin:bindComponents()

self.itemsGridPanel=UIObject.get(self,0)
self.titleTxt=UIText.get(self,1)



end


function UIXianJie_cloudSearchWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemsGridPanel);self.itemsGridPanel=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end
















local _this=nil


function UIXianJie_cloudSearchWin:onLoaded(...)
_this=self
self:bindComponents()
self.titleTxt:setText('仙雾探查')
end


function UIXianJie_cloudSearchWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXianJie_cloudSearchWin:onHide()

end




function UIXianJie_cloudSearchWin:onShow(argtable,afterOnloaded)
if argtable then
self.cloudList=argtable.cloudList
end
if self.cloudList==nil then
self.cloudList=xianjieModel:getCloudMsgList()
end
self:refreshView()
end

function UIXianJie_cloudSearchWin:refreshView()
local n=#self.cloudList
self.itemsGridPanel:setChildLayoutGroupCreateItems(n)
local grids=self.itemsGridPanel:getChildLayoutGroupGridList()
for i=1,n do
local item=grids[i-1]
self:refreshItem(item,i)
end
end

function UIXianJie_cloudSearchWin:refreshItem(item,index)
local cloudid=self.cloudList[index]
local name=cfgHelper.get2(cfg_fairylandcloudconfig_get,cloudid,'name')

item:SetChildText(0,name)

local desc_str
local cloudData=xianjieModel:getCloudData(cloudid)
local canUnlock=cloudData:canUnlock()
if canUnlock then
desc_str='此片区域已探查完毕'
else
local idx=cloudData.idx+1
desc_str=cfgHelper.get3(cfg_fairylandcloudunlockconfig_get,cloudid,idx,'desc')
end
item:SetChildText(1,desc_str)

item:SetChildButtonClick(2,function()
if _this==nil then return end
_this:onGotoBtn(index)
end,true)

local isReddot=canUnlock
item:SetChildActive(3,isReddot)
end

function UIXianJie_cloudSearchWin:onGotoBtn(index)
local cloudid=self.cloudList[index]
xianjieController:handleClickCloud(cloudid)
self:closeSelf()
end

function UIXianJie_cloudSearchWin:onClickClose()
self:closeSelf()
end