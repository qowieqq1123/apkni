







def_class("UIXianGuanPrivilegeTipsWin",UIWindowBase)









function UIXianGuanPrivilegeTipsWin:bindComponents()

self.mask=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.tipsPanel=UIObject.get(self,2)
self.arrowLeft=UIObject.get(self,3)
self.bgWuguan=UIObject.get(self,4)
self.bgWenguan=UIObject.get(self,5)
self.kuang=UIObject.get(self,6)
self.icon=UIImage.get(self,7)
self.name=UIText.get(self,8)
self.descGroup=UIObject.get(self,9)
self.uiRoot=UIObject.get(self,10)
self.arrowRight=UIObject.get(self,11)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIXianGuanPrivilegeTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.mask);self.mask=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tipsPanel);self.tipsPanel=nil;
_UIObject_release(self.arrowLeft);self.arrowLeft=nil;
_UIObject_release(self.bgWuguan);self.bgWuguan=nil;
_UIObject_release(self.bgWenguan);self.bgWenguan=nil;
_UIObject_release(self.kuang);self.kuang=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.descGroup);self.descGroup=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.arrowRight);self.arrowRight=nil;
end















local _this




function UIXianGuanPrivilegeTipsWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
end


function UIXianGuanPrivilegeTipsWin:__delete()
_this=nil
self:unbindComponents()
end




function UIXianGuanPrivilegeTipsWin:onShow(argtable,afterOnloaded)
self.showData=argtable.showData











self.pos=argtable.pos
self.offset=argtable.offset or{0,0}


self.arrowType=argtable.arrowType or 1
self.isCanChangeArrow=argtable.isCanChangeArrow==nil and true or argtable.isCanChangeArrow
self:refresh()
end


function UIXianGuanPrivilegeTipsWin:onHide()

end

function UIXianGuanPrivilegeTipsWin:refresh()

self:refreshTipsPanel()


self:setRootPos()
end

function UIXianGuanPrivilegeTipsWin:refreshTipsPanel()
local args=self.showData
local iconName=args.iconName
local abName=args.abName
local name=args.name
local descList=args.descList or{}
local privilegeId=args.privilegeId
local wenwuType=args.wenwuType
if privilegeId then
local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,privilegeId)
if not iconName then
iconName=xianguanConfig.getTeQuanIconName(privilegeCfg.icon)
abName="ui/icons/xianguantequan/xianguantequan_atlas_pak.ab"
end
name=name or privilegeCfg.name
if privilegeCfg.tipsDesc and not next(descList)then
descList=privilegeCfg.tipsDesc
end
wenwuType=privilegeCfg.wenwuType
end


local isWenGuan=not wenwuType or wenwuType==1
self.bgWenguan:setActive(isWenGuan)
self.bgWuguan:setActive(not isWenGuan)


self.icon:setSprite(abName,iconName)


self.name:setText(name)


local gridsList=self.descGroup:getChildCommonLayoutGroupWidgetList()
for i=1,gridsList.Count do
local widget=gridsList[i-1]
local desc=descList[i]
if desc then
widget:SetChildActive(-1,true)
widget:SetChildText(-1,desc)
else
widget:SetChildActive(-1,false)
end
end
end

function UIXianGuanPrivilegeTipsWin:setRootPos()
self.winlua:ForceLayoutRect(self.tipsPanel:getID())
if self.pos then
local notOffsetPos_x=self.pos[1]or 0
local notOffsetPos_y=self.pos[2]or 0
local originalPos_x=notOffsetPos_x+self.offset[1]
local originalPos_y=notOffsetPos_y+self.offset[2]
local scaleFactor=CS.CSGUIManager.Instance.CanvasScaleValue

local rt=self.uiRoot:getCommonComponent('RectTransform')



local pos_x
local pos_y
local arrowPos_x
local arrowPos_y



local isShowArrow=self.arrowType>0
local isLeftArrow=isShowArrow and self.arrowType~=2
local isCanChangeSide=self.isCanChangeArrow

local itemWidth=self.tipsPanel:getChildRectWidth()
local itemHeight=self.tipsPanel:getChildRectHeight()
local halfItemWidth=itemWidth/2
local halfItemHeight=itemHeight/2
local anchorMinX=rt.anchorMin.x
local anchorMaxX=rt.anchorMax.x
local uiWidth=UnityEngine.Screen.width/scaleFactor.x
local leftOffset=uiWidth*(anchorMinX-0)
local rightOffset=uiWidth*(1-anchorMaxX)
originalPos_x=originalPos_x-leftOffset/2+rightOffset/2
pos_x=originalPos_x
pos_y=originalPos_y

local halfWidth=(uiWidth-leftOffset-rightOffset)/2
local halfHeight=UnityEngine.Screen.height/scaleFactor.y/2
if pos_x-halfItemWidth<-halfWidth then
if not isLeftArrow and isCanChangeSide then
isLeftArrow=true
pos_x=pos_x-self.offset[1]*2+10
if pos_x-halfItemWidth<-halfWidth then
pos_x=-halfWidth+halfItemWidth
end
else
pos_x=-halfWidth+halfItemWidth
end
end
if pos_x+halfItemWidth>halfWidth then
if isLeftArrow and isCanChangeSide then
isLeftArrow=false
pos_x=pos_x-self.offset[1]*2-10
if pos_x+halfItemWidth>halfWidth then
pos_x=halfWidth-halfItemWidth
end
else
pos_x=halfWidth-halfItemWidth
end
end

if pos_y-itemHeight<-halfHeight then
pos_y=-halfHeight+itemHeight
end
if pos_y>halfHeight then
pos_y=halfHeight
end
arrowPos_x=isLeftArrow and-164 or 174
arrowPos_y=-90+originalPos_y-pos_y
if arrowPos_y>-90 then
arrowPos_y=-90
end

self.root:setChildAnchoredPos(pos_x,pos_y)
self.arrowLeft:setActive(isShowArrow and isLeftArrow)
self.arrowRight:setActive(isShowArrow and not isLeftArrow)
if isShowArrow then
if isLeftArrow then
self.arrowLeft:setChildAnchoredPos(arrowPos_x,arrowPos_y)
else
self.arrowRight:setChildAnchoredPos(arrowPos_x,arrowPos_y)
end
end
end
end




function UIXianGuanPrivilegeTipsWin:onMask()
self:closeSelf()
end


function UIXianGuanPrivilegeTipsWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
_this:onMask()
end

function UIXianGuanPrivilegeTipsWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
_this:onMask()
end

function UIXianGuanPrivilegeTipsWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then return end
_this:onMask()
end

