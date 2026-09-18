
widgetHelper={}

local _format=string.format

local _rewardItemIndex={
root=0,
qualityEffect=1,
quality=2,
icon=3,
count=4,
stage=5,
lock=6,
stageBG=7,
gailv=8,
xin=9,
coutnBg=10,
grayImg=11,
teyou=12,
suit=13,
duanwei=14,
}

local _itemModelShowCmpIndex={
root=0,
itemModel=1,
itemEffectBg=2,
itemEffect=3,
itemImg=4,
itemClick=5,
zuShiModel1=6,
zuShiModel2=7,
bubbleframeRoot=8,
bubbleModel=9,
headKuang=10,
emotRoot=11,
emoticon=12,
}

local _item_color_func={
[ITEM_MAIN_TYPE.eYFLingZhen]=function(itemId,itemGuid)
local color=UIYuFuLingZhenControl:getItemColorById(itemId,itemGuid)
return color
end
}

local _item_count_func={
}

local _item_stage_func={
[ITEM_MAIN_TYPE.eYFLingZhen]=function(itemId,itemGuid)
local txt
local itemCfg=itemsConfig.getConfig(itemId)
txt=FMT.fmt("{0}级",itemCfg.level)
return txt
end
}

function widgetHelper.getWidgetDataStringA(key,index,arg1)
return _format('%d##%d##%s',key,index,arg1)
end

function widgetHelper.getWidgetDataStringB(key,index,arg1,arg2)
return _format('%d##%d##%s##%s',key,index,arg1,arg2)
end







function widgetHelper.setNormalRewardItem(widget,index,data,clearBtn)
local itemId=data[1]
local itemCount=data[2]
local flag=data[3]
local guid=data.guid
local equip=guid and equipsHelper.getEquip(guid)or nil
if equip==nil then
equip={itemid=itemId}
end

local itemConfig=itemsConfig.getConfig(itemId)

local countText
local showGrayImg=data.showGrayImage
local setIconGray
local showGain=false
if data.checkAmount then
local have
local isMoney=moneyConfig.isMoney(itemId)
if isMoney then
have=moneyModel.getMoney(itemId)
else
have=bagModel.getItemCountById(itemId)
end
local countStr=mathHelper.formatNumber2(itemCount)
local haveStr=mathHelper.formatNumber2(have)
if have<itemCount then
showGain=true
showGrayImg=true
local col=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
if isMoney then
countText=FMT.fmt('<color={0}>{1}</color>',col,countStr)
else
countText=FMT.fmt('<color={0}>{1}/{2}</color>',col,haveStr,countStr)
end
if have==0 then
setIconGray=true
end
else
if isMoney then
countText=countStr
else
countText=FMT.fmt('{0}/{1}',haveStr,countStr)
end
end
else
countText=data.countText or(itemCount>1 and mathHelper.formatNumber2(itemCount)or'')
end

local colorPage=itemConfig.colorPage or 0

local stage=data.stage

if data.showStage then
if not moneyConfig.isMoney(itemId)then
stage=itemConfig.stage
end
end

if itemsConfig.isGubao(itemId)then
stage=nil
end

local stageStr=stage and pfwindowslController:getStageStr(itemId,itemsConfig.getStageName(itemId))or""

local range=data.range
if range then
countText=FMT.fmt('{0}~{1}',range[1],range[2])
end

local suiticon=equipsHelper.getEquipSuitIcon(equip)

if not equip or suiticon==''then
local itemCfg=itemsConfig.getConfig(itemId)
if itemsConfig.isEquip(itemId)and itemCfg.fix then
local suitid=itemCfg.fix[0].suitid
suiticon=equipsHelper.getEquipSuitIconById(suitid)
end
end

if data.showSuit==false then
suiticon=''
end

local isShowGailv=data.isShowGailv or false

local _type=itemsConfig.getMainType(itemId)

local color=data.color
if not color then
local _color_func=_item_color_func[_type]
if _color_func then
color=_color_func(itemId,guid)
else
color=itemConfig.color
end
end

