







def_class("UIAirMiniGameMainWin",UIWindowBase)









function UIAirMiniGameMainWin:bindComponents()

self.boss=UIObject.get(self,0)
self.damage=UIObject.get(self,1)
self.icon=UIImage.get(self,2)
self.joyStick=UIObject.get(self,3)
self.joyStickRoot=UIObject.get(self,4)
self.level=UIText.get(self,5)
self.lv=UIText.get(self,6)
self.moneyNum=UIText.get(self,7)
self.progressBar=UIProgressBarAni.get(self,8)
self.round=UIText.get(self,9)
self.skillMount=UIObject.get(self,10)
self.skillRole=UIObject.get(self,11)
self.time=UIText.get(self,12)
self.timeRoot=UIObject.get(self,13)
self.top=UIObject.get(self,14)
self.pauseClickArea=UIButton.get(self,15)
self.joyStickArrow=UIObject.get(self,16)

self.pauseClickArea:setButtonClick(function()self:onPauseClickArea()end)



end


function UIAirMiniGameMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.boss);self.boss=nil;
_UIObject_release(self.damage);self.damage=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.joyStick);self.joyStick=nil;
_UIObject_release(self.joyStickRoot);self.joyStickRoot=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.lv);self.lv=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.round);self.round=nil;
_UIObject_release(self.skillMount);self.skillMount=nil;
_UIObject_release(self.skillRole);self.skillRole=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timeRoot);self.timeRoot=nil;
_UIObject_release(self.top);self.top=nil;
_UIObject_release(self.pauseClickArea);self.pauseClickArea=nil;
_UIObject_release(self.joyStickArrow);self.joyStickArrow=nil;
end
















local _this
local defaultTimePosY=-10
local defaultTimeSize=1
local finalTimePosY=-80
local finalTimeSize=2



function UIAirMiniGameMainWin:onLoaded(...)
_this=self
self:bindComponents()
local joyStick=self.joyStick:getTransform()
CS.PlayerInput.Instance:BindJoyStick(joyStick)
self:addNotify(notifyConfig.joystickMoveStart,function(...)self:onMoveStart(...)end)
self:addNotify(notifyConfig.joystickMove,function(...)self:onMove(...)end)
self:addNotify(notifyConfig.joystickMoveEnd,function(...)self:onMoveEnd(...)end)

local moneyIconName=cfgHelper.get(cfg_aircommonconfig_get,1,"moneyIcon")
self.icon:setIcon(moneyIconName,false)
self:freshMoney()
self.skillTimer={}

self.progressBar:setFinishAction(function(...)
if not _this then return end
return _this:onProgressAniFinish(...)
end)
if airLevelSystem:isLevelDoing()then
airLevelSystem:onRefreshWin()
end
end

function UIAirMiniGameMainWin:__delete()
_this=nil
CS.PlayerInput.Instance:UnBindJoyStick()

self:unbindComponents()
end

function UIAirMiniGameMainWin:onShow(argtable,afterOnloaded)

end

function UIAirMiniGameMainWin:onHide()

end



function UIAirMiniGameMainWin:onMove(screenPoint)
local speed=Time.deltaTime*5
local originalPoint=screenPoint
screenPoint={x=screenPoint.x*speed,y=screenPoint.y*speed}
airActorSystem:onMove(screenPoint)

local angle=mathHelper.getAngleByPos(0,0,originalPoint.x,originalPoint.y)
self.joyStickArrow:setRotation(0,0,angle-90)
local maxRadius=1
local distance=mathHelper.distance(0,0,originalPoint.x,originalPoint.y)
local alpha=math.abs(distance/maxRadius)
if alpha>1 then
alpha=1
end
self.joyStickArrow:setChildCanvasGroupAlpha(alpha)
end

function UIAirMiniGameMainWin:onMoveStart()

end

function UIAirMiniGameMainWin:onMoveEnd()
airActorSystem:onMoveEnd()
self.joyStickArrow:setRotation(0,0,0)
self.joyStickArrow:setChildCanvasGroupAlpha(0)
end

