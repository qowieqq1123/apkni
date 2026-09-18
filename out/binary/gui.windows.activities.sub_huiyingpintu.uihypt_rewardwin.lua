







def_class("UIHYPT_rewardWin",UIWindowBase)









function UIHYPT_rewardWin:bindComponents()

self.titleTxt=UIText.get(self,0)
self.tipsTxt=UIText.get(self,1)
self.noItemTips=UIText.get(self,2)
self.tipsTxt2=UIText.get(self,3)
self.tipIcon=UIImage.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.taskScroller=UIObject.get(self,6)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIHYPT_rewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.noItemTips);self.noItemTips=nil;
_UIObject_release(self.tipsTxt2);self.tipsTxt2=nil;
_UIObject_release(self.tipIcon);self.tipIcon=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.taskScroller);self.taskScroller=nil;
end

















local _this


function UIHYPT_rewardWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIHYPT_rewardWin:__delete()
self:unbindComponents()
end




function UIHYPT_rewardWin:onShow(argtable,afterOnloaded)

if argtable then
self.actID=argtable.actID
self.subType=argtable.subType
self.subid=argtable.subid
local mydata=activitiesModel:getSubActInfoData(_this.actID,_this.subType,_this.subid)
local puzzle_id=mydata.puzzle_id
local recvList=mydata.recvList
local cfg=cfg_paintedpuzzleactivityconfig_get(_this.subid)
local cfg_reward=cfg.debris[puzzle_id]
local new_rewardlist={}
local sever_reward={}
if recvList and#recvList>0 then
for k,v in ipairs(recvList)do
if v then
sever_reward[#sever_reward+1]=cfg_reward[v][1]
end
end
end


for k,v in ipairs(cfg_reward)do
local item_id=v[1][1]
local item_num=v[1][2]
if new_rewardlist[item_id]then
if new_rewardlist[item_id][item_num]then
new_rewardlist[item_id][item_num].all_num=new_rewardlist[item_id][item_num].all_num+1
else
new_rewardlist[item_id][item_num]={all_num=1,get_num=0}
end
else
new_rewardlist[item_id]={}
new_rewardlist[item_id][item_num]={all_num=1,get_num=0}
end
end


if#sever_reward>0 then
for k,v in ipairs(sever_reward)do
local itemid=v[1]
local itenum=v[2]
if new_rewardlist[itemid]and new_rewardlist[itemid][itenum]then
new_rewardlist[itemid][itenum].get_num=new_rewardlist[itemid][itenum].get_num+1
end
end
end


local new_rewardlist_two={}
for k,v in pairs(new_rewardlist)do
for i,j in pairs(v)do
new_rewardlist_two[#new_rewardlist_two+1]={itemid=k,itemnum=i,data=j}
end
end


table.sort(new_rewardlist_two,function(a,b)
local color_a=itemsConfig.getConfig(a.itemid).color
local color_b=itemsConfig.getConfig(b.itemid).color
return color_a>color_b
end)

self.taskScroller:setChildCanvasGroupAlpha(0)
self:delayDo(0.2,function()
self.taskScroller:setChildCanvasGroupDOFade(1,0.25,nil)
end)


local dataNum=#new_rewardlist_two
if dataNum<=0 then
self.taskScroller:setActive(false)
else
self.taskScroller:setActive(true)
self.taskScroller:setChildScrollViewCreateGrids(dataNum,1)
local grids=self.taskScroller:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
if item then
local item_id=new_rewardlist_two[i].itemid
local item_num=new_rewardlist_two[i].itemnum
local dataitem={item_id,item_num}
local item_data=new_rewardlist_two[i].data
local itemn_color=itemsConfig.getConfig(item_id).color
local itemn_name=itemsConfig.getConfig(item_id).name
local typename=itemsConfig.getConfig(item_id).typename
item:SetChildText(11,typename or"货币")
item:SetChildText(7,FMT.cfmt(itemn_color,'{0}',itemn_name))
local widget=item:GetChildWidgetBase(9)
widgetHelper.setNormalRewardItem(widget,-1,dataitem)
widget:SetChildButtonClick(14,function()
if _this==nil then return end
self:ontipsClick(item_id)
end)
local _color=item_data.get_num>=item_data.all_num and'FD9E6E'or'252220'
item:SetChildText(10,FMT.fmt('<color=#CA631D>可获得次数：{0}/{1}</color>',item_data.get_num,item_data.all_num))
end
end
end

end

end


function UIHYPT_rewardWin:onHide()

end





function UIHYPT_rewardWin:onCloseBtn()
self:closeSelf()
end



function UIHYPT_rewardWin:ontipsClick(itemId)
if not itemId or itemId==-1 then
return
end
tipsManager.showTips({itemid=itemId,itemguid=nil,showModel=true})
end



