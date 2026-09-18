







def_class("UISubAct_DaoBingGePreviewWin",UIWindowBase)









function UISubAct_DaoBingGePreviewWin:bindComponents()

self.Content=UIObject.get(self,0)
self.ScrollView=UIScrollViewSlow.get(self,1)
self.line=UIObject.get(self,2)
self.daobingZhuanShuShentong=UIObject.get(self,3)
self.daobingWeaponShentong=UIObject.get(self,4)
self.daobingVocShentong=UIObject.get(self,5)
self.daobingContent=UIObject.get(self,6)
self.attr1=UIObject.get(self,7)
self.attr2=UIObject.get(self,8)
self.attr3=UIObject.get(self,9)
self.maxlvBtn=UIButton.get(self,10)
self.selectBtn=UIButton.get(self,11)
self.daobingScrollView=UIObject.get(self,12)
self.daobingInfo=UIObject.get(self,13)
self.daobingBaseAttr=UIObject.get(self,14)
self.closeTag=UIObject.get(self,15)
self.openTag=UIObject.get(self,16)
self.selectTxt=UIText.get(self,17)
self.skill_3=UIObject.get(self,18)
self.skill_2=UIObject.get(self,19)
self.skill_1=UIObject.get(self,20)
self.titleName=UIImage.get(self,21)
self.select=UIObject.get(self,22)
self.dbmodel=UIObject.get(self,23)
self.modelClick=UIButton.get(self,24)
self.title=UIText.get(self,25)

self.maxlvBtn:setButtonClick(function()self:onMaxlvBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.modelClick:setButtonClick(function()self:onModelClick()end)
self.skill={
self.skill_1,
self.skill_2,
self.skill_3,
}



end


function UISubAct_DaoBingGePreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.line);self.line=nil;
_UIObject_release(self.daobingZhuanShuShentong);self.daobingZhuanShuShentong=nil;
_UIObject_release(self.daobingWeaponShentong);self.daobingWeaponShentong=nil;
_UIObject_release(self.daobingVocShentong);self.daobingVocShentong=nil;
_UIObject_release(self.daobingContent);self.daobingContent=nil;
_UIObject_release(self.attr1);self.attr1=nil;
_UIObject_release(self.attr2);self.attr2=nil;
_UIObject_release(self.attr3);self.attr3=nil;
_UIObject_release(self.maxlvBtn);self.maxlvBtn=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.daobingScrollView);self.daobingScrollView=nil;
_UIObject_release(self.daobingInfo);self.daobingInfo=nil;
_UIObject_release(self.daobingBaseAttr);self.daobingBaseAttr=nil;
_UIObject_release(self.closeTag);self.closeTag=nil;
_UIObject_release(self.openTag);self.openTag=nil;
_UIObject_release(self.selectTxt);self.selectTxt=nil;
_UIObject_release(self.skill_3);self.skill_3=nil;
_UIObject_release(self.skill_2);self.skill_2=nil;
_UIObject_release(self.skill_1);self.skill_1=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.select);self.select=nil;
_UIObject_release(self.dbmodel);self.dbmodel=nil;
_UIObject_release(self.modelClick);self.modelClick=nil;
_UIObject_release(self.title);self.title=nil;
self.skill=nil;
end

















local _colorStr='<color=#7d3b17>{0}：</color><color=#171311>{1}</color>'

function UISubAct_DaoBingGePreviewWin:onLoaded(...)
self:bindComponents()
self.ScrollView:setSlowClickAction(function(...)self:onClickGrid(...)end)
self.ScrollView:bindSlowWidget(function(...)
self:bindGrid(...)
end)
self.showMax=false
self:freshToggle()
end

function UISubAct_DaoBingGePreviewWin:__delete()
self:unbindComponents()
end

function UISubAct_DaoBingGePreviewWin:onShow(argtable,afterOnloaded)
local actId=argtable.actId
local subType=argtable.subType
local subId=argtable.subId
self.subCfg=activitiesModel:getSubActivityConfig(subType,subId)
self.model=activitiesModel:getSubActInfo(actId,subType,subId)
self.dbitemid=self.subCfg.dbitemid
self.starlv=0
self.jllv=0
self:freshInfo()
end

