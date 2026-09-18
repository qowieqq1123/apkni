







def_class("UIAquariumBagWin",UIWindowBase)









function UIAquariumBagWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.pageScrollView=UIObject.get(self,1)
self.bagScrollView=UIObject.get(self,2)
self.reverseBtn=UIButton.get(self,3)
self.comboBox=UIObject.get(self,4)
self.count=UIText.get(self,5)
self.marketBtn=UIButton.get(self,6)
self.model=UIObject.get(self,7)
self.sellScrollView=UIObject.get(self,8)
self.selectAllBtn=UIButton.get(self,9)
self.sellBtn=UIButton.get(self,10)
self.sellFilter=UIButton.get(self,11)
self.moneyIcon=UIObject.get(self,12)
self.moneyCount=UIText.get(self,13)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.reverseBtn:setButtonClick(function()self:onReverseBtn()end)

self.marketBtn:setButtonClick(function()self:onMarketBtn()end)

self.selectAllBtn:setButtonClick(function()self:onSelectAllBtn()end)

self.sellBtn:setButtonClick(function()self:onSellBtn()end)

self.sellFilter:setButtonClick(function()self:onSellFilter()end)



end


function UIAquariumBagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.pageScrollView);self.pageScrollView=nil;
_UIObject_release(self.bagScrollView);self.bagScrollView=nil;
_UIObject_release(self.reverseBtn);self.reverseBtn=nil;
_UIObject_release(self.comboBox);self.comboBox=nil;
_UIObject_release(self.count);self.count=nil;
_UIObject_release(self.marketBtn);self.marketBtn=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.sellScrollView);self.sellScrollView=nil;
_UIObject_release(self.selectAllBtn);self.selectAllBtn=nil;
_UIObject_release(self.sellBtn);self.sellBtn=nil;
_UIObject_release(self.sellFilter);self.sellFilter=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyCount);self.moneyCount=nil;
end



















function UIAquariumBagWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/aquarium/aquarium_atlas_pak.ab'
self.dyABName='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'

self.pageNames={'全部','小鱼','中鱼','大鱼'}

self.colorNames={'全部品质','红色品质','橙色品质','紫色品质','蓝色品质','绿色品质'}
self.colorIndex={0,5,4,3,2,1}

self.sellList={}

self.sellDatas={}

self.reverse=false

self.moneyIcon:setIcon(moneyModel.getIconNameEx(eMoneyType.mtYuBi),true)
self.moneyCount:setText(0)

self.comboBox:setChildComboBoxInit(function(...)self:onComboxChange(...)end)

self.pageScrollView:setChildScrollViewInit(0.5,true,function(...)self:onPageClick(...)end,nil)
self.bagScrollView:setChildScrollViewInit(0.5,true,function(...)self:onItemClick(...)end,nil)
self.sellScrollView:setChildScrollViewInit(0.5,true,function(...)self:onSellItemClick(...)end,nil)

UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtYuBi}})
end

function UIAquariumBagWin:onComboxChange(index)
self.selectColor=self.colorIndex[index+1]
self:onPageClick(0,self.pageIndex or 0)
end

function UIAquariumBagWin:onPageClick(num,index)
if self.pageIndex then
local widget=self.pageScrollView:getChildScrollViewItemWidget(self.pageIndex)
widget:SetChildActive(0,false)
end
self.pageIndex=index
local widget=self.pageScrollView:getChildScrollViewItemWidget(self.pageIndex)
widget:SetChildActive(0,true)

self:showBagList()
end

function UIAquariumBagWin:onItemClick(num,index)
self:showTips(index)
end

function UIAquariumBagWin:onSellItemClick(num,index)
self:showSellTips(index)
end

function UIAquariumBagWin:moveSellToBag(index,num)
local data=self.sellList[index+1]
local itemData=data[1]
local sdata=self.sellDatas[tostring(itemData.itemguid)]
sdata[2]=sdata[2]-num
if sdata[2]<=0 then
self.sellDatas[tostring(itemData.itemguid)]=nil
end
self:showSellList()
self:showBagList()
end


function UIAquariumBagWin:__delete()
UIManager:hideWindow('UITopMoneyWin')

self.bagScrollView:setChildScrollViewStopGridCreate()

self:unbindComponents()

uiAIManager:clearUIWinData('UIAquariumBagWin')
end




function UIAquariumBagWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UIAquariumBagWin:refresh()
self:showPage()
self.comboBox:setChildComboBoxOption(0,self.colorNames)

