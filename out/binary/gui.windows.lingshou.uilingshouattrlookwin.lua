







def_class("UILingShouAttrLookWin",UIWindowBase)









function UILingShouAttrLookWin:bindComponents()

self.desccreater=UIObject.get(self,0)
self.discipleListPanel=UIObject.get(self,1)
self.jingjieInput=UIInputField.get(self,2)
self.liantiInput=UIInputField.get(self,3)



end


function UILingShouAttrLookWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.desccreater);self.desccreater=nil;
_UIObject_release(self.discipleListPanel);self.discipleListPanel=nil;
_UIObject_release(self.jingjieInput);self.jingjieInput=nil;
_UIObject_release(self.liantiInput);self.liantiInput=nil;
end



















function UILingShouAttrLookWin:onLoaded(...)
self:bindComponents()
end


function UILingShouAttrLookWin:__delete()
self:unbindComponents()
end




function UILingShouAttrLookWin:onShow(argtable,afterOnloaded)
self.lsDataList=argtable.list

self.curSelect=argtable.sindex


self:initListPanel()

self:initDescPanel()
end


function UILingShouAttrLookWin:onHide()

end

function UILingShouAttrLookWin:initListPanel()
local dataNum=#self.lsDataList
self.discipleListPanel:setChildLayoutGroupCreateItems(dataNum)
local grids=self.discipleListPanel:getChildLayoutGroupGridList()
for i=1,dataNum do
local item=grids[i-1]
local lsData=self.lsDataList[i]



comHelper.setChildModelHeadIconBGByColor(item,5,lingshouModel.getColorEx(lsData))

comHelper.setChildModelRawImage_lingshou(item,lsData.id,2,0,eHeadCenterType.eHead,1)

item:SetChildText(3,lsData.name)

item:SetChildText(4,lsData.guid_str)

self:changItemBG(item,self.curSelect==i)

item:SetChildButtonClick(0,function()
self:onDisClick(i)
end)
end
end

function UILingShouAttrLookWin:changItemBG(item,flag)
item:SetChildActive(1,flag)
end

function UILingShouAttrLookWin:onDisClick(idx)
if self.curSelect==idx then return end

local old=self.curSelect
self.curSelect=idx
local lsData=self.lsDataList[idx]
self.lsGuid=lsData.guid

if old~=nil then
local oldItem=self.discipleListPanel:getChildLayoutGroupGridItem(old-1)
self:changItemBG(oldItem,false)
end
local item=self.discipleListPanel:getChildLayoutGroupGridItem(idx-1)
self:changItemBG(item,true)

self:initDescPanel()
end

function UILingShouAttrLookWin:initDescPanel()
self:getDescList()
local pagenum=#self.descList
self.desccreater:setChildLayoutGroupCreateItems(pagenum)
local grids=self.desccreater:getChildLayoutGroupGridList()
for i=1,pagenum do
local item=grids[i-1]
self:refreshPageItem(item,i)
end
end

function UILingShouAttrLookWin:refreshPageItem(item,pageidx)
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

function UILingShouAttrLookWin:onCopy()
platformHelper.copyTextToClipboard(tostring(self.lsGuid))
end


function UILingShouAttrLookWin:getDescList()
local lsData=self.lsDataList[self.curSelect]
local lsGuid=lsData.guid
local descList={}
local desc,attrs
local titleName={
'资质','潜力','攻击','防御','生命','词条效果列表','特质效果列举','修为获取效率（丹药）'
}
local idx=0


idx=idx+1
desc={name=titleName[idx],childlist={}}
desc.childlist[1]=FMT.fmt("基础:{0}",lsData.zizhi)
desc.childlist[2]=FMT.fmt("特质加成:{0}",lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_DATA_ADD,6)or 0)
desc.childlist[3]=FMT.fmt("传功损失:{0}",lingshouModel:getReduceZiZhiValByLsGuid(lsGuid)or 0)
desc.childlist[4]=FMT.fmt("结算:{0}",lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.ZIZHI)or 0)
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
desc.childlist[1]=FMT.fmt("基础:{0}",lsData.qianli)
desc.childlist[2]=FMT.fmt("特质加成:{0}",lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_DATA_ADD,7)or 0)
desc.childlist[3]=FMT.fmt("结算:{0}",lingshouModel.getLingShouPropertyVal(lsData,lingshouPropertyType.QIANLI)or 0)
table.insert(descList,desc)

local lastAttrLookup=lingshouModel:getAllAttrList(lsData,true)
local allAttrLookup=lsData.allAttrLookup
local allAttrRateLookup=lsData.allAttrRateLookup

