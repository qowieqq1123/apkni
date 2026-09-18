







def_class("UISystemZongMenRelationDialog",UIWindowBase)









function UISystemZongMenRelationDialog:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.descList=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISystemZongMenRelationDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descList);self.descList=nil;
end















local _this=nil
local _descCmp={
list=-1,
icon=0,
name=1,
line=2,
}



function UISystemZongMenRelationDialog:onLoaded(...)
self:bindComponents()
_this=self
end


function UISystemZongMenRelationDialog:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenRelationDialog:onShow(argtable,afterOnloaded)
local config=cfg_syssectrelationconfig()
local count=#config
self.descList:setChildLayoutGroupCreateItems(count,function(index)
local descItem=self.descList:getChildLayoutGroupGridItem(index-1)
local cfg=config[index]
descItem:SetChildCSImageSprite(_descCmp.icon,cfg.icon[1],cfg.icon[2])
descItem:SetChildText(_descCmp.name,cfg.name)
descItem:SetChildActive(_descCmp.line,index<count)
descItem:SetChildLayoutGroupCreateItems(_descCmp.list,#cfg.desc,function(idx)
local item=descItem:GetChildLayoutGroupGridItem(_descCmp.list,idx-1)
local descStr=cfg.desc[idx]
item:SetChildText(-1,descStr)
end)
end)
self.winlua:ForceLayoutRect(self.descList:getID())
end


function UISystemZongMenRelationDialog:onHide()

end





function UISystemZongMenRelationDialog:onCloseBtn()
UIFullSystemZongMenControl:closeWindow("UISystemZongMenRelationDialog")
end

function UISystemZongMenRelationDialog:onBackground()
UIFullSystemZongMenControl:closeWindow("UISystemZongMenRelationDialog")
end