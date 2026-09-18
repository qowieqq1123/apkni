







def_class("UIFlyupward_speed",UIWindowBase)









function UIFlyupward_speed:bindComponents()

self.adItemClick=UIButton.get(self,0)
self.btnAdsSpeedup=UIButton.get(self,1)
self.btnClose=UIButton.get(self,2)
self.cdPanel=UIObject.get(self,3)
self.cdProgress=UIObject.get(self,4)
self.completeBtn=UIButton.get(self,5)
self.completeText=UIText.get(self,6)
self.iconAds=UIImage.get(self,7)
self.itemroot=UIObject.get(self,8)
self.payAds=UIText.get(self,9)
self.proAddExp=UIProgressBarAni.get(self,10)
self.proExp=UIObject.get(self,11)
self.reduce=UIText.get(self,12)
self.reducetime=UIText.get(self,13)
self.speedUpBtnText=UIText.get(self,14)
self.time2=UIText.get(self,15)
self.title=UIText.get(self,16)
self.topPanel=UIObject.get(self,17)

self.adItemClick:setButtonClick(function()self:onAdItemClick()end)

self.btnAdsSpeedup:setButtonClick(function()self:onBtnAdsSpeedup()end)

self.btnClose:setButtonClick(function()self:onBtnClose()end)

self.completeBtn:setButtonClick(function()self:onCompleteBtn()end)



end


function UIFlyupward_speed:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.adItemClick);self.adItemClick=nil;
_UIObject_release(self.btnAdsSpeedup);self.btnAdsSpeedup=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.cdPanel);self.cdPanel=nil;
_UIObject_release(self.cdProgress);self.cdProgress=nil;
_UIObject_release(self.completeBtn);self.completeBtn=nil;
_UIObject_release(self.completeText);self.completeText=nil;
_UIObject_release(self.iconAds);self.iconAds=nil;
_UIObject_release(self.itemroot);self.itemroot=nil;
_UIObject_release(self.payAds);self.payAds=nil;
_UIObject_release(self.proAddExp);self.proAddExp=nil;
_UIObject_release(self.proExp);self.proExp=nil;
_UIObject_release(self.reduce);self.reduce=nil;
_UIObject_release(self.reducetime);self.reducetime=nil;
_UIObject_release(self.speedUpBtnText);self.speedUpBtnText=nil;
_UIObject_release(self.time2);self.time2=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.topPanel);self.topPanel=nil;
end


















local itemcmp=
{
rewarditem=0,
slider=1,
count=2,
add=3,
cut=4,
name=5,
effecttext=6,
txt_name=7,
}
local feishengtaiid=81
local _this

function UIFlyupward_speed:onLoaded(...)
self:bindComponents()
_this=self
end


function UIFlyupward_speed:__delete()
self:unbindComponents()
end




function UIFlyupward_speed:onShow(argtable,afterOnloaded)
if argtable then
self.bdData=argtable.bdData
self.un_build_id=self.bdData.un_build_id
self.buildid=self.bdData.build_id
self.flag=argtable.flag
if not self.flag or self.flag==1 then
self.completeText:setText("修复完成")
else
self.completeText:setText("升级完成")
end

end
self.title:setText("加速时间")
if self.buildid==feishengtaiid then
self.baseCfg=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'reduce_times_itemlist')
else
self.baseCfg=cfgHelper.get2(cfg_dujietreasuresbasicconfig_get,1,'reduce_times_itemlist')
end
self:refreshdata()

end


function UIFlyupward_speed:onHide()

end

function UIFlyupward_speed:refreshdata(reducetime)
self:SetProgressbar(reducetime)
self:SetItem()
end

function UIFlyupward_speed:SetItem()
self.reducetime:setActive(false)
self.reduce:setActive(false)

local itemtable={}

self.recorditem={}
for k,v in pairs(self.baseCfg)do
local itemid=k
itemtable[#itemtable+1]={itemid,v}
self.recorditem[itemid]={time=v,selectnum=0}
end
table.sort(itemtable,function(a,b)
local itemConfig1=itemsConfig.getConfig(a[1])
local color1=itemConfig1.color
local itemConfig2=itemsConfig.getConfig(b[1])
local color2=itemConfig2.color
return color1>color2
end)
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.un_build_id)

