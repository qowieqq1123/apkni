







def_class("UIBaGuaLuFilterWin",UIWindowBase)









function UIBaGuaLuFilterWin:bindComponents()

self.btnComfirm=UIButton.get(self,0)
self.desc=UIText.get(self,1)
self.specialCreater=UIObject.get(self,2)

self.btnComfirm:setButtonClick(function()self:onBtnComfirm()end)



end


function UIBaGuaLuFilterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnComfirm);self.btnComfirm=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.specialCreater);self.specialCreater=nil;
end


















function UIBaGuaLuFilterWin:onLoaded(...)
self:bindComponents()
end

function UIBaGuaLuFilterWin:__delete()
self:unbindComponents()
end

function UIBaGuaLuFilterWin:onShow(argtable,afterOnloaded)
self.list=argtable.list
self.descFunc=argtable.descFunc
self.title=argtable.title
self.selectCall=argtable.selectCall
self.filter=argtable.filter
self:freshSpecialView()
self.desc:setText(self.descFunc(self.filter))
end

function UIBaGuaLuFilterWin:onHide()

end





function UIBaGuaLuFilterWin:onBtnComfirm()
self.selectCall(self.filter)
self:closeSelf()
UIManager:closeWindow("UICommonPageWin")
end


function UIBaGuaLuFilterWin:freshSpecialView()
self.specialCreater:setChildLayoutGroupCreateItems(1)
local grids=self.specialCreater:getChildLayoutGroupGridList()
local item=grids[0]
self:freshSpeicalPageItem(item,1)
end

function UIBaGuaLuFilterWin:freshSpeicalPageItem(widget)
local list=self.list

local selectIdx=self.filter or 1

widget:SetChildText(1,self.title)

local len=#list
widget:SetChildLayoutGroupCreateItems(0,len)
local grids=widget:GetChildLayoutGroupGridList(0)
for i=1,len do
local item=grids[i-1]
self:freshSpeicalChildItem(item,i)
end
end

function UIBaGuaLuFilterWin:freshSpeicalChildItem(item,idx)
local info=self.list[idx]
local name=info.nameFunc()
local selectIdx=self.filter or 1
local isSelect=selectIdx==idx
item:SetChildToggle(0,isSelect)
item:SetChildActive(2,isSelect)
item:SetChildToggleChange(0,function(name,isOn)
if isOn then
self.filter=idx
self:freshSpecialView()
self.desc:setText(self.descFunc(self.filter))
end
end)
item:SetChildText(1,name)
end
