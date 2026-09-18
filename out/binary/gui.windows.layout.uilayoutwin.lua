







def_class("UILayoutWin",UIWindowBase)









function UILayoutWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.tipsbg=UIObject.get(self,1)
self.joyStickRoot=UIObject.get(self,2)
self.roadJuanZhou=UIObject.get(self,3)
self.stylePanel=UIObject.get(self,4)
self.tipspanel=UIButton.get(self,5)
self.selectpanel=UIObject.get(self,6)
self.bdtipsroot=UIObject.get(self,7)
self.closeBtn=UIButton.get(self,8)
self.leftPanel=UIObject.get(self,9)
self.rightPanel=UIObject.get(self,10)
self.groundBtn=UIButton.get(self,11)
self.surfaceObjBtn=UIButton.get(self,12)
self.nameBtn=UIButton.get(self,13)
self.skyObjBtn=UIButton.get(self,14)
self.btnScrollview=UIObject.get(self,15)
self.deleteBtn=UIButton.get(self,16)
self.sortBtnScrollview=UIObject.get(self,17)
self.storageScrollview=UIObject.get(self,18)
self.buildScrollview=UIObject.get(self,19)
self.tabRect=UIObject.get(self,20)
self.tips=UIText.get(self,21)
self.tipsCostRoot=UIObject.get(self,22)
self.bdtipsicon=UIImage.get(self,23)
self.bdtipsdesc=UIText.get(self,24)
self.bdtipslevel=UIText.get(self,25)
self.bdtipsname=UIText.get(self,26)
self.styleRoot=UIObject.get(self,27)
self.styleArrowBtn=UIButton.get(self,28)
self.tipsRoot=UIObject.get(self,29)
self.deleteSelect=UIObject.get(self,30)
self.deleteNomal=UIObject.get(self,31)
self.btnScrollviewBg=UIObject.get(self,32)
self.scRoot=UIObject.get(self,33)
self.sceneryFilter=UIObject.get(self,34)
self.countRoot=UIObject.get(self,35)
self.buildSuitBtn=UIButton.get(self,36)
self.storageTips=UIText.get(self,37)
self.tipsCostIcon=UIObject.get(self,38)
self.tipsCost=UIText.get(self,39)
self.styleScrollView=UIObject.get(self,40)
self.tipsBuildName=UIText.get(self,41)
self.tipsDesc=UIText.get(self,42)
self.addStorage=UIButton.get(self,43)
self.storageCount=UIText.get(self,44)
self.limitTips=UIButton.get(self,45)
self.buildCount=UIText.get(self,46)
self.buildSuitReddot=UIObject.get(self,47)
self.styleTitle=UIImage.get(self,48)
self.joyStick=UIObject.get(self,49)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.tipspanel:setButtonClick(function()self:onTipspanel()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.groundBtn:setButtonClick(function()self:onGroundBtn()end)

self.surfaceObjBtn:setButtonClick(function()self:onSurfaceObjBtn()end)

self.nameBtn:setButtonClick(function()self:onNameBtn()end)

self.skyObjBtn:setButtonClick(function()self:onSkyObjBtn()end)

self.deleteBtn:setButtonClick(function()self:onDeleteBtn()end)

self.styleArrowBtn:setButtonClick(function()self:onStyleArrowBtn()end)

self.buildSuitBtn:setButtonClick(function()self:onBuildSuitBtn()end)

self.addStorage:setButtonClick(function()self:onAddStorage()end)

self.limitTips:setButtonClick(function()self:onLimitTips()end)



end


function UILayoutWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.tipsbg);self.tipsbg=nil;
_UIObject_release(self.joyStickRoot);self.joyStickRoot=nil;
_UIObject_release(self.roadJuanZhou);self.roadJuanZhou=nil;
_UIObject_release(self.stylePanel);self.stylePanel=nil;
_UIObject_release(self.tipspanel);self.tipspanel=nil;
_UIObject_release(self.selectpanel);self.selectpanel=nil;
_UIObject_release(self.bdtipsroot);self.bdtipsroot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.groundBtn);self.groundBtn=nil;
_UIObject_release(self.surfaceObjBtn);self.surfaceObjBtn=nil;
_UIObject_release(self.nameBtn);self.nameBtn=nil;
_UIObject_release(self.skyObjBtn);self.skyObjBtn=nil;
_UIObject_release(self.btnScrollview);self.btnScrollview=nil;
_UIObject_release(self.deleteBtn);self.deleteBtn=nil;
_UIObject_release(self.sortBtnScrollview);self.sortBtnScrollview=nil;
_UIObject_release(self.storageScrollview);self.storageScrollview=nil;
_UIObject_release(self.buildScrollview);self.buildScrollview=nil;
_UIObject_release(self.tabRect);self.tabRect=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsCostRoot);self.tipsCostRoot=nil;
_UIObject_release(self.bdtipsicon);self.bdtipsicon=nil;
_UIObject_release(self.bdtipsdesc);self.bdtipsdesc=nil;
_UIObject_release(self.bdtipslevel);self.bdtipslevel=nil;
_UIObject_release(self.bdtipsname);self.bdtipsname=nil;
_UIObject_release(self.styleRoot);self.styleRoot=nil;
_UIObject_release(self.styleArrowBtn);self.styleArrowBtn=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.deleteSelect);self.deleteSelect=nil;
_UIObject_release(self.deleteNomal);self.deleteNomal=nil;
_UIObject_release(self.btnScrollviewBg);self.btnScrollviewBg=nil;
_UIObject_release(self.scRoot);self.scRoot=nil;
_UIObject_release(self.sceneryFilter);self.sceneryFilter=nil;
_UIObject_release(self.countRoot);self.countRoot=nil;
_UIObject_release(self.buildSuitBtn);self.buildSuitBtn=nil;
_UIObject_release(self.storageTips);self.storageTips=nil;
_UIObject_release(self.tipsCostIcon);self.tipsCostIcon=nil;
_UIObject_release(self.tipsCost);self.tipsCost=nil;
_UIObject_release(self.styleScrollView);self.styleScrollView=nil;
_UIObject_release(self.tipsBuildName);self.tipsBuildName=nil;
_UIObject_release(self.tipsDesc);self.tipsDesc=nil;
_UIObject_release(self.addStorage);self.addStorage=nil;
_UIObject_release(self.storageCount);self.storageCount=nil;
_UIObject_release(self.limitTips);self.limitTips=nil;
_UIObject_release(self.buildCount);self.buildCount=nil;
_UIObject_release(self.buildSuitReddot);self.buildSuitReddot=nil;
_UIObject_release(self.styleTitle);self.styleTitle=nil;
_UIObject_release(self.joyStick);self.joyStick=nil;
end


















local _this

local _titleSprite={'button_daoluqh_1','button_puqiangqh_1'}

local newImgAB='ui/windows/layout/newlayout_atlas_pak.ab'

local _titleBundle=globalABLookup.layoutsprite

local _btnType={
Build=1,
Layout=2,
Road=3,
Wall=4,
Edit=5,
Sky=6,
}

local _mountainBtnList={
[mapIdType.xianmeng]={_btnType.Build,_btnType.Layout},
[mapIdType.fort]={_btnType.Build,_btnType.Layout},
}

local _hideSkyBtn=
{
[mapIdType.fort]=true,
}

local _hideEditBtn=
{
[mapIdType.lingshoudao]=true,
}




function UILayoutWin:onLoaded(...)
self:bindComponents()
_this=self

local sfId=zongmenModel:getMountainId()
if _mountainBtnList[sfId]then
self.defaultBtnList=_mountainBtnList[sfId]
else
self.defaultBtnList={_btnType.Build,_btnType.Layout,_btnType.Road,_btnType.Wall}
local isHideEdit=_hideEditBtn[sfId]
if not isHideEdit then
table.insert(self.defaultBtnList,3,_btnType.Edit)
end

if UILayoutControl:isOpenSkyLayout()then
table.insert(self.defaultBtnList,3,_btnType.Sky)
end
end

self.funcBtnIndex={}
for i,v in ipairs(self.defaultBtnList)do
self.funcBtnIndex[v]=i
end

self.surfaceObjBtn:setActive(false)

self.bdtipsroot:setChildAnchoredPosition(Vector2(10,150))

self:hideBuildingInfo()

self.imgAB='ui/windows/layout/sharedtextures/layout.ab'
self.hudAB='ui/windows/hud/hud_sprite_atlas_pak.ab'
self.func_btns={
[_btnType.Build]={'button_jzjianzao_1','button_jzjianzao_2'},
[_btnType.Layout]={'button_jzbuju_1','button_jzbuju_2'},
[_btnType.Edit]={'button_jzsheji_1','button_jzsheji_2'},
[_btnType.Road]={'button_jzpulu_1','button_jzpulu_2'},
[_btnType.Wall]={'button_jzpuqiang_1','button_jzpuqiang_2'},
[_btnType.Sky]={'button_jzkongzhong_1','button_jzkongzhong_2'},




}
self.func_icons={
[1]='icon_jianzhushibie_4',
[2]='icon_jianzhushibie_2',
[3]='icon_jianzhushibie_1',
[4]='icon_jianzhushibie_3',
[5]='icon_jianzhushibie_4',



}
self.bd_name_colors={
[1]='#92ea42',
[2]='#6ab9fb',
[3]='#fd8950',
[4]='#fdc650',
[5]='#6833c0',



}

self.red_btns={
[_btnType.Edit]=function()
return ims_design_layout:isLayoutReddot()
end,
}

self.hType=0

self.roadtype=0

self.sfId=zongmenModel:getMountainId()












self.defaultRoadId={1,3}

local btnFUncs={
[_btnType.Build]=function()

self:onBuildBtn()
end,
[_btnType.Layout]=function()

self:onLayoutBtn()
end,
[_btnType.Road]=function()

self:onChangeRoad(1,1)
end,
[_btnType.Wall]=function()

self:onChangeRoad(2,1)
end,
[_btnType.Edit]=function()
self:onDesignBtn()
end
}

self.isSkyOpen=UILayoutControl:isOpenSkyLayout()
if self.isSkyOpen then
btnFUncs[_btnType.Sky]=function()
self:onSkyBtn()
end
end

self.skyObjBtn:setActive(self.isSkyOpen and not _hideSkyBtn[sfId])

self.btnFUncs=btnFUncs

self.fbSelectId=0






















self.first_build_check={}



self.btnScrollview:setChildScrollViewInit(0.5,true,self.on_btns_click,nil)
self.buildScrollview:setChildScrollViewInit(1,true,nil,nil)
self.storageScrollview:setChildScrollViewInit(1,true,self.on_storage_item_click,nil)
self.sortBtnScrollview:setChildScrollViewInit(0,true,self.on_sort_btn_click,nil)
self.styleScrollView:setChildScrollViewInit(1,true,nil,nil)
self.sceneryFilter:setChildComboBoxInit(self.on_scenery_filter_change)

