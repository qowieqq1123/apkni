





itemsComponentHelper={}



function itemsComponentHelper.getCommonFillData(item,conf)
if item==nil then
return itemsComponentHelper.getCommonSpecialFillData(conf)
else
local itemid=item.itemid
if itemsConfig.isMoney(itemid)then
return itemsComponentHelper.getCommonMoneyFillData(item,conf)
elseif itemsConfig.isItem(itemid)then
return itemsComponentHelper.getCommonItemsFillData(item,conf)
elseif itemsConfig.isEquip(itemid)then
return itemsComponentHelper.getCommonEquipsFillData(item,conf)
elseif itemsConfig.isFabao(itemid)then
return itemsComponentHelper.getCommonFabaoFillData(item,conf)
elseif itemsConfig.isDaoBing(itemid)then
return itemsComponentHelper.getCommonDaoBingFillData(item,conf)
elseif itemsConfig.isClothing(itemid)then
return itemsComponentHelper.getCommonClothingFillData(item,conf)
elseif itemsConfig.isXingChen(itemid)then
return itemsComponentHelper.getCommonXingChenFillData(item,conf)
elseif itemsConfig.isYunZhouComponents(itemid)then
return itemsComponentHelper.getCommonYunZhouEquipsFillData(item,conf)
elseif itemsConfig.isVocEquip(itemid)then
return itemsComponentHelper.getCommonVocEquipsFillData(item,conf)
else
return itemsComponentHelper.getCommonItemsFillData(item,conf)
end
end
end




function itemsComponentHelper.getCommonSpecialFillData(conf)
local prop={}

local showbg=conf.showbg or false
local select=conf.select or false
local color=conf.color or eQualityColor.eWhite
local iconName=conf.iconName or''
local countStr=conf.itemcount or''
local showCountBG=conf.showCountBG
if showCountBG==nil then showCountBG=false end
local graynum=conf.gray
local name=conf.name or''
local itemid=conf.itemid or-1
local guid=conf.guid or-1
local attach=conf.attach or''
local colorEffect=conf.colorEffect
local stageStr=conf.stageStr or''
local showStageBg=conf.showStageBg

local range=conf.range
if range then
countStr=FMT.fmt('{0}~{1}',range[1],range[2])
end

prop[PropIndex(DataPropKey.eWidgetActive,0)]=showbg
prop[PropIndex(DataPropKey.eWidgetActive,1)]=select
prop[PropIndex(DataPropKey.eWidgetQualityEx,2)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,3)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,4)]=countStr
prop[PropIndex(DataPropKey.eWidgetActive,5)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,6)]=stageStr
prop[PropIndex(DataPropKey.eWidgetText,7)]=name
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=guid
prop[DataPropKey.eItemAttach]=attach
if graynum~=nil then

local isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(graynum,eGrayType.eMaskGray-1)
prop[PropIndex(DataPropKey.eWidgetGray,3)]=isGray
prop[PropIndex(DataPropKey.eWidgetGray,2)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isGrayMask
end
if colorEffect then
prop[PropIndex(DataPropKey.eWidgetQualityEffect,10)]=colorEffect
end
if showStageBg then
prop[PropIndex(DataPropKey.eWidgetActive,9)]=stageStr~=''
end
return prop
end


function itemsComponentHelper.getCommonMoneyFillData(item,conf)
if conf==nil then conf={}end
local prop={}
local itemcount=item.itemcount or 0
local itemid=item.itemid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local name=conf.nomalname==true and itemConfig.name or FMT.cfmt(color,itemConfig.name)
local attach=conf.attach or''

local showbg=conf.showbg or false
local select=conf.select or false
local countStr=conf.itemcount or mathHelper.formatNumber(itemcount)
if conf.showname==false then name=''end
if conf.showcount==false then countStr=''end
local graynum=conf.gray
local showCountBG=conf.showCountBG
if showCountBG==nil then showCountBG=false end

local colorPage=itemConfig.colorPage or 0
local itemColor=colorPage*100+color
local colorEffect=conf.colorEffect

local range=conf.range
if range then
countStr=FMT.fmt('{0}~{1}',range[1],range[2])
end

prop[PropIndex(DataPropKey.eWidgetActive,0)]=showbg
prop[PropIndex(DataPropKey.eWidgetActive,1)]=select
prop[PropIndex(DataPropKey.eWidgetQualityEx,2)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,3)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,4)]=countStr
prop[PropIndex(DataPropKey.eWidgetActive,5)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,6)]=''
prop[PropIndex(DataPropKey.eWidgetText,7)]=name
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=-1
prop[DataPropKey.eItemAttach]=attach
if graynum~=nil then

local isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(graynum,eGrayType.eMaskGray-1)
prop[PropIndex(DataPropKey.eWidgetGray,3)]=isGray
prop[PropIndex(DataPropKey.eWidgetGray,2)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isGrayMask
end
if colorEffect then
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end
prop[PropIndex(DataPropKey.eWidgetQualityEffect,10)]=colorEffect
end
return prop
end

function itemsComponentHelper.getCommonItemsFillData(item,conf)
if conf==nil then conf={}end
local prop={}
local itemcount=item.itemcount or 0
local itemid=item.itemid
local itemguid=item.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local name=conf.nomalname==true and itemConfig.name or FMT.cfmt(color,itemConfig.name)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local graynum=conf.gray

local attach=conf.attach or''
local showbg=conf.showbg or false
local select=conf.select or false
stageStr=conf.stage or stageStr
local countStr=conf.itemcount or mathHelper.formatNumber(itemcount)
if conf.showname==false then name=''end
if conf.showcount==false then countStr=''end
local showStageBg=conf.showStageBg
local showCountBG=conf.showCountBG
if showCountBG==nil then showCountBG=false end

local colorPage=itemConfig.colorPage or 0
local itemColor=colorPage*100+color
local colorEffect=conf.colorEffect

local range=conf.range
if range then
countStr=FMT.fmt('{0}~{1}',range[1],range[2])
end

prop[PropIndex(DataPropKey.eWidgetActive,0)]=showbg
prop[PropIndex(DataPropKey.eWidgetActive,1)]=select
prop[PropIndex(DataPropKey.eWidgetQualityEx,2)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,3)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,4)]=countStr
prop[PropIndex(DataPropKey.eWidgetActive,5)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,6)]=stageStr
prop[PropIndex(DataPropKey.eWidgetText,7)]=name
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
prop[DataPropKey.eItemAttach]=attach

if graynum~=nil then

local isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(graynum,eGrayType.eMaskGray-1)
prop[PropIndex(DataPropKey.eWidgetGray,3)]=isGray
prop[PropIndex(DataPropKey.eWidgetGray,2)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isGrayMask
end
if colorEffect then
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end
prop[PropIndex(DataPropKey.eWidgetQualityEffect,10)]=colorEffect
end
if showStageBg then
prop[PropIndex(DataPropKey.eWidgetActive,9)]=stageStr~=''
end
return prop
end

function itemsComponentHelper.getCommonEquipsFillData(item,conf)
if conf==nil then conf={}end
local prop={}
local itemid=item.itemid
local itemguid=item.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(item)
local name=itemsModel.getNameByItem(item)
name=conf.nomalname==true and name or FMT.cfmt(color,name)
local stageStr=itemConfig.stage and FMT.fmt('{0}阶',itemConfig.stage)or''
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''

local showbg=conf.showbg or false
local select=conf.select or false
local attach=conf.attach or''
local itemcount=conf.itemcount or jinglianStr
if conf.showname==false then name=''end
if conf.showstage==false then stageStr=''end
if conf.showjinglian==false then jinglianStr=''end
if conf.showcount==false then itemcount=''end
local graynum=conf.gray
local showStageBg=conf.showStageBg
local showCountBG=conf.showCountBG
if showCountBG==nil then showCountBG=false end

local colorPage=itemConfig.colorPage or 0
local itemColor=colorPage*100+color
local colorEffect=conf.colorEffect

prop[PropIndex(DataPropKey.eWidgetActive,0)]=showbg
prop[PropIndex(DataPropKey.eWidgetActive,1)]=select
prop[PropIndex(DataPropKey.eWidgetQualityEx,2)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,3)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,4)]=itemcount
prop[PropIndex(DataPropKey.eWidgetActive,5)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,6)]=stageStr
prop[PropIndex(DataPropKey.eWidgetText,7)]=name
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
prop[DataPropKey.eItemAttach]=attach