function UIAirMiniGameMainWin:startLevel(args)
local levelCfg=args.levelCfg
self.levelCfg=levelCfg
local levelTime=levelCfg.levelTime
self.maxlevel=args.maxLevel
local levelIdx=args.curLevelIdx or 1
self:stopCountTimer()
if levelTime then
self.endStamp=levelTime+airController:getRealServerTime_long()+airLevelSystem:getPauseTime()
self:startCountTimer()
else
self.timeRoot:setActive(false)
end

self:freshRound(levelIdx)

self.level:setText(levelCfg.name)

self:initSkills()

self:refreshExp(true)
self:freshMoney()

self:startGuide(levelIdx)
end

function UIAirMiniGameMainWin:endLevel()
self:stopAllTimer()
self.countTimer=nil
self.skillTimer={}
self.levelCfg=nil
self.timeRoot:setActive(false)

end

function UIAirMiniGameMainWin:stopCountTimer()
if self.countTimer then
self:stopTimerByID(self.countTimer)
end
self.countTimer=nil
end

function UIAirMiniGameMainWin:startCountTimer()
local tick=function()
local pauseTime=airLevelSystem:getPauseTime()
local nowTime=airController:getRealServerTime_long()
local lerp=self.endStamp-nowTime
local left=lerp+pauseTime
left=math.floor(left)
local str=left
if left<0 then
str=0
end
self.time:setText(str)


local textSize=defaultTimeSize
local textPosY=defaultTimePosY
if left<10 then
textSize=finalTimeSize
textPosY=finalTimePosY
end
self.time:setScale(Vector3.New(textSize,textSize,textSize))
self.time:setChildAnchoredPos(0,textPosY)
end
self.countTimer=self:setTimer(0.5,0,tick)
self.timeRoot:setActive(true)
tick()
end

function UIAirMiniGameMainWin:freshRound(round)
self.round:setText(FMT.fmt('{0}/{1}',round,self.maxlevel))
end

local guideList={1283,1284,1285}
function UIAirMiniGameMainWin:startGuide(round)
if airGameEnterModel:checkFirstLevel()then
if guideList[round]then
weakGuideController:beginGuide(guideList[round])
end
end
end

function UIAirMiniGameMainWin:startDamage()
local index=self.damage:getID()
if self.tweener then
self.tweener:Rewind()
self.tweener:Kill()
self.tweener=nil
end
local tweener=self.winlua:SetChildCanvasGroupDOFade(index,1,0.5)
self.tweener=tweener
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(5,_LoopType.Yoyo)
tweener:OnComplete(function()
tweener:Rewind()
self.tweener=nil
end)
end

function UIAirMiniGameMainWin:initSkills()
if not airActorSystem:hasActor()then return end

self.mountSkillid=airActorSystem:getMountSkillid()
self.roleSkillid=airActorSystem:getRoleSkillid()

local skillid=self.mountSkillid
if skillid then
self.skillMount:setActive(true)
local widget=self.skillMount:getChildWidgetBase()
local icon=cfgHelper.get2(cfg_airskillconfig_get,skillid,'icon')
local iconName=iconHelper.getSkillIcon(icon)
local cd=airActorSystem:getCoolDownSkill(skillid,true)
widget:SetChildIcon(0,iconName,false)
widget:SetChildButtonClick(0,function()
if airActorSystem:isCoolDownSkill(skillid)then
local ret=airActorSystem:castMountSkill()
if ret==-2 then
UIManager.error('异常状态无法释放技能')
return
end
self:setSkillTimer(widget,skillid)
else
UIManager.error('技能正处于冷却中')
end
end,true)
widget:SetChildButtonClick(4,function()
if airActorSystem:isCoolDownSkill(skillid)then
local ret=airActorSystem:castMountSkill()
if ret==-2 then
UIManager.error('异常状态无法释放技能')
return
end
self:setSkillTimer(widget,skillid)
else
UIManager.error('技能正处于冷却中')
end
end,true)
widget:SetChildActive(1,cd>0)
widget:SetChildActive(3,cd<=0)
self:setSkillTimer(widget,skillid)
else
self.skillMount:setActive(false)
end

