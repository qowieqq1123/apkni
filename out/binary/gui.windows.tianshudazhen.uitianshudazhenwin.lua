







def_class("UITianShuDaZhenWin",UIWindowBase)









function UITianShuDaZhenWin:bindComponents()

self.addtion=UIText.get(self,0)
self.baohuTime=UIText.get(self,1)
self.btnBuChong=UIButton.get(self,2)
self.btnDetail=UIButton.get(self,3)
self.btnEditor=UIButton.get(self,4)
self.btnLog=UIButton.get(self,5)
self.btnSelect=UIButton.get(self,6)
self.btnTips=UIButton.get(self,7)
self.btnUp=UIButton.get(self,8)
self.btnUpFinish=UIButton.get(self,9)
self.btnUping=UIButton.get(self,10)
self.btnUpingTxt=UIText.get(self,11)
self.btnXiJie=UIButton.get(self,12)
self.btnXiushi=UIButton.get(self,13)
self.btnYuanJun=UIButton.get(self,14)
self.buChongRoot=UIObject.get(self,15)
self.canOpenRoot=UIObject.get(self,16)
self.canOpenTitle=UIText.get(self,17)
self.disableRoot=UIObject.get(self,18)
self.discipleScrollView=UIObject.get(self,19)
self.fight=UIText.get(self,20)
self.fzCreator=UIObject.get(self,21)
self.leftOpenTime=UIText.get(self,22)
self.level=UIText.get(self,23)
self.maxRoot=UIObject.get(self,24)
self.model=UIObject.get(self,25)
self.moneyIcon=UIObject.get(self,26)
self.moneyRoot=UIObject.get(self,27)
self.moneyValue=UIText.get(self,28)
self.num=UIText.get(self,29)
self.openningRoot=UIObject.get(self,30)
self.progressBar=UIProgressBarAni.get(self,31)
self.progressCount=UIText.get(self,32)
self.root=UIObject.get(self,33)
self.selectRoot=UIObject.get(self,34)
self.shipName=UIText.get(self,35)
self.teamRoot=UIObject.get(self,36)
self.tipsBottom=UIObject.get(self,37)
self.tipsRoot=UIObject.get(self,38)
self.tipsTx=UIText.get(self,39)
self.upReddot=UIObject.get(self,40)
self.yzModel=UIObject.get(self,41)

self.btnBuChong:setButtonClick(function()self:onBtnBuChong()end)

self.btnDetail:setButtonClick(function()self:onBtnDetail()end)

self.btnEditor:setButtonClick(function()self:onBtnEditor()end)

self.btnLog:setButtonClick(function()self:onBtnLog()end)

self.btnSelect:setButtonClick(function()self:onBtnSelect()end)

self.btnTips:setButtonClick(function()self:onBtnTips()end)

self.btnUp:setButtonClick(function()self:onBtnUp()end)

self.btnUpFinish:setButtonClick(function()self:onBtnUpFinish()end)

self.btnUping:setButtonClick(function()self:onBtnUping()end)

self.btnXiJie:setButtonClick(function()self:onBtnXiJie()end)

self.btnXiushi:setButtonClick(function()self:onBtnXiushi()end)

self.btnYuanJun:setButtonClick(function()self:onBtnYuanJun()end)



end


function UITianShuDaZhenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addtion);self.addtion=nil;
_UIObject_release(self.baohuTime);self.baohuTime=nil;
_UIObject_release(self.btnBuChong);self.btnBuChong=nil;
_UIObject_release(self.btnDetail);self.btnDetail=nil;
_UIObject_release(self.btnEditor);self.btnEditor=nil;
_UIObject_release(self.btnLog);self.btnLog=nil;
_UIObject_release(self.btnSelect);self.btnSelect=nil;
_UIObject_release(self.btnTips);self.btnTips=nil;
_UIObject_release(self.btnUp);self.btnUp=nil;
_UIObject_release(self.btnUpFinish);self.btnUpFinish=nil;
_UIObject_release(self.btnUping);self.btnUping=nil;
_UIObject_release(self.btnUpingTxt);self.btnUpingTxt=nil;
_UIObject_release(self.btnXiJie);self.btnXiJie=nil;
_UIObject_release(self.btnXiushi);self.btnXiushi=nil;
_UIObject_release(self.btnYuanJun);self.btnYuanJun=nil;
_UIObject_release(self.buChongRoot);self.buChongRoot=nil;
_UIObject_release(self.canOpenRoot);self.canOpenRoot=nil;
_UIObject_release(self.canOpenTitle);self.canOpenTitle=nil;
_UIObject_release(self.disableRoot);self.disableRoot=nil;
_UIObject_release(self.discipleScrollView);self.discipleScrollView=nil;
_UIObject_release(self.fight);self.fight=nil;
_UIObject_release(self.fzCreator);self.fzCreator=nil;
_UIObject_release(self.leftOpenTime);self.leftOpenTime=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.maxRoot);self.maxRoot=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.moneyValue);self.moneyValue=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.openningRoot);self.openningRoot=nil;
_UIObject_release(self.progressBar);self.progressBar=nil;
_UIObject_release(self.progressCount);self.progressCount=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectRoot);self.selectRoot=nil;
_UIObject_release(self.shipName);self.shipName=nil;
_UIObject_release(self.teamRoot);self.teamRoot=nil;
_UIObject_release(self.tipsBottom);self.tipsBottom=nil;
_UIObject_release(self.tipsRoot);self.tipsRoot=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.upReddot);self.upReddot=nil;
_UIObject_release(self.yzModel);self.yzModel=nil;
end

















local _dzItemCmpIndex=
{
name=0,
fight=1,
stateName=2,
head=3,
color=4,
job=5,
mask=6,
root=7,
stateImg=8,
self=9,
panel=10,
state=11,
tianminObj=12,
banFlag=13,
ban=14,
leaderFlag=15,
spDzFlag=16,
}

local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'
local diziabname='ui/windows/disciple/sharedtextures/uidisciplecolorframeicons.ab'
local ColorToFrame={
[eQualityColor.eGreen]='frame_dzkplvse',
[eQualityColor.eBlue]='frame_dzkplanse',
[eQualityColor.ePurple]='frame_dzkpzise',
[eQualityColor.eOrange]='frame_dzkpchengse',
[eQualityColor.eRed]='frame_dzkphongse',
}

function UITianShuDaZhenWin:onLoaded(...)
self:bindComponents()
self:delayDo(0.2,function()
self.widget:SetChildCanvasGroupDOFade(self.root:getID(),1,0.3)
end)
self:addNotify(notifyConfig.onTianShuDaZhen_fangyuzhi_change,function(...)
self:onFYZchange(...)
end)
self:addNotify(notifyConfig.building_event,function(...)
self:on_building_event(...)
end)
self:addNotify(notifyConfig.on_money_changed,function(...)
self:onMoneyChanged(...)
end)
self.sfId=mapIdType.fort
self.bdData=tianshudazhenModel:getBuildData()
self.model:setChildUIModelShowTarget(5742,1,{},eAnimationID.stand,false,false,false,function()
self.loadModel=true
if self and not self.isClose then
self:freshXianJieBtn()
end
end)
self.useBuffTimer={}
self:showWindow('UITopMoneyWin',{{eMoneyType.mtLingYu},{eMoneyType.mtXianYu}})
end

function UITianShuDaZhenWin:__delete()
self:unbindComponents()
end

function UITianShuDaZhenWin:onShow(argtable,afterOnloaded)
self.soldierSortOrder=tianshudazhenModel:getSoldierSortOrder()
self:refreshInfo()
if argtable then
if argtable.type==1 then

self:onBtnUp()
end
end
end

function UITianShuDaZhenWin:onHide()

end





function UITianShuDaZhenWin:onBtnBuChong()
if tianshudazhenModel:isDoingUp()then
UIManager.error('天枢大阵升级中')
return
end

if tianshudazhenModel:isBuyMaxHDZTimes()then
UIManager.error('本周购买次数已用完')
return
end

local ret,typo,v=tianshudazhenModel:isCanBuChongHuDun()
if not ret then
if typo==1 then
local itemid=v[1]
local need=v[2]
local name=itemsConfig.getItemName(v[1])



local getDescFunc=function(uselist)
local itemName=itemsConfig.getColorName(itemid)
local s=fastBuyController.getCostDescWithIcon(uselist)
local str=FMT.fmt('缺少<color=#549327>{1}</color>枚{0}，是否花费{2}购买？',itemName,need,s)
return str
end
local call=function()
local index=tianshudazhenModel:getNextBuyHDZTimes()
tianshudazhenController.reqReconverHudun(index)
end
fastBuyController:checkUse4(itemid,need,call,getDescFunc,nil,true)

