







def_class("UIYFLZCombineWin",UIWindowBase)









function UIYFLZCombineWin:bindComponents()

self.label=UIText.get(self,0)
self.cost=UIText.get(self,1)
self.combinText=UIText.get(self,2)
self.materials_2=UIObject.get(self,3)
self.materials_3=UIObject.get(self,4)
self.materials_1=UIObject.get(self,5)
self.pageScrollView=UIObject.get(self,6)
self.comboBox=UIObject.get(self,7)
self.filter=UIButton.get(self,8)
self.reverseBtn=UIButton.get(self,9)
self.bagScrollView=UIObject.get(self,10)
self.count=UIText.get(self,11)
self.product=UIObject.get(self,12)
self.levelAttr1=UIObject.get(self,13)
self.levelAttr2=UIObject.get(self,14)
self.costInfo=UIObject.get(self,15)
self.combinBtn=UIButton.get(self,16)
self.chongZhuBtn=UIButton.get(self,17)
self.costIcon=UIObject.get(self,18)
self.batchCombinBtn=UIButton.get(self,19)
self.selectCntSlider=UIObject.get(self,20)
self.selectCntText=UIText.get(self,21)
self.sliderClickMask=UIObject.get(self,22)
self.subBtn=UIButton.get(self,23)
self.addBtn=UIButton.get(self,24)
self.sliderPanel=UIObject.get(self,25)

self.filter:setButtonClick(function()self:onFilter()end)

self.reverseBtn:setButtonClick(function()self:onReverseBtn()end)

self.combinBtn:setButtonClick(function()self:onCombinBtn()end)

self.chongZhuBtn:setButtonClick(function()self:onChongZhuBtn()end)

self.batchCombinBtn:setButtonClick(function()self:onBatchCombinBtn()end)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)
self.materials={
self.materials_1,
self.materials_2,
self.materials_3,
}



end


function UIYFLZCombineWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.label);self.label=nil;
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.combinText);self.combinText=nil;
_UIObject_release(self.materials_2);self.materials_2=nil;
_UIObject_release(self.materials_3);self.materials_3=nil;
_UIObject_release(self.materials_1);self.materials_1=nil;
_UIObject_release(self.pageScrollView);self.pageScrollView=nil;
_UIObject_release(self.comboBox);self.comboBox=nil;
_UIObject_release(self.filter);self.filter=nil;
_UIObject_release(self.reverseBtn);self.reverseBtn=nil;
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.count);self.count=nil;
_UIObject_release(self.product);self.product=nil;
_UIObject_release(self.levelAttr1);self.levelAttr1=nil;
_UIObject_release(self.levelAttr2);self.levelAttr2=nil;
_UIObject_release(self.costInfo);self.costInfo=nil;
_UIObject_release(self.combinBtn);self.combinBtn=nil;
_UIObject_release(self.chongZhuBtn);self.chongZhuBtn=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.batchCombinBtn);self.batchCombinBtn=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
_UIObject_release(self.sliderClickMask);self.sliderClickMask=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.sliderPanel);self.sliderPanel=nil;
self.materials=nil;
end















local _tmpList={}




function UIYFLZCombineWin:onLoaded(...)
self:bindComponents()

self.pageNames={'全部','金','木','水','火','土','五行',spe=7}
self.currMaterials={}
self.combineDatas={}



self.pageScrollView:setChildScrollViewInit(0.5,true,function(...)self:onPageClick(...)end,nil)
self.bagScrollView:setChildScrollViewInit(0.5,true,function(...)self:onItemClick(...)end,nil)


end

function UIYFLZCombineWin:onComboxChange(index)
local filter
if index~=0 then
filter={[index]=true}
end
self:setFilter(filter)
end

function UIYFLZCombineWin:onPageClick(num,index)
if self.pageIndex then
local widget=self.pageScrollView:getChildScrollViewItemWidget(self.pageIndex)
if self.pageNames.spe==self.pageIndex+1 then
widget:SetChildActive(3,false)
else
widget:SetChildActive(0,false)
end
end
self.pageIndex=index
local widget=self.pageScrollView:getChildScrollViewItemWidget(self.pageIndex)
if self.pageNames.spe==index+1 then
widget:SetChildActive(3,true)
else
widget:SetChildActive(0,true)
end


self:showBagList()
end

function UIYFLZCombineWin:onItemClick(num,index)
self:showTips(index)
end


