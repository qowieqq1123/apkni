




UIChildFriend=simple_class(UIChildObject)

local iconname='button_zjmdaoyou'

local _this

function UIChildFriend:onLoaded()

end

function UIChildFriend:onShow(isInit)
if isInit then
_this=self
reddotClassManager.register_event(REDDIT_TYPE.eFriend,self.refreshReddot)
end
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()
friendController:showMainUI()
end,true)
local isreddot=friendController:hasReddot()
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
end

function UIChildFriend:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eFriend,self.refreshReddot)
_this=nil
end

function UIChildFriend.refreshReddot(class,sub_typo,last_flag,flag)
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
end

function UIChildFriend:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end