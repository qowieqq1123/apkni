







def_class("UITop15FightDialogueWin",UIWindowBase)









function UITop15FightDialogueWin:bindComponents()

self.UITop15FightDialogueWin=UIWindowLua.new(self,0)
self.add_value=UIObject.get(self,1)
self.arrowDown=UIObject.get(self,2)
self.arrowUp=UIObject.get(self,3)
self.effect=UIObject.get(self,4)
self.minus_value=UIObject.get(self,5)
self.old_value=UIText.get(self,6)
self.value=UIText.get(self,7)
self.add={
["value"]=self.add_value,
}
self.minus={
["value"]=self.minus_value,
}
self.old={
["value"]=self.old_value,
}



end


function UITop15FightDialogueWin:unbindComponents()
local _UIObject_release=UIObject.release
self.UITop15FightDialogueWin:deleteSelf();self.UITop15FightDialogueWin=nil;
_UIObject_release(self.add_value);self.add_value=nil;
_UIObject_release(self.arrowDown);self.arrowDown=nil;
_UIObject_release(self.arrowUp);self.arrowUp=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.minus_value);self.minus_value=nil;
_UIObject_release(self.old_value);self.old_value=nil;
_UIObject_release(self.value);self.value=nil;
self.add=nil;
self.minus=nil;
self.old=nil;
end


















function UITop15FightDialogueWin:onLoaded(...)
self:bindComponents()
self.array={}
self.lock=false
self.add=nil
end

function UITop15FightDialogueWin:__delete()
self:unbindComponents()
end

function UITop15FightDialogueWin:onShow(argtable,afterOnloaded)
if self.lock then return end

local oldVal,newVal=fightUpRemindModel:getZongmenTop15FightVal(true)
local array={{oldVal=oldVal,newVal=newVal}}
self:enqueArray(array)
self:start()
end

function UITop15FightDialogueWin:onHide()
self.lock=false
end

function UITop15FightDialogueWin:addArray(argtable)
if argtable==nil or#argtable==0 then return end
self:enqueArray(argtable)
self:start()
end


function UITop15FightDialogueWin:playAnimator(stateId)
self.UITop15FightDialogueWin:setAnimatorInteger('nStateID',stateId,true)
end

function UITop15FightDialogueWin:refreshNumber()
if self.add~=nil then
local fightInfo=self.fightInfo
local oldVal=fightInfo.oldVal
local newVal=fightInfo.newVal
local val=math.abs(newVal-oldVal)
local cmp=self.add==true and self.add_value or self.minus_value
cmp:setText(val)
end
end

function UITop15FightDialogueWin:onFinish()

self:startNext()
end

function UITop15FightDialogueWin:start()
if self.lock then return end
local fightInfo=self:deque()
self.lock=true
if fightInfo==nil then
self:closeSelf()
return
end
self.fightInfo=fightInfo
local oldVal=fightInfo.oldVal
local newVal=fightInfo.newVal
if oldVal==nil or newVal==nil or oldVal==newVal then
self:startNext()
return
end
local add=oldVal<newVal
self.add=add
local changeVal=math.abs(newVal-oldVal)
local stateId=add and 1 or 2
self.value:setText(changeVal)
self.old_value:setText(oldVal)
self.arrowUp:setActive(add)
self.arrowDown:setActive(not add)
self:playAnimator(stateId)
end

function UITop15FightDialogueWin:startNext()

self.lock=false
self:start()
end

function UITop15FightDialogueWin:enqueArray(fightInfoArray)
if fightInfoArray==nil or#fightInfoArray==0 then return end
local array=self.array
for _,v in ipairs(fightInfoArray)do
array[#array+1]=v
end
end

function UITop15FightDialogueWin:deque()
if self.array==nil or#self.array==0 then return end
return table.remove(self.array,1)
end
