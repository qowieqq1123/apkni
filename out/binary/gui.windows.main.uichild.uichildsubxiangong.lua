




UIChildSubXianGong=simple_class(UIChildObject)

local defaultIcon='button_zjmxiangong'
local _this

function UIChildSubXianGong:onLoaded()
reddotClassManager.register_event(REDDIT_TYPE.eXianGong,self.refreshReddot)
end

function UIChildSubXianGong:onShow(isInit)
if isInit then
_this=self
end
local abname=mainConfig.getBundleName()


local iconname=defaultIcon
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()self:OnButtonClick()end,true)
local isreddot=reddotClassManager.get_reddot(REDDIT_TYPE.eXianGong)
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
self:doPunchRotation(isreddot)

self:setChildActive(3,false)


self:setChildActive(4,false)
end

function UIChildSubXianGong:OnButtonClick()



local id=2
local cfg=xianjieModel:GetForceCfg(id)
local flag=xianjieModel:judeForceisOpen(id)
if not flag then
if cfg.talktreeid then
worldStoryController:showStoryTree(cfg.talktreeid)
end
return
end

if id==1 then
UIFullXJForceControl:showYuJingMainWindow()
elseif id==2 then
UIFullXJForceControl:showXianGongMainWindow()
elseif id==3 then
UIFullXJForceControl:showPengLaiMainWindow()
elseif id==4 then
UIFullXJForceControl:showJiuYuanMainWindow()
end

UIFullXJForceControl:showWindow("UIXianJieForceWin",{Forceid=id})




UIManager:invokeUIMethod("UIMainSubEnterPanelWin","onMask")
end

function UIChildSubXianGong:OnYuanZhuButtonClick()
xianjieController:reqHelpAll()
end

function UIChildSubXianGong:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eXianGong,self.refreshReddot)
self:setChildActive(2,false)
self:doPunchRotation(false)

self:setChildActive(3,false)
_this=nil
end

function UIChildSubXianGong.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end

function UIChildSubXianGong:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end

function UIChildSubXianGong:doPunchRotation(isreddot)
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