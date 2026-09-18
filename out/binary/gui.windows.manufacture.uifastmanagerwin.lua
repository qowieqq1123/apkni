







def_class("UIFastManagerWin",UIWindowBase)









function UIFastManagerWin:bindComponents()

self.root=UIObject.get(self,0)
self.manufacture=UIObject.get(self,1)
self.build=UIObject.get(self,2)
self.kongque=UIObject.get(self,3)
self.scrollviewM=UIObject.get(self,4)
self.flyEffectItem=UIObject.get(self,5)
self.scrollviewB=UIObject.get(self,6)
self.completeBtn=UIButton.get(self,7)
self.kqText=UIText.get(self,8)
self.speedUpItem=UIBaseItem.get(self,9)
self.speedUpBtn=UIButton.get(self,10)
self.flyEffect=UIObject.get(self,11)
self.viewTopPoint=UIObject.get(self,12)
self.viewBottomPoint=UIObject.get(self,13)
self.speedUpItemPanel=UIObject.get(self,14)
self.receiveBtn=UIButton.get(self,15)
self.cancelBtn=UIButton.get(self,16)
self.doghouseBtn=UIButton.get(self,17)

self.completeBtn:setButtonClick(function()self:onCompleteBtn()end)

self.speedUpBtn:setButtonClick(function()self:onSpeedUpBtn()end)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)

self.cancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.doghouseBtn:setButtonClick(function()self:onDoghouseBtn()end)



end


function UIFastManagerWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.manufacture);self.manufacture=nil;
_UIObject_release(self.build);self.build=nil;
_UIObject_release(self.kongque);self.kongque=nil;
_UIObject_release(self.scrollviewM);self.scrollviewM=nil;
_UIObject_release(self.flyEffectItem);self.flyEffectItem=nil;
_UIObject_release(self.scrollviewB);self.scrollviewB=nil;
_UIObject_release(self.completeBtn);self.completeBtn=nil;
_UIObject_release(self.kqText);self.kqText=nil;
_UIObject_release(self.speedUpItem);self.speedUpItem=nil;
_UIObject_release(self.speedUpBtn);self.speedUpBtn=nil;
_UIObject_release(self.flyEffect);self.flyEffect=nil;
_UIObject_release(self.viewTopPoint);self.viewTopPoint=nil;
_UIObject_release(self.viewBottomPoint);self.viewBottomPoint=nil;
_UIObject_release(self.speedUpItemPanel);self.speedUpItemPanel=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.cancelBtn);self.cancelBtn=nil;
_UIObject_release(self.doghouseBtn);self.doghouseBtn=nil;
end
















local _indexM={
icon=0,
name=1,
progressbar=2,
time=3,
receiveBtn=4,
gotoBtn=5,
stateBtn=6,
itemList=7,
items={8,9,10,11,12},
rwText=13,
tanhao=14,
effect=15,
rwScrollView=16,
gotoReddot=17,
}

local _indexB={
icon=0,
name=1,
progressbar=2,
time=3,
receiveBtn=4,
gotoBtn=5,
stateBtn=6,
stateBtnText=7,
rwText=8,
tanhao=9,
receiveBtnText=10,
}

local _this
local feishengtaitype=
{
[81]=true
}
local dujiezhibaotype=
{
[82]=true,
[83]=true,
[84]=true,
[85]=true,
[86]=true,
}



function UIFastManagerWin:onLoaded(...)
self:bindComponents()

_this=self
self.page=0

self.reqRewardList={}
self.rewardList={}
self.flyBtList={}
self.countDownList={}

self.receiveBtns={
[buildingCDType.plan]=self.receiveBtn,
[buildingCDType.build]=self.completeBtn,
}

self.scrollviewM:setChildScrollViewInit(0.5,true,nil,nil)
self.scrollviewB:setChildScrollViewInit(0.5,true,nil,nil)

self:addNotify(notifyConfig.building_event,self.on_building_event)
self:addNotify(notifyConfig.on_item_list_changed,self.on_item_list_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIFastManagerWin:__delete()
self.scrollviewM:setChildScrollViewStopGridCreate()
self.scrollviewB:setChildScrollViewStopGridCreate()
self:clearTimer()
self:clearDelayRefreshTimer()
_this=nil

self:unbindComponents()
end

function UIFastManagerWin.on_building_event(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.planComplete or etype==buildingEvent.liandanComplete or etype==buildingEvent.shangpuComplete then
if _this then
if _this.freshPlanGUID==bdId or _this.freshLiandanGUID==bdId then
_this:refreshEx(1)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','refreshMenuReddot',1)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk')
end
_this:showPlantRewards(bdId)
end
elseif etype==buildingEvent.buildComplete or etype==buildingEvent.levelUpComplete then
if _this then

if _this.freshGUID==bdId then
_this:refreshEx(2)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','refreshMenuReddot',1)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','refreshMenuReddot',2)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk')
end
end
elseif etype==buildingEvent.planStart then
if _this then
if _this.page==1 then
_this:refreshEx(1)
end
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','refreshMenuReddot',1)
end
elseif etype==buildingEvent.planCancel or etype==buildingEvent.planStatusChange
or etype==buildingEvent.speedUpComplete then
if _this then
if _this.page==1 then


end
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','refreshMenuReddot',1)
end
end
end




function UIFastManagerWin:onShow(argtable,afterOnloaded)
local page=1
if argtable then
page=argtable.menuPageIndex
end
self.parentWin=argtable.parentWin

self.topPointPos=self.viewTopPoint:getChildPosition()
self.bottomPointPos=self.viewBottomPoint:getChildPosition()
self.needShowFlyEffectCount=0
self.hasSpeedUpItem=false
self.speedUpItemId=nil
self.waitUseSpeedUpItemRecv=false
self.speedUpBdIndex_lookup={}
self.isUseSpeedUpItem=false


