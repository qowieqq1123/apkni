









local xjEntityHud_xmMove={}


function xjEntityHud_xmMove:onInit()
self.needFollow=true
local hudSet=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'hudSet_xmmove')
if hudSet.tagOffset then
self.tagOffset={}
local offset=hudSet.tagOffset[1]
self.tagOffset[1]=offset and mathHelper.convertArrayToVector(offset)or Vector3.zero
else
self.tagOffset={Vector3.zero}
end
if hudSet.uiOffset then
self.uiOffset={}
local offset=hudSet.uiOffset[1]
self.uiOffset[1]=offset and mathHelper.convertArrayToVector(offset)or Vector2(0,0)
else
self.uiOffset={Vector2(0,0)}
end

self.tagOffset={Vector3(0,0,2.5),}

local xmData=xianjieModel:getMyXianMengData()
self.inCurScene=xmData:checkInCurScene()
self.xm_gridX=xmData.gridX
self.xm_gridZ=xmData.gridZ
end

function xjEntityHud_xmMove:checkInRange(gridX,gridZ)
if self.inCurScene==true then
local data=self.data
local gridX_=self.xm_gridX
local gridZ_=self.xm_gridZ
local width=data[3]
local height=data[4]
for i=0,width-1 do
for j=0,height-1 do
if gridX==gridX_+i and gridZ==gridZ_+j then
return true
end
end
end
end
return false
end

function xjEntityHud_xmMove:refreshPos()

end


function xjEntityHud_xmMove:onCreateWidget(widget)

widget:SetChildButtonClick(0,function()
self:onCancelClick()
end)

widget:SetChildButtonClick(1,function()
self:onCommitClick()
end)
self:refreshWidget(widget)
end

function xjEntityHud_xmMove:refreshWidget(widget)
local currentTimes=xianjieModel:getXianMengMoveTimes()
local checkTimes=currentTimes+1
local costList=cfgHelper.get2(cfg_devildombaseconfig_get,1,"guildmove")
costList=#costList>=checkTimes and costList[checkTimes]or costList[#costList]
local haveCost=next(costList)~=nil
widget:SetChildActive(2,haveCost)
widget:SetChildLayoutGroupCreateItems(2,#costList,function(index)
local item=widget:GetChildLayoutGroupGridItem(2,index-1)
local itemData=costList[index]
local itemId=itemData[1]
local itemNum=itemData[2]
local haveNum=itemsModel.getCount(itemId)
local numStr=mathHelper.formatNumber(itemNum)
if itemNum<=haveNum then
numStr=FMT.cfmt3("E33021",numStr)
end
item:SetChildCSImageIcon(0,iconHelper.getIconName(itemId),false)
item:SetChildText(1,numStr)
item:ForceLayoutRect(1)
item:SetChildText(2,FMT.fmt("{0}：",itemsConfig.getItemName(itemId)))
item:ForceLayoutRect(2)
end)
widget:ForceLayoutRect(2)

local str=haveCost and"迁移"or"免费\n迁移"
widget:SetChildText(3,str)
end


function xjEntityHud_xmMove:onRemoveWidget(widget)

end

function xjEntityHud_xmMove:onCancelClick()
if not self:checkWidget()then return end
xianjieModel:leaveSceneState(xjSceneStateType.eMoveXianMeng)
end

function xjEntityHud_xmMove:onCommitClick()
if not self:checkWidget()then return end
local xmData=xianjieModel:getMyXianMengData()
if self.xm_gridX~=xmData.gridX or self.xm_gridZ~=xmData.gridZ then
local args={
content="仙盟堡垒位置发生变动无法签约\n祖师是否前往查看",
oktext="前往查看",
okcb=function()
xianjieModel:leaveSceneState(xjSceneStateType.eMoveXianMeng)
local xmData=xianjieModel:getMyXianMengData()
local pos=xmData:getWorldPos()
xianjieController:lookAtPosition(pos)
end,
}
local dialogue=UIDialogManager.getConfirmDialogEx(nil,args)
dialogue:show()
return
end

local data=self.data
local sceneidx=xianjieModel:getSceneIndex()
local gridX=data[1]
local gridZ=data[2]
local width=data[3]
local height=data[4]
if self.inCurScene==true and gridX==self.xm_gridX and gridZ==self.xm_gridZ then
UIManager.error('请选择要移动的位置')
return
end
if not xianjieModel:checkRangeBlink(gridX,gridZ,width,height)then
UIManager.error("此处无法放置堡垒")
return
end

local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,width,height)
local myXMData=xianjieModel:getMyXianMengData()
local gridX_c_=myXMData.gridX_c
local gridZ_c_=myXMData.gridZ_c
local sceneidx_=myXMData.sceneidx
local bornAreaID=myXMData:getBornAreaID()
local flag,g_list,errorParams=xianjieController:checkMovePath(bornAreaID,sceneidx_,gridX_c_,gridZ_c_,sceneidx,gridX_c,gridZ_c,true,nil,true)
if not flag then
return
end

local check=true
local gridX_,gridZ_
for i=0,width-1 do
for j=0,height-1 do
gridX_=gridX+i
gridZ_=gridZ+j
if self:checkInRange(gridX_,gridZ_)==false and xianjieModel:checkGridState2(sceneidx,gridX_,gridZ_)then
check=false
break
end
end
end
if check==true then
check=xianjieController:checkGridInMap2(gridX,gridZ,width,height,sceneidx)
end
if check==false then
UIManager.error('此处无法放置堡垒')
return
end


local currentTimes=xianjieModel:getXianMengMoveTimes()
local checkTimes=currentTimes+1
local costList=cfgHelper.get2(cfg_devildombaseconfig_get,1,"guildmove")
costList=#costList>=checkTimes and costList[checkTimes]or costList[#costList]
if next(costList)~=nil then
moneySystem:useMoneys(costList,function()
xianjieController:send_35_184(sceneidx,gridX,gridZ)
end,WARNING_TYPE.eWarning)
else
xianjieController:send_35_184(sceneidx,gridX,gridZ)
end
xianjieModel:leaveSceneState(xjSceneStateType.eMoveXianMeng)
end


function xjEntityHud_xmMove:onDelete()

end

return xjEntityHud_xmMove