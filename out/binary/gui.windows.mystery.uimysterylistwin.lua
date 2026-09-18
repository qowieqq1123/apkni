







def_class("UIMysteryListWin",UIWindowBase)









function UIMysteryListWin:bindComponents()

self.hideButton=UIButton.get(self,0)
self.MainContent=UIObject.get(self,1)
self.CSGUIScrollView=UIComboScrollView.get(self,2)
self.fbListPanel=UIObject.get(self,3)
self.NullTxt=UIText.get(self,4)
self.NullImg=UIObject.get(self,5)
self.CDTxt=UIText.get(self,6)
self.uiRoot=UIObject.get(self,7)
self.root=UIObject.get(self,8)

self.hideButton:setButtonClick(function()self:onHideButton()end)



end


function UIMysteryListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.hideButton);self.hideButton=nil;
_UIObject_release(self.MainContent);self.MainContent=nil;
_UIObject_release(self.CSGUIScrollView);self.CSGUIScrollView=nil;
_UIObject_release(self.fbListPanel);self.fbListPanel=nil;
_UIObject_release(self.NullTxt);self.NullTxt=nil;
_UIObject_release(self.NullImg);self.NullImg=nil;
_UIObject_release(self.CDTxt);self.CDTxt=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
_UIObject_release(self.root);self.root=nil;
end

















local main_index=
{
name=0,
item=1,
jiantou1=2,
jiantou2=3,
reddot=4,
}
local bqabName="ui/windows/mystery/sharedtextures/mysterylistsprite.ab"
local refreshFunc=
{
["refreshCommonItem"]=function(self,subItem,mainIndex,index,data)
if data then
subItem:SetChildActive(3,self.subIndex==index)
subItem:SetChildActive(11,true)
subItem:SetChildActive(12,false)
local cfg_fb=cfg_secretscenefubenconfig_get(data.id)
if cfg_fb then
local fbid=data.id
local difficulty_text_color=cfg_secretscenebaseconfig_get(1).fb_quality
local color_cfg=difficulty_text_color[cfg_fb.color]
local colorStr=color_cfg[2]
local fbName=cfg_fb.name
subItem:SetChildText(0,colorStr and FMT.fmt("<color=#{0}>{1}</color>",colorStr,fbName)or fbName)
local percent=MysteryModel:getPercentListData(fbid)or data.percent
subItem:SetChildText(1,FMT.fmt("{0}%",percent))
subItem:SetChildCSImageIcon(2,cfg_fb.image,false)
subItem:SetChildActive(3,false)

local biaoqian=cfg_fb.mjShowType

subItem:SetChildActive(5,biaoqian~=nil)
subItem:SetChildCSImageSprite(5,bqabName,FMT.fmt("icon_dsjmijingtp_{0}",biaoqian))

local targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,fbid})
local taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)
if taskKey and data.tzStatus==1 then
local task=worldTaskModel:getTask(taskKey)
local discipleguid=task.disciples[1]
subItem:SetChildActive(4,true)
if UIDiscipleModel:getDiscipleData(discipleguid)then
comHelper.setChildModelRawImage(subItem,discipleguid,8,0,eHeadCenterType.eHead,0.7)
end
else
subItem:SetChildActive(4,false)
end
local senceType=MysteryModel:get_mystery_sence_type(data.id)
if senceType==MysterySenceType.ResPoint then
local resPoint,guid,subIdx=worldResPointDataModel:findMysteryData(data.id)
if resPoint then
local worldName=cfgHelper.get2(cfg_worldconfig_get,resPoint.world,'name')
subItem:SetChildText(6,worldName)
else
subItem:SetChildText(6,'')
end
elseif senceType==MysterySenceType.ZongMen then
subItem:SetChildText(6,"宗门")
else
local posData=MysteryModel:get_mysteryFB_unit(fbid)
if posData then
local worldName=cfgHelper.get2(cfg_worldconfig_get,posData[1],'name')
subItem:SetChildText(6,worldName)
else
subItem:SetChildText(6,'')
end
end
end

local ndLevel=data.ndLevel
local fixedJingJie=cfg_fb.fixedJingJie
if fixedJingJie then
ndLevel=fixedJingJie
end


