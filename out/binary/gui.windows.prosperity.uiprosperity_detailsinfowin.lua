







def_class("UIProsperity_DetailsInfoWin",UIWindowBase)









function UIProsperity_DetailsInfoWin:bindComponents()

self.Root=UIObject.get(self,0)
self.uiRoot=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.infoScrollView=UIScrollView.get(self,3)
self.menuSpineList=UIObject.get(self,4)
self.menuList=UIObject.get(self,5)
self.menu_anim_1=UIObject.get(self,6)
self.menu_anim_2=UIObject.get(self,7)
self.menu_anim_3=UIObject.get(self,8)
self.infoList=UIObject.get(self,9)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.menu_anim={
self.menu_anim_1,
self.menu_anim_2,
self.menu_anim_3,
}



end


function UIProsperity_DetailsInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.infoScrollView);self.infoScrollView=nil;
_UIObject_release(self.menuSpineList);self.menuSpineList=nil;
_UIObject_release(self.menuList);self.menuList=nil;
_UIObject_release(self.menu_anim_1);self.menu_anim_1=nil;
_UIObject_release(self.menu_anim_2);self.menu_anim_2=nil;
_UIObject_release(self.menu_anim_3);self.menu_anim_3=nil;
_UIObject_release(self.infoList);self.infoList=nil;
self.menu_anim=nil;
end
















local _this

local menu_slot_name='button_dytab'

local body_id={
menu=2017,
}

local CmpProsperityItemIndex={
icon=0,
info=1,
pInfo=2,
dzSkillInfo=3,
goBtn=4,
btntxt=5,
}

local menuDataList={
{
name="全部",
getMenuPanelData=function()
return prosperityModel:getBuildingFRDDataList()
end
},
{
name="生产",
getMenuPanelData=function()
return prosperityModel:getBuildingProsperityByWinTypeList({sysWinType.eFangAn})
end
},
{
name="设施",
getMenuPanelData=function()
return prosperityModel:getBuildingProsperityByWinTypeList({sysWinType.eFangAn},true)
end
},
}

local infoDescFuncList={
[SLG_SYSTEM_TYPE.eZongMen]=function(data,bdData)
local num=guildOrderModel:getOrderActiveNum()
local preinfo=toColorString(FONT_COLOR.eOrangeDescColor,"已激活法令数量：")
local info=FMT.fmt('{0}{1}',preinfo,num)
return info
end,
[SLG_SYSTEM_TYPE.eTanXianDui]=function(data,bdData)
local num=wanBaoXunBaoDuiModel:getUnlockChannelNum()
local preinfo=toColorString(FONT_COLOR.eOrangeDescColor,"已激活航道数量：")
local info=FMT.fmt('{0}{1}',preinfo,num)
return info
end,
[SLG_SYSTEM_TYPE.eQianJiGe]=function(data,bdData)
local num=QianJiGeModel:get_unlock_skill_num()
local preinfo=toColorString(FONT_COLOR.eOrangeDescColor,"已激活技能数量：")
local info=FMT.fmt('{0}{1}',preinfo,num)
return info
end,
[SLG_SYSTEM_TYPE.eYinXianTai]=function(data,bdData)
local datas=worldXiuZhenJiaZuModel:getAllSelfFamilyData()or{}
local num=#datas
local preinfo=toColorString(FONT_COLOR.eOrangeDescColor,"已进驻家族数量：")
local info=FMT.fmt('{0}{1}',preinfo,num)
return info
end,
[SLG_SYSTEM_TYPE.eChuanSongZhen]=function(data,bdData)
local num=0
local zyAllCfg=cfg_worldblocktransportconfig()
for worldID,worldData in pairs(zyAllCfg)do
if worldBlockModel:getWorldStateCount(worldID,eWorldBlockState.OPEN)>0 then
for blockID,bloackData in pairs(worldData)do
if worldBlockModel:checkBlockState(worldID,blockID,eWorldBlockState.OPEN)then
if chuanSongZhenModel:getFlagBit(worldID,blockID)then
num=num+1
end
end
end
end
end
local preinfo=toColorString(FONT_COLOR.eOrangeDescColor,"已激活阵眼数量：")
local info=FMT.fmt('{0}{1}',preinfo,num)
return info
end,
[SLG_SYSTEM_TYPE.eCangJingGe]=function(data,bdData)
local num=UIGongFaModel:getGongFaProgressByElement(0)
local preinfo=toColorString(FONT_COLOR.eOrangeDescColor,"已收集功法：")
local info=FMT.fmt('{0}{1}',preinfo,num)
return info
end,
}

