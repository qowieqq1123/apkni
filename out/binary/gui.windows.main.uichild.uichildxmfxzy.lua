UIChildXMFXZY=simple_class(UIChildObject)

local iconname='button_zjmxiangzhu'

local _this

function UIChildXMFXZY:onLoaded()
_this=self

end

function UIChildXMFXZY:onShow(isInit)
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()
UIFullXianMengXianWuLouControl:showFXZYWindow()
end,true)
end

function UIChildXMFXZY:release()

_this=nil
end