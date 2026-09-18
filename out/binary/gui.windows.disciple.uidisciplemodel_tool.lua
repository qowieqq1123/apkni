







local table_insert=table.insert
local table_sort=table.sort
local _LuaHelper=CS.LuaHelper


function UIDiscipleModel.sortAttrList(list)
table_sort(list,function(a,b)
local ac=cfgHelper.get1(cfg_attributesconfig_get,a[1])
local bc=cfgHelper.get1(cfg_attributesconfig_get,b[1])
if ac.sortId==bc.sortId then
return ac.id<bc.id
else
return ac.sortId>bc.sortId
end
end)
end

function UIDiscipleModel.calculationDiscipleImage(val_32,val_64)
local dd={}
dd.color=bit.band(val_32,0x0F)
dd.race=bit.band(bit.rshift(val_32,4),0xFF)
dd.sex=bit.band(bit.rshift(val_32,12),0x0F)
dd.job=bit.band(bit.rshift(val_32,16),0xFFFF)
local temp=val_64
local tyname=type(temp)
if tyname=='string'then
temp=int64.new(temp)
elseif tyname=='number'then
temp=mathHelper.number_to_int64(temp)
end
local temp1=_LuaHelper.SplitInt32(temp,"0x3FFFFFF",0)
local temp2=_LuaHelper.SplitInt32(temp,"0xFFFFFFFF",26)
dd.hair=bit.band(temp1,0xFFFF)
dd.face=bit.band(bit.rshift(temp1,16),0x3FF)
dd.body=bit.band(temp2,0xFFFF)
dd.accessory=bit.band(bit.rshift(temp2,16),0x3FF)
return dd
end

function UIDiscipleModel.image_int64_to_number(val_64)
local temp1=_LuaHelper.SplitInt32(val_64,"0x3FFFFFF",0)
local temp2=_LuaHelper.SplitInt32(val_64,"0xFFFFFFFF",26)
local str=_LuaHelper.ToInt64String(temp2,temp1)
return tonumber(str)
end

function UIDiscipleModel.calculationDiscipleImageBase(netData,switchidx)
switchidx=switchidx or 0
local discipledata
local discipleimage
local dressList
local xianmo_voc
if switchidx==0 then
discipledata=netData.discipledata
discipleimage=netData.discipleimage
dressList=netData.dressList
xianmo_voc=netData.xianmo_voc
else
local switchData=netData.switchList[switchidx]
discipledata=switchData.discipledata
discipleimage=switchData.discipleimage
dressList=switchData.dressList
xianmo_voc=switchData.xianmo_voc
end
local image=UIDiscipleModel.calculationDiscipleImage(discipledata,discipleimage)

local clothingId=nil
local clothingStar=nil
local clothing_equip=nil

if dressList then
clothing_equip=dressList[1]
end

if netData.discipleguid~=nil then
local isSelfDZHideDress=UIDiscipleModel:isMyDZHideDress(netData.discipleguid)
if isSelfDZHideDress==1 then
clothing_equip=nil
else
if clothing_equip==nil then
clothing_equip=ClothingModel:getEquipByDizi(netData.discipleguid,switchidx)
end
end
end

if clothing_equip then
clothingId=clothing_equip.itemid
clothingStar=ClothingModel:getStarLvByEquip(clothing_equip)
end

if not clothingId and netData.clothingId then
clothingId=netData.clothingId
end
if not clothingStar and netData.clothingStar then
clothingStar=netData.clothingStar
end



image.clothingId=netData.hidedress~=1 and clothingId or nil
image.clothingStar=netData.hidedress~=1 and clothingStar or nil
if netData.hidexianmodress~=1 and(xianmo_voc==1 or xianmo_voc==2)then
image.xianmo_voc=xianmo_voc
else
image.xianmo_voc=nil
end
return image
end

function UIDiscipleModel.calculationDiscipleImageEx(netData,switchidx)
local image=UIDiscipleModel.calculationDiscipleImageBase(netData,switchidx)

local color=UIDiscipleModel:getDiscipleBaseAttrSum2Color(netData,switchidx)
if color~=nil then
image.color=color
end
return image
end














function UIDiscipleModel.getDiscipleFightModelInfo(val_32,val_64,weaponImageID,scale,args)
local imageInfo=UIDiscipleModel.calculationDiscipleImage(val_32,val_64)
return UIDiscipleModel.getDiscipleFightModelInfoEx(imageInfo,weaponImageID,scale,args)
end

function UIDiscipleModel.getDiscipleFightModelInfoEx(image,weaponImageID,scale,args)
args=args or{}
local outSideImage={}

local bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,image.body)

if bodyCfg.out_tm and args.tmLv and bodyCfg.out_tm[args.tmLv]then
outSideImage.body=bodyCfg.out_tm[args.tmLv]
end


local xianmo_voc=args.xianmo_voc
if xianmo_voc then
if bodyCfg.xm_transfer and bodyCfg.xm_transfer[xianmo_voc]then
local index=1
if args.tmLv and args.tmLv>=#cfg_discipletianminglevelconfig()then
index=2
end
outSideImage.body=bodyCfg.xm_transfer[xianmo_voc][index]
end
end


local clothingStar=args.clothingStar or 0
if bodyCfg.clothing_map and bodyCfg.clothing_map[args.clothingId]then
local change=bodyCfg.clothing_map[args.clothingId]
local maxIndex=clothingStar>=ClothingConfig.getStarMaxLv(args.clothingId)and 2 or 1
bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,change[maxIndex])

outSideImage.body=bodyCfg.out_side
else
if bodyCfg.clothing_out_side and args.clothingId and bodyCfg.clothing_out_side[args.clothingId]then
local maxIndex=clothingStar>=(ClothingConfig.getStarMaxLv(args.clothingId)or 5)and 2 or 1
outSideImage.body=bodyCfg.clothing_out_side[args.clothingId][maxIndex]
end
end

if not outSideImage.body then
outSideImage.body=bodyCfg.out_side
end
local hideWeapon=cfgHelper.get2(cfg_dbbodyconfig_get,outSideImage.body,'hideWeapon')
outSideImage.hideWeapon=hideWeapon
outSideImage.scale=scale
outSideImage.size=transformHelper.bodySize(outSideImage.body,scale)

outSideImage.componets={}
if image.face>0 then

local comp=cfgHelper.get2(cfg_disciplefaceimageconfig_get,image.face,'out_side')
if comp then
for _,cmpID in ipairs(comp)do
table_insert(outSideImage.componets,cmpID)
end
end
end
if image.hair>0 then

local hairCfg=cfgHelper.get1(cfg_disciplehairimageconfig_get,image.hair)
if args.clothingId and args.clothingId>0 then
if hairCfg.clothing_out_side and hairCfg.clothing_out_side[args.clothingId]then
table_insert(outSideImage.componets,hairCfg.clothing_out_side[args.clothingId])
end
elseif xianmo_voc~=1 and xianmo_voc~=2 then
local comp=hairCfg.out_side
if comp then
for _,cmpID in ipairs(comp)do
table_insert(outSideImage.componets,cmpID)
end
end
end

end
if weaponImageID>0 and hideWeapon==nil then
table_insert(outSideImage.componets,cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponImageID,'out_side'))
end
return image,outSideImage
end