if graynum~=nil then

local isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(graynum,eGrayType.eMaskGray-1)
prop[PropIndex(DataPropKey.eWidgetGray,3)]=isGray
prop[PropIndex(DataPropKey.eWidgetGray,2)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isGrayMask
end
if colorEffect then
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end
prop[PropIndex(DataPropKey.eWidgetQualityEffect,10)]=colorEffect
end

if showStageBg then
prop[PropIndex(DataPropKey.eWidgetActive,9)]=stageStr~=''
end

return prop
end


function itemsComponentHelper.getCommonFabaoFillData(item,conf)
if conf==nil then conf={}end
local prop={}
local itemid=item.itemid
local itemguid=item.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local itemData=item.itemData or{}
local iconName=itemsModel.getIconName(item)
local name=item.name or item.itemData.name or''
local stage=itemConfig.stage or 0
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=stage>0 and pfwindowslController:getStageStr(itemid,stageTitile)or''
local jilianlv=itemData.jilianlv or 0
local jilianlvStr=conf.itemcount or jilianlv>0 and FMT.fmt('+{0}',jilianlv)or''

local showbg=conf.showbg or false
local select=conf.select or false
local attach=conf.attach or''
if conf.showname==false then name=''end
if conf.showstage==false then stageStr=''end
if conf.showjinglian==false then jilianlvStr=''end
if conf.showcount==false then jilianlvStr=''end
local graynum=conf.gray
local showStageBg=conf.showStageBg
local showCountBG=conf.showCountBG
if showCountBG==nil then showCountBG=false end

local colorPage=itemConfig.colorPage or 0
local itemColor=colorPage*100+color
local colorEffect=conf.colorEffect

prop[PropIndex(DataPropKey.eWidgetActive,0)]=showbg
prop[PropIndex(DataPropKey.eWidgetActive,1)]=select
prop[PropIndex(DataPropKey.eWidgetQualityEx,2)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,3)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,4)]=jilianlvStr
prop[PropIndex(DataPropKey.eWidgetActive,5)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,6)]=stageStr
prop[PropIndex(DataPropKey.eWidgetText,7)]=name
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
prop[DataPropKey.eItemAttach]=attach

if graynum~=nil then

local isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(graynum,eGrayType.eMaskGray-1)
prop[PropIndex(DataPropKey.eWidgetGray,3)]=isGray
prop[PropIndex(DataPropKey.eWidgetGray,2)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isGrayMask
end
if colorEffect then
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end
prop[PropIndex(DataPropKey.eWidgetQualityEffect,10)]=colorEffect
end

if showStageBg then
prop[PropIndex(DataPropKey.eWidgetActive,9)]=stageStr~=''
end
return prop
end

function itemsComponentHelper.getCommonDaoBingFillData(item,conf)
if conf==nil then conf={}end
local prop={}
local itemcount=item.itemcount or 0
local itemid=item.itemid
local itemguid=item.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local name=conf.nomalname==true and itemConfig.name or FMT.cfmt(color,itemConfig.name)
local stageStr=''
local graynum=conf.gray

local attach=conf.attach or''
local showbg=conf.showbg or false
local select=conf.select or false
local countStr=conf.itemcount or mathHelper.formatNumber(itemcount)
if conf.showname==false then name=''end
if conf.showcount==false then countStr=''end
local showCountBG=conf.showCountBG
if showCountBG==nil then showCountBG=false end

local colorPage=itemConfig.colorPage or 0
local itemColor=colorPage*100+color
local colorEffect=conf.colorEffect

local range=conf.range
if range then
countStr=FMT.fmt('{0}~{1}',range[1],range[2])
end

prop[PropIndex(DataPropKey.eWidgetActive,0)]=showbg
prop[PropIndex(DataPropKey.eWidgetActive,1)]=select
prop[PropIndex(DataPropKey.eWidgetQualityEx,2)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,3)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,4)]=countStr
prop[PropIndex(DataPropKey.eWidgetActive,5)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,6)]=stageStr
prop[PropIndex(DataPropKey.eWidgetText,7)]=name
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
prop[DataPropKey.eItemAttach]=attach

