







def_class("UILingZhenAttrDetailWin",UIWindowBase)









function UILingZhenAttrDetailWin:bindComponents()

self.contentRoot=UIObject.get(self,0)
self.attrCreater1=UIObject.get(self,1)
self.attrCreater2=UIObject.get(self,2)
self.questionBtn=UIButton.get(self,3)

self.questionBtn:setButtonClick(function()self:onQuestionBtn()end)



end


function UILingZhenAttrDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.contentRoot);self.contentRoot=nil;
_UIObject_release(self.attrCreater1);self.attrCreater1=nil;
_UIObject_release(self.attrCreater2);self.attrCreater2=nil;
_UIObject_release(self.questionBtn);self.questionBtn=nil;
end



















function UILingZhenAttrDetailWin:onLoaded(...)
self:bindComponents()
end


function UILingZhenAttrDetailWin:__delete()
self:unbindComponents()
end




function UILingZhenAttrDetailWin:onShow(argtable,afterOnloaded)
self.yfId=argtable.yfId
self.yfGuid=argtable.yfGuid

self:showTotalAttrList()

self.contentRoot:setChildCanvasGroupAlpha(0)
local func=function()
self.contentRoot:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.1,func)
end


function UILingZhenAttrDetailWin:onHide()

end

function UILingZhenAttrDetailWin:showTotalAttrList()
local attrDatas,diziAttrList=UIYuFuLingZhenControl:countAllAttr(self.yfId,self.yfGuid,nil,"#905335")
local list={}
for k,v in pairs(attrDatas)do
table.insert(list,{k,v})
end

local len=#list
self.attrCreater1:setChildLayoutGroupCreateItems(len)
local grids=self.attrCreater1:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local attr=list[i]

if i<=len then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
item:SetChildText(0,name)
item:SetChildText(1,str)
end
end

local dLen=#diziAttrList
self.attrCreater2:setActive(dLen>0)
self.attrCreater2:setChildLayoutGroupCreateItems(dLen)
local dGrids=self.attrCreater2:getChildLayoutGroupGridList()
local count=dGrids.Count
for i=1,count do
local item=dGrids[i-1]
local attr=diziAttrList[i]
item:SetChildText(0,attr)
end

end





function UILingZhenAttrDetailWin:onQuestionBtn()
end

