








function UIDiscipleModel:setDiscipleImageDirty(netData)
netData.imageDirty=true
dataControl.onDiscipleImageChange()
notifySystem:postNotify(notifyConfig.onDiscipleImageChange)
end


function UIDiscipleModel:setDiscipleImageDirtyX(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
UIDiscipleModel:setDiscipleImageDirty(netData)
end


function UIDiscipleModel:setDiscipleSwitchImageDirty(netData)
netData.switchImageDirty=true
dataControl.onDiscipleImageChange()
notifySystem:postNotify(notifyConfig.onDiscipleImageChange)
end


function UIDiscipleModel:setDiscipleSwitchImageDirtyX(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
UIDiscipleModel:setDiscipleSwitchImageDirty(netData)
end

function UIDiscipleModel:getDiscipleHideHress(guid)
local netData=UIDiscipleModel:getDiscipleData(guid)
return netData.hidedress or 0
end


function UIDiscipleModel:getDiscipleImageInfo(guid,switchidx)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleImageInfoEx(netData,switchidx)
end

function UIDiscipleModel:getDiscipleImageInfoEx(netData,switchidx)
switchidx=switchidx or 0
if netData~=nil then
if switchidx==0 then
if netData.imageInfo==nil or netData.imageDirty then

netData.imageInfo=UIDiscipleModel.calculationDiscipleImageEx(netData)
netData.imageDirty=false

end
return netData.imageInfo
else
if netData.switchImageInfo==nil then
netData.switchImageInfo={}
end
if netData.switchImageInfo[switchidx]==nil or netData.switchImageDirty then

netData.switchImageInfo[switchidx]=UIDiscipleModel.calculationDiscipleImageEx(netData,switchidx)
netData.switchImageDirty=false

end
return netData.switchImageInfo[switchidx]
end
end
return nil
end


function UIDiscipleModel:getDiscipleInsideModelInfo(guid,args,switchidx)
local netData=UIDiscipleModel:getDiscipleData(guid)
return UIDiscipleModel:getDiscipleInsideModelInfoEx(netData,args,switchidx)
end
function UIDiscipleModel:getDiscipleInsideModelInfoEx(netData,args,switchidx)
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(netData,switchidx)
return UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo,args)
end


function UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo,args)
args=args or{}
local result={}
if imageInfo.skeleton~=nil and imageInfo.skeleton>0 then
result.body=imageInfo.skeleton
else
if imageInfo.sex==SEX_TYPE.eMale then
result.body=1001
else
result.body=1002
end
end
result.componets={}
if imageInfo.hair>0 then

local hair=cfgHelper.get2(cfg_disciplehairimageconfig_get,imageInfo.hair,'in_side')
if hair~=nil then
for _,cmpID in ipairs(hair)do
table_insert(result.componets,cmpID)
end
end
end
if imageInfo.face>0 then

local face=cfgHelper.get2(cfg_disciplefaceimageconfig_get,imageInfo.face,'in_side')
if face~=nil then
for _,cmpID in ipairs(face)do
table_insert(result.componets,cmpID)
end
end
end
if imageInfo.body>0 then

local bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,imageInfo.body)

local showClothing=true
if args.notClothing then
showClothing=false
end

local clothingId=imageInfo.clothingId
local clothingStar=imageInfo.clothingStar or 0
if args~=nil then
if args.clothingId~=nil then
clothingId=args.clothingId
end
if args.clothingStar~=nil then
clothingStar=args.clothingStar
end
end
if clothingId then
if bodyCfg.clothing_map then
local change=bodyCfg.clothing_map[clothingId]
if change then
local maxIndex=clothingStar>=ClothingConfig.getStarMaxLv(clothingId)and 2 or 1
bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,change[maxIndex])
end
end
end


local bgFisrt=args.bgFisrt


local bd_skeletonID
if bgFisrt and bodyCfg.skeletonID_bg then
bd_skeletonID=bodyCfg.skeletonID_bg
else
bd_skeletonID=bodyCfg.skeletonID
end
if bd_skeletonID then
result.body=bd_skeletonID
end

local bd_in_side
if bgFisrt and bodyCfg.in_side_bg then
bd_in_side=bodyCfg.in_side_bg
else
bd_in_side=bodyCfg.in_side
end
if bd_in_side then
for _,cmpID in ipairs(bd_in_side)do
table_insert(result.componets,cmpID)
end
end
local body2=cfgHelper.get(cfg_dbbodyconfig_get,result.body,'body2')
if args.changeBody and body2 and body2[args.changeBody]then
result.body=body2[args.changeBody][1]
end
end
if imageInfo.accessory>0 then

