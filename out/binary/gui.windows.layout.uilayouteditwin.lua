







def_class("UILayoutEditWin",UIWindowBase)









function UILayoutEditWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.clickMask=UIButton.get(self,2)
self.chongzhiBtn=UIButton.get(self,3)
self.shouqiBtn=UIButton.get(self,4)
self.selectpanel=UIObject.get(self,5)
self.testRoot=UIObject.get(self,6)
self.btnScrollviewBg=UIObject.get(self,7)
self.btnScrollview=UIObject.get(self,8)
self.tipspanel=UIButton.get(self,9)
self.editRoadRoot=UIObject.get(self,10)
self.tipsbg=UIObject.get(self,11)
self.helpButton=UIButton.get(self,12)
self.sortBtnScrollview=UIObject.get(self,13)
self.tempScrollview=UIObject.get(self,14)
self.applyButton=UIButton.get(self,15)
self.tabRect=UIObject.get(self,16)
self.storageScrollview=UIObject.get(self,17)
self.tipsRoot=UIObject.get(self,18)
self.exportTestBtn=UIButton.get(self,19)
self.loadTestBtn=UIButton.get(self,20)
self.inputTextField=UIInputField.get(self,21)
self.startTestBtn=UIButton.get(self,22)
self.tips=UIText.get(self,23)
self.tipsCostRoot=UIObject.get(self,24)
self.sceneryFilter=UIObject.get(self,25)
self.countRoot=UIObject.get(self,26)
self.buildSuitBtn=UIButton.get(self,27)
self.scRoot=UIObject.get(self,28)
self.storageTips=UIText.get(self,29)
self.unlockButton=UIButton.get(self,30)
self.previewButton=UIButton.get(self,31)
self.tipsCost=UIText.get(self,32)
self.tipsCostIcon=UIObject.get(self,33)
self.tipsDesc=UIText.get(self,34)
self.tipsBuildName=UIText.get(self,35)
self.roadRoot=UIObject.get(self,36)
self.addStorage=UIButton.get(self,37)
self.storageCount=UIText.get(self,38)
self.buildSuitReddot=UIObject.get(self,39)
self.limitTips=UIButton.get(self,40)
self.buildCount=UIText.get(self,41)
self.unlockCost=UILinkImageText.get(self,42)
self.testQuitRoadButton=UIButton.get(self,43)
self.testClearRoadButton=UIButton.get(self,44)
self.testInitRoadButton=UIButton.get(self,45)
self.testDelRoadButton=UIButton.get(self,46)
self.testCreateRoadButton=UIButton.get(self,47)
self.inputRoadIdField=UIInputField.get(self,48)
self.deleteBtn=UIButton.get(self,49)
self.joyStickRoot=UIObject.get(self,50)
self.stylePanel=UIObject.get(self,51)
self.roadJuanZhou=UIObject.get(self,52)
self.styleArrowBtn=UIButton.get(self,53)
self.styleRoot=UIObject.get(self,54)
self.joyStick=UIObject.get(self,55)
self.styleScrollView=UIObject.get(self,56)
self.styleTitle=UIImage.get(self,57)
self.deleteNomal=UIObject.get(self,58)
self.deleteSelect=UIObject.get(self,59)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.chongzhiBtn:setButtonClick(function()self:onChongzhiBtn()end)

self.shouqiBtn:setButtonClick(function()self:onShouqiBtn()end)

self.tipspanel:setButtonClick(function()self:onTipspanel()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.applyButton:setButtonClick(function()self:onApplyButton()end)

self.exportTestBtn:setButtonClick(function()self:onExportTestBtn()end)

self.loadTestBtn:setButtonClick(function()self:onLoadTestBtn()end)

self.startTestBtn:setButtonClick(function()self:onStartTestBtn()end)

self.buildSuitBtn:setButtonClick(function()self:onBuildSuitBtn()end)

self.unlockButton:setButtonClick(function()self:onUnlockButton()end)

self.previewButton:setButtonClick(function()self:onPreviewButton()end)

self.addStorage:setButtonClick(function()self:onAddStorage()end)

self.limitTips:setButtonClick(function()self:onLimitTips()end)

self.testQuitRoadButton:setButtonClick(function()self:onTestQuitRoadButton()end)

self.testClearRoadButton:setButtonClick(function()self:onTestClearRoadButton()end)

self.testInitRoadButton:setButtonClick(function()self:onTestInitRoadButton()end)

self.testDelRoadButton:setButtonClick(function()self:onTestDelRoadButton()end)

self.testCreateRoadButton:setButtonClick(function()self:onTestCreateRoadButton()end)

self.deleteBtn:setButtonClick(function()self:onDeleteBtn()end)

self.styleArrowBtn:setButtonClick(function()self:onStyleArrowBtn()end)



end


function UILayoutEditWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.chongzhiBtn);self.chongzhiBtn=nil;
_UIObject_release(self.shouqiBtn);self.shouqiBtn=nil;
_UIObject_release(self.selectpanel);self.selectpanel=nil;
_UIObject_release(self.testRoot);self.testRoot=nil;
_UIObject_release(self.btnScrollviewBg);self.btnScrollviewBg=nil;
_UIObject_release(self.btnScrollview);self.btnScrollview=nil;
_UIObject_release(self.tipspanel);self.tipspanel=nil;
_UIObject_release(self.editRoadRoot);self.editRoadRoot=nil;
_UIObject_release(self.tipsbg);self.tipsbg=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.sortBtnScrollview);self.sortBtnScrollview=nil;
_UIObject_release(self.tempScrollview);self.tempScrollview=nil;
_UIObject_release(self.applyButton);self.applyButton=nil;
_UIObject_release(self.tabRect);self.tabRect=nil;
_UIObject_release(self.storageScrollview);self.storageScrollview=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.exportTestBtn);self.exportTestBtn=nil;
_UIObject_release(self.loadTestBtn);self.loadTestBtn=nil;
_UIObject_release(self.inputTextField);self.inputTextField=nil;
_UIObject_release(self.startTestBtn);self.startTestBtn=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsCostRoot);self.tipsCostRoot=nil;
_UIObject_release(self.sceneryFilter);self.sceneryFilter=nil;
_UIObject_release(self.countRoot);self.countRoot=nil;
_UIObject_release(self.buildSuitBtn);self.buildSuitBtn=nil;
_UIObject_release(self.scRoot);self.scRoot=nil;
_UIObject_release(self.storageTips);self.storageTips=nil;
_UIObject_release(self.unlockButton);self.unlockButton=nil;
_UIObject_release(self.previewButton);self.previewButton=nil;
_UIObject_release(self.tipsCost);self.tipsCost=nil;
_UIObject_release(self.tipsCostIcon);self.tipsCostIcon=nil;
_UIObject_release(self.tipsDesc);self.tipsDesc=nil;
_UIObject_release(self.tipsBuildName);self.tipsBuildName=nil;
_UIObject_release(self.roadRoot);self.roadRoot=nil;
_UIObject_release(self.addStorage);self.addStorage=nil;
_UIObject_release(self.storageCount);self.storageCount=nil;
_UIObject_release(self.buildSuitReddot);self.buildSuitReddot=nil;
_UIObject_release(self.limitTips);self.limitTips=nil;
_UIObject_release(self.buildCount);self.buildCount=nil;
_UIObject_release(self.unlockCost);self.unlockCost=nil;
_UIObject_release(self.testQuitRoadButton);self.testQuitRoadButton=nil;
_UIObject_release(self.testClearRoadButton);self.testClearRoadButton=nil;
_UIObject_release(self.testInitRoadButton);self.testInitRoadButton=nil;
_UIObject_release(self.testDelRoadButton);self.testDelRoadButton=nil;
_UIObject_release(self.testCreateRoadButton);self.testCreateRoadButton=nil;
_UIObject_release(self.inputRoadIdField);self.inputRoadIdField=nil;
_UIObject_release(self.deleteBtn);self.deleteBtn=nil;
_UIObject_release(self.joyStickRoot);self.joyStickRoot=nil;
_UIObject_release(self.stylePanel);self.stylePanel=nil;
_UIObject_release(self.roadJuanZhou);self.roadJuanZhou=nil;
_UIObject_release(self.styleArrowBtn);self.styleArrowBtn=nil;
_UIObject_release(self.styleRoot);self.styleRoot=nil;
_UIObject_release(self.joyStick);self.joyStick=nil;
_UIObject_release(self.styleScrollView);self.styleScrollView=nil;
_UIObject_release(self.styleTitle);self.styleTitle=nil;
_UIObject_release(self.deleteNomal);self.deleteNomal=nil;
_UIObject_release(self.deleteSelect);self.deleteSelect=nil;
end




















