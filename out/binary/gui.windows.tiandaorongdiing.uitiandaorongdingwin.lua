







def_class("UITianDaoRongDingWin",UIWindowBase)









function UITianDaoRongDingWin:bindComponents()

self.lianzhiDesc=UIText.get(self,0)
self.btnReward=UIButton.get(self,1)
self.nameBg=UIObject.get(self,2)
self.progress2Txt=UIText.get(self,3)
self.progressBar2=UIProgressBarAni.get(self,4)
self.addBtn=UIButton.get(self,5)
self.levelUpBtnText=UIText.get(self,6)
self.bdLevel=UIText.get(self,7)
self.levelUpBtn=UIButton.get(self,8)
self.progressTxt=UIText.get(self,9)
self.progressBar=UIProgressBarAni.get(self,10)
self.progress2=UIObject.get(self,11)
self.item1=UIBaseItem.get(self,12)
self.btnAdd=UIButton.get(self,13)
self.levelUpRoot=UIObject.get(self,14)
self.progress=UIObject.get(self,15)
self.luzi=UIObject.get(self,16)
self.resetTitle=UIObject.get(self,17)
self.root=UIObject.get(self,18)
self.effect=UIObject.get(self,19)
self.effect2=UIObject.get(self,20)
self.upRoot=UIObject.get(self,21)
self.speed=UIButton.get(self,22)
self.time=UIText.get(self,23)
self.effectRoot=UIObject.get(self,24)
self.resetTxt=UIText.get(self,25)

self.btnReward:setButtonClick(function()self:onBtnReward()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.btnAdd:setButtonClick(function()self:onBtnAdd()end)

self.speed:setButtonClick(function()self:onSpeed()end)



end


function UITianDaoRongDingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.lianzhiDesc);self.lianzhiDesc=nil;
_UIObject_release(self.btnReward);self.btnReward=nil;
_UIObject_release(self.nameBg);self.nameBg=nil;
_UIObject_release(self.progress2Txt);self.progress2Txt=nil;
_UIObject_release(self.progressBar2);self.progressBar2=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.progressTxt);self.progressTxt=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progress2);self.progress2=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.btnAdd);self.btnAdd=nil;
_UIObject_release(self.levelUpRoot);self.levelUpRoot=nil;
_UIObject_release(self.progress);self.progress=nil;
_UIObject_release(self.luzi);self.luzi=nil;
_UIObject_release(self.resetTitle);self.resetTitle=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.upRoot);self.upRoot=nil;
_UIObject_release(self.speed);self.speed=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.resetTxt);self.resetTxt=nil;
end


















function UITianDaoRongDingWin:onLoaded(...)
self:bindComponents()
self.isLianZhi=false
self.peifangId=nil
self.useItemLookup={}
self:freshBuyInfo(false)
self:addNotify(notifyConfig.onItemUse,function(...)self:onItemUse(...)end)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChange(...)end)
self:addNotify(notifyConfig.building_event,function(...)self:on_building_event(...)end)
self.winlua:SetChildCanvasGroupAlpha(self.root:getID(),0)
self:delayDo(0.2,function()
self.winlua:SetChildCanvasGroupDOFade(self.root:getID(),1,0.3)
self:freshEffect()
end)
self:freshLuziAni()
end

function UITianDaoRongDingWin:__delete()
self:unbindComponents()
end

function UITianDaoRongDingWin:onShow(argtable,afterOnloaded)
local guid=argtable.entityId
self.entityId=guid
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)
self.config=cfgHelper.get1(cfg_monijybuildconfig_get,self.bdData.build_id)
self:freshInfo()
end

function UITianDaoRongDingWin:onHide()

end





function UITianDaoRongDingWin:onAddBtn()
self:freshBuyInfo(true)
end

function UITianDaoRongDingWin:onLevelUpBtn()
if buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)then
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
else
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end
end

function UITianDaoRongDingWin:onBtnAdd()
self:onClickItem(-1)
end

function UITianDaoRongDingWin:onLianZhi()



AudioManager.playAudio(575)
self:freshEffect(true)
self:freshInfo()
end

function UITianDaoRongDingWin:onItemUse(itemid,num)
if self.useItemLookup[itemid]then
local name=itemsModel.getName(itemid)
UIManager.info(FMT.fmt('增加{0}天火值',self.useItemLookup[itemid]))
end
end

function UITianDaoRongDingWin:onMoneyChange(moneyType,lastVal,val)
if moneyType==eMoneyType.mtRongLian then
self:freshRonglianValue()
end
end

function UITianDaoRongDingWin:onClickItem(itemid)
if itemid==-1 then
UIManager:showWindow('UITianDaoRongDingPeIFangWin',{entityId=self.entityId})
else
tipsManager.showTips({itemid=itemid})
end
end

