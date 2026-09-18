







def_class("UISubAct_CangBaoTuSOSTips",UIWindowBase)









function UISubAct_CangBaoTuSOSTips:bindComponents()

self.background=UIButton.get(self,0)
self.haveNum=UIText.get(self,1)
self.haveIcon=UIImage.get(self,2)
self.haveRoot=UIObject.get(self,3)
self.closeBtn=UIButton.get(self,4)
self.model=UIObject.get(self,5)
self.content=UIText.get(self,6)
self.item=UIBaseItem.get(self,7)
self.shareBtn=UIButton.get(self,8)
self.cancelBtn=UIButton.get(self,9)
self.actorName=UIText.get(self,10)
self.tips=UIText.get(self,11)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.shareBtn:setButtonClick(function()self:onShareBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UISubAct_CangBaoTuSOSTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.haveNum);self.haveNum=nil;
_UIObject_release(self.haveIcon);self.haveIcon=nil;
_UIObject_release(self.haveRoot);self.haveRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.shareBtn);self.shareBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.actorName);self.actorName=nil;
_UIObject_release(self.tips);self.tips=nil;
end



















function UISubAct_CangBaoTuSOSTips:onLoaded(...)
self:bindComponents()
end


function UISubAct_CangBaoTuSOSTips:__delete()
self:unbindComponents()
end




function UISubAct_CangBaoTuSOSTips:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.actorId=argtable.actorId
self.itemId=argtable.itemId
self.infoGuid=argtable.infoGuid

self.serverId=argtable.serverId
self.config=activitiesModel:getSubActivityConfig(argtable.subType,argtable.subId)

local str=FMT.fmt("帮帮我，我需要{0}解锁藏宝图碎块",itemsConfig.getColorName(argtable.itemId))
self.content:setText(str)

local imageInfo=UIDiscipleModel.calculationDiscipleImage(argtable.dzData,argtable.dzImage)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
self.model:setChildUIModelShowTarget(modelParams.body,1.5,modelParams.componets,self.config.disciple[2][1],false,false,0)
self.model:setChildUIModelShowFlipX(true)
if spineHelper.enableChangeFace(modelParams.body)then
self.winlua:SetChildChangeSlotDisplay(self.model:getID(),"face","face",self.config.disciple[2][2])
end

local conf={itemid=argtable.itemId,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.item:setChildPropData(prop)
self.item:setBaseItemClickEvent(function(...)
itemsComponentHelper.onItemClickEx(...)
end)

local count=itemsModel.getCount(self.itemId)
self.haveNum:setText(FMT.fmt("剩余:{0}",count))
self.haveIcon:setImageIcon(iconHelper.getIconName(self.itemId),false)
self.winlua:ForceLayoutRect(self.haveRoot:getID())
self.actorName:setText(argtable.actorName)

local info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)

self.done=info:getMarkChat(self.actorId,self.infoGuid)
self.shareBtn:setChildGraphicGray(self.done)




end


function UISubAct_CangBaoTuSOSTips:onHide()

end





function UISubAct_CangBaoTuSOSTips:onCloseBtn()
self:closeSelf()
end



function UISubAct_CangBaoTuSOSTips:onShareBtn()
if self.done then return UIManager.info("无法分享给对方")end
local info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
if info and info:checkDoing()then
local count=itemsModel.getCount(self.itemId)
if count>0 then
call_activitiesHandle_func('activitiesHandle_cangbaotu','reqShareItem',self.actId,self.subId,self.actorId,self.itemId,self.infoGuid)
info:setMarkChat(self.actorId,self.infoGuid)
self:closeSelf()
else
UIManager.error(FMT.fmt("{0}不足，无法赠与",itemsConfig.getItemName(self.itemId)))
end
else
UIManager.info("活动已结束")
end
end



function UISubAct_CangBaoTuSOSTips:onCancelBtn()
self:closeSelf()
end

function UISubAct_CangBaoTuSOSTips:onBackground()
self:closeSelf()
end
