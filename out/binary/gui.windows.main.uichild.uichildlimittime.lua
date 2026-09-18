




UIChildLimitTime=simple_class(UIChildObject)

local iconname='button_zjmxianshi'

function UIChildLimitTime:onLoaded()

end

function UIChildLimitTime:onShow()
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()print('click limittime')end,true)
end

function UIChildLimitTime:release()

end