







def_class("UILDDiaoXiangShowWin",UIWindowBase)









function UILDDiaoXiangShowWin:bindComponents()

self.spineObj=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.text=UIText.get(self,2)
self.text2=UIText.get(self,3)
self.image=UIImage.get(self,4)
self.ButtonClose=UIButton.get(self,5)
self.textImg_1=UIObject.get(self,6)
self.textImg_2=UIObject.get(self,7)
self.textImg_3=UIObject.get(self,8)

self.ButtonClose:setButtonClick(function()self:onButtonClose()end)
self.textImg={
self.textImg_1,
self.textImg_2,
self.textImg_3,
}



end


function UILDDiaoXiangShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.spineObj);self.spineObj=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.text);self.text=nil;
_UIObject_release(self.text2);self.text2=nil;
_UIObject_release(self.image);self.image=nil;
_UIObject_release(self.ButtonClose);self.ButtonClose=nil;
_UIObject_release(self.textImg_1);self.textImg_1=nil;
_UIObject_release(self.textImg_2);self.textImg_2=nil;
_UIObject_release(self.textImg_3);self.textImg_3=nil;
self.textImg=nil;
end



















function UILDDiaoXiangShowWin:onLoaded(...)
self:bindComponents()
self.spineObj:setChildUIModelShowTarget(4033,1,{},eAnimationID.stand,false,false)
end


function UILDDiaoXiangShowWin:__delete()
self:unbindComponents()
end




function UILDDiaoXiangShowWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
if argtable then
local guid=argtable.entityId

local isVisit=argtable.isVisit
if isVisit then
self.bdData=argtable
local model=cfgHelper.get3(cfg_monijybuildconfig_get,self.bdData.build_id,'model',1)
self.image:setChildUIModelShowTarget(model,1,nil,eAnimationID.bd_stand)
local sfId=zongmenModel:getMountainId()
local data=visitControl:getStatueData(sfId,self.bdData.un_build_id)
if data then
self:freshByData(data)
end
else
self.bdData=zongmenModel:findBuildingByEntityId(guid)
local data=lundaodahuiModel:getDxData(self.bdData.un_build_id)
local model=cfgHelper.get3(cfg_monijybuildconfig_get,self.bdData.build_id,'model',1)
self.image:setChildUIModelShowTarget(model,1,nil,eAnimationID.bd_stand)

if not data then
lundaodahuiController.req_6_70(self.bdData.un_build_id)
else
self:freshData(self.bdData.un_build_id)
end
end
end

end


function UILDDiaoXiangShowWin:onHide()

end

function UILDDiaoXiangShowWin:onRecv()
self:freshData(self.bdData.un_build_id)
end

function UILDDiaoXiangShowWin:freshData(un_build_id)
local data=lundaodahuiModel:getDxData(un_build_id)
if data then
self:freshByData(data)
end
end

function UILDDiaoXiangShowWin:freshByData(data)
if data then
local rank=data.rank
local jieShu=data.jieShu
self.title:setText(jieShu)
self.textImg[rank]:setActive(true)


local name=''
if rank==1 then
name='冠'
elseif rank==2 then
name='亚'
elseif rank==3 then
name='季'
end
self.text:setText(FMT.fmt("{0}军专属雕像",name))


end
end

function UILDDiaoXiangShowWin:onButtonClose()
self:closeSelf()
end


