







def_class("UIXianMengGXBTaskRewardDialouge",UIWindowBase)









function UIXianMengGXBTaskRewardDialouge:bindComponents()

self.dialougeText=UIText.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.okButton=UIButton.get(self,2)
self.getted=UIObject.get(self,3)
self.titleText=UIText.get(self,4)
self.goodGrid=UIObject.get(self,5)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIXianMengGXBTaskRewardDialouge:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dialougeText);self.dialougeText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.getted);self.getted=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.goodGrid);self.goodGrid=nil;
end



















function UIXianMengGXBTaskRewardDialouge:onLoaded(...)
self:bindComponents()
end


function UIXianMengGXBTaskRewardDialouge:__delete()
self:unbindComponents()
end




function UIXianMengGXBTaskRewardDialouge:onShow(argtable,afterOnloaded)

self.titleText:setText(argtable.title or'提示')
self.dialougeText:setText(argtable.desc or"")

self.okButton:setActive(not argtable.finish)
self.getted:setActive(argtable.finish)

local showReward=argtable.rewards~=nil
if showReward then

local rwlist=argtable.rewards
local num=#rwlist
self.goodGrid:setChildLayoutGroupCreateItems(num)
local grid=self.goodGrid:getChildLayoutGroupGridList()
local c=grid.Count
if c>4 then
self.goodGrid:setLocalPosX(500)
end
for i=1,num do
local item=grid[i-1]
local good=rwlist[i]
local itemid=good[1]
local itemnum=good[2]
local has=itemsModel.getCount(itemid)
local num_str
local showCountBG
if itemnum>1 then
num_str=tostring(itemnum)
showCountBG=true
else
num_str=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=num_str,showname=false,itemIndex=i,showStage=true,showCountBG=showCountBG}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
self:onItemClick(...)
end)
end
end

self.cancelCB=argtable.cancelCB
self.commitCB=argtable.commitCB
end


function UIXianMengGXBTaskRewardDialouge:onHide()

end





function UIXianMengGXBTaskRewardDialouge:onCloseBtn()
local cb=self.cancelCB
self:closeSelf()
if cb then
cb()
end
end



function UIXianMengGXBTaskRewardDialouge:onOkButton()
local cb=self.commitCB
self:closeSelf()
if cb then
cb()
end
end


function UIXianMengGXBTaskRewardDialouge:onItemClick(itemid,index,guid,attach)
tipsManager.showTips({itemid=itemid,itemguid=guid,attach=attach})
end

function UIXianMengGXBTaskRewardDialouge:onBGClick()
self:onCloseBtn()
end