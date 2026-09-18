







def_class("UITipsShiZhuangModelWin",UIWindowBase)









function UITipsShiZhuangModelWin:bindComponents()

self.root=UIObject.get(self,0)
self.model=UIObject.get(self,1)
self.limit=UIObject.get(self,2)
self.dizi=UIObject.get(self,3)
self.maxlvBtn=UIButton.get(self,4)
self.Text=UIText.get(self,5)
self.kuang=UIImage.get(self,6)
self.tou=UIObject.get(self,7)
self.Text2=UIText.get(self,8)
self.closeTag=UIObject.get(self,9)
self.openTag=UIObject.get(self,10)

self.maxlvBtn:setButtonClick(function()self:onMaxlvBtn()end)



end


function UITipsShiZhuangModelWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.limit);self.limit=nil;
_UIObject_release(self.dizi);self.dizi=nil;
_UIObject_release(self.maxlvBtn);self.maxlvBtn=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.kuang);self.kuang=nil;
_UIObject_release(self.tou);self.tou=nil;
_UIObject_release(self.Text2);self.Text2=nil;
_UIObject_release(self.closeTag);self.closeTag=nil;
_UIObject_release(self.openTag);self.openTag=nil;
end



















function UITipsShiZhuangModelWin:onLoaded(...)
self:bindComponents()
end


function UITipsShiZhuangModelWin:__delete()
self:unbindComponents()
end




function UITipsShiZhuangModelWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
local itemid=argtable.itemid
local itemguid=argtable.itemguid

self.itemid=itemid
self.itemguid=itemguid
self.attach=argtable.attach or{}
if type(self.attach)~='table'then
self.attach={}
end
if itemguid then
local star=ClothingModel:getStarLv(itemguid)
self.isMax=ClothingConfig.isStarMaxLv(itemid,star)
self.oriStar=star
else
self.isMax=false
self.oriStar=0
end

self.closeTag:setActive(not self.isMax)
self.openTag:setActive(self.isMax)
local modelParams=self:getModelParams(itemguid,itemid)
self:setModel(modelParams)


local equipedDizi=itemguid~=nil and ClothingModel:getDiziguidByItemguid(itemguid)or nil
self.equipedDizi=equipedDizi
local itemCfg=itemsConfig.getConfig(itemid)
self.dizi:setActive(equipedDizi~=nil)
local equipedName=''
if equipedDizi then
local switchidx=ClothingModel:getEquipSwitchIdx(itemguid)
comHelper.setChildModelHeadIconBG(self.winid,self.kuang:getID(),equipedDizi,switchidx)
comHelper.setChildModelRawImage(self.winid,equipedDizi,self.tou:getID(),0,eHeadCenterType.eHead,nil,nil,nil,switchidx)

self.Text2:setText(UIDiscipleModel:getDiscipleName(equipedDizi))
end

if itemCfg.disciple then
local name=cfgHelper.get(cfg_discipleconfig_get,itemCfg.disciple,"name")
self.Text:setText(FMT.fmt("{1}角色限定：{0}",name,equipedName))
else
local name=cfgHelper.get(cfg_disciplevocationconfig_get,itemCfg.type1,"name")
self.Text:setText(FMT.fmt("{1}职业限定：{0}",name,equipedName))
end
end
end

function UITipsShiZhuangModelWin:getModelParams(itemguid,itemid)
local model
local star=self.isMax and ClothingConfig.getStarMaxLv(itemid)or 0
if itemguid then
local diziguid=ClothingModel:getDiziguidByItemguid(itemguid)
local switchidx=ClothingModel:getEquipSwitchIdx(itemguid)
model=ClothingConfig.getModelArgs(itemid,star,diziguid,switchidx)
else
model=ClothingConfig.getModelArgs(itemid,star)
end
return model
end

function UITipsShiZhuangModelWin:setModel(modelParams)
local modelID=modelParams.model
local defsize=cfgHelper.get2(cfg_dbbodyconfig_get,modelID,'scales')or{}
local size=modelParams.scale or defsize[1]or 1
local componnets=modelParams.component or{}
local animationID=modelParams.ani or 0
local offset=modelParams.offset
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),1,0,3)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.root:getID(),2,0,3)
self.winlua:SetChildUIModelShowTarget(self.model:getID(),modelID,size*2,componnets,animationID)
if offset then
self.winlua:SetChildUIModelShowTargetOffset(self.model:getID(),offset[1],offset[2])
end
end

function UITipsShiZhuangModelWin:onAniComplete()
self.winlua:SetChildDOLocalMoveX(self.root:getID(),-300,0.3)
end

function UITipsShiZhuangModelWin:onHide()

end

function UITipsShiZhuangModelWin:onMaxlvBtn()
self.isMax=not self.isMax
self.closeTag:setActive(not self.isMax)
self.openTag:setActive(self.isMax)

local modelParams=self:getModelParams(self.itemguid,self.itemid)
self:setModel(modelParams)

tipsManager.freshTipsWithAttach(self.attach,"starlv",self.isMax and 5 or self.oriStar)
end



