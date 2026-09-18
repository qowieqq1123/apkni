







def_class("UISystemZongMenKuFangWin",UIWindowBase)









function UISystemZongMenKuFangWin:bindComponents()

self.icon=UIImage.get(self,0)
self.moneyGrid=UIObject.get(self,1)
self.ScrollView=UIScrollViewSlow.get(self,2)
self.back=UIButton.get(self,3)

self.back:setButtonClick(function()self:onBack()end)



end


function UISystemZongMenKuFangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.moneyGrid);self.moneyGrid=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.back);self.back=nil;
end
















local _this=nil
local _col=5
local _cmpItemWidgetIdx=
{
cmpQuality=0,
cmpIcon=1,
cmpCountTxt=2,
cmpLock=3,
cmpStageTxt=4,
cmpSelect=5,
cmpBg=6,
cmpStageBg=7,
cmpNewFlag=8,
cmpCountBg=9,
cmpFabaoTag=10,
cmpReddot=11,
}
local _moneyCfg={
1,2,5,4,6,9,10,8
}




function UISystemZongMenKuFangWin:onLoaded(...)
self:bindComponents()
_this=self
self.ScrollView:setSlowClickAction(function(...)self:onScrollItemClick(...)end)
self.ScrollView:bindSlowWidget(function(...)self:bindGrid(...)end)
notifySystem:listenNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
self.isSetZero=false
end


function UISystemZongMenKuFangWin:__delete()
self:unbindComponents()
_this=nil
tipsManager.closeTips()
notifySystem:removelistener(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
end




function UISystemZongMenKuFangWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
self.infoData=systemZongMenModel:getInfoData(self.serial)
if systemZongMenModel:checkDetailPartInfo(self.serial,systemZongMenDetailDataPart.eBag)then
self.detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eBag)
self:combineItemList()
self:refreshView()
end

if self.selectIdx then
local item=self.ScrollView:getSlowItemByIndex(self.selectIdx-1)
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,false)
end
end


function UISystemZongMenKuFangWin:onHide()
tipsManager.closeTips()
end



function UISystemZongMenKuFangWin:refreshView()
self:refreshMoneys()
self:refreshItems()
end

function UISystemZongMenKuFangWin:refreshItems()
local tNum=math.max(#self.itemList,30)
local row=math.ceil(tNum/_col)
self.ScrollView:freshSlowGrids(tNum,row,_col,not self.isSetZero)

end

function UISystemZongMenKuFangWin:refreshMoneys()
local gridCmp=self.moneyGrid:getID()
self.winlua:SetChildLayoutGroupCreateItems(gridCmp,#_moneyCfg,function(idx)
local item=self.winlua:GetChildLayoutGroupGridItem(gridCmp,idx-1)
local mId=_moneyCfg[idx]
item:SetChildIcon(0,iconHelper.getIconName(mId),false)
local count="————"
if self.detailInfo then
count=0
if self.detailInfo.money_num>0 then
for i,v in ipairs(self.detailInfo.moneyList)do
if v.param_1==mId then
count=v.param_2
break
end
end
end
end
item:SetChildText(1,FMT.fmt("{0}:{1}",itemsConfig.getItemName(mId),count))
end)
end

function UISystemZongMenKuFangWin:onEdgeEvent()
self:refreshItems()
end

function UISystemZongMenKuFangWin:bindGrid(index,item)
local itemInfo=self.itemList[index]

local isTemp=itemInfo==nil
if not isTemp then




















local itemid=itemInfo.item
local count=itemInfo.num
local lock=itemInfo.lock

local color=itemInfo.color
local stage=itemInfo.stage>0 and itemInfo.stage or nil
local iconName=iconHelper.getIconName(itemid)
local txt=count>1 and count or''
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=stage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local hasStage=stageStr~=''
local isFabao=itemsConfig.isFabao(itemid)

local isSelect=false
local newFlag=false
local reddot=false





widgetHelper.setItemQulaity(item,itemid,_cmpItemWidgetIdx.cmpQuality)
item:SetChildIcon(_cmpItemWidgetIdx.cmpIcon,iconName,false)
item:SetChildText(_cmpItemWidgetIdx.cmpCountTxt,txt)
item:SetChildActive(_cmpItemWidgetIdx.cmpStageBg,hasStage)
item:SetChildText(_cmpItemWidgetIdx.cmpStageTxt,stageStr)
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,isSelect)
item:SetChildActive(_cmpItemWidgetIdx.cmpBg,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpLock,lock)
item:SetChildActive(_cmpItemWidgetIdx.cmpNewFlag,newFlag)
item:SetChildActive(_cmpItemWidgetIdx.cmpCountBg,txt~='')
item:SetChildActive(_cmpItemWidgetIdx.cmpFabaoTag,isFabao)
item:SetChildActive(_cmpItemWidgetIdx.cmpReddot,reddot)
item:SetBaseItemChildID(-1,itemid)