isometricMapSystem:showGrid()

notifySystem:listenNotify(notifyConfig.building_event,self.handleBuildingEvent)

notifySystem:listenNotify(notifyConfig.on_system_open,self.on_system_open)

self._onMoneyChange=function(...)self:onMoneyChange(...)end
notifySystem:listenNotify(notifyConfig.on_money_changed,self._onMoneyChange)

local joyStick=self.joyStick:getTransform()
CS.PlayerInput.Instance:BindJoyStick(joyStick)

self:addNotify(notifyConfig.joystickMoveStart,function(...)self:onMoveStart(...)end)
self:addNotify(notifyConfig.joystickMove,function(...)self:onMove(...)end)
self:addNotify(notifyConfig.joystickMoveEnd,function(...)self:onMoveEnd(...)end)

self.winlua:SetChildScrollViewPlayAniAction(self.styleScrollView:getID(),function(...)
if self and not self.isClose then
self:onPlayStyleAniFinish(...)
end
end)
self.styleCfgs={}

end


function UILayoutWin:onMoneyChange(moneyType,lastVal,val)
if moneyType==eMoneyType.mtLingYu then
self:refreshCurrPage()
end
end

function UILayoutWin:initTabBtns()
local datas=self.datas
self.buildTabToIndex={}
self.indexToBuildTab={}
self.btnDatas={}
if self.filterIndexs==nil then self.filterIndexs={}end
local level=zongmenModel:getLevel()
local cfg=cfgHelper.get1(cfg_monijysfconfig_get,self.sfId)
local index=1
for i,v in ipairs(cfg.layout_menu)do
local showlv=v[2]
if level>=showlv then
local md={}
md.name=v[1]
local fd=v[3]
local fl=v[4]
local ft=fd[1]
if ft==1 then
local page=fd[2]
md.page=page
local vis=fd[3]==1
local hasBuild=datas[page]~=nil
if hasBuild or vis then
if self.filterIndexs[page]==nil then self.filterIndexs[page]=0 end
self.buildTabToIndex[page]=index
self.indexToBuildTab[index]=page
md.func=function()
self:setFilter(fl,page)
self:SelectPage(page)
self:clearPageReddot(page)
self.inStorage=false
end
table.insert(self.btnDatas,md)
index=index+1
end
elseif ft==2 then
md.func=function()
self:setFilter()
self:onStorageBtn()
self.inStorage=true
end
table.insert(self.btnDatas,md)
index=index+1
end
end
end
local rPage=BUILD_TAB_TYPE.eHoldJingGuan
local rData=self.datas[rPage]or{}
local rLen=#rData
self.sortBtnScrollview:setChildScrollViewCreateGrids(#self.btnDatas,0)
local grids=self.sortBtnScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local data=self.btnDatas[i+1]
local page=data.page
local reddot=page and self:getPageReddot(page)or false
if page==self.page then
reddot=false
if page==BUILD_TAB_TYPE.eJingGuan then
reddot=zongmenBuildingSuitModel:checkReddot()
elseif page==BUILD_TAB_TYPE.eProduction then
reddot=zongmenModel:hasAllProductionBuildReddot()
elseif page==BUILD_TAB_TYPE.eFunction then
reddot=zongmenModel:hasAllFunctionBuildReddot()
end
end
local isPage=page==rPage
item:SetChildText(1,data.name)
item:SetChildNewBieComponentId(-1,FMT.fmt('UILayoutWin.UILayoutSortBtn_{0}',i+1))
item:SetChildActive(2,reddot)
item:SetChildActive(3,isPage and rLen>0)
item:SetChildText(4,isPage and rLen or'')
end
end

function UILayoutWin:clickLayoutBtn()
self.on_btns_click(0,1)
end

function UILayoutWin.on_btns_click(clicknum,index)
local call=function()
local lastSelect=_this.fbSelectId
_this.fbSelectId=index
if lastSelect then
_this:freshBtnSelect(lastSelect)
end

_this:freshBtnSelect(index)

_this:hideBuildingInfo()

local btnType=_this.funcBtns[index+1]
_this.btnFUncs[btnType]()

_this:refreshBuildSuitButton()
end
_this:checkModel5(call)
end

function UILayoutWin:freshBtnSelect(index)
local item=_this.btnScrollview:getChildScrollViewItemWidget(index)
if item then
item:SetChildActive(0,self.fbSelectId~=index)
item:SetChildActive(1,self.fbSelectId==index)
end
end

function UILayoutWin:freshBtnReddot(ft)

local reddot=self.red_btns[ft]~=nil and self.red_btns[ft]()or false
for i,v in ipairs(self.funcBtns)do
if v==ft then
local item=_this.btnScrollview:getChildScrollViewItemWidget(i-1)
item:SetChildActive(3,reddot)
break
end
end
end

function UILayoutWin:initFuncBtn()
self.funcBtns=self.defaultBtnList
self.btnScrollview:setChildScrollViewCreateGrids(#self.funcBtns,0)

local grids=self.btnScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local ft=self.funcBtns[i+1]
local icon=self.func_btns[ft]
item:SetChildCSImageSprite(0,newImgAB,icon[2])
item:SetChildActive(1,i==0)
item:SetChildCSImageSprite(2,newImgAB,icon[1])

local reddot=self.red_btns[ft]~=nil and self.red_btns[ft]()or false
item:SetChildActive(3,reddot)
end

end

function UILayoutWin:showBuildingInfo(bdtype,level)

self:clearInfoTweener()
if self.force then return end
self.bdInfoTweener=self.bdtipsroot:setChildDOAnchorPosY(-10,0.5)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdtype)
local stype=cfg.func_type
self.bdtipsicon:setSprite(self.imgAB,self.func_icons[stype])
self.bdtipsname:setText(FMT.fmt('<color={0}>{1}</color>',self.bd_name_colors[stype],cfg.name))
self.bdtipslevel:setText(FMT.fmt('{0}级',level))
self.bdtipsdesc:setText(cfg.desc or'...')
end

function UILayoutWin:hideBuildingInfo()

self:clearInfoTweener()
self.bdInfoTweener=self.bdtipsroot:setChildDOAnchorPosY(150,0.5)
end

function UILayoutWin:clearInfoTweener()
if self.bdInfoTweener then
self.bdInfoTweener:Kill()
self.bdInfoTweener=nil
end
end

function UILayoutWin.on_scenery_filter_change(index)
local page=_this.toPage or _this.page
if page then
_this.toPage=nil
_this.filterIndexs[page]=index
_this.bRefresh=true
_this:SelectPage(page)
end
end

function UILayoutWin:setFilter(datas,page)
if datas then
self.sceneryFilter:setActive(true)
self.currFilter={}
self.option={}
for i,v in ipairs(datas)do
table.insert(self.option,v[1])
table.insert(self.currFilter,v[2])
end
self.toPage=page
self.sceneryFilter:setChildComboBoxOption(self.filterIndexs[page],self.option)
else
self.sceneryFilter:setActive(false)
self.currFilter=nil
end
end

function UILayoutWin.on_sort_btn_click(clicknum,index)
if _this.selectId then
local item=_this.sortBtnScrollview:getChildScrollViewItemWidget(_this.selectId)
item:SetChildActive(0,false)
end

_this.selectId=index

local item=_this.sortBtnScrollview:getChildScrollViewItemWidget(_this.selectId)
if item then
item:SetChildActive(0,true)
end

_this.btnDatas[index+1].func()
_this:refreshBuildSuitButton()
end


function UILayoutWin:__delete()
self:leaveSkyModel()
CS.PlayerInput.Instance:UnBindJoyStick()
zongmenModel:clearAllActiveBuildReddot()
zongmenModel:clearAllActiveRoadReddot()
self:Cancel()
if self.model==3 or self.model==4 then
isometricMapSystem:cancelRoad(true)
end

self:unbindComponents()
_this=nil


if self.beginMark then
hudControl:removeHUD(self.beginMark.guid)
self.beginMark.widget=nil
end
if self.endMark then
hudControl:removeHUD(self.endMark.guid)
self.endMark.widget=nil
end

local page=self.indexToBuildTab[self.selectId+1]
UILayoutControl:setLayoutPage(page)

isometricMapSystem:hideGrid(mapLayer.Grid)
isometricMapSystem:clearAreaDraw()

notifySystem:removelistener(notifyConfig.building_event,self.handleBuildingEvent)

notifySystem:removelistener(notifyConfig.on_system_open,self.on_system_open)
notifySystem:removelistener(notifyConfig.on_money_changed,self._onMoneyChange)
isometricMapSystem:leaveLayoutModel()
end

function UILayoutWin.handleBuildingEvent(etype,sfId,bdId)
if not _this then return end
if isometricMapSystem:hasPreviewBuilding()then
_this:refreshApplyBtn()
local preview=isometricMapSystem:getPreviewBuilding()
local pCfgId=nil
local pos=_MapManager.GetTilemapObjectPosition(preview.guid)
_MapManager.SetPosition(preview.guid,pos)
if _this.hType==3 then
pCfgId=preview.cfg.pCfgId_m or preview.cfg.pCfgId
else
pCfgId=preview.cfg.pCfgId
end
if pCfgId then
isometricMapSystem:hideAreaDraw(nil,mapLayer.DrawRoad1)
isometricMapSystem:showAreaDraw(nil,TILE_TYPE.eXianMengGrid,mapLayer.DrawRoad1,pCfgId)
end
return
end
if etype==buildingEvent.buildStart then
_this:HandleApplyBuild(sfId,bdId)
elseif etype==buildingEvent.moveBuilding then
_this:HandleApplyMove()
elseif etype==buildingEvent.storageBuilding then
_this:HandleStorage()
elseif etype==buildingEvent.placeBuilding then
_this:HandleApplyPlace()
elseif etype==buildingEvent.removeBuilding then
_this:HandleRemove()
end
end






function UILayoutWin:refreshApplyBtn()
if self.isInSkyModel then
UIManager:invokeUIMethod('UISkyLayoutWin','refreshApplyBtn')
return
end

if self.hudWidget then
local preview=isometricMapSystem:getPreviewBuilding()
if preview then
local pCfgId=nil
if self.hType==3 then
pCfgId=preview.cfg.pCfgId_m or preview.cfg.pCfgId or conditionConfig.showPlace
else
pCfgId=preview.cfg.pCfgId or conditionConfig.showPlace
end
local canPlace=_MapManager.IsCanPlace(self.buildingGuid,pCfgId)
if canPlace~=self.rcPlaceState then
self.rcPlaceState=canPlace
self.hudWidget:SetChildCSImageSprite(2,self.hudAB,canPlace and'button_jzqueding'or'button_jzqueding_1')
end
end
end
end

function UILayoutWin:ChangeModel(model)
self.model=model
local showMsg=true
if model==1 then
isometricMapSystem:setLayoutMode(layoutMode.eBuild)
showMsg=false
else
isometricMapSystem:setLayoutMode(layoutMode.eLayout)

end
if model==1 then
self.selectpanel:setActive(true)
if self.inStorage then
self:onStorageBtn()
end
self:showStylePanel(false)
self.joyStickRoot:setActive(false)
self.deleteBtn:setActive(false)
elseif model==2 then
self.selectpanel:setActive(false)
self:showStylePanel(false)
self.joyStickRoot:setActive(false)
self.deleteBtn:setActive(false)
elseif model==3 then
self.selectpanel:setActive(false)
self.joyStickRoot:setActive(self.opRoadType==2)
self.deleteBtn:setActive(true)
elseif model==4 then
self.selectpanel:setActive(false)
self.joyStickRoot:setActive(self.opRoadType==2)
self.deleteBtn:setActive(true)
elseif model==5 then
self.selectpanel:setActive(false)
self:showStylePanel(false)
self.joyStickRoot:setActive(false)
self.deleteBtn:setActive(false)
self.roadJuanZhou:setActive(false)
elseif model==6 then
self.selectpanel:setActive(false)
self:showStylePanel(false)
self.joyStickRoot:setActive(false)
self.deleteBtn:setActive(false)
end
if model==5 then
self:showWindow("UILayoutEditWin",{rootWin=self})
self.showEditWin=true



self.leftPanel:setActive(false)
self.btnScrollviewBg:setActive(false)
self.btnScrollview:setActive(false)
self.closeBtn:setActive(false)
showMsg=false
else
self.btnScrollviewBg:setActive(not self.force)
self.btnScrollview:setActive(not self.force)
self.closeBtn:setActive(true)
self.leftPanel:setActive(true)
if self.showEditWin then
self:hideWindow("UILayoutEditWin")
self.showEditWin=nil
end
end
if model==6 then
self:toSkyModel()
showMsg=false
else
self:leaveSkyModel()
end
self:showMsgWin(showMsg)

if model>1 then
UIManager:hideWindow('UITopMoneyWin')
else
UIManager:showWindow('UITopMoneyWin')
end
end

function UILayoutWin:toSkyModel()
if self.isInSkyModel then
return
end
self.isInSkyModel=true
local mapId=zongmenModel:getMountainId()
local areas=cfgHelper.get2(cfg_monijysfconfig_get,mapId,'sky_layout_area')
for i,v in ipairs(areas)do
isometricMapSystem:showGridInRange(mapId,mapLayer.Grid2,v[1],v[2],TILE_TYPE.eSkyGrid,true)
end
isometricMapSystem:setCameraOrthoSize(6,0.5)
zongmenModel:setSkyBuildingClickEnable(mapId,true)
self.skyObjBtn:setActive(false)
self.surfaceObjBtn:setActive(true)
self:showWindow("UISkyLayoutWin",{rootWin=self,fastBuildId=self.skyFastBuildId})
self.skyFastBuildId=nil
if not isometricMapSystem:isShowSkyObject()then
zongmenModel:setSkyBuildingShow(mapId,true)
end
if not isometricMapSystem:isShowSurfaceObject()then
zongmenModel:setSurfaceBuildingShow(mapId,false)
end
self:changeSkyObjAnim(true)
end

function UILayoutWin:leaveSkyModel()
if not self.isInSkyModel then
return
end
self.isInSkyModel=false
local mapId=zongmenModel:getMountainId()
isometricMapSystem:hideGrid(mapLayer.Grid2)
_MapManager.SetCellCheckRange(false)
isometricMapSystem:setCameraOrthoSize(4,0.5)
zongmenModel:setSkyBuildingClickEnable(mapId,false)
self.skyObjBtn:setActive(true)
self.surfaceObjBtn:setActive(false)
self:closeWindow("UISkyLayoutWin")
if not isometricMapSystem:isShowSkyObject()then
zongmenModel:setSkyBuildingShow(mapId,false)
end
if not isometricMapSystem:isShowSurfaceObject()then
zongmenModel:setSurfaceBuildingShow(mapId,true)
end

self:changeSkyObjAnim(false)
end

function UILayoutWin:changeSkyObjAnim(bEnter)
local mapId=zongmenModel:getMountainId()
local datas=zongmenModel:getSkyBuildingDatas(mapId)
for k,v in pairs(datas)do
if v.entityId then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if cfg.layout_anim and not cfg.stand_behavior then
local animId=bEnter and eAnimationID[cfg.layout_anim]or eAnimationID.stand
_MapManager.RunAnimator(v.entityId,animId)
end
end
end
end

function UILayoutWin:RefreshGroundBtn()
local inMode=isometricMapSystem:isInGroundModel()
local widget=self.groundBtn:getWidgetBase()
widget:SetChildActive(0,not inMode)
widget:SetChildActive(1,inMode)
end

function UILayoutWin:freshNameBtn()
local inMode=isometricMapSystem:isInNameModel()
local widget=self.nameBtn:getWidgetBase()
widget:SetChildActive(0,not inMode)
widget:SetChildActive(1,inMode)
end

function UILayoutWin:freshSkyBtn()
local inMode=isometricMapSystem:isShowSkyObject()
local widget=self.skyObjBtn:getWidgetBase()
widget:SetChildActive(0,not inMode)
widget:SetChildActive(1,inMode)
end

function UILayoutWin:freshSurfaceBtn()
local inMode=isometricMapSystem:isShowSurfaceObject()
local widget=self.surfaceObjBtn:getWidgetBase()
widget:SetChildActive(0,not inMode)
widget:SetChildActive(1,inMode)
end

function UILayoutWin:showMsgWin(bShow)
if zongmenModel:getMountainId()~=mapIdType.zhufeng then
return
end
if bShow then
if isometricMapSystem:hasUnlinkRoad()then
UIManager:showWindow('UIBuildingMsgWin',{msgType=zmMsgType.unlinkRoad,showSpe=false})
end
else
UIManager:closeWindowWithLoading('UIBuildingMsgWin')
end
end




function UILayoutWin:onShow(argtable,afterOnloaded)
self.model=argtable.model>0 and argtable.model or 1
if self.model~=6 then
self:ChangeModel(self.model)
end

isometricMapSystem:createRoadMark(INSTANCE_TYPE.eBeginMark,function(data)
self.beginMark=data
self.beginMark.widget:SetChildActive(0,false)
end)
isometricMapSystem:createRoadMark(INSTANCE_TYPE.eEndMark,function(data)
self.endMark=data
self.endMark.widget:SetChildActive(0,false)
local widget=self.endMark.widget
widget:SetChildUIDragEvent(0,0,self.onArrowDown,self.onArrowUp,self.onArrowDrag)
widget:SetChildButtonClick(1,function()
self:onCancelClick()
end)
widget:SetChildButtonClick(2,function()
self:onApplyClick()
end)
end)

self.bdId=argtable.bdId
self.isBuild=argtable.isBuild
local page=argtable.sortType or UILayoutControl:getLayoutPage()
self.datas=self:GetBuildingConfigs()
self:initTabBtns()
local index=self.buildTabToIndex[page]
if index==nil then index=1 end
self.on_sort_btn_click(1,index-1)
self.bdId=nil
self.isBuild=nil

local entity=argtable.entity
if entity then
local bdData=zongmenModel:findBuildingByEntityId(entity)
self:PickUpBuilding(entity,bdData)
end

self:initFuncBtn()

if self.model==layoutMode.eLayout then


self.on_btns_click(1,1)
end
self.buildItemGUID=argtable.itemguid



self.force=argtable.forceBuildId~=nil
self.closeBtn:setActive(not self.force)
self.groundBtn:setActive(not self.force and not isometricMapSystem:isBanGroundModel())
self.nameBtn:setActive(not self.force)
self.skyObjBtn:setActive(self.isSkyOpen and not self.force and not _hideSkyBtn[self.sfId])
self.btnScrollview:setActive(not self.force)
self.btnScrollviewBg:setActive(not self.force)

if argtable.fastBuildId or argtable.forceBuildId then
if self.model~=6 then
self:handleFastBuild(argtable.fastBuildId or argtable.forceBuildId)

self:SetTips(argtable.forceBuildTips)

else
self.skyFastBuildId=argtable.fastBuildId
local skIndex=self.funcBtnIndex[_btnType.Sky]
self.on_btns_click(0,skIndex-1)
end
else
self:SetTips()
end

self:RefreshGroundBtn()
self:freshNameBtn()
self:freshSkyBtn()
self:freshSurfaceBtn()


end

function UILayoutWin:checkShowInList(cfg)
if cfg.cnd_show then
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,cfg.id,1)
if zongmenControl:checkLevelUp(levelCfg)then
return true
end
return false
end
return true
end