function UISubAct_DaoBingGePreviewWin:onHide()

end





function UISubAct_DaoBingGePreviewWin:onModelClick()
tipsManager.showTips({itemid=self.itemid})
end

function UISubAct_DaoBingGePreviewWin:onSelectBtn()
local itemid=self.model:getRecordDaoBingItemid()
if itemid==self.itemid then return end
self.model:setRecordDaoBingItemid(self.itemid)
self:freshSelect()
UIManager:callWindowFunc('UISubAct_DaoBingGeWin','onChangeDaoBing',self.itemid)
end

function UISubAct_DaoBingGePreviewWin:onMaxlvBtn()
local showMax=not self.showMax
self.showMax=showMax
local itemid=self.itemid
self.jllv=showMax and daobingConfig.getJinglianMaxLv(itemid)or 0
self.starlv=showMax and daobingConfig.getStarMaxLv(itemid)or 0
self:freshGridMax()
self:freshMidPanel()
self:freshRightPanel()
end

function UISubAct_DaoBingGePreviewWin:onClickGrid(itemid,index,guid,attach)
if tostring(self.itemid)==tostring(itemid)then return end
local oldid=self.itemid
self.itemid=itemid
if oldid then
local oldIdx=self:getIndex(oldid)
self.ScrollView:freshSlowItem(oldIdx-1)
end
self.ScrollView:freshSlowItem(index-1)
self:freshMidPanel()
self:freshRightPanel()
end

function UISubAct_DaoBingGePreviewWin:freshInfo()
self:freshArgs()
self:freshLeftPanel()
self:freshMidPanel()
self:freshRightPanel()
end


function UISubAct_DaoBingGePreviewWin:freshArgs()
local subCfg=self.subCfg
local actId=self.actId
local subType=self.subType
local subId=self.subId
local data=activitiesModel:getSubActInfoData(actId,subType,subId)
local prizelv,prizeluxuryLv=self.model:getPrizelv()
self.speRLevel=prizeluxuryLv
local lv_info=subCfg.lv_info
self.maxLevel=lv_info[1]
end

function UISubAct_DaoBingGePreviewWin:freshLeftPanel()
local dbitemid=self.dbitemid
local itemCfg=itemsConfig.getConfig(dbitemid)

local itemlist=itemCfg.funcparam.itemList
self.itemlist=itemlist
if self.itemid==nil then self.itemid=itemlist[1][1]end
local rNum=#itemlist
local row=math.ceil(rNum/1)
self.ScrollView:freshSlowGrids(rNum,row,1,true)
end

function UISubAct_DaoBingGePreviewWin:bindGrid(index,widget)
local itemInfo=self.itemlist[index]
local itemid=itemInfo[1]
local showMax=self.showMax
local itemCfgs=itemsConfig.getConfig(itemid)
local color=itemCfgs.color
local iconName=iconHelper.getIconName(itemid)
local isSelect=tostring(self.itemid)==tostring(itemid)
local jllv=showMax and daobingConfig.getJinglianMaxLv(itemid)or 0
local jinglianStr=jllv>0 and FMT.fmt('+{0}',jllv)or''
local starlv=showMax and daobingConfig.getStarMaxLv(itemid)or 0
widget:SetChildQulaity(0,color)
widget:SetChildIcon(1,iconName,false)
widget:SetChildActive(2,jinglianStr~='')
widget:SetChildText(3,jinglianStr)
widget:SetChildActive(4,isSelect)
widget:SetChildActive(5,false)
widget:SetChildStarNumber(6,starlv)
widget:SetBaseItemChildID(-1,itemid)
if isSelect then
self.starlv=starlv
self.jllv=jllv
end
if self.needFocus and isSelect then
self.needFocus=nil
self.ScrollView:jumpToSlowItem(index)
end
end

