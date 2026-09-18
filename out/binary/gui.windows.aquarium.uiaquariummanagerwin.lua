







def_class("UIAquariumManagerWin",UIWindowBase)









function UIAquariumManagerWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.infoPanel=UIObject.get(self,1)
self.count=UIText.get(self,2)
self.scrollView=UIObject.get(self,3)
self.pageScrollView=UIObject.get(self,4)
self.fishInfo=UIObject.get(self,5)
self.decInfo=UIObject.get(self,6)
self.changePosBtn=UIButton.get(self,7)
self.tixing_1=UIButton.get(self,8)
self.tixing_2=UIButton.get(self,9)
self.tixing_3=UIButton.get(self,10)
self.texing_1=UIObject.get(self,11)
self.texing_2=UIObject.get(self,12)
self.texing_3=UIObject.get(self,13)
self.pageBtn_5=UIObject.get(self,14)
self.pageBtn_4=UIObject.get(self,15)
self.pageBtn_3=UIObject.get(self,16)
self.pageBtn_2=UIObject.get(self,17)
self.pageBtn_1=UIObject.get(self,18)
self.pageBtn_6=UIObject.get(self,19)
self.sellBtn=UIButton.get(self,20)
self.replaceBtn=UIButton.get(self,21)
self.attr=UIText.get(self,22)
self.model=UIObject.get(self,23)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.changePosBtn:setButtonClick(function()self:onChangePosBtn()end)

self.tixing_1:setButtonClick(function()self:onTixing_1()end)

self.tixing_2:setButtonClick(function()self:onTixing_2()end)

self.tixing_3:setButtonClick(function()self:onTixing_3()end)

self.sellBtn:setButtonClick(function()self:onSellBtn()end)

self.replaceBtn:setButtonClick(function()self:onReplaceBtn()end)
self.tixing={
self.tixing_1,
self.tixing_2,
self.tixing_3,
}
self.texing={
self.texing_1,
self.texing_2,
self.texing_3,
}
self.pageBtn={
self.pageBtn_1,
self.pageBtn_2,
self.pageBtn_3,
self.pageBtn_4,
self.pageBtn_5,
self.pageBtn_6,
}



end


function UIAquariumManagerWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.infoPanel);self.infoPanel=nil;
_UIObject_release(self.count);self.count=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.pageScrollView);self.pageScrollView=nil;
_UIObject_release(self.fishInfo);self.fishInfo=nil;
_UIObject_release(self.decInfo);self.decInfo=nil;
_UIObject_release(self.changePosBtn);self.changePosBtn=nil;
_UIObject_release(self.tixing_1);self.tixing_1=nil;
_UIObject_release(self.tixing_2);self.tixing_2=nil;
_UIObject_release(self.tixing_3);self.tixing_3=nil;
_UIObject_release(self.texing_1);self.texing_1=nil;
_UIObject_release(self.texing_2);self.texing_2=nil;
_UIObject_release(self.texing_3);self.texing_3=nil;
_UIObject_release(self.pageBtn_5);self.pageBtn_5=nil;
_UIObject_release(self.pageBtn_4);self.pageBtn_4=nil;
_UIObject_release(self.pageBtn_3);self.pageBtn_3=nil;
_UIObject_release(self.pageBtn_2);self.pageBtn_2=nil;
_UIObject_release(self.pageBtn_1);self.pageBtn_1=nil;
_UIObject_release(self.pageBtn_6);self.pageBtn_6=nil;
_UIObject_release(self.sellBtn);self.sellBtn=nil;
_UIObject_release(self.replaceBtn);self.replaceBtn=nil;
_UIObject_release(self.attr);self.attr=nil;
_UIObject_release(self.model);self.model=nil;
self.tixing=nil;
self.texing=nil;
self.pageBtn=nil;
end
















local _item_index=
{
icon=0,
add=1,
suo=2,
text=3,
select=4,
bg=5,
}




function UIAquariumManagerWin:onLoaded(...)
self:bindComponents()

self.pageName={'小型','中型','大型','异兽','灵物','摆件'}
self.pageType={1,2,3,4,5,6}
self.ttName={'最小体态','普通体态','最大体态'}

self.infoPanel:setActive(false)

self.showNumData=self:countShowNum()
self.unlockCost=cfgHelper.getdef1(cfg_yuelongchiconfig,'consume')

self.scrollView:setChildScrollViewInit(0.5,true,function(...)self:onFishClick(...)end,nil)


UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtYuBi}})
end

function UIAquariumManagerWin:onPageClick(num,index,notSlide)
if self.pageIndex then

local widget=self.pageBtn[self.pageIndex+1]:getChildWidgetBase()
widget:SetChildActive(0,false)
end
self.pageIndex=index

