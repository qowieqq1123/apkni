







def_class("UIYSFDZInfoTips",UIWindowBase)









function UIYSFDZInfoTips:bindComponents()

self.itemGreator=UIObject.get(self,0)
self.titleTxt1=UIText.get(self,1)
self.titleTxt2=UIText.get(self,2)
self.root=UIObject.get(self,3)



end


function UIYSFDZInfoTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemGreator);self.itemGreator=nil;
_UIObject_release(self.titleTxt1);self.titleTxt1=nil;
_UIObject_release(self.titleTxt2);self.titleTxt2=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this



function UIYSFDZInfoTips:onLoaded(...)
self:bindComponents()
_this=self
end


function UIYSFDZInfoTips:__delete()
self:unbindComponents()

if self.moveXTween then
for i,v in pairs(self.moveXTween)do
v:Kill(false)
end
end

if self.callback then
self.callback()
end

_this=nil
end




function UIYSFDZInfoTips:onShow(argtable,afterOnloaded)
local title=argtable.title
local info=argtable.info
local proLevel=argtable.level
self.callback=argtable.callback


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
self.root:setChildLocalPosition(Vector3.New(self.pos.x,self.pos.y,0))

self.titleTxt1:setText(title[1])
self.titleTxt2:setText(title[2])

local list={}
for k,v in pairs(info)do
table.insert(list,{level=k,value=v})
end
table.sort(list,function(a,b)return a.level<b.level end)

local curIdx=0
for i,v in ipairs(list)do
if proLevel>=v.level then
curIdx=i
end
end

self.itemGreator:setChildLayoutGroupCreateItems(#list)
self.moveXTween={}
local itemGrid=self.itemGreator:getChildLayoutGroupGridList()
for i=1,#list do
local item=itemGrid[i-1]
local info=list[i]
local colorStr='#8e8c87'
if curIdx and curIdx==i then
colorStr='#efb150'
end
local descStr1=FMT.fmt('<color={0}>{1}</color>',colorStr,info.level)
local descStr2=FMT.fmt('<color={0}>{1}</color>',colorStr,info.value)
item:SetChildText(0,descStr1)
item:SetChildText(1,descStr2)
if curIdx and curIdx==i then
item:SetChildActive(2,true)
item:SetChildActive(3,false)
else
item:SetChildActive(2,false)
item:SetChildActive(3,true)
end





end
end


function UIYSFDZInfoTips:onHide()

end

