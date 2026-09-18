







def_class("UIYFLTMapWin",UIWindowBase)









function UIYFLTMapWin:bindComponents()

self.AntiClockWiseBtn=UIButton.get(self,0)
self.blockMask=UIButton.get(self,1)
self.BtnList=UIObject.get(self,2)
self.ClockWiseBtn=UIButton.get(self,3)
self.dec_1=UIObject.get(self,4)
self.dec_10=UIObject.get(self,5)
self.dec_2=UIObject.get(self,6)
self.dec_3=UIObject.get(self,7)
self.dec_4=UIObject.get(self,8)
self.dec_5=UIObject.get(self,9)
self.dec_6=UIObject.get(self,10)
self.dec_7=UIObject.get(self,11)
self.dec_8=UIObject.get(self,12)
self.dec_9=UIObject.get(self,13)
self.dzEmpty=UIObject.get(self,14)
self.ExitBtn=UIButton.get(self,15)
self.gridItem_1=UIObject.get(self,16)
self.gridItem_10=UIObject.get(self,17)
self.gridItem_11=UIObject.get(self,18)
self.gridItem_12=UIObject.get(self,19)
self.gridItem_13=UIObject.get(self,20)
self.gridItem_14=UIObject.get(self,21)
self.gridItem_15=UIObject.get(self,22)
self.gridItem_16=UIObject.get(self,23)
self.gridItem_17=UIObject.get(self,24)
self.gridItem_18=UIObject.get(self,25)
self.gridItem_19=UIObject.get(self,26)
self.gridItem_2=UIObject.get(self,27)
self.gridItem_20=UIObject.get(self,28)
self.gridItem_21=UIObject.get(self,29)
self.gridItem_22=UIObject.get(self,30)
self.gridItem_23=UIObject.get(self,31)
self.gridItem_24=UIObject.get(self,32)
self.gridItem_25=UIObject.get(self,33)
self.gridItem_26=UIObject.get(self,34)
self.gridItem_27=UIObject.get(self,35)
self.gridItem_28=UIObject.get(self,36)
self.gridItem_29=UIObject.get(self,37)
self.gridItem_3=UIObject.get(self,38)
self.gridItem_30=UIObject.get(self,39)
self.gridItem_31=UIObject.get(self,40)
self.gridItem_32=UIObject.get(self,41)
self.gridItem_33=UIObject.get(self,42)
self.gridItem_34=UIObject.get(self,43)
self.gridItem_35=UIObject.get(self,44)
self.gridItem_36=UIObject.get(self,45)
self.gridItem_4=UIObject.get(self,46)
self.gridItem_5=UIObject.get(self,47)
self.gridItem_6=UIObject.get(self,48)
self.gridItem_7=UIObject.get(self,49)
self.gridItem_8=UIObject.get(self,50)
self.gridItem_9=UIObject.get(self,51)
self.longTouchBtn=UIButton.get(self,52)
self.longTouchMask=UIObject.get(self,53)
self.mapContent=UIButton.get(self,54)
self.misMatchedItem_1=UIObject.get(self,55)
self.misMatchedItem_2=UIObject.get(self,56)
self.misMatchedItem_3=UIObject.get(self,57)
self.misMatchedItem_4=UIObject.get(self,58)
self.misMatchedItem_5=UIObject.get(self,59)
self.misMatchedItem_6=UIObject.get(self,60)
self.plantTipsRoot=UIObject.get(self,61)
self.root=UIObject.get(self,62)
self.SeedingBtn=UIButton.get(self,63)
self.unlockModel=UIObject.get(self,64)
self.unlockTips=UIText.get(self,65)
self.unlockTipsRoot=UIObject.get(self,66)

self.AntiClockWiseBtn:setButtonClick(function()self:onAntiClockWiseBtn()end)

self.blockMask:setButtonClick(function()self:onBlockMask()end)

self.ClockWiseBtn:setButtonClick(function()self:onClockWiseBtn()end)

self.ExitBtn:setButtonClick(function()self:onExitBtn()end)

self.longTouchBtn:setButtonClick(function()self:onLongTouchBtn()end)

self.mapContent:setButtonClick(function()self:onMapContent()end)

self.SeedingBtn:setButtonClick(function()self:onSeedingBtn()end)
self.dec={
self.dec_1,
self.dec_2,
self.dec_3,
self.dec_4,
self.dec_5,
self.dec_6,
self.dec_7,
self.dec_8,
self.dec_9,
self.dec_10,
}
self.gridItem={
self.gridItem_1,
self.gridItem_2,
self.gridItem_3,
self.gridItem_4,
self.gridItem_5,
self.gridItem_6,
self.gridItem_7,
self.gridItem_8,
self.gridItem_9,
self.gridItem_10,
self.gridItem_11,
self.gridItem_12,
self.gridItem_13,
self.gridItem_14,
self.gridItem_15,
self.gridItem_16,
self.gridItem_17,
self.gridItem_18,
self.gridItem_19,
self.gridItem_20,
self.gridItem_21,
self.gridItem_22,
self.gridItem_23,
self.gridItem_24,
self.gridItem_25,
self.gridItem_26,
self.gridItem_27,
self.gridItem_28,
self.gridItem_29,
self.gridItem_30,
self.gridItem_31,
self.gridItem_32,
self.gridItem_33,
self.gridItem_34,
self.gridItem_35,
self.gridItem_36,
}
self.misMatchedItem={
self.misMatchedItem_1,
self.misMatchedItem_2,
self.misMatchedItem_3,
self.misMatchedItem_4,
self.misMatchedItem_5,
self.misMatchedItem_6,
}



end


function UIYFLTMapWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.AntiClockWiseBtn);self.AntiClockWiseBtn=nil;
_UIObject_release(self.blockMask);self.blockMask=nil;
_UIObject_release(self.BtnList);self.BtnList=nil;
_UIObject_release(self.ClockWiseBtn);self.ClockWiseBtn=nil;
_UIObject_release(self.dec_1);self.dec_1=nil;
_UIObject_release(self.dec_10);self.dec_10=nil;
_UIObject_release(self.dec_2);self.dec_2=nil;
_UIObject_release(self.dec_3);self.dec_3=nil;
_UIObject_release(self.dec_4);self.dec_4=nil;
_UIObject_release(self.dec_5);self.dec_5=nil;
_UIObject_release(self.dec_6);self.dec_6=nil;
_UIObject_release(self.dec_7);self.dec_7=nil;
_UIObject_release(self.dec_8);self.dec_8=nil;
_UIObject_release(self.dec_9);self.dec_9=nil;
_UIObject_release(self.dzEmpty);self.dzEmpty=nil;
_UIObject_release(self.ExitBtn);self.ExitBtn=nil;
_UIObject_release(self.gridItem_1);self.gridItem_1=nil;
_UIObject_release(self.gridItem_10);self.gridItem_10=nil;
_UIObject_release(self.gridItem_11);self.gridItem_11=nil;
_UIObject_release(self.gridItem_12);self.gridItem_12=nil;
_UIObject_release(self.gridItem_13);self.gridItem_13=nil;
_UIObject_release(self.gridItem_14);self.gridItem_14=nil;
_UIObject_release(self.gridItem_15);self.gridItem_15=nil;
_UIObject_release(self.gridItem_16);self.gridItem_16=nil;
_UIObject_release(self.gridItem_17);self.gridItem_17=nil;
_UIObject_release(self.gridItem_18);self.gridItem_18=nil;
_UIObject_release(self.gridItem_19);self.gridItem_19=nil;
_UIObject_release(self.gridItem_2);self.gridItem_2=nil;
_UIObject_release(self.gridItem_20);self.gridItem_20=nil;
_UIObject_release(self.gridItem_21);self.gridItem_21=nil;
_UIObject_release(self.gridItem_22);self.gridItem_22=nil;
_UIObject_release(self.gridItem_23);self.gridItem_23=nil;
_UIObject_release(self.gridItem_24);self.gridItem_24=nil;
_UIObject_release(self.gridItem_25);self.gridItem_25=nil;
_UIObject_release(self.gridItem_26);self.gridItem_26=nil;
_UIObject_release(self.gridItem_27);self.gridItem_27=nil;
_UIObject_release(self.gridItem_28);self.gridItem_28=nil;
_UIObject_release(self.gridItem_29);self.gridItem_29=nil;
_UIObject_release(self.gridItem_3);self.gridItem_3=nil;
_UIObject_release(self.gridItem_30);self.gridItem_30=nil;
_UIObject_release(self.gridItem_31);self.gridItem_31=nil;
_UIObject_release(self.gridItem_32);self.gridItem_32=nil;
_UIObject_release(self.gridItem_33);self.gridItem_33=nil;
_UIObject_release(self.gridItem_34);self.gridItem_34=nil;
_UIObject_release(self.gridItem_35);self.gridItem_35=nil;
_UIObject_release(self.gridItem_36);self.gridItem_36=nil;
_UIObject_release(self.gridItem_4);self.gridItem_4=nil;
_UIObject_release(self.gridItem_5);self.gridItem_5=nil;
_UIObject_release(self.gridItem_6);self.gridItem_6=nil;
_UIObject_release(self.gridItem_7);self.gridItem_7=nil;
_UIObject_release(self.gridItem_8);self.gridItem_8=nil;
_UIObject_release(self.gridItem_9);self.gridItem_9=nil;
_UIObject_release(self.longTouchBtn);self.longTouchBtn=nil;
_UIObject_release(self.longTouchMask);self.longTouchMask=nil;
_UIObject_release(self.mapContent);self.mapContent=nil;
_UIObject_release(self.misMatchedItem_1);self.misMatchedItem_1=nil;
_UIObject_release(self.misMatchedItem_2);self.misMatchedItem_2=nil;
_UIObject_release(self.misMatchedItem_3);self.misMatchedItem_3=nil;
_UIObject_release(self.misMatchedItem_4);self.misMatchedItem_4=nil;
_UIObject_release(self.misMatchedItem_5);self.misMatchedItem_5=nil;
_UIObject_release(self.misMatchedItem_6);self.misMatchedItem_6=nil;
_UIObject_release(self.plantTipsRoot);self.plantTipsRoot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.SeedingBtn);self.SeedingBtn=nil;
_UIObject_release(self.unlockModel);self.unlockModel=nil;
_UIObject_release(self.unlockTips);self.unlockTips=nil;
_UIObject_release(self.unlockTipsRoot);self.unlockTipsRoot=nil;
self.dec=nil;
self.gridItem=nil;
self.misMatchedItem=nil;
end
















local gridCmp={
base=0,
lock=1,
matched=2,
combined=3,
plant=4,
misMatched=5,
preview=6,
hud=7,
btn=8,
years=9,
icon=10,
reddot=11,
unlock=12,
effect=13,
}
local sceneMode={
eNormal=1,
ePlant=2,
}
local shapeIconAB="ui/windows/yifanglingtian/yifanglingtianmap_atlas_pak.ab"
local plantIconAB="ui/windows/yifanglingtian/yifanglingtianplant_atlas_pak.ab"
local spriteIconAB="ui/windows/yifanglingtian/yifanglingtian_atlas_pak.ab"
local _this
local maskWins={
['UIYFLTMapWin']=true,
['UIYiFangLingTianMain']=true,
['UIYFLTSelectPlantMain']=true,
}
local effectList=nil
local offsetXStep,offsetYStep={147,-76},{144,74}



