




UIChildTianDaoShu=simple_class(UIChildObject)

local iconname='button_zjmtiandaoshu'

local _this

function UIChildTianDaoShu:onLoaded()
_this=self

end

function UIChildTianDaoShu:onShow(isInit)
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()
UIFullTianDaoShuController:touchBuild()
end,true)
end

function UIChildTianDaoShu:release()

_this=nil
end