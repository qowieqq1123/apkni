







def_class("UISubAct_ChiSeJinDi_CopyDiscipleSellWin",UIWindowBase)









function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.empty=UIObject.get(self,1)
self.itemList=UIObject.get(self,2)
self.moneyBg=UIButton.get(self,3)
self.moneyIcon=UIImage.get(self,4)
self.moneyNum=UIText.get(self,5)
self.scrollView=UIObject.get(self,6)
self.sellBtn=UIButton.get(self,7)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.sellBtn:setButtonClick(function()self:onSellBtn()end)



end


function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.itemList);self.itemList=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.sellBtn);self.sellBtn=nil;
end















local _this=nil
local _itemCmp={
widget=-1,
back=0,
dis_name=1,
rawImage=2,
dis_job=3,
lv_Obj=4,
dis_level=5,
moneyIcon=6,
moneyNum=7,
colorImage=8,
selected=9,
starList=10,
on=11,
}
local _abName="ui/windows/activities/sub_chisejindi/chisejindi_atlas_pak.ab"



function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:onLoaded(...)
self:bindComponents()
_this=self

self.selectLookup={}

socketManager:addNotify(249,241,self.on_249_241)
end


function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:__delete()
self:unbindComponents()
_this=nil

socketManager:removeNotify(249,241,self.on_249_241)
end




function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:onShow(argtable,afterOnloaded)

self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.parentWin=argtable.parentWin


self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.copyData=self.info:getCopy()
self.teamData=self.info:getTeam()

self:updateData()

self:initView()
self:refreshMoney()
self:refreshView()
end


function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:onHide()

end




function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:onCloseBtn()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:onMoneyBg()
tipsManager.showTips({itemid=self.config.chanceMoney})
end

function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:onSellBtn()
if next(self.selectLookup)==nil then
UIManager.error("请先选择解雇弟子")
return
end

local temp={}
for i,v in pairs(self.selectLookup)do
table.insert(temp,i)
end
if#temp>=#self.discipleDatas then
UIManager.error("需要至少保留一名弟子")
return
end

UIDialogManager.getCommonDialog(nil,"确定解雇选中弟子？",function()
call_activitiesHandle_func("activitiesHandle_chisejindi","reqSellCopyItem",self.actId,self.subId,eChiSeJinDiRoundType.Disciple,temp)
end)
end

function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:onClickItem(item,id)
self.selectLookup[id]=(not self.selectLookup[id])or nil
item:SetChildActive(_itemCmp.selected,self.selectLookup[id])
end

function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:onLongTouchItem(disciple)
local pos=self.onLookup[disciple]
local weapon=pos and self.teamData[pos].weapon or 0
local args={
actId=self.actId,
subType=self.subType,
subId=self.subId,
roleList={
{
disciple=disciple,
weapon=weapon>0 and weapon or nil,
}
},
parentWin=self,
}
self:showWindow("UISubAct_ChiSeJinDi_CopyDiscipleDetailWin",args)
end

function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:initView()
self.moneyIcon:setImageIcon(iconHelper.getIconName(self.config.chanceMoney),false)
end

function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:refreshMoney()
local moneyStr=mathHelper.formatNumber(self.copyData.money)
self.moneyNum:setText(moneyStr)
end

function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:updateData()
self.onLookup=self.info:getTeamLookup_Disciple()
self.discipleDatas=self.copyData.discipleList
if#self.discipleDatas>1 then
local discipleServer=self.config.disciple

table.sort(self.discipleDatas,function(a,b)
local colorA=discipleServer[a][5]
local colorB=discipleServer[b][5]
if colorA~=colorB then
return colorA>colorB
else
return a<b
end
end)
end
end

function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:refreshView()
local len=#self.discipleDatas
local have=len>0
self.scrollView:setActive(have)
self.empty:setActive(not have)
if have then
self.itemList:setChildLayoutGroupCreateItems(len,function(index)
local item=self.itemList:getChildLayoutGroupGridItem(index-1)
local id=self.discipleDatas[index]
self:refreshItem(item,id)
end)
end
end

function UISubAct_ChiSeJinDi_CopyDiscipleSellWin:refreshItem(item,id)
local pos=self.onLookup[id]
local serverCfg=self.config.disciple[id]
local star=self.info:getCopyItemStar(id)
local monsterId=serverCfg[1]
local sellNum=serverCfg[4]
local color=serverCfg[5]
local jingjielv=self.config.discipleJJ[id]
local job=serverCfg[6]
local inside=self.config.discipleInside[id]
local monsterCfg=cfgHelper.get1(cfg_monsterconfig_get,monsterId)
local modelParams={
body=inside[1],
componets=inside[2]or{},
}
item:SetChildCSImageSprite(_itemCmp.back,globalABLookup.diciplecolorframe,discipleColorToFrame[color])
item:SetChildCSImageSprite(_itemCmp.dis_job,globalABLookup.global,UIDiscipleModel:getJobIconName(job))
item:SetChildText(_itemCmp.dis_name,monsterCfg.name)
comHelper.setChildModelRawImageEx(_itemCmp.rawImage,item,modelParams,eHeadCenterType.eHead)
item:SetChildCSImageSprite(_itemCmp.colorImage,_abName,FMT.fmt("image_chiseshilian_pz{0}",color))
item:SetChildCSImageSprite(_itemCmp.lv_Obj,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])
item:SetChildText(_itemCmp.dis_level,jingjielv)
item:SetChildButtonClick(_itemCmp.widget,function()
self:onClickItem(item,id)
end)
item:SetChildCSImageIcon(_itemCmp.moneyIcon,iconHelper.getIconName(self.config.chanceMoney),false)
item:SetChildText(_itemCmp.moneyNum,sellNum)
item:SetChildActive(_itemCmp.selected,self.selectLookup[id]or false)
item:SetChildLongTouch(_itemCmp.widget,0,1,function(...)self:onLongTouchItem(id)end)
item:SetChildLayoutGroupCreateItems(_itemCmp.starList,star)
item:SetChildActive(_itemCmp.on,pos~=nil)
end

function UISubAct_ChiSeJinDi_CopyDiscipleSellWin.on_249_241(actId,subId,roundtype,len,ids)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
_this:refreshMoney()
for i,v in ipairs(ids)do
_this.selectLookup[v]=nil
end
_this:updateData()
_this:refreshView()
end
end