self.Slidertable={}
self.itemroot:setChildLayoutGroupCreateItems(3,function(index)
if itemtable[index]then
local itemId=itemtable[index][1]
local rewardItem=self.itemroot:getChildLayoutGroupGridItem(index-1)
rewardItem:SetChildActive(-1,true)
local havenum=itemsModel.getCount(itemId)
local itemConfig=itemsConfig.getConfig(itemId)
local color=itemConfig.color
local itemname=itemConfig.name
local costtime=itemtable[index][2]

local Can_usenum=math.ceil(self.lastTime/costtime)

local jia_havenum=havenum>Can_usenum and Can_usenum or havenum
local rewardData={itemId,havenum}

local showCountBG=rewardData[2]
local countStr=showCountBG and havenum or""
local conf={itemid=rewardData[1],itemcount=countStr,showCountBG=true,showname=true,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
local showtime=math.ceil(costtime/3600)
rewardItem:SetChildText(itemcmp.effecttext,string.format("%d小时/个",showtime))
rewardItem:SetChildPropData(itemcmp.rewarditem,prop)
rewardItem:SetChildText(itemcmp.txt_name,string.format("<color=%s>%s</color>",FONT_COLOR_VAL[color],itemname))



self.Slidertable[itemId]={maxnum=0}
if jia_havenum==0 then
jia_havenum=1
end
rewardItem:SetChildSlider(itemcmp.slider,0,0,jia_havenum,function(val)
local gameob=rewardItem:GetChildGameObject(1)
local component=gameob:GetComponent("Slider")
if _this.lockClick then
component.value=self.Slidertable[itemId].maxnum
return
end

local recordtime=0
for k,v in pairs(self.Slidertable)do
if k~=itemId then

recordtime=recordtime+v.maxnum*self.recorditem[k].time
end
end


local time=self.lastTime-recordtime

local num=time/costtime
num=math.abs(math.ceil(num))
if num>havenum then
num=havenum
end


local value=math.ceil(val)
local jinduvalue=value
if jinduvalue>num then
jinduvalue=num
end

local yujinum=cddata.dtime+recordtime+jinduvalue*self.recorditem[itemId].time
self.proAddExp:animateThreeParams(yujinum,cddata.ntime,0)

self.reducetime:setActive(recordtime+jinduvalue*self.recorditem[itemId].time>0)
self.reduce:setActive(recordtime+jinduvalue*self.recorditem[itemId].time>0)
self.reducetime:setText(timeHelper.format_time_stamp11(recordtime+jinduvalue*self.recorditem[itemId].time))
if value>num then
component.value=num
self.Slidertable[itemId]={maxnum=num}
rewardItem:SetChildText(itemcmp.count,num)
return
elseif havenum==0 then
component.value=0
self.Slidertable[itemId]={maxnum=0}
rewardItem:SetChildText(itemcmp.count,0)

else
rewardItem:SetChildText(itemcmp.count,value)
self.Slidertable[itemId]={maxnum=value}
end


end)
rewardItem:SetChildText(itemcmp.count,0)
rewardItem:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClickEx(...)
end)



rewardItem:SetChildButtonClick(itemcmp.add,function()
if _this.lockClick then
return
end
local rewardItem=self.itemroot:getChildLayoutGroupGridItem(index-1)
if not self.Slidertable[itemId]then
self.Slidertable[itemId]={maxnum=0}
end

local gameob=rewardItem:GetChildGameObject(1)
local component=gameob:GetComponent("Slider")
local recordtime=0
for k,v in pairs(self.Slidertable)do
if k~=itemId then
recordtime=recordtime+v.maxnum*self.recorditem[k].time
end
end


local time=self.lastTime-recordtime
if time<0 then
return
end

self.Slidertable[itemId].maxnum=self.Slidertable[itemId].maxnum+1

local num=time/costtime
num=math.abs(math.ceil(num))
if num>havenum then
num=havenum
end
if self.Slidertable[itemId].maxnum>havenum then
gainControl:showGainWin(itemId)
UIManager.info(string.format("<color=%s>%s</color>不足",FONT_COLOR_VAL[color],itemname))
end
if self.Slidertable[itemId].maxnum>num then
self.Slidertable[itemId].maxnum=num
end
component.value=self.Slidertable[itemId].maxnum
rewardItem:SetChildText(itemcmp.count,self.Slidertable[itemId].maxnum)
end)
rewardItem:SetChildButtonClick(itemcmp.cut,function()
if _this.lockClick then
return
end
local rewardItem=self.itemroot:getChildLayoutGroupGridItem(index-1)
if not self.Slidertable[itemId]then
self.Slidertable[itemId]={maxnum=0}
end
self.Slidertable[itemId].maxnum=self.Slidertable[itemId].maxnum-1
local gameob=rewardItem:GetChildGameObject(1)
local component=gameob:GetComponent("Slider")
if self.Slidertable[itemId].maxnum<0 then
self.Slidertable[itemId].maxnum=0
end
component.value=self.Slidertable[itemId].maxnum
rewardItem:SetChildText(itemcmp.count,self.Slidertable[itemId].maxnum)
end)
else
local rewardItem=self.itemroot:getChildLayoutGroupGridItem(index-1)
rewardItem:SetChildActive(-1,false)
end
end)

