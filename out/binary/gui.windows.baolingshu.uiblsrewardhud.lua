







def_class("UIBLSRewardHUD",UICloneObject)





UIBLSRewardHUD.abName="ui/windows/baolingshu/uiblsrewardhud.ab"

UIBLSRewardHUD.assetName="UIBLSRewardHUD"


function UIBLSRewardHUD:bindComponents()

self.bigItem=UIBaseItem.get(self,0)
self.effect1=UIObject.get(self,1)
self.effect2=UIObject.get(self,2)
self.root=UIObject.get(self,3)

end


function UIBLSRewardHUD:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bigItem);self.bigItem=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.root);self.root=nil;
end







local _Ease=DG.Tweening.Ease
local sectionY={{920,1100},{820,1200},{760,1200},{900,1200}}


function UIBLSRewardHUD:onLoaded(...)
self:bindComponents()
end


function UIBLSRewardHUD:__delete()
if self.sequence then
self.sequence:Kill(false)
end
self:unbindComponents()
end




function UIBLSRewardHUD:onShow(argtable,afterOnloaded)
local itemid=argtable[1]
local onlyOne=argtable[2]
local showType=argtable.showType
local showPos
if onlyOne then
local list={{997,8.2,0.6,2},{998,7.6,0.5,3},{999,7.6,0.45,3},{1000,7.6,0.4,3},{1001,8.2,0.5,3}}
local rand=math.random(1,#list)
showPos=list[rand]
else
if showType==1 then
showPos=baoLingShuModel:getShowPosition()
elseif showType==2 then
showPos=qiYuanShuModel:getShowPosition()
end
end
local areaPosY=sectionY[showPos[4]]
local posy=math.random(areaPosY[1],areaPosY[2])/100
local pos=Vector3(showPos[1],posy,-3.5)
self:setChildPosition(self.root:getID(),pos)
self:setChildPosition(self.effect1:getID(),pos)
self:fillItemData(itemid)
self.root:setScale(Vector3.zero)

local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
self.bigItem:setActive(false)
if onlyOne then
self.effect1:setChildShowEffect(10034+color,true)
self:playDotweenAndEffect(showPos,color)
else
timeEventController.delayDo(math.random(),function(...)
if not self:hasObj()then return end
self.effect1:setChildShowEffect(10034+color,true)
self:playDotweenAndEffect(showPos,color)
end)
end
end


function UIBLSRewardHUD:onHide()

end

function UIBLSRewardHUD:playDotweenAndEffect(showPos,color)
timeEventController.delayDo(0.5,function(...)
if not self:hasObj()then return end
self.bigItem:setActive(true)
self:dropReward(showPos)
self.effect2:setChildShowEffect(10039+color,true)
end)
end

function UIBLSRewardHUD:fillItemData(itemid)
local conf={itemid=itemid,showCountBG=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

self.bigItem:setChildPropData(prop)

local item=self:getChildCSGUIBaseItem(self.bigItem:getID())
item:SetChildActive(0,false)
end

function UIBLSRewardHUD:dropReward(showPos)

self.sequence=Lua.SequenceProxy.New()
local scaleTween=self:setChildDOScale(self.root:getID(),1.1,0.4,nil)
self.sequence:Append(scaleTween)
local moveTween=self:setChildDOMove(self.root:getID(),Vector3(showPos[1],showPos[3],-3.5),1.1,nil)
moveTween:SetEase(_Ease.InQuart)
self.sequence:Append(moveTween)
local list={-0.5,0.5}
local rand=math.random(1,#list)
local offsetX=list[rand]
local jumpTween=self:setChildDOJump(self.root:getID(),Vector3(showPos[1]+offsetX,showPos[3],-3.5),1,1,0.8,nil)
jumpTween:SetEase(_Ease.OutBounce)
self.sequence:Append(jumpTween)
end


