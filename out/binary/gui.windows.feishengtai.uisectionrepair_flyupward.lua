







def_class("UISectionRepair_flyupward",UIWindowBase)









function UISectionRepair_flyupward:bindComponents()

self.adItemClick=UIButton.get(self,0)
self.bgmodel=UIObject.get(self,1)
self.btnAdsSpeedup=UIButton.get(self,2)
self.btnOnekey=UIButton.get(self,3)
self.btnReset=UIButton.get(self,4)
self.bulidEffect=UIText.get(self,5)
self.bxbtn=UIButton.get(self,6)
self.bxbtn2=UIButton.get(self,7)
self.cddjzbPanel=UIObject.get(self,8)
self.cddjzbProgress=UIObject.get(self,9)
self.cdPanel=UIObject.get(self,10)
self.cdProgress=UIObject.get(self,11)
self.closeBtn=UIButton.get(self,12)
self.completeBtn=UIButton.get(self,13)
self.Content=UIObject.get(self,14)
self.costItems=UIObject.get(self,15)
self.costScrollview=UIObject.get(self,16)
self.dazaobtn=UIButton.get(self,17)
self.dazaopanel=UIObject.get(self,18)
self.destext=UIText.get(self,19)
self.djbxreddot=UIObject.get(self,20)
self.djbxreddot2=UIObject.get(self,21)
self.djzbcdimg=UIObject.get(self,22)
self.djzbdestext=UIText.get(self,23)
self.djzbfinishtxt=UIText.get(self,24)
self.djzbfinishtxtbg=UIObject.get(self,25)
self.djzbjumpbtn=UIButton.get(self,26)
self.djzbrightPanel=UIObject.get(self,27)
self.djzbtitle=UIText.get(self,28)
self.djzbzwtxt=UIText.get(self,29)
self.Dropdown1=UIDropdownEx.get(self,30)
self.dzdjreddot=UIObject.get(self,31)
self.feishengtaiReddot=UIImage.get(self,32)
self.finishbtn=UIButton.get(self,33)
self.gotoTianjieBtn=UIObject.get(self,34)
self.iconAds=UIImage.get(self,35)
self.iconbtn=UIButton.get(self,36)
self.infoPanels=UIObject.get(self,37)
self.InviteBtn=UIButton.get(self,38)
self.item1=UIBaseItem.get(self,39)
self.item2=UIBaseItem.get(self,40)
self.item3=UIBaseItem.get(self,41)
self.item4=UIBaseItem.get(self,42)
self.item5=UIBaseItem.get(self,43)
self.itemroot=UIObject.get(self,44)
self.itemspeed1=UIBaseItem.get(self,45)
self.itemspeed2=UIBaseItem.get(self,46)
self.itemspeed3=UIBaseItem.get(self,47)
self.jdtxt=UIText.get(self,48)
self.jdtxt2=UIText.get(self,49)
self.jdupanel=UIObject.get(self,50)
self.jumptoFST=UIButton.get(self,51)
self.leftitem=UIObject.get(self,52)
self.leftitem1=UIObject.get(self,53)
self.leftitem2=UIObject.get(self,54)
self.leftitem3=UIObject.get(self,55)
self.leftitem4=UIObject.get(self,56)
self.leftitem5=UIObject.get(self,57)
self.lhpanel=UIObject.get(self,58)
self.lianhuapanel=UIObject.get(self,59)
self.lockpanel=UIObject.get(self,60)
self.locktxt=UIText.get(self,61)
self.openBtn=UIButton.get(self,62)
self.opendjzbBtn=UIButton.get(self,63)
self.payAds=UIText.get(self,64)
self.proAddExp=UIProgressBarAni.get(self,65)
self.proExpProgressbar=UIProgressBarAni.get(self,66)
self.progressText=UIText.get(self,67)
self.progressTexta=UIText.get(self,68)
self.proName=UIText.get(self,69)
self.proSkillInfo=UIObject.get(self,70)
self.repairBg=UIObject.get(self,71)
self.repairBtn=UIButton.get(self,72)
self.repairPanel=UIObject.get(self,73)
self.repairreddot=UIObject.get(self,74)
self.repairtxt=UIText.get(self,75)
self.rewardBtn=UIButton.get(self,76)
self.rewardGrid=UIObject.get(self,77)
self.rewardreddot=UIObject.get(self,78)
self.rightPanel=UIObject.get(self,79)
self.rule=UIButton.get(self,80)
self.ScrollView=UIScrollViewSlow.get(self,81)
self.selectBg=UIButton.get(self,82)
self.selectPanel=UIObject.get(self,83)
self.selpanelttxt=UIText.get(self,84)
self.speedUpBtnText=UIText.get(self,85)
self.time1=UIText.get(self,86)
self.time2=UIText.get(self,87)
self.timedjzb2=UIText.get(self,88)
self.tipsbtn=UIButton.get(self,89)
self.title=UIText.get(self,90)
self.topPanel=UIObject.get(self,91)
self.userbtn=UIButton.get(self,92)
self.yetInvite=UIButton.get(self,93)
self.yetrepairBg=UIObject.get(self,94)
self.yetrepairtxt=UIText.get(self,95)
self.zsicon=UIObject.get(self,96)
self.zstxt=UIText.get(self,97)

self.adItemClick:setButtonClick(function()self:onAdItemClick()end)

self.btnAdsSpeedup:setButtonClick(function()self:onBtnAdsSpeedup()end)

self.btnOnekey:setButtonClick(function()self:onBtnOnekey()end)

self.btnReset:setButtonClick(function()self:onBtnReset()end)

self.bxbtn:setButtonClick(function()self:onBxbtn()end)

self.bxbtn2:setButtonClick(function()self:onBxbtn2()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.completeBtn:setButtonClick(function()self:onCompleteBtn()end)

self.dazaobtn:setButtonClick(function()self:onDazaobtn()end)

self.djzbjumpbtn:setButtonClick(function()self:onDjzbjumpbtn()end)

self.finishbtn:setButtonClick(function()self:onFinishbtn()end)

self.iconbtn:setButtonClick(function()self:onIconbtn()end)

self.InviteBtn:setButtonClick(function()self:onInviteBtn()end)

self.jumptoFST:setButtonClick(function()self:onJumptoFST()end)

self.openBtn:setButtonClick(function()self:onOpenBtn()end)

self.opendjzbBtn:setButtonClick(function()self:onOpendjzbBtn()end)

self.repairBtn:setButtonClick(function()self:onRepairBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.rule:setButtonClick(function()self:onRule()end)

self.selectBg:setButtonClick(function()self:onSelectBg()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.userbtn:setButtonClick(function()self:onUserbtn()end)

self.yetInvite:setButtonClick(function()self:onYetInvite()end)



end


function UISectionRepair_flyupward:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.adItemClick);self.adItemClick=nil;
_UIObject_release(self.bgmodel);self.bgmodel=nil;
_UIObject_release(self.btnAdsSpeedup);self.btnAdsSpeedup=nil;
_UIObject_release(self.btnOnekey);self.btnOnekey=nil;
_UIObject_release(self.btnReset);self.btnReset=nil;
_UIObject_release(self.bulidEffect);self.bulidEffect=nil;
_UIObject_release(self.bxbtn);self.bxbtn=nil;
_UIObject_release(self.bxbtn2);self.bxbtn2=nil;
_UIObject_release(self.cddjzbPanel);self.cddjzbPanel=nil;
_UIObject_release(self.cddjzbProgress);self.cddjzbProgress=nil;
_UIObject_release(self.cdPanel);self.cdPanel=nil;
_UIObject_release(self.cdProgress);self.cdProgress=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.completeBtn);self.completeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.costItems);self.costItems=nil;
_UIObject_release(self.costScrollview);self.costScrollview=nil;
_UIObject_release(self.dazaobtn);self.dazaobtn=nil;
_UIObject_release(self.dazaopanel);self.dazaopanel=nil;
_UIObject_release(self.destext);self.destext=nil;
_UIObject_release(self.djbxreddot);self.djbxreddot=nil;
_UIObject_release(self.djbxreddot2);self.djbxreddot2=nil;
_UIObject_release(self.djzbcdimg);self.djzbcdimg=nil;
_UIObject_release(self.djzbdestext);self.djzbdestext=nil;
_UIObject_release(self.djzbfinishtxt);self.djzbfinishtxt=nil;
_UIObject_release(self.djzbfinishtxtbg);self.djzbfinishtxtbg=nil;
_UIObject_release(self.djzbjumpbtn);self.djzbjumpbtn=nil;
_UIObject_release(self.djzbrightPanel);self.djzbrightPanel=nil;
_UIObject_release(self.djzbtitle);self.djzbtitle=nil;
_UIObject_release(self.djzbzwtxt);self.djzbzwtxt=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.dzdjreddot);self.dzdjreddot=nil;
_UIObject_release(self.feishengtaiReddot);self.feishengtaiReddot=nil;
_UIObject_release(self.finishbtn);self.finishbtn=nil;
_UIObject_release(self.gotoTianjieBtn);self.gotoTianjieBtn=nil;
_UIObject_release(self.iconAds);self.iconAds=nil;
_UIObject_release(self.iconbtn);self.iconbtn=nil;
_UIObject_release(self.infoPanels);self.infoPanels=nil;
_UIObject_release(self.InviteBtn);self.InviteBtn=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.item3);self.item3=nil;
_UIObject_release(self.item4);self.item4=nil;
_UIObject_release(self.item5);self.item5=nil;
_UIObject_release(self.itemroot);self.itemroot=nil;
_UIObject_release(self.itemspeed1);self.itemspeed1=nil;
_UIObject_release(self.itemspeed2);self.itemspeed2=nil;
_UIObject_release(self.itemspeed3);self.itemspeed3=nil;
_UIObject_release(self.jdtxt);self.jdtxt=nil;
_UIObject_release(self.jdtxt2);self.jdtxt2=nil;
_UIObject_release(self.jdupanel);self.jdupanel=nil;
_UIObject_release(self.jumptoFST);self.jumptoFST=nil;
_UIObject_release(self.leftitem);self.leftitem=nil;
_UIObject_release(self.leftitem1);self.leftitem1=nil;
_UIObject_release(self.leftitem2);self.leftitem2=nil;
_UIObject_release(self.leftitem3);self.leftitem3=nil;
_UIObject_release(self.leftitem4);self.leftitem4=nil;
_UIObject_release(self.leftitem5);self.leftitem5=nil;
_UIObject_release(self.lhpanel);self.lhpanel=nil;
_UIObject_release(self.lianhuapanel);self.lianhuapanel=nil;
_UIObject_release(self.lockpanel);self.lockpanel=nil;
_UIObject_release(self.locktxt);self.locktxt=nil;
_UIObject_release(self.openBtn);self.openBtn=nil;
_UIObject_release(self.opendjzbBtn);self.opendjzbBtn=nil;
_UIObject_release(self.payAds);self.payAds=nil;
_UIObject_release(self.proAddExp);self.proAddExp=nil;
_UIObject_release(self.proExpProgressbar);self.proExpProgressbar=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.progressTexta);self.progressTexta=nil;
_UIObject_release(self.proName);self.proName=nil;
_UIObject_release(self.proSkillInfo);self.proSkillInfo=nil;
_UIObject_release(self.repairBg);self.repairBg=nil;
_UIObject_release(self.repairBtn);self.repairBtn=nil;
_UIObject_release(self.repairPanel);self.repairPanel=nil;
_UIObject_release(self.repairreddot);self.repairreddot=nil;
_UIObject_release(self.repairtxt);self.repairtxt=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.rewardreddot);self.rewardreddot=nil;
_UIObject_release(self.rightPanel);self.rightPanel=nil;
_UIObject_release(self.rule);self.rule=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.selectBg);self.selectBg=nil;
_UIObject_release(self.selectPanel);self.selectPanel=nil;
_UIObject_release(self.selpanelttxt);self.selpanelttxt=nil;
_UIObject_release(self.speedUpBtnText);self.speedUpBtnText=nil;
_UIObject_release(self.time1);self.time1=nil;
_UIObject_release(self.time2);self.time2=nil;
_UIObject_release(self.timedjzb2);self.timedjzb2=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
_UIObject_release(self.userbtn);self.userbtn=nil;
_UIObject_release(self.yetInvite);self.yetInvite=nil;
_UIObject_release(self.yetrepairBg);self.yetrepairBg=nil;
_UIObject_release(self.yetrepairtxt);self.yetrepairtxt=nil;
_UIObject_release(self.zsicon);self.zsicon=nil;
_UIObject_release(self.zstxt);self.zstxt=nil;
end
















