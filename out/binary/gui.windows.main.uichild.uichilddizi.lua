




UIChildDizi=simple_class(UIChildObject)

local iconname='button_zjmdizi'
local _this

function UIChildDizi:onLoaded()

end

function UIChildDizi:onShow(isInit)
if isInit then
_this=self
reddotClassManager.register_event(REDDIT_SUB_TYPE.sDiscipleBase,self.refreshReddot)
reddotClassManager.register_event(REDDIT_SUB_TYPE.sDiscipleWenXin,self.refreshWXGReddot)
reddotClassManager.register_event(REDDIT_SUB_TYPE.sDiscipleXianMo,self.refreshXianMoReddot)
reddotClassManager.register_event(REDDIT_SUB_TYPE.sDiscipleLingGen,self.refreshLinggenTeQuan)
reddotClassManager.register_event(REDDIT_SUB_TYPE.sLingShouEnter,self.refreshLingShouReddot)
notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)
end


self:refreshBtnImage()
self.widget:SetChildButtonClick(1,function()self:OnButtonClick()end,true,0)



self:delayRefreshReddot()
end


function UIChildDizi:delayRefreshReddot()
if self.reddotTimer then return end
local func=function()
local isreddot=reddotClassManager.get_reddot(REDDIT_SUB_TYPE.sDiscipleBase)
local isWxgReddot=reddotClassManager.get_reddot(REDDIT_SUB_TYPE.sDiscipleWenXin)
local isXianMoReddot=reddotClassManager.get_reddot(REDDIT_SUB_TYPE.sDiscipleXianMo)
local isLingGenTqOnReddot=mzbkModel:getOneTimeReddot()
local isLingShouReddot=reddotClassManager.get_reddot(REDDIT_SUB_TYPE.sLingShouEnter)

if isreddot then
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
self:doPunchRotation(isreddot)
else
self:setChildActive(2,isWxgReddot or isXianMoReddot or isLingGenTqOnReddot or isLingShouReddot)
self:refreshReddotView()
self:doPunchRotation(isWxgReddot or isXianMoReddot or isLingGenTqOnReddot or isLingShouReddot)
end
self.reddotTimer=nil
end
self.reddotTimer=timer.new()
self.reddotTimer:start(0.1,func,1)
end

function UIChildDizi:OnButtonClick()

local cnt=UIDiscipleModel:checkDiscipleCount()
if cnt<=0 then
UIManager.error('没有弟子')
return
end

UIFullDiscipleSelectControl:showDiscipleSelectWindow()
end

function UIChildDizi:release()
reddotClassManager.unregister_event(REDDIT_SUB_TYPE.sDiscipleBase,self.refreshReddot)
reddotClassManager.unregister_event(REDDIT_SUB_TYPE.sDiscipleWenXin,self.refreshWXGReddot)
reddotClassManager.unregister_event(REDDIT_SUB_TYPE.sDiscipleXianMo,self.refreshXianMoReddot)
reddotClassManager.unregister_event(REDDIT_SUB_TYPE.sDiscipleLingGen,self.refreshLinggenTeQuan)
reddotClassManager.unregister_event(REDDIT_SUB_TYPE.sLingShouEnter,self.refreshLingShouReddot)
notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)

self:setChildActive(2,false)
self:doPunchRotation(false)
if self.reddotTimer then
self.reddotTimer:cancel()
end
self.reddotTimer=nil
_this=nil
end

function UIChildDizi.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
if _this.reddotTimer then
_this.reddotTimer:cancel()
end
_this.reddotTimer=nil
_this:setChildActive(2,flag)
_this:doPunchRotation(flag)
_this:refreshReddotView(flag)
end

function UIChildDizi.refreshWXGReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
if _this.reddotTimer then
_this.reddotTimer:cancel()
end
_this.reddotTimer=nil
_this:setChildActive(2,flag)
_this:doPunchRotation(flag)
_this:refreshReddotView()
end

function UIChildDizi.refreshXianMoReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
if _this.reddotTimer then
_this.reddotTimer:cancel()
end
_this.reddotTimer=nil
_this:setChildActive(2,flag)
_this:doPunchRotation(flag)
_this:refreshReddotView()
end

function UIChildDizi.refreshLinggenTeQuan(class,sub_typo,last_flag,flag)
if _this==nil then return end
if _this.reddotTimer then
_this.reddotTimer:cancel()
end
_this.reddotTimer=nil
_this:setChildActive(2,flag)
_this:doPunchRotation(flag)
_this:refreshReddotView()
end

function UIChildDizi.refreshLingShouReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
if _this.reddotTimer then
_this.reddotTimer:cancel()
end
_this.reddotTimer=nil
_this:setChildActive(2,flag)
_this:doPunchRotation(flag)
_this:refreshReddotView()
end

function UIChildDizi:refreshReddotView(isreddot)

local reddotImg
if isreddot then
reddotImg='image_dujie_2'
self.reddotType=1
else
reddotImg='image_daojutishikuang_1'
self.reddotType=2
end
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=self.reddotType==1 and-35 or-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
end

function UIChildDizi:doPunchRotation(isreddot)
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

function UIChildDizi:refreshBtnImage()
local imageName=iconname
local isOpenLingShou=systemModel.isOpen(SYSTEM_DEFINE.eLingShou)
if isOpenLingShou then
imageName="button_zjmlingshou"
end
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(0,abname,imageName)
end

function UIChildDizi.on_system_open(sysId)
if _this==nil then return end
if sysId==SYSTEM_DEFINE.eLingShou then
_this:refreshBtnImage()
end
end