function UISubAct_DaoBingGePreviewWin:freshGridMax()
local itemlist=self.itemlist
local rNum=#itemlist
for i=1,rNum do
local widget=self.ScrollView:getSlowItemByIndex(i-1)
if widget then
local itemInfo=self.itemlist[i]
local itemid=itemInfo[1]
local showMax=self.showMax
local jllv=showMax and daobingConfig.getJinglianMaxLv(itemid)or 0
local jinglianStr=jllv>0 and FMT.fmt('+{0}',jllv)or''
local starlv=showMax and daobingConfig.getStarMaxLv(itemid)or 0
widget:SetChildActive(2,jinglianStr~='')
widget:SetChildText(3,jinglianStr)
widget:SetChildStarNumber(6,starlv)
end
end

end

function UISubAct_DaoBingGePreviewWin:getIndex(itemid)
for i,v in ipairs(self.itemlist)do
if v[1]==itemid then
return i
end
end
end

function UISubAct_DaoBingGePreviewWin:freshMidPanel()
local itemid=self.itemid


local itemsCfg=itemsConfig.getConfig(itemid)
local modelParams=itemsCfg.model
local effectInfo=self.showMax and modelParams[2]or modelParams[1]
self.dbmodel:setChildShowEffect(effectInfo[1],true)
self.titleName:setSprite(globalABLookup.daobingsprite,iconHelper.getDaobingNameIcon(itemsCfg.nameicon))

local skills=daobingHelper.getWeaponShentong(itemid)
local starlv=self.starlv
local skilllv=daobingConfig.getWeaponShentongLvByStar(starlv)
local len=#self.skill
for i=1,len do
local item=self.skill[i]
local skillid=skills[i]
item:setActive(skillid~=nil)

if skillid then
local widget=item:getWidgetBase()
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillid)
widget:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)
widget:SetChildText(1,cfgHelper.get2(cfg_skillconfig_get,skillid,'name'))
widget:SetChildButtonClick(2,function()
if self and not self.isClose then
UIManager:showWindow('UIDaoBingSkillWin',{itemid=itemid,skillid=skillid,skilllv=skilllv})
end
end,true)
end
end
self:freshSelect()
self:freshToggle()

local desc=itemsCfg.desc or
FMT.fmt('解锁内门特训并提升等级至<color=#7d3b17><size=28>{0}级</size></color>后， 可在左侧物品栏中选择任意一把作为奖励',30)
self.title:setText(desc)
end

function UISubAct_DaoBingGePreviewWin:freshSelect()
local itemid=self.model:getRecordDaoBingItemid()
local isPrizeAll=self.speRLevel>=self.maxLevel
local vis=true
local vis2=false
if isPrizeAll then
vis=false
vis2=self.itemid==itemid
elseif self.itemid==itemid then
vis=false
vis2=true
end
self.selectBtn:setActive(vis)
self.select:setActive(vis2)
end

function UISubAct_DaoBingGePreviewWin:freshToggle()
local showMax=self.showMax
self.closeTag:setActive(not showMax)
self.openTag:setActive(showMax)
end

function UISubAct_DaoBingGePreviewWin:freshRightPanel()
local itemid=self.itemid
local itemsCfg=itemsConfig.getConfig(itemid)
local type1=itemsCfg.type1
local type2=itemsCfg.type2


local weaponType=equipsConfig.getWeaponConfig(type2).name
local typeName=FMT.fmt(_colorStr,'类型',FMT.fmt('道兵（{0}）',weaponType))
local jllv=self.jllv
local starlv=self.starlv

local widget=self.daobingInfo:getWidgetBase()
widget:SetChildStarNumber(0,starlv)
widget:SetChildText(1,typeName)



local baseAttrList=daobingHelper.getBaseAttrsList(itemsCfg)or{}
local jlbaseAttrList=daobingHelper.getJinglianBaseAttrs(itemid,jllv)
local jlBaseAttrsLookup=attrListHelper.tramsformToLookup(jlbaseAttrList)

local jlBaseAttrsAddLookup=daobingHelper.getJinglianAddPercentBaseAttrs(itemid,starlv,jllv)


local starBaseAttrsAddLookup=daobingHelper.getStarAddPercentBaseAttrs(itemid,starlv,jllv)

local attrwidget=self.daobingBaseAttr:getWidgetBase()
for i=1,3 do
local attrInfo=baseAttrList[i]
if attrInfo then
local attrType=attrInfo[1]
local baseVal=attrInfo[2]+(jlBaseAttrsLookup[attrType]or 0)
local jlVal=jlBaseAttrsAddLookup[attrType]or 0
local starVal=starBaseAttrsAddLookup[attrType]or 0
local widget=attrwidget:GetChildWidgetBase(i-1)
self:setAttr(widget,attrType,baseVal+jlVal+starVal)
else
self:setAttr(i)
end
end

