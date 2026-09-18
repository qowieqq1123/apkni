







def_class("UIZhenTuYanJiuWin",UIWindowBase)









function UIZhenTuYanJiuWin:bindComponents()

self.yanjiureddot=UIObject.get(self,0)
self.jumpBtn=UIButton.get(self,1)
self.condition=UIText.get(self,2)
self.yanJiuBtn=UIButton.get(self,3)
self.costScrollView=UIObject.get(self,4)
self.condditionRoot=UIObject.get(self,5)
self.title=UIText.get(self,6)
self.ztScrollView=UIObject.get(self,7)
self.desTile=UIText.get(self,8)
self.desc=UIText.get(self,9)
self.lzbg=UIImage.get(self,10)
self.lzbgmask=UIImage.get(self,11)
self.lzmodel=UIObject.get(self,12)
self.effect=UIObject.get(self,13)
self.actived=UIObject.get(self,14)
self.activePanel=UIObject.get(self,15)
self.lingzhen_4=UIObject.get(self,16)
self.lingzhen_5=UIObject.get(self,17)
self.lingzhen_3=UIObject.get(self,18)
self.lingzhen_2=UIObject.get(self,19)
self.lingzhen_1=UIObject.get(self,20)
self.lingzhen_6=UIObject.get(self,21)
self.activeStr=UIText.get(self,22)
self.detailBtn=UIButton.get(self,23)

self.jumpBtn:setButtonClick(function()self:onJumpBtn()end)

self.yanJiuBtn:setButtonClick(function()self:onYanJiuBtn()end)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)
self.lingzhen={
self.lingzhen_1,
self.lingzhen_2,
self.lingzhen_3,
self.lingzhen_4,
self.lingzhen_5,
self.lingzhen_6,
}



end


function UIZhenTuYanJiuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.yanjiureddot);self.yanjiureddot=nil;
_UIObject_release(self.jumpBtn);self.jumpBtn=nil;
_UIObject_release(self.condition);self.condition=nil;
_UIObject_release(self.yanJiuBtn);self.yanJiuBtn=nil;
_UIObject_release(self.costScrollView);self.costScrollView=nil;
_UIObject_release(self.condditionRoot);self.condditionRoot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.ztScrollView);self.ztScrollView=nil;
_UIObject_release(self.desTile);self.desTile=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.lzbg);self.lzbg=nil;
_UIObject_release(self.lzbgmask);self.lzbgmask=nil;
_UIObject_release(self.lzmodel);self.lzmodel=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.actived);self.actived=nil;
_UIObject_release(self.activePanel);self.activePanel=nil;
_UIObject_release(self.lingzhen_4);self.lingzhen_4=nil;
_UIObject_release(self.lingzhen_5);self.lingzhen_5=nil;
_UIObject_release(self.lingzhen_3);self.lingzhen_3=nil;
_UIObject_release(self.lingzhen_2);self.lingzhen_2=nil;
_UIObject_release(self.lingzhen_1);self.lingzhen_1=nil;
_UIObject_release(self.lingzhen_6);self.lingzhen_6=nil;
_UIObject_release(self.activeStr);self.activeStr=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
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
}


function UIZhenTuYanJiuWin:onLoaded(...)
self:bindComponents()

self.ztScrollView:setChildScrollViewInit(0.5,true,function(num,index)self:onItemClick(num,index)end,nil)
self.costScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIZhenTuYanJiuWin:__delete()
self:unbindComponents()
end

function UIZhenTuYanJiuWin:onItemClick(num,index,anim)
if self.selectIndex then
local widget=self.ztScrollView:getChildScrollViewItemWidget(self.selectIndex)
widget:SetChildActive(4,false)
end
self.selectIndex=index
local widget=self.ztScrollView:getChildScrollViewItemWidget(self.selectIndex)
widget:SetChildActive(4,true)

self:showSelectZhenTu(anim)
end




function UIZhenTuYanJiuWin:onShow(argtable,afterOnloaded)
self:refresh()
end

function UIZhenTuYanJiuWin:refresh(anim)
self:showZhenTuList()
self:onItemClick(0,self.selectIndex or 0,anim)
end


function UIZhenTuYanJiuWin:onHide()

end

function UIZhenTuYanJiuWin:showZhenTuList()
local cfgs=cfg_yufuzhentuconfig()
self.datas=cfgs
local len=#cfgs
self.ztScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.ztScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cfg=cfgs[i]
local check=UIYuFuLingZhenControl:isZhenTuResearched(cfg.id)
if check then
item:SetChildActive(1,false)
item:SetChildActive(2,false)
else
item:SetChildActive(1,true)
item:SetChildActive(2,false)
end
item:SetChildText(3,cfg.name)
local abName,imgName="ui/windows/yufulingzhen/yflz_yanjiu_atlas_pak.ab",cfg.image[3]

item:SetChildCSImageSprite(0,abName,imgName)
item:SetChildActive(4,false)
item:SetChildActive(2,UIYuFuLingZhenControl:checkZhenTyReseach(cfg.id))

end
end

