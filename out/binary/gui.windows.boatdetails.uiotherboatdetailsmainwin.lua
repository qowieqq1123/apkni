







def_class("UIOtherBoatDetailsMainWin",UIWindowBase)









function UIOtherBoatDetailsMainWin:bindComponents()

self.attrListContent=UIObject.get(self,0)
self.attrscrollview=UIObject.get(self,1)
self.back=UIObject.get(self,2)
self.equipItem_1=UIBaseItem.get(self,3)
self.equipItem_2=UIBaseItem.get(self,4)
self.equipItem_3=UIBaseItem.get(self,5)
self.equipSlot=UIBaseItem.get(self,6)
self.icon=UIObject.get(self,7)
self.nameText=UIText.get(self,8)
self.notSkillEquipText=UIText.get(self,9)
self.pifuNameText=UIText.get(self,10)
self.root=UIObject.get(self,11)
self.ruleBtn=UIButton.get(self,12)
self.shipListContent=UIObject.get(self,13)
self.shipscrollview=UIObject.get(self,14)
self.skillItem_1=UIObject.get(self,15)
self.skillItem_2=UIObject.get(self,16)
self.skillItem_3=UIObject.get(self,17)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)
self.equipItem={
self.equipItem_1,
self.equipItem_2,
self.equipItem_3,
}
self.skillItem={
self.skillItem_1,
self.skillItem_2,
self.skillItem_3,
}



end


function UIOtherBoatDetailsMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrListContent);self.attrListContent=nil;
_UIObject_release(self.attrscrollview);self.attrscrollview=nil;
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.equipItem_1);self.equipItem_1=nil;
_UIObject_release(self.equipItem_2);self.equipItem_2=nil;
_UIObject_release(self.equipItem_3);self.equipItem_3=nil;
_UIObject_release(self.equipSlot);self.equipSlot=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.nameText);self.nameText=nil;
_UIObject_release(self.notSkillEquipText);self.notSkillEquipText=nil;
_UIObject_release(self.pifuNameText);self.pifuNameText=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.shipListContent);self.shipListContent=nil;
_UIObject_release(self.shipscrollview);self.shipscrollview=nil;
_UIObject_release(self.skillItem_1);self.skillItem_1=nil;
_UIObject_release(self.skillItem_2);self.skillItem_2=nil;
_UIObject_release(self.skillItem_3);self.skillItem_3=nil;
self.equipItem=nil;
self.skillItem=nil;
end
















local _this=nil

local body_id={
back=2072,
menu=2017,
}

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemNew=7,
cmpItemReddot=8,
cmpLock=9,
cmpFabaoTag=10,
cmpCountBg=11,
cmpStar=12,
cmpSuitIcon=13,
cmpLiandon=14,
cmpBtn=15,
}



function UIOtherBoatDetailsMainWin:onLoaded(...)
self:bindComponents()
_this=self
self.isInitBoatList=false
end


function UIOtherBoatDetailsMainWin:__delete()
self:unbindComponents()
_this=nil
self.isInitDiscipleList=false
end




function UIOtherBoatDetailsMainWin:onShow(argtable,afterOnloaded)
self.boatlist=argtable.list
self.curBoatIndex=argtable.index
self.fortresslv=argtable.fortresslv

if self.curBoatIndex==nil then
self.curBoatIndex=1
end
self.curBoatId=self.boatlist[self.curBoatIndex].boatid

local isfirst=afterOnloaded

local firstcb=function()
if not self.isInitBoatList then
self.isInitBoatList=true
self:refreshBoatList()
end
self:refreshWin()
end

local cb=nil
if isfirst then
cb=firstcb
end
self.back:setChildUIModelShowTarget(body_id.back,1,{},eAnimationID.common_window_enter,false,false,0,cb)
if not isfirst then
firstcb()
end

self.root:setChildCanvasGroupAlpha(0)
local cavasGroup=self.root:getCommonComponent('CanvasGroup')
if self.tweener then
self.tweener:Kill(false)
self.tweener=nil
end
self.tweener=_DOTweenProxy.DOFade(cavasGroup,1,1)
self.tweener:SetDelay(0.2)
end