self.count:setText(FMT.fmt('鱼舱空间：{0}/{1}',#self.datas,200))

if not self.isCreateModel then
self:createCat()
self.isCreateModel=true
end
self:setMarketBtn()
end

function UIAquariumBagWin:setMarketBtn(isSelect)
self.marketBtn:setSprite(self.abName,isSelect and'button_yjqingbao_2'or'button_yjqingbao_1')
end


function UIAquariumBagWin:onHide()

end

function UIAquariumBagWin:createCat()
local aiCfg=cfgHelper.get1(cfg_yuelongchiaiconfig_get,1)
local initData={
speakTime=3,
speakRate=aiCfg.ui_bag_speak_rate,
speakCD=aiCfg.ui_bag_speak_cd,
speakHUDParent=1,
}
local tran=self.model:getCommonComponent('Transform')
local vpos=Vector2.New(0,0)
local otherData={

}
uiAIManager:createEmptyObject('UIAquariumBagWin','bt_ui_aquarium_bag',INSTANCE_TYPE.eUIDisciple,
tran,vpos,initData,otherData,function(bt)


end)
end


function UIAquariumBagWin:getCatSpeakText(bt,tkey)
local aiCfg=cfgHelper.get1(cfg_yuelongchiaiconfig_get,1)
local isSell=#self.sellList>0
local datas=isSell and aiCfg.ui_bag_speak_2 or aiCfg.ui_bag_speak_1
local str=datas[math.random(1,#datas)]
if not isSell then
local ft=UIAquariumControl:getMaxMarketType()
local fname=UIAquariumControl:getYuTypeName(ft)
str=FMT.fmt(str,fname)
end
bt:setSharedVar(tkey,str)
end

function UIAquariumBagWin:getPageDatas(stypes)
local items=UIAquariumControl:getFishItemsInBag(stypes)
local list={}
for i,v in ipairs(items)do
local count=v.itemcount
local sdata=self.sellDatas[tostring(v.itemguid)]
if sdata then
count=count-sdata[2]
end
if count>0 then
local itemCfg=itemsConfig.getConfig(v.itemid)
if self.selectColor==0 or itemCfg.color==self.selectColor then
table.insert(list,{v,count,itemCfg.color})
end
end
end
table.sort(list,function(a,b)
local color1=a[3]
local color2=b[3]
if color1>color2 then
return true
elseif color1==color2 then
return a[1].itemid<b[1].itemid
else
return false
end
end)
if self.reverse then
list=table.reverse(list)
end
return list
end

function UIAquariumBagWin:showPage()
local len=#self.pageNames
self.pageScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.pageScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
item:SetChildActive(0,false)
item:SetChildText(1,self.pageNames[i])
end
end

function UIAquariumBagWin:showBagList(index)
local stypes
if self.pageIndex==1 then
stypes={1}
elseif self.pageIndex==2 then
stypes={2}
elseif self.pageIndex==3 then
stypes={3}
elseif self.pageIndex==4 then
stypes={4}
else
stypes={1,2,3,4}
end
self.datas=self:getPageDatas(stypes)
local len=#self.datas
self.bagScrollView:setChildScrollViewStopGridCreate()

self.bagScrollView:setChildScrollViewCreateGrids(0,0)
self.bagScrollView:setChildScrollViewDelayCreateGrids(len,4,0.02,35,false,false,function(index,item)
local data=self.datas[index+1]
local itemData=data[1]
local itemCount=data[2]
local cfg=itemsConfig.getConfig(itemData.itemid)
item:SetChildCSImageSprite(0,self.dyABName,'image_cyhyyupj_'..cfg.color)
item:SetChildIcon(1,itemsModel.getIconName(itemData),true)
item:SetChildText(2,itemCount)
local isSPFish=UIAquariumControl:isOrnamentalFish(itemData)
item:SetChildActive(3,isSPFish)
end)


if index then
if index>len then
index=len
end
self.bagScrollView:setChildScrollViewSelectItem(index)
end
end

function UIAquariumBagWin:showTips(index)
local data=self.datas[index+1]
local itemData=data[1]
local itemCount=data[2]
local tipsAttach={
isSell=true,
state=1,
index=index,
selectNumCmpArgs={
numFormat='<color=#f1ce78>数量：</color>{0}/{1}',
min=1,
max=itemCount,
curr=1,
}
}
itemsComponentHelper.onItemClickEx(itemData.itemid,nil,itemData.itemguid,tipsAttach)
end

function UIAquariumBagWin:getSellCount()
local count=0
for k,v in pairs(self.sellDatas)do
count=count+1
end
return count
end

function UIAquariumBagWin:moveItemToSell(index,num)
local data=self.datas[index+1]
local itemData=data[1]
local sdata=self.sellDatas[tostring(itemData.itemguid)]
local refresh=true
if sdata then
sdata[2]=sdata[2]+num
else
local count=self:getSellCount()
if count<10 then
sdata={itemData,num}
self.sellDatas[tostring(itemData.itemguid)]=sdata
else
refresh=false
UIManager.info('出售栏已满')
end
end
if refresh then
self:showSellList()
self:showBagList(index)
end
end

function UIAquariumBagWin:getSellList()
local list={}
for k,v in pairs(self.sellDatas)do
table.insert(list,v)
end
return list
end

function UIAquariumBagWin:showSellList(index)
self.sellPosList={}
self.sellList=self:getSellList()
local len=#self.sellList
self.sellScrollView:setChildScrollViewCreateGrids(len,5)
local grids=self.sellScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.sellList[i]
local itemData=data[1]
local itemCount=data[2]
local cfg=itemsConfig.getConfig(itemData.itemid)
item:SetChildCSImageSprite(0,self.dyABName,'image_cyhyyupj_'..cfg.color)
item:SetChildIcon(1,itemsModel.getIconName(itemData),true)
item:SetChildText(2,itemCount)
local isSPFish=UIAquariumControl:isOrnamentalFish(itemData)
item:SetChildActive(3,isSPFish)
local sPos=item:GetChildPosition(1)

local rise=UIAquariumControl:getFishPriceRise(itemData.itemid)
local count=math.floor(cfg.dealPrice[2]*rise*itemCount)
table.insert(self.sellPosList,{pos=sPos,count=count})
end

self.moneyCount:setText(self:countSellPrice())
end

function UIAquariumBagWin:showSellTips(index)
local data=self.sellList[index+1]
local itemData=data[1]
local itemCount=data[2]
local tipsAttach={
isSell=true,
state=2,
index=index,
selectNumCmpArgs={
numFormat='<color=#f1ce78>数量：</color>{0}/{1}',
min=1,
max=itemCount,
curr=1,
}
}
itemsComponentHelper.onItemClickEx(itemData.itemid,nil,itemData.itemguid,tipsAttach)
end

function UIAquariumBagWin:countSellPrice()
local count=0
for i,v in ipairs(self.sellList)do
local itemData=v[1]
local itemCount=v[2]
local cfg=itemsConfig.getConfig(itemData.itemid)
local rise=UIAquariumControl:getFishPriceRise(itemData.itemid)
count=count+math.floor(cfg.dealPrice[2]*rise*itemCount)
end
return count
end

function UIAquariumBagWin:completeSell()
self.sellDatas={}
self:showYuBiMove()
self:showSellList()

UIManager.error('成功出售')

AudioManager.playAudio(584)
end

function UIAquariumBagWin:showDialog(content,callback)
local comfirmDialog=UIDialogManager.getConfirmDialog(nil,nil,content,nil,nil,callback)
comfirmDialog:show()
end

function UIAquariumBagWin:showYuBiMove()
for i,v in ipairs(self.sellPosList)do
UIManager:invokeUIMethod('UITopMoneyWin','flyYuBiIcon',v.pos,eMoneyType.mtYuBi,v.count)
end
self.sellPosList={}
end




function UIAquariumBagWin:onSelectAllBtn()
local datas=self:getPageDatas({1,2,3,4})
local list={}
local sellData=UIAquariumControl:getSellCheckData()
for i,v in ipairs(datas)do
local itemData=v[1]
local itemCount=v[2]
local isSPFish=UIAquariumControl:isOrnamentalFish(itemData)
local cfg=itemsConfig.getConfig(itemData.itemid)
local stype=cfg.type1
local color=cfg.color
local check=true
if isSPFish then
if not sellData[1][stype]then
check=false
end
if not sellData[2][color]then
check=false
end
else
if not sellData[3][stype]then
check=false
end
if not sellData[4][color]then
check=false
end
end
if check then
local sdata=list[tostring(itemData.itemguid)]
if sdata then
sdata[2]=sdata[2]+itemCount
else
sdata={itemData,itemCount}
list[tostring(itemData.itemguid)]=sdata
end
end
end

local count=self:getSellCount()
local refresh=false
for k,v in pairs(list)do
local data=self.sellDatas[k]
if data then
data[2]=data[2]+v[2]
refresh=true
else
if count<10 then
self.sellDatas[k]=v
count=count+1
refresh=true
end
end
end
if refresh then
self:showSellList()
self:showBagList()
else
UIManager.info('鱼舱中没有商品鱼种')
end
end

function UIAquariumBagWin:onSellBtn()
if#self.sellList<=0 then
UIManager.error('当前没有任何鱼获可出售')
return
end
self:showDialog('确定要出售当前鱼获吗？',function()
local sendDatas={}
for i,v in ipairs(self.sellList)do
local itemData=v[1]
local itemCount=v[2]
table.insert(sendDatas,{itemData.itemguid,itemCount})
end
UIAquariumControl:reqDeal(#sendDatas,sendDatas)
end)
end

function UIAquariumBagWin:onMarketBtn()
self:setMarketBtn(true)
UIManager:showWindow('UIAquariumMarketWin')
end

function UIAquariumBagWin:onReverseBtn()
self.reverse=not self.reverse
self:onPageClick(0,self.pageIndex or 0)
end

function UIAquariumBagWin:onSellFilter()
UIManager:showWindow('UIAquariumSellFilterWin')
end

function UIAquariumBagWin:onCloseClick()
self:closeSelf()
end

function UIAquariumBagWin:onCloseBtn()
self:onCloseClick()
end