require("lua.gui.windows.layout.designLayoutExport")


local _titleSprite={'button_daoluqh_1','button_puqiangqh_1'}

local newImgAB='ui/windows/layout/newlayout_atlas_pak.ab'

local _titleBundle=globalABLookup.layoutsprite

local btnFUncs={
[1]=function(this)
if this.model~=1 then
this:onCancelClick()
end
this.model=1
this:onBuildBtn()
end,
[2]=function(this)
this:Cancel()
this:onChangeRoad(1,1)
end,
[3]=function(this)
this:Cancel()
this:onChangeRoad(2,1)
end,
}


local func_btns={
[1]={'建筑'},
[2]={'道路'},
[3]={'围墙'},

}
local _this


function UILayoutEditWin:onLoaded(...)
self:bindComponents()
_this=self
self.model=1
self.defaultRoadId={1,3}
if deviceHelper.isRunEditor()then
self.exportLua=designLayoutExport(self)
self.exportLua:setWindow(self)
self.testRoot:setActive(true)


else
self.testRoot:setActive(false)
end

isometricMapSystem:createRoadMark(INSTANCE_TYPE.eBeginMark,function(data)
hudControl:changeContainer(data.guid,1)
self.beginMark=data
self.beginMark.widget:SetChildActive(0,false)
end)
isometricMapSystem:createRoadMark(INSTANCE_TYPE.eEndMark,function(data)
hudControl:changeContainer(data.guid,1)
self.endMark=data
self.endMark.widget:SetChildActive(0,false)
local widget=self.endMark.widget

widget:SetChildButtonClick(1,function()
if self.enterTestRoadMode then
self:onTestCancelClick()
else
self:onCancelClick()
end
end)
widget:SetChildButtonClick(2,function()
if self.enterTestRoadMode then
self:onTestApplyClick()
else
self:onApplyClick()
end
end)
end)

self.hudAB='ui/windows/hud/hud_sprite_atlas_pak.ab'
local on_storage_item_click=function(clicknum,index)
if self.isInEditMode then
self.exportLua:OnStorageItemSelect(self,index)
else
self:OnStorageItemSelect(index)
end
end
local on_sort_btn_click=function(clicknum,index)
self:on_sort_btn_click(index)
end
self.storageScrollview:setChildScrollViewInit(1,true,on_storage_item_click,nil)
self.sortBtnScrollview:setChildScrollViewInit(0,true,on_sort_btn_click,nil)
self.btnScrollview:setChildScrollViewInit(0.5,true,self.on_btns_click,nil)
self:addNotify(notifyConfig.swipe,function(...)self:on_swipe(...)end)
self.inputTextField:setChildInputFieldChange(true,function(...)self:onSearchChange(...)end)


self.winlua:SetChildScrollViewPlayAniAction(self.styleScrollView:getID(),function(...)
if self and not self.isClose then
self:onPlayStyleAniFinish(...)
end
end)


end

function UILayoutEditWin:initFuncBtn()
self.funcBtns={1,2,3}
self.btnScrollview:setChildScrollViewCreateGrids(#self.funcBtns,0)

local grids=self.btnScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]

item:SetChildActive(1,i==0)
item:SetChildText(2,func_btns[i+1][1])
end
end

function UILayoutEditWin.on_btns_click(clicknum,index)
local lastSelect=_this.fbSelectId
_this.fbSelectId=index
if lastSelect then
_this:freshBtnSelect(lastSelect)
end

_this:freshBtnSelect(index)
_this:showCloseBtn(true)
UIManager:invokeUIMethod("UILayoutWin","hideBuildingInfo")

local btnType=_this.funcBtns[index+1]
btnFUncs[btnType](_this)


end

function UILayoutEditWin:freshBtnSelect(index)
local item=self.btnScrollview:getChildScrollViewItemWidget(index)
item:SetChildActive(0,self.fbSelectId~=index)
item:SetChildActive(1,self.fbSelectId==index)
end

function UILayoutEditWin:freshBtnReddot(index,active)
local item=self.btnScrollview:getChildScrollViewItemWidget(index)
if item then
item:SetChildActive(3,active)
end
end


function UILayoutEditWin:__delete()
if self.model~=1 then
self:onCancelClick()
end
self:Cancel()
self:unbindComponents()


self.exportLua=nil

end




function UILayoutEditWin:onShow(argtable,afterOnloaded)
self.hType=0
self.rootWin=argtable.rootWin

self.first_build_check={}
isometricMapSystem:startDesign()
self.sfId=zongmenModel:getMountainId()
self:initFuncBtn()
self:initTabBtns()
self.on_btns_click(1,0)
self:showRootWin(false)
self:showBtnWin(false)
end


function UILayoutEditWin:onHide()
self.selectTemplateIdx=nil
self:Cancel()

end


function UILayoutEditWin:showRootWin(show)
self.selectpanel:setChildAnchoredPos(0,show and 0 or 10000)
self.chongzhiBtn:setActive(show)
self.shouqiBtn:setActive(show)
end

function UILayoutEditWin:showCloseBtn(show)

end

function UILayoutEditWin:showBtnWin(show)
self.btnScrollviewBg:setChildAnchoredPos(-82,show and-276 or 10000)
self.btnScrollview:setChildAnchoredPos(-82,show and 35.8 or 10000)
self.chongzhiBtn:setActive(show)
self.shouqiBtn:setActive(show)
end

function UILayoutEditWin:showRoadRootWin(show)
self.editRoadRoot:setActive(show)
end

function UILayoutEditWin:initTabBtns()
self.selectId=0