local widget=self.pageBtn[self.pageIndex+1]:getChildWidgetBase()
widget:SetChildActive(0,true)

self:resetSelect()
self:shwoFishByPage(index)
self:autoSelectFish(notSlide)
end

function UIAquariumManagerWin:onFishClick(num,index)
local data=self.showDatas[index+1]
if data.stype==4 then
local cost=self:getUnlockCost(self.ftype)
local mtype=cost[1]
local mvalue=cost[2]
local mname=moneyModel.getMoneyName(mtype)
local content=FMT.fmt('是否花费{0}{1}进行扩容',mvalue,mname)
self:showDialog(content,function()
local have=moneyModel.getMoney(mtype)
if have>=mvalue then
UIAquariumControl:reqExpansion(self.ftype,1)
else
UIManager.error(FMT.fmt('{0}不足',mname))
gainControl:showGainWin(mtype)
end
end)
elseif data.stype==3 then
local sdata=self.showNumData[self.ftype]
UIManager.info(FMT.fmt('{0}级解锁',sdata.ulevel))
else
if data.fish then
self:selectFinish(index)
else
self:openSelectWin()
end
end
end

function UIAquariumManagerWin:openSelectWin(select)
local fish
if select then
local data=self.showDatas[select+1]
fish=data.fish
end
UIManager:showWindow('UIAquariumDeliveryWin',{ftype=self.ftype,fish=fish})
end

function UIAquariumManagerWin:resetSelect()
if self.currSelect then
local widget=self.scrollView:getChildScrollViewItemWidget(self.currSelect)
widget:SetChildActive(_item_index.select,false)
widget:SetChildActive(_item_index.bg,true)
end
end

function UIAquariumManagerWin:selectFinish(index)
self:resetSelect()
self.currSelect=index
local widget=self.scrollView:getChildScrollViewItemWidget(self.currSelect)
widget:SetChildActive(_item_index.select,true)
widget:SetChildActive(_item_index.bg,false)

if self.ftype~=6 then
self:setInfoPanel(index)
else
self:setDecorationInfo(index)
end
end

function UIAquariumManagerWin:refreshInfoPanel()
self:setInfoPanel(self.currSelect)
end

function UIAquariumManagerWin:setInfoPanel(index)
self.infoPanel:setActive(true)
self.fishInfo:setActive(true)
self.decInfo:setActive(false)
local data=self.showDatas[index+1]
local fish=data.fish
local cfg=itemsConfig.getConfig(fish.itemid)
local ncfg=cfgHelper.get1(cfg_ylcinfoconfig_get,cfg.info)
local size=UIAquariumControl:getFishSize(fish.itemguid)
local scale=UIAquariumControl:countScaleBySize(1,size,fish.itemid)
self.model:setChildUIModelShowTarget(ncfg.model,scale,nil,eAnimationID.stand)
local ly=UIAquariumControl:countFishLingYun(fish,cfg)
self.attr:setText(FMT.fmt('灵韵  <color=#ca631d>+{0}</color>',ly))

if self.ftype<5 then
self.fishInfo:setActive(true)

local txList=fish.itemData.featureList
for i,v in ipairs(self.texing)do
local tx=txList and txList[i]
if tx then
v:setActive(true)
local widget=v:getChildWidgetBase()
local txcfg=cfgHelper.get1(cfg_fishfeatureconfig_get,tx)
local name=UIDiscipleModel.getSpecialityNameStr(txcfg.name)
widget:SetChildText(1,name)
widget:SetChildButtonClick(0,function()
UIAquariumControl:showSpecialityTips(tx,widget)
end)
else
v:setActive(false)
end
end

local check=UIAquariumControl:checkHandleBookFlag(cfg.bookid,0)
self.currTXSelect=size+1
local widget=self.tixing_1:getChildWidgetBase()
widget:SetChildText(0,self.ttName[1])
widget:SetChildActive(1,size==0)
widget:SetChildActive(2,not check)
widget:SetChildButtonClick(-1,function()
if check then
self:onTiXingSelect(1)
else
UIManager.error('需先解锁最小体型')
end
end)

widget=self.tixing_2:getChildWidgetBase()
widget:SetChildText(0,self.ttName[2])
widget:SetChildActive(1,size==1)
widget:SetChildActive(2,false)
widget:SetChildButtonClick(-1,function()
self:onTiXingSelect(2)
end)

local check2=UIAquariumControl:checkHandleBookFlag(cfg.bookid,2)
widget=self.tixing_3:getChildWidgetBase()
widget:SetChildText(0,self.ttName[3])
widget:SetChildActive(1,size==2)
widget:SetChildActive(2,not check2)
widget:SetChildButtonClick(-1,function()
if check2 then
self:onTiXingSelect(3)
else
UIManager.error('需先解锁最大体型')
end
end)
else
self.fishInfo:setActive(false)
end
end