self.isInRefresh=nil
self.isNeedRefreshPage=nil
self.isxzsOpen=xiaoZhuShouController:checkXiaoZhuShouVisiable()
self.doghouseBtn:setActive(false)

local bagWuFangSpeedUpFuList=itemsLookup:getItemsByBag(item_funtion_type.wuFangSpeedUpFu)
if bagWuFangSpeedUpFuList and next(bagWuFangSpeedUpFuList)then

self.hasSpeedUpItem=true
for k,v in pairs(bagWuFangSpeedUpFuList)do
if not self.speedUpItemId then
self.speedUpItemId=v.id
else
logErr(FMT.fmt("背包中存在多种功能类型为{0}的道具 请检查数据与配置是否正确",item_funtion_type.wuFangSpeedUpFu))
break
end
end
end


if page==1 then
self:onManufactureBtn()
else
self:onBuildBtn()
end
self:countDown()

UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk')
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end
end


function UIFastManagerWin:onHide()
self:clearTimer()
self:clearDelayRefreshTimer()
end




function UIFastManagerWin:showKQPanel(bshwo,txt)
self.kongque:setActive(bshwo)
if bshwo then
self.kqText:setText(txt)
end
end

function UIFastManagerWin:refresh(page)
if self.delayFlushFreshTimer==nil then
local func=function()
if not self or self.isClose then return end
self:refreshEx(page)
self.delayFlushFreshTimer=nil
end

self.delayFlushFreshTimer=FrameTimer.New(func,1,0)
self.delayFlushFreshTimer:Start()
end
end

function UIFastManagerWin:refreshEx(page)
if page~=self.page then
return
end
self.countDownList={}
if page==1 then
self:refreshSpeedUpPanel()
self:setManufacturePanelEx()
elseif page==2 then
self:setBuildPanel()
end
end


function UIFastManagerWin:refreshManufacturePanelReddot()
if self.delayFlushReddotTimer==nil then
local func=function()
if not self or self.isClose then return end
self:refreshManufacturePanelReddotEx()
self.delayFlushReddotTimer=nil
end

self.delayFlushReddotTimer=FrameTimer.New(func,1,0)
self.delayFlushReddotTimer:Start()
end
end

function UIFastManagerWin:refreshManufacturePanelReddotEx()
if self.page~=1 then
return
end
local grids=self.scrollviewM:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.datasM[i]
self:setManufactureItem_reddot(item,data,i)
end
end

function UIFastManagerWin:refreshComplete()
self:refresh(1)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','refreshMenuReddot',1)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk')
end

function UIFastManagerWin:refreshCancel()
self:refresh(1)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','refreshMenuReddot',1)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk')
end

function UIFastManagerWin:countDown(isForceRefresh)
if self.timer then
return
end
if isForceRefresh then
self:clearTimer()
end

local fun=function()
local rpage
for k,v in pairs(self.countDownList)do
local cddata=buildingCDControl:getCDData(v.cdtype,v.data.un_build_id,true)
if not cddata then
v.sflag=2
v.item=nil
self:removeFormCountDownList(k)
rpage=v.fpage
self:setReceivebuttonShow(v.cdtype==1 and 1 or 2)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk',{un_build_id=v.data.un_build_id})
elseif cddata.complete then
v.sflag=1
v.item=nil
self:removeFormCountDownList(k)
rpage=v.fpage
self:setReceivebuttonShow(v.cdtype==1 and 1 or 2)
UIManager:invokeUIMethod('UIXiaoDaoTongMainWin','checkTalk',{un_build_id=v.data.un_build_id})
else
if cddata.isPause then
v.item:SetChildText(v.ttIndex,'已暂停')
v.item:SetChildUIProgressbar(v.pbIndex,cddata.dtime,cddata.ntime,false)
else
self:setProgressbar(v,cddata.dtime,cddata.ntime,true)
end
end
end
if rpage then
self:refresh(rpage)
end
end

self.timer=self:setTimer(1,0,fun)

fun()
end

function UIFastManagerWin:setProgressbar(v,dt,nt,anim)
v.item:SetChildText(v.ttIndex,timeHelper.format_time_stamp11(nt-dt,true))
v.item:SetChildUIProgressbar(v.pbIndex,dt,nt,anim)
end

function UIFastManagerWin:addToCountDownList(data)
local bdData=data.data
if not self.countDownList[bdData.un_build_id]then
self.countDownList[bdData.un_build_id]=data
end
end

function UIFastManagerWin:removeFormCountDownList(bdId)
self.countDownList[bdId]=nil
end

function UIFastManagerWin:getManufactureData()
local datas=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
local list={}

for k,v in pairs(datas)do
if v.flag==0 then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
local data
local cd
if cfg.win_type==sysWinType.eFangAn then
data={cfg=cfg,data=v,fpage=1,cdtype=buildingCDType.plan}
cd=buildingCDControl:getCD(buildingCDType.plan,v.un_build_id)
elseif cfg.id==SLG_SYSTEM_TYPE.eLianDanFang then
data={cfg=cfg,data=v,fpage=1,cdtype=buildingCDType.liandan}
cd=buildingCDControl:getCD(buildingCDType.liandan,v.un_build_id)
elseif cfg.id==SLG_SYSTEM_TYPE.eBingGongFang then
data={cfg=cfg,data=v,fpage=1,cdtype=buildingCDType.binggongfang}
cd=buildingCDControl:checkCD(cfg,v)
elseif cfg.win_type==sysWinType.eShangPu then
local state=UIShopControl:getShopCreateState(v)
local tabType=state==SHOP_CREATE_TYPE.eAutoFinish and FULL_TAB_TYPE.eShop or FULL_TAB_TYPE.eShopProduction
data=state~=SHOP_CREATE_TYPE.eNone and{cfg=cfg,data=v,fpage=1,cdtype=buildingCDType.shangpu,tabType=tabType}or nil
cd=buildingCDControl:getCD(buildingCDType.shangpu,v.un_build_id)
end
if data then