local comonInfoFunc=function(data,bdData)
local proSkillID=cfgHelper.get2(cfg_monijybuildconfig_get,data.buildID,'pro_skill_id')
local diziID=tonumber(tostring(bdData.dizi_id))
local isShowProSkillInfo=diziID>0 and proSkillID~=nil
local isManager=cfgHelper.get2(cfg_monijybuildconfig_get,data.buildID,'is_manage')
if isManager==1 then
if isShowProSkillInfo then
local jobLevel=UIDiscipleModel:getDiscipleJobLevel(bdData.dizi_id,proSkillID)
local jobName=UIDiscipleModel:getDiscipleJobName(proSkillID)
local preStr=toColorString(FONT_COLOR.eOrangeDescColor,FMT.fmt("弟子{0}等级：",jobName))
local proSKillInfo=FMT.fmt("{0}{1}",preStr,jobLevel)
return proSKillInfo
else
return'暂无弟子进驻'
end
else
return""
end
end

local spNameFuncList={
[SLG_SYSTEM_TYPE.eXuanShangTai]=function(data,bdData)
local bdName=cfgHelper.get2(cfg_monijybuildconfig_get,data.buildID,'name')
local num=UIXuanShangControl:getXuanShangLevel()
local info=FMT.fmt('{0}级{1}',num,bdName)
return info
end,
}




function UIProsperity_DetailsInfoWin:onLoaded(...)
self:bindComponents()

_this=self

self.menuSelectIndex=1

self.infoScrollView:bindScrollWidget(function(...)self:bindProsperityItem(...)end)
end


function UIProsperity_DetailsInfoWin:__delete()
self:unbindComponents()

_this=nil


end




function UIProsperity_DetailsInfoWin:onShow(argtable,afterOnloaded)

if argtable then
self.menuSelectIndex=argtable.index or 1
end

self:initUI()

if afterOnloaded then
self:showMenuAnimation()
end
end


function UIProsperity_DetailsInfoWin:onHide()

end

function UIProsperity_DetailsInfoWin:showMenuAnimation()
self.animLock1=nil
self:clearMenuTweener()
self.menuSpineList:setChildCanvasGroupAlpha(0)
self.menuList:setChildCanvasGroupAlpha(0)

local func=function()
self.menuSpineList:setChildCanvasGroupAlpha(1)
local selectMenuIdx=self.menuSelectIndex
for i,v in ipairs(self.menu_anim)do
local isshow=i<=#menuDataList
local anim=self.menu_anim[i]
local func2=function()
if isshow then
self:changeMenuItemState(i,selectMenuIdx==i,false)
end
end

anim:setChildUIModelShowTarget(body_id.menu,1,{},eAnimationID.common_window_enter,false,false,0,func2)
anim:setActive(isshow)
end
end
self:delayDo(0.1,func)
self.animLock1=true
local func1=function()
self.animLock1=nil
self.menuList:setChildCanvasGroupAlpha(0)
local fun3=function()
self.menuTweener=nil
end
self.menuTweener=self.menuList:setChildCanvasGroupDOFade(1,1,fun3)
end
func1()
end

function UIProsperity_DetailsInfoWin:clearMenuTweener()
if self.menuTweener~=nil then
self.menuTweener:Complete()
self.menuTweener=nil
end
end

function UIProsperity_DetailsInfoWin:changeMenuItemState(index,state,isAnim)





local item=self.menu_anim[index]

if isAnim then
item:setChildModelAnimationState(eAnimationID.common_window_enter,1,nil)
end


local name
if state then
name=FMT.fmt("{0}_{1}",menu_slot_name,2)
else
name=FMT.fmt("{0}_{1}",menu_slot_name,1)
end

