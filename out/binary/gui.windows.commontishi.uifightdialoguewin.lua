







def_class("UIFightDialogueWin",UIWindowBase)









function UIFightDialogueWin:bindComponents()

self.UIFightDialogueWin=UIWindowLua.new(self,0)
self.add_value=UIObject.get(self,1)
self.arrowDown=UIObject.get(self,2)
self.arrowUp=UIObject.get(self,3)
self.effect=UIObject.get(self,4)
self.minus_value=UIObject.get(self,5)
self.old_value=UIText.get(self,6)
self.val_type=UIObject.get(self,7)
self.value=UIText.get(self,8)
self.add={
["value"]=self.add_value,
}
self.minus={
["value"]=self.minus_value,
}
self.old={
["value"]=self.old_value,
}
self.val={
["type"]=self.val_type,
}


self.sprite_image_shuwushili_1=0
self.sprite_image_zhanliwz_1=1
self.sprite_image_fanrongdu_1=2
self.sprite_image_zuiqiangwurenmsz_1=3

end


function UIFightDialogueWin:unbindComponents()
local _UIObject_release=UIObject.release
self.UIFightDialogueWin:deleteSelf();self.UIFightDialogueWin=nil;
_UIObject_release(self.add_value);self.add_value=nil;
_UIObject_release(self.arrowDown);self.arrowDown=nil;
_UIObject_release(self.arrowUp);self.arrowUp=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.minus_value);self.minus_value=nil;
_UIObject_release(self.old_value);self.old_value=nil;
_UIObject_release(self.val_type);self.val_type=nil;
_UIObject_release(self.value);self.value=nil;
self.add=nil;
self.minus=nil;
self.old=nil;
self.val=nil;
end


















function UIFightDialogueWin:onLoaded(...)
self:bindComponents()
self.array={}
self.lock=false
self.add=nil
end

function UIFightDialogueWin:__delete()
self:unbindComponents()
end

function UIFightDialogueWin:onShow(argtable,afterOnloaded)
if self.lock then return end

self.val_type:setImageSprite(self.sprite_image_zhanliwz_1,true)
local array=fightUpRemindModel:getCurrentFightList(true)
self:enqueArray(array)
self:start()
end

function UIFightDialogueWin:onHide()
self.lock=false
end

function UIFightDialogueWin:addArray(argtable)
if argtable==nil or#argtable==0 then return end
self:enqueArray(argtable)
self:start()
end


function UIFightDialogueWin:playAnimator(stateId)
self.UIFightDialogueWin:setAnimatorInteger('nStateID',stateId,true)
end

function UIFightDialogueWin:refreshNumber()
if self.add~=nil then
local fightInfo=self.fightInfo
local oldVal=fightInfo.oldVal
local newVal=fightInfo.newVal
local val=math.abs(newVal-oldVal)
local cmp=self.add==true and self.add_value or self.minus_value
cmp:setText(val)
end
end

function UIFightDialogueWin:onFinish()

self:startNext()
end

function UIFightDialogueWin:start()
if self.lock then return end
local fightInfo=self:deque()
self.lock=true
if fightInfo==nil then
local array=fightUpRemindModel:getCurrentFightList(true)
self:enqueArray(array)
fightInfo=self:deque()
if fightInfo==nil then
self:closeSelf()
return
end
end
self.fightInfo=fightInfo
local oldVal=fightInfo.oldVal
local newVal=fightInfo.newVal
if oldVal==nil or newVal==nil or oldVal==newVal then
self:startNext()
return
end
self.val_type:setImageSprite(self:getIconIndex(fightInfo.source),true)
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

function UIFightDialogueWin:getIconIndex(source)
if source==1 then
return self.sprite_image_shuwushili_1
end

if source==2 then
return self.sprite_image_fanrongdu_1
end

if source==3 then
return self.sprite_image_zuiqiangwurenmsz_1
end

return self.sprite_image_zhanliwz_1
end

function UIFightDialogueWin:startNext()

self.lock=false
self:start()
end

function UIFightDialogueWin:enqueArray(fightInfoArray)
if fightInfoArray==nil or#fightInfoArray==0 then return end
local array=self.array
for _,v in ipairs(fightInfoArray)do
array[#array+1]=v
end
end

function UIFightDialogueWin:deque()
if self.array==nil or#self.array==0 then return end
return table.remove(self.array,1)
end
