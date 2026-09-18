







def_class("UIQieShiShenShouWin",UIWindowBase)









function UIQieShiShenShouWin:bindComponents()

self.model=UIObject.get(self,0)
self.dzScrollView=UIObject.get(self,1)
self.rwScrollView=UIObject.get(self,2)
self.fightBtn=UIButton.get(self,3)
self.rwIcon=UIObject.get(self,4)
self.gongfa_2=UIButton.get(self,5)
self.gongfa_1=UIButton.get(self,6)
self.name=UIImage.get(self,7)
self.zhiye=UIImage.get(self,8)
self.daobingInfo=UIObject.get(self,9)
self.gongfaInfo=UIObject.get(self,10)
self.tianming_1=UIBaseItem.get(self,11)
self.tianming_2=UIBaseItem.get(self,12)
self.actTime=UIText.get(self,13)
self.dingwei_1=UIObject.get(self,14)
self.dingwei_2=UIObject.get(self,15)
self.daobing=UIObject.get(self,16)

self.fightBtn:setButtonClick(function()self:onFightBtn()end)

self.gongfa_2:setButtonClick(function()self:onGongfa_2()end)

self.gongfa_1:setButtonClick(function()self:onGongfa_1()end)
self.gongfa={
self.gongfa_1,
self.gongfa_2,
}
self.tianming={
self.tianming_1,
self.tianming_2,
}
self.dingwei={
self.dingwei_1,
self.dingwei_2,
}



end


function UIQieShiShenShouWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.dzScrollView);self.dzScrollView=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.fightBtn);self.fightBtn=nil;
_UIObject_release(self.rwIcon);self.rwIcon=nil;
_UIObject_release(self.gongfa_2);self.gongfa_2=nil;
_UIObject_release(self.gongfa_1);self.gongfa_1=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.zhiye);self.zhiye=nil;
_UIObject_release(self.daobingInfo);self.daobingInfo=nil;
_UIObject_release(self.gongfaInfo);self.gongfaInfo=nil;
_UIObject_release(self.tianming_1);self.tianming_1=nil;
_UIObject_release(self.tianming_2);self.tianming_2=nil;
_UIObject_release(self.actTime);self.actTime=nil;
_UIObject_release(self.dingwei_1);self.dingwei_1=nil;
_UIObject_release(self.dingwei_2);self.dingwei_2=nil;
_UIObject_release(self.daobing);self.daobing=nil;
self.gongfa=nil;
self.tianming=nil;
self.dingwei=nil;
end



















function UIQieShiShenShouWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/qieshishenshou/qieshishenshou_atlas_pak.ab'

self.modelBasePos=self.model:getChildAnchoredPosition3D()

self.dzScrollView:setChildScrollViewInit(0.5,true,function(...)self:onDZSelect(...)end,nil)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end

function UIQieShiShenShouWin:onDZSelect(cnum,index)
if self.currSelect==index then
return
end

if self.currSelect then
local widget=self.dzScrollView:getChildScrollViewItemWidget(self.currSelect)
widget:SetChildActive(1,true)
end

self.currSelect=index

local widget=self.dzScrollView:getChildScrollViewItemWidget(self.currSelect)
widget:SetChildActive(1,false)

local data=self.datas[index+1]
local dzId=data.id
local dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzId)
local info=dzData.imageInfo
local args={bgFisrt=true}
local scale=data.scale or 1
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,args)
self.model:setChildUIModelEnableInitUISpinePara(false,true)
self.model:setChildUIModelShowTarget(modelParams.body,scale,modelParams.componets,eAnimationID.stand)

local offset=data.offset
if offset then
local ap=Vector3.New(self.modelBasePos.x,self.modelBasePos.y,0)
ap.x=ap.x+data.offset[1]
ap.y=ap.y+data.offset[2]
self.model:setChildAnchoredPosition3D(ap)
end

self.name:setSprite(self.abName,data.icon[2])
local jobicon=UIDiscipleModel:getJobIconName(info.job)
self.zhiye:setSprite(globalABLookup.global,jobicon)

self:setRewards(data.gift)

for i=1,2 do
local dw=data.dingwei[i]
self:setDingWeiItem(self.dingwei[i],dw)
end

local flag=data.flag
local showGF=flag==1
self.gongfaInfo:setActive(showGF)
self.daobingInfo:setActive(not showGF)
if showGF then
for i=1,2 do
local gfd=data.gongfa[i]
self:setGongFaIcon(self.gongfa[i],gfd)
end
else
self:setDaoBing(data.daobing)
end

for i=1,2 do
local tmd=data.tianming[i]
self:setTianMing(self.tianming[i],tmd,info.job)
end


local _isCanReceive=FreeGiftController.GetFreeGift(data.gift,{self.actId,self.subType,self.subId})
widget:SetChildActive(2,_isCanReceive)
end

function UIQieShiShenShouWin:setDingWeiItem(dwItem,data)
local item=dwItem:getChildWidgetBase()
item:SetChildText(1,data[1])

item:SetChildButtonClick(0,function()
local pos=dwItem:getChildPosition()
local args={
content=data[2],
doScaleType=2,
ptype=3,
worldPos=pos,
pivot=Vector2.New(1,0.5),
offset={-70,0},
width=550,
}
UIManager:showWindow("UICommonHelpTwo",args)
end)
end

function UIQieShiShenShouWin:setGongFaIcon(gfItem,gfData)
local gfID=gfData[1]
local level=gfData[2]
local item=gfItem:getChildWidgetBase()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)

local colorIcon=UIGongFaModel:getGFColorKuangIcon(cfg.color)
item:SetChildCSImageSprite(0,globalABLookup.cangjingge,colorIcon)

