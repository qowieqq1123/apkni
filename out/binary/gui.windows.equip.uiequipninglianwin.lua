







def_class("UIEquipNingLianWin",UIWindowBase)









function UIEquipNingLianWin:bindComponents()

self.leftDialogue=UIButton.get(self,0)
self.disciplePanel=UIObject.get(self,1)
self.leftPanel=UIObject.get(self,2)
self.effectRoot=UIObject.get(self,3)
self.leftdialogueinfo=UIObject.get(self,4)
self.equipList=UIObject.get(self,5)
self.effect1=UIObject.get(self,6)
self.effect2=UIObject.get(self,7)
self.effect3=UIObject.get(self,8)
self.effect4=UIObject.get(self,9)
self.effect0=UIObject.get(self,10)
self.effect=UIObject.get(self,11)
self.effect5=UIObject.get(self,12)
self.ScrollView=UIScrollViewSlow.get(self,13)
self.Dropdown2_Dialogue=UIDropdownEx.get(self,14)
self.Dropdown1_Dialogue=UIDropdownEx.get(self,15)
self.putBtnReddot_Dialogue=UIObject.get(self,16)
self.name=UIText.get(self,17)
self.discipleList=UIScrollView.get(self,18)
self.equipone=UIBaseItem.get(self,19)
self.equiptwo=UIBaseItem.get(self,20)
self.tipsbtn=UIButton.get(self,21)
self.descItem1=UIImage.get(self,22)
self.descItem2=UIImage.get(self,23)
self.descItem3=UIImage.get(self,24)
self.rwItem=UIObject.get(self,25)
self.cost1=UIObject.get(self,26)
self.nlbtn=UIButton.get(self,27)
self.thbtn=UIButton.get(self,28)
self.ScrollView2=UIObject.get(self,29)
self.cost2=UIObject.get(self,30)
self.btnpanel=UIObject.get(self,31)
self.maxtxt=UIText.get(self,32)
self.nlreddot=UIObject.get(self,33)
self.xmcctxt=UIText.get(self,34)

self.leftDialogue:setButtonClick(function()self:onLeftDialogue()end)

self.tipsbtn:setButtonClick(function()self:onTipsbtn()end)

self.nlbtn:setButtonClick(function()self:onNlbtn()end)

self.thbtn:setButtonClick(function()self:onThbtn()end)
self.Dropdown2={
["Dialogue"]=self.Dropdown2_Dialogue,
}
self.Dropdown1={
["Dialogue"]=self.Dropdown1_Dialogue,
}
self.putBtnReddot={
["Dialogue"]=self.putBtnReddot_Dialogue,
}



end


function UIEquipNingLianWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.leftDialogue);self.leftDialogue=nil;
_UIObject_release(self.disciplePanel);self.disciplePanel=nil;
_UIObject_release(self.leftPanel);self.leftPanel=nil;
_UIObject_release(self.effectRoot);self.effectRoot=nil;
_UIObject_release(self.leftdialogueinfo);self.leftdialogueinfo=nil;
_UIObject_release(self.equipList);self.equipList=nil;
_UIObject_release(self.effect1);self.effect1=nil;
_UIObject_release(self.effect2);self.effect2=nil;
_UIObject_release(self.effect3);self.effect3=nil;
_UIObject_release(self.effect4);self.effect4=nil;
_UIObject_release(self.effect0);self.effect0=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.effect5);self.effect5=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.Dropdown2_Dialogue);self.Dropdown2_Dialogue=nil;
_UIObject_release(self.Dropdown1_Dialogue);self.Dropdown1_Dialogue=nil;
_UIObject_release(self.putBtnReddot_Dialogue);self.putBtnReddot_Dialogue=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.discipleList);self.discipleList=nil;
_UIObject_release(self.equipone);self.equipone=nil;
_UIObject_release(self.equiptwo);self.equiptwo=nil;
_UIObject_release(self.tipsbtn);self.tipsbtn=nil;
_UIObject_release(self.descItem1);self.descItem1=nil;
_UIObject_release(self.descItem2);self.descItem2=nil;
_UIObject_release(self.descItem3);self.descItem3=nil;
_UIObject_release(self.rwItem);self.rwItem=nil;
_UIObject_release(self.cost1);self.cost1=nil;
_UIObject_release(self.nlbtn);self.nlbtn=nil;
_UIObject_release(self.thbtn);self.thbtn=nil;
_UIObject_release(self.ScrollView2);self.ScrollView2=nil;
_UIObject_release(self.cost2);self.cost2=nil;
_UIObject_release(self.btnpanel);self.btnpanel=nil;
_UIObject_release(self.maxtxt);self.maxtxt=nil;
_UIObject_release(self.nlreddot);self.nlreddot=nil;
_UIObject_release(self.xmcctxt);self.xmcctxt=nil;
self.Dropdown2=nil;
self.Dropdown1=nil;
self.putBtnReddot=nil;
end
















