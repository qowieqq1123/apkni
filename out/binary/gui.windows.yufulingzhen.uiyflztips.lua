







def_class("UIYFLZTips",UIWindowBase)









function UIYFLZTips:bindComponents()

self.root=UIObject.get(self,0)
self.title=UIText.get(self,1)
self.level=UIText.get(self,2)
self.lzbg=UIImage.get(self,3)
self.lzmodel=UIObject.get(self,4)
self.attrScrollView=UIObject.get(self,5)
self.lingzhen_1=UIObject.get(self,6)
self.lingzhen_2=UIObject.get(self,7)
self.lingzhen_3=UIObject.get(self,8)
self.lingzhen_4=UIObject.get(self,9)
self.lingzhen_5=UIObject.get(self,10)
self.lingzhen_6=UIObject.get(self,11)
self.lzgmbtn=UIButton.get(self,12)
self.gmline=UIObject.get(self,13)
self.gmqiu=UIObject.get(self,14)
self.gmtxt=UIText.get(self,15)
self.btnspine=UIObject.get(self,16)

self.lzgmbtn:setButtonClick(function()self:onLzgmbtn()end)
self.lingzhen={
self.lingzhen_1,
self.lingzhen_2,
self.lingzhen_3,
self.lingzhen_4,
self.lingzhen_5,
self.lingzhen_6,
}



end


function UIYFLZTips:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.lzbg);self.lzbg=nil;
_UIObject_release(self.lzmodel);self.lzmodel=nil;
_UIObject_release(self.attrScrollView);self.attrScrollView=nil;
_UIObject_release(self.lingzhen_1);self.lingzhen_1=nil;
_UIObject_release(self.lingzhen_2);self.lingzhen_2=nil;
_UIObject_release(self.lingzhen_3);self.lingzhen_3=nil;
_UIObject_release(self.lingzhen_4);self.lingzhen_4=nil;
_UIObject_release(self.lingzhen_5);self.lingzhen_5=nil;
_UIObject_release(self.lingzhen_6);self.lingzhen_6=nil;
_UIObject_release(self.lzgmbtn);self.lzgmbtn=nil;
_UIObject_release(self.gmline);self.gmline=nil;
_UIObject_release(self.gmqiu);self.gmqiu=nil;
_UIObject_release(self.gmtxt);self.gmtxt=nil;
_UIObject_release(self.btnspine);self.btnspine=nil;
self.lingzhen=nil;
end
















local _lz_xq_index={
click=0,
add_icon=1,
icon=2,
suo=3,
tips=4,
pingzhi=5,
reddot=6,
lv=7,
lvText=8,
}




function UIYFLZTips:onLoaded(...)
self:bindComponents()

self.colorTexts={'绿品','蓝品','紫品','橙品','红品'}
self.unlockTexts={'绿品解锁','蓝品解锁','紫品解锁','橙品解锁','红品解锁'}

self.attrScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIYFLZTips:__delete()
self:unbindComponents()
end




function UIYFLZTips:onShow(argtable,afterOnloaded)
self.yfId=argtable.itemId
self.yfGuid=argtable.itemGuid
self.lzData=UIYuFuLingZhenControl:getLingZhenData(self.yfGuid)

local yfcfg=itemsConfig.getConfig(self.yfId)
self.title:setText(FMT.fmt('<color={2}>{0}·{1}</color>',self.colorTexts[yfcfg.color],yfcfg.name,FONT_COLOR_VAL[yfcfg.color]))
local level=UIYuFuLingZhenControl:countTotalLevel(self.lzData)
self.level:setText(FMT.fmt('灵阵总级：{0}级',level))

self:setLingzhen()
self:setAttr()
end


function UIYFLZTips:onHide()

end

function UIYFLZTips:setAttr()
local ztId=self.lzData.zhentuId
local ztcfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,ztId)
local typeLevelDatas=UIYuFuLingZhenControl:countTypeLevels(self.lzData)
local len=#ztcfg.attr
self.attrScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.attrScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=ztcfg.attr[i]

local pr=UIYuFuLingZhenControl:getPrefixName(data[2])

item:SetChildText(0,FMT.fmt('激活条件：{0}灵阵{1}级',pr,data[3]))
local curr=typeLevelDatas[data[2]]or 0
local max=data[3]
item:SetChildUIProgressbar(1,curr,max,false)
item:SetChildText(2,FMT.fmt('{0}/{1}',curr,max))
local attrList=data[4]
local widgetIdx={{3,4},{5,6}}
local len=#attrList
for i,attr in ipairs(attrList)do
local stype=attr[1]
if stype==2 then
self:setAttrText(item,widgetIdx[i][1],stype,attr[2][1],curr<max)
self:setAttrText(item,widgetIdx[i][2],stype,attr[2][2],curr<max)
if len==1 and i==1 then
self:setAttrText(item,widgetIdx[i+1][1],stype,attr[2][3],curr<max)
self:setAttrText(item,widgetIdx[i+1][2],stype,attr[2][4],curr<max)
end
else
self:setAttrText(item,widgetIdx[i][1],stype,attr,curr<max)
self:setAttrText(item,widgetIdx[i][2],stype,nil,curr<max)
end
end

end
self:refreshgmNum()
end

