







def_class("UIBaoLingShuHUD",UICloneObject)





UIBaoLingShuHUD.abName="ui/windows/baolingshu/uibaolingshuhud.ab"

UIBaoLingShuHUD.assetName="UIBaoLingShuHUD"


function UIBaoLingShuHUD:bindComponents()

self.root=UIObject.get(self,0)
self.dzItem=UIBaseItem.get(self,1)
self.dzModel=UIObject.get(self,2)
self.qipao=UIObject.get(self,3)

end


function UIBaoLingShuHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.dzItem);self.dzItem=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.qipao);self.qipao=nil;
end









function UIBaoLingShuHUD:onLoaded(...)
self:bindComponents()
end


function UIBaoLingShuHUD:__delete()
self:killDoTween()
self:unbindComponents()

end

local function _onClickItem(itemid,index,guid,attach)
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end




function UIBaoLingShuHUD:onShow(argtable,afterOnloaded)
self.ent=argtable.fightEnt
self.parent=argtable.parent
self.showType=argtable.showType
self.dzId=argtable.dzId

self.ent.baolingShuHUD=self
self.root:setActive(true)
self.qipao:setActive(true)
self:attach(self.ent.guid)
self:setChildPosition(self.root:getID(),Vector3.zero)

self:showDZItems()
self:fadeItem(self.dzItem)

self:showDzModel()
end


function UIBaoLingShuHUD:onHide()

end

function UIBaoLingShuHUD:showRoot(show)
self.root:setActive(show)
end

function UIBaoLingShuHUD:showQiPao(show)
self.qipao:setActive(show)
end

function UIBaoLingShuHUD:attach(guid)
self:setChildFollowEntity(self.root:getID(),guid,Vector3.zero)
end

function UIBaoLingShuHUD:unAttach()
self:setChildFollowEntity(self.root:getID(),self.ent.guid,Vector3.zero)
end

function UIBaoLingShuHUD:showDZItems()
local itemid
if self.showType==1 then
itemid=baoLingShuModel:getShowItemid()
elseif self.showType==2 then
itemid=qiYuanShuModel:getShowItemid()
end
local conf={itemid=itemid,showCountBG=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

self.dzItem:setChildPropData(prop)
self.dzItem:setBaseItemClickEvent(itemsComponentHelper.onItemClickEx)

local item=self:getChildCSGUIBaseItem(self.dzItem:getID())
item:SetChildActive(0,false)
end

function UIBaoLingShuHUD:fadeItem(item)
if self.tweener1==nil then
local rand=math.random()+1
local showCall=function(...)
self.tweener1:Kill(false)
self.tweener1=nil
local hideCall=function(...)
self.tweener2:Kill(false)
self.tweener2=nil
self:showDZItems()
self:fadeItem(item)
end
self.tweener2=self:setChildCanvasGroupDOFade(item:getID(),0,2,hideCall)
local hideDeley=math.random(8,10)
self.tweener2:SetDelay(hideDeley)
end
self.tweener1=self:setChildCanvasGroupDOFade(item:getID(),1,2,showCall)
end
end

function UIBaoLingShuHUD:killDoTween()
if self.tweener1 then
self.tweener1:Kill(false)
self.tweener1=nil
end
if self.tweener2 then
self.tweener2:Kill(false)
self.tweener2=nil
end
end

function UIBaoLingShuHUD:showDzModel()
if self.dzId and self.showType==2 then

self.dzModel:setActive(true)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.dzId,false,1)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(self.dzId)
local bodyid=imageInfo.sex==SEX_TYPE.eMale and 50001 or 50002
modelParams.ChangeBody=cfgHelper.get2(cfg_disciplebodyimageconfig_get,bodyid,'out_side')
local scale=0.75
self.dzModel:setChildUIModelShowTarget(modelParams.ChangeBody,modelParams.scale,nil,modelParams.anim,false,false,0.5)
self.dzModel:setChildAddSkeletonSlot("tou1","head",modelParams.componets[1])
self.dzModel:setScale(Vector3.New(scale,scale,scale))
else
self.dzModel:setActive(false)
self.dzModel:setChildUIModelRemoveTarget()
end
end

function UIBaoLingShuHUD:setDzModelActive(isActive)
self.dzModel:setActive(isActive)
end

function UIBaoLingShuHUD:fadeInDzModel()
self.dzModel:setChildCanvasGroupAlpha(0)
self.dzModel:setChildCanvasGroupDOFade(1,1)
end

