






local _MODULENAME="serverSaveModel"




def_table(_MODULENAME)
serverSaveModel.name=_MODULENAME



serverSaveModel.SYSTEM_ENUM={

HAVE_DAO_BING=1,
NEWBIE_DATA=4,
NEWBIE_BRANCH_DATA=5,

REVIEW_DATA=6,
REVIEW_DATA_RED_DZ=7,
REVIEW_DATA_SPECIAL_DZ=8,
REVIEW_DATA_LEVEL=9,
SUPER_VIP_DATA_START_TIME=10,
AUCTION_WBSH_GUANZHU_STATE=11,
SHANGHANG_LEAVE_TIME=12,
WXEnter_ID=13,
ZhongQiuDengMiActivity=14,
XianJiePointRecord=15,
systemZMVassalPlot=16,
ZongMenReviewShare=17,
SpecialityMark=18,
EquipPreset=19,
EquipPresetArrayIndexPool=20,
BAG_EQUIP_FILTER_COUNT=21,
MoJieYuGao=22,
BaoShuZhuLingOpen=23,
}

local _handles={}

local _this=serverSaveModel

local function registerHandle(type,handle)
table.checkCreateSubTable(_handles,{type})
table.insert(_handles[type],handle)
end


function serverSaveModel:onAppStart()



registerHandle(self.SYSTEM_ENUM.HAVE_DAO_BING,daobingModel.onInitDaoBingRecord)
registerHandle(self.SYSTEM_ENUM.NEWBIE_DATA,newbieModel.initFinishData)
registerHandle(self.SYSTEM_ENUM.NEWBIE_BRANCH_DATA,newbieModel.initBranchFinishData)

registerHandle(self.SYSTEM_ENUM.REVIEW_DATA,UIGoodReviewsControl.initReviewData)
registerHandle(self.SYSTEM_ENUM.REVIEW_DATA_RED_DZ,UIGoodReviewsControl.initReviewDataRedDZCount)
registerHandle(self.SYSTEM_ENUM.REVIEW_DATA_SPECIAL_DZ,UIGoodReviewsControl.initReviewDataSpecialDZCount)
registerHandle(self.SYSTEM_ENUM.REVIEW_DATA_LEVEL,UIGoodReviewsControl.initReviewDataZMLevel)
registerHandle(self.SYSTEM_ENUM.SUPER_VIP_DATA_START_TIME,superZuShiModel.initSuperZuShiEnterFirstShowTime)
registerHandle(self.SYSTEM_ENUM.AUCTION_WBSH_GUANZHU_STATE,auctionModel.initAuctionItemGuanZhuState_WBSH)
registerHandle(self.SYSTEM_ENUM.SHANGHANG_LEAVE_TIME,shangHangController.load_leave_time)
registerHandle(self.SYSTEM_ENUM.WXEnter_ID,welfareController.initWXEnter_ID)
registerHandle(self.SYSTEM_ENUM.ZhongQiuDengMiActivity,serverSaveModel.setZQDMActivityData)
registerHandle(self.SYSTEM_ENUM.systemZMVassalPlot,systemZongmenRelationController.setSystemZMPlotData)
registerHandle(self.SYSTEM_ENUM.ZongMenReviewShare,JiuChongTianJieEnterController.setZongMenReivewShareStamp)

registerHandle(self.SYSTEM_ENUM.SpecialityMark,UIDiscipleModel.loveSpeciality)
registerHandle(self.SYSTEM_ENUM.EquipPreset,discipleEquipPresetController.initEquipPresetGuidData)
registerHandle(self.SYSTEM_ENUM.EquipPresetArrayIndexPool,discipleEquipPresetController.initEquipPresetArrayIndexPool)
registerHandle(self.SYSTEM_ENUM.BAG_EQUIP_FILTER_COUNT,bagModel.initBagEquipFilterCount)
registerHandle(self.SYSTEM_ENUM.MoJieYuGao,MojiePreviewExtendController.initSeverData)
registerHandle(self.SYSTEM_ENUM.BaoShuZhuLingOpen,gubaoModel.initBaoShuZhuLingOpenData)
end


function serverSaveModel:onEnterState()
self.jsonStr=nil
self.jsonData={}
self.jsonDataTemp={}
end


function serverSaveModel:onLeaveState()

self.jsonStr=nil
self.jsonData={}
self.jsonDataTemp={}
end


function serverSaveModel:onServerDataInitFinish()

end



function serverSaveModel:DispathData(type,len,array)
local handles=_handles[type]
if handles then
for i,v in ipairs(handles)do
v(len,array)
end
end
end







SERVER_JSON_DATA_TYPE=
{
eFaLing=1,
eAir=2,
eXJYZData=3,
eXiaoZhuShou=4,
eXJYZYZData=5,
eEquipPreset=6,
eFixCode=7,
}
local _json_data_type={}
for k,v in pairs(SERVER_JSON_DATA_TYPE)do
_json_data_type[v]=true
end

function serverSaveModel:saveJsonData(jsonStr)
self.jsonStr=jsonStr
if jsonStr==''then
self.jsonData={}
self.jsonDataTemp={}
return
end
self.jsonData=jsonHelper.decode(jsonStr)
self.jsonDataTemp=table.deepCopy(self.jsonData)
end

function serverSaveModel:getJsonData(dataType)
if self.jsonData==nil then return nil end
if self.jsonData[dataType]==nil or type(self.jsonData[dataType])=='userdata'then return end
return self.jsonData[dataType]
end


function serverSaveModel:setTempJsonData(dataType,data)
if _json_data_type[dataType]==nil then
loggerUtil.debugErrFMT('保存失败，请先定义！')
return
end
self.jsonDataTemp[dataType]=data
self.jsonData[dataType]=data
return jsonHelper.encode(self.jsonDataTemp)
end

function serverSaveModel:getJsonStr()
return self.jsonStr
end



function serverSaveModel.setZQDMActivityData(len,arr)
if len>0 then
serverSaveModel.ZQDMRecordData=arr
end
end
function serverSaveModel:getZQDMActivityData()
return serverSaveModel.ZQDMRecordData
end