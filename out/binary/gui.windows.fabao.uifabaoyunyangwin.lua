







def_class("UIFabaoYunYangWin",UIWindowBase)









function UIFabaoYunYangWin:bindComponents()

self.btnTuPo=UIButton.get(self,0)
self.costItems=UIObject.get(self,1)
self.Scrollview=UIObject.get(self,2)
self.progressRoot=UIObject.get(self,3)
self.fbicon=UIButton.get(self,4)
self.btnup=UIButton.get(self,5)
self.attrRoot=UIObject.get(self,6)
self.lxlevel=UIText.get(self,7)
self.lxhelp=UIButton.get(self,8)
self.progressBar2=UIProgressBarAni.get(self,9)
self.addBtn=UIButton.get(self,10)
self.progress2Txt=UIText.get(self,11)
self.attrSlot_1=UIObject.get(self,12)
self.attrSlot_3=UIObject.get(self,13)
self.attrSlot_2=UIObject.get(self,14)
self.item_5=UIBaseItem.get(self,15)
self.item_1=UIBaseItem.get(self,16)
self.item_2=UIBaseItem.get(self,17)
self.item_3=UIBaseItem.get(self,18)
self.item_4=UIBaseItem.get(self,19)
self.desc=UIText.get(self,20)
self.upReddot=UIObject.get(self,21)
self.effect1=UIObject.get(self,22)
self.effect2=UIObject.get(self,23)
self.model=UIObject.get(self,24)

self.btnTuPo:setButtonClick(function()self:onBtnTuPo()end)

self.fbicon:setButtonClick(function()self:onFbicon()end)

self.btnup:setButtonClick(function()self:onBtnup()end)

self.lxhelp:setButtonClick(function()self:onLxhelp()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)
self.attrSlot={
self.attrSlot_1,
self.attrSlot_2,
self.attrSlot_3,
}
self.item={
self.item_1,
self.item_2,
self.item_3,
self.item_4,
self.item_5,
}



end


function UIFabaoYunYangWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnTuPo);self.btnTuPo=nil;
_UIObject_release(self.costItems);self.costItems=nil;
_UIObject_release(self.Scrollview);self.Scrollview=nil;
_UIObject_release(self.progressRoot);self.progressRoot=nil;
_UIObject_release(self.fbicon);self.fbicon=nil;
_UIObject_release(self.btnup);self.btnup=nil;
_UIObject_release(self.attrRoot);self.attrRoot=nil;
_UIObject_release(self.lxlevel);self.lxlevel=nil;
_UIObject_release(self.lxhelp);self.lxhelp=nil;
_UIObject_release(self.progressBar2);self.progressBar2=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.progress2Txt);self.progress2Txt=nil;
_UIObject_release(self.attrSlot_1);self.attrSlot_1=nil;
_UIObject_release(self.attrSlot_3);self.attrSlot_3=nil;
_UIObject_release(self.attrSlot_2);self.attrSlot_2=nil;
_UIObject_release(self.item_5);self.item_5=nil;
_UIObject_release(self.item_1);self.item_1=nil;
_UIObject_release(self.item_2);self.item_2=nil;
_UIObject_release(self.item_3);self.item_3=nil;
_UIObject_release(self.item_4);self.item_4=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.upReddot);self.upReddot=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.model);self.model=nil;
self.attrSlot=nil;
self.item=nil;
end

















local _colorEffect=
{
[eQualityColor.ePurple]=10261,
[eQualityColor.eOrange]=10262,
[eQualityColor.eRed]=10263,
}

function UIFabaoYunYangWin:onLoaded(...)
self:bindComponents()
self.Scrollview:setChildScrollViewInit(1,true,nil,nil)
local pos=self:getChildCanvas(-1)
self.defaultSortLayer=pos[1]
self.defaultSortOrder=pos[2]
self:addNotify(notifyConfig.on_item_list_changed,function()
self:freshUpReddot()
end)
end

function UIFabaoYunYangWin:__delete()
self:unbindComponents()
end

function UIFabaoYunYangWin:onShow(argtable,afterOnloaded)
self:freshFaBao(argtable)
end