if graynum~=nil then

local isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(graynum,eGrayType.eMaskGray-1)
prop[PropIndex(DataPropKey.eWidgetGray,3)]=isGray
prop[PropIndex(DataPropKey.eWidgetGray,2)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isGrayMask
end
if colorEffect then
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end
prop[PropIndex(DataPropKey.eWidgetQualityEffect,10)]=colorEffect
end
prop[PropIndex(DataPropKey.eWidgetActive,9)]=stageStr~=''
return prop
end

function itemsComponentHelper.getCommonClothingFillData(item,conf)
if conf==nil then conf={}end
local prop={}
local itemcount=item.itemcount or 0
local itemid=item.itemid
local itemguid=item.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local name=conf.nomalname==true and itemConfig.name or FMT.cfmt(color,itemConfig.name)
local stageStr=''
local graynum=conf.gray

local attach=conf.attach or''
local showbg=conf.showbg or false
local select=conf.select or false
local countStr=conf.itemcount or mathHelper.formatNumber(itemcount)
if conf.showname==false then name=''end
if conf.showcount==false then countStr=''end
local showCountBG=conf.showCountBG
if showCountBG==nil then showCountBG=false end

local colorPage=itemConfig.colorPage or 0
local itemColor=colorPage*100+color
local colorEffect=conf.colorEffect

local range=conf.range
if range then
countStr=FMT.fmt('{0}~{1}',range[1],range[2])
end

prop[PropIndex(DataPropKey.eWidgetActive,0)]=showbg
prop[PropIndex(DataPropKey.eWidgetActive,1)]=select
prop[PropIndex(DataPropKey.eWidgetQualityEx,2)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,3)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,4)]=countStr
prop[PropIndex(DataPropKey.eWidgetActive,5)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,6)]=stageStr
prop[PropIndex(DataPropKey.eWidgetText,7)]=name
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
prop[DataPropKey.eItemAttach]=attach

if graynum~=nil then

local isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(graynum,eGrayType.eMaskGray-1)
prop[PropIndex(DataPropKey.eWidgetGray,3)]=isGray
prop[PropIndex(DataPropKey.eWidgetGray,2)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isGrayMask
end
if colorEffect then
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end
prop[PropIndex(DataPropKey.eWidgetQualityEffect,10)]=colorEffect
end
prop[PropIndex(DataPropKey.eWidgetActive,9)]=stageStr~=''
return prop
end

function itemsComponentHelper.getCommonXingChenFillData(item,conf)
if conf==nil then conf={}end
local prop={}
local itemcount=item.itemcount or 0
local itemid=item.itemid
local itemguid=item.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)

local equip=itemsModel.getItem(itemguid)
local rare=false




local nameStr=rare and FMT.fmt("稀·{0}",itemConfig.name)or itemConfig.name

local name=conf.nomalname==true and nameStr or FMT.cfmt(color,nameStr)
local stageStr=''
local graynum=conf.gray

local attach=conf.attach or''
local showbg=conf.showbg or false
local select=conf.select or false
local countStr=conf.itemcount or mathHelper.formatNumber(itemcount)
if conf.showname==false then name=''end
if conf.showcount==false then countStr=''end
local showCountBG=conf.showCountBG
if showCountBG==nil then showCountBG=false end

local colorPage=itemConfig.colorPage or 0
local itemColor=colorPage*100+color
local colorEffect=conf.colorEffect

local range=conf.range
if range then
countStr=FMT.fmt('{0}~{1}',range[1],range[2])
end



prop[PropIndex(DataPropKey.eWidgetActive,0)]=showbg
prop[PropIndex(DataPropKey.eWidgetActive,1)]=select
prop[PropIndex(DataPropKey.eWidgetQualityEx,2)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,3)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,4)]=countStr
prop[PropIndex(DataPropKey.eWidgetActive,5)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,6)]=stageStr
prop[PropIndex(DataPropKey.eWidgetText,7)]=name
if conf.showRare then
prop[PropIndex(DataPropKey.eWidgetActive,11)]=rare
end

prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
prop[DataPropKey.eItemAttach]=attach

if graynum~=nil then

local isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(graynum,eGrayType.eMaskGray-1)
prop[PropIndex(DataPropKey.eWidgetGray,3)]=isGray
prop[PropIndex(DataPropKey.eWidgetGray,2)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isGrayMask
end
if colorEffect then
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end
prop[PropIndex(DataPropKey.eWidgetQualityEffect,10)]=colorEffect
end
prop[PropIndex(DataPropKey.eWidgetActive,9)]=stageStr~=''
return prop
end

function itemsComponentHelper.getCommonVocEquipsFillData(item,conf)
if conf==nil then conf={}end
local prop={}
local itemid=item.itemid
local itemguid=item.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=itemsModel.getIconName(item)
local name=itemsModel.getNameByItem(item)
name=conf.nomalname==true and name or FMT.cfmt(color,name)

local stageStr=''
local jinglianlv=item.itemData and item.itemData.jinglianlv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''

local showbg=conf.showbg or false
local select=conf.select or false
local attach=conf.attach or''
local itemcount=conf.itemcount or jinglianStr
if conf.showname==false then name=''end
if conf.showstage==false then stageStr=''end
if conf.showjinglian==false then jinglianStr=''end
if conf.showcount==false then itemcount=''end
local graynum=conf.gray
local showStageBg=false
local showCountBG=conf.showCountBG
if showCountBG==nil then showCountBG=false end

local colorPage=itemConfig.colorPage or 0
local itemColor=colorPage*100+color
local colorEffect=conf.colorEffect

prop[PropIndex(DataPropKey.eWidgetActive,0)]=showbg
prop[PropIndex(DataPropKey.eWidgetActive,1)]=select
prop[PropIndex(DataPropKey.eWidgetQualityEx,2)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,3)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,4)]=itemcount
prop[PropIndex(DataPropKey.eWidgetActive,5)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,6)]=stageStr
prop[PropIndex(DataPropKey.eWidgetText,7)]=name
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
prop[DataPropKey.eItemAttach]=attach

if graynum~=nil then

local isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(graynum,eGrayType.eMaskGray-1)
prop[PropIndex(DataPropKey.eWidgetGray,3)]=isGray
prop[PropIndex(DataPropKey.eWidgetGray,2)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isGrayMask
end
if colorEffect then
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end
prop[PropIndex(DataPropKey.eWidgetQualityEffect,10)]=colorEffect
end

if showStageBg then
prop[PropIndex(DataPropKey.eWidgetActive,9)]=stageStr~=''
end

return prop
end

function itemsComponentHelper.getCommonYunZhouEquipsFillData(item,conf)
if conf==nil then conf={}end
local prop={}
local itemcount=item.itemcount or 0
local itemid=item.itemid
local itemguid=item.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local name=conf.nomalname==true and itemConfig.name or FMT.cfmt(color,itemConfig.name)
local graynum=conf.gray

local stageStr=''
local attach=conf.attach or''
local showbg=conf.showbg or false
local select=conf.select or false
local countStr=conf.itemcount or mathHelper.formatNumber(itemcount)
if conf.showname==false then name=''end
if conf.showcount==false then countStr=''end
local showStageBg=conf.showStageBg
local showCountBG=false

local colorPage=itemConfig.colorPage or 0
local itemColor=colorPage*100+color
local colorEffect=conf.colorEffect

local range=conf.range
if range then
countStr=FMT.fmt('{0}~{1}',range[1],range[2])
end

prop[PropIndex(DataPropKey.eWidgetActive,0)]=showbg
prop[PropIndex(DataPropKey.eWidgetActive,1)]=select
prop[PropIndex(DataPropKey.eWidgetQualityEx,2)]=itemColor
prop[PropIndex(DataPropKey.eWidgetIcon,3)]=iconName
prop[PropIndex(DataPropKey.eWidgetText,4)]=countStr
prop[PropIndex(DataPropKey.eWidgetActive,5)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,6)]=""
prop[PropIndex(DataPropKey.eWidgetText,7)]=name
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
prop[DataPropKey.eItemAttach]=attach