function UIYFLTMapWin:onLoaded(...)
self:bindComponents()
_this=self
self.is_enableDrag=true
self.winLookup={}
if deviceHelper.getAPILevel()>=12 then
local s_func=function(pos)
if _this==nil then return end
_this.lockClick=true
end
local e_func=function(pos)
if _this==nil then return end
_this.lockClick=false
end
self.root:setChildDragStartAndEndEvent(s_func,e_func)
end

local sc=UIManager.defaultCanvas_trans.localScale
local screenWidth=UnityEngine.Screen.width/sc.x
local screenHeight=UnityEngine.Screen.height/sc.y
local mapWidth=self.mapContent:getChildRectWidth()
local mapHeight=self.mapContent:getChildRectHeight()
local minWidthScale=screenWidth/mapWidth
local minHeighScale=screenHeight/mapHeight
local minScale=math.max(minWidthScale,minHeighScale,0.7)
self.mapContent:setScale(Vector3(minScale,minScale,minScale))

local _onDragBegin=function(index,pos)
self:onDragBegin(index,pos)
end
local _onDragUpdate=function(index,pos,deltaTime)
self:onDragUpdate(index,pos)
end
local _onDragEnd=function(index,pos)
self:onDragEnd(index,pos)
end
for i,v in ipairs(self.gridItem)do
local grid=self.winlua:GetChildWidgetBase(v:getID())
grid:SetChildUIDragEvent(gridCmp.btn,i,_onDragBegin,_onDragEnd,_onDragUpdate)
end

local _onLongPressPlantBtn=function(id)
if not _this then return end
_this:onLongPressPlantBtn()
end
self.longTouchBtn:setChildLongPress(1,_onLongPressPlantBtn,nil)

self:addNotify(notifyConfig.showUI,self.showUI)
self:addNotify(notifyConfig.closeUI,self.closeUI)
self:addNotify(notifyConfig.inNewbie,self.setEnableDrag)
self:addNotify(notifyConfig.building_event,self.on_building_event)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)

effectList={}
end

function UIYFLTMapWin:onLongPressPlantBtn(id)



if not self.selectPlantGridItemId then
return
end
if YiFangLingTianController:checkGridMatched(self.selectPlantGridIdx,self.selectPlantGridItemId,self.selectPlantGridDir)then
local x,y=YiFangLingTianController:idxToXY(self.selectPlantGridIdx)
YiFangLingTianController:req_3_81(self.selectPlantGridItemId,self.selectPlantGridDir,x,y)
else
UIManager.error("当前位置不可种植")
end
end


function UIYFLTMapWin:__delete()
self:unbindComponents()
uiAIManager:clearUIWinData('UIYFLTMapWin')
self.currDZ=nil
self:stopAllTimer()
effectList=nil
end




function UIYFLTMapWin:onShow(argtable,afterOnloaded)

UIManager:showWindow("UIYFLTSelectPlantMain",argtable)
self.args=argtable
self.mode=sceneMode.eNormal
self.lockClick=false
self.isDraging=false


self:refreshUnlockTips()

self.showTypeSetting=YiFangLingTianModel:Get_Setting()
self:initGridView()
if afterOnloaded then
self:enableDrag(true)
self.dec_1:setChildUIModelShowTarget(5482,1,{},eAnimationID.stand)
self.dec_2:setChildUIModelShowTarget(5483,1,{},eAnimationID.stand)
self.dec_3:setChildUIModelShowTarget(5484,1,{},eAnimationID.stand)
self.dec_4:setChildUIModelShowTarget(5485,1,{},eAnimationID.stand)
self.dec_5:setChildUIModelShowTarget(5486,1,{},eAnimationID.stand)
self.dec_6:setChildUIModelShowTarget(5487,1,{},eAnimationID.stand)
self.dec_7:setChildUIModelShowTarget(5488,1,{},eAnimationID.stand)
self.dec_8:setChildUIModelShowTarget(5489,1,{},eAnimationID.stand)
self.dec_9:setChildUIModelShowTarget(5490,1,{},eAnimationID.stand)
self.dec_10:setChildUIModelShowTarget(5518,1,{},eAnimationID.stand)
end

local entityId=argtable.data.entityId
self.bdData=zongmenModel:findBuildingByEntityId(entityId)
self.dzId=self.bdData.dizi_id
self.dzStrId=tostring(self.bdData.dizi_id)
self:refreshDzModel()
end

function UIYFLTMapWin:refreshDzModel()
local dzId=self.dzId
uiAIManager:removeUIInstance(self.currDZ)
self.currDZ=nil
if mathHelper.validInt64(dzId)then
self:createDZ(dzId,{-21.4,-72},function(bt)
if self then
self.currDZ=bt
local dzWidget=self.currDZ:getSharedVar('dzWidget')
dzWidget:SetChildUIModelShowFlipX(0,true)
end
end)
end
end

function UIYFLTMapWin:test()
local gridItem=self.gridItem[16]:getChildWidgetBase()
local lPos=gridItem:GetChildUIScreenPos2Local(-1,gridItem:GetChildUIScreenPos(-1))
logErr("gridItem lpos",serializeHelper.serialize(gridItem:GetChildUIScreenPos(-1)))
end

function UIYFLTMapWin:onDragBegin(index,pos)

self.lockClick=true
if self.mode~=sceneMode.ePlant then
return
end
if self.selectPlantGridIdx~=index then
local dragIndex=self:convertPos2GridIdx(pos)
local itemid=self.selectPlantGridItemId
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,itemid)
local coordinate_conf=cfg.coordinate_conf[self.selectPlantGridDir]
local combinedDrag=false
for _,gridPos in ipairs(coordinate_conf)do
local x_coordinate,y_coordinate=unpack(gridPos)
local x_offest=x_coordinate-1
local y_offest=y_coordinate-1
local idx=self.selectPlantGridIdx+(x_offest*YiFangLingTianController.y_max)+y_offest
if idx==dragIndex then
combinedDrag=true
break
end
end
if not combinedDrag then
return
end
end

