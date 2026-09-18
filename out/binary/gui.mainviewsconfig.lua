
mainViewsConfig={}


MAIN_VIEW_TYPE=
{
eZongMenZhuFeng=1,
eLingShouDao=2,
eXianzhan=3,
eMiJing=4,
eWorld=5,
eXianMeng=6,
eChaKanZhuFeng=7,
eXianJie=8,
eFort=9,
eAir=10,
}





local _openViewAttachMap=
{






["UITaskListWin"]={
gameplot=true,
scene={{sceneType=eSceneType.eZongmen,mapIds={mapIdType.zhufeng,mapIdType.fort,mapIdType.lingshoudao}},{sceneType=eSceneType.eWorld}},
check=function()
return taskController.showTaskListConditon()
end
},
['UIBuildingMsgWin']={
gameplot=false,
scene={{sceneType=eSceneType.eZongmen,mapIds={mapIdType.zhufeng}}},
check=function()
return MysteryModel:get_cur_fbid()==nil
end
},
['UIMainEntryWin']={
gameplot=false,
scene={{sceneType=eSceneType.eZongmen,mapIds={mapIdType.zhufeng,mapIdType.xianmeng,mapIdType.fort,mapIdType.lingshoudao}},{sceneType=eSceneType.eXianJie}},
check=function()
return MysteryModel:get_cur_fbid()==nil
end,
},
['UIFuncStorageWin']={
gameplot=true,
scene={{sceneType=eSceneType.eZongmen,mapIds={mapIdType.zhufeng,mapIdType.fort}}},
check=function()
return zongmenControl:checkShowFuncStorageWin()and MysteryModel:get_cur_fbid()==nil
end,
sortWeight=1,
},
['UIFuncStorageXMWin']={
gameplot=false,
scene={{sceneType=eSceneType.eZongmen,mapIds={mapIdType.xianmeng}}},
check=function()
return mainCountHelper:checkXMCountWin()and
MysteryModel:get_cur_fbid()==nil
end
},
['UILimitActStorageWin']={
gameplot=false,
scene={{sceneType=eSceneType.eZongmen,mapIds={mapIdType.zhufeng,mapIdType.fort}}},
check=function()
return MysteryModel:get_cur_fbid()==nil
end
},
['UIAssetLoadEnterWin']=
{
gameplot=true,
check=function()
return downAssetManager:visDownLoadEnterWin()
end
},
['UIMoneyDetailWin']={
gameplot=false,
scene={{sceneType=eSceneType.eZongmen,mapIds={mapIdType.zhufeng}}},
args=function()
return{isInit=true}
end,
check=function()
return MysteryModel:get_cur_fbid()==nil and simpleModeControl:getLeftSimple()==leftSimpleState.moneyDetail
end
},
['UIHomeBuffWin']={
gameplot=false,
scene={{sceneType=eSceneType.eZongmen,mapIds={mapIdType.zhufeng}}},
args=function()
local list=homeBuffModel.getAllList()
return{list=list,isInit=true}
end,
check=function()
return MysteryModel:get_cur_fbid()==nil and simpleModeControl:getLeftSimple()==leftSimpleState.homeBuff
end
},
['UIItemUseTipWin']=
{
gameplot=false,
scene={{sceneType=eSceneType.eZongmen,mapIds={mapIdType.zhufeng,mapIdType.lingshoudao}}},
check=function()
return bagUseControl.checkOpenWindow()
end
},






['UIWorldFuncStorageWin']={
gameplot=false,
scene={{sceneType=eSceneType.eWorld}},
check=function()
return MysteryModel:get_cur_fbid()==nil
end,
},
['UITianMoJieEventWin']={
gameplot=false,
scene={{sceneType=eSceneType.eZongmen,mapIds={mapIdType.zhufeng}}},
check=function()
local actorId=playerModel:getActorID()
return tianMoJieModel:haveMonsterByActor(actorId)and MysteryModel:get_cur_fbid()==nil
end
},
['UIXianJieFuncStorageWin']={
gameplot=false,
scene={{sceneType=eSceneType.eXianJie}},
check=function()
return xianjieController:checkShowFuncStorageWin()
end,
},
['UIXianJieLimitActStorageWin']={
gameplot=false,
scene={{sceneType=eSceneType.eXianJie}},
check=function()
return MysteryModel:get_cur_fbid()==nil
end
},
}
local _sortOpenViewAttachMap

for name,_ in pairs(_openViewAttachMap)do
UIManager:addIgonreWindow(name)
end

local _closeViewAttachList=
{

'UIBuildingMsgWin',
'UIFuncStorageWin',
'UILimitActStorageWin',
'UITianMoJieEventWin',
}

local _hideViewAttchList=
{

"UITaskListWin",
'UIMainEntryWin',
'UIAssetLoadEnterWin',
"UIMoneyDetailWin",
"UIHomeBuffWin",
'UIItemUseTipWin',
'UIFuncStorageXMWin',

'UIWorldFuncStorageWin',
'UIXianJieFuncStorageWin',
'UIXianJieLimitActStorageWin',
}




