







discipleSelectController=gameState.addListener({})

dzSelectWinOpenType={
eManager=1,
eRoommate=2,
eFangShi=3,
eFeiSheng=4,
eChuanGongGe=5,
eYouLi=6,
eXianZhan=7,
eZhenFa=8,
eInteractNPC=9,
eXuanShang=10,
eHouShanJinDi=11,
eFabaoOwner=12,
eTianTiShiLian=13,
eBingGongFang=14,
eSystemZMOutgoer=15,
eSystemZMOutgoer_MultiSelect=16,
eHongChenJie=17,
eCouple=18,
eYifanglingtian=19,
eAirGameEnter=20,
eXianJieSearch=21,
eWenXinGuanSelect=22,
eJctjFeiSheng=23,
eZaoWuGe=24,
}

local _noBlackBgFunc={
[edzFuncSpecialityType.eSpeciality_SystemZongMenOutgoer_Arrest]=true,
[edzFuncSpecialityType.eSpeciality_SystemZongMenOutgoer_Incite]=true,
}

dzSelectWinOpenTypeWin={
[dzSelectWinOpenType.eManager]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eManager],
[dzSelectWinOpenType.eRoommate]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eRoommate],
[dzSelectWinOpenType.eFangShi]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eManager],
[dzSelectWinOpenType.eFeiSheng]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eFeisheng],
[dzSelectWinOpenType.eYouLi]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eYouli],
[dzSelectWinOpenType.eXianZhan]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eXianzhan],
[dzSelectWinOpenType.eZhenFa]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eManager],
[dzSelectWinOpenType.eInteractNPC]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eInteractnpc],
[dzSelectWinOpenType.eChuanGongGe]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eChuangongge],
[dzSelectWinOpenType.eXuanShang]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eXuanshang],
[dzSelectWinOpenType.eHouShanJinDi]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eHoushanjindi],
[dzSelectWinOpenType.eFabaoOwner]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eFabaoOwner],
[dzSelectWinOpenType.eTianTiShiLian]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eTiantishilian],
[dzSelectWinOpenType.eBingGongFang]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eBinggongfang],
[dzSelectWinOpenType.eSystemZMOutgoer]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eSystemzongmenoutgoer],
[dzSelectWinOpenType.eSystemZMOutgoer_MultiSelect]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eSystemzongmenoutgoer_multiSelect],
[dzSelectWinOpenType.eHongChenJie]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eFilter],
[dzSelectWinOpenType.eCouple]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eCouple],
[dzSelectWinOpenType.eYifanglingtian]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eYifanglingtian],
[dzSelectWinOpenType.eAirGameEnter]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eFilter],
[dzSelectWinOpenType.eXianJieSearch]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eXianjieSearch],
[dzSelectWinOpenType.eWenXinGuanSelect]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eWenxinguan],
[dzSelectWinOpenType.eJctjFeiSheng]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eJctjFeiSheng],
[dzSelectWinOpenType.eZaoWuGe]=eMultiUIMDiscipleSelectNames[eMultiUIMDiscipleSelectTypes.eZaowuge],
}

dzSelectEffectType={
ePlan=1,
eFangShi=2,
eShangPu=3,
eZhenFa=4,
eJuTianYi=5,
}

discipleSelectController.item_cmp_index=
{
img_select=0,
icon_head=1,
txt_name=2,
txt_desc1=3,
txt_desc2=4,
txt_tips=5,
scrollView_spe=6,
icon_sign=7,
img_color=8,
icon_cursign=9,
grid_spe=10,
grid_speBtns=11,
txt_desc3=12,
ex_info=13,
chuiweiBack=14,
chuiweiImg=15,
jiuzhiBtn=16,
stateObj=17,
stateName=18,
fightTxt=19,
blackRoot=20,
blackTx=21,
xiangxi=22,
up=23,
taozhuangGrid=24,
jobRoot=25,
jobImg=26,
jobText=27,
order=28,
quguan=29,
exx_info=30,
exx_info_root=31,
txt_desc4=32,
lockRoot=33,
lockText=34,
rightRoot=35,
frame=36,
scrollView_spe_wenixnguan=37,
grid_spe_wenixnguan=38,
dis_job=39,
txt_desc5=40,
img_xianmo=41,
hcjFkag=42,
spDzFlag=43,
}

