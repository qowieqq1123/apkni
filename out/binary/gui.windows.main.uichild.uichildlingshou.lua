




UIChildLingShou=simple_class(UIChildObject)

local bgname='button_zmxditu_1'
local icon1name='image_shanfengxingxiang_1'
local icon2name='button_zhujiemian_2'

function UIChildLingShou:onLoaded()

end

function UIChildLingShou:onShow()
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,bgname)
self:setChildCSImageSprite(3,abname,icon1name)
self:setChildCSImageSprite(4,abname,icon2name)
self:setText(5,'灵兽山')
self:setChildButtonClick(1,function()self:OnButtonClick()end,true)
end

function UIChildLingShou:OnButtonClick()
if mainControl:isSceneType(eSceneType.eZongmen)then
if zongmenControl:isMountid(mapIdType.lingshoudao)then
mountainControl:loadAndswitchMapEx(mapIdType.zhufeng,true)
else
mountainControl:loadAndswitchMapEx(mapIdType.lingshoudao,true)
end
end
end

function UIChildLingShou:release()

end