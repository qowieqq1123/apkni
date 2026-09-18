









local baseEntity_ball={}


function baseEntity_ball:onInit()

end


function baseEntity_ball:onCreateWidget(widget)
if self.sequence then
self.sequence:Kill()
self.sequence=nil
end
widget:SetChildCanvasGroupAlpha(-1,1)
local ball=self.data

local createCB=ball.createCB
if createCB~=nil then
ball.createCB=nil
createCB()
end

widget:SetChildAnchoredPos(-1,ball.x,ball.y)

local abname,icon=bubbleShooterModel:getBallIcon(ball.color)
widget:SetChildCSImageSprite(0,abname,icon)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildShowEffect(3,0,false)
end


function baseEntity_ball:onRemoveWidget(widget)
widget:SetChildCSImageIcon(0,'',false)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildShowEffect(3,0,false)
end

function baseEntity_ball:playMove(x,y,time)
local widget=self:getWidget()
if widget~=nil then
local tweener=widget:SetChildDOAnchorPos(-1,Vector2(x,y),time,nil)
tweener:SetEase(DG.Tweening.Ease.Linear)
end
end


function baseEntity_ball:playDead(time,deadType)
local widget=self:getWidget()
if widget~=nil then

deadType=deadType or 1
if deadType==1 then
widget:SetChildShowEffect(3,60023,true)
widget:SetChildCanvasGroupAlpha(-1,0)
else
widget:SetChildShowEffect(3,0,false)
widget:SetChildActive(1,deadType==2)
widget:SetChildActive(2,deadType==3)
widget:SetChildCanvasGroupDOFade(-1,0,time-0.5,nil)
end
end
end

function baseEntity_ball:playDead2(time)
local widget=self:getWidget()
if widget~=nil then
local rootTF=widget:GetChildGameObject(-1).transform
local pos=widget:GetChildAnchoredPosition(-1)








local sequence=Lua.SequenceProxy.New()






local moveTime=time
local startValue=0
local targetXList={-50,50}
local randomX=math.random(targetXList[1],targetXList[2])
local targetX=pos.x+randomX
local targetY1=16+pos.y
local topY=50
local k=0.25
local maxValue=moveTime*100
local tweenerMove=Lua.DOTweenProxyExtensions.DoValueTo(function()
return startValue
end,
function(val)
startValue=val
if widget==nil then return end
local moveX=pos.x+val/maxValue*randomX
local moveY=pos.y+(-topY/(k^2))*((val/maxValue)^2)+(2*topY/k)*(val/maxValue)
widget:SetChildAnchoredPos(-1,moveX,moveY)
end,maxValue,moveTime)
sequence:Append(tweenerMove)

local canvasGroup=widget:GetCommonComponent(-1,'CanvasGroup')
local tweenerFade=Lua.DOTweenProxyExtensions.DOFade(canvasGroup,0,time)
sequence:Join(tweenerFade)

self.sequence=sequence
end
end

return baseEntity_ball