local leftitem=
{
selectspine=1,
iconspine=2,
namebg=3,
name=4,
btn=5,
element=6,
bxReddot=7,
dotween=8,
}
local builditemid=
{
[81]=1,
[84]=2,
[85]=3,
[86]=4,
[82]=5,
[83]=6,
}
local alldjjz={81,82,83,84,85,86}
local buildstate=
{
weidoing=0,
doing=1,
finish=2
}
local feishengtaiid=81
local buildelement=
{
[84]=2,
[85]=4,
[86]=5,
[82]=1,
[83]=3,
}
local buildleftname=
{
[84]="太清葫芦",
[85]="真阳宝幡",
[86]="坤仪玄盾",
[82]="辟天神剑",
[83]="山海悬镜",
}
local _abname="ui/windows/feishengtai/flyupxiufu_atlas_pak.ab"
local _costid=10
local _colomn=4
local _row=6
local _bag_filter_val={}
local _bag_filter_desc={}
local _dropItemHeight=40
local _dropViewHeight=150

local _equipIdxArray={1,6,2,3,4,5,7}
local _materialIdxArray={1,2,3,4,5}
local _equipIdxOneKeyArray={1,6,2,3,4,5}
local _materialIdxOneKeyArray={1,2,3,4,5}
local element_name=
{
[1]="金属性",
[2]="木属性",
[3]="水属性",
[4]="火属性",
[5]="土属性",
}
local sortTypeName={'1阶及以下','2阶及以下','3阶及以下','4阶及以下','5阶及以下'}
local djbuildid={82,83,84,85,86}


local _this




function UISectionRepair_flyupward:onLoaded(...)
self:bindComponents()
_this=self
self.baseCfg=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'reduce_times_itemlist')
self.costScrollview:setChildScrollViewInit(0.5,true,nil,nil)
self.bgmodel:setChildUIModelShowTarget(5495,1,nil,5)
self.leftitems={self.leftitem,self.leftitem1,self.leftitem2,self.leftitem3,self.leftitem4,self.leftitem5}
self.builditemidx=1
self.allZhenWudata={}
self.isdjdz=false
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)

self.ScrollView:setSlowClickAction(nil)
self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(1,...)end)

self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(1,...)end)

local itemsList={}
itemsList={self.item1,self.item2,self.item3,self.item4,self.item5}
self.itemsList=itemsList
for _,v in ipairs(itemsList)do
v:setBaseItemClickEvent(function(...)
if not self.isClose then
self:onSelectItemClick(...)
end
end)
end

local list=table.toTable(1,5)
self.nomalStageVal=list
self.nomalStageDesc=itemsFilterHelper.getFilterNames(list,function(stage)
return FMT.fmt('{0}阶及以下',stage)
end)
self.jingcaiStageDesc={'1阶及以下'}
_bag_filter_desc[ITEM_FILTER_TYPE.eStage]=self.nomalStageDesc
self.filter={}
self.filter[ITEM_FILTER_TYPE.eElement]=0
self.filter[ITEM_FILTER_TYPE.eStage]=0
self.filter[ITEM_FILTER_TYPE.eColor]=0
self.noweStage=1
self.nowelement=1
self.Dropdown1:setOption(sortTypeName)
self.Dropdown1:setValue(self.noweStage-1)

self.selectBagType=BAG_TYPE.eMaterialsBag
self.selectList={}
self.selectNumList={}
self.showAttrPanel=false
self.lianzhiType=FABAO_LIANZHI_TYPE.eNomal

self.selectBg:setActive(false)
self.unlockItem={}
self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
self.curPageIndex=1
self.selectItemguid=nil
self.isSetZero=false
self.selectItemguidIdx=nil
self.isSelectGrid=nil
self.funcFilter=0
end


function UISectionRepair_flyupward:__delete()

UIManager:hideWindow('UITopMoneyWin')
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
_this=nil

FeiShengTaiModel:refreshFSTHUD()
DuJieZhiBaoController:refreshDJZBHUD()
end

function UISectionRepair_flyupward.on_building_event(etype,sfId,bdId,arg1,arg2)
local data=zongmenModel:getBuildingData(bdId)

if not data then
return
end
if data.build_id==feishengtaiid then
_this:refreshjzData()
if etype==buildingEvent.buildStart or etype==buildingEvent.buildComplete
or etype==buildingEvent.levelUpStart or etype==buildingEvent.levelUpComplete then
if _this.model==1 then
_this.model=2
_this.data=data
end
if data.flag~=0 then
_this:refresh()
else
_this:onClickClose()
end
elseif etype==buildingEvent.speedUpComplete then
_this:refresh(true)
end
elseif data.build_id==82 or data.build_id==83 or data.build_id==84 or data.build_id==85 or data.build_id==86 then
_this:refreshjzData()
if etype==buildingEvent.buildStart or etype==buildingEvent.buildComplete
or etype==buildingEvent.levelUpStart or etype==buildingEvent.levelUpComplete then
if _this.model==1 then
_this.model=2
_this.data=data
end
if data.flag~=0 then
if _this.isdjdz then
local jzdata=data
local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
if jzdata and jzdata.flag then
if jzdata.flag==11 or jzdata.flag==12 then
local un_build_id=jzdata.un_build_id
local cddata=buildingCDControl:getCDData(buildingCDType.build,un_build_id,false)
if not cddata or cddata.complete then
return
end
if cddata then
local feisheng_cfg=allcfg.server_reduce_conf
local fs_data=nil
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
local alltime=cddata.ntime
local chatime=cddata.ntime
if fs_data then
local cdrate=fs_data[4]
local cdrate2=100-cdrate
chatime=chatime*(cdrate2/100)
end
local deltime=alltime-chatime
if deltime and deltime>0 then
zongmenModel:setUpgradeSpeedupTime(1,un_build_id,deltime)
buildingCDControl:setSpeedUp(un_build_id,speedUpType.eUpgradeBuilding)
end
end
end
end
_this.isdjdz=false
end
_this:dujierefresh(_this._buildid,false,true)
else
_this:onClickClose()
end
elseif etype==buildingEvent.speedUpComplete then
local builditemidx=builditemid[_this._buildid]
_this:dazaoleftSingle(_this._buildid,builditemidx)

_this:dujierefresh(_this._buildid,false,true)
end
end
end

function UISectionRepair_flyupward:showTopMoney(datas)
if not datas then
return
end
local mlist={}
for i,v in ipairs(datas)do
if moneyConfig.isMoney(v[1])then
table.insert(mlist,{v[1],0})
end
end
UIManager:showWindow('UITopMoneyWin',mlist)
end




function UISectionRepair_flyupward:onShow(argtable,afterOnloaded)
self.infoPanels:setChildCanvasGroupAlpha(0)
self.infoPanels:setChildCanvasGroupDOFade(1,0.6,nil)
self.sfId=zongmenModel:getMountainId()
self.model=argtable[1]
self.data=argtable[2]


self.gotoTianjieBtn:setActive(systemModel.isOpen(SYSTEM_DEFINE.eFeiShengTai))
self:refreshjzData()
local buildid
if self.model==1 then
buildid=self.data.id
else
buildid=self.data.build_id
end
for k,v in pairs(self.allZhenWudata)do
if v.jzid==buildid then
self.model=v.model
self.data=v.jzdata
end
end

if builditemid[buildid]then
self.builditemidx=builditemid[buildid]
else
logErr(FMT.fmt("找不到建筑id:{0} 对应的建筑预制",buildid))
end
self:initleftbtn()
self:initleftpanel()

local build_id
if self.model==1 then
build_id=self.data.id
else
build_id=self.data.build_id
end
self._buildid=build_id
self.nowelement=buildelement[build_id]or 1
if build_id==feishengtaiid then
self.rightPanel:setActive(true)
self.topPanel:setActive(false)
self.djzbrightPanel:setActive(false)
socketManager:send_34_41()
self:refresh()
else
self.rightPanel:setActive(false)
self.topPanel:setActive(true)
self.djzbrightPanel:setActive(true)
self:refreshRight()
end



local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,81)
local costs=cfg.repair_cost[1]
self:showTopMoney(costs)
self:refreshDailyReward()


if systemModel.isOpen(SYSTEM_DEFINE.eFeiShengTai)and not systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
local isFirst=userActorSetting.get('feishengtai_win_first',false)
if not isFirst then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_BRANCH_LUA_FUNC_NAME.FirstTimeFeiShengTaiLuaFunc)
userActorSetting.set('feishengtai_win_first',true)
userActorSetting.flush()
end
end

if systemModel.isOpen(SYSTEM_DEFINE.eDuJieZhiBao)then
local isFirst=userActorSetting.get('djzb_win_first',false)
if not isFirst then
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_BRANCH_LUA_FUNC_NAME.FirstTimeDuJieZhiBaoLuaFunc)
userActorSetting.set('djzb_win_first',true)
userActorSetting.flush()
end
end
end


function UISectionRepair_flyupward:onHide()

end

function UISectionRepair_flyupward:speedback(reduce_times)
self:refresh(true)
end
function UISectionRepair_flyupward:refresh(playAnim)

local FeiShengdata=FeiShengTaiModel:GetFeiSheng()
if not next(FeiShengdata)then
return
end
local peoplenum=FeiShengdata.super_actor_cnt
self.itemReduce,self.timeReduce=self:judeReducedata(peoplenum)

local send_help_cnt=FeiShengdata.send_help_cnt
local super_actor_cnt=FeiShengdata.super_actor_cnt
local baseCfg=cfgHelper.get(cfg_jctjbaseconfig_get,1)
local needNum=baseCfg.xljkNum or 0
local buffList=nil
if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie2)and JiuChongTianJieEnterModel:getOpenTianJiePeople()>=needNum then
buffList=JiuChongTianJieEnterModel:getBuffList()
end
self.openBtn:setActive(buffList and next(buffList)~=nil)

local id
local rlevel=1
local cddata
if self.model==1 then
id=self.data.id
else
self.bdData=self.data
id=self.data.build_id
cddata=buildingCDControl:getCDData(buildingCDType.build,self.data.un_build_id,true)
if self.data.flag>20 then
rlevel=self.data.flag-19
elseif self.data.flag>10 then
rlevel=self.data.flag-10

else
rlevel=self.data.flag
end
end
self.cfgId=id
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local costs=cfg.repair_cost[rlevel]
self.costData=costs



local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,id,1)
self.destext:setText(levelCfg.build_desc)

self.title:setText(cfg.name)

local c1=0
local c2=#cfg.repair_cost
self.FSTstage=rlevel
if self.data.flag and self.data.flag<10 then
c1=c2
self.FSTstage=-1
elseif self.model==2 then
c1=rlevel-1
self.FSTstage=rlevel-1
end
local build_effect=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'build_effect')
self.bulidEffect:setText(build_effect[1])
self.progressTexta:setText(FMT.fmt('修筑进度：<color=#ca631d>{0}/{1}</color>',c1,c2))
local guildlvl_limit=cfgHelper.get2(cfg_monijybuildconfig_get,81,'guildlvl_limit')
local minlv=guildlvl_limit[1][1]
local maxlv=guildlvl_limit[1][2]
if cddata then
self.InviteBtn:setActive(true)
self.repairPanel:setActive(false)
self.cdPanel:setActive(true)
self.itemroot:setActive(true)
self.repairBg:setActive(false)
self.yetrepairBg:setActive(false)
self.time2:setText(timeHelper.format_time_stamp11(cddata.cd))
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime,cddata.ntime,playAnim==true)

self.yetInvite:setActive(send_help_cnt>=1)
self.lastTime=cddata.cd

if cddata.complete then
self.completeBtn:setActive(true)
self.btnAdsSpeedup:setActive(false)
else
self.completeBtn:setActive(false)
self.btnAdsSpeedup:setActive(true)
self:SetItemData()
self:refreshSpeedPanel(speedUpType.eUpgradeBuilding)
end

