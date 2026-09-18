







def_class("UIXinFaMainWin",UIWindowBase)









function UIXinFaMainWin:bindComponents()

self.costItem_1=UIObject.get(self,0)
self.costItem_2=UIObject.get(self,1)
self.costItem_3=UIObject.get(self,2)
self.gainDaoHeng=UIText.get(self,3)
self.lockPanel=UIObject.get(self,4)
self.menuContent=UIObject.get(self,5)
self.root=UIObject.get(self,6)
self.skillContent=UIObject.get(self,7)
self.skillScrollView=UIObject.get(self,8)
self.tuPoNum=UIText.get(self,9)
self.xinFaActiveBtn=UIButton.get(self,10)
self.xinFaActiveReddot=UIObject.get(self,11)
self.xinFaCdn=UIText.get(self,12)
self.xinFaDesc=UIText.get(self,13)
self.xinFaName=UIText.get(self,14)
self.xinFaSkillIcon=UIImage.get(self,15)
self.xiuLianCdn=UIText.get(self,16)

self.xinFaActiveBtn:setButtonClick(function()self:onXinFaActiveBtn()end)
self.costItem={
self.costItem_1,
self.costItem_2,
self.costItem_3,
}



end


function UIXinFaMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costItem_1);self.costItem_1=nil;
_UIObject_release(self.costItem_2);self.costItem_2=nil;
_UIObject_release(self.costItem_3);self.costItem_3=nil;
_UIObject_release(self.gainDaoHeng);self.gainDaoHeng=nil;
_UIObject_release(self.lockPanel);self.lockPanel=nil;
_UIObject_release(self.menuContent);self.menuContent=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.skillContent);self.skillContent=nil;
_UIObject_release(self.skillScrollView);self.skillScrollView=nil;
_UIObject_release(self.tuPoNum);self.tuPoNum=nil;
_UIObject_release(self.xinFaActiveBtn);self.xinFaActiveBtn=nil;
_UIObject_release(self.xinFaActiveReddot);self.xinFaActiveReddot=nil;
_UIObject_release(self.xinFaCdn);self.xinFaCdn=nil;
_UIObject_release(self.xinFaDesc);self.xinFaDesc=nil;
_UIObject_release(self.xinFaName);self.xinFaName=nil;
_UIObject_release(self.xinFaSkillIcon);self.xinFaSkillIcon=nil;
_UIObject_release(self.xiuLianCdn);self.xiuLianCdn=nil;
self.costItem=nil;
end


















local _this

function UIXinFaMainWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXinFaMainWin:__delete()
self:unbindComponents()
UIDiscipleModel:clearTargetXinFaData()
_this=nil
end


function UIXinFaMainWin:onHide()

end




function UIXinFaMainWin:onShow(argtable,afterOnloaded)
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,1,nil)
end
self:onShowArgRecv(argtable)
end

function UIXinFaMainWin:onShowArgRecv(argtable)
argtable=argtable or{}
self.type=argtable.type or 1
self.selectStage=UIDiscipleModel:getXinFaStage(self.type)
if argtable.selectStage then
self.selectStage=argtable.selectStage
else
local reddot,reddotStage=UIDiscipleModel:checkXinFaTypeReddot(self.type)
if reddot then
self.selectStage=reddotStage
end
end
self.cfgs=cfgHelper.get1(cfg_disciplexinfaconfig_get,self.type)
self:refreshAllView()
end

function UIXinFaMainWin:refreshStageReddot(stage)
local item=self.menuContent:getChildLayoutGroupGridItem(stage-1)
local reddot=UIDiscipleModel:checkXinFaStageReddot(self.type,stage)
item:SetChildActive(3,reddot)
end

function UIXinFaMainWin:refreshAllView()

self.menuContent:setChildLayoutGroupCreateItems(#self.cfgs,function(index)
local item=self.menuContent:getChildLayoutGroupGridItem(index-1)
item:SetChildActive(0,index==self.selectStage)
item:SetChildText(1,string.format("%s阶",mathHelper.numberToChinese(index)))
item:SetChildButtonClick(2,function()
if _this then
_this:onClickMenuItem(index)
end
end)
local reddot=UIDiscipleModel:checkXinFaStageReddot(self.type,index)
item:SetChildActive(3,reddot)
end)
self:refreshMainSkill()
self:refreshBranchSkill()
self:refreshRightInfo()
end

function UIXinFaMainWin:refreshMainSkill()
local cfg=self.cfgs[self.selectStage]

self.xinFaName:setText(cfg.name)

self.xinFaDesc:setText(cfg.desc)

self.xinFaSkillIcon:setChildIcon(cfg.icon,false)
end

