







def_class("UILingZhenLevelAttrDetailWin",UIWindowBase)









function UILingZhenLevelAttrDetailWin:bindComponents()

self.questionBtn=UIButton.get(self,0)
self.attrCreater_1=UIObject.get(self,1)
self.attrCreater_2=UIObject.get(self,2)
self.contentRoot=UIObject.get(self,3)
self.attrCreater_3=UIObject.get(self,4)
self.attrCreater_4=UIObject.get(self,5)

self.questionBtn:setButtonClick(function()self:onQuestionBtn()end)
self.attrCreater={
self.attrCreater_1,
self.attrCreater_2,
self.attrCreater_3,
self.attrCreater_4,
}



end


function UILingZhenLevelAttrDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.questionBtn);self.questionBtn=nil;
_UIObject_release(self.attrCreater_1);self.attrCreater_1=nil;
_UIObject_release(self.attrCreater_2);self.attrCreater_2=nil;
_UIObject_release(self.contentRoot);self.contentRoot=nil;
_UIObject_release(self.attrCreater_3);self.attrCreater_3=nil;
_UIObject_release(self.attrCreater_4);self.attrCreater_4=nil;
self.attrCreater=nil;
end



















function UILingZhenLevelAttrDetailWin:onLoaded(...)
self:bindComponents()
end


function UILingZhenLevelAttrDetailWin:__delete()
self:unbindComponents()
end




function UILingZhenLevelAttrDetailWin:onShow(argtable,afterOnloaded)

self.contentRoot:setChildCanvasGroupAlpha(0)
local func=function()
self.contentRoot:setChildCanvasGroupDOFade(1,0.2,nil)
end
self:delayDo(0.1,func)

local cfg=cfg_yufuzhenturandattrconfig()
local list={}
for i,v in ipairs(cfg)do
list[v.xcLevel]=list[v.xcLevel]or{}
table.insert(list[v.xcLevel],UIYuFuLingZhenControl:getDzAttrDesc(v,"#905335"))
end
local index=1
for i,v in pairs(list)do
local len=#v
self.attrCreater[index]:setChildLayoutGroupCreateItems(len)
local grids=self.attrCreater[index]:getChildLayoutGroupGridList()
local count=grids.Count
for ii=1,count do
local item=grids[ii-1]
item:SetChildText(0,v[ii])
end
index=index+1
end
end


function UILingZhenLevelAttrDetailWin:onHide()

end





function UILingZhenLevelAttrDetailWin:onQuestionBtn()
end

