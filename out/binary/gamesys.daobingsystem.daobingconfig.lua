daobingConfig={}

local _colorBgName={
[eQualityColor.ePurple]='image_daobingpz_01',
[eQualityColor.eOrange]='image_daobingpz_02',
[eQualityColor.eRed]='image_daobingpz_03',
}




function daobingConfig.getCommonConfig()
return cfg_discipledaobingconfig_get(1)
end

function daobingConfig.getUnlocklv()
return daobingConfig.getCommonConfig().tianming
end

function daobingConfig.getjinglianLimitLv()
return daobingConfig.getCommonConfig().jinglian
end

function daobingConfig.getjinglianLimitLvByStar(starlv)
return daobingConfig.getjinglianLimitLv()[starlv]
end

function daobingConfig.getWeaponShentongLvByStar(star)
local shentong=daobingConfig.getCommonConfig().shentong or{}
return shentong[star][1]
end

function daobingConfig.getVocShentongLvByStar(star)
local shentong=daobingConfig.getCommonConfig().shentong or{}
return shentong[star][2]
end

function daobingConfig.getZhuanShuShentongLvByStar(star)
local shentong=daobingConfig.getCommonConfig().shentong or{}
return shentong[star][3]
end


function daobingConfig.getStarByShentonglv(lv)
local shentong=daobingConfig.getCommonConfig().shentong or{}
local min
local minlv
for k,v in pairs(shentong)do
if minlv==nil or lv>=v[1]and minlv<=v[1]then
min=k
minlv=v[1]
end
end
return min
end

function daobingConfig.getCostBenTiNum(starlv)
local consume=daobingConfig.getCommonConfig().consume
return consume[starlv]or 0
end






function daobingConfig.getJinglianMaxLv(itemid)
local itemsCfg=itemsConfig.getConfig(itemid)
return#itemsCfg.jinglian
end


function daobingConfig.getCurrentJinglianMaxLv(itemid,starlv)
local itemsCfg=itemsConfig.getConfig(itemid)
local maxlv=#itemsCfg.jinglian
local maxlv2=daobingConfig.getjinglianLimitLvByStar(starlv)
return math.min(maxlv2,maxlv)
end



function daobingConfig.getStarMaxLv(itemid)
local itemsCfg=itemsConfig.getConfig(itemid)
return#(itemsCfg.star)
end

function daobingConfig.isStarMaxLv(itemid,starlv)
local maxlv=daobingConfig.getStarMaxLv(itemid)
return starlv>=maxlv
end

function daobingConfig.getMinStarLvByJlLv(jllv)
local star=daobingConfig.getjinglianLimitLv()
local min
for k,v in pairs(star)do
if v>=jllv and(min==nil or min>k)then
min=k
end
end
return min
end

function daobingConfig.getColorBg(color)
return _colorBgName[color]
end

function daobingConfig.getNextTuPoLv(itemid,lv)
local itemCfg=itemsConfig.getConfig(itemid)
local jinglian=daobingHelper.getJlAttrs(itemCfg)
local jllv=lv
local precent=jinglian[jllv][3]
while true do
jllv=jllv+1
local jinglianTable=jinglian[jllv]
if jinglianTable==nil then return end
local p=jinglianTable[3]
if p>precent then return jllv end
end
end

function daobingConfig.getCombineCnt(itemid)
return itemsConfig.getConfig(itemid).piece[2]
end

function daobingConfig.getCombineDaoBing(itemid)
return itemsConfig.getConfig(itemid).piece[1]
end