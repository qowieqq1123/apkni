







def_class("UIXianJie_zmSearchTipsWin",UIWindowBase)









function UIXianJie_zmSearchTipsWin:bindComponents()

self.clickMask=UIButton.get(self,0)
self.costCount=UILinkImageText.get(self,1)
self.headIconCreater=UIObject.get(self,2)
self.mbg=UIObject.get(self,3)
self.oldTimeText=UIText.get(self,4)
self.playerName=UIText.get(self,5)
self.posText=UILinkImageText.get(self,6)
self.searchBtn=UIButton.get(self,7)
self.seeBtn=UIButton.get(self,8)
self.timeText=UIText.get(self,9)
self.tipsText=UIText.get(self,10)
self.titleName=UIText.get(self,11)
self.buttonPanel=UIObject.get(self,12)
self.buttonPanel2=UIObject.get(self,13)
self.jobIcon=UIImage.get(self,14)
self.jobName=UIText.get(self,15)
self.searchBtn2=UIButton.get(self,16)
self.tqimg=UIObject.get(self,17)
self.timeText2=UIText.get(self,18)
self.seeBtn2=UIButton.get(self,19)
self.oldTimeText2=UIText.get(self,20)

self.clickMask:setButtonClick(function()self:onClickMask()end)

self.searchBtn:setButtonClick(function()self:onSearchBtn()end)

self.seeBtn:setButtonClick(function()self:onSeeBtn()end)

self.searchBtn2:setButtonClick(function()self:onSearchBtn2()end)

self.seeBtn2:setButtonClick(function()self:onSeeBtn2()end)



end


function UIXianJie_zmSearchTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clickMask);self.clickMask=nil;
_UIObject_release(self.costCount);self.costCount=nil;
_UIObject_release(self.headIconCreater);self.headIconCreater=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.oldTimeText);self.oldTimeText=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.posText);self.posText=nil;
_UIObject_release(self.searchBtn);self.searchBtn=nil;
_UIObject_release(self.seeBtn);self.seeBtn=nil;
_UIObject_release(self.timeText);self.timeText=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.titleName);self.titleName=nil;
_UIObject_release(self.buttonPanel);self.buttonPanel=nil;
_UIObject_release(self.buttonPanel2);self.buttonPanel2=nil;
_UIObject_release(self.jobIcon);self.jobIcon=nil;
_UIObject_release(self.jobName);self.jobName=nil;
_UIObject_release(self.searchBtn2);self.searchBtn2=nil;
_UIObject_release(self.tqimg);self.tqimg=nil;
_UIObject_release(self.timeText2);self.timeText2=nil;
_UIObject_release(self.seeBtn2);self.seeBtn2=nil;
_UIObject_release(self.oldTimeText2);self.oldTimeText2=nil;
end
















local _this=nil
local _ab=globalABLookup.xianguan




function UIXianJie_zmSearchTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianJie_zmSearchTipsWin:__delete()
self:unbindComponents()
self:stopCDTimer()
_this=nil
end

function UIXianJie_zmSearchTipsWin:showModel()

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6011,1,nil,eAnimationID.stand,false,false,0,nil)
end




function UIXianJie_zmSearchTipsWin:onShow(argtable,afterOnloaded)
if argtable then
self.actorId=argtable.actorId
self.targetId=argtable.targetId
if argtable.tipsText then
self.tipsText:setText(argtable.tipsText)
end
end

self:refreshView()
self:showModel()
end

function UIXianJie_zmSearchTipsWin:refreshView()
local zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
if zmData==nil then
self:closeSelf()
else
self:refreshInfo(zmData)
end
end

function UIXianJie_zmSearchTipsWin:refreshInfo(zmData)
if zmData==nil then
zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
end
if zmData==nil then return end
local stationData=self.targetId and xianjieModel:getStationData(self.targetId)or nil


local gridX=stationData and stationData.gridX or zmData.gridX
local gridZ=stationData and stationData.gridZ or zmData.gridZ
local pos_str=FMT.fmt('(X:{0},Y:{1})',gridX,gridZ)
self.posText:setText(pos_str)


local iconInfo=zmData.iconInfo
playerController:setHeadIcon(self.winlua,self.headIconCreater:getID(),{iconInfo=iconInfo,scale=0.82})


local nameStr=zmData.actorname
if stationData then
nameStr=FMT.fmt("{0}的驻扎",nameStr)
end
self.playerName:setText(nameStr)

