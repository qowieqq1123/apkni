







def_class("UIShiLianTaTaskWin",UIWindowBase)









function UIShiLianTaTaskWin:bindComponents()

self.title=UIText.get(self,0)
self.taskList=UILoopListView.new(self,1)

self.taskList:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIShiLianTaTaskWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title);self.title=nil;
self.taskList:deleteSelf();self.taskList=nil;
end


















local ItemCmpIndex=
{
icon=0,
iconBg=1,
name=2,
noname=3,
task=4,
got=5,
button=6,
btnText=7,
item=8,
getbg=9,
iconBg2=10,
itemMask=11,
qualityIcon=12,
itemIcon=13,
reddot=14,
noempty=15,
noneIcon=16,
}

local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemBgStageIdx=2,
cmpItemTxtCountIdx=3,
cmpItemTxtStage=4,
}

local taskConfigList={}



function UIShiLianTaTaskWin:onLoaded(...)
self:bindComponents()
taskConfigList={}
local taskCfg=cfg_traintowerrankrewardconfig()
local topLayer=cfgHelper.get2(cfg_traintowerglobalconfig_get,1,'topLayer')
for k,v in pairs(taskCfg)do
if v.id<=topLayer then
table.insert(taskConfigList,v)
end

end
table.sort(taskConfigList,function(a,b)return a.id<b.id end)
shiLianTaController.req_13_6()
end


function UIShiLianTaTaskWin:__delete()
self:unbindComponents()
self.openIdx=nil
end




function UIShiLianTaTaskWin:onShow(argtable,afterOnloaded)

if self.openIdx then

self.taskList:jumpItem(self.openIdx-1 or 1)
end
end


function UIShiLianTaTaskWin:onHide()

end

function UIShiLianTaTaskWin:refreshFirstClearList()
local _slotName='item'
self.taskList:initData(_slotName,taskConfigList)
self:setTaskListjumpTop()
end

function UIShiLianTaTaskWin:setTaskListjumpTop()
local gotList=shiLianTaModel:getFirstClearRewardLayerFlagList()
local layerList=shiLianTaModel:getFirstClearRewardLayerList()
local layerInfo
local index=nil
for i,v in ipairs(taskConfigList)do
layerInfo=layerList[v.id]
if layerInfo then
if not gotList[v.id]then
if index==nil then
index=i
break
end
end
else
if index==nil then
index=i
break
end
end
end
self.taskList:jumpItem(index or 1)
end

function UIShiLianTaTaskWin:refreshFirstClearItem(layer)
self.taskList:refreshAllItems()

self:setTaskListjumpTop()
end

function UIShiLianTaTaskWin:onClickItemCallback()

shiLianTaController.req_13_7()
end

function UIShiLianTaTaskWin:fillItem(grid,itemid,count,itemConfig,layer)
if not grid then
return
end
grid:SetBaseItemClickEvent(ItemCmpIndex.item,function(id,index,guid,attach)self:onItemClick(id,index,guid,attach,layer)end)
local prop={}
local color=itemConfig.color
prop[PropIndex(DataPropKey.eWidgetQuality,_itemWidgetIdx.cmpItemQualityIdx)]=color
prop[PropIndex(DataPropKey.eWidgetIcon,_itemWidgetIdx.cmpItemIconIdx)]=iconHelper.getIconName(itemid)
prop[PropIndex(DataPropKey.eWidgetActive,_itemWidgetIdx.cmpItemBgStageIdx)]=itemConfig.stage~=nil
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtCountIdx)]=count
prop[PropIndex(DataPropKey.eWidgetText,_itemWidgetIdx.cmpItemTxtStage)]=itemConfig.stage and FMT.fmt('{0}阶',itemConfig.stage)or''
prop[DataPropKey.eItemID]=itemid
prop[DataPropKey.eItemSeries]=-1
grid:SetChildPropData(ItemCmpIndex.item,prop)
end

function UIShiLianTaTaskWin:onFreshAction(i,grid)
local cfg,rewardId,itemList,itemData,layerInfo

local gotList=shiLianTaModel:getFirstClearRewardLayerFlagList()
local layerList=shiLianTaModel:getFirstClearRewardLayerList()
cfg=taskConfigList[i]

grid:SetChildText(ItemCmpIndex.task,FMT.fmt("本服任意祖师通关{0}层",cfg.id))


rewardId=cfg.rewardId
itemList=cfgHelper.get2(cfg_awardconfig_get,rewardId,"staticItems")
itemData=itemList[1]
if grid and itemData then
local itemConfig=itemsConfig.getConfig(itemData[1])
self:fillItem(grid,itemData[1],itemData[2],itemConfig,cfg.id)
end

layerInfo=layerList[cfg.id]
if layerInfo then
if gotList[cfg.id]then

grid:SetChildActive(ItemCmpIndex.getbg,false)
grid:SetChildActive(ItemCmpIndex.reddot,false)
grid:SetChildGray(ItemCmpIndex.qualityIcon,true)
grid:SetChildGray(ItemCmpIndex.itemIcon,true)
grid:SetChildActive(ItemCmpIndex.got,true)
else



grid:SetChildGray(ItemCmpIndex.qualityIcon,false)
grid:SetChildGray(ItemCmpIndex.itemIcon,false)
grid:SetChildActive(ItemCmpIndex.getbg,true)
grid:SetChildActive(ItemCmpIndex.reddot,true)
grid:SetChildActive(ItemCmpIndex.got,false)
end
grid:SetChildActive(ItemCmpIndex.iconBg2,false)

playerController:setHeadIcon(grid,ItemCmpIndex.icon,{scale=0.85,iconInfo=layerInfo.iconInfo})
grid:SetChildActive(ItemCmpIndex.noempty,true)
grid:SetChildActive(ItemCmpIndex.noname,false)
grid:SetChildText(ItemCmpIndex.name,playerModel:getOtherActorName(layerInfo.name))
grid:SetChildActive(ItemCmpIndex.noneIcon,false)
if layerInfo.name and layerInfo.name==''then
grid:SetChildActive(ItemCmpIndex.iconBg,false)
grid:SetChildActive(ItemCmpIndex.noneIcon,true)
end

else




grid:SetChildActive(ItemCmpIndex.iconBg2,false)
grid:SetChildActive(ItemCmpIndex.getbg,false)
grid:SetChildActive(ItemCmpIndex.reddot,false)
grid:SetChildActive(ItemCmpIndex.noname,true)
grid:SetChildActive(ItemCmpIndex.noempty,false)
grid:SetChildActive(ItemCmpIndex.got,false)
grid:SetChildGray(ItemCmpIndex.qualityIcon,false)
grid:SetChildGray(ItemCmpIndex.itemIcon,false)
end
end
function UIShiLianTaTaskWin:onStartAction()

end

function UIShiLianTaTaskWin:onItemClick(id,index,guid,attach,layer)
local layerList=shiLianTaModel:getFirstClearRewardLayerList()
local isClear=layerList[layer]
local isgot=shiLianTaModel:getFirstClearRewardLayerFlag(layer)
if isClear and not isgot then
self:onClickItemCallback()
else
itemsComponentHelper.onItemClick(id,index,guid,attach)
end
end


