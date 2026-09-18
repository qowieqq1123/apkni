








local _enumIdx=0
function getEnumIdx()
_enumIdx=_enumIdx+1
return _enumIdx
end

eApplicationState=
{
eNone=0,
eInstall=1,
eUpdate=2,
eLoading=3,
eLogin=4,
eGame=5,
eQuiting=6
}

eSceneLoadState=
{
Loading=0,
None=1,
}


eGameStageType=
{
none=0,
loadScene=1,
showGame=2,
}


eQualityColor={
eWhite=0,
eGreen=1,
eBlue=2,
ePurple=3,
eOrange=4,
eRed=5,
ePink=6,
}


eQualityColorName=
{
[eQualityColor.eWhite]='白色',
[eQualityColor.eGreen]='绿色',
[eQualityColor.eBlue]='蓝色',
[eQualityColor.ePurple]='紫色',
[eQualityColor.eOrange]='橙色',
[eQualityColor.eRed]='红色',
[eQualityColor.ePink]='粉色',
}


FONT_COLOR=
{
eWhiteColor=0,
eGreenColor=1,
eBlueColor=2,
ePurpleColor=3,
eOrangeColor=4,
eRedColor=5,
ePinkColor=6,


eGrayColor=100,
eNomalColor=101,
eOrangeDescColor=102,
eTipsTitleColor=104,
eTipWhiteColor=105,
eNomalBlackColor=106,
eNomalGrayColor=107,
eGrayWhiteTxtColor=108,
eGreenTxtColor=109,
eTitle2Color=110,
ePurpleActiveColor=111,
}

FONT_COLOR_VAL=
{
[FONT_COLOR.eNomalColor]='#181412',
[FONT_COLOR.eWhiteColor]='#efeded',
[FONT_COLOR.eGreenColor]='#549327',
[FONT_COLOR.eBlueColor]='#3375c0',
[FONT_COLOR.ePurpleColor]='#6833c0',
[FONT_COLOR.eOrangeColor]='#ca631d',
[FONT_COLOR.eRedColor]='#c82c2c',
[FONT_COLOR.ePinkColor]='#d03497',
[FONT_COLOR.eGrayColor]='#827f78',

[FONT_COLOR.eOrangeDescColor]='#7d3b17',
[FONT_COLOR.eTipsTitleColor]='#b39d68',
[FONT_COLOR.eTipWhiteColor]='#cacaca',
[FONT_COLOR.eNomalBlackColor]='#171311',
[FONT_COLOR.eNomalGrayColor]='#65615f',
[FONT_COLOR.eGrayWhiteTxtColor]='#f7f7f7',
[FONT_COLOR.eGreenTxtColor]='#76d81e',
[FONT_COLOR.eTitle2Color]='#f1ce78',
[FONT_COLOR.ePurpleActiveColor]='#A18cfd',
}

FONT_TIPS_COLOR_VAL=
{
[FONT_COLOR.eWhiteColor]='#f7f7f7',
[FONT_COLOR.eGreenColor]='#aae252',
[FONT_COLOR.eBlueColor]='#5ac0e2',
[FONT_COLOR.ePurpleColor]='#bb8cf1',
[FONT_COLOR.eOrangeColor]='#efb150',
[FONT_COLOR.eRedColor]='#f36666',
[FONT_COLOR.eGrayColor]='#8e8c87',
[FONT_COLOR.eTipWhiteColor]='#cacaca',
}


FONT_COLOR_FMT={}
for k,v in pairs(FONT_COLOR_VAL)do
FONT_COLOR_FMT[k]=string.format('<color=%s>{0}</color>',v)
end

FONT_TIPS_COLOR_FMT={}
for k,v in pairs(FONT_TIPS_COLOR_VAL)do
FONT_TIPS_COLOR_FMT[k]=string.format('<color=%s>{0}</color>',v)
end

function toColorString(color,desc)
return FMT.fmt(FONT_COLOR_FMT[color],desc)
end

function toColorString2(color,desc)
return FMT.fmt(FONT_TIPS_COLOR_FMT[color],desc)
end

function toColorStringX(color,desc)
return FMT.fmt('<color={0}>{1}</color>',color,desc)
end

local elementTypeNames={}
local getElementTypeNames=function(typo,v)
if elementTypeNames[typo]~=nil then
return elementTypeNames[typo][v]
end
return nil
end
local setElementTypeNames=function(typo,v,str)
if elementTypeNames[typo]==nil then
elementTypeNames[typo]={}
end
elementTypeNames[typo][v]=str
end