self.isDraging=true
self:enableDrag(false)



end

function UIYFLTMapWin:onDragEnd(index,pos)

self.lockClick=false
self.isDraging=false
self:enableDrag(true)



end

function UIYFLTMapWin:onDragUpdate(index,pos)
if not self.isDraging then
return
end


local dragIndex=self:convertPos2GridIdx(pos)
if dragIndex then
self:onClickGridItem(dragIndex)
end
end

function UIYFLTMapWin:convertPos2GridIdx(pos)
local width,height=230/2,130/2
for i,v in ipairs(self.gridItem)do
local grid=self.winlua:GetChildWidgetBase(v:getID())
local centerPos=grid:GetChildUIScreenPos(-1)
local dx=math.abs(pos.x-centerPos.x)
local dy=math.abs(pos.y-centerPos.y)
if((dx/width)+(dy/height))<=1 then

return i
end
end
end

function UIYFLTMapWin.on_building_event(etype,sfId,bdId,diziguid,olddiziguid)
if _this.bdData.un_build_id~=bdId then return end
if tostring(diziguid)=='0'then diziguid=0 end
if etype==buildingEvent.replaceDisciple then
_this.dzId=diziguid
_this.dzStrId='0'
_this:refreshDzModel()
end
end

function UIYFLTMapWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end











end


function UIYFLTMapWin:onHide()
self:enableDrag(false)
end

function UIYFLTMapWin:onLostConnection()
self:enableDrag(false)
end

function UIYFLTMapWin.showUI(name)
if _this==nil then return end
if maskWins[name]==nil then
local flag=next(_this.winLookup)==nil
_this.winLookup[name]=true
if flag then
_this:enableDrag(false)
end
end
end

function UIYFLTMapWin.closeUI(name)
if _this==nil then return end
if maskWins[name]==nil then
_this.winLookup[name]=nil
local flag=next(_this.winLookup)==nil
if flag then
_this:enableDrag(true)
end
end
end


function UIYFLTMapWin:initGridView()
for i,v in ipairs(self.gridItem)do
local gridItem=self.winlua:GetChildWidgetBase(v:getID())

gridItem:SetChildActive(gridCmp.plant,true)
gridItem:SetChildActive(gridCmp.misMatched,true)
gridItem:SetChildActive(gridCmp.lock,true)
gridItem:SetChildActive(gridCmp.unlock,true)
gridItem:SetChildActive(gridCmp.preview,true)
gridItem:SetChildActive(gridCmp.hud,true)

gridItem:SetChildCanvasEx(gridCmp.plant,nil,1001)
gridItem:SetChildCanvasEx(gridCmp.misMatched,nil,1002)
gridItem:SetChildCanvasEx(gridCmp.unlock,nil,1003)
gridItem:SetChildCanvasEx(gridCmp.preview,nil,1004)
gridItem:SetChildCanvasEx(gridCmp.hud,nil,1005)

gridItem:SetChildActive(gridCmp.base,false)
gridItem:SetChildActive(gridCmp.combined,false)
gridItem:SetChildActive(gridCmp.plant,false)
gridItem:SetChildActive(gridCmp.misMatched,false)
gridItem:SetChildActive(gridCmp.lock,false)
gridItem:SetChildActive(gridCmp.unlock,false)
gridItem:SetChildActive(gridCmp.preview,false)
gridItem:SetChildActive(gridCmp.hud,false)

self:refreshGrid(i)

gridItem:SetChildButtonClick(gridCmp.btn,function()
if _this then
_this:onClickGridItem(i)
end
end)
end
if self.growTimer then
self:stopTimerByID(self.growTimer)
end
self.growTimer=self:setTimer(6,0,function()
self:refreshGrowGrid()
end)
end


function UIYFLTMapWin:refreshGrowGrid()
local datas=YiFangLingTianModel:GetGridData()
for idx,_ in pairs(datas)do
self:refreshGrid(idx)
end
end


function UIYFLTMapWin:refreshGrid(idx)
local data=YiFangLingTianModel:GetSingleGridData(idx)
local gridItem=self.winlua:GetChildWidgetBase(self.gridItem[idx]:getID())
local itemid,pos_idx,combinedGridIdx
if data then
itemid=data.item_id
pos_idx=data.pos_idx
combinedGridIdx=data.combinedGridIdx
end

if itemid then
if itemid~=0 then
gridItem:SetChildActive(gridCmp.base,false)
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,itemid)
local beginTime=data.begintimes
local plantStage=YiFangLingTianModel:GetPlantGrowthStage(idx)
local shapeId=cfg.shape_conf[pos_idx]
local shape_conf=cfgHelper.get1(cfg_yifanglintianshapeconfig_get,shapeId)

gridItem:SetChildCSImageSprite(gridCmp.combined,shapeIconAB,shape_conf.shapeIcon)
gridItem:SetChildAnchoredPosition(gridCmp.combined,Vector2(shape_conf.offest[1],shape_conf.offest[2]))
gridItem:SetChildActive(gridCmp.combined,true)

gridItem:SetChildCSImageSprite(gridCmp.plant,plantIconAB,cfg.stageIcon[plantStage][1])
gridItem:SetChildActive(gridCmp.plant,true)

self:refreshGridHud(idx)

local showEffect=cfg.stageEffect[plantStage]
if not effectList[idx]or effectList[idx]~=showEffect then
effectList[idx]=showEffect
gridItem:SetChildShowEffect(gridCmp.effect,showEffect,true)
end
else
gridItem:SetChildActive(gridCmp.base,not combinedGridIdx)
if combinedGridIdx then
local data=YiFangLingTianModel:GetSingleGridData(combinedGridIdx)
itemid=data.item_id
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,itemid)
local plantStage=YiFangLingTianModel:GetPlantGrowthStage(combinedGridIdx)