local order=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'order')
local costs=order[xjOrderType.eLook][4]
local s=FMT.fmt('消耗：{0}quad-icon={1}-quad',costs[1][2],iconHelper.getIconName(costs[1][1]))
self.costCount:setText(s)


local isWSBX,xgid=xianguanModel.isTTMS_tequan()
if isWSBX then
self.buttonPanel:setActive(false)
self.buttonPanel2:setActive(true)
local jobCfg=xianguanConfig.getJobConfig(nil,xgid)
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_19
local jobIconName=xianguanConfig.getJobIconName(jobCfg.jobIcon)
self.jobIcon:setCSImageSprite(_ab,jobIconName)
local tqname=cfgHelper.get2(cfg_xianguanprivilegeconfig_get,tqid,'name')
self.jobName:setText(tqname)


self:stopCDTimer()
local cd=xianguanModel.ttms_WSBX_Cd()
local curTime=timeHelper.getServerShortTime()
local dval=0
local callback=function()
curTime=timeHelper.getServerShortTime()
dval=cd-curTime
if dval>0 then
_this.tqimg:setActive(true)
_this.timeText2:setText(FMT.fmt("{0}",timeHelper.format_time_stamp14(dval)))
else
_this:stopCDTimer()
_this.tqimg:setActive(false)
end
end
self.cdTimer=self:setTimer(1,0,callback)
callback()











else
self.buttonPanel:setActive(true)
self.buttonPanel2:setActive(false)

local time_str=self:getWayTimeStr(stationData or zmData)
self.timeText:setText(time_str)


local datatb=xianjieModel:Get_searchLogLookup(self.actorId,self.targetId or 0)
self.seeBtn:setActive(datatb~=nil)
if datatb then
local nowTime=timeHelper.getServerShortTime()
local left=nowTime-tonumber(datatb.sec)
self.oldTimeText:setText(FMT.fmt("上次侦查:{0}",timeHelper.format_time_stamp14(left)))
end
end
end
function UIXianJie_zmSearchTipsWin:stopCDTimer()
if self.cdTimer then
self:stopTimerByID(self.cdTimer)
self.cdTimer=nil
end
end

function UIXianJie_zmSearchTipsWin:getWayTimeStr(zmData)
local gridX=zmData.gridX
local gridZ=zmData.gridZ
local sceneidx=zmData.sceneidx
local speed=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'march')[2][1]
local wayTime=xianjieModel:getZongMenToPosWayTime(sceneidx,gridX,gridZ,speed,nil,nil,nil)
wayTime=math.ceil(wayTime)
local time_str=timeHelper.format_time_stamp3(wayTime)
return time_str
end

function UIXianJie_zmSearchTipsWin:showDialogue(content,callback)
local dialogue=UIDialogManager.getConfirmDialogEx(nil,{
content=content,
okcb=callback
})
dialogue:show()
end


function UIXianJie_zmSearchTipsWin:onHide()

end





function UIXianJie_zmSearchTipsWin:onClickMask()
self:closeSelf()
end

function UIXianJie_zmSearchTipsWin:onSearchBtn2()
local isWSBX,xgid=xianguanModel.isTTMS_tequan()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_19
local cd=xianguanModel.ttms_WSBX_Cd()
local curTime=timeHelper.getServerShortTime()
local dval=cd-curTime
if dval>0 then
UIManager.info("无所不晓特权冷却中")
return
end

local zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil

local nameStr=zmData.actorname
local orderType=xjOrderType.eLook
local infoguid=self.targetId or self.actorId

local order=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'order')
local costs=order[orderType][4]
local itemName=itemsConfig.getItemName(costs[1][1])
local content=FMT.fmt('是否花费{0}{1}前往侦查\n【{2}】的驻守情报？\n<color=#549327>立即获得情报</color>',costs[1][2],itemName,nameStr)
self:showDialogue(content,function()
if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end
local have=itemsModel.getCount(costs[1][1])
if have<costs[1][2]then
gainControl:showGainWin(costs[1][1])
UIManager.error('消耗不足')
return
end

xianguanModel.useTTMS_WSBX_tequan(xgid,tqid,infoguid)
UIManager.info("侦查成功")
_this:closeSelf()
end)
end



