







def_class("UIYFLTTipsWin",UIWindowBase)









function UIYFLTTipsWin:bindComponents()

self.addyear=UIText.get(self,0)
self.bottom=UIObject.get(self,1)
self.buttonroot=UIObject.get(self,2)
self.CancelBtn=UIButton.get(self,3)
self.cancuishuyear=UIText.get(self,4)
self.color=UIText.get(self,5)
self.cuishu1=UIObject.get(self,6)
self.cuishu2=UIObject.get(self,7)
self.cuishuBg=UIObject.get(self,8)
self.CuiShuBtn=UIButton.get(self,9)
self.cuishuEffect=UIObject.get(self,10)
self.cuishuroot=UIObject.get(self,11)
self.fillValue=UIImage.get(self,12)
self.fillvalue2=UIObject.get(self,13)
self.four=UIObject.get(self,14)
self.geziicon=UIImage.get(self,15)
self.Icon=UIImage.get(self,16)
self.iconEffect=UIObject.get(self,17)
self.iconImg=UIImage.get(self,18)
self.intraduction=UIText.get(self,19)
self.introduceroot=UIObject.get(self,20)
self.leftbutton=UIButton.get(self,21)
self.model=UIObject.get(self,22)
self.model2=UIObject.get(self,23)
self.name=UIText.get(self,24)
self.one=UIObject.get(self,25)
self.PlantName=UIText.get(self,26)
self.rightbutton=UIButton.get(self,27)
self.rightroot=UIObject.get(self,28)
self.root=UIObject.get(self,29)
self.shuxing=UIText.get(self,30)
self.skillTree=UIObject.get(self,31)
self.speedrt1=UIBaseItem.get(self,32)
self.speedrt2=UIBaseItem.get(self,33)
self.stage=UIText.get(self,34)
self.three=UIObject.get(self,35)
self.top=UIImage.get(self,36)
self.two=UIObject.get(self,37)
self.type=UIText.get(self,38)
self.yet=UIObject.get(self,39)
self.yetyear=UIText.get(self,40)
self.countPanel=UIObject.get(self,41)
self.countText=UIText.get(self,42)
self.intraductionEx=UIText.get(self,43)

self.CancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.CuiShuBtn:setButtonClick(function()self:onCuiShuBtn()end)

self.leftbutton:setButtonClick(function()self:onLeftbutton()end)

self.rightbutton:setButtonClick(function()self:onRightbutton()end)



end


function UIYFLTTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.addyear);self.addyear=nil;
_UIObject_release(self.bottom);self.bottom=nil;
_UIObject_release(self.buttonroot);self.buttonroot=nil;
_UIObject_release(self.CancelBtn);self.CancelBtn=nil;
_UIObject_release(self.cancuishuyear);self.cancuishuyear=nil;
_UIObject_release(self.color);self.color=nil;
_UIObject_release(self.cuishu1);self.cuishu1=nil;
_UIObject_release(self.cuishu2);self.cuishu2=nil;
_UIObject_release(self.cuishuBg);self.cuishuBg=nil;
_UIObject_release(self.CuiShuBtn);self.CuiShuBtn=nil;
_UIObject_release(self.cuishuEffect);self.cuishuEffect=nil;
_UIObject_release(self.cuishuroot);self.cuishuroot=nil;
_UIObject_release(self.fillValue);self.fillValue=nil;
_UIObject_release(self.fillvalue2);self.fillvalue2=nil;
_UIObject_release(self.four);self.four=nil;
_UIObject_release(self.geziicon);self.geziicon=nil;
_UIObject_release(self.Icon);self.Icon=nil;
_UIObject_release(self.iconEffect);self.iconEffect=nil;
_UIObject_release(self.iconImg);self.iconImg=nil;
_UIObject_release(self.intraduction);self.intraduction=nil;
_UIObject_release(self.introduceroot);self.introduceroot=nil;
_UIObject_release(self.leftbutton);self.leftbutton=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.model2);self.model2=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.one);self.one=nil;
_UIObject_release(self.PlantName);self.PlantName=nil;
_UIObject_release(self.rightbutton);self.rightbutton=nil;
_UIObject_release(self.rightroot);self.rightroot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.shuxing);self.shuxing=nil;
_UIObject_release(self.skillTree);self.skillTree=nil;
_UIObject_release(self.speedrt1);self.speedrt1=nil;
_UIObject_release(self.speedrt2);self.speedrt2=nil;
_UIObject_release(self.stage);self.stage=nil;
_UIObject_release(self.three);self.three=nil;
_UIObject_release(self.top);self.top=nil;
_UIObject_release(self.two);self.two=nil;
_UIObject_release(self.type);self.type=nil;
_UIObject_release(self.yet);self.yet=nil;
_UIObject_release(self.yetyear);self.yetyear=nil;
_UIObject_release(self.countPanel);self.countPanel=nil;
_UIObject_release(self.countText);self.countText=nil;
_UIObject_release(self.intraductionEx);self.intraductionEx=nil;
end


















