







def_class("UIAquariumDeliveryWin",UIWindowBase)









function UIAquariumDeliveryWin:bindComponents()

self.deliveryBtn=UIButton.get(self,0)
self.filtelBtn=UIButton.get(self,1)
self.scrollView=UIObject.get(self,2)
self.texing_1=UIObject.get(self,3)
self.texing_2=UIObject.get(self,4)
self.texing_3=UIObject.get(self,5)

self.deliveryBtn:setButtonClick(function()self:onDeliveryBtn()end)

self.filtelBtn:setButtonClick(function()self:onFiltelBtn()end)
self.texing={
self.texing_1,
self.texing_2,
self.texing_3,
}



end


function UIAquariumDeliveryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.deliveryBtn);self.deliveryBtn=nil;
_UIObject_release(self.filtelBtn);self.filtelBtn=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.texing_1);self.texing_1=nil;
_UIObject_release(self.texing_2);self.texing_2=nil;
_UIObject_release(self.texing_3);self.texing_3=nil;
self.texing=nil;
end
















local _item_index=
{
icon=0,
name=1,
color=2,
attr=3,
select=4,
texing={5,6,7},
}




function UIAquariumDeliveryWin:onLoaded(...)
self:bindComponents()

self.abName='ui/windows/yiyuhuiyou/yyhyimage_atlas_pak.ab'

self.scrollView:setChildScrollViewInit(0.5,true,function(...)self:onItemCLick(...)end,nil)
end

function UIAquariumDeliveryWin:onItemCLick(num,index)
if self.currSelect then
local widget=self.scrollView:getChildScrollViewItemWidget(self.currSelect)
widget:SetChildActive(_item_index.select,false)
end
self.currSelect=index
local widget=self.scrollView:getChildScrollViewItemWidget(self.currSelect)
widget:SetChildActive(_item_index.select,true)
end


function UIAquariumDeliveryWin:__delete()
self.scrollView:setChildScrollViewStopGridCreate()

self:unbindComponents()
end

function UIAquariumDeliveryWin:getDatas(stype)
local items=UIAquariumControl:getFishItemsInBag({stype})

local list={}
for i,v in ipairs(items)do
local cfg=itemsConfig.getConfig(v.itemid)
if cfg.type1~=6 then
if UIAquariumControl:isOrnamentalFish(v)then
table.insert(list,{cfg,v})
end
else
table.insert(list,{cfg,v})
end
end
table.sort(list,function(a,b)
local c1=a[1]
local c2=b[1]
if c1.color>c2.color then
return true
elseif c1.color==c2.color then
return c1.id<c2.id
else
return false
end
end)
local rlist={}
for i,v in ipairs(list)do
table.insert(rlist,v[2])
end
return rlist
end


function UIAquariumDeliveryWin:FilterData()







if not self.selectlist or not next(self.selectlist)then
self.datas=table.weakCopy(self.Alldatas)
return
end
self.datas={}
for k,v in ipairs(self.Alldatas)do
local featureList=v.itemData.featureList
for k1,v1 in ipairs(featureList)do
if self.selectlist[v1]then
table.insert(self.datas,v)
break
end
end
end
end



function UIAquariumDeliveryWin:onShow(argtable,afterOnloaded)
local stype=argtable.ftype
self.fish=argtable.fish
self.ftype=stype
self.Alldatas=self:getDatas(stype)
self:FilterData()
self:refresh()
if#self.datas>0 then
self:onItemCLick(1,0)
end
end

function UIAquariumDeliveryWin:refresh()

local len=#self.datas
self.scrollView:setChildScrollViewDelayCreateGrids(len,2,0.02,2,false,false,function(index,item)
local id=index+1
local data=self.datas[id]
local cfg=itemsConfig.getConfig(data.itemid)
item:SetChildIcon(_item_index.icon,itemsModel.getIconName(data),true)
item:SetChildText(_item_index.name,cfg.name)
item:SetChildCSImageSprite(_item_index.color,self.abName,'image_cyhyyupj_'..cfg.color)


local ly=UIAquariumControl:countFishLingYun(data,cfg)
item:SetChildText(_item_index.attr,FMT.fmt('灵韵<color=#549327>+{0}</color>',ly))
item:SetChildActive(_item_index.select,false)
local txList=data.itemData.featureList
for i,v in ipairs(_item_index.texing)do
local tx=txList and txList[i]
if tx then
item:SetChildActive(v,true)
local widget=item:GetChildWidgetBase(v)
local txcfg=cfgHelper.get1(cfg_fishfeatureconfig_get,tx)
widget:SetChildText(1,txcfg.name)
widget:SetChildButtonClick(0,function()
UIAquariumControl:showSpecialityTips(tx,widget)
end)
else
item:SetChildActive(v,false)
end
end
end)
end


function UIAquariumDeliveryWin:onHide()

end





function UIAquariumDeliveryWin:onDeliveryBtn()
if not self.currSelect then
UIManager.info('鱼舱里没有观赏鱼啦~')
return
end
local data=self.datas[self.currSelect+1]
if self.ftype==6 and not self.fish then
UIManager:closeWindow('UIAquariumManagerWin')
UIManager:callWindowFunc('UIAquariumWin','toDecoration',data)
else
local currId=self.fish and self.fish.itemguid or int64.new('0')
UIAquariumControl:reqDelivery(currId,data.itemguid)
end
self:onCloseClick()
end


function UIAquariumDeliveryWin:onFiltelBtn()
local callback=function(selectlist)
self.selectlist=table.weakCopy(selectlist)
self:FilterData()
self:refresh()
end
UIManager:showWindow('UIAquariumFilterWin',{callback=callback,selectlist=self.selectlist})
end

function UIAquariumDeliveryWin:onCloseClick()
self:closeSelf()
end