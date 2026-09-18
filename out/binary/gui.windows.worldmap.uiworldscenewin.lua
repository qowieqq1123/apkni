







def_class("UIWorldSceneWin",UIWindowBase)









function UIWorldSceneWin:bindComponents()

self.ScrollView=UIObject.get(self,0)
self.Root=UIObject.get(self,1)
self.Map=UIImage.get(self,2)
self.Mask=UIObject.get(self,3)
self.ArrowFilterType=UIObject.get(self,4)
self.TextFilterType=UIText.get(self,5)
self.FilterAllOn=UIObject.get(self,6)
self.ListFilter=UIScrollView.get(self,7)
self.ButtonFilterType=UIButton.get(self,8)
self.ButtonFilterAll=UIButton.get(self,9)
self.ListFilterType=UIObject.get(self,10)
self.PanelFliter=UIObject.get(self,11)
self.ButtonWorld=UIButton.get(self,12)
self.PanelFilterType=UIButton.get(self,13)
self.ButtonZM=UIButton.get(self,14)
self.ButtonBack=UIButton.get(self,15)
self.ButtonFilter=UIButton.get(self,16)
self.Content=UIObject.get(self,17)
self.TipsTx=UIText.get(self,18)

self.ButtonFilterType:setButtonClick(function()self:onButtonFilterType()end)

self.ButtonFilterAll:setButtonClick(function()self:onButtonFilterAll()end)

self.ButtonWorld:setButtonClick(function()self:onButtonWorld()end)

self.PanelFilterType:setButtonClick(function()self:onPanelFilterType()end)

self.ButtonZM:setButtonClick(function()self:onButtonZM()end)

self.ButtonBack:setButtonClick(function()self:onButtonBack()end)

self.ButtonFilter:setButtonClick(function()self:onButtonFilter()end)



end


function UIWorldSceneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.Map);self.Map=nil;
_UIObject_release(self.Mask);self.Mask=nil;
_UIObject_release(self.ArrowFilterType);self.ArrowFilterType=nil;
_UIObject_release(self.TextFilterType);self.TextFilterType=nil;
_UIObject_release(self.FilterAllOn);self.FilterAllOn=nil;
_UIObject_release(self.ListFilter);self.ListFilter=nil;
_UIObject_release(self.ButtonFilterType);self.ButtonFilterType=nil;
_UIObject_release(self.ButtonFilterAll);self.ButtonFilterAll=nil;
_UIObject_release(self.ListFilterType);self.ListFilterType=nil;
_UIObject_release(self.PanelFliter);self.PanelFliter=nil;
_UIObject_release(self.ButtonWorld);self.ButtonWorld=nil;
_UIObject_release(self.PanelFilterType);self.PanelFilterType=nil;
_UIObject_release(self.ButtonZM);self.ButtonZM=nil;
_UIObject_release(self.ButtonBack);self.ButtonBack=nil;
_UIObject_release(self.ButtonFilter);self.ButtonFilter=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.TipsTx);self.TipsTx=nil;
end
















local mapItemCmp={
owner=0,
icon=1,
attach=2,
}
local filterItemCmp={
icon=0,
name=1,
off=2,
}
local filterTypeCmp={
button=0,
selected=1,
name=2,
}
local reduceValue=0.85
local reduceTime=0.3
local _this=nil
local _shows={true,false}
local _categories_order={
{"全部",{eWorldSceneMapItemType.MiJing,eWorldSceneMapItemType.Monster,eWorldSceneMapItemType.ResPoint,eWorldSceneMapItemType.Family}},
{"挑战",{eWorldSceneMapItemType.MiJing,eWorldSceneMapItemType.Monster}},
{"情报",{eWorldSceneMapItemType.Family}},
{"资源点",{eWorldSceneMapItemType.ResPoint}},
{"其他",{}},
}
local _filter_selecteds={}
local _categories_selecteds=1





function UIWorldSceneWin:onLoaded(...)
self:bindComponents()
_this=self
_categories_selecteds=worldSceneMapModel:getCategorieData()
_filter_selecteds=worldSceneMapModel:getFilterData()

