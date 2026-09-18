







def_class("UIXianjieXuanShangWin",UIWindowBase)









function UIXianjieXuanShangWin:bindComponents()

self.ruleBtn=UIButton.get(self,0)
self.cloud=UIButton.get(self,1)
self.taskitem=UIObject.get(self,2)
self.taskitem2=UIObject.get(self,3)
self.taskitem3=UIObject.get(self,4)
self.pqBtn=UIButton.get(self,5)
self.synum=UIText.get(self,6)
self.xslnum=UIText.get(self,7)
self.xsicon=UIImage.get(self,8)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.cloud:setButtonClick(function()self:onCloud()end)

self.pqBtn:setButtonClick(function()self:onPqBtn()end)


self.sprite_image_dygou=0
self.sprite_image_dycha=1

end


function UIXianjieXuanShangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.taskitem);self.taskitem=nil;
_UIObject_release(self.taskitem2);self.taskitem2=nil;
_UIObject_release(self.taskitem3);self.taskitem3=nil;
_UIObject_release(self.pqBtn);self.pqBtn=nil;
_UIObject_release(self.synum);self.synum=nil;
_UIObject_release(self.xslnum);self.xslnum=nil;
_UIObject_release(self.xsicon);self.xsicon=nil;
end
















local _this
local taskIndex=
{
selfitem=0,
bg=1,
rootpanel=2,
noinfo=3,
info=4,
addbtn=5,
zmicon=6,
zmname=7,
tz=8,
delbtn=9,
tiptxt=10,
tasktxt=11,
cdpanel=12,
rewardpanel=13,
cddprogress=14,
cdtime=15,
finishbtn=16,
rescrollview=17,
getbtn=18,
finishimg=19,

rwScrollView2=20,
rwItemlist={21,22,23},
}



function UIXianjieXuanShangWin:onLoaded(...)
self:bindComponents()
_this=self
self.taskItems={self.taskitem,self.taskitem2,self.taskitem3}
end


function UIXianjieXuanShangWin:__delete()




for index=1,3 do
self:clearTimer(index)
end
self:unbindComponents()
_this=nil
end




function UIXianjieXuanShangWin:onShow(argtable,afterOnloaded)
self.bdData=argtable.data
self.sfId=zongmenModel:getMountainId()
local cfg=cfg_zongmenxuanshangtaskbaseconfig_get(1)
self.xjxstFreeNum=cfg.xjxstFreeNum
self.xjxstFeeNum=cfg.xjxstFeeNum
self.xjxstTaskItem=cfg.xjxstTaskItem

self.defaultVersionId=pfwindowslController:getGameVersion()
self.pfid=loginModel:getPfid()

self:initinfo()
self:freshSYnum()
end


function UIXianjieXuanShangWin:onHide()

end

function UIXianjieXuanShangWin:onCloud()
end

function UIXianjieXuanShangWin:onRuleBtn()
local d={}
d.title='规则'
d.mode=3
d.name='ui_Xianjiexuanshang_rule_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIXianjieXuanShangWin:oncloseClick()
UIXuanShangControl:closeUI()
end
function UIXianjieXuanShangWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eCenter})
end
function UIXianjieXuanShangWin:showDialog(content,onChoose,onOK)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
choosetext='本次登录不再提示',
choosecallback=onChoose,
okcallback=onOK,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function UIXianjieXuanShangWin:onAddbtnBtn(index)
local nowfree=XianjieXuanShangModel:getfreeNumUse()
if nowfree<self.xjxstFreeNum then
UIManager:showWindow('UIXianjieXSselectWin',{parentWin=self,taskIndex=index})
else
local nowUse=XianjieXuanShangModel:getfeeNumUse()
if nowUse<self.xjxstFeeNum then
UIManager:showWindow('UIXianjieXSselectWin',{parentWin=self,taskIndex=index})
else
UIManager.info("每日接取任务次数已达上限")
end
end
end

function UIXianjieXuanShangWin:onGetBtn(index,taskid)
XianjieXuanShangController:send_7_58()
end

