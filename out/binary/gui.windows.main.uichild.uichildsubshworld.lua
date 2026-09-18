




UIChildSubSHWorld=simple_class(UIChildObject)

local defaultIcon='button_shanhaishijie'
local _this

function UIChildSubSHWorld:onLoaded()

end

function UIChildSubSHWorld:onShow(isInit)
if isInit then
_this=self
end
local abname=mainConfig.getBundleName()


local iconname=defaultIcon
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()self:OnButtonClick()end,true)
local isreddot=false
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
self:doPunchRotation(isreddot)

self:setChildActive(3,false)


self:checkState()
end

function UIChildSubSHWorld:OnButtonClick()
jumpManager:jump({id=JUMP_TYPE.eLimitActivity,args={actID=LIMIT_ACT_TYPE.eZhengZhanShanHai}})

UIManager:invokeUIMethod("UIMainSubEnterPanelWin","onMask")
end

function UIChildSubSHWorld:OnYuanZhuButtonClick()
xianjieController:reqHelpAll()
end

function UIChildSubSHWorld:release()
self:setChildActive(2,false)
self:doPunchRotation(false)

self:setChildActive(3,false)
_this=nil
end

function UIChildSubSHWorld.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end

function UIChildSubSHWorld:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end

function UIChildSubSHWorld:doPunchRotation(isreddot)
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

function UIChildSubSHWorld:checkState()
local isShowTips=false
local signIcon
local tipsStr
local actId=LIMIT_ACT_TYPE.eZhengZhanShanHai
local actInfo=limitActivitiesModel:getActInfo(actId)
if actInfo then
local condCheck,condStr=actInfo:checkCondition()
if condCheck then
if actId==LIMIT_ACT_TYPE.eZhengZhanShanHai then
local raceState=zhengzhanshanhaiModel:getLunState()
if raceState==eZZSH_State.ePVPStandby then
signIcon='icon_beizhan'
elseif raceState==eZZSH_State.ePVPFight then
signIcon='icon_zhanzhengzhon'
end
end
local leastTime=limitActivitiesModel:getActStartLeftTime(actId)
local actCfg=actInfo:getActConfig()
isShowTips=leastTime>0
if leastTime>0 then
tipsStr=FMT.fmt("quad-icon=icon_gantanhao_1-quad{0}后\n<color=#ca631d>{1}</color>现世",timeHelper.formatSimpleTime(leastTime),actCfg.name)

end
end
end

local showSign=signIcon~=nil
self:setChildActive(3,showSign)
if showSign then
local abname=mainConfig.getBundleName()
self:setChildCSImageSprite(3,abname,signIcon)
end

self:setChildActive(4,isShowTips)
if isShowTips then
self:setText(5,tipsStr)
end
end