local accessory=cfgHelper.get2(cfg_disciplefaceaccessoryimageconfig_get,imageInfo.accessory,'in_side')
if accessory~=nil then
for _,cmpID in ipairs(accessory)do
table_insert(result.componets,cmpID)
end
end
end

local scales=cfgHelper.get2(cfg_dbbodyconfig_get,result.body,'scales')or{}
result.scale=scales[1]or 1
result.anim=0
return result
end

function UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(imageInfo,args)
args=args or{}
local result={}
result.componets={}
if imageInfo.hair>0 then

local hair=cfgHelper.get2(cfg_disciplehairimageconfig_get,imageInfo.hair,'lihui')
if hair~=nil then
for _,cmpID in ipairs(hair)do
table_insert(result.componets,cmpID)
end
end
end
if imageInfo.face>0 then

local face=cfgHelper.get2(cfg_disciplefaceimageconfig_get,imageInfo.face,'lihui')
if face~=nil then
for _,cmpID in ipairs(face)do
table_insert(result.componets,cmpID)
end
end
end
if imageInfo.body>0 then
local bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,imageInfo.body)

local showClothing=true
if args.notClothing then
showClothing=false
end
if showClothing then
local clothingId=imageInfo.clothingId
local clothingStar=imageInfo.clothingStar or 0
if args~=nil then
if args.clothingId~=nil then
clothingId=args.clothingId
end
if args.clothingStar~=nil then
clothingStar=args.clothingStar
end
end
if clothingId then
if bodyCfg.clothing_map then
local change=bodyCfg.clothing_map[clothingId]
if change then
local maxIndex=clothingStar>=ClothingConfig.getStarMaxLv(clothingId)and 2 or 1
bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,change[maxIndex])
end
end
end
end



local isNotBg=args.isNotBg or false
local hasLihuiConfig=false

if isNotBg then
if bodyCfg.skeletonID_lihui_notBg then
result.body=bodyCfg.skeletonID_lihui_notBg
if bodyCfg.lihui~=nil then
for _,cmpID in ipairs(bodyCfg.lihui)do
table_insert(result.componets,cmpID)
end
end
hasLihuiConfig=true
end
end

if not hasLihuiConfig then
if bodyCfg.skeletonID_lihui then
result.body=bodyCfg.skeletonID_lihui
if bodyCfg.lihui~=nil then
for _,cmpID in ipairs(bodyCfg.lihui)do
table_insert(result.componets,cmpID)
end
end
else
result.body=bodyCfg.skeletonID
if bodyCfg.in_side~=nil then
for _,cmpID in ipairs(bodyCfg.in_side)do
table_insert(result.componets,cmpID)
end
end
end
end

end
if imageInfo.accessory>0 then

local accessory=cfgHelper.get2(cfg_disciplefaceaccessoryimageconfig_get,imageInfo.accessory,'lihui')
if accessory~=nil then
for _,cmpID in ipairs(accessory)do
table_insert(result.componets,cmpID)
end
end
end
return result
end


function UIDiscipleModel:getDiscipleHeadModelInfo(guid,noFace)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
return UIDiscipleModel:getImageInfoHeadModelInfo(imageInfo,noFace)
end

function UIDiscipleModel:getImageInfoHeadModelInfo(imageInfo,noFace)
local result={}
local bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,imageInfo.body)
result.body=bodyCfg.out_side
local hideWeapon=cfgHelper.get2(cfg_dbbodyconfig_get,result.body,'hideWeapon')
result.hideWeapon=hideWeapon
result.componets={}
if(not noFace)and imageInfo.face>0 then

local comp=cfgHelper.get2(cfg_disciplefaceimageconfig_get,imageInfo.face,'out_side')
if comp then
for _,cmpID in ipairs(comp)do
table_insert(result.componets,cmpID)
end
end
end
if imageInfo.hair>0 then

local comp=cfgHelper.get2(cfg_disciplehairimageconfig_get,imageInfo.hair,'out_side')
if comp then
for _,cmpID in ipairs(comp)do
table_insert(result.componets,cmpID)
end
end
end





local headOffset=cfgHelper.get2(cfg_dbbodyconfig_get,result.body,'headOffset')
result.offset={headOffset[1],headOffset[2]}
result.scale=headOffset[3]or 1
result.anim=0
return result
end



function UIDiscipleModel:getDiscipleOutsideModelInfo(guid,showWeapon,scaleType,other,switchidx)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid,switchidx)
local result=self:getDiscipleOutsideModelInfoByData(imageInfo,scaleType,other)

