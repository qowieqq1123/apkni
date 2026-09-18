







def_class("UISpeedUpUseWin",UIWindowBase)









function UISpeedUpUseWin:bindComponents()

self.applyBtn=UIButton.get(self,0)
self.applyText=UIText.get(self,1)
self.desc=UIText.get(self,2)
self.scrollView=UIObject.get(self,3)
self.time=UIText.get(self,4)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)



end


function UISpeedUpUseWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.applyText);self.applyText=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.time);self.time=nil;
end
















local _this=nil




function UISpeedUpUseWin:onLoaded(...)
_this=self
self:bindComponents()

self.speedUpItems={16001,16004}

self.scrollView:setChildScrollViewInit(0.5,true,function(...)self:onItemCLick(...)end,nil)

local baseCfg=cfgHelper.get2(cfg_monijybasicconfig_get,1,'reduce_times')
self.feedTime=baseCfg[speedUpMode.eFree][1]
end

function UISpeedUpUseWin:onItemCLick(num,index)
if self.currSelect then
local widget=self.scrollView:getChildScrollViewItemWidget(self.currSelect)
widget:SetChildActive(0,false)
end
self.currSelect=index
local widget=self.scrollView:getChildScrollViewItemWidget(self.currSelect)
widget:SetChildActive(0,true)

self:setDescAndCD()
end


function UISpeedUpUseWin:__delete()
_this=nil
self:unbindComponents()
end




function UISpeedUpUseWin:onShow(argtable,afterOnloaded)
self:setTimer(60,0,function()
self:refresh()
end)
self:refresh()
end


function UISpeedUpUseWin:onHide()

end

function UISpeedUpUseWin:getCDBySelect(select)
local cdtypes={buildingCDType.plan}
if select==1 then
table.insert(cdtypes,buildingCDType.liandan)
table.insert(cdtypes,buildingCDType.shangpu)
end
local cd,maxcd=buildingCDControl:countCDBytype(cdtypes)
return cd,maxcd
end

function UISpeedUpUseWin:setDescAndCD()
local tipsStr=self.currSelect==0 and'speed_up_item_use_tips_1'or'speed_up_item_use_tips_2'
local str=cfgHelper.get1(cfg_lang_get,tipsStr)
self.desc:setText(str)

local cd,maxcd=self:getCDBySelect(self.currSelect)
local cdstr=maxcd>0 and self:formatTime(maxcd)or'未生产'
self.time:setText(FMT.fmt('<color=#171311>总生产时长为：</color>{0}',cdstr))

local check=self:checkUse(self.currSelect+1)
self.applyBtn:setChildGraphicGray(not check,true)
if maxcd>0 and cd==0 then
self.applyText:setText("免费加速")
else
self.applyText:setText("一键加速")
end
end

function UISpeedUpUseWin:refresh()
local select=1
if not self.currSelect then
if not self:checkUse(1)and self:checkUse(2)then
select=2
end
else
select=self.currSelect+1
end

local len=#self.speedUpItems
self.scrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local itemId=self.speedUpItems[i]
item:SetChildActive(0,select==i)
widgetHelper.setNormalRewardItem(item,1,{itemId,0})
local name=itemsConfig.getColorName(itemId)
item:SetChildText(2,name)
local have=bagModel.getItemCountById(itemId)
local cd,maxcd=self:getCDBySelect(i-1)
local need=self:getNeedBySelect(i-1)
local enough=have>=need and(i==1 or cd>0)
local color=enough and'#549327'or'#c82c2c'
item:SetChildText(3,FMT.fmt('<color={2}>({0}/{1})</color>',have,need,color))
item:SetChildGraphicGray(1,not enough,true)
end

self:onItemCLick(0,select-1)
end

function UISpeedUpUseWin:getNeedBySelect(select)
if select==0 then
local itemId=self.speedUpItems[select+1]
local cfg=cfgHelper.get1(cfg_monijybasicconfig_get,1)
local spdata=cfg.reduce_times[2][itemId]
local datas=buildingCDControl:getCDTypeDatas(buildingCDType.plan)
local need=0
for k,v in pairs(datas)do
local count=v.cd>self.feedTime and math.ceil(v.cd/spdata[2])*spdata[1]or 0
need=count+need
end
return math.max(need,0)
else
return 1
end
end

function UISpeedUpUseWin:formatTime(time)
if time<60 then
return'1分'
end
local h=math.floor(time/3600)
local m=math.floor((time%3600)/60)
if h>0 then
return string.format('%s时%s分',h,m)
else
return string.format('%s分',m)
end
end

function UISpeedUpUseWin:checkUse(stype)
local cd,maxcd=self:getCDBySelect(stype-1)
if maxcd<=0 then
return false
end

local itemId=self.speedUpItems[stype]
local have=bagModel.getItemCountById(itemId)
local need=self:getNeedBySelect(stype-1)
return have>=need
end



function UISpeedUpUseWin:onApplyBtn()
if self.currSelect then
local cd,maxcd=self:getCDBySelect(self.currSelect)
if maxcd>0 then
local itemId=self.speedUpItems[self.currSelect+1]
local have=bagModel.getItemCountById(itemId)
if self.currSelect==0 then
local cfg=cfgHelper.get1(cfg_monijybasicconfig_get,1)
local spdata=cfg.reduce_times[2][itemId]
local datas=buildingCDControl:getCDTypeDatas(buildingCDType.plan)
local sendData={}
local sendFreeData={}
local need=0
for k,v in pairs(datas)do
local count=math.ceil(v.cd/spdata[2])*spdata[1]
if count>0 then
if v.cd<=self.feedTime then
table.insert(sendFreeData,{k,count,itemId or 0})
else
need=count+need
table.insert(sendData,{k,count,itemId or 0})
end
end
end
if cd==0 then
zongmenControl:reqSpeedup(speedUpMode.eFree,0,0,speedUpType.eExecutePlant,mapIdType.zhufeng,0,sendFreeData)
self:onCloseClick()
elseif have>=need then
self:handleSpeedUp(self.currSelect,itemId,need,sendData,sendFreeData)
else
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
end
else
local need=1
if cd==0 then
UIManager.error('建筑生产时间低于5分钟，不需要使用五方加速符')
elseif have>=need then
self:handleSpeedUp(self.currSelect,itemId,need)
else
UIManager.error(FMT.fmt('{0}不足',itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
end
end

else
UIManager.error('无生产中建筑')
end
else
UIManager.error('请选择使用的加速道具')
end
end

function UISpeedUpUseWin:handleSpeedUp(select,itemId,count,sendData,sendFreeData)
local callback=function()
if _this==nil then return end
if select==0 then
zongmenControl:reqSpeedup(speedUpMode.eItem,0,itemId,speedUpType.eExecutePlant,mapIdType.zhufeng,0,sendData)
else
bagProtocolControl.req_use_item(itemId,count)
end
if sendFreeData and#sendFreeData>0 then
zongmenControl:reqSpeedup(speedUpMode.eFree,0,0,speedUpType.eExecutePlant,mapIdType.zhufeng,0,sendFreeData)
end
_this:onCloseClick()
end
local dialog=UIDialogManager.getConfirmDialogEx(nil,{
content='使用以下加速仙符一键完成所有生产？',
itemList={{itemId,count}},
okcb=callback,
canvasIndex=8,
})
dialog:show()
end

function UISpeedUpUseWin:onCloseClick()
self:closeSelf()
end