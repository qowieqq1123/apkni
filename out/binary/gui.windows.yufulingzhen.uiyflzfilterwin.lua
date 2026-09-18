







def_class("UIYFLZFilterWin",UIWindowBase)









function UIYFLZFilterWin:bindComponents()

self.levelScrollView=UIObject.get(self,0)
self.typeScrollView=UIObject.get(self,1)
self.setAllBtnA=UIButton.get(self,2)
self.setAllBtnB=UIButton.get(self,3)
self.resetBtn=UIButton.get(self,4)
self.applyBtn=UIButton.get(self,5)

self.setAllBtnA:setButtonClick(function()self:onSetAllBtnA()end)

self.setAllBtnB:setButtonClick(function()self:onSetAllBtnB()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)



end


function UIYFLZFilterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.levelScrollView);self.levelScrollView=nil;
_UIObject_release(self.typeScrollView);self.typeScrollView=nil;
_UIObject_release(self.setAllBtnA);self.setAllBtnA=nil;
_UIObject_release(self.setAllBtnB);self.setAllBtnB=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.applyBtn);self.applyBtn=nil;
end



















function UIYFLZFilterWin:onLoaded(...)
self:bindComponents()
local cfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"openLevel")
self.maxLevel=cfg or 15
self.levelDatas={}
for i=1,self.maxLevel do
self.levelDatas[i]=i
end
self.typeDatas={'金','木','水','火','土','五行'}


self.typeSelect={}



self.levelScrollView:setChildScrollViewInit(0.5,true,function(...)self:onLevelSelect(...)end,nil)
self.typeScrollView:setChildScrollViewInit(0.5,true,function(...)self:onTypeSelect(...)end,nil)
end

function UIYFLZFilterWin:onLevelSelect(num,index)
if self.levelDatas[index+1]then


if self.levelSelect then
self:setSelect(self.levelScrollView,self.levelSelect-1,false)
end
self.levelSelect=index+1
self:setSelect(self.levelScrollView,index,true)

else
if self.levelSelect then
self:setSelect(self.levelScrollView,self.levelSelect-1,false)
end
self.levelSelect=index+1
self:setSelect(self.levelScrollView,index,true)

end
end

function UIYFLZFilterWin:onTypeSelect(num,index)
local check=not self.typeSelect[index]
self.typeSelect[index]=check
self:setSelect(self.typeScrollView,index,check)
end

function UIYFLZFilterWin:setSelect(scrollView,index,check)
local item=scrollView:getChildScrollViewItemWidget(index)
if item then
item:SetChildActive(0,check)
end
end


function UIYFLZFilterWin:__delete()
self:unbindComponents()
end




function UIYFLZFilterWin:onShow(argtable,afterOnloaded)
if argtable then
self.selectCall=argtable.selectCall
self.allText=argtable.allText
self.hideAll=argtable.hideAll or false

self.resetBtn:setActive(self.hideAll)
end
self:setLevelFilter(argtable)
self:setTypeFilter()
end


function UIYFLZFilterWin:onHide()

end

function UIYFLZFilterWin:setLevelFilter(argtable)
local len=#self.levelDatas
if not self.hideAll then
len=len+1
end
if argtable and argtable.levelSelect~=nil then
self.levelSelect=argtable.levelSelect
else
if not self.hideAll then
self.levelSelect=len
end
end
self.levelScrollView:setChildScrollViewCreateGrids(len,5)
local grids=self.levelScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]

item:SetChildActive(0,i==self.levelSelect)
if not self.hideAll then
if i==count then
item:SetChildText(1,self.allText or'全部')
else
local level=self.levelDatas[i]
item:SetChildText(1,level..'级')
end
else
local level=self.levelDatas[i]
if i>1 then
item:SetChildText(1,level..'级及以下')
else
item:SetChildText(1,level..'级')
end

end

end
end

function UIYFLZFilterWin:setTypeFilter()
local len=#self.typeDatas
self.typeScrollView:setChildScrollViewCreateGrids(len,5)
local grids=self.typeScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local tname=self.typeDatas[i]
item:SetChildActive(0,false)
item:SetChildText(1,tname)
end
end



function UIYFLZFilterWin:onSetAllBtnA()





end

function UIYFLZFilterWin:onSetAllBtnB()
for i,v in ipairs(self.typeDatas)do
local index=i-1
self.typeSelect[i]=true
self:setSelect(self.typeScrollView,index,true)
end
end

function UIYFLZFilterWin:onResetBtn()











if self.selectCall then
self.selectCall({},-1)
end
self:onCloseClick()
end

function UIYFLZFilterWin:onApplyBtn()
local select={}
if self.levelDatas[self.levelSelect]then
select[self.levelSelect]=true
else
select=nil
end
if self.selectCall then
self.selectCall(select,self.levelSelect)
end
self:onCloseClick()
end

function UIYFLZFilterWin:onCloseClick()
self:closeSelf()
end