self.buildTabToIndex={}
self.indexToBuildTab={}
self.btnDatas={}
if self.filterIndexs==nil then self.filterIndexs={}end
local level=zongmenModel:getLevel()
local cfg=cfgHelper.get1(cfg_monijysfconfig_get,self.sfId)
local index=1
for i,v in ipairs(cfg.design_menu)do
local showlv=v[2]
if level>=showlv then
local md={}
md.name=v[1]
md.func=function()
self.selectTemplateIdx=nil

self:onStorageBtn(v[3])
self.inStorage=true
self.inTemplate=nil
end
md.page=v[3]
table.insert(self.btnDatas,md)
index=index+1
end
end

if systemModel.isOpen(SYSTEM_DEFINE.eTemplate)then
table.insert(self.btnDatas,{name="模板",page=10000,func=function()
self.inTemplate=true
self.scRoot:setScale(Vector3.zero)
self:onTemplateClick()
end,})
end








self:initFilterData()

local maxNum=zongmenModel:getStorageMaxNum()

self.sortBtnScrollview:setChildScrollViewCreateGrids(#self.btnDatas,0)
local grids=self.sortBtnScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
local haveNum=false
for i=0,count-1 do
local item=grids[i]
local data=self.btnDatas[i+1]
local page=data.page

local num=0
if self.filterDatas[page]then
for i,v in ipairs(self.filterDatas[page])do
num=num+1
end
end

item:SetChildText(1,data.name)


item:SetChildActive(0,self.selectId==i)
if self.selectId==i then
self:refreshStorageView(page)
end
if page==1 then
self:setStorageNum(num,maxNum)
item:SetChildText(4,num-maxNum)
item:SetChildActive(3,num-maxNum>0)
else
item:SetChildActive(3,num>0)
item:SetChildText(4,num)
if num>0 then
haveNum=true
end
end
item:SetChildActive(5,page>=10000)
item:SetChildActive(6,page>=10000)

if page==10000 then
local reddot=ims_design_layout:isLayoutReddot()
item:SetChildActive(2,reddot)
end

item:SetChildWeakGuideComponentId(-1,FMT.fmt('UILayoutEditWin.TabBtn_{0}',i+1))
end
self:freshBtnReddot(0,haveNum)
end

function UILayoutEditWin:setStorageNum(num,maxNum)

if maxNum>=9999 then
self.storageCount:setText('收纳种类：无限')
self.addStorage:setActive(false)
self.scRoot:setActive(true)
else
self.storageCount:setText(num>maxNum and string.format('收纳种类：<color=#c83232>%s/%s</color>',num,maxNum)or string.format('收纳种类：%s/%s',num,maxNum))
self.addStorage:setActive(false)

self.scRoot:setActive(true)
end
end

function UILayoutEditWin:initFilterData()
local datas=zongmenModel:getDesignStorageData()
local mapId=zongmenModel:getMountainId()
local idList={}
for i,v in pairs(datas)do
idList[v.build_id]=idList[v.build_id]or{}
table.insert(idList[v.build_id],v)
end
local haveDatas={}
if mapId==mapIdType.xianmeng then
haveDatas=xianmengModel:getStorageDatas()
else
haveDatas=zongmenModel:getAllstorageBuilding()
end
for k,v in pairs(haveDatas)do
if not zongmenModel:getDesignBuildingData(v.un_build_id)and not datas[v.un_build_id]then
idList[v.build_id]=idList[v.build_id]or{}
table.insert(idList[v.build_id],v)
end
end
local rlist={}
for i,v in pairs(idList)do
local bdCfg=cfgHelper.get1(cfg_monijybuildconfig_get,v[1].build_id)
rlist[bdCfg.func_type]=rlist[bdCfg.func_type]or{}
table.insert(rlist[bdCfg.func_type],v)
end

self.filterDatas=rlist

end

function UILayoutEditWin:refreshSortCount()
self:initFilterData()
local maxNum=zongmenModel:getStorageMaxNum()
local grids=self.sortBtnScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
local haveNum=false
for i=0,count-1 do
local item=grids[i]
local data=self.btnDatas[i+1]
local page=data.page
local num=0
if self.filterDatas[page]then
for i,v in ipairs(self.filterDatas[page])do
num=num+1
end
end

if self.selectId==i and page<10000 then
self:refreshStorageView(page)
end

if page==1 then
self:setStorageNum(num,maxNum)
item:SetChildText(4,num-maxNum)
item:SetChildActive(3,num-maxNum>0)
else
item:SetChildActive(3,num>0)
item:SetChildText(4,num)
if num>0 then
haveNum=true
end
end
end
self:freshBtnReddot(0,haveNum)
end

function UILayoutEditWin:getSortCount()
local grids=self.sortBtnScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local data=self.btnDatas[i+1]
local page=data.page
local num=0
if self.filterDatas[page]then
for i,v in ipairs(self.filterDatas[page])do
num=num+1
end
end
if page~=1 then
if num>0 then
return i+1
end
end
end
end


function UILayoutEditWin:isShowOrientation(cfg,bdData)
if cfg.is_orientation==0 then
return false
end
return true
end



function UILayoutEditWin:isCanStorage(cfg,bdData,wraning)
if emergenciesControl:isBuildingOnFire(bdData.entityId)then
return false
end
local maxNum=zongmenModel:getStorageMaxNum()
local sCount=zongmenModel:getJingGuanStorageCount()
if sCount>=maxNum then
if wraning then
UIManager.error('建筑收纳空间已满')
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
return true
end

function UILayoutEditWin:showBuildingLinkSlot(bShow,data)
if bShow then
local linkSlot=isometricMapSystem:getLinkSlotId(data.build_id,data.flag)
isometricMapSystem:showLinkSlot(data.entityId,linkSlot)
else
isometricMapSystem:showLinkSlot(data,-1)
end
end

function UILayoutEditWin:IsCanPlace(guid,pcfg)

if _MapManager.IsCanPlace(guid,pcfg or conditionConfig.designPlace)and not zongmenModel:checkDesignBuildingDataOverlapByBuildId(946,guid)then
return true
end
UIManager.error('该位置无法放置建筑')
return false
end

function UILayoutEditWin:PickUpBuilding(guid,bdData)
if isometricMapSystem:hasPreviewBuilding()then
return
end

if self.isInEditMode then
self.exportLua:PickUpBuilding(self,guid,bdData)
return
end

self:showRootWin(false)

self.hType=3
_MapManager.SetObjectPlaceCheckID(guid,conditionConfig.designPlace)
isometricMapSystem:onPickUpBuilding(guid,bdData,function(data)
_MapManager.SetObjectPlaceCheckID(guid,conditionConfig.designPlace)
hudControl:changeContainer(data.hudId,1)

if not isometricMapSystem:hasPreviewBuilding()then
return
end
self:showCloseBtn(false)
UIManager:invokeUIMethod("UILayoutWin","showBuildingInfo",bdData.build_id,bdData.level)

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
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
self:showCloseBtn(true)
UIManager:invokeUIMethod("UILayoutWin","hideBuildingInfo")
end
self.hudWidget:SetChildButtonClick(0,cancelFunc)
self.hudWidget:SetChildButtonClick(1,function()
isometricMapSystem:setflipX(guid,building.bdData,building.orientation==0,cfg.model[1])
building.orientation=building.orientation==0 and 1 or 0

end)
self.hudWidget:SetChildButtonClick(2,function()
if self:IsCanPlace(guid,conditionConfig.designPlace)then


AudioManager.playAudio(432)
local pv=isometricMapSystem:getObjectPosValue(guid)
if pv[1]~=bdData.x or pv[2]~=bdData.y or bdData.orientation~=building.orientation then
isometricMapSystem:onDesignMove(self.sfId,bdData.un_build_id,pv[1],pv[2],building.orientation)



self.hudWidget=nil
self.hType=0
isometricMapSystem:hideBuffArea()

self:showRootWin(true)

zongmenModel:saveDesignData()
zongmenModel:saveDesignRoadData()
zongmenModel:flushSaveDesignData()

if self.inTemplate and self.selectTemplateIdx then
self:refreshTemplateItemSelect(self.selectTemplateIdx,false)
end
self.selectTemplateIdx=nil
self:showCloseBtn(true)
UIManager:invokeUIMethod("UILayoutWin","hideBuildingInfo")
else
cancelFunc()
end

end

end)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local showStorage=true
self.hudWidget:SetChildActive(3,showStorage)
if showStorage then
self.hudWidget:SetChildButtonClick(3,function()



if bdData.flag and bdData.flag~=0 then
UIManager.error('建筑正在建造中，无法收纳')
return
end

isometricMapSystem:onDesignStore(self.sfId,bdData.un_build_id)


self:refreshSortCount()
self:showRootWin(true)
self:showCloseBtn(true)
UIManager:invokeUIMethod("UILayoutWin","hideBuildingInfo")



UIManager.info("建筑已成功收起")

self.hType=0
end)
end

self.hudWidget:SetChildActive(4,false)





isometricMapSystem:showBuffArea(guid)
end)
end

function UILayoutEditWin:Cancel(changeModel)
if self.hType==3 then
isometricMapSystem:cancelDesignPickUp()
elseif self.hType==2 then
isometricMapSystem:cancelBuild()
end
self.hudWidget=nil
if not changeModel then
self.selectRoadId=nil
end
self.hType=0
if self.model==1 then
self:showRootWin(true)
end

end

function UILayoutEditWin:on_sort_btn_click(index)
if self.selectId then
local item=self.sortBtnScrollview:getChildScrollViewItemWidget(self.selectId)
item:SetChildActive(0,false)
end

self.selectId=index

local item=self.sortBtnScrollview:getChildScrollViewItemWidget(self.selectId)
if item then
item:SetChildActive(0,true)
end

self.btnDatas[index+1].func()

end

function UILayoutEditWin:onStorageBtn(page)
self:refreshStorageView(page)
end

function UILayoutEditWin:getBDShowPos()
if self.lastBDPos then
return self.lastBDPos
else
local mapId=zongmenModel:getMountainId()
return _MapManager.ScreenPointToCell(mapId,Vector3.New(_Screen.width*0.5,_Screen.height*0.5,0),0,mapLayer.Data)
end
end

function UILayoutEditWin:OnStorageItemSelect(index,checkLast)
local page=self.btnDatas[self.selectId+1].page
local bdData=self.filterDatas[page]or{}
local data=bdData[index+1]
if data then
data=data[1]
local bdId=data.un_build_id

if checkLast and data.build_id~=checkLast then
return
end


self.hType=2

local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)

