







def_class("UIDiscipleTianMingTipsTwoWin",UIWindowBase)









function UIDiscipleTianMingTipsTwoWin:bindComponents()

self.root=UIObject.get(self,0)
self.specialityInfo=UIObject.get(self,1)
self.descSlot=UIObject.get(self,2)
self.speScrollView=UIObject.get(self,3)
self.changeroot=UIObject.get(self,4)
self.changeScrollView=UIObject.get(self,5)



end


function UIDiscipleTianMingTipsTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.specialityInfo);self.specialityInfo=nil;
_UIObject_release(self.descSlot);self.descSlot=nil;
_UIObject_release(self.speScrollView);self.speScrollView=nil;
_UIObject_release(self.changeroot);self.changeroot=nil;
_UIObject_release(self.changeScrollView);self.changeScrollView=nil;
end

















function UIDiscipleTianMingTipsTwoWin:onLoaded(...)
self:bindComponents()
end


function UIDiscipleTianMingTipsTwoWin:__delete()
self:unbindComponents()
end


function UIDiscipleTianMingTipsTwoWin:onHide()
end




function UIDiscipleTianMingTipsTwoWin:onShow(argtable,afterOnloaded)
local config=argtable.config
self.jobid=argtable.jobid
self.tmlv=argtable.tmlv
self.tmList=argtable.tmList
local item=argtable.item
local directionType=argtable.directionType

self.speScrollView:setChildScrollRectEnable(false)
self:delayDo(0.25,function()
self.speScrollView:setChildScrollRectEnable(true)
end)

local speItem=self.descSlot:getChildWidgetBase()
UIDiscipleModel.refreshSpecialityItem(speItem,config,nil)

local grids=self.specialityInfo:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local descItem=grids[i-1]
self:refreshItem(descItem,i)
end


local stateList={}
local changeStateList={}
for i=1,5 do
local tmID=self.tmList[i]
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
local descEx=tmCfg.descEx
if descEx~=nil or#(descEx or{})>0 then
for idx,data in ipairs(descEx)do
local temp={}
local topStr=string.match(data[1],"【(.-)】")
if pfwindowslController:checkIsGameVersion_oumei()then
topStr=string.match(data[1],"%[(.-)%]")
end
if topStr then
temp.stateName=topStr
temp.stateIconId=data[2]
temp.stateType=data[3]

local line=FMT.fmt("【{0}】",topStr)
if pfwindowslController:checkIsGameVersion_oumei()then
line=FMT.fmt("%[{0}%]",topStr)
end
local _,el=string.find(data[1],line)

temp.desc=string.sub(data[1],el+1)
local nameColor=data[3]==1 and"#5ac0e2"or"#f36666"
temp.stateName=FMT.fmt("<color={0}>{1}</color>",nameColor,temp.stateName)
temp.gongFaTypeIcon=data[4]
stateList[topStr]=temp
end
end
end
end
for i,v in pairs(stateList)do
table.insert(changeStateList,v)
end

self.changeScrollView:setChildScrollRectEnable(false)
self:delayDo(0.25,function()
self.changeScrollView:setChildScrollRectEnable(true)
end)

local isHasFT=changeStateList~=nil and#(changeStateList or{})>0
self.changeScrollView:setActive(isHasFT)
if isHasFT then
self.changeroot:setChildLayoutGroupCreateItems(#changeStateList,function(index)
local item=self.changeroot:getChildLayoutGroupGridItem(index-1)
local data=changeStateList[index]
local stateIcon=data.stateType==1 and"icon_zengyi"or"icon_jianyi"
item:SetChildText(1,data.stateName)
item:SetChildIcon(0,iconHelper.getBuffIcon(data.stateIconId),false)
item:SetChildText(3,data.desc)
item:SetChildCSImageSprite(2,globalABLookup.global,stateIcon)

item:SetChildActive(4,data.gongFaTypeIcon~=nil)
if data.gongFaTypeIcon then
item:SetChildIcon(4,string.format('icon_gong_fa_type_%d',data.gongFaTypeIcon),true)
end
end)
end
self:showPosition(item,directionType,isHasFT)
end

