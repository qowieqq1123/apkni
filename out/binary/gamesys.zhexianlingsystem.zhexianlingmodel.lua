






local _MODULENAME="zheXianLingModel"




def_table(_MODULENAME)
zheXianLingModel.name=_MODULENAME

zheXianLingModel.data={}


function zheXianLingModel:onAppStart()
self:init()
end



function zheXianLingModel:onLeaveState(isReconnect)

self:init()
end


function zheXianLingModel:onEnterState(isReconnect)

end

function zheXianLingModel:onProtocolReq()
zheXianLingModel:checkEnterNextBook()
end

function zheXianLingModel:init()
self.data={}
self.data.list={}
self.data.lookup={}
self.data.rewardsBookLookup={}
self.data.rewardsChapterLookup={}
self.data.finishedBookLookup={}
self.data.finishedChapterLookup={}

self.data.bookTaskLookup={}

self.data.jiyuantimes=0
self.data.jiyuanid=1
self.data.jiyuanFlag=0
self.data.jiyuanFinish=false

self.data.chapter_id=nil
self.data.book_id=nil
end

function zheXianLingModel:initData(len,array,jiyuantimes,jiyuanid,rewardflag)
self.data.list=array
self.data.lookup={}
if array then
for i,v in ipairs(array)do
local book_id=v.book_id
local book_status=v.book_status
if book_status==ZHE_XIAN_LING_STATUS.eDoing or
book_status==ZHE_XIAN_LING_STATUS.eFinish or
book_status==ZHE_XIAN_LING_STATUS.eReward then
if self.data.book_id==nil or book_id>self.data.book_id then
self.data.book_id=book_id
end
for i,vv in ipairs(v.chapterInfo or{})do
if vv.status==ZHE_XIAN_LING_STATUS.eDoing or
vv.status==ZHE_XIAN_LING_STATUS.eFinish or
vv.status==ZHE_XIAN_LING_STATUS.eReward then
local chapter_id=vv.chapter_id
if self.data.chapter_id==nil or chapter_id>self.data.chapter_id then
self.data.chapter_id=chapter_id
end
end
end
end
self.data.lookup[book_id]=v
end
end

self.data.jiyuantimes=jiyuantimes
self.data.jiyuanid=jiyuanid
self.data.jiyuanFlag=rewardflag
self.data.jiyuanFinish=false
self:checkNextJiYuanRewards()


self:initRewardedLookup()


self:initFinishedLookup()


self:initBookTask()

zheXianLingController:freshTaskWindow('refreshZheXianLing')
end

function zheXianLingModel:onOpenNewBook(book_id)


local old_book_id=self.data.book_id

self.data.list=self.data.list or{}
local list=self.data.list
local chapterids=zheXianLingConfig.getBookconfig(book_id).chapterids
local len=#chapterids

local info=
{
book_id=book_id,
book_status=ZHE_XIAN_LING_STATUS.eDoing,
len=len,
}