function UILayoutWin:checkYSFShowCondition(cfg)
if cfg.id==SLG_SYSTEM_TYPE.eYuShouFang then
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,cfg.id,1)
local checkCND,data=zongmenControl:checkCondition(levelCfg)
return checkCND
end
return true
end

function UILayoutWin:GetBuildingConfigs()
local cfgs=cfg_monijybuildconfig()
local level=zongmenModel:getLevel()
local list={}

local buildTab=BUILD_TAB_TYPE.eJingGuan
list[buildTab]={}
local ltb=list[buildTab]


local roadlist=self:getStyleData(1)
for _,id in pairs(roadlist)do
local v=cfg_roadstyleconfig_get(id)
table.insert(ltb,{cfg=v,id=v.id,sortVal=1,type=1,sw=v.sort_weights or 0})
end

local qianglist=self:getStyleData(2)
for _,id in pairs(qianglist)do
local v=cfg_roadstyleconfig_get(id)
table.insert(ltb,{cfg=v,id=v.id,sortVal=1,type=1,sw=v.sort_weights or 0})
end


local activeBuilds=zongmenModel:getActiveBuild()
for i,v in ipairs(activeBuilds)do
local bdId=v
local cfg=cfgHelper.get(cfg_monijybuildconfig_get,bdId)
local buildTab=cfg.buildTab
local tb=list[buildTab]or{}
local sortVal=2
if zongmenModel:hasActiveBuildReddot(bdId)then
sortVal=0
elseif zongmenModel:hasProductionBuildReddot(bdId)or zongmenModel:hasFunctionBuildReddot(bdId)then
sortVal=1
end
local show=true

if self.sfId==mapIdType.fort and cfg.mountain and not cfg.mountain[self.sfId]then
show=false
end
if show then
table.insert(tb,{cfg=cfg,id=v,sortVal=sortVal,type=0,sw=cfg.sort_weights or 0})
end
list[buildTab]=tb
end

for k,v in pairs(cfgs)do
if v.id==88 or v.id==89 then