function UIDiscipleTianMingTipsTwoWin:refreshItem(item,idx)
if item==nil then
item=self.specialityInfo:getChildCommonLayoutGroupWidgetItem(groupIdx-1)
end

local tmlv=self.tmlv
local tmIndex=idx

local isActive,need_tmlv
if tmIndex==6 then
isActive,need_tmlv=UIDiscipleModel.checkTiamMingCiFuPosOpenX(tmlv,1)
elseif tmIndex>6 then
isActive,need_tmlv=UIDiscipleModel:checkTianMingFloorActive(tmlv,tmIndex-1)
else
isActive,need_tmlv=UIDiscipleModel:checkTianMingFloorActive(tmlv,tmIndex)
end


local floor=UIDiscipleModel.getTianMingLevelFloor(need_tmlv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
item:SetChildCSImageSprite(0,abName,iconName)

local tmcfg=nil
if tmIndex<6 then
local tmID=self.tmList[tmIndex]
tmcfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
end

local name_str
if tmIndex==6 then
name_str=UIDiscipleModel.getTianMingName('赐福')
else
local name=tmcfg.name
name_str=UIDiscipleModel.getTianMingName(name)
end
if isActive then
name_str=toColorString(FONT_COLOR.eTipWhiteColor,name_str)
end
item:SetChildText(1,name_str)

local desc_str=UIDiscipleModel.getTianMingDesc(tmcfg,self.jobid)
if isActive then
desc_str=toColorString(FONT_COLOR.eTipWhiteColor,desc_str)
end
item:SetChildText(2,desc_str)
end

function UIDiscipleTianMingTipsTwoWin:showPosition(item,directionType,isHasFT)

local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)
local itemTrans=item.transform
local itemSize=itemTrans.sizeDelta
local itemPivot=itemTrans.pivot

local selfTrans=self.root:getTransform()
local selfSize=selfTrans.sizeDelta

local itemOffx=0
local itemOffy=0
local offsetX=0
local offsetY=0
directionType=directionType or eDirectionType.eLeft
if directionType==eDirectionType.eBottom or directionType==eDirectionType.eTop then
if itemPivot.x~=0.5 then
itemOffx=itemPivot.x==0 and itemSize.x/2 or-itemSize.x/2
end
offsetX=itemOffx
elseif directionType==eDirectionType.eLeft or directionType==eDirectionType.eRight then
if itemPivot.y~=0.5 then
itemOffy=itemPivot.y==0 and itemSize.y/2 or-itemSize.y/2
end
offsetY=itemOffy
end

if directionType==eDirectionType.eBottom then
if itemPivot.y~=0 then
itemOffy=itemPivot.y==0.5 and-itemSize.y/2 or-itemSize.y
end
offsetY=-selfSize.y/2+itemOffy
elseif directionType==eDirectionType.eTop then
if itemPivot.y~=1 then
itemOffy=itemPivot.y==0.5 and itemSize.y/2 or itemSize.y
end
offsetY=selfSize.y/2+itemOffy
elseif directionType==eDirectionType.eLeft then
if itemPivot.x~=0 then
itemOffx=itemPivot.x==0.5 and-itemSize.x/2 or-itemSize.x
end
offsetX=-selfSize.x/2+itemOffx
elseif directionType==eDirectionType.eRight then
if itemPivot.x~=1 then
itemOffx=itemPivot.x==0.5 and itemSize.x/2 or itemSize.x
end
offsetX=selfSize.x/2+itemOffx
end
local rootPosX=screenPoint.x+offsetX
local rootPosY=screenPoint.y+offsetY
if isHasFT and rootPosX>-30 then
self.winlua:SetChildLocalPosition(self.root:getID(),Vector3(-200,0,0))
else
self.winlua:SetChildLocalPosition(self.root:getID(),Vector3(rootPosX,0,0))
end
end