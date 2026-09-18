







def_class("UIXianMoZhuanZhi_XinFaUpWin",UIWindowBase)









function UIXianMoZhuanZhi_XinFaUpWin:bindComponents()

self.attrGrid=UIObject.get(self,0)
self.attrGrid1=UIObject.get(self,1)
self.attrGrid2=UIObject.get(self,2)
self.imgbg2=UIObject.get(self,3)
self.onepanel=UIObject.get(self,4)
self.root=UIObject.get(self,5)
self.skill1=UIObject.get(self,6)
self.skill2=UIObject.get(self,7)
self.skillitem1=UIObject.get(self,8)
self.skillitem2=UIObject.get(self,9)
self.skillitemdesc1=UIText.get(self,10)
self.skillitemdesc2=UIText.get(self,11)
self.skillitemname1=UIText.get(self,12)
self.skillitemname2=UIText.get(self,13)
self.successEffect=UIObject.get(self,14)
self.titleBack=UIObject.get(self,15)
self.tranObj=UIObject.get(self,16)
self.twopanel=UIObject.get(self,17)



end


function UIXianMoZhuanZhi_XinFaUpWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrGrid);self.attrGrid=nil;
_UIObject_release(self.attrGrid1);self.attrGrid1=nil;
_UIObject_release(self.attrGrid2);self.attrGrid2=nil;
_UIObject_release(self.imgbg2);self.imgbg2=nil;
_UIObject_release(self.onepanel);self.onepanel=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skill1);self.skill1=nil;
_UIObject_release(self.skill2);self.skill2=nil;
_UIObject_release(self.skillitem1);self.skillitem1=nil;
_UIObject_release(self.skillitem2);self.skillitem2=nil;
_UIObject_release(self.skillitemdesc1);self.skillitemdesc1=nil;
_UIObject_release(self.skillitemdesc2);self.skillitemdesc2=nil;
_UIObject_release(self.skillitemname1);self.skillitemname1=nil;
_UIObject_release(self.skillitemname2);self.skillitemname2=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.titleBack);self.titleBack=nil;
_UIObject_release(self.tranObj);self.tranObj=nil;
_UIObject_release(self.twopanel);self.twopanel=nil;
end
















local _this

function UIXianMoZhuanZhi_XinFaUpWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXianMoZhuanZhi_XinFaUpWin:__delete()
self.successEffect:setChildShowEffect(10010,false)
self:unbindComponents()
_this=nil
end




function UIXianMoZhuanZhi_XinFaUpWin:onShow(argtable,afterOnloaded)
local dis_guid
self.imgbg2:setActive(true)

dis_guid=argtable.dis_guid
self.dis_guid_next=dis_guid

self.successEffect:setChildShowEffect(10010,true)

local attrsBase=cfgHelper.getdef(cfg_attributesconfig,'attrsBase')
local attrLookup=argtable.attrLookup
local attrlist=UIDiscipleModel.getAttrListByType(attrLookup,attrsBase,true,true)
local oldattrLookup=argtable.oldattrLookup
local oldattrlist=UIDiscipleModel.getAttrListByType(oldattrLookup,attrsBase,true,true)

self.oldSkillList=argtable.oldSkillList
self.newSkillList=UIDiscipleModel:getDiscipleXianMoSkillList(dis_guid)

self.rootWidget=self.root:getChildWidgetBase()

local attrNum=0
local gridlist=self.attrGrid:getChildCommonLayoutGroupWidgetList()
local c=gridlist.Count
for i=1,c do
local item=gridlist[i-1]
local attr=attrlist[i]
local oldattr=oldattrlist[i]
local show=attr~=nil and oldattr~=nil and(attr[2]~=oldattr[2])
item:SetChildActive(0,show)
if show then
attrNum=attrNum+1
local attrType=attr[1]
local attrValue=attr[2]
local oldattrValue=oldattr[2]
local name=helper.getAttributeName(attrType)
item:SetChildText(1,string.format("%s：",name))
item:SetChildText(2,helper.getAttributeStrEx(attrType,oldattrValue,nil))

local isadd=true
item:SetChildActive(3,isadd)
item:SetChildActive(4,isadd)
if isadd then
item:SetChildText(4,helper.getAttributeStrEx(attrType,attrValue,nil))
end
end
end

