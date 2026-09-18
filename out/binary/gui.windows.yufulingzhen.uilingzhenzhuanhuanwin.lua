







def_class("UILingzhenZhuanHuanWin",UIWindowBase)









function UILingzhenZhuanHuanWin:bindComponents()

self.add=UIObject.get(self,0)
self.cancelbtn=UIButton.get(self,1)
self.centerPanel=UIObject.get(self,2)
self.itembg=UIButton.get(self,3)
self.leftItemImage=UIButton.get(self,4)
self.leftItemImg=UIImage.get(self,5)
self.leftLevel=UIText.get(self,6)
self.materials=UIObject.get(self,7)
self.materialsItem_1=UIBaseItem.get(self,8)
self.materialsItem_2=UIBaseItem.get(self,9)
self.remainTimes=UIText.get(self,10)
self.replace=UIObject.get(self,11)
self.rightItemImage=UIImage.get(self,12)
self.rightItemImg=UIImage.get(self,13)
self.rightLevel=UIText.get(self,14)
self.rightText=UIText.get(self,15)
self.tips=UIText.get(self,16)
self.zhuanHuanbtn=UIButton.get(self,17)

self.cancelbtn:setButtonClick(function()self:onCancelbtn()end)

self.itembg:setButtonClick(function()self:onItembg()end)

self.leftItemImage:setButtonClick(function()self:onLeftItemImage()end)

self.zhuanHuanbtn:setButtonClick(function()self:onZhuanHuanbtn()end)
self.materialsItem={
self.materialsItem_1,
self.materialsItem_2,
}



end


function UILingzhenZhuanHuanWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.add);self.add=nil;
_UIObject_release(self.cancelbtn);self.cancelbtn=nil;
_UIObject_release(self.centerPanel);self.centerPanel=nil;
_UIObject_release(self.itembg);self.itembg=nil;
_UIObject_release(self.leftItemImage);self.leftItemImage=nil;
_UIObject_release(self.leftItemImg);self.leftItemImg=nil;
_UIObject_release(self.leftLevel);self.leftLevel=nil;
_UIObject_release(self.materials);self.materials=nil;
_UIObject_release(self.materialsItem_1);self.materialsItem_1=nil;
_UIObject_release(self.materialsItem_2);self.materialsItem_2=nil;
_UIObject_release(self.remainTimes);self.remainTimes=nil;
_UIObject_release(self.replace);self.replace=nil;
_UIObject_release(self.rightItemImage);self.rightItemImage=nil;
_UIObject_release(self.rightItemImg);self.rightItemImg=nil;
_UIObject_release(self.rightLevel);self.rightLevel=nil;
_UIObject_release(self.rightText);self.rightText=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.zhuanHuanbtn);self.zhuanHuanbtn=nil;
self.materialsItem=nil;
end


















local convertCfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"convert")
local times=convertCfg[1]
local lv_limit=convertCfg[2]
local costCfg=convertCfg[3]
local _this


function UILingzhenZhuanHuanWin:onLoaded(...)
self:bindComponents()
_this=self
self:addNotify(notifyConfig.on_item_changed,self.on_item_changed)
self:addNotify(notifyConfig.on_money_changed,self.on_money_changed)
end


function UILingzhenZhuanHuanWin:__delete()
self:unbindComponents()
end




function UILingzhenZhuanHuanWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local itemguid=argtable.itemguid
local yufuGuid=argtable.yfguid
local kongIndex=argtable.kongIndex
self.selectGuid=itemguid
self.leftYfguid=yufuGuid
self.kongIndex=kongIndex

self:refreshLeftItem(itemguid,yufuGuid,kongIndex)
self:showEmptyPanel()

local item=UIYuFuLingZhenControl:getItem(itemguid,yufuGuid,kongIndex)
local itemid=item.itemid
if yufuGuid and kongIndex and kongIndex>0 then
itemid=item.itemId
end
local cfg=itemsConfig.getConfig(itemid)
self.leftType1=cfg.type1
self.level=cfg.level

self:refreshRemainTimes()
self.tips:setText(FMT.fmt('灵阵等级达到<color=#c86728>{0}级</color>才能进行转换',lv_limit))
self:checkZhuanHuan()
end


function UILingzhenZhuanHuanWin:onHide()
end

function UILingzhenZhuanHuanWin:selectLzId(itemid)
self.rightItemId=itemid
self:refreshRightItem(itemid)

self.centerPanel:setActive(true)
local itemCfg=itemsConfig.getConfig(itemid)
local type1=itemCfg.type1
local level=itemCfg.level
self:refreshCost(type1,level)
self:checkZhuanHuan()
end