if not data.countText then
local _count_func=_item_count_func[_type]
if _count_func then
countText=_count_func(itemId,guid)
end
end

if stageStr==""then
local _stage_func=_item_stage_func[_type]
if _stage_func then
stageStr=_stage_func(itemId,guid)
stage=stageStr
end
end

local datas={

widgetHelper.getWidgetDataStringB(DataPropKey.eWidgetQualityEx,_rewardItemIndex.quality,colorPage,color),
widgetHelper.getWidgetDataStringA(DataPropKey.eWidgetGray,_rewardItemIndex.quality,setIconGray==true),
widgetHelper.getWidgetDataStringB(DataPropKey.eWidgetIcon,_rewardItemIndex.icon,itemsModel.getIconName(equip),true),
widgetHelper.getWidgetDataStringA(DataPropKey.eWidgetGray,_rewardItemIndex.icon,setIconGray==true),
widgetHelper.getWidgetDataStringA(DataPropKey.eWidgetText,_rewardItemIndex.count,countText),
widgetHelper.getWidgetDataStringA(DataPropKey.eWidgetActive,_rewardItemIndex.lock,flag==1),
widgetHelper.getWidgetDataStringA(DataPropKey.eWidgetActive,_rewardItemIndex.gailv,itemCount==-1 or isShowGailv==true),
widgetHelper.getWidgetDataStringA(DataPropKey.eWidgetActive,_rewardItemIndex.teyou,itemCount==-2 or data.teyou==true),
widgetHelper.getWidgetDataStringA(DataPropKey.eWidgetActive,_rewardItemIndex.stageBG,stage~=nil and stageStr~=''),
widgetHelper.getWidgetDataStringA(DataPropKey.eWidgetText,_rewardItemIndex.stage,stageStr),
widgetHelper.getWidgetDataStringA(DataPropKey.eWidgetActive,_rewardItemIndex.xin,data.isNew==true),
widgetHelper.getWidgetDataStringA(DataPropKey.eWidgetActive,_rewardItemIndex.coutnBg,countText~=''),
widgetHelper.getWidgetDataStringA(DataPropKey.eWidgetActive,_rewardItemIndex.grayImg,showGrayImg==true),
widgetHelper.getWidgetDataStringB(DataPropKey.eWidgetIcon,_rewardItemIndex.suit,suiticon,false),
}

local duanwei=data.duanwei
if duanwei then
datas[#datas+1]=widgetHelper.getWidgetDataStringB(DataPropKey.eWidgetActive,_rewardItemIndex.duanwei,duanwei==1)
end

local item=widget:SetChildWidgetByData(index,datas)
if data.shwoSmallSign then
itemsComponentHelper.setUIBaseItemSmallSignCommon(item,_rewardItemIndex.icon,itemId,setIconGray)
end
if not data.noClick then
local clickFunc=data.clickFunc
if not clickFunc then
local attach=data.tipsAttach
clickFunc=function()
if not showGain or not gainControl:showGainWin(itemId)then
if clearBtn==true then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eClearBtn,itemid=itemId,itemguid=guid,attach=attach})
else
itemsComponentHelper.onItemClickEx(itemId,nil,guid,attach)
end
end
end
end
item:SetChildButtonClick(_rewardItemIndex.icon,clickFunc)
end
return item
end

function widgetHelper.setItemQulaity(widget,itemid,index,color)
local itemCfg=itemsConfig.getConfig(itemid)
color=color or itemCfg.color
local colorPage=itemCfg.colorPage or 0
widget:SetChildQulaityEx(index,colorPage,color)
end


function widgetHelper.setItemModelShow(widget,itemId,offset,size)
widgetHelper.clearItemModelShow(widget)
local cfg=itemsConfig.getConfig(itemId)
local model=cfg.model
if itemsConfig.isDaoBingMaterials(itemId)then
local dbitemid=daobingConfig.getCombineDaoBing(itemId)
model=itemsConfig.getConfig(dbitemid).model
end

