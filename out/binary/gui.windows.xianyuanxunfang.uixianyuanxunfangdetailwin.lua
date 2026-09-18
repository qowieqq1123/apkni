







def_class("UIXianYuanXunFangDetailWin",UIWindowBase)









function UIXianYuanXunFangDetailWin:bindComponents()

self.descTxt=UIText.get(self,0)
self.goods1Creater=UIObject.get(self,1)
self.goods2Creater=UIObject.get(self,2)
self.title1Txt=UIText.get(self,3)
self.title2Txt=UIText.get(self,4)



end


function UIXianYuanXunFangDetailWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.goods1Creater);self.goods1Creater=nil;
_UIObject_release(self.goods2Creater);self.goods2Creater=nil;
_UIObject_release(self.title1Txt);self.title1Txt=nil;
_UIObject_release(self.title2Txt);self.title2Txt=nil;
end

















function UIXianYuanXunFangDetailWin:onLoaded(...)
self:bindComponents()
end


function UIXianYuanXunFangDetailWin:__delete()
self:unbindComponents()
end


function UIXianYuanXunFangDetailWin:onHide()

end




function UIXianYuanXunFangDetailWin:onShow(argtable,afterOnloaded)
local myData=xianyuanxunfangModel:getData()

local items=myData.items
local num=#items
local mycfg=xianyuanxunfangModel:getCfg2()
local showReward=mycfg.showReward
local title1Str=""
if mycfg.select_num~=nil then
if num<=0 then
title1Str=FMT.fmt('从以下弟子中选择{0}名弟子加入仙缘寻访，抽卡时有{1}%概率获得选择的{0}名弟子其中之一',mycfg.select_num,showReward[1][1][2])
else
title1Str=FMT.fmt('<color=#ca631d>{0}%</color>概率出以下天命弟子的其中一位',showReward[1][1][2])
end
else
title1Str=FMT.fmt('<color=#ca631d>{0}%</color>概率出以下天命弟子的其中一位',showReward[1][1][2])
end

local lp={}
local openDay=timeHelper.getServerOpenDay()
for i,v in ipairs(mycfg.disciple)do
local itemid=v[1]
local openDay_=v[3]
local lerp=openDay_-openDay
if lerp<=0 then
lp[itemid]=true
end
end

local rewards1={}
if mycfg.select_num~=nil then
if num<=0 then
for i,v in ipairs(showReward[1])do
local itemid=v[1]
if lp[itemid]==true then
table.insert(rewards1,itemid)
end
end
else
for i,itemIdx in ipairs(items)do
local v=mycfg.disciple[itemIdx]
local itemid=v[1]
table.insert(rewards1,itemid)
end
end
else
for i,v in ipairs(showReward[1])do
local itemid=v[1]
if lp[itemid]==true then
table.insert(rewards1,itemid)
end
end
end
self.rewardList=rewards1
self.title1Txt:setText(title1Str)
num=#self.rewardList
self.goods1Creater:setChildLayoutGroupCreateItems(num)
local grids1=self.goods1Creater:getChildLayoutGroupGridList()
for i=1,num do
local item=grids1[i-1]
local itemid=self.rewardList[i]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemid)
local info=dzData.imageInfo

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)

modelParams.offset={0,9.5}
comHelper.setChildModelRawImageEx(0,item,modelParams,eHeadCenterType.eNone,1,false)

local abname,icon=UIDiscipleModel:getJobOrientationBigIcon(info.job,dzData.id)
item:SetChildCSImageSprite(2,abname,icon)

item:SetChildText(3,dzData.disciplename)

item:SetChildButtonClick(1,function()
self:onShowDZItem(i)
end)
end


local rewards2={}
if myData.equip_idx>0 and mycfg.lottery_equip~=nil then
local piece=mycfg.lottery_equip[1][myData.equip_idx][1]
table.insert(rewards2,{piece,mycfg.lottery_equip[2]/100})
end
local list
local day
for day_,v in pairs(showReward[2])do
if openDay>=day_ and(day==nil or day<day_)then
list=v
day=day_
end
end
if list~=nil then
for _,v in ipairs(list)do
table.insert(rewards2,v)
end
end
self.title2Txt:setText('全部可能出现的道具')
num=#rewards2
self.goods2Creater:setChildLayoutGroupCreateItems(num)
local grids2=self.goods2Creater:getChildLayoutGroupGridList()
for i=1,num do
local item=grids2[i-1]
local reward=rewards2[i]
local itemid=reward[1]
local rate=reward[2]
local name=FMT.fmt('{0}%',rate)
local conf={itemid=itemid,itemcount='',showCountBG=false,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetChildText(1,name)
item:SetBaseItemClickEvent(0,function(...)
self:onClickItem(...)
end)
end


local desc_str=''
local showDesc=mycfg.showDesc
for i,v in ipairs(showDesc)do
if i==1 then
desc_str=v
else
desc_str=FMT.fmt('{0}\n{1}',desc_str,v)
end
end
self.descTxt:setText(desc_str)
end

function UIXianYuanXunFangDetailWin:onShowDZItem(index)
local itemid=self.rewardList[index]
UIRecruitControl:showItemDiscipleInfoByItemId2(itemid)
end

function UIXianYuanXunFangDetailWin:onClickItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
itemsComponentHelper.onItemClickEx(itemId)
end