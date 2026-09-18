







def_class("UISkyLayoutWin",UIWindowBase)









function UISkyLayoutWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.rightPanel=UIObject.get(self,1)
self.selectpanel=UIObject.get(self,2)
self.btnChange_normal=UIButton.get(self,3)
self.btnChange_concise=UIButton.get(self,4)
self.btnScrollview=UIObject.get(self,5)
self.tabRect=UIObject.get(self,6)
self.buildScrollview=UIObject.get(self,7)
self.storageScrollview=UIObject.get(self,8)
self.sortBtnScrollview=UIObject.get(self,9)
self.buildTips=UIText.get(self,10)
self.storageTips=UIText.get(self,11)
self.countRoot=UIObject.get(self,12)
self.buildCount=UIText.get(self,13)
self.limitTips=UIButton.get(self,14)
self.btnScrollviewBg=UIObject.get(self,15)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.btnChange_normal:setButtonClick(function()self:onBtnChange_normal()end)

self.btnChange_concise:setButtonClick(function()self:onBtnChange_concise()end)

self.limitTips:setButtonClick(function()self:onLimitTips()end)
self.btnChange={
["normal"]=self.btnChange_normal,
["concise"]=self.btnChange_concise,
}



end


function UISkyLayoutWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.selectpanel);self.selectpanel=nil;
_UIObject_release(self.btnChange_normal);self.btnChange_normal=nil;
_UIObject_release(self.btnChange_concise);self.btnChange_concise=nil;
_UIObject_release(self.btnScrollview);self.btnScrollview=nil;
_UIObject_release(self.tabRect);self.tabRect=nil;
_UIObject_release(self.buildScrollview);self.buildScrollview=nil;
_UIObject_release(self.storageScrollview);self.storageScrollview=nil;
_UIObject_release(self.sortBtnScrollview);self.sortBtnScrollview=nil;
_UIObject_release(self.buildTips);self.buildTips=nil;
_UIObject_release(self.storageTips);self.storageTips=nil;
_UIObject_release(self.countRoot);self.countRoot=nil;
_UIObject_release(self.buildCount);self.buildCount=nil;
_UIObject_release(self.limitTips);self.limitTips=nil;
_UIObject_release(self.btnScrollviewBg);self.btnScrollviewBg=nil;
self.btnChange=nil;
end
















local _this

local newImgAB='ui/windows/layout/newlayout_atlas_pak.ab'

local _btnType={
Build=1,
Layout=2,
}

local _defaultBtnList={_btnType.Build,_btnType.Layout}




function UISkyLayoutWin:onLoaded(...)
self:bindComponents()

_this=self

self.playTweenList={}

self:freshSimpleBtn(false)

self.hudAB='ui/windows/hud/hud_sprite_atlas_pak.ab'

self.layout_menu={{"装饰",1,{1,6,1}},{"储存",1,{2}}}

self.fbSelectId=0

self.placeCfgId=-2

self.closeBtn:setActive(false)

local mapId=zongmenModel:getMountainId()
self.maxBuildNum=cfgHelper.get2(cfg_monijysfconfig_get,mapId,'max_sky_bd_num')
self:setBuildingCount()

self.func_btns={
[_btnType.Build]={'button_jzjianzao_1','button_jzjianzao_2'},
[_btnType.Layout]={'button_jzbuju_1','button_jzbuju_2'},
}

self.first_build_check={}

local btnFUncs={
[_btnType.Build]=function()
self:onBuildBtn()
end,
[_btnType.Layout]=function()
self:onLayoutBtn()
end,
}

self.btnFUncs=btnFUncs

self.btnScrollview:setChildScrollViewInit(0.5,true,self.on_btns_click,nil)
self.buildScrollview:setChildScrollViewInit(1,true,nil,nil)
self.storageScrollview:setChildScrollViewInit(1,true,self.on_storage_item_click,nil)
self.sortBtnScrollview:setChildScrollViewInit(0,true,self.on_sort_btn_click,nil)
end

function UISkyLayoutWin:setBuildingCount()
local mapId=zongmenModel:getMountainId()
local count=zongmenModel:getCurrentSkyBuildingCount(mapId)
self.buildCount:setText(FMT.fmt('建造上限：{0}/{1}',count,self.maxBuildNum))
end

function UISkyLayoutWin:refreshApplyBtn()
if self.hudWidget then
local preview=isometricMapSystem:getPreviewBuilding()
if preview then
local pCfgId=-2
local canPlace=_MapManager.IsCanPlace(self.buildingGuid,pCfgId)
if canPlace~=self.rcPlaceState then
self.rcPlaceState=canPlace
self.hudWidget:SetChildCSImageSprite(2,self.hudAB,canPlace and'button_jzqueding'or'button_jzqueding_1')
end
end
end
end

