







def_class("UILingShouYSFitemWin",UIWindowBase)









function UILingShouYSFitemWin:bindComponents()

self.root=UIObject.get(self,0)
self.btnClose=UIButton.get(self,1)
self.wjhimg=UIObject.get(self,2)
self.taskScroller=UIObject.get(self,3)
self.tips=UIObject.get(self,4)

self.btnClose:setButtonClick(function()self:onBtnClose()end)



end


function UILingShouYSFitemWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.btnClose);self.btnClose=nil;
_UIObject_release(self.wjhimg);self.wjhimg=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
_UIObject_release(self.tips);self.tips=nil;
end
















local abname='ui/windows/xianyungang/yunzhouzhentu_atlas_pak.ab'
local _this
local itemidx=
{
itemself=0,
name=1,
desc=2,
baseitem=3,
cancelbtn=4,
gotobtn=5,
choosebtn=6,
}



function UILingShouYSFitemWin:onLoaded(...)
self:bindComponents()
_this=self
self.chooseItemid=0
self.chooseid=0
self.itemlist={}
end


function UILingShouYSFitemWin:__delete()
self:unbindComponents()
_this=nil
end

function UILingShouYSFitemWin:onClickRewardItem(itemId,index,guid,attach)

if itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=guid,move=TIPS_MOVE_POS.eCenter})
end

function UILingShouYSFitemWin:onChooseClickBtn(itemid)
yushoufangModel:setLSItemId(itemid)
UIManager.info('选择成功')
UIManager:invokeUIMethod("UILingShouYSFJiaoPeiWin","refreshSpeSlot")
self:closeSelf()
end

function UILingShouYSFitemWin:onCancelClickBtn(itemid)
yushoufangModel:clearLSItemId()
UIManager.info('取消成功')
self.chooseItemid=yushoufangModel:getLSItemId()
UIManager:invokeUIMethod("UILingShouYSFJiaoPeiWin","refreshSpeSlot")
self:freshbtnlist()
end

function UILingShouYSFitemWin:onGotoClickBtn(itemid)
gainControl:showGainWin(itemid)
end





function UILingShouYSFitemWin:onShow(argtable,afterOnloaded)
self.config=cfg_lingshoubabybasicconfig_get(1)
self.chooseItemid=yushoufangModel:getLSItemId()
self.itemUseNum=self.config.new_ls_cnt
self:freshlist()
end


function UILingShouYSFitemWin:onHide()

end

function UILingShouYSFitemWin:onBtnClose()
self:closeSelf()
end


function UILingShouYSFitemWin:sortlist()
self.itemlist={}
local ex_special_list=self.config.ex_special_list
for k,v in ipairs(ex_special_list)do
local itemid=v[1]
local bagcount=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local isnone=bagcount>=self.itemUseNum and 1 or 0
local ischoose=0
if self.chooseItemid==itemid then
ischoose=10000
end
local weight=k+isnone*1000+ischoose
table.insert(self.itemlist,{weight=weight,data=v})
end
if#self.itemlist>1 then
table.sort(self.itemlist,function(a,b)
return a.weight>b.weight
end)
end
end


function UILingShouYSFitemWin:freshlist()
self:sortlist()
local ex_special_list=self.itemlist
local dataNum=#ex_special_list
if dataNum<=0 then
_this.taskScroller:setActive(false)
_this.tips:setActive(true)
else
_this.tips:setActive(false)
_this.taskScroller:setActive(true)
_this.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local data=ex_special_list[i].data
local itemid=data[1]
local desc=data[2]
local itemConfig=itemsConfig.getConfig(itemid)
item:SetChildText(itemidx.name,itemConfig.name)
item:SetChildText(itemidx.desc,desc)

local bagcount=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
local itemNum=bagcount
local countStr=itemNum>=1 and mathHelper.formatNumber(itemNum)or 0
local showCountBG=true
local graynum=0



local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,gray=graynum,showStage=true,name='',}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(itemidx.baseitem,prop)
item:SetBaseItemClickEvent(itemidx.baseitem,function(...)
self:onClickRewardItem(...)
end)
if bagcount>=self.itemUseNum then
if self.chooseItemid==itemid then
item:SetChildActive(itemidx.choosebtn,false)
item:SetChildActive(itemidx.cancelbtn,true)
item:SetChildActive(itemidx.gotobtn,false)
else
item:SetChildActive(itemidx.choosebtn,true)
item:SetChildActive(itemidx.cancelbtn,false)
item:SetChildActive(itemidx.gotobtn,false)
end
else
item:SetChildActive(itemidx.choosebtn,false)
item:SetChildActive(itemidx.cancelbtn,false)
item:SetChildActive(itemidx.gotobtn,true)
end


item:SetChildButtonClick(itemidx.choosebtn,function()
if _this==nil then return end
_this:onChooseClickBtn(itemid)
end)

item:SetChildButtonClick(itemidx.cancelbtn,function()
if _this==nil then return end
_this:onCancelClickBtn(itemid)
end)

item:SetChildButtonClick(itemidx.gotobtn,function()
if _this==nil then return end
_this:onGotoClickBtn(itemid)
end)
end
end
end
end


function UILingShouYSFitemWin:freshbtnlist()
local ex_special_list=self.itemlist
local dataNum=#ex_special_list
if dataNum<=0 then
_this.taskScroller:setActive(false)
_this.tips:setActive(true)
else
_this.tips:setActive(false)
_this.taskScroller:setActive(true)
_this.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=_this.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local data=ex_special_list[i].data
local itemid=data[1]
local desc=data[2]
local itemConfig=itemsConfig.getConfig(itemid)
item:SetChildText(itemidx.name,itemConfig.name)
item:SetChildText(itemidx.desc,desc)

local bagcount=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if bagcount>=self.itemUseNum then
if self.chooseItemid==itemid then
item:SetChildActive(itemidx.choosebtn,false)
item:SetChildActive(itemidx.cancelbtn,true)
item:SetChildActive(itemidx.gotobtn,false)
else
item:SetChildActive(itemidx.choosebtn,true)
item:SetChildActive(itemidx.cancelbtn,false)
item:SetChildActive(itemidx.gotobtn,false)
end
else
item:SetChildActive(itemidx.choosebtn,false)
item:SetChildActive(itemidx.cancelbtn,false)
item:SetChildActive(itemidx.gotobtn,true)
end
end
end
end
end