function UIXianjieXuanShangWin:onDelbtnBtn(index,taskid)
local content="放弃任务后将无法领取奖励，是否放弃此任务"
local flag=XianjieXuanShangModel:checkPassStart(taskid)
if not flag then
content="放弃任务后将无法领取奖励，且返还次数或悬赏令，是否放弃此任务"
end
self:showDialog(content,nil,function()
XianjieXuanShangController:send_7_60(taskid)
end)
end

function UIXianjieXuanShangWin:onQuickBtn(index,taskid)
local param=cfgHelper.get2(cfg_zongmenxuanshangtaskbaseconfig_get,1,'gsParam2')
local cddata=XianjieXuanShangModel:getCDData(taskid)
local cd=cddata.cd
local use=math.ceil(cd/(param[1]*60))
local costnum=use*param[3]
local costid=param[2]

local content=FMT.fmt('是否消耗<color=#549327>{0}*{1}</color>立即完成？',itemsConfig.getItemName(costid),costnum)
self:showDialog(content,nil,function()
local isEnough=moneyModel.checkEnoughMoney(costid,costnum)
if not isEnough and costid==eMoneyType.mtLingYu then
local hasLingYuCount=moneyModel.getMoney(costid)
local needXianYuCount=costnum-hasLingYuCount
isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
end
if not isEnough then
local MoneyName=moneyModel.getMoneyName(costid)
UIManager.error(FMT.fmt("{0}不足",MoneyName))
gainControl:showGainWin(costid)
else
local func=function()
XianjieXuanShangController:send_7_57(taskid)
end
moneySystem:useMoney(costid,costnum,func,WARNING_TYPE.eWarning)
end
end)
end

function UIXianjieXuanShangWin:onClickTeDianItem(item,tzcfg,isgray,idx,bigidx)



local args={}
args.posWidget=item
local name=tzcfg.name
local framecolor=tzcfg.framecolor
local desc={tzcfg.desc}
args.title=name
args.framecolor=framecolor
args.desclist=desc

if bigidx==1 or bigidx==2 then
args.pivot=Vector2(0,0)
else
args.pivot=Vector2(1,0)
end
UIManager:showWindow('UIDescribeTips2',args)
end

