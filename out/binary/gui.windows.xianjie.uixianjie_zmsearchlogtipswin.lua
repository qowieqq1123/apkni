







def_class("UIXianJie_zmSearchLogTipsWin",UIWindowBase)









function UIXianJie_zmSearchLogTipsWin:bindComponents()

self.attrListContent=UIObject.get(self,0)
self.dazhenValueText=UIText.get(self,1)
self.dzPanel=UIObject.get(self,2)
self.headIconCreater=UIObject.get(self,3)
self.inifGrid=UIObject.get(self,4)
self.junzhenPanel=UIObject.get(self,5)
self.lueduoPanel=UIObject.get(self,6)
self.lueduoTitle=UIObject.get(self,7)
self.mbg=UIObject.get(self,8)
self.mqCountText=UIText.get(self,9)
self.mqMaxTips=UIText.get(self,10)
self.mqNameText=UIText.get(self,11)
self.notDzText=UIText.get(self,12)
self.notXSText=UIText.get(self,13)
self.playerInfo=UIObject.get(self,14)
self.playerName=UIText.get(self,15)
self.posText=UIButton.get(self,16)
self.roleListPanel=UIObject.get(self,17)
self.troopsPanel=UIObject.get(self,18)
self.xqCountText=UIText.get(self,19)
self.xqMaxTips=UIText.get(self,20)
self.xqNameText=UIText.get(self,21)
self.zhuzaPanel=UIObject.get(self,22)
self.zmFightValueText=UIText.get(self,23)
self.tqyjPanel=UIObject.get(self,24)
self.nottqyjText=UIText.get(self,25)
self.yjinifGrid=UIObject.get(self,26)
self.tqyunjiayinPanel=UIObject.get(self,27)
self.notyjyText=UIText.get(self,28)
self.yjyinifGrid=UIObject.get(self,29)
self.xianqingbtn=UIButton.get(self,30)

self.posText:setButtonClick(function()self:onPosText()end)

self.xianqingbtn:setButtonClick(function()self:onXianqingbtn()end)



end


function UIXianJie_zmSearchLogTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrListContent);self.attrListContent=nil;
_UIObject_release(self.dazhenValueText);self.dazhenValueText=nil;
_UIObject_release(self.dzPanel);self.dzPanel=nil;
_UIObject_release(self.headIconCreater);self.headIconCreater=nil;
_UIObject_release(self.inifGrid);self.inifGrid=nil;
_UIObject_release(self.junzhenPanel);self.junzhenPanel=nil;
_UIObject_release(self.lueduoPanel);self.lueduoPanel=nil;
_UIObject_release(self.lueduoTitle);self.lueduoTitle=nil;
_UIObject_release(self.mbg);self.mbg=nil;
_UIObject_release(self.mqCountText);self.mqCountText=nil;
_UIObject_release(self.mqMaxTips);self.mqMaxTips=nil;
_UIObject_release(self.mqNameText);self.mqNameText=nil;
_UIObject_release(self.notDzText);self.notDzText=nil;
_UIObject_release(self.notXSText);self.notXSText=nil;
_UIObject_release(self.playerInfo);self.playerInfo=nil;
_UIObject_release(self.playerName);self.playerName=nil;
_UIObject_release(self.posText);self.posText=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.troopsPanel);self.troopsPanel=nil;
_UIObject_release(self.xqCountText);self.xqCountText=nil;
_UIObject_release(self.xqMaxTips);self.xqMaxTips=nil;
_UIObject_release(self.xqNameText);self.xqNameText=nil;
_UIObject_release(self.zhuzaPanel);self.zhuzaPanel=nil;
_UIObject_release(self.zmFightValueText);self.zmFightValueText=nil;
_UIObject_release(self.tqyjPanel);self.tqyjPanel=nil;
_UIObject_release(self.nottqyjText);self.nottqyjText=nil;
_UIObject_release(self.yjinifGrid);self.yjinifGrid=nil;
_UIObject_release(self.tqyunjiayinPanel);self.tqyunjiayinPanel=nil;
_UIObject_release(self.notyjyText);self.notyjyText=nil;
_UIObject_release(self.yjyinifGrid);self.yjyinifGrid=nil;
_UIObject_release(self.xianqingbtn);self.xianqingbtn=nil;
end
















local _this=nil
local liconIdx=
{
headicon=0,
headkuang=1,
headclick=2,
name=3,
liconself=4,
}



function UIXianJie_zmSearchLogTipsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIXianJie_zmSearchLogTipsWin:__delete()
self:unbindComponents()
_this=nil
end

