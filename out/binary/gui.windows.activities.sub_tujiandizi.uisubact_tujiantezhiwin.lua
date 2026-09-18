







def_class("UISubAct_tujianTeZhiWin",UIWindowBase)









function UISubAct_tujianTeZhiWin:bindComponents()

self.bgModel=UIObject.get(self,0)
self.actytime=UIText.get(self,1)
self.centerPanel=UIObject.get(self,2)
self.roleScrollerView=UIObject.get(self,3)
self.rolescrollerview2=UIObject.get(self,4)
self.desc=UIText.get(self,5)
self.gobtn=UIButton.get(self,6)
self.rulebtn=UIButton.get(self,7)
self.ywcimg=UIObject.get(self,8)
self.tezhipanel=UIObject.get(self,9)
self.titleTxt1=UIText.get(self,10)
self.titleTxt2=UIText.get(self,11)
self.titleimg=UIImage.get(self,12)

self.gobtn:setButtonClick(function()self:onGobtn()end)

self.rulebtn:setButtonClick(function()self:onRulebtn()end)



end


function UISubAct_tujianTeZhiWin:unbindComponents()
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
_UIObject_release(self.tezhipanel);self.tezhipanel=nil;
_UIObject_release(self.titleTxt1);self.titleTxt1=nil;
_UIObject_release(self.titleTxt2);self.titleTxt2=nil;
_UIObject_release(self.titleimg);self.titleimg=nil;
end
















local _this
local roleidx=
{
roleitem=0,
root=1,
tzimg=2,
tzname=3,
namebg=4,
bg=5,
desc1=6,
received=7,
btn=8,
choosebtn=9,
selectimg=10,
quxiaobtn=11,
desc2=12,
descimg=13,
desc_zsname=14,
desc3=15,
descbg2=16,
descbg3=17,
sv=18,
}
local tzidx=
{
tzitem=0,
bg=1,
blackimg=2,
gou=3,
name=4,
btn=5
}
local bgbigimgs=
{
[2]={'image_tujianhuodong_08','image_tujianhuodong_21','image_tujianhuodong_22'},
[3]={'image_tujianhuodong_09','image_tujianhuodong_23','image_tujianhuodong_24'},
[4]={'image_tujianhuodong_07','image_tujianhuodong_19','image_tujianhuodong_20'},
}
local bgsmallimgs=
{
[2]='image_tujianhuodong_11',
[3]='image_tujianhuodong_12',
[4]='image_tujianhuodong_13',
}
local typeimgs=
{
[2]='image_tujianhuodong_16',
[3]='image_tujianhuodong_17',
[4]='image_tujianhuodong_15',
}
local abName='ui/windows/activities/sub_tujiandizi/tujiandizi_atlas_pak.ab'



function UISubAct_tujianTeZhiWin:onLoaded(...)
self:bindComponents()
self:clearTimer()
_this=self
self.selecttezhi={}
self.tzsxbtn={}
self.tzsxselect={}
end


function UISubAct_tujianTeZhiWin:__delete()
self:unbindComponents()
_this=nil
end

function UISubAct_tujianTeZhiWin:onRulebtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='UISubAct_tujianTeZhiWin_%d'
d.showBlack=true
self:showWindow('UIRuleWin',d)
end


function UISubAct_tujianTeZhiWin:onGobtn()

if not self.selecttezhi or not next(self.selecttezhi)then
UIManager.info('请先选择特质')
return
end
local temp={}
for k,v in pairs(self.selecttezhi)do
table.insert(temp,k)
end
local actID=self.actID
local subType=self.subType
local subid=self.subid
local _fun=function()
local json_str=jsonHelper.encode({1,temp})
activitiesController:sendProtocol(actSendType.eComonReqHandle,actID,subType,subid,json_str)
end
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt("是否领取选择的弟子特质?"),
oktext='确认',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
}
local comfirmDialog3=UIDialogManager.newDialog(showdata)
comfirmDialog3:show()
end


