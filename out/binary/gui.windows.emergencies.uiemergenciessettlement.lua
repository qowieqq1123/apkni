







def_class("UIEmergenciesSettlement",UIWindowBase)









function UIEmergenciesSettlement:bindComponents()

self.effect=UIObject.get(self,0)
self.success=UIObject.get(self,1)
self.failure=UIObject.get(self,2)
self.settlementEffect=UIObject.get(self,3)
self.showDataPanel=UIObject.get(self,4)
self.progressItem=UIObject.get(self,5)



end


function UIEmergenciesSettlement:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.success);self.success=nil;
_UIObject_release(self.failure);self.failure=nil;
_UIObject_release(self.settlementEffect);self.settlementEffect=nil;
_UIObject_release(self.showDataPanel);self.showDataPanel=nil;
_UIObject_release(self.progressItem);self.progressItem=nil;
end
















local _successPanelIndex={
tips1=0,
tips2=1,
rewardScrollview=2,
buffDesc=3,
buffIcon=4,
center=5,
filter=6,
}

local _failurePanelIndex={
tips1=0,
tips2=1,
buildScrollview=2,
rewards=3,
rewardIndex={4,5,6},
specialDesc=7,
}


local _speSuccessTipsHandle={
[emergenciesType.eSystemZongMenSpy]=function(cfg)
local nameStr=emergenciesControl:getSystemZongMenSpyName()or""
return FMT.fmt(cfg.desc[1],nameStr)
end,
}

local _this



function UIEmergenciesSettlement:onLoaded(...)
_this=self
self:bindComponents()
end


function UIEmergenciesSettlement:__delete()
self:unbindComponents()
_this=nil
end

function UIEmergenciesSettlement:handleBuildingList(datas)
local list={}
for i,v in ipairs(datas)do
local bdData=zongmenModel:getBuildingData(v.param_2)
list[bdData.build_id]=v
end
local rlist={}
for k,v in pairs(list)do
table_insert(rlist,v)
end
return rlist
end




function UIEmergenciesSettlement:onShow(argtable,afterOnloaded)
self.eventId=argtable[1]
local result=argtable[2]
local buff=argtable[3]
local len=argtable[4]
local datas=argtable[5]
self.closeCB=argtable[6]
self.otherParam=argtable[7]

local isSuccess=result==0
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,self.eventId)
if not isSuccess and not datas and cfg.event_type==emergenciesType.eMonsterInvasion then
datas={}
for i,v in ipairs(cfg.event_conf.reduceMoneyList)do
table.insert(datas,{param_1=v[1],param_2=0})
end
len=#datas
end

self.showDataPanel:setActive(false)
local showFunc=function()
if _this==nil then return end
_this.showDataPanel:setActive(true)
_this.success:setActive(isSuccess)
_this.failure:setActive(not isSuccess)
if isSuccess then
_this:setSuccessPanel(_this.eventId,buff,len,datas)
else
_this:setFailurePanel(_this.eventId,buff,len,datas)
end
end

local delayTime
if isSuccess then
self.settlementEffect:setChildShowEffect(10335,true)
delayTime=2.0
else
self.settlementEffect:setChildShowEffect(10336,true)
delayTime=2.9
end
self:delayDo(delayTime,showFunc)
end

function UIEmergenciesSettlement:setSuccessPanel(eventId,buff,len,datas)
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local panel=self.success:getChildWidgetBase()
local Desc=cfg.desc[1]
Desc=_speSuccessTipsHandle[cfg.event_type]and _speSuccessTipsHandle[cfg.event_type](cfg)or Desc
panel:SetChildText(_successPanelIndex.tips1,Desc)
panel:SetChildActive(_successPanelIndex.rewardScrollview,len>0)
panel:SetChildActive(_successPanelIndex.buffDesc,buff>0)
panel:SetChildActive(_successPanelIndex.filter,buff<=0)
if not self.isInitRS then
panel:SetChildScrollViewInit(_successPanelIndex.rewardScrollview,0,true,nil,nil)
self.isInitRS=true
end

