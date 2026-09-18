









local xjEntityHud_zmMove={}


function xjEntityHud_zmMove:onInit()
self.needFollow=true
local hudSet=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'hudSet_zmmove')
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

local zmData=xianjieModel:getMyZongMenData()
self.inCurScene=zmData:checkInCurScene()
self.zm_gridX=zmData.gridX
self.zm_gridZ=zmData.gridZ
end

function xjEntityHud_zmMove:checkInRange(gridX,gridZ)
if self.inCurScene==true then
local data=self.data
local gridX_=self.zm_gridX
local gridZ_=self.zm_gridZ
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

function xjEntityHud_zmMove:refreshPos()

end


function xjEntityHud_zmMove:onCreateWidget(widget)

widget:SetChildButtonClick(0,function()
self:onCancelClick()
end)

widget:SetChildButtonClick(1,function()
self:onCommitClick()
end)
self:refreshWidget(widget)
end

function xjEntityHud_zmMove:refreshWidget(widget)
self.moveType=xianjieModel:getZongMenMoveType()

local isShowCostItem=self.moveType==1
widget:SetChildActive(3,isShowCostItem)

if self.moveType==ZongMenMoveTypeEnum.USE_ITEM then
self:refreshCost(widget)
elseif self.moveType==ZongMenMoveTypeEnum.USE_PRIVILEGE then
self:refreshFree(widget)
elseif self.moveType==ZongMenMoveTypeEnum.USE_MOJIE_FREE then
self:refreshFree(widget)
elseif self.moveType==ZongMenMoveTypeEnum.USE_MOGONGACT_FREE then
self:refreshFree(widget)
end
end

function xjEntityHud_zmMove:refreshCost(widget)
local costs=xianjieModel:getZongMenMoveCost()
local cost=costs[1]
local itemid=cost[1]
local need=cost[2]
local costWidget=widget:GetChildWidgetBase(2)
costWidget:SetChildCSImageIcon(0,iconHelper.getIconName(itemid),false)
local num_str
local have=0
if moneyConfig.isMoney(itemid)then
have=moneyModel.getMoney(itemid)
else
have=bagModel.getItemCountById(itemid)
end
num_str=tostring(need)
if have<need then
num_str=FMT.fmt('<color=#E33021>{0}</color>',num_str)
end





costWidget:SetChildText(1,num_str)
widget:SetChildText(4,"迁移")
end

function xjEntityHud_zmMove:refreshFree(widget)
widget:SetChildText(4,"<color=#f4f0e9>迁移</color>\n<color=#aae252><size=20>免费</size></color>")
end


function xjEntityHud_zmMove:onRemoveWidget(widget)

end

function xjEntityHud_zmMove:onCancelClick()
if not self:checkWidget()then return end
xianjieModel:leaveSceneState(xjSceneStateType.eMoveZongMen)
end

function xjEntityHud_zmMove:onCommitClick()
if not self:checkWidget()then return end
local data=self.data
local sceneidx=xianjieModel:getSceneIndex()
local gridX=data[1]
local gridZ=data[2]
local width=data[3]
local height=data[4]
if self.inCurScene==true and gridX==self.zm_gridX and gridZ==self.zm_gridZ then
UIManager.error('请选择要移动的位置')
return
end
if not xianjieModel:checkRangeBlink(gridX,gridZ,width,height)then
UIManager.error("此处无法放置堡垒")
return
end

if xianjienSceneIndexType:isMoJie(sceneidx)then
local isHasCantMoveBuff,errStr=self:checkCantLeaveSafeAreaBuff()
if isHasCantMoveBuff then

local zmData=xianjieModel:getMyZongMenData()
local r_areaID=zmData:getBornAreaID()
local t_areaID=xianjieModel:checkMapGridDataAreaID(sceneidx,gridX,gridZ)
if r_areaID~=t_areaID then
UIManager.error(errStr)
return
end
end
end

local gridX_c,gridZ_c=xianjieController:worldGridCenterPos(gridX,gridZ,width,height)
local gridX_c_,gridZ_c_,sceneidx_,bornAreaID=xianjieModel:getZongMenWorldGridCenterPos()
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
if xianjieModel:checkGridLimit(sceneidx,gridX_,gridZ_)then
check=false
break
else
if self:checkInRange(gridX_,gridZ_)==false and xianjieModel:checkGridState2(sceneidx,gridX_,gridZ_)then
check=false
break
end
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

