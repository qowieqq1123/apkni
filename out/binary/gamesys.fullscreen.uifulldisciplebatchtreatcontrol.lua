








UIFullDiscipleBatchTreatControl=gameState.addListener(fullScreenUI.create())

function UIFullDiscipleBatchTreatControl:onAppStart()
local function _showBatchTreat(...)self:showBatchTreat(...)end
local function _showBatchCure(...)self:showBatchCure(...)end
local menulist=
{
{tabType=FULL_TAB_TYPE.eDiscipleBatchTreat,callback=_showBatchTreat},
{tabType=FULL_TAB_TYPE.eDiscipleBatchCure,callback=_showBatchCure},
}
local args=
{
menulist=menulist,
fullType=FULL_TYPE.eDiscipleBatchTreat,
skinType=fullScreenSkinType.eSkin3,
}
self:initUI(args)
end

function UIFullDiscipleBatchTreatControl:showBatchWindow()
local activeSubMenu={}
local check,list=self:initDiziData()
if check then
for i,v in ipairs(list)do
table.insert(activeSubMenu,{tabType=v.tab,callback=v.click})
end
local argstable={type=1,list=list}
UIFullDiscipleBatchTreatControl.activeMenuIndex=1
local args=
{

showBg=true,
viewNames={'UIDiscipleBatchZhiliaoWin'},
viewArgs={['UIDiscipleBatchZhiliaoWin']=argstable},
activeSubMenu=activeSubMenu,
}
self:showUI(args)
else

end
end

function UIFullDiscipleBatchTreatControl:showBatchTreat()
local argstable={type=1}
local args=
{
tabType=FULL_TAB_TYPE.eDiscipleBatchTreat,
showBg=true,
viewNames={'UIDiscipleBatchZhiliaoWin'},
viewArgs={['UIDiscipleBatchZhiliaoWin']=argstable},
}
self:showUI(args)
end

function UIFullDiscipleBatchTreatControl:showBatchCure()
local argstable={type=2}
local args=
{
tabType=FULL_TAB_TYPE.eDiscipleBatchCure,
showBg=true,
viewNames={'UIDiscipleBatchZhiliaoWin'},
viewArgs={['UIDiscipleBatchZhiliaoWin']=argstable},
}
self:showUI(args)
end

function UIFullDiscipleBatchTreatControl:initDiziData(dzguid)
local dizilist=UIDiscipleModel:getAllDiscipleDataX()
local hasDizi=dizilist~=nil
local list={}
if not hasDizi then
return false,list
end
local flag=0
local injuryData={}
local shouyuanData={}
for _,v in pairs(dizilist)do
local diziguid=v.netData.net.discipleguid
if dzguid~=nil then
local injury=UIDiscipleModel:getDiscipleInjury(diziguid)
local injuryType=eInjuryType.getType(injury)
if injuryType>eInjuryType.eHealth or dzguid==diziguid then
injuryData[#injuryData+1]=v
flag=flag+1
end
else
if UIDiscipleModel:checkInjuryChuiWeiType(diziguid)then
injuryData[#injuryData+1]=v
flag=flag+1
end
end
if dzguid==nil and UIDiscipleModel:checkShouYuanChuiWeiType(diziguid)then
shouyuanData[#shouyuanData+1]=v
flag=flag+1
end
end

local openFuncType1=item_funtion_type.shouyuan
local list1=itemsLookup:get_function_items(openFuncType1)
local openFuncType2=item_funtion_type.liaoshang
local list2=itemsLookup:get_function_items(openFuncType2)
if#shouyuanData>0 and#list1>0 then
list[#list+1]={
tab=FULL_TAB_TYPE.eDiscipleBatchTreat,
click=function(...)self:showBatchTreat(...)end,
type=item_funtion_type.shouyuan,
list=shouyuanData,
}



end
if#injuryData>0 and#list2>0 then
list[#list+1]={
tab=FULL_TAB_TYPE.eDiscipleBatchCure,
click=function(...)self:showBatchCure(...)end,
type=item_funtion_type.liaoshang,
list=injuryData,
}



end
return flag>0,list
end

function UIFullDiscipleBatchTreatControl.showBatchZhiliaoDialogueWin(type,canvasIdx,dzguid)
local check,list=UIFullDiscipleBatchTreatControl:initDiziData(dzguid)
if check then
local argstable={type=type,list=list,canvasIdx=canvasIdx,openfull=false,dzguid=dzguid}
local titleName="批量救治"
local winParams={
titleName=titleName,
extraWin="UIDiscipleBatchZhiliaoWin",
extraParams=argstable,
canvasIdx=canvasIdx,

}
return UIManager:showWindow('UICommonDragonBoneWin',winParams)
end
return false
end

function UIFullDiscipleBatchTreatControl.showBatchZhiliaoWin(openFull,type,canvasIdx,dzguid)
local shouyuanlist=dzguid~=nil and{}or UIDiscipleModel:getAllShouYuanChuiWeiDZ()
local injurylist
if dzguid~=nil then
injurylist=UIDiscipleModel:getAllInjuryFushangDZ(dzguid)
else
injurylist=UIDiscipleModel:getAllInjuryChuiWeiDZ()
end
if#shouyuanlist<=0 and#injurylist<=0 then
UIManager.info('没有需要救治的弟子')
return
end

if not openFull then
UIFullDiscipleBatchTreatControl.showBatchZhiliaoDialogueWin(type,canvasIdx,dzguid)
else
UIFullDiscipleBatchTreatControl:showBatchWindow()
end

local liaoshang=itemsLookup:getItemsByBag(item_funtion_type.liaoshang)
local shouyuan=itemsLookup:getItemsByBag(item_funtion_type.shouyuan)
local hasShouyuanList=#shouyuanlist>0
local hasInjuryyuanList=#injurylist>0
local enoughShouYuan=#shouyuan>0 and hasShouyuanList or false
local enoughLiaoShang=#liaoshang>0 and hasInjuryyuanList or false
if not enoughShouYuan and not enoughLiaoShang then
local itemCfgs
if hasShouyuanList and not enoughShouYuan then
itemCfgs=itemsLookup:get_function_items(item_funtion_type.shouyuan)
elseif hasInjuryyuanList and not enoughLiaoShang then
itemCfgs=itemsLookup:get_function_items(item_funtion_type.liaoshang)
end
if itemCfgs then
local cfgs=itemCfgs
if#itemCfgs>1 then
cfgs=table.deepCopy(itemCfgs)
table.sort(cfgs,function(a,b)
return a.color<b.color
end)
end
local itemid=cfgs[1].id
local name=itemsConfig.getItemName(itemid)
UIManager.error(FMT.fmt('{0}数量不足',name))

end
end
end