local _mainViewsConfig=
{

[MAIN_VIEW_TYPE.eZongMenZhuFeng]=
{
check=function()
return mainControl:isSceneType(eSceneType.eZongmen)and
(zongmenControl:isMountid(mapIdType.zhufeng)or
zongmenControl:isMountid(mapIdType.lingshoudao)or
zongmenControl:isMountid(mapIdType.zhufeng_design))and
MysteryModel:get_cur_fbid()==nil
end,
open=function()
mainControl:openWindow()
mainTipsController:openMain()
end,
close=function()
mainControl:hideWindow()
mainTipsController:closeMain()
end
},
[MAIN_VIEW_TYPE.eXianzhan]={
check=function()
return mainControl:isSceneType(eSceneType.eZongmen)and
zongmenControl:isMountid(mapIdType.xianzhan)and
MysteryModel:get_cur_fbid()==nil
end,
open=function()
xianzhanController:openXianZhanMainWin()
end,
close=function()
xianzhanController:closeXianZhanMainWin()
end
},
[MAIN_VIEW_TYPE.eXianMeng]={
check=function()
return mainControl:isSceneType(eSceneType.eZongmen)and
zongmenControl:isMountid(mapIdType.xianmeng)and
MysteryModel:get_cur_fbid()==nil
end,
open=function()
xianmengController:showMain()
end,
hide=function()
xianmengController:hideMain()
end,
close=function()
xianmengController:closeMain()
end,
},
[MAIN_VIEW_TYPE.eMiJing]=
{
check=function()
return MysteryModel:get_cur_fbid()~=nil
end,
open=function()
UIFullMysteryMainControl:showMysteryMainWindow()
end,
close=function()
UIFullMysteryMainControl:hideMysteryMainWindow()
end
},
[MAIN_VIEW_TYPE.eWorld]=
{
check=function()
return mainControl:isSceneType(eSceneType.eWorld)and
MysteryModel:get_cur_fbid()==nil
end,
open=function()
worldController:openPanel()
end,
close=function()
worldController:hidePanel()
end
},
[MAIN_VIEW_TYPE.eChaKanZhuFeng]={
check=function()
return mainControl:isSceneType(eSceneType.eZongmen)and
zongmenControl:isMountid(mapIdType.zhufeng_hy)and
MysteryModel:get_cur_fbid()==nil
end,
open=function()
visitControl:openVisitWin()
end,
close=function()
visitControl:closeVisitWin()
end
},
[MAIN_VIEW_TYPE.eXianJie]={
check=function()
return mainControl:isSceneType(eSceneType.eXianJie)and
MysteryModel:get_cur_fbid()==nil
end,
open=function()
xianjieController:openXianJieWin()
end,
hide=function()
xianjieController:hideXianJieWin()
end,
close=function()
xianjieController:closeXianJieWin()
end
},
[MAIN_VIEW_TYPE.eFort]={
check=function()
return mainControl:isSceneType(eSceneType.eZongmen)and
zongmenControl:isMountid(mapIdType.fort)and
MysteryModel:get_cur_fbid()==nil
end,
open=function()
UIManager:showWindow('UIXianJieFortInfoWin')
UIManager:showWindow('UIXianJieFortTaskbarWin')
mainControl:openWindow()
mainTipsController:openMain()
end,
close=function()
UIManager:closeWindow('UIXianJieFortInfoWin')
UIManager:closeWindow('UIXianJieFortTaskbarWin')
mainControl:hideWindow()
mainTipsController:closeMain()
end
},
[MAIN_VIEW_TYPE.eAir]={
check=function()
return mainControl:isSceneType(eSceneType.eAirGame)and
MysteryModel:get_cur_fbid()==nil
end,
open=function()
airController:openMain()
end,
close=function()
airController:closeMain()
end
},
}


function mainViewsConfig.getOpenMap()
return _openViewAttachMap
end

function mainViewsConfig.getSortOpenMap()
if not _sortOpenViewAttachMap or not next(_sortOpenViewAttachMap)then
_sortOpenViewAttachMap={}
for name,viewConf in pairs(_openViewAttachMap)do
local sortWeight=viewConf.sortWeight or 10000
_sortOpenViewAttachMap[#_sortOpenViewAttachMap+1]={
name=name,
cfg=viewConf,
sortWeight=sortWeight,
}
end

if#_sortOpenViewAttachMap>1 then
table.sort(_sortOpenViewAttachMap,function(a,b)
return a.sortWeight<b.sortWeight
end)
end
end

return _sortOpenViewAttachMap
end

function mainViewsConfig:getOpenData(winName)
return _openViewAttachMap[winName]
end

function mainViewsConfig.getCloseMap()
return _closeViewAttachList
end

function mainViewsConfig.getHideMap()
return _hideViewAttchList
end

function mainViewsConfig.getAllMainTypeCfg()
return _mainViewsConfig
end

function mainViewsConfig.getMainTypeCfg(mainType)
return _mainViewsConfig[mainType]
end