ELEMENT_TYPE=
{
eGold=1,
eWood=2,
eWater=3,
eFire=4,
eSoil=5,
eWind=6,
eThunder=7,
ePoison=8,
eSoul=9,
eBlood=10,
eVaryLei=11,
eVaryFeng=12,
eVaryShui=13,
eVaryYan=14,
eVaryYue=15,
eVaryYu=16,


getName=function(v)
return cfgHelper.get2(cfg_elementtypeconfig_get,v,'name')
end,
getNameX=function(v)
local str=getElementTypeNames(1,v)
if str==nil then
str=FMT.fmt('{0}行',cfgHelper.get2(cfg_elementtypeconfig_get,v,'name'))
setElementTypeNames(1,v,str)
end
return str
end,
getName3=function(v)
local str=getElementTypeNames(3,v)
if str==nil then
str=FMT.fmt('{0}属性',cfgHelper.get2(cfg_elementtypeconfig_get,v,'name'))
setElementTypeNames(3,v,str)
end
return str
end,
getName5=function(v)
local str=getElementTypeNames(5,v)
if str==nil then
str=FMT.fmt('{0}属性材料',cfgHelper.get2(cfg_elementtypeconfig_get,v,'name'))
setElementTypeNames(5,v,str)
end
return str
end,
getNameGF=function(v)
local str=getElementTypeNames(2,v)
if str==nil then
str=FMT.fmt('{0}系功法',cfgHelper.get2(cfg_elementtypeconfig_get,v,'name'))
setElementTypeNames(2,v,str)
end
return str
end,
getNamePX=function(v)
local str=getElementTypeNames(4,v)
if str==nil then
str=FMT.fmt('{0}功法',cfgHelper.get2(cfg_factiontypeconfig_get,v,'name'))
setElementTypeNames(4,v,str)
end
return str
end,
getIcon=function(v)
return'icon_yuansu_'..cfgHelper.get2(cfg_elementtypeconfig_get,v,'icon')
end,
getIconEx=function(icon)
if icon then
return'icon_yuansu_'..icon
end
end,
getFive=function(self)
return{self.eGold,self.eWood,self.eWater,self.eFire,self.eSoil}
end,
getVaryIcon=function(typelist)
if#typelist>1 then
return'icon_linggen_be16',globalABLookup.varylinggensprite
else
return'icon_linggen_be'..typelist[1],globalABLookup.varylinggensprite
end
end,
isVary=function(self,type)
return type>=self.eVaryLei and type<=self.eVaryYue
end
}


elementAttrLookup={
[ELEMENT_TYPE.eGold]={101,102},
[ELEMENT_TYPE.eWood]={103,104},
[ELEMENT_TYPE.eWater]={105,106},
[ELEMENT_TYPE.eFire]={107,108},
[ELEMENT_TYPE.eSoil]={109,110},
[ELEMENT_TYPE.eWind]={113,114},
[ELEMENT_TYPE.eThunder]={115,116},
[ELEMENT_TYPE.ePoison]={111,112},
[ELEMENT_TYPE.eSoul]={117,118},
[ELEMENT_TYPE.eBlood]={119,120},

getDesc=function(typo)
return FMT.fmt('{0}系技能威力',ELEMENT_TYPE.getName(typo))
end,
getDesc2=function(typo)
return FMT.fmt('{0}系威力',ELEMENT_TYPE.getName(typo))
end,
}

eSkillHurtType={
eNone=0,
eOut=1,
eIn=2,
}

eSkillHurtLookup={
[eSkillHurtType.eNone]={
name='无',
attr={},
},
[eSkillHurtType.eOut]={
name='物理',
desc='物理伤害',
attr={213},
},
[eSkillHurtType.eIn]={
name='法术',
desc='法术伤害',
attr={215},
},
}

eGrayType=
{
eGray=1,
eMaskGray=2,
eLock=3,
}

eDiscipleSortType=
{
eFightSort=1,
eJingJieSort=2,
eLianTiSort=3,
eColorSort=4,
ePostSort=5,
eFuShang=6,
eShouYuan=7,
eProSkill=8,
eAttr6=9,
eQianLi=10,
eZiZhi=11,
eFanYan=12,
eGenGu=13,
eCongHui=14,
eMeiLi=15,
eJiYuan=16,
ePeiZhi=17,
eDanDao=18,
eShangDao=19,
eFuLu=20,
eLianQi=21,
eZhenFa=22,
eSiYang=23,
eJuLing=24,
eLoyalty=25,
eTeZhi=26,
eAttr6Sum=27,
eBaseAttr6=28,
eClothing=29,
eShangShi=30,
eMYZS_Hp=31,
eDaiShu=32,


getSortList=function(self)
if self.getSortList_==nil then
self.getSortList_={self.eFightSort,self.eJingJieSort,self.eLianTiSort,self.eColorSort,
self.ePostSort,self.eFuShang,self.eShouYuan}
end
return self.getSortList_
end,
getSystemZongMenList1=function(self)
if self.getSystemZongMenSortList1_==nil then
self.getSystemZongMenSortList1_={self.eJingJieSort,self.eCongHui,self.eZhenFa}

end
return self.getSystemZongMenSortList1_
end,
getSystemZongMenList2=function(self)
if self.getSystemZongMenSortList2_==nil then
self.getSystemZongMenSortList2_={self.eJingJieSort,self.eColorSort,self.eLoyalty,self.ePostSort}
end
return self.getSystemZongMenSortList2_
end,

getFSSortList=function(self)
if self.getFSSortList_==nil then
self.getFSSortList_={self.eFightSort,self.eLianTiSort,self.eColorSort}
end
return self.getFSSortList_
end,

}