local _this
local abname="ui/windows/equip/chongzhu_atlas_pak.ab"
local equipSlotIndex={
[EQUIP_TYPE.eWeapon]=0,
[EQUIP_TYPE.eClothes]=1,
[EQUIP_TYPE.eCap]=2,
[EQUIP_TYPE.eShoot]=3,
}
local _equipTypeLookup={}
for k,v in pairs(equipSlotIndex)do
_equipTypeLookup[v]=k
end
local _itemWidgetIdx=
{
cmpItemQualityIdx=0,
cmpItemIconIdx=1,
cmpItemTxtCount=2,
cmpItemAdd=3,
cmpItemName=4,
cmpItemStage=5,
cmpItemStageBg=6,
cmpItemNew=7,
cmpItemReddot=8,
cmpLock=9,
cmpFabaoTag=10,
cmpCountBg=11,
cmpStar=12,
cmpSuitIcon=13,
cmpSelect=14,
xmicons=15,
xmstagetxt=16,
xmtxt=17,
}
local ccitemidx=
{
selfitem=0,
img=1,
txt=2,
descs={3,4,5,6,7}
}
local moneyidx=
{
selfcost=0,
micon=1,
mtxt=2
}




function UIEquipNingLianWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChange)
self._on_select_dis=function(...)
self:on_select_dis(...)
end
self.discipleList:setClickAction(self._on_select_dis)
self.isInitDiscipleList=false

self.equipListWidget=self.equipList:getChildWidgetBase()
for equipType,idx in ipairs(equipSlotIndex)do
self.equipListWidget:SetBaseItemClickEvent(idx,function(...)self:onBaseItemClick(...)end)
self.equipListWidget:SetBaseItemChildIndex(idx,equipType)
end
self.equipxm={self.equipone,self.equiptwo}
self.descItems={self.descItem1,self.descItem2,self.descItem3}
self.costMoney={self.cost1,self.cost2}
end


function UIEquipNingLianWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.on_item_changed,self.on_item_changed)
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChange)
_this=nil
end


function UIEquipNingLianWin:onHide()
self.discipleList:setActive(false)
self.equipList:setActive(false)
end

function UIEquipNingLianWin:resetData()
end

function UIEquipNingLianWin:onEquipClickNobtn(itemid,itemguid)
tipsManager.showTips({formType=TIPS_FORM_TYPE.eNoBtns,itemid=itemid,itemguid=itemguid,})
end

function UIEquipNingLianWin:onTipsbtn()
local d={}
d.title='规则'
d.mode=3
d.name='UIEquipNingLianWin_Tips_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end

function UIEquipNingLianWin:onNlbtn()
local equip=self.item
local ninglian_star=equipsModel.getNingLianStar(equip)
local maxstar=equipsModel.getNingLianMaxStar(equip.itemid)
if ninglian_star<maxstar then
local uplvl=ninglian_star+1
local cost,effect_id,percent=equipsModel.getEquipXMNingLianData(equip.itemid,uplvl)
if cost then
for k,v in ipairs(cost)do
local itemid=v[1]
local itemnum=v[2]
local havecount=0
if moneyConfig.isMoney(itemid)then
havecount=moneyModel.getMoney(itemid)
else
havecount=bagModel.getItemCountById(itemid)
end
if havecount<itemnum then
gainControl:showGainWin(itemid)
return
end
end
end