function UIOtherBoatDetailsMainWin:refreshWin()
local boatData=self.boatlist[self.curBoatIndex]
self.nameText:setText(boatData.name)
local boatCfg=cfgHelper.get1(cfg_fairylandboatconfig_get,boatData.boatid)
local scale=boatCfg.modelUIParams[1]
self.icon:setChildUIModelShowTarget(boatCfg.model,scale,nil,eAnimationID.stand)
local attrLookup={}
if boatData.attrlistlen>0 then
for i=1,boatData.attrlistlen do
local attr=boatData.attrList[i]
if attr~=nil then
attrLookup[attr.param_1]=(attrLookup[attr.param_1]or 0)+attr.param_2
end
end
end




























helper.getAttrRelationShipChange(attrLookup)
local abname="ui/windows/xianyungang/xianyungang_atlas_pak.ab"
local attrTypes={
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
eAttributeType.eJZ_CNT_VALUE,
eAttributeType.eYZ_Speed,
eAttributeType.ePoZhen,
}
local attrTypeData={
[eAttributeType.eJZATK_PCT]={icon=6,attr=0},
[eAttributeType.eJZDEF_PCT]={icon=1,attr=0},
[eAttributeType.eJZHP_PCT]={icon=2,attr=0},
[eAttributeType.eJZ_CNT_VALUE]={icon=4,attr=0,name="弟子军阵",getValue=function()
local cfg=cfgHelper.get1(cfg_tianshudianconfig_get,self.fortresslv)
return xianjieModel:getOtherJiJieAddCount(cfg.czxs_max_cnt,attrLookup)
end},
[eAttributeType.eYZ_Speed]={icon=3,attr=10000},
[eAttributeType.ePoZhen]={icon=5,attr=10000},
}

self.attrListContent:setChildLayoutGroupCreateItems(#attrTypes,function(index)
local item=self.attrListContent:getChildLayoutGroupGridItem(index-1)
local attrID=attrTypes[index]
local attrValue=0
if attrTypeData[attrID].getValue then
attrValue=attrTypeData[attrID].getValue()
else
attrValue=attrTypeData[attrID].attr+(attrLookup[attrID]or 0)
end
local attrCfg=cfgHelper.get1(cfg_attributesconfig_get,attrID)

item:SetChildText(0,attrTypeData[attrID].name or attrCfg.attrname)
item:SetChildText(1,helper.getAttributeStrEx(attrID,attrValue))
item:SetChildCSImageSprite(2,abname,FMT.fmt("icon_yunzhoushuxing_{0}",attrTypeData[attrID].icon))

item:SetChildButtonClick(-1,function()
local d={}
d.title=FMT.fmt('【{0}】',attrTypeData[attrID].name or attrCfg.attrname)
d.desc=cfgHelper.getlang(FMT.fmt("YunZhouAttrDesc_{0}",attrID))
local posVector2=item:GetChildScreenPointToLocalPointRectangle(-1)
local posX=posVector2.x+120
local posY=posVector2.y+45
d.pos={posX,posY}
UIManager:showWindow('UIXianYunGangAttrDescWin',d)
end)
end)

self:refreshEquipList()
self:refreshEquipSlot()
end

function UIOtherBoatDetailsMainWin:refreshEquipList()
local boatData=self.boatlist[self.curBoatIndex]
self.equipList={}
for i=1,boatData.zq4listlen do
local zq4Data=boatData.zq4List[i]
local itemConfig=itemsConfig.getConfig(zq4Data.itemid)
self.equipList[itemConfig.type1]=zq4Data
end

for i=1,3 do
self:refreshEquipItemEx(i)
end
end

function UIOtherBoatDetailsMainWin:refreshEquipItemEx(idx)
local widget=self.equipItem[idx]:getChildWidgetBase()
local equip=self.equipList[idx]
local typename
if idx==1 then
typename="龙首"
elseif idx==2 then
typename="龙骨"
else
typename="阵炉"
end
widget:SetChildText(_itemWidgetIdx.cmpItemName,typename)
widget:SetChildText(_itemWidgetIdx.cmpItemAdd,typename)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=false
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=''
local star=stage

local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('{0}级',jinglianlv)or''
local iconName=iconHelper.getIconName(itemid)
local reddot=false
local suitid=itemConfig.type2
local suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,suitid,itemConfig.color)
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)


widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetChildButtonClick(_itemWidgetIdx.cmpBtn,function()self:onClickYunZhouComponents(idx)end)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,true)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetChildButtonClick(_itemWidgetIdx.cmpBtn,function()self:onClickYunZhouComponents(idx)end)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIOtherBoatDetailsMainWin:onClickYunZhouComponents(pos)
local equip=self.equipList[pos]
local suitData=XianYunGangModel:getOtherPlayerYunZhouComponentsSuitData(self.equipList)
if equip then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchRoleItem,itemguid=equip.itemguid,itemid=equip.itemid,attach={suitData=suitData,itemData=equip.itemData,pos=pos}})
end
end

function UIOtherBoatDetailsMainWin:refreshEquipSlot()
self.skillList={}

local boatData=self.boatlist[self.curBoatIndex]
local widget=self.equipSlot:getChildWidgetBase()
local equip=boatData.zq2List and boatData.zq2List[1]or nil
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local isLD=liandonModel:getIsLianDonItem(itemid)
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local star=0

local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local iconName=iconHelper.getIconName(itemid)
local reddot=false
local suitIconName=equipsHelper.getEquipSuitIcon(equip)


widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,isLD)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)


if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,true)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpLiandon,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end

for i=1,3 do
self:refreshSkillSlotEx(i)
end
end

function UIOtherBoatDetailsMainWin:refreshSkillSlotEx(idx,showEffect)
local skillItem=self.skillItem[idx]
local item=skillItem:getChildWidgetBase()
local d=self.skillList[idx]
if d then
local skillID=d[1]
local skillLv=d[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local islock=skillLv<=0
item:SetChildActive(-1,true)

item:SetChildIcon(0,iconHelper.getSkillIcon(skillCfg.icon),false)

local isgray=islock
item:SetChildImageExGray(0,isgray)

local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(1,is_bd)

item:SetChildActive(4,not islock)
if not islock then
local c_skillLv=skillLv
if st==eSkillTipsType.eDZGFSkill then
c_skillLv=UIDiscipleModel:getSkillLv(self.disciple_guid,skillID,c_skillLv)
end
item:SetChildText(2,skillModel:getSkillLvStr(c_skillLv))
end

item:SetChildActive(5,islock)

item:SetChildText(7,skillCfg.name)

item:SetChildButtonClick(3,function()
self:onSkillItemClick(eSkillTipsType.eDZGFSkill,skillID,skillLv)
end)
else
item:SetChildActive(-1,false)
end
end


function UIOtherBoatDetailsMainWin:onHide()

end

function UIOtherBoatDetailsMainWin:refreshBoatList()
local shipDatas=self.boatlist
local shipNumber=#self.boatlist
self.shipListContent:setChildLayoutGroupCreateItems(shipNumber,function(index)
local boatData=shipDatas[index]
local item=self.shipListContent:getChildLayoutGroupGridItem(index-1)
item:SetChildText(2,boatData.name)


local isSelect=self.curBoatId==boatData.boatid
if isSelect then
self.curBoatIndex=index
end
self:changItemSelect(item,isSelect)


item:SetBaseItemClickEvent(-1,function()
if self.curBoatIndex==index then return end
if self.curBoatIndex then
local oldItem=self.shipListContent:getChildLayoutGroupGridItem(self.curBoatIndex-1)
self:changItemSelect(oldItem,false)
end
self.curBoatIndex=index
self:changItemSelect(item,true)

self:refreshWin()
end)
end)


self.shipscrollview:setChildScrollRectEnable(true)
end

function UIOtherBoatDetailsMainWin:changItemSelect(item,isSelect)
item:SetChildActive(4,isSelect)
end






function UIOtherBoatDetailsMainWin:onRuleBtn()
local attrLookup={}
local boatData=self.boatlist[self.curBoatIndex]
if boatData.attrlistlen>0 then
for i=1,boatData.attrlistlen do
local attr=boatData.attrList[i]
if attr~=nil then
attrLookup[attr.param_1]=(attrLookup[attr.param_1]or 0)+attr.param_2
end
end
end
local xs_cnt=attrLookup[eAttributeType.eJZ_CNT_VALUE]or 0
local d={}
d.title='兵力上限详情'
d.datas={
{desc="云舟总兵力",value=xs_cnt},
{desc="云舟兵力上限",value=120000},
{desc="天枢阁建筑",value=990},
{desc="道衍台兵法",value=20},
{desc="阵旗阵法",value=14},
}
UIManager:showWindow('UIXianYunGangRuleWin',d)
end

function UIOtherBoatDetailsMainWin:onClickClose()
self:closeSelf()
end