function discipleSelectController.refreshItemHead(item,guid)
local item_cmp_index_=discipleSelectController.item_cmp_index

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(item_cmp_index_.img_color,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

local chuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
comHelper.setChildModelRawImage(item,guid,item_cmp_index_.icon_head,0,eHeadCenterType.eHalf,nil,chuiwei)

local name=UIDiscipleModel:getDiscipleName(guid)
item:SetChildText(item_cmp_index_.txt_name,name)

local fight_str
local dzData=UIDiscipleModel:getDiscipleData(guid)
local isShuWuDZ=dzData and UIDiscipleModel:isShuWuDisciple(dzData.id)
if isShuWuDZ then
local shili=UIDiscipleModel:getShuWuFightValue(guid)
fight_str=FMT.fmt('<color=#7d3b17>实力</color> {0}',shili)
else
fight_str=FMT.fmt('<color=#7d3b17>战</color> {0}',UIDiscipleModel:getDiscipleFightValue(guid))
end
item:SetChildText(item_cmp_index_.fightTxt,fight_str)

local netData=UIDiscipleModel:getDiscipleData(guid)
UIDiscipleModel:setDiscipleXianMoBackImage(item,item_cmp_index_.img_xianmo,netData)
end

function discipleSelectController.refreshDesc(item,desc1,desc2,desc3,desc4)

local item_cmp_index_=discipleSelectController.item_cmp_index
local show1=desc1~=nil
item:SetChildActive(item_cmp_index_.txt_desc1,show1)
if show1 then
item:SetChildText(item_cmp_index_.txt_desc1,desc1)
end
local show2=desc2~=nil
item:SetChildActive(item_cmp_index_.txt_desc2,show2)
if show2 then
item:SetChildText(item_cmp_index_.txt_desc2,desc2)
end
local show3=desc3~=nil
item:SetChildActive(item_cmp_index_.txt_desc3,show3)
if show3 then
item:SetChildText(item_cmp_index_.txt_desc3,desc3)
end
local show4=desc4~=nil
item:SetChildActive(item_cmp_index_.txt_desc4,show4)
if show4 then
item:SetChildText(item_cmp_index_.txt_desc4,desc4)
end
end

function discipleSelectController.refreshSign(item,istuijian,guid)
local item_cmp_index_=discipleSelectController.item_cmp_index
local showicon=nil

if not istuijian then

local injury=UIDiscipleModel:getDiscipleInjury(guid)
local injuryType=eInjuryType.getType(injury)
if injuryType>eInjuryType.eHealth then
showicon=eInjuryType:getIconEx(injuryType)


local chuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
if chuiwei then
showicon=nil
end
end

local lowloyalty=UIDiscipleModel:checkLowLoyalty(guid)
if lowloyalty then
if injuryType~=eInjuryType.eImminent then
showicon='image_zhuangtai_4'
end
end
else
showicon='image_tuijian'
end
local isshowicon=showicon~=nil
item:SetChildActive(item_cmp_index_.icon_sign,isshowicon)
if isshowicon then
item:SetChildCSImageSprite(item_cmp_index_.icon_sign,globalABLookup.global,showicon)
end
end


function discipleSelectController.refreshSpeciality(item,disIdx,effectlist,func)
local item_cmp_index_=discipleSelectController.item_cmp_index
if effectlist~=nil and#effectlist>0 then
item:SetChildActive(item_cmp_index_.scrollView_spe,true)
item:SetChildText(item_cmp_index_.txt_tips,'')

local count=#effectlist
item:SetChildLayoutGroupCreateItems(item_cmp_index_.grid_spe,count)
local spegrids=item:GetChildLayoutGroupGridList(item_cmp_index_.grid_spe)
for i=1,count do
local speitem=spegrids[i-1]
local effectcfg=effectlist[i]
UIDiscipleModel.refreshSpecialityItemExx(speitem,effectcfg)
speitem:SetChildButtonClick(1,function()
func(disIdx,i)
end)
end
item:SetChildScrollRectEnable(item_cmp_index_.scrollView_spe,count>=3)
else
item:SetChildActive(item_cmp_index_.scrollView_spe,false)
item:SetChildText(item_cmp_index_.txt_tips,'')
end
end

function discipleSelectController.refreshSelectTypeListItem(item,idx,name,flag,func)
item:SetChildButtonClickWithID(0,func,idx)
item:SetChildText(1,name)
discipleSelectController.refreshSelectTypeListItemSelect(item,flag)
end

function discipleSelectController.refreshSelectTypeListItemSelect(item,flag)
item:SetChildCSImageSprite(0,globalABLookup.global,flag==true and'button_xiaoyeqian_1'or'button_xiaoyeqian_2')
end


function discipleSelectController.getEffectDesc(effect_type,pro_skill_cfg,data)

local effect_str=''
if effect_type==dzSelectEffectType.ePlan then
effect_str=discipleSelectController.getEffectDesc_plan(pro_skill_cfg,data.level)
elseif effect_type==dzSelectEffectType.eFangShi then
local level=data.disciple.proskillList[DISCIPLE_PROSKILL_TYPE.eShangDao].level
effect_str=discipleSelectController.getEffectDesc_fs(pro_skill_cfg,level)
elseif effect_type==dzSelectEffectType.eShangPu then
effect_str=discipleSelectController.getEffectDesc_sp(pro_skill_cfg,data.level)
elseif effect_type==dzSelectEffectType.eZhenFa then
local guid=data.disciple.discipleguid
local level=data.disciple.proskillList[DISCIPLE_PROSKILL_TYPE.eZhenFa].level
effect_str=discipleSelectController.getEffectDesc_zf(guid,pro_skill_cfg,level)
elseif effect_type==dzSelectEffectType.eJuTianYi then
effect_str=discipleSelectController.getEffectDesc_jty(pro_skill_cfg,data.level)
end
return effect_str
end


function discipleSelectController.getEffectDesc_jty(pro_skill_cfg,level)
local effect_str=''
local effect=0
if pro_skill_cfg.jutianyi_effects then
local temp1=pro_skill_cfg.jutianyi_effects[level]
if temp1 and temp1>0 then
effect=temp1
end
end
if effect~=0 then
effect_str=FMT.fmt('（收集效率+{0}%）',effect)
end
return effect_str
end


function discipleSelectController.getEffectDesc_zf(guid,pro_skill_cfg,level)
local effect_str=''
local effect=0
if pro_skill_cfg.tiangongge_discount then
local temp1=pro_skill_cfg.tiangongge_discount[level]
if temp1 and temp1>0 then
effect=effect-temp1
end
end


if effect~=0 then
effect_str=FMT.fmt('（研究时长{0}%）',effect)
end
return effect_str
end


function discipleSelectController.getEffectDesc_plan(pro_skill_cfg,level)
local effect_str=''
if pro_skill_cfg.buildplant_effects then
local effect=pro_skill_cfg.buildplant_effects[level]
if effect and(effect[1]>0 or effect[2]>0)then
if effect[1]>0 and effect[2]>0 then
effect_str=FMT.fmt('（产量+{0}%，消耗-{1}%）',effect[1],effect[2])
elseif effect[1]>0 and effect[2]<=0 then
effect_str=FMT.fmt('（产量+{0}%）',effect[1])
elseif effect[1]<=0 and effect[2]>0 then
effect_str=FMT.fmt('（消耗-{0}%）',effect[2])
end
end
end
return effect_str
end


function discipleSelectController.getEffectDesc_fs(pro_skill_cfg,level)
local effect_str=''
if pro_skill_cfg.fangshi_discount then
local effect=pro_skill_cfg.fangshi_discount[level]
if effect and effect>0 then
effect_str=pfwindowslController:convertDiscount_yuenan(FMT.fmt('（额外折扣：{0}折）',(1-effect/100)*10))
end
end
return effect_str
end


function discipleSelectController.getEffectDesc_sp(pro_skill_cfg,level)
local effect_str=''
if pro_skill_cfg.shangpu_effects then
local effect=pro_skill_cfg.shangpu_effects[level]
if effect then
effect_str=FMT.fmt('（收益+{0}%）',effect)
end
end
return effect_str
end

function discipleSelectController.refreshChuiWei(item,guid)
local item_cmp_index_=discipleSelectController.item_cmp_index
local chuiwei=UIDiscipleModel:checkDiscipleState2(guid,DISCIPLE_STATE_TYPE.eChuiWei)
item:SetChildActive(item_cmp_index_.chuiweiBack,chuiwei)
item:SetChildActive(item_cmp_index_.chuiweiImg,chuiwei)
item:SetChildActive(item_cmp_index_.jiuzhiBtn,chuiwei)
if chuiwei then
local func=function()
discipleSelectController.onJiuZhiClick(guid)
end
item:SetChildButtonClick(item_cmp_index_.jiuzhiBtn,func,true)
end
end

function discipleSelectController.onJiuZhiClick(guid)
UIManager:showWindow('UIDiscipleChuiweiWin',{guid=guid})
end

function discipleSelectController.showReplaceManagerDialog(title,content,func)

local dialog=discipleSelectController.dialog
if not dialog then
title=title or'提示'
local show_data={
type='UIDialouge',
title=title,
content=content,
oktext='确定',
canceltext='取消',
okcallback=func,
}
dialog=UIDialogManager.newDialog(show_data)
discipleSelectController.dialog=dialog
else
dialog.title=title
dialog.content=content
dialog.okcallback=func
end
dialog:show()
end

function discipleSelectController.isDiziEmptyOrNil(guidstr)
return guidstr==nil or guidstr=='0'
end


function discipleSelectController:onAppStart()
end
function discipleSelectController:onEnterState()
notifySystem:listenNotify(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
end
function discipleSelectController:onLeaveState()
notifySystem:removelistener(notifyConfig.onDiscipleStateChange,self.onDiscipleStateChange)
end
function discipleSelectController:onPlayerCreate(...)
end
function discipleSelectController:onLostConnection()
end



local curOpenType=nil

function discipleSelectController:openDiscipleSelect(args,titleName,winname)
titleName=titleName or'弟子安排'
local openType=args.openType or dzSelectWinOpenType.eManager
args.openType=openType
local winName=winname or dzSelectWinOpenTypeWin[openType]

if winName==nil then
logErr(FMT.fmt('弟子选择类型{0}，没有指定窗口',openType))
return
else

end
curOpenType=openType

local winParams={
canvasIdx=args.canvasIdx,
titleName=titleName,
noBlackBg=args.funcType and _noBlackBgFunc[args.funcType]or nil,
extraWin=winName,
extraParams=args,
}

UIManager:showWindow('UICommonDragonBoneWin',winParams)
end


function discipleSelectController.onDiscipleStateChange(discipleguid,stateType,old,cur)
if curOpenType==nil then return end
if stateType==DISCIPLE_STATE_TYPE.eChuiWei then
local winName=dzSelectWinOpenTypeWin[curOpenType]
local win=UIManager:findActiveWindow(winName)
if win then
if win.refreshView~=nil then
win:refreshView()
end
end
end
end

local build_speciality_lookup=nil
function discipleSelectController.initBuildSpecialityLookup()
if build_speciality_lookup==nil then
build_speciality_lookup={}
local cfgs=cfg_disciplefunctionspecialityconfig()
for k,v in pairs(cfgs)do
local buildType=v.buildType
if buildType then
if build_speciality_lookup[buildType]==nil then build_speciality_lookup[buildType]={}end
table.insert(build_speciality_lookup[buildType],v)
end
end
for k,v in pairs(build_speciality_lookup)do
if#v>1 then
table.sort(v,function(a,b)
local aIdx=a.funcIndex or 1
local bIdx=b.funcIndex or 1
return aIdx<bIdx
end)
end
end
end
end

function discipleSelectController.getSpeciallistByBuild(guid,buildType,funcIndex)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData==nil then return nil end
return discipleSelectController.getSpeciallistByBuildEx(netData,buildType,funcIndex)
end

function discipleSelectController.getBuildSpecialityLookup(buildType,funcIndex)
funcIndex=funcIndex or 1
discipleSelectController.initBuildSpecialityLookup()

return build_speciality_lookup[buildType]and build_speciality_lookup[buildType][funcIndex]
end

function discipleSelectController.getSpeciallistByBuildEx(netData,buildType,funcIndex)
funcIndex=funcIndex or 1
discipleSelectController.initBuildSpecialityLookup()
local list=build_speciality_lookup[buildType]
if list==nil then return nil end
local cfg=list[funcIndex]
if cfg==nil then return nil end
local spelist=UIDiscipleModel:getDiscipleSpecialityConfigByData(netData)
if#spelist<=0 then return spelist end
return discipleSelectController.calculateSpeciallist(spelist,cfg.spelist)
end

function discipleSelectController.getSpeciallistByFunction(guid,funcType)
local netData=UIDiscipleModel:getDiscipleData(guid)
if netData==nil then return nil end
return discipleSelectController.getSpeciallistByFunctionEX(netData,funcType)
end

function discipleSelectController.getSpeciallistByFunctionEX(netData,funcType)
local cfg=cfgHelper.get1(cfg_disciplefunctionspecialityconfig_get,funcType)
if cfg==nil then return nil end
local spelist=UIDiscipleModel:getDiscipleSpecialityConfigByData(netData)
if#spelist<=0 then return spelist end
return discipleSelectController.calculateSpeciallist(spelist,cfg.spelist)
end


function discipleSelectController.calculateSpeciallist(spelist,masklist)
local temp={}
for i,spe in ipairs(spelist)do
local specialitytype=spe.specialitytype
if masklist[specialitytype]then
for _,speid in ipairs(masklist[specialitytype])do
if spe.id==speid then
table.insert(temp,spe)
break
end
end
end
end
return temp
end