equipsProtocolControl:send_2_162(equip.itemguid)
end
end

function UIEquipNingLianWin:onThbtn()

local equip=self.item















self:showWindow("UIXMEpuipChongZhiWin",{item=equip})
end

function UIEquipNingLianWin.on_item_changed(changeType,itemguid,itemid,lastcount,itemcount)
if _this==nil then
return
end
_this:refreshXMBtn()
end

function UIEquipNingLianWin.onMoneyChange(moneyType,lastVal,val)
if _this==nil then
return
end
_this:refreshXMBtn()
end




function UIEquipNingLianWin:onShow(argtable,afterOnloaded)
self:freshEquip(argtable)
end

function UIEquipNingLianWin:freshEquip(argtable)
self:resetData()
if argtable then
local itemguid=argtable.itemguid
self.item=equipsHelper.getEquip(itemguid)
local isEquip=equipsModel.isEquipedOnAnyDizi(itemguid)
self.isEquip=isEquip
end
self.disciplelist={}
if self.isEquip then
self.disciple_guid=equipsModel.getDiziguidByItemguid(argtable.itemguid)
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)
local sortType=UIDiscipleModel:getSaveSortType()
local sortCondition=UIDiscipleModel:getSaveSortCondition()
local sortOrder=eSortOrder.eDown
local sortParams={true}
local list=discipleLookup:getSortDiscipleList(sortType,sortCondition,sortOrder,sortParams)
for i,v in ipairs(list)do
local equipList=equipsModel.getAllEquipsByDizi(v.netData.net.discipleguid)
if equipList and#equipList>0 then
table.insert(self.disciplelist,v)
end
end
for i,v in ipairs(self.disciplelist)do
local netdata=v.netData.net
if mathHelper.compareInt64(netdata.discipleguid,self.disciple_guid)then
self.curDisIndex=i
break
end
end
end
local len=#self.disciplelist
if len>0 then
if not self.isInitDiscipleList then
self.isInitDiscipleList=true
self:refreshDiscipleList()
self:refreshEquipList()
else
self.discipleList:setActive(true)
self.equipList:setActive(true)
end
end
self.disciplePanel:setActive(len>0)
if not self.isEquip then
self.equipList:setActive(false)
end


if self.item then
local itemid=self.item.itemid
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
self.xmcctxt:setText("仙道传承")
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
self.xmcctxt:setText("魔道传承")
end
end

self:refreshXMLeft()
self:refreshXMRight()
self:refreshXMBtn()
self:freshreddot()
end


function UIEquipNingLianWin:RefreshNingLing()
_this:refreshXMLeft()
_this:refreshXMRight()
_this:refreshXMBtn()
_this:freshreddot()
_this:refreshEquipList()
end

function UIEquipNingLianWin:chenggongEffect()
_this.effect:setChildShowEffect(10060,true)
end
function UIEquipNingLianWin:freshreddot()
local equip=self.item
local red=equipsModel.isReddotEquipNingLian(equip.itemguid)
self.nlreddot:setActive(red)
end


function UIEquipNingLianWin:refreshXMLeft()
local equip=self.item
local ninglian_star=equipsModel.getNingLianStar(equip)
for i=1,2 do
local widget=self.equipxm[i]:getChildWidgetBase()
if i==2 then
ninglian_star=ninglian_star+1
local maxstar=equipsModel.getNingLianMaxStar(equip.itemid)
if ninglian_star>maxstar then
ninglian_star=maxstar
end
end
if i==1 and equip then
widget:SetBaseItemClickEvent(-1,function()
self:onEquipClickNobtn(equip.itemid,equip.itemguid)
end)
end
self:fillItemXM(equip,widget,ninglian_star)
end
end
function UIEquipNingLianWin:fillItemXM(equip,widget,ninglianStar)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local xmstageStr=''
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=showStage and FMT.fmt('仙·{0}{1}',stage,stageTitile)or''
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=showStage and FMT.fmt('魔·{0}{1}',stage,stageTitile)or''
end
local star=0
local reddot=false
local suitIconName=''
if itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
suitIconName=equipsHelper.getEquipSuitIcon(equip)
end
widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)

