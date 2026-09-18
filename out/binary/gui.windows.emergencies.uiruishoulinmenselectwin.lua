







def_class("UIRuiShouLinMenSelectWin",UIWindowBase)









function UIRuiShouLinMenSelectWin:bindComponents()

self.background=UIButton.get(self,0)
self.feedBtn=UIButton.get(self,1)
self.autoBtn=UIButton.get(self,2)
self.tipsTx=UIText.get(self,3)
self.ScrollView=UIScrollViewSlow.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)

self.feedBtn:setButtonClick(function()self:onFeedBtn()end)

self.autoBtn:setButtonClick(function()self:onAutoBtn()end)



end


function UIRuiShouLinMenSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.feedBtn);self.feedBtn=nil;
_UIObject_release(self.autoBtn);self.autoBtn=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end
















local _this=nil
local _col=5
local _row=6
local _pageNum=_col*_row
local _itemConf={
showname=false,
showcount=false,
showStageBg=true,
color="",
}
local _itemCmp={
UIBaseItem=0,
deleteFlag=1,
countBg=2,
countTx=3
}



function UIRuiShouLinMenSelectWin:onLoaded(...)
self:bindComponents()
_this=self
self.ScrollView:setSlowClickAction(function(...)self:onAddItemSelect(...)end)
self.ScrollView:setItemsBtnAction(1,function(...)self:onDelItemSelect(...)end)
self.ScrollView:bindSlowWidget(function(...)self:bindGrid(...)end)
self.ScrollView:setSlowLongClickAction(function(...)self:onLongTouchItem(...)end)
self.selectList={}
self.changeValue=0
end


function UIRuiShouLinMenSelectWin:__delete()
self:unbindComponents()
_this=nil
end




function UIRuiShouLinMenSelectWin:onShow(argtable,afterOnloaded)
self.eventId=argtable.event
self.variation=argtable.variation
self.changeEvent=argtable.change
self.closeEvent=argtable.close
self.eventCfg=cfgHelper.get1(cfg_tufaeventtypeconfig_get,self.eventId)
self:updateData()
self:resetViewList()
end


function UIRuiShouLinMenSelectWin:onHide()

end




function UIRuiShouLinMenSelectWin:onBackground()
if self.closeEvent then
self.closeEvent()
end

emergenciesModel:showRSLMBoxesEffect(self.eventId)
UIFullRuiShouLinMenControl:closeUI(true)
end


function UIRuiShouLinMenSelectWin:Feedrefresh()
self.selectList={}
self.changeValue=0
self.priority=nil
self.delta=nil
self:updateData()
self:resetViewList()
end


function UIRuiShouLinMenSelectWin:onFeedBtn()
if next(self.selectList)then
local list={}
for key,num in pairs(self.selectList)do
if num>0 then
for index,data in ipairs(self.itemList)do
if tostring(data.itemguid)==key then
table.insert(list,{data.itemid,num})
break
end
end
end
end

emergenciesControl:reqFeedRuiShou(list)


else
UIManager.error('请选择喂养材料')
end
end


function UIRuiShouLinMenSelectWin:onAutoBtn()
if self.changeValue<self.variation then
local list={}
for index,data in ipairs(self.itemList)do
if self.changeValue>=self.variation then
break
end
local max=data.itemcount
local guidStr=tostring(data.itemguid)
local cur=self.selectList[guidStr]or 0
local least=max-cur
if least>0 then
local c=0
local d=self.delta[data.itemid]
for i=1,least do
c=i
if(self.changeValue+i*d)>=self.variation then
break
end
end
self.changeValue=self.changeValue+d*c
self.selectList[guidStr]=cur+c
if c>0 then
table.insert(list,index)
end
end
end
for i,v in ipairs(list)do
local item=self.ScrollView:getSlowItemByIndex(v-1)
local data=self.itemList[v]
local max=data.itemcount
local cur=self.selectList[tostring(data.itemguid)]
item:SetChildActive(_itemCmp.deleteFlag,true)

local countStr=FMT.fmt("{0}/{1}",cur,max)
item:SetChildActive(_itemCmp.deleteFlag,true)
item:SetChildActive(_itemCmp.countBg,true)
item:SetChildText(_itemCmp.countTx,countStr)
end

if self.changeEvent then
self.changeEvent(self.changeValue)
end
end
end

function UIRuiShouLinMenSelectWin:onAddItemSelect(itemid,index,itemguid,attach)

if itemguid==nil then return end
local cur=self.selectList[tostring(itemguid)]or 0
if cur<=0 and self.changeValue>=self.variation then
return UIManager.info("已达饱食度上限")
end
local itemData=self.itemList[index]
if itemData==nil then
return
end
local max=itemData.itemcount
local temp=cur+math.ceil((self.variation-self.changeValue)/self.delta[itemid])
local smax=math.min(max,temp)
local attach_={}
local old=cur
local commit=false
local onSelect=function(num)
local cur=self.selectList[tostring(itemguid)]or 0
local delta=num-cur
self.selectList[tostring(itemguid)]=num>0 and num or nil
self.changeValue=self.changeValue+self.delta[itemid]*delta

local item=self.ScrollView:getSlowItemByIndex(index-1)
item:SetChildActive(_itemCmp.deleteFlag,num>0)