function UIXianJie_zmSearchLogTipsWin:showModel()

self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mbg:getID(),false,true,false)
self.mbg:setChildUIModelShowTarget(6010,1,nil,eAnimationID.stand,false,false,0,nil)
end




function UIXianJie_zmSearchLogTipsWin:onShow(argtable,afterOnloaded)
if argtable and argtable.args then
self.args=argtable.args
end
if argtable and argtable.actorId then
self.actorId=argtable.actorId
end

self:refreshView()
self:showModel()
end

function UIXianJie_zmSearchLogTipsWin:refreshView()
local zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
if zmData==nil then
self:closeSelf()
else
self:refreshInfo(zmData)
end
end

function UIXianJie_zmSearchLogTipsWin:refreshInfo(zmData)
if zmData==nil then
zmData=self.actorId and xianjieModel:getZongMenData(self.actorId)or nil
end
if zmData==nil then return end

local stationguid=tonumber(self.args.stationguid)
local datatb=xianjieModel:Get_searchLogLookup(self.actorId,stationguid)
local logtb=self:splitStr(datatb.params)


local ttms_data=logtb[8]or false



local pos_str=FMT.fmt('(X:{0}，Y:{1})',logtb[6],logtb[7])
self.posText:setText(pos_str)


local iconInfo=zmData.iconInfo
playerController:setHeadIcon(self.winlua,self.headIconCreater:getID(),{iconInfo=iconInfo,scale=1})


local nameStr=zmData.actorname
self.playerName:setText(nameStr)

local dzFightList={}
local dzList={}
for i=1,self.args.disciplelistlen do
local baseData=table.weakCopy(self.args.discipleList[i])
if baseData.flag>0 then
local dzData=otherPlayerModel.detailDisciple_to_discipleStruct3(baseData)
local dzGuidStr=tostring(dzData.base.discipleguid)
local fightValue=mathHelper.int64_to_number(dzData.base.fightvalue)
dzFightList[dzGuidStr]=fightValue
table.insert(dzList,dzData)
end
end
local disciplelistlen=#dzList
self.roleListPanel:setActive(disciplelistlen>0)
self.notDzText:setActive(disciplelistlen==0)
if disciplelistlen>0 then
self.roleListPanel:setChildScrollViewCreateGrids(disciplelistlen,5)
local teamGrids=self.roleListPanel:getChildScrollViewItemWidgets()
local count=teamGrids.Count
for i=1,count do
local dzData=dzList[i]
local baseData=dzData.base
local dizi_guid=baseData.discipleguid
local discipledata=baseData.discipledata
local discipleimage=baseData.discipleimage

local item=teamGrids[i-1]
local image=UIDiscipleModel.calculationDiscipleImage(discipledata,discipleimage)


local color=image.color
local abname,iconname=UIDiscipleModel:getDiscipleColorFrameName(baseData,color)
item:SetChildCSImageSprite(0,abname,iconname)

UIDiscipleModel:setDiscipleXianMoBackImage(item,28,baseData)

local jobicon=UIDiscipleModel:getJobIconName(image.job)
item:SetChildCSImageSprite(1,globalABLookup.global,jobicon)

item:SetChildText(2,baseData.disciplename)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(3,item,modelParams,eHeadCenterType.eHead,nil,false)

item:SetChildCSImageSprite(17,globalABLookup.diciplecolorframe,discipleColorToFrame3[color])

local lv_str=tostring(baseData.jingjielv)
item:SetChildText(5,lv_str)

item:SetChildActive(6,true)
item:SetChildText(6,tostring(mathHelper.int64_to_number(baseData.fightvalue)))

item:SetChildText(4,'')

UIDiscipleController.refreshCommonItemTianMing(item,baseData)

local isLD=liandonModel:getLianDonLinkageIdByDZId(baseData.id)>0
item:SetChildActive(27,isLD)


local func=function()
if _this==nil then return end
otherPlayerController:openOtherPlayerDZInfoWinEXX(_this.actorId,dzList,dizi_guid)
end
item:SetChildButtonClick(-1,func,true)
end
end