function UIZhenTuYanJiuWin:showSelectZhenTu(anim)
local cfg=self.datas[self.selectIndex+1]
self.title:setText(cfg.name)
self.desTile:setText(cfg.name)
self.desc:setText(cfg.desc)
local check=UIYuFuLingZhenControl:isZhenTuResearched(cfg.id)

if anim then
if check then
self.lzmodel:setActive(false)
self.lzbg:setActive(true)
local abName,imgName=UIYuFuLingZhenControl:getImageName(cfg.id,true)
self.lzbg:setSprite(abName,imgName)
abName,imgName=UIYuFuLingZhenControl:getImageName(cfg.id,false)
self.lzbgmask:setSprite(abName,imgName)
self.winid:SetDissolveFactor(self.lzbgmask:getID(),0)
self.tweenerVal=0
self.tweeners=_DOTweenProxy.DoValueTo(
function()
return self.tweenerVal or 0
end,
function(val)
self.tweenerVal=val
self.winid:SetDissolveFactor(self.lzbgmask:getID(),val)
end,
1,1)
self:delayDo(1,function()
self.lzmodel:setActive(true)
self.lzbg:setActive(false)
local sp=UIYuFuLingZhenControl:getSpine(cfg.id)
self.lzmodel:setChildUIModelShowTarget(sp[1],sp[2],{},eAnimationID.stand,false,false,0,nil)
end)
self.effect:setChildShowEffect(20200,true)
else
self.lzbg:setActive(true)
self.lzmodel:setActive(false)
local abName,imgName=UIYuFuLingZhenControl:getImageName(cfg.id,false)
self.lzbg:setSprite(abName,imgName)
self.lzbgmask:setSprite(abName,imgName)
self.winid:SetDissolveFactor(self.lzbgmask:getID(),1)
end
else
self.lzbg:setActive(not check)
self.lzmodel:setActive(check)
if check then
local sp=UIYuFuLingZhenControl:getSpine(cfg.id)
self.lzmodel:setChildUIModelShowTarget(sp[1],sp[2],{},eAnimationID.stand,false,false,0,nil)
else
local abName,imgName=UIYuFuLingZhenControl:getImageName(cfg.id,false)
self.lzbg:setSprite(abName,imgName)
self.lzbgmask:setSprite(abName,imgName)
self.winid:SetDissolveFactor(self.lzbgmask:getID(),1)
end
end

if check then
self.actived:setActive(true)
self.activePanel:setActive(false)
self.yanjiureddot:setActive(false)
else
self.actived:setActive(false)
self.activePanel:setActive(true)

local rid=cfg.unlockList[1]

local data=UIYuFuLingZhenControl:getResearchedInfo(rid[1],rid[2],cfg.id)
local max=rid[3]

local curr=data or 0
if curr>=max then
self.condditionRoot:setActive(false)
self.condition:setText('')
self.costScrollView:setActive(true)
self.yanJiuBtn:setActive(true)

local costs=cfg.yjItems
local len=#costs
self.costScrollView:setChildScrollViewCreateGrids(len,0)
local grids=self.costScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cdata=costs[i]
cdata.checkAmount=true
widgetHelper.setNormalRewardItem(item,0,cdata)
end
local red=true
if cfg.yjItems then
for i,v in ipairs(costs)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
red=false
break
end
end
end

self.yanjiureddot:setActive(red)
else
self.condditionRoot:setActive(true)
self.condition:setText(FMT.fmt('{0}\n<color={3}>({1}/{2})</color>',FMT.fmt(cfg.unlockname,max),curr,max,curr>=max and FONT_COLOR_VAL[FONT_COLOR.eGreenColor]or FONT_COLOR_VAL[FONT_COLOR.eRedColor]))
self.costScrollView:setActive(false)
self.yanJiuBtn:setActive(false)

self.yanjiureddot:setActive(false)

if cfg.jump then
self.jumpCall=function()
jumpManager:jump(cfg.jump)
end
end
end
end
self:setLingzhen(cfg.id)
end

function UIZhenTuYanJiuWin:setLingzhen(lzId)
local cfg=cfgHelper.get1(cfg_yufuzhentuconfig_get,lzId)

self.activeStr:setText(FMT.fmt("激活{0}，可在玉符选择激活此阵图",cfg.name))













end




function UIZhenTuYanJiuWin:onDetailBtn()
local cfg=self.datas[self.selectIndex+1]
UIManager:showWindow('UIZhenTuYanJiuDetailWin',cfg.id)
end

function UIZhenTuYanJiuWin:onYanJiuBtn()
local cfg=self.datas[self.selectIndex+1]

if cfg.yjItems then
for i,v in ipairs(cfg.yjItems)do
local have=itemsModel.getCount(v[1])
if have<v[2]then
local err=FMT.fmt('{0}不足',itemsConfig.getItemName(v[1]))
UIManager.error(err)
gainControl:showGainWin(v[1])
return
end
end
end
UIYuFuLingZhenControl:reqYanJiu(cfg.id)
end

function UIZhenTuYanJiuWin:onJumpBtn()
if self.jumpCall then
self.jumpCall()
end
end