function UIYFLZCombineWin:__delete()
self:unbindComponents()
end




function UIYFLZCombineWin:onShow(argtable,afterOnloaded)
if argtable then
self.yfGuid=argtable.itemGuid or int64.zero
self.lzData=UIYuFuLingZhenControl:getLingZhenData(self.yfGuid)

else
self.yfGuid=int64.zero
end
local moneyBar=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"moneyBar")
if moneyBar then
self:showWindow('UITopMoneyWin2',moneyBar)
end

local cfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"openLevel")

self.maxLevel=cfg or 15





self:showPage()
self:refresh()

if argtable and argtable.putInItem then
self:putInItem(argtable.putInItem[1],argtable.putInItem[2],argtable.putInItem[3])
end

self:refreshSelectCntSlider(true)
end


function UIYFLZCombineWin:onHide()

end

function UIYFLZCombineWin:refresh()
self:onPageClick(0,self.pageIndex or 0)
self:clearCombinePanel()
end

function UIYFLZCombineWin:clearCombinePanel()
for i,v in ipairs(self.materials)do
local widget=v:getWidgetBase()
widget:SetChildActive(0,false)
widget:SetChildText(2,'')
widget:SetChildActive(3,false)
widget:SetChildActive(1,true)
widget:SetChildActive(7,false)
widget:SetChildActive(8,false)
end
local widget=self.product:getWidgetBase()
widget:SetChildActive(0,false)

local widgetAttrL=self.levelAttr1:getWidgetBase()
widgetAttrL:SetChildText(0,'??级')
widgetAttrL:SetChildText(1,'')
widgetAttrL:SetChildText(2,'')
widgetAttrL:SetChildText(3,'暂无信息')
widgetAttrL:SetChildActive(4,false)
widgetAttrL:SetChildText(5,'')

local widgetAttrR=self.levelAttr2:getWidgetBase()
widgetAttrR:SetChildText(0,'??级')
widgetAttrR:SetChildText(1,'')
widgetAttrR:SetChildText(2,'')
widgetAttrR:SetChildText(3,'暂无信息')
widgetAttrR:SetChildActive(4,false)
widgetAttrR:SetChildText(5,'')

self.cost:setActive(false)

self.combinBtn:setGray(true)
self.combinText:setText("请放入灵阵")

self:showCost(false)
self.combineDatas={}
self.check1=nil
self.haveMat=nil
self.isPutIn=nil
self.maxCombineCnt=nil
self.selectCnt=nil
self.costMoney=nil
self.selectItemList=nil
self:refreshSelectCntSlider(true)
end

function UIYFLZCombineWin:showPage()
local len=#self.pageNames
self.pageScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.pageScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildActive(0,false)
item:SetChildText(1,self.pageNames[i])
item:SetChildActive(2,self.pageNames.spe==i)
end
end

function UIYFLZCombineWin:setFilter(datas,levelSelect)
self.filterData=datas
self.levelSelect=levelSelect
if levelSelect>self.maxLevel then
self.label:setText('灵阵筛选')
else
self.label:setText(FMT.fmt("{0}级",levelSelect))
end
self:showBagList()
end

function UIYFLZCombineWin:checkFilter(level)
if self.filterData then
return self.filterData[level]==true
end
return true
end

function UIYFLZCombineWin:getPageDatas()
local items=lingzhenBagModel:getBagItems()
local index=self.pageIndex
local list={}
for i,v in ipairs(items)do
local cfg=itemsConfig.getConfig(v.itemid)
if(index==0 or index==cfg.type1)and self:checkFilter(cfg.level)then
table.insert(list,{type=cfg.type1,level=cfg.level,data=v})
end
end






















table.sort(list,function(a,b)
if a.level>b.level then
if self.sortFlag then
return false
else
return true
end
elseif a.level==b.level then
return a.type<b.type
else
if self.sortFlag then
return true
else
return false
end
end
end)

return list
end