end
if level>=v.show_level and v.buildTab>0 and self:checkShowInList(v)and(not v.mountain or v.mountain[self.sfId])and self:checkYSFShowCondition(v)then
local curr=zongmenModel:getBuildingCount(v.id,self.sfId)
local max=zongmenModel:getBuildingMaxNum(v.id,self.sfId)
local show=true
local buildTab=v.buildTab
if zongmenModel:isActiveBuild(v.id)or v.activate_cost then
show=false
end

if buildTab==BUILD_TAB_TYPE.eJingGuan and self.sfId==mapIdType.fort and max==0 then
show=false
end
local itemid=nil

if buildTab==BUILD_TAB_TYPE.eHoldJingGuan then
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,v.id,1)
local canBuildCount=zongmenControl:getCanbuildCount(lcfg)
show=show and canBuildCount>0 or false
if lcfg.uplevel_cost and next(lcfg.uplevel_cost)then
itemid=lcfg.uplevel_cost[1][1]
end
end
if show then
local tb=list[buildTab]or{}
local isfull=max>0 and curr>=max
local sortVal=self:isBuildingUnlock(v)and 2 or 3
if sortVal==2 and isfull then
sortVal=4
elseif zongmenModel:hasProductionBuildReddot(v.id)or zongmenModel:hasFunctionBuildReddot(v.id)then
sortVal=1
end
table.insert(tb,{cfg=v,id=v.id,sortVal=sortVal,type=0,sw=v.sort_weights or 0,itemid=itemid})
list[buildTab]=tb
end
end
end

for k,v in pairs(list)do
if#v==0 then
list[k]=nil
end
end

for k,v in pairs(list)do
if#v==0 then
list[k]=nil
else
table.sort(v,function(a,b)
if a.sortVal<b.sortVal then
return true
elseif a.sortVal>b.sortVal then
return false
else
if a.sw>b.sw then
return true
elseif a.sw==b.sw then
return a.id<b.id
else
return false
end
end
end)
end
end
local buildTab=BUILD_TAB_TYPE.eShop
local dl=list[buildTab]
if not self.likeDatas and dl then
self.likeDatas=zongmenControl:countLikeDatas(dl)
end

if dl then
table.sort(dl,function(a,b)
local v1=self.likeDatas[a.id]
local v2=self.likeDatas[b.id]
if v1>v2 then
return true
elseif v1==v2 then
return a.id<b.id
else
return false
end
end)
end

return list
end

function UILayoutWin:GetCondition(data,ctype)
for i,v in ipairs(data)do
if v.type==ctype then
return v.param
end
end
end

function UILayoutWin:getFilterData()
local datas=self.datas[self.page]or{}
if not self.currFilter then
return datas
end
local index=self.filterIndexs[self.page]
local ftype=self.currFilter[index+1]
if ftype==0 then
return datas
end
local rlist={}
for i,v in ipairs(datas)do
if v.cfg.filter_type==ftype then
table.insert(rlist,v)
end
end
return rlist
end

function UILayoutWin:InitBuilding(page)
if self.page==page and not self.bRefresh then
return
end
if self.bRefresh then
self.bRefresh=false
end
self.page=page

self.datas=self:GetBuildingConfigs()
self:initTabBtns()

local datas=self:getFilterData()

self.filterDatas=datas
self.buildScrollview:setChildScrollViewCreateGrids(#datas,0)
local grids=self.buildScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
local select
local isShop=page==BUILD_TAB_TYPE.eShop
for i=0,count-1 do
local data=datas[i+1]
local cfg=data.cfg
local btype=data.type
local item=grids[i]
if btype==0 then
self:setNormalBuildingItem(item,cfg,isShop,i)
elseif btype==1 then
self:setRoadItem(item,cfg)
end
if cfg.id==self.bdId then
select=i
end
end
if isShop and count>0 then
self:setBuildCount(true,datas[1].id)
else
self:setBuildCount()
end
if self.placeIndex then
select=self.placeIndex
end
if select then
self.bdId=nil
self.buildScrollview:setChildScrollViewSelectItem(select,false,false,false)
self.placeIndex=nil
if self.isBuild then
self.isBuild=nil
self.on_item_click(1,select)
end
end
end

function UILayoutWin:setRoadPrice(id)
local rcfg=cfgHelper.get1(cfg_roadstyleconfig_get,id)
self.road_price=rcfg.cost and rcfg.cost[1]
end

function UILayoutWin:isCanCreateRoad(count)
if not self.road_price then
return true
end
local have=moneyModel.getMoney(self.road_price[1])
local pay=count*self.road_price[2]
return have>=pay
end

function UILayoutWin:setRoadItem(item,cfg)
item:SetChildText(0,cfg.name)
item:SetChildButtonClick(9,function()
self:onRoadItemClick(cfg.id)
end,true)



item:SetChildIcon(1,cfg.icon,true)
item:SetChildWeakGuideComponentId(9,FMT.fmt('UILayoutWin.UILayoutBuildItem_{0}.root_wg',cfg.id))
item:SetChildText(2,'')
item:SetChildActive(17,false)
item:SetChildActive(5,true)
item:SetChildActive(7,false)
item:SetChildActive(10,false)
item:SetChildActive(11,false)
item:SetChildActive(12,false)
item:SetChildActive(13,false)
item:SetChildText(14,'')
item:SetChildActive(15,false)
item:SetChildActive(16,zongmenModel:hasActiveRoadReddot(cfg.id))
item:SetChildActive(20,false)
if cfg.cost then
item:SetChildActive(5,false)
local v1=self:SetCostText(3,item,cfg.cost[1])
local v2=self:SetCostText(4,item,cfg.cost[2])
item:SetChildActive(8,v1==false or v2==false)
else
item:SetChildActive(5,true)
item:SetChildText(5,cfg.desc)
item:SetChildActive(3,false)
item:SetChildActive(4,false)
item:SetChildActive(8,false)
end
end

function UILayoutWin:clearStyle()
self.showStyle=false
self.styleCfgs={}
self:closeStyleAni()
end

function UILayoutWin:showStylePanel(vis)
if self.stylePanelVis~=vis then

self.stylePanel:setActive(vis)
self.stylePanelVis=vis
end
end

function UILayoutWin:freshStyle()
local len=#self.styleCfgs
local showStyle=len>=1

self.showStyle=showStyle
self:showStylePanel(showStyle)
self:setJuanZhou()
self.styleArrowBtn:setActive(self.opRoadType==2)


if showStyle then
local roadtype=self.roadtype
local typeName=roadtype==1 and'道路'or'墙壁'
local titleSprite=_titleSprite[roadtype]
self.styleTitle:setSprite(_titleBundle,titleSprite)
end
end

function UILayoutWin:setJuanZhou()
if self.showStyle then
local show=self.opRoadType==1
self.roadJuanZhou:setActive(true)
if not show then
self:visStyleRoot()
end
self:playStyleAni(show)
else
self:closeStyleAni()
end
end

function UILayoutWin:closeStyleAni()
self:visStyleRoot(false)
self.roadJuanZhou:setActive(false)
end

function UILayoutWin:playStyleAni(showAni)
self.showJuanZhouAni=showAni
self:playJuanZhou()
end

function UILayoutWin:visStyleRoot()
if self.styleTimer then
self:stopTimerByID(self.styleTimer)
self.styleTimer=nil
end
local vis=self.model==3 and self.opRoadType==1
if vis then
self:freshStyleView()
end
end

function UILayoutWin:playJuanZhou()
if self.loadJuanZhouSpine==nil then
self.juanzhouiAction=function()
if self and not self.isClose then
self.loadJuanZhouSpine=true
self:showRoadView()
if self.showJuanZhouAni then
self:visStyleRoot()
end
end
end
self.roadJuanZhou:setChildUIModelShowTarget(4049,1,{},self.showJuanZhouAni and 100 or 20,false,false,0,self.juanzhouiAction)
else
local delay=self:showRoadView()
if self.showJuanZhouAni then
self:visStyleRoot()
end
end
end

function UILayoutWin:showRoadView()
if not self.loadJuanZhouSpine then return end
local show=self.showJuanZhouAni
if show then
if self.JuanZhouAni==100 then return end
self.roadJuanZhou:setChildModelAnimationState(100)
self.JuanZhouAni=100
else
if self.JuanZhouAni==20 then return end
self.roadJuanZhou:setChildModelAnimationState(20)
self.JuanZhouAni=20
self.winlua:SetChildScrollViewPlayExitAni(self.styleScrollView:getID())
self.doAni=nil
end
return true
end

function UILayoutWin:getStyleData(roadtype)
local roadtype=roadtype or self.roadtype
local mapid=zongmenModel:getMountainId()
local cfg=cfg_monijysfconfig_get(mapid)

local road_menu=cfg.road_menu or{}
local defaultId=self.defaultRoadId[roadtype]
local defaultList={defaultId}
if cfg.hide_road then
defaultList={}
end
local temp=road_menu[roadtype]
if temp==nil or#temp==0 then
temp=defaultList
end
local t={}
for _,v in ipairs(temp)do
local cfg=cfg_roadstyleconfig_get(v)
if zongmenModel:isActiveRoad(v)and cfg.allow_place then
t[#t+1]=v
end
end
return t
end

function UILayoutWin:freshStyleView()
local cfgs=self.styleCfgs
local len=#cfgs
self.styleRoot:setActive(true)
self.styleScrollView:setChildScrollViewCreateGrids(len,0,self.doAni==nil)
self.doAni=true
local grids=self.styleScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local id=cfgs[i+1]
local cfg=cfg_roadstyleconfig_get(id)
local name=cfg.name
local cost=cfg.cost
local hasCost=cost~=nil
local icon=cfg.icon
local isNew=false

item:SetChildText(0,name)
item:SetChildIcon(1,cfg.icon,true)
item:SetChildButtonClick(2,function()
self:onRoadItemClick(cfg.id)
end,true)
self:SetCostText(3,item,hasCost and cost[1]or nil)
self:SetCostText(4,item,hasCost and cost[2]or nil)
item:SetChildText(5,'')
item:SetChildActive(6,isNew)

item:SetChildActive(7,false)
end
end

function UILayoutWin:onPlayStyleAniFinish(isEnter,isFinish)
if not isEnter and isFinish then
self.styleRoot:setActive(false)
end
end

function UILayoutWin:onStyleItemClick(id)
if self.selectStyleId==id then return end
self.selectStyleId=id
isometricMapSystem:setCurrentRoadType(id)
self:freshStyle()
end

function UILayoutWin:onRoadItemClick(id)
local rcfg=cfgHelper.get1(cfg_roadstyleconfig_get,id)
self.road_price=rcfg.cost and rcfg.cost[1]
self.roadtype=rcfg.func
self.selectRoadId=id
local lastSelect=self.fbSelectId
if self.roadtype==1 then
self:onChangeRoad(self.roadtype,2)
self.fbSelectId=3
else
self:onChangeRoad(self.roadtype,2)
self.fbSelectId=4
end
if lastSelect then
self:freshBtnSelect(lastSelect)
end
self:freshBtnSelect(self.fbSelectId)
self:hideBuildingInfo()
isometricMapSystem:hideBuffArea()
isometricMapSystem:cancelRoad()
self:ShowMarkPos(false,false)
end

function UILayoutWin:setNormalBuildingItem(item,cfg,isShop,index)
local bdId=cfg.id
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdId,1)
item:SetChildText(0,cfg.name)
item:SetChildButtonClick(9,function()self.on_item_click(1,index)end,true)



item:SetChildIcon(1,cfg.icon,true)
item:SetChildNewBieComponentId(9,FMT.fmt('UILayoutWin.UILayoutBuildItem_{0}.root',bdId))
item:SetChildWeakGuideComponentId(9,FMT.fmt('UILayoutWin.UILayoutBuildItem_{0}.root_wg',bdId))
local needSys=cfg.build_system
local isFS=bdId==SLG_SYSTEM_TYPE.eDuoRen or bdId==SLG_SYSTEM_TYPE.eDanRen
local isShowTips=false
local holdJingGuan=self.page==BUILD_TAB_TYPE.eHoldJingGuan
if holdJingGuan then
item:SetChildAnchoredPos(1,0,85)
else
item:SetChildAnchoredPos(1,0,115)
end

local cnd=self:GetCondition(lcfg.uplevel_condition,1)
cnd=cnd and zongmenControl:getMinNeedLevel(cfg)
local isXMMap=zongmenModel:getMountainId()==mapIdType.xianmeng
local checkLevel=false
if isXMMap then
local level=xianmengModel:getXMLevel()
checkLevel=cnd>(level or 0)
else
checkLevel=cnd>zongmenModel:getLevel()
end
local isActiveBuild=zongmenModel:hasActiveBuildReddot(bdId)
item:SetChildActive(15,false)
item:SetChildActive(16,isActiveBuild)
local isRed=zongmenModel:hasProductionBuildReddot(bdId)or zongmenModel:hasFunctionBuildReddot(bdId)
item:SetChildActive(20,isRed)

local checkOpen=needSys and not systemModel.isOpen(needSys)
if checkLevel or checkOpen then
item:SetChildText(2,'')
item:SetChildActive(17,false)
item:SetChildActive(3,false)
item:SetChildActive(4,false)
item:SetChildActive(5,true)
if checkOpen then
local tips=((cfg.build_tips or{})[1]or{})[1]or'未配置'
item:SetChildText(5,tips)
else
if isXMMap then
item:SetChildText(5,FMT.fmt(cfgHelper.getlang('layout_win_txt_2'),cnd))
else
item:SetChildText(5,FMT.fmt(cfgHelper.getlang('layout_win_txt_1'),cnd))
end
end
item:SetChildActive(8,false)
item:SetChildActive(10,false)
item:SetChildActive(11,false)
item:SetChildActive(12,false)
item:SetChildText(14,'')
isShowTips=true
else
cnd=self:GetCondition(lcfg.uplevel_condition,2)
if cnd and not taskModel:checkTaskFinish(cnd)then
item:SetChildText(2,'')
item:SetChildActive(17,false)
item:SetChildActive(3,false)
item:SetChildActive(4,false)
item:SetChildActive(5,true)

item:SetChildText(5,cfg.build_tips[2][1])
item:SetChildActive(8,false)
item:SetChildActive(10,false)
item:SetChildActive(11,false)
item:SetChildActive(12,false)
item:SetChildText(14,'')
isShowTips=true
else
cnd=self:GetCondition(lcfg.uplevel_condition,3)
local sfId=zongmenModel:getMountainId()
local check,ncount=zongmenModel:checkBuildingWithCondition(sfId,cnd)
if cnd and not check then
item:SetChildText(2,'')
item:SetChildActive(17,false)
item:SetChildActive(3,false)
item:SetChildActive(4,false)
item:SetChildActive(5,true)
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,cnd[1])
item:SetChildText(5,string.format('%s级%s<color=#db3f3f>%s/%s</color>座',cnd[3],bdcfg.name,ncount,cnd[2]))
item:SetChildActive(8,false)
item:SetChildActive(10,false)
item:SetChildActive(11,false)
item:SetChildActive(12,false)
item:SetChildActive(13,false)
item:SetChildText(14,'')
isShowTips=true
else
local curr=zongmenModel:getBuildingCount(bdId,self.sfId)
local max=zongmenModel:getBuildingMaxNum(bdId,self.sfId)
item:SetChildActive(5,false)
if isShop then
item:SetChildText(2,'')
item:SetChildActive(17,false)
else
if holdJingGuan then
local canBuildCount=zongmenControl:getCanbuildCount(lcfg)
item:SetChildText(14,FMT.fmt('拥有:{0}',canBuildCount))
item:SetChildText(2,'')
item:SetChildActive(17,false)
item:SetChildActive(15,true)
else
item:SetChildText(14,'')
if max>=999 then
item:SetChildText(2,'')
item:SetChildActive(17,false)
else
item:SetChildText(2,string.format('%s/%s',curr,max))
item:SetChildActive(17,true)
end
end
end
local isfull=max>0 and curr>=max
if isfull then
item:SetChildActive(3,false)
item:SetChildActive(4,false)
item:SetChildActive(8,false)
if isShop then
item:SetChildActive(10,false)
item:SetChildActive(11,true)
else
item:SetChildActive(10,true)
item:SetChildActive(11,false)
end
item:SetChildActive(12,false)
else
local v1=self:SetCostText(3,item,lcfg.uplevel_cost[1])
local v2=self:SetCostText(4,item,lcfg.uplevel_cost[2])
if holdJingGuan then
self:SetCostText(19,item,lcfg.uplevel_cost[1])
item:SetChildActive(3,false)
item:SetChildActive(4,false)
end
local showTips=v1==false or v2==false
item:SetChildActive(8,showTips)
item:SetChildActive(10,false)
item:SetChildActive(11,false)
if showTips then
isFS=false
end
local showHL=isFS and self:checkHomeless(bdId==SLG_SYSTEM_TYPE.eDuoRen)
item:SetChildActive(12,showHL)






