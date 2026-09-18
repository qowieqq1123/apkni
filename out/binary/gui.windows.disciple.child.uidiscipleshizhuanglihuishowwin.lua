







def_class("UIDiscipleShiZhuangLiHuiShowWin",UIWindowBase)









function UIDiscipleShiZhuangLiHuiShowWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.model=UIObject.get(self,1)
self.modelL=UIObject.get(self,2)
self.name=UIText.get(self,3)
self.imageName=UIObject.get(self,4)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIDiscipleShiZhuangLiHuiShowWin")end)



end


function UIDiscipleShiZhuangLiHuiShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.modelL);self.modelL=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.imageName);self.imageName=nil;
end



















function UIDiscipleShiZhuangLiHuiShowWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleShiZhuangLiHuiShowWin:__delete()
self:unbindComponents()
end
local nameAtltas='ui/windows/disciple/clothing_name_atlas_pak.ab'



function UIDiscipleShiZhuangLiHuiShowWin:onShow(argtable,afterOnloaded)
self.diziguid=argtable.dizi
self.selectItemId=argtable.itemid

local itemid=nil
local star=nil
local euqip=ClothingModel:getEquipByDizi(self.diziguid)
if self.selectItemId then
itemid=self.selectItemId
else
if euqip then
itemid=euqip.itemid
star=euqip.itemData.star
end
end

local args={clothingId=itemid,clothingStar=star}

if self.selectMaxStar and itemid~=-1 then
args.clothingStar=ClothingConfig.getStarMaxLv(itemid)
end

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo2(self.diziguid,0,nil,args)
local scale=modelParams.scale*3.5


self.modelL:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,modelParams.anim,false,false,0.6)

local dzData=UIDiscipleModel:getDiscipleData(self.diziguid)
local info=dzData.imageInfo
local modelParamsLihui=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,args)
local item_config=itemsConfig.getConfig(itemid)

local size=0.7
if item_config and item_config.lihuiOffest and item_config.lihuiOffest.scale then
size=item_config.lihuiOffest.scale
end

self.model:setChildUIModelShowTarget(modelParamsLihui.body,size,modelParamsLihui.componets,modelParamsLihui.anim or 0,false,false,0.6)


self.name:setText("")


if item_config and item_config.lihuiOffest then
local lihuiOffest=item_config.lihuiOffest
self.model:setChildAnchoredPosition(Vector2.New(lihuiOffest.x or 0,lihuiOffest.y or 100))

if lihuiOffest.flipX then
self.model:setChildUIModelShowFlipX(lihuiOffest.flipX==1)
end

end

self.imageName:setCSImageSprite(nameAtltas,FMT.fmt("image_dizishizhuangname_{0}",itemid))
end


function UIDiscipleShiZhuangLiHuiShowWin:onHide()

end



