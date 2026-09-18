







def_class("UIDiscipleAttrLookWin",UIWindowBase)









function UIDiscipleAttrLookWin:bindComponents()

self.discipleListPanel=UIObject.get(self,0)
self.desccreater=UIObject.get(self,1)
self.jingjieInput=UIInputField.get(self,2)
self.liantiInput=UIInputField.get(self,3)



end


function UIDiscipleAttrLookWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.discipleListPanel);self.discipleListPanel=nil;
_UIObject_release(self.desccreater);self.desccreater=nil;
_UIObject_release(self.jingjieInput);self.jingjieInput=nil;
_UIObject_release(self.liantiInput);self.liantiInput=nil;
end
















local _this


function UIDiscipleAttrLookWin:onLoaded(...)
_this=self
self:bindComponents()
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
end


function UIDiscipleAttrLookWin:__delete()
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
end


function UIDiscipleAttrLookWin:onHide()

end

function UIDiscipleAttrLookWin.onDiscipleJJChange(disguid,old_jjlv,jingjielv,old_jjexp,jingjieexp)
if _this==nil then return end
if mathHelper.compareInt64(disguid,_this.dis_guid)then
_this:initDescPanel()
end
end




function UIDiscipleAttrLookWin:onShow(argtable,afterOnloaded)
self.dislist=UIDiscipleModel:getSortList()
self.curSelect=1
local netData=self.dislist[self.curSelect]
self.dis_guid=netData.discipleguid
self:initListPanel()
self:initDescPanel()
end

function UIDiscipleAttrLookWin:initListPanel()
local dataNum=#self.dislist
self.discipleListPanel:setChildLayoutGroupCreateItems(dataNum)
local grids=self.discipleListPanel:getChildLayoutGroupGridList()
for i=1,dataNum do
local item=grids[i-1]
local netData=self.dislist[i]



comHelper.setChildModelHeadIconBG(item,5,netData.discipleguid)

local scale=0.35
comHelper.setChildModelRawImage(item,netData.discipleguid,2,0,eHeadCenterType.eHead)

item:SetChildText(3,netData.disciplename)

item:SetChildText(4,tostring(netData.discipleguid))

self:changItemBG(item,self.curSelect==i)

item:SetChildButtonClick(0,function()
self:onDisClick(i)
end)
end
end

function UIDiscipleAttrLookWin:changItemBG(item,flag)
item:SetChildActive(1,flag)
end

function UIDiscipleAttrLookWin:onDisClick(idx)
if self.curSelect==idx then return end

local old=self.curSelect
self.curSelect=idx
local netData=self.dislist[idx]
self.dis_guid=netData.discipleguid

if old~=nil then
local oldItem=self.discipleListPanel:getChildLayoutGroupGridItem(old-1)
self:changItemBG(oldItem,false)
end
local item=self.discipleListPanel:getChildLayoutGroupGridItem(idx-1)
self:changItemBG(item,true)

self:initDescPanel()
end

function UIDiscipleAttrLookWin:initDescPanel()
self:getDescList()
local pagenum=#self.descList
self.desccreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.desccreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end

function UIDiscipleAttrLookWin:refreshPageItem(item,pageidx)
local pageData=self.descList[pageidx]
item:SetChildText(0,pageData.name)

local childnum=#pageData.childlist
item:SetChildLayoutGroupCreateItems(1,childnum)
local childGrids=item:GetChildLayoutGroupGridList(1)
for i=1,childnum do
local childItem=childGrids[i-1]
local data=pageData.childlist[i]
if type(data)=='table'then
childItem:SetChildText(0,'')
childItem:SetChildActive(1,true)
childItem:SetChildButtonClick(1,function()
data[2]()
end)
childItem:SetChildText(2,data[1])
else
childItem:SetChildText(0,pageData.childlist[i])
childItem:SetChildActive(1,false)
end
end
end

function UIDiscipleAttrLookWin:onCopy()
platformHelper.copyTextToClipboard(tostring(self.dis_guid))
end