function UIXianjieXuanShangWin:onPqBtn()
local tasklists=XianjieXuanShangModel:getTaskAllData()
local taskidlist={}
for i=1,3 do
local taskdata=tasklists[i]
if taskdata then
local nowstamp=timeHelper.getServerShortTime()
if nowstamp>=taskdata.endTime and taskdata.rwFlag==1 then
taskidlist[#taskidlist+1]=taskdata.taskId
end
end
end

if#taskidlist>0 then
for k,v in ipairs(taskidlist)do
if XianjieXuanShangModel:checkDoneToday(v)then
UIManager.info("今日无法再次派遣相同任务")
return
end
end
end
if#taskidlist>0 then

local new_taskidlist={}
local need_exNum=0

local allnum=#taskidlist
local nowfree=XianjieXuanShangModel:getfreeNumUse()
local maxfree=self.xjxstFreeNum
local cannum=maxfree-nowfree

local nowUse=XianjieXuanShangModel:getfeeNumUse()
local maxUse=self.xjxstFeeNum
local cannum_ex=maxUse-nowUse

if allnum<=cannum then

for k,v in ipairs(taskidlist)do
new_taskidlist[#new_taskidlist+1]=v
end
else
local len=0
for k=1,cannum do
new_taskidlist[#new_taskidlist+1]=taskidlist[k]
len=len+1
end
local exneed=allnum-cannum
if exneed<=cannum_ex then
for k=1,exneed do
local oldindex=k+len
new_taskidlist[#new_taskidlist+1]=taskidlist[oldindex]
end
need_exNum=exneed
else
UIManager.info("一键派遣所需次数不足")
end
end


if need_exNum==0 and#new_taskidlist>0 then
XianjieXuanShangController:send_7_59(#new_taskidlist,new_taskidlist)
end

if need_exNum>0 and#new_taskidlist>0 then
local costItemId=self.xjxstTaskItem[1][1]
local costItemNum=self.xjxstTaskItem[1][2]*need_exNum
local bagcount=itemsModel.getCount(costItemId)
local content="是否确认消耗{0}x<color=#7d3b17>{1}</color>执行<color=#7d3b17>{2}</color>次额外任务？\n\n共执行任务次数：<color=#7d3b17>{3}</color>"
local itemIconName=iconHelper.getIconName(costItemId)
local iconStr=chatEmotHelper.getIconEmotMesg(itemIconName,36)
content=FMT.fmt(content,iconStr,costItemNum,need_exNum,#new_taskidlist)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function(...)

if bagcount<costItemNum then
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(costItemId)))
gainControl:showGainWin(costItemId)
else
XianjieXuanShangController:send_7_59(#new_taskidlist,new_taskidlist)
end
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
else
UIManager.info("无可自动派遣的任务")
end
end


function UIXianjieXuanShangWin:switchPanel(widget,isClose)
if isClose then
widget:SetChildActive(taskIndex.noinfo,false)
widget:SetChildActive(taskIndex.info,true)
widget:SetChildCanvasGroupDOFade(taskIndex.info,0,0.2,function()
if _this==nil then return end
widget:SetChildActive(taskIndex.noinfo,true)
widget:SetChildActive(taskIndex.info,false)
widget:SetChildCanvasGroupDOFade(taskIndex.noinfo,1,0.2,nil)
end)
else
widget:SetChildActive(taskIndex.noinfo,true)
widget:SetChildActive(taskIndex.info,false)
widget:SetChildCanvasGroupDOFade(taskIndex.noinfo,0,0.2,function()
if _this==nil then return end
widget:SetChildActive(taskIndex.noinfo,false)
widget:SetChildActive(taskIndex.info,true)
widget:SetChildCanvasGroupDOFade(taskIndex.info,1,0.2,nil)
end)
end
end

function UIXianjieXuanShangWin:switchNoPanel(widget,isinfo)
if isinfo then
widget:SetChildActive(taskIndex.noinfo,false)
widget:SetChildCanvasGroupAlpha(taskIndex.noinfo,0)
widget:SetChildActive(taskIndex.info,true)
widget:SetChildCanvasGroupAlpha(taskIndex.info,1)
else
widget:SetChildActive(taskIndex.noinfo,true)
widget:SetChildCanvasGroupAlpha(taskIndex.noinfo,1)
widget:SetChildActive(taskIndex.info,false)
widget:SetChildCanvasGroupAlpha(taskIndex.info,0)
end
end


function UIXianjieXuanShangWin:freshSYnum()
local nowfree=XianjieXuanShangModel:getfreeNumUse()
if _this.xjxstFreeNum-nowfree>0 then
_this.xslnum:setActive(false)
_this.synum:setText(FMT.fmt("今日免费任务次数：{0}",_this.xjxstFreeNum-nowfree))
else
local nowUse=XianjieXuanShangModel:getfeeNumUse()
_this.synum:setText(FMT.fmt("今日额外任务次数：{0}",_this.xjxstFeeNum-nowUse))
_this.xslnum:setActive(true)
local itemid=_this.xjxstTaskItem[1][1]
if itemid then
_this.xsicon:setChildIcon(iconHelper.getIconName(itemid),false)
local count=itemsModel.getCount(itemid)
_this.xslnum:setText(count)
end
end
end


function UIXianjieXuanShangWin:initinfo()
local tasklists=XianjieXuanShangModel:getTaskAllData()
for idx,v in ipairs(self.taskItems)do
local widget=v:getWidgetBase()
local Tdata=tasklists[idx]
self:clearTimer(idx)
if Tdata then
local rwFlag=Tdata.rwFlag
if rwFlag==1 then
self:switchNoPanel(widget,false)
widget:SetChildButtonClick(taskIndex.addbtn,function()
if _this==nil then return end
self:onAddbtnBtn(idx)
end)
else
self:switchNoPanel(widget,true)
local taskId=Tdata.taskId
local serial=Tdata.zmGuid
local littlelvl=LittleWorldModel:getLittleWorldLevel()
local infoData=systemZongMenModel:getInfoData(serial)
local name=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
local icon=systemZongMenModel:getIconName(infoData.id,infoData.level)
widget:SetChildText(taskIndex.zmname,name)
widget:SetChildCSImageIcon(taskIndex.zmicon,icon,false)
widget:SetChildActive(taskIndex.delbtn,false)
widget:SetChildActive(taskIndex.rescrollview,false)
widget:SetChildActive(taskIndex.rwScrollView2,false)


local ishavetz=false
local istzvalue
local tzeffrct={}
local xtzmtzItem=XianjieXuanShangModel:getZMtezhiDatabyGuid(infoData.id)

if xtzmtzItem then
local tzList=xtzmtzItem
if tzList then
widget:SetChildScrollViewCreateGrids(taskIndex.tz,#tzList,#tzList)
local grids=widget:GetChildScrollViewItemWidgets(taskIndex.tz)
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local tzid=tzList[i]
local tzcfg=cfg_syssecttzconfig_get(tzid)
local xstTaskIdlist=tzcfg.xstTaskId
local isgray=false
if not xstTaskIdlist[taskId]then
isgray=true
end
if xstTaskIdlist[taskId]==1 then
ishavetz=true
istzvalue=tzcfg.tezhijc
local effectcfg=tzcfg.effect[1][2]
for _,n in ipairs(effectcfg)do
tzeffrct[n[1]]=n[2]
end
end
local framecolor=tzcfg.framecolor
local _name=tzcfg.name
_name=UIDiscipleModel.getSpecialityNameStr(_name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(framecolor)
item:SetChildCSImageSprite(0,abName,frameIcon)
item:SetChildGray(0,isgray)
item:SetChildText(1,_name)
item:SetChildButtonClick(0,function()
if _this==nil then return end
self:onClickTeDianItem(item,tzcfg,isgray,i,idx)
end)
end
end
end


local endTime=Tdata.endTime
local taskcfg=cfg_xianjiexuanshangtaskconfig_get(taskId)
local nowstamp=timeHelper.getServerShortTime()
widget:SetChildText(taskIndex.tasktxt,taskcfg.name)


if nowstamp>=endTime then

widget:SetChildActive(taskIndex.cdpanel,false)
widget:SetChildActive(taskIndex.rewardpanel,true)
widget:SetChildText(taskIndex.tiptxt,"<color=#549327>任务执行完成</color>")

local lvlcfg=cfg_syssectxslvconfig_get(infoData.xs_level)
local xstTaskAdd=lvlcfg.xstTaskAdd
local value=xstTaskAdd[taskId]or 0
local _rewardList=XianjieXuanShangController:checkOrderPT(taskcfg.rewardList,self.defaultVersionId,self.pfid)
local rewardList=_rewardList[littlelvl][1][2]
local len=#rewardList
widget:SetChildActive(taskIndex.rescrollview,false)
widget:SetChildActive(taskIndex.rwScrollView2,false)
if len>3 then
widget:SetChildActive(taskIndex.rescrollview,true)
widget:SetChildScrollViewCreateGrids(taskIndex.rescrollview,len,len)
local grids=widget:GetChildScrollViewItemWidgets(taskIndex.rescrollview)
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewardList[i]
local itemId=data[1]
local itemCount=data[2]
local value2=0
if istzvalue and tzeffrct and tzeffrct[itemId]then
value2=value+tzeffrct[itemId]
end
if value2 and value2>0 then
itemCount=math.floor(itemCount+itemCount*value2)
end
local showEffFlag=data[3]==1
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
self:onClickItem(...)
end)
end
else
widget:SetChildActive(taskIndex.rwScrollView2,true)
for i=1,3 do
local item=widget:GetChildWidgetBase(taskIndex.rwItemlist[i])
local data=rewardList[i]
if data then
item:SetChildActive(0,true)
local itemId=data[1]
local itemCount=data[2]
local value2=0
if istzvalue and tzeffrct and tzeffrct[itemId]then
value2=value+tzeffrct[itemId]
end
if value2 and value2>0 then
itemCount=math.floor(itemCount+itemCount*value2)
end
local showEffFlag=data[3]==1
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(1,prop)
item:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
self:onClickItem(...)
end)
else
item:SetChildActive(0,false)
end
end
end
widget:SetChildButtonClick(taskIndex.getbtn,function()
if _this==nil then return end
self:onGetBtn(idx,taskId)
end)
else

local cddata=XianjieXuanShangModel:getCDData(taskId)
if cddata then
if not cddata.complete then
self:startTimer(widget,taskId,idx)
widget:SetChildActive(taskIndex.delbtn,true)
end
end
widget:SetChildButtonClick(taskIndex.finishbtn,function()
if _this==nil then return end
self:onQuickBtn(idx,taskId)
end)

widget:SetChildButtonClick(taskIndex.delbtn,function()
if _this==nil then return end
self:onDelbtnBtn(idx,taskId)
end)
end
end
else
self:switchNoPanel(widget,false)
widget:SetChildButtonClick(taskIndex.addbtn,function()
if _this==nil then return end
self:onAddbtnBtn(idx)
end)
end
end
end

function UIXianjieXuanShangWin:clearTimer(index)
if not self.timer then
self.timer={}
end
if self.timer[index]then
self:stopTimerByID(self.timer[index])
self.timer[index]=nil
end
end
function UIXianjieXuanShangWin:startTimer(widget,taskId,index)
local firstTick=true
local tick=function()

local data=XianjieXuanShangModel:getCDData(taskId)
local dtime=data.dtime
local ntime=data.ntime
if firstTick then
widget:SetChildUIProgressbar(taskIndex.cddprogress,dtime,ntime,false)
else
widget:SetChildUIProgressbar(taskIndex.cddprogress,dtime+1,ntime,true)
end
widget:SetChildText(taskIndex.cdtime,timeHelper.format_time_stamp11(data.cd))
if data.cd<=0 then
self:clearTimer(index)
end
end
tick()
firstTick=false
local data=XianjieXuanShangModel:getCDData(taskId)
if not self.timer then
self.timer={}
end
self.timer[index]=self:setTimer(1,data.ntime+5,tick)
end


function UIXianjieXuanShangWin:refreshinfo(indexlist)
for k,idx in ipairs(indexlist)do
local widget=_this.taskItems[idx]:getWidgetBase()
local tasklists=XianjieXuanShangModel:getTaskAllData()
local Tdata=tasklists[idx]

_this:clearTimer(idx)
if Tdata then
local rwFlag=Tdata.rwFlag
if rwFlag==1 then
_this:switchNoPanel(widget,false)
widget:SetChildButtonClick(taskIndex.addbtn,function()
if _this==nil then return end
_this:onAddbtnBtn(idx)
end)
else

widget:SetChildText(taskIndex.tiptxt,"<color=#CA631D>正在执行任务</color>")
widget:SetChildActive(taskIndex.cdpanel,true)
widget:SetChildActive(taskIndex.rewardpanel,false)
_this:switchNoPanel(widget,true)
local taskId=Tdata.taskId
local serial=Tdata.zmGuid
local littlelvl=LittleWorldModel:getLittleWorldLevel()
local infoData=systemZongMenModel:getInfoData(serial)
local name=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
local icon=systemZongMenModel:getIconName(infoData.id,infoData.level)
widget:SetChildText(taskIndex.zmname,name)
widget:SetChildCSImageIcon(taskIndex.zmicon,icon,false)
widget:SetChildActive(taskIndex.delbtn,false)


local ishavetz=false
local istzvalue
local tzeffrct={}
local xtzmtzItem=XianjieXuanShangModel:getZMtezhiDatabyGuid(infoData.id)

if xtzmtzItem then
local tzList=xtzmtzItem
if tzList then
widget:SetChildScrollViewCreateGrids(taskIndex.tz,#tzList,#tzList)
local grids=widget:GetChildScrollViewItemWidgets(taskIndex.tz)
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local tzid=tzList[i]
local tzcfg=cfg_syssecttzconfig_get(tzid)
local xstTaskIdlist=tzcfg.xstTaskId
local isgray=false
if not xstTaskIdlist[taskId]then
isgray=true
end
if not xstTaskIdlist[taskId]then
isgray=true
end
if xstTaskIdlist[taskId]==1 then
ishavetz=true
istzvalue=tzcfg.tezhijc
local effectcfg=tzcfg.effect[1][2]
for _,n in ipairs(effectcfg)do
tzeffrct[n[1]]=n[2]
end
end
local framecolor=tzcfg.framecolor
local _name=tzcfg.name
_name=UIDiscipleModel.getSpecialityNameStr(_name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(framecolor)
item:SetChildCSImageSprite(0,abName,frameIcon)
item:SetChildGray(0,isgray)
item:SetChildText(1,_name)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onClickTeDianItem(item,tzcfg,isgray,i)
end)
end
end
end


local endTime=Tdata.endTime
local taskcfg=cfg_xianjiexuanshangtaskconfig_get(taskId)
local nowstamp=timeHelper.getServerShortTime()
widget:SetChildText(taskIndex.tasktxt,taskcfg.name)

if nowstamp>=endTime then

widget:SetChildActive(taskIndex.cdpanel,false)
widget:SetChildActive(taskIndex.rewardpanel,true)
widget:SetChildText(taskIndex.tiptxt,"<color=#549327>任务执行完成</color>")

local lvlcfg=cfg_syssectxslvconfig_get(infoData.xs_level)
local xstTaskAdd=lvlcfg.xstTaskAdd
local value=xstTaskAdd[taskId]or 0

local _rewardList=XianjieXuanShangController:checkOrderPT(taskcfg.rewardList,self.defaultVersionId,self.pfid)
local rewardList=_rewardList[littlelvl][1][2]
local len=#rewardList
widget:SetChildActive(taskIndex.rescrollview,false)
widget:SetChildActive(taskIndex.rwScrollView2,false)
if len>3 then
widget:SetChildActive(taskIndex.rescrollview,true)
widget:SetChildScrollViewCreateGrids(taskIndex.rescrollview,len,len)
local grids=widget:GetChildScrollViewItemWidgets(taskIndex.rescrollview)
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=rewardList[i]
local itemId=data[1]
local itemCount=data[2]
local value2=0
if istzvalue and tzeffrct and tzeffrct[itemId]then
value2=value+tzeffrct[itemId]
end
if value2 and value2>0 then
itemCount=math.floor(itemCount+itemCount*value2)
end
local showEffFlag=data[3]==1
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
else
widget:SetChildActive(taskIndex.rwScrollView2,true)
for i=1,3 do
local item=widget:GetChildWidgetBase(taskIndex.rwItemlist[i])
local data=rewardList[i]
if data then
item:SetChildActive(0,true)
local itemId=data[1]
local itemCount=data[2]
local value2=0
if istzvalue and tzeffrct and tzeffrct[itemId]then
value2=value+tzeffrct[itemId]
end
if value2 and value2>0 then
itemCount=math.floor(itemCount+itemCount*value2)
end
local showEffFlag=data[3]==1
local countStr=itemCount>1 and mathHelper.formatNumber2(itemCount)or''
local showCountBG=itemCount>1
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=showEffFlag}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(1,prop)
item:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
self:onClickItem(...)
end)
else
item:SetChildActive(0,false)
end
end
end
widget:SetChildButtonClick(taskIndex.getbtn,function()
if _this==nil then return end
_this:onGetBtn(idx,taskId)
end)
else

local cddata=XianjieXuanShangModel:getCDData(taskId)
if cddata then
if not cddata.complete then
_this:startTimer(widget,taskId,idx)
widget:SetChildActive(taskIndex.delbtn,true)
end
end
widget:SetChildButtonClick(taskIndex.finishbtn,function()
if _this==nil then return end
_this:onQuickBtn(idx,taskId)
end)

widget:SetChildButtonClick(taskIndex.delbtn,function()
if _this==nil then return end
_this:onDelbtnBtn(idx,taskId)
end)
end
end
else
_this:switchNoPanel(widget,false)
widget:SetChildButtonClick(taskIndex.addbtn,function()
if _this==nil then return end
_this:onAddbtnBtn(idx)
end)
end
end
end
