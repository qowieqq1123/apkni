







def_class("UIDiZiLookRivalWin",UIWindowBase)









function UIDiZiLookRivalWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.roleList=UIObject.get(self,1)
self.totalFightText=UIText.get(self,2)
self.model_2=UIObject.get(self,3)
self.model_3=UIObject.get(self,4)
self.model_4=UIObject.get(self,5)
self.model_5=UIObject.get(self,6)
self.model_1=UIObject.get(self,7)
self.infoBtn=UIButton.get(self,8)
self.equipslist=UIObject.get(self,9)
self.polygonAttrPanel=UIObject.get(self,10)
self.shentong=UIObject.get(self,11)
self.lianti=UIText.get(self,12)
self.gfSlot_1=UIButton.get(self,13)
self.gfSlot_2=UIButton.get(self,14)
self.sixAttrText=UIText.get(self,15)
self.jingjie=UIText.get(self,16)
self.stSlot=UIButton.get(self,17)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.infoBtn:setButtonClick(function()self:onInfoBtn()end)

self.gfSlot_1:setButtonClick(function()self:onGfSlot_1()end)

self.gfSlot_2:setButtonClick(function()self:onGfSlot_2()end)

self.stSlot:setButtonClick(function()self:onStSlot()end)
self.model={
self.model_1,
self.model_2,
self.model_3,
self.model_4,
self.model_5,
}
self.gfSlot={
self.gfSlot_1,
self.gfSlot_2,
}



end


function UIDiZiLookRivalWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.roleList);self.roleList=nil;
_UIObject_release(self.totalFightText);self.totalFightText=nil;
_UIObject_release(self.model_2);self.model_2=nil;
_UIObject_release(self.model_3);self.model_3=nil;
_UIObject_release(self.model_4);self.model_4=nil;
_UIObject_release(self.model_5);self.model_5=nil;
_UIObject_release(self.model_1);self.model_1=nil;
_UIObject_release(self.infoBtn);self.infoBtn=nil;
_UIObject_release(self.equipslist);self.equipslist=nil;
_UIObject_release(self.polygonAttrPanel);self.polygonAttrPanel=nil;
_UIObject_release(self.shentong);self.shentong=nil;
_UIObject_release(self.lianti);self.lianti=nil;
_UIObject_release(self.gfSlot_1);self.gfSlot_1=nil;
_UIObject_release(self.gfSlot_2);self.gfSlot_2=nil;
_UIObject_release(self.sixAttrText);self.sixAttrText=nil;
_UIObject_release(self.jingjie);self.jingjie=nil;
_UIObject_release(self.stSlot);self.stSlot=nil;
self.model=nil;
self.gfSlot=nil;
end

















local _this

local _iconAb="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _iconBg={
[1]="image_gwtouxiangpjk_5",
[2]="image_gwtouxiangpjk_4",
[3]="image_gwtouxiangpjk_3",
[4]="image_gwtouxiangpjk_6",
[5]="image_gwtouxiangpjk_2",
}

local equipSlotIndex={
[EQUIP_TYPE.eWeapon]=0,
[EQUIP_TYPE.eClothes]=1,
[EQUIP_TYPE.eCap]=2,
[EQUIP_TYPE.eShoot]=3,
[EQUIP_TYPE.eFabao]=4,
[EQUIP_TYPE.eDaoBing]=5,
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
}


function UIDiZiLookRivalWin:onLoaded(...)
self:bindComponents()
self.equipHandleList={}
self.equipListWidget=self.equipslist:getChildWidgetBase()
for equipType,idx in ipairs(equipSlotIndex)do
self.equipListWidget:SetBaseItemClickEvent(idx,function(...)self:onBaseItemClick(...)end)
self.equipListWidget:SetBaseItemChildIndex(idx,equipType)
end
end


function UIDiZiLookRivalWin:__delete()
self:unbindComponents()

if self.equipHandleList and next(self.equipHandleList)then
watchModel.removeItemList(self.equipHandleList)
self.equipHandleList=nil
end
end




function UIDiZiLookRivalWin:onShow(argtable,afterOnloaded)
local teamList=argtable.teamList