if model then
if itemsConfig.isDaoBing(itemId)or itemsConfig.isDaoBingMaterials(itemId)then
widgetHelper.setItemModelShow_DaoBing(widget,itemId)
else
widgetHelper.setItemModelShow_NormalItemModel(widget,model)
end
elseif cfg.funcparam and cfg.funcparam.type==28 and cfg.type1==18 then
widgetHelper.setItemModelShow_ZuShi(widget,itemId)
elseif cfg.funcparam and cfg.funcparam.type==item_funtion_type.disciple and cfg.funcparam.isSpecial then
widgetHelper.setItemModelShow_DiZi(widget,itemId)
elseif cfg.relevantPram and cfg.type1==18 then
widgetHelper.setItemModelShow_HeadKuangOrQiPaoKuangOrEmot(widget,itemId)
elseif cfg.relevantPram then

local relevantPram=cfg.relevantPram
local modelType=relevantPram.relevantId
if modelType==1 then
widgetHelper.setItemModelShow_GuBao(widget,relevantPram)
else



end
else

widgetHelper.setItemModelShow_NormalItemImage(widget,itemId)
end
offset=offset or{0,0}
size=size or 1
widget:SetChildScale(_itemModelShowCmpIndex.root,Vector3.New(size,size,size))
widget:SetChildAnchoredPosition(_itemModelShowCmpIndex.root,Vector2.New(offset[1],offset[2]))
end

function widgetHelper.clearItemModelShow(widget)
widget:SetChildUIModelRemoveTarget(_itemModelShowCmpIndex.itemModel)
widget:SetChildUIModelRemoveTarget(_itemModelShowCmpIndex.zuShiModel1)
widget:SetChildUIModelRemoveTarget(_itemModelShowCmpIndex.zuShiModel2)
widget:SetChildDOTweenAnimation_DOPause(_itemModelShowCmpIndex.itemImg)
widget:SetChildAnchoredPos(_itemModelShowCmpIndex.itemImg,0,0)
widget:SetChildActive(_itemModelShowCmpIndex.itemImg,false)
widget:SetChildShowEffect(_itemModelShowCmpIndex.itemEffect,0,false)
widget:SetChildShowEffect(_itemModelShowCmpIndex.itemEffectBg,0,false)
playerController:setWidgetHeadKuang(widget,_itemModelShowCmpIndex.headKuang)
widget:SetChildActive(_itemModelShowCmpIndex.headKuang,false)
widget:SetChildUIModelRemoveTarget(_itemModelShowCmpIndex.bubbleModel)
widget:SetChildCSImageIcon(_itemModelShowCmpIndex.bubbleframeRoot,"",false)
widget:SetChildActive(_itemModelShowCmpIndex.bubbleframeRoot,false)
widget:SetChildCSImageIcon(_itemModelShowCmpIndex.emoticon,"",false)
widget:SetChildActive(_itemModelShowCmpIndex.emotRoot,false)

widget:SetChildScale(_itemModelShowCmpIndex.itemImg,Vector3.New(1,1,1))
widget:SetChildScale(_itemModelShowCmpIndex.itemEffect,Vector3.New(1,1,1))
widget:SetChildScale(_itemModelShowCmpIndex.itemEffectBg,Vector3.New(1,1,1))
end


function widgetHelper.setItemModelShow_DaoBing(widget,oItemId,size)
local _daoBingBgEffectId=
{
[eQualityColor.ePurple]=10185,
[eQualityColor.eOrange]=10186,
[eQualityColor.eRed]=10187,
}
local itemId=oItemId
if itemsConfig.isDaoBingMaterials(oItemId)then
itemId=itemsConfig.getConfig(oItemId).piece[1]
end
local isMaxStar
local maxlv=daobingConfig.getStarMaxLv(itemId)
local starlv=0
isMaxStar=starlv==maxlv
local itemCfg=itemsConfig.getConfig(itemId)
local color=itemCfg.color

