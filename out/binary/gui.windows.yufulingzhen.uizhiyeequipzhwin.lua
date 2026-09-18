







def_class("UIZhiYeEquipZHWin",UIWindowBase)









function UIZhiYeEquipZHWin:bindComponents()

self.add=UIObject.get(self,0)
self.cancelbtn=UIButton.get(self,1)
self.centerPanel=UIObject.get(self,2)
self.itembg=UIButton.get(self,3)
self.leftItemImage=UIButton.get(self,4)
self.leftItemImg=UIImage.get(self,5)
self.leftLevel=UIText.get(self,6)
self.remainTimes=UIText.get(self,7)
self.replace=UIObject.get(self,8)
self.rightItemImage=UIImage.get(self,9)
self.rightItemImg=UIImage.get(self,10)
self.rightLevel=UIText.get(self,11)
self.rightText=UIText.get(self,12)
self.tips=UIText.get(self,13)
self.zhuanHuanbtn=UIButton.get(self,14)
self.costitem=UIObject.get(self,15)
self.leftlvbg=UIObject.get(self,16)
self.rightlvbg=UIObject.get(self,17)

self.cancelbtn:setButtonClick(function()self:onCancelbtn()end)

self.itembg:setButtonClick(function()self:onItembg()end)

self.leftItemImage:setButtonClick(function()self:onLeftItemImage()end)

self.zhuanHuanbtn:setButtonClick(function()self:onZhuanHuanbtn()end)



end


function UIZhiYeEquipZHWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.add);self.add=nil;
_UIObject_release(self.cancelbtn);self.cancelbtn=nil;
_UIObject_release(self.centerPanel);self.centerPanel=nil;
_UIObject_release(self.itembg);self.itembg=nil;
_UIObject_release(self.leftItemImage);self.leftItemImage=nil;
_UIObject_release(self.leftItemImg);self.leftItemImg=nil;
_UIObject_release(self.leftLevel);self.leftLevel=nil;
_UIObject_release(self.remainTimes);self.remainTimes=nil;
_UIObject_release(self.replace);self.replace=nil;
_UIObject_release(self.rightItemImage);self.rightItemImage=nil;
_UIObject_release(self.rightItemImg);self.rightItemImg=nil;
_UIObject_release(self.rightLevel);self.rightLevel=nil;
_UIObject_release(self.rightText);self.rightText=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.zhuanHuanbtn);self.zhuanHuanbtn=nil;
_UIObject_release(self.costitem);self.costitem=nil;
_UIObject_release(self.leftlvbg);self.leftlvbg=nil;
_UIObject_release(self.rightlvbg);self.rightlvbg=nil;
end
















local _this



function UIZhiYeEquipZHWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)

end


function UIZhiYeEquipZHWin:__delete()
self:unbindComponents()
self:closeWindow('UITopMoneyWin2')
_this=nil
end

function UIZhiYeEquipZHWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
_this:FreshBtnGray()
end
function UIZhiYeEquipZHWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
_this:FreshBtnGray()
end

function UIZhiYeEquipZHWin:freshonNewMonth5am()
if _this==nil then return end
_this:refreshRemainTimes()
_this:FreshBtnGray()
end


function UIZhiYeEquipZHWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UIZhiYeEquipZHWin:onLeftItemImage()
tipsManager.showTips({itemid=self.leftItemId,itemguid=self.leftitemguId})
end

function UIZhiYeEquipZHWin:onItembg()
local temp=
{
leftItemId=self.leftItemId,
jinglianlv=self.jinglianlv,
leftitemguId=self.leftitemguId,
selectCallback=function(itemid)
self:selectLzId(itemid)
end,
}
self:showWindow("UIZhiYeEquipZHSelectWin",temp)
end

function UIZhiYeEquipZHWin:onZhuanHuanbtn()
local maxtimes=self.cfg_month_max_cnt
local nowtimes=vocEquipModel:getSwitch_cnt()
local remainTimes=maxtimes-nowtimes
if remainTimes<=0 then
UIManager.info('本月转换次数已用完')
return
end
if not self.rightItemId then
UIManager.info('请先选择需要的职业装备')
return
end
if self.cost then
for k,v in ipairs(self.cost)do
local costdata=v
local itemid=costdata[1]
local itemnum=costdata[2]
local bagnum=0
if moneyConfig.isMoney(itemid)then
bagnum=moneyModel.getMoney(itemid)
else
bagnum=bagModel.getItemCountById(itemid)
end

if bagnum<itemnum then
if itemid==eMoneyType.mtLingYu then

