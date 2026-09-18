







def_class("UIWorldMonsterListWin",UIWindowBase)









function UIWorldMonsterListWin:bindComponents()

self.hideButton=UIButton.get(self,0)
self.huntBtn=UIButton.get(self,1)
self.huntIcon1=UIObject.get(self,2)
self.huntIcon0=UIObject.get(self,3)
self.huntIcon2=UIObject.get(self,4)
self.huntIcon3=UIObject.get(self,5)
self.huntTextBg=UIObject.get(self,6)
self.hurtReddot=UIObject.get(self,7)
self.huntText=UIText.get(self,8)
self.CSGUIScrollView=UIComboScrollView.get(self,9)
self.monsterListPanel=UIObject.get(self,10)
self.NullTxt=UIText.get(self,11)
self.CDTxt=UIText.get(self,12)
self.uiRoot=UIObject.get(self,13)
self.root=UIObject.get(self,14)

self.hideButton:setButtonClick(function()self:onHideButton()end)

self.huntBtn:setButtonClick(function()self:onHuntBtn()end)



end


function UIWorldMonsterListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.hideButton);self.hideButton=nil;
_UIObject_release(self.huntBtn);self.huntBtn=nil;
_UIObject_release(self.huntIcon1);self.huntIcon1=nil;
_UIObject_release(self.huntIcon0);self.huntIcon0=nil;
_UIObject_release(self.huntIcon2);self.huntIcon2=nil;
_UIObject_release(self.huntIcon3);self.huntIcon3=nil;
_UIObject_release(self.huntTextBg);self.huntTextBg=nil;
_UIObject_release(self.hurtReddot);self.hurtReddot=nil;
_UIObject_release(self.huntText);self.huntText=nil;
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.monsterListPanel);self.monsterListPanel=nil;
_UIObject_release(self.NullTxt);self.NullTxt=nil;
_UIObject_release(self.CDTxt);self.CDTxt=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.root);self.root=nil;
end



















local selectMonster=nil

local _iconAb="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _iconBg={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_7",
}
local _iconTag={

[monType.EliteMonster]="icon_gwbz_3",
[monType.Boss]="icon_gwbz_2",
[monType.GodAnimal]="icon_gwbz_1",
}

local main_index=
{
name=0,
item=1,
jiantou1=2,
jiantou2=3,
reddot=4,
fighting=5,
reward=6,
}

local _this=nil


function UIWorldMonsterListWin:onLoaded(...)
self:bindComponents()
_this=self
local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.CSGUIScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)
self.init=true

self.maxnum=cfgHelper.get1(cfg_worldmonsterconfig_get,1).maxnum

self:addNotify(notifyConfig.onHuntMonsterTeamSelectMonsterChange,self.onHuntMonsterTeamSelectMonsterChange)
self:addNotify(notifyConfig.onHuntMonsterTeamSelectWorldChange,self.onHuntMonsterTeamSelectWorldChange)
self:addNotify(notifyConfig.onHuntMonsterTeamStartTeam,self.onHuntMonsterTeamStartTeam)
self:addNotify(notifyConfig.onHuntMonsterTeamFight,self.onHuntMonsterTeamFight)
self:addNotify(notifyConfig.onHuntMonsterTeamEndTeam,self.onHuntMonsterTeamEndTeam)
end


function UIWorldMonsterListWin:__delete()
selectMonster=nil

self:unbindComponents()
_this=nil


end




function UIWorldMonsterListWin:onShow(argtable,afterOnloaded)



self.winlua:SwitchChildParent(self.root:getID(),worldController:isInWorld()and-1 or self.uiRoot:getID(),false)

self:refreshUI(argtable)
self:refreshHunt(true)

if argtable and argtable.showhunt then
local worldData=self.groupList[self.mainIndex]
local world=worldData.world
huntMonsterTeamController:openShowWin(world)
self:refreshAllSubItemHunt()
self:refreshTime()
end
end


function UIWorldMonsterListWin:onHide()
self:closeWindow("UIWorldMonsterHurtTeamWin")
self.mainIndex=nil
end





function UIWorldMonsterListWin:updateData()

self.lastStamp=worldMonsterModel:get_last_stamp()

local monsterList=worldMonsterModel:get_unlock_block_monster_list()or{}
local respointList=worldResPointDataModel:get_monster_list()

