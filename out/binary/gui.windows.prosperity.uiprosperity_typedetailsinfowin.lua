







def_class("UIProsperity_TypeDetailsInfoWin",UIWindowBase)









function UIProsperity_TypeDetailsInfoWin:bindComponents()

self.Root=UIObject.get(self,0)
self.uiRoot=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.infoScrollView=UIScrollView.get(self,3)
self.infoList=UIObject.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIProsperity_TypeDetailsInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.infoScrollView);self.infoScrollView=nil;
_UIObject_release(self.infoList);self.infoList=nil;
end
















local CmpProsperityItemIndex={
icon=0,
info=1,
pInfo=2,
dzSkillInfo=3,
goBtn=4,
btntxt=5,
}




function UIProsperity_TypeDetailsInfoWin:onLoaded(...)
self:bindComponents()

self.infoScrollView:bindScrollWidget(function(...)self:bindProsperityItem(...)end)
end


function UIProsperity_TypeDetailsInfoWin:__delete()
self:unbindComponents()
end




function UIProsperity_TypeDetailsInfoWin:onShow(argtable,afterOnloaded)
self.typeList=argtable and argtable.typeList

self:initUI()
end


function UIProsperity_TypeDetailsInfoWin:onHide()

end

function UIProsperity_TypeDetailsInfoWin:initUI()

self:refreshLeftPart()
end

function UIProsperity_TypeDetailsInfoWin:refreshLeftPart()
self.buildingFrdDatas=prosperityModel:getBuildingProsperityByTypeList(self.typeList)

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

function UIProsperity_TypeDetailsInfoWin:bindProsperityItem(index,item)
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
item:SetChildText(CmpProsperityItemIndex.info,info)

local totalFR=Mathf.Floor(data.totalFR+0.00001)
local pInfo=FMT.fmt("{0}{1}",toColorString(FONT_COLOR.eOrangeDescColor,"繁荣："),totalFR)
item:SetChildText(CmpProsperityItemIndex.pInfo,pInfo)

local proSkillID=cfgHelper.get2(cfg_monijybuildconfig_get,data.buildID,'pro_skill_id')
local diziID=tonumber(tostring(bdData.dizi_id))
local isShowProSkillInfo=diziID>0 and proSkillID~=nil
item:SetChildActive(CmpProsperityItemIndex.dzSkillInfo,isShowProSkillInfo)

if isShowProSkillInfo then
local jobLevel=UIDiscipleModel:getDiscipleJobLevel(bdData.dizi_id,proSkillID)
local jobName=UIDiscipleModel:getDiscipleJobName(proSkillID)
local preStr=toColorString(FONT_COLOR.eOrangeDescColor,FMT.fmt("弟子{0}等级：",jobName))
local proSKillInfo=FMT.fmt("{0}{1}",preStr,jobLevel)
item:SetChildText(CmpProsperityItemIndex.dzSkillInfo,proSKillInfo)
end

local noJumpBuildingList=cfgHelper.getdef1(cfg_guildabundanceconfig,'no_jump_building_list')
local isNonShowGoBtn=table.findValue(noJumpBuildingList,data.buildID)
item:SetChildActive(CmpProsperityItemIndex.goBtn,not isNonShowGoBtn)

item:SetChildButtonClick(CmpProsperityItemIndex.goBtn,function()
if isometricMapSystem:checkLinkRoad(bdData,true)then
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=bdData.build_id,args={un_build_id=bdData.un_build_id}}})
end
end,true)
end
end
item:SetChildActive(-1,isShow)
end





function UIProsperity_TypeDetailsInfoWin:onCloseBtn()
self:closeSelf()
end