end


if isActiveBuild then
local vis=lcfg.uplevel_cost==nil or#lcfg.uplevel_cost==0
item:SetChildActive(5,vis)
if vis then
item:SetChildText(5,cfg.desc or'')
end
end
end
end
end
item:SetChildActive(13,isShowTips)
if isShowTips then
item:SetChildButtonClick(13,function()self:onTipsClick(item,cfg)end)
end
item:SetChildActive(7,isShop)
if isShop then
item:SetChildText(6,self.likeDatas[bdId])
item:SetChildButtonClick(7,function(...)
local d={}
d.title='商铺规则'
d.mode=3
d.name='layoutwin_aixin_help_%d'
UIManager:showWindow('UIRuleWin',d)
end)
end
end

function UILayoutWin:checkReddot(cfg)
return zongmenModel:hasActiveBuildReddot(cfg.id)
end

function UILayoutWin:getPageReddot(page)
local datas=self.datas[page]or{}
for _,v in ipairs(datas)do
if self:checkReddot(v.cfg)then
return true
end
end
if page==BUILD_TAB_TYPE.eJingGuan then
return zongmenModel:hasAnyActiveRoadReddot()or zongmenBuildingSuitModel:checkReddot()
elseif page==BUILD_TAB_TYPE.eProduction then
return zongmenModel:hasAllProductionBuildReddot()
elseif page==BUILD_TAB_TYPE.eFunction then
return zongmenModel:hasAllFunctionBuildReddot()
end
return false
end

function UILayoutWin:clearPageReddot(page)
local datas=self.datas[page]or{}
for _,v in ipairs(datas)do
if self:checkReddot(v.cfg)then
zongmenModel:clearActiveBuildReddot(v.cfg.id)
end
end
if page==BUILD_TAB_TYPE.eJingGuan then
zongmenModel:clearAllActiveRoadReddot()
end
end

function UILayoutWin:onTipsClick(item,cfg)
self.tipspanel:setActive(true)
local itemPos=item:GetChildPosition(-1)
self.tipsRoot:setChildPosition(itemPos+Vector3(-1,1.5,0))
self.tipsBuildName:setText(cfg.name)
self.tipsDesc:setText(cfg.tipsdesc~=nil and FMT.fmt("  {0}",cfg.tipsdesc)or"")
end

function UILayoutWin:checkHomeless(isDuoRen)
local datas=UIDiscipleModel:getAllDiscipleData()
for k,v in pairs(datas)do
if not v.netData.net:check_in()then
local spdatas=UIDiscipleModel:getDiscipleSpecialityConfigByData(v.netData.net)
local duju
for ii,vv in ipairs(spdatas)do
if vv.specialitytype==4 and vv.id==21 then
duju=true
break
end
end
if isDuoRen then
if not duju then
return true
end
else
if duju then
return true
end
end
end
end
return false
end

function UILayoutWin:CheckMaxNum(sfId,id,showTips)
local count=zongmenModel:getBuildingCount(id,sfId)
local max=zongmenModel:getBuildingMaxNum(id,sfId)
if count>=max then
if showTips then
UIManager.error('已达到建造上限')
end
return false
end
return true
end

function UILayoutWin.on_item_click(clicknum,index)
_this:OnSelectItem(index)
end

function UILayoutWin:OnSelectItem(index)
self.placeIndex=index

if self.placeIndex then
local data=self.filterDatas[index+1]
if data then
local cfg=data.cfg
self:checkAndSelectBuilding(cfg,nil,data)
end
end
end

function UILayoutWin:isBuildingUnlock(cfg)
local needSys=cfg.build_system
if needSys and not systemModel.isOpen(needSys)then
return false
end

local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,cfg.id,1)
local check=zongmenControl:checkCondition(levelCfg,false)
return check
end

function UILayoutWin:checkAndSelectBuilding(cfg,level,data)
if isometricMapSystem:hasPreviewBuilding()then
return false
end

local needSys=cfg.build_system
if needSys and not systemModel.isOpen(needSys)then
local tips=((cfg.build_tips or{})[1]or{})[1]or'未配置build_tips'
UIManager.error(tips)
return false
end

local flag,lvupData=self:checkCost(cfg.id,1)
if not flag then
if lvupData~=nil and lvupData[1]==0 then

UIDiscipleController.doTriggerSomething(dzTriggerDoSomething.ePrivateMoney,{lvupData[2],lvupData[3]})
end
return false
end

if not self:CheckMaxNum(self.sfId,cfg.id,true)then
return false
end

