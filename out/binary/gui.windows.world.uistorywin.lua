







def_class("UIStoryWin",UIWindowBase)






local _this=nil
local script_action={}

function UIStoryWin:bindComponents()

self.RoleRoot=UIObject.get(self,0)
self.ButtonJump=UIButton.get(self,1)
self.Dialog=UIObject.get(self,2)
self.ImageNameBg=UIObject.get(self,3)
self.TextName=UIText.get(self,4)
self.TextDialog=UIText.get(self,5)




end


function UIStoryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.RoleRoot);self.RoleRoot=nil;
_UIObject_release(self.ButtonJump);self.ButtonJump=nil;
_UIObject_release(self.Dialog);self.Dialog=nil;
_UIObject_release(self.ImageNameBg);self.ImageNameBg=nil;
_UIObject_release(self.TextName);self.TextName=nil;
_UIObject_release(self.TextDialog);self.TextDialog=nil;
end

















function UIStoryWin:onLoaded(...)
self:bindComponents()
script_action[1]=self.RoleEnter
script_action[2]=self.RoleExit
script_action[3]=self.RoleSay
script_action[4]=self.RoleAnimation
_this=self
end


function UIStoryWin:__delete()
if self.callback then self.callback()end
if self.tween~=nil and self.tween:IsActive()then
self.tween:Kill()
self.tween=nil
end
self.script=nil
self:unbindComponents()
_this=nil
end




function UIStoryWin:onShow(argtable,afterOnloaded)
self.cfg=argtable[1]
self.callback=argtable[2]
self.roles={}
for i,v in ipairs(self.cfg.roles)do
local role=self.winlua:CreateFromRectTransformPrefab(0,0):GetComponent("CSGUIWidgetBase")
role:SetChildAnchoredPos(0,-1000,-110)
role:SetChildUIModelShowTarget(0,v[2],v[4],v[3],v[5])
role:SetChildUIModelShowFlipX(0,v[6]or false)
self.roles[i]={v[1],role}
end

if self.cfg.jump then
self.ButtonJump:setActive(true);
end

self.script=0
self.tween=nil
self:onClickNext()
end


function UIStoryWin:onHide()

end




function UIStoryWin:onClickJump()
self:closeSelf()
end

function UIStoryWin:onClickNext()

if self.tween then
if not self.tween:IsComplete()then
self.tween:Kill(true)
end
self.tween=nil
else
if self.script then
self.script=self.script+1
if self.script<=#self.cfg.scripts then
self:StartScript(self.script)
else
self:closeSelf()
end
end
end
end

function UIStoryWin:StartScript(index)
if self.preCall then
self.preCall()
self.preCall=nil
end

local scriptData=self.cfg.scripts[index]
local roleIndex=scriptData[1]
local scriptTime=scriptData[2]
local scriptType=scriptData[3]
local scriptParam=scriptData[4]
local autoNext=scriptData[5]

for i,v in pairs(self.roles)do
local owner=scriptType~=3 or i==roleIndex

local roleCmp=v[2]
local colorValue=owner and 1 or 0.5
local color=Color.New(colorValue,colorValue,colorValue,1)
roleCmp:SetChildUIModelShowColor(0,color)
end

if self.tween then
self.tween:Kill()
end

self.tween=script_action[scriptType](self,roleIndex,scriptTime,scriptParam)

self.tween:AddComplete(function()
self.tween=nil
if autoNext then
self:onClickNext()
end
end)
end

function UIStoryWin:RoleEnter(roleIndex,scriptTime,scriptParam)
local roleInfo=self.roles[roleIndex]
local roleCmp=roleInfo[2]
local side=scriptParam==0 and-1 or 1
roleCmp:SetChildAnchoredPos(0,side*1000,-110)
return Lua.DOTweenProxyExtensions.DOAnchorPosX(roleCmp.transform,side*400,scriptTime,false)
end

function UIStoryWin:RoleExit(roleIndex,scriptTime,scriptParam)
local roleInfo=self.roles[roleIndex]
local roleCmp=roleInfo[2]
local side=scriptParam==0 and-1 or 1

return Lua.DOTweenProxyExtensions.DOAnchorPosX(roleCmp.transform,side*1000,scriptTime,false)
end

function UIStoryWin:RoleSay(roleIndex,scriptTime,scriptParam)
local roleInfo=self.roles[roleIndex]
self.Dialog:setActive(true)
self.ImageNameBg:setActive(roleInfo~=nil)
self.TextName:setText(roleInfo[1])
local textCmp=self.TextDialog:getGameObject():GetComponent("Text")
local sequenceProxy=Lua.SequenceProxy.New()
sequenceProxy:Append(Lua.DOTweenProxyExtensions.DOText(textCmp,"",0))
local tweenProxy=Lua.DOTweenProxyExtensions.DOText(textCmp,scriptParam[1]or"",scriptTime)
sequenceProxy:Append(tweenProxy)
local other=scriptParam[2]or 0
if mathHelper.getBitValue(other,0)then
self.preCall=function()
self.ImageNameBg:setActive(false)
self.TextName:setText("")
self.TextDialog:setText("")
end
elseif mathHelper.getBitValue(other,1)then
self.preCall=function()
self.Dialog:setActive(false)
end
end
return sequenceProxy
end

function UIStoryWin:RoleAnimation(roleIndex,scriptTime,scriptParam)
local roleInfo=self.roles[roleIndex]
local sequenceProxy=Lua.SequenceProxy.New()
sequenceProxy:AppendCallback(function()
roleInfo[2]:setChildModelAnimationState(0,scriptParam[1])
end)
sequenceProxy:AppendInterval(scriptTime)
if scriptParam[2]then
sequenceProxy:AppendCallback(function()
roleInfo[2]:setChildModelAnimationState(0,scriptParam[2])
end)
end
return sequenceProxy
end