if cd then
data.sflag=cd>0 and 3 or 1
else
data.sflag=2
end

table.insert(list,data)
end
end
end

table.sort(list,function(a,b)
local sf1=a.sflag
local sf2=b.sflag
if sf1<sf2 then
return true
elseif sf1==sf2 then
local id1=a.cfg.id
local id2=b.cfg.id
if id1<id2 then
return true
elseif id1==id2 then
return a.data.level>b.data.level
else
return false
end
else
return false
end
end)

return list
end

function UIFastManagerWin:setManufacturePanel()
if self.delaySetManufactureTimer==nil then
local func=function()
if not self or self.isClose then return end
self:setManufacturePanelEx()
self.delaySetManufactureTimer=nil
end

self.delaySetManufactureTimer=FrameTimer.New(func,1,0)
self.delaySetManufactureTimer:Start()
end
end

function UIFastManagerWin:setManufacturePanelEx()







self.datasM=self:getManufactureData()
local len=#self.datasM
if len>0 then
self.scrollviewM:setChildScrollViewCreateGrids(len,2)
local grids=self.scrollviewM:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.datasM[i]
self:setManufactureItem(item,data,i)
end

self:showKQPanel(false)
else
self:showKQPanel(true,'暂无建筑可生产')
end
self:setReceivebuttonShow(2)







end

function UIFastManagerWin:setReceivebuttonShow(cdtype)
local num
if cdtype==2 then
num=xiaodaotongModel:getManufatureFinishNum()
else
num=xiaodaotongModel:getBuildFinishNum()
end
self.receiveBtns[cdtype]:setActive(num>0)










if num>0 then

self.cancelBtn:setActive(false)
end
if cdtype==2 then
self:checkbtnActive()
end
end

function UIFastManagerWin:refreshSpeedUpPanel()























local cdtypes={buildingCDType.plan,buildingCDType.liandan}
local cd,maxcd=buildingCDControl:countCDBytype(cdtypes)
local num=xiaodaotongModel:getManufatureFinishNum()
self.cancelBtn:setActive(cd>0 and num==0)
self.speedUpItem:setActive(false)









end

function UIFastManagerWin:checkbtnActive()
local cdtypes={buildingCDType.plan,buildingCDType.liandan}
local cd,maxcd=buildingCDControl:countCDBytype(cdtypes)
local num=xiaodaotongModel:getManufatureFinishNum()

if num>0 and cd==0 then
self:btnActive(4)
elseif num>0 and cd>0 then
self:btnActive(5)
elseif num==0 and cd>0 then
self:btnActive(2)
elseif num==0 and cd==0 then
self:btnActive(1)
end
end


function UIFastManagerWin:btnActive(flag)
if self.isxzsOpen then
if flag==1 then
self.doghouseBtn:setActive(true)
self.cancelBtn:setActive(false)
self.speedUpItemPanel:setActive(false)
self.receiveBtn:setActive(false)
elseif flag==2 then
self.doghouseBtn:setActive(false)
self.cancelBtn:setActive(true)
self.speedUpItemPanel:setActive(true)
self.receiveBtn:setActive(false)
elseif flag==3 then
self.doghouseBtn:setActive(false)
self.cancelBtn:setActive(false)
self.speedUpItemPanel:setActive(false)
self.receiveBtn:setActive(true)
elseif flag==4 then
self.doghouseBtn:setActive(true)
self.cancelBtn:setActive(false)
self.speedUpItemPanel:setActive(false)
self.receiveBtn:setActive(true)
elseif flag==5 then
self.doghouseBtn:setActive(false)
self.cancelBtn:setActive(false)
self.speedUpItemPanel:setActive(true)
self.receiveBtn:setActive(true)
elseif flag==6 then
self.doghouseBtn:setActive(false)
self.cancelBtn:setActive(false)
self.speedUpItemPanel:setActive(true)
self.receiveBtn:setActive(true)
end
end
end

