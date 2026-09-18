







def_class("UIWorldProgressWin",UIWindowBase)







function UIWorldProgressWin:bindComponents()

self.Background=UIButton.get(self,0)
self.ScrollView=UIScrollView.get(self,1)

self.Background:setButtonClick(function()self:onBackground()end)



end


function UIWorldProgressWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.Background);self.Background=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end














local itemKid={
background=0,
dragonBone=1,
progressBar=2,
getBtn=3,
getted=4,
tipsTx=5,
titleTx=6,
rewards={7,8,9},
progressBg=10,
fangdajing=11,
fangdajingTx=12,
}
local _sprite_ab="ui/windows/world/sharedtextures/dashijie_lilian_altas.ab"

local _this=nil




function UIWorldProgressWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onWorldAreaReward,self.onWorldAreaReward)
worldController:stopCameraControl()
end


function UIWorldProgressWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onWorldAreaReward,self.onWorldAreaReward)
worldController:resumeCameraControl()
end




function UIWorldProgressWin:onShow(argtable,afterOnloaded)
self:initData()
self:initScrollView()
end


function UIWorldProgressWin:onHide()

end





function UIWorldProgressWin:onBackground()
self:closeSelf()
end

function UIWorldProgressWin.onClickGet(id)
worldExperienceController:send_5_7(id)
end

function UIWorldProgressWin:initData()
self.data={}
for i,v in pairs(cfg_worldareaconfig())do
table.insert(self.data,v.id)
end
table.sort(self.data)
end

function UIWorldProgressWin:initScrollView()
self.ScrollView:freshGridsNum(#self.data,1,#self.data,false)
for i=1,#self.data do
local data=self.data[i]
local item=self.ScrollView:getGridObjectByindex(i-1)
self:initAreaItem(item,data)
end
end

function UIWorldProgressWin:freshAreaItemState(id)
for i,v in ipairs(self.data)do
if v==id then
local item=self.ScrollView:getGridObjectByindex(i-1)
self:setAreaItem(item,id)
break
end
end
end

function UIWorldProgressWin:initAreaItem(item,data)
local cfg=cfgHelper.get1(cfg_worldareaconfig_get,data)
item:SetChildText(itemKid.titleTx,cfg.name)


item:SetChildButtonClickWithID(itemKid.getBtn,self.onClickGet,data)
for i,v in ipairs(itemKid.rewards)do
local itemData=cfg.rewards[i]
local show=itemData~=nil
item:SetChildActive(v,show)
if show then
local conf={showname=false}
local item_data={itemid=itemData[1],itemcount=itemData[2]}
item:SetChildPropData(v,itemsComponentHelper.getCommonFillData(item_data,conf))
item:SetBaseItemClickEvent(v,itemsComponentHelper.onItemClick)
end
end

self:setAreaItem(item,data)
end

function UIWorldProgressWin:setAreaItem(item,data)
local cfg=cfgHelper.get1(cfg_worldareaconfig_get,data)
local progress=worldExperienceModel:getAreaProgress(data)
local reward=worldExperienceModel:getReward(data)
local lock=worldBlockModel:isAreaAllClose(data)
local finish=progress>=100

item:SetChildActive(itemKid.getBtn,not lock and finish and not reward)
item:SetChildActive(itemKid.getted,not lock and finish and reward)
item:SetChildActive(itemKid.progressBg,not lock and not finish)
item:SetChildCSImageSprite(itemKid.background,_sprite_ab,cfg.icon)
item:SetChildImageExGray(itemKid.background,lock)

if not lock and not finish then
local eWorld=worldExperienceModel:getCurrentWorld()
local task=nil
if eWorld==cfg.world then
task=worldExperienceModel:getTask()
end

item:SetChildProgress(itemKid.progressBar,progress,100)
item:SetChildProgressText(itemKid.progressBar,FMT.fmt("{0}%",progress))
item:SetChildActive(itemKid.dragonBone,task~=nil)

if not task then
item:SetChildText(itemKid.tipsTx,"待探索")
item:SetChildActive(itemKid.fangdajing,false)
item:SetChildActive(itemKid.fangdajingTx,false)
else
item:SetChildText(itemKid.tipsTx,"")
local disciple=task.disciples[1]
local modelParams=UIDiscipleModel:getDiscipleHeadModelInfo(disciple)
local bodyCfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelParams.body)
local scale=bodyCfg.uiScales and bodyCfg.uiScales[1]or 1
local moveAnimation=10
item:SetChildUIModelShowTarget(itemKid.dragonBone,modelParams.body,scale,modelParams.componets,moveAnimation)
item:SetChildUIModelShowFlipX(itemKid.dragonBone,true)
item:SetChildActive(itemKid.fangdajing,true)
item:SetChildActive(itemKid.fangdajingTx,true)
end
elseif lock then
item:SetChildText(itemKid.tipsTx,"尚未解锁")
item:SetChildActive(itemKid.fangdajing,false)
item:SetChildActive(itemKid.fangdajingTx,false)
else
item:SetChildText(itemKid.tipsTx,"")
item:SetChildActive(itemKid.fangdajing,false)
item:SetChildActive(itemKid.fangdajingTx,false)
end
end

function UIWorldProgressWin.onWorldAreaReward(area)
_this:freshAreaItemState(area)
end