fabaoPrizeControl={}

BATCH_PRIZE_TYPE=
{
eLianDan=1,
eBatchLianDan=2,
eLianQi=3,
eBatchLianQi=4,
eBatchYuFu=5,
}

local _recvPrizeFunc=
{
[BATCH_PRIZE_TYPE.eLianDan]=function(args)
local sfId=args.sf_id
local ubdId=args.un_build_id
local curr_cnt=args.curr_cnt
local begintime=args.begintime
local totaltimes=args.totaltimes
UIDanYaoController.onPrizeDanYaoList(sfId,ubdId,curr_cnt,begintime,totaltimes)
end,
[BATCH_PRIZE_TYPE.eBatchLianDan]=function(args)
local sfId=args.sf_id
local ubdId=args.un_build_id
local curr_cnt=args.current_cnt
local begintime=args.begintime
local idx=args.idx
local remove_cnt=args.remove_cnt
local over=args.over
UIDanYaoController.onPrizeBatchDanYaoList(sfId,ubdId,begintime,idx,remove_cnt,curr_cnt,over)
end,
[BATCH_PRIZE_TYPE.eLianQi]=function(args)
local sfId=args.sf_id
local ubdId=args.un_build_id
local itemguid=args.fabaoguid
fabaoProtocolControl.onFabaoPrize(sfId,ubdId,itemguid,true)
end,
[BATCH_PRIZE_TYPE.eBatchLianQi]=function(args)
local sfId=args.sfid
local ubdId=args.buildguid
local idx=args.idx
local over=args.over
fabaoProtocolControl.onPrizeBatch(sfId,ubdId,idx,over)
end,
[BATCH_PRIZE_TYPE.eBatchYuFu]=function(args)
local sfId=args.sfid
local ubdId=args.buildguid
local count=args.cnt
UIFullFuLuFangControl.recv_3_170(sfId,ubdId,count)
end,
}

function fabaoPrizeControl.onBatchPrzie(len,array)
if len<=0 or array==nil then return end
for i,v in ipairs(array)do
local recvtype=v.recvtype
if _recvPrizeFunc[recvtype]then
_recvPrizeFunc[recvtype](v)
end
end
end