local this=nil

function UIYFLTTipsWin:onLoaded(...)
self:bindComponents()
this=self
end


function UIYFLTTipsWin:__delete()
self:unbindComponents()
if this.openid then
this:stopTimerByID(this.openid)
this.openid=nil
end
if this.changeid then
this:stopTimerByID(this.changeid)
this.changeid=nil
end

UIManager:invokeUIMethod("UIYFLTGetPlantWin","refreshList")
end
local abname='ui/windows/yifanglingtian/yifanglingtiantips_atlas_pak.ab'



function UIYFLTTipsWin:onShow(argtable,afterOnloaded)
self.model:setChildUIModelShowTarget(5479,1,{},0)
self.model2:setChildUIModelShowTarget(5478,1,{},eAnimationID.enter)
self.itemId=argtable.itemId
self.formType=argtable.formType
if argtable.x and argtable.y then
self.x=argtable.x
self.y=argtable.y
self.data=YiFangLingTianModel:GetSingeGezi(argtable.x,argtable.y)
self.itemId=self.data.item_id

self.idx=YiFangLingTianController:xyToIdx(self.x,self.y)
self.gezistage=YiFangLingTianModel:GetPlantGrowthStage(self.idx)
self.gezidata=YiFangLingTianModel:GetSingleGridData(self.idx)
self.YFLTBagCome=false
self:setCanvasIndex(-1,7)
self.leftbutton:setActive(self:judeCanchange())
self.rightbutton:setActive(self:judeCanchange())
if self:judeCanchange()and not self.showArrowAnim then
self.showArrowAnim=true
local tween1=self.leftbutton:setChildDOLocalMoveX(-585,0.75,nil)
tween1:SetEase(_Ease.InOutSine)
tween1:SetLoops(-1,_LoopType.Yoyo)
local tween2=self.rightbutton:setChildDOLocalMoveX(592,0.75,nil)
tween2:SetEase(_Ease.InOutSine)
tween2:SetLoops(-1,_LoopType.Yoyo)
end
else
local v4=Vector4.New(-0.5,0.02,0.02,1)
self.winlua:SetChildCSImageMatVector(self.fillValue:getID(),"_FlowParam",v4)
self.winlua:SetChildUIProgressbar(self.skillTree:getID(),1,1,false)
self.YFLTBagCome=true
self:setCanvasIndex(-1,9)
self.leftbutton:setActive(false)
self.rightbutton:setActive(false)
end

self:initdata()
self.rightroot:setActive(false)
self.buttonroot:setActive(false)
local func=function()
self.rightroot:setActive(true)
self.openid=nil
self.buttonroot:setActive(not self.elsewinCome)
end
if not self.openid then
self.openid=self:setTimer(0.55,1,func)
end
end


function UIYFLTTipsWin:onHide()

end

function UIYFLTTipsWin:judeCanchange()
local idx_i=self.idx
local num=0
for i=1,36 do
idx_i=idx_i+1
if idx_i>36 then
idx_i=1
end
local gezidata=YiFangLingTianModel:GetSingleGridData(idx_i)
if gezidata and gezidata.item_id and gezidata.item_id~=0 and not gezidata.combinedGridIdx then
num=num+1
end
end
return num>1
end

function UIYFLTTipsWin:changetip(LeftOrRight)
if not self.x or not self.y then
return
end
local idx_i=self.idx

if LeftOrRight==0 then
for i=1,36 do
idx_i=idx_i-1
if idx_i<=0 then
idx_i=36
end
local gezidata=YiFangLingTianModel:GetSingleGridData(idx_i)
if gezidata and gezidata.item_id and gezidata.item_id~=0 and not gezidata.combinedGridIdx then
self.x=gezidata.x
self.y=gezidata.y
self.idx=i
self.data=YiFangLingTianModel:GetSingeGezi(gezidata.x,gezidata.y)
self.itemId=self.data.item_id

self.idx=YiFangLingTianController:xyToIdx(self.x,self.y)
self.gezistage=YiFangLingTianModel:GetPlantGrowthStage(self.idx)
self.gezidata=YiFangLingTianModel:GetSingleGridData(self.idx)
self:initdata()
break
end
end
else
for i=1,36 do
idx_i=idx_i+1
if idx_i>36 then
idx_i=1
end
local gezidata=YiFangLingTianModel:GetSingleGridData(idx_i)
if gezidata and gezidata.item_id and gezidata.item_id~=0 and not gezidata.combinedGridIdx then
self.x=gezidata.x
self.y=gezidata.y
self.idx=i
self.data=YiFangLingTianModel:GetSingeGezi(gezidata.x,gezidata.y)
self.itemId=self.data.item_id

