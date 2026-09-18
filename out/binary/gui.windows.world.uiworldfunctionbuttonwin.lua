







def_class("UIWorldFunctionButtonWin",UIWindowBase)









function UIWorldFunctionButtonWin:bindComponents()

self.ButtonTour=UIButton.get(self,0)
self.ButtonExperience=UIButton.get(self,1)
self.BottomList=UIObject.get(self,2)
self.mjActBtn=UIButton.get(self,3)
self.chatBtn=UIButton.get(self,4)
self.mapBtn=UIButton.get(self,5)
self.ButtonBack=UIButton.get(self,6)
self.ReddotTour=UIObject.get(self,7)
self.FreeTour=UIObject.get(self,8)
self.RewardExperience=UIObject.get(self,9)
self.ReddotExperience=UIObject.get(self,10)
self.bg2=UIObject.get(self,11)
self.bg1=UIObject.get(self,12)
self.bg0=UIObject.get(self,13)
self.bg3=UIObject.get(self,14)
self.mjList=UIObject.get(self,15)
self.mjListBg=UIObject.get(self,16)
self.mjReddot=UIObject.get(self,17)
self.mapReddot=UIObject.get(self,18)
self.btnJieYu=UIButton.get(self,19)

self.ButtonTour:setButtonClick(function()self:onButtonTour()end)

self.ButtonExperience:setButtonClick(function()self:onButtonExperience()end)

self.mjActBtn:setButtonClick(function()self:onMjActBtn()end)

self.chatBtn:setButtonClick(function()self:onChatBtn()end)

self.mapBtn:setButtonClick(function()self:onMapBtn()end)

self.ButtonBack:setButtonClick(function()self:onButtonBack()end)

self.btnJieYu:setButtonClick(function()self:onBtnJieYu()end)



end


function UIWorldFunctionButtonWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ButtonTour);self.ButtonTour=nil;
_UIObject_release(self.ButtonExperience);self.ButtonExperience=nil;
_UIObject_release(self.BottomList);self.BottomList=nil;
_UIObject_release(self.mjActBtn);self.mjActBtn=nil;
_UIObject_release(self.chatBtn);self.chatBtn=nil;
_UIObject_release(self.mapBtn);self.mapBtn=nil;
_UIObject_release(self.ButtonBack);self.ButtonBack=nil;
_UIObject_release(self.ReddotTour);self.ReddotTour=nil;
_UIObject_release(self.FreeTour);self.FreeTour=nil;
_UIObject_release(self.RewardExperience);self.RewardExperience=nil;
_UIObject_release(self.ReddotExperience);self.ReddotExperience=nil;
_UIObject_release(self.bg2);self.bg2=nil;
_UIObject_release(self.bg1);self.bg1=nil;
_UIObject_release(self.bg0);self.bg0=nil;
_UIObject_release(self.bg3);self.bg3=nil;
_UIObject_release(self.mjList);self.mjList=nil;
_UIObject_release(self.mjListBg);self.mjListBg=nil;
_UIObject_release(self.mjReddot);self.mjReddot=nil;
_UIObject_release(self.mapReddot);self.mapReddot=nil;
_UIObject_release(self.btnJieYu);self.btnJieYu=nil;
end
















local effectBodyId=
{
eJuanzhou=2008,
}







local _this=nil




