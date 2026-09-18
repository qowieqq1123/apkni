







def_class("UIAquariumFilterWin",UIWindowBase)









function UIAquariumFilterWin:bindComponents()

self.btnConfirm=UIButton.get(self,0)
self.btnReset=UIButton.get(self,1)
self.cliskMask=UIButton.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.pageCreater=UIObject.get(self,4)
self.titleName=UIText.get(self,5)

self.btnConfirm:setButtonClick(function()self:onBtnConfirm()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.cliskMask:setButtonClick(function()self:onCliskMask()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIAquariumFilterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnConfirm);self.btnConfirm=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.cliskMask);self.cliskMask=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.pageCreater);self.pageCreater=nil;
_UIObject_release(self.titleName);self.titleName=nil;
end



















function UIAquariumFilterWin:onLoaded(...)
self:bindComponents()
end


function UIAquariumFilterWin:__delete()
self:unbindComponents()
end




function UIAquariumFilterWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.selectidlist=argtable.selectlist or{}
self:refresh()
end

function UIAquariumFilterWin:refresh()
local pagenum=1
self.pageCreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.pageCreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end


function UIAquariumFilterWin:refreshPageItem(item,pageidx)
local fishfeaturecfg=UIAquariumControl:GetAllfishfeature()
local childnum=#fishfeaturecfg
item:SetChildLayoutGroupCreateItems(1,childnum)
self.childGrids=item:GetChildLayoutGroupGridList(1)
for i=1,childnum do
local childItem=self.childGrids[i-1]
self:refreshChildItem(childItem,i,fishfeaturecfg[i])
end
end

function UIAquariumFilterWin:refreshChildItem(childItem,idx,singlecfg)
local widget=childItem:GetChildWidgetBase(4)
childItem:SetChildToggle(0,self.selectidlist[idx]or false)
childItem:SetChildToggleChange(0,function(name,isOn)
self.selectidlist[idx]=isOn
if isOn then

end
end)
widget:SetChildButtonClick(0,function()
UIAquariumControl:showSpecialityTips(idx,widget)
end)
widget:SetChildText(1,singlecfg.name)
end

function UIAquariumFilterWin:onHide()

end






function UIAquariumFilterWin:onBtnConfirm()
self.callback(self.selectidlist)
self:closeSelf()
end



function UIAquariumFilterWin:onBtnReset()
if next(self.selectidlist)then
for k,v in pairs(self.selectidlist)do
self.childGrids[k-1]:SetChildToggle(0,false)
end
end
self.selectidlist={}
end



function UIAquariumFilterWin:onCliskMask()
end



function UIAquariumFilterWin:onCloseBtn()
self:closeSelf()
end