if showWeapon==true and result.hideWeapon==nil then
local weaponID=0
local equipItemID=UIDiscipleModel:getDiscipleShowWeaponID(guid,true,switchidx)
if equipItemID>0 then
local equipCfg=itemsConfig.getConfig(equipItemID)
if equipCfg then
weaponID=equipCfg.imageID or 0

end
end
if weaponID>0 then
table_insert(result.componets,cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponID,'out_side'))
end
end

return result
end

function UIDiscipleModel:getDiscipleOutsideModelInfo2(guid,weaponID,scaleType,other)
local imageInfo=UIDiscipleModel:getDiscipleImageInfo(guid)
local result=self:getDiscipleOutsideModelInfoByData(imageInfo,scaleType,other)

if weaponID~=nil and weaponID>0 and result.hideWeapon==nil then
table_insert(result.componets,cfgHelper.get2(cfg_discipleweaponimageconfig_get,weaponID,'out_side'))
end
return result
end

function UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo,scaleType,args)
args=args or{}
local result={}
local bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,imageInfo.body)

if args.tmLv and bodyCfg.out_tm and bodyCfg.out_tm[args.tmLv]then
result.body=bodyCfg.out_tm[args.tmLv]
end


local xianmo_voc
local showXianMo=true
if args~=nil and args.hideXianMo==true then
showXianMo=false
end
if showXianMo then
xianmo_voc=imageInfo.xianmo_voc
if args~=nil and args.xianmo_voc then
xianmo_voc=args.xianmo_voc
end
if xianmo_voc then
if bodyCfg.xm_transfer and bodyCfg.xm_transfer[xianmo_voc]then
local index=1
if args.tmLv and args.tmLv>=#cfg_discipletianminglevelconfig()then
index=2
end
result.body=bodyCfg.xm_transfer[xianmo_voc][index]
end
end
end


local clothingId
local clothingStar
local showClothing=true

if args~=nil and args.notClothing==true then
showClothing=false
end
if showClothing then
clothingId=imageInfo.clothingId
clothingStar=imageInfo.clothingStar or 0
if args~=nil then
if args.clothingId~=nil then
clothingId=args.clothingId
end
if args.clothingStar~=nil then
clothingStar=args.clothingStar
end
end
if clothingId then
if bodyCfg.clothing_map and bodyCfg.clothing_map[clothingId]then
local change=bodyCfg.clothing_map[clothingId]
local maxIndex=clothingStar>=ClothingConfig.getStarMaxLv(clothingId)and 2 or 1
bodyCfg=cfgHelper.get1(cfg_disciplebodyimageconfig_get,change[maxIndex])

result.body=bodyCfg.out_side
else
if bodyCfg.clothing_out_side and bodyCfg.clothing_out_side[clothingId]then
local maxIndex=clothingStar>=(ClothingConfig.getStarMaxLv(clothingId)or 5)and 2 or 1
result.body=bodyCfg.clothing_out_side[clothingId][maxIndex]
end
end
end
end



if not result.body then
result.body=bodyCfg.out_side
end

local hideWeapon=cfgHelper.get2(cfg_dbbodyconfig_get,result.body,'hideWeapon')
result.hideWeapon=hideWeapon

result.componets={}
if imageInfo.face>0 then

local comp=cfgHelper.get2(cfg_disciplefaceimageconfig_get,imageInfo.face,'out_side')
if comp then
for _,cmpID in ipairs(comp)do
table_insert(result.componets,cmpID)
end
end
end
if imageInfo.hair>0 then

local hairCfg=cfgHelper.get1(cfg_disciplehairimageconfig_get,imageInfo.hair)
if hairCfg then
if clothingId~=nil then
if hairCfg.clothing_out_side and hairCfg.clothing_out_side[clothingId]then
table_insert(result.componets,hairCfg.clothing_out_side[clothingId])
end
elseif xianmo_voc~=1 and xianmo_voc~=2 then
local comp=hairCfg.out_side
if comp then
for _,cmpID in ipairs(comp)do
table_insert(result.componets,cmpID)
end
end
end
end
end

local body2=cfgHelper.get(cfg_dbbodyconfig_get,result.body,'body2')
if args.changeBody and body2 and body2[args.changeBody]then
result.body=body2[args.changeBody][1]
end





local scales=cfgHelper.get2(cfg_dbbodyconfig_get,result.body,'scales')or{}
scaleType=scaleType or 2
result.scale=scales[scaleType]or 1
result.anim=0
return result
end