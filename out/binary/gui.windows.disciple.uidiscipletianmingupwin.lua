







def_class("UIDiscipleTianMingUpWin",UIWindowBase)









function UIDiscipleTianMingUpWin:bindComponents()

self.root=UIObject.get(self,0)
self.tianmingNameTxt=UIText.get(self,1)
self.tianmingDescTxt=UIText.get(self,2)
self.tianmingIcon=UIImage.get(self,3)
self.titleBack=UIObject.get(self,4)
self.predisItem=UIObject.get(self,5)
self.disItem=UIObject.get(self,6)
self.attrGrid=UIObject.get(self,7)
self.tianmingObj=UIObject.get(self,8)
self.successEffect=UIObject.get(self,9)
self.arrowImg=UIObject.get(self,10)
self.imgbg2=UIObject.get(self,11)



end


function UIDiscipleTianMingUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tianmingNameTxt);self.tianmingNameTxt=nil;
_UIObject_release(self.tianmingDescTxt);self.tianmingDescTxt=nil;
_UIObject_release(self.tianmingIcon);self.tianmingIcon=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.predisItem);self.predisItem=nil;
_UIObject_release(self.disItem);self.disItem=nil;
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.tianmingObj);self.tianmingObj=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.arrowImg);self.arrowImg=nil;
_UIObject_release(self.imgbg2);self.imgbg2=nil;
end






















local _this


function UIDiscipleTianMingUpWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIDiscipleTianMingUpWin:__delete()
self.successEffect:setChildShowEffect(10010,false)
self:unbindComponents()
if _this.showfloor_new then
UIManager:showWindow('UIDiscipleTianMingUpSkillWin',{dis_guid=self.dis_guid_next,tmlv=self.tmlv_next,oldtmlv=self.oldtmlv_next})
else
local isUnlockDY=UIDiscipleModel:getDiscipleDaoYanUnLockReddot(self.dis_guid_next)
if isUnlockDY then
UIManager:invokeUIMethod('UIDiscipleTianMingWin','onUnlockDY',self.dis_guid_next)
end
end
_this=nil
end


function UIDiscipleTianMingUpWin:onHide()

end

function function_name(...)

end




function UIDiscipleTianMingUpWin:onShow(argtable,afterOnloaded)
local dis_guid
local tmlv
local oldtmlv
self.imgbg2:setActive(true)

if argtable[1]and argtable[1]==-1 then
local disciplesList=discipleLookup:getSortDiscipleList()
local netdata=disciplesList[1].netData
local guid=netdata.net.discipleguid
for k,v in ipairs(disciplesList)do
netdata=disciplesList[1].netData
guid=netdata.net.discipleguid
local tmLv=UIDiscipleModel:getTianMingLevel(guid)
if tmLv>0 then
guid=netdata.net.discipleguid
break
end
end
dis_guid=guid
tmlv=4
oldtmlv=3
self.newoldattrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(dis_guid,false)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
netData.tmlv=tmlv
UIDiscipleModel:setDiscipleAttrListDirty(netData,DISCIPLE_ATTRIBUTE_TYPE.eTianMing,true)
UIDiscipleModel:setSkillReplaceLookupDirty(netData)
self.newattrLookup=UIDiscipleModel:getDiscipleMultipleAttrLookup(dis_guid,false)
self.dis_guid_next=dis_guid
self.tmlv_next=tmlv
self.oldtmlv_next=oldtmlv
else
dis_guid=argtable.dis_guid
tmlv=argtable.tmlv
oldtmlv=argtable.oldtmlv
self.dis_guid_next=dis_guid
self.tmlv_next=tmlv
self.oldtmlv_next=oldtmlv
end

self.successEffect:setChildShowEffect(10010,true)

local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
local attrLookup=self.newoldattrLookup or argtable.attrLookup
local attrlist=UIDiscipleModel.getAttrListByType(attrLookup,attrsBase,true,true)
local oldattrLookup=self.newattrLookup or argtable.oldattrLookup
local oldattrlist=UIDiscipleModel.getAttrListByType(oldattrLookup,attrsBase,true,true)

self.tmlv=tmlv
self.oldtmlv=oldtmlv
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local oldfloor=UIDiscipleModel.getTianMingLevelFloor(oldtmlv)

self.rootWidget=self.root:getChildWidgetBase()

local predisItemWidget=self.predisItem:getChildWidgetBase()
self.predisItemWidget=predisItemWidget