function UITianDaoRongDingWin:onPrize(id)
if id~=self.peifangId then return end
self:freshSelectItem()
self:freshLianZhiRoot()


end

function UITianDaoRongDingWin:onBtnReward()
tianDaoRongDingController.reqPrize()
end

function UITianDaoRongDingWin:on_building_event(etype,sfId,ubdId,arg1,arg2)
if self.bdData.un_build_id~=ubdId then return end
if etype==buildingEvent.buildDataChange or etype==buildingEvent.levelUpStart then
self:freshInfo()
elseif etype==buildingEvent.levelUpComplete then
self:freshInfo()
end
end

function UITianDaoRongDingWin:onSpeed()
if buildingCDControl:isComplete(buildingCDType.build,self.bdData.un_build_id)then
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
else
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end
end

function UITianDaoRongDingWin:freshInfo()
local ftype=zongmenModel:getBDFlagType(self.bdData.flag)
local islevelup=ftype==bdFlagType.levelUp
self.upRoot:setActive(islevelup)
if not islevelup then
local hasPeiFang=tianDaoRongDingModel:hasPeiFang()
if hasPeiFang then
self.peifangId=tianDaoRongDingModel:getPeiFangId()
self.isLianZhi=tianDaoRongDingModel:getLeftLianZhiTime(self.peifangId)>0
else
self.isLianZhi=false
self.peifangId=nil
end
self.effectRoot:setActive(true)
self.winlua:SetChildSpineSlotAttachment(self.luzi:getID(),'ding','ding')
self:freshLuziAni()
self:freshProgress()
self:freshLevelUpPanel()
self:freshSelectItem()
self:freshLianZhiRoot()
else
self:freshLevelUpTime()
self:freshLevelUpPanel()
self.effectRoot:setActive(false)
self.winlua:SetChildSpineSlotAttachment(self.luzi:getID(),'ding','')
self.progress2:setActive(false)
self.progress:setActive(false)
self.item1:setActive(false)
self.btnAdd:setActive(false)
self.resetTitle:setActive(false)
end
end

function UITianDaoRongDingWin:freshLevelUpTime()
local tick=function()
local cdd=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id,true)or{}
local left=cdd.cd or 0
if left<=0 then
if self.tickTimer then
self:stopTimerByID(self.tickTimer)
end
self.tickTimer=nil
self.time:setText('')
else
self.time:setText(timeHelper.format_time_stamp3(left))
end
return true
end
self.tickTimer=self:setTimer(1,0,tick)
tick()
end

function UITianDaoRongDingWin:freshProgress()
local isLianZhi=self.isLianZhi
local bdData=self.bdData
local buildid=bdData.build_id
local lv=bdData.level
local canPrize=tianDaoRongDingModel:isCanPrize()
self.progress2:setActive(not canPrize and not isLianZhi)
self.progress:setActive(not canPrize and isLianZhi)
if not isLianZhi then


local money=tianDaoRongDingModel:getMaxRonglianExp(buildid,lv)
if money==nil then
logggerUtil.logErrFMT('建筑升级表没有配置当前等级{0}的熔炼值配置',lv)
end
local moneyType=money[1]
local max=money[2]
local cur=moneyModel.getMoney(eMoneyType.mtRongLian)
self.progressBar2:animateThreeParams(cur,max,0)
self.progress2Txt:setText(FMT.fmt('{0}/{1}',cur,max))
self.resetTitle:setActive(true)
self.resetTxt:setText(FMT.fmt('每周一0点将重置为{0}点道火',max))
else
local lianzhiId=self.peifangId
local max=tianDaoRongDingModel:getLianZhiTime(lianzhiId)
local cur=tianDaoRongDingModel:getStartedLianZhiTime(lianzhiId)
local left=tianDaoRongDingModel:getLeftLianZhiTime(lianzhiId)
local cost=max-left
self.maxtime=max
self.progressBar:animateFiveParams(cost,max,max,left)
self:startLianZhiTimer(function()
if self and not self.isClose then
self:onLianZhiProgress()
end
end)
self.resetTitle:setActive(false)
end
end

function UITianDaoRongDingWin:freshLuziAni()
local canPrize=tianDaoRongDingModel:isCanPrize()
local ani=self.isLianZhi and not canPrize and eAnimationID.stand2 or eAnimationID.stand
if self.luziAni==ani then return end
self.winlua:SetChildSpineAnimation(self.luzi:getID(),ani,1,nil)
self.luziAni=ani
end

function UITianDaoRongDingWin:freshEffect(islianzhi)
local canPrize=tianDaoRongDingModel:isCanPrize()
local flag=self.isLianZhi and not canPrize and 2 or 1
if islianzhi~=nil then
flag=islianzhi==true and 2 or 1
end
if flag==2 then
self.effect:setChildShowEffect(10239,true)
self.effect2:setChildShowEffect(10240,true)
else
self.effect:setChildShowEffect(10238,true)
self.effect2:setChildShowEffect(0,false)
end
end


