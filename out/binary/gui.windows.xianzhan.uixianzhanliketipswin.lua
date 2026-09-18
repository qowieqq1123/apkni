







def_class("UIXianZhanLikeTipsWin",UIWindowBase)









function UIXianZhanLikeTipsWin:bindComponents()

self.nameText=UIText.get(self,0)
self.contentText=UIText.get(self,1)
self.itemsPanel=UIObject.get(self,2)



end


function UIXianZhanLikeTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.nameText);self.nameText=nil;
_UIObject_release(self.contentText);self.contentText=nil;
_UIObject_release(self.itemsPanel);self.itemsPanel=nil;
end

















function UIXianZhanLikeTipsWin:onLoaded(...)
self:bindComponents()
end


function UIXianZhanLikeTipsWin:__delete()
self:unbindComponents()
end


function UIXianZhanLikeTipsWin:onHide()

end




function UIXianZhanLikeTipsWin:onShow(argtable,afterOnloaded)
local customerId=argtable.customerId

local name=cfgHelper.getlang('xianzhan_fangke_like_tips_1')
local desc=cfgHelper.getlang('xianzhan_fangke_like_tips_2')
self.nameText:setText(name)
self.contentText:setText(desc)
local likeThing=cfgHelper.get2(cfg_xianzhanfangkeconfig_get,customerId,'likeThing')
local grid=self.itemsPanel:getChildCommonLayoutGroupWidgetList()
local count=grid.Count
for i=1,count do
local item=grid[i-1]
local data=likeThing[i]
local isshow=data~=nil
item:SetChildActive(-1,isshow)
if isshow then
item:SetChildText(1,data[1])
item:SetChildCSImageIcon(0,data[2],false)
end
end
end