







def_class("UIYFLTSettingWin",UIWindowBase)









function UIYFLTSettingWin:bindComponents()

self.againPlant=UIToggleButton.get(self,0)
self.showType_1=UIToggleButton.get(self,1)
self.showType_2=UIToggleButton.get(self,2)
self.showType_3=UIToggleButton.get(self,3)
self.showType_4=UIToggleButton.get(self,4)
self.showTypeClick_1=UIButton.get(self,5)
self.showTypeClick_2=UIButton.get(self,6)
self.showTypeClick_3=UIButton.get(self,7)
self.showTypeClick_4=UIButton.get(self,8)
self.title=UIText.get(self,9)

self.showTypeClick_1:setButtonClick(function()self:onShowTypeClick_1()end)

self.showTypeClick_2:setButtonClick(function()self:onShowTypeClick_2()end)

self.showTypeClick_3:setButtonClick(function()self:onShowTypeClick_3()end)

self.showTypeClick_4:setButtonClick(function()self:onShowTypeClick_4()end)
self.showType={
self.showType_1,
self.showType_2,
self.showType_3,
self.showType_4,
}
self.showTypeClick={
self.showTypeClick_1,
self.showTypeClick_2,
self.showTypeClick_3,
self.showTypeClick_4,
}



end


function UIYFLTSettingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.againPlant);self.againPlant=nil;
_UIObject_release(self.showType_1);self.showType_1=nil;
_UIObject_release(self.showType_2);self.showType_2=nil;
_UIObject_release(self.showType_3);self.showType_3=nil;
_UIObject_release(self.showType_4);self.showType_4=nil;
_UIObject_release(self.showTypeClick_1);self.showTypeClick_1=nil;
_UIObject_release(self.showTypeClick_2);self.showTypeClick_2=nil;
_UIObject_release(self.showTypeClick_3);self.showTypeClick_3=nil;
_UIObject_release(self.showTypeClick_4);self.showTypeClick_4=nil;
_UIObject_release(self.title);self.title=nil;
self.showType=nil;
self.showTypeClick=nil;
end



















function UIYFLTSettingWin:onLoaded(...)
self:bindComponents()

self.showTypeSetting,self.isagain=YiFangLingTianModel:Get_Setting()

for i,v in ipairs(self.showType)do
v:setToggle(i==self.showTypeSetting)
end
for i,v in ipairs(self.showTypeClick)do
v:setButtonClick(function()
self.showTypeSetting=i

YiFangLingTianModel:RecordSetting(self.showTypeSetting,self.isagain)
self:refreshShowType()
end)
end

self.againPlant:setToggle(self.isagain)
self.againPlant:setToggleChange(function(name,isOn)
self.isagain=isOn

YiFangLingTianModel:RecordSetting(self.showTypeSetting,self.isagain)
end)
end


function UIYFLTSettingWin:__delete()
self:unbindComponents()
UIManager:invokeUIMethod("UIYFLTMapWin","refreshSetting")
end




function UIYFLTSettingWin:onShow(argtable,afterOnloaded)

end

function UIYFLTSettingWin:refreshShowType()

for i,v in ipairs(self.showType)do
v:setToggle(i==self.showTypeSetting)
end
end


function UIYFLTSettingWin:onHide()
UIManager:invokeUIMethod("UIYFLTMapWin","refreshSetting")
end
function UIYFLTSettingWin:onClickClose()
self:closeSelf()
end