function UIFastManagerWin:playPunchRotation(item,index,data)
if data.tweener then
return
end
local tweener=item:SetChildDOPunchRotation(index,Vector3(0,0,10),2,3,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
data.tweener=tweener
end

function UIFastManagerWin:stopPunchRotation(data)
if not data.tweener then
return
end
data.tweener:Rewind()
data.tweener:Kill()
data.tweener=nil
end

function UIFastManagerWin:setManufactureItem(item,data,index)



local bdData=data.data
item:SetChildIcon(_indexM.icon,data.cfg.icon,true)
if data.cfg.id==SLG_SYSTEM_TYPE.eLianDanFang or data.cfg.id==SLG_SYSTEM_TYPE.eBingGongFang then
item:SetChildText(_indexM.name,data.cfg.name)
else
item:SetChildText(_indexM.name,FMT.fmt('{0}级{1}',bdData.level,data.cfg.name))
end
local check1=data.sflag==1
local check2=data.sflag==3
local check3=data.sflag==2
item:SetChildActive(_indexM.receiveBtn,check1)
item:SetChildActive(_indexM.stateBtn,check2)
item:SetChildActive(_indexM.gotoBtn,check3)


if check1 then
item:SetChildUIProgressbar(_indexM.progressbar,1,1,false)
item:SetChildText(_indexM.time,'生产完成')
item:SetChildButtonClick(_indexM.receiveBtn,function()
local sfId=zongmenModel:getMountainId()
if data.cdtype==buildingCDType.plan then
self.freshPlanGUID=bdData.un_build_id
elseif data.cdtype==buildingCDType.liandan then
self.freshLiandanGUID=bdData.un_build_id
end

self:getPlantRewards(sfId,data)


end)

end
if check2 then
data.item=item
data.ttIndex=_indexM.time
data.pbIndex=_indexM.progressbar
local cddata=buildingCDControl:getCDData(data.cdtype,bdData.un_build_id)
self:setProgressbar(data,cddata.dtime,cddata.ntime)
self:addToCountDownList(data)
item:SetChildButtonClick(_indexM.stateBtn,function()
if isometricMapSystem:checkLinkRoad(bdData,true)then
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=bdData.build_id,args={un_build_id=bdData.un_build_id},tabType=data.tabType}})
end
end)
end
if check3 then
item:SetChildUIProgressbar(_indexM.progressbar,0,1,false)
item:SetChildText(_indexM.time,'空闲')
item:SetChildButtonClick(_indexM.gotoBtn,function()
if isometricMapSystem:checkLinkRoad(bdData,true)then


jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=bdData.build_id,args={un_build_id=bdData.un_build_id},tabType=data.tabType}})
end
end)
local reddot=zongmenModel:checkFreeManufactureBuildingReddotByUbdId(bdData.un_build_id)
item:SetChildActive(_indexM.gotoReddot,reddot)
end
item:SetChildActive(_indexM.rwScrollView,false)
if check1 or check2 then
if data.cdtype==buildingCDType.plan then
item:SetChildText(_indexM.rwText,'')
self:setManufactureRewars(item,data)
elseif data.cdtype==buildingCDType.liandan then
local cddata=buildingCDControl:getCDData(buildingCDType.liandan,bdData.un_build_id)
local cfg=cfgHelper.get1(cfg_danfangconfig_get,cddata.dfId)
if cddata.complete then
item:SetChildText(_indexM.rwText,FMT.fmt('{0}炼制完成',cfg.name))
else
item:SetChildText(_indexM.rwText,FMT.fmt('{0}正在炼制',cfg.name))
end
end
else
item:SetChildText(_indexM.rwText,'')
end

if check1 and self.isUseSpeedUpItem and self.speedUpBdIndex_lookup[bdData.un_build_id]then


item:SetChildActive(_indexM.effect,true)
local effectId="wufangspeedup_hit"
item:SetChildAnimationStringID(_indexM.effect,effectId,false)


self.speedUpBdIndex_lookup[bdData.un_build_id]=nil
else
item:SetChildActive(_indexM.effect,false)
end

if self.isUseSpeedUpItem and not next(self.speedUpBdIndex_lookup)then
self.isUseSpeedUpItem=false
end
end

function UIFastManagerWin:setManufactureItem_reddot(item,data,index)
local bdData=data.data
local check1=data.sflag==1
local check2=data.sflag==3
local check3=data.sflag==2
if check3 then
local reddot=zongmenModel:checkFreeManufactureBuildingReddotByUbdId(bdData.un_build_id)
item:SetChildActive(_indexM.gotoReddot,reddot)
end
end

function UIFastManagerWin:setManufactureRewars(item,data)

local datas=zongmenControl:getPlanStepReward(data.data,true)
local rw_percent=buildingCDControl:getPercent(buildingCDType.plan,data.data.un_build_id)
local len=#datas
local rw_count=math.floor(rw_percent*len)+1
len=math.min(rw_count,len)
len=math.min(#_indexM.items,len)
local isShow=len>0
item:SetChildActive(_indexM.rwScrollView,isShow)
if isShow then
local enableSrollView=len>=4
item:SetChildScrollRectEnable(_indexM.rwScrollView,enableSrollView)
for i=1,5 do
local v=_indexM.items[i]
if i<=len then
local rwd=datas[i]
if rwd then
item:SetChildActive(v,true)
widgetHelper.setNormalRewardItem(item,v,rwd)
else
item:SetChildActive(v,false)
end
else
item:SetChildActive(v,false)
end
end
item:SetChildAnchoredPos(_indexM.itemList,0,0)
end
end



function UIFastManagerWin:djzbSpecialHandel(_id,_flag)
local idx=_flag
local buildid=_id
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local now_rate=0
if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local refine_rate2=allcfg.refine_rate[idx]
if refine_rate2 then
local fs_data
local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local feisheng_cfg=allcfg.server_reduce_conf
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
if fs_data then
local rate=fs_data[3]
local rate2=100-rate
refine_rate2=refine_rate2*(rate2/100)
end
if now_rate>=refine_rate2 then
return true
end
end
return false
end

function UIFastManagerWin:getBuildData()
local datas=zongmenModel:getAllBuildingData(zongmenModel:getMountainId())
local list={}
for k,v in pairs(datas)do
if xiaodaotongModel:checkBuild(v)then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
local data={cfg=cfg,data=v,fpage=2,cdtype=buildingCDType.build,level=v.level}
local cd=buildingCDControl:getCD(buildingCDType.build,v.un_build_id)
if cd then
data.sflag=cd>0 and 2 or 1
table.insert(list,data)
else
if v.flag>0 then
if feishengtaitype[v.build_id]or dujiezhibaotype[v.build_id]then
if dujiezhibaotype[v.build_id]then
if self:djzbSpecialHandel(v.build_id,2)then
data.sflag=-2
table.insert(list,data)
end
else
data.sflag=-2
table.insert(list,data)
end
else
data.sflag=3
table.insert(list,data)
end
else
data.sflag=3
table.insert(list,data)
end
end
end
end
local temp=isometricMapSystem:getAllRepairData()
if temp~=nil then
for k,v in pairs(temp)do
if xiaodaotongModel:needCheckRepair(v.type)then
if zongmenModel:isAreaUnlock(v.areaId)then
if isometricMapSystem:canBuildRepair(v)then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.id)
local data={cfg=cfg,data=v,fpage=2,cdtype=nil}
if dujiezhibaotype[v.id]then
if self:djzbSpecialHandel(v.id,1)then
data.sflag=-2
table.insert(list,data)
end
elseif feishengtaitype[v.id]then
data.sflag=-2
table.insert(list,data)
else
data.sflag=-1
table.insert(list,data)
end
end
end
end
end
end

