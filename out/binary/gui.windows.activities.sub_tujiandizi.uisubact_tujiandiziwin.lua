







def_class("UISubAct_tujiandiziWin",UIWindowBase)









function UISubAct_tujiandiziWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.actytime=UIText.get(self,1)
self.centerPanel=UIObject.get(self,2)
self.roleScrollerView=UIObject.get(self,3)
self.rolescrollerview2=UIObject.get(self,4)
self.desc=UIText.get(self,5)
self.gobtn=UIButton.get(self,6)
self.rulebtn=UIButton.get(self,7)
self.ywcimg=UIObject.get(self,8)
self.titleimg=UIImage.get(self,9)

self.gobtn:setButtonClick(function()self:onGobtn()end)

self.rulebtn:setButtonClick(function()self:onRulebtn()end)



end


function UISubAct_tujiandiziWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.actytime);self.actytime=nil;
_UIObject_release(self.centerPanel);self.centerPanel=nil;
_UIObject_release(self.roleScrollerView);self.roleScrollerView=nil;
_UIObject_release(self.rolescrollerview2);self.rolescrollerview2=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.gobtn);self.gobtn=nil;
_UIObject_release(self.rulebtn);self.rulebtn=nil;
_UIObject_release(self.ywcimg);self.ywcimg=nil;
_UIObject_release(self.titleimg);self.titleimg=nil;
end
















local _this
local roleidx=
{
roleitem=0,
root=1,
lihui=2,
dissolve=3,
jobbtn=4,
jobiocn=5,
orientation=6,
received=7,
timg=8,
btn=9,
xqbtn=10,
choosebtn=11,
selectimg=12,
quxiaobtn=13,
lihui2=14,
name=15,
}
local abName='ui/windows/recruit/sharedtextures/yinxiantai_new.ab'
local abname='ui/windows/activities/sub_tujiandizi/tujiandizi_atlas_pak.ab'



function UISubAct_tujiandiziWin:onLoaded(...)
_this=self
self:bindComponents()
self:addNotify(notifyConfig.onShowPrize,self.onShowPrize)

self:clearTimer()
self.selectdizi={}
end


function UISubAct_tujiandiziWin:__delete()
self:unbindComponents()

_this=nil
end

function UISubAct_tujiandiziWin:onRulebtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='UISubAct_tujiandiziWin_%d'
d.showBlack=true
self:showWindow('UIRuleWin',d)
end


function UISubAct_tujiandiziWin:onGobtn()

if not self.selectdizi or not next(self.selectdizi)then
UIManager.info('请先选择弟子')
return
end
local temp={}
for k,v in pairs(self.selectdizi)do
table.insert(temp,k)
end

local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt("是否招募选择的弟子"),
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=function()
local json_str=jsonHelper.encode({1,temp})
activitiesController:sendProtocol(actSendType.eComonReqHandle,_this.actID,_this.subType,_this.subid,json_str)
end,
showclosebtn=true,
}
local comfirmDialog4=UIDialogManager.newDialog(showdata)
comfirmDialog4:show()
end





function UISubAct_tujiandiziWin:onShow(argtable,afterOnloaded)
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
self.sub_actInfo=activitiesModel:getSubActInfo(self.actID,self.subType,self.subid)
if not self.sub_actInfo then
logErr(FMT.fmt("没有获取到活动id: {0}, 活动类型: {1}, 子活动id: {2}的活动数据",self.activityId,self.subType,self.subId))
return
end
self.startday=self.sub_actInfo.start_day_idx
self.start_time=self.sub_actInfo.start_time
self.end_time=self.sub_actInfo.end_time
self.selectdizi={}

self.bgModel:setChildUIModelShowTarget(6119,1,nil,eAnimationID.stand)
self.winlua:SetChildCSImageSprite(self.titleimg:getID(),abName,self.sub_actcfg.titleimg)

self:refreshActivityTime()
self:setdesc()
self:freshdata()
end

function UISubAct_tujiandiziWin:refreshActivityTime()
self:clearTimer()
local func
func=function()
local nowTime=gameUtilityModel.getServerShortTime()
local lerp=self.end_time and self.end_time-nowTime or 0
if lerp>0 then
self.actytime:setText(FMT.fmt("剩余时间：<color=#fd8950>{0}</color>",timeHelper.format_time_stamp3(lerp,true)))
else
self.actytime:setText("活动已结束")
UIManager.error("活动已结束")
self.isOver=true
self:clearTimer()
end
end
self.timer=self:setTimer(1,0,func)
func()
end

function UISubAct_tujiandiziWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_tujiandiziWin:onHide()

end


function UISubAct_tujiandiziWin:severfresh()
_this.selectdizi={}
_this:setdesc()
_this:freshdata()
end