if buff>0 then
local buffcfg=cfgHelper.get1(cfg_guildstateconfig_get,buff)
panel:SetChildText(_successPanelIndex.buffDesc,self:getBuffDesc(buffcfg.effects))
panel:SetChildActive(_successPanelIndex.buffDesc,true)
panel:SetChildCSImageIcon(_successPanelIndex.buffIcon,iconHelper.getzmStateIcon(buffcfg.icon),false)
end

if len>0 then
panel:SetChildScrollViewCreateGrids(_successPanelIndex.rewardScrollview,len,0)
local grids=panel:GetChildScrollViewItemWidgets(_successPanelIndex.rewardScrollview)
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datas[i]
local itemConfig=itemsConfig.getConfig(data.param_1)
local stage=itemConfig.stage
widgetHelper.setNormalRewardItem(item,0,{data.param_1,data.param_2,stage=stage})
item:SetChildText(1,itemsConfig.getItemName(data.param_1))
end
end

panel:ForceLayoutRect(_successPanelIndex.center)

self.effect:setChildShowEffect(10014,true)


AudioManager.playAudio(502)
end

function UIEmergenciesSettlement:setFailurePanel(eventId,buff,len,datas)
local cfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,eventId)
local panel=self.failure:getChildWidgetBase()
panel:SetChildText(_failurePanelIndex.tips1,cfg.desc[2])
panel:SetChildText(_failurePanelIndex.tips2,cfg.desc[3])

panel:SetChildActive(_failurePanelIndex.specialDesc,false)
if cfg.event_type==emergenciesType.eBuildingOnFire then
datas=self:handleBuildingList(datas)
len=#datas
panel:SetChildActive(_failurePanelIndex.buildScrollview,true)
panel:SetChildActive(_failurePanelIndex.rewards,false)
if len>0 then
if not self.isInitBS then
panel:SetChildScrollViewInit(_failurePanelIndex.buildScrollview,0.5,true,nil,nil)
self.isInitBS=true
end
local buildIdList=emergenciesModel:getOnFireBDCfgList(eventId)
panel:SetChildScrollViewCreateGrids(_failurePanelIndex.buildScrollview,len,0)
local grids=panel:GetChildScrollViewItemWidgets(_failurePanelIndex.buildScrollview)
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=datas[i]
local bdData=zongmenModel:getBuildingData(data.param_2)
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local model=bdcfg.model[bdData.level]
local scale=isometricMapSystem:getModelScale(model,true)
item:SetChildUIModelShowTarget(0,model,scale*0.5,nil,eAnimationID.bd_stand)
local edata=buildIdList[bdData.build_id]
if edata[1]==1 then