function UISkyLayoutWin:initFuncBtn()

self.funcBtns=_defaultBtnList
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
end
end

function UISkyLayoutWin:clickLayoutBtn()
self.on_btns_click(0,1)
end

function UISkyLayoutWin.on_btns_click(clicknum,index)
local lastSelect=_this.fbSelectId
_this.fbSelectId=index
if lastSelect then
_this:freshBtnSelect(lastSelect)
end

_this:freshBtnSelect(index)



local btnType=_this.funcBtns[index+1]
_this.btnFUncs[btnType]()


end

function UISkyLayoutWin.on_item_click(clicknum,index)
_this:OnSelectItem(index)
end

function UISkyLayoutWin:freshBtnSelect(index)
local item=_this.btnScrollview:getChildScrollViewItemWidget(index)
item:SetChildActive(0,self.fbSelectId~=index)
item:SetChildActive(1,self.fbSelectId==index)
end

function UISkyLayoutWin.on_sort_btn_click(clicknum,index)
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

end


function UISkyLayoutWin:__delete()
self:onBtnChange_concise()

if self.hType>0 then
self:Cancel()
self.rootWin:hideBuildingInfo()
end

self:unbindComponents()

_this=nil
end




function UISkyLayoutWin:onShow(argtable,afterOnloaded)
self.rootWin=argtable.rootWin

self.sfId=zongmenModel:getMountainId()
self.datas=self:GetBuildingConfigs()
self:initTabBtns()
self:initFuncBtn()
self.rightPanel:setActive(false)
self.on_btns_click(0,0)
self.on_sort_btn_click(0,0)

if argtable.fastBuildId then
self:handleFastBuild(argtable.fastBuildId)
end
end


function UISkyLayoutWin:onHide()

end

function UISkyLayoutWin:GetBuildingConfigs()
local cfgs=cfg_monijybuildconfig()
local level=zongmenModel:getLevel()
local list={}
for k,v in pairs(cfgs)do
if level>=v.show_level and v.buildTab>0 and self:checkShowInList(v)and(not v.mountain or v.mountain[self.sfId])then
local buildTab=v.buildTab
local tb=list[buildTab]or{}
table.insert(tb,{cfg=v,id=v.id,sortVal=1,type=0,sw=v.sort_weights or 0})
list[buildTab]=tb
end
end
return list
end

function UISkyLayoutWin:checkShowInList(cfg)
if cfg.cnd_show then
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,cfg.id,1)
if zongmenControl:checkLevelUp(levelCfg)then
return true
end
return false
end
return true
end

function UISkyLayoutWin:initTabBtns()
local datas=self.datas


self.btnDatas={}
local level=zongmenModel:getLevel()
local cfg=cfgHelper.get1(cfg_monijysfconfig_get,self.sfId)
local index=1
for i,v in ipairs(self.layout_menu)do
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


md.func=function()
self:SelectPage(page)
self.inStorage=false
end
table.insert(self.btnDatas,md)
index=index+1
end
elseif ft==2 then
md.func=function()
self:onStorageBtn()
self.inStorage=true
end
table.insert(self.btnDatas,md)
index=index+1
end
end
end
self.sortBtnScrollview:setChildScrollViewCreateGrids(#self.btnDatas,0)
local grids=self.sortBtnScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local data=self.btnDatas[i+1]
item:SetChildText(1,data.name)
item:SetChildActive(2,false)
item:SetChildActive(3,false)
item:SetChildText(4,'')
end
end

function UISkyLayoutWin:SelectPage(page)
self.buildScrollview:setActive(true)
self.storageScrollview:setActive(false)

self.countRoot:setActive(true)
self:InitBuilding(page)
end

function UISkyLayoutWin:InitBuilding(page)
if self.page==page and not self.bRefresh then
return
end
if self.bRefresh then
self.bRefresh=false
end
self.page=page
local datas=self.datas[self.page]or{}
local len=#datas
self.buildTips:setActive(len<=0)
self.buildScrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.buildScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local data=datas[i+1]
local cfg=data.cfg

local item=grids[i]
self:setNormalBuildingItem(item,cfg,i)
end
end

function UISkyLayoutWin:setNormalBuildingItem(item,cfg,index)
local bdId=cfg.id
local lcfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdId,1)
item:SetChildText(0,cfg.name)
item:SetChildButtonClick(9,function()self.on_item_click(1,index)end,true)
item:SetChildIcon(1,cfg.icon,true)
item:SetChildAnchoredPos(1,0,85)