function UIYFLZTips:setAttrText(item,index,stype,attr,gray)
if attr then
item:SetChildActive(index,true)
if stype==2 then
local name,str=equipsHelper.getAttr(attr[1],attr[2])
if gray then
item:SetChildText(index,FMT.cfmt(FONT_COLOR.eGrayColor,'{0}+{1}',name,str))
else
item:SetChildText(index,FMT.fmt('{0}+{1}',name,str))
end

elseif stype==1 then
if gray then
item:SetChildText(index,FMT.cfmt(FONT_COLOR.eGrayColor,'该阵图中{0}灵阵的总属性+{1}%',attr[2]==0 and'所有'or UIYuFuLingZhenControl:getPrefixName(attr[2]),attr[3]*100))
else
item:SetChildText(index,FMT.fmt('该阵图中{0}灵阵的总属性+{1}%',attr[2]==0 and'所有'or UIYuFuLingZhenControl:getPrefixName(attr[2]),attr[3]*100))
end
end
else
item:SetChildActive(index,false)
end
end
function UIYFLZTips:isLingZhenEnough()
if self.lzData and self.lzData.kongList then
for i=1,5 do
if not self.lzData.kongList[i]then
return false
end
end
return true
end
return false
end

function UIYFLZTips:setLingzhen()
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,self.lzData.zhentuId)
local yfcfg=itemsConfig.getConfig(self.yfId)


local isActive=UIYuFuLingZhenControl:isZhenTuActive(cfg.id)
local isEnough1=self:isLingZhenEnough()
self.lzmodel:setActive(isActive and isEnough1)
self.lzbg:setActive((not isActive)or(not isEnough1))
if isActive and isEnough1 then
local sp=UIYuFuLingZhenControl:getSpine(cfg.id)
self.lzmodel:setChildUIModelShowTarget(sp[1],sp[2],{},eAnimationID.stand,false,false,0,nil)
else
local abName,imgName=UIYuFuLingZhenControl:getImageName(cfg.id,false)
self.lzbg:setSprite(abName,imgName)
end
local posList=cfg.poslist
for i,v in ipairs(self.lingzhen)do
local widget=v:getWidgetBase()
local pos=posList[i]
widget:SetChildLocalPos(-1,pos[1],pos[2],0)
local check=cfg.unlock[i]
local unlock=true
if check then
unlock=yfcfg.color>=check
end
if check and i==6 then
local level=self.lzData and UIYuFuLingZhenControl:countTotalLevel(self.lzData)or 0
unlock=check<level
end
widget:SetChildActive(_lz_xq_index.reddot,false)
if unlock then
local kdata=self.lzData.kongList[i]
local shwoIcon=kdata~=nil
widget:SetChildActive(_lz_xq_index.pingzhi,shwoIcon)
widget:SetChildActive(_lz_xq_index.add_icon,false)
widget:SetChildActive(_lz_xq_index.icon,shwoIcon)
widget:SetChildActive(_lz_xq_index.suo,false)
widget:SetChildActive(_lz_xq_index.lv,shwoIcon)
if shwoIcon then
local itemCfg=itemsConfig.getConfig(kdata.itemId)
local color=UIYuFuLingZhenControl:getItemColorById(kdata.itemId,kdata.itemguid)
local pz=UIYuFuLingZhenControl:getPZIconName(color)
widget:SetChildCSImageSprite(_lz_xq_index.pingzhi,globalABLookup.yufulingzhen,pz)
local icon=UIYuFuLingZhenControl:getLZIconName(itemCfg)

widget:SetChildIcon(_lz_xq_index.icon,icon,true)

widget:SetChildText(_lz_xq_index.lvText,UIYuFuLingZhenControl:getItemLevel(kdata.itemId))
else
widget:SetChildText(_lz_xq_index.tips,'')
end
else
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
widget:SetChildActive(3,true)
widget:SetChildActive(_lz_xq_index.pingzhi,false)
widget:SetChildActive(_lz_xq_index.lv,false)
local txt=FMT.fmt('<color={0}>{1}</color>',FONT_COLOR_VAL[check],self.unlockTexts[check])
widget:SetChildText(4,txt)
end
end
end




function UIYFLZTips:onLzgmbtn()
local cur,max=LingZhenChongZhuModel:getjihuonum(self.lzData,self.yfId)
local yfcfg=itemsConfig.getConfig(self.yfId)
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,self.lzData.zhentuId)
local alllevel=0
for i=1,5 do
local unlock=true
local check=cfg.unlock[i]
if check then
unlock=yfcfg.color>=check
end
if check and i==6 then
local level=self.lzData and UIYuFuLingZhenControl:countTotalLevel(self.lzData)or 0
unlock=check<level
end
if unlock then
local kdata=self.lzData.kongList[i]
if kdata then
alllevel=alllevel+UIYuFuLingZhenControl:getItemLevel(kdata.itemId)
end
end
end
UIManager:showWindow("UILZGMTipsWin",{cur,max,alllevel,self.lzData})
end

function UIYFLZTips:refreshgmNum()
local cur,max=LingZhenChongZhuModel:getjihuonum(self.lzData,self.yfId)
self.gmtxt:setText(FMT.fmt("{0}/{1}",cur,max))


local starnum=0
for i=1,5 do




if i<=cur then




starnum=starnum+1
end
end
local actionid=eAnimationID.stand
if starnum>0 and actionid<=5 then
actionid=2907+starnum
end
self.btnspine:setChildUIModelShowTarget(5705,1,nil,actionid)
end