self:stopCOuntDown()
if not cddata.complete then
self:startCountDown()
else
self.time2:setText('已完成')
self.isFull=(c1+1)==c2
end
else
self.InviteBtn:setActive(false)
self.repairPanel:setActive(true)
self.cdPanel:setActive(false)
self.completeBtn:setActive(false)
self.btnAdsSpeedup:setActive(false)
self.itemroot:setActive(false)
self.yetInvite:setActive(false)
local guildlvl_limit=cfgHelper.get2(cfg_monijybuildconfig_get,81,'guildlvl_limit')
local minlv=guildlvl_limit[1][1]
local maxlv=guildlvl_limit[1][2]
local repair_tips=cfgHelper.get2(cfg_monijybuildconfig_get,81,'repair_tips')



if playerModel:getActorLevel()<minlv or playerModel:getActorLevel()>maxlv or not systemModel.isOpen(SYSTEM_DEFINE.eFeiShengTai)then
self.time1:setActive(false)
self.repairPanel:setActive(false)
self.rewardBtn:setActive(false)
self.repairBtn:setActive(false)
self.repairBg:setActive(true)
self.yetrepairBg:setActive(false)
self.repairtxt:setText(string.format("<color=#c82c2c>%s</color>",repair_tips[1].desc))
elseif self.FSTstage==-1 then
self.repairBtn:setActive(false)
self.yetrepairBg:setActive(true)
self.repairBg:setActive(false)
self.yetrepairtxt:setText(string.format("<color=#c82c2c>飞升台已修建完成</color>"))
else
self.time1:setActive(true)
self.repairBtn:setActive(true)
self.repairBg:setActive(false)
self.yetrepairBg:setActive(false)
end

if self.FSTstage~=-1 and(playerModel:getActorLevel()>=minlv and playerModel:getActorLevel()<=maxlv and systemModel.isOpen(SYSTEM_DEFINE.eFeiShengTai))then

local len=#costs
self.costScrollview:setChildScrollViewCreateGrids(len,math.min(len,5))
local grids=self.costScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local node=grids[i]
local data=costs[i+1]
local num=math.ceil(data[2]*(1-self.itemReduce/100))
widgetHelper.setNormalRewardItem(node,0,{data[1],num,checkAmount=true})
local item=node:GetChildWidgetBase(0)
item:SetChildGraphicGray(3,false)
item:SetChildGraphicGray(2,false)
end
local time=math.ceil(cfg.repair_time[rlevel]*(1-self.timeReduce/100))
self.time1:setText(timeHelper.format_time_stamp11(time))

if send_help_cnt>=1 then
self.InviteBtn:setActive(false)
end
else
self.time1:setActive(false)
self.InviteBtn:setActive(false)
end
end
if playerModel:getActorLevel()>=minlv and playerModel:getActorLevel()<=maxlv and systemModel.isOpen(SYSTEM_DEFINE.eFeiShengTai)then
local reddotflag,rewardflag=FeiShengTaiModel:GetRewardreddot()

self.rewardBtn:setActive(rewardflag)
self.rewardreddot:setActive(reddotflag)

self.repairreddot:setActive(FeiShengTaiModel:judeCanRepairFST())
end

self.jumptoFST:setActive(self.FSTstage==-1)

self:refreshDailyReward()
end

function UISectionRepair_flyupward:judeReducedata(peoplenum)
local server_reduce_conf=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'server_reduce_conf')
for k,v in ipairs(server_reduce_conf)do
if peoplenum>=v[1]and peoplenum<=v[2]then


return v[3],v[4]
end
end
return 0,0
end
function UISectionRepair_flyupward:startCountDown()
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.data.un_build_id)
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime)
local tick=function()
self.lastTime=cddata.cd
self.time2:setText(timeHelper.format_time_stamp11(cddata.cd))
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime+1,cddata.ntime)
if cddata.complete then
self:stopCOuntDown()
self:refresh()
end
end

self:addCDUpdateFunc('SRPCD',tick)
end
function UISectionRepair_flyupward:stopCOuntDown()
self:removeCDUpdateFunc('SRPCD')
end
function UISectionRepair_flyupward:getRepairModel(cfg,rlevel)
if cfg.sp_ui_model then
if type(cfg.sp_ui_model[0])=='table'then

if rlevel==0 then
rlevel=1
end
return cfg.sp_ui_model[0][rlevel]
else
return cfg.sp_ui_model[0]
end
end
return cfg.repair_model[rlevel]
end




function UISectionRepair_flyupward:checkCost(wraning)
if not self.itemReduce then
self.itemReduce=0
end
for i,v in ipairs(self.costData)do
local id=v[1]
local need=math.ceil(v[2]*(1-self.itemReduce/100))
if moneyConfig.isMoney(id)then
local have=moneyModel.getMoney(id)
if have<need then
if wraning then
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(id)))
gainControl:showGainWin(id)
end
return false,id
end
else
local have=bagModel.getItemCountById(id)
if have<need then
if wraning then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(id)))
gainControl:showGainWin(id)
end
return false,id
end
end
end
local guildlvl_limit=cfgHelper.get2(cfg_monijybuildconfig_get,81,'guildlvl_limit')
local minlv=guildlvl_limit[1][1]
local maxlv=guildlvl_limit[1][2]
if playerModel:getActorLevel()<minlv or playerModel:getActorLevel()>maxlv then
return false
end
if not systemModel.isOpen(SYSTEM_DEFINE.eFeiShengTai)then
return false
end

return true
end
function UISectionRepair_flyupward:onRepairBtn()
if self:checkCost(true)then
local sfId=zongmenModel:getMountainId()
if self.model==1 then
zongmenControl:reqBuild(sfId,self.data.id,self.data.x,self.data.y,0)
else
zongmenControl:reqBuildingLevelUp(sfId,self.data.un_build_id,0,{})
end
socketManager:send_34_41()
end
end
function UISectionRepair_flyupward:onCompleteBtn()
local sfId=zongmenModel:getMountainId()
zongmenControl:reqBuildingLevelUpComplete(sfId,self.data.un_build_id)
if self.isFull then
self:onClickClose()
end
end
function UISectionRepair_flyupward:onClickClose()
self:closeSelf()
end

function UISectionRepair_flyupward:refreshSpeedPanel(typo)
self.speedup_type=typo
local have
local itemId
local data
local itemcfg=self.baseCfg
for k,v in pairs(itemcfg)do
have=itemsModel.getCount(k)
if have>0 then
itemId=k
data=v
break
end
end
self.payAds:setActive(false)
self.speedup_item_id=nil
if data then
local cfg=itemsConfig.getConfig(itemId)
self.iconAds:setChildIcon(iconHelper.getIconName(cfg.id),true)
self.payAds:setText(string.format('剩余：%s',have))

self.speedUpBtnText:setText('加速')


self.speedup_time=data
self.speedUpMode=1

return
end
self.iconAds:setSprite(globalABLookup.global,'icon_djguankanshipin')
self.payAds:setText(string.format('免费加速'))
local needtime=adControl:getSpeedUpTime()
self.speedUpBtnText:setText('加速')
self.speedUpMode=2
end

function UISectionRepair_flyupward:onBtnAdsSpeedup()
UIManager:showWindow("UIFlyupward_speed",{bdData=self.data,flag=1})
end
function UISectionRepair_flyupward:onAdItemClick()
if self.speedup_item_id then
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=self.speedup_item_id})
end
end

function UISectionRepair_flyupward:SetItemData()
local itemtable={}
for k,v in pairs(self.baseCfg)do
local itemid=k
itemtable[#itemtable+1]=itemid
end
table.sort(itemtable,function(a,b)
local itemConfig1=itemsConfig.getConfig(a)
local color1=itemConfig1.color
local itemConfig2=itemsConfig.getConfig(b)
local color2=itemConfig2.color
return color1>color2
end)
for i=1,3 do
local widget=nil
if i==1 then
self.itemspeed1:setActive(true)
widget=self.winlua:GetChildWidgetBase(self.itemspeed1:getID())
elseif i==2 then
self.itemspeed2:setActive(true)
widget=self.winlua:GetChildWidgetBase(self.itemspeed2:getID())
elseif i==3 then
self.itemspeed3:setActive(true)
widget=self.winlua:GetChildWidgetBase(self.itemspeed3:getID())
end
if itemtable[i]then
widget:SetChildActive(-1,true)
local itemConfig=itemsConfig.getConfig(itemtable[i])
local color=itemConfig.color
widget:SetChildIcon(1,iconHelper.getIconName(itemtable[i]),false)
local havenum=itemsModel.getCount(itemtable[i])
local moneystr=havenum
if havenum<=0 then
moneystr=FMT.fmt("<color={0}>{1}</color>",FONT_COLOR_VAL[FONT_COLOR.eRedColor],moneystr)
end
widget:SetChildText(2,moneystr)
widget:SetChildActive(9,true)
widget:SetChildQulaity(0,color)
widget:SetChildButtonClick(1,function(...)
itemsComponentHelper.onItemClickEx(itemtable[i])
end)
else
widget:SetChildActive(-1,false)
end

end
end

function UISectionRepair_flyupward:onInviteBtn()
if not xianmengModel:hasXM()then
UIManager.info('请先加入仙盟')
xianmengController:openJoinWin()
self:closeSelf()
return
end

FeiShengTaiController:SendXMHelpMe()
UIManager.info("向仙盟盟友发送邀请成功")
end

function UISectionRepair_flyupward:onOpenBtn()
self:showWindow("UIXianLuJianKaiWin")
end
function UISectionRepair_flyupward:onRule()
local d={}
d.title='规则说明'
d.mode=3
d.name='feishengtai_repair_rule_%d'
d.closeCB=function()

end
UIManager:showWindow('UIRuleWin',d)
end


function UISectionRepair_flyupward:onRewardBtn()

UIManager:showWindow("UIFST_repairRewardWin",{FSTstage=self.FSTstage})

end

function UISectionRepair_flyupward:onJumptoFST()

FeiShengTaiModel:jumptoFST()
end




function UISectionRepair_flyupward:onOpendjzbBtn()
self:showWindow("UIXianLuJianKaiWin")
end

function UISectionRepair_flyupward:onDjzbjumpbtn()

UIFullDuJieZhiBaoControl:showDJZBWindow({2,self.data.build_id})
end

function UISectionRepair_flyupward:onFinishbtn()
local sfId=zongmenModel:getMountainId()
zongmenControl:reqBuildingLevelUpComplete(sfId,self.data.un_build_id)




end

function UISectionRepair_flyupward:onBxbtn()
self:showWindow("UIDJZBRewardWin",{buildid=_this._buildid})
end
function UISectionRepair_flyupward:onBxbtn2()
self:showWindow("UIDJZBRewardWin",{buildid=_this._buildid})
end

function UISectionRepair_flyupward:onTipsbtn()
tipsManager.closeTips()
local d={}
d.title='规则说明'
d.mode=3
d.name='dujiezhibao_repair_rule_%d'
d.closeCB=function()
end
UIManager:showWindow('UIRuleWin',d)
end

function UISectionRepair_flyupward:onSelectBg()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UISectionRepair_flyupward:refreshjzData()
local templist={}
for k,v in ipairs(alldjjz)do
local temp=
{
stage=0,
jzid=v,
jzdata=nil,
model=1,
isfinish=false
}
templist[v]=temp
end

for k,SLG_type in ipairs(alldjjz)do
local bdDatas=zongmenModel:getBuildingDataByBdType(self.sfId,SLG_type)
if bdDatas and bdDatas[1]then
local v=bdDatas[1]
if v then
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,v.build_id)
if v.flag>10 then
local temp=
{
stage=1,
jzid=cfg.build_type,
jzdata=v,
model=2,
isfinish=false
}
templist[cfg.build_type]=temp
else
local temp=
{
stage=2,
jzid=cfg.build_type,
jzdata=v,
model=2,
isfinish=true
}
templist[cfg.build_type]=temp
end
end
end
end


for k,v in pairs(templist)do
local _stage=v.stage
local _jzid=v.jzid
if _stage==buildstate.weidoing then
local _data=isometricMapSystem:getRepairDataByID(self.sfId,_jzid)
local temp=
{
stage=0,
jzid=_jzid,
jzdata=_data,
model=1,
isfinish=false
}
templist[k]=temp
end
end








self.allZhenWudata=templist

end

