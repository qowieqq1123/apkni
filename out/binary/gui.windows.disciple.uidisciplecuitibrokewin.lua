







def_class("UIDiscipleCuiTiBrokeWin",UIWindowBase)









function UIDiscipleCuiTiBrokeWin:bindComponents()

self.root=UIObject.get(self,0)
self.cuitiEffect=UIObject.get(self,1)
self.ctSpineNew=UIObject.get(self,2)
self.uiPanel=UIObject.get(self,3)
self.successEffect=UIObject.get(self,4)
self.levelTxt=UIText.get(self,5)
self.levelNextTxt=UIText.get(self,6)
self.arrowImg=UIObject.get(self,7)
self.attrGrid=UIObject.get(self,8)
self.titleBack=UIObject.get(self,9)



end


function UIDiscipleCuiTiBrokeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.cuitiEffect);self.cuitiEffect=nil;
_UIObject_release(self.ctSpineNew);self.ctSpineNew=nil;
_UIObject_release(self.uiPanel);self.uiPanel=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.levelTxt);self.levelTxt=nil;
_UIObject_release(self.levelNextTxt);self.levelNextTxt=nil;
_UIObject_release(self.arrowImg);self.arrowImg=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
end

















local _this


function UIDiscipleCuiTiBrokeWin:onLoaded(...)
_this=self
self:bindComponents()
local pos=self:getChildCanvas(-1)
self.ctSpineNew:setChildCanvas(pos[1],pos[2]+2)
self.uiPanel:setChildCanvas(pos[1],pos[2]+3)
end


function UIDiscipleCuiTiBrokeWin:__delete()
_this=nil
self.successEffect:setChildShowEffect(10010,false)
self:unbindComponents()
end


function UIDiscipleCuiTiBrokeWin:onHide()

end




function UIDiscipleCuiTiBrokeWin:onShow(argtable,afterOnloaded)
local dis_guid=argtable.dis_guid
local ctlv=argtable.ctlv
local oldctlv=argtable.oldctlv
self.ctlv=ctlv

self.successEffect:setChildShowEffect(10010,true)

local spineid2,effectid2=UIDiscipleModel:getCuiTiFloorSpine(ctlv)
self.ctSpineNew:setChildUIModelShowTarget(spineid2,0.25,{},2040,false,false,0,function()
if _this==nil then return end
_this:delayDo(0.8,function()
_this.cuitiEffect:setChildShowEffect(effectid2,true)
end)
end)

local ctlv_str=UIDiscipleModel:getCuiTiNameEx(ctlv,2)
local oldctlv_str=UIDiscipleModel:getCuiTiNameEx(oldctlv,2)
self.levelTxt:setText(oldctlv_str)
self.levelNextTxt:setText(ctlv_str)
self.levelTxt:setActive(false)
self.levelNextTxt:setActive(false)

local lookup2=UIDiscipleModel:getDiscipleAttrLookupX(dis_guid,DISCIPLE_ATTRIBUTE_TYPE.eQiZhen)
local rate2=UIDiscipleModel:getDZQiZhan2LianTianRate(dis_guid)
local attrlist=UIDiscipleModel.getDZCuiTiAttrChangeEx(oldctlv,ctlv,lookup2,rate2)
local attrGridList=self.attrGrid:getChildCommonLayoutGroupWidgetList()
for i=1,4 do
local item=attrGridList[i-1]
local attr=attrlist[i]
local isshow=attr~=nil
item:SetChildActive(-1,isshow)
if isshow then
local attrID=attr[1]
local attrValue=attr[2]
local addValue=attr[3]
local isadd=addValue>0
item:SetChildActive(2,isadd)
if attrID~=-1 then
item:SetChildText(0,FMT.fmt('{0}：',helper.getAttributeName(attrID)))
item:SetChildText(1,attrValue)
if isadd then
item:SetChildText(3,addValue)
end
else
item:SetChildText(0,'炼体属性：')
item:SetChildText(1,FMT.fmt('{0}%',attrValue))
if isadd then
item:SetChildText(3,FMT.fmt('{0}%',addValue))
end
end
end
end
self.attrNum=#attrlist
self.attrGrid:setActive(false)

self:doMyAnim()
end

function UIDiscipleCuiTiBrokeWin:doMyAnim()
local delay=0
self.titleBack:setScale(Vector3(2,2,2))
self.titleBack:setChildDOScale(1,0.15)
delay=delay+0.15

self:delayDo(delay,function()
self.levelTxt:setActive(true)
self.levelNextTxt:setActive(true)
self.arrowImg:setActive(true)
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
end