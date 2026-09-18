







def_class("UIHuanJingRewardWin",UIWindowBase)









function UIHuanJingRewardWin:bindComponents()

self.diban=UIObject.get(self,0)
self.baoXiang=UIObject.get(self,1)
self.scrollview=UIObject.get(self,2)
self.rwScrollView=UIObject.get(self,3)
self.receive=UIObject.get(self,4)
self.receiveBtn=UIButton.get(self,5)
self.rwTips=UIText.get(self,6)
self.icon=UIObject.get(self,7)

self.receiveBtn:setButtonClick(function()self:onReceiveBtn()end)



end


function UIHuanJingRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.diban);self.diban=nil;
_UIObject_release(self.baoXiang);self.baoXiang=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.receive);self.receive=nil;
_UIObject_release(self.receiveBtn);self.receiveBtn=nil;
_UIObject_release(self.rwTips);self.rwTips=nil;
_UIObject_release(self.icon);self.icon=nil;
end
















local _item_index={
title=0,
recv_btn=1,
wc_icon=2,
items={3,4,5,6},
recv_btn_text=7,
}




function UIHuanJingRewardWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)

end


function UIHuanJingRewardWin:__delete()
self:unbindComponents()
end




function UIHuanJingRewardWin:onShow(argtable,afterOnloaded)
self.receiveList={}
self:refresh()
end

function UIHuanJingRewardWin:refresh()
self:setLevelList()
self:setChapterReward()
end


function UIHuanJingRewardWin:onHide()

end

function UIHuanJingRewardWin:setChapterReward()
local datas=UIHuanJingControl:getChapterRewardData()
local clist={}
for k,v in pairs(datas)do
local state=UIHuanJingControl:getLevelReceiveState(v.level)
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
local lcfg=cfgHelper.get1(cfg_guanqianewconfig_get,id)














if lcfg.rw_image_name then
self.diban:setActive(true)
self.icon:setChildIcon(lcfg.rw_image_name,true)
self.baoXiang:setActive(false)
else
self.diban:setActive(false)
self.baoXiang:setActive(true)
end
















end

function UIHuanJingRewardWin:getLevelData()
local datas=UIHuanJingControl:getLevelRewardData()
local slist={}
local svd={[-1]=0,[0]=1,[1]=-1}
for k,v in pairs(datas)do
local state=UIHuanJingControl:getLevelReceiveState(k)
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

function UIHuanJingRewardWin:setLevelList()
local datas=self:getLevelData()
local len=#datas
self.scrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.scrollview:getChildScrollViewItemWidgets()
local count=grids.Count-1
for i=0,count do
local item=grids[i]
local data=datas[i+1]
local id=data.id
item:SetChildText(_item_index.title,UIHuanJingControl:getLevelName('完成层数关卡：',id))
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

function UIHuanJingRewardWin:setLevelReward(item,id)
local lcfg=cfgHelper.get1(cfg_guanqianewconfig_get,id)
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



function UIHuanJingRewardWin:receiveAll()
local idList={}
for k,v in pairs(self.receiveList)do
UIHuanJingControl:setLevelRewardCheck(k)
table.insert(idList,k)
end
UIHuanJingControl:reqLevelReward(#idList,idList)
self.receiveList={}
end

function UIHuanJingRewardWin:onReceiveBtn()

self:receiveAll()
end

function UIHuanJingRewardWin:onCloseClick()
self:closeSelf()
end