local isShop=self.page==BUILD_TAB_TYPE.eShop
if isShop and not self.hideTips then
if self.likeDatas[cfg.id]<=0 then
local tips=cfgHelper.get1(cfg_lang_get,'layout_shop_build_tips')
UIDialogManager.getCommonDialog('提示',tips,function()
self:handleSelectItem(cfg,level,data)
end)
return false
end
end
self:handleSelectItem(cfg,level,data)

return true
end

function UILayoutWin:findIndex(bdId)
for k,v in pairs(self.datas)do
for i,vv in ipairs(v)do
if vv.cfg.id==bdId then
return k,i
end
end
end
return 1,1
end

function UILayoutWin:handleFastBuild(bdId)
self.fastBuildId=bdId
local p,i=self:findIndex(bdId)
self.placeIndex=i-1
self.page=p
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
self:checkAndSelectBuilding(cfg)
end

function UILayoutWin:handleFastBuildEx(bdId)
self.fastBuildId=bdId
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
self:checkAndSelectBuilding(cfg)
end

function UILayoutWin:getBDShowPos()
if self.lastBDPos then
return self.lastBDPos
else
local mapId=zongmenModel:getMountainId()
return _MapManager.ScreenPointToCell(mapId,Vector3.New(_Screen.width*0.5,_Screen.height*0.5,0),0,mapLayer.Data)
end
end

function UILayoutWin:checkCost(id,level)
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,level)
return zongmenControl:checkLevelUp(levelCfg,true,nil,true)
end

function UILayoutWin:handleSelectItem(cfg,lv,tabData)
self:ChangeModel(2)

self.hType=1

local level=lv or 1
local bpos=self:getBDShowPos()
local useDefPos=not self.first_build_check[cfg.id]
self.first_build_check[cfg.id]=true

local func=function(data)
if not _this then
hudControl:removeHUD(data.hudId)
_MapManager.RemoveTilemapObject(data.guid)
return
end

if not isometricMapSystem:hasPreviewBuilding()then
return
end

self:showBuildingInfo(cfg.id,level)

local building=data
local guid=building.guid
self.buildingGuid=guid
isometricMapSystem:setEditorMode(editorMode.ePlace)
isometricMapSystem:setPlaceObject(guid)

self.hudWidget=hudControl:getHUDWidget(building.hudId)
local clickCancel=function()
if not self.force then
self:Cancel()
self.bRefresh=true
self.on_sort_btn_click(1,self.selectId)
self.hudWidget=nil
self.fastBuildId=nil
self:hideBuildingInfo()
end
end
self.hudWidget:SetChildActive(0,not self.force)
local showOrientation=self:isShowOrientation(cfg,building.bdData)
self.hudWidget:SetChildActive(1,showOrientation)
self.hudWidget:SetChildButtonClick(0,clickCancel)
self.hudWidget:SetChildButtonClick(1,function()
isometricMapSystem:setflipX(guid,building.bdData,building.orientation==0,cfg.model[1])
building.orientation=building.orientation==0 and 1 or 0
self:refreshApplyBtn()
end)
local clickFunc=function()
if self:IsCanPlace(guid,cfg.pCfgId or conditionConfig.showPlace)then

isometricMapSystem:receiveSundriesByEntityArea(guid)

AudioManager.playAudio(432)
local pos=isometricMapSystem:getObjectPosValue(guid)

local sendGUID=self.buildItemGUID
if tabData and tabData.itemid and sendGUID==nil then
local filter={}
filter[ITEM_FILTER_TYPE.eItemid]=tabData.itemid
local itemlist=bagControl.getBagItemsByFilter(ITEM_MAIN_TYPE.eItem,filter,false)
if itemlist then
local k,item=next(itemlist)
if item then
sendGUID=item.itemguid
self.fastBuildId=cfg.id
end
end

end
zongmenControl:reqBuild(self.sfId,cfg.id,pos[1],pos[2],building.orientation,building.modelIndex,nil,sendGUID)
end
end




self.hudWidget:SetChildButtonClick(2,clickFunc)
self.hudWidget:SetChildActive(3,false)
self.hudWidget:SetChildActive(4,false)

isometricMapSystem:showBuffArea(guid)
self:refreshApplyBtn()
end

local args={
id=cfg.id,

cfg=cfg,
level=level,
pos=bpos,
useDefPos=useDefPos,
callback=func,
pCfgId=cfg.pCfgId or conditionConfig.showPlace,
force=self.force,






}
isometricMapSystem:createBuilding(args)

if cfg.pCfgId then
isometricMapSystem:hideAreaDraw(nil,mapLayer.DrawRoad1)
isometricMapSystem:showAreaDraw(nil,TILE_TYPE.eXianMengGrid,mapLayer.DrawRoad1,cfg.pCfgId)
end
end

function UILayoutWin:HandleApplyBuild(sfId,bdId)
self:hideBuildingInfo()

local bdData=zongmenModel:getBuildingData(bdId)
self.lastBDPos=_MapManager.ToVector3Int(bdData.x,bdData.y,0)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)

local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,cfg.id,1)
for i,v in ipairs(levelCfg.uplevel_cost)do
hudControl:showRewardTips(bdData.entityId,v[1],-v[2],{-1,0})
end

self.hudWidget=nil
self.hType=0
isometricMapSystem:hideBuffArea()
if self.fastBuildId then
self:onCloseBtn()
return
end

if self:CheckMaxNum(self.sfId,cfg.id)and not newbieControl.isInNewbie()then
if self:checkCost(cfg.id,1)then
self.hideTips=true
self:OnSelectItem(self.placeIndex)
self.hideTips=false
else
self:onCloseBtn()
end
else
self:onCloseBtn()
end
end



function UILayoutWin:GetStorageDatas()
local mapId=zongmenModel:getMountainId()
local datas={}
if mapId==mapIdType.xianmeng then
datas=xianmengModel:getStorageDatas()
else
datas=zongmenModel:getAllstorageBuilding()
end

local list={}
local typeList={}
local count=0
for k,v in pairs(datas)do
local btype=v.build_id

local show=true

local config=cfgHelper.get1(cfg_monijybuildconfig_get,btype)
if config.mountain and not config.mountain[self.sfId]then
show=false
end
if show then
local bdlist=list[btype]
if not bdlist then
bdlist={}
list[btype]=bdlist
end
table.insert(bdlist,v)
end

local typeVal=typeList[btype]
if not typeVal then
typeList[btype]=1
count=count+1
end
end
local rlist={}
for k,v in pairs(list)do
table.insert(rlist,v)
end
count=count
return rlist,count
end

function UILayoutWin:InitStorage()
if self.initStorage then
self.initStorage=true
return
end

local storages,sCount=self:GetStorageDatas()
self.storages=storages

self.storageScrollview:setChildScrollViewCreateGrids(#storages,0)
local grids=self.storageScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local dlist=storages[i+1]
local data=dlist[1]
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local item=grids[i]
local len=#dlist

item:SetChildText(0,cfg.name)
local check=len>1
item:SetChildActive(2,check)
if check then
item:SetChildText(3,len>9 and'9+'or len)
end















item:SetChildIcon(1,cfg.icon,true)
end

self.sCount=sCount
self:setStorageNum()

self.storageTips:setActive(count<=0)

if self.placeIndex then
self.storageScrollview:setChildScrollViewSelectItem(self.placeIndex,true,false,false)
end
end

function UILayoutWin:setBuildCount(bShow,btype)
self.countRoot:setActive(bShow or false)
if bShow then
self.buildCount:setText(string.format('建造上限：%s/%s',
zongmenModel:getBuildingCount(btype,self.sfId),
zongmenModel:getBuildingMaxNum(btype,self.sfId)
))
end
end

function UILayoutWin:setStorageNum()

local maxNum=zongmenModel:getStorageMaxNum()
if maxNum>=9999 then
self.storageCount:setText('总收纳种类：无限')
self.addStorage:setActive(false)
else
self.storageCount:setText(string.format('总收纳种类：%s/%s',self.sCount,maxNum))
self.addStorage:setActive(false)
end
end

function UILayoutWin.on_storage_item_click(clicknum,index)
if not _this or _this.isClose then return end
_this:OnStorageItemSelect(index)
end

function UILayoutWin:OnStorageItemSelect(index)
if isometricMapSystem:hasPreviewBuilding()then
return
end

if not self.storageList then
self.storageList=self.storages[index+1]
end
local data=table.remove(self.storageList)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)

self.storageId=cfg.id





self:ChangeModel(2)

self.hType=2

local level=data.level
local bpos=self:getBDShowPos()
local useDefPos=not self.first_build_check[cfg.id]
self.first_build_check[cfg.id]=true

local func=function(bdata)
if not _this then
hudControl:removeHUD(bdata.hudId)
_MapManager.RemoveTilemapObject(bdata.guid)
return
end

if not isometricMapSystem:hasPreviewBuilding()then
return
end

self:showBuildingInfo(cfg.id,level)

local building=bdata
local guid=building.guid
self.buildingGuid=guid
isometricMapSystem:setEditorMode(editorMode.ePlace)
isometricMapSystem:setPlaceObject(guid)

self.hudWidget=hudControl:getHUDWidget(building.hudId)
self.hudWidget:SetChildButtonClick(0,function()
self:Cancel()
self.hudWidget=nil
self.initStorage=false
self.storageList=nil
self:hideBuildingInfo()
end)
self.hudWidget:SetChildButtonClick(1,function()
isometricMapSystem:setflipX(guid,building.bdData,building.orientation==0,cfg.model[1])
building.orientation=building.orientation==0 and 1 or 0
self:refreshApplyBtn()
end)
self.hudWidget:SetChildButtonClick(2,function()
if self:IsCanPlace(guid,cfg.pCfgId or conditionConfig.showPlace)then

isometricMapSystem:receiveSundriesByEntityArea(guid)

AudioManager.playAudio(432)
local pos=isometricMapSystem:getObjectPosValue(guid)
zongmenControl:reqPlaceBuilding(self.sfId,data.un_build_id,pos[1],pos[2],building.orientation,building.modelIndex)
end
end)
local showOrientation=self:isShowOrientation(cfg,building.bdData)
self.hudWidget:SetChildActive(1,showOrientation)
self.hudWidget:SetChildActive(3,false)
self.hudWidget:SetChildActive(4,false)

isometricMapSystem:showBuffArea(guid)
self:refreshApplyBtn()
end

local args={
id=cfg.id,
skinId=data.build_appearance_id,
cfg=cfg,
level=level,
pos=bpos,
useDefPos=useDefPos,
callback=func,
pCfgId=cfg.pCfgId or conditionConfig.showPlace,
force=self.force,






}
isometricMapSystem:createBuilding(args)
if cfg.pCfgId then
isometricMapSystem:hideAreaDraw(nil,mapLayer.DrawRoad1)
isometricMapSystem:showAreaDraw(nil,TILE_TYPE.eXianMengGrid,mapLayer.DrawRoad1,cfg.pCfgId)
end
end