gridItem:SetChildCSImageSprite(gridCmp.plant,plantIconAB,cfg.stageIcon[plantStage][1])
gridItem:SetChildActive(gridCmp.plant,true)

local showEffect=cfg.stageEffect[plantStage]
if not effectList[idx]or effectList[idx]~=showEffect then
effectList[idx]=showEffect
gridItem:SetChildShowEffect(gridCmp.effect,showEffect,true)
end
else
if effectList[idx]and effectList[idx]~=0 then
effectList[idx]=0
gridItem:SetChildShowEffect(gridCmp.effect,0,true)
end
end
end
else
gridItem:SetChildActive(gridCmp.lock,true)
local zmCondUnlock=YiFangLingTianController:checkGridUnlockCond(idx)
gridItem:SetChildActive(gridCmp.unlock,zmCondUnlock)
end
end


function UIYFLTMapWin:refreshGridHud(idx)
local data=YiFangLingTianModel:GetSingleGridData(idx)
if data then
local itemid=data.item_id
if itemid~=0 then
local gridItem=self.winlua:GetChildWidgetBase(self.gridItem[idx]:getID())
local plantStage,maxStage=YiFangLingTianModel:GetPlantGrowthStage(idx)
if self.mode==sceneMode.ePlant or(self.showTypeSetting==4 and plantStage<maxStage)then
gridItem:SetChildActive(gridCmp.hud,false)
return
end
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,itemid)
local beginTime=data.begintimes
local x,y=YiFangLingTianController:idxToXY(idx)
local exData=YiFangLingTianModel:GetSingeGezi(x,y)or{}

local growTime=exData.total_times or 0

gridItem:SetChildCSImageSprite(gridCmp.hud,spriteIconAB,cfg.stageIcon[plantStage][3])
gridItem:SetChildActive(gridCmp.hud,true)

gridItem:SetChildCSImageSprite(gridCmp.icon,plantIconAB,cfg.stageIcon[plantStage][2])