function UISubAct_tujianTeZhiWin:onClickTZBtn(i)
local bigwidget=self.tezhipanel:getChildWidgetBase()
local widget=bigwidget:GetChildWidgetBase(i)
local specialityType=self.tzsxbtn[i+1]

if self.tzsxselect[specialityType]then
widget:SetChildActive(tzidx.gou,false)
widget:SetChildActive(tzidx.blackimg,true)
self.tzsxselect[specialityType]=nil
else
widget:SetChildActive(tzidx.gou,true)
widget:SetChildActive(tzidx.blackimg,false)
self.tzsxselect[specialityType]=true
end

self.selecttezhi={}
self:setdesc()
self:freshdata()
end




function UISubAct_tujianTeZhiWin:onShow(argtable,afterOnloaded)
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
self.selecttezhi={}

self.bgModel:setChildUIModelShowTarget(6123,1,nil,eAnimationID.stand)
self.winlua:SetChildCSImageSprite(self.titleimg:getID(),abName,self.sub_actcfg.titleimg)
self.titleTxt1:setText(self.sub_actcfg.descs[1])
self.titleTxt2:setText(self.sub_actcfg.descs[2])


self.tzsxbtn=self.sub_actcfg.tzsxlist
self:showTzSetPanel()

self:refreshActivityTime()
self:setdesc()
self:freshdata()
end

function UISubAct_tujianTeZhiWin:refreshActivityTime()
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

function UISubAct_tujianTeZhiWin:clearTimer()
if self.timer then
self:stopTimerByID(self.timer)
self.timer=nil
end
end

function UISubAct_tujianTeZhiWin:onHide()

end


function UISubAct_tujianTeZhiWin:showTzSetPanel()
if self.tzsxbtn and next(self.tzsxbtn)then
for k,v in ipairs(self.tzsxbtn)do
self.tzsxselect[v]=true
end
self.tezhipanel:setActive(true)
local bigwidget=self.tezhipanel:getChildWidgetBase()
for i=0,4 do
if self.tzsxbtn[i+1]then
bigwidget:SetChildActive(i,true)
local widget=bigwidget:GetChildWidgetBase(i)
widget:SetChildActive(tzidx.gou,true)
widget:SetChildActive(tzidx.blackimg,false)
local specialityType=self.tzsxbtn[i+1]
local TypeName=UIDiscipleModel:getSpecialityTypeName(specialityType)
widget:SetChildText(tzidx.name,TypeName)
widget:SetChildCSImageSprite(tzidx.bg,abName,bgsmallimgs[specialityType])

widget:SetChildButtonClick(tzidx.btn,function()
self:onClickTZBtn(i)
end)
else
bigwidget:SetChildActive(i,false)
end
end
else
self.tezhipanel:setActive(false)
end
end


function UISubAct_tujianTeZhiWin:severfresh()
_this.selecttezhi={}
_this:setdesc()
_this:freshdata()
end


function UISubAct_tujianTeZhiWin:setdesc()
local myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
local select_max=sub_actcfg.select_num
local selectSpeciality=myData.selectSpeciality
local num=0
for k,v in pairs(selectSpeciality)do
num=num+1
end
for k,v in pairs(self.selecttezhi)do
num=num+1
end
local str=''
if num>=select_max then
str=string.format("请选择上方任意（<color=#c82c2c>%d/%d</color>）个特质领取",num,select_max)
else
str=string.format("请选择上方任意（<color=#549327>%d/%d</color>）个特质领取",num,select_max)
end
self.desc:setText(str)
end


function UISubAct_tujianTeZhiWin:sortlist(selectSpeciality,sub_actcfg)
local list={}
local speciality=sub_actcfg.speciality or{}

