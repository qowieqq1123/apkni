







gubaoLookup={}

gubaoColorFrame={
[2]=1,
[3]=2,
[4]=3,
[5]=4,
[6]=5,

getName=function(self_,v)
return'image_gubaoys_'..self_[v]
end
}
eQualityColorName_GB={
[eQualityColor.eWhite]='白色',
[eQualityColor.eGreen]='绿色',
[eQualityColor.eBlue]='蓝色',
[eQualityColor.ePurple]='紫色',
[eQualityColor.eOrange]='橙色',
[eQualityColor.eRed]='红色',
[eQualityColor.ePink]='混沌',
}

local table_insert=table.insert
local table_sort=table.sort

local color_lookup=nil
local race_lookup=nil
local suit_lookup=nil
local suit_num_lookup=nil
local effect_lookup=nil
local active_gb_lookup=nil
local gb_active_lookup=nil
local piece_gb_lookup=nil
local gb_piece_lookup=nil

local colorCommonPieceLookup=nil
local colorCollectLookup=nil
local colorChangePieceLookup=nil

function gubaoLookup:initLookup()
if color_lookup==nil then
color_lookup={}
race_lookup={}
suit_lookup={}
suit_num_lookup={}
effect_lookup={}
active_gb_lookup={}
gb_active_lookup={}
piece_gb_lookup={}
gb_piece_lookup={}
colorCommonPieceLookup={}
colorCollectLookup={}
colorChangePieceLookup={}

local configs=cfg_gubaoconfig()
for k,v in pairs(configs)do

local color=v.color
if color_lookup[color]==nil then color_lookup[color]={}end
color_lookup[color][v.id]=true

local race=v.race
if race_lookup[race]==nil then race_lookup[race]={}end
race_lookup[race][v.id]=true

for i1,v1 in ipairs(v.effectTypes)do
if effect_lookup[v1]==nil then effect_lookup[v1]={}end
effect_lookup[v1][v.id]=true
end

for i2,v2 in pairs(v.active)do
local item=itemsConfig.getConfig(i2)





if item.piece~=nil then
active_gb_lookup[i2]=v.id
gb_active_lookup[v.id]=i2
else
piece_gb_lookup[i2]=v.id
gb_piece_lookup[v.id]=i2
end
end
end

local suitCfgs=cfg_gubaosuitconfig()
for i,v in ipairs(suitCfgs)do
local c=#v.list
if suit_num_lookup[c]==nil then suit_num_lookup[c]={}end
for i1,v1 in ipairs(v.list)do
if suit_lookup[v1]==nil then suit_lookup[v1]={}end
table.insert(suit_lookup[v1],v.id)
suit_num_lookup[c][v1]=true
end
end

local commonPieceItem=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'commonPieceItem')
if commonPieceItem then
for i,itemid in ipairs(commonPieceItem)do
local cfg=itemsConfig.getConfig(itemid)
local color=cfg.color
colorCommonPieceLookup[color]=itemid
end
end

