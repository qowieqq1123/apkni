







def_class("UIBenMingFabaoCreateWin",UIWindowBase)









function UIBenMingFabaoCreateWin:bindComponents()

self.fbIcon=UIImage.get(self,0)
self.fbName=UIText.get(self,1)
self.attrGrid=UIObject.get(self,2)
self.skillDesc=UIText.get(self,3)
self.fbcolor=UIImage.get(self,4)
self.backEffect=UIObject.get(self,5)
self.title1=UIText.get(self,6)
self.title2=UIText.get(self,7)



end


function UIBenMingFabaoCreateWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.fbIcon);self.fbIcon=nil;
_UIObject_release(self.fbName);self.fbName=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.skillDesc);self.skillDesc=nil;
_UIObject_release(self.fbcolor);self.fbcolor=nil;
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
end

















local _this=nil
local _colorBg=fabaoConfig.bmQualityBg

function UIBenMingFabaoCreateWin:onLoaded(...)
_this=self
self:bindComponents()
end

function UIBenMingFabaoCreateWin:__delete()
if self.closeCallBack then
self.closeCallBack()
end
_this=nil
self:unbindComponents()
end

function UIBenMingFabaoCreateWin:onShow(argtable,afterOnloaded)
self.backEffect:setChildShowEffect(10014,true)
self.itemguid=argtable.itemguid
self.closeCallBack=argtable.closeCallBack

self:updateView()

self:showAnim()
end

function UIBenMingFabaoCreateWin:onHide()

end



function UIBenMingFabaoCreateWin:updateView()
local itemguid=self.itemguid
local equip=fabaoHelper.getFabao(itemguid)
local itemid=equip.itemid
local itemCfg=itemsConfig.getConfig(itemid)
local iconname=itemsModel.getIconName(equip)
local color=itemCfg.color

self.fbIcon:setImageIcon(iconname,true)

self.fbcolor:setSprite(globalABLookup.gubaomainicons,gubaoColorFrame:getName(color))

local name=fabaoHelper.getFabaoName(equip)
name=FMT.fmt(FONT_COLOR_FMT[color],name)
self.fbName:setText(name)

local attrWidget=self.attrGrid:getChildWidgetBase()
local attrlist=fabaoHelper.getBaseAttrsList(equip)

for i=1,3 do
local attr=attrlist[i]
local isshow=attr~=nil
attrWidget:SetChildActive(i-1,isshow)
if isshow then
local str=helper.getAttributeStr(attr[1],attr[2],nil,'{0}：<color=#549327>{1}</color>')
attrWidget:SetChildText(i-1,str)
end
end


local mainid=fabaoHelper.getMainId(equip)
local czid=benMingFaBaoHelper.getCiZhui(mainid)
local czCfg=cfg_disciplefabaoczconfig_get(czid)
local czname=czCfg.name
local desc=czCfg.descEx or czCfg.desc
self.skillDesc:setText(FMT.fmt('<color=#ca631d>【{0}】</color>{1}',czname,desc))
end

function UIBenMingFabaoCreateWin:showAnim()

local delay=0
local sub=0.3
self.fbIcon:setRotation(0,90,0)
self.fbName:setActive(false)
local func=function()
if _this==nil then return end
_this.fbName:setActive(true)
end
self.fbIcon:setChildDORotation(Vector3.zero,sub,DG.Tweening.RotateMode.Fast,func)
delay=delay+sub

local pos1=self.title1:getChildLocalPosition()
self.title1:setLocalPosY(-200)
self.title1:setActive(false)
sub=0.2
local func1=function()
self.title1:setActive(true)
self.title1:setChildDOLocalMoveY(pos1.y,sub,nil)
end
self:delayDo(delay,func1)
delay=delay+sub

local pos2=self.attrGrid:getChildLocalPosition()
self.attrGrid:setLocalPosY(-200)
self.attrGrid:setActive(false)
sub=0.2
local func2=function()
self.attrGrid:setActive(true)
self.attrGrid:setChildDOLocalMoveY(pos2.y,sub,nil)
end
self:delayDo(delay,func2)
delay=delay+sub

local pos3=self.title2:getChildLocalPosition()
self.title2:setLocalPosY(-200)
self.title2:setActive(false)
sub=0.2
local func3=function()
self.title2:setActive(true)
self.title2:setChildDOLocalMoveY(pos3.y,sub,nil)
end
self:delayDo(delay,func3)
delay=delay+sub

local pos4=self.skillDesc:getChildLocalPosition()
self.skillDesc:setLocalPosY(-200)
self.skillDesc:setActive(false)
sub=0.2
local func4=function()
self.skillDesc:setActive(true)
self.skillDesc:setChildDOLocalMoveY(pos4.y,sub,nil)
end
self:delayDo(delay,func4)
delay=delay+sub
end

function UIBenMingFabaoCreateWin:onClickClose()
self:closeSelf()
end
