







def_class("UIMingYuanZhuSha_SelectBaoWuWin",UIWindowBase)









function UIMingYuanZhuSha_SelectBaoWuWin:bindComponents()

self.bgSpine=UIObject.get(self,0)
self.btns=UIObject.get(self,1)
self.bwDetailBtn=UIButton.get(self,2)
self.bwItem_1=UIBaseItem.get(self,3)
self.bwItem_2=UIBaseItem.get(self,4)
self.bwItem_3=UIBaseItem.get(self,5)
self.bwList=UIObject.get(self,6)
self.centerLayout=UIObject.get(self,7)
self.comfireBtn=UIButton.get(self,8)
self.discipleStateBtn=UIButton.get(self,9)
self.Root=UIObject.get(self,10)
self.uiRoot=UIObject.get(self,11)

self.bwDetailBtn:setButtonClick(function()self:onBwDetailBtn()end)

self.comfireBtn:setButtonClick(function()self:onComfireBtn()end)

self.discipleStateBtn:setButtonClick(function()self:onDiscipleStateBtn()end)
self.bwItem={
self.bwItem_1,
self.bwItem_2,
self.bwItem_3,
}



end


function UIMingYuanZhuSha_SelectBaoWuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bgSpine);self.bgSpine=nil;
_UIObject_release(self.btns);self.btns=nil;
_UIObject_release(self.bwDetailBtn);self.bwDetailBtn=nil;
_UIObject_release(self.bwItem_1);self.bwItem_1=nil;
_UIObject_release(self.bwItem_2);self.bwItem_2=nil;
_UIObject_release(self.bwItem_3);self.bwItem_3=nil;
_UIObject_release(self.bwList);self.bwList=nil;
_UIObject_release(self.centerLayout);self.centerLayout=nil;
_UIObject_release(self.comfireBtn);self.comfireBtn=nil;
_UIObject_release(self.discipleStateBtn);self.discipleStateBtn=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.uiRoot);self.uiRoot=nil;
self.bwItem=nil;
end
















local _this

local _bwItemCmpIndex={
quality=0,
select=1,
namebg=2,
name=3,
descbg=4,
desc=5,
bwImg=6,
effect=7,
selectEffect=8
}




function UIMingYuanZhuSha_SelectBaoWuWin:onLoaded(...)
self:bindComponents()

_this=self

self.selectIndex=0
end


function UIMingYuanZhuSha_SelectBaoWuWin:__delete()
_this=nil

self:unbindComponents()
end




function UIMingYuanZhuSha_SelectBaoWuWin:onShow(argtable,afterOnloaded)


if afterOnloaded then
self.uiRoot:setChildCanvasGroupAlpha(0)
self.bgSpine:setChildUIModelShowTarget(5685,1,nil,eAnimationID.enter,false,false,0.2,function()
self:delayDo(0.3,function()
_this.uiRoot:setChildCanvasGroupDOFade(1,0.2)
end)
end)
end
self:refreshAll()
end


function UIMingYuanZhuSha_SelectBaoWuWin:onHide()

end

function UIMingYuanZhuSha_SelectBaoWuWin:refreshAll()
self:refreshBwList()
end

function UIMingYuanZhuSha_SelectBaoWuWin:refreshBwList()
local bwList,bwListLen=myzsModel:getCurLevelItemList()

local func=function(index,item)


local bwData=bwList[index]
local isShow=bwData~=nil
item:SetChildActive(-1,isShow)
if not isShow then return end

local bwId=bwData.param_2
local bwArgs=bwData.param_3

local bwCfg=cfgHelper.get1(cfg_mingyuanzhushabaowuconfig_get,bwId)





local isSelect=_this.selectIndex==index
item:SetChildActive(_bwItemCmpIndex.select,isSelect)
item:SetChildActive(_bwItemCmpIndex.selectEffect,isSelect)

item:SetChildText(_bwItemCmpIndex.name,bwCfg.name)

local desc=skillModel:getSkillDesc(bwCfg.skill[1],bwCfg.skill[2])
item:SetChildText(_bwItemCmpIndex.desc,desc)

item:SetChildIcon(_bwItemCmpIndex.bwImg,bwCfg.imageName,true)


item:SetBaseItemClickEvent(-1,function()
if _this==nil then return end
if _this.selectIndex==index then return end
if _this.selectIndex>0 then
local preItem=self.bwItem[_this.selectIndex]
preItem=preItem:getWidgetBase()


preItem:SetChildActive(_bwItemCmpIndex.effect,false)
end

_this.selectIndex=index


item:SetChildActive(_bwItemCmpIndex.effect,true)


end)
end

for index,obj in ipairs(self.bwItem)do
func(index,obj:getWidgetBase())
end


end






function UIMingYuanZhuSha_SelectBaoWuWin:onBwDetailBtn()

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eMYZS_BWDetail,{})
end



function UIMingYuanZhuSha_SelectBaoWuWin:onComfireBtn()
if self.selectIndex<=0 then
UIManager.info("请选择宝物")
return
end


myzsController.reqInteraction(MYZSInteractionType.eSelectBW,self.selectIndex,0,{})
end



function UIMingYuanZhuSha_SelectBaoWuWin:onDiscipleStateBtn()

oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eMYZS_DisicpleState,{})
end