table.sort(list,function(a,b)
local sf1=a.sflag
local sf2=b.sflag
if sf1<sf2 then
return true
elseif sf1==sf2 then
local id1=a.cfg.id
local id2=b.cfg.id
if id1<id2 then
return true
elseif id1==id2 then
local a_levle=a.data.level or 0
local b_levle=b.data.level or 0
return a_levle>b_levle
else
return false
end
else
return false
end
end)

return list
end

function UIFastManagerWin:setBuildPanel()
self.datasB=self:getBuildData()
local len=#self.datasB
if len>0 then
self:showKQPanel(false)
else
self:showKQPanel(true,'暂无建筑可升级')
end
self.scrollviewB:setChildScrollViewDelayCreateGrids(len,2,0.02,1,false,false,function(index,item)
local data=self.datasB[index+1]
self:setBuildItem(item,data)
end)
self:setReceivebuttonShow(1)
end

function UIFastManagerWin:setBuildItem(item,data)



local bdData=data.data

item:SetChildIcon(_indexB.icon,data.cfg.icon,true)
local check1=data.sflag==1
local check2=data.sflag==2
local check3=data.sflag==3
local check4=data.sflag==-1
local check5=data.sflag==-2
if check4 then
item:SetChildText(_indexB.name,data.cfg.name)
else
local level=bdData.level
local name=data.cfg.name
if bdData.build_id==SLG_SYSTEM_TYPE.eShanMen and level>1 then
name="山门大阵"
level=level-1
end

item:SetChildText(_indexB.name,FMT.fmt('{0}级{1}',level,name))
end
item:SetChildActive(_indexB.receiveBtn,check1 or check4 or check5)
item:SetChildActive(_indexB.stateBtn,false)
item:SetChildActive(_indexB.gotoBtn,check2 or check3)
item:SetChildActive(_indexB.progressbar,not check4)

if check1 then
item:SetChildUIProgressbar(_indexB.progressbar,1,1,false)
local ftype=zongmenModel:getBDFlagType(bdData.flag)
local str
if ftype==bdFlagType.levelUp then
str='升级完成'
elseif ftype==bdFlagType.build then
str='建造完成'
elseif ftype==bdFlagType.sectionBuildComplete then
str='修复完成'
end
item:SetChildText(_indexB.time,str)
item:SetChildText(_indexB.receiveBtnText,'完成')
item:SetChildButtonClick(_indexB.receiveBtn,function()
local sfId=zongmenModel:getMountainId()
self.freshGUID=bdData.un_build_id
if bdData.flag==1 then
zongmenControl:reqBuildComplete(sfId,bdData.un_build_id)
else
zongmenControl:reqBuildingLevelUpComplete(sfId,bdData.un_build_id)
end
end)
item:SetChildText(_indexB.rwText,FMT.fmt('{0}{1}',data.cfg.name,bdData.flag==1 and'建造完成'or'升级完成'))

if feishengtaitype[bdData.build_id]or dujiezhibaotype[bdData.build_id]then
local flag=bdData.flag-10-1
local repair_cost=data.cfg.repair_cost or{}
local max=#repair_cost

if max>0 and flag>=0 then
local _str=FMT.fmt('{0}[{1}/{2}]{3}',data.cfg.name,flag,max,feishengtaitype[bdData.build_id]and'修筑完成'or'打造完成')
item:SetChildText(_indexB.rwText,_str)
end
end
end
if check2 then
data.item=item
data.ttIndex=_indexB.time
data.pbIndex=_indexB.progressbar
local cddata=buildingCDControl:getCDData(data.cdtype,bdData.un_build_id)
self:setProgressbar(data,cddata.dtime,cddata.ntime)
self:addToCountDownList(data)