local disciplesList={}
local totalFight=0
for i,v in ipairs(teamList)do
local fight=v:fightValNum_get()or 0
totalFight=totalFight+fight
table.insert(disciplesList,{index=i,data=v})
end
self.disciplesList=disciplesList
self.totalFightText:setText(totalFight)

self:freshDisciplesList()
self:freshModels()



end


function UIDiZiLookRivalWin:onHide()

end


function UIDiZiLookRivalWin:freshDisciplesList()
local num=#self.disciplesList
self.roleList:setChildLayoutGroupCreateItems(num,function(index)
local item=self.roleList:getChildLayoutGroupGridItem(index-1)
local disciple=self.disciplesList[index]
local data=disciple.data
item:SetChildActive(-1,true)
item:SetChildButtonClickWithID(0,function(index)
self:onClickRoleItem(index)
end,index)

local baseData=data.base
item:SetChildText(2,baseData.disciplename)
item:SetChildText(3,FMT.fmt('{0}',data:fightValNum_get()))
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoEx(baseData)
comHelper.setChildModelRawImageEx(1,item,modelParams,eHeadCenterType.eHead)

comHelper.setChildModelHeadIconBGByColor(item,5,data.color or 1)


end)
self:onClickRoleItem(1)
end

function UIDiZiLookRivalWin:onClickRoleItem(index)
if self.selectRoleIdx==index then return end
if self.selectRoleIdx then
local lastItem=self.roleList:getChildLayoutGroupGridItem(self.selectRoleIdx-1)
lastItem:SetChildActive(4,false)
self:refreshModelSelect(false)
end
self.selectRoleIdx=index
local item=self.roleList:getChildLayoutGroupGridItem(self.selectRoleIdx-1)
item:SetChildActive(4,true)
self:freshInfo()
self:refreshModelSelect(true)
end


function UIDiZiLookRivalWin:freshModels()
for i,v in ipairs(self.disciplesList)do
local data=v.data
local index=v.index
self.model[index]:setActive(true)

local widget=self.model[index]:getChildWidgetBase(-1)

local baseData=data.base
local image=UIDiscipleModel.calculationDiscipleImageBase(baseData)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(image)
widget:SetChildUIModelShowTarget(0,modelParams.body,0.8,modelParams.componets,modelParams.anim)
widget:SetChildUIModelShowTargetOffset(0,0,-50)
widget:SetChildText(3,UIDiscipleModel:getJobName(image.job))
end
end

function UIDiZiLookRivalWin:refreshModelSelect(flag)
self:killSpeakTween(self.selectRoleIdx)
local data=self.disciplesList[self.selectRoleIdx]
local index=data.index
local widget=self.model[index]:getChildWidgetBase(-1)
widget:SetChildCanvasGroupAlpha(1,flag and 1 or 0)

widget:SetChildShowEffect(4,10125,flag)
end

function UIDiZiLookRivalWin:killSpeakTween(index)




end

function UIDiZiLookRivalWin:killAllSpeakTween()
for i,v in ipairs(self.disciplesList)do
self:killSpeakTween(i)
end
end


function UIDiZiLookRivalWin:freshInfo()
local disciple=self.disciplesList[self.selectRoleIdx]
local data=disciple.data
local diziguid=data.discipleguidStr
self.diziguid=diziguid
self.diziData=data
local netData=data.base

if not netData then
return
end


local jjlv=netData.jingjielv
local n,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}',n,pN)
else
jj_str=n
end
self.jingjie:setText(jj_str)

local ltlv=netData.liantilv
local n1,p1,pN=UIDiscipleModel:getLTNameX(ltlv)
local lt_lv_str=FMT.fmt('{0}层',p1 or 0)
local lt_str=FMT.fmt('{0}{1}',n1,pN)
self.lianti:setText(lt_str)

self:freshEquip(self.diziData)
self:freshGFSkillSlot(self.diziData)

self:freshFaBaoSkill(self.diziData)
end


