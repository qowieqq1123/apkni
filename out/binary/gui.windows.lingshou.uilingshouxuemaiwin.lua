







def_class("UILingShouXueMaiWin",UIWindowBase)









function UILingShouXueMaiWin:bindComponents()

self.baseInfoPart=UIObject.get(self,0)
self.centerLayout=UIObject.get(self,1)
self.costPart=UIObject.get(self,2)
self.costScrollView=UIObject.get(self,3)
self.costTitle=UIText.get(self,4)
self.czBtn=UIButton.get(self,5)
self.drawBg=UIObject.get(self,6)
self.effectback=UIObject.get(self,7)
self.infoPart=UIObject.get(self,8)
self.limitTuPoTips=UIText.get(self,9)
self.lineList=UIObject.get(self,10)
self.maxLevel=UIObject.get(self,11)
self.name=UIText.get(self,12)
self.namePart=UIObject.get(self,13)
self.ninglianBtn=UIButton.get(self,14)
self.ninglianPart=UIObject.get(self,15)
self.pointLineDrawPart=UIObject.get(self,16)
self.pointList=UIObject.get(self,17)
self.quickNingLianBtn=UIButton.get(self,18)
self.quickNingLianSelect=UIObject.get(self,19)
self.renameBtn=UIButton.get(self,20)
self.Root=UIObject.get(self,21)
self.succesEffect=UIObject.get(self,22)
self.tupoBtn=UIButton.get(self,23)
self.tupoEmptyTips=UIText.get(self,24)
self.tupoInfoPart=UIObject.get(self,25)
self.tupoPart=UIObject.get(self,26)
self.uiRoot=UIObject.get(self,27)
self.xmStageIcon=UIImage.get(self,28)
self.xuemaiInfo=UIText.get(self,29)
self.xuemaiInfoPart=UIObject.get(self,30)

self.czBtn:setButtonClick(function()self:onCzBtn()end)

self.ninglianBtn:setButtonClick(function()self:onNinglianBtn()end)

self.quickNingLianBtn:setButtonClick(function()self:onQuickNingLianBtn()end)

self.renameBtn:setButtonClick(function()self:onRenameBtn()end)

self.tupoBtn:setButtonClick(function()self:onTupoBtn()end)



end


function UILingShouXueMaiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.baseInfoPart);self.baseInfoPart=nil;
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.costPart);self.costPart=nil;
_UIObject_release(self.costScrollView);self.costScrollView=nil;
_UIObject_release(self.costTitle);self.costTitle=nil;
_UIObject_release(self.czBtn);self.czBtn=nil;
_UIObject_release(self.drawBg);self.drawBg=nil;
_UIObject_release(self.effectback);self.effectback=nil;
_UIObject_release(self.infoPart);self.infoPart=nil;
_UIObject_release(self.limitTuPoTips);self.limitTuPoTips=nil;
_UIObject_release(self.lineList);self.lineList=nil;
_UIObject_release(self.maxLevel);self.maxLevel=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.namePart);self.namePart=nil;
_UIObject_release(self.ninglianBtn);self.ninglianBtn=nil;
_UIObject_release(self.ninglianPart);self.ninglianPart=nil;
_UIObject_release(self.pointLineDrawPart);self.pointLineDrawPart=nil;
_UIObject_release(self.pointList);self.pointList=nil;
_UIObject_release(self.quickNingLianBtn);self.quickNingLianBtn=nil;
_UIObject_release(self.quickNingLianSelect);self.quickNingLianSelect=nil;
_UIObject_release(self.renameBtn);self.renameBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.succesEffect);self.succesEffect=nil;
_UIObject_release(self.tupoBtn);self.tupoBtn=nil;
_UIObject_release(self.tupoEmptyTips);self.tupoEmptyTips=nil;
_UIObject_release(self.tupoInfoPart);self.tupoInfoPart=nil;
_UIObject_release(self.tupoPart);self.tupoPart=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.xmStageIcon);self.xmStageIcon=nil;
_UIObject_release(self.xuemaiInfo);self.xuemaiInfo=nil;
_UIObject_release(self.xuemaiInfoPart);self.xuemaiInfoPart=nil;
end
















local _this




function UILingShouXueMaiWin:onLoaded(...)
self:bindComponents()

_this=self

self.isPlayLineAmount=false
self.isShowTuPoSkillWin=false

self.costScrollView:setChildScrollViewInit(0.5,true,nil,nil)

self.quickUpLevelFlag=false

local _on_item_list_changed=function(argslist,lookup_guidStr,lookup_itemid)
if _this==nil then return end
if _this.moneyLookup==nil or next(_this.moneyLookup)==nil then return end

for itemId,item in pairs(_this.moneyLookup)do
if lookup_itemid[itemId]then
_this:refreshCostItem(item[1],item[2])
end
end
end
self:addNotify(notifyConfig.on_item_list_changed,_on_item_list_changed)
end


function UILingShouXueMaiWin:__delete()
_this=nil

self:clearLineAmountDt()

self:unbindComponents()
end


function UILingShouXueMaiWin:onCzBtn()
lingshouController:showLingShouCZwin(self.ls_guid)
end


function UILingShouXueMaiWin:checkIsTuPo(index)
local levelCfg=lingshouModel:getLevelConfig3_XueMai(self.ls_guid,self.level)
if levelCfg==nil then return false end
return levelCfg.optionalUpLevelCost[index]~=nil
end