item:SetChildText(1,FMT.fmt('修复{0}',timeHelper.formatSimpleTime(edata[2],true)))
else
item:SetChildText(1,FMT.fmt('产量降低{0}%',edata[2]))
end
end
end
elseif cfg.event_type==emergenciesType.eMonsterInvasion then
panel:SetChildActive(_failurePanelIndex.buildScrollview,false)
panel:SetChildActive(_failurePanelIndex.rewards,true)
for i=1,3 do
local d=datas[i]
local index=_failurePanelIndex.rewardIndex[i]
if d then
panel:SetChildActive(index,true)
self:setReward(panel,index,d.param_1,-d.param_2)
else
panel:SetChildActive(index,false)
end
end
elseif cfg.event_type==emergenciesType.eJiQuanBuNing then
panel:SetChildActive(_failurePanelIndex.buildScrollview,false)
panel:SetChildActive(_failurePanelIndex.rewards,false)
elseif cfg.event_type==emergenciesType.eYiMuCongSheng then
panel:SetChildActive(_failurePanelIndex.buildScrollview,true)
panel:SetChildActive(_failurePanelIndex.rewards,false)
panel:SetChildText(_failurePanelIndex.tips2,"以下建筑被藤蔓缠绕")
local buildIdList=cfg.event_conf.twine_builds
panel:SetChildScrollViewCreateGrids(_failurePanelIndex.buildScrollview,#buildIdList,0)
local grids=panel:GetChildScrollViewItemWidgets(_failurePanelIndex.buildScrollview)
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local buildId=buildIdList[i]
local bdcfg=cfgHelper.get1(cfg_monijybuildconfig_get,buildId)
local model=bdcfg.model[1]
local scale=isometricMapSystem:getModelScale(model,true)
item:SetChildUIModelShowTarget(0,model,scale*0.5,nil,eAnimationID.bd_stand)
item:SetChildText(1,FMT.fmt('缠绕{0}',timeHelper.formatSimpleTime(cfg.event_conf.reduce_sec)))
end
elseif cfg.event_type==emergenciesType.eYouHunRaoLuan then

panel:SetChildActive(_failurePanelIndex.buildScrollview,false)
panel:SetChildActive(_failurePanelIndex.rewards,false)

panel:SetChildActive(_failurePanelIndex.specialDesc,true)
local count=cfg.event_conf.decloyal
local descList={{name="宗门弟子忠诚度",count=-count},}
self:setSpecialDesc(panel,descList)
elseif cfg.event_type==emergenciesType.eYiShiLaiKe then
panel:SetChildActive(_failurePanelIndex.buildScrollview,false)
panel:SetChildActive(_failurePanelIndex.rewards,false)
elseif cfg.event_type==emergenciesType.eSystemZongMenSpy then
panel:SetChildActive(_failurePanelIndex.buildScrollview,false)
panel:SetChildActive(_failurePanelIndex.rewards,false)

panel:SetChildActive(_failurePanelIndex.specialDesc,true)
local count=cfg.event_conf.dec_def_value
local str=string.format("山门大阵护盾值 <color=#FF0B0B>-%s%%</color>",count)
panel:SetChildText(_failurePanelIndex.specialDesc,str)
self.progressItem:setActive(true)
local curvalue=shanMenDaZhenModel:getShanMenDaZhenShieldValue()
local maxvalue=shanMenDaZhenModel:getShanMenDaZhenShieldMaxValue()
local Widget=self.progressItem:getWidgetBase()
Widget:SetChildProgress(2,curvalue,maxvalue)
Widget:SetChildText(3,string.format("%s%%",math.floor((curvalue/maxvalue)*100)))
end
end

function UIEmergenciesSettlement:setReward(item,index,id,count)
local widget=item:GetChildWidgetBase(index)
widget:SetChildIcon(0,iconHelper.getIconName(id),true)
widget:SetChildText(1,moneyModel.getMoneyName(id))
if count<=0 then
widget:SetChildText(2,FMT.cfmt(FONT_COLOR.eRedColor,'{0}',count))
else
widget:SetChildText(2,FMT.cfmt(FONT_COLOR.eGreenColor,'+{0}',count))
end
end

function UIEmergenciesSettlement:getBuffDesc(effects)
local desc=''
for i,v in ipairs(effects)do
local ds=homeBuffModel:getBuffDesc(v)
desc=FMT.fmt('{0}\n{1}',desc,ds)
end
desc=string.gsub(desc,'\n','',1)
return desc
end


function UIEmergenciesSettlement:setSpecialDesc(widget,descList)
local str=""

for i=1,#descList do
local name=descList[i].name
local count=descList[i].count
local countStr=""
if count<=0 then
countStr=FMT.cfmt(FONT_COLOR.eRedColor,'{0}',count)
else
countStr=FMT.cfmt(FONT_COLOR.eGreenColor,'+{0}',count)
end

local descItemStr=FMT.fmt("{0} {1}",name,countStr)

if i<=1 then
str=descItemStr
else
str=FMT.fmt("{0}\n{1}",str,descItemStr)
end
end

widget:SetChildText(_failurePanelIndex.specialDesc,str)
end


function UIEmergenciesSettlement:onHide()

end




function UIEmergenciesSettlement:onCloseClick()
if self.closeCB then
self.closeCB(self.eventId)
end
self:closeSelf()
end