function UISectionRepair_flyupward:initleftbtn()
for k,v in pairs(self.allZhenWudata)do
local _jzid=v.jzid
local builditemidx=builditemid[_jzid]
local widget=self.leftitems[builditemidx]:getWidgetBase()
widget:SetChildButtonClick(leftitem.btn,function()
self:onClickleft(_jzid,builditemidx)
end)
end
end

function UISectionRepair_flyupward:onClickleft(_jzid,builditemidx)
if self.builditemidx==builditemidx then
return
end
local oldidx=self.builditemidx
self.builditemidx=builditemidx
self:onBtnReset()
self:closeProvideSelectGrids()


if oldidx then
local oldwidget=self.leftitems[oldidx]:getWidgetBase()
oldwidget:SetChildActive(leftitem.selectspine,false)
if oldidx==1 then
oldwidget:SetChildCSImageSprite(leftitem.namebg,_abname,"image_dujiezhibao_4")

oldwidget:SetChildDOTweenAnimation_DOPause(leftitem.element)
oldwidget:SetChildLocalPosY(leftitem.element,0)
else
oldwidget:SetChildCSImageSprite(leftitem.namebg,_abname,"image_dujiezhibao_2")
oldwidget:SetChildDOTweenAnimation_DOPause(leftitem.dotween)
oldwidget:SetChildLocalPosY(leftitem.dotween,0)
end
end

local widget=self.leftitems[builditemidx]:getWidgetBase()
widget:SetChildActive(leftitem.selectspine,true)
if builditemidx==1 then
widget:SetChildCSImageSprite(leftitem.namebg,_abname,"image_dujiezhibao_5")

widget:SetChildLocalPosY(leftitem.element,0)
widget:SetChildDOTweenAnimation_DOPlay(leftitem.element)
else
widget:SetChildCSImageSprite(leftitem.namebg,_abname,"image_dujiezhibao_3")
widget:SetChildLocalPosY(leftitem.dotween,0)
widget:SetChildDOTweenAnimation_DOPlay(leftitem.dotween)
end


for k,v in pairs(self.allZhenWudata)do
if v.jzid==_jzid then
self.model=v.model
self.data=v.jzdata
local build_id
if self.model==1 then
build_id=self.data.id
else
build_id=self.data.build_id
end
self._buildid=build_id
self.nowelement=buildelement[build_id]or 1
end
end

if _jzid==feishengtaiid then
self.rightPanel:setActive(true)
self.topPanel:setActive(false)
self.djzbrightPanel:setActive(false)
self:refresh()
else
self.rightPanel:setActive(false)
self.topPanel:setActive(true)
self.djzbrightPanel:setActive(true)
self:refreshRight()
end
end

function UISectionRepair_flyupward:initleftpanel()
for k,v in pairs(self.allZhenWudata)do
local _jzid=v.jzid
local builditemidx=builditemid[_jzid]
if _jzid==feishengtaiid then
local widget=self.leftitems[builditemidx]:getWidgetBase()
widget:SetChildUIModelShowTarget(leftitem.selectspine,5497,1,nil,eAnimationID.stand)
if _this.builditemidx==builditemidx then
widget:SetChildCSImageSprite(leftitem.namebg,_abname,"image_dujiezhibao_5")
widget:SetChildActive(leftitem.selectspine,true)

widget:SetChildLocalPosY(leftitem.element,0)
widget:SetChildDOTweenAnimation_DOPlay(leftitem.element)
else
widget:SetChildCSImageSprite(leftitem.namebg,_abname,"image_dujiezhibao_4")
widget:SetChildActive(leftitem.selectspine,false)
end
self:fstrefreshleft(_jzid,builditemidx,v)
else
self:initleftSingle(_jzid,builditemidx)
self:djzbRewardReddot(_jzid)
end
end
end

function UISectionRepair_flyupward:initleftSingle(_jzid,builditemidx)
local widget=self.leftitems[builditemidx]:getWidgetBase()
local buildid=_jzid
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
local name=buildleftname[buildid]or""
widget:SetChildText(leftitem.name,name)
local element=buildelement[buildid]
local elementIcon=ELEMENT_TYPE.getIcon(element)
widget:SetChildCSImageSprite(leftitem.element,globalABLookup.global,elementIcon)

local builddata=self.allZhenWudata[buildid]
local rlevel=1
if builddata.model==1 then
else
if builddata.jzdata.flag>20 then
rlevel=builddata.jzdata.flag-19
else
rlevel=builddata.jzdata.flag-10
end
end
local repairModel=self:getRepairModel(cfg,rlevel)
if builddata.isfinish then
if cfg.sp_ui_model then
repairModel=cfg.sp_ui_model[1]
end
end

local scale=0.25
widget:SetChildUIModelShowTarget(leftitem.iconspine,repairModel,scale,nil,eAnimationID.bd_stand)

widget:SetChildUIModelShowTarget(leftitem.selectspine,5496,1,nil,eAnimationID.stand)
if _this.builditemidx==builditemidx then
widget:SetChildCSImageSprite(leftitem.namebg,_abname,"image_dujiezhibao_3")
widget:SetChildActive(leftitem.selectspine,true)

widget:SetChildLocalPosY(leftitem.dotween,0)
widget:SetChildDOTweenAnimation_DOPlay(leftitem.dotween)
else
widget:SetChildCSImageSprite(leftitem.namebg,_abname,"image_dujiezhibao_2")
widget:SetChildActive(leftitem.selectspine,false)
end

local reddot=DuJieZhiBaoController:getDJZBSingleReddot(buildid)
if reddot then
widget:SetChildCanvasGroupAlpha(leftitem.bxReddot,1)
else
widget:SetChildCanvasGroupAlpha(leftitem.bxReddot,0)
end
widget:SetChildRotation(leftitem.bxReddot,0,0,0)
local tweener=widget:SetChildDOPunchRotation(leftitem.bxReddot,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)

end
function UISectionRepair_flyupward:getRepairModeldjzb(cfg)
if cfg.sp_ui_model then
return cfg.sp_ui_model[0]
end
return cfg.repair_model[1]
end

function UISectionRepair_flyupward:dazaoleftSingle(_jzid,builditemidx)
local widget=_this.leftitems[builditemidx]:getWidgetBase()
local buildid=_jzid
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
local builddata=_this.allZhenWudata[buildid]
local rlevel=1
if builddata.model==1 then
else
if builddata.jzdata.flag>20 then
rlevel=builddata.jzdata.flag-19
else
rlevel=builddata.jzdata.flag-10
end
end
local repairModel=_this:getRepairModel(cfg,rlevel)
if builddata.isfinish then
if cfg.sp_ui_model then
repairModel=cfg.sp_ui_model[1]
end
end

local scale=0.25
widget:SetChildUIModelShowTarget(leftitem.iconspine,repairModel,scale,nil,eAnimationID.bd_stand)
end

function UISectionRepair_flyupward:refreshRight()
local buildid
if self.model==1 then
buildid=self.data.id
else
buildid=self.data.build_id
end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
local levelCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,buildid,1)
self.djzbdestext:setText(levelCfg.build_desc)
self.djzbtitle:setText(cfg.name)
self:dujierefresh(buildid,true,false)
local buffList
if systemModel.isOpen(SYSTEM_DEFINE.eJiuChongTianJie2)then
buffList=JiuChongTianJieEnterModel:getBuffList()
end
self.opendjzbBtn:setActive(buffList and next(buffList)~=nil)
end

function UISectionRepair_flyupward:dujierefresh(buildid,init,playAnim)
local djcfg=cfg_dujietreasuresconfig_get(buildid)
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
_this.islock=false
_this.isitemidlock=0
_this.lhlock=false

local jiachengdesc=djcfg.jiachengdesc
self.djzbzwtxt:setText(jiachengdesc or"")

local thisbuilddata=nil
for k,v in pairs(self.allZhenWudata)do
if v.jzid==buildid then
thisbuilddata=v
end
end

self.jdupanel:setActive(false)
self.bxbtn:setActive(true)
self.proSkillInfo:setActive(true)
self.lhpanel:setActive(false)
self.lockpanel:setActive(false)
self.dazaopanel:setActive(false)
self.rewardGrid:setActive(false)
self.dazaobtn:setActive(false)
self.finishbtn:setActive(false)
self.cddjzbPanel:setActive(false)
self.djzbfinishtxtbg:setActive(false)
self.djzbjumpbtn:setActive(false)
self:djzbRewardReddot(buildid)


local pass,tips=zongmenControl:checkBuildingPassRepairCondition(buildid)
if not pass then

self.jdupanel:setActive(true)
self.bxbtn:setActive(false)
self.proSkillInfo:setActive(false)
self.lockpanel:setActive(true)
self.locktxt:setText(tips or"")
local max_stage=allcfg.max_stage
local jduanstr=FMT.fmt('修筑阶段:<color=#ca631d> 0/{0}</color>',max_stage)
self.jdtxt:setText(jduanstr)
else

local checkOpen=DuJieZhiBaoController:checkOpen(192)

if not checkOpen then
local checkOpen2=DuJieZhiBaoController:checkOpen(169)

local _str=""
if not checkOpen2 then
_str=allcfg.desc or""
else
local coldDay=DuJieZhiBaoController:getColdDay(192)

if coldDay>0 then
local _time=timeHelper.format_time_stamp8(coldDay)
_str=FMT.fmt("{0}后开启",_time)
else
_str=allcfg.desc or""
end
end

self.jdupanel:setActive(true)
self.bxbtn:setActive(false)
self.proSkillInfo:setActive(false)
self.lockpanel:setActive(true)
self.locktxt:setText(_str)
local max_stage=allcfg.max_stage
local jduanstr=FMT.fmt('修筑阶段:<color=#ca631d> 0/{0}</color>',max_stage)
self.jdtxt:setText(jduanstr)
else
local stage=thisbuilddata.stage
if stage==buildstate.weidoing then
self:showpanel(buildid,1,-1,init)
elseif stage==buildstate.doing then
if thisbuilddata.jzdata.flag then
if thisbuilddata.jzdata.flag==11 or thisbuilddata.jzdata.flag==21 then
self:showpanel(buildid,1,thisbuilddata.jzdata.flag,init)
elseif thisbuilddata.jzdata.flag==12 or thisbuilddata.jzdata.flag==22 then
self:showpanel(buildid,2,thisbuilddata.jzdata.flag,init)
end
end
elseif stage==buildstate.finish then
self:showpanel(buildid,3,thisbuilddata.jzdata.flag,init)
end
end
end
end

function UISectionRepair_flyupward:showpanel(_buildid,_flag,_bidflag,init)


local flag=_flag
local bidflag=_bidflag
local buildid=_buildid
local thisbuilddata=nil
for k,v in pairs(self.allZhenWudata)do
if v.jzid==buildid then
thisbuilddata=v
break
end
end
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local feisheng_cfg=allcfg.server_reduce_conf
local fs_data=nil
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
local now_rate=0
if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end

if flag==1 then

if bidflag==11 then

self.dazaopanel:setActive(true)
self.jinduflag=1
local max_stage=allcfg.max_stage
local jduanstr=FMT.fmt('修筑阶段:<color=#ca631d> 0/{0}</color>',max_stage)
self.jdtxt:setText(jduanstr)
self.jdtxt2:setText(jduanstr)
local _stage=thisbuilddata.stage
if _stage==buildstate.doing then
local un_build_id=thisbuilddata.jzdata.un_build_id
local cddata=buildingCDControl:getCDData(buildingCDType.build,un_build_id,true)

if cddata then

self.cddjzbPanel:setActive(true)
self.timedjzb2:setText(timeHelper.format_time_stamp11(math.floor(cddata.cd)))
self.winlua:SetChildUIProgressbar(self.cddjzbProgress:getID(),cddata.dtime,cddata.ntime)
if cddata.complete then
self.dazaobtn:setActive(false)
self.finishbtn:setActive(true)
else
self.dazaobtn:setActive(false)
self.finishbtn:setActive(false)
end
self:djzbstopCOuntDown()
if not cddata.complete then
self:djzbstartCountDown(buildid,un_build_id,nil)
else
self.timedjzb2:setText('已完成')
self.djzbcdimg:setActive(false)
end
end


end
elseif bidflag==21 then