function UIFabaoYunYangWin:freshFaBao(argtable)
local itemguid=argtable.itemguid
self.itemguid=itemguid
self.equip=fabaoHelper.getFabao(itemguid)
local equip=self.equip
self.dzguid=fabaoModel.getDiziguidByItemguid(itemguid)
self.isEquip=fabaoModel.isEquipedOnAnyDizi(itemguid)
self.model:setChildUIModelShowTarget(4092,1,{},eAnimationID.stand,false,false,0)
self:freshInfo()
self:startYunYangTimer()
end

function UIFabaoYunYangWin:onHide()
self:stopYunYangTimer()
self.model:setChildUIModelRemoveTarget()
self.effect1:setChildShowEffect(0,false)
self.effect2:setChildShowEffect(0,false)
self.fbicon:setActive(false)
self.costItems:setActive(false)
self.progressRoot:setActive(false)
end





function UIFabaoYunYangWin:onBtnTuPo()
self:reqUp()
end



function UIFabaoYunYangWin:onBtnup()
self:reqUp()
end



function UIFabaoYunYangWin:onLxhelp()
local d={}
d.title='灵性规则'
d.mode=3
d.name='fabao_lingxing_rule_%d'
UIManager:showWindow('UIRuleWin',d)
end



function UIFabaoYunYangWin:onFbicon()
local itemguid=self.equip.itemguid
tipsManager.showTips({itemguid=itemguid})
end

function UIFabaoYunYangWin:onAddBtn()
self:showBuyView(self.equip.itemguid)
end

function UIFabaoYunYangWin:freshInfo()
local equip=self.equip
local fbiconName=itemsModel.getIconName(equip)
self.fbicon:setActive(true)
self.fbicon:setChildIcon(fbiconName,false)

self:freshYunYang()
self:freshLxlv()
self:freshProgress()
self:freshCostItem()
self:freshAttr()
self:freshBtn()
self:freshEffect()
end

function UIFabaoYunYangWin:freshYunYang()
self.isYunYang=false
local equip=self.equip
local itemid=equip.itemid
local dzguid=fabaoModel.getDiziguidByItemguid(equip.itemguid)
self.isYunYang=dzguid and benMingFaBaoHelper.isAbsorbExp(dzguid)or false

self.effect1:setChildShowEffect(10260,true)

local color=itemsConfig.getConfig(itemid).color
self.effect2:setChildShowEffect(_colorEffect[color],true)
end

function UIFabaoYunYangWin:freshProgress()
local equip=self.equip
local itemguid=equip.itemguid
local lxlv=fabaoModel.getLingXingLv(itemguid)
local tupocost=fabaoConfig.getTuPoLxCost(lxlv)
local isTplv=tupocost~=nil
self.progressRoot:setActive(not isTplv)
local isMax=fabaoConfig.isLxMaxLv(lxlv)
if not isTplv then
local cur=fabaoModel.getFabaoLingXingExp(itemguid)
local need=fabaoConfig.getNeedLxExpByLx(lxlv)
self.progressBar2:animateThreeParams(cur,need,0)
self.progress2Txt:setText(not isMax and FMT.fmt('{0}/{1}',cur,need)or'等级已满')
end
end



function UIFabaoYunYangWin:freshLxlv()
local itemguid=self.equip.itemguid
local lxlv=fabaoModel.getLingXingLv(itemguid)
self.lxlevel:setText(FMT.fmt('灵性：{0}级',lxlv))
end

