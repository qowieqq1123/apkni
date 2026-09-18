







def_class("UIRecruitJZAPWin",UIWindowBase)









function UIRecruitJZAPWin:bindComponents()

self.back=UIObject.get(self,0)
self.tdName=UIText.get(self,1)
self.info2=UIObject.get(self,2)
self.tedian=UIButton.get(self,3)
self.info1=UIObject.get(self,4)
self.zyScrollView=UIObject.get(self,5)
self.jzScrollview=UIObject.get(self,6)
self.lgScrollView=UIObject.get(self,7)
self.cost1=UIObject.get(self,8)
self.cost2=UIObject.get(self,9)
self.title=UIText.get(self,10)
self.tips=UIText.get(self,11)
self.countdown=UIText.get(self,12)
self.peiyang=UIButton.get(self,13)
self.infoTips=UIText.get(self,14)
self.infoTime=UIObject.get(self,15)
self.gotoBtn=UIButton.get(self,16)
self.countdown2=UIText.get(self,17)

self.tedian:setButtonClick(function()self:onTedian()end)

self.peiyang:setButtonClick(function()self:onPeiyang()end)

self.gotoBtn:setButtonClick(function()self:onGotoBtn()end)



end


function UIRecruitJZAPWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.tdName);self.tdName=nil;
_UIObject_release(self.info2);self.info2=nil;
_UIObject_release(self.tedian);self.tedian=nil;
_UIObject_release(self.info1);self.info1=nil;
_UIObject_release(self.zyScrollView);self.zyScrollView=nil;
_UIObject_release(self.jzScrollview);self.jzScrollview=nil;
_UIObject_release(self.lgScrollView);self.lgScrollView=nil;
_UIObject_release(self.cost1);self.cost1=nil;
_UIObject_release(self.cost2);self.cost2=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.countdown);self.countdown=nil;
_UIObject_release(self.peiyang);self.peiyang=nil;
_UIObject_release(self.infoTips);self.infoTips=nil;
_UIObject_release(self.infoTime);self.infoTime=nil;
_UIObject_release(self.gotoBtn);self.gotoBtn=nil;
_UIObject_release(self.countdown2);self.countdown2=nil;
end
















local _this




function UIRecruitJZAPWin:onLoaded(...)
self:bindComponents()

_this=self
self.zmtimers={}


self.lgColors={'#ae8434','#549327','#3375c0','#c82c2c','#7d3b17'}

self.abName='ui/windows/recruit/sharedtextures/jiazuzhaomu.ab'

self.jzScrollview:setChildScrollViewInit(0.5,true,self.on_jz_item_click,nil)
self.zyScrollView:setChildScrollViewInit(0,true,self.on_zy_item_click,nil)
self.lgScrollView:setChildScrollViewInit(0,true,self.on_lg_item_click,nil)
end

function UIRecruitJZAPWin.on_jz_item_click(clicknum,index)
if _this.selectIndex==index then
return
end
_this:clearSelect()
if _this.selectIndex then
local item=_this.jzScrollview:getChildScrollViewItemWidget(_this.selectIndex)
item:SetChildActive(0,false)
end
_this.selectIndex=index
local item=_this.jzScrollview:getChildScrollViewItemWidget(_this.selectIndex)
item:SetChildActive(0,true)
local data=_this.datas[index+1]
local cfg=cfgHelper.get1(cfg_xiuzhenfamilydataconfig_get,data.familyId)
_this:refreshZYList(cfg.voc_citiao)
_this:refreshCost(data.sdata)
_this:refreshLGList()

local fdata=data.fdata
local showTD=not fdata
_this.tedian:setActive(showTD)
if showTD then
_this.tdId=data.sdata.tedianId
local tdcfg=cfgHelper.get1(cfg_xiuzhenfamilycharacteristicconfig_get,_this.tdId)
local tdStr=_this.tdId>0 and tdcfg.name or'无特点'
_this.tdName:setText(tdStr)
_this.tedian:setActive(_this.tdId>0)
end

_this.recruiting=not showTD

_this.info1:setActive(showTD)
_this.info2:setActive(not showTD)
if not showTD then
local stime=gameUtilityModel.getServerShortTime()
local dt=fdata.endtime-stime
local isRecruit=dt>0
_this.infoTime:setActive(isRecruit)
_this.gotoBtn:setActive(not isRecruit)
if isRecruit then
_this:setRecruitInfo(fdata)
_this:startPageTimer(dt)
else
_this.infoTips:setText('已完成此次招募，请祖师查验弟子资质')
end
else
_this:clearPageTimer()
end
end

