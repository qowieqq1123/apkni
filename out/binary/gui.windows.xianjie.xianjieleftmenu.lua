





XianJieLeftMenu={}

XIAN_JIE_MAIN_MENU_TYPE=
{
eMoJieZhengDuo=1,
eZhengTaoMoJiang=2,
eLeiTaiYanWu=3,
eZhengTaoMoJun=4,
eXiuFuZhenTai=5,
}

local _XianJieMenuConfig=
{
[XIAN_JIE_MAIN_MENU_TYPE.eMoJieZhengDuo]=
{
menuSkin="mjzdmenuGroup",
check=function()
return moGongZhengDuoActModel:checkIsXJArenaActDoing()and
(mainControl:isSceneType(eSceneType.eXianJie)and
xianjienSceneType:isMoGongZhengDuo(xianjieModel:getScenceType()))
end,
open=function(self)
self:showWindow("UIXianJieExtra_MJZDWin")
end,
close=function(self)
self:closeWindow("UIXianJieExtra_MJZDWin")
end,

checkTaskShow=function(self)
return self:callExtraFunc("getSelectMenuPageIndex")==2
end,
},
[XIAN_JIE_MAIN_MENU_TYPE.eZhengTaoMoJiang]=
{
menuSkin="ztmjmenuGroup",
check=function()
return(mainControl:isSceneType(eSceneType.eXianJie)and
xianjienSceneType:isMoJie(xianjieModel:getScenceType()))and
limitActivitiesModel:checkAct_Open_Doing(LIMIT_ACT_TYPE.eMoJiang)and
seasonModel:haveDoingStage(seasonStageType.eMJHD)
end,
open=function(self)
self:showWindow("UIXianJieExtra_ZTMJWin")
end,
close=function(self)
self:closeWindow("UIXianJieExtra_ZTMJWin")
end,

checkTaskShow=function(self)
return self:callExtraFunc("getSelectMenuPageIndex")==2
end,
},
[XIAN_JIE_MAIN_MENU_TYPE.eLeiTaiYanWu]=
{
menuSkin="ltywmenuGroup",
check=function()
local isDoingArena=xianJieArenaActModel:checkIsXJArenaActCanOpen()and xianJieArenaActModel:checkIsXJArenaActDoing()
if isDoingArena then

local nowSceneIdx=xianjieModel:getSceneIndex()
local isInMoJie=nowSceneIdx and xianjienSceneIndexType:isMoJie(nowSceneIdx)or false
return not isInMoJie
else
return false
end

end,
open=function(self)

end,
close=function(self)

end,

checkTaskShow=function(self)
return self:callExtraFunc("getSelectMenuPageIndex")==2
end,
},
[XIAN_JIE_MAIN_MENU_TYPE.eZhengTaoMoJun]=
{
menuSkin="ztmjunmenuGroup",
check=function()
return(mainControl:isSceneType(eSceneType.eXianJie)and
xianjienSceneType:isMoJie(xianjieModel:getScenceType()))and
xianjieModel:isShowMoJunMenuGroup()
end,
hideMenuSkin=function()
return xianjieModel:hideMoJunMenuSkin()
end,
open=function(self)
self:showWindow("UIXianJieExtra_ZTMJunWin")
end,
close=function(self)
self:closeWindow("UIXianJieExtra_ZTMJunWin")
end,

checkTaskShow=function(self)
return self:callExtraFunc("getSelectMenuPageIndex")==2
end,
},
[XIAN_JIE_MAIN_MENU_TYPE.eXiuFuZhenTai]=
{
menuSkin="xfztmenuGroup",
check=function()
return(mainControl:isSceneType(eSceneType.eXianJie)and
xianjienSceneType:isMoJie(xianjieModel:getScenceType()))and
xianjieModel:isShowZhenTaiMenuGroup()
end,
open=function(self)
end,
close=function(self)
end,

checkTaskShow=function(self)
return self:callExtraFunc("getSelectMenuPageIndex")==2
end,
},
}

function XianJieLeftMenu.getXianJieAllConfig()
return _XianJieMenuConfig
end

function XianJieLeftMenu.getXianJieConfig(xjMainMenuType)
return _XianJieMenuConfig[xjMainMenuType]
end