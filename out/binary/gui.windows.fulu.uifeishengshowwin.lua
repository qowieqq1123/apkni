







def_class("UIFeiShengShowWin",UIWindowBase)









function UIFeiShengShowWin:bindComponents()

self.arrowImg=UIObject.get(self,0)
self.attrGrid=UIObject.get(self,1)
self.backEffect=UIObject.get(self,2)
self.disItem=UIObject.get(self,3)
self.predisItem=UIObject.get(self,4)
self.successRoot=UIObject.get(self,5)
self.titleBack=UIObject.get(self,6)



end


function UIFeiShengShowWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrowImg);self.arrowImg=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.disItem);self.disItem=nil;
_UIObject_release(self.predisItem);self.predisItem=nil;
_UIObject_release(self.successRoot);self.successRoot=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
end



















local _this


function UIFeiShengShowWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIFeiShengShowWin:__delete()
_this=nil
self.backEffect:setChildShowEffect(10010,false)
isometricMapSystem:leaveStoryMode()
buildlightController:SetBuildBrightness(false)
self:unbindComponents()
end




function UIFeiShengShowWin:onShow(argtable,afterOnloaded)
self.diziid=argtable.guid
self.oldAttrList=argtable.attrlist
self.backEffect:setChildShowEffect(10010,true)

self:refreshAttrs()
self:refreshHead()
end


function UIFeiShengShowWin:onHide()

end




function UIFeiShengShowWin:refreshHead()
local netData=UIDiscipleModel:getDiscipleData(self.diziid)
local data=UIDiscipleModel:getDiscipleImageInfo(self.diziid)
local color='#efb150'
local name=netData.disciplename
local str=string.format('<color=%s>%s</color>',color,name)

local predisItemWidget=self.predisItem:getChildWidgetBase()
comHelper.setChildModelHeadIconBG(predisItemWidget,0,self.diziid)
comHelper.setChildModelRawImage(predisItemWidget,self.diziid,1,0,eHeadCenterType.eHead,nil,false)
predisItemWidget:SetChildText(3,str)

local disItemWidget=self.disItem:getChildWidgetBase()
comHelper.setChildModelHeadIconBG(disItemWidget,0,self.diziid)
comHelper.setChildModelRawImage(disItemWidget,self.diziid,1,0,eHeadCenterType.eHead,nil,false)
disItemWidget:SetChildText(3,str)
end

function UIFeiShengShowWin:refreshAttrs()
local attrsShow={1,3,2,4}
local attrlist=UIDiscipleModel:getDiscipleMultipleAttrListByType(self.diziid,attrsShow,true)
local gridlist=self.attrGrid:getChildCommonLayoutGroupWidgetList()
local c=gridlist.Count
self.attrNum=c

if c>0 then
for i=1,c do
local item=gridlist[i-1]

if i==1 then
local oldName=UIDiscipleModel:getJJName3(90)
local newName=UIDiscipleModel:getJJName3(91)
item:SetChildText(1,oldName)
item:SetChildText(3,newName)
else
local index=i-1
local attr=attrlist[index]
local oldAttr=self.oldAttrList[index]
local attrType=attr[1]
local newAttrValue=mathHelper.formatNumber9(attr[2],1)
local oldAttrValue=oldAttr[2]

local color_str='{0}: {1}'

item:SetChildText(1,helper.getAttributeStr2(attrType,oldAttrValue,nil,color_str))
item:SetChildText(3,newAttrValue)
end
end
end
self:doMyAnim()
end

function UIFeiShengShowWin:onClickClose()
isometricMapSystem:leaveStoryMode()
buildlightController:SetBuildBrightness(false)
self:closeSelf()
end

function UIFeiShengShowWin:doMyAnim()
local delay=0
self.titleBack:setScale(Vector3(2,2,2))
self.titleBack:setChildDOScale(1,0.15)

_this.disItemWidget=self.disItem:getChildWidgetBase()
_this.predisItemWidget=self.predisItem:getChildWidgetBase()

delay=delay+0.15

local predisItemPos=self.predisItem:getChildLocalPosition()
self.predisItem:setLocalPosX(0)
self.predisItem:setChildCanvasGroupDOFade(1,0.1)
self.predisItem:setChildDOLocalMoveX(predisItemPos.x,0.2,function()
if _this==nil then return end
_this.predisItemWidget:SetChildCanvasGroupDOFade(2,1,0.2)

end)

local disItemPos=self.disItem:getChildLocalPosition()
self.disItem:setLocalPosX(0)
self.disItem:setChildCanvasGroupDOFade(1,0.1)
self.disItem:setChildDOLocalMoveX(disItemPos.x,0.2,function()
if _this==nil then return end
_this.disItemWidget:SetChildCanvasGroupDOFade(2,1,0.2)
end)

delay=delay+0.1

self.attrGrid:setActive(true)
for i=1,self.attrNum do
local item=self.attrGrid:getChildCommonLayoutGroupWidgetItem(i-1)
item:SetChildActive(-1,false)
local pos=item:GetChildLocalPosition(-1)
item:SetChildLocalPosY(-1,pos.y-200)
self:delayDo(delay,function()
item:SetChildActive(-1,true)
item:SetChildDOLocalMoveY(-1,pos.y,0.2)
end)
delay=delay+0.1
end


delay=delay+0.3
self:delayDo(delay,function()

end)
end