







def_class("UIFuBaoHBWin",UIWindowBase)









function UIFuBaoHBWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.comboBox=UIObject.get(self,1)
self.receiveBtn=UIButton.get(self,2)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)



end


function UIFuBaoHBWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.comboBox);self.comboBox=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
end
















local _this




function UIFuBaoHBWin:onLoaded(...)
self:bindComponents()

_this=self

self.comboBox:setChildComboBoxInit(self.on_combobox_change)

self.scrollview:setChildScrollViewInit(0.5,true,self.on_item_click,nil)
end


function UIFuBaoHBWin:__delete()
self:unbindComponents()

_this=nil
end

function UIFuBaoHBWin.on_item_click(clickNum,index)
local cfg=_this.datas[index+1]
local gotAll=UIFuLuFangModel:checkRateRewardGotAll(cfg.id)
if gotAll then
return
end
UIManager:showWindow('UIFuBaoPingJiRewardWin',cfg)
end

function UIFuBaoHBWin.on_combobox_change(index)
_this.selectState=_this.indexToState[index+1]
_this:refreshFuBaoList()
end




function UIFuBaoHBWin:onShow(argtable,afterOnloaded)
self:initSort()
end


function UIFuBaoHBWin:onHide()

end

function UIFuBaoHBWin:initSort()
self.option={
'所有',
'不可领取',
'可领取',
'已领取',
}
self.indexToState={-1,1,2,3}
self.comboBox:setChildComboBoxOption(0,self.option)
end

function UIFuBaoHBWin:getFuBaoDatas(state)
local cfgs=cfg_fulufangconfig()
local list={}
if state==-1 then
local clist={}
for i,v in ipairs(cfgs)do
local cdata={}
cdata.id=v.id
local flag=0
local check=UIFuLuFangModel:checkFuLuRateReward(v.id)
if check then
flag=-1
else
check=UIFuLuFangModel:checkRateRewardGotAll(v.id)
if check then
flag=1
end
end
cdata.flag=flag
cdata.data=v
table.insert(clist,cdata)
end
table.sort(clist,function(a,b)
if a.flag==b.flag then
return a.id<b.id
else
return a.flag<b.flag
end
end)
for i,v in ipairs(clist)do
table.insert(list,v.data)
end
elseif state==1 then
for i,v in ipairs(cfgs)do
local redot=UIFuLuFangModel:checkFuLuRateReward(v.id)
local gotAll=UIFuLuFangModel:checkRateRewardGotAll(v.id)
if not redot and not gotAll then
table.insert(list,v)
end
end
elseif state==2 then
for i,v in ipairs(cfgs)do
local redot=UIFuLuFangModel:checkFuLuRateReward(v.id)
if redot then
table.insert(list,v)
end
end
else
for i,v in ipairs(cfgs)do
local gotAll=UIFuLuFangModel:checkRateRewardGotAll(v.id)
if gotAll then
table.insert(list,v)
end
end
end
return list
end

function UIFuBaoHBWin:refreshFuBaoList()
self.datas=self:getFuBaoDatas(_this.selectState)
local len=#self.datas
self.scrollview:setChildScrollViewCreateGrids(len,2)

local haveReceive=false
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cfg=self.datas[i]








widgetHelper.setNormalRewardItem(item,0,{cfg.itemId,0,noClick=true})

item:SetChildText(1,cfg.name)
local level=UIFuLuFangModel:getRating(cfg.id)
local lcfg=cfgHelper.get1(cfg_fubaoratingconfig_get,level)
local rateName=lcfg and lcfg.name or''
item:SetChildText(2,FMT.fmt('当前：{0}',rateName))

local redot=UIFuLuFangModel:checkFuLuRateReward(cfg.id)
if redot then
haveReceive=true
end
local gotAll=UIFuLuFangModel:checkRateRewardGotAll(cfg.id)
item:SetChildActive(3,redot)
item:SetChildActive(4,gotAll)
end
self.receiveBtn:setButtonEnable(haveReceive,not haveReceive)
end




function UIFuBaoHBWin:onReceiveBtn()
for i,v in ipairs(self.datas)do

UIFullFuLuFangControl:reqReceiveFLLevelReward(v.id,0)
end
end

function UIFuBaoHBWin:onCloseClick()
self:closeSelf()
end