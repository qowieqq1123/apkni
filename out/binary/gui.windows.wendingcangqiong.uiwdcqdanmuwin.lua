







def_class("UIWDCQDanMuWin",UIWindowBase)









function UIWDCQDanMuWin:bindComponents()

self.danmuRoot=UIObject.get(self,0)



end


function UIWDCQDanMuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.danmuRoot);self.danmuRoot=nil;
end



















local YList={-100,-100+50,-100+50*2,-100+50*3,-100+50*4}
local XList={500,500+50,500+50*2,500+50*3,500+50*4}

function UIWDCQDanMuWin:onLoaded(...)
self:bindComponents()
self.danMuQueue=queue.New()
self.YListIndex={1,2,3,4,5}
end


function UIWDCQDanMuWin:__delete()
self:unbindComponents()

end


function UIWDCQDanMuWin:onHide()

end




function UIWDCQDanMuWin:onShow(argtable,afterOnloaded)
self:checkShowDanMu()
end

function UIWDCQDanMuWin:checkShowDanMu()
local danshowFlagList=userActorArraySetting.get(ACTOR_SETTING_TYPE.eWenDingCangQiong,"danshowFlagList",{})
local showList={}
for i,v in ipairs(WDCQCGroupEnumList)do
local groupEnum=v
local stage=WDCQController.getGroupStage(groupEnum)
if stage~=WDCQCGameStageEnum.eNone and stage~=WDCQCGameStageEnum.eSixteen then
local preStage=stage-1
local key=FMT.fmt("danshow_{0}_{1}",groupEnum,preStage)
if WDCQController.checkGroupStageFinish(groupEnum,preStage)and not danshowFlagList[key]then
local prestageCfgTemp=WDCQController.getStageCfgTemp(groupEnum,preStage)
if prestageCfgTemp and next(prestageCfgTemp)and prestageCfgTemp.danmuList then
table.insert(showList,{groupEnum,preStage,prestageCfgTemp.danmuList})
danshowFlagList[key]=true
end
end
end
end
if#showList<=0 then
return
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eWenDingCangQiong,"danshowFlagList",danshowFlagList)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eWenDingCangQiong)

for i,v in ipairs(showList)do
local group=v[1]
local stage=v[2]
local danmuList=v[3]
local macthList=WDCQModel:getData_MacthList(group,stage)
if macthList then
for i2,v2 in ipairs(macthList)do
if not mathHelper.compareInt64(v2.actor_id_1,Int64_0)
and not mathHelper.compareInt64(v2.actor_id_2,Int64_0)
and not mathHelper.compareInt64(v2.win_actor_id,Int64_0)then
local winName,winServerId,failName,failServerId
if mathHelper.compareInt64(v2.actor_id_1,v2.win_actor_id)then
winName=v2.name_1
winServerId=v2.server_id_1
failName=v2.name_2
failServerId=v2.server_id_2
else
winName=v2.name_2
winServerId=v2.server_id_2
failName=v2.name_1
failServerId=v2.server_id_1
end
local randomIndex=math.random(1,#danmuList)
local msg=FMT.fmt(danmuList[randomIndex],loginModel:getServerName(winServerId),winName,loginModel:getServerName(failServerId),failName)
self:onRecvMesg(msg)
end
end
end
end
end

function UIWDCQDanMuWin:onRecvMesg(mesg)
local danMu=self.danMuQueue:dequeue()
if not danMu then
self.danmuItemNum=self.danmuItemNum or 0
if self.danmuItemNum<2 then
self.danmuRoot:setChildLayoutGroupAddItem()
self.danmuItemNum=self.danmuItemNum+1
danMu=self.danmuRoot:getChildLayoutGroupGridItem(self.danmuItemNum-1)
end
end
if danMu then
local randomYIndex=math.random(1,#self.YListIndex)
local YIndex=self.YListIndex[randomYIndex]
table.remove(self.YListIndex,randomYIndex)
local x=0
danMu:SetChildCanvasGroupAlpha(-1,1)
danMu:SetChildLocalPosition(-1,Vector3(XList[YIndex],YList[YIndex],0))
local tween=danMu:SetChildDOLocalMoveX(-1,-2500,20,function()
danMu:SetChildCanvasGroupAlpha(-1,0)
self.danMuQueue:enqueue(danMu)
table.insert(self.YListIndex,YIndex)
end)
tween:SetEase(_Ease.Linear)
danMu:SetChildText(0,mesg)
else
self:delayDo(20,function()
self:onRecvMesg(mesg)
end)
end
end









