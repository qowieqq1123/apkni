







def_class("UIZhenJiFixWin",UIWindowBase)









function UIZhenJiFixWin:bindComponents()

self.got=UIObject.get(self,0)
self.progressbar=UIProgress.get(self,1)
self.model=UIObject.get(self,2)
self.fixRoot=UIObject.get(self,3)
self.rewardItemList=UIObject.get(self,4)
self.closeButton=UIButton.get(self,5)
self.fixed=UIObject.get(self,6)
self.progress_1=UIObject.get(self,7)
self.progress_2=UIObject.get(self,8)
self.progress_3=UIObject.get(self,9)
self.progress_4=UIObject.get(self,10)
self.progress_5=UIObject.get(self,11)
self.cailiaoItemList=UIObject.get(self,12)
self.fixButton=UIButton.get(self,13)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIZhenJiFixWin")end)

self.fixButton:setButtonClick(function()self:onFixButton()end)
self.progress={
self.progress_1,
self.progress_2,
self.progress_3,
self.progress_4,
self.progress_5,
}



end


function UIZhenJiFixWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.got);self.got=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.fixRoot);self.fixRoot=nil;
_UIObject_release(self.rewardItemList);self.rewardItemList=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.fixed);self.fixed=nil;
_UIObject_release(self.progress_1);self.progress_1=nil;
_UIObject_release(self.progress_2);self.progress_2=nil;
_UIObject_release(self.progress_3);self.progress_3=nil;
_UIObject_release(self.progress_4);self.progress_4=nil;
_UIObject_release(self.progress_5);self.progress_5=nil;
_UIObject_release(self.cailiaoItemList);self.cailiaoItemList=nil;
_UIObject_release(self.fixButton);self.fixButton=nil;
self.progress=nil;
end



















function UIZhenJiFixWin:onLoaded(...)
self:bindComponents()

self:addNotify(notifyConfig.onShowPrize,function(prizeType)
if prizeType==ePrizeType.eCommon then
self:refreshCaiLiao()
end
end)
end


function UIZhenJiFixWin:__delete()
self:unbindComponents()
end





function UIZhenJiFixWin:onShow(argtable,afterOnloaded)
self.actid=argtable.act_id
self.subType=SUB_ACTIVITY_TYPE.eLongHuHuiJuan
self.subid=argtable.sub_act_id

self.zhenjiId=argtable.zhenjiId
self.plotId=argtable.plotId

self.info=activitiesModel:getSubActInfo(self.actid,self.subType,self.subid)

self.zhenJiEventCfg=cfgHelper.get(cfg_longhuhuijuaneventconfig_get,self.zhenjiId)


self:refresh()
end


function UIZhenJiFixWin:onHide()

end

function UIZhenJiFixWin:refresh()

local repair=self.zhenJiEventCfg.repair
local length=#repair

local idx=self.info:getRepairEventProgress(self.zhenjiId)

for i,v in ipairs(self.progress)do
if idx<i then
v:setActive(false)
else
v:setActive(true)
end
end
self.progressbar:setProgress(idx,length)

local isMax=false
local nextCfg=repair[idx+1]
if not nextCfg then
nextCfg=repair[idx]
isMax=true
end
self.isMax=isMax
local model=self.zhenJiEventCfg.model[idx+1]
if not model then
model=self.zhenJiEventCfg.model[#self.zhenJiEventCfg.model]
end
self.model:setChildUIModelShowTarget(model[1],model[2],{},eAnimationID.stand,false,false,0.6)
local num=#nextCfg[2]
self.rewardItemList:setChildLayoutGroupCreateItems(num)
local grids=self.rewardItemList:getChildLayoutGroupGridList()
for i=1,num do
local grid=grids[i-1]
local item={itemid=nextCfg[2][i][1]}
local config={itemcount=nextCfg[2][i][2],showname=false,gray=isMax and 1 or nil}
local porp=itemsComponentHelper.getCommonFillData(item,config)

grid:SetChildPropData(-1,porp)
grid:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)
end
self.got:setActive(isMax)
local num=#nextCfg[1]
self.fixed:setActive(isMax)
self.fixRoot:setActive(not isMax)
self.cailiaoItemList:setChildLayoutGroupCreateItems(num)
local showMoney={}
local grids=self.cailiaoItemList:getChildLayoutGroupGridList()
for i=1,num do
local grid=grids[i-1]
local item={itemid=nextCfg[1][i][1]}
local have=itemsModel.getCount(item.itemid)
local isMoney=itemsConfig.isMoney(item.itemid)
local itemcount
if isMoney then
itemcount=have<nextCfg[1][i][2]and FMT.cfmt(FONT_COLOR.eRedColor,mathHelper.formatNumber(nextCfg[1][i][2]))or mathHelper.formatNumber(nextCfg[1][i][2])
else
itemcount=have<nextCfg[1][i][2]and FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",mathHelper.formatNumber(have),mathHelper.formatNumber(nextCfg[1][i][2]))or FMT.fmt("{0}/{1}",mathHelper.formatNumber(have),mathHelper.formatNumber(nextCfg[1][i][2]))
end
local config={itemcount=itemcount,showname=false}
local porp=itemsComponentHelper.getCommonFillData(item,config)



grid:SetChildPropData(-1,porp)
grid:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)

table.insert(showMoney,{item.itemid})
end
self.cailiaoList=nextCfg[1]
self.fixButton:setActive(not isMax)


self.showMoney=#showMoney>0
if self.showMoney then
self:showWindow('UITopMoneyWin',showMoney)
else
self:hideWindow('UITopMoneyWin')
end
end

function UIZhenJiFixWin:refreshCaiLiao()
if self.cailiaoList and not self.isMax then
local caiLiaoList=self.cailiaoList
local grids=self.cailiaoItemList:getChildLayoutGroupGridList()
for i=1,#caiLiaoList do
local grid=grids[i-1]
local item={itemid=caiLiaoList[i][1]}
local have=itemsModel.getCount(item.itemid)
local isMoney=itemsConfig.isMoney(item.itemid)
local itemcount
if isMoney then
itemcount=have<caiLiaoList[i][2]and FMT.cfmt(FONT_COLOR.eRedColor,mathHelper.formatNumber(caiLiaoList[i][2]))or mathHelper.formatNumber(caiLiaoList[i][2])
else
itemcount=have<caiLiaoList[i][2]and FMT.cfmt(FONT_COLOR.eRedColor,"{0}/{1}",mathHelper.formatNumber(have),mathHelper.formatNumber(caiLiaoList[i][2]))or FMT.fmt("{0}/{1}",mathHelper.formatNumber(have),mathHelper.formatNumber(caiLiaoList[i][2]))
end
local config={itemcount=itemcount,showname=false}
local porp=itemsComponentHelper.getCommonFillData(item,config)


grid:SetChildPropData(-1,porp)
grid:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClick)
end
end
end





function UIZhenJiFixWin:onFixButton()
if not self.cailiaoList then
return
end
local need=self.cailiaoList
for i,v in ipairs(need)do
local count=itemsModel.getCount(v[1])
if count<v[2]then
local name=itemsConfig.getItemName(v[1])
local err=FMT.fmt('{0}不足',name)
UIManager.error(err)
gainControl:showGainWin(v[1])
return
end
end

activitiesHandle_longhuhuijuan.req_fix_zhenji(self.actid,self.subid,self.plotId,self.zhenjiId)
end

