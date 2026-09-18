







def_class("UIGuanLianWin",UIWindowBase)









function UIGuanLianWin:bindComponents()

self.blackBG=UIObject.get(self,0)
self.descRoot=UIObject.get(self,1)
self.item1=UIObject.get(self,2)
self.item2=UIObject.get(self,3)
self.itemrootbg=UIImage.get(self,4)
self.root=UIObject.get(self,5)
self.title=UIText.get(self,6)
self.changbtn=UIButton.get(self,7)

self.changbtn:setButtonClick(function()self:onChangbtn()end)



end


function UIGuanLianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.blackBG);self.blackBG=nil;
_UIObject_release(self.descRoot);self.descRoot=nil;
_UIObject_release(self.item1);self.item1=nil;
_UIObject_release(self.item2);self.item2=nil;
_UIObject_release(self.itemrootbg);self.itemrootbg=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.changbtn);self.changbtn=nil;
end



















local cmp=
{
icon=1,
itembg=2,
itemname=3,
head=4,
itembg2=5,
}

local colorcmp=
{
[eQualityColor.eRed]='image_liandongdi_06',
[eQualityColor.eOrange]='image_liandongdi_05',
[eQualityColor.ePurple]='image_liandongdi_07',
}
local abname="ui/windows/common/liandong_atlas_pak.ab"

function UIGuanLianWin:onLoaded(...)
self:bindComponents()
end


function UIGuanLianWin:__delete()
self:unbindComponents()
end


function UIGuanLianWin:onChangbtn()
if self.ischangwin and self.isldchang and self.oldchangdata and self.newchangdata then

local key=FMT.fmt('changeDiscipleimageVoc_{0}',tostring(self.dzguid))
local _ysdzdjsTime=userActorSetting.get(key,0)
local nowTime=timeHelper.getServerLongTime()
if _ysdzdjsTime>0 and nowTime<_ysdzdjsTime then
local desc='弟子还未适应新容貌\n暂时无法发功再次易容'
local show_data=
{
title='提示',
ysdztxt=desc,
oktext="确定",
canceltext="取消",
ysdzdjsTime=_ysdzdjsTime,
}
UIManager:showWindow('UIDialougeYJDZtips',show_data)
else
local _fun=function()
UIDiscipleController:send_2_176(self.dzguid,self.newchangdata[2])
end
local str=''
if self.changtype==1 then
str=FMT.fmt("是否把<color=#ca631d>{0}</color>的形象易容为\n异世弟子<color=#ca631d>{1}</color>的形象",self.oldchangdata[1],self.newchangdata[1])
else
str=FMT.fmt("是否把异世弟子<color=#ca631d>{0}</color>的形象\n恢复为<color=#ca631d>{1}</color>的形象",self.oldchangdata[1],self.newchangdata[1])
end
local showdata=
{
type='UIDialouge',
title='提示',
content=str,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=_fun,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end
end
end




function UIGuanLianWin:onShow(argtable,afterOnloaded)
self.itemid1=argtable[1]
self.itemid2=argtable[2]
self.tipsType=argtable[3]
self.widget1=self.item1:getWidgetBase()
self.widget2=self.item2:getWidgetBase()
self.widget1:SetChildActive(cmp.itembg2,false)
self.widget2:SetChildActive(cmp.itembg2,false)
self.changbtn:setActive(false)
if argtable.dzguid or argtable.dzid then

self.dzguid=argtable.dzguid
self.dzid=argtable.dzid
self:SetDZwin()
self:setdizichange()
self.itemrootbg:setSprite(abname,"image_liandongdi_01",false)
self.title:setText("异世弟子")
elseif argtable.GFid then
self:SetGFWin()
self.itemrootbg:setSprite(abname,"image_liandongdi_02",false)
self.title:setText("异世功法")
elseif self.tipsType and(self.tipsType==TIPS_TYPE.eCommonGubao or self.tipsType==TIPS_TYPE.eCommonGubaoMetrial)then

self:SetGBWin()
self.itemrootbg:setSprite(abname,"image_liandongdi_04",false)
self.title:setText("异世古宝")
elseif self.tipsType and self.tipsType==TIPS_TYPE.eCommonXianBao then

self:SetXBWin()
self.itemrootbg:setSprite(abname,"image_liandongdi_03",false)
self.title:setText("异世仙宝")
end

end


function UIGuanLianWin:onHide()

end


function UIGuanLianWin:SetItem(widget,itemConfig)
widget:SetChildCSImageIcon(cmp.icon,iconHelper.getItemIconName(itemConfig.icon),false)
widget:SetChildCSImage(cmp.itembg,abname,colorcmp[itemConfig.color],false)
local name=itemConfig.name
local str=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[itemConfig.color],name)
widget:SetChildText(cmp.itemname,str)
end


function UIGuanLianWin:setdizichange()
if self.ischangwin then
self.isldchang=UIDiscipleModel:isLianDongChangDiscipleImage(self.dzguid)
if self.isldchang then
self.changbtn:setActive(true)
local OutnetData=UIDiscipleModel:getDiscipleData(self.dzguid)
local disguise=OutnetData.disguise