for k,v in ipairs(speciality)do
local tztype=v[2]
local _sort=k+(tztype*1000)
if selectSpeciality[k]then
_sort=_sort-100000
end
if next(self.tzsxselect)==nil then
table.insert(list,{cfgdata=v,cfgindex=k,sort=_sort})
else
if self.tzsxselect[tztype]then
table.insert(list,{cfgdata=v,cfgindex=k,sort=_sort})
end
end
end
if#list>0 then
table.sort(list,function(a,b)
return a.sort<b.sort
end)
end
return list
end

function UISubAct_tujianTeZhiWin:freshdata()
local myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
local select_max=sub_actcfg.select_num
local selectSpeciality=myData.selectSpeciality
local num=0
for k,v in pairs(selectSpeciality)do
num=num+1
end
if num>=select_max then
self.gobtn:setActive(false)
self.ywcimg:setActive(true)
else
self.gobtn:setActive(true)
self.ywcimg:setActive(false)
end

local speciality=self:sortlist(selectSpeciality,sub_actcfg)
local len=#speciality
if len>0 then
self.roleScrollerView:setActive(true)
self.roleScrollerView:setChildScrollViewCreateGrids(len,len)
local grids=self.roleScrollerView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local data=speciality[i]
self:setRoleData(i,widget,data,selectSpeciality)
end
end
end

function UISubAct_tujianTeZhiWin:setRoleData(index,widget,data,selectSpeciality)
local cfgdata=data.cfgdata
local cfgindex=data.cfgindex
local specialityType=cfgdata[2]
local sID=cfgdata[3]
local cfg=UIDiscipleModel:getSpecialityConfig(specialityType,sID)
if cfg then


widget:SetChildCSImageSprite(roleidx.namebg,abName,typeimgs[specialityType])
widget:SetChildCSImageSprite(roleidx.bg,abName,bgbigimgs[specialityType][1])

local _abName,_frameIcon=UIDiscipleModel.getSpecialityColorFrame(cfg.framecolor)
widget:SetChildCSImageSprite(roleidx.tzimg,_abName,_frameIcon)
widget:SetChildButtonClick(roleidx.tzimg,function(...)
if _this==nil then return end
self:onDescSlotClick(widget,cfg)
end)
local tzname=UIDiscipleModel.getSpecialityNameStr(cfg.name)
widget:SetChildText(roleidx.tzname,tzname)

local effects_adddesc=cfg.effects_adddesc or{}
local descstr1=self:checklengthover(effects_adddesc[1],55)
widget:SetChildText(roleidx.desc1,descstr1)
local isable=self:checklengthovernum(effects_adddesc[1],54)
widget:SetChildScrollRectEnable(roleidx.sv,isable)

local tjtzactdesc=cfg.tjtzactdesc
if tjtzactdesc then
widget:SetChildActive(roleidx.descimg,true)
widget:SetChildActive(roleidx.descbg2,false)
widget:SetChildCSImageSprite(roleidx.descbg3,abName,bgbigimgs[specialityType][3])
widget:SetChildText(roleidx.desc_zsname,tjtzactdesc[1]or'祖师名字')
local descstr3=self:checklengthover(tjtzactdesc[2],6)
widget:SetChildText(roleidx.desc3,descstr3)
else
widget:SetChildActive(roleidx.descimg,false)
widget:SetChildActive(roleidx.descbg2,true)
widget:SetChildCSImageSprite(roleidx.descbg2,abName,bgbigimgs[specialityType][2])
local effects_desc=cfg.effects_desc or''
local descstr2=self:checklengthover(effects_desc,32)
widget:SetChildText(roleidx.desc2,descstr2)
end

local check=selectSpeciality[cfgindex]==true
widget:SetChildActive(roleidx.received,check)


local select=false
if self.selecttezhi[cfgindex]then
select=true
end

local selected=false
if selectSpeciality[cfgindex]then
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
widget:SetChildAnimationStringID(roleidx.selectimg,'tjhdtz_choose',true)


