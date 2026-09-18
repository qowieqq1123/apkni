







def_class("UITaiXuCangWin",UIWindowBase)









function UITaiXuCangWin:bindComponents()

self.battleLogBtn=UIButton.get(self,0)
self.bdLevel=UIText.get(self,1)
self.chuliang=UIText.get(self,2)
self.jiangli=UIButton.get(self,3)
self.jiangliButton=UIButton.get(self,4)
self.level=UIText.get(self,5)
self.levelUpBtn=UIButton.get(self,6)
self.levelUpBtnText=UIText.get(self,7)
self.moneyName=UIText.get(self,8)
self.moneyPanel=UIButton.get(self,9)
self.moneyRoot=UIObject.get(self,10)
self.moneyTips_1=UIText.get(self,11)
self.moneyTips_2=UIText.get(self,12)
self.moneyTips_3=UIText.get(self,13)
self.mutiaoScroller=UIObject.get(self,14)
self.nextLevel=UIText.get(self,15)
self.num=UIText.get(self,16)
self.root=UIObject.get(self,17)
self.scrollview=UIObject.get(self,18)
self.shouquButton=UIButton.get(self,19)
self.shouquRed=UIObject.get(self,20)
self.time=UIText.get(self,21)
self.timebg=UIObject.get(self,22)

self.battleLogBtn:setButtonClick(function()self:onBattleLogBtn()end)

self.jiangli:setButtonClick(function()self:onJiangli()end)

self.jiangliButton:setButtonClick(function()self:onJiangliButton()end)

self.levelUpBtn:setButtonClick(function()self:onLevelUpBtn()end)

self.moneyPanel:setButtonClick(function()self:onMoneyPanel()end)

self.shouquButton:setButtonClick(function()self:onShouquButton()end)
self.moneyTips={
self.moneyTips_1,
self.moneyTips_2,
self.moneyTips_3,
}



end


function UITaiXuCangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.battleLogBtn);self.battleLogBtn=nil;
_UIObject_release(self.bdLevel);self.bdLevel=nil;
_UIObject_release(self.chuliang);self.chuliang=nil;
_UIObject_release(self.jiangli);self.jiangli=nil;
_UIObject_release(self.jiangliButton);self.jiangliButton=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.levelUpBtn);self.levelUpBtn=nil;
_UIObject_release(self.levelUpBtnText);self.levelUpBtnText=nil;
_UIObject_release(self.moneyName);self.moneyName=nil;
_UIObject_release(self.moneyPanel);self.moneyPanel=nil;
_UIObject_release(self.moneyRoot);self.moneyRoot=nil;
_UIObject_release(self.moneyTips_1);self.moneyTips_1=nil;
_UIObject_release(self.moneyTips_2);self.moneyTips_2=nil;
_UIObject_release(self.moneyTips_3);self.moneyTips_3=nil;
_UIObject_release(self.mutiaoScroller);self.mutiaoScroller=nil;
_UIObject_release(self.nextLevel);self.nextLevel=nil;
_UIObject_release(self.num);self.num=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.shouquButton);self.shouquButton=nil;
_UIObject_release(self.shouquRed);self.shouquRed=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.timebg);self.timebg=nil;
self.moneyTips=nil;
end



















function UITaiXuCangWin:onLoaded(...)
self:bindComponents()
self.maxNum=TaiXuCangModel:getMax()


self.on_building_event=function(etype,sfId,bdId,arg1,arg2)
if etype==buildingEvent.levelUpComplete then
local data=zongmenModel:getBuildingData(bdId)
if self.bdData and self.bdData.un_build_id==bdId then
self.bdData=data
self.bdLevel:setText(FMT.fmt("{0}级太虚仓",self.bdData.level))
if self:isMaxLevel(data)then
self.levelUpBtnText:setText("建筑信息")
else
self.levelUpBtnText:setText("建筑升级")
end
self:refreshLeft()
end
end
end
self:addNotify(notifyConfig.building_event,self.on_building_event)

end

function UITaiXuCangWin:isMaxLevel(bdData)
return cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)==nil
end


function UITaiXuCangWin:__delete()
self:unbindComponents()
end




function UITaiXuCangWin:onShow(argtable,afterOnloaded)
self.bdData=argtable.bdData or TaiXuCangModel:getBuildingData()

self:refreshRight()

if self.bdData then
self.bdLevel:setText(FMT.fmt("{0}级太虚仓",self.bdData.level))
if self:isMaxLevel(self.bdData)then
self.levelUpBtnText:setText("建筑信息")
else
self.levelUpBtnText:setText("建筑升级")
end
end

self:refreshLeft()
end





function UITaiXuCangWin:onHide()

end

function UITaiXuCangWin:onRecv()
self:refreshRight()
end

local abName="ui/windows/taixucang/taixucang_atlas_pak.ab"
local bgName={"image_taixucang_6","image_taixucang_7"}
local colorName={"#ca631d","#c82c2c"}
local rect=252
function UITaiXuCangWin:refreshLeft()
local level=self.bdData.level
local cfg=cfgHelper.get(cfg_taixucangconfig_get,level)
local protect=cfg.protect
local list={}
local val
for m,v in pairs(protect)do
local total=math.floor(v+v*TaiXuCangModel:getProtectAdd(m)/100)
table.insert(list,{m,total})
if not val then
val=total
end
end

