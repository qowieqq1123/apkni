







def_class("UIBagEquipFilterPartWin",UIWindowBase)









function UIBagEquipFilterPartWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.randomAttrPart=UIObject.get(self,1)
self.resetBtn=UIButton.get(self,2)
self.Root=UIObject.get(self,3)
self.stagePart=UIObject.get(self,4)
self.suitPart=UIObject.get(self,5)
self.title=UIText.get(self,6)
self.typePart=UIObject.get(self,7)
self.uiRoot=UIObject.get(self,8)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)



end


function UIBagEquipFilterPartWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.randomAttrPart);self.randomAttrPart=nil;
_UIObject_release(self.resetBtn);self.resetBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.stagePart);self.stagePart=nil;
_UIObject_release(self.suitPart);self.suitPart=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.typePart);self.typePart=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
end
















local _this=nil

local _filter_Custom={
[BAG_FILTER_TYPE.eEquipPosType]={
initFilterArgs=function(self)
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType]={}
end,
buildFilterArgs=function(self,filterArgs)
local args=filterArgs[ITEM_FILTER_TYPE.eBagEquipType]
if args~=nil then
local idx
local _,info=next(args)
for type,data in pairs(info)do
idx=data[1]
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][idx]=data
end
end
end,
getFilterArgs=function(self,args)
if next(args)then
local temp={}
for index,arg in pairs(args)do








temp[#temp+1]=arg
end
return ITEM_FILTER_TYPE.eBagEquipType,{[ITEM_FILTER_TYPE.eBagEquipType]={[ITEM_FILTER_COMPARE.eEquals]=temp}}
end
return ITEM_FILTER_TYPE.eBagEquipType
end,
onEquipSubFilter=function(self,result)
local data=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][1]or{1}
data[2]=result
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType][1]=data

_this:freshSingleResultArgsList(BAG_FILTER_TYPE.eEquipPosType)
self:refreshEquipTypePart()
end,
},
[BAG_FILTER_TYPE.eStage]={
initFilterArgs=function(self)
self.comFilterArgsList[BAG_FILTER_TYPE.eStage]={}
end,
buildFilterArgs=function(self,filterArgs)
local args=filterArgs[ITEM_FILTER_TYPE.eStage]
if args~=nil then
local _,info=next(args)
for _,idx in pairs(info)do
self.comFilterArgsList[BAG_FILTER_TYPE.eStage][idx]=1
end
end
end,
getFilterArgs=function(self,args)
if next(args)then
local temp={}
for index,arg in pairs(args)do
if arg==1 then
temp[#temp+1]=index
end
end
if#temp==0 then
return ITEM_FILTER_TYPE.eStage
end
return ITEM_FILTER_TYPE.eStage,{[ITEM_FILTER_TYPE.eStage]={[ITEM_FILTER_COMPARE.eEquals]=temp}}
end
return ITEM_FILTER_TYPE.eStage
end,
onEquipSubFilter=function(self,result)end,
},
[BAG_FILTER_TYPE.eEquipSuit]={
initFilterArgs=function(self)
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit]={}
end,
buildFilterArgs=function(self,filterArgs)
local args=filterArgs[ITEM_FILTER_TYPE.eSuitEquip]
if args~=nil then
local _,_args=next(args)
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit]=_args
end
end,
getFilterArgs=function(self,args)
if next(args)then
local temp={}
for index,arg in pairs(args)do
temp[#temp+1]=arg
end
return ITEM_FILTER_TYPE.eSuitEquip,{[ITEM_FILTER_TYPE.eSuitEquip]={[ITEM_FILTER_COMPARE.eEquals]=temp}}
end
return ITEM_FILTER_TYPE.eSuitEquip
end,
onEquipSubFilter=function(self,result)
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit]=result

_this:freshSingleResultArgsList(BAG_FILTER_TYPE.eEquipSuit)
self:refreshEquipSuitPart()
end,
},
[BAG_FILTER_TYPE.eEquipRandomAttr]={
initFilterArgs=function(self)
local temp={}
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr]=temp
local attrs=equipsConfig.getEquipConstConfig().rangeattrs

self.attrsLookup={}

for index,attrid in ipairs(attrs)do

self.attrsLookup[attrid]=index
end
end,
buildFilterArgs=function(self,filterArgs)
local args=filterArgs[ITEM_FILTER_TYPE.eEquipRandomAttr]
if args~=nil then
local _,info=next(args)
for compareType,info in pairs(args)do
local index
for idx,attrid in pairs(info)do
index=self.attrsLookup[attrid]
if compareType==ITEM_FILTER_COMPARE.eAnd then
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr][index]=1
elseif compareType==ITEM_FILTER_COMPARE.eNot then
self.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr][index]=0
end
end
end

