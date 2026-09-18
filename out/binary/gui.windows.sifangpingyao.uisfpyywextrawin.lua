







def_class("UISFPYYWExtraWin",UIWindowBase)









function UISFPYYWExtraWin:bindComponents()

self.skillname=UIText.get(self,0)
self.skillDescTxt=UIText.get(self,1)
self.tiptxtbtn=UIButton.get(self,2)
self.gwitem=UIObject.get(self,3)

self.tiptxtbtn:setButtonClick(function()self:onTiptxtbtn()end)



end


function UISFPYYWExtraWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.skillname);self.skillname=nil;
_UIObject_release(self.skillDescTxt);self.skillDescTxt=nil;
_UIObject_release(self.tiptxtbtn);self.tiptxtbtn=nil;
_UIObject_release(self.gwitem);self.gwitem=nil;
end
















local _this
local gwitem=
{
iconbg=1,
image=2,
btn=3
}
local _iconAb="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _iconBg={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_7",
}



function UISFPYYWExtraWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISFPYYWExtraWin:__delete()
self:unbindComponents()
end




function UISFPYYWExtraWin:onShow(argtable,afterOnloaded)




local demons_id=SiFangPingYaoModel:getMapIdex()
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
local ywzjcfg=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id]
local ygcfg=cfg_foursideskilldemonsconfig_get(demons_id)
local ywbossid=ywzjcfg.bossid
local nuqizhi=SiFangPingYaoModel:getbossanger()




local nqstr="妖王情绪值：0"
local qh=0
local nq=0
if nuqizhi>0 then
qh=nuqizhi
nqstr=FMT.fmt('妖王亲和值：<color=#f1ce78>{0}</color>',qh)
elseif nuqizhi<0 then
nq=-nuqizhi
nqstr=FMT.fmt('妖王怒气值：<color=#f1ce78>{0}</color>',nq)
end
self.skillname:setText(nqstr)

local arry=nil
if qh>0 then
local affine_boss_attrs=ygcfg.affine_boss_attrs
for k,v in ipairs(affine_boss_attrs)do
if qh>=v[1]then
arry=v
end
end
end
if qh==0 and nq==0 then
local affine_boss_attrs=ygcfg.affine_boss_attrs
for k,v in ipairs(affine_boss_attrs)do
if qh>=v[1]then
arry=v
end
end
end
if nq>0 then
local affine_boss_attrs=ygcfg.angry_boss_attrs
for k,v in ipairs(affine_boss_attrs)do
if nq>=v[1]then
arry=v
end
end
end

if arry then
local txtdata=arry[4][1]

self.skillDescTxt:setText(txtdata or"")
end


if nuqizhi and nuqizhi<0 then

self.winlua:SetChildLocalPosY(self.skillname:getID(),-13.5)
self.winlua:SetChildLocalPosY(self.skillDescTxt:getID(),-26.5)
else
self.winlua:SetChildLocalPosY(self.skillname:getID(),-24)
self.winlua:SetChildLocalPosY(self.skillDescTxt:getID(),-28)
end


local item=self.gwitem:getWidgetBase()
comHelper.setChildModelRawImage_monsterGroup(item,ywbossid,gwitem.image,0,eHeadCenterType.eHead)
end


function UISFPYYWExtraWin:onHide()

end





function UISFPYYWExtraWin:onTiptxtbtn()
end