local skillid=self.roleSkillid
local widget=self.skillRole:getChildWidgetBase()
local icon=cfgHelper.get2(cfg_airskillconfig_get,skillid,'icon')
local iconName=iconHelper.getSkillIcon(icon)
local cd=airActorSystem:getCoolDownSkill(skillid,true)
widget:SetChildIcon(0,iconName,false)
widget:SetChildButtonClick(0,function()
if airActorSystem:isCoolDownSkill(skillid)then
local ret=airActorSystem:castSkillOnTarget(skillid)
if ret==-2 then
UIManager.error('异常状态无法释放技能')
return
end
self:setSkillTimer(widget,skillid)
else
UIManager.error('技能正处于冷却中')
end
end,true)
widget:SetChildButtonClick(4,function()
if airActorSystem:isCoolDownSkill(skillid)then
local ret=airActorSystem:castSkillOnTarget(skillid)
if ret==-2 then
UIManager.error('异常状态无法释放技能')
return
end
self:setSkillTimer(widget,skillid)
else
UIManager.error('技能正处于冷却中')
end
end,true)
widget:SetChildActive(1,cd>0)
widget:SetChildActive(3,cd<=0)
self:setSkillTimer(widget,skillid)
end

function UIAirMiniGameMainWin:freshMountSkillCool()
local skillid=self.mountSkillid
if skillid then
self.skillMount:setActive(true)
local widget=self.skillMount:getChildWidgetBase()
local cd=airActorSystem:getCoolDownSkill(skillid,true)
widget:SetChildActive(1,cd>0)
widget:SetChildActive(3,cd<=0)
self:setSkillTimer(widget,skillid)
else
self.skillMount:setActive(false)
end
end

function UIAirMiniGameMainWin:freshRoleSkillCool()
local skillid=self.roleSkillid
if skillid then
self.skillRole:setActive(true)
local widget=self.skillRole:getChildWidgetBase()
local cd=airActorSystem:getCoolDownSkill(skillid,true)
widget:SetChildActive(1,cd>0)
widget:SetChildActive(3,cd<=0)
self:setSkillTimer(widget,skillid)
else
self.skillRole:setActive(false)
end
end

function UIAirMiniGameMainWin:clearExpData()
self.nowShowLevel=nil
self.nowShowExp=nil
self.nowTargetExp=nil
self.lastExp=nil
self.isInProgressBarAnim=nil
self.progressCur=nil
end

function UIAirMiniGameMainWin:refreshExp(isInit)
if self.isInRefreshExp then
self.needRefreshExpData={isInit=isInit}
return
end

self.isInRefreshExp=true

local exp=airModel:getExp()

local nowLevel=airModel:getLevel()


if isInit then
self:clearExpData()
self.nowShowLevel=nowLevel
self.nowShowExp=0
self.nowTargetExp=0
self.lastExp=nil
end


local showLevel=self.nowShowLevel or nowLevel
self.lv:setText(FMT.fmt("{0}级",showLevel))

local deltaExp=self.lastExp and exp-self.lastExp or exp
local roleCfg=cfgHelper.get(cfg_airroleconfig_get,1)

local maxLevel=roleCfg.maxlevel
local maxExp=self.nowShowLevel<maxLevel and roleCfg.lvUpExp[self.nowShowLevel+1]or 0
if isInit then
self.lastExp=exp
self.nowTargetExp=self.nowTargetExp+deltaExp

local target=self.nowTargetExp<maxExp and self.nowTargetExp/maxExp*100 or 100
if target>100 then
target=100
end
self.progressCur=target
self.nowShowExp=self.nowTargetExp
self.isInProgressBarAnim=nil
self.widget:SetProgressBarAniWithFourParams(self.progressBar:getID(),target*100,10000,0,false)
else
if deltaExp>0 or self.nowShowExp<self.nowTargetExp then
self.lastExp=exp
self.nowTargetExp=self.nowTargetExp+deltaExp
if self.isInProgressBarAnim then