function UIDiZiLookRivalWin:freshEquip(dizidata)
local fightEquipList=dizidata.fightEquipList
if not fightEquipList then
fightEquipList=dizidata.equipLookup
end
for equipType,idx in ipairs(equipSlotIndex)do
local equip=nil
if fightEquipList then
equip=fightEquipList[equipType]
if equip then
watchModel.setItem(equip)
table.insert(self.equipHandleList,equip.itemguid)
end
end
self:fillItem(equip,idx)
end
end

function UIDiZiLookRivalWin:fillItem(equip,equipSlotIdx)
local prop={}
local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIdx)
local scaleTable={}
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local stage=''
local iconName
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local star=0
if itemsConfig.isFabao(itemid)then
isFabao=true
local jinglianlv=equip.itemData and equip.itemData.jilianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
elseif itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=iconHelper.getIconName(itemid)
elseif itemsConfig.isFubao(itemid)then
iconName=iconHelper.getIconName(itemid)
elseif itemsConfig.isDaoBing(itemid)then
iconName=iconHelper.getIconName(itemid)
star=equip.itemData and equip.itemData.star or 0
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
stageStr=''
end

if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end

widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,true)
widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)

else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
end
end

function UIDiZiLookRivalWin:fillLingShouItem(lsData,equipSlotIdx)
local prop={}
local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIdx)
if lsData then
local ls_guid=lsData.guid
local color=lingshouModel:getColor(ls_guid)

prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemIconIdx)]=true
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCount)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemAdd)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemName)]=false
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemStage)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemStageBg)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemNew)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemReddot)]=false
prop[DataPropKey.eItemID]=lsData.id
prop[DataPropKey.eItemSeries]=ls_guid
else
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemQualityIdx)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemIconIdx)]=false
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCount)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemAdd)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemName)]=true
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemStage)]=''
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemStageBg)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemNew)]=false
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemReddot)]=false
prop[DataPropKey.eItemID]=-1
prop[DataPropKey.eItemSeries]=-1
end
self.equipListWidget:SetChildPropData(equipSlotIdx,prop)
if lsData then
comHelper.setChildModelRawImage_lingshou(widget,lsData.id,_itemWidgetIdx.cmpItemIconIdx,0,eHeadCenterType.eHead,1)
end
end

function UIDiZiLookRivalWin:onBaseItemClick(id,equipType,guid,attach)

if equipType==EQUIP_TYPE.eZhuZhan then return end
if id~=-1 then
tipsManager.showTips({itemid=id,itemguid=guid,move=TIPS_MOVE_POS.eLeft})
end
end

function UIDiZiLookRivalWin:onLingShouItemClick(id,equipType,guid,attach)
if id>0 then
local lsData=otherPlayerModel:getDZLingShouData2(self.diziData)
if lsData then
UIManager:showWindow('UILingShouTipsWin',{lsData=lsData})
end
end
end


function UIDiZiLookRivalWin:freshGFSkillSlot()
for i=1,2 do
self:freshGFSkillSlotEx(i)
end
end

function UIDiZiLookRivalWin:freshGFSkillSlotEx(idx)
local gflist={}

local dzData=self.diziData

if not dzData then
return
end

local baseData=dzData.base

for i,v in ipairs(baseData.gongfaidList)do
local gfid=v
local gflv=0
if gfid>0 then gflv=baseData.gongfaListlookup[gfid].param_2 end
gflist[i]={gfid,gflv}
end
self.usingGFListLevel=gflist
self.usingGFList=baseData.gongfaidList

local slot=self.gfSlot[idx]
local slotItem=slot:getChildWidgetBase()
local gfID=self.usingGFList[idx]
local hasGF=gfID>0

slotItem:SetChildActive(0,hasGF)
if hasGF then
local gfIcon=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'icon')
slotItem:SetChildIcon(0,iconHelper.getGongFaIcon(gfIcon),false)
end

slotItem:SetChildActive(1,hasGF)
if hasGF then
slotItem:SetChildText(2,UIGongFaModel:getGFLeverlStr(gflist[idx][2]))
end

local name_str=''
if hasGF then
local gfname=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'name')
name_str=string.format('<color=#7d3b17>%s</color>',gfname)
else
name_str='尚未习得功法'
end
if self.showType==dicipleType.eTemp then
name_str=''
end
slotItem:SetChildText(3,name_str)
end