self.list={}
for i,v in ipairs(monsterList)do
local mCfg=worldMonsterModel.get_monster_group(v.worldMonsterId)
local key=worldModel:convertUnitKey({eWorldUnitTpye.MONSTER,tostring(v.guid)})
table.insert(self.list,{
type=eWorldUnitTpye.MONSTER,
id=v.worldMonsterId,
guid=v.guid,
level=v.level,
world=v.worldId,
monType=mCfg.monType,
sort1=mCfg.monType*10000+v.level,
key=key,
sort2=huntMonsterTeamModel:findMonsterWorld(key)and huntMonsterTeamModel:findTeamMonsterIndexEx(v.worldId,key)or 10000
})
end
for i,v in ipairs(respointList)do
local respointCfg=cfgHelper.get1(cfg_worldresbattleconfig_get,v.id)
local mCfg=cfgHelper.get1(cfg_monstergroup_get,respointCfg.groupid)
local key=worldModel:convertUnitKey({eWorldUnitTpye.RESPOINT,v.guid})
table.insert(self.list,{
type=eWorldUnitTpye.RESPOINT,
id=v.id,
guid=v.guid,
level=v.level,
world=v.world,
monType=mCfg.monType,
sort1=mCfg.monType*10000+v.level,
key=key,
sort2=huntMonsterTeamModel:findMonsterWorld(key)and huntMonsterTeamModel:findTeamMonsterIndexEx(v.world,key)or 10000
})
end
table.sort(self.list,function(a,b)
if a.sort2~=b.sort2 then
return a.sort2<b.sort2
else
return a.sort1>b.sort1
end
end)

self.curWorldIndex=nil
self.groupList={}
local gList={}
for i,v in ipairs(self.list)do
gList[v.world]=gList[v.world]or{}
table.insert(gList[v.world],v)
end

local cfg=cfg_worldconfig()
for worldid,worldCfg in pairs(cfg)do
if worldBlockModel:getWorldStateCount(worldid,eWorldBlockState.OPEN)>0 then
table.insert(self.groupList,{world=worldid,list=gList[worldid]or{}})
if worldModel:isSameWorld(worldid)then
self.curWorldIndex=#self.groupList
end
end
end
end



function UIWorldMonsterListWin:refreshUI(argtable)
self:updateData()
self:refreshList(argtable)
self:refreshTime()
end


function UIWorldMonsterListWin:refreshList(argtable)

if next(self.groupList)then
self.CSGUIScrollView:setActive(true)
self.NullTxt:setActive(false)
if not self.init then

self.showType=nil
self.selectMainItem=nil
self.CSGUIScrollView:removeAllGrids()
end