local changePieceItem=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'changePieceItem')
if changePieceItem then
for i,itemid in ipairs(changePieceItem)do
local cfg=itemsConfig.getConfig(itemid)
local changeCfg=cfg and cfg.change_conf or nil
if changeCfg and next(changeCfg)then
for color,v in pairs(changeCfg)do
if v==1 then
if not colorChangePieceLookup[color]then
colorChangePieceLookup[color]={}
end
local list=colorChangePieceLookup[color]
list[#list+1]=itemid
end
end
end
end
end

local collectcfgs=cfg_gubaocollectconfig()
for color,v in pairs(collectcfgs)do
local lp=colorCollectLookup[color]
if lp==nil then
lp={}
colorCollectLookup[color]=lp
end
for k2,cfg in pairs(v)do
local d={cfg=cfg}
d.color=color
d.num=cfg.num
table.insert(lp,d)
end
end
for k,v in pairs(colorCollectLookup)do
if#v>1 then
table.sort(v,function(a,b)
return a.num<b.num
end)
end
for i2,d in ipairs(v)do
local last_d=v[i2-1]
gubaoLookup:handleColorCollectInfo(d,last_d)
end
end
end
end

function gubaoLookup:changeColorCollectAttr(d)
local attr={}
local bonus={}
if d~=nil then
if d.cfg.attr then
for i3,v3 in ipairs(d.cfg.attr)do
attr[v3[1]]=v3[2]
end
end
if d.cfg.bonus then
for k3,v3 in pairs(d.cfg.bonus)do
bonus[k3]=v3
end
end
end
return attr,bonus
end

function gubaoLookup:handleColorCollectInfo(d,last_d)
local attr,bonus
if last_d==nil then
attr,bonus=gubaoLookup:changeColorCollectAttr(d)
else
attr={}
bonus={}
local cur_attr,cur_bonus=gubaoLookup:changeColorCollectAttr(d)
local old_attr,old_bonus=gubaoLookup:changeColorCollectAttr(last_d)
for k,v in pairs(cur_attr)do
local last_v=old_attr[k]
if last_v==nil then
attr[k]=v
else
local lerp=v-last_v
if lerp>0 then
attr[k]=lerp
end
end
end
for k,v in pairs(cur_bonus)do
local last_v=old_bonus[k]
if last_v==nil then
bonus[k]=v
else
local lerp=v-last_v
if lerp>0 then
bonus[k]=lerp
end
end
end
end
d.attr=attr
d.bonus=bonus
end

function gubaoLookup:clearLookup()
color_lookup=nil
race_lookup=nil
suit_lookup=nil
suit_num_lookup=nil
effect_lookup=nil
active_gb_lookup=nil
gb_active_lookup=nil
piece_gb_lookup=nil
gb_piece_lookup=nil
colorCommonPieceLookup=nil
colorChangePieceLookup=nil
end

function gubaoLookup:checkColor(color,gbid)
if color_lookup[color]~=nil then
return color_lookup[color][gbid]~=nil
end
return false
end

function gubaoLookup:checkRace(race,gbid)
if race_lookup[race]~=nil then
return race_lookup[race][gbid]~=nil
end
return false
end


function gubaoLookup:getSuitList(gbid)
return suit_lookup[gbid]
end

function gubaoLookup:checkHasSuit(gbid)
local suitlist=gubaoLookup:getSuitList(gbid)
if suitlist==nil or#suitlist<=0 then
return false
end
return true
end

function gubaoLookup:checkSuitNum(suitnum,gbid)
if suit_num_lookup[suitnum]~=nil then
return suit_num_lookup[suitnum][gbid]~=nil
end
return false
end

function gubaoLookup:checkEffect(effectid,gbid)
if effect_lookup[effectid]~=nil then
return effect_lookup[effectid][gbid]~=nil
end
return false
end

function gubaoLookup:checkEnoughActiveGood(gbid)
local itemid=gb_active_lookup[gbid]
if itemid then
local c=bagModel.getItemCountById(itemid)
local need=cfg_gubaoconfig_get(gbid).active[itemid]
return c>=need
end
return false
end

function gubaoLookup:checkEnoughPieceGood(gbid)
local itemid=gb_piece_lookup[gbid]
if itemid then
local c=bagModel.getItemCountById(itemid)
local need=cfg_gubaoconfig_get(gbid).active[itemid]
return c>=need
end
return false
end


function gubaoLookup:checkEnoughPieceGoodWithChangePiece(gbid)
local itemid=gb_piece_lookup[gbid]
local glid,main=liandonModel:CheckGB_Guanlian(gbid)
if glid then

if gubaoModel:checkActive_OrGLgubao(gbid)then
return false
end
end
if itemid then
local c=bagModel.getItemCountById(itemid)
local need=cfg_gubaoconfig_get(gbid).active[itemid]
if c>=need then
return true
end
local deltaNum=need-c
local color=itemsConfig.getItemColor(itemid)
local changePieceItemList=gubaoLookup:getChangePieceItemListByColor(color)or{}
for _,changePieceItemId in ipairs(changePieceItemList)do
local num=bagModel.getItemCountById(changePieceItemId)
deltaNum=deltaNum-num
if deltaNum<=0 then
return true
end
end
end
return false
end

function gubaoLookup:checkNeedChangePieceNum(gbid)
local itemid=gb_piece_lookup[gbid]
if itemid then
local c=bagModel.getItemCountById(itemid)
local need=cfg_gubaoconfig_get(gbid).active[itemid]
local needChangePieceNum=need-c
return needChangePieceNum
end
return 0
end

function gubaoLookup:getChangePieceItemListByColor(color)
local itemList=colorChangePieceLookup[color]
return itemList
end

function gubaoLookup:checkEnoughActive(gbid)
return gubaoLookup:checkEnoughActiveGood(gbid)or gubaoLookup:checkEnoughPieceGood(gbid)
end


function gubaoLookup:good2GuBao(itemid)
return active_gb_lookup[itemid]or piece_gb_lookup[itemid]
end
function gubaoLookup:good2GuBaoActive(itemid)
return active_gb_lookup[itemid]
end
function gubaoLookup:good2GuBaoPiece(itemid)
return piece_gb_lookup[itemid]
end


function gubaoLookup:gubao2GoodActive(gbid)
return gb_active_lookup[gbid]
end


function gubaoLookup:gubao2GoodPiece(gbid)
return gb_piece_lookup[gbid]
end

function gubaoLookup:getColorCommonPiece(color)
return colorCommonPieceLookup[color]
end

function gubaoLookup:getAllColorCommonPiece()
return colorCommonPieceLookup
end

function gubaoLookup:getColorCollectList(color)
return colorCollectLookup[color]
end

function gubaoLookup:getColorCollectCfg(color,num)
local list=gubaoLookup:getColorCollectList(color)
local d,idx
if list then
for i,v in ipairs(list)do
if num>=v.num then
idx=i
d=v
end
end
end
return d,idx
end

function gubaoLookup:getAllList()
local result={}
local configs=cfg_gubaoconfig()
for k,cfg in pairs(configs)do
if cfg.id~=nil then
result[#result+1]=cfg
end
end
return result
end

function gubaoLookup:getSortList(allcfgs,sortType,sortCondition,sortOrder,checkHide)
local result={}
local t_temp={}
local markLook={}
local temp={}
local tempLook={}
for i,cfg in ipairs(allcfgs)do
local gbid=cfg.id
local suitlist=gubaoLookup:getSuitList(gbid)
local add=true
local mark=true
if sortCondition~=nil then

if sortCondition[1]~=nil and#sortCondition[1]>0 then
local addx=false
for i1,v1 in ipairs(sortCondition[1])do
if v1==1 then

if gubaoModel:checkActive(gbid)then
addx=true
break
end
else

if not gubaoModel:checkActive(gbid)then
addx=true
break
end
end
end
if not addx then
if gubaoModel:checkCanActive(gbid)then

local glid,main=liandonModel:CheckGB_Guanlian(gbid)
if glid then

if gubaoModel:checkCanActive(glid)then

if main==1 then
addx=true
end
else

addx=true
end
else

addx=true
end
end
end
add=add and addx
end

if sortCondition[2]~=nil and#sortCondition[2]>0 then
local addx=false
for i1,v1 in ipairs(sortCondition[2])do
if gubaoLookup:checkColor(v1,gbid)then
addx=true
break
end
end
add=add and addx
mark=mark and addx
end

if sortCondition[3]~=nil and#sortCondition[3]>0 then
local addx=false
for i1,v1 in ipairs(sortCondition[3])do
if gubaoLookup:checkSuitNum(v1,gbid)then
addx=true
break
end
end
add=add and addx
mark=mark and addx
end

if sortCondition[4]~=nil and#sortCondition[4]>0 then
local addx=false
for i1,v1 in ipairs(sortCondition[4])do
if gubaoLookup:checkEffect(v1,gbid)then
addx=true
break
end
end
add=add and addx
mark=mark and addx
end

if sortCondition[5]~=nil and#sortCondition[5]>0 then
local addx=false
for i1,v1 in ipairs(sortCondition[5])do
if v1==1 then

if gubaoModel:checkCanUpStar(gbid)or gubaoModel:checkCanAwake(gbid)then
addx=true
break
end
else

if gubaoModel:checkCanLianHua(gbid)then
addx=true
break
end
end
end

add=add and addx
mark=mark and addx
end
end

if checkHide==true then
local addx=true
if cfg.isHide==true then
if not gubaoModel:checkActive(gbid)and not gubaoLookup:checkEnoughActive(gbid)then
addx=false
end
end
add=add and addx
end

if cfg.isShieldShow then
add=false
end
if add then
t_temp[#t_temp+1]=cfg
end
if mark then
markLook[gbid]=cfg
end
end

for i,cfg in ipairs(t_temp)do
local gbid=cfg.id
temp[#temp+1]=cfg
tempLook[gbid]=cfg
if sortType==2 then

local suitlist=gubaoLookup:getSuitList(gbid)
if suitlist~=nil and#suitlist>0 then
for gbid1,suitid in ipairs(suitlist)do
local gblist=cfgHelper.get(cfg_gubaosuitconfig_get,suitid,'list')
for i,gbid2 in ipairs(gblist)do
if markLook[gbid2]~=nil and tempLook[gbid2]==nil then
temp[#temp+1]=markLook[gbid2]
tempLook[gbid2]=markLook[gbid2]
end
end
end
end
end
end
if#temp>0 then
if sortType~=nil then
sortOrder=sortOrder
if sortOrder==nil then sortOrder=eSortOrder.eDown end
if sortType==1 then

local colorlookup=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'colorNames')
local colorlist={}
for i,v in pairsBySortKey(colorlookup)do
table.insert(colorlist,i)
end
if sortOrder==eSortOrder.eDown then
table.sort(colorlist,function(a,b)
return a>b
end)
end
for i,v in ipairs(colorlist)do
local color=v
local d={}
d.typo=color
local childlist={}
d.childlist=childlist
for i2,v2 in ipairs(temp)do
local gbid=v2.id
if gubaoLookup:checkColor(color,gbid)then
table_insert(childlist,v2)
end
end
local cc=#childlist
if cc>1 then
table_sort(childlist,function(a,b)
local va=a.id
local vb=b.id
return gubaoLookup:commonSort(va,vb,a,b,eSortOrder.eDown)
end)
end
if cc>0 then table_insert(result,d)end
end
elseif sortType==2 then

local suitCfgs=cfg_gubaosuitconfig()
for i,v in ipairs(suitCfgs)do
local suitid=v.id
local d={}
d.typo=suitid
local childlist={}
d.childlist=childlist
for i2,v2 in ipairs(v.list)do
local gbid=v2
local cfg=tempLook[gbid]
if cfg~=nil then
table_insert(childlist,cfg)
end
end
local cc=#childlist
if cc>1 then
table_sort(childlist,function(a,b)
local va=a.id
local vb=b.id
return gubaoLookup:commonSort(va,vb,a,b,sortOrder)
end)
end
if cc>0 then table_insert(result,d)end
end

local d={}
d.typo=-1
local childlist={}
d.childlist=childlist
for k,v in pairs(tempLook)do
if not gubaoLookup:checkHasSuit(k)then
table_insert(childlist,v)
end
end
local cc=#childlist
if cc>1 then
table_sort(childlist,function(a,b)
local va=a.id
local vb=b.id
return gubaoLookup:commonSort(va,vb,a,b,sortOrder)
end)
end
if cc>0 then table_insert(result,d)end
else

local raceCfgs=cfg_discipleraceconfig()
for i,v in ipairs(raceCfgs)do
local race=v.id
local d={}
d.typo=race
local childlist={}
d.childlist=childlist
for i2,v2 in ipairs(temp)do
local gbid=v2.id
if gubaoLookup:checkRace(race,gbid)then
table_insert(childlist,v2)
end
end
local cc=#childlist
if cc>1 then
table_sort(childlist,function(a,b)
local va=a.color
local vb=b.color
return gubaoLookup:commonSort(va,vb,a,b,sortOrder)
end)
end
if cc>0 then table_insert(result,d)end
end
end
else
return temp
end
end
return result
end

function gubaoLookup:findAcitveInSuitList(suitlist)
if suitlist==nil or#suitlist<=0 then return nil end
for gbid,suitid in ipairs(suitlist)do
local found=gubaoLookup:findAcitveInSuit(suitid)
if found~=nil then return found end
end
return nil
end

function gubaoLookup:findAcitveInSuit(suitid)
local gblist=cfgHelper.get(cfg_gubaosuitconfig_get,suitid,'list')
for i,gbid in ipairs(gblist)do
if gubaoModel:checkActive(gbid)then
return gbid
end
end
return nil
end

function gubaoLookup:findNotAcitveInSuitList(suitlist)
if suitlist==nil or#suitlist<=0 then return nil end
for gbid,suitid in ipairs(suitlist)do
local found=gubaoLookup:findNotAcitveInSuit(suitid)
if found~=nil then return found end
end
return nil
end

function gubaoLookup:findNotAcitveInSuit(suitid)
local gblist=cfgHelper.get(cfg_gubaosuitconfig_get,suitid,'list')
for i,gbid in ipairs(gblist)do
if not gubaoModel:checkActive(gbid)then
return gbid
end
end
return nil
end

function gubaoLookup:commonSort(va,vb,a,b,sortOrder)
local acan=gubaoModel:checkCanActive(a.id)==true and 1 or 0
local bcan=gubaoModel:checkCanActive(b.id)==true and 1 or 0
if acan==bcan then
local aactive=gubaoModel:checkActive(a.id)==true and 1 or 0
local bactive=gubaoModel:checkActive(b.id)==true and 1 or 0
if aactive==bactive then
local a_isspe=gubaoModel:isSpecialEx(a)==true and 0 or 1
local b_isspe=gubaoModel:isSpecialEx(b)==true and 0 or 1
if a_isspe==b_isspe then
return helper.sortOrderComparis(va,vb,sortOrder)
else
return a_isspe>b_isspe
end
else
return aactive>bactive
end
else
return acan>bcan
end
end

function gubaoLookup:getConditonFilter(sortCondition)
local c=1
local filterName={}
local filterFlag={}
filterName[c]={}
filterName[c][1]='状态'
filterName[c][2]={}
filterFlag[c]={}
local statelist={'已激活','未激活'}
for i,v in ipairs(statelist)do
table.insert(filterName[c][2],{name=v,typeid=i})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
c=c+1
filterName[c]={}
filterName[c][1]='品质'
filterName[c][2]={}
filterFlag[c]={}
local colorlist=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'colorNames')
for i,v in pairsBySortKey(colorlist)do
table.insert(filterName[c][2],{name=eQualityColorName_GB[i],typeid=i})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
c=c+1
filterName[c]={}
filterName[c][1]='套装'
filterName[c][2]={}
filterFlag[c]={}
local suitlist={[2]='2件套',[3]='3件套',[4]='4件套',[5]='5件套'}
for i,v in pairsBySortKey(suitlist)do
table.insert(filterName[c][2],{name=v,typeid=i})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
c=c+1
filterName[c]={}
filterName[c][1]='增益'
filterName[c][2]={}
filterFlag[c]={}
local effectlist=cfg_gubaoeffecttypeconfig()
for i,v in ipairs(effectlist)do
table.insert(filterName[c][2],{name=v.name,typeid=v.id})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,v.id)
table.insert(filterFlag[c],flag)
end
c=c+1
filterName[c]={}
filterName[c][1]='强化'
filterName[c][2]={}
filterFlag[c]={}
local statelist={'可升星','可炼化'}
for i,v in ipairs(statelist)do
table.insert(filterName[c][2],{name=v,typeid=i})
local flag=discipleLookup.getFilterFlagByCondition(sortCondition,c,i)
table.insert(filterFlag[c],flag)
end
return filterName,filterFlag
end

function gubaoLookup:getGoodsSortList()
local result={}
local baglist=bagControl.invokeFuncByBagType(BAG_TYPE.eGubaoBag,'getBagItems')
if baglist~=nil and#baglist>0 then
local temp={}
temp[1]={}
temp[2]={}
temp[3]={}
temp[4]={}
temp[5]={}
for i,v in ipairs(baglist)do
local itemid=v.itemid
local gbid=gubaoLookup:good2GuBao(itemid)
if gbid then
local active=gubaoModel:checkActive_OrGLgubao(gbid)
if active then
table_insert(temp[3],v)
else
if gubaoLookup:good2GuBaoActive(itemid)~=nil then
if gubaoLookup:checkEnoughActiveGood(gbid)then
table_insert(temp[1],v)
else
table_insert(temp[2],v)
end
elseif gubaoLookup:good2GuBaoPiece(itemid)~=nil then
if gubaoLookup:checkEnoughPieceGood(gbid)then
table_insert(temp[1],v)
else
table_insert(temp[2],v)
end
end
end
else
local cfg=itemsConfig.getConfig(itemid)
local changeCfg=cfg.change_conf
if changeCfg then
table_insert(temp[5],v)
else
table_insert(temp[4],v)
end
end
end
for i,v in ipairs(temp)do
if#v>0 then
local d={}
d.typo=i
d.childlist=v

table_sort(d.childlist,function(a,b)
local acfg=itemsHelper:get_gubao_config(a.itemid)
local bcfg=itemsHelper:get_gubao_config(b.itemid)
return acfg.color>bcfg.color
end)
table_insert(result,d)
end
end
end
return result
end


function gubaoLookup:getGoodsSortList2(sortCondition1,sortCondition1Type,sortCondition2)
local elementlist
if sortCondition2>1 then
elementlist=ELEMENT_TYPE:getFive()
end
local result={}
local temp1=bagControl.invokeFuncByBagType(BAG_TYPE.eItemBag,'getBagItems')or{}
local temp2=bagControl.invokeFuncByBagType(BAG_TYPE.eMaterialsBag,'getBagItems')or{}
local baglist=table.concatTable(temp1,temp2)
if baglist~=nil and#baglist>0 then
for i,v in ipairs(baglist)do
local itemid=v.itemid
local cfg=itemsConfig.getConfig(itemid)
if cfg.gubaolianhua~=nil then
local checkIsItem=itemsConfig.isItem(itemid)
local add=true
local addx=true
if sortCondition1>1 then

addx=false
if not checkIsItem then
if sortCondition1Type==1 then
if cfg.stage<=sortCondition1-1 then
addx=true
end
elseif sortCondition1Type==2 then
if cfg.stage==sortCondition1-1 then
addx=true
end
end
end
add=add and addx
else

if sortCondition1Type==1 then
addx=false
if checkIsItem then
addx=true
end
add=add and addx
end
end
if sortCondition2>1 then
addx=false

if not checkIsItem then
local ele=elementlist[sortCondition2-1]
if cfg.element==ele then
addx=true
end
else
addx=true
end
add=add and addx
end
if add then
local d={}
d.item=v
d.stage=cfg.stage
d.checkIsItem=checkIsItem==true and 1 or 0
d.color=cfg.color
table_insert(result,d)
end
end
end
if#result>1 then
table_sort(result,function(a,b)
if a.checkIsItem==b.checkIsItem then
if a.checkIsItem==1 then
return a.color<b.color
else
return a.stage<b.stage
end
else
return a.checkIsItem>b.checkIsItem
end
end)
end
end
return result
end

function gubaoLookup:setGoodsSortList3Dirty()
self.goodsSortList3Dirty=true
end


function gubaoLookup:getGoodsSortList3(lockcolor)

if self.goodsSortList3==nil or
self.goodsSortList3[lockcolor]==nil or
self.goodsSortList3Dirty then

self.goodsSortList3Dirty=false



local result={}
result[lockcolor]={}
local baglist=bagControl.invokeFuncByBagType(BAG_TYPE.eGubaoBag,'getBagItems')
if baglist~=nil and#baglist>0 then
local allColorTable=gubaoLookup:getAllColorCommonPiece()
for i,v in ipairs(baglist)do
local itemid=v.itemid
local tempgbid=gubaoLookup:good2GuBaoPiece(itemid)

if tempgbid~=nil then
local cfg=itemsConfig.getConfig(itemid)
local color=cfg.color
if gubaoModel:checkFullUpStar(tempgbid)then
if result[color]==nil then result[color]={}end
local d={}
d.item=v
d.stage=cfg.stage or color
d.weight=d.stage
table_insert(result[color],d)
end
else

for color,common_itemid in pairs(allColorTable)do
if common_itemid==itemid then
if result[color]==nil then result[color]={}end
local cfg=itemsConfig.getConfig(itemid)
local d={}
d.item=v
d.stage=cfg.stage or cfg.color
d.weight=d.stage+100
table_insert(result[color],d)
break
end
end
end
end
for _,list in pairs(result)do
if#list>1 then
table_sort(list,function(a,b)
return a.weight>b.weight
end)
end
end
end
self.goodsSortList3=result
end
return self.goodsSortList3[lockcolor]
end


function gubaoLookup:getGoodsSortList4(lockcolor)
gubaoLookup:getGoodsSortList3(lockcolor)

local list={}
for i,v in pairs(self.goodsSortList3)do
if i>=lockcolor then
list=table.concatTable(list,v)
end
end
return list
end

function gubaoLookup:setlianhuaitemDirty(itemid)
local cfg=itemsConfig.getConfig(itemid)
if cfg.gubaolianhua then
self.hasgblianhuaitemDirty=true
end
end

function gubaoLookup:setlianhuaitemDirtyEx()
self.hasgblianhuaitemDirty=true
end

function gubaoLookup:hasAnyEnoughGoods()
if self.hasgblianhuaitem==nil or self.hasgblianhuaitemDirty==true then
self.hasgblianhuaitemDirty=false
local items=bagControl.getBagItems(BAG_TYPE.eItemBag)
self.hasgblianhuaitem=false
for _,v in ipairs(items)do
local cfg=itemsConfig.getConfig(v.itemid)
if cfg.gubaolianhua~=nil then
self.hasgblianhuaitem=true
break
end
end
end
return self.hasgblianhuaitem
end
