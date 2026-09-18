








function helper.getAttrRelationShip(attrType)
local cfg=cfgHelper.get1(cfg_attributesconfig_get,attrType)
if cfg then return cfg.PTCRelationship end
return nil
end

function helper.getAttrRelationShipChange(lookup)
for k,v in pairs(lookup)do
local ptc=helper.getAttrRelationShip(k)
if ptc~=nil and lookup[ptc]~=nil then

lookup[k]=math.floor(lookup[k]*(1+math.floor(lookup[ptc]*10000+0.1)/10000)+0.00001)

end
end
end

function helper.getAttributeCfg(attrType)
return cfgHelper.get1(cfg_attributesconfig_get,attrType)
end

function helper.getAttributeName(attrType)
return cfgHelper.get2(cfg_attributesconfig_get,attrType,'attrname')
end

function helper.getAttributeStr(attrType,attrValue,bitNum,fmt_str)
fmt_str=fmt_str or'{0} {1}'
local attrConfig=cfg_attributesconfig_get(attrType)
local name=attrConfig.attrname
local valStr=helper.getAttributeStrEx(attrType,attrValue,bitNum)
return FMT.fmt(fmt_str,name,valStr)
end

function helper.getAttributeStrEx(attrType,attrValue,bitNum)
if bitNum==nil then bitNum=1 end
local attrConfig=cfg_attributesconfig_get(attrType)
local flag=attrConfig.flag
local val=helper.getAttributeNum(attrType,attrValue,bitNum)
local valStr
if flag==3 then
valStr=FMT.fmt('{0}%',val)
elseif flag==2 then
valStr=FMT.fmt('{0}%',val)
else
valStr=math.floor(val)
end
return valStr
end

function helper.getAttributeNum(attrType,attrValue,bitNum)
if bitNum==nil then bitNum=1 end
local attrConfig=cfg_attributesconfig_get(attrType)
local flag=attrConfig.flag
local val
if flag==3 then
val=mathHelper.decimal(attrValue*100,bitNum)
elseif flag==2 then
val=mathHelper.decimal(attrValue/100,bitNum)
else
val=math.floor(attrValue)
end
local max_value=attrConfig.max_value
if max_value~=nil and val>max_value then
val=max_value
end
return val
end

function helper.getAttributeStr1(attrType,attrValue)
local attributesconfig=cfgHelper.get1(cfg_attributesconfig_get,attrType)
local str=tostring(attrValue)
if attributesconfig.ifMod then
str=str..'%'
end
return str
end

function helper.getAttributeStr2(attrType,attrValue,bitNum,fmt_str)
fmt_str=fmt_str or'{0} {1}'
local attrConfig=cfg_attributesconfig_get(attrType)
local name=attrConfig.attrname
local valStr=helper.getAttributeStrEx2(attrType,attrValue,bitNum)
return FMT.fmt(fmt_str,name,valStr)
end

function helper.getAttributeStrEx2(attrType,attrValue,bitNum)
if bitNum==nil then bitNum=1 end
local attrConfig=cfg_attributesconfig_get(attrType)
local flag=attrConfig.flag
local val=helper.getAttributeNum(attrType,attrValue,bitNum)
local valStr
if flag==3 then
valStr=FMT.fmt('{0}%',val)
elseif flag==2 then
valStr=FMT.fmt('{0}%',val)
else
valStr=mathHelper.formatNumber9(val,1)
end
return valStr
end

function helper.getAttributeStr3(attrType,attrValue,bitNum,fmt_str)
fmt_str=fmt_str or'{0}{1}'
local attrConfig=cfg_attributesconfig_get(attrType)
local name=attrConfig.attrname
local flag=attrConfig.flag
local val=helper.getAttributeNum(attrType,attrValue,bitNum)

local cflag=val>0 and 1 or 0

local tval=Mathf.Abs(val)

local valStr
if flag==3 then
valStr=FMT.fmt('{0}%',tval)
elseif flag==2 then
valStr=FMT.fmt('{0}%',tval)
else
valStr=mathHelper.formatNumber9(tval,1)
end

valStr=cflag==1 and FMT.fmt("增加{0}",toColorString(FONT_COLOR.eGreenTxtColor,valStr))or FMT.fmt("降低{0}",toColorString(FONT_COLOR.eRedColor,valStr))

return FMT.fmt(fmt_str,name,valStr)
end

function helper.getAttributeStr4(attrType,attrValue,bitNum,fmt_str)
fmt_str=fmt_str or'{0} {1}'
local attrConfig=cfg_attributesconfig_get(attrType)
local name=attrConfig.attrname
local valStr=helper.getAttributeStrEx4(attrType,attrValue,bitNum)
return FMT.fmt(fmt_str,name,valStr)
end

function helper.getAttributeStrEx4(attrType,attrValue,bitNum)
if bitNum==nil then bitNum=1 end
local attrConfig=cfg_attributesconfig_get(attrType)
local flag=attrConfig.flag
local val=helper.getAttributeNum(attrType,attrValue,bitNum)
local valStr
if flag==3 then
valStr=FMT.fmt('{0}%',val)
elseif flag==2 then
valStr=FMT.fmt('{0}%',val)
else
valStr=mathHelper.formatNumber9(val,2)
end
return valStr
end



