end
end,
getFilterArgs=function(self,args)
if next(args)then
local temp={}
local noTemp={}
local attrs=equipsConfig.getEquipConstConfig().rangeattrs
local attrid
for index,state in pairs(args)do
if state==1 then
attrid=attrs[index]
temp[#temp+1]=attrid
elseif state==0 then
attrid=attrs[index]
noTemp[#noTemp+1]=attrid
end
end
if#temp==0 and#noTemp==0 then
return ITEM_FILTER_TYPE.eEquipRandomAttr
end

local filter={[ITEM_FILTER_TYPE.eEquipRandomAttr]={}}

if#temp>0 then
filter[ITEM_FILTER_TYPE.eEquipRandomAttr][ITEM_FILTER_COMPARE.eAnd]=temp
end

if#noTemp>0 then
filter[ITEM_FILTER_TYPE.eEquipRandomAttr][ITEM_FILTER_COMPARE.eNot]=noTemp
end

return ITEM_FILTER_TYPE.eEquipRandomAttr,filter
end
return ITEM_FILTER_TYPE.eEquipRandomAttr
end,
onEquipSubFilter=function(self,result)

end,
},
}




function UIBagEquipFilterPartWin:onLoaded(...)
self:bindComponents()

_this=self

self.comFilterArgsList={}

self.resultFilterArgsList={}

self.equipPosCfgs=cfg_discipleweaponconfig()

end


function UIBagEquipFilterPartWin:__delete()
self:unbindComponents()

_this=nil

self:clearDT()

bagModel.saveBagEquipFilterCount()
end




function UIBagEquipFilterPartWin:onShow(argtable,afterOnloaded)

self.selectBagType=argtable.attach

self.comfirmCallback=argtable.comfirmCallback
self.closeCallBack=argtable.closeCallBack

self.equipBagFilter=argtable.equipBagFilter or{}

self:initData()
self:recordData()
self:freshResultArgsList()

self:refreshAll()

if afterOnloaded then
self:playEnterAnimation()
end
end


function UIBagEquipFilterPartWin:onHide()

end





function UIBagEquipFilterPartWin:onCloseBtn()
if self.closeCallBack then
self.closeCallBack()
end
self:closeSelf()
end



function UIBagEquipFilterPartWin:onResetBtn()
self:initData()
self:refreshAll()
self:freshResultArgsList()
self:onComitBagWin()
end

function UIBagEquipFilterPartWin:initData()
self.filterCfg=bagFilterConfig.getFilter(self.selectBagType)
self.filterTypes={}

local filterType,filterCustom
for index,cfg in pairs(self.filterCfg)do
filterType=cfg.type
self.filterTypes[index]=filterType
filterCustom=_filter_Custom[filterType]
if filterCustom then
filterCustom.initFilterArgs(self)
end
end
end

function UIBagEquipFilterPartWin:recordData()
local filterType,filterCustom
for index,cfg in pairs(self.filterCfg)do
filterType=cfg.type
filterCustom=_filter_Custom[filterType]
if filterCustom then
filterCustom.buildFilterArgs(self,self.equipBagFilter)
end
end
end

function UIBagEquipFilterPartWin:freshResultArgsList()
for type,args in pairs(self.comFilterArgsList)do
self:freshSingleResultArgsList(type,true)
end
end

function UIBagEquipFilterPartWin:freshSingleResultArgsList(type,isNoFreshBag)
local filterList=self.resultFilterArgsList
local args=self.comFilterArgsList[type]
local filterType,filterArgs=_filter_Custom[type].getFilterArgs(self,args)
if filterArgs then
for filterType,filter in pairs(filterArgs)do
filterList[filterType]=filter
end
else
filterList[filterType]=nil
end

if not isNoFreshBag then
self:onComitBagWin()
end
end


function UIBagEquipFilterPartWin:onComitBagWin()
if self.comfirmCallback then

self.comfirmCallback(self.resultFilterArgsList)
notifySystem:postNotify(notifyConfig.onBagEquipFilter)
bagModel.addBagEquipFilterCount()
end
end


function UIBagEquipFilterPartWin:onEquipSubFilter(filterType,result)
_filter_Custom[filterType].onEquipSubFilter(self,result)
end


function UIBagEquipFilterPartWin:refreshAll()

self:refreshEquipTypePart()
self:refreshEquipStagePart()
self:refreshEquipSuitPart()
self:refreshRandomAttrPart()