if graynum~=nil then

local isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(graynum,eGrayType.eMaskGray-1)
prop[PropIndex(DataPropKey.eWidgetGray,3)]=isGray
prop[PropIndex(DataPropKey.eWidgetGray,2)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isGrayMask
end
if colorEffect then
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end
prop[PropIndex(DataPropKey.eWidgetQualityEffect,10)]=colorEffect
end
if showStageBg then
prop[PropIndex(DataPropKey.eWidgetActive,9)]=stageStr~=''
end
return prop
end


function itemsComponentHelper.setUIBaseItemSign(item,conf)
local itemid=conf.itemid
local isGray=false
local graynum=conf.gray
if graynum~=nil then
isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
end
itemsComponentHelper.setUIBaseItemSmallSignCommon(item,3,itemid,isGray)
end

function itemsComponentHelper.getTempFillData(conf)
local prop={}

local select=conf.select or false
local showbg=conf.showbg or false
local bgColor=conf.bgColor


prop[PropIndex(DataPropKey.eWidgetActive,0)]=showbg
if bgColor then
prop[PropIndex(DataPropKey.eWidgetQuality,0)]=bgColor
end
prop[PropIndex(DataPropKey.eWidgetActive,1)]=select
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetActive,3)]=false
prop[PropIndex(DataPropKey.eWidgetText,4)]=''
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false
prop[PropIndex(DataPropKey.eWidgetText,6)]=''
prop[PropIndex(DataPropKey.eWidgetText,7)]=''
prop[DataPropKey.eItemID]=-1
prop[DataPropKey.eItemSeries]=-1
prop[DataPropKey.eItemAttach]=''

return prop
end



function itemsComponentHelper.getCommonTempDataSmall()
local prop={}
prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=0
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=''
prop[PropIndex(DataPropKey.eWidgetActive,2)]=false
prop[PropIndex(DataPropKey.eWidgetText,3)]=''
prop[PropIndex(DataPropKey.eWidgetText,4)]=''
prop[PropIndex(DataPropKey.eWidgetActive,5)]=false
prop[PropIndex(DataPropKey.eWidgetText,6)]=''
prop[DataPropKey.eItemID]=-1
prop[DataPropKey.eItemSeries]=-1
prop[DataPropKey.eItemAttach]=''
prop[PropIndex(DataPropKey.eWidgetActive,7)]=false
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
return prop
end


function itemsComponentHelper.getCommonFillDataSmall(conf)
if conf==nil then conf={}end
local itemid=conf.itemid
local itemguid=conf.itemguid or-1
local prop={}
local iconColor
local iconName=conf.iconName
local name
local showStage=conf.showStage or false

local stageStr=''
local colorEffect=conf.colorEffect
if colorEffect==false then colorEffect=-1 end
if itemid~=0 then
if itemsConfig.isVocEquip(itemid)or itemsConfig.isYunZhouComponents(itemid)then
showStage=false
end
local bagItem=nil
if itemguid~=nil and itemguid~=-1 then
bagItem=itemsModel.getItem(itemguid)
end
local itemConfig=itemsConfig.getConfig(itemid)
iconColor=itemConfig.color
local colorPage=itemConfig.colorPage or 0
iconColor=colorPage*100+iconColor
if not iconName then
if bagItem~=nil then
iconName=itemsModel.getIconName(bagItem)
else
iconName=iconHelper.getIconName(itemid)
end
end
name=itemConfig.name
if bagItem then
name=itemsModel.getNameByItem(bagItem)
end
if conf.name~=nil then
name=conf.name
end
if showStage==true then
showStage=itemConfig.stage~=nil
end
if itemsConfig.getMainType(itemid)==ITEM_MAIN_TYPE.eXingChen then
showStage=false
end
if showStage then
stageStr=pfwindowslController:getStageStr(itemid,itemsConfig.getStageName(itemid))
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=FMT.fmt('仙·{0}{1}',itemConfig.stage,itemsConfig.getStageName(itemid))
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=FMT.fmt('魔·{0}{1}',itemConfig.stage,itemsConfig.getStageName(itemid))
end
end
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end
else
iconColor=conf.iconColor
iconName=conf.iconName
name=conf.name or''
stageStr=conf.stageStr or''
end

