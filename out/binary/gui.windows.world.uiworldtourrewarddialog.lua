







def_class("UIWorldTourRewardDialog",UIWindowBase)






local itemKid={
icon=0,
name=1,
list=2,
}


function UIWorldTourRewardDialog:bindComponents()

self.Content=UIObject.get(self,0)



end


function UIWorldTourRewardDialog:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Content);self.Content=nil;
end



















function UIWorldTourRewardDialog:onLoaded(...)
self:bindComponents()
end


function UIWorldTourRewardDialog:__delete()
self:unbindComponents()
self.data=nil
end




function UIWorldTourRewardDialog:onShow(argtable,afterOnloaded)
if argtable then
self.data=argtable

local cnt=#self.data
self.Content:setChildLayoutGroupCreateItems(cnt)
local itemConf={showname=false}
for i,v in ipairs(self.data)do
local tourId=v[1]
local disciple=v[2]
local rewards=v[3]
local item=self.Content:getChildLayoutGroupGridItem(i-1)




local modelParams=UIDiscipleModel:getDiscipleInsideModelInfo(disciple)
comHelper.setChildModelRawImageEx(itemKid.icon,item,modelParams,eHeadCenterType.eHead,0.6,false)

item:SetChildText(itemKid.name,UIDiscipleModel:getDiscipleName(disciple))
local rewardCnt=#rewards
item:SetChildLayoutGroupCreateItems(itemKid.list,rewardCnt)
for j,w in ipairs(rewards)do
local propData=itemsComponentHelper.getCommonFillData(w,itemConf)
local rewardItem=item:GetChildLayoutGroupGridItem(itemKid.list,j-1)
rewardItem:SetPropData(propData)
rewardItem:SetClickEvent(itemsComponentHelper.onItemClick)
end
end

end
end


function UIWorldTourRewardDialog:onHide()

end



function UIWorldTourRewardDialog:onClickRedo()
if self.data then
local temp={}
for i,v in ipairs(self.data)do
local pointCfg=cfgHelper.get1(cfg_worldtravelpointconfig_get,v[1])
local blockNum=worldBlockModel:getAreaStateCount(pointCfg.area,worldBlockModel.BLOCKSTATE.OPEN)
local costList=pointCfg.consume[blockNum]or{}
for j,w in ipairs(costList)do
temp[w[1]]=(temp[w[1]]or 0)+w[2]
end
end
local cost={}
for i,v in pairs(temp)do
table.insert(cost,{i,v})
end
local ret,moneyType=moneyModel.checkEnoughMoneyX(cost)
if not ret then
gainControl:showGainWin(moneyType)
return UIManager.error("消耗不足")
end

local discipleCheck={}
for i,v in ipairs(self.data)do
local check=discipleCheck[tostring(v[2])]
if not check then
discipleCheck[tostring(v[2])]=v[1]
if UIDiscipleModel:checkDZStateToDoSomething(v[2],eCheckDiscipleStateOpType.eYouLi,true)then
worldTourController:send_5_71(v[1],v[2])
end
else

end
end
end
self:closeSelf()
end

function UIWorldTourRewardDialog:onClickClose()
self:closeSelf()
end