item:SetChildIcon(1,iconHelper.getGongFaIcon(cfg.icon),false)

local elements=UIGongFaModel:getGFElements(gfID)
local elementid=elements[1]
local elementIcon=ELEMENT_TYPE.getIcon(elementid)
item:SetChildCSImageSprite(2,globalABLookup.global,elementIcon)

item:SetChildText(3,cfg.name)

item:SetChildButtonClick(0,function()
local check=UIGongFaModel:isGongFaActive(gfID)
UIManager:showWindow('UIGongFaTipsFiveWin',{gfID=gfID,gfLevel=level,showGain=not check})
end)
end

function UIQieShiShenShouWin:setDaoBing(dbData)
local widget=self.daobing:getChildWidgetBase()
local itemId=dbData[1]
local star=dbData[2]
local level=dbData[3]
local levelStr
if level>0 then
levelStr=FMT.fmt('+{0}',level)
else
levelStr=''
end
local clickFunc=function()
local attach={starlv=star,jllv=level}
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight,attach=attach})
end
widgetHelper.setNormalRewardItem(widget,0,{itemId,0,countText=levelStr,clickFunc=clickFunc})

local sw=widget:GetChildWidgetBase(1)
for i=1,5 do
sw:SetChildActive(i-1,i<=star)
end
end

function UIQieShiShenShouWin:setTianMing(tmItem,tmd,jobid)
local tmId=tmd[1]
local tmLevel=tmd[2]
local item=tmItem:getChildWidgetBase()
local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmId)
local skillIconId=UIDiscipleModel.getTianMingSkillIconId(tmCfg,jobid)
local skillIconName=iconHelper.getSkillIcon(skillIconId)
item:SetChildIcon(0,skillIconName,true)
local name=FMT.fmt('【{0}】',tmCfg.name)
if pfwindowslController:checkIsGameVersion_yuenan()then
if string.len(name)>25 then
name=string.sub(name,1,18)..'...'
end
elseif pfwindowslController:checkIsGameVersion_oumei()then
if string.lenEx(name)>20 then
name=string.sub(name,1,18)..'...'
end
else
if string.len(name)>20 then
name=string.sub(name,1,15)..'...'
end
end
item:SetChildText(1,name)

local floor=UIDiscipleModel.getTianMingLevelFloor(tmLevel)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
item:SetChildCSImageSprite(2,abName,iconName)

item:SetChildButtonClick(-1,function()
local args={
tmId=tmId,
tmLv=0,
needFloor=0,
tmState=true,
jobId=jobid,
skillIconId=skillIconId,
}
UIManager:showWindow("UIDiscipleTianMingSkillTipsWin",args)
end)
end


function UIQieShiShenShouWin:__delete()
self:unbindComponents()
end




function UIQieShiShenShouWin:onShow(argtable,afterOnloaded)
if argtable then
if argtable.act_id then
self.actId=argtable.act_id
end
if argtable.sub_act_type then
self.subType=argtable.sub_act_type
end
if argtable.sub_act_id then
self.subId=argtable.sub_act_id
end
if argtable.parentWin then
self.parentWin=argtable.parentWin
end
end

self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.datas=self.config.dzlist

local index=self.currSelect or 0

local extraParams=argtable.extraParams
if extraParams and extraParams.index then
index=extraParams.index-1
end

self:setDZList(index+1)
self:onDZSelect(0,index)

if not self.nTimer then
local info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
local etime=info.end_time
local tick=function()
local dt=etime-gameUtilityModel.getServerShortTime()
self.actTime:setText(timeHelper.format_time_stamp11(dt,true))
if dt<=0 then
self.actTime:setText('活动已结束')
self:stopTimerByID(self.nTimer)
self.nTimer=nil
end
end
self.nTimer=self:setTimer(1,0,tick)
tick()
end

self:setDZListReddots()
end


function UIQieShiShenShouWin:onHide()

end

function UIQieShiShenShouWin:setDZList(index)
local len=#self.datas
self.dzScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.dzScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.datas[i]
item:SetChildCSImageSprite(0,self.abName,data.icon[1])
item:SetChildActive(1,i~=index)
item:SetChildActive(2,false)
end
end

function UIQieShiShenShouWin:setRewards(rwId)
local isCanReceive=FreeGiftController.GetFreeGift(rwId,{self.actId,self.subType,self.subId})
self.isCanReceive=isCanReceive
local cfg=cfgHelper.get1(cfg_freegiftconfig_get,rwId)
local rewards=cfg.rewards
local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local rwd=rewards[i]
widgetHelper.setNormalRewardItem(item,0,rwd)
item:SetChildActive(1,not isCanReceive)
end
self.rwIcon:setActive(isCanReceive)
end

function UIQieShiShenShouWin:setDZListReddots()
local grids=self.dzScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.datas[i]
local giftid=data.gift
if giftid then
local isCanReceive=FreeGiftController.GetFreeGift(giftid,{self.actId,self.subType,self.subId})
item:SetChildActive(2,isCanReceive)
end
end
end




function UIQieShiShenShouWin:onFightBtn()
local index=self.currSelect+1
local data=self.datas[index]
local report=fightModel:getServerFightReport(data.frId)
local other={
fighttype=eBattleLaunch.qieshishenshou,
rwId=data.gift,
actId=self.actId,
subType=self.subType,
subId=self.subId,
index=index
}
roleAudioController:setSinglePlayDizi(data.id)
local handle=fightBattleHandle:getHandle(eBattleType.qieshishenshou)
handle.mustLook=self.isCanReceive
fightLaunchController.recv_254_28(1,{{result=1,len=1,list={report}}},other,0)
end

function UIQieShiShenShouWin:onCloseClick()
self:closeSelf()
end