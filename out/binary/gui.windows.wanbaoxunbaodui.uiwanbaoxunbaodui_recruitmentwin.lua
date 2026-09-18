







def_class("UIWanBaoXunBaoDui_RecruitmentWin",UIWindowBase)









function UIWanBaoXunBaoDui_RecruitmentWin:bindComponents()

self.bg=UIObject.get(self,0)
self.btns=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.Content=UIObject.get(self,3)
self.featureScrollView=UIObject.get(self,4)
self.hiredBtn=UIButton.get(self,5)
self.hiredState=UIObject.get(self,6)
self.infoRoot=UIObject.get(self,7)
self.kind=UIText.get(self,8)
self.maxtili=UIText.get(self,9)
self.nofeature=UIObject.get(self,10)
self.nohiredState=UIObject.get(self,11)
self.notHiredBtn=UIButton.get(self,12)
self.nvalue=UIText.get(self,13)
self.ploygonroot=UIObject.get(self,14)
self.Root=UIObject.get(self,15)
self.ScrollView=UIScrollViewSlow.get(self,16)
self.sex=UIText.get(self,17)
self.title=UIText.get(self,18)
self.titleBG=UIObject.get(self,19)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.hiredBtn:setButtonClick(function()self:onHiredBtn()end)

self.notHiredBtn:setButtonClick(function()self:onNotHiredBtn()end)



end


function UIWanBaoXunBaoDui_RecruitmentWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
_UIObject_release(self.btns);self.btns=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.featureScrollView);self.featureScrollView=nil;
_UIObject_release(self.hiredBtn);self.hiredBtn=nil;
_UIObject_release(self.hiredState);self.hiredState=nil;
_UIObject_release(self.infoRoot);self.infoRoot=nil;
_UIObject_release(self.kind);self.kind=nil;
_UIObject_release(self.maxtili);self.maxtili=nil;
_UIObject_release(self.nofeature);self.nofeature=nil;
_UIObject_release(self.nohiredState);self.nohiredState=nil;
_UIObject_release(self.notHiredBtn);self.notHiredBtn=nil;
_UIObject_release(self.nvalue);self.nvalue=nil;
_UIObject_release(self.ploygonroot);self.ploygonroot=nil;
_UIObject_release(self.Root);self.Root=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.sex);self.sex=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.titleBG);self.titleBG=nil;
end

















local CmpRecruitShotItemIndex={
self=0,
quality=1,
model=2,
mask=3,
select=4,
state=5,
nostate=6,
lvbg=7,
lvtxt=8,
}




function UIWanBaoXunBaoDui_RecruitmentWin:onLoaded(...)
self:bindComponents()

self.ScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)

self:addNotify(notifyConfig.onWanBaoXunBaoDuiDealCatInterView,function(...)self:onWanBaoXunBaoDuiDealCatInterView(...)end)

UIManager.setMoneyMsgShowState(true,true)
end


function UIWanBaoXunBaoDui_RecruitmentWin:__delete()
self:unbindComponents()
end




function UIWanBaoXunBaoDui_RecruitmentWin:onShow(argtable,afterOnloaded)
self.type=argtable.type or WBXBD_ReCruitment_TYPE.recruit
self.recruitDatas=argtable.catdata or wanBaoXunBaoDuiModel:getRecruitDatas()
self.statelist=argtable.statelist or{}
self.selectIndex=1





local cb=function()
self.Root:setChildCanvasGroupDOFade(1,0.5,nil)
end

self.Root:setChildCanvasGroupAlpha(0)
self:initUI()

if afterOnloaded then
self.bg:setChildUIModelShowTarget(2016,1,{},eAnimationID.common_window_enter,false,false,0,cb)
end

end


function UIWanBaoXunBaoDui_RecruitmentWin:onHide()

end




function UIWanBaoXunBaoDui_RecruitmentWin:onNotHiredBtn()
if not self.statelist[self.selectIndex]then
local data=self.recruitDatas[self.selectIndex]

local func=function()
wanBaoXunBaoDuiController:reqRecruiterResult(data.guid,2)
end
if data.color==4 then
local showdata=
{
type='UIDialouge',
title='提示',
content='是否确定拒绝招聘该仙品猫猫？',
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function(...)
func()
end,
showclosebtn=true,
}
local confirmDialog=UIDialogManager.newDialog(showdata)
confirmDialog:show()
else
func()
end
end
end



function UIWanBaoXunBaoDui_RecruitmentWin:onHiredBtn()
if not self.statelist[self.selectIndex]then
if wanBaoXunBaoDuiModel:isFullEmployee()then
local data=self.recruitDatas[self.selectIndex]
wanBaoXunBaoDuiController:reqRecruiterResult(data.guid,1)
else
UIManager.info('雇员已满员了喵')
end
end
end

function UIWanBaoXunBaoDui_RecruitmentWin:onCloseBtn()

UIFullWanBaoXunBaoDuiController:closeWindow('UIWanBaoXunBaoDui_RecruitmentWin')
end



function UIWanBaoXunBaoDui_RecruitmentWin:initUI()
self:freshRecruitList()
self:freshRecruitInfo()


local state=self.statelist[self.selectIndex]==1
local nostate=self.statelist[self.selectIndex]==2
self.hiredState:setActive(state)
self.nohiredState:setActive(nostate)
self.hiredBtn:setActive(not state and self.statelist[self.selectIndex]==nil and self.type==WBXBD_ReCruitment_TYPE.recruit)
self.notHiredBtn:setActive(not nostate and self.statelist[self.selectIndex]==nil and self.type==WBXBD_ReCruitment_TYPE.recruit)
end