else
item:SetChildActive(_cmpItemWidgetIdx.cmpQuality,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpIcon,false)
item:SetChildText(_cmpItemWidgetIdx.cmpCountTxt,'')
item:SetChildActive(_cmpItemWidgetIdx.cmpCountBg,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpStageBg,false)
item:SetChildText(_cmpItemWidgetIdx.cmpStageTxt,'')
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpBg,true)
item:SetChildActive(_cmpItemWidgetIdx.cmpLock,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpNewFlag,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpFabaoTag,false)
item:SetChildActive(_cmpItemWidgetIdx.cmpReddot,false)
item:SetBaseItemChildID(-1,-1)

end
end

function UISystemZongMenKuFangWin:onScrollItemClick(id,index,guid,attach)


if self.selectIdx then
local item=self.ScrollView:getSlowItemByIndex(self.selectIdx-1)
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,false)
end
self.selectIdx=index
local item=self.ScrollView:getSlowItemByIndex(self.selectIdx-1)
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,true)

tipsManager.showTips({
formType=TIPS_FORM_TYPE.eNone,
itemid=id,
backType=TIPS_BACK_TYPE.eNone,
itemguid=guid,
move=TIPS_MOVE_POS.eLeft,

})
end

function UISystemZongMenKuFangWin.onSystemZMDetailInfo(partType,serial)
if _this.serial==serial and partType==systemZongMenDetailDataPart.eBag then
_this.detailInfo=systemZongMenModel:getDetailPartInfo(_this.serial,systemZongMenDetailDataPart.eBag)
_this:combineItemList()
_this:refreshView()
end
end

function UISystemZongMenKuFangWin:onBack()
tipsManager.closeTips()
if self.selectIdx then
local item=self.ScrollView:getSlowItemByIndex(self.selectIdx-1)
item:SetChildActive(_cmpItemWidgetIdx.cmpSelect,false)
end
self.selectIdx=nil
end

function UISystemZongMenKuFangWin:combineItemList()
self.itemList={}
self.tempList={}
for i,v in ipairs(self.detailInfo.itemList or{})do
local itemId=v.param_1
local itemNum=v.param_2
local lock=v.param_3==1
local index=itemId*(lock and 1 or-1)
if not self.tempList[index]then
local cfg=itemsConfig.getConfig(itemId)
local data={
item=itemId,
num=itemNum,
lock=lock,
dup=cfg.dup,
}
self.tempList[index]=data
else
local data=self.tempList[index]
data.num=data.num+itemNum
end
end
for i,v in pairs(self.tempList)do
local count=math.ceil(v.num/v.dup)
local lastNum=v.num%v.dup
for j=1,count do
local num=v.dup
if lastNum>0 and j==count then
num=lastNum
end
local cfg=itemsConfig.getConfig(v.item)
local data={
item=v.item,
num=v.num,
lock=v.lock,
color=cfg.color,
stage=cfg.stage or 0,
}
table.insert(self.itemList,data)
end
end
table.sort(self.itemList,self.sortItemList)
end

function UISystemZongMenKuFangWin.sortItemList(a,b)
if a.color~=b.color then
return a.color>b.color
elseif a.stage~=b.stage then
return a.stage>b.stage
elseif a.item~=b.item then
return a.item>b.item
else
return a.lock
end
end