else
local target=self.nowTargetExp<maxExp and self.nowTargetExp/maxExp*100 or 100
if target>100 then
target=100
end
self.progressCur=target
self.isInProgressBarAnim=true
local cur=self.nowShowExp<maxExp and self.nowShowExp/maxExp*100 or 100
if self.nowShowLevel<maxLevel and self.nowTargetExp>=maxExp then

self.nowTargetExp=self.nowTargetExp-maxExp

self.nowShowExp=0
self.nowShowLevel=self.nowShowLevel+1
else
self.nowShowExp=self.nowTargetExp
end
self.progressBar:animateFiveParams(cur*100,target*100,10000,0.5,false)
end
end
end

self.isInRefreshExp=false
if self.needRefreshExpData then
local isNeedInit=self.needRefreshExpData.isInit
self.needRefreshExpData=nil
return self:refreshExp(isNeedInit)
end
end

function UIAirMiniGameMainWin:setSkillTimer(widget,skillid)
if self.skillTimer[skillid]then
self:stopTimerByID(self.skillTimer[skillid])
self.skillTimer[skillid]=nil
end
if not airActorSystem:hasActor()then return end
local cd=airActorSystem:getCoolDownSkill(skillid,true)

if cd>0 then
local tick=function()
if airController:isPauseGame()or
not airActorSystem:hasActor()then return end

local cd=airActorSystem:getCoolDownSkill(skillid,true)
if cd>0 then
widget:SetChildText(2,cd)
else
widget:SetChildActive(1,false)
widget:SetChildActive(3,true)
self:stopTimerByID(self.skillTimer[skillid])
self.skillTimer[skillid]=nil
end
end
self.skillTimer[skillid]=self:setTimer(0.5,0,tick)
tick()
widget:SetChildActive(1,true)
widget:SetChildActive(3,false)
end
end

function UIAirMiniGameMainWin:getMoneyLocalPosition()
local index=self.icon:getID()
local screenPos=self.winlua:GetChildUIScreenPos(index)
return self.winlua:GetChildUIScreenPos2Local(index,screenPos)
end

function UIAirMiniGameMainWin:getMoneyTransform()
return self.icon:getTransform()
end

function UIAirMiniGameMainWin:onPauseClickArea()

return UIFullAirMiniGameControl:showPauseWin()
end

function UIAirMiniGameMainWin:freshMoney()
local money=airModel:getMoney()
self.moneyNum:setText(mathHelper.formatNumber(money))
end

function UIAirMiniGameMainWin:onPause(flag)
if self.endStamp then
if flag then
self:stopCountTimer()
else
self:startCountTimer()
end
end
end

function UIAirMiniGameMainWin:onProgressAniFinish()
if self.progressCur and self.progressCur>=100 then

self:delayDo(0.1,function()
if _this==nil then
return
end


_this.progressCur=0

local showLevel=_this.nowShowLevel
_this.lv:setText(FMT.fmt("{0}级",showLevel))
local roleCfg=cfgHelper.get(cfg_airroleconfig_get,1)
local maxLevel=roleCfg.maxlevel
if showLevel<maxLevel then
_this.widget:SetProgressBarAniWithFourParams(_this.progressBar:getID(),0,10000,0,false)
end

_this.isInProgressBarAnim=nil
if showLevel>=maxLevel then

return
end

if _this.nowShowExp~=_this.nowTargetExp then
return _this:refreshExp()
end
end)
return
end

self.isInProgressBarAnim=nil

if self.nowShowExp~=self.nowTargetExp then
return self:refreshExp()
end
end


function UIAirMiniGameMainWin:testFunc(cur,time)
self.progressBar:animateFourParams(cur,100,time,false)
end