eDiscipleSortTypeName=
{
[eDiscipleSortType.eFightSort]="战力",
[eDiscipleSortType.eJingJieSort]="境界",
[eDiscipleSortType.eLianTiSort]="炼体",
[eDiscipleSortType.eColorSort]="品质",
[eDiscipleSortType.ePostSort]="职位",
[eDiscipleSortType.eFuShang]="健康",
[eDiscipleSortType.eShouYuan]="寿元",
[eDiscipleSortType.eProSkill]="专业",
[eDiscipleSortType.eAttr6]="6维",
[eDiscipleSortType.eQianLi]="潜力",
[eDiscipleSortType.eZiZhi]="资质",
[eDiscipleSortType.eFanYan]="繁衍",
[eDiscipleSortType.eGenGu]="根骨",
[eDiscipleSortType.eCongHui]="聪慧",
[eDiscipleSortType.eJiYuan]="机缘",
[eDiscipleSortType.eMeiLi]="魅力",
[eDiscipleSortType.ePeiZhi]="培植",
[eDiscipleSortType.eDanDao]="丹道",
[eDiscipleSortType.eShangDao]="商道",
[eDiscipleSortType.eFuLu]="符箓",
[eDiscipleSortType.eLianQi]="炼器",
[eDiscipleSortType.eZhenFa]="阵法",
[eDiscipleSortType.eSiYang]="饲养",
[eDiscipleSortType.eJuLing]="聚灵",
[eDiscipleSortType.eLoyalty]="忠诚度",
[eDiscipleSortType.eTeZhi]="特质数量",
[eDiscipleSortType.eMYZS_Hp]="战力",
[eDiscipleSortType.eDaiShu]="代数",

getName1=function(self,sortType)
return self[sortType]
end,
getName2=function(self,sortType)
return FMT.fmt("{0}顺序",self[sortType])
end,
getName2List=function(self)
local list={}
local temp=eDiscipleSortType:getSortList()
for i,v in ipairs(temp)do
list[i]=self:getName2(v)
end
return list
end,
getName2List2=function(self,typelist)
local list={}
for i,v in ipairs(typelist)do
list[i]=self:getName2(v)
end
return list
end,
getName3List2=function(self,startIdx,endIdx)
local list={}
for i=startIdx,endIdx do
list[i]=self:getName2(i)
end
return list
end,
getName5List=function(self)
local list={}
local temp=eDiscipleSortType:getSortList5()
for i,v in ipairs(temp)do
list[i]=self:getName2(v)
end
return list
end,
getName6List=function(self)
local list={}
local temp=eDiscipleSortType:getFSSortList()
for i,v in ipairs(temp)do
list[i]=self:getName2(v)
end
return list
end,

}

eSortOrder=
{
eUp=true,
eDown=false,
}

eSortOrderEx=
{
eDown=1,
eUp=2,
}


TO_INT_TYPE=
{
eNone=0,
eUp=1,
eDown=2,
}


SEX_TYPE=
{
eMale=1,
eFeMale=2,
eNo=3,

getName=function(v)
return cfgHelper.get2(cfg_disciplesexconfig_get,v,'name')
end,
getName2=function(v)
return cfgHelper.get2(cfg_disciplesexconfig_get,v,'name2')
end
}


RACE_TYPE=
{
eHuman=1,
eDemon=2,
eAnimal=3,
eGhost=4,
}


FACTION_TYPE=
{
eNone=0,
eSword=1,
eBuddh=2,
eTao=3,
eConfucian=4,
eSoul=5,
eSpirit=6,
eMusic=7,
eCharm=8,
eBlood=9,
eDemon=10,
}


eInjuryType=
{
eHealth=0,
eMinor=1,
eSevere=2,
eImminent=3,

getType=function(v)
local range=cfgHelper.get2(cfg_discipleinjuryconfig_get,1,'range')
for i1,v1 in ipairs(range)do
local r=v1[1]
if v>=r[1]and v<=r[2]then
return v1[5]
end
end
return nil
end,
getName=function(self,v)
local typo=self.getType(v)
return self:getNameEx(typo)
end,
getNameEx=function(self,typo)
if typo then
local idx=typo+1
local d=cfgHelper.get3(cfg_discipleinjuryconfig_get,1,'range',idx)
if d then
return d[4]
end
end
end,
getIcon=function(self,v)
local typo=self.getType(v)
return self:getIconEx(typo)
end,
getIconEx=function(self,typo)
if typo~=nil and(typo==self.eMinor or typo==self.eSevere or typo==self.eImminent)then
return'image_zhuangtai_'..typo
end
return nil
end,
getAttrRate=function(self,v)
local typo=self.getType(v)
if typo then
local idx=typo+1
local d=cfgHelper.get3(cfg_discipleinjuryconfig_get,1,'range',idx)
if d then
return d[3]
end
end
return nil
end,
}


CHANGE_TYPE=
{
eInit=0,
eAdd=1,
eDelete=2,
eChanged=3,
}


CHECK_OFFLINE_FORM_TYPE=
{
ePrivateChat=1,
}


CHECK_OFFLINE_RET=
{
eOffline=0,
eLocalServer=1,
eOtherServer=2,
}


SpineUpdateMode=
{
Nothing=0,
OnlyAnimationStatus=1,
OnlyEventTimelines=4,
EverythingExceptMesh=2,
FullUpdate=3,
}




















































































eBiaoQing=
{
jingKong=1,
fengNv=2,
hanYan=3,
siWan=4,
kuQi=5,
shouShang=6,
haiXiu=7,
kaiXin=8,
aiShang=9,
daiZhi=10,
mingXiang=11,
biShi=12,
hanQingMM=13,
}