elseif typo==2 then
UIManager.error('防护值已满')
end
return
end
local index=tianshudazhenModel:getNextBuyHDZTimes()
tianshudazhenController.reqReconverHudun(index)
end



function UITianShuDaZhenWin:onBtnEditor()
self:onBtnSelect()
end

function UITianShuDaZhenWin:onBtnXiushi()
local callback=function(sortOrder)
self.soldierSortOrder=sortOrder
tianshudazhenController.reqSetTeam(self.yzid,self.dzlist,self.soldierlist,sortOrder)
end
local sortOrder=tianshudazhenModel:getSoldierSortOrder()
self:showWindow('UITianShuDaZhenSettingWin',{callback=callback,sortOrder=sortOrder})
end

function UITianShuDaZhenWin:onBtnLog()

xianjieController:OpenXianjieResourceLog(true)
end



function UITianShuDaZhenWin:onBtnSelect()
local soldierSortOrder=self.soldierSortOrder
local func=function(dzlist,soldierlist,yzid)
tianshudazhenController.reqSetTeam(yzid,dzlist,soldierlist,soldierSortOrder)
end
local soldierlist=tianshudazhenModel:getCurSoldiersSetting()or{}

local enough=true
for i,v in ipairs(soldierlist)do
local moneytype=v[1]
local cnt=v[2]
if not moneyModel.checkEnoughMoney(moneytype,cnt)then
enough=false
break
end
end
local moneylookup={}
if not enough then
for i,v in ipairs(soldierlist)do
local id=yunjiayingModel:getSoldierLevelByMoneyType(v[1])
moneylookup[id]=0
end
UIManager.info('协防修士不足，请重新设置')
else
for i,v in ipairs(soldierlist)do
local id=yunjiayingModel:getSoldierLevelByMoneyType(v[1])
moneylookup[id]=v[2]
end
end

local defdzlist
local isAutoSetFirstTeam
if not self.dzlist then
local needFlag,list=xianjieModel:checkSetXJIsHasFirstTeam()
if needFlag then
defdzlist=list
isAutoSetFirstTeam=true
else
defdzlist=tianshudazhenModel:getTop5Disciple()
end


end
local yzid
if not self.yzid then
yzid=1
end
UIFullFightPrepareControl:showXJYunZhouBuZhenWindowEx({
callback=func,
isIgnoreCheckFreeTeam=true,
isIgnoreCheckCost=true,
isCheckYBDData=false,
selectYzIndex=self.yzid or yzid,
defaultDzList=self.dzlist or defdzlist,
minSoldierNum=1,
isOnlyEditTeam=true,
defaultSoldierList=moneylookup,
minDzNum=1,
maxDzNum=5,
confirmBtnStr='设置守军',
cancelCallBack=function()
UIFullTianShuDaZhenControl:showMainWindow()
end,
isIgnoreYzOccupy=true,

isAutoSetFirstTeam=isAutoSetFirstTeam,
})
end



function UITianShuDaZhenWin:onBtnUp()
local attrs={}
local level=self.bdData.level
local tsdzCfg=tianshudazhenConfig.getTianshudazhenconfig(level)

local hdzValue=tsdzCfg.shield
local curAttrs=tsdzCfg.attr

local next_tsdz_cfg=tianshudazhenConfig.getTianshudazhenconfig(level+1)
local nexthdzValue=next_tsdz_cfg and next_tsdz_cfg.shield or hdzValue
local nextAttrs=next_tsdz_cfg and next_tsdz_cfg.attr or curAttrs

