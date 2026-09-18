







def_class("UIYunZhouZhenTuAttrWin",UIWindowBase)









function UIYunZhouZhenTuAttrWin:bindComponents()

self.root=UIObject.get(self,0)
self.scrollview=UIObject.get(self,1)
self.attrlist=UIObject.get(self,2)
self.skilllist=UIObject.get(self,3)
self.btnClose=UIButton.get(self,4)
self.skill=UIObject.get(self,5)
self.wjhimg=UIObject.get(self,6)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UIYunZhouZhenTuAttrWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.attrlist);self.attrlist=nil;
_UIObject_release(self.skilllist);self.skilllist=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.skill);self.skill=nil;
_UIObject_release(self.wjhimg);self.wjhimg=nil;
end
















local abname='ui/windows/xianyungang/yunzhouzhentu_atlas_pak.ab'
local _this



function UIYunZhouZhenTuAttrWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIYunZhouZhenTuAttrWin:__delete()
self:unbindComponents()
_this=nil
UIManager:invokeUIMethod("UIYunZhouZhenTuMainWin","ShowEnableDrag")
end




function UIYunZhouZhenTuAttrWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.6,nil)


local jzattr=self:getYZZTAllAttr()
local attrs=self:getAttrInfoList(jzattr)
local skills=YunZhouZhenTuModel:getYZZTAllSkillData()
if#attrs>0 or skills and next(skills)then
self.scrollview:setActive(true)
self.wjhimg:setActive(false)
else
self.scrollview:setActive(false)
self.wjhimg:setActive(true)
end

self.attrlist:setChildLayoutGroupCreateItems(#attrs,function(index)
local item=self.attrlist:getChildLayoutGroupGridItem(index-1)
local data=attrs[index]
local name=helper.getAttributeName(data.attrId)
local sVal=helper.getAttributeStrEx(data.attrId,data.attrVal)
local str=FMT.fmt('{0}：{1}',name,sVal)
item:SetChildText(0,str)
item:SetChildActive(1,data.isAdd)
if data.isAdd then
local addVal=helper.getAttributeStrEx(data.attrId,data.addVal)
item:SetChildText(1,addVal)
end
end)


if skills and next(skills)then
self.skill:setActive(true)
self.skilllist:setChildLayoutGroupCreateItems(#skills,function(index)
local widget=self.skilllist:getChildLayoutGroupGridItem(index-1)
local data=skills[index]
local ztid=data.id
local effectLevel=data.effectLevel
local ztcfg=cfg_yunzhouzhentuconfig_get(ztid)


local name=FMT.fmt('{0}  <color=#549327>{1}级</color>',ztcfg.skillname,effectLevel)
widget:SetChildText(2,name)


widget:SetChildCSImageSprite(1,abname,ztcfg.skillicon)


local descs=ztcfg.Upskilldesc
local parmdescs=ztcfg.Upskilldesc2
local desc=self:getSkillZTDesc(ztid,descs,parmdescs,effectLevel)
widget:SetChildText(3,desc)
end)
else
self.skill:setActive(false)
end
end

function UIYunZhouZhenTuAttrWin:getSkillZTDesc(ztid,descs,parmdescs,effectLevel)
local desc=''









desc=FMT.fmt(descs,unpack(parmdescs[effectLevel]))
return desc
end


function UIYunZhouZhenTuAttrWin:onHide()

end
function UIYunZhouZhenTuAttrWin:onBtnClose()
self:closeSelf()
end


function UIYunZhouZhenTuAttrWin:getAttrInfoList(attrs1)
local attrs=attrs1
local attrLookup={}
local attrTypeList={}
for Id,Val in pairs(attrs)do
attrLookup[Id]=Val
attrTypeList[#attrTypeList+1]=Id
end
local attrInfoList={}
for index,atype in ipairs(attrTypeList)do
local temp={}
temp.attrId=atype
temp.attrVal=attrLookup[atype]
temp.isAdd=nil
attrInfoList[index]=temp
end
return attrInfoList
end
function UIYunZhouZhenTuAttrWin:getYZZTAllAttr()
local attrLookup={}
for ztid=1,6 do

local yzztData=YunZhouZhenTuModel:getYZZTDataByID(ztid)
local isActive=false
local level=0
local effectLevel=0
if yzztData then
isActive=true
level=yzztData.level
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
effectLevel=cfg.effectLevel
end
if isActive then
local cfg=cfg_yunzhouzhentulevelconfig_get(ztid)[level]
local jzattr=cfg.jzattr

for i,v in ipairs(jzattr)do
local value=isActive and v[2]or 0
if attrLookup[v[1]]then
attrLookup[v[1]]=attrLookup[v[1]]+value
else
attrLookup[v[1]]=value
end
end
end
end
return attrLookup
end