local cfg1=cfgHelper.get1(cfg_discipleconfig_get,self.dizi_1)
local cfg2=cfgHelper.get1(cfg_discipleconfig_get,self.dizi_2)
local zhaomuItemid1=cfg1.zhaomuItemid
local name1=cfg1.name
local name2=cfg2.name




if disguise==0 or disguise==self.dizi_1 then
self.oldchangdata={name1,self.dizi_1}
self.newchangdata={name2,self.dizi_2}
self.changtype=1
else
self.oldchangdata={name2,self.dizi_2}
self.newchangdata={name1,self.dizi_1}
self.changtype=2
end
end
else
self.changbtn:setActive(false)
end
end


function UIGuanLianWin:SetDZwin()
local dzID=nil
if self.dzguid then
local dzguid=self.dzguid
local netData=UIDiscipleModel:getDiscipleData(self.dzguid)
dzID=UIDiscipleModel:getDiscipleIDEx(netData)

local defaultVersionId=pfwindowslController:getGameVersion()

local iSTable=cfgHelper.get2(cfg_discipleconfig_get,dzID,'isShowyr')
if iSTable and iSTable[defaultVersionId]then
self.ischangwin=true
end
elseif self.dzid then
dzID=self.dzid
end
self.nowdzid=dzID

local glid,main=liandonModel:CheckDiZi_Guanlian(dzID)
self.dizi_1=dzID
self.dizi_2=glid
if main==2 then
self.dizi_2=dzID
self.dizi_1=glid
end

self.widget1:SetChildActive(cmp.head,true)
comHelper.setChildModelRawImageByDiziId(self.widget1,self.dizi_1,cmp.head,0,eHeadCenterType.eHead)

self.widget2:SetChildActive(cmp.head,true)
comHelper.setChildModelRawImageByDiziId(self.widget2,self.dizi_2,cmp.head,0,eHeadCenterType.eHead)

local cfg1=cfgHelper.get1(cfg_discipleconfig_get,self.dizi_1)
local cfg2=cfgHelper.get1(cfg_discipleconfig_get,self.dizi_2)
local zhaomuItemid1=cfg1.zhaomuItemid
local zhaomuItemid2=cfg2.zhaomuItemid
self.widget1:SetChildButtonClick(cmp.itembg2,function()
tipsManager.closeTips()
UIRecruitControl:showItemDiscipleInfoByItemId2(zhaomuItemid1)
self:closeSelf()
end)
self.widget2:SetChildButtonClick(cmp.itembg2,function()
tipsManager.closeTips()
UIRecruitControl:showItemDiscipleInfoByItemId2(zhaomuItemid2)
self:closeSelf()
end)
local itemConfig_1=itemsConfig.getConfig(zhaomuItemid1)
local itemConfig_2=itemsConfig.getConfig(zhaomuItemid2)
self.widget1:SetChildActive(cmp.itembg,false)
self.widget2:SetChildActive(cmp.itembg,false)
self.widget1:SetChildActive(cmp.itembg2,true)
self.widget2:SetChildActive(cmp.itembg2,true)
comHelper.setChildModelHeadIconBGByColor(self.widget1,cmp.itembg2,itemConfig_1.color)
comHelper.setChildModelHeadIconBGByColor(self.widget2,cmp.itembg2,itemConfig_2.color)

local name1=cfg1.name
local str=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[itemConfig_1.color],name1)
self.widget1:SetChildText(cmp.itemname,str)
local name2=cfg2.name
local str=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[itemConfig_2.color],name2)
self.widget2:SetChildText(cmp.itemname,str)

local name1=cfg1.name
local strname1=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[itemConfig_1.color],name1)
local name2=cfg2.name
local strname2=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[itemConfig_2.color],name2)
local introduction_text=cfgHelper.get2(cfg_linkageresourceconfig_get,liandongZY.dizi,"introduction_text")
self:Setdesc(introduction_text,strname1,strname2)
end


function UIGuanLianWin:SetGFWin()
local glid,main=liandonModel:CheckGongFa_Guanlian(self.itemid1)
if main==2 then


self.itemid2=self.itemid1
self.itemid1=glid
end

local cfg1=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.itemid1)
local itemidtable=gongfaLookup:checkpiecesgongfa(self.itemid1)
local itemid=itemidtable[1]
local itemConfig_1=itemsConfig.getConfig(itemid)

self.widget1:SetChildCSImageIcon(cmp.icon,iconHelper.getItemIconName(itemConfig_1.icon),false)
self.widget1:SetChildCSImage(cmp.itembg,abname,colorcmp[cfg1.color],false)
local name=cfg1.name
local str=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[cfg1.color],name)
self.widget1:SetChildText(cmp.itemname,str)
self.widget1:SetChildButtonClick(cmp.icon,function()
tipsManager.closeTips()
UIManager:closeWindow('UIGongFaTipsThreeWin')
UIManager:showWindow('UIGongFaTipsThreeWin',{gfID=self.itemid1})
self:closeSelf()
end)




