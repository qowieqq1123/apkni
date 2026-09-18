







def_class("UIDiscipleTianMingTipsWin",UIWindowBase)









function UIDiscipleTianMingTipsWin:bindComponents()

self.tmIcon=UIImage.get(self,0)
self.descgrid=UIObject.get(self,1)
self.tmLvTxt=UIText.get(self,2)
self.tmSign=UIImage.get(self,3)
self.tmNameTxt=UIText.get(self,4)
self.tmDescTxt=UIText.get(self,5)
self.root=UIObject.get(self,6)



end


function UIDiscipleTianMingTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tmIcon);self.tmIcon=nil;
_UIObject_release(self.descgrid);self.descgrid=nil;
_UIObject_release(self.tmLvTxt);self.tmLvTxt=nil;
_UIObject_release(self.tmSign);self.tmSign=nil;
_UIObject_release(self.tmNameTxt);self.tmNameTxt=nil;
_UIObject_release(self.tmDescTxt);self.tmDescTxt=nil;
_UIObject_release(self.root);self.root=nil;
end

















function UIDiscipleTianMingTipsWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleTianMingTipsWin:__delete()
self:unbindComponents()
end


function UIDiscipleTianMingTipsWin:onHide()

end




function UIDiscipleTianMingTipsWin:onShow(argtable,afterOnloaded)
local tmID=argtable.tmID
local tmIndex=argtable.tmIndex
local tmlv=argtable.tmlv
self.jobid=argtable.jobid
self.tmID=tmID
self.tmIndex=tmIndex
self.tmlv=tmlv

local isActive,need_tmlv
if tmIndex==6 then
isActive,need_tmlv=UIDiscipleModel.checkTiamMingCiFuPosOpenX(tmlv,1)
elseif tmIndex>6 then
isActive,need_tmlv=UIDiscipleModel:checkTianMingFloorActive(tmlv,tmIndex-1)
else
isActive,need_tmlv=UIDiscipleModel:checkTianMingFloorActive(tmlv,tmIndex)
end
local color=tmIndex

local lv_str=UIDiscipleModel.getTianMingLevelDesc(need_tmlv,1)

self.tmLvTxt:setText(lv_str)

local active_str=isActive==true and'image_yijihuo'or'image_weijihuo'
self.tmSign:setSprite(globalABLookup.global,active_str)

local floor=UIDiscipleModel.getTianMingLevelFloor(need_tmlv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
self.tmIcon:setSprite(abName,iconName)

local tmcfg=nil
if tmID then
tmcfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
end

local name_str
if tmIndex==6 then
name_str=UIDiscipleModel.getTianMingName('赐福')
else
local name=tmcfg.name
name_str=UIDiscipleModel.getTianMingName(name)
end
if isActive then
name_str=toColorString(FONT_COLOR.eTipWhiteColor,name_str)
end
self.tmNameTxt:setText(name_str)

local desc_str=UIDiscipleModel.getTianMingDesc(tmcfg,self.jobid)
if isActive then
desc_str=toColorString(FONT_COLOR.eTipWhiteColor,desc_str)
end
self.tmDescTxt:setText(desc_str)
end


