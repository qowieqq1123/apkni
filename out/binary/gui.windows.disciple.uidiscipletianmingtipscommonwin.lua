







def_class("UIDiscipleTianMingTipsCommonWin",UIWindowBase)









function UIDiscipleTianMingTipsCommonWin:bindComponents()

self.changeroot=UIObject.get(self,0)
self.changeScrollView=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.specialityInfo=UIObject.get(self,3)
self.speScrollView=UIObject.get(self,4)



end


function UIDiscipleTianMingTipsCommonWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.changeroot);self.changeroot=nil;
_UIObject_release(self.changeScrollView);self.changeScrollView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.specialityInfo);self.specialityInfo=nil;
_UIObject_release(self.speScrollView);self.speScrollView=nil;
end















local _this=nil



function UIDiscipleTianMingTipsCommonWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleTianMingTipsCommonWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDiscipleTianMingTipsCommonWin:onShow(argtable,afterOnloaded)
self.tmList=argtable.tmList
self.job=argtable.job or 0
self.align=argtable.align
self.postion=argtable.position
self.anchors=argtable.anchors
self.pivot=argtable.pivot

if self.anchors then
self.winlua:SetChildAnchors(self.root:getID(),self.anchors.min,self.anchors.max)
end
if self.pivot then
self.winlua:SetChildPivot(self.root:getID(),self.pivot)
end
if self.postion then
self.winlua:SetChildAnchoredPosition(self.root:getID(),self.postion)
elseif self.align then
local widget=self.align.widget
local index=self.align.index
local pivot=self.align.pivot
local screenPos=widget:GetChildUIScreenPos(index)
local rect=widget:GetCommonComponent(index,"RectTransform").rect
local temp=Vector2.New(screenPos.x,screenPos.y)+(rect.min+rect.max)/2
if pivot then
temp=temp+Vector2.New((pivot.x-0.5)*rect.width,(pivot.y-0.5)*rect.height)
end
self.root:setChildUIScreenPos(temp)
end

self.speScrollView:setChildScrollRectEnable(false)
self.changeScrollView:setChildScrollRectEnable(false)
self:delayDo(0.25,function()
self.speScrollView:setChildScrollRectEnable(true)
self.changeScrollView:setChildScrollRectEnable(true)
end)

self:refreshScrollView()
self:refreshChangeView()
end


function UIDiscipleTianMingTipsCommonWin:onHide()

end




function UIDiscipleTianMingTipsCommonWin:refreshScrollView()
self.specialityInfo:setChildLayoutGroupCreateItems(#self.tmList,function(index)
self:refreshItem(nil,index)
end)
self.winlua:ForceLayoutRect(self.speScrollView:getID())
end

function UIDiscipleTianMingTipsCommonWin:refreshItem(item,idx)
if item==nil then
item=self.specialityInfo:getChildLayoutGroupGridItem(idx-1)
end

local tmID=self.tmList[idx]
local tmcfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
if tmcfg==nil then
loggerUtil.logErrFMT("没有对应的天命ID:{0}",tmID)
return
end

local tmnane=tmcfg.name
local name_str=FMT.fmt("【{0}】",tmnane)
name_str=toColorString(FONT_COLOR.eTipWhiteColor,name_str)
item:SetChildText(0,name_str)

local desc_str=UIDiscipleModel.getTianMingDesc(tmcfg,self.job)
desc_str=toColorString(FONT_COLOR.eTipWhiteColor,desc_str)
item:SetChildText(1,desc_str)
end

function UIDiscipleTianMingTipsCommonWin:refreshChangeView()

local stateList={}
local changeStateList={}
for i=1,5 do
local tmID=self.tmList[i]
if tmID then
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmID)
local descEx=tmCfg.descEx
if descEx~=nil or#(descEx or{})>0 then
for idx,data in ipairs(descEx)do
local temp={}
local topStr=string.match(data[1],"【(.-)】")
if topStr then
temp.stateName=topStr
temp.stateIconId=data[2]
temp.stateType=data[3]
local _,el=string.find(data[1],FMT.fmt('【{0}】',topStr))
temp.desc=string.sub(data[1],el+1)
local nameColor=data[3]==1 and"#5ac0e2"or"#f36666"
temp.stateName=FMT.fmt("<color={0}>{1}</color>",nameColor,temp.stateName)

stateList[topStr]=temp
end
end
end
end
end
for i,v in pairs(stateList)do
table.insert(changeStateList,v)
end
local isHasFT=changeStateList~=nil and#changeStateList>0
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
end)
end
end