discipleColorToFrame={
[eQualityColor.eWhite]='frame_dzkpwuse',
[eQualityColor.eGreen]='frame_dzkplvse',
[eQualityColor.eBlue]='frame_dzkplanse',
[eQualityColor.ePurple]='frame_dzkpzise',
[eQualityColor.eOrange]='frame_dzkpchengse',
[eQualityColor.eRed]='frame_dzkphongse',
}

discipleColorToFrame2={
[eQualityColor.eWhite]='frame_dzpz_1',
[eQualityColor.eGreen]='frame_dzpz_1',
[eQualityColor.eBlue]='frame_dzpz_2',
[eQualityColor.ePurple]='frame_dzpz_3',
[eQualityColor.eOrange]='frame_dzpz_4',
[eQualityColor.eRed]='frame_dzpz_5',
}

discipleColorToFrame3={
[eQualityColor.eWhite]='image_dzdjk_1',
[eQualityColor.eGreen]='image_dzdjk_1',
[eQualityColor.eBlue]='image_dzdjk_2',
[eQualityColor.ePurple]='image_dzdjk_3',
[eQualityColor.eOrange]='image_dzdjk_4',
[eQualityColor.eRed]='image_dzdjk_5',
}

globalABLookup=
{
global='ui/sharedtextures/uiglobalspriteatlas_1.ab',
globa4='ui/sharedtextures/uiglobalspriteatlas_4.ab',
cangjingge='ui/windows/gongfa/sharedtextures/cangjinggeicons.ab',
diciplecolorframe='ui/windows/disciple/sharedtextures/uidisciplecolorframeicons.ab',
diciplemain='ui/windows/disciple/sharedtextures/uidisciplemainicons.ab',
zongmendadian='ui/windows/sectpalace/sharedtextures/sectpalaceicons.ab',
task='ui/windows/task/sharedtextures/uitaskicons.ab',
proskill='ui/windows/disciple/sharedtextures/uidisciplejobicons.ab',
mainwin='ui/windows/main/main_sprite_atlas_pak.ab',
mainEntrySprite='ui/windows/main/main_entry_atlas_pak.ab',
login='ui/windows/login/sharedtextures/loginicons.ab',
dashijie_lilian='ui/windows/world/sharedtextures/dashijie_lilian_altas.ab',
gubaomainicons='ui/windows/gubao/sharedtextures/gubaomainicons.ab',
juqingicons='ui/windows/gameplot/sharedtextures/dashijie_story_altas.ab',
tipssprite='ui/windows/tips/sharedtextures/tipssprite.ab',
hud_atlas='ui/windows/hud/hud_sprite_atlas_pak.ab',
fight_lost='ui/windows/fight/sharedtextures/fightlostwinicons.ab',
lingshoumain='ui/windows/lingshou/lingshoumainicons_pak.ab',
xzrome='ui/windows/xianzhan/sharedtextures/xzromeicons.ab',
npcIcons='ui/windows/npc/npcicons_atlas_pak.ab',
npcCommonIcons='ui/windows/npc/npccommonicons_atlas_pak.ab',
rankList="ui/windows/ranklist/ranklist_atlas_pak.ab",
xianzhanIcon='ui/windows/xianzhan/sharedtextures/xianzhan.ab',
yinxiantai='ui/windows/recruit/sharedtextures/yinxiantai_new.ab',
xianmeng='ui/windows/xianmeng/xianmeng_atlas_pak.ab',
xianmengicons='ui/windows/xianmeng/xianmengicons_atlas_pak.ab',
equipJinglian='ui/windows/equip/jinglian_atlas_pak.ab',
funcshopicons='ui/windows/funcshop/sharedtextures/funcshop.ab',
inmysterysprite='ui/windows/mystery/sharedtextures/inmysterysprite.ab',
zhexianling='ui/windows/zhexianling/zhexianling_atlas_pak.ab',
dizitianmingicons='ui/windows/disciple/dizitianmingicons_atlas_pak.ab',
pushGift='ui/windows/pushgift/pushgift_sprite_atlas_pak.ab',
pushGiftTwo='ui/windows/pushgifttwo/pushgift_two_atlas_pak.ab',
gongfatipsicons='ui/windows/gongfa/gongfatipsicons_atlas_pak.ab',
activieSprites='ui/windows/activities/activities_common_atlas_pak.ab',
diziorientationicons='ui/windows/disciple/sharedtextures/diziorientationicons.ab',
xianyuanxunfang='ui/windows/activities/sub_xianshichouka/sharedtextures/xianyuanxunfang.ab',

tianyuanshouchaoicons='ui/windows/xianmeng/act_tianyuanshouchao/tianyuanshouchaoicons_atlas_pak.ab',
limitacticons='ui/windows/limitactivities/limitacticons_atlas_pak.ab',
limitactbigicons='ui/windows/limitactivities/limitactbigicons_atlas_pak.ab',
limitacwinicons='ui/windows/limitactivities/limitacwinicons_atlas_pak.ab',
beginVideo='ui/windows/video/beginvideo_atlas_pak.ab',
systemicons='ui/icons/system/systemicons_atlas_pak.ab',
guildordericons='ui/windows/guildorder/guildordericons_atlas_pak.ab',
fight_prepare='ui/windows/fight/sharedtextures/fight_prepare.ab',
zonmengdabi_baoming='ui/windows/activities/sub_zongmendabi/zongmendabibaoming_atlas_pak.ab',
zonmengdabi_rank='ui/windows/activities/sub_zongmendabi/zongmendabirank_atlas_pak.ab',
zonmengdabi_battle='ui/windows/activities/sub_zongmendabi/zongmendabibattle_atlas_pak.ab',
fightcommonicons='ui/windows/fight/fightcommonicons_atlas_pak.ab',
layoutsprite='ui/windows/layout/sharedtextures/layout.ab',
daobingsprite='ui/windows/daobing/daobing_atlas_pak.ab',
xianshichouka2='ui/windows/activities/sub_xianshichouka2/xianshichouka2_atlas_pak.ab',
chatSprite='ui/windows/chat/sharedtextures/chat_sprite.ab',
daobingBagSprite='ui/windows/daobing/daobing_bag_atlas_pak.ab',
benmingFaBaoSprite='ui/windows/fabao/benming_fabao_atlas_pak.ab',
benmingFaBaoSmallSprite='ui/windows/fabao/fabao_small_atlas_pak.ab',
fabaoSprite='ui/windows/fabao/sharedtextures/fabao_sprite.ab',
xmdgzsicons='ui/windows/xianmeng/act_xianmengdigong/xmdgzsicons_atlas_pak.ab',
xmdgmainicons='ui/windows/xianmeng/act_xianmengdigong/xmdgmainicons_atlas_pak.ab',
actpreviewicons='ui/windows/activities/actpreview_atlas_pak.ab',
lingcuishopicons='ui/windows/disciple/lingcuishopicons_atlas_pak.ab',
zawubuicons='ui/windows/main/zawubuicons_atlas_pak.ab',
lingxuwenjianicons='ui/windows/xianmeng/act_lingxuwenjian/lingxuwenjianicons_atlas_pak.ab',
gubaonamesprite='ui/windows/gubao/gbname_atlas_pak.ab',
wxdsprite='ui/windows/wuxingdian/wxd_sprite_atlas_pak.ab',
wxdrewardssprite='ui/windows/wuxingdian/wxd_rewards_atlas_pak.ab',
wxdtouzisprite='ui/windows/wuxingdian/wxd_touzi_atlas_pak.ab',
varylinggensprite='ui/windows/disciple/varyspriteroot_atlas_pak.ab',
wxdtitlesprite='ui/windows/wuxingdian/wxd_title_atlas_pak.ab',
gubaotipsicons='ui/windows/gubao/gubaotipsicons_atlas_pak.ab',
wanbaoxunbaodui='ui/windows/wanbaoxunbaodui/wanbaoxunbaodui_atlas_pak.ab',
cangbaotuchat='ui/windows/activities/sub_cangbaotu/cangbaotu_chat_atlas_pak.ab',
dicipleroleinfo='ui/windows/disciple/sharediscipleroleinfo_atlas_pak.ab',
qiecuosprite='ui/windows/diziqiecuo/qiecuo_atlas_pak.ab',
tianmoruqinsprite='ui/windows/activities/sub_tianmoruqin/tianmoruqin_chat_atlas_pak.ab',
fabaomiluicons='ui/windows/activities/sub_fabaomilu/fabaomilu_atlas_pak.ab',
fabaoshilianicons='ui/windows/activities/sub_fabaoshilian/fabaoshilian_atlas_pak.ab',
shuwusprite='ui/windows/disciple/shuwudizi_atlas_pak.ab',
yufulingzhen='ui/windows/yufulingzhen/yufulingzhen_atlas_pak.ab',
zzshicons='ui/windows/xianmeng/act_zhengzhanshanhai/zhengzhanshanhaiicons_atlas_pak.ab',
prosperity='ui/windows/prosperity/prosprity_atlas_pak.ab',
xdpdicons='ui/windows/xiangongpingding/xgpd_atlas_pak.ab',
zzshbossicons='ui/windows/xianmeng/act_zhengzhanshanhai/zzshbossicons_atlas_pak.ab',
zzshentityicons='ui/windows/xianmeng/act_zhengzhanshanhai/zzshentityicons_atlas_pak.ab',
zzshtitleicons='ui/windows/xianmeng/act_zhengzhanshanhai/zzshtitleicons_atlas_pak.ab',
zzshxmicons='ui/windows/xianmeng/act_zhengzhanshanhai/zzshxmicons_atlas_pak.ab',
limitinvestorgift='ui/windows/activities/sub_limitinvestor/limitinvestorgift_atlas_pak.ab',
bigworldmap_component='ui/windows/worldmap/sharedtextures/bigworldmap_component_altas.ab',
dashijie_component='ui/windows/world/sharedtextures/dashijie_component_altas.ab',
hongchenjie='ui/windows/hongchenjie/hongchenjie_atlas_pak.ab',
xianfawendao='ui/windows/xianfawendao/xfwd_atlas_pak.ab',
liandonLogin='ui/windows/common/liandonlogincommon_atlas_pak.ab',
xianbaomainicons='ui/windows/xianbao/xianbao_atlas_pak.ab',
airmainicons='ui/windows/airminigame/air_game_atlas_pak.ab',
lundaodahui='ui/windows/lundaodahui/lundaodahui_atlas_pak.ab',
wendingcangqiong='ui/windows/wendingcangqiong/wdcq_atlas_pak.ab',
xjhudicons='ui/windows/xianjie/xianjiemain_hud_atlas_pak.ab',
xjtaskicons='ui/windows/xianjie/xianjietask_atlas_pak.ab',
xianguan='ui/windows/xianguan/xianguan_atlas_pak.ab',
xjcloudicons='ui/windows/xianjie/xianjiecloud_atlas_pak.ab',
xjhud2icons='ui/windows/xianjie/xianjiehud2icons_atlas_pak.ab',
zongmenlevelinvestor='ui/windows/welfare/welfare_zongmenlevelinvestor_atlas_pak.ab',
totaltouzi_atlas='ui/windows/totaltouziactivity/totaltouzi_atlas_pak.ab',
xjcloudunlockmapgrid='ui/windows/xianjie/xianjiecloudunlockmap/cloudunlockmap_grid_atlas_pak.ab',
xjcloudunlockmaptancha='ui/windows/xianjie/xianjiecloudunlockmap/cloudunlockmap_tancha_atlas_pak.ab',
xianguanJingXuan='ui/windows/xianguan/xianguan_jingxuan_atlas_pak.ab',
shilianzhengtu_base_atlas='ui/windows/shilianta/shilianzhengtu_base_atlas_pak.ab',
xgbigicon='ui/windows/xianguan/xgbigicon_atlas_pak.ab',
dizidaoyanicons='ui/windows/disciple/dizidaoyanicons_atlas_pak.ab',
xiangong='ui/windows/xiangong/xiangong_atlas_pak.ab',
bluediamondIcon='ui/windows/bluediamond/bluediamond_icon_atlas_pak.ab',
wanzongduijueicons='ui/windows/activities/sub_wanzongduijue/wanzongduijue_atlas_pak.ab',
jiuyuzhengfeng='ui/windows/jiuyuzhengfeng/jyzf_atlas_pak.ab',
mogongzhengduo='ui/windows/mogongzhengduoact/mogongzhengduo_atlas_pak.ab',
lingshouxuemai='ui/windows/lingshou/lingshouxuemai_atlas_pak.ab',
}
ITEM_FUNC_CND_TYPE=
{
eRandomJilv=0,
eJingjieLv=1,
eLiantiLv=2,
eAttr6=3,
eProSkill=4,
eZongmenLv=5,
eLingshouLv=6,
eLingGen=7,
eTeZhi=8,
eLingShouAttr2=10,
}


