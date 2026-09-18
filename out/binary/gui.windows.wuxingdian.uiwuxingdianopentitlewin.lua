







def_class("UIWuXingDianOpenTitleWin",UIWindowBase)









function UIWuXingDianOpenTitleWin:bindComponents()

self.model=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.title=UIImage.get(self,2)



end


function UIWuXingDianOpenTitleWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
end

















local _modelList={4874,4875,4876,4877,4878}

function UIWuXingDianOpenTitleWin:onLoaded(...)
self:bindComponents()
end

function UIWuXingDianOpenTitleWin:__delete()
self:unbindComponents()
end

function UIWuXingDianOpenTitleWin:onShow(argtable,afterOnloaded)
local list=argtable
self.list=list
self:playNext()
end

function UIWuXingDianOpenTitleWin:playNext()
local index=self.index or 0
index=index+1
local wxdId=self.list[index]
if wxdId==nil then
self:closeSelf()
return
end
self.index=index
wuXingDianModel:setOpenTitle(wxdId)
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
self:stopAllTimer()
self:delayDo(0.5,function()
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.5)
end)
self.title:setSprite(globalABLookup.wxdtitlesprite,FMT.fmt('image_yuansumenkqcc_{0}',wxdId))
self.model:setChildUIModelShowTarget(_modelList[wxdId],1,{},0)
end

function UIWuXingDianOpenTitleWin:onHide()

end