function UITianDaoRongDingWin:freshRonglianValue()
if self.isLianZhi then return end
local bdData=self.bdData
local buildid=bdData.build_id
local lv=bdData.level
local money=tianDaoRongDingModel:getMaxRonglianExp(buildid,lv)
if money==nil then
logggerUtil.logErrFMT('建筑升级表没有配置当前等级{0}的熔炼值配置',lv)
end
local moneyType=money[1]
local max=money[2]
local cur=moneyModel.getMoney(eMoneyType.mtRongLian)
self.progressBar2:animateThreeParams(cur,max,0)
self.progress2Txt:setText(FMT.fmt('{0}/{1}',cur,max))
end

function UITianDaoRongDingWin:freshLianZhiRoot()
local canPrize=tianDaoRongDingModel:isCanPrize()
self.btnReward:setActive(canPrize)
end

function UITianDaoRongDingWin:freshLevelUpPanel()
local canPrize=tianDaoRongDingModel:isCanPrize()
local show=not self.isLianZhi and not canPrize
self.levelUpRoot:setActive(show)
if not show then return end
self.bdLevel:setText(string.format('%s级%s',self.bdData.level,self.config.name))
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.bdData.un_build_id,true)
if cddata and cddata.complete then
self.levelUpBtnText:setText('完成升级')
return
end
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)
self.levelUpBtnText:setText(nextLvCfg~=nil and'建筑升级'or'建筑信息')
end

function UITianDaoRongDingWin:freshSelectItem()
local widget=self.item1
local isLianZhi=self.isLianZhi
local canPrize=tianDaoRongDingModel:isCanPrize()
if isLianZhi or canPrize then
local peifangId=self.peifangId
local lzcnt=tianDaoRongDingModel:getPeiFanglzcnt()
local lzitem=tianDaoRongDingModel:getLianZhiItem(peifangId)
local itemid=lzitem[1]
local cnt=lzitem[2]or 1
local tcnt=lzcnt*cnt
local item={itemid=itemid}
self.itemid=itemid
local itemcount=tcnt>1 and tcnt or''
local showCountBG=tcnt>1
local conf={showname=true,nomalname=true,itemcount=itemcount,showCountBG=showCountBG}
local prop=itemsComponentHelper.getCommonFillData(item,conf)
widget:setChildPropData(prop)
widget:setBaseItemClickEvent(function()
if not self or self.isClose then return end
self:onClickItem(itemid)
end)
else
local conf={showbg=true,showname=false,itemcount='',showCountBG=false}
local prop=itemsComponentHelper.getTempFillData(conf)
widget:setChildPropData(prop)
widget:setBaseItemClickEvent(function()
if not self or self.isClose then return end
self:onClickItem(-1)
end)
end
self.item1:setActive(true)
self.btnAdd:setActive(not isLianZhi and not canPrize)
end



function UITianDaoRongDingWin:startLianZhiTimer(callback)
self:stopLianZhiTimer()
callback()
self.lianzhiTimer=timer.new()
self.lianzhiTimer:start(1,callback)
end


function UITianDaoRongDingWin:stopLianZhiTimer()
if self.lianzhiTimer then
self.lianzhiTimer:cancel()
end
end

function UITianDaoRongDingWin:onLianZhiProgress()
local lianzhiId=self.peifangId
if lianzhiId==nil then return end
local left=tianDaoRongDingModel:getLeftLianZhiTime(lianzhiId)
local maxtime=self.maxtime
local timeStr=timeHelper.format_time_stamp11(left,true)
self.progressTxt:setText(timeStr)
if left<=0 then
self:stopLianZhiTimer()
local canPrize=tianDaoRongDingModel:isCanPrize()
if canPrize then
tianDaoRongDingController.reqPrize()
end
self:delayDo(0.5,function()
self:freshEffect(false)
self:freshInfo()
end)
end
end

function UITianDaoRongDingWin:showBuyView()
local args={}
args.titleName="道具列表"
args.pos=2
args.extraWin='UITianDaoRongDingUseWin'
local extraParams={}

args.extraParams=extraParams
UIManager:showWindow('UICommonPageWin',args)
end

function UITianDaoRongDingWin:freshBuyInfo(vis)
if vis then
self:showBuyView()
end
local list=cfgHelper.get2(cfg_tdrlbasicconfig_get,1,'itemlist')
local len=#list
self.useItemLookup={}
for i,v in ipairs(list)do
local itemid=v
local itemCfg=itemsConfig.getConfig(itemid)
local gain=itemCfg.gain or{}
local count=gain[2]or 0

self.useItemLookup[itemid]=count
end
end