function UISubAct_tujiandiziWin:setdesc()
local myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
local select_max=sub_actcfg.select_num
local selectDisciple=myData.selectDisciple
local num=0
for k,v in pairs(selectDisciple)do
num=num+1
end
for k,v in pairs(self.selectdizi)do
num=num+1
end
local str=''
if num>=select_max then
str=string.format("选择上方任意（<color=#f36666>%d/%d</color>）名弟子招入宗门",num,select_max)
else
str=string.format("选择上方任意（<color=#aae252>%d/%d</color>）名弟子招入宗门",num,select_max)
end
self.desc:setText(str)
end


function UISubAct_tujiandiziWin:sortlist(selectDisciple,sub_actcfg)

local list={}
local disciple=sub_actcfg.disciple or{}
for k,v in ipairs(disciple)do
local _sort=k
if selectDisciple[k]then
_sort=k-10000
end
table.insert(list,{itemID=v,cfgindex=k,sort=_sort})
end
if#list>0 then
table.sort(list,function(a,b)
return a.sort<b.sort
end)
end
return list
end

function UISubAct_tujiandiziWin:freshdata()
local myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
local select_max=sub_actcfg.select_num
local selectDisciple=myData.selectDisciple
local num=0
for k,v in pairs(selectDisciple)do
num=num+1
end
if num>=select_max then
self.gobtn:setActive(false)
self.ywcimg:setActive(true)
else
self.gobtn:setActive(true)
self.ywcimg:setActive(false)
end

local disciple=self:sortlist(selectDisciple,sub_actcfg)
local len=#disciple
if len>0 then
self.roleScrollerView:setActive(true)
self.roleScrollerView:setChildScrollViewCreateGrids(len,len)
local grids=self.roleScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local data=disciple[i]
self:setRoleData(i,widget,data,selectDisciple)
end
end
end

function UISubAct_tujiandiziWin:setRoleData(index,widget,data,selectDisciple)
local itemID=data.itemID
local cfgindex=data.cfgindex
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemID)
local info=dzData.imageInfo

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData_lihui(info,{isNotBg=true})


local modelSet=self.sub_actcfg.modelSet or{}
local modelSetdata=modelSet[itemID]or{}
local scale=modelSetdata.scale or 0.3
local offset=modelSetdata.offset or{0,0,0}
widget:SetChildUIModelShowTarget(roleidx.lihui2,modelParams.body,scale,modelParams.componets,eAnimationID.stand,true,false,0)
widget:SetChildUIModelShowTargetOffset(roleidx.lihui2,offset[1],offset[2])

local check=selectDisciple[cfgindex]==true
widget:SetChildActive(roleidx.received,check)
widget:SetChildCSImageSprite(roleidx.timg,abName,FMT.fmt('frame_yxtjuanzhou_{0}',info.color))
widget:SetChildCSImageSprite(roleidx.jobiocn,globalABLookup.global,UIDiscipleModel:getJobIconName(info.job))
local orientation=UIDiscipleModel:getJobOrientationName(info.job)or''
widget:SetChildText(roleidx.orientation,orientation)
widget:SetChildText(roleidx.name,dzData.disciplename)


local select=false
if self.selectdizi[cfgindex]then
select=true
end

local selected=false
if selectDisciple[cfgindex]then
selected=true
end
if selected then
widget:SetChildActive(roleidx.selectimg,false)
widget:SetChildActive(roleidx.quxiaobtn,false)
widget:SetChildActive(roleidx.choosebtn,false)
else
widget:SetChildActive(roleidx.selectimg,select)
widget:SetChildActive(roleidx.quxiaobtn,select)
widget:SetChildActive(roleidx.choosebtn,not select)
end
widget:SetChildAnimationStringID(roleidx.selectimg,'tjhd_choose',true)


widget:SetChildButtonClick(roleidx.jobbtn,function(...)
if _this==nil then return end
self:onJobClickItem(widget,dzData)
end)

widget:SetChildButtonClick(roleidx.xqbtn,function(...)
if _this==nil then return end
self:onXQClickItem(itemID)
end)

widget:SetChildButtonClick(roleidx.choosebtn,function(...)
if _this==nil then return end
self:onChooseClickItem(index,data)
end)

widget:SetChildButtonClick(roleidx.quxiaobtn,function(...)
if _this==nil then return end
self:onQuXiaoClickItem(index,data)
end)
end


function UISubAct_tujiandiziWin:onJobClickItem(widget,dzData)
local dzID=dzData.id
local imageInfo=dzData.imageInfo
local jobid=imageInfo.job
local args={}
args.posWidget=widget
args.pos=Vector2.New(0,-20)
commonTipsHelper.showDiscipleJpbTips(dzID,jobid,args)
end

function UISubAct_tujiandiziWin:onXQClickItem(itemID)
UIRecruitControl:showItemDiscipleInfoByItemId2(itemID)
end

function UISubAct_tujiandiziWin:onChooseClickItem(index,data)
local cfgindex=data.cfgindex
if self.selectdizi[cfgindex]then
UIManager.info('已招入该名弟子，请选择其他弟子招入')
return
end