local func=function()
if self.moveType==ZongMenMoveTypeEnum.USE_ITEM then
self:onCommitCost()
elseif self.moveType==ZongMenMoveTypeEnum.USE_PRIVILEGE then
self:onCommitPrivilege()
elseif self.moveType==ZongMenMoveTypeEnum.USE_MOJIE_FREE then
self:onCommitCost()
elseif self.moveType==ZongMenMoveTypeEnum.USE_MOGONGACT_FREE then
self:onCommitFree()
end
end
local hasFHZ=xianjieModel:isOpenFangHuZhao(playerModel:getActorID())
if hasFHZ and xianjieModel:checkMoJunTZRangeArea(gridX,gridZ,width,height,sceneidx)then

local content="迁城到魔君挑战将解除护山大阵，是否迁城？"

local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=function()
func()
end
})
dialogue:show()
else
func()
end
end

function xjEntityHud_zmMove:onCommitFree()
local gridX=self.data[1]
local gridZ=self.data[2]
local moveFunc=function()
xianjieController:reqMoveZMPos(gridX,gridZ)
xianjieModel:leaveSceneState(xjSceneStateType.eMoveZongMen)
end

local hasJiJie=xianjieModel:checkHasSelfInitiatorJiJie()
if hasJiJie then
local showdata=
{
type='UIDialouge',
title='提示',
content='正在发起集结，迁城将取消集结，是否取消？',
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=moveFunc,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
moveFunc()
end
end

function xjEntityHud_zmMove:onCommitCost()
local call=function()
local gridX=self.data[1]
local gridZ=self.data[2]
local moveFunc=function()
xianjieController:reqMoveZMPos(gridX,gridZ)
xianjieModel:leaveSceneState(xjSceneStateType.eMoveZongMen)
end

local hasJiJie=xianjieModel:checkHasSelfInitiatorJiJie()
if hasJiJie then
local showdata=
{
type='UIDialouge',
title='提示',
content='正在发起集结，迁城将取消集结，是否取消？',
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=moveFunc,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
moveFunc()
end
end

local call2=function()
local state,itemid,need,useNum=xianjieModel:checkZongMenMoveCost(false)
if state then
call()
else
local getDescFunc=function(uselist)
local itemName=itemsConfig.getColorName(itemid)
local s=fastBuyController.getCostDescWithIcon(uselist)
local str=FMT.fmt('缺少<color=#549327>{1}</color>枚{0}，是否花费{2}购买并使用？',itemName,need,s)
return str
end

fastBuyController:checkUse5(itemid,useNum,call,getDescFunc,nil)
end
end
local hasZhuZha=xianjieModel:getStationDataNotEmpty()
if hasZhuZha then
local showdata=
{
type='UIDialouge',
title='提示',
content='有队伍在空地驻扎，是否召回队伍进行迁城？',
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=call2,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
call2()
end
end

function xjEntityHud_zmMove:onCommitPrivilege()
local args={}
local temp={2,self.data[1],self.data[2]}

args.exInfoJsonStr=jsonHelper.encode(temp)

local tqId=XIANGUAN_PRIVILEGE_ENUM.eYiTianYiRi
local xgInfo=xianguanController:getSelfHasTeQuanByType(tqId,XIANGUAN_TYPE_ENUM.eYiTianShenJiang)
local state,errId=xianguanHelper.checkTeQuanUseCondition(xgInfo.jobId,tqId)
if state then
xianguanModel:callTeQuanObjFunc(xgInfo.jobId,tqId,"use",args)
xianjieModel:leaveSceneState(xjSceneStateType.eMoveZongMen)
else
UIManager.error(xianguanHelper.getConditionWarningDesc(errId,xgInfo.jobId,tqId))
end
end



function xjEntityHud_zmMove:onDelete()

end


function xjEntityHud_zmMove:checkCantLeaveSafeAreaBuff()
local flag,lp=xianjieModel:getBuffIDsByBuffType(xjBuffEffectType.eCantLeaveSafeArea)
local ltime
if flag==true then
for buffID,_ in pairs(lp)do
local ltime_=xianjieModel:getBuffLeftTime(buffID)
if ltime_>0 then
if ltime==nil or ltime_>ltime then
ltime=ltime_
end
end
end
end
if ltime~=nil and ltime>0 then
local moveBuffLeftTime=ltime
local str=FMT.fmt('{0}后可迁移出仙域本阵',timeHelper.format_time_stamp3(moveBuffLeftTime))

return true,str
end
return false
end

return xjEntityHud_zmMove