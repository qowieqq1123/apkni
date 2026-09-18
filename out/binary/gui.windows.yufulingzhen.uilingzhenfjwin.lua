







def_class("UILingZhenFJWin",UIWindowBase)









function UILingZhenFJWin:bindComponents()

self.comboBoxColor=UIObject.get(self,0)
self.scrollview=UIObject.get(self,1)
self.fenjie=UIButton.get(self,2)
self.rewardItem=UIBaseItem.get(self,3)
self.label=UIText.get(self,4)
self.boxBtn=UIButton.get(self,5)

self.fenjie:setButtonClick(function()self:onFenjie()end)

self.boxBtn:setButtonClick(function()self:onBoxBtn()end)



end


function UILingZhenFJWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.comboBoxColor);self.comboBoxColor=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.fenjie);self.fenjie=nil;
_UIObject_release(self.rewardItem);self.rewardItem=nil;
_UIObject_release(self.label);self.label=nil;
_UIObject_release(self.boxBtn);self.boxBtn=nil;
end



















local _this


function UILingZhenFJWin:onLoaded(...)
self:bindComponents()
_this=self
self.selectList={}
local cfg=cfgHelper.get(cfg_yufulingzhenbaseconfig_get,1,"openLevel")
self.maxLevel=cfg or 15



self.scrollview:setChildScrollViewInit(0,false,self.on_item_click,self.on_item_long_touch)

self:addNotify(notifyConfig.on_item_lock_changed,self.onFuBaoLockChanged)

self.label:setText('灵阵筛选')
end


function UILingZhenFJWin:__delete()
self:unbindComponents()
end




function UILingZhenFJWin:onShow(argtable,afterOnloaded)
self:refreshItems()
end


function UILingZhenFJWin:onHide()

end


function UILingZhenFJWin:__delete()
self:unbindComponents()

_this=nil

end

function UILingZhenFJWin.onFuBaoLockChanged(itemid,itemguid,isUnlock)
local index=_this:getIndexByItemGuid(itemguid)
if not isUnlock then
_this.selectList[index]=nil
end
_this:setGridItemByIndex(index)
end

function UILingZhenFJWin.on_item_long_touch(clicknum,index)
local data=_this.items[index+1]
if data then
local itemId=_this.items[index+1].data.itemid
local guid=_this.items[index+1].data.itemguid
tipsManager.showTips({formType=TIPS_FORM_TYPE.eWatchItem,itemid=itemId,itemguid=guid})
end
end

function UILingZhenFJWin.on_item_click(clicknum,index)
local data=_this.items[index+1]
if data then
if UIYuFuLingZhenControl:getItemLock(data.data.itemguid)then
UIManager.error('该灵阵已锁定，不可分解')
else
_this:selectItem(index)
end
end
end

function UILingZhenFJWin:selectItem(index)
local item=_this.scrollview:getChildScrollViewItemWidget(index)
local isSelect=_this.selectList[index]
isSelect=not isSelect
_this.selectList[index]=isSelect
item:SetChildActive(1,isSelect)

self:checkShowReward()
end

function UILingZhenFJWin:refreshArgRecv()
self.scrollview:setChildScrollViewCreateGrids(0,0)
self:refreshItems(true)
end


function UILingZhenFJWin:setFilter(datas,levelSelect)
self.filterData=datas
levelSelect=levelSelect or-1
self.levelSelect=levelSelect
if levelSelect>self.maxLevel or levelSelect==-1 then
self.label:setText('灵阵筛选')
else
if levelSelect>1 then
self.label:setText(FMT.fmt("{0}级及以下",levelSelect))
else
self.label:setText(FMT.fmt("{0}级",levelSelect))
end
end
self:refreshItems()
end

function UILingZhenFJWin:checkFilter(level)
if self.filterData then
return level<=self.levelSelect
end
return false
end


function UILingZhenFJWin:getPageDatas()
local items=lingzhenBagModel:getBagItems()

local list={}
for i,v in ipairs(items)do
local cfg=itemsConfig.getConfig(v.itemid)
if cfg.type1==6 then
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