local nextcfg=cfgHelper.get(cfg_taixucangconfig_get,level+1)
if nextcfg then
local protectN=nextcfg.protect
local k,valN=next(protectN)
if k then
local addN=TaiXuCangModel:getProtectAdd(k)
if addN then
valN=math.floor(valN+valN*addN/100)
end
end
self.nextLevel:setText(FMT.fmt("升至{0}级资源保护+{1}",level+1,valN-val))
else
self.nextLevel:setText(FMT.fmt("当前保护容量{0}",val))
end

self.scrollview:setChildScrollViewCreateGrids(#list,1)
self.grids=self.scrollview:getChildScrollViewItemWidgets()
local count=self.grids.Count
for i=1,count do
local grid=self.grids[i-1]
local data=list[i]
local itemid=data[1]
local money=moneyModel.getMoney(itemid)
local protect=data[2]

grid:SetChildCSImageSprite(-1,abName,bgName[i])

grid:SetChildIcon(0,iconHelper.getIconName(itemid),false)
grid:SetChildText(1,FMT.cfmt2(colorName[i],itemsConfig.getItemName(itemid)))
grid:SetChildText(2,money)



local r=1
if money>protect then
r=protect/money
end


grid:SetChildProgress(3,r*100,100)

grid:SetChildLocalPosX(6,rect*(r))

grid:SetChildButtonClick(8,function()
self:openMoneyPanel(itemid,protect)
end)
grid:SetChildButtonClick(7,function()
itemsComponentHelper.onItemClick(itemid)
end)
grid:SetChildButtonClick(-1,function()
self:openMoneyPanel(itemid,protect)
end)
end
end

function UITaiXuCangWin:refreshRight()
local leftTime=TaiXuCangModel:getLeftTime()
if leftTime>0 then
self.time:setActive(true)
self.time:setText(timeHelper.format_time_stamp2(leftTime))
self.timebg:setActive(true)
self:startLeftTimer()
else
self.time:setActive(false)
self.timebg:setActive(false)
end

local num=TaiXuCangModel:getNum()
self.num:setText(num)
if num==self.maxNum then
self.chuliang:setText(FMT.fmt("储量：<color=#549327>{0}/{1}</color>",num,self.maxNum))
else
self.chuliang:setText(FMT.fmt("储量：{0}/{1}",num,self.maxNum))
end



self.shouquRed:setActive(num>0 and zongmenModel:getBDFlagType(self.bdData.flag)==bdFlagType.normal)
end


function UITaiXuCangWin:startLeftTimer()
self.timerid=self:setTimer(1,-1,function()
local leftTime=TaiXuCangModel:getLeftTime()
if leftTime>0 then
self.time:setText(timeHelper.format_time_stamp2(leftTime))
else
local num=TaiXuCangModel:getNum()
self.num:setText(num)
self.shouquRed:setActive(num>0)
if num==self.maxNum then
self.chuliang:setText(FMT.fmt("储量：<color=#549327>{0}/{1}</color>",num,self.maxNum))
else
self.chuliang:setText(FMT.fmt("储量：{0}/{1}",num,self.maxNum))
end
if leftTime<0 then
self.time:setActive(false)
self.timebg:setActive(false)
if self.timeid then
self:stopTimerByID(self.timeid)
self.timerid=nil
end
end
end
end)
end

function UITaiXuCangWin:openMoneyPanel(id,protect)
self.moneyPanel:setActive(true)
self.moneyName:setText(itemsConfig.getItemName(id))
self.moneyTips_1:setActive(true)
local money=moneyModel.getMoney(id)
self.moneyTips_1:setText(FMT.fmt("<color=#ffffff00>--</color>受保护资源：{0}",money>protect and protect or money))
self.moneyTips_2:setActive(true)
self.moneyTips_2:setText(FMT.fmt("<color=#ffffff00>--</color>非保护资源：{0}",money>protect and money-protect or 0))
self.moneyTips_3:setActive(true)
self.moneyTips_3:setText("太虚仓的禁制可以保护部分储存的资源，使其在宗门失陷时不会丢失")
end




function UITaiXuCangWin:onJiangliButton()
local level=self.bdData.level
local cfg=cfgHelper.get(cfg_taixucangconfig_get,level)
self:showWindow("UITaiXuCangRewardWin",cfg.dropid)
end

function UITaiXuCangWin:onJiangli()
self:onJiangliButton()
end



function UITaiXuCangWin:onShouquButton()
if not TaiXuCangModel:checkGetItem()then
UIManager.error("军备正在运送中")
return
end
if zongmenModel:getBDFlagType(self.bdData.flag)~=bdFlagType.normal then
UIManager.error("太虚仓升级中，非施工人员请勿靠近")
return
end
TaiXuCangController:send_6_142()
end

function UITaiXuCangWin:onLevelUpBtn()
UIManager:showWindow("UIXJBuildingInfoWin",self.bdData)
end

function UITaiXuCangWin:onMoneyPanel()
self.moneyPanel:setActive(false)
end

function UITaiXuCangWin:onBattleLogBtn()
self:showWindow("UITaiXuCangbattleLogWin")
end