local level=data.level
local bpos=self:getBDShowPos()

local useDefPos=false


self:showRootWin(false)

local func=function(bdata)

hudControl:changeContainer(bdata.hudId,1)

if not self or(self and self.isClose)then
hudControl:removeHUD(bdata.hudId)
_MapManager.RemoveTilemapObject(bdata.guid)
return
end

if not isometricMapSystem:hasPreviewBuilding()then
return
end
self:showCloseBtn(false)
UIManager:invokeUIMethod("UILayoutWin","showBuildingInfo",cfg.id,level)

local building=bdata
local guid=building.guid
self.buildingGuid=guid
isometricMapSystem:setEditorMode(editorMode.ePlace)
isometricMapSystem:setPlaceObject(guid)

self.hudWidget=hudControl:getHUDWidget(building.hudId)
self.hudWidget:SetChildButtonClick(0,function()
self:Cancel()
self.hudWidget=nil
self:showCloseBtn(true)
UIManager:invokeUIMethod("UILayoutWin","hideBuildingInfo")
end)
self.hudWidget:SetChildButtonClick(1,function()
isometricMapSystem:setflipX(guid,building.bdData,building.orientation==0,cfg.model[1])
building.orientation=building.orientation==0 and 1 or 0

end)
self.hudWidget:SetChildButtonClick(2,function()
if self:IsCanPlace(guid,cfg.pCfgId or conditionConfig.designPlace)then

local pv=isometricMapSystem:getObjectPosValue(guid)
if pv[1]~=bdData.x or pv[2]~=bdData.y or bdData.orientation~=building.orientation then

hudControl:removeHUD(building.hudId)

local data=table.deepCopy(zongmenModel:getBuildingData(bdId))
local oldEntityId

if not data then
data=table.deepCopy(zongmenModel:getStorageBuilding(bdId))
data.entityId=guid
data.modelIndex=bdata.modelIndex
data.flag=0
else
oldEntityId=data.entityId
data.entityId=guid
end

data.x=pv[1]
data.y=pv[2]
data.orientation=building.orientation

zongmenModel:saveDesignBuildingData(self.sfId,bdId,data)
zongmenModel:setDesignBuildingMapData(self.sfId,bdId,data)
zongmenModel:setDesignEntityId(bdId,guid)


if _MapManager.IsPlace(guid)then
_MapManager.PickUpFromMap(guid)
end
_MapManager.SetPosition(data.entityId,_MapManager.ToVector3Int(data.x,data.y,0))
isometricMapSystem:setflipX(guid,data,data.orientation==1,cfg.model[1])
_MapManager.PlaceToMap(data.entityId,conditionConfig.designPlace)
local layer
if cfg.etype==2 then

layer=SortingLayers.ITBuilding
local idArr=_MapManager.GetLayoutBuildingMembersGUID(data.entityId,1)
local st=_EntityManager:GetEntity(idArr[1])
st:SetSortingLayer(SortingLayers.ITGrid2)
else
layer=SortingLayers.ITBuilding
end
_MapManager.SetSortingLayer(data.entityId,layer)



AudioManager.playAudio(432)

zongmenModel:delDesignStorageData(bdId)
table.remove(self.filterDatas[page][index+1],1)
if not next(self.filterDatas[page][index+1])then
table.remove(self.filterDatas[page],index+1)
end
self:refreshSortCount()
self.hudWidget=nil
self.hType=0
isometricMapSystem:hideBuffArea()
self:showCloseBtn(true)
UIManager:invokeUIMethod("UILayoutWin","hideBuildingInfo")
self:showRootWin(true)


isometricMapSystem:clearStatus()






















zongmenModel:saveDesignData()
zongmenModel:flushSaveDesignData()
self.lastBDPos=_MapManager.ToVector3Int(data.x,data.y,0)


self:OnStorageItemSelect(index,data.build_id)

hudControl:refreshBuildingStatusHUD(bdId)


if self.inTemplate and self.selectTemplateIdx then
self:refreshTemplateItemSelect(self.selectTemplateIdx,false)
end
self.selectTemplateIdx=nil
else

self:Cancel()
end
end
end)
local showOrientation=self:isShowOrientation(cfg,building.bdData)
self.hudWidget:SetChildActive(1,showOrientation)
self.hudWidget:SetChildActive(3,false)
self.hudWidget:SetChildActive(4,false)