widget:SetChildText(_itemWidgetIdx.xmtxt,'')
local percent=equipsModel.getEquipXMNingLianZY(itemid,ninglianStar)
if percent then
widget:SetChildText(_itemWidgetIdx.xmtxt,FMT.fmt('基础属性+{0}%',percent))
end

widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildText(_itemWidgetIdx.xmstagetxt,xmstageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~=''or xmstageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end

if ninglianStar and ninglianStar>0 then
widget:SetChildActive(_itemWidgetIdx.xmicons,true)
local xmWidget=widget:GetChildWidgetBase(_itemWidgetIdx.xmicons)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_jinlian1")
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_moyan1")
end
else
xmWidget:SetChildActive(i-1,false)
end
end
else
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
end
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildText(_itemWidgetIdx.xmstagetxt,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildText(_itemWidgetIdx.xmtxt,'')
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
end
end


function UIEquipNingLianWin:refreshXMRight()

local effect_idlist=self:getChuangChenIdList()
if effect_idlist then
self.ScrollView2:setActive(true)
local equip=self.item
local ninglian_star=equipsModel.getNingLianStar(equip)

for k,v in ipairs(self.descItems)do
local widget=v:getChildWidgetBase()
if effect_idlist[k]then
widget:SetChildActive(ccitemidx.selfitem,true)


local nl_lvl=effect_idlist[k][2]
if ninglian_star>=nl_lvl then
widget:SetChildActive(ccitemidx.img,true)
widget:SetChildActive(ccitemidx.txt,false)
widget:SetChildCSImageSprite(ccitemidx.selfitem,abname,"image_zbnl_xxd1")
else
widget:SetChildActive(ccitemidx.img,false)
widget:SetChildActive(ccitemidx.txt,true)
widget:SetChildCSImageSprite(ccitemidx.selfitem,abname,"image_zbnl_xxd2")
local str=FMT.fmt("凝炼{0}次\n激活",nl_lvl)
widget:SetChildText(ccitemidx.txt,str)
end


local effect_id=effect_idlist[k][1]
local cfg=cfg_discipleequipxmccconfig_get(effect_id)
local desclist=cfg.desc
for i,descarry in ipairs(ccitemidx.descs)do
if desclist[i]then
widget:SetChildActive(ccitemidx.descs[i],true)
















if ninglian_star>=nl_lvl then
local _str=desclist[i]
_str=string.gsub(_str," ","\194\160")
widget:SetChildText(ccitemidx.descs[i],desclist[i])
else
local _str=desclist[i]
_str=string.gsub(_str," ","\194\160")
local clearRichStr=string.gsub(_str,"<[^>]+>","")
widget:SetChildText(ccitemidx.descs[i],FMT.fmt("<color=#827f78>{0}</color>",clearRichStr))
end

else
widget:SetChildActive(ccitemidx.descs[i],false)
end
end

else
widget:SetChildActive(ccitemidx.selfitem,false)
end
end
else
self.ScrollView2:setActive(false)
end
end

function UIEquipNingLianWin:getChuangChenIdList()
local list={}
local equip=self.item
local ninglian_conf=equipsModel.getEquipXMNingLianCfg(equip.itemid)
if ninglian_conf then
for k,v in ipairs(ninglian_conf)do
if v.effect_id and v.effect_id~=0 then
table.insert(list,{v.effect_id,k})
end
end
end
return list
end


function UIEquipNingLianWin:refreshXMBtn()
local equip=self.item
local ninglian_star=equipsModel.getNingLianStar(equip)
local maxstar=equipsModel.getNingLianMaxStar(equip.itemid)
if ninglian_star<maxstar then
self.btnpanel:setActive(true)
self.maxtxt:setActive(false)
local uplvl=ninglian_star+1
local cost,effect_id,percent=equipsModel.getEquipXMNingLianData(equip.itemid,uplvl)

if cost then

local rwItem=self.rwItem:getChildWidgetBase()
local costdata1=cost[1]
local itemid=costdata1[1]
local itemnum=costdata1[2]
local havecount=bagModel.getItemCountById(itemid)
local graynum=0
local itemcount=""
if havecount>=itemnum then
itemcount=FMT.fmt('{0}/{1}',havecount,itemnum)
else
itemcount=FMT.fmt('<color=#f36666>{0}/{1}</color>',havecount,itemnum)
graynum=0
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=true,showStage=true,showname=false,gray=graynum}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rwItem:SetChildPropData(1,prop)
rwItem:SetBaseItemClickEvent(1,function(...)
if _this==nil then return end
self:onClickItem(...)
end)


if#cost>1 then
for k,v in ipairs(self.costMoney)do
local mwidget=v:getChildWidgetBase()
if cost[k+1]then
mwidget:SetChildActive(moneyidx.selfcost,true)
local costdata=cost[k+1]
local mtype=costdata[1]
local mval=costdata[2]
local bagnum=0
if moneyConfig.isMoney(mtype)then
bagnum=moneyModel.getMoney(mtype)
else
bagnum=bagModel.getItemCountById(mtype)
end





if bagnum>=mval then
bagnum=FMT.fmt('{0}',mathHelper.formatNumber9(mval,1))
else
bagnum=FMT.fmt('<color=#c82c2c>{0}</color>',mathHelper.formatNumber9(mval,1))
end
mwidget:SetChildIcon(moneyidx.micon,iconHelper.getIconName(mtype),false)
mwidget:SetChildText(moneyidx.mtxt,bagnum)
else
mwidget:SetChildActive(moneyidx.selfcost,false)
end
end
end
end
else
self.btnpanel:setActive(false)
self.maxtxt:setActive(true)
end


if ninglian_star and ninglian_star>0 then
self.thbtn:setActive(true)
else
self.thbtn:setActive(false)
end
end

function UIEquipNingLianWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end


function UIEquipNingLianWin:refreshDiscipleList()
local tNum=#self.disciplelist
self.discipleList:freshGridsNum(tNum,tNum,1,true)
local idx=1
for i=1,tNum do
local item=self.discipleList:getGridObjectByindex(i-1)
local netdata=self.disciplelist[i].netData.net
local discipleguid=netdata.discipleguid
comHelper.setChildModelHeadIconBG(item,0,discipleguid)

UIDiscipleModel:setDiscipleXianMoHeadImage(item,8,netdata)

comHelper.setChildModelRawImage(item,discipleguid,1,0,eHeadCenterType.eHead)

local isSelect=mathHelper.compareInt64(self.disciple_guid,discipleguid)
if isSelect then
idx=i
self.curDisIndex=idx
end
self:changItemSelect(item,isSelect)

self:refreshItemReddot(item,i)
end
self.discipleList:jumpToLockX(idx)
end

function UIEquipNingLianWin:changItemSelect(item,isSelect)
item:SetChildActive(3,isSelect)
end

function UIEquipNingLianWin:refreshItemReddot(item,idx)
if item==nil then
item=self.discipleList:getGridObjectByindex(idx-1)
end
item:SetChildActive(6,false)
end

function UIEquipNingLianWin:refreshAllItemReddot()
for i,v in ipairs(self.disciplelist)do
self:refreshItemReddot(nil,i)
end
end

function UIEquipNingLianWin:on_select_dis(id,index,guid,attach)

if self.curDisIndex==index then return end
local oldItem=self.item
local old=self.curDisIndex
self.curDisIndex=index
if old then
local olditem=self.discipleList:getGridObjectByindex(old-1)
self:changItemSelect(olditem,false)
end
local item=self.discipleList:getGridObjectByindex(self.curDisIndex-1)
self:changItemSelect(item,true)

local netdata=self.disciplelist[self.curDisIndex].netData.net
local dis_guid=netdata.discipleguid
self.disciple_guid=dis_guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)

