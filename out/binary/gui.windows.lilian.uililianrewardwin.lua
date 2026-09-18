







def_class("UILiLianRewardWin",UIWindowBase)









function UILiLianRewardWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.rwScrollView=UIObject.get(self,1)
self.receive=UIObject.get(self,2)
self.receiveBtn=UIButton.get(self,3)
self.rwTips=UIText.get(self,4)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)



end


function UILiLianRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.receive);self.receive=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.rwTips);self.rwTips=nil;
end
















local _item_index={
title=0,
recv_btn=1,
wc_icon=2,
items={3,4,5,6},
recv_btn_text=7,
}




function UILiLianRewardWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UILiLianRewardWin:__delete()
self:unbindComponents()
end




function UILiLianRewardWin:onShow(argtable,afterOnloaded)
self.receiveList={}
self:refresh()
end

function UILiLianRewardWin:refresh()
self:setLevelList()
self:setChapterReward()
end


function UILiLianRewardWin:onHide()

end

function UILiLianRewardWin:setChapterReward()
local datas=UILiLianControl:getChapterRewardData()
local clist={}
for k,v in pairs(datas)do
local state=UILiLianControl:getLevelReceiveState(v.level)
if state==0 then
self.receiveList[v.level]=true
end
table_insert(clist,{data=v,state=state})
end

table.sort(clist,function(a,b)
return a.data.id<b.data.id
end)

local data
for i,v in ipairs(clist)do
data=v.data
if v.state~=1 then
break
end
end

local id=data.level
self.cwId=id
local lcfg=cfgHelper.get1(cfg_guanqiaconfig_get,id)
local rwId=lcfg.extra_rewards[1]
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems

local len=#rewards
self.rwScrollView:setChildScrollViewCreateGrids(len,math.min(len,4))
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count-1
for i=0,count do
local item=grids[i]
local rwdata=rewards[i+1]
widgetHelper.setNormalRewardItem(item,0,rwdata)
end

local state=UILiLianControl:getLevelReceiveState(id)
self.receive:setActive(state==1)
if state<1 then
local complete=UILiLianControl:isChapterComplete(data.id)
self.receiveBtn:setActive(complete)
if complete then
self.rwTips:setText('')
else
local curr,max=UILiLianControl:getChapterProgressRate(data.id)
self.rwTips:setText(FMT.fmt('完成第{0}章所有关卡\n<color=#7d3b17>({1}/{2})</color>',data.id,curr,max))
end
else
self.receiveBtn:setActive(false)
self.rwTips:setText('')
end
end

function UILiLianRewardWin:getLevelData()
local datas=UILiLianControl:getLevelRewardData()
local slist={}
local svd={[-1]=0,[0]=1,[1]=-1}
for k,v in pairs(datas)do
local state=UILiLianControl:getLevelReceiveState(k)
if state==0 then
self.receiveList[k]=true
end
table_insert(slist,{id=k,state=state,sv=svd[state]})
end
table.sort(slist,function(a,b)
if a.sv>b.sv then
return true
elseif a.sv==b.sv then
return a.id<b.id
else
return false
end
end)
return slist
end

function UILiLianRewardWin:setLevelList()
local datas=self:getLevelData()
local len=#datas
self.scrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count-1
for i=0,count do
local item=grids[i]
local data=datas[i+1]
local id=data.id
item:SetChildText(_item_index.title,UILiLianControl:getLevelName('完成章节关卡：',id))
self:setLevelReward(item,id)
local state=data.state
if state==1 then
item:SetChildActive(_item_index.wc_icon,true)
item:SetChildActive(_item_index.recv_btn,false)
elseif state==0 then
item:SetChildActive(_item_index.wc_icon,false)
item:SetChildActive(_item_index.recv_btn,true)
item:SetChildGraphicGray(_item_index.recv_btn,false)
item:SetChildButtonClick(_item_index.recv_btn,function()

self:receiveAll()
end)
item:SetChildText(_item_index.recv_btn_text,'领取奖励')
else
item:SetChildActive(_item_index.wc_icon,false)
item:SetChildActive(_item_index.recv_btn,true)
item:SetChildGraphicGray(_item_index.recv_btn,true)
item:SetChildButtonClick(_item_index.recv_btn,function()
UIManager.info('该关卡未完成')
end)
item:SetChildText(_item_index.recv_btn_text,'未完成')
end
end
end

function UILiLianRewardWin:setLevelReward(item,id)
local lcfg=cfgHelper.get1(cfg_guanqiaconfig_get,id)
local rwId=lcfg.extra_rewards[1]
local rwcfg=cfgHelper.get1(cfg_awardconfig_get,rwId)
local rewards=rwcfg.showItems
for i,v in ipairs(_item_index.items)do
local data=rewards[i]
if data then
item:SetChildActive(v,true)
widgetHelper.setNormalRewardItem(item,v,data)
else
item:SetChildActive(v,false)
end
end
end



function UILiLianRewardWin:receiveAll()
for k,v in pairs(self.receiveList)do
UILiLianControl:setLevelRewardCheck(k)
UILiLianControl:reqLevelReward(k)
end
self.receiveList={}
end

function UILiLianRewardWin:onReceiveBtn()

self:receiveAll()
end

function UILiLianRewardWin:onCloseClick()
self:closeSelf()
end