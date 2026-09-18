







def_class("UIBuildingDiscountInfoTips",UIWindowBase)









function UIBuildingDiscountInfoTips:bindComponents()

self.itemGreator=UIObject.get(self,0)
self.titleTxt1=UIText.get(self,1)
self.titleTxt2=UIText.get(self,2)



end


function UIBuildingDiscountInfoTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.itemGreator);self.itemGreator=nil;
_UIObject_release(self.titleTxt1);self.titleTxt1=nil;
_UIObject_release(self.titleTxt2);self.titleTxt2=nil;
end



















function UIBuildingDiscountInfoTips:onLoaded(...)
self:bindComponents()
end


function UIBuildingDiscountInfoTips:__delete()
self:unbindComponents()

if self.moveXTween then
for i,v in pairs(self.moveXTween)do
v:Kill(false)
end
end

if self.callback then
self.callback()
end
end




function UIBuildingDiscountInfoTips:onShow(argtable,afterOnloaded)
local title=argtable.title
local info=argtable.info
local proLevel=argtable.level
self.callback=argtable.callback

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
local colorStr='#CACACA'
if curIdx and curIdx==i then
colorStr='#76d81e'
end
local descStr1=FMT.fmt('<color={0}>{1}</color>',colorStr,info.level)
local descStr2=FMT.fmt('<color={0}>{1}</color>',colorStr,info.value)
item:SetChildText(0,descStr1)
item:SetChildText(1,descStr2)
item:SetChildActive(2,curIdx and curIdx==i)
if curIdx==i then
self.moveXTween[i]=item:SetChildDOLocalMoveX(2,-130,1.2,nil)
self.moveXTween[i]:SetEase(_Ease.Linear)
self.moveXTween[i]:SetLoops(-1,_LoopType.Yoyo)
end
end
end


function UIBuildingDiscountInfoTips:onHide()

end