local canBuildCount=zongmenControl:getCanbuildCount(lcfg)
item:SetChildText(14,FMT.fmt('拥有:{0}',canBuildCount))
item:SetChildActive(15,true)

local v1=self:SetCostText(3,item,lcfg.uplevel_cost[1])
local v2=self:SetCostText(4,item,lcfg.uplevel_cost[2])
self:SetCostText(19,item,lcfg.uplevel_cost[1])
item:SetChildActive(3,false)
item:SetChildActive(4,false)

local showTips=v1==false or v2==false
item:SetChildActive(8,showTips)
end

function UISkyLayoutWin:SetCostText(index,item,cost)
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

function UISkyLayoutWin:handleFastBuild(bdId)
self.fastBuildId=bdId
local p,i=self:findIndex(bdId)
self.placeIndex=i-1
self.page=p
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
self:checkAndSelectBuilding(cfg)
end

function UISkyLayoutWin:findIndex(bdId)
for k,v in pairs(self.datas)do
for i,vv in ipairs(v)do
if vv.cfg.id==bdId then
return k,i
end
end
end
return 1,1
end

function UISkyLayoutWin:OnSelectItem(index)

local cfg=self.datas[self.page][index+1].cfg
self:checkAndSelectBuilding(cfg)
end

function UISkyLayoutWin:checkCost(id,level)
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,level)
return zongmenControl:checkLevelUp(levelCfg,true,nil,true)
end

function UISkyLayoutWin:checkAndSelectBuilding(cfg,level)
if isometricMapSystem:hasPreviewBuilding()then
return false
end

local needSys=cfg.build_system
if needSys and not systemModel.isOpen(needSys)then
UIManager.error(cfg.build_tips[1][2])
return false
end

local flag,lvupData=self:checkCost(cfg.id,1)
if not flag then




return false
end

local mapId=zongmenModel:getMountainId()
local count=zongmenModel:getCurrentSkyBuildingCount(mapId)
if count>=self.maxBuildNum then
UIManager.error('空中装饰已达上限')
return false
end

self:handleSelectItem(cfg,level)

return true
end

function UISkyLayoutWin:handleSelectItem(cfg,lv)
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

self.rootWin:showBuildingInfo(cfg.id,level)


local building=data
local guid=building.guid
self.buildingGuid=guid
isometricMapSystem:setEditorMode(editorMode.ePlace)
isometricMapSystem:setPlaceObject(guid)

self.hudWidget=hudControl:getHUDWidget(building.hudId)
local clickCancel=function()

self:Cancel()
self.bRefresh=true
self.on_sort_btn_click(1,self.selectId)
self.hudWidget=nil
self.fastBuildId=nil
self.rootWin:hideBuildingInfo()

end
self.hudWidget:SetChildActive(0,not self.force)
local showOrientation=self:isShowOrientation(cfg,building.bdData)
self.hudWidget:SetChildActive(1,showOrientation)
self.hudWidget:SetChildButtonClick(0,clickCancel)
self.hudWidget:SetChildButtonClick(1,function()
_MapManager.Flip(guid)
building.orientation=building.orientation==0 and 1 or 0
self:refreshApplyBtn()
end)
local clickFunc=function()
if self:IsCanPlace(guid,self.placeCfgId)then

AudioManager.playAudio(432)
local pos=isometricMapSystem:getObjectPosValue(guid)
self.lastPlacePos=pos
zongmenControl:reqSkyBuild(self.sfId,cfg.id,pos[1],pos[2],building.orientation)
end
end
self.hudWidget:SetChildButtonClick(2,clickFunc)
self.hudWidget:SetChildActive(3,false)
self.hudWidget:SetChildActive(4,false)


self:refreshApplyBtn()
end

local args={
id=cfg.id,

cfg=cfg,
level=level,
pos=bpos,
useDefPos=useDefPos,
callback=func,
pCfgId=self.placeCfgId,


checkPlaceId=self.placeCfgId,



objType=objectType.eSkyPlaceObject,
lastPosArr=self.lastPlacePos,
}
isometricMapSystem:createBuilding(args)





end

function UISkyLayoutWin:getBDShowPos()
if self.lastBDPos then
return self.lastBDPos
else
local mapId=zongmenModel:getMountainId()
return _MapManager.ScreenPointToCell(mapId,Vector3.New(_Screen.width*0.5,_Screen.height*0.5,0),0,mapLayer.Data)
end
end

function UISkyLayoutWin:IsCanPlace(guid,pcfg)
if _MapManager.IsCanPlace(guid,pcfg or conditionConfig.place)then
return true
end
UIManager.error('该位置无法放置建筑')
return false
end