function UIDiscipleAttrLookWin:getDescList()
local netData=self.dislist[self.curSelect]
local guid=netData.discipleguid
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local job=imageInfo.job
local descList={}
local desc,attrs
local titleName={'六维','形象','基础属性','职业属性','境界属性','仙魔属性','炼体属性','奇珍属性','淬体属性','功法属性','装备属性','特质属性','负伤属性','古宝属性','宗门增益建筑属性',
'拥有技能','技能属性','技能相关','灵兽特性','修为自增效率提升','修为获取效率提升','修为额外加成',
'炼体获取效率提升','天命属性','天命赐福属性','天道树属性','玉符属性','山门大阵属性',
'跃龙池属性','小世界属性',
}
local idx=0


idx=idx+1
desc={name=titleName[idx],childlist={}}
self.addSixAttrDescStr(desc.childlist,netData)
table.insert(descList,desc)

idx=idx+1
desc={name=titleName[idx],childlist={}}
self.addImageInfo(desc.childlist,netData)
table.insert(descList,desc)

local baseAttrs=UIDiscipleModel:getDiscipleAttrLookup(guid)

idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eBase]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)

idx=idx+1
desc={name=FMT.fmt('{0}({1})',titleName[idx],UIDiscipleModel:getJobNameX(guid)),childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eJob]or{}
self.addAttrDescStr(desc.childlist,attrs)
local add_lp_job=gubaoModel:getGBSkil_job_attrLookup(job)
if next(add_lp_job)then
local jobname=UIDiscipleModel:getJobName(job)
for attrType,v in pairs(add_lp_job)do
local attrName=helper.getAttributeName(attrType)
table.insert(desc.childlist,FMT.fmt('<color=red>古宝-{0}-{1} {2}</color>',jobname,attrName,v))
end
end
table.insert(descList,desc)

idx=idx+1
desc={name=FMT.fmt('{0}({1})',titleName[idx],UIDiscipleModel:getJJNameEx(netData.jingjielv)),childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eJingJie]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(desc.childlist,FMT.fmt('<color=red>潜力对境界加成{0}%</color>',UIDiscipleModel:getDiscipleBaseAttrExListX(guid,DISCIPLE_BASE_ATTR_TYPE.eQianLi)[1]))
table.insert(desc.childlist,FMT.fmt('<color=red>天命对境界加成{0}%</color>',UIDiscipleModel:getTianMingJJRate(guid)*100))
table.insert(desc.childlist,FMT.fmt('<color=red>古宝-专业-境界 {0}%</color>',gubaoModel:getGBSkil_ProskillToJJAttrRate(guid)))
table.insert(desc.childlist,FMT.fmt('<color=red>仙魔对境界加成{0}%</color>',UIDiscipleModel:getXianMoJJRate(guid)*100))
table.insert(desc.childlist,FMT.fmt('<color=red>职业装备对境界加成{0}%</color>',vocEquipModel:getVocEquipJJRate(guid)*100))
local addrate_lp_jj=gubaoModel:getGBSkil_job_jj_attrRateLookup(job)
if next(addrate_lp_jj)then
local jobname=UIDiscipleModel:getJobName(job)
for attrType,v in pairs(addrate_lp_jj)do
local attrName=helper.getAttributeName(attrType)
table.insert(desc.childlist,FMT.fmt('<color=red>古宝-{0}-境界-{1} {2}%</color>',jobname,attrName,v*100))
end
end
local addrate_xc_jj=xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eDiziVocJingJieRate)
if next(addrate_xc_jj)and addrate_xc_jj[job]then
local xcJobList=addrate_xc_jj[job]
local jobname=UIDiscipleModel:getJobName(job)
for attrType,v in pairs(xcJobList)do
local attrName=helper.getAttributeName(attrType)
table.insert(desc.childlist,FMT.fmt('<color=red>星辰-{0}-境界-{1} {2}%</color>',jobname,attrName,v))
end
end
table.insert(descList,desc)

idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eXianMoDaoHeng]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)