local countStr=nil
if num>0 then
countStr=FMT.fmt("{0}/{1}",num,max)
else
if max>1 then
countStr=max
end
end
item:SetChildText(_itemCmp.countTx,countStr or"")
item:SetChildActive(_itemCmp.countBg,countStr~=nil)

if self.changeEvent then
self.changeEvent(self.changeValue)
end
end

local selectNumCmpArgs={numFormat='数量：<color=#f1ce78>{0}/{1}</color>',min=1,max=smax,val=cur,isOverZero=true}
selectNumCmpArgs.onSelectValue=onSelect
attach_.selectNumCmpArgs=selectNumCmpArgs
attach_.tipsCommonUseItemCB=function(attach__)
commit=true
end
attach_.insertBtnList={TIPS_BTNS_TYPE.eCommonUseItem}
local closeCallback=function()
if not commit then
onSelect(old)
end
end
tipsManager.showTips({itemid=itemid,itemguid=itemguid,attach=attach_,closeCallback=closeCallback})




































end

function UIRuiShouLinMenSelectWin:onDelItemSelect(itemid,index,itemguid,attach)
if itemguid==nil then return end
local cur=self.selectList[tostring(itemguid)]or 0
if cur>0 then
cur=cur-1
self.selectList[tostring(itemguid)]=cur>0 and cur or nil
self.changeValue=self.changeValue-self.delta[itemid]

local item=self.ScrollView:getSlowItemByIndex(index-1)
local showFlag=cur>0
item:SetChildActive(_itemCmp.deleteFlag,showFlag)

local itemData=self.itemList[index]
local max=itemData.itemcount
local countStr=FMT.fmt("{0}/{1}",cur,max)
if not showFlag then
countStr=max>1 and tostring(max)or""
end
item:SetChildText(_itemCmp.countTx,countStr)
item:SetChildActive(_itemCmp.countBg,max>1)

if self.changeEvent then
self.changeEvent(self.changeValue)
end
end
end

function UIRuiShouLinMenSelectWin:updateData()
if self.priority==nil then
self.priority=self.eventCfg.event_conf.priority




end
if self.delta==nil then
self.delta={}
for i,v in ipairs(self.eventCfg.event_conf.feed)do
self.delta[v[1]]=v[2]
end
end
self.itemList={}
self.temp1={}
self.temp2={}
for i,v in ipairs(self.eventCfg.event_conf.feed)do
local itemId=v[1]
local priority=self.priority[itemId]
local itemData=bagControl.invokeFuncByItemId(itemId,'getAllItemByItemID',itemId)
for j,w in ipairs(itemData)do
table.insert(priority and self.temp1 or self.temp2,w)
end
end
table.sort(self.temp1,self.sorItemList)
table.sort(self.temp2,self.sorItemList)
for i,v in ipairs(self.temp1)do
table.insert(self.itemList,v)
end
for i,v in ipairs(self.temp2)do
table.insert(self.itemList,v)
end
self.pageCnt=math.ceil(#self.itemList/_pageNum)
end

function UIRuiShouLinMenSelectWin.sorItemList(a,b)
local aCfg=itemsConfig.getConfig(a.itemid)
local bCfg=itemsConfig.getConfig(b.itemid)
if aCfg.color~=bCfg.color then
return aCfg.color<bCfg.color
else
return a.itemid<b.itemid
end
end

function UIRuiShouLinMenSelectWin:bindGrid(index,item)
local data=self.itemList[index]
local dataProp=itemsComponentHelper.getCommonFillData(data,_itemConf)
if data==nil then
dataProp[PropIndex(DataPropKey.eWidgetQualityEx,2)]=nil
end
item:SetChildPropData(0,dataProp)
if data then
local selectNum=self.selectList[tostring(data.itemguid)]or 0
local isSelected=selectNum>0
local countStr=data.itemcount>1 and data.itemcount or""
if isSelected then
countStr=FMT.fmt("{0}/{1}",selectNum,data.itemcount)
end
item:SetChildActive(_itemCmp.deleteFlag,isSelected)
item:SetChildActive(_itemCmp.countBg,isSelected or(data.itemcount>1))
item:SetChildText(_itemCmp.countTx,countStr)
item:SetBaseItemChildID(-1,data.itemid)
item:SetBaseItemChildGUID(-1,data.itemguid)
else
item:SetChildActive(_itemCmp.deleteFlag,false)
item:SetChildActive(_itemCmp.countBg,false)
item:SetChildText(_itemCmp.countTx,"")
item:SetBaseItemChildID(-1,-1)
item:SetBaseItemChildGUID(-1,-1)
end
end

function UIRuiShouLinMenSelectWin:onEdgeEvent()
if self.currentPage>=self.pageCnt then return end
self.currentPage=self.currentPage+1
self:refreshViewList(false)
end

function UIRuiShouLinMenSelectWin:resetViewList()
self.currentPage=1
self.ScrollView:clearSlowItems()
self:refreshViewList(true)
end

function UIRuiShouLinMenSelectWin:refreshViewList(notSetZero)
local showNum=self.currentPage*_pageNum
local showRow=showNum/_col
self.ScrollView:freshSlowGrids(showNum,showRow,_col,notSetZero)
end

function UIRuiShouLinMenSelectWin:onLongTouchItem(id,index,guid,attach)
itemsComponentHelper.onItemClickEx(id,index,guid,attach)
end