function UIXinFaMainWin:refreshBranchSkill()
local cfg=self.cfgs[self.selectStage]
local isActived=UIDiscipleModel:isXinFaActive(self.type,self.selectStage)
if isActived then
self.skillScrollView:setActive(true)
self.lockPanel:setActive(false)
self.skillContent:setChildLayoutGroupCreateItems(#cfg.branch_list,function(index)
local item=self.skillContent:getChildLayoutGroupGridItem(index-1)
local branchId=cfg.branch_list[index]
local branchCfg=cfgHelper.get1(cfg_disciplexinfabranchconfig_get,branchId)
local level=UIDiscipleModel:getXinFaBranchLevel(branchId)
local isBranchActived=level>0

item:SetChildActive(0,false)

item:SetChildIcon(1,branchCfg.icon,false)
item:SetChildImageExGray(1,not isBranchActived)
item:SetChildButtonClick(2,function()
if _this then
_this:onClickBranchSkillItem(index)
end
end)

item:SetChildActive(3,isBranchActived)
item:SetChildText(4,level)

local reddot=UIDiscipleModel:isXinFaBranchCanActive(branchId)
item:SetChildActive(5,reddot)
end)
else
self.skillScrollView:setActive(false)
self.lockPanel:setActive(true)
local reddot=UIDiscipleModel:isXinFaCanActive(self.type,self.selectStage)
self.xinFaActiveReddot:setActive(reddot)

local itemList=cfg.active
for i,v in ipairs(self.costItem)do
local items=itemList[i]
if items then
local widget=self.winlua:GetChildWidgetBase(v:getID())
local itemId,needNum=unpack(items)
local itemNum=itemsModel.getCount(itemId)
local countStr=string.format("<color=%s>%d</color>",itemNum>=needNum and"F9F9F9"or"red",needNum)
local conf={itemid=itemId,itemcount=countStr,showCountBG=true,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
widget:SetChildPropData(0,prop)
else
v:setActive(false)
end
end
end
end

function UIXinFaMainWin:refreshRightInfo()
local cfg=cfgHelper.get1(cfg_disciplevocconfig_get,1)
local stage_daoheng=UIDiscipleModel:getXinFaStageDaoHeng(self.selectStage)

self.gainDaoHeng:setText(string.format("%d年",stage_daoheng))

local n,p,pN=UIDiscipleModel:getJJNameX(cfg.voc_level)
local jj_str=''
if p~=nil then
jj_str=FMT.fmt('{0}{1}',n,pN)
else
jj_str=n
end
self.xiuLianCdn:setText(jj_str)
if self.selectStage>1 then
self.xinFaCdn:setActive(true)
self.xinFaCdn:setText(string.format("%d阶心法修炼圆满",self.selectStage-1))
else
self.xinFaCdn:setActive(false)
end

local cfg=self.cfgs[self.selectStage]
local num=cfg.full_level
if self.cfgs[self.selectStage-1]then
cfg=self.cfgs[self.selectStage-1]
num=num-cfg.full_level
end
self.tuPoNum:setText(string.format("突破%d次",num))

end


function UIXinFaMainWin:onClickMenuItem(index)
if self.selectStage==index then
return
end
local curStage=UIDiscipleModel:getXinFaStage(self.type)
if index>curStage+1 then
UIManager.info(string.format("请先激活%s阶心法",mathHelper.numberToChinese(curStage+1)))
return
end
if self.selectStage then
local menuItem=self.menuContent:getChildLayoutGroupGridItem(self.selectStage-1)
menuItem:SetChildActive(0,false)
end
self.selectStage=index
local menuItem=self.menuContent:getChildLayoutGroupGridItem(self.selectStage-1)
menuItem:SetChildActive(0,true)

self:refreshMainSkill()
self:refreshBranchSkill()
self:refreshRightInfo()
end

function UIXinFaMainWin:onClickBranchSkillItem(index)
local cfg=self.cfgs[self.selectStage]
local id=cfg.branch_list[index]
self:showWindow("UIXinFaBranchWin",{self.type,self.selectStage,id,false})
end

function UIXinFaMainWin:onXinFaActiveBtn()
local cfg=self.cfgs[self.selectStage]
local itemList=cfg.active
for i,v in ipairs(itemList)do
local itemId,needNum=v[1],v[2]
local itemNum=itemsModel.getCount(itemId)
if itemNum<needNum then
UIManager.error(string.format("%s不足",itemsModel.getName(itemId)))
gainControl:showGainWin(itemId)
return
end
end
UIDiscipleController:reqXinFaActive(self.type,self.selectStage)
end