function UIFabaoYunYangWin:freshAttr()
local equip=self.equip
local itemguid=equip.itemguid
local isDress=fabaoHelper.isDressed(itemguid)
local mainid=fabaoHelper.getReallyMainId(equip)
local lxlv=fabaoModel.getLingXingLv(itemguid)
local lxCfg=fabaoConfig.getLxConfig(lxlv)
local nexlxlv=lxlv+1
local nextlxCfg=fabaoConfig.getLxConfig(nexlxlv,false)
local hasNext=nextlxCfg~=nil
local mainid=fabaoHelper.getReallyMainId(equip)
local attrs=benMingFaBaoHelper.getLxAttr(mainid,lxlv)or{}
local nextAttrs=hasNext and benMingFaBaoHelper.getLxAttr(mainid,nexlxlv)or{}
for i,v in ipairs(self.attrSlot)do
local widget=v:getWidgetBase()
local attr=attrs[i]
local has=attr~=nil
v:setActive(has)
if has then
local name,valstr=equipsHelper.getAttr(attr[1],attr[2])
widget:SetChildText(0,FMT.fmt('{0}：{1}',name,valstr))
widget:SetChildActive(1,hasNext)
if hasNext then
local nextAttr=nextAttrs[i]
local add=nextAttr[2]-attr[2]
local name,valstr=equipsHelper.getAttr(nextAttr[1],add)
widget:SetChildText(2,valstr)
end
end
end
end


function UIFabaoYunYangWin:freshCostItem()
local equip=self.equip
local itemguid=equip.itemguid
local lxlv=fabaoModel.getLingXingLv(itemguid)
local tupocost=fabaoConfig.getTuPoLxCost(lxlv)
local isTupo=tupocost~=nil
self.costItems:setActive(isTupo)
if not isTupo then return end
for i,v in ipairs(self.item)do
local cost=tupocost[i]
local has=cost~=nil
v:setActive(has)
if has then
local itemid=cost[1]
local need=cost[2]
local countStr=UIDanYaoModel:getItemCountStr(itemid,need)
local itemCfg=itemsConfig.getConfig(itemid)
local widget=v:getWidgetBase()
widget:SetChildButtonClick(0,function()
if itemsModel.getCount(itemid)>=need then
tipsManager.showTips({itemid=itemid})
else
gainControl:showGainWin(itemid)
end
end,true)

widgetHelper.setItemQulaity(widget,itemid,0)
widget:SetChildIcon(1,iconHelper.getIconName(itemCfg.icon),true)
widget:SetChildActive(2,true)
widget:SetChildText(3,countStr)
end
end
end

function UIFabaoYunYangWin:freshBtn()
local equip=self.equip
local itemguid=equip.itemguid
local lxlv=fabaoModel.getLingXingLv(itemguid)
local tupocost=fabaoConfig.getTuPoLxCost(lxlv)
local isMax=fabaoConfig.isLxMaxLv(lxlv)
local isTplv=tupocost~=nil
local visTp=not isMax and isTplv or false
local visUp=not isMax and not isTplv or false
local isDressSelf=benMingFaBaoHelper.isDressSelf(equip)
local canUp=benMingFaBaoHelper.canlxUp(itemguid)
self.desc:setText('')
if isDressSelf then
local dzguid=benMingFaBaoHelper.getOwner(itemguid)
local jjlv=UIDiscipleModel:getDiscipleJJLevel(dzguid)
local needjjlv=fabaoConfig.getNeedJingjielvByLx(lxlv)
if needjjlv>jjlv then
visTp=false
visUp=false
local jjname=UIDiscipleModel:getJJName(needjjlv)
self.desc:setText(FMT.fmt('境界需达到{0}期',jjname))
end
end
self.btnTuPo:setActive(visTp)
self.btnup:setActive(visUp)
self.upReddot:setActive(canUp)
end

function UIFabaoYunYangWin:freshEffect()
local equip=self.equip
local itemguid=equip.itemguid
local curlxlv=fabaoModel.getLingXingLv(itemguid)
local lvlist,lvInfoList,effectlvlist=fabaoConfig.getLxEffectList()
local len=#lvlist
self.Scrollview:setChildScrollViewCreateGrids(len,0)
local grids=self.Scrollview:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local item=grids[i]
local lxlv=lvlist[i+1]
local info=lvInfoList[lxlv]
local effectType=info[1]
local lastlv=fabaoConfig.getLastEffectLv(effectType,lxlv)
local lastval=lastlv and benMingFaBaoHelper.getEffectValue(lastlv,effectType)or nil
local val=benMingFaBaoHelper.getEffectValue(lxlv,effectType)
local name,desc=benMingFaBaoHelper.getDiffDesc(equip,effectType,lastval,val)
local isActive=curlxlv>=lxlv
local name=isActive and FMT.fmt('灵性{0}级',lxlv)or
FMT.cfmt2('#bea47b','灵性{0}级',lxlv)
local desc=isActive and desc or
FMT.cfmt2('#8e8c87',desc)
item:SetChildActive(1,isActive)
item:SetChildText(2,name)
item:SetChildText(3,desc)
end
end

