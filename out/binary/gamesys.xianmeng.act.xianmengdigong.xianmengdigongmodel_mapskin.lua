







local mapSkinConfig={

[1]={
topHeight=272,
bottomHeight=197,
mapTopSide=0,
mapBottomSide=0,
mapLeftSide=0,
mapRightSide=0,
topSpineID=4104,
topSpineWidth=1625,
topEnterSpineID=4103,
topEnterSpineWidth=1625,
bottomSpineID=4105,
bottomSpineWidth=1625,
},
}

function xianmengdigongModel:get_mapSkinCfg(mpaSkinID)
return mapSkinConfig[mpaSkinID]
end