self.jinduflag=2
local refine_rate2=allcfg.refine_rate[2]
if fs_data then
local rate=fs_data[3]
local rate2=100-rate
refine_rate2=refine_rate2*(rate2/100)
end
local now_rate2=0
if DuJiedata and DuJiedata[buildid]then
now_rate2=DuJiedata[buildid].refine_rate or 0
end
local max_stage=allcfg.max_stage
local jduanstr=FMT.fmt('修筑阶段:<color=#ca631d> 1/{0}</color>',max_stage)
self.jdtxt:setText(jduanstr)
self.jdtxt2:setText(jduanstr)

if now_rate2>=refine_rate2 then
self.dazaopanel:setActive(true)
self.rewardGrid:setActive(true)
self.dazaobtn:setActive(true)
self:refreshdazaoinfo(buildid,2)
else
self.jdupanel:setActive(true)
self.lhpanel:setActive(true)
self:refreshnowjindu(now_rate2,refine_rate2,init,true)
self:lhcostnum(0)
self:setDropdowns()
self:setSelectItems()
end
else

self.jinduflag=1
local refine_rate=allcfg.refine_rate[1]
if fs_data then
local rate=fs_data[3]
local rate2=100-rate
refine_rate=refine_rate*(rate2/100)
end

local max_stage=allcfg.max_stage
local jduanstr=FMT.fmt('修筑阶段:<color=#ca631d> 0/{0}</color>',max_stage)
self.jdtxt:setText(jduanstr)
self.jdtxt2:setText(jduanstr)

if now_rate>=refine_rate then
self.dazaopanel:setActive(true)
self.rewardGrid:setActive(true)
self.dazaobtn:setActive(true)
self:refreshdazaoinfo(buildid,1)
else
self.jdupanel:setActive(true)
self.lhpanel:setActive(true)
self:refreshnowjindu(now_rate,refine_rate,init,true)
self:lhcostnum(0)
self:setDropdowns()
self:setSelectItems()
end
end

elseif flag==2 then

if bidflag==12 then

self.dazaopanel:setActive(true)

self.jinduflag=2
local max_stage=allcfg.max_stage
local jduanstr=FMT.fmt('修筑阶段:<color=#ca631d> 1/{0}</color>',max_stage)
self.jdtxt:setText(jduanstr)
self.jdtxt2:setText(jduanstr)
local _stage=thisbuilddata.stage
if _stage==buildstate.doing then
local un_build_id=thisbuilddata.jzdata.un_build_id
local cddata=buildingCDControl:getCDData(buildingCDType.build,un_build_id,true)

if cddata then

self.cddjzbPanel:setActive(true)
self.timedjzb2:setText(timeHelper.format_time_stamp11(math.floor(cddata.cd)))
self.winlua:SetChildUIProgressbar(self.cddjzbProgress:getID(),cddata.dtime,cddata.ntime)
if cddata.complete then
self.dazaobtn:setActive(false)
self.finishbtn:setActive(true)
else
self.dazaobtn:setActive(false)
self.finishbtn:setActive(false)
end
self:djzbstopCOuntDown()
if not cddata.complete then
self:djzbstartCountDown(buildid,un_build_id,nil)
else
self.timedjzb2:setText('已完成')
self.djzbcdimg:setActive(false)
end
end


end
elseif bidflag==22 then

self.dazaopanel:setActive(true)
self.djzbfinishtxtbg:setActive(true)
self.djzbjumpbtn:setActive(true)
self.jinduflag=2
local max_stage=allcfg.max_stage
local jduanstr2=FMT.fmt('修筑阶段:<color=#ca631d> 1/{0}</color>',max_stage)
self.jdtxt:setText(jduanstr2)
self.jdtxt2:setText(jduanstr2)
end
elseif flag==3 then

self.dazaopanel:setActive(true)
self.djzbfinishtxtbg:setActive(true)
self.djzbjumpbtn:setActive(true)
self.jinduflag=2
local max_stage=allcfg.max_stage
local jduanstr2=FMT.fmt('修筑阶段:<color=#ca631d> 2/{0}</color>',max_stage)
self.jdtxt:setText(jduanstr2)
self.jdtxt2:setText(jduanstr2)
end
end
function UISectionRepair_flyupward:djzbstopCOuntDown()
self:removeCDUpdateFunc('DJZBSRPCD')
end
function UISectionRepair_flyupward:djzbstartCountDown(buildid,un_build_id,deltime)
local cddata=buildingCDControl:getCDData(buildingCDType.build,un_build_id)
self.winlua:SetChildUIProgressbar(self.cddjzbProgress:getID(),cddata.dtime+1,cddata.ntime)
local tick=function()
self.lastTime=cddata.cd
self.timedjzb2:setText(timeHelper.format_time_stamp11(math.floor(cddata.cd)))
self.winlua:SetChildUIProgressbar(self.cddjzbProgress:getID(),cddata.dtime+1,cddata.ntime)
if cddata.complete then
self:djzbstopCOuntDown()
self:dujierefresh(buildid,false,false)
end
end
self:addCDUpdateFunc('DJZBSRPCD',tick)
end

function UISectionRepair_flyupward:fstrefreshleft(_jzid,_builditemidx,_builddata)
local id=_jzid
local builditemidx=_builditemidx
local builddata=_builddata
local rlevel=1
local cddata
if builddata.model==1 then
else
cddata=buildingCDControl:getCDData(buildingCDType.build,builddata.jzdata.un_build_id,true)
if builddata.jzdata.flag>20 then
rlevel=builddata.jzdata.flag-19
else
rlevel=builddata.jzdata.flag-10
end
end
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,id)
local repairModel=self:getRepairModel(cfg,rlevel)
if builddata.isfinish then
if cfg.sp_ui_model then
repairModel=cfg.sp_ui_model[1]
end
end
local repair_move=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'repair_move')
local repairtable=nil
if builddata.isfinish then
repairtable=repair_move[#repair_move]
else
repairtable=repair_move[rlevel]
end

local scale=repairtable[3]

local widget=self.leftitems[builditemidx]:getWidgetBase()
widget:SetChildUIModelShowTarget(leftitem.iconspine,repairModel,scale,nil,eAnimationID.bd_stand)
widget:SetChildUIModelShowTargetOffset(leftitem.iconspine,repairtable[1],repairtable[2])
end

function UISectionRepair_flyupward:djzbRewardReddot(_jzid)
local reddot=DuJieZhiBaoController:getDJZBSingleReddot(_jzid)
local reddot2=DuJieZhiBaoController:checklianhuaSingleReddot(_jzid)
_this.djbxreddot:setActive(reddot)
_this.djbxreddot2:setActive(reddot)
local builditemidx=builditemid[_jzid]
local widget=_this.leftitems[builditemidx]:getWidgetBase()
if reddot or reddot2 then
widget:SetChildCanvasGroupAlpha(leftitem.bxReddot,1)
else
widget:SetChildCanvasGroupAlpha(leftitem.bxReddot,0)
end

end

function UISectionRepair_flyupward:changedjzbRewardReddot()
for k,v in pairs(self.allZhenWudata)do
local _jzid=v.jzid
if _jzid==feishengtaiid then
self:refreshDailyReward()
else
self:djzbRewardReddot(_jzid)
end
end
end

function UISectionRepair_flyupward.on_item_changed(changeType,itemguid,itemid,lastcount,itemcount)
if _this==nil then
return
end
_this:changedjzbRewardReddot()
if _this._buildid then
if _this._buildid==feishengtaiid then
else
_this:refreshRight()
end
end
end

function UISectionRepair_flyupward:djzbtestttts()
local checkOpen=DuJieZhiBaoController:checkOpen(168)

end




function UISectionRepair_flyupward:refreshnowjindu(ltexp,nxltexp,init,reverse)
local curexp=ltexp
local maxexp=nxltexp
local allAddValue=self:getjd()


if init then
self.proAddExp:animateThreeParams(curexp+allAddValue,maxexp,0)
self.proExpProgressbar:animateThreeParams(curexp,maxexp,0)
else
if reverse then
self.proAddExp:animateFourParams(curexp+allAddValue,maxexp,0.5,reverse)
else
self:useHideAddProgress(curexp,maxexp,allAddValue)
end
self.proExpProgressbar:animateFourParams(curexp,maxexp,0.5,reverse)
end

local progressStr=''
if curexp>=maxexp then
progressStr=FMT.fmt('{0}/{1}',maxexp,maxexp)
else
if allAddValue>0 then
progressStr=FMT.fmt('{0}<color=#549327>（+{1}）</color>/{2}',curexp,allAddValue,maxexp)
else
progressStr=FMT.fmt('{0}/{1}',curexp,maxexp)
end
end
self.progressText:setText(progressStr)
end

function UISectionRepair_flyupward:lhcostnum(costnum)
local str=""
local needcount=0
_this.lhlock=false
if moneyConfig.isMoney(_costid)then
needcount=moneyModel.getMoney(_costid)
end
if needcount<costnum then
str=FMT.fmt('<color=#c82c2c>{0}</color>',costnum)
_this.lhlock=true
else
str=tostring(costnum)
end
self.zstxt:setText(str)
end

function UISectionRepair_flyupward:refreshdazaoinfo(buildid,jieduan)
self.rewardGrid:setActive(true)
self.dazaobtn:setActive(true)
local cfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildid)
local rewards=cfg.repair_cost[jieduan]
_this.islock=false
_this.isitemidlock=0
if rewards and#rewards>0 then
local len=#rewards
self.rewardGrid:setChildLayoutGroupCreateItems(len)
local grids=self.rewardGrid:getChildLayoutGroupGridList()
for i=1,len do
local rewardItem=grids[i-1]
local itemid=rewards[i][1]
local itemnum=rewards[i][2]
local itemcount=""
local havecount=0
local graynum=0
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end

local str2=mathHelper.formatNumber7(itemnum,nil,2)
if havecount>=itemnum then
itemcount=FMT.fmt('{0}',str2)
else
if _this.isitemidlock==0 then
_this.isitemidlock=itemid
end
_this.islock=true
itemcount=FMT.fmt('<color=#c82c2c>{0}</color>',str2)
graynum=0
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=true,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
_this.winlua:SetChildCaptureImageGray(_this.dazaobtn:getID(),false)
if _this.islock then
_this.dzdjreddot:setActive(false)
_this.winlua:SetChildCaptureImageGray(_this.dazaobtn:getID(),true)
else
_this.dzdjreddot:setActive(true)
end
end

function UISectionRepair_flyupward:checkAndShowArrowBtn()
local list=self.allZhenWudata or{}
local len=#list
local showArrow=len>1
self.leftArrow:setActive(showArrow)
self.rightArrow:setActive(showArrow)
if showArrow and not self.showArrowAnim then
self.showArrowAnim=true
local tween1=self.leftArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween1:SetEase(_Ease.InOutSine)
tween1:SetLoops(-1,_LoopType.Yoyo)
local tween2=self.rightArrowImg:setChildDOLocalMoveX(-15,0.75,nil)
tween2:SetEase(_Ease.InOutSine)
tween2:SetLoops(-1,_LoopType.Yoyo)
end
end

function UISectionRepair_flyupward:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UISectionRepair_flyupward:onCloseBtn()
self:closeProvideSelectGrids()
tipsManager.closeTips()
end

function UISectionRepair_flyupward:onSelectItemClick(itemid,index,itemguid,attach)

local lastIndex=self.lastSelectIndex
if lastIndex and lastIndex==index and UIManager:isActive('UITipsWin',true)then
return
end
self.lastSelectIndex=index
local hasItem=itemid~=nil and itemid>0

local isEquip=hasItem and itemsConfig.isEquip(itemid)or false
local selectBagType=isEquip and BAG_TYPE.eEquipBag or BAG_TYPE.eMaterialsBag
local changeSelectBag=selectBagType~=self.selectBagType
self.selectBagType=selectBagType



if changeSelectBag or not self.showDialogue then
self.ScrollView:clearSlowItems()
self:showProvideSelectGrids()
end

if hasItem then
local isMakeByEquip=false
local isMain=false
tipsManager.showTips({formType=TIPS_FORM_TYPE.eOffFeiShengTaiMaterial,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,isMain=isMain,isMakeByEquip=isMakeByEquip},
move=TIPS_MOVE_POS.eCenter})

self:onSelectOneGrid(itemguid,false,index)
end
end