function UILayoutWin:HandleApplyPlace()
self:hideBuildingInfo()

self.hudWidget=nil
self.hType=0
isometricMapSystem:hideBuffArea()

if self.storageList then
if#self.storageList>0 then
if self:CheckMaxNum(self.sfId,self.storageId)then
self:OnStorageItemSelect(self.storageIndex)
return
end
else
self.storageList=nil
end
end

self.initStorage=false
self:ChangeModel(1)
self:onStorageBtn()
end



function UILayoutWin:showBuildingLinkSlot(bShow,data)
if bShow then
local linkSlot=isometricMapSystem:getLinkSlotId(data.build_id,data.flag)
isometricMapSystem:showLinkSlot(data.entityId,linkSlot)
else
isometricMapSystem:showLinkSlot(data,-1)
end
end

function UILayoutWin:PickUpBuilding(guid,bdData)
if isometricMapSystem:hasPreviewBuilding()then
return
end

self.hType=3

isometricMapSystem:onPickUpBuilding(guid,bdData,function(data)
if not isometricMapSystem:hasPreviewBuilding()then
return
end

self:showBuildingInfo(bdData.build_id,bdData.level)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local checkId=cfg.pCfgId_m or cfg.pCfgId or conditionConfig.showPlace
_MapManager.SetObjectPlaceCheckID(guid,checkId)

local building=data
self:showBuildingLinkSlot(false,guid)
self.buildingGuid=guid
self.hudWidget=hudControl:getHUDWidget(building.hudId)
local showOrientation=self:isShowOrientation(cfg,bdData)
self.hudWidget:SetChildActive(1,showOrientation)
local cancelFunc=function()
self:Cancel()
self.hudWidget=nil
self:showBuildingLinkSlot(true,bdData)
self:hideBuildingInfo()
end
self.hudWidget:SetChildButtonClick(0,cancelFunc)
self.hudWidget:SetChildButtonClick(1,function()
isometricMapSystem:setflipX(guid,building.bdData,building.orientation==0,cfg.model[1])
building.orientation=building.orientation==0 and 1 or 0
self:refreshApplyBtn()
end)
self.hudWidget:SetChildButtonClick(2,function()
if self:IsCanPlace(guid,checkId)then

isometricMapSystem:receiveSundriesByEntityArea(guid)

AudioManager.playAudio(432)
local pv=isometricMapSystem:getObjectPosValue(guid)
if pv[1]~=bdData.x or pv[2]~=bdData.y or bdData.orientation~=building.orientation then
zongmenControl:reqMoveBuilding(self.sfId,bdData.un_build_id,pv[1],pv[2],building.orientation)
else
cancelFunc()
end
end
end)
local showStorage=self:IsShowStorage(cfg,bdData)
self.hudWidget:SetChildActive(3,showStorage)
if showStorage then
self.hudWidget:SetChildButtonClick(3,function()
if self:isCanStorage(cfg,bdData,true)then
zongmenControl:reqStorageBuilding(self.sfId,bdData.un_build_id)
end
end)
end
local canSelete=cfg.is_destory~=0 and self:checkbuildDestoryConditionEx(building)
self.hudWidget:SetChildActive(4,canSelete)
if canSelete then
self.hudWidget:SetChildButtonClick(4,function()
local sfId=self.sfId
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eBuildingTearDown)
if cfg.del_tips and not check then
self.m_dialog=UIDialogManager.getConfirmDialog(self.m_dialog,'提示','拆除后将不可恢复，是否继续拆除？',
'确定','取消',function()
zongmenControl:reqDeleteBuilding(sfId,bdData.un_build_id)
end,nil,'今日不再提示',function(flag)

dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eBuildingTearDown,flag)
end,true)
self.m_dialog:show()
elseif cfg.destoy_return~=nil then
local args={
bdData=bdData,
sfId=sfId
}
self:showWindow("UIBuildRemoveRewardWin",args)
else
zongmenControl:reqDeleteBuilding(sfId,bdData.un_build_id)
end
end)
end
local pCfgId=cfg.pCfgId_m or cfg.pCfgId
if pCfgId then
_MapManager.SetObjectPlaceCheckID(guid,pCfgId)
isometricMapSystem:hideAreaDraw(nil,mapLayer.DrawRoad1)
isometricMapSystem:showAreaDraw(nil,TILE_TYPE.eXianMengGrid,mapLayer.DrawRoad1,pCfgId)
end
isometricMapSystem:showBuffArea(guid)
end)
end

function UILayoutWin:IsShowStorage(cfg,bdData)
if emergenciesControl:isBuildingOnFire(bdData.entityId)then
return false
end
if cfg.is_collect==0 then
return false
end

if cfg.build_type==SLG_SYSTEM_TYPE.eLianDanFang then
return true
end
if bdData.flag>0 or bdData.plant_id>0 then
return false
end
return true
end

function UILayoutWin:isShowOrientation(cfg,bdData)
if cfg.is_orientation==0 then
return false
end
return true
end

function UILayoutWin:isCanStorage(cfg,bdData,wraning)
if emergenciesControl:isBuildingOnFire(bdData.entityId)then
return false
end
local maxNum=zongmenModel:getStorageMaxNum()
local storages,sCount=self:GetStorageDatas()

if sCount>=maxNum then
if wraning then
if zongmenModel:isMountainUnlock(mapIdType.fort)then
UIManager.error('宗门和堡垒总收纳数量已满')
else
UIManager.error('建筑总收纳空间已满')
end
end
return false
end
if cfg.win_type==8 then
if not UIShouLanModel:isCanStorage(bdData.un_build_id)then
if wraning then
UIManager.info('需清空兽栏')
end
return false
end
end
if cfg.win_type==sysWinType.eShangPu then
if UIShopControl:checkCreatingEx(bdData)then
if wraning then
UIManager.info('商铺正在生产中，无法收纳')
end
return false
end
end
if bdData and bdData.build_id==SLG_SYSTEM_TYPE.eTianGongGe then
local sfid,un_build_id=zongmenModel:getMountainId(),bdData.un_build_id
if LZDiaoKeModel:CheckDKState(sfid,un_build_id)==LZDKSTATE.eDKing then
if wraning then
UIManager.info('正在雕刻中，无法收纳')
end
return false
end
end
return true
end

function UILayoutWin:HandleApplyMove()
self:hideBuildingInfo()
self.hudWidget=nil
self.hType=0
isometricMapSystem:hideBuffArea()
end

function UILayoutWin:HandleStorage()
self:hideBuildingInfo()
self.hudWidget=nil
self.hType=0
isometricMapSystem:hideBuffArea()
end

function UILayoutWin:HandleRemove()
self:hideBuildingInfo()
self.hudWidget=nil
end



function UILayoutWin:IsCanPlace(guid,pcfg)
if _MapManager.IsCanPlace(guid,pcfg or conditionConfig.place)then
return true
end
UIManager.error('该位置无法放置建筑')
return false
end

function UILayoutWin:Cancel(changeModel)
if self.hType==1 or self.hType==2 then
isometricMapSystem:cancelBuild()
self:ChangeModel(1)
self.lastBDPos=nil
elseif self.hType==3 then
isometricMapSystem:cancelPickUp()
self.hudWidget=nil
end
if not changeModel then
self.selectRoadId=nil
end
self.hType=0
isometricMapSystem:hideBuffArea()
end

function UILayoutWin:SetCostText(index,item,cost)
if not cost then
item:SetChildActive(index,false)
return
end
item:SetChildActive(index,true)
local node=item:GetChildWidgetBase(index)
local mtype=cost[1]
local need=cost[2]
local have
if moneyConfig.isMoney(mtype)then
have=moneyModel.getMoney(mtype)
else
have=bagModel.getItemCountById(mtype)
end
local enough=have>=need
if enough then
node:SetChildText(0,need)
else
node:SetChildText(0,string.format('<color=#c82c2c>%s</color>',need))
end
node:SetChildIcon(1,iconHelper.getIconName(mtype),false)
return enough
end

function UILayoutWin:SetTips(tips)

if tips then
self.tipsbg:setActive(true)
self.tips:setText(tips)
else
self.tipsbg:setActive(false)
self:setCostTips()
end
end


function UILayoutWin:setCostTips(cost)
if self.model==5 then
return
end
self.tipsCostRoot:setActive(cost~=nil)
if cost then
local itemid=cost[1]
local need=cost[2]
local iconname=iconHelper.getIconName(itemid)
local has=itemsModel.getCount(itemid)
local enough=has>=need
local str=mathHelper.formatNumber3(need)
local countStr=enough and str or FMT.cfmt(FONT_COLOR.eRedColor,str)
self.tipsCostIcon:setIcon(iconHelper.getIconName(itemid))
self.tipsCost:setText(countStr)
end
end

function UILayoutWin:checkbuildDestoryConditionEx(building)

if building.bdData.flag==buildingStateType.eBuilding then
return false
end

if building.bdData.flag==buildingStateType.eUpgrading then
return false
end

if building.bdData.build_id==SLG_SYSTEM_TYPE.eDuoRen then
return systemModel.isOpen(SYSTEM_DEFINE.eMutipleRoomExtend)
end

return true
end




function UILayoutWin:OnEnable()

end


function UILayoutWin:OnDisable()

end



function UILayoutWin:SetBeginMarkPos(pos)
local mapId=zongmenModel:getMountainId()
hudControl:setHUDTargetPosition(self.beginMark.guid,mapId,pos)
end

function UILayoutWin:SetEndMarkPos(pos,count)
local mapId=zongmenModel:getMountainId()
hudControl:setHUDTargetPosition(self.endMark.guid,mapId,pos)
if self.road_price then
self.crPay=count*self.road_price[2]
self.isCanCR=isometricMapSystem:getEditorMode()~=editorMode.eCreateRoad or self:isCanCreateRoad(count)
self.endMark.widget:SetChildCSImageSprite(2,_this.hudAB,self.isCanCR and'button_jzqueding'or'button_jzqueding_1')
else
self.isCanCR=true
end
end

function UILayoutWin:ShowMarkPos(v1,v2)
if self.beginMark then
self.beginMark.widget:SetChildActive(0,v1)
end
if self.endMark then
self.endMark.widget:SetChildActive(0,v2)
end
end

function UILayoutWin:onBuildBtn()
self.opRoadType=nil
if self.model>2 then
isometricMapSystem:cancelRoad(true)
self:ShowMarkPos(false,false)
end
if not(self.hType==1 or self.hType==2)then
self:ChangeModel(1)
end
self:clearStyle()
self:SetTips(self.forceTips)
self:Cancel(true)
end

