







def_class("UISubAct_xianshichouka2_result_Win",UIWindowBase)









function UISubAct_xianshichouka2_result_Win:bindComponents()

self.root=UIObject.get(self,0)
self.resultModel=UIObject.get(self,1)



end


function UISubAct_xianshichouka2_result_Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.resultModel);self.resultModel=nil;
end

















function UISubAct_xianshichouka2_result_Win:onLoaded(...)
self:bindComponents()
end


function UISubAct_xianshichouka2_result_Win:__delete()
self:unbindComponents()
end


function UISubAct_xianshichouka2_result_Win:onHide()

end




function UISubAct_xianshichouka2_result_Win:onShow(argtable,afterOnloaded)
self.resultWidget=self.resultModel:getChildWidgetBase()
self.resultModel:setActive(false)
end

function UISubAct_xianshichouka2_result_Win:playModel(animID)

AudioManager.playAudio(601)
self.resultModel:setActive(true)
self.resultWidget:SetChildSpineAnimation(0,animID,1,nil)
end

function UISubAct_xianshichouka2_result_Win:hideModel()
self.resultModel:setActive(false)
end

function UISubAct_xianshichouka2_result_Win:reloadEffect(effectID)

self.resultWidget:SetChildActive(1,false)
self.resultWidget:SetChildShowEffect(2,effectID,true)
end

function UISubAct_xianshichouka2_result_Win:playEffect(effectID)
self.resultWidget:SetChildActive(1,true)
self.resultWidget:SetChildShowEffect(2,effectID,true)
end