local xqValue=0
local mqValue=0
local TSDZShieldValue=0
local XBlist={}
local moneyList=logtb[2]
local soldierListLockup={}
if#moneyList>0 then
local soldierList={}
for i,v in pairs(moneyList)do
local soldierLevel=yunjiayingModel:getSoldierLevelByMoneyType(v[1])
if soldierLevel and soldierLevel>0 then
if not soldierList[soldierLevel]then
soldierList[soldierLevel]={}
soldierList[soldierLevel].type=soldierLevel
soldierList[soldierLevel].num=0
end
soldierList[soldierLevel].num=soldierList[soldierLevel].num+v[2]
elseif v[1]==eMoneyType.mtXianQi then
xqValue=v[2]
elseif v[1]==eMoneyType.mtMoQi then
mqValue=v[2]
elseif v[1]==eMoneyType.mtTSDZShield then
TSDZShieldValue=v[2]
end
end

for i,v in pairs(soldierList)do
soldierListLockup[v.type]=v.num
XBlist[#XBlist+1]=v
end
local totleNum=0
local XBlistLen=#XBlist
self.inifGrid:setChildLayoutGroupCreateItems(XBlistLen)
local inifGrids=self.inifGrid:getChildLayoutGroupGridList()
for i=1,XBlistLen do
local data=XBlist[i]
local item=inifGrids[i-1]
item:SetChildActive(-1,data~=nil)
if data then
local type=data.type
local num=data.num
totleNum=totleNum+num

local cfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,type)
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
item:SetChildCSImageSprite(0,iconAb,cfg.bgIcon)
item:SetChildCSImageSprite(1,iconAb,cfg.nameIcon)
item:SetChildText(2,num)
end
end
end

local fightValue=xianjieModel:getXJYZTeamFightValue(dzFightList,soldierListLockup)
self.zmFightValueText:setText(mathHelper.formatNumber3(fightValue))

