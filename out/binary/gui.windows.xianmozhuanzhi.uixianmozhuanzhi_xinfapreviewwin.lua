







def_class("UIXianMoZhuanZhi_xinFaPreviewWin",UIWindowBase)









function UIXianMoZhuanZhi_xinFaPreviewWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.gainAttrContent=UIObject.get(self,1)
self.gainAttrListTitle=UIText.get(self,2)
self.gainDaoHeng=UIText.get(self,3)
self.menuContent=UIObject.get(self,4)
self.skillContent=UIObject.get(self,5)
self.xinFaDesc=UIText.get(self,6)
self.xinFaName=UIText.get(self,7)
self.xinFaSkillIcon=UIImage.get(self,8)
self.xiuLianCdn=UIText.get(self,9)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianMoZhuanZhi_xinFaPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.gainAttrContent);self.gainAttrContent=nil;
_UIObject_release(self.gainAttrListTitle);self.gainAttrListTitle=nil;
_UIObject_release(self.gainDaoHeng);self.gainDaoHeng=nil;
_UIObject_release(self.menuContent);self.menuContent=nil;
_UIObject_release(self.skillContent);self.skillContent=nil;
_UIObject_release(self.xinFaDesc);self.xinFaDesc=nil;
_UIObject_release(self.xinFaName);self.xinFaName=nil;
_UIObject_release(self.xinFaSkillIcon);self.xinFaSkillIcon=nil;
_UIObject_release(self.xiuLianCdn);self.xiuLianCdn=nil;
end


















local _this

function UIXianMoZhuanZhi_xinFaPreviewWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianMoZhuanZhi_xinFaPreviewWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianMoZhuanZhi_xinFaPreviewWin:onShow(argtable,afterOnloaded)
self:onShowArgRecv(argtable)
end

function UIXianMoZhuanZhi_xinFaPreviewWin:onShowArgRecv(argtable)
self.dis_guid=argtable
self.type=UIDiscipleModel:getDiscipleXianMoVoc(self.dis_guid)
self.selectStage=UIDiscipleModel:getDiscipleXinFaStage(self.dis_guid)
self.cfgs=cfgHelper.get1(cfg_disciplexinfaconfig_get,self.type)
self.voc=UIDiscipleModel:getDiscipleJob(self.dis_guid)
self:refreshAllView()
end

function UIXianMoZhuanZhi_xinFaPreviewWin:refreshAllView()

self.menuContent:setChildLayoutGroupCreateItems(#self.cfgs,function(index)
local item=self.menuContent:getChildLayoutGroupGridItem(index-1)
local isActived=UIDiscipleModel:isXinFaActive(self.type,index)
if isActived then
item:SetChildActive(0,index==self.selectStage)
item:SetChildText(1,string.format("%s阶",mathHelper.numberToChinese(index)))
item:SetChildButtonClick(2,function()
if _this then
_this:onClickMenuItem(index)
end
end)
else
item:SetChildActive(-1,false)
end
end)
self:refreshMainSkill()
self:refreshBranchSkill()
self:refreshRightInfo()
end

function UIXianMoZhuanZhi_xinFaPreviewWin:refreshMainSkill()
local cfg=self.cfgs[self.selectStage]

self.xinFaName:setText(cfg.name)

self.xinFaDesc:setText(cfg.desc)

self.xinFaSkillIcon:setChildIcon(cfg.icon,false)
end

function UIXianMoZhuanZhi_xinFaPreviewWin:refreshBranchSkill()
local cfg=self.cfgs[self.selectStage]
local isActived=UIDiscipleModel:isXinFaActive(self.type,self.selectStage)
if isActived then
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
end)
else
self.skillContent:setChildLayoutGroupClearAllItems()
end
end

function UIXianMoZhuanZhi_xinFaPreviewWin:refreshRightInfo()
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

local vocCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,self.voc)
local xm_name=vocCfg.xm_name[self.type]
self.gainAttrListTitle:setText(string.format("%s可获得属性",xm_name))
local attrList={}
local stageAttrList=UIDiscipleModel:getXinFaStageDaoHengAttr(self.voc,self.type,self.selectStage)
for attrKey,attrVal in pairs(stageAttrList)do
table.insert(attrList,{attrKey,attrVal})
end
self.gainAttrContent:setChildLayoutGroupCreateItems(#attrList,function(index)
local item=self.gainAttrContent:getChildLayoutGroupGridItem(index-1)

local attr=attrList[index]
local attrInfo=helper.getAttributeStr(attr[1],attr[2],1,"{0} <color=#549327>+{1}</color>")
item:SetChildText(0,attrInfo)
end)
end


function UIXianMoZhuanZhi_xinFaPreviewWin:onClickMenuItem(index)
if self.selectStage==index then
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

function UIXianMoZhuanZhi_xinFaPreviewWin:onClickBranchSkillItem(index)
local cfg=self.cfgs[self.selectStage]
local id=cfg.branch_list[index]
self:showWindow("UIXinFaBranchWin",{self.type,self.selectStage,id,true})
end

function UIXianMoZhuanZhi_xinFaPreviewWin:onCloseBtn()
self:closeSelf()
end