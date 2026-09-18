







def_class("UIDaoBingChongZhiWin",UIWindowBase)









function UIDaoBingChongZhiWin:bindComponents()

self.closeButton=UIButton.get(self,0)
self.title=UIText.get(self,1)
self.rewardPanel=UIObject.get(self,2)
self.chongzhiBtn=UIButton.get(self,3)
self.cost=UIText.get(self,4)
self.costicon=UIObject.get(self,5)
self.frame=UIButton.get(self,6)
self.introductiontxt=UIText.get(self,7)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIDaoBingChongZhiWin")end)

self.chongzhiBtn:setButtonClick(function()self:onChongzhiBtn()end)

self.frame:setButtonClick(function()self:onFrame()end)



end


function UIDaoBingChongZhiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
_UIObject_release(self.chongzhiBtn);self.chongzhiBtn=nil;
_UIObject_release(self.cost);self.cost=nil;
_UIObject_release(self.costicon);self.costicon=nil;
_UIObject_release(self.frame);self.frame=nil;
_UIObject_release(self.introductiontxt);self.introductiontxt=nil;
end



















local _this=nil

function UIDaoBingChongZhiWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDaoBingChongZhiWin:__delete()
self:unbindComponents()
_this=nil
end




function UIDaoBingChongZhiWin:onShow(argtable,afterOnloaded)









self.itemguid=argtable[1]
self.diziguid=argtable[2]
local equip=nil
if self.diziguid then
equip=daobingModel:getEquipByDizi(self.diziguid)
else
equip=equipsHelper.getEquip(self.itemguid)
end


if equip~=nil then
local itemid=equip.itemid
end
self:ShowReward(equip)


local reset=daobingConfig.getCommonConfig().reset
local consumeMoneyId=reset[2][1][1]
local consumeCount=reset[2][1][2]
local moneyIconName=iconHelper.getIconName(consumeMoneyId)
local hasNum=itemsModel.getCount(consumeMoneyId)
local color=hasNum>=consumeCount and FONT_COLOR.eNomalBlackColor or FONT_COLOR.eRedColor
self.cost:setText(toColorString(color,consumeCount))
self.costicon:setChildIcon(moneyIconName,false)






end

function UIDaoBingChongZhiWin:findUpStar(starlv,itemData,itemConfig)


local bentinum=0

local rewardtb={}
if starlv>0 then
for i=0,starlv-1 do
bentinum=bentinum+daobingConfig.getCostBenTiNum(i)
end

bentinum=bentinum-itemData.num


local starcfg=itemConfig.star

for i=0,starlv-1 do

local cfg=starcfg[i]
local costcfg=cfg[1]
for i,v in pairs(costcfg)do
if rewardtb[v[1]]then
rewardtb[v[1]]=rewardtb[v[1]]+v[2]
else
rewardtb[v[1]]=v[2]
end
end
end
end
return bentinum,rewardtb
end

function UIDaoBingChongZhiWin:findJLreward(itemData,itemConfig,rewardtb)

local jinglianlv=itemData.jinglianlv
if jinglianlv>0 then
for i=0,jinglianlv-1 do
local jlcfg=itemConfig.jinglian[i]
local jlreward_cfg=jlcfg[1]
for k,v in ipairs(jlreward_cfg)do
if rewardtb[v[1]]then
rewardtb[v[1]]=rewardtb[v[1]]+v[2]
else
rewardtb[v[1]]=v[2]
end
end
end
end
return rewardtb
end

function UIDaoBingChongZhiWin:ShowReward(equip)
if equip==nil then
return
end
local equipitemid=equip.itemid
local itemData=equip.itemData
local starlv=itemData.star
local itemConfig=itemsConfig.getConfig(equipitemid)
local str=FMT.fmt("重置后，道兵<color=#ca631d>{0}</color>的精炼等级、升星数将变更为<color=#ca631d>初始状态</color>。\n<color=#ca631d>{1}</color>精炼、升星时消耗的<color=#549327>100%</color>返还<color=#ca631d>（小于1万的玄铁无法折算返还）</color>",itemConfig.name,itemConfig.name)
self.introductiontxt:setText(str)

