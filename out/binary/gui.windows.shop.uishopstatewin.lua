







def_class("UIShopStateWin",UIWindowBase)









function UIShopStateWin:bindComponents()

self.root=UIObject.get(self,0)
self.scrollview=UIObject.get(self,1)
self.pval1=UIText.get(self,2)



end


function UIShopStateWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.pval1);self.pval1=nil;
end



















function UIShopStateWin:onLoaded(...)
self:bindComponents()

self.root:setScale(Vector3.New(1,0,1))

self.edes1={'收益'}
self.edes2={'弟子特质：','专业技能：','宗门状态：','宗门古宝：','加成建筑：','事件影响：','庶务弟子：','仙居图录：'}

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIShopStateWin:__delete()
self:unbindComponents()

UIManager:invokeUIMethod('UIShopWin','setStateButton',false)
end

function UIShopStateWin:getValueText(val,br)
val=val or 0
local isAdd=val>0
if br then
isAdd=val<0
end
local color=isAdd and'#76d81e'or'#c82c2c'
if val>0 then
return FMT.fmt('<color={1}>+{0}%</color>',val,color)
elseif val<0 then
return FMT.fmt('<color={1}>{0}%</color>',val,color)
else
return'无影响'
end
end

function UIShopStateWin:getEffectText(data)
local str=''
for k,v in pairs(data)do
local isAdd=v>0
local cv=isAdd
local color=cv and'#76d81e'or'#c82c2c'
local sign=isAdd and'+'or''
local des=self.edes1[k]
str=FMT.fmt('{0}{1} ',str,FMT.fmt('<color={1}>{0}{2}{3}%</color>',des,color,sign,v))
end
return str
end




function UIShopStateWin:onShow(argtable,afterOnloaded)
self.bdData=argtable
local edatas=zongmenModel:getShopEffect(self.bdData)
local tdatas=zongmenModel:getMergeShopEffect(edatas)
self.pval1:setText(self:getValueText(tdatas[1]))

self.scrollview:setChildScrollViewCreateGrids(#edatas,1)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=edatas[i]
item:SetChildText(0,self.edes2[data.type])
item:SetChildText(1,self:getEffectText(data.data))
end

self.root:setChildDOScaleY(1,0.35,nil)
end


function UIShopStateWin:onHide()

end




function UIShopStateWin:onCloseClick()
self:closeSelf()
end