function UIYFLZCombineWin:showBagList()
local stypes
if self.pageIndex==0 then
stypes={1,2,3,4,5,6}
else
stypes={self.pageIndex}
end
self.datas=self:getPageDatas(stypes)
self.count:setText(FMT.fmt("灵阵背包：{0}/200",#self.datas))
local len=200
self.bagScrollView:setChildScrollViewStopGridCreate()

self.bagScrollView:setChildScrollViewCreateGrids(0,0)
self.bagScrollView:setChildScrollViewDelayCreateGrids(len,4,0.02,35,false,false,function(index,item)
local lzdata=self.datas[index+1]
if lzdata then
local data=lzdata.data








local cfg=itemsConfig.getConfig(data.itemid)
local color=UIYuFuLingZhenControl:getItemColorById(data.itemid,data.itemguid,lzdata.level)
local pz=UIYuFuLingZhenControl:getPZIconName(color)
item:SetChildActive(0,true)
item:SetChildCSImageSprite(0,globalABLookup.yufulingzhen,pz)
local icon=UIYuFuLingZhenControl:getLZIconName(cfg)
item:SetChildIcon(1,icon,true)

item:SetChildText(3,lzdata.level)
local lock=UIYuFuLingZhenControl:getItemLock(data.itemguid)or false
item:SetChildActive(5,data.itemcount>1 or lock)
item:SetChildText(6,data.itemcount>1 and data.itemcount or'')
item:SetChildActive(7,lock)

else
item:SetChildActive(0,false)
end
end)
end

function UIYFLZCombineWin:showTips(index)
if not self.datas[index+1]then
return
end
local data=self.datas[index+1].data

tipsManager.showTips({formType=TIPS_FORM_TYPE.eYFLZCombine,itemid=data.itemid,itemguid=data.itemguid,move=TIPS_MOVE_POS.eRight,attach={yfguid=data.yufuGuid,kongIndex=data.kongIndex}})
end

function UIYFLZCombineWin:setMaterialA(mat,itemid,itemguid,yufuGuid,kongIndex)
local widget=mat:getWidgetBase()
widget:SetChildGray(-1,false)
local color=UIYuFuLingZhenControl:getItemColorById(itemid,itemguid)
widget:SetChildActive(0,false)
widget:SetChildActive(1,false)
local cfg=itemsConfig.getConfig(itemid)
widget:SetChildText(2,cfg.name)
widget:SetChildActive(3,true)
local pz=UIYuFuLingZhenControl:getPZIconName(color)
widget:SetChildCSImageSprite(4,globalABLookup.yufulingzhen,pz)
local icon=UIYuFuLingZhenControl:getLZIconName(cfg)
widget:SetChildIcon(5,icon,true)
widget:SetChildText(6,cfg.level)
widget:SetChildActive(7,true)
widget:SetChildButtonClick(7,function()
tipsManager.showTips({formType=TIPS_FORM_TYPE.eYFLZCombineSelected,itemid=itemid,itemguid=itemguid,move=TIPS_MOVE_POS.eRight,attach={yfguid=yufuGuid,kongIndex=kongIndex}})
end)
widget:SetChildActive(8,false)
end

function UIYFLZCombineWin:clearMaterial(mat)
local widget=mat:getWidgetBase()
widget:SetChildGray(-1,false)
widget:SetChildActive(0,false)
widget:SetChildText(2,'')
widget:SetChildActive(3,false)
widget:SetChildActive(1,true)
widget:SetChildActive(7,false)
widget:SetChildActive(8,false)
end

function UIYFLZCombineWin:lockMaterial(mat)
local widget=mat:getWidgetBase()
widget:SetChildGray(-1,false)
widget:SetChildActive(0,false)
widget:SetChildText(2,'')
widget:SetChildActive(3,false)
widget:SetChildActive(1,false)
widget:SetChildActive(7,false)
widget:SetChildActive(8,true)
end

function UIYFLZCombineWin:setMaterialB(mat,matdata)
local widget=mat:getWidgetBase()
widget:SetChildGray(-1,false)
widget:SetChildActive(0,true)
widgetHelper.setNormalRewardItem(widget,0,{matdata[1],matdata[2],checkAmount=true})
widget:SetChildActive(1,false)


widget:SetChildActive(3,false)
widget:SetChildActive(7,true)
widget:SetChildActive(8,false)
widget:SetChildText(2,"")
widget:SetChildButtonClick(7,function()
tipsManager.showTips({formType=TIPS_FORM_TYPE.eYFLZCombineSelected,itemid=matdata[1],move=TIPS_MOVE_POS.eRight})
end)

end

function UIYFLZCombineWin:setMaterialC(mat,itemid)
local widget=mat:getWidgetBase()
local color=UIYuFuLingZhenControl:getItemColorById(itemid)

widget:SetChildActive(0,false)
widget:SetChildActive(1,false)
local cfg=itemsConfig.getConfig(itemid)
widget:SetChildText(2,cfg.name)
widget:SetChildActive(3,true)
local pz=UIYuFuLingZhenControl:getPZIconName(color)
widget:SetChildCSImageSprite(4,globalABLookup.yufulingzhen,pz)
local icon=UIYuFuLingZhenControl:getLZIconName(cfg)
widget:SetChildIcon(5,icon,true)
widget:SetChildText(6,cfg.level)
widget:SetChildActive(7,true)
widget:SetChildButtonClick(7,function()
tipsManager.showTips({itemid=itemid,move=TIPS_MOVE_POS.eRight})
end)
widget:SetChildActive(8,false)

widget:SetChildGray(-1,true)
end

function UIYFLZCombineWin:getCombineMaterialItem(itemId)
local items=lingzhenBagModel:getBagItems()
for i,v in ipairs(items)do
if v.itemid==itemId and not self.currMaterials[tostring(v.itemguid)]then
return v
end
end
return nil
end

function UIYFLZCombineWin:getCombineMaterialItemB(itemguid)
local lingzhen






return nil
end

function UIYFLZCombineWin:setAttrsA(widgetAttr,itemid,level,guid)
widgetAttr:SetChildText(0,FMT.fmt('{0}级',level))
local attrs,dzAttrs=UIYuFuLingZhenControl:getAttrs(itemid)











local widget={1,2,5,6}
if next(attrs)then
for i=1,4 do
local attr=attrs[i]
if attr then

local name,str=equipsHelper.getAttr(attr[1],attr[2])
widgetAttr:SetChildText(widget[i],FMT.fmt('{0}：{1}',name,str))
else
widgetAttr:SetChildText(widget[i],'')
end
end
widgetAttr:SetChildText(3,'')
else
widgetAttr:SetChildText(1,'')
widgetAttr:SetChildText(2,'')
widgetAttr:SetChildText(3,'暂无信息')
end

end

function UIYFLZCombineWin:putInItem(guid,yfguid,kongIndex)
self.maxCombineCnt=nil
self.selectCnt=nil
if self.combineDatas[2]then
local mdata
local mGuid=self.combineDatas[2]
if self.kongIndex then
mdata=UIYuFuLingZhenControl:getXianQianData(self.yfGuid,self.kongIndex)
else
mdata=lingzhenBagModel:getItem(mGuid)
end


local itemid=self.kongIndex and mdata.itemId or mdata.itemid
local cfg=itemsConfig.getConfig(itemid)
if cfg.type1==6 then
local hechengcai=cfgHelper.get2(cfg_yufulingzhenbaseconfig_get,1,'hechengcai')or 0
local data=lingzhenBagModel:getItem(guid)
if data and hechengcai==data.itemid and not self.haveMat then
self:putInItem1(guid,yfguid,kongIndex)
return
end
end
end

local isEquip=false
local data=lingzhenBagModel:getItem(guid)
if not data then
isEquip=true
data=UIYuFuLingZhenControl:getXianQianData(yfguid,kongIndex)
end
local itemid=kongIndex and data.itemId or data.itemid
data.itemid=itemid
local cfg=itemsConfig.getConfig(itemid)

local level=cfg.level

if level>=self.maxLevel then
UIManager.error("灵阵已满级")
return
end

self:setMaterialA(self.materials_2,itemid,data.itemguid,yfguid,kongIndex)

self.currMaterials={}
self.currMaterials[tostring(guid)]=(self.currMaterials[tostring(guid)]or 0)+1
self.combineDatas={}
if not isEquip then
self.combineDatas[2]=guid
else
self.combineDatas[2]=int64.zero
self.yfGuid=yfguid
end

self.kongIndex=kongIndex
self.putItem=itemid
local group=UIYuFuLingZhenControl:getItemLevelGroup(itemid)
self.nextId=group[level+1]

local cfg=itemsConfig.getConfig(itemid)
local hcdata=cfgHelper.get2(cfg_yufulingzhenbaseconfig_get,1,'hecheng2')
local check1=cfg.type1==6
local check2=level>=hcdata[1]
local mats=cfg.hcMaterials
local maxCombineCnt,maxSelectNum
if check1 then

maxCombineCnt=1
maxSelectNum=1
self.sliderPanel:setActive(false)
else
maxCombineCnt,maxSelectNum=UIYuFuLingZhenControl:getLZMaxCombineCntAndMaxSelectNum(itemid)
self.sliderPanel:setActive(true)
end
self.maxCombineCnt=maxCombineCnt or 0
self.selectCnt=math.min(maxCombineCnt or 0,maxSelectNum or 0)
if self.selectCnt<=0 then
self.selectCnt=1
end

self.costItem=nil

local haveMat=false
if check1 then

if mats then
local itemNum=itemsModel.getCount(mats[1][1])
local needNum=mats[1][2]*self.selectCnt
if itemNum>=needNum then
local itemId=mats[1][1]
self:setMaterialB(self.materials_1,{itemId,needNum})
self.combineDatas[1]=int64.new('0')
self.combineDatas[3]=int64.new('0')
self:lockMaterial(self.materials_3)
haveMat=true
else
self:setMaterialB(self.materials_1,mats[1])
self.combineDatas[1]=int64.new('0')
self.combineDatas[3]=int64.new('0')
self:lockMaterial(self.materials_3)
end
self.costItem=mats[1]
end


















else

local count=itemsModel.getCount(itemid)
if isEquip then
count=count+1
end
if count>=2 then
self:setMaterialA(self.materials_1,itemid,guid)
self.currMaterials[tostring(guid)]=true
if not isEquip then
self.combineDatas[1]=guid
else
local item,itemguid=bagControl.invokeFuncByItemId(itemid,'getItemByItemID',itemid)
self.combineDatas[1]=itemguid
end


else

self:setMaterialC(self.materials_1,itemid)
end

if check2 then
self:setMaterialB(self.materials_3,mats[1])
self.combineDatas[3]=int64.new('0')
self.costItem=mats[1]
else


if count>=3 then
self:setMaterialA(self.materials_3,itemid,guid)
self.currMaterials[tostring(guid)]=true
if not isEquip then
self.combineDatas[3]=guid
else
local item,itemguid=bagControl.invokeFuncByItemId(itemid,'getItemByItemID',itemid)
self.combineDatas[3]=itemguid
end
else

self:setMaterialC(self.materials_3,itemid)
end
end
end


local widgetAttrL=self.levelAttr1:getWidgetBase()
widgetAttrL:SetChildText(0,FMT.fmt('{0}级',level))
widgetAttrL:SetChildText(3,'')
self:setAttrsA(widgetAttrL,itemid,level,guid)

widgetAttrL:SetChildActive(4,false)

local widgetAttrR=self.levelAttr2:getWidgetBase()
widgetAttrR:SetChildText(0,FMT.fmt('{0}级',level+1))
local nextItemid=UIYuFuLingZhenControl:getItemIdByLevel(itemid,level+1)
widgetAttrR:SetChildText(3,'')
self:setAttrsA(widgetAttrR,nextItemid,level+1,guid)
widgetAttrR:SetChildActive(4,true)

level=cfg.level+1
local color=UIYuFuLingZhenControl:getItemColorById(self.nextId)

local widget=self.product:getWidgetBase()
widget:SetChildActive(0,true)
local pz=UIYuFuLingZhenControl:getPZIconName(color)
widget:SetChildCSImageSprite(1,globalABLookup.yufulingzhen,pz)
local icon=UIYuFuLingZhenControl:getLZIconName(cfg)
widget:SetChildIcon(2,icon,true)
widget:SetChildText(3,level)
widget:SetChildButtonClick(4,function()
tipsManager.showTips({itemid=nextItemid,itemguid=data.itemguid,move=TIPS_MOVE_POS.eRight,attach={yfguid=data.yufuGuid,kongIndex=data.kongIndex,level=level}})

end)




local cost
if check1 then

cost=cfg.compound
self.selectItemList={}
self.selectItemList[itemid]=1
if cost then
self.selectItemList[cost[1]]=cost[2]
end
if mats then
for i,v in ipairs(mats)do
self.selectItemList[v[1]]=v[2]
end
end
else

local costType=eMoneyType.mtZhenShi
if self.maxCombineCnt>0 then
self.selectItemList=UIYuFuLingZhenControl:getLZCombineSelectItemList_crossLevel(itemid,self.selectCnt,self.selectItemList,_tmpList)
local costCount=self.selectItemList[costType]or 0
cost={costType,costCount}
else
cost=cfg.compound
end
end

self.costMoney=cost
if cost then
self:showCost(true)
self.cost:setActive(true)
local have=itemsModel.getCount(cost[1])
local needCount=cost[2]
local showCostStr=have>=needCount and needCount or FMT.cfmt(FONT_COLOR.eRedColor,needCount)
self.cost:setText(showCostStr)

self.costIcon:setIcon(iconHelper.getIconName(cost[1]),true)
else
self:showCost(false)
self.cost:setActive(false)
end

local notgray=false
if check1 then
if haveMat then
notgray=self.combineDatas[2]
else
notgray=self.combineDatas[1]and self.combineDatas[2]
end
else

notgray=self.maxCombineCnt and self.maxCombineCnt>0 or false
end
self.check1=check1
self.haveMat=haveMat
self.isPutIn=notgray

if notgray then
self.combinBtn:setGray(false)
self.combinText:setText("合成")
else
self.combinBtn:setGray(true)
self.combinText:setText("请放入灵阵")
end
self:refreshSelectCntSlider(true)
end

function UIYFLZCombineWin:putInItem1(guid,yfguid,kongIndex)
local data=lingzhenBagModel:getItem(guid)
if not data then
data=UIYuFuLingZhenControl:getXianQianData(yfguid,kongIndex)
end


self:setMaterialA(self.materials_3,data.itemid,data.itemguid)

self.currMaterials[tostring(guid)]=true
self.combineDatas[1]=guid


self:refreshBtn()
end

function UIYFLZCombineWin:takeOffByTips(itemid,itemguid)
for k,v in pairs(self.combineDatas)do
if itemguid==v then
if self['materials_'..k]then
self:clearMaterial(self['materials_'..k])
end
self.combineDatas[k]=nil

if k==2 then
self:clearCombinePanel()
break
end
end
end
self:refreshBtn()
end

function UIYFLZCombineWin:showCost(active)
self.costInfo:setActive(active)
end


function UIYFLZCombineWin:refreshBtn()
local notgray=false
if self.check1 then
if self.haveMat then
notgray=self.combineDatas[2]
else
notgray=self.combineDatas[1]and self.combineDatas[2]
end
else

notgray=self.maxCombineCnt and self.maxCombineCnt>0 or false
end
if notgray then
self.combinBtn:setGray(false)
self.combinText:setText("合成")
else
self.combinBtn:setGray(true)
self.combinText:setText("请放入灵阵")
end
self.isPutIn=notgray
end

function UIYFLZCombineWin:refreshSelectCntSlider(isInit)
if not self.maxCombineCnt then
self.maxCombineCnt=0
end

if not self.selectCnt then
self.selectCnt=0
end

if self.putItem then
local itemid=self.putItem
local cfg=itemsConfig.getConfig(itemid)
local check1=cfg.type1==6
if check1 then
self.sliderPanel:setActive(false)
else
self.sliderPanel:setActive(true)
end
else
self.sliderPanel:setActive(false)
end


local mixCount
local showMaxCount=self.maxCombineCnt>0 and self.maxCombineCnt or 1
if showMaxCount==1 then
mixCount=0
else
mixCount=1
end

self.sliderClickMask:setActive(self.maxCombineCnt<=0 or self.maxCombineCnt==1)
if isInit then
local func=function(...)
self:onSliderChange(...)
end
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,mixCount,showMaxCount,func)
else
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end
end

function UIYFLZCombineWin:onSliderChange(value)
self.selectCnt=value
self.selectCntText:setText(self.selectCnt)



local cost
if not self.check1 then

table.clear(_tmpList)
local itemid=self.putItem
if itemid then
local costType=eMoneyType.mtZhenShi
local costCount
if self.maxCombineCnt>0 then
self.selectItemList=UIYuFuLingZhenControl:getLZCombineSelectItemList_crossLevel(itemid,self.selectCnt,self.selectItemList,_tmpList)
costCount=self.selectItemList[costType]or 0
self.costMoney={costType,costCount}
end
end
end
cost=self.costMoney
if cost then
self:showCost(true)
self.cost:setActive(true)
local have=itemsModel.getCount(cost[1])
local needCount=cost[2]
local showCostStr=have>=needCount and needCount or FMT.cfmt(FONT_COLOR.eRedColor,needCount)
self.cost:setText(showCostStr)

self.costIcon:setIcon(iconHelper.getIconName(cost[1]),true)
else
self:showCost(false)
self.cost:setActive(false)
end




if self.check1 then
if self.haveMat then
local item=self.costItem
local itemId=item[1]
local itemCount=item[2]
local needCount=itemCount*self.selectCnt
self:setMaterialB(self.materials_1,{itemId,needCount})
end
end

end


function UIYFLZCombineWin:onReverseBtn()



self:showWindow("UILingZhenFJWin")
end

function UIYFLZCombineWin:onCombinBtn()
if self.isPutIn then

if self.costItem then
local itemsCount=itemsModel.getCount(self.costItem[1])
local itemNeedNum=self.costItem[2]*self.selectCnt
if itemsCount<itemNeedNum then
local err=FMT.fmt('{0}不足',itemsConfig.getItemName(self.costItem[1]))
UIManager.error(err)
gainControl:showGainWin(self.costItem[1])
return
end
end

local selectItemList={}
local selectItemList_lookup=self.selectItemList
for itemId,count in pairs(selectItemList_lookup)do
local itemGuid
if not moneyConfig.isMoney(itemId)then

if itemId==self.putItem and self.combineDatas[2]and not mathHelper.compareInt64(self.combineDatas[2],Int64_0)then
itemGuid=self.combineDatas[2]
else
local item,itemguid=bagControl.invokeFuncByItemId(itemId,'getItemByItemID',itemId)
if item then
itemGuid=itemguid
end
end
end

if itemGuid then






selectItemList[#selectItemList+1]={itemGuid,count}
end
end

if self.costMoney then
self.combineDatas[1]=self.combineDatas[1]or int64.zero
self.combineDatas[3]=self.combineDatas[3]or int64.zero
if itemsConfig.isMoney(self.costMoney[1])then
moneySystem:useMoney(self.costMoney[1],self.costMoney[2],function()

UIYuFuLingZhenControl:reqLZHeCheng(self.nextId,self.selectCnt,self.combineDatas[2],selectItemList)
end,WARNING_TYPE.eWarning)
else
local itemsCount=itemsModel.getCount(self.costMoney[1])
local itemNeedNum=self.costMoney[2]
if itemsCount>=itemNeedNum then

UIYuFuLingZhenControl:reqLZHeCheng(self.nextId,self.selectCnt,self.combineDatas[2],selectItemList)
else
local err=FMT.fmt('{0}不足',itemsConfig.getItemName(self.costMoney[1]))
UIManager.error(err)
gainControl:showGainWin(self.costMoney[1])
end
end
else
self.combineDatas[1]=self.combineDatas[1]or int64.zero
self.combineDatas[3]=self.combineDatas[3]or int64.zero

UIYuFuLingZhenControl:reqLZHeCheng(self.nextId,self.selectCnt,self.combineDatas[2],selectItemList)
end

else
if self.combineDatas[2]and self.putItem then
gainControl:showGainWin(self.putItem)
end
UIManager.error('合成物品不足')
end
end

function UIYFLZCombineWin:onBatchCombinBtn()
local sfId=mapIdType.zhufeng
local bdId=SLG_SYSTEM_TYPE.eBaGuaLu1
local bdData=zongmenModel:findBuildingDataByID(sfId,bdId)
if bdData then
UIFullBaGuaLuControl:showMyWindowByBuild({data=bdData,args={tabType=FULL_TAB_TYPE.eHechengLianHua}})
UIFullBaGuaLuControl:showWindow('UIHeChengLianHuaPeiFangWin',{sfId=sfId,bdData=bdData,selectPage=2})
self:closeSelf()
else
UIManager.info("请先建造八卦炉")
end
end

function UIYFLZCombineWin:onFilter()
UIManager:showWindow('UIYFLZFilterWin',{levelSelect=self.levelSelect,selectCall=function(select,levelSelect)
self:setFilter(select,levelSelect)
end})
end

function UIYFLZCombineWin:onCloseClick()
self:closeSelf()
end

function UIYFLZCombineWin:onChongZhuBtn()
self:showWindow("UILingzhenChongZhuWin",{yfguid=self.yfGuid,kongIndex=6,openForm=1})
end

function UIYFLZCombineWin:onSubBtn()
if self.maxCombineCnt<=0 or self.selectCnt<=1 then
return
end

self.selectCnt=self.selectCnt-1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIYFLZCombineWin:onAddBtn()
if self.maxCombineCnt<=0 or self.selectCnt>=self.maxCombineCnt then
return
end

self.selectCnt=self.selectCnt+1
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end