local modelParams=itemsConfig.getConfig(itemId).model
local effectInfo=isMaxStar and modelParams[2]or modelParams[1]
widget:SetChildShowEffect(_itemModelShowCmpIndex.itemEffect,effectInfo[1],true)
widget:SetChildShowEffect(_itemModelShowCmpIndex.itemEffectBg,_daoBingBgEffectId[color],true)

size=size or 0.8
widget:SetChildScale(_itemModelShowCmpIndex.itemEffect,Vector3.New(size,size,size))
widget:SetChildScale(_itemModelShowCmpIndex.itemEffectBg,Vector3.New(size,size,size))
end


function widgetHelper.setItemModelShow_NormalItemModel(widget,modelParams)
local modelID=modelParams.model
local defsize=cfgHelper.get2(cfg_dbbodyconfig_get,modelID,'scales')or{}
local size=modelParams.scale or defsize[1]or 1
local componnets=modelParams.cmp or{}
local animationID=modelParams.ani or 0
local offset=modelParams.offset
widget:SetChildUIModelShowTarget(_itemModelShowCmpIndex.itemModel,modelID,size,componnets,animationID)
if offset then
widget:SetChildUIModelShowTargetOffset(_itemModelShowCmpIndex.itemModel,offset[1],offset[2])
end
end


function widgetHelper.setItemModelShow_ZuShi(widget,itemId)
local itemCfg=itemsConfig.getConfig(itemId)
local sex=playerModel:getActorSex()

local list=itemCfg.funcparam.list[sex]
local modelParams=itemCfg.funcparam.model or{}
local scale=modelParams.scale or 0.5
local offsetX=modelParams.offsetX or 0
local offsetY=modelParams.offsetY or 0
if#(list or 0)==1 and list[1][1]==10 then
local temp={}
temp[list[1][1]]=list[1][2]
comHelper.setChildPlayerImage2(widget,_itemModelShowCmpIndex.zuShiModel2,temp,sex,scale,eAnimationID.idle,offsetX,offsetY,playerController:supportDynamic())
else
local selfImageList=playerImageModel:getDefaultImage()
local getImageId=function(tabid)
for i,v in ipairs(list)do
if v[1]==tabid then
return v[2]
end
end
end
local playerImage={}
for _,tabid in pairs(PLAYER_IMAGE_TYPE)do
playerImage[tabid]=getImageId(tabid)or selfImageList[tabid]
end
playerImageController.setPlayerModel(widget,_itemModelShowCmpIndex.zuShiModel1,playerImage,scale,eAnimationID.idle,offsetX,offsetY,playerController:supportDynamic())
end
end


function widgetHelper.setItemModelShow_HeadKuangOrQiPaoKuangOrEmot(widget,itemId)
local itemCfg=itemsConfig.getConfig(itemId)
local itemType1=itemCfg.type1
local itemType2=itemCfg.type2
local relevantPram=itemCfg.relevantPram
if itemType1==18 then
if itemType2==1 then

local headKuangId=relevantPram.relevantId
local headKuangCfg=cfgHelper.get1(cfg_headportraitframeconfig_get,headKuangId)
if headKuangCfg then
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
local kuangAnimType,kuangAnim,enterAnimId=playerModel:getActorFrameAnimById(headKuangId)
playerController:setWidgetHeadKuang(widget,_itemModelShowCmpIndex.headKuang,headKuangCfg.icon,kuangAnimType,kuangAnim,nil,enterAnimId)
widget:SetChildScale(_itemModelShowCmpIndex.headKuang,Vector3.New(size,size,size))
widget:SetChildAnchoredPosition(_itemModelShowCmpIndex.headKuang,Vector2.New(offset[1],offset[2]))
widget:SetChildActive(_itemModelShowCmpIndex.headKuang,true)
end
elseif itemType2==2 then

