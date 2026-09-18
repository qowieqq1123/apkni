







def_class("UISFPYtongguanWin",UIWindowBase)









function UISFPYtongguanWin:bindComponents()

self.root=UIObject.get(self,0)
self.titleBack=UIObject.get(self,1)
self.successEffect=UIObject.get(self,2)
self.imgbg2=UIObject.get(self,3)
self.icon=UIImage.get(self,4)
self.nameimg=UIImage.get(self,5)
self.nextname=UIText.get(self,6)
self.nextpanel=UIObject.get(self,7)
self.iconModel=UIObject.get(self,8)



end


function UISFPYtongguanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.imgbg2);self.imgbg2=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.nameimg);self.nameimg=nil;
_UIObject_release(self.nextname);self.nextname=nil;
_UIObject_release(self.nextpanel);self.nextpanel=nil;
_UIObject_release(self.iconModel);self.iconModel=nil;
end
















local _this
local abname="ui/windows/sifangpingyao/sifangpingyao_atlas_pak.ab"
local worlds=
{
[1]={"image_sifangpingyao_ditu3",{-6,2.5},{229,164}},
[2]={"image_sifangpingyao_ditu2",{14.2,-6.3},{178,177}},
[3]={"image_sifangpingyao_ditu1",{-3.2,-6.3},{179,218}},
[4]={"image_sifangpingyao_ditu4",{-6,-14.5},{219,176}},
[5]={"image_sifangpingyao_ditu5",{-6,-23},{360,278}},
}
local worldsname=
{
[1]={"image_sifanwenzi_09"},
[2]={"image_sifanwenzi_12"},
[3]={"image_sifanwenzi_10"},
[4]={"image_sifanwenzi_11"},
[5]={"image_sifanwenzi_13"},
}

local yg_systemid=
{
[1]=174,
[2]=177,
[3]=178,
[4]=179,
[5]=180,
}



function UISFPYtongguanWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISFPYtongguanWin:__delete()
self:unbindComponents()
_this=nil
end




function UISFPYtongguanWin:onShow(argtable,afterOnloaded)
self.thisygid=argtable.thisygid
self.nextygid=argtable.nextygid





local mapconfig=cfg_foursideskilldemonsconfig_get(self.thisygid)
local ygimg=mapconfig.ygimg
self.winlua:SetChildUIModelShowTarget(self.iconModel:getID(),ygimg[1],1,nil,eAnimationID.stand)

self.winlua:SetChildCSImageSprite(self.nameimg:getID(),abname,worldsname[self.thisygid][1])
SiFangPingYaoModel:settgflag(false)

local isshownext=false
local sfpytgarry=userActorArraySetting.get(ACTOR_SETTING_TYPE.eSiFangPingYao,'sfpytgarry',nil)
if sfpytgarry and sfpytgarry[self.thisygid]then
if sfpytgarry[self.thisygid]==0 then
local allygjd=SiFangPingYaoModel:getYGJingDuData()
if self.thisygid==5 then
isshownext=false
end
if allygjd[self.nextygid]then
isshownext=false
end
isshownext=true

sfpytgarry[self.thisygid]=1
userActorArraySetting.set(ACTOR_SETTING_TYPE.eSiFangPingYao,'sfpytgarry',sfpytgarry)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eSiFangPingYao)
end
end

if isshownext then
if self.nextygid<=5 then
local ygcfg=cfg_foursideskilldemonsconfig_get(self.nextygid)
local nextname=ygcfg.name
local str=FMT.fmt('\'{0}\' 已开启',nextname)
self.nextpanel:setActive(true)
self.nextname:setText(str or"")
end
else
self.nextpanel:setActive(false)
end


if self.nextygid<=5 then
local checkOpen=SiFangPingYaoController:checkOpen(yg_systemid[self.nextygid])
if not checkOpen then
local ygcfg=cfg_foursideskilldemonsconfig_get(self.nextygid)
local nextname=ygcfg.name
local coldDay=SiFangPingYaoController:getColdDay(yg_systemid[self.nextygid])
local str=""
if coldDay>0 then
str=FMT.fmt("{0}天后开启",coldDay)
else
str=FMT.fmt("{0}\'{1}\'",SiFangPingYaoController:getOpenTips(yg_systemid[self.nextygid]),nextname)
end
self.nextpanel:setActive(true)
self.nextname:setText(str or"")
end
end
end


function UISFPYtongguanWin:onHide()

end