for equipType,idx in ipairs(equipSlotIndex)do
local equip=equipsModel.getEquipByDizi(self.disciple_guid,equipType)
if equip then
self.item=equipsHelper.getEquip(equip.itemguid)
break
end
end

local oldIsCanChongZhu=equipsHelper.isCanChongZhu(oldItem.itemguid)
local isCanChongZhu=equipsHelper.isCanChongZhu(self.item.itemguid)

local oldIsxm=equipsHelper.isEquipXM(oldItem.itemguid)
local isxm=equipsHelper.isEquipXM(self.item.itemguid)
local isxmzbfresh=oldIsxm~=isxm


if isCanChongZhu then

equipsProtocolControl.req_equip_2_91_ex(self.item.itemguid)
end

local argtable={itemguid=self.item.itemguid}
if oldIsCanChongZhu~=isCanChongZhu or isxmzbfresh then
local isOpen=oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipJingLian,argtable)
local isOpen2=oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipNingLian,argtable)
local isOpen3=oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipRonghe,argtable)
if not isOpen or not isOpen2 or not isOpen3 then
oneTabScreenController:openUI(SEC_FULL_TYPE.equipSecondary,argtable)
end
else
oneTabScreenController:changeArgs(argtable,true)
end

if _this==nil then return end
self:refreshEquipList()
self:freshEquip(argtable)
end



