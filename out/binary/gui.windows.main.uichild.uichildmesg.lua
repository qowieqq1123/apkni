




UIChildMesg=simple_class(UIChildObject)

local iconname='button_zjmxinjian'

local _this

function UIChildMesg:onLoaded()

end

function UIChildMesg:onShow(isInit)
if isInit then
_this=self
reddotClassManager.register_event(REDDIT_TYPE.eMail,self.refreshReddot)
end
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()
mailController:showMailUI()
end,true)
local isreddot=mailController:hasReddot()
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
end

function UIChildMesg:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eMail,self.refreshReddot)
_this=nil
end

function UIChildMesg.refreshReddot(class,sub_typo,last_flag,flag)
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
end

function UIChildMesg:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end