end



local _typePartWbIndex={
weapon=0,
weaponOption=1,
weaponSub=2,
weaponContentTxt=3,
click=4,
list=5,
armorOption=6,
crownOption=7,
bootsOption=8,
}

local _typeOptions={_typePartWbIndex.weaponOption,_typePartWbIndex.armorOption,_typePartWbIndex.crownOption,_typePartWbIndex.bootsOption}
local _typeToOptionList={EQUIP_TYPE.eWeapon,EQUIP_TYPE.eClothes,EQUIP_TYPE.eCap,EQUIP_TYPE.eShoot}
local _equipPosShowWordNum=5

function UIBagEquipFilterPartWin:refreshEquipTypePart()

local typePartWb=self.typePart:getWidgetBase()

local comFilterArgs=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipPosType]
local filterData,isGray
for index,typeOption in ipairs(_typeOptions)do
filterData=comFilterArgs[index]
isGray=filterData==nil

local typeOptionWb=typePartWb:GetChildWidgetBase(typeOption)
typeOptionWb:SetChildGray(1,isGray)

if typeOption==_typePartWbIndex.weaponOption then
local str='全部'

if not isGray then
local selectList=filterData[2]
local selectLen=#selectList
local isAll=selectList[1]==0 or#self.equipPosCfgs==selectLen

if not isAll then
str=nil
local posCfg
local strLen=0
for pindex,pos in pairs(selectList)do
posCfg=self.equipPosCfgs[pos]
str=str and FMT.fmt('{0}，{1}',str,posCfg.name)or posCfg.name
strLen=strLen+string.lenEx(posCfg.name)
if strLen>_equipPosShowWordNum and pindex~=selectLen then
str=str..'...'
break
end
end
end
end

typePartWb:SetChildGray(_typePartWbIndex.weaponSub,isGray)
typePartWb:SetChildText(_typePartWbIndex.weaponContentTxt,str)

typePartWb:SetChildButtonClick(_typePartWbIndex.click,function()
local args={}
args.titleName="选择武器"
args.extraWin='UIBagEquipSubFilterPartWin'
local extraParams={}
args.extraParams=extraParams
extraParams.invokeWin=_this
extraParams.partType=BAG_FILTER_TYPE.eEquipPosType
extraParams.recordData=comFilterArgs[1]and comFilterArgs[1][2]

UIManager:showWindow('UICommonPageFourWin',args)
end,true)
end

typePartWb:SetBaseItemClickEvent(typeOption,function()
local idx=index
local filter=comFilterArgs[idx]
if filter then
comFilterArgs[idx]=nil


if idx==_typePartWbIndex.weaponOption then
typePartWb:SetChildGray(_typePartWbIndex.weaponSub,true)
typePartWb:SetChildText(_typePartWbIndex.weaponContentTxt,'全部')
end
else
if idx==_typePartWbIndex.weaponOption then
comFilterArgs[idx]={_typeToOptionList[index],{0}}
typePartWb:SetChildGray(_typePartWbIndex.weaponSub,false)
typePartWb:SetChildText(_typePartWbIndex.weaponContentTxt,'全部')
else
comFilterArgs[idx]={_typeToOptionList[index],{}}
end
end
filter=comFilterArgs[idx]

typeOptionWb:SetChildGray(1,filter==nil)
_this:freshSingleResultArgsList(BAG_FILTER_TYPE.eEquipPosType)
end)
end
end



local _maxStageNum=5

function UIBagEquipFilterPartWin:refreshEquipStagePart()
local stagePartWb=self.stagePart:getWidgetBase()

local comFilterArgs=self.comFilterArgsList[BAG_FILTER_TYPE.eStage]

local createFunc=function(index)
local item=stagePartWb:GetChildLayoutGroupGridItem(0,index-1)

local name=FMT.fmt("{0}阶",index)
item:SetChildText(0,name)

local isGray=comFilterArgs[index]==nil or comFilterArgs[index]==0
item:SetChildGray(1,isGray)

item:SetBaseItemClickEvent(-1,function()
isGray=not isGray
comFilterArgs[index]=isGray and 0 or 1

item:SetChildGray(1,isGray)
_this:freshSingleResultArgsList(BAG_FILTER_TYPE.eStage)
end)
end

stagePartWb:SetChildLayoutGroupCreateItems(0,_maxStageNum,createFunc)

self.winlua:ForceLayoutVertical(self.stagePart:getID())
end



local _maxShowSuitNum=4

function UIBagEquipFilterPartWin:refreshEquipSuitPart()
local suitPartWb=self.suitPart:getChildWidgetBase()