function UISectionRepair_flyupward:onSelectOneGrid(itemguid,isBagGrid,index)
local lastSelectGrid=self.isSelectGrid
self.isSelectGrid=isBagGrid
local lastItemguid=self.selectItemguid
self.selectItemguid=itemguid
local lastSelectIndex=self.selectItemguidIdx
self.selectItemguidIdx=index

if itemguid==nil or isBagGrid==nil or index==nil then
loggerUtil.logErrFMT('传入参数有问题：itemguid：{0} isBagGrid：{1} index：{2}',itemguid,isBagGrid,index)
return
end
if lastSelectGrid==isBagGrid and tostring(lastItemguid)==tostring(itemguid)and lastSelectIndex==index then
return
end

if lastItemguid then
if lastSelectGrid then
self:freshProvideGridSelect(lastItemguid)
elseif lastSelectGrid==false then
if lastSelectIndex then
local _lastItemguid=self.selectList[lastSelectIndex]
if lastItemguid and tostring(_lastItemguid)==tostring(lastItemguid)then
self:freshOneSelectItemSelectBg(lastSelectIndex)
else
self:closeAllSelectItemSelectBg()
end
else
self:closeAllSelectItemSelectBg()
end
end
end
if isBagGrid then
self:freshProvideGridSelect(itemguid)
elseif isBagGrid==false then
if index then
self:freshOneSelectItemSelectBg(index)
else
loggerUtil.logErrFMT('传入选中序号为空')
end
end
end

function UISectionRepair_flyupward:freshProvideGridSelect(itemguid)
local idx=self:getBagItemIdx(itemguid)

if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(1,tostring(self.selectItemguid)==tostring(itemguid)and self.isSelectGrid==true)
else
loggerUtil.logErrFMT('没找到序号的widget：{0}',tostring(itemguid))
end
end
end

function UISectionRepair_flyupward:onClickGridButton(index,itemid,itemguid,selectIndex,isdeletall)
if itemid==-1 then return end
local num=self:getSelectItemNum(itemguid)
if num<=0 then
UIManager.error('物品已达下限')
return
end
tipsManager.closeTips()
local selectIdx=selectIndex or self:getSelectIndex(itemguid)
local isMainItem=self:isMainHole(selectIdx)
local deleteNum=1
if isdeletall then
if self.selectNumList and self.selectNumList[selectIdx]then
deleteNum=self.selectNumList[selectIdx]
end
end
local isFzHole=self:isFzHole(selectIdx)
if isMainItem then
deleteNum=num
elseif isFzHole then
deleteNum=self:getPutNum(selectIdx)
end

self:deleteSelectNum(selectIdx,deleteNum)
num=num-deleteNum
if self:isMainHole(selectIdx)then
if num<=0 or self:getPutNum(selectIdx)<=0 then
self.selectList={}
self.selectNumList={}
self.curPageIndex=1
self.isSetZero=false
self:freshProvideSelectGrids(true)
else
self:freshProvideSelectSingleItemNum(itemguid)
end
else
local onlyHasMainItem=false
local flag=false
if onlyHasMainItem then
flag=self.ScrollView:freshAllItems()
end
if not flag then
if num<=0 then
self:freshProvideSelectSingleGirid(itemguid,false)
end
self:freshProvideSelectSingleItemNum(itemguid)
end
end
self:setSelectItems()



end

function UISectionRepair_flyupward:closeAllSelectItemSelectBg()
for i,v in ipairs(self.itemsList)do
local widget=v:getWidgetBase()
widget:SetChildActive(1,false)
end
end

function UISectionRepair_flyupward:freshOneSelectItemSelectBg(idx)
local slot=self.itemsList[idx]
local itemguid=self.selectList[idx]
local widget=slot:getWidgetBase()
widget:SetChildActive(1,self.isSelectGrid==false and
tostring(self.selectItemguid)==tostring(itemguid)and
self.selectItemguidIdx==idx)
end

function UISectionRepair_flyupward:showProvideSelectGrids()
if self.showDialogue then
self:freshProvideSelectGrids(true)
return
end
self.showDialogue=true
self.selectBg:setActive(true)
self:freshProvideSelectGrids(true)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'1',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)

local elname=element_name[self.nowelement]
local _str=FMT.fmt("可放入<color=#ca631d>{0}</color>材料进行炼化",elname)
self.selpanelttxt:setText(_str)
end

function UISectionRepair_flyupward:closeProvideSelectGrids()
if not self.showDialogue then return end
self.showDialogue=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
self.curPageIndex=1
self.isSetZero=false
self.selectBg:setActive(false)
self.winlua:SetChildDOTweenAnimation_DOPlay(self.selectPanel:getID(),'2',0,3)
self.winlua:SetChildLocalPosY(self.Content:getID(),0)
end

function UISectionRepair_flyupward:onDropdownChange(dropIdx,reIdx)
local isMaterials=self.selectBagType==BAG_TYPE.eMaterialsBag
local typo=isMaterials and(dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eElement)or
dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eItemType1AndType2
local len=#_bag_filter_desc[typo]
local idx=len-1-reIdx

self.curPageIndex=1
self.isSetZero=false
if self.isSelectGrid==true then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end


reIdx=reIdx+1
self.noweStage=reIdx

self:freshProvideSelectGrids(true)
tipsManager.closeTips()
end
function UISectionRepair_flyupward:onDropdownCreate(dropIdx,scrollTrans,contentTrans)
local isMaterials=self.selectBagType==BAG_TYPE.eMaterialsBag
local typo=isMaterials and(dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eElement)or
dropIdx==1 and ITEM_FILTER_TYPE.eStage or ITEM_FILTER_TYPE.eItemType1AndType2
local filterType=typo
local idx=self.filter[filterType]or 0
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=height-(idx)*_dropItemHeight-_dropViewHeight
else
posY=0
end
if posY<=0 then posY=0 end
contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end

function UISectionRepair_flyupward:freshProvideSelectGrids(freshData)
if not self.showDialogue then return end
if freshData then
self:freshBagList()
end
local list=self.bagList
local rNum=#list
local pageNum=_row*_colomn
if rNum<pageNum then rNum=pageNum end
local tRow=math.ceil(rNum/_colomn)
local tPage=math.ceil(rNum/pageNum)
self.tPage=tPage
local curPageIndex=self.curPageIndex
local showNum=curPageIndex*pageNum
local showRow=math.ceil(showNum/_colomn)
if curPageIndex==1 then
self.ScrollView:clearSlowItems()
end
self.ScrollView:freshSlowGrids(showNum,showRow,_colomn,not self.isSetZero)
self.isSetZero=true
end

function UISectionRepair_flyupward:freshProvideSelectSingleItemNum(itemguid)
local idx=self:getBagItemIdx(itemguid)
if idx then
local num=self:getSelectItemNum(itemguid)
local item=bagModel.getItem(itemguid)

if not item then

else
local itemcount=num>0 and FMT.fmt('{0}/{1}',num,item.itemcount)or item.itemcount
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildText(4,itemcount)
end
end
end
end
function UISectionRepair_flyupward:getBagItemIdx(itemguid)
local list=self.bagList or{}
for i,v in ipairs(list)do
if tostring(v.itemguid)==tostring(itemguid)then
return i
end
end
end

function UISectionRepair_flyupward:freshProvideSelectSingleGirid(itemguid,flag)
local idx=self:getBagItemIdx(itemguid)
if idx then
local widget=self.ScrollView:getSlowItemByIndex(idx-1)
if widget then
widget:SetChildActive(10,flag)
end
end
end

function UISectionRepair_flyupward:freshBagList()

local filter={}
local filter2={}

local stage=0
local element=1
if self.noweStage then
stage=self.noweStage
end
if stage>5 then
stage=5
end

if self.nowelement then
element=self.nowelement
end
filter=
{
[ITEM_FILTER_TYPE.eStage]={[ITEM_FILTER_COMPARE.eLessEqulas]={5}},
[ITEM_FILTER_TYPE.eElement]={[ITEM_FILTER_COMPARE.eEquals]={element}}
}
filter2={
[ITEM_FILTER_TYPE.eStage]={[ITEM_FILTER_COMPARE.eLessEqulas]={stage}},
[ITEM_FILTER_TYPE.eElement]={[ITEM_FILTER_COMPARE.eEquals]={element}}
}




local buildid=_this._buildid
local cfgrefine_conf=cfg_dujietreasuresconfig_get(buildid).refine_conf

local _bagList=bagControl.getBagItemsByFilter(self.selectBagType,filter)

local bagList={}
if _bagList then
for k,v in ipairs(_bagList)do
local config=itemsConfig.getConfig(v.itemid)
if config.element and cfgrefine_conf[v.itemid]then
table.insert(bagList,v)
end
end
end
local sortTag={}
for i,v in ipairs(bagList)do
local itemid=v.itemid
local itemguidStr=tostring(v.itemguid)


local itemCfg=itemsConfig.getConfig(itemid)











sortTag[itemguidStr]=itemCfg.stage*1000000+itemCfg.color*100000+itemid
end
table.sort(bagList,function(a,b)
return sortTag[tostring(a.itemguid)]<sortTag[tostring(b.itemguid)]
end)


















self.bagList=bagList


local _bagList2=bagControl.getBagItemsByFilter(self.selectBagType,filter2)
local bagList2={}
if _bagList2 then
for k,v in ipairs(_bagList2)do
local config=itemsConfig.getConfig(v.itemid)
if config.element and cfgrefine_conf[v.itemid]then
table.insert(bagList2,v)
end
end
end
local sortTag2={}
for i,v in ipairs(bagList2)do
local itemid=v.itemid
local itemguidStr=tostring(v.itemguid)
local itemCfg=itemsConfig.getConfig(itemid)

sortTag2[itemguidStr]=itemCfg.stage*1000000+itemCfg.color*100000+itemid
end
table.sort(bagList2,function(a,b)
return sortTag2[tostring(a.itemguid)]<sortTag2[tostring(b.itemguid)]
end)
self.bagListonekey=bagList2

end

function UISectionRepair_flyupward:isLock(itemid)
return false
end

function UISectionRepair_flyupward:isPutAnyHoleByGUID(itemguid)
return false
end

function UISectionRepair_flyupward:bindGrid(index,widget)
local itemInfo=self.bagList[index]
local isTemp=itemInfo==nil
local hasPutMainItem=true
local inGray=not hasPutMainItem or false
if not isTemp then
local count=itemInfo.itemcount
local itemcount=itemInfo.itemcount or 0
local itemid=itemInfo.itemid
local itemguid=itemInfo.itemguid or-1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local iconName=iconHelper.getIconName(itemid)
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=itemConfig.stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local num=self:getSelectItemNum(itemguid)
local has=num>0
local itemTxt=num>0 and FMT.fmt('{0}/{1}',num,itemInfo.itemcount)or itemInfo.itemcount>1 and itemInfo.itemcount or''
local showbg=true
local islock=not hasPutMainItem and self:isLock(itemid)or false
local showStage=itemConfig.stage~=nil
local needNum=0
local isGray=needNum>itemcount and inGray or islock or false
local isSelect=tostring(self.selectItemguid)==tostring(itemguid)and self.isSelectGrid==true

