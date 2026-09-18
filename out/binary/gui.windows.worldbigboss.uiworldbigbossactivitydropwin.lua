







def_class("UIWorldBigBossActivityDropWin",UIWindowBase)









function UIWorldBigBossActivityDropWin:bindComponents()

self.ScrollView=UIScrollView.get(self,0)



end


function UIWorldBigBossActivityDropWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end



















function UIWorldBigBossActivityDropWin:onLoaded(...)
self:bindComponents()
end


function UIWorldBigBossActivityDropWin:__delete()
self:unbindComponents()
end




function UIWorldBigBossActivityDropWin:onShow(argtable,afterOnloaded)
if self.monsterIdx==argtable.monsterIdx and self.stageIdx==argtable.stageIdx then
return
end
self.monsterIdx=argtable.monsterIdx
self.stageIdx=argtable.stageIdx
local cfg=cfgHelper.get3(cfg_worldbossconfig_get,1,"monster",self.monsterIdx)
local rewardId=cfg[2]
local lvCfg=cfgHelper.get1(cfg_worldbosslevelconfig_get,self.stageIdx)
local level=lvCfg['2']
local rewardCfg=itemsAwardConfig:getAwardInConfigByLevel(rewardId,level)
local propDatas={}
local itemsList=rewardCfg.detailItems
table.sort(itemsList,function(a,b)
local itemida,itemidb
local isTeZhia,isTeZhib=false,false
local isGaiLva,isGaiLvb=false,false
if type(a)=='table'then
itemida=a[1]
itemidb=b[1]
isTeZhia=a[2]==-2
isGaiLva=a[2]==-1
isTeZhib=b[2]==-2
isGaiLvb=b[2]==-1
else
itemida=a
itemidb=b
end
local aConfig=itemsConfig.getConfig(itemida)
local bConfig=itemsConfig.getConfig(itemidb)


local aRareLv=itemsConfig.getRareLv(itemida)
local bRareLv=itemsConfig.getRareLv(itemidb)
local aScore=aRareLv*10000000+itemida
local bScore=bRareLv*10000000+itemidb

if not isGaiLva then
aScore=aScore+1000000
end
if not isGaiLvb then
bScore=bScore+1000000
end

aScore=aScore+aConfig.color*100000
bScore=bScore+bConfig.color*100000

if itemsConfig.isGubao(itemida)then
aScore=aScore+200000000
elseif not itemsConfig.isEquip(itemida)then
aScore=aScore+100000000
end

if itemsConfig.isGubao(itemidb)then
bScore=bScore+200000000
elseif not itemsConfig.isEquip(itemidb)then
bScore=bScore+100000000
end

return aScore>bScore
end)

for i,v in ipairs(itemsList)do
local itemid
local isTeZhi=false
local isGaiLv=false
if type(v)=='table'then
itemid=v[1]
isTeZhi=v[2]==-2
isGaiLv=v[2]==-1
else
itemid=v
end
local fillData=itemsComponentHelper.getCommonFillData({itemid=itemid},{showname=false,itemcount="",showStageBg=true})
fillData[PropIndex(DataPropKey.eWidgetActive,11)]=isGaiLv
fillData[PropIndex(DataPropKey.eWidgetActive,12)]=isTeZhi
table.insert(propDatas,fillData)
end
local count=#propDatas
self.colomn=12
self.row=math.ceil(count,self.colomn)
self.ScrollView:freshGridsNum(count,self.row,self.colomn,false)
self.ScrollView:initPropData(propDatas)
end


function UIWorldBigBossActivityDropWin:onHide()

end



