







def_class("UIDialougeRongLian",UIWindowBase)









function UIDialougeRongLian:bindComponents()

self.cancelButton=UIButton.get(self,0)
self.cancelText=UIText.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.okButton=UIButton.get(self,3)
self.okText=UIText.get(self,4)
self.rewardview=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.tip=UIText.get(self,7)
self.titleText=UIText.get(self,8)

self.cancelButton:setButtonClick(function()self:onCancelButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.okButton:setButtonClick(function()self:onOkButton()end)



end


function UIDialougeRongLian:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.cancelButton);self.cancelButton=nil;
_UIObject_release(self.cancelText);self.cancelText=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.okButton);self.okButton=nil;
_UIObject_release(self.okText);self.okText=nil;
_UIObject_release(self.rewardview);self.rewardview=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tip);self.tip=nil;
_UIObject_release(self.titleText);self.titleText=nil;
end



















function UIDialougeRongLian:onLoaded(...)
self:bindComponents()
end


function UIDialougeRongLian:__delete()
self:unbindComponents()
end




function UIDialougeRongLian:onShow(argtable,afterOnloaded)
self.showdata=argtable

self.itemInfoList=argtable.itemInfoList



self.title=argtable.title or"提示"
self.content=argtable.content or"祖师是否熔炼所选装备，熔炼装备可获得"
self.canceltextArg=argtable.cancelText or"取消"
self.oktextArg=argtable.oktext or"确认"
self.allowclickbg=argtable.allowclickbg



