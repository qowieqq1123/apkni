







def_class("UIDiscipleShuWuUpWin",UIWindowBase)









function UIDiscipleShuWuUpWin:bindComponents()

self.root=UIObject.get(self,0)
self.imgbg2=UIObject.get(self,1)
self.effect=UIObject.get(self,2)
self.titleBack=UIObject.get(self,3)
self.arrowImg=UIObject.get(self,4)
self.predisItem=UIObject.get(self,5)
self.disItem=UIObject.get(self,6)
self.attrScrollView=UIObject.get(self,7)
self.successEffect=UIObject.get(self,8)



end


function UIDiscipleShuWuUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.imgbg2);self.imgbg2=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.arrowImg);self.arrowImg=nil;
_UIObject_release(self.predisItem);self.predisItem=nil;
_UIObject_release(self.disItem);self.disItem=nil;
_UIObject_release(self.attrScrollView);self.attrScrollView=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
end
















local _this




function UIDiscipleShuWuUpWin:onLoaded(...)
self:bindComponents()
_this=self

self.attrScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIDiscipleShuWuUpWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleShuWuUpWin:onShow(argtable,afterOnloaded)
local dis_guid=argtable.dzId
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
local level=netData.qiaojianglv

self.imgbg2:setActive(true)

self.successEffect:setChildShowEffect(10010,true)

local predisItemWidget=self.predisItem:getChildWidgetBase()
self.predisItemWidget=predisItemWidget
comHelper.setChildModelHeadIconBG(predisItemWidget,0,dis_guid)
comHelper.setChildModelRawImage(predisItemWidget,dis_guid,1,0,eHeadCenterType.eHead)

local disItemWidget=self.disItem:getChildWidgetBase()
self.disItemWidget=disItemWidget
comHelper.setChildModelHeadIconBG(disItemWidget,0,dis_guid)
comHelper.setChildModelRawImage(disItemWidget,dis_guid,1,0,eHeadCenterType.eHead)

predisItemWidget:SetChildCanvasGroupAlpha(2,0)
disItemWidget:SetChildCanvasGroupAlpha(2,0)
self.predisItem:setChildCanvasGroupAlpha(0)

local attrs=self:countAttr(netData.id,level-1)
local len=#attrs
self.attrScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.attrScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=attrs[i]
if data.htype==-1 then
item:SetChildText(0,data.stageName1)
item:SetChildText(2,data.stageName2)
elseif data.htype==9 then
item:SetChildText(0,FMT.fmt('炼丹效率：       {0}%',math.abs(data.percent)))
item:SetChildText(2,FMT.fmt('{0}%',math.abs(data.next)))
else
local ptname=moneyModel.getMoneyName(data.ptype)
item:SetChildText(0,FMT.fmt('{0}产量：       {1}%',ptname,data.percent))
item:SetChildText(2,FMT.fmt('{0}%',data.next))
end
end

self:doMyAnim()
end


function UIDiscipleShuWuUpWin:onHide()

end

function UIDiscipleShuWuUpWin:countAttr(id,qjLevel)
local bonus=cfgHelper.get2(cfg_discipleqiaojiangconfig_get,qjLevel,'bonus')
local attrs=bonus[id]
local nextcfg=cfgHelper.get1(cfg_discipleqiaojiangconfig_get,qjLevel+1)
local nextAttr=nextcfg and nextcfg.bonus[id]
local list={}
local cfg=UIDiscipleModel:getShuWuDZConfig(id)
for i,v in ipairs(attrs)do
local ptype=cfg.produceType
local data={
htype=v[1],
ptype=ptype,
percent=v[3],
}
if nextAttr then
data.next=nextAttr[i][3]
end
list[#list+1]=data
end
local swcfg=UIDiscipleModel:getShuWuDZConfig(id)












local sname1=UIDiscipleModel:getShuWuQJLevelFullName(swcfg.bdId,qjLevel)
local sname2=UIDiscipleModel:getShuWuQJLevelFullName(swcfg.bdId,qjLevel+1)
if sname1~=sname2 then
local data={
htype=-1,
stageName1=sname1,
stageName2=sname2,
}
list[#list+1]=data
end
return list
end

function UIDiscipleShuWuUpWin:doMyAnim()
local delay=0
self.titleBack:setScale(Vector3(2,2,2))
self.titleBack:setChildDOScale(1,0.15)
delay=delay+0.15

local predisItemPos=self.predisItem:getChildLocalPosition()
self.predisItem:setLocalPosX(0)
self.predisItem:setChildCanvasGroupDOFade(1,0.1)
self.predisItem:setChildDOLocalMoveX(predisItemPos.x,0.2,function()
if _this==nil then return end
_this.predisItemWidget:SetChildCanvasGroupDOFade(2,1,0.2)
_this.arrowImg:setActive(true)
end)

local disItemPos=self.disItem:getChildLocalPosition()
self.disItem:setLocalPosX(0)
self.disItem:setChildCanvasGroupDOFade(1,0.1)
self.disItem:setChildDOLocalMoveX(disItemPos.x,0.2,function()
if _this==nil then return end
_this.disItemWidget:SetChildCanvasGroupDOFade(2,1,0.2)
end)

delay=delay+0.1

delay=delay+0.3
self:delayDo(delay,function()
self.imgbg2:setActive(false)
end)
end