end
function UIFlyupward_speed.onAdd(index,itemId)




local rewardItem=self.itemroot:getChildLayoutGroupGridItem(index-1)

rewardItem:SetChildSliderValue(itemcmp.slider,self.Slidertable[itemId]+1)

end


function UIFlyupward_speed:SetProgressbar(reducetimes)
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.un_build_id)

self.cdPanel:setActive(true)

self.time2:setText(timeHelper.format_time_stamp11(cddata.cd))
if not reducetimes then
self.winlua:SetChildUIProgressbar(self.cdProgress:getID(),cddata.dtime,cddata.ntime,false)
else
self:refreshLevelProgressGreen(cddata.dtime/cddata.ntime)
end


self.lastTime=cddata.cd
if cddata.complete then
self.completeBtn:setActive(true)
self.btnAdsSpeedup:setActive(false)
else
self.completeBtn:setActive(false)
self.btnAdsSpeedup:setActive(true)
end

self:stopCOuntDown()
if not cddata.complete then
self:startCountDown()
else
self.time2:setText('已完成')

end
end

function UIFlyupward_speed:startCountDown()
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.un_build_id)


local tick=function()
self.lastTime=cddata.cd
self.time2:setText(timeHelper.format_time_stamp11(cddata.cd))
self.proExp:setChildIconFillAmount((cddata.dtime+1)/cddata.ntime)

if cddata.complete then
self:stopCOuntDown()
self:refresh()
end
end

self:addCDUpdateFunc('SRPCD',tick)
end

function UIFlyupward_speed:stopCOuntDown()




self:removeCDUpdateFunc('SRPCD')
end

function UIFlyupward_speed:refresh()
self.time2:setText("已完成")
self.btnAdsSpeedup:setActive(false)
self:closeSelf()
end




function UIFlyupward_speed:onBtnClose()
self:closeSelf()
end

function UIFlyupward_speed:onBtnAdsSpeedup()
self.speedup_type=speedUpType.eUpgradeBuilding
self.sfId=zongmenModel:getMountainId()

if next(self.Slidertable)then
local itemlist={}
for k,v in pairs(self.Slidertable)do
if v.maxnum>0 then
itemlist[#itemlist+1]={k,v.maxnum}
end
end
local reducetime=0
local cddata=buildingCDControl:getCDData(buildingCDType.build,self.un_build_id)
for k,v in pairs(self.Slidertable)do
reducetime=reducetime+v.maxnum*self.recorditem[k].time
end
local buildid=_this.buildid
if reducetime>cddata.cd then
local contentStr=FMT.fmt('本次道具加速时间超过目前需求\n时间<color=#c82c2c>{0}</color>，是否继续使用',timeHelper.format_time_stamp11(reducetime-cddata.cd))
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()
if buildid==feishengtaiid then
FeiShengTaiController:SendFeiSheng_JiaSu(#itemlist,itemlist)
else
DuJieZhiBaoController:send_34_33(buildid,#itemlist,itemlist)
end
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
else
if buildid==feishengtaiid then
FeiShengTaiController:SendFeiSheng_JiaSu(#itemlist,itemlist)
else
DuJieZhiBaoController:send_34_33(buildid,#itemlist,itemlist)
end
end
end
end


function UIFlyupward_speed:onCompleteBtn()
local sfId=zongmenModel:getMountainId()
zongmenControl:reqBuildingLevelUpComplete(sfId,self.un_build_id)
UIManager:invokeUIMethod("UISectionRepair_flyupward","onClickClose")
self:closeSelf()
end

function UIFlyupward_speed:onClickClose()
self:closeSelf()
end

function UIFlyupward_speed:onAdItemClick()

end
function UIFlyupward_speed:showinfotext()
UIManager.info("加速成功")
end


function UIFlyupward_speed:refreshLevelProgressGreen(rate)
local bFunc=function()
if _this==nil then return end
_this.lockClick=true
end
local eFunc=function()
if _this==nil then return end
_this.lockClick=nil
end

helper.playProgressAnim(self.proExp,rate,0,bFunc,eFunc,nil,2)
end