local cfg2=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.itemid2)
local itemidtable=gongfaLookup:checkpiecesgongfa(self.itemid2)
local itemid=itemidtable[1]
local itemConfig_2=itemsConfig.getConfig(itemid)

self.widget2:SetChildCSImageIcon(cmp.icon,iconHelper.getItemIconName(itemConfig_2.icon),false)
self.widget2:SetChildCSImage(cmp.itembg,abname,colorcmp[cfg2.color],false)
local name=cfg2.name
local str=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[cfg2.color],name)
self.widget2:SetChildText(cmp.itemname,str)
self.widget2:SetChildButtonClick(cmp.icon,function()
tipsManager.closeTips()
UIManager:closeWindow('UIGongFaTipsThreeWin')
UIManager:showWindow('UIGongFaTipsThreeWin',{gfID=self.itemid2})
self:closeSelf()
end)

local name=cfg1.name
local strname1=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[cfg1.color],name)
local name=cfg2.name
local strname2=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[cfg2.color],name)
local introduction_text=cfgHelper.get2(cfg_linkageresourceconfig_get,liandongZY.gongfa,"introduction_text")
self:Setdesc(introduction_text,strname1,strname2)
end


function UIGuanLianWin:SetXBWin()
local glid,main=liandonModel:CheckXB_Guanlian(self.itemid1)
if main==2 then


self.itemid2=self.itemid1
self.itemid1=glid
end

local itemid_1=xianbaoModel:checkActiveItemID(self.itemid1)
local itemid_2=xianbaoModel:checkActiveItemID(self.itemid2)
local itemConfig_1=itemsConfig.getConfig(itemid_1)
local itemConfig_2=itemsConfig.getConfig(itemid_2)

self:SetItem(self.widget1,itemConfig_1)

self:SetItem(self.widget2,itemConfig_2)
self.widget1:SetChildButtonClick(cmp.icon,function()
tipsManager.showTipsXB({attach={xbItemId=itemid_1},formType=TIPS_FORM_TYPE.eXianBaoTujian,tipsType=TIPS_TYPE.eCommonXianBao,itemid=self.itemid1,bg=false,funType=TIPS_FUNC_TYPE.eXianBao})
self:closeSelf()
end)
self.widget2:SetChildButtonClick(cmp.icon,function()
tipsManager.showTipsXB({attach={xbItemId=itemid_2},formType=TIPS_FORM_TYPE.eXianBaoTujian,tipsType=TIPS_TYPE.eCommonXianBao,itemid=self.itemid2,bg=false,funType=TIPS_FUNC_TYPE.eXianBao})
self:closeSelf()
end)
local name=itemConfig_1.name
local strname1=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[itemConfig_1.color],name)
local name=itemConfig_2.name
local strname2=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[itemConfig_2.color],name)
local introduction_text=cfgHelper.get2(cfg_linkageresourceconfig_get,liandongZY.xianbao,"introduction_text")
self:Setdesc(introduction_text,strname1,strname2)
end


function UIGuanLianWin:SetGBWin()
local glid,main=liandonModel:CheckGB_Guanlian(self.itemid1)
if main==2 then


self.itemid2=self.itemid1
self.itemid1=glid
end

local itemid_1=gubaoLookup:gubao2GoodActive(self.itemid1)
local itemid_2=gubaoLookup:gubao2GoodActive(self.itemid2)
local itemConfig_1=itemsConfig.getConfig(itemid_1)
local itemConfig_2=itemsConfig.getConfig(itemid_2)

self:SetItem(self.widget1,itemConfig_1)
self:SetItem(self.widget2,itemConfig_2)
self.widget1:SetChildButtonClick(cmp.icon,function()

tipsManager.showTipsGB({formType=TIPS_FORM_TYPE.eGubaoWin,tipsType=TIPS_TYPE.eCommonGubao,itemid=self.itemid1,bg=false})
self:closeSelf()
end)
self.widget2:SetChildButtonClick(cmp.icon,function()
tipsManager.showTipsGB({formType=TIPS_FORM_TYPE.eGubaoWin,tipsType=TIPS_TYPE.eCommonGubao,itemid=self.itemid2,bg=false})
self:closeSelf()
end)
local name=itemConfig_1.name
local strname1=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[itemConfig_1.color],name)
local name=itemConfig_2.name
local strname2=string.format("<color=%s>%s</color>",FONT_TIPS_COLOR_VAL[itemConfig_2.color],name)
local introduction_text=cfgHelper.get2(cfg_linkageresourceconfig_get,liandongZY.gubao,"introduction_text")
self:Setdesc(introduction_text,strname1,strname2)
end

function UIGuanLianWin:Setdesc(introduction_text,strname1,strname2)
self.descRoot:setChildLayoutGroupCreateItems(#introduction_text,function(index)
local item=self.descRoot:getChildLayoutGroupGridItem(index-1)
local str=FMT.fmt(introduction_text[index],strname1,strname2)
item:SetChildText(0,str)
end)
end