function UIEquipNingLianWin:refreshEquipList()
for equipType,idx in ipairs(equipSlotIndex)do
local equip=equipsHelper.getEquipByDizi(self.disciple_guid,equipType)
if equip and not equipsHelper.isEquipXM(equip.itemguid)then
equip=nil
end
self:fillItem(equip,idx)
end
end
function UIEquipNingLianWin:fillItem(equip,equipSlotIdx)
local prop={}
local equipType=_equipTypeLookup[equipSlotIdx]
local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIdx)
if equip then
local itemid=equip.itemid
local itemguid=equip.itemguid
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local jinglianStr=''
local iconName
local isLock=bagHelper.isLock(equip)
local isFabao=false
local stage=itemConfig.stage
local showStage=stage~=nil
local stageTitile=itemsConfig.getStageName(itemid)
local stageStr=showStage and pfwindowslController:getStageStr(itemid,stageTitile)or''
local xmstageStr=''
local isxmEquip=equipsHelper.getEquipXMTypebyItemid(itemid)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
stageStr=''
xmstageStr=showStage and FMT.fmt('仙·{0}{1}',stage,stageTitile)or''
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
stageStr=''
xmstageStr=showStage and FMT.fmt('魔·{0}{1}',stage,stageTitile)or''
end
local star=0
local reddot=false
local suitIconName=''
if itemsConfig.isEquip(itemid)then
local jinglianlv=equip.itemData and equip.itemData.jinglianlv or 0
jinglianStr=jinglianlv>0 and FMT.fmt('+{0}',jinglianlv)or''
iconName=itemsModel.getIconName(equip)
suitIconName=equipsHelper.getEquipSuitIcon(equip)
end
widgetHelper.setItemQulaity(widget,itemid,_itemWidgetIdx.cmpItemQualityIdx)
widget:SetChildIcon(_itemWidgetIdx.cmpItemIconIdx,iconName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,jinglianStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,false)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,stageStr)
widget:SetChildText(_itemWidgetIdx.xmstagetxt,xmstageStr)
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,stageStr~=''or xmstageStr~='')
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,reddot)
widget:SetChildActive(_itemWidgetIdx.cmpLock,isLock)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,isFabao)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,jinglianStr~='')
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,star)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,star)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,suitIconName,false)
widget:SetBaseItemChildID(-1,itemid)
widget:SetBaseItemChildGUID(-1,itemguid or-1)
if star>0 then
local starWidget=widget:GetChildWidgetBase(_itemWidgetIdx.cmpStar)
for i=1,5 do
if star>=i then
starWidget:SetChildAnimationStringID(i-1,'daobing',false)
end
end
end

local curEquipType=equipsConfig.getEquipType(self.item.itemid)
local isSelect=curEquipType==equipType
self:changEquipSelect(widget,isSelect)