subItem:SetChildNewBieComponentId(-1,FMT.fmt('UIMysteryListWin.MapListItem.{0}',index))
subItem:SetChildActive(10,false)


subItem:SetChildGray(2,false)
subItem:SetChildActive(2,false)
subItem:SetChildActive(2,true)

subItem:SetChildActive(7,true)
subItem:SetChildActive(16,false)
end
end,
["refreshRandomItem"]=function(self,subItem,mainIndex,index,data)
if data then
subItem:SetChildActive(3,self.subIndex==index)
subItem:SetChildActive(11,true)
subItem:SetChildActive(12,false)
local fbData=mysteryZiYuanFuBenModel:getGroupFbData(index)

local config=data[fbData.curId]

local fbName=config.name
subItem:SetChildText(0,fbName)
local curLayer=mysteryZiYuanFuBenModel:getCurLayer(index)
local mijingId=config.mjGroup[curLayer]
local biaoqian=config.mjShowType
local worldBlock=config.worldBlock
subItem:SetChildActive(5,biaoqian~=nil)
subItem:SetChildCSImageSprite(5,bqabName,FMT.fmt("icon_dsjmijingtp_{0}",biaoqian))

subItem:SetChildCSImageIcon(2,config.image,false)
subItem:SetChildActive(3,false)

local worldName=cfgHelper.get2(cfg_worldconfig_get,worldBlock[1],'name')
subItem:SetChildText(6,worldName)

if mijingId then

local jindu=mysteryZiYuanFuBenModel:getZiYuanMysteryJinDu(index,curLayer)
subItem:SetChildText(1,FMT.fmt("{0}%",jindu))
else
subItem:SetChildText(1,FMT.fmt("{0}%",0))
end
local ret=true
local cond=config.condition
local condStr=''
if cond then
local book_id=cond[1]
local index=cond[2]or 0
ret=zheXianLingModel:checkFinish(book_id,index)
local bookStr=mathHelper.numberToChinese(book_id)
if book_id and index>0 then
local chapterStr=mathHelper.numberToChinese(index)
condStr=FMT.fmt('完成谪仙令<color=#c82c2c>卷{0}·第{1}章</color>',bookStr,chapterStr)
else
condStr=FMT.fmt('完成谪仙令<color=#c82c2c>卷{0}</color>',bookStr)
end
end
if not ret then
subItem:SetChildText(6,condStr)
end
subItem:SetChildActive(10,not ret)
subItem:SetChildGray(2,not ret)
subItem:SetChildActive(7,ret)


if curLayer>0 then
local taskKey
local id=config.mjGroup[curLayer]
if id then
local targetKey=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,id})
taskKey=worldTaskModel:findTaskKey_ByTarget(targetKey)
end
local discipleguid
if taskKey then
local task=worldTaskModel:getTask(taskKey)
discipleguid=task.disciples[1]
else
local random_dis=UIDiscipleModel:getRandomDiscipleData()
discipleguid=random_dis.discipleguid
end

subItem:SetChildActive(4,true)
if UIDiscipleModel:getDiscipleData(discipleguid)then
comHelper.setChildModelRawImage(subItem,discipleguid,8,0,eHeadCenterType.eHead,0.7)
end
else
subItem:SetChildActive(4,false)
end

subItem:SetChildActive(16,mysteryZiYuanFuBenModel:checkPassButNotGetRewardzjMjId(index,fbData.curId))

subItem:SetChildNewBieComponentId(-1,FMT.fmt('UIMysteryListWin.MapListItem.{0}',index))
end
end,
["refreshXianDiItem"]=function(self,subItem,mainIndex,index,data)
subItem:SetChildActive(3,self.subIndex==index)
subItem:SetChildActive(11,false)
subItem:SetChildActive(12,true)
subItem:SetChildText(0,data.name)
subItem:SetChildCSImageIcon(2,data.icon,true)
subItem:SetChildActive(14,data.ing)
if data.ing then
subItem:SetChildCSImageSprite(14,iconHelper.globalSpriteBundle1,'image_tiaozhanzhong_1')
end

subItem:SetChildActive(15,true)
subItem:SetChildProgressValue(15,data.percent,100)
subItem:SetChildProgressText(15,FMT.fmt("{0}%",data.percent))