function UILingzhenZhuanHuanWin:refreshLeftItem(itemguid,yufuGuid,kongIndex)
local item=UIYuFuLingZhenControl:getItem(itemguid,yufuGuid,kongIndex)
local itemid=item.itemId or item.itemid
self.leftItemId=itemid
if yufuGuid and kongIndex and kongIndex>0 then
itemid=item.itemId
end
local cfg=itemsConfig.getConfig(itemid)
local icon=UIYuFuLingZhenControl:getLZIconName(cfg)
self.leftItemImage:setActive(true)
self.leftItemImg:setActive(true)
self.leftItemImg:setCSImageSprite(globalABLookup.yufulingzhen,UIYuFuLingZhenControl:getPZIconName(cfg.color))
self.leftItemImage:setChildIcon(icon,true)
self.leftLevel:setText(cfg.level)
end

function UILingzhenZhuanHuanWin:refreshRightItem(itemid)
local cfg=itemsConfig.getConfig(itemid)
local icon=UIYuFuLingZhenControl:getLZIconName(cfg)
self.rightItemImage:setActive(true)
self.rightItemImg:setActive(true)
self.rightItemImg:setCSImageSprite(globalABLookup.yufulingzhen,UIYuFuLingZhenControl:getPZIconName(cfg.color))
self.rightItemImage:setChildIcon(icon,true)
self.rightLevel:setText(cfg.level)
self.add:setActive(false)
self.replace:setActive(true)
self.rightText:setText('转换后')
end

function UILingzhenZhuanHuanWin:showEmptyPanel()
self.rightItemImg:setActive(false)
self.rightItemImage:setActive(false)
self.add:setActive(true)
end

function UILingzhenZhuanHuanWin:refreshCost(type,level)
self.centerPanel:setActive(true)
local curCostCfg=costCfg[type]
self.curLevelCostCfg=curCostCfg[level]
self.cost1=self.curLevelCostCfg[1]
self.cost2=self.curLevelCostCfg[2]
self.costItemid1=self.cost1[1]
self.costItemNum1=self.cost1[2]
self.costItemid2=self.cost2[1]
self.costItemNum2=self.cost2[2]
self:refreshCostItem()






































