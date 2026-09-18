







def_class("UIYunZhouZhenTuTips",UIWindowBase)









function UIYunZhouZhenTuTips:bindComponents()

self.Root=UIObject.get(self,0)
self.uiRoot=UIObject.get(self,1)
self.reScrollView=UIObject.get(self,2)
self.top=UIObject.get(self,3)
self.center=UIObject.get(self,4)
self.skill=UIObject.get(self,5)



end


function UIYunZhouZhenTuTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.reScrollView);self.reScrollView=nil;
_UIObject_release(self.top);self.top=nil;
_UIObject_release(self.center);self.center=nil;
_UIObject_release(self.skill);self.skill=nil;
end
















local _this
local abname=''



function UIYunZhouZhenTuTips:onLoaded(...)
self:bindComponents()
_this=self
end


function UIYunZhouZhenTuTips:__delete()
self:unbindComponents()
_this=nil
end




function UIYunZhouZhenTuTips:onShow(argtable,afterOnloaded)
if argtable then
if argtable.ztid then
self.ztid=argtable.ztid
end
end

local Cfg_zt=cfg_yunzhouzhentuconfig_get(self.ztid)
local yzztData=YunZhouZhenTuModel:getYZZTDataByID(self.ztid)
local Chongidx=1
local Nodeidx=1
local isjihuo=false
local effectLevel=0
if yzztData then
isjihuo=true
Chongidx=yzztData.chongshu
Nodeidx=yzztData.zhenshuMax
effectLevel=yzztData.effectLevel
end

local chongshuList=Cfg_zt.chongshu
local Chongid=chongshuList[Chongidx]
local Cfg_chongshu=cfg_zhentuchongshuconfig_get(Chongid)

local zhenshuList=Cfg_chongshu.zhenshuList
local Nodeid=zhenshuList[Nodeidx]
local Cfg_Node=cfg_zhenshujiedianconfig_get(Nodeid)
local jzattr=Cfg_Node.jzattr


local topwidget=self.top:getWidgetBase()

topwidget:SetChildText(0,FMT.fmt('名字：{0}',Cfg_zt.name))
if isjihuo then
topwidget:SetChildText(1,FMT.fmt('等级：{0}',Cfg_chongshu.name))
else
topwidget:SetChildText(1,'等级：<color=#827f78>未激活</color>')
end

topwidget:SetChildCSImageSprite(2,abname,Cfg_zt.icon)


local centerwidget=self.center:getWidgetBase()
local attrs=self:getAttrInfoList(jzattr,nil)
centerwidget:SetChildLayoutGroupCreateItems(0,#attrs,function(index)
local item=centerwidget:GetChildLayoutGroupGridItem(0,index-1)
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


local skillwidget=self.skill:getWidgetBase()
local skillicon=Cfg_zt.skillicon

skillwidget:SetChildCSImageSprite(0,abname,skillicon)

if effectLevel>0 then
skillwidget:SetChildGray(0,false)

local name=FMT.fmt('{0}  <color=#549327>{1}级</color>',Cfg_zt.skillname,effectLevel)
skillwidget:SetChildText(1,name)


local descs=Cfg_zt.Upskilldesc
local parmdescs=Cfg_zt.Upskilldesc2
local desc=FMT.fmt(descs,unpack(parmdescs[effectLevel]))
skillwidget:SetChildText(2,desc)
else
skillwidget:SetChildGray(0,true)

local name=FMT.fmt('{0}  <color=#827f78>（未激活）</color>',Cfg_zt.skillname)
skillwidget:SetChildText(1,name)

local descs=Cfg_zt.Upskilldesc
local parmdescs=Cfg_zt.Upskilldesc2
local desc=FMT.fmt(descs,unpack(parmdescs[effectLevel]))
desc=FMT.fmt("<color=#827f78>{0}</color>",desc)
skillwidget:SetChildText(2,desc)
end

end


function UIYunZhouZhenTuTips:onHide()

end

function UIYunZhouZhenTuTips:getAttrInfoList(attrs1,attrs2)
local attrs=attrs1
local attrLookup={}
local attrTypeList={}
for index,attrInfo in ipairs(attrs)do
attrLookup[attrInfo[1]]=attrInfo[2]
attrTypeList[#attrTypeList+1]=attrInfo[1]
end
local curSkillInfo=attrs
local nextSkillInfo=attrs2
local transTable=function(list)
local temp={}
if list then
for index,data in ipairs(list)do
temp[data[1]]=data[2]
end
end
return temp
end
local attrInfoList={}
local curAttrLookup=transTable(curSkillInfo)
local nextAttrLookup=transTable(nextSkillInfo or curSkillInfo)
for index,atype in ipairs(attrTypeList)do
local temp={}
temp.attrId=atype
temp.attrVal=attrLookup[atype]
temp.isAdd=nextAttrLookup[atype]~=nil
if temp.isAdd then
temp.addVal=nextAttrLookup[atype]-curAttrLookup[atype]
end
if temp.addVal==0 then
temp.isAdd=false
end
attrInfoList[index]=temp
end
return attrInfoList
end