local select_max=self.sub_actcfg.select_num
local selectDisciple=self.myData.selectDisciple
local num=0
for k,v in pairs(selectDisciple)do
num=num+1
end
for k,v in pairs(self.selectdizi)do
num=num+1
end
if num>=select_max then
UIManager.info('已达到活动最大招入弟子数量')
return
end

local grids=self.roleScrollerView:getChildScrollViewItemWidgets()
local widget=grids[index-1]
local _fun=function()

_this.selectdizi[cfgindex]=true
widget:SetChildActive(roleidx.selectimg,true)
widget:SetChildActive(roleidx.quxiaobtn,true)
widget:SetChildActive(roleidx.choosebtn,false)
_this:setdesc()
end


local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(data.itemID)
local finds=UIDiscipleModel:findDisciplesByID(dzData.id)
local name=dzData.disciplename
local owned=#finds>0
if owned then
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt("宗门已招入该弟子\n再次招入将获得<color={0}>【{1}魂魄】</color>*50\n是否继续选择?",FONT_COLOR_VAL[5],name),
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
}
local comfirmDialog3=UIDialogManager.newDialog(showdata)
comfirmDialog3:show()
else
_fun()
end
end

function UISubAct_tujiandiziWin:onQuXiaoClickItem(index,data)
local cfgindex=data.cfgindex

self.selectdizi[cfgindex]=nil
local grids=self.roleScrollerView:getChildScrollViewItemWidgets()
local widget=grids[index-1]
widget:SetChildActive(roleidx.selectimg,false)
widget:SetChildActive(roleidx.quxiaobtn,false)
widget:SetChildActive(roleidx.choosebtn,true)
self:setdesc()
end


function UISubAct_tujiandiziWin:testtttt()
local temp={
[1]={
['sortWeight']=15000,
['itemid']=19002,
['num']=1,
['itemguid']=2774660473725911198,
}
,
}
local prizeType=94
UISubAct_tujiandiziWin.onShowPrize(prizeType,temp,nil)
end


function UISubAct_tujiandiziWin.onShowPrize(prizeType,temp,effectData)
if prizeType==ePrizeType.eActivityTuJianDizi then
if _this==nil then return end
_this.rewardlist=table.deepCopy(temp)

local newdiiz={}
local olddiiz={}
for k,v in ipairs(_this.rewardlist)do
local itemcfg=itemsConfig.getConfig(v.itemid)
local funcparam=itemcfg.funcparam
local netData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(funcparam.discipleid)
if netData then
table.insert(olddiiz,v)
else
table.insert(newdiiz,v)
end
end

if#olddiiz>0 then
for k,v in ipairs(olddiiz)do
bagProtocolControl.req_use_item(v.itemid,v.num)
end
end

if#newdiiz>0 then
for k,v in ipairs(newdiiz)do
bagProtocolControl.req_use_item(v.itemid,v.num)
end
end














local lists={}
for k,v in ipairs(olddiiz)do
local itemnum=v.num
local dzid
local itemcfg=itemsConfig.getConfig(v.itemid)
local funcparam=itemcfg.funcparam
if funcparam then
local ftype=funcparam.type
if ftype==item_funtion_type.disciple and funcparam.isSpecial==true then
dzid=funcparam.discipleid
end
end
if dzid then
local yuanpo=cfgHelper.get2(cfg_discipleconfig_get,dzid,'yuanpo')
local itemid__=yuanpo[1]
local itemnum__=yuanpo[2]*itemnum
table.insert(lists,{itemid=itemid__,num=itemnum__})
end
end
if#lists>0 then
showPrizeControl.showWindow(lists,nil)
end
end
end


function UISubAct_tujiandiziWin:checkItem(reward)
local itemid=reward.itemid
local itemnum=reward.num
local itemcfg=itemsConfig.getConfig(itemid)
local checkuse=false
local funcparam=itemcfg.funcparam
if funcparam then
local ftype=funcparam.type
if ftype==item_funtion_type.disciple and funcparam.isSpecial==true then

local itemCount=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if itemCount>=itemnum then
checkuse=true
end
end
end
return checkuse
end
function UISubAct_tujiandiziWin.onItemUse(itemid,num)

if _this==nil then return end
local itemcfg=itemsConfig.getConfig(itemid)
local funcparam=itemcfg.funcparam
if funcparam then
local ftype=funcparam.type
if ftype==item_funtion_type.disciple and funcparam.isSpecial==true then
local dzid=funcparam.discipleid


end
end
end
function UISubAct_tujiandiziWin:replay(itemid_,num,dzid)
local yuanpo=cfgHelper.get2(cfg_discipleconfig_get,dzid,'yuanpo')
local itemid__=yuanpo[1]
local itemnum__=yuanpo[2]*num
local _num=itemsLookup:checkAutoExchange(itemid__,itemnum__)

if _num~=nil then
bagProtocolControl.req_use_item(itemid__,itemnum__)
end
end