self.winlua:SetChildUIModelShowSlotAttachment(item:getID(),menu_slot_name,name)

end

function UIProsperity_DetailsInfoWin:initUI()

self:refreshMenuList()


self:refreshLeftPart()
end


function UIProsperity_DetailsInfoWin:refreshMenuList()
self.menuList:setChildLayoutGroupCreateItems(#menuDataList,function(index)
local data=menuDataList[index]
local item=self.menuList:getChildLayoutGroupGridItem(index-1)

item:SetChildActive(-1,data~=nil)

if data then
item:SetChildText(0,data.name)
item:SetBaseItemClickEvent(-1,function()
if self.menuSelectIndex~=index then
self:changeMenuItemState(self.menuSelectIndex,false)

self.menuSelectIndex=index
self:changeMenuItemState(index,true,true)

self:refreshLeftPart()
end
end)
end
end)
end

function UIProsperity_DetailsInfoWin:refreshLeftPart()
self.buildingFrdDatas=menuDataList[self.menuSelectIndex].getMenuPanelData()

local list={}
for k,v in ipairs(self.buildingFrdDatas)do
local bdData=zongmenModel:getBuildingData(v.unBuildID)
if bdData~=nil then
table.insert(list,v)
end
end


table.sort(self.buildingFrdDatas,function(b1,b2)
return b1.totalFR<b2.totalFR
end)

local len=#self.buildingFrdDatas

self.infoScrollView:clearItems()
self.infoScrollView:freshGridsNum(len,Mathf.Ceil(len/2),2,false)
end


function UIProsperity_DetailsInfoWin:bindProsperityItem(index,item)
local data=self.buildingFrdDatas[index]



local isShow=data~=nil
if isShow then
local bdData=zongmenModel:getBuildingData(data.unBuildID)
isShow=isShow and bdData~=nil
if isShow then

local bdIcon=cfgHelper.get2(cfg_monijybuildconfig_get,data.buildID,'icon')
item:SetChildIcon(CmpProsperityItemIndex.icon,bdIcon,true)

local bdName=cfgHelper.get2(cfg_monijybuildconfig_get,data.buildID,'name')
local bdLvCfgList=cfgHelper.get1(cfg_monijybuilduplvlconfig_get,data.buildID)
local info=bdName
if bdLvCfgList and bdLvCfgList[2]~=nil then
info=FMT.fmt("{0}级{1}",bdData.level,bdName)
end

if spNameFuncList[data.buildID]then
info=spNameFuncList[data.buildID](data,bdData)
end

item:SetChildText(CmpProsperityItemIndex.info,info)

local totalFR=Mathf.Floor(data.totalFR+0.00001)
local pInfo=FMT.fmt("{0}{1}",toColorString(FONT_COLOR.eOrangeDescColor,"繁荣："),totalFR)
item:SetChildText(CmpProsperityItemIndex.pInfo,pInfo)





local desc=""
if infoDescFuncList[data.buildID]then
local infoFunc=infoDescFuncList[data.buildID]
desc=infoFunc(data,bdData)
else
desc=comonInfoFunc(data,bdData)or""
end

item:SetChildText(CmpProsperityItemIndex.dzSkillInfo,desc)



local noJumpBuildingList=cfgHelper.getdef1(cfg_guildabundanceconfig,'no_jump_building_list')
local isNonShowGoBtn=table.findValue(noJumpBuildingList,data.buildID)
item:SetChildActive(CmpProsperityItemIndex.goBtn,not isNonShowGoBtn)

item:SetChildButtonClick(CmpProsperityItemIndex.goBtn,function()
if isometricMapSystem:checkLinkRoad(bdData,true)then
if bdData.build_id==SLG_SYSTEM_TYPE.eXianZhan then
jumpManager:jump({id=JUMP_TYPE.eXianZhan,args={type=bdData.build_id,args={un_build_id=bdData.un_build_id}}})
else
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=bdData.build_id,args={un_build_id=bdData.un_build_id}}})
end
end
end,true)
end
end
item:SetChildActive(-1,isShow)
end





function UIProsperity_DetailsInfoWin:onCloseBtn()
self:closeSelf()
end