function UIAquariumManagerWin:setDecorationInfo(index)
self.infoPanel:setActive(true)
self.fishInfo:setActive(false)
self.decInfo:setActive(true)

local data=self.showDatas[index+1]
local fish=data.fish
local cfg=itemsConfig.getConfig(fish.itemid)
local ncfg=cfgHelper.get1(cfg_ylcinfoconfig_get,cfg.info)
self.model:setChildUIModelShowTarget(ncfg.model,1,nil,eAnimationID.stand)
local ly=UIAquariumControl:countFishLingYun(fish,cfg)
self.attr:setText(FMT.fmt('灵韵  <color=#ca631d>+{0}</color>',ly))
end

function UIAquariumManagerWin:onTiXingSelect(index)
if self.currTXSelect==index then
return
end
if self.currTXSelect then
local widget=self.tixing[self.currTXSelect]:getChildWidgetBase()
widget:SetChildActive(1,false)
end
self.currTXSelect=index
local widget=self.tixing[self.currTXSelect]:getChildWidgetBase()
widget:SetChildActive(1,true)

local data=self.showDatas[self.currSelect+1]
local fish=data.fish
UIAquariumControl:reqChangeSize({fish.itemguid,index-1})
end


function UIAquariumManagerWin:__delete()
UIManager:hideWindow('UITopMoneyWin')

self:unbindComponents()
end




function UIAquariumManagerWin:onShow(argtable,afterOnloaded)
if argtable then
self.defType=argtable.ftype
self.defSelect=argtable.select
if argtable.fishGuid then
self.defFishGuid=argtable.fishGuid
self.defType=UIAquariumControl:getFishTypeByGuid(argtable.fishGuid)
end
end
self:refresh()
self.defType=nil
self.defSelect=nil
self.defFishGuid=nil
end

function UIAquariumManagerWin:refreshAndSelect(guid,notSlide)
self.defFishGuid=guid
self:refresh(notSlide)
self.defFishGuid=nil
end

function UIAquariumManagerWin:refresh(notSlide)
self:showPage()
local ftype=self.ftype or self.defType or 1
local select=self.pageType[ftype]-1
self:onPageClick(1,select,notSlide)
end

function UIAquariumManagerWin:autoSelectFish(notSlide)
local len=#self.showDatas
if len>0 then
if self.defFishGuid then
local guidStr=tostring(self.defFishGuid)
for i,v in ipairs(self.showDatas)do
if v.fish and tostring(v.fish.itemguid)==guidStr then
self.defSelect=i-1
break
end
end
end
local index=math.min(len-1,self.currSelect or self.defSelect or 0)
local data=self.showDatas[index+1]
if data.fish then
if not notSlide then
self.scrollView:setChildScrollViewSelectItem(index,false,true,false)
end
else

local findex=-1
for i,v in ipairs(self.showDatas)do
if v.fish then
findex=i-1
break
end
end
if findex>=0 then
self:selectFinish(findex)
else
self.infoPanel:setActive(false)
end
end
else
self.infoPanel:setActive(false)
end
end

function UIAquariumManagerWin:getUnlockCost(ftype)
return self.unlockCost[ftype][1]
end

function UIAquariumManagerWin:countShowNum()
local showNumData={}
for i=1,6 do

local t={uNum=0,ulevel=0,eNUm=0}
showNumData[i]=t
end
local level=UIAquariumControl:getLevel()
local cfgs=cfg_yuelongchiconfig()
local ccfg=cfgs[level]
for k,v in pairs(ccfg.max)do
local t=showNumData[k]
t.uNum=v
end
for k,v in pairs(ccfg.extend)do
local t=showNumData[k]
t.eNUm=v
end
local len=#cfgs
local nl=math.min(level+1,len)
for i,v in ipairs(showNumData)do
for ii=nl,len do
local cfg=cfgs[ii]
local num=cfg.max[i]
if num and num>v.uNum then
v.ulevel=ii
break
end
end
end
return showNumData
end

function UIAquariumManagerWin:showPage()











for i,v in ipairs(self.pageBtn)do
local item=v:getChildWidgetBase()
item:SetChildActive(0,false)
item:SetChildText(1,self.pageName[i])
local check=UIAquariumControl:checkFishManagerTypeReddot(self.pageType[i])
item:SetChildActive(2,check)
item:SetChildButtonClick(3,function()
self:onPageClick(0,i-1)
end)
end
end