local isZM=stationguid==0
self.dazhenValueText:setActive(isZM)
self.lueduoTitle:setActive(isZM)
self.lueduoPanel:setActive(isZM)
self.inifGrid:setActive(#XBlist>0)
self.notXSText:setActive(#XBlist==0)
if isZM then
local bdData=TaiXuCangModel:getBuildingData()
local level=bdData and bdData.level or 1
local cfg=cfgHelper.get(cfg_taixucangconfig_get,level)
local curPlunder=TaiXuCangModel:getPlunderList()

local curXQValue=curPlunder[eMoneyType.mtXianQi]or 0
local isMaxXQ=curXQValue>=cfg.plunder[eMoneyType.mtXianQi]
self.xqNameText:setText(moneyModel.getMoneyName(eMoneyType.mtXianQi))
self.xqCountText:setText(xqValue)
self.xqCountText:setActive(xqValue>0)
self.xqMaxTips:setText(isMaxXQ and"(今日可获取量已达上限)"or"(此宗门暂无可获取资源)")
self.xqMaxTips:setActive(xqValue==0)

local curMQValue=curPlunder[eMoneyType.mtMoQi]or 0
local isMaxMQ=curMQValue>=cfg.plunder[eMoneyType.mtMoQi]
self.mqNameText:setText(moneyModel.getMoneyName(eMoneyType.mtMoQi))
self.mqCountText:setText(mqValue)
self.mqCountText:setActive(mqValue>0)
self.mqMaxTips:setText(isMaxMQ and"(今日可获取量已达上限)"or"(此宗门暂无可获取资源)")
self.mqMaxTips:setActive(mqValue==0)
self.dazhenValueText:setText(FMT.fmt("大阵防护值:{0}",TSDZShieldValue))
end

self.junzhenPanel:setActive(true)
local attrTypes={
eAttributeType.eJZATK_PCT,
eAttributeType.eJZDEF_PCT,
eAttributeType.eJZHP_PCT,
eAttributeType.eJunSha,
eAttributeType.eTongYu,
}
local attrList={}
if self.args.bonuslistlen>0 then
for i=1,self.args.bonuslistlen do
local attr=self.args.bonusList[i]
attrList[attr.param_1]=attr.param_2
end
end
self.attrListContent:setChildLayoutGroupCreateItems(#attrTypes)
local grids=self.attrListContent:getChildLayoutGroupGridList()
for i=1,#attrTypes do
local item=grids[i-1]
local attrID=attrTypes[i]
local attrValue=helper.getAttributeStrEx(attrID,(attrList[attrID]or 0))
local attrCfg=cfgHelper.get1(cfg_attributesconfig_get,attrID)
item:SetChildText(0,attrCfg.attrname)
item:SetChildText(1,FMT.fmt("+{0}",attrValue))
end


if ttms_data then
self:openTeQuanXSPanel(ttms_data,logtb)
self.tqyjPanel:setActive(true)
self.nottqyjText:setActive(true)
self.yjinifGrid:setActive(false)
if next(ttms_data)then
xianjieController:send_35_42(self.args.guid)
end
end
end


function UIXianJie_zmSearchLogTipsWin:onHide()

end



function UIXianJie_zmSearchLogTipsWin:openTeQuanXSPanel(ttms_data,logtb)
if next(ttms_data)==nil then
self.tqyunjiayinPanel:setActive(true)
self.notyjyText:setActive(true)
self.yjyinifGrid:setActive(false)
else
self.tqyunjiayinPanel:setActive(true)
self.notyjyText:setActive(false)
self.yjyinifGrid:setActive(true)

local xqValue=0
local mqValue=0
local TSDZShieldValue=0
local XBlist={}
local moneyList=ttms_data
local soldierListLockup={}
if#moneyList>0 then
local soldierList={}
for i,v in pairs(moneyList)do
local soldierLevel=yunjiayingModel:getSoldierLevelByMoneyType(v[1])
if soldierLevel and soldierLevel>0 then
if not soldierList[soldierLevel]then
soldierList[soldierLevel]={}
soldierList[soldierLevel].type=soldierLevel
soldierList[soldierLevel].num=0
end
soldierList[soldierLevel].num=soldierList[soldierLevel].num+v[2]
elseif v[1]==eMoneyType.mtXianQi then
xqValue=v[2]
elseif v[1]==eMoneyType.mtMoQi then
mqValue=v[2]
elseif v[1]==eMoneyType.mtTSDZShield then
TSDZShieldValue=v[2]
end
end
for i,v in pairs(soldierList)do
soldierListLockup[v.type]=v.num
XBlist[#XBlist+1]=v
end
local totleNum=0
local XBlistLen=#XBlist
self.yjyinifGrid:setChildLayoutGroupCreateItems(XBlistLen)
local inifGrids=self.yjyinifGrid:getChildLayoutGroupGridList()
for i=1,XBlistLen do
local data=XBlist[i]
local item=inifGrids[i-1]
item:SetChildActive(-1,data~=nil)
if data then
local type=data.type
local num=data.num
totleNum=totleNum+num

local cfg=cfgHelper.get(cfg_fairylandsoldierconfig_get,type)
local iconAb="ui/windows/yunjiaying/yunjiaying_atlas_pak.ab"
item:SetChildCSImageSprite(0,iconAb,cfg.bgIcon)
item:SetChildCSImageSprite(1,iconAb,cfg.nameIcon)
item:SetChildText(2,num)
end
end
end
end
end

function UIXianJie_zmSearchLogTipsWin:TeQuanYJPanelfresh()
_this:openTeQuanYJPanel()
end
function UIXianJie_zmSearchLogTipsWin:openTeQuanYJPanel()
local assistlist=xianjieModel:getTQyuanjun_Data()
if assistlist and next(assistlist)then
self.tqyjPanel:setActive(true)
self.nottqyjText:setActive(false)
self.yjinifGrid:setActive(true)
local Gridwidget=self.yjinifGrid:getChildWidgetBase()
for i=1,4 do
local assdata=assistlist[i]
local liconItem=Gridwidget:GetChildWidgetBase(i-1)
if assdata then
liconItem:SetChildActive(liconIdx.liconself,true)
local name=assdata.actorname or""
liconItem:SetChildText(liconIdx.name,name)

local headParams={iconInfo=assdata.icon,scale=0.8}
playerController:setHeadIcon(liconItem,liconIdx.headicon,headParams)

liconItem:SetChildButtonClick(liconIdx.headclick,function(...)
if _this==nil then return end
self:onDZClickItem(i,assdata)
end)

else
liconItem:SetChildActive(liconIdx.liconself,false)
end
end
if#assistlist>=4 then
self.xianqingbtn:setActive(true)
else
self.xianqingbtn:setActive(false)
end
end
end

function UIXianJie_zmSearchLogTipsWin:onDZClickItem(idx,assdata)

self:showWindow('UIYingXianGeTQyuanjunWin')
end
function UIXianJie_zmSearchLogTipsWin:onXianqingbtn()
self:showWindow('UIYingXianGeTQyuanjunWin')
end




function UIXianJie_zmSearchLogTipsWin:onPosText()
local stationguid=self.args.stationguid
local datatb=xianjieModel:Get_searchLogLookup(self.actorId,stationguid)
local logtb=self:splitStr(datatb.params)
xianjieController:jumpGrid(logtb[5],logtb[6],logtb[7],nil,true)
self:closeSelf()
end

local cjson=require'cjson'

function UIXianJie_zmSearchLogTipsWin:splitStr(str)
return cjson.decode(str)
end