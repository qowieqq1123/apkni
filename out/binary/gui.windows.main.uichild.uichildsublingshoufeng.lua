




UIChildSubLingShouFeng=simple_class(UIChildObject)




local defaultIcon='button_lingshoufeng'

function UIChildSubLingShouFeng:onLoaded()

end

function UIChildSubLingShouFeng:onShow()
local abname=mainConfig.getBundleName()


local iconname=defaultIcon
self:setChildCSImageSprite(0,abname,iconname)


self:setChildButtonClick(1,function()self:OnButtonClick()end,true)
local isreddot=false
self:setChildActive(2,isreddot)
self:setChildActive(3,false)
self:setChildActive(4,false)
end

function UIChildSubLingShouFeng:OnButtonClick()










lingshouController:enterLingShouDaoMap()

UIManager:invokeUIMethod("UIMainSubEnterPanelWin","onMask")
end

function UIChildSubLingShouFeng:release()

end