local countStr=conf.itemcount or''
local showCountBG=false
local attach=conf.attach or''
if conf.showname==false then name=''end
if conf.showCountBG==true then showCountBG=true end
local graynum=conf.gray

local range=conf.range
if range then
countStr=FMT.fmt('{0}~{1}',range[1],range[2])
end

prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=iconColor
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetActive,2)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,3)]=countStr
prop[PropIndex(DataPropKey.eWidgetText,4)]=name
prop[PropIndex(DataPropKey.eWidgetActive,5)]=showStage
if showStage then
prop[PropIndex(DataPropKey.eWidgetText,6)]=stageStr
end
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
prop[DataPropKey.eItemAttach]=attach

if conf.itemIndex then
prop[DataPropKey.eItemIndex]=conf.itemIndex
end
if graynum~=nil then

local isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
local isGrayMask=mathHelper.getBitValue(graynum,eGrayType.eMaskGray-1)
local isLock=mathHelper.getBitValue(graynum,eGrayType.eLock-1)
prop[PropIndex(DataPropKey.eWidgetGray,0)]=isGray
prop[PropIndex(DataPropKey.eWidgetGray,1)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,7)]=isGrayMask or isGray
prop[PropIndex(DataPropKey.eWidgetActive,8)]=isLock
end
if colorEffect then
prop[PropIndex(DataPropKey.eWidgetQualityEffect,9)]=colorEffect
end

return prop
end


function itemsComponentHelper.setUIBaseItemSmallSign(item,conf)
local itemid=conf.itemid
local isGray=false
local graynum=conf.gray
if graynum~=nil then
isGray=mathHelper.getBitValue(graynum,eGrayType.eGray-1)
end
itemsComponentHelper.setUIBaseItemSmallSignCommon(item,1,itemid,isGray)
end

function itemsComponentHelper.setUIBaseItemSmallSignCommon(item,index,itemid,isGray,callback)
local signIcon=nil
if itemid~=0 then
local itemConfig=itemsConfig.getConfig(itemid)
signIcon=itemConfig.signIcon
end
itemsComponentHelper.setUIBaseItemSmallSignCommonEx(item,index,signIcon,isGray,callback)
end

function itemsComponentHelper.setUIBaseItemSmallSignCommonEx(item,index,signIcon,isGray,callback)
local add=false
if signIcon~=nil then

local signIconName=cfgHelper.get2(cfg_itemsignconfig_get,signIcon,'icon')
local func=function(guid_)
local widget=item:GetChildExpandUIEx(guid_)
if widget then
widget:SetChildIcon(0,signIconName,false)
widget:SetChildImageExGray(0,isGray)
if callback then
callback(widget)
end
end
end
item:SetChildCommonItemSign(index,INSTANCE_TYPE.eCommonItemSignUIExpand,func)
add=true
end
if not add then

item:SetChildCommonItemSign(index,INSTANCE_TYPE.eCommonItemSignUIExpand,nil)
end
end




function itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
if itemid==nil or itemid==-1 then return end
if attach==''then attach=nil end
tipsManager.showTips({itemid=itemid,itemguid=itemguid,attach=attach})
end

function itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
local mainType=itemsConfig.getMainType(itemid)
if attach==''then attach=nil end
if mainType==ITEM_MAIN_TYPE.eGubao then
gubaoController:gubaoShowTips(itemid,index,itemguid,attach)
elseif mainType==ITEM_MAIN_TYPE.eYuHuo then
UIAquariumControl:showYuHuoTips(itemid,index,itemguid,attach)
elseif mainType==ITEM_MAIN_TYPE.eLingShou then