self.selectGUIDList={}
for index,itemInfo in pairs(self.itemInfoList)do
self.selectGUIDList[#self.selectGUIDList+1]=itemInfo.itemguid
end

self.titleText:setText(self.title)

self.cancelText:setText(self.canceltextArg)
self.okText:setText(self.oktextArg)

self:freshRlItems()
end


function UIDialougeRongLian:onHide()

end

function UIDialougeRongLian:calcuItems()
local selectGUIDList=self.selectGUIDList or{}
local rlitems={}
local xmlist={}
self.xmEquipList={}
local xmRandList={}
for _,itemguid in ipairs(selectGUIDList)do
local item=itemsModel.getItem(itemguid)
local items

items=equipsHelper.returnRonglianItems(item)
local xmEquipType=equipsHelper.getEquipXMTypebyItemid(item.itemid)
if xmEquipType>0 then
xmlist=self:calcuItems2(item,xmlist)
self:calcuItems4(item.itemid,xmRandList,xmEquipType)
end
self.xmEquipList[#self.xmEquipList+1]=item
rlitems=table.concatTableXX(rlitems,items)
end
local rrlitems={}
for i,v in ipairs(rlitems)do
if not itemsConfig.isMoney(v[1])then
rrlitems[#rrlitems+1]=v
end
end
local xxmlist={}
for i,v in pairs(xmlist)do
if not itemsConfig.isMoney(i)then
xxmlist[i]=v
end
end
return rrlitems,xxmlist,xmRandList
end

function UIDialougeRongLian:calcuItems2(item,xmlist)

local itemid=item.itemid
if item.itemData.ninglian_star>0 then
local ninglian_conf=equipsModel.getEquipXMNingLianCfg(itemid)
for index=1,item.itemData.ninglian_star do
if ninglian_conf[1]and ninglian_conf[index].cost then
local _cost=ninglian_conf[index].cost[1]
if _cost and _cost[1]then
local data=xmlist[_cost[1]]or{cur=0,min=0,max=0}
data.cur=data.cur+_cost[2]
xmlist[_cost[1]]=data
end
end
end
end
local fenjie_rand_reward=equipsModel.getEquipXMFenJie(itemid)
if fenjie_rand_reward and fenjie_rand_reward[3]then
local data=xmlist[fenjie_rand_reward[3]]or{cur=0,min=0,max=0}
data.min=data.min+fenjie_rand_reward[1]
data.max=data.max+fenjie_rand_reward[2]
xmlist[fenjie_rand_reward[3]]=data
end
return xmlist
end

function UIDialougeRongLian:calcuItems3(rlitems,xmlist)
local txmlist={}
if rlitems and xmlist then
local list={}
for k,v in ipairs(rlitems)do
local itemid=v[1]
if not xmlist[itemid]then
list[#list+1]=v
end
end
local temp
for k,v in pairs(xmlist)do
temp={k,2,xmflag=true,cur=v.cur,min=v.min,max=v.max}
txmlist[#txmlist+1]=temp
list[#list+1]=temp
end
return list,txmlist
else
return rlitems,txmlist
end
end

function UIDialougeRongLian:calcuItems4(itemid,xmRandList,xmEquipType)
local fenjie_rand_reward=equipsModel.getEquipXMFenJie(itemid)
if fenjie_rand_reward and fenjie_rand_reward[3]then
local temp=xmRandList[fenjie_rand_reward[3]]or{0,0,xmEquipType}

temp[1]=temp[1]+fenjie_rand_reward[1]
temp[2]=temp[2]+fenjie_rand_reward[2]

xmRandList[fenjie_rand_reward[3]]=temp
end
end

function UIDialougeRongLian:freshRlItems()
local rlitems,xmlist,xmRandList=self:calcuItems()
self.rlitems=rlitems
self.xmlist=xmlist
self.xmRandList=xmRandList
rlitems,xmlist=self:calcuItems3(rlitems,xmlist)

local content="祖师是否熔炼所选装备，熔炼装备可获得"
if#xmlist>0 then
table.sort(xmlist,function(a,b)return a[1]>b[1]end)
content="所选装备包含稀有的<color=#c82c2c>仙魔装备</color>分解会有概率获得"
local itemStr=""
local itemFmt="{0}~{1}个<color=#c82c2c>【{2}】</color>"
for index,data in ipairs(xmlist)do
itemStr=FMT.fmt(itemFmt,data.min,data.max,itemsConfig.getItemName(data[1]))
content=FMT.fmt("{0}{1}",content,itemStr)
end
end
self.tip:setText(content)

local len=#rlitems
self.rewardview:setChildScrollViewCreateGrids(len,len)
local grids=self.rewardview:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local info=rlitems[i]
local v=grids[i-1]
if info then
local itemid=info[1]
local num=info[2]
local specialflag=info.xmflag
if specialflag then
local countStr=xmRandList[itemid]==nil and"???"or string.format("%d~%d",xmRandList[itemid][1],xmRandList[itemid][2])
local conf={itemid=itemid,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
v:SetChildPropData(0,self:getSelectFillData(i,conf))
else
local showCountBG=num>1
local countStr=showCountBG and num or""
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
v:SetChildPropData(0,self:getSelectFillData(i,conf))
end
v:SetBaseItemClickEvent(0,function()
self.winlua:SetCanvasIndex(-1,8)
itemsComponentHelper.onItemClick(itemid)
end)
end
end
end

function UIDialougeRongLian:getSelectFillData(index,conf)
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
return prop
end





function UIDialougeRongLian:onCloseBtn()
local closecallback=self.showdata.closecallback
self.showdata:deleteSelf()
self:close()
if closecallback then
closecallback()
end
end



function UIDialougeRongLian:onCancelButton()
local cancelcallback=self.showdata.cancelcallback
self.showdata:deleteSelf()
self:close()
if cancelcallback then
cancelcallback()
end
end



function UIDialougeRongLian:onOkButton()




local okcallback=self.showdata.okcallback
local guidlist=self.selectGUIDList
local rlitemlist=self.rlitems

local nlEquipList={}

local tip
if next(self.xmlist)then
for itemid,data in pairs(self.xmlist)do
if data.cur>0 then
nlEquipList[#nlEquipList+1]={itemid=itemid,itemcount=data.cur}
end
end
if#nlEquipList>0 then
if#self.xmEquipList==1 then
local itemConfig=itemsConfig.getConfig(self.xmEquipList[1].itemid)
tip=FMT.fmt("当前仙魔装备<color={1}>【{0}】</color>已凝炼\n分解后将返还<color=#549327>100%</color>的凝炼材料\n是否执行？",itemConfig.name,FONT_COLOR_VAL[itemConfig.color])
else
tip=FMT.fmt("有仙魔装备已凝炼\n分解后将返还<color=#549327>100%</color>的凝炼材料\n是否执行？")
end
end
end

self.showdata:deleteSelf()
self:close()
if okcallback then
if#nlEquipList>0 then
local showdata=
{
type='UIDialougeBuyWithReward2',
title='提示',
tip=tip,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()okcallback(guidlist,rlitemlist)end,
showclosebtn=true,
itemlist=nlEquipList,
}
local comfirmDialog2=UIDialogManager.newDialog(showdata)
comfirmDialog2:show()
else
okcallback(guidlist,rlitemlist)
end
end
end
