







def_class("UIJobLevelEffectWin",UIWindowBase)









function UIJobLevelEffectWin:bindComponents()

self.root=UIObject.get(self,0)
self.title1=UIText.get(self,1)
self.title2=UIText.get(self,2)
self.scrollview=UIObject.get(self,3)



end


function UIJobLevelEffectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
end



















function UIJobLevelEffectWin:onLoaded(...)
self:bindComponents()
self.root:setScale(Vector3.New(1,0,1))

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIJobLevelEffectWin:__delete()
self:unbindComponents()
end




function UIJobLevelEffectWin:onShow(argtable,afterOnloaded)
local titles=argtable.titles
self.title1:setText(titles[1])
self.title2:setText(titles[2])

local selectIndex=argtable.selectIndex
local datas=argtable.datas
local len=#datas
self.scrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local index=i+1
local item=grids[i]
local data=datas[index]
local isSelect=index==selectIndex
if isSelect then
item:SetChildText(0,FMT.fmt('<color=#5AE034>{0}</color>',data[1]))
item:SetChildText(1,FMT.fmt('<color=#5AE034>{0}</color>',data[2]))
else
item:SetChildText(0,data[1])
item:SetChildText(1,data[2])
end
item:SetChildActive(2,index~=len)
item:SetChildActive(3,isSelect)
end

local pos=argtable.pos
self.root:setChildAnchoredPosition(Vector2.New(pos[1],pos[2]))
self.root:setChildDOScale(1,0.35,function()
if selectIndex then
self.scrollview:setChildScrollViewSelectItem(selectIndex-1,true,false,false)
end
end)
end


function UIJobLevelEffectWin:onHide()

end




function UIJobLevelEffectWin:onCLoseClick()
self:closeSelf()
end