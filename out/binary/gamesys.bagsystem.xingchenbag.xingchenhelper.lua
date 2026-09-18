







xingChenHelper={}

function xingChenHelper.getPosType(itemid)
return itemsConfig.getConfig(itemid).type1
end




function xingChenHelper.getAffixList(equip)
return equip.itemData.affixList or{}
end

function xingChenHelper.getAffixListByGuid(guid)
local equip=equipsHelper.getEquip(guid)
return xingChenHelper.getAffixList(equip)
end

function xingChenHelper.getAffixLimit(equip,lv)
local affix_num=0
lv=lv or xingChenHelper.getStarLevel(equip)
local add_num=cfgHelper.get(cfg_starsstarconfig_get,lv,"affix_cnt")
affix_num=affix_num+add_num
local length=#xingChenHelper.getAffixList(equip)
if length>affix_num then
return length
else
return affix_num
end
end

function xingChenHelper.getMaxAffixLimit()
local max=#cfg_starsstarconfig()
return cfgHelper.get(cfg_starsstarconfig_get,max,"affix_cnt")
end

local colorList={3,2,4,1,1}
function xingChenHelper.getAffixColorFrame(color)
local abName=globalABLookup.global
local frameIcon='frame_tytezhikuang_'..(colorList[color]or 3)
return abName,frameIcon
end

function xingChenHelper.getAffixColorName(name,color)
local str
if color then
str=FMT.fmt('<color={0}>【{1}】</color>',FONT_COLOR_VAL[color],name)
else
str=FMT.fmt('【{0}】',name)
end
return str
end

function xingChenHelper.getAffixNameStr(name)
if pfwindowslController:checkIsGameVersion_yuenan()then
name=string.addNewlineAfterSecondWord(name)
if string.lenEx(name)>22 then
name=utf8.sub(name,1,22)
name=string.format("%s...",name)
end
else
if string.lenEx(name)>5 then
name=utf8.sub(name,1,5)
name=string.format("%s...",name)
end
end
return name
end

function xingChenHelper.getAllAffix()
local posData=xingChenBagModel:getPosData()
local list={}
for idx,item in pairs(posData)do
local affixList=xingChenHelper.getAffixList(item)
for i,v in ipairs(affixList)do
table.insert(list,v)
end
end

return list
end


function xingChenHelper.sortEquip(pos,sortOrder,showEquiped,newfilter)

local filter={}
filter[ITEM_FILTER_TYPE.eItemType]=ITEM_MAIN_TYPE.eXingChen
if pos then
filter[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,{pos}}
end

if newfilter then
for k,v in pairs(newfilter)do
filter[k]=v
end
end

local sortList=bagControl.getBagItemsByFilter(BAG_TYPE.eXingChen,filter,false)

local sortRule={}

sortRule[1]={ITEM_SORT_TYPE.eColor}
sortRule[2]={ITEM_SORT_TYPE.eRare}

sortRule.sort=sortOrder or ITEM_SORT_COMPARE_TYPE.eUpOrder

table.sort(sortList,function(a,b)
local aVal=itemsSortHelper.sort(a,sortRule)
local bVal=itemsSortHelper.sort(b,sortRule)
if sortOrder==ITEM_SORT_COMPARE_TYPE.eUpOrder then
return aVal>bVal
else
return aVal<bVal
end
end)

if showEquiped then

if pos then
local equipedItem=xingChenBagModel.equipsLookup[pos]
if equipedItem then
table.insert(sortList,1,equipedItem)
end
else
for i,v in pairs(xingChenBagModel.equipsLookup)do
table.insert(sortList,1,v)
end
end
end

return sortList
end


function xingChenHelper.getFixedAttr(itemid,lv)
if not xingChenBagModel.attrLookup then
xingChenBagModel.attrLookup={}
end
if not xingChenBagModel.attrLookup[itemid]then
xingChenBagModel.attrLookup[itemid]={}
end