function UISkyLayoutWin:isShowOrientation(cfg,bdData)
if cfg.is_orientation==0 then
return false
end
return true
end

function UISkyLayoutWin:Cancel(changeModel)
local backToBuild=false
if self.hType==1 or self.hType==2 then
isometricMapSystem:cancelBuild()
self:ChangeModel(1)
self.lastBDPos=nil
elseif self.hType==3 then
isometricMapSystem:cancelPickUp(true)
self.hudWidget=nil
end



if self.hType==2 or self.hType==3 then
backToBuild=true
end
self.hType=0


if backToBuild then
self.on_btns_click(0,0)
end
end

function UISkyLayoutWin:onBuildBtn()





if not(self.hType==1 or self.hType==2)then
self:ChangeModel(1)
end

self.rootWin:SetTips()
self:Cancel(true)
end

function UISkyLayoutWin:onLayoutBtn()

if self.hType==1 or self.hType==2 then
isometricMapSystem:cancelBuild()
self.hudWidget=nil
self.rootWin:hideBuildingInfo()
end






self:ChangeModel(2)


self.rootWin:SetTips('点击建筑调整布局')
end

function UISkyLayoutWin:ChangeModel(model)
self.model=model
local showMsg=true
if model==1 then
isometricMapSystem:setLayoutMode(layoutMode.eSkyBuild)
showMsg=false
else
isometricMapSystem:setLayoutMode(layoutMode.eSkyLayout)
end
if model==1 then
self.selectpanel:setActive(true)
if self.inStorage then
self:onStorageBtn()
end
elseif model==2 then
self.selectpanel:setActive(false)
end





end

function UISkyLayoutWin:onStorageBtn()
self.bRefresh=true
self.buildScrollview:setActive(false)
self.storageScrollview:setActive(true)
self.countRoot:setActive(false)

self:InitStorage()
end

function UISkyLayoutWin:InitStorage()
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


self.storageTips:setActive(count<=0)

if self.placeIndex then
self.storageScrollview:setChildScrollViewSelectItem(self.placeIndex,true,false,false)
end
end

function UISkyLayoutWin:GetStorageDatas()
local mapId=zongmenModel:getMountainId()
local datas=zongmenModel:getSkyStorageDatas(mapId)
local list={}
local count=0
for k,v in pairs(datas)do
local btype=v.build_id
local bdlist=list[btype]
if not bdlist then
bdlist={}
list[btype]=bdlist
end
table.insert(bdlist,v)
end
local rlist={}
for k,v in pairs(list)do
table.insert(rlist,v)
end
count=#rlist
return rlist,count
end

function UISkyLayoutWin.on_storage_item_click(clicknum,index)
if not _this or _this.isClose then return end
_this:OnStorageItemSelect(index)
end

function UISkyLayoutWin:OnStorageItemSelect(index)
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

self.rootWin:showBuildingInfo(cfg.id,level)


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
self.rootWin:hideBuildingInfo()
end)
self.hudWidget:SetChildButtonClick(1,function()

_MapManager.Flip(guid)
building.orientation=building.orientation==0 and 1 or 0
self:refreshApplyBtn()
end)
self.hudWidget:SetChildButtonClick(2,function()
if self:IsCanPlace(guid,self.placeCfgId)then



AudioManager.playAudio(432)
local pos=isometricMapSystem:getObjectPosValue(guid)
self.lastPlacePos=pos

zongmenControl:reqSkyBuildSB(self.sfId,data.un_build_id,pos[1],pos[2],building.orientation)
end
end)
local showOrientation=self:isShowOrientation(cfg,building.bdData)
self.hudWidget:SetChildActive(1,showOrientation)
self.hudWidget:SetChildActive(3,false)
self.hudWidget:SetChildActive(4,false)


self:refreshApplyBtn()
end

local args={
id=cfg.id,

cfg=cfg,
level=level,
pos=bpos,
useDefPos=useDefPos,
callback=func,
pCfgId=self.placeCfgId,


checkPlaceId=self.placeCfgId,



objType=objectType.eSkyPlaceObject,
lastPosArr=self.lastPlacePos,
}
isometricMapSystem:createBuilding(args)




end

function UISkyLayoutWin:PickUpBuilding(guid,bdData)
if isometricMapSystem:hasPreviewBuilding()then
return
end

self.hType=3