attrs[#attrs+1]={name='建筑等级',old=level,new=level+1}

attrs[#attrs+1]={name='护盾值上限',old=hdzValue,new=nexthdzValue}

for i,v in ipairs(curAttrs)do
local name,val=equipsHelper.getAttr(v[1],v[2])
local nextAttr=nextAttrs[i]
local name,nextVal=equipsHelper.getAttr(nextAttr[1],nextAttr[2])
attrs[#attrs+1]={name=name,old=val,new=nextVal}
end
local winParams={}
winParams.level=level

local data=
{
bdData=self.bdData,
winName='UITianShuDaZhenInfoWin',
winParams=winParams,
attrs=attrs,
}
self:showWindow('UIBaoLeiBuildingUpWin',data)
end

function UITianShuDaZhenWin:freshUpWindow()
local attrs={}
local level=self.bdData.level
local tsdzCfg=tianshudazhenConfig.getTianshudazhenconfig(level)

local hdzValue=tsdzCfg.shield
local curAttrs=tsdzCfg.attr

local next_tsdz_cfg=tianshudazhenConfig.getTianshudazhenconfig(level+1)
local nexthdzValue=next_tsdz_cfg and next_tsdz_cfg.shield or hdzValue
local nextAttrs=next_tsdz_cfg and next_tsdz_cfg.attr or curAttrs

attrs[#attrs+1]={name='建筑等级',old=level,new=level+1}

attrs[#attrs+1]={name='护盾值上限',old=hdzValue,new=nexthdzValue}

for i,v in ipairs(curAttrs)do
local name,val=equipsHelper.getAttr(v[1],v[2])
local nextAttr=nextAttrs[i]
local name,nextVal=equipsHelper.getAttr(nextAttr[1],nextAttr[2])
attrs[#attrs+1]={name=name,old=val,new=nextVal}
end

UIManager:callWindowFunc('UIBaoLeiBuildingUpWin','refreshInfo',attrs)
UIManager:callWindowFunc('UITianShuDaZhenInfoWin','refreshInfo')
end

function UITianShuDaZhenWin:onBtnUpFinish()
zongmenControl:reqBuildingLevelUpComplete(mapIdType.fort,self.bdData.un_build_id)
end



function UITianShuDaZhenWin:onBtnUping()
self:onBtnUp()
end



function UITianShuDaZhenWin:onBtnXiJie()
self.tipsRoot:setActive(true)
self.showTipsRoot=true
self:refreshTipsPanel()
self:refreshTipsBottom()
end



function UITianShuDaZhenWin:onBtnYuanJun()
self:showWindow('UIYingXianGeWDYJWin')
end

function UITianShuDaZhenWin:onBtnTips()
self.tipsRoot:setActive(false)
self.showTipsRoot=false
end

function UITianShuDaZhenWin:onBtnDetail()
self:showWindow('UITianShuDaZhenSoliderInfoWin')
end

function UITianShuDaZhenWin:refreshInfo()
self:refreshTop()

self:refreshMiddle()

self:refreshUpInfo()

self:freshXianJieBtn()
end

function UITianShuDaZhenWin:refreshTop()
local isZhuShouTeam=tianshudazhenModel:isZhuShouTeam()
self.selectRoot:setActive(not isZhuShouTeam)
self.teamRoot:setActive(isZhuShouTeam)

if not isZhuShouTeam then
self:refreshSelectInfo()
else
self:refreshTeamInfo()
end
end

function UITianShuDaZhenWin:refreshMiddle()
local max=tianshudazhenModel:getMaxHDZValue()
local cur=tianshudazhenModel:getHudunValue()
self.progressBar:animateThreeParams(cur*100,max*100,0)
self.progressCount:setText(FMT.fmt('{0}/{1}',cur,max))

local isBuyMax=tianshudazhenModel:isBuyMaxHDZTimes()
self.buChongRoot:setActive(not isBuyMax)
if not isBuyMax then
local recover=tianshudazhenConfig.getHuDunValueCost()
local times=tianshudazhenModel:getNextBuyHDZTimes()
local costTable=recover[times]or recover[#recover]
local hasCost=#costTable>0
self.moneyRoot:setActive(hasCost)
if hasCost then
local cost=costTable[1]
local itemid=cost[1]
local num=cost[2]
self.moneyIcon:setIcon(iconHelper.getIconName(itemid),false)
self.moneyValue:setText(num)
end
end
end

function UITianShuDaZhenWin:refreshUpInfo(refresh)
local isDoingUp=tianshudazhenModel:isDoingUp()
local isMax=tianshudazhenModel:isMaxLevel()
local isCanUpFinish=tianshudazhenModel:isCanUpFinish()
local isCanUpLevel=tianshudazhenModel:isCanUpLevel()
self.btnUping:setActive(not isMax and isDoingUp and not isCanUpLevel)
self.btnUp:setActive(not isMax and not isDoingUp)
self.upReddot:setActive(isCanUpLevel and not isDoingUp or isCanUpFinish)
self.maxRoot:setActive(isMax)

self.level:setText(FMT.fmt('{0}级天枢大阵',tianshudazhenModel:getLevel()))
if self.upTimer then
self:stopTimerByID(self.upTimer)
self.upTimer=nil
end
if isDoingUp then
local tick=function()
local left=tianshudazhenModel:getLeftUpTime()
if left>0 then
local leftStr=timeHelper.format_time_stamp(left)
self.btnUpingTxt:setText(leftStr)
else
self.btnUping:setActive(isDoingUp)
self.btnUp:setActive(not isDoingUp)
if not refresh then
self:refreshUpInfo(true)
end
end
end

self.upTimer=self:setTimer(1,0,tick)
tick()
end
end

function UITianShuDaZhenWin:refreshSelectInfo()

end

function UITianShuDaZhenWin:refreshTeamInfo()
local data=tianshudazhenModel:getYunZhouSetData()
if data==nil then return end
local soldierCountList,allSoldierCount=yunjiayingModel:getSoldierCount(xjSoldierHurtType.eHealthy,self.extraSoldierList)
local dzlist=data.dzlist
self.dzlist={}
for _,dzguid in ipairs(dzlist)do
local netdata=UIDiscipleModel:getDiscipleData(dzguid)
if netdata then
self.dzlist[#self.dzlist+1]=dzguid
end
end
self.yzid=data.yzid

self.soldierlist=data.soldierlist
local soldierCnt=0
for i,v in ipairs(data.soldierlist)do
soldierCnt=soldierCnt+v[2]
end
self.soldierCnt=soldierCnt

soldierCnt=math.min(soldierCnt,allSoldierCount)
self.num:setText(FMT.fmt('军阵修士:{0}',mathHelper.formatNumber3(self.soldierCnt)))

local dzCount=#self.dzlist
self.discipleScrollView:setChildScrollViewCreateGrids(dzCount,dzCount)
local grids=self.discipleScrollView:getChildScrollViewItemWidgets()
local totalFightValue=0
for i=1,dzCount do
local widget=grids[i-1]
local dzguid=self.dzlist[i]
local netdata=UIDiscipleModel:getDiscipleData(dzguid)

widget:SetChildText(_dzItemCmpIndex.name,UIDiscipleModel:getDiscipleName(dzguid))

local fightValue=UIDiscipleModel:getDiscipleFightValue(dzguid)
totalFightValue=totalFightValue+fightValue
widget:SetChildText(_dzItemCmpIndex.fight,FMT.fmt('<color=#7d3b17>战</color> {0}',fightValue))

widget:SetChildActive(_dzItemCmpIndex.state,false)

comHelper.setChildModelRawImage(widget,dzguid,_dzItemCmpIndex.head,0,eHeadCenterType.eHalf)

local color=UIDiscipleModel:getDiscipleColor(dzguid)
widget:SetChildCSImageSprite(_dzItemCmpIndex.color,diziabname,ColorToFrame[color])

local jobIcon=UIDiscipleModel:getJobIconNameX(dzguid)
widget:SetChildCSImageSprite(_dzItemCmpIndex.job,globalab,jobIcon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(dzguid)
widget:SetChildActive(_dzItemCmpIndex.spDzFlag,isSpDz)

UIDiscipleController.refreshCommonItemTianMing(widget,netdata,_dzItemCmpIndex.tianminObj)

widget:SetChildActive(_dzItemCmpIndex.leaderFlag,false)


widget:SetChildButtonClick(_dzItemCmpIndex.panel,function()
if not self or self.isClose then return end
self:onBtnEditor()
end)
end

local yzCfg=cfg_fairylandboatconfig_get(self.yzid)
local boatModelId=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'defaultBoatModelId')

self.yzModel:setChildUIModelShowTarget(boatModelId,1,nil,eAnimationID.stand)



local yzname='未建造'
local cfg=cfgHelper.get1(cfg_fairylandboatconfig_get,self.yzid)
local bdData=zongmenModel:findBuildingDataByID(mapIdType.fort,cfg.build_id)
if bdData and bdData.name then
yzname=bdData.name
end
self.shipName:setText(yzname)
local fightStr=mathHelper.formatNumber3(totalFightValue,true)
self.fight:setText(FMT.fmt('队伍实力: {0}',fightStr))

local level=tianshudazhenModel:getLevel()
local tsdzCfg=tianshudazhenConfig.getTianshudazhenconfig(level)
local attr=tsdzCfg.attr
local str='大阵加成:'
for i,v in ipairs(attr)do
local name,valstr=equipsHelper.getAttr(v[1],v[2])
str=i==1 and FMT.fmt('{0}{1}',str,FMT.fmt('{0}+{1}',name,valstr))or
FMT.fmt('{0},{1}',str,FMT.fmt('{0}+{1}',name,valstr))
end
self.addtion:setText(str)
end

function UITianShuDaZhenWin:freshXianJieBtn(update)
local isDisableOpen=tianshudazhenModel:isDisableOpenFHZ()
local isOpening=tianshudazhenModel:isOpeningFHZ()

self.disableRoot:setActive(isDisableOpen)
self.canOpenRoot:setActive(not isDisableOpen)

if self.disableTimer then
self:stopTimerByID(self.disableTimer)
self.disableTimer=nil
end

local ani=eAnimationID.stand3
if not isDisableOpen then
self.openningRoot:setActive(isOpening)
self.canOpenTitle:setText(isOpening and'护山大阵\n已激活'or'点击开启\n护山大阵')
if isOpening then
ani=eAnimationID.stand2
local tick=function()
local lefTime=tianshudazhenModel:getOpeningDaZhenLeftTime()
if lefTime>0 then
local timeStr=timeHelper.format_time_stamp3(lefTime)
self.baohuTime:setText(timeStr)
else
self.baohuTime:setText('')
if self.disableTimer then
self:stopTimerByID(self.disableTimer)
self.disableTimer=nil
end
if not update then
self:freshXianJieBtn(true)
end
end
end
self.disableTimer=self:setTimer(1,0,tick)
tick()
else
ani=eAnimationID.stand3
self.baohuTime:setText('')
end
else
ani=eAnimationID.stand
local tick=function()
local lefTime=tianshudazhenModel:getDisableDaZhenLeftTime()
if lefTime>0 then
local timeStr=timeHelper.format_time_stamp3(lefTime)
self.leftOpenTime:setText(FMT.fmt('{0}后煞气消散',timeStr))
else
self.leftOpenTime:setText('')
if self.disableTimer then
self:stopTimerByID(self.disableTimer)
self.disableTimer=nil
end
if not update then
self:freshXianJieBtn(true)
end
end
end
self.disableTimer=self:setTimer(1,0,tick)
tick()
end

if self.loadModel then
self.model:setChildModelAnimationState(ani,1,nil)
end
end

function UITianShuDaZhenWin:refreshTipsPanel()
local bufflist__=tianshudazhenConfig.getTianShuDaZhenBufflist()
local tqbuffid=tianshudazhenModel:getShenDunTeQuanBuffId()
local hasXgJob=tianshudazhenModel:hasXgsdTq()
local bufflist=bufflist__
if hasXgJob then
bufflist={}
bufflist[#bufflist+1]=tqbuffid
bufflist=table.concatTable(bufflist,bufflist__)
end
local len=#bufflist

for _,v in pairs(self.useBuffTimer)do
self:stopTimerByID(v)
end
self.useBuffTimer={}

self.winlua:SetChildLayoutGroupCreateItems(self.fzCreator:getID(),len,function(index)
local widget=self.winlua:GetChildLayoutGroupGridItem(self.fzCreator:getID(),index-1)
local buffid=bufflist[index]
local cfg=cfg_fairylandbuffconfig_get(buffid)
local consume=cfg.consume
local cost=consume and consume[1]or nil
local itemid=cost and cost[1]or nil
local need=cost and cost[2]or 0

widget:SetChildQulaity(10,eQualityColor.eBlue)
widget:SetChildIcon(11,cfg.iconNmae,false)
widget:SetChildText(0,cfg.name)
widget:SetChildText(1,cfg.desc)
if hasXgJob and buffid==tqbuffid then
local maxtimes=tianshudazhenModel:getMaxXgHuDunUseCnt()
local times=tianshudazhenModel:getXgHuDunUseCnt()
local tqid=XIANGUAN_PRIVILEGE_ENUM.eTqType_17
local tqcfg=cfg_xianguanprivilegeconfig_get(tqid)
local hastimes=maxtimes-times
local cntStr=hastimes>0 and FMT.fmt('<color=#aae252>{0}</color>',hastimes)or FMT.cfmt(FONT_COLOR.eRedColor,hastimes)
local desc=FMT.fmt('使用\n{0}/{1}',cntStr,maxtimes)
widget:SetChildText(4,desc)
widget:SetChildActive(5,hastimes<maxtimes)
widget:SetChildActive(7,false)
widget:SetChildActive(12,true)
local descStr=cfg.desc
if cfg.tipsDesc then
descStr=FMT.fmt('{0}\n{1}',descStr,cfg.tipsDesc)
end
local tqName=tqcfg.name
widget:SetChildButtonClick(12,function()
UIManager:showWindow('UITianShuDaZhenTeQuanTips',{name=tqName,
str=descStr,
pos=widget:GetChildScreenPointToLocalPointRectangle(12),
offsetPos=Vector2.zero})
end,true)
widget:SetChildButtonClick(3,function()
self:useShenDunTeQuan()
end,true)

if hastimes<maxtimes then
local func=function()
local leftTime=tianshudazhenModel:getUseXgTeQuanLeftTime()
leftTime=math.max(leftTime,0)
widget:SetChildText(6,timeHelper.format_time_stamp(leftTime))
end
self.useBuffTimer[buffid]=self:setTimer(0.7,0,func)
func()
end
elseif itemid==eMoneyType.mtTSDZConsume then
local maxtimes=tianshudazhenConfig:getMaxFHZFreeTimes()
local hastimes=tianshudazhenModel:getHasFHZFreeTimes()
local cntStr=hastimes>0 and FMT.fmt('<color=#aae252>{0}</color>',hastimes)or FMT.cfmt(FONT_COLOR.eRedColor,hastimes)
local desc=FMT.fmt('使用\n{0}/{1}',cntStr,maxtimes)
widget:SetChildText(4,desc)
widget:SetChildActive(5,hastimes<maxtimes)
widget:SetChildActive(7,false)
widget:SetChildActive(12,false)
widget:SetChildButtonClick(3,function()
self:useBuff(buffid,cfg)
end,true)
if hastimes<maxtimes then
local func=function()
local leftTime=moneyAutoIncreaseModel:getLeastTime(itemid)
leftTime=math.max(leftTime,0)
widget:SetChildText(6,timeHelper.format_time_stamp(leftTime))
end
self.useBuffTimer[buffid]=self:setTimer(0.7,0,func)
func()
end
else
widget:SetChildText(4,'使用')
widget:SetChildActive(5,false)
widget:SetChildActive(7,true)
widget:SetChildIcon(8,iconHelper.getIconName(itemid),false)
widget:SetChildActive(12,false)
widget:SetChildButtonClick(3,function()
self:useBuff(buffid,cfg)
end,true)
local enough=itemsModel.checkItemEnough(itemid,need)
local str=enough and need or FMT.cfmt(FONT_COLOR.eRedColor,need)
local hasCnt=itemsModel.getCount(itemid)
if hasCnt==0 then
widget:SetChildText(9,str)
else
local desc=FMT.fmt('{0}/{1}',str,hasCnt)
widget:SetChildText(9,desc)
end
end
end)
end

function UITianShuDaZhenWin:onMoneyChanged(moneyType)
if moneyType==eMoneyType.mtTSDZConsume then
self:refreshTipsPanel()
self:refreshUpInfo()
end
end

function UITianShuDaZhenWin:onFYZchange(oldVal,newVal)
local max=tianshudazhenModel:getMaxHDZValue()
self.progressBar:animateThreeParams(newVal*100,max*100,0.2)
self.progressCount:setText(FMT.fmt('{0}/{1}',newVal,max))
end

function UITianShuDaZhenWin:on_building_event(etype,sfId,ubdId,arg1,arg2)
if ubdId~=self.bdData.un_build_id then return end

if(etype==buildingEvent.levelUpStart or
etype==buildingEvent.speedUpComplete)then
self:refreshUpInfo()
self:freshUpWindow()
elseif etype==buildingEvent.levelUpComplete then
self:refreshInfo()
self:freshUpWindow()
end
end

function UITianShuDaZhenWin:onChangeDaZhen()
if self.showTipsRoot then
self:refreshTipsPanel()
end
self:freshXianJieBtn()
end

function UITianShuDaZhenWin:useBuff(buffid,cfg)
if not xianjieModel:checkJoin()then
UIManager.error('尚未进入仙域，无法开启护山大阵')
return
end

if tianshudazhenModel:isDisableOpenFHZ()then
UIManager.error('已被煞气入侵，无法开启护山大阵')
return
end

if tianshudazhenConfig.getFreeFHZBuffId()==buffid then
if tianshudazhenModel:getHasFHZFreeTimes()<=0 then
UIManager.error('免费次数已用完')
return
end
end

local consume=cfgHelper.get2(cfg_fairylandbuffconfig_get,buffid,'consume')
if consume then
for i,v in ipairs(consume)do
local itemId=v[1]
if not itemsModel.checkItemEnough(itemId,v[2])then
gainControl:showGainWin(itemId)
local name=itemsConfig.getItemName(itemId)
UIManager.error(FMT.fmt('{0}不足',name))
return
end
end
end

local leftTime=tianshudazhenModel:getOpeningDaZhenLeftTime()
local max=tianshudazhenConfig.getMaxFHZValue()
if leftTime>=max then
UIManager.error('已超防护罩持续上限')
return
end

leftTime=leftTime+cfg.duration

local func=function()
local func1=function()
tianshudazhenController.reqUseBuff(buffid)
end
if leftTime>max then
local overTime=leftTime-max
local overTimeStr=timeHelper.format_time_stamp16(overTime)
local desc=FMT.fmt('继续使用防护罩时间将溢出{0},请问是否继续？',overTimeStr)
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func1)
return
end
func1()
end

if xianjieModel:checkHasJiJieYBDIsOpen(xjJjJieBaseType.eWar)then
local args={}
args.content='已开启战争预备队，是否关闭预备队并开启护山大阵？'
args.title='提示'
args.okcallback=func
args.oktext='确定'
args.canceltext='取消'
args.choosetext="护山大阵结束后自动开启战争预备队"
args.choosecallback=function(flag)
tianshudazhenModel:setLocalJiJieYBDData(flag)
end
self:showWindow('UITianShuDaZhenDialouge',args)
else
func()
end
end

function UITianShuDaZhenWin:refreshTipsBottom()
self:refreshFSCD()
self.winlua:ForceLayoutRect(self.tipsBottom:getID())
end

function UITianShuDaZhenWin:refreshFSCD()
local info=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,"fengsuoZongMen")
if info then
local privilegeId=info[1]
local privilegeCfg=cfgHelper.get1(cfg_xianguanprivilegeconfig_get,privilegeId)
local buffId=privilegeCfg.effectArgs[1]
local leftTime=xianjieModel:getBuffLeftTime(buffId)
if leftTime>0 then
self.fsInfo={timeHelper.getServerShortTime()+leftTime,info[3]}
if self:updateFSTick()then
self:startFSTick()
self.tipsTx:setActive(true)
return
end
end
end
self.tipsTx:setActive(false)
self:stopFsTick()
self.fsInfo=nil
end

function UITianShuDaZhenWin:startFsTick()
if not self.fsTick then
self.fsTick=self:setTimer(1,0,function()
if not self:updateFsTick()then
self:refreshFSCD()
end
end)
end
end

function UITianShuDaZhenWin:stopFsTick()
if self.fsTick then
self:stopTimerByID(self.fsTick)
self.fsTick=nil
end
end

function UITianShuDaZhenWin:updateFSTick()
local nowTime=timeHelper.getServerShortTime()
local lefTime=self.fsInfo[1]-nowTime
local temp=lefTime>0
if temp then
self.tipsTx:setText(FMT.fmt(self.fsInfo[2],timeHelper.format_time_stamp3(lefTime,true)))
end
return temp
end

function UITianShuDaZhenWin:useShenDunTeQuan()
local actorid=playerModel:getActorID()
local func=function()
tianshudazhenModel:useShenDunTeQuan(actorid)
end

if tianshudazhenModel:isOpeningFHZ()then
local desc='已开启护山大阵，尊敬的天枢龙卫大人是否继续开启天枢神盾大阵？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
else
local desc='尊敬的天枢龙卫大人，是否确定开启天枢神盾大阵？'
self.dialog=UIDialogManager.getConfirmDialog3(self.dialog,desc,func)
end
end
