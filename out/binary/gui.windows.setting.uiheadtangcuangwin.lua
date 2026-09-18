







def_class("UIHeadTangCuangWin",UIWindowBase)









function UIHeadTangCuangWin:bindComponents()

self.root=UIObject.get(self,0)
self.center=UIObject.get(self,1)
self.titleimg=UIImage.get(self,2)
self.gotobtn=UIButton.get(self,3)
self.time=UIText.get(self,4)
self.headKuang2=UIObject.get(self,5)
self.attrRoot=UIObject.get(self,6)
self.curName=UIText.get(self,7)
self.headIcon=UIImage.get(self,8)
self.headKuang=UIImage.get(self,9)
self.attr_1=UIObject.get(self,10)
self.attr_2=UIObject.get(self,11)
self.btnClose=UIButton.get(self,12)
self.layout=UIObject.get(self,13)
self.icon=UIImage.get(self,14)
self.model=UIObject.get(self,15)
self.spimg=UIImage.get(self,16)
self.timebg=UIObject.get(self,17)
self.bgImg=UIImage.get(self,18)

self.gotobtn:setButtonClick(function()self:onGotobtn()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)
self.attr={
self.attr_1,
self.attr_2,
}



end


function UIHeadTangCuangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.titleimg);self.titleimg=nil;
_UIObject_release(self.gotobtn);self.gotobtn=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.headKuang2);self.headKuang2=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.curName);self.curName=nil;
_UIObject_release(self.headIcon);self.headIcon=nil;
_UIObject_release(self.headKuang);self.headKuang=nil;
_UIObject_release(self.attr_1);self.attr_1=nil;
_UIObject_release(self.attr_2);self.attr_2=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.spimg);self.spimg=nil;
_UIObject_release(self.timebg);self.timebg=nil;
_UIObject_release(self.bgImg);self.bgImg=nil;
self.attr=nil;
end
















local _this
local abname='ui/windows/setting/kefu_altas_pak.ab'



function UIHeadTangCuangWin:onLoaded(...)
self:bindComponents()
_this=self
self.dOFade=true
end


function UIHeadTangCuangWin:__delete()
self:unbindComponents()
_this=nil
end


function UIHeadTangCuangWin:onGotobtn()


local tab=self.jumps[2]
local itemid=self.jumps[1]
local secFullTab=UISettingController:getSecFullTabByTab(tab)
oneTabScreenController:openTabUI(secFullTab,{itemId=itemid})
self:closeSelf()
end





function UIHeadTangCuangWin:onShow(argtable,afterOnloaded)

self.root:setChildCanvasGroupAlpha(0)
self.bgImg:setChildUIModelShowTarget(6399,1,nil,eAnimationID.stand)
self.root:setChildCanvasGroupDOFade(1,0.6,function()
self.dOFade=false
end)

if argtable then
self.headKuangId=argtable.headKuangId
self.typo=argtable.typo
self.expiresec=argtable.expiresec
end

if self.typo==2 then
self.headKuang2:setActive(true)
self.layout:setActive(false)

local kuangCfg=cfgHelper.get1(cfg_headportraitframeconfig_get,self.headKuangId)
local kuangIcon=kuangCfg.icon
self.jumps=kuangCfg.jumps
local kuangAnimType,kuangAnim,enterAnimId=playerModel:getActorFrameAnimById(kuangCfg.id)


playerController:setWidgetHeadKuang(self.widget,self.headKuang:getID(),kuangIcon,kuangAnimType,kuangAnim,nil,enterAnimId)




self.curName:setText(kuangCfg.name)

self.winlua:SetChildCSImageSprite(self.titleimg:getID(),abname,'image_touxk_03')


self:setHeadAttr(kuangCfg)

elseif self.typo==3 then
self.headKuang2:setActive(false)
self.layout:setActive(true)

local kuangCfg=cfg_bubbleframeconfig_get(self.headKuangId)
self.jumps=kuangCfg.jumps
local kuangIconName=iconHelper.getChatKuangIcon(kuangCfg.icon)
local model=kuangCfg.model
local modelId=kuangCfg.setmodel
if modelId then
self.winlua:SetChildUIModelEnableInitUISpinePara(self.model:getID(),false,true)
if self.dOFade and api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.model:getID(),true,true,false)
end
self.model:setChildUIModelShowTarget(modelId,1,{},eAnimationID.stand)
else
self.model:setChildUIModelRemoveTarget()
self.icon:setImageIcon(kuangIconName,false)
end
self.winlua:SetChildActive(self.icon:getID(),modelId==nil)


self.curName:setText(kuangCfg.name)

self.winlua:SetChildCSImageSprite(self.titleimg:getID(),abname,'image_touxk_02')


self:setHeadAttr(kuangCfg)
end


if self.jumps and self.jumps[3]then
self.spimg:setActive(true)
self.winlua:SetChildCSImageSprite(self.spimg:getID(),abname,self.jumps[3])
else
self.spimg:setActive(false)
end


if self.expiresec and self.expiresec>0 then
self.timebg:setActive(true)
local logTime_long=timeHelper.convertLongStamp(self.expiresec)
local str=timeHelper.getFiveFormatByStamp(logTime_long)
self.time:setText(FMT.fmt('{0}过期',str))
else
self.timebg:setActive(false)
end
end


function UIHeadTangCuangWin:onHide()

end
function UIHeadTangCuangWin:onBtnClose()
self:closeSelf()
end


function UIHeadTangCuangWin:setWidgetHead(widget,index,iconid)
widget:SetChildUIModelRemoveTarget(index)
widget:SetChildIcon(index,"",false)
local scale=0.53
local offsetX=0
local offsetY=-43
local ani=eAnimationID.idle
local isdefault=cfgHelper.get2(cfg_headportraitconfig_get,iconid,'isdef')==1
local playerImage=playerImageModel:getPlayerImage()
if isdefault and playerImage~=nil then
playerImageController.setPlayerModel(widget,index,playerImage,scale,ani,offsetX,offsetY)
else
local headicon=playerModel:getActorIconById(iconid)
local iconname=iconHelper.getHeadIcon(headicon)
widget:SetChildIcon(index,iconname,false)
end
end

function UIHeadTangCuangWin:setHeadAttr(settingcfg)



















local attr=settingcfg.attr
local jzattr=settingcfg.jzattr
local haveAttr=false
if attr or jzattr then
haveAttr=true
end
if haveAttr then
local attrList
if attr then
attrList={}
for i,v in ipairs(attr)do
table.insert(attrList,v)
end
end
if jzattr then
if not attrList then
attrList={}
end
for i,v in ipairs(jzattr)do
table.insert(attrList,v)
end
end
if attrList then
self.attrRoot:setActive(true)
for i,v in ipairs(self.attr)do
if attrList[i]then
local attr=attrList[i]
v:setActive(true)
local item=v:getChildWidgetBase()
local name,value=equipsHelper.getAttr(attr[1],attr[2])
local nameStr=FMT.fmt("{0}：<color=#aae252>+{1}</color>",name,value)

item:SetChildText(1,nameStr)


else
v:setActive(false)
end
end
else
self.attrRoot:setActive(false)
end
else
self.attrRoot:setActive(false)
end
end