function UIDiZiLookRivalWin:onGFSlotClick(idx)
local gfID=self.usingGFList[idx]
local hasGF=gfID>0
if hasGF then
UIManager:showWindow('UIGongFaTipsTwoWin',{guid=nil,gfID=gfID,gfLevel=self.usingGFListLevel[idx][2]})
end
end


function UIDiZiLookRivalWin:freshPolygonAtrrPanel()
local netData,color
local dzData=self.diziData

if not dzData then
return
end

netData=dzData.base
local image=UIDiscipleModel.calculationDiscipleImageBase(netData)
color=image.color

local allnum=0
local ratelist={}
local lookup={6,5,4,3,2,1}
local polygonMaxValue=cfgHelper.getglobal1('discipleattrex_max')
for i,v in ipairs(netData.attrList)do
local a=v==0 and 1 or v
allnum=allnum+a
local aa=a
if aa>polygonMaxValue then
aa=polygonMaxValue
end
ratelist[lookup[i]]=aa/polygonMaxValue
end
self.sixAttrText:setText(FMT.fmt('总值：{0}',allnum))

local wiget=self.polygonAttrPanel:getChildWidgetBase()
for i=1,6 do
local idx=i-1
local attrType=i
local v=netData.attrList[attrType]==0 and 1 or netData.attrList[attrType]
wiget:SetChildText(idx,FMT.fmt('{0} <color=#549327>{1}</color>',UIDiscipleModel:discipleBaseAttrName(attrType),v))
end
wiget:SetChildUIPolygonImage(6,ratelist,0)

local polygonIcon='image_shuxingtu_'..color
wiget:SetChildCSImageSprite(7,globalABLookup.diciplemain,polygonIcon)
end




function UIDiZiLookRivalWin:onCloseBtn()
self:closeSelf()
end



function UIDiZiLookRivalWin:onInfoBtn()
local disguid=self.diziguid
local dzData=self.diziData
local attrLookup=UIDiscipleModel.getAttrListLookup(dzData.attrList)

local args={}
args.titleName='详细属性'
args.pos=1
args.extraWin='UICommonAttrDetailWin'
local extraParams={}
extraParams.attrLookup=attrLookup
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end



function UIDiZiLookRivalWin:onGfSlot_1()
self:onGFSlotClick(1)
end



function UIDiZiLookRivalWin:onGfSlot_2()
self:onGFSlotClick(2)
end


function UIDiZiLookRivalWin:freshFaBaoSkill(diziData)
local equipLookup=diziData.fightEquipList
if not equipLookup then
equipLookup=diziData.equipLookup
end
local equipItem

if equipLookup~=nil then
equipItem=equipLookup[EQUIP_TYPE.eFabao]
end
local shentongid,shentongLv
if equipItem then
shentongid,shentongLv=fabaoHelper.getShentongid(equipItem)
end

local slotItem=self.stSlot:getChildWidgetBase()
local has=shentongid~=nil

slotItem:SetChildActive(0,has)

slotItem:SetChildActive(1,has)
local name_str=''
if has then
local shentongConfig=fabaoConfig.getShentongConfig(shentongid)
local shentongIcon=iconHelper.getSkillIcon(shentongConfig.icon)
local shentongName=shentongConfig.name
slotItem:SetChildIcon(0,shentongIcon,false)
slotItem:SetChildText(2,FMT.fmt('{0}级',shentongLv))
name_str=string.format('<color=#7d3b17>%s</color>',shentongName)
self.stSlotFunc=function()
self:onStSlotFunc(shentongid,shentongLv)
end

else
name_str='尚未穿戴法宝'
self.stSlotFunc=nil
end

slotItem:SetChildText(3,name_str)
end

function UIDiZiLookRivalWin:onStSlotFunc(skillID,skillLv,diziguid)
local args={skillID=skillID,skillLv=skillLv,attend=eSkillTipsType.eDZSTSkill,dis_guid=nil,changLv=false}
UIManager:showWindow('UIDiscipleJobSkillTipsWin',args)
end

function UIDiZiLookRivalWin:onStSlot()
if self.stSlotFunc then
self.stSlotFunc()
end
end