screenStageType=
{
plotAction=-1,
dialogueAction=-2,
interactWorldNPC=-3,
interactSystemZongMenOutgoer=-4,
}


WARNING_TYPE=
{
eNone=1,
eWarning=2,
eRechargeDialogue=3,
eOnlyWaring=4,
}


eHeadCenterType=
{
eNone=0,
eHead=1,
eHalf=2,
eSymbol=3,
eFullBody=4,
}


eNumberType=
{
eZero=0,
eOne=1,
eTwo=2,
eThree=3,
eForth=4,
eFifth=5,
eSix=6,
eSeven=7,
eEight=8,
eNine=9,
eTen=10,

getName=function(self,v)
if self.namelist==nil then
self.namelist={[0]='零','一','二','三','四','五','六','七','八','九','十'}
end
return self.namelist[v]
end,
getName2=function(self,v)
if self.namelist2==nil then
self.namelist2={'初代','二代','三代','四代'}
end
return self.namelist2[v]
end,
}


eEquipChangeType={
eNone=0,
eReplace=1,
eSetup=2,
eRemove=3,
eRefresh=4,

geName=function(self,v)
if self.namelist==nil then
self.namelist={'替换','装备','卸下','更换'}
end
return self.namelist[v]
end
}



eArrowDirectionType=
{
eBottomLeft=1,
eBottomRight=2,
eTopLeft=3,
eTopRight=4,
}