local lsGuid=attach
local lsData=nil
if lsGuid~=nil then
lsData=lingshouModel:getLingShouData(lsGuid)
end
if lsData==nil and itemguid and itemguid~=-1 then
lsGuid=itemguid
lsData=lingshouModel:getLingShouData(lsGuid)
end

if lsData then
UIManager:showWindow('UILingShouTipsWin',{ls_guid=lsGuid,lsData=lsData})
else
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end
elseif xianbaoConfig.isXianbaoActiveItem(itemid)then
xianbaoController:showXBTipsByItemID(itemid)
else
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end
end

function itemsComponentHelper:checkItemShowColorEffect(itemid)
local check=false
if itemsConfig.isGubao(itemid)then

if gubaoLookup:good2GuBaoPiece(itemid)==nil then
check=true
end
end
if check then
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
if color>=eQualityColor.eGreen then
return color
end
end
return-1
end



function itemsComponentHelper.getDaoBingSmallData(item,conf)
if conf==nil then conf={}end
local prop={}
local itemcount=item.itemcount or 0
local itemid=item.itemid
local itemguid=item.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local graynum=conf.gray
local isGray=graynum and mathHelper.getBitValue(graynum,eGrayType.eGray-1)or false
local hasEquiped=false
if conf.showEquiped then
hasEquiped=daobingModel:getDiziguidByItemguid(itemguid)~=nil
end
local attach=conf.attach or''
local select=conf.select or false
local jjlv=daobingModel:getJilianLv(itemguid)
local countStr=jjlv>0 and FMT.fmt('+{0}',jjlv)or''
if conf.showcount==false then countStr=''end
local showCountBG=conf.showCountBG
if showCountBG==nil then showCountBG=false end

local colorPage=itemConfig.colorPage or 0
local itemColor=colorPage*100+color
local colorEffect=conf.colorEffect
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end

local range=conf.range
if range then
countStr=FMT.fmt('{0}~{1}',range[1],range[2])
end

prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=itemColor
if colorEffect then
prop[PropIndex(DataPropKey.eWidgetQualityEffect,0)]=colorEffect
end
prop[PropIndex(DataPropKey.eWidgetGray,0)]=isGray
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetGray,1)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,2)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,3)]=countStr
prop[PropIndex(DataPropKey.eWidgetActive,4)]=select
prop[PropIndex(DataPropKey.eWidgetActive,5)]=hasEquiped
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
prop[DataPropKey.eItemAttach]=attach
return prop
end


function itemsComponentHelper.getClothingSmallData(item,conf)
if conf==nil then conf={}end
local prop={}
local itemcount=item.itemcount or 0
local itemid=item.itemid
local itemguid=item.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local graynum=conf.gray
local isGray=graynum and mathHelper.getBitValue(graynum,eGrayType.eGray-1)or false
local hasEquiped=false
if conf.showEquiped then
hasEquiped=ClothingModel:getDiziguidByItemguid(itemguid)~=nil
end
local attach=conf.attach or''
local select=conf.select or false








local showCountBG=conf.showCountBG
if showCountBG==nil then showCountBG=false end

local colorPage=itemConfig.colorPage or 0
local itemColor=colorPage*100+color
local colorEffect=conf.colorEffect
if colorEffect==true then
colorEffect=itemConfig.color>=eQualityColor.eGreen and itemConfig.color or-1
end

prop[PropIndex(DataPropKey.eWidgetQualityEx,0)]=itemColor
if colorEffect then
prop[PropIndex(DataPropKey.eWidgetQualityEffect,0)]=colorEffect
end
prop[PropIndex(DataPropKey.eWidgetGray,0)]=isGray
prop[PropIndex(DataPropKey.eWidgetIcon,1)]=iconName
prop[PropIndex(DataPropKey.eWidgetGray,1)]=isGray
prop[PropIndex(DataPropKey.eWidgetActive,2)]=showCountBG
prop[PropIndex(DataPropKey.eWidgetText,3)]=''
prop[PropIndex(DataPropKey.eWidgetActive,4)]=select
prop[PropIndex(DataPropKey.eWidgetActive,5)]=hasEquiped

prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=itemguid
prop[DataPropKey.eItemAttach]=attach
return prop
end