self.idx=YiFangLingTianController:xyToIdx(self.x,self.y)
self.gezistage=YiFangLingTianModel:GetPlantGrowthStage(self.idx)
self.gezidata=YiFangLingTianModel:GetSingleGridData(self.idx)
self:initdata()
break
end
end
end


end

function UIYFLTTipsWin:initdata()
self.flag2=false
self.cuishuFlag=false
self.introduceroot:setActive(true)
self.cuishuroot:setActive(false)
self.CuiShuBtn:setActive(false)
self.CancelBtn:setActive(false)

self:SetleftData()
self:SetRightData()

self:SetButtonData()
self.buttonroot:setActive(not self.elsewinCome)

end

function UIYFLTTipsWin:refresh()
self.data=YiFangLingTianModel:GetSingeGezi(self.x,self.y)

local idx=YiFangLingTianController:xyToIdx(self.x,self.y)
self.gezistage=YiFangLingTianModel:GetPlantGrowthStage(idx)
self:SetleftData()
self:SetRightData()
self:SetCuiShuWin()
self:CuishuCallback()
self:judemax()
end

function UIYFLTTipsWin:judemax()
local conf=cfgHelper.get1(cfg_yifanglintianconfig_get,self.itemId)
local group_conf=conf.group_conf

local maxtime=group_conf[#group_conf][1]
if self.data.total_times<maxtime then
return
end
self.CuiShuBtn:setGray(true)

local callback=function()
YiFangLingTianController:req_3_84(1,{{self.data.x,self.data.y}})
this:closeSelf()
end
local groupstage_itemid=conf.groupstage_itemid[#conf.groupstage_itemid]
local itemConfig=itemsConfig.getConfig(groupstage_itemid)
self:onCancelBtn()

self:showDialog(string.format("<color=%s>%s</color>已完成成熟，是否立即采摘",FONT_COLOR_VAL[itemConfig.color],itemConfig.name),callback,"采摘")
end
local itemcmp=
{
show=0,
icon=1,
name=2,
time=3,
bg=4,
timebg=5,
guozieffect=6,
timeroot=7,
}


function UIYFLTTipsWin:SetleftData()
if not self.itemId then
return
end
local conf=cfgHelper.get1(cfg_yifanglintianconfig_get,self.itemId)
if not conf then
return
end
local confbase=cfgHelper.get1(cfg_yifanglingtianbaseconfig_get,1)
local num=#conf.group_conf
local group_guozi=conf.group_guozi
local cmp=
{
self.one,
self.two,
self.three,
self.four,
}
for k,v in ipairs(cmp)do
v:setActive(false)
end
for k,v in ipairs(group_guozi)do
cmp[v]:setActive(true)
end


self.PlantName:setText(conf.tips_plantname)

local showidlist=conf.showItemid


for i=1,#conf.group_conf do

local trueindex=i
local showid=showidlist[trueindex]
local itemConfig=itemsConfig.getConfig(showid)
local color=itemConfig.color
local iconname=iconHelper.getIconName(showid)
local index=group_guozi[i]
local item=cmp[index]:getWidgetBase()
if self.YFLTBagCome then

self.yet:setActive(false)
item:SetChildActive(itemcmp.show,true)
item:SetChildCSImageIcon(itemcmp.icon,iconname)
item:SetChildText(itemcmp.name,itemConfig.name)
local time=conf.group_conf[trueindex][1]

item:SetChildActive(itemcmp.timeroot,false)

else

self.yet:setActive(true)
local time=conf.group_conf[trueindex][1]
local nowindex=YiFangLingTianModel:GetNextJieDuan(self.itemId,self.data.total_times)

if not nowindex then

return
end
if nowindex+1==i then

local nexttime,needtime=YiFangLingTianModel:GetNextYear(conf.id,self.data.total_times)

local nextyear=gameUtilityModel.calculateGameYearCeil(needtime)
item:SetChildActive(itemcmp.timeroot,true)
item:SetChildText(itemcmp.time,string.format("%d年",nextyear))
local guzieffect=confbase.guzieffect
else
item:SetChildActive(itemcmp.timeroot,false)
end
if nowindex==i then
item:SetChildShowEffect(itemcmp.guozieffect,confbase.guzieffect[nowindex],true)
else
item:SetChildShowEffect(itemcmp.guozieffect,confbase.guzieffect[i],false)
end


local yettime=self.data.total_times

if yettime>=time then
item:SetChildActive(itemcmp.show,true)
item:SetChildImageExGray(itemcmp.icon,false)
else
item:SetChildActive(itemcmp.show,false)
item:SetChildImageExGray(itemcmp.icon,true)
end
item:SetChildCSImageIcon(itemcmp.icon,iconname)

item:SetChildText(itemcmp.name,conf.group_stagetxt[i])


self.stage:setText(conf.tips_stagetxt[self.gezistage])

local growyear=gameUtilityModel.calculateGameYearFloor(self.data.total_times)
local maxyear=YiFangLingTianModel:GetMaxYear(self.itemId)
if growyear>maxyear then
growyear=maxyear
end
if growyear<0 then
growyear=0
end
self.yetyear:setText(growyear..'年')

end
item:SetChildButtonClick(itemcmp.bg,function(...)
tipsManager.showTips({itemid=showid})
end)
end
if not self.YFLTBagCome then
local group_conf=conf.group_conf

local tipsjindu=conf.tipsjindu
local growtime=self.data.total_times
local index=0

local nowindex=YiFangLingTianModel:GetNextJieDuan(self.itemId,self.data.total_times)
if nowindex==#group_conf then

local v4=Vector4.New(-0.5,0.02,0.02,1)
self.winlua:SetChildCSImageMatVector(self.fillValue:getID(),"_FlowParam",v4)
self.winlua:SetChildUIProgressbar(self.skillTree:getID(),1,1,false)
else

index=nowindex+1
local needtipsjindu=0
local beforeStagetime=0

local needtime=group_conf[index][1]
if index==1 then
needtipsjindu=tipsjindu[index]
else
needtipsjindu=tipsjindu[index]-tipsjindu[index-1]
beforeStagetime=group_conf[index-1][1]
needtime=group_conf[index][1]-group_conf[index-1][1]
end


local thistime=growtime-beforeStagetime


local jindu=thistime/needtime*needtipsjindu
if index~=1 then
jindu=jindu+tipsjindu[index-1]
end
local v4=Vector4.New(-0.5,0.02,0.02,jindu)
self.winlua:SetChildCSImageMatVector(self.fillValue:getID(),"_FlowParam",v4)
self.winlua:SetChildUIProgressbar(self.skillTree:getID(),jindu,1,false)
end
end
end



function UIYFLTTipsWin:SetRightData()
if not self.itemId then
return
end
local conf=cfgHelper.get1(cfg_yifanglintianconfig_get,self.itemId)
if not conf then
return
end

local plantid=self.itemId
if self.gezistage then
plantid=conf.groupstage_itemid[self.gezistage]
end
local itemConfig=itemsConfig.getConfig(plantid)
local color=itemConfig.color
local iconname=iconHelper.getIconName(plantid)
self.name:setText(itemConfig.name)
self.type:setText(string.format("类型：<color=#171311>%s</color>",itemConfig.typename))
self.color:setText(string.format("使用等级：<color=#171311>%s级</color>",conf.need_level))

self.shuxing:setText("")
self.Icon:setImageIcon(iconname)

local descInfo=string.split(itemConfig.desc,"\n\n<color=#9999FF>【用途】</color>")
local len=#descInfo
local descStrArr={}
for i=1,len do
local str=descInfo[i]
if str and str~=""then
local index=i<=2 and 1 or 2
if not descStrArr[index]then
descStrArr[index]=str
else
descStrArr[index]=FMT.fmt('{0}\n{1}',descStrArr[index],str)
end
end
end

self.intraduction:setText(descStrArr[1])

local showDescEx=descStrArr[2]~=nil and descStrArr[2]~=""
self.intraductionEx:setActive(showDescEx)
if showDescEx then
self.intraductionEx:setText(descStrArr[2])
end

local showCount=itemConfig.dup and itemConfig.dup>1 and not itemConfig.hideTipsHasNum
self.countPanel:setActive(showCount)
if showCount then
local itemCount=bagModel.getItemCountById(plantid)
self.countText:setText(FMT.fmt('拥有：{0}',itemCount))
end

self.top:setCSImageSprite(abname,"image_yifanglingtianzzbzk_"..color)
if self.YFLTBagCome then

self.geziicon:setSprite(abname,conf.tips_geziicon)
end
self.bottom:setActive(self.YFLTBagCome)
end


local addcmp=
{
rewarditem=0,
slider=1,
count=2,
add=3,
cut=4,
showtext=5,
}


function UIYFLTTipsWin:SetCuiShuWin()
local lyhavenum,itemhavenum,lyreducetime,itemreducetime,itemId=YiFangLingTianModel:Get_HaveItemAndLy()
self.addspeedItemID=itemId
local conf=cfgHelper.get1(cfg_yifanglintianconfig_get,self.itemId)
local group_conf=conf.group_conf

local maxtime=group_conf[#group_conf][1]
local growtime=self.data.total_times





self.needtime=maxtime-growtime
self.itemUseNum=0
self.lyUseNum=lyhavenum>0 and 1 or 0

local havenum=itemsModel.getCount(itemId)
local maxUsenum=math.ceil(self.needtime/itemreducetime)
if maxUsenum>havenum then
maxUsenum=havenum
end

self.cuishu1:setActive(true)
local rewardData={itemId,maxUsenum}
local showCountBG=true
local strnum=string.format("<color=#efeded>%d</color>",havenum)
if havenum==0 then
strnum=string.format("<color=#c82c2c>%d</color>",havenum)
end
local countStr=showCountBG and strnum or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local additem=self:getChildCSGUIBaseItem(self.speedrt1:getID())
additem:SetChildPropData(addcmp.rewarditem,prop)

additem:SetBaseItemClickEvent(addcmp.rewarditem,function(...)
tipsManager.showTips({itemid=itemId})
end)

local itemreduceYear=gameUtilityModel.calculateGameYearFloor(itemreducetime)
local str=string.format("每滴<color=#ca631d>+%s年</color>培育时间",itemreduceYear)
additem:SetChildText(addcmp.showtext,str)

additem:SetChildButtonClick(addcmp.add,function()
local yetreduce=0
if self.lyUseNum>0 then
yetreduce=self.lyUseNum*lyreducetime
end
local cantime=self.needtime-yetreduce
local gameob=additem:GetChildGameObject(1)
local component=gameob:GetComponent("Slider")
local maxnum=math.ceil(cantime/itemreducetime)
local truemaxnum=maxnum
if maxnum>havenum then
maxnum=havenum
end

if component.value>=maxnum then
component.value=maxnum
if maxnum<truemaxnum then
gainControl:showGainWin(itemId)
else
UIManager.info("已可催熟至完全成熟")
end
return
end
component.value=component.value+1
self.itemUseNum=component.value
self.itemUseNum=math.ceil(self.itemUseNum)
additem:SetChildText(addcmp.count,self.itemUseNum)
self:ChangeData(itemreducetime,lyreducetime)
end)
additem:SetChildButtonClick(addcmp.cut,function()
local yetreduce=0
local gameob=additem:GetChildGameObject(1)
local component=gameob:GetComponent("Slider")


if component.value<=0 then
component.value=0
return
end
component.value=component.value-1
self.itemUseNum=component.value
self.itemUseNum=math.ceil(self.itemUseNum)
additem:SetChildText(addcmp.count,self.itemUseNum)
self:SetAddtext(itemreducetime,lyreducetime)
end)

local maxUsenum=math.ceil(self.needtime/itemreducetime)
if maxUsenum>havenum then
maxUsenum=havenum
end
self.itemhavenum=maxUsenum
additem:SetChildSlider(addcmp.slider,0,0,self.itemhavenum,function(val)
if self.flag1 then
self.flag1=false
return
end
local nowtime=timeHelper.getServerShortTime()
local yetreduce=0
if self.lyUseNum>0 then
yetreduce=self.lyUseNum*lyreducetime
end
local cantime=self.needtime-yetreduce
local gameob=additem:GetChildGameObject(1)
local component=gameob:GetComponent("Slider")
local maxnum=math.ceil(cantime/itemreducetime)
local truemaxnum=maxnum
if maxnum>self.itemhavenum then
maxnum=self.itemhavenum
end
if cantime<0 then
self.flag1=true
component.value=0
self.itemUseNum=0
if not self.recordtime or(nowtime-self.recordtime)>2 then
if maxnum>=truemaxnum then
UIManager.info("已可催熟至完全成熟")
end
self.recordtime=nowtime
end
else
if val>maxnum then
val=maxnum
if not self.recordtime or(nowtime-self.recordtime)>2 then
if maxnum>=truemaxnum then
UIManager.info("已可催熟至完全成熟")
end
self.recordtime=nowtime
end
end
self.flag1=true
if val<0 then
val=0
end
component.value=math.abs(math.ceil(val))
self.itemUseNum=val
end
self.itemUseNum=math.ceil(self.itemUseNum)
additem:SetChildText(addcmp.count,self.itemUseNum)
self:ChangeData(itemreducetime,lyreducetime)
end)
local strnum=string.format("<color=#171311>%d</color>",self.itemUseNum)
if havenum==0 then
strnum=string.format("<color=#c82c2c>%d</color>",0)
end
additem:SetChildText(addcmp.count,strnum)





self.cuishu2:setActive(true)
local additem=self:getChildCSGUIBaseItem(self.speedrt2:getID())

local LYreduceYear=gameUtilityModel.calculateGameYearFloor(lyreducetime)
local str=string.format("每滴<color=#ca631d>+%s年</color>培育时间",LYreduceYear)
additem:SetChildText(addcmp.showtext,str)
additem:SetChildButtonClick(addcmp.add,function()
local yetreduce=0
if self.itemUseNum>0 then
yetreduce=self.itemUseNum*itemreducetime
end
local cantime=self.needtime-yetreduce
local gameob=additem:GetChildGameObject(1)
local component=gameob:GetComponent("Slider")
local maxnum=math.ceil(cantime/lyreducetime)
local truemaxnum=maxnum
if maxnum>lyhavenum then
maxnum=lyhavenum
end

if component.value>=maxnum then
component.value=maxnum
if maxnum>=truemaxnum then
UIManager.info("已可催熟至完全成熟")
else
YiFangLingTianModel:openlyGainWin()
end
return
end
component.value=component.value+1
self.lyUseNum=component.value
self.lyUseNum=math.ceil(self.lyUseNum)
additem:SetChildText(addcmp.count,self.lyUseNum)
self:ChangeData(itemreducetime,lyreducetime)
end)
additem:SetChildButtonClick(addcmp.cut,function()
local yetreduce=0
local gameob=additem:GetChildGameObject(1)
local component=gameob:GetComponent("Slider")


if component.value<=0 then
component.value=0
return
end
component.value=component.value-1
self.lyUseNum=component.value
self.lyUseNum=math.ceil(self.lyUseNum)
additem:SetChildText(addcmp.count,self.lyUseNum)
self:ChangeData(itemreducetime,lyreducetime)
end)
local shownum=0
if lyhavenum>0 and growtime<maxtime then
shownum=1
end
local lymaxUsenum=math.ceil(self.needtime/lyreducetime)
if lymaxUsenum>lyhavenum then
lymaxUsenum=lyhavenum
end

self.lyhavenum=lymaxUsenum
additem:SetChildSlider(addcmp.slider,shownum,0,self.lyhavenum,function(val)
if self.flag2 then
self.flag2=false
return
end
local nowtime=timeHelper.getServerShortTime()
local yetreduce=0
if self.itemUseNum>0 then
yetreduce=self.itemUseNum*itemreducetime
end
local cantime=self.needtime-yetreduce
local gameob=additem:GetChildGameObject(1)
local component=gameob:GetComponent("Slider")
local maxnum=math.ceil(cantime/lyreducetime)
local truemaxnum=maxnum
if maxnum>self.lyhavenum then
maxnum=self.lyhavenum
end
if cantime<0 then
self.flag2=true
component.value=0
self.lyUseNum=0
if not self.recordtime or(nowtime-self.recordtime)>2 then
if maxnum>=truemaxnum then
UIManager.info("已可催熟至完全成熟")
end
self.recordtime=nowtime
end
else
if val>maxnum then
val=maxnum
if not self.recordtime or(nowtime-self.recordtime)>2 then
if maxnum>=truemaxnum then
UIManager.info("已可催熟至完全成熟")
end
self.recordtime=nowtime
end
end
self.flag2=true
if val<0 then
val=0
end
component.value=math.abs(math.ceil(val))

self.lyUseNum=val

end
self.lyUseNum=math.ceil(self.lyUseNum)
additem:SetChildText(addcmp.count,self.lyUseNum)
self:ChangeData(itemreducetime,lyreducetime)
end)
local lt_constcfg=cfg_yifanglintianconfig().const_def
local itemid=lt_constcfg.ly_itemid
local showCountBG=true

local lymaxUsenum=math.ceil(self.needtime/lyreducetime)
if lymaxUsenum>lyhavenum then
lymaxUsenum=lyhavenum
end
local strnum=string.format("<color=#efeded>%d</color>",lyhavenum)
if lyhavenum==0 then
strnum=string.format("<color=#c82c2c>%d</color>",lyhavenum)
end

local countStr=showCountBG and strnum or""
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
additem:SetChildPropData(addcmp.rewarditem,prop)
additem:SetBaseItemClickEvent(addcmp.rewarditem,function(...)
tipsManager.showTips({itemid=itemid})
end)
local strnum=string.format("<color=#171311>%d</color>",self.lyUseNum)
if lyhavenum==0 then
strnum=string.format("<color=#c82c2c>%d</color>",0)
end
additem:SetChildText(addcmp.count,strnum)

self:ChangeData(itemreducetime,lyreducetime)


end


function UIYFLTTipsWin:ChangeData(itemreducetime,lyreducetime)
self:SetAddJinDu(itemreducetime,lyreducetime)
self:SetAddtext(itemreducetime,lyreducetime)
end


function UIYFLTTipsWin:SetAddJinDu(itemreducetime,lyreducetime)
local addtime=self.itemUseNum*itemreducetime+self.lyUseNum*lyreducetime
local conf=cfgHelper.get1(cfg_yifanglintianconfig_get,self.itemId)
local group_conf=conf.group_conf

local tipsjindu=conf.tipsjindu
local growtime=self.data.total_times+addtime
local index=0

local nowindex=YiFangLingTianModel:GetNextJieDuan(self.itemId,growtime)


if nowindex>=#group_conf then

self.winlua:SetChildUIProgressbar(self.skillTree:getID(),1,1,false)
return
end

index=nowindex+1
local needtipsjindu=0

local beforeStagetime=0

local needtime=group_conf[index][1]
if index==1 then
needtipsjindu=tipsjindu[index]
else
needtipsjindu=tipsjindu[index]-tipsjindu[index-1]
beforeStagetime=group_conf[index-1][1]
needtime=group_conf[index][1]-group_conf[index-1][1]
end


local thistime=growtime-beforeStagetime


local jindu=thistime/needtime*needtipsjindu
if index~=1 then

jindu=jindu+tipsjindu[index-1]
end
self.winlua:SetChildUIProgressbar(self.skillTree:getID(),jindu,1,false)
end


function UIYFLTTipsWin:SetAddtext(itemreducetime,lyreducetime)
local addtime=self.itemUseNum*itemreducetime+self.lyUseNum*lyreducetime
local addyear=gameUtilityModel.calculateGameYearCeil(addtime)
if addyear<0 then
addyear=0
end
self.cancuishuyear:setText(addyear.."年")

end

local btncmp=
{
btn1=0,
btn2=1,
text1=2,
text2=3,
}

function UIYFLTTipsWin:SetButtonData()
local widget=self.buttonroot:getChildWidgetBase()

if self.formType and self.formType==TIPS_FORM_TYPE.eYFLTBag then
widget:SetChildText(btncmp.text1,"种植")
widget:SetChildButtonClick(btncmp.btn1,function()
local dzid=YiFangLingTianModel:GetNowDzID()
if tostring(dzid)=='0'then
UIManager.info("请先安排弟子")
return
end
UIManager:invokeUIMethod("UIYFLTBagWin","onClickClose")
UIManager:invokeUIMethod("UIYFLTMapWin","preparePlanting",self.itemId)
self:closeSelf()
end)
widget:SetChildText(btncmp.text2,"获取")
widget:SetChildButtonClick(btncmp.btn2,function()
gainControl:showCommonGainWin_item(self.itemId)
end)
elseif self.formType and self.formType==TIPS_FORM_TYPE.eBagGrids then
widget:SetChildText(btncmp.text1,"种植")
widget:SetChildButtonClick(btncmp.btn1,function()
if not systemModel.isOpen(SYSTEM_DEFINE.eYiFangLingTian)then
local notOpen_text=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,"notOpen_text")
local openday=timeHelper.getServerOpenDay()
local opensever_time=cfgHelper.get2(cfg_yifanglingtianbaseconfig_get,1,"opensever_time")
for k,v in ipairs(opensever_time)do
if openday>=v then
UIManager.info(notOpen_text[k])
break
end
end
return
end
jumpManager:jump({id=JUMP_TYPE.eBuilding,args={type=SLG_SYSTEM_TYPE.eYiFangLingTian,args={showgubao=true}}},nil)
end)
widget:SetChildText(btncmp.text2,"获取")
widget:SetChildButtonClick(btncmp.btn2,function()
gainControl:showCommonGainWin_item(self.itemId)
end)
elseif self.YFLTBagCome then
self.elsewinCome=true

self.buttonroot:setActive(false)
else
local index=YiFangLingTianModel:GetNextJieDuan(self.itemId,self.data.total_times)
if index==0 then
local conf=cfgHelper.get1(cfg_yifanglintianconfig_get,self.itemId)
local itemConfig=itemsConfig.getConfig(self.itemId)
local growyear=gameUtilityModel.calculateGameYearFloor(self.data.total_times)
local maxyear=YiFangLingTianModel:GetMaxYear(self.itemId)
if growyear>maxyear then
growyear=maxyear
end
if growyear<0 then
growyear=0
end

widget:SetChildText(btncmp.text2,"铲除")
widget:SetChildButtonClick(btncmp.btn2,function()
local x=self.x
local y=self.y
local callback=function()
YiFangLingTianController:req_3_85(x,y)
this:closeSelf()
end
self:showDialog(string.format("<color=%s>%s</color>已生长%d年，是否要铲除？\n（铲除灵植后不会返还种子）",FONT_COLOR_VAL[itemConfig.color],conf.tips_plantname,growyear),callback)

end)
else

widget:SetChildText(btncmp.text2,"采摘")
widget:SetChildButtonClick(btncmp.btn2,function()
local group_conf=cfgHelper.get2(cfg_yifanglintianconfig_get,self.itemId,"group_conf")
local maxtime=group_conf[#group_conf][1]
local growtime=self.data.total_times
if growtime>maxtime then
YiFangLingTianController:req_3_84(1,{{self.data.x,self.data.y}})
self:closeSelf()
return
else
local conf=cfgHelper.get1(cfg_yifanglintianconfig_get,self.itemId)
local itemConfig=itemsConfig.getConfig(self.itemId)
local callback=function()
YiFangLingTianController:req_3_84(1,{{self.data.x,self.data.y}})
this:closeSelf()
end
self:showDialog(string.format("<color=%s>%s</color>尚未成长至“%s”，\n祖师是否提前采摘？",FONT_COLOR_VAL[itemConfig.color],conf.tips_plantname,conf.tips_stagetxt[#conf.tips_stagetxt]),callback)

end



end)
end

widget:SetChildText(btncmp.text1,"催熟")
widget:SetChildButtonClick(btncmp.btn1,function()
local group_conf=cfgHelper.get2(cfg_yifanglintianconfig_get,self.itemId,"group_conf")
local maxtime=group_conf[#group_conf][1]
local growtime=self.data.total_times
if growtime>maxtime then
UIManager.info("已经完全成熟")
return
end
if self.cuishuFlag then
return
end
self.cuishuFlag=true

self.model2:setChildUIModelShowTarget(5478,1,{},2501)

local func=function()
self.CuiShuBtn:setActive(true)
self.CancelBtn:setActive(true)
self.cuishuroot:setActive(true)
self.changeid=nil
end
if not self.changeid then
self.changeid=self:setTimer(0.33,1,func)
end
self.introduceroot:setActive(false)


self:SetCuiShuWin()
self.buttonroot:setActive(false)

end)
end
end


function UIYFLTTipsWin:showDialog(content,callback,ok,cancel)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext=ok or'确定',
canceltext=cancel or'取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end


function UIYFLTTipsWin:onCancelBtn()
self.itemUseNum=0
self.lyUseNum=0
self.cuishuroot:setActive(false)

self.cuishuBg:setActive(false)
self.CuiShuBtn:setActive(false)
self.CancelBtn:setActive(false)
self.buttonroot:setActive(true)
self.cuishuFlag=false
self.model2:setChildUIModelShowTarget(5478,1,{},2501)
local func=function()
self.introduceroot:setActive(true)
self.changeid=nil
end
if not self.changeid then
self.changeid=self:setTimer(0.33,1,func)
end
self:SetButtonData()
local lyhavenum,itemhavenum,lyreducetime,itemreducetime,itemId=YiFangLingTianModel:Get_HaveItemAndLy()
self:ChangeData(itemreducetime,lyreducetime)
end

function UIYFLTTipsWin:onCuiShuBtn()
if(self.lyUseNum and self.lyUseNum<=0)and(self.itemUseNum and self.itemUseNum<=0)then
UIManager.info("尚未选择催熟灵液或甘露")
return
end
local growyear=gameUtilityModel.calculateGameYearFloor(self.data.total_times)
local maxyear=YiFangLingTianModel:GetMaxYear(self.itemId)
if growyear>=maxyear then
UIManager.info("已经完全成熟")
return
end

if self.lyUseNum and self.lyUseNum>0 then
YiFangLingTianController:req_3_83(1,{{self.x,self.y,self.lyUseNum}})
end
if self.itemUseNum and self.itemUseNum>0 then
YiFangLingTianController:req_3_87(1,{{self.x,self.y,self.addspeedItemID,self.itemUseNum}})
end
local lyhavenum,itemhavenum,lyreducetime,itemreducetime,itemId=YiFangLingTianModel:Get_HaveItemAndLy()
self.recordyear=0
if self.lyUseNum>0 then
self.recordyear=self.recordyear+self.lyUseNum*lyreducetime
end
if self.itemUseNum>0 then
self.recordyear=self.recordyear+self.itemUseNum*itemreducetime
end


end

function UIYFLTTipsWin:CuishuCallback()
if not self.recordyear then
return
end
self.recordyear=gameUtilityModel.calculateGameYearFloor(self.recordyear)
if self.recordyear>0 then
UIManager.info(string.format("成功催熟%d年",self.recordyear))

self.cuishuEffect:setChildShowEffect(20415,true)
end
end

function UIYFLTTipsWin:onClickClose()
self:closeSelf()
end


function UIYFLTTipsWin:onLeftbutton()
self:changetip(0)

end

function UIYFLTTipsWin:onRightbutton()
self:changetip(1)
end


