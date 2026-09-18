







def_class("UISubAct_xianshichouka_showRewardWin",UIWindowBase)









function UISubAct_xianshichouka_showRewardWin:bindComponents()

self.title1Txt=UIText.get(self,0)
self.descTxt=UIText.get(self,1)
self.goods1Creater=UIObject.get(self,2)
self.goods2Creater=UIObject.get(self,3)
self.title2Txt=UIText.get(self,4)



end


function UISubAct_xianshichouka_showRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.title1Txt);self.title1Txt=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.goods1Creater);self.goods1Creater=nil;
_UIObject_release(self.goods2Creater);self.goods2Creater=nil;
_UIObject_release(self.title2Txt);self.title2Txt=nil;
end

















function UISubAct_xianshichouka_showRewardWin:onLoaded(...)
self:bindComponents()
end


function UISubAct_xianshichouka_showRewardWin:__delete()
self:unbindComponents()
end


function UISubAct_xianshichouka_showRewardWin:onHide()

end




function UISubAct_xianshichouka_showRewardWin:onShow(argtable,afterOnloaded)
self.actID=argtable.actID
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.myData=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)

local sub_cfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
local showReward=sub_cfg.showReward
local title1Str=""
if self.subType==SUB_ACTIVITY_TYPE.eXianShiChouKa_Role then
showReward=showReward[self.myData.period_idx]
title1Str=FMT.fmt('<color=#ca631d>{0}%</color>概率出以下天命弟子的其中一位',showReward[1][1][2])
elseif self.subType==SUB_ACTIVITY_TYPE.eXianJieQiYuan2 then
title1Str=FMT.fmt('从以下弟子中选择{0}名弟子加入仙缘寻访，抽卡时有{1}%概率获得选择的{0}名弟子其中之一',sub_cfg.select_num,showReward[1][1][2])
elseif self.subType==SUB_ACTIVITY_TYPE.eLotteryact8 then
if#sub_cfg.disciple>1 then
title1Str=FMT.fmt('<color=#ca631d>{0}%</color>概率出以下天命弟子的其中一位',showReward[1][1][2])
else
title1Str=FMT.fmt('<color=#ca631d>{0}%</color>概率出以下天命弟子',showReward[1][1][2])
end
else
title1Str=FMT.fmt('<color=#ca631d>{0}%</color>概率出以下天命弟子的其中一位',showReward[1][1][2])
end



local rewards1=showReward[1]
self.title1Txt:setText(title1Str)
local num=#rewards1
self.goods1Creater:setChildLayoutGroupCreateItems(num)
local grids1=self.goods1Creater:getChildLayoutGroupGridList()
for i=1,num do
local item=grids1[i-1]
local reward=rewards1[i]
local itemid=reward[1]
local dzData=UIDiscipleModel:getItemDiscipleDataByItemId(itemid)
local info=dzData.imageInfo

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(info)

modelParams.offset={0,9.5}
comHelper.setChildModelRawImageEx(0,item,modelParams,eHeadCenterType.eNone,1,false)

local abname,icon=UIDiscipleModel:getJobOrientationBigIcon(info.job,dzData.id)
item:SetChildCSImageSprite(2,abname,icon)

item:SetChildText(3,dzData.disciplename)

item:SetChildButtonClick(1,function()
self:onShowDZItem(itemid)
end)
end


local rewards2={}
if self.myData.equip_idx and self.myData.equip_idx>0 and sub_cfg.lottery_equip~=nil then
local piece=sub_cfg.lottery_equip[1][self.myData.equip_idx][1]
table.insert(rewards2,{piece,sub_cfg.lottery_equip[2]/100})
end
for i,v in ipairs(showReward[2])do
table.insert(rewards2,v)
end
self.title2Txt:setText('全部可能出现的道具')
local num=#rewards2
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
local showDesc=sub_cfg.showDesc
for i,v in ipairs(showDesc)do
if i==1 then
desc_str=v
else
desc_str=FMT.fmt('{0}\n{1}',desc_str,v)
end
end
self.descTxt:setText(desc_str)
end

function UISubAct_xianshichouka_showRewardWin:onShowDZItem(itemId)
UIRecruitControl:showItemDiscipleInfoByItemId2(itemId)
end

function UISubAct_xianshichouka_showRewardWin:onClickItem(itemId,index,guid,attach)
if itemId==-1 then
return
end
itemsComponentHelper.onItemClickEx(itemId)
end