local comFilterArgs=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipSuit]
local equipSuitCfgs=cfg_discipleequipsuitconfig()

local isShowTotal=comFilterArgs==nil or next(comFilterArgs)==nil

suitPartWb:SetChildActive(0,not isShowTotal)
suitPartWb:SetChildActive(3,isShowTotal)


if not isShowTotal then
local str=nil
local suitCfg,iconName,chatIconName
for index,suitId in ipairs(comFilterArgs)do
suitCfg=equipSuitCfgs[suitId]
iconName=iconHelper.getSuitIcon(suitCfg.icon)
chatIconName=chatEmotHelper.getIconEmotMesg(iconName,30)
str=str and FMT.fmt("{0}，{1} {2}",str,chatIconName,suitCfg.name)or FMT.fmt("{0} {1}",chatIconName,suitCfg.name)

if index>=_maxShowSuitNum then
str=str..'...'
break
end
end
suitPartWb:SetChildText(1,str)
end

local clickFunc=function()
local args={}
args.titleName="选择套装"
args.extraWin='UIBagEquipSubFilterPartWin'
local extraParams={}
args.extraParams=extraParams
extraParams.invokeWin=_this
extraParams.partType=BAG_FILTER_TYPE.eEquipSuit
extraParams.recordData=comFilterArgs

UIManager:showWindow('UICommonPageFourWin',args)
end

suitPartWb:SetChildButtonClick(2,function()
clickFunc()
end,true)

suitPartWb:SetChildButtonClick(4,function()
clickFunc()
end,true)
end




local _renameType=
{
[eAttributeType.eATK_PCT]='攻击率',
[eAttributeType.eDEF_PCT]='防御率',
[eAttributeType.eHP_PCT]='生命率',
}

function UIBagEquipFilterPartWin:refreshRandomAttrPart()

local randomAttrWb=self.randomAttrPart:getChildWidgetBase()

local comFilterArgs=self.comFilterArgsList[BAG_FILTER_TYPE.eEquipRandomAttr]

local attrs=equipsConfig.getEquipConstConfig().rangeattrs
local attrsLen=#attrs

local createFunc=function(index)
local item=randomAttrWb:GetChildLayoutGroupGridItem(0,index-1)

local attrid=attrs[index]

local attrName
if _renameType[attrid]then
attrName=_renameType[attrid]
else
attrName=helper.getAttributeName(attrid)
end

item:SetChildText(0,attrName)

local val=comFilterArgs[index]
item:SetChildGray(1,val==nil or val~=1)
item:SetChildGray(2,val==nil or val~=0)

item:SetChildButtonClick(1,function()
if comFilterArgs[index]==nil then
comFilterArgs[index]=1
else
if comFilterArgs[index]==1 then
comFilterArgs[index]=nil
else
comFilterArgs[index]=1
end
end

item:SetChildGray(1,comFilterArgs[index]==nil or comFilterArgs[index]~=1)
item:SetChildGray(2,comFilterArgs[index]==nil or comFilterArgs[index]~=0)

_this:freshSingleResultArgsList(BAG_FILTER_TYPE.eEquipRandomAttr)
end,true)

item:SetChildButtonClick(2,function()
if comFilterArgs[index]==nil then
comFilterArgs[index]=0
else
if comFilterArgs[index]==0 then
comFilterArgs[index]=nil
else
comFilterArgs[index]=0
end
end

item:SetChildGray(1,comFilterArgs[index]==nil or comFilterArgs[index]~=1)
item:SetChildGray(2,comFilterArgs[index]==nil or comFilterArgs[index]~=0)

_this:freshSingleResultArgsList(BAG_FILTER_TYPE.eEquipRandomAttr)
end,true)
end

randomAttrWb:SetChildLayoutGroupCreateItems(0,attrsLen,createFunc)
self.winlua:ForceLayoutVertical(self.randomAttrPart:getID())
end




function UIBagEquipFilterPartWin:playEnterAnimation()
self.uiRoot:setChildAnchoredPos(365,0)
self.uiRoot:setChildCanvasGroupAlpha(0)

self.enterMoveDT=self.uiRoot:setChildDOAnchorPosX(-333.5,0.2)
self.enterAlphaDT=self.uiRoot:setChildCanvasGroupDOFade(1,0.2)
end

function UIBagEquipFilterPartWin:clearDT()
if self.enterMoveDT then
self.enterMoveDT:Kill()
self.enterMoveDT=nil
end

if self.enterAlphaDT then
self.enterAlphaDT:Kill()
self.enterAlphaDT=nil
end
end