function UIWanBaoXunBaoDui_RecruitmentWin:freshUI(index,state)
self.statelist[self.selectIndex]=state
self.selectIndex=Mathf.Min(self.selectIndex+1,#self.recruitDatas)
self:freshRecruitList()
self:freshRecruitInfo()
end

function UIWanBaoXunBaoDui_RecruitmentWin:freshRecruitList()
self.ScrollView:clearSlowItems()
self.ScrollView:freshSlowGrids(#self.recruitDatas,#self.recruitDatas,1,true)
end

function UIWanBaoXunBaoDui_RecruitmentWin:bindGrid(index,item)
local data=self.recruitDatas[index]
item:SetChildActive(-1,true)

local employeeColor,ab=wanbaoXunBaoDuiHelper:getCatRecruitFrame(data.color)
item:SetChildCSImageSprite(CmpRecruitShotItemIndex.quality,ab,employeeColor)

local modelid,components=wanbaoXunBaoDuiHelper:getCatModelCaptureImageParam(data)
item:SetChildModelCaptureImage(CmpRecruitShotItemIndex.model,modelid,components,3,eAnimationID.idle,0,-140,Vector2(0,0),1,false)


local lcolor,lab=wanbaoXunBaoDuiHelper:getCatLevelFrame(data.color)
item:SetChildCSImageSprite(CmpRecruitShotItemIndex.lvbg,lab,lcolor)
item:SetChildText(CmpRecruitShotItemIndex.lvtxt,data.lv)


item:SetChildActive(CmpRecruitShotItemIndex.select,self.selectIndex==index)

local state=self.statelist[index]==1
local nostate=self.statelist[index]==2
item:SetChildActive(CmpRecruitShotItemIndex.state,self.statelist[index]~=nil and state)
item:SetChildActive(CmpRecruitShotItemIndex.nostate,self.statelist[index]~=nil and nostate)


item:SetBaseItemClickEvent(CmpRecruitShotItemIndex.self,function(itemId,mindex,guid,attach)
local preitem=self.ScrollView:getSlowItemByIndex(self.selectIndex-1)
preitem:SetChildActive(CmpRecruitShotItemIndex.select,false)

self.selectIndex=index
item:SetChildActive(CmpRecruitShotItemIndex.select,true)

self:freshRecruitInfo()
end)
end

function UIWanBaoXunBaoDui_RecruitmentWin:freshRecruitInfo()

local data=self.recruitDatas[self.selectIndex]
local cfg=cfgHelper.get1(cfg_catshowconfig_get,data.wx_id)

local name=cfgHelper.get1(cfg_catnameconfig_get,data.name_id).name
self.nvalue:setText(name)

self.kind:setText(cfg.zz)

local sex=cfg.sex==1 and"公喵"or"母喵"
self.sex:setText(sex)

local maxtili
if self.type==WBXBD_ReCruitment_TYPE.recruit then
maxtili=wanBaoXunBaoDuiModel:caculationMaxTili(data)
else
maxtili=cfgHelper.get2(cfg_catcolorconfig_get,data.color,'tiliMax')
end
self.maxtili:setText(maxtili)

self.nofeature:setActive(data.texing_num==0)
self.featureScrollView:setActive(data.texing_num>0)
if data.texing_num>0 then
self.Content:setChildLayoutGroupCreateItems(#data.txList,function(index)
local txid=data.txList[index]
local item=self.Content:getChildLayoutGroupGridItem(index-1)
local txCfg=cfgHelper.get1(cfg_cattxconfig_get,txid)
local txWb=item:GetChildWidgetBase(0)

local name=UIDiscipleModel.getSpecialityNameStr(txCfg.name)
local abName,frameIcon=UIDiscipleModel.getSpecialityColorFrame(txCfg.frame)
txWb:SetChildCSImageSprite(0,abName,frameIcon)
txWb:SetChildText(1,name)

item:SetChildText(1,txCfg.desc)
end)
end

local widght=self.ploygonroot:getWidgetBase()
local baseAttrList=wanBaoXunBaoDuiModel:getSelectEmployeeBaseAttrData(data)
for k,v in pairs(baseAttrList)do
local attr=baseAttrList[k]
local awidget=widght:GetChildWidgetBase(k)
awidget:SetChildText(1,attr.name)
awidget:SetChildText(2,attr.value)
end

local const_def=wanBaoXunBaoDuiModel:getConstDef()
local plogondata=wanBaoXunBaoDuiModel:getEmployeePloygonData(data,const_def.singlePropMax2)
widght:SetChildUIPolygonImage(6,plogondata,270)

local state=self.statelist[self.selectIndex]==1
local nostate=self.statelist[self.selectIndex]==2
self.hiredState:setActive(state)
self.nohiredState:setActive(nostate)
self.hiredBtn:setActive(not state and self.statelist[self.selectIndex]==nil and self.type==WBXBD_ReCruitment_TYPE.recruit)
self.notHiredBtn:setActive(not nostate and self.statelist[self.selectIndex]==nil and self.type==WBXBD_ReCruitment_TYPE.recruit)
end

function UIWanBaoXunBaoDui_RecruitmentWin:onWanBaoXunBaoDuiDealCatInterView(index,type)
self:freshUI(index,type)
end