function UIWorldFunctionButtonWin:onLoaded(...)
UIManager:callWindowFunc('UIMain','releaseAllButton')
self:bindComponents()
_this=self
self.lookup={}
self.loadIcons={}
self:leaveExperienceMoney()
notifySystem:listenNotify(notifyConfig.on_system_open,self.onSystemOpen)
notifySystem:listenNotify(notifyConfig.initPro,self.onInitPro)
notifySystem:listenNotify(notifyConfig.onTourCountChange,self.onTourCountChange)
notifySystem:listenNotify(notifyConfig.onTourCompeleted,self.onTourCompeleted)
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:listenNotify(notifyConfig.onWorldAreaReward,self.onWorldAreaReward)
notifySystem:listenNotify(notifyConfig.onWorldBlockStateChanged,self.onWorldBlockStateChanged)
notifySystem:listenNotify(notifyConfig.iconUnlock,self.onIconUnlock)
notifySystem:listenNotify(notifyConfig.onTaskChange,self.onTaskChange)
self.iconLuaObjectLookup={}
self.iconRoots={}
local iconRoots=self.iconRoots
iconRoots[#iconRoots+1]=self.bg0
iconRoots[#iconRoots+1]=self.bg1
iconRoots[#iconRoots+1]=self.bg2
iconRoots[#iconRoots+1]=self.bg3
self.chatBtn:setActive(false)
self.ButtonExperience:setActive(false)
end


function UIWorldFunctionButtonWin:__delete()
self:releaseAllButton()
self:unbindComponents()
_this=nil
self.lookup={}
self.loadIcons={}
notifySystem:removelistener(notifyConfig.on_system_open,self.onSystemOpen)
notifySystem:removelistener(notifyConfig.initPro,self.onInitPro)
notifySystem:removelistener(notifyConfig.onTourCountChange,self.onTourCountChange)
notifySystem:removelistener(notifyConfig.onTourCompeleted,self.onTourCompeleted)
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
notifySystem:removelistener(notifyConfig.onWorldAreaReward,self.onWorldAreaReward)
notifySystem:removelistener(notifyConfig.onWorldBlockStateChanged,self.onWorldBlockStateChanged)
notifySystem:removelistener(notifyConfig.iconUnlock,self.onIconUnlock)
notifySystem:removelistener(notifyConfig.onTaskChange,self.onTaskChange)
end




function UIWorldFunctionButtonWin:onShow(argtable,afterOnloaded)
self:checkExperienceButton()
self:checkExperienceReward()
self:checkExperienceReddot()


self:checkTourButton(true)
self:refreshMapBtn()
self:creatGroupBtns()
self:refreshMjActBtn()

self:refreshJieYuBtn()
end


function UIWorldFunctionButtonWin:onHide()
self.RewardExperience:setActive(false)
self.ReddotTour:setActive(false)
end




function UIWorldFunctionButtonWin:onButtonExperience()
local find=worldBlockModel:findExploreBlock(worldModel.world)
if find then
local world=find[1]
local block=find[2]
local state=find[3]

if worldModel:isSameWorld(world)then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local cPos=worldController:getCameraPosition()
local position=Vector3.New(blockCfg.eExitPos[1],cPos.y,blockCfg.eExitPos[2])
worldController:setCameraPosition(position,false)
else
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,world,block)
local position=Vector3.New(blockCfg.eExitPos[1],worldCfg.cameraPos[2],blockCfg.eExitPos[2])
worldController:enterWorld(world,{position=position})
end
else
UIManager:showWindow("UIWorldProgressWin")
end
end


function UIWorldFunctionButtonWin:onButtonBack()
if worldController:checkCameraState(eWorldCameraState.Normal)then
self.backing=worldController:exitWorld()
end
end

function UIWorldFunctionButtonWin:onButtonTour()
if worldBlockModel:checkBlockState(1,1,eWorldBlockState.OPEN)then
UIManager:showWindow("UIWorldTourWin")
else
UIManager.error("没有可以游历的区块")
end
end

function UIWorldFunctionButtonWin:onMapBtn()
if not self.backing and worldController:checkCameraState(eWorldCameraState.Normal)then

worldController:setCameraState(eWorldCameraState.SceneMap)
worldController:zoomOverMax_atNormal(true)
end
end

function UIWorldFunctionButtonWin:onChatBtn()
self.winlua:SetChildDOPunchScale(self.chatBtn:getID(),Vector3.New(0.5,0.5,1),1)

UIManager:showWindow('UIChatWin')
end

function UIWorldFunctionButtonWin:onBtnJieYu()
local btnList={
MAIN_BTNS_TYPE.eSubMoJie,
MAIN_BTNS_TYPE.eSubWorld,
MAIN_BTNS_TYPE.eSubXianJie,
MAIN_BTNS_TYPE.eSubXianYu,
MAIN_BTNS_TYPE.eSubZM,
}

local posVector2=self.btnJieYu:getChildScreenPointToLocalPointRectangle(-1)
local pos={posVector2.x-70,posVector2.y+115}

UIManager:showWindow("UIMainSubEnterPanelWin",{btnList=btnList,pos=pos,posType=2})
end

function UIWorldFunctionButtonWin:refreshMapBtn()
local show=systemModel.isOpen(SYSTEM_DEFINE.eWorldSceneMap)
self.mapBtn:setActive(show)
if show then
local reddot=worldBlockModel:checkAllWorldEnterReddot()

self.mapReddot:setActive(reddot)
end
end

function UIWorldFunctionButtonWin.onSystemOpen(sysId)

if sysId==SYSTEM_DEFINE.eWorldSceneMap then
_this:refreshMapBtn()


end
end

function UIWorldFunctionButtonWin.onInitPro()

_this:refreshMapBtn()
end



function UIWorldFunctionButtonWin:creatGroupBtns()
local index=self.BottomList:getID()
local configs=mainConfig.getBottomGroupConfig()
local indexArray={}
local parentIndexArray={}
local keys={}
local names={}
local cfgs={}
local idx=0
for i,v in ipairs(configs)do
idx=idx+1
indexArray[idx]=v.UIPrefabIndex
parentIndexArray[idx]=idx-1
keys[idx]=v.key
names[idx]=v.creator
cfgs[#cfgs+1]=v
end
local len=#cfgs
for i=1,#self.iconRoots do
local flag=i<=len
self.iconRoots[i]:setActive(flag)
end

self.winlua:SetCreatChildClonePrefabEx(index,indexArray,parentIndexArray,keys)
for i=1,len do
local config=cfgs[i]
local buildType=config.buildType
local key=config.key
local iconType=config.iconType
local lookup=self.iconLuaObjectLookup
local luaObjet=lookup[key]
local widget=self.winlua:GetChildCloneWidget(index,i-1)
if luaObjet==nil then
mainBtnConfig.PreloadCtor(config)
local ctor=config.ctor
luaObjet=ctor(widget,i,config)
lookup[key]=luaObjet
luaObjet:onLoaded()
else
luaObjet:init(widget,i,config)
end
local isinit=self.loadIcons[key]==nil
self.loadIcons[key]=true
luaObjet:onShow(isinit)
local comName=FMT.fmt('UIWorldFunctionButtonWin.{0}.click',names[i])
luaObjet:setNewBieComponentId(1,comName)
end
self.winlua:StartChildClonePrefabTween(index,0,DG.Tweening.Ease.InOutBack)
end

function UIWorldFunctionButtonWin:checkExperienceButton()








end

function UIWorldFunctionButtonWin:checkTourButton(reddot)
self.ButtonTour:setActive(false)








end

function UIWorldFunctionButtonWin:refreshJieYuBtn()
local isOpenXianJie=xianjieController:checkXianJieSystemOpen()
self.ButtonBack:setActive(not isOpenXianJie)
self.btnJieYu:setActive(isOpenXianJie)
end



















function UIWorldFunctionButtonWin.on_building_event(etype,args1)
if etype==buildingEvent.zongmenLevelUp then

_this:checkExperienceButton()

end
end

function UIWorldFunctionButtonWin.on_money_changed(moneyType,lastVal,val)
if _this:checkExperienceMoney(moneyType)then
_this:checkExperienceButton()

end
end

function UIWorldFunctionButtonWin:checkExperienceReward()

self.RewardExperience:setActive(false)
end

function UIWorldFunctionButtonWin:checkExperienceReddot()

self.ReddotExperience:setActive(true)
end

function UIWorldFunctionButtonWin:leaveExperienceMoney()
self.experienceMoney={}
local cfg=cfg_worldblockconfig()
for i,v in pairs(cfg)do
for j,w in pairs(v)do
if w.consume then
for k,u in ipairs(w.consume)do
if not self.experienceMoney[u[1]]then
self.experienceMoney[u[1]]=true
end
end
end
end
end
end

function UIWorldFunctionButtonWin:checkExperienceMoney(moneyType)
return self.experienceMoney[moneyType]or false
end

function UIWorldFunctionButtonWin.onWorldAreaReward(area)

_this:checkExperienceButton()
end

function UIWorldFunctionButtonWin.onWorldBlockStateChanged(world,block,nState)
if nState==worldBlockModel.BLOCKSTATE.OPEN then

_this:checkExperienceButton()
end

end

function UIWorldFunctionButtonWin.onTaskChange(taskId,taskState)
if taskState==taskModel.taskFinishState and worldController:isInWorld()then
local worldCfg=cfg_worldblockconfig(worldModel.world)
for blockId,blockCfg in pairs(worldCfg)do
local check=worldBlockModel:checkBlockState(worldModel.world,blockId,eWorldBlockState.CLOSE)
if check then
local list=blockCfg.unLock or{}
for i,v in ipairs(list)do
if v[1]==2 and v[2]==taskId then
return _this:checkExperienceButton()
end
end
end
end
end
end

function UIWorldFunctionButtonWin.onIconUnlock(iconTypes)
if _this==nil or _this.isClose then return end
_this:onIconRefresh(iconTypes)
end

function UIWorldFunctionButtonWin:onIconRefresh(openIconTypes)
local iconGroupType=MAIN_ICON_GROUP_TYPE.eBottom
local iconTypes=mainConfig.getGroupIconTypeList(iconGroupType)
local flag=table.containsTableValue(iconTypes,openIconTypes)
if flag then
self:creatGroupBtns()
end
end


function UIWorldFunctionButtonWin:refreshMjActBtn()
local fb=mysteryWeekActivityModel:getNextMystery()
self.mjActBtn:setActive(fb~=nil)
local mjList=mysteryWeekActivityModel:getMysteryUnitWinList()
if#mjList>1 then
self.mulitMJ=true
self.mjList:setChildLayoutGroupCreateItems(#mjList,function(index)
local item=self.mjList:getChildLayoutGroupGridItem(index-1)
local data=mjList[index]
item:SetChildProgressValue(1,data.percent,100)
item:SetChildText(2,FMT.fmt("{0}%",data.percent))
local color=cfgHelper.get(cfg_secretscenefubenconfig_get,data.guid,"color")

item:SetChildText(0,FMT.cfmt2(FONT_TIPS_COLOR_VAL[color],data.name))
item:SetChildButtonClick(3,function()
mysteryWeekActivityController:openWeekEnterWin(data.guid)
self:onMjActBtn()
end)
item:SetChildActive(3,index%2==1)
item:SetChildActive(4,index%2==0)
if index%2==1 then
item:SetChildButtonClick(3,function()
mysteryWeekActivityController:openWeekEnterWin(data.guid)
self:onMjActBtn()
end)
else
item:SetChildButtonClick(4,function()
mysteryWeekActivityController:openWeekEnterWin(data.guid)
self:onMjActBtn()
end)
end
end)
else
self.mulitMJ=false
self.mjList:setChildLayoutGroupCreateItems(0)
self.mjListBg:setChildCanvasGroupAlpha(0)
self.mjList:setScale(Vector3.zero)
end
local reddot=mysteryWeekActivityModel:getFBReddot()
self.mjReddot:setActive(reddot)
self:doPunchRotation(reddot)
end

function UIWorldFunctionButtonWin:doPunchRotation(reddot)
if webGLHelper:isHidePunchAni()then return end
local index=self.mjReddot:getID()
if reddot then
if self.reddotTweener==nil then
self:setChildRotation(index,0,0,0)
local tweener=self:setChildDOPunchRotation(index,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener=nil
self:setChildRotation(index,0,0,0)
end
end
end
function UIWorldFunctionButtonWin:onMjActBtn()
if self.mulitMJ then
self.mjActOpen=not self.mjActOpen

if self.mjActOpen then
self.mjList:setScale(Vector3.one)
self.mjList:setChildCanvasGroupAlpha(0)
self.mjListBg:setChildCanvasGroupAlpha(0)
self.mjListBg:setChildCanvasGroupDOFade(1,0.5)
self.mjList:setChildCanvasGroupDOFade(1,0.2)
self.mjList:setLocalPosX(0)
self.mjList:setChildDOLocalMoveX(-27.4,0.2)
else
self.mjList:setChildCanvasGroupAlpha(1)
self.mjListBg:setChildCanvasGroupAlpha(1)
self.mjListBg:setChildCanvasGroupDOFade(0,0.5)
self.mjList:setChildCanvasGroupDOFade(0,0.2,function()
self.mjList:setScale(Vector3.zero)
end)
self.mjList:setLocalPosX(-27.4)
self.mjList:setChildDOLocalMoveX(0,0.2)
end

else
mysteryWeekActivityController:openFightWeekEnterWin()
end
end

function UIWorldFunctionButtonWin:releaseAllButton()

for _,luaObjet in pairs(self.iconLuaObjectLookup)do
if luaObjet and luaObjet.release then
luaObjet:release()
end
end

self.iconLuaObjectLookup={}
end