function UIAquariumManagerWin:delaySetReddot()
self:delayDo(0.001,function()
for i,v in ipairs(self.pageBtn)do
local item=v:getChildWidgetBase()
local check=UIAquariumControl:checkFishManagerTypeReddot(self.pageType[i])
item:SetChildActive(2,check)
end
end)
end

function UIAquariumManagerWin:getShowDataList(ftype)
local sdata=self.showNumData[ftype]
local fishItems=UIAquariumControl:getFishItemsByType(ftype)
local exNum=UIAquariumControl:getExtendNumByType(ftype)
local uNum=sdata.uNum+exNum
local datas={}
for i=1,uNum do
local fish=fishItems[i]
datas[i]={fish=fish,stype=fish and 2 or 1}
end
if sdata.ulevel>0 then
datas[#datas+1]={stype=3}
end
local dis=sdata.eNUm-exNum
if dis>0 then
datas[#datas+1]={stype=4}
end
table.sort(datas,function(a,b)
if a.fish and b.fish then
local a_cfg=itemsConfig.getConfig(a.fish.itemid)
local a_ly=UIAquariumControl:countFishLingYun(a.fish,a_cfg)
local b_cfg=itemsConfig.getConfig(b.fish.itemid)
local b_ly=UIAquariumControl:countFishLingYun(b.fish,b_cfg)
return a_ly>b_ly

else
return a.stype<b.stype
end
end)
return datas,uNum
end

function UIAquariumManagerWin:shwoFishByPage(index)
self.currSelect=nil
local ftype=self.pageType[index+1]
self.ftype=ftype
local sdata=self.showNumData[ftype]
local showDatas,uNum=self:getShowDataList(ftype)
self.showDatas=showDatas
self.count:setText(FMT.fmt('{0}({1}/{2})',UIAquariumControl:getYuTypeName(ftype),0,uNum))

local len=#self.showDatas
self.scrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.showDatas[i]
item:SetChildActive(_item_index.select,false)
local newbieName=FMT.fmt('UIAquariumManagerWin.#ScrollView.Item_{0}',i)
item:SetChildNewBieComponentId(-1,newbieName)
if i<=uNum then
if data.fish then
item:SetChildActive(_item_index.icon,true)
item:SetChildActive(_item_index.add,false)
item:SetChildActive(_item_index.suo,false)
item:SetChildIcon(_item_index.icon,itemsModel.getIconName(data.fish),true)
local cfg=itemsConfig.getConfig(data.fish.itemid)
local ly=UIAquariumControl:countFishLingYun(data.fish,cfg)
item:SetChildText(_item_index.text,FMT.fmt('<color=#171311>{0}</color>\n灵韵 <color=#ca631d>+{1}</color>',cfg.name,ly))
else
item:SetChildActive(_item_index.icon,false)
item:SetChildActive(_item_index.add,true)
item:SetChildActive(_item_index.suo,false)
item:SetChildText(_item_index.text,'请投入鱼种')
end
else
item:SetChildActive(_item_index.icon,false)
item:SetChildActive(_item_index.add,false)
item:SetChildActive(_item_index.suo,true)
if data.stype==4 then
local cost=self:getUnlockCost(ftype)
local mname=moneyModel.getMoneyName(cost[1])
item:SetChildText(_item_index.text,FMT.fmt('花费\n<color=#ca631d>{0}{1}</color>开启',cost[2],mname))
elseif data.stype==3 then
item:SetChildText(_item_index.text,FMT.fmt('跃龙池\n<color=#ca631d>{0}级</color>开启',sdata.ulevel))
end
end
end
end


function UIAquariumManagerWin:onHide()

end

function UIAquariumManagerWin:showDialog(content,callback)
local comfirmDialog=UIDialogManager.getConfirmDialog(nil,nil,content,nil,nil,callback)
comfirmDialog:show()
end



function UIAquariumManagerWin:onSellBtn()
local data=self.showDatas[self.currSelect+1]
local fish=data.fish
local cfg=itemsConfig.getConfig(fish.itemid)
self:showDialog(FMT.fmt('是否出售{0}？',cfg.name),function()
UIAquariumControl:reqDelivery(fish.itemguid,int64.new('0'))
UIAquariumControl:reqDeal(1,{{fish.itemguid,1}})
self.infoPanel:setActive(false)
end)
end

function UIAquariumManagerWin:onReplaceBtn()
self:openSelectWin(self.currSelect)
end

function UIAquariumManagerWin:onChangePosBtn()
local data=self.showDatas[self.currSelect+1]
local fish=data.fish
UIManager:callWindowFunc('UIAquariumWin','moveDecoration',fish)
self:onCloseBtn()
end

function UIAquariumManagerWin:onCloseBtn()
self:closeSelf()
end