idx=idx+1
desc={name=FMT.fmt('{0}({1})',titleName[idx],UIDiscipleModel:getLTNameEx(netData.liantilv)),childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eLianTi]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(desc.childlist,FMT.fmt('<color=red>潜力对炼体加成{0}%</color>',UIDiscipleModel:getDiscipleBaseAttrExListX(guid,DISCIPLE_BASE_ATTR_TYPE.eQianLi)[2]))
table.insert(desc.childlist,FMT.fmt('<color=red>奇珍对炼体加成{0}%</color>',UIDiscipleModel:getDZQiZhan2LianTianRate(guid)))
table.insert(desc.childlist,FMT.fmt('<color=red>淬体对炼体加成{0}%</color>',UIDiscipleModel:getDZCuiTi2LianTianRate(guid)))
table.insert(desc.childlist,FMT.fmt('<color=red>古宝-专业-炼体 {0}%</color>',gubaoModel:getGBSkil_ProskillToLTAttrRate(guid)))
table.insert(desc.childlist,FMT.fmt('<color=red>职业装备对炼体加成{0}%</color>',vocEquipModel:getVocEquipLTRate(guid)*100))
local addrate_lp_lt=gubaoModel:getGBSkil_job_lt_attrRateLookup(job)
if next(addrate_lp_lt)then
local jobname=UIDiscipleModel:getJobName(job)
for attrType,v in pairs(addrate_lp_lt)do
local attrName=helper.getAttributeName(attrType)
table.insert(desc.childlist,FMT.fmt('<color=red>古宝-{0}-炼体-{1} {2}%</color>',jobname,attrName,v*100))
end
end
table.insert(descList,desc)

idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eQiZhen]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eCuiTi]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)

idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eGongFa]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)

idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eEquip]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)

idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eSpecial]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)

idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eInjury]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=gubaoModel:getAllAttrLookup(false)
UIDiscipleModel:calculationGuBaoSkilAttrLookup(attrs,guid)
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs={}
UIDiscipleModel:calculationBenefitBuildingAttrLookup(attrs)
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
local skillLookup=UIDiscipleModel:getAllSkillLookup(guid)
self.addSkillDescStr(desc.childlist,skillLookup,guid)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eSkill]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
self.addSkillDescStrEx(desc.childlist,guid)
table.insert(descList,desc)


idx=idx+1
desc={childlist={}}
local lsname=self.addLingShouTXDescStr(desc.childlist,guid)
desc.name=FMT.fmt('{0}({1})',titleName[idx],lsname)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
self.addXiuWeiAutoRateStr(desc.childlist,guid)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
self.addXiuWeiRateStr(desc.childlist,guid)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
self.addXiuWeiExRateStr(desc.childlist,guid)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
self.addLianTiRateStr(desc.childlist,guid)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eTianMing]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eTianMingCiFu]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)

idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eTianDaoShu]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)

idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs=baseAttrs[DISCIPLE_ATTRIBUTE_TYPE.eYuFu]or{}
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs={}
UIDiscipleModel:calculationDiscipleDaZhenAttrLookup(attrs)
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs={}
UIDiscipleModel:calculationYueLongChiAttrLookup(attrs)
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
attrs={}
LittleWorldModel:calculationAttrLookup(attrs)
self.addAttrDescStr(desc.childlist,attrs)
table.insert(descList,desc)

self.descList=descList
end

function UIDiscipleAttrLookWin.addSixAttrDescStr(res,netData)
for i,v in ipairs(netData.attrList)do
local str=FMT.fmt('{0}：{1}',UIDiscipleModel:getDiscipleBaseAttrName(i),v)
table.insert(res,str)
end
end

function UIDiscipleAttrLookWin.addImageInfo(res,netData)
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData)
if imageInfo.skeleton~=nil then
table.insert(res,FMT.fmt("骨架：{0}",imageInfo.skeleton))
end
table.insert(res,FMT.fmt("发型：{0}",imageInfo.hair))
table.insert(res,FMT.fmt("脸型：{0}",imageInfo.face))
table.insert(res,FMT.fmt("身体：{0}",imageInfo.body))
table.insert(res,FMT.fmt("装饰：{0}",imageInfo.accessory))
end