widget:SetChildButtonClick(roleidx.choosebtn,function(...)
if _this==nil then return end
self:onChooseClickItem(index,data)
end)

widget:SetChildButtonClick(roleidx.quxiaobtn,function(...)
if _this==nil then return end
self:onQuXiaoClickItem(index,data)
end)
end
end

function UISubAct_tujianTeZhiWin:onDescSlotClick(widget,cfg)
UIManager:showWindow('UISpecialityWin',{item=widget,node='top',config=cfg,pivot=Vector2(0.5,1.5)})
end

function UISubAct_tujianTeZhiWin:onJobClickItem(widget,dzData)
local dzID=dzData.id
local imageInfo=dzData.imageInfo
local jobid=imageInfo.job
local args={}
args.posWidget=widget
args.pos=Vector2.New(0,-20)
commonTipsHelper.showDiscipleJpbTips(dzID,jobid,args)
end

function UISubAct_tujianTeZhiWin:onXQClickItem(itemID)
UIRecruitControl:showItemDiscipleInfoByItemId2(itemID)
end

function UISubAct_tujianTeZhiWin:onChooseClickItem(index,data)
local cfgindex=data.cfgindex
if self.selecttezhi[cfgindex]then
UIManager.info('已招入该名弟子，请选择其他弟子招入')
return
end


local select_max=self.sub_actcfg.select_num
local selectSpeciality=self.myData.selectSpeciality
local num=0
for k,v in pairs(selectSpeciality)do
num=num+1
end
for k,v in pairs(self.selecttezhi)do
num=num+1
end
if num>=select_max then
UIManager.info('选择弟子特质数量已达活动上限')
return
end

local grids=self.roleScrollerView:getChildScrollViewItemWidgets()
local widget=grids[index-1]

self.selecttezhi[cfgindex]=true
widget:SetChildActive(roleidx.selectimg,true)
widget:SetChildActive(roleidx.quxiaobtn,true)
widget:SetChildActive(roleidx.choosebtn,false)
self:setdesc()
end

function UISubAct_tujianTeZhiWin:onQuXiaoClickItem(index,data)
local cfgindex=data.cfgindex

self.selecttezhi[cfgindex]=nil
local grids=self.roleScrollerView:getChildScrollViewItemWidgets()
local widget=grids[index-1]
widget:SetChildActive(roleidx.selectimg,false)
widget:SetChildActive(roleidx.quxiaobtn,false)
widget:SetChildActive(roleidx.choosebtn,true)
self:setdesc()
end


function UISubAct_tujianTeZhiWin:checklengthover(str,limitnum)
if not str then return''end
if limitnum==100 then
local c=string.toTable(str)
local newstr=''
if c and#c>=limitnum then
newstr=string.format("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s...",c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12],c[13],c[14],c[15],c[16],c[17],c[18],c[19],c[20],c[21],c[22],c[23],c[24],c[25],c[26],c[27],c[28],c[29],c[30],c[31],c[32],c[33],c[34],c[35],c[36],c[37],c[38],c[39],c[40],c[41],c[42],c[43],c[44],c[45],c[46],c[47],c[48],c[49],c[50],c[51],c[52],c[53],c[54],c[55])
return newstr or str
else
return str
end
elseif limitnum==32 then
local c=string.toTable(str)
local newstr=''
if c and#c>=limitnum then
newstr=string.format("%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s...",c[1],c[2],c[3],c[4],c[5],c[6],c[7],c[8],c[9],c[10],c[11],c[12],c[13],c[14],c[15],c[16],c[17],c[18],c[19],c[20],c[21],c[22],c[23],c[24],c[25],c[26],c[27],c[28],c[29],c[30],c[31],c[32])
return newstr or str
else
return str
end
end
return str
end


function UISubAct_tujianTeZhiWin:checklengthovernum(str,limitnum)
if not str then return false end
local c=string.toTable(str)
if c and#c>=limitnum then
return true
else
return false
end
end