function UILayoutWin:onLayoutBtn()
self.opRoadType=nil
if self.hType==1 or self.hType==2 then
isometricMapSystem:cancelBuild()
self.hudWidget=nil
end
if self.model>2 then
self:ChangeModel(2)
isometricMapSystem:cancelRoad(true)
self:ShowMarkPos(false,false)

else
self:ChangeModel(2)
end
self:clearStyle()
self:SetTips('点击建筑调整布局')
end

function UILayoutWin:onDesignBtn()
self.opRoadType=nil
if self.hType==1 or self.hType==2 then
isometricMapSystem:cancelBuild()
self.hudWidget=nil
end
if self.model>2 then
isometricMapSystem:cancelRoad(true)
self:ShowMarkPos(false,false)
end

self:clearStyle()
self:Cancel(true)
self:SetTips()
self:ChangeModel(5)
end

function UILayoutWin:onSkyBtn()
self.opRoadType=nil
if self.hType==1 or self.hType==2 then
isometricMapSystem:cancelBuild()
self.hudWidget=nil
end
if self.model>2 then
isometricMapSystem:cancelRoad(true)
self:ShowMarkPos(false,false)
end

self:clearStyle()
self:Cancel(true)
self:SetTips()
self:ChangeModel(6)
end



function UILayoutWin:onChangeRoad(rtype,opType)

self.opRoadType=opType
self:setCostTips()

local isChangeRoadType=self.roadtype~=rtype
self.roadtype=rtype

self.styleCfgs=self:getStyleData(rtype)


local styleId=self.selectRoadId or self.styleCfgs[1]or
self.defaultRoadId[rtype]

local len=#self.styleCfgs
self.selectStyleId=styleId


if isChangeRoadType then
self:setRoadPrice(styleId)
isometricMapSystem:hideBuffArea()
isometricMapSystem:cancelRoad()
self:ShowMarkPos(false,false)
end



isometricMapSystem:setCurrentRoadType(styleId)

if(opType==1 or opType==nil)and len>1 then
self:onCreateRoadBtn()
else
self:onChangeCreateRoadMode()
end

self.isDelete=false
self.deleteSelect:setActive(self.isDelete)
self.deleteNomal:setActive(not self.isDelete)

isometricMapSystem:reDrawPath()
end


function UILayoutWin:onCreateRoadBtn()
local lastMode=self.model
self.opRoadType=1
self:Cancel()
self:ChangeModel(3)
self:freshStyle()
isometricMapSystem:setEditorMode(editorMode.eDefault)
local sname=self.roadtype==1 and'button_jzpulu3'or'button_jzpuqiang1'
self.endMark.widget:SetChildCSImageSprite(3,self.hudAB,sname)
local tips=self.roadtype==1 and'请拖动镜头确定道路起点'or'请拖动镜头确定围墙起点'
self:SetTips(tips)
if lastMode==4 then
isometricMapSystem:reDrawPath()
end
end


function UILayoutWin:onChangeCreateRoadMode()
local lastMode=self.model
self.opRoadType=2
self:Cancel()
self:ChangeModel(3)
self:freshStyle()
isometricMapSystem:setEditorMode(editorMode.eCreateRoad)
local sname=self.roadtype==1 and'button_jzpulu3'or'button_jzpuqiang1'
self.endMark.widget:SetChildCSImageSprite(3,self.hudAB,sname)
local tips=self.roadtype==1 and'请确定道路起点'or'请确定围墙起点'
self:SetTips(tips)
if lastMode==4 then
isometricMapSystem:reDrawPath()
end
end

function UILayoutWin:onDeleteRoadBtn()
local lastMode=self.model
self.opRoadType=2
self:Cancel(true)
self:ChangeModel(4)
self:freshStyle()
isometricMapSystem:setEditorMode(editorMode.eDeleteRoad)
local sname=self.roadtype==1 and'button_jzchailu3'or'button_jzchailu3'
self.endMark.widget:SetChildCSImageSprite(3,self.hudAB,sname)
local tips=self.roadtype==1 and'请点击或拖动确定拆路起点'or'请点击或拖动确定拆墙起点'
self:SetTips(tips)
self:setCostTips()
if lastMode==3 then
isometricMapSystem:reDrawPath()
end
end

function UILayoutWin:checkModel5(call)
if self.model==5 then
isometricMapSystem:ChangeDesignTips(call)
else
call()
end
end

function UILayoutWin:onCancelDeleteRoadBtn()
self:onChangeRoad(self.roadtype)
end

function UILayoutWin:onApplyClick()
if self.isCanCR then
self:SetCompleteTips()
isometricMapSystem:applyRoad(false)





else
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(self.road_price[1])))
gainControl:showGainWin(self.road_price[1])
end
end

function UILayoutWin:showCreateRoadPay()
if self.crPay and self.crPay>0 and isometricMapSystem:getEditorMode()==editorMode.eCreateRoad and self.roadtype==2 then
local pos=hudControl:getHUDTargetPosition(self.endMark.guid)
local mapId=zongmenModel:getMountainId()
hudControl:showRewardTipsToPos(mapId,pos,self.road_price[1],-self.crPay,{-1,0})
end
end

function UILayoutWin:onCancelClick()
self:SetCompleteTips()
isometricMapSystem:cancelRoad()
self:ShowMarkPos(false,false)
end

function UILayoutWin:SetCompleteTips()
local mode=isometricMapSystem:getEditorMode()
if mode==editorMode.eCreateRoad then
local tips=self.roadtype==1 and'继续铺路或完成铺路'or'继续建墙或完成建墙'
self:SetTips(tips)
else
local tips=self.roadtype==1 and'继续拆路或完成拆路'or'继续拆墙或完成拆墙'
self:SetTips(tips)
end
end

function UILayoutWin:onGroundBtn()
local ground=isometricMapSystem:isInGroundModel()
if not ground then
isometricMapSystem:enterGroundModel()
else
isometricMapSystem:leaveGroundModel()
end
self:RefreshGroundBtn()
end

function UILayoutWin:onNameBtn()
local ground=isometricMapSystem:isInNameModel()
if not ground then
isometricMapSystem:enterNameModel()
else
isometricMapSystem:leaveNameModel()
end
self:freshNameBtn()
end

function UILayoutWin:onSkyObjBtn()
local bShow=isometricMapSystem:isShowSkyObject()
isometricMapSystem:setSkyObjectShow(not bShow,true)
self:freshSkyBtn()
end

function UILayoutWin:onSurfaceObjBtn()
local bShow=isometricMapSystem:isShowSurfaceObject()
isometricMapSystem:setSurfaceObjectShow(not bShow,true)
self:freshSurfaceBtn()
end






function UILayoutWin:onReturnBtn()
self:onCloseBtn()
end

function UILayoutWin:onTipspanel()
self.tipspanel:setActive(false)
end

function UILayoutWin:refreshAfterItemUse(utype,arg1,arg2)
self:refreshCurrPage()
end

function UILayoutWin:refreshCurrPage()
self.bRefresh=true
self:SelectPage(self.page)
end

function UILayoutWin:SelectPage(page)
self.buildScrollview:setActive(true)
self.storageScrollview:setActive(false)
self.scRoot:setActive(false)
self:InitBuilding(page)
end

function UILayoutWin:onStorageBtn()
self.bRefresh=true
self.buildScrollview:setActive(false)
self.storageScrollview:setActive(true)
self.countRoot:setActive(false)
local showScRoot=zongmenModel:getMountainId()~=mapIdType.xianmeng
self.scRoot:setActive(showScRoot)
self:InitStorage()
end

function UILayoutWin:onAddStorage()
UIManager:showWindow('UIStorageUnlockWin')
end

function UILayoutWin:onClickMask()
self:onCloseBtn()
end

function UILayoutWin:onLimitTips()


local d={}
d.title='商铺规则'
d.mode=3
d.name='layoutwin_aixin_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UILayoutWin:onCloseBtn()
local call=function(openMain)
UILayoutControl:closeUI(true,openMain or openMain==nil)
end
self:checkModel5(call)
end

function UILayoutWin:onBuildSuitBtn()
UILayoutControl:showWindow("UIBuildingSuitWin")
end

function UILayoutWin.on_system_open(sysid)
if sysid==SYSTEM_DEFINE.eBuildSuit then
_this:refreshBuildSuitButton()
end
end

function UILayoutWin:refreshBuildSuitButton()
local md=self.btnDatas[self.selectId+1]
local show=md.page==1 and zongmenBuildingSuitModel:checkEnter()
self.buildSuitBtn:setActive(show)
if show then
self:refreshBuildSuitReddot()
end
end

function UILayoutWin:refreshBuildSuitReddot()
local reddot=zongmenBuildingSuitModel:checkReddot()
self.buildSuitReddot:setActive(reddot)

local grids=self.sortBtnScrollview:getChildScrollViewItemWidgets()
local reddot2=self:getPageReddot(BUILD_TAB_TYPE.eJingGuan)
if self.page==BUILD_TAB_TYPE.eJingGuan then
reddot2=zongmenBuildingSuitModel:checkReddot()
end
for index,data in ipairs(self.btnDatas)do
if data.page==BUILD_TAB_TYPE.eJingGuan then
local item=grids[index-1]
item:SetChildActive(2,reddot2)
break
end
end
end









function UILayoutWin:onDeleteBtn()
self.isDelete=not self.isDelete
self.deleteSelect:setActive(self.isDelete)
self.deleteNomal:setActive(not self.isDelete)
if self.isDelete then
self:onDeleteRoadBtn()
else
self:onCancelDeleteRoadBtn()
end
isometricMapSystem:hideBuffArea()
isometricMapSystem:cancelRoad()
self:ShowMarkPos(false,false)
end

function UILayoutWin:onStyleArrowBtn()
isometricMapSystem:cancelRoad()
self:onCreateRoadBtn()
isometricMapSystem:hideBuffArea()
self:ShowMarkPos(false,false)
end

function UILayoutWin:onMoveStart()

end

function UILayoutWin:onMove(screenPoint)
local speed=Time.deltaTime*5
screenPoint={x=screenPoint.x*speed,y=screenPoint.y*speed}
_MapManager.SetCameraTranslate(screenPoint,0)
end

function UILayoutWin:onMoveEnd()

end

function UILayoutWin:showBtnScrollView(show)
self.btnScrollview:setActive(show)
self.btnScrollviewBg:setActive(show)

self.closeBtn:setActive(show)
end



function UILayoutWin.onArrowDown(id,pos)
isometricMapSystem.on_touch_start(0,1,_this.endMark.widget:GetChildUIScreenPos(0,true))
end

function UILayoutWin.onArrowDrag(id,pos,deltaTime)
isometricMapSystem.on_touch_down(0,1,pos)
isometricMapSystem.on_swipe(0,1,pos,nil,nil,nil,deltaTime)
end

function UILayoutWin.onArrowUp(id,pos)
isometricMapSystem.on_touch_up(0,1,pos,-1)
end
