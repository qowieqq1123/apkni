







def_class("UICaiShenJiaDaoRedPacketMainWin",UIWindowBase)









function UICaiShenJiaDaoRedPacketMainWin:bindComponents()

self.bgImage=UIImage.get(self,0)
self.bgModel=UIObject.get(self,1)
self.descTx=UIText.get(self,2)
self.descTx2=UIText.get(self,3)
self.jumpBtn=UIButton.get(self,4)
self.model=UIObject.get(self,5)
self.rewardList=UIObject.get(self,6)
self.rewardView=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.timeBg=UIImage.get(self,9)
self.timeTx=UIText.get(self,10)
self.titleImage=UIImage.get(self,11)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)



end


function UICaiShenJiaDaoRedPacketMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgImage);self.bgImage=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.descTx);self.descTx=nil;
_UIObject_release(self.descTx2);self.descTx2=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.rewardList);self.rewardList=nil;
_UIObject_release(self.rewardView);self.rewardView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.timeBg);self.timeBg=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.titleImage);self.titleImage=nil;
end















local _this=nil
local _ab="ui/windows/activities/sub_caishenjiadao/caishenjiadao_atlas_pak.ab"



function UICaiShenJiaDaoRedPacketMainWin:onLoaded(...)
self:bindComponents()
_this=self
self._onNewDay=function()
self:onNewDay()
end
self:addNotify(notifyConfig.onNewDay,self._onNewDay)
end


function UICaiShenJiaDaoRedPacketMainWin:__delete()
self:unbindComponents()
_this=nil
end




function UICaiShenJiaDaoRedPacketMainWin:onShow(argtable,afterOnloaded)
if argtable then
local old=self.activityId==argtable.act_id and self.subType==argtable.sub_act_type and self.subId==argtable.sub_act_id
if not old then
self.activityId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.argtable=argtable
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self:refreshView()
end
end
end


function UICaiShenJiaDaoRedPacketMainWin:onHide()

end




function UICaiShenJiaDaoRedPacketMainWin:onJumpBtn()
local info=self.info
if info:checkEntityTime()then
UIFullCommonControl:closeUI(nil,true)
UIManager:showWindow("UICaiShenJiaDaoRedPacketShareWin",{info=info})
else
UIManager.info("发红包的时间已过")
end
end

function UICaiShenJiaDaoRedPacketMainWin:refreshView()
local bgImage=self.argtable.bgImage
if bgImage then
self.bgImage:setSprite(bgImage[1],bgImage[2])
else
self.bgImage:setImageIcon("",false)
end

local bgModel=self.argtable.bgModel
if bgModel then
self.bgModel:setChildUIModelShowTarget(bgModel[1],bgModel[2]or 1,bgModel[3]or{},bgModel[4]or eAnimationID.stand,false,true,0)
else
self.bgModel:setChildUIModelRemoveTarget()
end

local model=self.argtable.model
if model then
self.model:setChildUIModelShowTarget(model[1],model[2]or 1,model[3]or{},model[4]or eAnimationID.stand,false,true,0)
self.model:setChildAnchoredPos(model[5]or 0,model[6]or 0)
self.model:setChildUIModelShowFlipX(model[7]==1)
else
self.model:setChildUIModelRemoveTarget()
end

local titleImage=self.argtable.titleImage or""
if titleImage~=""then
self.titleImage:setSprite(_ab,titleImage)
else
self.titleImage:setImageIcon("",false)
end

local rewards=self.argtable.rewards or{}
local rewardCnt=#rewards
self.rewardList:setChildLayoutGroupCreateItems(rewardCnt,function(index)
local rewardItem=self.rewardList:getChildLayoutGroupGridItem(index-1)
local rewardData=rewards[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""
local itemConf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
rewardItem:SetChildPropData(-1,itemProp)
rewardItem:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
end)

local descStr=self.argtable.desc or""
local obj=self.descTx2:getGameObject()
local width=self.descTx2:getChildSizeDeltaX()
descStr=comHelper.getCheckLayoutStr(obj,width,descStr,true)
self.descTx:setText(descStr)

self:refreshJump()

local startTime_l=timeHelper.getServerZeroStamp(self.info.start_time_l)
self.endTime=timeHelper.convertShortStamp(startTime_l+self.sub_actcfg.end_day_idx*86400)
if self:updateCDTick()then
self:startCDTick()
end
end

function UICaiShenJiaDaoRedPacketMainWin:startCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
if not self:updateCDTick()then
self:stopCDTick()
end
end)
end
end

function UICaiShenJiaDaoRedPacketMainWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UICaiShenJiaDaoRedPacketMainWin:updateCDTick()
local nowTime=timeHelper.getServerShortTime()
local leastTime=self.endTime-nowTime
if leastTime>0 then
self.timeTx:setText(FMT.fmt("<color=#efb150>活动剩余时间：</color>{0}",timeHelper.format_time_stamp3(leastTime)))
return true
else
self.timeTx:setText("<color=#efb150>活动已结束</color>")
return false
end
end

function UICaiShenJiaDaoRedPacketMainWin:refreshJump()
self.jumpBtn:setActive(self.info:checkEntityTime())
end

function UICaiShenJiaDaoRedPacketMainWin:onNewDay()
self:refreshJump()
end