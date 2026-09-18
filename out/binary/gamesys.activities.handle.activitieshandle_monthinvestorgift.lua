







activitiesHandle_monthInvestorGift=new_activitiesHandle('activitiesHandle_monthInvestorGift',activitiesHandle)

function activitiesHandle_monthInvestorGift:onInit()

end

function activitiesHandle_monthInvestorGift.recv_249_20(args)
local subType=SUB_ACTIVITY_TYPE.eYueKaZengLi
local actId=args[1]
local subId=args[2]
local yuekaStatus=args[3]
local jikaStatus=args[4]
local ykDiscount=args[5]
local jkDiscount=args[6]
local data={
normalRequirement=yuekaStatus,
highRequirement=jikaStatus,
normalDisCount=ykDiscount,
highDisCount=jkDiscount,
}

activitiesModel:setSubActInfoData(actId,subType,subId,data)

local win=UIManager:findActiveWindow('UISubAct_monthInvestorGiftWin')
if win then
win:refresh()
end


reddotControl.on_change_catch_type(CATCH_TYPE.eActivityChange,subType)


win=UIManager:findActiveWindow('UIMonthInvestorWin')
if win then
win:refresh()
end
end