isometricMapSystem:showBuffArea(guid)
end
local bdata=zongmenModel:getDesignBuilding(bdId)
local designData=zongmenModel:getDesignBuildingData(bdId)or bdata
local args={
id=cfg.id,
skinId=bdata~=nil and bdata.build_appearance_id,
cfg=cfg,
level=level,
pos=bpos,
useDefPos=useDefPos,
callback=func,
pCfgId=conditionConfig.designPlace,

flag=data.flag,
checkPlaceId=conditionConfig.designPlace,
plantid=bdata~=nil and bdata.plant_id,
plan_status=bdata~=nil and bdata.planStatus,
flip=designData.orientation==1,

}
isometricMapSystem:createBuilding(args)





end
end

function UILayoutEditWin:on_swipe(fingerIndex,touchCount,screenPoint,swipe,swipeVector,swipeLength,deltaTime)
if self and not self.isClose then
self:refreshApplyBtn()
end
end

function UILayoutEditWin:refreshApplyBtn()
if self.hudWidget then
local preview=isometricMapSystem:getPreviewBuilding()
if preview then
local pCfgId=conditionConfig.designPlace

local canPlace=_MapManager.IsCanPlace(self.buildingGuid,pCfgId)
if canPlace~=self.rcPlaceState then
self.rcPlaceState=canPlace
self.hudWidget:SetChildCSImageSprite(2,self.hudAB,canPlace and'button_jzqueding'or'button_jzqueding_1')
end
end
end
end

function UILayoutEditWin:refreshStorageView(page)
local bdData=self.filterDatas[page]or{}
self.tempScrollview:setActive(false)
self.storageScrollview:setActive(true)
self.storageScrollview:setChildScrollViewCreateGrids(#bdData,0)
local grids=self.storageScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local dlist=bdData[i+1]
local data=dlist[1]
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,data.build_id)
local item=grids[i]
local len=#dlist

item:SetChildText(0,cfg.name)
local check=len>1
item:SetChildActive(2,check)
if check then
item:SetChildText(3,len)
end

item:SetChildIcon(1,cfg.icon,true)
end

self.storageTips:setActive(count==0)
if count==0 then
local tips={'景观','设施','生产','商铺',}
self.storageTips:setText(FMT.fmt("尚无{0}建筑需要进行摆放",tips[page]))
end

if page==1 then
self.scRoot:setScale(Vector3.one)
else
self.scRoot:setScale(Vector3.zero)
end
end

function UILayoutEditWin:refreshTemplateList()
local list=ims_design_layout:getTemplateConfig(true)
self.tempScrollview:setActive(true)
self.storageScrollview:setActive(false)
self.templateList=list
local isSelect=false
local selectId




self.tempScrollview:setChildScrollViewCreateGrids(#list,0)
local grids=self.tempScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local template=list[i+1]
local item=grids[i]

if selectId==template.id then
self.selectTemplateIdx=i+1
end

item:SetChildText(0,template.name)
item:SetChildActive(2,self.selectTemplateIdx==i+1)

local isConditionsUnlock,conditionStr=ims_design_layout:getConditionsUnlock(template.conditions)
local isUnlock=ims_design_layout:getUnlockTemplate(template.id)
if not isConditionsUnlock and not isUnlock then
item:SetChildText(3,conditionStr)
item:SetChildActive(3,true)
item:SetChildActive(4,false)
item:SetChildActive(6,true)
elseif template.cost_items and not isUnlock then
item:SetChildActive(3,false)
item:SetChildActive(4,true)
item:SetChildActive(6,false)
else
item:SetChildActive(3,false)
item:SetChildActive(4,false)
item:SetChildActive(6,false)
end

if self.selectTemplateIdx==i+1 then
isSelect=true
if not isConditionsUnlock and not isUnlock then
self:showUnlockBtn(false,nil,true)
else
self:showUnlockBtn((not isUnlock)and template.cost_items~=nil,template.cost_items)
end
end

item:SetChildButtonClick(5,function()
self:onTemplateItemClick(i+1)
end)

item:SetChildCSImageSprite(1,"ui/windows/layout/layout_template_atlas_pak.ab",FMT.fmt("icon_layout_{0}",template.icon))
end
self.previewButton:setActive(isSelect and self.selectTemplateIdx~=-1)
end

function UILayoutEditWin:refreshTemplateItem(templateId,enter)
if self.templateList then
for i,v in ipairs(self.templateList)do
if v.id==templateId then
local grid=self.tempScrollview:getChildScrollViewItemWidget(i-1)
if grid then
grid:SetChildActive(4,false)
end
local isConditionsUnlock,conditionStr=ims_design_layout:getConditionsUnlock(v.conditions)
local isUnlock=ims_design_layout:getUnlockTemplate(v.id)
if not isConditionsUnlock and not isUnlock then
self:showUnlockBtn(false,nil,true)
else
self:showUnlockBtn((not isUnlock)and v.cost_items~=nil,v.cost_items)
end
if self.selectTemplateIdx==i and enter then
ims_design_layout:onEnterTemplateMap(templateId)
self.previewButton:setActive(v.id~=-1)
end
return
end
end
end
end

function UILayoutEditWin:refreshTemplateItemSelect(selectTemplateIdx,flag)
local grid=self.tempScrollview:getChildScrollViewItemWidget(selectTemplateIdx-1)
if grid then
grid:SetChildActive(2,flag)
end
end

function UILayoutEditWin:showUnlockBtn(show,cost,isGray)
self.unlockButton:setActive(show)
self.applyButton:setActive(not show)
self.chongzhiBtn:setActive(not show)
self.shouqiBtn:setActive(not show)
self.applyButton:setGray(isGray)
if show then
local iconname=iconHelper.getIconName(cost[1])
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,32)
self.unlockCost:setText(FMT.fmt("{0}{1}",iconStr,cost[2]))
end
end

function UILayoutEditWin:onTemplateItemClick(idx)
local config=self.templateList[idx]
local unlock=not(config.cost_items and not ims_design_layout:getUnlockTemplate(config.id))
local isConditionsUnlock,conditionStr=ims_design_layout:getConditionsUnlock(config.conditions)
local isUnlock=ims_design_layout:getUnlockTemplate(config.id)
if not isConditionsUnlock and not isUnlock then
if self.inTemplate and self.selectTemplateIdx then
self:refreshTemplateItemSelect(self.selectTemplateIdx,false)
end
self.selectTemplateIdx=nil

self:showPreview(config.id)
return
end
local oldSelectIdx=self.selectTemplateIdx
if oldSelectIdx then
local grid=self.tempScrollview:getChildScrollViewItemWidget(oldSelectIdx-1)
if grid then
grid:SetChildActive(2,false)
end
end
local grid=self.tempScrollview:getChildScrollViewItemWidget(idx-1)
if grid then
grid:SetChildActive(2,true)
end


