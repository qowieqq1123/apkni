MysteryLingshouModel={}


function MysteryLingshouModel:on_enter_state()
self.guidlist={}
self.huluguidlist={}
MysteryLingshouModel.lingshoudata={}
MysteryLingshouModel.lingShouCatch=false
end

function MysteryLingshouModel:on_leave_state()
self.guidlist={}
self.huluguidlist={}
MysteryLingshouModel.lingshoudata={}
MysteryLingshouModel.lingShouCatch=false
end



function MysteryLingshouModel:CreateLingShou(obstaclePos)

local PosList=mysteryPosHelper.getRangeSixPosList(obstaclePos,1)
self.poslistordered={}
for k,v in pairs(PosList)do
table.insert(self.poslistordered,v)
end
if not MysteryLingshouModel.lingshoudata or not next(MysteryLingshouModel.lingshoudata)then

mysteryObstacleModel:recordShowLingShouEntitypos(obstaclePos)
return
end
self.huluguidlist={}
for i=1,#MysteryLingshouModel.lingshoudata do
local lsguid=MysteryLingshouModel.lingshoudata[i].guid
local modeldata,scaledata,modelex=lingshouModel:getLingShouOutsideModelInfo(tostring(lsguid))
local model=
{
id=modeldata.body,
components={},
layer=SortingLayers.ITBuilding,
scale=1.5,
icon=modelex and modelex.icon
}
local data={lingshou=true}
if not self.poslistordered[i]or not self.poslistordered[i][1]then
break
end
local guid=mysteryLingShou:create_entity(eMysteryEntityType.emysteryLingShou,1,self.poslistordered[i][1],0,model,data)
self.guidlist[#self.guidlist+1]=guid

local lsCfg=cfgHelper.get1(cfg_lingshouconfig_get,MysteryLingshouModel.lingshoudata[i].id)
local model=
{
id=lsCfg.catchID or 6512,
components={},
layer=SortingLayers.ITGrid2,
scale=1,
}
local huludata={hulu=true}
local hlguid=mysteryLingShou:create_entity(eMysteryEntityType.emysteryLingShou,1,self.poslistordered[i][1],0,model,huludata)
local role=_HexMapManager.GetRole(hlguid)
if role then
role:RunAnimator(eAnimationID.stand2,1)
end
self.huluguidlist[#self.huluguidlist+1]=hlguid
end
mysteryObstacleModel:ClearShowLingShouEntitypos()
MysteryLingshouModel:autoCatch()
end

function MysteryLingshouModel:SetLingShouEntity(lingshoulen,lingshoulist)
self.guidlist={}

lingshoulist=MysteryLingshouModel:sortlingshoulist(lingshoulist)
MysteryLingshouModel.lingshoudata=lingshoulist
local lastpos=mysteryPlayerModel:get_last_pos()
local obstaclePos=mysteryObstacleModel:GetShowLingShouEntitypos()
if obstaclePos then
MysteryLingshouModel:CreateLingShou(obstaclePos)
end
end

function MysteryLingshouModel:recordRecvData(getFlag,itemListLen,itemList,autoItemListLen,autoItemList,effectFlag)
self.RecvData={}
self.RecvData.getFlag=getFlag
self.RecvData.itemListLen=itemListLen
self.RecvData.itemList=itemList
self.RecvData.autoItemListLen=autoItemListLen
self.RecvData.autoItemList=autoItemList
self.RecvData.effectFlag=effectFlag
end


function MysteryLingshouModel:ShowLingShouData()
UIManager:showWindow("UIMysteryCatchFinishWin")

end

function MysteryLingshouModel:ShowLingShouWin()
local lingshoutb=table.weakCopy(MysteryLingshouModel.lingshoudata)
local args={lslist=lingshoutb,lsindex=1,
closeCallBack=function()
MysteryLingshouModel:ShowRewardJieSuan()
UIFullLingShouMainControl:closeUI()
end,}
MysteryLingshouModel.lingshoudata={}
yushoufangController:onShowLingShouInfoWin(args)





end

function MysteryLingshouModel:recordJieSuanData(lookUp,list,needAuto)
self.jiesuandata={}
self.jiesuandata.lookUp=lookUp
self.jiesuandata.list=list
self.jiesuandata.needAuto=needAuto

end

function MysteryLingshouModel:ShowRewardJieSuan()
MysteryController:autoRemoveReward(self.jiesuandata.lookUp,self.jiesuandata.list)
end

function MysteryLingshouModel:dealCatch()
MysteryLingshouModel.lingShouCatch=true
MysteryLingshouModel:playDeadAnim()

timeEventController.delayDo(2.8,function()
MysteryController:jiesuanReward(self.RecvData.getFlag,self.RecvData.itemListLen,self.RecvData.itemList,
self.RecvData.autoItemListLen,self.RecvData.autoItemList,self.RecvData.effectFlag,true)
MysteryLingshouModel:ClearLingShouEntity()
MysteryLingshouModel.lingShouCatch=false
end)
end


function MysteryLingshouModel:autoCatch()
if MysteryGuildOrder:isInAuto()then
MysteryLingshouModel:dealCatch()
end
end

function MysteryLingshouModel:playDeadAnim()

for i=1,#self.huluguidlist do

local guid=self.huluguidlist[i]
local role=_HexMapManager.GetRole(guid)
if role then
role:RunAnimator(3652,1)
end
end
end

function MysteryLingshouModel:ClearLingShouEntity()
for i=1,#self.guidlist do
local guid=self.guidlist[i]
mysteryLingShou:remove_entity(guid)
end
for i=1,#self.huluguidlist do
local guid=self.huluguidlist[i]
mysteryLingShou:remove_entity(guid)
end
self.guidlist={}

end


function MysteryLingshouModel:sortlingshoulist(lingshoulist)
lingshouLookup:sortList(lingshoulist,eLingShouSortType.eFightSort,eSortOrder.eDown)
return lingshoulist
end