if plantStage<maxStage then
local showType=self.showTypeSetting
if showType==1 then
local years=math.max(gameUtilityModel.calculateGameYearFloor(growTime),0)
gridItem:SetChildText(gridCmp.years,string.format("%d年",years))
elseif showType==2 then
local group_conf=cfg.group_conf
local group_stage=0
for stage=#group_conf,1,-1 do
if growTime>=group_conf[stage][1]then
group_stage=stage
break
end
end
local leftTime=group_conf[group_stage+1][1]-growTime
local timeStr=self:format_time(leftTime)
gridItem:SetChildText(gridCmp.years,string.format("剩余:%s",timeStr))
elseif showType==3 then
local group_conf=cfg.group_conf
local leftTime=group_conf[#group_conf][1]-growTime
local timeStr=self:format_time(leftTime)
gridItem:SetChildText(gridCmp.years,string.format("剩余:%s",timeStr))
end
else
gridItem:SetChildText(gridCmp.years,"<color=#2DEC00>完全成熟</color>")
end

local reddot=plantStage>=maxStage
gridItem:SetChildActive(gridCmp.reddot,reddot)
end
end
end

function UIYFLTMapWin:format_time(time)
local day=86400
local hour=3600
local min=60
local str=nil
if time>=day then
local v1=math.floor(time/day)
local v2=time%day/hour
str=string.format('%d天',v1)
elseif time>=hour then
local v1=math.floor(time/hour)
local v2=time%hour/min
str=string.format('%d时',v1)
else
local v1=math.floor(time/min)
local v2=time-v1*60
str=string.format('%d分',v1)
end
return str
end


function UIYFLTMapWin:refreshSetting()
self.showTypeSetting=YiFangLingTianModel:Get_Setting()
for i=1,#self.gridItem do

self:refreshGridHud(i)
end
end



function UIYFLTMapWin:unlockGrid(geziList)
for i,v in ipairs(geziList)do
local x,y=v.param_1,v.param_2
local idx=YiFangLingTianController:xyToIdx(x,y)
local gridItem=self.winlua:GetChildWidgetBase(self.gridItem[idx]:getID())
gridItem:SetChildActive(gridCmp.base,true)
gridItem:SetChildActive(gridCmp.lock,false)
end
self:refreshUnlockTips()

self.unlockModel:setChildShowEffect(20416,true)
end


function UIYFLTMapWin:plantedGrid(idxList)
for _,idx in ipairs(idxList)do
self:refreshGrid(idx)
end
if self.mode==sceneMode.ePlant and self.selectPlantGridItemId then
self:preparePlanting(self.selectPlantGridItemId,true)
end
if not self.tipsTime or(timeHelper.getServerShortTime()-self.tipsTime)>0.3 then
self.tipsTime=timeHelper.getServerShortTime()
UIManager.info("播种成功")
end
end


function UIYFLTMapWin:cleanGrid(idxList)
for _,idx in ipairs(idxList)do
local gridItem=self.winlua:GetChildWidgetBase(self.gridItem[idx]:getID())
gridItem:SetChildActive(gridCmp.base,true)
gridItem:SetChildActive(gridCmp.plant,false)
gridItem:SetChildActive(gridCmp.hud,false)
gridItem:SetChildActive(gridCmp.combined,false)
gridItem:SetChildShowEffect(gridCmp.effect,0,false)
effectList[idx]=0
end
end


function UIYFLTMapWin:preparePlanting(itemid,againPlant,selectIdx)
local canPlant,idx,pos_idx=YiFangLingTianController:getTheBestGrid(itemid)
if againPlant then
local have=itemsModel.getCount(self.selectPlantGridItemId)
if have<=0 then
UIManager.info(string.format("已无%s可种植",itemsModel.getName(self.selectPlantGridItemId)))
self:exitPlanting()
return
elseif not canPlant then
UIManager.info(string.format("已无仙圃可种植%s",itemsModel.getName(self.selectPlantGridItemId)))
self:exitPlanting()
return
end
else
if self.mode==sceneMode.eNormal then

self.mode=sceneMode.ePlant
self:refreshSetting()
end
end
if self.selectPlantGridIdx and self.selectPlantGridItemId and self.selectPlantGridIdx==selectIdx and self.selectPlantGridItemId==itemid then
return
end
if self.selectPlantGridIdx then
self:refreshPlantingGrid(self.selectPlantGridIdx,true)
end
self.mode=sceneMode.ePlant
self.selectPlantGridItemId=itemid
self.selectPlantGridIdx=idx
if selectIdx then
self.selectPlantGridIdx=selectIdx
end
self.selectPlantGridDir=pos_idx
self:refreshPlantingGrid(self.selectPlantGridIdx)
self:refreshPlantingBtn()
if not selectIdx then
self:focusPlantingGrid()
end
end


function UIYFLTMapWin:exitPlanting()
if self.mode~=sceneMode.ePlant then
return
end
if self.selectPlantGridIdx then
self:refreshPlantingGrid(self.selectPlantGridIdx,true)
end
self.mode=sceneMode.eNormal
self.selectPlantGridItemId=nil
self.selectPlantGridIdx=nil
self.selectPlantGridDir=nil
self:refreshPlantingBtn()

self:refreshSetting()
self.longTouchBtn:setChildLongPressStop()
YiFangLingTianModel:exitPlantModel(self.args)
end


function UIYFLTMapWin:focusPlantingGrid()
if self.mode~=sceneMode.ePlant then
return
end
if self.selectPlantGridIdx then
local gridItem=self.gridItem[self.selectPlantGridIdx]:getChildWidgetBase()
local ScreenPos=gridItem:GetChildUIScreenPos(-1)
local sc=UIManager.defaultCanvas_trans.localScale
local ScreenPosX,ScreenPosY=ScreenPos.x/sc.x,ScreenPos.y/sc.y
local scale=self.mapContent:getScale()
local width=self.mapContent:getChildRectWidth()*scale.x
local height=self.mapContent:getChildRectHeight()*scale.y
local screenWidth=UnityEngine.Screen.width/sc.x
local screenHeight=UnityEngine.Screen.height/sc.y
local centerPosX,centerPosY=(screenWidth/2),(screenHeight/2)
local offsetX,offsetY=(centerPosX-ScreenPosX),(centerPosY-ScreenPosY)
local minX,minY=(width-screenWidth)/2,(height-screenHeight)/2

local mapPos=self.mapContent:getChildAnchoredPosition()
local resultX=mapPos.x+offsetX
local resultY=mapPos.y+offsetY
if math.abs(resultX)>minX then
if resultX<0 then
resultX=-minX
else
resultX=minX
end
end
if math.abs(resultY)>minY then
if resultY<0 then
resultY=-minY
else
resultY=minY
end
end
self.mapContent:setChildDOAnchorPos(Vector2(resultX,resultY),0.3)
end
end


function UIYFLTMapWin:refreshPlantingBtn()
if self.mode==sceneMode.eNormal then
self.BtnList:setActive(false)
self.plantTipsRoot:setActive(false)
self:refreshUnlockTips()
self.longTouchBtn:setActive(false)
self.longTouchMask:setActive(false)
elseif self.mode==sceneMode.ePlant then
self.BtnList:setActive(true)
local gridItem=self.winlua:GetChildWidgetBase(self.gridItem[self.selectPlantGridIdx]:getID())
local pos=gridItem:GetChildAnchoredPosition(-1)
self.BtnList:setChildAnchoredPosition(Vector2(pos.x,pos.y+125))
self.plantTipsRoot:setActive(true)
self.unlockTipsRoot:setActive(false)
self.longTouchBtn:setActive(true)
self.longTouchMask:setActive(true)
end
end


function UIYFLTMapWin:refreshPlantingGrid(idx,remove)
if self.mode==sceneMode.ePlant then
local itemid=self.selectPlantGridItemId
local cfg=cfgHelper.get1(cfg_yifanglintianconfig_get,itemid)
local coordinate_conf=cfg.coordinate_conf[self.selectPlantGridDir]
local x,y=YiFangLingTianController:idxToXY(idx)
local crossBorder={}
for _,gridPos in ipairs(coordinate_conf)do
local x_offest,y_offest=unpack(gridPos)
local x_grid=x+x_offest-1
local y_grid=y+y_offest-1
if x_grid<=0 or x_grid>YiFangLingTianController.x_max or y_grid<=0 or y_grid>YiFangLingTianController.y_max then
table.insert(crossBorder,{x=x_offest,y=y_offest})
else
local selectIdx=YiFangLingTianController:xyToIdx(x_grid,y_grid)
local gridItem=self.winlua:GetChildWidgetBase(self.gridItem[selectIdx]:getID())
if remove then
gridItem:SetChildActive(gridCmp.matched,false)
gridItem:SetChildActive(gridCmp.misMatched,false)
gridItem:SetChildCSImageIcon(gridCmp.preview,nil)
gridItem:SetChildActive(gridCmp.preview,false)
else
local gridState=YiFangLingTianController:getGridState(selectIdx)
gridItem:SetChildActive(gridCmp.matched,gridState==YFLTGridState.eUnPlanted)
gridItem:SetChildActive(gridCmp.misMatched,gridState~=YFLTGridState.eUnPlanted)

gridItem:SetChildCSImageSprite(gridCmp.preview,plantIconAB,cfg.stageIcon[1][1])
gridItem:SetChildActive(gridCmp.preview,true)
end
end
end
if#crossBorder>0 and not remove then
local gridItem=self.winlua:GetChildWidgetBase(self.gridItem[idx]:getID())
local pos=gridItem:GetChildAnchoredPosition(-1)
local oPosX,oPosY=pos.x,pos.y
for i,v in ipairs(self.misMatchedItem)do
local offset=crossBorder[i]
local misItem=self.winlua:GetChildWidgetBase(v:getID())
if offset then
misItem:SetChildActive(-1,true)

misItem:SetChildCSImageSprite(0,plantIconAB,cfg.stageIcon[1][1])
local x_offest,y_offest=offset.x-1,offset.y-1
local offsetXStep_X,offsetXStep_Y=x_offest*offsetXStep[1],x_offest*offsetXStep[2]
local offsetYStep_X,offsetYStep_Y=y_offest*offsetYStep[1],y_offest*offsetYStep[2]
misItem:SetChildAnchoredPosition(-1,Vector2(oPosX+offsetXStep_X+offsetYStep_X,oPosY+offsetXStep_Y+offsetYStep_Y))
else
misItem:SetChildActive(-1,false)
end
end
end
if remove then
for i,v in ipairs(self.misMatchedItem)do
local misItem=self.winlua:GetChildWidgetBase(v:getID())
misItem:SetChildActive(-1,false)
end
end
end
end


function UIYFLTMapWin:onClickGridItem(idx)
if self.lockClick and not self.isDraging then
return
end
if self.mode==sceneMode.eNormal then
local data=YiFangLingTianModel:GetSingleGridData(idx)
if data then
local itemid=data.item_id
local pos_idx=data.pos_idx
local combinedGridIdx=data.combinedGridIdx
if itemid~=0 then
if YiFangLingTianModel:CheckPlantHarvest(idx)then
return YiFangLingTianModel:HarvestMaturePlant()
end
local x,y=YiFangLingTianController:idxToXY(idx)
UIManager:showWindow("UIYFLTTipsWin",{x=x,y=y})
else
if not combinedGridIdx then
return UIManager.info("请祖师选择种子播种")
end
if YiFangLingTianModel:CheckPlantHarvest(combinedGridIdx)then
return YiFangLingTianModel:HarvestMaturePlant()
end
local x,y=YiFangLingTianController:idxToXY(combinedGridIdx)
UIManager:showWindow("UIYFLTTipsWin",{x=x,y=y})
end
else
local zmCondUnlock,zmCondLv=YiFangLingTianController:checkGridUnlockCond(idx)
local zmCondNum,costCondNum=YiFangLingTianController:getGridUnlockCondNum()
if zmCondUnlock then
local refresh=function(num)
local unlock_gezi_cost=cfgHelper.getdef1(cfg_yifanglintianconfig,"unlock_gezi_cost")
local unlock_gezi_itemid=cfgHelper.getdef1(cfg_yifanglintianconfig,"unlock_gezi_itemid")
local cost=0
local unlockNum=YiFangLingTianModel:GetUnlockGridNum()
for i=unlockNum+1,unlockNum+num do
cost=cost+unlock_gezi_cost[i]
end
local rewardMoneyIcon=iconHelper.getIconName(unlock_gezi_itemid)
local have=itemsModel.getCount(unlock_gezi_itemid)+itemsModel.getCount(eMoneyType.mtXianYu)
local color=have>=cost and"#ca631d"or"red"
local contentStr=FMT.fmt("开垦仙圃将花费quad-icon={0}-quad<color={2}>{1}</color>",rewardMoneyIcon,cost,color)
return contentStr
end
local show_data={
type='UIDialougeBuyCount',
title='提示',
refreshcallback=refresh,
max=zmCondNum,
moneytypes={{eMoneyType.mtXianYu},{eMoneyType.mtLingYu}},
tips=nil,
oktext='开垦',
canceltext='取消',
okcallback=function(num)
local unlock_gezi_cost=cfgHelper.getdef1(cfg_yifanglintianconfig,"unlock_gezi_cost")
local unlock_gezi_itemid=cfgHelper.getdef1(cfg_yifanglintianconfig,"unlock_gezi_itemid")
local cost=0
local unlockNum=YiFangLingTianModel:GetUnlockGridNum()
local have=itemsModel.getCount(unlock_gezi_itemid)
for i=unlockNum+1,unlockNum+num do
cost=cost+unlock_gezi_cost[i]
end

local geziList={}
local contain=false
local len=0
for unlockIdx=1,YiFangLingTianController.xy_max do
if not YiFangLingTianModel:GetSingleGridData(unlockIdx)and YiFangLingTianController:checkGridUnlockCond(unlockIdx)then
if unlockIdx==idx then
contain=true
end
local x,y=YiFangLingTianController:idxToXY(unlockIdx)
table.insert(geziList,{x,y})
len=len+1
if len>=num then
break
end
end
end
if not contain then
table.remove(geziList)
local x,y=YiFangLingTianController:idxToXY(idx)
table.insert(geziList,{x,y})
end
if have>=cost then
YiFangLingTianController:req_3_82(len,geziList)
else
local needXianYuCount=cost-have
local isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
if isEnough then
moneySystem:useMoney(unlock_gezi_itemid,cost,function()
YiFangLingTianController:req_3_82(len,geziList)
end)
else


gainControl:showGainWin(unlock_gezi_itemid)
end
end
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
UIManager.info(string.format("宗门%d级可开垦此仙圃",zmCondLv))
end
end
elseif self.mode==sceneMode.ePlant then
if self.selectPlantGridIdx==idx then
return
end






self:refreshPlantingGrid(self.selectPlantGridIdx,true)
self.selectPlantGridIdx=idx




self:refreshPlantingGrid(self.selectPlantGridIdx)
self:refreshPlantingBtn()
end
end

function UIYFLTMapWin:refreshUnlockTips()



self.unlockTipsRoot:setActive(false)
end

function UIYFLTMapWin:onExitBtn()
if self.lockClick then
return
end
self:exitPlanting()
end
function UIYFLTMapWin:onMapContent()
if self.lockClick then
return
end
self:exitPlanting()
end

function UIYFLTMapWin:onAntiClockWiseBtn()
if self.lockClick then
return
end
if self.mode==sceneMode.ePlant then
local dir=self.selectPlantGridDir
local canRotate=false
for i=1,3 do
dir=(dir+2)%4+1
local outBorder=false
if not outBorder then
self:refreshPlantingGrid(self.selectPlantGridIdx,true)
self.selectPlantGridDir=dir
self:refreshPlantingGrid(self.selectPlantGridIdx)
self:refreshPlantingBtn()
canRotate=true
break
end
end




end
end


function UIYFLTMapWin:onClockWiseBtn()
if self.lockClick then
return
end
if self.mode==sceneMode.ePlant then
local dir=self.selectPlantGridDir
local canRotate=false
for i=1,3 do
dir=(dir%4)+1
local outBorder=false
if not outBorder then
self:refreshPlantingGrid(self.selectPlantGridIdx,true)
self.selectPlantGridDir=dir
self:refreshPlantingGrid(self.selectPlantGridIdx)
self:refreshPlantingBtn()
canRotate=true
break
end
end




end
end

function UIYFLTMapWin:onSeedingBtn()
if self.lockClick then
return
end
if YiFangLingTianController:checkGridMatched(self.selectPlantGridIdx,self.selectPlantGridItemId,self.selectPlantGridDir)then
local x,y=YiFangLingTianController:idxToXY(self.selectPlantGridIdx)
YiFangLingTianController:req_3_81(self.selectPlantGridItemId,self.selectPlantGridDir,x,y)
else
UIManager.error("当前位置不可种植")
end
end

function UIYFLTMapWin:onLongTouchBtn()

end

function UIYFLTMapWin:enableDrag(flag)
if self.is_enableDrag~=flag then
self.is_enableDrag=flag
self.root:setChildDragZoomEnable(flag)
end
self.blockMask:setActive(not flag)
end

function UIYFLTMapWin:onBlockMask()
self:enableDrag(true)
end

function UIYFLTMapWin.setEnableDrag(id,flag)
if not _this then return end
if flag then
_this:enableDrag(false)
else
_this:enableDrag(true)
end
end

function UIYFLTMapWin:doNextStep(bt)
if self.dzStrId and self.dzStrId~='0'and UIDiscipleModel:checkDiscipleState2ByStr(self.dzStrId,DISCIPLE_STATE_TYPE.eChuiWei)then
bt:setSharedVar('animId',0)
bt:setSharedVar('animDuration',5)
bt:setSharedVar('canMove',0)
bt:setSharedVar('step',2)
bt:setSharedVar('waitTime',10)
return
end
local actionWeight=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,'actionWeight')
local waitTimes=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,'waitTime')
local waitTime=math.random(waitTimes[1],waitTimes[2])
local step=mathHelper.weightRandom(actionWeight)
if step==1 then
local dzTextLib=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,'dzTextLib')
local idx=math.random(#dzTextLib)
bt:setSharedVar('tKey',dzTextLib[idx][1])
bt:setSharedVar('speakDuration',dzTextLib[idx][2])
elseif step==2 then
local dzAnimLib=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,'dzAnimLib')
local idx=math.random(#dzAnimLib)
bt:setSharedVar('animId',dzAnimLib[idx][1])
bt:setSharedVar('animDuration',dzAnimLib[idx][2])

elseif step==3 then
local dzPosLib=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,'dzPosLib')
local idx=math.random(#dzPosLib)
self.posGroup=dzPosLib[idx]
self.posStep=0
bt:setSharedVar('repeatCount',#self.posGroup)

end

bt:setSharedVar('step',step)
bt:setSharedVar('waitTime',waitTime)
end

function UIYFLTMapWin:doNextMove(bt)
if self.dzStrId and self.dzStrId~='0'and UIDiscipleModel:checkDiscipleState2ByStr(self.dzStrId,DISCIPLE_STATE_TYPE.eChuiWei)then
bt:setSharedVar('animId',0)
bt:setSharedVar('animDuration',5)
bt:setSharedVar('canMove',0)
bt:setSharedVar('step',2)
bt:setSharedVar('waitTime',10)
return
end
self.posStep=self.posStep+1
if self.posStep>#self.posGroup then
bt:setSharedVar('canMove',0)
if self.posGroup.left then
local dzWidget=self.currDZ:getSharedVar('dzWidget')
dzWidget:SetChildUIModelShowFlipX(0,false)
elseif self.posGroup.right then
local dzWidget=self.currDZ:getSharedVar('dzWidget')
dzWidget:SetChildUIModelShowFlipX(0,true)
end
return
end
bt:setSharedVar('canMove',1)
bt:setSharedVar('movePos',self.posGroup[self.posStep])
end

function UIYFLTMapWin:createDZ(dzId,pos,callback)
local waitTimes=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,'waitTime')
local waitTime=math.random(waitTimes[1],waitTimes[2])
local initData={
speakDuration=3,
speakHUDParent=1,
offset={0,0},
movePos={0,0},
canMove=0,
tKey='',
waitTime=waitTime,
repeatCount=10,
step=2,
animId=0,
animDuration=3,
}
local tran=self.dzEmpty:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
local otherData={

}
uiAIManager:createUIDisciple('UIYFLTMapWin','bt_ui_yifanglingtian',dzId,tran,vpos,initData,otherData,function(bt)
callback(bt)
end)
end