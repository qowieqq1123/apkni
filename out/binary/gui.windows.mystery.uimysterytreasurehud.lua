







def_class("UIMysteryTreasureHUD",UICloneObject)





UIMysteryTreasureHUD.abName="ui/windows/mystery/uimysterytreasurehud.ab"

UIMysteryTreasureHUD.assetName="UIMysteryTreasureHUD"


function UIMysteryTreasureHUD:bindComponents()

self.Root=UIObject.get(self,0)
self.logButton=UIObject.get(self,1)
self.effectgrid=UIObject.get(self,2)
self.grid=UIObject.get(self,3)

end


function UIMysteryTreasureHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.logButton);self.logButton=nil;
_UIObject_release(self.effectgrid);self.effectgrid=nil;
_UIObject_release(self.grid);self.grid=nil;
end








local dropStrong={25,50}
local dropInterval=0.25
local dropDuration=1
local dropWait=0.5

local dropBezierCurvePoints={Vector3.New(-55,-25,0),Vector3.New(0,-100,0),Vector3.New(50,0)}
local _HexMapManager=CS.HexagonMapManagerInterface

function UIMysteryTreasureHUD:onLoaded(...)
self.dropTweeners={}
self:bindComponents()

end


function UIMysteryTreasureHUD:__delete()
self.grid:setChildLayoutGroupClearAllItems()
self.effectgrid:setChildLayoutGroupClearAllItems()
if next(self.dropTweeners)then
for i,v in ipairs(self.dropTweeners)do
if v:IsActive()then
v:Kill(false)
end
end
end
self.dropTweeners={}
self:unbindComponents()

end




function UIMysteryTreasureHUD:onShow(argtable,afterOnloaded)
if not argtable then return end
local hudPos=_HexMapManager.GetCellCenterWorld(argtable.pos,argtable.layer,true)
self:setChildPosition(self.Root:getID(),Vector3.New(hudPos.x,hudPos.y+1.2,hudPos.z))

if argtable.playEffect then
self:playEffect(argtable.callback,argtable.close)
else
self:dropItem(argtable.num,argtable.rewards,argtable.callback,argtable.close)
end
end


function UIMysteryTreasureHUD:onHide()

end


function UIMysteryTreasureHUD:dropItem(num,rewards,callback,close)
self.grid:setChildLayoutGroupCreateItems(num)
self.effectgrid:setChildLayoutGroupCreateItems(num)
math.randomseed(timeHelper.getServerShortTime())

local cb=function()
if callback then
callback()
end

if close then
self:recycleSelf()
end
end

local afterFade=function(i,itemCmp)
local effectCmp=self.effectgrid:getChildLayoutGroupGridItem(i-1)
if effectCmp then
local startPos=itemCmp:GetChildGameObject(1).transform.position
local sPos=_HexMapManager.WorldToScreenPoint(startPos)
effectCmp:SetChildUIScreenPos(0,Vector2.New(sPos.x,sPos.y))
effectCmp:SetChildShowEffect(1,10076,true)

local delay=self:setTimer(0.5,1,function()
effectCmp:SetChildShowEffect(1,10077,true)
local epos=UIManager:invokeUIMethod("UIMysteryWin","getRecordCornerPos")
if not epos then
epos=self.logButton:getChildPosition()
end
effectCmp:SetChildDOJump(0,epos,math.random(-1,1),1,1.5,function()
if i==1 then
UIManager:invokeUIMethod("UIMysteryWin","playLogButtonAni")
end
effectCmp:SetChildShowEffect(1,10078,true)
if i==num then
local delay2=self:setTimer(1.5,1,cb)
end
end)
end)
end
end


for i,v in ipairs(rewards or{})do
local itemId=v.itemid
local itemCmp=self.grid:getChildLayoutGroupGridItem(i-1)
if itemCmp then
itemCmp:SetChildIcon(1,iconHelper.getIconName(itemId),false)

local sequence=Lua.SequenceProxy.New()
sequence:AppendInterval(dropInterval*(i-1))
local strong=math.random(dropStrong[1],dropStrong[2])
local t
if num==1 then
t=0.5
elseif num==2 then
if i==1 then
t=0.25
elseif i==2 then
t=0.75
end
elseif num==3 then
if i==1 then
t=0.5
elseif i==2 then
t=0.25
else
t=0.75
end
else
t=i/(num+1)
end
local point=mathHelper.getPoint_OnBezierCurvePoint(dropBezierCurvePoints,t)
local tf=CS.UIHelper.GetRectTransform(itemCmp.gameObject)
local tweenerJump=Lua.DOTweenProxyExtensions.DOLocalJump(tf,point,strong,1,dropDuration,false)
sequence:Append(tweenerJump)
sequence:AppendInterval(dropWait*(num-i))
tweenerJump:OnComplete(function()
afterFade(i,itemCmp)
end)
local tweenerFade=itemCmp:SetChildImageDOColor(1,Color.clear,0.2,nil)
sequence:Append(tweenerFade)
table.insert(self.dropTweeners,sequence)

end
end
end

function UIMysteryTreasureHUD:playEffect(callback,close)
self.effectgrid:setChildLayoutGroupCreateItems(1)
math.randomseed(timeHelper.getServerShortTime())

local cb=function()
if callback then
callback()
end

if close then
self:recycleSelf()
end
end
local roomID=mysteryRoomModel:get_cur_roomID()
local groundLayer=mysteryRoomModel:get_GroundLayer(roomID)
local effectCmp=self.effectgrid:getChildLayoutGroupGridItem(0)
if effectCmp then
local startPos=self.grid:getChildPosition()
local sPos=_HexMapManager.WorldToScreenPoint(startPos)

effectCmp:SetChildPosition(0,startPos)
effectCmp:SetChildShowEffect(1,10076,true)

local delay=self:setTimer(0.5,1,function()
effectCmp:SetChildShowEffect(1,10077,true)
local pos=mysteryPlayerModel:get_player_pos()
local epos=_HexMapManager.GetCellCenterWorld(pos,groundLayer)




effectCmp:SetChildDOJump(0,epos,math.random(-1,1),1,1.5,function()
UIManager:invokeUIMethod("UIMysteryWin","playLogButtonAni")
effectCmp:SetChildShowEffect(1,10078,true)
self:setTimer(1.5,1,cb)
end)
end)
end

end