end
function UILingzhenZhuanHuanWin:refreshCostItem()
local showCost={}
if moneyConfig.isMoney(self.costItemid1)then
table.insert(showCost,self.costItemid1)
end
if moneyConfig.isMoney(self.costItemid2)then
table.insert(showCost,self.costItemid2)
end
self:showWindow('UITopMoneyWin2',{showCost})
self.gainTable={}
for i=1,#self.materialsItem do
self.materialsItem[i]:setActive(i<=#self.curLevelCostCfg)
if i<=#self.curLevelCostCfg then
local costMat=self.curLevelCostCfg[i]
local matId=costMat[1]
local have=0
if moneyConfig.isMoney(matId)then
have=moneyModel.getMoney(matId)
else
have=bagControl.invokeFuncByItemId(matId,'getItemCountByItemID',matId)
end
local need=costMat[2]
local colorStr=have<need and'red'or'white'
local countStr=''
if moneyConfig.isMoney(matId)then
countStr=FMT.fmt('<color={0}>{1}</color>',colorStr,mathHelper.formatBIGNumbereEx(need))
else
countStr=FMT.fmt('<color={0}>{1}/{2}</color>',colorStr,mathHelper.formatBIGNumbereEx(have),mathHelper.formatBIGNumbereEx(need))
end
local matConf={itemid=matId,itemcount=countStr,showCountBG=true,showStage=true}
local matProp=itemsComponentHelper.getCommonFillDataSmall(matConf)
matProp[PropIndex(DataPropKey.eWidgetGray,0)]=have==0
matProp[PropIndex(DataPropKey.eWidgetGray,1)]=have==0
matProp[PropIndex(DataPropKey.eWidgetActive,7)]=have<need
self.gainTable[matId]=need
self.materialsItem[i]:setChildPropData(matProp)
self.materialsItem[i]:setBaseItemClickEvent(function(...)
if itemsModel.getCount(matId)<(self.gainTable[matId]or 0)then
local needCount=self.gainTable[matId]or 0
gainControl:showGainWin(matId,nil,{needCount=needCount})
return
end
tipsManager.showTips({itemid=matId,usingType=TIPS_USING_TYPE.eNormal})
end)
end
end
end

function UILingzhenZhuanHuanWin:refreshRemainTimes()
UIYuFuLingZhenControl:reqLZDatas()
self.convertNum=UIYuFuLingZhenControl:getConvertNum()
local remainTimes=times-self.convertNum
if remainTimes>0 then
self.remainTimes:setText(FMT.fmt("本月剩余次数：{0}",remainTimes))
else
self.remainTimes:setText("每月1日5点重置转换次数")
end
end

function UILingzhenZhuanHuanWin:refreshRemainTimesOnNewMonth5am()
self.convertNum=0
local remainTimes=times-self.convertNum
if remainTimes>0 then
self.remainTimes:setText(FMT.fmt("本月剩余次数:{0}",remainTimes))
else
self.remainTimes:setText("每月1日5点重置转换次数")
end
end

function UILingzhenZhuanHuanWin:checkZhuanHuan()
self.convertNum=UIYuFuLingZhenControl:getConvertNum()
local remainTimes=times-self.convertNum
if remainTimes>0 then
if self.rightItemId then
if self:checkCost()then
self.zhuanHuanbtn:setActive(true)
self.winlua:SetChildButtonEnable(self.zhuanHuanbtn:getID(),true,false)
else
self.winlua:SetChildButtonEnable(self.zhuanHuanbtn:getID(),true,true)
end
else
self.winlua:SetChildButtonEnable(self.zhuanHuanbtn:getID(),true,true)
end
else
self.winlua:SetChildButtonEnable(self.zhuanHuanbtn:getID(),true,true)
end
end

function UILingzhenZhuanHuanWin:checkCost()
local have1=0
local have2=0
if moneyConfig.isMoney(self.costItemid1)then
have1=moneyModel.getMoney(self.costItemid1)
else
have1=bagControl.invokeFuncByItemId(self.costItemid1,'getItemCountByItemID',self.costItemid1)
end
if moneyConfig.isMoney(self.costItemid2)then
have2=moneyModel.getMoney(self.costItemid2)
else
have2=bagControl.invokeFuncByItemId(self.costItemid2,'getItemCountByItemID',self.costItemid2)
end
if have1<self.costItemNum1 or have2<self.costItemNum2 then
return false
else
return true
end
end





function UILingzhenZhuanHuanWin:onCancelbtn()
self:closeSelf()
end



function UILingzhenZhuanHuanWin:onItembg()
self:showWindow("UIYFLZZhuanHuanSelectWin",{leftIndex=self.leftType1,leftItemId=self.leftItemId,selectCallback=function(itemid)
self:selectLzId(itemid)
end})
end



function UILingzhenZhuanHuanWin:onZhuanHuanbtn()
local convertNum=UIYuFuLingZhenControl:getConvertNum()
local remainTimes=times-convertNum
if remainTimes>0 then
if self.rightItemId then
if self:checkCost()then
local costName1=iconHelper.getIconName(self.costItemid1)
local costName2=iconHelper.getIconName(self.costItemid2)
local iconStr1=chatEmotHelper.getIconEmotMesg(costName1,40)
local iconStr2=chatEmotHelper.getIconEmotMesg(costName2,40)
local leftItemCfg=itemsConfig.getConfig(self.leftItemId)
local rightItemCfg=itemsConfig.getConfig(self.rightItemId)
local str=FMT.fmt("是否消耗<color=#549327>{0}{1},{2}{3}</color>将所选择的\n<color=#c86728>{4}级{5}</color>转换为<color=#c86728>{6}级{7}</color>"
,iconStr1,self.costItemNum1,iconStr2,self.costItemNum2,leftItemCfg.level,leftItemCfg.name,rightItemCfg.level,rightItemCfg.name)
local show_data=
{
type='UIDialougeWithIcon',
title='提示',
content=str,
oktext='确认',
canceltext='取消',
allowclickBG=false,
okcallback=function()
self:zhuanHuan()
end,
showclosebtn=true,
}
self.comfirmDialog=UIDialogManager.newDialog(show_data)
self.comfirmDialog:show()

else

local have1=0
local have2=0
if moneyConfig.isMoney(self.costItemid1)then
have1=moneyModel.getMoney(self.costItemid1)
else
have1=bagControl.invokeFuncByItemId(self.costItemid1,'getItemCountByItemID',self.costItemid1)
end
if moneyConfig.isMoney(self.costItemid2)then
have2=moneyModel.getMoney(self.costItemid2)
else
have2=bagControl.invokeFuncByItemId(self.costItemid2,'getItemCountByItemID',self.costItemid2)
end
if have1<self.costItemNum1 then
gainControl:showGainWin(self.costItemid1)
elseif have2<self.costItemNum2 then
gainControl:showGainWin(self.costItemid2)
end
end
else
UIManager.info('请选择需要的灵阵')
end
else
UIManager.info('本月转换次数已用完')
end
end

function UILingzhenZhuanHuanWin:onLeftItemImage()
tipsManager.showTips({itemid=self.leftItemId,itemguid=nil})
end


function UILingzhenZhuanHuanWin:zhuanHuan()
local dzId=UIFuLuFangModel:getDzGuidByItemGuid(self.leftYfguid)
UIYuFuLingZhenControl:reqZhuanHuan(self.selectGuid or int64.zero,dzId or int64.zero,self.leftYfguid or int64.zero,self.kongIndex or 0,self.rightItemId)
self:refreshRemainTimes()
end

function UILingzhenZhuanHuanWin.on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if _this==nil then return end
if itemid==_this.costItemid1 or itemid==_this.costItemid2 then
_this:refreshCostItem()
_this:checkZhuanHuan()
end
end

function UILingzhenZhuanHuanWin.on_money_changed(moneyType,lastVal,val)
if _this==nil then return end
if moneyType==_this.costItemid1 or moneyType==_this.costItemid2 then
_this:refreshCostItem()
_this:checkZhuanHuan()
end
end