







def_class("UIChatDefineEmotEditorPanel",UIWindowBase)









function UIChatDefineEmotEditorPanel:bindComponents()

self.creater=UIGameobjectClone.new(self,0)
self.Content=UIObject.get(self,1)



end


function UIChatDefineEmotEditorPanel:unbindComponents()
local _UIObject_release=UIObject.release
self.creater:deleteSelf();self.creater=nil;
_UIObject_release(self.Content);self.Content=nil;
end


















function UIChatDefineEmotEditorPanel:onLoaded(...)
self:bindComponents()
end

function UIChatDefineEmotEditorPanel:__delete()
self:unbindComponents()
end

function UIChatDefineEmotEditorPanel:onShow(argtable,afterOnloaded)
local configs=chatConfig.getDefineEmotConfig()
local temp={}
for i,v in ipairs(configs)do
local singleInfo={}
singleInfo.name='UIChatDefineEditorChildItem'
singleInfo.parentIdx=self.Content:getID()
singleInfo.order=i
singleInfo.args=v
temp[#temp+1]=singleInfo
end
self.creater:createObjectList(temp)
end

function UIChatDefineEmotEditorPanel:onHide()

end