function UIXianJie_zmSearchTipsWin:onSearchBtn()
local zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
local stationData=self.targetId and xianjieModel:getStationData(self.targetId)or nil
local nameStr=zmData.actorname
local data=stationData or zmData
local flag,g_list,errorParams=data:checkMovePathCondition(true)
if not flag then
if errorParams then
local errStr=""
local isSelfInNeutralArea=errorParams.isSelfInNeutralArea
local isTargetInNeutralArea=errorParams.isTargetInNeutralArea
if isSelfInNeutralArea then

errStr="处于阵外无法侦查本阵内的其他祖师"
elseif isTargetInNeutralArea then

errStr="处于本阵内无法侦查阵外的祖师"
else

errStr="处于本阵内无法侦查其他本阵内的其他祖师"
end
UIManager.error(errStr)
end
return
end

local orderType=xjOrderType.eLook
local infoguid=self.targetId or self.actorId
local timeStr=self:getWayTimeStr(stationData or zmData)
local order=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'order')
local costs=order[orderType][4]
local itemName=itemsConfig.getItemName(costs[1][1])
local content=FMT.fmt('是否花费{0}{1}前往侦查\n【{2}】的驻守情报？\n预计{3}后可获得情报',costs[1][2],itemName,nameStr,timeStr)
self:showDialogue(content,function()
if not xianjieModel:checkWaiPaiTeamNum(true)then
return
end
local have=itemsModel.getCount(costs[1][1])
if have<costs[1][2]then
gainControl:showGainWin(costs[1][1])
UIManager.error('消耗不足')
return
end
local searchFunc=function()
local guid=int64.new(tostring(infoguid))
local moneyList={}
local pstr=jsonHelper.encode({})
xianjieController:reqOrder(guid,orderType,{},moneyList,pstr,nil,nil,g_list)
_this:closeSelf()
end

local hasFHZ=xianjieModel:isOpenFangHuZhao(playerModel:getActorID())
local enemyType=xianjieModel:checkEnemyType2(data.actorid,data.sceneidx)
local isFriend=enemyType==xjEnemyType.eSelf or enemyType==xjEnemyType.eAllies
if hasFHZ and not isFriend then

local content="发起侦查将解除护山大阵，是否侦查？"
_this:showDialogue(content,function()
searchFunc()
end)
else
searchFunc()
end
end)
end



function UIXianJie_zmSearchTipsWin:onSeeBtn()
local maxTime=cfg_fairylandlogconfig().const_def.spy_maxTime
local datatb=xianjieModel:Get_searchLogLookup(self.actorId,self.targetId or 0)
local nowTime=timeHelper.getServerShortTime()
local left=nowTime-tonumber(datatb.sec)
if left>=maxTime then
UIManager.error('侦查信息已过期，请重新侦查')
return
end
local zmData=xianjieModel:getZongMenData(self.actorId)
local args={actorid=self.actorId,serverid=zmData.serverid,guid=datatb.guid,stationguid=self.targetId or 0,markRecored=true}
local callback=function(args,other)
if _this==nil then return end
UIManager:showWindow('UIXianJie_zmSearchLogTipsWin',{args=args,actorId=_this.actorId})
xianjieController:closeWin('UIXianJie_stationInfoWin')
_this:closeSelf()
xianjieController:closeWin3()
end
otherPlayerModel:reqActorXianJieInfo(otherPlayerInfoType.eXianJieSearchLog,self.actorId,args,callback)
end

function UIXianJie_zmSearchTipsWin:onSeeBtn2()
local maxTime=cfg_fairylandlogconfig().const_def.spy_maxTime
local datatb=xianjieModel:Get_searchLogLookup(self.actorId,self.targetId or 0)
local nowTime=timeHelper.getServerShortTime()
local left=nowTime-tonumber(datatb.sec)
if left>=maxTime then
UIManager.error('侦查信息已过期，请重新侦查')
return
end
local zmData=xianjieModel:getZongMenData(self.actorId)
local args={actorid=self.actorId,serverid=zmData.serverid,guid=datatb.guid,stationguid=self.targetId or 0,markRecored=true}
local callback=function(args,other)
if _this==nil then return end
UIManager:showWindow('UIXianJie_zmSearchLogTipsWin',{args=args,actorId=_this.actorId})
xianjieController:closeWin('UIXianJie_stationInfoWin')
_this:closeSelf()
xianjieController:closeWin3()
end
otherPlayerModel:reqActorXianJieInfo(otherPlayerInfoType.eXianJieSearchLog,self.actorId,args,callback)
end