isometricMapSystem:onPickUpBuilding(guid,bdData,function(data)
if not isometricMapSystem:hasPreviewBuilding()then
return
end

self.buildingGuid=guid


self.rootWin:showBuildingInfo(bdData.build_id,bdData.level)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local building=data
self.hudWidget=hudControl:getHUDWidget(building.hudId)
local showOrientation=self:isShowOrientation(cfg,bdData)
self.hudWidget:SetChildActive(1,showOrientation)
local cancelFunc=function()
self:Cancel()
self.hudWidget=nil
self.rootWin:hideBuildingInfo()
end
self.hudWidget:SetChildButtonClick(0,cancelFunc)
self.hudWidget:SetChildButtonClick(1,function()
_MapManager.Flip(guid)
building.orientation=building.orientation==0 and 1 or 0
self:refreshApplyBtn()
end)
self.hudWidget:SetChildButtonClick(2,function()
if self:IsCanPlace(guid,self.placeCfgId)then

AudioManager.playAudio(432)
local pv=isometricMapSystem:getObjectPosValue(guid)
if pv[1]~=bdData.x or pv[2]~=bdData.y or bdData.orientation~=building.orientation then
zongmenControl:reqSkyBDMove(self.sfId,bdData.un_build_id,pv[1],pv[2],building.orientation)
else
cancelFunc()
end
end
end)
local showStorage=cfg.is_collect==1
self.hudWidget:SetChildActive(3,showStorage)
if showStorage then
self.hudWidget:SetChildButtonClick(3,function()
zongmenControl:reqSkyBDStorage(self.sfId,bdData.un_build_id)
end)
end
self.hudWidget:SetChildActive(4,false)
end,true)
end

function UISkyLayoutWin:HandleApplyBuild(sfId,bdId)
self.rootWin:hideBuildingInfo()

local bdData=zongmenModel:getSkyBuildingData(bdId)


local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,1)
for i,v in ipairs(levelCfg.uplevel_cost)do
hudControl:showRewardTips(bdData.entityId,v[1],-v[2],{-1,0})
end

self.hudWidget=nil
self.hType=0

self.bRefresh=true
self:setBuildingCount()
self.on_btns_click(0,0)
self.on_sort_btn_click(0,0)
end

function UISkyLayoutWin:HandleApplyPlace()
self.rootWin:hideBuildingInfo()

self.hudWidget=nil
self.hType=0


if self.storageList then
if#self.storageList>0 then

self:OnStorageItemSelect(self.storageIndex)
return

else
self.storageList=nil
end
end

self.initStorage=false



self.bRefresh=true
self:setBuildingCount()
self.on_btns_click(0,0)
end

function UISkyLayoutWin:HandleApplyMove()
self.rootWin:hideBuildingInfo()
self.hudWidget=nil
self.hType=0

self.on_btns_click(0,0)
end

function UISkyLayoutWin:HandleStorage()
self.rootWin:hideBuildingInfo()
self.hudWidget=nil
self.hType=0

self.bRefresh=true
self:setBuildingCount()
self.on_btns_click(0,0)
end

function UISkyLayoutWin:clearTweener()
for i,v in ipairs(self.playTweenList)do
v:Kill()
end
self.playTweenList={}
end

function UISkyLayoutWin:onBtnChange_concise()
self:freshSimpleBtn(false)




self:clearTweener()
local tweener=self.selectpanel:setChildDOAnchorPosY(0,0.5,nil)
table.insert(self.playTweenList,tweener)
tweener=self.rootWin.leftPanel:setChildDOAnchorPosX(667,0.5,nil)
table.insert(self.playTweenList,tweener)
tweener=self.rootWin.rightPanel:setChildDOAnchorPosX(-667,0.5,nil)
table.insert(self.playTweenList,tweener)
end

function UISkyLayoutWin:onBtnChange_normal()
self:freshSimpleBtn(true)




self:clearTweener()
local tweener=self.selectpanel:setChildDOAnchorPosY(-256,0.5,nil)
table.insert(self.playTweenList,tweener)
tweener=self.rootWin.leftPanel:setChildDOAnchorPosX(450,0.5,nil)
table.insert(self.playTweenList,tweener)
tweener=self.rootWin.rightPanel:setChildDOAnchorPosX(-530,0.5,nil)
table.insert(self.playTweenList,tweener)
end

function UISkyLayoutWin:freshSimpleBtn(isConcise)
self.btnChange["concise"]:setActive(isConcise)
self.btnChange["normal"]:setActive(not isConcise)
end



function UISkyLayoutWin:onBuildSuitBtn()

end

function UISkyLayoutWin:onLimitTips()

end

function UISkyLayoutWin:onAddStorage()

end

function UISkyLayoutWin:onCloseBtn()
self.rootWin.hType=1
self.rootWin.on_btns_click(0,0)
end
