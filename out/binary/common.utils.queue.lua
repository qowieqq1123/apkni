








queue={}
local mt={}
mt.__call=function(self)
local q={array={},head=0,rear=0}
for k,v in pairs(self)do
q[k]=v
end
return q
end

setmetatable(queue,mt)

function queue.New(array,head,rear)
return setmetatable({array=array or{},head=head or 0,rear=rear or 0},{__index=queue})
end

function queue:enqueue(element)
self.rear=self.rear+1
self.array[self.rear]=element
end

function queue:dequeue()
if self:isEmpty()then
return
end
self.head=self.head+1
local value=self.array[self.head]
return value
end



function queue:iterator()
local index=self.head
local iter=function()
index=index+1
if index>self.rear then
return nil
end
return index,self.array[index]
end
return iter
end

function queue:clear()
self.array={}
self.head=0
self.rear=0
end

function queue:isEmpty()
return self:size()==0
end

function queue:size()
return self.rear-self.head
end