function UILingZhenFJWin:getIndexByItemGuid(itemguid)
local idStr=tostring(itemguid)
for i,v in ipairs(self.items)do
if tostring(v.itemguid)==idStr then
return i-1
end
end
end


function UILingZhenFJWin:refreshItems(notAuto)
self.selectList={}

self.items=self:getPageDatas()
if not notAuto then


if#self.items>0 then

for i=0,#self.items-1 do
local item=self.items[i+1]
local data=item.data
if not UIYuFuLingZhenControl:getItemLock(data.itemguid)then

local stage=_this.selectStage or 1
local color=_this.selectColor or 1
local itemConfig=itemsConfig.getConfig(data.itemid)
if self:checkFilter(itemConfig.level)then
self.selectList[i]=true
end
end
end

end
end
local showNum=#self.items<72 and 72 or#self.items

self.scrollview:setChildScrollViewDelayCreateGrids(showNum,0,0.02,12,false,false,function(index,item)
self:setGridItem(index,item)
end)
self:checkShowReward()
end

function UILingZhenFJWin:checkShowReward()
local show=false
for k,v in pairs(self.selectList)do
if v then
show=true
break
end
end
self.rewardItem:setActive(show)
if show then
local itemId,count=self:getRewardInfo()
local conf={itemid=itemId,itemcount=count}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
self.rewardItem:setChildPropData(prop)
self.rewardItem:setBaseItemClickEvent(function(itemid,index,guid,attach)
if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end)
end
end
function UILingZhenFJWin:getRewardInfo()
local itemid
local add=0
for k,v in pairs(self.selectList)do
if v then
local fbId=self.items[k+1].data.itemid
local config=itemsConfig.getConfig(fbId)
local decompose=config.fenjieItems
itemid=decompose[1][1]
local count=decompose[1][2]
add=add+count
end
end
return itemid,add
end


function UILingZhenFJWin:setGridItemByIndex(index)
local item=self.scrollview:getChildScrollViewItemWidget(index)
self:setGridItem(index,item)
end

function UILingZhenFJWin:setGridItem(index,item)
local d=self.items[index+1]
if d then
local data=d.data
local itemid=data.itemid

local isLock=UIYuFuLingZhenControl:getItemLock(data.itemguid)

local conf={itemid=itemid,showCountBG=false,showStage=true,gray=0}
if isLock then
conf.gray=mathHelper.setbit(conf.gray,eGrayType.eGray-1)
conf.gray=mathHelper.setbit(conf.gray,eGrayType.eLock-1)
end

local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetChildActive(1,self.selectList[index]or false)
end
end






function UILingZhenFJWin:onFenjie()
local list={}
local have2=false
for k,v in pairs(self.selectList)do
if v then
local guid=self.items[k+1].data.itemguid
if self.items[k+1].level>=2 then
have2=true
end
table.insert(list,guid)
end
end
local len=#list
if len>0 then

local tishiState=dialogueRepeatRemindModel.getRepeatVis(REPEAT_TIME_TYPE.eDay,REPEAT_TYPE.eFuLuDecomposeDialog)
if not tishiState and have2 then

local content='您选择的是高等级灵阵，是否继续分解？'
local okcallback=function(...)
UIYuFuLingZhenControl.req_2_109(list)
end
UIDialogManager.getConfirmDialog3(nil,content,okcallback,REPEAT_TYPE.eFuLuDecomposeDialog)
else
UIYuFuLingZhenControl.req_2_109(list)
end
else
UIManager.error('未选择需分解的灵阵')
return
end
end

function UILingZhenFJWin:onCloseClick()
self:closeSelf()
end

function UILingZhenFJWin:onBoxBtn()
local levelSelect=self.levelSelect or 0
UIManager:showWindow('UIYFLZFilterWin',{levelSelect=levelSelect>0 and levelSelect or nil,hideAll=true,selectCall=function(select,levelSelect)
self:setFilter(select,levelSelect)
end})
end