attrNum=attrNum+1
if attrNum<=c then
local item=gridlist[attrNum-1]
local old_xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,argtable.oldxinfaLevel)
local xinfaLevelCfg=cfgHelper.get1(cfg_discipledaohengconfig_get,argtable.xinfaLevel)
item:SetChildActive(0,true)
item:SetChildText(1,"道行上限：")
item:SetChildText(2,old_xinfaLevelCfg.daoheng_conf[2])
local isadd=true
item:SetChildActive(3,isadd)
item:SetChildActive(4,isadd)
if isadd then
item:SetChildText(4,xinfaLevelCfg.daoheng_conf[2])
end
end

self.attrNum=attrNum
self.attrGrid:setActive(false)

self:doMyAnim()
self:refreshSkillDesc()
end

function UIXianMoZhuanZhi_XinFaUpWin:doMyAnim()
local delay=0
self.titleBack:setScale(Vector3(2,2,2))
self.titleBack:setChildDOScale(1,0.15)

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
self.imgbg2:setActive(false)
self.winlua:SetChildCanvasGroupDOFade(self.skill1:getID(),1,1)
self.winlua:SetChildCanvasGroupDOFade(self.skill2:getID(),1,1)
end)
end

function UIXianMoZhuanZhi_XinFaUpWin:getSkillID()
for i=1,3 do
local old=self.oldSkillList[i]
local new=self.newSkillList[i]
local oldSkillId=old[1]
local oldSkillLv=old[2]

local newSkillId=new[1]
local newSkillLv=new[2]

if newSkillLv>oldSkillLv then
if oldSkillLv==0 then
return true,newSkillId,newSkillLv
else
return false,newSkillId,newSkillLv,oldSkillLv
end
end
end
return false
end

function UIXianMoZhuanZhi_XinFaUpWin:refreshSkillDesc()
local isActive,skillId,newLv,oldLv=self:getSkillID()

if isActive then
self.skill1:setActive(false)
self.skill2:setActive(true)
self.winlua:SetChildLocalPosX(self.skill2:getID(),-375)

else
if skillId then
self.skill1:setActive(true)
self.skill2:setActive(true)
self.winlua:SetChildLocalPosX(self.skill2:getID(),0)

else
self.skill1:setActive(false)
self.skill2:setActive(false)

end
end

self:refreshSkillObj(skillId,newLv,oldLv,isActive)
end

function UIXianMoZhuanZhi_XinFaUpWin:refreshSkillObj(skillId,newLv,oldLv,isActive)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local icon=iconHelper.getSkillIcon(skillCfg.icon)

if oldLv then
local gridlist=self.attrGrid1:getChildCommonLayoutGroupWidgetList()
local item=gridlist[0]

local levelTxt='已激活'
if not isActive then levelTxt=skillModel:getSkillLvStr(oldLv)end

local skillitem=self.skillitem1:getWidgetBase()
skillitem:SetChildCSImageIcon(1,icon)
self.skillitemname1:setText(string.format('<color=#ED7D31>%s</color>',skillCfg.name))
self.skillitemdesc1:setText(string.format('<color=#92D050>%s</color>',levelTxt))
local desc=skillModel:getSkillDesc(skillId,oldLv)
item:SetChildText(4,string.format('<color=#ED7D31>【%s】</color>',skillCfg.name))
item:SetChildText(6,desc)
end

if newLv then
local gridlist=self.attrGrid2:getChildCommonLayoutGroupWidgetList()
local item=gridlist[0]

local levelTxt='已激活'
if not isActive then levelTxt=skillModel:getSkillLvStr(newLv)end

local skillitem=self.skillitem2:getWidgetBase()
skillitem:SetChildCSImageIcon(1,icon)
self.skillitemname2:setText(string.format('<color=#ED7D31>%s</color>',skillCfg.name))
self.skillitemdesc2:setText(string.format('<color=#92D050>%s</color>',levelTxt))
local desc=self:getSkillDesc(skillId,newLv)
item:SetChildText(4,string.format('<color=#ED7D31>【%s】</color>',skillCfg.name))
item:SetChildText(6,desc)
end
end

function UIXianMoZhuanZhi_XinFaUpWin:getSkillDesc(skillid,skilllv)
local skillconfig=cfgHelper.get1(cfg_skillconfig_get,skillid)
local desc=skillconfig.desc
local descParams=skillconfig.descParams
if desc==nil then
return'没有找到技能配置'
end
if descParams==nil or#descParams<=0 then
return desc
end
if skilllv>#descParams then
skilllv=#descParams
end
if skilllv==0 then
skilllv=1
end

for k,v in ipairs(descParams[skilllv])do
descParams[skilllv][k]=string.format("<color=#76D81E>%s</color>",v)
end

return FMT.fmt(desc,unpack(descParams[skilllv]))
end