local posData=MysteryModel:get_mysteryFB_unit(data.id)
if posData then
local worldName=cfgHelper.get2(cfg_worldconfig_get,posData[1],'name')
subItem:SetChildText(6,worldName)
end
subItem:SetChildNewBieComponentId(-1,FMT.fmt('UIMysteryListWin.MapListItem.{0}',index))
end,
}

local onClickFunc=
{
["onCommonClick"]=function(self,subItem,mainIndex,index,data)
local lastSubItem=self.selectSubItem
local index=subItem.Index+1

self.subIndex=index
self.selectSubItem=subItem

local mystery=data


if lastSubItem then
lastSubItem:SetChildActive(3,false)
end
subItem:SetChildActive(3,true)


if mystery then
local senceType=MysteryModel:get_mystery_sence_type(data.id)

if senceType==MysterySenceType.ZongMen then
local showdata=
{
type='UIDialouge',
title='提示',
content='该秘境在宗门，是否前往探索？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)

local cfg_fb=cfgHelper.get(cfg_secretscenefubenconfig_get,data.id)
local sfId=cfg_fb.sceneParam[1]

local targetPos_x=cfg_fb.sceneParam[2]
local targetPos_y=cfg_fb.sceneParam[3]

local targetPram={cameraMoveTargetType.eZongmeng_pos,{targetPos_x,targetPos_y}}
local finishCallback=function(flag_)
if flag_ then
jumpManager:jump({id=JUMP_TYPE.eZongmenMystery,args={fbId=data.id}})
end
end
cameraMoveController:Begin({eSceneType.eZongmen,sfId},targetPram,finishCallback)
if not worldController:isInWorld()then
UIManager:closeWindow("UIWorldMapWinEx")
end
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
elseif senceType==MysterySenceType.ResPoint then
local resPoint,guid,subIdx=worldResPointDataModel:findMysteryData(data.id)
if resPoint then
if worldModel:isSameWorld(resPoint.world)then
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local unitData=worldController:getUnit(unitKey)
if unitKey then
worldController:lookAtUnit(unitKey)
end
if unitData then
worldController.onClickUnit(unitData.LuaData)
else

end
else
if worldController:isInWorld()then
if UIManager:isActive("UIMysteryEnterWin")then
UIManager:invokeUIMethod("UIMysteryEnterWin","onShow",{id=data.id})
else
worldController:changeRightView("UIMysteryEnterWin",{id=data.id})
end
else
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
self:onDialogJumpToWorld(resPoint.world,unitKey)
end
end
end
else
local posData=MysteryModel:get_mysteryFB_unit(data.id)
if posData then
if worldController:isInWorld()then
if worldModel:isSameWorld(posData[1])then
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,data.id})
if key then
worldController:lookAtUnit(key)
end
end
if UIManager:isActive("UIMysteryEnterWin")then
UIManager:invokeUIMethod("UIMysteryEnterWin","onShow",{id=data.id})
else
worldController:changeRightView("UIMysteryEnterWin",{id=data.id})
end
else
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,data.id})
self:onDialogJumpToWorld(posData[1],key)
end
end
end

end
end,
["ohRandomClick"]=function(self,subItem,mainIndex,index,data)
local lastSubItem=self.selectSubItem
local index=subItem.Index+1

self.subIndex=index
self.selectSubItem=subItem


if lastSubItem then
lastSubItem:SetChildActive(3,false)
end
subItem:SetChildActive(3,true)


local fbData=mysteryZiYuanFuBenModel:getGroupFbData(index)
local config=data[fbData.curId]
local tagTable={config.tagId,fbData.curId}
local key=table.concat(tagTable,'-')
local posData=mysteryZiYuanFuBenModel:get_mysteryFB_unit(key)

if posData then
if worldController:isInWorld()then
if worldModel:isSameWorld(posData[1])then
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.RESMYSTERY,key})
if key then
worldController:lookAtUnit(key)
end
else

end
if UIManager:isActive("UIMysteryEnterZiYuanWin")then
UIManager:invokeUIMethod("UIMysteryEnterZiYuanWin","onShow",tagTable)
else
worldController:changeRightView("UIMysteryEnterZiYuanWin",tagTable)
end
else
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.RESMYSTERY,key})
self:onDialogJumpToWorld(posData[1],key)
end
end
end,
["onXianDiClick"]=function(self,subItem,mainIndex,index,data)
mysteryWeekActivityController:openWeekEnterWin(data.guid)
end,
}