function UIRecruitJZAPWin:setRecruitInfo(fdata)
local jycfg=cfgHelper.get1(cfg_disciplevocationconfig_get,fdata.voc)
local spcfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,fdata.spiritrootid)
self.infoTips:setText(FMT.fmt('该家族正在培养<color={2}>{0}{1}</color>弟子',spcfg.name,jycfg.name,self.lgColors[fdata.spiritrootid]))
end

function UIRecruitJZAPWin.on_zy_item_click(clicknum,index)
local data=_this.jydatas[index+1]
if not data.isUnlock then

local tipsStr=data.lockTips
UIManager.error(tipsStr)
return
end
if _this.recruiting then
UIManager.error('招募中')
return
end
if _this.zySelect then
local item=_this.zyScrollView:getChildScrollViewItemWidget(_this.zySelect)
item:SetChildActive(2,false)
end
_this.zySelect=index
local item=_this.zyScrollView:getChildScrollViewItemWidget(_this.zySelect)
item:SetChildActive(2,true)
end

function UIRecruitJZAPWin.on_lg_item_click(clicknum,index)
if _this.recruiting then
UIManager.error('招募中')
return
end
if _this.lgSelect then
local item=_this.lgScrollView:getChildScrollViewItemWidget(_this.lgSelect)
item:SetChildActive(2,false)
end
_this.lgSelect=index
local item=_this.lgScrollView:getChildScrollViewItemWidget(_this.lgSelect)
item:SetChildActive(2,true)
end

function UIRecruitJZAPWin:clearSelect()
if self.zySelect then
local item=self.zyScrollView:getChildScrollViewItemWidget(self.zySelect)
item:SetChildActive(2,false)
self.zySelect=nil
end
if self.lgSelect then
local item=self.lgScrollView:getChildScrollViewItemWidget(self.lgSelect)
item:SetChildActive(2,false)
self.lgSelect=nil
end
end


function UIRecruitJZAPWin:__delete()
self:unbindComponents()

_this=nil
end




function UIRecruitJZAPWin:onShow(argtable,afterOnloaded)
self.pos=argtable

self.back:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,nil)
self:refresh()
end

function UIRecruitJZAPWin:refresh()
self:refreshJZList()
self.on_jz_item_click(0,0)
self:refreshLGList()
end


function UIRecruitJZAPWin:onHide()

end

function UIRecruitJZAPWin:getJZDatas()
local datas=worldXiuZhenJiaZuModel:getAllSelfFamilyData()
local list={}
for i,v in ipairs(datas)do
list[v.familyId]={sdata=v,familyId=v.familyId}
end
local fdatas=UIRecruitModel:getAllFamilyData()
for k,v in pairs(fdatas)do
if v.state==0 then
local sd=list[tonumber(k)]
if sd then
sd.fdata=v
end
end
end
local rlist={}
for k,v in pairs(list)do
local sdata=v.sdata
if sdata then
local index=worldXiuZhenJiaZuModel:getFamilyScaleData(sdata.guid)
v.index=-index
else
v.index=0
end
table.insert(rlist,v)
end
rlist=self:getSortList(rlist)

return rlist
end

function UIRecruitJZAPWin:getSortList(list)
local stime=gameUtilityModel.getServerShortTime()
for i,v in ipairs(list)do
local sdata=v.sdata
local fdata=v.fdata
if fdata then
local dt=fdata.endtime-stime
if dt>0 then
v.sortFlag=sdata.familyId
else
v.sortFlag=sdata.familyId-1000000
end
else
v.sortFlag=sdata.familyId-100000000
end
end
table.sort(list,function(a,b)return a.sortFlag<b.sortFlag end)
return list
end