local ftype=zongmenModel:getBDFlagType(bdData.flag)
item:SetChildButtonClick(_indexB.gotoBtn,function()


if ftype==bdFlagType.sectionBuildStart then
if feishengtaitype[bdData.build_id]or dujiezhibaotype[bdData.build_id]then
local parentWin=_this.parentWin
FeiShengTaiController.openFeiShengTaiRepairWin({2,bdData})

if parentWin then
UIManager:invokeUIMethod(parentWin,'onClickClose')
end
else
local parentWin=_this.parentWin
isometricMapSystem:moveCameraToObject(bdData.entityId,false,nil)
UIManager:showWindow('UISectionRepair',{2,bdData})
if parentWin then
UIManager:invokeUIMethod(parentWin,'onClickClose')
end
end
else
xiaodaotongModel:setBuildCallbackPage(2)
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=bdData.build_id,args={un_build_id=bdData.un_build_id}}})
end
end)
local str
if ftype==bdFlagType.levelUp then
str='升级中'
elseif ftype==bdFlagType.build then
str='建造中'
elseif ftype==bdFlagType.sectionBuildStart then
str='修复中'
end
item:SetChildText(_indexB.rwText,FMT.fmt('{0}{1}',data.cfg.name,str))
if feishengtaitype[bdData.build_id]or dujiezhibaotype[bdData.build_id]then
if ftype==bdFlagType.sectionBuildStart then
local flag=bdData.flag-10-1
local repair_cost=data.cfg.repair_cost or{}
local max=#repair_cost
if max>0 and flag>=0 then
local _str=FMT.fmt('{0}[{1}/{2}]{3}',data.cfg.name,flag,max,feishengtaitype[bdData.build_id]and'修筑中'or'打造中')
item:SetChildText(_indexB.rwText,_str)
end
end
end
end
if check3 then
item:SetChildUIProgressbar(_indexB.progressbar,0,1,false)
local ftype=zongmenModel:getBDFlagType(bdData.flag)
local str=ftype==bdFlagType.sectionBuildComplete and'可修复'or'可升级'
item:SetChildText(_indexB.time,str)
item:SetChildButtonClick(_indexB.gotoBtn,function()


if ftype==bdFlagType.sectionBuildComplete then
if feishengtaitype[bdData.build_id]or dujiezhibaotype[bdData.build_id]then
local parentWin=_this.parentWin
FeiShengTaiController.openFeiShengTaiRepairWin({2,bdData})

if parentWin then
UIManager:invokeUIMethod(parentWin,'onClickClose')
end
else
local parentWin=_this.parentWin
isometricMapSystem:moveCameraToObject(bdData.entityId,false,nil)
UIManager:showWindow('UISectionRepair',{2,bdData})
if parentWin then
UIManager:invokeUIMethod(parentWin,'onClickClose')
end
end
else
xiaodaotongModel:setBuildCallbackPage(2)
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=bdData.build_id,args={un_build_id=bdData.un_build_id}}})
end
end)
item:SetChildText(_indexB.rwText,'')
end
if check4 then
item:SetChildText(_indexB.time,'')
item:SetChildText(_indexB.receiveBtnText,'修复')
item:SetChildButtonClick(_indexB.receiveBtn,function()
if _this==nil then return end
local parentWin=_this.parentWin
local rdata=isometricMapSystem:getUnlockRepairDataByID(zongmenModel:getMountainId(),bdData.id)
if rdata then
isometricMapSystem:moveCameraToObject(rdata.guid,false,nil)
UIManager:showWindow('UIRepairWin',rdata)
if parentWin then
UIManager:invokeUIMethod(parentWin,'onClickClose')
end
end
end)
item:SetChildText(_indexB.rwText,FMT.fmt('{0}{1}',data.cfg.name,'可修复'))
end
if check5 then
item:SetChildActive(_indexB.progressbar,false)
item:SetChildText(_indexB.time,'')

local has=0
local _buildid
if bdData.build_id then
_buildid=bdData.build_id
has=1
item:SetChildText(_indexB.name,FMT.fmt('{0}级{1}',bdData.level,data.cfg.name))
elseif bdData.id then
_buildid=bdData.id
has=2
item:SetChildText(_indexB.name,data.cfg.name)
end
if _buildid then
if feishengtaitype[_buildid]then
item:SetChildText(_indexB.rwText,FMT.fmt('{0}{1}',data.cfg.name,'可修筑'))
item:SetChildText(_indexB.receiveBtnText,'修筑')
elseif dujiezhibaotype[_buildid]then
item:SetChildText(_indexB.rwText,FMT.fmt('{0}{1}',data.cfg.name,'可打造'))
item:SetChildText(_indexB.receiveBtnText,'打造')
end
item:SetChildButtonClick(_indexB.receiveBtn,function()
if _this==nil then return end
local parentWin=_this.parentWin
if has==1 then
FeiShengTaiController.openFeiShengTaiRepairWin({2,bdData})

elseif has==2 then
local rdata=isometricMapSystem:getUnlockRepairDataByID(zongmenModel:getMountainId(),_buildid)
if rdata then
FeiShengTaiController.openFeiShengTaiRepairWin({1,rdata})

end
end
if parentWin then
UIManager:invokeUIMethod(parentWin,'onClickClose')
end
end)
end
end
end



function UIFastManagerWin:addDanYaoRewards(ubdId,rewards)
local temp={}
for i,v in ipairs(rewards)do
table.insert(temp,{v.itemid,v.num})
end
self.reqRewardList[ubdId]=temp
end

function UIFastManagerWin:addShangPuRewards(ubdId,rewards)
local temp={}
for i,v in ipairs(rewards)do
table.insert(temp,{v.itemid,v.num})
end
self.reqRewardList[ubdId]=temp
end

function UIFastManagerWin:combineReceivePlantRewards(sfId,data,combineCfg,combineData)
local bdData=data.data
if emergenciesModel:isCreeper(bdData.un_build_id)then
UIManager.info('缠绕中无法使用')
return false
end

