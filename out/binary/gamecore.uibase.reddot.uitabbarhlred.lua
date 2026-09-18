

UITabBarHLRed=simple_class(UITabBarHL)

function UITabBarHLRed:initToggles()
self.toggles_select_img={}
self.toggles_nor_img={}
self.togglesObj={}
self.redObj={}

otherHelper.invokeFuncOnEveryData(self.toggles,function(index,handle_toggle)
self.toggles_select_img[index]=EngineTools.FindGameObject(handle_toggle,'SelectBg')
self.toggles_nor_img[index]=EngineTools.FindGameObject(handle_toggle,'NorBg')
self.togglesObj[index]=handle_toggle.gameObject
self.redObj[index]=EngineTools.FindGameObject(handle_toggle,'RedPoint')
end)
end

function UITabBarHLRed:__delete()
self:UnRegistRed()
if self.RedEventDotList~=nil then
for k,v in pairs(self.RedEventDotList)do
v:OnDestroy()
end
end
self.RedEventDotList=nil

self.toggles_select_img=nil
self.toggles_nor_img=nil
self.togglesObj=nil
self.redObj=nil
end


function UITabBarHLRed:RegistRed(Index,EventKeyName,noShowNum)
if self.redObj[Index]==nil then return end

if self.RedEventDotList==nil then
self.RedEventDotList={}
end

if self.RedEventDotList[Index]==nil then
self.RedEventDotList[Index]=UIRedItem(self.redObj[Index],EventKeyName,noShowNum)
end
end

function UITabBarHLRed:UnRegistRed()
if self.RedEventDotList~=nil then
for k,v in pairs(self.RedEventDotList)do
v:RemoveListener()
end
end
end

function UITabBarHLRed:SetTogglesVisibleLogic(func)
self.func=func
end

function UITabBarHLRed:SetTogglesVisible(uiname,pos)
if self.func==nil then
self._base.SetTogglesVisible(self,uiname,pos)
return
end
self.func(uiname,pos)
end
