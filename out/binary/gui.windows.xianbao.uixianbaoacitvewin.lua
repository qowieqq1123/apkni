







def_class("UIXianBaoAcitveWin",UIWindowBase)









function UIXianBaoAcitveWin:bindComponents()

self.gubaoIcon=UIImage.get(self,0)
self.gubaoName=UIText.get(self,1)
self.attrGrid=UIObject.get(self,2)
self.skillDesc=UIText.get(self,3)
self.gubaocolor=UIImage.get(self,4)
self.backEffect=UIObject.get(self,5)
self.title1=UIText.get(self,6)
self.title2=UIText.get(self,7)



end


function UIXianBaoAcitveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gubaoIcon);self.gubaoIcon=nil;
_UIObject_release(self.gubaoName);self.gubaoName=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.skillDesc);self.skillDesc=nil;
_UIObject_release(self.gubaocolor);self.gubaocolor=nil;
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
end


















local _this=nil


function UIXianBaoAcitveWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianBaoAcitveWin:__delete()
_this=nil
self.backEffect:setChildShowEffect(0,false)
self:unbindComponents()
end


function UIXianBaoAcitveWin:onHide()

end




function UIXianBaoAcitveWin:onShow(argtable,afterOnloaded)
self.backEffect:setChildShowEffect(10014,true)
self.xbid=argtable.xbid

self:updateView()

self:showAnim()
end

function UIXianBaoAcitveWin:updateView()
local xbid=self.xbid
local xbcfg=xianbaoConfig.getXBCfg(xbid)

self.gubaoIcon:setImageIcon(xianbaoConfig.getXianBaoIconName(xbid),true)


self.gubaocolor:setSprite(globalABLookup.gubaomainicons,gubaoColorFrame:getName(5))

local name_str=FMT.fmt(FONT_COLOR_FMT[xbcfg.color],xbcfg.name)
self.gubaoName:setText(name_str)

local starXbCdg=xianbaoConfig.getXBStarCfg(xbid,0)
local attrWidget=self.attrGrid:getChildWidgetBase()
local attrlist=starXbCdg.attrs
for i=1,3 do
local attr=attrlist[i]
local isshow=attr~=nil
attrWidget:SetChildActive(i-1,isshow)
if isshow then
local str=helper.getAttributeStr(attr[1],attr[2],nil,'{0}：<color=#549327>{1}</color>')
attrWidget:SetChildText(i-1,str)
end
end


self.skillDesc:setText(xbcfg.xb_Effect_active)
end

function UIXianBaoAcitveWin:showAnim()

local delay=0
local sub=0.3
self.gubaoIcon:setRotation(0,90,0)
self.gubaoName:setActive(false)
local func=function()
if _this==nil then return end
_this.gubaoName:setActive(true)
end
self.gubaoIcon:setChildDORotation(Vector3.zero,sub,DG.Tweening.RotateMode.Fast,func)
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

function UIXianBaoAcitveWin:onClickClose()
self:closeSelf()
end