local bentinum,rewardtb=self:findUpStar(starlv,itemData,itemConfig)

rewardtb=self:findJLreward(itemData,itemConfig,rewardtb)
local paixutable={}
for k,v in pairs(rewardtb)do
paixutable[#paixutable+1]={k,v}
end

table.sort(paixutable,function(a,b)

if not itemsConfig.isMoney(a[1])and not itemsConfig.isMoney(b[1])then
local colora=itemsConfig.getConfig(a[1]).color
local colorb=itemsConfig.getConfig(b[1]).color
return colora>colorb
elseif not itemsConfig.isMoney(a[1])and itemsConfig.isMoney(b[1])then
return true
elseif itemsConfig.isMoney(a[1])and not itemsConfig.isMoney(b[1])then
return false
else
return true
end

end)


local reset=daobingConfig.getCommonConfig().reset
local xiangzitable={}

for k,v in ipairs(paixutable)do

if itemsConfig.isMoney(v[1])then
local num=v[2]

for k1,v1 in pairs(reset[1])do

if k1==v[1]then

xiangzitable[k1]={}

for k2,v2 in ipairs(v1)do


for i=num,v2[1],-v2[2]do

num=num-v2[2]
if num>=0 then
if not xiangzitable[k1][k2]then

xiangzitable[k1][k2]={v2[3][1],0}
end
xiangzitable[k1][k2][2]=xiangzitable[k1][k2][2]+v2[3][2]
end
end

end

end
end
end
end

for i=1,#paixutable do

if itemsConfig.isMoney(paixutable[i][1])then
table.remove(paixutable,i)
i=i-1
end
end

for k1,v1 in pairs(xiangzitable)do
for k2,v2 in pairs(xiangzitable[k1])do
table.insert(paixutable,v2)
end
end




local rnum=bentinum+itemData.num+#paixutable
self.rewardPanel:setChildLayoutGroupCreateItems(rnum)
local grids=self.rewardPanel:getChildLayoutGroupGridList()
local rewards=paixutable

for i=1,rnum do
local rwItem=grids[i-1]
local itemid=nil
local itemnum=nil
if i<=bentinum+itemData.num then
if i<=bentinum then
itemid=equipitemid
itemnum=1
else
itemid=daobingConfig.getCommonConfig().common[itemConfig.color]
if not itemid then
logErr("缺少道兵本源的配置",itemConfig.color)
end
itemnum=1
end

else
itemid=rewards[i-bentinum-itemData.num][1]
itemnum=rewards[i-bentinum-itemData.num][2]
end


local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(0,prop)
rwItem:SetChildActive(0,true)
rwItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

end

end

function UIDaoBingChongZhiWin:onHide()

end

function UIDaoBingChongZhiWin:onClickItem(itemId,index,guid,attach)

tipsManager.showTips({itemid=itemId,itemguid=nil,})
end



function UIDaoBingChongZhiWin:onChongzhiBtn()
if _this==nil then
return
end
local reset=daobingConfig.getCommonConfig().reset
local consumeMoneyId=reset[2][1][1]
local consumeCount=reset[2][1][2]
local hasNum=itemsModel.getCount(consumeMoneyId)

if hasNum>=consumeCount then
daobingController.reqResetDaoBing(_this.itemguid)
self:onFrame()
else
local itemguid=_this.itemguid
local cb=function(...)
daobingController.reqResetDaoBing(itemguid)
if _this==nil then return end
_this:onFrame()
end
moneySystem:useMoney(consumeMoneyId,consumeCount,cb,WARNING_TYPE.eWarning)
end


end


function UIDaoBingChongZhiWin:onFrame()
UIManager:closeWindow("UIDaoBingChongZhiWin")
end