local m_CreateCD=nil

local selectFB=nil


function UIMysteryListWin:onLoaded(...)
self:bindComponents()

local _mainClickAction=function(...)self:mainClickAction(...)end
local _subClickAction=function(...)self:subClickAction(...)end
local _mainCreateAction=function(...)self:mainCreateAction(...)end
local _subCreateAction=function(...)self:subCreateAction(...)end
local _onExpandAction=function(...)self:onExpandAction(...)end
self.CSGUIScrollView:setAction(_mainClickAction,_subClickAction,_mainCreateAction,_subCreateAction,_onExpandAction)
self.init=true
local baseConfig=cfg_secretscenebaseconfig_get(1)
self.random_maptotal=baseConfig.maptotal
end


function UIMysteryListWin:__delete()
self:unbindComponents()
selectFB=nil
worldController:resetLeftView()
end






function UIMysteryListWin:onShow(argtable,afterOnloaded)




argtable=argtable or{}
local jumpTagId=argtable.tagId

self.isShow=true
self.winlua:SwitchChildParent(self.root:getID(),worldController:isInWorld()and-1 or self.uiRoot:getID(),false)


local mainIndex=self:refreshFBList(jumpTagId)
mainIndex=mainIndex or 1
if mainIndex then
if mainIndex~=self.mainIndex then
self.CSGUIScrollView:clickItem(mainIndex-1)

if mainIndex>=2 then
self:delayDo(0.2,function()
self.MainContent:setChildDOLocalMoveY(0,0.2)
end)
end
end
end

self.mainIndex=mainIndex
end

function UIMysteryListWin:onHide()
self.allCfg={}
self.mainIndex=nil
self.CSGUIScrollView:removeAllGrids()
end

function UIMysteryListWin:refreshFBList(jumpTagId)

local list=MysteryModel:get_mysteryFB_list_sort_data3()
self.allCfg=list
local mainIndex=nil
if next(self.allCfg)then
self.CSGUIScrollView:setActive(true)
self.NullTxt:setText("")
self.NullImg:setActive(false)
if not self.init then

self.CSGUIScrollView:removeAllGrids()
self.showType=nil
self.selectMainItem=nil
end


