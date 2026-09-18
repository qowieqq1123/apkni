







def_class("UIConditionTipsFour",UIWindowBase)









function UIConditionTipsFour:bindComponents()

self.rightRoot=UIObject.get(self,0)
self.leftRoot=UIObject.get(self,1)
self.leftTopRoot=UIObject.get(self,2)
self.rightTopRoot=UIObject.get(self,3)



end


function UIConditionTipsFour:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.leftTopRoot);self.leftTopRoot=nil;
_UIObject_release(self.rightTopRoot);self.rightTopRoot=nil;
end

























function UIConditionTipsFour:onLoaded(...)
self:bindComponents()
end


function UIConditionTipsFour:__delete()
self:unbindComponents()
local cb=self.callback
if cb then
cb()
end
end


function UIConditionTipsFour:onHide()

end
















function UIConditionTipsFour:onShow(argtable,afterOnloaded)
self.showType=argtable.showType or 1
self.callback=argtable.callback
self.name=argtable.name
self.len=argtable.num
self.extraStrList=argtable.extraStrList
self.extraLast=argtable.extraLast

local pos=nil
if argtable.posItem then
pos=argtable.posItem:getChildScreenPointToLocalPointRectangle()
elseif argtable.posWidget then
local posWidgetIndex=argtable.posWidgetIndex or-1
pos=argtable.posWidget:GetChildScreenPointToLocalPointRectangle(posWidgetIndex)
end
if pos then
local p=argtable.pos or{x=0,y=0}
pos.x=pos.x+p.x
pos.y=pos.y+p.y
else
pos=argtable.pos or Vector2.zero
end




self.pos=pos
self:updateView()
end

function UIConditionTipsFour:updateView()
self.rightRoot:setActive(self.showType==1)
self.leftRoot:setActive(self.showType==2)
self.leftTopRoot:setActive(self.showType==3)
self.rightTopRoot:setActive(self.showType==4)
self.root=self.showType==1 and self.rightRoot or
self.showType==2 and self.leftRoot or
self.showType==3 and self.leftTopRoot or
self.rightTopRoot

self.desclist={}
local num=self.len or 10
local name=self.name
if name then
for i=1,num do
local str=cfgHelper.get1(cfg_lang_get,string.format(name,i))
if str~=nil then
table.insert(self.desclist,str)
end
end
end

if self.extraStrList then
local extraLast=self.extraLast
for i,v in ipairs(self.extraStrList)do
if extraLast then
table.insert(self.desclist,v)
else
table.insert(self.desclist,1,v)
end
end
end

self:refreshDesc()

local widget=self.root:getChildWidgetBase()
self.root:setChildLocalPosition(Vector3.New(self.pos.x,self.pos.y,0))
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.1,nil)
self.root:setScale(Vector3.New(0,0,0))
local t1=self.root:setChildDOScale(1,0.2,nil)

end

function UIConditionTipsFour:refreshDesc()
if self.desclist==nil then return end
local c=#self.desclist
if c<=0 then return end
self.root:setChildLayoutGroupCreateItems(c)
local gridlist=self.root:getChildLayoutGroupGridList()
for i=1,c do
local item=gridlist[i-1]
item:SetChildText(0,self.desclist[i])
end
end