if unlock then
if self.selectTemplateIdx==idx then
return
end
if config.isMyLayout then
ims_design_layout:loadMyMapData()
else
ims_design_layout:onEnterTemplateMap(config.id)
end

if not isConditionsUnlock and not isUnlock then
self:showUnlockBtn(false,nil,true)
else
self:showUnlockBtn(false)
end
else
if not isConditionsUnlock and not isUnlock then
self:showUnlockBtn(false,nil,true)
elseif config.cost_items and not isUnlock then
self:showUnlockBtn(true,config.cost_items)
else
self:showUnlockBtn(false)
end
end
self.previewButton:setActive(config.id~=-1)
self.selectTemplateIdx=idx
end

function UILayoutEditWin:onTemplateClick()
self:refreshTemplateList()

if ims_design_layout:isLayoutReddot()then
userActorArraySetting.set(ACTOR_SETTING_TYPE.eMyZongMenLayout,'systemReddot',nil)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eMyZongMenLayout)
reddotControl.on_change_catch_type(CATCH_TYPE.eDesignLayoutOpen,false)
ims_design_layout:refreshLayoutReddot()
end
end

function UILayoutEditWin:refreshLayoutReddot()
local grids=self.sortBtnScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local data=self.btnDatas[i+1]
if data.page==10000 then
local reddot=ims_design_layout:isLayoutReddot()
item:SetChildActive(2,reddot)
break
end
end
end

function UILayoutEditWin:onTestEditClick()
self.exportLua:refreshBuildingList(self)
end





function UILayoutEditWin:onClickMask()

end



function UILayoutEditWin:onTipspanel()
end



function UILayoutEditWin:onShouqiBtn()
if self.hType>0 then
return
end
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLayoutEditorStorageAllBuilding)
if not check then
local showdata=
{
type='UIDialouge',
title='提示',
content='是否将已摆放的<color=#ba5f00>建筑</color>，<color=#ba5f00>道路</color>和<color=#ba5f00>围墙</color>全部收起？',
canceltext='取消',
oktext='确定',
allowclickBG=true,
okcallback=function(...)
zongmenModel:setDesignAllBuildingStorage()
isometricMapSystem:clearDesignRoadData()
zongmenModel.data.designRoadData={}
UIManager.info("全部收起成功")
zongmenModel:saveDesignData()
zongmenModel:saveDesignRoadData()
zongmenModel:flushSaveDesignData()

zongmenModel:selectDesignLayoutId()
if self.inTemplate and self.selectTemplateIdx then
self:refreshTemplateItemSelect(self.selectTemplateIdx,false)
end
self.selectTemplateIdx=nil
self.previewButton:setActive(false)
end,
choosetext='今日不再提示',
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLayoutEditorStorageAllBuilding,flag)

end,
showclosebtn=true,
}
if self.comfirmDialog then
self.comfirmDialog.deleteSelf=function(...)

if self and not self.isClose then
self.comfirmDialog=nil
end
end
else
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog.deleteSelf=function(...)

if self and not self.isClose then
self.comfirmDialog=nil
end
end
self.comfirmDialog:show()
end
else
zongmenModel:setDesignAllBuildingStorage()
isometricMapSystem:clearDesignRoadData()
UIManager.info("全部收起成功")

zongmenModel:saveDesignData()
zongmenModel:saveDesignRoadData()
zongmenModel:flushSaveDesignData()

zongmenModel:selectDesignLayoutId()
if self.inTemplate and self.selectTemplateIdx then
self:refreshTemplateItemSelect(self.selectTemplateIdx,false)
end
self.selectTemplateIdx=nil
end

end

function UILayoutEditWin:onChongzhiBtn()
if self.hType>0 then
return
end
local check=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLayoutEditorDesignReset)
if not check then
local showdata=
{
type='UIDialouge',
title='提示',
content='是否重置还原回当前的宗门布局？',
canceltext='取消',
oktext='确定',
allowclickBG=true,
okcallback=function(...)
self:setChongzhi(true)
end,
choosetext='今日不再提示',
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eLayoutEditorDesignReset,flag)

end,
showclosebtn=true,
}
if self.comfirmDialog then
self.comfirmDialog.deleteSelf=function(...)

if self and not self.isClose then
self.comfirmDialog=nil
end
end
else
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog.deleteSelf=function(...)

if self and not self.isClose then
self.comfirmDialog=nil
end
end
self.comfirmDialog:show()
end
else
self:setChongzhi(true)
end
end

function UILayoutEditWin:setChongzhi(isTips)
zongmenModel:resetDesignMap(true)
zongmenModel:selectDesignLayoutId()
if self.inTemplate and self.selectTemplateIdx then
self:refreshTemplateItemSelect(self.selectTemplateIdx,false)
end
self.selectTemplateIdx=nil
self.previewButton:setActive(false)
self:refreshSortCount()
zongmenModel:saveDesignData()
zongmenModel:saveDesignRoadData()
zongmenModel:flushSaveDesignData()
if isTips then
UIManager.info("宗门布局已重置")
end
end



function UILayoutEditWin:onGroundBtn()
end



function UILayoutEditWin:onCloseBtn()
UIManager:invokeUIMethod("UILayoutWin","on_btns_click",1,0)
end



function UILayoutEditWin:onApplyButton()
if self.hType>0 then
return
end
if self.selectTemplateIdx then
local config=self.templateList[self.selectTemplateIdx]
local isConditionsUnlock,conditionStr=ims_design_layout:getConditionsUnlock(config.conditions,true)
local isUnlock=ims_design_layout:getUnlockTemplate(config.id)
if not isConditionsUnlock and not isUnlock then
return
end
end
zongmenModel:applyLayout()
end

function UILayoutEditWin:onHelpButton()
local d={}
d.title='提示'
d.mode=3
d.name='layout_design_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UILayoutEditWin:onStartTestBtn()

self:initTabBtns()
self.exportTestBtn:setActive(true)
self.loadTestBtn:setActive(true)
self.inputTextField:setActive(true)
end

function UILayoutEditWin:onPreviewButton()
if self.selectTemplateIdx and self.templateList[self.selectTemplateIdx]then
self:showPreview(self.templateList[self.selectTemplateIdx].id)
end
end

function UILayoutEditWin:showPreview(id)
ims_design_layout:onEnterPreviewMap(id)

self:delayDo(1,function()
self.root:setActive(false)
UIManager:invokeUIMethod("UILayoutWin",'showBtnScrollView',false)
if self and not self.isClose then
self:showWindow("UILayoutPreviewWin")
end
end)
end

function UILayoutEditWin:showEditWin(show)
self.root:setActive(show)
end

function UILayoutEditWin:onUnlockButton()
if self.selectTemplateIdx and self.templateList[self.selectTemplateIdx]then
local cost_items=self.templateList[self.selectTemplateIdx].cost_items
moneySystem:useMoney(cost_items[1],cost_items[2],function()
ims_design_layout.req_3_60(self.templateList[self.selectTemplateIdx].id)
end,WARNING_TYPE.eWarning)
end
end