self.CSGUIScrollView:createMainGrids(#self.groupList,1,true)


else
self.CSGUIScrollView:setActive(false)
self.NullTxt:setActive(true)
end
self.init=false

if argtable and argtable.world then
for i,v in ipairs(self.groupList)do
if v.world==argtable.world then
if self.mainIndex~=i then
self.CSGUIScrollView:clickItem(i-1)
return
end
end
end
end

if self.mainIndex then
self.CSGUIScrollView:clickItem(self.mainIndex-1)
else

if self.curWorldIndex then
self.CSGUIScrollView:clickItem(self.curWorldIndex-1)
else
self.CSGUIScrollView:clickItem(0)
end

end
end

function UIWorldMonsterListWin:setItem(item,monsterId,monsternName,monsterType,level,monsterModel,spe)
item:SetChildText(0,monsternName)
item:SetChildText(1,UIDiscipleModel.getJJNameCommon(level,3))

local body=monsterModel[1]
local components=monsterModel[3]or{}
local headOffset=monsterModel[4]or{0,0,0.7}
comHelper.setChildModelRawImage_monsterGroup(item,monsterId,2,0,eHeadCenterType.eHead)
item:SetChildActive(3,false)
if _iconBg[monsterType]then
item:SetChildCSImageSprite(4,_iconAb,_iconBg[monsterType])
else
item:SetChildCSImageIcon(4,nil,true)
end
item:SetChildActive(5,spe)

if _iconTag[monsterType]then
item:SetChildCSImageSprite(6,_iconAb,_iconTag[monsterType])
else
item:SetChildCSImageIcon(6,nil,true)
end
end

function UIWorldMonsterListWin:refreshMainItem(mainIndex)
if mainIndex then
local worldMystery=self.groupList[mainIndex]
local num=worldMystery and#worldMystery.list or 0
self.CSGUIScrollView:rebuildSubItems(mainIndex-1,num,nil)
end
end

function UIWorldMonsterListWin:setMainItemHunt(mainItem,world)
local teamData=huntMonsterTeamModel:getTeamData(world)
mainItem:SetChildActive(main_index.fighting,teamData~=nil)
if teamData then
local reward=huntMonsterTeamModel:isTeamComplete(teamData)
mainItem:SetChildActive(main_index.reddot,reward)
mainItem:SetChildActive(main_index.reward,reward)
else
mainItem:SetChildActive(main_index.reddot,false)
mainItem:SetChildActive(main_index.reward,false)
end
end

function UIWorldMonsterListWin:mainClickAction(mainItem)
local lastMainItem=self.selectMainItem
local index=mainItem.Index+1
self.mainIndex=index
local isExpanded=self.showType==index
if isExpanded then
self.selectMainItem=mainItem
end
mainItem:SetChildActive(main_index.jiantou1,not isExpanded)
mainItem:SetChildActive(main_index.jiantou2,isExpanded)
if lastMainItem~=nil and lastMainItem.Index~=mainItem.Index then
self:mainClickAction(lastMainItem)

local worldData=self.groupList[self.mainIndex]
huntMonsterTeamController:refreshShowWin(worldData.world)
self:refreshHunt()
end
end

function UIWorldMonsterListWin:subClickAction(subItem)
local lastSubItem=self.selectSubItem
local index=subItem.Index+1

self.subIndex=index
self.selectSubItem=subItem

local mainIndex=subItem.Mainindex+1
local worldMystery=self.groupList[mainIndex]
local gdata=worldMystery.list[index]

local huntToggle=huntMonsterTeamController:isToggleShowWin()
if huntToggle then

AudioManager.playBtnClick()
local world=worldMystery.world
local teamData=huntMonsterTeamModel:getTeamData(world)
if not teamData then
if not huntMonsterTeamModel:isSelectMonster(gdata.key)then
huntMonsterTeamController:addSelectMonster(gdata.key,world)
else
huntMonsterTeamController:removeSelectMonster(gdata.key)
end

else
UIManager.info("猎妖队狩猎中，请稍后")
end
return
end


if lastSubItem then
lastSubItem:SetChildActive(3,false)
end
subItem:SetChildActive(3,true)


local cPos=worldController:getCameraPosition()
local d=gdata

if d.type==eWorldUnitTpye.MONSTER then
local data=worldMonsterModel:findSortMonster_ByGUID(d.guid)
local key=d.key
local toKey=worldTaskModel:findTaskKey_ByTargetProgress(key,eWorldTripProgress.Go)
local workKey=worldTaskModel:findTaskKey_ByTargetProgress(key,eWorldTripProgress.Work)
if toKey or workKey then
worldController:lookAtUnit(key)
return UIManager.info("队伍正在前往的路上")
end
local areaConfig=worldMonsterModel.get_area_config(data.areaId)
if worldModel:isSameWorld(areaConfig.world)then
local minZoom=worldController:getCameraZoomRange_Normal()[1]
worldController:lookAtUnit(key,minZoom,false,function()
if huntMonsterTeamModel:findMonsterWorld(key)then
UIManager.info("猎妖队狩猎中，请稍后")
return
end
worldMonsterController.showInfoWin(data,cPos.y)
end)
else



local worldName=cfgHelper.get2(cfg_worldconfig_get,areaConfig.world,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local args={clickUnit=key}
worldController:enterWorld(areaConfig.world,args)
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end
else
local data=d
local t=string.split(data.guid,'_')
local guid=int64.new(t[1])
local subIndx=tonumber(t[2])
local key=data.key
if worldTaskModel:findLastTaskKey_ByTarget(key)then
worldController:lookAtUnit(key)
return UIManager.info("队伍正在前往的路上")
end
if worldModel:isSameWorld(data.world)then
worldResPointController:onClickUnit_Monster(guid,subIndx,data.id)
else
local worldName=cfgHelper.get2(cfg_worldconfig_get,data.world,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local args={clickUnit=key}
worldController:enterWorld(data.world,args)
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()

end
end
end

function UIWorldMonsterListWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local worldData=self.groupList[index]

if worldData then
local widget=mainItem
local world=worldData.world
local name=cfgHelper.get(cfg_worldconfig_get,world,"name")
widget:SetChildText(main_index.name,name)
local isExpanded=self.showType==index
mainItem:SetChildActive(main_index.jiantou1,isExpanded)
mainItem:SetChildActive(main_index.jiantou2,not isExpanded)
local num=#worldData.list

widget:SetAddExpandColumCount(num)

self:setMainItemHunt(mainItem,world)
end
end

function UIWorldMonsterListWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1

local worldData=self.groupList[mainIndex]
local world=worldData.world
local data=worldData.list[index]

local item=subItem
subItem:SetChildNewBieComponentId(-1,FMT.fmt('UIWorldMonsterListWin.UIWorldMonsterListItem.{0}',index))
if data.type==eWorldUnitTpye.MONSTER then
local monsterGroupCfg=worldMonsterModel.get_monster_group_config(data.id)
local mCfg=worldMonsterModel.get_monster_group(data.id)
local level=mCfg.levelUp and data.level or mCfg.level
self:setItem(item,mCfg.id,monsterGroupCfg.name,mCfg.monType,level,mCfg.model,false)
else
local respointCfg=cfgHelper.get1(cfg_worldresbattleconfig_get,data.id)
local mCfg=cfgHelper.get1(cfg_monstergroup_get,respointCfg.groupid)
if mCfg then
self:setItem(item,respointCfg.groupid,mCfg.name,mCfg.monType,data.level,mCfg.model,false)
else
loggerUtil.logErrFMT("资源点没有怪物配置{0}",data.id,respointCfg.groupid)
end
end

self:setItemHunt(subItem,world,data)
end

function UIWorldMonsterListWin:setItemHunt(subItem,world,data,toggle)
local open=systemModel.isOpen(SYSTEM_DEFINE.eHuntMonsterTeam)
subItem:SetChildActive(7,open)
if open and data then
local teamData=huntMonsterTeamModel:getTeamData(world)
if teamData then
if huntMonsterTeamModel:findMonsterWorld(data.key)then
local current=huntMonsterTeamModel:isCurrentMonster(teamData,data.key)
subItem:SetChildActive(8,current)
subItem:SetChildActive(9,not current)
else
subItem:SetChildActive(8,false)
subItem:SetChildActive(9,false)
end
subItem:SetChildActive(10,false)
else
if toggle==nil then
toggle=huntMonsterTeamController:isSelectedWorld()
end
subItem:SetChildActive(8,false)
subItem:SetChildActive(9,false)
subItem:SetChildActive(10,toggle)
if toggle then
subItem:SetChildActive(11,huntMonsterTeamModel:isSelectMonster(data.key))
end
end
end
end


function UIWorldMonsterListWin:onExpandAction(index)
self.subIndex=nil
if index>=0 then
self.showType=index+1
else
self.showType=nil
end
end

function UIWorldMonsterListWin:refreshTime()
local huntToggle=huntMonsterTeamController:isToggleShowWin()
if huntToggle and self.mainIndex then
local worldData=self.groupList[self.mainIndex]
local teamData=huntMonsterTeamModel:getTeamData(worldData.world)
if teamData then
if not huntMonsterTeamModel:isTeamStop(teamData)and not huntMonsterTeamModel:isTeamComplete(teamData)then
local cur=teamData.progress-1
local max=#teamData.monsters
local str=FMT.fmt("已狩猎妖怪：{0}/{1}",cur,max)
self.CDTxt:setText(str)
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
return
end
else
local cur=huntMonsterTeamModel:getSelectMonsterCount()
local max=huntMonsterTeamModel:getWorldMaxNum(worldData.world)
local str=FMT.fmt("已选妖怪：{0}/{1}",cur,max)
self.CDTxt:setText(str)
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
return
end
end

local isE,max=self:isEnough()
if isE or self.lastStamp<=-1 then
self.CDTxt:setText("妖怪数量已达上限")
else
self:timerHandler()
if not self.timer then
self.timer=self:setTimer(1,0,function()self:timerHandler()end)
end
end
end

function UIWorldMonsterListWin:isEnough()
local allMonsterList=worldMonsterModel:get_monster_sort_list()
if not allMonsterList then
return false
end
local maxnum=cfgHelper.get1(cfg_worldmonsterconfig_get,1).maxnum
local areaconfig=cfg_worldmonsterareaconfig()
if#allMonsterList>=maxnum then
return true,maxnum
else
local areaList=worldMonsterModel:get_monster_sort_list()
local areaData=worldMonsterModel:getOpenAreas()
local areaMax=maxnum
for i,v in ipairs(areaData)do
local num=areaList[v]and#areaList[v]or 0
if num<areaconfig[v].max then
if#areaData>1 then
return false,maxnum
else
return false,areaconfig[v].max
end
else
areaMax=areaconfig[v].max
end
end
return true,areaMax
end
end

function UIWorldMonsterListWin:timerHandler(...)
if not self.lastStamp then
return
end
local cd=self.lastStamp+worldMonsterModel.get_fresh_time_with_buff()-timeHelper.getServerShortTime()
local isE,max=self:isEnough()
if isE or self.lastStamp<=-1 then
self.CDTxt:setText("妖怪数量已达上限")

else
if cd>0 then
local time=timeHelper.format_time_stamp(cd)
self.CDTxt:setText(FMT.fmt("妖怪出现倒计时：{0}",FMT.cfmt(FONT_COLOR.eGreenColor,"{0}",time)))
else
self.CDTxt:setText("")



worldMonsterProtocolController.req_fresh()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end
end
end

function UIWorldMonsterListWin:findGroupListIndex(world)
for i,v in ipairs(_this.groupList)do
if v.world==world then
return i
end
end
end



function UIWorldMonsterListWin:onHideButton()
worldController:resetLeftView()
end


function UIWorldMonsterListWin:refreshHunt(init)
self.openHunt=systemModel.isOpen(SYSTEM_DEFINE.eHuntMonsterTeam)
self.huntBtn:setActive(self.openHunt)
if init then
self.CDTxt:setChildAnchoredPos(self.openHunt and-25 or 0,0)
end
if self.openHunt then
self:refreshHuntContent()
end
end

function UIWorldMonsterListWin:refreshHuntContent()
if not self.openHunt then
return
end
if self.mainIndex then
local worldData=self.groupList[self.mainIndex]
local worldId=worldData.world
local open=huntMonsterTeamModel:getWorldMaxNum(worldId)>0
if not open then
self.huntIcon0:setActive(true)
self.huntIcon1:setActive(true)
self.huntIcon2:setActive(false)
self.hurtReddot:setActive(false)
self.huntTextBg:setActive(false)
return
end

newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.FirstTriggerHuntMonsterTeam)

local teamData=huntMonsterTeamModel:getTeamData(worldId)
self.huntTextBg:setActive(true)
self.huntIcon0:setActive(false)
if teamData then
local reddot=huntMonsterTeamModel:isTeamComplete(teamData)
local str=reddot and"<color=#F36666>完成狩猎</color>"or"<color=#F5B855>狩猎中</color>"
self.huntIcon1:setActive(false)
self.huntIcon3:setActive(not reddot)
self.huntIcon2:setActive(reddot)
self.hurtReddot:setActive(reddot)
self.huntText:setText(str)
else
self.huntIcon1:setActive(true)
self.huntIcon2:setActive(false)
self.huntIcon3:setActive(false)
self.hurtReddot:setActive(false)
self.huntText:setText("<color=#A1EC58>等待狩猎</color>")
end
end
end

function UIWorldMonsterListWin:onHuntBtn()
if worldController:isInWorld()then
worldController:resetRightView()
end
local worldData=self.groupList[self.mainIndex]
huntMonsterTeamController:onToggleShowWin(worldData.world)
end

function UIWorldMonsterListWin:refreshAllSubItemHunt()
local subItems=self.CSGUIScrollView:getSubItemsList()
local worldData=self.groupList[self.mainIndex]
local world=worldData.world
for i=1,subItems.Count do
local subItem=subItems[i-1]
local data=worldData.list[i]
self:setItemHunt(subItem,world,data)
end
end

function UIWorldMonsterListWin:refreshAllSubItemHuntEx(limit)
local subItems=self.CSGUIScrollView:getSubItemsList()
local worldData=self.groupList[self.mainIndex]
local world=worldData.world
for i=1,subItems.Count do
local subItem=subItems[i-1]
local data=worldData.list[i]
if table.containsValue(limit,data.key)then
self:setItemHunt(subItem,world,data)
end
end
end

function UIWorldMonsterListWin.onHuntMonsterTeamSelectMonsterChange(cType,cList)
if _this==nil or _this.isClose then return end
_this:refreshAllSubItemHuntEx(cList)
_this:refreshTime()
end

function UIWorldMonsterListWin.onHuntMonsterTeamSelectWorldChange(world)
if _this==nil or _this.isClose then return end
local worldData=_this.groupList[_this.mainIndex]
if world<=0 or world==worldData.world then
_this:refreshAllSubItemHunt()
_this:refreshTime()
end
if world<=0 then
_this:refreshHuntContent()
end
end

function UIWorldMonsterListWin.onHuntMonsterTeamStartTeam(world)
if _this==nil or _this.isClose then return end





_this:refreshUI()
_this:refreshHuntContent()

end

function UIWorldMonsterListWin.onHuntMonsterTeamFight(result,world,unitKey)
if _this==nil or _this.isClose then return end





_this:refreshUI()
_this:refreshHuntContent()

end

function UIWorldMonsterListWin.onHuntMonsterTeamEndTeam(world)
if _this==nil or _this.isClose then return end





_this:refreshUI()
_this:refreshHuntContent()

end