function UIFabaoYunYangWin:showBuyView(itemguid)
local args={}
args.titleName="灵性增加"
args.pos=2
args.extraWin='UIFabaoSelectWin'
local extraParams={}
extraParams.title='消耗灵性道具直接增加法宝灵性'
args.extraParams=extraParams
extraParams.itemguid=itemguid
UIManager:showWindow('UICommonPageWin',args)
end

function UIFabaoYunYangWin:reqUp()

local equip=self.equip
local itemguid=equip.itemguid
local hasOwner,dzguid=benMingFaBaoHelper.hasOwner(itemguid)
local lxlv=fabaoModel.getLingXingLv(itemguid)
local cost=fabaoConfig.getTuPoLxCost(lxlv)
if not hasOwner then
local isTplv=cost~=nil
if isTplv then
UIManager.error('暂无主人，无法突破')
else
UIManager.error('暂无主人，无法升级')
end
return
end

local cur=fabaoModel.getFabaoLingXingExp(itemguid)
local need=fabaoConfig.getNeedLxExpByLx(lxlv)
if cur<need then
UIManager.error('灵性值不足')
return
end

local jjlv=UIDiscipleModel:getDiscipleJJLevel(dzguid)
local needjjlv=fabaoConfig.getNeedJingjielvByLx(lxlv)
if needjjlv>jjlv then
UIManager.error('主人境界等级不足')
return
end

for i,v in ipairs(cost or{})do
local itemid=v[1]
local need=v[2]
if itemsModel.getCount(itemid)<need then
local name=itemsModel.getName(itemid)
UIManager.error(FMT.fmt('{0}不足',name))
gainControl:showGainWin(itemid)
return
end
end
fabaoProtocolControl.reqUpLingXing(itemguid)
end

function UIFabaoYunYangWin:onUpRet(itemguid)
if tostring(itemguid)~=tostring(self.equip.itemguid)then return end
self:freshInfo()
self:startYunYangTimer()
end

function UIFabaoYunYangWin:onChangeExp(itemguid)
if tostring(itemguid)~=tostring(self.equip.itemguid)then return end
self:freshProgress()
self:freshBtn()
self:freshYunYang()
end

function UIFabaoYunYangWin:startYunYangTimer()
self:stopYunYangTimer()
if not self.isYunYang then return end
local equip=self.equip
local itemguid=equip.itemguid
local tick=function()
local cur=fabaoModel.getFabaoLingXingExp(itemguid)
local lxlv=fabaoModel.getLingXingLv(itemguid)
local need=fabaoConfig.getNeedLxExpByLx(lxlv)
local isMax=fabaoConfig.isLxMaxLv(lxlv)
self.progressBar2:animateThreeParams(cur,need,0.2)
self.progress2Txt:setText(not isMax and FMT.fmt('{0}/{1}',cur,need)or'等级已满')
local curexp=self.curexp
self.curexp=cur
if curexp==nil then return end
local add=cur-curexp
if add>0 and add<1000 then
local str=FMT.fmt('+{0}灵性',add)
commonTipsHelper.addThrowOutAndSliderTips(4,str,20,nil,self.defaultSortLayer,self.defaultSortOrder+1)
end
if isMax then
self:stopYunYangTimer()
end
end
self.yyTimer=self:setTimer(5,0,tick)
tick()
end

function UIFabaoYunYangWin:stopYunYangTimer()
if self.yyTimer then
self:stopTimerByID(self.yyTimer)
end
self.yyTimer=nil
end

function UIFabaoYunYangWin:freshUpReddot()
local canUp=benMingFaBaoHelper.canlxUp(self.itemguid)
self.upReddot:setActive(canUp)
end