if xingChenBagModel.attrLookup[itemid][lv]then
return xingChenBagModel.attrLookup[itemid][lv]
else
local config=itemsConfig.getConfig(itemid)
local lv_Attr={}
local lv_attrs=config.lv_attrs or defaultT
for i,v in ipairs(lv_attrs)do
if lv>=v[1]and lv<=v[2]then
lv_Attr=xingChenHelper.concatList(v[3],v[4],lv-v[1]+1)
break


end
end
local tuPoAttr=xingChenHelper.getTuPoAttr(itemid,lv)
local total=attrListHelper.concatList(lv_Attr,tuPoAttr)
if config.basic_attrs then
total=attrListHelper.concatList(total,config.basic_attrs)
end
xingChenBagModel.attrLookup[itemid][lv]=total
return total
end
end

function xingChenHelper.getTuPoAttr(itemid,lv)
local tupo_attrs=itemsConfig.getConfig(itemid).tupo_attrs
for i=#tupo_attrs,1,-1 do
local config=tupo_attrs[i]
if lv>=config[1]then
return config[2]
end
end
end

function xingChenHelper.concatList(list1,list2,Magnitude)
local temp={}
local insert=function(list,num)
for _,v1 in ipairs(temp)do
if v1[1]==list[1]then
v1[2]=v1[2]+list[2]*num
return
end
end
temp[#temp+1]={list[1],list[2]*num}
end

if list1 then
for _,v in pairs(list1)do
insert(v,1)
end
end

if list2 then
for _,v in pairs(list2)do
insert(v,Magnitude)
end
end
return temp
end


function xingChenHelper.getAllFixedAttr()
local posData=xingChenBagModel:getPosData()
local list={}
for idx,item in pairs(posData)do
local lv=xingChenBagModel:getOrbitLevel(idx)
local attrList=xingChenHelper.getFixedAttr(item.itemid,lv)
list=attrListHelper.concatList(list,attrList)
local starAttr=xingChenHelper.getStarAttr(item.itemid,xingChenHelper.getStarLevel(item))
list=attrListHelper.concatList(list,starAttr)
end

return list
end



local showWindowGrowAttr={[xingChenGrowEffectChangeType.eXiuShiAddLimit]=1,[xingChenGrowEffectChangeType.eXiuShiAddAddRate]=1}
function xingChenHelper.getAllGrowAttrInWindow()
local posData=xingChenBagModel:getPosData()
local list={}
for _,item in pairs(posData)do
local starGrow=xingChenHelper.getStarGrowAttr(item.itemid,xingChenHelper.getStarLevel(item))
for _,v in ipairs(starGrow)do
if showWindowGrowAttr[v[1]]then
list[v[1]]=(list[v[1]]or 0)+v[2]
end
end
end
local temp={}
for k,v in pairs(list)do
temp[#temp+1]={k,v}
end
return temp
end


function xingChenHelper.getAllStarAttr_Lookup()
local posData=xingChenBagModel:getPosData()
local lookup={}
for idx,item in pairs(posData)do
local lv=xingChenBagModel:getOrbitLevel(idx)
local attrList=xingChenHelper.getFixedAttr(item.itemid,lv)
lookup=attrListHelper.concatLookup(lookup,attrListHelper.tramsformToLookup(attrList))

local starAttr=xingChenHelper.getStarAttr(item.itemid,xingChenHelper.getStarLevel(item))
lookup=attrListHelper.concatLookup(lookup,attrListHelper.tramsformToLookup(starAttr))
end

return lookup
end

function xingChenHelper.getAllAffixAttr_Lookup()
return xingChenCiZhuiEffectController:getEquippedXingChenGrowVal(xingChenGrowEffectChangeType.eDiziAttrInLittleWorld)
end


function xingChenHelper.getStarAttr(itemid,starlv)
if not xingChenBagModel.attrStarLookup then
xingChenBagModel.attrStarLookup={}
end
if not xingChenBagModel.attrStarLookup[itemid]then
xingChenBagModel.attrStarLookup[itemid]={}
end

if xingChenBagModel.attrStarLookup[itemid][starlv]then
return xingChenBagModel.attrStarLookup[itemid][starlv]
else
local config=itemsConfig.getConfig(itemid)
local star_attrs=config.star_attrs or defaultT
if star_attrs[starlv]then
xingChenBagModel.attrStarLookup[itemid][starlv]=star_attrs[starlv][2]
return star_attrs[starlv][2]
else
return defaultT
end
end
end


function xingChenHelper.getStarGrowAttr(itemid,starlv)
local config=itemsConfig.getConfig(itemid)
local star_attrs=config.star_attrs or defaultT
if star_attrs[starlv]then
return star_attrs[starlv][3]or defaultT
else
return defaultT
end
end

function xingChenHelper.getXingChenAttr()
return xingChenHelper.getAllStarAttr_Lookup()
end

function xingChenHelper.getStarZhenXiId(itemid,starlv)
if not xingChenBagModel.attrStarZhenXiLookup then
xingChenBagModel.attrStarZhenXiLookup={}
end
if not xingChenBagModel.attrStarZhenXiLookup[itemid]then
xingChenBagModel.attrStarZhenXiLookup[itemid]={}
end
if xingChenBagModel.attrStarZhenXiLookup[itemid][starlv]then
return xingChenBagModel.attrStarZhenXiLookup[itemid][starlv]
else
local config=itemsConfig.getConfig(itemid)
local star_attrs=config.star_attrs or defaultT
if star_attrs[starlv]then
xingChenBagModel.attrStarZhenXiLookup[itemid][starlv]=star_attrs[starlv][1]
return xingChenBagModel.attrStarZhenXiLookup[itemid][starlv]
end
end
end

function xingChenHelper.getStarZhenXiPriorities(id)
return cfgHelper.get(cfg_starsrareconfig_get,id,"prio")
end

function xingChenHelper.getStarLevel(item)
return item.itemData.star or 0
end

function xingChenHelper.getStarLevelByGuid(guid)
local item=itemsModel.getItem(guid)
return item and item.itemData.star or 0
end


function xingChenHelper.getStarStage(starLevel)
if starLevel==0 then
return 1
end
return cfgHelper.get(cfg_starsstarconfig_get,starLevel,"show_quality")
end

local star3AB="ui/windows/xianjiebuilding/littleworld/littleworld3_atlas_pak.ab"
local function _getStarIconAndEffect(starLevel)
if not starLevel or starLevel<0 then
return nil,star3AB,0
end

local icon=cfgHelper.get(cfg_starsstarconfig_get,starLevel,"icon")
local effect=cfgHelper.get(cfg_starsstarconfig_get,starLevel,"effect")or 0

if not icon or icon==""then
local stage=xingChenHelper.getStarStage(starLevel)
icon="icon_stars_star_"..stage
end

return icon,star3AB,effect
end
local function _getStarSmallIconAndEffect(starLevel)
if not starLevel or starLevel<0 then
return nil,globalABLookup.globa4,nil,nil
end

local stage=xingChenHelper.getStarStage(starLevel)

local icon=cfgHelper.get(cfg_starsstarconfig_get,starLevel,"small_icon")
local aniName=cfgHelper.get(cfg_starsstarconfig_get,starLevel,"small_effect")
local aniAbName=cfgHelper.get(cfg_starsstarconfig_get,starLevel,"small_effect_ab")

if not icon or icon==""then
icon="icon_stars_star_s_"..(stage or 0)
end


return icon,globalABLookup.globa4,aniName,aniAbName
end

function xingChenHelper.getStarImg(starLevel)
local icon=cfgHelper.get(cfg_starsstarconfig_get,starLevel,"icon")
if icon and icon~=""then
return icon,star3AB
end
return"icon_stars_star_"..xingChenHelper.getStarStage(starLevel),star3AB
end

function xingChenHelper.getStarImgByStage(stage)
local icon=cfgHelper.get(cfg_starsstarconfig_get,stage*5,"icon")
if icon and icon~=""then
return icon,star3AB
end
return"icon_stars_star_"..stage,star3AB
end

function xingChenHelper.getGrayStarImg()
return"icon_tydxingxing_2",globalABLookup.global
end

function xingChenHelper.getStarSmallImg(starLevel)
local icon=cfgHelper.get(cfg_starsstarconfig_get,starLevel,"small_icon")

if not icon or icon==""then
icon="icon_stars_star_s_"..(xingChenHelper.getStarStage(starLevel)or 0)
end

return icon,globalABLookup.globa4
end

function xingChenHelper.getStarSmallImgByStage(stage)
local icon=cfgHelper.get(cfg_starsstarconfig_get,stage*5,"small_icon")
if icon and icon~=""then
return icon,globalABLookup.globa4
end

return"icon_stars_star_s_"..stage,globalABLookup.globa4
end

function xingChenHelper.setStarFlag(starWidget,lv,small)
if not starWidget then
return
end


if small and lv==0 then
starWidget:SetChildActive(-1,false)
for i=0,4 do
starWidget:SetChildActive(i,false)
starWidget:SetChildActive(i+5,false)
starWidget:SetChildActive(i+10,false)
end
return
end

local cnt=xingChenHelper.getStarCnt(lv)
if lv==0 then
cnt=0
end
starWidget:SetChildActive(-1,true)

for i=0,4 do
starWidget:SetChildActive(i,false)
starWidget:SetChildActive(i+5,false)
starWidget:SetChildActive(i+10,false)
end

local stage=xingChenHelper.getStarStage(lv)

local img,ab
if small then
img,ab=xingChenHelper.getStarSmallImg(lv)
else
img,ab=xingChenHelper.getStarImg(lv)
end

local _,_,bigEffectId=_getStarIconAndEffect(lv)
bigEffectId=bigEffectId or 0

local _,_,smallAniName,smallAniAbName=_getStarSmallIconAndEffect(lv)

local curStage=stage or 0
local prevStage=curStage-1
local prevBigEffectId=0
local prevSmallAniName=nil
if prevStage>0 then
local prevLv=prevStage*5
prevBigEffectId=cfgHelper.get(cfg_starsstarconfig_get,prevLv,"effect")or 0
prevSmallAniName=cfgHelper.get(cfg_starsstarconfig_get,prevLv,"small_effect")
end


for i=0,4 do
local effIndex=i+10

if i+1<=cnt then

starWidget:SetChildCSImageSprite(i,ab,img)
starWidget:SetChildActive(i,true)

if not small then
if bigEffectId>0 then
starWidget:SetChildActive(effIndex,true)
starWidget:SetChildShowEffect(effIndex,bigEffectId,true)
end
else
if smallAniName and smallAniName~=""then
starWidget:SetChildActive(effIndex,true)
starWidget:SetChildAnimationStringID(effIndex,smallAniName,false)
end
end
else

if not small then
if prevBigEffectId>0 then
starWidget:SetChildActive(effIndex,true)
starWidget:SetChildShowEffect(effIndex,prevBigEffectId,true)
end
else
if prevSmallAniName and prevSmallAniName~=""then
starWidget:SetChildActive(effIndex,true)
starWidget:SetChildAnimationStringID(effIndex,prevSmallAniName,false)
end
end
end
end


if small and lv<=5 then

return
end

stage=math.max(0,stage-1)

local backImg,backAb
if small then
backImg,backAb=xingChenHelper.getStarSmallImgByStage(stage)
else
backImg,backAb=xingChenHelper.getStarImgByStage(stage)
end

for i=0,4 do
local needShowBack=true
if lv>5 and i+1<=cnt then
needShowBack=false
end

if needShowBack then
starWidget:SetChildActive(i+5,true)
if stage>0 then
starWidget:SetChildCSImageSprite(i+5,backAb,backImg)
else
local grayIcon,grayAb=xingChenHelper.getGrayStarImg()
starWidget:SetChildCSImageSprite(i+5,grayAb,grayIcon)
end
end
end
end





function xingChenHelper.getStarCnt(starLevel)
if starLevel==0 then
return 1
end
return cfgHelper.get(cfg_starsstarconfig_get,starLevel,"show_star_cnt")
end


function xingChenHelper.updateStarZhenXiId(item)

if item.itemData.star then
local star_zhenxi=xingChenHelper.getStarZhenXiId(item.itemid,item.itemData.star)or 0
if star_zhenxi>0 then
if item.itemData.rare_id>0 then
local prio1=xingChenHelper.getStarZhenXiPriorities(star_zhenxi)
local prio2=xingChenHelper.getStarZhenXiPriorities(item.itemData.rare_id)
if prio1>=prio2 then
item.itemData.fin_rare_id=star_zhenxi
else
item.itemData.fin_rare_id=item.itemData.rare_id
end
else
item.itemData.fin_rare_id=star_zhenxi
end
else
item.itemData.fin_rare_id=item.itemData.rare_id
end
else
item.itemData.fin_rare_id=item.itemData.rare_id
end
end

function xingChenHelper.getAllZhenXi()
local posData=xingChenBagModel:getPosData()
local list={}
for idx,item in pairs(posData)do
if item.itemData.fin_rare_id~=0 then
table.insert(list,item.itemData.fin_rare_id)
end
end

return list
end

local _cacheFilter={}
function xingChenHelper.isSlotCanEquip(pos)
if xingChenBagModel:getEquipDataByPos(pos)then
return false
end
table.clear(_cacheFilter)
_cacheFilter[ITEM_FILTER_TYPE.eItemType1]=pos
return bagControl.hasBagItems(BAG_TYPE.eXingChen,_cacheFilter)
end

function xingChenHelper.isHaveSlotCanEquip()
if not xingChenHelper.isXingChenOpen()then
return
end
for pos=1,4 do
if xingChenHelper.isSlotCanEquip(pos)then
return true
end
end
return false
end

function xingChenHelper.isXingChenOpen()



return systemModel.isOpen(SYSTEM_DEFINE.eSmallWorldXC)
end

function xingChenHelper.getXingChenName(equip)



return itemsConfig.getItemName(equip.itemid)

end




function xingChenHelper.getAllZhenXiNum(color,israre)
local posData=xingChenBagModel:getPosData()
local num=0
for idx,item in pairs(posData)do
local config=itemsConfig.getConfig(item.itemid)
local itemcolor=config.color
if israre~=0 then
if israre==1 and item.itemData.fin_rare_id~=0 and itemcolor>=color then
num=num+1
elseif israre==2 and item.itemData.fin_rare_id==0 and itemcolor>=color then
num=num+1
end
else
if itemcolor>=color then
num=num+1
end
end
end
return num
end




function xingChenHelper.getXingGuiWear(type,israre)
local posData=xingChenBagModel:getPosData()
local num=0
if not posData[type]then
return num
end
local item=posData[type]
if israre~=0 then
if israre==1 and item.itemData.fin_rare_id~=0 then
num=1
elseif israre==2 and item.itemData.fin_rare_id==0 then
num=1
end
else
num=1
end
return num
end



function xingChenHelper.getXingGuiWearCiZhui(idlist)
local allaffix=xingChenHelper.getAllAffix()
for k,v in ipairs(allaffix)do
for a,b in ipairs(idlist)do
if v==b then
return 1
end
end
end
return 0
end




function xingChenHelper.getXingGuitoLv(id,lv)
local poslv=xingChenBagModel:getOrbitLevel(id)
return poslv>=tonumber(lv)and 1 or 0
end

function xingChenHelper:getNewAffixLv(cnt)
if not self.newAffixLv then
local list={}
local cfg=cfg_starsstarconfig()
for i,v in ipairs(cfg)do
if not list[v.affix_cnt]then
list[v.affix_cnt]=v.id
end
end
self.newAffixLv=list
return list[cnt]
else
return self.newAffixLv[cnt]
end
end