comHelper.setChildModelHeadIconBG(predisItemWidget,0,dis_guid)
comHelper.setChildModelRawImage(predisItemWidget,dis_guid,1,0,eHeadCenterType.eHead)
local pre_chong=UIDiscipleModel.getTianMingLevelChongEx(oldtmlv)
if pre_chong>0 then
local floor=UIDiscipleModel.getTianMingLevelFloor(oldtmlv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local grids=predisItemWidget:GetChildCommonLayoutGroupWidgetList(2)
for i=1,3 do
local item=grids[i-1]
local isActive=i<=pre_chong
item:SetChildActive(-1,isActive)
if isActive then
item:SetChildCSImageSprite(0,abName,iconName)
end
end
end
predisItemWidget:SetChildCanvasGroupAlpha(2,0)
self.predisItem:setChildCanvasGroupAlpha(0)


local disItemWidget=self.disItem:getChildWidgetBase()
self.disItemWidget=disItemWidget


comHelper.setChildModelHeadIconBG(disItemWidget,0,dis_guid)
comHelper.setChildModelRawImage(disItemWidget,dis_guid,1,0,eHeadCenterType.eHead)
local chong=UIDiscipleModel.getTianMingLevelChongEx(tmlv)
if chong>0 then
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local grids=disItemWidget:GetChildCommonLayoutGroupWidgetList(2)
for i=1,3 do
local item=grids[i-1]
local isActive=i<=chong
item:SetChildActive(-1,isActive)
if isActive then
item:SetChildCSImageSprite(0,abName,iconName)
end
end
end
disItemWidget:SetChildCanvasGroupAlpha(2,0)
self.predisItem:setChildCanvasGroupAlpha(0)

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
local oldattrValue=oldattr[2]
item:SetChildText(1,helper.getAttributeStr(attrType,oldattrValue,nil,'{0}：       {1}'))

local isadd=true
item:SetChildActive(2,isadd)
item:SetChildActive(3,isadd)
if isadd then
item:SetChildText(3,helper.getAttributeStrEx(attrType,attrValue,nil))
end
end
if i==#attrlist+1 then
item:SetChildActive(0,true)
attrNum=attrNum+1
local tmcfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,oldtmlv)
local next_tmcfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,tmlv)
local isFull=next_tmcfg==nil
if not isFull then
local rate_str=FMT.fmt('<color=#efb150>境界属性：{0}%</color>',tmcfg.percent)
local nextrate_str=FMT.fmt('<color=#efb150>{0}%</color>',next_tmcfg.percent)
item:SetChildText(1,rate_str)
item:SetChildActive(2,true)
item:SetChildText(3,nextrate_str)
end
end
end
self.attrNum=attrNum
self.attrGrid:setActive(false)

_this.showfloor_new=floor~=oldfloor and floor<5
local showfloor=false
self.tianmingObj:setActive(showfloor)
if showfloor then
local tmIndex=floor+1
local jobid=UIDiscipleModel:getDiscipleJob(dis_guid)
local tmID=UIDiscipleModel:getTianMingByIndex(dis_guid,tmIndex)
local tmcfg=nil
if tmID then
tmcfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
end

local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
self.tianmingIcon:setSprite(abName,iconName)

local name_str
if tmIndex==6 then
name_str=UIDiscipleModel.getTianMingName('赐福')
else
local name=tmcfg.name
name_str=UIDiscipleModel.getTianMingName(name)
end
self.tianmingNameTxt:setText(name_str)

local desc_str=UIDiscipleModel.getTianMingDesc(tmcfg,jobid)
self.tianmingDescTxt:setText(desc_str)
end
self.showfloor=showfloor
if showfloor then
self.tianmingObj:setActive(false)
end

self:doMyAnim()
end

function UIDiscipleTianMingUpWin:doMyAnim()
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

if self.showfloor then
self.tianmingObj:setActive(true)
for i=1,3 do
local idx=i-1
local pos=self.rootWidget:GetChildLocalPosition(idx)
self.rootWidget:SetChildActive(idx,false)
local pos=self.rootWidget:GetChildLocalPosition(idx)
self.rootWidget:SetChildLocalPosY(idx,pos.y-200)
self:delayDo(delay,function()
self.rootWidget:SetChildActive(idx,true)
self.rootWidget:SetChildDOLocalMoveY(idx,pos.y,0.2)
end)
delay=delay+0.1
end
end

delay=delay+0.3
self:delayDo(delay,function()
self.imgbg2:setActive(false)
end)
end
