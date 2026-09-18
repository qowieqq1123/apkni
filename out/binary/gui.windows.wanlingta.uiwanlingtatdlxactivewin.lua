







def_class("UIWanLingTaTDLXActiveWin",UIWindowBase)








function UIWanLingTaTDLXActiveWin:bindComponents()

self.attrGrid=UIObject.get(self,0)
self.attrGrid2=UIObject.get(self,1)
self.backEffect=UIObject.get(self,2)
self.gubaocolor=UIImage.get(self,3)
self.gubaoIcon=UIImage.get(self,4)
self.gubaoName=UIText.get(self,5)
self.skillDesc=UIText.get(self,6)
self.title1=UIText.get(self,7)
self.title2=UIText.get(self,8)
self.title3=UIText.get(self,9)



end


function UIWanLingTaTDLXActiveWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.attrGrid2);self.attrGrid2=nil;
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.gubaocolor);self.gubaocolor=nil;
_UIObject_release(self.gubaoIcon);self.gubaoIcon=nil;
_UIObject_release(self.gubaoName);self.gubaoName=nil;
_UIObject_release(self.skillDesc);self.skillDesc=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.title3);self.title3=nil;
end

















local _this=nil


function UIWanLingTaTDLXActiveWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIWanLingTaTDLXActiveWin:__delete()
_this=nil
self.backEffect:setChildShowEffect(0,false)
self:unbindComponents()
end


function UIWanLingTaTDLXActiveWin:onHide()

end




function UIWanLingTaTDLXActiveWin:onShow(argtable,afterOnloaded)
self.backEffect:setChildShowEffect(10014,true)
self.gbid=argtable.gbid

self:updateView()

self:showAnim()
end

function UIWanLingTaTDLXActiveWin:updateView()
local gbid=self.gbid
local gbcfg=wanLingTaModel:getTuJianConfig(gbid)

self.gubaoIcon:setImageIcon(gbcfg.icon,true)

self.gubaocolor:setSprite(globalABLookup.gubaomainicons,gubaoColorFrame:getName(gbcfg.color))

local name_str=FMT.fmt(FONT_COLOR_FMT[gbcfg.color],gbcfg.name)
self.gubaoName:setText(name_str)

local attrWidget=self.attrGrid:getChildWidgetBase()
local attrLookup=gbcfg.prop[1]
local attrList={}
for attrKey,attrVal in pairs(attrLookup)do
table.insert(attrList,{attrKey,attrVal})
end
for i=1,3 do
local attr=attrList[i]
local isshow=attr~=nil
attrWidget:SetChildActive(i-1,isshow)
if isshow then
local str=helper.getAttributeStr(attr[1],attr[2],nil,'{0}：<color=#549327>{1}</color>')
attrWidget:SetChildText(i-1,str)
end
end


local skill_str=""
local propRewardsDesc=gbcfg.propRewardsDesc and gbcfg.propRewardsDesc[1]
if propRewardsDesc then
for i,v in ipairs(propRewardsDesc)do
if i==1 then
skill_str=v
else
skill_str=string.format("%s\n%s",skill_str,v)
end
end
self.showTitle2=true
else
self.showTitle2=false
end
self.skillDesc:setText(skill_str)
end

function UIWanLingTaTDLXActiveWin:showAnim()

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

if self.isfly then

local pos12=self.title3:getChildLocalPosition()
self.title3:setLocalPosY(-200)
self.title3:setActive(false)
sub=0.2
local func11=function()
self.title3:setActive(true)
self.title3:setChildDOLocalMoveY(pos12.y,sub,nil)
end
self:delayDo(delay,func11)
delay=delay+sub


local pos22=self.attrGrid2:getChildLocalPosition()
self.attrGrid2:setLocalPosY(-200)
self.attrGrid2:setActive(false)
sub=0.2
local func22=function()
self.attrGrid2:setActive(true)
self.attrGrid2:setChildDOLocalMoveY(pos22.y,sub,nil)
end
self:delayDo(delay,func22)
delay=delay+sub
end


local pos3=self.title2:getChildLocalPosition()
self.title2:setLocalPosY(-200)
self.title2:setActive(false)
if self.showTitle2 then
sub=0.2
local func3=function()
self.title2:setActive(true)
self.title2:setChildDOLocalMoveY(pos3.y,sub,nil)
end
self:delayDo(delay,func3)
delay=delay+sub
end

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

function UIWanLingTaTDLXActiveWin:onClickClose()
self:closeSelf()
end