widget:SetChildActive(0,true)
widget:SetChildActive(1,isSelect)
widgetHelper.setItemQulaity(widget,itemid,2)
widget:SetChildImageExGray(2,isGray)
widget:SetChildIcon(3,iconName,false)
widget:SetChildImageExGray(3,isGray)
widget:SetChildText(4,itemTxt)
widget:SetChildActive(5,itemTxt~='')
widget:SetChildText(6,stageStr)
widget:SetChildText(7,'')
widget:SetChildActive(8,showStage)
widget:SetChildActive(9,islock)
widget:SetChildActive(10,has)
widget:SetChildButtonClick(10,function()self:onClickGridButton(index,itemid,itemguid)end,true)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid)
widget:SetChildButtonClick(-1,function()
self:onClickGrid(itemid,index,itemguid,nil)
end)
else
widget:SetChildActive(0,true)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,false)
widget:SetChildText(4,'')
widget:SetChildActive(5,false)
widget:SetChildText(6,'')
widget:SetChildText(7,'')
widget:SetChildActive(8,false)
widget:SetChildActive(9,false)
widget:SetChildActive(10,false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildButtonClick(-1,function()
self:onClickGrid(-1,index,-1,nil)
end)
end
end

function UISectionRepair_flyupward:onClickGrid(itemid,index,itemguid,attach)
if itemid==-1 then return end
local comCfg=fabaoConfig.getCommonConfig()
local itemConfig=itemsConfig.getConfig(itemid)
local stage=itemConfig.stage
local isEquip=itemsConfig.isEquip(itemid)
local refstage=stage
if isEquip then
refstage=comCfg.stage[stage]or nil
end

local hasMain=self:hasPutMainItem()

if refstage and not hasMain then
local systemLimit=comCfg.system
local sysid=systemLimit[refstage]
if sysid then
local isOpen=systemModel.isOpen(sysid)
if not isOpen then
local tips=systemModel.getOpenTips(sysid)
UIManager.info(tips)
return
end
end
end

local item=bagModel.getItem(itemguid)
local num=item.itemcount
local hasPut=self:getSelectItemNum(itemguid)
num=num-hasPut
local needNum=self:getLeftPutNum(itemguid,index)

local maxNum=needNum
if needNum>num then
maxNum=num
end
maxNum=math.min(num,maxNum)

if maxNum<=0 then
UIManager.error("可放入材料已满")
return
end
local selectNumCmpArgs={numFormat='放入：<color=#f1ce78>{0}/{1}</color>',
min=1,max=maxNum,val=maxNum}

local isMain=false

tipsManager.showTips({formType=TIPS_FORM_TYPE.ePutFeiShengTaiMaterial,
itemid=itemid,
itemguid=itemguid,
backType=TIPS_BACK_TYPE.eNone,
attach={index=index,
selectNumCmpArgs=selectNumCmpArgs,
isMain=isMain,
isMakeByEquip=false},
move=TIPS_MOVE_POS.eCenter})

self:onSelectOneGrid(itemguid,true,index)
end

function UISectionRepair_flyupward:getLeftPutNum(itemguid,holeIdx)
local needNum=self:getNeedNumByGUID(nil,itemguid,holeIdx)
return needNum or 0
end

function UISectionRepair_flyupward:getSelectItemNum(itemguid)
if self.selectList==nil then self.selectList={}end
local handle=tostring(itemguid)
local num=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
if tostring(self.selectList[i])==handle then
num=num+self:getPutNum(i)
end
end
return num
end
function UISectionRepair_flyupward:getIdxArray()
local array
if self:isMakeByEquip()then
array=_equipIdxArray
else
array=_materialIdxArray
end
return array
end
function UISectionRepair_flyupward:getOneKeyIdxArray()
local array
if self:isMakeByEquip()then
array=_equipIdxOneKeyArray
else
array=_materialIdxOneKeyArray
end
return array
end
function UISectionRepair_flyupward:isMakeByEquip()
return false
end
function UISectionRepair_flyupward:getPutNum(idx)
return self.selectNumList[idx]or 0
end
function UISectionRepair_flyupward:deletePutNum(idx,num)
local num1=self:getPutNum(idx)-num
if num1<=0 then num1=0 end
self.selectNumList[idx]=num1
end
function UISectionRepair_flyupward:deleteSelectNum(index,num)

self:deletePutNum(index,num)
if self:getPutNum(index)<=0 then
self.selectList[index]=nil
end
end
function UISectionRepair_flyupward:getSelectIndex(itemguid)
if self.selectList==nil then self.selectList={}end
local array=self:getIdxArray()
local len=#array
for i=len,1,-1 do
local index=array[i]
if tostring(self.selectList[index])==tostring(itemguid)then
return index
end
end
end
function UISectionRepair_flyupward:isMainHole(idx)
return false
end
function UISectionRepair_flyupward:isFzHole(idx)
return false
end
function UISectionRepair_flyupward:isJHIdxHole(idx)
return false
end
function UISectionRepair_flyupward:hasPutMainItem()
return true
end
function UISectionRepair_flyupward:getMainGUID()
return nil
end

function UISectionRepair_flyupward:setDropdowns()














end

function UISectionRepair_flyupward:setSelectItems()

local isNotSelectGrid=self.isSelectGrid==false
local hasSelect=false
local itemsList=self.itemsList
if self.selectList==nil then self.selectList={}end

for i,v in ipairs(itemsList)do
if not self:isMainHole(i)then
local itemguid=self.selectList[i]
local item=itemguid and bagModel.getItem(itemguid)or nil
local isSelect=itemguid and self.isSelectGrid==false and tostring(self.selectItemguid)==tostring(itemguid)and self.selectItemguidIdx==i or false
hasSelect=isSelect or hasSelect

local itemcount=''
local hasNum=self:getPutNum(i)

if hasNum>1 and item then

itemcount=hasNum
end
local conf={showname=false,itemcount=itemcount,showCountBG=itemcount~='',select=isSelect}
v:setChildPropData(self:getSelectFillData(i,item,conf))
end
end






if isNotSelectGrid and not hasSelect then
self.selectItemguidIdx=nil
self.selectItemguid=nil
end

self:refreshjdandzs()
end

function UISectionRepair_flyupward:getNeedNumByGUID(mainguid,guid,fillIdx)
local _guid=self.selectList[fillIdx]
if _guid and tostring(guid)~=tostring(guid)then return end
local num=self:getMaxNumByItemguid(guid)
return num
end
function UISectionRepair_flyupward:getSelectFillData(index,item,conf)
local prop
if item==nil then
prop=self:getSelectTempFillData(index)
prop[PropIndex(DataPropKey.eWidgetActive,8)]=false
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=true
else
prop=itemsComponentHelper.getCommonFillData(item,conf)
local itemConfig=itemsConfig.getConfig(item.itemid)
local showStage=itemConfig.stage~=nil
prop[PropIndex(DataPropKey.eWidgetActive,8)]=showStage
prop[PropIndex(DataPropKey.eWidgetActive,9)]=false
prop[PropIndex(DataPropKey.eWidgetActive,10)]=false
end
prop[DataPropKey.eItemIndex]=index
return prop
end
function UISectionRepair_flyupward:getSelectTempFillData(index)
local conf={}
conf.showbg=true
return itemsComponentHelper.getTempFillData(conf)
end
function UISectionRepair_flyupward:freshAllItems()
if self.selectBagType~=BAG_TYPE.eEquipBag then
self.curPageIndex=1
self.isSetZero=false
self:freshProvideSelectGrids(true)
return true
end
return false
end
function UISectionRepair_flyupward:hasPutAny()
local array=self:getIdxArray()
for _,i in ipairs(array)do
if self:getPutNum(i)>0 then
return true
end
end
return false
end

function UISectionRepair_flyupward:onBtnReset()
if self:hasPutAny()then
local selectList=table.deepCopy(self.selectList)
for _,itemguid in pairs(selectList)do
self:freshProvideSelectSingleGirid(itemguid,false)

self:freshProvideSelectSingleItemNum(itemguid)
end
self.selectList={}
self.selectNumList={}
self.lastSelectIndex=nil
self:setSelectItems()



self:freshAllItems()

tipsManager.closeTips()
end
end

function UISectionRepair_flyupward:onBtnOnekey()

local isChange=false
local mainguid=self:getMainGUID()
local moniSelectList={}
local moniSelectNumList={}
local array=self:getIdxArray()
for _,i in ipairs(array)do
moniSelectList[i]=self.selectList[i]
moniSelectNumList[i]=self:getPutNum(i)
end

local flag=self.jinduflag
local buildid=self._buildid
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local refine_rate=allcfg.refine_rate[flag]
local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local feisheng_cfg=allcfg.server_reduce_conf
local fs_data=nil
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
if fs_data then
local rate=fs_data[3]
local rate2=100-rate
refine_rate=refine_rate*(rate2/100)
end
local cfg_refine_conf=cfg_dujietreasuresconfig_get(buildid).refine_conf

local getMaxNumByItemguid=function(guid)
local neednum=0
local allnumjd=0
for _,i in ipairs(array)do
local itemguid=moniSelectList[i]
local itemguid_num=moniSelectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local refine_conf=cfg_refine_conf[itemid]
local costnum=refine_conf
allnumjd=allnumjd+costnum*itemguid_num
end
end

end
local now_rate=0
if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end
now_rate=now_rate+allnumjd
local chaeNum=refine_rate-now_rate


if chaeNum<=0 then
return 0
end
local this_item=bagModel.getItem(guid)
local this_itemid=this_item.itemid
local this_refine_conf=cfg_refine_conf[this_itemid]
local singlevalue=this_refine_conf
neednum=math.ceil(chaeNum/singlevalue)


return neednum
end


local _getSelectItemNum=function(itemguid)
local handle=tostring(itemguid)
local num=0
for _,i in ipairs(array)do
if tostring(moniSelectList[i])==handle then
num=num+(moniSelectNumList[i]or 0)
end
end
return num
end

local _getLeftNum=function(itemguid)
local num=_getSelectItemNum(itemguid)or 0
local item=bagModel.getItem(itemguid)
local itemcount=item.itemcount
return itemcount-num
end

local _getNextFillItemGuid=function(holeIdx)
local bagList=self.bagListonekey or{}
for i,v in ipairs(bagList)do
local left=_getLeftNum(v.itemguid)
local needNum=self:getNeedNumByGUID(nil,v.itemguid,holeIdx)
local addNum=needNum
if needNum>left then
addNum=left
end
local fillNum=math.min(left,addNum)
if fillNum>0 then
return v.itemguid,left,i
end
end
end

local _getMainFillGuid=function()
local bagList=self.bagList or{}
return nil
end
local _addItem=function(index,itemguid,num)

local handle=tostring(itemguid)
local ishasidx=false
for _,i in ipairs(array)do
local guid=moniSelectList[i]
local guidStr=tostring(guid)
if guid~=nil and guidStr==handle then
ishasidx=i
break
end
end
if ishasidx then
moniSelectNumList[ishasidx]=moniSelectNumList[ishasidx]+num
else
moniSelectList[index]=itemguid
moniSelectNumList[index]=moniSelectNumList[index]+num
end
end














local array_=self:getOneKeyIdxArray()
for _,i in ipairs(array_)do
local hasNum=moniSelectNumList[i]or 0
if self:isMainHole(i)then
local needNum=self:getNeedNumByGUID(nil,mainguid,i)
local canAddNum=needNum-hasNum
local leftNum=_getLeftNum(mainguid)
local fillNum=math.min(leftNum,canAddNum)
if fillNum>0 then
_addItem(i,mainguid,fillNum)
isChange=true
self:freshProvideSelectSingleItemNum(mainguid)
self:freshProvideSelectSingleGirid(mainguid,true)
end
else

local itemguid=moniSelectList[i]
if itemguid==nil then
local guid=_getNextFillItemGuid(i)
itemguid=guid
end
if itemguid then
local leftNum=_getLeftNum(itemguid)
local needNum=getMaxNumByItemguid(itemguid)

local addNum=needNum
if needNum>leftNum then
addNum=leftNum
end
local fillNum=math.min(leftNum,addNum)

if fillNum>0 then
_addItem(i,itemguid,fillNum)
self:freshProvideSelectSingleItemNum(itemguid)
self:freshProvideSelectSingleGirid(itemguid,true)
end
isChange=true
end
end
end
if isChange then
self.lastSelectIndex=nil
for _,i in ipairs(array)do
self.selectList[i]=moniSelectList[i]
self:setPutNum(i,moniSelectNumList[i]or 0)
end

self:freshAllItems()
self:setSelectItems()


end
tipsManager.closeTips()
end

function UISectionRepair_flyupward:refreshjdandzs()
if self.jinduflag and self._buildid then
local flag=self.jinduflag
local buildid=self._buildid
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local refine_rate=allcfg.refine_rate[flag]


local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local feisheng_cfg=allcfg.server_reduce_conf
local fs_data=nil
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
if fs_data then
local rate=fs_data[3]
local rate2=100-rate
refine_rate=refine_rate*(rate2/100)
end

local now_rate=0
if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end
self:refreshnowjindu(now_rate,refine_rate,false,true)
local num=self:getzscost(now_rate,refine_rate)
self:lhcostnum(num)
end
end

function UISectionRepair_flyupward:getjd()
local cfg_refine_conf=cfg_dujietreasuresconfig_get(self._buildid).refine_conf
local allnumjd=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local refine_conf=cfg_refine_conf[itemid]
local costnum=refine_conf
allnumjd=allnumjd+costnum*itemguid_num
end
end
end

return allnumjd
end

function UISectionRepair_flyupward:getzscost(now_rate,refine_rate)
local cfg_refine_conf=cfg_dujietreasuresconfig_get(self._buildid).refine_conf
local refine_money=cfg_dujietreasuresbasicconfig_get(1).refine_money
local allnumcost=0
local allnumjd=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local refine_conf=cfg_refine_conf[itemid]
local costnum=refine_conf
allnumjd=allnumjd+costnum*itemguid_num
end
end
end
local chazhi=refine_rate-now_rate
if allnumjd>chazhi then
allnumjd=chazhi
end
allnumcost=allnumjd*refine_money

return allnumcost
end

function UISectionRepair_flyupward:getMaxNumByItemguid(guid)





local neednum=0
if self.jinduflag and self._buildid then
local flag=self.jinduflag
local buildid=self._buildid
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local now_rate=0
local refine_rate=allcfg.refine_rate[flag]


local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local feisheng_cfg=allcfg.server_reduce_conf
local fs_data=nil
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
if fs_data then
local rate=fs_data[3]
local rate2=100-rate
refine_rate=refine_rate*(rate2/100)
end


if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end


local cfg_refine_conf=cfg_dujietreasuresconfig_get(self._buildid).refine_conf
local allnumjd=0
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local refine_conf=cfg_refine_conf[itemid]
local costnum=refine_conf
allnumjd=allnumjd+costnum*itemguid_num
end
end
end
now_rate=now_rate+allnumjd


local chaeNum=refine_rate-now_rate
if chaeNum<=0 then
return 0
end


local this_item=bagModel.getItem(guid)
local this_itemid=this_item.itemid
local this_refine_conf=cfg_refine_conf[this_itemid]
local singlevalue=this_refine_conf
neednum=math.ceil(chaeNum/singlevalue)
end

return neednum
end

function UISectionRepair_flyupward:getAllJinDuYiChu(_buildid)


local buildid=_buildid
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local feisheng_cfg=allcfg.server_reduce_conf
local fs_data=nil
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
local refine_rate=allcfg.refine_rate[self.jinduflag]
if fs_data then
local rate=fs_data[3]
local rate2=100-rate
refine_rate=refine_rate*(rate2/100)
end
local now_rate=0
if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end


end

function UISectionRepair_flyupward:putItem(index,itemid,itemguid,fillnum)
if itemid==-1 then return end
local putFinish=itemid~=nil
local handle=tostring(itemguid)
local num=self:getSelectItemNum(itemguid)
local item=bagModel.getItem(itemguid)
local lastHasMain=self:hasPutMainItem()
local itemcount=item.itemcount
if num>=itemcount then
UIManager.error('物品已达上限')
tipsManager.closeTips()
return
end
local fillIdx=self:getNextFillIdx(itemguid)
if fillIdx==nil then
UIManager.error('可放入材料已满')
tipsManager.closeTips()
return
end
local lastFillNum=self:getPutNum(fillIdx)
local isMainHole=self:isMainHole(fillIdx)
local fillBagType=BAG_TYPE.eMaterialsBag
local isFzHole=self:isFzHole(fillIdx)
local isJhHole=self:isJHIdxHole(fillIdx)
local changeBagType=fillBagType~=self.selectBagType
if itemsConfig.isEquip(item.itemid)and not isMainHole then
UIManager.error('装备只能作为主材料')
return
end
local lastNum=num
local addNum=1
local curNum=num+addNum
if isMainHole or isFzHole or isJhHole then
local mainItemguid=self:getMainGUID()
local needNum=self:getNeedNumByGUID(mainItemguid,itemguid,fillIdx)
local leibie=isMainHole and'主材料'or
isFzHole or'副材料'or
'炼化材料'
if needNum and itemcount<needNum then
local itemName=itemsConfig.getConfig(itemid).name
UIManager.error(FMT.fmt('{0}数量不足以作为{3}({1}/{2})',itemName,itemcount,needNum,leibie))
gainControl:showGainWin(itemid)
return
end
addNum=needNum
curNum=addNum
else
addNum=fillnum
end
if lastNum==0 then
self:freshProvideSelectSingleGirid(itemguid,true)
end

self:addSelectHole(itemguid,fillIdx,addNum)
self:freshProvideSelectSingleItemNum(itemguid)
self:setSelectItems()



tipsManager.closeTips()
local isMain=isMainHole and not lastHasMain





if changeBagType then
self:freshProvideGrids(fillBagType)
elseif not lastHasMain then

self.ScrollView:freshAllItems()
end
end

function UISectionRepair_flyupward:getNextFillIdx(itemguid,containsJh)
local handle=tostring(itemguid)
local array=self:getIdxArray()
for _,i in ipairs(array)do
local isJHIdxHole=self:isJHIdxHole(i)
if not isJHIdxHole or isJHIdxHole and containsJh then
local guid=self.selectList[i]
if guid==nil or tostring(guid)==handle and not self:isfull(i)then
return i
end
end
end
end
function UISectionRepair_flyupward:isfull(fillIdx)
local guid=self.selectList[fillIdx]
if guid==nil then return false end
local mainItemguid=self:getMainGUID()
local needNum=self:getNeedNumByGUID(mainItemguid,guid,fillIdx)
local hasNum=self:getPutNum(fillIdx)
return hasNum>=needNum
end

function UISectionRepair_flyupward:addSelectHole(itemguid,index,num)
if num<=0 then return end
local array=self:getIdxArray()
local handle=tostring(itemguid)
local mainItemguid=self:getMainGUID()
for _,i in ipairs(array)do
local needNum=self:getNeedNumByGUID(mainItemguid,itemguid,i)
local hasNum=self:getPutNum(i)
local guid=self.selectList[i]
local guidStr=tostring(guid)

if guid==nil or guidStr==handle and needNum>0 then

local add=math.min(num,needNum)
self:addSelectNum(itemguid,i,add)
num=num-add
if num<=0 then
break
end
end
end
end
function UISectionRepair_flyupward:addSelectNum(itemguid,index,num)

local array=self:getIdxArray()
local handle=tostring(itemguid)
local ishasidx=false
for _,i in ipairs(array)do
local guid=self.selectList[i]
local guidStr=tostring(guid)
if guid~=nil and guidStr==handle then
ishasidx=i
break
end
end
if ishasidx then
self:addPutNum(ishasidx,num)
else
self.selectList[index]=itemguid
self:addPutNum(index,num)
end
end
function UISectionRepair_flyupward:addPutNum(idx,num)
self.selectNumList[idx]=self:getPutNum(idx)+num
end
function UISectionRepair_flyupward:setPutNum(idx,num)
self.selectNumList[idx]=num
end

function UISectionRepair_flyupward:takeOffByTips(index,itemid,itemguid)
self.lastSelectIndex=nil
if self.isSelectGrid==false then
if index==self.selectItemguidIdx then
self.selectItemguid=nil
self.selectItemguidIdx=nil
end
end
self:onClickGridButton(nil,itemid,itemguid,index,true)
end

function UISectionRepair_flyupward:onUserbtn()
local buildid=self._buildid
local flag=self.jinduflag
local list={}
if _this.lhlock then
if _costid then
gainControl:showGainWin(_costid)
end
return
end

local allnumcost=0
local cfg_refine_conf=cfg_dujietreasuresconfig_get(buildid).refine_conf
local array=self:getIdxArray()
for _,i in ipairs(array)do
local itemguid=self.selectList[i]
local itemguid_num=self.selectNumList[i]
if itemguid and itemguid_num then
local item=bagModel.getItem(itemguid)
if item then
local itemid=item.itemid
local temp={itemid,itemguid_num}
list[#list+1]=temp

local refine_conf=cfg_refine_conf[itemid]
local costnum=refine_conf
allnumcost=allnumcost+costnum*itemguid_num
end
end
end
if#list==0 then
UIManager.error("未放入炼化材料")
return
end


local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local feisheng_cfg=allcfg.server_reduce_conf
local fs_data=nil
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
local refine_rate=allcfg.refine_rate[flag]
if fs_data then
local rate=fs_data[3]
local rate2=100-rate
refine_rate=refine_rate*(rate2/100)
end
local now_rate=0
if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end
local chanum=now_rate+allnumcost-refine_rate


local addvalue=0
if chanum>0 then
addvalue=refine_rate-now_rate
else
addvalue=allnumcost
end
local _func=function()
local str=FMT.fmt('进度+{0}',addvalue)
commonTipsHelper.addThrowOutAndSliderTipsEx({3,str})
end

if chanum>0 then

local tips=FMT.fmt("当前材料增加的炼化进度会溢出<color=#c82c2c>{0}</color>点，\n溢出值在炼化后将损耗，是否继续？",chanum)
local show_data=
{
title='提示',
_okText="确认",
_cancelText="取消",
tipsText=tips,
closetopbtn=true,
cellcallback=function()
_func()
DuJieZhiBaoController:send_34_32(buildid,#list,list)
end,
}
UIManager:showWindow('UIDialougeNormalTip',show_data)
else
_func()
DuJieZhiBaoController:send_34_32(buildid,#list,list)
end
end

function UISectionRepair_flyupward:onIconbtn()
if _costid then
gainControl:showGainWin(_costid)
end
end

function UISectionRepair_flyupward:onDazaobtn()
if _this.islock then
if _this.isitemidlock and _this.isitemidlock~=0 then
local str=FMT.fmt("{0}不足",itemsConfig.getItemName(_this.isitemidlock))
UIManager.info(str)
gainControl:showGainWin(_this.isitemidlock)
end
return
end
if self.jinduflag and self._buildid then
local model=self.model
local flag=self.jinduflag
local buildid=self._buildid
local un_build_id=self.data.un_build_id
local allcfg=cfg_dujietreasuresbasicconfig_get(1)
local DuJiedata=DuJieZhiBaoModel:getDJZBData()
local refine_rate=allcfg.refine_rate[flag]


local jctjpeople=JiuChongTianJieEnterModel:getOpenTianJiePeople()
local feisheng_cfg=allcfg.server_reduce_conf
local fs_data=nil
for k,v in ipairs(feisheng_cfg)do
if v[1]<=jctjpeople and v[2]>=jctjpeople then
fs_data=v
end
end
if fs_data then
local rate=fs_data[3]
local rate2=100-rate
refine_rate=refine_rate*(rate2/100)
end

local now_rate=0
if DuJiedata and DuJiedata[buildid]then
now_rate=DuJiedata[buildid].refine_rate or 0
end


if now_rate>=refine_rate then
local sfId=zongmenModel:getMountainId()
if model==1 then
local repairData=isometricMapSystem:getRepairDataByID(sfId,buildid)
zongmenControl:reqBuild(sfId,repairData.id,repairData.x,repairData.y,0)
else
zongmenControl:reqBuildingLevelUp(sfId,un_build_id,0,{})
end

self.isdjdz=true
else
logErr("当前修建进度不足，不能打造，请检查")
end
end
end

function UISectionRepair_flyupward:refreshLHdata(_buid)
_this:onBtnReset()
_this:closeProvideSelectGrids()
if _this._buildid==_buid then
_this.nowelement=buildelement[_buid]or 1
_this:refreshjzData()
_this:dujierefresh(_buid,false,false)
end
end


function UISectionRepair_flyupward:onGotoTianJie()
local jumpParam={id=JUMP_TYPE.eJiuChongTianJie}
jumpManager:jump(jumpParam)

end



function UISectionRepair_flyupward:onYetInvite()

UIManager.info("已邀请仙盟盟友协助，每日5点重置邀请")
end



function UISectionRepair_flyupward:refreshDailyReward()

local ishave=FeiShengTaiModel:judeCanRepairFST()or FeiShengTaiModel:GetFSTreddot()


if not ishave then
self.feishengtaiReddot:setActive(false)
self:doPunchRotation(false)
else
self.feishengtaiReddot:setActive(true)
self:doPunchRotation(true)
end
end


function UISectionRepair_flyupward:doPunchRotation(reddot)
if reddot then
if self.reddotTweener==nil then
self.feishengtaiReddot:setRotation(0,0,0)
local tweener=self.feishengtaiReddot:setChildDOPunchRotation(Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self.feishengtaiReddot:setRotation(0,0,0)
end
end
end
