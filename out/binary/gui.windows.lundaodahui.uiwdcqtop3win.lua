







def_class("UIWDCQTop3Win",UIWindowBase)









function UIWDCQTop3Win:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.mc_1=UIObject.get(self,1)
self.mc_2=UIObject.get(self,2)
self.mc_3=UIObject.get(self,3)
self.mcList=UIObject.get(self,4)
self.Root=UIObject.get(self,5)
self.title=UIText.get(self,6)
self.uiRoot=UIObject.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.mc={
self.mc_1,
self.mc_2,
self.mc_3,
}



end


function UIWDCQTop3Win:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.mc_1);self.mc_1=nil;
_UIObject_release(self.mc_2);self.mc_2=nil;
_UIObject_release(self.mc_3);self.mc_3=nil;
_UIObject_release(self.mcList);self.mcList=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.mc=nil;
end
















local CmpMCItemIndex={
icon=0,
head=1,
server=3,
name=2,
default=4,
infoRoot=5,
loseHead=6,
}




function UIWDCQTop3Win:onLoaded(...)
self:bindComponents()
end


function UIWDCQTop3Win:__delete()
self:unbindComponents()
end




function UIWDCQTop3Win:onShow(argtable,afterOnloaded)
self.group=argtable.group


local top3RoleInfo={}
top3RoleInfo=WDCQModel:getRYBRankInfo(self.group)or{}




local createFunc=function(index)
local itemobj=self.mc[index]
local item=itemobj:getWidgetBase()

local actorId=top3RoleInfo[index]
local topRankIconInfo=WDCQModel:getRYBRankIconInfo(actorId)
if actorId then
topRankIconInfo=WDCQModel:getRYBRankIconInfo(actorId)
if not topRankIconInfo then
logErr("缺少 iconInfo ")
end
end

local isHas=actorId~=nil and topRankIconInfo~=nil
item:SetChildActive(CmpMCItemIndex.default,not isHas)
item:SetChildActive(CmpMCItemIndex.infoRoot,isHas)

if isHas then
local isLose=mathHelper.validInt64(actorId)and topRankIconInfo.actor_name==''
if not isLose then
playerController:setHeadIcon(item,CmpMCItemIndex.head,{scale=0.55,iconInfo=topRankIconInfo.iconInfo})
end
item:SetChildActive(CmpMCItemIndex.head,not isLose)
item:SetChildActive(CmpMCItemIndex.loseHead,isLose)

local serverName=loginModel:getServerName(topRankIconInfo.serverid)
local actorName=playerModel:getOtherActorName(topRankIconInfo.actor_name)
item:SetChildText(CmpMCItemIndex.server,serverName)
item:SetChildText(CmpMCItemIndex.name,actorName)
end
end

for index=1,#self.mc do
createFunc(index)
end
end


function UIWDCQTop3Win:onHide()

end





function UIWDCQTop3Win:onCloseBtn()
self:closeSelf()
end