function UILingShouXueMaiWin:getNextTuPoIndex()
local levelCfg=lingshouModel:getLevelConfig3_XueMai(self.ls_guid,self.level)
local nextPoint=self.activePointIdx
for index=nextPoint,#levelCfg.pointList do
if levelCfg.optionalUpLevelCost[index]~=nil then
nextPoint=index
break
end
end
if self.isMaxStage then
nextPoint=#levelCfg.pointList
end
return nextPoint
end






function UILingShouXueMaiWin:onShow(argtable,afterOnloaded)
self.ls_guid=argtable.ls_guid

self:refreshAll()
end


function UILingShouXueMaiWin:freshLingShouCZ()
local lsData=lingshouModel:getLingShouData(_this.ls_guid)
local flag=lingshouController:checkLingShouCZopen(lsData)
if flag then
_this.czBtn:setActive(true)
else
_this.czBtn:setActive(false)
end
end


function UILingShouXueMaiWin:onHide()

end





function UILingShouXueMaiWin:onNinglianBtn()
if self.isPlayLineAmount then return end

local isCanUpStage,tips=lingshouModel:checkCanUpLevel_XueMai(self.ls_guid)
if not isCanUpStage then
UIManager.info(tips)
return
end



local isPassCheckCost=self:checkCostList(true)
if isPassCheckCost then



local lsGuid=self.ls_guid
local dzGuid=lingshouModel:getDiziguidByLsGuid(lsGuid)or Int64_0
if self.quickUpLevelFlag then
lingshouController.req_19_6(lsGuid,dzGuid)
else
local colorLSList=defaultT
local sameLSList=defaultT
for index,costData in ipairs(self.cost)do
local itemID=costData[1]
if itemID==-1 then

sameLSList=costData[3]
elseif itemID==-2 then

colorLSList=costData[3]
end
end

