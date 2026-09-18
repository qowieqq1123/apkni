




UIChildGuBao=simple_class(UIChildObject)

local iconname='button_zjmgubao'
local _this

function UIChildGuBao:onLoaded()

end

function UIChildGuBao:onShow(isInit)
if isInit then
_this=self
reddotClassManager.register_eventList({REDDIT_TYPE.eGuBaoBase,REDDIT_TYPE.eDaoBing,REDDIT_TYPE.eXianBao},
self.refreshReddot)
end
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()self:OnButtonClick()end,true)






self:delayRefreshReddot()
end


function UIChildGuBao:delayRefreshReddot()
if self.reddotTimer then return end
local func=function()
local isreddot=reddotClassManager.get_reddot(REDDIT_TYPE.eDaoBing)or
reddotClassManager.get_reddot(REDDIT_TYPE.eGuBaoBase)or
reddotClassManager.get_reddot(REDDIT_TYPE.eXianBao)
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
self:doPunchRotation(isreddot)
self.reddotTimer=nil
end
self.reddotTimer=timer.new()
self.reddotTimer:start(0.2,func,1)
end

function UIChildGuBao:OnButtonClick()


pfCommonHelper.gubaoReport()
UIFullGuBaoControl:showWindowMainWin()
end

function UIChildGuBao:release()
reddotClassManager.unregister_eventList({REDDIT_TYPE.eGuBaoBase,REDDIT_TYPE.eDaoBing,REDDIT_TYPE.eXianBao},
self.refreshReddot)
self:setChildActive(2,false)
self:doPunchRotation(false)
if self.reddotTimer then
self.reddotTimer:cancel()
end
self.reddotTimer=nil
_this=nil
end

function UIChildGuBao.refreshReddot(...)
if _this==nil then return end
if _this.reddotTimer then
_this.reddotTimer:cancel()
end
_this.reddotTimer=nil
local flag=reddotClassManager.get_reddot(REDDIT_TYPE.eDaoBing)or
reddotClassManager.get_reddot(REDDIT_TYPE.eGuBaoBase)or
reddotClassManager.get_reddot(REDDIT_TYPE.eXianBao)
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(false)
end

function UIChildGuBao:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end

function UIChildGuBao:doPunchRotation(isreddot)
if webGLHelper:isHidePunchAni()then return end
if isreddot then
if self.reddotTweener==nil then
self:setChildRotation(2,0,0,0)
local tweener=self:setChildDOPunchRotation(2,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self:setChildRotation(2,0,0,0)
end
end
end
