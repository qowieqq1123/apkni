







def_class("UIDiscipleDaoYanUpWin",UIWindowBase)









function UIDiscipleDaoYanUpWin:bindComponents()

self.arrowImg=UIObject.get(self,0)
self.attrGrid=UIObject.get(self,1)
self.disItem=UIObject.get(self,2)
self.effDY=UIObject.get(self,3)
self.effDYDi=UIObject.get(self,4)
self.imgbg2=UIObject.get(self,5)
self.mbg=UIObject.get(self,6)
self.predisItem=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.successEffect=UIObject.get(self,9)
self.titleBack=UIObject.get(self,10)



end


function UIDiscipleDaoYanUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrowImg);self.arrowImg=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.disItem);self.disItem=nil;
_UIObject_release(self.effDY);self.effDY=nil;
_UIObject_release(self.effDYDi);self.effDYDi=nil;
_UIObject_release(self.imgbg2);self.imgbg2=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.predisItem);self.predisItem=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
end



















local _this


function UIDiscipleDaoYanUpWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIDiscipleDaoYanUpWin:__delete()
self.successEffect:setChildShowEffect(10010,false)
self:unbindComponents()
_this=nil
end




function UIDiscipleDaoYanUpWin:onShow(argtable,afterOnloaded)
self.imgbg2:setActive(true)

local dis_guid=argtable.dis_guid
local dylv=argtable.dylv
local olddylv=argtable.olddylv
self.dis_guid_next=dis_guid
self.dylv_next=dylv
self.olddylv_next=olddylv

local _bgModelIds={6188,6189,6190}
local animationIds={eAnimationID.enter,eAnimationID.enter2,eAnimationID.enter3}
local cur_chong=UIDiscipleModel.getDaoYanLevelFloor(dylv)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(_bgModelIds[cur_chong],0.85,nil,animationIds[cur_chong],false,false,0)

self.winlua:SetChildShowEffect(self.effDY:getID(),0,false)
self.winlua:SetChildShowEffect(self.effDYDi:getID(),0,false)
if dylv>0 then
local effId,effId2=UIDiscipleModel:getDiscipleDaoYanDZJYEffectId(cur_chong)
self.winlua:SetChildShowEffect(self.effDY:getID(),effId,true)
self.winlua:SetChildShowEffect(self.effDYDi:getID(),effId2,true)
end

self.successEffect:setChildShowEffect(10010,true)

local oldattrlist=UIDiscipleModel:getDaoYanAttrByGuid(dis_guid,olddylv)
local attrlist=UIDiscipleModel:getDaoYanAttrByGuid(dis_guid,dylv)

self.dylv=dylv
self.olddylv=olddylv
local desc=UIDiscipleModel.getDaoYanLevelDesc(dylv)
local olddesc=UIDiscipleModel.getDaoYanLevelDesc(olddylv)


local predisItemWidget=self.predisItem:getChildWidgetBase()
predisItemWidget:SetChildText(0,olddesc)
self.predisItem:setChildCanvasGroupAlpha(0)


local disItemWidget=self.disItem:getChildWidgetBase()
disItemWidget:SetChildText(0,desc)
self.disItem:setChildCanvasGroupAlpha(0)

self.arrowImg:setChildCanvasGroupAlpha(0)

local attrNum=0
local gridlist=self.attrGrid:getChildCommonLayoutGroupWidgetList()
local c=gridlist.Count
for i=1,5 do
local item=gridlist[i-1]
local attr=attrlist[i]
local oldattr=oldattrlist[i]
local show=attr~=nil or i>c
item:SetChildActive(0,show)
if show then
attrNum=attrNum+1
local attrType=attr[1]
local attrValue=attr[2]
local oldattrValue=oldattr and(oldattr[2]or 0)or 0
item:SetChildText(1,helper.getAttributeStr(attrType,oldattrValue,nil,'{0}：{1}'))
item:SetChildText(3,helper.getAttributeStr(attrType,attrValue,nil,'{0}：{1}'))
end
end
self.attrNum=attrNum
self.attrGrid:setActive(false)

local skillList=UIDiscipleModel:getDaoYanSkillByGuid(dis_guid)
for i,v in ipairs(skillList)do
if v[2]==dylv then
_this.newSkillIdx=i
break
end
end
self:doMyAnim()

end


function UIDiscipleDaoYanUpWin:onHide()

end

function UIDiscipleDaoYanUpWin:doMyAnim()
local delay=0
self.titleBack:setScale(Vector3(2,2,2))
self.titleBack:setChildDOScale(1,0.15)
delay=delay+0.15

self:delayDo(delay,function()
_this.predisItem:setChildCanvasGroupDOFade(1,0.2)
end)
delay=delay+0.2

self:delayDo(delay,function()
if _this==nil then return end
_this.disItem:setChildCanvasGroupDOFade(1,0.2)
end)

delay=delay+0.2

self:delayDo(delay,function()
if _this==nil then return end
_this.arrowImg:setChildCanvasGroupDOFade(1,0.2)
end)

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
self.imgbg2:setActive(false)
end)
end





function UIDiscipleDaoYanUpWin:onCloseBtn()
if self.newSkillIdx then
self.titleBack:setActive(false)
self.root:setActive(false)
UIManager:showWindow('UIDiscipleDaoYanUpSkillWin',{dis_guid=self.dis_guid_next,dylv=self.dylv_next,olddylv=self.olddylv_next,newSkillIdx=_this.newSkillIdx,openFunc=function()
if not _this then return end
_this:closeSelf()
end})
else
self:closeSelf()
end
end