lingshouController.req_19_5(lsGuid,dzGuid,#colorLSList,colorLSList,#sameLSList,sameLSList)
end
end
end



function UILingShouXueMaiWin:onQuickNingLianBtn()
if self.isPlayLineAmount then return end







self.quickUpLevelFlag=not self.quickUpLevelFlag



self:refreshQuickNingLianOption()
self:initCostList()
self:refresInfoPart()
self:refreshLinePointDrawPart()
end



function UILingShouXueMaiWin:onTupoBtn()
if self.isPlayLineAmount then return end

local isCanUpStage,tips=lingshouModel:checkCanUpLevel_XueMai(self.ls_guid)
if not isCanUpStage then
UIManager.info(tips)
return
end


local isPassCheckCost=self:checkCostList(true)
if isPassCheckCost then



local okCallBack=function()

local lsGuid=_this.ls_guid
local dzGuid=lingshouModel:getDiziguidByLsGuid(lsGuid)or Int64_0
local colorLSList=defaultT
local sameLSList=defaultT
for index,costData in ipairs(_this.cost)do
local itemID=costData[1]
if itemID==-1 then

sameLSList=costData[3]
elseif itemID==-2 then

colorLSList=costData[3]
end
end

lingshouController.req_19_5(lsGuid,dzGuid,#sameLSList,sameLSList,#colorLSList,colorLSList)
end

local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLingShouXueMaiTuPoTiShi)
if flag then
okCallBack()
return
end

local show_data={
type='UIDialougeLSXMTips',
title='提示',
costList=self.cost,
content="是否消耗以下资源突破血脉",
showclosebtn=true,
okCallBack=okCallBack,
cancelCallBack=nil,
closecallback=nil,
canvasindex=8,
lsGuid=self.ls_guid,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog.choosetext="今日不再提示"
dialog.choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLingShouXueMaiTuPoTiShi,flag)
end
dialog:show()
end
end

function UILingShouXueMaiWin:onRenameBtn(guid)

if houtaiModel:isForbidenChangeName('该功能正在升级维护中')then
return
end

local guid=self.ls_guid
local lsData=lingshouModel:getLingShouData(guid)
local func=function(changeName)
lingshouController:reqChangeName(guid,changeName)
end
local baseCfg=cfgHelper.get1(cfg_lingshoubasicconfig_get,1)
local cost
if baseCfg and baseCfg.change_name_cost then
cost=baseCfg.change_name_cost[1]
end

local args={
changeNameType=changeNameType.eLingshou,
title='灵兽改名',
defaultName=lsData.name,
callback=func,
cost=cost,
}
UIManager:showWindow('UICommonChangeNameWin',args)
end






function UILingShouXueMaiWin:onChangeLingShou(guid)
self:onShow({ls_guid=guid})
end



function UILingShouXueMaiWin:initData()
local guid=self.ls_guid
self.lsData=lingshouModel:getLingShouData2(guid)

self.lsCfg=cfgHelper.get(cfg_lingshouconfig_get,self.lsData.id)
self.xmType=self.lsCfg.xuemai[1]
self.xmCfg=cfgHelper.get(cfg_lingshouxuemaiconfig_get,self.xmType)

self.level=self.lsData.xuemai_val
self.activePointIdx=self.lsData.xuemai_dianshu
self.levelCfg=lingshouModel:getLevelConfig2_XueMai(self.lsData.id,self.level)
self.pointListCfg=self.levelCfg.pointList
self.stage=lingshouModel:switchLevelToStageAndIdx_XueMai(self.level)
self.xmStage=lingshouModel:getLevelConfig3Ex_XueMai(self.lsData,self.level,'stage')

self.isNeedUpStage=lingshouModel:checkIsNeedUpLevel_XueMai(self.ls_guid,self.level,self.activePointIdx)
self.isMaxLevel=lingshouModel:checkIsMaxlevelAndPoint_XueMai(guid)
self.isMaxStage=lingshouModel:checkIsMaxLevel_XueMai(guid)

self.isShowTuPoSkillWin=false

self.moneyLookup={}

self:initCostList()
end



function UILingShouXueMaiWin:initCostList()
self.upCount=self.quickUpLevelFlag and 0 or 1

if self.isNeedUpStage then

local fixedUpLevelCost=lingshouModel:getLevelConfig2_XueMai(self.lsData.id,self.level,'fixedUpLevelCost',self.activePointIdx)
local optionalUpLevelCost=lingshouModel:getLevelConfig2_XueMai(self.lsData.id,self.level,'optionalUpLevelCost',self.activePointIdx)or defaultT

self.cost=table.concatTable(fixedUpLevelCost,optionalUpLevelCost)
self.cost=table.deepCopy(self.cost)
return
end

if self.quickUpLevelFlag then

local totalFixedUpLevelCost=lingshouModel:getLevelConfig2_XueMai(self.lsData.id,self.level,'fixedUpLevelCost')
local totalOptionalUpLevelCost=lingshouModel:getLevelConfig2_XueMai(self.lsData.id,self.level,'optionalUpLevelCost')

local lookup={}


local totalLen=self:getNextTuPoIndex()
for index=self.activePointIdx,totalLen do

local fixedCost=totalFixedUpLevelCost[index]
local optionCost=totalOptionalUpLevelCost[index]

if optionCost==nil then
for _,costData in ipairs(fixedCost)do
lookup[costData[1]]=lookup[costData[1]]or 0
lookup[costData[1]]=lookup[costData[1]]+costData[2]
end
end























if index~=totalLen then
self.upCount=self.upCount+1
end
end

self.cost={}
for itemID,itemCount in pairs(lookup)do
self.cost[#self.cost+1]={itemID,itemCount}
end

table.sort(self.cost,function(a,b)
return a[1]<b[1]
end)
return
end


local fixedUpLevelCost=lingshouModel:getLevelConfig2_XueMai(self.lsData.id,self.level,'fixedUpLevelCost',self.activePointIdx)
local optionalUpLevelCost=lingshouModel:getLevelConfig2_XueMai(self.lsData.id,self.level,'optionalUpLevelCost',self.activePointIdx)or defaultT

self.cost=table.concatTable(fixedUpLevelCost,optionalUpLevelCost)
self.cost=table.deepCopy(self.cost)
end




function UILingShouXueMaiWin:checkCostList(isWarning)
if self.cost==nil or next(self.cost)==nil then return false end

for index,data in ipairs(self.cost)do
local itemID=data[1]
local needCount=data[2]

if itemID>0 then
local isEnough=itemsModel.checkItemEnough(itemID,needCount)
if not isEnough then
if isWarning then
gainControl:showGainWin(itemID,needCount,{needCount=needCount})
end

return false
end
else
if itemID==-1 then
local list=data[3]
local len=list and#list or 0



local isAllOK=self:checkSpeCostListMeetCondition_1(list)
if not isAllOK then
logErr("选择的灵兽不可用于消耗")
return false
end


local isEnough=len==needCount
if len>needCount then

end

if not isEnough then
if isWarning then
UIManager.info("缺少消耗灵兽")

local limitLSIDList=lingshouModel:getLingShouConfig(_this.lsData.id,'xuemai_cost_ls',self.level)or defaultT
local item=self.costGrids[index-1]
_this:showWindow('UILingShouCostSelectWin',{lsGuid=self.ls_guid,speType=-1,selectCount=needCount,selectLSGuidList=list,limitLSIDList=limitLSIDList,excludeLSGuidStrList={_this.lsData.guid_str},selectCallBack=function(lsGuidList)
data[3]=lsGuidList
_this:refreshCostItem_Spe1(item,data)
end})
end
return false
end
elseif itemID==-2 then
local list=data[3]
local len=list and#list or 0



local isAllOK=self:checkSpeCostListMeetCondition_2(list)
if not isAllOK then
logErr("选择的灵兽不可用于消耗")
return false
end


local isEnough=len==needCount
if len>needCount then

end

if not isEnough then
if isWarning then
UIManager.info("缺少消耗灵兽")

local item=self.costGrids[index-1]
local color=lingshouModel:getLingShouConfig(_this.lsData.id,'color')
_this:showWindow('UILingShouCostSelectWin',{lsGuid=self.ls_guid,speType=-2,selectCount=needCount,selectLSGuidList=list,limitColorList={color},excludeLSGuidStrList={_this.lsData.guid_str},selectCallBack=function(lsGuidList)
data[3]=lsGuidList
_this:refreshCostItem_Spe2(item,data)
end})
end
return false
end
end
end
end

return true
end




function UILingShouXueMaiWin:checkSpeCostListMeetCondition_1(list)
if list==nil or next(list)==nil then return true end

local upStageCostIDList=lingshouModel:getLingShouConfig(self.lsData.id,'xuemai_cost_ls',self.level)
if upStageCostIDList==nil then return true end

for index,lsGuid in ipairs(list)do
local lsData=lingshouModel:getLingShouData2(lsGuid)
if upStageCostIDList[lsData.id]==nil then
return false
end
end

return true
end




function UILingShouXueMaiWin:checkSpeCostListMeetCondition_2(list)
if list==nil or next(list)==nil then return true end

local color=lingshouModel:getLingShouConfig(self.lsData.id,'color')

for index,lsGuid in ipairs(list)do
local lsData=lingshouModel:getLingShouData2(lsGuid)
local ccolor=lingshouModel:getLingShouConfig(lsData.id,'color')
if color~=ccolor then
return false
end
end

return true
end

function UILingShouXueMaiWin:refreshAll()
self:initData()

self:refreshName()
self:refreshLinePointDrawPart()
self:refresInfoPart()
self:freshLingShouCZ()
end

function UILingShouXueMaiWin:refreshName()
local name_str=self.lsData.name
self.name:setText(name_str)
end



function UILingShouXueMaiWin:refreshLinePointDrawPart()

self:fillDrawBg()
self:fillLineList()
self:fillPointList()
end



function UILingShouXueMaiWin:fillDrawBg()

end



function UILingShouXueMaiWin:fillLineList()
local lineLen=#self.pointListCfg-1

self.lineList:setChildLayoutGroupCreateItems(lineLen)

self.lineItemList=self.lineList:getChildLayoutGroupGridList()

for index=1,lineLen do
self:refreshSingleLine(index)
end
end

local _fixedLineWidth=15
local _fixedPointRadius=25
local _lineItemCmpIndex={
empty=0,
active=1,
}
function UILingShouXueMaiWin:refreshSingleLine(index)
if self.lineItemList==nil or index>self.lineItemList.Count then return end

local item=self.lineItemList[index-1]

local isAcive=self.activePointIdx>index

item:SetChildActive(_lineItemCmpIndex.empty,true)
item:SetChildActive(_lineItemCmpIndex.active,isAcive)
local amount=isAcive and 1 or 0
item:SetChildIconFillAmount(_lineItemCmpIndex.active,amount)


local thisPoint=self.pointListCfg[index]
local nextPoint=self.pointListCfg[index+1]
if nextPoint~=nil then

local angle=mathHelper.getAngleByPos(thisPoint[1],thisPoint[2],nextPoint[1],nextPoint[2])
item:SetChildRotation(-1,0,0,angle+90)

local newX,newY=self:getNewPoint(thisPoint[1],thisPoint[2],math.rad(angle),_fixedPointRadius)
item:SetChildAnchoredPos(-1,newX,newY)


local dis=mathHelper.distance(thisPoint[1],thisPoint[2],nextPoint[1],nextPoint[2])-_fixedPointRadius*2
item:SetChildSizeDelta(-1,_fixedLineWidth,dis)
end

end







function UILingShouXueMaiWin:getNewPoint(startX,startY,angleRadians,distance)
local newX=startX+distance*math.cos(angleRadians)
local newY=startY+distance*math.sin(angleRadians)
return newX,newY
end



function UILingShouXueMaiWin:fillPointList()
local pointLen=#self.pointListCfg

self.pointList:setChildLayoutGroupCreateItems(pointLen)

self.pointItemList=self.pointList:getChildLayoutGroupGridList()

for index=1,pointLen do
self:refreshSinglePoint(index)
end
end

local _pointItemCmpIndex={
empty=0,
active=1,
dw=2,
icon=3,
}
local _pointTypeCircleImageName={
'image_lingshou_xuemai_2',
'image_lingshou_xuemai_16',
}
function UILingShouXueMaiWin:refreshSinglePoint(index)
if self.pointItemList==nil or index>self.pointItemList.Count then return end

local item=self.pointItemList[index-1]

local isAcive=self.activePointIdx>=index

local isTuPo=self:checkIsTuPo(index)
local tempIndex=isTuPo and 2 or 1

local nextIndex=self.quickUpLevelFlag and self:getNextTuPoIndex()or self.activePointIdx+1

item:SetChildActive(_pointItemCmpIndex.empty,true)
item:SetChildCSImageSprite(_pointItemCmpIndex.empty,globalABLookup.lingshouxuemai,_pointTypeCircleImageName[tempIndex])
item:SetChildActive(_pointItemCmpIndex.active,isAcive)
item:SetChildActive(_pointItemCmpIndex.dw,index==nextIndex and self.activePointIdx~=nextIndex)


local pointIconname=lingshouModel:getPointIconNameByStage(self.stage)
item:SetChildCSImageSprite(_pointItemCmpIndex.icon,globalABLookup.lingshouxuemai,pointIconname)
item:SetChildGray(_pointItemCmpIndex.icon,not isAcive)


local thisPoint=self.pointListCfg[index]
item:SetChildAnchoredPos(-1,thisPoint[1],thisPoint[2])
end



function UILingShouXueMaiWin:refresInfoPart()
self:refreshXueMaiLevel()
self:refreshBaseInfoList()
self:refreshTuPoInfoList()
self:refreshCostPart()
self:refreshFuncButtoms()
end

function UILingShouXueMaiWin:refreshXueMaiLevel()
local xuemaiLevel=self.lsData.xuemai_val
local sindex,lidx=lingshouModel:switchLevelToStageAndIdx_XueMai(xuemaiLevel)
local isShowIdx=lidx>0
self.xuemaiInfo:setActive(isShowIdx)
if isShowIdx then
self.xuemaiInfo:setText(FMT.fmt("+{0}",lidx))
end
local stageIconName=lingshouModel:getStageIconName(sindex)
self.xmStageIcon:setCSImageSprite(globalABLookup.lingshouxuemai,stageIconName)
end

local _BaseInfoItemCmpIndex={
info1=0,
info2=1,
arraw=2,
}

local _getNextBaseAttrs=function(level,activePointIdx)
local lsID=_this.lsData.id
if _this.isMaxLevel then
return lingshouModel:getLevelConfig2_XueMai(lsID,level,'attrs',activePointIdx)
end

if _this.isNeedUpStage and not _this.isMaxStage then
return lingshouModel:getLevelConfig2_XueMai(lsID,level+1,'attrs',0)
else
return lingshouModel:getLevelConfig2_XueMai(lsID,level,'attrs',activePointIdx+_this.upCount)
end
end
local _getPercent=function(lsData,level,activePointIdx)
local percentT
if _this.isNeedUpStage and not _this.isMaxStage then
percentT=lingshouModel:getLevelConfig3Ex_XueMai(lsData,level+1,'percent')
return percentT[0]or 0
else
percentT=lingshouModel:getLevelConfig3Ex_XueMai(lsData,level,'percent')
return percentT[activePointIdx]or 0
end
end
function UILingShouXueMaiWin:refreshBaseInfoList()
local thisBaseAttrs=lingshouModel:getLevelConfig2_XueMai(self.lsData.id,self.level,'attrs',self.activePointIdx)
local nextBaseAttrs=_getNextBaseAttrs(self.level,self.activePointIdx)

local thisBaseAttrsLookUp=attrListHelper.tramsformToLookup(thisBaseAttrs)
local nextBaseAttrsLookUp=thisBaseAttrsLookUp
local diffBaseAttrsLookUp={}
local diffBaseAttrs={}

if nextBaseAttrs~=nil then
nextBaseAttrsLookUp=attrListHelper.tramsformToLookup(nextBaseAttrs)
end
local xuemaiBaseAttr=cfgHelper.get(cfg_lingshoubasicconfig_get,1,'xuemaiBaseAttr')
local sortList={}
for index,type in ipairs(xuemaiBaseAttr)do
sortList[index]={type}
diffBaseAttrsLookUp[type]=nextBaseAttrsLookUp[type]-thisBaseAttrsLookUp[type]
end
if self.isMaxLevel then
local xuemaiSpeAttr=cfgHelper.get(cfg_lingshoubasicconfig_get,1,'xuemaiSpeAttr')
for index,type in ipairs(xuemaiSpeAttr)do
sortList[#sortList+1]={type}
diffBaseAttrsLookUp[type]=nextBaseAttrsLookUp[type]-thisBaseAttrsLookUp[type]
end
end
diffBaseAttrs=attrListHelper.transformToList(diffBaseAttrsLookUp,sortList)


local percent=lingshouModel:getLevelConfig3Ex_XueMai(self.lsData,self.level,'percent',self.activePointIdx)
local nextPercent=_getPercent(self.lsData,self.level,self.activePointIdx+_this.upCount)
diffBaseAttrs[#diffBaseAttrs+1]={-1,percent,nextPercent}

local len=#diffBaseAttrs

self.baseInfoPart:setChildLayoutGroupCreateItems(len)
local itemList=self.baseInfoPart:getChildLayoutGroupGridList()
for index=1,itemList.Count do
local infoItem=itemList[index-1]

local attrData=diffBaseAttrs[index]
local attrType=attrData[1]

local isSpe=attrType<0
if isSpe then
local diffVal=attrData[3]
local isDiff=attrData[3]-attrData[2]>0
local info1=FMT.fmt("<color='#7d3b17'>基础属性</color>：{0}",string.format("%s%%",attrData[2]))
infoItem:SetChildText(_BaseInfoItemCmpIndex.info1,info1)

infoItem:SetChildActive(_BaseInfoItemCmpIndex.info2,isDiff)
infoItem:SetChildActive(_BaseInfoItemCmpIndex.arraw,isDiff)
if isDiff then
infoItem:SetChildText(_BaseInfoItemCmpIndex.info2,string.format("%s%%",diffVal))
end
else
local diffVal=attrData[2]
local baseVal=thisBaseAttrsLookUp[attrType]

local info1=helper.getAttributeStr(attrType,baseVal,2,"<color='#7d3b17'>{0}</color>：{1}")
infoItem:SetChildText(_BaseInfoItemCmpIndex.info1,info1)

local isDiff=diffVal>0
infoItem:SetChildActive(_BaseInfoItemCmpIndex.info2,isDiff)
infoItem:SetChildActive(_BaseInfoItemCmpIndex.arraw,isDiff)
if isDiff then
infoItem:SetChildText(_BaseInfoItemCmpIndex.info2,nextBaseAttrsLookUp[attrType])
end
end
end
end

local _TuPoInfoItemCmpIndex={
info1=0,
info2=1,
chakan=2,
arrow=3,
info3=4,
xqbtn=5,
}
local _getSkillList=function(lsData,level)
if _this.isMaxLevel then
return defaultT
end

local plv=0
local passive_skill=lsData.cfg.passive_skill
local skillList={}
local jj_lvl=lsData.jj_lvl
for pIndex,skillID in pairs(passive_skill)do
local skillUpCfg=cfgHelper.get(cfg_lingshoupassiveskillconfig_get,skillID)
local lvConfLen=#skillUpCfg.up_level_conf
local skillInfo
for lIndex=1,lvConfLen do
local cond=skillUpCfg.up_level_conf[lIndex]
if level<=cond[1]and jj_lvl>=cond[2]then
local flv=cond[1]+plv
if lIndex==1 then
skillInfo={2,skillID,flv,lIndex,cond[1]}
else
skillInfo={3,skillID,flv,lIndex,cond[1]}
end
break
end
end
if skillInfo then
skillList[#skillList+1]=skillInfo
end
end

return skillList
end

function UILingShouXueMaiWin:refreshTuPoInfoList()



local isNoMaxStage=not self.isMaxStage

local nextStageName=""
if not self.isMaxStage then
nextStageName=lingshouModel:switchLevelToStageName_XueMai(self.level+1)
nextStageName=FMT.fmt("({0})",nextStageName)
end



local tupoInfoDataList={}




local nextUpPercentlevel














if not self.isMaxStage then
local xuemaiSpeAttr=cfgHelper.get(cfg_lingshoubasicconfig_get,1,'xuemaiSpeAttr')
local levelCfgs=lingshouModel:getLevelConfig2_XueMai(self.lsData.id)
local change=false
local list={}

for index=self.level,#levelCfgs do
local cfg=levelCfgs[index]
for aindex=0,#cfg.attrs do
local lookup=attrListHelper.tramsformToLookup(cfg.attrs[aindex])

if index>self.level then
for _,type in ipairs(xuemaiSpeAttr)do
if lookup[type]>list[type]then
change=true
table.insert(tupoInfoDataList,{4,type,list[type],lookup[type]})
break
end
end
elseif(index==self.level and aindex==self.activePointIdx)then
for _,type in ipairs(xuemaiSpeAttr)do
list[type]=lookup[type]or 0
end
end
if change then
break
end
end
if change then
break
end
end
end

local tlevel=self.isMaxStage and self.level or self.level+1
local skillList=_getSkillList(self.lsData,tlevel)
tupoInfoDataList=table.concatTable(tupoInfoDataList,skillList)

local len=#tupoInfoDataList

self.tupoInfoPart:setChildLayoutGroupCreateItems(len)
local itemList=self.tupoInfoPart:getChildLayoutGroupGridList()
for index=1,itemList.Count do
local infoItem=itemList[index-1]

local infoData=tupoInfoDataList[index]
local infoType=infoData[1]

local isSKill=infoType==2 or infoType==3

local isDiff=infoData[3]~=nil
infoItem:SetChildActive(_TuPoInfoItemCmpIndex.arrow,(not isSKill)and isDiff)
infoItem:SetChildActive(_TuPoInfoItemCmpIndex.chakan,isSKill)
infoItem:SetChildActive(_TuPoInfoItemCmpIndex.info3,false)
infoItem:SetChildActive(_TuPoInfoItemCmpIndex.xqbtn,infoType==4)

if isSKill then
local skillID=infoData[2]
local skillLv=infoData[4]
infoItem:SetChildButtonClick(_TuPoInfoItemCmpIndex.chakan,function()
local _skillLv=skillLv+lingshouModel:getLingShouTraitEffectEx(_this.ls_guid,lingshouTraitEffectEnum.LINGSHOU_SKILL_LEVEL_ADD,1)or 0
local args={skillID=skillID,skillLv=_skillLv,attend=eSkillTipsType.eLSSkill,hideUpgrade=true}
_this:showWindow('UIDiscipleJobSkillTipsWin',args)
end,true)
end

local nameColor=isNoMaxStage and'#65615f'or'#7d3b17'
local valColor=isNoMaxStage and'#65615f'or'#000000'

if infoType==1 then
local isShowStageName=nextUpPercentlevel~=nil
infoItem:SetChildActive(_TuPoInfoItemCmpIndex.info2,isShowStageName)
if isShowStageName then
nextStageName=lingshouModel:switchLevelToStageName_XueMai(nextUpPercentlevel)
nextStageName=FMT.fmt("({0})",nextStageName)
infoItem:SetChildText(_TuPoInfoItemCmpIndex.info2,toColorStringX(valColor,nextStageName))
end
local info1=FMT.fmt("<color={0}>基础属性：</color><color={1}>{2}</color>",nameColor,valColor,string.format("%s%%",infoData[2]))
infoItem:SetChildText(_TuPoInfoItemCmpIndex.info1,info1)
if isDiff then
local info3=string.format("<color=%s>%s%%</color>",valColor,infoData[3])
infoItem:SetChildText(_TuPoInfoItemCmpIndex.info3,info3)
end

infoItem:SetChildActive(_TuPoInfoItemCmpIndex.info3,isDiff)

elseif infoType==2 then
nextStageName=lingshouModel:switchLevelToStageName_XueMai(infoData[5])
nextStageName=FMT.fmt("({0})",nextStageName)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,infoData[2])
local info1=FMT.fmt("<color={0}>解锁技能：</color><color={1}>[{2}]</color>",nameColor,valColor,skillCfg.name)
infoItem:SetChildText(_TuPoInfoItemCmpIndex.info1,info1)
infoItem:SetChildText(_TuPoInfoItemCmpIndex.info2,toColorStringX(valColor,nextStageName))
self.isShowTuPoSkillWin=true
elseif infoType==3 then
nextStageName=lingshouModel:switchLevelToStageName_XueMai(infoData[5])
nextStageName=FMT.fmt("({0})",nextStageName)
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,infoData[2])
local info1=FMT.fmt("<color={0}>技能：</color><color={1}>[{2}]等级+{3}</color>",nameColor,valColor,skillCfg.name,1)
infoItem:SetChildText(_TuPoInfoItemCmpIndex.info1,info1)
infoItem:SetChildText(_TuPoInfoItemCmpIndex.info2,toColorStringX(valColor,nextStageName))
self.isShowTuPoSkillWin=true
elseif infoType==4 then

local attrType=infoData[2]
local baseVal=infoData[3]
local diffVal=infoData[4]

local fmt=string.format("<color=%s>{0}</color><color=%s>+{1}</color>",nameColor,valColor)
local info1=helper.getAttributeStr(attrType,diffVal-baseVal,2,fmt)
infoItem:SetChildText(_TuPoInfoItemCmpIndex.info1,info1)

local isDiff=diffVal>0
infoItem:SetChildActive(_TuPoInfoItemCmpIndex.info3,false)
infoItem:SetChildActive(_TuPoInfoItemCmpIndex.arrow,false)

local isShowStageName=isDiff
infoItem:SetChildActive(_TuPoInfoItemCmpIndex.info2,isShowStageName)
if isShowStageName then
nextStageName=lingshouModel:switchLevelToStageName_XueMai(tlevel)
nextStageName=FMT.fmt("({0})",nextStageName)
infoItem:SetChildText(_TuPoInfoItemCmpIndex.info2,toColorStringX(valColor,nextStageName))
end

infoItem:SetChildButtonClick(_TuPoInfoItemCmpIndex.xqbtn,function()
if _this==nil then return end
_this:showTuPoEffectWin()
end,true)
end
end

self.tupoInfoPart:setActive(not self.isMaxLevel)
self.tupoEmptyTips:setActive(len<=0)
end

function UILingShouXueMaiWin:showTuPoEffectWin()
local args={}
args.titleName="灵兽突破效果"
args.pos=1
args.extraWin='UILingShouXueMaiTuPoEffectWin'
local extraParams={}
extraParams.lsData=_this.lsData
args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UILingShouXueMaiWin:refreshCostPart()
self.costPart:setActive(not self.isMaxLevel)
if self.isMaxLevel then return end

local title=self.isNeedUpStage and"突破消耗"or"凝练消耗"
self.costTitle:setText(title)

local len=#self.cost
self.costScrollView:setChildScrollViewCreateGrids(len,len)
self.costGrids=self.costScrollView:getChildScrollViewItemWidgets()

local moneyList={}
table.clear(self.moneyLookup)

for index=1,self.costGrids.Count do
local item=self.costGrids[index-1]

local costData=self.cost[index]

local isSpe=costData[1]<0

item:SetChildActive(0,not isSpe)
item:SetChildActive(1,isSpe)
if isSpe then
if costData[1]==-1 then
self:refreshCostItem_Spe1(item,costData)
elseif costData[1]==-2 then
self:refreshCostItem_Spe2(item,costData)
end
else
self:refreshCostItem(item,costData)
moneyList[#moneyList+1]={costData[1]}
self.moneyLookup[costData[1]]={item,costData}
end
end

UIManager:showWindow('UITopMoneyWin',moneyList)
end

function UILingShouXueMaiWin:refreshCostItem(item,costData)
local itemId=costData[1]
local itemNum=costData[2]
local hasNum=itemsModel.getCount(itemId)
local isEnough=hasNum>=itemNum
local color=isEnough and'#efeded'or'#c82c2c'

local countStr=string.format("<color=%s>%s</color>",color,mathHelper.formatNumber(itemNum))

local showCountBG=itemNum>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(itemId)
end)
end

function UILingShouXueMaiWin:refreshCostItem_Spe1(item,costData)
local subItem=item:GetChildWidgetBase(1)
local selectList=costData[3]or{}
local needCount=costData[2]

local selectLen=#selectList
local isFull=selectLen>=needCount
local color=isFull and FONT_COLOR.eGreenTxtColor or FONT_COLOR.eRedColor
local countStr=FMT.fmt("{0}/{1}",toColorString(color,selectLen),needCount)

subItem:SetChildActive(0,selectLen>0)
subItem:SetChildText(2,countStr)
local cost_ls=self.lsData.cfg.xuemai_cost_ls[self.level]
if cost_ls==nil then logErr("血脉消耗灵兽配置品阶缺少",self.stage)end
local id=next(cost_ls)
local color=cfgHelper.get(cfg_lingshouconfig_get,id,'color')
subItem:SetChildQulaity(3,color)
subItem:SetChildActive(4,selectLen>0)


item:SetBaseItemClickEvent(1,function(...)
local limitLSIDList=lingshouModel:getLingShouConfig(_this.lsData.id,'xuemai_cost_ls',self.level)or defaultT
_this:showWindow('UILingShouCostSelectWin',{lsGuid=self.ls_guid,speType=-1,selectCount=needCount,selectLSGuidList=selectList,limitLSIDList=limitLSIDList,excludeLSGuidStrList={_this.lsData.guid_str},selectCallBack=function(lsGuidList)
costData[3]=lsGuidList
_this:refreshCostItem_Spe1(item,costData)
end})
end)
end

function UILingShouXueMaiWin:refreshCostItem_Spe2(item,costData)
local subItem=item:GetChildWidgetBase(1)
local selectList=costData[3]or defaultT
local needCount=costData[2]

local selectLen=#selectList
local isFull=selectLen>=needCount
local color=isFull and FONT_COLOR.eGreenTxtColor or FONT_COLOR.eRedColor
local countStr=FMT.fmt("{0}/{1}",toColorString(color,selectLen),needCount)

subItem:SetChildActive(0,selectLen>0)
subItem:SetChildText(2,countStr)
local cost_ls=self.lsData.cfg.xuemai_cost_ls[self.level]
local id=next(cost_ls)
local color=cfgHelper.get(cfg_lingshouconfig_get,id,'color')
subItem:SetChildQulaity(3,color)
subItem:SetChildActive(4,selectLen>0)

item:SetBaseItemClickEvent(1,function(...)
local color=lingshouModel:getLingShouConfig(_this.lsData.id,'color')
_this:showWindow('UILingShouCostSelectWin',{lsGuid=self.ls_guid,speType=-2,selectCount=needCount,selectLSGuidList=selectList,limitColorList={color},excludeLSGuidStrList={_this.lsData.guid_str},selectCallBack=function(lsGuidList)
costData[3]=lsGuidList
_this:refreshCostItem_Spe2(item,costData)
end})
end)
end

function UILingShouXueMaiWin:refreshFuncButtoms()
local isNoMaxLevel=not self.isMaxLevel
self.tupoPart:setActive(self.isNeedUpStage and isNoMaxLevel)
self.ninglianPart:setActive(not self.isNeedUpStage and isNoMaxLevel)

if self.isNeedUpStage then
self:refreshTuPoBtnPart()
else
self:refreshUpLevelBtnPart()
end

self.maxLevel:setActive(self.isMaxLevel)
end

function UILingShouXueMaiWin:refreshTuPoBtnPart()
local isCanUpStage,tips=lingshouModel:checkCanUpLevel_XueMai(self.ls_guid)

local isNeedShowTips=not isCanUpStage
self.limitTuPoTips:setActive(isNeedShowTips)
if isNeedShowTips then
self.limitTuPoTips:setText(tips)
end

self.tupoBtn:setGray(isNeedShowTips)
end

function UILingShouXueMaiWin:refreshUpLevelBtnPart()
self:refreshQuickNingLianOption()

local isCanUpStage,tips=lingshouModel:checkCanUpLevel_XueMai(self.ls_guid)

local isNeedShowTips=not isCanUpStage
self.limitTuPoTips:setActive(isNeedShowTips)
if isNeedShowTips then
self.limitTuPoTips:setText(tips)
end

self.ninglianBtn:setGray(isNeedShowTips)
end

function UILingShouXueMaiWin:refreshQuickNingLianOption()
self.winlua:SetChildActive(self.quickNingLianSelect:getID(),self.quickUpLevelFlag)
end



function UILingShouXueMaiWin:clearLineAmountDt()
if self.lineAmountDt then
self.lineAmountDt:Complete()
self.lineAmountDt:Kill()
self.lineAmountDt=nil
end
end

function UILingShouXueMaiWin:playNingLianAnimation()
self:clearLineAmountDt()

if self.oldActivePointIdx>=self.activePointIdx then self.isPlayLineAmount=false return end

local callback=function()
if _this==nil then return end
if _this.oldActivePointIdx>0 then
_this:refreshSinglePoint(_this.oldActivePointIdx)
end
_this:refreshSinglePoint(_this.oldActivePointIdx+1)
_this:refreshSinglePoint(_this.oldActivePointIdx+2)
_this.oldActivePointIdx=_this.oldActivePointIdx+1
_this:playNingLianAnimation()
end

local isHasLine=self.oldActivePointIdx-1>=0
if isHasLine then
self.isPlayLineAmount=true
local lineItem=self.lineItemList[self.oldActivePointIdx-1]
lineItem:SetChildIconFillAmount(_lineItemCmpIndex.active,0)
lineItem:SetChildActive(_lineItemCmpIndex.active,true)
self.lineAmountDt=lineItem:SetChildImageDOFillAmount(_lineItemCmpIndex.active,1,0.2,function()
_this.lineAmountDt=nil
callback()
end)
else
callback()
end
end

function UILingShouXueMaiWin:playTuPoAnimation()
self:refreshLinePointDrawPart()
end




function UILingShouXueMaiWin:recv_NingLian(lsGuid)
if not mathHelper.compareInt64(self.ls_guid,lsGuid)then return end

self.oldActivePointIdx=self.activePointIdx

_this.succesEffect:setChildShowEffect(10060,true)


self:initData()

self:refresInfoPart()

self:playNingLianAnimation()
self:freshLingShouCZ()
end

function UILingShouXueMaiWin:recv_TuPo(lsGuid,oldData)
if not mathHelper.compareInt64(self.ls_guid,lsGuid)then return end

self.oldLevel=self.level
self.oldActivePointIdx=self.activePointIdx

_this.succesEffect:setChildShowEffect(10060,true)

local isShowTuPoSkillWin=self.isShowTuPoSkillWin
self:initData()

self:refresInfoPart()

self:playTuPoAnimation()


self:showWindow('UILingShouXueMaiUpStageWin',{
lsGuid=self.ls_guid,
oldData=oldData,
})

end