function UIDiscipleAttrLookWin.addAttrDescStr(res,attrs)
if attrs==nil then
return
end
local num=0
for i,v in pairsBySortKey(attrs)do
num=num+1
local str=helper.getAttributeStr(i,v,2,'{0}：{1}')
table.insert(res,str)
end
if num<=0 then
table.insert(res,'暂无')
end
end

function UIDiscipleAttrLookWin.addSkillDescStr(res,skillLookup,guid)
local num=0
local titles={'职业','装备','功法','特质'}
for typo,lookup in pairs(skillLookup)do
for skillId,skillLv in pairs(lookup)do
num=num+1
local skill_lv=skillLv
if skillLv>0 then
skill_lv=UIDiscipleModel:getSkillLv(guid,skillId,skillLv)
end
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local str=FMT.fmt('{0}{1}级({2})',skillCfg.name,skill_lv,titles[typo])
table.insert(res,str)
end
end
if num<=0 then
table.insert(res,'暂无')
end
end

function UIDiscipleAttrLookWin.addSkillDescStrEx(res,guid)
local num=0
local plusLookup=UIDiscipleModel:getSkillLvPlusLookup(guid)
if plusLookup then
for skillId,pluslv in pairs(plusLookup)do
num=num+1
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local str=FMT.fmt('{0}({1})等级+{2}',skillCfg.name,skillId,pluslv)
table.insert(res,str)
end
end
local cdLookup=UIDiscipleModel:getSkillCoolDownLookup(guid)
if cdLookup then
for skillId,cd in pairs(cdLookup)do
num=num+1
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
local str=FMT.fmt('{0}({1})冷却变化：{2}',skillCfg.name,skillId,cd)
table.insert(res,str)
end
end
if num<=0 then
table.insert(res,'暂无')
end
end

function UIDiscipleAttrLookWin.addLingShouTXDescStr(res,guid)
local num=0
local name='无'
local ls_guid=UIDiscipleModel:getDZLingShou(guid)
if ls_guid then
local lsData=lingshouModel:getLingShouData(ls_guid)
name=lsData.name

local rates=lingshouModel:getCharacterAttrs(lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI))
for k,v in pairs(rates)do
num=num+1
local str=FMT.fmt('{0}+{1}%',helper.getAttributeName(k),v*100)
table.insert(res,str)
end


local attrlist=lingshouModel:getAllAttrList(lsData)
for k,v in pairs(attrlist)do
num=num+1
local valStr=helper.getAttributeStrEx(k,v)
local str=FMT.fmt('{0}+{1}',helper.getAttributeName(k),valStr)
table.insert(res,str)
end
end
if num<=0 then
table.insert(res,'暂无')
end
return name
end

function UIDiscipleAttrLookWin.addXiuWeiAutoRateStr(res,guid)
local rate,r_list=UIDiscipleModel:getJJAutoGrowRate(guid)
table.insert(res,FMT.fmt('总加成:{0}%',rate*100))
table.insert(res,FMT.fmt('资质加成:{0}%',r_list[1]*100))
table.insert(res,FMT.fmt('特质加成:{0}%',r_list[2]*100))
table.insert(res,FMT.fmt('古宝加成:{0}%',r_list[3]*100))
table.insert(res,FMT.fmt('符宝加成:{0}%',r_list[4]*100))
table.insert(res,FMT.fmt('洞府加成:{0}%',r_list[5]*100))
table.insert(res,FMT.fmt('职位加成:{0}%',r_list[6]*100))
table.insert(res,FMT.fmt('宗门状态加成:{0}%',r_list[7]*100))
table.insert(res,FMT.fmt('宗门状态加成:{0}%(自增)',r_list[8]*100))
table.insert(res,FMT.fmt('宗门增益建筑加成:{0}%(自增)',r_list[9]*100))
table.insert(res,FMT.fmt('仙盟活动:{0}%(自增)',r_list[10]*100))
table.insert(res,FMT.fmt('古宝加成:{0}%(自增)',r_list[11]*100))
table.insert(res,{'服务器概率',function()
gmControl.reqCommand(FMT.fmt('@printdisciplejjeffect {0}',tostring(guid)))
end})
end