idx=idx+1
desc={name=titleName[idx],childlist={}}
desc.childlist[1]=FMT.fmt("结算:{0}",lastAttrLookup[eAttributeType.eATK]or 0)
desc.childlist[2]=FMT.fmt("基础:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eBase,eAttributeType.eATK)or 0)
desc.childlist[3]=FMT.fmt("境界附加:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eJingJie,eAttributeType.eATK)or 0)
desc.childlist[4]=FMT.fmt("潜力附加:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eQianLi,eAttributeType.eATK)or 0)
desc.childlist[5]=FMT.fmt("血脉附加:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eXueMai,eAttributeType.eATK)or 0)
desc.childlist[6]=FMT.fmt("潜力加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eQianLi,eAttributeType.eATK)or 0)
desc.childlist[7]=FMT.fmt("血脉加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eXueMai,eAttributeType.eATK)or 0)
desc.childlist[8]=FMT.fmt("饲养加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eDJob,eAttributeType.eATK)or 0)
desc.childlist[9]=FMT.fmt("特质加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eTrait,eAttributeType.eATK)or 0)
desc.childlist[10]=FMT.fmt("功法加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eDzGongFa,eAttributeType.eATK)or 0)

table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
desc.childlist[1]=FMT.fmt("结算:{0}",lastAttrLookup[eAttributeType.eDEF]or 0)
desc.childlist[2]=FMT.fmt("基础:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eBase,eAttributeType.eDEF)or 0)
desc.childlist[3]=FMT.fmt("境界附加:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eJingJie,eAttributeType.eDEF)or 0)
desc.childlist[4]=FMT.fmt("潜力附加:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eQianLi,eAttributeType.eDEF)or 0)
desc.childlist[5]=FMT.fmt("血脉附加:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eXueMai,eAttributeType.eDEF)or 0)
desc.childlist[6]=FMT.fmt("潜力加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eQianLi,eAttributeType.eDEF)or 0)
desc.childlist[7]=FMT.fmt("血脉加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eXueMai,eAttributeType.eDEF)or 0)
desc.childlist[8]=FMT.fmt("饲养加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eDJob,eAttributeType.eDEF)or 0)
desc.childlist[9]=FMT.fmt("特质加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eTrait,eAttributeType.eDEF)or 0)
desc.childlist[10]=FMT.fmt("功法加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eDzGongFa,eAttributeType.eDEF)or 0)

table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
desc.childlist[1]=FMT.fmt("结算:{0}",lastAttrLookup[eAttributeType.eHP]or 0)
desc.childlist[2]=FMT.fmt("基础:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eBase,eAttributeType.eHP)or 0)
desc.childlist[3]=FMT.fmt("境界附加:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eJingJie,eAttributeType.eHP)or 0)
desc.childlist[4]=FMT.fmt("潜力附加:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eQianLi,eAttributeType.eHP)or 0)
desc.childlist[5]=FMT.fmt("血脉附加:{0}",table.getKeyValue(allAttrLookup,lingshouAttributeType.eXueMai,eAttributeType.eHP)or 0)
desc.childlist[6]=FMT.fmt("潜力加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eQianLi,eAttributeType.eHP)or 0)
desc.childlist[7]=FMT.fmt("血脉加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eXueMai,eAttributeType.eHP)or 0)
desc.childlist[8]=FMT.fmt("饲养加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eDJob,eAttributeType.eHP)or 0)
desc.childlist[9]=FMT.fmt("特质加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eTrait,eAttributeType.eHP)or 0)
desc.childlist[10]=FMT.fmt("功法加成:{0}",table.getKeyValue(allAttrRateLookup,lingshouAttributeType.eDzGongFa,eAttributeType.eHP)or 0)

table.insert(descList,desc)

local lsTrait=lingshouModel.lsTraitEffectLookup[lsData.guid_str]
local laindex=0
idx=idx+1
local lalist={}
desc={name=titleName[idx],childlist=lalist}
for word,typeLookup in pairs(lsTrait)do
local name=cfgHelper.get(cfg_lingshouwordconfig_get,word,'name')
for type,list in pairs(typeLookup)do
for _,args in ipairs(list)do
laindex=laindex+1
lalist[laindex]=FMT.fmt("{0}-{1}-{2}\n{3}",word,name,type,serializeHelper.serializeEx(args))
end
end
end
table.insert(descList,desc)

local lsTraitResult=lingshouModel.lsTraitEffectResultLookup[lsData.guid_str]
local laindex=0
idx=idx+1
local lalist={}
desc={name=titleName[idx],childlist=lalist}
for type,lookup in pairs(lsTraitResult)do
laindex=laindex+1
lalist[laindex]=FMT.fmt("{0}:::{1}",type,serializeHelper.serializeEx(lookup))
end
table.insert(descList,desc)


idx=idx+1
desc={name=titleName[idx],childlist={}}
desc.childlist[1]=FMT.fmt("基础:{0}",0)
local xwRate_dy_zizhiAdd=lingshouModel:getLsZiZhiAddXiuLianExpRate(lsData)
desc.childlist[2]=FMT.fmt("资质加成:{0}",xwRate_dy_zizhiAdd or 0)
local xwRate_dy_tezhiAdd=lingshouModel:getLingShouTraitEffect(lsData,lingshouTraitEffectEnum.LINGSHOU_XIUWEI_GET_RATE_ADD,1)
desc.childlist[3]=FMT.fmt("特质加成:{0}",xwRate_dy_tezhiAdd and xwRate_dy_tezhiAdd/100 or 0)
local xwRate_dy_buildingBuffAdd=zongmenModel:getBenefitBuildingBuffAddition(false,BENEFIT_BUFF_EFFECT_TYPE.eLingShouJJSpeed,2)
desc.childlist[4]=FMT.fmt("建筑加成:{0}",xwRate_dy_buildingBuffAdd and xwRate_dy_buildingBuffAdd/100 or 0)
desc.childlist[5]=FMT.fmt("结算:{0}",xwRate_dy_zizhiAdd+xwRate_dy_tezhiAdd/100+xwRate_dy_buildingBuffAdd/100)
table.insert(descList,desc)

self.descList=descList
end