function UILayoutEditWin:onExportTestBtn()
local inputstr=self.inputTextField:getInputFieldValue()
if inputstr then
inputstr=tonumber(inputstr)
designLayoutExport:saveLayoutMap(self,inputstr)
end
end

function UILayoutEditWin:onSearchChange(str)

end

function UILayoutEditWin:onTestCreateRoadButton()
local inputstr=self.inputRoadIdField:getInputFieldValue()
if inputstr then
inputstr=tonumber(inputstr)
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,inputstr)
if cfg then
isometricMapSystem:setCurrentRoadType(inputstr)
self:Cancel()
isometricMapSystem:setEditorMode(editorMode.eCreateRoad)
self:showRootWin(false)
self.enterTestRoadMode=true
self.curr_road_type=inputstr
else
UIManager.error("道路配置不存在")
end
end
end

function UILayoutEditWin:onTestDelRoadButton()
self:Cancel()
isometricMapSystem:setEditorMode(editorMode.eDeleteRoad)
self:showRootWin(false)
self.enterTestRoadMode=true
end

function UILayoutEditWin:onTestQuitRoadButton()
isometricMapSystem:setEditorMode(editorMode.eDefault)
self:showRootWin(true)
self:ShowMarkPos(false,false)
self.enterTestRoadMode=nil
end

function UILayoutEditWin:setRoadPath(path)
if self.enterTestRoadMode or self.model~=1 then
self.path=path
end
end

function UILayoutEditWin:SetBeginMarkPos(pos)
local mapId=zongmenModel:getMountainId()

hudControl:setHUDTargetPosition(self.beginMark.guid,mapId,pos)
end

function UILayoutEditWin:SetEndMarkPos(pos,count)
local mapId=zongmenModel:getMountainId()
hudControl:setHUDTargetPosition(self.endMark.guid,mapId,pos)
self.isCanCR=true
end

function UILayoutEditWin:ShowMarkPos(v1,v2)
self.beginMark.widget:SetChildActive(0,v1)
self.endMark.widget:SetChildActive(0,v2)
end

function UILayoutEditWin:onTestCancelClick()
if self.enterTestRoadMode then
self.path=nil
isometricMapSystem:cancelRoad()
self:ShowMarkPos(false,false)
end
end

function UILayoutEditWin:onTestApplyClick()
if self.enterTestRoadMode then

if isometricMapSystem.editorMode==editorMode.eCreateRoad then
local fpath=self.path
local dArr=_MapManager.PathToArray(fpath)
local sList=_MapManager.GetMapCellStyle(mapLayer.DrawRoad2,fpath)
local tlist={}
local tlen=#dArr
local cfgs=cfg_roadstyleconfig()
local rdlists={}
for k,v in pairs(cfgs)do
rdlists[k]={}
end
local scount=1
for i=1,tlen,3 do
table.insert(tlist,{dArr[i],dArr[i+1],self.curr_road_type,sList[scount]})

local rt=self.curr_road_type
local rdlist=rdlists[rt]
local count=#rdlist+1
rdlist[count]=dArr[i]
count=count+1
rdlist[count]=dArr[i+1]
count=count+1
rdlist[count]=0
count=count+1
rdlist[count]=rt
count=count+1
rdlist[count]=sList[scount]

scount=scount+1
end
self.exportLua:setRoadData(self,tlist)
for k,v in pairs(rdlists)do
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,k)
_MapManager.DrawRoadByData(mapIdType.zhufeng_design,v,mapLayer[cfg.layer])
end
elseif isometricMapSystem.editorMode==editorMode.eDeleteRoad then
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,self.curr_road_type)
local datas=isometricMapSystem:splitPath(self.path)
_MapManager.DrawRoadByPath(mapIdType.zhufeng_design,self.path,self.curr_road_type,mapLayer[cfg.layer],true,true)
for i,v in pairs(datas)do

self.exportLua:delRoadData(self,v)
end
end

self:onTestCancelClick()
end
end

function UILayoutEditWin:onTestClearRoadButton()
self.exportLua:clearRoadData(self)
end

function UILayoutEditWin:onTestInitRoadButton()
self.exportLua:initRoadData(self)
end

function UILayoutEditWin:onLoadTestBtn()
local inputstr=self.inputTextField:getInputFieldValue()
if inputstr then
inputstr=tonumber(inputstr)
ims_design_layout:onTestEnterTemplateMap(inputstr,function()self.exportLua:initRoadDataByConfigId(self,inputstr)end)
end
end

function UILayoutEditWin:onBuildBtn()
self:showRootWin(true)
self:showRoadRootWin(false)
if self.rootWin then
self.rootWin.joyStickRoot:setActive(false)
end
isometricMapSystem:setEditorMode(editorMode.eDefault)
self:SetTips("宗门布局修改后，祖师需要进行应用才能生效")
end


function UILayoutEditWin:SetTips(tips)

if tips then
self.tipsbg:setActive(true)
self.tips:setText(tips)
else
self.tipsbg:setActive(false)
self:setCostTips()
end
end




function UILayoutEditWin:onChangeRoad(rtype,opType)

self.opRoadType=opType


local isChangeRoadType=self.roadtype~=rtype
self.roadtype=rtype

self.styleCfgs=self:getStyleData(rtype)


local styleId=nil

if isChangeRoadType then
styleId=self.styleCfgs[1]or self.defaultRoadId[rtype]
else
styleId=self.selectRoadId or self.styleCfgs[1]or self.defaultRoadId[rtype]
end
local len=#self.styleCfgs
self.selectStyleId=styleId


if isChangeRoadType then

isometricMapSystem:hideBuffArea()
isometricMapSystem:cancelRoad()
self:ShowMarkPos(false,false)
end

self:showRoadRootWin(true)

isometricMapSystem:setCurrentRoadType(styleId)

if(opType==1 or opType==nil)and len>1 then
self:onCreateRoadBtn()
else
self:onChangeCreateRoadMode()
end

self.isDelete=false
self.deleteSelect:setActive(self.isDelete)
self.deleteNomal:setActive(not self.isDelete)

self:showRootWin(false)


isometricMapSystem:reDrawPath()

if self.inTemplate and self.selectTemplateIdx then
self:refreshTemplateItemSelect(self.selectTemplateIdx,false)
end
self.selectTemplateIdx=nil
end

function UILayoutEditWin:onApplyClick()
if self.model~=1 then
if isometricMapSystem.editorMode==editorMode.eCreateRoad then
local fpath=self.path
local dArr=_MapManager.PathToArray(fpath)
local sList=_MapManager.GetMapCellStyle(mapLayer.DrawRoad2,fpath)
local tlist={}
local tlen=#dArr
local cfgs=cfg_roadstyleconfig()
local rdlists={}
for k,v in pairs(cfgs)do
rdlists[k]={}
end
local scount=1
for i=1,tlen,3 do
table.insert(tlist,{dArr[i],dArr[i+1],self.selectStyleId,sList[scount]})

local rt=self.selectStyleId
local rdlist=rdlists[rt]
local count=#rdlist+1
rdlist[count]=dArr[i]
count=count+1
rdlist[count]=dArr[i+1]
count=count+1
rdlist[count]=0
count=count+1
rdlist[count]=rt
count=count+1
rdlist[count]=sList[scount]