function UIDiscipleAttrLookWin.addXiuWeiRateStr(res,guid)
local rate,r_list=UIDiscipleModel:getJJGrowRate(guid)
table.insert(res,FMT.fmt('总加成:{0}%',rate*100))
table.insert(res,FMT.fmt('资质加成:{0}%',r_list[1]*100))
table.insert(res,FMT.fmt('特质加成:{0}%',r_list[2]*100))
table.insert(res,FMT.fmt('古宝加成:{0}%',r_list[3]*100))
table.insert(res,FMT.fmt('符宝加成:{0}%',r_list[4]*100))
table.insert(res,FMT.fmt('洞府加成:{0}%',r_list[5]*100))
table.insert(res,FMT.fmt('职位加成:{0}%',r_list[6]*100))
table.insert(res,FMT.fmt('宗门状态加成:{0}%',r_list[7]*100))
table.insert(res,{'服务器概率',function()
gmControl.reqCommand(FMT.fmt('@printdisciplejjeffect {0}',tostring(guid)))
end})
end

function UIDiscipleAttrLookWin.addXiuWeiExRateStr(res,guid)
local rate=0
local netData=UIDiscipleModel:getAnyDiscipleDataByStr(tostring(guid))
local danyaorate=dzSpecialityGrowEffectController:getJJMedicineRate(netData)
rate=danyaorate+rate

local buildingBuffRate=zongmenModel:getBenefitBuildingBuffAddition(false,BENEFIT_BUFF_EFFECT_TYPE.eJingJieSpeed,2)
buildingBuffRate=buildingBuffRate/100
rate=rate+buildingBuffRate
table.insert(res,FMT.fmt('总加成:{0}%',rate*100))
table.insert(res,FMT.fmt('服食丹药加成:{0}%',danyaorate*100))
table.insert(res,FMT.fmt('宗门增益建筑加成:{0}%(服用丹药)',buildingBuffRate*100))
end

function UIDiscipleAttrLookWin.addLianTiRateStr(res,guid)
local rate,r_list=UIDiscipleModel:getLTGrowRate(guid)

local buildingBuffRate=zongmenModel:getBenefitBuildingBuffAddition(false,BENEFIT_BUFF_EFFECT_TYPE.eLianTiSpeed,2)
buildingBuffRate=buildingBuffRate/100
rate=rate+buildingBuffRate
table.insert(res,FMT.fmt('总加成:{0}%',rate*100))
table.insert(res,FMT.fmt('根骨加成:{0}%',r_list[1]*100))
table.insert(res,FMT.fmt('特质加成:{0}%',r_list[2]*100))
table.insert(res,FMT.fmt('古宝加成:{0}%',r_list[3]*100))
table.insert(res,FMT.fmt('符宝加成:{0}%',r_list[4]*100))
table.insert(res,FMT.fmt('宗门状态加成:{0}%',r_list[5]*100))
table.insert(res,FMT.fmt('宗门增益建筑加成:{0}%(服用丹药)',buildingBuffRate*100))
end

function UIDiscipleAttrLookWin:onSetJingJie()
local input=self.jingjieInput:getInputFieldValue()
if input~=''and input~=nil then
gmControl.reqCommand(FMT.fmt('@setdisciplejingjie {0} {1}',tostring(self.dis_guid),input))
end
end

function UIDiscipleAttrLookWin:onSetLianTi()
local input=self.liantiInput:getInputFieldValue()
if input~=''and input~=nil then
gmControl.reqCommand(FMT.fmt('@setdisciplelianti {0} {1}',tostring(self.dis_guid),input))
end
end