eDirectionType=
{
eLeft=1,
eRight=2,
eTop=3,
eBottom=4,
}


eAttributeTypeEx={
eFight=404,
}


changeNameType={
eDisciple=1,
eLingshou=2,
eXianMeng=3,
eZZSHSign=4,
eXJSign=5,
eXJYunZhou=6,
eXJYunZhou_team=7,
}

local nologstr='未知错误'

changeNameLog=
{
[1]='无免费次数',
[2]='有免费次数',
[3]='消耗不足',
[4]='弟子来源类型不支持',
[5]='名字中含有敏感字符',
[6]='名字仅限中文',

getlog=function(self,v)
if self[v]==nil then
return nologstr
end
return self[v]
end
}


difficultyType={
eEasy=1,
eCommon=2,
eHard=3,

getName=function(this_,v)
if this_.namelist==nil then
this_.namelist={"简单","普通","噩梦","深渊","稀有","史诗","传说"}
end
return this_.namelist[v]
end
}


littleGameType=
{
eLianLianKan=1,
eTuLingGuiWei=2,
eLongGuLianHua=3,
eGuHeJieMi=4,
eWanBaoJianShang=5,
eLingYunLanZhong=6,
e2048=7,
eastroke=8,
eDrawFuWin=9,
eCatchLingShou=10,
}


shopLibaoType=
{
eDay=1,
eWeek=2,
eMonth=3,
eGuangGao=4,
eGain=5,
eQQLobby_Active=6,
eQQLobby_Login=7,
eQQLobby_Grown=8,

blueDiamondNewBieGift=9,
blueDiamondDailyGift=10,
blueDiamondGrowUpGift=11,
}

CAMERA_TYPE=
{
eFight=1,
eHome=2,
eWorld=3,
eMiJing=4,
eAirGame=5,
eXianJie=6,
}