self.CSGUIScrollView:createMainGrids(#list,1,true)

if jumpTagId then
for i,v in ipairs(list)do
if v.id==jumpTagId then
mainIndex=i
break
end
end
else
local min=10000
for i,v in ipairs(list)do
if v.config.priority and v.config.priority<=min then
mainIndex=i
min=v.config.priority
end
end
end







else
self.CSGUIScrollView:setActive(false)
self.NullTxt:setText("暂无秘境")
self.NullImg:setActive(true)
end
self.init=false
return mainIndex

end

function UIMysteryListWin:refreshMainItem(mainIndex)
if mainIndex then
local worldMystery=self.allCfg[mainIndex]
local num=#worldMystery.list
self.CSGUIScrollView:rebuildSubItems(mainIndex-1,num,nil)
end
end

function UIMysteryListWin:mainClickAction(mainItem)
local lastMainItem=self.selectMainItem
local index=mainItem.Index+1
self.mainIndex=index
local isExpanded=self.showType==index
if isExpanded then
self.selectMainItem=mainItem
end
mainItem:SetChildActive(main_index.jiantou1,isExpanded)
mainItem:SetChildActive(main_index.jiantou2,not isExpanded)
if lastMainItem~=nil and lastMainItem.Index~=mainItem.Index then
self:mainClickAction(lastMainItem)
end
end

function UIMysteryListWin:subClickAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local data=self.allCfg[mainIndex]
local config=data.config
local funcKey=config.onClickFunc
local list=data.list
onClickFunc[funcKey](self,subItem,mainIndex,index,list[index])
end

function UIMysteryListWin:mainCreateAction(mainItem)
local index=mainItem.Index+1
local worldMystery=self.allCfg[index]
if worldMystery then
local config=worldMystery.config
local widget=mainItem

local name=config.name
widget:SetChildText(main_index.name,name)

local num=#worldMystery.list
local isExpanded=self.showType==index
mainItem:SetChildActive(main_index.jiantou1,isExpanded)
mainItem:SetChildActive(main_index.jiantou2,not isExpanded)
widget:SetAddExpandColumCount(num)

if config.id==4 then
mainItem:SetChildActive(main_index.reddot,mysteryZiYuanFuBenModel:checkPassReddot()or false)
end
end
end

function UIMysteryListWin:refreshMainReddot()
for index,v in ipairs(self.allCfg)do
local mItem=self.CSGUIScrollView:getMainItem(index-1)
if mItem then
local worldMystery=self.allCfg[index]
local config=worldMystery.config
if config.id==4 then
mItem:SetChildActive(main_index.reddot,mysteryZiYuanFuBenModel:checkPassReddot()or false)
end
end
end
end

function UIMysteryListWin:refreshChildReddot()
local worldMystery=self.allCfg[self.mainIndex]
local config=worldMystery.config
if config.id==4 then
local subItems=self.CSGUIScrollView:getSubItemsList()
for i=1,subItems.Count do
local subItem=subItems[i-1]
if subItem then

local fbData=mysteryZiYuanFuBenModel:getGroupFbData(i)
if fbData then
subItem:SetChildActive(16,mysteryZiYuanFuBenModel:checkPassButNotGetRewardzjMjId(i,fbData.curId))
end

end
end
end
end


function UIMysteryListWin:subCreateAction(subItem)
local index=subItem.Index+1
local mainIndex=subItem.Mainindex+1
local data=self.allCfg[mainIndex]
local config=data.config
local refreshFuncKey=config.refreshFunc
local list=data.list
refreshFunc[refreshFuncKey](self,subItem,mainIndex,index,list[index])
end


function UIMysteryListWin:onExpandAction(index)
self.subIndex=nil
if index>=0 then
self.showType=index+1
else
self.showType=nil
end
end


function UIMysteryListWin:onHideButton()
worldController:resetLeftView()
end

function UIMysteryListWin:timerHandler(...)
if m_CreateCD then
m_CreateCD=m_CreateCD-1
if m_CreateCD>0 then
self.CDTxt:setText(FMT.fmt("秘境出现倒计时：{0}",FMT.cfmt(FONT_COLOR.eGreenColor,"{0}",timeHelper.format_time_stamp(m_CreateCD))))
else
self.CDTxt:setText("")

if self.CreateCDTimer then
self:stopTimerByID(self.CreateCDTimer)
self.CreateCDTimer=nil
end
end
end
end


function UIMysteryListWin:OnEnable()

end


function UIMysteryListWin:OnDisable()
self.fb_data_list=nil

end

function UIMysteryListWin.getOpenTips(sysid)
if systemConfig.isShield(sysid)then return''end
if systemModel.isOpen(sysid)then return''end
local isCan,errArgs=systemConfig.isEnoughConfigOpenCnd(sysid)
if not isCan then
local typo=errArgs[1]
local val=errArgs[2]
local name='秘境'
if typo==SYSTEM_OPEN_TYPE.eZongmemLevelChanged then
local level=val
return FMT.fmt('宗门达到{0}级刷新{1}',level,name)
elseif typo==SYSTEM_OPEN_TYPE.eTaskFinish then
local taskname=taskModel:getTaskConfig(val).name
return FMT.fmt('完成{0}任务刷新{1}',taskname,name)
elseif typo==SYSTEM_OPEN_TYPE.eOpenServerTime then
local day=val
return FMT.fmt('开服第{0}天刷新{1}',day,name)
elseif typo==SYSTEM_OPEN_TYPE.eKillBoss then
local boosName=cfgHelper.get1(cfg_monstergroup_get,val).name
return FMT.fmt('击杀{0}刷新{1}',boosName,name)
end
end
end

function UIMysteryListWin:onDialogJumpToWorld(world,unitKey)
local worldName=cfgHelper.get2(cfg_worldconfig_get,world,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
local args={lookAtUnit=unitKey}
mainControl:enterWorld({world,args},function()
local unitData=worldController:getUnit(unitKey)
if unitData then
worldController.onClickUnit(unitData.LuaData)
end
end)

end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
end