local hasLast=false

local useSkillids,allSkillids=daobingHelper.getZhuanShuShentong(itemid)
local len=#allSkillids
self.daobingZhuanShuShentong:setActive(len>0)
if len>0 then
hasLast=true
local skilllv=daobingConfig.getZhuanShuShentongLvByStar(starlv)
local widget=self.daobingZhuanShuShentong:getWidgetBase()
widget:SetChildLayoutGroupCreateItems(2,len)
local grids=widget:GetChildLayoutGroupGridList(2)
for i=1,len do
local item=grids[i-1]
local skillid=allSkillids[i]
local cfg=fabaoConfig.getShentongConfig(skillid)
local name=cfg.name
local desc=skillModel:getSkillDesc(skillid,skilllv)
local descEx=skillModel:getSkillDescEx(skillid,skilllv)or{}
for i,v in ipairs(descEx)do
local str=FMT.fmt('<color=#F15508>{0}</color>',v)
desc=FMT.fmt('{0}\n{1}',desc,str)
end
desc=FMT.cfmt2('#171311',desc)
item:SetChildText(0,desc)
end
end


local skillids=daobingHelper.getWeaponShentong(itemid)
local len=#skillids
self.daobingWeaponShentong:setActive(len>0)
if len>0 then
local skilllv=daobingConfig.getWeaponShentongLvByStar(starlv)
local widget=self.daobingWeaponShentong:getWidgetBase()
widget:SetChildLayoutGroupCreateItems(2,len)
local grids=widget:GetChildLayoutGroupGridList(2)
for i=1,len do
local item=grids[i-1]
local skillid=skillids[i]
local cfg=fabaoConfig.getShentongConfig(skillid)
local name=cfg.name
local nameTitle=FMT.fmt('<color=#6833c0>【{0}{1}级】</color>',name,skilllv)
local desc=skillModel:getSkillDesc(skillid,skilllv)
desc=FMT.fmt('{0}{1}',nameTitle,desc)
local descEx=skillModel:getSkillDescEx(skillid,skilllv)or{}
for i,v in ipairs(descEx)do
local str=FMT.fmt('<color=#F15508>{0}</color>',v)
desc=FMT.fmt('{0}\n{1}',desc,str)
end
desc=self.showMax and FMT.cfmt(FONT_COLOR.eOrangeColor,desc)or FMT.cfmt2('#171311',desc)
item:SetChildText(0,desc)
end
widget:SetChildActive(0,hasLast)
hasLast=true
end


local useSkillids,allSkillids=daobingHelper.getVocShentong(itemid)
local len=#allSkillids
self.daobingVocShentong:setActive(len>0)
if len>0 then
local skilllv=daobingConfig.getVocShentongLvByStar(starlv)
local widget=self.daobingVocShentong:getWidgetBase()
widget:SetChildLayoutGroupCreateItems(1,len)
local grids=widget:GetChildLayoutGroupGridList(1)
for i=1,len do
local item=grids[i-1]
local skillid=allSkillids[i]
local desc=skillModel:getSkillDesc(skillid,skilllv)
local descEx=skillModel:getSkillDescEx(skillid,skilllv)or{}
for i,v in ipairs(descEx)do
local str=FMT.fmt('<color=#F15508>{0}</color>',v)
desc=FMT.fmt('{0}\n{1}',desc,str)
end
desc=FMT.cfmt2('#171311',desc)
item:SetChildText(0,desc)
end
widget:SetChildActive(2,hasLast)
hasLast=true
end
end

function UISubAct_DaoBingGePreviewWin:setAttr(widget,attrType,attrValue)
if attrType==nil then
widget:SetChildActive(-1,false)
return
end
widget:SetChildActive(-1,true)
local name,str=equipsHelper.getAttr(attrType,attrValue)
local attrStr=FMT.fmt(_colorStr,name,str)
widget:SetChildText(0,attrStr)
end