USER_TYPE=
{
ePrivateProtected=1,
eUserProtocol=2,
}

ITEM_USE_TYPE=
{
eSigleUse=1,
eMultipleUse=2,
}

timeSecLook=
{
eOneDaySec=86400,
eSevenDaySec=604800,
eTwoWeekSec=1209600,

getDaySec=function(self,dnum)
return self.eOneDaySec*dnum
end,
}


MONSTER_TYPE={
eXiaoGuai=1,
eJingYing=2,
eShouLing=3,
}

DOWNLOAD_TYPE=
{
eUnDownLoad=-1,
eDownLoading=0,
eDownLoaded=1,
}

eNetworkReachability=
{

NotReachable=0,

ViaCarrierData=1,

ViaLocalArea=2,
}

BUILD_TAB_TYPE=
{
eOther=0,
eJingGuan=1,
eFunction=2,
eProduction=3,
eShop=4,
eHoldJingGuan=5,
}

eSpecialAttrType={
DISCIPLE_SPE_ATTR_ID_ATTR_1=1,
DISCIPLE_SPE_ATTR_ID_ATTR_2=2,
DISCIPLE_SPE_ATTR_ID_ATTR_3=3,
DISCIPLE_SPE_ATTR_ID_ATTR_4=4,
DISCIPLE_SPE_ATTR_ID_ATTR_5=5,
DISCIPLE_SPE_ATTR_ID_ATTR_6=6,
DISCIPLE_SPE_ATTR_ID_SHOUYUAN=7,
DISCIPLE_SPE_ATTR_ID_SEX=8,
DISCIPLE_SPE_ATTR_ID_STAND=9,
DISCIPLE_SPE_ATTR_ID_LOYALTY=10,
DISCIPLE_SPE_ATTR_ID_INJURY=11,
DISCIPLE_SPE_ATTR_ID_SATIETY=12,
DISCIPLE_SPE_ATTR_ID_VOC=13,
DISCIPLE_SPE_ATTR_ID_JINGJIE=14,
DISCIPLE_SPE_ATTR_ID_LIANTI=15,
DISCIPLE_SPE_ATTR_ID_DUJIE=16,
DISCIPLE_SPE_ATTR_ID_GONGFAEXP=17,
DISCIPLE_SPE_ATTR_ID_JINGJIEEXP=18,
DISCIPLE_SPE_ATTR_ID_LIANTIEXP=19,
DISCIPLE_SPE_ATTR_ID_PROSKILL_1=21,
DISCIPLE_SPE_ATTR_ID_PROSKILL_2=22,
DISCIPLE_SPE_ATTR_ID_PROSKILL_3=23,
DISCIPLE_SPE_ATTR_ID_PROSKILL_4=24,
DISCIPLE_SPE_ATTR_ID_PROSKILL_5=25,
DISCIPLE_SPE_ATTR_ID_PROSKILL_6=26,
DISCIPLE_SPE_ATTR_ID_PROSKILL_7=27,
DISCIPLE_SPE_ATTR_ID_PROSKILL_8=28,
DISCIPLE_SPE_ATTR_ID_COLOR=29,
DISCIPLE_SPE_ATTR_ID_NAME=30,
DISCIPLE_SPE_ATTR_ID_MAXHP=31,
DISCIPLE_SPE_ATTR_ID_STATE=32,
DISCIPLE_SPE_ATTR_ID_POS=33,
}

eSpecialAttrName=
{
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_1]={"资质"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_2]={"根骨"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_3]={"聪慧"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_4]={"潜力"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_5]={"魅力"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_6]={"机缘"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_SHOUYUAN]={"寿元"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_LOYALTY]={"忠诚度"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_INJURY]={"负伤值"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_VOC]={"职业"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_DUJIE]={"渡劫成功率",isPercent=true},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_GONGFAEXP]={"功法经验"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_JINGJIEEXP]={"境界修为"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_LIANTIEXP]={"炼体经验"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_1]={"培植"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_2]={"丹道"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_3]={"商道"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_4]={"符箓"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_5]={"炼器"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_6]={"阵法"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_7]={"饲养"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_8]={"聚灵"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_LIANTI]={"炼体"},
[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_JINGJIE]={"境界"},

getName=function(self,v)
return self[v][1]
end,
isPercent=function(self,v)
return self[v].isPercent
end,
getDesc=function(self,v,p)
local s
if p>=0 then
s=FMT.fmt('+{0}',p)
else
s=tostring(p)
end
if self:isPercent(v)then
s=FMT.fmt('{0}{1}%',self:getName(v),s)
else
s=FMT.fmt('{0}{1}',self:getName(v),s)
end
return s
end,
}

eSpecialAttrFunc={

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_1]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eZiZhi)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_2]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eGenGu)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_3]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eCongHui)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_4]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eQianLi)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_5]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eMeiLi)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_ATTR_6]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleBaseAttr(guid,DISCIPLE_BASE_ATTR_TYPE.eJiYuan)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_VOC]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleJob(guid)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_JINGJIE]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleJJLevel(guid)
end,
getValueStr=function(guid,v)
v=v or UIDiscipleModel:getDiscipleJJLevel(guid)
return UIDiscipleModel:getJJName3(v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_LIANTI]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleLTLevel(guid)
end,
getValueStr=function(guid,v)
v=v or UIDiscipleModel:getDiscipleLTLevel(guid)
return UIDiscipleModel:getLTName3(v)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_1]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.ePeiZhi)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_2]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eDanDao)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_3]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eShangDao)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_4]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eFuLu)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_5]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eLianQi)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_6]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eZhenFa)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_7]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eSiYang)
end,
},