info.chapterInfo={}
local chapterInfo=info.chapterInfo
for i=1,len do
local _info={}
_info.chapter_id=chapterids[i]
_info.status=i==1 and ZHE_XIAN_LING_STATUS.eDoing or ZHE_XIAN_LING_STATUS.eUnStart
_info.len=0
chapterInfo[#chapterInfo+1]=_info
end

self.data.lookup[book_id]=info
list[#list+1]=info
self.data.book_id=book_id
self.data.chapter_id=chapterids[1]


self:initRewardedLookup()


self:initFinishedLookup()


self:initBookTask()

zheXianLingController:freshTaskWindow('refreshZheXianLing')

if old_book_id then
systemControl.onZheXianLingChanged(old_book_id)
end

newbieControl.startNewbie(NEW_BIE_CND_TYPE.eZheXianLing,book_id)
end

function zheXianLingModel:onOpenNewChapter(chapter_id)

local last_chapter_id=self.data.chapter_id
local book_id=self.data.book_id
local bookInfo=self.data.lookup[book_id]
local has=false
for k,v in pairs(bookInfo.chapterInfo or{})do
if v.chapter_id==chapter_id then
v.status=ZHE_XIAN_LING_STATUS.eDoing
has=true
break
end
end

if not has then
if bookInfo.chapterInfo==nil then bookInfo.chapterInfo={}end
local chapterInfo=bookInfo.chapterInfo
local info={}
info.chapter_id=chapter_id
info.status=ZHE_XIAN_LING_STATUS.eDoing
chapterInfo[#chapterInfo+1]=info
end

self.data.chapter_id=chapter_id


self:initRewardedLookup()


self:initFinishedLookup()


self:initBookTask()

local book_id,index=zheXianLingConfig.getChapterIndex(last_chapter_id)
systemControl.onZheXianLingChanged(book_id,index)

newbieControl.startNewbie(NEW_BIE_CND_TYPE.eZheXianLing,book_id,index)
end

function zheXianLingModel:onRewards(typo,id)
if typo==1 then
self:onRewardBook(id)
elseif typo==2 then
self:onRewardChapeter(id)
end
end

function zheXianLingModel:onRewardJiYuan(idx)
if self.data.jiyuanid==nil then return end
local id=self.data.jiyuanid
self.data.jiyuanFlag=mathHelper.setbit(self.data.jiyuanFlag,idx-1)
self:checkNextJiYuanRewards()
end

function zheXianLingModel:onJiYuanTimesChanged(times)
self.data.jiyuantimes=times
end

function zheXianLingModel:onRewardBook()
local book_id=self.data.book_id
local bookInfo=self.data.lookup[book_id]
bookInfo.book_status=ZHE_XIAN_LING_STATUS.eReward

self:initRewardedLookup()


self:initFinishedLookup()

systemControl.onZheXianLingChanged(book_id)
notifySystem:postNotify(notifyConfig.onZheXianLingChange,book_id)

zheXianLingController:freshTaskWindow('refreshZheXianLing')
end

function zheXianLingModel:checkEnterFirstBook()
if self.data.list~=nil then return end
if self.data.book_id~=nil and self.data.book_id>0 then return end
local bookList=zheXianLingConfig.getBookLine()
local book_id=bookList[1]
if zheXianLingModel:canOpenBook(book_id)then
socketManager:send_27_2(book_id)
return true
end
return false
end

function zheXianLingModel:enterNextBook()
local book_id=self.data.book_id
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
local nextid=bookCfg.nextid
if nextid==nil then
return
end
if zheXianLingModel:canOpenBook(nextid)then
socketManager:send_27_2(nextid)
end
end

function zheXianLingModel:onFinishCurrentChapeter()
local chapter_id=self.data.chapter_id
local book_id=self.data.book_id
local bookInfo=self.data.lookup[book_id]
local has=false
for k,v in pairs(bookInfo.chapterInfo or{})do
if v.chapter_id==chapter_id then
if v.status==nil or v.status<ZHE_XIAN_LING_STATUS.eFinish then
v.status=ZHE_XIAN_LING_STATUS.eFinish
end
has=true
break
end
end
if not has then
if bookInfo.chapterInfo==nil then bookInfo.chapterInfo={}end
local chapterInfo=bookInfo.chapterInfo
local info={}
info.chapter_id=chapter_id
info.status=ZHE_XIAN_LING_STATUS.eFinish
local cfgTaskids=zheXianLingConfig.getTaskIds(chapter_id)
info.len=#cfgTaskids
info.taskids={}
local taskids=chapterInfo.taskids or{}
for _,v in ipairs(cfgTaskids)do
taskids[#taskids+1]=v
end
chapterInfo[#chapterInfo+1]=info
end
end

function zheXianLingModel:onRewardChapeter(chapter_id)
local book_id=self.data.book_id
local bookInfo=self.data.lookup[book_id]
local has=false
for k,v in pairs(bookInfo.chapterInfo or{})do
if v.chapter_id==chapter_id then
v.status=ZHE_XIAN_LING_STATUS.eReward
has=true
break
end
end
if not has then
if bookInfo.chapterInfo==nil then bookInfo.chapterInfo={}end
local chapterInfo=bookInfo.chapterInfo
local info={}
info.chapter_id=chapter_id
info.status=ZHE_XIAN_LING_STATUS.eReward
local cfgTaskids=zheXianLingConfig.getTaskIds(chapter_id)
info.len=#cfgTaskids
info.taskids={}
local taskids=chapterInfo.taskids or{}
for _,v in ipairs(cfgTaskids)do
taskids[#taskids+1]=v
end
chapterInfo[#chapterInfo+1]=info
end
local _book_id,index=zheXianLingConfig.getChapterIndex(chapter_id)
self:enterNextChapeterByReward(book_id,bookInfo,chapter_id)
systemControl.onZheXianLingChanged(book_id,index)
notifySystem:postNotify(notifyConfig.onZheXianLingChange,book_id,index)
end

function zheXianLingModel:enterCurBookNextChapeter()
local book_id=self.data.book_id
local chapter_id=self.data.chapter_id
local chapterCfg=zheXianLingConfig.getChapterconfig(chapter_id)
local nextid=chapterCfg.nextid
local chapterCfg=nextid and zheXianLingConfig.getChapterconfig(nextid)
local nextBookId=chapterCfg and chapterCfg.book_id
if nextBookId==book_id then
if zheXianLingModel:canOpenChapter(nextid)then
socketManager:send_27_6(nextid)
end
end
end

function zheXianLingModel:enterNextChapeterByReward(book_id,bookInfo,chapter_id)
local chapterCfg=zheXianLingConfig.getChapterconfig(chapter_id)
local nextid=chapterCfg.nextid
local chapterCfg=nextid and zheXianLingConfig.getChapterconfig(nextid)
local nextBookId=chapterCfg and chapterCfg.book_id

self:initRewardedLookup()


self:initFinishedLookup()

if nextBookId==book_id then
if zheXianLingModel:canOpenChapter(nextid)then
socketManager:send_27_6(nextid)
else
UIFullZheXianControl:closeUI()
end
return
end
bookInfo.book_status=ZHE_XIAN_LING_STATUS.eFinish

zheXianLingController:freshTaskWindow('refreshZheXianLing')
zheXianLingController:freshChapterWindow('freshInfo')
zheXianLingController:freshMainWindow('freshAllReddot')
end


function zheXianLingModel:getCurrentRewardBook()
if zheXianLingModel:isRewardCurrentBook()then
return self.data.book_id
end
local lastid,nextid=zheXianLingConfig.getAttachBookId(self.data.book_id)
return lastid
end


function zheXianLingModel:initRewardedLookup()
local book_id=self.data.book_id
self.data.rewardsBookLookup={}
self.data.rewardsChapterLookup={}
if book_id==nil then return end
local rewardsbook=self.data.rewardsBookLookup
local rewardschapter=self.data.rewardsChapterLookup
local bookList=zheXianLingConfig.getBookLine()
for i,v in ipairs(bookList)do
local bookCfg=zheXianLingConfig.getBookconfig(v)
if book_id~=v then
rewardsbook[v]=true
for _,vv in ipairs(bookCfg.chapterids)do
rewardschapter[vv]=true
end
else
if self:isRewardCurrentBook()then
rewardsbook[v]=true
end
local temp={}
local insert=true
local fresh=false
for _,vv in ipairs(bookCfg.chapterids)do
local chapterInfo=self:getChapterInfo(vv)
if chapterInfo and chapterInfo.status==ZHE_XIAN_LING_STATUS.eReward then
rewardschapter[vv]=true
end
if chapterInfo and chapterInfo.status==ZHE_XIAN_LING_STATUS.eDoing then
insert=false
fresh=true
end
if insert then
temp[#temp+1]=vv
end
end
if fresh then
for _,vv in ipairs(temp)do
rewardschapter[vv]=true
end
end
break
end
end
end


function zheXianLingModel:initFinishedLookup()
local book_id=self.data.book_id
self.data.finishedBookLookup={}
self.data.finishedChapterLookup={}
if book_id==nil then return end
local finishedbook=self.data.finishedBookLookup
local finishedchapter=self.data.finishedChapterLookup
local bookList=zheXianLingConfig.getBookLine()
for i,v in ipairs(bookList)do
local bookCfg=zheXianLingConfig.getBookconfig(v)
if book_id~=v then
finishedbook[v]=true
for _,vv in ipairs(bookCfg.chapterids)do
finishedchapter[vv]=true
end
else
if self:isFinishCurrentBook()or self:isRewardCurrentBook()then
finishedbook[v]=true
end

local temp={}
local insert=true
local fresh=false
for _,vv in ipairs(bookCfg.chapterids)do
local chapterInfo=self:getChapterInfo(vv)
if chapterInfo and(chapterInfo.status==ZHE_XIAN_LING_STATUS.eFinish or chapterInfo.status==ZHE_XIAN_LING_STATUS.eReward)then
finishedchapter[vv]=true
end
if chapterInfo and chapterInfo.status==ZHE_XIAN_LING_STATUS.eDoing then
insert=false
fresh=true
end
if insert then
temp[#temp+1]=vv
end
end
if fresh then
for _,vv in ipairs(temp)do
finishedchapter[vv]=true
end
end

break
end
end
end

function zheXianLingModel:initBookTask()
local book_id=self.data.book_id
self.data.bookTaskLookup={}
if book_id==nil then return end
local taskLookup=self.data.bookTaskLookup
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
for i,v in ipairs(bookCfg.chapterids)do
local chapter_id=v
if not self:isRewardChapter(chapter_id)then
local taskids=zheXianLingConfig.getTaskIds(chapter_id)
for i,v in ipairs(taskids)do
taskLookup[v]=true
end
end
end
end



function zheXianLingModel:hasNextBook()
local book_id=self.data.book_id
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
return bookCfg.nextid~=nil
end

function zheXianLingModel:isFinishCurrentBook()
local book_id=self.data.book_id
local bookInfo=self.data.lookup[book_id]
return bookInfo.book_status==ZHE_XIAN_LING_STATUS.eFinish
end

function zheXianLingModel:isRewardCurrentBook()
local book_id=self.data.book_id
local bookInfo=self.data.lookup[book_id]
return bookInfo.book_status==ZHE_XIAN_LING_STATUS.eReward
end

function zheXianLingModel:isFinishCurrentChapter()
local book_id=self.data.book_id
local chapter_id=self.data.chapter_id
local bookInfo=self.data.lookup[book_id]
local isFinish=false
for _,v in pairs(bookInfo.chapterInfo or{})do
if v.chapter_id==chapter_id then
if v.status==ZHE_XIAN_LING_STATUS.eFinish then
isFinish=true
end
break
end
end
return isFinish
end

function zheXianLingModel:isRewardCurrentChapter()
local book_id=self.data.book_id
local chapter_id=self.data.chapter_id
local bookInfo=self.data.lookup[book_id]
local isFinish=false
for _,v in pairs(bookInfo.chapterInfo or{})do
if v.chapter_id==chapter_id then
if v.status==ZHE_XIAN_LING_STATUS.eReward then
isFinish=true
end
break
end
end
return isFinish
end

function zheXianLingModel:isCanCurrentChapterReward()
return zheXianLingModel:isFinishCurrentChapter()
end

function zheXianLingModel:isFinishCurrentChapterAllTask()
local chapter_id=self.data.chapter_id
if chapter_id==nil then return false end
local taskids=zheXianLingConfig.getTaskIds(chapter_id)
for _,taskid in ipairs(taskids)do
local task=taskModel:getTaskInfo(taskid)
if task then
if task and taskModel:getTaskState_transfromstate(task)~=taskModel.taskFinishState then
return false
end
end
end
return true
end

function zheXianLingModel:isAnyTaskCanPrizeByCurrentChapter()
local chapter_id=self.data.chapter_id
local taskids=zheXianLingConfig.getTaskIds(chapter_id)
for _,taskid in ipairs(taskids)do
local task=taskModel:getTaskInfo(taskid)
if task and taskModel:getTaskState_transfromstate(task)==taskModel.taskRewardState then
return true
end
end
return false
end

function zheXianLingModel:isCurrentBookTask(taskid)
return self.data.bookTaskLookup[taskid]==true
end

function zheXianLingModel:getCurShowChapter_id()
if zheXianLingModel:isRewardCurrentChapter()then
local chapter_id=self.data.chapter_id
local chaptercfg=zheXianLingConfig.getChapterconfig(chapter_id)
return chaptercfg.nextid
end
return self:getChapter()
end

function zheXianLingModel:isShowChapterLock()
local chapter_id=self:getCurShowChapter_id()
if chapter_id then
return not self:canOpenChapter(chapter_id)
end
return false
end

function zheXianLingModel:isRewardBook(book_id)
return self.data.rewardsBookLookup[book_id]==true
end

function zheXianLingModel:isFinishedBook(book_id)
return self.data.finishedbook[book_id]==true
end

function zheXianLingModel:isRewardChapter(chapter_id)
return self.data.rewardsChapterLookup[chapter_id]==true
end

function zheXianLingModel:isFinishChapter(chapter_id)
return self.data.finishedChapterLookup[chapter_id]==true
end

function zheXianLingModel:isFinishChapterByIdx(book_id,index)
local chapter_id=zheXianLingConfig.getChapterId(book_id,index)
return self.data.finishedChapterLookup[chapter_id]==true
end

function zheXianLingModel:isAnyChapterCanReward(book_id)
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
for i,v in ipairs(bookCfg.chapterids)do
if not self:isRewardChapter(v)then
return true,v
end
end
return false
end

















function zheXianLingModel:isNextBook(book_id1,book_id2)
return zheXianLingConfig.getBookIndex(book_id1)>zheXianLingConfig.getBookIndex(book_id2)
end

function zheXianLingModel:isFinishAll()
return zheXianLingModel:isRewardCurrentBook()and not zheXianLingModel:hasNextBook()
end


function zheXianLingModel:checkOpen(args)
local typo=args[1]
local val=args[2]
if typo==ZHE_XIAN_LING_CND_TYPE.eZMlv then
return(zongmenModel:getLevel()or 0)>=val
elseif typo==ZHE_XIAN_LING_CND_TYPE.eRewardChapter then
return zheXianLingModel:isRewardBook(val)
end
end

function zheXianLingModel:canOpenBook(book_id)
if not systemModel.isOpen(SYSTEM_DEFINE.eZeXianLing)then return nil end
local bookCfg=zheXianLingConfig.getBookconfig(book_id)
local conditions=bookCfg.conditions
for i,v in ipairs(conditions)do
if not self:checkOpen(v)then
return false,v
end
end
return true
end

function zheXianLingModel:canOpenChapter(chapter_id)
if not systemModel.isOpen(SYSTEM_DEFINE.eZeXianLing)then return false,{0,SYSTEM_DEFINE.eZeXianLing}end
local zm_lv=zheXianLingConfig.getChapterOpenLv(chapter_id)
local lv=playerModel:getActorLevel()or 0
if zm_lv and lv<zm_lv then
return false,{1,zm_lv}
end
return true
end


function zheXianLingModel:getOpenBookCnd(book_id)
local ret,args=zheXianLingModel:canOpenBook(book_id)
if ret~=false then
return''
end
local typo=args[1]
local val=args[2]
if typo==ZHE_XIAN_LING_CND_TYPE.eZMlv then
return FMT.fmt('宗门达到{0}级',val)
elseif typo==ZHE_XIAN_LING_CND_TYPE.eRewardChapter then
local name=zheXianLingConfig.getBookconfig(val).name
return FMT.fmt('必须完成{0}卷',name)
end
end


function zheXianLingModel:getOpenchapterCnd(chapter_id)
local zm_lv=zheXianLingConfig.getChapterOpenLv(chapter_id)
if zm_lv and zm_lv>playerModel:getActorLevel()then
return true,FMT.fmt('宗门{0}级开启新章节',zm_lv)
end
return false,''
end


function zheXianLingModel:getJiYuanTimes()
return moneyModel.getMoney(eMoneyType.mtJiYuan)
end

function zheXianLingModel:hasJiYuanTimes()
return self:getJiYuanTimes()>0
end


function zheXianLingModel:hasJiYuanItems()
return self.data.jiyuanFinish~=true
end

function zheXianLingModel:isPrizeJiYuan(idx)
return mathHelper.getBitValue(self.data.jiyuanFlag,idx-1)
end


function zheXianLingModel:checkNextJiYuanRewards()
local jiyuanid=self.data.jiyuanid
if jiyuanid==nil then return end
local rewards=zheXianLingConfig.getJiYuanConfig(jiyuanid)
local len=#rewards
local num=0
for i=1,len do
num=num+mathHelper.setbit(0,i-1)
end
self.data.jiyuanFinish=false
if self.data.jiyuanFlag==num then
local jiyuanid=self.data.jiyuanid+1
local cfg=zheXianLingConfig.getJiYuanConfig(jiyuanid)
if cfg then
self.data.jiyuanid=jiyuanid
self.data.jiyuanFlag=0
self.data.jiyuanFinish=false
else
self.data.jiyuanFinish=true
end
end
end

function zheXianLingModel:checkEnterNextBook()
if zheXianLingModel:checkEnterFirstBook()then return end
if self.data.book_id==nil then return end
if zheXianLingModel:isRewardCurrentBook()then
zheXianLingModel:enterNextBook()
elseif zheXianLingModel:isRewardCurrentChapter()then
zheXianLingModel:enterCurBookNextChapeter()
end
end

function zheXianLingModel:getData()
return self.data
end

function zheXianLingModel:getChapter()
return self.data.chapter_id
end

function zheXianLingModel:getChapterInfo(chapter_id)
local book_id=self.data.book_id
local bookInfo=self.data.lookup[book_id]
for k,v in pairs(bookInfo.chapterInfo or{})do
if v.chapter_id==chapter_id then
return v
end
end
end

function zheXianLingModel:getJiYuanId()
return self.data.jiyuanid
end

function zheXianLingModel:getJiYuanItemConfig()
local jiyuanid=self.data.jiyuanid
return zheXianLingConfig.getJiYuanConfig(jiyuanid)
end

function zheXianLingModel:getCurrentChapterTaskFinishCount()
local chapter_id=self.data.chapter_id
local taskids=zheXianLingConfig.getTaskIds(chapter_id)
local num=0
local len=#taskids
for _,taskid in ipairs(taskids)do
local task=taskModel:getTaskInfo(taskid)
if task then
if taskModel:getTaskState_transfromstate(task)==taskModel.taskFinishState then
num=num+1
end
else
num=num+1
end
end
return num,len
end

function zheXianLingModel:getCurrentChapterTaskRewardCount()
local chapter_id=self.data.chapter_id
local taskids=zheXianLingConfig.getTaskIds(chapter_id)
local num=0
local len=#taskids
for _,taskid in ipairs(taskids)do
local task=taskModel:getTaskInfo(taskid)
if task and taskModel:getTaskState_transfromstate(task)==taskModel.taskRewardState then
num=num+1
end
end
return num,len
end


function zheXianLingModel:checkFinish(book_id,index)
if index and index>0 then
local chapterid=zheXianLingConfig.getChapterId(book_id,index)
local ret=zheXianLingModel:isRewardChapter(chapterid)
return ret
else
local ret=zheXianLingModel:isRewardBook(book_id)
return ret
end
end