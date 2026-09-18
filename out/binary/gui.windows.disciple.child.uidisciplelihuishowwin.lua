







def_class("UIDiscipleLiHuiShowWin",UIWindowBase)









function UIDiscipleLiHuiShowWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.model=UIObject.get(self,1)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIDiscipleLiHuiShowWin")end)



end


function UIDiscipleLiHuiShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.model);self.model=nil;
end



















function UIDiscipleLiHuiShowWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleLiHuiShowWin:__delete()
self:unbindComponents()
end




function UIDiscipleLiHuiShowWin:onShow(argtable,afterOnloaded)
local dzId=argtable.dzId
local tjId=argtable.tjId
local itemid=argtable.itemid
local isSwitching=argtable.isSwitching
local cfg=cfg_xumitaxyhlconfig_get(tjId)
local size,x,y=unpack(cfg.Live2D)
if isSwitching then
size,x,y=unpack(cfg.Live2D.switch)
end
local flipX=false
local args={clothingId=itemid}
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzId)
local info=dzData.imageInfo
local modelParamsLihui=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,args)

if itemid then
size,x,y=0.7,0,0
local item_config=itemsConfig.getConfig(itemid)
if item_config and item_config.lihuiOffest and item_config.lihuiOffest.scale then
size=item_config.lihuiOffest.scale
end

if item_config and item_config.lihuiOffest then
local lihuiOffest=item_config.lihuiOffest
if lihuiOffest.x then
x=lihuiOffest.x
end
if lihuiOffest.y then
y=lihuiOffest.y
end
if lihuiOffest.flipX then
flipX=true
end
end
end

self.model:setChildUIModelShowTarget(modelParamsLihui.body,size,modelParamsLihui.componets,modelParamsLihui.anim or 0,false,false,0.6)
self.model:setChildUIModelShowTargetOffset(x,y)
if flipX then
self.model:setChildUIModelShowFlipX(true)
end
end


function UIDiscipleLiHuiShowWin:onHide()

end



