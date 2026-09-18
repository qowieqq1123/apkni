







def_class("UIDaoBingSkillWin",UIWindowBase)









function UIDaoBingSkillWin:bindComponents()

self.cnd=UIText.get(self,0)
self.title2=UIText.get(self,1)
self.desc=UIText.get(self,2)
self.creater=UIObject.get(self,3)
self.title1=UIText.get(self,4)
self.skillItem=UIObject.get(self,5)
self.descTitleRoot=UIObject.get(self,6)
self.descRoot=UIObject.get(self,7)
self.cndTitleRoot=UIObject.get(self,8)
self.cndRoot=UIObject.get(self,9)
self.blackImg=UIObject.get(self,10)
self.root=UIObject.get(self,11)
self.upRoot=UIObject.get(self,12)



end


function UIDaoBingSkillWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cnd);self.cnd=nil;
_UIObject_release(self.title2);self.title2=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.creater);self.creater=nil;
_UIObject_release(self.title1);self.title1=nil;
_UIObject_release(self.skillItem);self.skillItem=nil;
_UIObject_release(self.descTitleRoot);self.descTitleRoot=nil;
_UIObject_release(self.descRoot);self.descRoot=nil;
_UIObject_release(self.cndTitleRoot);self.cndTitleRoot=nil;
_UIObject_release(self.cndRoot);self.cndRoot=nil;
_UIObject_release(self.blackImg);self.blackImg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.upRoot);self.upRoot=nil;
end


















function UIDaoBingSkillWin:onLoaded(...)
self:bindComponents()
end

function UIDaoBingSkillWin:__delete()
self:unbindComponents()
end

function UIDaoBingSkillWin:onShow(argtable,afterOnloaded)
local itemid=argtable.itemid
local skillid=argtable.skillid
local skilllv=argtable.skilllv
self:freshInfo(itemid,skillid,skilllv)
end

function UIDaoBingSkillWin:onHide()

end



function UIDaoBingSkillWin:freshInfo(itemid,skillid,skilllv)
local skillWidget=self.skillItem:getChildWidgetBase()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillid)
local isbd=skillModel.isSkillBD(skillCfg.skillType)
skillWidget:SetChildText(0,skillCfg.name)
skillWidget:SetChildIcon(1,iconHelper.getSkillIcon(skillCfg.icon),false)
skillWidget:SetChildActive(2,isbd)
skillWidget:SetChildText(3,FMT.fmt('{0}级',skilllv))

self.title1:setText('技能效果')
local desc=skillModel:getSkillDesc(skillid,skilllv)
local descEx=skillModel:getSkillDescEx(skillid,skilllv)or{}
for i,v in ipairs(descEx)do
local str=FMT.fmt('<color=#ffff99>{0}</color>',v)
desc=FMT.fmt('{0}\n{1}',desc,str)
end
self.desc:setText(desc)

local upgradeDesc=skillCfg.upgradeDesc or''
local descParams=skillCfg.descParams[skilllv]
local nextdescParams=skillCfg.descParams[skilllv+1]

local upgradeDescEx=skillCfg.upgradeDescEx or''
local descExParams=skillCfg.descExParams or{}
local descParamsEx=(descExParams[skilllv]or{})[1]
local nextdescExParams=(descExParams[skilllv+1]or{})[1]

local hasNext=nextdescParams~=nil
local descArray=string.split(upgradeDesc,',')
local descExArray=string.split(upgradeDescEx,',')
local temp={}


local params={}
local nextparams={}
for i,v in ipairs(descArray)do
if v and v~=''then
temp[#temp+1]={v,i}
end
end
local nlen=#temp


for i,v in ipairs(descExArray)do
if v and v~=''then
temp[#temp+1]={v,i}
end
end

local len=#temp
self.upRoot:setActive(len>0)
self.creater:setChildLayoutGroupCreateItems(len,function(i)
local descInfo=temp[i]
local descfmt=descInfo[1]
local replaceIdx=descInfo[2]
local idx=i-nlen
local isNomal=i<=nlen
local param=isNomal and descParams[i]or descParamsEx[idx]
local item=self.creater:getChildLayoutGroupGridItem(i-1)

descfmt=string.replace(descfmt,string.format('{%d}',replaceIdx-1),'{0}')
local name=FMT.fmt(descfmt,param)


descfmt=string.gsub(descfmt,'<color=#[%da-zA-z]+>','')
descfmt=string.gsub(descfmt,'</color>','')

local array=string.split(descfmt,'}')
local extra=array[2]or''

item:SetChildText(0,name)
item:SetChildActive(1,false)
if hasNext then
local nextparam=isNomal and nextdescParams[i]or nextdescExParams[idx]
local up=nextparam-param
item:SetChildActive(1,up>0)
local nextattr=FMT.fmt('{0}{1}',up,extra)
item:SetChildText(2,nextattr)
end
end)
self.title2:setText('升级要求')

if not hasNext then
self.cnd:setText('已满级')
else
local name=itemsConfig.getConfig(itemid).name
local starlv=daobingConfig.getStarByShentonglv(skilllv+1)
self.cnd:setText(FMT.fmt('{0}升至{1}星',name,starlv))
end
end
