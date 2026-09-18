







def_class("UIDiscipleInfo2Component",UIWindowBase)









function UIDiscipleInfo2Component:bindComponents()

self.dialogTx=UIText.get(self,0)
self.discipleModelRoot=UIObject.get(self,1)
self.dialog=UIObject.get(self,2)
self.nameText=UIText.get(self,3)
self.discipleJobIcon=UIImage.get(self,4)
self.discipleJobIcon2=UIImage.get(self,5)
self.spBg=UIObject.get(self,6)



end


function UIDiscipleInfo2Component:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.dialogTx);self.dialogTx=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.dialog);self.dialog=nil;
_UIObject_release(self.nameText);self.nameText=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.discipleJobIcon2);self.discipleJobIcon2=nil;
_UIObject_release(self.spBg);self.spBg=nil;
end
















local _this=nil




function UIDiscipleInfo2Component:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onDiscipleBagAddItem,self.onDiscipleBagAddItem)
notifySystem:listenNotify(notifyConfig.onDiscipleBagDeleteItem,self.onDiscipleBagDeleteItem)
notifySystem:listenNotify(notifyConfig.onDiscipleRemove,self.onDiscipleRemove)
end


function UIDiscipleInfo2Component:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onDiscipleBagAddItem,self.onDiscipleBagAddItem)
notifySystem:removelistener(notifyConfig.onDiscipleBagDeleteItem,self.onDiscipleBagDeleteItem)
notifySystem:removelistener(notifyConfig.onDiscipleRemove,self.onDiscipleRemove)
_this=nil
end




function UIDiscipleInfo2Component:onShow(argtable,afterOnloaded)
local isChangeDz=false
if not afterOnloaded then
isChangeDz=not mathHelper.compareInt64(self.disciple_guid,argtable.guid)
end
self.disciple_guid=argtable.guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
self:refreshModel()

self.menuPageIndex=argtable.menuPageIndex
end


function UIDiscipleInfo2Component:onHide()

end

function UIDiscipleInfo2Component:refreshModel()

self.nameText:setText(UIDiscipleModel:getDiscipleName(self.disciple_guid))

local jobicon=UIDiscipleModel:getJobIconNameX(self.disciple_guid)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(self.disciple_guid)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)
self.discipleJobIcon2:setActive(isSPdz)
self.spBg:setActive(isSPdz)
if isSPdz then
local switchidx=1
local switchJobIcon=UIDiscipleModel:getJobIconNameX(self.disciple_guid,switchidx)
self.discipleJobIcon2:setSprite(globalABLookup.global,switchJobIcon)
self.discipleJobIcon:setChildAnchoredPos(-10,10)
local scale=54/68
self.discipleJobIcon:setScale(Vector3(scale,scale,scale))
else
self.discipleJobIcon:setChildAnchoredPos(0,0)
self.discipleJobIcon:setScale(Vector3.one)
end

comHelper.setChildInSideModel(self.discipleModelRoot,self.disciple_guid,nil,nil,0,-15,false,true)
end