[eSpecialAttrType.DISCIPLE_SPE_ATTR_ID_PROSKILL_8]={
getValue=function(guid)
return UIDiscipleModel:getDiscipleJobLevel(guid,DISCIPLE_PROSKILL_TYPE.eJuLing)
end,
},


getValue=function(self_,typo,guid)
return self_[typo].getValue(guid)
end,
getValueStr=function(self_,typo,guid,v)
if self_[typo].getValueStr then
return self_[typo].getValueStr(guid,v)
else
v=v or self_[typo].getValue(guid)
return v
end
end,
}

WanBaoXunBaoDuiOperationType={
DoTask=1,
StopTask=2,
Return=3,
FinishTask=4,
Recruit=5,
QuickDispath=6,
}

mapIdType={
zhufeng=1,
lingshoudao=2,
xianzhan=3,
xianmeng=4,
zhufeng_hy=5,
zhufeng_design=6,
fort=7,
}

ACT_EXTEND_LIMIT={
Normal=9,
big=2,
}

LingGenShowListIndex={
SmalIcon=1,
BigIcon=2,
BidWold=3,
Dikuang=4,
nodeSpine=5,
infoNodeSpine=6,
varyEffect=7,
nodeButtonImg=8,
varyingNodeEffectFailed=9,
varyingNodeEffectSuccess=10,
varyingDiscipleEffect=11,
}

LinggenTipsType={
select_1=1,
select_2=2,
select_3=3,
select_4=4,
select_5=5,
}

BUILD_LIGHT_TYPE={
DAY=0,
DUSK=1,
NIGHT=2,
DAWN=3,
}


BUILD_LIGHT_Scene_TYPE={
eZongMen=0,
eXianZhan=1,
eXianMen=2,
eDSJ_TaiYueShanMai=3,
eDSJ_TianYunZhou=4,
eDSJ_NanJiang=5,
eDSJ_TianShan=6,
eHolderPlace_1=7,
eHolderPlace_2=8,
eHolderPlace_3=9,
eZhanZhengBaoLei=10,
eLingShouDao=11,
}


BUILD_LIGHT_DASHIJIE_TYPE=
{
[1]=BUILD_LIGHT_Scene_TYPE.eDSJ_TaiYueShanMai,
[2]=BUILD_LIGHT_Scene_TYPE.eDSJ_TianYunZhou,
[3]=BUILD_LIGHT_Scene_TYPE.eDSJ_NanJiang,
[4]=BUILD_LIGHT_Scene_TYPE.eDSJ_TianShan,
}

function getWorldIDLightType(worldID)
return BUILD_LIGHT_DASHIJIE_TYPE[worldID]
end


sendMessageServerType={
eNone=0,
eKuafu=1,
eXJKuafu=2,
}

QualityColorNewType=
{
white=1,
black=2,
}


function getQualityColorNew(type,color)
if color and type then
local cfgdata=cfgHelper.get2(cfg_qualitycolornewconfig_get,1,'colortype')
if cfgdata and cfgdata[type]and cfgdata[type][color]then
return cfgdata[type][color]
else
return"#FFFFFF"
end
else
return"#FFFFFF"
end
end


SHOP_CREATE_TYPE={
eAutoFinish=0,
eNull=1,
eFinish=2,
eCreating=3,
eNone=4,
}

GraphicsQualityLevel=
{
Low=1,
High=2,
}


XianBaoEffectType=
{
ZTP=1,
}


sceneLineType={
eGreenArrow=0,
eBlueArrow=1,
eRedArrow=2,
eGrayArrow=3,
}


bigCrossActType={
eWDCQ=1,
}

sysWinType={
eDefault=0,
eFangAn=1,
eZiRan=2,
eBuff=3,
eShangPu=4,
eJingGuang=5,
eMiZhen=6,
eZhenYan=7,
eShouLan=8,
eXianMeng=9,
eSuitPart=10,
eFeiShengTai=11,
efujiezhibao=12,
eQiYu=13,
eAutoBuild=14,
eLingShouFengQiYu=15,
}

buildingCDType={
build=1,
plan=2,
natural=3,
liandan=4,
lianqi=5,
xiufu=6,
xuanshang=7,
chanrao=8,
zhifu=9,
tiandaohecheng=10,
binggongfang=11,
shangpu=12,
lianDanXiuFu=13,
dujiexiandan=14,
taixucang=15,
zhalu=16,
littleworld=17,
xjtrain=18,
zwgPlane=19,
yushoufang=20,
}

buildingCDFuncType={
build=1,
manufacture=2,
}


RewardTempState={
eNone=0,
eRecved=1,
eNotRecv=2,
eRecv=3,
}

SeasonEnterPrefabTypeEnum={
eNormal=1,
ePreview=2,
}



eBagItemSubType={

eAll=1,

eBaoXiang=2,

eFuLu=3,

eMiYao=4,

eYuanPei=5,

eBiLu=6,

eOther=7

}

haoPingYouLiTypeEnum={
eNone=0,
ePopUpEnd=1,
eClickURL=2,
eReward=3,
}