scount=scount+1
end
zongmenModel:setDesignRoadData(tlist)
for k,v in pairs(rdlists)do
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,k)
_MapManager.DrawRoadByData(mapIdType.zhufeng_design,v,mapLayer[cfg.layer])
end
if mapLayer[cfgs[self.selectStyleId].layer]==mapLayer.Data then
_MapManager.Erase(mapIdType.zhufeng_design,fpath,mapLayer.Road1)
else
_MapManager.Erase(mapIdType.zhufeng_design,fpath,mapLayer.Data)
end
zongmenModel:saveDesignRoadData()
zongmenModel:flushSaveDesignData()
elseif isometricMapSystem.editorMode==editorMode.eDeleteRoad then
local cfg=cfgHelper.get1(cfg_roadstyleconfig_get,self.selectStyleId)
local datas=_MapManager.PathToArray(self.path)
_MapManager.DrawRoadByPath(mapIdType.zhufeng_design,self.path,self.selectStyleId,mapLayer[cfg.layer],true,true)
local tlen=#datas
for i=1,tlen,3 do
zongmenModel:delDesignRoadData({{datas[i],datas[i+1],datas[i+2]}})
end
zongmenModel:saveDesignRoadData()
zongmenModel:flushSaveDesignData()
end

self:onCancelClick()
end
end

function UILayoutEditWin:onCancelClick()
self.path=nil
isometricMapSystem:cancelRoad()
self:ShowMarkPos(false,false)
end


function UILayoutEditWin:setRoadItem(item,cfg)
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
item:SetChildText(14,'')
item:SetChildActive(15,false)
item:SetChildActive(16,zongmenModel:hasActiveRoadReddot(cfg.id))
if cfg.cost then
item:SetChildActive(5,false)



else
item:SetChildActive(5,true)
item:SetChildText(5,cfg.desc)
item:SetChildActive(3,false)
item:SetChildActive(4,false)
item:SetChildActive(8,false)
end
end

function UILayoutEditWin:clearStyle()
self.showStyle=false
self.styleCfgs={}
self:closeStyleAni()
end

function UILayoutEditWin:showStylePanel(vis)
if self.stylePanelVis~=vis then

self.stylePanel:setActive(vis)
self.stylePanelVis=vis
end
end

function UILayoutEditWin:freshStyle()
local len=#self.styleCfgs
local showStyle=len>=1

self.showStyle=showStyle
self:showStylePanel(showStyle)
self:setJuanZhou()
self.styleArrowBtn:setActive(self.opRoadType==2)


if showStyle then
local roadtype=self.roadtype
local titleSprite=_titleSprite[roadtype]
self.styleTitle:setSprite(_titleBundle,titleSprite)
end
end

function UILayoutEditWin:setJuanZhou()
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

function UILayoutEditWin:closeStyleAni()
self:visStyleRoot(false)
self.roadJuanZhou:setActive(false)
end

function UILayoutEditWin:playStyleAni(showAni)
self.showJuanZhouAni=showAni
self:playJuanZhou()
end

function UILayoutEditWin:visStyleRoot()
if self.styleTimer then
self:stopTimerByID(self.styleTimer)
self.styleTimer=nil
end
local vis=self.model==3 and self.opRoadType==1
if vis then
self:freshStyleView()
end
end

function UILayoutEditWin:playJuanZhou()
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

function UILayoutEditWin:showRoadView()
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

function UILayoutEditWin:getStyleData(roadtype)
local roadtype=roadtype or self.roadtype
local mapid=mapIdType.zhufeng
local cfg=cfg_monijysfconfig_get(mapid)
local road_menu=cfg.road_menu or{}
local defaultId=self.defaultRoadId[roadtype]
local defaultList={defaultId}

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

function UILayoutEditWin:freshStyleView()
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


item:SetChildText(5,'')
item:SetChildActive(6,isNew)

item:SetChildActive(7,false)
end
end

function UILayoutEditWin:onPlayStyleAniFinish(isEnter,isFinish)
if not isEnter and isFinish then
self.styleRoot:setActive(false)
end
end

function UILayoutEditWin:onStyleItemClick(id)
if self.selectStyleId==id then return end
self.selectStyleId=id

self:freshStyle()
end

function UILayoutEditWin:onRoadItemClick(id)
local rcfg=cfgHelper.get1(cfg_roadstyleconfig_get,id)
self.road_price=rcfg.cost and rcfg.cost[1]
self.roadtype=rcfg.func
self.selectRoadId=id
local lastSelect=self.fbSelectId
if self.roadtype==1 then
self:onChangeRoad(self.roadtype,2)
self.fbSelectId=1
else
self:onChangeRoad(self.roadtype,2)
self.fbSelectId=2
end
if lastSelect then
self:freshBtnSelect(lastSelect)
end
self:freshBtnSelect(self.fbSelectId)
self:showCloseBtn(true)
UIManager:invokeUIMethod("UILayoutWin","hideBuildingInfo")
isometricMapSystem:hideBuffArea()
isometricMapSystem:cancelRoad()
self:ShowMarkPos(false,false)
end


function UILayoutEditWin:onCreateRoadBtn()
local lastMode=self.model
self.opRoadType=1
self.hType=0
isometricMapSystem:hideBuffArea()
self.model=3
if self.rootWin then
self.rootWin.joyStickRoot:setActive(self.opRoadType==2)
end
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


function UILayoutEditWin:onChangeCreateRoadMode()
local lastMode=self.model
self.opRoadType=2
self.hType=0
isometricMapSystem:hideBuffArea()
self.model=3
if self.rootWin then
self.rootWin.joyStickRoot:setActive(self.opRoadType==2)
end
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

function UILayoutEditWin:onDeleteRoadBtn()
local lastMode=self.model
self.opRoadType=2
self.hType=0
isometricMapSystem:hideBuffArea()
self.model=4
if self.rootWin then
self.rootWin.joyStickRoot:setActive(self.opRoadType==2)
end
self:freshStyle()
isometricMapSystem:setEditorMode(editorMode.eDeleteRoad)
local sname=self.roadtype==1 and'button_jzchailu3'or'button_jzchailu3'
self.endMark.widget:SetChildCSImageSprite(3,self.hudAB,sname)
local tips=self.roadtype==1 and'请点击或拖动确定拆路起点'or'请点击或拖动确定拆墙起点'
self:SetTips(tips)

if lastMode==3 then
isometricMapSystem:reDrawPath()
end
end

function UILayoutEditWin:onDeleteBtn()
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
function UILayoutEditWin:onStyleArrowBtn()
isometricMapSystem:cancelRoad()
self:onCreateRoadBtn()
isometricMapSystem:hideBuffArea()
self:ShowMarkPos(false,false)
end

function UILayoutEditWin:onCancelDeleteRoadBtn()
self:onChangeRoad(self.roadtype)
end


function UILayoutEditWin:onMove(screenPoint)
local speed=Time.deltaTime*5
screenPoint={x=screenPoint.x*speed,y=screenPoint.y*speed}
_MapManager.SetCameraTranslate(screenPoint,0)
end
