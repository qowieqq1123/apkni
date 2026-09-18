







function gubaoModel:getLianHuaLv(gbid)
local gbData=gubaoModel:getDataByID(gbid)
if gbData~=nil then
return gbData.gubaolhlv
end
return 0
end

function gubaoModel:checkFullLianHua(gbid)
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
local curlv=gbData.gubaolhlv
local maxlv=gubaoModel:getLianHuaMax(gbid)
return curlv>=maxlv
end
return false
end
function gubaoModel:checkFullLianHuaEx(gbid)
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
local curlv=gbData.gubaolhlv
local maxlv=gubaoModel:getLianHuaMaxEx()
return curlv>=maxlv
end
return false
end

function gubaoModel:getLianHuaMax(gbid)
local gbData=gubaoModel:getDataByID(gbid)
if gbData then
local star=gbData.gubaostar
return cfg_gubaobaseconfig_get(1).lianhualimit[star]
end
return 0
end
function gubaoModel:getLianHuaMaxEx()
return cfg_gubaobaseconfig_get(1).lianhualimit[gubaoModel.maxStar]
end

function gubaoModel:checkCanLianHua(gbid)
local isSpe=gubaoModel:isSpecial(gbid)
if not isSpe then
if not gubaoModel:checkFullLianHua(gbid)then
return gubaoLookup:hasAnyEnoughGoods()
end
end
return false
end

function gubaoModel:checkAllLianHuaReddot()
local lookup=gubaoModel:getGuGaoArray()
local check=false
if lookup then
for k,v in pairs(lookup)do
local gbid=v.gubaoid
local isSpe=gubaoModel:isSpecial(gbid)
if not isSpe and not gubaoModel:checkFullLianHua(gbid)then
check=true
break
end
end
end
if check then
return gubaoLookup:hasAnyEnoughGoods()
end
return false
end

function gubaoModel:getLianHuaCostMoney()
return cfg_gubaobaseconfig_get(1).lianhuaconsume
end

function gubaoModel:getLianHuaCfg(gbid,lv)
return cfg_gubaoconfig_get(gbid).lianhua[lv]
end

function gubaoModel:getLianHuaUpExp(gbid,lv)
local lhcfg=gubaoModel:getLianHuaCfg(gbid,lv)
if lhcfg then
return lhcfg[1]
end
return nil
end

function gubaoModel:changeAddExp(gbid,addexp)
local gbData=gubaoModel:getDataByID(gbid)
local curlv=gbData.gubaolhlv
local curexp=gbData.gubaolhexp
local maxlv=gubaoModel:getLianHuaMax(gbid)
local changelv=curlv
local changeexp=curexp+addexp
local upexp=gubaoModel:getLianHuaUpExp(gbid,changelv)
while upexp~=nil and upexp~=0 and changeexp>=upexp and changelv<maxlv do
changeexp=changeexp-upexp
changelv=changelv+1
upexp=gubaoModel:getLianHuaUpExp(gbid,changelv)
end
return changelv,changeexp
end