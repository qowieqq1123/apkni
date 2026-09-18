







def_class("UIYuFuFilterPartWin",UIWindowBase)









function UIYuFuFilterPartWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.randomAttrPart=UIObject.get(self,1)
self.resetBtn=UIButton.get(self,2)
self.Root=UIObject.get(self,3)
self.stagePart=UIObject.get(self,4)
self.suitPart=UIObject.get(self,5)
self.title=UIText.get(self,6)
self.typePart=UIObject.get(self,7)
self.uiRoot=UIObject.get(self,8)
self.colorPart=UIObject.get(self,9)
self.fubaotypePart=UIObject.get(self,10)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.resetBtn:setButtonClick(function()self:onResetBtn()end)



end


function UIYuFuFilterPartWin:unbindComponents()
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
_UIObject_release(self.colorPart);self.colorPart=nil;
_UIObject_release(self.fubaotypePart);self.fubaotypePart=nil;
end
















local _this=nil

local _filter_Custom={

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

[BAG_FILTER_TYPE.eColor]={
initFilterArgs=function(self)
self.comFilterArgsList[BAG_FILTER_TYPE.eColor]={}
end,
buildFilterArgs=function(self,filterArgs)
local args=filterArgs[ITEM_FILTER_TYPE.eColor]
if args~=nil then
local _,info=next(args)
for _,idx in pairs(info)do
self.comFilterArgsList[BAG_FILTER_TYPE.eColor][idx]=1
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
return ITEM_FILTER_TYPE.eColor
end
return ITEM_FILTER_TYPE.eColor,{[ITEM_FILTER_TYPE.eColor]={[ITEM_FILTER_COMPARE.eEquals]=temp}}
end
return ITEM_FILTER_TYPE.eColor
end,
onEquipSubFilter=function(self,result)end,
},

[BAG_FILTER_TYPE.eFubaoEffectType]={
initFilterArgs=function(self)
self.comFilterArgsList[BAG_FILTER_TYPE.eFubaoEffectType]={}
end,
buildFilterArgs=function(self,filterArgs)
local args=filterArgs[ITEM_FILTER_TYPE.eFubaoEffectType]
if args~=nil then
local _,info=next(args)
for _,idx in pairs(info)do
self.comFilterArgsList[BAG_FILTER_TYPE.eFubaoEffectType][idx]=1
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
return ITEM_FILTER_TYPE.eFubaoEffectType
end
return ITEM_FILTER_TYPE.eFubaoEffectType,{[ITEM_FILTER_TYPE.eFubaoEffectType]={[ITEM_FILTER_COMPARE.eEquals]=temp}}
end
return ITEM_FILTER_TYPE.eFubaoEffectType
end,
onEquipSubFilter=function(self,result)end,
},

[BAG_FILTER_TYPE.eFuBaoEffectRandomAttr]={
initFilterArgs=function(self)
local temp={}
self.comFilterArgsList[BAG_FILTER_TYPE.eFuBaoEffectRandomAttr]=temp
local attrs2=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"rangeattrs")
local attrsLookup={}
local attrsLookup2={}
local index=0
for i,subFilterAttrData in ipairs(attrs2)do
local attrType=subFilterAttrData[1]
local attrIds=subFilterAttrData[2]

attrsLookup[attrType]={}
for k,attrId in ipairs(attrIds)do
index=index+1
attrsLookup[attrType][attrId]=index
attrsLookup2[index]={attrType,attrId}
end
end
self.attrsLookup=attrsLookup
self.attrsLookup2=attrsLookup2
end,
buildFilterArgs=function(self,filterArgs)
local args=filterArgs[ITEM_FILTER_TYPE.eFubaoRandomAttr]
if args~=nil then
local _,info=next(args)
for compareType,info in pairs(args)do
local index
for idx,data in pairs(info)do
local attrType=data[1]
local attrId=data[2]
index=self.attrsLookup[attrType][attrId]
if compareType==ITEM_FILTER_COMPARE.eAnd then
self.comFilterArgsList[BAG_FILTER_TYPE.eFuBaoEffectRandomAttr][index]=1
_this.limitnum=_this.limitnum+1
elseif compareType==ITEM_FILTER_COMPARE.eNot then
self.comFilterArgsList[BAG_FILTER_TYPE.eFuBaoEffectRandomAttr][index]=0
end
end
end

end
end,
getFilterArgs=function(self,args)
if next(args)then
local temp={}
local noTemp={}
for index,state in pairs(args)do
local data=self.attrsLookup2[index]
if state==1 then
temp[#temp+1]=data
elseif state==0 then
noTemp[#noTemp+1]=data
end
end
if#temp==0 and#noTemp==0 then
return ITEM_FILTER_TYPE.eFubaoRandomAttr
end

local filter={[ITEM_FILTER_TYPE.eFubaoRandomAttr]={}}

if#temp>0 then
filter[ITEM_FILTER_TYPE.eFubaoRandomAttr][ITEM_FILTER_COMPARE.eAnd]=temp
end

if#noTemp>0 then
filter[ITEM_FILTER_TYPE.eFubaoRandomAttr][ITEM_FILTER_COMPARE.eNot]=noTemp
end

return ITEM_FILTER_TYPE.eFubaoRandomAttr,filter
end
return ITEM_FILTER_TYPE.eFubaoRandomAttr
end,
onEquipSubFilter=function(self,result)

end,
},
}




function UIYuFuFilterPartWin:onLoaded(...)
self:bindComponents()
_this=self
self.comFilterArgsList={}
self.resultFilterArgsList={}
self.attrsLookup2={}
self.limitnum=0
end


function UIYuFuFilterPartWin:__delete()
self:unbindComponents()
self:clearDT()
bagModel.saveBagEquipFilterCount()
_this=nil
end


function UIYuFuFilterPartWin:onResetBtn()
self.limitnum=0
self:initData()
self:refreshAll()
self:freshResultArgsList()
self:onComitBagWin()
end




function UIYuFuFilterPartWin:onShow(argtable,afterOnloaded)
self.selectBagType=argtable.attach
self.comfirmCallback=argtable.comfirmCallback
self.closeCallBack=argtable.closeCallBack
self.equipBagFilter=argtable.fubaoBagFilter or{}
self.limitnum=0


self:initData()
self:recordData()
self:freshResultArgsList()
self:refreshAll()
if afterOnloaded then
self:playEnterAnimation()
end
end


function UIYuFuFilterPartWin:onHide()

end

function UIYuFuFilterPartWin:onCloseBtn()
if self.closeCallBack then
self.closeCallBack()
end
self:closeSelf()
end



function UIYuFuFilterPartWin:initData()
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

function UIYuFuFilterPartWin:recordData()
local filterType,filterCustom
for index,cfg in pairs(self.filterCfg)do
filterType=cfg.type
filterCustom=_filter_Custom[filterType]
if filterCustom then
filterCustom.buildFilterArgs(self,self.equipBagFilter)
end
end
end

function UIYuFuFilterPartWin:freshResultArgsList()
for type,args in pairs(self.comFilterArgsList)do
self:freshSingleResultArgsList(type,true)
end
end
function UIYuFuFilterPartWin:freshSingleResultArgsList(type,isNoFreshBag)
local filterList=self.resultFilterArgsList
local args=self.comFilterArgsList[type]
if _filter_Custom[type]then
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
end



function UIYuFuFilterPartWin:onComitBagWin()
if self.comfirmCallback then



self.comfirmCallback(self.resultFilterArgsList)
notifySystem:postNotify(notifyConfig.onBagEquipFilter)
bagModel.addBagEquipFilterCount()

end
end

function UIYuFuFilterPartWin:onEquipSubFilter(filterType,result)
_filter_Custom[filterType].onEquipSubFilter(self,result)
end

function UIYuFuFilterPartWin:refreshAll()

self:refreshFuBaoStagePart()
self:refreshFuBaoColorPart()
self:refreshFuBaoTypePart()
self:refreshFuBaoRandomAttrPart()
end


function UIYuFuFilterPartWin:playEnterAnimation()
self.uiRoot:setChildAnchoredPos(365,16)
self.uiRoot:setChildCanvasGroupAlpha(0)
self.enterMoveDT=self.uiRoot:setChildDOAnchorPosX(-358,0.2)
self.enterAlphaDT=self.uiRoot:setChildCanvasGroupDOFade(1,0.2)
end
function UIYuFuFilterPartWin:clearDT()
if self.enterMoveDT then
self.enterMoveDT:Kill()
self.enterMoveDT=nil
end
if self.enterAlphaDT then
self.enterAlphaDT:Kill()
self.enterAlphaDT=nil
end
end


local _maxStageNum=5
function UIYuFuFilterPartWin:refreshFuBaoStagePart()
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


local _maxColorNum=5
function UIYuFuFilterPartWin:refreshFuBaoColorPart()
local stagePartWb=self.colorPart:getWidgetBase()
local comFilterArgs=self.comFilterArgsList[BAG_FILTER_TYPE.eColor]
local createFunc=function(index)
local item=stagePartWb:GetChildLayoutGroupGridItem(0,index-1)
local name=eQualityColorName[index]
item:SetChildText(0,name)
local isGray=comFilterArgs[index]==nil or comFilterArgs[index]==0
item:SetChildGray(1,isGray)
item:SetBaseItemClickEvent(-1,function()
isGray=not isGray
comFilterArgs[index]=isGray and 0 or 1
item:SetChildGray(1,isGray)
_this:freshSingleResultArgsList(BAG_FILTER_TYPE.eColor)
end)
end
stagePartWb:SetChildLayoutGroupCreateItems(0,_maxColorNum,createFunc)
self.winlua:ForceLayoutVertical(self.colorPart:getID())
end


local _maxtypeNum=5
local typeName={'虎仙','玄龟','蟠龙','毕方','鹿蜀',}
function UIYuFuFilterPartWin:refreshFuBaoTypePart()
local stagePartWb=self.fubaotypePart:getWidgetBase()
local comFilterArgs=self.comFilterArgsList[BAG_FILTER_TYPE.eFubaoEffectType]
local createFunc=function(index)
local item=stagePartWb:GetChildLayoutGroupGridItem(0,index-1)
local name=typeName[index]
item:SetChildText(0,name)
local isGray=comFilterArgs[index]==nil or comFilterArgs[index]==0
item:SetChildGray(1,isGray)
item:SetBaseItemClickEvent(-1,function()
isGray=not isGray
comFilterArgs[index]=isGray and 0 or 1
item:SetChildGray(1,isGray)
_this:freshSingleResultArgsList(BAG_FILTER_TYPE.eFubaoEffectType)
end)
end
stagePartWb:SetChildLayoutGroupCreateItems(0,_maxtypeNum,createFunc)
self.winlua:ForceLayoutVertical(self.fubaotypePart:getID())
end


function UIYuFuFilterPartWin:refreshFuBaoRandomAttrPart()
local randomAttrWb=self.randomAttrPart:getChildWidgetBase()
local comFilterArgs=self.comFilterArgsList[BAG_FILTER_TYPE.eFuBaoEffectRandomAttr]
local attrsLookup2=self.attrsLookup2

local attrsLen=#attrsLookup2
local createFunc=function(index)
local item=randomAttrWb:GetChildLayoutGroupGridItem(0,index-1)
local attrType=attrsLookup2[index][1]
local attrId=attrsLookup2[index][2]
local attrName=''
if attrType==FUBAO_EFFECT_TYPE.eSixAttr then
attrName=FMT.fmt("{0}",UIDiscipleModel:discipleBaseAttrName(attrId))
elseif attrType==FUBAO_EFFECT_TYPE.eProfessionExp then
local _cfg=cfgHelper.get1(cfg_discipleproskillconfig_get,attrId)
attrName=FMT.fmt('{0}经验',_cfg.name)
elseif attrType==FUBAO_EFFECT_TYPE.eGongFaExpSpeed then
attrName=FMT.fmt("{0}经验",ELEMENT_TYPE.getNameGF(attrId))
end
item:SetChildText(0,attrName)

local val=comFilterArgs[index]
item:SetChildGray(1,val==nil or val~=1)
item:SetChildGray(2,val==nil or val~=0)

item:SetChildButtonClick(1,function()
if comFilterArgs[index]==nil then
if self.limitnum>=4 then
UIManager.error('最多选择四项随机属性')
return
end
comFilterArgs[index]=1
self.limitnum=self.limitnum+1
else
if comFilterArgs[index]==1 then
comFilterArgs[index]=nil
if self.limitnum>0 then
self.limitnum=self.limitnum-1
end
else
if self.limitnum>=4 then
UIManager.error('最多选择四项随机属性')
return
end
comFilterArgs[index]=1
self.limitnum=self.limitnum+1
end
end
item:SetChildGray(1,comFilterArgs[index]==nil or comFilterArgs[index]~=1)
item:SetChildGray(2,comFilterArgs[index]==nil or comFilterArgs[index]~=0)
_this:freshSingleResultArgsList(BAG_FILTER_TYPE.eFuBaoEffectRandomAttr)
end,true)


item:SetChildButtonClick(2,function()
if comFilterArgs[index]==nil then
comFilterArgs[index]=0
else
if comFilterArgs[index]==0 then
comFilterArgs[index]=nil
else
comFilterArgs[index]=0
if self.limitnum>0 then
self.limitnum=self.limitnum-1
end
end
end
item:SetChildGray(1,comFilterArgs[index]==nil or comFilterArgs[index]~=1)
item:SetChildGray(2,comFilterArgs[index]==nil or comFilterArgs[index]~=0)
_this:freshSingleResultArgsList(BAG_FILTER_TYPE.eFuBaoEffectRandomAttr)
end,true)
end
randomAttrWb:SetChildLayoutGroupCreateItems(0,attrsLen,createFunc)
self.winlua:ForceLayoutVertical(self.randomAttrPart:getID())
end


