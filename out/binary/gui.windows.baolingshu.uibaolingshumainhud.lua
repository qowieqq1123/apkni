







def_class("UIBaoLingShuMainHUD",UIWindowBase)









function UIBaoLingShuMainHUD:bindComponents()

self.creator=UIGameobjectClone.new(self,0)
self.hud=UIObject.get(self,1)



end


function UIBaoLingShuMainHUD:unbindComponents()
local _UIObject_release=UIObject.release
self.creator:deleteSelf();self.creator=nil;
_UIObject_release(self.hud);self.hud=nil;
end

















local stopEffect=CS.GameInterface.StopEffect

local rewardObjList
local points={{992,9.4,1.6,1},{993,9.4,1.6,1},{994,9.2,1.2,1},{995,8.5,0.8,2},{996,8.2,0.7,2},{997,8.2,0.6,2},{998,7.6,0.5,3},{999,7.6,0.45,3},{1000,7.6,0.4,3},{1001,8.2,0.5,3},{1002,8.6,0.45,4},{1003,11,0.5,4},{1005,9.2,0.65,4},{1006,9.2,0.9,4},{1007,9.2,0.9,4},{1008,9.2,0.9,4}}
local showTypeEnum={
BaoLingShu=1,
QiYuanShu=2,
}


function UIBaoLingShuMainHUD:onLoaded(...)
self:bindComponents()
rewardObjList={}
end


function UIBaoLingShuMainHUD:__delete()
cameraControl.setCameraActive(true)
if self.handle then
stopEffect(self.handle)
end
rewardObjList=nil
self:stopDelayTimer()
self:unbindComponents()
end




function UIBaoLingShuMainHUD:onShow(argtable,afterOnloaded)
if argtable==nil then return end
self.entList=argtable.entList
local config=argtable.config
local showNum=argtable.dzCount
self.showDzIdList=argtable.showDzIdList
if baoLingShuController.fightStage then
if baoLingShuController.fightStage.stageID==101 then
self.showType=showTypeEnum.BaoLingShu
elseif baoLingShuController.fightStage.stageID==106 then
self.showType=showTypeEnum.QiYuanShu
end
end

local showItems=self:getShowItems(config)

self:useModelFunc("setShowItemList",showItems[3],showNum)

for i,ent in ipairs(self.entList)do
local dzId
if self.showType==showTypeEnum.QiYuanShu then
dzId=self.showDzIdList[i]
end
self.creator:createObject('UIBaoLingShuHUD',self.hud:getID(),i,{fightEnt=ent,parent=self,showItems=showItems[3],showType=self.showType,dzId=dzId})
end
self:showPassAni(true)
self.handle=fightManager.playEffect(10024,fightModel.getWorldCenter(),true)
cameraControl.setCameraActive(false)
end


function UIBaoLingShuMainHUD:onHide()
cameraControl.setCameraActive(true)
end

function UIBaoLingShuMainHUD:showPassAni(show)
if show and self.showType==1 then
self.passAniId=self.creator:createObject('UIBLSPassAniHUD',self.hud:getID(),#self.entList+1)
else
if self.passAniId then
self.creator:recycleItemById(self.passAniId)
self.passAniId=nil
end
end
end

function UIBaoLingShuMainHUD:getShowItems(config)
local rewards=config.rewardShow
local worldLevel=zongmenModel:getWorldLevel()
for i,v in ipairs(rewards)do
if worldLevel>=v[1]and worldLevel<=v[2]then
return v
end
end
return rewards[#rewards]
end

function UIBaoLingShuMainHUD:showBigReward()
local randList=table.deepCopy(points)
self:useModelFunc("setShowPoints",randList)
local configId,rewards
if self.showType==showTypeEnum.BaoLingShu then
configId,rewards=baoLingShuModel:getRewardsTemp()
elseif self.showType==showTypeEnum.QiYuanShu then
rewards=qiYuanShuModel:getRewardsTemp()
end
local one=false
local time=4.2
if#rewards==1 then
one=true
time=3
end
for i,v in ipairs(rewards)do
local luaid=self.creator:createObject('UIBLSRewardHUD',self.hud:getID(),#self.entList+1+i,{v.param_1,one,showType=self.showType})
rewardObjList[#rewardObjList+1]=luaid
end

self.delayTimer=self:delayDo(time,function(...)
self:overShowReward()
end)
end

function UIBaoLingShuMainHUD:stopDelayTimer()
if self.delayTimer then
self:stopTimerByID(self.delayTimer)
self.delayTimer=nil
end
end

function UIBaoLingShuMainHUD:overShowReward()
if#rewardObjList>0 then
for i=1,#rewardObjList do
local luaid=rewardObjList[i]
self.creator:recycleItemById(luaid)
rewardObjList[i]=nil
end
end
self:showPassAni(true)

if self.showType==showTypeEnum.BaoLingShu then
baoLingShuController:showBaoLingShuPrize()
UIManager:callWindowFunc('UIBaoLingShuWin','overQiFuExpression')
elseif self.showType==showTypeEnum.QiYuanShu then
qiYuanShuController:showQiYuanShuPrize()
UIManager:callWindowFunc('UIQiYuanShuWin','overQiFuExpression')
end
end

function UIBaoLingShuMainHUD:jumpToOverShowReward()
self:stopDelayTimer()
self:overShowReward()
end


function UIBaoLingShuMainHUD:useModelFunc(funcName,...)
if self.showType==showTypeEnum.BaoLingShu then
return baoLingShuModel[funcName](baoLingShuModel,...)
elseif self.showType==showTypeEnum.QiYuanShu then
return qiYuanShuModel[funcName](qiYuanShuModel,...)
end
end

