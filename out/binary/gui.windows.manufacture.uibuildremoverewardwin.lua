







def_class("UIBuildRemoveRewardWin",UIWindowBase)









function UIBuildRemoveRewardWin:bindComponents()

self.activeText=UIText.get(self,0)
self.CancelBtn=UIButton.get(self,1)
self.Content=UIObject.get(self,2)
self.ContinueBtn=UIButton.get(self,3)
self.desc=UIText.get(self,4)
self.gou=UIObject.get(self,5)
self.ScrollView=UIObject.get(self,6)
self.YueKaButton=UIButton.get(self,7)

self.CancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.ContinueBtn:setButtonClick(function()self:onContinueBtn()end)

self.YueKaButton:setButtonClick(function()self:onYueKaButton()end)



end


function UIBuildRemoveRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.activeText);self.activeText=nil;
_UIObject_release(self.CancelBtn);self.CancelBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.ContinueBtn);self.ContinueBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.gou);self.gou=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.YueKaButton);self.YueKaButton=nil;
end
















local _continueBtnCd=3




function UIBuildRemoveRewardWin:onLoaded(...)
self:bindComponents()

local _building_event=function(...)



self:building_event(...)
end
self:addNotify(notifyConfig.building_event,_building_event)

self.clickContinueStamp=0
end


function UIBuildRemoveRewardWin:__delete()
self:unbindComponents()
end




function UIBuildRemoveRewardWin:onShow(argtable,afterOnloaded)
self.bdData=argtable.bdData
self.sfId=argtable.sfId

self.cfg=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)

local langkey=FMT.fmt("build_remove_return_desc_{0}",self.bdData.build_id)
local lang=cfgHelper.getlang(langkey)
if lang==nil then
lang="拆除建筑返还{0}%建造和升级的材料"
end
self.desc:setText(FMT.fmt(lang,self.cfg.destoy_return))

local cost={}
local tempCost={}
local levelCfgs=cfgHelper.get1(cfg_monijybuilduplvlconfig_get,self.bdData.build_id)

local levelCfg,sCostItemId,sCostItemNum,itemNum
for index=1,self.bdData.level do
levelCfg=levelCfgs[index]
for _,sCost in ipairs(levelCfg.uplevel_cost)do
sCostItemId=sCost[1]
sCostItemNum=sCost[2]
itemNum=tempCost[sCostItemId]or 0
tempCost[sCostItemId]=itemNum+sCostItemNum
end
end

local calculeNum
for itemId,itemNum in pairs(tempCost)do
calculeNum=mathHelper.safe_floor(itemNum*self.cfg.destoy_return/100)
cost[#cost+1]={itemId,calculeNum}
end

table.sort(cost,function(a,b)
return a[1]>b[1]
end)

local propData={}
local itemId,itemNum
for i,v in ipairs(cost)do
itemId=v[1]
itemNum=v[2]
table.insert(propData,itemsComponentHelper.getCommonFillData({itemid=itemId,itemcount=itemNum},{showname=false,showcount=itemNum>1,showCountBG=itemNum>1,showStageBg=true}))
end

local propDataCnt=#propData
if propDataCnt>0 then
self.gridAnim=true
end
self.propData=propData

self.ScrollView:setChildScrollViewDelayCreateGrids(propDataCnt,12,0.1,1,false,false,function(id,item)
if id+1>=propDataCnt then
self.gridAnim=nil
end
self:refreshItem(id,item,propData)
end)
end


function UIBuildRemoveRewardWin:onHide()

end

function UIBuildRemoveRewardWin:refreshItem(id,item,propData)
item:SetChildPropData(0,propData[id+1])
item:SetChildCanvasGroupDOFade(1,1,0.1)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end

function UIBuildRemoveRewardWin:building_event(eventType,id,bdId)
if eventType==buildingEvent.removeBuilding and bdId==self.bdData.un_build_id then
self:onCloseButton()
end
end





function UIBuildRemoveRewardWin:onCancelBtn()
self:onCloseButton()
end



function UIBuildRemoveRewardWin:onContinueBtn()
local curTime=timeHelper.getServerShortTime()
if curTime-self.clickContinueStamp<_continueBtnCd then
UIManager.error("拆除中")
return
end

local func=function()
self.clickContinueStamp=curTime
zongmenControl:reqDeleteBuilding(self.sfId,self.bdData.un_build_id)
end


local isShowNoEnoughDialouge=self:checkDestoryBuildDiscipleHomeLess()
if isShowNoEnoughDialouge then
local show_data={
type='UIDialouge',
title='提示',
content='弟子将无居所，祖师万万不可拆啊！',
oktext='确定',
showclosebtn=true,
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
local isBuildDestoryVis=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMutipleRoomBuildDestory)
if isBuildDestoryVis~=true then
local content=FMT.fmt("是否拆除<color=#ca631d>{0}级{1}</color>{2}",self.bdData.level,self.bdData.name,self.cfg.name)
local choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eMutipleRoomBuildDestory,flag)
end
local show_data={
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=func,
choosetext="今日不再提示",
choosecallback=choosecallback
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
func()
end
end

end



function UIBuildRemoveRewardWin:onYueKaButton()
end

function UIBuildRemoveRewardWin:onCloseButton()
self:closeSelf()
end



function UIBuildRemoveRewardWin:getRoomBuildDiscipleNum(bdData)
local num=0

local grids=bdData.caveGeziList or{}

for index,grid in ipairs(grids)do
if mathHelper.validInt64(grid.dizi_id)then
num=num+1
end
end

return num
end

function UIBuildRemoveRewardWin:checkDestoryBuildDiscipleHomeLess()
local bdDataList=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eDuoRen)

local num=self:getRoomBuildDiscipleNum(self.bdData)

local emptyRoomNum=0

local buildDiscipleNum,totalRoomNum
for index,bdData in ipairs(bdDataList)do
buildDiscipleNum=self:getRoomBuildDiscipleNum(bdData)
totalRoomNum=#bdData.caveGeziList
emptyRoomNum=emptyRoomNum+(totalRoomNum-buildDiscipleNum)

if emptyRoomNum>=num then
return false
end
end

return true
end
