







def_class("UISubAct_CrossRankingServerListWin",UIWindowBase)









function UISubAct_CrossRankingServerListWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.serverListContent=UIObject.get(self,1)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_CrossRankingServerListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.serverListContent);self.serverListContent=nil;
end



















function UISubAct_CrossRankingServerListWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_CrossRankingServerListWin:__delete()
self:unbindComponents()
end




function UISubAct_CrossRankingServerListWin:onShow(argtable,afterOnloaded)
local serverList=argtable or defaultT
self.serverListContent:setChildLayoutGroupCreateItems(#serverList,function(index)
local item=self.serverListContent:getChildLayoutGroupGridItem(index-1)
local cross_id=serverList[index]
local name=loginModel:getCrossZoneName(cross_id)
local isSelfCross=cross_id==loginModel:getCrossServerId()
item:SetChildActive(0,isSelfCross)
item:SetChildText(1,name)
end)
end


function UISubAct_CrossRankingServerListWin:onCloseBtn()
self:closeSelf()
end