function UIRecruitJZAPWin:refreshJZList()
self.datas=self:getJZDatas()
local stime=gameUtilityModel.getServerShortTime()
self.jzScrollview:setChildScrollViewCreateGrids(#self.datas,0)
local grids=self.jzScrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local data=self.datas[i+1]
local sdata=data.sdata
local fdata=data.fdata
item:SetChildActive(0,i==self.selectIndex)
item:SetChildText(1,self:getFamilyName(data))
item:SetChildActive(4,fdata~=nil)
item:SetChildActive(5,fdata==nil)
local index,sd=worldXiuZhenJiaZuModel:getFamilyScaleData(sdata.guid)
item:SetChildText(2,sd[4])
if fdata then
local dt=fdata.endtime-stime
if dt>0 then
self:startTimer(data.familyId,item,dt)
end
item:SetChildActive(3,dt>0)
item:SetChildActive(6,dt<=0)
else
local tId=sdata.tedianId
local cfg=cfgHelper.get1(cfg_xiuzhenfamilycharacteristicconfig_get,tId)
local tdStr=tId>0 and FMT.fmt('《{0}》',cfg.name)or'无特点'
item:SetChildText(5,tdStr)
item:SetChildActive(5,tId>0)
end
end
end

function UIRecruitJZAPWin:getFamilyName(data)
local sdata=data.sdata
local index,sd
if sdata then
index,sd=worldXiuZhenJiaZuModel:getFamilyScaleData(sdata.guid)
else
local cfg=cfg_xiuzhenfamilybasicconfig_get(worldModel.world)
index=1
sd=cfg.family_pre_names[1]
end
local elderCfg=worldXiuZhenJiaZuModel:getElderConfig(data.familyId)
local name=FMT.fmt('{0}·{1}',sd[3],elderCfg.elder_lastname)
return name
end

function UIRecruitJZAPWin:startTimer(id,item,tcount)
self:clearTimer(id)

local endtime=tcount+os.time()
item:SetChildText(3,timeHelper.format_time_stamp3(tcount))
self.zmtimers[id]=self:setTimer(1,tcount+3,function()
local dt=endtime-os.time()
if dt<0 then
self:clearTimer(id)
self:refresh()
return
end
item:SetChildText(3,timeHelper.format_time_stamp3(dt))
end)
end

function UIRecruitJZAPWin:clearTimer(id)
if self.zmtimers[id]then
self:stopTimerByID(self.zmtimers[id])
self.zmtimers[id]=nil
end
end

function UIRecruitJZAPWin:startPageTimer(tcount)
self:clearPageTimer()

local endtime=tcount+os.time()
self.countdown2:setText(timeHelper.format_time_stamp3(tcount))
self.pageTimer=self:setTimer(1,tcount+3,function()
local dt=endtime-os.time()
if dt<0 then
self:clearPageTimer()
self:refresh()
return
end
self.countdown2:setText(timeHelper.format_time_stamp3(dt))
end)
end

function UIRecruitJZAPWin:clearPageTimer()
if self.pageTimer then
self:stopTimerByID(self.pageTimer)
self.pageTimer=nil
end
end

function UIRecruitJZAPWin:getZYDatas(zylist)
local level=zongmenModel:getLevel()
local list={}
for i,v in ipairs(zylist)do
local jycfg=cfgHelper.get1(cfg_disciplevocationconfig_get,v)
local isUnlock=false
local lockTips=''
if level>=jycfg.level then

if jycfg.system then
local systemId=jycfg.system
isUnlock=systemModel.isOpen(systemId)
if not isUnlock then
lockTips=systemModel.getOpenTips(systemId,nil,'解锁')
end
else

isUnlock=true
end
else

lockTips=FMT.fmt('宗门达到{0}级解锁',jycfg.level)
end

table.insert(list,{cfg=jycfg,isUnlock=isUnlock,lockTips=lockTips})
end
return list
end

function UIRecruitJZAPWin:refreshZYList(zylist)
local zjdata=self.datas[self.selectIndex+1]
local voc=zjdata.fdata and zjdata.fdata.voc or-1
self.jydatas=self:getZYDatas(zylist)
self.zyScrollView:setChildScrollViewCreateGrids(#self.jydatas,0)
local grids=self.zyScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local data=self.jydatas[i+1]


item:SetChildText(1,data.cfg.name)
item:SetChildActive(2,voc==data.cfg.id)

local diziIconAbName='ui/windows/recruit/sharedtextures/jiazuzhaomudizizuhe.ab'
item:SetChildCSImageSprite(4,diziIconAbName,data.cfg.icon3)

item:SetChildActive(3,not data.isUnlock)

item:SetChildImageExGray(0,not data.isUnlock)

item:SetChildImageExGray(4,not data.isUnlock)
end

local jiazuzhaomuSetting=userActorSetting.get("jiazuzhaomuSetting",{})
local jzSetting=jiazuzhaomuSetting[tostring(zjdata.sdata.guid)]or{}
self.zySelect=jzSetting[1]
if self.zySelect then
local item=self.zyScrollView:getChildScrollViewItemWidget(self.zySelect)
item:SetChildActive(2,true)
end
end

function UIRecruitJZAPWin:refreshLGList()
local zjdata=self.datas[self.selectIndex+1]
local sp=zjdata.fdata and zjdata.fdata.spiritrootid or-1
self.lgdatas=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eSpiritRoot)
self.lgScrollView:setChildScrollViewCreateGrids(#self.lgdatas,0)
local grids=self.lgScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local cfg=self.lgdatas[i+1]
item:SetChildCSImageSprite(0,self.abName,FMT.fmt('image_jzaplgdise_{0}',cfg.id))
item:SetChildText(1,FMT.fmt("<color={0}>{1}</color>",self.lgColors[cfg.id],cfg.name))
item:SetChildActive(2,sp==cfg.id)
end

local jiazuzhaomuSetting=userActorSetting.get("jiazuzhaomuSetting",{})
local jzSetting=jiazuzhaomuSetting[tostring(zjdata.sdata.guid)]or{}
self.lgSelect=jzSetting[2]
if self.lgSelect then
local item=self.lgScrollView:getChildScrollViewItemWidget(self.lgSelect)
item:SetChildActive(2,true)
end
end

function UIRecruitJZAPWin:refreshCost(sdata)
local index
if sdata then
index=worldXiuZhenJiaZuModel:getFamilyScaleData(sdata.guid)
else
index=1
end

local cfg=cfgHelper.get1(cfg_yinxiantaijzscaleconfig_get,index)
self:setCost(self.cost1,cfg.consume[1])
self:setCost(self.cost2,cfg.consume[2])

local recruitTime=cfg.duration
if sdata.specialityId then

local specialityCfg=cfgHelper.get1(cfg_xiuzhenfamilyspecialityconfig_get,sdata.specialityId)
if specialityCfg.effects and specialityCfg.effects[1]==3 then
local reduceRate=specialityCfg.effects[2][index]
recruitTime=recruitTime*(1-reduceRate/100)
end
end
self.countdown:setText(timeHelper.format_time_stamp11(recruitTime,true))
self.tips:setText(cfg.tips)
end

function UIRecruitJZAPWin:setCost(item,mdata)
if mdata then
item:setActive(true)
local widget=item:getChildWidgetBase()
widget:SetChildIcon(0,iconHelper.getIconName(mdata[1]),false)
local have=moneyModel.getMoney(mdata[1])
if have<mdata[2]then
widget:SetChildText(1,FMT.fmt('<color=red>{0}</color>',mdata[2]))
else
widget:SetChildText(1,mdata[2])
end
else
item:setActive(false)
end
end

function UIRecruitJZAPWin:checkCost(sdata)
local index
if sdata then
index=worldXiuZhenJiaZuModel:getFamilyScaleData(sdata.guid)
else
index=1
end
local cfg=cfgHelper.get1(cfg_yinxiantaijzscaleconfig_get,index)
for i,v in ipairs(cfg.consume)do
local have=moneyModel.getMoney(v[1])
if have<v[2]then
local name=moneyModel.getMoneyName(v[1])
UIManager.error(FMT.fmt('{0}不足',name))
gainControl:showGainWin(v[1])
return false
end
end
return true
end




function UIRecruitJZAPWin:isRecruiting(fdata)
local stime=gameUtilityModel.getServerShortTime()
local dt=fdata.endtime-stime
return dt>0
end

function UIRecruitJZAPWin:onPeiyang()
local data=self.datas[self.selectIndex+1]
if data.fdata then
if self:isRecruiting(data.fdata)then
UIManager.error('该家族正在招募中')
else
UIManager.error('该家族尚有弟子未处理')
end
elseif not self.zySelect or not self.lgSelect then
UIManager.error('安排职业和灵根后方能培养')
return
elseif self:checkCost(data.sdata)then
local zy=self.jydatas[self.zySelect+1].cfg.id
local lg=self.lgdatas[self.lgSelect+1].id
local jiazuzhaomuSetting=userActorSetting.get("jiazuzhaomuSetting",{})
jiazuzhaomuSetting[tostring(data.sdata.guid)]={self.zySelect,self.lgSelect}
userActorSetting.set("jiazuzhaomuSetting",jiazuzhaomuSetting)
userActorSetting.flush()
UIRecruitControl:reqRecruitJZ(self.pos,data.sdata.world,data.sdata.guid,zy,lg)
self:onClickClose()
end
end

function UIRecruitJZAPWin:onTedian()
UIManager:showWindow('UIFeatureWin',self.tdId)
end

function UIRecruitJZAPWin:onGotoBtn()
self:onClickClose()
end

function UIRecruitJZAPWin:onClickClose()
self:closeSelf()
end