local bubbleFrameId=relevantPram.relevantId
local bubbleFrameCfg=cfgHelper.get1(cfg_bubbleframeconfig_get,bubbleFrameId)
if bubbleFrameCfg then
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
local bgmodel=bubbleFrameCfg.setmodel
if bgmodel then
widget:SetChildUIModelShowTarget(_itemModelShowCmpIndex.bubbleModel,bgmodel,1,{},eAnimationID.stand)
else
local kuangIconName=iconHelper.getChatKuangIcon(bubbleFrameCfg.icon)
widget:SetChildCSImageIcon(_itemModelShowCmpIndex.bubbleframeRoot,kuangIconName,false)
end
widget:SetChildScale(_itemModelShowCmpIndex.bubbleframeRoot,Vector3.New(size,size,size))
widget:SetChildAnchoredPosition(_itemModelShowCmpIndex.bubbleframeRoot,Vector2.New(offset[1],offset[2]))
widget:SetChildActive(_itemModelShowCmpIndex.bubbleframeRoot,true)
end
elseif itemType2==4 then

local bigEmotId=relevantPram.relevantId
local bigEmotCfg=cfgHelper.get1(cfg_chatebigmotconfig_get,bigEmotId)
if bigEmotCfg then
local size=relevantPram.pram.size or 1
local offset=relevantPram.pram.offset or{0,0}
local bigEmotName=iconHelper.getBigEmotIcon(bigEmotId)
widget:SetChildCSImageIcon(_itemModelShowCmpIndex.emoticon,bigEmotName,false)
widget:SetChildScale(_itemModelShowCmpIndex.emotRoot,Vector3.New(size,size,size))
widget:SetChildAnchoredPosition(_itemModelShowCmpIndex.emotRoot,Vector2.New(offset[1],offset[2]))
widget:SetChildActive(_itemModelShowCmpIndex.emotRoot,true)
end
end
end
end


function widgetHelper.setItemModelShow_GuBao(widget,relevantPram)
local pram=relevantPram.pram
local icon=pram.icon or''
local effectid=pram.effectid
widget:SetChildCSImageIcon(_itemModelShowCmpIndex.itemImg,icon,true)
local needMove=icon~=''
if needMove then
widget:SetChildDOTweenAnimation_DOPlay(_itemModelShowCmpIndex.itemImg)
widget:SetChildActive(_itemModelShowCmpIndex.itemImg,true)
else
widget:SetChildDOTweenAnimation_DOPause(_itemModelShowCmpIndex.itemImg)
widget:SetChildAnchoredPos(_itemModelShowCmpIndex.itemImg,0,0)
widget:SetChildActive(_itemModelShowCmpIndex.itemImg,false)
end

if effectid then
widget:SetChildShowEffect(_itemModelShowCmpIndex.itemEffect,effectid,true)
else
widget:SetChildShowEffect(_itemModelShowCmpIndex.itemEffect,0,false)
end

local size=0.8
widget:SetChildScale(_itemModelShowCmpIndex.itemImg,Vector3.New(size,size,size))
widget:SetChildScale(_itemModelShowCmpIndex.itemEffect,Vector3.New(size,size,size))
end


function widgetHelper.setItemModelShow_NormalItemImage(widget,itemId)
local iconName=iconHelper.getIconName(itemId)
widget:SetChildCSImageIcon(_itemModelShowCmpIndex.itemImg,iconName,false)
widget:SetChildSizeDelta(_itemModelShowCmpIndex.itemImg,250,250)
widget:SetChildActive(_itemModelShowCmpIndex.itemImg,true)
end


function widgetHelper.setItemModelShow_DiZi(widget,itemId)
local data=UIDiscipleModel:getItemDiscipleDataByItemId(itemId)
if not data then
return
end

if not data.hasFixedImage then

logErr(FMT.fmt("展示弟子道具 {0} 对应的弟子id: {1} 没有配置固定组件库 无法加载形象",itemId,data.id))
return
end

local info=data.imageInfo
if info then

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info)
local scale=1
local animId=eAnimationID.stand
widget:SetChildUIModelShowTarget(_itemModelShowCmpIndex.zuShiModel1,modelParams.body,scale,modelParams.componets,animId)
end
end
