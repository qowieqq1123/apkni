







def_class("UIOtherDiscipleAttrWin_SystemZongMen",UIWindowBase)








function UIOtherDiscipleAttrWin_SystemZongMen:bindComponents()

self.root=UIObject.get(self,0)
self.discipleModelRoot=UIObject.get(self,1)
self.posImg=UIImage.get(self,2)
self.proSkillGrid=UIObject.get(self,3)
self.polygonAttrPanel=UIObject.get(self,4)
self.discipleNameText=UIText.get(self,5)
self.discipleJobIcon=UIImage.get(self,6)
self.alllAttrPointNumText=UIText.get(self,7)



end


function UIOtherDiscipleAttrWin_SystemZongMen:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.discipleModelRoot);self.discipleModelRoot=nil;
_UIObject_release(self.posImg);self.posImg=nil;
_UIObject_release(self.proSkillGrid);self.proSkillGrid=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.discipleNameText);self.discipleNameText=nil;
_UIObject_release(self.discipleJobIcon);self.discipleJobIcon=nil;
_UIObject_release(self.alllAttrPointNumText);self.alllAttrPointNumText=nil;
end
















local proSkillSort={1,3,5,7,2,4,6,8}


function UIOtherDiscipleAttrWin_SystemZongMen:onLoaded(...)
self:bindComponents()
end


function UIOtherDiscipleAttrWin_SystemZongMen:__delete()
self:unbindComponents()
end


function UIOtherDiscipleAttrWin_SystemZongMen:onHide()

end




function UIOtherDiscipleAttrWin_SystemZongMen:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.disciple_data=argtable.data
self:refreshInfo()
end

function UIOtherDiscipleAttrWin_SystemZongMen:onChangeDisciple(dis_guid,dis_data)
self:onShow({guid=dis_guid,data=dis_data})
end

function UIOtherDiscipleAttrWin_SystemZongMen:refreshInfo()
local disguid=self.disciple_guid
local dzData=self.disciple_data
local image=UIDiscipleModel.calculationDiscipleImageBase(dzData)


self.discipleNameText:setText(dzData.disciplename)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
self.discipleJobIcon:setSprite(globalABLookup.global,jobicon)

self.discipleModelRoot:setChildUIModelRemoveTarget()
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildInSideModelEx(self.discipleModelRoot,modelParams,0.85,nil,0,0,false,true)

local posType=UIDiscipleModel:getDisciplePostEX(dzData)
local posIconName=UISectPalaceModel:getPostIcon(posType)
self.posImg:setSprite(globalABLookup.diciplemain,posIconName)

local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
for i,v in ipairs(dzData.attrList)do
local a=v==0 and 1 or v
allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
end
self.alllAttrPointNumText:setText(FMT.fmt('总值：{0}',allnum))
local widget=self.polygonAttrPanel:getChildWidgetBase()
for i=1,6 do
local idx=i-1
local attrType=i
local v=dzData.attrList[attrType]==0 and 1 or dzData.attrList[attrType]
widget:SetChildText(idx,FMT.fmt('{0}\n<color=#549327>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
end
widget:SetChildUIPolygonImage(6,ratelist,0)
local color=image.color
local polygonIcon='image_shuxingtu_'..color
widget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)

self:refreshPorSkill()
end

function UIOtherDiscipleAttrWin_SystemZongMen:refreshPorSkill()
local disguid=self.disciple_guid
local dzData=self.disciple_data

local proskilllist=dzData.proskillList
self.proSkillGrid:setChildLayoutGroupCreateItems(#proSkillSort)
local gridlist=self.proSkillGrid:getChildLayoutGroupGridList()
local c=gridlist.Count
for i=1,c do
local ty=proSkillSort[i]
local item=gridlist[i-1]
local level=0
for j,w in ipairs(proskilllist)do
if w.param_1==ty then
level=w.param_2
break
end
end

local name=cfgHelper.get2(cfg_discipleproskillconfig_get,ty,'name')
item:SetChildText(1,name)

item:SetChildText(2,FMT.fmt('{0}级',level))

local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,ty,'icon')
item:SetChildCSImageSprite(0,globalABLookup.proskill,'image_gongzhongtp_'..icon)
end
end