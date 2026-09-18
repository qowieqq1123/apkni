







def_class("UISubAct_CangBaoTuSharedTips",UIWindowBase)









function UISubAct_CangBaoTuSharedTips:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.model=UIObject.get(self,2)
self.content=UIText.get(self,3)
self.item=UIBaseItem.get(self,4)
self.jumpBtn=UIButton.get(self,5)
self.cancelBtn=UIButton.get(self,6)
self.actorName=UIText.get(self,7)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)



end


function UISubAct_CangBaoTuSharedTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.item);self.item=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.actorName);self.actorName=nil;
end



















function UISubAct_CangBaoTuSharedTips:onLoaded(...)
self:bindComponents()
end


function UISubAct_CangBaoTuSharedTips:__delete()
self:unbindComponents()
end




function UISubAct_CangBaoTuSharedTips:onShow(argtable,afterOnloaded)
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.actorId=argtable.actorId
self.itemId=argtable.itemId
self.config=activitiesModel:getSubActivityConfig(argtable.subType,argtable.subId)


local str=FMT.fmt("请祖师查收，<color=#549327>{0}</color>分享了{1}给祖师{1}可用于解锁藏宝图碎块",argtable.actorName,itemsConfig.getColorName(argtable.itemId))

self.content:setText(str)

local imageInfo=UIDiscipleModel.calculationDiscipleImage(argtable.dzData,argtable.dzImage)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo)
self.model:setChildUIModelShowTarget(modelParams.body,1.5,modelParams.componets,self.config.disciple[1][1],false,false,0)
self.model:setChildUIModelShowFlipX(true)
if spineHelper.enableChangeFace(modelParams.body)then
self.winlua:SetChildChangeSlotDisplay(self.model:getID(),"face","face",self.config.disciple[1][2])
end

local conf={itemid=argtable.itemId,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.item:setChildPropData(prop)
self.item:setBaseItemClickEvent(function(...)
itemsComponentHelper.onItemClickEx(...)
end)

self.actorName:setText("祖师赠礼")

end


function UISubAct_CangBaoTuSharedTips:onHide()

end





function UISubAct_CangBaoTuSharedTips:onCloseBtn()
self:closeSelf()
end



function UISubAct_CangBaoTuSharedTips:onJumpBtn()
local extraParams={
subWindow=1
}
jumpManager:jump({id=JUMP_TYPE.eActivity,args={subType=self.subType,subid=self.subId,extraParams=extraParams}},function()
jumpManager:clearJump()
end)
end



function UISubAct_CangBaoTuSharedTips:onCancelBtn()
self:closeSelf()
end

function UISubAct_CangBaoTuSharedTips:onBackground()
self:closeSelf()
end