local addReceive=function(typo)
if combineCfg[typo]==nil then combineCfg[typo]={}end
if combineData[typo]==nil then combineData[typo]={}end
local cfg=combineCfg[typo]
local data=combineData[typo]
data[#data+1]=bdData.un_build_id
if typo==1 then
if cfg.fun==nil then
cfg.fun=function()
local ubuilds=combineData[typo]
if#ubuilds>0 then
zongmenControl:reqGetPlantRewardsEx(sfId,#ubuilds,ubuilds)
end
end
end
elseif typo==2 then
if cfg.fun==nil then
cfg.fun=function()
local ubuilds=combineData[typo]
for i,v in ipairs(ubuilds)do
UIDanYaoController:req_danYao_reward(sfId,v)
end
end
end
elseif typo==3 then
if cfg.fun==nil then
cfg.fun=function()
local ubuilds=combineData[typo]
for i,v in ipairs(ubuilds)do
local _bdData=zongmenModel:getBuildingData(v)
local state=UIShopControl:getShopCreateState(_bdData)
if state==SHOP_CREATE_TYPE.eFinish then
UIShopControl.Req_9_16(v)
elseif state==SHOP_CREATE_TYPE.eAutoFinish then
UIShopControl:reqAutoCreateRecv(v)
end
end
end
end
end
end

if data.cdtype==buildingCDType.plan then
local ret,errParam=zongmenControl:checkWarehouse(bdData)
local param
if ret then
addReceive(1)
local datas=zongmenControl:getPlanStepReward(data.data,true)
self.reqRewardList[bdData.un_build_id]=datas
else


local item=errParam.item
if item then
param={isFull=true,item=item,ubdId=bdData.un_build_id}
end
end
return ret,param
elseif data.cdtype==buildingCDType.liandan then
addReceive(2)
self.reqRewardList[bdData.un_build_id]={}
return true
elseif data.cdtype==buildingCDType.shangpu then
addReceive(3)
self.reqRewardList[bdData.un_build_id]={}
return true
end
return false
end

function UIFastManagerWin:getPlantRewards(sfId,data)
local bdData=data.data
if emergenciesModel:isCreeper(bdData.un_build_id)then
UIManager.info('缠绕中无法使用')
return false
end
if data.cdtype==buildingCDType.plan then
local ret=zongmenControl:getPlantRewards(sfId,bdData)
if ret then

local datas=zongmenControl:getPlanStepReward(data.data,true)
self.reqRewardList[bdData.un_build_id]=datas
end
return ret
elseif data.cdtype==buildingCDType.liandan then
UIDanYaoController:req_danYao_reward(sfId,bdData.un_build_id)

self.reqRewardList[bdData.un_build_id]={}
return true
elseif data.cdtype==buildingCDType.binggongfang then
bingGongChangController.req_6_96()
self.reqRewardList[bdData.un_build_id]={}
return true
elseif data.cdtype==buildingCDType.shangpu then
local state=UIShopControl:getShopCreateState(bdData)
if state==SHOP_CREATE_TYPE.eFinish then
UIShopControl.Req_9_16(bdData.un_build_id)
elseif state==SHOP_CREATE_TYPE.eAutoFinish then
UIShopControl:reqAutoCreateRecv(bdData.un_build_id)
end
self.reqRewardList[bdData.un_build_id]={}
return true
end
return false
end

function UIFastManagerWin:showPlantRewards(ubdId)
local datas=self.reqRewardList[ubdId]
if datas then
for i,v in ipairs(datas)do
local num=self.rewardList[v[1]]or 0
num=num+v[2]
self.rewardList[v[1]]=num
end
end
self.reqRewardList[ubdId]=nil
if not next(self.reqRewardList)then
local tempRewardlist={}
for k,v in pairs(self.rewardList)do
showPrizeControl.insertTemp(tempRewardlist,nil,k,v)
end
showPrizeControl.showWindow(tempRewardlist)
self.rewardList={}
end
end

function UIFastManagerWin:onReceiveBtn()
local combineCfg={}
local combineData={}
local sfId=zongmenModel:getMountainId()
local cangKuFullData
for i,v in ipairs(self.datasM)do
if v.sflag==1 then
local ret,param=self:combineReceivePlantRewards(sfId,v,combineCfg,combineData)
if ret then

if v.cdtype==buildingCDType.liandan then
self.freshLiandanGUID=v.data.un_build_id
elseif v.cdtype==buildingCDType.plan then
self.freshPlanGUID=v.data.un_build_id
end
elseif param and param.isFull then
local item=param.item
local itemId=item[1]
local itemCount=item[2]
local ubdId=param.ubdId
if not cangKuFullData then
cangKuFullData={}
cangKuFullData.itemList={}
cangKuFullData.ubdIdList={}
end
if cangKuFullData.itemList[itemId]then
cangKuFullData.itemList[itemId]=cangKuFullData.itemList[itemId]+itemCount
else
cangKuFullData.itemList[itemId]=itemCount
end
table.insert(cangKuFullData.ubdIdList,ubdId)
end
end
end
for k,v in pairs(combineData)do
local cfg=combineCfg[k]
cfg.fun()
end

if cangKuFullData then
local itemList={}
for itemId,itemCount in pairs(cangKuFullData.itemList)do
itemList[#itemList+1]={itemId,itemCount}
end
local ubdIdList=cangKuFullData.ubdIdList
local notSolutionCallback=function()
if#ubdIdList>0 then
zongmenControl:reqGetPlantRewardsEx(sfId,#ubdIdList,ubdIdList)
end
end
cangkuFullSolutionController:showCangKuFullSolutionByItemList(itemList,notSolutionCallback)
end
end

function UIFastManagerWin:onCompleteBtn()
local sfId=zongmenModel:getMountainId()
for i,v in ipairs(self.datasB)do
if v.sflag==1 then
self.freshGUID=v.data.un_build_id
if v.data.flag==1 then
zongmenControl:reqBuildComplete(sfId,v.data.un_build_id)
else
zongmenControl:reqBuildingLevelUpComplete(sfId,v.data.un_build_id)
end
end
end
end

function UIFastManagerWin:onCancelBtn()
local list={}
local buildIdList={}
local sfId=zongmenModel:getMountainId()
local types={buildingCDType.plan,buildingCDType.liandan}
for i,v in ipairs(types)do
local datas=buildingCDControl:getCDTypeDatas(v)
for kk,vv in pairs(datas)do
if vv.cd>0 then
table.insert(list,{i,sfId,vv.bdData.un_build_id})

if not buildIdList[vv.bdData.build_id]then
buildIdList[vv.bdData.build_id]=vv.bdData.build_id
end
end
end
end
if#list==0 then
return
end

local buildNameStr=nil
local buildLen=0
for i,buildId in pairs(buildIdList)do
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildId)
if not buildNameStr then
buildNameStr=cfg.name
else
buildNameStr=FMT.fmt('{0}、{1}',buildNameStr,cfg.name)
end
buildLen=buildLen+1
end
if buildLen>1 then
buildNameStr=FMT.fmt('{0}等建筑的',buildNameStr)
end

local callback=function()
if _this==nil then return end
if#list>0 then
zongmenControl:reqCancel(list)
else
UIManager.error('无生产中建筑')
end
end
local flag=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eBatchCancelPlant)
if not flag then
local showdata=
{
type='UIDialougeBatchCancelPlant',
title='提示',
content=FMT.fmt('是否取消{0}生产？\n<color=#ca631d>(已完成的生产的资源会自动收取，未完成的则会退还材料)</color>',buildNameStr),
canceltext=nil,
oktext='确认取消',
allowclickBG=true,
okcallback=callback,
choosetext='今日不再提示',
choosecallback=function(flag)
dialogueRepeatRemindModel.setRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eBatchCancelPlant,flag)
end,

showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
else
callback()
end
end

function UIFastManagerWin:onSpeedUpBtn()
























UIManager:showWindow('UISpeedUpUseWin')
end

function UIFastManagerWin:onManufactureBtn()
self.manufacture:setActive(true)
self.build:setActive(false)
self.page=1
self:refreshEx(self.page)
end

function UIFastManagerWin:onBuildBtn()
self.manufacture:setActive(false)
self.build:setActive(true)
self.page=2
self:refreshEx(self.page)
end

function UIFastManagerWin.on_item_list_changed(argstable)
if not argstable or not _this then
return
end

for i,v in ipairs(argstable)do
local itemid=v[3]
if itemsLookup:checkItemFuncType(itemid,item_funtion_type.wuFangSpeedUpFu)then
local lastCount=v[4]
local nowItemCount=v[5]
if nowItemCount>0 then
_this.speedUpItemId=itemid
_this.hasSpeedUpItem=true
else
_this.speedUpItemId=nil
_this.hasSpeedUpItem=false
end
_this.isUseSpeedUpItem=_this.waitUseSpeedUpItemRecv and lastCount>nowItemCount
_this.waitUseSpeedUpItemRecv=false


return _this:countDown(true)
end
end
end

function UIFastManagerWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end


function UIFastManagerWin:onDoghouseBtn()
if systemModel.isOpen(SYSTEM_DEFINE.eBatch)then
xianChongControl:showFastManufactureWin()
else
UIManager.info('系统暂未开启')
end
end


function UIFastManagerWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UIFastManagerWin:clearDelayRefreshTimer()
if self.delayRefreshTimer then
self:stopTimerByID(self.delayRefreshTimer)
self.delayRefreshTimer=nil
end
end


function UIFastManagerWin:playFlyEffect(index,un_build_id)

local item=self.scrollviewM:getChildScrollViewItemWidget(index-1)
local pos=item:GetChildPosition(_indexM.effect)

if pos.y<self.bottomPointPos.y or pos.y>self.topPointPos.y then

return
end

local oX,oY,eX,eY
if index%2==0 then

oX=-2
oY=-1
eX=-2
eY=0
else

oX=0
oY=0
eX=-1
eY=0
end

self.flyEffectItem:setActive(true)

local cloneTarget=self.flyEffectItem:getID()
local cloneParent=self.UIFastManagerWin:getID()
local argsTable={index,un_build_id}
local stateId=0
local initData=
{
widget=self.winlua,
cloneParent=cloneParent,
cloneTarget=cloneTarget,

endPos=pos,
oSlider=Vector2.New(oX or 0,oY or 0),
eSlider=Vector2.New(eX or 0,eY or 0),
rate=0.01,
stateId=stateId,
flyTime=1,
winName='UIFastManagerWin',
finishClone='finishClone',
beforeDestory='beforeDestory',
finishBehavior='finishBehavior',
beforeDestoryWaitTime=0.8,
autoPlayEffect=true,
args=argsTable,
}
if self.needShowFlyEffectCount<=0 then

self.scrollviewM:setChildScrollRectEnable(false)
self.cloneCount=0
end
self.needShowFlyEffectCount=self.needShowFlyEffectCount+1
self.cloneCount=self.cloneCount+1
self.flyBtList[index]=behaviorManager:addBehaviorTree('bt_ui_fly_effect',nil,true,initData)
self.flyBtList[index]:setUpdateInterval(0.02)


end

function UIFastManagerWin:finishClone(index,un_build_id)
self.cloneCount=self.cloneCount-1
if self.cloneCount<=0 then
self.flyEffectItem:setActive(false)
end
end

function UIFastManagerWin:finishBehavior(index,un_build_id)


if self.flyBtList[index]then
behaviorManager:removeBehaviorTree(self.flyBtList[index])
end
self.flyBtList[index]=nil
end

function UIFastManagerWin:beforeDestory(index,un_build_id)
local item=self.scrollviewM:getChildScrollViewItemWidget(index-1)
item:SetChildActive(_indexM.effect,true)
local effectId="wufangspeedup_hit"
item:SetChildAnimationStringID(_indexM.effect,effectId,false)

self.needShowFlyEffectCount=self.needShowFlyEffectCount-1
if self.needShowFlyEffectCount<=0 then
self.needShowFlyEffectCount=0

self.scrollviewM:setChildScrollRectEnable(true)
end
end

function UIFastManagerWin:getTalkList(args)
if self.page==1 then
local data=self.datasM[1]
if data then
local state_
if data.sflag==2 then

state_=0
elseif data.sflag==3 then

state_=1
elseif data.sflag==1 then

state_=2
end
return xiaodaotongModel:getTalkList_2(data.cfg.build_type,state_)
end
elseif self.page==2 then
local data=self.datasB[1]
if data then
if args==nil or args.un_build_id==data.data.un_build_id then
local state_
if data.sflag==3 then

state_=0
elseif data.sflag==2 then

state_=1
elseif data.sflag==1 then

state_=2
elseif data.sflag==-1 then

state_=4
end
return xiaodaotongModel:getTalkList_2(0,state_)
end
else
return xiaodaotongModel:getTalkList_2(0,3)
end
end
return nil
end

function UIFastManagerWin.on_money_changed(moneyType,lastVal,val)
if _this and _this.page==1 then
_this:refreshManufacturePanelReddot()
end
end