self.ListFilter:setClickAction(self.onClickFilterItem)
self.ListFilterType:setChildLayoutGroupCreateItems(#_categories_order,self.onInitListFilterType)
self.PanelFilterType:setActive(_shows[2])

self.cDelay=self:delayDo(2.5,function()worldController:showCamera(false)end)
end


function UIWorldSceneWin:__delete()
worldController:releaseCloudMask()
self:unbindComponents()
_this=nil
_shows={true,false}
self:stopDelay()
self:stopSceleTween()
end




function UIWorldSceneWin:onShow(argtable,afterOnloaded)

self:stopSceleTween()
self.world=worldMapController:getCurrentScene()
self.worldCfg=cfgHelper.get1(cfg_worldconfig_get,self.world)
self.mapCfg=cfgHelper.get1(cfg_worldscenemapconfig_get,self.worldCfg.sceneMap)
self.Map:setSprite(self.mapCfg.res[1],self.mapCfg.res[2])
self.Map:setScale(Vector3.one*self.mapCfg.uiScale)
self.Map:setChildAnchoredPosition(mathHelper.convertArrayToVector(self.mapCfg.mapAnchoredPos))

self.list=worldSceneMapModel:getSceneMapUnitList(self.world)
self.Mask:setChildLayoutGroupCreateItems(#self.list,_this.refreshMapItem)

self:refreshFilterList()
self.FilterAllOn:setActive(self:checkAllOn())

local maskInfo=self.mapCfg.maskParams
local clouds=worldBlockModel:getMasks(self.world)
self.winlua:SetChildCSImageMatTextureEx(self.Map:getID(),"_ControlTex",maskInfo,clouds)
self.winlua:SetChildCSImageMatVector(self.Map:getID(),"_CtrOffset",worldSceneMapModel:getMaskUVRect(self.world))
self.Map:setActive(false)
self.Map:setActive(true)

self.TipsTx:setText(FMT.fmt("点击目的地进入<color=#38fa3c>{0}</color>",self.worldCfg.name))
end


function UIWorldSceneWin:onHide()

end





function UIWorldSceneWin.refreshMapItem(index)
local item=_this.winlua:GetChildLayoutGroupGridItem(_this.Mask:getID(),index-1)
local data=_this.list[index]
local type=data[1]
local x=data[2]
local y=data[3]
local unitKey=data[4]
local param=data[5]

local anchoredPos=worldSceneMapModel:changePosition(x,y,_this.world)
item:SetChildButtonClickWithID(mapItemCmp.icon,_this.onClickIcon,index)
item:SetChildAnchoredPosition(mapItemCmp.owner,anchoredPos)
item:SetChildScale(mapItemCmp.owner,Vector3.one*_this.mapCfg.iconScale)
local mapIcon,mapIconscale=worldSceneMapModel:getMapItemIcon(type,unpack(param))






item:SetChildCSImageIcon(mapItemCmp.icon,mapIcon,true)
item:SetChildScale(mapItemCmp.icon,Vector3.one*(mapIconscale or 1))
if type==eWorldSceneMapItemType.MiJing then
local taskKey=worldTaskModel:findTaskKey_ByTarget(unitKey)
if taskKey then
local task=worldTaskModel:getTask(taskKey)
local show=task and task.progress_state==eWorldTripProgress.Work or false
if show then
item:SetChildActive(mapItemCmp.attach,true)
item:SetChildCSImageSprite(mapItemCmp.attach,"ui/sharedtextures/uiglobalspriteatlas_1.ab","icon_dizitx_1")
return
end
end
end
item:SetChildActive(mapItemCmp.attach,false)
item:SetChildActive(mapItemCmp.owner,_filter_selecteds[type])
end

function UIWorldSceneWin:doAnimationScale(callback)
local endValue=self.mapCfg.uiScale*reduceValue
self.scaleTween=self.Map:setChildDOScale(endValue,reduceTime,function()
if callback then
callback()
end
end)
end

function UIWorldSceneWin:stopSceleTween()
if self.scaleTween then
self.scaleTween:Kill()
self.scaleTween=nil
end
end

function UIWorldSceneWin:stopDelay()
if self.cDelay then
self:stopTimerByID(self.cDelay)
self.cDelay=nil
end
end


function UIWorldSceneWin:getMapLocalPosition(screenPoint)
return self.winlua:GetChildUIScreenPos2Local(self.Map:getID(),screenPoint)
end

function UIWorldSceneWin:getFilterList(index)
local temp=_categories_order[index or _categories_selecteds]







return temp and temp[2]or{}
end

function UIWorldSceneWin:checkAllOn()
local list=self:getFilterList(1)
for i,v in ipairs(list)do
if not _filter_selecteds[v]then
return false
end
end
return true
end


function UIWorldSceneWin:showFilter(show)
self.PanelFliter:setActive(show)
_shows[1]=show
end


function UIWorldSceneWin:showFilterCategory(show)
self.PanelFilterType:setActive(show)
self.ArrowFilterType:setRotation(0,0,show and 180 or 0)
_shows[2]=show
end

function UIWorldSceneWin:refreshFilterList()

local list=self:getFilterList()
self.ListFilter:freshGridsNum(#list,#list,1,false)
for i,v in ipairs(list)do
local item=self.ListFilter:getGridObjectByindex(i-1)
item:SetChildText(filterItemCmp.name,worldSceneMapModel:getItemName(v))
item:SetChildIcon(filterItemCmp.icon,worldSceneMapModel:getItemIcon(v),true)

item:SetChildActive(filterItemCmp.off,not _filter_selecteds[v])
end
end


function UIWorldSceneWin.onInitListFilterType(index)
local item=_this.ListFilterType:getChildLayoutGroupGridItem(index-1)
local info=_categories_order[index]
item:SetChildButtonClickWithID(filterTypeCmp.button,_this.onClickFilterType,index)
item:SetChildText(filterTypeCmp.name,info[1])
end


function UIWorldSceneWin:selectFilterType(index,selected)
local item=_this.ListFilterType:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(filterTypeCmp.selected,selected)
if selected then
_categories_selecteds=index
worldSceneMapModel:setCategorieData(_categories_selecteds)
self:refreshFilterList()
self.TextFilterType:setText(_categories_order[index][1])
end
end


function UIWorldSceneWin:selectFilterItem(index,selected)
local list=self:getFilterList()
local type=list[index]
_filter_selecteds[type]=selected
worldSceneMapModel:setFilterData(type,selected)

local item=_this.ListFilter:getGridObjectByindex(index-1)
item:SetChildActive(filterItemCmp.off,not selected)


for i,v in ipairs(self.list)do
if v[1]==type then
local item=self.winlua:GetChildLayoutGroupGridItem(self.Mask:getID(),i-1)
item:SetChildActive(mapItemCmp.owner,selected)
end
end
end


function UIWorldSceneWin.onClickFilterType(index)

if _categories_selecteds then
_this:selectFilterType(_categories_selecteds,false)
end
_categories_selecteds=index
worldSceneMapModel:setCategorieData(_categories_selecteds)
_this:selectFilterType(_categories_selecteds,true)
end


function UIWorldSceneWin.onClickFilterItem(id,index,guid,attach)

local list=_this:getFilterList()
local type=list[index]
_this:selectFilterItem(index,not _filter_selecteds[type])
_this.FilterAllOn:setActive(_this:checkAllOn())
end


function UIWorldSceneWin.onClickIcon(index)
if not worldMapController:isMapModel()then return end

local data=_this.list[index]
local unitKey=data[4]
if _this.world==worldMapController:getEnterScene()then
worldController:breakOverTopLookAtCamera_Unit(unitKey)
worldController:setCameraState(eWorldCameraState.Normal)
worldMapController:exitMapModel()
else
if worldController:enterWorld(_this.world,{lookAtUnit=unitKey})then
worldMapController:exitMapModel()
end
end
end


function UIWorldSceneWin:onButtonZM()
self:closeSelf()
worldController:exitWorld()
end


function UIWorldSceneWin:onButtonBack()
if not worldMapController:isMapModel()then return end
worldController:breakOverTopBackEnter(self.worldCfg.cameraPos[2])
worldController:setCameraState(eWorldCameraState.Normal)
end


function UIWorldSceneWin:onButtonWorld()

worldController.onCameraZoomMax()
end


function UIWorldSceneWin:onButtonFilter()
self:showFilter(not _shows[1])
end


function UIWorldSceneWin:onButtonFilterType()
self:showFilterCategory(not _shows[2])
end


function UIWorldSceneWin:onPanelFilterType()
self:showFilterCategory(false)
end


function UIWorldSceneWin:onButtonFilterAll()
local check=self:checkAllOn()
local temp={}
local list=self:getFilterList(1)
if not check then
for i,v in ipairs(list)do
temp[v]=true
end
end
_filter_selecteds=temp

worldSceneMapModel:setFilterAllData(_filter_selecteds)

for i,v in ipairs(self:getFilterList())do
self:selectFilterItem(i,not check)
end
self.FilterAllOn:setActive(not check)
end

function UIWorldSceneWin:resetMapMask(offset,mapSize,worldSize,resSize,worldPos)
local maskInfo=self.mapCfg.maskParams
local clouds=worldBlockModel:getMasks(self.world)
local cloudParam=worldSceneMapModel:getMaskUVRect(self.world,offset,resSize,mapSize)
self.winlua:SetChildCSImageMatTextureEx(self.Map:getID(),"_ControlTex",maskInfo,clouds)
self.winlua:SetChildCSImageMatVector(self.Map:getID(),"_CtrOffset",cloudParam)
self.Map:setActive(false)
self.Map:setActive(true)

self.list=worldSceneMapModel:getSceneMapUnitList(self.world)
local list=self.Mask:getChildLayoutGroupGridList()
for i=1,list.Count do
local item=list[i-1]
local data=self.list[i]
local x=data[2]
local y=data[3]
local anchoredPos=worldSceneMapModel:changePosition(x,y,_this.world,offset,mapSize,worldSize,worldPos)
item:SetChildAnchoredPosition(mapItemCmp.owner,anchoredPos)
end
end