local needXianYuCount=itemnum-bagnum
local isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
if not isEnough then
gainControl:showGainWin(itemid)
return
end
else
gainControl:showGainWin(itemid)
return
end
end
end


local jinglianlv=self.jinglianlv
if self.cost[2]then
local costnum1=self.cost[1][2]
local costnum2=self.cost[2][2]
local costName1=iconHelper.getIconName(self.cost[1][1])
local costName2=iconHelper.getIconName(self.cost[2][1])
local iconStr1=chatEmotHelper.getIconEmotMesg(costName1,40)
local iconStr2=chatEmotHelper.getIconEmotMesg(costName2,40)
local leftItemCfg=itemsConfig.getConfig(self.leftItemId)
local rightItemCfg=itemsConfig.getConfig(self.rightItemId)
local str=FMT.fmt("是否消耗<color=#549327>{0}{1},{2}{3}</color>将所选择的\n<color=#c86728>{5}+{4}</color>转换为<color=#c86728>{7}+{6}</color>"
,iconStr1,costnum1,iconStr2,costnum2,jinglianlv,leftItemCfg.name,jinglianlv,rightItemCfg.name)
local show_data=
{
type='UIDialougeWithIcon',
title='提示',
content=str,
oktext='确认',
canceltext='取消',
allowclickBG=false,
okcallback=function()
if _this==nil then return end
self:zhuanHuanBtn()
self:onCancelbtn()
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(show_data)
self.comfirmDialog:show()
else
local cb=function(...)
if _this==nil then return end
self:zhuanHuanBtn()
self:onCancelbtn()
end
local costid1=self.cost[1][1]
local costnum1=self.cost[1][2]
local costName1=iconHelper.getIconName(self.cost[1][1])
local iconStr1=chatEmotHelper.getIconEmotMesg(costName1,40)
local leftItemCfg=itemsConfig.getConfig(self.leftItemId)
local rightItemCfg=itemsConfig.getConfig(self.rightItemId)
local str=FMT.fmt("是否消耗<color=#549327>{0}{1}</color>将所选择的\n<color=#c86728>{3}+{2}</color>转换为<color=#c86728>{5}+{4}</color>"
,iconStr1,costnum1,jinglianlv,leftItemCfg.name,jinglianlv,rightItemCfg.name)
local show_data=
{
type='UIDialougeWithIcon',
title='提示',
content=str,
oktext='确认',
canceltext='取消',
allowclickBG=false,
okcallback=function()
if _this==nil then return end
if costid1==eMoneyType.mtLingYu then
moneySystem:useMoney(costid1,costnum1,cb,WARNING_TYPE.eWarning)
else
cb()
end
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(show_data)
self.comfirmDialog:show()
end
else
self:zhuanHuanBtn()
self:onCancelbtn()
end
end

function UIZhiYeEquipZHWin:zhuanHuanBtn()
local pos=0
local guid=self.leftitemguId
local right_item_id=self.rightItemId
if vocEquipModel:isEquipedOnAnyDizi(guid)then
guid=vocEquipModel:getDiziguidByItemguid(guid)
pos=1
end
vocEquipController.req_vocEquip_ZhuanHuan(guid,pos,right_item_id)
end





function UIZhiYeEquipZHWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local itemguid=argtable.itemguid
self.selectGuid=itemguid
self.cfg_cost=cfgHelper.get(cfg_disciplevocequipswitchconfig_get,1,"cost")
self.cfg_month_max_cnt=cfgHelper.get(cfg_disciplevocequipswitchconfig_get,1,"month_max_cnt")
self.cfg_sys_id=cfgHelper.get(cfg_disciplevocequipswitchconfig_get,1,"sys_id")


self.equip=nil
if argtable and argtable.diziguid then
local equipType=EQUIP_TYPE.eVocEquip
local equip=equipsHelper.getEquipByDizi(argtable.diziguid,equipType)
self.equip=equip
end
if argtable and argtable.itemguid then
local equip=equipsHelper.getEquip(argtable.itemguid)
self.equip=equip
end


self:refreshLeftItem()


local now_jinglianlv=self.jinglianlv or 0
local cost
for k,v in ipairs(self.cfg_cost)do
if v[1]<=now_jinglianlv and v[2]>=now_jinglianlv then
cost=v[3]
end
end
self.cost=cost


if self.cost then
local hobilist={}
for k,v in ipairs(self.cost)do
local costdata=v
local itemid=costdata[1]
if moneyConfig.isMoney(itemid)then
hobilist[#hobilist+1]={itemid}
if itemid==eMoneyType.mtLingYu then
hobilist[#hobilist+1]={eMoneyType.mtXianYu}
end
end
end
if#hobilist>0 then
self:showWindow("UITopMoneyWin2",{moneys=hobilist,offsetX=0,offsetY=-40})
end
end

self:showEmptyPanel()


self:refreshRemainTimes()
self.tips:setText('')


self:refreshCost(self.cost)
end


function UIZhiYeEquipZHWin:onHide()
end
function UIZhiYeEquipZHWin:onCancelbtn()
self:closeSelf()
end


function UIZhiYeEquipZHWin:refreshRemainTimes()
local maxtimes=self.cfg_month_max_cnt
local nowtimes=vocEquipModel:getSwitch_cnt()
local remainTimes=maxtimes-nowtimes
if remainTimes>0 then
self.remainTimes:setText(FMT.fmt("本月剩余次数：{0}",remainTimes))
else
self.remainTimes:setText("每月1日5点重置转换次数")
end
end

function UIZhiYeEquipZHWin:showEmptyPanel()
self.rightItemId=false
self.rightItemImg:setActive(false)
self.rightItemImage:setActive(false)
self.add:setActive(true)
end

function UIZhiYeEquipZHWin:refreshLeftItem()
local equip=self.equip
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local colorPage=itemConfig.colorPage or 0
local jinglianlv=equip.itemData and equip.itemData.enhancelv or 0
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local iconName=itemsModel.getIconName(equip)
if jinglianlv>0 then
self.leftlvbg:setActive(true)
self.leftLevel:setText(jinglianStr)
else
self.leftlvbg:setActive(false)
end

self.leftItemId=itemid
self.leftitemguId=itemguid
self.jinglianlv=jinglianlv


self.leftItemImg:setActive(true)
self.winlua:SetChildQulaityEx(self.leftItemImg:getID(),colorPage,color)


self.leftItemImage:setActive(true)
self.winlua:SetChildIcon(self.leftItemImage:getID(),iconName,false)
end
end


function UIZhiYeEquipZHWin:selectLzId(itemid)
self.rightItemId=itemid
self:refreshRightItem(itemid)


self:refreshCost(self.cost)
end


function UIZhiYeEquipZHWin:refreshRightItem(itemid)
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local colorPage=itemConfig.colorPage or 0
local jinglianlv=self.jinglianlv
local jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
local iconName=iconHelper.getIconName(itemid)
if jinglianlv>0 then
self.rightlvbg:setActive(true)
self.rightLevel:setText(jinglianStr)
else
self.rightlvbg:setActive(false)
end


self.rightItemImg:setActive(true)
self.winlua:SetChildQulaityEx(self.rightItemImg:getID(),colorPage,color)


self.rightItemImage:setActive(true)
self.winlua:SetChildIcon(self.rightItemImage:getID(),iconName,false)

self.add:setActive(false)
self.replace:setActive(true)
self.rightText:setText('转换后')
end

function UIZhiYeEquipZHWin:refreshCost(cost)
local isgray=false
if cost then
self.centerPanel:setActive(true)
local costWidget=self.costitem:getWidgetBase()
for k,v in ipairs(cost)do
costWidget:SetChildActive(k-1,true)
local costdata=v
local itemid=costdata[1]
local itemnum=costdata[2]
local havecount=0
local itemcount=""
local graynum=0
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end
if havecount>=itemnum then

itemcount=FMT.fmt('{0}',mathHelper.formatNumber9(itemnum,1))
else

itemcount=FMT.fmt('<color=#f36666>{0}</color>',mathHelper.formatNumber9(itemnum,1))
graynum=0
isgray=true
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=true,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
costWidget:SetChildPropData(k-1,prop)
costWidget:SetBaseItemClickEvent(k-1,function(...)
if _this==nil then return end
self:onClickItem(...)
end)
end
end

local maxtimes=self.cfg_month_max_cnt
local nowtimes=vocEquipModel:getSwitch_cnt()
local remainTimes=maxtimes-nowtimes
if remainTimes<=0 or not self.rightItemId then
isgray=true
end
self.winlua:SetChildGray(self.zhuanHuanbtn:getID(),isgray)
end

function UIZhiYeEquipZHWin:FreshBtnGray()
local isgray=false
if self.cost then
for k,v in ipairs(self.cost)do
local costdata=v
local itemid=costdata[1]
local itemnum=costdata[2]
local havecount=0
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end
if havecount<itemnum then
isgray=true
break
end
end
end
local maxtimes=self.cfg_month_max_cnt
local nowtimes=vocEquipModel:getSwitch_cnt()
local remainTimes=maxtimes-nowtimes
if remainTimes<=0 or not self.rightItemId then
isgray=true
end
self.winlua:SetChildGray(self.zhuanHuanbtn:getID(),isgray)
end