local ninglianStar=equipsModel.getNingLianStar(equip)
if ninglianStar and ninglianStar>0 then
widget:SetChildActive(_itemWidgetIdx.xmicons,true)
local xmWidget=widget:GetChildWidgetBase(_itemWidgetIdx.xmicons)
for i=1,3 do
if ninglianStar>=i then
xmWidget:SetChildActive(i-1,true)
if isxmEquip==EQUIP_XianMo_TYPES.eXian then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_jinlian1")
elseif isxmEquip==EQUIP_XianMo_TYPES.eMo then
xmWidget:SetChildCSImageSprite(i-1,abname,"image_dzzb_moyan1")
end
end
end
else
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
end
else
widget:SetChildActive(_itemWidgetIdx.cmpItemQualityIdx,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemIconIdx,false)
widget:SetChildText(_itemWidgetIdx.cmpItemTxtCount,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemAdd,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemName,true)
widget:SetChildText(_itemWidgetIdx.cmpItemStage,'')
widget:SetChildText(_itemWidgetIdx.xmstagetxt,'')
widget:SetChildActive(_itemWidgetIdx.cmpItemStageBg,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemNew,false)
widget:SetChildActive(_itemWidgetIdx.cmpItemReddot,false)
widget:SetChildActive(_itemWidgetIdx.cmpLock,false)
widget:SetChildActive(_itemWidgetIdx.cmpFabaoTag,false)
widget:SetChildActive(_itemWidgetIdx.cmpCountBg,false)
widget:SetChildGroundStarNum(_itemWidgetIdx.cmpStar,0)
widget:SetChildStarNumber(_itemWidgetIdx.cmpStar,0)
widget:SetChildIcon(_itemWidgetIdx.cmpSuitIcon,'',false)
widget:SetBaseItemChildID(-1,-1)
widget:SetBaseItemChildGUID(-1,-1)
widget:SetChildActive(_itemWidgetIdx.xmicons,false)
end
end
function UIEquipNingLianWin:changEquipSelect(widget,isSelect)
widget:SetChildActive(_itemWidgetIdx.cmpSelect,isSelect)
end
function UIEquipNingLianWin:onBaseItemClick(id,equipType,guid,attach)
local equip=equipsHelper.getEquipByDizi(self.disciple_guid,equipType)
if equip and not equipsHelper.isEquipXM(equip.itemguid)then
equip=nil
end
if not equip then
if self.showType==dicipleType.eSystem then

end
return
end
local oldEquipType=equipsConfig.getEquipType(self.item.itemid)
if oldEquipType==equipType then return end

local old=equipSlotIndex[oldEquipType]
if oldEquipType then
local oldWidget=self.equipListWidget:GetChildWidgetBase(old)
self:changEquipSelect(oldWidget,false)
end

local widget=self.equipListWidget:GetChildWidgetBase(equipSlotIndex[equipType])
self:changEquipSelect(widget,true)

local equip=equipsModel.getEquipByDizi(self.disciple_guid,equipType)

local oldIsCanChongZhu=equipsHelper.isCanChongZhu(self.item.itemguid)
local isCanChongZhu=equipsHelper.isCanChongZhu(equip.itemguid)
local oldIsxm=equipsHelper.isEquipXM(self.item.itemguid)
local isxm=equipsHelper.isEquipXM(equip.itemguid)
local isxmzbfresh=oldIsxm~=isxm

if isCanChongZhu then

equipsProtocolControl.req_equip_2_91_ex(equip.itemguid)
end

local argtable={itemguid=equip.itemguid}
if oldIsCanChongZhu~=isCanChongZhu or isxmzbfresh then
local isOpen=oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.eEquipJingLian,argtable)
local isOpen2
local isOpen3
if not isOpen or isxmzbfresh then
oneTabScreenController:openUI(SEC_FULL_TYPE.equipSecondary,argtable)
end
else
oneTabScreenController:changeArgs(argtable,true)
end
if _this==nil then return end
self:freshEquip(argtable)
end
function UIEquipNingLianWin:onChangeItem(guid,equipType)
if tostring(guid)~=tostring(self.disciple_guid)then return end
local diziguid=self.disciple_guid
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
if equipSlotIndex[equipType]~=nil then
self:fillItem(equip,equipSlotIndex[equipType])
end
equipListManager.closeTips()
end




function UIEquipNingLianWin:testtt(str)
local clearRichStr=string.gsub(str,"<[^>]+>","")

end
